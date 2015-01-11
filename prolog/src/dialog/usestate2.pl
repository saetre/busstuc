/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE usestate2.pl
%% SYSTEM BUSTER
%% CREATED TO-970319
%% REVISED TO-970421  TA-100521

:- module( usestate, [ rule/2 ] ).

%:- ensure_loaded( user:'../declare' ). %% RS-111213 General (semantic) Operators
:- use_module( '../declare', [] ). %% RS-111213 General (semantic) Operators

%:- ensure_loaded('../app/pragma'). %% RS-111213 Pragmatic (rule) Operators
:- use_module( '../app/pragma', [] ). %% RS-140207 Pragmatic (rule) Operators


%% COMMON TELE BUS VERSION 


% Pragma rule for using the state information in the dialogue system
% Source: State (round list)
% Destination: the modified (flatted etc) BUSLOG representation of an input
% statetment.
% Information from the state is added to the BUSLOG  statement.

%tracevalue(L) :- value(traceprog,L).  % Trace level 1-4


askfor rule
is	present frame(Frame)
id	replace askfor([], Slot, Value)
        with    askfor(Frame, Slot, Value)
ip      [].


%% First make sure we don't mess up the special purpose queries:


nocontext rule    %%% Ad Hoc, 
is	[]
id	not nocontext, 
	exactly (today(X), atday(X),atdate2(_,_),flag(exit)), %% TA-090618
	add nocontext
ip	[].


nocontext0 rule 
is	[]
id	not nocontext,
   message(answer(_)), %%%% db_reply(_tuc,_version,_))),
	add nocontext
ip	[].


nocontextmess1 rule
is	[]
id	not nocontext,
   message(underspecified_place(_)),  %% TA-070201
	add nocontext
ip	[].

nocontextmess2 rule
is	[]
id	not nocontext,
   message(place_resolve(_,_)),  %% TA-070201
	add nocontext
ip	[].





nocontextquit rule   %% TA-041219
is	[]
id	not nocontext,
   message(quit(_)), 
	add nocontext
ip	[].


nocontextreply rule   %% TA-041219 ???
is	[]
id	not nocontext,
   reply(_),
	add nocontext
ip	[].



nocontext1 rule
is	[]
id	not nocontext,
	present stationsat(_, _, _),
	add nocontext
ip	[].

nocontext2 rule
is	[]
id	not nocontext,
	present timeis(_),
	add nocontext
ip	[].


/**** %% TA-090828
nocontextm1 rule
is	[]
id	not nocontext,
	present message(date_isa_day(_, _)), %% TA-071214
	add nocontext
ip	[].
*/





nocontextm2 rule
is	[]
id	not nocontext,
	present message(howtuchelp),
	add nocontext
ip	[].




nocontext4 rule
is	[]
id	not nocontext,
	present allstations(_),
	add nocontext
ip	[].

nocontext5 rule
is	[]
id	not nocontext,
	present properstation(_),
	add nocontext
ip	[].

nocontext6 rule
is	[]
id	not nocontext,
	present stationsnear(_, _, _),
	add nocontext
ip	[].

nocontext7 rule
is	[]
id	not nocontext,
	present endstations(_, _), %% TA-080228
	add nocontext
ip	[].

nocontext7b rule 
is	[]
id	not nocontext,
	present findstations(_, _, _),
	add nocontext
ip	[].

nocontext8 rule
is	[]
id	not nocontext,
	present true,
	add nocontext
ip	[].

nocontext8b rule %% TA-030107
is	[]
id	not nocontext,
	present selectroute(_, _, _), %% No more constraints if we know the route
	add nocontext
ip	[].


nocontext9 rule %% TA-041005
is	[]
id	not nocontext,
	present ticketprice2(_,_),   %% TA-041005
	add nocontext
ip	[].




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Use attributes %%  from usestatetele

attrib_givenname rule
is      framevalue(attributes::givenname, Value)
id      remove teleprocess(Fields,Table,Condlist,X),
		add teleprocess(Fields,Table,NewCondlist,X)
ip		\+ member(firstname=_,Condlist),

