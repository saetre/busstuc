% Auxillary tables created datetime(2012,3,7,15,52,9)

%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

:- :-prolog_flag(discontiguous_warnings,_,off).

sentence([gpsflag:::_15877|_15874],[sentence,{},_15938,!,_15972],_15914,_15916) --> 
    {user:value(gpsflag,true)},
    origin_phrase(_15877,_15938,_15914,_15955),
    !,
    sentences(_15874,_15972,_15955,_15916).

sentence(_15872,[sentence,{},_15927],_15903,_15905) --> 
    {user:(\+value(gpsflag,true))},
    sentences(_15872,_15927,_15903,_15905).

origin_phrase([_15873|_15874],[origin_phrase,lit('('),!,_15946,{},_15985],_15916,_15918) --> 
    cc('(',_15916,_15940),
    !,
    origin_element(_15873,_15946,_15940,_15963),
    {user:set(new_origin,true)},
    origin_phrase0n(_15874,_15985,_15963,_15918).

origin_phrase([],[origin_phrase,[]],_15891,_15891) --> 
    [].

origin_phrase0n([_15873|_15874],[origin_phrase0n,_15917,!,_15951],_15903,_15905) --> 
    origin_element(_15873,_15917,_15903,_15934),
    !,
    origin_phrase0n(_15874,_15951,_15934,_15905).

origin_phrase0n([],[origin_phrase0n,lit(')')],_15893,_15895) --> 
    cc(')',_15893,_15895).

origin_element(gps_origin(_15874,_15875),[origin_element,_15920,lit(+),_15960],_15906,_15908) --> 
    gps_origin(_15874,_15920,_15906,_15937),
    cc(+,_15937,_15959),
    gps_time(_15875,_15960,_15959,_15908).

gps_origin(_15872,[gps_origin,_15915,!],_15901,_15903) --> 
    name_phrase(name,_15872:_15882,_15879,_15915,_15901,_15903),
    !.

gps_time(_15872,[gps_time,_15910],_15896,_15898) --> 
    w(nb(_15872,num),_15910,_15896,_15898).

sentence01(_15872,[sentence01,_15907],_15893,_15895) --> 
    implicitq(_15872,_15907,_15893,_15895).

sentence01(_15872,[sentence01,_15907],_15893,_15895) --> 
    sentence1(_15872,_15907,_15893,_15895).

sentences([new:::_15877],[sentences,{},_15942,_15971,!,_16000],_15918,_15920) --> 
    {user:value(queryflag,false)},
    declaration(_15877,_15942,_15918,_15959),
    terminatore(_15971,_15959,_15986),
    !,
    accept(_16000,_15986,_15920).

sentences([_15873],[sentences,{},_15947,_15971,_16000,_16044,!,_16073],_15923,_15925) --> 
    {user:value(queryflag,true)},
    greetings0(_15947,_15923,_15962),
    implicitq(_15873,_15971,_15962,_15988),
    optional(itrailer,_16000,_15988,_16032),
    terminatores(_16044,_16032,_16059),
    !,
    accept(_16073,_16059,_15925).

sentences(_15872,[sentences,_15924,{},_15963,_15987],_15910,_15912) --> 
    onesentence(_15883,_15924,_15910,_15941),
    {user:_15883\==error},
    check_stop(_15963,_15941,_15978),
    moresentences0(_15883,_15872,_15987,_15978,_15912).

moresentences0(_15872,_15873,[moresentences0,_15929,_15958,!,_15987,_16011],_15912,_15914) --> 
    onesentence(_15888,_15929,_15912,_15946),
    check_stop(_15958,_15946,_15973),
    !,
    accept(_15987,_15973,_16002),
    evenmore0(_15872,_15888,_15873,_16011,_16002,_15914).

evenmore0(_15872,error,[_15872,error],[evenmore0,!,_15929],_15904,_15906) --> 
    !,
    skip_rest(_15929,_15904,_15906).

evenmore0(_15872,[],[_15872],[evenmore0,[],!],_15902,_15902) --> 
    [],
    !.

evenmore0(_15872,_15873,[_15872|_15876],[evenmore0,_15922],_15902,_15904) --> 
    moresentences0(_15873,_15876,_15922,_15902,_15904).

onesentence([],[onesentence,_15911,!,_15940],_15897,_15899) --> 
    endofline(_15911,_15897,_15926),
    !,
    accept(_15940,_15926,_15899).

onesentence(_15872,[onesentence,_15916,_15945,!,_15974],_15902,_15904) --> 
    conf_statement(_15872,_15916,_15902,_15933),
    endofline(_15945,_15933,_15960),
    !,
    accept(_15974,_15960,_15904).

onesentence(_15872,[onesentence,_15916,_15940,_15969,_15993],_15902,_15904) --> 
    grums0(_15916,_15902,_15931),
    sentence1(_15872,_15940,_15931,_15957),
    sentence_delimiter(_15969,_15957,_15984),
    accept(_15993,_15984,_15904).

onesentence(error,[onesentence,_15905],_15891,_15893) --> 
    skip_rest(_15905,_15891,_15893).

notify([notify,_15904],_15893,_15895) --> 
    w(verb(notify,_15875,_15876),_15904,_15893,_15895).

notify([notify,_15905],_15894,_15896) --> 
    w(noun(notification,_15875,_15876,_15877),_15905,_15894,_15896).

conf_statement(confirm:::_15875,[conf_statement,_15910],_15896,_15898) --> 
    confirm(_15875,_15910,_15896,_15898).

confirm(false,[confirm,lit(jeg),_15935,lit(ikke),_15975],_15910,_15912) --> 
    cc(jeg,_15910,_15934),
    w(verb(know,pres,fin),_15935,_15934,_15952),
    cc(ikke,_15952,_15974),
    endofline(_15975,_15974,_15912).

confirm(true,[confirm,lit(ja),_15921],_15896,_15898) --> 
    cc(ja,_15896,_15920),
    of_course0(_15921,_15920,_15898).

confirm(true,[confirm,lit(jo),_15921],_15896,_15898) --> 
    cc(jo,_15896,_15920),
    of_course0(_15921,_15920,_15898).

confirm(false,[confirm,lit(nei),_15921],_15896,_15898) --> 
    cc(nei,_15896,_15920),
    of_coursenot0(_15921,_15920,_15898).

confirm(true,[confirm,_15905],_15891,_15893) --> 
    of_course(_15905,_15891,_15893).

confirm(false,[confirm,_15910,lit(ikke)],_15896,_15898) --> 
    of_course(_15910,_15896,_15925),
    cc(ikke,_15925,_15898).

sentence_delimiter([sentence_delimiter,lit(for),_15918],_15896,_15898) --> 
    cc(for,_15896,_15917),
    look_ahead([hvis],_15918,_15917,_15898).

sentence_delimiter([sentence_delimiter,lit(;)],_15889,_15891) --> 
    cc(;,_15889,_15891).

sentence_delimiter([sentence_delimiter,_15898],_15887,_15889) --> 
    terminatore(_15898,_15887,_15889).

terminatore0([terminatore0,_15904,!,_15933],_15893,_15895) --> 
    terminatore(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

terminatore0([terminatore0,[]],_15887,_15887) --> 
    [].

terminatores([terminatores,_15904,!,_15933],_15893,_15895) --> 
    terminator(_15904,_15893,_15919),
    !,
    terminatores(_15933,_15919,_15895).

terminatores([terminatores,_15907,_15931,!,_15960],_15896,_15898) --> 
    check_stop(_15907,_15896,_15922),
    endofline(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

terminatore([terminatore,_15898],_15887,_15889) --> 
    terminator1(_15898,_15887,_15889).

terminator1([terminator1,_15947,_15971,_16000,_16029,_16058,!,_16092],_15936,_15938) --> 
    terminator(_15947,_15936,_15962),
    not_look_ahead(w(nb(_15894,num)),_15971,_15962,_15988),
    not_look_ahead(w(name(_15901,_15902,month)),_16000,_15988,_16017),
    not_look_ahead(w(name(_15901,_15910,day)),_16029,_16017,_16046),
    not_look_ahead(w(name(_15901,_15918,date)),_16058,_16046,_16075),
    !,
    accept(_16092,_16075,_15938).

terminator1([terminator1,_15907,_15931,!,_15960],_15896,_15898) --> 
    check_stop_locations(_15907,_15896,_15922),
    endofline(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

look_ahead_endofline([look_ahead_endofline,_15909,!],_15898,_15900) --> 
    look_ahead_lit(['.',?,!],_15909,_15898,_15900),
    !.

look_ahead_endofline([look_ahead_endofline,_15898],_15887,_15889) --> 
    end_of_line(_15898,_15887,_15889).

endofline0([endofline0,_15904,!,_15933],_15893,_15895) --> 
    terminator(_15904,_15893,_15919),
    !,
    endofline0(_15933,_15919,_15895).

endofline0([endofline0,_15898],_15887,_15889) --> 
    end_of_line0(_15898,_15887,_15889).

endofline([endofline,_15907,_15931,!,_15960],_15896,_15898) --> 
    terminator(_15907,_15896,_15922),
    endofline(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

endofline([endofline,lit(:),_15917,!],_15895,_15897) --> 
    cc(:,_15895,_15916),
    end_of_line(_15917,_15916,_15897),
    !.

endofline([endofline,lit(+),{},_15938,!,_15967],_15906,_15908) --> 
    cc(+,_15906,_15927),
    {user:value(busflag,true)},
    endofline(_15938,_15927,_15953),
    !,
    accept(_15967,_15953,_15908).

endofline([endofline,_15898],_15887,_15889) --> 
    end_of_line(_15898,_15887,_15889).

endofline1([endofline1,lit('.')],_15889,_15891) --> 
    cc('.',_15889,_15891).

endofline1([endofline1,lit(?)],_15889,_15891) --> 
    cc(?,_15889,_15891).

endofline1([endofline1,lit(!)],_15889,_15891) --> 
    cc(!,_15889,_15891).

check_stop_locations([check_stop_locations,_15901,!],_15890,_15892) --> 
    check_stop(_15901,_15890,_15892),
    !.

assemble_stop_locations([_15876+_15877|_15874],[assemble_stop_locations,_15937,lit(+),_15977,!,_16011],_15923,_15925) --> 
    w(name(_15876,n,_15897),_15937,_15923,_15954),
    cc(+,_15954,_15976),
    w(nb(_15877,num),_15977,_15976,_15994),
    !,
    check_stop_locations(_15874,_16011,_15994,_15925).

assemble_stop_locations([],[assemble_stop_locations,_15905],_15891,_15893) --> 
    end_of_line(_15905,_15891,_15893).

sentence1(new:::_15875,[sentence1,_15958,_15982,lit(at),!,_16027,_16061],_15944,_15946) --> 
    hellos0(_15958,_15944,_15973),
    w(adj2(_15903,_15904),_15982,_15973,_15999),
    cc(at,_15999,_16021),
    !,
    clausal_object1(_15913,_15914,_16027,_16021,_16046),
    pushstack(first,(xnp(_15913,_15914),w(verb(be,pres,fin)),w(adj2(_15903,_15904))),nil,_16046,_16104),
    statreal(_15875,_16061,_16104,_15946).

sentence1(new:::_15875,[sentence1,_15933,_15957,!,_16005],_15919,_15921) --> 
    detaa(_15933,_15919,_15948),
    pushstack(first,[noen],nil,_15948,_15970),clausal_object1(_15889,_15890,_15957,_15970,_15985),
    !,
    pushstack(first,xnp(_15889,_15890),nil,_15985,_16046),
    statreal(_15875,_16005,_16046,_15921).

detaa([detaa,lit(det),lit(å)],_15894,_15896) --> 
    cc(det,_15894,_15915),
    cc(å,_15915,_15896).

detaa([detaa,lit(å)],_15889,_15891) --> 
    cc(å,_15889,_15891).

sentence1(new:::_15875,[sentence1,_15928,_15952,!,_15991],_15914,_15916) --> 
    hvorvidt(_15928,_15914,_15943),
    clausal_object1(_15889,_15890,_15952,_15943,_15971),
    !,
    pushstack(first,xnp(_15889,_15890),nil,_15971,_16032),
    statreal(_15875,_15991,_16032,_15916).

hvorvidt([hvorvidt,lit(hvorvidt)],_15889,_15891) --> 
    cc(hvorvidt,_15889,_15891).

hvorvidt([hvorvidt,lit(det),lit(at)],_15894,_15896) --> 
    cc(det,_15894,_15915),
    cc(at,_15915,_15896).

hvorvidt([hvorvidt,lit(at)],_15889,_15891) --> 
    cc(at,_15889,_15891).

sentence1(new:::_15875,[sentence1,_15921,_15945,!,_15979],_15907,_15909) --> 
    redundant(_15921,_15907,_15936),
    be_it_tf_that(_15888,_15945,_15936,_15962),
    !,
    statreal(_15875,_15979,_15962,_15909).

sentence1(new:::_15875,[sentence1,_15940,_15969,_15998],_15926,_15928) --> 
    w(verb(be,_15898,fin),_15940,_15926,_15957),
    look_ahead_lit([mye],_15969,_15957,_15986),
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_15986,_16008),
    statement(_15875,_15998,_16008,_15928).

sentence1(new:::_15875,[sentence1,_15954,_15983,lit(som),!,_16023],_15940,_15942) --> 
    w(verb(_15905,_15906,pass),_15954,_15940,_15971),
    redundant0(_15983,_15971,_15998),
    cc(som,_15998,_16017),
    !,
    pushstack(first,([noen],w(verb(_15905,_15906,fin)),[dette],[som]),nil,_16017,_16033),
    statreal(_15875,_16023,_16033,_15942).

sentence1(new:::_15875,[sentence1,_15948,_15992,_16021,_16050],_15934,_15936) --> 
    optional([kanskje],_15948,_15934,_15980),
    negation(_15895,_15992,_15980,_16009),
    not_look_ahead([alle],_16021,_16009,_16038),
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_15895)),nil,_16038,_16093),
    statreal(_15875,_16050,_16093,_15936).

sentence1(new:::_15875,[sentence1,_16036,_16065,_16094,_16123,_16157,_16186,lit(å),_16226,!,_16260],_16022,_16024) --> 
    one_of_lit([den,det,dette,disse,slike],_16036,_16022,_16053),
    w(noun(_15927,_15928,_15929,n),_16065,_16053,_16082),
    w(verb(be,_15954,fin),_16094,_16082,_16111),
    subject(_15957,_15958,_16123,_16111,_16142),
    w(adj2(_15962,nil),_16157,_16142,_16174),
    w(prep(_15967),_16186,_16174,_16203),
    cc(å,_16203,_16225),
    w(verb(_15973,inf,fin),_16226,_16225,_16243),
    !,
    pushstack(first,(xnp(_15957,_15958),w(verb(be,_15954,fin)),w(adj2(_15962,nil)),w(prep(_15967)),[å],w(verb(_15973,inf,fin)),w(noun(_15927,_15928,_15929,n))),nil,_16243,_16301),
    statreal(_15875,_16260,_16301,_16024).

sentence1(new:::_15875,[sentence1,_16008,_16037,_16066,_16095,_16129,_16158,!,_16192],_15994,_15996) --> 
    one_of_lit([den,det,dette,disse,slike],_16008,_15994,_16025),
    w(noun(_15915,_15916,_15917,n),_16037,_16025,_16054),
    w(verb(be,_15942,fin),_16066,_16054,_16083),
    subject(_15945,_15946,_16095,_16083,_16114),
    w(adj2(_15950,nil),_16129,_16114,_16146),
    w(prep(_15955),_16158,_16146,_16175),
    !,
    pushstack(free,(xnp(_15945,_15946),w(verb(be,_15942,fin)),w(adj2(_15950,nil)),w(prep(_15955)),w(noun(_15915,_15916,_15917,n))),nil,_16175,_16233),
    statreal(_15875,_16192,_16233,_15996).

sentence1(new:::_15875,[sentence1,_16012,_16041,_16070,_16099,_16133,_16162,!,_16196],_15998,_16000) --> 
    one_of_lit([den,det,dette,disse,slike],_16012,_15998,_16029),
    w(noun(_15915,_15916,_15917,n),_16041,_16029,_16058),
    w(verb(_15941,_15942,fin),_16070,_16058,_16087),
    subject(_15945,_15946,_16099,_16087,_16118),
    w(noun(_15950,sin,u,n),_16133,_16118,_16150),
    w(prep(_15957),_16162,_16150,_16179),
    !,
    pushstack(first,(xnp(_15945,_15946),w(verb(_15941,_15942,fin)),w(noun(_15950,sin,u,n)),w(prep(_15957)),w(noun(_15915,_15916,_15917,n))),nil,_16179,_16237),
    statreal(_15875,_16196,_16237,_16000).

sentence1(new:::_15875,[sentence1,_15992,_16021,_16050,{},_16089,!,_16128],_15978,_15980) --> 
    one_of_lit([den,det,dette,disse,slike],_15992,_15978,_16009),
    w(noun(_15906,_15907,_15908,n),_16021,_16009,_16038),
    w(verb(_15932,_15933,fin),_16050,_16038,_16067),
    {user:(\+testmember(_15932,[have,get]))},
    subject(_15947,_15948,_16089,_16067,_16108),
    !,
    pushstack(first,(xnp(_15947,_15948),w(verb(_15932,_15933,fin)),w(noun(_15906,_15907,_15908,n))),nil,_16108,_16169),
    statreal(_15875,_16128,_16169,_15980).

sentence1(new:::_15875,[sentence1,lit(hvorvidt),_15972,!,lit(kan),_16022,!,_16056],_15947,_15949) --> 
    cc(hvorvidt,_15947,_15971),
    clausal_object1(_15904,_15905,_15972,_15971,_15991),
    !,
    cc(kan,_15991,_16021),
    w(verb(_15916,_15917,pass),_16022,_16021,_16039),
    !,
    pushstack(first,([dere],w(verb(_15916,_15917,fin)),xnp(_15904,_15905)),nil,_16039,_16097),
    statreal(_15875,_16056,_16097,_15949).

sentence1(new:::_15875,[sentence1,_15954,_15983,_16017,!,_16051],_15940,_15942) --> 
    w(verb(_15897,_15903,_15904),_15954,_15940,_15971),
    gmem(_15897,[talk,speak],_15983,_15971,_16002),
    look_ahead(w(prep(_15917)),_16017,_16002,_16034),
    !,
    pushstack(first,([du],w(verb(_15897,pres))),nil,_16034,_16061),
    statreal(_15875,_16051,_16061,_15942).

sentence1(new:::_15875,[sentence1,_15927,_15951,!,_15980],_15913,_15915) --> 
    aux1(_15927,_15913,_15942),
    not_look_ahead_np(_15951,_15942,_15966),
    !,
    pushstack(first,([jeg],aux1),nil,_15966,_16023),
    statreal(_15875,_15980,_16023,_15915).

sentence1(new:::_15875,[sentence1,_15936,!,_15970],_15922,_15924) --> 
    w(verb(_15891,past,part),_15936,_15922,_15953),
    !,
    pushstack(first,([jeg],w(verb(_15891,past,fin))),nil,_15953,_15980),
    statreal(_15875,_15970,_15980,_15924).

sentence1(new:::_15875,[sentence1,_15936,!,_15970],_15922,_15924) --> 
    w(verb(_15891,past,part),_15936,_15922,_15953),
    !,
    pushstack(first,([jeg],w(verb(_15891,past,fin))),nil,_15953,_15980),
    statreal(_15875,_15970,_15980,_15924).

sentence1(new:::_15875,[sentence1,lit(har),_15962,_15991,!,_16025],_15937,_15939) --> 
    cc(har,_15937,_15961),
    negation0(_15898,_15962,_15961,_15979),
    w(verb(_15906,past,part),_15991,_15979,_16008),
    !,
    pushstack(first,([jeg],w(verb(_15906,past,fin)),negation(_15898)),nil,_16008,_16065),
    statreal(_15875,_16025,_16065,_15939).

sentence1(new:::_15875,[sentence1,_15974,_16003,_16032,_16066,_16090,_16119,!,_16153],_15960,_15962) --> 
    not_look_ahead([så],_15974,_15960,_15991),
    w(verb(_15906,pres,fin),_16003,_15991,_16020),
    gmem(_15906,[go,think],_16032,_16020,_16051),
    not_look_ahead_np(_16066,_16051,_16081),
    not_look_ahead([ikke],_16090,_16081,_16107),
    not_look_ahead_lit([jeg,meg,du],_16119,_16107,_16136),
    !,
    pushstack(first,([jeg],w(verb(_15906,pres,fin))),nil,_16136,_16163),
    statreal(_15875,_16153,_16163,_15962).

sentence1(new:::_15875,[sentence1,_16008,_16037,_16066,_16100,_16134,_16163,_16192,!,_16226],_15994,_15996) --> 
    not_look_ahead([så],_16008,_15994,_16025),
    w(verb(_15909,_15920,fin),_16037,_16025,_16054),
    gmem(_15920,[pres],_16066,_16054,_16085),
    gmem(_15909,[arrive,calculate,discover,give,hope,pass,run,send,start,take,think,try,wait],_16100,_16085,_16119),
    particlev1(_15909,_16134,_16119,_16151),
    not_look_ahead([ikke],_16163,_16151,_16180),
    not_look_ahead_lit([jeg,meg,du,vi],_16192,_16180,_16209),
    !,
    pushstack(first,([jeg],w(verb(_15909,pres,fin))),nil,_16209,_16236),
    statreal(_15875,_16226,_16236,_15996).

sentence1(new:::_15875,[sentence1,_16000,_16029,_16058,_16092,_16126,_16155,_16184,!,_16218],_15986,_15988) --> 
    not_look_ahead([så],_16000,_15986,_16017),
    w(verb(_15909,_15920,fin),_16029,_16017,_16046),
    gmem(_15920,[imp,inf],_16058,_16046,_16077),
    gmem(_15909,[arrive,discover,pass,run,send,start,take,try],_16092,_16077,_16111),
    reflexiv0(_15909,_16126,_16111,_16143),
    not_look_ahead([ikke],_16155,_16143,_16172),
    not_look_ahead_lit([jeg,meg,du,vi],_16184,_16172,_16201),
    !,
    pushstack(first,([jeg],w(verb(_15909,pres,fin))),nil,_16201,_16228),
    statreal(_15875,_16218,_16228,_15988).

sentence1(new:::_15875,[sentence1,_15990,_16019,{},_16058,_16087,_16116,_16140,!,_16189],_15976,_15978) --> 
    not_look_ahead([så],_15990,_15976,_16007),
    w(verb(_15918,pres,fin),_16019,_16007,_16036),
    {user:testmember(_15918,[believe,calculate,think,see,know])},
    not_look_ahead([det],_16058,_16036,_16075),
    not_look_ahead([du],_16087,_16075,_16104),
    redundant0(_16116,_16104,_16131),
    optional([at],_16140,_16131,_16172),
    !,
    pushstack(first,([jeg],w(verb(_15918,pres,fin)),[at]),nil,_16172,_16199),
    statreal(_15875,_16189,_16199,_15978).

sentence1(new:::_15875,[sentence1,_15959,_15988,_16017,lit(jeg),_16052,!,_16081],_15945,_15947) --> 
    not_look_ahead([så],_15959,_15945,_15976),
    w(verb(_15912,_15913,fin),_15988,_15976,_16005),
    redundant0(_16017,_16005,_16032),
    cc(jeg,_16032,_16051),
    aux1(_16052,_16051,_16067),
    !,
    pushstack(first,([jeg],w(verb(_15912,pres,fin)),[å]),nil,_16067,_16091),
    statement(_15875,_16081,_16091,_15947).

sentence1(new:::_15875,[sentence1,_15952,_15976,_16000,_16029,!,_16063],_15938,_15940) --> 
    aux1(_15952,_15938,_15967),
    redundants0(_15976,_15967,_15991),
    negation0(_15901,_16000,_15991,_16017),
    w(verb(_15907,inf,fin),_16029,_16017,_16046),
    !,
    pushstack(first,([jeg],w(verb(_15907,pres,fin)),negation(_15901)),nil,_16046,_16103),
    statement(_15875,_16063,_16103,_15940).

sentence1(_15872,[sentence1,_15907],_15893,_15895) --> 
    command(_15872,_15907,_15893,_15895).

sentence1(_15872,[sentence1,_15913,_15937,_15966],_15899,_15901) --> 
    greetings0(_15913,_15899,_15928),
    question(_15872,_15937,_15928,_15954),
    qtrailer0(_15966,_15954,_15901).

sentence1(modifier(_15884):::_15888 isa clock and srel/nil/time/_15888/_15884 and event/real/_15884,[sentence1,{},_15977,_16006,{},!,_16045],_15953,_15955) --> 
    {user:value(dialog,1)},
    item(_15926,_15977,_15953,_15994),
    endofline(_16006,_15994,_16021),
    {user:_15926=(_15888 isa clock)},
    !,
    accept(_16045,_16021,_15955).

sentence1(item:::_15875,[sentence1,{},_15937,_15966,!,_15995],_15913,_15915) --> 
    {user:value(dialog,1)},
    item(_15875,_15937,_15913,_15954),
    endofline(_15966,_15954,_15981),
    !,
    accept(_15995,_15981,_15915).

sentence1(item:::_15877 isa clock,[sentence1,{},lit(nå),_15961,!,_15990,{}],_15926,_15928) --> 
    {user:value(dialog,1)},
    cc(nå,_15926,_15960),
    terminator1(_15961,_15960,_15976),
    !,
    accept(_15990,_15976,_15928),
    {user:timenow(_15877)}.

sentence1(item:::_15875,[sentence1,_15938,{},_16002,!,_16031],_15924,_15926) --> 
    noun(_15889,_15890,_15891,n,it:_15897,_15875,_15938,_15924,_15965),
    {user:value(dialog,1)},
    endofline(_16002,_15965,_16017),
    !,
    accept(_16031,_16017,_15926).

sentence1(item:::it isa _15878,[sentence1,{},_15948,_15972,!,_16001,{}],_15924,_15926) --> 
    {user:value(dialog,1)},
    today(_15948,_15924,_15963),
    terminator1(_15972,_15963,_15987),
    !,
    accept(_16001,_15987,_15926),
    {user:today(_15878)}.

sentence1(new:::_15875,[sentence1,lit(ble),_15961,!,_15995],_15936,_15938) --> 
    cc(ble,_15936,_15960),
    look_ahead(w(adj2(_15897,nil)),_15961,_15960,_15978),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),w(adj2(_15897,nil))),nil,_15978,_16005),
    statement(_15875,_15995,_16005,_15938).

sentence1(new:::_15875,[sentence1,_15970,_15999,_16023,{},!,_16067,_16091],_15956,_15958) --> 
    w(verb(be,_15911,_15912),_15970,_15956,_15987),
    now0(_15999,_15987,_16014),
    w(prep(_15916),_16023,_16014,_16040),
    {user:testmember(_15916,[in,on,at])},
    !,
    accept(_16067,_16040,_16082),
    pushstack(first,([jeg],w(verb(be,pres,fin)),w(prep(on))),nil,_16082,_16101),
    statement(_15875,_16091,_16101,_15958).

sentence1(new:::_15875,[sentence1,_15955,_15979,{},_16018,_16042],_15941,_15943) --> 
    has(_15955,_15941,_15970),
    w(verb(_15897,past,part),_15979,_15970,_15996),
    {user:testmember(_15897,[send,get,receive,lay])},
    now0(_16018,_15996,_16033),
    pushstack(first,([jeg],w(verb(_15897,past,fin))),nil,_16033,_16052),
    statement(_15875,_16042,_16052,_15943).

sentence1(new:::_15875,[sentence1,_15954,{},_15993,_16017],_15940,_15942) --> 
    w(verb(_15894,_15901,fin),_15954,_15940,_15971),
    {user:testmember(_15894,[send,get,receive,lay,check])},
    now0(_15993,_15971,_16008),
    pushstack(first,([jeg],w(verb(_15894,pres,fin))),nil,_16008,_16027),
    statement(_15875,_16017,_16027,_15942).

sentence1(new:::_15875,[sentence1,_15916,_15940,_15969],_15902,_15904) --> 
    greetings0(_15916,_15902,_15931),
    statement(_15875,_15940,_15931,_15957),
    dtrailer0(_15969,_15957,_15904).

sentence1(item:::_15875,[sentence1,_15919,_15948,!,_15977],_15905,_15907) --> 
    item(_15875,_15919,_15905,_15936),
    terminator1(_15948,_15936,_15963),
    !,
    accept(_15977,_15963,_15907).

item(_15874 isa clock,[item,{},_15939,{},_15978],_15915,_15917) --> 
    {user:value(dialog,1)},
    time12(_15874,_15939,_15915,_15956),
    {user:_15874\==now},
    endofline(_15978,_15956,_15917).

item(_15872,[item,{},_15929,_15963],_15905,_15907) --> 
    {user:value(dialog,1)},
    obviousdate1(_15885,_15872,_15929,_15905,_15948),
    endofline(_15963,_15948,_15907).

item(_15872,[item,_15909],_15895,_15897) --> 
    namep(_15874,_15875,_15872,_15909,_15895,_15897).

command(_15872,[command,lit(vil),!,_15929],_15899,_15901) --> 
    cc(vil,_15899,_15923),
    !,
    reject(_15929,_15923,_15901).

command(_15872,[command,lit(skal),!,_15929],_15899,_15901) --> 
    cc(skal,_15899,_15923),
    !,
    reject(_15929,_15923,_15901).

command(doit:::_15875,[command,lit(du),lit(må),_15975,_16004,!,_16038],_15939,_15941) --> 
    cc(du,_15939,_15963),
    cc(må,_15963,_15974),
    not_look_ahead([ikke],_15975,_15974,_15992),
    w(verb(_15900,inf,fin),_16004,_15992,_16021),
    !,
    pushstack(first,([du],w(verb(_15900,pres,fin))),nil,_16021,_16048),
    statreal(_15875,_16038,_16048,_15941).

command(doit:::quit(_15877),[command,_15921,_15945,_15969,_15998],_15907,_15909) --> 
    grums0(_15921,_15907,_15936),
    okeys0(_15945,_15936,_15960),
    quit(_15877,_15969,_15960,_15986),
    skip_rest(_15998,_15986,_15909).

command(doit:::reply(_15877),[command,_15918,_15947,_15971],_15904,_15906) --> 
    personal(_15877,_15918,_15904,_15935),
    dtrailer0(_15947,_15935,_15962),
    endofline(_15971,_15962,_15906).

command(doit:::replyq('Hei'),[command,_15913,!],_15899,_15901) --> 
    hellos(_15913,_15899,_15901),
    !.

command(new:::_15875,[command,_15948,_15977,lit(ut),_16017,_16051,!,_16080],_15934,_15936) --> 
    w(verb(_15900,pres,fin),_15948,_15934,_15965),
    not_look_ahead([du],_15977,_15965,_15994),
    cc(ut,_15994,_16016),
    gmem(_15900,[see,look],_16017,_16016,_16036),
    tilat(_16051,_16036,_16066),
    !,
    substateme1(real,_15875,_16080,_16066,_15936).

tilat([tilat,lit(til),lit(at),!],_15897,_15899) --> 
    cc(til,_15897,_15918),
    cc(at,_15918,_15899),
    !.

tilat([tilat,lit(som),lit(om),!],_15897,_15899) --> 
    cc(som,_15897,_15918),
    cc(om,_15918,_15899),
    !.

tilat([tilat,lit(som)],_15889,_15891) --> 
    cc(som,_15889,_15891).

command(new:::_15875,[command,_15963,_15992,_16021,!,_16060],_15949,_15951) --> 
    w(verb(_15897,pres,fin),_15963,_15949,_15980),
    not_look_ahead([du],_15992,_15980,_16009),
    gmem(_15897,[expect,miss,need,get,receive,see,understand],_16021,_16009,_16040),
    !,
    pushstack(first,([jeg],w(verb(_15897,pres,fin))),nil,_16040,_16070),
    statreal(_15875,_16060,_16070,_15951).

command(new:::_15875,[command,_15999,_16028,_16057,{},_16096,{},!,_16140],_15985,_15987) --> 
    not_look_ahead([nå],_15999,_15985,_16016),
    not_look_ahead(w(verb(come,imp,fin)),_16028,_16016,_16045),
    w(verb(_15906,_15925,fin),_16057,_16045,_16074),
    {user:testmember(_15906,[go,take,run,arrive,leave,leave2,depart,start,pass])},
    not_look_ahead([meg],_16096,_16074,_16113),
    {user:testmember(_15925,[imp,inf])},
    !,
    pushstack(first,([jeg],w(verb(_15906,pres,fin))),nil,_16113,_16150),
    statreal(_15875,_16140,_16150,_15987).

command(new:::_15875,[command,_15964,_15993,{},_16032,lit(jeg),_16077,!,_16111],_15950,_15952) --> 
    w(verb(_15905,pres,fin),_15964,_15950,_15981),
    not_look_ahead([du],_15993,_15981,_16010),
    {user:testmember(_15905,[believe])},
    that0(_15905,that,_16032,_16010,_16051),
    cc(jeg,_16051,_16076),
    not_look_ahead(w(prep(_15929)),_16077,_16076,_16094),
    !,
    pushstack(first,[jeg],nil,_16094,_16121),
    statreal(_15875,_16111,_16121,_15952).

command(new:::_15875,[command,_15951,_15980,_16014,!,_16043],_15937,_15939) --> 
    w(verb(_15897,pres,fin),_15951,_15937,_15968),
    gmem(_15897,[arrive,leave2,depart],_15980,_15968,_15999),
    look_ahead_place(_16014,_15999,_16029),
    !,
    pushstack(first,([jeg],w(verb(_15897,pres,fin))),nil,_16029,_16053),
    statreal(_15875,_16043,_16053,_15939).

command(doit:::_15875,[command,_15965,_16009,_16033,_16062,{},_16101,!,_16130],_15951,_15953) --> 
    optional(grums,_15965,_15951,_15997),
    please0(_16009,_15997,_16024),
    negation0(_15907,_16033,_16024,_16050),
    w(verb(_15915,imp,fin),_16062,_16050,_16079),
    {user:verbtype(_15915,tv)},
    look_ahead_np(_16101,_16079,_16116),
    !,
    pushstack(first,([du],w(verb(_15915,pres,fin)),negation(_15907)),nil,_16116,_16170),
    statreal(_15875,_16130,_16170,_15953).

command(doit:::_15875,[command,_15960,_16004,_16028,_16057,_16086,!,_16125],_15946,_15948) --> 
    optional(grums,_15960,_15946,_15992),
    please0(_16004,_15992,_16019),
    negation0(_15904,_16028,_16019,_16045),
    w(verb(_15912,imp,fin),_16057,_16045,_16074),
    particlev0(_15912,_15917,_16086,_16074,_16105),
    !,
    pushstack(first,([du],w(verb(_15917,pres,fin)),negation(_15904)),nil,_16105,_16165),
    statreal(_15875,_16125,_16165,_15948).

command(doit:::replyq(?),[command,_15910],_15896,_15898) --> 
    end_of_line(_15910,_15896,_15898).

imp_phrase(_15872,[imp_phrase,_15927,lit(oss),_15982,!],_15913,_15915) --> 
    lexv(_15883,let,imp,fin,_15927,_15913,_15950),
    cc(oss,_15950,_15981),
    w(verb(_15872,inf,fin),_15982,_15981,_15915),
    !.

imp_phrase(let,[imp_phrase,_15916,!,_15965],_15902,_15904) --> 
    lexv(rv,let,imp,fin,_15916,_15902,_15939),
    !,
    accept(_15965,_15939,_15904).

imp_phrase(list,[imp_phrase,_15919,_15943,!,_15992],_15905,_15907) --> 
    faa(_15919,_15905,_15934),
    lexv(_15883,see,imp,fin,_15943,_15934,_15966),
    !,
    accept(_15992,_15966,_15907).

imp_phrase(wait,[imp_phrase,_15914,!],_15900,_15902) --> 
    w(verb(wait,imp,fin),_15914,_15900,_15902),
    !.

imp_phrase(_15872,[imp_phrase,_15942,_15971,_15995,{},{}],_15928,_15930) --> 
    not_look_ahead([må],_15942,_15928,_15959),
    comeand0(_15971,_15959,_15986),
    lexv(_15901,_15872,imp,fin,_15995,_15986,_15930),
    {user:_15901\==rv},
    {user:(\+testmember(_15872,[have,expect]))}.

imp_phrase(_15872,[imp_phrase,_15941,_15970,_15994,{},{},_16058],_15927,_15929) --> 
    not_look_ahead([må],_15941,_15927,_15958),
    comeand0(_15970,_15958,_15985),
    lexv(rv,_15872,imp,fin,_15994,_15985,_16017),
    {user:_15872\==be},
    {user:_15872\==wonder},
    reflexiv0(_15872,_16058,_16017,_15929).

imp_phrase(_15872,[imp_phrase,_15942,_15971,_15995,{},{}],_15928,_15930) --> 
    not_look_ahead([må],_15942,_15928,_15959),
    comeand0(_15971,_15959,_15986),
    lexv(_15895,_15872,inf,fin,_15995,_15986,_15930),
    {user:testmember(_15872,[list,show,make])},
    {user:_15872\==be}.

comeand0([comeand0,_15912,lit(å),!],_15901,_15903) --> 
    w(verb(come,imp,fin),_15912,_15901,_15929),
    cc(å,_15929,_15903),
    !.

comeand0([comeand0,[]],_15887,_15887) --> 
    [].

declaration(_15874 isa self,[declaration,_15919,_15943,!,_15972],_15905,_15907) --> 
    i(_15919,_15905,_15934),
    be(_15943,_15934,_15958),
    !,
    newatomid(_15874,_15972,_15958,_15907).

declaration(_15872,[declaration,_15926,_15955,_15979,!,_16008],_15912,_15914) --> 
    newatom(_15890,_15926,_15912,_15943),
    be(_15955,_15943,_15970),
    a(_15979,_15970,_15994),
    !,
    noun(_15886,sin,u,n,_15890,_15872,_16008,_15994,_15914).

statement(_15872,[statement,lit(det),_15970,lit(at),_16010,_16039,_16078,!,_16107,[],_16178],_15945,_15947) --> 
    cc(det,_15945,_15969),
    be_truefalse(_15905,_15970,_15969,_15987),
    cc(at,_15987,_16009),
    look_ahead_lit([før,etter,når],_16010,_16009,_16027),
    adverbial3(_15917,_15918,_15919,_16039,_16027,_16060),
    comma0(_16078,_16060,_16093),
    !,
    accept(_16107,_16093,_16122),
    pushstack(free,adverbial1(_15917,_15918,_15919),nil,_16122,_16177),[],
    substatement1(_15872,_16178,_16177,_15947).

statement(_15872,[statement,_15945,_15974,_16013,!,_16042],_15931,_15933) --> 
    look_ahead_lit([hvis,om,selvom,da],_15945,_15931,_15962),
    adverbial3(_15892,_15893,_15894,_15974,_15962,_15995),
    soredundant(_16013,_15995,_16028),
    !,
    lock(last,_16028,_16092),
    pushstack(last,([så],xadverbial1(_15892,_15893,_15894)),nil,_16092,_16098),
    substatement1(_15872,_16042,_16098,_16087),
    unlock(_16087,_15933).

statement(_15872,[statement,_15969,_15998,_16037,_16066,lit(det),!,_16111,_16135],_15955,_15957) --> 
    look_ahead([hvis],_15969,_15955,_15986),
    adverbial3(_15904,_15905,_15906,_15998,_15986,_16019),
    not_look_ahead([så],_16037,_16019,_16054),
    w(verb(_15922,_15923,fin),_16066,_16054,_16083),
    cc(det,_16083,_16105),
    !,
    accept(_16111,_16105,_16126),
    lock(last,_16126,_16184),
    pushstack(last,([det],w(verb(_15922,_15923,fin)),xadverbial1(_15904,_15905,_15906)),nil,_16184,_16190),
    substatement1(_15872,_16135,_16190,_16179),
    unlock(_16179,_15957).

statement(_15872,[statement,_15967,_15996,_16035,_16064,lit(det),_16099,!,_16133,_16157],_15953,_15955) --> 
    look_ahead([hvis],_15967,_15953,_15984),
    adverbial3(_15910,_15911,_15912,_15996,_15984,_16017),
    not_look_ahead([så],_16035,_16017,_16052),
    aux1(_16064,_16052,_16079),
    cc(det,_16079,_16098),
    negation0(_15928,_16099,_16098,_16116),
    !,
    accept(_16133,_16116,_16148),
    lock(last,_16148,_16264),
    pushstack(last,([det],aux1,negation(_15928),xadverbial1(_15910,_15911,_15912)),nil,_16264,_16270),
    substatement1(_15872,_16157,_16270,_16259),
    unlock(_16259,_15955).

statement(_15872,[statement,_15972,_16001,_16040,_16069,_16093,_16127,_16151,!,_16185,_16209],_15958,_15960) --> 
    look_ahead([hvis],_15972,_15958,_15989),
    adverbial3(_15913,_15914,_15915,_16001,_15989,_16022),
    not_look_ahead([så],_16040,_16022,_16057),
    aux1(_16069,_16057,_16084),
    subject(_15929,_15930,_16093,_16084,_16112),
    redundant0(_16127,_16112,_16142),
    negation0(_15932,_16151,_16142,_16168),
    !,
    accept(_16185,_16168,_16200),
    lock(last,_16200,_16347),
    pushstack(last,(xnp(_15929,_15930),aux1,negation(_15932),xadverbial1(_15913,_15914,_15915)),nil,_16347,_16353),
    substatement1(_15872,_16209,_16353,_16342),
    unlock(_16342,_15960).

statement(_15872,[statement,_15974,_16003,_16042,_16071,!,_16105,!,_16144,_16168],_15960,_15962) --> 
    look_ahead([hvis],_15974,_15960,_15991),
    adverbial3(_15907,_15908,_15909,_16003,_15991,_16024),
    not_look_ahead([så],_16042,_16024,_16059),
    w(verb(_15925,_15926,fin),_16071,_16059,_16088),
    !,
    subject(_15929,_15930,_16105,_16088,_16124),
    !,
    accept(_16144,_16124,_16159),
    lock(last,_16159,_16248),
    pushstack(last,(xnp(_15929,_15930),w(verb(_15925,_15926,fin)),xadverbial1(_15907,_15908,_15909)),nil,_16248,_16254),
    substatement1(_15872,_16168,_16254,_16243),
    unlock(_16243,_15962).

statement(_15872,[statement,_15944,_15973,_16012,!,_16041,[],_16111],_15930,_15932) --> 
    look_ahead_lit([før,etter,når],_15944,_15930,_15961),
    adverbial3(_15902,_15903,_15904,_15973,_15961,_15994),
    comma0(_16012,_15994,_16027),
    !,
    accept(_16041,_16027,_16056),
    pushstack(free,adverbial1(_15902,_15903,_15904),nil,_16056,_16110),[],
    substatement1(_15872,_16111,_16110,_15932).

statement(_15872,[statement,_15908],_15894,_15896) --> 
    statemens(real,_15872,_15908,_15894,_15896).

substatement1(_15872,[substatement1,_15960,_15984,_16013,_16057,_16091,_16135,!,_16174],_15946,_15948) --> 
    dether(_15960,_15946,_15975),
    w(verb(be,_15907,fin),_15984,_15975,_16001),
    optional([ofte],_16013,_16001,_16045),
    np0_accept(_15901,_15902,_16057,_16045,_16076),
    optional([som],_16091,_16076,_16123),
    subject(_15921,_15922,_16135,_16123,_16154),
    !,
    pushstack(free,(xnp(_15921,_15922),xnp(_15901,_15902)),nil,_16154,_16246),
    statreal(_15872,_16174,_16246,_15948).

dether([dether,lit(det)],_15889,_15891) --> 
    cc(det,_15889,_15891).

dether([dether,lit(det),lit(her)],_15894,_15896) --> 
    cc(det,_15894,_15915),
    cc(her,_15915,_15896).

dether([dether,lit(dette)],_15889,_15891) --> 
    cc(dette,_15889,_15891).

substatement1(_15872,[substatement1,_15908],_15894,_15896) --> 
    statemen1(real,_15872,_15908,_15894,_15896).

statemens(_15872,_15873,[statemens,_15921,_15955],_15904,_15906) --> 
    statemen1(_15872,_15879,_15921,_15904,_15940),
    statemens0(_15872,_15879,_15873,_15955,_15940,_15906).

statemens0(_15872,_15873,_15873 and _15877,[statemens0,_15937,_15961,!,_15990],_15917,_15919) --> 
    stm_conjunction(_15937,_15917,_15952),
    aux1(_15961,_15952,_15976),
    !,
    pushstack(first,[jeg],nil,_15976,_16000),
    statemens(_15872,_15877,_15990,_16000,_15919).

statemens0(_15872,_15873,_15873 and _15877,[statemens0,_15940,_15964,!,_15998],_15920,_15922) --> 
    stm_conjunction(_15940,_15920,_15955),
    look_ahead_lit([så,nå,da],_15964,_15955,_15981),
    !,
    statemens(_15872,_15877,_15998,_15981,_15922).

statemens0(_15872,_15873,_15873 and _15877,[statemens0,_15933,!,_15967],_15913,_15915) --> 
    look_ahead([så],_15933,_15913,_15950),
    !,
    statemens(_15872,_15877,_15967,_15950,_15915).

statemens0(_15872,_15873,_15873 and _15877,[statemens0,_15943,_15967,_15996,!,_16025],_15923,_15925) --> 
    stm_conjunction(_15943,_15923,_15958),
    not_look_ahead(w(verb(_15898,_15899,_15900)),_15967,_15958,_15984),
    not_look_ahead_number(_15996,_15984,_16011),
    !,
    statemens(_15872,_15877,_16025,_16011,_15925).

statemens0(_15872,_15873,_15873,[statemens0,[]],_15897,_15897) --> 
    [].

stm_conjunction([stm_conjunction,lit(hvorav)],_15889,_15891) --> 
    cc(hvorav,_15889,_15891).

stm_conjunction([stm_conjunction,lit(å),_15918],_15896,_15898) --> 
    cc(å,_15896,_15917),
    look_ahead([så],_15918,_15917,_15898).

stm_conjunction([stm_conjunction,lit(å),_15918],_15896,_15898) --> 
    cc(å,_15896,_15917),
    look_ahead([nå],_15918,_15917,_15898).

stm_conjunction([stm_conjunction,lit(og),_15918],_15896,_15898) --> 
    cc(og,_15896,_15917),
    look_ahead([nå],_15918,_15917,_15898).

stm_conjunction([stm_conjunction,lit(og),lit(at)],_15894,_15896) --> 
    cc(og,_15894,_15915),
    cc(at,_15915,_15896).

stm_conjunction([stm_conjunction,lit(men),lit(at)],_15894,_15896) --> 
    cc(men,_15894,_15915),
    cc(at,_15915,_15896).

stm_conjunction([stm_conjunction,lit(altså),lit(at)],_15894,_15896) --> 
    cc(altså,_15894,_15915),
    cc(at,_15915,_15896).

stm_conjunction([stm_conjunction,_15898],_15887,_15889) --> 
    and1(_15898,_15887,_15889).

stm_conjunction([stm_conjunction,lit(men)],_15889,_15891) --> 
    cc(men,_15889,_15891).

stm_conjunction([stm_conjunction,_15902],_15891,_15893) --> 
    look_ahead([så],_15902,_15891,_15893).

stm_conjunction([stm_conjunction,_15909,_15953],_15898,_15900) --> 
    optional([','],_15909,_15898,_15941),
    look_ahead([ikke],_15953,_15941,_15900).

stm_conjunction([stm_conjunction,lit(mens)],_15889,_15891) --> 
    cc(mens,_15889,_15891).

statemen1(_15872,_15873,[statemen1,_15914],_15897,_15899) --> 
    stateme1(_15872,_15873,_15914,_15897,_15899).

statemen1(_15872,_15873,[statemen1,_15973,{},_16012,!,_16061],_15956,_15958) --> 
    w(adj2(_15903,nil),_15973,_15956,_15990),
    {user:testmember(_15903,[possible,clear,ready])},
    optional([at],_16012,_15990,_16044),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_15903,nil)),[at]),nil,_16044,_16071),
    substateme1(_15872,_15873,_16061,_16071,_15958).

statemen1(_15872,_15873,[statemen1,_15997,{},_16036,{},{},_16085,!,_16124,!,_16203],_15980,_15982) --> 
    w(adj2(_15904,nil),_15997,_15980,_16014),
    {user:testmember(_15904,[enclosed])},
    w(verb(_15916,_15917,fin),_16036,_16014,_16053),
    {user:(\+testmember(_15916,[]))},
    {user:verbtype(_15916,iv)},
    subject(_15932,_15933,_16085,_16053,_16104),
    !,
    pushstack(first,(xnp(_15932,_15933),w(verb(_15916,_15917,fin)),w(adj2(_15904,nil))),nil,_16104,_16168),substateme1(_15872,_15873,_16124,_16168,_16183),
    !,
    accept(_16203,_16183,_15982).

statemen1(_15872,_15873,[statemen1,_15964,_15988,{},lit(det),_16038,_16062,!,_16110],_15947,_15949) --> 
    redundant(_15964,_15947,_15979),
    w(verb(_15898,_15899,fin),_15988,_15979,_16005),
    {user:(\+testmember(_15898,[]))},
    cc(det,_16005,_16037),
    danow0(_16038,_16037,_16053),
    pushstack(first,([det],w(verb(_15898,pres,fin))),nil,_16053,_16075),substateme1(_15872,_15873,_16062,_16075,_16090),
    !,
    accept(_16110,_16090,_15949).

statemen1(_15872,_15873,[statemen1,_15973,_16017,{},_16056,!,_16104],_15956,_15958) --> 
    optional([meget],_15973,_15956,_16005),
    w(adj2(_15896,nil),_16017,_16005,_16034),
    {user:testmember(_15896,[good,bad,interesting,nice])},
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_15896,nil))),nil,_16034,_16069),substateme1(_15872,_15873,_16056,_16069,_16084),
    !,
    accept(_16104,_16084,_15958).

statemen1(_15872,_15873,[statemen1,_15934,{},_15973],_15917,_15919) --> 
    not_look_ahead_lit([hva,hvem,hvilke,hvilken,hvilket],_15934,_15917,_15951),
    {user:unprotected_verb},
    substateme1(_15872,_15873,_15973,_15951,_15919).

statemen1(_15872,_15873,[statemen1,lit(som),lit(du),_15999,{},_16038,_16067,_16101],_15960,_15962) --> 
    cc(som,_15960,_15987),
    cc(du,_15987,_15998),
    w(verb(_15911,_15912,fin),_15999,_15998,_16016),
    {user:testmember(_15911,[know,see,understand])},
    w(verb(_15901,_15929,fin),_16038,_16016,_16055),
    subject(_15932,_15933,_16067,_16055,_16086),
    pushstack(first,(xnp(_15932,_15933),w(verb(_15901,pres,fin))),nil,_16086,_16142),
    substateme1(_15872,_15873,_16101,_16142,_15962).

statemen1(_15872,_15873,[statemen1,_15948,_15972,lit(det),_16012,!],_15931,_15933) --> 
    soredundant(_15948,_15931,_15963),
    w(verb(_15889,_15890,fin),_15972,_15963,_15989),
    cc(det,_15989,_16011),
    pushstack(first,([noe],w(verb(_15889,_15890,fin))),nil,_16011,_16025),substateme1(_15872,_15873,_16012,_16025,_15933),
    !.

stateme1(_15872,_15873,[stateme1,_15923],_15906,_15908) --> 
    statem(_15875,event/_15872/_15875::_15873,_15923,_15906,_15908).

substateme1(_15872,_15873,[substateme1,_15923],_15906,_15908) --> 
    substatem1(_15875,event/_15872/_15875::_15873,_15923,_15906,_15908).

substatem(_15872,_15873,[substatem,_15921,_15955],_15904,_15906) --> 
    substatem1(_15872,_15879,_15921,_15904,_15940),
    ogat(_15872,_15879,_15873,_15955,_15940,_15906).

ogat(_15872,_15876::_15879,_15876::_15879 and _15880,[ogat,lit(og),lit(at),!,_15972],_15925,_15927) --> 
    cc(og,_15925,_15955),
    cc(at,_15955,_15966),
    !,
    substatem1(_15872,_15876::_15880,_15972,_15966,_15927).

ogat(_15872,_15873,_15873,[ogat,[]],_15897,_15897) --> 
    [].

substatem1(_15872,_15873,[substatem1,lit(det),_15974,_16003,{},!,[],_16091],_15946,_15948) --> 
    cc(det,_15946,_15973),
    negation0(_15907,_15974,_15973,_15991),
    be(_15909,_16003,_15991,_16020),
    {user:bigno(_15907,_15909,_15915)},
    !,
    pushstack(free,negation(_15915),nil,_16020,_16090),[],
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_16090,_16101),
    statem(_15872,_15873,_16091,_16101,_15948).

substatem1(_15872,_15873,[substatem1,lit(det),_15975,_16004,{},!,_16068],_15947,_15949) --> 
    cc(det,_15947,_15974),
    negation0(_15903,_15975,_15974,_15992),
    hlexv(_15905,_15906,_15907,fin,_15909,_16004,_15992,_16029),
    {user:bigno(_15903,_15909,_15899)},
    !,
    pushstack(first,([det],w(verb(_15906,pres,fin)),negation(_15899)),nil,_16029,_16108),
    statem(_15872,_15873,_16068,_16108,_15949).

substatem1(_15872,_15873,[substatem1,lit(å),!,_15958,!,_16006],_15925,_15927) --> 
    cc(å,_15925,_15952),
    !,
    pushstack(first,[jeg],nil,_15952,_15971),clausal_object1(_15890,_15891,_15958,_15971,_15986),
    !,
    lock(last,_15986,_16054),
    pushstack(last,xnp(_15890,_15891),nil,_16054,_16060),
    statem(_15872,_15873,_16006,_16060,_16049),
    unlock(_16049,_15927).

substatem1(_15872,_15873,[substatem1,_15967,_15991,_16020,_16063,!,_16092],_15950,_15952) --> 
    forå(_15967,_15950,_15982),
    w(verb(_15902,inf,fin),_15991,_15982,_16008),
    pushstack(first,([jeg],w(verb(_15902,pres,fin))),nil,_16008,_16033),clausal_object1(_15897,true::_15898,_16020,_16033,_16048),
    hvisaa0(_16063,_16048,_16078),
    !,
    lock(last,_16078,_16142),
    pushstack(last,([så],subordinate(in_order_to,_15897,_15898)),nil,_16142,_16148),
    statem(_15872,_15873,_16092,_16148,_16137),
    unlock(_16137,_15952).

substatem1(_15872,_15873,[substatem1,_15987,_16016,[],_16100,_16124,lit(det),_16159,_16183,!,_16217],_15970,_15972) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom],_15987,_15970,_16004),
    subordinate(_15929,_15930,_15931,_16016,_16004,_16037),
    pushstack(free,subordinate(_15929,_15930,_15931),nil,_16037,_16099),[],
    hvisaa0(_16100,_16099,_16115),
    has(_16124,_16115,_16139),
    cc(det,_16139,_16158),
    redundant0(_16159,_16158,_16174),
    w(verb(be,past,part),_16183,_16174,_16200),
    !,
    pushstack(first,w(verb(be,past,fin)),nil,_16200,_16227),
    itstatem(_15872,_15873,_16217,_16227,_15972).

substatem1(_15872,_15873,[substatem1,_15964,_15993,_16032,!,_16061],_15947,_15949) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom,da,når],_15964,_15947,_15981),
    subordinate(_15893,_15894,_15895,_15993,_15981,_16014),
    hvisaa0(_16032,_16014,_16047),
    !,
    lock(last,_16047,_16110),
    pushstack(last,([så],subordinate(_15893,_15894,_15895)),nil,_16110,_16116),
    statem(_15872,_15873,_16061,_16116,_16105),
    unlock(_16105,_15949).

substatem1(_15872,_15873,[substatem1,_15914],_15897,_15899) --> 
    substate(_15872,_15873,_15914,_15897,_15899).

hvisaa0([hvisaa0,lit(så),!],_15892,_15894) --> 
    cc(så,_15892,_15894),
    !.

hvisaa0([hvisaa0,_15905,!],_15894,_15896) --> 
    look_ahead_lit([ble],_15905,_15894,_15896),
    !.

hvisaa0([hvisaa0,_15907,!],_15896,_15898) --> 
    look_ahead_lit([kan,får],_15907,_15896,_15898),
    !.

hvisaa0([hvisaa0,_15922,{}],_15911,_15913) --> 
    look_ahead(w(verb(_15877,_15893,fin)),_15922,_15911,_15913),
    {user:testmember(_15877,[avoid,be,come,have])}.

hvisaa0([hvisaa0,[]],_15887,_15887) --> 
    [].

sostatem(_15872,_15873,[sostatem,_15969,_15993,_16027,_16051,_16080,!,_16114,!],_15952,_15954) --> 
    faux1(_15969,_15952,_15984),
    subject(_15896,_15897,_15993,_15984,_16012),
    redundant0(_16027,_16012,_16042),
    negation0(_15899,_16051,_16042,_16068),
    w(verb(_15903,inf,fin),_16080,_16068,_16097),
    !,
    pushstack(first,(xnp(_15896,_15897),aux1,negation(_15899),w(verb(_15903,inf,fin))),nil,_16097,_16216),state(_15872,_15873,_16114,_16216,_15954),
    !.

sostatem(_15872,_15873,[sostatem,_15989,lit(det),_16029,_16058,lit(at),!,_16118,_16152],_15972,_15974) --> 
    w(verb(_15915,_15916,fin),_15989,_15972,_16006),
    cc(det,_16006,_16028),
    negation0(_15921,_16029,_16028,_16046),
    adj1(_15908,_15928:_15929,_15910,_15911,_16058,_16046,_16081),
    cc(at,_16081,_16112),
    !,
    clausal_object1(_15933,_15934,_16118,_16112,_16137),
    pushstack(first,(xnp(_15933,_15934),w(verb(_15915,_15916,fin)),negation(_15921),adj1(_15908,_15928:_15951,_15910,_15911)),nil,_16137,_16256),
    state(_15872,_15873,_16152,_16256,_15974).

sostatem(_15872,_15873,[sostatem,_15968,lit(det),_16003,_16027,_16056,_16085,_16119,!],_15951,_15953) --> 
    has(_15968,_15951,_15983),
    cc(det,_15983,_16002),
    preadverbials0(_16003,_16002,_16018),
    negation0(_15898,_16027,_16018,_16044),
    w(verb(_15902,past,part),_16056,_16044,_16073),
    subject(_15906,_15907,_16085,_16073,_16104),
    pushstack(first,(xnp(_15906,_15907),w(verb(_15902,past,fin)),negation(_15898)),nil,_16104,_16193),state(_15872,_15873,_16119,_16193,_15953),
    !.

sostatem(_15872,_15873,[sostatem,_15967,_16016,_16045,_16069,{},_16108,!],_15950,_15952) --> 
    lexvaccept(rv,_15894,_15895,fin,_15897,_15967,_15950,_15992),
    negation0(_15899,_16016,_15992,_16033),
    thereit(_16045,_16033,_16060),
    negation0(_15901,_16069,_16060,_16086),
    {user:bigno(_15899,_15901,_15897)},
    pushstack(first,([noe],w(verb(_15894,_15895,fin)),negation(_15897)),nil,_16086,_16151),state(_15872,_15873,_16108,_16151,_15952),
    !.

sostatem(_15872,_15873,[sostatem,_15971,_16000,_16029,_16063,{},_16102,!],_15954,_15956) --> 
    w(verb(_15895,_15896,fin),_15971,_15954,_15988),
    negation0(_15899,_16000,_15988,_16017),
    subject(_15901,_15902,_16029,_16017,_16048),
    negation0(_15904,_16063,_16048,_16080),
    {user:bigno(_15899,_15904,_15910)},
    pushstack(first,(xnp(_15901,_15902),w(verb(_15895,_15896,fin)),negation(_15910)),nil,_16080,_16176),state(_15872,_15873,_16102,_16176,_15956),
    !.

sostatem(_15872,_15873,[sostatem,_15953,_15982,_16006,_16035,!],_15936,_15938) --> 
    w(verb(_15889,_15890,pass),_15953,_15936,_15970),
    thereit0(_15982,_15970,_15997),
    negation0(_15893,_16006,_15997,_16023),
    pushstack(first,([noen],w(verb(_15889,_15890,fin)),negation(_15893)),nil,_16023,_16078),state(_15872,_15873,_16035,_16078,_15938),
    !.

sostatem(_15872,_15873,[sostatem,_15965,lit(det),_16000,{},!,_16044,!],_15948,_15950) --> 
    aux1(_15965,_15948,_15980),
    cc(det,_15980,_15999),
    w(verb(_15897,_15898,_15899),_16000,_15999,_16017),
    {user:(_15898=inf;_15899=part)},
    !,
    pushstack(first,([noe],w(verb(_15897,pres,fin))),nil,_16017,_16057),state(_15872,_15873,_16044,_16057,_15950),
    !.

sostatem(_15872,_15873,[sostatem,_15949,lit(det),_15984,!,_16018,!],_15932,_15934) --> 
    aux1(_15949,_15932,_15964),
    cc(det,_15964,_15983),
    w(verb(_15894,pres,pass),_15984,_15983,_16001),
    !,
    pushstack(first,(someone,w(verb(_15894,pres,fin))),nil,_16001,_16062),state(_15872,_15873,_16018,_16062,_15934),
    !.

sostatem(_15872,_15873,[sostatem,_15956,_15980,_16014,!,_16048,!],_15939,_15941) --> 
    aux1(_15956,_15939,_15971),
    object(_15890,_15891,_15980,_15971,_15999),
    w(verb(_15895,pres,pass),_16014,_15999,_16031),
    !,
    pushstack(first,(someone,w(verb(_15895,pres,fin)),xnp(_15890,_15891)),nil,_16031,_16120),state(_15872,_15873,_16048,_16120,_15941),
    !.

sostatem(_15872,_15873,[sostatem,_15958,_15987,{},lit(det),!,_16042,!],_15941,_15943) --> 
    not_look_ahead([så],_15958,_15941,_15975),
    w(verb(_15899,_15900,fin),_15987,_15975,_16004),
    {user:_15900\==inf},
    cc(det,_16004,_16036),
    !,
    pushstack(free,w(verb(_15899,pres,fin)),nil,_16036,_16055),state(_15872,_15873,_16042,_16055,_15943),
    !.

sostatem(_15872,_15873,[sostatem,_15956,_15980,_16014,!,_16048,!],_15939,_15941) --> 
    docan(_15956,_15939,_15971),
    subject(_15890,_15891,_15980,_15971,_15999),
    w(verb(_15895,pres,pass),_16014,_15999,_16031),
    !,
    pushstack(first,(someone,w(verb(_15895,pres,fin)),xnp(_15890,_15891)),nil,_16031,_16120),state(_15872,_15873,_16048,_16120,_15941),
    !.

statem(_15872,_15873,[statem,lit(det),_15983,_16012,_16046,!,_16080],_15955,_15957) --> 
    cc(det,_15955,_15982),
    w(verb(_15908,_15909,pass),_15983,_15982,_16000),
    gmem(_15908,[want,wish,need],_16012,_16000,_16031),
    negation0(_15921,_16046,_16031,_16063),
    !,
    pushstack(first,([noen],w(verb(_15908,_15909,fin)),negation(_15921),[dette]),nil,_16063,_16120),
    state(_15872,_15873,_16080,_16120,_15957).

statem(_15872,_15873,[statem,_15920,!,_15949],_15903,_15905) --> 
    preadverbials(_15920,_15903,_15935),
    !,
    prestatem(_15872,_15873,_15949,_15935,_15905).

statem(_15872,_15873,[statem,_15965,_15999,_16028,_16052,!,[],_16138],_15948,_15950) --> 
    obviousdate1(_15905,_15906,_15965,_15948,_15984),
    w(verb(_15901,_15902,fin),_15999,_15984,_16016),
    det0(_16028,_16016,_16043),
    subject(_15914,_15915,_16052,_16043,_16071),
    !,
    pushstack(free,obviousdate1(_15905,_15906),nil,_16071,_16137),[],
    pushstack(first,(xnp(_15914,_15915),w(verb(_15901,_15902,fin))),nil,_16137,_16179),
    state(_15872,_15873,_16138,_16179,_15950).

statem(_15872,_15873,[statem,_15959,_15993,_16022,!,_16071],_15942,_15944) --> 
    obviousdate1(_15896,_15897,_15959,_15942,_15978),
    w(verb(_15904,_15905,pass),_15993,_15978,_16010),
    optional([det],_16022,_16010,_16054),
    !,
    pushstack(free,([noen],w(verb(_15904,_15905,fin)),obviousdate1(_15896,_15897)),nil,_16054,_16112),
    state(_15872,_15873,_16071,_16112,_15944).

statem(_15872,_15873,[statem,_16006,_16040,_16069,_16103,_16137,_16166,lit(om),!,[],[],_16239],_15989,_15991) --> 
    lit_of(_15916,[det,dette],_16006,_15989,_16025),
    w(verb(_15925,_15926,fin),_16040,_16025,_16057),
    gmem(_15925,[worry],_16069,_16057,_16088),
    lit_of(_15934,[jeg,du,man],_16103,_16088,_16122),
    reflexiv0(_15925,_16137,_16122,_16154),
    negation0(_15914,_16166,_16154,_16183),
    cc(om,_16183,_16205),
    !,
    pushstack(free,[dette],nil,_16205,_16224),[],
    pushstack(free,[om],nil,_16224,_16238),[],
    pushstack(first,([_15934],w(verb(_15925,_15926,fin)),negation(_15914)),nil,_16238,_16279),
    state(_15872,_15873,_16239,_16279,_15991).

statem(_15872,_15873,[statem,_16000,_16034,_16063,_16097,lit(om),!,[],[],[],_16227],_15983,_15985) --> 
    lit_of(_15914,[det,dette],_16000,_15983,_16019),
    w(verb(_15910,_15911,fin),_16034,_16019,_16051),
    lit_of(_15927,[jeg,du,man],_16063,_16051,_16082),
    np_kernel(0,_15937,_15938,_16097,_16082,_16118),
    cc(om,_16118,_16146),
    !,
    pushstack(free,[dette],nil,_16146,_16165),[],
    pushstack(free,[om],nil,_16165,_16179),[],
    pushstack(free,np_kernel(0,_15937,_15938),nil,_16179,_16226),[],
    pushstack(first,([_15927],w(verb(_15910,_15911,fin))),nil,_16226,_16237),
    state(_15872,_15873,_16227,_16237,_15985).

statem(_15872,_15873,[statem,_16000,_16034,_16063,_16097,lit(om),!,[],[],[],_16226],_15983,_15985) --> 
    lit_of(_15914,[det,dette],_16000,_15983,_16019),
    w(verb(have,_15911,fin),_16034,_16019,_16051),
    lit_of(_15927,[jeg,du,man],_16063,_16051,_16082),
    np_kernel(0,_15937,_15938,_16097,_16082,_16118),
    cc(om,_16118,_16146),
    !,
    pushstack(free,[dette],nil,_16146,_16165),[],
    pushstack(free,[om],nil,_16165,_16179),[],
    pushstack(free,np_kernel(0,_15937,_15938),nil,_16179,_16225),[],
    pushstack(first,([_15927],w(verb(have,_15911,fin))),nil,_16225,_16236),
    state(_15872,_15873,_16226,_16236,_15985).

statem(_15872,_15873,[statem,_15992,_16031,lit(det),_16066,_16105,_16134,!,_16173],_15975,_15977) --> 
    preadverbial1(_15915,_15916,_15917,_15992,_15975,_16013),
    blei(_16031,_16013,_16046),
    cc(det,_16046,_16065),
    preadverbial0(_15911,_15912,_15913,_16066,_16065,_16087),
    w(verb(_15927,past,part),_16105,_16087,_16122),
    object(_15931,_15932,_16134,_16122,_16153),
    !,
    pushstack(first,(xnp(_15931,_15932),w(verb(be,pres,fin)),w(verb(_15927,past,part)),adverbial1(_15915,_15916,_15917),adverbial1(_15911,_15912,_15913)),nil,_16153,_16278),
    state(_15872,_15873,_16173,_16278,_15977).

statem(_15872,_15873,[statem,_16027,_16056,_16090,_16119,_16153,_16187,_16216,_16260,!,_16294],_16010,_16012) --> 
    not_look_ahead([det],_16027,_16010,_16044),
    obvious_object(_15920,_15921,_16056,_16044,_16075),
    w(verb(_15932,_15933,fin),_16090,_16075,_16107),
    gmem(_15932,[want,wish,need],_16119,_16107,_16138),
    lit_of(_15945,[jeg,vi,han,hun,du],_16153,_16138,_16172),
    negation0(_15958,_16187,_16172,_16204),
    optional([å],_16216,_16204,_16248),
    w(verb(_15966,inf,fin),_16260,_16248,_16277),
    !,
    pushstack(first,([_15945],w(verb(_15932,_15933,fin)),negation(_15958),[å],w(verb(_15966,_15933,fin)),xnp(_15920,_15921)),nil,_16277,_16365),
    state(_15872,_15873,_16294,_16365,_16012).

statem(_15872,_15873,[statem,_15994,_16023,_16057,_16086,_16120,_16154,!,_16188],_15977,_15979) --> 
    not_look_ahead([det],_15994,_15977,_16011),
    obvious_object(_15905,_15906,_16023,_16011,_16042),
    w(verb(_15917,_15918,fin),_16057,_16042,_16074),
    gmem(_15917,[have,get],_16086,_16074,_16105),
    lit_of(_15928,[jeg,vi,han,hun,du],_16120,_16105,_16139),
    w(verb(_15943,past,part),_16154,_16139,_16171),
    !,
    pushstack(first,([_15928],w(verb(_15943,_15918,fin)),xnp(_15905,_15906)),nil,_16171,_16229),
    state(_15872,_15873,_16188,_16229,_15979).

statem(_15872,_15873,[statem,_15997,_16026,_16060,{},_16099,_16133,!,_16167],_15980,_15982) --> 
    not_look_ahead([det],_15997,_15980,_16014),
    obvious_object(_15908,_15909,_16026,_16014,_16045),
    w(verb(_15920,_15921,fin),_16060,_16045,_16077),
    {user:(\+testmember(_15920,[give]))},
    lit_of(_15933,[jeg,vi,han,hun,du],_16099,_16077,_16118),
    negation0(_15946,_16133,_16118,_16150),
    !,
    pushstack(first,([_15933],w(verb(_15920,_15921,fin)),negation(_15946),xnp(_15908,_15909)),nil,_16150,_16238),
    state(_15872,_15873,_16167,_16238,_15982).

statem(_15872,_15873,[statem,_16031,_16060,_16094,_16123,_16157,_16191,_16235,_16264,!,_16298],_16014,_16016) --> 
    not_look_ahead([det],_16031,_16014,_16048),
    obvious_object(_15920,_15921,_16060,_16048,_16079),
    w(verb(_15932,_15933,fin),_16094,_16079,_16111),
    gmem(_15932,[want,wish,need],_16123,_16111,_16142),
    lit_of(_15945,[jeg,vi,han,hun,du],_16157,_16142,_16176),
    optional([å],_16191,_16176,_16223),
    w(verb(_15964,inf,fin),_16235,_16223,_16252),
    w(prep(_15970),_16264,_16252,_16281),
    !,
    pushstack(first,([_15945],w(verb(_15932,_15933,fin)),[å],w(verb(_15964,_15933,fin)),w(prep(_15970)),xnp(_15920,_15921)),nil,_16281,_16339),
    state(_15872,_15873,_16298,_16339,_16016).

statem(_15872,_15873,[statem,_15975,lit(kan),_16020,_16054,!,_16088],_15958,_15960) --> 
    obvious_object(_15899,_15900,_15975,_15958,_15994),
    cc(kan,_15994,_16019),
    lit_of(_15907,[jeg,vi,han,hun,du],_16020,_16019,_16039),
    not_look_ahead(w(verb(_15924,_15925,_15926)),_16054,_16039,_16071),
    !,
    pushstack(first,([_15907],w(verb(do1,pres,fin)),xnp(_15899,_15900)),nil,_16071,_16129),
    state(_15872,_15873,_16088,_16129,_15960).

statem(_15872,_15873,[statem,_15978,_16007,_16041,_16065,_16099,!,_16133],_15961,_15963) --> 
    not_look_ahead([det],_15978,_15961,_15995),
    obvious_object(_15902,_15903,_16007,_15995,_16026),
    aux1(_16041,_16026,_16056),
    lit_of(_15912,[jeg,vi,han,hun,du],_16065,_16056,_16084),
    w(verb(_15927,inf,fin),_16099,_16084,_16116),
    !,
    pushstack(first,([_15912],w(verb(_15927,pres,fin)),xnp(_15902,_15903)),nil,_16116,_16174),
    state(_15872,_15873,_16133,_16174,_15963).

statem(_15872,_15873,[statem,_15978,_16007,_16041,_16065,_16099,!,_16133],_15961,_15963) --> 
    not_look_ahead([det],_15978,_15961,_15995),
    obvious_object(_15902,_15903,_16007,_15995,_16026),
    aux1(_16041,_16026,_16056),
    lit_of(_15912,[jeg,vi,han,hun,du],_16065,_16056,_16084),
    w(verb(_15927,inf,fin),_16099,_16084,_16116),
    !,
    pushstack(first,([_15912],w(verb(_15927,pres,fin)),xnp(_15902,_15903)),nil,_16116,_16174),
    state(_15872,_15873,_16133,_16174,_15963).

statem(_15872,_15873,[statem,lit(det),lit(som),!,_15974],_15930,_15932) --> 
    cc(det,_15930,_15957),
    cc(som,_15957,_15968),
    !,
    pushstack(first,([en],w(noun(thing,sin,u,n)),[som]),nil,_15968,_15984),
    state(_15872,_15873,_15974,_15984,_15932).

statem(_15872,_15873,[statem,_15968,_15997,_16021,lit(å),!,_16066],_15951,_15953) --> 
    one_of_lit([nå,så,da,redundant0],_15968,_15951,_15985),
    shoulditbe(_15997,_15985,_16012),
    w(adj2(_15913,_15914),_16021,_16012,_16038),
    cc(å,_16038,_16060),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_15913,_15914)),[å]),nil,_16060,_16076),
    itstatem(_15872,_15873,_16066,_16076,_15953).

statem(_15872,_15873,[statem,_15940,_15969,_15993,!],_15923,_15925) --> 
    one_of_lit([nå,så,da],_15940,_15923,_15957),
    shoulditbe(_15969,_15957,_15984),
    pushstack(first,w(verb(be,pres,fin)),nil,_15984,_16006),itstatem(_15872,_15873,_15993,_16006,_15925),
    !.

shoulditbe([shoulditbe,_15912,_15941,lit(det)],_15901,_15903) --> 
    w(verb(be,_15883,fin),_15912,_15901,_15929),
    redundant0(_15941,_15929,_15956),
    cc(det,_15956,_15903).

shoulditbe([shoulditbe,_15915,_15939,lit(det),_15974],_15904,_15906) --> 
    aux1(_15915,_15904,_15930),
    redundant0(_15939,_15930,_15954),
    cc(det,_15954,_15973),
    w(verb(be,inf,fin),_15974,_15973,_15906).

shoulditbe([shoulditbe,_15916,lit(det),_15956],_15905,_15907) --> 
    one_of_lit([kan,kunne,får,fikk],_15916,_15905,_15933),
    cc(det,_15933,_15955),
    vaere(_15956,_15955,_15907).

vaere([vaere,_15908],_15897,_15899) --> 
    one_of_lit([være,vært,bli,blitt],_15908,_15897,_15899).

statem(_15872,_15873,[statem,lit(det),_15991,_16015,_16049,{},{},!,_16103],_15963,_15965) --> 
    cc(det,_15963,_15990),
    aux1(_15991,_15990,_16006),
    subject(_15909,_15910,_16015,_16006,_16034),
    w(verb(_15914,inf,fin),_16049,_16034,_16066),
    {user:testmember(_15914,[believe,know])},
    {user:verbtype(_15914,rv)},
    !,
    pushstack(first,(xnp(_15909,_15910),w(verb(_15914,pres,fin)),[dette]),nil,_16066,_16144),
    state(_15872,_15873,_16103,_16144,_15965).

statem(_15872,_15873,[statem,_15984,_16018,{},{},_16067,!,_16106],_15967,_15969) --> 
    obvious_object(_15905,_15906,_15984,_15967,_16003),
    w(verb(_15913,_15914,fin),_16018,_16003,_16035),
    {user:testmember(_15913,[believe,know])},
    {user:verbtype(_15913,rv)},
    subject(_15931,_15932,_16067,_16035,_16086),
    !,
    pushstack(first,(xnp(_15931,_15932),w(verb(_15913,_15914,fin)),[at],xnp(_15905,_15906)),nil,_16086,_16178),
    state(_15872,_15873,_16106,_16178,_15969).

statem(_15872,_15873,[statem,_15962,_15996,_16020,_16054,!,_16088],_15945,_15947) --> 
    obvious_object(_15899,_15900,_15962,_15945,_15981),
    has(_15996,_15981,_16011),
    subject(_15905,_15906,_16020,_16011,_16039),
    w(verb(_15910,past,part),_16054,_16039,_16071),
    !,
    pushstack(first,(xnp(_15905,_15906),w(verb(_15910,past,fin)),xnp(_15899,_15900)),nil,_16071,_16160),
    state(_15872,_15873,_16088,_16160,_15947).

statem(_15872,_15873,[statem,lit(å),_15985,_16014,_16057,!,_16091],_15957,_15959) --> 
    cc(å,_15957,_15984),
    w(verb(_15903,inf,fin),_15985,_15984,_16002),
    pushstack(first,([noen],w(verb(_15903,pres,fin))),nil,_16002,_16027),clausal_object1(_15893,_15896::_15897,_16014,_16027,_16042),
    look_ahead(w(verb(be,pres,fin)),_16057,_16042,_16074),
    !,
    pushstack(first,xnp(_15893,_15896::_15897),nil,_16074,_16132),
    state(_15872,_15873,_16091,_16132,_15959).

statem(_15872,_15873,[statem,lit(det),_15987,lit(seg),_16027,_16056,lit(å),!,_16101,!],_15959,_15961) --> 
    cc(det,_15959,_15986),
    w(verb(let,_15904,fin),_15987,_15986,_16004),
    cc(seg,_16004,_16026),
    negation0(_15909,_16027,_16026,_16044),
    w(verb(do1,inf,fin),_16056,_16044,_16073),
    cc(å,_16073,_16095),
    !,
    pushstack(first,(w(noun(agent,sin,u,n)),aux1,negation(_15909)),nil,_16095,_16172),state(_15872,_15873,_16101,_16172,_15961),
    !.

statem(_15872,_15873,[statem,_15917,_15941],_15900,_15902) --> 
    soredundant(_15917,_15900,_15932),
    sostatem(_15872,_15873,_15941,_15932,_15902).

statem(_15872,_15873,[statem,_15967,_15996,{},_16035,_16074],_15950,_15952) --> 
    w(noun(_15899,_15900,_15901,n),_15967,_15950,_15984),
    look_ahead(w(prep(_15893)),_15996,_15984,_16013),
    {user:testmember(_15893,[at])},
    pp(_15893,_15894,_15895,_16035,_16013,_16056),
    pushstack(free,(w(noun(_15899,_15900,_15901,n)),pp(_15893,_15894,_15895)),nil,_16056,_16117),
    state(_15872,_15873,_16074,_16117,_15952).

statem(_15872,_15873,[statem,_15991,_16025,{},_16064,_16098,!,_16132,!],_15974,_15976) --> 
    lit_of(_15896,[dette],_15991,_15974,_16010),
    w(verb(_15903,_15904,fin),_16025,_16010,_16042),
    {user:(\+testmember(_15903,[be,give,take,cost]))},
    subject(_15922,_15923,_16064,_16042,_16083),
    negation0(_15925,_16098,_16083,_16115),
    !,
    pushstack(first,(xnp(_15922,_15923),w(verb(_15903,_15904,fin)),negation(_15925),[_15896]),nil,_16115,_16206),state(_15872,_15873,_16132,_16206,_15976),
    !.

statem(_15872,_15873,[statem,_15983,{},_16022,!,_16056],_15966,_15968) --> 
    w(adj2(_15905,nil),_15983,_15966,_16000),
    {user:testmember(_15905,[good,bad,correct,true,mild,hot,cold])},
    w(prep(_15901),_16022,_16000,_16039),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_15905,nil)),w(prep(_15901))),nil,_16039,_16066),
    state(_15872,_15873,_16056,_16066,_15968).

statem(_15872,_15873,[statem,_15983,{},_16022,!,_16056],_15966,_15968) --> 
    w(adj2(_15905,nil),_15983,_15966,_16000),
    {user:testmember(_15905,[good,bad,correct,true,mild,hot,cold])},
    w(adv(_15901),_16022,_16000,_16039),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_15905,nil)),w(adv(_15901))),nil,_16039,_16066),
    state(_15872,_15873,_16056,_16066,_15968).

statem(_15872,_15873,[statem,_15947,_15971,_16000,!,_16034,!,_16112],_15930,_15932) --> 
    init(_15947,_15930,_15962),
    negation(_15893,_15971,_15962,_15988),
    not_look_ahead(w(verb(_15899,_15900,pass)),_16000,_15988,_16017),
    !,
    pushstack(free,negation(_15893),nil,_16017,_16077),itstatem(_15872,_15873,_16034,_16077,_16092),
    !,
    accept(_16112,_16092,_15932).

statem(_15872,_15873,[statem,_15956,_15980,_16004,_16028,_16057,!,[],_16110],_15939,_15941) --> 
    redundants0(_15956,_15939,_15971),
    dette(_15980,_15971,_15995),
    aux1(_16004,_15995,_16019),
    not_look_ahead([være],_16028,_16019,_16045),
    obvious_object(_15906,_15907,_16057,_16045,_16076),
    !,
    pushstack(free,[dette],nil,_16076,_16109),[],
    pushstack(first,(xnp(_15906,_15907),aux1),nil,_16109,_16179),
    state(_15872,_15873,_16110,_16179,_15941).

statem(_15872,_15873,[statem,_15926,!,_15955,!,_15994],_15909,_15911) --> 
    init(_15926,_15909,_15941),
    !,
    itstatem(_15872,_15873,_15955,_15941,_15974),
    !,
    accept(_15994,_15974,_15911).

statem(_15872,_15875::_15876,[statem,_15926,!,_15965],_15909,_15911) --> 
    state(_15872,_15875::_15876,_15926,_15909,_15945),
    !,
    accept(_15965,_15945,_15911).

statem(_15872,_15875::_15876,[statem,_16019,_16053,_16082,_16106,_16135,lit(å),{},[],{},_16240,{}],_16002,_16004) --> 
    subject(_15914,_15915,_16019,_16002,_16038),
    be(_15910,_16053,_16038,_16070),
    so0(_16082,_16070,_16097),
    gradverb0(_15919,_16106,_16097,_16123),
    w(adj2(_15923,nil),_16135,_16123,_16152),
    cc(å,_16152,_16174),
    {user:testmember(_15923,[difficult,easy,expensive,free,funny,good,intelligent,sad,stupid,tedious])},
    pushstack(free,xnp(_15914,_15915),nil,_16174,_16229),[],
    {user:it_template(_15961)},
    pushstack(first,(w(adj2(_15923,nil)),[å]),nil,_16229,_16253),be_complements(_15961,_15872,_15875::_15911,_16240,_16253,_16004),
    {user:negate(_15910,_15911,_15876)}.

statem(_15872,_15875::_15876,[statem,_15974,_16008,_16032,{},!,_16076,_16100],_15957,_15959) --> 
    np1_accept(_15907,_15908,_15974,_15957,_15993),
    aux1(_16008,_15993,_16023),
    prepnof(_15910,_16032,_16023,_16049),
    {user:testmember(_15910,[on,to,towards])},
    !,
    accept(_16076,_16049,_16091),
    pushstack(first,(np(_15907,_15908),w(verb(go,pres,fin)),prep(to)),nil,_16091,_16174),
    state(_15872,_15875::_15876,_16100,_16174,_15959).

statem(_15872,_15875::_15876,[statem,_15988,_16017,_16046,_16080,_16104,{},_16143],_15971,_15973) --> 
    not_look_ahead([dette],_15988,_15971,_16005),
    not_look_ahead([det],_16017,_16005,_16034),
    np1_accept(_15915,_15916,_16046,_16034,_16065),
    aux1(_16080,_16065,_16095),
    prepnof(_15905,_16104,_16095,_16121),
    {user:testmember(_15905,[to,from,near,in,on,past])},
    pushstack(first,(np(_15915,_15916),w(verb(go,pres,fin)),prep(_15905)),nil,_16121,_16215),
    state(_15872,_15875::_15876,_16143,_16215,_15973).

statem(_15872,_15875::_15876,[statem,_15990,_16019,_16048,_16082,_16111,_16135,_16164,_16193,_16222],_15973,_15975) --> 
    not_look_ahead([dette],_15990,_15973,_16007),
    not_look_ahead([det],_16019,_16007,_16036),
    np1_accept(_15922,_15923,_16048,_16036,_16067),
    not_look_ahead([kan],_16082,_16067,_16099),
    aux1(_16111,_16099,_16126),
    look_ahead([hjem],_16135,_16126,_16152),
    not_look_ahead([kunne],_16164,_16152,_16181),
    not_look_ahead(w(verb(_15941,_15942,_15943)),_16193,_16181,_16210),
    pushstack(first,(np(_15922,_15923),w(verb(go,pres,fin))),nil,_16210,_16263),
    state(_15872,_15875::_15876,_16222,_16263,_15975).

statem(_15872,_15873,[statem,_15943,_15967,_15991,[],_16039],_15926,_15928) --> 
    dedette(_15943,_15926,_15958),
    aux1(_15967,_15958,_15982),
    np1_accept(_15893,_15894,_15991,_15982,_16010),
    pushstack(free,[dette],nil,_16010,_16038),[],
    pushstack(first,(xnp(_15893,_15894),aux1),nil,_16038,_16108),
    state(_15872,_15873,_16039,_16108,_15928).

dedette([dedette,lit(det)],_15889,_15891) --> 
    cc(det,_15889,_15891).

dedette([dedette,lit(dette)],_15889,_15891) --> 
    cc(dette,_15889,_15891).

soredundant0([soredundant0,_15901,!],_15890,_15892) --> 
    soredundant(_15901,_15890,_15892),
    !.

soredundant([soredundant,lit(når),!],_15892,_15894) --> 
    cc(når,_15892,_15894),
    !.

soredundant([soredundant,_15901,!],_15890,_15892) --> 
    so(_15901,_15890,_15892),
    !.

soredundant([soredundant,_15898],_15887,_15889) --> 
    redundant(_15898,_15887,_15889).

so([so,lit(så),!],_15892,_15894) --> 
    cc(så,_15892,_15894),
    !.

so([so,lit(derfor),!],_15892,_15894) --> 
    cc(derfor,_15892,_15894),
    !.

so([so,_15910],_15899,_15901) --> 
    look_ahead_lit([kan,må,vil,skal,bør],_15910,_15899,_15901).

so([so,_15906],_15895,_15897) --> 
    look_ahead(w(verb(know,_15877,fin)),_15906,_15895,_15897).

statem(_15872,_15875::_15876,[statem,_15964,_16003,lit(kan),_16038,_16062,_16096,_16120],_15947,_15949) --> 
    adverbx(_15905,_15906,pre,_15964,_15947,_15985),
    saa0(_16003,_15985,_16018),
    cc(kan,_16018,_16037),
    redundant0(_16038,_16037,_16053),
    np1_accept(_15914,_15915,_16062,_16053,_16081),
    redundant0(_16096,_16081,_16111),
    pushstack(free,(noun_phrase1(_15914,_15915),[kan],xadverb(_15905,_15906)),nil,_16111,_16196),
    state(_15872,_15875::_15876,_16120,_16196,_15949).

statem(_15872,_15875::_15876,[statem,_15960,_15999,_16023,_16047,_16071,_16105,_16129],_15943,_15945) --> 
    adverbx(_15905,_15906,pre,_15960,_15943,_15981),
    saa0(_15999,_15981,_16014),
    aux1(_16023,_16014,_16038),
    redundant0(_16047,_16038,_16062),
    np1_accept(_15912,_15913,_16071,_16062,_16090),
    redundant0(_16105,_16090,_16120),
    pushstack(free,(noun_phrase1(_15912,_15913),aux1,xadverb(_15905,_15906)),nil,_16120,_16229),
    state(_15872,_15875::_15876,_16129,_16229,_15945).

statem(_15872,_15875::_15876,[statem,_15963,_16002,_16026,lit(jeg),_16061,!,_16090,_16114],_15946,_15948) --> 
    adverbx(_15908,_15909,pre,_15963,_15946,_15984),
    saa0(_16002,_15984,_16017),
    aux1(_16026,_16017,_16041),
    cc(jeg,_16041,_16060),
    redundant0(_16061,_16060,_16076),
    !,
    accept(_16090,_16076,_16105),
    pushstack(free,([jeg],[skal],xadverb(_15908,_15909)),nil,_16105,_16155),
    state(_15872,_15875::_15876,_16114,_16155,_15948).

statem(_15872,_15875::_15876,[statem,lit(at),_15950,_15984,{}],_15922,_15924) --> 
    cc(at,_15922,_15949),
    statem(_15872,_15875::_15890,_15950,_15949,_15969),
    be_truefalse(_15889,_15984,_15969,_15924),
    {user:negate(_15889,_15890,_15876)}.

statem(_15872,_15875::_15876,[statem,_15964,_16003,_16027,_16056,_16085],_15947,_15949) --> 
    adverbx(_15899,_15900,pre,_15964,_15947,_15985),
    saa0(_16003,_15985,_16018),
    w(verb(_15908,_15909,_15910),_16027,_16018,_16044),
    negation0(_15912,_16056,_16044,_16073),
    lock(last,_16073,_16163),
    pushstack(last,(w(verb(_15908,_15909,_15910)),negation(_15912),xadverb(_15899,_15900)),nil,_16163,_16169),
    state(_15872,_15875::_15876,_16085,_16169,_16158),
    unlock(_16158,_15949).

statem(_15872,_15875::_15876,[statem,_15975,_16014,_16043,_16077,!,_16111],_15958,_15960) --> 
    adverbx(_15902,_15903,pre,_15975,_15958,_15996),
    w(verb(be,_15912,fin),_16014,_15996,_16031),
    np1_accept(_15915,_15916,_16043,_16031,_16062),
    w(verb(_15920,_15921,part),_16077,_16062,_16094),
    !,
    lock(last,_16094,_16190),
    pushstack(last,(np(_15915,_15916),w(verb(_15920,_15921,fin)),xadverb(_15902,_15903)),nil,_16190,_16196),
    state(_15872,_15875::_15876,_16111,_16196,_16185),
    unlock(_16185,_15960).

statem(_15872,_15875::_15876,[statem,_15967,_16006,_16030,_16064,!,_16098],_15950,_15952) --> 
    adverbx(_15902,_15903,pre,_15967,_15950,_15988),
    be(_16006,_15988,_16021),
    specific_phrase(_15909,_15912::_15913,_16030,_16021,_16049),
    negation0(_15915,_16064,_16049,_16081),
    !,
    pushstack(free,(np(_15909,_15912::_15913),be(_15915),xadverb(_15902,_15903)),nil,_16081,_16203),
    state(_15872,_15875::_15876,_16098,_16203,_15952).

statem(_15872,_15875::_15876,[statem,_15955,_15994,_16023,!,_16057],_15938,_15940) --> 
    adverbx(_15896,_15897,pre,_15955,_15938,_15976),
    w(verb(be,_15906,fin),_15994,_15976,_16011),
    negation0(_15909,_16023,_16011,_16040),
    !,
    pushstack(free,(be(_15909),xadverb(_15896,_15897)),nil,_16040,_16128),
    state(_15872,_15875::_15876,_16057,_16128,_15940).

statem(_15872,_15875::_15876,[statem,_15939,_15978,_16002,_16026],_15922,_15924) --> 
    adverbx(_15890,_15891,pre,_15939,_15922,_15960),
    saa0(_15978,_15960,_15993),
    do(_16002,_15993,_16017),
    pushstack(free,xadverb(_15890,_15891),nil,_16017,_16067),
    state(_15872,_15875::_15876,_16026,_16067,_15924).

statem(_15872,_15873,[statem,_15960,_15999,_16023,_16057,_16086],_15943,_15945) --> 
    adverbx(_15896,_15897,pre,_15960,_15943,_15981),
    has(_15999,_15981,_16014),
    specific_phrase(_15903,_15904,_16023,_16014,_16042),
    w(verb(_15908,past,part),_16057,_16042,_16074),
    lock(last,_16074,_16165),
    pushstack(last,(xnp(_15903,_15904),w(verb(_15908,past,fin)),xadverb(_15896,_15897)),nil,_16165,_16171),
    state(_15872,_15873,_16086,_16171,_16160),
    unlock(_16160,_15945).

statem(_15872,_15873,[statem,_15946,_15985,_16014],_15929,_15931) --> 
    preadverbial1(_15887,_15888,_15889,_15946,_15929,_15967),
    w(verb(be,pres,fin),_15985,_15967,_16002),
    pushstack(free,(w(verb(be,pres,fin)),adverbial1(_15887,_15888,_15889)),nil,_16002,_16056),
    state(_15872,_15873,_16014,_16056,_15931).

statem(_15872,_15873,[statem,_15926,_15950,!,_15979,_16003],_15909,_15911) --> 
    preadverbials0(_15926,_15909,_15941),
    aux1(_15950,_15941,_15965),
    !,
    accept(_15979,_15965,_15994),
    state(_15872,_15873,_16003,_15994,_15911).

statem(_15872,_15875::_15876,[statem,_15952,_15991,!,_16020],_15935,_15937) --> 
    adverbial1(_15896,_15897,_15900::_15901,_15952,_15935,_15973),
    be(_15991,_15973,_16006),
    !,
    pushstack(free,(thereit,be,adverbial1(_15896,_15897,_15900::_15901)),nil,_16006,_16125),
    statem(_15872,_15875::_15876,_16020,_16125,_15937).

statem(_15872,_15875::_15876,[statem,_15987,_16026,_16050,_16084,!,_16118],_15970,_15972) --> 
    preadverbial1(_15905,_15906,_15909::_15910,_15987,_15970,_16008),
    do(_16026,_16008,_16041),
    specific_phrase(_15919,_15922::_15923,_16050,_16041,_16069),
    w(prep(_15927),_16084,_16069,_16101),
    !,
    pushstack(free,(np(_15919,_15922::_15923),w(verb(go,pres,fin)),w(prep(_15927)),adverbial1(_15905,_15906,_15909::_15910)),nil,_16101,_16197),
    state(_15872,_15875::_15876,_16118,_16197,_15972).

statem(_15872,_15875::_15876,[statem,_15946,_15985,!,_16014],_15929,_15931) --> 
    preadverbial1(_15890,_15891,_15894::_15895,_15946,_15929,_15967),
    do(_15985,_15967,_16000),
    !,
    pushstack(free,adverbial1(_15890,_15891,_15894::_15895),nil,_16000,_16059),
    state(_15872,_15875::_15876,_16014,_16059,_15931).

statem(_15872,_15873,[statem,_15964,_16003,_16027,_16056,!,_16095],_15947,_15949) --> 
    preadverbial1(_15899,_15900,_15901,_15964,_15947,_15985),
    so0(_16003,_15985,_16018),
    w(verb(have,_15910,fin),_16027,_16018,_16044),
    subject(_15913,_15914,_16056,_16044,_16075),
    !,
    pushstack(free,(xnp(_15913,_15914),w(verb(have,_15910,fin)),adverbial1(_15899,_15900,_15901)),nil,_16075,_16168),
    state(_15872,_15873,_16095,_16168,_15949).

statem(_15872,_15875::_15876,[statem,{},_16003,_16042,_16081,!,_16130,_16154],_15976,_15978) --> 
    {user:value(dialog,1)},
    preadverbial1(_15920,_15921,_15924::_15925,_16003,_15976,_16024),
    preadverbial1(_15905,_15906,_15909::_15910,_16042,_16024,_16063),
    lexv(_15934,_15935,_15936,fin,_16081,_16063,_16104),
    !,
    accept(_16130,_16104,_16145),
    lock(last,_16145,_16272),
    pushstack(last,(lexv(_15934,_15935,_15936,fin),adverbial1(_15920,_15921,_15924::_15925),adverbial1(_15905,_15906,_15909::_15910)),nil,_16272,_16278),
    state(_15872,_15875::_15876,_16154,_16278,_16267),
    unlock(_16267,_15978).

prestatem(_15872,_15873,[prestatem,_15966,_15995,lit(det),_16040,!,_16074],_15949,_15951) --> 
    w(verb(_15903,_15904,fin),_15966,_15949,_15983),
    gmem(_15903,[be,stand],_15995,_15983,_16014),
    cc(det,_16014,_16039),
    w(adj2(_15898,_15899),_16040,_16039,_16057),
    !,
    pushstack(first,(w(verb(be,_15904,fin)),w(adj2(_15898,_15899))),nil,_16057,_16084),
    itstatem(_15872,_15873,_16074,_16084,_15951).

prestatem(_15872,_15873,[prestatem,_15993,_16017,_16041,_16070,_16094,_16128,_16152,{},_16191,!,_16230],_15976,_15978) --> 
    so0(_15993,_15976,_16008),
    aux1(_16017,_16008,_16032),
    negation0(_15920,_16041,_16032,_16058),
    redundant0(_16070,_16058,_16085),
    object(_15917,_15918,_16094,_16085,_16113),
    redundant0(_16128,_16113,_16143),
    w(verb(_15927,_15928,pass),_16152,_16143,_16169),
    {user:(\+testmember(_15927,[be]))},
    whodidit(_15940,_15941,_16191,_16169,_16210),
    !,
    pushstack(first,(xnp(_15940,_15941),w(verb(_15927,_15928,fin)),negation(_15920),xnp(_15917,_15918)),nil,_16210,_16332),
    state(_15872,_15873,_16230,_16332,_15978).

prestatem(_15872,_15873,[prestatem,_15953,_15977,_16006,!,_16050],_15936,_15938) --> 
    shoulditbe(_15953,_15936,_15968),
    not_look_ahead(w(adj2(_15901,_15902)),_15977,_15968,_15994),
    adverbix0(_15893,_15894,_15895,_16006,_15994,_16027),
    !,
    pushstack(free,(w(verb(be,pres,fin)),xadverbial1(_15893,_15894,_15895)),nil,_16027,_16092),
    itstatem(_15872,_15873,_16050,_16092,_15938).

prestatem(_15872,_15873,[prestatem,_15934,lit(det),_15974,!,_16003],_15917,_15919) --> 
    w(verb(be,_15893,fin),_15934,_15917,_15951),
    cc(det,_15951,_15973),
    slikat(_15974,_15973,_15989),
    !,
    state(_15872,_15873,_16003,_15989,_15919).

prestatem(_15872,_15873,[prestatem,_15977,_16006,lit(det),_16051,_16075,_16104,!,_16133,_16167],_15960,_15962) --> 
    w(verb(_15913,_15914,fin),_15977,_15960,_15994),
    gmem(_15913,[have,be],_16006,_15994,_16025),
    cc(det,_16025,_16050),
    redundant0(_16051,_16050,_16066),
    w(verb(_15907,past,part),_16075,_16066,_16092),
    look_ahead_np(_16104,_16092,_16119),
    !,
    subject(_15932,_15933,_16133,_16119,_16152),
    pushstack(first,(xnp(_15932,_15933),w(verb(_15907,past,fin))),nil,_16152,_16208),
    state(_15872,_15873,_16167,_16208,_15962).

prestatem(_15872,_15873,[prestatem,_15962,_15986,_16020,_16049,!,_16088],_15945,_15947) --> 
    has(_15962,_15945,_15977),
    subject(_15902,_15903,_15986,_15977,_16005),
    w(verb(_15907,past,part),_16020,_16005,_16037),
    object(_15899,_15900,_16049,_16037,_16068),
    !,
    pushstack(first,(xnp(_15902,_15903),w(verb(_15907,past,fin)),xnp(_15899,_15900)),nil,_16068,_16160),
    state(_15872,_15873,_16088,_16160,_15947).

prestatem(_15872,_15873,[prestatem,_15980,{},_16019,_16053,_16082,!,_16121],_15963,_15965) --> 
    w(verb(_15907,_15908,fin),_15980,_15963,_15997),
    {user:(\+member(_15907,[]))},
    subject(_15918,_15919,_16019,_15997,_16038),
    not_look_ahead(w(verb(_15925,_15926,_15927)),_16053,_16038,_16070),
    object(_15902,_15903,_16082,_16070,_16101),
    !,
    pushstack(first,(xnp(_15918,_15919),w(verb(_15907,past,fin)),xnp(_15902,_15903)),nil,_16101,_16193),
    state(_15872,_15873,_16121,_16193,_15965).

prestatem(_15872,_15873,[prestatem,_15983,_16012,_16041,_16065,lit(det),_16105,_16129,!,_16163],_15966,_15968) --> 
    not_look_ahead(w(verb(be,_15915,_15916)),_15983,_15966,_16000),
    not_look_ahead(w(verb(be1,_15923,_15924)),_16012,_16000,_16029),
    so0(_16041,_16029,_16056),
    w(verb(_15928,_15929,fin),_16065,_16056,_16082),
    cc(det,_16082,_16104),
    not_look_ahead_np(_16105,_16104,_16120),
    negation0(_15908,_16129,_16120,_16146),
    !,
    pushstack(first,([dette],w(verb(_15928,_15929,fin)),negation(_15908)),nil,_16146,_16203),
    state(_15872,_15873,_16163,_16203,_15968).

prestatem(_15872,_15873,[prestatem,_15979,_16008,_16037,_16061,_16090,_16114,_16148,!,_16182],_15962,_15964) --> 
    not_look_ahead(w(verb(be,_15912,_15913)),_15979,_15962,_15996),
    not_look_ahead(w(verb(be1,_15920,_15921)),_16008,_15996,_16025),
    so0(_16037,_16025,_16052),
    w(verb(_15925,_15926,fin),_16061,_16052,_16078),
    det0(_16090,_16078,_16105),
    particlev0(_15925,_15930,_16114,_16105,_16133),
    negation0(_15905,_16148,_16133,_16165),
    !,
    pushstack(free,(w(verb(_15930,_15926,fin)),negation(_15905)),nil,_16165,_16222),
    state(_15872,_15873,_16182,_16222,_15964).

prestatem(_15872,_15873,[prestatem,_15980,_16004,{},_16043,_16067,!,_16101,_16135],_15963,_15965) --> 
    so0(_15980,_15963,_15995),
    w(verb(_15913,_15914,pass),_16004,_15995,_16021),
    {user:(\+testmember(_15913,[be]))},
    thereit0(_16043,_16021,_16058),
    negation0(_15926,_16067,_16058,_16084),
    !,
    object(_15908,_15909,_16101,_16084,_16120),
    pushstack(first,([noen],w(verb(_15913,_15914,fin)),negation(_15926),xnp(_15908,_15909)),nil,_16120,_16206),
    state(_15872,_15873,_16135,_16206,_15965).

prestatem(_15872,_15873,[prestatem,_15957,_15986,!,_16020,_16054],_15940,_15942) --> 
    w(verb(be,_15901,fin),_15957,_15940,_15974),
    negation0(_15896,_15986,_15974,_16003),
    !,
    subject(_15906,_15907,_16020,_16003,_16039),
    pushstack(first,(xnp(_15906,_15907),w(verb(be,_15901,fin)),negation(_15896)),nil,_16039,_16125),
    state(_15872,_15873,_16054,_16125,_15942).

prestatem(_15872,_15873,[prestatem,_15967,lit(kan),_16002,_16036,_16060,_16089,!,_16123],_15950,_15952) --> 
    so0(_15967,_15950,_15982),
    cc(kan,_15982,_16001),
    subject(_15910,_15911,_16002,_16001,_16021),
    redundant0(_16036,_16021,_16051),
    not_look_ahead(w(verb(_15917,_15918,_15919)),_16060,_16051,_16077),
    not_look_ahead([ikke],_16089,_16077,_16106),
    !,
    pushstack(free,(xnp(_15910,_15911),w(verb(do1,pres,fin))),nil,_16106,_16164),
    state(_15872,_15873,_16123,_16164,_15952).

prestatem(_15872,_15873,[prestatem,_15948,_15972,_15996,_16030,!,_16064],_15931,_15933) --> 
    so0(_15948,_15931,_15963),
    aux1(_15972,_15963,_15987),
    subject(_15901,_15902,_15996,_15987,_16015),
    negation0(_15899,_16030,_16015,_16047),
    !,
    pushstack(free,(xnp(_15901,_15902),aux1,negation(_15899)),nil,_16047,_16163),
    state(_15872,_15873,_16064,_16163,_15933).

itstatem(_15872,_15873,[itstatem,_15964,_15988,lit(at),_16033,!,_16072,_16106],_15947,_15949) --> 
    be(_15964,_15947,_15979),
    np0_accept(_15902,_15903,_15988,_15979,_16007),
    cc(at,_16007,_16032),
    traceprint(4,it00,_16033,_16032,_16052),
    !,
    clausal_object1(_15913,_15914,_16072,_16052,_16091),
    pushstack(first,(xnp(_15913,_15914),w(verb(be,pres,fin)),xnp(_15902,_15903)),nil,_16091,_16178),
    state(_15872,_15873,_16106,_16178,_15949).

itstatem(_15872,_15873,[itstatem,_15948,_15972,_16001,_16025,!,_16064],_15931,_15933) --> 
    be(_15948,_15931,_15963),
    not_look_ahead(w(adj2(_15903,_15904)),_15972,_15963,_15989),
    look_ahead_np(_16001,_15989,_16016),
    traceprint(4,it01,_16025,_16016,_16044),
    !,
    pushstack(free,w(verb(exist,pres,fin)),nil,_16044,_16074),
    state(_15872,_15873,_16064,_16074,_15933).

itstatem(_15872,_15873,[itstatem,_15952,{},_15991,_16015,!,_16054],_15935,_15937) --> 
    w(verb(_15895,_15896,fin),_15952,_15935,_15969),
    {user:_15895\==be},
    look_ahead_np(_15991,_15969,_16006),
    traceprint(4,it02,_16015,_16006,_16034),
    !,
    pushstack(free,w(verb(_15895,_15896,fin)),nil,_16034,_16064),
    state(_15872,_15873,_16054,_16064,_15937).

itstatem(_15872,_15873,[itstatem,_15979,_16008,{},_16067,_16101,!,_16140],_15962,_15964) --> 
    negation0(_15904,_15979,_15962,_15996),
    hlexv(_15906,_15907,_15908,fin,_15910,_16008,_15996,_16033),
    {user:bigno(_15904,_15910,_15902)},
    gmem(_15907,[help,give,make,create],_16067,_16033,_16086),
    traceprint(4,it0,_16101,_16086,_16120),
    !,
    pushstack(first,([dette],w(verb(_15907,_15908,fin)),negation(_15902)),nil,_16120,_16180),
    state(_15872,_15873,_16140,_16180,_15964).

itstatem(_15872,_15873,[itstatem,_15963,_15992,_16026,_16060,_16094],_15946,_15948) --> 
    w(verb(_15900,_15901,fin),_15963,_15946,_15980),
    gmem(_15900,[have],_15992,_15980,_16011),
    subject(_15909,_15910,_16026,_16011,_16045),
    traceprint(4,it1,_16060,_16045,_16079),
    pushstack(first,(xnp(_15909,_15910),w(verb(_15900,_15901,fin)),[dette]),nil,_16079,_16135),
    state(_15872,_15873,_16094,_16135,_15948).

itstatem(_15872,_15873,[itstatem,_15959,lit(at),_16019,_16043,!,_16082],_15942,_15944) --> 
    lexvaccept(rv,_15902,_15903,fin,_15899,_15959,_15942,_15984),
    cc(at,_15984,_16018),
    look_ahead_np(_16019,_16018,_16034),
    traceprint(4,it2,_16043,_16034,_16062),
    !,
    pushstack(first,([dette],w(verb(_15902,_15903,fin)),negation(_15899)),nil,_16062,_16122),
    state(_15872,_15873,_16082,_16122,_15944).

itstatem(_15872,_15873,[itstatem,_15999,_16023,_16047,_16076,_16105,_16134,lit(som),_16179,_16208,!,_16247,!,_16356],_15982,_15984) --> 
    be(_15999,_15982,_16014),
    redundant0(_16023,_16014,_16038),
    negation0(_15911,_16047,_16038,_16064),
    not_look_ahead(w(nb(_15917,_15918)),_16076,_16064,_16093),
    not_look_ahead_lit([jeg,du],_16105,_16093,_16122),
    np0_accept(_15926,_15927,_16134,_16122,_16153),
    cc(som,_16153,_16178),
    w(verb(_15933,_15934,fin),_16179,_16178,_16196),
    traceprint(4,it3,_16208,_16196,_16227),
    !,
    pushstack(first,(xnp(_15926,_15927),w(verb(_15933,_15934,fin)),negation(_15911)),nil,_16227,_16321),state(_15872,_15873,_16247,_16321,_16336),
    !,
    accept(_16356,_16336,_15984).

itstatem(_15872,_15873,[itstatem,_16002,_16026,_16060,_16089,_16118,_16147,_16176,!,_16215],_15985,_15987) --> 
    be(_16002,_15985,_16017),
    subject(_15919,_15920,_16026,_16017,_16045),
    negation0(_15922,_16060,_16045,_16077),
    not_look_ahead(noun(_15926,_15927,_15928,_15929),_16089,_16077,_16106),
    w(adj2(_15933,nil),_16118,_16106,_16135),
    w(prep(_15938),_16147,_16135,_16164),
    traceprint(4,it4,_16176,_16164,_16195),
    !,
    pushstack(first,(xnp(_15919,_15920),w(verb(be,pres,fin)),negation(_15922),w(adj2(_15933,nil)),w(prep(_15938)),[dette]),nil,_16195,_16286),
    state(_15872,_15873,_16215,_16286,_15987).

itstatem(_15872,_15873,[itstatem,_15971,_15995,_16029,_16058,_16087,!,_16126],_15954,_15956) --> 
    aux1(_15971,_15954,_15986),
    subject(_15907,_15908,_15995,_15986,_16014),
    negation0(_15910,_16029,_16014,_16046),
    w(verb(_15914,_15915,fin),_16058,_16046,_16075),
    traceprint(4,it5,_16087,_16075,_16106),
    !,
    pushstack(first,(xnp(_15907,_15908),w(verb(_15914,pres,fin)),negation(_15910),[dette]),nil,_16106,_16197),
    state(_15872,_15873,_16126,_16197,_15956).

itstatem(_15872,_15873,[itstatem,_15990,_16019,_16048,lit(å),_16088,!,_16127,_16170],_15973,_15975) --> 
    be(_15913,_15990,_15973,_16007),
    gradverb0(_15915,_16019,_16007,_16036),
    w(adj2(_15910,_15911),_16048,_16036,_16065),
    cc(å,_16065,_16087),
    traceprint(4,it7,_16088,_16087,_16107),
    !,
    pushstack(first,([jeg],[vil]),nil,_16107,_16140),clausal_object1(_15935,_15936,_16127,_16140,_16155),
    pushstack(first,(xnp(_15935,_15936),w(verb(be,pres,fin)),negation(_15913),w(adj2(_15910,_15911))),nil,_16155,_16241),
    state(_15872,_15873,_16170,_16241,_15975).

itstatem(_15872,_15873,[itstatem,_15971,_16000,_16044,_16083,!,_16122],_15954,_15956) --> 
    be(_15907,_15971,_15954,_15988),
    ap(_15902,_15903,_15872,_15905,_16000,_15988,_16023),
    pp(with,_15915,_15916,_16044,_16023,_16065),
    traceprint(4,it8,_16083,_16065,_16102),
    !,
    pushstack(first,(xnp(_15915,_15916),w(verb(be,pres,fin)),negation(_15907),ap(_15902,_15903,_15872,_15905)),nil,_16102,_16226),
    state(_15872,_15873,_16122,_16226,_15956).

itstatem(_15872,_15873,[itstatem,_15980,_16009,_16038,lit(at),_16078,!,_16117,_16151],_15963,_15965) --> 
    be(_15913,_15980,_15963,_15997),
    gradverb0(_15915,_16009,_15997,_16026),
    w(adj2(_15910,_15911),_16038,_16026,_16055),
    cc(at,_16055,_16077),
    traceprint(4,it9,_16078,_16077,_16097),
    !,
    clausal_object1(_15927,_15928,_16117,_16097,_16136),
    pushstack(first,(xnp(_15927,_15928),w(verb(be,pres,fin)),negation(_15913),w(adj2(_15910,_15911))),nil,_16136,_16222),
    state(_15872,_15873,_16151,_16222,_15965).

itstatem(_15872,_15873,[itstatem,_16007,_16036,_16065,_16094,_16123,lit(å),_16168,!,_16207,_16231,_16305],_15990,_15992) --> 
    be(_15922,_16007,_15990,_16024),
    gradverb0(_15924,_16036,_16024,_16053),
    w(adj2(_15919,_15920),_16065,_16053,_16082),
    w(prep(for),_16094,_16082,_16111),
    object(_15935,_15936,_16123,_16111,_16142),
    cc(å,_16142,_16167),
    traceprint(4,it10,_16168,_16167,_16187),
    !,
    accept(_16207,_16187,_16222),
    pushstack(first,(xnp(_15935,_15936),[vil]),nil,_16222,_16275),clausal_object1(_15951,_15952,_16231,_16275,_16290),
    pushstack(first,(xnp(_15951,_15952),w(verb(be,pres,fin)),negation(_15922),w(adj2(_15919,_15920))),nil,_16290,_16376),
    state(_15872,_15873,_16305,_16376,_15992).

itstatem(_15872,_15873,[itstatem,_15997,_16026,_16055,lit(å),_16105,!,_16144,_16168,_16211],_15980,_15982) --> 
    be(_15918,_15997,_15980,_16014),
    w(adj2(_15922,_15923),_16026,_16014,_16043),
    pp(_15914,_15915,_15916,_16055,_16043,_16076),
    cc(å,_16076,_16104),
    traceprint(4,it11,_16105,_16104,_16124),
    !,
    accept(_16144,_16124,_16159),
    pushstack(first,[noen],nil,_16159,_16181),clausal_object1(_15939,_15940,_16168,_16181,_16196),
    pushstack(first,(xnp(_15939,_15940),w(verb(be,pres,fin)),negation(_15918),w(adj2(_15922,_15923)),pp(_15914,_15915,_15916)),nil,_16196,_16314),
    state(_15872,_15873,_16211,_16314,_15982).

itstatem(_15872,_15873,[itstatem,_16009,_16038,lit(å),_16093,_16122,_16151,!,_16190,_16233],_15992,_15994) --> 
    be(_15916,_16009,_15992,_16026),
    adj1(_15911,_15923:_15924,_15913,_15914,_16038,_16026,_16061),
    cc(å,_16061,_16092),
    w(verb(_15930,inf,fin),_16093,_16092,_16110),
    reflexiv0(_15930,_16122,_16110,_16139),
    traceprint(4,it12,_16151,_16139,_16170),
    !,
    pushstack(first,([noen],w(verb(_15930,pres,fin))),nil,_16170,_16203),clausal_object1(_15951,_15952,_16190,_16203,_16218),
    pushstack(first,(xnp(_15951,_15952),w(verb(be,pres,fin)),negation(_15916),adj1(_15911,_15923:_15971,_15913,_15914)),nil,_16218,_16340),
    state(_15872,_15873,_16233,_16340,_15994).

itstatem(_15872,_15873,[itstatem,_15966,_15995,_16039,_16063,!,_16102],_15949,_15951) --> 
    be(_15907,_15966,_15949,_15983),
    adj1(_15902,_15903,_15904,_15905,_15995,_15983,_16018),
    not_look_ahead_np(_16039,_16018,_16054),
    traceprint(4,it13,_16063,_16054,_16082),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_15907),adj1(_15902,_15903,_15904,_15905)),nil,_16082,_16173),
    state(_15872,_15873,_16102,_16173,_15951).

itstatem(_15872,_15875::_15876,[itstatem,_16003,_16027,_16051,_16075,_16104,_16133,_16162,_16191,lit(som),_16236,_16270,!,_16379],_15986,_15988) --> 
    be(_16003,_15986,_16018),
    preadverbials0(_16027,_16018,_16042),
    redundant0(_16051,_16042,_16066),
    negation0(_15914,_16075,_16066,_16092),
    not_look_ahead(w(nb(_15920,_15921)),_16104,_16092,_16121),
    not_look_ahead_lit([jeg,du],_16133,_16121,_16150),
    not_look_ahead([det],_16162,_16150,_16179),
    np1_accept(_15933,_15934,_16191,_16179,_16210),
    cc(som,_16210,_16235),
    traceprint(4,it14a,_16236,_16235,_16255),
    pushstack(first,(xnp(_15933,_15934),w(verb(be,pres,fin)),negation(_15914)),nil,_16255,_16344),state(_15872,_15875::_15876,_16270,_16344,_16359),
    !,
    accept(_16379,_16359,_15988).

itstatem(_15872,_15873,[itstatem,_15953,_15977,_16006,_16030,!,_16069],_15936,_15938) --> 
    be(_15953,_15936,_15968),
    negation0(_15899,_15977,_15968,_15994),
    not_look_ahead_np(_16006,_15994,_16021),
    traceprint(4,it14b,_16030,_16021,_16049),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_15899)),nil,_16049,_16109),
    state(_15872,_15873,_16069,_16109,_15938).

itstatem(_15872,_15873,[itstatem,_15968,_15997,lit(med),_16042,_16076,!,_16115],_15951,_15953) --> 
    w(verb(_15901,_15902,fin),_15968,_15951,_15985),
    gmem(_15901,[help,function],_15997,_15985,_16016),
    cc(med,_16016,_16041),
    np0_accept(_15920,_15921,_16042,_16041,_16061),
    traceprint(4,it15,_16076,_16061,_16095),
    !,
    pushstack(first,(xnp(_15920,_15921),w(verb(_15901,_15902,fin))),nil,_16095,_16156),
    state(_15872,_15873,_16115,_16156,_15953).

itstatem(_15872,_15873,[itstatem,_15990,_16019,_16053,lit(å),_16098,!,_16137,_16180],_15973,_15975) --> 
    w(verb(_15910,_15911,fin),_15990,_15973,_16007),
    gmem(_15910,[cost,take],_16019,_16007,_16038),
    np0_accept(_15905,_15906,_16053,_16038,_16072),
    cc(å,_16072,_16097),
    traceprint(4,it16,_16098,_16097,_16117),
    !,
    pushstack(first,([noen],[vil]),nil,_16117,_16150),clausal_object1(_15937,_15938,_16137,_16150,_16165),
    pushstack(first,(xnp(_15937,_15938),w(verb(_15910,_15911,fin)),xnp(_15905,_15906)),nil,_16165,_16252),
    state(_15872,_15873,_16180,_16252,_15975).

itstatem(_15872,_15875::_15876,[itstatem,_15961,_15990,_16014,_16043,_16067,_16091,_16125,{}],_15944,_15946) --> 
    w(verb(go,pres,fin),_15961,_15944,_15978),
    redundants0(_15990,_15978,_16005),
    negation0(_15901,_16014,_16005,_16031),
    ann0(_16043,_16031,_16058),
    infinitive(_16067,_16058,_16082),
    traceprint(4,it17,_16091,_16082,_16110),
    pushstack(first,someone,nil,_16110,_16166),state(_15872,_15875::_15902,_16125,_16166,_15946),
    {user:negate(_15901,_15902,_15876)}.

itstatem(_15872,_15873,[itstatem,_15983,_16012,{},_16071,_16115,_16139,!,_16178],_15966,_15968) --> 
    negation0(_15913,_15983,_15966,_16000),
    hlexv(_15915,go,_15917,fin,_15919,_16012,_16000,_16037),
    {user:bigno(_15913,_15919,_15925)},
    optional([an],_16071,_16037,_16103),
    not_look_ahead_np(_16115,_16103,_16130),
    traceprint(4,it17b,_16139,_16130,_16158),
    !,
    pushstack(first,([dette],w(verb(be,_15917,fin)),negation(_15925),w(adj2(possible,nil))),nil,_16158,_16218),
    state(_15872,_15873,_16178,_16218,_15968).

itstatem(_15872,_15873,[itstatem,_15992,_16021,{},{},_16090,_16114,_16138,!,_16177,_16211],_15975,_15977) --> 
    negation0(_15913,_15992,_15975,_16009),
    hlexv(_15915,_15916,_15917,fin,_15919,_16021,_16009,_16046),
    {user:bigno(_15913,_15919,_15911)},
    {user:(\+testmember(_15916,[cost,take]))},
    preadverbials0(_16090,_16046,_16105),
    look_ahead_np(_16114,_16105,_16129),
    traceprint(4,it18,_16138,_16129,_16157),
    !,
    subject(_15941,_15942,_16177,_16157,_16196),
    pushstack(first,(xnp(_15941,_15942),w(verb(_15916,_15917,fin)),negation(_15911)),nil,_16196,_16282),
    state(_15872,_15873,_16211,_16282,_15977).

itstatem(_15872,_15873,[itstatem,_15968,lit(å),_16008,!,_16047,_16090],_15951,_15953) --> 
    w(verb(_15898,_15899,fin),_15968,_15951,_15985),
    cc(å,_15985,_16007),
    traceprint(4,it19,_16008,_16007,_16027),
    !,
    pushstack(first,([noen],[vil]),nil,_16027,_16060),clausal_object1(_15921,_15922,_16047,_16060,_16075),
    pushstack(first,(xnp(_15921,_15922),w(verb(_15898,_15899,fin))),nil,_16075,_16131),
    state(_15872,_15873,_16090,_16131,_15953).

itstatem(_15872,_15873,[itstatem,_15975,_15999,_16023,_16052,lit(at),_16092,!,_16131,_16155],_15958,_15960) --> 
    blei(_15975,_15958,_15990),
    redundant0(_15999,_15990,_16014),
    negation0(_15913,_16023,_16014,_16040),
    w(verb(_15917,past,part),_16052,_16040,_16069),
    cc(at,_16069,_16091),
    traceprint(4,it20,_16092,_16091,_16111),
    !,
    accept(_16131,_16111,_16146),
    pushstack(first,([noen],w(verb(_15917,past,fin)),negation(_15913),[at]),nil,_16146,_16195),
    state(_15872,_15873,_16155,_16195,_15960).

itstatem(_15872,_15873,[itstatem,_15995,_16019,_16058,_16082,_16111,_16140,_16174,!,_16213,_16237],_15978,_15980) --> 
    blei(_15995,_15978,_16010),
    preadverbial0(_15917,_15918,_15919,_16019,_16010,_16040),
    redundant0(_16058,_16040,_16073),
    negation0(_15925,_16082,_16073,_16099),
    w(verb(_15929,past,part),_16111,_16099,_16128),
    object(_15933,_15934,_16140,_16128,_16159),
    traceprint(4,it21,_16174,_16159,_16193),
    !,
    accept(_16213,_16193,_16228),
    pushstack(first,(xnp(_15933,_15934),w(verb(be,pres,fin)),negation(_15925),w(verb(_15929,past,part)),adverbial1(_15917,_15918,_15919)),nil,_16228,_16340),
    state(_15872,_15873,_16237,_16340,_15980).

itstatem(_15872,_15873,[itstatem,_15956,_15985,_16014,!,_16053],_15939,_15941) --> 
    w(verb(_15900,_15901,pass),_15956,_15939,_15973),
    negation0(_15896,_15985,_15973,_16002),
    traceprint(4,it23,_16014,_16002,_16033),
    !,
    pushstack(first,([noen],w(verb(_15900,_15901,fin)),negation(_15896)),nil,_16033,_16093),
    state(_15872,_15873,_16053,_16093,_15941).

itstatem(_15872,_15873,[itstatem,_15991,_16020,_16044,{},_16083,_16107,!,_16146],_15974,_15976) --> 
    w(verb(be,_15916,fin),_15991,_15974,_16008),
    redundant0(_16020,_16008,_16035),
    w(adj2(_15910,nil),_16044,_16035,_16061),
    {user:testmember(_15910,[certain,uncertain,good,bad])},
    atom(_16083,_16061,_16098),
    traceprint(4,it24,_16107,_16098,_16126),
    !,
    pushstack(first,state(_15872,_15873)\(xnp(_15940,_15941),w(verb(be,_15916,fin)),w(adj2(_15910,nil))),nil,_16126,_16189),
    clausal_object1(_15940,_15941,_16146,_16189,_15976).

atom([atom,lit(at)],_15889,_15891) --> 
    cc(at,_15889,_15891).

atom([atom,lit(om)],_15889,_15891) --> 
    cc(om,_15889,_15891).

itstatem(_15872,_15873,[itstatem,_16013,_16042,_16066,lit(å),_16106,_16135,_16164,_16188,!,_16227,_16270],_15996,_15998) --> 
    w(verb(be,_15922,fin),_16013,_15996,_16030),
    redundant0(_16042,_16030,_16057),
    w(adj2(_15916,nil),_16066,_16057,_16083),
    cc(å,_16083,_16105),
    w(verb(_15934,inf,fin),_16106,_16105,_16123),
    reflexiv0(_15934,_16135,_16123,_16152),
    not_look_ahead_np(_16164,_16152,_16179),
    traceprint(4,it25,_16188,_16179,_16207),
    !,
    pushstack(first,([noen],w(verb(_15934,pres,fin)),[dette]),nil,_16207,_16240),clausal_object1(_15954,_15955,_16227,_16240,_16255),
    pushstack(first,(xnp(_15954,_15955),w(verb(be,_15922,fin)),w(adj2(_15916,nil))),nil,_16255,_16311),
    state(_15872,_15873,_16270,_16311,_15998).

itstatem(_15872,_15873,[itstatem,_15970,_15999,_16028,_16057,!,_16096],_15953,_15955) --> 
    w(verb(be,_15909,fin),_15970,_15953,_15987),
    negation0(_15912,_15999,_15987,_16016),
    w(prep(_15904),_16028,_16016,_16045),
    traceprint(4,it26,_16057,_16045,_16076),
    !,
    pushstack(first,([dette],w(verb(be,_15909,fin)),negation(_15912),w(prep(_15904))),nil,_16076,_16136),
    state(_15872,_15873,_16096,_16136,_15955).

itstatem(_15872,_15873,[itstatem,_16000,_16029,lit(å),_16069,_16098,!,_16137,!,_16185],_15983,_15985) --> 
    w(verb(be,pres,fin),_16000,_15983,_16017),
    w(adj2(_15910,nil),_16029,_16017,_16046),
    cc(å,_16046,_16068),
    w(verb(_15928,inf,fin),_16069,_16068,_16086),
    traceprint(4,it27,_16098,_16086,_16117),
    !,
    pushstack(first,([jeg],w(verb(_15928,pres,fin))),nil,_16117,_16150),clausal_object1(_15947,_15948,_16137,_16150,_16165),
    !,
    pushstack(first,(xnp(_15947,_15948),w(verb(be,pres,fin)),w(adj2(_15910,nil))),nil,_16165,_16226),
    state(_15872,_15873,_16185,_16226,_15985).

itstatem(_15872,_15873,[itstatem,_15966,{},_16005,_16039,!,_16078],_15949,_15951) --> 
    w(verb(_15903,_15904,fin),_15966,_15949,_15983),
    {user:verbtype(_15903,rv)},
    subject(_15912,_15913,_16005,_15983,_16024),
    traceprint(4,it28,_16039,_16024,_16058),
    !,
    pushstack(first,(xnp(_15912,_15913),w(verb(_15903,pres,fin)),[dette]),nil,_16058,_16119),
    state(_15872,_15873,_16078,_16119,_15951).

itstatem(_15872,_15873,[itstatem,_16007,_16036,_16070,_16094,_16123,{},lit(noe),lit(om),_16184,_16218],_15990,_15992) --> 
    w(verb(have,_15925,fin),_16007,_15990,_16024),
    subject(_15928,_15929,_16036,_16024,_16055),
    redundant0(_16070,_16055,_16085),
    negation0(_15931,_16094,_16085,_16111),
    w(verb(_15935,past,part),_16123,_16111,_16140),
    {user:testmember(_15935,[tell])},
    cc(noe,_16140,_16172),
    cc(om,_16172,_16183),
    traceprint(4,it29,_16184,_16183,_16203),
    pushstack(first,(xnp(_15928,_15929),w(verb(_15935,past,fin)),negation(_15931),[noe],[om],[det]),nil,_16203,_16289),
    state(_15872,_15873,_16218,_16289,_15992).

itstatem(_15872,_15873,[itstatem,_15961,{},_16000,!,_16039],_15944,_15946) --> 
    w(verb(_15895,_15902,fin),_15961,_15944,_15978),
    {user:testmember(_15895,[concern])},
    traceprint(4,it30,_16000,_15978,_16019),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_15895,pres,fin))),nil,_16019,_16049),
    state(_15872,_15873,_16039,_16049,_15946).

itstatem(_15872,_15873,[itstatem,_15988,{},_16027,_16056,_16100,!,_16139],_15971,_15973) --> 
    w(verb(_15908,_15909,fin),_15988,_15971,_16005),
    {user:testmember(_15908,[go,look,see,function])},
    w(adv(_15904),_16027,_16005,_16044),
    optional([ut],_16056,_16044,_16088),
    traceprint(4,it31,_16100,_16088,_16119),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_15908,pres,fin)),w(adv(_15904))),nil,_16119,_16149),
    state(_15872,_15873,_16139,_16149,_15973).

itstatem(_15872,_15875::_15876,[itstatem,_15965,{},_16004,!,_16043],_15948,_15950) --> 
    w(verb(_15897,_15904,fin),_15965,_15948,_15982),
    {user:testmember(_15897,[rain,snow,look,be_urgent])},
    traceprint(4,it32,_16004,_15982,_16023),
    !,
    pushstack(first,(something,lexv(iv,_15897,pres,fin)),nil,_16023,_16117),
    state(_15872,_15875::_15876,_16043,_16117,_15950).

itstatem(_15872,_15875::_15876,[itstatem,_15952,{},_15996,_16030],_15935,_15937) --> 
    pvimodal(_15892,_15897,_15952,_15935,_15971),
    {user:constrainit(_15901,thing)},
    traceprint(4,it32,_15996,_15971,_16015),
    pushstack(first,w(verb(_15892,pres,fin)),nil,_16015,_16040),
    verb_phrase1(_15892,_15901,id,_15872,_15875::_15876,_16030,_16040,_15937).

itstatem(_15872,_15875::_15876,[itstatem,_15962,_15996,_16030,_16064,{}],_15945,_15947) --> 
    beginverb(_15896,_15892,_15962,_15945,_15981),
    np1(_15899,_15900,_15996,_15981,_16015),
    traceprint(4,it33,_16030,_16015,_16049),
    pushstack(first,(np1(_15899,_15900),w(verb(_15896,pres,fin))),nil,_16049,_16110),state(_15872,_15875::_15893,_16064,_16110,_15947),
    {user:negate(_15892,_15893,_15876)}.

itstatem(_15872,_15875::_15876,[itstatem,_15952,_15976,_16015,_16039,_16073],_15935,_15937) --> 
    be(_15952,_15935,_15967),
    adverbial(_15893,_15894,_15897::_15898,_15976,_15967,_15997),
    that(_16015,_15997,_16030),
    traceprint(4,it34,_16039,_16030,_16058),
    lock(last,_16058,_16123),
    pushstack(last,adverbial(_15893,_15894,_15897::_15898),nil,_16123,_16129),
    state(_15872,_15875::_15876,_16073,_16129,_16118),
    unlock(_16118,_15937).

itstatem(_15872,_15875::_15876,[itstatem,_15971,_15995,_16024,_16048,_16077,_16106,_16135,!,_16174,_16198],_15954,_15956) --> 
    be(_15971,_15954,_15986),
    negation0(_15911,_15995,_15986,_16012),
    saa0(_16024,_16012,_16039),
    not_look_ahead(w(verb(_15917,past,part)),_16048,_16039,_16065),
    w(adj2(_15923,nil),_16077,_16065,_16094),
    one_of_lit([at,om],_16106,_16094,_16123),
    traceprint(4,it35,_16135,_16123,_16154),
    !,
    accept(_16174,_16154,_16189),
    statem(_15872,_15875::_15876,_16198,_16189,_15956).

itstatem(_15872,_15875::_15876,[itstatem,_15967,_15991,_16020,_16044,{},_16083,_16112,_16146],_15950,_15952) --> 
    be(_15967,_15950,_15982),
    negation0(_15905,_15991,_15982,_16008),
    saa0(_16020,_16008,_16035),
    w(adj2(_15909,nil),_16044,_16035,_16061),
    {user:testmember(_15909,[good])},
    not_look_ahead(w(noun(_15923,_15924,_15925,_15926)),_16083,_16061,_16100),
    traceprint(4,it36,_16112,_16100,_16131),
    statem(_15872,_15875::_15876,_16146,_16131,_15952).

itstatem(_15872,_15875::_15876,[itstatem,_16014,{},_16053,_16077,_16106,{},_16145,_16179,{}],_15997,_15999) --> 
    be(_15904,_16014,_15997,_16031),
    {user:it_template(_15912)},
    so0(_16053,_16031,_16068),
    gradverb0(_15914,_16077,_16068,_16094),
    w(adj2(_15918,nil),_16106,_16094,_16123),
    {user:testmember(_15918,[difficult,easy,expensive,free,funny,good,intelligent,mild,hot,cold,wet,dark,bright,cloudy,sad,stupid,tedious])},
    traceprint(4,it37,_16145,_16123,_16164),
    pushstack(first,w(adj2(_15918,nil)),nil,_16164,_16192),be_complements(_15912,_15872,_15875::_15905,_16179,_16192,_15999),
    {user:negate(_15904,_15905,_15876)}.

itstatem(_15872,_15875::_15876,[itstatem,_15978,{},_16032,_16061,_16100,!,_16139],_15961,_15963) --> 
    lexv(iv,_15909,_15910,fin,_15978,_15961,_16001),
    {user:(\+testmember(_15909,be))},
    negation0(_15920,_16032,_16001,_16049),
    adverb(_15905,_15906,_15924,_16061,_16049,_16082),
    traceprint(4,it38,_16100,_16082,_16119),
    !,
    pushstack(free,(lexv(iv,_15909,_15910,fin),negation(_15920),xadverb(_15905,_15906)),nil,_16119,_16241),
    state(_15872,_15875::_15876,_16139,_16241,_15963).

itstatem(_15872,_15873,[itstatem,_15957,_15986,_16020,!,_16059,!],_15940,_15942) --> 
    be(_15890,_15957,_15940,_15974),
    subject(_15892,_15893,_15986,_15974,_16005),
    traceprint(4,it39,_16020,_16005,_16039),
    !,
    pushstack(first,(xnp(_15892,_15893),w(verb(exist,pres,fin)),negation(_15890)),nil,_16039,_16133),state(_15872,_15873,_16059,_16133,_15942),
    !.

statreal(_15872,[statreal,_15908],_15894,_15896) --> 
    stat(real,_15872,_15908,_15894,_15896).

stat(_15872,_15873,[stat,_15928,_15962],_15911,_15913) --> 
    state(_15879,_15886::_15887,_15928,_15911,_15947),
    worldcomp(_15872,_15879,_15886::_15887,_15873,_15962,_15947,_15913).

statreal1(_15872,[statreal1,_15916,_15950],_15902,_15904) --> 
    state1(_15878,_15879,_15916,_15902,_15935),
    worldcomp(real,_15878,_15879,_15872,_15950,_15935,_15904).

state1(_15872,_15875::_15876,[state1,_15963,_15997,_16026,!,_16055,{},{},!],_15946,_15948) --> 
    np(_15899,_15902::_15876,_15963,_15946,_15982),
    negation0(_15905,_15997,_15982,_16014),
    redundant0(_16026,_16014,_16041),
    !,
    vp(_15899,_15908,_15872,_15875::_15913,_16055,_16041,_15948),
    {user:bigno(_15905,_15908,_15919)},
    {user:negate(_15919,_15913,_15902)},
    !.

substate(_15872,_15875::_15876,[substate,_15960,_15994,_16018,!,_16052,{},{}],_15943,_15945) --> 
    subject(_15902,_15900::_15876,_15960,_15943,_15979),
    preadverbials0(_15994,_15979,_16009),
    negation0(_15908,_16018,_16009,_16035),
    !,
    vp(_15902,_15911,_15872,_15875::_15899,_16052,_16035,_15945),
    {user:bigno(_15908,_15911,_15898)},
    {user:negate(_15898,_15899,_15900)}.

state(_15872,_15875::_15876,[state,_15957,_15991,_16015,_16044,{},{}],_15940,_15942) --> 
    subject(_15899,_15897::_15876,_15957,_15940,_15976),
    redundant0(_15991,_15976,_16006),
    negation0(_15905,_16015,_16006,_16032),
    vp(_15899,_15908,_15872,_15875::_15896,_16044,_16032,_15942),
    {user:bigno(_15905,_15908,_15895)},
    {user:negate(_15895,_15896,_15897)}.

beginverb(_15872,_15873,[beginverb,_15934,_15963,_15992,_16016],_15917,_15919) --> 
    w(verb(start,_15893,fin),_15934,_15917,_15951),
    negation0(_15873,_15963,_15951,_15980),
    infinitiveand(_15992,_15980,_16007),
    w(verb(_15872,_15887,fin),_16016,_16007,_15919).

question(_15872,[question,_15947,_15976,!,_16005],_15933,_15935) --> 
    w(noun(clock,sin,_15903,n),_15947,_15933,_15964),
    terminator(_15976,_15964,_15991),
    !,
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(clock,sin,def,n))),nil,_15991,_16015),
    whatq(_15872,_16005,_16015,_15935).

question(_15872,[question,_15907],_15893,_15895) --> 
    whichq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    whoq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    whenq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    howadjq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    whereq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    wherefromq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    whatq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    howmuchq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    whyq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    howq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    ppq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15907],_15893,_15895) --> 
    whoseq(_15872,_15907,_15893,_15895).

question(_15872,[question,_15956,_15980,!,_16014,_16048,!,_16077],_15942,_15944) --> 
    be(_15956,_15942,_15971),
    w(noun(clock,_15914,_15915,_15916),_15980,_15971,_15997),
    !,
    np1(_15918,_15919,_16014,_15997,_16033),
    danow0(_16048,_16033,_16063),
    !,
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_16063,_16146),
    whatq(_15872,_16077,_16146,_15944).

question(_15872,[question,_15907],_15893,_15895) --> 
    question1(_15872,_15907,_15893,_15895).

question1(test:::_15875,[question1,lit(får),_15946,!,_15985],_15921,_15923) --> 
    cc(får,_15921,_15945),
    specific_phrase(_15896,_15897,_15946,_15945,_15965),
    !,
    pushstack(first,(np(_15896,_15897),[får]),nil,_15965,_16026),
    statement(_15875,_15985,_16026,_15923).

question1(new:::_15875,[question1,_15964,_15993,{},_16032,!,_16066],_15950,_15952) --> 
    w(verb(have,pres,fin),_15964,_15950,_15981),
    w(verb(_15900,past,part),_15993,_15981,_16010),
    {user:testmember(_15900,[want,think])},
    not_look_ahead([du],_16032,_16010,_16049),
    !,
    pushstack(first,([jeg],w(verb(_15900,pres,fin))),nil,_16049,_16076),
    statement(_15875,_16066,_16076,_15952).

question1(new:::_15875,[question1,_15963,{},_16002,_16036,!,_16070],_15949,_15951) --> 
    w(verb(_15906,pres,fin),_15963,_15949,_15980),
    {user:testmember(_15906,[want,think,hope])},
    particlev0(_15906,_15900,_16002,_15980,_16021),
    not_look_ahead([du],_16036,_16021,_16053),
    !,
    pushstack(first,([jeg],w(verb(_15900,pres,fin))),nil,_16053,_16080),
    statement(_15875,_16070,_16080,_15951).

question1(test:::_15875,[question1,_15910],_15896,_15898) --> 
    question0(_15875,_15910,_15896,_15898).

np_question(which(_15877):::_15875,[np_question,_15916],_15902,_15904) --> 
    np1(_15877,true::_15875,_15916,_15902,_15904).

question0(_15872,[question0,_15907],_15893,_15895) --> 
    isq(_15872,_15907,_15893,_15895).

question0(_15872,[question0,_15907],_15893,_15895) --> 
    ynqs(_15872,_15907,_15893,_15895).

question0(_15872,[question0,_15907],_15893,_15895) --> 
    hasq(_15872,_15907,_15893,_15895).

question0(_15872,[question0,_15910,_15934],_15896,_15898) --> 
    hoq(_15910,_15896,_15925),
    statement(_15872,_15934,_15925,_15898).

implicitq(new:::_15875,[implicitq,_16029,{},_16068,{},{},lit(som),_16128,_16152,_16195,!,_16234,_16258,!,_16312],_16015,_16017) --> 
    w(prep(_15918),_16029,_16015,_16046),
    {user:testmember(_15918,[from,to])},
    w(name(_15931,n,_15933),_16068,_16046,_16085),
    {user:testmember(_15933,[station,neighbourhood])},
    {user:no_unprotected_verb},
    cc(som,_16085,_16127),
    look_ahead_vp(_16128,_16127,_16143),
    pushstack(first,(w(noun(bus,sin,u,n)),w(prep(_15918)),w(name(_15931,n,_15933))),nil,_16143,_16165),np1_accept(_15963,_15966::_15875,_16152,_16165,_16180),
    traceprint(4,iq00,_16195,_16180,_16214),
    !,
    accept(_16234,_16214,_16249),
    verb_phrase1(_15983,_15963,id,_15986,event/real/_15986::_15966,_16258,_16249,_16283),
    !,
    accept(_16312,_16283,_16017).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,_16017,lit(når),{},_16067,_16096,_16140,{},_16179,!,{},_16228,_16267],_16003,_16005) --> 
    not_look_ahead([nr],_16017,_16003,_16034),
    cc(når,_16034,_16056),
    {user:(\+user:value(dialog,1))},
    w(verb(go,_15943,fin),_16067,_16056,_16084),
    optional([neste],_16096,_16084,_16128),
    w(name(_15920,n,_15922),_16140,_16128,_16157),
    {user:testmember(_15922,[station,neighbourhood])},
    traceprint(4,iq01,_16179,_16157,_16198),
    !,
    {user:setvartype(_15970,vehicle)},
    realcomp(_15880,_15974,_15878,_16228,_16198,_16249),
    pushstack(first,w(name(_15920,n,_15922)),nil,_16249,_16277),
    verb_modifiers(go,_15970,_15880,_15877::true,_15974,_16267,_16277,_16005).

implicitq(_15872,[implicitq,_15975,lit(når),{},{},_16035,{},!,_16079,_16103,_16137],_15961,_15963) --> 
    not_look_ahead([nr],_15975,_15961,_15992),
    cc(når,_15992,_16014),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    look_ahead(w(name(_15930,_15931,_15932)),_16035,_16014,_16052),
    {user:subclass0(_15932,place)},
    !,
    accept(_16079,_16052,_16094),
    traceprint(4,iq2,_16103,_16094,_16122),
    pushstack(first,w(prep(to)),nil,_16122,_16147),
    implicitq(_15872,_16137,_16147,_15963).

implicitq(test:::_15875,[implicitq,{},_15976,lit(når),lit(nr),{},!,_16042,_16066,_16100],_15952,_15954) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead([nr],_15976,_15952,_15993),
    cc(når,_15993,_16015),
    cc(nr,_16015,_16026),
    {user:no_unprotected_verb},
    !,
    accept(_16042,_16026,_16057),
    traceprint(4,iq3,_16066,_16057,_16085),
    pushstack(first,w(verb(go,pres,fin)),nil,_16085,_16110),
    ynq(_15875,_16100,_16110,_15954).

implicitq(test:::_15875,[implicitq,_15968,lit(når),{},{},_16028,!,_16077,_16101,_16135],_15954,_15956) --> 
    not_look_ahead([nr],_15968,_15954,_15985),
    cc(når,_15985,_16007),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    optional([det],_16028,_16007,_16060),
    !,
    accept(_16077,_16060,_16092),
    traceprint(4,iq4,_16101,_16092,_16120),
    pushstack(first,w(verb(go,pres,fin)),nil,_16120,_16145),
    ynq(_15875,_16135,_16145,_15956).

implicitq(_15872,[implicitq,_15911,!,_15940],_15897,_15899) --> 
    reject_implicitq(_15911,_15897,_15926),
    !,
    reject(_15940,_15926,_15899).

implicitq(new:::_15875,[implicitq,_16034,{},{},_16083,{},{},_16137,_16166,_16195,_16224,!,_16253,_16277,_16311,_16369,_16413,!,_16442],_16020,_16022) --> 
    look_ahead(w(noun(_15932,sin,u,n)),_16034,_16020,_16051),
    {user:subclass0(_15932,vehicle)},
    {user:no_unprotected_verb},
    np1_accept(_15944,_15947::_15875,_16083,_16051,_16102),
    {user:(\+vartypeid(_15944,time))},
    {user:(\+vartypeid(_15944,clock))},
    constrainvehdep(_15944,_16137,_16102,_16154),
    not_look_ahead([som],_16166,_16154,_16183),
    not_look_ahead([om],_16195,_16183,_16212),
    point0(_16224,_16212,_16239),
    !,
    accept(_16253,_16239,_16268),
    traceprint(4,iq4b,_16277,_16268,_16296),
    pushstack(first,w(verb(go,pres,fin)),nil,_16296,_16324),verb_phrase1(go,_15944,id,_15989,event/real/_15989::_15947,_16311,_16324,_16345),
    optional(itrailer,_16369,_16345,_16401),
    endofline(_16413,_16401,_16428),
    !,
    accept(_16442,_16428,_16022).

implicitq(which(_15877):::_15875,[implicitq,{},_16007,_16036,_16065,_16104,!,_16133,_16167,!,_16261],_15983,_15985) --> 
    {user:value(teleflag,true)},
    w(noun(_15916,_15917,_15918,n),_16007,_15983,_16024),
    not_look_ahead(w(prep(_15925)),_16036,_16024,_16053),
    person_name(_15931:person,_15928,_15929,_16065,_16053,_16086),
    endofline(_16104,_16086,_16119),
    !,
    traceprint(4,iq5,_16133,_16119,_16152),
    lock(exact,_16152,_16220),pushstack(exact,(w(noun(_15916,sin,u,n)),w(prep(to)),nameq1(_15931:person,_15928)),nil,_16220,_16226),no_phrases(_15877,_15875,_16167,_16226,_16215),unlock(_16215,_16216),
    !,
    accept(_16261,_16216,_15985).

implicitq(which(_15877):::_15875,[implicitq,{},_15949,_15983,_16007,!,_16046],_15925,_15927) --> 
    {user:value(teleflag,true)},
    no_phrases(_15877,_15875,_15949,_15925,_15968),
    endofline(_15983,_15968,_15998),
    traceprint(4,iq7,_16007,_15998,_16026),
    !,
    accept(_16046,_16026,_15927).

implicitq(new:::_15875,[implicitq,{},_16028,{},_16067,_16096,_16125,_16168,!,_16207,_16231,_16289,!,_16318],_16004,_16006) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead(w(prep(_15927)),_16028,_16004,_16045),
    {user:no_unprotected_verb},
    w(noun(time,_15934,_15935,_15936),_16067,_16045,_16084),
    look_ahead(w(prep(_15942)),_16096,_16084,_16113),
    pushstack(first,w(noun(departure,sin,u,_15936)),nil,_16113,_16138),np0(_15954,_15957::_15875,_16125,_16138,_16153),
    traceprint(4,iq8,_16168,_16153,_16187),
    !,
    accept(_16207,_16187,_16222),
    pushstack(first,w(verb(go,pres,fin)),nil,_16222,_16244),verb_phrase1(_15972,_15954,id,_15975,event/real/_15975::_15957,_16231,_16244,_16265),
    endofline(_16289,_16265,_16304),
    !,
    accept(_16318,_16304,_16006).

implicitq(new:::_15875,[implicitq,_16033,_16062,{},_16101,{},{},_16155,_16184,_16213,_16242,!,_16271,_16295,_16329,_16387,_16431,!,_16460],_16019,_16021) --> 
    not_look_ahead(w(nb(_15932,num)),_16033,_16019,_16050),
    not_look_ahead(w(prep(_15939)),_16062,_16050,_16079),
    {user:no_unprotected_verb},
    np1_accept(_15943,_15946::_15875,_16101,_16079,_16120),
    {user:(\+vartypeid(_15943,time))},
    {user:(\+vartypeid(_15943,clock))},
    constrainvehdep(_15943,_16155,_16120,_16172),
    not_look_ahead([som],_16184,_16172,_16201),
    not_look_ahead([om],_16213,_16201,_16230),
    point0(_16242,_16230,_16257),
    !,
    accept(_16271,_16257,_16286),
    traceprint(4,iq9,_16295,_16286,_16314),
    pushstack(first,w(verb(go,pres,fin)),nil,_16314,_16342),verb_phrase1(_15985,_15943,id,_15988,event/real/_15988::_15946,_16329,_16342,_16363),
    optional(itrailer,_16387,_16363,_16419),
    endofline(_16431,_16419,_16446),
    !,
    accept(_16460,_16446,_16021).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,{},_16014,_16043,_16072,{},_16106,_16130,{},_16164,_16203,_16227,_16318,!,_16357,_16381],_15990,_15992) --> 
    {user:value(dialog,1)},
    not_look_ahead([nå],_16014,_15990,_16031),
    time1(_15936,_16043,_16031,_16060),
    endofline(_16072,_16060,_16087),
    {user:no_unprotected_verb},
    no_harmful_adj(_16106,_16087,_16121),
    no_harmful_noun(_16130,_16121,_16145),
    {user:setvartype(_15942,vehicle)},
    realcomp(_15880,_15946,_15878,_16164,_16145,_16185),
    deter0(_16203,_16185,_16218),
    pushstack(first,obviousclock1(_15936:clock,_15936 isa clock),nil,_16218,_16273),verb_modifiers(go,_15942,_15880,_15877::true,_15946,_16227,_16273,_16294),
    traceprint(4,iq10,_16318,_16294,_16337),
    !,
    accept(_16357,_16337,_16372),
    qtrailer0(_16381,_16372,_15992).

implicitq(new:::_15875,[implicitq,{},_16036,_16065,{},_16099,{},{},_16153,_16182,_16211,!,_16245,_16269,_16303,_16361,!,_16390],_16012,_16014) --> 
    {user:value(dialog,1)},
    not_look_ahead(w(prep(_15934)),_16036,_16012,_16053),
    not_look_ahead_flnp(_16065,_16053,_16080),
    {user:no_unprotected_verb},
    np0(_15938,_15941::_15875,_16099,_16080,_16118),
    {user:(\+vartypeid(_15938,time))},
    {user:(\+vartypeid(_15938,clock))},
    constrainvehdep(_15938,_16153,_16118,_16170),
    not_look_ahead([om],_16182,_16170,_16199),
    not_look_ahead([som],_16211,_16199,_16228),
    !,
    accept(_16245,_16228,_16260),
    traceprint(4,iq11,_16269,_16260,_16288),
    pushstack(first,w(verb(go,pres,fin)),nil,_16288,_16316),verb_phrase1(_15980,_15938,id,_15983,event/real/_15983::_15941,_16303,_16316,_16337),
    endofline(_16361,_16337,_16376),
    !,
    accept(_16390,_16376,_16014).

implicitq(_15872,[implicitq,_15975,_15999,_16028,_16057,!,_16091,_16115,_16149],_15961,_15963) --> 
    the0(_15975,_15961,_15990),
    w(nb(_15913,num),_15999,_15990,_16016),
    flnp(_15916,_16028,_16016,_16045),
    w(prep(_15909),_16057,_16045,_16074),
    !,
    accept(_16091,_16074,_16106),
    traceprint(4,iq12,_16115,_16106,_16134),
    pushstack(first,(w(nb(_15913,num)),w(adj2(_15916,nil)),w(noun(route,plu,u,n)),w(prep(_15909))),nil,_16134,_16159),
    implicitq(_15872,_16149,_16159,_15963).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,_15992,_16021,_16050,!,_16084,_16108,_16142,_16181,!,_16244],_15978,_15980) --> 
    flnp(_15909,_15992,_15978,_16009),
    not_look_ahead([p],_16021,_16009,_16038),
    therightprep(_15915,_16050,_16038,_16067),
    !,
    accept(_16084,_16067,_16099),
    traceprint(4,iq13,_16108,_16099,_16127),
    realcomp(_15880,_15921,_15878,_16142,_16127,_16163),
    pushstack(first,w(prep(_15915)),nil,_16163,_16194),verb_modifiers(go,_15937:vehicle,_15880,_15877::_15937 isa vehicle and adj/nil/_15909/_15937/_15880,_15921,_16181,_16194,_16215),
    !,
    accept(_16244,_16215,_15980).

implicitq(_15872,[implicitq,{},_15997,_16026,{},_16065,{},!,_16109,_16133,_16167],_15973,_15975) --> 
    {user:(\+value(dialog,1))},
    w(noun(_15909,_15910,_15911,_15912),_15997,_15973,_16014),
    not_look_ahead(w(name(_15932,_15933,_15934)),_16026,_16014,_16043),
    {user:testmember(_15909,[station])},
    look_ahead(w(prep(_15947)),_16065,_16043,_16082),
    {user:no_unprotected_verb},
    !,
    accept(_16109,_16082,_16124),
    traceprint(4,iq14,_16133,_16124,_16152),
    pushstack(first,(whatbe,w(noun(_15909,_15910,_15911,_15912))),nil,_16152,_16210),
    whatq(_15872,_16167,_16210,_15975).

implicitq(_15872,[implicitq,{},_15985,_16014,{},{},!,_16068,_16092,_16126],_15961,_15963) --> 
    {user:(\+value(dialog,1))},
    w(adj2(nearest,nil),_15985,_15961,_16002),
    look_ahead(w(noun(_15925,_15926,_15927,_15928)),_16014,_16002,_16031),
    {user:testmember(_15925,[station])},
    {user:no_unprotected_verb},
    !,
    accept(_16068,_16031,_16083),
    traceprint(4,iq14b,_16092,_16083,_16111),
    pushstack(first,(whatbe,w(adj2(nearest,nil))),nil,_16111,_16164),
    whatq(_15872,_16126,_16164,_15963).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,lit(nå),{},{},{},_16050,_16079,_16108,{},_16142,_16181,_16239,!,_16278],_15995,_15997) --> 
    cc(nå,_15995,_16019),
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(adj2(_15940,nil)),_16050,_16019,_16067),
    not_look_ahead(w(noun(_15947,_15948,_15949,_15950)),_16079,_16067,_16096),
    not_fnlp(_16108,_16096,_16123),
    {user:setvartype(_15954,vehicle)},
    realcomp(_15880,_15958,_15878,_16142,_16123,_16163),
    pushstack(free,[nå],nil,_16163,_16194),verb_modifiers(go,_15954,_15880,_15877::true,_15958,_16181,_16194,_16215),
    traceprint(4,iq15,_16239,_16215,_16258),
    !,
    accept(_16278,_16258,_15997).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,{},{},{},_16039,_16068,{},_16112,_16151,_16175,!,_16269,_16293,_16327],_15995,_15997) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_15938,_15939)),_16039,_15995,_16056),
    obviousclock1(_15941,_15942,_16068,_16056,_16087),
    {user:setvartype(_15946,vehicle)},
    realcomp(_15880,_15950,_15878,_16112,_16087,_16133),
    deter0(_16151,_16133,_16166),
    pushstack(first,(w(prep(after)),obviousclock1(_15941,_15942)),nil,_16166,_16219),verb_modifiers(go,_15946,_15880,_15877::true,_15950,_16175,_16219,_16240),
    !,
    accept(_16269,_16240,_16284),
    traceprint(4,iq17,_16293,_16284,_16312),
    qtrailer0(_16327,_16312,_15997).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,{},{},_16011,_16050,{},_16084,_16113,_16142,_16181,_16230,!,_16269],_15977,_15979) --> 
    {user:(\+value(dialog,1))},
    {user:no_unprotected_verb},
    namep(_15924,_15925,_15926,_16011,_15977,_16032),
    no_harmful_adj(_16050,_16032,_16065),
    {user:constrain(_15925,vehicle)},
    not_look_ahead([om],_16084,_16065,_16101),
    not_look_ahead(w(nb(_15941,_15942)),_16113,_16101,_16130),
    realcomp(_15880,_15945,_15878,_16142,_16130,_16163),
    verb_modifiers(go,_15925,_15880,_15877::_15926,_15945,_16181,_16163,_16206),
    traceprint(4,iq18,_16230,_16206,_16249),
    !,
    accept(_16269,_16249,_15979).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,_15997,_16026,{},{},_16075,_16114,_16172,!,_16211],_15983,_15985) --> 
    not_look_ahead(w(name(_15910,_15911,_15912)),_15997,_15983,_16014),
    w(noun(_15916,sin,u,n),_16026,_16014,_16043),
    {user:test(_15916 ako day)},
    {user:setvartype(_15930,vehicle)},
    realcomp(_15880,_15934,_15878,_16075,_16043,_16096),
    pushstack(first,(w(prep(on)),w(noun(_15916,sin,u,n))),nil,_16096,_16127),verb_modifiers(go,_15930,_15880,_15877::true,_15934,_16114,_16127,_16148),
    traceprint(4,iq19,_16172,_16148,_16191),
    !,
    accept(_16211,_16191,_15985).

implicitq(new:::_15875,[implicitq,{},_16059,_16088,{},{},{},{},{},_16172,_16201,_16230,!,_16264,_16288,_16322,_16380,!,_16409],_16035,_16037) --> 
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_15934,_15935)),_16059,_16035,_16076),
    np1_accept(_15937,_15940::_15875,_16088,_16076,_16107),
    {user:(\+vartypeid(_15937,thing))},
    {user:(\+vartypeid(_15937,time))},
    {user:(\+vartypeid(_15937,clock))},
    {user:(\+vartypeid(_15937,arrival))},
    {user:(\+vartypeid(_15937,departure))},
    not_look_ahead([om],_16172,_16107,_16189),
    not_look_ahead(w(nb(_15986,_15987)),_16201,_16189,_16218),
    constrainvehdep(_15937,_16230,_16218,_16247),
    !,
    accept(_16264,_16247,_16279),
    traceprint(4,iq20,_16288,_16279,_16307),
    pushstack(first,w(verb(go,pres,fin)),nil,_16307,_16335),verb_phrase1(_16003,_15937,id,_16006,event/real/_16006::_15940,_16322,_16335,_16356),
    endofline(_16380,_16356,_16395),
    !,
    accept(_16409,_16395,_16037).

implicitq(new:::_15875,[implicitq,lit(når),_15991,!,_16035,_16059,!,_16093,_16127,_16202],_15966,_15968) --> 
    cc(når,_15966,_15990),
    np_kernel(_15912,_15913,_15914,_15991,_15990,_16012),
    !,
    accept(_16035,_16012,_16050),
    constrainvehdep(_15913,_16059,_16050,_16076),
    !,
    traceprint(4,iq21,_16093,_16076,_16112),
    pushstack(first,np_kernel(0,_15913,_15914),nil,_16112,_16172),np1(_15913,_15931::_15875,_16127,_16172,_16187),
    pushstack(first,w(verb(go,pres,fin)),nil,_16187,_16212),
    verb_phrase1(_15934,_15913,id,_15937,event/real/_15937::_15931,_16202,_16212,_15968).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,_16008,_16032,_16061,_16090,_16119,!,_16153,_16177,_16211,_16250,!,_16304],_15994,_15996) --> 
    athe0(_16008,_15994,_16023),
    flnp(_15915,_16032,_16023,_16049),
    not_look_ahead(w(nb(_15921,_15922)),_16061,_16049,_16078),
    not_look_ahead(w(name(_15928,_15929,route)),_16090,_16078,_16107),
    look_ahead(w(name(_15936,_15937,_15938)),_16119,_16107,_16136),
    !,
    accept(_16153,_16136,_16168),
    traceprint(4,iq22,_16177,_16168,_16196),
    realcomp(_15880,_15944,_15878,_16211,_16196,_16232),
    verb_modifiers(go,_15953:vehicle,_15880,_15877::_15953 isa vehicle and adj/nil/_15915/_15953/_15880,_15944,_16250,_16232,_16275),
    !,
    accept(_16304,_16275,_15996).

implicitq(_15872,[implicitq,{},_16032,_16061,_16090,_16119,_16148,_16177,{},_16216,!,_16255,_16279,_16313],_16008,_16010) --> 
    {user:(\+value(dialog,1))},
    not_look_ahead(w(noun(clock,_15931,_15932,_15933)),_16032,_16008,_16049),
    not_look_ahead(w(noun(thing,_15940,_15941,_15942)),_16061,_16049,_16078),
    not_look_ahead(w(noun(answer,_15949,_15950,_15951)),_16090,_16078,_16107),
    not_look_ahead([det],_16119,_16107,_16136),
    not_look_ahead(w(name(_15961,n,_15963)),_16148,_16136,_16165),
    look_ahead(w(noun(_15969,_15970,_15971,n)),_16177,_16165,_16194),
    {user:testmember(_15969,[ticket,price])},
    np1_accept(_15916,_15917,_16216,_16194,_16235),
    !,
    accept(_16255,_16235,_16270),
    traceprint(4,iq23,_16279,_16270,_16298),
    pushstack(first,(whatbe,xnp(_15916,_15917)),nil,_16298,_16382),
    whatq(_15872,_16313,_16382,_16010).

implicitq(_15872,[implicitq,{},_15984,{},_16023,!,_16057,_16081,_16115],_15960,_15962) --> 
    {user:(\+value(dialog,1))},
    w(noun(_15903,_15918,_15919,_15920),_15984,_15960,_16001),
    {user:testmember(_15903,[clock,date])},
    not_look_ahead(w(nb(_15935,_15936)),_16023,_16001,_16040),
    !,
    accept(_16057,_16040,_16072),
    traceprint(4,iq24,_16081,_16072,_16100),
    pushstack(first,(whatbe,w(noun(_15903,_15904,_15905,_15906))),nil,_16100,_16153),
    whatq(_15872,_16115,_16153,_15962).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,{},{},{},_16083,{},_16122,{},{},_16171,_16210,_16239,_16273,!,_16336,_16360],_16039,_16041) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    w(name(_15942,n,_15944),_16083,_16039,_16100),
    {user:subclass0(_15944,place)},
    w(name(_15953,n,_15955),_16122,_16100,_16139),
    {user:subclass0(_15955,place)},
    {user:setvartype(_15964,vehicle)},
    realcomp(_15880,_15968,_15878,_16171,_16139,_16192),
    not_look_ahead(w(nb(_15975,_15976)),_16210,_16192,_16227),
    traceprint(4,iq25,_16239,_16227,_16258),
    pushstack(first,(w(prep(from)),w(name(_15942,n,_15944)),w(prep(to)),w(name(_15953,n,_15955))),nil,_16258,_16286),verb_modifiers(go,_15964,_15880,_15877::true,_15968,_16273,_16286,_16307),
    !,
    accept(_16336,_16307,_16351),
    qtrailer0(_16360,_16351,_16041).

implicitq(modifier(_15880):::_15877 and _15878,[implicitq,{},{},{},_16039,_16063,_16087,{},_16126,_16165,_16189,_16218,_16242,_16266,_16300,!,_16354,_16378],_15995,_15997) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    no_harmful_adj(_16039,_15995,_16054),
    no_harmful_noun(_16063,_16054,_16078),
    not_look_ahead([du],_16087,_16078,_16104),
    {user:setvartype(_15952,vehicle)},
    realcomp(_15880,_15956,_15878,_16126,_16104,_16147),
    deter0(_16165,_16147,_16180),
    not_look_ahead(w(nb(_15963,_15964)),_16189,_16180,_16206),
    no_harmful_adj(_16218,_16206,_16233),
    redundants0(_16242,_16233,_16257),
    traceprint(4,iq26,_16266,_16257,_16285),
    verb_modifiers(go,_15952,_15880,_15877::true,_15956,_16300,_16285,_16325),
    !,
    accept(_16354,_16325,_16369),
    qtrailer0(_16378,_16369,_15997).

reject_implicitq([reject_implicitq,lit(hvilke)],_15889,_15891) --> 
    cc(hvilke,_15889,_15891).

reject_implicitq([reject_implicitq,_15933,_15962,_15991,_16020,_16049],_15922,_15924) --> 
    look_ahead(w(nb(1000,num)),_15933,_15922,_15950),
    not_look_ahead([en],_15962,_15950,_15979),
    not_look_ahead([et],_15991,_15979,_16008),
    not_look_ahead([to],_16020,_16008,_16037),
    not_look_ahead([tre],_16049,_16037,_15924).

reject_implicitq([reject_implicitq,lit(at)],_15889,_15891) --> 
    cc(at,_15889,_15891).

reject_implicitq([reject_implicitq,_15905],_15894,_15896) --> 
    w(noun(error,_15875,_15876,_15877),_15905,_15894,_15896).

reject_implicitq([reject_implicitq,_15923,_15952,_15981],_15912,_15914) --> 
    not_look_ahead(w(adj2(fast,_15888)),_15923,_15912,_15940),
    not_look_ahead(w(adj2(best,_15895)),_15952,_15940,_15969),
    w(adj2(good,nil),_15981,_15969,_15914).

reject_implicitq([reject_implicitq,lit(kan)],_15889,_15891) --> 
    cc(kan,_15889,_15891).

reject_implicitq([reject_implicitq,_15919,_15948,{}],_15908,_15910) --> 
    not_look_ahead([e],_15919,_15908,_15936),
    w(verb(_15880,_15890,_15891),_15948,_15936,_15910),
    {user:_15880\==reach}.

reject_implicitq([reject_implicitq,_15914,_15943],_15903,_15905) --> 
    w(noun(_15883,_15884,_15885,_15886),_15914,_15903,_15931),
    w(verb(_15877,_15878,_15879),_15943,_15931,_15905).

reject_implicitq([reject_implicitq,_15936,_15965,_15994,_16023,_16052,_16081],_15925,_15927) --> 
    not_look_ahead([de],_15936,_15925,_15953),
    not_look_ahead([den],_15965,_15953,_15982),
    not_look_ahead([det],_15994,_15982,_16011),
    not_look_ahead([alle],_16023,_16011,_16040),
    not_look_ahead([en],_16052,_16040,_16069),
    quant_pron(_15887,_15888,_16081,_16069,_15927).

reject_implicitq([reject_implicitq,_15910,_15939],_15899,_15901) --> 
    w(noun(_15879,_15880,_15881,_15882),_15910,_15899,_15927),
    posspron(_15875,_15939,_15927,_15901).

reject_implicitq([reject_implicitq,_15917,{}],_15906,_15908) --> 
    w(noun(_15877,_15887,_15888,_15889),_15917,_15906,_15908),
    {user:testmember(_15877,[possibility,necessity])}.

reject_implicitq([reject_implicitq,_15898],_15887,_15889) --> 
    what(_15898,_15887,_15889).

reject_implicitq([reject_implicitq,lit(der)],_15889,_15891) --> 
    cc(der,_15889,_15891).

reject_implicitq([reject_implicitq,lit(hvor)],_15889,_15891) --> 
    cc(hvor,_15889,_15891).

reject_implicitq([reject_implicitq,lit(hvem)],_15889,_15891) --> 
    cc(hvem,_15889,_15891).

reject_implicitq([reject_implicitq,_15923,_15952,lit(når),_15992],_15912,_15914) --> 
    not_look_ahead([nr],_15923,_15912,_15940),
    not_look_ahead([n],_15952,_15940,_15969),
    cc(når,_15969,_15991),
    not_look_ahead(w(prep(from)),_15992,_15991,_15914).

reject_implicitq([reject_implicitq,_15898],_15887,_15889) --> 
    so(_15898,_15887,_15889).

reject_implicitq([reject_implicitq,_15910,_15939],_15899,_15901) --> 
    w(nb(1000,num),_15910,_15899,_15927),
    look_ahead([takk],_15939,_15927,_15901).

reject_implicitq([reject_implicitq,lit(da)],_15889,_15891) --> 
    cc(da,_15889,_15891).

reject_implicitq([reject_implicitq,lit(og)],_15889,_15891) --> 
    cc(og,_15889,_15891).

reject_implicitq([reject_implicitq,lit(men)],_15889,_15891) --> 
    cc(men,_15889,_15891).

reject_implicitq([reject_implicitq,_15907,lit(hvis)],_15896,_15898) --> 
    not_look_ahead([om],_15907,_15896,_15924),
    cc(hvis,_15924,_15898).

reject_implicitq([reject_implicitq,lit(fordi)],_15889,_15891) --> 
    cc(fordi,_15889,_15891).

reject_implicitq([reject_implicitq,lit(ja)],_15889,_15891) --> 
    cc(ja,_15889,_15891).

reject_implicitq([reject_implicitq,lit(nei)],_15889,_15891) --> 
    cc(nei,_15889,_15891).

reject_implicitq([reject_implicitq,{},lit(det)],_15897,_15899) --> 
    {user:value(notimeoutflag,true)},
    cc(det,_15897,_15899).

reject_implicitq([reject_implicitq,lit(det),_15920],_15898,_15900) --> 
    cc(det,_15898,_15919),
    w(verb(be,_15878,_15879),_15920,_15919,_15900).

reject_implicitq([reject_implicitq,_15941,_15970,{}],_15930,_15932) --> 
    w(adj2(good,nil),_15941,_15930,_15958),
    w(noun(_15880,_15911,_15912,_15913),_15970,_15958,_15932),
    {user:testmember(_15880,[morrow,morning,day,night,evening,midnight,afternoon,prenoon,saturday,sunday])}.

reject_implicitq([reject_implicitq,_15915,{}],_15904,_15906) --> 
    w(noun(_15877,_15885,def,_15887),_15915,_15904,_15906),
    {user:testmember(_15877,[midnight])}.

reject_implicitq([reject_implicitq,lit(på),lit(forhånd),lit(takk)],_15899,_15901) --> 
    cc(på,_15899,_15920),
    cc(forhånd,_15920,_15931),
    cc(takk,_15931,_15901).

reject_implicitq([reject_implicitq,_15938,{},_15977,{},!,_16016],_15927,_15929) --> 
    w(noun(_15889,_15890,_15891,_15892),_15938,_15927,_15955),
    {user:(\+testmember(_15889,[nightbus,airplane,airbus]))},
    endofline(_15977,_15955,_15992),
    {user:value(notimeoutflag,true)},
    !,
    reject(_16016,_15992,_15929).

reject_implicitq([reject_implicitq,lit(nå),_15920,!,_15949],_15898,_15900) --> 
    cc(nå,_15898,_15919),
    endofline(_15920,_15919,_15935),
    !,
    reject(_15949,_15935,_15900).

no_harmful_adj([no_harmful_adj,_15925,{},!,_15969],_15914,_15916) --> 
    look_ahead(w(adj2(_15885,nil)),_15925,_15914,_15942),
    {user:testmember(_15885,[nearest,good,next])},
    !,
    reject(_15969,_15942,_15916).

no_harmful_adj([no_harmful_adj,[]],_15887,_15887) --> 
    [].

no_harmful_noun([no_harmful_noun,_15923,_15952,!,_15991],_15912,_15914) --> 
    look_ahead(w(noun(_15885,_15886,_15887,n)),_15923,_15912,_15940),
    gmem(_15885,[airport,bridge],_15952,_15940,_15971),
    !,
    accept(_15991,_15971,_15914).

','({\+testmember(_15879,[airport])},no_harmful_noun,[',',_15942,{},!,_15986],_15925,_15927) --> 
    look_ahead(w(name(_15897,_15898,_15879)),_15942,_15925,_15959),
    {user:subclass0(_15879,place)},
    !,
    accept(_15986,_15959,_15927).

no_harmful_noun([no_harmful_noun,_15927,_15971,{},!],_15916,_15918) --> 
    optional([alle],_15927,_15916,_15959),
    look_ahead(w(noun(_15889,sin,_15891,_15892)),_15971,_15959,_15918),
    {user:testmember(_15889,[station])},
    !.

no_harmful_noun([no_harmful_noun,_15926,{},!],_15915,_15917) --> 
    look_ahead(w(noun(_15882,sin,u,n)),_15926,_15915,_15917),
    {user:testmember(_15882,[arrival,departure,station,student])},
    !.

no_harmful_noun([no_harmful_noun,_15917,{}],_15906,_15908) --> 
    not_look_ahead(w(noun(_15879,_15887,_15888,_15889)),_15917,_15906,_15908),
    {user:(\+testmember(_15879,airport))}.

therightprep(from,[therightprep,_15912,!],_15898,_15900) --> 
    w(prep(from),_15912,_15898,_15900),
    !.

therightprep(_15872,[therightprep,_15912,!],_15898,_15900) --> 
    w(prep(_15872),_15912,_15898,_15900),
    !.

not_adjective_only([not_adjective_only,_15909,!],_15898,_15900) --> 
    look_ahead(w(name(_15879,n,_15881)),_15909,_15898,_15900),
    !.

not_adjective_only([not_adjective_only,_15905],_15894,_15896) --> 
    look_ahead(w(adj2(_15876,_15877)),_15905,_15894,_15896).

not_fnlp([not_fnlp,_15927,{},!,_15971],_15916,_15918) --> 
    look_ahead(w(adj2(_15885,nil)),_15927,_15916,_15944),
    {user:testmember(_15885,[first,next,last,previous])},
    !,
    reject(_15971,_15944,_15918).

not_fnlp([not_fnlp,[]],_15887,_15887) --> 
    [].

constrainvehdep(_15872,[constrainvehdep,{},!,_15931],_15902,_15904) --> 
    {user:vartypeid(_15872,thing)},
    !,
    reject(_15931,_15902,_15904).

constrainvehdep(_15872,[constrainvehdep,{},!,_15931],_15902,_15904) --> 
    {user:constrain(_15872,clock)},
    !,
    reject(_15931,_15902,_15904).

constrainvehdep(_15874:_15875,[constrainvehdep,{},{},!,_15954],_15915,_15917) --> 
    {user:constrain(_15874:_15892,number)},
    {user:plausible_busno(_15874)},
    !,
    accept(_15954,_15915,_15917).

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,summerroute)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,winterroute)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,route)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,route_plan)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,vehicle)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,departure)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,arrival)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,connection)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,tram_route)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,tram_route_plan)},
    !.

constrainvehdep(_15872,[constrainvehdep,{},!],_15899,_15899) --> 
    {user:constrain(_15872,trip)},
    !.

hasq(_15872,[hasq,_15944,_15968,_15997,!,_16031,_16055],_15930,_15932) --> 
    has(_15944,_15930,_15959),
    thereit(_15901,_15968,_15959,_15985),
    w(verb(_15897,past,part),_15997,_15985,_16014),
    !,
    accept(_16031,_16014,_16046),
    pushstack(free,([det],w(verb(_15897,pres,fin))),nil,_16046,_16065),
    statement(_15872,_16055,_16065,_15932).

hasq(_15872,[hasq,_15965,_15994,_16023,_16047,_16081,_16110,_16134,_16158,_16182,!,_16211],_15951,_15953) --> 
    w(verb(have,_15919,fin),_15965,_15951,_15982),
    negation0(_15922,_15994,_15982,_16011),
    so0(_16023,_16011,_16038),
    subject(_15924,_15925,_16047,_16038,_16066),
    negation0(_15927,_16081,_16066,_16098),
    adverbx0(_16110,_16098,_16125),
    hatt0(_16134,_16125,_16149),
    negatino(_16158,_16149,_16173),
    sometimes0(_16182,_16173,_16197),
    !,
    pushstack(first,(xnp(_15924,_15925),w(verb(have,pres,fin))),nil,_16197,_16252),
    statement(_15872,_16211,_16252,_15953).

hasq(_15872,[hasq,_15930,_15959,_15988],_15916,_15918) --> 
    w(verb(have,_15886,fin),_15930,_15916,_15947),
    negation0(_15895,_15959,_15947,_15976),
    lock(last,_15976,_16005),
    pushstack(last,w(verb(have,_15886,fin)),nil,_16005,_16011),
    statement(_15872,_15988,_16011,_16000),
    unlock(_16000,_15918).

isq(_15872,[isq,_15995,_16019,_16048,_16077,_16106,_16130,_16159,lit(å),!,_16209,!,_16257],_15981,_15983) --> 
    be(_15995,_15981,_16010),
    negation0(_15921,_16019,_16010,_16036),
    thereit(_15923,_16048,_16036,_16065),
    negation0(_15925,_16077,_16065,_16094),
    so0(_16106,_16094,_16121),
    w(adj2(_15918,nil),_16130,_16121,_16147),
    gmem(_15918,[true,false,wrong,correct],_16159,_16147,_16178),
    cc(å,_16178,_16203),
    !,
    pushstack(first,[jeg],nil,_16203,_16222),clausal_object1(_15950,_15951,_16209,_16222,_16237),
    !,
    pushstack(first,(xnp(_15950,_15951),w(verb(be,pres,fin)),w(adj2(_15918,nil))),nil,_16237,_16298),
    substatement1(_15872,_16257,_16298,_15983).

isq(_15872,[isq,_15990,_16014,_16043,_16072,_16101,_16125,_16154,lit(at),!,_16204,!,_16243],_15976,_15978) --> 
    be(_15990,_15976,_16005),
    negation0(_15921,_16014,_16005,_16031),
    thereit(_15923,_16043,_16031,_16060),
    negation0(_15925,_16072,_16060,_16089),
    so0(_16101,_16089,_16116),
    w(adj2(_15918,nil),_16125,_16116,_16142),
    gmem(_15918,[true,false,wrong,correct],_16154,_16142,_16173),
    cc(at,_16173,_16198),
    !,
    clausal_object1(_15945,_15946,_16204,_16198,_16223),
    !,
    pushstack(first,(xnp(_15945,_15946),w(verb(be,pres,fin)),w(adj2(_15918,nil))),nil,_16223,_16284),
    substatement1(_15872,_16243,_16284,_15978).

isq(_15872,[isq,_15950,_15979,_16008,_16037,!,[],_16085],_15936,_15938) --> 
    w(verb(be,_15897,fin),_15950,_15936,_15967),
    negation0(_15900,_15979,_15967,_15996),
    thereit(_15902,_16008,_15996,_16025),
    w(verb(_15906,past,part),_16037,_16025,_16054),
    !,
    pushstack(free,w(verb(_15906,_15897,fin)),nil,_16054,_16084),[],
    statement(_15872,_16085,_16084,_15938).

isq(_15872,[isq,_15952,_15976,_16005,_16034,_16063,_16087,!,_16121],_15938,_15940) --> 
    be(_15952,_15938,_15967),
    negation0(_15907,_15976,_15967,_15993),
    pronoun(_15909,_16005,_15993,_16022),
    negation0(_15911,_16034,_16022,_16051),
    not_look_ahead_np(_16063,_16051,_16078),
    not_look_ahead([som],_16087,_16078,_16104),
    !,
    pushstack(first,(pronoun(_15909),w(verb(be,pres,fin))),nil,_16104,_16162),
    substatement1(_15872,_16121,_16162,_15940).

isq(_15872,[isq,_15986,lit(det),_16021,_16050,_16074,_16103,_16132,lit(å),!,_16182,_16256],_15972,_15974) --> 
    be(_15986,_15972,_16001),
    cc(det,_16001,_16020),
    negation0(_15920,_16021,_16020,_16038),
    so0(_16050,_16038,_16065),
    w(adj2(_15915,nil),_16074,_16065,_16091),
    w(prep(for),_16103,_16091,_16120),
    object(_15931,_15932,_16132,_16120,_16151),
    cc(å,_16151,_16176),
    !,
    pushstack(first,(xnp(_15931,_15932),[vil]),nil,_16176,_16226),clausal_object1(_15944,_15945,_16182,_16226,_16241),
    pushstack(first,(xnp(_15944,_15945),be,w(adj2(_15915,nil))),nil,_16241,_16325),
    substatement1(_15872,_16256,_16325,_15974).

isq(_15872,[isq,_15961,_15985,_16014,_16043,_16067,_16096,!,_16135],_15947,_15949) --> 
    be(_15961,_15947,_15976),
    thereit(_15911,_15985,_15976,_16002),
    negation0(_15913,_16014,_16002,_16031),
    so0(_16043,_16031,_16058),
    w(adj2(_15917,nil),_16067,_16058,_16084),
    prepnog(_15917,_15909,_16096,_16084,_16115),
    !,
    pushstack(first,(something,be,w(adj2(_15917,nil)),w(prep(_15909))),nil,_16115,_16201),
    substatement1(_15872,_16135,_16201,_15949).

isq(_15872,[isq,_15981,_16005,_16034,_16063,_16092,_16116,{},lit(å),!,_16171],_15967,_15969) --> 
    be(_15981,_15967,_15996),
    negation0(_15915,_16005,_15996,_16022),
    thereit(_15917,_16034,_16022,_16051),
    negation0(_15919,_16063,_16051,_16080),
    so0(_16092,_16080,_16107),
    w(adj2(_15923,nil),_16116,_16107,_16133),
    {user:(\+testmember(_15923,[]))},
    cc(å,_16133,_16165),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_15923,nil)),[å]),nil,_16165,_16181),
    substatement1(_15872,_16171,_16181,_15969).

isq(_15872,[isq,_15961,_15985,_16014,_16043,_16072,_16096,!,_16130],_15947,_15949) --> 
    be(_15961,_15947,_15976),
    negation0(_15909,_15985,_15976,_16002),
    thereit(_15911,_16014,_16002,_16031),
    negation0(_15913,_16043,_16031,_16060),
    so0(_16072,_16060,_16087),
    w(adj2(_15906,nil),_16096,_16087,_16113),
    !,
    pushstack(first,([noe],w(verb(be,pres,fin)),w(adj2(_15906,nil))),nil,_16113,_16140),
    substatement1(_15872,_16130,_16140,_15949).

isq(_15872,[isq,_15935,_15959,_15983,!,_16017],_15921,_15923) --> 
    be(_15935,_15921,_15950),
    dette(_15959,_15950,_15974),
    negation0(_15898,_15983,_15974,_16000),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin))),nil,_16000,_16027),
    substatement1(_15872,_16017,_16027,_15923).

isq(_15872,[isq,_15933,_15957,_15981,!,_16010],_15919,_15921) --> 
    be(_15933,_15919,_15948),
    thereit(_15957,_15948,_15972),
    ikkeingen0(_15981,_15972,_15996),
    !,
    pushstack(free,([det],w(verb(be,pres,fin))),nil,_15996,_16020),
    substatement1(_15872,_16010,_16020,_15921).

isq(_15872,[isq,_15944,_15968,_15997,_16031,!,_16065],_15930,_15932) --> 
    be(_15944,_15930,_15959),
    negation0(_15901,_15968,_15959,_15985),
    subject(_15903,_15904,_15997,_15985,_16016),
    negation0(_15906,_16031,_16016,_16048),
    !,
    pushstack(first,(xnp(_15903,_15904),w(verb(be,pres,fin))),nil,_16048,_16106),
    substatement1(_15872,_16065,_16106,_15932).

isq(_15872,[isq,_15930,_15954,_15978,!,_16012],_15916,_15918) --> 
    be(_15930,_15916,_15945),
    det0(_15954,_15945,_15969),
    negation0(_15895,_15978,_15969,_15995),
    !,
    pushstack(free,w(verb(be,pres,fin)),nil,_15995,_16022),
    substatement1(_15872,_16012,_16022,_15918).

ikkeingen0([ikkeingen0,lit(ingen),!],_15892,_15894) --> 
    cc(ingen,_15892,_15894),
    !.

ikkeingen0([ikkeingen0,_15900],_15889,_15891) --> 
    negation0(_15872,_15900,_15889,_15891).

ynqs(_15872,[ynqs,_15919,_15948,!,_15987],_15905,_15907) --> 
    isynq(_15883,_15919,_15905,_15936),
    orwill(_15883,_15872,_15948,_15936,_15967),
    !,
    accept(_15987,_15967,_15907).

isynq(_15872,[isynq,_15907],_15893,_15895) --> 
    isq(_15872,_15907,_15893,_15895).

isynq(_15872,[isynq,_15907],_15893,_15895) --> 
    ynq(_15872,_15907,_15893,_15895).

orwill(_15872,_15872,[orwill,lit(eller),_15933,!,_15962],_15905,_15907) --> 
    cc(eller,_15905,_15932),
    endofline(_15933,_15932,_15948),
    !,
    accept(_15962,_15948,_15907).

orwill(_15872,_15872 or _15876,[orwill,lit(eller),_15954,!,_15988,_16012,_16041],_15926,_15928) --> 
    cc(eller,_15926,_15953),
    not_look_ahead(w(nb(_15902,_15903)),_15954,_15953,_15971),
    !,
    accept(_15988,_15971,_16003),
    isynq(_15893,_16012,_16003,_16029),
    orwill(_15893,_15876,_16041,_16029,_15928).

orwill(_15872,_15872,[orwill,[]],_15894,_15894) --> 
    [].

ynq(_15872,[ynq,_15967,{},lit(det),_16017,_16046,!,_16080],_15953,_15955) --> 
    w(verb(_15900,_15901,fin),_15967,_15953,_15984),
    {user:(\+testmember(_15900,[be,have]))},
    cc(det,_15984,_16016),
    negation0(_15923,_16017,_16016,_16034),
    look_ahead(w(adj2(_15929,_15930)),_16046,_16034,_16063),
    !,
    pushstack(free,([dette],w(verb(_15900,_15901,fin))),nil,_16063,_16090),
    statreal(_15872,_16080,_16090,_15955).

ynq(_15872,[ynq,_15982,{},lit(det),_16032,lit(å),_16077,!,_16125],_15968,_15970) --> 
    w(verb(_15909,_15910,fin),_15982,_15968,_15999),
    {user:testmember(_15909,[cost])},
    cc(det,_15999,_16031),
    np0_accept(_15904,_15905,_16032,_16031,_16051),
    cc(å,_16051,_16076),
    pushstack(first,([noen],[vil]),nil,_16076,_16090),clausal_object1(_15935,_15936,_16077,_16090,_16105),
    !,
    pushstack(first,(xnp(_15935,_15936),w(verb(_15909,pres,fin)),xnp(_15904,_15905)),nil,_16105,_16197),
    statreal1(_15872,_16125,_16197,_15970).

ynq(_15872,[ynq,_15959,lit(det),_15994,_16023,_16052,_16086,_16110,!,_16184],_15945,_15947) --> 
    aux1(_15959,_15945,_15974),
    cc(det,_15974,_15993),
    negation0(_15900,_15994,_15993,_16011),
    w(verb(happen,inf,fin),_16023,_16011,_16040),
    subject(_15908,_15909,_16052,_16040,_16071),
    not_look_ahead_vp(_16086,_16071,_16101),
    pushstack(first,(xnp(_15908,_15909),w(verb(happen,pres,fin))),nil,_16101,_16154),statreal1(_15872,_16110,_16154,_16167),
    !,
    accept(_16184,_16167,_15947).

ynq(_15872,[ynq,lit(kan),_15963,_15992,_16026,_16055,_16079,!,_16153],_15938,_15940) --> 
    cc(kan,_15938,_15962),
    negation0(_15897,_15963,_15962,_15980),
    subject(_15899,_15900,_15992,_15980,_16011),
    negation0(_15902,_16026,_16011,_16043),
    not_look_ahead_vp(_16055,_16043,_16070),
    pushstack(first,(xnp(_15899,_15900),w(verb(know1,pres,fin))),nil,_16070,_16123),statreal1(_15872,_16079,_16123,_16136),
    !,
    accept(_16153,_16136,_15940).

ynq(_15872,[ynq,lit(_15897),{},_15977,_16006,_16040,!,_16074],_15942,_15944) --> 
    cc(_15897,_15942,_15966),
    {user:testmember(_15897,[får,kan,kunne])},
    negation0(_15913,_15977,_15966,_15994),
    subject(_15915,_15916,_16006,_15994,_16025),
    negation0(_15918,_16040,_16025,_16057),
    !,
    pushstack(first,(xnp(_15915,_15916),[_15897]),nil,_16057,_16115),
    statreal1(_15872,_16074,_16115,_15944).

ynq(_15872,[ynq,_15969,_15993,_16027,_16056,{},_16095,!,_16129],_15955,_15957) --> 
    aux1(_15969,_15955,_15984),
    subject(_15907,_15908,_15993,_15984,_16012),
    w(verb(_15903,inf,fin),_16027,_16012,_16044),
    not_look_ahead(w(verb(_15920,_15921,_15922)),_16056,_16044,_16073),
    {user:(\+verbtype(_15903,rv))},
    negation0(_15931,_16095,_16073,_16112),
    !,
    pushstack(first,(xnp(_15907,_15908),w(verb(_15903,pres,fin))),nil,_16112,_16170),
    statreal1(_15872,_16129,_16170,_15957).

ynq(_15872,[ynq,lit(så),!,_15929],_15899,_15901) --> 
    cc(så,_15899,_15923),
    !,
    reject(_15929,_15923,_15901).

ynq(_15872,[ynq,_15966,_15990,_16019,lit(av),!,_16069,_16093,_16117,_16146],_15952,_15954) --> 
    aux1(_15966,_15952,_15981),
    not_look_ahead(w(verb(go,_15914,_15915)),_15990,_15981,_16007),
    subject(_15917,_15918,_16019,_16007,_16038),
    cc(av,_16038,_16063),
    !,
    accept(_16069,_16063,_16084),
    adverbx0(_16093,_16084,_16108),
    negation0(_15922,_16117,_16108,_16134),
    pushstack(first,(xnp(_15917,_15918),w(verb(go,pres,fin)),[av]),nil,_16134,_16187),
    statreal1(_15872,_16146,_16187,_15954).

ynq(_15872,[ynq,_15981,_16005,_16034,_16068,_16092,{},!,_16136,_16160,_16184,_16213],_15967,_15969) --> 
    aux1(_15981,_15967,_15996),
    not_look_ahead(w(verb(go,_15922,_15923)),_16005,_15996,_16022),
    subject(_15925,_15926,_16034,_16022,_16053),
    redundant0(_16068,_16053,_16083),
    w(prep(_15915),_16092,_16083,_16109),
    {user:_15915\==av},
    !,
    accept(_16136,_16109,_16151),
    adverbx0(_16160,_16151,_16175),
    negation0(_15937,_16184,_16175,_16201),
    pushstack(first,(xnp(_15925,_15926),w(verb(go,pres,fin)),w(prep(_15915))),nil,_16201,_16254),
    statreal1(_15872,_16213,_16254,_15969).

ynq(_15872,[ynq,_15996,_16030,_16059,_16088,_16117,_16146,_16180,_16219,!,_16253,_16277,_16301,[],_16376,!,_16478],_15982,_15984) --> 
    aux1(_15919,_15920,_15996,_15982,_16015),
    negation0(_15922,_16030,_16015,_16047),
    not_look_ahead([man],_16059,_16047,_16076),
    not_look_ahead([jeg],_16088,_16076,_16105),
    not_look_ahead([du],_16117,_16105,_16134),
    subject(_15936,_15937,_16146,_16134,_16165),
    preadverbial0(_15939,_15940,_15941,_16180,_16165,_16201),
    negation0(_15943,_16219,_16201,_16236),
    !,
    accept(_16253,_16236,_16268),
    adverbx0(_16277,_16268,_16292),
    negation0(_15945,_16301,_16292,_16318),
    pushstack(free,adverbial1(_15939,_15940,_15941),nil,_16318,_16375),[],
    pushstack(first,(noun_phrase1(_15936,_15937),aux1),nil,_16375,_16448),statreal1(_15872,_16376,_16448,_16461),
    !,
    accept(_16478,_16461,_15984).

ynq(_15872,[ynq,_15949,_15973,_15997,{},!,_16041],_15935,_15937) --> 
    do(_15949,_15935,_15964),
    you(_15973,_15964,_15988),
    w(verb(_15894,_15901,fin),_15997,_15988,_16014),
    {user:testmember(_15894,[list,show])},
    !,
    pushstack(first,w(verb(_15894,imp,fin)),nil,_16014,_16051),
    command(doit:::_15872,_16041,_16051,_15937).

ynq(_15872,[ynq,_15915,_15939,_15968],_15901,_15903) --> 
    do(_15915,_15901,_15930),
    negation0(_15882,_15939,_15930,_15956),
    statreal1(_15872,_15968,_15956,_15903).

ynq(_15872,[ynq,_15916,_15940,!,_15974],_15902,_15904) --> 
    aux1(_15916,_15902,_15931),
    prep(_15883,_15940,_15931,_15957),
    !,
    reject(_15974,_15957,_15904).

ynq(_15872,[ynq,_15984,_16013,lit(det),_16058,lit(å),!,_16108,_16151],_15970,_15972) --> 
    w(verb(_15909,_15910,fin),_15984,_15970,_16001),
    gmem(_15909,[cost,take,be],_16013,_16001,_16032),
    cc(det,_16032,_16057),
    np0_accept(_15904,_15905,_16058,_16057,_16077),
    cc(å,_16077,_16102),
    !,
    pushstack(first,([noen],[vil]),nil,_16102,_16121),clausal_object1(_15937,_15938,_16108,_16121,_16136),
    pushstack(first,(xnp(_15937,_15938),w(verb(_15909,pres,fin)),xnp(_15904,_15905)),nil,_16136,_16223),
    statreal1(_15872,_16151,_16223,_15972).

ynq(_15872,[ynq,_15945,{},_15984,!,_16018],_15931,_15933) --> 
    w(verb(_15891,_15892,fin),_15945,_15931,_15962),
    {user:testmember(_15891,[know,find])},
    negation0(_15910,_15984,_15962,_16001),
    !,
    pushstack(free,w(verb(_15891,_15892,fin)),nil,_16001,_16028),
    statreal1(_15872,_16018,_16028,_15933).

ynq(_15872,[ynq,_15962,{},{},_16026,_16055,!,_16084],_15948,_15950) --> 
    lexv(tv,_15897,_15898,fin,_15962,_15948,_15985),
    {user:_15898\==imp},
    {user:(\+testmember(_15897,[have,think]))},
    not_look_ahead(w(adj2(_15926,_15927)),_16026,_15985,_16043),
    anyadverb0(_16055,_16043,_16070),
    !,
    pushstack(free,w(verb(_15897,_15898,fin)),nil,_16070,_16094),
    statreal1(_15872,_16084,_16094,_15950).

ynq(_15872,[ynq,_15945,_15989,lit(til),lit(å),!,_16050],_15931,_15933) --> 
    lexv(iv,come,_15899,fin,_15945,_15931,_15968),
    subject(_15902,_15903,_15989,_15968,_16008),
    cc(til,_16008,_16033),
    cc(å,_16033,_16044),
    !,
    pushstack(first,(xnp(_15902,_15903),[vil]),nil,_16044,_16091),
    statreal(_15872,_16050,_16091,_15933).

ynq(_15872,[ynq,_15954,_15998,_16032,lit(hva),!,_16077],_15940,_15942) --> 
    lexv(rv,know,_15902,fin,_15954,_15940,_15977),
    subject(_15905,_15906,_15998,_15977,_16017),
    negation0(_15908,_16032,_16017,_16049),
    cc(hva,_16049,_16071),
    !,
    pushstack(first,(xnp(_15905,_15906),w(verb(know,_15902,fin)),[hva]),nil,_16071,_16118),
    statreal(_15872,_16077,_16118,_15942).

ynq(_15872,[ynq,_15947,_15991,_16025,!,_16054],_15933,_15935) --> 
    lexv(rv,_15898,_15899,fin,_15947,_15933,_15970),
    subject(_15902,_15903,_15991,_15970,_16010),
    infinitive(_16025,_16010,_16040),
    !,
    pushstack(first,(xnp(_15902,_15903),w(verb(_15898,_15899,fin)),[å]),nil,_16040,_16095),
    statreal(_15872,_16054,_16095,_15935).

ynq(_15872,[ynq,_16000,{},_16039,_16068,_16097,_16136,_16170,_16199,_16228,!,_16262],_15986,_15988) --> 
    w(verb(_15919,_15920,fin),_16000,_15986,_16017),
    {user:(\+testmember(_15919,[be,have]))},
    not_look_ahead([det],_16039,_16017,_16056),
    not_look_ahead(w(adj2(_15942,_15943)),_16068,_16056,_16085),
    adverb0(_15915,_15946,_15947,_16097,_16085,_16118),
    subject(_15949,_15950,_16136,_16118,_16155),
    reflexiv0(_15919,_16170,_16155,_16187),
    negation0(_15954,_16199,_16187,_16216),
    rep_particlev0(_15919,_16228,_16216,_16245),
    !,
    pushstack(free,(xnp(_15949,_15950),w(verb(_15919,_15920,fin)),w(adv(_15915))),nil,_16245,_16303),
    statreal(_15872,_16262,_16303,_15988).

ynq(_15872,[ynq,_15957,_15986,_16020,!,_16049,_16073,_16097,_16126,!,_16200],_15943,_15945) --> 
    w(verb(reach,pres,fin),_15957,_15943,_15974),
    np1_accept(_15907,_15910::_15911,_15986,_15974,_16005),
    infinitive(_16020,_16005,_16035),
    !,
    accept(_16049,_16035,_16064),
    adverbx0(_16073,_16064,_16088),
    negation0(_15913,_16097,_16088,_16114),
    pushstack(first,noun_phrase1(_15907,_15910::_15911),nil,_16114,_16170),statreal1(_15872,_16126,_16170,_16183),
    !,
    accept(_16200,_16183,_15945).

ynq(_15872,[ynq,_15922,_15951,!,_15980],_15908,_15910) --> 
    not_look_ahead(w(verb(go,_15888,fin)),_15922,_15908,_15939),
    be(_15951,_15939,_15966),
    !,
    reject(_15980,_15966,_15910).

ynq(_15872,[ynq,_15940,!,_15974,_15998],_15926,_15928) --> 
    w(verb(_15891,pres,pass),_15940,_15926,_15957),
    !,
    thereit0(_15974,_15957,_15989),
    pushstack(free,(w(verb(be,pres,fin)),w(verb(_15891,past,part))),nil,_15989,_16008),
    isq(_15872,_15998,_16008,_15928).

ynq(_15872,[ynq,_15931,_15960,_15989,!,_16023],_15917,_15919) --> 
    w(verb(want,pres,fin),_15931,_15917,_15948),
    not_look_ahead([du],_15960,_15948,_15977),
    not_look_ahead([jeg],_15989,_15977,_16006),
    !,
    reject(_16023,_16006,_15919).

ynq(_15872,[ynq,_15933,_15962,_15986,_16015,!,_16044],_15919,_15921) --> 
    w(verb(go,_15895,fin),_15933,_15919,_15950),
    thereit(_15962,_15950,_15977),
    negation0(_15898,_15986,_15977,_16003),
    anaa(_16015,_16003,_16030),
    !,
    pushstack(first,someone,nil,_16030,_16082),
    statement(_15872,_16044,_16082,_15921).

ynq(_15872,[ynq,_15949,lit(det),{},!,_16019],_15935,_15937) --> 
    lexv(iv,_15894,_15895,fin,_15949,_15935,_15972),
    cc(det,_15972,_16003),
    {user:testmember(_15894,[rain,snow])},
    !,
    pushstack(first,([det],w(verb(_15894,_15895,fin))),nil,_16003,_16029),
    statement(_15872,_16019,_16029,_15937).

ynq(_15872,[ynq,_15959,lit(det),_15999,_16028,!,_16062],_15945,_15947) --> 
    w(verb(_15897,_15898,fin),_15959,_15945,_15976),
    cc(det,_15976,_15998),
    look_ahead(w(prep(_15913)),_15999,_15998,_16016),
    not_look_ahead([e],_16028,_16016,_16045),
    !,
    pushstack(first,(w(noun(vehicle,plu,u,n)),w(verb(_15897,_15898,fin))),nil,_16045,_16072),
    statement(_15872,_16062,_16072,_15947).

ynq(_15872,[ynq,_15953,{},_15992,_16021,!,_16055],_15939,_15941) --> 
    w(verb(_15897,_15898,fin),_15953,_15939,_15970),
    {user:(\+rv_templ(_15897,_15912))},
    negation0(_15914,_15992,_15970,_16009),
    thereit(_15916,_16021,_16009,_16038),
    !,
    pushstack(first,([det],w(verb(_15897,_15898,fin))),nil,_16038,_16065),
    statement(_15872,_16055,_16065,_15941).

ynq(_15872,[ynq,_15960,_15989,_16018,_16047,{},_16081,!,_16115],_15946,_15948) --> 
    w(verb(_15900,_15901,fin),_15960,_15946,_15977),
    not_look_ahead(w(verb,_15913,_15914),_15989,_15977,_16006),
    not_look_ahead([det],_16018,_16006,_16035),
    saa0(_16047,_16035,_16062),
    {user:_15900\==have},
    negation0(_15925,_16081,_16062,_16098),
    !,
    pushstack(free,w(verb(_15900,_15901,fin)),nil,_16098,_16125),
    statreal(_15872,_16115,_16125,_15948).

ynq(_15872,[ynq,{},_15949,_15978,!,_16007],_15925,_15927) --> 
    {user:value(smsflag,true)},
    w(verb(have,pres,fin),_15949,_15925,_15966),
    look_ahead_bus(_15978,_15966,_15993),
    !,
    pushstack(free,w(verb(go,pres,fin)),nil,_15993,_16017),
    statreal(_15872,_16007,_16017,_15927).

ynq(_15872,[ynq,_15957,_15986,{},_16040,{},_16074,!,_16103],_15943,_15945) --> 
    not_look_ahead([vil],_15957,_15943,_15974),
    lexv(iv,_15899,_15900,fin,_15986,_15974,_16009),
    {user:(\+rv_templ(_15899,_15917))},
    saa0(_16040,_16009,_16055),
    {user:_15900\==imp},
    anyadverb0(_16074,_16055,_16089),
    !,
    lock(last,_16089,_16153),
    pushstack(last,lexv(iv,_15899,_15900,fin),nil,_16153,_16159),
    statreal1(_15872,_16103,_16159,_16148),
    unlock(_16148,_15945).

look_ahead_bus([look_ahead_bus,_15921,{}],_15910,_15912) --> 
    look_ahead(w(noun(_15877,_15891,_15892,n)),_15921,_15910,_15912),
    {user:testmember(_15877,[bus,nightbus,number])}.

look_ahead_bus([look_ahead_bus,_15905],_15894,_15896) --> 
    look_ahead(w(adj2(next,nil)),_15905,_15894,_15896).

ppq(_15874:::_15875,[ppq,_16007,_16036,_16075,!,_16109,!,_16148,_16172,_16297],_15993,_15995) --> 
    prep(_15920,_16007,_15993,_16024),
    whx_phrase(_15922,_15874,_15926::_15927,_16036,_16024,_16057),
    w(verb(_15931,pres,pass),_16075,_16057,_16092),
    !,
    noun_phrase1(_15935,_15938::_15939,_16109,_16092,_16128),
    !,
    accept(_16148,_16128,_16163),
    lock(exact,_16163,_16256),pushstack(exact,(prep(_15920),noun_phrase1(_15922,_15926::_15927)),nil,_16256,_16262),adverbial1(_15913,_15914,_15917::_15918,_16172,_16262,_16251),unlock(_16251,_16252),
    pushstack(first,(someone,w(verb(_15931,pres,fin)),noun_phrase1(_15935,_15938::_15939),adverbial1(_15913,_15914,_15917::_15918)),nil,_16252,_16404),
    statreal(_15875,_16297,_16404,_15995).

ppq(_15874:::_15875,[ppq,_15954,_15983,{},!,_16037,_16081,!,_16115],_15940,_15942) --> 
    prepnof(_15898,_15954,_15940,_15971),
    whx_phrase(_15900,_15874,_15904::_15905,_15983,_15971,_16004),
    {user:adjustprep(_15900,_15898,_15911)},
    !,
    forwq(_15875,_15911,_15900,_15904::_15905,_16037,_16004,_16060),
    optionalprep(_15911,_16081,_16060,_16098),
    !,
    accept(_16115,_16098,_15942).

optionalprep(in,[optionalprep,_15913,!,_15947],_15899,_15901) --> 
    prep1(_15880,_15913,_15899,_15930),
    !,
    accept(_15947,_15930,_15901).

optionalprep(_15872,[optionalprep,[]],_15891,_15891) --> 
    [].

forwq(_15872,_15873,_15874,_15877::_15878,[forwq,_15961,!,_16010,_16034],_15938,_15940) --> 
    lexv(_15902,be1,_15904,fin,_15961,_15938,_15984),
    !,
    thereit0(_16010,_15984,_16025),
    pushstack(free,(w(verb(be1,pres,fin)),adverbial1(_15873,_15874,_15877::_15878)),nil,_16025,_16079),
    statreal(_15872,_16034,_16079,_15940).

forwq(_15872,_15873,_15874,_15877::_15878,[forwq,_15944,!,_15973],_15921,_15923) --> 
    do(_15944,_15921,_15959),
    !,
    pushstack(free,adverbial1(_15873,_15874,_15877::_15878),nil,_15959,_16018),
    statreal(_15872,_15973,_16018,_15923).

forwq(_15872,_15873,_15874,_15877::_15878,[forwq,_15967,{},_16006,_16030],_15944,_15946) --> 
    w(verb(_15904,_15905,_15906),_15967,_15944,_15984),
    {user:_15904\==understand},
    thereit0(_16006,_15984,_16021),
    pushstack(free,(w(verb(_15904,_15905,_15906)),adverbial1(_15873,_15874,_15877::_15878)),nil,_16021,_16075),
    statreal(_15872,_16030,_16075,_15946).

whichq(_15874:::_15877 and _15878,[whichq,_15986,_16025,_16054,_16078,_16102,!,_16136,_16160],_15972,_15974) --> 
    whx_phrase(_15916,_15874,true::_15877,_15986,_15972,_16007),
    w(verb(recommend,_15928,pass),_16025,_16007,_16042),
    det0(_16054,_16042,_16069),
    infinitive(_16078,_16069,_16093),
    w(verb(_15933,inf,_15935),_16102,_16093,_16119),
    !,
    accept(_16136,_16119,_16151),
    pushstack(first,([noen],w(verb(recommend,_15928,fin)),[å],w(verb(_15933,inf,_15953)),npgap(_15916)),nil,_16151,_16201),
    statreal(_15878,_16160,_16201,_15974).

whichq(_15874:::_15877 and _15878,[whichq,_15964,_16003,_16027,_16056,!,_16095],_15950,_15952) --> 
    whx_phrase(_15904,_15874,true::_15877,_15964,_15950,_15985),
    paux0(_16003,_15985,_16018),
    w(verb(_15915,_15916,pass),_16027,_16018,_16044),
    whodidit(_15919,_15920,_16056,_16044,_16075),
    !,
    pushstack(first,(xnp(_15919,_15920),w(verb(_15915,_15916,fin)),npgap(_15904)),nil,_16075,_16166),
    statreal(_15878,_16095,_16166,_15952).

whichq(_15874:::_15875,[whichq,_15939,_15978,_16017,{}],_15925,_15927) --> 
    whx_phrase(_15892,_15874,_15890::_15875,_15939,_15925,_15960),
    realcomp(_15899,_15900,_15889,_15978,_15960,_15999),
    qverb_phrase(_15892,_15888,_15899,_15900,_16017,_15999,_15927),
    {user:negate(_15888,_15889,_15890)}.

whx_phrase(_15872,_15873,_15876::_15877,[whx_phrase,{},_15998,_16032,{},!,_16076,!,_16137],_15968,_15970) --> 
    {user:value(busflag,true)},
    whichf(_15872,_15873,_15998,_15968,_16017),
    look_ahead(w(verb(_15912,_15913,fin)),_16032,_16017,_16049),
    {user:testmember(_15912,[go,pass,leave,depart,arrive])},
    !,
    lock(exact,_16049,_16096),pushstack(exact,w(noun(vehicle,plu,u,n)),nil,_16096,_16102),noun_phrase1(_15872,_15876::_15877,_16076,_16102,_16091),unlock(_16091,_16092),
    !,
    accept(_16137,_16092,_15970).

whx_phrase(_15872,_15873,_15876::_15877,[whx_phrase,_15966,_16000,_16024,_16053,!,_16082],_15946,_15948) --> 
    whichf(_15872,_15873,_15966,_15946,_15985),
    oter(_16000,_15985,_16015),
    w(noun(_15907,_15908,u,n),_16024,_16015,_16041),
    enn(_16053,_16041,_16068),
    !,
    pushstack(first,(w(noun(_15907,_15908,u,n)),[ulik]),nil,_16068,_16092),
    noun_phrase1(_15872,_15876::_15877,_16082,_16092,_15948).

whx_phrase(_15872,which(_15872),_15876::_15877,[whx_phrase,_15973,_15997,_16026,{},!,_16070],_15953,_15955) --> 
    hvordan(_15973,_15953,_15988),
    not_look_ahead(w(verb(_15910,pres,fin)),_15997,_15988,_16014),
    w(noun(_15901,_15917,_15918,_15919),_16026,_16014,_16043),
    {user:_15901\==type},
    !,
    pushstack(first,w(noun(_15901,sin,u,n)),nil,_16043,_16080),
    noun_phrase1(_15872,_15876::_15877,_16070,_16080,_15955).

whx_phrase(_15872,which(_15872),_15876::_15877,[whx_phrase,lit(hva),_15978,_16007,{},!,_16051],_15947,_15949) --> 
    cc(hva,_15947,_15977),
    not_look_ahead(w(verb(_15908,_15909,_15910)),_15978,_15977,_15995),
    look_ahead(w(noun(_15916,_15917,_15918,_15919)),_16007,_15995,_16024),
    {user:_15916\==type},
    !,
    noun_phrase1(_15872,_15876::_15877,_16051,_16024,_15949).

whx_phrase(_15872,_15873,_15876::_15877,[whx_phrase,_15941,_15975,_15999,!,_16038],_15921,_15923) --> 
    whichf(_15872,_15873,_15941,_15921,_15960),
    type0(_15975,_15960,_15990),
    noun_phrase1(_15872,_15876::_15877,_15999,_15990,_16018),
    !,
    accept(_16038,_16018,_15923).

whx_phrase(_15872,_15873,_15876::_15877,[whx_phrase,_15957,_15991,!,_16025,!,_16073],_15937,_15939) --> 
    whichf(_15872,_15873,_15957,_15937,_15976),
    w(nb(_15899,num),_15991,_15976,_16008),
    !,
    pushstack(first,w(nb(_15899,num)),nil,_16008,_16038),noun_phrase1(_15872,_15876::_15877,_16025,_16038,_16053),
    !,
    accept(_16073,_16053,_15939).

whichf(_15872,which(_15872),[whichf,_15913],_15896,_15898) --> 
    which2(_15913,_15896,_15898).

whichg00(_15872,_15873,_15883:_15872,which(_15883):::_15883 isa _15872 and _15873,[whichg00,[]],_15914,_15914) --> 
    [].

qstatement(_15872,_15875:::_15876,[qstatement,{},_15934],_15907,_15909) --> 
    {user:which_thing(_15872,_15875)},
    statreal(_15876,_15934,_15907,_15909).

what_phrase(_15876:thing,which(_15876:thing),_15876 isa thing,[what_phrase,lit(hva)],_15910,_15912) --> 
    cc(hva,_15910,_15912).

whatq(_15872,[whatq,lit(hva),_15992,_16021,_16055,_16089,_16118,!,_16147,_16171],_15967,_15969) --> 
    cc(hva,_15967,_15991),
    w(verb(use,_15920,fin),_15992,_15991,_16009),
    subject(_15923,_15924,_16021,_16009,_16040),
    np1_accept(_15926,_15927,_16055,_16040,_16074),
    prep1(_15929,_16089,_16074,_16106),
    not_look_ahead_np(_16118,_16106,_16133),
    !,
    accept(_16147,_16133,_16162),
    pushstack(first,(xnp(_15923,_15924),w(verb(use,_15920,fin)),np(_15926,_15927),w(prep(_15929)),npgap(_15913)),nil,_16162,_16273),
    qstatement(_15913,_15872,_16171,_16273,_15969).

whatq(which(_15878):::_15877 ako _15878,[whatq,{},_15952,_15976,_16000,_16029,!],_15928,_15930) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_15952,_15928,_15967),
    art1(_15976,_15967,_15991),
    w(noun(_15877,_15907,u,n),_16000,_15991,_16017),
    endofline(_16029,_16017,_15930),
    !.

whatq(which(_15878):::_15877 ako _15878,[whatq,{},_15966,_15990,{},_16029],_15942,_15944) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_15966,_15942,_15981),
    w(noun(_15877,_15904,u,n),_15990,_15981,_16007),
    {user:(\+testmember(_15877,[clock,special_ticket,price,bus,station]))},
    endofline(_16029,_16007,_15944).

whatq(_15872,[whatq,{},_15956,_15980,_16009,!,_16038],_15932,_15934) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_15956,_15932,_15971),
    look_ahead(w(name(_15909,_15910,_15911)),_15980,_15971,_15997),
    redundant0(_16009,_15997,_16024),
    !,
    pushstack(first,w(verb(describe,imp,fin)),nil,_16024,_16048),
    command(_15872,_16038,_16048,_15934).

whatq(which(_15879:thing):::_15875,[whatq,lit(hva),_15988,_16032,_16066,_16100,_16134],_15963,_15965) --> 
    cc(hva,_15963,_15987),
    lexv(tv,_15914,_15915,fin,_15988,_15987,_16011),
    gmem(_15914,[hold,keep,drive,operate],_16032,_16011,_16051),
    subject(_15929,_15930,_16066,_16051,_16085),
    particlev2(_15914,_15933,_16100,_16085,_16119),
    pushstack(first,(xnp(_15929,_15930),w(verb(_15933,pres,fin)),npgap(_15879:thing)),nil,_16119,_16206),
    statreal(_15875,_16134,_16206,_15965).

whatq(_15874:::_15875,[whatq,{},lit(hva),_16025,_16049,_16083,_16112,lit(kunne),_16167,!,_16201],_15990,_15992) --> 
    {user:which_thing(_15922,_15874)},
    cc(hva,_15990,_16024),
    has(_16025,_16024,_16040),
    subject(_15931,_15932,_16049,_16040,_16068),
    w(verb(expect,past,part),_16083,_16068,_16100),
    optional([at],_16112,_16100,_16144),
    cc(kunne,_16144,_16166),
    w(verb(_15948,_15949,pass),_16167,_16166,_16184),
    !,
    pushstack(first,(xnp(_15931,_15932),w(verb(expect,past,fin)),[at],[noen],w(verb(_15948,pres,fin)),npgap(_15922)),nil,_16184,_16272),
    statreal(_15875,_16201,_16272,_15992).

whatq(_15874:::_15877 and _15878,[whatq,_15961,_16000,_16024,_16053,!,_16092],_15947,_15949) --> 
    what_phrase(_15904,_15874,_15877,_15961,_15947,_15982),
    paux0(_16000,_15982,_16015),
    w(verb(_15912,_15913,pass),_16024,_16015,_16041),
    whodidit(_15916,_15917,_16053,_16041,_16072),
    !,
    pushstack(first,(xnp(_15916,_15917),w(verb(_15912,_15913,fin)),npgap(_15904)),nil,_16072,_16163),
    statreal(_15878,_16092,_16163,_15949).

whatq(_15874:::_15877 and _15878,[whatq,_15998,_16037,{},_16091,_16125,_16159,!,_16198,[],_16271],_15984,_15986) --> 
    what_phrase(_15922,_15874,_15877,_15998,_15984,_16019),
    lexv(rv,_15927,_15928,fin,_16037,_16019,_16060),
    {user:(\+testmember(_15927,[]))},
    subject(_15938,_15939,_16091,_16060,_16110),
    that0(_15927,that,_16125,_16110,_16144),
    subject(_15919,_15920,_16159,_16144,_16178),
    !,
    negation0(_15947,_16198,_16178,_16215),
    pushstack(free,npgap(_15922),nil,_16215,_16270),[],
    pushstack(first,(xnp(_15938,_15939),w(verb(_15927,pres,fin)),[at],xnp(_15919,_15920)),nil,_16270,_16343),
    statreal(_15878,_16271,_16343,_15986).

whatq(_15874:::_15877 and _15878,[whatq,_15961,_16000,lit(det),_16040,_16084,!,_16123],_15947,_15949) --> 
    what_phrase(_15904,_15874,_15877,_15961,_15947,_15982),
    w(verb(be,_15913,fin),_16000,_15982,_16017),
    cc(det,_16017,_16039),
    optional([som],_16040,_16039,_16072),
    specific_phrase(_15922,_15923,_16084,_16072,_16103),
    !,
    pushstack(free,(xnp(_15922,_15923),npgap(_15904)),nil,_16103,_16194),
    statreal(_15878,_16123,_16194,_15949).

whatq(which(_15879:thing):::_15875,[whatq,lit(hva),_15988,_16032,_16056,_16090,_16119,_16148],_15963,_15965) --> 
    cc(hva,_15963,_15987),
    lexv(rv,_15920,_15921,fin,_15988,_15987,_16011),
    look_ahead_subject(_16032,_16011,_16047),
    np0_accept(_15924,_15925,_16056,_16047,_16075),
    negation0(_15927,_16090,_16075,_16107),
    prepnom(_15929,_16119,_16107,_16136),
    pushstack(first,(xnp(_15924,_15925),w(verb(_15920,pres,fin)),w(prep(_15929)),npgap(_15879:thing)),nil,_16136,_16222),
    statreal(_15875,_16148,_16222,_15965).

whatq(_15874:::_15877 and _15878,[whatq,_15989,_16028,{},_16082,_16116,_16145,_16174,_16203],_15975,_15977) --> 
    what_phrase(_15910,_15874,_15877,_15989,_15975,_16010),
    lexv(tv,do,_15918,fin,_16028,_16010,_16051),
    {user:(\+testmember(do,[cost,be2,have]))},
    subject(_15934,_15935,_16082,_16051,_16101),
    not_look_ahead([at],_16116,_16101,_16133),
    not_look_ahead([å],_16145,_16133,_16162),
    negation0(_15945,_16174,_16162,_16191),
    pushstack(first,(xnp(_15934,_15935),w(verb(do,pres,fin)),npgap(_15910)),nil,_16191,_16274),
    statreal(_15878,_16203,_16274,_15977).

whatq(_15874:::_15875,[whatq,{},lit(hva),_15985,_16009,_16043,!,_16077],_15950,_15952) --> 
    {user:which_thing(_15904,_15874)},
    cc(hva,_15950,_15984),
    has(_15985,_15984,_16000),
    subject(_15913,_15914,_16009,_16000,_16028),
    w(verb(_15918,past,part),_16043,_16028,_16060),
    !,
    pushstack(first,(xnp(_15913,_15914),w(verb(_15918,past,fin)),npgap(_15904)),nil,_16060,_16148),
    statreal(_15875,_16077,_16148,_15952).

whatq(_15874:::_15875,[whatq,{},lit(hva),_16020,_16044,_16078,_16132,!,_16166,_16283],_15985,_15987) --> 
    {user:which_thing(_15915,_15874)},
    cc(hva,_15985,_16019),
    has(_16020,_16019,_16035),
    subject(_15920,_15921,_16044,_16035,_16063),
    noun(_15923,_15924,_15925,_15926,_15910,_15928,_16078,_16063,_16105),
    prepnom(_15930,_16132,_16105,_16149),
    !,
    lock(exact,_16149,_16247),pushstack(exact,(noun(_15923,_15924,_15925,_15926,_15910,_15928),w(prep(_15930)),npgap(_15915)),nil,_16247,_16253),np1(_15910,_15911,_16166,_16253,_16242),unlock(_16242,_16243),
    pushstack(first,(xnp(_15920,_15921),w(verb(have,pres,fin)),xnp(_15910,_15911)),nil,_16243,_16355),
    statreal(_15875,_16283,_16355,_15987).

whatq(which(_15879:thing):::_15875,[whatq,lit(hva),_16005,{},lit(det),_16055,lit(å),_16090,!,_16138],_15980,_15982) --> 
    cc(hva,_15980,_16004),
    w(verb(_15924,_15925,fin),_16005,_16004,_16022),
    {user:testmember(_15924,[cost])},
    cc(det,_16022,_16054),
    for0(_16055,_16054,_16070),
    cc(å,_16070,_16089),
    pushstack(first,([noen],[vil]),nil,_16089,_16103),clausal_object1(_15947,_15948,_16090,_16103,_16118),
    !,
    pushstack(first,(xnp(_15947,_15948),w(verb(_15924,pres,fin)),npgap(_15879:thing)),nil,_16118,_16212),
    statreal1(_15875,_16138,_16212,_15982).

for0([for0,lit(for),!],_15892,_15894) --> 
    cc(for,_15892,_15894),
    !.

for0([for0,[]],_15887,_15887) --> 
    [].

whatq(_15874:::_15875,[whatq,lit(hva),_16016,{},lit(det),_16066,!,_16100,{},_16134,_16190],_15991,_15993) --> 
    cc(hva,_15991,_16015),
    w(verb(_15919,_15920,fin),_16016,_16015,_16033),
    {user:testmember(_15919,[cost,weigh])},
    cc(det,_16033,_16065),
    look_ahead(w(prep(_15938)),_16066,_16065,_16083),
    !,
    accept(_16100,_16083,_16115),
    {user:which_thing(_15913,_15874)},
    lock(exact,_16115,_16154),pushstack(exact,w(noun(ticket,sin,u,n)),nil,_16154,_16160),noun_phrase1(_15955,_15958::_15959,_16134,_16160,_16149),unlock(_16149,_16150),
    pushstack(first,(noun_phrase1(_15955,_15958::_15959),lexv(tv,_15919,_15920,fin),npgap(_15913)),nil,_16150,_16295),
    statreal(_15875,_16190,_16295,_15993).

whatq(_15874:::_15877 and _15878,[whatq,_15977,_16016,_16045,_16079,{},!,_16128],_15963,_15965) --> 
    what_phrase(_15907,_15874,_15877,_15977,_15963,_15998),
    w(verb(_15915,_15916,fin),_16016,_15998,_16033),
    gmem(_15915,[cost,weigh],_16045,_16033,_16064),
    np1_accept(_15926,_15927,_16079,_16064,_16098),
    {user:(\+constrain(_15926,place))},
    !,
    pushstack(first,(xnp(_15926,_15927),lexv(tv,_15915,_15916,fin),npgap(_15907)),nil,_16098,_16232),
    statreal(_15878,_16128,_16232,_15965).

whatq(_15874:::_15877 and _15878,[whatq,_15930,_15969,_16008],_15916,_15918) --> 
    what_phrase(_15886,_15874,_15877,_15930,_15916,_15951),
    realcomp(_15888,_15889,_15878,_15969,_15951,_15990),
    qverb_phrase(_15886,id,_15888,_15889,_16008,_15990,_15918).

whatq(which(_15879:thing):::_15875,[whatq,_15961,lit(det),_15996,_16025,_16059,!,_16093],_15947,_15949) --> 
    whatbe(_15961,_15947,_15976),
    cc(det,_15976,_15995),
    not_look_ahead(w(adj2(_15917,nil)),_15996,_15995,_16013),
    subject(_15920,_15921,_16025,_16013,_16044),
    negation0(_15923,_16059,_16044,_16076),
    !,
    pushstack(free,(xnp(_15920,_15921),npgap(_15879:thing)),nil,_16076,_16167),
    statement(_15875,_16093,_16167,_15949).

whatq(_15872,[whatq,_15983,_16007,_16031,_16055,_16084,{},!,_16128],_15969,_15971) --> 
    whatbe(_15983,_15969,_15998),
    so0(_16007,_15998,_16022),
    dent0(_16031,_16022,_16046),
    not_look_ahead(w(nb(_15916,_15917)),_16055,_16046,_16072),
    w(adj2(_15909,nil),_16084,_16072,_16101),
    {user:(\+testmember(_15909,[near,nearest,next]))},
    !,
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin)),w(adj2(_15909,nil))),nil,_16101,_16169),
    whichq(_15872,_16128,_16169,_15971).

whatq(which(_15877):::_15875,[whatq,_15933,_15957,_15981,!,_16015,_16049],_15919,_15921) --> 
    whatbe(_15933,_15919,_15948),
    thereit(_15957,_15948,_15972),
    prep1(for,_15981,_15972,_15998),
    !,
    noun_phrase1(_15877,true::_15875,_16015,_15998,_16034),
    danow0(_16049,_16034,_15921).

whatq(which(_15877):::_15875,[whatq,_15977,lit(det),lit(som),!,_16028,_16052,_16086,_16142],_15963,_15965) --> 
    whatbe(_15977,_15963,_15992),
    cc(det,_15992,_16011),
    cc(som,_16011,_16022),
    !,
    accept(_16028,_16022,_16043),
    np(_15916,_15919::_15920,_16052,_16043,_16071),
    lock(exact,_16071,_16106),pushstack(exact,w(noun(thing,sin,u,n)),nil,_16106,_16112),np(_15877,_15909::_15910,_16086,_16112,_16101),unlock(_16101,_16102),
    pushstack(free,(np(_15916,_15919::_15920),np(_15877,_15909::_15910)),nil,_16102,_16220),
    statreal(_15875,_16142,_16220,_15965).

whatq(which(_15877):::_15875,[whatq,_15957,_15981,_16010,_16039,_16082,!,_16111],_15943,_15945) --> 
    whatbe(_15957,_15943,_15972),
    w(noun(time,_15900,_15901,n),_15981,_15972,_15998),
    look_ahead(w(prep(_15908)),_16010,_15998,_16027),
    pushstack(first,w(noun(departure,sin,u,n)),nil,_16027,_16052),noun_phrase1(_15877,true::_15875,_16039,_16052,_16067),
    danow0(_16082,_16067,_16097),
    !,
    accept(_16111,_16097,_15945).

whatq(_15874:::_15875,[whatq,{},_15977,lit(det),_16012,_16041,_16075,!,_16109],_15953,_15955) --> 
    {user:which_thing(_15904,_15874)},
    whatbe(_15977,_15953,_15992),
    cc(det,_15992,_16011),
    not_look_ahead(w(adj2(_15917,nil)),_16012,_16011,_16029),
    noun_phrase1(_15920,_15923::_15924,_16041,_16029,_16060),
    negation0(_15926,_16075,_16060,_16092),
    !,
    pushstack(free,(np(_15920,_15923::_15924),npgap(_15904)),nil,_16092,_16183),
    statement(_15875,_16109,_16183,_15955).

whatq(which(_15879:thing):::_15875,[whatq,_15974,_15998,_16027,_16056,_16090,_16114,!,_16143],_15960,_15962) --> 
    whatbe(_15974,_15960,_15989),
    not_look_ahead([det],_15998,_15989,_16015),
    not_look_ahead(w(name(_15925,n,_15927)),_16027,_16015,_16044),
    np(_15929,_15930,_16056,_16044,_16075),
    danow0(_16090,_16075,_16105),
    endofline(_16114,_16105,_16129),
    !,
    lock(exact,_16129,_16224),
    pushstack(exact,(xnp(_15929,_15930),w(verb(be,pres,fin)),npgap(_15879:thing)),nil,_16224,_16230),
    statreal(_15875,_16143,_16230,_16219),
    unlock(_16219,_15962).

whatq(which(_15877):::_15875,[whatq,_15940,_15964,_15993,_16022,_16056],_15926,_15928) --> 
    whatbe(_15940,_15926,_15955),
    not_look_ahead([det],_15964,_15955,_15981),
    not_look_ahead(w(name(_15899,n,_15901)),_15993,_15981,_16010),
    np1_accept(_15877,true::_15875,_16022,_16010,_16041),
    danow0(_16056,_16041,_15928).

whatq(which(_15879:thing):::_15875,[whatq,_15980,_16004,_16038,_16067,!,_16101],_15966,_15968) --> 
    whatbe(_15980,_15966,_15995),
    noun_phrase1(_15917,_15918,_16004,_15995,_16023),
    w(verb(_15922,past,part),_16038,_16023,_16055),
    prep(_15926,_16067,_16055,_16084),
    !,
    pushstack(first,(noun_phrase1(_15917,_15918),w(verb(be,pres,fin)),w(verb(_15922,past,part)),w(prep(_15926)),npgap(_15879:thing)),nil,_16084,_16175),
    statement(_15875,_16101,_16175,_15968).

whatq(_15872,[whatq,_15932,_15956],_15918,_15920) --> 
    whatbe(_15932,_15918,_15947),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin))),nil,_15947,_15994),
    whichq(_15872,_15956,_15994,_15920).

whatq(_15872,[whatq,lit(hva),_15991,_16015,_16049,_16078,!,_16112,_16136],_15966,_15968) --> 
    cc(hva,_15966,_15990),
    aux1(_15991,_15990,_16006),
    np1_accept(_15914,_15917::_15918,_16015,_16006,_16034),
    w(verb(use,_15923,pass),_16049,_16034,_16066),
    prep1(_15926,_16078,_16066,_16095),
    !,
    accept(_16112,_16095,_16127),
    pushstack(first,([noen],w(verb(use,_15923,fin)),np(_15914,_15917::_15918),w(prep(_15926)),npgap(_15910)),nil,_16127,_16210),
    qstatement(_15910,_15872,_16136,_16210,_15968).

whatq(_15872,[whatq,lit(hva),_15988,_16017,_16051,!,_16085,_16109],_15963,_15965) --> 
    cc(hva,_15963,_15987),
    w(verb(use,_15914,pass),_15988,_15987,_16005),
    np1_accept(_15917,_15920::_15921,_16017,_16005,_16036),
    prep1(_15923,_16051,_16036,_16068),
    !,
    accept(_16085,_16068,_16100),
    pushstack(first,([noen],w(verb(use,_15914,fin)),np(_15917,_15920::_15921),w(prep(_15923)),npgap(_15907)),nil,_16100,_16183),
    qstatement(_15907,_15872,_16109,_16183,_15965).

whatq(which(_15879:thing):::_15875,[whatq,_15996,_16020,_16054,_16078,_16107,_16136,_16165,{},!,_16209],_15982,_15984) --> 
    whatcan(_15996,_15982,_16011),
    subject(_15926,_15927,_16020,_16011,_16039),
    redundant0(_16054,_16039,_16069),
    negation0(_15929,_16078,_16069,_16095),
    w(verb(_15933,_15934,_15935),_16107,_16095,_16124),
    reflexiv0(_15933,_16136,_16124,_16153),
    prepnom(_15939,_16165,_16153,_16182),
    {user:testmember(_15939,[regarding,with])},
    !,
    pushstack(first,(xnp(_15926,_15927),w(verb(_15933,_15934,_15935)),w(prep(_15939)),npgap(_15879:thing)),nil,_16182,_16283),
    statreal(_15875,_16209,_16283,_15984).

whatq(_15874:::_15875,[whatq,_15965,{},_15999,_16033,lit(om),!,_16078],_15951,_15953) --> 
    whatcan(_15965,_15951,_15980),
    {user:which_thing(_15911,_15874)},
    specific_phrase(_15914,_15915,_15999,_15980,_16018),
    negation0(_15917,_16033,_16018,_16050),
    cc(om,_16050,_16072),
    !,
    pushstack(first,(noun_phrase1(_15914,_15915),w(verb(know1,pres,fin)),npgap(_15911),[om]),nil,_16072,_16149),
    statreal(_15875,_16078,_16149,_15953).

whatq(_15874:::_15875,[whatq,_16006,{},_16040,_16074,_16103,_16132,lit(_15938),{},_16182,!,_16216],_15992,_15994) --> 
    whatcan(_16006,_15992,_16021),
    {user:which_thing(_15916,_15874)},
    specific_phrase(_15923,_15926::_15927,_16040,_16021,_16059),
    negation0(_15929,_16074,_16059,_16091),
    w(verb(_15933,_15934,_15935),_16103,_16091,_16120),
    reflexiv0(_15933,_16132,_16120,_16149),
    cc(_15938,_16149,_16171),
    {user:testmember(_15938,[på,om,til])},
    not_look_ahead(w(noun(_15956,_15957,_15958,_15959)),_16182,_16171,_16199),
    !,
    pushstack(first,(noun_phrase1(_15923,_15926::_15927),w(verb(_15933,_15934,_15935)),npgap(_15916)),nil,_16199,_16290),
    statreal(_15875,_16216,_16290,_15994).

whatq(_15874:::_15875,[whatq,_15999,{},_16033,_16067,_16096,_16125,lit(om),_16165,!,_16204],_15985,_15987) --> 
    whatcan(_15999,_15985,_16014),
    {user:which_thing(_15924,_15874)},
    specific_phrase(_15927,_15930::_15931,_16033,_16014,_16052),
    negation0(_15933,_16067,_16052,_16084),
    w(verb(_15937,_15938,_15939),_16096,_16084,_16113),
    reflexiv0(_15937,_16125,_16113,_16142),
    cc(om,_16142,_16164),
    noun_phrase1(_15919,_15920,_16165,_16164,_16184),
    !,
    pushstack(first,(noun_phrase1(_15927,_15930::_15931),w(verb(_15937,_15938,_15939)),npgap(_15924),w(prep(regarding)),np(_15919,_15920)),nil,_16184,_16309),
    statreal(_15875,_16204,_16309,_15987).

whatq(_15874:::_15875,[whatq,_15999,{},_16033,_16067,_16096,_16140,_16174,!,_16208],_15985,_15987) --> 
    whatcan(_15999,_15985,_16014),
    {user:which_thing(_15916,_15874)},
    specific_phrase(_15923,_15926::_15927,_16033,_16014,_16052),
    negation0(_15929,_16067,_16052,_16084),
    lexv(tv,_15932,_15933,_15934,_16096,_16084,_16119),
    np1(_15936,_15939::_15940,_16140,_16119,_16159),
    prepnom(_15942,_16174,_16159,_16191),
    !,
    pushstack(first,(noun_phrase1(_15923,_15926::_15927),w(verb(_15932,_15933,_15934)),np1(_15936,_15939::_15940),w(prep(_15942)),npgap(_15916)),nil,_16191,_16313),
    statreal(_15875,_16208,_16313,_15987).

whatq(_15874:::_15875,[whatq,_16000,_16024,_16058,_16087,_16116,_16150,!,{},_16194],_15986,_15988) --> 
    whatcan(_16000,_15986,_16015),
    specific_phrase(_15922,_15925::_15926,_16024,_16015,_16043),
    negation0(_15928,_16058,_16043,_16075),
    w(verb(_15932,_15933,_15934),_16087,_16075,_16104),
    noun_phrase1(_15916,_15919::_15920,_16116,_16104,_16135),
    prepnom(_15942,_16150,_16135,_16167),
    !,
    {user:which_thing(_15946,_15874)},
    pushstack(first,(noun_phrase1(_15922,_15925::_15926),w(verb(_15932,_15933,_15934)),npgap(_15946),w(prep(_15942)),np(_15916,_15919::_15920)),nil,_16167,_16302),
    statreal(_15875,_16194,_16302,_15988).

whatq(_15874:::_15875,[whatq,_15972,{},_16006,_16040,_16069,!,_16103],_15958,_15960) --> 
    whatcan(_15972,_15958,_15987),
    {user:which_thing(_15904,_15874)},
    specific_phrase(_15911,_15914::_15915,_16006,_15987,_16025),
    negation0(_15917,_16040,_16025,_16057),
    not_look_ahead(w(verb(_15923,_15924,_15925)),_16069,_16057,_16086),
    !,
    pushstack(first,(noun_phrase1(_15911,_15914::_15915),w(verb(do1,pres,fin)),npgap(_15904)),nil,_16086,_16177),
    statreal(_15875,_16103,_16177,_15960).

whatq(_15874:::_15875,[whatq,_15975,{},_16009,_16043,_16072,_16101,!,_16135],_15961,_15963) --> 
    whatcan(_15975,_15961,_15990),
    {user:which_thing(_15907,_15874)},
    specific_phrase(_15914,_15917::_15918,_16009,_15990,_16028),
    negation0(_15920,_16043,_16028,_16060),
    w(verb(_15924,_15925,_15926),_16072,_16060,_16089),
    reflexiv0(_15924,_16101,_16089,_16118),
    !,
    pushstack(first,(noun_phrase1(_15914,_15917::_15918),w(verb(_15924,_15925,_15926)),npgap(_15907)),nil,_16118,_16209),
    statreal(_15875,_16135,_16209,_15963).

whatq(_15874:::_15875,[whatq,lit(hva),{},_15987,_16016,!,_16055],_15952,_15954) --> 
    cc(hva,_15952,_15976),
    {user:which_thing(_15901,_15874)},
    w(verb(know,_15913,fin),_15987,_15976,_16004),
    specific_phrase(_15916,_15919::_15920,_16016,_16004,_16035),
    !,
    pushstack(first,(noun_phrase1(_15916,_15919::_15920),lexv(tv,know1,_15913,fin),npgap(_15901)),nil,_16035,_16160),
    statreal(_15875,_16055,_16160,_15954).

whatq(_15872,[whatq,lit(hva),_15942,_15966],_15917,_15919) --> 
    cc(hva,_15917,_15941),
    do(_15942,_15941,_15957),
    pushstack(first,(which,w(noun(thing,sin,u,n)),do),nil,_15957,_16035),
    whichq(_15872,_15966,_16035,_15919).

whatq(_15872,[whatq,lit(hva),_15964,!,_16013,_16037,_16066],_15939,_15941) --> 
    cc(hva,_15939,_15963),
    lexv(iv,_15900,_15908,fin,_15964,_15963,_15987),
    !,
    accept(_16013,_15987,_16028),
    negation0(_15911,_16037,_16028,_16054),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(_15900,pres,fin))),nil,_16054,_16104),
    whichq(_15872,_16066,_16104,_15941).

whenq(which(_15877):::_15875,[whenq,_15946,_15985,lit(det),_16020,!,_16049],_15932,_15934) --> 
    when_adverbialq(_15897,_15877,_15901::_15902,_15946,_15932,_15967),
    be(_15985,_15967,_16000),
    cc(det,_16000,_16019),
    that0(_16020,_16019,_16035),
    !,
    pushstack(free,xadverbial1(_15897,_15877,_15901::_15902),nil,_16035,_16090),
    statreal(_15875,_16049,_16090,_15934).

whenq(which(_15877):::_15875,[whenq,_15950,_15989,!,_16023,_16047],_15936,_15938) --> 
    when_adverbialq(_15894,_15877,_15898::_15899,_15950,_15936,_15971),
    look_ahead(w(noun(bus,_15913,_15914,n)),_15989,_15971,_16006),
    !,
    accept(_16023,_16006,_16038),
    pushstack(free,xadverbial1(_15894,_15877,_15898::_15899),nil,_16038,_16092),
    statreal(_15875,_16047,_16092,_15938).

whenq(which(_15877):::_15875,[whenq,_15984,_16023,_16052,{},!,_16096],_15970,_15972) --> 
    when_adverbialq(_15903,_15877,_15907::_15908,_15984,_15970,_16005),
    w(verb(go,_15920,fin),_16023,_16005,_16040),
    look_ahead(w(prep(_15927)),_16052,_16040,_16069),
    {user:testmember(_15927,[from,to])},
    !,
    pushstack(free,(w(noun(bus,sin,u,n)),w(verb(go,_15920,fin)),xadverbial1(_15903,_15877,_15907::_15908)),nil,_16069,_16141),
    statreal(_15875,_16096,_16141,_15972).

whenq(which(_15877):::_15875,[whenq,_15959,_15998,_16022,_16046,!,_16085,_16109,_16138],_15945,_15947) --> 
    when_adverbialq(_15902,_15877,_15911::_15912,_15959,_15945,_15980),
    be(_15998,_15980,_16013),
    detnexttime(_16022,_16013,_16037),
    np1(_15900,_15917::_15918,_16046,_16037,_16065),
    !,
    accept(_16085,_16065,_16100),
    negation0(_15920,_16109,_16100,_16126),
    whencomplex(_15900,_15917::_15918,_15902,_15877,_15911::_15912,_15875,_16138,_16126,_15947).

whenq(which(_15877):::_15875,[whenq,_15937,_15961,{},!,_16005],_15923,_15925) --> 
    when(_15937,_15923,_15952),
    look_ahead(w(prep(_15895)),_15961,_15952,_15978),
    {user:testmember(_15895,[from,to])},
    !,
    reject(_16005,_15978,_15925).

whenq(which(_15877):::_15875,[whenq,_16002,_16026,_16065,!,_16109,_16133,!,_16217,_16241],_15988,_15990) --> 
    when(_16002,_15988,_16017),
    preadverbial1(_15919,_15920,_15923::_15924,_16026,_16017,_16047),
    preadverbial1(_15912,_15913,_15916::_15917,_16065,_16047,_16086),
    !,
    accept(_16109,_16086,_16124),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_16124,_16177),adverbial1(_15946,_15877,_15950::_15951,_16133,_16177,_16194),
    !,
    accept(_16217,_16194,_16232),
    lock(last,_16232,_16359),
    pushstack(last,(adverbial1(in,_15877,_15950::_15951),adverbial1(_15919,_15920,_15923::_15924),adverbial1(_15912,_15913,_15916::_15917)),nil,_16359,_16365),
    question0(_15875,_16241,_16365,_16354),
    unlock(_16354,_15990).

whenq(which(_15877):::_15875,[whenq,_15989,_16013,_16042,!,_16086,_16110,!,_16193,_16217],_15975,_15977) --> 
    when(_15989,_15975,_16004),
    not_look_ahead([e],_16013,_16004,_16030),
    adverbial1(_15909,_15910,_15913::_15914,_16042,_16030,_16063),
    !,
    accept(_16086,_16063,_16101),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_16101,_16153),adverbial1(_15940,_15877,_15944::_15945,_16110,_16153,_16170),
    !,
    accept(_16193,_16170,_16208),
    lock(last,_16208,_16300),
    pushstack(last,(xadverbial1(in,_15877,_15944::_15945),xadverbial1(_15909,_15910,_15913::_15914)),nil,_16300,_16306),
    question0(_15875,_16217,_16306,_16295),
    unlock(_16295,_15977).

whenq(which(_15877):::_15875,[whenq,_15969,_15993,!,_16037,!,_16133],_15955,_15957) --> 
    when(_15969,_15955,_15984),
    adverb(_15900,_15901,pre,_15993,_15984,_16014),
    !,
    lock(exact,_16014,_16087),pushstack(exact,(prep(in),w(noun(time,sin,u,n))),nil,_16087,_16093),adverbial1(_15920,_15877,_15924::_15925,_16037,_16093,_16082),unlock(_16082,_16083),
    !,
    pushstack(free,(xadverbial1(in,_15877,_15924::_15925),xadverb(_15900,_15901)),nil,_16083,_16209),
    question0(_15875,_16133,_16209,_15957).

whenq(which(_15877):::_15875,[whenq,_15981,_16020,{},_16059,_16083,!,_16117],_15967,_15969) --> 
    howlongto(_15906,_15877,_15910::_15911,_15981,_15967,_16002),
    w(adj2(_15922,nil),_16020,_16002,_16037),
    {user:testmember(_15922,[easy,possible,good])},
    infinitive(_16059,_16037,_16074),
    w(verb(_15938,inf,fin),_16083,_16074,_16100),
    !,
    lock(last,_16100,_16197),
    pushstack(last,(someone,w(verb(_15938,pres,fin)),adverbial1(_15906,_15877,_15910::_15911)),nil,_16197,_16203),
    statement(_15875,_16117,_16203,_16192),
    unlock(_16192,_15969).

whenq(which(_15877):::_15875,[whenq,_15953,_15992,!,_16026],_15939,_15941) --> 
    howlongto(_15894,_15877,_15898::_15899,_15953,_15939,_15974),
    w(verb(_15910,_15911,fin),_15992,_15974,_16009),
    !,
    lock(last,_16009,_16078),
    pushstack(last,(w(verb(_15910,pres,fin)),adverbial1(_15894,_15877,_15898::_15899)),nil,_16078,_16084),
    statement(_15875,_16026,_16084,_16073),
    unlock(_16073,_15941).

whenq(which(_15877):::_15875,[whenq,_15947,!,_15991,_16064,_16093],_15933,_15935) --> 
    when_adverbialq(_15893,_15877,_15897::_15898,_15947,_15933,_15968),
    !,
    pushstack(free,xadverbial1(_15893,_15877,_15897::_15898),nil,_15968,_16039),question0(_15875,_15991,_16039,_16052),
    not_look_ahead([a],_16064,_16052,_16081),
    prep0(_15891,_16093,_16081,_15935).

detnexttime([detnexttime,lit(det),_15920,_15944,!],_15898,_15900) --> 
    cc(det,_15898,_15919),
    nexttime0(_15920,_15919,_15935),
    that0(_15944,_15935,_15900),
    !.

detnexttime([detnexttime,_15904,_15928,!],_15893,_15895) --> 
    nexttime(_15904,_15893,_15919),
    that0(_15928,_15919,_15895),
    !.

detnexttime([detnexttime,lit(at),!],_15892,_15894) --> 
    cc(at,_15892,_15894),
    !.

nexttime0([nexttime0,_15898],_15887,_15889) --> 
    nexttime(_15898,_15887,_15889).

nexttime0([nexttime0,[]],_15887,_15887) --> 
    [].

nexttime([nexttime,_15910,_15939],_15899,_15901) --> 
    w(adj2(next,nil),_15910,_15899,_15927),
    optional([gang],_15939,_15927,_15901).

whencomplex(_15872,_15879::_15880,_15874,_15875,_15882::_15883,_15877,[whencomplex,_15989,_16013,!,_16047,_16071],_15960,_15962) --> 
    do0(_15989,_15960,_16004),
    w(verb(_15915,_15916,finy),_16013,_16004,_16030),
    !,
    accept(_16047,_16030,_16062),
    pushstack(free,(np(_15872,_15879::_15880),w(verb(_15915,pres,fin)),adverbial1(_15874,_15875,_15882::_15883)),nil,_16062,_16150),
    statreal(_15877,_16071,_16150,_15962).

whencomplex(_15872,_15879::_15880,_15874,_15875,_15882::_15883,_15877,[whencomplex,_15971],_15942,_15944) --> 
    pushstack(free,(np(_15872,_15879::_15880),w(verb(be,pres,fin)),adverbial1(_15874,_15875,_15882::_15883)),nil,_15942,_16050),
    statreal(_15877,_15971,_16050,_15944).

verb0(_15872,[verb0,_15917,!,_15951],_15903,_15905) --> 
    w(verb(_15872,_15883,_15884),_15917,_15903,_15934),
    !,
    accept(_15951,_15934,_15905).

verb0(be1,[verb0,[]],_15891,_15891) --> 
    [].

subjectverb(_15872,_15873,_15874,[subjectverb,_15932,_15961,!],_15912,_15914) --> 
    w(verb(_15874,_15885,fin),_15932,_15912,_15949),
    subject(_15872,_15873,_15961,_15949,_15914),
    !.

subjectverb(_15872,_15873,_15874,[subjectverb,_15932,_15956,_15990],_15912,_15914) --> 
    aux1(_15932,_15912,_15947),
    subject(_15872,_15873,_15956,_15947,_15975),
    w(verb(_15874,inf,fin),_15990,_15975,_15914).

whereq(which(_15877):::_15875,[whereq,_15996,_16020,_16059,_16088,_16112,_16141,!,_16180,_16204,!,_16233,[],_16303,!,_16377],_15982,_15984) --> 
    dummyprep0(_15996,_15982,_16011),
    where_adverbial(_15921,_15877,_15923,_16020,_16011,_16041),
    w(verb(_15927,_15928,fin),_16059,_16041,_16076),
    thereit0(_16088,_16076,_16103),
    not_look_ahead(w(nb(_15935,_15936)),_16112,_16103,_16129),
    subject(_15938,_15939,_16141,_16129,_16160),
    !,
    accept(_16180,_16160,_16195),
    dummyprep0(_16204,_16195,_16219),
    !,
    accept(_16233,_16219,_16248),
    pushstack(free,adverbial1(_15921,_15877,_15923),nil,_16248,_16302),[],
    pushstack(first,(xnp(_15938,_15939),w(verb(_15927,_15928,fin))),nil,_16302,_16347),substatement1(_15875,_16303,_16347,_16360),
    !,
    accept(_16377,_16360,_15984).

whereq(which(_15877):::_15875,[whereq,{},_15992,_16016,!,_16050,!,_16116,_16185],_15968,_15970) --> 
    {user:(\+value(dialog,1))},
    where(_15992,_15968,_16007),
    w(verb(go,_15910,fin),_16016,_16007,_16033),
    !,
    lock(exact,_16033,_16070),pushstack(exact,w(noun(place,sin,u,n)),nil,_16070,_16076),adverbial1(nil,_15877,_15927::_15928,_16050,_16076,_16065),unlock(_16065,_16066),
    !,
    pushstack(free,(w(verb(go,pres,fin)),adverbial1(nil,_15877,_15927::_15928)),nil,_16066,_16160),ynq(_15875,_16116,_16160,_16173),
    dummyprep0(_16185,_16173,_15970).

whereq(which(_15877):::_15875,[whereq,_15985,_16009,_16038,!,_16082,!,_16178],_15971,_15973) --> 
    where(_15985,_15971,_16000),
    not_look_ahead(w(prep(after)),_16009,_16000,_16026),
    adverbial1(_15903,_15904,_15907::_15908,_16038,_16026,_16059),
    !,
    lock(exact,_16059,_16132),pushstack(exact,(prep(in),w(noun(place,sin,u,n))),nil,_16132,_16138),adverbial1(_15936,_15877,_15940::_15941,_16082,_16138,_16127),unlock(_16127,_16128),
    !,
    pushstack(free,(adverbial1(in,_15877,_15940::_15941),adverbial1(_15903,_15904,_15907::_15908)),nil,_16128,_16258),
    question0(_15875,_16178,_16258,_15973).

whereq(which(_15877):::_15875,[whereq,_15970,_16009,lit(det),_16044,!,[],_16127],_15956,_15958) --> 
    where_adverbial(_15911,_15877,_15915::_15916,_15970,_15956,_15991),
    be(_16009,_15991,_16024),
    cc(det,_16024,_16043),
    w(adj2(_15908,_15909),_16044,_16043,_16061),
    !,
    pushstack(free,adverbial1(_15911,_15877,_15915::_15916),nil,_16061,_16126),[],
    pushstack(first,([det],be,w(adj2(_15908,_15909))),nil,_16126,_16165),
    substatement1(_15875,_16127,_16165,_15958).

whereq(which(_15877):::_15875,[whereq,_15946,_15985,lit(det),_16020,!,_16049],_15932,_15934) --> 
    where_adverbial(_15897,_15877,_15901::_15902,_15946,_15932,_15967),
    be(_15985,_15967,_16000),
    cc(det,_16000,_16019),
    that0(_16020,_16019,_16035),
    !,
    pushstack(free,adverbial1(_15897,_15877,_15901::_15902),nil,_16035,_16094),
    statreal(_15875,_16049,_16094,_15934).

whereq(_15872,[whereq,_15940,_15964,_15988],_15926,_15928) --> 
    where(_15940,_15926,_15955),
    be(_15964,_15955,_15979),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),w(verb(be1,pres,fin))),nil,_15979,_16056),
    ppq(_15872,_15988,_16056,_15928).

whereq(which(_15877):::_15875,[whereq,_15919,_15943,!,_15972],_15905,_15907) --> 
    where(_15919,_15905,_15934),
    many1(_15943,_15934,_15958),
    !,
    reject(_15972,_15958,_15907).

whereq(_15872,[whereq,_15934,_15958,_15982],_15920,_15922) --> 
    where(_15934,_15920,_15949),
    aux1(_15958,_15949,_15973),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),do),nil,_15973,_16078),
    ppq(_15872,_15982,_16078,_15922).

whereq(_15872,[whereq,_15926,_15950,_15974],_15912,_15914) --> 
    where(_15926,_15912,_15941),
    look_ahead_vp(_15950,_15941,_15965),
    pushstack(first,(which,w(noun(place,sin,u,n))),nil,_15965,_16012),
    whichq(_15872,_15974,_16012,_15914).

when_adverbial(in,_15873,_15876::_15877,[when_adverbial,_15940,_15964,!,{}],_15920,_15922) --> 
    which(_15940,_15920,_15955),
    np1(_15873,_15876::_15877,_15964,_15955,_15922),
    !,
    {user:testconstraint(_15873,time)}.

when_adverbialq(in,_15882:time,_15876::_15882 isa time and _15876,[when_adverbialq,_15929],_15909,_15911) --> 
    when(_15929,_15909,_15911).

when_adverbial(in,_15882:time,_15876::_15882 isa time and _15876,[when_adverbial,_15929],_15909,_15911) --> 
    whenx(_15929,_15909,_15911).

where_adverbial(nil,_15873,_15874,[where_adverbial,_15934,_15958,!,{}],_15914,_15916) --> 
    which(_15934,_15914,_15949),
    np1(_15873,_15874,_15958,_15949,_15916),
    !,
    {user:testconstraint(_15873,place)}.

where_adverbial(nil,_15873,_15874,[where_adverbial,lit(hvor),_15940,!],_15909,_15911) --> 
    cc(hvor,_15909,_15939),
    np00(place,_15873,_15874,_15940,_15939,_15911),
    !.

dummyprep0([dummyprep0,_15901,!],_15890,_15892) --> 
    dummyprep(_15901,_15890,_15892),
    !.

dummyprep0([dummyprep0,[]],_15887,_15887) --> 
    [].

dummyprep([dummyprep,_15906,!,_15940],_15895,_15897) --> 
    prep1(from,_15906,_15895,_15923),
    !,
    accept(_15940,_15923,_15897).

dummyprep([dummyprep,_15906,!,_15940],_15895,_15897) --> 
    prep1(to,_15906,_15895,_15923),
    !,
    accept(_15940,_15923,_15897).

wherefromq(_15872,[wherefromq,_15931,!,_15960],_15917,_15919) --> 
    wherefrom(_15931,_15917,_15946),
    !,
    pushstack(first,(prep(from),which,w(noun(place,sin,u,n))),nil,_15946,_16029),
    ppq(_15872,_15960,_16029,_15919).

whoq(_15872,[whoq,_15956,_15980,_16009,!,_16043],_15942,_15944) --> 
    who(_15956,_15942,_15971),
    look_ahead(w(noun(_15905,sin,def,n)),_15980,_15971,_15997),
    w(verb(_15897,_15898,fin),_16009,_15997,_16026),
    !,
    pushstack(first,(which,w(noun(agent,sin,u,n)),w(verb(_15897,_15898,fin))),nil,_16026,_16081),
    whichq(_15872,_16043,_16081,_15944).

whoq(_15872,[whoq,_15923,_15947],_15909,_15911) --> 
    who(_15923,_15909,_15938),
    pushstack(first,(which,w(noun(agent,sin,u,n))),nil,_15938,_15985),
    whichq(_15872,_15947,_15985,_15911).

whoseq(_15872,[whoseq,_15948,_15972,_16026],_15934,_15936) --> 
    whose(_15948,_15934,_15963),
    noun(_15895,_15896,u,n,_15899,_15900,_15972,_15963,_15999),
    pushstack(first,(who,w(verb(have,pres,fin)),a,noun(_15895,_15896,u,n,_15899,_15900),that),nil,_15999,_16160),
    whoq(_15872,_16026,_16160,_15936).

whyq(explain:::_15875,[whyq,_15913,_15937],_15899,_15901) --> 
    hvorfor(_15913,_15899,_15928),
    isq(_15875,_15937,_15928,_15901).

whyq(explain:::_15875,[whyq,_15913,_15937],_15899,_15901) --> 
    hvorfor(_15913,_15899,_15928),
    ynq(_15875,_15937,_15928,_15901).

whyq(explain:::_15875,[whyq,_15913,_15937],_15899,_15901) --> 
    hvorfor(_15913,_15899,_15928),
    hasq(_15875,_15937,_15928,_15901).

howq(doit:::reply('OK'),[howq,lit(hvordan),_15943,lit(det),!,_15988],_15918,_15920) --> 
    cc(hvordan,_15918,_15942),
    w(verb(go,_15896,fin),_15943,_15942,_15960),
    cc(det,_15960,_15982),
    !,
    skip_rest(_15988,_15982,_15920).

howq(explain:::_15875,[howq,lit(hvordan),_15958,_15982,_16011,!,_16040],_15933,_15935) --> 
    cc(hvordan,_15933,_15957),
    erdetaa0(_15958,_15957,_15973),
    w(verb(_15900,inf,fin),_15982,_15973,_15999),
    mex0(_16011,_15999,_16026),
    !,
    pushstack(first,([jeg],w(verb(_15900,pres,fin))),nil,_16026,_16050),
    statreal1(_15875,_16040,_16050,_15935).

howq(explain:::_15875,[howq,lit(hvorfor),_15952,!,_15986],_15927,_15929) --> 
    cc(hvorfor,_15927,_15951),
    w(verb(_15894,inf,fin),_15952,_15951,_15969),
    !,
    pushstack(first,([jeg],w(verb(_15894,pres,fin))),nil,_15969,_15996),
    statreal1(_15875,_15986,_15996,_15929).

howq(explain:::_15875,[howq,lit(hvordan),_15950,[],_16024],_15925,_15927) --> 
    cc(hvordan,_15925,_15949),
    look_ahead(w(verb(be,_15895,fin)),_15950,_15949,_15967),
    pushstack(free,xadverbial1(how,nil,_15905::_15905),nil,_15967,_16023),[],
    isq(_15875,_16024,_16023,_15927).

howq(explain:::_15875,[howq,_15937,_15961,_15985,_16019],_15923,_15925) --> 
    how(_15937,_15923,_15952),
    be(_15961,_15952,_15976),
    np1_accept(_15898,_15899,_15985,_15976,_16004),
    pushstack(first,(xnp(_15898,_15899),w(verb(be,pres,fin))),nil,_16004,_16060),
    substatement1(_15875,_16019,_16060,_15925).

howq(explain:::_15875,[howq,_15943,_15967,lit(det),_16002,!,_16036],_15929,_15931) --> 
    how(_15943,_15929,_15958),
    be(_15967,_15958,_15982),
    cc(det,_15982,_16001),
    negation0(_15906,_16002,_16001,_16019),
    !,
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_16019,_16046),
    substatement1(_15875,_16036,_16046,_15931).

howq(explain:::_15875,[howq,_15927,_15971,_15995,!,_16024],_15913,_15915) --> 
    lexv(iv,tell,imp,fin,_15927,_15913,_15950),
    me0(_15971,_15950,_15986),
    how(_15995,_15986,_16010),
    !,
    statreal1(_15875,_16024,_16010,_15915).

howq(_15872,[howq,_15922,_15946,_15970,!,_15999],_15908,_15910) --> 
    how(_15922,_15908,_15937),
    be(_15946,_15937,_15961),
    thereit(_15970,_15961,_15985),
    !,
    pushstack(first,whatbe,nil,_15985,_16037),
    whatq(_15872,_15999,_16037,_15910).

howq(_15872,[howq,_15929,_15953,lit(det),_15988,!,_16022],_15915,_15917) --> 
    how(_15929,_15915,_15944),
    be(_15953,_15944,_15968),
    cc(det,_15968,_15987),
    prep1(with,_15988,_15987,_16005),
    !,
    pushstack(first,whatbe,nil,_16005,_16060),
    whatq(_15872,_16022,_16060,_15917).

howq(explain:::_15875,[howq,_15913,_15937],_15899,_15901) --> 
    how(_15913,_15899,_15928),
    ynq(_15875,_15937,_15928,_15901).

howq(explain:::_15875,[howq,_15913,_15937],_15899,_15901) --> 
    how(_15913,_15899,_15928),
    hasq(_15875,_15937,_15928,_15901).

erdetaa0([erdetaa0,_15914,lit(det),lit(å),!,_15965],_15903,_15905) --> 
    be(_15914,_15903,_15929),
    cc(det,_15929,_15948),
    cc(å,_15948,_15959),
    !,
    accept(_15965,_15959,_15905).

erdetaa0([erdetaa0,[]],_15887,_15887) --> 
    [].

howlongto(_15872,_15873,_15876::_15877,[howlongto,_15950,lit(det),lit(lenge),_15996,_16025],_15930,_15932) --> 
    be(_15950,_15930,_15965),
    cc(det,_15965,_15984),
    cc(lenge,_15984,_15995),
    prep1(to,_15996,_15995,_16013),
    lock(exact,_16013,_16042),
    pushstack(exact,[når],nil,_16042,_16048),
    when_adverbial(_15872,_15873,_15876::_15877,_16025,_16048,_16037),
    unlock(_16037,_15932).

howlongto(_15872,_15873,_15876::_15877,[howlongto,lit(hvor),lit(lenge),_15977,lit(det),_16012,_16041],_15935,_15937) --> 
    cc(hvor,_15935,_15965),
    cc(lenge,_15965,_15976),
    be(_15977,_15976,_15992),
    cc(det,_15992,_16011),
    prep1(to,_16012,_16011,_16029),
    lock(exact,_16029,_16058),
    pushstack(exact,[når],nil,_16058,_16064),
    when_adverbial(_15872,_15873,_15876::_15877,_16041,_16064,_16053),
    unlock(_16053,_15937).

howlongto(_15872,_15873,_15876::_15877,[howlongto,_15936,_15975,_15999,_16023],_15916,_15918) --> 
    when_adverbial(_15872,_15873,_15876::_15877,_15936,_15916,_15957),
    be(_15975,_15957,_15990),
    thereit(_15999,_15990,_16014),
    that0(_16023,_16014,_15918).

howadjq(_15872,[howadjq,_15998,_16022,{},_16061,{},lit(det),_16111,_16140,_16164,_16193,!,_16264],_15984,_15986) --> 
    hvor(_15998,_15984,_16013),
    howadj1(_15907,_16022,_16013,_16039),
    {user:testmember(_15907,[duration])},
    w(verb(_15918,_15919,fin),_16061,_16039,_16078),
    {user:testmember(_15918,[take,be])},
    cc(det,_16078,_16110),
    not_look_ahead([å],_16111,_16110,_16128),
    redundant0(_16140,_16128,_16155),
    not_look_ahead(w(prep(with)),_16164,_16155,_16181),
    pushstack(first,(which,w(noun(_15907,sin,u,n)),w(verb(_15918,_15919,fin))),nil,_16181,_16234),whichq(_15872,_16193,_16234,_16247),
    !,
    accept(_16264,_16247,_15986).

howadjq(_15872,[howadjq,_15962,_15986,_16015,{},!,_16054],_15948,_15950) --> 
    hvor(_15962,_15948,_15977),
    howadj1(_15901,_15986,_15977,_16003),
    docan(_16015,_16003,_16030),
    {user:testmember(_15901,[frequency,speed,lateness,earliness,duration,distance])},
    !,
    pushstack(first,(prep(with),which,w(noun(_15901,sin,u,n)),do),nil,_16030,_16151),
    ppq(_15872,_16054,_16151,_15950).

howadjq(_15872,[howadjq,_15978,_16002,{},_16041,{},!,_16085],_15964,_15966) --> 
    hvor(_15978,_15964,_15993),
    howadj1(_15910,_16002,_15993,_16019),
    {user:testmember(_15910,[frequency,earliness,lateness])},
    w(verb(_15906,_15926,_15908),_16041,_16019,_16058),
    {user:(\+_15906=be)},
    !,
    pushstack(first,(prep(with),which,w(noun(_15910,sin,u,n)),w(verb(_15906,pres,_15908))),nil,_16058,_16153),
    ppq(_15872,_16085,_16153,_15966).

howadjq(_15872,[howadjq,_15948,_15972,_16001,_16035,_16059],_15934,_15936) --> 
    hvor(_15948,_15934,_15963),
    howadj1(_15901,_15972,_15963,_15989),
    gmem(_15901,[distance],_16001,_15989,_16020),
    be(_16035,_16020,_16050),
    pushstack(first,(which,w(noun(_15901,sin,u,n)),w(verb(have,pres,fin))),nil,_16050,_16097),
    whichq(_15872,_16059,_16097,_15936).

howadjq(which(_15882:time):::_15882 isa time and _15878,[howadjq,_15989,_16013,_16042,lit(det),lit(til),_16093,!,_16132,_16171],_15975,_15977) --> 
    hvor(_15989,_15975,_16004),
    howadj1(duration,_16013,_16004,_16030),
    w(verb(be,_15930,fin),_16042,_16030,_16059),
    cc(det,_16059,_16081),
    cc(til,_16081,_16092),
    clausal_object0(_15937,_15938,_16093,_16092,_16112),
    !,
    np00(time,_15882:time,_15923,_16132,_16112,_16153),
    pushstack(first,(xnp(_15937,_15938),w(verb(exist,_15930,fin)),xadverbial1(nil,_15882,_15923)),nil,_16153,_16243),
    statreal(_15878,_16171,_16243,_15977).

howadjq(_15872,[howadjq,_15986,_16030,_16054,_16083,_16112,_16146,!,_16180,_16219],_15972,_15974) --> 
    whichg00(duration,_15915,_15911,_15872,_15986,_15972,_16009),
    hvor(_16030,_16009,_16045),
    howadj1(duration,_16054,_16045,_16071),
    w(verb(be,_15924,fin),_16083,_16071,_16100),
    np1_accept(_15927,_15928,_16112,_16100,_16131),
    w(adj2(_15932,nil),_16146,_16131,_16163),
    !,
    np00(duration,_15911,_15912,_16180,_16163,_16201),
    pushstack(first,(xnp(_15927,_15928),w(verb(be,_15924,fin)),w(adj2(_15932,nil)),xadverbial1(nil,_15911,_15912)),nil,_16201,_16292),
    statreal(_15915,_16219,_16292,_15974).

howadjq(_15872,[howadjq,_15979,_16023,_16047,_16076,_16105,_16139,!,_16173,_16212],_15965,_15967) --> 
    whichg00(duration,_15912,_15908,_15872,_15979,_15965,_16002),
    hvor(_16023,_16002,_16038),
    howadj1(duration,_16047,_16038,_16064),
    w(verb(have,_15921,fin),_16076,_16064,_16093),
    subject(_15924,_15925,_16105,_16093,_16124),
    w(verb(_15929,past,part),_16139,_16124,_16156),
    !,
    np00(duration,_15908,_15909,_16173,_16156,_16194),
    pushstack(first,(xnp(_15924,_15925),w(verb(_15929,past,fin)),xadverbial1(nil,_15908,_15909)),nil,_16194,_16285),
    statreal(_15912,_16212,_16285,_15967).

howadjq(which(_15880):::_15880 isa _15883 and _15878,[howadjq,_15996,_16020,_16049,_16078,_16112,!,{},_16161,_16200],_15982,_15984) --> 
    hvor(_15996,_15982,_16011),
    howadj1(_15883,_16020,_16011,_16037),
    w(verb(have,_15930,fin),_16049,_16037,_16066),
    subject(_15933,_15934,_16078,_16066,_16097),
    object(_15936,_15937,_16112,_16097,_16131),
    !,
    {user:_15922=(_15880:_15883)},
    np00(_15883,_15922,_15923,_16161,_16131,_16182),
    pushstack(first,(xnp(_15933,_15934),w(verb(have,_15930,fin)),xnp(_15936,_15937),xadverbial1(nil,_15922,_15923)),nil,_16182,_16304),
    statreal(_15878,_16200,_16304,_15984).

howadjq(which(_15880):::_15880 isa _15883 and _15878,[howadjq,_16004,_16028,_16057,{},_16096,_16125,!,{},_16174,_16213],_15990,_15992) --> 
    hvor(_16004,_15990,_16019),
    howadj1(duration,_16028,_16019,_16045),
    w(verb(_15928,_15929,fin),_16057,_16045,_16074),
    {user:(\+testmember(_15928,[expect,be]))},
    not_look_ahead([det],_16096,_16074,_16113),
    np1(_15947,_15948,_16125,_16113,_16144),
    !,
    {user:_15921=(_15880:duration)},
    np00(_15883,_15921,_15922,_16174,_16144,_16195),
    pushstack(first,(xnp(_15947,_15948),w(verb(_15928,_15929,fin)),xnp(_15921,_15922)),nil,_16195,_16285),
    statreal(_15878,_16213,_16285,_15992).

howadjq(_15872,[howadjq,lit(hvor),lit(lenge),_15989,lit(det),_16029,!,_16063,_16097],_15953,_15955) --> 
    cc(hvor,_15953,_15977),
    cc(lenge,_15977,_15988),
    w(verb(be,pres,fin),_15989,_15988,_16006),
    cc(det,_16006,_16028),
    w(prep(to),_16029,_16028,_16046),
    !,
    clausal_object0(_15904,_15905,_16063,_16046,_16082),
    pushstack(first,([når],w(verb(be,pres,fin)),xnp(_15904,_15905)),nil,_16082,_16138),
    whenq(_15872,_16097,_16138,_15955).

howadjq(_15872,[howadjq,lit(hvor),lit(mange),_15997,_16026,lit(det),_16066,!,_16100],_15961,_15963) --> 
    cc(hvor,_15961,_15985),
    cc(mange,_15985,_15996),
    w(noun(minute,plu,u,n),_15997,_15996,_16014),
    w(verb(be,pres,fin),_16026,_16014,_16043),
    cc(det,_16043,_16065),
    w(prep(to),_16066,_16065,_16083),
    !,
    pushstack(free,([når],w(verb(be,pres,fin)),[det],[at]),nil,_16083,_16110),
    whenq(_15872,_16100,_16110,_15963).

howadjq(_15872,[howadjq,_15971,_15995,lit(blir),_16035,_16069,!,_16103],_15957,_15959) --> 
    hvor(_15971,_15957,_15986),
    howadj1(_15910,_15995,_15986,_16012),
    cc(blir,_16012,_16034),
    np1(_15907,_15908,_16035,_16034,_16054),
    w(verb(_15919,past,part),_16069,_16054,_16086),
    !,
    pushstack(first,(prep(with),which,w(noun(_15910,sin,u,n)),w(verb(_15919,pres,pass)),xnp(_15907,_15908)),nil,_16086,_16202),
    ppq(_15872,_16103,_16202,_15959).

howadjq(_15872,[howadjq,_15997,_16021,{},_16060,_16084,_16118,{},_16157,_16196],_15983,_15985) --> 
    hvor(_15997,_15983,_16012),
    howadj1(_15916,_16021,_16012,_16038),
    {user:testmember(_15916,[frequency])},
    be(_16060,_16038,_16075),
    subject(_15925,_15926,_16084,_16075,_16103),
    w(adj2(_15930,nil),_16118,_16103,_16135),
    {user:testmember(_15930,[delayed,tooearly])},
    np00(frequency,_15913,_15914,_16157,_16135,_16178),
    pushstack(first,(xnp(_15925,_15926),w(verb(be,pres,fin)),w(adj2(_15930,nil)),w(prep(with)),xnp(_15913,_15914)),nil,_16178,_16268),
    statreal1(_15872,_16196,_16268,_15985).

howadjq(_15872,[howadjq,_15956,_15980,{},_16019,_16043],_15942,_15944) --> 
    hvor(_15956,_15942,_15971),
    howadj1(_15901,_15980,_15971,_15997),
    {user:(\+testmember(_15901,[duration,distance,time]))},
    be(_16019,_15997,_16034),
    pushstack(first,(which,w(noun(_15901,sin,u,n)),w(verb(have,pres,fin))),nil,_16034,_16081),
    whichq(_15872,_16043,_16081,_15944).

howadjq(_15872,[howadjq,_15979,_16003,_16032,_16056,_16090,{},_16129,!,_16231],_15965,_15967) --> 
    hvor(_15979,_15965,_15994),
    howadj1(_15898,_16003,_15994,_16020),
    do(_16032,_16020,_16047),
    np(_15900,_15901,_16056,_16047,_16075),
    w(verb(_15905,_15906,_15907),_16090,_16075,_16107),
    {user:testmember(_15905,[use,take])},
    pushstack(first,(which,w(noun(_15898,sin,u,n)),w(verb(_15905,inf,fin)),xnp(_15900,_15901)),nil,_16107,_16201),whichq(_15872,_16129,_16201,_16214),
    !,
    accept(_16231,_16214,_15967).

howadjq(which(_15877):::_15875,[howadjq,_16007,_16031,{},_16070,{},_16109,!,_16148,!,_16253],_15993,_15995) --> 
    hvor(_16007,_15993,_16022),
    howadj1(_15906,_16031,_16022,_16048),
    {user:testmember(_15906,[speed,distance])},
    w(verb(_15919,pres,fin),_16070,_16048,_16087),
    {user:(\+testmember(_15919,[know,be]))},
    np1(_15934,_15935,_16109,_16087,_16128),
    !,
    pushstack(first,(xnp(_15934,_15935),w(verb(_15919,pres,fin)),w(prep(with)),the(_15877),w(noun(_15906,sin,u,n))),nil,_16128,_16223),statreal(_15875,_16148,_16223,_16236),
    !,
    accept(_16253,_16236,_15995).

howadjq(_15872,[howadjq,_15957,lit(lenge),_15992,_16016,!,_16050],_15943,_15945) --> 
    hvor(_15957,_15943,_15972),
    cc(lenge,_15972,_15991),
    be(_15992,_15991,_16007),
    not_look_ahead([det],_16016,_16007,_16033),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),w(verb(be,pres,fin))),nil,_16033,_16088),
    ppq(_15872,_16050,_16088,_15945).

howadjq(_15872,[howadjq,_15993,_16017,{},_16056,{},lit(det),_16106,_16130,!,_16164,_16188,!,_16259],_15979,_15981) --> 
    hvor(_15993,_15979,_16008),
    howadj1(_15910,_16017,_16008,_16034),
    {user:testmember(_15910,[duration])},
    w(verb(_15921,pres,fin),_16056,_16034,_16073),
    {user:testmember(_15921,[take,be])},
    cc(det,_16073,_16105),
    redundant0(_16106,_16105,_16121),
    prep(with,_16130,_16121,_16147),
    !,
    accept(_16164,_16147,_16179),
    pushstack(first,(which,w(noun(_15910,sin,u,n)),w(verb(_15921,pres,fin))),nil,_16179,_16229),whichq(_15872,_16188,_16229,_16242),
    !,
    accept(_16259,_16242,_15981).

howadjq(_15872,[howadjq,_16012,_16036,{},_16075,{},lit(det),_16125,_16154,_16178,!,_16212,_16236,!,_16307],_15998,_16000) --> 
    hvor(_16012,_15998,_16027),
    howadj1(_15913,_16036,_16027,_16053),
    {user:testmember(_15913,[duration])},
    w(verb(_15924,pres,fin),_16075,_16053,_16092),
    {user:testmember(_15924,[take])},
    cc(det,_16092,_16124),
    not_look_ahead([å],_16125,_16124,_16142),
    redundant0(_16154,_16142,_16169),
    look_ahead(w(prep(_15945)),_16178,_16169,_16195),
    !,
    accept(_16212,_16195,_16227),
    pushstack(first,(which,w(noun(_15913,sin,u,n)),w(verb(_15924,pres,fin)),w(noun(vehicle,sin,def,n))),nil,_16227,_16277),whichq(_15872,_16236,_16277,_16290),
    !,
    accept(_16307,_16290,_16000).

howadjq(_15872,[howadjq,_15989,_16013,{},_16052,lit(det),_16092,{},_16131,_16155,!,_16226],_15975,_15977) --> 
    hvor(_15989,_15975,_16004),
    howadj1(_15904,_16013,_16004,_16030),
    {user:testmember(_15904,[duration])},
    w(verb(_15915,pres,fin),_16052,_16030,_16069),
    cc(det,_16069,_16091),
    not_look_ahead([å],_16092,_16091,_16109),
    {user:testmember(_15915,[take,be])},
    redundant0(_16131,_16109,_16146),
    pushstack(first,(which,w(noun(_15904,sin,u,n)),w(verb(exist,pres,fin))),nil,_16146,_16196),whichq(_15872,_16155,_16196,_16209),
    !,
    accept(_16226,_16209,_15977).

howadjq(_15872,[howadjq,_15928,_15952,_15981],_15914,_15916) --> 
    ihvor(_15928,_15914,_15943),
    howadj1(_15888,_15952,_15943,_15969),
    pushstack(first,(which,w(noun(_15888,sin,u,n))),nil,_15969,_16019),
    whichq(_15872,_15981,_16019,_15916).

howadjq(_15872,[howadjq,_15944,lit(lenge),_15979,!,_16008],_15930,_15932) --> 
    hvor(_15944,_15930,_15959),
    cc(lenge,_15959,_15978),
    be(_15979,_15978,_15994),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),be),nil,_15994,_16074),
    ppq(_15872,_16008,_16074,_15932).

howadjq(_15872,[howadjq,_15947,_15971,_15995,_16019,_16048],_15933,_15935) --> 
    hvor(_15947,_15933,_15962),
    meny(_15971,_15962,_15986),
    be(_15995,_15986,_16010),
    w(noun(clock,_15908,_15909,_15910),_16019,_16010,_16036),
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_16036,_16114),
    whatq(_15872,_16048,_16114,_15935).

howadjq(_15872,[howadjq,_15962,lit(lenge),_15997,{},!,_16041],_15948,_15950) --> 
    hvor(_15962,_15948,_15977),
    cc(lenge,_15977,_15996),
    w(verb(_15903,pres,fin),_15997,_15996,_16014),
    {user:_15903\==take},
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(_15903,pres,fin))),nil,_16014,_16109),
    ppq(_15872,_16041,_16109,_15950).

howadjq(_15872,[howadjq,_15954,_15978,_16007,!,_16041],_15940,_15942) --> 
    hvor(_15954,_15940,_15969),
    howadj1(duration,_15978,_15969,_15995),
    w(verb(use,pres,fin),_16007,_15995,_16024),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_16024,_16109),
    ppq(_15872,_16041,_16109,_15942).

howadjq(_15872,[howadjq,_15945,_15969,_15998,_16022,!,_16151],_15931,_15933) --> 
    hvor(_15945,_15931,_15960),
    howadj1(_15889,_15969,_15960,_15986),
    do(_15998,_15986,_16013),
    pushstack(first,(prep(with),which,w(noun(_15889,sin,u,n)),do),nil,_16013,_16121),ppq(_15872,_16022,_16121,_16134),
    !,
    accept(_16151,_16134,_15933).

howadjq(_15872,[howadjq,_15945,_15969,_15998,_16022,_16046],_15931,_15933) --> 
    hvor(_15945,_15931,_15960),
    howadj1(duration,_15969,_15960,_15986),
    betake(_15998,_15986,_16013),
    thereit(_16022,_16013,_16037),
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(duration,sin,def,n))),nil,_16037,_16056),
    whatq(_15872,_16046,_16056,_15933).

howadjq(_15872,[howadjq,_15961,_15985,_16014,_16043,!,_16077],_15947,_15949) --> 
    hvor(_15961,_15947,_15976),
    howadj1(duration,_15985,_15976,_16002),
    w(verb(take,pres,fin),_16014,_16002,_16031),
    not_look_ahead([det],_16043,_16031,_16060),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_16060,_16145),
    ppq(_15872,_16077,_16145,_15949).

howmuchq(which(_15877):::_15875,[howmuchq,_15969,lit(lenge),_16004,lit(det),!,_16049],_15955,_15957) --> 
    hvor(_15969,_15955,_15984),
    cc(lenge,_15984,_16003),
    w(verb(be,_15913,fin),_16004,_16003,_16021),
    cc(det,_16021,_16043),
    !,
    pushstack(first,(which,w(noun(duration,plu,u,n)),w(verb(be,_15913,fin)),[det]),nil,_16043,_16087),
    whichq(which(_15877):::_15875,_16049,_16087,_15957).

howmuchq(which(_15877):::_15875,[howmuchq,_15986,_16010,_16034,{},lit(det),lit(å),_16095,!,_16143],_15972,_15974) --> 
    hvor(_15986,_15972,_16001),
    much(_16010,_16001,_16025),
    w(verb(_15916,_15917,fin),_16034,_16025,_16051),
    {user:testmember(_15916,[cost])},
    cc(det,_16051,_16083),
    cc(å,_16083,_16094),
    pushstack(first,([noen],[vil]),nil,_16094,_16108),clausal_object1(_15939,_15940,_16095,_16108,_16123),
    !,
    pushstack(first,(xnp(_15939,_15940),w(verb(_15916,pres,fin)),npgap(_15877)),nil,_16123,_16214),
    statreal1(_15875,_16143,_16214,_15974).

howmuchq(test:::_15875,[howmuchq,_15969,_15993,_16017,_16046,_16080,!,_16114,_16138],_15955,_15957) --> 
    hvor(_15969,_15955,_15984),
    much(_15993,_15984,_16008),
    w(verb(be,_15915,fin),_16017,_16008,_16034),
    np0_accept(_15918,_15919,_16046,_16034,_16065),
    w(adj2(_15909,nil),_16080,_16065,_16097),
    !,
    accept(_16114,_16097,_16129),
    pushstack(first,(xnp(_15918,_15919),w(verb(be,pres,fin)),w(adj2(_15909,nil))),nil,_16129,_16179),
    statemen1(real,_15875,_16138,_16179,_15957).

howmuchq(_15872,[howmuchq,_15932,_15956,_15980,!,_16014],_15918,_15920) --> 
    hvor(_15932,_15918,_15947),
    many1(_15956,_15947,_15971),
    look_ahead(w(verb(be,_15896,fin)),_15980,_15971,_15997),
    !,
    pushstack(first,[hva],nil,_15997,_16024),
    whatq(_15872,_16014,_16024,_15920).

howmuchq(howmany(_15877):::_15875,[howmuchq,_15926,_15950,_15974],_15912,_15914) --> 
    hvor(_15926,_15912,_15941),
    many1(_15950,_15941,_15965),
    pushstack(first,which,nil,_15965,_16012),
    whichq(which(_15877):::_15875,_15974,_16012,_15914).

howmuchq(howmany(_15877):::_15875,[howmuchq,_15936,_15960,_15984],_15922,_15924) --> 
    hvor(_15936,_15922,_15951),
    manypersons(_15960,_15951,_15975),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_15975,_16022),
    whichq(which(_15877):::_15875,_15984,_16022,_15924).

howmuchq(howmany(_15877):::_15875,[howmuchq,_15946,lit(det),_15981,lit(som),_16016],_15932,_15934) --> 
    be(_15946,_15932,_15961),
    cc(det,_15961,_15980),
    manypersons(_15981,_15980,_15996),
    cc(som,_15996,_16015),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_16015,_16054),
    whichq(which(_15877):::_15875,_16016,_16054,_15934).

howmuchq(which(_15877):::_15875,[howmuchq,_15941,_15965,_15989,{},_16028],_15927,_15929) --> 
    hvor(_15941,_15927,_15956),
    much(_15965,_15956,_15980),
    w(verb(_15891,_15898,fin),_15989,_15980,_16006),
    {user:testmember(_15891,[earn,cost])},
    whattrans(_15891,_15877,_15875,_16028,_16006,_15929).

howmuchq(_15872,[howmuchq,_15925,_15949,_15973,!,_16002],_15911,_15913) --> 
    hvor(_15925,_15911,_15940),
    much(_15949,_15940,_15964),
    of(_15973,_15964,_15988),
    !,
    pushstack(first,(which,of),nil,_15988,_16071),
    whichq(_15872,_16002,_16071,_15913).

howmuchq(_15872,[howmuchq,_15942,_15966,_15990,_16019,!,_16090],_15928,_15930) --> 
    hvor(_15942,_15928,_15957),
    much(_15966,_15957,_15981),
    w(noun(_15891,_15892,u,n),_15990,_15981,_16007),
    pushstack(first,(which,w(noun(_15891,sin,u,n))),nil,_16007,_16060),whichq(_15872,_16019,_16060,_16073),
    !,
    accept(_16090,_16073,_15930).

howmuchq(_15872,[howmuchq,_15918,_15942,_15966],_15904,_15906) --> 
    hvor(_15918,_15904,_15933),
    much(_15942,_15933,_15957),
    pushstack(first,[hva],nil,_15957,_15976),
    question(_15872,_15966,_15976,_15906).

whattrans(_15872,_15873,_15874,[whattrans,_15961,_15990,!,_16029],_15941,_15943) --> 
    not_look_ahead([det],_15961,_15941,_15978),
    noun_phrase1(_15900,_15903::_15904,_15990,_15978,_16009),
    !,
    pushstack(first,(noun_phrase1(_15900,_15903::_15904),w(verb(_15872,pres,fin)),npgap(_15873)),nil,_16009,_16103),
    statreal1(_15874,_16029,_16103,_15943).

howadj1(_15872,[howadj1,_15910,!],_15896,_15898) --> 
    howadj(_15872,_15910,_15896,_15898),
    !.

howadj(duration,[howadj,lit(langt)],_15893,_15895) --> 
    cc(langt,_15893,_15895).

howadj(age,[howadj,_15910],_15896,_15898) --> 
    w(adj2(old,nil),_15910,_15896,_15898).

howadj(age,[howadj,lit(mange),_15928],_15903,_15905) --> 
    cc(mange,_15903,_15927),
    w(noun(year,plu,u,n),_15928,_15927,_15905).

howadj(delay,[howadj,_15910],_15896,_15898) --> 
    w(adj2(slow,nil),_15910,_15896,_15898).

howadj(delay,[howadj,_15915,_15959],_15901,_15903) --> 
    optional(much,_15915,_15901,_15947),
    w(adj2(delayed,nil),_15959,_15947,_15903).

howadj(delay,[howadj,_15910],_15896,_15898) --> 
    w(adj2(punctual,nil),_15910,_15896,_15898).

howadj(earliness,[howadj,_15910],_15896,_15898) --> 
    w(adj2(early,nil),_15910,_15896,_15898).

howadj(lateness,[howadj,_15910],_15896,_15898) --> 
    w(adj2(late,nil),_15910,_15896,_15898).

howadj(lateness,[howadj,lit(sent)],_15893,_15895) --> 
    cc(sent,_15893,_15895).

howadj(distance,[howadj,lit(langt)],_15893,_15895) --> 
    cc(langt,_15893,_15895).

howadj(distance,[howadj,_15931,_15955,{}],_15917,_15919) --> 
    many(_15931,_15917,_15946),
    w(noun(_15882,_15896,u,n),_15955,_15946,_15919),
    {user:testmember(_15882,[mil,mile,kilometer,meter])}.

howadj(duration,[howadj,lit(mange),_15928],_15903,_15905) --> 
    cc(mange,_15903,_15927),
    w(noun(minute,_15880,_15881,n),_15928,_15927,_15905).

howadj(duration,[howadj,lit(lenge)],_15893,_15895) --> 
    cc(lenge,_15893,_15895).

howadj(duration,[howadj,_15918,_15942,!],_15904,_15906) --> 
    long(_15918,_15904,_15933),
    w(noun(time,_15883,u,n),_15942,_15933,_15906),
    !.

howadj(duration,[howadj,_15918,_15942,!],_15904,_15906) --> 
    much(_15918,_15904,_15933),
    w(noun(time,_15883,u,n),_15942,_15933,_15906),
    !.

howadj(duration,[howadj,_15910],_15896,_15898) --> 
    w(adj2(short,nil),_15910,_15896,_15898).

howadj(frequency,[howadj,_15905],_15891,_15893) --> 
    often(_15905,_15891,_15893).

howadj(frequency,[howadj,lit(mange),_15937,_15966,!,_15995],_15912,_15914) --> 
    cc(mange,_15912,_15936),
    w(noun(time_count,_15891,_15892,n),_15937,_15936,_15954),
    inperiod0(_15966,_15954,_15981),
    !,
    accept(_15995,_15981,_15914).

howadj(intelligence,[howadj,_15910],_15896,_15898) --> 
    w(adj2(intelligent,nil),_15910,_15896,_15898).

howadj(intelligence,[howadj,_15910],_15896,_15898) --> 
    w(adj2(stupid,_15877),_15910,_15896,_15898).

howadj(intelligence,[howadj,_15920,_15949],_15906,_15908) --> 
    w(adj2(_15886,nil),_15920,_15906,_15937),
    w(noun(intelligence,sin,_15881,n),_15949,_15937,_15908).

howadj(price,[howadj,_15910],_15896,_15898) --> 
    w(adj2(expensive,nil),_15910,_15896,_15898).

howadj(price,[howadj,_15910],_15896,_15898) --> 
    w(adj2(cheap,nil),_15910,_15896,_15898).

howadj(size,[howadj,_15905],_15891,_15893) --> 
    great(_15905,_15891,_15893).

howadj(length,[howadj,_15910],_15896,_15898) --> 
    w(adj2(long,nil),_15910,_15896,_15898).

howadj(length,[howadj,_15910],_15896,_15898) --> 
    w(adj2(short,nil),_15910,_15896,_15898).

howadj(speed,[howadj,lit(fort)],_15893,_15895) --> 
    cc(fort,_15893,_15895).

howadj(speed,[howadj,_15910],_15896,_15898) --> 
    w(adj2(fast,_15877),_15910,_15896,_15898).

howadj(speed,[howadj,_15910],_15896,_15898) --> 
    w(adj2(slow,_15877),_15910,_15896,_15898).

howadj(temperature,[howadj,_15910],_15896,_15898) --> 
    w(adj2(cold,nil),_15910,_15896,_15898).

howadj(temperature,[howadj,_15910],_15896,_15898) --> 
    w(adj2(hot,nil),_15910,_15896,_15898).

howadj(weather,[howadj,_15910],_15896,_15898) --> 
    w(adj2(hot,nil),_15910,_15896,_15898).

howadj(weather,[howadj,_15910],_15896,_15898) --> 
    w(adj2(cold,nil),_15910,_15896,_15898).

howadj(weight,[howadj,_15910],_15896,_15898) --> 
    w(adj2(heavy,nil),_15910,_15896,_15898).

vp(_15872,_15873,_15874,_15877::true,[vp,lit(:),_15945,!],_15911,_15913) --> 
    cc(:,_15911,_15944),
    end_of_line(_15945,_15944,_15913),
    !.

vp(_15872,_15873,_15874,_15875,[vp,_15928],_15905,_15907) --> 
    verb_phrase(_15872,_15873,_15874,_15875,_15928,_15905,_15907).

verb_phrase(_15872,_15873,_15874,_15875,[verb_phrase,_15996,{},{},{},{},!,_16065,_16089,!],_15973,_15975) --> 
    endofline(_15996,_15973,_16011),
    {user:value(busflag,true)},
    {user:(\+value(dialog,1))},
    {user:vartypeid(_15872,_15916)},
    {user:testmember(_15916,[neighbourhood,bus,tram,station,departure,arrival])},
    !,
    accept(_16065,_16011,_16080),
    pushstack(first,w(verb(exist,pres,fin)),nil,_16080,_16102),verb_phrase1(exist,_15872,_15873,_15874,_15875,_16089,_16102,_15975),
    !.

verb_phrase(_15872,_15873,_15874,_15877::_15878,[verb_phrase,_16032,{},lit(og),_16082,{},_16121,!,_16160,!,_16267],_16009,_16011) --> 
    w(verb(_15920,_15921,fin),_16032,_16009,_16049),
    {user:verbtype(_15920,tv)},
    cc(og,_16049,_16081),
    w(verb(_15933,_15934,fin),_16082,_16081,_16099),
    {user:verbtype(_15933,tv)},
    object(_15916,_15943,_16121,_16099,_16140),
    !,
    lock(exact,_16140,_16211),pushstack(exact,(w(verb(_15920,_15966,fin)),xnp(_15916,_15943)),nil,_16211,_16217),verb_phrase1(_15920,_15872,_15873,_15874,_15877::_15961,_16160,_16217,_16206),unlock(_16206,_16207),
    !,
    lock(exact,_16207,_16314),
    pushstack(exact,([og],w(verb(_15933,_15983,fin)),npgap(_15916)),nil,_16314,_16320),
    verb_phrases0(_15933,_15872,_15874,_15961,_15877::_15878,_16267,_16320,_16309),
    unlock(_16309,_16011).

verb_phrase(_15872,_15873,_15874,_15877::_15878,[verb_phrase,_15947,_15996],_15924,_15926) --> 
    verb_phrase1(_15883,_15872,_15873,_15874,_15877::_15886,_15947,_15924,_15972),
    verb_phrases0(_15883,_15872,_15874,_15886,_15877::_15878,_15996,_15972,_15926).

verb_phrases0(_15872,_15873,_15874,_15875,_15878::_15875 and _15882,[verb_phrases0,_15994,lit(ikke),!,_16034,{},{},_16112],_15968,_15970) --> 
    vp_conjunction(_15994,_15968,_16009),
    cc(ikke,_16009,_16028),
    !,
    pushstack(first,w(verb(_15872,pres,fin)),nil,_16028,_16047),verb_phrase1(_15872,_15873,_15924,_15874,_15878::_15929,_16034,_16047,_16068),
    {user:bigno(not,_15924,_15935)},
    {user:negate(_15935,_15929,_15905)},
    verb_phrases0(_15872,_15873,_15874,_15905,_15878::_15882,_16112,_16068,_15970).

verb_phrases0(_15872,_15873,_15874,_15875,_15878::_15875 and _15882,[verb_phrases0,_15975,_15999,_16028,{},_16087],_15949,_15951) --> 
    vp_conjunction(_15975,_15949,_15990),
    not_look_ahead([så],_15999,_15990,_16016),
    verb_phrase1(_15909,_15873,_15911,_15874,_15878::_15916,_16028,_16016,_16053),
    {user:negate(_15911,_15916,_15899)},
    verb_phrases0(_15896,_15873,_15874,_15899,_15878::_15882,_16087,_16053,_15951).

verb_phrases0(be,_15873,_15874,_15875,_15878::_15875 and _15882,[verb_phrases0,_15982,{},!,_16026],_15956,_15958) --> 
    w(adj2(_15901,nil),_15982,_15956,_15999),
    {user:testmember(_15901,[enclosed])},
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_15901,nil))),nil,_15999,_16036),
    verb_phrase1(be,_15873,id,_15874,_15878::_15882,_16026,_16036,_15958).

verb_phrases0(_15872,_15873,_15874,_15875,_15878::_15875,[verb_phrases0,[]],_15906,_15906) --> 
    [].

vp_conjunction([vp_conjunction,lit(som),_15914],_15892,_15894) --> 
    cc(som,_15892,_15913),
    look_ahead_vp(_15914,_15913,_15894).

vp_conjunction([vp_conjunction,lit(å),_15922],_15900,_15902) --> 
    cc(å,_15900,_15921),
    look_ahead(w(verb(_15879,pres,fin)),_15922,_15921,_15902).

vp_conjunction([vp_conjunction,lit(evt)],_15889,_15891) --> 
    cc(evt,_15889,_15891).

vp_conjunction([vp_conjunction,_15924,_15948,_15977,_16006,!],_15913,_15915) --> 
    and1(_15924,_15913,_15939),
    not_look_ahead([nå],_15948,_15939,_15965),
    not_look_ahead([så],_15977,_15965,_15994),
    not_look_ahead(w(adv(redundantly)),_16006,_15994,_15915),
    !.

vp_conjunction([vp_conjunction,lit(men),_15930,_15959,!],_15908,_15910) --> 
    cc(men,_15908,_15929),
    not_look_ahead([så],_15930,_15929,_15947),
    look_ahead_lit([skal,vil],_15959,_15947,_15910),
    !.

vp_conjunction([vp_conjunction,lit(men),_15932,_15961,!],_15910,_15912) --> 
    cc(men,_15910,_15931),
    not_look_ahead([så],_15932,_15931,_15949),
    look_ahead(w(verb(_15891,_15892,_15893)),_15961,_15949,_15912),
    !.

vp_conjunction([vp_conjunction,_15909,_15933],_15898,_15900) --> 
    or1(_15909,_15898,_15924),
    look_ahead(w(verb(_15879,_15880,fin)),_15933,_15924,_15900).

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_15975,_15999,_16028,!,_16062,_16086],_15949,_15951) --> 
    aux1(_15975,_15949,_15990),
    not_look_ahead(w(verb(_15906,_15907,_15908)),_15999,_15990,_16016),
    look_ahead_lit([så,tilbake,fram],_16028,_16016,_16045),
    !,
    accept(_16062,_16045,_16077),
    pushstack(first,w(verb(go,pres,fin)),nil,_16077,_16096),
    do_phrase(_15872,_15873,_15874,_15875,_15876,_16086,_16096,_15951).

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_15998,_16022,_16051,{},{},!,_16110,_16134],_15972,_15974) --> 
    aux1(_15998,_15972,_16013),
    not_look_ahead(w(verb(_15912,_15913,_15914)),_16022,_16013,_16039),
    np0_accept(_15905,_15906,_16051,_16039,_16070),
    {user:vartypeid(_15905,_15922)},
    {user:testmember(_15922,[thing,coevent,activity])},
    !,
    accept(_16110,_16070,_16125),
    pushstack(first,(w(verb(do1,pres,fin)),xnp(_15905,_15906)),nil,_16125,_16175),
    do_phrase(_15872,_15873,_15874,_15875,_15876,_16134,_16175,_15974).

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_16025,_16049,_16078,_16102,_16131,{},_16170,_16194,{},!,_16243,_16267],_15999,_16001) --> 
    aux1(_16025,_15999,_16040),
    negation0(_15874,_16049,_16040,_16066),
    redundant0(_16078,_16066,_16093),
    not_look_ahead(w(verb(_15929,_15930,_15931)),_16102,_16093,_16119),
    w(prep(_15935),_16131,_16119,_16148),
    {user:testmember(_15935,[from,to,on,towards])},
    look_ahead_np(_16170,_16148,_16185),
    np0_accept(_15920,_15921,_16194,_16185,_16213),
    {user:constrain(_15920,place)},
    !,
    accept(_16243,_16213,_16258),
    pushstack(first,(w(verb(go,pres,fin)),w(prep(_15935)),xnp(_15920,_15921)),nil,_16258,_16308),
    do_phrase(_15872,_15873,_15874,_15875,_15876,_16267,_16308,_16001).

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_15985,_16009,_16038,{},_16077,!,_16106,_16130],_15959,_15961) --> 
    aux1(_15985,_15959,_16000),
    not_look_ahead(w(verb(_15909,_15910,_15911)),_16009,_16000,_16026),
    look_ahead(w(prep(_15917)),_16038,_16026,_16055),
    {user:(\+testmember(_15917,[from,to,on,towards]))},
    preadverbials0(_16077,_16055,_16092),
    !,
    accept(_16106,_16092,_16121),
    do_phrase(_15872,_15873,_15874,_15875,_15876,_16130,_16121,_15961).

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_15964,_15988,_16017,!,_16051,_16075],_15938,_15940) --> 
    aux1(_15964,_15938,_15979),
    not_look_ahead(w(verb(_15903,_15904,_15905)),_15988,_15979,_16005),
    one_of_lit([da,nå],_16017,_16005,_16034),
    !,
    accept(_16051,_16034,_16066),
    do_phrase(_15872,_15873,_15874,_15875,_15876,_16075,_16066,_15940).

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_15992,_16016,_16045,_16074,_16098,{},!,_16147,_16171],_15966,_15968) --> 
    aux1(_15992,_15966,_16007),
    not_look_ahead(w(verb(_15915,_15916,_15917)),_16016,_16007,_16033),
    w(prep(_15921),_16045,_16033,_16062),
    look_ahead_np(_16074,_16062,_16089),
    np0_accept(_15908,_15909,_16098,_16089,_16117),
    {user:constrain(_15908,time)},
    !,
    accept(_16147,_16117,_16162),
    lock(last,_16162,_16219),
    pushstack(last,(w(prep(_15921)),xnp(_15908,_15909)),nil,_16219,_16225),
    do_phrase(_15872,_15873,_15874,_15875,_15876,_16171,_16225,_16214),
    unlock(_16214,_15968).

verb_phrase1(be1,_15873,_15874,_15875,_15876,[verb_phrase1,lit(skal),_16000,_16029,lit(med),_16084,_16108,{}],_15963,_15965) --> 
    cc(skal,_15963,_15999),
    negation0(_15898,_16000,_15999,_16017),
    optional(w(verb(be,inf,fin)),_16029,_16017,_16061),
    cc(med,_16061,_16083),
    not_look_ahead_np(_16084,_16083,_16099),
    pushstack(first,(w(verb(be1,inf,fin)),w(adv(inside))),nil,_16099,_16121),do_phrase(be1,_15873,_15899,_15875,_15876,_16108,_16121,_15965),
    {user:bigno(_15898,_15899,_15874)}.

verb_phrase1(be,_15873,id,_15875,_15876,[verb_phrase1,_15959,{},_15998],_15933,_15935) --> 
    w(adj2(_15889,nil),_15959,_15933,_15976),
    {user:testmember(_15889,[enclosed])},
    pushstack(first,w(adj2(_15889,nil)),nil,_15976,_16008),
    be_pred(_15873,_15875,_15876,_15998,_16008,_15935).

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_16007,_16036,_16065,_16094,{},!,_16138,_16196,{}],_15981,_15983) --> 
    constrainvehdep(_15873,_16007,_15981,_16024),
    w(verb(be,_15913,fin),_16036,_16024,_16053),
    negation0(_15904,_16065,_16053,_16082),
    w(verb(_15872,past,part),_16094,_16082,_16111),
    {user:testmember(_15872,[go,run,pass])},
    !,
    pushstack(first,w(verb(_15872,_15913,fin)),nil,_16111,_16151),vp_kernel(_15872,_15873,_15905,_15875,_15948,_16138,_16151,_16172),
    verb_modifiers0(_15872,_15873,_15875,_15948,_15876,_16196,_16172,_15983),
    {user:bigno(_15904,_15905,_15874)}.

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_15972,_15996,_16025,_16054,!,_16103],_15946,_15948) --> 
    blei(_15972,_15946,_15987),
    one_of_lit([siden,derfor,dermed],_15996,_15987,_16013),
    negation0(_15874,_16025,_16013,_16042),
    lexv(tv,_15872,past,part,_16054,_16042,_16077),
    !,
    pushstack(first,w(verb(_15872,past,part)),nil,_16077,_16113),
    passive(_15873,_15875,_15876,_16103,_16113,_15948).

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_15967,_15991,_16015,_16044,_16068,!,_16117],_15941,_15943) --> 
    aux1(_15967,_15941,_15982),
    redundant0(_15991,_15982,_16006),
    negation0(_15874,_16015,_16006,_16032),
    blei(_16044,_16032,_16059),
    lexv(tv,_15872,past,part,_16068,_16059,_16091),
    !,
    pushstack(first,w(verb(_15872,past,part)),nil,_16091,_16127),
    passive(_15873,_15875,_15876,_16117,_16127,_15943).

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_15974,_15998,_16027,_16051,_16095,!,_16134],_15948,_15950) --> 
    redundant0(_15974,_15948,_15989),
    blei(_15874,_15998,_15989,_16015),
    redundant0(_16027,_16015,_16042),
    lexv(_15907,_15872,past,part,_16051,_16042,_16074),
    gmem(_15907,[tv,dtv],_16095,_16074,_16114),
    !,
    pushstack(first,w(verb(_15872,past,part)),nil,_16114,_16144),
    passive(_15873,_15875,_15876,_16134,_16144,_15950).

verb_phrase1(be,_15873,_15874,_15875,_15876,[verb_phrase1,_15967,_15996,_16020,_16044,_16073,_16097,_16121,_16145,_16169],_15941,_15943) --> 
    not_look_ahead(w(verb(go,_15911,fin)),_15967,_15941,_15984),
    aux10(_15996,_15984,_16011),
    redundants0(_16020,_16011,_16035),
    be(_15874,_16044,_16035,_16061),
    not_look_ahead_verbx(_16073,_16061,_16088),
    danow0(_16097,_16088,_16112),
    redundant0(_16121,_16112,_16136),
    not_look_ahead_prepx(_16145,_16136,_16160),
    be_complements(_15873,_15875,_15876,_16169,_16160,_15943).

not_look_ahead_verbx([not_look_ahead_verbx,lit(så),!],_15892,_15894) --> 
    cc(så,_15892,_15894),
    !.

not_look_ahead_verbx([not_look_ahead_verbx,_15906],_15895,_15897) --> 
    not_look_ahead(w(verb(_15876,_15877,_15878)),_15906,_15895,_15897).

not_look_ahead_prepx([not_look_ahead_prepx,_15922,{},!,_15966],_15911,_15913) --> 
    look_ahead(w(prep(_15885)),_15922,_15911,_15939),
    {user:(\+testmember(_15885,[for]))},
    !,
    reject(_15966,_15939,_15913).

not_look_ahead_prepx([not_look_ahead_prepx,[]],_15887,_15887) --> 
    [].

verb_phrase1(_15872,_15873,_15874,_15875,_15876,[verb_phrase1,_15984,_16018,_16047,_16071,{},_16110,{},!,_16174],_15958,_15960) --> 
    auxs0(_15902,_15903,_15984,_15958,_16003),
    not_look_ahead(w(verb(_15909,_15910,pass)),_16018,_16003,_16035),
    redundants0(_16047,_16035,_16062),
    negation0(_15913,_16071,_16062,_16088),
    {user:bigno(_15902,_15913,_15919)},
    do_phrase(_15872,_15873,_15923,_15875,_15876,_16110,_16088,_16135),
    {user:bigno(_15919,_15923,_15874)},
    !,
    accept(_16174,_16135,_15960).

verb_phrase1(go,_15873,_15874,_15875,_15876,[verb_phrase1,_15974,_15998,lit(av),!,_16043,_16067],_15948,_15950) --> 
    aux1(_15974,_15948,_15989),
    not_look_ahead(w(verb(_15905,_15906,_15907)),_15998,_15989,_16015),
    cc(av,_16015,_16037),
    !,
    accept(_16043,_16037,_16058),
    pushstack(first,(w(verb(go,pres,fin)),[av]),nil,_16058,_16077),
    do_phrase(go,_15873,_15874,_15875,_15876,_16067,_16077,_15950).

verb_phrase1(_15872,_15873,id,_15875,_15878::_15879,[verb_phrase1,_15963,_15987,_16011,_16040],_15937,_15939) --> 
    paux0(_15963,_15937,_15978),
    redundant0(_15987,_15978,_16002),
    w(verb(_15872,_15902,pass),_16011,_16002,_16028),
    pushstack(first,w(verb(_15872,past,part)),nil,_16028,_16050),
    passive(_15873,_15875,_15878::_15879,_16040,_16050,_15939).

verb_phrase1(live,_15873,id,_15875,_15876,[verb_phrase1,_15998,_16022,_16046,_16075,_16104,!,_16153],_15972,_15974) --> 
    be(_15998,_15972,_16013),
    redundant0(_16022,_16013,_16037),
    number(_15915,_16046,_16037,_16063),
    w(noun(year,_15920,u,n),_16075,_16063,_16092),
    optional(w(adj2(old,nil)),_16104,_16092,_16136),
    !,
    pushstack(first,(w(verb(live,pres,fin)),prep1(in),number(_15915),w(noun(year,plu,u,n))),nil,_16136,_16227),
    do_phrase(live,_15873,id,_15875,_15876,_16153,_16227,_15974).

verb_phrase1(be,_15873,_15874,_15875,_15876,[verb_phrase1,_15951,_15980,lit(som),!,_16020],_15925,_15927) --> 
    be(_15874,_15951,_15925,_15968),
    dudet(_15980,_15968,_15995),
    cc(som,_15995,_16014),
    !,
    do_phrase(be,_15873,_15874,_15875,_15876,_16020,_16014,_15927).

verb_phrase1(be,_15873,_15874,_15875,_15876,[verb_phrase1,_16012,_16041,_16070,!,_16104,_16128,_16157,_16186,_16210,_16234,{}],_15986,_15988) --> 
    not_look_ahead(w(verb(go,_15919,fin)),_16012,_15986,_16029),
    w(verb(be,_15925,fin),_16041,_16029,_16058),
    not_look_ahead(w(verb(_15932,_15933,part)),_16070,_16058,_16087),
    !,
    accept(_16104,_16087,_16119),
    not_look_ahead(w(name(_15940,_15941,_15942)),_16128,_16119,_16145),
    negation0(_15910,_16157,_16145,_16174),
    it0(_16186,_16174,_16201),
    redundant0(_16210,_16201,_16225),
    pushstack(first,w(verb(be,pres,fin)),nil,_16225,_16247),do_phrase(be,_15873,_15911,_15875,_15876,_16234,_16247,_15988),
    {user:bigno(_15910,_15911,_15874)}.

verb_phrase1(_15872,_15873,id,_15875,_15876,[verb_phrase1,_15956,_15980,_16009,_16033],_15930,_15932) --> 
    paux0(_15956,_15930,_15971),
    w(verb(_15872,pres,pass),_15980,_15971,_15997),
    thereit0(_16009,_15997,_16024),
    pushstack(first,w(adj2(_15872,nil)),nil,_16024,_16043),
    be_complements(_15873,_15875,_15876,_16033,_16043,_15932).

do_phrase(_15872,_15873,_15874,_15875,_15876,[do_phrase,_16057,{},_16096,_16125,_16149,_16178,_16207,{},!,_16251,_16275,_16341],_16031,_16033) --> 
    w(verb(_15872,_15930,fin),_16057,_16031,_16074),
    {user:testmember(_15872,[go,come])},
    negation0(_15874,_16096,_16074,_16113),
    morethan0(_16125,_16113,_16140),
    w(nb(_15946,num),_16149,_16140,_16166),
    w(noun(minute,_15952,u,n),_16178,_16166,_16195),
    w(adj2(_15958,_15959),_16207,_16195,_16224),
    {user:testmember(_15958,[delayed,tooearly,late])},
    !,
    accept(_16251,_16224,_16266),
    lock(exact,_16266,_16295),pushstack(exact,w(adj2(_15958,_15959)),nil,_16295,_16301),ap(_15958,_15873,_15875,_15983,_16275,_16301,_16290),unlock(_16290,_16291),
    pushstack(first,(w(prep(with)),w(nb(_15946,num)),w(noun(minute,plu,u,n))),nil,_16291,_16351),
    verb_modifiers0(adj/nil/_15958,_15873,_15875,_15983,_15876,_16341,_16351,_16033).

morethan0([morethan0,lit(ca),!],_15892,_15894) --> 
    cc(ca,_15892,_15894),
    !.

morethan0([morethan0,lit(minst),!],_15892,_15894) --> 
    cc(minst,_15892,_15894),
    !.

morethan0([morethan0,lit(mer),lit(enn),!],_15897,_15899) --> 
    cc(mer,_15897,_15918),
    cc(enn,_15918,_15899),
    !.

morethan0([morethan0,[]],_15887,_15887) --> 
    [].

do_phrase(_15872,_15873,id,_15875,_15878::_15881 and _15882,[do_phrase,_16013,_16042,_16071,{},_16115,_16139,!,_16173,{}],_15987,_15989) --> 
    w(verb(ask,_15920,fin),_16013,_15987,_16030),
    not_look_ahead([om],_16042,_16030,_16059),
    object(_15927,_15928,_16071,_16059,_16090),
    {user:constrain(_15927,agent)},
    omaa0(_16115,_16090,_16130),
    w(verb(_15937,inf,fin),_16139,_16130,_16156),
    !,
    pushstack(first,(xnp(_15927,_15928),w(verb(_15937,pres,fin))),nil,_16156,_16217),clausal_object1(_15913,_15878::_15882,_16173,_16217,_15989),
    {user:co_template(_15872,that,_15873,_15913,_15875,_15881)}.

omaa0([omaa0,[]],_15887,_15887) --> 
    [].

omaa([omaa,lit(om),lit(å)],_15894,_15896) --> 
    cc(om,_15894,_15915),
    cc(å,_15915,_15896).

omaa([omaa,lit(om),lit(og)],_15894,_15896) --> 
    cc(om,_15894,_15915),
    cc(og,_15915,_15896).

omaa([omaa,lit(å)],_15889,_15891) --> 
    cc(å,_15889,_15891).

do_phrase(_15872,_15873,_15874,_15875,_15876,[do_phrase,_15944,_15993],_15918,_15920) --> 
    rvp_kernel(_15872,_15873,_15874,_15875,_15884,_15944,_15918,_15969),
    verb_modifiers0(_15872,_15873,_15875,_15884,_15876,_15993,_15969,_15920).

do_phrase(have,_15873,id,_15875,_15878::_15881 and _15882,[do_phrase,_16003,_16027,{},lit(for),lit(å),!,_16093,_16117,{}],_15977,_15979) --> 
    has(_16003,_15977,_16018),
    w(adj2(_15918,nil),_16027,_16018,_16044),
    {user:testmember(_15918,[difficult])},
    cc(for,_16044,_16076),
    cc(å,_16076,_16087),
    !,
    accept(_16093,_16087,_16108),
    pushstack(first,(npgap(_15873),aux1),nil,_16108,_16188),clausal_object1(_15944:coevent,_15878::_15882,_16117,_16188,_15979),
    {user:tv_template(dislike,_15873,_15944:coevent,_15875,_15881)}.

do_phrase(_15872,_15873,_15874,_15875,_15876,[do_phrase,_15950,_15999,_16048],_15924,_15926) --> 
    vp_kernel(_15872,_15873,_15884,_15875,_15891,_15950,_15924,_15975),
    verb_modifiers0(_15872,_15873,_15875,_15891,_15876,_15999,_15975,_16024),
    negation2(_15884,_15874,_16048,_16024,_15926).

do_phrase(_15872,_15873,_15874,_15875,_15876,[do_phrase,_15979,_16008,!,_16042,_16100,_16124],_15953,_15955) --> 
    not_look_ahead(w(verb(_15903,_15904,_15905)),_15979,_15953,_15996),
    look_ahead(w(prep(_15911)),_16008,_15996,_16025),
    !,
    pushstack(first,w(verb(do1,pres,fin)),nil,_16025,_16055),vp_kernel(_15872,_15873,_15874,_15875,_15896,_16042,_16055,_16076),
    it0(_16100,_16076,_16115),
    verb_modifiers0(_15872,_15873,_15875,_15896,_15876,_16124,_16115,_15955).

rvp_kernel(_15872,_15873,_15874,_15875,_15876,[rvp_kernel,_16069,{},_16128,_16157,_16186,_16215,_16244,{},_16288,_16332,_16361,!,_16400,_16520],_16043,_16045) --> 
    hlexv(dtv,_15872,_15928,_15929,_15930,_16069,_16043,_16094),
    {user:testmember(_15872,[ask,tell,answer,answer1])},
    not_look_ahead([om],_16128,_16094,_16145),
    not_look_ahead([et],_16157,_16145,_16174),
    not_look_ahead([en],_16186,_16174,_16203),
    not_look_ahead(w(nb(_15961,_15962)),_16215,_16203,_16232),
    ind_object(_15964,_15965,_16244,_16232,_16263),
    {user:constrain(_15964,agent)},
    optional([om],_16288,_16263,_16320),
    not_look_ahead([at],_16332,_16320,_16349),
    np1_accept(_15923,_15924,_16361,_16349,_16380),
    !,
    pushstack(first,(lexv(dtv,_15872,_15928,_15929),xnp(_15964,_15965),[noe]),nil,_16380,_16475),vp_kernel(_15872,_15873,_15874,_15875,_15998,_16400,_16475,_16496),
    pushstack(first,(w(prep(about)),xnp(_15923,_15924)),nil,_16496,_16561),
    verb_modifiers0(_15872,_15873,_15875,_15998,_15876,_16520,_16561,_16045).

rvp_kernel(_15872,_15873,_15874,_15875,_15876,[rvp_kernel,_15952,_16001,_16030,!],_15926,_15928) --> 
    lexvaccept(rv,_15872,_15889,_15890,_15874,_15952,_15926,_15977),
    reflexiv0(_15872,_16001,_15977,_16018),
    rvpk(_15872,_15873,id,_15875,_15876,_16030,_16018,_15928),
    !.

rvp_kernel(_15872,_15873,id,_15875,event/real/_15875::_15881 and _15882,[rvp_kernel,_16017,{},_16076,_16105,{},_16144,!,_16173,_16197,{}],_15991,_15993) --> 
    hlexv(rv,_15872,_15927,_15928,_15929,_16017,_15991,_16042),
    {user:testmember(_15872,[know,say])},
    reflexiv0(_15872,_16076,_16042,_16093),
    w(prep(_15944),_16105,_16093,_16122),
    {user:(\+testmember(_15944,[]))},
    which(_16144,_16122,_16159),
    !,
    accept(_16173,_16159,_16188),
    pushstack(first,(w(prep(_15944)),which),nil,_16188,_16238),ppstnp(_15921,_15881,_16197,_16238,_15993),
    {user:tv_template(_15872,_15873,_15921,_15875,_15882)}.

rvp_kernel(adj/nil/_15885,_15873,_15874,_15875,_15878::_15881 and _15882,[rvp_kernel,_15990,_16019,_16048,_16077,_16101,{}],_15964,_15966) --> 
    w(verb(be,_15917,fin),_15990,_15964,_16007),
    negation0(_15874,_16019,_16007,_16036),
    w(adj2(_15885,nil),_16048,_16036,_16065),
    forat(_16077,_16065,_16092),
    clausal_object1(_15933:_15934,_15878::_15882,_16101,_16092,_15966),
    {user:atv_template(_15885,because_of,_15873,_15933:_15934,_15875,_15881)}.

rvpk(_15872,_15873,id,_15875,_15878::_15881 and _15882,[rvpk,{},_16025,lit(hvordan),_16060,!,_16089,_16113,{}],_15989,_15991) --> 
    {user:testmember(_15872,[ask,answer,answer1,discuss,know,know1])},
    omut0(_16025,_15989,_16040),
    cc(hvordan,_16040,_16059),
    endofline0(_16060,_16059,_16075),
    !,
    accept(_16089,_16075,_16104),
    pushstack(first,(w(noun(bus,sin,def,n)),w(verb(go,pres,fin))),nil,_16104,_16126),clausal_object1(_15951:_15952,_15878::_15882,_16113,_16126,_15991),
    {user:co_template(_15872,how,_15873,_15951:_15952,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},_16021,lit(hvordan),!,_16061,{},!,_16105,_16129,{}],_15985,_15987) --> 
    {user:testmember(_15872,[ask,answer,answer1,discuss,know,know1])},
    omut0(_16021,_15985,_16036),
    cc(hvordan,_16036,_16055),
    !,
    negation0(_15874,_16061,_16055,_16078),
    {user:test(rv_templ(_15872,_15946))},
    !,
    accept(_16105,_16078,_16120),
    clausal_object1(_15954:_15955,_15878::_15882,_16129,_16120,_15987),
    {user:co_template(_15872,how,_15873,_15954:_15955,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,_16018,_16052,lit(at),_16092,!,_16126,_16165,{}],_15992,_15994) --> 
    gmem(_15872,[calculate,say,tell,know,decide,believe,doubt,think],_16018,_15992,_16037),
    negation0(_15874,_16052,_16037,_16069),
    cc(at,_16069,_16091),
    look_ahead_lit([hvis,når,selvom],_16092,_16091,_16109),
    !,
    subordinate(_15944,_15945,_15946,_16126,_16109,_16147),
    lock(last,_16147,_16217),pushstack(last,subordinate(_15944,_15945,_15946),nil,_16217,_16223),clausal_object1(_15961:_15962,_15878::_15882,_16165,_16223,_16212),unlock(_16212,_15994),
    {user:tv_template(_15872,_15873,_15961:_15962,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,_15997,_16031,_16055,_16084,_16113,{}],_15971,_15973) --> 
    gmem(_15872,[calculate,fear,hope,know,mean,recognize,think,understand],_15997,_15971,_16016),
    redundant0(_16031,_16016,_16046),
    negation0(_15874,_16055,_16046,_16072),
    not_look_ahead_lit([at,om],_16084,_16072,_16101),
    clausal_object0(_15940:_15941,_15878::_15882,_16113,_16101,_15973),
    {user:tv_template(_15872,_15873,_15940:_15941,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,_16005,_16039,lit(at),_16079,!,_16118,_16142,{}],_15979,_15981) --> 
    gmem(_15872,[do1,paint],_16005,_15979,_16024),
    negation0(_15874,_16039,_16024,_16056),
    cc(at,_16056,_16078),
    np0_accept(_15924,_15925,_16079,_16078,_16098),
    !,
    accept(_16118,_16098,_16133),
    pushstack(first,(xnp(_15924,_15925),w(verb(be,pres,fin))),nil,_16133,_16186),clausal_object1(_15945:_15946,_15878::_15882,_16142,_16186,_15981),
    {user:tv_template(_15872,_15873,_15945:_15946,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},_15998,_16027,lit(at),!,_16067,{}],_15962,_15964) --> 
    {user:testmember(_15872,[base,say,tell])},
    negation0(_15874,_15998,_15962,_16015),
    preadverbials0(_16027,_16015,_16042),
    cc(at,_16042,_16061),
    !,
    clausal_object1(_15931:_15932,_15878::_15882,_16067,_16061,_15964),
    {user:tv_template(_15872,_15873,_15931:_15932,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},_16001,_16030,!,_16064,_16088,{}],_15965,_15967) --> 
    {user:testmember(_15872,[mean,think])},
    pronoun(_15919,_16001,_15965,_16018),
    negation0(_15874,_16030,_16018,_16047),
    !,
    accept(_16064,_16047,_16079),
    pushstack(first,pronoun(_15919),nil,_16079,_16131),clausal_object1(_15934:_15935,_15878::_15882,_16088,_16131,_15967),
    {user:tv_template(_15872,_15873,_15934:_15935,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},_16004,_16033,_16067,lit(å),!,_16127,{}],_15968,_15970) --> 
    {user:testmember(_15872,[regard])},
    negation0(_15874,_16004,_15968,_16021),
    object1(_15922,_15923,_16033,_16021,_16052),
    optional([for],_16067,_16052,_16099),
    cc(å,_16099,_16121),
    !,
    pushstack(first,xnp(_15922,_15923),nil,_16121,_16171),clausal_object1(_15909,_15878::_15882,_16127,_16171,_15970),
    {user:tv_template(_15872,_15873,_15909,_15875,_15881)}.

rvpk(_15872,_15873,id,_15875,_15878::_15881 and _15882,[rvpk,{},_16004,_16048,lit(når),!,_16108,_16132,{}],_15968,_15970) --> 
    {user:testmember(_15872,[wonder])},
    optional([på],_16004,_15968,_16036),
    optional([om],_16048,_16036,_16080),
    cc(når,_16080,_16102),
    !,
    accept(_16108,_16102,_16123),
    clausal_object1(_15937:coevent,_15878::_15882,_16132,_16123,_15970),
    {user:co_template(_15872,when,_15873,_15937:coevent,_15875,_15881)}.

rvpk(_15872,_15873,id,_15875,_15878::_15881 and _15882,[rvpk,{},_15999,lit(om),!,_16059,_16083,{}],_15963,_15965) --> 
    {user:testmember(_15872,[think,wonder])},
    optional([på],_15999,_15963,_16031),
    cc(om,_16031,_16053),
    !,
    accept(_16059,_16053,_16074),
    clausal_object1(_15932:coevent,_15878::_15882,_16083,_16074,_15965),
    {user:co_template(_15872,whether,_15873,_15932:coevent,_15875,_15881)}.

altsogå([altsogå,lit(altså),lit(å)],_15894,_15896) --> 
    cc(altså,_15894,_15915),
    cc(å,_15915,_15896).

altsogå([altsogå,lit(og),lit(å)],_15894,_15896) --> 
    cc(og,_15894,_15915),
    cc(å,_15915,_15896).

ppstnp(_15872,_15873,[ppstnp,_15933,_15962,_15986,_16025],_15916,_15918) --> 
    w(prep(_15885),_15933,_15916,_15950),
    which(_15962,_15950,_15977),
    np_kernel(0,_15872,_15887,_15986,_15977,_16007),
    forwst(_15873,_15885,_15872,_15887,_16025,_16007,_15918).

forwst(_15872,_15873,_15874,_15875,[forwst,_15932],_15909,_15911) --> 
    pushstack(free,adverbial1(_15873,_15874,_15875),nil,_15909,_15974),
    statreal(_15872,_15932,_15974,_15911).

forat([forat,lit(at)],_15889,_15891) --> 
    cc(at,_15889,_15891).

forat([forat,lit(for),lit(at)],_15894,_15896) --> 
    cc(for,_15894,_15915),
    cc(at,_15915,_15896).

forat([forat,lit(fordi)],_15889,_15891) --> 
    cc(fordi,_15889,_15891).

forat([forat,lit(av),lit(at)],_15894,_15896) --> 
    cc(av,_15894,_15915),
    cc(at,_15915,_15896).

forat([forat,lit(over),lit(at)],_15894,_15896) --> 
    cc(over,_15894,_15915),
    cc(at,_15915,_15896).

forat([forat,lit(til),lit(at)],_15894,_15896) --> 
    cc(til,_15894,_15915),
    cc(at,_15915,_15896).

forat([forat,lit(om)],_15889,_15891) --> 
    cc(om,_15889,_15891).

rvpk(_15872,_15873,id,_15875,_15878::_15881 and _15882,[rvpk,{},_16016,lit(hvor),_16051,!,_16085,{}],_15980,_15982) --> 
    {user:testmember(_15872,[ask,answer,answer1,discuss,know,know1])},
    omut0(_16016,_15980,_16031),
    cc(hvor,_16031,_16050),
    w(adj2(_15932,nil),_16051,_16050,_16068),
    !,
    pushstack(free,w(adj2(_15932,nil)),nil,_16068,_16098),clausal_object1(_15949:_15950,_15878::_15882,_16085,_16098,_15982),
    {user:co_template(_15872,how,_15873,_15949:_15950,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,_16021,_16055,_16084,_16108,lit(når),{},!,_16158,!,_16192,_16216,{}],_15995,_15997) --> 
    gmem(_15872,[ask,answer,answer1,discover,discuss,know,know1,say],_16021,_15995,_16040),
    reflexiv0(_15872,_16055,_16040,_16072),
    redundant0(_16084,_16072,_16099),
    omut0(_16108,_16099,_16123),
    cc(når,_16123,_16142),
    {user:test(rv_templ(_15872,_15954))},
    !,
    negation0(_15874,_16158,_16142,_16175),
    !,
    accept(_16192,_16175,_16207),
    clausal_object1(_15964:_15965,_15878::_15882,_16216,_16207,_15997),
    {user:co_template(_15872,when,_15873,_15964:_15965,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},{},lit(_15945),{},!,_16068,!,_16102,_16126,{}],_15996,_15998) --> 
    {user:(\+testmember(_15872,[fail,help,let,lie2,slip,try]))},
    {user:test(rv_templ(_15872,_15944))},
    cc(_15945,_15996,_16052),
    {user:testmember(_15945,[hvorfor,hvordan])},
    !,
    negation0(_15874,_16068,_16052,_16085),
    !,
    accept(_16102,_16085,_16117),
    clausal_object1(_15965:_15966,_15878::_15882,_16126,_16117,_15998),
    {user:co_template(_15872,why,_15873,_15965:_15966,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},_16010,_16039,lit(at),!,_16094,{},[]],_15974,_15976) --> 
    {user:testmember(_15872,[say,tell])},
    negation0(_15874,_16010,_15974,_16027),
    pp(_15908,_15909,_15910,_16039,_16027,_16060),
    cc(at,_16060,_16088),
    !,
    clausal_object1(_15935:_15936,_15878::_15882,_16094,_16088,_16113),
    {user:tv_template(_15872,_15873,_15935:_15936,_15875,_15881)},
    pushstack(free,adverbial1(_15908,_15909,_15910),nil,_16113,_15976),
    [].

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},_16033,_16062,_16086,{},{},!,_16140,_16164,{}],_15997,_15999) --> 
    {user:(\+testmember(_15872,[fail,help,let,lie2,slip,think,try,propose]))},
    reflexiv0(_15872,_16033,_15997,_16050),
    omut0(_16062,_16050,_16077),
    negation0(_15874,_16086,_16077,_16103),
    {user:test(rv_templ(_15872,_15951))},
    {user:(\+verbtype(_15872,tv))},
    !,
    accept(_16140,_16103,_16155),
    clausal_object0(_15966:_15967,_15878::_15882,_16164,_16155,_15999),
    {user:tv_template(_15872,_15873,_15966:_15967,_15875,_15881)}.

at0([at0,lit(at),!],_15892,_15894) --> 
    cc(at,_15892,_15894),
    !.

at0([at0,_15916],_15905,_15907) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de,det],_15916,_15905,_15907).

omut0([omut0,lit(om),!],_15892,_15894) --> 
    cc(om,_15892,_15894),
    !.

omut0([omut0,lit(ut),!],_15892,_15894) --> 
    cc(ut,_15892,_15894),
    !.

omut0([omut0,[]],_15887,_15887) --> 
    [].

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},_16022,lit(om),_16062,!,_16096,!,_16130,_16154,{}],_15986,_15988) --> 
    {user:testmember(_15872,[ask,say,know,know1,answer,answer1])},
    reflexiv0(_15872,_16022,_15986,_16039),
    cc(om,_16039,_16061),
    not_look_ahead_lit([et,en],_16062,_16061,_16079),
    !,
    negation0(_15874,_16096,_16079,_16113),
    !,
    accept(_16130,_16113,_16145),
    clausal_object1(_15955:_15956,_15878::_15882,_16154,_16145,_15988),
    {user:co_template(_15872,whether,_15873,_15955:_15956,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},{},_16037,_16066,lit(at),!,_16106,!,_16140,_16164,{}],_15991,_15993) --> 
    {user:test(rv_templ(_15872,_15927))},
    {user:(\+testmember(_15872,[fail,help,let,lie2,slip,try]))},
    reflexiv0(_15872,_16037,_15991,_16054),
    omut0(_16066,_16054,_16081),
    cc(at,_16081,_16100),
    !,
    negation0(_15874,_16106,_16100,_16123),
    !,
    accept(_16140,_16123,_16155),
    clausal_object1(_15960:_15961,_15878::_15882,_16164,_16155,_15993),
    {user:tv_template(_15872,_15873,_15960:_15961,_15875,_15881)}.

at0([at0,lit(at),!],_15892,_15894) --> 
    cc(at,_15892,_15894),
    !.

at0([at0,_15914],_15903,_15905) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_15914,_15903,_15905).

omut0([omut0,lit(om),!],_15892,_15894) --> 
    cc(om,_15892,_15894),
    !.

omut0([omut0,lit(ut),!],_15892,_15894) --> 
    cc(ut,_15892,_15894),
    !.

omut0([omut0,[]],_15887,_15887) --> 
    [].

rvpk(_15872,_15873,_15874,_15875,_15876,[rvpk,{},_16006,_16050,_16074,!,_16113],_15970,_15972) --> 
    {user:testmember(_15872,[ask,check,discuss,know,know1,tell])},
    optional([om],_16006,_15970,_16038),
    hvilkemange(_16050,_16038,_16065),
    clausal_object0(_15902,_15903,_16074,_16065,_16093),
    !,
    pushstack(first,(w(verb(_15872,pres,fin)),w(prep(about)),xnp(_15902,_15903)),nil,_16093,_16154),
    do_phrase(_15872,_15873,_15874,_15875,_15876,_16113,_16154,_15972).

hvilkemange([hvilkemange,lit(hvilke)],_15889,_15891) --> 
    cc(hvilke,_15889,_15891).

hvilkemange([hvilkemange,lit(hvor),lit(mange)],_15894,_15896) --> 
    cc(hvor,_15894,_15915),
    cc(mange,_15915,_15896).

rvpk(_15872,_15873,id,_15875,_15878::_15881 and _15882,[rvpk,lit(om),lit(å),{},{},!,_16046,{}],_15973,_15975) --> 
    cc(om,_15973,_16009),
    cc(å,_16009,_16020),
    {user:testmember(_15872,[ask])},
    {user:test(rv_templ(_15872,_15926))},
    !,
    pushstack(first,(npgap(_15873),aux1),nil,_16020,_16117),clausal_object1(_15940:coevent,_15878::_15882,_16046,_16117,_15975),
    {user:tv_template(_15872,_15873,_15940:coevent,_15875,_15881)}.

rvpk(_15872,_15873,id,_15875,_15878::_15881 and _15882,[rvpk,_15992,_16026,!,_16075,{}],_15966,_15968) --> 
    gmem(_15872,[need,start,stop,try,use2],_15992,_15966,_16011),
    optional([å],_16026,_16011,_16058),
    !,
    pushstack(first,(npgap(_15873),aux1),nil,_16058,_16146),clausal_object1(_15933:coevent,_15878::_15882,_16075,_16146,_15968),
    {user:tv_template(_15872,_15873,_15933:coevent,_15875,_15881)}.

rvpk(_15872,_15873,id,_15875,_15878::_15881 and _15882,[rvpk,_16054,lit(å),{},!,_16124,_16148,{}],_16028,_16030) --> 
    optional([på],_16054,_16028,_16086),
    cc(å,_16086,_16108),
    {user:testmember(_15872,[avoid,choose,consider,deny,end,expect,forget,hate,hope,learn,like,manage,need,postpone,promise,propose,reach,recommend,refuse,remember,resist,risk,seem,slip,start,think,try,use2,want,wish,wonder])},
    !,
    accept(_16124,_16108,_16139),
    pushstack(first,(npgap(_15873),aux1),nil,_16139,_16219),clausal_object1(_15995:coevent,_15878::_15882,_16148,_16219,_16030),
    {user:tv_template(_15872,_15873,_15995:coevent,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},_16066,_16095,lit(om),_16150,_16184,_16213,!,_16242,_16266,{},_16320,{},{}],_16030,_16032) --> 
    {user:testmember(_15872,[answer,answer1,say])},
    reflexiv0(_15872,_16066,_16030,_16083),
    optional([på],_16095,_16083,_16127),
    cc(om,_16127,_16149),
    np1_accept(_15948,_15949,_16150,_16149,_16169),
    negation0(_15951,_16184,_16169,_16201),
    look_ahead_vp(_16213,_16201,_16228),
    !,
    accept(_16242,_16228,_16257),
    lexv(_15953,_15954,_15955,fin,_16266,_16257,_16289),
    {user:test(rv_templ(_15872,_15963))},
    pushstack(first,(xnp(_15948,_15949),w(verb(_15954,_15955,fin)),negation0(_15951)),nil,_16289,_16397),clausal_object1(_15982:coevent,_15878::_15882,_16320,_16397,_16032),
    {user:tv_template(_15872,_15873,_15982:coevent,_15875,_15926)},
    {user:negate(_15874,_15926,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15876,[rvpk,{},lit(om),_16015,_16054,!,_16088],_15968,_15970) --> 
    {user:testmember(_15872,[ask,worry,tell])},
    cc(om,_15968,_16014),
    np_kernel(0,_15903,_15904,_16015,_16014,_16036),
    look_ahead([som],_16054,_16036,_16071),
    !,
    pushstack(first,(w(verb(_15872,pres,fin)),w(prep(about)),np_kernel(0,_15903,_15904)),nil,_16071,_16130),
    do_phrase(_15872,_15873,_15874,_15875,_15876,_16088,_16130,_15970).

rvpk(_15872,_15873,id,_15875,_15878::_15881 and _15882,[rvpk,{},lit(om),_16004,{}],_15957,_15959) --> 
    {user:testmember(_15872,[ask,check,discuss,know,know1,see])},
    cc(om,_15957,_16003),
    clausal_object1(_15926:coevent,_15878::_15882,_16004,_16003,_15959),
    {user:tv_template(_15872,_15873,_15926:coevent,_15875,_15881)}.

rvpk(_15872,_15873,_15874,_15875,_15876,[rvpk,{},lit(om),_16006,!,_16045],_15959,_15961) --> 
    {user:testmember(_15872,[ask,worry,tell])},
    cc(om,_15959,_16005),
    np1_accept(_15899,_15900,_16006,_16005,_16025),
    !,
    pushstack(first,(w(verb(_15872,pres,fin)),w(prep(about)),xnp(_15899,_15900)),nil,_16025,_16086),
    do_phrase(_15872,_15873,_15874,_15875,_15876,_16045,_16086,_15961).

rvpk(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[rvpk,{},_16023,_16052,_16081,{},!,_16125,_16149,{}],_15987,_15989) --> 
    {user:testmember(_15872,[believe,clculate,know,know1,mean,tell,say])},
    negation0(_15874,_16023,_15987,_16040),
    reflexiv0(_15872,_16052,_16040,_16069),
    not_look_ahead([om],_16081,_16069,_16098),
    {user:test(rv_templ(_15872,_15948))},
    !,
    accept(_16125,_16098,_16140),
    clausal_object0(_15956:_15957,_15878::_15882,_16149,_16140,_15989),
    {user:tv_template(_15872,_15873,_15956:_15957,_15875,_15881)}.

clausal_object0(_15872,_15873,[clausal_object0,_15930,_15959,!,_15998],_15913,_15915) --> 
    look_ahead(w(nb(_15888,_15889)),_15930,_15913,_15947),
    obviousdate(_15872,_15873,_15959,_15947,_15978),
    !,
    accept(_15998,_15978,_15915).

clausal_object0(_15872,_15873,[clausal_object0,_15932,_15961,_15995],_15915,_15917) --> 
    not_look_ahead(w(nb(_15890,_15891)),_15932,_15915,_15949),
    np(_15881,_15882,_15961,_15949,_15980),
    cond_vp(_15881,_15882,_15872,_15873,_15995,_15980,_15917).

cond_vp(_15872,_15873,_15874,_15875,[cond_vp,_15954,{},_15993,!],_15931,_15933) --> 
    look_ahead([_15887],_15954,_15931,_15971),
    {user:testmember(_15887,[du,jeg])},
    lock(last,_15971,_16044),pushstack(last,xnp(_15872,_15873),nil,_16044,_16050),clausal_object1(_15874,_15875,_15993,_16050,_16039),unlock(_16039,_15933),
    !.

cond_vp(_15872,_15873,_15874,_15875,[cond_vp,_15945,_15974,_15998,!],_15922,_15924) --> 
    not_look_ahead([så],_15945,_15922,_15962),
    look_ahead_vp(_15974,_15962,_15989),
    pushstack(first,xnp(_15872,_15873),nil,_15989,_16042),clausal_object1(_15874,_15875,_15998,_16042,_15924),
    !.

cond_vp(_15872,_15873,_15872,_15873,[cond_vp,[]],_15900,_15900) --> 
    [].

clausal_object1(_15887:coevent,_15875::exists(_15887:coevent)::_15887 isa coevent and event/_15887/_15899 and _15885,[clausal_object1,_15946],_15929,_15931) --> 
    substatem(_15899,_15875::_15885,_15946,_15929,_15931).

clausal_object2(_15887:coevent,_15875::exists(_15887:coevent)::_15887 isa coevent and event/_15887/_15899 and _15885,[clausal_object2,_15946],_15929,_15931) --> 
    sostatem(_15899,_15875::_15885,_15946,_15929,_15931).

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_16010,{},_16069,_16103,_16147,{},_16231,_16270],_15984,_15986) --> 
    hlexv(dtv,_15872,_15907,_15908,_15902,_16010,_15984,_16035),
    {user:testmember(_15872,[allow,let])},
    ind_object(_15920,_15921,_16069,_16035,_16088),
    optional([å],_16103,_16088,_16135),
    pushstack(first,(xnp(_15920,_15921),[vil]),nil,_16135,_16191),clausal_object1(_15935,_15938::_15879,_16147,_16191,_16206),
    {user:tv_template(_15872,_15873,_15935,_15875,_15950)},
    someevent00(_15875,_15950,_15878::_15938,_16231,_16206,_16252),
    negation2(_15902,_15874,_16270,_16252,_15986).

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15881 and _15882,[vp_kernel,_16052,_16096,_16125,_16154,_16183,_16212,_16246,_16275,{},_16314,{},_16358,_16402],_16026,_16028) --> 
    lexv(dtv,_15872,_15929,fin,_16052,_16026,_16075),
    not_look_ahead(w(adj2(_15936,nil)),_16096,_16075,_16113),
    not_look_ahead(w(nb(_15943,_15944)),_16125,_16113,_16142),
    not_look_ahead_lit([en,et,den,det,han,hun,vi],_16154,_16142,_16171),
    negation0(_15962,_16183,_16171,_16200),
    ind_object(_15964,_15925::_15881,_16212,_16200,_16231),
    negation0(_15970,_16246,_16231,_16263),
    not_look_ahead([så],_16275,_16263,_16292),
    {user:bigno(_15962,_15970,_15874)},
    object(_15982,_15925::_15882,_16314,_16292,_16333),
    {user:dtv_template(_15872,_15873,_15964,_15982,_15875,_15921)},
    optional([til],_16358,_16333,_16390),
    someevent00(_15875,_15921,_15878::_15925,_16402,_16390,_16028).

vp_kernel(notify,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_15989,_16038,!,_16072,_16096,{},_16162],_15963,_15965) --> 
    hlexv(tv,notify,_15908,_15909,_15874,_15989,_15963,_16014),
    look_ahead(w(nb(_15916,_15917)),_16038,_16014,_16055),
    !,
    accept(_16072,_16055,_16087),
    lock(exact,_16087,_16116),pushstack(exact,[meg],nil,_16116,_16122),np0_accept(_15924,_15904::_15879,_16096,_16122,_16111),unlock(_16111,_16112),
    {user:tv_template(notify,_15873,_15924,_15875,_15900)},
    someevent00(_15875,_15900,_15878::_15904,_16162,_16112,_15965).

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_15995,_16044,_16068,_16107,!,_16151,{},_16185,[]],_15969,_15971) --> 
    lexvaccept(tv,_15872,_15914,fin,_15874,_15995,_15969,_16020),
    redundant0(_16044,_16020,_16059),
    adverbx(_15908,_15909,_15910,_16068,_16059,_16089),
    object2(_15873,_15923,_15926::_15879,_16107,_16089,_16128),
    !,
    accept(_16151,_16128,_16166),
    {user:tv_template(_15872,_15873,_15923,_15875,_15935)},
    someevent00(_15875,_15935,_15878::_15926,_16185,_16166,_16206),
    pushstack(free,adverbx(_15908,_15909,_15910),nil,_16206,_15971),
    [].

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_16040,_16089,_16118,{},{},{},{},{},!,_16212,{},_16246],_16014,_16016) --> 
    hlexv(tv,_15872,_15923,_15924,_15874,_16040,_16014,_16065),
    not_look_ahead_lit([om,hver],_16089,_16065,_16106),
    object2(_15873,_15934,_15919::_15879,_16118,_16106,_16139),
    {user:(\+constrain(_15934,date);_15872==have)},
    {user:(\+constrain(_15934,distance))},
    {user:(\+constrain(_15934,minute))},
    {user:(\+constrain(_15934,hour))},
    {user:(\+constrain(_15934,clock))},
    !,
    accept(_16212,_16139,_16227),
    {user:tv_template(_15872,_15873,_15934,_15875,_15915)},
    someevent00(_15875,_15915,_15878::_15919,_16246,_16227,_16016).

vp_kernel(_15872,_15873,_15874,_15875,_15876,[vp_kernel,_15984,_16033,{},{},!,_16092,_16116,_16140,_16169],_15958,_15960) --> 
    hlexv(iv,_15872,_15908,fin,_15874,_15984,_15958,_16009),
    gmem(_15872,[run,pass],_16033,_16009,_16052),
    {user:iv_template(_15872,_15873,_15875,_15903)},
    {user:_15908\==imp},
    !,
    redundants0(_16092,_16052,_16107),
    it0(_16116,_16107,_16131),
    reflexiv0(_15872,_16140,_16131,_16157),
    someevent00(_15875,_15903,_15876,_16169,_16157,_15960).

vp_kernel(have,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_16027,_16056,_16080,{},_16119,lit(om),_16159,!,_16193,{},_16246],_16001,_16003) --> 
    negation0(_15918,_16027,_16001,_16044),
    has(_16056,_16044,_16071),
    negation0(_15920,_16080,_16071,_16097),
    {user:bigno(_15918,_15920,_15874)},
    w(noun(information,sin,u,n),_16119,_16097,_16136),
    cc(om,_16136,_16158),
    not_look_ahead_lit([når,å,at],_16159,_16158,_16176),
    !,
    pushstack(first,(w(noun(information,sin,u,n)),w(prep(regarding))),nil,_16176,_16206),np1(_15955,_15916::_15879,_16193,_16206,_16221),
    {user:tv_template(have,_15873,_15955,_15875,_15912)},
    someevent00(_15875,_15912,_15878::_15916,_16246,_16221,_16003).

vp_kernel(have,_15873,_15874,_15875,_15876,[vp_kernel,_15972,_16001,_16025,{},!,_16069],_15946,_15948) --> 
    negation0(_15874,_15972,_15946,_15989),
    has(_16001,_15989,_16016),
    w(adj2(_15898,nil),_16025,_16016,_16042),
    {user:testmember(_15898,[open,closed])},
    !,
    pushstack(first,w(adj2(_15898,nil)),nil,_16042,_16079),
    be_complement(_15873,_15875,_15876,_16069,_16079,_15948).

vp_kernel(have,_15873,_15874,_15875,_15876,[vp_kernel,_15972,lit(det),_16007,_16036,_16065,!,_16114],_15946,_15948) --> 
    has(_15972,_15946,_15987),
    cc(det,_15987,_16006),
    negation0(_15874,_16007,_16006,_16024),
    w(adj2(_15901,nil),_16036,_16024,_16053),
    optional([da],_16065,_16053,_16097),
    !,
    pushstack(first,w(adj2(_15901,nil)),nil,_16097,_16124),
    be_complement(_15873,_15875,_15876,_16114,_16124,_15948).

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_16041,_16070,_16099,_16148,{},{},_16197,_16226,_16255,_16279,!,_16323,{},_16357,_16396],_16015,_16017) --> 
    not_look_ahead(w(verb(have,_15931,_15932)),_16041,_16015,_16058),
    not_look_ahead(w(verb(be2,_15939,_15940)),_16070,_16058,_16087),
    hlexv(tv,_15872,_15944,_15945,_15923,_16099,_16087,_16124),
    not_look_ahead(w(prep(_15952)),_16148,_16124,_16165),
    {user:_15872\==have},
    {user:_15872\==be2},
    reflexiv0(_15872,_16197,_16165,_16214),
    particle0(_15872,_16226,_16214,_16243),
    redundant0(_16255,_16243,_16270),
    object2(_15873,_15969,_15972::_15879,_16279,_16270,_16300),
    !,
    accept(_16323,_16300,_16338),
    {user:tv_template(_15872,_15873,_15969,_15875,_15981)},
    someevent00(_15875,_15981,_15878::_15972,_16357,_16338,_16378),
    negation2(_15923,_15874,_16396,_16378,_16017).

menbare([menbare,lit(men)],_15889,_15891) --> 
    cc(men,_15889,_15891).

menbare([menbare,lit(bare)],_15889,_15891) --> 
    cc(bare,_15889,_15891).

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_16051,_16080,_16109,{},{},{},_16188,_16227,_16256,{},_16305,_16344,[]],_16025,_16027) --> 
    not_look_ahead(w(verb(have,_15928,_15929)),_16051,_16025,_16068),
    not_look_ahead(w(verb(be2,_15936,_15937)),_16080,_16068,_16097),
    hlexv(tv,_15872,_15941,_15942,_15943,_16109,_16097,_16134),
    {user:_15872\==have},
    {user:_15872\==be2},
    {user:(\+verbtype(_15872,iv))},
    adverb(_15920,_15921,pre,_16188,_16134,_16209),
    not_look_ahead(w(noun(night,_15971,_15972,_15973)),_16227,_16209,_16244),
    object2(_15873,_15976,_15979::_15879,_16256,_16244,_16277),
    {user:tv_template(_15872,_15873,_15976,_15875,_15988)},
    someevent00(_15875,_15988,_15878::_15979,_16305,_16277,_16326),
    negation2(_15943,_15874,_16344,_16326,_16363),
    pushstack(free,xadverb(_15920,_15921),nil,_16363,_16027),
    [].

vp_kernel(be1,_15873,_15874,_15875,_15876,[vp_kernel,_15981,_16005,_16034,{},{},_16083,[]],_15955,_15957) --> 
    be(_15981,_15955,_15996),
    negation0(_15874,_16005,_15996,_16022),
    look_ahead(w(noun(_15909,_15910,_15911,_15912)),_16034,_16022,_16051),
    {user:subclass0(_15909,time)},
    {user:iv_template(be1,_15873,_15875,_15924)},
    someevent00(_15875,_15924,_15876,_16083,_16051,_16104),
    pushstack(free,w(prep(on)),nil,_16104,_15957),
    [].

vp_kernel(be1,_15873,id,_15875,_15876,[vp_kernel,_15983,{},_16017,{},{},_16066,[]],_15957,_15959) --> 
    be(_15983,_15957,_15998),
    {user:vartypeid(_15873,self)},
    look_ahead(w(name(_15912,n,_15914)),_16017,_15998,_16034),
    {user:subclass0(_15914,place)},
    {user:iv_template(be1,_15873,_15875,_15926)},
    someevent00(_15875,_15926,_15876,_16066,_16034,_16087),
    pushstack(free,w(prep(in)),nil,_16087,_15959),
    [].

vp_kernel(be1,_15873,_15874,_15875,_15876,[vp_kernel,_15957,_15981,_16010,{},_16044,_16068],_15931,_15933) --> 
    be(_15957,_15931,_15972),
    negation0(_15874,_15981,_15972,_15998),
    not_look_ahead_np(_16010,_15998,_16025),
    {user:iv_template(be1,_15873,_15875,_15894)},
    redundant0(_16044,_16025,_16059),
    someevent00(_15875,_15894,_15876,_16068,_16059,_15933).

vp_kernel(be1,_15873,_15874,_15875,_15876,[vp_kernel,_15977,_16001,_16030,{},!,{},_16084],_15951,_15953) --> 
    be(_15977,_15951,_15992),
    negation0(_15874,_16001,_15992,_16018),
    look_ahead(w(adv(_15906)),_16030,_16018,_16047),
    {user:testmember(_15906,[redundantly,inside,outside])},
    !,
    {user:iv_template(be1,_15873,_15875,_15897)},
    someevent00(_15875,_15897,_15876,_16084,_16047,_15953).

vp_kernel(be1,_15873,_15874,_15875,_15876,[vp_kernel,_15975,_15999,_16028,{},{},_16077,_16101],_15949,_15951) --> 
    be(_15975,_15949,_15990),
    negation0(_15874,_15999,_15990,_16016),
    look_ahead([_15903],_16028,_16016,_16045),
    {user:testmember(_15903,[her,der,overalt])},
    {user:iv_template(be1,_15873,_15875,_15897)},
    redundant0(_16077,_16045,_16092),
    someevent00(_15875,_15897,_15876,_16101,_16092,_15951).

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_16021,{},_16060,_16089,_16123,_16152,_16176,_16205,{},_16254,_16293,!,_16332],_15995,_15997) --> 
    w(verb(_15919,_15920,fin),_16021,_15995,_16038),
    {user:testmember(_15919,[have])},
    negation0(_15930,_16060,_16038,_16077),
    particlev2(_15919,_15872,_16089,_16077,_16108),
    reflexiv0(_15872,_16123,_16108,_16140),
    redundant0(_16152,_16140,_16167),
    not_look_ahead(w(verb(_15941,past,part)),_16176,_16167,_16193),
    object2(_15873,_15946,_15949::_15879,_16205,_16193,_16226),
    {user:tv_template(_15872,_15873,_15946,_15875,_15958)},
    someevent00(_15875,_15958,_15878::_15949,_16254,_16226,_16275),
    negation2(_15930,_15874,_16293,_16275,_16312),
    !,
    accept(_16332,_16312,_15997).

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_16032,{},!,_16091,_16120,_16169,_16198,_16222,{},_16271,!,_16315,[]],_16006,_16008) --> 
    lexv(tv,_15872,_15934,_15935,_16032,_16006,_16055),
    {user:testmember(_15872,[lay])},
    !,
    negation0(_15874,_16091,_16055,_16108),
    verb_mod1(_15872,_15924,_15875,_15926,_15929::_15930,_16120,_16108,_16145),
    particle(_15872,_16169,_16145,_16186),
    redundant0(_16198,_16186,_16213),
    object2(_15873,_15958,_15961::_15879,_16222,_16213,_16243),
    {user:tv_template(_15872,_15873,_15958,_15875,_15970)},
    someevent00(_15875,_15970,_15878::_15961,_16271,_16243,_16292),
    !,
    accept(_16315,_16292,_16330),
    pushstack(free,(particle(_15872),verb_mod1(_15872,_15924,_15875,_15926,_15929::_15930)),nil,_16330,_16008),
    [].

vp_kernel(evah,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_15971,_16015,_16044,{},_16093],_15945,_15947) --> 
    lexv(tv,evah,_15902,fin,_15971,_15945,_15994),
    negation0(_15874,_16015,_15994,_16032),
    subject2(_15873,_15908,_15911::_15894,_16044,_16032,_16065),
    {user:has_template(_15908,_15873,_15911)},
    someevent00(_15875,_15894,_15878::_15879,_16093,_16065,_15947).

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15879,[vp_kernel,_16000,{},_16059,{},_16098,_16122,{},_16171,_16210],_15974,_15976) --> 
    hlexv(tv,_15872,_15910,_15911,_15905,_16000,_15974,_16025),
    {user:_15872==be2},
    reflexiv0(_15872,_16059,_16025,_16076),
    {user:compliancetest2(tv,_15872,_15873)},
    redundant0(_16098,_16076,_16113),
    object2(_15873,_15928,_15931::_15879,_16122,_16113,_16143),
    {user:tv_template(_15872,_15873,_15928,_15875,_15940)},
    someevent00(_15875,_15940,_15878::_15931,_16171,_16143,_16192),
    negation2(_15905,_15874,_16210,_16192,_15976).

vp_kernel(_15872,_15873,_15874,_15875,_15876,[vp_kernel,_15971,{},{},_16040,_16064,_16088,_16117],_15945,_15947) --> 
    hlexv(iv,_15872,_15902,fin,_15874,_15971,_15945,_15996),
    {user:iv_template(_15872,_15873,_15875,_15897)},
    {user:_15902\==imp},
    redundants0(_16040,_15996,_16055),
    it0(_16064,_16055,_16079),
    reflexiv0(_15872,_16088,_16079,_16105),
    someevent00(_15875,_15897,_15876,_16117,_16105,_15947).

vp_kernel(_15872,_15873,_15874,_15875,_15878::_15879,[vp_kernel,{},_16023,lit(_15920),{},_16073,!,_16107,_16175,_16209],_15987,_15989) --> 
    {user:constrain(_15873,person)},
    not_look_ahead([kan],_16023,_15987,_16040),
    cc(_15920,_16040,_16062),
    {user:testmember(_15920,[må,skal,vil])},
    not_look_ahead(w(verb(_15938,_15939,_15940)),_16073,_16062,_16090),
    !,
    pushstack(first,w(verb(arrive,pres,fin)),nil,_16090,_16120),intrans_verb(_15872,_15873,_15953,_15875,_15906,_15956,_15957,_16107,_16120,_16145),
    negation2(_15953,_15874,_16175,_16145,_16194),
    someevent00(_15875,_15906,_15878::_15879,_16209,_16194,_15989).

worldcomp(_15872,_15873,event/_15872/_15873::_15875,_15875,[worldcomp,[]],_15909,_15909) --> 
    [].

realcomp(_15872,event/real/_15872::_15874,_15874,[realcomp,[]],_15906,_15906) --> 
    [].

someevent00(_15872,_15873,_15876::exists(_15872:event)::_15873 and _15876,[someevent00,[]],_15911,_15911) --> 
    [].

thatto0(_15872,that,_15874,[thatto0,_15928,!,[]],_15908,_15910) --> 
    infinitive(_15928,_15908,_15943),
    !,
    pushstack(free,npgap(_15874),nil,_15943,_15910),
    [].

thatto0(_15872,_15873,_15874,[thatto0,_15927,!,_15961],_15907,_15909) --> 
    w(prep(on),_15927,_15907,_15944),
    !,
    reject(_15961,_15944,_15909).

thatto0(_15872,_15873,_15874,[thatto0,lit(om),_15947,!,_15981],_15916,_15918) --> 
    cc(om,_15916,_15946),
    look_ahead(w(name(_15891,_15892,_15893)),_15947,_15946,_15964),
    !,
    reject(_15981,_15964,_15918).

thatto0(_15872,_15873,_15874,[thatto0,lit(om),_15948,!,_15982],_15917,_15919) --> 
    cc(om,_15917,_15947),
    look_ahead(w(noun(departure,_15892,_15893,n)),_15948,_15947,_15965),
    !,
    reject(_15982,_15965,_15919).

that0(_15872,that,[that0,lit(på),!,_15935],_15902,_15904) --> 
    cc(på,_15902,_15929),
    !,
    reject(_15935,_15929,_15904).

that0(_15872,when,[that0,_15976,lit(når),_16021,_16050,!,_16089,[],!,_16163],_15959,_15961) --> 
    gmem(_15872,[know,know1,think,ask,notify,tell],_15976,_15959,_15995),
    cc(når,_15995,_16020),
    w(verb(_15918,_15919,fin),_16021,_16020,_16038),
    np1(_15922,_15923,_16050,_16038,_16069),
    !,
    accept(_16089,_16069,_16104),
    pushstack(free,(xnp(_15922,_15923),w(verb(_15918,_15919,fin))),nil,_16104,_16157),[],
    !,
    accept(_16163,_16157,_15961).

that0(ask,that,[that0,_15919],_15902,_15904) --> 
    look_ahead(w(verb(_15879,inf,_15881)),_15919,_15902,_15904).

that0(answer,whether,[that0,_15916,lit(om)],_15899,_15901) --> 
    on0(_15916,_15899,_15931),
    cc(om,_15931,_15901).

that0(ask,that,[that0,lit(om),_15933,!,_15962],_15905,_15907) --> 
    cc(om,_15905,_15932),
    infinitive(_15933,_15932,_15948),
    !,
    accept(_15962,_15948,_15907).

that0(ask,whether,[that0,lit(om),!,_15935],_15902,_15904) --> 
    cc(om,_15902,_15929),
    !,
    accept(_15935,_15929,_15904).

that0(ask,that,[that0,_15917,!,_15946],_15900,_15902) --> 
    infinitive(_15917,_15900,_15932),
    !,
    accept(_15946,_15932,_15902).

that0(believe,that,[that0,lit(at),!],_15899,_15901) --> 
    cc(at,_15899,_15901),
    !.

that0(believe,that,[that0,[]],_15894,_15894) --> 
    [].

that0(know,whether,[that0,lit(om),!],_15899,_15901) --> 
    cc(om,_15899,_15901),
    !.

that0(know,that,[that0,lit(at),!],_15899,_15901) --> 
    cc(at,_15899,_15901),
    !.

that0(know,that,[that0,_15927,_15956],_15910,_15912) --> 
    not_look_ahead([en],_15927,_15910,_15944),
    not_look_ahead(w(noun(_15882,_15883,_15884,_15885)),_15956,_15944,_15912).

that0(know1,whether,[that0,lit(om),!],_15899,_15901) --> 
    cc(om,_15899,_15901),
    !.

that0(know1,that,[that0,lit(at),!],_15899,_15901) --> 
    cc(at,_15899,_15901),
    !.

that0(know1,that,[that0,_15927,_15956],_15910,_15912) --> 
    not_look_ahead([en],_15927,_15910,_15944),
    not_look_ahead(w(noun(_15882,_15883,_15884,_15885)),_15956,_15944,_15912).

that0(let,that,[that0,[]],_15894,_15894) --> 
    [].

that0(mean,that,[that0,lit(at),!],_15899,_15901) --> 
    cc(at,_15899,_15901),
    !.

that0(mean,that,[that0,[]],_15894,_15894) --> 
    [].

that0(notify,that,[that0,lit(at)],_15896,_15898) --> 
    cc(at,_15896,_15898).

that0(notify,that,[that0,lit(om),lit(at),!,_15951],_15907,_15909) --> 
    cc(om,_15907,_15934),
    cc(at,_15934,_15945),
    !,
    accept(_15951,_15945,_15909).

that0(notify,_15873,[that0,lit(om),!,_15935],_15902,_15904) --> 
    cc(om,_15902,_15929),
    !,
    reject(_15935,_15929,_15904).

that0(say,that,[that0,lit(at),!],_15899,_15901) --> 
    cc(at,_15899,_15901),
    !.

that0(say,that,[that0,[]],_15894,_15894) --> 
    [].

that0(tell,that,[that0,_15921,!,_15955],_15904,_15906) --> 
    look_ahead([et],_15921,_15904,_15938),
    !,
    reject(_15955,_15938,_15906).

that0(tell,that,[that0,_15921,!,_15955],_15904,_15906) --> 
    look_ahead([en],_15921,_15904,_15938),
    !,
    reject(_15955,_15938,_15906).

that0(tell,that,[that0,lit(at),!],_15899,_15901) --> 
    cc(at,_15899,_15901),
    !.

that0(think,that,[that0,lit(at),!],_15899,_15901) --> 
    cc(at,_15899,_15901),
    !.

that0(think,that,[that0,[]],_15894,_15894) --> 
    [].

that0(understand,how,[that0,lit(hvordan)],_15896,_15898) --> 
    cc(hvordan,_15896,_15898).

that0(want,that,[that0,lit(at),!],_15899,_15901) --> 
    cc(at,_15899,_15901),
    !.

that0(want,to,[that0,lit(og)],_15896,_15898) --> 
    cc(og,_15896,_15898).

that0(wish,that,[that0,_15919],_15902,_15904) --> 
    look_ahead(w(verb(_15879,_15880,_15881)),_15919,_15902,_15904).

that0(_15872,_15873,[that0,_15931,!,_15965,_15994],_15914,_15916) --> 
    that(_15873,_15931,_15914,_15948),
    !,
    not_look_ahead(w(noun(departure,_15891,_15892,_15893)),_15965,_15948,_15982),
    accept(_15994,_15982,_15916).

rep_modifiers0(_15872,_15873,_15874,_15875,_15876,[rep_modifiers0,lit(hvor),!,_15953],_15911,_15913) --> 
    cc(hvor,_15911,_15947),
    !,
    reject(_15953,_15947,_15913).

rep_modifiers0(_15872,_15873,_15874,_15875,_15876,[rep_modifiers0,lit(hva),!,_15953],_15911,_15913) --> 
    cc(hva,_15911,_15947),
    !,
    reject(_15953,_15947,_15913).

rep_modifiers0(_15872,_15873,_15874,_15875,_15876,[rep_modifiers0,{},_15974,{},_16013],_15938,_15940) --> 
    {user:testmember(_15872,[see])},
    look_ahead(w(prep(_15904)),_15974,_15938,_15991),
    {user:testmember(_15904,[in])},
    verb_modifier(_15872,_15873,_15874,_15875,_15876,_16013,_15991,_15940).

rep_modifiers0(_15872,_15873,_15874,_15875,_15876,[rep_modifiers0,{},_15967,_15996],_15931,_15933) --> 
    {user:testmember(_15872,[say,tell])},
    prep1(to,_15967,_15931,_15984),
    pushstack(first,prep(to),nil,_15984,_16036),
    verb_modifiers(_15872,_15873,_15874,_15875,_15876,_15996,_16036,_15933).

rep_modifiers0(_15872,_15873,_15874,_15875,_15875,[rep_modifiers0,[]],_15903,_15903) --> 
    [].

be_complements(_15872,_15873,_15876::_15879 and _15880,[be_complements,lit(at),_15971,!,_16005,_16029,{}],_15940,_15942) --> 
    cc(at,_15940,_15970),
    look_ahead(w(prep(_15911)),_15971,_15970,_15988),
    !,
    preadverbials(_16005,_15988,_16020),
    clausal_object2(_15900,_15876::_15880,_16029,_16020,_15942),
    {user:bealign(_15872,_15900,_15873,_15880,_15879)}.

be_complements(_15872,_15873,_15876::_15879 and _15880,[be_complements,lit(at),!,_15967,_15991,{}],_15931,_15933) --> 
    cc(at,_15931,_15961),
    !,
    accept(_15967,_15961,_15982),
    clausal_object1(_15897,_15876::_15880,_15991,_15982,_15933),
    {user:bealign(_15872,_15897,_15873,_15880,_15879)}.

be_complements(_15872,_15873,_15876::_15879 and _15880,[be_complements,lit(å),!,_15970,_15994,{}],_15934,_15936) --> 
    cc(å,_15934,_15964),
    !,
    accept(_15970,_15964,_15985),
    pushstack(first,someone,nil,_15985,_16035),clausal_object1(_15897,_15876::_15880,_15994,_16035,_15936),
    {user:bealign(_15872,_15897,_15873,_15880,_15879)}.

be_complements(_15872,_15873,_15874,[be_complements,_15935,_15974],_15915,_15917) --> 
    be_complement(_15872,_15873,_15888::_15889,_15935,_15915,_15956),
    be_complements20(_15872,_15873,_15888::_15889,_15874,_15974,_15956,_15917).

be_complements20(_15872,_15873,_15877::_15880,_15877::_15880 or _15881,[be_complements20,lit(eller),_15981,!,_16015,_16054],_15947,_15949) --> 
    cc(eller,_15947,_15980),
    not_look_ahead_lit(['.',?],_15981,_15980,_15998),
    !,
    be_complement(_15872,_15873,_15877::_15919,_16015,_15998,_16036),
    be_complements20(_15872,_15873,_15877::_15919,_15877::_15881,_16054,_16036,_15949).

be_complements20(_15872,_15873,_15877::_15880,_15877::_15880 and _15881,[be_complements20,_15950,_15974,_16013],_15927,_15929) --> 
    be_compl_conjunction(_15950,_15927,_15965),
    be_pred(_15872,_15873,_15894,_15974,_15965,_15995),
    be_complements20(_15872,_15873,_15894,_15877::_15881,_16013,_15995,_15929).

be_complements20(_15872,_15873,_15874,_15874,[be_complements20,_15923],_15900,_15902) --> 
    redundant0(_15923,_15900,_15902).

be_compl_conjunction([be_compl_conjunction,lit(og),!],_15892,_15894) --> 
    cc(og,_15892,_15894),
    !.

be_compl_conjunction([be_compl_conjunction,lit(men),_15925,!],_15903,_15905) --> 
    cc(men,_15903,_15924),
    look_ahead(w(verb(_15884,past,part)),_15925,_15924,_15905),
    !.

be_complement(_15872,_15873,_15874,[be_complement,_15930,_15959],_15910,_15912) --> 
    not_look_ahead_lit([der,her],_15930,_15910,_15947),
    be_pred(_15872,_15873,_15874,_15959,_15947,_15912).

be_complement(_15872,_15873,_15874,[be_complement,_15930,_15959],_15910,_15912) --> 
    not_look_ahead_lit([der,her],_15930,_15910,_15947),
    be_noun(_15872,_15873,_15874,_15959,_15947,_15912).

be_pred(_15872,_15873,_15874,[be_pred,_15954,{},_16008,_16032],_15934,_15936) --> 
    ap(_15891,_15872,_15873,_15888,_15954,_15934,_15977),
    {user:(\+testmember(_15891,[true,whole]))},
    not_look_ahead_nounx(_16008,_15977,_16023),
    verb_modifiers0(adj/nil/_15891,_15872,_15873,_15888,_15874,_16032,_16023,_15936).

be_pred(_15872,_15873,_15874,[be_pred,_15941,_15970,{}],_15921,_15923) --> 
    look_ahead(w(prep(_15892)),_15941,_15921,_15958),
    verb_mod1(be1,_15872,_15873,_15884,_15885,_15970,_15958,_15923),
    {user:thenwhat(_15884,_15885,_15874)}.

be_pred(_15872,_15873,_15874,[be_pred,_16008,_16037,_16066,{},_16105,_16171],_15988,_15990) --> 
    w(nb(_15909,num),_16008,_15988,_16025),
    w(noun(percent,_15903,u,n),_16037,_16025,_16054),
    w(adj2(_15921,nil),_16066,_16054,_16083),
    {user:testmember(_15921,[certain,safe])},
    lock(exact,_16083,_16125),pushstack(exact,w(adj2(_15921,nil)),nil,_16125,_16131),ap(_15921,_15872,_15873,_15944,_16105,_16131,_16120),unlock(_16120,_16121),
    pushstack(first,(w(prep(with)),w(nb(_15909,num)),w(noun(percent,_15903,u,n))),nil,_16121,_16181),
    verb_modifiers0(adj/nil/_15921,_15872,_15873,_15944,_15874,_16171,_16181,_15990).

be_pred(_15872,_15873,_15874,[be_pred,_16001,_16025,_16049,!,_16083,{},_16122,_16188],_15981,_15983) --> 
    ofte0(_16001,_15981,_16016),
    mangenoen(_16025,_16016,_16040),
    w(noun(minute,_15913,u,n),_16049,_16040,_16066),
    !,
    w(adj2(_15919,nil),_16083,_16066,_16100),
    {user:testmember(_15919,[delayed,tooearly])},
    lock(exact,_16100,_16142),pushstack(exact,w(adj2(_15919,nil)),nil,_16142,_16148),ap(_15919,_15872,_15873,_15942,_16122,_16148,_16137),unlock(_16137,_16138),
    pushstack(first,(w(prep(with)),w(noun(minute,plu,u,n))),nil,_16138,_16198),
    verb_modifiers0(adj/nil/_15919,_15872,_15873,_15942,_15874,_16188,_16198,_15983).

ofte0([ofte0,lit(ofte)],_15889,_15891) --> 
    cc(ofte,_15889,_15891).

ofte0([ofte0,[]],_15887,_15887) --> 
    [].

mangenoen([mangenoen,lit(mange)],_15889,_15891) --> 
    cc(mange,_15889,_15891).

mangenoen([mangenoen,lit(flere)],_15889,_15891) --> 
    cc(flere,_15889,_15891).

mangenoen([mangenoen,lit(noen)],_15889,_15891) --> 
    cc(noen,_15889,_15891).

be_pred(_15872,_15873,_15874,[be_pred,_16008,_16037,_16066,{},_16105,_16171],_15988,_15990) --> 
    w(nb(_15909,num),_16008,_15988,_16025),
    w(noun(minute,_15903,u,n),_16037,_16025,_16054),
    w(adj2(_15921,nil),_16066,_16054,_16083),
    {user:testmember(_15921,[delayed,tooearly])},
    lock(exact,_16083,_16125),pushstack(exact,w(adj2(_15921,nil)),nil,_16125,_16131),ap(_15921,_15872,_15873,_15944,_16105,_16131,_16120),unlock(_16120,_16121),
    pushstack(first,(w(prep(with)),w(nb(_15909,num)),w(noun(minute,_15903,u,n))),nil,_16121,_16181),
    verb_modifiers0(adj/nil/_15921,_15872,_15873,_15944,_15874,_16171,_16181,_15990).

be_pred(_15872,_15873,_15874,[be_pred,lit(mer),_15968,_15997,_16063],_15937,_15939) --> 
    cc(mer,_15937,_15967),
    look_ahead([enn],_15968,_15967,_15985),
    lock(exact,_15985,_16017),pushstack(exact,w(adj2(great,nil)),nil,_16017,_16023),ap(_15905,_15872,_15873,_15888,_15997,_16023,_16012),unlock(_16012,_16013),
    verb_modifiers0(adj/nil/_15905,_15872,_15873,_15888,_15874,_16063,_16013,_15939).

be_pred(_15872,_15873,_15876::_15877,[be_pred,_15927],_15907,_15909) --> 
    passive(_15872,_15873,_15876::_15877,_15927,_15907,_15909).

be_pred(_15872,_15873,_15874,[be_pred,_15928,_15967],_15908,_15910) --> 
    comparisons(_15872,_15873,_15880,_15928,_15908,_15949),
    someevent00(_15873,_15880,_15874,_15967,_15949,_15910).

be_pred(_15872,_15873,_15876::_15877,[be_pred,_15941,_15965],_15921,_15923) --> 
    sure(_15941,_15921,_15956),
    pushstack(first,w(verb(know,pres,fin)),nil,_15956,_15975),
    do_phrase(know,_15872,id,_15873,_15876::_15877,_15965,_15975,_15923).

be_pred(_15872,_15873,_15874,[be_pred,_15965,_16009,{},_16048],_15945,_15947) --> 
    ap(_15892,_15872,_15873,_15895,_15965,_15945,_15988),
    look_ahead([hva],_16009,_15988,_16026),
    {user:(\+testmember(_15892,[true,whole]))},
    pushstack(first,w(prep(on)),nil,_16026,_16058),
    verb_modifiers0(adj/nil/_15892,_15872,_15873,_15895,_15874,_16048,_16058,_15947).

fordent0(_15872,[fordent0,_15910,!],_15896,_15898) --> 
    gradverb(_15872,_15910,_15896,_15898),
    !.

fordent0(nil,[fordent0,_15905],_15891,_15893) --> 
    dent0(_15905,_15891,_15893).

not_look_ahead_nounx([not_look_ahead_nounx,_15910,!],_15899,_15901) --> 
    look_ahead(w(noun(clock,sin,def,n)),_15910,_15899,_15901),
    !.

not_look_ahead_nounx([not_look_ahead_nounx,_15907],_15896,_15898) --> 
    not_look_ahead(w(noun(_15876,_15877,_15878,_15879)),_15907,_15896,_15898).

be_noun(_15872,_15873,_15876::exists(_15873:event)::_15880,[be_noun,lit(at),_15964,{},!],_15933,_15935) --> 
    cc(at,_15933,_15963),
    clausal_object1(_15898,_15876::_15902,_15964,_15963,_15935),
    {user:bealign(_15872,_15898,_15873,_15902,_15880)},
    !.

be_noun(_15872,_15873,_15876::exists(_15873:event)::_15880,[be_noun,_15983,_16012,{},!,_16070],_15963,_15965) --> 
    look_ahead(w(nb(_15912,_15913)),_15983,_15963,_16000),
    pushstack(first,w(noun(clock,sin,def,n)),nil,_16000,_16025),obviousclock(_15925,_15928::_15929,_16012,_16025,_16040),
    {user:bealign(_15872,_15925,_15873,_15929,_15937)},
    !,
    verb_modifiers0(exist,_15872,_15873,_15928::_15937,_15876::_15880,_16070,_16040,_15965).

be_noun(_15872,_15873,_15876::exists(_15873:event)::_15880,[be_noun,_15973,_15997,{},_16041,!,_16090],_15953,_15955) --> 
    redundant0(_15973,_15953,_15988),
    object(_15911,_15914::_15915,_15997,_15988,_16016),
    {user:bealign(_15872,_15911,_15873,_15915,_15923)},
    optional([bare],_16041,_16016,_16073),
    !,
    verb_modifiers0(exist,_15872,_15873,_15914::_15923,_15876::_15880,_16090,_16073,_15955).

ap(_15872,_15873,_15874,_15875,[ap,_15941,_15965,_16009,_16033],_15918,_15920) --> 
    mthe10(_15941,_15918,_15956),
    adj1s(_15872,_15873,_15874,_15887,_15965,_15956,_15988),
    redundant0(_16009,_15988,_16024),
    someevent00(_15874,_15887,_15875,_16033,_16024,_15920).

ap(_15872,_15873,_15874,_15875,[ap,_15964,{},{},_16013],_15941,_15943) --> 
    w(verb(_15872,past,part),_15964,_15941,_15981),
    {user:(\+testmember(_15872,[be,have]))},
    {user:adj_template(nil,be/_15872,_15873,_15874,_15887)},
    someevent00(_15874,_15887,_15875,_16013,_15981,_15943).

mthe10([mthe10,lit(mye)],_15889,_15891) --> 
    cc(mye,_15889,_15891).

mthe10([mthe10,_15898],_15887,_15889) --> 
    the0(_15898,_15887,_15889).

passive(_15872,_15873,_15874,[passive,_16008,_16037,_16071,{},_16125,!,_16164],_15988,_15990) --> 
    w(noun(_15911,sin,u,n),_16008,_15988,_16025),
    gmem(_15911,[video,camera],_16037,_16025,_16056),
    lexv(tv,_15931,_15932,part,_16071,_16056,_16094),
    {user:(\+testmember(_15931,[be2,have]))},
    whodidit(_15946,_15947,_16125,_16094,_16144),
    !,
    pushstack(first,(np(_15946,_15947),w(verb(_15931,_15932,fin)),npgap(_15872),w(prep(by)),w(noun(_15911,sin,u,n))),nil,_16144,_16235),
    state(_15873,_15874,_16164,_16235,_15990).

passive(_15872,_15873,_15874,[passive,_15985,{},_16039,_16068,!,_16107],_15965,_15967) --> 
    lexv(dtv,_15903,past,part,_15985,_15965,_16008),
    {user:(\+testmember(_15903,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_15926,_15927)),_16039,_16008,_16056),
    whodidit(_15929,_15930,_16068,_16056,_16087),
    !,
    pushstack(first,(np(_15929,_15930),w(verb(_15903,past,fin)),npgap(_15872)),nil,_16087,_16178),
    state(_15873,_15874,_16107,_16178,_15967).

passive(_15872,_15873,_15874,[passive,_15997,{},_16051,_16080,_16114,!,_16153],_15977,_15979) --> 
    lexv(dtv,_15910,_15911,part,_15997,_15977,_16020),
    {user:(\+testmember(_15910,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_15933,_15934)),_16051,_16020,_16068),
    ind_object(_15906,_15907,_16080,_16068,_16099),
    whodidit(_15939,_15940,_16114,_16099,_16133),
    !,
    pushstack(free,(np(_15939,_15940),w(verb(_15910,_15911,fin)),npgap(_15872),noun_phrase1(_15906,_15907)),nil,_16133,_16255),
    state(_15873,_15874,_16153,_16255,_15979).

passive(_15872,_15873,_15876::_15877,[passive,_15975,lit(om),_16030,!,_16069],_15955,_15957) --> 
    lexv(tv,notify,past,part,_15975,_15955,_15998),
    cc(om,_15998,_16029),
    whodidit(_15912,_15913,_16030,_16029,_16049),
    !,
    lock(last,_16049,_16147),
    pushstack(last,(xnp(_15912,_15913),w(verb(notify,pres,fin)),w(prep(regarding)),npgap(_15872)),nil,_16147,_16153),
    state(_15873,_15876::_15877,_16069,_16153,_16142),
    unlock(_16142,_15957).

passive(_15872,_15873,_15874,[passive,_15988,!,_16032,{},_16086,!,_16125],_15968,_15970) --> 
    adverbial1(_15906,_15907,_15908,_15988,_15968,_16009),
    !,
    lexv(tv,_15915,_15916,part,_16032,_16009,_16055),
    {user:(\+testmember(_15915,[be2,have]))},
    whodidit(_15930,_15931,_16086,_16055,_16105),
    !,
    pushstack(first,(np(_15930,_15931),w(verb(_15915,_15916,fin)),npgap(_15872),adverbial1(_15906,_15907,_15908)),nil,_16105,_16228),
    state(_15873,_15874,_16125,_16228,_15970).

passive(_15872,_15873,_15874,[passive,_15980,{},_16034,_16068,_16092,!,_16131],_15960,_15962) --> 
    lexv(tv,_15906,_15907,part,_15980,_15960,_16003),
    {user:(\+testmember(_15906,[be2,have]))},
    particlev0(_15906,_15922,_16034,_16003,_16053),
    redundant0(_16068,_16053,_16083),
    whodidit(_15924,_15925,_16092,_16083,_16111),
    !,
    pushstack(first,(np(_15924,_15925),w(verb(_15922,_15907,fin)),npgap(_15872)),nil,_16111,_16202),
    state(_15873,_15874,_16131,_16202,_15962).

passive(_15872,_15873,_15874,[passive,_16019,{},_16073,lit(og),_16108,{},!,_16172,!,_16211],_15999,_16001) --> 
    lexv(tv,_15921,past,part,_16019,_15999,_16042),
    {user:(\+testmember(_15921,[be2,have]))},
    redundant0(_16073,_16042,_16088),
    cc(og,_16088,_16107),
    hlexv(tv,_15939,past,part,id,_16108,_16107,_16133),
    {user:(\+testmember(_15921,[be2,have]))},
    !,
    whodidit(_15955,_15956,_16172,_16133,_16191),
    !,
    pushstack(first,(np(_15955,_15956),w(verb(_15921,past,fin)),[og],w(verb(_15939,past,fin)),npgap(_15872)),nil,_16191,_16282),
    state(_15873,_15874,_16211,_16282,_16001).

whodidit(_15872,_15873,[whodidit,lit(av),lit(at),_15952,!,_15991],_15913,_15915) --> 
    cc(av,_15913,_15940),
    cc(at,_15940,_15951),
    clausal_object1(_15872,_15873,_15952,_15951,_15971),
    !,
    accept(_15991,_15971,_15915).

whodidit(_15872,_15873,[whodidit,_15920,!,_15949],_15903,_15905) --> 
    by(_15920,_15903,_15935),
    !,
    np(_15872,_15873,_15949,_15935,_15905).

whodidit(_15872,_15873,[whodidit,_15930,!,_15991],_15913,_15915) --> 
    lock(exact,_15913,_15950),pushstack(exact,w(noun(agent,sin,u,n)),nil,_15950,_15956),np1(_15872,_15873,_15930,_15956,_15945),unlock(_15945,_15946),
    !,
    accept(_15991,_15946,_15915).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15980,lit(det),lit(å),_16046,_16089,!,_16128],_15957,_15959) --> 
    lexv(tv,_15905,_15906,fin,_15980,_15957,_16003),
    cc(det,_16003,_16034),
    cc(å,_16034,_16045),
    pushstack(first,[noen],nil,_16045,_16059),clausal_object1(_15918,_15902,_16046,_16059,_16074),
    traceprint(4,qv0a,_16089,_16074,_16108),
    !,
    pushstack(first,(lexv(tv,_15905,_15906,fin),xnp(_15872,_15902)),nil,_16108,_16202),
    verb_phrase(_15918,_15873,_15874,_15875,_16128,_16202,_15959).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16035,{},{},_16099,_16133,_16162,_16191,{},_16235,_16264,_16288,!,_16327],_16012,_16014) --> 
    lexv(tv,_15931,_15932,fin,_16035,_16012,_16058),
    {user:_15931\==ask},
    {user:_15931\==have},
    subject(_15945,_15946,_16099,_16058,_16118),
    negation0(_15873,_16133,_16118,_16150),
    not_look_ahead([om],_16162,_16150,_16179),
    object(_15954,_15955,_16191,_16179,_16210),
    {user:subject_object_test(_15931,_15945,_15954)},
    w(prep(_15965),_16235,_16210,_16252),
    not_look_ahead_np(_16264,_16252,_16279),
    traceprint(4,qv0b,_16288,_16279,_16307),
    !,
    pushstack(first,(xnp(_15945,_15946),w(verb(_15931,pres,fin)),xnp(_15954,_15955),w(prep(_15965)),npgap(_15872)),nil,_16307,_16429),
    state(_15874,_15875,_16327,_16429,_16014).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16015,{},_16069,_16103,_16132,_16161,_16185,!,_16224,{},_16258],_15992,_15994) --> 
    lexv(iv,_15922,_15923,fin,_16015,_15992,_16038),
    {user:(\+testmember(_15922,[think]))},
    subject(_15935,_15936,_16069,_16038,_16088),
    negation0(_15873,_16103,_16088,_16120),
    w(prep(_15942),_16132,_16120,_16149),
    not_look_ahead_np(_16161,_16149,_16176),
    traceprint(4,qv1,_16185,_16176,_16204),
    !,
    accept(_16224,_16204,_16239),
    {user:adjustprepv(_15922,_15942,_15951)},
    pushstack(first,(xnp(_15935,_15936),w(verb(_15922,_15923,fin)),w(prep(_15951)),npgap(_15872)),nil,_16239,_16329),
    state(_15874,_15875,_16258,_16329,_15994).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15995,_16039,_16073,_16097,[],_16171,!,_16210],_15972,_15974) --> 
    lexv(rv,_15914,pres,fin,_15995,_15972,_16018),
    subject(_15918,_15919,_16039,_16018,_16058),
    infinitive(_16073,_16058,_16088),
    w(verb(do,inf,fin),_16097,_16088,_16114),
    pushstack(free,xnp(_15872,_15919),nil,_16114,_16170),[],
    traceprint(4,qv2,_16171,_16170,_16190),
    !,
    pushstack(first,(w(verb(_15914,pres,fin)),[å],w(verb(do,inf,fin))),nil,_16190,_16220),
    verb_phrase(_15918,_15873,_15874,_15875,_16210,_16220,_15974).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15994,_16038,_16072,_16106,_16130,!,[],_16214],_15971,_15973) --> 
    lexv(dtv,_15913,_15914,fin,_15994,_15971,_16017),
    subject(_15917,_15918,_16038,_16017,_16057),
    ind_object(_15920,_15921,_16072,_16057,_16091),
    omaa(_16106,_16091,_16121),
    traceprint(4,qv3,_16130,_16121,_16149),
    !,
    pushstack(free,xnp(_15872,_15918),nil,_16149,_16213),[],
    pushstack(first,(w(verb(_15913,_15914,fin)),xnp(_15920,_15921),[om],[å]),nil,_16213,_16255),
    verb_phrase(_15917,_15873,_15874,_15875,_16214,_16255,_15973).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15996,{},{},_16060,_16094,{},_16138,!,_16177],_15973,_15975) --> 
    lexv(tv,_15911,_15912,fin,_15996,_15973,_16019),
    {user:_15911\==ask},
    {user:_15911\==have},
    subject(_15925,_15908,_16060,_16019,_16079),
    particlev0(_15911,_15929,_16094,_16079,_16113),
    {user:subject_object_test(_15911,_15925,_15872)},
    traceprint(4,qv4,_16138,_16113,_16157),
    !,
    pushstack(first,(lexv(tv,_15929,_15912,fin),xnp(_15872,_15908)),nil,_16157,_16251),
    verb_phrase(_15925,_15873,_15874,_15875,_16177,_16251,_15975).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16010,_16034,_16063,_16097,_16141,{},{},_16190,!,_16229,{}],_15987,_15989) --> 
    aux1(_16010,_15987,_16025),
    negation0(_15909,_16034,_16025,_16051),
    subject(_15915,_15916,_16063,_16051,_16082),
    lexv(tv,_15919,inf,fin,_16097,_16082,_16120),
    not_look_ahead([om],_16141,_16120,_16158),
    {user:_15919\==have},
    {user:test(tv_template(_15919,_15915,_15872,_15874,_15940))},
    traceprint(4,qv5,_16190,_16158,_16209),
    !,
    pushstack(first,(lexv(tv,_15919,pres,fin),xnp(_15872,_15916)),nil,_16209,_16304),verb_phrase(_15915,_15910,_15874,_15875,_16229,_16304,_15989),
    {user:bigno(_15909,_15910,_15873)}.

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16000,_16024,_16058,_16087,_16116,_16145,!,_16184],_15977,_15979) --> 
    aux1(_16000,_15977,_16015),
    subject(_15913,_15911,_16024,_16015,_16043),
    w(verb(be,inf,fin),_16058,_16043,_16075),
    w(adj2(_15924,_15925),_16087,_16075,_16104),
    w(prep(_15929),_16116,_16104,_16133),
    traceprint(4,qv6,_16145,_16133,_16164),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_15924,_15925)),w(prep(_15929)),xnp(_15872,_15911)),nil,_16164,_16225),
    verb_phrase(_15913,_15873,_15874,_15875,_16184,_16225,_15979).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15979,lit(du),_16014,_16043,_16072,!,_16111],_15956,_15958) --> 
    has(_15979,_15956,_15994),
    cc(du,_15994,_16013),
    negation0(_15873,_16014,_16013,_16031),
    prepnom(_15909,_16043,_16031,_16060),
    traceprint(4,qv7,_16072,_16060,_16091),
    !,
    pushstack(first,([du],w(verb(have,pres,fin)),npgap(_15872),w(prep(_15909))),nil,_16091,_16151),
    state(_15874,_15875,_16111,_16151,_15958).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16000,_16024,_16058,_16087,_16116,!,_16155],_15977,_15979) --> 
    has(_16000,_15977,_16015),
    np1_accept(_15913,_15910::_15911,_16024,_16015,_16043),
    w(noun(_15921,_15922,_15923,n),_16058,_16043,_16075),
    prepnom(_15926,_16087,_16075,_16104),
    traceprint(4,qv8,_16116,_16104,_16135),
    !,
    pushstack(free,(w(verb(have,pres,fin)),w(noun(_15921,sin,u,n)),w(prep(_15926)),noun_phrase1(_15872,_15910::_15911)),nil,_16135,_16199),
    do_phrase(have,_15913,_15873,_15874,_15875,_16155,_16199,_15979).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16000,_16024,_16058,_16087,{},_16126,_16165,!,_16204],_15977,_15979) --> 
    has(_16000,_15977,_16015),
    subject(_15915,_15916,_16024,_16015,_16043),
    negation0(_15873,_16058,_16043,_16075),
    w(verb(_15922,_15923,part),_16087,_16075,_16104),
    {user:testmember(_15922,[go])},
    defaultprep(_15922,_15872,_15935,_16126,_16104,_16147),
    traceprint(4,qv9,_16165,_16147,_16184),
    !,
    pushstack(first,(xnp(_15915,_15916),w(verb(_15922,_15923,fin)),prep1(_15935),npgap(_15872)),nil,_16184,_16306),
    state(_15874,_15875,_16204,_16306,_15979).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15978,_16002,_16036,_16065,_16094,!,_16133],_15955,_15957) --> 
    has(_15978,_15955,_15993),
    subject(_15906,_15907,_16002,_15993,_16021),
    negation0(_15873,_16036,_16021,_16053),
    w(verb(_15913,past,part),_16065,_16053,_16082),
    traceprint(4,qv10,_16094,_16082,_16113),
    !,
    pushstack(first,(xnp(_15906,_15907),w(verb(_15913,past,fin)),npgap(_15872)),nil,_16113,_16204),
    state(_15874,_15875,_16133,_16204,_15957).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15975,_15999,_16033,_16062,_16091,!,_16130],_15952,_15954) --> 
    has(_15975,_15952,_15990),
    np1_accept(_15907,_15908,_15999,_15990,_16018),
    negation0(_15873,_16033,_16018,_16050),
    w(verb(_15903,_15904,part),_16062,_16050,_16079),
    traceprint(4,qv11,_16091,_16079,_16110),
    !,
    pushstack(first,(xnp(_15907,_15908),w(verb(_15903,_15904,fin))),nil,_16110,_16171),
    verb_phrase(_15872,id,_15874,_15875,_16130,_16171,_15954).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,lit(kan),_15992,_16026,_16060,_16089,!,_16128],_15958,_15960) --> 
    cc(kan,_15958,_15991),
    subject(_15906,_15902,_15992,_15991,_16011),
    negation2(id,_15873,_16026,_16011,_16045),
    not_look_ahead(w(verb(_15916,_15917,_15918)),_16060,_16045,_16077),
    traceprint(4,qv12,_16089,_16077,_16108),
    !,
    lock(last,_16108,_16176),
    pushstack(last,(w(verb(know1,pres,fin)),xnp(_15872,_15902)),nil,_16176,_16182),
    do_phrase(_15923,_15906,id,_15874,_15875,_16128,_16182,_16171),
    unlock(_16171,_15960).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15997,_16026,_16060,_16094,_16123,_16152,!,_16191],_15974,_15976) --> 
    w(verb(_15911,_15912,fin),_15997,_15974,_16014),
    gmem(_15911,[talk,speak],_16026,_16014,_16045),
    subject(_15922,_15923,_16060,_16045,_16079),
    negation0(_15873,_16094,_16079,_16111),
    look_ahead(w(prep(_15931)),_16123,_16111,_16140),
    traceprint(4,qv13a,_16152,_16140,_16171),
    !,
    lock(last,_16171,_16269),
    pushstack(last,(xnp(_15872,_15923),w(verb(_15911,_15912,fin)),negation(_15873)),nil,_16269,_16275),
    do_phrase(_15936,_15922,id,_15874,_15875,_16191,_16275,_16264),
    unlock(_16264,_15976).

qverb_phrase(_15872,id,_15874,_15875,[qverb_phrase,_15973,_15997,_16031,_16060,!,_16099],_15950,_15952) --> 
    aux1(_15973,_15950,_15988),
    subject(_15903,_15904,_15997,_15988,_16016),
    w(verb(be,_15909,fin),_16031,_16016,_16048),
    traceprint(4,qv15c,_16060,_16048,_16079),
    !,
    pushstack(first,(xnp(_15903,_15904),w(verb(be,pres,fin)),npgap(_15872)),nil,_16079,_16170),
    state(_15874,_15875,_16099,_16170,_15952).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15959,_15983,_16017,_16051,!,_16090],_15936,_15938) --> 
    docan(_15959,_15936,_15974),
    subject(_15898,_15896,_15983,_15974,_16002),
    negation2(id,_15873,_16017,_16002,_16036),
    traceprint(4,qv13b,_16051,_16036,_16070),
    !,
    lock(last,_16070,_16138),
    pushstack(last,xnp(_15872,_15896),nil,_16138,_16144),
    do_phrase(_15907,_15898,id,_15874,_15875,_16090,_16144,_16133),
    unlock(_16133,_15938).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,{},_16003,_16027,_16061,lit(av),_16101,!,_16140],_15970,_15972) --> 
    {user:constrain(_15872,place)},
    aux1(_16003,_15970,_16018),
    np1_accept(_15917,_15920::_15921,_16027,_16018,_16046),
    negation0(_15873,_16061,_16046,_16078),
    cc(av,_16078,_16100),
    traceprint(4,qv14,_16101,_16100,_16120),
    !,
    pushstack(first,(noun_phrase1(_15917,_15920::_15921),w(verb(go,pres,fin)),[av],npgap(_15872)),nil,_16120,_16214),
    state(_15874,_15875,_16140,_16214,_15972).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16008,_16037,_16061,_16095,_16124,_16153,_16182,!,_16221],_15985,_15987) --> 
    w(verb(be,pres,_15922),_16008,_15985,_16025),
    thereit0(_16037,_16025,_16052),
    np1_accept(_15924,_15927::_15928,_16061,_16052,_16080),
    negation0(_15873,_16095,_16080,_16112),
    w(verb(_15934,_15935,part),_16124,_16112,_16141),
    prep(_15938,_16153,_16141,_16170),
    traceprint(4,qv15,_16182,_16170,_16201),
    !,
    pushstack(first,(someone,w(verb(_15934,_15935,fin)),noun_phrase1(_15924,_15927::_15928),w(prep(_15938)),npgap(_15872)),nil,_16201,_16323),
    state(_15874,_15875,_16221,_16323,_15987).

qverb_phrase(_15872,id,_15874,_15875,[qverb_phrase,_16000,_16029,_16063,_16092,_16121,!,_16160],_15977,_15979) --> 
    w(verb(be,_15915,fin),_16000,_15977,_16017),
    subject(_15918,_15919,_16029,_16017,_16048),
    w(adj2(_15923,nil),_16063,_16048,_16080),
    w(prep(_15928),_16092,_16080,_16109),
    traceprint(4,qv15a,_16121,_16109,_16140),
    !,
    pushstack(first,(xnp(_15918,_15919),w(verb(be,pres,fin)),w(adj2(_15923,nil)),w(prep(_15928)),npgap(_15872)),nil,_16140,_16231),
    state(_15874,_15875,_16160,_16231,_15979).

qverb_phrase(_15872,id,_15874,_15875,[qverb_phrase,_15970,_15999,_16033,!,_16072],_15947,_15949) --> 
    w(verb(be,_15903,fin),_15970,_15947,_15987),
    subject(_15906,_15907,_15999,_15987,_16018),
    traceprint(4,qv15b,_16033,_16018,_16052),
    !,
    pushstack(first,(xnp(_15906,_15907),w(verb(be,pres,fin)),npgap(_15872)),nil,_16052,_16143),
    state(_15874,_15875,_16072,_16143,_15949).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15999,_16028,_16052,_16086,_16115,_16144,{},_16178,!,_16217],_15976,_15978) --> 
    w(verb(be,_15921,fin),_15999,_15976,_16016),
    thereit0(_16028,_16016,_16043),
    np1_accept(_15924,_15925,_16052,_16043,_16071),
    negation0(_15873,_16086,_16071,_16103),
    prep(_15929,_16115,_16103,_16132),
    not_look_ahead_np(_16144,_16132,_16159),
    {user:_15929\==towards},
    traceprint(4,qv16,_16178,_16159,_16197),
    !,
    pushstack(first,(xnp(_15924,_15925),w(verb(be1,pres,fin)),prep(_15929),npgap(_15872)),nil,_16197,_16318),
    state(_15874,_15875,_16217,_16318,_15978).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16062,{},_16116,_16150,_16179,_16213,_16242,_16266,!,{},{},_16325],_16039,_16041) --> 
    lexv(tv,_15928,_15929,fin,_16062,_16039,_16085),
    {user:(\+testmember(_15928,[pass,be1,be,be2,cost,have,know1]))},
    np1_accept(_15953,_15956::_15957,_16116,_16085,_16135),
    negation0(_15873,_16150,_16135,_16167),
    np1_accept(_15872,_15964::_15965,_16179,_16167,_16198),
    prep1(_15967,_16213,_16198,_16230),
    endofline(_16242,_16230,_16257),
    traceprint(4,qv17,_16266,_16257,_16285),
    !,
    {user:(\+testmember(_15967,[off,of]))},
    {user:test(verb_compl(_15928,_15967,_15953,_15872,_15991,_15992))},
    pushstack(first,(noun_phrase1(_15953,_15956::_15957),lexv(tv,_15928,_15929,fin),noun_phrase1(_15872,_15964::_15965),prep1(_15967),npgap(_15872)),nil,_16285,_16496),
    state(_15874,_15875,_16325,_16496,_16041).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16070,_16099,_16128,{},{},_16192,_16216,_16250,_16279,{},{},_16338,_16362,!,_16401],_16047,_16049) --> 
    not_look_ahead([kan],_16070,_16047,_16087),
    not_look_ahead(w(verb(be,_15942,_15943)),_16099,_16087,_16116),
    lexv(_15945,_15946,_15947,fin,_16128,_16116,_16151),
    {user:(_15945==iv;_15945==rv)},
    {user:(\+testmember(_15946,[pass]))},
    thereit0(_16192,_16151,_16207),
    np1_accept(_15970,_15973::_15974,_16216,_16207,_16235),
    negation0(_15873,_16250,_16235,_16267),
    defaultprep(_15946,_15872,_15980,_16279,_16267,_16300),
    {user:(\+testmember(_15980,[off,of]))},
    {user:test(verb_compl(_15946,_15980,_15970,_15872,_16001,_16002))},
    qtrailer0(_16338,_16300,_16353),
    traceprint(4,qv18,_16362,_16353,_16381),
    !,
    pushstack(first,(noun_phrase1(_15970,_15973::_15974),w(verb(_15946,_15947,fin)),prep1(_15980),npgap(_15872)),nil,_16381,_16505),
    state(_15874,_15875,_16401,_16505,_16049).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,{},_16034,{},_16073,_16102,_16136,_16165,_16204,!,_16243],_16001,_16003) --> 
    {user:constrain(_15872,place)},
    w(verb(_15925,_15926,fin),_16034,_16001,_16051),
    {user:(\+testmember(_15925,[be,take,pass]))},
    not_look_ahead([det],_16073,_16051,_16090),
    np1_accept(_15946,_15949::_15950,_16102,_16090,_16121),
    negation0(_15873,_16136,_16121,_16153),
    defaultprep(_15925,_15872,_15956,_16165,_16153,_16186),
    traceprint(4,qv19,_16204,_16186,_16223),
    !,
    pushstack(first,(noun_phrase1(_15946,_15949:_15950),w(verb(_15925,pres,fin)),prep1(_15956),npgap(_15872)),nil,_16223,_16344),
    state(_15874,_15875,_16243,_16344,_16003).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16024,{},_16078,_16112,{},_16151,{},_16190,!,_16229],_16001,_16003) --> 
    lexv(iv,_15919,_15920,fin,_16024,_16001,_16047),
    {user:_15919\==be1},
    np1_accept(_15928,_15931::_15932,_16078,_16047,_16097),
    negation0(_15873,_16112,_16097,_16129),
    {user:constrain(_15928,vehicle)},
    prep1(_15941,_16151,_16129,_16168),
    {user:testmember(_15941,[to,from,past,by,on])},
    traceprint(4,qv20,_16190,_16168,_16209),
    !,
    pushstack(first,(noun_phrase1(_15928,_15931::_15932),w(verb(_15919,pres,fin)),prep1(_15941),npgap(_15872)),nil,_16209,_16333),
    state(_15874,_15875,_16229,_16333,_16003).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15974,_15998,_16032,_16076,!,_16115],_15951,_15953) --> 
    do(_15974,_15951,_15989),
    noun_phrase1(_15904,_15901::_15902,_15998,_15989,_16017),
    lexv(_15910,know1,_15912,fin,_16032,_16017,_16055),
    traceprint(4,qv21,_16076,_16055,_16095),
    !,
    pushstack(first,(lexv(_15910,know1,_15912,fin),np(_15872,_15901::_15902)),nil,_16095,_16190),
    verb_phrase(_15904,_15873,_15874,_15875,_16115,_16190,_15953).

qverb_phrase(_15872,_15873,_15874,_15877::_15878,[qverb_phrase,_15968,_15992,_16026,_16050,!,_16089],_15945,_15947) --> 
    use(_15968,_15945,_15983),
    noun_phrase1(_15903,_15906::_15878,_15992,_15983,_16011),
    in_order_to(_16026,_16011,_16041),
    traceprint(4,qv22,_16050,_16041,_16069),
    !,
    pushstack(free,(prep(with),npgap(_15872)),nil,_16069,_16159),
    verb_phrase(_15903,_15873,_15874,_15877::_15906,_16089,_16159,_15947).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15967,_15991,_16020,_16049,!,_16088],_15944,_15946) --> 
    be(_15967,_15944,_15982),
    thereit2(be,_15991,_15982,_16008),
    not_look_ahead(w(noun(_15907,_15908,u,_15910)),_16020,_16008,_16037),
    traceprint(4,qv23,_16049,_16037,_16068),
    !,
    pushstack(first,w(verb(exist,pres,fin)),nil,_16068,_16098),
    verb_phrase1(exist,_15872,_15873,_15874,_15875,_16088,_16098,_15946).

qverb_phrase(_15872,id,_15874,_15875,[qverb_phrase,{},_16005,{},_16059,{},_16103,!,_16142],_15972,_15974) --> 
    {user:constrain(_15872,route)},
    lexv(iv,_15915,_15916,fin,_16005,_15972,_16028),
    {user:testmember(_15915,[go])},
    subject(_15926,_15927,_16059,_16028,_16078),
    {user:constrain(_15926,vehicle)},
    traceprint(4,qv24,_16103,_16078,_16122),
    !,
    lock(last,_16122,_16220),
    pushstack(last,(xnp(_15926,_15927),w(verb(_15915,_15916,fin)),npgap(_15872)),nil,_16220,_16226),
    state(_15874,_15875,_16142,_16226,_16215),
    unlock(_16215,_15974).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15983,_16027,{},_16071,_16100,!,_16139],_15960,_15962) --> 
    lexv(tv,_15905,_15906,fin,_15983,_15960,_16006),
    subject(_15909,_15902,_16027,_16006,_16046),
    {user:subject_object_test(_15905,_15909,_15872)},
    not_look_ahead(w(prep(_15922)),_16071,_16046,_16088),
    traceprint(4,qv25,_16100,_16088,_16119),
    !,
    pushstack(first,(lexv(tv,_15905,_15906,fin),xnp(_15872,_15902)),nil,_16119,_16213),
    verb_phrase(_15909,_15873,_15874,_15875,_16139,_16213,_15962).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15948,_15977,!,_16016],_15925,_15927) --> 
    look_ahead(w(verb(be,_15896,fin)),_15948,_15925,_15965),
    traceprint(4,qv26,_15977,_15965,_15996),
    !,
    verb_phrase(_15872,_15873,_15874,_15875,_16016,_15996,_15927).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15967,{},_16006,_16035,!,_16074],_15944,_15946) --> 
    not_look_ahead(w(verb(be,_15902,fin)),_15967,_15944,_15984),
    {user:vartypeid(_15872,thing)},
    look_ahead(w(verb(_15914,_15915,fin)),_16006,_15984,_16023),
    traceprint(4,qv27,_16035,_16023,_16054),
    !,
    verb_phrase(_15872,_15873,_15874,_15875,_16074,_16054,_15946).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15978,lit(du),_16018,_16042,_16076,lit(kan),_16121,!,_16160],_15955,_15957) --> 
    w(verb(believe,pres,fin),_15978,_15955,_15995),
    cc(du,_15995,_16017),
    that0(_16018,_16017,_16033),
    noun_phrase1(_15915,_15905,_16042,_16033,_16061),
    negation2(id,_15873,_16076,_16061,_16095),
    cc(kan,_16095,_16120),
    traceprint(4,qv28,_16121,_16120,_16140),
    !,
    pushstack(free,xnp(_15872,_15905),nil,_16140,_16201),
    do_phrase(believe,_15915,id,_15874,_15875,_16160,_16201,_15957).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15962,_15986,_16020,_16054,_16078,!,_16117],_15939,_15941) --> 
    do(_15962,_15939,_15977),
    noun_phrase1(_15901,_15899,_15986,_15977,_16005),
    negation2(id,_15873,_16020,_16005,_16039),
    redundant0x(_16054,_16039,_16069),
    traceprint(4,qv29,_16078,_16069,_16097),
    !,
    lock(last,_16097,_16165),
    pushstack(last,xnp(_15872,_15899),nil,_16165,_16171),
    do_phrase(_15910,_15901,id,_15874,_15875,_16117,_16171,_16160),
    unlock(_16160,_15941).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15997,{},_16051,_16075,_16109,_16133,_16162,!,_16201],_15974,_15976) --> 
    lexv(iv,_15914,_15915,fin,_15997,_15974,_16020),
    {user:(\+testmember(_15914,[know,know1,be1]))},
    thereit(_16051,_16020,_16066),
    noun_phrase1(_15931,_15911,_16075,_16066,_16094),
    adverbx0(_16109,_16094,_16124),
    prep0(_15934,_16133,_16124,_16150),
    traceprint(4,qv30,_16162,_16150,_16181),
    !,
    pushstack(first,(lexv(iv,_15914,_15915,fin),prep(_15934),xnp(_15872,_15911)),nil,_16181,_16305),
    verb_phrase(_15931,_15873,_15874,_15875,_16201,_16305,_15976).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15985,_16009,_16043,_16087,_16111,_16155,!,_16194],_15962,_15964) --> 
    has(_15985,_15962,_16000),
    np1_accept(_15910,_15907::_15908,_16009,_16000,_16028),
    lexv(rv,_15917,past,part,_16043,_16028,_16066),
    infinitive(_16087,_16066,_16102),
    lexv(tv,_15922,inf,fin,_16111,_16102,_16134),
    traceprint(4,qv31,_16155,_16134,_16174),
    !,
    pushstack(first,(lexv(tv,_15922,pres,fin),np(_15872,_15907::_15908)),nil,_16174,_16271),
    verb_phrase(_15910,_15873,_15874,_15875,_16194,_16271,_15964).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15974,_15998,_16032,_16076,!,_16115],_15951,_15953) --> 
    has(_15974,_15951,_15989),
    np1_accept(_15904,_15901::_15902,_15998,_15989,_16017),
    lexv(tv,_15911,past,part,_16032,_16017,_16055),
    traceprint(4,qv32,_16076,_16055,_16095),
    !,
    pushstack(first,(lexv(tv,_15911,past,fin),np(_15872,_15901::_15902)),nil,_16095,_16190),
    verb_phrase(_15904,_15873,_15874,_15875,_16115,_16190,_15953).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15971,_15995,{},_16039,!,_16078],_15948,_15950) --> 
    has(_15971,_15948,_15986),
    np1_accept(_15901,_15899,_15995,_15986,_16014),
    {user:has_template(_15901,_15872,_15908)},
    traceprint(4,qv33,_16039,_16014,_16058),
    !,
    pushstack(free,(w(verb(have,pres,fin)),noun_phrase1(_15872,_15899)),nil,_16058,_16119),
    do_phrase(have,_15901,_15873,_15874,_15875,_16078,_16119,_15950).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16002,_16026,_16060,_16104,_16138,_16167,!,_16206],_15979,_15981) --> 
    has(_16002,_15979,_16017),
    np1_accept(_15916,_15913::_15914,_16026,_16017,_16045),
    lexv(tv,_15923,past,part,_16060,_16045,_16083),
    noun_phrase1(_15927,_15930::_15931,_16104,_16083,_16123),
    prep(_15933,_16138,_16123,_16155),
    traceprint(4,qv34,_16167,_16155,_16186),
    !,
    pushstack(first,(lexv(tv,_15923,past,fin),np(_15927,_15930::_15931),prep(_15933),np(_15872,_15913::_15914)),nil,_16186,_16347),
    verb_phrase(_15916,_15873,_15874,_15875,_16206,_16347,_15981).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15958,{},_15997,!,_16036],_15935,_15937) --> 
    not_look_ahead(w(verb(be,_15899,fin)),_15958,_15935,_15975),
    {user:(\+vartypeid(_15872,thing))},
    traceprint(4,qv35,_15997,_15975,_16016),
    !,
    verb_phrase(_15872,_15873,_15874,_15875,_16036,_16016,_15937).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,{},_15978,_16007,_16031,!,_16070],_15945,_15947) --> 
    {user:(\+vartypeid(_15872,thing))},
    w(verb(_15897,_15898,fin),_15978,_15945,_15995),
    thereit0(_16007,_15995,_16022),
    traceprint(4,qv36,_16031,_16022,_16050),
    !,
    pushstack(first,w(verb(_15897,_15898,fin)),nil,_16050,_16080),
    verb_phrase(_15872,_15873,_15874,_15875,_16070,_16080,_15947).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_15971,_16015,_16039,_16126,!,_16165],_15948,_15950) --> 
    lexv(_15901,_15902,_15903,fin,_15971,_15948,_15994),
    thereit(_16015,_15994,_16030),
    lock(exact,_16030,_16090),pushstack(exact,this,nil,_16090,_16096),npa(_15909,_15899,_16039,_16096,_16085),unlock(_16085,_16086),
    traceprint(4,qv37,_16126,_16086,_16145),
    !,
    pushstack(first,(lexv(_15901,_15902,_15903,fin),xnp(_15872,_15899)),nil,_16145,_16239),
    verb_phrase(_15909,_15873,_15874,_15875,_16165,_16239,_15950).

qverb_phrase(_15872,_15873,_15874,_15875,[qverb_phrase,_16020,{},_16074,_16108,_16137,_16176,!,_16215,_16239,_16278],_15997,_15999) --> 
    lexv(iv,_15922,_15923,fin,_16020,_15997,_16043),
    {user:(\+testmember(_15922,[think]))},
    np1_accept(_15935,_15936,_16074,_16043,_16093),
    negation0(_15873,_16108,_16093,_16125),
    adverbial1(_15940,_15941,_15944::_15945,_16137,_16125,_16158),
    traceprint(4,qv38,_16176,_16158,_16195),
    !,
    accept(_16215,_16195,_16230),
    defaultprep(_15922,_15872,_15952,_16239,_16230,_16260),
    pushstack(first,(xnp(_15935,_15936),lexv(iv,_15922,_15923,fin),adverbial1(_15940,_15941,_15944::_15945),prep1(_15952),npgap(_15872)),nil,_16260,_16447),
    state(_15874,_15875,_16278,_16447,_15999).

verb_modifiers0(_15872,_15873,_15874,_15875,_15876,[verb_modifiers0,lit(hva),!,_15953],_15911,_15913) --> 
    cc(hva,_15911,_15947),
    !,
    reject(_15953,_15947,_15913).

verb_modifiers0(_15872,_15873,_15874,_15875,_15876,[verb_modifiers0,_15935],_15909,_15911) --> 
    verb_modifiers(_15872,_15873,_15874,_15875,_15876,_15935,_15909,_15911).

verb_modifiers0(_15872,_15873,_15874,_15875,_15876,[verb_modifiers0,_15941,!,_15970],_15915,_15917) --> 
    redundant(_15941,_15915,_15956),
    !,
    verb_modifiers(_15872,_15873,_15874,_15875,_15876,_15970,_15956,_15917).

verb_modifiers0(_15872,_15873,_15874,_15875,_15875,[verb_modifiers0,{}],_15910,_15910) --> 
    {user:(\+_15872=be1)}.

verb_modifiers(_15872,_15873,_15874,_15875,_15876,[verb_modifiers,_15950,!,_16004,_16028],_15924,_15926) --> 
    verb_modifier(_15872,_15873,_15874,_15875,_15890,_15950,_15924,_15975),
    !,
    accept(_16004,_15975,_16019),
    verb_modifiers10(_15872,_15873,_15874,_15890,_15876,_16028,_16019,_15926).

verb_modifiers10(_15872,_15873,_15874,_15875,_15876,[verb_modifiers10,_15941,_15965,_15989],_15915,_15917) --> 
    vmod_conjunction(_15941,_15915,_15956),
    look_ahead_prepadv(_15965,_15956,_15980),
    verb_modifiers(_15872,_15873,_15874,_15875,_15876,_15989,_15980,_15917).

verb_modifiers10(go,_15873,_15874,_15875,_15876,[verb_modifiers10,_15961,_15985,!,_16019,_16043],_15935,_15937) --> 
    numberroute(_15961,_15935,_15976),
    look_ahead(w(nb(_15901,num)),_15985,_15976,_16002),
    !,
    accept(_16019,_16002,_16034),
    pushstack(first,w(prep(with)),nil,_16034,_16053),
    verb_modifiers(go,_15873,_15874,_15875,_15876,_16043,_16053,_15937).

verb_modifiers10(_15872,_15873,_15874,_15875,_15876,[verb_modifiers10,_15949,_15973,_16002],_15923,_15925) --> 
    point(_15949,_15923,_15964),
    look_ahead(w(name(_15894,_15895,_15896)),_15973,_15964,_15990),
    verb_modifiers0(_15872,_15873,_15874,_15875,_15876,_16002,_15990,_15925).

verb_modifiers10(_15872,_15873,_15874,_15875,_15876,[verb_modifiers10,_15935],_15909,_15911) --> 
    verb_modifiers0(_15872,_15873,_15874,_15875,_15876,_15935,_15909,_15911).

verb_modifiers10(_15872,_15873,_15874,_15875,_15875,[verb_modifiers10,[]],_15903,_15903) --> 
    [].

look_ahead_prepadv([look_ahead_prepadv,_15907,!],_15896,_15898) --> 
    look_ahead(w(prep(_15879)),_15907,_15896,_15898),
    !.

look_ahead_prepadv([look_ahead_prepadv,_15907,!],_15896,_15898) --> 
    look_ahead(w(adv(_15879)),_15907,_15896,_15898),
    !.

verb_modifier(_15872,_15873,_15874,_15884 and _15878::_15879,_15878::_15879,[verb_modifier,_15984,_16013,{},{}],_15958,_15960) --> 
    thisplace(_15907,_15984,_15958,_16001),
    not_look_ahead([jegdu],_16013,_16001,_15960),
    {user:verb_compl(_15872,_15907,_15873,_15922:place,_15874,_15905)},
    {user:_15884=(findexternal(_15922:place)::_15922 isa place and _15905)}.

verb_modifier(_15872,_15873,_15874,_15884 and _15878::_15882,_15878::_15879,[verb_modifier,_15947],_15921,_15923) --> 
    verb_mod1(_15872,_15873,_15874,_15884,_15882::_15879,_15947,_15921,_15923).

verb_modifier(_15872,_15873,_15874,_15884 and _15878::_15879,_15878::_15879,[verb_modifier,_15953,!,{}],_15927,_15929) --> 
    today(_15953,_15927,_15929),
    !,
    {user:adv_compl(_15872,today,_15873,time,_15874,_15884)}.

verb_modifier(_15872,_15873,_15874,_15875,_15875,[verb_modifier,_15937,!,_15971],_15911,_15913) --> 
    particlev1(_15872,_15937,_15911,_15954),
    !,
    accept(_15971,_15954,_15913).

verb_modifier(_15872,_15873,_15874,_15875,_15875,[verb_modifier,{},_15951],_15915,_15917) --> 
    {user:testmember(_15872,[want])},
    reflexiv(_15872,_15951,_15915,_15917).

verb_modifier(_15872,_15873,_15874,_15884 and _15878::_15882,_15878::_15879,[verb_modifier,{},_15982,_16026,{}],_15946,_15948) --> 
    {user:_15872\==be1},
    lexv(iv,_15911,pres,part,_15982,_15946,_16005),
    verb_modifier3(_15911,_15873,_15901,_15882,_15879,_16026,_16005,_15948),
    {user:verb_compl(_15872,during,_15873,_15901,_15874,_15884)}.

verb_modifier(_15872,_15873,_15874,_15878 and _15885::_15882,_15878::_15879,[verb_modifier,_15968,_15992,{}],_15942,_15944) --> 
    this(_15968,_15942,_15983),
    pushstack(first,(prep(in),this),nil,_15983,_16063),adverbial(_15896,_15898,_15882::_15879,_15992,_16063,_15944),
    {user:verb_compl(_15872,_15896,_15873,_15898,_15874,_15885)}.

verb_modifier(_15872,_15873,_15874,_15884 and _15878::_15879,_15878::_15879,[verb_modifier,_15954,{}],_15928,_15930) --> 
    partday(_15893,_15895,_15901,_15954,_15928,_15930),
    {user:adv_compl(_15872,_15893,_15873,_15895,_15874,_15884)}.

verb_modifier(_15872,_15873,_15874,_15884 and _15878::_15882,_15878::_15879,[verb_modifier,_15968,_15997,{},!,_16051],_15942,_15944) --> 
    nil_compl(_15872,_15968,_15942,_15985),
    adjunct1(nil,_15902,_15882::_15879,_15997,_15985,_16018),
    {user:verb_compl(_15872,nil,_15873,_15902,_15874,_15884)},
    !,
    accept(_16051,_16018,_15944).

verb_modifier(_15872,_15873,_15874,_15884 and _15878::_15882,_15878::_15879,[verb_modifier,_15968,_15997,{},!,_16051],_15942,_15944) --> 
    dir_compl(_15872,_15968,_15942,_15985),
    adjunct1(dir,_15902,_15882::_15879,_15997,_15985,_16018),
    {user:verb_compl(_15872,dir,_15873,_15902,_15874,_15884)},
    !,
    accept(_16051,_16018,_15944).

verb_modifier(adj/nil/_15882,_15873,_15874,_15890 and _15878::_15888,_15878::_15879,[verb_modifier,_15981,_16005,_16054,{}],_15955,_15957) --> 
    infinitive(_15981,_15955,_15996),
    subordinateinfnosubj(nil,coevent,_15873,_15907,_15915,_16005,_15996,_16030),
    determiner00(_15907,_15888,_15915::_15879,_16054,_16030,_15957),
    {user:verb_compl(adj/nil/_15882,in_order_to,_15873,_15907,_15874,_15890)}.

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,_15985,_16019,{},_16058,!,_16097,{}],_15959,_15961) --> 
    gmem(_15872,[be1,go,arrive,depart],_15985,_15959,_16004),
    w(prep(_15899),_16019,_16004,_16036),
    {user:testmember(_15899,[before,after,between])},
    plausibleclock(_15901,_15876,_16058,_16036,_16077),
    !,
    accept(_16097,_16077,_15961),
    {user:verb_compl(_15872,_15899,_15873,_15901,_15874,_15875)}.

verb_mod1(look,_15873,_15874,_15875,_15878::_15879,[verb_mod1,_15974,lit(ut),!,_16019,{}],_15948,_15950) --> 
    w(adj2(_15904,_15905),_15974,_15948,_15991),
    cc(ut,_15991,_16013),
    !,
    lock(exact,_16013,_16039),pushstack(exact,w(adv(_15904)),nil,_16039,_16045),adverbix(_15896,_15898,_15878::_15879,_16019,_16045,_16034),unlock(_16034,_15950),
    {user:verb_compl(look,_15896,_15873,_15898,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,_15976,_16010,{},!,_16054,{}],_15950,_15952) --> 
    gmem(_15872,[be1],_15976,_15950,_15995),
    w(prep(_15896),_16010,_15995,_16027),
    {user:(\+member(_15896,[between,for]))},
    !,
    np1_accept(_15898,_15876,_16054,_16027,_15952),
    {user:verb_compl(_15872,_15896,_15873,_15898,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,lit(som),_15970,!,_16004,{}],_15933,_15935) --> 
    cc(som,_15933,_15969),
    w(prep(in),_15970,_15969,_15987),
    !,
    np1_accept(_15895,_15876,_16004,_15987,_15935),
    {user:verb_compl(_15872,as_in,_15873,_15895,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,lit(som),!,_15968,{}],_15926,_15928) --> 
    cc(som,_15926,_15962),
    !,
    np1_accept(_15892,_15876,_15968,_15962,_15928),
    {user:verb_compl(_15872,as,_15873,_15892,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,_15989,_16023,{},_16062,!,_16096,{}],_15963,_15965) --> 
    gmem(_15872,[exist],_15989,_15963,_16008),
    one_of_lit([til,før],_16023,_16008,_16040),
    {user:(vartypeid(_15873,_15921),subclass0(_15921,duration))},
    not_look_ahead(w(name(_15931,n,place)),_16062,_16040,_16079),
    !,
    clausal_object0(_15901,_15876,_16096,_16079,_15965),
    {user:verb_compl(_15872,until,_15873,_15901,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,{},lit(_15911),{},{},!,_16032,{}],_15960,_15962) --> 
    {user:testmember(_15872,[exist])},
    cc(_15911,_15960,_16006),
    {user:testmember(_15911,[siden])},
    {user:(vartypeid(_15873,_15926),subclass0(_15926,duration))},
    !,
    clausal_object0(_15901,_15876,_16032,_16006,_15962),
    {user:verb_compl(_15872,since,_15873,_15901,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,{},lit(med),lit(at),!,_16004,{}],_15941,_15943) --> 
    {user:testmember(_15872,[mean])},
    cc(med,_15941,_15987),
    cc(at,_15987,_15998),
    !,
    clausal_object1(_15898,_15876,_16004,_15998,_15943),
    {user:verb_compl(_15872,with,_15873,_15898,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},_16001,_16030,!,_16064,{}],_15965,_15967) --> 
    {user:testmember(_15872,[ask])},
    not_look_ahead([nå],_16001,_15965,_16018),
    look_ahead(w(verb(_15920,inf,fin)),_16030,_16018,_16047),
    !,
    pushstack(first,(npgap(_15873),[vil]),nil,_16047,_16107),clausal_object1(_15901,_15878::_15879,_16064,_16107,_15967),
    {user:verb_compl(_15872,regarding,_15873,_15901,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,{},lit(om),_15992,!,_16026,{}],_15945,_15947) --> 
    {user:testmember(_15872,[notify,take])},
    cc(om,_15945,_15991),
    not_look_ahead([en],_15992,_15991,_16009),
    !,
    clausal_object0(_15898,_15876,_16026,_16009,_15947),
    {user:verb_compl(_15872,regarding,_15873,_15898,_15874,_15875)}.

verb_mod1(adj/nil/_15879,_15873,_15874,_15875,_15876,[verb_mod1,{},_15997,!,_16031,{}],_15961,_15963) --> 
    {user:testmember(_15879,[delayed])},
    w(nb(_15914,num),_15997,_15961,_16014),
    !,
    pushstack(first,(w(prep(with)),w(nb(_15914,num))),nil,_16014,_16044),pp(with,_15901,_15876,_16031,_16044,_15963),
    {user:adj_compl(_15879,with,_15873,_15901,_15874,_15875)}.

utenå([utenå,lit(uten),_15920,_15944,!],_15898,_15900) --> 
    cc(uten,_15898,_15919),
    ogå(_15920,_15919,_15935),
    måtte(_15944,_15935,_15900),
    !.

utenå([utenå,lit(uten),_15914],_15892,_15894) --> 
    cc(uten,_15892,_15913),
    ogå(_15914,_15913,_15894).

måtte([måtte,_15910],_15899,_15901) --> 
    one_of_lit([måtte,ville,skulle,burde,kunne],_15910,_15899,_15901).

verb_mod1(adj/nil/_15879,_15873,_15874,_15875,_15876,[verb_mod1,{},_15978,!,_16007,{}],_15942,_15944) --> 
    {user:testmember(_15879,[afraid,happy])},
    foratx0(_15978,_15942,_15993),
    !,
    clausal_object1(_15901,_15876,_16007,_15993,_15944),
    {user:adj_compl(_15879,because_of,_15873,_15901,_15874,_15875)}.

foratx0([foratx0,lit(for),lit(at)],_15894,_15896) --> 
    cc(for,_15894,_15915),
    cc(at,_15915,_15896).

foratx0([foratx0,lit(at)],_15889,_15891) --> 
    cc(at,_15889,_15891).

foratx0([foratx0,_15914],_15903,_15905) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_15914,_15903,_15905).

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,{},_15972,_15996,{},!],_15936,_15938) --> 
    {user:testmember(_15872,[label,be_named])},
    look_ahead_np(_15972,_15936,_15987),
    np0_accept(_15899,_15876,_15996,_15987,_15938),
    {user:verb_compl(_15872,with,_15873,_15899,_15874,_15875)},
    !.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},lit(enn),lit(å),!,_16021,{}],_15958,_15960) --> 
    {user:(\+testmember(_15872,[be,be1,be2]))},
    cc(enn,_15958,_16004),
    cc(å,_16004,_16015),
    !,
    pushstack(first,[noen],nil,_16015,_16034),clausal_object1(_15901,_15878::_15879,_16021,_16034,_15960),
    {user:verb_compl(_15872,than,_15873,_15901,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},lit(enn),lit(at),!,_16016,{}],_15953,_15955) --> 
    {user:(\+testmember(_15872,[be,be1,be2]))},
    cc(enn,_15953,_15999),
    cc(at,_15999,_16010),
    !,
    clausal_object1(_15901,_15878::_15879,_16016,_16010,_15955),
    {user:verb_compl(_15872,than,_15873,_15901,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},lit(enn),_15992,{}],_15945,_15947) --> 
    {user:(\+testmember(_15872,[be,be1,be2]))},
    cc(enn,_15945,_15991),
    np1(_15895,_15878::_15879,_15992,_15991,_15947),
    {user:verb_compl(_15872,than,_15873,_15895,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,{},_15988,{},!,_16032,{}],_15952,_15954) --> 
    {user:testmember(_15872,[notify,wait])},
    w(prep(_15896),_15988,_15952,_16005),
    {user:(\+testmember(_15896,[for]))},
    !,
    clausal_object0(_15898,_15876,_16032,_16005,_15954),
    {user:verb_compl(_15872,_15896,_15873,_15898,_15874,_15875)}.

verb_mod1(adj/nil/_15882,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},_16012,lit(å),!,_16072,{}],_15976,_15978) --> 
    {user:testmember(_15882,[nice,good,bad,interested,interesting])},
    optional(w(prep(_15930)),_16012,_15976,_16044),
    cc(å,_16044,_16066),
    !,
    pushstack(first,npgap(_15873),nil,_16066,_16115),clausal_object1(_15907,_15878::_15879,_16072,_16115,_15978),
    {user:verb_compl(adj/nil/_15882,because_of,_15873,_15907,_15874,_15875)}.

overat([overat,lit(fordi)],_15889,_15891) --> 
    cc(fordi,_15889,_15891).

overat([overat,lit(av),lit(at)],_15894,_15896) --> 
    cc(av,_15894,_15915),
    cc(at,_15915,_15896).

overat([overat,lit(over),lit(at)],_15894,_15896) --> 
    cc(over,_15894,_15915),
    cc(at,_15915,_15896).

overat([overat,lit(til),lit(at)],_15894,_15896) --> 
    cc(til,_15894,_15915),
    cc(at,_15915,_15896).

verb_mod1(adj/nil/_15879,_15873,_15874,_15875,_15876,[verb_mod1,{},lit(av),lit(hvilken),!,_16016,{}],_15953,_15955) --> 
    {user:(\+testmember(_15879,[]))},
    cc(av,_15953,_15999),
    cc(hvilken,_15999,_16010),
    !,
    np1(_15904,_15876,_16016,_16010,_15955),
    {user:verb_compl(adj/nil/_15879,of,_15873,_15904,_15874,_15875)}.

verb_mod1(adj/nil/_15882,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},_15993,!,_16022,{}],_15957,_15959) --> 
    {user:(\+testmember(_15882,[]))},
    overaa(_15993,_15957,_16008),
    !,
    pushstack(first,npgap(_15873),nil,_16008,_16065),clausal_object1(_15904,_15878::_15879,_16022,_16065,_15959),
    {user:verb_compl(adj/nil/_15882,because_of,_15873,_15904,_15874,_15875)}.

overaa([overaa,lit(av),lit(å)],_15894,_15896) --> 
    cc(av,_15894,_15915),
    cc(å,_15915,_15896).

overaa([overaa,lit(over),lit(å)],_15894,_15896) --> 
    cc(over,_15894,_15915),
    cc(å,_15915,_15896).

overaa([overaa,lit(til),lit(å)],_15894,_15896) --> 
    cc(til,_15894,_15915),
    cc(å,_15915,_15896).

verb_mod1(_15872,_15873,_15874,_15875,_15876,[verb_mod1,{},_15980,lit(å),!,_16020,{}],_15944,_15946) --> 
    {user:(\+testmember(_15872,[]))},
    instead_of(_15980,_15944,_15995),
    cc(å,_15995,_16014),
    !,
    pushstack(first,npgap(_15873),nil,_16014,_16063),clausal_object1(_15898,_15876,_16020,_16063,_15946),
    {user:verb_compl(_15872,instead_of,_15873,_15898,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15878,[verb_mod1,_15974,_16003,{},_16052,{}],_15948,_15950) --> 
    gradverb0(_15902,_15974,_15948,_15991),
    adverb(_15896,_15898,_15906,_16003,_15991,_16024),
    {user:testmember(_15896,[slowly,fast,thereafter])},
    not_look_ahead([det],_16052,_16024,_15950),
    {user:adv_compl(_15872,_15896,_15873,_15898,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},lit(om),lit(å),!,_16015,{}],_15952,_15954) --> 
    {user:testmember(_15872,[ask])},
    cc(om,_15952,_15998),
    cc(å,_15998,_16009),
    !,
    pushstack(first,npgap(_15873),nil,_16009,_16058),clausal_object1(_15901,_15878::_15879,_16015,_16058,_15954),
    {user:verb_compl(_15872,regarding,_15873,_15901,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},_15999,_16043,lit(å),!,_16103,{}],_15963,_15965) --> 
    {user:testmember(_15872,[extend,help])},
    optional([til],_15999,_15963,_16031),
    optional([med],_16043,_16031,_16075),
    cc(å,_16075,_16097),
    !,
    pushstack(first,npgap(_15873),nil,_16097,_16146),clausal_object1(_15904,_15878::_15879,_16103,_16146,_15965),
    {user:verb_compl(_15872,with,_15873,_15904,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,_15954,!,{}],_15928,_15930) --> 
    xadverbial1(_15890,_15892,_15878::_15879,_15954,_15928,_15930),
    !,
    {user:verb_compl(_15872,_15890,_15873,_15892,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},_15986,!,_16020,_16044,{}],_15950,_15952) --> 
    {user:testmember(_15872,[talk,speak])},
    look_ahead([om],_15986,_15950,_16003),
    !,
    accept(_16020,_16003,_16035),
    adverbial1(regarding,_15901,_15878::_15879,_16044,_16035,_15952),
    {user:verb_compl(_15872,regarding,_15873,_15901,_15874,_15875)}.

verb_mod1(adj/_15885/_15882,_15873,_15874,_15875,_15878::_15879,[verb_mod1,_15957,{}],_15931,_15933) --> 
    adverbial4(_15893,_15895,_15878::_15879,_15957,_15931,_15933),
    {user:adj_compl(_15882,_15893,_15873,_15895,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},_15979,{}],_15943,_15945) --> 
    {user:(\+testmember(_15872,[know,know1,speak,hope]))},
    adverbial3(_15890,_15892,_15878::_15879,_15979,_15943,_15945),
    {user:verb_compl(_15872,_15890,_15873,_15892,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},_15994,!,_16028,_16052,{}],_15958,_15960) --> 
    {user:testmember(_15872,[know,know1,ask,tell,speak,think])},
    look_ahead([om],_15994,_15958,_16011),
    !,
    accept(_16028,_16011,_16043),
    adverbial1(regarding,_15901,_15878::_15879,_16052,_16043,_15960),
    {user:verb_compl(_15872,regarding,_15873,_15901,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,srel/_15891/time/_15885/_15874,_15878::_15878,[verb_mod1,_15998,{},_16037,{},{},!,_16091],_15972,_15974) --> 
    w(prep(_15891),_15998,_15972,_16015),
    {user:testmember(_15891,[to,until])},
    w(adv(_15885),_16037,_16015,_16054),
    {user:testmember(_15885,[tomorrow])},
    {user:verb_compl(_15872,_15891,_15873,_15944:time,_15874,_15942)},
    !,
    accept(_16091,_16054,_15974).

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15878,[verb_mod1,_15947,{}],_15921,_15923) --> 
    xadverb(_15887,_15889,_15947,_15921,_15923),
    {user:adv_compl(_15872,_15887,_15873,_15889,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,_15951,{}],_15925,_15927) --> 
    adverbix(_15887,_15889,_15878::_15879,_15951,_15925,_15927),
    {user:verb_compl(_15872,_15887,_15873,_15889,_15874,_15875)}.

verb_mod1(_15872,_15873,_15874,_15875,_15878::_15879,[verb_mod1,{},_16022,_16051,{},{},!,_16115],_15986,_15988) --> 
    {user:(\+testmember(_15872,[go]))},
    nil_compl(_15872,_16022,_15986,_16039),
    adjunct1(nil,_15911,_15878::_15879,_16051,_16039,_16072),
    {user:(constrain(_15911,time);constrain(_15911,departure);constrain(_15911,arrival);constrain(_15911,route);constrain(_15911,number);constrain(_15911,bus))},
    {user:verb_compl(_15872,nil,_15873,_15911,_15874,_15875)},
    !,
    accept(_16115,_16072,_15988).

dir_compl(_15872,[dir_compl,{},!,_15933],_15904,_15906) --> 
    {user:v_compl(_15872,_15883,dir,_15885)},
    !,
    accept(_15933,_15904,_15906).

nil_compl(_15872,[nil_compl,_15920,_15954,!],_15906,_15908) --> 
    gmem(_15872,[have],_15920,_15906,_15939),
    look_ahead_lit([hver],_15954,_15939,_15908),
    !.

nil_compl(be/_15875,[nil_compl,{},!,_15936],_15907,_15909) --> 
    {user:a_compl(_15875,_15886,nil,_15888)},
    !,
    accept(_15936,_15907,_15909).

nil_compl(adj/nil/_15875,[nil_compl,{},!],_15907,_15907) --> 
    {user:(\+testmember(_15875,[]))},
    !.

nil_compl(adj/nil/_15875,[nil_compl,{},!,_15938],_15909,_15911) --> 
    {user:(\+post_adjective(_15875))},
    !,
    reject(_15938,_15909,_15911).

nil_compl(go,[nil_compl,_16127,{},_16166,_16195,_16224,_16253,_16282,_16311,_16340,_16369,_16398,_16427,_16456,_16485,_16514,_16543,_16572,_16601,_16630,_16659,_16688,_16717,_16746,!,_16780],_16113,_16115) --> 
    w(nb(_15948,num),_16127,_16113,_16144),
    {user:_15948<100},
    not_look_ahead(w(noun(time_count,plu,u,n)),_16166,_16144,_16183),
    not_look_ahead(w(nb(_15969,num)),_16195,_16183,_16212),
    not_look_ahead([:],_16224,_16212,_16241),
    not_look_ahead([?],_16253,_16241,_16270),
    not_look_ahead(['.'],_16282,_16270,_16299),
    not_look_ahead([/],_16311,_16299,_16328),
    not_look_ahead([den],_16340,_16328,_16357),
    not_look_ahead(w(name(_15996,_15997,month)),_16369,_16357,_16386),
    not_look_ahead(w(name(new_years_day,_16005,date)),_16398,_16386,_16415),
    not_look_ahead(w(name(whitsun_day,_16013,date)),_16427,_16415,_16444),
    not_look_ahead(w(name(christmas_day,_16021,date)),_16456,_16444,_16473),
    not_look_ahead(w(name(easterday,_16029,date)),_16485,_16473,_16502),
    not_look_ahead(w(prep(_16036)),_16514,_16502,_16531),
    not_look_ahead(w(prep(over)),_16543,_16531,_16560),
    not_look_ahead(w(prep(on)),_16572,_16560,_16589),
    not_look_ahead(w(prep(in)),_16601,_16589,_16618),
    not_look_ahead(w(noun(day,_16061,_16062,_16063)),_16630,_16618,_16647),
    not_look_ahead(w(noun(hour,_16070,_16071,_16072)),_16659,_16647,_16676),
    not_look_ahead(w(noun(minute,_16079,_16080,_16081)),_16688,_16676,_16705),
    not_look_ahead(w(noun(second,_16088,_16089,_16090)),_16717,_16705,_16734),
    not_look_ahead([om],_16746,_16734,_16763),
    !,
    reject(_16780,_16763,_16115).

nil_compl(_15872,[nil_compl,{},{},{},_15975,!,_16004],_15931,_15933) --> 
    {user:(\+abnormalverb(_15872,_15894))},
    {user:(\+testmember(_15872,[have,be_named]))},
    {user:v_compl(_15872,_15910,nil,_15912)},
    hver0(_15975,_15931,_15990),
    !,
    accept(_16004,_15990,_15933).

verb_modifier3(_15872,_15873,_15874,_15875,_15876,[verb_modifier3,_15969,_16100],_15943,_15945) --> 
    pushstack(free,(npgap(_15873),lexv(iv,_15872,pres,fin),prep(in),w(noun(time,sin,u,n))),nil,_15943,_16075),statreal(_15885,_15969,_16075,_16088),
    determiner00(_15874,_15875,_15885::_15876,_16100,_16088,_15945).

adverbix0(_15872,_15873,_15874,[adverbix0,_15924,!],_15904,_15906) --> 
    adverbix(_15872,_15873,_15874,_15924,_15904,_15906),
    !.

adverbix0(redundantly,nil:thing,_15876::_15876,[adverbix0,[]],_15903,_15903) --> 
    [].

adverbix(_15872,nil:_15880,_15876::_15876,[adverbix,_15936,{}],_15916,_15918) --> 
    w(adv(_15872),_15936,_15916,_15918),
    {user:particle(_15872,_15880,_15889)}.

adverbix(redundantly,nil:thing,_15876::_15876,[adverbix,_15930,!],_15910,_15912) --> 
    w(adv(redundantly),_15930,_15910,_15912),
    !.

adverbix(_15872,_15873,_15876::_15877,[adverbix,_15927],_15907,_15909) --> 
    adverbial1(_15872,_15873,_15876::_15877,_15927,_15907,_15909).

adverbix(_15872,nil:_15880,_15876::_15876,[adverbix,_15932,_15961],_15912,_15914) --> 
    gradverbs0(_15889,_15932,_15912,_15949),
    adverbx(_15872,_15880,_15887,_15961,_15949,_15914).

adverbix(nil,_15873,_15874,[adverbix,_15940,_15969,_16003],_15920,_15922) --> 
    look_ahead(w(noun(_15889,sin,u,n)),_15940,_15920,_15957),
    gmem(_15889,[midnight],_15969,_15957,_15988),
    complement_nil(_15873,_15874,_16003,_15988,_15922).

adverbix(nil,_15873,_15874,[adverbix,lit(den),_15946,_15975],_15915,_15917) --> 
    cc(den,_15915,_15945),
    look_ahead(w(nb(_15891,_15892)),_15946,_15945,_15963),
    complement_nil(_15873,_15874,_15975,_15963,_15917).

adverbial(_15872,_15873,_15876::_15877,[adverbial,_15927],_15907,_15909) --> 
    adverbial3(_15872,_15873,_15876::_15877,_15927,_15907,_15909).

adverbial(_15872,_15873,_15876::_15877,[adverbial,_15927],_15907,_15909) --> 
    adverbial1(_15872,_15873,_15876::_15877,_15927,_15907,_15909).

preadverbial0(_15872,_15873,_15874,[preadverbial0,_15924,!],_15904,_15906) --> 
    adverbial1(_15872,_15873,_15874,_15924,_15904,_15906),
    !.

preadverbial0(redundantly,nil:thing,_15876::_15876,[preadverbial0,[]],_15903,_15903) --> 
    [].

preadverbial1(_15872,_15873,_15874,[preadverbial1,_15963,_15992,_16021,{},_16060,!],_15943,_15945) --> 
    w(nb(_15893,num),_15963,_15943,_15980),
    w(noun(minute,_15899,_15900,_15901),_15992,_15980,_16009),
    look_ahead(w(prep(_15907)),_16021,_16009,_16038),
    {user:testmember(_15907,[before,after])},
    adverbial1(_15872,_15873,_15874,_16060,_16038,_15945),
    !.

preadverbial1(_15872,_15873,_15874,[preadverbial1,_15931,_15960,_15984],_15911,_15913) --> 
    not_look_ahead([e],_15931,_15911,_15948),
    not_look_ahead_np(_15960,_15948,_15975),
    adverbix(_15872,_15873,_15874,_15984,_15975,_15913).

preadverbial1(nil,_15873,_15874,[preadverbial1,_15945,!,_15979,_16003],_15925,_15927) --> 
    w(adj2(early,nil),_15945,_15925,_15962),
    !,
    accept(_15979,_15962,_15994),
    pushstack(first,w(noun(morning,sin,u,n)),nil,_15994,_16013),
    adjunct1(nil,_15873,_15874,_16003,_16013,_15927).

preadverbial1(before,1200:clock,_15876::_15876 and 1200 isa clock,[preadverbial1,_15936],_15916,_15918) --> 
    w(noun(morning,sin,u,n),_15936,_15916,_15918).

preadverbial1(before,1200:clock,_15876::_15876 and 1200 isa clock,[preadverbial1,_15936],_15916,_15918) --> 
    w(noun(prenoon,sin,u,n),_15936,_15916,_15918).

preadverbial1(after,1200:clock,_15876::_15876 and 1200 isa clock,[preadverbial1,_15936],_15916,_15918) --> 
    w(noun(afternoon,sin,u,n),_15936,_15916,_15918).

preadverbial1(after,1800:clock,_15876::_15876 and 1800 isa clock,[preadverbial1,_15936],_15916,_15918) --> 
    w(noun(night,sin,u,n),_15936,_15916,_15918).

preadverbial1(nil,_15873,_15874,[preadverbial1,_15926,!,_15965],_15906,_15908) --> 
    obviousclock1(_15873,_15874,_15926,_15906,_15945),
    !,
    accept(_15965,_15945,_15908).

preadverbial1(nil,_15873,_15874,[preadverbial1,_15926,!,_15965],_15906,_15908) --> 
    obviousdate1(_15873,_15874,_15926,_15906,_15945),
    !,
    accept(_15965,_15945,_15908).

preadverbials([preadverbials,_15904,!,_15933],_15893,_15895) --> 
    redundant(_15904,_15893,_15919),
    !,
    preadverbials(_15933,_15919,_15895).

preadverbials([preadverbials,_15921,!,[],_16011,_16035],_15910,_15912) --> 
    adverbix(_15884,_15885,_15886,_15921,_15910,_15942),
    !,
    pushstack(free,xadverbial1(_15884,_15885,_15886),nil,_15942,_16010),[],
    adverbial_conjunction0(_16011,_16010,_16026),
    preadverbials0(_16035,_16026,_15912).

preadverbials0([preadverbials0,_15901,!],_15890,_15892) --> 
    preadverbials(_15901,_15890,_15892),
    !.

preadverbials0([preadverbials0,[]],_15887,_15887) --> 
    [].

adverbial_conjunction0([adverbial_conjunction0,_15901,!],_15890,_15892) --> 
    adverbial_conjunction(_15901,_15890,_15892),
    !.

adverbial_conjunction0([adverbial_conjunction0,[]],_15887,_15887) --> 
    [].

adverbial_conjunction([adverbial_conjunction,lit(og),_15923,!],_15901,_15903) --> 
    cc(og,_15901,_15922),
    look_ahead(w(prep(_15884)),_15923,_15922,_15903),
    !.

adverbial1(_15872,_15873,_15874,[adverbial1,lit(slik),!,_15967],_15931,_15933) --> 
    cc(slik,_15931,_15961),
    !,
    pushstack(first,(w(prep(in)),w(noun(way,sin,def,n)),[som]),nil,_15961,_15977),
    adjunct1(_15872,_15873,_15874,_15967,_15977,_15933).

adverbial1(_15872,_15873,_15874,[adverbial1,lit(dit),_15977,!,_16016],_15946,_15948) --> 
    cc(dit,_15946,_15976),
    lit_of(_15896,[jeg,du],_15977,_15976,_15996),
    !,
    pushstack(first,(w(prep(to)),w(noun(place,sin,def,n)),[som],[_15896]),nil,_15996,_16026),
    adjunct1(_15872,_15873,_15874,_16016,_16026,_15948).

adverbial1(ago,_15873,_15874,[adverbial1,_15963,_15992,_16021,lit(siden),!,_16066],_15943,_15945) --> 
    prep1(for,_15963,_15943,_15980),
    anumber(_15906,_15992,_15980,_16009),
    w(noun(_15899,_15911,u,n),_16021,_16009,_16038),
    cc(siden,_16038,_16060),
    !,
    lock(exact,_16060,_16113),
    pushstack(exact,(number(_15906),w(noun(_15899,plu,u,n))),nil,_16113,_16119),
    np1(_15873,_15874,_16066,_16119,_16108),
    unlock(_16108,_15945).

adverbial1(in,_15885:day,_15876::exists(_15885:morrow)::_15885 isa morrow and _15876,[adverbial1,_15943,!,_15972],_15923,_15925) --> 
    tomorrow(_15943,_15923,_15958),
    !,
    accept(_15972,_15958,_15925).

adverbial1(_15872,_15873,_15874,[adverbial1,_15921],_15901,_15903) --> 
    adjunct1(_15872,_15873,_15874,_15921,_15901,_15903).

adverbial1(in,_15885:_15886,_15876::exists(_15885:_15886)::_15885 isa _15886 and _15876,[adverbial1,_15972,{},!,_16016],_15952,_15954) --> 
    w(noun(_15886,_15908,_15909,n),_15972,_15952,_15989),
    {user:testmember(_15886,[monday,tuesday,wednesday,thursday,friday,saturday,sunday])},
    !,
    accept(_16016,_15989,_15954).

adverbial3(_15872,_15879:_15880,_15876::_15877,[adverbial3,_15975,_16014,[],_16093,_16159],_15955,_15957) --> 
    xsubjunction(_15872,_15880,_15903,_15975,_15955,_15996),
    adverbial_object00(_15879:_15880,_15906,_16014,_15996,_16033),
    pushstack(free,adverbial1(_15903,_15879:_15880,_15906),nil,_16033,_16092),[],
    pushstack(first,([jeg],aux1),nil,_16092,_16134),substatement1(_15898,_16093,_16134,_16147),
    determiner00(_15879:_15880,_15876,_15898::_15877,_16159,_16147,_15957).

adverbial3(_15872,_15873,_15874,[adverbial3,lit(før),_15939,!,_15968],_15908,_15910) --> 
    cc(før,_15908,_15938),
    look_ahead_time(_15939,_15938,_15954),
    !,
    reject(_15968,_15954,_15910).

adverbial3(_15872,_15873,_15876::_15877,[adverbial3,lit(til),_15974,_16003,!,_16037,_16085],_15943,_15945) --> 
    cc(til,_15943,_15973),
    not_look_ahead([j],_15974,_15973,_15991),
    look_ahead([jeg],_16003,_15991,_16020),
    !,
    pushstack(first,w(prep(to)),nil,_16020,_16050),subordinate(_15872,_15873,_15898,_16037,_16050,_16067),
    determiner00(_15873,_15876,_15898::_15877,_16085,_16067,_15945).

adverbial3(_15872,_15873,_15876::_15877,[adverbial3,_15941,_15970,_16009],_15921,_15923) --> 
    not_look_ahead([til],_15941,_15921,_15958),
    subordinate(_15872,_15873,_15889,_15970,_15958,_15991),
    determiner00(_15873,_15876,_15889::_15877,_16009,_15991,_15923).

adverbial4(_15872,_15873,_15876::_15876 and _15880,[adverbial4,_15950,_15979,_16008,{}],_15930,_15932) --> 
    not_look_ahead([om],_15950,_15930,_15967),
    prep(_15894,_15979,_15967,_15996),
    clausal_object0(_15873,true::_15880,_16008,_15996,_15932),
    {user:adjustprep(_15873,_15894,_15872)}.

adverbial4(_15872,_15873,_15876::_15876 and _15880,[adverbial4,_15955,_15984,lit(at),_16024,{}],_15935,_15937) --> 
    not_look_ahead([om],_15955,_15935,_15972),
    prep(_15897,_15984,_15972,_16001),
    cc(at,_16001,_16023),
    clausal_object1(_15873,true::_15880,_16024,_16023,_15937),
    {user:adjustprep(_15873,_15897,_15872)}.

subordinate(nil,_15876:coevent,_15874,[subordinate,lit(de),lit(samme),lit(som),_16003,_16037],_15950,_15952) --> 
    cc(de,_15950,_15980),
    cc(samme,_15980,_15991),
    cc(som,_15991,_16002),
    adverbial_object00(_15876:coevent,_15902,_16003,_16002,_16022),
    lock(last,_16022,_16085),
    pushstack(last,([de],w(verb(be,pres,fin)),adverbial1(nil,_15876:coevent,_15902)),nil,_16085,_16091),
    substatement1(_15874,_16037,_16091,_16080),
    unlock(_16080,_15952).

subordinate(_15872,_15873,_15874,[subordinate,_15946,{},_15985,!,_16019],_15926,_15928) --> 
    w(prep(_15890),_15946,_15926,_15963),
    {user:testmember(_15890,[instead_of])},
    not_look_ahead_lit([at,å],_15985,_15963,_16002),
    !,
    reject(_16019,_16002,_15928).

subordinate(_15872,_15873,_15874,[subordinate,_15954,_15983,_16012,{},!,_16056],_15934,_15936) --> 
    not_look_ahead([siden],_15954,_15934,_15971),
    w(prep(_15897),_15983,_15971,_16000),
    look_ahead(w(noun(_15903,_15904,_15905,_15906)),_16012,_16000,_16029),
    {user:subclass0(_15903,time)},
    !,
    reject(_16056,_16029,_15936).

subordinate(_15872,_15873,_15874,[subordinate,_15940,_15979,_16008],_15920,_15922) --> 
    subjunction(_15872,_15883,_15882,_15940,_15920,_15961),
    not_look_ahead(w(verb(_15895,_15896,_15897)),_15979,_15961,_15996),
    subord_clause(_15882,_15883,_15873,_15874,_16008,_15996,_15922).

subord_clause(_15872,_15873,_15877:_15873,_15875,[subord_clause,_15950,!,_15989],_15927,_15929) --> 
    adverbial_object00(_15877:_15873,_15891,_15950,_15927,_15969),
    !,
    lock(last,_15969,_16037),
    pushstack(last,xadverbial1(_15872,_15877:_15873,_15891),nil,_16037,_16043),
    substatement1(_15875,_15989,_16043,_16032),
    unlock(_16032,_15929).

adverbial_object00(_15884:_15885,_15875::exists(_15884:_15885)::_15884 isa _15885 and _15875,[adverbial_object00,[]],_15914,_15914) --> 
    [].

subordinateinfnosubj(_15872,_15873,_15874,_15875,_15876,[subordinateinfnosubj,{},_15976,!,_16020],_15940,_15942) --> 
    {user:it_template(_15874)},
    np00(_15873,_15894,_15897::_15898,_15976,_15940,_15997),
    !,
    pushstack(free,(npgap(_15874),adverbial1(_15872,_15894,_15897::_15898)),nil,_15997,_16095),
    statreal(_15876,_16020,_16095,_15942).

subordinateinfnosubj(_15872,_15873,_15874,_15875,_15876,[subordinateinfnosubj,{},_16011,{},!,_16070,!,_16114],_15975,_15977) --> 
    {user:(\+it_template(_15874))},
    lexv(tv,_15922,_15923,fin,_16011,_15975,_16034),
    {user:testmember(_15922,[take])},
    !,
    np00(_15873,_15909,_15912::_15913,_16070,_16034,_16091),
    !,
    pushstack(free,(someone,w(verb(_15922,pres,fin)),npgap(_15874),adverbial1(_15872,_15909,_15912::_15913)),nil,_16091,_16217),
    statreal(_15876,_16114,_16217,_15977).

subordinateinfnosubj(_15872,_15873,_15874,_15875,_15876,[subordinateinfnosubj,{},_16011,{},!,_16070,!,_16114],_15975,_15977) --> 
    {user:(\+it_template(_15874))},
    lexv(tv,_15922,_15923,fin,_16011,_15975,_16034),
    {user:testmember(_15922,[help])},
    !,
    np00(_15873,_15909,_15912::_15913,_16070,_16034,_16091),
    !,
    pushstack(free,(npgap(_15874),w(verb(_15922,pres,fin)),someone,adverbial1(_15872,_15909,_15912::_15913)),nil,_16091,_16217),
    statreal(_15876,_16114,_16217,_15977).

partday(_15872,_15873,_15874,[partday,_15936,{},!],_15916,_15918) --> 
    w(noun(_15872,_15885,_15886,n),_15936,_15916,_15918),
    {user:particle(_15872,_15873,_15874)},
    !.

partday(tomorrow,_15873,_15874,[partday,_15951,_15975,_16004,_16033,!,{}],_15931,_15933) --> 
    to0(_15951,_15931,_15966),
    prep1(in,_15975,_15966,_15992),
    not_look_ahead([formiddag],_16004,_15992,_16021),
    w(noun(morning,_15906,_15907,n),_16033,_16021,_15933),
    !,
    {user:particle(tomorrow,_15873,_15874)}.

partday(tomorrow,_15873,_15874,[partday,_15944,_15968,_15997,!,{}],_15924,_15926) --> 
    to0(_15944,_15924,_15959),
    prep1(in,_15968,_15959,_15985),
    w(noun(morrow,_15899,_15900,n),_15997,_15985,_15926),
    !,
    {user:particle(tomorrow,_15873,_15874)}.

partday(_15872,_15873,_15874,[partday,_15950,_15979,!,{},{}],_15930,_15932) --> 
    inom(_15894,_15950,_15930,_15967),
    w(noun(_15898,_15899,_15900,n),_15979,_15967,_15932),
    !,
    {user:norpart(_15894,_15898,_15872)},
    {user:particle(_15872,_15873,_15874)}.

adverbx(with,mode,post,[adverbx,lit(med),_15936,!],_15905,_15907) --> 
    cc(med,_15905,_15935),
    not_look_ahead_np(_15936,_15935,_15907),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),_15936,!],_15905,_15907) --> 
    cc(etter,_15905,_15935),
    terminatore(_15936,_15935,_15907),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),lit(det),!],_15907,_15909) --> 
    cc(etter,_15907,_15937),
    cc(det,_15937,_15909),
    !.

adverbx(earlier,time,post,[adverbx,lit(før),lit(det),!],_15907,_15909) --> 
    cc(før,_15907,_15937),
    cc(det,_15937,_15909),
    !.

adverbx(_15872,_15873,_15874,[adverbx,lit(slik),lit(at),!,_15957],_15910,_15912) --> 
    cc(slik,_15910,_15940),
    cc(at,_15940,_15951),
    !,
    reject(_15957,_15951,_15912).

adverbx(_15872,_15873,_15874,[adverbx,_15936,_15960,!,{}],_15916,_15918) --> 
    not_look_ahead_prepx(_15936,_15916,_15951),
    w(adv(_15872),_15960,_15951,_15918),
    !,
    {user:particle(_15872,_15873,_15874)}.

not_look_ahead_prepx([not_look_ahead_prepx,lit(med),_15917,!],_15895,_15897) --> 
    cc(med,_15895,_15916),
    look_ahead_np(_15917,_15916,_15897),
    !.

not_look_ahead_prepx([not_look_ahead_prepx,_15904],_15893,_15895) --> 
    not_look_ahead(w(prep(_15876)),_15904,_15893,_15895).

adverbx(_15872,_15873,_15874,[adverbx,_15921],_15901,_15903) --> 
    adverb(_15872,_15873,_15874,_15921,_15901,_15903).

adverbx(_15872,_15873,_15874,[adverbx,_15921],_15901,_15903) --> 
    partday(_15872,_15873,_15874,_15921,_15901,_15903).

adverbx(yesterday,_15873,_15874,[adverbx,_15936,lit(går),!,{}],_15916,_15918) --> 
    prep1(in,_15936,_15916,_15953),
    cc(går,_15953,_15918),
    !,
    {user:particle(yesterday,_15873,_15874)}.

anyadverb0([anyadverb0,_15918,_15942,!,[]],_15907,_15909) --> 
    therenot0(_15918,_15907,_15933),
    adverb(_15884,_15885,_15886,_15942,_15933,_15963),
    !,
    pushstack(free,adverb(_15884,_15885,_15886),nil,_15963,_15909),
    [].

anyadverb0([anyadverb0,_15898],_15887,_15889) --> 
    therenot0(_15898,_15887,_15889).

adverbx0([adverbx0,_15905,!],_15894,_15896) --> 
    w(adv(redundantly),_15905,_15894,_15896),
    !.

adverbx0([adverbx0,_15948,_15977,_16006,{},!,[]],_15937,_15939) --> 
    not_look_ahead(w(noun(_15898,sin,u,n)),_15948,_15937,_15965),
    not_look_ahead(w(prep(_15907)),_15977,_15965,_15994),
    adverb(_15890,_15891,_15892,_16006,_15994,_16027),
    {user:(\+testmember(_15890,[home]))},
    !,
    pushstack(free,adverb(_15890,_15891,_15892),nil,_16027,_15939),
    [].

adverbx0([adverbx0,[]],_15887,_15887) --> 
    [].

adverb0(_15872,_15873,_15874,[adverb0,_15924,!],_15904,_15906) --> 
    adverb(_15872,_15873,_15874,_15924,_15904,_15906),
    !.

adverb0(redundantly,thing,post,[adverb0,[]],_15897,_15897) --> 
    [].

adverb(delayed,time,post,[adverb,_15925,!],_15905,_15907) --> 
    w(adj2(delayed,nil),_15925,_15905,_15907),
    !.

adverb(_15872,_15873,_15874,[adverb,_15943,_15972,_16001,{}],_15923,_15925) --> 
    gradverb0(_15891,_15943,_15923,_15960),
    not_look_ahead([siste],_15972,_15960,_15989),
    w(adj2(_15872,nil),_16001,_15989,_15925),
    {user:particle(_15872,_15873,_15874)}.

adverb(now,_15873,_15874,[adverb,_15931,_15960,{}],_15911,_15913) --> 
    prep1(with,_15931,_15911,_15948),
    detsamme(_15960,_15948,_15913),
    {user:particle(now,_15873,_15874)}.

adverb(first,time,_15874,[adverb,lit(først)],_15899,_15901) --> 
    cc(først,_15899,_15901).

adverb(today,day,pre,[adverb,_15929,_15958],_15909,_15911) --> 
    prep1(in,_15929,_15909,_15946),
    w(noun(day,sin,u,n),_15958,_15946,_15911).

adverb(tomorrow,day,pre,[adverb,_15924,lit(morgen)],_15904,_15906) --> 
    prep1(in,_15924,_15904,_15941),
    cc(morgen,_15941,_15906).

adverb(day_after_tomorrow,day,pre,[adverb,_15924,lit(overimorgen)],_15904,_15906) --> 
    prep1(in,_15924,_15904,_15941),
    cc(overimorgen,_15941,_15906).

adverb(day_before_yesterday,day,pre,[adverb,_15924,lit(forgårs)],_15904,_15906) --> 
    prep1(in,_15924,_15904,_15941),
    cc(forgårs,_15941,_15906).

adverb(tonight,daypart,pre,[adverb,_15929,_15958],_15909,_15911) --> 
    prep1(in,_15929,_15909,_15946),
    w(noun(night,_15882,_15883,_15884),_15958,_15946,_15911).

adverb(today,day,pre,[adverb,_15929,_15958],_15909,_15911) --> 
    prep1(in,_15929,_15909,_15946),
    w(noun(day,_15882,_15883,_15884),_15958,_15946,_15911).

adverb(locally,place,post,[adverb,lit(lokalt)],_15899,_15901) --> 
    cc(lokalt,_15899,_15901).

adverb(_15872,_15873,_15874,[adverb,_15930,_15959,!,_15988],_15910,_15912) --> 
    w(prep(_15887),_15930,_15910,_15947),
    look_ahead_np(_15959,_15947,_15974),
    !,
    reject(_15988,_15974,_15912).

adverb(_15872,_15873,_15874,[adverb,_15928,{}],_15908,_15910) --> 
    particle(_15872,_15928,_15908,_15910),
    {user:particle(_15872,_15873,_15874)}.

adverb(_15872,_15873,_15874,[adverb,_15966,{},_16005,_16034,{},_16073],_15946,_15948) --> 
    particle(_15872,_15966,_15946,_15983),
    {user:testmember(_15872,[on,off])},
    not_look_ahead(w(noun(_15906,_15907,_15908,_15909)),_16005,_15983,_16022),
    not_look_ahead(w(name(_15915,_15916,_15917)),_16034,_16022,_16051),
    {user:particle(_15872,_15873,_15874)},
    da0(_16073,_16051,_15948).

particlev0(_15872,_15873,[particlev0,_15917,!],_15900,_15902) --> 
    particlev2(_15872,_15873,_15917,_15900,_15902),
    !.

particlev0(_15872,_15872,[particlev0,_15913],_15896,_15898) --> 
    particlev1(_15872,_15913,_15896,_15898).

particlev0(_15872,_15872,[particlev0,[]],_15894,_15894) --> 
    [].

particle0(_15872,[particle0,_15910,!],_15896,_15898) --> 
    particle(_15872,_15910,_15896,_15898),
    !.

particle0(_15872,[particle0,[]],_15891,_15891) --> 
    [].

particlev1(believe,[particlev1,lit(på)],_15893,_15895) --> 
    cc(på,_15893,_15895).

particlev1(calculate,[particlev1,lit(med)],_15893,_15895) --> 
    cc(med,_15893,_15895).

particlev1(check,[particlev1,lit(opp)],_15893,_15895) --> 
    cc(opp,_15893,_15895).

particlev1(come,[particlev1,lit(med),_15921],_15896,_15898) --> 
    cc(med,_15896,_15920),
    not_look_ahead_np(_15921,_15920,_15898).

particlev1(come,[particlev1,lit(til),_15921],_15896,_15898) --> 
    cc(til,_15896,_15920),
    not_look_ahead_np(_15921,_15920,_15898).

particlev1(come,[particlev1,lit(opp)],_15893,_15895) --> 
    cc(opp,_15893,_15895).

particlev1(correct,[particlev1,lit(opp)],_15893,_15895) --> 
    cc(opp,_15893,_15895).

particlev1(fetch,[particlev1,lit(ned)],_15893,_15895) --> 
    cc(ned,_15893,_15895).

particlev1(fetch,[particlev1,lit(opp)],_15893,_15895) --> 
    cc(opp,_15893,_15895).

particlev1(find,[particlev1,lit(ut),lit(av)],_15898,_15900) --> 
    cc(ut,_15898,_15922),
    cc(av,_15922,_15900).

particlev1(get,[particlev1,lit(med)],_15893,_15895) --> 
    cc(med,_15893,_15895).

particlev1(get,[particlev1,lit(opp)],_15893,_15895) --> 
    cc(opp,_15893,_15895).

particlev1(have,[particlev1,lit(på)],_15893,_15895) --> 
    cc(på,_15893,_15895).

particlev1(help,[particlev1,lit(til),lit(med)],_15898,_15900) --> 
    cc(til,_15898,_15922),
    cc(med,_15922,_15900).

particlev1(help,[particlev1,lit(til)],_15893,_15895) --> 
    cc(til,_15893,_15895).

particlev1(improve,[particlev1,lit(inn)],_15893,_15895) --> 
    cc(inn,_15893,_15895).

particlev1(indicte,[particlev1,lit(på)],_15893,_15895) --> 
    cc(på,_15893,_15895).

particlev1(lay,[particlev1,lit(inn)],_15893,_15895) --> 
    cc(inn,_15893,_15895).

particlev1(lie1,[particlev1,lit(med)],_15893,_15895) --> 
    cc(med,_15893,_15895).

particlev1(name,[particlev1,lit(til)],_15893,_15895) --> 
    cc(til,_15893,_15895).

particlev1(reach,[particlev1,lit(til)],_15893,_15895) --> 
    cc(til,_15893,_15895).

particlev1(reach,[particlev1,lit(fram),lit(til)],_15898,_15900) --> 
    cc(fram,_15898,_15922),
    cc(til,_15922,_15900).

particlev1(read,[particlev1,lit(gjennom)],_15893,_15895) --> 
    cc(gjennom,_15893,_15895).

particlev1(receive,[particlev1,lit(opp)],_15893,_15895) --> 
    cc(opp,_15893,_15895).

particlev1(get,[particlev1,lit(opp)],_15893,_15895) --> 
    cc(opp,_15893,_15895).

particlev1(send,[particlev1,lit(med)],_15893,_15895) --> 
    cc(med,_15893,_15895).

particlev1(send,[particlev1,lit(over)],_15893,_15895) --> 
    cc(over,_15893,_15895).

particlev1(send,[particlev1,lit(ved)],_15893,_15895) --> 
    cc(ved,_15893,_15895).

particlev1(sing,[particlev1,lit(ut)],_15893,_15895) --> 
    cc(ut,_15893,_15895).

particlev1(take,[particlev1,lit(ut)],_15893,_15895) --> 
    cc(ut,_15893,_15895).

particlev1(throw,[particlev1,lit(av)],_15893,_15895) --> 
    cc(av,_15893,_15895).

particlev1(tell,[particlev1,lit(inn)],_15893,_15895) --> 
    cc(inn,_15893,_15895).

particlev1(tell,[particlev1,lit(om)],_15893,_15895) --> 
    cc(om,_15893,_15895).

particlev1(tell,[particlev1,lit(fra),lit(om),!],_15901,_15903) --> 
    cc(fra,_15901,_15925),
    cc(om,_15925,_15903),
    !.

particlev1(tell,[particlev1,lit(fra)],_15893,_15895) --> 
    cc(fra,_15893,_15895).

particlev1(tell,[particlev1,lit(ifra)],_15893,_15895) --> 
    cc(ifra,_15893,_15895).

particlev1(tell,[particlev1,_15909],_15895,_15897) --> 
    w(prep(regarding),_15909,_15895,_15897).

particlev1(wonder,[particlev1,lit(på)],_15893,_15895) --> 
    cc(på,_15893,_15895).

particlev1(write,[particlev1,lit(inn)],_15893,_15895) --> 
    cc(inn,_15893,_15895).

particlev2(avoid,release,[particlev2,lit(fri)],_15896,_15898) --> 
    cc(fri,_15896,_15898).

particlev2(be,come,[particlev2,lit(med)],_15896,_15898) --> 
    cc(med,_15896,_15898).

particlev2(belong,belong_to,[particlev2,lit(til)],_15896,_15898) --> 
    cc(til,_15896,_15898).

particlev2(hear,belong_to,[particlev2,lit(til)],_15896,_15898) --> 
    cc(til,_15896,_15898).

particlev2(calculate,expect,[particlev2,lit(med)],_15896,_15898) --> 
    cc(med,_15896,_15898).

particlev2(care1,ensure,[particlev2,lit(for)],_15896,_15898) --> 
    cc(for,_15896,_15898).

particlev2(come,appear,[particlev2,lit(fram)],_15896,_15898) --> 
    cc(fram,_15896,_15898).

particlev2(come,disappear,[particlev2,lit(bort),_15933],_15905,_15907) --> 
    cc(bort,_15905,_15932),
    not_look_ahead(w(prep(to)),_15933,_15932,_15907).

particlev2(comment,remove,[particlev2,lit(ut)],_15896,_15898) --> 
    cc(ut,_15896,_15898).

particlev2(do1,finish,[particlev2,lit(ferdig)],_15896,_15898) --> 
    cc(ferdig,_15896,_15898).

particlev2(do1,make,[particlev2,lit(meg)],_15896,_15898) --> 
    cc(meg,_15896,_15898).

particlev2(find,do1,[particlev2,lit(på)],_15896,_15898) --> 
    cc(på,_15896,_15898).

particlev2(find,discover,[particlev2,lit(ut)],_15896,_15898) --> 
    cc(ut,_15896,_15898).

particlev2(fool,wonder,[particlev2,lit(på)],_15896,_15898) --> 
    cc(på,_15896,_15898).

particlev2(go,stop,[particlev2,lit(ned)],_15896,_15898) --> 
    cc(ned,_15896,_15898).

particlev2(get,manage,[particlev2,lit(til)],_15896,_15898) --> 
    cc(til,_15896,_15898).

particlev2(have,bring,[particlev2,lit(med)],_15896,_15898) --> 
    cc(med,_15896,_15898).

particlev2(hold,be,[particlev2,lit(deg)],_15896,_15898) --> 
    cc(deg,_15896,_15898).

particlev2(hold,be,[particlev2,lit(meg)],_15896,_15898) --> 
    cc(meg,_15896,_15898).

particlev2(hold,be,[particlev2,lit(seg)],_15896,_15898) --> 
    cc(seg,_15896,_15898).

particlev2(hold,do1,[particlev2,lit(på),lit(med)],_15901,_15903) --> 
    cc(på,_15901,_15928),
    cc(med,_15928,_15903).

particlev2(hold,be1,[particlev2,lit(til)],_15896,_15898) --> 
    cc(til,_15896,_15898).

particlev2(hold,wait,[particlev2,lit(ut)],_15896,_15898) --> 
    cc(ut,_15896,_15898).

particlev2(improve,ensure,[particlev2,lit(inn)],_15896,_15898) --> 
    cc(inn,_15896,_15898).

particlev2(lay,include,[particlev2,lit(inn)],_15896,_15898) --> 
    cc(inn,_15896,_15898).

particlev2(lay,include,[particlev2,lit(på)],_15896,_15898) --> 
    cc(på,_15896,_15898).

particlev2(lay,enclose,[particlev2,lit(ved)],_15896,_15898) --> 
    cc(ved,_15896,_15898).

particlev2(lay,stop,[particlev2,lit(ned)],_15896,_15898) --> 
    cc(ned,_15896,_15898).

particlev2(lay,change,[particlev2,lit(om)],_15896,_15898) --> 
    cc(om,_15896,_15898).

particlev2(lead,cause,[particlev2,lit(til)],_15896,_15898) --> 
    cc(til,_15896,_15898).

particlev2(lie1,belong_to,[particlev2,lit(under)],_15896,_15898) --> 
    cc(under,_15896,_15898).

particlev2(list,list,[particlev2,lit(opp)],_15896,_15898) --> 
    cc(opp,_15896,_15898).

particlev2(long,want,[particlev2,lit(etter)],_15896,_15898) --> 
    cc(etter,_15896,_15898).

particlev2(look,appear,[particlev2,lit(ut)],_15896,_15898) --> 
    cc(ut,_15896,_15898).

particlev2(meet,meetup,[particlev2,lit(opp)],_15896,_15898) --> 
    cc(opp,_15896,_15898).

particlev2(negotiate,discuss,[particlev2,lit(om)],_15896,_15898) --> 
    cc(om,_15896,_15898).

particlev2(operate,do1,[particlev2,_15920,lit(med)],_15903,_15905) --> 
    optional([på],_15920,_15903,_15952),
    cc(med,_15952,_15905).

particlev2(pay,pay2,[particlev2,lit(seg)],_15896,_15898) --> 
    cc(seg,_15896,_15898).

particlev2(put,arrange,[particlev2,lit(opp)],_15896,_15898) --> 
    cc(opp,_15896,_15898).

particlev2(say,tell,[particlev2,lit(fra)],_15896,_15898) --> 
    cc(fra,_15896,_15898).

particlev2(say,tell,[particlev2,lit(ifra)],_15896,_15898) --> 
    cc(ifra,_15896,_15898).

particlev2(see,appear,[particlev2,lit(ut)],_15896,_15898) --> 
    cc(ut,_15896,_15898).

particlev2(see,appear,[particlev2,lit(ut)],_15896,_15898) --> 
    cc(ut,_15896,_15898).

particlev2(stand,indicate,[particlev2,lit(for)],_15896,_15898) --> 
    cc(for,_15896,_15898).

particlev2(take,bring,[particlev2,lit(med)],_15896,_15898) --> 
    cc(med,_15896,_15898).

particlev2(take,manage,[particlev2,lit(over)],_15896,_15898) --> 
    cc(over,_15896,_15898).

particlev2(take,get,[particlev2,lit(til),_15927],_15899,_15901) --> 
    cc(til,_15899,_15926),
    rfxpron(_15927,_15926,_15901).

particlev2(take,get,[particlev2,lit(mot)],_15896,_15898) --> 
    cc(mot,_15896,_15898).

particlev2(take,get,[particlev2,lit(imot)],_15896,_15898) --> 
    cc(imot,_15896,_15898).

particlev2(take,get,[particlev2,lit(i),lit(mot)],_15901,_15903) --> 
    cc(i,_15901,_15928),
    cc(mot,_15928,_15903).

particlev2(take,treat,[particlev2,lit(opp)],_15896,_15898) --> 
    cc(opp,_15896,_15898).

particlev2(turn,stop,[particlev2,lit(av)],_15896,_15898) --> 
    cc(av,_15896,_15898).

particlev2(turn,start,[particlev2,lit(på)],_15896,_15898) --> 
    cc(på,_15896,_15898).

particlev2(write,print,[particlev2,lit(ut)],_15896,_15898) --> 
    cc(ut,_15896,_15898).

rep_particlev0(_15872,[rep_particlev0,_15910,!],_15896,_15898) --> 
    rep_particlev(_15872,_15910,_15896,_15898),
    !.

rep_particlev0(_15872,[rep_particlev0,[]],_15891,_15891) --> 
    [].

rep_particlev(ask,[rep_particlev,lit(:),!],_15896,_15898) --> 
    cc(:,_15896,_15898),
    !.

rep_particlev(deny,[rep_particlev,lit(for)],_15893,_15895) --> 
    cc(for,_15893,_15895).

rep_particlev(wonder,[rep_particlev,lit(på),_15927,!,_15956],_15902,_15904) --> 
    cc(på,_15902,_15926),
    which0(_15927,_15926,_15942),
    !,
    accept(_15956,_15942,_15904).

rep_particlev(know,[rep_particlev,_15913,!,_15947],_15899,_15901) --> 
    prep1(to,_15913,_15899,_15930),
    !,
    accept(_15947,_15930,_15901).

rep_particlev(find,[rep_particlev,lit(ut)],_15893,_15895) --> 
    cc(ut,_15893,_15895).

rep_particlev(recognize,[rep_particlev,lit(til)],_15893,_15895) --> 
    cc(til,_15893,_15895).

rep_particlev(think,[rep_particlev,lit(på),_15931,!,_15965],_15906,_15908) --> 
    cc(på,_15906,_15930),
    not_look_ahead([om],_15931,_15930,_15948),
    !,
    reject(_15965,_15948,_15908).

rep_particlev(think,[rep_particlev,lit(på),_15931,!,_15965],_15906,_15908) --> 
    cc(på,_15906,_15930),
    not_look_ahead([at],_15931,_15930,_15948),
    !,
    reject(_15965,_15948,_15908).

rep_particlev(think,[rep_particlev,lit(på),!,_15929],_15899,_15901) --> 
    cc(på,_15899,_15923),
    !,
    accept(_15929,_15923,_15901).

particle(redundantly,[particle,_15905],_15891,_15893) --> 
    redundant(_15905,_15891,_15893).

particle(_15872,[particle,_15912,!],_15898,_15900) --> 
    w(adv(_15872),_15912,_15898,_15900),
    !.

particle(back,[particle,lit(tilbake)],_15893,_15895) --> 
    cc(tilbake,_15893,_15895).

particle(badly,[particle,lit(dårlig)],_15893,_15895) --> 
    cc(dårlig,_15893,_15895).

particle(beforethat,[particle,_15905],_15891,_15893) --> 
    beforethat(_15905,_15891,_15893).

particle(daily,[particle,lit(daglig)],_15893,_15895) --> 
    cc(daglig,_15893,_15895).

particle(day_after_tomorrow,[particle,lit(overimorgen)],_15893,_15895) --> 
    cc(overimorgen,_15893,_15895).

particle(directly,[particle,lit(direkte)],_15893,_15895) --> 
    cc(direkte,_15893,_15895).

particle(down,[particle,lit(ned)],_15893,_15895) --> 
    cc(ned,_15893,_15895).

particle(down,[particle,lit(under)],_15893,_15895) --> 
    cc(under,_15893,_15895).

particle(earlier,[particle,_15905],_15891,_15893) --> 
    earlier(_15905,_15891,_15893).

particle(early,[particle,lit(så),lit(tidlig),lit(som),_15964,!,_15998],_15917,_15919) --> 
    cc(så,_15917,_15941),
    cc(tidlig,_15941,_15952),
    cc(som,_15952,_15963),
    w(adj2(possible,nil),_15964,_15963,_15981),
    !,
    accept(_15998,_15981,_15919).

particle(early,[particle,lit(tidligst),_15932,!,_15966],_15907,_15909) --> 
    cc(tidligst,_15907,_15931),
    w(adj2(possible,nil),_15932,_15931,_15949),
    !,
    accept(_15966,_15949,_15909).

particle(early,[particle,lit(tidlig)],_15893,_15895) --> 
    cc(tidlig,_15893,_15895).

particle(early,[particle,lit(am)],_15893,_15895) --> 
    cc(am,_15893,_15895).

particle(eastward,[particle,lit(østover)],_15893,_15895) --> 
    cc(østover,_15893,_15895).

particle(everywhere,[particle,lit(overalt)],_15893,_15895) --> 
    cc(overalt,_15893,_15895).

particle(far,[particle,lit(langt)],_15893,_15895) --> 
    cc(langt,_15893,_15895).

particle(fast,[particle,lit(fort)],_15893,_15895) --> 
    cc(fort,_15893,_15895).

particle(fast,[particle,_15910],_15896,_15898) --> 
    w(adj2(fast,comp),_15910,_15896,_15898).

particle(from,[particle,lit(ifra)],_15893,_15895) --> 
    cc(ifra,_15893,_15895).

particle(gratis,[particle,lit(gratis)],_15893,_15895) --> 
    cc(gratis,_15893,_15895).

particle(home,[particle,lit(hjem),_15929,!,_15963],_15904,_15906) --> 
    cc(hjem,_15904,_15928),
    prep1(to,_15929,_15928,_15946),
    !,
    reject(_15963,_15946,_15906).

particle(home,[particle,_15910,lit(hjem)],_15896,_15898) --> 
    to0(_15910,_15896,_15925),
    cc(hjem,_15925,_15898).

particle(here,[particle,_15910,lit(hit)],_15896,_15898) --> 
    to0(_15910,_15896,_15925),
    cc(hit,_15925,_15898).

particle(here,[particle,_15910,lit(her)],_15896,_15898) --> 
    to0(_15910,_15896,_15925),
    cc(her,_15925,_15898).

particle(hereafter,[particle,_15905],_15891,_15893) --> 
    hereafter(_15905,_15891,_15893).

particle(in,[particle,lit(inn)],_15893,_15895) --> 
    cc(inn,_15893,_15895).

particle(in_morning,[particle,lit(ommorgenen)],_15893,_15895) --> 
    cc(ommorgenen,_15893,_15895).

particle(late,[particle,_15910,lit(sent)],_15896,_15898) --> 
    so0(_15910,_15896,_15925),
    cc(sent,_15925,_15898).

particle(late,[particle,_15910,lit(sent)],_15896,_15898) --> 
    too(_15910,_15896,_15925),
    cc(sent,_15925,_15898).

particle(lay,[particle,lit(ut)],_15893,_15895) --> 
    cc(ut,_15893,_15895).

particle(lay,[particle,lit(inn)],_15893,_15895) --> 
    cc(inn,_15893,_15895).

particle(lay,[particle,lit(ved)],_15893,_15895) --> 
    cc(ved,_15893,_15895).

particle(logically,[particle,lit(logisk)],_15893,_15895) --> 
    cc(logisk,_15893,_15895).

particle(much,[particle,_15910,lit(mye)],_15896,_15898) --> 
    so(_15910,_15896,_15925),
    cc(mye,_15925,_15898).

particle(normally,[particle,lit(normalt)],_15893,_15895) --> 
    cc(normalt,_15893,_15895).

particle(northward,[particle,lit(nordover)],_15893,_15895) --> 
    cc(nordover,_15893,_15895).

particle(now,[particle,_15905],_15891,_15893) --> 
    now1(_15905,_15891,_15893).

particle(now,[particle,_15912,lit(øyeblikket)],_15898,_15900) --> 
    prep1(for,_15912,_15898,_15929),
    cc(øyeblikket,_15929,_15900).

particle(on,[particle,_15907],_15893,_15895) --> 
    prep1(on,_15907,_15893,_15895).

particle(off,[particle,lit(av)],_15893,_15895) --> 
    cc(av,_15893,_15895).

particle(offside,[particle,_15908,_15932],_15894,_15896) --> 
    and0(_15908,_15894,_15923),
    compassly(_15932,_15923,_15896).

particle(often,[particle,_15910,lit(ofte)],_15896,_15898) --> 
    so0(_15910,_15896,_15925),
    cc(ofte,_15925,_15898).

particle(recently,[particle,_15905],_15891,_15893) --> 
    recently(_15905,_15891,_15893).

particle(out,[particle,lit(ut)],_15893,_15895) --> 
    cc(ut,_15893,_15895).

particle(past,[particle,lit(forbi)],_15893,_15895) --> 
    cc(forbi,_15893,_15895).

particle(present,[particle,lit(framme)],_15893,_15895) --> 
    cc(framme,_15893,_15895).

particle(punctually,[particle,lit(presis)],_15893,_15895) --> 
    cc(presis,_15893,_15895).

particle(punctually,[particle,_15910],_15896,_15898) --> 
    w(adj2(punctual,nil),_15910,_15896,_15898).

particle(punctually,[particle,_15912,lit(tide)],_15898,_15900) --> 
    prep1(in,_15912,_15898,_15929),
    cc(tide,_15929,_15900).

particle(regularly,[particle,lit(som),lit(normalt)],_15898,_15900) --> 
    cc(som,_15898,_15922),
    cc(normalt,_15922,_15900).

particle(silent,[particle,lit(stille)],_15893,_15895) --> 
    cc(stille,_15893,_15895).

particle(simultaneously,[particle,lit(samtidig)],_15893,_15895) --> 
    cc(samtidig,_15893,_15895).

particle(slowly,[particle,lit(langsomt)],_15893,_15895) --> 
    cc(langsomt,_15893,_15895).

particle(somewhere,[particle,lit(noensted)],_15893,_15895) --> 
    cc(noensted,_15893,_15895).

particle(southward,[particle,lit(sørover)],_15893,_15895) --> 
    cc(sørover,_15893,_15895).

particle(there,[particle,lit(dit)],_15893,_15895) --> 
    cc(dit,_15893,_15895).

particle(there,[particle,lit(der)],_15893,_15895) --> 
    cc(der,_15893,_15895).

particle(there,[particle,_15910],_15896,_15898) --> 
    w(adj2(present,nil),_15910,_15896,_15898).

particle(thereafter,[particle,_15905],_15891,_15893) --> 
    thereafter(_15905,_15891,_15893).

particle(this_midnight,[particle,lit(inatt)],_15893,_15895) --> 
    cc(inatt,_15893,_15895).

particle(today,[particle,lit(idag)],_15893,_15895) --> 
    cc(idag,_15893,_15895).

particle(together,[particle,lit(sammen)],_15893,_15895) --> 
    cc(sammen,_15893,_15895).

particle(tomorrow,[particle,lit(imorgen)],_15893,_15895) --> 
    cc(imorgen,_15893,_15895).

particle(tonight,[particle,lit(ikveld)],_15893,_15895) --> 
    cc(ikveld,_15893,_15895).

particle(up,[particle,lit(opp)],_15893,_15895) --> 
    cc(opp,_15893,_15895).

particle(well,[particle,lit(bra)],_15893,_15895) --> 
    cc(bra,_15893,_15895).

particle(well,[particle,lit(best)],_15893,_15895) --> 
    cc(best,_15893,_15895).

particle(well,[particle,lit(vel)],_15893,_15895) --> 
    cc(vel,_15893,_15895).

particle(westward,[particle,lit(vestover)],_15893,_15895) --> 
    cc(vestover,_15893,_15895).

particle(with1,[particle,lit(med),_15929],_15904,_15906) --> 
    cc(med,_15904,_15928),
    not_look_ahead(w(name(_15881,_15882,_15883)),_15929,_15928,_15906).

particle(wrongly,[particle,_15910,lit(feil)],_15896,_15898) --> 
    saa0(_15910,_15896,_15925),
    cc(feil,_15925,_15898).

particle(yesterday,[particle,lit(igår)],_15893,_15895) --> 
    cc(igår,_15893,_15895).

adjunct1(_15872,_15873,_15876::_15877,[adjunct1,{},_16020,_16049,_16073,{},!,_16117,!,_16178],_15990,_15992) --> 
    {user:_15872==nil},
    w(nb(_15910,_15911),_16020,_15990,_16037),
    point0(_16049,_16037,_16064),
    w(noun(_15915,_15916,u,n),_16073,_16064,_16090),
    {user:testmember(_15915,[year,month,week,day,hour,minute,second,mile,kilometer,meter])},
    !,
    lock(exact,_16090,_16137),pushstack(exact,(w(nb(_15910,num)),w(noun(_15915,sin,u,n))),nil,_16137,_16143),np0_accept(_15873,_15876::_15877,_16117,_16143,_16132),unlock(_16132,_16133),
    !,
    accept(_16178,_16133,_15992).

adjunct1(after,_15873,_15874,[adjunct1,_15943,lit(å),!,_15988],_15923,_15925) --> 
    w(prep(after),_15943,_15923,_15960),
    cc(å,_15960,_15982),
    !,
    lock(last,_15982,_16033),
    pushstack(last,([noen],aux1),nil,_16033,_16039),
    clausal_object1(_15873,_15874,_15988,_16039,_16028),
    unlock(_16028,_15925).

adjunct1(when,_15873,_15874,[adjunct1,lit(om),lit(når),!,_15960],_15913,_15915) --> 
    cc(om,_15913,_15943),
    cc(når,_15943,_15954),
    !,
    clausal_object1(_15873,_15874,_15960,_15954,_15915).

adjunct1(where,_15873,_15874,[adjunct1,lit(om),lit(hvor),!,_15960],_15913,_15915) --> 
    cc(om,_15913,_15943),
    cc(hvor,_15943,_15954),
    !,
    clausal_object1(_15873,_15874,_15960,_15954,_15915).

adjunct1(regarding,_15873,_15874,[adjunct1,lit(om),lit(at),!,_15960],_15913,_15915) --> 
    cc(om,_15913,_15943),
    cc(at,_15943,_15954),
    !,
    clausal_object1(_15873,_15874,_15960,_15954,_15915).

adjunct1(with,_15873,_15874,[adjunct1,lit(med),lit(det),lit(å),!,_15982],_15924,_15926) --> 
    cc(med,_15924,_15954),
    cc(det,_15954,_15965),
    cc(å,_15965,_15976),
    !,
    pushstack(first,(someone,aux1),nil,_15976,_16048),
    clausal_object1(_15873,_15874,_15982,_16048,_15926).

adjunct1(_15872,_15873,_15874,[adjunct1,lit(hva),!,_15941],_15905,_15907) --> 
    cc(hva,_15905,_15935),
    !,
    reject(_15941,_15935,_15907).

adjunct1(_15872,_15873,_15874,[adjunct1,_15935,_15964,!,_15998],_15915,_15917) --> 
    prep1(in,_15935,_15915,_15952),
    w(noun(morning,_15890,_15891,_15892),_15964,_15952,_15981),
    !,
    reject(_15998,_15981,_15917).

adjunct1(_15872,_15873,_15876::_15877,[adjunct1,{},!,_15952],_15917,_15919) --> 
    {user:_15872==nil},
    !,
    complement_nil(_15873,_15876::_15877,_15952,_15917,_15919).

adjunct1(ago,_15873,_15876::_15877,[adjunct1,_15972,_16001,_16030,lit(siden),!,_16075,!],_15952,_15954) --> 
    prep1(for,_15972,_15952,_15989),
    anumber(_15899,_16001,_15989,_16018),
    w(noun(_15903,_15904,u,n),_16030,_16018,_16047),
    cc(siden,_16047,_16069),
    !,
    lock(exact,_16069,_16125),pushstack(exact,(number(_15899),w(noun(_15903,plu,u,n))),nil,_16125,_16131),np0_accept(_15873,_15876::_15877,_16075,_16131,_16120),unlock(_16120,_15954),
    !.

adjunct1(after,_15873,_15876::_15877,[adjunct1,lit(om),_15985,_16014,_16043,!,_16077],_15954,_15956) --> 
    cc(om,_15954,_15984),
    anumber(_15909,_15985,_15984,_16002),
    w(noun(_15902,_15914,u,gen),_16014,_16002,_16031),
    w(noun(time,sin,u,n),_16043,_16031,_16060),
    !,
    pushstack(first,(number(_15909),w(noun(_15902,sin,u,n))),nil,_16060,_16117),
    np1(_15873,_15876::_15877,_16077,_16117,_15956).

adjunct1(in,_15873,_15874,[adjunct1,_15980,_16009,{},_16048,!,_16082],_15960,_15962) --> 
    prep(in,_15980,_15960,_15997),
    w(nb(_15899,num),_16009,_15997,_16026),
    {user:(1000=<_15899,_15899=<9999)},
    not_look_ahead(w(noun(time,_15925,_15926,_15927)),_16048,_16026,_16065),
    !,
    lock(exact,_16065,_16099),
    pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_15899,num))),nil,_16099,_16105),
    np1(_15873,_15874,_16082,_16105,_16094),
    unlock(_16094,_15962).

adjunct1(around,_15873,_15874,[adjunct1,_15966,{},_16005,_16029,_16063,_16087,!,_16121],_15946,_15948) --> 
    prep1(_15900,_15966,_15946,_15983),
    {user:testmember(_15900,[in,at,around])},
    ca0(_16005,_15983,_16020),
    clock_kernel(_15873,_15897,_16029,_16020,_16048),
    point0(_16063,_16048,_16078),
    not_look_ahead(w(noun(_15920,_15921,_15922,_15923)),_16087,_16078,_16104),
    !,
    raise_object00(_15897,_15874,_16121,_16104,_15948).

adjunct1(_15872,_15873,_15874,[adjunct1,lit(med),lit(en),lit(gang),!,_15973],_15915,_15917) --> 
    cc(med,_15915,_15945),
    cc(en,_15945,_15956),
    cc(gang,_15956,_15967),
    !,
    reject(_15973,_15967,_15917).

adjunct1(between,(_15888,_15889):clock,_15876::_15876 and _15882 and _15883,[adjunct1,_15967,_15996,_16020,_16054,_16078,_16102,!,_16141],_15947,_15949) --> 
    prep1(between,_15967,_15947,_15984),
    clock0(_15996,_15984,_16011),
    clock_kernel(_15888:clock,_15882,_16020,_16011,_16039),
    betwand0(_16054,_16039,_16069),
    clock0(_16078,_16069,_16093),
    clock_kernel(_15889:clock,_15883,_16102,_16093,_16121),
    !,
    accept(_16141,_16121,_15949).

adjunct1(between,_15873,_15874,[adjunct1,_15931,_15960,!,_15999],_15911,_15913) --> 
    prep1(between,_15931,_15911,_15948),
    noun_phrases2(_15873,_15874,_15960,_15948,_15979),
    !,
    accept(_15999,_15979,_15913).

adjunct1(_15872,_15873,_15874,[adjunct1,lit(om),_15951,!,_15980,{}],_15920,_15922) --> 
    cc(om,_15920,_15950),
    not_look_ahead_subject(_15951,_15950,_15966),
    !,
    np(_15873,_15874,_15980,_15966,_15922),
    {user:adjustprep(_15873,om,_15872)}.

adjunct1(_15872,_15873,_15874,[adjunct1,_15921],_15901,_15903) --> 
    pp(_15872,_15873,_15874,_15921,_15901,_15903).

adjunct1(_15872,_15873,_15874,[adjunct1,{},_15938],_15908,_15910) --> 
    {user:_15872==dir},
    noun_phrase1(_15873,_15874,_15938,_15908,_15910).

pp(on,_15873,_15874,[pp,_15930,lit(at),_15970],_15910,_15912) --> 
    prep(on,_15930,_15910,_15947),
    cc(at,_15947,_15969),
    clausal_object1(_15873,_15874,_15970,_15969,_15912).

pp(as,_15873,_15874,[pp,lit(som),_15956,!,_15990],_15925,_15927) --> 
    cc(som,_15925,_15955),
    look_ahead_lit([meg,deg,ham,henne,oss,dem],_15956,_15955,_15973),
    !,
    np(_15873,_15874,_15990,_15973,_15927).

pp(_15872,_15873,_15874,[pp,_15939,_15968,_15997,_16026],_15919,_15921) --> 
    look_ahead([om],_15939,_15919,_15956),
    prep(_15872,_15968,_15956,_15985),
    not_look_ahead([jeg],_15997,_15985,_16014),
    np(_15873,_15874,_16026,_16014,_15921).

pp(_15872,_15873,_15874,[pp,lit(før),lit(det),!,_15957],_15910,_15912) --> 
    cc(før,_15910,_15940),
    cc(det,_15940,_15951),
    !,
    reject(_15957,_15951,_15912).

pp(_15872,_15873,_15874,[pp,_15944,_15973,_16002,_16026,{}],_15924,_15926) --> 
    not_look_ahead_lit([om],_15944,_15924,_15961),
    prep(_15891,_15973,_15961,_15990),
    redundant0(_16002,_15990,_16017),
    object(_15873,_15874,_16026,_16017,_15926),
    {user:adjustprep(_15873,_15891,_15872)}.

pp(_15872,_15873,_15876::_15876 and _15880,[pp,_16007,{},_16046,_16075,_16104,_16138,_16167,_16196,!,_16230],_15987,_15989) --> 
    prep(_15872,_16007,_15987,_16024),
    {user:testmember(_15872,[before,after,around,to,over,within])},
    not_look_ahead([et],_16046,_16024,_16063),
    not_look_ahead([en],_16075,_16063,_16092),
    clock_kernel(_15873,_15880,_16104,_16092,_16123),
    not_look_ahead(w(noun(station,_15944,_15945,_15946)),_16138,_16123,_16155),
    not_look_ahead(w(noun(hour,_15953,_15954,_15955)),_16167,_16155,_16184),
    not_look_ahead(w(noun(minute,_15962,_15963,_15964)),_16196,_16184,_16213),
    !,
    accept(_16230,_16213,_15989).

complement_nil(_15872,_15873,[complement_nil,_15979,_16008,_16037,!,_16081,_16115],_15962,_15964) --> 
    w(nb(_15907,num),_15979,_15962,_15996),
    w(noun(minute,_15913,_15914,_15915),_16008,_15996,_16025),
    subjunction(_15917,time,_15919,_16037,_16025,_16058),
    !,
    clausal_object0(_15902,_15903,_16081,_16058,_16100),
    lock(exact,_16100,_16163),
    pushstack(exact,(w(nb(_15907,num)),w(noun(minute,plu,u,n)),w(prep(_15917)),xnp(_15902,_15903)),nil,_16163,_16169),
    np1(_15872,_15873,_16115,_16169,_16158),
    unlock(_16158,_15964).

complement_nil(_15872,_15873,[complement_nil,_15962,_15991,_16020,!,_16054],_15945,_15947) --> 
    w(nb(_15902,num),_15962,_15945,_15979),
    w(noun(minute,_15908,_15909,_15910),_15991,_15979,_16008),
    look_ahead(w(prep(_15916)),_16020,_16008,_16037),
    !,
    lock(exact,_16037,_16071),
    pushstack(exact,(w(nb(_15902,num)),w(noun(minute,_15896,_15897,_15898))),nil,_16071,_16077),
    noun_phrase1(_15872,_15873,_16054,_16077,_16066),
    unlock(_16066,_15947).

complement_nil(_15872,_15873,[complement_nil,_15914],_15897,_15899) --> 
    obviousclock(_15872,_15873,_15914,_15897,_15899).

complement_nil(_15872,_15873,[complement_nil,_15924,!,_15958],_15907,_15909) --> 
    w(prep(nil),_15924,_15907,_15941),
    !,
    noun_phrase1(_15872,_15873,_15958,_15941,_15909).

complement_nil(_15872,_15875::_15876,[complement_nil,_15968,{},!,_16012,_16036],_15951,_15953) --> 
    w(noun(_15898,_15906,_15907,n),_15968,_15951,_15985),
    {user:testmember(_15898,[nightbus,summerroute,winterroute])},
    !,
    accept(_16012,_15985,_16027),
    lock(exact,_16027,_16053),
    pushstack(exact,(w(prep(with)),w(noun(_15898,sin,u,n))),nil,_16053,_16059),
    adjunct1(_15921,_15872,_15875::_15876,_16036,_16059,_16048),
    unlock(_16048,_15953).

complement_nil(_15872,_15873,[complement_nil,_15954,_15983,_16012,_16041,_16070,!,_16104],_15937,_15939) --> 
    not_look_ahead(w(noun(street,sin,u,n)),_15954,_15937,_15971),
    not_look_ahead([den],_15983,_15971,_16000),
    not_look_ahead([det],_16012,_16000,_16029),
    not_look_ahead(w(prep(with)),_16041,_16029,_16058),
    pronoun1(_15916,_16070,_16058,_16087),
    !,
    reject(_16104,_16087,_15939).

complement_nil(_15872,_15875::_15875 and _15879,[complement_nil,_15920],_15903,_15905) --> 
    plausibleclock1(_15872,_15879,_15920,_15903,_15905).

complement_nil(_15872,_15875::_15876,[complement_nil,_15923,!],_15906,_15908) --> 
    obviousdate(_15872,_15875::_15876,_15923,_15906,_15908),
    !.

complement_nil(_15872,_15875::_15875 and _15879,[complement_nil,_15920],_15903,_15905) --> 
    plausibledate1(_15872,_15879,_15920,_15903,_15905).

complement_nil(_15872,_15875::_15876,[complement_nil,_15943,_15972,!,_16011],_15926,_15928) --> 
    look_ahead(w(adj2(_15897,nil)),_15943,_15926,_15960),
    gmem(_15897,[short,long],_15972,_15960,_15991),
    !,
    noun_phrase1(_15872,_15875::_15876,_16011,_15991,_15928).

complement_nil(_15872,_15873,[complement_nil,_15953,_15982,!,_16016],_15936,_15938) --> 
    w(nb(_15899,num),_15953,_15936,_15970),
    w(noun(time_count,_15893,_15894,_15895),_15982,_15970,_15999),
    !,
    lock(exact,_15999,_16033),
    pushstack(exact,(w(nb(_15899,num)),w(noun(time_count,_15893,_15894,_15895))),nil,_16033,_16039),
    np0(_15872,_15873,_16016,_16039,_16028),
    unlock(_16028,_15938).

complement_nil(_15872,_15873,[complement_nil,_15976,_16005,_16034,_16063,_16092,_16121,!,_16155],_15959,_15961) --> 
    not_look_ahead(w(name(_15900,_15901,_15902)),_15976,_15959,_15993),
    w(nb(_15906,num),_16005,_15993,_16022),
    not_look_ahead([ganger],_16034,_16022,_16051),
    not_look_ahead(w(noun(hour,_15918,_15919,_15920)),_16063,_16051,_16080),
    not_look_ahead(w(noun(minute,_15927,_15928,_15929)),_16092,_16080,_16109),
    not_look_ahead(w(noun(second,_15936,_15937,_15938)),_16121,_16109,_16138),
    !,
    reject(_16155,_16138,_15961).

complement_nil(_15872,_15873,[complement_nil,_15998,_16027,_16056,_16085,_16114,_16143,_16172,_16201,!],_15981,_15983) --> 
    not_look_ahead(w(nb(_15903,_15904)),_15998,_15981,_16015),
    not_look_ahead(w(_15908,name(_15908,_15912,month)),_16027,_16015,_16044),
    not_look_ahead_lit([sin,sitt,sine],_16056,_16044,_16073),
    not_look_ahead(w(noun(hour,plu,u,n)),_16085,_16073,_16102),
    not_look_ahead(w(noun(minute,plu,u,n)),_16114,_16102,_16131),
    not_look_ahead(w(noun(second,plu,u,n)),_16143,_16131,_16160),
    not_look_ahead(w(noun(room,_15955,u,n)),_16172,_16160,_16189),
    object(_15872,_15873,_16201,_16189,_15983),
    !.

complement1_accept(_15872,_15873,_15874,[complement1_accept,lit(idag),!,_15963,!],_15927,_15929) --> 
    cc(idag,_15927,_15957),
    !,
    pushstack(first,(prep(in),w(noun(day,sin,u,n))),nil,_15957,_16006),complement1_accept(_15872,_15873,_15874,_15963,_16006,_15929),
    !.

complement1_accept(_15872,_15873,_15876::_15877,[complement1_accept,_15965,{},_16004,_16033,_16062,!,_16101],_15945,_15947) --> 
    prep(_15872,_15965,_15945,_15982),
    {user:(\+testmember(_15872,[of,between]))},
    not_look_ahead([jeg],_16004,_15982,_16021),
    not_look_ahead([man],_16033,_16021,_16050),
    noun_phrase_accept(_15873,_15876::_15877,_16062,_16050,_16081),
    !,
    accept(_16101,_16081,_15947).

plausibledate1(_15875:date,_15875 isa date,[plausibledate1,_15995,{},_16034,_16058,{},_16097,_16121,{},!,_16165,{}],_15978,_15980) --> 
    num_na(_15916,_15995,_15978,_16012),
    {user:(_15916>=1000,_15916=<9999)},
    dashpoint0(_16034,_16012,_16049),
    num_na(_15917,_16058,_16049,_16075),
    {user:(_15917>=1,_15917=<12)},
    dashpoint0(_16097,_16075,_16112),
    num_na(_15918,_16121,_16112,_16138),
    {user:(_15918>=1,_15918=<31)},
    !,
    accept(_16165,_16138,_15980),
    {user:_15875=date(_15916,_15917,_15918)}.

plausibledate1(_15875:date,_15875 isa date,[plausibledate1,_15975,{},_16014,_16038,{},{},!,_16092,{}],_15958,_15960) --> 
    num_na(_15915,_15975,_15958,_15992),
    {user:_15915=<31},
    slashpoint0(_16014,_15992,_16029),
    num_na(_15914,_16038,_16029,_16055),
    {user:_15914=<12},
    {user:this_year(_15933)},
    !,
    accept(_16092,_16055,_15960),
    {user:(adjust_year(_15914,_15933,_15913),_15875=date(_15913,_15914,_15915))}.

obviousdate(_15872,_15875::_15878 and _15875,[obviousdate,_15920],_15903,_15905) --> 
    obviousdate1(_15872,_15878,_15920,_15903,_15905).

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15954,_15978,_16007,_16031,_16060,!,_16099,{}],_15937,_15939) --> 
    point0(_15954,_15937,_15969),
    dayno(_15909,_15978,_15969,_15995),
    slashpoint0(_16007,_15995,_16022),
    monthname(_15908,_16031,_16022,_16048),
    xyear0(_15908,_15907,_16060,_16048,_16079),
    !,
    accept(_16099,_16079,_15939),
    {user:_15875=date(_15907,_15908,_15909)}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15998,_16022,{},_16061,_16085,{},_16124,_16148,{},!,_16192,{}],_15981,_15983) --> 
    point0(_15998,_15981,_16013),
    num_na(_15919,_16022,_16013,_16039),
    {user:(_15919>=1000,_15919=<9999)},
    dashpoint0(_16061,_16039,_16076),
    num_na(_15920,_16085,_16076,_16102),
    {user:(_15920>=1,_15920=<12)},
    dashpoint0(_16124,_16102,_16139),
    num_na(_15921,_16148,_16139,_16165),
    {user:(_15921>=1,_15921=<31)},
    !,
    accept(_16192,_16165,_15983),
    {user:_15875=date(_15919,_15920,_15921)}.

obviousdate1(_15872,_15878 isa day and _15876,[obviousdate1,_15938,{},_15977,!,_16016],_15921,_15923) --> 
    dendagen(_15878,_15938,_15921,_15955),
    {user:dayname(_15878)},
    date(_15872,_15876,_15977,_15955,_15996),
    !,
    accept(_16016,_15996,_15923).

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15976,_16000,{},_16039,_16063,{},_16102,!,_16141,{}],_15959,_15961) --> 
    point0(_15976,_15959,_15991),
    num_na(_15915,_16000,_15991,_16017),
    {user:(_15915>=25,_15915=<31)},
    slash(_16039,_16017,_16054),
    num_na(_15914,_16063,_16054,_16080),
    {user:_15914=<12},
    xyear0(_15914,_15913,_16102,_16080,_16121),
    !,
    accept(_16141,_16121,_15961),
    {user:_15875=date(_15913,_15914,_15915)}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_16017,_16041,{},_16080,_16104,{},_16143,_16187,!,{}],_16000,_16002) --> 
    den0(_16017,_16000,_16032),
    num_na(_15926,_16041,_16032,_16058),
    {user:(_15926>=1,_15926=<7)},
    point0(_16080,_16058,_16095),
    w(name(_15941,n,date),_16104,_16095,_16121),
    {user:testmember(_15941,[easterday])},
    optional(w(noun(year,_15957,_15958,n)),_16143,_16121,_16175),
    w(nb(_15963,num),_16187,_16175,_16002),
    !,
    {user:(easterdate(_15963,_15922),_15963>=1000,_15963=<9999,_15923 is _15926-1,add_days(_15922,_15923,_15875))}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,{},_15987,{},_16026,!,{}],_15960,_15962) --> 
    {user:_15875=date(_15910,_15902,_15903)},
    w(name(_15898,n,date),_15987,_15960,_16004),
    {user:testmember(_15898,[christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day,may17])},
    year_expression(_15910,_16026,_16004,_15962),
    !,
    {user:named_date(_15898,date(_15901,_15902,_15903))}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_16021,_16045,{},_16084,_16108,{},_16147,_16176,!,{}],_16004,_16006) --> 
    den0(_16021,_16004,_16036),
    num_na(_15920,_16045,_16036,_16062),
    {user:(_15920>=1,_15920=<7)},
    point0(_16084,_16062,_16099),
    w(name(_15935,n,date),_16108,_16099,_16125),
    {user:testmember(_15935,[whitsun_day,easterday,christmas_day,new_years_day])},
    not_look_ahead(w(noun(year,_15957,_15958,_15959)),_16147,_16125,_16164),
    not_look_ahead(w(nb(_15965,num)),_16176,_16164,_16006),
    !,
    {user:(named_date(_15935,date(_15971,_15972,_15973)),_15917 is _15920-1,add_days(date(_15971,_15972,_15973),_15917,_15875))}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15989,{},_16028,_16057,!,{}],_15972,_15974) --> 
    w(name(_15898,n,date),_15989,_15972,_16006),
    {user:testmember(_15898,[whitsun_eve,whitsun_day,palm_sunday,maundy_thursday,good_friday,eastereve,easterday,christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day])},
    not_look_ahead(w(prep(in)),_16028,_16006,_16045),
    not_look_ahead(w(noun(year,_15949,_15950,_15951)),_16057,_16045,_15974),
    !,
    {user:named_date(_15898,_15875)}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15934,{},!],_15917,_15919) --> 
    w(name(_15889,n,date),_15934,_15917,_15919),
    {user:named_date(_15889,_15875)},
    !.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15946,{},_15985,{},!,_16029],_15929,_15931) --> 
    dendagen(_15896,_15946,_15929,_15963),
    {user:_15896\==nil},
    num_na(_15896,_15985,_15963,_16002),
    {user:numberdate(_15896,_15875)},
    !,
    accept(_16029,_16002,_15931).

obviousdate1(_15872,_15873,[obviousdate1,_15922,_15951,!],_15905,_15907) --> 
    dendagen(_15881,_15922,_15905,_15939),
    date(_15872,_15873,_15951,_15939,_15907),
    !.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15968,_15992,{},_16031,_16055,_16084,_16108,!,{}],_15951,_15953) --> 
    den(_15968,_15951,_15983),
    num_na(_15912,_15992,_15983,_16009),
    {user:(_15912>=1,_15912=<31)},
    slashpoint0(_16031,_16009,_16046),
    monthname(_15911,_16055,_16046,_16072),
    slashpoint0(_16084,_16072,_16099),
    xyear0(_15911,_15910,_16108,_16099,_15953),
    !,
    {user:_15875=date(_15910,_15911,_15912)}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15981,_16005,{},_16044,_16068,{},_16107,_16131,!,{}],_15964,_15966) --> 
    den0(_15981,_15964,_15996),
    num_na(_15915,_16005,_15996,_16022),
    {user:(_15915>=1,_15915=<31)},
    slashpoint0(_16044,_16022,_16059),
    month(_15914,_16068,_16059,_16085),
    {user:(_15914>=1,_15914=<12)},
    slashpoint0(_16107,_16085,_16122),
    year(_15913,_16131,_16122,_15966),
    !,
    {user:_15875=date(_15913,_15914,_15915)}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15954,_15983,_16012,_16041,!,{}],_15937,_15939) --> 
    not_look_ahead(w(nb(_15909,num)),_15954,_15937,_15971),
    month(_15902,_15983,_15971,_16000),
    num_na(_15903,_16012,_16000,_16029),
    year0(_15901,_16041,_16029,_15939),
    !,
    {user:_15875=date(_15901,_15902,_15903)}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15957,_15981,_16010,_16034,!,{}],_15940,_15942) --> 
    den(_15957,_15940,_15972),
    num_na(_15909,_15981,_15972,_15998),
    slashpoint(_16010,_15998,_16025),
    month(_15908,_16034,_16025,_15942),
    !,
    {user:(this_year(_15915),adjust_year(_15908,_15915,_15907),_15875=date(_15907,_15908,_15909))}.

obviousdate1(_15872,_15873,[obviousdate1,_15934,_15963,_15992,!,_16026],_15917,_15919) --> 
    dendagen(_15887,_15934,_15917,_15951),
    num_na(_15889,_15963,_15951,_15980),
    w(noun(_15893,plu,_15895,_15896),_15992,_15980,_16009),
    !,
    reject(_16026,_16009,_15919).

obviousdate1(_15872,_15873,[obviousdate1,lit(den),_15938,!,_15972],_15910,_15912) --> 
    cc(den,_15910,_15937),
    w(nb(_15888,ord),_15938,_15937,_15955),
    !,
    reject(_15972,_15955,_15912).

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,{},_15972,_16001,_16025,_16054,{}],_15945,_15947) --> 
    {user:value(busflag,true)},
    num_na(_15906,_15972,_15945,_15989),
    slashpoint0(_16001,_15989,_16016),
    num_na(_15905,_16025,_16016,_16042),
    slashpoint0(_16054,_16042,_15947),
    {user:(dedicated_date(date(_15904,_15905,_15906)),_15875=date(_15904,_15905,_15906))}.

obviousdate1(_15875:date,_15873,[obviousdate1,_15946,_15975,{},_16014,!,_16048],_15929,_15931) --> 
    dendagen(_15893,_15946,_15929,_15963),
    num_na(_15895,_15975,_15963,_15992),
    {user:(_15895>=1,_15895=<31)},
    colemin(_15908,_16014,_15992,_16031),
    !,
    reject(_16048,_16031,_15931).

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15985,{},_16024,{},_16063,_16087,!,{},{}],_15968,_15970) --> 
    dendagen(_15914,_15985,_15968,_16002),
    {user:_15914\==nil},
    num_na(_15912,_16024,_16002,_16041),
    {user:(_15912>=1,_15912=<31)},
    point(_16063,_16041,_16078),
    not_look_ahead(w(nb(_15938,_15939)),_16087,_16078,_15970),
    !,
    {user:todaysdate(date(_15910,_15911,_15947))},
    {user:_15875=date(_15910,_15911,_15912)}.

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,lit(den),_15949,{},!,_15993],_15921,_15923) --> 
    cc(den,_15921,_15948),
    num_na(_15895,_15949,_15948,_15966),
    {user:numberdate(_15895,_15875)},
    !,
    accept(_15993,_15966,_15923).

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15953,{},_15992,{},!,_16036],_15936,_15938) --> 
    num_na(_15896,_15953,_15936,_15970),
    {user:_15896>=10101},
    not_look_ahead(w(noun(_15907,plu,_15909,_15910)),_15992,_15970,_16009),
    {user:numberdate(_15896,_15875)},
    !,
    accept(_16036,_16009,_15938).

obviousdate1(_15875:date,_15875 isa date,[obviousdate1,_15953,{},_15992,{},!,_16036],_15936,_15938) --> 
    num_na(_15896,_15953,_15936,_15970),
    {user:_15896>=2501},
    not_look_ahead(w(noun(_15907,plu,_15909,_15910)),_15992,_15970,_16009),
    {user:numberdate(_15896,_15875)},
    !,
    accept(_16036,_16009,_15938).

year_expression(_15872,[year_expression,_15942,_15986,_16030,{},!],_15928,_15930) --> 
    optional(w(prep(in)),_15942,_15928,_15974),
    optional(w(noun(year,sin,u,n)),_15986,_15974,_16018),
    w(nb(_15872,num),_16030,_16018,_15930),
    {user:_15872=<9999},
    !.

year_expression(_15872,[year_expression,_15924,!,{}],_15910,_15912) --> 
    lastyear(_15924,_15910,_15912),
    !,
    {user:(this_year(_15888),_15872 is _15888-1)}.

year_expression(_15872,[year_expression,_15924,!,{}],_15910,_15912) --> 
    nextyear(_15924,_15910,_15912),
    !,
    {user:(this_year(_15888),_15872 is _15888+1)}.

lastyear([lastyear,_15917,lit(siste),_15972],_15906,_15908) --> 
    optional([i],_15917,_15906,_15949),
    cc(siste,_15949,_15971),
    w(noun(year,sin,_15882,n),_15972,_15971,_15908).

lastyear([lastyear,_15912,_15956],_15901,_15903) --> 
    optional([i],_15912,_15901,_15944),
    w(noun(lastyear,sin,_15879,n),_15956,_15944,_15903).

lastyear([lastyear,lit(ifjor),!],_15892,_15894) --> 
    cc(ifjor,_15892,_15894),
    !.

nextyear([nextyear,_15917,lit(neste),_15972],_15906,_15908) --> 
    optional([i],_15917,_15906,_15949),
    cc(neste,_15949,_15971),
    w(noun(year,sin,u,n),_15972,_15971,_15908).

plausibleclock(_15872,_15875::_15875 and _15879,[plausibleclock,_15933,!,_15967],_15916,_15918) --> 
    look_ahead(w(nb(_15894,_15895)),_15933,_15916,_15950),
    !,
    clock_sequel(_15872,_15879,_15967,_15950,_15918).

plausibleclock1(_15875:clock,_15875 isa clock,[plausibleclock1,_15987,{},_16026,_16050,_16079,_16123,_16152,{},!],_15970,_15972) --> 
    w(nb(_15907,num),_15987,_15970,_16004),
    {user:(_15907>=1,_15907=<24)},
    point0(_16026,_16004,_16041),
    w(nb(_15923,num),_16050,_16041,_16067),
    optional(['.'],_16079,_16067,_16111),
    not_look_ahead(w(nb(_15934,_15935)),_16123,_16111,_16140),
    not_look_ahead(w(name(_15941,_15942,month)),_16152,_16140,_15972),
    {user:plausibleclocktest(_15907,_15923,_15875)},
    !.

obviousclock(_15872,_15873,[obviousclock,_15944,_15973,_15997,{},!,_16041],_15927,_15929) --> 
    w(nb(_15892,num),_15944,_15927,_15961),
    pointNO(_15973,_15961,_15988),
    w(nb(_15897,num),_15997,_15988,_16014),
    {user:dedicated_date(date(_15904,_15897,_15892))},
    !,
    reject(_16041,_16014,_15929).

obviousclock(_15872,_15875::_15875 and _15879,[obviousclock,_15920],_15903,_15905) --> 
    obviousclock1(_15872,_15879,_15920,_15903,_15905).

obviousclock1(_15872,_15873,[obviousclock1,_15920,!,_15949],_15903,_15905) --> 
    clock(_15920,_15903,_15935),
    !,
    clock_sequel(_15872,_15873,_15949,_15935,_15905).

obviousclock1(_15872,_15873,[obviousclock1,_15930,_15964,!,_15998],_15913,_15915) --> 
    clock_kernel(_15872,_15873,_15930,_15913,_15949),
    w(noun(time,sin,def,n),_15964,_15949,_15981),
    !,
    accept(_15998,_15981,_15915).

obviousclock1(_15875:clock,_15875 isa clock,[obviousclock1,_16018,_16047,_16076,{},_16115,_16144,_16173,_16202,_16231,_16260,!,_16309],_16001,_16003) --> 
    not_look_ahead(w(name(_15918,n,route)),_16018,_16001,_16035),
    not_look_ahead(w(name(_15926,n,nightbus)),_16047,_16035,_16064),
    w(nb(_15875,num),_16076,_16064,_16093),
    {user:(_15875>=100,clock_test(_15875))},
    not_look_ahead([-],_16115,_16093,_16132),
    not_look_ahead(w(nb(_15953,_15954)),_16144,_16132,_16161),
    not_look_ahead(w(noun(_15960,plu,_15962,_15963)),_16173,_16161,_16190),
    not_look_ahead([tusen],_16202,_16190,_16219),
    not_look_ahead([millioner],_16231,_16219,_16248),
    optional(w(noun(time,sin,def,n)),_16260,_16248,_16292),
    !,
    accept(_16309,_16292,_16003).

obviousclock1(_15875:clock,_15875 isa clock,[obviousclock1,_15919],_15902,_15904) --> 
    time2(_15875,_15919,_15902,_15904).

obviousclock1(_15875:clock,_15875 isa clock,[obviousclock1,_15926,_15955],_15909,_15911) --> 
    hours100(_15875,_15926,_15909,_15943),
    look_ahead([om],_15955,_15943,_15911).

rel_clauses(_15872,_15873,_15874,[rel_clauses,lit(hva),!,_15941],_15905,_15907) --> 
    cc(hva,_15905,_15935),
    !,
    reject(_15941,_15935,_15907).

rel_clauses(_15872,_15873,_15873 and _15877,[rel_clauses,_15961,lit(det),_15996,_16087],_15941,_15943) --> 
    derhvor(_15961,_15941,_15976),
    cc(det,_15976,_15995),
    lock(exact,_15995,_16046),pushstack(exact,(w(prep(in)),npgap(_15872)),nil,_16046,_16052),adverbial1(_15894,_15895,_15896,_15996,_16052,_16041),unlock(_16041,_16042),
    lock(last,_16042,_16136),
    pushstack(last,([det],xadverbial1(_15894,_15895,_15896)),nil,_16136,_16142),
    substatement1(_15877,_16087,_16142,_16131),
    unlock(_16131,_15943).

rel_clauses(_15872,_15873,_15873 and _15877,[rel_clauses,_15982,_16011,_16040,!,_16074],_15962,_15964) --> 
    w(noun(_15907,_15908,_15909,n),_15982,_15962,_15999),
    w(verb(apply,_15915,fin),_16011,_15999,_16028),
    w(prep(_15920),_16040,_16028,_16057),
    !,
    pushstack(first,(w(noun(_15907,_15908,_15909,n)),w(verb(apply,_15915,fin)),w(prep(_15920)),npgap(_15872)),nil,_16057,_16114),
    statreal(_15877,_16074,_16114,_15964).

rel_clauses(_15872,_15873,_15874,[rel_clauses,_15949,_15983],_15929,_15931) --> 
    lit_of(_15884,[jeg,hun,han,vi,man,du],_15949,_15929,_15968),
    pushstack(first,([som],[_15884]),nil,_15968,_15993),
    rel_clause(_15872,_15873,_15874,_15983,_15993,_15931).

rel_clauses(_15872,_15873,_15873 and _15877,[rel_clauses,_15961,lit(det),_15996,_16087],_15941,_15943) --> 
    derhvor(_15961,_15941,_15976),
    cc(det,_15976,_15995),
    lock(exact,_15995,_16046),pushstack(exact,(w(prep(in)),npgap(_15872)),nil,_16046,_16052),adverbial1(_15894,_15895,_15896,_15996,_16052,_16041),unlock(_16041,_16042),
    lock(last,_16042,_16136),
    pushstack(last,([det],xadverbial1(_15894,_15895,_15896)),nil,_16136,_16142),
    substatement1(_15877,_16087,_16142,_16131),
    unlock(_16131,_15943).

rel_clauses(_15872,_15873,_15873 and _15877,[rel_clauses,_15949,_15973,_16007],_15929,_15931) --> 
    derhvor(_15949,_15929,_15964),
    subject(_15896,_15897,_15973,_15964,_15992),
    lock(last,_15992,_16085),
    pushstack(last,(xnp(_15896,_15897),w(prep(in)),npgap(_15872)),nil,_16085,_16091),
    statreal(_15877,_16007,_16091,_16080),
    unlock(_16080,_15931).

rel_clauses(_15872,_15873,_15874,[rel_clauses,lit(som),_15982,_16006,_16035,_16069,!,[],_16159],_15951,_15953) --> 
    cc(som,_15951,_15981),
    danow0(_15982,_15981,_15997),
    look_ahead(w(prep(_15908)),_16006,_15997,_16023),
    gmem(_15908,[of],_16035,_16023,_16054),
    adverbix(_15915,_15916,_15917,_16069,_16054,_16090),
    !,
    pushstack(free,xadverbial1(_15915,_15916,_15917),nil,_16090,_16158),[],
    pushstack(first,[som],nil,_16158,_16169),
    rel_clause(_15872,_15873,_15874,_16159,_16169,_15953).

rel_clauses(_15872,_15873,_15874,[rel_clauses,_15928,_15967],_15908,_15910) --> 
    rel_clause(_15872,_15873,_15880,_15928,_15908,_15949),
    rel_clauses0(_15872,_15880,_15874,_15967,_15949,_15910).

rel_clauses0(_15872,_15873,_15874,[rel_clauses0,_15924,_15948],_15904,_15906) --> 
    and1x(_15924,_15904,_15939),
    rel_clauses(_15872,_15873,_15874,_15948,_15939,_15906).

rel_clauses0(_15872,_15873,_15873,[rel_clauses0,[]],_15897,_15897) --> 
    [].

derhvor([derhvor,_15909,!],_15898,_15900) --> 
    one_of_lit([der,hvor,dit],_15909,_15898,_15900),
    !.

and1x([and1x,_15898],_15887,_15889) --> 
    and1(_15898,_15887,_15889).

and1x([and1x,_15902],_15891,_15893) --> 
    look_ahead([som],_15902,_15891,_15893).

dvs([dvs,lit(dvs)],_15889,_15891) --> 
    cc(dvs,_15889,_15891).

dvs([dvs,lit(altså)],_15889,_15891) --> 
    cc(altså,_15889,_15891).

dvs([dvs,lit(a),lit(la)],_15894,_15896) --> 
    cc(a,_15894,_15915),
    cc(la,_15915,_15896).

rel_clause(_15872,_15873,_15873 and _15877,[rel_clause,_15942,!,_15971],_15922,_15924) --> 
    dvs(_15942,_15922,_15957),
    !,
    lock(last,_15957,_16018),
    pushstack(last,(npgap(_15872),w(verb(be,pres,fin))),nil,_16018,_16024),
    statreal(_15877,_15971,_16024,_16013),
    unlock(_16013,_15924).

rel_clause(_15872,_15873,_15873 and _15877,[rel_clause,_15972,_16001,!,_16040],_15952,_15954) --> 
    w(verb(_15901,past,part),_15972,_15952,_15989),
    gmem(_15901,[adapt,label,be_named,register],_16001,_15989,_16020),
    !,
    lock(last,_16020,_16087),
    pushstack(last,(w(noun(agent,sin,u,n)),w(verb(_15901,past,fin)),npgap(_15872)),nil,_16087,_16093),
    statreal(_15877,_16040,_16093,_16082),
    unlock(_16082,_15954).

rel_clause(_15872,_15873,_15873 and _15877,[rel_clause,_15965,_15994,_16028,!,_16057],_15945,_15947) --> 
    rel(_15872,_15965,_15945,_15982),
    lit_of(_15901,[du,jeg,de,han,hun,vi,dere,man],_15994,_15982,_16013),
    look_ahead_vp(_16028,_16013,_16043),
    !,
    lock(last,_16043,_16104),
    pushstack(last,([_15901],npgap(_15872)),nil,_16104,_16110),
    statreal(_15877,_16057,_16110,_16099),
    unlock(_16099,_15947).

rel_clause(_15872,_15873,_15873 and _15877,[rel_clause,_15939,_15968,_15997],_15919,_15921) --> 
    rel(_15872,_15939,_15919,_15956),
    not_look_ahead([at],_15968,_15956,_15985),
    pushstack(free,npgap(_15872),nil,_15985,_16037),
    statreal(_15877,_15997,_16037,_15921).

rel_clause(_15872,_15873,_15873 and _15877,[rel_clause,_15945,lit(det),!,_15990],_15925,_15927) --> 
    rel(_15872,_15945,_15925,_15962),
    cc(det,_15962,_15984),
    !,
    lock(last,_15984,_16037),
    pushstack(last,([det],npgap(_15872)),nil,_16037,_16043),
    statreal(_15877,_15990,_16043,_16032),
    unlock(_16032,_15927).

relneg(_15872,[relneg,_15913,_15937,!],_15899,_15901) --> 
    relblabla(_15913,_15899,_15928),
    negation0(_15872,_15937,_15928,_15901),
    !.

relneg(_15872,[relneg,_15913,_15942,!],_15899,_15901) --> 
    negation0(_15872,_15913,_15899,_15930),
    relblabla(_15942,_15930,_15901),
    !.

relblabla([relblabla,lit(nå),!],_15892,_15894) --> 
    cc(nå,_15892,_15894),
    !.

relblabla([relblabla,lit(bare),!],_15892,_15894) --> 
    cc(bare,_15892,_15894),
    !.

relblabla([relblabla,_15898],_15887,_15889) --> 
    redundant0(_15898,_15887,_15889).

whose_noun(_15872,_15873,[whose_noun,_15921,_15945],_15904,_15906) --> 
    whose(_15921,_15904,_15936),
    noun(_15878,_15879,u,n,_15872,_15873,_15945,_15936,_15906).

relwhat(_15872,[relwhat,_15922,_15946,{},!,_15985],_15908,_15910) --> 
    hva(_15922,_15908,_15937),
    som0(_15946,_15937,_15961),
    {user:constrain(_15872,thing)},
    !,
    accept(_15985,_15961,_15910).

relwhat(_15872,[relwhat,lit(hvem),_15935,{},!,_15974],_15910,_15912) --> 
    cc(hvem,_15910,_15934),
    som0(_15935,_15934,_15950),
    {user:constrain(_15872,agent)},
    !,
    accept(_15974,_15950,_15912).

rel(_15872,[rel,_15937,_15966,_15995,{},!,_16054],_15923,_15925) --> 
    relpron(_15889,_15937,_15923,_15954),
    not_look_ahead(w(quote(_15895)),_15966,_15954,_15983),
    optional([nå],_15995,_15983,_16027),
    {user:constrain(_15872,_15889)},
    !,
    accept(_16054,_16027,_15925).

comparisons(_15872,_15873,_15874,[comparisons,_15929,_15968],_15909,_15911) --> 
    comparison(_15872,_15873,_15881,_15929,_15909,_15950),
    comparisons0(_15872,_15873,_15881,_15874,_15968,_15950,_15911).

comparisons0(_15872,_15873,_15874,_15874 and _15878,[comparisons0,_15941,_15965,_16004],_15918,_15920) --> 
    and1(_15941,_15918,_15956),
    comparison(_15872,_15873,_15888,_15965,_15956,_15986),
    comparisons0(_15872,_15873,_15888,_15878,_16004,_15986,_15920).

comparisons0(_15872,_15873,_15874,_15874,[comparisons0,[]],_15900,_15900) --> 
    [].

comparison(_15872,_15873,_15874,[comparison,{},{},_15981,!,{}],_15941,_15943) --> 
    {user:vartypeid(_15872,_15899)},
    {user:testmember(_15899,[speed,price,name,description])},
    np1_accept(_15893,_15894::_15874,_15981,_15941,_15943),
    !,
    {user:compare(eq,thing,_15872,_15893,_15894)}.

comparison(_15872,_15873,_15874,[comparison,_15954,{},{},{},!,_16018],_15934,_15936) --> 
    comparator1(_15891,_15954,_15934,_15971),
    {user:_15891==gt},
    {user:vartype(_15872,_15901,_15902)},
    {user:testmember(_15902,[information,minute])},
    !,
    reject(_16018,_15971,_15936).

comparison(_15872,_15873,_15874,[comparison,_15951,{},_15990,{}],_15931,_15933) --> 
    comparator1(_15887,_15951,_15931,_15968),
    {user:testmember(_15887,[eq,ne])},
    noun_phrase1(_15890,_15891::_15874,_15990,_15968,_15933),
    {user:compare(_15887,thing,_15872,_15890,_15891)}.

comparison(_15872,_15873,_15874,[comparison,_15955,{},_15994,{}],_15935,_15937) --> 
    comparator1(_15887,_15955,_15935,_15972),
    {user:testmember(_15887,[gt,ge,le,lt])},
    noun_phrase1(_15890,_15891::_15874,_15994,_15972,_15937),
    {user:compare(_15887,number,_15872,_15890,_15891)}.

comparison(_15872,_15873,_15874,[comparison,_15940,_15974,{}],_15920,_15922) --> 
    comparator2(_15884,_15885,_15940,_15920,_15959),
    noun_phrase1(_15887,_15888::_15874,_15974,_15959,_15922),
    {user:compare(_15884,_15885,_15872,_15887,_15888)}.

comparison(_15872,_15873,_15874,[comparison,_15940,_15974,{}],_15920,_15922) --> 
    comparator3(_15884,_15885,_15940,_15920,_15959),
    noun_phrase1(_15887,_15888::_15874,_15974,_15959,_15922),
    {user:comparad(_15884,_15885,_15872,_15887,_15888)}.

np(_15872,_15873,[np,_15914],_15897,_15899) --> 
    xnp(_15872,_15873,_15914,_15897,_15899).

np(_15872,_15875::_15876,[np,_15920],_15903,_15905) --> 
    noun_phrases(_15872,_15875::_15876,_15920,_15903,_15905).

np(_15872,_15875::_15875,[np,_15916],_15899,_15901) --> 
    npgap(_15872,_15916,_15899,_15901).

np0_accept(_15872,_15875::_15876,[np0_accept,_15926,!,_15965],_15909,_15911) --> 
    np0(_15872,_15875::_15876,_15926,_15909,_15945),
    !,
    accept(_15965,_15945,_15911).

np00(_15872,_15885:_15872,_15876::exists(_15885:_15872)::_15885 isa _15872 and _15876,[np00,[]],_15917,_15917) --> 
    [].

raise_object00(_15872,_15875::_15875 and _15872,[raise_object00,[]],_15900,_15900) --> 
    [].

subject(_15872,_15873,[subject,_15957,_15986,_16015,_16044],_15940,_15942) --> 
    not_look_ahead(w(name(være,n,_15893)),_15957,_15940,_15974),
    not_look_ahead(w(name(norwegian,n,language)),_15986,_15974,_16003),
    not_look_ahead_lit([meg,deg,ham,henne,seg,oss,dem,det],_16015,_16003,_16032),
    np(_15872,_15873,_16044,_16032,_15942).

object1(_15872,_15873,[object1,_15932,_15961,!],_15915,_15917) --> 
    not_look_ahead_lit([jeg,du,han,hun,vi],_15932,_15915,_15949),
    np0(_15872,_15873,_15961,_15949,_15917),
    !.

object(_15872,_15873,[object,_15917,_15941],_15900,_15902) --> 
    not_look_ahead_subject(_15917,_15900,_15932),
    noun_phrase_accept(_15872,_15873,_15941,_15932,_15902).

ind_object(_15872,_15873,[ind_object,_15917,_15941],_15900,_15902) --> 
    not_look_ahead_subject(_15917,_15900,_15932),
    noun_phrase_accept(_15872,_15873,_15941,_15932,_15902).

not_look_ahead_time([not_look_ahead_time,_15904,!,_15933],_15893,_15895) --> 
    look_ahead_time(_15904,_15893,_15919),
    !,
    reject(_15933,_15919,_15895).

look_ahead_time([look_ahead_time,_15903],_15892,_15894) --> 
    w(nb(_15874,_15875),_15903,_15892,_15894).

look_ahead_time([look_ahead_time,_15904],_15893,_15895) --> 
    one_of_lit([halv,kvart],_15904,_15893,_15895).

look_ahead_time([look_ahead_time,_15916,{},!],_15905,_15907) --> 
    w(noun(_15880,_15881,_15882,_15883),_15916,_15905,_15907),
    {user:subclass0(_15880,time)},
    !.

not_look_ahead_subject([not_look_ahead_subject,_15904,!,_15933],_15893,_15895) --> 
    look_ahead_subject(_15904,_15893,_15919),
    !,
    reject(_15933,_15919,_15895).

not_look_ahead_subject([not_look_ahead_subject,[]],_15887,_15887) --> 
    [].

look_ahead_subject([look_ahead_subject,_15912],_15901,_15903) --> 
    look_ahead_lit([jeg,du,han,hun,vi,man],_15912,_15901,_15903).

subject2(_15872,_15873,_15874,[subject2,_15927,!,_15971],_15907,_15909) --> 
    noun_phrase2(_15872,_15873,_15874,_15927,_15907,_15948),
    !,
    accept(_15971,_15948,_15909).

object2hnn(_15872,_15873,_15874,[object2hnn,_15957,_15986,_16015,_16044,!,_16078],_15937,_15939) --> 
    w(name(_15893,_15894,_15895),_15957,_15937,_15974),
    not_look_ahead(w(prep(on)),_15986,_15974,_16003),
    not_look_ahead(w(noun(_15907,_15908,_15909,_15910)),_16015,_16003,_16032),
    not_look_ahead([deg],_16044,_16032,_16061),
    !,
    reject(_16078,_16061,_15939).

object2hnn(_15872,_15873,_15874,[object2hnn,_15927,!,_15971],_15907,_15909) --> 
    object2h(_15872,_15873,_15874,_15927,_15907,_15948),
    !,
    accept(_15971,_15948,_15909).

object2h(_15872,_15873,_15874,[object2h,lit(dere),!,_15941],_15905,_15907) --> 
    cc(dere,_15905,_15935),
    !,
    reject(_15941,_15935,_15907).

object2h(_15872,_15873,_15874,[object2h,_15921],_15901,_15903) --> 
    object2(_15872,_15873,_15874,_15921,_15901,_15903).

object2(_15872,_15873,_15874,[object2,lit(en),lit(gang),!,_15957],_15910,_15912) --> 
    cc(en,_15910,_15940),
    cc(gang,_15940,_15951),
    !,
    reject(_15957,_15951,_15912).

object2(_15872,_15873,_15874,[object2,_15939,_15963,{},!,_16012],_15919,_15921) --> 
    which(_15939,_15919,_15954),
    np(_15873,_15874,_15963,_15954,_15982),
    {user:(\+vartypeid(_15873,place))},
    !,
    accept(_16012,_15982,_15921).

object2(_15872,_15872,_15876::_15876 and _15880,[object2,_15937,_15966,!,_15995],_15917,_15919) --> 
    prep1(around,_15937,_15917,_15954),
    clock(_15966,_15954,_15981),
    !,
    clock_kernel(_15872,_15880,_15995,_15981,_15919).

object2(_15872,_15873,_15876::_15877,[object2,_15934,_15963],_15914,_15916) --> 
    not_look_ahead_lit([middag],_15934,_15914,_15951),
    noun_phrase2(_15872,_15873,_15876::_15877,_15963,_15951,_15916).

object2(_15872,_15873,_15874,[object2,_15940,_15969,!,_16003],_15920,_15922) --> 
    one_of_lit([jeg,du,hun,vi],_15940,_15920,_15957),
    not_look_ahead([som],_15969,_15957,_15986),
    !,
    reject(_16003,_15986,_15922).

noun_phrase2(_15872,_15873,_15876::_15876 and _15880,[noun_phrase2,_15942,!,_15976,_16000],_15922,_15924) --> 
    look_ahead([hvor],_15942,_15922,_15959),
    !,
    accept(_15976,_15959,_15991),
    adverbial_noun_phrase1(_15873,_15876::_15880,_16000,_15991,_15924).

noun_phrase2(_15872,_15872,_15876::_15877,[noun_phrase2,_15936,_15965],_15916,_15918) --> 
    recipron(_15887,_15936,_15916,_15953),
    pushstack(first,npgap(_15872),nil,_15953,_16005),
    noun_phrase1(_15872,_15876::_15877,_15965,_16005,_15918).

noun_phrase2(_15872,_15873,_15876::findalt(diff,_15872,_15873)::_15882 and _15876,[noun_phrase2,_15948,_15972,_16026],_15928,_15930) --> 
    another(_15948,_15928,_15963),
    noun(_15900,sin,u,n,_15873,_15897,_15972,_15963,_15999),
    noun_modsx0(0,_15873,_15897,_15882,_16026,_15999,_15930).

noun_phrase2(_15872,_15873,_15874,[noun_phrase2,_15951,_15980,_16009,!,_16043],_15931,_15933) --> 
    not_look_ahead(w(noun(_15892,_15893,_15894,_15895)),_15951,_15931,_15968),
    not_look_ahead(w(adj2(_15901,_15902)),_15980,_15968,_15997),
    w(verb(_15906,past,part),_16009,_15997,_16026),
    !,
    reject(_16043,_16026,_15933).

noun_phrase2(_15872,_15873,_15874,[noun_phrase2,_15930,!,_15964],_15910,_15912) --> 
    look_ahead([hva],_15930,_15910,_15947),
    !,
    np(_15873,_15874,_15964,_15947,_15912).

noun_phrase2(_15872,_15873,_15874,[noun_phrase2,_15930,_15959,_15983],_15910,_15912) --> 
    not_look_ahead([hva],_15930,_15910,_15947),
    which0(_15959,_15947,_15974),
    np(_15873,_15874,_15983,_15974,_15912).

adverbial_noun_phrase1(_15872,_15875::_15875 and _15879,[adverbial_noun_phrase1,lit(hvor),_15982,_16011,!,_16077],_15954,_15956) --> 
    cc(hvor,_15954,_15981),
    not_look_ahead([mye],_15982,_15981,_15999),
    lock(exact,_15999,_16031),pushstack(exact,(w(prep(in)),w(noun(place,sin,u,n))),nil,_16031,_16037),adverbial1(_15896,_15872,_15900::_15901,_16011,_16037,_16026),unlock(_16026,_16027),
    !,
    lock(last,_16027,_16129),
    pushstack(last,adverbial1(_15896,_15872,_15900::_15901),nil,_16129,_16135),
    statreal(_15879,_16077,_16135,_16124),
    unlock(_16124,_15956).

noun_phrase_accept(_15872,_15873,[noun_phrase_accept,_15920,!,_15959],_15903,_15905) --> 
    np(_15872,_15873,_15920,_15903,_15939),
    !,
    accept(_15959,_15939,_15905).

np1_accept(_15872,_15873,[np1_accept,_15920,!,_15959],_15903,_15905) --> 
    noun_phrase1(_15872,_15873,_15920,_15903,_15939),
    !,
    accept(_15959,_15939,_15905).

noun_phrases2(_15872,_15875::_15878 and _15879,[noun_phrases2,_15951,_15985,_16009,{},!,_16058],_15934,_15936) --> 
    np1_accept(_15896,_15875::_15878,_15951,_15934,_15970),
    and0(_15985,_15970,_16000),
    np1_accept(_15902,_15875::_15879,_16009,_16000,_16028),
    {user:latin(and,_15896,_15902,_15872)},
    !,
    accept(_16058,_16028,_15936).

noun_phrases(_15872,_15875::_15878 and _15881 and _15882,[noun_phrases,_15990,_16019,{},{},_16073,_16107,{},!,_16156],_15973,_15975) --> 
    look_ahead(w(noun(distance,sin,def,n)),_15990,_15973,_16007),
    noun_phrase1(_15917,_15875::_15878,_16019,_16007,_16038),
    {user:vartypeid(_15917,_15926)},
    {user:testmember(_15926,[distance])},
    noun_phrase1(_15935,_15875::_15881,_16073,_16038,_16092),
    noun_phrase1(_15941,_15875::_15882,_16107,_16092,_16126),
    {user:latin(and,_15935,_15941,_15872)},
    !,
    accept(_16156,_16126,_15975).

noun_phrases(_15872,_15875::_15876,[noun_phrases,_15937,_15971,!,_16020],_15920,_15922) --> 
    noun_phrase1(_15887,_15875::_15891,_15937,_15920,_15956),
    noun_phrases0(_15887,_15872,true::_15891,_15876,_15971,_15956,_15994),
    !,
    accept(_16020,_15994,_15922).

noun_phrases0(_15872,_15872,_15877::_15875,_15875,[noun_phrases0,{},!],_15911,_15911) --> 
    {user:constrain(_15872,number)},
    !.

noun_phrases0(_15872,_15872,_15877::_15875,_15875,[noun_phrases0,_15936,!],_15913,_15915) --> 
    look_ahead(w(nb(_15887,_15888)),_15936,_15913,_15915),
    !.

noun_phrases0(_15872,_15872,_15877::_15875,_15875,[noun_phrases0,_15935,!],_15912,_15914) --> 
    look_ahead_lit([etc,samme],_15935,_15912,_15914),
    !.

noun_phrases0(_15872,_15872,_15877::_15875,_15875,[noun_phrases0,_15949,{},!],_15926,_15928) --> 
    look_ahead(w(verb(_15890,inf,fin)),_15949,_15926,_15928),
    {user:testmember(_15890,[be,use])},
    !.

noun_phrases0(_15872,_15872,_15877::_15875,_15875,[noun_phrases0,_15949,{},!],_15926,_15928) --> 
    look_ahead(w(verb(_15890,pres,fin)),_15949,_15926,_15928),
    {user:testmember(_15890,[wish,want])},
    !.

noun_phrases0(_15872,_15873,_15880::_15877,_15877 and _15878,[noun_phrases0,_15978,_16007,_16036,_16065,_16099,{}],_15955,_15957) --> 
    not_look_ahead([','],_15978,_15955,_15995),
    np_conjunction(_15900,_16007,_15995,_16024),
    not_look_ahead(w(noun(_15915,sin,def,n)),_16036,_16024,_16053),
    noun_phrase1(_15920,_15880::_15924,_16065,_16053,_16084),
    noun_phrases20(_15920,_15902,_15880,_15924,_15878,_16099,_16084,_15957),
    {user:latin(_15900,_15872,_15902,_15873)}.

noun_phrases0(_15872,_15873,_15880::_15877,_15877 and _15878,[noun_phrases0,{},_15974,_16008,{}],_15941,_15943) --> 
    {user:(\+vartypeid(_15872,savant))},
    noun_phrase1(_15906,_15880::_15910,_15974,_15941,_15993),
    noun_phrases10(_15906,_15896,_15880,_15910,_15878,_16008,_15993,_15943),
    {user:latin(and,_15872,_15896,_15873)}.

noun_phrases0(_15872,_15872,_15877::_15875,_15875,[noun_phrases0,[]],_15903,_15903) --> 
    [].

noun_phrases10(_15872,_15873,_15874,_15875,_15875 and _15879,[noun_phrases10,_15967,_15996,_16030,{},lit(etc)],_15941,_15943) --> 
    andor(_15895,_15967,_15941,_15984),
    noun_phrase1(_15897,_15874::_15901,_15996,_15984,_16015),
    noun_phrases20(_15897,_15904,_15874,_15901,_15879,_16030,_16015,_16055),
    {user:latin(_15895,_15872,_15904,_15873)},
    cc(etc,_16055,_15943).

noun_phrases10(_15872,_15873,_15874,_15875,_15875 and _15879,[noun_phrases10,_15967,_15996,_16030,{}],_15941,_15943) --> 
    not_look_ahead(w(nb(_15901,_15902)),_15967,_15941,_15984),
    noun_phrase1(_15904,_15874::_15908,_15996,_15984,_16015),
    noun_phrases10(_15904,_15894,_15874,_15908,_15879,_16030,_16015,_15943),
    {user:latin(and,_15872,_15894,_15873)}.

noun_phrases10(_15872,_15872,_15874,_15875,_15875,[noun_phrases10,lit(etc)],_15905,_15907) --> 
    cc(etc,_15905,_15907).

noun_phrases20(_15872,_15873,_15874,_15875,_15875 and _15879,[noun_phrases20,_15962,_15991,_16025,{}],_15936,_15938) --> 
    andor(_15892,_15962,_15936,_15979),
    noun_phrase1(_15899,_15874::_15903,_15991,_15979,_16010),
    noun_phrases20(_15899,_15894,_15874,_15903,_15879,_16025,_16010,_15938),
    {user:latin(_15892,_15872,_15894,_15873)}.

noun_phrases20(_15872,_15872,_15874,_15875,_15875,[noun_phrases20,[]],_15903,_15903) --> 
    [].

no_phrases(_15872,_15873,[no_phrases,{},!,_15943],_15911,_15913) --> 
    {user:value(teleflag,true)},
    !,
    np(_15872,true::_15873,_15943,_15911,_15913).

no_phrases(_15872,_15873,[no_phrases,_15920,_15944],_15903,_15905) --> 
    the0(_15920,_15903,_15935),
    np(_15872,true::_15873,_15944,_15935,_15905).

no_phrase(_15872,_15873,[no_phrase,_15920,_15944],_15903,_15905) --> 
    the0(_15920,_15903,_15935),
    noun_phrase1(_15872,true::_15873,_15944,_15935,_15905).

noun_phrase1(_15872,_15873,[noun_phrase1,lit(og),!,_15935],_15902,_15904) --> 
    cc(og,_15902,_15929),
    !,
    reject(_15935,_15929,_15904).

noun_phrase1(_15872,_15873,[noun_phrase1,_15914],_15897,_15899) --> 
    np2(_15872,_15873,_15914,_15897,_15899).

noun_phrase1(_15872,_15873,[noun_phrase1,_15914],_15897,_15899) --> 
    np1(_15872,_15873,_15914,_15897,_15899).

noun_phrase1(_15872,_15873,[noun_phrase1,_15941,_15970,_15999,_16028,_16052],_15924,_15926) --> 
    one_of_lit([noen,mange],_15941,_15924,_15958),
    not_look_ahead([som],_15970,_15958,_15987),
    not_look_ahead([av],_15999,_15987,_16016),
    not_look_ahead_np(_16028,_16016,_16043),
    np00(agent,_15872,_15873,_16052,_16043,_15926).

noun_phrase1(_15872,_15873,[noun_phrase1,_15938,_15967,_15996,_16020],_15921,_15923) --> 
    one_of_lit([den,det],_15938,_15921,_15955),
    not_look_ahead(w(verb(_15898,_15899,pass)),_15967,_15955,_15984),
    not_look_ahead_np(_15996,_15984,_16011),
    np00(thing,_15872,_15873,_16020,_16011,_15923).

noun_phrase1(_15872,_15875::_15876,[noun_phrase1,_15978,_16007,_16036,_16070,_16099,!,_16133,_16157],_15961,_15963) --> 
    not_look_ahead([de],_15978,_15961,_15995),
    not_look_ahead([det],_16007,_15995,_16024),
    quant_pron(some,_15907,_16036,_16024,_16055),
    not_look_ahead([som],_16070,_16055,_16087),
    not_look_ahead(w(noun(_15931,_15932,_15933,_15934)),_16099,_16087,_16116),
    !,
    accept(_16133,_16116,_16148),
    lock(exact,_16148,_16207),
    pushstack(exact,(some,w(noun(_15907,sin,u,n))),nil,_16207,_16213),
    np1(_15872,_15875::_15876,_16157,_16213,_16202),
    unlock(_16202,_15963).

noun_phrase1(_15872,_15873,[noun_phrase1,_15970,_15999,_16033,_16062,!,_16096,_16120],_15953,_15955) --> 
    not_look_ahead([de],_15970,_15953,_15987),
    quant_pron(every,thing,_15999,_15987,_16018),
    not_look_ahead(w(noun(_15917,_15918,_15919,_15920)),_16033,_16018,_16050),
    not_look_ahead(w(adj2(_15926,_15927)),_16062,_16050,_16079),
    !,
    accept(_16096,_16079,_16111),
    pushstack(first,([alle],w(noun(thing,sin,u,n))),nil,_16111,_16130),
    np1(_15872,_15873,_16120,_16130,_15955).

noun_phrase1(_15872,_15873,[noun_phrase1,_15914],_15897,_15899) --> 
    npa(_15872,_15873,_15914,_15897,_15899).

noun_phrase1(_15872,_15875::_15876,[noun_phrase1,_15939,_15973],_15922,_15924) --> 
    quant_pron(much,_15889,_15939,_15922,_15958),
    lock(exact,_15958,_16023),
    pushstack(exact,(much,w(noun(_15889,sin,u,n))),nil,_16023,_16029),
    np1(_15872,_15875::_15876,_15973,_16029,_16018),
    unlock(_16018,_15924).

noun_phrase1(_15872,_15875::_15876,[noun_phrase1,_15939,_15973],_15922,_15924) --> 
    quant_pron(little,_15889,_15939,_15922,_15958),
    lock(exact,_15958,_16023),
    pushstack(exact,(little,w(noun(_15889,sin,u,n))),nil,_16023,_16029),
    np1(_15872,_15875::_15876,_15973,_16029,_16018),
    unlock(_16018,_15924).

noun_phrase1(_15872,_15875::not _15878,[noun_phrase1,_15941,_15975],_15924,_15926) --> 
    quant_pron(no,_15891,_15941,_15924,_15960),
    lock(exact,_15960,_16025),
    pushstack(exact,(every,w(noun(_15891,sin,u,n))),nil,_16025,_16031),
    np1(_15872,_15875::_15878,_15975,_16031,_16020),
    unlock(_16020,_15926).

noun_phrase1(_15872,_15873,[noun_phrase1,_15914],_15897,_15899) --> 
    xnp(_15872,_15873,_15914,_15897,_15899).

noun_phrase1(_15872,_15875::_15875,[noun_phrase1,_15916],_15899,_15901) --> 
    npgap(_15872,_15916,_15899,_15901).

specific_phrase(_15872,_15873,[specific_phrase,_15923,!,_15957],_15906,_15908) --> 
    w(name(_15883,gen,_15885),_15923,_15906,_15940),
    !,
    reject(_15957,_15940,_15908).

specific_phrase(_15872,_15873,[specific_phrase,_15926,_15955,!,_15984],_15909,_15911) --> 
    w(name(_15886,_15887,_15888),_15926,_15909,_15943),
    sin(_15955,_15943,_15970),
    !,
    reject(_15984,_15970,_15911).

specific_phrase(_15872,_15875::_15876,[specific_phrase,_15920],_15903,_15905) --> 
    sp1(_15872,_15875::_15876,_15920,_15903,_15905).

sp1(_15884:_15885,_15875::findpron(_15884:_15885)::_15884 isa _15893 and _15875,[sp1,_15941,{}],_15924,_15926) --> 
    pronoun(_15893,_15941,_15924,_15926),
    {user:type(_15893,_15885)}.

sp1(_15872,_15873,[sp1,_15927,_15966],_15910,_15912) --> 
    name_phrase(name,_15872,_15873,_15927,_15910,_15948),
    not_look_ahead(w(noun(_15882,_15883,_15884,_15885)),_15966,_15948,_15912).

np0(_15872,_15873,[np0,lit(mye),_15960,_15984,_16013,!,_16079],_15932,_15934) --> 
    cc(mye,_15932,_15959),
    not_look_ahead_np(_15960,_15959,_15975),
    not_look_ahead(w(adj(_15896,_15897)),_15984,_15975,_16001),
    lock(exact,_16001,_16033),pushstack(exact,w(noun(thing,sin,u,n)),nil,_16033,_16039),np_kernel(0,_15872,_15873,_16013,_16039,_16028),unlock(_16028,_16029),
    !,
    accept(_16079,_16029,_15934).

np0(_15872,_15875::_15876,[np0,_15927,!,_15971],_15910,_15912) --> 
    np_head1(_15884,_15872,_15875::_15876,_15927,_15910,_15948),
    !,
    accept(_15971,_15948,_15912).

np0(_15872,_15875::_15876,[np0,_15924,_15948],_15907,_15909) --> 
    the10(_15924,_15907,_15939),
    aname_phrase(_15881,_15872,_15875::_15876,_15948,_15939,_15909).

np0(_15872,_15875::_15876,[np0,_15921],_15904,_15906) --> 
    np_kernel(_15878,_15872,_15875::_15876,_15921,_15904,_15906).

np0(_15872,_15875::_15876,[np0,_15920],_15903,_15905) --> 
    npa(_15872,_15875::_15876,_15920,_15903,_15905).

np0(_15872,_15875::_15875,[np0,_15916],_15899,_15901) --> 
    npgap(_15872,_15916,_15899,_15901).

obvious_object(_15872,_15873,[obvious_object,lit(det),_15941,!,_15975],_15913,_15915) --> 
    cc(det,_15913,_15940),
    not_look_ahead(w(verb(_15890,_15891,pass)),_15941,_15940,_15958),
    !,
    reject(_15975,_15958,_15915).

obvious_object(_15872,_15873,[obvious_object,_15924,_15953,!],_15907,_15909) --> 
    look_ahead([alt],_15924,_15907,_15941),
    np1_accept(_15872,_15873,_15953,_15941,_15909),
    !.

obvious_object(_15872,_15873,[obvious_object,_15921,_15950],_15904,_15906) --> 
    not_look_ahead([noen],_15921,_15904,_15938),
    np0_accept(_15872,_15873,_15950,_15938,_15906).

np1(_15872,_15875::_15875 and _15879,[np1,_15983,lit(det),_16018,lit(å),!,_16063,!,_16111],_15966,_15968) --> 
    hvormye(_15983,_15966,_15998),
    cc(det,_15998,_16017),
    w(verb(_15917,_15918,fin),_16018,_16017,_16035),
    cc(å,_16035,_16057),
    !,
    pushstack(first,([noen],[vil]),nil,_16057,_16076),clausal_object1(_15931,_15932,_16063,_16076,_16091),
    !,
    lock(exact,_16091,_16189),
    pushstack(exact,(xnp(_15931,_15932),w(verb(_15917,_15918,fin)),npgap(_15872)),nil,_16189,_16195),
    statreal1(_15879,_16111,_16195,_16184),
    unlock(_16184,_15968).

np1(_15872,_15873,[np1,lit(noe),_15961,!,_15995,_16056],_15933,_15935) --> 
    cc(noe,_15933,_15960),
    look_ahead(w(prep(_15898)),_15961,_15960,_15978),
    !,
    lock(exact,_15978,_16015),pushstack(exact,w(noun(thing,sin,u,n)),nil,_16015,_16021),np_kernel(0,_15872,_15889,_15995,_16021,_16010),unlock(_16010,_16011),
    noun_modifiers0(0,_15872,_15889,_15873,_16056,_16011,_15935).

np1(_15872,_15873,[np1,_16017,_16041,_16070,_16099,{},!,_16143,_16167,_16228],_16000,_16002) --> 
    a(_16017,_16000,_16032),
    w(noun(_15916,sin,u,n),_16041,_16032,_16058),
    w(name(_15910,n,_15912),_16070,_16058,_16087),
    w(noun(_15929,sin,u,n),_16099,_16087,_16116),
    {user:(\+testmember(_15929,[minute,hour,direction,home,station]))},
    !,
    accept(_16143,_16116,_16158),
    lock(exact,_16158,_16187),pushstack(exact,w(noun(_15929,sin,u,n)),nil,_16187,_16193),np_kernel(_15961,_15872,_15963,_16167,_16193,_16182),unlock(_16182,_16183),
    lock(exact,_16183,_16245),
    pushstack(exact,(w(prep(with)),w(noun(_15916,sin,u,n)),w(name(_15910,n,_15912))),nil,_16245,_16251),
    noun_modifiers0(0,_15872,_15963,_15873,_16228,_16251,_16240),
    unlock(_16240,_16002).

np1(_15872,_15873,[np1,lit(hvem),_15960,!,_15994,_16033],_15932,_15934) --> 
    cc(hvem,_15932,_15959),
    look_ahead_lit([man,jeg,du,vi],_15960,_15959,_15977),
    !,
    np00(agent,_15872,_15906,_15994,_15977,_16015),
    pushstack(first,relpron(agent),nil,_16015,_16076),
    noun_modifiers0(0,_15872,_15906,_15873,_16033,_16076,_15934).

np1(_15872,_15873,[np1,lit(hvem),lit(som),!,_15968,_16007],_15924,_15926) --> 
    cc(hvem,_15924,_15951),
    cc(som,_15951,_15962),
    !,
    np00(agent,_15872,_15898,_15968,_15962,_15989),
    pushstack(first,relpron(agent),nil,_15989,_16047),
    noun_modifiers0(0,_15872,_15898,_15873,_16007,_16047,_15926).

np1(_15872,_15873,[np1,_15947,_15971,!,_16000,_16061],_15930,_15932) --> 
    hvormye(_15947,_15930,_15962),
    dette(_15971,_15962,_15986),
    !,
    lock(exact,_15986,_16020),pushstack(exact,w(noun(thing,sin,u,n)),nil,_16020,_16026),np_kernel(0,_15872,_15904,_16000,_16026,_16015),unlock(_16015,_16016),
    pushstack(first,relpron(thing),nil,_16016,_16102),
    noun_modifiers0(0,_15872,_15904,_15873,_16061,_16102,_15932).

np1(_15872,_15873,[np1,lit(hva),lit(som),!,_15968,_16007],_15924,_15926) --> 
    cc(hva,_15924,_15951),
    cc(som,_15951,_15962),
    !,
    np00(thing,_15872,_15898,_15968,_15962,_15989),
    pushstack(first,relpron(thing),nil,_15989,_16047),
    noun_modifiers0(0,_15872,_15898,_15873,_16007,_16047,_15926).

np1(_15872,_15873,[np1,lit(hva),_15960,!,_15989,_16050],_15932,_15934) --> 
    cc(hva,_15932,_15959),
    look_ahead_np(_15960,_15959,_15975),
    !,
    lock(exact,_15975,_16009),pushstack(exact,w(noun(thing,sin,u,n)),nil,_16009,_16015),np_kernel(0,_15872,_15906,_15989,_16015,_16004),unlock(_16004,_16005),
    pushstack(first,relpron(thing),nil,_16005,_16090),
    noun_modifiers0(0,_15872,_15906,_15873,_16050,_16090,_15934).

np1(_15872,_15873,[np1,lit(de),_15956,_15985,!,_16019],_15928,_15930) --> 
    cc(de,_15928,_15955),
    not_look_ahead(w(nb(_15897,_15898)),_15956,_15955,_15973),
    look_ahead(w(noun(_15904,sin,_15906,_15907)),_15985,_15973,_16002),
    !,
    np00(agent,_15872,_15873,_16019,_16002,_15930).

np1(_15872,_15873,[np1,_15975,!,_16004,lit(å),_16049,!,_16083,_16144],_15958,_15960) --> 
    noemed(_15975,_15958,_15990),
    !,
    np0_accept(_15902,_15903,_16004,_15990,_16023),
    cc(å,_16023,_16048),
    w(verb(do1,inf,fin),_16049,_16048,_16066),
    !,
    lock(exact,_16066,_16103),pushstack(exact,w(noun(thing,sin,u,n)),nil,_16103,_16109),np_kernel(_15926,_15872,_15928,_16083,_16109,_16098),unlock(_16098,_16099),
    pushstack(first,(w(prep(with)),xnp(_15902,_15903)),nil,_16099,_16185),
    noun_modifiers0(_15926,_15872,_15928,_15873,_16144,_16185,_15960).

noemed([noemed,lit(noe),lit(med)],_15894,_15896) --> 
    cc(noe,_15894,_15915),
    cc(med,_15915,_15896).

np1(_15872,_15873,[np1,_15949,!,_15978,_16039],_15932,_15934) --> 
    noeå(_15949,_15932,_15964),
    !,
    lock(exact,_15964,_15998),pushstack(exact,w(noun(thing,sin,u,n)),nil,_15998,_16004),np_kernel(0,_15872,_15904,_15978,_16004,_15993),unlock(_15993,_15994),
    pushstack(first,([som],[jeg]),nil,_15994,_16049),
    noun_modifiers0(0,_15872,_15904,_15873,_16039,_16049,_15934).

noeå([noeå,lit(noe),lit(å)],_15894,_15896) --> 
    cc(noe,_15894,_15915),
    cc(å,_15915,_15896).

np1(_15872,_15873,[np1,_15944,!,_15973,_16034],_15927,_15929) --> 
    noesom(_15944,_15927,_15959),
    !,
    lock(exact,_15959,_15993),pushstack(exact,w(noun(thing,sin,u,n)),nil,_15993,_15999),np_kernel(0,_15872,_15901,_15973,_15999,_15988),unlock(_15988,_15989),
    pushstack(first,[som],nil,_15989,_16044),
    noun_modifiers0(0,_15872,_15901,_15873,_16034,_16044,_15929).

noesom([noesom,lit(det),_15924],_15902,_15904) --> 
    cc(det,_15902,_15923),
    look_ahead_lit([man,jeg,du,vi],_15924,_15923,_15904).

noesom([noesom,lit(det),lit(som)],_15894,_15896) --> 
    cc(det,_15894,_15915),
    cc(som,_15915,_15896).

noesom([noesom,lit(noe),lit(som)],_15894,_15896) --> 
    cc(noe,_15894,_15915),
    cc(som,_15915,_15896).

noesom([noesom,lit(noe),_15924],_15902,_15904) --> 
    cc(noe,_15902,_15923),
    look_ahead_lit([jeg,du,han,hun],_15924,_15923,_15904).

noesom([noesom,lit(hva),lit(som)],_15894,_15896) --> 
    cc(hva,_15894,_15915),
    cc(som,_15915,_15896).

noesom([noesom,lit(det),_15923,!],_15901,_15903) --> 
    cc(det,_15901,_15922),
    look_ahead_lit([jeg,du],_15923,_15922,_15903),
    !.

np1(_15872,_15873,[np1,lit(det),_15954,!,_15988,_16027],_15926,_15928) --> 
    cc(det,_15926,_15953),
    look_ahead([de],_15954,_15953,_15971),
    !,
    np00(agent,_15872,_15900,_15988,_15971,_16009),
    pushstack(first,[som],nil,_16009,_16037),
    noun_modifiers0(0,_15872,_15900,_15873,_16027,_16037,_15928).

np1(_15872,_15873,[np1,lit(noen),_15954,!,_15988,_16027],_15926,_15928) --> 
    cc(noen,_15926,_15953),
    look_ahead([de],_15954,_15953,_15971),
    !,
    np00(agent,_15872,_15900,_15988,_15971,_16009),
    pushstack(first,[som],nil,_16009,_16037),
    noun_modifiers0(0,_15872,_15900,_15873,_16027,_16037,_15928).

np1(_15872,_15873,[np1,lit(hvilke),_15957,_15996,_16025,!,_16054],_15929,_15931) --> 
    cc(hvilke,_15929,_15956),
    np_kernel(_15897,_15872,_15899,_15957,_15956,_15978),
    not_look_ahead([som],_15996,_15978,_16013),
    look_ahead_np(_16025,_16013,_16040),
    !,
    pushstack(first,[som],nil,_16040,_16064),
    noun_modifiers0(_15897,_15872,_15899,_15873,_16054,_16064,_15931).

np1(_15872,_15873,[np1,lit(hvilke),_15949,_15988,!,_16022],_15921,_15923) --> 
    cc(hvilke,_15921,_15948),
    np_kernel(_15887,_15872,_15889,_15949,_15948,_15970),
    look_ahead([som],_15988,_15970,_16005),
    !,
    noun_modifiers0(_15887,_15872,_15889,_15873,_16022,_16005,_15923).

np1(_15872,_15873,[np1,{},lit(de),_16031,_16060,_16089,_16118,!,_16152,[],_16190,_16238],_15993,_15995) --> 
    {user:value(busflag,true)},
    cc(de,_15993,_16030),
    w(nb(_15919,num),_16031,_16030,_16048),
    flnp(_15922,_16060,_16048,_16077),
    not_look_ahead(w(noun(_15928,_15929,_15930,_15931)),_16089,_16077,_16106),
    w(prep(_15935),_16118,_16106,_16135),
    !,
    accept(_16152,_16135,_16167),
    pushstack(free,w(prep(_15935)),nil,_16167,_16189),[],
    pushstack(first,(w(nb(_15919,num)),w(adj2(_15922,nil)),w(noun(vehicle,sin,u,n))),nil,_16189,_16203),np_kernel(_15905,_15872,_15907,_16190,_16203,_16220),
    noun_modifiers0(_15905,_15872,_15907,_15873,_16238,_16220,_15995).

np1(_15872,_15875::_15876,[np1,_15926,!,_15965],_15909,_15911) --> 
    obviousclock(_15872,_15875::_15876,_15926,_15909,_15945),
    !,
    accept(_15965,_15945,_15911).

np1(_15872,_15873,[np1,{},lit(en),_16008,{},_16047,!,_16081,_16105,_16153],_15970,_15972) --> 
    {user:value(busflag,true)},
    cc(en,_15970,_16007),
    w(nb(_15913,num),_16008,_16007,_16025),
    {user:plausible_busno(_15913)},
    not_look_ahead(w(noun(_15924,_15925,_15926,_15927)),_16047,_16025,_16064),
    !,
    accept(_16081,_16064,_16096),
    pushstack(first,(w(noun(vehicle,sin,u,n)),w(nb(_15913,num))),nil,_16096,_16118),np_kernel(_15899,_15872,_15901,_16105,_16118,_16135),
    noun_modifiers0(_15899,_15872,_15901,_15873,_16153,_16135,_15972).

np1(_15872,_15875::_15876,[np1,_15935,_15974],_15918,_15920) --> 
    np_kernel(_15881,_15872,_15893::_15894,_15935,_15918,_15956),
    noun_modifiers0(_15881,_15872,_15893::_15894,_15875::_15876,_15974,_15956,_15920).

np_kernel(0,_15885:thing,_15876::findpron(_15885:thing)::_15885 isa thing and _15876,[np_kernel,_15943,_15967,!],_15923,_15925) --> 
    dette(_15943,_15923,_15958),
    not_look_ahead_np(_15967,_15958,_15925),
    !.

np_kernel(0,_15885:agent,_15876::findpron(_15885:agent)::_15885 isa agent and _15876,[np_kernel,lit(de),_15984,_16013,_16042,!],_15953,_15955) --> 
    cc(de,_15953,_15983),
    not_look_ahead(w(nb(_15914,_15915)),_15984,_15983,_16001),
    not_look_ahead(w(adj2(_15921,_15922)),_16013,_16001,_16030),
    look_ahead(w(verb(_15928,pres,fin)),_16042,_16030,_15955),
    !.

np_kernel(0,_15873,_15876::_15877,[np_kernel,_15932,!,_15971],_15912,_15914) --> 
    obviousdate(_15873,_15876::_15877,_15932,_15912,_15951),
    !,
    accept(_15971,_15951,_15914).

np_kernel(0,_15885:thing,_15876::findpron(_15885:thing)::_15885 isa thing and _15876,[np_kernel,lit(en),_15972,!],_15941,_15943) --> 
    cc(en,_15941,_15971),
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_15972,_15971,_15943),
    !.

np_kernel(name,_15885:_15886,_15876::findpron(_15885:_15886)::_15885 isa _15886 and _15876,[np_kernel,_15955,_15984,!],_15935,_15937) --> 
    not_look_ahead_lit([de,den,det,et],_15955,_15935,_15972),
    pronoun(_15886,_15984,_15972,_15937),
    !.

np_kernel(0,_15885:thing,_15876::exists(_15885:thing)::_15885 isa thing and _15876,[np_kernel,_15955,_15984,!],_15935,_15937) --> 
    one_of_lit([alt,noe],_15955,_15935,_15972),
    look_ahead_lit([som,å],_15984,_15972,_15937),
    !.

np_kernel(_15872,_15873,_15876::_15877,[np_kernel,_15927],_15907,_15909) --> 
    np_head1(_15872,_15873,_15876::_15877,_15927,_15907,_15909).

np_kernel(_15872,_15873,_15874,[np_kernel,_15944,_15973,_16002],_15924,_15926) --> 
    look_ahead(w(name(_15890,n,_15892)),_15944,_15924,_15961),
    not_look_ahead(w(noun(_15898,_15899,_15900,_15901)),_15973,_15961,_15990),
    aname_phrase(_15872,_15873,_15874,_16002,_15990,_15926).

np_kernel(_15872,_15873,_15876::_15877,[np_kernel,_15927],_15907,_15909) --> 
    np_head(_15872,_15873,_15876::_15877,_15927,_15907,_15909).

np_kernel(_15872,_15873,_15876::_15877,[np_kernel,_15938,_15967],_15918,_15920) --> 
    not_look_ahead(w(name(_15893,n,_15895)),_15938,_15918,_15955),
    aname_phrase(_15872,_15873,_15876::_15877,_15967,_15955,_15920).

np_head1(_15872,_15873,_15876::_15877,[np_head1,{},_15969,_16018,_16047,{}],_15939,_15941) --> 
    {user:value(teleflag,true)},
    determiner0(_15903,_15872,_15873,_15896,_15876::_15877,_15969,_15939,_15994),
    preadjs0(_15893,_16018,_15994,_16035),
    noun_list2(_15914,_15873,_15895,_16047,_16035,_15941),
    {user:preadjs_template(_15893,_15873,_15895,_15896)}.

np_head1(0,_15879:_15880,_15876::_15877,[np_head1,{},_16008,_16052,_16106,!,{},{},{}],_15978,_15980) --> 
    {user:value(busflag,true)},
    optional([denne],_16008,_15978,_16040),
    bus_head(_15919,_15905,_15921,_15880,_15923,_15879,_16052,_16040,_16079),
    not_look_ahead_lit([sin,sitt,sine],_16106,_16079,_15980),
    !,
    {user:decide_adjective(_15921,_15879,_15938)},
    {user:_15942=(_15879 isa _15880 and _15938)},
    {user:decide_quantifier(_15905,_15879:_15880,_15942 and _15876,_15877)}.

np_head1(0,_15873,_15876::_15877,[np_head1,{},lit(den),_16022,{},_16061,!,_16095,_16119,!,_16185],_15981,_15983) --> 
    {user:value(busflag,true)},
    cc(den,_15981,_16021),
    w(adj2(_15915,nil),_16022,_16021,_16039),
    {user:testmember(_15915,[first,last,next,previous])},
    look_ahead([som],_16061,_16039,_16078),
    !,
    accept(_16095,_16078,_16110),
    lock(exact,_16110,_16139),pushstack(exact,(w(adj2(_15915,nil)),w(noun(vehicle,sin,u,n))),nil,_16139,_16145),np_head(0,_15873,_15876::_15877,_16119,_16145,_16134),unlock(_16134,_16135),
    !,
    accept(_16185,_16135,_15983).

np_head1(0,_15873,_15876::exists(_15873)::_15882 and _15885 and _15876,[np_head1,_15969,_15998,_16027,{},!,_16096],_15949,_15951) --> 
    not_look_ahead([dere],_15969,_15949,_15986),
    w(name(_15911,_15912,_15913),_15998,_15986,_16015),
    noun(_15915,_15916,_15917,n,_15873,_15885,_16027,_16015,_16054),
    {user:adjnamecomp_template(_15911,_15873,_15882)},
    !,
    accept(_16096,_16054,_15951).

bus_head(_15872,_15873,_15874,_15875,_15875,_15877,[bus_head,_15978,_16012,_16046,{},{},_16100,_16134],_15949,_15951) --> 
    traceprint(5,bx01,_15978,_15949,_15997),
    art0(_15872,_15904,_16012,_15997,_16031),
    quantnext(_15873,_15874,_16046,_16031,_16065),
    {user:_15874\==nil},
    {user:_15873=<5},
    busnumber(_15877,_15875,_16100,_16065,_16119),
    traceprint(4,bh01,_16134,_16119,_15951).

bus_head(_15872,_15873,_15874,_15875,_15876,_15877,[bus_head,_15971,_16005,_16039,{},_16083,_16122],_15942,_15944) --> 
    traceprint(5,bx02,_15971,_15942,_15990),
    art0(_15872,_15901,_16005,_15990,_16024),
    quantnext(_15873,_15874,_16039,_16024,_16058),
    {user:_15873=<5},
    busseno(_15877,_15875,_15876,_16083,_16058,_16104),
    traceprint(4,bh02,_16122,_16104,_15944).

bus_head(_15872,_15873,_15874,_15875,_15875,_15877,[bus_head,_15983,_16017,_16051,{},_16095,_16124,_16148,_16182],_15954,_15956) --> 
    traceprint(5,bx03,_15983,_15954,_16002),
    art0(_15872,_15907,_16017,_16002,_16036),
    quantnext(_15873,_15874,_16051,_16036,_16070),
    {user:_15873=<5},
    not_look_ahead(w(nb(_15921,_15922)),_16095,_16070,_16112),
    nr0(_16124,_16112,_16139),
    busnumber(_15877,_15875,_16148,_16139,_16167),
    traceprint(4,bh03,_16182,_16167,_15956).

bus_head(_15872,_15873,_15874,_15875,_15875,_15877,[bus_head,_15992,_16026,_16060,{},_16104,_16133,_16189,!],_15963,_15965) --> 
    traceprint(5,bx04,_15992,_15963,_16011),
    art0(_15872,_15904,_16026,_16011,_16045),
    quantnext(_15873,_15874,_16060,_16045,_16079),
    {user:_15873=<5},
    look_ahead(w(prep(_15918)),_16104,_16079,_16121),
    lock(exact,_16121,_16153),pushstack(exact,w(noun(bus,plu,def,n)),nil,_16153,_16159),busnumber(_15877,_15875,_16133,_16159,_16148),unlock(_16148,_16149),
    traceprint(4,bh04,_16189,_16149,_15965),
    !.

bus_head(_15872,1,_15874,_15875,_15876,_15877,[bus_head,_15972,_16006,_16040,_16069,_16093,_16127,_16171],_15943,_15945) --> 
    traceprint(5,bx05,_15972,_15943,_15991),
    art0(_15872,_15904,_16006,_15991,_16025),
    flnp(_15874,_16040,_16025,_16057),
    nr1(_16069,_16057,_16084),
    busnumber(_15877,_15876,_16093,_16084,_16112),
    busse0(_15876,_15875,_15913,_15914,_16127,_16112,_16150),
    traceprint(4,bh05,_16171,_16150,_15945).

bus_head(_15872,_15873,nil,_15875,_15876,_15877,[bus_head,_15972,_16006,_16040,_16069,_16093,_16127,_16171],_15943,_15945) --> 
    traceprint(5,bx06,_15972,_15943,_15991),
    art0(_15872,_15904,_16006,_15991,_16025),
    quant(_15873,_16040,_16025,_16057),
    nr1(_16069,_16057,_16084),
    busnumber(_15877,_15876,_16093,_16084,_16112),
    busse0(_15876,_15875,_15913,_15914,_16127,_16112,_16150),
    traceprint(4,bh06,_16171,_16150,_15945).

bus_head(_15872,_15873,nil,_15875,_15876,_15877,[bus_head,_15971,_16005,_16039,_16068,_16107,_16131,_16165],_15942,_15944) --> 
    traceprint(5,bx07,_15971,_15942,_15990),
    art0(_15872,_15904,_16005,_15990,_16024),
    quant(_15873,_16039,_16024,_16056),
    busnoun(_15875,_15909,_15910,_16068,_16056,_16089),
    nr0(_16107,_16089,_16122),
    busnumber(_15877,_15876,_16131,_16122,_16150),
    traceprint(4,bh07,_16165,_16150,_15944).

bus_head(_15872,_15873,nil,_15875,_15876,_15877,[bus_head,_15968,_16002,_16036,_16065,_16099,_16138],_15939,_15941) --> 
    traceprint(5,bx08,_15968,_15939,_15987),
    art0(_15872,_15901,_16002,_15987,_16021),
    quant(_15873,_16036,_16021,_16053),
    busnumber(_15877,_15876,_16065,_16053,_16084),
    busnoun(_15875,_15909,_15910,_16099,_16084,_16120),
    traceprint(4,bh08,_16138,_16120,_15941).

bus_head(_15872,1,_15874,_15875,_15876,_15877,[bus_head,_15971,_16005,_16039,_16068,_16092,_16126,_16165],_15942,_15944) --> 
    traceprint(5,bx09,_15971,_15942,_15990),
    art0(_15872,_15904,_16005,_15990,_16024),
    filanepr(_15874,_16039,_16024,_16056),
    nr1(_16068,_16056,_16083),
    busnumber(_15877,_15876,_16092,_16083,_16111),
    busnoun(_15875,_15912,_15913,_16126,_16111,_16147),
    traceprint(4,bh09,_16165,_16147,_15944).

bus_head(_15872,1,_15874,route,_15876,_15877,[bus_head,_15972,_16006,{},_16050,_16079,_16103,_16137],_15943,_15945) --> 
    traceprint(5,bx10,_15972,_15943,_15991),
    art0(_15872,_15904,_16006,_15991,_16025),
    {user:_15904\==plu},
    filanepr(_15874,_16050,_16025,_16067),
    nr1(_16079,_16067,_16094),
    busnumber(_15877,_15876,_16103,_16094,_16122),
    traceprint(4,bh10,_16137,_16122,_15945).

bus_head(_15872,1,_15874,_15875,_15876,_15877,[bus_head,_15994,_16028,{},_16072,_16101,_16140,_16164,_16188,_16222,_16251],_15965,_15967) --> 
    traceprint(5,bx11,_15994,_15965,_16013),
    art0(_15872,_15913,_16028,_16013,_16047),
    {user:_15913\==plu},
    filanepr(_15874,_16072,_16047,_16089),
    busnoun(_15875,_15923,_15924,_16101,_16089,_16122),
    nr0(_16140,_16122,_16155),
    colon0(_16164,_16155,_16179),
    busnumber(_15877,_15876,_16188,_16179,_16207),
    not_look_ahead(w(noun(minute,_15934,_15935,_15936)),_16222,_16207,_16239),
    traceprint(4,bh11,_16251,_16239,_15967).

bus_head(_15872,_15873,_15874,_15875,_15876,_15877,[bus_head,_15977,_16011,_16045,{},_16089,_16128,_16162],_15948,_15950) --> 
    traceprint(5,bx12,_15977,_15948,_15996),
    art0(_15872,_15904,_16011,_15996,_16030),
    quantnext(_15873,_15874,_16045,_16030,_16064),
    {user:_15873<10},
    busnoun(_15875,_15915,plu,_16089,_16064,_16110),
    busnumber(_15877,_15876,_16128,_16110,_16147),
    traceprint(4,bh12,_16162,_16147,_15950).

bus_head(_15872,_15873,_15874,_15875,nil,_15877,[bus_head,_15971,_16005,_16039,{},_16083,_16122],_15942,_15944) --> 
    traceprint(5,bx13,_15971,_15942,_15990),
    art0(_15872,plu,_16005,_15990,_16024),
    quantnext(_15873,_15874,_16039,_16024,_16058),
    {user:_15873<100},
    busnoun(_15875,_15912,_15913,_16083,_16058,_16104),
    traceprint(4,bh13,_16122,_16104,_15944).

bus_head(_15872,_15873,_15874,_15875,nil,_15877,[bus_head,_15971,_16005,_16039,{},_16083,_16122],_15942,_15944) --> 
    traceprint(5,bx14,_15971,_15942,_15990),
    art0(_15872,_15901,_16005,_15990,_16024),
    quantnext(_15873,_15874,_16039,_16024,_16058),
    {user:_15873=<5},
    busnoun(_15875,_15912,plu,_16083,_16058,_16104),
    traceprint(4,bh14,_16122,_16104,_15944).

bus_head(_15872,1,_15874,_15875,_15876,_15877,[bus_head,_15981,_16015,_16049,_16078,{},_16122,_16161],_15952,_15954) --> 
    traceprint(5,bx15,_15981,_15952,_16000),
    art0(_15872,_15904,_16015,_16000,_16034),
    filanepr(_15874,_16049,_16034,_16066),
    busnumber(_15877,_15876,_16078,_16066,_16097),
    {user:(number(_15877),_15877>5)},
    busnoun(_15875,_15922,_15923,_16122,_16097,_16143),
    traceprint(4,bh15,_16161,_16143,_15954).

bus_head(_15872,1,_15874,_15875,_15876,_15877,[bus_head,_15976,_16010,_16044,_16073,{},_16117,_16156],_15947,_15949) --> 
    traceprint(5,bx16,_15976,_15947,_15995),
    art0(_15872,_15904,_16010,_15995,_16029),
    filanepr(_15874,_16044,_16029,_16061),
    busnumber(_15877,_15876,_16073,_16061,_16092),
    {user:_15877\==1},
    busnoun(_15875,_15917,sin,_16117,_16092,_16138),
    traceprint(4,bh16,_16156,_16138,_15949).

bus_head(u,1,nil,bus,number,_15877,[bus_head,_15989,_16023,_16052,{},_16091,_16130],_15960,_15962) --> 
    traceprint(5,bx17,_15989,_15960,_16008),
    not_look_ahead(w(name(_15904,n,route)),_16023,_16008,_16040),
    w(nb(_15877,num),_16052,_16040,_16069),
    {user:(number(_15877),_15877>5,_15877=<9999)},
    busnoun(bus,def,sin,_16091,_16069,_16112),
    traceprint(4,bh17,_16130,_16112,_15962).

bus_head(def,_15873,_15874,route,nil,_15877,[bus_head,_15966,lit(de),_16011,{},_16055,_16079],_15937,_15939) --> 
    traceprint(5,bx18,_15966,_15937,_15985),
    cc(de,_15985,_16010),
    quantnext(_15873,_15874,_16011,_16010,_16030),
    {user:_15873=<5},
    not_look_ahead_np(_16055,_16030,_16070),
    traceprint(4,bh18,_16079,_16070,_15939).

bus_head(_15872,_15873,_15874,route,nil,_15877,[bus_head,_15984,_16018,_16052,{},{},_16106,_16130,!],_15955,_15957) --> 
    traceprint(5,bx19,_15984,_15955,_16003),
    art0(_15872,_15904,_16018,_16003,_16037),
    quantnext(_15873,_15874,_16052,_16037,_16071),
    {user:_15874\==nil},
    {user:(_15873>0,_15873=<5)},
    not_look_ahead_np(_16106,_16071,_16121),
    traceprint(4,bh19,_16130,_16121,_15957),
    !.

bus_head(_15872,1,_15874,_15875,_15876,_15877,[bus_head,_15986,_16020,_16054,_16083,_16122,_16146,_16170,_16204,_16233],_15957,_15959) --> 
    traceprint(5,bx20,_15986,_15957,_16005),
    art0(_15872,_15910,_16020,_16005,_16039),
    filanepr(_15874,_16054,_16039,_16071),
    busnoun(_15875,_15915,sin,_16083,_16071,_16104),
    nr0(_16122,_16104,_16137),
    colon0(_16146,_16137,_16161),
    busnumber(_15877,_15876,_16170,_16161,_16189),
    not_look_ahead(w(noun(minute,_15926,_15927,_15928)),_16204,_16189,_16221),
    traceprint(4,bh20,_16233,_16221,_15959).

art0(u,plu,[art0,lit(noen),_15930,!],_15902,_15904) --> 
    cc(noen,_15902,_15929),
    look_ahead_np(_15930,_15929,_15904),
    !.

art0(u,sin,[art0,lit(noe),!],_15899,_15901) --> 
    cc(noe,_15899,_15901),
    !.

art0(_15872,_15873,[art0,_15917,!],_15900,_15902) --> 
    art(_15872,_15873,_15917,_15900,_15902),
    !.

art0(u,nil,[art0,[]],_15894,_15894) --> 
    [].

art(u,sin,[art,lit(en),!],_15899,_15901) --> 
    cc(en,_15899,_15901),
    !.

art(u,sin,[art,lit(et),!],_15899,_15901) --> 
    cc(et,_15899,_15901),
    !.

art(u,sin,[art,lit(ei),!],_15899,_15901) --> 
    cc(ei,_15899,_15901),
    !.

art(def,sin,[art,lit(den),!],_15899,_15901) --> 
    cc(den,_15899,_15901),
    !.

art(def,plu,[art,lit(det),!],_15899,_15901) --> 
    cc(det,_15899,_15901),
    !.

art(def,plu,[art,lit(de),!],_15899,_15901) --> 
    cc(de,_15899,_15901),
    !.

quantnext(_15872,_15873,[quantnext,_15921,_15950,!],_15904,_15906) --> 
    quant(_15872,_15921,_15904,_15938),
    filanepr(_15873,_15950,_15938,_15906),
    !.

quantnext(_15872,_15873,[quantnext,_15921,_15950,!],_15904,_15906) --> 
    filanepr(_15873,_15921,_15904,_15938),
    quant(_15872,_15950,_15938,_15906),
    !.

quant00(1,[quant00,[]],_15891,_15891) --> 
    [].

quant(_15872,[quant,_15910],_15896,_15898) --> 
    w(nb(_15872,num),_15910,_15896,_15898).

filanepr(_15872,[filanepr,_15910,!],_15896,_15898) --> 
    flnp(_15872,_15910,_15896,_15898),
    !.

filanepr(nil,[filanepr,[]],_15891,_15891) --> 
    [].

busseno(_15872,_15873,_15874,[busseno,_15936,_15975,_15999,_16023,!],_15916,_15918) --> 
    busnoun(_15873,_15889,_15890,_15936,_15916,_15957),
    nr0(_15975,_15957,_15990),
    colon0(_15999,_15990,_16014),
    busnumber(_15872,_15874,_16023,_16014,_15918),
    !.

busseno(_15872,_15873,_15874,[busseno,_15933,_15957,_15991,!],_15913,_15915) --> 
    nr0(_15933,_15913,_15948),
    busnumber(_15872,_15874,_15957,_15948,_15976),
    busnoun(_15873,_15889,_15890,_15991,_15976,_15915),
    !.

busnumber(_15872,_15873,[busnumber,_16027,_16071,{},_16110,_16139,_16168,_16192,_16221,_16250,_16279,_16308,_16337],_16010,_16012) --> 
    optional(w(noun(route,sin,u,n)),_16027,_16010,_16059),
    w(name(_15872,n,_15873),_16071,_16059,_16088),
    {user:test(subclass0(_15873,vehicle))},
    not_look_ahead(w(noun(minute,_15943,_15944,_15945)),_16110,_16088,_16127),
    not_look_ahead([:],_16139,_16127,_16156),
    point0(_16168,_16156,_16183),
    not_look_ahead(w(name(_15955,_15956,month)),_16192,_16183,_16209),
    not_look_ahead(w(name(_15955,_15964,day)),_16221,_16209,_16238),
    not_look_ahead(w(name(whitsun_day,_15972,date)),_16250,_16238,_16267),
    not_look_ahead(w(name(christmas_day,_15980,date)),_16279,_16267,_16296),
    not_look_ahead(w(name(easterday,_15988,date)),_16308,_16296,_16325),
    not_look_ahead(w(name(new_years_day,_15913,date)),_16337,_16325,_16012).

busnumber(_15872,number,[busnumber,_16016,_16060,_16089,_16118,_16147,_16171,_16200,_16229,_16258,_16287,_16316],_15999,_16001) --> 
    optional(w(noun(route,sin,u,n)),_16016,_15999,_16048),
    w(nb(_15872,num),_16060,_16048,_16077),
    not_look_ahead(w(noun(minute,_15932,_15933,_15934)),_16089,_16077,_16106),
    not_look_ahead([:],_16118,_16106,_16135),
    point0(_16147,_16135,_16162),
    not_look_ahead(w(name(_15944,_15945,month)),_16171,_16162,_16188),
    not_look_ahead(w(name(_15944,_15953,day)),_16200,_16188,_16217),
    not_look_ahead(w(name(whitsun_day,_15961,date)),_16229,_16217,_16246),
    not_look_ahead(w(name(christmas_day,_15969,date)),_16258,_16246,_16275),
    not_look_ahead(w(name(easterday,_15977,date)),_16287,_16275,_16304),
    not_look_ahead(w(name(new_years_day,_15910,date)),_16316,_16304,_16001).

busse0(_15872,_15873,_15874,_15875,[busse0,_15930,!],_15907,_15909) --> 
    busnoun(_15873,_15874,_15875,_15930,_15907,_15909),
    !.

busse0(_15872,_15872,u,sin,[busse0,[]],_15900,_15900) --> 
    [].

busnoun(_15872,_15873,_15874,[busnoun,_15946,!,{},_15990],_15926,_15928) --> 
    w(noun(_15872,_15874,_15873,n),_15946,_15926,_15963),
    !,
    {user:(test(subclass0(_15872,vehicle));_15872=number)},
    point0(_15990,_15963,_15928).

aname_phrase(0,_15873,_15876::_15876 and _15880,[aname_phrase,_15961,_15985,_16014,_16043,{},!],_15941,_15943) --> 
    a0(_15961,_15941,_15976),
    look_ahead(w(name(_15901,n,_15903)),_15985,_15976,_16002),
    preadjs(_15905,_16014,_16002,_16031),
    noun2(_15907,_15908,n,_15873,_15911,_16043,_16031,_15943),
    {user:preadjs_template(_15905,_15873,_15911,_15880)},
    !.

aname_phrase(_15872,_15873,_15876::_15876 and _15880,[aname_phrase,_15964,_15993,lit(gang),!,_16038,_16062],_15944,_15946) --> 
    w(name(_15902,n,route),_15964,_15944,_15981),
    w(adj2(next,nil),_15993,_15981,_16010),
    cc(gang,_16010,_16032),
    !,
    accept(_16038,_16032,_16053),
    pushstack(first,w(name(_15902,n,route)),nil,_16053,_16072),
    namep(_15872,_15873,_15880,_16062,_16072,_15946).

aname_phrase(_15872,_15873,_15874,[aname_phrase,_15937,_15966,_15995,!,_16024],_15917,_15919) --> 
    number(_15888,_15937,_15917,_15954),
    not_look_ahead(w(prep(from)),_15966,_15954,_15983),
    filanepr(_15995,_15983,_16010),
    !,
    reject(_16024,_16010,_15919).

aname_phrase(_15872,_15873,_15874,[aname_phrase,_15951,_15975,_15999,_16028,{},!,_16072],_15931,_15933) --> 
    dent0(_15951,_15931,_15966),
    filanepr(_15975,_15966,_15990),
    bus_number(_15894,_15999,_15990,_16016),
    w(noun(_15898,plu,_15900,_15901),_16028,_16016,_16045),
    {user:testmember(_15898,[bus])},
    !,
    reject(_16072,_16045,_15933).

aname_phrase(_15872,_15873,_15874,[aname_phrase,_15957,_15981,_16010,_16044,{},!,_16088],_15937,_15939) --> 
    dent0(_15957,_15937,_15972),
    w(adj2(_15896,nil),_15981,_15972,_15998),
    gmem(_15896,[nearest],_16010,_15998,_16029),
    w(name(_15906,_15907,_15908),_16044,_16029,_16061),
    {user:(\+number(_15906))},
    !,
    reject(_16088,_16061,_15939).

aname_phrase(_15872,_15873,_15876::_15877,[aname_phrase,_15959,_15983,_16012,_16041,_16070,{}],_15939,_15941) --> 
    a0(_15959,_15939,_15974),
    preadjs0(_15896,_15983,_15974,_16000),
    not_look_ahead([jeg],_16012,_16000,_16029),
    not_look_ahead([du],_16041,_16029,_16058),
    name_phrase(_15872,_15873,_15876::_15898,_16070,_16058,_15941),
    {user:preadjs_template(_15896,_15873,_15898,_15877)}.

aname_phrase(_15872,_15873,_15876::_15877,[aname_phrase,_15937,_15966,_15990],_15917,_15919) --> 
    not_look_ahead([ett],_15937,_15917,_15954),
    a0(_15966,_15954,_15981),
    name_phrase(_15872,_15873,_15876::_15877,_15990,_15981,_15919).

aname_phrase(name,_15873,_15874,[aname_phrase,_15921],_15901,_15903) --> 
    person_name(_15873,_15874,_15878,_15921,_15901,_15903).

name_phrase(0,_15873,_15876::_15877,[name_phrase,_16015,_16044,_16073,_16102,_16126,_16155,!,{},{},_16209],_15995,_15997) --> 
    w(noun(time,sin,def,n),_16015,_15995,_16032),
    w(nb(_15926,num),_16044,_16032,_16061),
    w(nb(_15931,num),_16073,_16061,_16090),
    to0(_16102,_16090,_16117),
    w(nb(_15936,num),_16126,_16117,_16143),
    w(nb(_15941,num),_16155,_16143,_16172),
    !,
    {user:_15946 is _15926*100+_15931},
    {user:_15915 is _15936*100+_15941},
    lock(exact,_16172,_16322),
    pushstack(exact,(time1(_15946),and1,time1(_15915)),nil,_16322,_16328),
    noun_phrases(_15873,_15876::_15877,_16209,_16328,_16317),
    unlock(_16317,_15997).

name_phrase(0,_15873,_15876::_15877,[name_phrase,_15965,_15994,_16023,_16047,!,_16081],_15945,_15947) --> 
    w(noun(time,sin,def,n),_15965,_15945,_15982),
    timexp(_15912,_15994,_15982,_16011),
    to0(_16023,_16011,_16038),
    timexp(_15903,_16047,_16038,_16064),
    !,
    pushstack(first,(time1(_15912),and1,time1(_15903)),nil,_16064,_16179),
    noun_phrases(_15873,_15876::_15877,_16081,_16179,_15947).

name_phrase(_15872,_15873,_15876::_15879 and _15876,[name_phrase,_15949,_15978,_16017],_15929,_15931) --> 
    look_ahead(w(nb(_15901,_15902)),_15949,_15929,_15966),
    namep(_15872,_15873,_15879,_15978,_15966,_15999),
    not_look_ahead(w(noun(minute,_15893,_15894,_15895)),_16017,_15999,_15931).

name_phrase(_15872,_15873,_15876::_15879 and _15876,[name_phrase,_15949,_15978,_16017],_15929,_15931) --> 
    look_ahead(w(nb(_15901,_15902)),_15949,_15929,_15966),
    namep(_15872,_15873,_15879,_15978,_15966,_15999),
    not_look_ahead(w(noun(minute,_15893,_15894,_15895)),_16017,_15999,_15931).

name_phrase(_15872,_15873,_15876::_15879 and _15876,[name_phrase,_15927],_15907,_15909) --> 
    namep(_15872,_15873,_15879,_15927,_15907,_15909).

person_name((_15879,_15882,_15883):person,_15885 and _15888 and _15889,_15874,[person_name,_15956,_15995,_16034,!,_16078],_15936,_15938) --> 
    properfirstname(_15879,_15885,_15905,_15956,_15936,_15977),
    properfirstname(_15882,_15888,_15909,_15995,_15977,_16016),
    properlastname(_15883,_15889,_15874,_16034,_16016,_16055),
    !,
    accept(_16078,_16055,_15938).

person_name((_15879,_15880):person,_15882 and _15883,_15874,[person_name,_15943,_15982,!,_16026],_15923,_15925) --> 
    properfirstname(_15879,_15882,_15896,_15943,_15923,_15964),
    properlastname(_15880,_15883,_15874,_15982,_15964,_16003),
    !,
    accept(_16026,_16003,_15925).

properfirstname(_15872,_15873,_15874,[properfirstname,_15924],_15904,_15906) --> 
    name1g(_15872:firstname,_15873,_15874,_15924,_15904,_15906).

properlastname(_15872,_15873,_15874,[properlastname,_15924],_15904,_15906) --> 
    name1g(_15872:lastname,_15873,_15874,_15924,_15904,_15906).

np_head(_15872,_15873,_15874,[np_head,lit(ett),_15946,!,_15980],_15915,_15917) --> 
    cc(ett,_15915,_15945),
    w(noun(time,_15890,def,_15892),_15946,_15945,_15963),
    !,
    reject(_15980,_15963,_15917).

np_head(0,_15873,_15876::_15877,[np_head,_15973,_15997,_16026,!,_16070,_16099,{},{}],_15953,_15955) --> 
    the0(_15973,_15953,_15988),
    preadjs0(_15907,_15997,_15988,_16014),
    quantifier(_15873,_15905,_15905 and _15876::_15877,_16026,_16014,_16047),
    !,
    preadjs0(_15902,_16070,_16047,_16087),
    noun_complex(_15921,_15873,_15923,_16099,_16087,_15955),
    {user:preadjs_template(_15907,_15873,_15923,_15904)},
    {user:preadjs_template(_15902,_15873,_15904,_15905)}.

np_head(_15872,_15873,_15874,[np_head,_15977,_16026,{},_16065,_16094,{}],_15957,_15959) --> 
    determiner0(_15898,_15872,_15873,_15896,_15874,_15977,_15957,_16002),
    preadjs0(_15893,_16026,_16002,_16043),
    {user:(_15893=true->_15911=_15898;_15911=_15912)},
    not_look_ahead(w(noun(crown,_15928,_15929,_15930)),_16065,_16043,_16082),
    noun_complex(_15911,_15873,_15895,_16094,_16082,_15959),
    {user:preadjs_template(_15893,_15873,_15895,_15896)}.

np_head(0,_15873,_15876::findpron(_15891)::exists(_15873)::_15885 and _15888 and _15876,[np_head,_15977,_16001,_16055,!,_16089,{}],_15957,_15959) --> 
    thispron(_15977,_15957,_15992),
    noun(_15916,_15917,_15918,gen,_15891,_15888,_16001,_15992,_16028),
    look_ahead(w(nb(_15927,num)),_16055,_16028,_16072),
    !,
    np0_accept(_15873,_15914::_15885,_16089,_16072,_15959),
    {user:has_template(_15891,_15873,_15914)}.

np_head(0,_15873,_15876::findpron(_15897)::exists(_15873)::_15885 and _15888 and _15891 and _15894 and _15876,[np_head,_15989,_16013,!,_16072,_16101,_16140,{},{}],_15969,_15971) --> 
    thispron(_15989,_15969,_16004),
    noun(_15928,_15929,_15930,gen,_15897,_15891,_16013,_16004,_16040),
    !,
    preadjs0(_15935,_16072,_16040,_16089),
    noun_compound(_15873,_15888,_15939,_16101,_16089,_16122),
    not_look_aheadnounx(_16140,_16122,_15971),
    {user:preadjs_template(_15935,_15873,_15888,_15885)},
    {user:has_template(_15897,_15873,_15894)}.

not_look_aheadnounx([not_look_aheadnounx,_15909,!],_15898,_15900) --> 
    look_ahead(w(verb(_15879,_15880,fin)),_15909,_15898,_15900),
    !.

not_look_aheadnounx([not_look_aheadnounx,_15910,!],_15899,_15901) --> 
    look_ahead(w(noun(clock,_15880,_15881,_15882)),_15910,_15899,_15901),
    !.

not_look_aheadnounx([not_look_aheadnounx,_15907],_15896,_15898) --> 
    not_look_ahead(w(noun(_15876,_15877,_15878,_15879)),_15907,_15896,_15898).

noun_complex(_15872,_15876:_15877,_15876 isa _15877,[noun_complex,_15972,_16001,_16030,_16059,{},!],_15952,_15954) --> 
    not_look_ahead(w(nb(_15901,_15902)),_15972,_15952,_15989),
    w(name(_15876,n,_15908),_16001,_15989,_16018),
    not_look_ahead(w(verb(_15914,pres,fin)),_16030,_16018,_16047),
    w(noun(_15920,_15872,_15922,n),_16059,_16047,_15954),
    {user:joinclass(_15920,_15908,_15877)},
    !.

noun_complex(sin,_15876:_15877,_15876 isa _15877,[noun_complex,_15940,_15969,!],_15920,_15922) --> 
    w(noun(_15877,sin,_15892,n),_15940,_15920,_15957),
    w(quote(_15876),_15969,_15957,_15922),
    !.

noun_complex(sin,_15876:_15880,_15876 isa _15877,[noun_complex,_15990,_16019,_16048,_16077,_16106,_16130,{},!],_15970,_15972) --> 
    w(noun(_15877,sin,_15907,n),_15990,_15970,_16007),
    not_look_ahead([du],_16019,_16007,_16036),
    w(name(_15876,n,_15918),_16048,_16036,_16065),
    not_look_ahead(w(noun(minute,_15925,_15926,_15927)),_16077,_16065,_16094),
    point0(_16106,_16094,_16121),
    not_look_ahead(w(name(_15933,_15934,date)),_16130,_16121,_15972),
    {user:(joinclass(_15877,_15918,_15880),_15880\==nil)},
    !.

noun_complex(sin,_15876:_15877,_15876 isa _15877,[noun_complex,_15972,_16001,{},_16040,_16064,!],_15952,_15954) --> 
    w(noun(_15877,_15900,_15901,n),_15972,_15952,_15989),
    w(nb(_15876,num),_16001,_15989,_16018),
    {user:testmember(_15877,[footnote,page,sms,telephone,week,year])},
    and1(_16040,_16018,_16055),
    w(nb(_15928,_15929),_16064,_16055,_15954),
    !.

noun_complex(_15872,_15876:_15877,_15876 isa _15877,[noun_complex,_15963,_15992,{},!],_15943,_15945) --> 
    w(noun(_15877,_15872,_15895,n),_15963,_15943,_15980),
    w(nb(_15876,num),_15992,_15980,_15945),
    {user:testmember(_15877,[footnote,page,sms,telephone,week,year,number])},
    !.

noun_complex(_15872,_15876:_15877,_15876 isa _15877,[noun_complex,_16008,{},_16047,_16081,_16110,_16144,_16173,_16202,_16231,!,_16265],_15988,_15990) --> 
    w(noun(_15877,_15872,_15916,n),_16008,_15988,_16025),
    {user:subtype0(_15877,vehicle)},
    plausibleno(_15877,_15876,_16047,_16025,_16066),
    not_look_ahead([ganger],_16081,_16066,_16098),
    plausibleno(_15877,_15876,_16110,_16098,_16129),
    not_look_ahead_lit([sin,sitt,sine],_16144,_16129,_16161),
    not_look_ahead(w(name(_15946,_15947,month)),_16173,_16161,_16190),
    not_look_ahead(w(name(_15946,_15955,date)),_16202,_16190,_16219),
    not_look_ahead(w(noun(_15962,plu,_15964,_15965)),_16231,_16219,_16248),
    !,
    accept(_16265,_16248,_15990).

noun_complex(plu,_15876:_15877,_15876 isa _15877,[noun_complex,_15944,_15978,{}],_15924,_15926) --> 
    plausibleno(_15877,_15876,_15944,_15924,_15963),
    w(noun(_15877,sin,u,n),_15978,_15963,_15926),
    {user:subtype0(_15877,vehicle)}.

noun_complex(_15872,_15873,_15874,[noun_complex,_15942,_15981,_16010],_15922,_15924) --> 
    noun_list(_15872,_15873,_15874,_15942,_15922,_15963),
    not_look_ahead_lit([sin,sitt,sine],_15981,_15963,_15998),
    not_look_ahead(w(nb(_15886,_15887)),_16010,_15998,_15924).

noun_complex(_15872,_15873,_15874,[noun_complex,_15935,_15964,_15993],_15915,_15917) --> 
    not_look_ahead([noe],_15935,_15915,_15952),
    not_look_ahead([min],_15964,_15952,_15981),
    noun_compound(_15873,_15874,_15872,_15993,_15981,_15917).

plausibleno(_15872,_15873,[plausibleno,_15925,_15954,_15978,!,_16007],_15908,_15910) --> 
    num(_15887,_15925,_15908,_15942),
    point(_15954,_15942,_15969),
    monthnamex(_15978,_15969,_15993),
    !,
    reject(_16007,_15993,_15910).

plausibleno(_15872,_15873,[plausibleno,_15922,_15951,!,_15980],_15905,_15907) --> 
    num(_15884,_15922,_15905,_15939),
    colon(_15951,_15939,_15966),
    !,
    reject(_15980,_15966,_15907).

plausibleno(_15872,_15873,[plausibleno,_15924,_15953,!,_15987],_15907,_15909) --> 
    num(_15884,_15924,_15907,_15941),
    monthname(_15886,_15953,_15941,_15970),
    !,
    reject(_15987,_15970,_15909).

plausibleno(_15872,_15873,[plausibleno,_15930,_15954,{}],_15913,_15915) --> 
    nr0(_15930,_15913,_15945),
    num(_15873,_15954,_15945,_15915),
    {user:(_15873>0,_15873<1000)}.

plausibleno(_15872,_15873,[plausibleno,_15927,_15951,{}],_15910,_15912) --> 
    nr0(_15927,_15910,_15942),
    w(nb(_15873,alf),_15951,_15942,_15912),
    {user:_15873<1000}.

npa(_15884:_15885,_15875::findexternal(_15884:_15885)::_15884 isa _15885 and _15875,[npa,_15957,_15986,!,{}],_15940,_15942) --> 
    one_of_lit([det,dette],_15957,_15940,_15974),
    look_ahead(w(adv(_15919)),_15986,_15974,_15942),
    !,
    {user:_15885=thing}.

npa(_15884:_15885,_15875::findexternal(_15884:_15885)::_15884 isa _15885 and _15875,[npa,lit(dette),_15955,{}],_15927,_15929) --> 
    cc(dette,_15927,_15954),
    not_look_ahead_np(_15955,_15954,_15929),
    {user:_15885=thing}.

npa(_15884:_15885,_15875::findexternal(_15884:thing)::_15884 isa _15885 and _15875,[npa,lit(det),_15958,_15987],_15930,_15932) --> 
    cc(det,_15930,_15957),
    look_ahead(w(verb(_15907,_15908,fin)),_15958,_15957,_15975),
    not_look_ahead_np(_15987,_15975,_15932).

npa(_15872,_15875::findit(_15881)::_15879,[npa,_15948,_15972,_16011,{}],_15931,_15933) --> 
    its(_15948,_15931,_15963),
    determiner00(_15872,_15905 and _15896,_15875::_15879,_15972,_15963,_15993),
    noun_compound(_15872,_15905,_15910,_16011,_15993,_15933),
    {user:has_template(_15881,_15872,_15896)}.

npa(_15872,_15873,[npa,_15920,_15944,!,_15973],_15903,_15905) --> 
    this(_15920,_15903,_15935),
    look_ahead_np(_15944,_15935,_15959),
    !,
    reject(_15973,_15959,_15905).

npa(_15872,_15875::find(_15872)::_15881 and _15875,[npa,_15929],_15912,_15914) --> 
    noun(_15886,_15887,def,n,_15872,_15881,_15929,_15912,_15914).

npa(_15884:_15885,_15875::findexternal(_15884:_15885)::_15884 isa _15893 and _15875,[npa,lit(denne),_15979,_16008,{},{}],_15951,_15953) --> 
    cc(denne,_15951,_15978),
    not_look_ahead(w(adj),_15979,_15978,_15996),
    not_look_ahead(w(noun(_15922,_15923,_15924,_15925)),_16008,_15996,_15953),
    {user:_15893=thing},
    {user:type(_15893,_15885)}.

npa(_15884:_15885,_15875::findpron(_15884:_15885)::_15884 isa thing and _15875,[npa,lit(det),_15955,{}],_15927,_15929) --> 
    cc(det,_15927,_15954),
    endofline(_15955,_15954,_15929),
    {user:type(thing,_15885)}.

npa(_15872,_15875::_15876,[npa,_15957,_15981,_16010,_16039],_15940,_15942) --> 
    allsome0(_15957,_15940,_15972),
    posspron(_15901,_15981,_15972,_15998),
    w(nb(_15898,num),_16010,_15998,_16027),
    pushstack(first,(thispron,w(noun(_15901,sin,u,gen)),w(nb(_15898,num))),nil,_16027,_16080),
    np1(_15872,_15875::_15876,_16039,_16080,_15942).

npa(_15872,_15875::_15876,[npa,_15941,_15965,_15994],_15924,_15926) --> 
    allsome0(_15941,_15924,_15956),
    posspron(_15892,_15965,_15956,_15982),
    pushstack(first,(thispron,w(noun(_15892,sin,u,gen))),nil,_15982,_16032),
    np1(_15872,_15875::_15876,_15994,_16032,_15926).

npa(_15872,_15873,[npa,lit(de),_15995,_16024,_16053,_16082,!,_16116],_15967,_15969) --> 
    cc(de,_15967,_15994),
    w(nb(_15913,num),_15995,_15994,_16012),
    flnp(_15916,_16024,_16012,_16041),
    not_look_ahead(w(name(_15922,_15923,_15924)),_16053,_16041,_16070),
    not_look_ahead(w(noun(_15930,_15931,_15932,_15933)),_16082,_16070,_16099),
    !,
    pushstack(first,(w(nb(_15913,num)),w(adj2(_15916,nil)),w(noun(vehicle,sin,u,n))),nil,_16099,_16126),
    np1(_15872,_15873,_16116,_16126,_15969).

npa(_15872,_15875::_15876,[npa,_16000,_16024,_16053,_16082,_16111,_16140,_16164,_16193,!,_16227],_15983,_15985) --> 
    dent0(_16000,_15983,_16015),
    not_look_ahead([først],_16024,_16015,_16041),
    not_look_ahead([sist],_16053,_16041,_16070),
    not_look_ahead([senest],_16082,_16070,_16099),
    not_look_ahead([tidligst],_16111,_16099,_16128),
    nest(_16140,_16128,_16155),
    flnp(_15937,_16164,_16155,_16181),
    not_look_ahead(w(noun(_15943,_15944,_15945,_15946)),_16193,_16181,_16210),
    !,
    pushstack(first,(w(adj2(second,nil)),w(adj2(_15937,nil)),w(noun(vehicle,sin,u,n))),nil,_16210,_16237),
    np1(_15872,_15875::_15876,_16227,_16237,_15985).

npa(_15872,_15875::_15876,[npa,_16004,_16028,_16057,_16086,_16115,!,_16149,_16220],_15987,_15989) --> 
    dent0(_16004,_15987,_16019),
    not_look_ahead([f,s,først,sist,senest,tidligst],_16028,_16019,_16045),
    flnp(_15922,_16057,_16045,_16074),
    not_look_ahead(w(name(_15928,_15929,_15930)),_16086,_16074,_16103),
    not_look_ahead(w(noun(_15936,_15937,_15938,_15939)),_16115,_16103,_16132),
    !,
    pushstack(first,(a,w(adj2(_15922,nil)),w(noun(vehicle,sin,u,n))),nil,_16132,_16190),np1(_15872,_15875::_15876,_16149,_16190,_16205),
    optional(w(noun(bus,sin,_15905,_15906)),_16220,_16205,_15989).

npa(_15872,_15873,[npa,{},lit(den),_15973,_16002,!,_16036],_15935,_15937) --> 
    {user:value(busflag,true)},
    cc(den,_15935,_15972),
    not_look_ahead(w(adj2(_15904,nil)),_15973,_15972,_15990),
    not_look_ahead(w(noun(_15911,_15912,_15913,_15914)),_16002,_15990,_16019),
    !,
    npit(_15872,_15873,_16036,_16019,_15937).

npa(_15872,_15875::_15876,[npa,lit(den),_15974,_16003,!,_16037],_15946,_15948) --> 
    cc(den,_15946,_15973),
    not_look_ahead(w(adj2(_15909,nil)),_15974,_15973,_15991),
    not_look_ahead(w(noun(_15916,_15917,_15918,_15919)),_16003,_15991,_16020),
    !,
    lock(exact,_16020,_16082),
    pushstack(exact,(this,w(noun(thing,sin,u,n))),nil,_16082,_16088),
    np1(_15872,_15875::_15876,_16037,_16088,_16077),
    unlock(_16077,_15948).

npit(_15881:_15882,_15875::_15881 isa _15882 and _15875,[npit,{}],_15913,_15913) --> 
    {user:it_template(_15881:_15882)}.

adjnoun([adjnoun,_15903],_15892,_15894) --> 
    w(adj2(nil,nil),_15903,_15892,_15894).

adjnoun([adjnoun,_15905],_15894,_15896) --> 
    w(noun(_15874,plu,u,_15877),_15905,_15894,_15896).

np2(_15872,_15873,[np2,lit(noe),_15963,_15992,!,_16021],_15935,_15937) --> 
    cc(noe,_15935,_15962),
    w(adj2(_15904,_15905),_15963,_15962,_15980),
    not_look_ahead_np(_15992,_15980,_16007),
    !,
    lock(exact,_16007,_16038),
    pushstack(exact,(w(adj2(_15904,_15905)),w(noun(thing,sin,u,n))),nil,_16038,_16044),
    np_kernel(0,_15872,_15873,_16021,_16044,_16033),
    unlock(_16033,_15937).

np2(_15872,_15873,[np2,lit(noe),_15961,!,_15995,_16056],_15933,_15935) --> 
    cc(noe,_15933,_15960),
    look_ahead(w(prep(_15898)),_15961,_15960,_15978),
    !,
    lock(exact,_15978,_16015),pushstack(exact,w(noun(thing,sin,u,n)),nil,_16015,_16021),np_kernel(0,_15872,_15889,_15995,_16021,_16010),unlock(_16010,_16011),
    noun_modifiers0(0,_15872,_15889,_15873,_16056,_16011,_15935).

np2(_15872,_15873,[np2,_15983,_16017,{},!,_16061,!],_15966,_15968) --> 
    clock_kernel(_15893:clock,_15893 isa clock,_15983,_15966,_16002),
    w(noun(_15901,sin,_15903,n),_16017,_16002,_16034),
    {user:testmember(_15901,[departure,arrival])},
    !,
    lock(exact,_16034,_16114),pushstack(exact,(w(noun(_15901,sin,def,n)),w(prep(at)),clock_kernel(_15893:clock,_15893 isa clock)),nil,_16114,_16120),np1(_15872,_15873,_16061,_16120,_16109),unlock(_16109,_15968),
    !.

np2(_15872,_15873,[np2,_15970,_15994,lit(enn),!,_16039,!,_16078,!],_15953,_15955) --> 
    anders(_15970,_15953,_15985),
    w(noun(_15898,_15899,_15900,n),_15994,_15985,_16011),
    cc(enn,_16011,_16033),
    !,
    np1(_15905,_15906,_16039,_16033,_16058),
    !,
    lock(exact,_16058,_16129),pushstack(exact,(w(noun(_15898,_15899,_15900,n)),w(prep(except)),xnp(_15905,_15906)),nil,_16129,_16135),np1(_15872,_15873,_16078,_16135,_16124),unlock(_16124,_15955),
    !.

anders([anders,lit(andre),!],_15892,_15894) --> 
    cc(andre,_15892,_15894),
    !.

anders([anders,lit(en),lit(annen),!],_15897,_15899) --> 
    cc(en,_15897,_15918),
    cc(annen,_15918,_15899),
    !.

np2(_15872,_15873,[np2,lit(samme),_15983,lit(som),!,_16028,!,_16067,!],_15955,_15957) --> 
    cc(samme,_15955,_15982),
    w(noun(_15900,sin,u,n),_15983,_15982,_16000),
    cc(som,_16000,_16022),
    !,
    np1(_15907,_15908,_16028,_16022,_16047),
    !,
    lock(exact,_16047,_16118),pushstack(exact,(w(noun(_15900,sin,def,n)),w(prep(as)),xnp(_15907,_15908)),nil,_16118,_16124),np1(_15872,_15873,_16067,_16124,_16113),unlock(_16113,_15957),
    !.

np2(_15881:_15882,_15875::_15878 and _15875,[np2,_15989,_16018,_16052,{},{}],_15972,_15974) --> 
    w(name(_15915,n,_15917),_15989,_15972,_16006),
    gmem(_15917,[company],_16018,_16006,_16037),
    w(noun(_15882,_15927,_15928,n),_16052,_16037,_15974),
    {user:subclass0(_15882,vehicle)},
    {user:_15878=(exists(_15881)::_15881 isa _15882 and _15915 isa _15917 and adj/nil/_15915/_15881/real)}.

np2(_15872,_15873,[np2,_16019,{},{},_16068,_16097,_16126,{},!,_16170,_16194,!],_16002,_16004) --> 
    w(name(_15907,n,_15909),_16019,_16002,_16036),
    {user:testmember(_15909,[neighbourhood,station,street])},
    {user:(\+testmember(_15907,[sentrum]))},
    w(noun(_15933,_15934,_15935,n),_16068,_16036,_16085),
    not_look_ahead([nr],_16097,_16085,_16114),
    not_look_ahead(w(nb(_15946,_15947)),_16126,_16114,_16143),
    {user:subclass0(_15933,vehicle)},
    !,
    accept(_16170,_16143,_16185),
    lock(exact,_16185,_16214),pushstack(exact,(w(noun(_15933,sin,def,n)),w(prep(to)),w(name(_15907,n,_15909))),nil,_16214,_16220),np1(_15872,_15873,_16194,_16220,_16209),unlock(_16209,_16004),
    !.

np2(_15872,_15873,[np2,_15973,{},_16012,_16041,!,_16075,_16099,!],_15956,_15958) --> 
    w(nb(_15898,num),_15973,_15956,_15990),
    {user:this_year(_15898)},
    not_look_ahead([-],_16012,_15990,_16029),
    not_look_ahead(w(nb(_15913,_15914)),_16041,_16029,_16058),
    !,
    accept(_16075,_16058,_16090),
    lock(exact,_16090,_16119),pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_15898,num))),nil,_16119,_16125),np1(_15872,_15873,_16099,_16125,_16114),unlock(_16114,_15958),
    !.

np2(_15872,_15873,[np2,_15953,_15977,lit(enn),!,_16022],_15936,_15938) --> 
    oter(_15953,_15936,_15968),
    w(noun(_15900,_15901,u,n),_15977,_15968,_15994),
    cc(enn,_15994,_16016),
    !,
    pushstack(first,(a,w(noun(_15900,sin,u,n)),[ulik]),nil,_16016,_16060),
    np1(_15872,_15873,_16022,_16060,_15938).

np2(_15872,_15875::_15876,[np2,_15957,_15986,_16015,_16049],_15940,_15942) --> 
    not_look_ahead([alle],_15957,_15940,_15974),
    not_look_ahead(w(name(_15908,_15909,_15910)),_15986,_15974,_16003),
    quant_pron(every,_15895,_16015,_16003,_16034),
    pushstack(first,(every,w(noun(_15895,sin,u,n))),nil,_16034,_16087),
    np1(_15872,_15875::_15876,_16049,_16087,_15942).

np2(_15872,_15873,[np2,_15943,_15977,_16006,_16030],_15926,_15928) --> 
    quant_pron(every,_15892,_15943,_15926,_15962),
    not_look_ahead([som],_15977,_15962,_15994),
    not_look_ahead_np(_16006,_15994,_16021),
    pushstack(first,(every,w(noun(_15892,sin,u,n))),nil,_16021,_16068),
    np0_accept(_15872,_15873,_16030,_16068,_15928).

np2(_15872,_15873,[np2,_15934,_15968,_15992,_16021,_16045],_15917,_15919) --> 
    quant_pron(some,_15887,_15934,_15917,_15953),
    rfxpron0(_15968,_15953,_15983),
    not_look_ahead([som],_15992,_15983,_16009),
    not_look_ahead_np(_16021,_16009,_16036),
    np00(_15887,_15872,_15873,_16045,_16036,_15919).

clock_number(_15874:_15875,[clock_number,_15923,{},!],_15909,_15911) --> 
    number(_15874:_15875,_15923,_15909,_15911),
    {user:clock_test(_15874)},
    !.

bus_number(_15874:_15875,[bus_number,_15920,{}],_15906,_15908) --> 
    number(_15874:_15875,_15920,_15906,_15908),
    {user:plausible_busno(_15874)}.

road_number(_15874:_15875,[road_number,_15921,{}],_15907,_15909) --> 
    number(_15874:_15875,_15921,_15907,_15909),
    {user:_15874=<200}.

noun_list2(_15872,_15873,_15874,[noun_list2,_15932,_15986],_15912,_15914) --> 
    noun(_15884,_15872,u,n,_15879,_15880,_15932,_15912,_15959),
    nlists10(_15879,_15880,_15873,_15874,_15986,_15959,_15914).

nlists10(_15880:_15881,_15873,(_15880,_15890):(_15881,_15887),_15873 and _15878,[nlists10,_15959,_15983,_16037],_15936,_15938) --> 
    comma(_15959,_15936,_15974),
    noun(_15903,_15904,_15905,n,_15898,_15899,_15983,_15974,_16010),
    nlists10(_15898,_15899,_15890:_15887,_15878,_16037,_16010,_15938).

nlists10(_15880:_15881,_15873,(_15880,_15890):(_15881,_15887),_15873 and _15878,[nlists10,_15953,_15982],_15930,_15932) --> 
    andor(_15902,_15953,_15930,_15970),
    noun(_15895,_15896,_15897,n,_15890:_15887,_15878,_15982,_15970,_15932).

noun_list(_15872,_15873,_15874,[noun_list,_15975,_16004,_16033,_16062,_16091,{},_16155],_15955,_15957) --> 
    not_look_ahead([noe],_15975,_15955,_15992),
    not_look_ahead([noen],_16004,_15992,_16021),
    not_look_ahead([min],_16033,_16021,_16050),
    not_look_ahead(w(adj2(_15915,nil)),_16062,_16050,_16079),
    noun(_15918,_15872,_15920,n,_15894,_15895,_16091,_16079,_16118),
    {user:(\+testmember(_15918,[clock]))},
    nlists0join(_15894,_15895,_15873,_15874,_16155,_16118,_15957).

nlists0join(_15872,_15873,_15877:_15878,_15875,[nlists0join,_15956,{},!,_16015,{}],_15933,_15935) --> 
    nlists0(_15872,_15873,_15877:_15903,_15875,_15956,_15933,_15979),
    {user:joinclasses(_15903,_15878)},
    !,
    accept(_16015,_15979,_15935),
    {user:_15878\==thing}.

nlists0(_15880:_15881,_15873,(_15880,_15890):(_15881,_15887),_15873 and _15878,[nlists0,lit(og),_16015,_16044,_16098,{},{},_16147],_15981,_15983) --> 
    cc(og,_15981,_16014),
    not_look_ahead_lit([da,så,min],_16015,_16014,_16032),
    noun(_15925,_15926,_15927,n,_15910,_15911,_16044,_16032,_16071),
    not_look_ahead(w(prep(_15936)),_16098,_16071,_16115),
    {user:joinclass(_15881,_15925,_15942)},
    {user:(_15942\==thing,_15942\==nil)},
    nlists0(_15910,_15911,_15890:_15887,_15878,_16147,_16115,_15983).

nlists0(_15872,_15873,_15872,_15873,[nlists0,[],_15940],_15912,_15914) --> 
    [],
    not_look_ahead(w(noun(_15884,_15885,_15886,_15887)),_15940,_15912,_15914).

postcode(_15872,[postcode,_15954,{},_15993,{}],_15940,_15942) --> 
    w(nb(_15872,num),_15954,_15940,_15971),
    {user:(number(_15872),_15872>=1000,_15872=<9999)},
    look_ahead(w(name(_15919,n,_15885)),_15993,_15971,_15942),
    {user:testmember(_15885,[city,neighbourhood,station])}.

noun_compound(_15872,_15873,sin,[noun_compound,_15941,_15970,_16009,_16033],_15921,_15923) --> 
    not_look_ahead([man],_15941,_15921,_15958),
    namep(_15896,_15887,_15888,_15970,_15958,_15991),
    sin(_16009,_15991,_16024),
    ncomps0(gen,_15872,_15887,_15888,_15873,_15890,_16033,_16024,_15923).

noun_compound(_15872,_15876 and _15877,_15874,[noun_compound,_15952,_15981,_16010,{}],_15932,_15934) --> 
    not_look_ahead([dere],_15952,_15932,_15969),
    w(name(_15890,_15901,_15902),_15981,_15969,_15998),
    noun(_15904,_15874,u,n,_15872,_15876,_16010,_15998,_15934),
    {user:adjnamecomp_template(_15890,_15872,_15877)}.

noun_compound(_15872,_15873,_15874,[noun_compound,_15956,_15985,{},_16044,_16088],_15936,_15938) --> 
    not_look_ahead([man],_15956,_15936,_15973),
    noun2(_15899,_15900,_15901,_15890,_15891,_15985,_15973,_16010),
    {user:_15874=_15899},
    s0(_15899,_15900,_15901,_15888,_16044,_16010,_16067),
    ncomps0(_15888,_15872,_15890,_15891,_15873,_15893,_16088,_16067,_15938).

morenames(_15872,(_15872,_15876),[morenames,_15922,_15951],_15905,_15907) --> 
    unplausible_name(_15881,_15922,_15905,_15939),
    morenames(_15881,_15876,_15951,_15939,_15907).

morenames(_15872,_15872,[morenames,[]],_15894,_15894) --> 
    [].

unplausible_name(_15872,[unplausible_name,_15917,!,_15951],_15903,_15905) --> 
    w(name(_15872,unknown,_15884),_15917,_15903,_15934),
    !,
    accept(_15951,_15934,_15905).

ncomps0(gen,_15873,_15874,_15875,_15876,0,[ncomps0,_15955,_15984,{}],_15926,_15928) --> 
    preadjs0(_15887,_15955,_15926,_15972),
    ncomps(_15873,_15874,_15890,_15876,_15984,_15972,_15928),
    {user:preadjs_template(_15887,_15873,_15875,_15890)}.

ncomps0(n,_15879:_15880,_15879:_15880,_15875,_15875,0,[ncomps0,_15948],_15919,_15921) --> 
    w(noun(_15880,_15888,_15889,n),_15948,_15919,_15921).

ncomps0(n,_15873,_15874,_15875,_15875,name,[ncomps0,{}],_15911,_15911) --> 
    {user:compatvar(_15873,_15874)}.

ncomps(_15872,_15873,_15874,_15875,[ncomps,_15954,{},_16013],_15931,_15933) --> 
    noun2(_15890,_15891,_15883,_15885,_15894,_15954,_15931,_15979),
    {user:has_template(_15873,_15885,_15900)},
    ncomps0(_15883,_15872,_15885,_15874 and _15894 and _15900,_15875,_15888,_16013,_15979,_15933).

s0(_15872,_15873,n,gen,[s0,_15923],_15900,_15902) --> 
    sin(_15923,_15900,_15902).

s0(_15872,_15873,n,gen,[s0,lit(s)],_15902,_15904) --> 
    cc(s,_15902,_15904).

s0(sin,u,n,n,[s0,[]],_15900,_15900) --> 
    [].

s0(sin,def,n,n,[s0,[]],_15900,_15900) --> 
    [].

s0(plu,u,n,n,[s0,[]],_15900,_15900) --> 
    [].

s0(plu,def,n,n,[s0,[]],_15900,_15900) --> 
    [].

s0(_15872,_15873,gen,gen,[s0,[]],_15900,_15900) --> 
    [].

noun_modifiers0(_15872,_15873,_15880::_15878,_15877::_15878,[noun_modifiers0,_15934],_15911,_15913) --> 
    noun_modsx0(_15872,_15873,_15877,_15880,_15934,_15911,_15913).

noun_modsx0(0,_15873,_15874,_15875,[noun_modsx0,_15927],_15904,_15906) --> 
    rel_clauses(_15873,_15874,_15875,_15927,_15904,_15906).

noun_modsx0(0,_15886:_15887,_15874,_15874 and _15889 isa coevent and _15883 and _15884,[noun_modsx0,{},lit(til),lit(at),!,_16029,{},!,_16078],_15969,_15971) --> 
    {user:testmember(_15887,[cause])},
    cc(til,_15969,_16012),
    cc(at,_16012,_16023),
    !,
    clausal_object1(_15889:coevent,true::_15884,_16029,_16023,_16048),
    {user:noun_compl(to,_15886:_15887,_15889:coevent,_15883)},
    !,
    accept(_16078,_16048,_15971).

noun_modsx0(0,_15886:_15887,_15874,_15874 and _15889 isa coevent and _15883 and _15884,[noun_modsx0,{},lit(for),lit(å),!,_16034,{},!,_16092],_15974,_15976) --> 
    {user:testmember(_15887,[way])},
    cc(for,_15974,_16017),
    cc(å,_16017,_16028),
    !,
    pushstack(first,[noen],nil,_16028,_16047),clausal_object1(_15889:coevent,true::_15884,_16034,_16047,_16062),
    {user:noun_compl(regarding,_15886:_15887,_15889:coevent,_15883)},
    !,
    accept(_16092,_16062,_15976).

noun_modsx0(0,_15886:_15887,_15874,_15874 and _15889 isa coevent and _15883 and _15884,[noun_modsx0,{},lit(for),lit(hvordan),!,_16029,{},!,_16078],_15969,_15971) --> 
    {user:testmember(_15887,[way])},
    cc(for,_15969,_16012),
    cc(hvordan,_16012,_16023),
    !,
    clausal_object1(_15889:coevent,true::_15884,_16029,_16023,_16048),
    {user:noun_compl(regarding,_15886:_15887,_15889:coevent,_15883)},
    !,
    accept(_16078,_16048,_15971).

noun_modsx0(0,_15886:_15887,_15874,_15874 and _15889 isa coevent and _15883 and _15884,[noun_modsx0,{},lit(om),lit(hvor),_16040,!,_16074,{},!,_16132],_15985,_15987) --> 
    {user:testmember(_15887,[question])},
    cc(om,_15985,_16028),
    cc(hvor,_16028,_16039),
    w(adj2(_15929,nil),_16040,_16039,_16057),
    !,
    pushstack(free,w(adj2(_15929,nil)),nil,_16057,_16087),clausal_object1(_15889:coevent,true::_15884,_16074,_16087,_16102),
    {user:noun_compl(regarding,_15886:_15887,_15889:coevent,_15883)},
    !,
    accept(_16132,_16102,_15987).

noun_modsx0(0,_15886:_15887,_15874,_15874 and _15889 isa coevent and _15883 and _15884,[noun_modsx0,{},lit(der),!,_16013,{},!,_16062],_15964,_15966) --> 
    {user:testmember(_15887,[example])},
    cc(der,_15964,_16007),
    !,
    clausal_object1(_15889:coevent,true::_15884,_16013,_16007,_16032),
    {user:noun_compl(on,_15886:_15887,_15889:coevent,_15883)},
    !,
    accept(_16062,_16032,_15966).

noun_modsx0(0,_15886:_15887,_15874,_15874 and _15889 isa coevent and _15883 and _15884,[noun_modsx0,{},_16010,lit(å),!,_16070,{},!,_16184],_15977,_15979) --> 
    {user:testmember(_15887,[cause])},
    optional([for],_16010,_15977,_16042),
    cc(å,_16042,_16064),
    !,
    pushstack(first,(someone,aux1),nil,_16064,_16139),clausal_object1(_15889:coevent,true::_15884,_16070,_16139,_16154),
    {user:noun_compl(for,_15886:_15887,_15889:coevent,_15883)},
    !,
    accept(_16184,_16154,_15979).

noun_modsx0(0,_15886:_15887,_15874,_15874 and _15889 isa coevent and _15883 and _15884,[noun_modsx0,{},_16012,lit(å),!,_16072,{},!,_16186],_15979,_15981) --> 
    {user:testmember(_15887,[permission,possibility])},
    optional([til],_16012,_15979,_16044),
    cc(å,_16044,_16066),
    !,
    pushstack(first,(someone,aux1),nil,_16066,_16141),clausal_object1(_15889:coevent,true::_15884,_16072,_16141,_16156),
    {user:noun_compl(to,_15886:_15887,_15889:coevent,_15883)},
    !,
    accept(_16186,_16156,_15981).

noun_modsx0(0,_15886:_15887,_15874,_15874 and _15889 isa coevent and _15883 and _15884,[noun_modsx0,{},lit(om),lit(å),!,_16041,{},!,_16155],_15981,_15983) --> 
    {user:testmember(_15887,[notification,request,plan,wish])},
    cc(om,_15981,_16024),
    cc(å,_16024,_16035),
    !,
    pushstack(first,(someone,aux1),nil,_16035,_16110),clausal_object1(_15889:coevent,true::_15884,_16041,_16110,_16125),
    {user:noun_compl(about,_15886:_15887,_15889:coevent,_15883)},
    !,
    accept(_16155,_16125,_15983).

noun_modsx0(0,_15886:_15887,_15874,_15874 and _15889 isa coevent and _15883 and _15884,[noun_modsx0,{},_16005,lit(at),!,_16050,{},!,_16099],_15972,_15974) --> 
    {user:constrain(_15886:_15887,connection)},
    w(prep(with),_16005,_15972,_16022),
    cc(at,_16022,_16044),
    !,
    clausal_object1(_15889:coevent,true::_15884,_16050,_16044,_16069),
    {user:noun_compl(with,_15886:_15887,_15889:coevent,_15883)},
    !,
    accept(_16099,_16069,_15974).

noun_modsx0(0,_15873,_15874,_15874 and _15878,[noun_modsx0,{},_16006,_16030,_16074,_16108,!,_16147],_15973,_15975) --> 
    {user:constrain(_15873,way)},
    in_order_tox(_16006,_15973,_16021),
    lexv(tv,_15921,inf,fin,_16030,_16021,_16053),
    np1(_15925,_15928::_15929,_16074,_16053,_16093),
    fictitiousprep(way,_15932,_16108,_16093,_16127),
    !,
    pushstack(first,(someone,w(verb(_15921,pres,fin)),np1(_15925,_15928::_15929),prep(_15932),npgap(_15873)),nil,_16127,_16279),
    statreal(_15878,_16147,_16279,_15975).

noun_modsx0(0,_15873,_15874,_15874 and _15878,[noun_modsx0,{},_15988,_16012,_16056,!,_16095],_15955,_15957) --> 
    {user:constrain(_15873,way)},
    in_order_tox(_15988,_15955,_16003),
    lexv(iv,_15915,inf,fin,_16012,_16003,_16035),
    fictitiousprep(way,_15920,_16056,_16035,_16075),
    !,
    pushstack(first,(someone,w(verb(_15915,pres,fin)),prep(_15920),npgap(_15873)),nil,_16075,_16193),
    statreal(_15878,_16095,_16193,_15957).

noun_modsx0(_15872,_15873,_15874,_15874,[noun_modsx0,_15933,!,_15967],_15910,_15912) --> 
    look_ahead([den],_15933,_15910,_15950),
    !,
    accept(_15967,_15950,_15912).

noun_modsx0(_15872,_15873,_15874,_15874,[noun_modsx0,{},_15959,!,_15993],_15926,_15928) --> 
    {user:(vartypeid(_15873,_15891),subclass(_15891,daypart))},
    not_look_ahead(w(prep(_15901)),_15959,_15926,_15976),
    !,
    accept(_15993,_15976,_15928).

noun_modsx0(_15872,_15873,_15874,_15875,[noun_modsx0,_15931,!],_15908,_15910) --> 
    noun_mods(_15872,_15873,_15874,_15875,_15931,_15908,_15910),
    !.

noun_modsx0(_15872,_15873,_15874,_15874,[noun_modsx0,[]],_15900,_15900) --> 
    [].

fictitiousprep(way,in,[fictitiousprep,[]],_15894,_15894) --> 
    [].

fictitiousprep(abstract,with,[fictitiousprep,[]],_15894,_15894) --> 
    [].

noun_mods(0,_15873,_15874,_15874 and _15878,[noun_mods,{},_16076,{},_16115,_16144,_16173,_16202,_16231,_16260,_16289,_16318],_16043,_16045) --> 
    {user:(vartypeid(_15873,_15927),testmember(_15927,[address,email,mind,mailaddress,telephone,webaddress]))},
    prep1(to,_16076,_16043,_16093),
    {user:(vartypeid(_15873,_15954),\+testmember(_15954,[name]))},
    not_look_ahead(w(nb(_15966,_15967)),_16115,_16093,_16132),
    not_look_ahead(w(prep(_15973)),_16144,_16132,_16161),
    not_look_ahead_lit([deg,meg,seg],_16173,_16161,_16190),
    not_look_ahead(w(noun(station,_15988,_15989,_15990)),_16202,_16190,_16219),
    not_look_ahead(w(name(_15996,_15997,station)),_16231,_16219,_16248),
    not_look_ahead(w(name(_16004,_16005,neighbourhood)),_16260,_16248,_16277),
    not_look_ahead(w(name(_16012,_16013,city)),_16289,_16277,_16306),
    pushstack(first,(npgap(_15873),w(verb(evah,pres,fin))),nil,_16306,_16358),
    statreal(_15878,_16318,_16358,_16045).

noun_mods(0,_15873,_15874,_15874 and _15878,[noun_mods,{},_15987,{},{},_16036],_15954,_15956) --> 
    {user:value(teleflag,true)},
    not_look_ahead(w(prep(_15913)),_15987,_15954,_16004),
    {user:vartypeid(_15873,_15918)},
    {user:(\+vartypid(_15918,[]))},
    pushstack(first,(npgap(_15873),w(verb(evah,pres,fin))),nil,_16004,_16076),
    statreal(_15878,_16036,_16076,_15956).

noun_mods(0,_15873,_15874,_15875,[noun_mods,_15941,!,_15985,_16009],_15918,_15920) --> 
    noun_mod(_15873,_15874,_15888,_15941,_15918,_15962),
    !,
    accept(_15985,_15962,_16000),
    noun_modsx0(0,_15873,_15888,_15875,_16009,_16000,_15920).

noun_mods(name,_15873,_15874,_15875,[noun_mods,{},_15986,{},_16025,!,_16069,_16093],_15953,_15955) --> 
    {user:(vartypeid(_15873,_15905),subclass0(_15905,vehicle))},
    look_ahead(w(prep(_15915)),_15986,_15953,_16003),
    {user:testmember(_15915,[to,from])},
    noun_mod(_15873,_15874,_15897,_16025,_16003,_16046),
    !,
    accept(_16069,_16046,_16084),
    noun_mods(name,_15873,_15897,_15875,_16093,_16084,_15955).

noun_mods(name,_15873,_15874,_15875,[noun_mods,_15976,{},{},_16025,!,_16069,_16093],_15953,_15955) --> 
    look_ahead(w(prep(_15904)),_15976,_15953,_15993),
    {user:testmember(_15904,[on,towards])},
    {user:(vartypeid(_15873,_15920),subclass0(_15920,place))},
    noun_mod(_15873,_15874,_15897,_16025,_15993,_16046),
    !,
    accept(_16069,_16046,_16084),
    noun_mods(name,_15873,_15897,_15875,_16093,_16084,_15955).

noun_mods(name,_15873,_15874,_15875,[noun_mods,{},_15959,_15998],_15926,_15928) --> 
    {user:(value(textflag,true);value(teleflag,true))},
    noun_mod(_15873,_15874,_15885,_15959,_15926,_15980),
    noun_mods(name,_15873,_15885,_15875,_15998,_15980,_15928).

noun_mods(name,_15873,_15874,_15874 and _15878,[noun_mods,{},{},_16003,{},_16042],_15960,_15962) --> 
    {user:value(teleflag,true)},
    {user:constrain(_15873,person)},
    w(name(_15900,n,_15902),_16003,_15960,_16020),
    {user:subclass0(_15902,place)},
    pushstack(first,(prep1(in),w(name(_15900,n,_15902))),nil,_16020,_16082),
    noun_mod(_15873,_15874,_15878,_16042,_16082,_15962).

noun_mod(_15882:_15883,_15873,nrel/nil/day/clock/_15882/_15886 and _15873 and _15880,[noun_mod,{},_15971,_15995],_15941,_15943) --> 
    {user:constrain(_15882:_15883,day)},
    clock(_15971,_15941,_15986),
    clock_sequel(_15886:_15918,_15880,_15995,_15986,_15943).

noun_mod(_15872,_15873,_15873 and _15877,[noun_mod,_15937,{},!],_15917,_15919) --> 
    adverb(_15885,_15886,_15887,_15937,_15917,_15919),
    {user:noun_adverb(_15872,_15885,_15886,_15877)},
    !.

noun_mod(_15882:_15883,_15873,_15873 and _15879 and _15880,[noun_mod,lit(for),lit(å),_16005,!,_16044,{},!,_16102],_15963,_15965) --> 
    cc(for,_15963,_15993),
    cc(å,_15993,_16004),
    gmem(_15883,[condition],_16005,_16004,_16024),
    !,
    pushstack(first,[noen],nil,_16024,_16057),clausal_object1(_15926:coevent,true::_15880,_16044,_16057,_16072),
    {user:noun_compl(for,_15882:_15883,_15926:coevent,_15879)},
    !,
    accept(_16102,_16072,_15965).

noun_mod(_15882:_15883,_15873,_15873 and _15879 and _15880,[noun_mod,lit(om),lit(at),{},!,_16031,{},{},!,_16090],_15974,_15976) --> 
    cc(om,_15974,_16004),
    cc(at,_16004,_16015),
    {user:testmember(_15883,[information,message,notification,question])},
    !,
    clausal_object1(_15932:coevent,_15929::_15880,_16031,_16015,_16050),
    {user:_15929=true},
    {user:noun_compl(regarding,_15882:_15883,_15932:coevent,_15879)},
    !,
    accept(_16090,_16050,_15976).

noun_mod(_15872,_15873,_15873 and _15877,[noun_mod,_15946,_15975],_15926,_15928) --> 
    posspron(_15893,_15946,_15926,_15963),
    lock(exact,_15963,_16052),
    pushstack(exact,(pronoun(_15893),w(verb(have,pres,fin)),npgap(_15872)),nil,_16052,_16058),
    statreal(_15877,_15975,_16058,_16047),
    unlock(_16047,_15928).

noun_mod(_15872,_15873,_15873 and _15877,[noun_mod,_15934,_15963],_15914,_15916) --> 
    look_ahead(w(adj(_15890,comp)),_15934,_15914,_15951),
    comparison(_15872,_15883,_15877,_15963,_15951,_15916).

noun_mod(_15872,_15873,_15873 and _15877,[noun_mod,_15967,{},_16006,{},!,_16060,{}],_15947,_15949) --> 
    negation0(_15899,_15967,_15947,_15984),
    {user:(\+vartypeid(_15872,self))},
    adjunct1(_15912,_15913,_15901::_15877,_16006,_15984,_16027),
    {user:noun_compl(_15912,_15872,_15913,_15900)},
    !,
    accept(_16060,_16027,_15949),
    {user:negate(_15899,_15900,_15901)}.

noun_mod(_15876:_15877,_15873,_15873,[noun_mod,{},_15954,_15978,{}],_15924,_15926) --> 
    {user:constrain(_15876:_15877,vehicle)},
    numberroute(_15954,_15924,_15969),
    num_na(_15890,_15978,_15969,_15926),
    {user:_15890=_15876}.

noun_mod(_15872,_15873,_15873 and _15877,[noun_mod,_15957,_15986,{},!,_16057],_15937,_15939) --> 
    day(_15891,_15957,_15937,_15974),
    lock(exact,_15974,_16006),pushstack(exact,w(noun(_15891,sin,u,n)),nil,_16006,_16012),np1(_15903,_15906::_15877,_15986,_16012,_16001),unlock(_16001,_16002),
    {user:noun_compl(nil,_15872,_15903,_15906)},
    !,
    accept(_16057,_16002,_15939).

noun_mod(_15872,_15873,_15873 and _15877,[noun_mod,_15962,_15991,{},!,_16049],_15942,_15944) --> 
    w(noun(midnight,_15894,_15895,n),_15962,_15942,_15979),
    pushstack(first,w(noun(midnight,sin,u,n)),nil,_15979,_16004),np1(_15908,_15911::_15877,_15991,_16004,_16019),
    {user:noun_compl(nil,_15872,_15908,_15911)},
    !,
    accept(_16049,_16019,_15944).

noun_mod(_15872,_15873,_15873 and _15877,[noun_mod,_15942,{},!,_15991],_15922,_15924) --> 
    obviousdate(_15888,_15891::_15877,_15942,_15922,_15961),
    {user:noun_compl(nil,_15872,_15888,_15891)},
    !,
    accept(_15991,_15961,_15924).

noun_mod(_15872,_15873,_15873 and _15877,[noun_mod,_15942,{},!,_15991],_15922,_15924) --> 
    obviousclock(_15888,_15891::_15877,_15942,_15922,_15961),
    {user:noun_compl(nil,_15872,_15888,_15891)},
    !,
    accept(_15991,_15961,_15924).

noun_mod(_15872,_15873,_15874,[noun_mod,_15959,_15988,!,_16027,!,_16111],_15939,_15941) --> 
    w(noun(direction,_15894,_15895,_15896),_15959,_15939,_15976),
    nameq1(_15898,_15899,_15988,_15976,_16007),
    !,
    pushstack(first,(w(prep(towards)),nameq1(_15898,_15899)),nil,_16007,_16071),noun_mod(_15872,_15873,_15874,_16027,_16071,_16088),
    !,
    accept(_16111,_16088,_15941).

noun_mod(_15879:_15880,_15873,_15873 and _15877,[noun_mod,{},_15969,{},!,_16018],_15939,_15941) --> 
    {user:test(n_compl(nil,_15880,_15900))},
    np1_accept(_15902,_15905::_15877,_15969,_15939,_15988),
    {user:noun_compl(nil,_15879:_15880,_15902,_15905)},
    !,
    accept(_16018,_15988,_15941).

begin([begin,[]],_15887,_15887) --> 
    [].

end([end,[]],_15887,_15887) --> 
    [].

accept([accept,[]],_15887,_15887) --> 
    [].

reject([reject,{}],_15889,_15889) --> 
    {user:fail}.

look_ahead_place([look_ahead_place,_15916,{}],_15905,_15907) --> 
    look_ahead(w(name(_15886,_15887,_15879)),_15916,_15905,_15907),
    {user:test(subclass0(_15879,place))}.

look_ahead_conjuction([look_ahead_conjuction,_15902],_15891,_15893) --> 
    look_ahead([før],_15902,_15891,_15893).

look_ahead_conjuction([look_ahead_conjuction,_15902],_15891,_15893) --> 
    look_ahead([etter],_15902,_15891,_15893).

look_ahead_conjuction([look_ahead_conjuction,_15902],_15891,_15893) --> 
    look_ahead([når],_15902,_15891,_15893).

not_look_ahead_flnp([not_look_ahead_flnp,_15927,{},!,_15971],_15916,_15918) --> 
    look_ahead(w(adj2(_15885,nil)),_15927,_15916,_15944),
    {user:testmember(_15885,[first,last,next,previous])},
    !,
    reject(_15971,_15944,_15918).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_15887,_15887) --> 
    [].

not_look_ahead_flnp([not_look_ahead_flnp,_15927,{},!,_15971],_15916,_15918) --> 
    look_ahead(w(adj2(_15885,nil)),_15927,_15916,_15944),
    {user:testmember(_15885,[first,last,next,previous])},
    !,
    reject(_15971,_15944,_15918).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_15887,_15887) --> 
    [].

not_look_ahead_vehicle([not_look_ahead_vehicle,_15923,{},!,_15967],_15912,_15914) --> 
    look_ahead(w(noun(_15885,_15886,_15887,_15888)),_15923,_15912,_15940),
    {user:test(subclass0(_15885,vehicle))},
    !,
    reject(_15967,_15940,_15914).

not_look_ahead_vehicle([not_look_ahead_vehicle,_15925,{},!,_15969],_15914,_15916) --> 
    look_ahead(w(noun(_15885,_15886,_15887,_15888)),_15925,_15914,_15942),
    {user:testmember(_15885,[departure,arrival])},
    !,
    reject(_15969,_15942,_15916).

not_look_ahead_vehicle([not_look_ahead_vehicle,[]],_15887,_15887) --> 
    [].

not_look_ahead_day([not_look_ahead_day,_15921,{},!,_15965],_15910,_15912) --> 
    look_ahead(w(noun(_15885,_15886,_15887,_15888)),_15921,_15910,_15938),
    {user:_15885 ako day},
    !,
    reject(_15965,_15938,_15912).

not_look_ahead_day([not_look_ahead_day,[]],_15887,_15887) --> 
    [].

not_look_ahead_noun([not_look_ahead_noun,_15907],_15896,_15898) --> 
    not_look_ahead(w(noun(_15876,_15877,_15878,_15879)),_15907,_15896,_15898).

look_ahead_timeclause([look_ahead_timeclause,_15907],_15896,_15898) --> 
    look_ahead(w(noun(clock,_15877,_15878,_15879)),_15907,_15896,_15898).

look_ahead_timeclause([look_ahead_timeclause,_15915,{}],_15904,_15906) --> 
    look_ahead(w(noun(_15877,sin,u,n)),_15915,_15904,_15906),
    {user:subclass(_15877,day)}.

look_ahead_clock([look_ahead_clock,_15904],_15893,_15895) --> 
    look_ahead_lit([kl,klokken],_15904,_15893,_15895).

look_ahead_clock([look_ahead_clock,_15907],_15896,_15898) --> 
    look_ahead(w(noun(clock,sin,def,n)),_15907,_15896,_15898).

look_ahead_clock([look_ahead_clock,_15905],_15894,_15896) --> 
    look_ahead(w(nb(_15876,_15877)),_15905,_15894,_15896).

not_look_ahead_vp([not_look_ahead_vp,_15904,!,_15933],_15893,_15895) --> 
    look_ahead_vp(_15904,_15893,_15919),
    !,
    reject(_15933,_15919,_15895).

not_look_ahead_vp([not_look_ahead_vp,[]],_15887,_15887) --> 
    [].

look_ahead_vp([look_ahead_vp,_15906],_15895,_15897) --> 
    look_ahead(w(verb(_15876,_15877,_15878)),_15906,_15895,_15897).

look_ahead_vp([look_ahead_vp,_15902],_15891,_15893) --> 
    look_ahead([ikke],_15902,_15891,_15893).

look_ahead_vp([look_ahead_vp,_15898],_15887,_15889) --> 
    look_ahead_aux(_15898,_15887,_15889).

look_ahead_aux([look_ahead_aux,_15920],_15909,_15911) --> 
    look_ahead_lit([vil,skal,bør,må,kan,ville,skulle,burde,måtte,kunne],_15920,_15909,_15911).

not_look_ahead_lit(_15872,[not_look_ahead_lit,_15913,!,_15947],_15899,_15901) --> 
    look_ahead_lit(_15872,_15913,_15899,_15930),
    !,
    reject(_15947,_15930,_15901).

not_look_ahead_lit(_15872,[not_look_ahead_lit,[]],_15891,_15891) --> 
    [].

look_ahead_lit(_15872,[look_ahead_lit,_15920,{},!],_15906,_15908) --> 
    look_ahead([_15881],_15920,_15906,_15908),
    {user:testmember(_15881,_15872)},
    !.

lit_of(_15872,_15873,[lit_of,lit(_15872),{},!],_15907,_15909) --> 
    cc(_15872,_15907,_15909),
    {user:member(_15872,_15873)},
    !.

one_of_lit(_15872,[one_of_lit,lit(_15879),{},!],_15904,_15906) --> 
    cc(_15879,_15904,_15906),
    {user:member(_15879,_15872)},
    !.

not_one_of_lit(_15872,[not_one_of_lit,_15913,!,_15947],_15899,_15901) --> 
    one_of_lit(_15872,_15913,_15899,_15930),
    !,
    reject(_15947,_15930,_15901).

not_one_of_lit(_15872,[not_one_of_lit,[]],_15891,_15891) --> 
    [].

not_look_ahead_number([not_look_ahead_number,lit(ett),!],_15892,_15894) --> 
    cc(ett,_15892,_15894),
    !.

not_look_ahead_number([not_look_ahead_number,_15909,!,_15943],_15898,_15900) --> 
    w(nb(_15880,_15881),_15909,_15898,_15926),
    !,
    fail(_15943,_15926,_15900).

not_look_ahead_number([not_look_ahead_number,[]],_15887,_15887) --> 
    [].

not_look_ahead_np([not_look_ahead_np,_15923,_15952,!],_15912,_15914) --> 
    look_ahead(w(adv(_15882)),_15923,_15912,_15940),
    gmem(_15882,[klokken,kloka,kl,directly,correctly],_15952,_15940,_15914),
    !.

not_look_ahead_np([not_look_ahead_np,_15904,!,_15933],_15893,_15895) --> 
    look_ahead_np(_15904,_15893,_15919),
    !,
    reject(_15933,_15919,_15895).

not_look_ahead_np([not_look_ahead_np,[]],_15887,_15887) --> 
    [].

look_ahead_np([look_ahead_np,_15966],_15955,_15957) --> 
    look_ahead_lit([den,det,de,denne,dere,dette,disse,du,en,et,ei,han,hun,jeg,noe,noen,vi,meg,deg,seg,min,mine,din,dine,hans,hennes,seg,vår,våre,deres,mange,noen,noe],_15966,_15955,_15957).

look_ahead_np([look_ahead_np,_15915,{}],_15904,_15906) --> 
    look_ahead(w(adj2(_15879,_15887)),_15915,_15904,_15906),
    {user:(\+testmember(_15879,[]))}.

look_ahead_np([look_ahead_np,_15907],_15896,_15898) --> 
    look_ahead(w(noun(_15876,_15877,_15878,_15879)),_15907,_15896,_15898).

look_ahead_np([look_ahead_np,_15905],_15894,_15896) --> 
    look_ahead(w(nb(_15876,_15877)),_15905,_15894,_15896).

look_ahead_np([look_ahead_np,_15904],_15893,_15895) --> 
    look_ahead_lit([halv,kvart],_15904,_15893,_15895).

look_ahead_np([look_ahead_np,_15916,{}],_15905,_15907) --> 
    look_ahead(w(name(_15879,_15887,_15888)),_15916,_15905,_15907),
    {user:(\+testmember(_15879,[]))}.

look_ahead_subject([look_ahead_subject,lit(_15877),{}],_15907,_15909) --> 
    cc(_15877,_15907,_15909),
    {user:testmember(_15877,[jeg,du,han,hun,vi])}.

look_ahead_pron([look_ahead_pron,_15908],_15897,_15899) --> 
    look_ahead_lit([jeg,vi,du,dere],_15908,_15897,_15899).

not_look_ahead_pron([not_look_ahead_pron,_15906,!,_15940],_15895,_15897) --> 
    posspron(_15878,_15906,_15895,_15923),
    !,
    reject(_15940,_15923,_15897).

not_look_ahead_pron([not_look_ahead_pron,_15908],_15897,_15899) --> 
    not_look_ahead_lit([jeg,du,han,hun],_15908,_15897,_15899).

determiner0(plu,0,_15874,_15875,_15878::quant(approx/_15891,_15874)::_15875 and _15878,[determiner0,lit(mellom),_15986,lit(og),_16026,{}],_15949,_15951) --> 
    cc(mellom,_15949,_15985),
    w(nb(_15891,num),_15986,_15985,_16003),
    cc(og,_16003,_16025),
    w(nb(_15908,num),_16026,_16025,_15951),
    {user:_15891<_15908}.

determiner0(plu,0,_15874,_15875,_15878::quant(eq/_15891,_15874)::_15875 and _15878,[determiner0,_16005,_16029,{},_16068,_16097,!,_16131,[]],_15979,_15981) --> 
    theplu0(_16005,_15979,_16020),
    w(adj2(_15919,nil),_16029,_16020,_16046),
    {user:testmember(_15919,[first,last,next,previous])},
    number(_15891:_15943,_16068,_16046,_16085),
    look_ahead(w(noun(_15949,plu,_15951,_15952)),_16097,_16085,_16114),
    !,
    accept(_16131,_16114,_16146),
    pushstack(free,w(adj2(_15919,nil)),nil,_16146,_15981),
    [].

determiner0(sin,0,_15874,_15875,_15878::_15879,[determiner0,{},_15963,_15987],_15927,_15929) --> 
    {user:value(dialog,1)},
    the(_15963,_15927,_15978),
    pushstack(first,this,nil,_15978,_16025),
    determiner(_15874,_15875,_15878::_15879,_15987,_16025,_15929).

determiner0(_15872,_15873,_15874,_15875,_15876,[determiner0,_15960,_15984,_16013,{},!,_16057],_15934,_15936) --> 
    theplu0(_15960,_15934,_15975),
    number(_15895:_15896,_15984,_15975,_16001),
    w(noun(_15900,_15901,_15902,_15903),_16013,_16001,_16030),
    {user:measureclass(_15900)},
    !,
    reject(_16057,_16030,_15936).

determiner0(plu,0,_15874,_15875,_15878::quant(approx/_15891,_15874)::_15875 and _15878,[determiner0,_15955,!,_15984],_15929,_15931) --> 
    approx(_15955,_15929,_15970),
    !,
    number(_15891:_15902,_15984,_15970,_15931).

approx([approx,lit(ca),!],_15892,_15894) --> 
    cc(ca,_15892,_15894),
    !.

approx([approx,lit(rundt),!],_15892,_15894) --> 
    cc(rundt,_15892,_15894),
    !.

determiner0(plu,0,_15874,_15875,_15878::quant(ge/_15891,_15874)::_15875 and _15878,[determiner0,_15952,_15976],_15926,_15928) --> 
    morethan(_15952,_15926,_15967),
    number(_15891:_15899,_15976,_15967,_15928).

morethan([morethan,lit(minst)],_15889,_15891) --> 
    cc(minst,_15889,_15891).

morethan([morethan,lit(over)],_15889,_15891) --> 
    cc(over,_15889,_15891).

morethan([morethan,lit(mer),lit(enn)],_15894,_15896) --> 
    cc(mer,_15894,_15915),
    cc(enn,_15915,_15896).

determiner0(plu,0,_15874,_15875,_15878::quant(eq/_15891,_15874)::_15875 and _15878,[determiner0,_15964,_15988,_16017],_15938,_15940) --> 
    theplu0(_15964,_15938,_15979),
    number(_15891:_15911,_15988,_15979,_16005),
    not_look_ahead(w(noun(time,_15904,def,n)),_16017,_16005,_15940).

determiner0(sin,0,_15874,_15875,_15878::quant(eq/1,_15874)::_15875 and _15878,[determiner0,_15964,_15993,!],_15938,_15940) --> 
    w(nb(1,num),_15964,_15938,_15981),
    not_look_ahead(w(noun(time,_15909,def,n)),_15993,_15981,_15940),
    !.

determiner0(sin,0,_15874,_15875,_15878::_15879,[determiner0,{},_15963,_15987],_15927,_15929) --> 
    {user:value(dialog,1)},
    the(_15963,_15927,_15978),
    pushstack(first,this,nil,_15978,_16025),
    determiner(_15874,_15875,_15878::_15879,_15987,_16025,_15929).

determiner0(plu,0,_15874,_15875,_15878::_15879,[determiner0,_15953,_15977,_16006],_15927,_15929) --> 
    the(_15953,_15927,_15968),
    not_look_ahead(w(verb(_15898,pres,fin)),_15977,_15968,_15994),
    determiner00(_15874,_15875,_15878::_15879,_16006,_15994,_15929).

determiner0(_15872,0,_15874,_15875,_15878::_15879,[determiner0,_15939],_15913,_15915) --> 
    determiner(_15874,_15875,_15878::_15879,_15939,_15913,_15915).

determiner0(_15872,0,_15874,_15875,_15878::_15879,[determiner0,_15939],_15913,_15915) --> 
    determiner00(_15874,_15875,_15878::_15879,_15939,_15913,_15915).

determiner0(_15872,0,_15874,_15875,_15878::exists(_15874)::_15875 and _15878,[determiner0,_15940],_15914,_15916) --> 
    the0(_15940,_15914,_15916).

determiner00(_15882:_15883,_15873,_15876::_15873 and _15876,[determiner00,_15934,!],_15914,_15916) --> 
    the(_15882:_15883,_15934,_15914,_15916),
    !.

determiner00(_15872,_15873,_15876::exists(_15872)::_15873 and _15876,[determiner00,[]],_15908,_15908) --> 
    [].

determiner(_15872,_15873,_15876::forall(_15872)::_15873=>_15876,[determiner,lit(alle),_15944],_15913,_15915) --> 
    cc(alle,_15913,_15943),
    look_ahead_np(_15944,_15943,_15915).

determiner(_15872,_15873,_15876::forall(_15872)::_15873=>_15876,[determiner,lit(hver)],_15910,_15912) --> 
    cc(hver,_15910,_15912).

determiner(_15872,_15873,_15876::find(_15872)::_15873 and _15876,[determiner,_15931,_15955],_15911,_15913) --> 
    this(_15931,_15911,_15946),
    look_ahead_np(_15955,_15946,_15913).

determiner(_15872,_15873,_15876::_15873 and _15876,[determiner,_15925],_15905,_15907) --> 
    the(_15872,_15925,_15905,_15907).

determiner(_15872,_15873,_15876::exists(_15872)::_15873 and _15876,[determiner,_15949,_15973,_15997,_16026,!],_15929,_15931) --> 
    only0(_15949,_15929,_15964),
    art(_15973,_15964,_15988),
    look_ahead(w(noun(_15903,sin,u,n)),_15997,_15988,_16014),
    off0(_16026,_16014,_15931),
    !.

determiner(_15872,_15873,_15876::exists(_15872)::_15873 and _15876,[determiner,_15934,_15958,_15982],_15914,_15916) --> 
    only0(_15934,_15914,_15949),
    art(_15958,_15949,_15973),
    off0(_15982,_15973,_15916).

determiner(_15872,_15873,_15876::forall(_15872)::_15873=>_15876,[determiner,_15931,_15955],_15911,_15913) --> 
    every(_15931,_15911,_15946),
    look_ahead_np(_15955,_15946,_15913).

determiner(_15872,_15873,_15876::not (exists(_15872)::_15873 and _15876),[determiner,_15933,_15957],_15913,_15915) --> 
    no(_15933,_15913,_15948),
    look_ahead_np(_15957,_15948,_15915).

determiner(_15872,_15873,_15876::exists(_15872)::_15873 and not _15876,[determiner,_15933,_15957],_15913,_15915) --> 
    notall(_15933,_15913,_15948),
    look_ahead_np(_15957,_15948,_15915).

determiner(_15872,_15873,_15876::quant(all,_15872)::_15873 and _15876,[determiner,lit(hele)],_15911,_15913) --> 
    cc(hele,_15911,_15913).

determiner(_15872,_15873,_15876::_15877,[determiner,_15927],_15907,_15909) --> 
    quantifier(_15872,_15873,_15876::_15877,_15927,_15907,_15909).

quantifier(_15872,_15873,_15876::quant(eq/_15889,_15872)::_15873 and _15876,[quantifier,lit(bare),_15953],_15922,_15924) --> 
    cc(bare,_15922,_15952),
    w(nb(_15889,_15897),_15953,_15952,_15924).

quantifier(_15872,_15873,_15876::quant(few,_15872)::_15873 and _15876,[quantifier,_15935,_15959,_15983],_15915,_15917) --> 
    aso0(_15935,_15915,_15950),
    few(_15959,_15950,_15974),
    look_ahead_np(_15983,_15974,_15917).

quantifier(_15872,_15873,_15876::quant(most,_15872)::_15873 and _15876,[quantifier,lit(de),lit(fleste),_15961],_15919,_15921) --> 
    cc(de,_15919,_15949),
    cc(fleste,_15949,_15960),
    look_ahead_np(_15961,_15960,_15921).

quantifier(_15872,_15873,_15876::quant(much,_15872)::_15873 and _15876,[quantifier,_15939,_15963],_15919,_15921) --> 
    much(_15939,_15919,_15954),
    not_look_ahead(w(adj2(_15895,nil)),_15963,_15954,_15921).

quantifier(_15872,_15873,_15876::quant(little,_15872)::_15873 and _15876,[quantifier,_15939,_15963],_15919,_15921) --> 
    little(_15939,_15919,_15954),
    not_look_ahead(w(adj2(_15895,nil)),_15963,_15954,_15921).

quantifier(_15872,_15873,_15876::quant(many,_15872)::_15873 and _15876,[quantifier,_15935,_15959,_15983],_15915,_15917) --> 
    aso0(_15935,_15915,_15950),
    many(_15959,_15950,_15974),
    look_ahead_np(_15983,_15974,_15917).

quantifier(_15872,_15873,_15876::quant(most,_15872)::_15873 and _15876,[quantifier,_15935,_15959,_15983],_15915,_15917) --> 
    aso0(_15935,_15915,_15950),
    most(_15959,_15950,_15974),
    look_ahead_np(_15983,_15974,_15917).

quantifier(_15872,_15873,_15876::quant(all,_15872)::_15873 and _15876,[quantifier,lit(alle),_15945],_15914,_15916) --> 
    cc(alle,_15914,_15944),
    look_ahead_np(_15945,_15944,_15916).

quantifier(_15872,_15873,_15876::quant(ge/2,_15872)::_15873 and _15876,[quantifier,_15935,_15959],_15915,_15917) --> 
    several(_15935,_15915,_15950),
    look_ahead_np(_15959,_15950,_15917).

quantifier(_15872,_15873,_15876::quant(count,_15872)::_15873 and _15876,[quantifier,_15946,_15975,_16019],_15926,_15928) --> 
    w(noun(count,_15897,_15898,_15899),_15946,_15926,_15963),
    optional([av],_15975,_15963,_16007),
    look_ahead_np(_16019,_16007,_15928).

few([few,lit(få)],_15889,_15891) --> 
    cc(få,_15889,_15891).

few([few,lit(færre)],_15889,_15891) --> 
    cc(færre,_15889,_15891).

plausible_name(_15876:person,_15876 isa person,_15874,[plausible_name,_15951,_15990,{},!,_16044],_15931,_15933) --> 
    properfirstname(_15894,_15895,_15896,_15951,_15931,_15972),
    properlastname(_15898,_15899,_15874,_15990,_15972,_16011),
    {user:_15876=(_15894,_15898)},
    !,
    accept(_16044,_16011,_15933).

plausible_name(_15876:_15877,_15876 isa _15877,_15874,[plausible_name,_15947,{}],_15927,_15929) --> 
    w(name(_15876,_15874,_15877),_15947,_15927,_15929),
    {user:(\+_15877=0,\+_15877=date)}.

name_compound(_15872,_15873,_15874,[name_compound,_15963,_15992,_16021,_16050,_16089,_16133],_15943,_15945) --> 
    not_look_ahead([dere],_15963,_15943,_15980),
    not_look_ahead([du],_15992,_15980,_16009),
    not_look_ahead(w(nb(_15910,_15911)),_16021,_16009,_16038),
    plausible_name(_15893,_15894,_15915,_16050,_16038,_16071),
    s0(sin,u,_15915,_15891,_16089,_16071,_16112),
    ncomps0(_15891,_15873,_15893,_15894,_15874,_15872,_16133,_16112,_15945).

namep(name,_15876:street,_15876 isa street,[namep,_15966,_15995,_16019,_16048,{},!,_16092],_15946,_15948) --> 
    w(name(_15876,n,street),_15966,_15946,_15983),
    comma0(_15995,_15983,_16010),
    postcode(_15906,_16019,_16010,_16036),
    w(name(_15910,n,_15912),_16048,_16036,_16065),
    {user:testmember(_15912,[neighbourhood,city,station])},
    !,
    accept(_16092,_16065,_15948).

namep(_15872,_15873,_15874,[namep,_15963,_15992,_16021,_16050,_16089,_16133],_15943,_15945) --> 
    not_look_ahead([dere],_15963,_15943,_15980),
    not_look_ahead([du],_15992,_15980,_16009),
    not_look_ahead(w(nb(_15910,_15911)),_16021,_16009,_16038),
    plausible_name(_15893,_15894,_15915,_16050,_16038,_16071),
    s0(sin,u,_15915,_15891,_16089,_16071,_16112),
    ncomps0(_15891,_15873,_15893,_15894,_15874,_15872,_16133,_16112,_15945).

namep(name,_15876:thing,_15876 isa unkn,[namep,{},_15949,_15978],_15919,_15921) --> 
    {user:value(unknownflag,true)},
    unplausible_name(_15888,_15949,_15919,_15966),
    morenames(_15888,_15876,_15978,_15966,_15921).

namep(0,_15873,_15874,[namep,_15920],_15900,_15902) --> 
    measure(_15873,_15874,_15920,_15900,_15902).

namep(name,_15873,_15874,[namep,_15932,_15956],_15912,_15914) --> 
    you(_15932,_15912,_15947),
    pushstack(first,w(name(tuc,n,savant)),nil,_15947,_15966),
    nameq(_15873,_15874,_15956,_15966,_15914).

namep(0,_15873,_15874,[namep,_15935,_15964,!,_16023],_15915,_15917) --> 
    number(_15885,_15935,_15915,_15952),
    noun(_15887,plu,_15889,n,_15891,_15892,_15964,_15952,_15991),
    !,
    reject(_16023,_15991,_15917).

namep(0,_15873,_15874,[namep,_16020,_16044,{},_16103,_16132,_16161,_16195,{},{},_16244,_16273,!,_16307],_16000,_16002) --> 
    athe0(_16020,_16000,_16035),
    noun2(_15912,_15913,n,_15918:_15919,_15916,_16044,_16035,_16069),
    {user:(\+testmember(_15919,[thing]))},
    not_look_ahead([jeg],_16103,_16069,_16120),
    not_look_ahead([du],_16132,_16120,_16149),
    nameq(_15938,_15939,_16161,_16149,_16180),
    not_look_ahead([:],_16195,_16180,_16212),
    {user:compoundtest(_15912,_15913,_15918:_15919,_15938)},
    {user:align_noun_name(_15918:_15919,_15938,_15916,_15873,_15874)},
    optional_suffix(_15918:_15919,_16244,_16212,_16261),
    not_look_ahead(w(name(_15975,_15976,date)),_16273,_16261,_16290),
    !,
    accept(_16307,_16290,_16002).

namep(0,_15873,_15874,[namep,_15962,_15986,_16010,_16044,{},!,{}],_15942,_15944) --> 
    athe0(_15962,_15942,_15977),
    nr0(_15986,_15977,_16001),
    nameq1(_15897,_15903,_16010,_16001,_16029),
    noun(_15905,sin,u,n,_15896,_15898,_16044,_16029,_15944),
    {user:testmember(_15905,[bus,tram])},
    !,
    {user:align_noun_name(_15896,_15897,_15898,_15873,_15874)}.

namep(0,_15873,_15874,[namep,_15963,_15987,_16016,_16050,{},{}],_15943,_15945) --> 
    athe0(_15963,_15943,_15978),
    not_look_ahead([_15900],_15987,_15978,_16004),
    nameq1(_15894,_15904,_16016,_16004,_16035),
    noun(_15906,sin,_15908,n,_15893,_15895,_16050,_16035,_15945),
    {user:(\+testmember(_15906,[thing]))},
    {user:align_noun_name(_15893,_15894,_15895,_15873,_15874)}.

namep(name,_15873,_15874,[namep,_15927,_15956],_15907,_15909) --> 
    not_look_ahead([ett],_15927,_15907,_15944),
    nameq(_15873,_15874,_15956,_15944,_15909).

optional_suffix(_15874:_15875,[optional_suffix,_15929,{},!,_15973],_15915,_15917) --> 
    w(noun(_15888,_15889,_15890,n),_15929,_15915,_15946),
    {user:alignable(_15875,_15888)},
    !,
    accept(_15973,_15946,_15917).

optional_suffix(_15874:_15875,[optional_suffix,_15929,{},!,_15973],_15915,_15917) --> 
    w(noun(_15888,_15889,_15890,n),_15929,_15915,_15946),
    {user:alignable(_15875,_15888)},
    !,
    accept(_15973,_15946,_15917).

optional_suffix(_15874:_15875,[optional_suffix,_15908],_15894,_15896) --> 
    point0(_15908,_15894,_15896).

noun2(sin,u,n,_15878:thing,_15878 isa thing,[noun2,lit(_15893),{},_15979],_15932,_15934) --> 
    cc(_15893,_15932,_15968),
    {user:testmember(_15893,[de,disse,dem])},
    look_ahead([som],_15979,_15968,_15934).

noun2(plu,u,n,_15878:thing,_15878 isa thing,[noun2,lit(_15889),{},_15975],_15928,_15930) --> 
    cc(_15889,_15928,_15964),
    {user:testmember(_15889,[de,disse,dem])},
    not_look_ahead_np(_15975,_15964,_15930).

noun2(sin,u,n,_15878:agent,_15878 isa agent,[noun2,_15942,_15966],_15916,_15918) --> 
    agent_pronoun(_15942,_15916,_15957),
    look_ahead([som],_15966,_15957,_15918).

noun2(sin,u,n,_15878:thing,_15878 isa thing,[noun2,lit(det),_15955],_15918,_15920) --> 
    cc(det,_15918,_15954),
    look_ahead([som],_15955,_15954,_15920).

noun2(_15872,_15873,_15874,_15875,_15876,[noun2,_15969,{},_16033,!,_16062],_15943,_15945) --> 
    noun(_15890,_15872,_15873,_15874,_15875,_15876,_15969,_15943,_15996),
    {user:testmember(_15890,[monday,tuesday,wednesday,thursday,friday,saturday,sunday,month])},
    point0(_16033,_15996,_16048),
    !,
    accept(_16062,_16048,_15945).

noun2(_15872,_15873,_15874,_15878:_15879,_15876,[noun2,_15998,_16027,_16056,_16085,_16114,{},!,_16158],_15972,_15974) --> 
    w(noun(_15904,_15905,u,n),_15998,_15972,_16015),
    not_look_ahead(w(noun(number,sin,_15915,n)),_16027,_16015,_16044),
    not_look_ahead([nr],_16056,_16044,_16073),
    not_look_ahead(w(verb(_15926,_15927,_15928)),_16085,_16073,_16102),
    w(noun(_15932,_15872,_15873,_15874),_16114,_16102,_16131),
    {user:adjnoun_template(_15904,_15932,_15878:_15879,_15876)},
    !,
    accept(_16158,_16131,_15974).

noun2(_15872,_15873,_15874,_15875,_15876,[noun2,_15936],_15910,_15912) --> 
    noun(_15878,_15872,_15873,_15874,_15875,_15876,_15936,_15910,_15912).

noun2(sin,u,n,_15878:thing,_15878 isa thing,[noun2,_15945,_15969,!],_15919,_15921) --> 
    someone(_15945,_15919,_15960),
    look_ahead([som],_15969,_15960,_15921),
    !.

agent_pronoun([agent_pronoun,lit(jeg)],_15889,_15891) --> 
    cc(jeg,_15889,_15891).

agent_pronoun([agent_pronoun,lit(du)],_15889,_15891) --> 
    cc(du,_15889,_15891).

agent_pronoun([agent_pronoun,lit(noen)],_15889,_15891) --> 
    cc(noen,_15889,_15891).

agent_pronoun([agent_pronoun,lit(mange)],_15889,_15891) --> 
    cc(mange,_15889,_15891).

agent_pronoun([agent_pronoun,lit(få)],_15889,_15891) --> 
    cc(få,_15889,_15891).

agent_pronoun([agent_pronoun,lit(han)],_15889,_15891) --> 
    cc(han,_15889,_15891).

agent_pronoun([agent_pronoun,lit(ham)],_15889,_15891) --> 
    cc(ham,_15889,_15891).

agent_pronoun([agent_pronoun,lit(hun)],_15889,_15891) --> 
    cc(hun,_15889,_15891).

agent_pronoun([agent_pronoun,lit(henne)],_15889,_15891) --> 
    cc(henne,_15889,_15891).

agent_pronoun([agent_pronoun,lit(dere)],_15889,_15891) --> 
    cc(dere,_15889,_15891).

agent_pronoun([agent_pronoun,lit(alle)],_15889,_15891) --> 
    cc(alle,_15889,_15891).

noun(_15872,_15873,_15874,_15875,_15879:_15872,_15879 isa _15872,[noun,_15948],_15919,_15921) --> 
    w(noun(_15872,_15873,_15874,_15875),_15948,_15919,_15921).

measure(_15872,_15873,[measure,_15955,{},_16019,_16053,_16077,!,{}],_15938,_15940) --> 
    noun(_15901,_15902,_15903,n,_15895,_15897,_15955,_15938,_15982),
    {user:measureclass(_15901)},
    gmem(_15901,[crown],_16019,_15982,_16038),
    point0(_16053,_16038,_16068),
    anumber(_15896,_16077,_16068,_15940),
    !,
    {user:align_measure(_15895,_15896,_15897,_15872,_15873)}.

measure(_15872,_15873,[measure,_15952,_15981,_16005,_16059,_16083,{},{}],_15935,_15937) --> 
    anumber(_15896,_15952,_15935,_15969),
    point0(_15981,_15969,_15996),
    noun(_15903,_15904,_15905,n,_15895,_15897,_16005,_15996,_16032),
    point0(_16059,_16032,_16074),
    not_overon_clock(_15903,_16083,_16074,_15937),
    {user:measureclass(_15903)},
    {user:align_measure(_15895,_15896,_15897,_15872,_15873)}.

not_overon_clock(_15872,[not_overon_clock,{},_15963,{},_16002,!,_16036],_15939,_15941) --> 
    {user:testmember(_15872,[hour,minute,second])},
    prep1(_15900,_15963,_15939,_15980),
    {user:testmember(_15900,[on,before,over,after])},
    look_ahead(w(nb(_15919,_15920)),_16002,_15980,_16019),
    !,
    reject(_16036,_16019,_15941).

not_overon_clock(_15872,[not_overon_clock,[]],_15891,_15891) --> 
    [].

nameq(_15872,_15873,[nameq,_15924,_15958],_15907,_15909) --> 
    nameq1(_15872,_15873,_15924,_15907,_15943),
    not_look_ahead(w(nb(_15882,_15883)),_15958,_15943,_15909).

nameq(_15872,_15873,[nameq,_15924,_15958],_15907,_15909) --> 
    nameq2(_15872,_15873,_15924,_15907,_15943),
    not_look_ahead(w(nb(_15882,_15883)),_15958,_15943,_15909).

name1g(_15876:lastname,_15876 isa lastname,_15874,[name1g,{},_15975,_16004,_16033,!,_16067],_15945,_15947) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_15876,_15907,firstname)),_15975,_15945,_15992),
    w(name(_15876,_15874,lastname),_16004,_15992,_16021),
    not_look_ahead(w(name(_15920,_15921,lastname)),_16033,_16021,_16050),
    !,
    accept(_16067,_16050,_15947).

name1g(_15876:firstname,_15876 isa firstname,n,[name1g,{},_15975,_16004,_16033,!,_16067],_15945,_15947) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_15876,_15907,lastname)),_15975,_15945,_15992),
    w(name(_15876,n,firstname),_16004,_15992,_16021),
    look_ahead(w(name(_15920,_15921,lastname)),_16033,_16021,_16050),
    !,
    accept(_16067,_16050,_15947).

name1g(_15876:lastname,_15876 isa lastname,_15874,[name1g,{},_15975,_16004,_16033,!,_16067],_15945,_15947) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_15876,_15907,firstname)),_15975,_15945,_15992),
    w(name(_15876,_15874,lastname),_16004,_15992,_16021),
    not_look_ahead(w(name(_15920,n,lastname)),_16033,_16021,_16050),
    !,
    accept(_16067,_16050,_15947).

name1g(_15876:firstname,_15876 isa firstname,n,[name1g,{},_15975,_16004,_16033,!,_16067],_15945,_15947) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_15876,_15907,lastname)),_15975,_15945,_15992),
    w(name(_15876,n,firstname),_16004,_15992,_16021),
    look_ahead(w(name(_15920,n,lastname)),_16033,_16021,_16050),
    !,
    accept(_16067,_16050,_15947).

name1g(_15876:_15877,_15876 isa _15877,_15874,[name1g,_15930],_15910,_15912) --> 
    wnameg(_15876:_15877,_15874,_15877,_15930,_15910,_15912).

wnameg(_15876:_15874,gen,_15874,[wnameg,_15932,_15961,!],_15912,_15914) --> 
    w(name(_15876,n,_15874),_15932,_15912,_15949),
    sin(_15961,_15949,_15914),
    !.

wnameg(_15876:_15874,gen,_15874,[wnameg,_15932,_15961,!],_15912,_15914) --> 
    w(name(_15876,gen,_15874),_15932,_15912,_15949),
    sin(_15961,_15949,_15914),
    !.

wnameg(_15876:_15874,gen,_15874,[wnameg,_15929,!],_15909,_15911) --> 
    w(name(_15876,gen,_15874),_15929,_15909,_15911),
    !.

wnameg(_15876:_15874,n,_15874,[wnameg,_15926],_15906,_15908) --> 
    w(name(_15876,n,_15874),_15926,_15906,_15908).

nameq1(_15875:lastname,_15875 isa lastname,[nameq1,{},_15969,_15998,_16027,!,_16061],_15942,_15944) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_15875,n,firstname)),_15969,_15942,_15986),
    w(name(_15875,n,lastname),_15998,_15986,_16015),
    not_look_ahead(w(name(_15919,n,lastname)),_16027,_16015,_16044),
    !,
    accept(_16061,_16044,_15944).

nameq1(_15875:firstname,_15875 isa firstname,[nameq1,{},_15969,_15998,_16027,!,_16061],_15942,_15944) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_15875,n,lastname)),_15969,_15942,_15986),
    w(name(_15875,n,firstname),_15998,_15986,_16015),
    look_ahead(w(name(_15919,n,lastname)),_16027,_16015,_16044),
    !,
    accept(_16061,_16044,_15944).

nameq1(quote(_15881):_15879,quote(_15881)isa thing,[nameq1,_15936,!,{}],_15919,_15921) --> 
    w(quote(_15881),_15936,_15919,_15921),
    !,
    {user:type(thing,_15879)}.

nameq1(_15872,_15873,[nameq1,_15925,_15954,_15978,!,_16007],_15908,_15910) --> 
    number(_15887,_15925,_15908,_15942),
    point0(_15954,_15942,_15969),
    monthnamex(_15978,_15969,_15993),
    !,
    reject(_16007,_15993,_15910).

nameq1(_15872,_15873,[nameq1,_15929,_15958,!,_15992],_15912,_15914) --> 
    number(_15884,_15929,_15912,_15946),
    w(noun(hour,_15889,_15890,_15891),_15958,_15946,_15975),
    !,
    reject(_15992,_15975,_15914).

nameq1(_15872,_15873,[nameq1,_15932,_15961,_15985,!,_16019],_15915,_15917) --> 
    number(_15887,_15932,_15915,_15949),
    point(_15961,_15949,_15976),
    w(noun(_15891,_15892,_15893,_15894),_15985,_15976,_16002),
    !,
    reject(_16019,_16002,_15917).

nameq1(_15872,_15873,[nameq1,_15920,!,_15959],_15903,_15905) --> 
    obviousclock1(_15872,_15873,_15920,_15903,_15939),
    !,
    accept(_15959,_15939,_15905).

nameq1(_15875:_15879,_15875 isa clock,[nameq1,_15933,_15957,!,{}],_15916,_15918) --> 
    clock0(_15933,_15916,_15948),
    time2(_15875,_15957,_15948,_15918),
    !,
    {user:type(clock,_15879)}.

nameq1(_15875:_15879,_15875 isa clock,[nameq1,_15926],_15909,_15911) --> 
    plausibleclock1(_15875:_15879,_15875 isa clock,_15926,_15909,_15911).

nameq1(_15872,_15873,[nameq1,_15914],_15897,_15899) --> 
    date(_15872,_15873,_15914,_15897,_15899).

nameq1(_15875:_15876,_15873,[nameq1,_15930,_15954,!,_15988],_15913,_15915) --> 
    one(_15930,_15913,_15945),
    w(noun(_15889,sin,u,n),_15954,_15945,_15971),
    !,
    reject(_15988,_15971,_15915).

nameq1(_15875:_15879,_15875 isa _15876,[nameq1,_15960,{},{},_16009,!,_16043],_15943,_15945) --> 
    w(name(_15875,_15899,_15876),_15960,_15943,_15977),
    {user:atom(_15875)},
    {user:testmember(_15876,[language,colour])},
    look_ahead(w(noun(_15919,_15920,_15921,_15922)),_16009,_15977,_16026),
    !,
    reject(_16043,_16026,_15945).

nameq1(_15875:_15879,_15875 isa _15876,[nameq1,_15974,_16003,{},{},{},{}],_15957,_15959) --> 
    not_look_ahead(w(name,_15904,gen,_15906),_15974,_15957,_15991),
    w(name(_15875,_15911,_15876),_16003,_15991,_15959),
    {user:_15875\==1},
    {user:(_15876==unkn->value(unknownflag,true);true)},
    {user:_15911\==gen},
    {user:type(_15876,_15879)}.

nameq1(_15875:_15879,_15875 isa _15876,[nameq1,_15969,_15993,_16022,_16046,{},{},{}],_15952,_15954) --> 
    nr0(_15969,_15952,_15984),
    w(name(_15875,n,_15876),_15993,_15984,_16010),
    point0(_16022,_16010,_16037),
    not_look_ahead(w(name(_15914,_15915,date)),_16046,_16037,_15954),
    {user:(_15876==unkn->value(unknownflag,true))},
    {user:number(_15875)},
    {user:type(_15876,_15879)}.

nameq1(_15875:_15876,_15873,[nameq1,_15933,{}],_15916,_15918) --> 
    timeq1(_15875:_15876,_15873,_15933,_15916,_15918),
    {user:(number(_15875),_15875>=100)}.

nameq1(_15875:year,_15875 isa year,[nameq1,_15941,{}],_15924,_15926) --> 
    w(nb(_15875,num),_15941,_15924,_15926),
    {user:(number(_15875),_15875>=1900,_15875=<2099)}.

date(_15875:date,_15875 isa date,[date,_16003,{},_16042,_16066,!,{},{},{},{}],_15986,_15988) --> 
    num_na(_15914,_16003,_15986,_16020),
    {user:(_15914>=1,_15914=<7)},
    slashpoint0(_16042,_16020,_16057),
    w(name(new_years_day,n,date),_16066,_16057,_15988),
    !,
    {user:datetime(_15935,_15936,_15937,_15938,_15939,_15940)},
    {user:(_15936>1->_15910 is _15935+1;_15910 is _15935)},
    {user:_15912 is _15914},
    {user:_15875=date(_15910,1,_15912)}.

date(_15875:date,_15875 isa date,[date,_15994,{},_16033,_16057,{},!,{}],_15977,_15979) --> 
    num_na(_15911,_15994,_15977,_16011),
    {user:(_15911>=1,_15911=<7)},
    slashpoint0(_16033,_16011,_16048),
    w(name(_15926,n,date),_16057,_16048,_15979),
    {user:testmember(_15926,[whitsun_day,easterday,christmas_day])},
    !,
    {user:(named_date(_15926,date(_15944,_15945,_15946)),_15908 is _15911-1,add_days(date(_15944,_15945,_15946),_15908,_15875))}.

date(_15875:date,_15875 isa date,[date,_15950,_15979,_16003,_16032,_16056,!,{}],_15933,_15935) --> 
    dayno(_15906,_15950,_15933,_15967),
    slashpoint0(_15979,_15967,_15994),
    month(_15905,_16003,_15994,_16020),
    slashpoint0(_16032,_16020,_16047),
    year(_15904,_16056,_16047,_15935),
    !,
    {user:_15875=date(_15904,_15905,_15906)}.

date(_15875:date,_15875 isa date,[date,_15965,_15994,_16018,_16047,{},!,_16086,{}],_15948,_15950) --> 
    dayno(_15909,_15965,_15948,_15982),
    slashpoint(_15994,_15982,_16009),
    month(_15908,_16018,_16009,_16035),
    point0(_16047,_16035,_16062),
    {user:(_15909>24;_15908>0)},
    !,
    xyear0(_15908,_15907,_16086,_16062,_15950),
    {user:_15875=date(_15907,_15908,_15909)}.

date(_15875:date,_15875 isa date,[date,_15951,_15980,_16004,_16033,!,_16072,{}],_15934,_15936) --> 
    dayno(_15906,_15951,_15934,_15968),
    slashpoint0(_15980,_15968,_15995),
    monthname(_15905,_16004,_15995,_16021),
    xyear0(_15905,_15904,_16033,_16021,_16052),
    !,
    accept(_16072,_16052,_15936),
    {user:_15875=date(_15904,_15905,_15906)}.

date(_15875:date,_15875 isa date,[date,_15953,_15982,_16011,!,_16045,{},!,_16084],_15936,_15938) --> 
    year(_15902,_15953,_15936,_15970),
    month(_15904,_15982,_15970,_15999),
    dayno(_15906,_16011,_15999,_16028),
    !,
    accept(_16045,_16028,_16060),
    {user:_15875=date(_15902,_15904,_15906)},
    !,
    accept(_16084,_16060,_15938).

timeq1(_15875:clock,_15875 isa clock,[timeq1,lit(halv),_15955,{},!,_15999],_15927,_15929) --> 
    cc(halv,_15927,_15954),
    hours(_15895,_15955,_15954,_15972),
    {user:_15875 is _15895*100-70},
    !,
    accept(_15999,_15972,_15929).

timeq1(_15875:clock,_15875 isa clock,[timeq1,_15925,!,_15959],_15908,_15910) --> 
    time12(_15875,_15925,_15908,_15942),
    !,
    accept(_15959,_15942,_15910).

clock_sequel(_15875:clock,_15875 isa clock,[clock_sequel,_15929,!],_15912,_15914) --> 
    clock_kernel(_15875:clock,_15875 isa clock,_15929,_15912,_15914),
    !.

clock_sequel(_15875:clock,_15875 isa clock,[clock_sequel,_15973,{},_16012,_16041,_16065,{},!,{}],_15956,_15958) --> 
    w(nb(_15912,num),_15973,_15956,_15990),
    {user:_15912<100},
    not_look_ahead([/],_16012,_15990,_16029),
    point(_16041,_16029,_16056),
    w(nb(_15908,num),_16065,_16056,_15958),
    {user:_15908<100},
    !,
    {user:_15875 is _15912*100+_15908}.

clock_sequel(_15875:clock,_15875 isa clock,[clock_sequel,_15958,_15987,{}],_15941,_15943) --> 
    w(nb(_15893,num),_15958,_15941,_15975),
    not_look_ahead([/],_15987,_15975,_15943),
    {user:(_15893>0,_15893<25->_15875 is _15893*100;_15875 is _15893)}.

clock_kernel(_15875:clock,_15875 isa clock,[clock_kernel,_15940,{},!],_15923,_15925) --> 
    number(_15875:_15890,_15940,_15923,_15925),
    {user:(_15875>2500,\+clock_test(_15875))},
    !.

clock_kernel(_15872,_15873,[clock_kernel,lit(nå),!,_15935],_15902,_15904) --> 
    cc(nå,_15902,_15929),
    !,
    reject(_15935,_15929,_15904).

clock_kernel(_15872,_15873,[clock_kernel,lit(en),!,_15935],_15902,_15904) --> 
    cc(en,_15902,_15929),
    !,
    reject(_15935,_15929,_15904).

clock_kernel(_15872,_15873,[clock_kernel,lit(et),!,_15935],_15902,_15904) --> 
    cc(et,_15902,_15929),
    !,
    reject(_15935,_15929,_15904).

clock_kernel(_15875:clock,_15875 isa clock,[clock_kernel,_16001,_16030,_16059,{},_16098,_16127,_16156,_16185,!,_16234],_15984,_15986) --> 
    not_look_ahead(w(name(_15912,n,route)),_16001,_15984,_16018),
    not_look_ahead(w(name(_15920,n,nightbus)),_16030,_16018,_16047),
    w(nb(_15875,num),_16059,_16047,_16076),
    {user:(_15875>=100,clock_test(_15875))},
    not_look_ahead(w(noun(_15943,plu,_15945,_15946)),_16098,_16076,_16115),
    not_look_ahead([tusen],_16127,_16115,_16144),
    not_look_ahead([millioner],_16156,_16144,_16173),
    optional(w(noun(time,sin,def,n)),_16185,_16173,_16217),
    !,
    accept(_16234,_16217,_15986).

clock_kernel(_15872,_15873,[clock_kernel,_15927,_15956,_15980,!,_16014],_15910,_15912) --> 
    num_na(_15887,_15927,_15910,_15944),
    point0(_15956,_15944,_15971),
    monthname(_15889,_15980,_15971,_15997),
    !,
    reject(_16014,_15997,_15912).

clock_kernel(_15875:clock,_15875 isa clock,[clock_kernel,{},_15960,_15989,_16018,!,_16052],_15933,_15935) --> 
    {user:value(busflag,true)},
    hours(_15904,_15960,_15933,_15977),
    colemin0(_15906,_15989,_15977,_16006),
    w(name(_15910,_15911,month),_16018,_16006,_16035),
    !,
    reject(_16052,_16035,_15935).

clock_kernel(_15875:clock,_15875 isa clock,[clock_kernel,{},_15962,_15991,{},!,_16035],_15935,_15937) --> 
    {user:value(busflag,true)},
    hours(_15904,_15962,_15935,_15979),
    colemin0(_15906,_15991,_15979,_16008),
    {user:dedicated_date(date(_15912,_15904,_15906))},
    !,
    reject(_16035,_16008,_15937).

clock_kernel(_15872,_15873,[clock_kernel,_15940,_15969,_15998,{},!,_16042],_15923,_15925) --> 
    hours(_15890,_15940,_15923,_15957),
    colemin2(_15892,_15969,_15957,_15986),
    w(nb(_15896,num),_15998,_15986,_16015),
    {user:_15896>=60},
    !,
    reject(_16042,_16015,_15925).

clock_kernel(_15875:clock,_15875 isa clock,[clock_kernel,_15953,_15982,!,_16016,{}],_15936,_15938) --> 
    hours24(_15901,_15953,_15936,_15970),
    colemin2(_15899,_15982,_15970,_15999),
    !,
    optional(w(noun(time,sin,def,n)),_16016,_15999,_15938),
    {user:_15875 is _15901*100+_15899}.

clock_kernel(_15875:clock,_15875 isa clock,[clock_kernel,_15925,!,_15959],_15908,_15910) --> 
    time012(_15875,_15925,_15908,_15942),
    !,
    accept(_15959,_15942,_15910).

clock_kernel(_15875:clock,_15875 isa clock,[clock_kernel,_15919],_15902,_15904) --> 
    timeoff(_15875,_15919,_15902,_15904).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(et)],_15902,_15904) --> 
    cc(et,_15902,_15904).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(en)],_15902,_15904) --> 
    cc(en,_15902,_15904).

clock_kernel(_15875:clock,_15875 isa clock,[clock_kernel,_15975,{},_16014,_16043,{}],_15958,_15960) --> 
    w(nb(_15900,num),_15975,_15958,_15992),
    {user:_15900>9},
    not_look_ahead(w(noun(minute,_15913,_15914,_15915)),_16014,_15992,_16031),
    not_look_ahead([/],_16043,_16031,_15960),
    {user:(_15900>0,_15900<25->_15875 is _15900*100;fail)}.

namenb(1,[namenb,lit(ett),_15934,!,_15968],_15909,_15911) --> 
    cc(ett,_15909,_15933),
    w(noun(_15887,_15888,_15889,_15890),_15934,_15933,_15951),
    !,
    reject(_15968,_15951,_15911).

namenb(1,[namenb,lit(ett),!,_15929],_15899,_15901) --> 
    cc(ett,_15899,_15923),
    !,
    accept(_15929,_15923,_15901).

namenb(_15872,[namenb,_15911,!,_15940],_15897,_15899) --> 
    a(_15911,_15897,_15926),
    !,
    reject(_15940,_15926,_15899).

namenb(_15872,[namenb,_15911],_15897,_15899) --> 
    w(name(_15872,n,_15878),_15911,_15897,_15899).

namenb(_15872,[namenb,_15910],_15896,_15898) --> 
    w(nb(_15872,num),_15910,_15896,_15898).

dayno(_15872,[dayno,_15921,{}],_15907,_15909) --> 
    num_na(_15872,_15921,_15907,_15909),
    {user:(_15872>0,_15872=<31)}.

month(_15872,[month,_15910,!],_15896,_15898) --> 
    monthnamed(_15872,_15910,_15896,_15898),
    !.

month(_15872,[month,_15907],_15893,_15895) --> 
    monthnum(_15872,_15907,_15893,_15895).

monthnamed(_15872,[monthnamed,_15913,_15942,!],_15899,_15901) --> 
    monthname(_15872,_15913,_15899,_15930),
    point0(_15942,_15930,_15901),
    !.

monthname(_15872,[monthname,_15919,{}],_15905,_15907) --> 
    w(name(_15879,n,_15886),_15919,_15905,_15907),
    {user:monthnumber(_15879,_15872)}.

monthnum(_15872,[monthnum,_15924,{}],_15910,_15912) --> 
    number(_15872:_15888,_15924,_15910,_15912),
    {user:(_15872>0,_15872=<12)}.

monthnamex([monthnamex,_15900],_15889,_15891) --> 
    monthname(_15872,_15900,_15889,_15891).

monthnamex([monthnamex,_15912,{}],_15901,_15903) --> 
    w(name(_15877,_15883,_15884),_15912,_15901,_15903),
    {user:named_date(_15877,_15878)}.

day(_15872,[day,_15919,{}],_15905,_15907) --> 
    w(noun(_15872,_15884,_15885,_15886),_15919,_15905,_15907),
    {user:dayname(_15872)}.

day(weekday,[day,_15912],_15898,_15900) --> 
    w(noun(weekday,_15877,_15878,_15879),_15912,_15898,_15900).

xyear0(_15872,_15873,[xyear0,_15922,_15946,!,_15980],_15905,_15907) --> 
    aar0(_15922,_15905,_15937),
    year(_15873,_15946,_15937,_15963),
    !,
    accept(_15980,_15963,_15907).

xyear0(_15872,_15873,[xyear0,{},{}],_15907,_15907) --> 
    {user:this_year(_15881)},
    {user:adjust_year(_15872,_15881,_15873)}.

year0(_15872,[year0,_15916,_15940,!,_15974],_15902,_15904) --> 
    aar0(_15916,_15902,_15931),
    year(_15872,_15940,_15931,_15957),
    !,
    accept(_15974,_15957,_15904).

year0(_15872,[year0,{}],_15895,_15895) --> 
    {user:this_year(_15872)}.

aar0([aar0,_15911,_15935,!],_15900,_15902) --> 
    point0(_15911,_15900,_15926),
    w(noun(year,_15881,_15882,n),_15935,_15926,_15902),
    !.

aar0([aar0,_15898],_15887,_15889) --> 
    point0(_15898,_15887,_15889).

year(_15872,[year,{},_15951,{},!,_15995],_15927,_15929) --> 
    {user:value(busflag,true)},
    number(_15872:_15897,_15951,_15927,_15968),
    {user:(_15872>=2000,_15872=<9999)},
    !,
    accept(_15995,_15968,_15929).

year(_15872,[year,_15930,{},!,_15974],_15916,_15918) --> 
    number(_15872:_15886,_15930,_15916,_15947),
    {user:(_15872>=1000,_15872=<9999)},
    !,
    accept(_15974,_15947,_15918).

year(_15872,[year,_15941,{},!,_15985,{}],_15927,_15929) --> 
    number(_15891:_15897,_15941,_15927,_15958),
    {user:(_15891>=0,_15891=<99)},
    !,
    accept(_15985,_15958,_15929),
    {user:_15872 is _15891+2000}.

timexp(_15872,[timexp,_15910,_15934],_15896,_15898) --> 
    clock0(_15910,_15896,_15925),
    time2(_15872,_15934,_15925,_15898).

timexp(_15872,[timexp,_15910,_15934],_15896,_15898) --> 
    clock0(_15910,_15896,_15925),
    time1(_15872,_15934,_15925,_15898).

timenexp(_15872,[timenexp,_15910,_15934],_15896,_15898) --> 
    clock(_15910,_15896,_15925),
    time2(_15872,_15934,_15925,_15898).

timenexp(_15872,[timenexp,_15910,_15934],_15896,_15898) --> 
    clock(_15910,_15896,_15925),
    time1(_15872,_15934,_15925,_15898).

clock_time(1300,[clock_time,_15911,!,_15940],_15897,_15899) --> 
    a(_15911,_15897,_15926),
    !,
    accept(_15940,_15926,_15899).

clock_time(1300,[clock_time,lit(nå),!,_15929],_15899,_15901) --> 
    cc(nå,_15899,_15923),
    !,
    reject(_15929,_15923,_15901).

clock_time(_15872,[clock_time,_15932,_15961,{},_16000],_15918,_15920) --> 
    hours(_15886,_15932,_15918,_15949),
    colemin0(_15888,_15961,_15949,_15978),
    {user:_15883 is _15886*100+_15888},
    ampm0(_15883,_15872,_16000,_15978,_15920).

clock_time(_15872,[clock_time,_15907],_15893,_15895) --> 
    time12(_15872,_15907,_15893,_15895).

time012(_15872,[time012,_15907],_15893,_15895) --> 
    time12(_15872,_15907,_15893,_15895).

time012(_15872,[time012,_15960,{},_15999,_16028,{}],_15946,_15948) --> 
    w(nb(_15897,num),_15960,_15946,_15977),
    {user:_15897>1},
    not_look_ahead(w(noun(minute,_15915,_15916,_15917)),_15999,_15977,_16016),
    not_look_ahead([/],_16028,_16016,_15948),
    {user:(_15897>0,_15897<25,_15872 is _15897*100)}.

time012(100,[time012,_15923,_15952,_15981,!],_15909,_15911) --> 
    w(nb(1,num),_15923,_15909,_15940),
    not_look_ahead([/],_15952,_15940,_15969),
    not_look_ahead_np(_15981,_15969,_15911),
    !.

time12(_15872,[time12,_15917,_15946],_15903,_15905) --> 
    time2(_15872,_15917,_15903,_15934),
    w(noun(time,sin,def,n),_15946,_15934,_15905).

time12(_15872,[time12,_15907],_15893,_15895) --> 
    time2(_15872,_15907,_15893,_15895).

time12(_15872,[time12,_15920,_15949,_15973],_15906,_15908) --> 
    time1(_15872,_15920,_15906,_15937),
    point0(_15949,_15937,_15964),
    w(noun(time,sin,def,n),_15973,_15964,_15908).

timeoff(_15872,[timeoff,_15951,{},_15990,_16014,{},{}],_15937,_15939) --> 
    w(nb(_15899,num),_15951,_15937,_15968),
    {user:_15899<100},
    colon0(_15990,_15968,_16005),
    w(nb(_15895,num),_16014,_16005,_15939),
    {user:_15895<100},
    {user:_15872 is _15899*100+_15895}.

time1(_15872,[time1,_15916,!,_15950],_15902,_15904) --> 
    w(nb(0,_15883),_15916,_15902,_15933),
    !,
    reject(_15950,_15933,_15904).

time1(_15872,[time1,lit(ett),_15946,_15975,!,_16009],_15921,_15923) --> 
    cc(ett,_15921,_15945),
    not_look_ahead(w(noun(time,_15893,def,_15895)),_15946,_15945,_15963),
    w(noun(_15899,_15900,_15901,_15902),_15975,_15963,_15992),
    !,
    reject(_16009,_15992,_15923).

time1(100,[time1,lit(ett),_15936,!,_15985],_15911,_15913) --> 
    cc(ett,_15911,_15935),
    optional(w(noun(time,_15890,def,_15892)),_15936,_15935,_15968),
    !,
    accept(_15985,_15968,_15913).

time1(_15872,[time1,_15923,_15947,!,_15981],_15909,_15911) --> 
    a(_15923,_15909,_15938),
    not_look_ahead(w(noun(time,_15888,def,_15890)),_15947,_15938,_15964),
    !,
    reject(_15981,_15964,_15911).

time1(_15872,[time1,_15919,_15948,!,_15987],_15905,_15907) --> 
    time3(_15883,_15919,_15905,_15936),
    ampm0(_15883,_15872,_15948,_15936,_15967),
    !,
    accept(_15987,_15967,_15907).

time1(_15872,[time1,_15957,_15986,_16015,{},!,{},_16069],_15943,_15945) --> 
    w(nb(_15897,num),_15957,_15943,_15974),
    not_look_ahead(w(noun(hour,_15905,_15906,_15907)),_15986,_15974,_16003),
    not_look_ahead([t],_16015,_16003,_16032),
    {user:_15897<25},
    !,
    {user:_15892 is _15897*100},
    ampm0(_15892,_15872,_16069,_16032,_15945).

time1(now,[time1,lit(nå),lit(av),!,_15945],_15904,_15906) --> 
    cc(nå,_15904,_15928),
    cc(av,_15928,_15939),
    !,
    reject(_15945,_15939,_15906).

time1(now,[time1,lit(nå)],_15893,_15895) --> 
    cc(nå,_15893,_15895).

time2(_15872,[time2,_15957,{},_15996,_16020,{},!,_16064,{}],_15943,_15945) --> 
    hours24(_15903,_15957,_15943,_15974),
    {user:_15903=<25},
    point(_15996,_15974,_16011),
    num(_15901,_16020,_16011,_16037),
    {user:(_15901>12,_15901<60)},
    !,
    accept(_16064,_16037,_15945),
    {user:_15872 is _15903*100+_15901}.

time2(_15872,[time2,_15941,_15970,!,{},_16014,{}],_15927,_15929) --> 
    num(_15895,_15941,_15927,_15958),
    w(prep(over),_15970,_15958,_15987),
    !,
    {user:_15895<60},
    hours30(_15894,_16014,_15987,_15929),
    {user:_15872 is _15894+_15895}.

time2(_15872,[time2,_15940,_15969,_15993,!,{},_16032,{}],_15926,_15928) --> 
    num(_15898,_15940,_15926,_15957),
    minutes(_15969,_15957,_15984),
    overclock(_15993,_15984,_16008),
    !,
    {user:_15898<60},
    hours30(_15897,_16032,_16008,_15928),
    {user:_15872 is _15897+_15898}.

time2(_15872,[time2,_15939,{},_15978,!,_16012,{}],_15925,_15927) --> 
    num(_15892,_15939,_15925,_15956),
    {user:_15892<60},
    w(prep(on),_15978,_15956,_15995),
    !,
    hours30(_15891,_16012,_15995,_15927),
    {user:subfromtime(_15891,_15892,_15872)}.

time2(_15872,[time2,_15941,_15970,_15994,!,{},_16033,_16057,{}],_15927,_15929) --> 
    num(_15898,_15941,_15927,_15958),
    minutes(_15970,_15958,_15985),
    onclock(_15994,_15985,_16009),
    !,
    {user:_15898<60},
    clock0(_16033,_16009,_16048),
    hours30(_15897,_16057,_16048,_15929),
    {user:subfromtime(_15897,_15898,_15872)}.

time2(_15872,[time2,_15947,lit(halv),_16002,{},_16041],_15933,_15935) --> 
    optional(w(prep(in)),_15947,_15933,_15979),
    cc(halv,_15979,_16001),
    hours100(_15903,_16002,_16001,_16019),
    {user:_15872 is _15903-100+30},
    optional(w(noun(time,sin,def,n)),_16041,_16019,_15935).

time2(_15872,[time2,lit(halv),_15942,!,_15976,{}],_15917,_15919) --> 
    cc(halv,_15917,_15941),
    prep1(over,_15942,_15941,_15959),
    !,
    hours100(_15891,_15976,_15959,_15919),
    {user:_15872 is _15891+30}.

time2(_15872,[time2,lit(kvart),_15940,_15964,{}],_15915,_15917) --> 
    cc(kvart,_15915,_15939),
    onclock(_15940,_15939,_15955),
    hours100(_15893,_15964,_15955,_15917),
    {user:_15872 is _15893-100+45}.

time2(_15872,[time2,lit(kvart),_15940,_15964,{}],_15915,_15917) --> 
    cc(kvart,_15915,_15939),
    overclock(_15940,_15939,_15955),
    hours(_15893,_15964,_15955,_15917),
    {user:_15872 is _15893*100+15}.

time2(_15872,[time2,_15934,_15963,_15992,{},!,_16036],_15920,_15922) --> 
    hours(_15889,_15934,_15920,_15951),
    minutes(_15891,_15963,_15951,_15980),
    number(_15895:_15896,_15992,_15980,_16009),
    {user:_15895>24},
    !,
    reject(_16036,_16009,_15922).

time2(_15872,[time2,_15927,_15956,_15985,!,_16019],_15913,_15915) --> 
    hours(_15886,_15927,_15913,_15944),
    minutes(_15888,_15956,_15944,_15973),
    w(name(_15892,_15893,month),_15985,_15973,_16002),
    !,
    reject(_16019,_16002,_15915).

time2(_15872,[time2,_15932,_15961,{},_16000],_15918,_15920) --> 
    hours24(_15886,_15932,_15918,_15949),
    colemin(_15888,_15961,_15949,_15978),
    {user:_15883 is _15886*100+_15888},
    ampm0(_15883,_15872,_16000,_15978,_15920).

time2(_15872,[time2,_15926,_15955,_15984,_16008,!,_16042],_15912,_15914) --> 
    hours(_15889,_15926,_15912,_15943),
    minutes(_15891,_15955,_15943,_15972),
    point(_15984,_15972,_15999),
    minutes(_15893,_16008,_15999,_16025),
    !,
    reject(_16042,_16025,_15914).

time2(_15872,[time2,_15940,_15969,{},{},_16018],_15926,_15928) --> 
    hours24(_15889,_15940,_15926,_15957),
    minutes(_15891,_15969,_15957,_15986),
    {user:_15891>12},
    {user:_15886 is _15889*100+_15891},
    ampm0(_15886,_15872,_16018,_15986,_15928).

onclock([onclock,_15917,{},_15956],_15906,_15908) --> 
    w(prep(_15880),_15917,_15906,_15934),
    {user:testmember(_15880,[on,before])},
    clock0(_15956,_15934,_15908).

overclock([overclock,_15917,{},_15956],_15906,_15908) --> 
    w(prep(_15880),_15917,_15906,_15934),
    {user:testmember(_15880,[over,after])},
    clock0(_15956,_15934,_15908).

hours30(_15872,[hours30,lit(halv),_15943,{},!,_15987],_15918,_15920) --> 
    cc(halv,_15918,_15942),
    hours(_15888,_15943,_15942,_15960),
    {user:_15872 is _15888*100-70},
    !,
    accept(_15987,_15960,_15920).

hours30(_15872,[hours30,_15907],_15893,_15895) --> 
    hours100(_15872,_15907,_15893,_15895).

hours100(_15872,[hours100,_15918,_15947,!,_15981],_15904,_15906) --> 
    num(_15872,_15918,_15904,_15935),
    monthname(_15885,_15947,_15935,_15964),
    !,
    reject(_15981,_15964,_15906).

hours100(_15872,[hours100,_15939,{},!,_15983],_15925,_15927) --> 
    num(_15872,_15939,_15925,_15956),
    {user:(_15872 is _15872//100*100,_15872>100,_15872<2500)},
    !,
    accept(_15983,_15956,_15927).

hours100(_15872,[hours100,_15918,{}],_15904,_15906) --> 
    hours(_15882,_15918,_15904,_15906),
    {user:_15872 is _15882*100}.

hours100(100,[hours100,lit(ett),!,_15929],_15899,_15901) --> 
    cc(ett,_15899,_15923),
    !,
    accept(_15929,_15923,_15901).

hours100(1300,[hours100,lit(et),!,_15929],_15899,_15901) --> 
    cc(et,_15899,_15923),
    !,
    accept(_15929,_15923,_15901).

time3(_15872,[time3,_15918,{}],_15904,_15906) --> 
    w(nb(_15872,num),_15918,_15904,_15906),
    {user:_15872>=60}.

ampm0(_15872,_15872,[ampm0,_15917,!,_15946],_15900,_15902) --> 
    amtime(_15917,_15900,_15932),
    !,
    accept(_15946,_15932,_15902).

ampm0(_15872,_15873,[ampm0,_15937,!,{}],_15920,_15922) --> 
    pmtime(_15937,_15920,_15922),
    !,
    {user:(_15872>1200->_15873 is _15872;_15873 is _15872+1200)}.

ampm0(_15872,_15872,[ampm0,lit(h),!],_15899,_15901) --> 
    cc(h,_15899,_15901),
    !.

ampm0(_15872,_15872,[ampm0,[]],_15894,_15894) --> 
    [].

amtime([amtime,lit(am)],_15889,_15891) --> 
    cc(am,_15889,_15891).

amtime([amtime,lit(a),lit(m)],_15894,_15896) --> 
    cc(a,_15894,_15915),
    cc(m,_15915,_15896).

pmtime([pmtime,lit(pm)],_15889,_15891) --> 
    cc(pm,_15889,_15891).

pmtime([pmtime,lit(p),lit(m)],_15894,_15896) --> 
    cc(p,_15894,_15915),
    cc(m,_15915,_15896).

hours24(_15872,[hours24,_15907],_15893,_15895) --> 
    hours(_15872,_15907,_15893,_15895).

hours(_15872,[hours,_15925,_15954,_15983,!,_16012],_15911,_15913) --> 
    not_look_ahead([ett],_15925,_15911,_15942),
    not_look_ahead([et],_15954,_15942,_15971),
    a(_15983,_15971,_15998),
    !,
    reject(_16012,_15998,_15913).

hours(_15872,[hours,_15925,{},_15964],_15911,_15913) --> 
    w(nb(_15872,num),_15925,_15911,_15942),
    {user:_15872=<25},
    optional([h],_15964,_15942,_15913).

smallhours(_15872,[smallhours,_15924,{}],_15910,_15912) --> 
    w(nb(_15872,num),_15924,_15910,_15912),
    {user:(_15872>31,_15872=<59)}.

minutes0([minutes0,_15904,!,_15933],_15893,_15895) --> 
    minutes(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

minutes0([minutes0,[]],_15887,_15887) --> 
    [].

minutes([minutes,_15911,!,_15945],_15900,_15902) --> 
    w(noun(minute,_15881,_15882,_15883),_15911,_15900,_15928),
    !,
    accept(_15945,_15928,_15902).

colemin0(_15872,[colemin0,_15913,!,_15947],_15899,_15901) --> 
    colemin(_15872,_15913,_15899,_15930),
    !,
    accept(_15947,_15930,_15901).

colemin0(_15872,[colemin0,_15916,_15940,!,_15974],_15902,_15904) --> 
    point0(_15916,_15902,_15931),
    minutes0(_15872,_15940,_15931,_15957),
    !,
    accept(_15974,_15957,_15904).

colemin2(_15872,[colemin2,_15921,_15950,_15974,!,_16008],_15907,_15909) --> 
    minutes(_15886,_15921,_15907,_15938),
    point(_15950,_15938,_15965),
    minutes(_15888,_15974,_15965,_15991),
    !,
    reject(_16008,_15991,_15909).

colemin2(_15872,[colemin2,_15919,_15943,_15972,!,_16001],_15905,_15907) --> 
    colon(_15919,_15905,_15934),
    minutes(_15872,_15943,_15934,_15960),
    colesec0(_15972,_15960,_15987),
    !,
    accept(_16001,_15987,_15907).

colemin2(_15872,[colemin2,_15919,_15943,!,_15977],_15905,_15907) --> 
    colon(_15919,_15905,_15934),
    w(nb(_15872,num),_15943,_15934,_15960),
    !,
    reject(_15977,_15960,_15907).

colemin2(0,[colemin2,_15911,!,_15940],_15897,_15899) --> 
    colon(_15911,_15897,_15926),
    !,
    accept(_15940,_15926,_15899).

colemin2(_15872,[colemin2,_15916,_15940,_15969,!],_15902,_15904) --> 
    point0(_15916,_15902,_15931),
    minutes(_15872,_15940,_15931,_15957),
    point0(_15969,_15957,_15904),
    !.

colemin2(_15872,[colemin2,_15913,_15942,!],_15899,_15901) --> 
    minutes(_15872,_15913,_15899,_15930),
    point0(_15942,_15930,_15901),
    !.

colemin(_15872,[colemin,_15929,{},_15968,_15992,!,_16026],_15915,_15917) --> 
    minutes(_15889,_15929,_15915,_15946),
    {user:_15889\==0},
    point(_15968,_15946,_15983),
    minutes(_15896,_15992,_15983,_16009),
    !,
    reject(_16026,_16009,_15917).

colemin(_15872,[colemin,_15919,_15943,!,_15977,_16001],_15905,_15907) --> 
    colon(_15919,_15905,_15934),
    minutes(_15872,_15943,_15934,_15960),
    !,
    accept(_15977,_15960,_15992),
    colesec0(_16001,_15992,_15907).

colemin(_15872,[colemin,_15930,_15954,{},!,_15998],_15916,_15918) --> 
    point(_15930,_15916,_15945),
    minutes(_15872,_15954,_15945,_15971),
    {user:(_15872=0;_15872>12)},
    !,
    colesec0(_15998,_15971,_15918).

colemin(_15872,[colemin,_15919,_15943,!,_15977],_15905,_15907) --> 
    colon(_15919,_15905,_15934),
    w(nb(_15872,num),_15943,_15934,_15960),
    !,
    reject(_15977,_15960,_15907).

colemin(0,[colemin,_15911,!,_15940],_15897,_15899) --> 
    colon(_15911,_15897,_15926),
    !,
    accept(_15940,_15926,_15899).

colesec0([colesec0,lit(:),_15919,!],_15897,_15899) --> 
    cc(:,_15897,_15918),
    minutes(_15880,_15919,_15918,_15899),
    !.

colesec0([colesec0,[]],_15887,_15887) --> 
    [].

minutes0(_15872,[minutes0,_15913,!,_15947],_15899,_15901) --> 
    minutes(_15872,_15913,_15899,_15930),
    !,
    accept(_15947,_15930,_15901).

minutes0(0,[minutes0,[]],_15891,_15891) --> 
    [].

minutes(_15872,[minutes,_15911,!,_15940],_15897,_15899) --> 
    a(_15911,_15897,_15926),
    !,
    reject(_15940,_15926,_15899).

minutes(_15872,[minutes,_15918,{}],_15904,_15906) --> 
    w(nb(_15872,num),_15918,_15904,_15906),
    {user:_15872<100}.

nameq2(_15875:_15879,_15875 isa number,[nameq2,_15934,_15963,_15987,!,_16016],_15917,_15919) --> 
    number(_15875:_15879,_15934,_15917,_15951),
    point0(_15963,_15951,_15978),
    monthnamex(_15987,_15978,_16002),
    !,
    reject(_16016,_16002,_15919).

nameq2(_15872,_15873,[nameq2,_15927,_15951,!,_15985],_15910,_15912) --> 
    one(_15927,_15910,_15942),
    w(noun(_15886,sin,u,n),_15951,_15942,_15968),
    !,
    reject(_15985,_15968,_15912).

nameq2(_15875:_15876,_15875 isa _15876,[nameq2,_15956,_15985,{},_16019,{},!],_15939,_15941) --> 
    number(_15875:_15899,_15956,_15939,_15973),
    point(_15985,_15973,_16000),
    {user:(\+_15875=1)},
    w(noun(_15876,sin,u,n),_16019,_16000,_15941),
    {user:alignable(_15876,number)},
    !.

nameq2(_15875:_15879,_15875 isa clock,[nameq2,{},_15958,{},{},!],_15931,_15933) --> 
    {user:type(clock,_15879)},
    number(_15875:_15901,_15958,_15931,_15933),
    {user:_15875>=1000},
    {user:clock_test(_15875)},
    !.

nameq2(_15875:_15879,_15875 isa number,[nameq2,_15922],_15905,_15907) --> 
    number(_15875:_15879,_15922,_15905,_15907).

number(_15874:number,[number,_15951,lit('.'),_15991,{},!,{}],_15937,_15939) --> 
    num(_15900,_15951,_15937,_15968),
    cc('.',_15968,_15990),
    num(_15898,_15991,_15990,_15939),
    {user:(_15898>=100,_15898<1000)},
    !,
    {user:_15874 is _15900*1000+_15898}.

number(2:_15875,[number,_15926,_15950,{}],_15912,_15914) --> 
    a(_15926,_15912,_15941),
    w(noun(pair,_15891,_15892,_15893),_15950,_15941,_15914),
    {user:type(number,_15875)}.

number(_15874:_15875,[number,_15937,_15961,{},_16000,{}],_15923,_15925) --> 
    only0(_15937,_15923,_15952),
    num(_15894,_15961,_15952,_15978),
    {user:type(number,_15875)},
    thousands0(_15895,_16000,_15978,_15925),
    {user:_15874 is _15894*_15895}.

number(_15872,[number,_15923,_15947,!,_15981],_15909,_15911) --> 
    a(_15923,_15909,_15938),
    not_look_ahead(w(noun(time,_15888,def,_15890)),_15947,_15938,_15964),
    !,
    reject(_15981,_15964,_15911).

thousands0(1000,[thousands0,_15908,!],_15894,_15896) --> 
    tusen(_15908,_15894,_15896),
    !.

thousands0(1000000,[thousands0,_15908,!],_15894,_15896) --> 
    million(_15908,_15894,_15896),
    !.

thousands0(1000000000,[thousands0,_15911,!],_15897,_15899) --> 
    milliard(_15911,_15897,_15899),
    !.

thousands0(1,[thousands0,[]],_15891,_15891) --> 
    [].

tusen([tusen,lit(tusen)],_15889,_15891) --> 
    cc(tusen,_15889,_15891).

tusen([tusen,lit(tusener)],_15889,_15891) --> 
    cc(tusener,_15889,_15891).

million([million,lit(million)],_15889,_15891) --> 
    cc(million,_15889,_15891).

million([million,lit(millioner)],_15889,_15891) --> 
    cc(millioner,_15889,_15891).

milliard([milliard,lit(milliard)],_15889,_15891) --> 
    cc(milliard,_15889,_15891).

milliard([milliard,lit(milliarder)],_15889,_15891) --> 
    cc(milliarder,_15889,_15891).

anumber(_15872,[anumber,_15916,_15940,!,_15974],_15902,_15904) --> 
    a0(_15916,_15902,_15931),
    number(_15872,_15940,_15931,_15957),
    !,
    accept(_15974,_15957,_15904).

anumber(1:_15875,[anumber,_15919,!,{}],_15905,_15907) --> 
    art1(_15919,_15905,_15907),
    !,
    {user:type(number,_15875)}.

intrans_verb(work,_15873,id,_15875,_15876,_15877,_15878,[intrans_verb,_15963,_16007,{}],_15931,_15933) --> 
    lexv(tv,hold,_15877,_15878,_15963,_15931,_15986),
    w(prep(on),_16007,_15986,_15933),
    {user:iv_template(work,_15873,_15875,_15876)}.

intrans_verb(be1,_15873,id,_15875,_15876,_15877,_15878,[intrans_verb,_15963,_16007,{}],_15931,_15933) --> 
    lexv(tv,hold,_15877,_15878,_15963,_15931,_15986),
    w(prep(to),_16007,_15986,_15933),
    {user:iv_template(be1,_15873,_15875,_15876)}.

intrans_verb(_15872,_15873,id,_15875,_15876,_15877,_15878,[intrans_verb,_15956,{}],_15924,_15926) --> 
    lexv(iv,_15872,_15877,_15878,_15956,_15924,_15926),
    {user:iv_template(_15872,_15873,_15875,_15876)}.

intrans_verb(be1,_15873,_15874,_15875,_15876,pres,fin,[intrans_verb,_15975,_16004,_16033,{}],_15943,_15945) --> 
    not_look_ahead(w(verb(go,_15901,fin)),_15975,_15943,_15992),
    be1(_15874,_16004,_15992,_16021),
    not_look_ahead(w(verb(_15910,_15911,_15912)),_16033,_16021,_15945),
    {user:iv_template(be1,_15873,_15875,_15876)}.

intrans_verb(_15872,_15873,_15874,_15875,_15876,past,fin,[intrans_verb,_15964,_15993,_16017,{}],_15932,_15934) --> 
    has(_15874,_15964,_15932,_15981),
    now0(_15993,_15981,_16008),
    lexv(iv,_15872,past,part,_16017,_16008,_15934),
    {user:iv_template(_15872,_15873,_15875,_15876)}.

trans_verbs(_15872,_15873,_15874,_15875,_15876,[trans_verbs,_15948,_16012],_15922,_15924) --> 
    trans_verb(_15881,_15873,_15874,id,_15875,_15893,_15894,_15895,_15948,_15922,_15979),
    trans_verbs0(_15881,_15872,_15873,_15874,_15875,_15876,_16012,_15979,_15924).

trans_verbs0(_15872,_15873,_15874,_15875,_15876,_15877,[trans_verbs0,_15960,_15984,_16048],_15931,_15933) --> 
    andor(_15960,_15931,_15975),
    trans_verb(_15892,_15874,_15875,id,_15876,_15897,_15898,_15899,_15984,_15975,_16015),
    trans_verbs0((_15872,_15892),_15873,_15874,_15875,_15876,_15877,_16048,_16015,_15933).

trans_verbs0(_15872,_15872,_15882:_15883,_15885:_15886,_15876,_15872/_15882/_15885/_15876,[trans_verbs0,[]],_15921,_15921) --> 
    [].

trans_verb(tell,_15873,_15874,id,_15876,_15877,_15878,fin,[trans_verb,_15968,_16012,{}],_15933,_15935) --> 
    lexv(tv,tell,_15878,fin,_15968,_15933,_15991),
    particle0(tell,_16012,_15991,_15935),
    {user:tv_template(tell,_15873,_15874,_15876,_15877)}.

trans_verb(_15872,_15873,_15874,_15875,_15876,_15877,past,fin,[trans_verb,_15968,_15997,{}],_15933,_15935) --> 
    has(_15875,_15968,_15933,_15985),
    lexv(tv,_15872,past,part,_15997,_15985,_15935),
    {user:tv_template(_15872,_15873,_15874,_15876,_15877)}.

trans_verb(_15872,_15873,_15874,id,_15876,_15877,_15878,_15879,[trans_verb,_15963,{}],_15928,_15930) --> 
    lexv(tv,_15872,_15878,_15879,_15963,_15928,_15930),
    {user:tv_template(_15872,_15873,_15874,_15876,_15877)}.

rep_v(be_free,pres,fin,[rep_v,_15922],_15902,_15904) --> 
    w(adj2(free,nil),_15922,_15902,_15904).

rep_v(_15872,_15873,_15874,[rep_v,_15935,_15959,_16003,_16032],_15915,_15917) --> 
    aux0(_15935,_15915,_15950),
    lexv(rv,_15872,_15873,_15874,_15959,_15950,_15982),
    reflexiv0(_15872,_16003,_15982,_16020),
    rep_particlev0(_15872,_16032,_16020,_15917).

rep_v(want,pres,fin,[rep_v,lit(skal),!,_15941],_15905,_15907) --> 
    cc(skal,_15905,_15935),
    !,
    reject(_15941,_15935,_15907).

there_be_modal(think,[there_be_modal,_15919,_15943,lit(an)],_15905,_15907) --> 
    thereit(_15919,_15905,_15934),
    w(verb(go,_15885,_15886),_15943,_15934,_15960),
    cc(an,_15960,_15907).

there_be_modal(_15872,[there_be_modal,_15910,_15934],_15896,_15898) --> 
    thereit(_15910,_15896,_15925),
    be_modal(_15872,_15934,_15925,_15898).

be_there_modal(_15872,[be_there_modal,_15913,_15937,_15961],_15899,_15901) --> 
    be(_15913,_15899,_15928),
    thereit(_15937,_15928,_15952),
    be_modal(_15872,_15961,_15952,_15901).

be_modal(_15872,[be_modal,_15910,_15934],_15896,_15898) --> 
    be(_15910,_15896,_15925),
    modal(_15872,_15934,_15925,_15898).

be_modal(seem,[be_modal,_15911],_15897,_15899) --> 
    w(verb(seem,_15877,fin),_15911,_15897,_15899).

modal(_15872,[modal,_15914,_15953],_15900,_15902) --> 
    rep_v(_15872,past,part,_15914,_15900,_15935),
    tobetrue(_15877,_15953,_15935,_15902).

modal(_15872,[modal,_15909],_15895,_15897) --> 
    rep_v(_15872,_15875,fin,_15909,_15895,_15897).

modal(think,[modal,_15910],_15896,_15898) --> 
    w(adj2(possible,nil),_15910,_15896,_15898).

modal(think,[modal,_15910],_15896,_15898) --> 
    w(adj2(best,nil),_15910,_15896,_15898).

modal(free,[modal,_15910],_15896,_15898) --> 
    w(adj2(free,nil),_15910,_15896,_15898).

tobetrue(_15872,[tobetrue,_15910,_15934],_15896,_15898) --> 
    infinitive(_15910,_15896,_15925),
    be_truefalse(_15872,_15934,_15925,_15898).

tobetrue(id,[tobetrue,[]],_15891,_15891) --> 
    [].

pvimodal(_15872,_15873,[pvimodal,_15932,{},{}],_15915,_15917) --> 
    lexv(tv,_15872,_15888,fin,_15932,_15915,_15917),
    {user:_15872\==be},
    {user:pvi_templ(_15872,_15873)}.

lexvaccept(_15872,_15873,_15874,_15875,_15876,[lexvaccept,_15938,!],_15912,_15914) --> 
    hlexv(_15872,_15873,_15874,_15875,_15876,_15938,_15912,_15914),
    !.

hlexv(_15872,_15873,_15874,_15875,_15876,[hlexv,_15971,_15995,_16024,_16053,{},_16097,{}],_15945,_15947) --> 
    aux0(_15971,_15945,_15986),
    negation0(_15898,_15995,_15986,_16012),
    w(verb(_15906,_15874,_15875),_16024,_16012,_16041),
    particlev0(_15906,_15873,_16053,_16041,_16072),
    {user:verbtype(_15873,_15872)},
    negation0(_15899,_16097,_16072,_15947),
    {user:bigno(_15898,_15899,_15876)}.

hlexv(iv,_15873,_15874,fin,_15876,[hlexv,_15952,_15981,_16005,_16034,!],_15926,_15928) --> 
    w(verb(be,_15874,fin),_15952,_15926,_15969),
    now0(_15981,_15969,_15996),
    negation0(_15876,_16005,_15996,_16022),
    particlev2(be,_15873,_16034,_16022,_15928),
    !.

hlexv(_15872,_15873,past,fin,_15876,[hlexv,_15950,_15974,_15998,_16027,_16071],_15924,_15926) --> 
    has(_15950,_15924,_15965),
    danow0(_15974,_15965,_15989),
    negation0(_15876,_15998,_15989,_16015),
    lexv(_15872,_15873,past,part,_16027,_16015,_16050),
    reflexiv0(_15873,_16071,_16050,_15926).

hlexv(tv,bring,_15874,_15875,id,[hlexv,_15940,_15969],_15914,_15916) --> 
    w(verb(have,_15874,_15875),_15940,_15914,_15957),
    prep1(with,_15969,_15957,_15916).

hlexv(_15872,_15873,past,fin,_15876,[hlexv,_15957,_15986,_16015,{}],_15931,_15933) --> 
    w(verb(get,_15895,fin),_15957,_15931,_15974),
    negation0(_15876,_15986,_15974,_16003),
    w(verb(_15873,past,part),_16015,_16003,_15933),
    {user:verbtype(_15873,_15872)}.

hlexv(_15872,_15873,_15874,fin,_15876,[hlexv,_15965,_15994,_16023,{},!],_15939,_15941) --> 
    w(verb(get,_15874,fin),_15965,_15939,_15982),
    negation0(_15876,_15994,_15982,_16011),
    lexv(_15872,_15873,_15900,_15901,_16023,_16011,_15941),
    {user:(_15900\==imp,_15901\=fin)},
    !.

hlexv(_15872,_15873,past,fin,_15876,[hlexv,_15954,_15983,_16007,_16036,!],_15928,_15930) --> 
    w(verb(be,_15893,fin),_15954,_15928,_15971),
    now0(_15983,_15971,_15998),
    negation0(_15876,_16007,_15998,_16024),
    lexv(_15872,_15873,past,part,_16036,_16024,_15930),
    !.

hlexv(_15872,_15873,past,fin,_15876,[hlexv,_15945,_15969,_15993,_16022],_15919,_15921) --> 
    has(_15945,_15919,_15960),
    redundant0(_15969,_15960,_15984),
    negation0(_15876,_15993,_15984,_16010),
    lexv(_15872,_15873,past,part,_16022,_16010,_15921).

hlexv(_15872,know1,_15874,_15875,_15876,[hlexv,_15976,_16005,_16034,{},!,{}],_15950,_15952) --> 
    w(verb(know,_15874,_15875),_15976,_15950,_15993),
    negation0(_15876,_16005,_15993,_16022),
    look_ahead([_15907],_16034,_16022,_15952),
    {user:testmember(_15907,[hva,hvem,hvilken,hvilket,hvilke])},
    !,
    {user:_15872=tv}.

hlexv(tv,know1,_15874,_15875,_15876,[hlexv,_15945,_15974,lit(om)],_15919,_15921) --> 
    w(verb(know,_15874,_15875),_15945,_15919,_15962),
    negation0(_15876,_15974,_15962,_15991),
    cc(om,_15991,_15921).

hlexv(tv,_15873,_15874,fin,_15876,[hlexv,_15970,_15999,_16028,_16052,_16086,!,[]],_15944,_15946) --> 
    w(verb(get,_15874,fin),_15970,_15944,_15987),
    negation0(_15876,_15999,_15987,_16016),
    look_ahead_np(_16028,_16016,_16043),
    np1_accept(_15899,_15900,_16052,_16043,_16071),
    w(verb(_15873,past,part),_16086,_16071,_16103),
    !,
    pushstack(free,xnp(_15899,_15900),nil,_16103,_15946),
    [].

hlexv(tv,get,pres,fin,_15876,[hlexv,lit(får),_15968,_15997,_16026,!],_15931,_15933) --> 
    cc(får,_15931,_15967),
    not_look_ahead(w(verb(_15896,inf,_15898)),_15968,_15967,_15985),
    negation0(_15876,_15997,_15985,_16014),
    optional([opp],_16026,_16014,_15933),
    !.

hlexv(iv,_15873,_15874,_15875,_15876,[hlexv,_15964,{},{},_16013,_16042],_15938,_15940) --> 
    w(verb(_15873,_15874,_15875),_15964,_15938,_15981),
    {user:rv_templ(_15873,_15903)},
    {user:tv_templ(_15873,_15908,nil)},
    negation0(_15876,_16013,_15981,_16030),
    look_ahead([om],_16042,_16030,_15940).

hlexv(_15872,_15873,_15874,_15875,_15876,[hlexv,_15978,{},_16017,_16046,!,{}],_15952,_15954) --> 
    w(verb(_15873,_15874,_15875),_15978,_15952,_15995),
    {user:testmember(_15873,[understand,believe,know])},
    negation0(_15876,_16017,_15995,_16034),
    look_ahead_lit([at,hvordan,hvorfor,når],_16046,_16034,_15954),
    !,
    {user:_15872=rv}.

hlexv(_15872,_15873,_15874,_15875,_15876,[hlexv,_15961,{},_16000,!,{}],_15935,_15937) --> 
    w(verb(_15873,_15874,_15875),_15961,_15935,_15978),
    {user:testmember(_15873,[believe])},
    negation0(_15876,_16000,_15978,_15937),
    !,
    {user:_15872=rv}.

hlexv(_15872,_15873,_15874,_15875,_15876,[hlexv,_15961,{},_16000,!,{}],_15935,_15937) --> 
    w(verb(_15873,_15874,_15875),_15961,_15935,_15978),
    {user:testmember(_15873,[understand])},
    negation0(_15876,_16000,_15978,_15937),
    !,
    {user:_15872=tv}.

hlexv(rv,_15873,_15874,_15875,_15876,[hlexv,{},_15982,_16026,_16055,_16084,_16113,!,_16147],_15946,_15948) --> 
    {user:value(textflag,true)},
    lexv(rv,_15873,_15874,_15875,_15982,_15946,_16005),
    negation0(_15876,_16026,_16005,_16043),
    not_look_ahead([det],_16055,_16043,_16072),
    not_look_ahead([hva],_16084,_16072,_16101),
    rep_particlev0(_15873,_16113,_16101,_16130),
    !,
    accept(_16147,_16130,_15948).

hlexv(tv,know1,pres,fin,_15876,[hlexv,lit(kan),_15972,_16001,_16030,_16059],_15935,_15937) --> 
    cc(kan,_15935,_15971),
    negation0(_15876,_15972,_15971,_15989),
    not_look_ahead([jeg],_16001,_15989,_16018),
    not_look_ahead([du],_16030,_16018,_16047),
    not_look_ahead(w(verb(_15894,_15895,_15896)),_16059,_16047,_15937).

hlexv(_15872,_15873,_15874,_15875,_15876,[hlexv,{},_15959,_16003,!],_15923,_15925) --> 
    {user:nonvar(_15872)},
    lexv(_15872,_15873,_15874,_15875,_15959,_15923,_15982),
    negation0(_15876,_16003,_15982,_15925),
    !.

hlexv(_15872,_15873,_15874,_15875,_15876,[hlexv,_15939,_15983],_15913,_15915) --> 
    lexv(_15872,_15873,_15874,_15875,_15939,_15913,_15962),
    negation0(_15876,_15983,_15962,_15915).

lexv(_15872,_15873,past,fin,[lexv,_15961,_15990,_16014,_16043,!,{},!],_15938,_15940) --> 
    w(verb(have,_15898,fin),_15961,_15938,_15978),
    redundant0(_15990,_15978,_16005),
    w(verb(_15903,past,part),_16014,_16005,_16031),
    particlev2(_15903,_15873,_16043,_16031,_15940),
    !,
    {user:verbtype(_15873,_15872)},
    !.

lexv(_15872,_15873,_15874,part,[lexv,_15946,_15975,{},!],_15923,_15925) --> 
    w(verb(_15888,_15874,part),_15946,_15923,_15963),
    particlev2(_15888,_15873,_15975,_15963,_15925),
    {user:verbtype(_15873,_15872)},
    !.

lexv(iv,_15873,past,fin,[lexv,_15940,{},!],_15917,_15919) --> 
    w(verb(_15873,past,part),_15940,_15917,_15919),
    {user:verbtype(_15873,iv)},
    !.

lexv(iv,_15873,pres,part,[lexv,_15940,{},!],_15917,_15919) --> 
    w(verb(_15873,pres,part),_15940,_15917,_15919),
    {user:verbtype(_15873,iv)},
    !.

lexv(dtv,_15873,_15874,_15875,[lexv,_15937,{}],_15914,_15916) --> 
    w(verb(_15873,_15874,_15875),_15937,_15914,_15916),
    {user:verbtype(_15873,dtv)}.

lexv(iv,be1,pres,fin,[lexv,_15929],_15906,_15908) --> 
    w(verb(be,inf,fin),_15929,_15906,_15908).

lexv(tv,_15873,past,part,[lexv,_15949,_15978,{},!],_15926,_15928) --> 
    w(verb(be,past,part),_15949,_15926,_15966),
    w(verb(_15873,past,part),_15978,_15966,_15928),
    {user:verbtype(_15873,tv)},
    !.

lexv(_15872,_15873,past,part,[lexv,_15940,{},!],_15917,_15919) --> 
    w(verb(_15873,past,part),_15940,_15917,_15919),
    {user:verbtype(_15873,_15872)},
    !.

lexv(tv,tell,_15874,_15875,[lexv,_15947,_15976,_16005,!,_16054],_15924,_15926) --> 
    w(verb(tell,_15874,_15875),_15947,_15924,_15964),
    reflexiv0(tell,_15976,_15964,_15993),
    optional([om],_16005,_15993,_16037),
    !,
    accept(_16054,_16037,_15926).

lexv(rv,_15873,_15874,_15875,[lexv,_15944,{},_15983],_15921,_15923) --> 
    w(verb(_15873,_15874,_15875),_15944,_15921,_15961),
    {user:rv_templ(_15873,_15896)},
    not_look_ahead([hva],_15983,_15961,_15923).

lexv(iv,_15873,_15874,fin,[lexv,_15941,_15970,!],_15918,_15920) --> 
    w(verb(be,_15874,fin),_15941,_15918,_15958),
    w(verb(_15873,pres,part),_15970,_15958,_15920),
    !.

lexv(iv,_15873,past,fin,[lexv,_15941,_15970,!],_15918,_15920) --> 
    w(verb(be,_15886,fin),_15941,_15918,_15958),
    w(verb(_15873,pres,part),_15970,_15958,_15920),
    !.

lexv(rv,_15873,_15874,_15875,[lexv,_15959,{},_15998,_16027,!,_16061],_15936,_15938) --> 
    w(verb(_15873,_15874,_15875),_15959,_15936,_15976),
    {user:testmember(_15873,[tell,notify])},
    reflexiv0(_15873,_15998,_15976,_16015),
    not_look_ahead([hva],_16027,_16015,_16044),
    !,
    accept(_16061,_16044,_15938).

lexv(rv,show,_15874,_15875,[lexv,_15934,_15963],_15911,_15913) --> 
    w(verb(show,_15874,_15875),_15934,_15911,_15951),
    reflexiv0(show,_15963,_15951,_15913).

lexv(rv,mean,_15874,_15875,[lexv,_15939,_15968,!],_15916,_15918) --> 
    w(verb(mean,_15874,_15875),_15939,_15916,_15956),
    look_ahead([at],_15968,_15956,_15918),
    !.

lexv(rv,mean,_15874,_15875,[lexv,_15950,_15979,_16008,_16037],_15927,_15929) --> 
    w(verb(mean,_15874,_15875),_15950,_15927,_15967),
    not_look_ahead([hva],_15979,_15967,_15996),
    not_look_ahead([en],_16008,_15996,_16025),
    not_look_ahead([noe],_16037,_16025,_15929).

lexv(tv,know1,_15874,_15875,[lexv,_15943,_15972,_16001],_15920,_15922) --> 
    w(verb(know,_15874,_15875),_15943,_15920,_15960),
    not_look_ahead([når],_15972,_15960,_15989),
    not_look_ahead([at],_16001,_15989,_15922).

lexv(_15872,_15873,_15874,_15875,[lexv,_15949,_15973,_15997,{},!,_16041],_15926,_15928) --> 
    do(_15949,_15926,_15964),
    faa(_15973,_15964,_15988),
    w(verb(_15873,_15874,_15875),_15997,_15988,_16014),
    {user:verbtype(_15873,_15872)},
    !,
    accept(_16041,_16014,_15928).

lexv(_15872,_15873,_15874,_15875,[lexv,_15953,_15977,_16006,{},!,_16050],_15930,_15932) --> 
    do(_15953,_15930,_15968),
    not_look_ahead([nå],_15977,_15968,_15994),
    w(verb(_15873,_15874,_15875),_16006,_15994,_16023),
    {user:verbtype(_15873,_15872)},
    !,
    accept(_16050,_16023,_15932).

lexv(_15872,_15873,_15874,_15875,[lexv,_15956,_15980,_16009,{},{}],_15933,_15935) --> 
    faa(_15956,_15933,_15971),
    not_look_ahead([nå],_15980,_15971,_15997),
    lexv(_15872,_15873,_15874,_15875,_16009,_15997,_15935),
    {user:verbtype(_15873,_15872)},
    {user:(\+_15873=manage)}.

lexv(tv,run,_15874,_15875,[lexv,_15940,_15969,!,_16003],_15917,_15919) --> 
    w(verb(run,_15874,_15875),_15940,_15917,_15957),
    prep1(with,_15969,_15957,_15986),
    !,
    reject(_16003,_15986,_15919).

lexv(tv,evah,pres,fin,[lexv,_15935,!,_15969],_15912,_15914) --> 
    w(verb(evah,pres,fin),_15935,_15912,_15952),
    !,
    accept(_15969,_15952,_15914).

lexv(cv,be,pres,fin,[lexv,_15926,_15950],_15903,_15905) --> 
    aux0(_15926,_15903,_15941),
    be(_15950,_15941,_15905).

lexv(tv,wonder,_15874,_15875,[lexv,_15929],_15906,_15908) --> 
    w(verb(wonder,_15874,_15875),_15929,_15906,_15908).

lexv(tv,want,_15874,_15875,[lexv,_15932,_15961],_15909,_15911) --> 
    w(verb(think,_15874,_15875),_15932,_15909,_15949),
    rfxpron(_15961,_15949,_15911).

lexv(_15872,_15873,past,fin,[lexv,_15966,_15990,_16019,{},_16058,_16087,{}],_15943,_15945) --> 
    aux1(_15966,_15943,_15981),
    w(verb(_15902,past,part),_15990,_15981,_16007),
    not_look_ahead([om],_16019,_16007,_16036),
    {user:_15902\==have},
    reflexiv0(_15902,_16058,_16036,_16075),
    particlev0(_15902,_15873,_16087,_16075,_15945),
    {user:verbtype(_15873,_15872)}.

lexv(_15872,_15873,_15874,_15875,[lexv,{},_15975,_16004,{},_16043,{}],_15942,_15944) --> 
    {user:_15872==tv},
    w(verb(_15873,_15874,_15875),_15975,_15942,_15992),
    not_look_ahead([om],_16004,_15992,_16021),
    {user:_15873\==have},
    reflexiv0(_15873,_16043,_16021,_15944),
    {user:verbtype(_15873,_15872)}.

lexv(_15872,_15873,_15874,_15875,[lexv,{},_15990,{},_16029,{},_16068,_16097,{}],_15957,_15959) --> 
    {user:var(_15872)},
    w(verb(_15909,_15874,_15875),_15990,_15957,_16007),
    {user:(\+rv_templ(_15909,_15918))},
    not_look_ahead([om],_16029,_16007,_16046),
    {user:_15909\==have},
    reflexiv0(_15909,_16068,_16046,_16085),
    particlev0(_15909,_15873,_16097,_16085,_15959),
    {user:verbtype(_15873,_15872)}.

lexv(iv,_15873,_15874,_15875,[lexv,_15967,_15991,{},{},_16040,_16069,{}],_15944,_15946) --> 
    aux0(_15967,_15944,_15982),
    w(verb(_15902,_15874,_15875),_15991,_15982,_16008),
    {user:_15875==fin},
    {user:_15902\==have},
    reflexiv0(_15902,_16040,_16008,_16057),
    particlev0(_15902,_15873,_16069,_16057,_15946),
    {user:verbtype(_15873,iv)}.

lexv(_15872,have,_15874,_15875,[lexv,_15952,_15976,{},_16015],_15929,_15931) --> 
    aux0(_15952,_15929,_15967),
    w(verb(have,_15874,_15875),_15976,_15967,_15993),
    {user:verbtype(have,_15872)},
    not_look_ahead(w(noun(arrival,_15891,_15892,n)),_16015,_15993,_15931).

lexv(_15872,_15873,past,fin,[lexv,_15940,_15964,{}],_15917,_15919) --> 
    has(_15940,_15917,_15955),
    w(verb(_15873,past,part),_15964,_15955,_15919),
    {user:verbtype(_15873,_15872)}.

lexv(tv,bring,_15874,_15875,[lexv,_15934,_15963],_15911,_15913) --> 
    w(verb(take,_15874,_15875),_15934,_15911,_15951),
    prep1(with,_15963,_15951,_15913).

lexv(_15872,_15873,_15874,_15875,[lexv,_15949,_15978,_16002,{},!],_15926,_15928) --> 
    w(verb(_15891,_15874,_15875),_15949,_15926,_15966),
    redundant0(_15978,_15966,_15993),
    particlev0(_15891,_15873,_16002,_15993,_15928),
    {user:verbtype(_15873,_15872)},
    !.

preadjs0(_15872,[preadjs0,lit(s),_15927,!,_15956],_15902,_15904) --> 
    cc(s,_15902,_15926),
    look_ahead_clock(_15927,_15926,_15942),
    !,
    reject(_15956,_15942,_15904).

preadjs0(_15872,[preadjs0,_15913,_15937,!],_15899,_15901) --> 
    so(_15913,_15899,_15928),
    preadjs(_15872,_15937,_15928,_15901),
    !.

preadjs0((_15874,_15875),[preadjs0,_15921,_15945,_15974,_15998],_15907,_15909) --> 
    dent0(_15921,_15907,_15936),
    preadj1(_15874,_15945,_15936,_15962),
    adj_conjunction(_15974,_15962,_15989),
    preadj1(_15875,_15998,_15989,_15909).

preadjs0((_15874,_15875),[preadjs0,_15927,_15951,_15980,_16009],_15913,_15915) --> 
    dent0(_15927,_15913,_15942),
    preadj1(_15874,_15951,_15942,_15968),
    not_look_ahead(w(prep(_15894)),_15980,_15968,_15997),
    preadjs0(_15875,_16009,_15997,_15915).

preadjs0(true,[preadjs0,[]],_15891,_15891) --> 
    [].

preadjs((_15874,_15875),[preadjs,_15924,_15953,_15982],_15910,_15912) --> 
    preadj1(_15874,_15924,_15910,_15941),
    not_look_ahead(w(prep(_15891)),_15953,_15941,_15970),
    preadjs0(_15875,_15982,_15970,_15912).

preadj1(nil/first,[preadj1,_15919,_15948,!],_15905,_15907) --> 
    w(nb(1,num),_15919,_15905,_15936),
    point(_15948,_15936,_15907),
    !.

preadj1(nil/second,[preadj1,_15919,_15948,!],_15905,_15907) --> 
    w(nb(2,num),_15919,_15905,_15936),
    point(_15948,_15936,_15907),
    !.

preadj1(nil/third,[preadj1,_15919,_15948,!],_15905,_15907) --> 
    w(nb(3,num),_15919,_15905,_15936),
    point(_15948,_15936,_15907),
    !.

preadj1(nil/_15875,[preadj1,_15930,{},!,_15974],_15916,_15918) --> 
    w(name(_15875,n,station),_15930,_15916,_15947),
    {user:(\+adjname_templ(_15875,_15897))},
    !,
    reject(_15974,_15947,_15918).

preadj1(nil/_15875,[preadj1,_15925,{},!],_15911,_15913) --> 
    w(name(_15875,n,_15887),_15925,_15911,_15913),
    {user:adjname_templ(_15875,_15892)},
    !.

preadj1(_15874/_15875,[preadj1,_15918,_15947],_15904,_15906) --> 
    gradverb(_15874,_15918,_15904,_15935),
    w(adj2(_15875,nil),_15947,_15935,_15906).

preadj1(_15874/_15875,[preadj1,_15955,_15984,_16013,_16057,{},!],_15941,_15943) --> 
    not_look_ahead_lit([først,senest,tidligst],_15955,_15941,_15972),
    not_look_ahead(w(prep(_15904)),_15984,_15972,_16001),
    optional([mye],_16013,_16001,_16045),
    w(adj2(_15875,_15874),_16057,_16045,_15943),
    {user:(\+user:post_adjective(_15875))},
    !.

adj_conjunction0([adj_conjunction0,_15901,!],_15890,_15892) --> 
    adj_conjunction(_15901,_15890,_15892),
    !.

adj_conjunction0([adj_conjunction0,[]],_15887,_15887) --> 
    [].

adj_conjunction([adj_conjunction,lit(og)],_15889,_15891) --> 
    cc(og,_15889,_15891).

adj_conjunction([adj_conjunction,lit(men)],_15889,_15891) --> 
    cc(men,_15889,_15891).

adj_conjunction([adj_conjunction,lit(eller)],_15889,_15891) --> 
    cc(eller,_15889,_15891).

adj_conjunction([adj_conjunction,lit(/)],_15889,_15891) --> 
    cc(/,_15889,_15891).

adj1s((_15880;_15881),_15873,_15874,_15877 or _15878,[adj1s,_15950,lit(eller),_16005,!],_15927,_15929) --> 
    adj1(_15880,_15873,_15874,_15877,_15950,_15927,_15973),
    cc(eller,_15973,_16004),
    adj1(_15881,_15873,_15874,_15878,_16005,_16004,_15929),
    !.

adj1s((_15880,_15881),_15873,_15874,_15877 and _15878,[adj1s,_15959,lit(og),_16014,_16058,!],_15936,_15938) --> 
    adj1(_15880,_15873,_15874,_15877,_15959,_15936,_15982),
    cc(og,_15982,_16013),
    adj1(_15881,_15873,_15874,_15878,_16014,_16013,_16037),
    not_look_ahead(w(prep(_15911)),_16058,_16037,_15938),
    !.

adj1s(_15872,_15873,_15874,_15875,[adj1s,_15928],_15905,_15907) --> 
    adj1(_15872,_15873,_15874,_15875,_15928,_15905,_15907).

adj1(_15872,_15873,_15874,_15875,[adj1,_15944,_15973,{}],_15921,_15923) --> 
    gradverbs0(_15885,_15944,_15921,_15961),
    w(adj2(_15872,nil),_15973,_15961,_15923),
    {user:adj_template(_15885,_15872,_15873,_15874,_15875)}.

adj1(_15872,_15873,_15874,_15875,[adj1,_15939,{}],_15916,_15918) --> 
    w(adj2(_15872,_15882),_15939,_15916,_15918),
    {user:adj_template(_15882,_15872,_15873,_15874,_15875)}.

gradverbs0(_15872,[gradverbs0,_15915,!,_15949],_15901,_15903) --> 
    gradverb(_15872,_15915,_15901,_15932),
    !,
    gradverbs0(_15880,_15949,_15932,_15903).

gradverbs0(nil,[gradverbs0,[]],_15891,_15891) --> 
    [].

gradverb0(more,[gradverb0,lit(mer),_15931,!],_15906,_15908) --> 
    cc(mer,_15906,_15930),
    look_ahead(w(adj2(_15886,nil)),_15931,_15930,_15908),
    !.

gradverb0(_15872,[gradverb0,_15919,_15948,!],_15905,_15907) --> 
    gradverb(_15872,_15919,_15905,_15936),
    not_look_ahead(w(prep(_15886)),_15948,_15936,_15907),
    !.

gradverb0(nil,[gradverb0,[]],_15891,_15891) --> 
    [].

gradverb(little,[gradverb,lit(dårlig)],_15893,_15895) --> 
    cc(dårlig,_15893,_15895).

gradverb(more,[gradverb,lit(litt),lit(mer),!],_15901,_15903) --> 
    cc(litt,_15901,_15925),
    cc(mer,_15925,_15903),
    !.

gradverb(more,[gradverb,lit(mye),lit(mer),!],_15901,_15903) --> 
    cc(mye,_15901,_15925),
    cc(mer,_15925,_15903),
    !.

gradverb(more,[gradverb,lit(mer)],_15893,_15895) --> 
    cc(mer,_15893,_15895).

gradverb(only,[gradverb,lit(bare)],_15893,_15895) --> 
    cc(bare,_15893,_15895).

gradverb(too,[gradverb,lit(for)],_15893,_15895) --> 
    cc(for,_15893,_15895).

gradverb(very,[gradverb,lit(meget)],_15893,_15895) --> 
    cc(meget,_15893,_15895).

gradverb(very,[gradverb,lit(veldig)],_15893,_15895) --> 
    cc(veldig,_15893,_15895).

gradverb(little,[gradverb,lit(litt)],_15893,_15895) --> 
    cc(litt,_15893,_15895).

gradverb(somewhat,[gradverb,lit(noe)],_15893,_15895) --> 
    cc(noe,_15893,_15895).

gradverb(often,[gradverb,lit(ofte)],_15893,_15895) --> 
    cc(ofte,_15893,_15895).

gradverb(nil,[gradverb,lit(så)],_15893,_15895) --> 
    cc(så,_15893,_15895).

prepnom(_15872,[prepnom,_15921,{},!,_15965],_15907,_15909) --> 
    prep(_15872,_15921,_15907,_15938),
    {user:_15872==regarding},
    !,
    accept(_15965,_15938,_15909).

prepnom(_15872,[prepnom,_15907],_15893,_15895) --> 
    prepnof(_15872,_15907,_15893,_15895).

prepnog(long,from,[prepnog,_15919,!,_15953],_15902,_15904) --> 
    prep1(from,_15919,_15902,_15936),
    !,
    accept(_15953,_15936,_15904).

prepnog(possible,_15873,[prepnog,!,_15919],_15897,_15899) --> 
    !,
    reject(_15919,_15897,_15899).

prepnog(_15872,_15873,[prepnog,_15919,!,_15953],_15902,_15904) --> 
    prepnof(_15873,_15919,_15902,_15936),
    !,
    accept(_15953,_15936,_15904).

prepnof(_15872,[prepnof,_15917,{}],_15903,_15905) --> 
    prep(_15872,_15917,_15903,_15905),
    {user:(\+_15872=of)}.

defaultprep(_15872,_15873,_15874,[defaultprep,{},{},_15963,!,_16007],_15923,_15925) --> 
    {user:_15872\==be},
    {user:vartypeid(_15873,_15896)},
    adjustprep0(_15872,_15896,_15874,_15963,_15923,_15984),
    !,
    accept(_16007,_15984,_15925).

adjustprep0(_15872,_15873,_15874,[adjustprep0,_15924,!],_15904,_15906) --> 
    adjustprep(_15872,_15873,_15874,_15924,_15904,_15906),
    !.

adjustprep0(_15872,_15873,_15874,[adjustprep0,_15921],_15901,_15903) --> 
    missingprep(_15872,_15873,_15874,_15921,_15901,_15903).

adjustprep(ask,_15873,regarding,[adjustprep,lit(om)],_15899,_15901) --> 
    cc(om,_15899,_15901).

adjustprep(dream,_15873,regarding,[adjustprep,lit(om)],_15899,_15901) --> 
    cc(om,_15899,_15901).

adjustprep(handle2,_15873,regarding,[adjustprep,lit(om)],_15899,_15901) --> 
    cc(om,_15899,_15901).

adjustprep(know,_15873,regarding,[adjustprep,lit(om)],_15899,_15901) --> 
    cc(om,_15899,_15901).

adjustprep(know1,_15873,regarding,[adjustprep,lit(om)],_15899,_15901) --> 
    cc(om,_15899,_15901).

adjustprep(go,_15873,from,[adjustprep,_15919],_15899,_15901) --> 
    prep(after,_15919,_15899,_15901).

adjustprep(go,_15873,to,[adjustprep,_15919],_15899,_15901) --> 
    prep(of,_15919,_15899,_15901).

adjustprep(_15872,_15873,_15874,[adjustprep,_15919],_15899,_15901) --> 
    prep(_15874,_15919,_15899,_15901).

missingprep(_15872,duration,with,[missingprep,!],_15897,_15897) --> 
    !.

missingprep(pass,_15873,_15874,[missingprep,!,_15925],_15900,_15902) --> 
    !,
    reject(_15925,_15900,_15902).

missingprep(_15872,thing,_15874,[missingprep,!,_15925],_15900,_15902) --> 
    !,
    reject(_15925,_15900,_15902).

missingprep(go,direction,in,[missingprep,[]],_15897,_15897) --> 
    [].

missingprep(arrive,_15873,at,[missingprep,[]],_15897,_15897) --> 
    [].

missingprep(depart,_15873,from,[missingprep,[]],_15897,_15897) --> 
    [].

missingprep(go,direction,in,[missingprep,[]],_15897,_15897) --> 
    [].

missingprep(go,_15873,at,[missingprep,[]],_15897,_15897) --> 
    [].

missingprep(start,_15873,at,[missingprep,[]],_15897,_15897) --> 
    [].

missingprep(stop,_15873,at,[missingprep,[]],_15897,_15897) --> 
    [].

prep0(from,[prep0,_15913,!,_15947],_15899,_15901) --> 
    prep(from,_15913,_15899,_15930),
    !,
    accept(_15947,_15930,_15901).

prep0(_15872,[prep0,_15915,{}],_15901,_15903) --> 
    prep(_15872,_15915,_15901,_15903),
    {user:_15872\==of}.

prep0(in,[prep0,[]],_15891,_15891) --> 
    [].

prep(_15872,[prep,lit(m),_15932,!,_15966],_15907,_15909) --> 
    cc(m,_15907,_15931),
    w(nb(_15887,_15888),_15932,_15931,_15949),
    !,
    reject(_15966,_15949,_15909).

prep(from,[prep,lit(dra),{},_15947],_15912,_15914) --> 
    cc(dra,_15912,_15936),
    {user:value(smsflag,true)},
    look_ahead(w(name(_15884,n,_15886)),_15947,_15936,_15914).

prep(_15872,[prep,_15907],_15893,_15895) --> 
    prep2(_15872,_15907,_15893,_15895).

prep(_15872,[prep,_15907],_15893,_15895) --> 
    prep1(_15872,_15907,_15893,_15895).

prep1(after,[prep1,lit(e),_15928,!],_15903,_15905) --> 
    cc(e,_15903,_15927),
    not_look_ahead(['.'],_15928,_15927,_15905),
    !.

prep1(_15872,[prep1,_15916,_15945],_15902,_15904) --> 
    w(prep(_15872),_15916,_15902,_15933),
    not_look_ahead([å],_15945,_15933,_15904).

prep1(to,[prep1,lit(ti),_15929],_15904,_15906) --> 
    cc(ti,_15904,_15928),
    look_ahead(w(name(_15881,_15882,_15883)),_15929,_15928,_15906).

atom(_15872,[atom,_15919,{}],_15905,_15907) --> 
    w(name(_15879,_15885,_15886),_15919,_15905,_15907),
    {user:atom_templ(_15879,_15872)}.

atomlist(_15872,[atomlist,_15921,_15950,_15979],_15907,_15909) --> 
    atom1(_15883,_15921,_15907,_15938),
    atom1(_15885,_15950,_15938,_15967),
    atoms0(_15883-_15885,_15872,_15979,_15967,_15909).

atom1(_15872,[atom1,_15919,{}],_15905,_15907) --> 
    w(name(_15872,n,_15879),_15919,_15905,_15907),
    {user:_15879\==unkn}.

atoms0(_15872,_15873,[atoms0,_15922,_15951],_15905,_15907) --> 
    atom1(_15881,_15922,_15905,_15939),
    atoms0(_15872-_15881,_15873,_15951,_15939,_15907).

atoms0(_15872,_15872,[atoms0,[]],_15894,_15894) --> 
    [].

newatom(_15872,[newatom,_15919,{}],_15905,_15907) --> 
    w(name(_15879,_15885,_15886),_15919,_15905,_15907),
    {user:atom_templ(_15879,_15872)}.

newatomid(_15872,[newatomid,_15911],_15897,_15899) --> 
    w(name(_15872,_15877,_15878),_15911,_15897,_15899).

xsubjunction(nil,coevent,instead_of,[xsubjunction,lit(fremfor)],_15899,_15901) --> 
    cc(fremfor,_15899,_15901).

xsubjunction(nil,coevent,in_order_to,[xsubjunction,_15917],_15897,_15899) --> 
    in_order_to(_15917,_15897,_15899).

xsubjunction(nil,coevent,without,[xsubjunction,_15917],_15897,_15899) --> 
    utenå(_15917,_15897,_15899).

xsubjunction(nil,coevent,by,[xsubjunction,lit(ved),lit(å)],_15904,_15906) --> 
    cc(ved,_15904,_15934),
    cc(å,_15934,_15906).

subjunction(before,time,in,[subjunction,_15922,_15951],_15902,_15904) --> 
    prep1(to,_15922,_15902,_15939),
    look_ahead_np(_15951,_15939,_15904).

subjunction(after,time,in,[subjunction,_15922,_15951],_15902,_15904) --> 
    prep1(after,_15922,_15902,_15939),
    that(_15951,_15939,_15904).

subjunction(after,time,in,[subjunction,_15951,_15980,_16009,_16038,!],_15931,_15933) --> 
    prep1(after,_15951,_15931,_15968),
    not_look_ahead(w(noun(clock,sin,def,n)),_15980,_15968,_15997),
    not_look_ahead(w(nb(_15903,_15904)),_16009,_15997,_16026),
    look_ahead([jeg],_16038,_16026,_15933),
    !.

subjunction(before,time,in,[subjunction,lit(før),_15952,_15981],_15921,_15923) --> 
    cc(før,_15921,_15951),
    not_look_ahead(w(nb(_15897,_15898)),_15952,_15951,_15969),
    not_look_ahead(w(noun(clock,sin,def,n)),_15981,_15969,_15923).

subjunction(before,time,in,[subjunction,lit(til),_15941],_15910,_15912) --> 
    cc(til,_15910,_15940),
    not_look_ahead(w(name(_15883,_15884,_15885)),_15941,_15940,_15912).

subjunction(not_withstanding,coevent,nil,[subjunction,_15922,lit(om)],_15902,_15904) --> 
    uansett(_15922,_15902,_15937),
    cc(om,_15937,_15904).

subjunction(not_withstanding,coevent,nil,[subjunction,lit(selvom)],_15899,_15901) --> 
    cc(selvom,_15899,_15901).

uansett([uansett,lit(uansett)],_15889,_15891) --> 
    cc(uansett,_15889,_15891).

uansett([uansett,lit(selv)],_15889,_15891) --> 
    cc(selv,_15889,_15891).

subjunction(unless,coevent,nil,[subjunction,lit(med),lit(mindre)],_15904,_15906) --> 
    cc(med,_15904,_15934),
    cc(mindre,_15934,_15906).

subjunction(nil,coevent,so_that,[subjunction,_15917],_15897,_15899) --> 
    because(_15917,_15897,_15899).

subjunction(nil,coevent,so_that,[subjunction,_15917],_15897,_15899) --> 
    if1(_15917,_15897,_15899).

subjunction(nil,coevent,despite_of,[subjunction,_15924,lit(at)],_15904,_15906) --> 
    prep1(without,_15924,_15904,_15941),
    cc(at,_15941,_15906).

subjunction(nil,coevent,instead_of,[subjunction,_15917],_15897,_15899) --> 
    instead_of(_15917,_15897,_15899).

subjunction(nil,coevent,because_of,[subjunction,lit(med),lit(at)],_15904,_15906) --> 
    cc(med,_15904,_15934),
    cc(at,_15934,_15906).

subjunction(nil,coevent,because_of,[subjunction,_15917],_15897,_15899) --> 
    so_that(_15917,_15897,_15899).

subjunction(nil,coevent,because_of,[subjunction,lit(slik)],_15899,_15901) --> 
    cc(slik,_15899,_15901).

subjunction(during,time,in,[subjunction,_15917],_15897,_15899) --> 
    while(_15917,_15897,_15899).

subjunction(in,time,in,[subjunction,lit(om),_15933],_15902,_15904) --> 
    cc(om,_15902,_15932),
    when1(_15933,_15932,_15904).

subjunction(in,time,in,[subjunction,_15917],_15897,_15899) --> 
    when1(_15917,_15897,_15899).

subjunction(in,time,in,[subjunction,lit(så),_15937],_15906,_15908) --> 
    cc(så,_15906,_15936),
    w(adv(fast),_15937,_15936,_15908).

subjunction(in,time,in,[subjunction,lit(om),lit(hvordan)],_15904,_15906) --> 
    cc(om,_15904,_15934),
    cc(hvordan,_15934,_15906).

subjunction(in,time,in,[subjunction,lit(på),lit(hvordan)],_15904,_15906) --> 
    cc(på,_15904,_15934),
    cc(hvordan,_15934,_15906).

subjunction(in,time,in,[subjunction,lit(da)],_15899,_15901) --> 
    cc(da,_15899,_15901).

subjunction(in,place,in,[subjunction,lit(der)],_15899,_15901) --> 
    cc(der,_15899,_15901).

subjunction(in,place,in,[subjunction,lit(hvor),_15940],_15909,_15911) --> 
    cc(hvor,_15909,_15939),
    not_look_ahead(w(adj2(_15883,_15884)),_15940,_15939,_15911).

subjunction(until,time,in,[subjunction,_15917],_15897,_15899) --> 
    until(_15917,_15897,_15899).

subjunction(in,time,in,[subjunction,lit(i),lit(det)],_15904,_15906) --> 
    cc(i,_15904,_15934),
    cc(det,_15934,_15906).

because([because,lit(fordi)],_15889,_15891) --> 
    cc(fordi,_15889,_15891).

because([because,lit(for),_15923,!],_15901,_15903) --> 
    cc(for,_15901,_15922),
    look_ahead_lit([da,den],_15923,_15922,_15903),
    !.

because([because,lit(siden),_15935,{},!,_15979],_15913,_15915) --> 
    cc(siden,_15913,_15934),
    w(noun(_15888,_15889,_15890,_15891),_15935,_15934,_15952),
    {user:constrain(_15888,time)},
    !,
    reject(_15979,_15952,_15915).

because([because,lit(siden)],_15889,_15891) --> 
    cc(siden,_15889,_15891).

erdetdet([erdetdet,_15909,lit(det),_15944,_15968],_15898,_15900) --> 
    be(_15909,_15898,_15924),
    cc(det,_15924,_15943),
    that0(_15944,_15943,_15959),
    det0(_15968,_15959,_15900).

be_it_tf_that(_15872,[be_it_tf_that,_15936,lit(det),_15976,lit(ut),lit(til),lit(at)],_15922,_15924) --> 
    w(verb(see,_15894,fin),_15936,_15922,_15953),
    cc(det,_15953,_15975),
    negation0(_15872,_15976,_15975,_15993),
    cc(ut,_15993,_16015),
    cc(til,_16015,_16026),
    cc(at,_16026,_15924).

omaa([omaa,lit(om),lit(å),!],_15897,_15899) --> 
    cc(om,_15897,_15918),
    cc(å,_15918,_15899),
    !.

omaa([omaa,lit(å),!],_15892,_15894) --> 
    cc(å,_15892,_15894),
    !.

gadd([gadd,lit(vil)],_15889,_15891) --> 
    cc(vil,_15889,_15891).

hvormye([hvormye,lit(hvor),lit(mye)],_15894,_15896) --> 
    cc(hvor,_15894,_15915),
    cc(mye,_15915,_15896).

hvormye([hvormye,lit(hvor),lit(mange)],_15894,_15896) --> 
    cc(hvor,_15894,_15915),
    cc(mange,_15915,_15896).

hvormye([hvormye,lit(hvor),lit(meget)],_15894,_15896) --> 
    cc(hvor,_15894,_15915),
    cc(meget,_15915,_15896).

hvormye([hvormye,lit(hva)],_15889,_15891) --> 
    cc(hva,_15889,_15891).

whatcan([whatcan,lit(hva),lit(kan)],_15894,_15896) --> 
    cc(hva,_15894,_15915),
    cc(kan,_15915,_15896).

whatcan([whatcan,lit(hva),_15914],_15892,_15894) --> 
    cc(hva,_15892,_15913),
    aux1(_15914,_15913,_15894).

ompa([ompa,lit(om)],_15889,_15891) --> 
    cc(om,_15889,_15891).

ompa([ompa,_15902],_15891,_15893) --> 
    w(prep(on),_15902,_15891,_15893).

ompa([ompa,_15902],_15891,_15893) --> 
    w(prep(for),_15902,_15891,_15893).

hver0([hver0,lit(hvert),!],_15892,_15894) --> 
    cc(hvert,_15892,_15894),
    !.

hver0([hver0,lit(hver),!],_15892,_15894) --> 
    cc(hver,_15892,_15894),
    !.

hver0([hver0,[]],_15887,_15887) --> 
    [].

detå([detå,lit(det),_15917,!],_15895,_15897) --> 
    cc(det,_15895,_15916),
    infinitive(_15917,_15916,_15897),
    !.

detå([detå,lit(det),lit(og),!],_15897,_15899) --> 
    cc(det,_15897,_15918),
    cc(og,_15918,_15899),
    !.

detå([detå,lit(det),lit(for),_15933,!],_15900,_15902) --> 
    cc(det,_15900,_15921),
    cc(for,_15921,_15932),
    infinitive(_15933,_15932,_15902),
    !.

detå([detå,lit(det),lit(for),lit(og),!],_15902,_15904) --> 
    cc(det,_15902,_15923),
    cc(for,_15923,_15934),
    cc(og,_15934,_15904),
    !.

numberroute([numberroute,_15904,_15928,!],_15893,_15895) --> 
    optionalbus(_15904,_15893,_15919),
    num1(_15928,_15919,_15895),
    !.

numberroute([numberroute,_15901,!],_15890,_15892) --> 
    bus1(_15901,_15890,_15892),
    !.

optionalbus([optionalbus,_15905,_15929],_15894,_15896) --> 
    bus1(_15905,_15894,_15920),
    optional([nr],_15929,_15920,_15896).

optionalbus([optionalbus,_15898],_15887,_15889) --> 
    num1(_15898,_15887,_15889).

optionalbus([optionalbus,[]],_15887,_15887) --> 
    [].

num1([num1,_15911,_15940,!],_15900,_15902) --> 
    w(noun(number,sin,_15882,n),_15911,_15900,_15928),
    point0(_15940,_15928,_15902),
    !.

num1([num1,lit(nr),_15917,!],_15895,_15897) --> 
    cc(nr,_15895,_15916),
    point0(_15917,_15916,_15897),
    !.

bus1([bus1,_15905],_15894,_15896) --> 
    w(noun(route,sin,_15876,_15877),_15905,_15894,_15896).

bus1([bus1,_15905],_15894,_15896) --> 
    w(noun(bus,sin,_15876,_15877),_15905,_15894,_15896).

commas0([commas0,_15904,!,_15933],_15893,_15895) --> 
    comma(_15904,_15893,_15919),
    !,
    commas0(_15933,_15919,_15895).

commas0([commas0,[]],_15887,_15887) --> 
    [].

comma0([comma0,lit(','),!],_15892,_15894) --> 
    cc(',',_15892,_15894),
    !.

comma0([comma0,[]],_15887,_15887) --> 
    [].

comma([comma,lit(',')],_15889,_15891) --> 
    cc(',',_15889,_15891).

streetno([streetno,_15904,!,_15933],_15893,_15895) --> 
    a(_15904,_15893,_15919),
    !,
    reject(_15933,_15919,_15895).

streetno([streetno,lit(veg)],_15889,_15891) --> 
    cc(veg,_15889,_15891).

streetno([streetno,_15911,{}],_15900,_15902) --> 
    w(nb(_15877,num),_15911,_15900,_15902),
    {user:_15877<500}.

tilsiden([tilsiden,_15900],_15889,_15891) --> 
    prep1(to,_15900,_15889,_15891).

tilsiden([tilsiden,_15900],_15889,_15891) --> 
    prep1(before,_15900,_15889,_15891).

tilsiden([tilsiden,lit(siden)],_15889,_15891) --> 
    cc(siden,_15889,_15891).

hva([hva,lit(hva),!,_15922],_15895,_15897) --> 
    cc(hva,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

hva([hva,lit(hvor),_15920,!,_15949],_15898,_15900) --> 
    cc(hvor,_15898,_15919),
    meny(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

addressat0([addressat0,_15910,!,_15944],_15899,_15901) --> 
    w(name(tuc,n,_15882),_15910,_15899,_15927),
    !,
    accept(_15944,_15927,_15901).

addressat0([addressat0,_15910,!,_15944],_15899,_15901) --> 
    w(name(busstuc,n,_15882),_15910,_15899,_15927),
    !,
    accept(_15944,_15927,_15901).

addressat0([addressat0,_15910,!,_15944],_15899,_15901) --> 
    w(name(bustuc,n,_15882),_15910,_15899,_15927),
    !,
    accept(_15944,_15927,_15901).

addressat0([addressat0,_15910,!,_15944],_15899,_15901) --> 
    w(name(hal,n,_15882),_15910,_15899,_15927),
    !,
    accept(_15944,_15927,_15901).

addressat0([addressat0,[]],_15887,_15887) --> 
    [].

enn([enn,lit(enn)],_15889,_15891) --> 
    cc(enn,_15889,_15891).

enn([enn,lit(en)],_15889,_15891) --> 
    cc(en,_15889,_15891).

hatt0([hatt0,_15907,!],_15896,_15898) --> 
    w(verb(have,past,part),_15907,_15896,_15898),
    !.

hatt0([hatt0,[]],_15887,_15887) --> 
    [].

out0([out0,lit(ut),!,_15922],_15895,_15897) --> 
    cc(ut,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

out0([out0,lit(opp),!,_15922],_15895,_15897) --> 
    cc(opp,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

out0([out0,[]],_15887,_15887) --> 
    [].

a0([a0,_15898],_15887,_15889) --> 
    a(_15898,_15887,_15889).

a0([a0,[]],_15887,_15887) --> 
    [].

a([a,lit(ett),_15923],_15901,_15903) --> 
    cc(ett,_15901,_15922),
    not_look_ahead(w(noun(time,_15880,def,_15882)),_15923,_15922,_15903).

a([a,lit(noen),lit(av),!],_15897,_15899) --> 
    cc(noen,_15897,_15918),
    cc(av,_15918,_15899),
    !.

a([a,lit(noen),_15928,_15957,_15986],_15906,_15908) --> 
    cc(noen,_15906,_15927),
    not_look_ahead([av],_15928,_15927,_15945),
    not_look_ahead([de],_15957,_15945,_15974),
    look_ahead_np(_15986,_15974,_15908).

a([a,lit(noe),_15921,_15950],_15899,_15901) --> 
    cc(noe,_15899,_15920),
    not_look_ahead([de],_15921,_15920,_15938),
    look_ahead_np(_15950,_15938,_15901).

a([a,_15905,_15929],_15894,_15896) --> 
    art1(_15905,_15894,_15920),
    optional([slik],_15929,_15920,_15896).

art([art,_15898],_15887,_15889) --> 
    a(_15898,_15887,_15889).

art([art,_15906,lit(eller),_15941],_15895,_15897) --> 
    a(_15906,_15895,_15921),
    cc(eller,_15921,_15940),
    more(_15941,_15940,_15897).

art([art,lit(de)],_15889,_15891) --> 
    cc(de,_15889,_15891).

art([art,lit(all)],_15889,_15891) --> 
    cc(all,_15889,_15891).

art([art,_15911,lit(alt)],_15900,_15902) --> 
    not_look_ahead(w(name(_15881,_15882,_15883)),_15911,_15900,_15928),
    cc(alt,_15928,_15902).

art([art,_15908,{}],_15897,_15899) --> 
    every(_15908,_15897,_15899),
    {user:(\+value(textflag,true))}.

art1([art1,lit(en)],_15889,_15891) --> 
    cc(en,_15889,_15891).

art1([art1,lit(et)],_15889,_15891) --> 
    cc(et,_15889,_15891).

art1([art1,lit(ei)],_15889,_15891) --> 
    cc(ei,_15889,_15891).

allsome0([allsome0,lit(noen),lit(av)],_15894,_15896) --> 
    cc(noen,_15894,_15915),
    cc(av,_15915,_15896).

allsome0([allsome0,_15901,!],_15890,_15892) --> 
    all(_15901,_15890,_15892),
    !.

allsome0([allsome0,[]],_15887,_15887) --> 
    [].

all0([all0,_15901,!],_15890,_15892) --> 
    all(_15901,_15890,_15892),
    !.

all0([all0,[]],_15887,_15887) --> 
    [].

all([all,_15898],_15887,_15889) --> 
    every(_15898,_15887,_15889).

always([always,lit(alltid)],_15889,_15891) --> 
    cc(alltid,_15889,_15891).

always([always,_15913,_15942],_15902,_15904) --> 
    w(adj2(whole,nil),_15913,_15902,_15930),
    w(noun(time,sin,def,n),_15942,_15930,_15904).

and0([and0,_15904,!,_15933],_15893,_15895) --> 
    and1(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

and0([and0,[]],_15887,_15887) --> 
    [].

andor0([andor0,_15904,!,_15933],_15893,_15895) --> 
    andor(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

andor0([andor0,[]],_15887,_15887) --> 
    [].

andor([andor,lit(og),!],_15892,_15894) --> 
    cc(og,_15892,_15894),
    !.

andor([andor,lit(eller),!],_15892,_15894) --> 
    cc(eller,_15892,_15894),
    !.

betwand0([betwand0,lit(å),!],_15892,_15894) --> 
    cc(å,_15892,_15894),
    !.

betwand0([betwand0,lit(og),!],_15892,_15894) --> 
    cc(og,_15892,_15894),
    !.

betwand0([betwand0,_15905,!],_15894,_15896) --> 
    w(prep(to),_15905,_15894,_15896),
    !.

betwand0([betwand0,[]],_15887,_15887) --> 
    [].

and1([and1,lit(og)],_15889,_15891) --> 
    cc(og,_15889,_15891).

and1([and1,lit(men),_15920],_15898,_15900) --> 
    cc(men,_15898,_15919),
    look_ahead_lit([en,et],_15920,_15919,_15900).

vmod_conjunction([vmod_conjunction,lit(mao)],_15889,_15891) --> 
    cc(mao,_15889,_15891).

vmod_conjunction([vmod_conjunction,lit(men),_15920],_15898,_15900) --> 
    cc(men,_15898,_15919),
    not_look_ahead_lit([med,nå],_15920,_15919,_15900).

vmod_conjunction([vmod_conjunction,_15960,_15989,_16033,_16062,_16091,_16120,_16149],_15949,_15951) --> 
    one_of_lit([og,eller],_15960,_15949,_15977),
    optional([så],_15989,_15977,_16021),
    not_look_ahead_lit([da,så,nå],_16033,_16021,_16050),
    not_look_ahead(w(prep(in)),_16062,_16050,_16079),
    not_look_ahead(w([ikveld]),_16091,_16079,_16108),
    not_look_ahead(w([imorgen]),_16120,_16108,_16137),
    not_look_ahead(w(name(_15894,_15895,_15896)),_16149,_16137,_15951).

andwhen0([andwhen0,_15907,_15931,!,_15960],_15896,_15898) --> 
    and1(_15907,_15896,_15922),
    when(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

andwhen0([andwhen0,[]],_15887,_15887) --> 
    [].

andwhere0([andwhere0,_15912,_15936,_15965,!,_15994],_15901,_15903) --> 
    and1(_15912,_15901,_15927),
    prep1(from,_15936,_15927,_15953),
    where(_15965,_15953,_15980),
    !,
    accept(_15994,_15980,_15903).

andwhere0([andwhere0,_15907,_15931,!,_15960],_15896,_15898) --> 
    and1(_15907,_15896,_15922),
    where(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

andwhere0([andwhere0,_15909,lit(hvorfra),!,_15949],_15898,_15900) --> 
    and1(_15909,_15898,_15924),
    cc(hvorfra,_15924,_15943),
    !,
    accept(_15949,_15943,_15900).

andwhere0([andwhere0,[]],_15887,_15887) --> 
    [].

np_conjunction(_15872,[np_conjunction,_15921,lit(det),_15961,!,_15990],_15907,_15909) --> 
    andor(_15886,_15921,_15907,_15938),
    cc(det,_15938,_15960),
    look_ahead_vp(_15961,_15960,_15976),
    !,
    reject(_15990,_15976,_15909).

np_conjunction(_15872,[np_conjunction,_15932,_15961,_15990,_16019],_15918,_15920) --> 
    andor(_15872,_15932,_15918,_15949),
    not_look_ahead_lit([da,så],_15961,_15949,_15978),
    not_look_ahead(w(prep(_15899)),_15990,_15978,_16007),
    not_look_ahead(['.'],_16019,_16007,_15920).

andor0(_15872,[andor0,_15907],_15893,_15895) --> 
    andor(_15872,_15907,_15893,_15895).

andor0(and,[andor0,{}],_15899,_15899) --> 
    {user:value(textflag,true)}.

andor(and,[andor,_15931,_15955,_15984],_15917,_15919) --> 
    and1(_15931,_15917,_15946),
    not_look_ahead(['.'],_15955,_15946,_15972),
    not_look_ahead_lit([jeg,mange,ikke,ingen,noen,disse,dette],_15984,_15972,_15919).

andor(or,[andor,lit(eller),_15929],_15904,_15906) --> 
    cc(eller,_15904,_15928),
    not_look_ahead(w(verb(_15881,_15882,_15883)),_15929,_15928,_15906).

andor(and,[andor,{},_15932,!,_15961],_15908,_15910) --> 
    {user:value(teleflag,true)},
    art(_15932,_15908,_15947),
    !,
    reject(_15961,_15947,_15910).

andor(and,[andor,{}],_15899,_15899) --> 
    {user:value(teleflag,true)}.

also0([also0,lit(også),lit(samtidig),!],_15897,_15899) --> 
    cc(også,_15897,_15918),
    cc(samtidig,_15918,_15899),
    !.

also0([also0,lit(samtidig),lit(også),!],_15897,_15899) --> 
    cc(samtidig,_15897,_15918),
    cc(også,_15918,_15899),
    !.

also0([also0,lit(også),!],_15892,_15894) --> 
    cc(også,_15892,_15894),
    !.

also0([also0,lit(samtidig),!],_15892,_15894) --> 
    cc(samtidig,_15892,_15894),
    !.

also0([also0,lit(deretter),!],_15892,_15894) --> 
    cc(deretter,_15892,_15894),
    !.

also0([also0,[]],_15887,_15887) --> 
    [].

anaa([anaa,_15904,_15928,!],_15893,_15895) --> 
    ann0(_15904,_15893,_15919),
    ogaa(_15928,_15919,_15895),
    !.

ogaa([ogaa,lit(å)],_15889,_15891) --> 
    cc(å,_15889,_15891).

ogaa([ogaa,lit(og)],_15889,_15891) --> 
    cc(og,_15889,_15891).

ann0([ann0,lit(an),!,_15922],_15895,_15897) --> 
    cc(an,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

ann0([ann0,[]],_15887,_15887) --> 
    [].

anorder(a,_15873,[anorder,_15919,_15943],_15902,_15904) --> 
    a(_15919,_15902,_15934),
    w(nb(_15873,ord),_15943,_15934,_15904).

anorder(the,_15873,[anorder,_15919,_15943],_15902,_15904) --> 
    the(_15919,_15902,_15934),
    w(nb(_15873,ord),_15943,_15934,_15904).

another([another,_15901,_15925],_15890,_15892) --> 
    a(_15901,_15890,_15916),
    other(_15925,_15916,_15892).

around0([around0,_15898],_15887,_15889) --> 
    around1(_15898,_15887,_15889).

around0([around0,[]],_15887,_15887) --> 
    [].

around1([around1,_15898],_15887,_15889) --> 
    ca(_15898,_15887,_15889).

around1([around1,lit(om),lit(lag)],_15894,_15896) --> 
    cc(om,_15894,_15915),
    cc(lag,_15915,_15896).

around1([around1,_15900],_15889,_15891) --> 
    prep1(around,_15900,_15889,_15891).

as([as,lit(som)],_15889,_15891) --> 
    cc(som,_15889,_15891).

as0([as0,_15898],_15887,_15889) --> 
    as(_15898,_15887,_15889).

as0([as0,[]],_15887,_15887) --> 
    [].

andsoon([andsoon,lit(og),_15914],_15892,_15894) --> 
    cc(og,_15892,_15913),
    sovidere0(_15914,_15913,_15894).

sovidere0([sovidere0,_15901,_15925],_15890,_15892) --> 
    sov0(_15901,_15890,_15916),
    videre0(_15925,_15916,_15892).

sov0([sov0,lit(så)],_15889,_15891) --> 
    cc(så,_15889,_15891).

sov0([sov0,[]],_15887,_15887) --> 
    [].

videre0([videre0,lit(videre)],_15889,_15891) --> 
    cc(videre,_15889,_15891).

videre0([videre0,[]],_15887,_15887) --> 
    [].

aspossible0([aspossible0,_15904,!,_15933],_15893,_15895) --> 
    aspossible(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

aspossible0([aspossible0,_15898],_15887,_15889) --> 
    possible0(_15898,_15887,_15889).

aspossible([aspossible,_15906,_15930],_15895,_15897) --> 
    as(_15906,_15895,_15921),
    w(adj2(possible,nil),_15930,_15921,_15897).

aso0([aso0,lit(så),!,_15922],_15895,_15897) --> 
    cc(så,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

aso0([aso0,_15904,!,_15933],_15893,_15895) --> 
    too(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

aso0([aso0,_15898],_15887,_15889) --> 
    as(_15898,_15887,_15889).

aso0([aso0,[]],_15887,_15887) --> 
    [].

at([at,_15900],_15889,_15891) --> 
    prep(at,_15900,_15889,_15891).

athe([athe,_15898],_15887,_15889) --> 
    the(_15898,_15887,_15889).

athe([athe,_15898],_15887,_15889) --> 
    a(_15898,_15887,_15889).

athe0([athe0,_15901,!],_15890,_15892) --> 
    athe(_15901,_15890,_15892),
    !.

athe0([athe0,[]],_15887,_15887) --> 
    [].

blei(_15872,[blei,_15930,_15959,_15988,!],_15916,_15918) --> 
    w(verb(stand,pres,fin),_15930,_15916,_15947),
    negation0(_15872,_15959,_15947,_15976),
    look_ahead(w(verb(_15895,past,part)),_15988,_15976,_15918),
    !.

blei(_15872,[blei,_15910,_15934],_15896,_15898) --> 
    blei(_15910,_15896,_15925),
    negation0(_15872,_15934,_15925,_15898).

blei([blei,_15918,_15947,!],_15907,_15909) --> 
    w(verb(stand,pres,fin),_15918,_15907,_15935),
    look_ahead(w(verb(_15888,past,part)),_15947,_15935,_15909),
    !.

blei([blei,_15907,!],_15896,_15898) --> 
    w(verb(be,_15878,fin),_15907,_15896,_15898),
    !.

blei([blei,_15913,_15937,_15961,!],_15902,_15904) --> 
    has(_15913,_15902,_15928),
    redundant0(_15937,_15928,_15952),
    w(verb(be,past,part),_15961,_15952,_15904),
    !.

blei([blei,_15910,_15934,!],_15899,_15901) --> 
    aux1(_15910,_15899,_15925),
    w(verb(be,past,part),_15934,_15925,_15901),
    !.

blei([blei,_15910,_15934,!],_15899,_15901) --> 
    aux1(_15910,_15899,_15925),
    w(verb(be,inf,fin),_15934,_15925,_15901),
    !.

aux0(_15872,_15873,[aux0,_15917,!],_15900,_15902) --> 
    aux1(_15872,_15873,_15917,_15900,_15902),
    !.

aux0(id,pres,[aux0,_15911],_15894,_15896) --> 
    aux0(_15911,_15894,_15896).

auxs0(_15872,_15873,[auxs0,_15917,!],_15900,_15902) --> 
    aux1(_15872,_15873,_15917,_15900,_15902),
    !.

auxs0(_15872,_15873,[auxs0,[]],_15894,_15894) --> 
    [].

auxs([auxs,_15901,_15925],_15890,_15892) --> 
    aux1(_15901,_15890,_15916),
    auxs0(_15925,_15916,_15892).

auxs0([auxs0,_15904,!,_15933],_15893,_15895) --> 
    aux1(_15904,_15893,_15919),
    !,
    auxs0(_15933,_15919,_15895).

auxs0([auxs0,[]],_15887,_15887) --> 
    [].

aux1(_15872,pres,[aux1,lit(kan),_15946,_15970,_15999,!],_15918,_15920) --> 
    cc(kan,_15918,_15945),
    redundant0(_15946,_15945,_15961),
    negation0(_15872,_15970,_15961,_15987),
    look_ahead(w(verb(_15895,_15896,_15897)),_15999,_15987,_15920),
    !.

aux1(_15872,past,[aux1,lit(kunne),_15943,_15972,!],_15915,_15917) --> 
    cc(kunne,_15915,_15942),
    negation0(_15872,_15943,_15942,_15960),
    look_ahead(w(verb(_15892,_15893,_15894)),_15972,_15960,_15917),
    !.

aux1(_15872,past,[aux1,lit(burde),_15932,!],_15904,_15906) --> 
    cc(burde,_15904,_15931),
    negation0(_15872,_15932,_15931,_15906),
    !.

aux1(_15872,past,[aux1,lit(kunne),_15932,!],_15904,_15906) --> 
    cc(kunne,_15904,_15931),
    negation0(_15872,_15932,_15931,_15906),
    !.

aux1(_15872,pres,[aux1,_15916,_15940],_15899,_15901) --> 
    aux1(_15916,_15899,_15931),
    negation0(_15872,_15940,_15931,_15901).

skalsaa([skalsaa,_15901,_15925],_15890,_15892) --> 
    aux1(_15901,_15890,_15916),
    so0(_15925,_15916,_15892).

faux1([faux1,_15907,!],_15896,_15898) --> 
    w(verb(get,_15878,fin),_15907,_15896,_15898),
    !.

faux1([faux1,_15898],_15887,_15889) --> 
    aux1(_15898,_15887,_15889).

aux1([aux1,_15929,_15958,_15987,!],_15918,_15920) --> 
    one_of_lit([kan,kunne,får,fikk],_15929,_15918,_15946),
    not_look_ahead([nå],_15958,_15946,_15975),
    look_ahead(w(verb(_15899,inf,_15901)),_15987,_15975,_15920),
    !.

aux1([aux1,_15904],_15893,_15895) --> 
    one_of_lit([kan,kunne],_15904,_15893,_15895).

aux1([aux1,_15916],_15905,_15907) --> 
    one_of_lit([bør,burde,må,måtte,skal,skulle,vil,ville],_15916,_15905,_15907).

aux10([aux10,_15901,!],_15890,_15892) --> 
    aux1(_15901,_15890,_15892),
    !.

aux10([aux10,[]],_15887,_15887) --> 
    [].

aux0([aux0,_15912,_15936,!],_15901,_15903) --> 
    faa(_15912,_15901,_15927),
    look_ahead(w(verb(_15882,_15883,_15884)),_15936,_15927,_15903),
    !.

aux0([aux0,lit(må)],_15889,_15891) --> 
    cc(må,_15889,_15891).

aux0([aux0,_15922,lit(så),_15957,lit(å),!,_16002],_15911,_15913) --> 
    be(_15922,_15911,_15937),
    cc(så,_15937,_15956),
    w(adj2(good,nil),_15957,_15956,_15974),
    cc(å,_15974,_15996),
    !,
    accept(_16002,_15996,_15913).

aux0([aux0,_15898],_15887,_15889) --> 
    do(_15898,_15887,_15889).

aux0([aux0,[]],_15887,_15887) --> 
    [].

paux0([paux0,_15906,lit(blitt),!],_15895,_15897) --> 
    has(_15906,_15895,_15921),
    cc(blitt,_15921,_15897),
    !.

paux0([paux0,lit(vil),lit(bli),!],_15897,_15899) --> 
    cc(vil,_15897,_15918),
    cc(bli,_15918,_15899),
    !.

paux0([paux0,lit(_15877),{},!],_15920,_15922) --> 
    cc(_15877,_15920,_15922),
    {user:testmember(_15877,[skal,vil,bør,må,kan,skulle,ville,burde,måtte,kunne])},
    !.

paux0([paux0,[]],_15887,_15887) --> 
    [].

do(_15872,[do,_15913,_15937,_15966],_15899,_15901) --> 
    use(_15913,_15899,_15928),
    negation0(_15872,_15937,_15928,_15954),
    infinitive(_15966,_15954,_15901).

do(_15872,[do,_15913,_15937,_15966],_15899,_15901) --> 
    do(_15913,_15899,_15928),
    negation0(_15872,_15937,_15928,_15954),
    hasto0(_15966,_15954,_15901).

do(id,[do,[]],_15891,_15891) --> 
    [].

do0([do0,_15898],_15887,_15889) --> 
    do(_15898,_15887,_15889).

do0([do0,[]],_15887,_15887) --> 
    [].

docan([docan,lit(kan)],_15889,_15891) --> 
    cc(kan,_15889,_15891).

docan([docan,lit(må)],_15889,_15891) --> 
    cc(må,_15889,_15891).

docan([docan,lit(får)],_15889,_15891) --> 
    cc(får,_15889,_15891).

docan([docan,_15901,!],_15890,_15892) --> 
    do(_15901,_15890,_15892),
    !.

do([do,_15914,_15938,!,_15972],_15903,_15905) --> 
    faa(_15914,_15903,_15929),
    w(noun(information,_15884,_15885,_15886),_15938,_15929,_15955),
    !,
    reject(_15972,_15955,_15905).

do([do,lit(vil),lit(vil),!,_15938],_15900,_15902) --> 
    cc(vil,_15900,_15921),
    cc(vil,_15921,_15932),
    !,
    accept(_15938,_15932,_15902).

do([do,_15898],_15887,_15889) --> 
    skalsaa(_15898,_15887,_15889).

do([do,_15898],_15887,_15889) --> 
    may(_15898,_15887,_15889).

do([do,_15898],_15887,_15889) --> 
    must(_15898,_15887,_15889).

may([may,lit(kan),_15922],_15900,_15902) --> 
    cc(kan,_15900,_15921),
    look_ahead(w(verb(_15879,_15880,_15881)),_15922,_15921,_15902).

may([may,lit(får),_15922],_15900,_15902) --> 
    cc(får,_15900,_15921),
    look_ahead(w(verb(_15879,_15880,_15881)),_15922,_15921,_15902).

may([may,lit(bør)],_15889,_15891) --> 
    cc(bør,_15889,_15891).

may([may,lit(må)],_15889,_15891) --> 
    cc(må,_15889,_15891).

must([must,lit(må)],_15889,_15891) --> 
    cc(må,_15889,_15891).

must([must,lit(skal)],_15889,_15891) --> 
    cc(skal,_15889,_15891).

be(_15872,[be,_15936,_15965,_15994,!,_16023,{}],_15922,_15924) --> 
    w(verb(hold,_15898,fin),_15936,_15922,_15953),
    negation0(_15891,_15965,_15953,_15982),
    rfxpron(_15994,_15982,_16009),
    !,
    negation0(_15892,_16023,_16009,_15924),
    {user:bigno(_15891,_15892,_15872)}.

be(_15872,[be,_15913,!,_15947],_15899,_15901) --> 
    be1(_15872,_15913,_15899,_15930),
    !,
    accept(_15947,_15930,_15901).

be(not,[be,_15908,_15932],_15894,_15896) --> 
    not(_15908,_15894,_15923),
    be(_15932,_15923,_15896).

be(id,[be,_15905],_15891,_15893) --> 
    be(_15905,_15891,_15893).

be0([be0,_15900],_15889,_15891) --> 
    optional(be,_15900,_15889,_15891).

be([be,_15910,_15934,!],_15899,_15901) --> 
    aux1(_15910,_15899,_15925),
    w(verb(be,inf,fin),_15934,_15925,_15901),
    !.

be([be,_15919,_15948,_15972,!],_15908,_15910) --> 
    w(verb(have,_15884,fin),_15919,_15908,_15936),
    redundant0(_15948,_15936,_15963),
    w(verb(be,past,part),_15972,_15963,_15910),
    !.

be([be,_15907,!],_15896,_15898) --> 
    w(verb(be,_15878,part),_15907,_15896,_15898),
    !.

be([be,_15910,_15939,!],_15899,_15901) --> 
    w(verb(be,_15881,fin),_15910,_15899,_15927),
    been0(_15939,_15927,_15901),
    !.

be1(_15872,[be1,_15919,_15948,_15972],_15905,_15907) --> 
    w(verb(be,_15885,fin),_15919,_15905,_15936),
    redundant0(_15948,_15936,_15963),
    negation0(_15872,_15972,_15963,_15907).

be1(_15872,[be1,_15922,_15946,_15970,_15999],_15908,_15910) --> 
    aux1(_15922,_15908,_15937),
    redundant0(_15946,_15937,_15961),
    negation0(_15872,_15970,_15961,_15987),
    w(verb(be,inf,fin),_15999,_15987,_15910).

be1(_15872,[be1,_15928,_15957,_15981,_16015,!],_15914,_15916) --> 
    negation0(_15886,_15928,_15914,_15945),
    aux1(_15957,_15945,_15972),
    negation2(_15886,_15872,_15981,_15972,_16000),
    w(verb(be,inf,fin),_16015,_16000,_15916),
    !.

be1(_15872,[be1,_15928,_15957,_15986,!],_15914,_15916) --> 
    w(verb(have,_15886,fin),_15928,_15914,_15945),
    negation0(_15872,_15957,_15945,_15974),
    w(verb(be,past,part),_15986,_15974,_15916),
    !.

be1(_15872,[be1,_15919,_15948,_15972,_15996],_15905,_15907) --> 
    negation0(_15883,_15919,_15905,_15936),
    be(_15948,_15936,_15963),
    redundant0(_15972,_15963,_15987),
    negation2(_15883,_15872,_15996,_15987,_15907).

be1(_15872,[be1,_15921,_15950,lit(blitt)],_15907,_15909) --> 
    w(verb(have,_15885,fin),_15921,_15907,_15938),
    negation0(_15872,_15950,_15938,_15967),
    cc(blitt,_15967,_15909).

be1(id,[be1,lit(blitt)],_15893,_15895) --> 
    cc(blitt,_15893,_15895).

be1(not,[be1,_15919,_15948,_15977],_15905,_15907) --> 
    w(verb(reject,_15883,fin),_15919,_15905,_15936),
    prep(to,_15948,_15936,_15965),
    be(_15977,_15965,_15907).

be_truefalse_that(_15872,[be_truefalse_that,_15939,{},_15978,lit(ut),_16018,!],_15925,_15927) --> 
    w(verb(_15891,_15892,fin),_15939,_15925,_15956),
    {user:testmember(_15891,[look,see])},
    negation0(_15872,_15978,_15956,_15995),
    cc(ut,_15995,_16017),
    somatom0(_16018,_16017,_15927),
    !.

be_truefalse_that(_15872,[be_truefalse_that,_15939,{},_15978,lit(ut),_16018,!],_15925,_15927) --> 
    w(verb(_15891,_15892,fin),_15939,_15925,_15956),
    {user:testmember(_15891,[look,see])},
    negation0(_15872,_15978,_15956,_15995),
    cc(ut,_15995,_16017),
    somatom0(_16018,_16017,_15927),
    !.

be_truefalse_that(_15872,[be_truefalse_that,_15934,{},_15973,_16002,!],_15920,_15922) --> 
    w(verb(_15888,_15889,fin),_15934,_15920,_15951),
    {user:testmember(_15888,[appear,be])},
    negation0(_15872,_15973,_15951,_15990),
    somatom0(_16002,_15990,_15922),
    !.

somatom0([somatom0,_15901,!],_15890,_15892) --> 
    somatom(_15901,_15890,_15892),
    !.

somatom0([somatom0,[]],_15887,_15887) --> 
    [].

somatom([somatom,_15911,lit(at),!],_15900,_15902) --> 
    w(adj2(true,nil),_15911,_15900,_15928),
    cc(at,_15928,_15902),
    !.

somatom([somatom,lit(som),lit(at),!],_15897,_15899) --> 
    cc(som,_15897,_15918),
    cc(at,_15918,_15899),
    !.

somatom([somatom,lit(som),lit(om),!],_15897,_15899) --> 
    cc(som,_15897,_15918),
    cc(om,_15918,_15899),
    !.

somatom([somatom,lit(som)],_15889,_15891) --> 
    cc(som,_15889,_15891).

somatom([somatom,lit(at)],_15889,_15891) --> 
    cc(at,_15889,_15891).

somatom([somatom,lit(til),lit(at),!],_15897,_15899) --> 
    cc(til,_15897,_15918),
    cc(at,_15918,_15899),
    !.

somatom([somatom,lit(til)],_15889,_15891) --> 
    cc(til,_15889,_15891).

be_truefalse_that(_15872,[be_truefalse_that,_15936,_15965,_15999,_16028,!],_15922,_15924) --> 
    w(verb(_15888,_15889,fin),_15936,_15922,_15953),
    gmem(_15888,[agree,appear],_15965,_15953,_15984),
    negation0(_15872,_15999,_15984,_16016),
    optional([at],_16028,_16016,_15924),
    !.

be_truefalse_that(_15872,[be_truefalse_that,_15926,_15955,_15984,!],_15912,_15914) --> 
    negation0(_15872,_15926,_15912,_15943),
    one_of_lit([så,slik],_15955,_15943,_15972),
    optional([at],_15984,_15972,_15914),
    !.

be_truefalse_that(id,[be_truefalse_that,_15926,_15955,lit(at),!],_15912,_15914) --> 
    w(verb(show,_15886,fin),_15926,_15912,_15943),
    optional([seg],_15955,_15943,_15987),
    cc(at,_15987,_15914),
    !.

be_truefalse_that(_15872,[be_truefalse_that,_15939,{},_15978,lit(ut),_16018,!],_15925,_15927) --> 
    w(verb(_15891,_15892,fin),_15939,_15925,_15956),
    {user:testmember(_15891,[see,look])},
    negation0(_15872,_15978,_15956,_15995),
    cc(ut,_15995,_16017),
    somatom(_16018,_16017,_15927),
    !.

be_truefalse_that(_15872,[be_truefalse_that,_15934,{},_15973,_16002,!],_15920,_15922) --> 
    w(verb(_15888,_15889,fin),_15934,_15920,_15951),
    {user:testmember(_15888,[be,appear])},
    negation0(_15872,_15973,_15951,_15990),
    somatom(_16002,_15990,_15922),
    !.

be_truefalse_that(_15872,[be_truefalse_that,_15917,_15946,!],_15903,_15905) --> 
    be_truefalse(_15872,_15917,_15903,_15934),
    optional([at],_15946,_15934,_15905),
    !.

be_truefalse(_15872,[be_truefalse,_15934,{},_15973,_16002,!],_15920,_15922) --> 
    w(verb(_15888,_15889,fin),_15934,_15920,_15951),
    {user:testmember(_15888,[be,appear])},
    negation0(_15872,_15973,_15951,_15990),
    somatom(_16002,_15990,_15922),
    !.

be_truefalse(_15872,[be_truefalse,_15926,_15975,!],_15912,_15914) --> 
    lexvaccept(rv,_15881,_15882,fin,_15872,_15926,_15912,_15951),
    gmem(_15881,[stand,mean2,indicate],_15975,_15951,_15914),
    !.

be_truefalse(_15872,[be_truefalse,_15941,{},_15980,lit(ut),lit(til),!],_15927,_15929) --> 
    w(verb(_15891,_15892,fin),_15941,_15927,_15958),
    {user:testmember(_15891,[see,look])},
    negation0(_15872,_15980,_15958,_15997),
    cc(ut,_15997,_16019),
    cc(til,_16019,_15929),
    !.

be_truefalse(_15872,[be_truefalse,_15941,{},_15980,lit(ut),lit(for),!],_15927,_15929) --> 
    w(verb(_15891,_15892,fin),_15941,_15927,_15958),
    {user:testmember(_15891,[see,look])},
    negation0(_15872,_15980,_15958,_15997),
    cc(ut,_15997,_16019),
    cc(for,_16019,_15929),
    !.

be_truefalse(_15872,[be_truefalse,_15941,{},_15980,lit(ut),lit(som),!],_15927,_15929) --> 
    w(verb(_15891,_15892,fin),_15941,_15927,_15958),
    {user:testmember(_15891,[see,look])},
    negation0(_15872,_15980,_15958,_15997),
    cc(ut,_15997,_16019),
    cc(som,_16019,_15929),
    !.

be_truefalse(_15872,[be_truefalse,_15919,!,_15953],_15905,_15907) --> 
    w(verb(agree,_15885,fin),_15919,_15905,_15936),
    !,
    negation0(_15872,_15953,_15936,_15907).

be_truefalse(_15872,[be_truefalse,_15910,_15934],_15896,_15898) --> 
    be(_15910,_15896,_15925),
    truefalse(_15872,_15934,_15925,_15898).

be_truefalse(not,[be_truefalse,_15920,_15949,_15973,_15997],_15906,_15908) --> 
    w(verb(reject,_15886,fin),_15920,_15906,_15937),
    infinitive(_15949,_15937,_15964),
    be(_15973,_15964,_15988),
    true(_15997,_15988,_15908).

been0([been0,_15904,!,_15933],_15893,_15895) --> 
    been(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

been0([been0,[]],_15887,_15887) --> 
    [].

been([been,_15904],_15893,_15895) --> 
    w(verb(be,past,part),_15904,_15893,_15895).

betake([betake,_15898],_15887,_15889) --> 
    be(_15898,_15887,_15889).

betake([betake,_15904],_15893,_15895) --> 
    w(verb(take,_15875,fin),_15904,_15893,_15895).

both0([both0,lit(både)],_15889,_15891) --> 
    cc(både,_15889,_15891).

both0([both0,[]],_15887,_15887) --> 
    [].

by([by,lit(av),_15918],_15896,_15898) --> 
    cc(av,_15896,_15917),
    not_look_ahead([hensyn],_15918,_15917,_15898).

ca0([ca0,_15904,!,_15933],_15893,_15895) --> 
    ca(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

ca0([ca0,[]],_15887,_15887) --> 
    [].

ca([ca,_15909,_15938,!,_15967],_15898,_15900) --> 
    prep1(around,_15909,_15898,_15926),
    point0(_15938,_15926,_15953),
    !,
    accept(_15967,_15953,_15900).

clock0([clock0,_15898],_15887,_15889) --> 
    clock(_15898,_15887,_15889).

clock0([clock0,[]],_15887,_15887) --> 
    [].

clock([clock,lit(k),_15924,!],_15902,_15904) --> 
    cc(k,_15902,_15923),
    look_ahead(w(nb(_15884,_15885)),_15924,_15923,_15904),
    !.

clock([clock,lit(k),_15927,_15951,!],_15905,_15907) --> 
    cc(k,_15905,_15926),
    point(_15927,_15926,_15942),
    look_ahead(w(nb(_15887,_15888)),_15951,_15942,_15907),
    !.

clock([clock,lit(kl),_15917,!],_15895,_15897) --> 
    cc(kl,_15895,_15916),
    colon(_15917,_15916,_15897),
    !.

clock([clock,_15907,_15931,_15955,_15979],_15896,_15898) --> 
    point0(_15907,_15896,_15922),
    klokken(_15931,_15922,_15946),
    point0(_15955,_15946,_15970),
    ca0(_15979,_15970,_15898).

clock([clock,_15904,_15928,_15952],_15893,_15895) --> 
    point0(_15904,_15893,_15919),
    klokken(_15928,_15919,_15943),
    colon0(_15952,_15943,_15895).

klokken([klokken,lit(kl)],_15889,_15891) --> 
    cc(kl,_15889,_15891).

klokken([klokken,_15905],_15894,_15896) --> 
    w(noun(clock,sin,_15876,n),_15905,_15894,_15896).

colon0([colon0,_15904,!,_15933],_15893,_15895) --> 
    colon(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

colon0([colon0,_15902],_15891,_15893) --> 
    not_look_ahead(['.'],_15902,_15891,_15893).

colon([colon,lit(:)],_15889,_15891) --> 
    cc(:,_15889,_15891).

colon([colon,lit(;)],_15889,_15891) --> 
    cc(;,_15889,_15891).

comparator1(_15872,[comparator1,_15910,!],_15896,_15898) --> 
    comparel(_15872,_15910,_15896,_15898),
    !.

comparel(eq,[comparel,_15908,_15932],_15894,_15896) --> 
    equal(_15908,_15894,_15923),
    tomed0(_15932,_15923,_15896).

comparel(ge,[comparel,_15917,_15941,_15965,_15989,_16013],_15903,_15905) --> 
    greater(_15917,_15903,_15932),
    than0(_15941,_15932,_15956),
    or1(_15965,_15956,_15980),
    equal(_15989,_15980,_16004),
    to0(_16013,_16004,_15905).

comparel(ge,[comparel,_15911,_15935,_15959],_15897,_15899) --> 
    not(_15911,_15897,_15926),
    less(_15935,_15926,_15950),
    than(_15959,_15950,_15899).

comparel(ge,[comparel,lit(minst)],_15893,_15895) --> 
    cc(minst,_15893,_15895).

comparel(gt,[comparel,_15908,_15932],_15894,_15896) --> 
    greater(_15908,_15894,_15923),
    than(_15932,_15923,_15896).

comparel(gt,[comparel,lit(mer),_15921],_15896,_15898) --> 
    cc(mer,_15896,_15920),
    than(_15921,_15920,_15898).

comparel(gt,[comparel,_15907],_15893,_15895) --> 
    prep1(over,_15907,_15893,_15895).

comparel(le,[comparel,_15917,_15941,_15965,_15989,_16013],_15903,_15905) --> 
    less(_15917,_15903,_15932),
    than0(_15941,_15932,_15956),
    or1(_15965,_15956,_15980),
    equal(_15989,_15980,_16004),
    to0(_16013,_16004,_15905).

comparel(le,[comparel,_15911,_15935,_15959],_15897,_15899) --> 
    not(_15911,_15897,_15926),
    more(_15935,_15926,_15950),
    than(_15959,_15950,_15899).

comparel(le,[comparel,_15911,_15935,_15959],_15897,_15899) --> 
    not(_15911,_15897,_15926),
    greater(_15935,_15926,_15950),
    than(_15959,_15950,_15899).

comparel(le,[comparel,_15908,_15932],_15894,_15896) --> 
    at(_15908,_15894,_15923),
    most(_15932,_15923,_15896).

comparel(lt,[comparel,_15908,_15932],_15894,_15896) --> 
    less(_15908,_15894,_15923),
    than(_15932,_15923,_15896).

comparel(ne,[comparel,lit(forskjellig),_15923],_15898,_15900) --> 
    cc(forskjellig,_15898,_15922),
    prep1(from,_15923,_15922,_15900).

comparel(ne,[comparel,lit(annet),lit(enn)],_15898,_15900) --> 
    cc(annet,_15898,_15922),
    cc(enn,_15922,_15900).

comparel(ne,[comparel,lit(ulik)],_15893,_15895) --> 
    cc(ulik,_15893,_15895).

comparel(ne,[comparel,lit(unntatt)],_15893,_15895) --> 
    cc(unntatt,_15893,_15895).

comparel(ne,[comparel,_15908,_15932],_15894,_15896) --> 
    unequal(_15908,_15894,_15923),
    to0(_15932,_15923,_15896).

comparel(_15872,[comparel,_15915,lit(enn)],_15901,_15903) --> 
    w(adj2(_15872,comp),_15915,_15901,_15932),
    cc(enn,_15932,_15903).

comparel(_15872,[comparel,lit(mer),_15931,lit(enn)],_15906,_15908) --> 
    cc(mer,_15906,_15930),
    w(adj2(_15872,nil),_15931,_15930,_15948),
    cc(enn,_15948,_15908).

comparator2(gt,intelligent,[comparator2,_15919,_15948],_15902,_15904) --> 
    w(adj2(intelligent,nil),_15919,_15902,_15936),
    than(_15948,_15936,_15904).

comparator2(lt,intelligent,[comparator2,_15919,_15948],_15902,_15904) --> 
    w(adj2(stupid,nil),_15919,_15902,_15936),
    than(_15948,_15936,_15904).

comparator2(gt,quality,[comparator2,_15919,_15948],_15902,_15904) --> 
    w(adj2(good,comp),_15919,_15902,_15936),
    than(_15948,_15936,_15904).

comparator2(gt,age,[comparator2,_15914,_15938],_15897,_15899) --> 
    older(_15914,_15897,_15929),
    than(_15938,_15929,_15899).

comparator2(lt,age,[comparator2,_15914,_15938],_15897,_15899) --> 
    younger(_15914,_15897,_15929),
    than(_15938,_15929,_15899).

comparator2(gt,latitude,[comparator2,lit(nord),lit(for)],_15901,_15903) --> 
    cc(nord,_15901,_15928),
    cc(for,_15928,_15903).

comparator2(lt,latitude,[comparator2,lit(sør),lit(for)],_15901,_15903) --> 
    cc(sør,_15901,_15928),
    cc(for,_15928,_15903).

comparator2(gt,longitude,[comparator2,lit(vest),lit(for)],_15901,_15903) --> 
    cc(vest,_15901,_15928),
    cc(for,_15928,_15903).

comparator2(lt,longitude,[comparator2,lit(øst),lit(for)],_15901,_15903) --> 
    cc(øst,_15901,_15928),
    cc(for,_15928,_15903).

comparator2(gt,size,[comparator2,_15914,_15938],_15897,_15899) --> 
    greater(_15914,_15897,_15929),
    than(_15938,_15929,_15899).

comparator2(lt,size,[comparator2,lit(mindre),_15927],_15899,_15901) --> 
    cc(mindre,_15899,_15926),
    than(_15927,_15926,_15901).

comparator3(eq,_15873,[comparator3,lit(like),_15937,lit(som)],_15909,_15911) --> 
    cc(like,_15909,_15936),
    w(adj2(_15873,nil),_15937,_15936,_15954),
    cc(som,_15954,_15911).

comparator3(gt,_15873,[comparator3,lit(mer),_15937,lit(enn)],_15909,_15911) --> 
    cc(mer,_15909,_15936),
    w(adj2(_15873,nil),_15937,_15936,_15954),
    cc(enn,_15954,_15911).

comparator3(lt,_15873,[comparator3,lit(mindre),_15937,lit(enn)],_15909,_15911) --> 
    cc(mindre,_15909,_15936),
    w(adj2(_15873,nil),_15937,_15936,_15954),
    cc(enn,_15954,_15911).

comparator3(lt,_15873,[comparator3,lit(ikke),lit(så),_15953,lit(som)],_15914,_15916) --> 
    cc(ikke,_15914,_15941),
    cc(så,_15941,_15952),
    w(adj2(_15873,nil),_15953,_15952,_15970),
    cc(som,_15970,_15916).

comparator3(ge,_15873,[comparator3,lit(minst),lit(like),_15953,lit(som)],_15914,_15916) --> 
    cc(minst,_15914,_15941),
    cc(like,_15941,_15952),
    w(adj2(_15873,nil),_15953,_15952,_15970),
    cc(som,_15970,_15916).

comparator3(le,_15873,[comparator3,lit(høyst),lit(så),_15953,lit(som)],_15914,_15916) --> 
    cc(høyst,_15914,_15941),
    cc(så,_15941,_15952),
    w(adj2(_15873,nil),_15953,_15952,_15970),
    cc(som,_15970,_15916).

superlative(_15872,_15873,[superlative,_15926,_15965,!,_15999],_15909,_15911) --> 
    filanepr(_15872,_15885,_15873,_15926,_15909,_15947),
    quant1(_15885,_15965,_15947,_15982),
    !,
    accept(_15999,_15982,_15911).

superlative(_15872,_15873,[superlative,_15920,_15949],_15903,_15905) --> 
    quant0(_15879,_15920,_15903,_15937),
    filanepr(_15872,_15879,_15873,_15949,_15937,_15905).

flnp(_15872,[flnp,_15924,_15953],_15910,_15912) --> 
    w(adj2(_15872,nil),_15924,_15910,_15941),
    gmem(_15872,[first,last,next,previous],_15953,_15941,_15912).

flnp(next,[flnp,lit(nest)],_15893,_15895) --> 
    cc(nest,_15893,_15895).

flnp(last,[flnp,_15913,!],_15899,_15901) --> 
    w(adj2(late,sup),_15913,_15899,_15901),
    !.

flnp(first,[flnp,_15910],_15896,_15898) --> 
    w(nb(1,ord),_15910,_15896,_15898).

flnpproper(_15872,[flnpproper,lit(først),!,_15929],_15899,_15901) --> 
    cc(først,_15899,_15923),
    !,
    reject(_15929,_15923,_15901).

flnpproper(_15872,[flnpproper,lit(sist),!,_15929],_15899,_15901) --> 
    cc(sist,_15899,_15923),
    !,
    reject(_15929,_15923,_15901).

flnpproper(_15872,[flnpproper,lit(nest),!,_15929],_15899,_15901) --> 
    cc(nest,_15899,_15923),
    !,
    reject(_15929,_15923,_15901).

flnpproper(_15872,[flnpproper,_15907],_15893,_15895) --> 
    flnp(_15872,_15907,_15893,_15895).

filanepr([filanepr,_15906,!],_15895,_15897) --> 
    w(adj2(first,nil),_15906,_15895,_15897),
    !.

filanepr([filanepr,_15906,!],_15895,_15897) --> 
    w(adj2(last,nil),_15906,_15895,_15897),
    !.

filanepr([filanepr,_15906,!],_15895,_15897) --> 
    w(adj2(next,nil),_15906,_15895,_15897),
    !.

filanepr([filanepr,_15906,!],_15895,_15897) --> 
    w(adj2(previous,nil),_15906,_15895,_15897),
    !.

filanepr(min(_15873),_15873,time,[filanepr,_15919],_15899,_15901) --> 
    first(_15919,_15899,_15901).

filanepr(max(_15873),_15873,time,[filanepr,_15919],_15899,_15901) --> 
    latest(_15919,_15899,_15901).

filanepr(min(_15873),_15873,next,[filanepr,_15919],_15899,_15901) --> 
    next(_15919,_15899,_15901).

filanepr(max(_15873),_15873,previous,[filanepr,_15919],_15899,_15901) --> 
    previous(_15919,_15899,_15901).

filanepr(max(_15873),_15873,size,[filanepr,_15919],_15899,_15901) --> 
    greatest(_15919,_15899,_15901).

filanepr(min(_15873),_15873,size,[filanepr,lit(minste)],_15901,_15903) --> 
    cc(minste,_15901,_15903).

faaverb(_15872,[faaverb,_15917,_15941,!],_15903,_15905) --> 
    faa(_15917,_15903,_15932),
    w(verb(_15872,_15883,_15884),_15941,_15932,_15905),
    !.

faaverb(_15872,[faaverb,_15914,!],_15900,_15902) --> 
    w(verb(_15872,inf,fin),_15914,_15900,_15902),
    !.

da0([da0,lit(da),!,_15922],_15895,_15897) --> 
    cc(da,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

da0([da0,[]],_15887,_15887) --> 
    [].

de0([de0,lit(de),!,_15922],_15895,_15897) --> 
    cc(de,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

de0([de0,[]],_15887,_15887) --> 
    [].

dendagen(_15872,[dendagen,lit(om),_15932,_15961,!,_15990],_15907,_15909) --> 
    cc(om,_15907,_15931),
    day(_15872,_15932,_15931,_15949),
    den0(_15961,_15949,_15976),
    !,
    accept(_15990,_15976,_15909).

dendagen(nil,[dendagen,_15914,_15938,!,_15967],_15900,_15902) --> 
    today(_15914,_15900,_15929),
    den0(_15938,_15929,_15953),
    !,
    accept(_15967,_15953,_15902).

dendagen(nil,[dendagen,_15914,_15938,!,_15967],_15900,_15902) --> 
    yesterday(_15914,_15900,_15929),
    den0(_15938,_15929,_15953),
    !,
    accept(_15967,_15953,_15902).

dendagen(nil,[dendagen,_15914,_15938,!,_15967],_15900,_15902) --> 
    tomorrow(_15914,_15900,_15929),
    den0(_15938,_15929,_15953),
    !,
    accept(_15967,_15953,_15902).

dendagen(_15872,[dendagen,_15919,_15943,_15972,!,_16001],_15905,_15907) --> 
    on0(_15919,_15905,_15934),
    day(_15872,_15943,_15934,_15960),
    den0(_15972,_15960,_15987),
    !,
    accept(_16001,_15987,_15907).

dendagen(nil,[dendagen,_15916,lit(den),!,_15956],_15902,_15904) --> 
    on0(_15916,_15902,_15931),
    cc(den,_15931,_15950),
    !,
    accept(_15956,_15950,_15904).

dendagen(nil,[dendagen,_15916,_15945,!,_15974],_15902,_15904) --> 
    prep1(for,_15916,_15902,_15933),
    den0(_15945,_15933,_15960),
    !,
    accept(_15974,_15960,_15904).

dendagen(nil,[dendagen,_15913,!,_15947],_15899,_15901) --> 
    prep1(on,_15913,_15899,_15930),
    !,
    accept(_15947,_15930,_15901).

der0([der0,lit(der),_15920,!,_15949],_15898,_15900) --> 
    cc(der,_15898,_15919),
    qm0(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

der0([der0,_15898],_15887,_15889) --> 
    qm0(_15898,_15887,_15889).

qm0([qm0,lit(?)],_15889,_15891) --> 
    cc(?,_15889,_15891).

qm0([qm0,[]],_15887,_15887) --> 
    [].

detsamme([detsamme,lit(en),lit(gang)],_15894,_15896) --> 
    cc(en,_15894,_15915),
    cc(gang,_15915,_15896).

detsamme([detsamme,_15910,lit(det),lit(samme)],_15899,_15901) --> 
    prep1(with,_15910,_15899,_15927),
    cc(det,_15927,_15949),
    cc(samme,_15949,_15901).

den0([den0,_15901,!],_15890,_15892) --> 
    den(_15901,_15890,_15892),
    !.

den0([den0,[]],_15887,_15887) --> 
    [].

den([den,lit(den)],_15889,_15891) --> 
    cc(den,_15889,_15891).

dendet0([dendet0,_15905,!],_15894,_15896) --> 
    look_ahead([d],_15905,_15894,_15896),
    !.

dendet0([dendet0,lit(den),_15927,!,_15961],_15905,_15907) --> 
    cc(den,_15905,_15926),
    not_look_ahead(w(nb(_15887,_15888)),_15927,_15926,_15944),
    !,
    accept(_15961,_15944,_15907).

dendet0([dendet0,lit(det),!,_15922],_15895,_15897) --> 
    cc(det,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

dendet0([dendet0,[]],_15887,_15887) --> 
    [].

dent0([dent0,lit(den),!],_15892,_15894) --> 
    cc(den,_15892,_15894),
    !.

dent0([dent0,lit(det),!],_15892,_15894) --> 
    cc(det,_15892,_15894),
    !.

dent0([dent0,lit(de),!,_15922],_15895,_15897) --> 
    cc(de,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

dent0([dent0,lit(noen),!],_15892,_15894) --> 
    cc(noen,_15892,_15894),
    !.

dent0([dent0,lit(en),!],_15892,_15894) --> 
    cc(en,_15892,_15894),
    !.

dent0([dent0,[]],_15887,_15887) --> 
    [].

det0([det0,_15907,_15931,!,_15960],_15896,_15898) --> 
    thereit(_15907,_15896,_15922),
    thereit_not_pronoun(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

det0([det0,[]],_15887,_15887) --> 
    [].

dudet([dudet,lit(du)],_15889,_15891) --> 
    cc(du,_15889,_15891).

dudet([dudet,lit(det)],_15889,_15891) --> 
    cc(det,_15889,_15891).

dudet([dudet,_15900],_15889,_15891) --> 
    pronoun(_15872,_15900,_15889,_15891).

each([each,lit(alle),_15914],_15892,_15894) --> 
    cc(alle,_15892,_15913),
    the(_15914,_15913,_15894).

earlier([earlier,lit(tidligere)],_15889,_15891) --> 
    cc(tidligere,_15889,_15891).

earlier([earlier,_15905,lit(forhånd)],_15894,_15896) --> 
    prep1(on,_15905,_15894,_15922),
    cc(forhånd,_15922,_15896).

earlier([earlier,lit(derfør)],_15889,_15891) --> 
    cc(derfør,_15889,_15891).

either0([either0,lit(enten),!,_15922],_15895,_15897) --> 
    cc(enten,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

either0([either0,[]],_15887,_15887) --> 
    [].

equal([equal,lit(lik)],_15889,_15891) --> 
    cc(lik,_15889,_15891).

equal([equal,lit(likt)],_15889,_15891) --> 
    cc(likt,_15889,_15891).

iyou(du,[iyou,lit(du)],_15893,_15895) --> 
    cc(du,_15893,_15895).

iyou(jeg,[iyou,lit(jeg)],_15893,_15895) --> 
    cc(jeg,_15893,_15895).

iyou(vi,[iyou,lit(vi)],_15893,_15895) --> 
    cc(vi,_15893,_15895).

areyou([areyou,lit(erru),_15916],_15894,_15896) --> 
    cc(erru,_15894,_15915),
    negation0(_15875,_15916,_15915,_15896).

areyou([areyou,_15914,lit(du),_15954],_15903,_15905) --> 
    w(verb(be,_15883,fin),_15914,_15903,_15931),
    cc(du,_15931,_15953),
    negation0(_15878,_15954,_15953,_15905).

areyou([areyou,lit(vil),lit(du),_15941,_15970],_15908,_15910) --> 
    cc(vil,_15908,_15929),
    cc(du,_15929,_15940),
    negation0(_15891,_15941,_15940,_15958),
    w(verb(be,_15884,fin),_15970,_15958,_15910).

every([every,lit(alle),_15914],_15892,_15894) --> 
    cc(alle,_15892,_15913),
    de0(_15914,_15913,_15894).

every([every,lit(en),lit(hver)],_15894,_15896) --> 
    cc(en,_15894,_15915),
    cc(hver,_15915,_15896).

false([false,lit(galt)],_15889,_15891) --> 
    cc(galt,_15889,_15891).

false([false,lit(usant)],_15889,_15891) --> 
    cc(usant,_15889,_15891).

false([false,lit(feil)],_15889,_15891) --> 
    cc(feil,_15889,_15891).

false([false,lit(uriktig)],_15889,_15891) --> 
    cc(uriktig,_15889,_15891).

few([few,lit(få)],_15889,_15891) --> 
    cc(få,_15889,_15891).

few([few,lit(fåtallig)],_15889,_15891) --> 
    cc(fåtallig,_15889,_15891).

first([first,_15903],_15892,_15894) --> 
    w(adj2(first,nil),_15903,_15892,_15894).

first([first,lit(tidligste)],_15889,_15891) --> 
    cc(tidligste,_15889,_15891).

faa([faa,lit(få)],_15889,_15891) --> 
    cc(få,_15889,_15891).

faa([faa,lit(får)],_15889,_15891) --> 
    cc(får,_15889,_15891).

faa0([faa0,_15904,!,_15933],_15893,_15895) --> 
    faa(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

faa0([faa0,[]],_15887,_15887) --> 
    [].

fast([fast,lit(fort)],_15889,_15891) --> 
    cc(fort,_15889,_15891).

fast([fast,_15903],_15892,_15894) --> 
    w(adj2(fast,nil),_15903,_15892,_15894).

fast([fast,_15908,lit(mulig)],_15897,_15899) --> 
    w(adj2(fast,nil),_15908,_15897,_15925),
    cc(mulig,_15925,_15899).

fast([fast,_15898],_15887,_15889) --> 
    hereafter(_15898,_15887,_15889).

from([from,_15900],_15889,_15891) --> 
    prep(from,_15900,_15889,_15891).

førnår([førnår,lit(når)],_15889,_15891) --> 
    cc(når,_15889,_15891).

førnår([førnår,lit(før)],_15889,_15891) --> 
    cc(før,_15889,_15891).

great([great,_15903],_15892,_15894) --> 
    w(adj2(great,nil),_15903,_15892,_15894).

great([great,lit(høy)],_15889,_15891) --> 
    cc(høy,_15889,_15891).

greater([greater,_15900],_15889,_15891) --> 
    prep(after,_15900,_15889,_15891).

greater([greater,lit(større)],_15889,_15891) --> 
    cc(større,_15889,_15891).

greater([greater,lit(høyere)],_15889,_15891) --> 
    cc(høyere,_15889,_15891).

greater([greater,lit(mer)],_15889,_15891) --> 
    cc(mer,_15889,_15891).

greater([greater,_15898],_15887,_15889) --> 
    great(_15898,_15887,_15889).

greatest([greatest,lit(størst)],_15889,_15891) --> 
    cc(størst,_15889,_15891).

greatest([greatest,lit(største)],_15889,_15891) --> 
    cc(største,_15889,_15891).

halfhour([halfhour,lit(halv),_15921],_15899,_15901) --> 
    cc(halv,_15899,_15920),
    w(noun(hour,_15878,_15879,n),_15921,_15920,_15901).

halfhour([halfhour,lit(halvtime)],_15889,_15891) --> 
    cc(halvtime,_15889,_15891).

has(_15872,[has,_15922,_15946,_15975],_15908,_15910) --> 
    has(_15922,_15908,_15937),
    negation0(_15872,_15946,_15937,_15963),
    not_look_ahead(w(noun(arrival,_15885,_15886,n)),_15975,_15963,_15910).

has0([has0,_15901,!],_15890,_15892) --> 
    has(_15901,_15890,_15892),
    !.

has0([has0,[]],_15887,_15887) --> 
    [].

has([has,_15916,_15945],_15905,_15907) --> 
    w(verb(have,_15887,fin),_15916,_15905,_15933),
    not_look_ahead(w(noun(arrival,_15880,_15881,n)),_15945,_15933,_15907).

hashad0([hashad0,_15901,!],_15890,_15892) --> 
    hashad(_15901,_15890,_15892),
    !.

hashad0([hashad0,[]],_15887,_15887) --> 
    [].

hashad([hashad,_15919,_15948,!,_15982],_15908,_15910) --> 
    w(verb(have,_15884,_15885),_15919,_15908,_15936),
    w(verb(have,_15890,_15891),_15948,_15936,_15965),
    !,
    accept(_15982,_15965,_15910).

hashad([hashad,_15904],_15893,_15895) --> 
    w(verb(have,_15875,_15876),_15904,_15893,_15895).

hasto0([hasto0,_15907,_15936],_15896,_15898) --> 
    w(verb(have,_15878,fin),_15907,_15896,_15924),
    infinitive(_15936,_15924,_15898).

hasto0([hasto0,[]],_15887,_15887) --> 
    [].

hereafter([hereafter,lit(om),lit(ikke),lit(så),lit(lenge)],_15904,_15906) --> 
    cc(om,_15904,_15925),
    cc(ikke,_15925,_15936),
    cc(så,_15936,_15947),
    cc(lenge,_15947,_15906).

hereafter([hereafter,_15901,_15925],_15890,_15892) --> 
    soonar(_15901,_15890,_15916),
    aspossible0(_15925,_15916,_15892).

hereafter([hereafter,lit(så),_15930,lit(som),_15965,!],_15908,_15910) --> 
    cc(så,_15908,_15929),
    soon(_15930,_15929,_15945),
    cc(som,_15945,_15964),
    w(adj2(possible,nil),_15965,_15964,_15910),
    !.

hereafter([hereafter,_15916,_15945,_15969,!],_15905,_15907) --> 
    prep1(in,_15916,_15905,_15933),
    near(_15945,_15933,_15960),
    w(noun(future,_15886,_15887,_15888),_15969,_15960,_15907),
    !.

hereafter([hereafter,lit(med),lit(en),lit(gang)],_15899,_15901) --> 
    cc(med,_15899,_15920),
    cc(en,_15920,_15931),
    cc(gang,_15931,_15901).

hereafter([hereafter,lit(heretter)],_15889,_15891) --> 
    cc(heretter,_15889,_15891).

hereafter([hereafter,_15903,_15932],_15892,_15894) --> 
    prep1(from,_15903,_15892,_15920),
    nowon(_15932,_15920,_15894).

hereafter([hereafter,_15918,_15947,_15976],_15907,_15909) --> 
    prep1(in,_15918,_15907,_15935),
    w(adj2(nearest,nil),_15947,_15935,_15964),
    w(noun(future,_15881,_15882,n),_15976,_15964,_15909).

hereafter([hereafter,_15918,_15947,_15976],_15907,_15909) --> 
    prep1(on,_15918,_15907,_15935),
    w(adj2(_15889,nil),_15947,_15935,_15964),
    w(noun(way,_15881,u,n),_15976,_15964,_15909).

hereafter([hereafter,_15903,_15932],_15892,_15894) --> 
    prep1(after,_15903,_15892,_15920),
    now1(_15932,_15920,_15894).

hereafter([hereafter,_15905,lit(dette)],_15894,_15896) --> 
    prep1(after,_15905,_15894,_15922),
    cc(dette,_15922,_15896).

hereafter([hereafter,lit(raskest),lit(mulig)],_15894,_15896) --> 
    cc(raskest,_15894,_15915),
    cc(mulig,_15915,_15896).

hereafter([hereafter,_15908,lit(gang)],_15897,_15899) --> 
    w(adj2(next,nil),_15908,_15897,_15925),
    cc(gang,_15925,_15899).

hereafter([hereafter,lit(raskest)],_15889,_15891) --> 
    cc(raskest,_15889,_15891).

herefrom([herefrom,_15911,lit(her),!,_15956],_15900,_15902) --> 
    prep1(from,_15911,_15900,_15928),
    cc(her,_15928,_15950),
    !,
    accept(_15956,_15950,_15902).

herefrom([herefrom,lit(herfra)],_15889,_15891) --> 
    cc(herfra,_15889,_15891).

herefrom([herefrom,lit(derfra)],_15889,_15891) --> 
    cc(derfra,_15889,_15891).

how([how,lit(hvordan),_15914],_15892,_15894) --> 
    cc(hvordan,_15892,_15913),
    ialle0(_15914,_15913,_15894).

how([how,lit(hvorfor),_15914],_15892,_15894) --> 
    cc(hvorfor,_15892,_15913),
    ialle0(_15914,_15913,_15894).

hoq([hoq,lit(vil),lit(du),lit(at)],_15899,_15901) --> 
    cc(vil,_15899,_15920),
    cc(du,_15920,_15931),
    cc(at,_15931,_15901).

hoq([hoq,_15914,lit(det),lit(at)],_15903,_15905) --> 
    w(verb(mean,_15883,fin),_15914,_15903,_15931),
    cc(det,_15931,_15953),
    cc(at,_15953,_15905).

hoq([hoq,_15916,lit(det),lit(seg),_15962,lit(at)],_15905,_15907) --> 
    has(_15916,_15905,_15931),
    cc(det,_15931,_15950),
    cc(seg,_15950,_15961),
    redundant0(_15962,_15961,_15977),
    cc(at,_15977,_15907).

hoq([hoq,_15911,lit(det),_15946,lit(at)],_15900,_15902) --> 
    be(_15911,_15900,_15926),
    cc(det,_15926,_15945),
    redundant0(_15946,_15945,_15961),
    cc(at,_15961,_15902).

hoq([hoq,_15919,lit(det),lit(an),lit(at)],_15908,_15910) --> 
    w(verb(go,_15886,fin),_15919,_15908,_15936),
    cc(det,_15936,_15958),
    cc(an,_15958,_15969),
    cc(at,_15969,_15910).

hoq([hoq,_15919,lit(det),_15959,lit(at)],_15908,_15910) --> 
    w(verb(agree,_15886,fin),_15919,_15908,_15936),
    cc(det,_15936,_15958),
    negation0(_15891,_15959,_15958,_15976),
    cc(at,_15976,_15910).

ihvor([ihvor,lit(i),lit(hvor),!],_15897,_15899) --> 
    cc(i,_15897,_15918),
    cc(hvor,_15918,_15899),
    !.

ihvor([ihvor,lit(hvor)],_15889,_15891) --> 
    cc(hvor,_15889,_15891).

hvor([hvor,lit(hvor)],_15889,_15891) --> 
    cc(hvor,_15889,_15891).

hvordan([hvordan,lit(hvordan),!,_15922],_15895,_15897) --> 
    cc(hvordan,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

hvordan([hvordan,lit(hva),lit(slags),_15936,!,_15965],_15903,_15905) --> 
    cc(hva,_15903,_15924),
    cc(slags,_15924,_15935),
    type0(_15936,_15935,_15951),
    !,
    accept(_15965,_15951,_15905).

hvordan([hvordan,lit(hva),!,_15922],_15895,_15897) --> 
    cc(hva,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

hvordan([hvordan,lit(hvor),_15925,!,_15959],_15903,_15905) --> 
    cc(hvor,_15903,_15924),
    w(adj2(great,nil),_15925,_15924,_15942),
    !,
    accept(_15959,_15942,_15905).

hvorfor([hvorfor,lit(hvorfor),_15914],_15892,_15894) --> 
    cc(hvorfor,_15892,_15913),
    ialle0(_15914,_15913,_15894).

type0([type0,_15904,!,_15933],_15893,_15895) --> 
    type(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

type0([type0,[]],_15887,_15887) --> 
    [].

type([type,_15911,!,_15945],_15900,_15902) --> 
    w(noun(type,_15881,u,n),_15911,_15900,_15928),
    !,
    accept(_15945,_15928,_15902).

i([i,lit(jeg)],_15889,_15891) --> 
    cc(jeg,_15889,_15891).

i([i,lit(meg)],_15889,_15891) --> 
    cc(meg,_15889,_15891).

i([i,lit(oss)],_15889,_15891) --> 
    cc(oss,_15889,_15891).

ialle0([ialle0,[]],_15887,_15887) --> 
    [].

if1([if1,lit(hvis)],_15889,_15891) --> 
    cc(hvis,_15889,_15891).

if1([if1,lit(om),_15932,{}],_15910,_15912) --> 
    cc(om,_15910,_15931),
    look_ahead(w(name(_15891,_15892,_15882)),_15932,_15931,_15912),
    {user:(\+subclass0(_15882,place))}.

if1([if1,lit(om),_15933,{}],_15911,_15913) --> 
    cc(om,_15911,_15932),
    look_ahead(w(noun(_15882,_15892,_15893,_15894)),_15933,_15932,_15913),
    {user:(\+subclass0(_15882,place))}.

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([jeg],_15918,_15917,_15898).

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([du],_15918,_15917,_15898).

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([han],_15918,_15917,_15898).

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([hun],_15918,_15917,_15898).

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([man],_15918,_15917,_15898).

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([vi],_15918,_15917,_15898).

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([dere],_15918,_15917,_15898).

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([de],_15918,_15917,_15898).

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([en],_15918,_15917,_15898).

if1([if1,lit(om),_15918],_15896,_15898) --> 
    cc(om,_15896,_15917),
    look_ahead([et],_15918,_15917,_15898).

ifra([ifra,lit(fra)],_15889,_15891) --> 
    cc(fra,_15889,_15891).

ifra([ifra,lit(ifra)],_15889,_15891) --> 
    cc(ifra,_15889,_15891).

iman([iman,lit(jeg)],_15889,_15891) --> 
    cc(jeg,_15889,_15891).

iman([iman,lit(man)],_15889,_15891) --> 
    cc(man,_15889,_15891).

iman([iman,lit(en)],_15889,_15891) --> 
    cc(en,_15889,_15891).

iman([iman,lit(du)],_15889,_15891) --> 
    cc(du,_15889,_15891).

inperiod0([inperiod0,_15916,_15945,!,_15979],_15905,_15907) --> 
    prep1(in,_15916,_15905,_15933),
    w(noun(hour,_15886,def,n),_15945,_15933,_15962),
    !,
    accept(_15979,_15962,_15907).

inperiod0([inperiod0,lit(om),_15927,!,_15961],_15905,_15907) --> 
    cc(om,_15905,_15926),
    w(noun(day,_15886,def,n),_15927,_15926,_15944),
    !,
    accept(_15961,_15944,_15907).

inperiod0([inperiod0,lit(hver),_15927,!,_15961],_15905,_15907) --> 
    cc(hver,_15905,_15926),
    w(noun(day,sin,u,n),_15927,_15926,_15944),
    !,
    accept(_15961,_15944,_15907).

inperiod0([inperiod0,[]],_15887,_15887) --> 
    [].

in_order_to(adj/nil/_15876,id,[in_order_to,_15917],_15900,_15902) --> 
    infinitiveand(_15917,_15900,_15902).

in_order_to(begin,id,[in_order_to,_15917,!,_15946],_15900,_15902) --> 
    infinitive(_15917,_15900,_15932),
    !,
    accept(_15946,_15932,_15902).

in_order_to(like,id,[in_order_to,_15917,!,_15946],_15900,_15902) --> 
    infinitive(_15917,_15900,_15932),
    !,
    accept(_15946,_15932,_15902).

in_order_to(start,id,[in_order_to,_15917,!,_15946],_15900,_15902) --> 
    infinitive(_15917,_15900,_15932),
    !,
    accept(_15946,_15932,_15902).

in_order_to(stop,id,[in_order_to,_15917,!,_15946],_15900,_15902) --> 
    infinitive(_15917,_15900,_15932),
    !,
    accept(_15946,_15932,_15902).

in_order_to(use,id,[in_order_to,_15938,{},_15977,!,_16006],_15921,_15923) --> 
    prepnof(_15887,_15938,_15921,_15955),
    {user:testmember(_15887,[on,to,for,with])},
    infinitive(_15977,_15955,_15992),
    !,
    accept(_16006,_15992,_15923).

in_order_to(use2,id,[in_order_to,_15917,!,_15946],_15900,_15902) --> 
    infinitive(_15917,_15900,_15932),
    !,
    accept(_15946,_15932,_15902).

in_order_to(have,id,[in_order_to,_15911],_15894,_15896) --> 
    infinitive(_15911,_15894,_15896).

in_order_to(think,id,[in_order_to,[]],_15894,_15894) --> 
    [].

in_order_to(_15872,not,[in_order_to,lit(uten),_15927],_15899,_15901) --> 
    cc(uten,_15899,_15926),
    infinitive(_15927,_15926,_15901).

in_order_to(_15872,id,[in_order_to,_15911],_15894,_15896) --> 
    in_order_to(_15911,_15894,_15896).

in_order_tox([in_order_tox,_15901,!],_15890,_15892) --> 
    infinitive(_15901,_15890,_15892),
    !.

in_order_tox([in_order_tox,_15898],_15887,_15889) --> 
    in_order_to(_15898,_15887,_15889).

in_order_to([in_order_to,_15898],_15887,_15889) --> 
    forå(_15898,_15887,_15889).

in_order_to([in_order_to,lit(får),_15917,!],_15895,_15897) --> 
    cc(får,_15895,_15916),
    infinitive(_15917,_15916,_15897),
    !.

in_order_to([in_order_to,lit(for),_15917,!],_15895,_15897) --> 
    cc(for,_15895,_15916),
    infinitiveand(_15917,_15916,_15897),
    !.

in_order_to([in_order_to,lit(før),_15917,!],_15895,_15897) --> 
    cc(før,_15895,_15916),
    infinitive(_15917,_15916,_15897),
    !.

in_order_to([in_order_to,_15906,_15935,!],_15895,_15897) --> 
    prep1(on,_15906,_15895,_15923),
    infinitive(_15935,_15923,_15897),
    !.

in_order_to([in_order_to,_15906,_15935,!],_15895,_15897) --> 
    prep1(with,_15906,_15895,_15923),
    infinitive(_15935,_15923,_15897),
    !.

in_order_to([in_order_to,_15906,_15935,!],_15895,_15897) --> 
    prep1(to,_15906,_15895,_15923),
    infinitiveand(_15935,_15923,_15897),
    !.

in_order_to([in_order_to,lit(av),_15917,!],_15895,_15897) --> 
    cc(av,_15895,_15916),
    infinitive(_15917,_15916,_15897),
    !.

in_order_to([in_order_to,lit(for),lit(og),!],_15897,_15899) --> 
    cc(for,_15897,_15918),
    cc(og,_15918,_15899),
    !.

in_order_to([in_order_to,lit(får),lit(å),!],_15897,_15899) --> 
    cc(får,_15897,_15918),
    cc(å,_15918,_15899),
    !.

in_order_to([in_order_to,lit(får),lit(og),!],_15897,_15899) --> 
    cc(får,_15897,_15918),
    cc(og,_15918,_15899),
    !.

forå([forå,lit(i),_15914],_15892,_15894) --> 
    cc(i,_15892,_15913),
    ogå(_15914,_15913,_15894).

forå([forå,lit(med),_15914],_15892,_15894) --> 
    cc(med,_15892,_15913),
    ogå(_15914,_15913,_15894).

forå([forå,lit(mot),_15914],_15892,_15894) --> 
    cc(mot,_15892,_15913),
    ogå(_15914,_15913,_15894).

forå([forå,lit(for),_15914],_15892,_15894) --> 
    cc(for,_15892,_15913),
    ogå(_15914,_15913,_15894).

forå([forå,lit(til),_15914],_15892,_15894) --> 
    cc(til,_15892,_15913),
    ogå(_15914,_15913,_15894).

forå([forå,lit(over),_15914],_15892,_15894) --> 
    cc(over,_15892,_15913),
    ogå(_15914,_15913,_15894).

forå([forå,lit(før),lit(å)],_15894,_15896) --> 
    cc(før,_15894,_15915),
    cc(å,_15915,_15896).

forå([forå,lit(ved),lit(å)],_15894,_15896) --> 
    cc(ved,_15894,_15915),
    cc(å,_15915,_15896).

ogå([ogå,lit(å)],_15889,_15891) --> 
    cc(å,_15889,_15891).

ogå([ogå,lit(og)],_15889,_15891) --> 
    cc(og,_15889,_15891).

infinitiveand([infinitiveand,lit(å)],_15889,_15891) --> 
    cc(å,_15889,_15891).

infinitiveand([infinitiveand,lit(og)],_15889,_15891) --> 
    cc(og,_15889,_15891).

infinitive([infinitive,lit(å),_15928,_15952,!],_15906,_15908) --> 
    cc(å,_15906,_15927),
    faa(_15928,_15927,_15943),
    look_ahead(w(verb(_15887,_15888,_15889)),_15952,_15943,_15908),
    !.

infinitive([infinitive,lit(å)],_15889,_15891) --> 
    cc(å,_15889,_15891).

infinitive([infinitive,lit(til),lit(å)],_15894,_15896) --> 
    cc(til,_15894,_15915),
    cc(å,_15915,_15896).

inom(in,[inom,_15907],_15893,_15895) --> 
    prep1(in,_15907,_15893,_15895).

inom(om,[inom,lit(om)],_15893,_15895) --> 
    cc(om,_15893,_15895).

inom(om,[inom,_15907],_15893,_15895) --> 
    prep1(on,_15907,_15893,_15895).

instead_of([instead_of,lit(fremfor)],_15889,_15891) --> 
    cc(fremfor,_15889,_15891).

instead_of([instead_of,_15918,_15947,lit(for),!],_15907,_15909) --> 
    prep1(in,_15918,_15907,_15935),
    w(noun(place,sin,def,n),_15947,_15935,_15964),
    cc(for,_15964,_15909),
    !.

instead_of([instead_of,lit(istedenfor)],_15889,_15891) --> 
    cc(istedenfor,_15889,_15891).

instead_of([instead_of,lit(heller),lit(enn)],_15894,_15896) --> 
    cc(heller,_15894,_15915),
    cc(enn,_15915,_15896).

it0([it0,lit(det),_15921,!],_15899,_15901) --> 
    cc(det,_15899,_15920),
    not_look_ahead([vil],_15921,_15920,_15901),
    !.

it0([it0,[]],_15887,_15887) --> 
    [].

it([it,lit(den)],_15889,_15891) --> 
    cc(den,_15889,_15891).

its([its,lit(dens),_15914],_15892,_15894) --> 
    cc(dens,_15892,_15913),
    own0(_15914,_15913,_15894).

its([its,lit(dets),_15914],_15892,_15894) --> 
    cc(dets,_15892,_15913),
    own0(_15914,_15913,_15894).

later([later,lit(senere)],_15889,_15891) --> 
    cc(senere,_15889,_15891).

later([later,lit(siden),_15914],_15892,_15894) --> 
    cc(siden,_15892,_15913),
    not_look_ahead_np(_15914,_15913,_15894).

later([later,lit(deretter)],_15889,_15891) --> 
    cc(deretter,_15889,_15891).

latest([latest,_15903],_15892,_15894) --> 
    w(adj2(sup,late),_15903,_15892,_15894).

latest([latest,_15903],_15892,_15894) --> 
    w(adj2(last,nil),_15903,_15892,_15894).

less([less,lit(før)],_15889,_15891) --> 
    cc(før,_15889,_15891).

less([less,lit(tidligere)],_15889,_15891) --> 
    cc(tidligere,_15889,_15891).

less([less,lit(mindre)],_15889,_15891) --> 
    cc(mindre,_15889,_15891).

less([less,lit(lavere)],_15889,_15891) --> 
    cc(lavere,_15889,_15891).

let([let,_15904],_15893,_15895) --> 
    w(verb(let,pres,fin),_15904,_15893,_15895).

little([little,lit(lite)],_15889,_15891) --> 
    cc(lite,_15889,_15891).

long([long,_15903],_15892,_15894) --> 
    w(adj2(short,nil),_15903,_15892,_15894).

long([long,_15903],_15892,_15894) --> 
    w(adj2(long,nil),_15903,_15892,_15894).

longadj([longadj,_15903],_15892,_15894) --> 
    w(adj2(long,nil),_15903,_15892,_15894).

manypersons([manypersons,lit(mange),_15920,!,_15949],_15898,_15900) --> 
    cc(mange,_15898,_15919),
    adjnoun(_15920,_15919,_15935),
    !,
    reject(_15949,_15935,_15900).

manypersons([manypersons,lit(mange)],_15889,_15891) --> 
    cc(mange,_15889,_15891).

many1([many1,lit(mange),_15914],_15892,_15894) --> 
    cc(mange,_15892,_15913),
    off0(_15914,_15913,_15894).

many([many,_15906,lit(mange),_15941],_15895,_15897) --> 
    so0(_15906,_15895,_15921),
    cc(mange,_15921,_15940),
    off0(_15941,_15940,_15897).

meny([meny,lit(mange)],_15889,_15891) --> 
    cc(mange,_15889,_15891).

meny([meny,lit(meget)],_15889,_15891) --> 
    cc(meget,_15889,_15891).

meny([meny,lit(mye)],_15889,_15891) --> 
    cc(mye,_15889,_15891).

me0([me0,lit(jeg),!],_15892,_15894) --> 
    cc(jeg,_15892,_15894),
    !.

me0([me0,lit(meg),!],_15892,_15894) --> 
    cc(meg,_15892,_15894),
    !.

me0([me0,lit(oss),!],_15892,_15894) --> 
    cc(oss,_15892,_15894),
    !.

me0([me0,lit(seg),!],_15892,_15894) --> 
    cc(seg,_15892,_15894),
    !.

me0([me0,[]],_15887,_15887) --> 
    [].

mineyour0([mineyour0,_15903,!],_15892,_15894) --> 
    posspron(_15875,_15903,_15892,_15894),
    !.

mineyour0([mineyour0,[]],_15887,_15887) --> 
    [].

more([more,lit(mer)],_15889,_15891) --> 
    cc(mer,_15889,_15891).

more([more,lit(fler)],_15889,_15891) --> 
    cc(fler,_15889,_15891).

more([more,lit(flere)],_15889,_15891) --> 
    cc(flere,_15889,_15891).

most([most,lit(de),lit(fleste)],_15894,_15896) --> 
    cc(de,_15894,_15915),
    cc(fleste,_15915,_15896).

most([most,lit(flest)],_15889,_15891) --> 
    cc(flest,_15889,_15891).

much([much,lit(mye)],_15889,_15891) --> 
    cc(mye,_15889,_15891).

much([much,lit(meget)],_15889,_15891) --> 
    cc(meget,_15889,_15891).

my([my,lit(min)],_15889,_15891) --> 
    cc(min,_15889,_15891).

my([my,lit(mitt)],_15889,_15891) --> 
    cc(mitt,_15889,_15891).

my([my,lit(mine)],_15889,_15891) --> 
    cc(mine,_15889,_15891).

when10([when10,_15898],_15887,_15889) --> 
    when1(_15898,_15887,_15889).

when10([when10,[]],_15887,_15887) --> 
    [].

when1([when1,lit(da)],_15889,_15891) --> 
    cc(da,_15889,_15891).

when1([when1,lit(når)],_15889,_15891) --> 
    cc(når,_15889,_15891).

when1([when1,lit(n),{},!],_15900,_15902) --> 
    cc(n,_15900,_15902),
    {user:value(smsflag,true)},
    !.

when1([when1,lit(tid),_15918],_15896,_15898) --> 
    cc(tid,_15896,_15917),
    look_ahead([går],_15918,_15917,_15898).

negation2(only,only,[negation2,[],!],_15897,_15897) --> 
    [],
    !.

negation2(id,only,[negation2,_15913],_15896,_15898) --> 
    negation(only,_15913,_15896,_15898).

negation2(id,only,[negation2,_15913],_15896,_15898) --> 
    negation(only,_15913,_15896,_15898).

negation2(not,id,[negation2,_15913],_15896,_15898) --> 
    negation(only,_15913,_15896,_15898).

negation2(not,id,[negation2,_15919,!,_15953],_15902,_15904) --> 
    negation(not,_15919,_15902,_15936),
    !,
    reject(_15953,_15936,_15904).

negation2(not,not,[negation2,_15913],_15896,_15898) --> 
    negation0(id,_15913,_15896,_15898).

negation2(id,_15873,[negation2,_15913],_15896,_15898) --> 
    negation0(_15873,_15913,_15896,_15898).

negation2(often,often,[negation2,[]],_15894,_15894) --> 
    [].

negation0(_15872,[negation0,{},!],_15904,_15904) --> 
    {user:(nonvar(_15872),_15872==not)},
    !.

negation0(_15872,[negation0,_15910,!],_15896,_15898) --> 
    negation(_15872,_15910,_15896,_15898),
    !.

negation0(id,[negation0,[]],_15891,_15891) --> 
    [].

negation(id,[negation,_15913,lit(bare),!],_15899,_15901) --> 
    not(_15913,_15899,_15928),
    cc(bare,_15928,_15901),
    !.

negation(not,[negation,lit(bare),_15921],_15896,_15898) --> 
    cc(bare,_15896,_15920),
    not(_15921,_15920,_15898).

negation(not,[negation,_15905],_15891,_15893) --> 
    not(_15905,_15891,_15893).

negation(only,[negation,lit(bare)],_15893,_15895) --> 
    cc(bare,_15893,_15895).

negation(atleast,[negation,lit(minst)],_15893,_15895) --> 
    cc(minst,_15893,_15895).

negation(often,[negation,lit(ofte)],_15893,_15895) --> 
    cc(ofte,_15893,_15895).

negatino([negatino,lit(ikke),!],_15892,_15894) --> 
    cc(ikke,_15892,_15894),
    !.

negatino([negatino,lit(ingen),!],_15892,_15894) --> 
    cc(ingen,_15892,_15894),
    !.

negatino([negatino,[]],_15887,_15887) --> 
    [].

near([near,_15903],_15892,_15894) --> 
    w(adj2(near,nil),_15903,_15892,_15894).

near([near,_15906,_15930],_15895,_15897) --> 
    the0(_15906,_15895,_15921),
    w(adj2(nearest,nil),_15930,_15921,_15897).

nearest([nearest,_15903],_15892,_15894) --> 
    w(adj2(near,sup),_15903,_15892,_15894).

nearest([nearest,_15903],_15892,_15894) --> 
    w(adj2(nearest,nil),_15903,_15892,_15894).

nearest([nearest,_15900],_15889,_15891) --> 
    prep1(nearest,_15900,_15889,_15891).

nest([nest,lit(nest)],_15889,_15891) --> 
    cc(nest,_15889,_15891).

nest([nest,_15903],_15892,_15894) --> 
    w(adj2(next,nil),_15903,_15892,_15894).

next0([next0,_15901,!],_15890,_15892) --> 
    next(_15901,_15890,_15892),
    !.

next0([next0,[]],_15887,_15887) --> 
    [].

next([next,_15903],_15892,_15894) --> 
    w(adj2(next,nil),_15903,_15892,_15894).

no([no,lit(ingen),_15914],_15892,_15894) --> 
    cc(ingen,_15892,_15913),
    look_ahead_np(_15914,_15913,_15894).

notall([notall,lit(ikke),lit(alle)],_15894,_15896) --> 
    cc(ikke,_15894,_15915),
    cc(alle,_15915,_15896).

not0([not0,_15901,!],_15890,_15892) --> 
    not(_15901,_15890,_15892),
    !.

not0([not0,[]],_15887,_15887) --> 
    [].

not([not,lit(ikke)],_15889,_15891) --> 
    cc(ikke,_15889,_15891).

not([not,lit(intet),_15914],_15892,_15894) --> 
    cc(intet,_15892,_15913),
    look_ahead_np(_15914,_15913,_15894).

notwithstanding([notwithstanding,lit(selv_om)],_15889,_15891) --> 
    cc(selv_om,_15889,_15891).

notwithstanding([notwithstanding,lit(selv),lit(om)],_15894,_15896) --> 
    cc(selv,_15894,_15915),
    cc(om,_15915,_15896).

now0([now0,_15901,!],_15890,_15892) --> 
    now1(_15901,_15890,_15892),
    !.

now0([now0,_15898],_15887,_15889) --> 
    today(_15898,_15887,_15889).

now0([now0,[]],_15887,_15887) --> 
    [].

now1([now1,lit(ennå)],_15889,_15891) --> 
    cc(ennå,_15889,_15891).

now1([now1,lit(nå)],_15889,_15891) --> 
    cc(nå,_15889,_15891).

now1([now1,lit(no)],_15889,_15891) --> 
    cc(no,_15889,_15891).

nowon([nowon,_15906,lit(av),!],_15895,_15897) --> 
    now1(_15906,_15895,_15921),
    cc(av,_15921,_15897),
    !.

nowon([nowon,_15898],_15887,_15889) --> 
    now1(_15898,_15887,_15889).

nr0([nr0,_15901,!],_15890,_15892) --> 
    nr1(_15901,_15890,_15892),
    !.

nr0([nr0,[]],_15887,_15887) --> 
    [].

nr1([nr1,lit(nr),_15917,!],_15895,_15897) --> 
    cc(nr,_15895,_15916),
    point0(_15917,_15916,_15897),
    !.

nr1([nr1,lit(n),_15917,!],_15895,_15897) --> 
    cc(n,_15895,_15916),
    point0(_15917,_15916,_15897),
    !.

nr1([nr1,_15904,_15928,!],_15893,_15895) --> 
    number1(_15904,_15893,_15919),
    point0(_15928,_15919,_15895),
    !.

number0([number0,_15903,!],_15892,_15894) --> 
    num(_15875,_15903,_15892,_15894),
    !.

number0([number0,[]],_15887,_15887) --> 
    [].

number1([number1,_15908,_15937],_15897,_15899) --> 
    w(noun(number,sin,_15879,n),_15908,_15897,_15925),
    colon0(_15937,_15925,_15899).

of_course0([of_course0,_15898],_15887,_15889) --> 
    of_course(_15898,_15887,_15889).

of_course0([of_course0,_15906],_15895,_15897) --> 
    not_look_ahead(w(verb(_15876,_15877,_15878)),_15906,_15895,_15897).

of_coursenot0([of_coursenot0,_15903,lit(ikke)],_15892,_15894) --> 
    of_course(_15903,_15892,_15918),
    cc(ikke,_15918,_15894).

of_coursenot0([of_coursenot0,_15906],_15895,_15897) --> 
    not_look_ahead(w(verb(_15876,_15877,_15878)),_15906,_15895,_15897).

of_course([of_course,lit(naturligvis)],_15889,_15891) --> 
    cc(naturligvis,_15889,_15891).

of_course([of_course,lit(selvfølgelig)],_15889,_15891) --> 
    cc(selvfølgelig,_15889,_15891).

of_course([of_course,lit(det),_15920],_15898,_15900) --> 
    cc(det,_15898,_15919),
    w(verb(agree,pres,fin),_15920,_15919,_15900).

of0([of0,_15901,!],_15890,_15892) --> 
    of(_15901,_15890,_15892),
    !.

of0([of0,[]],_15887,_15887) --> 
    [].

of([of,_15900],_15889,_15891) --> 
    prep(of,_15900,_15889,_15891).

of([of,_15900],_15889,_15891) --> 
    prep1(to,_15900,_15889,_15891).

off0([off0,lit(av),!],_15892,_15894) --> 
    cc(av,_15892,_15894),
    !.

off0([off0,[]],_15887,_15887) --> 
    [].

offrom([offrom,lit(av)],_15889,_15891) --> 
    cc(av,_15889,_15891).

offrom([offrom,_15900],_15889,_15891) --> 
    prep1(from,_15900,_15889,_15891).

offrom([offrom,lit(ifra)],_15889,_15891) --> 
    cc(ifra,_15889,_15891).

often([often,_15903],_15892,_15894) --> 
    w(adj2(often,nil),_15903,_15892,_15894).

often([often,lit(ofte)],_15889,_15891) --> 
    cc(ofte,_15889,_15891).

often([often,lit(sjelden)],_15889,_15891) --> 
    cc(sjelden,_15889,_15891).

often([often,lit(jevnlig)],_15889,_15891) --> 
    cc(jevnlig,_15889,_15891).

ofthe([ofthe,_15901,_15925],_15890,_15892) --> 
    of(_15901,_15890,_15916),
    the(_15925,_15916,_15892).

ofthe0([ofthe0,_15898],_15887,_15889) --> 
    ofthe(_15898,_15887,_15889).

ofthe0([ofthe0,[]],_15887,_15887) --> 
    [].

older([older,lit(eldre)],_15889,_15891) --> 
    cc(eldre,_15889,_15891).

on0([on0,_15903,!],_15892,_15894) --> 
    prep1(on,_15903,_15892,_15894),
    !.

on0([on0,[]],_15887,_15887) --> 
    [].

newyear([newyear,_15913,_15942],_15902,_15904) --> 
    w(adj2(new,nil),_15913,_15902,_15930),
    w(noun(year,_15878,_15879,_15880),_15942,_15930,_15904).

newyear([newyear,lit(nyttår)],_15889,_15891) --> 
    cc(nyttår,_15889,_15891).

om0([om0,lit(om),!],_15892,_15894) --> 
    cc(om,_15892,_15894),
    !.

om0([om0,[]],_15887,_15887) --> 
    [].

on0([on0,lit(på),!],_15892,_15894) --> 
    cc(på,_15892,_15894),
    !.

on0([on0,[]],_15887,_15887) --> 
    [].

one([one,_15903],_15892,_15894) --> 
    w(nb(1,num),_15903,_15892,_15894).

one([one,_15898],_15887,_15889) --> 
    a(_15898,_15887,_15889).

only0([only0,lit(bare),!],_15892,_15894) --> 
    cc(bare,_15892,_15894),
    !.

only0([only0,lit(hele),!],_15892,_15894) --> 
    cc(hele,_15892,_15894),
    !.

only0([only0,lit(nesten),!],_15892,_15894) --> 
    cc(nesten,_15892,_15894),
    !.

only0([only0,[]],_15887,_15887) --> 
    [].

or1([or1,lit(eller)],_15889,_15891) --> 
    cc(eller,_15889,_15891).

ordinal(_15872,[ordinal,_15910],_15896,_15898) --> 
    w(nb(_15872,ord),_15910,_15896,_15898).

oter([oter,_15898],_15887,_15889) --> 
    other(_15898,_15887,_15889).

oter([oter,_15898],_15887,_15889) --> 
    others(_15898,_15887,_15889).

other([other,lit(annen)],_15889,_15891) --> 
    cc(annen,_15889,_15891).

other([other,lit(annet)],_15889,_15891) --> 
    cc(annet,_15889,_15891).

others([others,lit(andre)],_15889,_15891) --> 
    cc(andre,_15889,_15891).

own0([own0,lit(egen)],_15889,_15891) --> 
    cc(egen,_15889,_15891).

own0([own0,lit(egne)],_15889,_15891) --> 
    cc(egne,_15889,_15891).

own0([own0,[]],_15887,_15887) --> 
    [].

possible0([possible0,_15906,!],_15895,_15897) --> 
    w(adj2(possible,nil),_15906,_15895,_15897),
    !.

possible0([possible0,[]],_15887,_15887) --> 
    [].

reflexiv0(_15872,[reflexiv0,_15913,!,_15947],_15899,_15901) --> 
    reflexiv(_15872,_15913,_15899,_15930),
    !,
    accept(_15947,_15930,_15901).

reflexiv0(_15872,[reflexiv0,{},!,_15931],_15902,_15904) --> 
    {user:verbtype(_15872,dtv)},
    !,
    accept(_15931,_15902,_15904).

reflexiv0(_15872,[reflexiv0,[]],_15891,_15891) --> 
    [].

reflexiv(ask,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(befind,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(beworry,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(buy,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(change,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(come,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(cost,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(decide,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(feel,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(fit,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(find,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(give,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(go,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(have,[reflexiv,lit(meg)],_15893,_15895) --> 
    cc(meg,_15893,_15895).

reflexiv(have,[reflexiv,lit(seg)],_15893,_15895) --> 
    cc(seg,_15893,_15895).

reflexiv(hurry,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(learn,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(move,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(pass,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(pay2,[reflexiv,lit(seg)],_15893,_15895) --> 
    cc(seg,_15893,_15895).

reflexiv(promise,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(get,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(get,[reflexiv,lit(med)],_15893,_15895) --> 
    cc(med,_15893,_15895).

reflexiv(receive,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(receive,[reflexiv,lit(med)],_15893,_15895) --> 
    cc(med,_15893,_15895).

reflexiv(retire,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(run,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(say,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(send,[reflexiv,_15908,_15932],_15894,_15896) --> 
    to0(_15908,_15894,_15923),
    rfxpron(_15932,_15923,_15896).

reflexiv(show,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(sneak,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(take,[reflexiv,lit(med),_15921],_15896,_15898) --> 
    cc(med,_15896,_15920),
    rfxpron(_15921,_15920,_15898).

reflexiv(take,[reflexiv,lit(med)],_15893,_15895) --> 
    cc(med,_15893,_15895).

reflexiv(take,[reflexiv,_15912,_15941],_15898,_15900) --> 
    not_look_ahead([dere],_15912,_15898,_15929),
    rfxpron(_15941,_15929,_15900).

reflexiv(tell,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(think,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(turn,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(want,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(wish,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(worry,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

reflexiv(write,[reflexiv,_15905],_15891,_15893) --> 
    rfxpron(_15905,_15891,_15893).

rfxpron0([rfxpron0,_15901,!],_15890,_15892) --> 
    rfxpron(_15901,_15890,_15892),
    !.

rfxpron0([rfxpron0,[]],_15887,_15887) --> 
    [].

rfxpron([rfxpron,lit(meg)],_15889,_15891) --> 
    cc(meg,_15889,_15891).

rfxpron([rfxpron,lit(deg)],_15889,_15891) --> 
    cc(deg,_15889,_15891).

rfxpron([rfxpron,lit(seg)],_15889,_15891) --> 
    cc(seg,_15889,_15891).

rfxpron([rfxpron,lit(oss)],_15889,_15891) --> 
    cc(oss,_15889,_15891).

rfxpron([rfxpron,lit(dere)],_15889,_15891) --> 
    cc(dere,_15889,_15891).

rfxpron([rfxpron,lit(selv),_15918],_15896,_15898) --> 
    cc(selv,_15896,_15917),
    not_look_ahead([om],_15918,_15917,_15898).

compassly([compassly,lit(nordfra)],_15889,_15891) --> 
    cc(nordfra,_15889,_15891).

compassly([compassly,lit(nordover)],_15889,_15891) --> 
    cc(nordover,_15889,_15891).

compassly([compassly,lit(sydfra)],_15889,_15891) --> 
    cc(sydfra,_15889,_15891).

compassly([compassly,lit(sydover)],_15889,_15891) --> 
    cc(sydover,_15889,_15891).

compassly([compassly,lit(sørfra)],_15889,_15891) --> 
    cc(sørfra,_15889,_15891).

compassly([compassly,lit(sørover)],_15889,_15891) --> 
    cc(sørover,_15889,_15891).

compassly([compassly,lit(vestfra)],_15889,_15891) --> 
    cc(vestfra,_15889,_15891).

compassly([compassly,lit(vestover)],_15889,_15891) --> 
    cc(vestover,_15889,_15891).

compassly([compassly,lit(østfra)],_15889,_15891) --> 
    cc(østfra,_15889,_15891).

compassly([compassly,lit(østover)],_15889,_15891) --> 
    cc(østover,_15889,_15891).

redundant0x([redundant0x,lit(så)],_15889,_15891) --> 
    cc(så,_15889,_15891).

redundant0x([redundant0x,_15898],_15887,_15889) --> 
    redundants0(_15898,_15887,_15889).

redundant0([redundant0,_15901,!],_15890,_15892) --> 
    redundant(_15901,_15890,_15892),
    !.

redundant0([redundant0,[]],_15887,_15887) --> 
    [].

redundants0([redundants0,_15904,_15928,!],_15893,_15895) --> 
    redundant(_15904,_15893,_15919),
    redundants0(_15928,_15919,_15895),
    !.

redundants0([redundants0,[]],_15887,_15887) --> 
    [].

redundantsx0([redundantsx0,_15904,!,_15933],_15893,_15895) --> 
    redundant(_15904,_15893,_15919),
    !,
    redxxx0(_15933,_15919,_15895).

redundantsx0([redundantsx0,[]],_15887,_15887) --> 
    [].

redxxx0([redxxx0,lit(og),_15917,!],_15895,_15897) --> 
    cc(og,_15895,_15916),
    redundant(_15917,_15916,_15897),
    !.

redxxx0([redxxx0,[]],_15887,_15887) --> 
    [].

redundant([redundant,_15905,!],_15894,_15896) --> 
    w(adv(redundantly),_15905,_15894,_15896),
    !.

redundant([redundant,_15910,_15939],_15899,_15901) --> 
    prep1(in,_15910,_15899,_15927),
    w(noun(average,_15878,_15879,_15880),_15939,_15927,_15901).

redundant([redundant,_15905,lit(allverden)],_15894,_15896) --> 
    prep1(in,_15905,_15894,_15922),
    cc(allverden,_15922,_15896).

redundant([redundant,_15922,lit(det),_15962,_15991],_15911,_15913) --> 
    prep1(in,_15922,_15911,_15939),
    cc(det,_15939,_15961),
    w(adj2(whole,nil),_15962,_15961,_15979),
    w(verb(take,past,part),_15991,_15979,_15913).

redundant([redundant,_15905,lit(hvertfall)],_15894,_15896) --> 
    prep1(in,_15905,_15894,_15922),
    cc(hvertfall,_15922,_15896).

redundant([redundant,_15905,lit(gjen)],_15894,_15896) --> 
    prep1(in,_15905,_15894,_15922),
    cc(gjen,_15922,_15896).

redundant([redundant,_15910,_15939],_15899,_15901) --> 
    prep1(for,_15910,_15899,_15927),
    w(noun(time,sin,def,n),_15939,_15927,_15901).

redundant([redundant,_15919,_15948,_15972,!,_16006],_15908,_15910) --> 
    prep1(from,_15919,_15908,_15936),
    a(_15948,_15936,_15963),
    w(noun(place,sin,u,n),_15972,_15963,_15989),
    !,
    accept(_16006,_15989,_15910).

redundant([redundant,_15908,_15937],_15897,_15899) --> 
    prep1(on,_15908,_15897,_15925),
    w(adj2(new,nil),_15937,_15925,_15899).

redundant([redundant,_15915,lit(en),_15955],_15904,_15906) --> 
    prep1(on,_15915,_15904,_15932),
    cc(en,_15932,_15954),
    w(noun(time_count,sin,u,n),_15955,_15954,_15906).

redundant([redundant,_15903,_15932],_15892,_15894) --> 
    prep1(to,_15903,_15892,_15920),
    slutt(_15932,_15920,_15894).

redundant([redundant,_15905,lit(sammen)],_15894,_15896) --> 
    prep1(to,_15905,_15894,_15922),
    cc(sammen,_15922,_15896).

redundant([redundant,_15920,_15949,_15978],_15909,_15911) --> 
    prep1(to,_15920,_15909,_15937),
    w(adj2(ordinary,nil),_15949,_15937,_15966),
    not_look_ahead(w(noun(time,_15883,_15884,_15885)),_15978,_15966,_15911).

redundant([redundant,_15898],_15887,_15889) --> 
    always(_15898,_15887,_15889).

redundant([redundant,_15898],_15887,_15889) --> 
    aspossible(_15898,_15887,_15889).

redundant([redundant,lit(altså),_15920],_15898,_15900) --> 
    cc(altså,_15898,_15919),
    not_look_ahead_lit([at,å],_15920,_15919,_15900).

redundant([redundant,lit(bare)],_15889,_15891) --> 
    cc(bare,_15889,_15891).

redundant([redundant,lit(da),_15914],_15892,_15894) --> 
    cc(da,_15892,_15913),
    not_look_ahead_np(_15914,_15913,_15894).

redundant([redundant,lit(den),lit(gang)],_15894,_15896) --> 
    cc(den,_15894,_15915),
    cc(gang,_15915,_15896).

redundant([redundant,lit(derfra)],_15889,_15891) --> 
    cc(derfra,_15889,_15891).

redundant([redundant,lit(derfor)],_15889,_15891) --> 
    cc(derfor,_15889,_15891).

redundant([redundant,lit(alene)],_15889,_15891) --> 
    cc(alene,_15889,_15891).

redundant([redundant,lit(bort)],_15889,_15891) --> 
    cc(bort,_15889,_15891).

redundant([redundant,lit(dessverre)],_15889,_15891) --> 
    cc(dessverre,_15889,_15891).

redundant([redundant,lit(egentlig)],_15889,_15891) --> 
    cc(egentlig,_15889,_15891).

redundant([redundant,lit(ellers)],_15889,_15891) --> 
    cc(ellers,_15889,_15891).

redundant([redundant,lit(engang)],_15889,_15891) --> 
    cc(engang,_15889,_15891).

redundant([redundant,lit(enklest),lit(mulig)],_15894,_15896) --> 
    cc(enklest,_15894,_15915),
    cc(mulig,_15915,_15896).

redundant([redundant,lit(enklest)],_15889,_15891) --> 
    cc(enklest,_15889,_15891).

redundant([redundant,lit(ergo)],_15889,_15891) --> 
    cc(ergo,_15889,_15891).

redundant([redundant,lit(farefritt)],_15889,_15891) --> 
    cc(farefritt,_15889,_15891).

redundant([redundant,lit(faktisk)],_15889,_15891) --> 
    cc(faktisk,_15889,_15891).

redundant([redundant,lit(forøvrig)],_15889,_15891) --> 
    cc(forøvrig,_15889,_15891).

redundant([redundant,lit(forøvrig)],_15889,_15891) --> 
    cc(forøvrig,_15889,_15891).

redundant([redundant,lit(fram)],_15889,_15891) --> 
    cc(fram,_15889,_15891).

redundant([redundant,lit(gjerne)],_15889,_15891) --> 
    cc(gjerne,_15889,_15891).

redundant([redundant,lit(heller)],_15889,_15891) --> 
    cc(heller,_15889,_15891).

redundant([redundant,lit(helst)],_15889,_15891) --> 
    cc(helst,_15889,_15891).

redundant([redundant,lit(heldigvis)],_15889,_15891) --> 
    cc(heldigvis,_15889,_15891).

redundant([redundant,lit(herfra)],_15889,_15891) --> 
    cc(herfra,_15889,_15891).

redundant([redundant,lit(jo)],_15889,_15891) --> 
    cc(jo,_15889,_15891).

redundant([redundant,lit(jovisst)],_15889,_15891) --> 
    cc(jovisst,_15889,_15891).

redundant([redundant,lit(ikke),lit(sant)],_15894,_15896) --> 
    cc(ikke,_15894,_15915),
    cc(sant,_15915,_15896).

redundant([redundant,lit(ihvertfall)],_15889,_15891) --> 
    cc(ihvertfall,_15889,_15891).

redundant([redundant,lit(imens)],_15889,_15891) --> 
    cc(imens,_15889,_15891).

redundant([redundant,lit(inne)],_15889,_15891) --> 
    cc(inne,_15889,_15891).

redundant([redundant,lit(kanskje)],_15889,_15891) --> 
    cc(kanskje,_15889,_15891).

redundant([redundant,lit(langt),lit(bort)],_15894,_15896) --> 
    cc(langt,_15894,_15915),
    cc(bort,_15915,_15896).

redundant([redundant,lit(lenge)],_15889,_15891) --> 
    cc(lenge,_15889,_15891).

redundant([redundant,lit(likevel)],_15889,_15891) --> 
    cc(likevel,_15889,_15891).

redundant([redundant,lit(minst)],_15889,_15891) --> 
    cc(minst,_15889,_15891).

redundant([redundant,lit(mon),_15920],_15898,_15900) --> 
    cc(mon,_15898,_15919),
    w(verb(believe,imp,fin),_15920,_15919,_15900).

redundant([redundant,lit(normalt)],_15889,_15891) --> 
    cc(normalt,_15889,_15891).

redundant([redundant,lit(når),lit(som),lit(helst)],_15899,_15901) --> 
    cc(når,_15899,_15920),
    cc(som,_15920,_15931),
    cc(helst,_15931,_15901).

redundant([redundant,lit(også)],_15889,_15891) --> 
    cc(også,_15889,_15891).

redundant([redundant,_15898],_15887,_15889) --> 
    sometimes(_15898,_15887,_15889).

redundant([redundant,lit(om),_15921],_15899,_15901) --> 
    cc(om,_15899,_15920),
    w(noun(time_count,sin,def,n),_15921,_15920,_15901).

redundant([redundant,lit(ad),_15921],_15899,_15901) --> 
    cc(ad,_15899,_15920),
    w(noun(time_count,sin,def,n),_15921,_15920,_15901).

redundant([redundant,lit(sikkert)],_15889,_15891) --> 
    cc(sikkert,_15889,_15891).

redundant([redundant,lit(straks)],_15889,_15891) --> 
    cc(straks,_15889,_15891).

redundant([redundant,lit(selvsagt)],_15889,_15891) --> 
    cc(selvsagt,_15889,_15891).

redundant([redundant,lit(totalt)],_15889,_15891) --> 
    cc(totalt,_15889,_15891).

redundant([redundant,lit(uansett)],_15889,_15891) --> 
    cc(uansett,_15889,_15891).

redundant([redundant,lit(vanligvis)],_15889,_15891) --> 
    cc(vanligvis,_15889,_15891).

redundant([redundant,lit(vel)],_15889,_15891) --> 
    cc(vel,_15889,_15891).

redundant([redundant,lit(videre)],_15889,_15891) --> 
    cc(videre,_15889,_15891).

slutt([slutt,lit(sist)],_15889,_15891) --> 
    cc(sist,_15889,_15891).

slutt([slutt,lit(slutt)],_15889,_15891) --> 
    cc(slutt,_15889,_15891).

please0([please0,_15904,!,_15933],_15893,_15895) --> 
    please(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

please0([please0,lit(bare),!,_15922],_15895,_15897) --> 
    cc(bare,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

please0([please0,[]],_15887,_15887) --> 
    [].

please([please,_15907,_15931,_15955,_15979],_15896,_15898) --> 
    be(_15907,_15896,_15922),
    so(_15931,_15922,_15946),
    good(_15955,_15946,_15970),
    infinitive(_15979,_15970,_15898).

please([please,lit(kan),_15933,_15957,_15981,_16005,lit(å)],_15911,_15913) --> 
    cc(kan,_15911,_15932),
    you(_15933,_15932,_15948),
    be(_15957,_15948,_15972),
    so0(_15981,_15972,_15996),
    w(adj2(good,nil),_16005,_15996,_16022),
    cc(å,_16022,_15913).

slashpoint0([slashpoint0,_15901,!],_15890,_15892) --> 
    slashpoint(_15901,_15890,_15892),
    !.

slashpoint0([slashpoint0,[]],_15887,_15887) --> 
    [].

slashpoint([slashpoint,lit(ende),!],_15892,_15894) --> 
    cc(ende,_15892,_15894),
    !.

slashpoint([slashpoint,lit(/),!],_15892,_15894) --> 
    cc(/,_15892,_15894),
    !.

slashpoint([slashpoint,lit(i),_15924,!],_15902,_15904) --> 
    cc(i,_15902,_15923),
    look_ahead(w(nb(_15884,_15885)),_15924,_15923,_15904),
    !.

slashpoint([slashpoint,lit('.'),lit(i),_15940,!],_15907,_15909) --> 
    cc('.',_15907,_15928),
    cc(i,_15928,_15939),
    look_ahead(w(nb(_15889,_15890)),_15940,_15939,_15909),
    !.

slashpoint([slashpoint,lit('.'),!],_15892,_15894) --> 
    cc('.',_15892,_15894),
    !.

slash([slash,lit(/)],_15889,_15891) --> 
    cc(/,_15889,_15891).

dashpoint0([dashpoint0,_15901,!],_15890,_15892) --> 
    dashpoint(_15901,_15890,_15892),
    !.

dashpoint0([dashpoint0,[]],_15887,_15887) --> 
    [].

dashpoint([dashpoint,lit(-)],_15889,_15891) --> 
    cc(-,_15889,_15891).

dashpoint([dashpoint,lit('.')],_15889,_15891) --> 
    cc('.',_15889,_15891).

point0([point0,_15904,!,_15933],_15893,_15895) --> 
    point(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

point0([point0,[]],_15887,_15887) --> 
    [].

pointNO([pointNO,_15904,!,_15933],_15893,_15895) --> 
    point(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

pointNO([pointNO,{}],_15892,_15892) --> 
    {user:value(nodotflag,true)}.

point([point,lit('.')],_15889,_15891) --> 
    cc('.',_15889,_15891).

itrailer([itrailer,lit(n)],_15889,_15891) --> 
    cc(n,_15889,_15891).

itrailer([itrailer,_15907,lit(når)],_15896,_15898) --> 
    not_look_ahead([n],_15907,_15896,_15924),
    cc(når,_15924,_15898).

itrailer([itrailer,_15910,_15939],_15899,_15901) --> 
    not_look_ahead([n],_15910,_15899,_15927),
    w(adj2(next,nil),_15939,_15927,_15901).

itrailer([itrailer,lit(takk)],_15889,_15891) --> 
    cc(takk,_15889,_15891).

qtrailer0([qtrailer0,lit(?),_15917,!],_15895,_15897) --> 
    cc(?,_15895,_15916),
    qtrailer(_15917,_15916,_15897),
    !.

qtrailer0([qtrailer0,lit('.'),_15917,!],_15895,_15897) --> 
    cc('.',_15895,_15916),
    qtrailer(_15917,_15916,_15897),
    !.

qtrailer0([qtrailer0,lit(a),_15917,!],_15895,_15897) --> 
    cc(a,_15895,_15916),
    qtrailer(_15917,_15916,_15897),
    !.

qtrailer0([qtrailer0,_15901,!],_15890,_15892) --> 
    qtrailer(_15901,_15890,_15892),
    !.

qtrailer0([qtrailer0,[]],_15887,_15887) --> 
    [].

qtrailer([qtrailer,lit(a)],_15889,_15891) --> 
    cc(a,_15889,_15891).

qtrailer([qtrailer,lit(takk)],_15889,_15891) --> 
    cc(takk,_15889,_15891).

qtrailer([qtrailer,_15906,lit(du),_15941],_15895,_15897) --> 
    be(_15906,_15895,_15921),
    cc(du,_15921,_15940),
    good(_15941,_15940,_15897).

qtrailer([qtrailer,lit(ca)],_15889,_15891) --> 
    cc(ca,_15889,_15891).

qtrailer([qtrailer,lit(da)],_15889,_15891) --> 
    cc(da,_15889,_15891).

qtrailer([qtrailer,lit(eller),lit(ikke)],_15894,_15896) --> 
    cc(eller,_15894,_15915),
    cc(ikke,_15915,_15896).

qtrailer([qtrailer,lit(eller)],_15889,_15891) --> 
    cc(eller,_15889,_15891).

qtrailer([qtrailer,_15907,!],_15896,_15898) --> 
    w(name(hal,_15878,_15879),_15907,_15896,_15898),
    !.

qtrailer([qtrailer,_15918,_15962,!],_15907,_15909) --> 
    optional(w(adj2(great,nil)),_15918,_15907,_15950),
    w(noun(oracle,sin,u,n),_15962,_15950,_15909),
    !.

qtrailer([qtrailer,_15922,{},!],_15911,_15913) --> 
    w(noun(_15880,sin,u,n),_15922,_15911,_15913),
    {user:testmember(_15880,[program,oracle,boss])},
    !.

qtrailer([qtrailer,lit(og)],_15889,_15891) --> 
    cc(og,_15889,_15891).

qtrailer([qtrailer,lit(og),lit(når)],_15894,_15896) --> 
    cc(og,_15894,_15915),
    cc(når,_15915,_15896).

qtrailer([qtrailer,lit(lenger),!],_15892,_15894) --> 
    cc(lenger,_15892,_15894),
    !.

qtrailer([qtrailer,lit(lengre),!],_15892,_15894) --> 
    cc(lengre,_15892,_15894),
    !.

qtrailer([qtrailer,lit(så),_15936,lit(du),_15976,!],_15914,_15916) --> 
    cc(så,_15914,_15935),
    w(verb(be,_15889,_15890),_15936,_15935,_15953),
    cc(du,_15953,_15975),
    w(adj2(nice,nil),_15976,_15975,_15916),
    !.

qtrailer([qtrailer,_15904],_15893,_15895) --> 
    w(verb(believe,inf,fin),_15904,_15893,_15895).

qtrailer([qtrailer,_15909,lit(du)],_15898,_15900) --> 
    w(verb(believe,pres,fin),_15909,_15898,_15926),
    cc(du,_15926,_15900).

qtrailer([qtrailer,lit(ø)],_15889,_15891) --> 
    cc(ø,_15889,_15891).

qtrailer([qtrailer,_15907,lit(når)],_15896,_15898) --> 
    not_look_ahead([n],_15907,_15896,_15924),
    cc(når,_15924,_15898).

qtrailer([qtrailer,lit(din),_15931,_15975],_15909,_15911) --> 
    cc(din,_15909,_15930),
    optional(w(adj2(_15891,nil)),_15931,_15930,_15963),
    w(noun(_15880,sin,_15882,_15883),_15975,_15963,_15911).

qtrailer([qtrailer,_15919,{},!],_15908,_15910) --> 
    w(name(_15880,_15881,_15882),_15919,_15908,_15910),
    {user:testmember(_15882,[man,woman])},
    !.

qtrailer([qtrailer,lit(uansett)],_15889,_15891) --> 
    cc(uansett,_15889,_15891).

ctrailer0([ctrailer0,_15901,!],_15890,_15892) --> 
    ctrailer(_15901,_15890,_15892),
    !.

ctrailer0([ctrailer0,[]],_15887,_15887) --> 
    [].

ctrailer([ctrailer,_15898],_15887,_15889) --> 
    please(_15898,_15887,_15889).

ctrailer([ctrailer,lit(takk)],_15889,_15891) --> 
    cc(takk,_15889,_15891).

ctrailer([ctrailer,_15917,lit(du),_15957],_15906,_15908) --> 
    w(verb(be,pres,fin),_15917,_15906,_15934),
    cc(du,_15934,_15956),
    w(adj2(nice,nil),_15957,_15956,_15908).

ctrailer([ctrailer,lit(da)],_15889,_15891) --> 
    cc(da,_15889,_15891).

ctrailer([ctrailer,lit(din),_15931,_15975],_15909,_15911) --> 
    cc(din,_15909,_15930),
    optional(w(adj2(_15891,nil)),_15931,_15930,_15963),
    w(noun(_15880,sin,_15882,_15883),_15975,_15963,_15911).

dtrailer0([dtrailer0,{},_15921,!],_15900,_15902) --> 
    {user:(\+value(dialog,1))},
    dtrailer(_15921,_15900,_15902),
    !.

dtrailer0([dtrailer0,[]],_15887,_15887) --> 
    [].

dtrailer([dtrailer,_15904],_15893,_15895) --> 
    w(name(tore,n,firstname),_15904,_15893,_15895).

dtrailer([dtrailer,_15909,lit(jeg)],_15898,_15900) --> 
    w(verb(think,_15880,fin),_15909,_15898,_15926),
    cc(jeg,_15926,_15900).

dtrailer([dtrailer,_15909,lit(jeg)],_15898,_15900) --> 
    w(verb(mean,_15880,fin),_15909,_15898,_15926),
    cc(jeg,_15926,_15900).

dtrailer([dtrailer,_15904],_15893,_15895) --> 
    w(name(bustuc,_15875,_15876),_15904,_15893,_15895).

dtrailer([dtrailer,lit(ass)],_15889,_15891) --> 
    cc(ass,_15889,_15891).

dtrailer([dtrailer,lit(da)],_15889,_15891) --> 
    cc(da,_15889,_15891).

dtrailer([dtrailer,lit(din),_15931,_15975],_15909,_15911) --> 
    cc(din,_15909,_15930),
    optional(w(adj2(_15891,nil)),_15931,_15930,_15963),
    w(noun(fool,sin,u,n),_15975,_15963,_15911).

dtrailer([dtrailer,lit(du)],_15889,_15891) --> 
    cc(du,_15889,_15891).

dtrailer([dtrailer,lit(eller),lit(hva)],_15894,_15896) --> 
    cc(eller,_15894,_15915),
    cc(hva,_15915,_15896).

dtrailer([dtrailer,lit(eller)],_15889,_15891) --> 
    cc(eller,_15889,_15891).

dtrailer([dtrailer,lit(gitt)],_15889,_15891) --> 
    cc(gitt,_15889,_15891).

dtrailer([dtrailer,lit(hvordan)],_15889,_15891) --> 
    cc(hvordan,_15889,_15891).

dtrailer([dtrailer,lit(hei)],_15889,_15891) --> 
    cc(hei,_15889,_15891).

dtrailer([dtrailer,lit(ja)],_15889,_15891) --> 
    cc(ja,_15889,_15891).

dtrailer([dtrailer,lit(jeg)],_15889,_15891) --> 
    cc(jeg,_15889,_15891).

dtrailer([dtrailer,lit(men),lit(når)],_15894,_15896) --> 
    cc(men,_15894,_15915),
    cc(når,_15915,_15896).

dtrailer([dtrailer,lit(ok)],_15889,_15891) --> 
    cc(ok,_15889,_15891).

dtrailer([dtrailer,lit(sjø)],_15889,_15891) --> 
    cc(sjø,_15889,_15891).

dtrailer([dtrailer,lit(?),lit(takk)],_15894,_15896) --> 
    cc(?,_15894,_15915),
    cc(takk,_15915,_15896).

dtrailer([dtrailer,_15910,lit(hilsen),_15965],_15899,_15901) --> 
    optional([med],_15910,_15899,_15942),
    cc(hilsen,_15942,_15964),
    skip_rest(_15965,_15964,_15901).

posspron(self,[posspron,_15908,_15932],_15894,_15896) --> 
    my(_15908,_15894,_15923),
    own0(_15932,_15923,_15896).

posspron(man,[posspron,lit(hans),_15921],_15896,_15898) --> 
    cc(hans,_15896,_15920),
    own0(_15921,_15920,_15898).

posspron(woman,[posspron,lit(hennes),_15921],_15896,_15898) --> 
    cc(hennes,_15896,_15920),
    own0(_15921,_15920,_15898).

posspron(savant,[posspron,_15905],_15891,_15893) --> 
    your(_15905,_15891,_15893).

posspron(person,[posspron,_15908,_15932],_15894,_15896) --> 
    their(_15908,_15894,_15923),
    own0(_15932,_15923,_15896).

posspron(thing,[posspron,_15905],_15891,_15893) --> 
    sin(_15905,_15891,_15893).

previous([previous,_15903],_15892,_15894) --> 
    w(adj2(previous,nil),_15903,_15892,_15894).

thereafter([thereafter,_15901,_15925],_15890,_15892) --> 
    andor0(_15901,_15890,_15916),
    later(_15925,_15916,_15892).

thereafter([thereafter,_15905,lit(det)],_15894,_15896) --> 
    prep1(after,_15905,_15894,_15922),
    cc(det,_15922,_15896).

thereafter([thereafter,_15905,lit(dette)],_15894,_15896) --> 
    prep1(after,_15905,_15894,_15922),
    cc(dette,_15922,_15896).

thereafter([thereafter,_15905,lit(der)],_15894,_15896) --> 
    prep1(after,_15905,_15894,_15922),
    cc(der,_15922,_15896).

thereafter([thereafter,lit(nest),_15921,lit(der)],_15899,_15901) --> 
    cc(nest,_15899,_15920),
    prep1(after,_15921,_15920,_15938),
    cc(der,_15938,_15901).

thereafter([thereafter,_15905,lit(hvert)],_15894,_15896) --> 
    prep1(after,_15905,_15894,_15922),
    cc(hvert,_15922,_15896).

beforethat([beforethat,lit(derfør)],_15889,_15891) --> 
    cc(derfør,_15889,_15891).

beforethat([beforethat,_15901,_15925],_15890,_15892) --> 
    andor0(_15901,_15890,_15916),
    earlier(_15925,_15916,_15892).

beforethat([beforethat,_15905,lit(det)],_15894,_15896) --> 
    prep1(before,_15905,_15894,_15922),
    cc(det,_15922,_15896).

beforethat([beforethat,_15905,lit(dette)],_15894,_15896) --> 
    prep1(after,_15905,_15894,_15922),
    cc(dette,_15922,_15896).

beforethat([beforethat,_15905,lit(der)],_15894,_15896) --> 
    prep1(after,_15905,_15894,_15922),
    cc(der,_15922,_15896).

beforethat([beforethat,_15905,lit(dette)],_15894,_15896) --> 
    prep1(before,_15905,_15894,_15922),
    cc(dette,_15922,_15896).

beforethat([beforethat,lit(nest),_15921,lit(der)],_15899,_15901) --> 
    cc(nest,_15899,_15920),
    prep1(before,_15921,_15920,_15938),
    cc(der,_15938,_15901).

preperly([preperly,lit(en),lit(del)],_15894,_15896) --> 
    cc(en,_15894,_15915),
    cc(del,_15915,_15896).

preperly([preperly,lit(enda)],_15889,_15891) --> 
    cc(enda,_15889,_15891).

preperly([preperly,lit(ekte)],_15889,_15891) --> 
    cc(ekte,_15889,_15891).

preperly([preperly,lit(litt)],_15889,_15891) --> 
    cc(litt,_15889,_15891).

preperly([preperly,lit(noe)],_15889,_15891) --> 
    cc(noe,_15889,_15891).

preperly([preperly,lit(reellt)],_15889,_15891) --> 
    cc(reellt,_15889,_15891).

preperly([preperly,lit(strengt)],_15889,_15891) --> 
    cc(strengt,_15889,_15891).

preperly([preperly,lit(strikt)],_15889,_15891) --> 
    cc(strikt,_15889,_15891).

preperly([preperly,lit(virkelig)],_15889,_15891) --> 
    cc(virkelig,_15889,_15891).

prep2(after,[prep2,lit(avgang),_15927],_15902,_15904) --> 
    cc(avgang,_15902,_15926),
    not_look_ahead(w(prep(_15881)),_15927,_15926,_15904).

prep2(before,[prep2,lit(ankomst),_15927],_15902,_15904) --> 
    cc(ankomst,_15902,_15926),
    not_look_ahead(w(prep(_15881)),_15927,_15926,_15904).

prep2(after,[prep2,_15910,_15934],_15896,_15898) --> 
    preperly(_15910,_15896,_15925),
    prep1(after,_15934,_15925,_15898).

prep2(after,[prep2,_15918,_15942,lit(enn)],_15904,_15906) --> 
    preperly(_15918,_15904,_15933),
    w(adj2(later,nil),_15942,_15933,_15959),
    cc(enn,_15959,_15906).

prep2(before,[prep2,_15910,_15934],_15896,_15898) --> 
    preperly(_15910,_15896,_15925),
    prep1(before,_15934,_15925,_15898).

prep2(before,[prep2,_15918,_15942,lit(enn)],_15904,_15906) --> 
    preperly(_15918,_15904,_15933),
    w(adj2(earlier,nil),_15942,_15933,_15959),
    cc(enn,_15959,_15906).

prep2(according_to,[prep2,_15912,lit(følge)],_15898,_15900) --> 
    prep1(in,_15912,_15898,_15929),
    cc(følge,_15929,_15900).

prep2(after,[prep2,_15910,_15934],_15896,_15898) --> 
    clock(_15910,_15896,_15925),
    prep1(after,_15934,_15925,_15898).

prep2(after,[prep2,_15910,_15934],_15896,_15898) --> 
    around1(_15910,_15896,_15925),
    prep1(after,_15934,_15925,_15898).

prep2(after,[prep2,lit(ca),_15923],_15898,_15900) --> 
    cc(ca,_15898,_15922),
    prep1(after,_15923,_15922,_15900).

prep2(after,[prep2,_15910,_15939],_15896,_15898) --> 
    prep1(after,_15910,_15896,_15927),
    around1(_15939,_15927,_15898).

prep2(after,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(from,_15912,_15898,_15929),
    prep1(after,_15941,_15929,_15900).

prep2(after,[prep2,_15919,_15948,_15977],_15905,_15907) --> 
    prep1(to,_15919,_15905,_15936),
    not_look_ahead([e],_15948,_15936,_15965),
    prep1(after,_15977,_15965,_15907).

prep2(after,[prep2,_15917,lit(og),_15957],_15903,_15905) --> 
    prep1(from,_15917,_15903,_15934),
    cc(og,_15934,_15956),
    prep1(with,_15957,_15956,_15905).

prep2(after,[prep2,lit(like),_15923],_15898,_15900) --> 
    cc(like,_15898,_15922),
    prep1(after,_15923,_15922,_15900).

prep2(after,[prep2,_15910,_15934],_15896,_15898) --> 
    not(_15910,_15896,_15925),
    prep(before,_15934,_15925,_15898).

prep2(after,[prep2,lit(senere),lit(enn)],_15898,_15900) --> 
    cc(senere,_15898,_15922),
    cc(enn,_15922,_15900).

prep2(after,[prep2,lit(resten),_15923],_15898,_15900) --> 
    cc(resten,_15898,_15922),
    prep1(off,_15923,_15922,_15900).

prep2(around,[prep2,_15908,_15932],_15894,_15896) --> 
    around1(_15908,_15894,_15923),
    around0(_15932,_15923,_15896).

prep2(at,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(in,_15912,_15898,_15929),
    prep1(at,_15941,_15929,_15900).

prep2(at,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(on,_15912,_15898,_15929),
    prep1(at,_15941,_15929,_15900).

prep2(at,[prep2,_15922,_15951,lit(av)],_15908,_15910) --> 
    prep1(at,_15922,_15908,_15939),
    w(noun(side,_15887,_15888,_15889),_15951,_15939,_15968),
    cc(av,_15968,_15910).

prep2(before,[prep2,lit(for),_15928],_15903,_15905) --> 
    cc(for,_15903,_15927),
    look_ahead(w(nb(_15881,num)),_15928,_15927,_15905).

prep2(before,[prep2,_15920,_15949,!],_15906,_15908) --> 
    w(noun(arrival,sin,u,n),_15920,_15906,_15937),
    prep1(before,_15949,_15937,_15908),
    !.

prep2(before,[prep2,_15910,_15939],_15896,_15898) --> 
    prep1(before,_15910,_15896,_15927),
    ca(_15939,_15927,_15898).

prep2(before,[prep2,lit(like),_15923],_15898,_15900) --> 
    cc(like,_15898,_15922),
    prep1(before,_15923,_15922,_15900).

prep2(before,[prep2,_15910,_15934],_15896,_15898) --> 
    not(_15910,_15896,_15925),
    prep(after,_15934,_15925,_15898).

prep2(before,[prep2,lit(senest),_15923],_15898,_15900) --> 
    cc(senest,_15898,_15922),
    prep1(before,_15923,_15922,_15900).

prep2(before,[prep2,lit(senest)],_15893,_15895) --> 
    cc(senest,_15893,_15895).

prep2(before,[prep2,_15915,_15944],_15901,_15903) --> 
    w(adj2(present,nil),_15915,_15901,_15932),
    prep1(before,_15944,_15932,_15903).

prep2(before,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(to,_15912,_15898,_15929),
    prep1(before,_15941,_15929,_15900).

prep2(before,[prep2,_15912,lit(ca)],_15898,_15900) --> 
    prep1(to,_15912,_15898,_15929),
    cc(ca,_15929,_15900).

prep2(between,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(from,_15912,_15898,_15929),
    prep1(between,_15941,_15929,_15900).

prep2(between,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(in,_15912,_15898,_15929),
    prep1(between,_15941,_15929,_15900).

prep2(between,[prep2,_15920,_15944,_15973],_15906,_15908) --> 
    a0(_15920,_15906,_15935),
    w(noun(place,_15885,_15886,n),_15944,_15935,_15961),
    prep1(between,_15973,_15961,_15908).

prep2(during,[prep2,_15917,lit(løpet),lit(av)],_15903,_15905) --> 
    prep1(in,_15917,_15903,_15934),
    cc(løpet,_15934,_15956),
    cc(av,_15956,_15905).

prep2(during2,[prep2,lit(om),_15921],_15896,_15898) --> 
    cc(om,_15896,_15920),
    ca(_15921,_15920,_15898).

prep2(from,[prep2,_15910,_15939],_15896,_15898) --> 
    prep1(from,_15910,_15896,_15927),
    colon0(_15939,_15927,_15898).

prep2(from,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(from,_15912,_15898,_15929),
    prep1(near,_15941,_15929,_15900).

prep2(from,[prep2,_15926,_15955,_15984,!,_16018],_15912,_15914) --> 
    prep1(from,_15926,_15912,_15943),
    w(adj2(up,nil),_15955,_15943,_15972),
    prep1(at,_15984,_15972,_16001),
    !,
    accept(_16018,_16001,_15914).

prep2(from,[prep2,_15918,_15947,!,_15981],_15904,_15906) --> 
    prep1(from,_15918,_15904,_15935),
    prep1(from,_15947,_15935,_15964),
    !,
    accept(_15981,_15964,_15906).

prep2(from,[prep2,lit(med),_15923],_15898,_15900) --> 
    cc(med,_15898,_15922),
    prep1(from,_15923,_15922,_15900).

prep2(from,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(in,_15912,_15898,_15929),
    prep1(from,_15941,_15929,_15900).

prep2(from,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(over,_15912,_15898,_15929),
    prep1(from,_15941,_15929,_15900).

prep2(from,[prep2,lit(ifra)],_15893,_15895) --> 
    cc(ifra,_15893,_15895).

prep2(from,[prep2,lit(inn),_15923],_15898,_15900) --> 
    cc(inn,_15898,_15922),
    prep1(from,_15923,_15922,_15900).

prep2(from,[prep2,lit(ut),_15921],_15896,_15898) --> 
    cc(ut,_15896,_15920),
    offrom(_15921,_15920,_15898).

prep2(from,[prep2,_15922,_15951,_15980],_15908,_15910) --> 
    prep1(with,_15922,_15908,_15939),
    w(noun(start,sin,_15888,_15889),_15951,_15939,_15968),
    prep1(in,_15980,_15968,_15910).

prep2(from,[prep2,_15910,_15934],_15896,_15898) --> 
    umpover(_15910,_15896,_15925),
    prep1(from,_15934,_15925,_15898).

prep2(from,[prep2,_15922,_15951,lit(nærheten),lit(av)],_15908,_15910) --> 
    prep1(from,_15922,_15908,_15939),
    prep1(in,_15951,_15939,_15968),
    cc(nærheten,_15968,_15990),
    cc(av,_15990,_15910).

prep2(in,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(around,_15912,_15898,_15929),
    prep1(in,_15941,_15929,_15900).

prep2(in,[prep2,lit(inne),_15923],_15898,_15900) --> 
    cc(inne,_15898,_15922),
    prep1(in,_15923,_15922,_15900).

prep2(in,[prep2,lit(nede),_15923],_15898,_15900) --> 
    cc(nede,_15898,_15922),
    prep1(in,_15923,_15922,_15900).

prep2(instead_of,[prep2,lit(i),lit(stedet),lit(for)],_15903,_15905) --> 
    cc(i,_15903,_15927),
    cc(stedet,_15927,_15938),
    cc(for,_15938,_15905).

prep2(near,[prep2,_15913,_15937,_15966],_15899,_15901) --> 
    so0(_15913,_15899,_15928),
    prep1(near,_15937,_15928,_15954),
    to0(_15966,_15954,_15901).

prep2(near,[prep2,_15917,lit(nærheten),lit(av)],_15903,_15905) --> 
    prep1(in,_15917,_15903,_15934),
    cc(nærheten,_15934,_15956),
    cc(av,_15956,_15905).

prep2(near,[prep2,lit(like),_15923],_15898,_15900) --> 
    cc(like,_15898,_15922),
    prep1(at,_15923,_15922,_15900).

prep2(near,[prep2,_15919,_15943,_15972,_15996],_15905,_15907) --> 
    and0(_15919,_15905,_15934),
    w(adj2(nearest,nil),_15943,_15934,_15960),
    possible0(_15972,_15960,_15987),
    to0(_15996,_15987,_15907).

prep2(near,[prep2,_15915,_15944],_15901,_15903) --> 
    w(adj2(near,nil),_15915,_15901,_15932),
    prep1(at,_15944,_15932,_15903).

prep2(near,[prep2,_15920,lit(eller),_15960],_15906,_15908) --> 
    prep1(to,_15920,_15906,_15937),
    cc(eller,_15937,_15959),
    w(adj2(near,nil),_15960,_15959,_15908).

prep2(near,[prep2,_15920,lit(eller),_15960],_15906,_15908) --> 
    prep1(past,_15920,_15906,_15937),
    cc(eller,_15937,_15959),
    w(adj2(near,nil),_15960,_15959,_15908).

prep2(on,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(in,_15912,_15898,_15929),
    prep1(on,_15941,_15929,_15900).

prep2(on,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(with,_15912,_15898,_15929),
    prep1(on,_15941,_15929,_15900).

prep2(on,[prep2,_15921,lit(midt),_15956,!,_15990],_15907,_15909) --> 
    ca0(_15921,_15907,_15936),
    cc(midt,_15936,_15955),
    prep1(on,_15956,_15955,_15973),
    !,
    accept(_15990,_15973,_15909).

prep2(on,[prep2,lit(nede),_15923],_15898,_15900) --> 
    cc(nede,_15898,_15922),
    prep1(on,_15923,_15922,_15900).

prep2(out_of,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(to,_15912,_15898,_15929),
    prep1(outside,_15941,_15929,_15900).

prep2(outside,[prep2,lit(ikke),_15923],_15898,_15900) --> 
    cc(ikke,_15898,_15922),
    prep1(past,_15923,_15922,_15900).

prep2(outside,[prep2,lit(ikke),_15923],_15898,_15900) --> 
    cc(ikke,_15898,_15922),
    prep1(to,_15923,_15922,_15900).

prep2(over,[prep2,lit(litt),_15923],_15898,_15900) --> 
    cc(litt,_15898,_15922),
    prep1(over,_15923,_15922,_15900).

prep2(over,[prep2,_15912,lit(hvilke)],_15898,_15900) --> 
    prep1(over,_15912,_15898,_15929),
    cc(hvilke,_15929,_15900).

prep2(past,[prep2,lit(og),lit(ned)],_15898,_15900) --> 
    cc(og,_15898,_15922),
    cc(ned,_15922,_15900).

prep2(past,[prep2,lit(og),_15923],_15898,_15900) --> 
    cc(og,_15898,_15922),
    prep1(past,_15923,_15922,_15900).

prep2(past,[prep2,lit(ned)],_15893,_15895) --> 
    cc(ned,_15893,_15895).

prep2(past,[prep2,_15927,lit(/),_15967,lit(nærheten),lit(av)],_15913,_15915) --> 
    prep1(past,_15927,_15913,_15944),
    cc(/,_15944,_15966),
    prep1(in,_15967,_15966,_15984),
    cc(nærheten,_15984,_16006),
    cc(av,_16006,_15915).

prep2(past,[prep2,_15927,lit(eller),_15967,lit(nærheten),lit(av)],_15913,_15915) --> 
    prep1(past,_15927,_15913,_15944),
    cc(eller,_15944,_15966),
    prep1(in,_15967,_15966,_15984),
    cc(nærheten,_15984,_16006),
    cc(av,_16006,_15915).

prep2(past,[prep2,_15923,lit(/),_15963,!,_15997],_15909,_15911) --> 
    prep1(to,_15923,_15909,_15940),
    cc(/,_15940,_15962),
    prep1(from,_15963,_15962,_15980),
    !,
    accept(_15997,_15980,_15911).

prep2(past,[prep2,_15921,_15950,_15974,!,_16008],_15907,_15909) --> 
    prep1(to,_15921,_15907,_15938),
    and0(_15950,_15938,_15965),
    prep1(from,_15974,_15965,_15991),
    !,
    accept(_16008,_15991,_15909).

prep2(past,[prep2,_15921,_15950,_15974,!,_16008],_15907,_15909) --> 
    prep1(from,_15921,_15907,_15938),
    and1(_15950,_15938,_15965),
    prep1(to,_15974,_15965,_15991),
    !,
    accept(_16008,_15991,_15909).

prep2(past,[prep2,_15917,_15946],_15903,_15905) --> 
    prep1(with,_15917,_15903,_15934),
    w(noun(departure,_15880,_15881,_15882),_15946,_15934,_15905).

prep2(past,[prep2,_15917,lit(/),_15957],_15903,_15905) --> 
    prep1(past,_15917,_15903,_15934),
    cc(/,_15934,_15956),
    prep1(past,_15957,_15956,_15905).

prep2(to,[prep2,_15910,_15939],_15896,_15898) --> 
    prep1(to,_15910,_15896,_15927),
    colon0(_15939,_15927,_15898).

prep2(to,[prep2,_15918,_15947,!,_15981],_15904,_15906) --> 
    prep1(to,_15918,_15904,_15935),
    prep1(to,_15947,_15935,_15964),
    !,
    accept(_15981,_15964,_15906).

prep2(to,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(to,_15912,_15898,_15929),
    prep1(near,_15941,_15929,_15900).

prep2(to,[prep2,_15922,_15951,_15980],_15908,_15910) --> 
    prep1(in,_15922,_15908,_15939),
    w(noun(connection,_15887,u,n),_15951,_15939,_15968),
    prep1(with,_15980,_15968,_15910).

prep2(to,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(over,_15912,_15898,_15929),
    prep1(to,_15941,_15929,_15900).

prep2(to,[prep2,_15917,_15946],_15903,_15905) --> 
    prep1(with,_15917,_15903,_15934),
    w(noun(arrival,_15880,_15881,_15882),_15946,_15934,_15905).

prep2(to,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(with,_15912,_15898,_15929),
    prep1(to,_15941,_15929,_15900).

prep2(to,[prep2,_15910,_15934],_15896,_15898) --> 
    andsoon(_15910,_15896,_15925),
    prep1(to,_15934,_15925,_15898).

prep2(to,[prep2,lit(hjem),_15923],_15898,_15900) --> 
    cc(hjem,_15898,_15922),
    prep1(to,_15923,_15922,_15900).

prep2(to,[prep2,lit(inn),_15923],_15898,_15900) --> 
    cc(inn,_15898,_15922),
    prep1(to,_15923,_15922,_15900).

prep2(to,[prep2,lit(ned),_15923],_15898,_15900) --> 
    cc(ned,_15898,_15922),
    prep1(to,_15923,_15922,_15900).

prep2(to,[prep2,lit(opp),_15923],_15898,_15900) --> 
    cc(opp,_15898,_15922),
    prep1(to,_15923,_15922,_15900).

prep2(to,[prep2,lit(tur),lit(retur)],_15898,_15900) --> 
    cc(tur,_15898,_15922),
    cc(retur,_15922,_15900).

prep2(to,[prep2,_15910,_15934],_15896,_15898) --> 
    umpover(_15910,_15896,_15925),
    prep1(to,_15934,_15925,_15898).

prep2(towards,[prep2,lit(inn),_15923],_15898,_15900) --> 
    cc(inn,_15898,_15922),
    prep1(towards,_15923,_15922,_15900).

prep2(towards,[prep2,lit(ut),_15923],_15898,_15900) --> 
    cc(ut,_15898,_15922),
    prep1(towards,_15923,_15922,_15900).

prep2(towards,[prep2,lit(ned),_15923],_15898,_15900) --> 
    cc(ned,_15898,_15922),
    prep1(towards,_15923,_15922,_15900).

prep2(towards,[prep2,_15910,_15934],_15896,_15898) --> 
    umpover(_15910,_15896,_15925),
    prep1(towards,_15934,_15925,_15898).

prep2(until,[prep2,_15905],_15891,_15893) --> 
    until(_15905,_15891,_15893).

prep2(with,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(with,_15912,_15898,_15929),
    prep1(on,_15941,_15929,_15900).

prep2(with,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(with,_15912,_15898,_15929),
    prep1(in,_15941,_15929,_15900).

prep2(with,[prep2,_15913,lit(bruk),_15948],_15899,_15901) --> 
    by(_15913,_15899,_15928),
    cc(bruk,_15928,_15947),
    of(_15948,_15947,_15901).

prep2(within,[prep2,_15912,_15941],_15898,_15900) --> 
    prep1(on,_15912,_15898,_15929),
    prep1(under,_15941,_15929,_15900).

prep2(without,[prep2,lit(fri),lit(for)],_15898,_15900) --> 
    cc(fri,_15898,_15922),
    cc(for,_15922,_15900).

umpover([umpover,lit(opp),_15916],_15894,_15896) --> 
    cc(opp,_15894,_15915),
    prep1(over,_15916,_15915,_15896).

umpover([umpover,lit(bort)],_15889,_15891) --> 
    cc(bort,_15889,_15891).

umpover([umpover,_15900],_15889,_15891) --> 
    prep1(over,_15900,_15889,_15891).

umpover([umpover,lit(bortover)],_15889,_15891) --> 
    cc(bortover,_15889,_15891).

umpover([umpover,lit(utover)],_15889,_15891) --> 
    cc(utover,_15889,_15891).

umpover([umpover,lit(innover)],_15889,_15891) --> 
    cc(innover,_15889,_15891).

umpover([umpover,lit(oppover)],_15889,_15891) --> 
    cc(oppover,_15889,_15891).

umpover([umpover,lit(nedover)],_15889,_15891) --> 
    cc(nedover,_15889,_15891).

umpover([umpover,lit(hitover)],_15889,_15891) --> 
    cc(hitover,_15889,_15891).

umpover([umpover,_15910,_15939],_15899,_15901) --> 
    prep1(on,_15910,_15899,_15927),
    w(noun(route,sin,_15879,n),_15939,_15927,_15901).

umpover([umpover,_15910,_15939],_15899,_15901) --> 
    prep1(on,_15910,_15899,_15927),
    w(noun(direction,sin,_15879,n),_15939,_15927,_15901).

pronoun1(_15872,[pronoun1,lit(de),!,_15929],_15899,_15901) --> 
    cc(de,_15899,_15923),
    !,
    reject(_15929,_15923,_15901).

pronoun1(_15872,[pronoun1,lit(en),!,_15929],_15899,_15901) --> 
    cc(en,_15899,_15923),
    !,
    reject(_15929,_15923,_15901).

pronoun1(_15872,[pronoun1,_15907],_15893,_15895) --> 
    pronoun(_15872,_15907,_15893,_15895).

pronoun(thing,[pronoun,_15920,_15949,!,_15978],_15906,_15908) --> 
    one_of_lit([noe,det],_15920,_15906,_15937),
    not_look_ahead_np(_15949,_15937,_15964),
    !,
    accept(_15978,_15964,_15908).

pronoun(thing,[pronoun,lit(det),_15949,_15973,_16002,!,_16036],_15924,_15926) --> 
    cc(det,_15924,_15948),
    look_ahead_vp(_15949,_15948,_15964),
    not_look_ahead(w(adj2(_15895,_15896)),_15973,_15964,_15990),
    not_look_ahead(w(noun(_15902,_15903,_15904,_15905)),_16002,_15990,_16019),
    !,
    accept(_16036,_16019,_15926).

pronoun(agent,[pronoun,lit(man)],_15893,_15895) --> 
    cc(man,_15893,_15895).

pronoun(self,[pronoun,lit(jeg),_15936,_15965],_15911,_15913) --> 
    cc(jeg,_15911,_15935),
    not_look_ahead(['.'],_15936,_15935,_15953),
    not_look_ahead(w(name(_15884,_15885,_15886)),_15965,_15953,_15913).

pronoun(self,[pronoun,lit(meg)],_15893,_15895) --> 
    cc(meg,_15893,_15895).

pronoun(vehicle,[pronoun,lit(den),_15929,{}],_15904,_15906) --> 
    cc(den,_15904,_15928),
    not_look_ahead_np(_15929,_15928,_15906),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(de),_15929,{}],_15904,_15906) --> 
    cc(de,_15904,_15928),
    not_look_ahead_np(_15929,_15928,_15906),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(_15882),{},_15954,!],_15919,_15921) --> 
    cc(_15882,_15919,_15943),
    {user:testmember(_15882,[den,det,en,et])},
    look_ahead([som],_15954,_15943,_15921),
    !.

pronoun(_15872,[pronoun,lit(_15886),{},_15949],_15914,_15916) --> 
    cc(_15886,_15914,_15938),
    {dict_n:pronoun(_15886,_15872)},
    not_look_ahead(w(nb(_15884,_15885)),_15949,_15938,_15916).

pronoun(thing,[pronoun,lit(dette),_15946,_15975,!,_16009],_15921,_15923) --> 
    cc(dette,_15921,_15945),
    not_look_ahead(w(adj2(_15892,_15893)),_15946,_15945,_15963),
    not_look_ahead(w(noun(_15899,_15900,_15901,_15902)),_15975,_15963,_15992),
    !,
    accept(_16009,_15992,_15923).

pronoun(thing,[pronoun,lit(denne),_15927,!,_15956],_15902,_15904) --> 
    cc(denne,_15902,_15926),
    not_look_ahead_np(_15927,_15926,_15942),
    !,
    accept(_15956,_15942,_15904).

pronoun(agent,[pronoun,lit(vi)],_15893,_15895) --> 
    cc(vi,_15893,_15895).

pronoun(savant,[pronoun,lit(du)],_15893,_15895) --> 
    cc(du,_15893,_15895).

pronoun(agent,[pronoun,lit(dere)],_15893,_15895) --> 
    cc(dere,_15893,_15895).

quant_pron(some,person,[quant_pron,lit(en),_15938,!],_15910,_15912) --> 
    cc(en,_15910,_15937),
    look_ahead(w(verb(_15887,_15888,_15889)),_15938,_15937,_15912),
    !.

quant_pron(some,thing,[quant_pron,lit(mye),_15930,!],_15902,_15904) --> 
    cc(mye,_15902,_15929),
    not_look_ahead_np(_15930,_15929,_15904),
    !.

quant_pron(every,person,[quant_pron,_15923,lit(alle),_15963],_15906,_15908) --> 
    not_look_ahead([hver],_15923,_15906,_15940),
    cc(alle,_15940,_15962),
    not_look_ahead_np(_15963,_15962,_15908).

quant_pron(every,thing,[quant_pron,_15927,lit(alt),_15967],_15910,_15912) --> 
    not_look_ahead(w(name(_15885,_15886,_15887)),_15927,_15910,_15944),
    cc(alt,_15944,_15966),
    sammen0(_15967,_15966,_15912).

quant_pron(some,person,[quant_pron,lit(den),_15934,!],_15906,_15908) --> 
    cc(den,_15906,_15933),
    look_ahead([som],_15934,_15933,_15908),
    !.

quant_pron(some,thing,[quant_pron,lit(det),_15934,!],_15906,_15908) --> 
    cc(det,_15906,_15933),
    look_ahead([som],_15934,_15933,_15908),
    !.

quant_pron(some,person,[quant_pron,lit(man)],_15896,_15898) --> 
    cc(man,_15896,_15898).

quant_pron(some,thing,[quant_pron,lit(mer),_15931],_15903,_15905) --> 
    cc(mer,_15903,_15930),
    not_look_ahead([enn],_15931,_15930,_15905).

quant_pron(some,thing,[quant_pron,lit(noe)],_15896,_15898) --> 
    cc(noe,_15896,_15898).

quant_pron(some,agent,[quant_pron,lit(noen),_15937,_15961],_15909,_15911) --> 
    cc(noen,_15909,_15936),
    avdem0(_15937,_15936,_15952),
    not_look_ahead(w(adj(_15885,_15886)),_15961,_15952,_15911).

avdem0([avdem0,lit(av),lit(våre),!,_15938],_15900,_15902) --> 
    cc(av,_15900,_15921),
    cc(våre,_15921,_15932),
    !,
    reject(_15938,_15932,_15902).

avdem0([avdem0,lit(av),lit(dem),!],_15897,_15899) --> 
    cc(av,_15897,_15918),
    cc(dem,_15918,_15899),
    !.

avdem0([avdem0,[]],_15887,_15887) --> 
    [].

quant_pron(some,vehicle,[quant_pron,lit(noen),_15931],_15903,_15905) --> 
    cc(noen,_15903,_15930),
    not_look_ahead([av],_15931,_15930,_15905).

quant_pron(some,agent,[quant_pron,_15911],_15894,_15896) --> 
    someone(_15911,_15894,_15896).

quant_pron(some,thing,[quant_pron,_15922,_15946],_15905,_15907) --> 
    something(_15922,_15905,_15937),
    not_look_ahead(w(verb(_15882,_15883,pass)),_15946,_15937,_15907).

quant_pron(no,person,[quant_pron,lit(ingen),_15927],_15899,_15901) --> 
    cc(ingen,_15899,_15926),
    not_look_ahead_np(_15927,_15926,_15901).

quant_pron(no,thing,[quant_pron,lit(intet),_15936],_15908,_15910) --> 
    cc(intet,_15908,_15935),
    not_look_ahead(w(noun(_15882,_15883,_15884,_15885)),_15936,_15935,_15910).

quant_pron(no,thing,[quant_pron,lit(ingen),lit(ting)],_15901,_15903) --> 
    cc(ingen,_15901,_15928),
    cc(ting,_15928,_15903).

quant_pron(no,thing,[quant_pron,lit(ingenting)],_15896,_15898) --> 
    cc(ingenting,_15896,_15898).

quant_pron(much,thing,[quant_pron,_15921,_15945],_15904,_15906) --> 
    somuch(_15921,_15904,_15936),
    not_look_ahead(w(adj2(_15882,nil)),_15945,_15936,_15906).

quant_pron(little,thing,[quant_pron,_15937,_15966,_15990,_16019],_15920,_15922) --> 
    not_look_ahead(w(adv(_15895)),_15937,_15920,_15954),
    solittle(_15966,_15954,_15981),
    not_look_ahead([å],_15990,_15981,_16007),
    not_look_ahead(w(adj2(late,nil)),_16019,_16007,_15922).

quant_pron(some,feeling,[quant_pron,_15911],_15894,_15896) --> 
    somegood(_15911,_15894,_15896).

denbussen([denbussen,lit(den),_15925,!,_15959],_15903,_15905) --> 
    cc(den,_15903,_15924),
    w(adj2(_15885,nil),_15925,_15924,_15942),
    !,
    reject(_15959,_15942,_15905).

denbussen([denbussen,lit(den)],_15889,_15891) --> 
    cc(den,_15889,_15891).

sammen0([sammen0,lit(sammen),!],_15892,_15894) --> 
    cc(sammen,_15892,_15894),
    !.

sammen0([sammen0,_15906,!],_15895,_15897) --> 
    w(adj2(possible,nil),_15906,_15895,_15897),
    !.

sammen0([sammen0,[]],_15887,_15887) --> 
    [].

somuch([somuch,_15901,_15925],_15890,_15892) --> 
    so0(_15901,_15890,_15916),
    much(_15925,_15916,_15892).

solittle([solittle,_15901,_15925],_15890,_15892) --> 
    so0(_15901,_15890,_15916),
    little(_15925,_15916,_15892).

quant0(_15872,[quant0,_15913,!,_15947],_15899,_15901) --> 
    quant1(_15872,_15913,_15899,_15930),
    !,
    accept(_15947,_15930,_15901).

quant0(1,[quant0,[]],_15891,_15891) --> 
    [].

quant1(+(_15874),[quant1,_15912],_15898,_15900) --> 
    w(nb(_15874,num),_15912,_15898,_15900).

quant1(-(_15874),[quant1,_15909],_15895,_15897) --> 
    ordinal(_15874,_15909,_15895,_15897).

recently([recently,lit(nylig)],_15889,_15891) --> 
    cc(nylig,_15889,_15891).

recently([recently,_15908,lit(det),_15948],_15897,_15899) --> 
    prep1(in,_15908,_15897,_15925),
    cc(det,_15925,_15947),
    latest(_15948,_15947,_15899).

everything([everything,_15911,lit(alt)],_15900,_15902) --> 
    not_look_ahead(w(name(_15881,_15882,_15883)),_15911,_15900,_15928),
    cc(alt,_15928,_15902).

something([something,lit(noe),lit(mer),!,_15938],_15900,_15902) --> 
    cc(noe,_15900,_15921),
    cc(mer,_15921,_15932),
    !,
    accept(_15938,_15932,_15902).

something([something,lit(noe),lit(som),lit(helst),!,_15954],_15905,_15907) --> 
    cc(noe,_15905,_15926),
    cc(som,_15926,_15937),
    cc(helst,_15937,_15948),
    !,
    accept(_15954,_15948,_15907).

something([something,lit(noe)],_15889,_15891) --> 
    cc(noe,_15889,_15891).

something([something,lit(det),_15917,!],_15895,_15897) --> 
    cc(det,_15895,_15916),
    endofline(_15917,_15916,_15897),
    !.

something([something,lit(det),_15930,_15959],_15908,_15910) --> 
    cc(det,_15908,_15929),
    not_look_ahead([å],_15930,_15929,_15947),
    not_look_ahead(w(noun(_15882,_15883,_15884,_15885)),_15959,_15947,_15910).

somegood([somegood,lit(det),_15925,_15949,!],_15903,_15905) --> 
    cc(det,_15903,_15924),
    so0(_15925,_15924,_15940),
    w(adj2(good,nil),_15949,_15940,_15905),
    !.

somegood([somegood,lit(det),_15925,_15949,!],_15903,_15905) --> 
    cc(det,_15903,_15924),
    so0(_15925,_15924,_15940),
    w(adj2(bad,nil),_15949,_15940,_15905),
    !.

sometimes0([sometimes0,_15900],_15889,_15891) --> 
    optional(sometimes,_15900,_15889,_15891).

sometimes([sometimes,lit(noen),_15927,!,_15961],_15905,_15907) --> 
    cc(noen,_15905,_15926),
    w(noun(time_count,_15886,_15887,_15888),_15927,_15926,_15944),
    !,
    accept(_15961,_15944,_15907).

sometimes([sometimes,lit(tidvis)],_15889,_15891) --> 
    cc(tidvis,_15889,_15891).

sometimes0([sometimes0,[]],_15887,_15887) --> 
    [].

notrel([notrel,_15908,!,_15942],_15897,_15899) --> 
    look_ahead([som],_15908,_15897,_15925),
    !,
    reject(_15942,_15925,_15899).

notrel([notrel,[]],_15887,_15887) --> 
    [].

relpron(thing,[relpron,lit(som),_15921],_15896,_15898) --> 
    cc(som,_15896,_15920),
    also0(_15921,_15920,_15898).

recipron(man,[recipron,lit(han),_15921],_15896,_15898) --> 
    cc(han,_15896,_15920),
    self(_15921,_15920,_15898).

recipron(person,[recipron,lit(seg),_15921],_15896,_15898) --> 
    cc(seg,_15896,_15920),
    self(_15921,_15920,_15898).

recipron(woman,[recipron,lit(henne),_15921],_15896,_15898) --> 
    cc(henne,_15896,_15920),
    self(_15921,_15920,_15898).

recipron(thing,[recipron,lit(seg),_15921],_15896,_15898) --> 
    cc(seg,_15896,_15920),
    self0(_15921,_15920,_15898).

recipron(thing,[recipron,lit(hverandre)],_15893,_15895) --> 
    cc(hverandre,_15893,_15895).

same([same,lit(samme)],_15889,_15891) --> 
    cc(samme,_15889,_15891).

self0([self0,_15898],_15887,_15889) --> 
    self(_15898,_15887,_15889).

self0([self0,[]],_15887,_15887) --> 
    [].

self([self,lit(selv)],_15889,_15891) --> 
    cc(selv,_15889,_15891).

set([set,_15905],_15894,_15896) --> 
    w(noun(set,_15875,_15876,n),_15905,_15894,_15896).

setlist([setlist,_15898],_15887,_15889) --> 
    set(_15898,_15887,_15889).

setlist([setlist,_15905],_15894,_15896) --> 
    w(noun(list,_15875,_15876,n),_15905,_15894,_15896).

several([several,lit(fler)],_15889,_15891) --> 
    cc(fler,_15889,_15891).

several([several,lit(flere)],_15889,_15891) --> 
    cc(flere,_15889,_15891).

several([several,lit(mer),lit(enn),_15930],_15897,_15899) --> 
    cc(mer,_15897,_15918),
    cc(enn,_15918,_15929),
    one(_15930,_15929,_15899).

sin([sin,lit(sin)],_15889,_15891) --> 
    cc(sin,_15889,_15891).

sin([sin,lit(sine)],_15889,_15891) --> 
    cc(sine,_15889,_15891).

sin([sin,lit(sitt)],_15889,_15891) --> 
    cc(sitt,_15889,_15891).

saa0([saa0,lit(bare),!,_15922],_15895,_15897) --> 
    cc(bare,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

saa0([saa0,lit(så),_15924,!,_15973],_15902,_15904) --> 
    cc(så,_15902,_15923),
    optional([ofte],_15924,_15923,_15956),
    !,
    accept(_15973,_15956,_15904).

saa0([saa0,lit(mye),!,_15922],_15895,_15897) --> 
    cc(mye,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

saa0([saa0,lit(da),!,_15922],_15895,_15897) --> 
    cc(da,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

saa0([saa0,[]],_15887,_15887) --> 
    [].

so0([so0,_15901,!],_15890,_15892) --> 
    so(_15901,_15890,_15892),
    !.

so0([so0,[]],_15887,_15887) --> 
    [].

so([so,lit(så)],_15889,_15891) --> 
    cc(så,_15889,_15891).

so([so,_15898],_15887,_15889) --> 
    too(_15898,_15887,_15889).

so([so,lit(heretter)],_15889,_15891) --> 
    cc(heretter,_15889,_15891).

so_that([so_that,lit(forat)],_15889,_15891) --> 
    cc(forat,_15889,_15891).

so_that([so_that,lit(som),lit(at)],_15894,_15896) --> 
    cc(som,_15894,_15915),
    cc(at,_15915,_15896).

so_that([so_that,lit(slik),_15921,_15945],_15899,_15901) --> 
    cc(slik,_15899,_15920),
    that(_15921,_15920,_15936),
    optional([bare],_15945,_15936,_15901).

so_that([so_that,lit(så),_15914],_15892,_15894) --> 
    cc(så,_15892,_15913),
    that(_15914,_15913,_15894).

so_that([so_that,lit(som),_15923,_15952],_15901,_15903) --> 
    cc(som,_15901,_15922),
    w(verb(do1,_15883,fin),_15923,_15922,_15940),
    that(_15952,_15940,_15903).

so_that([so_that,lit(så),_15927,!],_15905,_15907) --> 
    cc(så,_15905,_15926),
    look_ahead_lit([jeg,da,den,det],_15927,_15926,_15907),
    !.

so_that([so_that,lit(så),_15926,!],_15904,_15906) --> 
    cc(så,_15904,_15925),
    look_ahead(w(noun(_15884,_15885,_15886,_15887)),_15926,_15925,_15906),
    !.

so_that([so_that,lit(til),lit(at),!],_15897,_15899) --> 
    cc(til,_15897,_15918),
    cc(at,_15918,_15899),
    !.

so_that([so_that,_15905,lit(at)],_15894,_15896) --> 
    prep1(for,_15905,_15894,_15922),
    cc(at,_15922,_15896).

som0([som0,_15898],_15887,_15889) --> 
    som(_15898,_15887,_15889).

som0([som0,[]],_15887,_15887) --> 
    [].

som([som,lit(som)],_15889,_15891) --> 
    cc(som,_15889,_15891).

some([some,lit(noen),_15914],_15892,_15894) --> 
    cc(noen,_15892,_15913),
    of0(_15914,_15913,_15894).

someonex([someonex,_15898],_15887,_15889) --> 
    someone(_15898,_15887,_15889).

someone([someone,lit(dere)],_15889,_15891) --> 
    cc(dere,_15889,_15891).

someone([someone,lit(noen),_15914],_15892,_15894) --> 
    cc(noen,_15892,_15913),
    endofline(_15914,_15913,_15894).

someone([someone,lit(noen),_15922],_15900,_15902) --> 
    cc(noen,_15900,_15921),
    look_ahead(w(verb(_15879,_15880,_15881)),_15922,_15921,_15902).

someone([someone,_15903,lit(mange)],_15892,_15894) --> 
    so0(_15903,_15892,_15918),
    cc(mange,_15918,_15894).

someone([someone,lit(den),_15918],_15896,_15898) --> 
    cc(den,_15896,_15917),
    look_ahead([som],_15918,_15917,_15898).

someone([someone,lit(en),_15918],_15896,_15898) --> 
    cc(en,_15896,_15917),
    look_ahead([som],_15918,_15917,_15898).

soonar([soonar,lit(snart)],_15889,_15891) --> 
    cc(snart,_15889,_15891).

soonar([soonar,lit(snarest)],_15889,_15891) --> 
    cc(snarest,_15889,_15891).

soonar([soonar,lit(fort)],_15889,_15891) --> 
    cc(fort,_15889,_15891).

soon([soon,lit(fort)],_15889,_15891) --> 
    cc(fort,_15889,_15891).

soon([soon,_15903],_15892,_15894) --> 
    w(adj2(fast,nil),_15903,_15892,_15894).

soon([soon,lit(snart)],_15889,_15891) --> 
    cc(snart,_15889,_15891).

soon([soon,lit(snarest)],_15889,_15891) --> 
    cc(snarest,_15889,_15891).

statics(avg,[statics,lit(gjennomsnittet),_15921],_15896,_15898) --> 
    cc(gjennomsnittet,_15896,_15920),
    ofthe0(_15921,_15920,_15898).

statics(max(1),[statics,lit(maksimum),_15923],_15898,_15900) --> 
    cc(maksimum,_15898,_15922),
    ofthe0(_15923,_15922,_15900).

statics(min(1),[statics,lit(minimum),_15923],_15898,_15900) --> 
    cc(minimum,_15898,_15922),
    ofthe0(_15923,_15922,_15900).

statics(sum,[statics,_15908,_15932],_15894,_15896) --> 
    total(_15908,_15894,_15923),
    ofthe0(_15932,_15923,_15896).

statics(number,[statics,lit(antall),_15921],_15896,_15898) --> 
    cc(antall,_15896,_15920),
    ofthe0(_15921,_15920,_15898).

sure([sure,lit(sikker)],_15889,_15891) --> 
    cc(sikker,_15889,_15891).

sure([sure,lit(sikkert)],_15889,_15891) --> 
    cc(sikkert,_15889,_15891).

sure([sure,lit(sikre)],_15889,_15891) --> 
    cc(sikre,_15889,_15891).

terminator([terminator,_15904,!,_15933],_15893,_15895) --> 
    termchar(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

termchar0([termchar0,_15901,!],_15890,_15892) --> 
    termchar(_15901,_15890,_15892),
    !.

termchar0([termchar0,[]],_15887,_15887) --> 
    [].

termchar([termchar,lit('.')],_15889,_15891) --> 
    cc('.',_15889,_15891).

termchar([termchar,lit(?)],_15889,_15891) --> 
    cc(?,_15889,_15891).

termchar([termchar,lit(!)],_15889,_15891) --> 
    cc(!,_15889,_15891).

termchar([termchar,lit(:)],_15889,_15891) --> 
    cc(:,_15889,_15891).

than0([than0,_15898],_15887,_15889) --> 
    than(_15898,_15887,_15889).

than0([than0,[]],_15887,_15887) --> 
    [].

than([than,lit(enn)],_15889,_15891) --> 
    cc(enn,_15889,_15891).

that([that,lit(om),lit(at),!,_15938],_15900,_15902) --> 
    cc(om,_15900,_15921),
    cc(at,_15921,_15932),
    !,
    accept(_15938,_15932,_15902).

that([that,lit(at)],_15889,_15891) --> 
    cc(at,_15889,_15891).

that(that,[that,_15905],_15891,_15893) --> 
    that(_15905,_15891,_15893).

that(how,[that,_15905],_15891,_15893) --> 
    how(_15905,_15891,_15893).

that(when,[that,_15905],_15891,_15893) --> 
    when(_15905,_15891,_15893).

that(where,[that,_15905],_15891,_15893) --> 
    where(_15905,_15891,_15893).

that(whether,[that,_15910,lit(hvorvidt)],_15896,_15898) --> 
    paa0(_15910,_15896,_15925),
    cc(hvorvidt,_15925,_15898).

that(whether,[that,_15910,lit(om)],_15896,_15898) --> 
    paa0(_15910,_15896,_15925),
    cc(om,_15925,_15898).

that(why,[that,lit(hvorfor)],_15893,_15895) --> 
    cc(hvorfor,_15893,_15895).

paa0([paa0,lit(på),!,_15922],_15895,_15897) --> 
    cc(på,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

paa0([paa0,[]],_15887,_15887) --> 
    [].

that0([that0,_15898],_15887,_15889) --> 
    that(_15898,_15887,_15889).

that0([that0,[]],_15887,_15887) --> 
    [].

the([the,lit(den)],_15889,_15891) --> 
    cc(den,_15889,_15891).

the([the,lit(denne)],_15889,_15891) --> 
    cc(denne,_15889,_15891).

the([the,lit(det)],_15889,_15891) --> 
    cc(det,_15889,_15891).

the([the,lit(de)],_15889,_15891) --> 
    cc(de,_15889,_15891).

the([the,lit(dette)],_15889,_15891) --> 
    cc(dette,_15889,_15891).

the([the,lit(disse),_15914],_15892,_15894) --> 
    cc(disse,_15892,_15913),
    look_ahead_np(_15914,_15913,_15894).

themost([themost,_15903,lit(mest)],_15892,_15894) --> 
    the(_15903,_15892,_15918),
    cc(mest,_15918,_15894).

the0([the0,_15907,_15931,!,_15960],_15896,_15898) --> 
    the(_15907,_15896,_15922),
    der0(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

the0([the0,{},_15916],_15895,_15897) --> 
    {user:value(textflag,true)},
    art(_15916,_15895,_15897).

the0([the0,[]],_15887,_15887) --> 
    [].

the10([the10,lit(det)],_15889,_15891) --> 
    cc(det,_15889,_15891).

the10([the10,lit(den)],_15889,_15891) --> 
    cc(den,_15889,_15891).

the10([the10,[]],_15887,_15887) --> 
    [].

theplu0([theplu0,_15907,_15931,!,_15960],_15896,_15898) --> 
    all0(_15907,_15896,_15922),
    theplu(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

theplu0([theplu0,lit(den)],_15889,_15891) --> 
    cc(den,_15889,_15891).

theplu0([theplu0,_15898],_15887,_15889) --> 
    all0(_15898,_15887,_15889).

theplu([theplu,lit(de)],_15889,_15891) --> 
    cc(de,_15889,_15891).

their([their,lit(deres)],_15889,_15891) --> 
    cc(deres,_15889,_15891).

their([their,lit(de),lit(andres)],_15894,_15896) --> 
    cc(de,_15894,_15915),
    cc(andres,_15915,_15896).

then0([then0,_15904,!,_15933],_15893,_15895) --> 
    then1(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

then0([then0,[]],_15887,_15887) --> 
    [].

then1([then1,lit(da)],_15889,_15891) --> 
    cc(da,_15889,_15891).

then1([then1,lit(så)],_15889,_15891) --> 
    cc(så,_15889,_15891).

theonly0([theonly0,_15901,_15925],_15890,_15892) --> 
    the0(_15901,_15890,_15916),
    only0(_15925,_15916,_15892).

thereit0([thereit0,_15904,!,_15933],_15893,_15895) --> 
    thereit(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

thereit0([thereit0,[]],_15887,_15887) --> 
    [].

therenot0([therenot0,_15907,_15931,!,_15960],_15896,_15898) --> 
    thereit(_15907,_15896,_15922),
    not0(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

therenot0([therenot0,_15907,_15931,!,_15960],_15896,_15898) --> 
    not(_15907,_15896,_15922),
    thereit0(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

therenot0([therenot0,[]],_15887,_15887) --> 
    [].

thereit(_15872,[thereit,_15922,_15946,_15975,_15999,!,_16028],_15908,_15910) --> 
    thereit(_15922,_15908,_15937),
    negation0(_15872,_15946,_15937,_15963),
    redundant0(_15975,_15963,_15990),
    been0(_15999,_15990,_16014),
    !,
    accept(_16028,_16014,_15910).

thereitN([thereitN,_15908,_15932,!],_15897,_15899) --> 
    thereit(_15908,_15897,_15923),
    look_ahead([ikke],_15932,_15923,_15899),
    !.

thereitN([thereitN,_15898],_15887,_15889) --> 
    thereit(_15898,_15887,_15889).

dette([dette,lit(det),_15914],_15892,_15894) --> 
    cc(det,_15892,_15913),
    it_was_pronoun(_15914,_15913,_15894).

dette([dette,lit(dette)],_15889,_15891) --> 
    cc(dette,_15889,_15891).

thereit2(be,[thereit2,lit(det),!],_15896,_15898) --> 
    cc(det,_15896,_15898),
    !.

thereit2(_15872,[thereit2,_15908,!],_15894,_15896) --> 
    thereit(_15908,_15894,_15896),
    !.

thereit2(be,[thereit2,_15912,!],_15898,_15900) --> 
    look_ahead([til],_15912,_15898,_15900),
    !.

init([init,lit(det)],_15889,_15891) --> 
    cc(det,_15889,_15891).

init([init,lit(dette),_15914],_15892,_15894) --> 
    cc(dette,_15892,_15913),
    look_ahead_vp(_15914,_15913,_15894).

thereit([thereit,lit(de),_15918],_15896,_15898) --> 
    cc(de,_15896,_15917),
    look_ahead([noe],_15918,_15917,_15898).

thereit([thereit,lit(det),_15920,!,_15949],_15898,_15900) --> 
    cc(det,_15898,_15919),
    thereit_not_pronoun(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

thereit([thereit,lit(der)],_15889,_15891) --> 
    cc(der,_15889,_15891).

thereit([thereit,lit(her)],_15889,_15891) --> 
    cc(her,_15889,_15891).

thereit_not_pronoun([thereit_not_pronoun,_15904,!,_15933],_15893,_15895) --> 
    it_was_pronoun(_15904,_15893,_15919),
    !,
    reject(_15933,_15919,_15895).

thereit_not_pronoun([thereit_not_pronoun,[]],_15887,_15887) --> 
    [].

it_was_pronoun([it_was_pronoun,_15898],_15887,_15889) --> 
    endofline(_15898,_15887,_15889).

it_was_pronoun([it_was_pronoun,_15898],_15887,_15889) --> 
    look_ahead_vp(_15898,_15887,_15889).

this(_15872,[this,_15912,{}],_15898,_15900) --> 
    this(_15912,_15898,_15900),
    {user:it_template(_15872)}.

this(_15872,[this,_15912,{}],_15898,_15900) --> 
    thereit(_15912,_15898,_15900),
    {user:it_template(_15872)}.

this([this,lit(denne)],_15889,_15891) --> 
    cc(denne,_15889,_15891).

this([this,lit(dette)],_15889,_15891) --> 
    cc(dette,_15889,_15891).

this([this,lit(disse),_15914],_15892,_15894) --> 
    cc(disse,_15892,_15913),
    not_look_ahead_np(_15914,_15913,_15894).

this([this,lit(det),_15921,_15950],_15899,_15901) --> 
    cc(det,_15899,_15920),
    look_ahead(['.'],_15921,_15920,_15938),
    accept(_15950,_15938,_15901).

this([this,lit(det),_15921,_15950],_15899,_15901) --> 
    cc(det,_15899,_15920),
    look_ahead([?],_15921,_15920,_15938),
    accept(_15950,_15938,_15901).

this([this,lit(det),lit(da),!,_15938],_15900,_15902) --> 
    cc(det,_15900,_15921),
    cc(da,_15921,_15932),
    !,
    accept(_15938,_15932,_15902).

this([this,lit(det),_15920,!,_15949],_15898,_15900) --> 
    cc(det,_15898,_15919),
    end_of_line(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

this([this,lit(slik),_15920],_15898,_15900) --> 
    cc(slik,_15898,_15919),
    not_look_ahead_lit([at,som],_15920,_15919,_15900).

thisplace(in,[thisplace,lit(her)],_15893,_15895) --> 
    cc(her,_15893,_15895).

thisplace(to,[thisplace,lit(hit)],_15893,_15895) --> 
    cc(hit,_15893,_15895).

thisplace(in,[thisplace,lit(der)],_15893,_15895) --> 
    cc(der,_15893,_15895).

thisplace(to,[thisplace,lit(dit)],_15893,_15895) --> 
    cc(dit,_15893,_15895).

timepoint([timepoint,_15905],_15894,_15896) --> 
    w(noun(time,_15875,u,n),_15905,_15894,_15896).

timepoint([timepoint,_15905],_15894,_15896) --> 
    w(noun(clock,sin,u,n),_15905,_15894,_15896).

to([to,_15900],_15889,_15891) --> 
    prep(to,_15900,_15889,_15891).

forto0([forto0,_15901,!],_15890,_15892) --> 
    forto(_15901,_15890,_15892),
    !.

forto0([forto0,[]],_15887,_15887) --> 
    [].

forto([forto,lit(for)],_15889,_15891) --> 
    cc(for,_15889,_15891).

forto([forto,lit(til)],_15889,_15891) --> 
    cc(til,_15889,_15891).

forto([forto,lit(om)],_15889,_15891) --> 
    cc(om,_15889,_15891).

slikat([slikat,lit(slik),lit(at)],_15894,_15896) --> 
    cc(slik,_15894,_15915),
    cc(at,_15915,_15896).

slikat([slikat,lit(sikkert),lit(at)],_15894,_15896) --> 
    cc(sikkert,_15894,_15915),
    cc(at,_15915,_15896).

to0([to0,_15901,!],_15890,_15892) --> 
    to(_15901,_15890,_15892),
    !.

to0([to0,[]],_15887,_15887) --> 
    [].

tomed0([tomed0,lit(til),!],_15892,_15894) --> 
    cc(til,_15892,_15894),
    !.

tomed0([tomed0,lit(med),!],_15892,_15894) --> 
    cc(med,_15892,_15894),
    !.

tomed0([tomed0,[]],_15887,_15887) --> 
    [].

too([too,lit(for),_15921],_15899,_15901) --> 
    cc(for,_15899,_15920),
    look_ahead(w(adj(_15879,nil)),_15921,_15920,_15901).

today0([today0,_15898],_15887,_15889) --> 
    today(_15898,_15887,_15889).

today0([today0,[]],_15887,_15887) --> 
    [].

today([today,lit(idag)],_15889,_15891) --> 
    cc(idag,_15889,_15891).

today([today,_15910,_15939],_15899,_15901) --> 
    prep(in,_15910,_15899,_15927),
    w(noun(day,sin,u,n),_15939,_15927,_15901).

tomorrow([tomorrow,lit(imorgen)],_15889,_15891) --> 
    cc(imorgen,_15889,_15891).

tomorrow([tomorrow,_15905,lit(morgen)],_15894,_15896) --> 
    prep1(in,_15905,_15894,_15922),
    cc(morgen,_15922,_15896).

total([total,lit(total)],_15889,_15891) --> 
    cc(total,_15889,_15891).

total([total,lit(totalt)],_15889,_15891) --> 
    cc(totalt,_15889,_15891).

total([total,lit(totale)],_15889,_15891) --> 
    cc(totale,_15889,_15891).

total([total,lit(sum),_15914],_15892,_15894) --> 
    cc(sum,_15892,_15913),
    of(_15914,_15913,_15894).

true([true,lit(sann)],_15889,_15891) --> 
    cc(sann,_15889,_15891).

true([true,lit(sant)],_15889,_15891) --> 
    cc(sant,_15889,_15891).

true([true,lit(sanne)],_15889,_15891) --> 
    cc(sanne,_15889,_15891).

true([true,lit(slik)],_15889,_15891) --> 
    cc(slik,_15889,_15891).

truefalse(id,[truefalse,_15905],_15891,_15893) --> 
    true(_15905,_15891,_15893).

truefalse(id,[truefalse,_15908,_15932],_15894,_15896) --> 
    not(_15908,_15894,_15923),
    false(_15932,_15923,_15896).

truefalse(not,[truefalse,_15905],_15891,_15893) --> 
    false(_15905,_15891,_15893).

truefalse(not,[truefalse,_15908,_15932],_15894,_15896) --> 
    not(_15908,_15894,_15923),
    true(_15932,_15923,_15896).

unequal([unequal,lit(ulik)],_15889,_15891) --> 
    cc(ulik,_15889,_15891).

unequal([unequal,lit(ulikt)],_15889,_15891) --> 
    cc(ulikt,_15889,_15891).

unequal([unequal,lit(ulike)],_15889,_15891) --> 
    cc(ulike,_15889,_15891).

unequal([unequal,_15901,_15925],_15890,_15892) --> 
    not(_15901,_15890,_15916),
    equal(_15925,_15916,_15892).

until([until,lit(inntil)],_15889,_15891) --> 
    cc(inntil,_15889,_15891).

until([until,lit(fram),_15916],_15894,_15896) --> 
    cc(fram,_15894,_15915),
    prep1(to,_15916,_15915,_15896).

use([use,_15904],_15893,_15895) --> 
    w(verb(use,_15875,fin),_15904,_15893,_15895).

use([use,_15904],_15893,_15895) --> 
    w(verb(want,_15875,fin),_15904,_15893,_15895).

what([what,lit(hva)],_15889,_15891) --> 
    cc(hva,_15889,_15891).

whatbe([whatbe,_15907,_15931,!,_15960],_15896,_15898) --> 
    what(_15907,_15896,_15922),
    be(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

whatbe([whatbe,lit(hvilke),_15920,!,_15949],_15898,_15900) --> 
    cc(hvilke,_15898,_15919),
    be(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

whatbe([whatbe,lit(hvilken),_15920,!,_15949],_15898,_15900) --> 
    cc(hvilken,_15898,_15919),
    be(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

whatbe([whatbe,lit(hvilket),_15920,!,_15949],_15898,_15900) --> 
    cc(hvilket,_15898,_15919),
    be(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

whatbemean([whatbemean,lit(hva),_15920],_15898,_15900) --> 
    cc(hva,_15898,_15919),
    w(verb(be,pres,fin),_15920,_15919,_15900).

whatbemean([whatbemean,lit(hva),_15920],_15898,_15900) --> 
    cc(hva,_15898,_15919),
    w(verb(mean2,pres,fin),_15920,_15919,_15900).

whatbemean([whatbemean,lit(hva),_15920],_15898,_15900) --> 
    cc(hva,_15898,_15919),
    w(verb(indicate,pres,fin),_15920,_15919,_15900).

when0([when0,_15904,!,_15933],_15893,_15895) --> 
    when(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

when0([when0,[]],_15887,_15887) --> 
    [].

whenx([whenx,_15909,lit(jeg),!,_15949],_15898,_15900) --> 
    when1(_15909,_15898,_15924),
    cc(jeg,_15924,_15943),
    !,
    reject(_15949,_15943,_15900).

whenx([whenx,_15898],_15887,_15889) --> 
    when(_15898,_15887,_15889).

when([when,lit(når),_15920,!,_15949],_15898,_15900) --> 
    cc(når,_15898,_15919),
    timepoint(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

when([when,lit(når)],_15889,_15891) --> 
    cc(når,_15889,_15891).

when([when,lit(hvordan),_15927,!,_15961],_15905,_15907) --> 
    cc(hvordan,_15905,_15926),
    w(noun(time,_15886,u,n),_15927,_15926,_15944),
    !,
    accept(_15961,_15944,_15907).

when([when,lit(hvor),_15920,!,_15949],_15898,_15900) --> 
    cc(hvor,_15898,_15919),
    timepoint(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

when([when,lit(hva),_15920,!,_15949],_15898,_15900) --> 
    cc(hva,_15898,_15919),
    timepoint(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

when([when,_15907,_15931,!,_15960],_15896,_15898) --> 
    which(_15907,_15896,_15922),
    timepoint(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

when([when,_15912,_15941,_15965,!,_15994],_15901,_15903) --> 
    prep1(to,_15912,_15901,_15929),
    which(_15941,_15929,_15956),
    timepoint(_15965,_15956,_15980),
    !,
    accept(_15994,_15980,_15903).

when([when,_15912,_15941,_15965,!,_15994],_15901,_15903) --> 
    prep1(on,_15912,_15901,_15929),
    which(_15941,_15929,_15956),
    timepoint(_15965,_15956,_15980),
    !,
    accept(_15994,_15980,_15903).

when([when,lit(så),lit(snart),!,_15938],_15900,_15902) --> 
    cc(så,_15900,_15921),
    cc(snart,_15921,_15932),
    !,
    accept(_15938,_15932,_15902).

when([when,lit(hva),lit(ti)],_15894,_15896) --> 
    cc(hva,_15894,_15915),
    cc(ti,_15915,_15896).

when([when,lit(hvordan),lit(ti)],_15894,_15896) --> 
    cc(hvordan,_15894,_15915),
    cc(ti,_15915,_15896).

when([when,lit(tid),_15918],_15896,_15898) --> 
    cc(tid,_15896,_15917),
    look_ahead([går],_15918,_15917,_15898).

where([where,lit(hvor),_15929,_15958,!,_15987],_15907,_15909) --> 
    cc(hvor,_15907,_15928),
    not_look_ahead(w(prep(from)),_15929,_15928,_15946),
    andwhen0(_15958,_15946,_15973),
    !,
    accept(_15987,_15973,_15909).

where([where,_15914,_15938,!,_15972],_15903,_15905) --> 
    which(_15914,_15903,_15929),
    w(noun(place,_15884,_15885,_15886),_15938,_15929,_15955),
    !,
    accept(_15972,_15955,_15905).

where1([where1,lit(der),lit(hvor),!,_15938],_15900,_15902) --> 
    cc(der,_15900,_15921),
    cc(hvor,_15921,_15932),
    !,
    accept(_15938,_15932,_15902).

where1([where1,lit(hvor),_15920,!,_15949],_15898,_15900) --> 
    cc(hvor,_15898,_15919),
    meny(_15920,_15919,_15935),
    !,
    reject(_15949,_15935,_15900).

where1([where1,lit(hvor)],_15889,_15891) --> 
    cc(hvor,_15889,_15891).

where1([where1,lit(der)],_15889,_15891) --> 
    cc(der,_15889,_15891).

wherefrom([wherefrom,_15919,_15948,_15972,!,_16006],_15908,_15910) --> 
    prep1(from,_15919,_15908,_15936),
    which(_15948,_15936,_15963),
    w(noun(place,_15889,_15890,_15891),_15972,_15963,_15989),
    !,
    accept(_16006,_15989,_15910).

wherefrom([wherefrom,_15911,lit(hvor),!,_15956],_15900,_15902) --> 
    prep1(from,_15911,_15900,_15928),
    cc(hvor,_15928,_15950),
    !,
    accept(_15956,_15950,_15902).

wherefrom([wherefrom,lit(hvorfra)],_15889,_15891) --> 
    cc(hvorfra,_15889,_15891).

wherefrom([wherefrom,lit(hvor),lit(fra)],_15894,_15896) --> 
    cc(hvor,_15894,_15915),
    cc(fra,_15915,_15896).

wherefrom([wherefrom,lit(hvor),lit(ifra)],_15894,_15896) --> 
    cc(hvor,_15894,_15915),
    cc(ifra,_15915,_15896).

while([while,lit(mens)],_15889,_15891) --> 
    cc(mens,_15889,_15891).

which0([which0,_15904,!,_15933],_15893,_15895) --> 
    which(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

which0([which0,[]],_15887,_15887) --> 
    [].

which([which,lit(hva),_15922,_15951,!],_15900,_15902) --> 
    cc(hva,_15900,_15921),
    prep1(for,_15922,_15921,_15939),
    a0(_15951,_15939,_15902),
    !.

which([which,lit(hva),lit(slags),!],_15897,_15899) --> 
    cc(hva,_15897,_15918),
    cc(slags,_15918,_15899),
    !.

which([which,lit(hvilken),lit(slags),!],_15897,_15899) --> 
    cc(hvilken,_15897,_15918),
    cc(slags,_15918,_15899),
    !.

which([which,lit(hvilken)],_15889,_15891) --> 
    cc(hvilken,_15889,_15891).

which([which,lit(hvilket)],_15889,_15891) --> 
    cc(hvilket,_15889,_15891).

which([which,lit(hvilke),_15914],_15892,_15894) --> 
    cc(hvilke,_15892,_15913),
    off0(_15914,_15913,_15894).

which2([which2,_15904,_15928,_15952],_15893,_15895) --> 
    which(_15904,_15893,_15919),
    numbertype0(_15928,_15919,_15943),
    ofthe0(_15952,_15943,_15895).

which2([which2,lit(hvem),_15938,_15967,!],_15916,_15918) --> 
    cc(hvem,_15916,_15937),
    look_ahead(w(noun(_15887,sin,u,n)),_15938,_15937,_15955),
    gmem(_15887,[bus,tram,day],_15967,_15955,_15918),
    !.

which2([which2,lit(hvordan),_15940,_15969,!],_15918,_15920) --> 
    cc(hvordan,_15918,_15939),
    look_ahead(w(noun(_15887,sin,u,n)),_15940,_15939,_15957),
    gmem(_15887,[label,bus,tram,day],_15969,_15957,_15920),
    !.

numbertype0([numbertype0,_15904,!,_15933],_15893,_15895) --> 
    type(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

numbertype0([numbertype0,[]],_15887,_15887) --> 
    [].

with0([with0,_15906,!,_15940],_15895,_15897) --> 
    prep(with,_15906,_15895,_15923),
    !,
    accept(_15940,_15923,_15897).

with0([with0,[]],_15887,_15887) --> 
    [].

who([who,lit(hvem)],_15889,_15891) --> 
    cc(hvem,_15889,_15891).

whose([whose,lit(hvis)],_15889,_15891) --> 
    cc(hvis,_15889,_15891).

mex0([mex0,_15908,!,_15942],_15897,_15899) --> 
    look_ahead([jeg],_15908,_15897,_15925),
    !,
    reject(_15942,_15925,_15899).

mex0([mex0,_15908,!,_15942],_15897,_15899) --> 
    look_ahead([du],_15908,_15897,_15925),
    !,
    reject(_15942,_15925,_15899).

mex0([mex0,lit(seg),!,_15922],_15895,_15897) --> 
    cc(seg,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

mex0([mex0,lit(meg),!,_15922],_15895,_15897) --> 
    cc(meg,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

mex0([mex0,lit(oss),!,_15922],_15895,_15897) --> 
    cc(oss,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

mex0([mex0,[]],_15887,_15887) --> 
    [].

you([you,lit(du),_15918],_15896,_15898) --> 
    cc(du,_15896,_15917),
    not_look_ahead([jeg],_15918,_15917,_15898).

yesterday([yesterday,_15905,lit(går)],_15894,_15896) --> 
    prep1(in,_15905,_15894,_15922),
    cc(går,_15922,_15896).

younger([younger,lit(yngre)],_15889,_15891) --> 
    cc(yngre,_15889,_15891).

your([your,lit(din)],_15889,_15891) --> 
    cc(din,_15889,_15891).

your([your,lit(ditt)],_15889,_15891) --> 
    cc(ditt,_15889,_15891).

your([your,lit(dine)],_15889,_15891) --> 
    cc(dine,_15889,_15891).

your([your,lit(di)],_15889,_15891) --> 
    cc(di,_15889,_15891).

num_na(_15872,[num_na,_15911,!,_15940],_15897,_15899) --> 
    art(_15911,_15897,_15926),
    !,
    reject(_15940,_15926,_15899).

num_na(_15872,[num_na,_15910],_15896,_15898) --> 
    w(nb(_15872,_15877),_15910,_15896,_15898).

num(_15872,[num,_15913,!],_15899,_15901) --> 
    w(nb(_15872,num),_15913,_15899,_15901),
    !.

personal('    ',[personal,lit(hysj)],_15893,_15895) --> 
    cc(hysj,_15893,_15895).

personal('RPGOLRAM',[personal,lit(rpgol)],_15893,_15895) --> 
    cc(rpgol,_15893,_15895).

personal('OK',[personal,lit(rpgolram)],_15893,_15895) --> 
    cc(rpgolram,_15893,_15895).

personal('Takk',[personal,lit(værsågod)],_15893,_15895) --> 
    cc(værsågod,_15893,_15895).

personal('Takk',[personal,_15924,lit(så),_15964],_15910,_15912) --> 
    w(verb(be,imp,fin),_15924,_15910,_15941),
    cc(så,_15941,_15963),
    w(adj2(good,nil),_15964,_15963,_15912).

personal('Takk',[personal,_15914,_15938,_15962,_15986],_15900,_15902) --> 
    so(_15914,_15900,_15929),
    good(_15938,_15929,_15953),
    you(_15962,_15953,_15977),
    be(_15986,_15977,_15902).

personal('Takk',[personal,lit(bravo)],_15893,_15895) --> 
    cc(bravo,_15893,_15895).

personal('Takk',[personal,_15917,_15946,_15970],_15903,_15905) --> 
    w(verb(congratulate,pres,fin),_15917,_15903,_15934),
    with0(_15946,_15934,_15961),
    skip_rest(_15970,_15961,_15905).

personal(pong,[personal,lit(ping)],_15893,_15895) --> 
    cc(ping,_15893,_15895).

personal(_15872,[personal,_15907],_15893,_15895) --> 
    greetings(_15872,_15907,_15893,_15895).

greetings0([greetings0,_15910,_15939,!],_15899,_15901) --> 
    w(verb(help,imp,fin),_15910,_15899,_15927),
    optoken(_15939,_15927,_15901),
    !.

greetings0([greetings0,_15909,_15953,_15977,!],_15898,_15900) --> 
    optional(grums,_15909,_15898,_15941),
    greetings(_15953,_15941,_15968),
    optoken(_15977,_15968,_15900),
    !.

greetings0([greetings0,_15900],_15889,_15891) --> 
    optional(grums,_15900,_15889,_15891).

greetings('OK',[greetings,_15908,_15932],_15894,_15896) --> 
    okeys(_15908,_15894,_15923),
    endofline(_15932,_15923,_15896).

greetings('Hei på deg',[greetings,_15908,_15932],_15894,_15896) --> 
    hello(_15908,_15894,_15923),
    daddy(_15932,_15923,_15896).

greetings('Hei',[greetings,_15905],_15891,_15893) --> 
    greetings(_15905,_15891,_15893).

daddy([daddy,_15908,!],_15897,_15899) --> 
    w(noun(father,sin,u,n),_15908,_15897,_15899),
    !.

daddy([daddy,_15908,!],_15897,_15899) --> 
    w(noun(mother,sin,u,n),_15908,_15897,_15899),
    !.

daddy([daddy,_15907,!],_15896,_15898) --> 
    w(name(_15877,n,man),_15907,_15896,_15898),
    !.

optoken([optoken,lit(:)],_15889,_15891) --> 
    cc(:,_15889,_15891).

optoken([optoken,lit(!)],_15889,_15891) --> 
    cc(!,_15889,_15891).

optoken([optoken,lit('.')],_15889,_15891) --> 
    cc('.',_15889,_15891).

optoken([optoken,[]],_15887,_15887) --> 
    [].

greetings([greetings,lit(_15877),{}],_15907,_15909) --> 
    cc(_15877,_15907,_15909),
    {user:testmember(_15877,[ja,jo,joda,nei,neida])}.

greetings([greetings,_15898],_15887,_15889) --> 
    hellos(_15898,_15887,_15889).

greetings([greetings,lit(hva),lit(om)],_15894,_15896) --> 
    cc(hva,_15894,_15915),
    cc(om,_15915,_15896).

greetings([greetings,lit(nei)],_15889,_15891) --> 
    cc(nei,_15889,_15891).

greetings([greetings,lit(o),_15920,_15944],_15898,_15900) --> 
    cc(o,_15898,_15919),
    adj0(_15920,_15919,_15935),
    np0(_15878,_15879,_15944,_15935,_15900).

greetings([greetings,_15909,lit(meg)],_15898,_15900) --> 
    w(verb(say,inf,fin),_15909,_15898,_15926),
    cc(meg,_15926,_15900).

greetings([greetings,_15932,{},_15971,_15995,!],_15921,_15923) --> 
    w(noun(_15886,sin,u,n),_15932,_15921,_15949),
    {user:testmember(_15886,[oracle,brother,sister])},
    colon0(_15971,_15949,_15986),
    look_ahead([når],_15995,_15986,_15923),
    !.

greetings([greetings,_15933,{},_15972,_15996],_15922,_15924) --> 
    w(noun(_15891,sin,u,n),_15933,_15922,_15950),
    {user:testmember(_15891,[oracle,brother,sister])},
    colon0(_15972,_15950,_15987),
    not_look_ahead(w(verb(_15885,_15886,fin)),_15996,_15987,_15924).

greetings([greetings,_15940,_15969,_15998,_16027,_16051,_16080,_16104],_15929,_15931) --> 
    w(name(bustuc,n,_15894),_15940,_15929,_15957),
    not_look_ahead([som],_15969,_15957,_15986),
    not_look_ahead(w(prep(_15904)),_15998,_15986,_16015),
    colon0(_16027,_16015,_16042),
    not_look_ahead(w(verb(_15910,_15911,_15912)),_16051,_16042,_16068),
    not_look_ahead_vp(_16080,_16068,_16095),
    not_look_ahead_np(_16104,_16095,_15931).

trafikk([trafikk,lit(trafikk)],_15889,_15891) --> 
    cc(trafikk,_15889,_15891).

trafikk([trafikk,lit(t)],_15889,_15891) --> 
    cc(t,_15889,_15891).

grums0([grums0,[]],_15887,_15887) --> 
    [].

grums([grums,lit(rute),{}],_15897,_15899) --> 
    cc(rute,_15897,_15899),
    {user:value(smsflag,true)}.

grums([grums,lit('.')],_15889,_15891) --> 
    cc('.',_15889,_15891).

grums([grums,lit(?)],_15889,_15891) --> 
    cc(?,_15889,_15891).

grums([grums,lit(:),!],_15892,_15894) --> 
    cc(:,_15892,_15894),
    !.

grums([grums,lit(/),!],_15892,_15894) --> 
    cc(/,_15892,_15894),
    !.

grums([grums,lit(!),!],_15892,_15894) --> 
    cc(!,_15892,_15894),
    !.

grums([grums,lit(-),!],_15892,_15894) --> 
    cc(-,_15892,_15894),
    !.

grums([grums,lit(eksempelvis),lit(:)],_15894,_15896) --> 
    cc(eksempelvis,_15894,_15915),
    cc(:,_15915,_15896).

grums([grums,_15903,lit(at)],_15892,_15894) --> 
    redundant(_15903,_15892,_15918),
    cc(at,_15918,_15894).

grums([grums,_15927,lit(:),_15967,!],_15916,_15918) --> 
    w(noun(_15883,sin,u,n),_15927,_15916,_15944),
    cc(:,_15944,_15966),
    gmem(_15883,[error,thing,subject,example],_15967,_15966,_15918),
    !.

grums([grums,_15911,lit(om),!],_15900,_15902) --> 
    w(adj2(good,nil),_15911,_15900,_15928),
    cc(om,_15928,_15902),
    !.

grums([grums,lit(bare)],_15889,_15891) --> 
    cc(bare,_15889,_15891).

grums([grums,lit(eller)],_15889,_15891) --> 
    cc(eller,_15889,_15891).

grums([grums,lit(fyi),_15914],_15892,_15894) --> 
    cc(fyi,_15892,_15913),
    point0(_15914,_15913,_15894).

grums([grums,lit(grr)],_15889,_15891) --> 
    cc(grr,_15889,_15891).

grums([grums,lit(huff)],_15889,_15891) --> 
    cc(huff,_15889,_15891).

grums([grums,lit(igjen)],_15889,_15891) --> 
    cc(igjen,_15889,_15891).

grums([grums,lit(jo)],_15889,_15891) --> 
    cc(jo,_15889,_15891).

grums([grums,lit(og)],_15889,_15891) --> 
    cc(og,_15889,_15891).

grums([grums,lit(kort),lit(sagt)],_15894,_15896) --> 
    cc(kort,_15894,_15915),
    cc(sagt,_15915,_15896).

grums([grums,lit(men)],_15889,_15891) --> 
    cc(men,_15889,_15891).

grums([grums,lit(nei),lit(men)],_15894,_15896) --> 
    cc(nei,_15894,_15915),
    cc(men,_15915,_15896).

grums([grums,lit(nb)],_15889,_15891) --> 
    cc(nb,_15889,_15891).

grums([grums,lit(nei),_15922],_15900,_15902) --> 
    cc(nei,_15900,_15921),
    look_ahead(w(verb(_15879,_15880,_15881)),_15922,_15921,_15902).

grums([grums,lit(ja),_15922],_15900,_15902) --> 
    cc(ja,_15900,_15921),
    look_ahead(w(verb(_15879,_15880,_15881)),_15922,_15921,_15902).

grums([grums,lit(typisk)],_15889,_15891) --> 
    cc(typisk,_15889,_15891).

grums([grums,lit(uff)],_15889,_15891) --> 
    cc(uff,_15889,_15891).

grums([grums,lit(vel)],_15889,_15891) --> 
    cc(vel,_15889,_15891).

grums([grums,lit(å),_15914],_15892,_15894) --> 
    cc(å,_15892,_15913),
    not_look_ahead_vp(_15914,_15913,_15894).

grums([grums,_15906,_15935],_15895,_15897) --> 
    w(nb(1939,num),_15906,_15895,_15923),
    point0(_15935,_15923,_15897).

grums([grums,_15919,_15963,_15992],_15908,_15910) --> 
    optional([for],_15919,_15908,_15951),
    w(noun(example,sin,u,n),_15963,_15951,_15980),
    optional([:],_15992,_15980,_15910).

grums([grums,_15910,lit(:)],_15899,_15901) --> 
    w(noun(question,sin,u,n),_15910,_15899,_15927),
    cc(:,_15927,_15901).

grums([grums,lit(svar),_15918],_15896,_15898) --> 
    cc(svar,_15896,_15917),
    optional([:],_15918,_15917,_15898).

grums([grums,lit(n),lit(:)],_15894,_15896) --> 
    cc(n,_15894,_15915),
    cc(:,_15915,_15896).

grums([grums,_15911,_15940,!],_15900,_15902) --> 
    w(noun(traffic,sin,u,n),_15911,_15900,_15928),
    colon(_15940,_15928,_15902),
    !.

grums([grums,_15907,lit(tt)],_15896,_15898) --> 
    not_look_ahead([dere],_15907,_15896,_15924),
    cc(tt,_15924,_15898).

grums([grums,lit(så),_15922,!],_15900,_15902) --> 
    cc(så,_15900,_15921),
    w(adj2(funny,nil),_15922,_15921,_15902),
    !.

grums([grums,lit(så),_15914],_15892,_15894) --> 
    cc(så,_15892,_15913),
    not_look_ahead_vp(_15914,_15913,_15894).

grums([grums,lit(ja),lit(så),_15930],_15897,_15899) --> 
    cc(ja,_15897,_15918),
    cc(så,_15918,_15929),
    not_look_ahead_vp(_15930,_15929,_15899).

grums([grums,lit(nb),_15922],_15900,_15902) --> 
    cc(nb,_15900,_15921),
    one_of_lit(['.',:,!],_15922,_15921,_15902).

grums([grums,lit(obs),_15922],_15900,_15902) --> 
    cc(obs,_15900,_15921),
    one_of_lit(['.',:,!],_15922,_15921,_15902).

grums([grums,lit(unnskyld),lit(men)],_15894,_15896) --> 
    cc(unnskyld,_15894,_15915),
    cc(men,_15915,_15896).

grums([grums,lit(ok),_15922],_15900,_15902) --> 
    cc(ok,_15900,_15921),
    look_ahead(w(verb(_15879,imp,fin)),_15922,_15921,_15902).

grums([grums,lit(supert)],_15889,_15891) --> 
    cc(supert,_15889,_15891).

team([team,_15904],_15893,_15895) --> 
    w(name(team,_15875,_15876),_15904,_15893,_15895).

team([team,lit(team)],_15889,_15891) --> 
    cc(team,_15889,_15891).

hellos([hellos,_15904,_15928,_15952],_15893,_15895) --> 
    hello(_15904,_15893,_15919),
    sludder0(_15928,_15919,_15943),
    hellos0(_15952,_15943,_15895).

hellos0([hellos0,_15898],_15887,_15889) --> 
    hellos(_15898,_15887,_15889).

hellos0([hellos0,[]],_15887,_15887) --> 
    [].

adj0([adj0,_15909,!,_15943],_15898,_15900) --> 
    w(adj2(_15880,_15881),_15909,_15898,_15926),
    !,
    accept(_15943,_15926,_15900).

adj0([adj0,[]],_15887,_15887) --> 
    [].

hei([hei,lit(hei),_15914],_15892,_15894) --> 
    cc(hei,_15892,_15913),
    der0(_15914,_15913,_15894).

hei([hei,lit(hallo),_15914],_15892,_15894) --> 
    cc(hallo,_15892,_15913),
    der0(_15914,_15913,_15894).

sludder0([sludder0,_15901,!],_15890,_15892) --> 
    sludder(_15901,_15890,_15892),
    !.

sludder0([sludder0,[]],_15887,_15887) --> 
    [].

sludder([sludder,lit(alle),lit(sammen),!],_15897,_15899) --> 
    cc(alle,_15897,_15918),
    cc(sammen,_15918,_15899),
    !.

sludder([sludder,lit(der),!],_15892,_15894) --> 
    cc(der,_15892,_15894),
    !.

sludder([sludder,lit(du),_15925,!],_15903,_15905) --> 
    cc(du,_15903,_15924),
    not_look_ahead(w(verb(_15884,_15885,_15886)),_15925,_15924,_15905),
    !.

sludder([sludder,_15918,_15947,!],_15907,_15909) --> 
    w(name(tuc,n,_15882),_15918,_15907,_15935),
    not_look_ahead(w(verb(_15888,_15889,_15890)),_15947,_15935,_15909),
    !.

sludder([sludder,_15907,!],_15896,_15898) --> 
    w(name(bustuc,n,_15879),_15907,_15896,_15898),
    !.

sludder([sludder,_15907,!],_15896,_15898) --> 
    w(name(tt,n,_15879),_15907,_15896,_15898),
    !.

sludder([sludder,_15907,!],_15896,_15898) --> 
    w(name(tagore,n,_15879),_15907,_15896,_15898),
    !.

sludder([sludder,_15907,!],_15896,_15898) --> 
    w(name(tore,n,_15879),_15907,_15896,_15898),
    !.

sludder([sludder,_15908,!],_15897,_15899) --> 
    w(noun(computer,sin,u,n),_15908,_15897,_15899),
    !.

sludder([sludder,_15908,!],_15897,_15899) --> 
    w(noun(oracle,sin,_15879,n),_15908,_15897,_15899),
    !.

sludder([sludder,_15908,!],_15897,_15899) --> 
    w(noun(man,sin,u,n),_15908,_15897,_15899),
    !.

sludder([sludder,_15908,!],_15897,_15899) --> 
    w(noun(sweetheart,sin,u,n),_15908,_15897,_15899),
    !.

okeys0([okeys0,_15898],_15887,_15889) --> 
    okeys(_15898,_15887,_15889).

okeys0([okeys0,[]],_15887,_15887) --> 
    [].

okeys([okeys,lit(ok),_15928,_15972,_16016],_15906,_15908) --> 
    cc(ok,_15906,_15927),
    optional([ja],_15928,_15927,_15960),
    optional([men],_15972,_15960,_16004),
    optoken(_16016,_16004,_15908).

hello([hello,lit(bra)],_15889,_15891) --> 
    cc(bra,_15889,_15891).

hello([hello,_15898],_15887,_15889) --> 
    okeys(_15898,_15887,_15889).

hello([hello,_15906,_15930,_15974],_15895,_15897) --> 
    hei(_15906,_15895,_15921),
    optional(paadeg,_15930,_15921,_15962),
    sludder0(_15974,_15962,_15897).

hello([hello,lit(goddag)],_15889,_15891) --> 
    cc(goddag,_15889,_15891).

hello([hello,_15931,_15960,{}],_15920,_15922) --> 
    w(adj2(good,nil),_15931,_15920,_15948),
    w(noun(_15880,_15901,_15902,_15903),_15960,_15948,_15922),
    {user:testmember(_15880,[day,morning,evening,night,afternoon])}.

paadeg([paadeg,_15911,lit(deg),!,_15956],_15900,_15902) --> 
    prep1(on,_15911,_15900,_15928),
    cc(deg,_15928,_15950),
    !,
    accept(_15956,_15950,_15902).

paadeg([paadeg,lit(og),lit(hå),!,_15938],_15900,_15902) --> 
    cc(og,_15900,_15921),
    cc(hå,_15921,_15932),
    !,
    accept(_15938,_15932,_15902).

forhjelpen0([forhjelpen0,_15908,lit(alt),!],_15897,_15899) --> 
    prep1(for,_15908,_15897,_15925),
    cc(alt,_15925,_15899),
    !.

forhjelpen0([forhjelpen0,_15919,_15948,_15977,!],_15908,_15910) --> 
    prep1(for,_15919,_15908,_15936),
    w(noun(_15885,sin,def,n),_15948,_15936,_15965),
    np1(_15890,_15891,_15977,_15965,_15910),
    !.

forhjelpen0([forhjelpen0,_15913,_15942,!],_15902,_15904) --> 
    prep1(for,_15913,_15902,_15930),
    w(noun(_15882,sin,def,n),_15942,_15930,_15904),
    !.

forhjelpen0([forhjelpen0,_15909,_15938,!],_15898,_15900) --> 
    prep1(for,_15909,_15898,_15926),
    np1(_15880,_15881,_15938,_15926,_15900),
    !.

forhjelpen0([forhjelpen0,lit(skal),lit(du),_15936],_15903,_15905) --> 
    cc(skal,_15903,_15924),
    cc(du,_15924,_15935),
    w(verb(have,imp,fin),_15936,_15935,_15905).

forhjelpen0([forhjelpen0,[]],_15887,_15887) --> 
    [].

hadet([hadet,lit(ha),lit(de),_15930],_15897,_15899) --> 
    cc(ha,_15897,_15918),
    cc(de,_15918,_15929),
    paabadet0(_15930,_15929,_15899).

hadet([hadet,lit(ha),lit(det),_15930],_15897,_15899) --> 
    cc(ha,_15897,_15918),
    cc(det,_15918,_15929),
    paabadet0(_15930,_15929,_15899).

hadet([hadet,lit(hadet),_15914],_15892,_15894) --> 
    cc(hadet,_15892,_15913),
    paabadet0(_15914,_15913,_15894).

hadet([hadet,lit(hade),_15914],_15892,_15894) --> 
    cc(hade,_15892,_15913),
    paabadet0(_15914,_15913,_15894).

kan([kan,_15904],_15893,_15895) --> 
    w(verb(know,_15875,fin),_15904,_15893,_15895).

kan([kan,lit(kan)],_15889,_15891) --> 
    cc(kan,_15889,_15891).

paabadet0([paabadet0,_15911,lit(badet),!,_15956],_15900,_15902) --> 
    prep1(on,_15911,_15900,_15928),
    cc(badet,_15928,_15950),
    !,
    accept(_15956,_15950,_15902).

paabadet0([paabadet0,[]],_15887,_15887) --> 
    [].

quit(thanks,[quit,_15923,_15952,!],_15909,_15911) --> 
    w(adj2(good,nil),_15923,_15909,_15940),
    w(noun(trip,sin,u,n),_15952,_15940,_15911),
    !.

quit(bye,[quit,_15914,_15943],_15900,_15902) --> 
    w(verb(hear,pres,pass),_15914,_15900,_15931),
    skip_rest(_15943,_15931,_15902).

quit(bye,[quit,_15914,_15943],_15900,_15902) --> 
    w(verb(see,pres,pass),_15914,_15900,_15931),
    skip_rest(_15943,_15931,_15902).

quit(bye,[quit,_15914,_15943],_15900,_15902) --> 
    w(verb(tals,pres,pass),_15914,_15900,_15931),
    skip_rest(_15943,_15931,_15902).

quit(bye,[quit,lit(med),lit(vennlig),_15947,_15976],_15911,_15913) --> 
    cc(med,_15911,_15935),
    cc(vennlig,_15935,_15946),
    w(noun(greeting,_15890,_15891,_15892),_15947,_15946,_15964),
    skip_rest(_15976,_15964,_15913).

quit(bye,[quit,lit(vennlig),_15931,_15960],_15906,_15908) --> 
    cc(vennlig,_15906,_15930),
    w(noun(greeting,_15885,_15886,_15887),_15931,_15930,_15948),
    skip_rest(_15960,_15948,_15908).

quit(bye,[quit,_15915,_15944],_15901,_15903) --> 
    w(noun(greeting,_15880,_15881,_15882),_15915,_15901,_15932),
    skip_rest(_15944,_15932,_15903).

quit(bye,[quit,_15912],_15898,_15900) --> 
    w(noun(midnight,plu,def,n),_15912,_15898,_15900).

quit(bye,[quit,lit(jeg),lit(snakkes),_15937],_15901,_15903) --> 
    cc(jeg,_15901,_15925),
    cc(snakkes,_15925,_15936),
    skip_rest(_15937,_15936,_15903).

quit(bye,[quit,_15911],_15897,_15899) --> 
    w(verb(stop,imp,_15878),_15911,_15897,_15899).

quit(bye,[quit,lit(adjø)],_15893,_15895) --> 
    cc(adjø,_15893,_15895).

quit(bye,[quit,lit(på),lit(gjensyn)],_15898,_15900) --> 
    cc(på,_15898,_15922),
    cc(gjensyn,_15922,_15900).

quit(bye,[quit,_15905],_15891,_15893) --> 
    hadet(_15905,_15891,_15893).

quit(bye,[quit,_15908,_15932],_15894,_15896) --> 
    hadet(_15908,_15894,_15923),
    godt(_15932,_15923,_15896).

quit(bye,[quit,lit(hei),lit(da)],_15898,_15900) --> 
    cc(hei,_15898,_15922),
    cc(da,_15922,_15900).

quit(bye,[quit,lit(godnatt)],_15893,_15895) --> 
    cc(godnatt,_15893,_15895).

quit(bye,[quit,_15934,_15958,_15982,{}],_15920,_15922) --> 
    haen0(_15934,_15920,_15949),
    godt(_15958,_15949,_15973),
    w(noun(_15885,_15899,_15900,_15901),_15982,_15973,_15922),
    {user:testmember(_15885,[midnight,weekend,easter,summer])}.

quit(bye,[quit,lit(takk),_15938,_15967,_15996],_15913,_15915) --> 
    cc(takk,_15913,_15937),
    prep1(for,_15938,_15937,_15955),
    prep1(in,_15967,_15955,_15984),
    w(noun(day,sin,u,n),_15996,_15984,_15915).

quit(bye,[quit,_15924,_15948,_15977],_15910,_15912) --> 
    good0(_15924,_15910,_15939),
    w(noun(greeting,_15889,_15890,_15891),_15948,_15939,_15965),
    w(name(_15882,_15883,_15884),_15977,_15965,_15912).

quit(bye,[quit,_15925,_15949,_15978],_15911,_15913) --> 
    good0(_15925,_15911,_15940),
    w(noun(greeting,_15890,_15891,_15892),_15949,_15940,_15966),
    w(noun(_15882,_15883,_15884,_15885),_15978,_15966,_15913).

quit(bye,[quit,lit(far),lit(vel)],_15898,_15900) --> 
    cc(far,_15898,_15922),
    cc(vel,_15922,_15900).

quit(bye,[quit,_15934,_15978,lit(en),_16018,_16042],_15920,_15922) --> 
    optional(hello,_15934,_15920,_15966),
    w(verb(have,imp,_15899),_15978,_15966,_15995),
    cc(en,_15995,_16017),
    godt(_16018,_16017,_16033),
    w(noun(_15888,_15889,_15890,_15891),_16042,_16033,_15922).

quit(you_are_welcome,[quit,lit(på),lit(forhånd),_15940,!],_15904,_15906) --> 
    cc(på,_15904,_15928),
    cc(forhånd,_15928,_15939),
    thanks(_15940,_15939,_15906),
    !.

quit(you_are_welcome,[quit,_15916,_15945,!],_15902,_15904) --> 
    w(nb(1000,_15883),_15916,_15902,_15933),
    thanks(_15945,_15933,_15904),
    !.

quit(you_are_welcome,[quit,_15908,_15932],_15894,_15896) --> 
    thanks(_15908,_15894,_15923),
    alot(_15932,_15923,_15896).

quit(you_are_welcome,[quit,_15934,lit(å),_15974,_16003,lit(deg)],_15920,_15922) --> 
    w(adj2(nice,nil),_15934,_15920,_15951),
    cc(å,_15951,_15973),
    w(verb(speak,_15898,_15899),_15974,_15973,_15991),
    prep1(with,_16003,_15991,_16020),
    cc(deg,_16020,_15922).

quit(merry_christmas,[quit,_15910,lit(jul)],_15896,_15898) --> 
    godt(_15910,_15896,_15925),
    cc(jul,_15925,_15898).

quit(happy_new_year,[quit,_15908,_15932],_15894,_15896) --> 
    godt(_15908,_15894,_15923),
    newyear(_15932,_15923,_15896).

quit(bye,[quit,lit(hilsen),_15921],_15896,_15898) --> 
    cc(hilsen,_15896,_15920),
    skip_rest(_15921,_15920,_15898).

alot([alot,[]],_15887,_15887) --> 
    [].

alot([alot,lit(så),lit(mye)],_15894,_15896) --> 
    cc(så,_15894,_15915),
    cc(mye,_15915,_15896).

alot([alot,lit(så),lit(meget)],_15894,_15896) --> 
    cc(så,_15894,_15915),
    cc(meget,_15915,_15896).

alot([alot,lit(skal),lit(du),_15936],_15903,_15905) --> 
    cc(skal,_15903,_15924),
    cc(du,_15924,_15935),
    w(verb(have,inf,fin),_15936,_15935,_15905).

godt([godt,_15903],_15892,_15894) --> 
    w(adj2(good,nil),_15903,_15892,_15894).

godt([godt,_15904],_15893,_15895) --> 
    w(verb(go,past,part),_15904,_15893,_15895).

godt([godt,_15913,_15942],_15902,_15904) --> 
    w(adj2(good,nil),_15913,_15902,_15930),
    w(noun(day,sin,u,n),_15942,_15930,_15904).

deter0([deter0,_15904,!,_15933],_15893,_15895) --> 
    deter(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

deter0([deter0,_15904,!,_15933],_15893,_15895) --> 
    endofline(_15904,_15893,_15919),
    !,
    reject(_15933,_15919,_15895).

deter0([deter0,[]],_15887,_15887) --> 
    [].

deter([deter,lit(det),_15920,!,_15949],_15898,_15900) --> 
    cc(det,_15898,_15919),
    be(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

deter([deter,lit(dette),_15920,!,_15949],_15898,_15900) --> 
    cc(dette,_15898,_15919),
    be(_15920,_15919,_15935),
    !,
    accept(_15949,_15935,_15900).

haen0([haen0,lit(ha),lit(en),!,_15938],_15900,_15902) --> 
    cc(ha,_15900,_15921),
    cc(en,_15921,_15932),
    !,
    accept(_15938,_15932,_15902).

haen0([haen0,[]],_15887,_15887) --> 
    [].

personal('Takk',[personal,lit(velkommen),lit(til),!,_15945],_15904,_15906) --> 
    cc(velkommen,_15904,_15928),
    cc(til,_15928,_15939),
    !,
    skip_rest(_15945,_15939,_15906).

personal('Takk',[personal,lit(velkommen)],_15893,_15895) --> 
    cc(velkommen,_15893,_15895).

personal('Takk',[personal,lit(god),_15928],_15903,_15905) --> 
    cc(god,_15903,_15927),
    w(noun(health,sin,u,n),_15928,_15927,_15905).

personal('OK',[personal,lit(ps)],_15893,_15895) --> 
    cc(ps,_15893,_15895).

personal('OK',[personal,_15913,_15957,_15981],_15899,_15901) --> 
    optional(hello,_15913,_15899,_15945),
    so0(_15957,_15945,_15972),
    persok(_15981,_15972,_15901).

persok([persok,_15898],_15887,_15889) --> 
    okeys(_15898,_15887,_15889).

persok([persok,_15904],_15893,_15895) --> 
    w(verb(test,imp,fin),_15904,_15893,_15895).

persok([persok,lit(bra),_15914],_15892,_15894) --> 
    cc(bra,_15892,_15913),
    endofline(_15914,_15913,_15894).

persok([persok,lit(sorry)],_15889,_15891) --> 
    cc(sorry,_15889,_15891).

persok([persok,_15917,lit(så),_15957],_15906,_15908) --> 
    w(verb(be,imp,fin),_15917,_15906,_15934),
    cc(så,_15934,_15956),
    w(adj2(good,nil),_15957,_15956,_15908).

persok([persok,_15909,lit(det)],_15898,_15900) --> 
    w(verb(forget,imp,fin),_15909,_15898,_15926),
    cc(det,_15926,_15900).

persok([persok,_15913,_15942],_15902,_15904) --> 
    w(verb(forget,imp,fin),_15913,_15902,_15930),
    np(_15875,_15878:_15879,_15942,_15930,_15904).

persok([persok,_15915,lit(du),_15955,_15979],_15904,_15906) --> 
    w(verb(be,_15884,fin),_15915,_15904,_15932),
    cc(du,_15932,_15954),
    good(_15955,_15954,_15970),
    dadanow0(_15979,_15970,_15906).

persok([persok,lit(unnskyld)],_15889,_15891) --> 
    cc(unnskyld,_15889,_15891).

persok([persok,lit(hvordan),_15933,lit(du),lit(det),_15984],_15911,_15913) --> 
    cc(hvordan,_15911,_15932),
    w(verb(have,_15889,fin),_15933,_15932,_15950),
    cc(du,_15950,_15972),
    cc(det,_15972,_15983),
    dadanow0(_15984,_15983,_15913).

persok([persok,lit(hvordan),_15936,lit(det),_15976,_16005,_16029],_15914,_15916) --> 
    cc(hvordan,_15914,_15935),
    w(verb(stand,pres,fin),_15936,_15935,_15953),
    cc(det,_15953,_15975),
    prep1(to,_15976,_15975,_15993),
    withyou0(_16005,_15993,_16020),
    dadanow0(_16029,_16020,_15916).

persok([persok,_15928,lit(det),_15968,_15997,_16026,_16050],_15917,_15919) --> 
    w(verb(stand,pres,fin),_15928,_15917,_15945),
    cc(det,_15945,_15967),
    w(adj2(good,nil),_15968,_15967,_15985),
    prep1(to,_15997,_15985,_16014),
    withyou0(_16026,_16014,_16041),
    dadanow0(_16050,_16041,_15919).

persok([persok,_15909,_15938],_15898,_15900) --> 
    w(verb(stand,pres,fin),_15909,_15898,_15926),
    prep1(to,_15938,_15926,_15900).

persok([persok,lit(hvordan),_15924,_15948],_15902,_15904) --> 
    cc(hvordan,_15902,_15923),
    be(_15924,_15923,_15939),
    w(noun(situation,sin,def,n),_15948,_15939,_15904).

persok([persok,lit(hva),_15924,_15948],_15902,_15904) --> 
    cc(hva,_15902,_15923),
    be(_15924,_15923,_15939),
    w(noun(situation,sin,def,n),_15948,_15939,_15904).

persok([persok,_15925,lit(du),lit(det),_15976,_16005],_15914,_15916) --> 
    w(verb(have,_15887,fin),_15925,_15914,_15942),
    cc(du,_15942,_15964),
    cc(det,_15964,_15975),
    w(adj2(_15896,nil),_15976,_15975,_15993),
    dadanow0(_16005,_15993,_15916).

persok([persok,lit(jeg),_15939,lit(det),_15979,_16008,_16032,_16056],_15917,_15919) --> 
    cc(jeg,_15917,_15938),
    w(verb(have,_15895,fin),_15939,_15938,_15956),
    cc(det,_15956,_15978),
    negation0(_15900,_15979,_15978,_15996),
    so0(_16008,_15996,_16023),
    good(_16032,_16023,_16047),
    dadanow0(_16056,_16047,_15919).

persok([persok,lit(hvordan),_15931,lit(det),_15971,_15995],_15909,_15911) --> 
    cc(hvordan,_15909,_15930),
    w(verb(go,pres,fin),_15931,_15930,_15948),
    cc(det,_15948,_15970),
    withyou0(_15971,_15970,_15986),
    dadanow0(_15995,_15986,_15911).

persok([persok,_15930,lit(det),_15970,_16014,_16043,_16067],_15919,_15921) --> 
    w(verb(go,pres,fin),_15930,_15919,_15947),
    cc(det,_15947,_15969),
    optional([ikke],_15970,_15969,_16002),
    w(adj2(good,nil),_16014,_16002,_16031),
    withyou0(_16043,_16031,_16058),
    dadanow0(_16067,_16058,_15921).

persok([persok,lit(greitt)],_15889,_15891) --> 
    cc(greitt,_15889,_15891).

persok([persok,_15906,_15935],_15895,_15897) --> 
    w(adj2(good,nil),_15906,_15895,_15923),
    endofline(_15935,_15923,_15897).

thanks([thanks,_15907,_15931,_15955,_15979],_15896,_15898) --> 
    ogmen0(_15907,_15896,_15922),
    thousands0(_15931,_15922,_15946),
    takk(_15955,_15946,_15970),
    forhjelpen0(_15979,_15970,_15898).

takk([takk,_15903,lit(takk)],_15892,_15894) --> 
    hellos0(_15903,_15892,_15918),
    cc(takk,_15918,_15894).

takk([takk,_15904],_15893,_15895) --> 
    w(verb(thank,pres,fin),_15904,_15893,_15895).

takk([takk,lit(jeg),lit(vil),_15936],_15903,_15905) --> 
    cc(jeg,_15903,_15924),
    cc(vil,_15924,_15935),
    w(verb(thank,inf,_15882),_15936,_15935,_15905).

ogmen0([ogmen0,lit(og),!,_15922],_15895,_15897) --> 
    cc(og,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

ogmen0([ogmen0,lit(men),!,_15922],_15895,_15897) --> 
    cc(men,_15895,_15916),
    !,
    accept(_15922,_15916,_15897).

ogmen0([ogmen0,[]],_15887,_15887) --> 
    [].

thousands0([thousands0,_15904,!,_15933],_15893,_15895) --> 
    thousand(_15904,_15893,_15919),
    !,
    thousands0(_15933,_15919,_15895).

thousands0([thousands0,[]],_15887,_15887) --> 
    [].

thousand0([thousand0,_15904,!,_15933],_15893,_15895) --> 
    thousand(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

thousand0([thousand0,[]],_15887,_15887) --> 
    [].

thousand([thousand,_15909,!,_15943],_15898,_15900) --> 
    number(1000:_15881,_15909,_15898,_15926),
    !,
    accept(_15943,_15926,_15900).

thousand([thousand,_15898],_15887,_15889) --> 
    many1(_15898,_15887,_15889).

withyou0([withyou0,_15911,lit(_15882),!,_15956],_15900,_15902) --> 
    prep1(with,_15911,_15900,_15928),
    cc(_15882,_15928,_15950),
    !,
    accept(_15956,_15950,_15902).

withyou0([withyou0,[]],_15887,_15887) --> 
    [].

dadanow0([dadanow0,_15901,_15925],_15890,_15892) --> 
    todax(_15901,_15890,_15916),
    danow0(_15925,_15916,_15892).

dadanow0([dadanow0,_15898],_15887,_15889) --> 
    danow0(_15898,_15887,_15889).

danow0([danow0,_15913,_15942,lit(nå),!],_15902,_15904) --> 
    look_ahead([nå],_15913,_15902,_15930),
    notreachphrase(_15942,_15930,_15957),
    cc(nå,_15957,_15904),
    !.

danow0([danow0,[]],_15887,_15887) --> 
    [].

notreachphrase([notreachphrase,_15904,!,_15933],_15893,_15895) --> 
    reachphrase(_15904,_15893,_15919),
    !,
    reject(_15933,_15919,_15895).

notreachphrase([notreachphrase,[]],_15887,_15887) --> 
    [].

reachphrase([reachphrase,_15910,_15939,!],_15899,_15901) --> 
    w(verb(reach,inf,fin),_15910,_15899,_15927),
    look_ahead_np(_15939,_15927,_15901),
    !.

danow0([danow0,_15901,!],_15890,_15892) --> 
    danow(_15901,_15890,_15892),
    !.

danow0([danow0,[]],_15887,_15887) --> 
    [].

danow([danow,_15908,_15937,!],_15897,_15899) --> 
    w(adv(now),_15908,_15897,_15925),
    danow(_15937,_15925,_15899),
    !.

danow([danow,_15902],_15891,_15893) --> 
    w(adv(now),_15902,_15891,_15893).

danow([danow,lit(da),_15914],_15892,_15894) --> 
    cc(da,_15892,_15913),
    danow(_15914,_15913,_15894).

todax([todax,_15904,!,_15933],_15893,_15895) --> 
    today(_15904,_15893,_15919),
    !,
    accept(_15933,_15919,_15895).

todax([todax,_15911,lit(går),!,_15956],_15900,_15902) --> 
    prep1(in,_15911,_15900,_15928),
    cc(går,_15928,_15950),
    !,
    accept(_15956,_15950,_15902).

good0([good0,_15907,_15931,!,_15960],_15896,_15898) --> 
    so0(_15907,_15896,_15922),
    good(_15931,_15922,_15946),
    !,
    accept(_15960,_15946,_15898).

good0([good0,[]],_15887,_15887) --> 
    [].

good([good,_15903],_15892,_15894) --> 
    w(adj2(good,nil),_15903,_15892,_15894).

good([good,_15903],_15892,_15894) --> 
    w(adj2(clever,nil),_15903,_15892,_15894).

good([good,_15903],_15892,_15894) --> 
    w(adj2(fast,nil),_15903,_15892,_15894).

good([good,_15903],_15892,_15894) --> 
    w(adj2(funny,nil),_15903,_15892,_15894).

good([good,_15903],_15892,_15894) --> 
    w(adj2(honest,nil),_15903,_15892,_15894).

good([good,_15903],_15892,_15894) --> 
    w(adj2(nice,nil),_15903,_15892,_15894).

good([good,_15898],_15887,_15889) --> 
    okeys(_15898,_15887,_15889).

gmem(_15872,_15873,[gmem,{}],_15899,_15899) --> 
    {user:testmember(_15872,_15873)}.

panic(_15872,[panic,{}],_15895,_15895) --> 
    {user:write(_15872)}.

traceprint(_15872,_15873,[traceprint,{}],_15899,_15899) --> 
    {user:traceprint(_15872,_15873)}.

% Auxillary tables created datetime(2012,3,7,15,52,10)

%% Automatically created by metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

optional(itrailer,[optional,_16123,!],_16109,_16111) --> 
    itrailer(_16123,_16109,_16111),
    !.

optional([kanskje],[optional,lit(kanskje),!],_16111,_16113) --> 
    cc(kanskje,_16111,_16113),
    !.

optional([at],[optional,lit(at),!],_16111,_16113) --> 
    cc(at,_16111,_16113),
    !.

optional(grums,[optional,_16123,!],_16109,_16111) --> 
    grums(_16123,_16109,_16111),
    !.

optional(grums,[optional,_16123,!],_16109,_16111) --> 
    grums(_16123,_16109,_16111),
    !.

optional([ofte],[optional,lit(ofte),!],_16111,_16113) --> 
    cc(ofte,_16111,_16113),
    !.

optional([som],[optional,lit(som),!],_16111,_16113) --> 
    cc(som,_16111,_16113),
    !.

optional([','],[optional,lit(','),!],_16111,_16113) --> 
    cc(',',_16111,_16113),
    !.

optional([at],[optional,lit(at),!],_16111,_16113) --> 
    cc(at,_16111,_16113),
    !.

optional([meget],[optional,lit(meget),!],_16111,_16113) --> 
    cc(meget,_16111,_16113),
    !.

optional([det],[optional,lit(det),!],_16111,_16113) --> 
    cc(det,_16111,_16113),
    !.

optional([å],[optional,lit(å),!],_16111,_16113) --> 
    cc(å,_16111,_16113),
    !.

optional([å],[optional,lit(å),!],_16111,_16113) --> 
    cc(å,_16111,_16113),
    !.

optional([an],[optional,lit(an),!],_16111,_16113) --> 
    cc(an,_16111,_16113),
    !.

optional([ut],[optional,lit(ut),!],_16111,_16113) --> 
    cc(ut,_16111,_16113),
    !.

optional([neste],[optional,lit(neste),!],_16111,_16113) --> 
    cc(neste,_16111,_16113),
    !.

optional([det],[optional,lit(det),!],_16111,_16113) --> 
    cc(det,_16111,_16113),
    !.

optional(itrailer,[optional,_16123,!],_16109,_16111) --> 
    itrailer(_16123,_16109,_16111),
    !.

optional(itrailer,[optional,_16123,!],_16109,_16111) --> 
    itrailer(_16123,_16109,_16111),
    !.

optional([alle],[optional,lit(alle),!],_16111,_16113) --> 
    cc(alle,_16111,_16113),
    !.

optional([at],[optional,lit(at),!],_16111,_16113) --> 
    cc(at,_16111,_16113),
    !.

optional([som],[optional,lit(som),!],_16111,_16113) --> 
    cc(som,_16111,_16113),
    !.

optional([gang],[optional,lit(gang),!],_16111,_16113) --> 
    cc(gang,_16111,_16113),
    !.

optional(much,[optional,_16123,!],_16109,_16111) --> 
    much(_16123,_16109,_16111),
    !.

optional(w(verb(be,inf,fin)),[optional,_16129,!],_16115,_16117) --> 
    w(verb(be,inf,fin),_16129,_16115,_16117),
    !.

optional(w(adj2(old,nil)),[optional,_16128,!],_16114,_16116) --> 
    w(adj2(old,nil),_16128,_16114,_16116),
    !.

optional([om],[optional,lit(om),!],_16111,_16113) --> 
    cc(om,_16111,_16113),
    !.

optional([for],[optional,lit(for),!],_16111,_16113) --> 
    cc(for,_16111,_16113),
    !.

optional([på],[optional,lit(på),!],_16111,_16113) --> 
    cc(på,_16111,_16113),
    !.

optional([om],[optional,lit(om),!],_16111,_16113) --> 
    cc(om,_16111,_16113),
    !.

optional([på],[optional,lit(på),!],_16111,_16113) --> 
    cc(på,_16111,_16113),
    !.

optional([om],[optional,lit(om),!],_16111,_16113) --> 
    cc(om,_16111,_16113),
    !.

optional([å],[optional,lit(å),!],_16111,_16113) --> 
    cc(å,_16111,_16113),
    !.

optional([på],[optional,lit(på),!],_16111,_16113) --> 
    cc(på,_16111,_16113),
    !.

optional([på],[optional,lit(på),!],_16111,_16113) --> 
    cc(på,_16111,_16113),
    !.

optional([å],[optional,lit(å),!],_16111,_16113) --> 
    cc(å,_16111,_16113),
    !.

optional([til],[optional,lit(til),!],_16111,_16113) --> 
    cc(til,_16111,_16113),
    !.

optional([da],[optional,lit(da),!],_16111,_16113) --> 
    cc(da,_16111,_16113),
    !.

optional([bare],[optional,lit(bare),!],_16111,_16113) --> 
    cc(bare,_16111,_16113),
    !.

optional(w(prep(_16092)),[optional,_16127,!],_16113,_16115) --> 
    w(prep(_16092),_16127,_16113,_16115),
    !.

optional([til],[optional,lit(til),!],_16111,_16113) --> 
    cc(til,_16111,_16113),
    !.

optional([med],[optional,lit(med),!],_16111,_16113) --> 
    cc(med,_16111,_16113),
    !.

optional([på],[optional,lit(på),!],_16111,_16113) --> 
    cc(på,_16111,_16113),
    !.

optional(w(noun(year,_16093,_16094,n)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(year,_16093,_16094,n),_16130,_16116,_16118),
    !.

optional(w(prep(in)),[optional,_16127,!],_16113,_16115) --> 
    w(prep(in),_16127,_16113,_16115),
    !.

optional(w(noun(year,sin,u,n)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(year,sin,u,n),_16130,_16116,_16118),
    !.

optional([i],[optional,lit(i),!],_16111,_16113) --> 
    cc(i,_16111,_16113),
    !.

optional([i],[optional,lit(i),!],_16111,_16113) --> 
    cc(i,_16111,_16113),
    !.

optional([i],[optional,lit(i),!],_16111,_16113) --> 
    cc(i,_16111,_16113),
    !.

optional(['.'],[optional,lit('.'),!],_16111,_16113) --> 
    cc('.',_16111,_16113),
    !.

optional(w(noun(time,sin,def,n)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(time,sin,def,n),_16130,_16116,_16118),
    !.

optional([nå],[optional,lit(nå),!],_16111,_16113) --> 
    cc(nå,_16111,_16113),
    !.

optional([denne],[optional,lit(denne),!],_16111,_16113) --> 
    cc(denne,_16111,_16113),
    !.

optional(w(noun(route,sin,u,n)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(route,sin,u,n),_16130,_16116,_16118),
    !.

optional(w(noun(route,sin,u,n)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(route,sin,u,n),_16130,_16116,_16118),
    !.

optional(w(noun(bus,sin,_16094,_16095)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(bus,sin,_16094,_16095),_16130,_16116,_16118),
    !.

optional([for],[optional,lit(for),!],_16111,_16113) --> 
    cc(for,_16111,_16113),
    !.

optional([til],[optional,lit(til),!],_16111,_16113) --> 
    cc(til,_16111,_16113),
    !.

optional([av],[optional,lit(av),!],_16111,_16113) --> 
    cc(av,_16111,_16113),
    !.

optional(w(noun(time,sin,def,n)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(time,sin,def,n),_16130,_16116,_16118),
    !.

optional(w(noun(time,sin,def,n)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(time,sin,def,n),_16130,_16116,_16118),
    !.

optional(w(noun(time,_16093,def,_16095)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(time,_16093,def,_16095),_16130,_16116,_16118),
    !.

optional(w(prep(in)),[optional,_16127,!],_16113,_16115) --> 
    w(prep(in),_16127,_16113,_16115),
    !.

optional(w(noun(time,sin,def,n)),[optional,_16130,!],_16116,_16118) --> 
    w(noun(time,sin,def,n),_16130,_16116,_16118),
    !.

optional([h],[optional,lit(h),!],_16111,_16113) --> 
    cc(h,_16111,_16113),
    !.

optional([opp],[optional,lit(opp),!],_16111,_16113) --> 
    cc(opp,_16111,_16113),
    !.

optional([om],[optional,lit(om),!],_16111,_16113) --> 
    cc(om,_16111,_16113),
    !.

optional([mye],[optional,lit(mye),!],_16111,_16113) --> 
    cc(mye,_16111,_16113),
    !.

optional([nr],[optional,lit(nr),!],_16111,_16113) --> 
    cc(nr,_16111,_16113),
    !.

optional([slik],[optional,lit(slik),!],_16111,_16113) --> 
    cc(slik,_16111,_16113),
    !.

optional([så],[optional,lit(så),!],_16111,_16113) --> 
    cc(så,_16111,_16113),
    !.

optional(be,[optional,_16123,!],_16109,_16111) --> 
    be(_16123,_16109,_16111),
    !.

optional([at],[optional,lit(at),!],_16111,_16113) --> 
    cc(at,_16111,_16113),
    !.

optional([at],[optional,lit(at),!],_16111,_16113) --> 
    cc(at,_16111,_16113),
    !.

optional([seg],[optional,lit(seg),!],_16111,_16113) --> 
    cc(seg,_16111,_16113),
    !.

optional([at],[optional,lit(at),!],_16111,_16113) --> 
    cc(at,_16111,_16113),
    !.

optional(w(adj2(great,nil)),[optional,_16128,!],_16114,_16116) --> 
    w(adj2(great,nil),_16128,_16114,_16116),
    !.

optional(w(adj2(_16092,nil)),[optional,_16128,!],_16114,_16116) --> 
    w(adj2(_16092,nil),_16128,_16114,_16116),
    !.

optional(w(adj2(_16092,nil)),[optional,_16128,!],_16114,_16116) --> 
    w(adj2(_16092,nil),_16128,_16114,_16116),
    !.

optional(w(adj2(_16092,nil)),[optional,_16128,!],_16114,_16116) --> 
    w(adj2(_16092,nil),_16128,_16114,_16116),
    !.

optional([med],[optional,lit(med),!],_16111,_16113) --> 
    cc(med,_16111,_16113),
    !.

optional(sometimes,[optional,_16123,!],_16109,_16111) --> 
    sometimes(_16123,_16109,_16111),
    !.

optional([ofte],[optional,lit(ofte),!],_16111,_16113) --> 
    cc(ofte,_16111,_16113),
    !.

optional([bare],[optional,lit(bare),!],_16111,_16113) --> 
    cc(bare,_16111,_16113),
    !.

optional(grums,[optional,_16123,!],_16109,_16111) --> 
    grums(_16123,_16109,_16111),
    !.

optional(grums,[optional,_16123,!],_16109,_16111) --> 
    grums(_16123,_16109,_16111),
    !.

optional([for],[optional,lit(for),!],_16111,_16113) --> 
    cc(for,_16111,_16113),
    !.

optional([:],[optional,lit(:),!],_16111,_16113) --> 
    cc(:,_16111,_16113),
    !.

optional([:],[optional,lit(:),!],_16111,_16113) --> 
    cc(:,_16111,_16113),
    !.

optional([ja],[optional,lit(ja),!],_16111,_16113) --> 
    cc(ja,_16111,_16113),
    !.

optional([men],[optional,lit(men),!],_16111,_16113) --> 
    cc(men,_16111,_16113),
    !.

optional(paadeg,[optional,_16123,!],_16109,_16111) --> 
    paadeg(_16123,_16109,_16111),
    !.

optional(hello,[optional,_16123,!],_16109,_16111) --> 
    hello(_16123,_16109,_16111),
    !.

optional(hello,[optional,_16123,!],_16109,_16111) --> 
    hello(_16123,_16109,_16111),
    !.

optional([ikke],[optional,lit(ikke),!],_16111,_16113) --> 
    cc(ikke,_16111,_16113),
    !.

optional(_16083,[],_15863,_15863) --> 
    [].

xnp(_16245,_16246,[xnp,_16288],_16271,_16273) --> 
    virtual(xnp(_16245,_16246),_16288,_16271,_16273).

negation(_16245,[negation,_16282],_16268,_16270) --> 
    virtual(negation(_16245),_16282,_16268,_16270).

aux1([aux1,_16275],_16264,_16266) --> 
    virtual(aux1,_16275,_16264,_16266).

adverbial1(_16245,_16246,_16247,[adverbial1,_16294],_16274,_16276) --> 
    virtual(adverbial1(_16245,_16246,_16247),_16294,_16274,_16276).

xadverbial1(_16245,_16246,_16247,[xadverbial1,_16294],_16274,_16276) --> 
    virtual(xadverbial1(_16245,_16246,_16247),_16294,_16274,_16276).

subordinate(in_order_to,_16246,_16247,[subordinate,_16294],_16274,_16276) --> 
    virtual(subordinate(in_order_to,_16246,_16247),_16294,_16274,_16276).

subordinate(_16245,_16246,_16247,[subordinate,_16294],_16274,_16276) --> 
    virtual(subordinate(_16245,_16246,_16247),_16294,_16274,_16276).

adj1(_16245,_16250:_16251,_16247,_16248,[adj1,_16303],_16280,_16282) --> 
    virtual(adj1(_16245,_16250:_16251,_16247,_16248),_16303,_16280,_16282).

someone([someone,_16275],_16264,_16266) --> 
    virtual(someone,_16275,_16264,_16266).

obviousdate1(_16245,_16246,[obviousdate1,_16288],_16271,_16273) --> 
    virtual(obviousdate1(_16245,_16246),_16288,_16271,_16273).

np_kernel(0,_16246,_16247,[np_kernel,_16294],_16274,_16276) --> 
    virtual(np_kernel(0,_16246,_16247),_16294,_16274,_16276).

xnp(_16245,_16248::_16249,[xnp,_16291],_16274,_16276) --> 
    virtual(xnp(_16245,_16248::_16249),_16291,_16274,_16276).

pp(_16245,_16246,_16247,[pp,_16294],_16274,_16276) --> 
    virtual(pp(_16245,_16246,_16247),_16294,_16274,_16276).

np(_16245,_16246,[np,_16288],_16271,_16273) --> 
    virtual(np(_16245,_16246),_16288,_16271,_16273).

prep(to,[prep,_16282],_16268,_16270) --> 
    virtual(prep(to),_16282,_16268,_16270).

prep(_16245,[prep,_16282],_16268,_16270) --> 
    virtual(prep(_16245),_16282,_16268,_16270).

noun_phrase1(_16245,_16246,[noun_phrase1,_16288],_16271,_16273) --> 
    virtual(noun_phrase1(_16245,_16246),_16288,_16271,_16273).

xadverb(_16245,_16246,[xadverb,_16288],_16271,_16273) --> 
    virtual(xadverb(_16245,_16246),_16288,_16271,_16273).

np(_16245,_16248::_16249,[np,_16291],_16274,_16276) --> 
    virtual(np(_16245,_16248::_16249),_16291,_16274,_16276).

be(_16245,[be,_16282],_16268,_16270) --> 
    virtual(be(_16245),_16282,_16268,_16270).

thereit([thereit,_16275],_16264,_16266) --> 
    virtual(thereit,_16275,_16264,_16266).

be([be,_16275],_16264,_16266) --> 
    virtual(be,_16275,_16264,_16266).

adverbial1(_16245,_16246,_16249::_16250,[adverbial1,_16297],_16277,_16279) --> 
    virtual(adverbial1(_16245,_16246,_16249::_16250),_16297,_16277,_16279).

lexv(_16245,_16246,_16247,fin,[lexv,_16300],_16277,_16279) --> 
    virtual(lexv(_16245,_16246,_16247,fin),_16300,_16277,_16279).

ap(_16245,_16246,_16247,_16248,[ap,_16300],_16277,_16279) --> 
    virtual(ap(_16245,_16246,_16247,_16248),_16300,_16277,_16279).

adj1(_16245,_16246,_16247,_16248,[adj1,_16300],_16277,_16279) --> 
    virtual(adj1(_16245,_16246,_16247,_16248),_16300,_16277,_16279).

\(state(_16248,_16249),(xnp(_16254,_16255),w(verb(be,_16263,fin)),w(adj2(_16268,nil))),[\,_16311],_16294,_16296) --> 
    virtual(state(_16248,_16249)\(xnp(_16254,_16255),w(verb(be,_16263,fin)),w(adj2(_16268,nil))),_16311,_16294,_16296).

something([something,_16275],_16264,_16266) --> 
    virtual(something,_16275,_16264,_16266).

lexv(iv,_16246,pres,fin,[lexv,_16300],_16277,_16279) --> 
    virtual(lexv(iv,_16246,pres,fin),_16300,_16277,_16279).

np1(_16245,_16246,[np1,_16288],_16271,_16273) --> 
    virtual(np1(_16245,_16246),_16288,_16271,_16273).

adverbial(_16245,_16246,_16249::_16250,[adverbial,_16297],_16277,_16279) --> 
    virtual(adverbial(_16245,_16246,_16249::_16250),_16297,_16277,_16279).

lexv(iv,_16246,_16247,fin,[lexv,_16300],_16277,_16279) --> 
    virtual(lexv(iv,_16246,_16247,fin),_16300,_16277,_16279).

the([the,_16275],_16264,_16266) --> 
    virtual(the,_16275,_16264,_16266).

nameq1(_16248:person,_16246,[nameq1,_16291],_16274,_16276) --> 
    virtual(nameq1(_16248:person,_16246),_16291,_16274,_16276).

obviousclock1(_16248:clock,_16248 isa clock,[obviousclock1,_16294],_16277,_16279) --> 
    virtual(obviousclock1(_16248:clock,_16248 isa clock),_16294,_16277,_16279).

whatbe([whatbe,_16275],_16264,_16266) --> 
    virtual(whatbe,_16275,_16264,_16266).

obviousclock1(_16245,_16246,[obviousclock1,_16288],_16271,_16273) --> 
    virtual(obviousclock1(_16245,_16246),_16288,_16271,_16273).

pronoun(_16245,[pronoun,_16282],_16268,_16270) --> 
    virtual(pronoun(_16245),_16282,_16268,_16270).

noun_phrase1(_16245,_16248::_16249,[noun_phrase1,_16291],_16274,_16276) --> 
    virtual(noun_phrase1(_16245,_16248::_16249),_16291,_16274,_16276).

npgap(_16245,[npgap,_16282],_16268,_16270) --> 
    virtual(npgap(_16245),_16282,_16268,_16270).

npgap(_16247:thing,[npgap,_16285],_16271,_16273) --> 
    virtual(npgap(_16247:thing),_16285,_16271,_16273).

noun(_16245,_16246,_16247,_16248,_16249,_16250,[noun,_16312],_16283,_16285) --> 
    virtual(noun(_16245,_16246,_16247,_16248,_16249,_16250),_16312,_16283,_16285).

lexv(tv,_16246,_16247,fin,[lexv,_16300],_16277,_16279) --> 
    virtual(lexv(tv,_16246,_16247,fin),_16300,_16277,_16279).

which([which,_16275],_16264,_16266) --> 
    virtual(which,_16275,_16264,_16266).

np1(_16245,_16248::_16249,[np1,_16291],_16274,_16276) --> 
    virtual(np1(_16245,_16248::_16249),_16291,_16274,_16276).

lexv(tv,know1,_16247,fin,[lexv,_16300],_16277,_16279) --> 
    virtual(lexv(tv,know1,_16247,fin),_16300,_16277,_16279).

do([do,_16275],_16264,_16266) --> 
    virtual(do,_16275,_16264,_16266).

xadverbial1(_16245,_16246,_16249::_16250,[xadverbial1,_16297],_16277,_16279) --> 
    virtual(xadverbial1(_16245,_16246,_16249::_16250),_16297,_16277,_16279).

prep(in,[prep,_16282],_16268,_16270) --> 
    virtual(prep(in),_16282,_16268,_16270).

adverbial1(in,_16246,_16249::_16250,[adverbial1,_16297],_16277,_16279) --> 
    virtual(adverbial1(in,_16246,_16249::_16250),_16297,_16277,_16279).

xadverbial1(in,_16246,_16249::_16250,[xadverbial1,_16297],_16277,_16279) --> 
    virtual(xadverbial1(in,_16246,_16249::_16250),_16297,_16277,_16279).

adverbial1(nil,_16246,_16249::_16250,[adverbial1,_16297],_16277,_16279) --> 
    virtual(adverbial1(nil,_16246,_16249::_16250),_16297,_16277,_16279).

prep(from,[prep,_16282],_16268,_16270) --> 
    virtual(prep(from),_16282,_16268,_16270).

who([who,_16275],_16264,_16266) --> 
    virtual(who,_16275,_16264,_16266).

a([a,_16275],_16264,_16266) --> 
    virtual(a,_16275,_16264,_16266).

noun(_16245,_16246,u,n,_16249,_16250,[noun,_16312],_16283,_16285) --> 
    virtual(noun(_16245,_16246,u,n,_16249,_16250),_16312,_16283,_16285).

that([that,_16275],_16264,_16266) --> 
    virtual(that,_16275,_16264,_16266).

xadverbial1(how,nil,_16249::_16249,[xadverbial1,_16297],_16277,_16279) --> 
    virtual(xadverbial1(how,nil,_16249::_16249),_16297,_16277,_16279).

prep(with,[prep,_16282],_16268,_16270) --> 
    virtual(prep(with),_16282,_16268,_16270).

xadverbial1(nil,_16246,_16247,[xadverbial1,_16294],_16274,_16276) --> 
    virtual(xadverbial1(nil,_16246,_16247),_16294,_16274,_16276).

the(_16245,[the,_16282],_16268,_16270) --> 
    virtual(the(_16245),_16282,_16268,_16270).

of([of,_16275],_16264,_16266) --> 
    virtual(of,_16275,_16264,_16266).

prep1(in,[prep1,_16282],_16268,_16270) --> 
    virtual(prep1(in),_16282,_16268,_16270).

number(_16245,[number,_16282],_16268,_16270) --> 
    virtual(number(_16245),_16282,_16268,_16270).

lexv(dtv,_16246,_16247,_16248,[lexv,_16300],_16277,_16279) --> 
    virtual(lexv(dtv,_16246,_16247,_16248),_16300,_16277,_16279).

negation0(_16245,[negation0,_16282],_16268,_16270) --> 
    virtual(negation0(_16245),_16282,_16268,_16270).

adverbx(_16245,_16246,_16247,[adverbx,_16294],_16274,_16276) --> 
    virtual(adverbx(_16245,_16246,_16247),_16294,_16274,_16276).

particle(_16245,[particle,_16282],_16268,_16270) --> 
    virtual(particle(_16245),_16282,_16268,_16270).

verb_mod1(_16245,_16246,_16247,_16248,_16251::_16252,[verb_mod1,_16309],_16283,_16285) --> 
    virtual(verb_mod1(_16245,_16246,_16247,_16248,_16251::_16252),_16309,_16283,_16285).

lexv(tv,_16246,pres,fin,[lexv,_16300],_16277,_16279) --> 
    virtual(lexv(tv,_16246,pres,fin),_16300,_16277,_16279).

prep1(_16245,[prep1,_16282],_16268,_16270) --> 
    virtual(prep1(_16245),_16282,_16268,_16270).

noun_phrase1(_16245,_16248:_16249,[noun_phrase1,_16291],_16274,_16276) --> 
    virtual(noun_phrase1(_16245,_16248:_16249),_16291,_16274,_16276).

lexv(_16245,know1,_16247,fin,[lexv,_16300],_16277,_16279) --> 
    virtual(lexv(_16245,know1,_16247,fin),_16300,_16277,_16279).

lexv(tv,_16246,past,fin,[lexv,_16300],_16277,_16279) --> 
    virtual(lexv(tv,_16246,past,fin),_16300,_16277,_16279).

this([this,_16275],_16264,_16266) --> 
    virtual(this,_16275,_16264,_16266).

adverbial1(_16245,_16249:_16250,_16247,[adverbial1,_16297],_16277,_16279) --> 
    virtual(adverbial1(_16245,_16249:_16250,_16247),_16297,_16277,_16279).

adverbial1(nil,_16249:coevent,_16247,[adverbial1,_16297],_16277,_16279) --> 
    virtual(adverbial1(nil,_16249:coevent,_16247),_16297,_16277,_16279).

xadverbial1(_16245,_16249:_16250,_16247,[xadverbial1,_16297],_16277,_16279) --> 
    virtual(xadverbial1(_16245,_16249:_16250,_16247),_16297,_16277,_16279).

adverb(_16245,_16246,_16247,[adverb,_16294],_16274,_16276) --> 
    virtual(adverb(_16245,_16246,_16247),_16294,_16274,_16276).

some([some,_16275],_16264,_16266) --> 
    virtual(some,_16275,_16264,_16266).

much([much,_16275],_16264,_16266) --> 
    virtual(much,_16275,_16264,_16266).

little([little,_16275],_16264,_16266) --> 
    virtual(little,_16275,_16264,_16266).

every([every,_16275],_16264,_16266) --> 
    virtual(every,_16275,_16264,_16266).

relpron(agent,[relpron,_16282],_16268,_16270) --> 
    virtual(relpron(agent),_16282,_16268,_16270).

relpron(thing,[relpron,_16282],_16268,_16270) --> 
    virtual(relpron(thing),_16282,_16268,_16270).

time1(_16245,[time1,_16282],_16268,_16270) --> 
    virtual(time1(_16245),_16282,_16268,_16270).

and1([and1,_16275],_16264,_16266) --> 
    virtual(and1,_16275,_16264,_16266).

thispron([thispron,_16275],_16264,_16266) --> 
    virtual(thispron,_16275,_16264,_16266).

clock_kernel(_16248:clock,_16248 isa clock,[clock_kernel,_16294],_16277,_16279) --> 
    virtual(clock_kernel(_16248:clock,_16248 isa clock),_16294,_16277,_16279).

nameq1(_16245,_16246,[nameq1,_16288],_16271,_16273) --> 
    virtual(nameq1(_16245,_16246),_16288,_16271,_16273).