%%%   \+ member(lastname=_,Condlist), %% dont use firstname from earlier if lastname is given
                                     
		\+ Value=dontknow,
		\+ Value=doknow,
  		append(Condlist, [firstname=Value], NewCondlist).

attrib_lastname rule
is      framevalue(attributes::sn, Value)
id      remove teleprocess(Fields,Table,Condlist,X),
		add teleprocess(Fields,Table,NewCondlist,X)
ip		\+ member(lastname=_,Condlist),
		\+ Value=dontknow,
		\+ Value=doknow,
  		append(Condlist, [lastname=Value], NewCondlist).

attrib_pname rule
is      framevalue(attributes::cn, Value)
id      remove teleprocess(Fields,Table,Condlist,X),
		add teleprocess(Fields,Table,NewCondlist,X)
ip		\+ member(pname=_,Condlist),
		\+ Value=dontknow,
		\+ Value=doknow,
  		append(Condlist, [pname=Value], NewCondlist).

attrib_title rule
is      framevalue(attributes::title, Value)
id      remove teleprocess(Fields,Table,Condlist,X),
		add teleprocess(Fields,Table,NewCondlist,X)
ip		\+ member(title=_,Condlist),
		\+ Value=dontknow,
		\+ Value=doknow,
  		append(Condlist, [title=Value], NewCondlist).


attrib_telephonenumberX  rule %% TA-040526
is      framevalue(attributes::telephonenumber, Value)
id      remove teleprocess(Fields,Table,Condlist,X),
		add teleprocess(Fields,Table,NewCondlist,X)
ip	   member(tel=_,Condlist),
      \+ member(telephonenumber=_,Condlist),
		\+ Value=dontknow,
		\+ Value=doknow,
  		append(Condlist, [telephonenumber=Value], NewCondlist).


attrib_roomnumber rule
is      framevalue(attributes::roomnumber, Value)
id      remove teleprocess(Fields,Table,Condlist,X),
		add teleprocess(Fields,Table,NewCondlist,X)
ip		\+ member(roomnumber=_,Condlist),
		\+ Value=dontknow,
		\+ Value=doknow,
  		append(Condlist, [roomnumber=Value], NewCondlist).

attrib_mail rule
is      framevalue(attributes::mail, Value)
id      remove teleprocess(Fields,Table,Condlist,X),
		add teleprocess(Fields,Table,NewCondlist,X)
ip		\+ member(mail=_,Condlist),
		\+ Value=dontknow,
		\+ Value=doknow,
  		append(Condlist, [mail=Value], NewCondlist).


attrib_department rule
is      framevalue(attributes::department, Value)
id      remove teleprocess(Fields,Table,Condlist,X),
		add teleprocess(Fields,Table,NewCondlist,X)
ip		\+ member(department=_,Condlist),
		\+ Value=dontknow,
		\+ Value=doknow,
  		append(Condlist, [department=Value], NewCondlist).




%%%%%%% Hvor ønsker du å reise : Dravoll => TO Dragvoll


%% add atday 

addframeday rule 
is   framevalue(day,X)
id   not atday(_),
     add atday(X)
ip   [].

adddaytoday rule 
is   not framevalue(day,X)
id   today(X),
     not atday(_),
     add atday(X)
ip   [].




depplace rule  
is     framevalue(where::departure, Place)
id     not nocontext, 
       not depset(from, _),
       not departure(_, _, _, _),         %% Not to and from same place
       add depset(from, [A]),    %% , B]), %% TA-030831

       atday(Day), 
       atdate2(DaySeq,_Date),             %% TA-090828

       add departure(Bus, Stat, DaySeq, A),
       add passevent(A, Bus, Stat, [from], Day, nil) %% TA-030831
ip     place_station(Place,Stat). 


%% Hvor ønsker du å reise
depplacebusto rule  %% TA-030514  Already Got a Bus, Mix IN 
is     framevalue(where::departure, Place)
id     not nocontext, 
       not depset(to, _),
       atday(Day), 
       atdate2(DaySeq,_Date),            %% TA-090828

       replace departure(Bus, Stat1, _,A)  
       with    departure(Bus, Place, DaySeq, A),

       replace  passevent(A, Bus, Stat2, FS, _Day2, _XB)
       with    passevent(A, Bus, Place, [to|FS], Day, nil), %% TA-030831

       replaceif  depset(unknown,Z)   %% NEW OPERATOR
       with    depset(to,Z)  %% ,B])  %% TA-030831
 
 ip    bound(Bus), unbound(Stat1),unbound(Stat2).



depplacebusfrom rule  %% TA-030514  Already Got a Bus, Mix IN
is     framevalue(where::departure, Place)
id     not nocontext, 
       not depset(from, _),

       atday(Day), 
       atdate2(DaySeq,_Date),           

       replace departure(Bus, Stat1, _Day1,A)  
       with    departure(Bus, Place, DaySeq, A),

       replace  passevent(A, Bus, Stat2, FS, _Day2, _XB)
       with passevent(A, Bus, Place, [from|FS], Day, nil), %% TA-030831

       replaceif depset(unknown,Z) %% New OPERATOR
       with    depset(from,Z)  %% TA-030831 B]) 
 
 ip    bound(Bus), unbound(Stat1),unbound(Stat2).


depplacepanic rule  %% TA-030913
is     framevalue(where::departure, Place)
id     not nocontext, 
       not depset(from, _),
       depset(unknown,TOTO),
       present departure(_, OtherStat, _, _),     

       remove  keepat(_Time,D1,D2),

       replace passevent(D2, BBus, BStat, Bopts, BDay, BNIL) with
               passevent(D1, BBus, BStat, Bopts, BDay, BNIL),

       replace depset(unknown,TOTO) with depset(to,TOTO), 

       add depset(from, [A]),    %% , B]), %% TA-030831
       atday(Day),   
       atdate2(DaySeq,_Date),   %% TA-090828

       add departure(Bus, Stat, DaySeq, A),
       add passevent(A, Bus, Stat, [from], Day, nil)

ip     place_station(Place,Stat), OtherStat \== Stat. 


arrplacepanic rule  %% TA-030913
is     framevalue(where::arrival, Place)
id     not nocontext, 
       not depset(to, _),
       present departure(_, OtherStat, _, _),     

       remove  keepat(_Time,D1,D2),

       replace passevent(D2, BBus, BStat, Bopts, BDay, BNIL) with
               passevent(D1, BBus, BStat, Bopts, BDay, BNIL),

       replace depset(unknown,TOTO) with depset(from,TOTO),  % <--

       add depset(to, [A]),    %% , B]), %% TA-030831

       atday(Day),   
       atdate2(DaySeq,_Date),   %% TA-090828

       add departure(Bus, Stat, DaySeq, A),
       add passevent(A, Bus, Stat, [to], Day, nil)

ip     place_station(Place,Stat), OtherStat \== Stat. 

  

depplace2 rule  
is     framevalue(where::departure, Place)
id     not present departure(_,Place,_62213,_63879), % panic %% TA-030913
       not nocontext, 
       not depset(from, _),
       present departure(_, OtherStat, _, _),         %% Not to and from same place

       add depset(from, [A]),    %% , B]), %% TA-030831
       atday(Day),            %%% TA-030409
       atdate2(DaySeq,_Date), 
       add departure(Bus, Stat, DaySeq, A), %% TA-090828
       add passevent(A, Bus, Stat, [from], Day, nil)

ip     place_station(Place,Stat), OtherStat \== Stat. 



depbus rule  
is     framevalue(bus, Bus)
id     not nocontext, 
       present depset(from, List),
       replace departure(OldBus, Place, DaySeq, A) 
       with departure(Bus, Place, DaySeq, A)
ip     varmember(A, List), unbound(OldBus).


% % %

depbefore_dep rule  
is     framevalue((when)::departure::before, Time)
id     not nocontext, 
       not keepbefore1(_, _, _),
       not keepbefore(_, _, _),

       replace depset(from, Rest)
       with depset(from, [B | Rest]),

       replace departure(Bus, Place, DaySeq, A)
       with (departure(Bus, Place, DaySeq, B), 
             keepbefore(Time, B, A)),

       replace passevent(TA1,TA2,TA3, [to],           TA5,TA6)  %% TA-030407
       with    passevent(TA1,TA2,TA3, [lastcorr,to]  ,TA5,TA6)  %% rough



ip     varmember(A, Rest).


depbefore_pass rule  
is     framevalue((when)::departure::before, Time)
id     not nocontext, 

       not keepbefore(_, _, _),
       not keepbefore1(_, _, _),

       replace passevent(B,TA2,TA3, [from], TA5,TA6)  %% TA-030408
  
       with ( keepbefore(Time, B,C),  %%%% if 2500 (last bus) ==> relax
              passevent(C,TA2,TA3, [last(1),time,from]  ,TA5,TA6))  %% rough


ip     [].


depafter_dep rule  
is     framevalue((when)::departure::after, Time)
id     not nocontext, 
       not keepafter(_, _, _),
       replace depset(from, Rest)
       with depset(from, [B | Rest]),

       replace departure(Bus, Place, Day, A)
       with (departure(Bus, Place, Day, B), keepafter(Time, B, A)),
       replace connections(TA1,TA2,TA3,TA4,TA5,TA6,DaySeqNo,Opts, TA8,TA9)  %% TA-030407
       with    connections(TA1,TA2,TA3,TA4,TA5,TA6,DaySeqNo,Opts2,TA8,TA9)

ip     varmember(A, Rest),
       deleteall(lastcorr,Opts,Opts1),      %% TA-030820
       setopt(nextaftertime(1),Opts1,Opts2). %%

depafter_pass rule  
is     framevalue((when)::departure::after, Time)
id     not nocontext, 
       not keepafter(_, _, _),
       replace passevent(B,TA2,TA3, [from], TA5,TA6)  %% TA-030409
        with ( keepafter(Time, B,C), 
              passevent(C,TA2,TA3, [time,from,nextaftertime(1)]  ,TA5,TA6))  %% rough

ip     [].

% % % % % % % % % %


arrplace rule  
is     framevalue(where::arrival, Place)
id     not nocontext, 
       not depset(to, _),
       not departure(_, _, _, _),         
       add depset(to, [A]),  %% TA-030831  B]),
  atday(Day),            %%% TA-030409
       add departure(Bus, Stat, Day, A),
       add passevent(A, Bus, Stat, [to], Day, nil)
ip     place_station(Place,Stat).

arrplace2 rule  
is     framevalue(where::arrival, Place)
id     not present departure(_,Place,_62213,_63879), % panic %% TA-030913
       not nocontext, 
       not depset(to, _),
       present departure(_, OtherStat, _, _),         
       add depset(to, [A]), %% , B]),
       atday(Day),           
       atdate2(DaySeq,_Date),             %% TA-090828
       add departure(Bus, Stat, DaySeq, A),
       add passevent(A, Bus, Stat, [to], Day,nil) %%  B)
ip     place_station(Place,Stat), OtherStat \== Stat.



whendeparturebus rule  
is     framevalue(arrival::bus, Bus)
id     not nocontext, 
       present depset(to, List),
       replace departure(OldBus, Place, DaySeq, A) 
       with departure(Bus, Place, DaySeq, A)
ip     varmember(A, List), unbound(OldBus).



usedepbus rule   %% TA-041007
is     framevalue(bus, Bus)  %% bus on outer level 
id     not nocontext, 
       present depset(from, List),
       replace departure(OldBus, Place, DaySeq, A) 
       with departure(Bus, Place, DaySeq, A)
ip     varmember(A, List), unbound(OldBus).



arrbus rule  
is     framevalue(arrival::bus, Bus)
id     not nocontext, 
       present depset(to, List),
       replace departure(OldBus, Place, DaySeq, A) 
       with departure(Bus, Place, DaySeq, A)
ip     varmember(A, List), unbound(OldBus).




arrbefore0 rule %%  no passevent -> connection
is     framevalue((when)::arrival::before, Time)
id     not passevent(_,_,_,_,_,_), 
       not nocontext, 
       not keepafter(_, _, _),
       not keepbefore(_, _, _),  
       not keepbefore1(_, _, _),
       replace depset(to, Rest)
       with depset(to, [B | Rest]),
       replace departure(Bus, Place, DaySeq, A)
       with (departure(Bus, Place, DaySeq, B), 
             keepbefore1(Time, B, A)),  

       replace connections(X1,X2,X3,X4,X5,X6,DaySeqNo,Opts1,X8,X9) 
       with    connections(X1,X2,X3,X4,X5,X6,DaySeqNo,[lastcorr|Opts1],X8,X9) 

ip     varmember(A, Rest).



arrbefore1 rule  %% only before time %% TA-041212
is     framevalue((when)::arrival::before, Time)
id     not nocontext, 
       replace depset(to, [Head | Rest])
       with depset(to, [B | [Head | Rest]]),
       replace passevent(Head,TA2,TA3, [to], TA5,TA6) 
       with ( keepbefore1(Time, Head, B), 
              passevent(B,TA2,TA3, [lastcorr,time,to]  ,TA5,TA6))  
ip     [].


arrbefore rule  
is     framevalue((when)::arrival::before, Time),
       not framevalue(day,_) %% Another day is set
                      %% Dont use arrival time !!!

id     not nocontext, 
       replace depset(to, [Head | Rest])
       with depset(to, [B | [Head | Rest]]),
       not keepbefore(_, _, _),                     % up TA-030110
       not keepbefore1(_, _, _),
 
      replace passevent(Head,TA2,TA3, [to], TA5,TA6)  %% TA-030408
  
      with ( keepbefore1(Time, Head, B), 
             passevent(B,TA2,TA3, [time,to]  ,TA5,TA6))  
                                  %% rough DROP lastcorr %% TA-041007
                                  %% first  before 1600 | after 1300

ip     [].

arrafter1 rule  
is     framevalue((when)::arrival::after, Time)
id     not nocontext, 
       not keepafter(_, _, _),
       replace depset(to, Rest)
       with depset(to, [B | Rest]),

       replace passevent(P1,P2,P3,P4,P5,P6) with %% Ad Hoc %% TA-031109
               passevent(P1,P2,P3,[nextaftertime(1)|P4],P5,P6), 

       replace departure(Bus, Place, DaySeq, A)
       with (departure(Bus, Place, DaySeq, B), keepafter(Time, B, A))
ip     varmember(A, Rest).

arrafter rule  
is     framevalue((when)::arrival::after, Time)
id     not nocontext, 
       replace depset(to, [Head | Rest])
       with depset(to, [B | [Head | Rest]]),
       not keepafter(_, _, _),
       add keepafter(Time, Head, B)
ip     [].

%% Modifier rules, allowed to overwrite existing information

moddepplace1 rule  
is     present modify,
       context framevalue(where::departure, Place)
id     not nocontext, 
       replace connections(A1, A2, A3, OldPlace, A5, A6,DaySeqNo, A7, A8, A9) 
       with connections(A1, A2, A3, Place, A5, A6,DaySeqNo, A7, A8, A9) 
ip     OldPlace \== Place.

moddepplace rule  
is     present modify,
       framevalue(where::departure, Place)
id     not nocontext, 
       present depset(from, List),
       replace departure(Bus, OldPlace, DaySeq, A) 
       with departure(Bus, Place, DaySeq, A)
ip     varmember(A, List), OldPlace \== Place.

moddepbus rule  
is     present modify,
       framevalue(bus, Bus)
id     not nocontext, 
       present depset(from, List),
       replace departure(OldBus, Place, DaySeq, A) 
       with departure(Bus, Place, DaySeq, A)
ip     varmember(A, List), OldBus \== Bus.

moddepbefore rule  
is     present modify,
       framevalue((when)::departure::before, Time)
id     not nocontext, 
       present depset(from, List),
       replace keepbefore(OldTime, A, B) 
       with keepbefore(Time, A, B)          %% TA-030122 was keepbefore1  
ip     varmember(A, List), OldTime \== Time.

moddepbefore1 rule  
is     present modify,
       framevalue((when)::departure::before, Time)
id     not nocontext, 
       present depset(from, List),
       replace keepbefore1(OldTime, A, B) 
       with keepbefore1(Time, A, B)            %% OK 
ip     varmember(A, List), OldTime \== Time.

moddepafter rule  
is     present modify,
       framevalue((when)::departure::after, Time)
id     not nocontext, 
       present depset(from, List),
       replace keepafter(OldTime, A, B) 
       with keepafter(Time, A, B)            
ip     varmember(A, List), OldTime \== Time.

modarrplace1 rule  
is     present modify,
       context framevalue(where::arrival, Place)
id     not nocontext, 
       replace connections(A1, A2, A3, A4, OldPlace, A6, DaySeqNo,A7, A8, A9) 
       with connections(A1, A2, A3, A4, Place, A6,DaySeqNo, A7, A8, A9) 
ip     OldPlace \== Place.

modarrplace rule  
is     present modify,
       framevalue(where::arrival, Place)
id     not nocontext, 
       present depset(to, List),
       replace departure(Bus, OldPlace, DaySeq, A) 
       with departure(Bus, Place, DaySeq, A)
ip     varmember(A, List), OldPlace \== Place.

modarrbus rule  
is     present modify,
       framevalue(arrival::bus, Bus)
id     not nocontext, 
       present depset(to, List),
       replace departure(OldBus, Place, DaySeq, A) 
       with departure(Bus, Place, DaySeq, A)
ip     varmember(A, List), OldBus \== Bus.

modarrbefore rule  
is     present modify,
       framevalue((when)::arrival::before, Time)
id     not nocontext, 
       present depset(to, List),
       replace keepbefore(OldTime, A, B) 
       with keepbefore(Time, A, B)          %% TA-030122 was keepbefore1  
ip     varmember(A, List), OldTime \== Time.

modarrbefore rule  
is     present modify,
       framevalue((when)::arrival::before, Time)
id     not nocontext, 
       present depset(to, List),
       replace keepbefore1(OldTime, A, B) 
       with keepbefore1(Time, A, B)            %% OK
ip     varmember(A, List), OldTime \== Time.

modarrafter rule  
is     present modify,
       framevalue((when)::arrival::after, Time)
id     not nocontext, 
       present depset(to, List),
       replace keepafter(OldTime, A, B) 
       with keepafter(Time, A, B)            
ip     varmember(A, List), OldTime \== Time.


resolveunknownfrom rule %% TA-031109
is   []
id  depset(to,_Set2),
    replace depset(unknown,Set1) with 
            depset(from,Set1),
    replace passevent(P1,P2,P3,P4,P5,P6) with
            passevent(P1,P2,P3,[from|P4],P5,P6)
ip  [].
    

makeconnection rule
is  []
id  remove passevent(Depset1,_,Place1,Opts1,Day,_),
    remove passevent(Depset2,Bus2,Place2,Opts2,Day,_),
    atdate2(DaySeqNo,_Date_), %% TA-100521
    add (connections(Depset1,Depset2,Bus2,Station1,Station2,Day,DaySeqNo,OptsUnite,_,_))

ip  (member(from,Opts1)   %%    Which buses pass A and B
      ; member(to,Opts2)),  %% Essential for correct direction
    not(member(nocouple,Opts1)),
    not(member(nocouple,Opts2)),
    mixopt(Opts1,Opts2,OptsUnite),
    place_station(Place1,Station1),
    place_station(Place2,Station2),

   Station1 \== Station2. %% TA-030126 <---------

modatday1 rule
is     present modify,
       framevalue(day, Day)   %% (when)::day
id     replace (X=_, atday(X))
       with (X=Day, atday(X))
ip     [].

    

usestate_fledsboprice rule
is      []
id      remove connections(_,_,_,From,To,_,_,_,_),
        replace ticketprice(_,_)   %% TA-041005
        with findprice(From, To, _, _)
ip      [].

usestate_fledsboprice2 rule 
is      []
id      present ticketprice(_,_),
        remove passevent(_, _, _, _, _, _)
ip      [].

%%%%%%%%%%%% THE END %%%%%%%%%%%%%%%%%
