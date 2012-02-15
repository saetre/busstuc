% Auxillary tables created datetime(2012,2,15,17,59,19)

%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

:- :-prolog_flag(discontiguous_warnings,_,off).

sentence([gpsflag:::_7707|_7704],[sentence,{},_7768,!,_7802],_7744,_7746) --> 
    {user:value(gpsflag,true)},
    origin_phrase(_7707,_7768,_7744,_7785),
    !,
    sentences(_7704,_7802,_7785,_7746).

sentence(_7702,[sentence,{},_7757],_7733,_7735) --> 
    {user:(\+value(gpsflag,true))},
    sentences(_7702,_7757,_7733,_7735).

origin_phrase([_7703|_7704],[origin_phrase,lit('('),!,_7776,{},_7815],_7746,_7748) --> 
    cc('(',_7746,_7770),
    !,
    origin_element(_7703,_7776,_7770,_7793),
    {user:set(new_origin,true)},
    origin_phrase0n(_7704,_7815,_7793,_7748).

origin_phrase([],[origin_phrase,[]],_7721,_7721) --> 
    [].

origin_phrase0n([_7703|_7704],[origin_phrase0n,_7747,!,_7781],_7733,_7735) --> 
    origin_element(_7703,_7747,_7733,_7764),
    !,
    origin_phrase0n(_7704,_7781,_7764,_7735).

origin_phrase0n([],[origin_phrase0n,lit(')')],_7723,_7725) --> 
    cc(')',_7723,_7725).

origin_element(gps_origin(_7704,_7705),[origin_element,_7750,lit(+),_7790],_7736,_7738) --> 
    gps_origin(_7704,_7750,_7736,_7767),
    cc(+,_7767,_7789),
    gps_time(_7705,_7790,_7789,_7738).

gps_origin(_7702,[gps_origin,_7745,!],_7731,_7733) --> 
    name_phrase(name,_7702:_7712,_7709,_7745,_7731,_7733),
    !.

gps_time(_7702,[gps_time,_7740],_7726,_7728) --> 
    w(nb(_7702,num),_7740,_7726,_7728).

sentence01(_7702,[sentence01,_7737],_7723,_7725) --> 
    implicitq(_7702,_7737,_7723,_7725).

sentence01(_7702,[sentence01,_7737],_7723,_7725) --> 
    sentence1(_7702,_7737,_7723,_7725).

sentences([new:::_7707],[sentences,{},_7772,_7801,!,_7830],_7748,_7750) --> 
    {user:value(queryflag,false)},
    declaration(_7707,_7772,_7748,_7789),
    terminatore(_7801,_7789,_7816),
    !,
    accept(_7830,_7816,_7750).

sentences([_7703],[sentences,{},_7777,_7801,_7830,_7874,!,_7903],_7753,_7755) --> 
    {user:value(queryflag,true)},
    greetings0(_7777,_7753,_7792),
    implicitq(_7703,_7801,_7792,_7818),
    optional(itrailer,_7830,_7818,_7862),
    terminatores(_7874,_7862,_7889),
    !,
    accept(_7903,_7889,_7755).

sentences(_7702,[sentences,_7754,{},_7793,_7817],_7740,_7742) --> 
    onesentence(_7713,_7754,_7740,_7771),
    {user:_7713\==error},
    check_stop(_7793,_7771,_7808),
    moresentences0(_7713,_7702,_7817,_7808,_7742).

moresentences0(_7702,_7703,[moresentences0,_7759,_7788,!,_7817,_7841],_7742,_7744) --> 
    onesentence(_7718,_7759,_7742,_7776),
    check_stop(_7788,_7776,_7803),
    !,
    accept(_7817,_7803,_7832),
    evenmore0(_7702,_7718,_7703,_7841,_7832,_7744).

evenmore0(_7702,error,[_7702,error],[evenmore0,!,_7759],_7734,_7736) --> 
    !,
    skip_rest(_7759,_7734,_7736).

evenmore0(_7702,[],[_7702],[evenmore0,[],!],_7732,_7732) --> 
    [],
    !.

evenmore0(_7702,_7703,[_7702|_7706],[evenmore0,_7752],_7732,_7734) --> 
    moresentences0(_7703,_7706,_7752,_7732,_7734).

onesentence([],[onesentence,_7741,!,_7770],_7727,_7729) --> 
    endofline(_7741,_7727,_7756),
    !,
    accept(_7770,_7756,_7729).

onesentence(_7702,[onesentence,_7746,_7775,!,_7804],_7732,_7734) --> 
    conf_statement(_7702,_7746,_7732,_7763),
    endofline(_7775,_7763,_7790),
    !,
    accept(_7804,_7790,_7734).

onesentence(_7702,[onesentence,_7746,_7770,_7799,_7823],_7732,_7734) --> 
    grums0(_7746,_7732,_7761),
    sentence1(_7702,_7770,_7761,_7787),
    sentence_delimiter(_7799,_7787,_7814),
    accept(_7823,_7814,_7734).

onesentence(error,[onesentence,_7735],_7721,_7723) --> 
    skip_rest(_7735,_7721,_7723).

notify([notify,_7734],_7723,_7725) --> 
    w(verb(notify,_7705,_7706),_7734,_7723,_7725).

notify([notify,_7735],_7724,_7726) --> 
    w(noun(notification,_7705,_7706,_7707),_7735,_7724,_7726).

conf_statement(confirm:::_7705,[conf_statement,_7740],_7726,_7728) --> 
    confirm(_7705,_7740,_7726,_7728).

confirm(false,[confirm,lit(jeg),_7765,lit(ikke),_7805],_7740,_7742) --> 
    cc(jeg,_7740,_7764),
    w(verb(know,pres,fin),_7765,_7764,_7782),
    cc(ikke,_7782,_7804),
    endofline(_7805,_7804,_7742).

confirm(true,[confirm,lit(ja),_7751],_7726,_7728) --> 
    cc(ja,_7726,_7750),
    of_course0(_7751,_7750,_7728).

confirm(true,[confirm,lit(jo),_7751],_7726,_7728) --> 
    cc(jo,_7726,_7750),
    of_course0(_7751,_7750,_7728).

confirm(false,[confirm,lit(nei),_7751],_7726,_7728) --> 
    cc(nei,_7726,_7750),
    of_coursenot0(_7751,_7750,_7728).

confirm(true,[confirm,_7735],_7721,_7723) --> 
    of_course(_7735,_7721,_7723).

confirm(false,[confirm,_7740,lit(ikke)],_7726,_7728) --> 
    of_course(_7740,_7726,_7755),
    cc(ikke,_7755,_7728).

sentence_delimiter([sentence_delimiter,lit(for),_7748],_7726,_7728) --> 
    cc(for,_7726,_7747),
    look_ahead([hvis],_7748,_7747,_7728).

sentence_delimiter([sentence_delimiter,lit(;)],_7719,_7721) --> 
    cc(;,_7719,_7721).

sentence_delimiter([sentence_delimiter,_7728],_7717,_7719) --> 
    terminatore(_7728,_7717,_7719).

terminatore0([terminatore0,_7734,!,_7763],_7723,_7725) --> 
    terminatore(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

terminatore0([terminatore0,[]],_7717,_7717) --> 
    [].

terminatores([terminatores,_7734,!,_7763],_7723,_7725) --> 
    terminator(_7734,_7723,_7749),
    !,
    terminatores(_7763,_7749,_7725).

terminatores([terminatores,_7737,_7761,!,_7790],_7726,_7728) --> 
    check_stop(_7737,_7726,_7752),
    endofline(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

terminatore([terminatore,_7728],_7717,_7719) --> 
    terminator1(_7728,_7717,_7719).

terminator1([terminator1,_7777,_7801,_7830,_7859,_7888,!,_7922],_7766,_7768) --> 
    terminator(_7777,_7766,_7792),
    not_look_ahead(w(nb(_7724,num)),_7801,_7792,_7818),
    not_look_ahead(w(name(_7731,_7732,month)),_7830,_7818,_7847),
    not_look_ahead(w(name(_7731,_7740,day)),_7859,_7847,_7876),
    not_look_ahead(w(name(_7731,_7748,date)),_7888,_7876,_7905),
    !,
    accept(_7922,_7905,_7768).

terminator1([terminator1,_7737,_7761,!,_7790],_7726,_7728) --> 
    check_stop_locations(_7737,_7726,_7752),
    endofline(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

look_ahead_endofline([look_ahead_endofline,_7739,!],_7728,_7730) --> 
    look_ahead_lit(['.',?,!],_7739,_7728,_7730),
    !.

look_ahead_endofline([look_ahead_endofline,_7728],_7717,_7719) --> 
    end_of_line(_7728,_7717,_7719).

endofline0([endofline0,_7734,!,_7763],_7723,_7725) --> 
    terminator(_7734,_7723,_7749),
    !,
    endofline0(_7763,_7749,_7725).

endofline0([endofline0,_7728],_7717,_7719) --> 
    end_of_line0(_7728,_7717,_7719).

endofline([endofline,_7737,_7761,!,_7790],_7726,_7728) --> 
    terminator(_7737,_7726,_7752),
    endofline(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

endofline([endofline,lit(:),_7747,!],_7725,_7727) --> 
    cc(:,_7725,_7746),
    end_of_line(_7747,_7746,_7727),
    !.

endofline([endofline,lit(+),{},_7768,!,_7797],_7736,_7738) --> 
    cc(+,_7736,_7757),
    {user:value(busflag,true)},
    endofline(_7768,_7757,_7783),
    !,
    accept(_7797,_7783,_7738).

endofline([endofline,_7728],_7717,_7719) --> 
    end_of_line(_7728,_7717,_7719).

endofline1([endofline1,lit('.')],_7719,_7721) --> 
    cc('.',_7719,_7721).

endofline1([endofline1,lit(?)],_7719,_7721) --> 
    cc(?,_7719,_7721).

endofline1([endofline1,lit(!)],_7719,_7721) --> 
    cc(!,_7719,_7721).

check_stop_locations([check_stop_locations,_7731,!],_7720,_7722) --> 
    check_stop(_7731,_7720,_7722),
    !.

assemble_stop_locations([_7706+_7707|_7704],[assemble_stop_locations,_7767,lit(+),_7807,!,_7841],_7753,_7755) --> 
    w(name(_7706,n,_7727),_7767,_7753,_7784),
    cc(+,_7784,_7806),
    w(nb(_7707,num),_7807,_7806,_7824),
    !,
    check_stop_locations(_7704,_7841,_7824,_7755).

assemble_stop_locations([],[assemble_stop_locations,_7735],_7721,_7723) --> 
    end_of_line(_7735,_7721,_7723).

sentence1(new:::_7705,[sentence1,_7788,_7812,lit(at),!,_7857,_7891],_7774,_7776) --> 
    hellos0(_7788,_7774,_7803),
    w(adj2(_7733,_7734),_7812,_7803,_7829),
    cc(at,_7829,_7851),
    !,
    clausal_object1(_7743,_7744,_7857,_7851,_7876),
    pushstack(first,(xnp(_7743,_7744),w(verb(be,pres,fin)),w(adj2(_7733,_7734))),nil,_7876,_7934),
    statreal(_7705,_7891,_7934,_7776).

sentence1(new:::_7705,[sentence1,_7763,_7787,!,_7835],_7749,_7751) --> 
    detaa(_7763,_7749,_7778),
    pushstack(first,[noen],nil,_7778,_7800),clausal_object1(_7719,_7720,_7787,_7800,_7815),
    !,
    pushstack(first,xnp(_7719,_7720),nil,_7815,_7876),
    statreal(_7705,_7835,_7876,_7751).

detaa([detaa,lit(det),lit(å)],_7724,_7726) --> 
    cc(det,_7724,_7745),
    cc(å,_7745,_7726).

detaa([detaa,lit(å)],_7719,_7721) --> 
    cc(å,_7719,_7721).

sentence1(new:::_7705,[sentence1,_7758,_7782,!,_7821],_7744,_7746) --> 
    hvorvidt(_7758,_7744,_7773),
    clausal_object1(_7719,_7720,_7782,_7773,_7801),
    !,
    pushstack(first,xnp(_7719,_7720),nil,_7801,_7862),
    statreal(_7705,_7821,_7862,_7746).

hvorvidt([hvorvidt,lit(hvorvidt)],_7719,_7721) --> 
    cc(hvorvidt,_7719,_7721).

hvorvidt([hvorvidt,lit(det),lit(at)],_7724,_7726) --> 
    cc(det,_7724,_7745),
    cc(at,_7745,_7726).

hvorvidt([hvorvidt,lit(at)],_7719,_7721) --> 
    cc(at,_7719,_7721).

sentence1(new:::_7705,[sentence1,_7751,_7775,!,_7809],_7737,_7739) --> 
    redundant(_7751,_7737,_7766),
    be_it_tf_that(_7718,_7775,_7766,_7792),
    !,
    statreal(_7705,_7809,_7792,_7739).

sentence1(new:::_7705,[sentence1,_7770,_7799,_7828],_7756,_7758) --> 
    w(verb(be,_7728,fin),_7770,_7756,_7787),
    look_ahead_lit([mye],_7799,_7787,_7816),
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_7816,_7838),
    statement(_7705,_7828,_7838,_7758).

sentence1(new:::_7705,[sentence1,_7784,_7813,lit(som),!,_7853],_7770,_7772) --> 
    w(verb(_7735,_7736,pass),_7784,_7770,_7801),
    redundant0(_7813,_7801,_7828),
    cc(som,_7828,_7847),
    !,
    pushstack(first,([noen],w(verb(_7735,_7736,fin)),[dette],[som]),nil,_7847,_7863),
    statreal(_7705,_7853,_7863,_7772).

sentence1(new:::_7705,[sentence1,_7778,_7822,_7851,_7880],_7764,_7766) --> 
    optional([kanskje],_7778,_7764,_7810),
    negation(_7725,_7822,_7810,_7839),
    not_look_ahead([alle],_7851,_7839,_7868),
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_7725)),nil,_7868,_7923),
    statreal(_7705,_7880,_7923,_7766).

sentence1(new:::_7705,[sentence1,_7866,_7895,_7924,_7953,_7987,_8016,lit(å),_8056,!,_8090],_7852,_7854) --> 
    one_of_lit([den,det,dette,disse,slike],_7866,_7852,_7883),
    w(noun(_7757,_7758,_7759,n),_7895,_7883,_7912),
    w(verb(be,_7784,fin),_7924,_7912,_7941),
    subject(_7787,_7788,_7953,_7941,_7972),
    w(adj2(_7792,nil),_7987,_7972,_8004),
    w(prep(_7797),_8016,_8004,_8033),
    cc(å,_8033,_8055),
    w(verb(_7803,inf,fin),_8056,_8055,_8073),
    !,
    pushstack(first,(xnp(_7787,_7788),w(verb(be,_7784,fin)),w(adj2(_7792,nil)),w(prep(_7797)),[å],w(verb(_7803,inf,fin)),w(noun(_7757,_7758,_7759,n))),nil,_8073,_8131),
    statreal(_7705,_8090,_8131,_7854).

sentence1(new:::_7705,[sentence1,_7838,_7867,_7896,_7925,_7959,_7988,!,_8022],_7824,_7826) --> 
    one_of_lit([den,det,dette,disse,slike],_7838,_7824,_7855),
    w(noun(_7745,_7746,_7747,n),_7867,_7855,_7884),
    w(verb(be,_7772,fin),_7896,_7884,_7913),
    subject(_7775,_7776,_7925,_7913,_7944),
    w(adj2(_7780,nil),_7959,_7944,_7976),
    w(prep(_7785),_7988,_7976,_8005),
    !,
    pushstack(free,(xnp(_7775,_7776),w(verb(be,_7772,fin)),w(adj2(_7780,nil)),w(prep(_7785)),w(noun(_7745,_7746,_7747,n))),nil,_8005,_8063),
    statreal(_7705,_8022,_8063,_7826).

sentence1(new:::_7705,[sentence1,_7842,_7871,_7900,_7929,_7963,_7992,!,_8026],_7828,_7830) --> 
    one_of_lit([den,det,dette,disse,slike],_7842,_7828,_7859),
    w(noun(_7745,_7746,_7747,n),_7871,_7859,_7888),
    w(verb(_7771,_7772,fin),_7900,_7888,_7917),
    subject(_7775,_7776,_7929,_7917,_7948),
    w(noun(_7780,sin,u,n),_7963,_7948,_7980),
    w(prep(_7787),_7992,_7980,_8009),
    !,
    pushstack(first,(xnp(_7775,_7776),w(verb(_7771,_7772,fin)),w(noun(_7780,sin,u,n)),w(prep(_7787)),w(noun(_7745,_7746,_7747,n))),nil,_8009,_8067),
    statreal(_7705,_8026,_8067,_7830).

sentence1(new:::_7705,[sentence1,_7822,_7851,_7880,{},_7919,!,_7958],_7808,_7810) --> 
    one_of_lit([den,det,dette,disse,slike],_7822,_7808,_7839),
    w(noun(_7736,_7737,_7738,n),_7851,_7839,_7868),
    w(verb(_7762,_7763,fin),_7880,_7868,_7897),
    {user:(\+testmember(_7762,[have,get]))},
    subject(_7777,_7778,_7919,_7897,_7938),
    !,
    pushstack(first,(xnp(_7777,_7778),w(verb(_7762,_7763,fin)),w(noun(_7736,_7737,_7738,n))),nil,_7938,_7999),
    statreal(_7705,_7958,_7999,_7810).

sentence1(new:::_7705,[sentence1,lit(hvorvidt),_7802,!,lit(kan),_7852,!,_7886],_7777,_7779) --> 
    cc(hvorvidt,_7777,_7801),
    clausal_object1(_7734,_7735,_7802,_7801,_7821),
    !,
    cc(kan,_7821,_7851),
    w(verb(_7746,_7747,pass),_7852,_7851,_7869),
    !,
    pushstack(first,([dere],w(verb(_7746,_7747,fin)),xnp(_7734,_7735)),nil,_7869,_7927),
    statreal(_7705,_7886,_7927,_7779).

sentence1(new:::_7705,[sentence1,_7784,_7813,_7847,!,_7881],_7770,_7772) --> 
    w(verb(_7727,_7733,_7734),_7784,_7770,_7801),
    gmem(_7727,[talk,speak],_7813,_7801,_7832),
    look_ahead(w(prep(_7747)),_7847,_7832,_7864),
    !,
    pushstack(first,([du],w(verb(_7727,pres))),nil,_7864,_7891),
    statreal(_7705,_7881,_7891,_7772).

sentence1(new:::_7705,[sentence1,_7757,_7781,!,_7810],_7743,_7745) --> 
    aux1(_7757,_7743,_7772),
    not_look_ahead_np(_7781,_7772,_7796),
    !,
    pushstack(first,([jeg],aux1),nil,_7796,_7853),
    statreal(_7705,_7810,_7853,_7745).

sentence1(new:::_7705,[sentence1,_7766,!,_7800],_7752,_7754) --> 
    w(verb(_7721,past,part),_7766,_7752,_7783),
    !,
    pushstack(first,([jeg],w(verb(_7721,past,fin))),nil,_7783,_7810),
    statreal(_7705,_7800,_7810,_7754).

sentence1(new:::_7705,[sentence1,_7766,!,_7800],_7752,_7754) --> 
    w(verb(_7721,past,part),_7766,_7752,_7783),
    !,
    pushstack(first,([jeg],w(verb(_7721,past,fin))),nil,_7783,_7810),
    statreal(_7705,_7800,_7810,_7754).

sentence1(new:::_7705,[sentence1,lit(har),_7792,_7821,!,_7855],_7767,_7769) --> 
    cc(har,_7767,_7791),
    negation0(_7728,_7792,_7791,_7809),
    w(verb(_7736,past,part),_7821,_7809,_7838),
    !,
    pushstack(first,([jeg],w(verb(_7736,past,fin)),negation(_7728)),nil,_7838,_7895),
    statreal(_7705,_7855,_7895,_7769).

sentence1(new:::_7705,[sentence1,_7804,_7833,_7862,_7896,_7920,_7949,!,_7983],_7790,_7792) --> 
    not_look_ahead([så],_7804,_7790,_7821),
    w(verb(_7736,pres,fin),_7833,_7821,_7850),
    gmem(_7736,[go,think],_7862,_7850,_7881),
    not_look_ahead_np(_7896,_7881,_7911),
    not_look_ahead([ikke],_7920,_7911,_7937),
    not_look_ahead_lit([jeg,meg,du],_7949,_7937,_7966),
    !,
    pushstack(first,([jeg],w(verb(_7736,pres,fin))),nil,_7966,_7993),
    statreal(_7705,_7983,_7993,_7792).

sentence1(new:::_7705,[sentence1,_7838,_7867,_7896,_7930,_7964,_7993,_8022,!,_8056],_7824,_7826) --> 
    not_look_ahead([så],_7838,_7824,_7855),
    w(verb(_7739,_7750,fin),_7867,_7855,_7884),
    gmem(_7750,[pres],_7896,_7884,_7915),
    gmem(_7739,[arrive,calculate,discover,give,hope,pass,run,send,start,take,think,try,wait],_7930,_7915,_7949),
    particlev1(_7739,_7964,_7949,_7981),
    not_look_ahead([ikke],_7993,_7981,_8010),
    not_look_ahead_lit([jeg,meg,du,vi],_8022,_8010,_8039),
    !,
    pushstack(first,([jeg],w(verb(_7739,pres,fin))),nil,_8039,_8066),
    statreal(_7705,_8056,_8066,_7826).

sentence1(new:::_7705,[sentence1,_7830,_7859,_7888,_7922,_7956,_7985,_8014,!,_8048],_7816,_7818) --> 
    not_look_ahead([så],_7830,_7816,_7847),
    w(verb(_7739,_7750,fin),_7859,_7847,_7876),
    gmem(_7750,[imp,inf],_7888,_7876,_7907),
    gmem(_7739,[arrive,discover,pass,run,send,start,take,try],_7922,_7907,_7941),
    reflexiv0(_7739,_7956,_7941,_7973),
    not_look_ahead([ikke],_7985,_7973,_8002),
    not_look_ahead_lit([jeg,meg,du,vi],_8014,_8002,_8031),
    !,
    pushstack(first,([jeg],w(verb(_7739,pres,fin))),nil,_8031,_8058),
    statreal(_7705,_8048,_8058,_7818).

sentence1(new:::_7705,[sentence1,_7820,_7849,{},_7888,_7917,_7946,_7970,!,_8019],_7806,_7808) --> 
    not_look_ahead([så],_7820,_7806,_7837),
    w(verb(_7748,pres,fin),_7849,_7837,_7866),
    {user:testmember(_7748,[believe,calculate,think,see,know])},
    not_look_ahead([det],_7888,_7866,_7905),
    not_look_ahead([du],_7917,_7905,_7934),
    redundant0(_7946,_7934,_7961),
    optional([at],_7970,_7961,_8002),
    !,
    pushstack(first,([jeg],w(verb(_7748,pres,fin)),[at]),nil,_8002,_8029),
    statreal(_7705,_8019,_8029,_7808).

sentence1(new:::_7705,[sentence1,_7789,_7818,_7847,lit(jeg),_7882,!,_7911],_7775,_7777) --> 
    not_look_ahead([så],_7789,_7775,_7806),
    w(verb(_7742,_7743,fin),_7818,_7806,_7835),
    redundant0(_7847,_7835,_7862),
    cc(jeg,_7862,_7881),
    aux1(_7882,_7881,_7897),
    !,
    pushstack(first,([jeg],w(verb(_7742,pres,fin)),[å]),nil,_7897,_7921),
    statement(_7705,_7911,_7921,_7777).

sentence1(new:::_7705,[sentence1,_7782,_7806,_7830,_7859,!,_7893],_7768,_7770) --> 
    aux1(_7782,_7768,_7797),
    redundants0(_7806,_7797,_7821),
    negation0(_7731,_7830,_7821,_7847),
    w(verb(_7737,inf,fin),_7859,_7847,_7876),
    !,
    pushstack(first,([jeg],w(verb(_7737,pres,fin)),negation(_7731)),nil,_7876,_7933),
    statement(_7705,_7893,_7933,_7770).

sentence1(_7702,[sentence1,_7737],_7723,_7725) --> 
    command(_7702,_7737,_7723,_7725).

sentence1(_7702,[sentence1,_7743,_7767,_7796],_7729,_7731) --> 
    greetings0(_7743,_7729,_7758),
    question(_7702,_7767,_7758,_7784),
    qtrailer0(_7796,_7784,_7731).

sentence1(modifier(_7714):::_7718 isa clock and srel/nil/time/_7718/_7714 and event/real/_7714,[sentence1,{},_7807,_7836,{},!,_7875],_7783,_7785) --> 
    {user:value(dialog,1)},
    item(_7756,_7807,_7783,_7824),
    endofline(_7836,_7824,_7851),
    {user:_7756=(_7718 isa clock)},
    !,
    accept(_7875,_7851,_7785).

sentence1(item:::_7705,[sentence1,{},_7767,_7796,!,_7825],_7743,_7745) --> 
    {user:value(dialog,1)},
    item(_7705,_7767,_7743,_7784),
    endofline(_7796,_7784,_7811),
    !,
    accept(_7825,_7811,_7745).

sentence1(item:::_7707 isa clock,[sentence1,{},lit(nå),_7791,!,_7820,{}],_7756,_7758) --> 
    {user:value(dialog,1)},
    cc(nå,_7756,_7790),
    terminator1(_7791,_7790,_7806),
    !,
    accept(_7820,_7806,_7758),
    {user:timenow(_7707)}.

sentence1(item:::_7705,[sentence1,_7768,{},_7832,!,_7861],_7754,_7756) --> 
    noun(_7719,_7720,_7721,n,it:_7727,_7705,_7768,_7754,_7795),
    {user:value(dialog,1)},
    endofline(_7832,_7795,_7847),
    !,
    accept(_7861,_7847,_7756).

sentence1(item:::it isa _7708,[sentence1,{},_7778,_7802,!,_7831,{}],_7754,_7756) --> 
    {user:value(dialog,1)},
    today(_7778,_7754,_7793),
    terminator1(_7802,_7793,_7817),
    !,
    accept(_7831,_7817,_7756),
    {user:today(_7708)}.

sentence1(new:::_7705,[sentence1,lit(ble),_7791,!,_7825],_7766,_7768) --> 
    cc(ble,_7766,_7790),
    look_ahead(w(adj2(_7727,nil)),_7791,_7790,_7808),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),w(adj2(_7727,nil))),nil,_7808,_7835),
    statement(_7705,_7825,_7835,_7768).

sentence1(new:::_7705,[sentence1,_7800,_7829,_7853,{},!,_7897,_7921],_7786,_7788) --> 
    w(verb(be,_7741,_7742),_7800,_7786,_7817),
    now0(_7829,_7817,_7844),
    w(prep(_7746),_7853,_7844,_7870),
    {user:testmember(_7746,[in,on,at])},
    !,
    accept(_7897,_7870,_7912),
    pushstack(first,([jeg],w(verb(be,pres,fin)),w(prep(on))),nil,_7912,_7931),
    statement(_7705,_7921,_7931,_7788).

sentence1(new:::_7705,[sentence1,_7785,_7809,{},_7848,_7872],_7771,_7773) --> 
    has(_7785,_7771,_7800),
    w(verb(_7727,past,part),_7809,_7800,_7826),
    {user:testmember(_7727,[send,get,receive,lay])},
    now0(_7848,_7826,_7863),
    pushstack(first,([jeg],w(verb(_7727,past,fin))),nil,_7863,_7882),
    statement(_7705,_7872,_7882,_7773).

sentence1(new:::_7705,[sentence1,_7784,{},_7823,_7847],_7770,_7772) --> 
    w(verb(_7724,_7731,fin),_7784,_7770,_7801),
    {user:testmember(_7724,[send,get,receive,lay,check])},
    now0(_7823,_7801,_7838),
    pushstack(first,([jeg],w(verb(_7724,pres,fin))),nil,_7838,_7857),
    statement(_7705,_7847,_7857,_7772).

sentence1(new:::_7705,[sentence1,_7746,_7770,_7799],_7732,_7734) --> 
    greetings0(_7746,_7732,_7761),
    statement(_7705,_7770,_7761,_7787),
    dtrailer0(_7799,_7787,_7734).

sentence1(item:::_7705,[sentence1,_7749,_7778,!,_7807],_7735,_7737) --> 
    item(_7705,_7749,_7735,_7766),
    terminator1(_7778,_7766,_7793),
    !,
    accept(_7807,_7793,_7737).

item(_7704 isa clock,[item,{},_7769,{},_7808],_7745,_7747) --> 
    {user:value(dialog,1)},
    time12(_7704,_7769,_7745,_7786),
    {user:_7704\==now},
    endofline(_7808,_7786,_7747).

item(_7702,[item,{},_7759,_7793],_7735,_7737) --> 
    {user:value(dialog,1)},
    obviousdate1(_7715,_7702,_7759,_7735,_7778),
    endofline(_7793,_7778,_7737).

item(_7702,[item,_7739],_7725,_7727) --> 
    namep(_7704,_7705,_7702,_7739,_7725,_7727).

command(_7702,[command,lit(vil),!,_7759],_7729,_7731) --> 
    cc(vil,_7729,_7753),
    !,
    reject(_7759,_7753,_7731).

command(_7702,[command,lit(skal),!,_7759],_7729,_7731) --> 
    cc(skal,_7729,_7753),
    !,
    reject(_7759,_7753,_7731).

command(doit:::_7705,[command,lit(du),lit(må),_7805,_7834,!,_7868],_7769,_7771) --> 
    cc(du,_7769,_7793),
    cc(må,_7793,_7804),
    not_look_ahead([ikke],_7805,_7804,_7822),
    w(verb(_7730,inf,fin),_7834,_7822,_7851),
    !,
    pushstack(first,([du],w(verb(_7730,pres,fin))),nil,_7851,_7878),
    statreal(_7705,_7868,_7878,_7771).

command(doit:::quit(_7707),[command,_7751,_7775,_7799,_7828],_7737,_7739) --> 
    grums0(_7751,_7737,_7766),
    okeys0(_7775,_7766,_7790),
    quit(_7707,_7799,_7790,_7816),
    skip_rest(_7828,_7816,_7739).

command(doit:::reply(_7707),[command,_7748,_7777,_7801],_7734,_7736) --> 
    personal(_7707,_7748,_7734,_7765),
    dtrailer0(_7777,_7765,_7792),
    endofline(_7801,_7792,_7736).

command(doit:::replyq('Hei'),[command,_7743,!],_7729,_7731) --> 
    hellos(_7743,_7729,_7731),
    !.

command(new:::_7705,[command,_7778,_7807,lit(ut),_7847,_7881,!,_7910],_7764,_7766) --> 
    w(verb(_7730,pres,fin),_7778,_7764,_7795),
    not_look_ahead([du],_7807,_7795,_7824),
    cc(ut,_7824,_7846),
    gmem(_7730,[see,look],_7847,_7846,_7866),
    tilat(_7881,_7866,_7896),
    !,
    substateme1(real,_7705,_7910,_7896,_7766).

tilat([tilat,lit(til),lit(at),!],_7727,_7729) --> 
    cc(til,_7727,_7748),
    cc(at,_7748,_7729),
    !.

tilat([tilat,lit(som),lit(om),!],_7727,_7729) --> 
    cc(som,_7727,_7748),
    cc(om,_7748,_7729),
    !.

tilat([tilat,lit(som)],_7719,_7721) --> 
    cc(som,_7719,_7721).

command(new:::_7705,[command,_7793,_7822,_7851,!,_7890],_7779,_7781) --> 
    w(verb(_7727,pres,fin),_7793,_7779,_7810),
    not_look_ahead([du],_7822,_7810,_7839),
    gmem(_7727,[expect,miss,need,get,receive,see,understand],_7851,_7839,_7870),
    !,
    pushstack(first,([jeg],w(verb(_7727,pres,fin))),nil,_7870,_7900),
    statreal(_7705,_7890,_7900,_7781).

command(new:::_7705,[command,_7829,_7858,_7887,{},_7926,{},!,_7970],_7815,_7817) --> 
    not_look_ahead([nå],_7829,_7815,_7846),
    not_look_ahead(w(verb(come,imp,fin)),_7858,_7846,_7875),
    w(verb(_7736,_7755,fin),_7887,_7875,_7904),
    {user:testmember(_7736,[go,take,run,arrive,leave,leave2,depart,start,pass])},
    not_look_ahead([meg],_7926,_7904,_7943),
    {user:testmember(_7755,[imp,inf])},
    !,
    pushstack(first,([jeg],w(verb(_7736,pres,fin))),nil,_7943,_7980),
    statreal(_7705,_7970,_7980,_7817).

command(new:::_7705,[command,_7794,_7823,{},_7862,lit(jeg),_7907,!,_7941],_7780,_7782) --> 
    w(verb(_7735,pres,fin),_7794,_7780,_7811),
    not_look_ahead([du],_7823,_7811,_7840),
    {user:testmember(_7735,[believe])},
    that0(_7735,that,_7862,_7840,_7881),
    cc(jeg,_7881,_7906),
    not_look_ahead(w(prep(_7759)),_7907,_7906,_7924),
    !,
    pushstack(first,[jeg],nil,_7924,_7951),
    statreal(_7705,_7941,_7951,_7782).

command(new:::_7705,[command,_7781,_7810,_7844,!,_7873],_7767,_7769) --> 
    w(verb(_7727,pres,fin),_7781,_7767,_7798),
    gmem(_7727,[arrive,leave2,depart],_7810,_7798,_7829),
    look_ahead_place(_7844,_7829,_7859),
    !,
    pushstack(first,([jeg],w(verb(_7727,pres,fin))),nil,_7859,_7883),
    statreal(_7705,_7873,_7883,_7769).

command(doit:::_7705,[command,_7795,_7839,_7863,_7892,{},_7931,!,_7960],_7781,_7783) --> 
    optional(grums,_7795,_7781,_7827),
    please0(_7839,_7827,_7854),
    negation0(_7737,_7863,_7854,_7880),
    w(verb(_7745,imp,fin),_7892,_7880,_7909),
    {user:verbtype(_7745,tv)},
    look_ahead_np(_7931,_7909,_7946),
    !,
    pushstack(first,([du],w(verb(_7745,pres,fin)),negation(_7737)),nil,_7946,_8000),
    statreal(_7705,_7960,_8000,_7783).

command(doit:::_7705,[command,_7790,_7834,_7858,_7887,_7916,!,_7955],_7776,_7778) --> 
    optional(grums,_7790,_7776,_7822),
    please0(_7834,_7822,_7849),
    negation0(_7734,_7858,_7849,_7875),
    w(verb(_7742,imp,fin),_7887,_7875,_7904),
    particlev0(_7742,_7747,_7916,_7904,_7935),
    !,
    pushstack(first,([du],w(verb(_7747,pres,fin)),negation(_7734)),nil,_7935,_7995),
    statreal(_7705,_7955,_7995,_7778).

command(doit:::replyq(?),[command,_7740],_7726,_7728) --> 
    end_of_line(_7740,_7726,_7728).

imp_phrase(_7702,[imp_phrase,_7757,lit(oss),_7812,!],_7743,_7745) --> 
    lexv(_7713,let,imp,fin,_7757,_7743,_7780),
    cc(oss,_7780,_7811),
    w(verb(_7702,inf,fin),_7812,_7811,_7745),
    !.

imp_phrase(let,[imp_phrase,_7746,!,_7795],_7732,_7734) --> 
    lexv(rv,let,imp,fin,_7746,_7732,_7769),
    !,
    accept(_7795,_7769,_7734).

imp_phrase(list,[imp_phrase,_7749,_7773,!,_7822],_7735,_7737) --> 
    faa(_7749,_7735,_7764),
    lexv(_7713,see,imp,fin,_7773,_7764,_7796),
    !,
    accept(_7822,_7796,_7737).

imp_phrase(wait,[imp_phrase,_7744,!],_7730,_7732) --> 
    w(verb(wait,imp,fin),_7744,_7730,_7732),
    !.

imp_phrase(_7702,[imp_phrase,_7772,_7801,_7825,{},{}],_7758,_7760) --> 
    not_look_ahead([må],_7772,_7758,_7789),
    comeand0(_7801,_7789,_7816),
    lexv(_7731,_7702,imp,fin,_7825,_7816,_7760),
    {user:_7731\==rv},
    {user:(\+testmember(_7702,[have,expect]))}.

imp_phrase(_7702,[imp_phrase,_7771,_7800,_7824,{},{},_7888],_7757,_7759) --> 
    not_look_ahead([må],_7771,_7757,_7788),
    comeand0(_7800,_7788,_7815),
    lexv(rv,_7702,imp,fin,_7824,_7815,_7847),
    {user:_7702\==be},
    {user:_7702\==wonder},
    reflexiv0(_7702,_7888,_7847,_7759).

imp_phrase(_7702,[imp_phrase,_7772,_7801,_7825,{},{}],_7758,_7760) --> 
    not_look_ahead([må],_7772,_7758,_7789),
    comeand0(_7801,_7789,_7816),
    lexv(_7725,_7702,inf,fin,_7825,_7816,_7760),
    {user:testmember(_7702,[list,show,make])},
    {user:_7702\==be}.

comeand0([comeand0,_7742,lit(å),!],_7731,_7733) --> 
    w(verb(come,imp,fin),_7742,_7731,_7759),
    cc(å,_7759,_7733),
    !.

comeand0([comeand0,[]],_7717,_7717) --> 
    [].

declaration(_7704 isa self,[declaration,_7749,_7773,!,_7802],_7735,_7737) --> 
    i(_7749,_7735,_7764),
    be(_7773,_7764,_7788),
    !,
    newatomid(_7704,_7802,_7788,_7737).

declaration(_7702,[declaration,_7756,_7785,_7809,!,_7838],_7742,_7744) --> 
    newatom(_7720,_7756,_7742,_7773),
    be(_7785,_7773,_7800),
    a(_7809,_7800,_7824),
    !,
    noun(_7716,sin,u,n,_7720,_7702,_7838,_7824,_7744).

statement(_7702,[statement,lit(det),_7800,lit(at),_7840,_7869,_7908,!,_7937,[],_8008],_7775,_7777) --> 
    cc(det,_7775,_7799),
    be_truefalse(_7735,_7800,_7799,_7817),
    cc(at,_7817,_7839),
    look_ahead_lit([før,etter,når],_7840,_7839,_7857),
    adverbial3(_7747,_7748,_7749,_7869,_7857,_7890),
    comma0(_7908,_7890,_7923),
    !,
    accept(_7937,_7923,_7952),
    pushstack(free,adverbial1(_7747,_7748,_7749),nil,_7952,_8007),[],
    substatement1(_7702,_8008,_8007,_7777).

statement(_7702,[statement,_7775,_7804,_7843,!,_7872],_7761,_7763) --> 
    look_ahead_lit([hvis,om,selvom,da],_7775,_7761,_7792),
    adverbial3(_7722,_7723,_7724,_7804,_7792,_7825),
    soredundant(_7843,_7825,_7858),
    !,
    lock(last,_7858,_7922),
    pushstack(last,([så],xadverbial1(_7722,_7723,_7724)),nil,_7922,_7928),
    substatement1(_7702,_7872,_7928,_7917),
    unlock(_7917,_7763).

statement(_7702,[statement,_7799,_7828,_7867,_7896,lit(det),!,_7941,_7965],_7785,_7787) --> 
    look_ahead([hvis],_7799,_7785,_7816),
    adverbial3(_7734,_7735,_7736,_7828,_7816,_7849),
    not_look_ahead([så],_7867,_7849,_7884),
    w(verb(_7752,_7753,fin),_7896,_7884,_7913),
    cc(det,_7913,_7935),
    !,
    accept(_7941,_7935,_7956),
    lock(last,_7956,_8014),
    pushstack(last,([det],w(verb(_7752,_7753,fin)),xadverbial1(_7734,_7735,_7736)),nil,_8014,_8020),
    substatement1(_7702,_7965,_8020,_8009),
    unlock(_8009,_7787).

statement(_7702,[statement,_7797,_7826,_7865,_7894,lit(det),_7929,!,_7963,_7987],_7783,_7785) --> 
    look_ahead([hvis],_7797,_7783,_7814),
    adverbial3(_7740,_7741,_7742,_7826,_7814,_7847),
    not_look_ahead([så],_7865,_7847,_7882),
    aux1(_7894,_7882,_7909),
    cc(det,_7909,_7928),
    negation0(_7758,_7929,_7928,_7946),
    !,
    accept(_7963,_7946,_7978),
    lock(last,_7978,_8094),
    pushstack(last,([det],aux1,negation(_7758),xadverbial1(_7740,_7741,_7742)),nil,_8094,_8100),
    substatement1(_7702,_7987,_8100,_8089),
    unlock(_8089,_7785).

statement(_7702,[statement,_7802,_7831,_7870,_7899,_7923,_7957,_7981,!,_8015,_8039],_7788,_7790) --> 
    look_ahead([hvis],_7802,_7788,_7819),
    adverbial3(_7743,_7744,_7745,_7831,_7819,_7852),
    not_look_ahead([så],_7870,_7852,_7887),
    aux1(_7899,_7887,_7914),
    subject(_7759,_7760,_7923,_7914,_7942),
    redundant0(_7957,_7942,_7972),
    negation0(_7762,_7981,_7972,_7998),
    !,
    accept(_8015,_7998,_8030),
    lock(last,_8030,_8177),
    pushstack(last,(xnp(_7759,_7760),aux1,negation(_7762),xadverbial1(_7743,_7744,_7745)),nil,_8177,_8183),
    substatement1(_7702,_8039,_8183,_8172),
    unlock(_8172,_7790).

statement(_7702,[statement,_7804,_7833,_7872,_7901,!,_7935,!,_7974,_7998],_7790,_7792) --> 
    look_ahead([hvis],_7804,_7790,_7821),
    adverbial3(_7737,_7738,_7739,_7833,_7821,_7854),
    not_look_ahead([så],_7872,_7854,_7889),
    w(verb(_7755,_7756,fin),_7901,_7889,_7918),
    !,
    subject(_7759,_7760,_7935,_7918,_7954),
    !,
    accept(_7974,_7954,_7989),
    lock(last,_7989,_8078),
    pushstack(last,(xnp(_7759,_7760),w(verb(_7755,_7756,fin)),xadverbial1(_7737,_7738,_7739)),nil,_8078,_8084),
    substatement1(_7702,_7998,_8084,_8073),
    unlock(_8073,_7792).

statement(_7702,[statement,_7774,_7803,_7842,!,_7871,[],_7941],_7760,_7762) --> 
    look_ahead_lit([før,etter,når],_7774,_7760,_7791),
    adverbial3(_7732,_7733,_7734,_7803,_7791,_7824),
    comma0(_7842,_7824,_7857),
    !,
    accept(_7871,_7857,_7886),
    pushstack(free,adverbial1(_7732,_7733,_7734),nil,_7886,_7940),[],
    substatement1(_7702,_7941,_7940,_7762).

statement(_7702,[statement,_7738],_7724,_7726) --> 
    statemens(real,_7702,_7738,_7724,_7726).

substatement1(_7702,[substatement1,_7790,_7814,_7843,_7887,_7921,_7965,!,_8004],_7776,_7778) --> 
    dether(_7790,_7776,_7805),
    w(verb(be,_7737,fin),_7814,_7805,_7831),
    optional([ofte],_7843,_7831,_7875),
    np0_accept(_7731,_7732,_7887,_7875,_7906),
    optional([som],_7921,_7906,_7953),
    subject(_7751,_7752,_7965,_7953,_7984),
    !,
    pushstack(free,(xnp(_7751,_7752),xnp(_7731,_7732)),nil,_7984,_8076),
    statreal(_7702,_8004,_8076,_7778).

dether([dether,lit(det)],_7719,_7721) --> 
    cc(det,_7719,_7721).

dether([dether,lit(det),lit(her)],_7724,_7726) --> 
    cc(det,_7724,_7745),
    cc(her,_7745,_7726).

dether([dether,lit(dette)],_7719,_7721) --> 
    cc(dette,_7719,_7721).

substatement1(_7702,[substatement1,_7738],_7724,_7726) --> 
    statemen1(real,_7702,_7738,_7724,_7726).

statemens(_7702,_7703,[statemens,_7751,_7785],_7734,_7736) --> 
    statemen1(_7702,_7709,_7751,_7734,_7770),
    statemens0(_7702,_7709,_7703,_7785,_7770,_7736).

statemens0(_7702,_7703,_7703 and _7707,[statemens0,_7767,_7791,!,_7820],_7747,_7749) --> 
    stm_conjunction(_7767,_7747,_7782),
    aux1(_7791,_7782,_7806),
    !,
    pushstack(first,[jeg],nil,_7806,_7830),
    statemens(_7702,_7707,_7820,_7830,_7749).

statemens0(_7702,_7703,_7703 and _7707,[statemens0,_7770,_7794,!,_7828],_7750,_7752) --> 
    stm_conjunction(_7770,_7750,_7785),
    look_ahead_lit([så,nå,da],_7794,_7785,_7811),
    !,
    statemens(_7702,_7707,_7828,_7811,_7752).

statemens0(_7702,_7703,_7703 and _7707,[statemens0,_7763,!,_7797],_7743,_7745) --> 
    look_ahead([så],_7763,_7743,_7780),
    !,
    statemens(_7702,_7707,_7797,_7780,_7745).

statemens0(_7702,_7703,_7703 and _7707,[statemens0,_7773,_7797,_7826,!,_7855],_7753,_7755) --> 
    stm_conjunction(_7773,_7753,_7788),
    not_look_ahead(w(verb(_7728,_7729,_7730)),_7797,_7788,_7814),
    not_look_ahead_number(_7826,_7814,_7841),
    !,
    statemens(_7702,_7707,_7855,_7841,_7755).

statemens0(_7702,_7703,_7703,[statemens0,[]],_7727,_7727) --> 
    [].

stm_conjunction([stm_conjunction,lit(hvorav)],_7719,_7721) --> 
    cc(hvorav,_7719,_7721).

stm_conjunction([stm_conjunction,lit(å),_7748],_7726,_7728) --> 
    cc(å,_7726,_7747),
    look_ahead([så],_7748,_7747,_7728).

stm_conjunction([stm_conjunction,lit(å),_7748],_7726,_7728) --> 
    cc(å,_7726,_7747),
    look_ahead([nå],_7748,_7747,_7728).

stm_conjunction([stm_conjunction,lit(og),_7748],_7726,_7728) --> 
    cc(og,_7726,_7747),
    look_ahead([nå],_7748,_7747,_7728).

stm_conjunction([stm_conjunction,lit(og),lit(at)],_7724,_7726) --> 
    cc(og,_7724,_7745),
    cc(at,_7745,_7726).

stm_conjunction([stm_conjunction,lit(men),lit(at)],_7724,_7726) --> 
    cc(men,_7724,_7745),
    cc(at,_7745,_7726).

stm_conjunction([stm_conjunction,lit(altså),lit(at)],_7724,_7726) --> 
    cc(altså,_7724,_7745),
    cc(at,_7745,_7726).

stm_conjunction([stm_conjunction,_7728],_7717,_7719) --> 
    and1(_7728,_7717,_7719).

stm_conjunction([stm_conjunction,lit(men)],_7719,_7721) --> 
    cc(men,_7719,_7721).

stm_conjunction([stm_conjunction,_7732],_7721,_7723) --> 
    look_ahead([så],_7732,_7721,_7723).

stm_conjunction([stm_conjunction,_7739,_7783],_7728,_7730) --> 
    optional([','],_7739,_7728,_7771),
    look_ahead([ikke],_7783,_7771,_7730).

stm_conjunction([stm_conjunction,lit(mens)],_7719,_7721) --> 
    cc(mens,_7719,_7721).

statemen1(_7702,_7703,[statemen1,_7744],_7727,_7729) --> 
    stateme1(_7702,_7703,_7744,_7727,_7729).

statemen1(_7702,_7703,[statemen1,_7803,{},_7842,!,_7891],_7786,_7788) --> 
    w(adj2(_7733,nil),_7803,_7786,_7820),
    {user:testmember(_7733,[possible,clear,ready])},
    optional([at],_7842,_7820,_7874),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7733,nil)),[at]),nil,_7874,_7901),
    substateme1(_7702,_7703,_7891,_7901,_7788).

statemen1(_7702,_7703,[statemen1,_7827,{},_7866,{},{},_7915,!,_7954,!,_8033],_7810,_7812) --> 
    w(adj2(_7734,nil),_7827,_7810,_7844),
    {user:testmember(_7734,[enclosed])},
    w(verb(_7746,_7747,fin),_7866,_7844,_7883),
    {user:(\+testmember(_7746,[]))},
    {user:verbtype(_7746,iv)},
    subject(_7762,_7763,_7915,_7883,_7934),
    !,
    pushstack(first,(xnp(_7762,_7763),w(verb(_7746,_7747,fin)),w(adj2(_7734,nil))),nil,_7934,_7998),substateme1(_7702,_7703,_7954,_7998,_8013),
    !,
    accept(_8033,_8013,_7812).

statemen1(_7702,_7703,[statemen1,_7794,_7818,{},lit(det),_7868,_7892,!,_7940],_7777,_7779) --> 
    redundant(_7794,_7777,_7809),
    w(verb(_7728,_7729,fin),_7818,_7809,_7835),
    {user:(\+testmember(_7728,[]))},
    cc(det,_7835,_7867),
    danow0(_7868,_7867,_7883),
    pushstack(first,([det],w(verb(_7728,pres,fin))),nil,_7883,_7905),substateme1(_7702,_7703,_7892,_7905,_7920),
    !,
    accept(_7940,_7920,_7779).

statemen1(_7702,_7703,[statemen1,_7803,_7847,{},_7886,!,_7934],_7786,_7788) --> 
    optional([meget],_7803,_7786,_7835),
    w(adj2(_7726,nil),_7847,_7835,_7864),
    {user:testmember(_7726,[good,bad,interesting,nice])},
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7726,nil))),nil,_7864,_7899),substateme1(_7702,_7703,_7886,_7899,_7914),
    !,
    accept(_7934,_7914,_7788).

statemen1(_7702,_7703,[statemen1,_7764,{},_7803],_7747,_7749) --> 
    not_look_ahead_lit([hva,hvem,hvilke,hvilken,hvilket],_7764,_7747,_7781),
    {user:unprotected_verb},
    substateme1(_7702,_7703,_7803,_7781,_7749).

statemen1(_7702,_7703,[statemen1,lit(som),lit(du),_7829,{},_7868,_7897,_7931],_7790,_7792) --> 
    cc(som,_7790,_7817),
    cc(du,_7817,_7828),
    w(verb(_7741,_7742,fin),_7829,_7828,_7846),
    {user:testmember(_7741,[know,see,understand])},
    w(verb(_7731,_7759,fin),_7868,_7846,_7885),
    subject(_7762,_7763,_7897,_7885,_7916),
    pushstack(first,(xnp(_7762,_7763),w(verb(_7731,pres,fin))),nil,_7916,_7972),
    substateme1(_7702,_7703,_7931,_7972,_7792).

statemen1(_7702,_7703,[statemen1,_7778,_7802,lit(det),_7842,!],_7761,_7763) --> 
    soredundant(_7778,_7761,_7793),
    w(verb(_7719,_7720,fin),_7802,_7793,_7819),
    cc(det,_7819,_7841),
    pushstack(first,([noe],w(verb(_7719,_7720,fin))),nil,_7841,_7855),substateme1(_7702,_7703,_7842,_7855,_7763),
    !.

stateme1(_7702,_7703,[stateme1,_7753],_7736,_7738) --> 
    statem(_7705,event/_7702/_7705::_7703,_7753,_7736,_7738).

substateme1(_7702,_7703,[substateme1,_7753],_7736,_7738) --> 
    substatem1(_7705,event/_7702/_7705::_7703,_7753,_7736,_7738).

substatem(_7702,_7703,[substatem,_7751,_7785],_7734,_7736) --> 
    substatem1(_7702,_7709,_7751,_7734,_7770),
    ogat(_7702,_7709,_7703,_7785,_7770,_7736).

ogat(_7702,_7706::_7709,_7706::_7709 and _7710,[ogat,lit(og),lit(at),!,_7802],_7755,_7757) --> 
    cc(og,_7755,_7785),
    cc(at,_7785,_7796),
    !,
    substatem1(_7702,_7706::_7710,_7802,_7796,_7757).

ogat(_7702,_7703,_7703,[ogat,[]],_7727,_7727) --> 
    [].

substatem1(_7702,_7703,[substatem1,lit(det),_7804,_7833,{},!,[],_7921],_7776,_7778) --> 
    cc(det,_7776,_7803),
    negation0(_7737,_7804,_7803,_7821),
    be(_7739,_7833,_7821,_7850),
    {user:bigno(_7737,_7739,_7745)},
    !,
    pushstack(free,negation(_7745),nil,_7850,_7920),[],
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_7920,_7931),
    statem(_7702,_7703,_7921,_7931,_7778).

substatem1(_7702,_7703,[substatem1,lit(det),_7805,_7834,{},!,_7898],_7777,_7779) --> 
    cc(det,_7777,_7804),
    negation0(_7733,_7805,_7804,_7822),
    hlexv(_7735,_7736,_7737,fin,_7739,_7834,_7822,_7859),
    {user:bigno(_7733,_7739,_7729)},
    !,
    pushstack(first,([det],w(verb(_7736,pres,fin)),negation(_7729)),nil,_7859,_7938),
    statem(_7702,_7703,_7898,_7938,_7779).

substatem1(_7702,_7703,[substatem1,lit(å),!,_7788,!,_7836],_7755,_7757) --> 
    cc(å,_7755,_7782),
    !,
    pushstack(first,[jeg],nil,_7782,_7801),clausal_object1(_7720,_7721,_7788,_7801,_7816),
    !,
    lock(last,_7816,_7884),
    pushstack(last,xnp(_7720,_7721),nil,_7884,_7890),
    statem(_7702,_7703,_7836,_7890,_7879),
    unlock(_7879,_7757).

substatem1(_7702,_7703,[substatem1,_7797,_7821,_7850,_7893,!,_7922],_7780,_7782) --> 
    forå(_7797,_7780,_7812),
    w(verb(_7732,inf,fin),_7821,_7812,_7838),
    pushstack(first,([jeg],w(verb(_7732,pres,fin))),nil,_7838,_7863),clausal_object1(_7727,true::_7728,_7850,_7863,_7878),
    hvisaa0(_7893,_7878,_7908),
    !,
    lock(last,_7908,_7972),
    pushstack(last,([så],subordinate(in_order_to,_7727,_7728)),nil,_7972,_7978),
    statem(_7702,_7703,_7922,_7978,_7967),
    unlock(_7967,_7782).

substatem1(_7702,_7703,[substatem1,_7817,_7846,[],_7930,_7954,lit(det),_7989,_8013,!,_8047],_7800,_7802) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom],_7817,_7800,_7834),
    subordinate(_7759,_7760,_7761,_7846,_7834,_7867),
    pushstack(free,subordinate(_7759,_7760,_7761),nil,_7867,_7929),[],
    hvisaa0(_7930,_7929,_7945),
    has(_7954,_7945,_7969),
    cc(det,_7969,_7988),
    redundant0(_7989,_7988,_8004),
    w(verb(be,past,part),_8013,_8004,_8030),
    !,
    pushstack(first,w(verb(be,past,fin)),nil,_8030,_8057),
    itstatem(_7702,_7703,_8047,_8057,_7802).

substatem1(_7702,_7703,[substatem1,_7794,_7823,_7862,!,_7891],_7777,_7779) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom,da,når],_7794,_7777,_7811),
    subordinate(_7723,_7724,_7725,_7823,_7811,_7844),
    hvisaa0(_7862,_7844,_7877),
    !,
    lock(last,_7877,_7940),
    pushstack(last,([så],subordinate(_7723,_7724,_7725)),nil,_7940,_7946),
    statem(_7702,_7703,_7891,_7946,_7935),
    unlock(_7935,_7779).

substatem1(_7702,_7703,[substatem1,_7744],_7727,_7729) --> 
    substate(_7702,_7703,_7744,_7727,_7729).

hvisaa0([hvisaa0,lit(så),!],_7722,_7724) --> 
    cc(så,_7722,_7724),
    !.

hvisaa0([hvisaa0,_7735,!],_7724,_7726) --> 
    look_ahead_lit([ble],_7735,_7724,_7726),
    !.

hvisaa0([hvisaa0,_7737,!],_7726,_7728) --> 
    look_ahead_lit([kan,får],_7737,_7726,_7728),
    !.

hvisaa0([hvisaa0,_7752,{}],_7741,_7743) --> 
    look_ahead(w(verb(_7707,_7723,fin)),_7752,_7741,_7743),
    {user:testmember(_7707,[avoid,be,come,have])}.

hvisaa0([hvisaa0,[]],_7717,_7717) --> 
    [].

sostatem(_7702,_7703,[sostatem,_7799,_7823,_7857,_7881,_7910,!,_7944,!],_7782,_7784) --> 
    faux1(_7799,_7782,_7814),
    subject(_7726,_7727,_7823,_7814,_7842),
    redundant0(_7857,_7842,_7872),
    negation0(_7729,_7881,_7872,_7898),
    w(verb(_7733,inf,fin),_7910,_7898,_7927),
    !,
    pushstack(first,(xnp(_7726,_7727),aux1,negation(_7729),w(verb(_7733,inf,fin))),nil,_7927,_8046),state(_7702,_7703,_7944,_8046,_7784),
    !.

sostatem(_7702,_7703,[sostatem,_7819,lit(det),_7859,_7888,lit(at),!,_7948,_7982],_7802,_7804) --> 
    w(verb(_7745,_7746,fin),_7819,_7802,_7836),
    cc(det,_7836,_7858),
    negation0(_7751,_7859,_7858,_7876),
    adj1(_7738,_7758:_7759,_7740,_7741,_7888,_7876,_7911),
    cc(at,_7911,_7942),
    !,
    clausal_object1(_7763,_7764,_7948,_7942,_7967),
    pushstack(first,(xnp(_7763,_7764),w(verb(_7745,_7746,fin)),negation(_7751),adj1(_7738,_7758:_7781,_7740,_7741)),nil,_7967,_8086),
    state(_7702,_7703,_7982,_8086,_7804).

sostatem(_7702,_7703,[sostatem,_7798,lit(det),_7833,_7857,_7886,_7915,_7949,!],_7781,_7783) --> 
    has(_7798,_7781,_7813),
    cc(det,_7813,_7832),
    preadverbials0(_7833,_7832,_7848),
    negation0(_7728,_7857,_7848,_7874),
    w(verb(_7732,past,part),_7886,_7874,_7903),
    subject(_7736,_7737,_7915,_7903,_7934),
    pushstack(first,(xnp(_7736,_7737),w(verb(_7732,past,fin)),negation(_7728)),nil,_7934,_8023),state(_7702,_7703,_7949,_8023,_7783),
    !.

sostatem(_7702,_7703,[sostatem,_7797,_7846,_7875,_7899,{},_7938,!],_7780,_7782) --> 
    lexvaccept(rv,_7724,_7725,fin,_7727,_7797,_7780,_7822),
    negation0(_7729,_7846,_7822,_7863),
    thereit(_7875,_7863,_7890),
    negation0(_7731,_7899,_7890,_7916),
    {user:bigno(_7729,_7731,_7727)},
    pushstack(first,([noe],w(verb(_7724,_7725,fin)),negation(_7727)),nil,_7916,_7981),state(_7702,_7703,_7938,_7981,_7782),
    !.

sostatem(_7702,_7703,[sostatem,_7801,_7830,_7859,_7893,{},_7932,!],_7784,_7786) --> 
    w(verb(_7725,_7726,fin),_7801,_7784,_7818),
    negation0(_7729,_7830,_7818,_7847),
    subject(_7731,_7732,_7859,_7847,_7878),
    negation0(_7734,_7893,_7878,_7910),
    {user:bigno(_7729,_7734,_7740)},
    pushstack(first,(xnp(_7731,_7732),w(verb(_7725,_7726,fin)),negation(_7740)),nil,_7910,_8006),state(_7702,_7703,_7932,_8006,_7786),
    !.

sostatem(_7702,_7703,[sostatem,_7783,_7812,_7836,_7865,!],_7766,_7768) --> 
    w(verb(_7719,_7720,pass),_7783,_7766,_7800),
    thereit0(_7812,_7800,_7827),
    negation0(_7723,_7836,_7827,_7853),
    pushstack(first,([noen],w(verb(_7719,_7720,fin)),negation(_7723)),nil,_7853,_7908),state(_7702,_7703,_7865,_7908,_7768),
    !.

sostatem(_7702,_7703,[sostatem,_7795,lit(det),_7830,{},!,_7874,!],_7778,_7780) --> 
    aux1(_7795,_7778,_7810),
    cc(det,_7810,_7829),
    w(verb(_7727,_7728,_7729),_7830,_7829,_7847),
    {user:(_7728=inf;_7729=part)},
    !,
    pushstack(first,([noe],w(verb(_7727,pres,fin))),nil,_7847,_7887),state(_7702,_7703,_7874,_7887,_7780),
    !.

sostatem(_7702,_7703,[sostatem,_7779,lit(det),_7814,!,_7848,!],_7762,_7764) --> 
    aux1(_7779,_7762,_7794),
    cc(det,_7794,_7813),
    w(verb(_7724,pres,pass),_7814,_7813,_7831),
    !,
    pushstack(first,(someone,w(verb(_7724,pres,fin))),nil,_7831,_7892),state(_7702,_7703,_7848,_7892,_7764),
    !.

sostatem(_7702,_7703,[sostatem,_7786,_7810,_7844,!,_7878,!],_7769,_7771) --> 
    aux1(_7786,_7769,_7801),
    object(_7720,_7721,_7810,_7801,_7829),
    w(verb(_7725,pres,pass),_7844,_7829,_7861),
    !,
    pushstack(first,(someone,w(verb(_7725,pres,fin)),xnp(_7720,_7721)),nil,_7861,_7950),state(_7702,_7703,_7878,_7950,_7771),
    !.

sostatem(_7702,_7703,[sostatem,_7788,_7817,{},lit(det),!,_7872,!],_7771,_7773) --> 
    not_look_ahead([så],_7788,_7771,_7805),
    w(verb(_7729,_7730,fin),_7817,_7805,_7834),
    {user:_7730\==inf},
    cc(det,_7834,_7866),
    !,
    pushstack(free,w(verb(_7729,pres,fin)),nil,_7866,_7885),state(_7702,_7703,_7872,_7885,_7773),
    !.

sostatem(_7702,_7703,[sostatem,_7786,_7810,_7844,!,_7878,!],_7769,_7771) --> 
    docan(_7786,_7769,_7801),
    subject(_7720,_7721,_7810,_7801,_7829),
    w(verb(_7725,pres,pass),_7844,_7829,_7861),
    !,
    pushstack(first,(someone,w(verb(_7725,pres,fin)),xnp(_7720,_7721)),nil,_7861,_7950),state(_7702,_7703,_7878,_7950,_7771),
    !.

statem(_7702,_7703,[statem,lit(det),_7813,_7842,_7876,!,_7910],_7785,_7787) --> 
    cc(det,_7785,_7812),
    w(verb(_7738,_7739,pass),_7813,_7812,_7830),
    gmem(_7738,[want,wish,need],_7842,_7830,_7861),
    negation0(_7751,_7876,_7861,_7893),
    !,
    pushstack(first,([noen],w(verb(_7738,_7739,fin)),negation(_7751),[dette]),nil,_7893,_7950),
    state(_7702,_7703,_7910,_7950,_7787).

statem(_7702,_7703,[statem,_7750,!,_7779],_7733,_7735) --> 
    preadverbials(_7750,_7733,_7765),
    !,
    prestatem(_7702,_7703,_7779,_7765,_7735).

statem(_7702,_7703,[statem,_7795,_7829,_7858,_7882,!,[],_7968],_7778,_7780) --> 
    obviousdate1(_7735,_7736,_7795,_7778,_7814),
    w(verb(_7731,_7732,fin),_7829,_7814,_7846),
    det0(_7858,_7846,_7873),
    subject(_7744,_7745,_7882,_7873,_7901),
    !,
    pushstack(free,obviousdate1(_7735,_7736),nil,_7901,_7967),[],
    pushstack(first,(xnp(_7744,_7745),w(verb(_7731,_7732,fin))),nil,_7967,_8009),
    state(_7702,_7703,_7968,_8009,_7780).

statem(_7702,_7703,[statem,_7789,_7823,_7852,!,_7901],_7772,_7774) --> 
    obviousdate1(_7726,_7727,_7789,_7772,_7808),
    w(verb(_7734,_7735,pass),_7823,_7808,_7840),
    optional([det],_7852,_7840,_7884),
    !,
    pushstack(free,([noen],w(verb(_7734,_7735,fin)),obviousdate1(_7726,_7727)),nil,_7884,_7942),
    state(_7702,_7703,_7901,_7942,_7774).

statem(_7702,_7703,[statem,_7836,_7870,_7899,_7933,_7967,_7996,lit(om),!,[],[],_8069],_7819,_7821) --> 
    lit_of(_7746,[det,dette],_7836,_7819,_7855),
    w(verb(_7755,_7756,fin),_7870,_7855,_7887),
    gmem(_7755,[worry],_7899,_7887,_7918),
    lit_of(_7764,[jeg,du,man],_7933,_7918,_7952),
    reflexiv0(_7755,_7967,_7952,_7984),
    negation0(_7744,_7996,_7984,_8013),
    cc(om,_8013,_8035),
    !,
    pushstack(free,[dette],nil,_8035,_8054),[],
    pushstack(free,[om],nil,_8054,_8068),[],
    pushstack(first,([_7764],w(verb(_7755,_7756,fin)),negation(_7744)),nil,_8068,_8109),
    state(_7702,_7703,_8069,_8109,_7821).

statem(_7702,_7703,[statem,_7830,_7864,_7893,_7927,lit(om),!,[],[],[],_8057],_7813,_7815) --> 
    lit_of(_7744,[det,dette],_7830,_7813,_7849),
    w(verb(_7740,_7741,fin),_7864,_7849,_7881),
    lit_of(_7757,[jeg,du,man],_7893,_7881,_7912),
    np_kernel(0,_7767,_7768,_7927,_7912,_7948),
    cc(om,_7948,_7976),
    !,
    pushstack(free,[dette],nil,_7976,_7995),[],
    pushstack(free,[om],nil,_7995,_8009),[],
    pushstack(free,np_kernel(0,_7767,_7768),nil,_8009,_8056),[],
    pushstack(first,([_7757],w(verb(_7740,_7741,fin))),nil,_8056,_8067),
    state(_7702,_7703,_8057,_8067,_7815).

statem(_7702,_7703,[statem,_7830,_7864,_7893,_7927,lit(om),!,[],[],[],_8056],_7813,_7815) --> 
    lit_of(_7744,[det,dette],_7830,_7813,_7849),
    w(verb(have,_7741,fin),_7864,_7849,_7881),
    lit_of(_7757,[jeg,du,man],_7893,_7881,_7912),
    np_kernel(0,_7767,_7768,_7927,_7912,_7948),
    cc(om,_7948,_7976),
    !,
    pushstack(free,[dette],nil,_7976,_7995),[],
    pushstack(free,[om],nil,_7995,_8009),[],
    pushstack(free,np_kernel(0,_7767,_7768),nil,_8009,_8055),[],
    pushstack(first,([_7757],w(verb(have,_7741,fin))),nil,_8055,_8066),
    state(_7702,_7703,_8056,_8066,_7815).

statem(_7702,_7703,[statem,_7822,_7861,lit(det),_7896,_7935,_7964,!,_8003],_7805,_7807) --> 
    preadverbial1(_7745,_7746,_7747,_7822,_7805,_7843),
    blei(_7861,_7843,_7876),
    cc(det,_7876,_7895),
    preadverbial0(_7741,_7742,_7743,_7896,_7895,_7917),
    w(verb(_7757,past,part),_7935,_7917,_7952),
    object(_7761,_7762,_7964,_7952,_7983),
    !,
    pushstack(first,(xnp(_7761,_7762),w(verb(be,pres,fin)),w(verb(_7757,past,part)),adverbial1(_7745,_7746,_7747),adverbial1(_7741,_7742,_7743)),nil,_7983,_8108),
    state(_7702,_7703,_8003,_8108,_7807).

statem(_7702,_7703,[statem,_7857,_7886,_7920,_7949,_7983,_8017,_8046,_8090,!,_8124],_7840,_7842) --> 
    not_look_ahead([det],_7857,_7840,_7874),
    obvious_object(_7750,_7751,_7886,_7874,_7905),
    w(verb(_7762,_7763,fin),_7920,_7905,_7937),
    gmem(_7762,[want,wish,need],_7949,_7937,_7968),
    lit_of(_7775,[jeg,vi,han,hun,du],_7983,_7968,_8002),
    negation0(_7788,_8017,_8002,_8034),
    optional([å],_8046,_8034,_8078),
    w(verb(_7796,inf,fin),_8090,_8078,_8107),
    !,
    pushstack(first,([_7775],w(verb(_7762,_7763,fin)),negation(_7788),[å],w(verb(_7796,_7763,fin)),xnp(_7750,_7751)),nil,_8107,_8195),
    state(_7702,_7703,_8124,_8195,_7842).

statem(_7702,_7703,[statem,_7824,_7853,_7887,_7916,_7950,_7984,!,_8018],_7807,_7809) --> 
    not_look_ahead([det],_7824,_7807,_7841),
    obvious_object(_7735,_7736,_7853,_7841,_7872),
    w(verb(_7747,_7748,fin),_7887,_7872,_7904),
    gmem(_7747,[have,get],_7916,_7904,_7935),
    lit_of(_7758,[jeg,vi,han,hun,du],_7950,_7935,_7969),
    w(verb(_7773,past,part),_7984,_7969,_8001),
    !,
    pushstack(first,([_7758],w(verb(_7773,_7748,fin)),xnp(_7735,_7736)),nil,_8001,_8059),
    state(_7702,_7703,_8018,_8059,_7809).

statem(_7702,_7703,[statem,_7827,_7856,_7890,{},_7929,_7963,!,_7997],_7810,_7812) --> 
    not_look_ahead([det],_7827,_7810,_7844),
    obvious_object(_7738,_7739,_7856,_7844,_7875),
    w(verb(_7750,_7751,fin),_7890,_7875,_7907),
    {user:(\+testmember(_7750,[give]))},
    lit_of(_7763,[jeg,vi,han,hun,du],_7929,_7907,_7948),
    negation0(_7776,_7963,_7948,_7980),
    !,
    pushstack(first,([_7763],w(verb(_7750,_7751,fin)),negation(_7776),xnp(_7738,_7739)),nil,_7980,_8068),
    state(_7702,_7703,_7997,_8068,_7812).

statem(_7702,_7703,[statem,_7861,_7890,_7924,_7953,_7987,_8021,_8065,_8094,!,_8128],_7844,_7846) --> 
    not_look_ahead([det],_7861,_7844,_7878),
    obvious_object(_7750,_7751,_7890,_7878,_7909),
    w(verb(_7762,_7763,fin),_7924,_7909,_7941),
    gmem(_7762,[want,wish,need],_7953,_7941,_7972),
    lit_of(_7775,[jeg,vi,han,hun,du],_7987,_7972,_8006),
    optional([å],_8021,_8006,_8053),
    w(verb(_7794,inf,fin),_8065,_8053,_8082),
    w(prep(_7800),_8094,_8082,_8111),
    !,
    pushstack(first,([_7775],w(verb(_7762,_7763,fin)),[å],w(verb(_7794,_7763,fin)),w(prep(_7800)),xnp(_7750,_7751)),nil,_8111,_8169),
    state(_7702,_7703,_8128,_8169,_7846).

statem(_7702,_7703,[statem,_7805,lit(kan),_7850,_7884,!,_7918],_7788,_7790) --> 
    obvious_object(_7729,_7730,_7805,_7788,_7824),
    cc(kan,_7824,_7849),
    lit_of(_7737,[jeg,vi,han,hun,du],_7850,_7849,_7869),
    not_look_ahead(w(verb(_7754,_7755,_7756)),_7884,_7869,_7901),
    !,
    pushstack(first,([_7737],w(verb(do1,pres,fin)),xnp(_7729,_7730)),nil,_7901,_7959),
    state(_7702,_7703,_7918,_7959,_7790).

statem(_7702,_7703,[statem,_7808,_7837,_7871,_7895,_7929,!,_7963],_7791,_7793) --> 
    not_look_ahead([det],_7808,_7791,_7825),
    obvious_object(_7732,_7733,_7837,_7825,_7856),
    aux1(_7871,_7856,_7886),
    lit_of(_7742,[jeg,vi,han,hun,du],_7895,_7886,_7914),
    w(verb(_7757,inf,fin),_7929,_7914,_7946),
    !,
    pushstack(first,([_7742],w(verb(_7757,pres,fin)),xnp(_7732,_7733)),nil,_7946,_8004),
    state(_7702,_7703,_7963,_8004,_7793).

statem(_7702,_7703,[statem,_7808,_7837,_7871,_7895,_7929,!,_7963],_7791,_7793) --> 
    not_look_ahead([det],_7808,_7791,_7825),
    obvious_object(_7732,_7733,_7837,_7825,_7856),
    aux1(_7871,_7856,_7886),
    lit_of(_7742,[jeg,vi,han,hun,du],_7895,_7886,_7914),
    w(verb(_7757,inf,fin),_7929,_7914,_7946),
    !,
    pushstack(first,([_7742],w(verb(_7757,pres,fin)),xnp(_7732,_7733)),nil,_7946,_8004),
    state(_7702,_7703,_7963,_8004,_7793).

statem(_7702,_7703,[statem,lit(det),lit(som),!,_7804],_7760,_7762) --> 
    cc(det,_7760,_7787),
    cc(som,_7787,_7798),
    !,
    pushstack(first,([en],w(noun(thing,sin,u,n)),[som]),nil,_7798,_7814),
    state(_7702,_7703,_7804,_7814,_7762).

statem(_7702,_7703,[statem,_7798,_7827,_7851,lit(å),!,_7896],_7781,_7783) --> 
    one_of_lit([nå,så,da,redundant0],_7798,_7781,_7815),
    shoulditbe(_7827,_7815,_7842),
    w(adj2(_7743,_7744),_7851,_7842,_7868),
    cc(å,_7868,_7890),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_7743,_7744)),[å]),nil,_7890,_7906),
    itstatem(_7702,_7703,_7896,_7906,_7783).

statem(_7702,_7703,[statem,_7770,_7799,_7823,!],_7753,_7755) --> 
    one_of_lit([nå,så,da],_7770,_7753,_7787),
    shoulditbe(_7799,_7787,_7814),
    pushstack(first,w(verb(be,pres,fin)),nil,_7814,_7836),itstatem(_7702,_7703,_7823,_7836,_7755),
    !.

shoulditbe([shoulditbe,_7742,_7771,lit(det)],_7731,_7733) --> 
    w(verb(be,_7713,fin),_7742,_7731,_7759),
    redundant0(_7771,_7759,_7786),
    cc(det,_7786,_7733).

shoulditbe([shoulditbe,_7745,_7769,lit(det),_7804],_7734,_7736) --> 
    aux1(_7745,_7734,_7760),
    redundant0(_7769,_7760,_7784),
    cc(det,_7784,_7803),
    w(verb(be,inf,fin),_7804,_7803,_7736).

shoulditbe([shoulditbe,_7746,lit(det),_7786],_7735,_7737) --> 
    one_of_lit([kan,kunne,får,fikk],_7746,_7735,_7763),
    cc(det,_7763,_7785),
    vaere(_7786,_7785,_7737).

vaere([vaere,_7738],_7727,_7729) --> 
    one_of_lit([være,vært,bli,blitt],_7738,_7727,_7729).

statem(_7702,_7703,[statem,lit(det),_7821,_7845,_7879,{},{},!,_7933],_7793,_7795) --> 
    cc(det,_7793,_7820),
    aux1(_7821,_7820,_7836),
    subject(_7739,_7740,_7845,_7836,_7864),
    w(verb(_7744,inf,fin),_7879,_7864,_7896),
    {user:testmember(_7744,[believe,know])},
    {user:verbtype(_7744,rv)},
    !,
    pushstack(first,(xnp(_7739,_7740),w(verb(_7744,pres,fin)),[dette]),nil,_7896,_7974),
    state(_7702,_7703,_7933,_7974,_7795).

statem(_7702,_7703,[statem,_7814,_7848,{},{},_7897,!,_7936],_7797,_7799) --> 
    obvious_object(_7735,_7736,_7814,_7797,_7833),
    w(verb(_7743,_7744,fin),_7848,_7833,_7865),
    {user:testmember(_7743,[believe,know])},
    {user:verbtype(_7743,rv)},
    subject(_7761,_7762,_7897,_7865,_7916),
    !,
    pushstack(first,(xnp(_7761,_7762),w(verb(_7743,_7744,fin)),[at],xnp(_7735,_7736)),nil,_7916,_8008),
    state(_7702,_7703,_7936,_8008,_7799).

statem(_7702,_7703,[statem,_7792,_7826,_7850,_7884,!,_7918],_7775,_7777) --> 
    obvious_object(_7729,_7730,_7792,_7775,_7811),
    has(_7826,_7811,_7841),
    subject(_7735,_7736,_7850,_7841,_7869),
    w(verb(_7740,past,part),_7884,_7869,_7901),
    !,
    pushstack(first,(xnp(_7735,_7736),w(verb(_7740,past,fin)),xnp(_7729,_7730)),nil,_7901,_7990),
    state(_7702,_7703,_7918,_7990,_7777).

statem(_7702,_7703,[statem,lit(å),_7815,_7844,_7887,!,_7921],_7787,_7789) --> 
    cc(å,_7787,_7814),
    w(verb(_7733,inf,fin),_7815,_7814,_7832),
    pushstack(first,([noen],w(verb(_7733,pres,fin))),nil,_7832,_7857),clausal_object1(_7723,_7726::_7727,_7844,_7857,_7872),
    look_ahead(w(verb(be,pres,fin)),_7887,_7872,_7904),
    !,
    pushstack(first,xnp(_7723,_7726::_7727),nil,_7904,_7962),
    state(_7702,_7703,_7921,_7962,_7789).

statem(_7702,_7703,[statem,lit(det),_7817,lit(seg),_7857,_7886,lit(å),!,_7931,!],_7789,_7791) --> 
    cc(det,_7789,_7816),
    w(verb(let,_7734,fin),_7817,_7816,_7834),
    cc(seg,_7834,_7856),
    negation0(_7739,_7857,_7856,_7874),
    w(verb(do1,inf,fin),_7886,_7874,_7903),
    cc(å,_7903,_7925),
    !,
    pushstack(first,(w(noun(agent,sin,u,n)),aux1,negation(_7739)),nil,_7925,_8002),state(_7702,_7703,_7931,_8002,_7791),
    !.

statem(_7702,_7703,[statem,_7747,_7771],_7730,_7732) --> 
    soredundant(_7747,_7730,_7762),
    sostatem(_7702,_7703,_7771,_7762,_7732).

statem(_7702,_7703,[statem,_7797,_7826,{},_7865,_7904],_7780,_7782) --> 
    w(noun(_7729,_7730,_7731,n),_7797,_7780,_7814),
    look_ahead(w(prep(_7723)),_7826,_7814,_7843),
    {user:testmember(_7723,[at])},
    pp(_7723,_7724,_7725,_7865,_7843,_7886),
    pushstack(free,(w(noun(_7729,_7730,_7731,n)),pp(_7723,_7724,_7725)),nil,_7886,_7947),
    state(_7702,_7703,_7904,_7947,_7782).

statem(_7702,_7703,[statem,_7821,_7855,{},_7894,_7928,!,_7962,!],_7804,_7806) --> 
    lit_of(_7726,[dette],_7821,_7804,_7840),
    w(verb(_7733,_7734,fin),_7855,_7840,_7872),
    {user:(\+testmember(_7733,[be,give,take,cost]))},
    subject(_7752,_7753,_7894,_7872,_7913),
    negation0(_7755,_7928,_7913,_7945),
    !,
    pushstack(first,(xnp(_7752,_7753),w(verb(_7733,_7734,fin)),negation(_7755),[_7726]),nil,_7945,_8036),state(_7702,_7703,_7962,_8036,_7806),
    !.

statem(_7702,_7703,[statem,_7813,{},_7852,!,_7886],_7796,_7798) --> 
    w(adj2(_7735,nil),_7813,_7796,_7830),
    {user:testmember(_7735,[good,bad,correct,true,mild,hot,cold])},
    w(prep(_7731),_7852,_7830,_7869),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7735,nil)),w(prep(_7731))),nil,_7869,_7896),
    state(_7702,_7703,_7886,_7896,_7798).

statem(_7702,_7703,[statem,_7813,{},_7852,!,_7886],_7796,_7798) --> 
    w(adj2(_7735,nil),_7813,_7796,_7830),
    {user:testmember(_7735,[good,bad,correct,true,mild,hot,cold])},
    w(adv(_7731),_7852,_7830,_7869),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7735,nil)),w(adv(_7731))),nil,_7869,_7896),
    state(_7702,_7703,_7886,_7896,_7798).

statem(_7702,_7703,[statem,_7777,_7801,_7830,!,_7864,!,_7942],_7760,_7762) --> 
    init(_7777,_7760,_7792),
    negation(_7723,_7801,_7792,_7818),
    not_look_ahead(w(verb(_7729,_7730,pass)),_7830,_7818,_7847),
    !,
    pushstack(free,negation(_7723),nil,_7847,_7907),itstatem(_7702,_7703,_7864,_7907,_7922),
    !,
    accept(_7942,_7922,_7762).

statem(_7702,_7703,[statem,_7786,_7810,_7834,_7858,_7887,!,[],_7940],_7769,_7771) --> 
    redundants0(_7786,_7769,_7801),
    dette(_7810,_7801,_7825),
    aux1(_7834,_7825,_7849),
    not_look_ahead([være],_7858,_7849,_7875),
    obvious_object(_7736,_7737,_7887,_7875,_7906),
    !,
    pushstack(free,[dette],nil,_7906,_7939),[],
    pushstack(first,(xnp(_7736,_7737),aux1),nil,_7939,_8009),
    state(_7702,_7703,_7940,_8009,_7771).

statem(_7702,_7703,[statem,_7756,!,_7785,!,_7824],_7739,_7741) --> 
    init(_7756,_7739,_7771),
    !,
    itstatem(_7702,_7703,_7785,_7771,_7804),
    !,
    accept(_7824,_7804,_7741).

statem(_7702,_7705::_7706,[statem,_7756,!,_7795],_7739,_7741) --> 
    state(_7702,_7705::_7706,_7756,_7739,_7775),
    !,
    accept(_7795,_7775,_7741).

statem(_7702,_7705::_7706,[statem,_7849,_7883,_7912,_7936,_7965,lit(å),{},[],{},_8070,{}],_7832,_7834) --> 
    subject(_7744,_7745,_7849,_7832,_7868),
    be(_7740,_7883,_7868,_7900),
    so0(_7912,_7900,_7927),
    gradverb0(_7749,_7936,_7927,_7953),
    w(adj2(_7753,nil),_7965,_7953,_7982),
    cc(å,_7982,_8004),
    {user:testmember(_7753,[difficult,easy,expensive,free,funny,good,intelligent,sad,stupid,tedious])},
    pushstack(free,xnp(_7744,_7745),nil,_8004,_8059),[],
    {user:it_template(_7791)},
    pushstack(first,(w(adj2(_7753,nil)),[å]),nil,_8059,_8083),be_complements(_7791,_7702,_7705::_7741,_8070,_8083,_7834),
    {user:negate(_7740,_7741,_7706)}.

statem(_7702,_7705::_7706,[statem,_7804,_7838,_7862,{},!,_7906,_7930],_7787,_7789) --> 
    np1_accept(_7737,_7738,_7804,_7787,_7823),
    aux1(_7838,_7823,_7853),
    prepnof(_7740,_7862,_7853,_7879),
    {user:testmember(_7740,[on,to,towards])},
    !,
    accept(_7906,_7879,_7921),
    pushstack(first,(np(_7737,_7738),w(verb(go,pres,fin)),prep(to)),nil,_7921,_8004),
    state(_7702,_7705::_7706,_7930,_8004,_7789).

statem(_7702,_7705::_7706,[statem,_7818,_7847,_7876,_7910,_7934,{},_7973],_7801,_7803) --> 
    not_look_ahead([dette],_7818,_7801,_7835),
    not_look_ahead([det],_7847,_7835,_7864),
    np1_accept(_7745,_7746,_7876,_7864,_7895),
    aux1(_7910,_7895,_7925),
    prepnof(_7735,_7934,_7925,_7951),
    {user:testmember(_7735,[to,from,near,in,on,past])},
    pushstack(first,(np(_7745,_7746),w(verb(go,pres,fin)),prep(_7735)),nil,_7951,_8045),
    state(_7702,_7705::_7706,_7973,_8045,_7803).

statem(_7702,_7705::_7706,[statem,_7820,_7849,_7878,_7912,_7941,_7965,_7994,_8023,_8052],_7803,_7805) --> 
    not_look_ahead([dette],_7820,_7803,_7837),
    not_look_ahead([det],_7849,_7837,_7866),
    np1_accept(_7752,_7753,_7878,_7866,_7897),
    not_look_ahead([kan],_7912,_7897,_7929),
    aux1(_7941,_7929,_7956),
    look_ahead([hjem],_7965,_7956,_7982),
    not_look_ahead([kunne],_7994,_7982,_8011),
    not_look_ahead(w(verb(_7771,_7772,_7773)),_8023,_8011,_8040),
    pushstack(first,(np(_7752,_7753),w(verb(go,pres,fin))),nil,_8040,_8093),
    state(_7702,_7705::_7706,_8052,_8093,_7805).

statem(_7702,_7703,[statem,_7773,_7797,_7821,[],_7869],_7756,_7758) --> 
    dedette(_7773,_7756,_7788),
    aux1(_7797,_7788,_7812),
    np1_accept(_7723,_7724,_7821,_7812,_7840),
    pushstack(free,[dette],nil,_7840,_7868),[],
    pushstack(first,(xnp(_7723,_7724),aux1),nil,_7868,_7938),
    state(_7702,_7703,_7869,_7938,_7758).

dedette([dedette,lit(det)],_7719,_7721) --> 
    cc(det,_7719,_7721).

dedette([dedette,lit(dette)],_7719,_7721) --> 
    cc(dette,_7719,_7721).

soredundant0([soredundant0,_7731,!],_7720,_7722) --> 
    soredundant(_7731,_7720,_7722),
    !.

soredundant([soredundant,lit(når),!],_7722,_7724) --> 
    cc(når,_7722,_7724),
    !.

soredundant([soredundant,_7731,!],_7720,_7722) --> 
    so(_7731,_7720,_7722),
    !.

soredundant([soredundant,_7728],_7717,_7719) --> 
    redundant(_7728,_7717,_7719).

so([so,lit(så),!],_7722,_7724) --> 
    cc(så,_7722,_7724),
    !.

so([so,lit(derfor),!],_7722,_7724) --> 
    cc(derfor,_7722,_7724),
    !.

so([so,_7740],_7729,_7731) --> 
    look_ahead_lit([kan,må,vil,skal,bør],_7740,_7729,_7731).

so([so,_7736],_7725,_7727) --> 
    look_ahead(w(verb(know,_7707,fin)),_7736,_7725,_7727).

statem(_7702,_7705::_7706,[statem,_7794,_7833,lit(kan),_7868,_7892,_7926,_7950],_7777,_7779) --> 
    adverbx(_7735,_7736,pre,_7794,_7777,_7815),
    saa0(_7833,_7815,_7848),
    cc(kan,_7848,_7867),
    redundant0(_7868,_7867,_7883),
    np1_accept(_7744,_7745,_7892,_7883,_7911),
    redundant0(_7926,_7911,_7941),
    pushstack(free,(noun_phrase1(_7744,_7745),[kan],xadverb(_7735,_7736)),nil,_7941,_8026),
    state(_7702,_7705::_7706,_7950,_8026,_7779).

statem(_7702,_7705::_7706,[statem,_7790,_7829,_7853,_7877,_7901,_7935,_7959],_7773,_7775) --> 
    adverbx(_7735,_7736,pre,_7790,_7773,_7811),
    saa0(_7829,_7811,_7844),
    aux1(_7853,_7844,_7868),
    redundant0(_7877,_7868,_7892),
    np1_accept(_7742,_7743,_7901,_7892,_7920),
    redundant0(_7935,_7920,_7950),
    pushstack(free,(noun_phrase1(_7742,_7743),aux1,xadverb(_7735,_7736)),nil,_7950,_8059),
    state(_7702,_7705::_7706,_7959,_8059,_7775).

statem(_7702,_7705::_7706,[statem,_7793,_7832,_7856,lit(jeg),_7891,!,_7920,_7944],_7776,_7778) --> 
    adverbx(_7738,_7739,pre,_7793,_7776,_7814),
    saa0(_7832,_7814,_7847),
    aux1(_7856,_7847,_7871),
    cc(jeg,_7871,_7890),
    redundant0(_7891,_7890,_7906),
    !,
    accept(_7920,_7906,_7935),
    pushstack(free,([jeg],[skal],xadverb(_7738,_7739)),nil,_7935,_7985),
    state(_7702,_7705::_7706,_7944,_7985,_7778).

statem(_7702,_7705::_7706,[statem,lit(at),_7780,_7814,{}],_7752,_7754) --> 
    cc(at,_7752,_7779),
    statem(_7702,_7705::_7720,_7780,_7779,_7799),
    be_truefalse(_7719,_7814,_7799,_7754),
    {user:negate(_7719,_7720,_7706)}.

statem(_7702,_7705::_7706,[statem,_7794,_7833,_7857,_7886,_7915],_7777,_7779) --> 
    adverbx(_7729,_7730,pre,_7794,_7777,_7815),
    saa0(_7833,_7815,_7848),
    w(verb(_7738,_7739,_7740),_7857,_7848,_7874),
    negation0(_7742,_7886,_7874,_7903),
    lock(last,_7903,_7993),
    pushstack(last,(w(verb(_7738,_7739,_7740)),negation(_7742),xadverb(_7729,_7730)),nil,_7993,_7999),
    state(_7702,_7705::_7706,_7915,_7999,_7988),
    unlock(_7988,_7779).

statem(_7702,_7705::_7706,[statem,_7805,_7844,_7873,_7907,!,_7941],_7788,_7790) --> 
    adverbx(_7732,_7733,pre,_7805,_7788,_7826),
    w(verb(be,_7742,fin),_7844,_7826,_7861),
    np1_accept(_7745,_7746,_7873,_7861,_7892),
    w(verb(_7750,_7751,part),_7907,_7892,_7924),
    !,
    lock(last,_7924,_8020),
    pushstack(last,(np(_7745,_7746),w(verb(_7750,_7751,fin)),xadverb(_7732,_7733)),nil,_8020,_8026),
    state(_7702,_7705::_7706,_7941,_8026,_8015),
    unlock(_8015,_7790).

statem(_7702,_7705::_7706,[statem,_7797,_7836,_7860,_7894,!,_7928],_7780,_7782) --> 
    adverbx(_7732,_7733,pre,_7797,_7780,_7818),
    be(_7836,_7818,_7851),
    specific_phrase(_7739,_7742::_7743,_7860,_7851,_7879),
    negation0(_7745,_7894,_7879,_7911),
    !,
    pushstack(free,(np(_7739,_7742::_7743),be(_7745),xadverb(_7732,_7733)),nil,_7911,_8033),
    state(_7702,_7705::_7706,_7928,_8033,_7782).

statem(_7702,_7705::_7706,[statem,_7785,_7824,_7853,!,_7887],_7768,_7770) --> 
    adverbx(_7726,_7727,pre,_7785,_7768,_7806),
    w(verb(be,_7736,fin),_7824,_7806,_7841),
    negation0(_7739,_7853,_7841,_7870),
    !,
    pushstack(free,(be(_7739),xadverb(_7726,_7727)),nil,_7870,_7958),
    state(_7702,_7705::_7706,_7887,_7958,_7770).

statem(_7702,_7705::_7706,[statem,_7769,_7808,_7832,_7856],_7752,_7754) --> 
    adverbx(_7720,_7721,pre,_7769,_7752,_7790),
    saa0(_7808,_7790,_7823),
    do(_7832,_7823,_7847),
    pushstack(free,xadverb(_7720,_7721),nil,_7847,_7897),
    state(_7702,_7705::_7706,_7856,_7897,_7754).

statem(_7702,_7703,[statem,_7790,_7829,_7853,_7887,_7916],_7773,_7775) --> 
    adverbx(_7726,_7727,pre,_7790,_7773,_7811),
    has(_7829,_7811,_7844),
    specific_phrase(_7733,_7734,_7853,_7844,_7872),
    w(verb(_7738,past,part),_7887,_7872,_7904),
    lock(last,_7904,_7995),
    pushstack(last,(xnp(_7733,_7734),w(verb(_7738,past,fin)),xadverb(_7726,_7727)),nil,_7995,_8001),
    state(_7702,_7703,_7916,_8001,_7990),
    unlock(_7990,_7775).

statem(_7702,_7703,[statem,_7776,_7815,_7844],_7759,_7761) --> 
    preadverbial1(_7717,_7718,_7719,_7776,_7759,_7797),
    w(verb(be,pres,fin),_7815,_7797,_7832),
    pushstack(free,(w(verb(be,pres,fin)),adverbial1(_7717,_7718,_7719)),nil,_7832,_7886),
    state(_7702,_7703,_7844,_7886,_7761).

statem(_7702,_7703,[statem,_7756,_7780,!,_7809,_7833],_7739,_7741) --> 
    preadverbials0(_7756,_7739,_7771),
    aux1(_7780,_7771,_7795),
    !,
    accept(_7809,_7795,_7824),
    state(_7702,_7703,_7833,_7824,_7741).

statem(_7702,_7705::_7706,[statem,_7782,_7821,!,_7850],_7765,_7767) --> 
    adverbial1(_7726,_7727,_7730::_7731,_7782,_7765,_7803),
    be(_7821,_7803,_7836),
    !,
    pushstack(free,(thereit,be,adverbial1(_7726,_7727,_7730::_7731)),nil,_7836,_7955),
    statem(_7702,_7705::_7706,_7850,_7955,_7767).

statem(_7702,_7705::_7706,[statem,_7817,_7856,_7880,_7914,!,_7948],_7800,_7802) --> 
    preadverbial1(_7735,_7736,_7739::_7740,_7817,_7800,_7838),
    do(_7856,_7838,_7871),
    specific_phrase(_7749,_7752::_7753,_7880,_7871,_7899),
    w(prep(_7757),_7914,_7899,_7931),
    !,
    pushstack(free,(np(_7749,_7752::_7753),w(verb(go,pres,fin)),w(prep(_7757)),adverbial1(_7735,_7736,_7739::_7740)),nil,_7931,_8027),
    state(_7702,_7705::_7706,_7948,_8027,_7802).

statem(_7702,_7705::_7706,[statem,_7776,_7815,!,_7844],_7759,_7761) --> 
    preadverbial1(_7720,_7721,_7724::_7725,_7776,_7759,_7797),
    do(_7815,_7797,_7830),
    !,
    pushstack(free,adverbial1(_7720,_7721,_7724::_7725),nil,_7830,_7889),
    state(_7702,_7705::_7706,_7844,_7889,_7761).

statem(_7702,_7703,[statem,_7794,_7833,_7857,_7886,!,_7925],_7777,_7779) --> 
    preadverbial1(_7729,_7730,_7731,_7794,_7777,_7815),
    so0(_7833,_7815,_7848),
    w(verb(have,_7740,fin),_7857,_7848,_7874),
    subject(_7743,_7744,_7886,_7874,_7905),
    !,
    pushstack(free,(xnp(_7743,_7744),w(verb(have,_7740,fin)),adverbial1(_7729,_7730,_7731)),nil,_7905,_7998),
    state(_7702,_7703,_7925,_7998,_7779).

statem(_7702,_7705::_7706,[statem,{},_7833,_7872,_7911,!,_7960,_7984],_7806,_7808) --> 
    {user:value(dialog,1)},
    preadverbial1(_7750,_7751,_7754::_7755,_7833,_7806,_7854),
    preadverbial1(_7735,_7736,_7739::_7740,_7872,_7854,_7893),
    lexv(_7764,_7765,_7766,fin,_7911,_7893,_7934),
    !,
    accept(_7960,_7934,_7975),
    lock(last,_7975,_8102),
    pushstack(last,(lexv(_7764,_7765,_7766,fin),adverbial1(_7750,_7751,_7754::_7755),adverbial1(_7735,_7736,_7739::_7740)),nil,_8102,_8108),
    state(_7702,_7705::_7706,_7984,_8108,_8097),
    unlock(_8097,_7808).

prestatem(_7702,_7703,[prestatem,_7796,_7825,lit(det),_7870,!,_7904],_7779,_7781) --> 
    w(verb(_7733,_7734,fin),_7796,_7779,_7813),
    gmem(_7733,[be,stand],_7825,_7813,_7844),
    cc(det,_7844,_7869),
    w(adj2(_7728,_7729),_7870,_7869,_7887),
    !,
    pushstack(first,(w(verb(be,_7734,fin)),w(adj2(_7728,_7729))),nil,_7887,_7914),
    itstatem(_7702,_7703,_7904,_7914,_7781).

prestatem(_7702,_7703,[prestatem,_7823,_7847,_7871,_7900,_7924,_7958,_7982,{},_8021,!,_8060],_7806,_7808) --> 
    so0(_7823,_7806,_7838),
    aux1(_7847,_7838,_7862),
    negation0(_7750,_7871,_7862,_7888),
    redundant0(_7900,_7888,_7915),
    object(_7747,_7748,_7924,_7915,_7943),
    redundant0(_7958,_7943,_7973),
    w(verb(_7757,_7758,pass),_7982,_7973,_7999),
    {user:(\+testmember(_7757,[be]))},
    whodidit(_7770,_7771,_8021,_7999,_8040),
    !,
    pushstack(first,(xnp(_7770,_7771),w(verb(_7757,_7758,fin)),negation(_7750),xnp(_7747,_7748)),nil,_8040,_8162),
    state(_7702,_7703,_8060,_8162,_7808).

prestatem(_7702,_7703,[prestatem,_7783,_7807,_7836,!,_7880],_7766,_7768) --> 
    shoulditbe(_7783,_7766,_7798),
    not_look_ahead(w(adj2(_7731,_7732)),_7807,_7798,_7824),
    adverbix0(_7723,_7724,_7725,_7836,_7824,_7857),
    !,
    pushstack(free,(w(verb(be,pres,fin)),xadverbial1(_7723,_7724,_7725)),nil,_7857,_7922),
    itstatem(_7702,_7703,_7880,_7922,_7768).

prestatem(_7702,_7703,[prestatem,_7764,lit(det),_7804,!,_7833],_7747,_7749) --> 
    w(verb(be,_7723,fin),_7764,_7747,_7781),
    cc(det,_7781,_7803),
    slikat(_7804,_7803,_7819),
    !,
    state(_7702,_7703,_7833,_7819,_7749).

prestatem(_7702,_7703,[prestatem,_7807,_7836,lit(det),_7881,_7905,_7934,!,_7963,_7997],_7790,_7792) --> 
    w(verb(_7743,_7744,fin),_7807,_7790,_7824),
    gmem(_7743,[have,be],_7836,_7824,_7855),
    cc(det,_7855,_7880),
    redundant0(_7881,_7880,_7896),
    w(verb(_7737,past,part),_7905,_7896,_7922),
    look_ahead_np(_7934,_7922,_7949),
    !,
    subject(_7762,_7763,_7963,_7949,_7982),
    pushstack(first,(xnp(_7762,_7763),w(verb(_7737,past,fin))),nil,_7982,_8038),
    state(_7702,_7703,_7997,_8038,_7792).

prestatem(_7702,_7703,[prestatem,_7792,_7816,_7850,_7879,!,_7918],_7775,_7777) --> 
    has(_7792,_7775,_7807),
    subject(_7732,_7733,_7816,_7807,_7835),
    w(verb(_7737,past,part),_7850,_7835,_7867),
    object(_7729,_7730,_7879,_7867,_7898),
    !,
    pushstack(first,(xnp(_7732,_7733),w(verb(_7737,past,fin)),xnp(_7729,_7730)),nil,_7898,_7990),
    state(_7702,_7703,_7918,_7990,_7777).

prestatem(_7702,_7703,[prestatem,_7810,{},_7849,_7883,_7912,!,_7951],_7793,_7795) --> 
    w(verb(_7737,_7738,fin),_7810,_7793,_7827),
    {user:(\+member(_7737,[]))},
    subject(_7748,_7749,_7849,_7827,_7868),
    not_look_ahead(w(verb(_7755,_7756,_7757)),_7883,_7868,_7900),
    object(_7732,_7733,_7912,_7900,_7931),
    !,
    pushstack(first,(xnp(_7748,_7749),w(verb(_7737,past,fin)),xnp(_7732,_7733)),nil,_7931,_8023),
    state(_7702,_7703,_7951,_8023,_7795).

prestatem(_7702,_7703,[prestatem,_7813,_7842,_7871,_7895,lit(det),_7935,_7959,!,_7993],_7796,_7798) --> 
    not_look_ahead(w(verb(be,_7745,_7746)),_7813,_7796,_7830),
    not_look_ahead(w(verb(be1,_7753,_7754)),_7842,_7830,_7859),
    so0(_7871,_7859,_7886),
    w(verb(_7758,_7759,fin),_7895,_7886,_7912),
    cc(det,_7912,_7934),
    not_look_ahead_np(_7935,_7934,_7950),
    negation0(_7738,_7959,_7950,_7976),
    !,
    pushstack(first,([dette],w(verb(_7758,_7759,fin)),negation(_7738)),nil,_7976,_8033),
    state(_7702,_7703,_7993,_8033,_7798).

prestatem(_7702,_7703,[prestatem,_7809,_7838,_7867,_7891,_7920,_7944,_7978,!,_8012],_7792,_7794) --> 
    not_look_ahead(w(verb(be,_7742,_7743)),_7809,_7792,_7826),
    not_look_ahead(w(verb(be1,_7750,_7751)),_7838,_7826,_7855),
    so0(_7867,_7855,_7882),
    w(verb(_7755,_7756,fin),_7891,_7882,_7908),
    det0(_7920,_7908,_7935),
    particlev0(_7755,_7760,_7944,_7935,_7963),
    negation0(_7735,_7978,_7963,_7995),
    !,
    pushstack(free,(w(verb(_7760,_7756,fin)),negation(_7735)),nil,_7995,_8052),
    state(_7702,_7703,_8012,_8052,_7794).

prestatem(_7702,_7703,[prestatem,_7810,_7834,{},_7873,_7897,!,_7931,_7965],_7793,_7795) --> 
    so0(_7810,_7793,_7825),
    w(verb(_7743,_7744,pass),_7834,_7825,_7851),
    {user:(\+testmember(_7743,[be]))},
    thereit0(_7873,_7851,_7888),
    negation0(_7756,_7897,_7888,_7914),
    !,
    object(_7738,_7739,_7931,_7914,_7950),
    pushstack(first,([noen],w(verb(_7743,_7744,fin)),negation(_7756),xnp(_7738,_7739)),nil,_7950,_8036),
    state(_7702,_7703,_7965,_8036,_7795).

prestatem(_7702,_7703,[prestatem,_7787,_7816,!,_7850,_7884],_7770,_7772) --> 
    w(verb(be,_7731,fin),_7787,_7770,_7804),
    negation0(_7726,_7816,_7804,_7833),
    !,
    subject(_7736,_7737,_7850,_7833,_7869),
    pushstack(first,(xnp(_7736,_7737),w(verb(be,_7731,fin)),negation(_7726)),nil,_7869,_7955),
    state(_7702,_7703,_7884,_7955,_7772).

prestatem(_7702,_7703,[prestatem,_7797,lit(kan),_7832,_7866,_7890,_7919,!,_7953],_7780,_7782) --> 
    so0(_7797,_7780,_7812),
    cc(kan,_7812,_7831),
    subject(_7740,_7741,_7832,_7831,_7851),
    redundant0(_7866,_7851,_7881),
    not_look_ahead(w(verb(_7747,_7748,_7749)),_7890,_7881,_7907),
    not_look_ahead([ikke],_7919,_7907,_7936),
    !,
    pushstack(free,(xnp(_7740,_7741),w(verb(do1,pres,fin))),nil,_7936,_7994),
    state(_7702,_7703,_7953,_7994,_7782).

prestatem(_7702,_7703,[prestatem,_7778,_7802,_7826,_7860,!,_7894],_7761,_7763) --> 
    so0(_7778,_7761,_7793),
    aux1(_7802,_7793,_7817),
    subject(_7731,_7732,_7826,_7817,_7845),
    negation0(_7729,_7860,_7845,_7877),
    !,
    pushstack(free,(xnp(_7731,_7732),aux1,negation(_7729)),nil,_7877,_7993),
    state(_7702,_7703,_7894,_7993,_7763).

itstatem(_7702,_7703,[itstatem,_7794,_7818,lit(at),_7863,!,_7902,_7936],_7777,_7779) --> 
    be(_7794,_7777,_7809),
    np0_accept(_7732,_7733,_7818,_7809,_7837),
    cc(at,_7837,_7862),
    traceprint(4,it00,_7863,_7862,_7882),
    !,
    clausal_object1(_7743,_7744,_7902,_7882,_7921),
    pushstack(first,(xnp(_7743,_7744),w(verb(be,pres,fin)),xnp(_7732,_7733)),nil,_7921,_8008),
    state(_7702,_7703,_7936,_8008,_7779).

itstatem(_7702,_7703,[itstatem,_7778,_7802,_7831,_7855,!,_7894],_7761,_7763) --> 
    be(_7778,_7761,_7793),
    not_look_ahead(w(adj2(_7733,_7734)),_7802,_7793,_7819),
    look_ahead_np(_7831,_7819,_7846),
    traceprint(4,it01,_7855,_7846,_7874),
    !,
    pushstack(free,w(verb(exist,pres,fin)),nil,_7874,_7904),
    state(_7702,_7703,_7894,_7904,_7763).

itstatem(_7702,_7703,[itstatem,_7782,{},_7821,_7845,!,_7884],_7765,_7767) --> 
    w(verb(_7725,_7726,fin),_7782,_7765,_7799),
    {user:_7725\==be},
    look_ahead_np(_7821,_7799,_7836),
    traceprint(4,it02,_7845,_7836,_7864),
    !,
    pushstack(free,w(verb(_7725,_7726,fin)),nil,_7864,_7894),
    state(_7702,_7703,_7884,_7894,_7767).

itstatem(_7702,_7703,[itstatem,_7809,_7838,{},_7897,_7931,!,_7970],_7792,_7794) --> 
    negation0(_7734,_7809,_7792,_7826),
    hlexv(_7736,_7737,_7738,fin,_7740,_7838,_7826,_7863),
    {user:bigno(_7734,_7740,_7732)},
    gmem(_7737,[help,give,make,create],_7897,_7863,_7916),
    traceprint(4,it0,_7931,_7916,_7950),
    !,
    pushstack(first,([dette],w(verb(_7737,_7738,fin)),negation(_7732)),nil,_7950,_8010),
    state(_7702,_7703,_7970,_8010,_7794).

itstatem(_7702,_7703,[itstatem,_7793,_7822,_7856,_7890,_7924],_7776,_7778) --> 
    w(verb(_7730,_7731,fin),_7793,_7776,_7810),
    gmem(_7730,[have],_7822,_7810,_7841),
    subject(_7739,_7740,_7856,_7841,_7875),
    traceprint(4,it1,_7890,_7875,_7909),
    pushstack(first,(xnp(_7739,_7740),w(verb(_7730,_7731,fin)),[dette]),nil,_7909,_7965),
    state(_7702,_7703,_7924,_7965,_7778).

itstatem(_7702,_7703,[itstatem,_7789,lit(at),_7849,_7873,!,_7912],_7772,_7774) --> 
    lexvaccept(rv,_7732,_7733,fin,_7729,_7789,_7772,_7814),
    cc(at,_7814,_7848),
    look_ahead_np(_7849,_7848,_7864),
    traceprint(4,it2,_7873,_7864,_7892),
    !,
    pushstack(first,([dette],w(verb(_7732,_7733,fin)),negation(_7729)),nil,_7892,_7952),
    state(_7702,_7703,_7912,_7952,_7774).

itstatem(_7702,_7703,[itstatem,_7829,_7853,_7877,_7906,_7935,_7964,lit(som),_8009,_8038,!,_8077,!,_8186],_7812,_7814) --> 
    be(_7829,_7812,_7844),
    redundant0(_7853,_7844,_7868),
    negation0(_7741,_7877,_7868,_7894),
    not_look_ahead(w(nb(_7747,_7748)),_7906,_7894,_7923),
    not_look_ahead_lit([jeg,du],_7935,_7923,_7952),
    np0_accept(_7756,_7757,_7964,_7952,_7983),
    cc(som,_7983,_8008),
    w(verb(_7763,_7764,fin),_8009,_8008,_8026),
    traceprint(4,it3,_8038,_8026,_8057),
    !,
    pushstack(first,(xnp(_7756,_7757),w(verb(_7763,_7764,fin)),negation(_7741)),nil,_8057,_8151),state(_7702,_7703,_8077,_8151,_8166),
    !,
    accept(_8186,_8166,_7814).

itstatem(_7702,_7703,[itstatem,_7832,_7856,_7890,_7919,_7948,_7977,_8006,!,_8045],_7815,_7817) --> 
    be(_7832,_7815,_7847),
    subject(_7749,_7750,_7856,_7847,_7875),
    negation0(_7752,_7890,_7875,_7907),
    not_look_ahead(noun(_7756,_7757,_7758,_7759),_7919,_7907,_7936),
    w(adj2(_7763,nil),_7948,_7936,_7965),
    w(prep(_7768),_7977,_7965,_7994),
    traceprint(4,it4,_8006,_7994,_8025),
    !,
    pushstack(first,(xnp(_7749,_7750),w(verb(be,pres,fin)),negation(_7752),w(adj2(_7763,nil)),w(prep(_7768)),[dette]),nil,_8025,_8116),
    state(_7702,_7703,_8045,_8116,_7817).

itstatem(_7702,_7703,[itstatem,_7801,_7825,_7859,_7888,_7917,!,_7956],_7784,_7786) --> 
    aux1(_7801,_7784,_7816),
    subject(_7737,_7738,_7825,_7816,_7844),
    negation0(_7740,_7859,_7844,_7876),
    w(verb(_7744,_7745,fin),_7888,_7876,_7905),
    traceprint(4,it5,_7917,_7905,_7936),
    !,
    pushstack(first,(xnp(_7737,_7738),w(verb(_7744,pres,fin)),negation(_7740),[dette]),nil,_7936,_8027),
    state(_7702,_7703,_7956,_8027,_7786).

itstatem(_7702,_7703,[itstatem,_7820,_7849,_7878,lit(å),_7918,!,_7957,_8000],_7803,_7805) --> 
    be(_7743,_7820,_7803,_7837),
    gradverb0(_7745,_7849,_7837,_7866),
    w(adj2(_7740,_7741),_7878,_7866,_7895),
    cc(å,_7895,_7917),
    traceprint(4,it7,_7918,_7917,_7937),
    !,
    pushstack(first,([jeg],[vil]),nil,_7937,_7970),clausal_object1(_7765,_7766,_7957,_7970,_7985),
    pushstack(first,(xnp(_7765,_7766),w(verb(be,pres,fin)),negation(_7743),w(adj2(_7740,_7741))),nil,_7985,_8071),
    state(_7702,_7703,_8000,_8071,_7805).

itstatem(_7702,_7703,[itstatem,_7801,_7830,_7874,_7913,!,_7952],_7784,_7786) --> 
    be(_7737,_7801,_7784,_7818),
    ap(_7732,_7733,_7702,_7735,_7830,_7818,_7853),
    pp(with,_7745,_7746,_7874,_7853,_7895),
    traceprint(4,it8,_7913,_7895,_7932),
    !,
    pushstack(first,(xnp(_7745,_7746),w(verb(be,pres,fin)),negation(_7737),ap(_7732,_7733,_7702,_7735)),nil,_7932,_8056),
    state(_7702,_7703,_7952,_8056,_7786).

itstatem(_7702,_7703,[itstatem,_7810,_7839,_7868,lit(at),_7908,!,_7947,_7981],_7793,_7795) --> 
    be(_7743,_7810,_7793,_7827),
    gradverb0(_7745,_7839,_7827,_7856),
    w(adj2(_7740,_7741),_7868,_7856,_7885),
    cc(at,_7885,_7907),
    traceprint(4,it9,_7908,_7907,_7927),
    !,
    clausal_object1(_7757,_7758,_7947,_7927,_7966),
    pushstack(first,(xnp(_7757,_7758),w(verb(be,pres,fin)),negation(_7743),w(adj2(_7740,_7741))),nil,_7966,_8052),
    state(_7702,_7703,_7981,_8052,_7795).

itstatem(_7702,_7703,[itstatem,_7837,_7866,_7895,_7924,_7953,lit(å),_7998,!,_8037,_8061,_8135],_7820,_7822) --> 
    be(_7752,_7837,_7820,_7854),
    gradverb0(_7754,_7866,_7854,_7883),
    w(adj2(_7749,_7750),_7895,_7883,_7912),
    w(prep(for),_7924,_7912,_7941),
    object(_7765,_7766,_7953,_7941,_7972),
    cc(å,_7972,_7997),
    traceprint(4,it10,_7998,_7997,_8017),
    !,
    accept(_8037,_8017,_8052),
    pushstack(first,(xnp(_7765,_7766),[vil]),nil,_8052,_8105),clausal_object1(_7781,_7782,_8061,_8105,_8120),
    pushstack(first,(xnp(_7781,_7782),w(verb(be,pres,fin)),negation(_7752),w(adj2(_7749,_7750))),nil,_8120,_8206),
    state(_7702,_7703,_8135,_8206,_7822).

itstatem(_7702,_7703,[itstatem,_7827,_7856,_7885,lit(å),_7935,!,_7974,_7998,_8041],_7810,_7812) --> 
    be(_7748,_7827,_7810,_7844),
    w(adj2(_7752,_7753),_7856,_7844,_7873),
    pp(_7744,_7745,_7746,_7885,_7873,_7906),
    cc(å,_7906,_7934),
    traceprint(4,it11,_7935,_7934,_7954),
    !,
    accept(_7974,_7954,_7989),
    pushstack(first,[noen],nil,_7989,_8011),clausal_object1(_7769,_7770,_7998,_8011,_8026),
    pushstack(first,(xnp(_7769,_7770),w(verb(be,pres,fin)),negation(_7748),w(adj2(_7752,_7753)),pp(_7744,_7745,_7746)),nil,_8026,_8144),
    state(_7702,_7703,_8041,_8144,_7812).

itstatem(_7702,_7703,[itstatem,_7839,_7868,lit(å),_7923,_7952,_7981,!,_8020,_8063],_7822,_7824) --> 
    be(_7746,_7839,_7822,_7856),
    adj1(_7741,_7753:_7754,_7743,_7744,_7868,_7856,_7891),
    cc(å,_7891,_7922),
    w(verb(_7760,inf,fin),_7923,_7922,_7940),
    reflexiv0(_7760,_7952,_7940,_7969),
    traceprint(4,it12,_7981,_7969,_8000),
    !,
    pushstack(first,([noen],w(verb(_7760,pres,fin))),nil,_8000,_8033),clausal_object1(_7781,_7782,_8020,_8033,_8048),
    pushstack(first,(xnp(_7781,_7782),w(verb(be,pres,fin)),negation(_7746),adj1(_7741,_7753:_7801,_7743,_7744)),nil,_8048,_8170),
    state(_7702,_7703,_8063,_8170,_7824).

itstatem(_7702,_7703,[itstatem,_7796,_7825,_7869,_7893,!,_7932],_7779,_7781) --> 
    be(_7737,_7796,_7779,_7813),
    adj1(_7732,_7733,_7734,_7735,_7825,_7813,_7848),
    not_look_ahead_np(_7869,_7848,_7884),
    traceprint(4,it13,_7893,_7884,_7912),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_7737),adj1(_7732,_7733,_7734,_7735)),nil,_7912,_8003),
    state(_7702,_7703,_7932,_8003,_7781).

itstatem(_7702,_7705::_7706,[itstatem,_7833,_7857,_7881,_7905,_7934,_7963,_7992,_8021,lit(som),_8066,_8100,!,_8209],_7816,_7818) --> 
    be(_7833,_7816,_7848),
    preadverbials0(_7857,_7848,_7872),
    redundant0(_7881,_7872,_7896),
    negation0(_7744,_7905,_7896,_7922),
    not_look_ahead(w(nb(_7750,_7751)),_7934,_7922,_7951),
    not_look_ahead_lit([jeg,du],_7963,_7951,_7980),
    not_look_ahead([det],_7992,_7980,_8009),
    np1_accept(_7763,_7764,_8021,_8009,_8040),
    cc(som,_8040,_8065),
    traceprint(4,it14a,_8066,_8065,_8085),
    pushstack(first,(xnp(_7763,_7764),w(verb(be,pres,fin)),negation(_7744)),nil,_8085,_8174),state(_7702,_7705::_7706,_8100,_8174,_8189),
    !,
    accept(_8209,_8189,_7818).

itstatem(_7702,_7703,[itstatem,_7783,_7807,_7836,_7860,!,_7899],_7766,_7768) --> 
    be(_7783,_7766,_7798),
    negation0(_7729,_7807,_7798,_7824),
    not_look_ahead_np(_7836,_7824,_7851),
    traceprint(4,it14b,_7860,_7851,_7879),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_7729)),nil,_7879,_7939),
    state(_7702,_7703,_7899,_7939,_7768).

itstatem(_7702,_7703,[itstatem,_7798,_7827,lit(med),_7872,_7906,!,_7945],_7781,_7783) --> 
    w(verb(_7731,_7732,fin),_7798,_7781,_7815),
    gmem(_7731,[help,function],_7827,_7815,_7846),
    cc(med,_7846,_7871),
    np0_accept(_7750,_7751,_7872,_7871,_7891),
    traceprint(4,it15,_7906,_7891,_7925),
    !,
    pushstack(first,(xnp(_7750,_7751),w(verb(_7731,_7732,fin))),nil,_7925,_7986),
    state(_7702,_7703,_7945,_7986,_7783).

itstatem(_7702,_7703,[itstatem,_7820,_7849,_7883,lit(å),_7928,!,_7967,_8010],_7803,_7805) --> 
    w(verb(_7740,_7741,fin),_7820,_7803,_7837),
    gmem(_7740,[cost,take],_7849,_7837,_7868),
    np0_accept(_7735,_7736,_7883,_7868,_7902),
    cc(å,_7902,_7927),
    traceprint(4,it16,_7928,_7927,_7947),
    !,
    pushstack(first,([noen],[vil]),nil,_7947,_7980),clausal_object1(_7767,_7768,_7967,_7980,_7995),
    pushstack(first,(xnp(_7767,_7768),w(verb(_7740,_7741,fin)),xnp(_7735,_7736)),nil,_7995,_8082),
    state(_7702,_7703,_8010,_8082,_7805).

itstatem(_7702,_7705::_7706,[itstatem,_7791,_7820,_7844,_7873,_7897,_7921,_7955,{}],_7774,_7776) --> 
    w(verb(go,pres,fin),_7791,_7774,_7808),
    redundants0(_7820,_7808,_7835),
    negation0(_7731,_7844,_7835,_7861),
    ann0(_7873,_7861,_7888),
    infinitive(_7897,_7888,_7912),
    traceprint(4,it17,_7921,_7912,_7940),
    pushstack(first,someone,nil,_7940,_7996),state(_7702,_7705::_7732,_7955,_7996,_7776),
    {user:negate(_7731,_7732,_7706)}.

itstatem(_7702,_7703,[itstatem,_7813,_7842,{},_7901,_7945,_7969,!,_8008],_7796,_7798) --> 
    negation0(_7743,_7813,_7796,_7830),
    hlexv(_7745,go,_7747,fin,_7749,_7842,_7830,_7867),
    {user:bigno(_7743,_7749,_7755)},
    optional([an],_7901,_7867,_7933),
    not_look_ahead_np(_7945,_7933,_7960),
    traceprint(4,it17b,_7969,_7960,_7988),
    !,
    pushstack(first,([dette],w(verb(be,_7747,fin)),negation(_7755),w(adj2(possible,nil))),nil,_7988,_8048),
    state(_7702,_7703,_8008,_8048,_7798).

itstatem(_7702,_7703,[itstatem,_7822,_7851,{},{},_7920,_7944,_7968,!,_8007,_8041],_7805,_7807) --> 
    negation0(_7743,_7822,_7805,_7839),
    hlexv(_7745,_7746,_7747,fin,_7749,_7851,_7839,_7876),
    {user:bigno(_7743,_7749,_7741)},
    {user:(\+testmember(_7746,[cost,take]))},
    preadverbials0(_7920,_7876,_7935),
    look_ahead_np(_7944,_7935,_7959),
    traceprint(4,it18,_7968,_7959,_7987),
    !,
    subject(_7771,_7772,_8007,_7987,_8026),
    pushstack(first,(xnp(_7771,_7772),w(verb(_7746,_7747,fin)),negation(_7741)),nil,_8026,_8112),
    state(_7702,_7703,_8041,_8112,_7807).

itstatem(_7702,_7703,[itstatem,_7798,lit(å),_7838,!,_7877,_7920],_7781,_7783) --> 
    w(verb(_7728,_7729,fin),_7798,_7781,_7815),
    cc(å,_7815,_7837),
    traceprint(4,it19,_7838,_7837,_7857),
    !,
    pushstack(first,([noen],[vil]),nil,_7857,_7890),clausal_object1(_7751,_7752,_7877,_7890,_7905),
    pushstack(first,(xnp(_7751,_7752),w(verb(_7728,_7729,fin))),nil,_7905,_7961),
    state(_7702,_7703,_7920,_7961,_7783).

itstatem(_7702,_7703,[itstatem,_7805,_7829,_7853,_7882,lit(at),_7922,!,_7961,_7985],_7788,_7790) --> 
    blei(_7805,_7788,_7820),
    redundant0(_7829,_7820,_7844),
    negation0(_7743,_7853,_7844,_7870),
    w(verb(_7747,past,part),_7882,_7870,_7899),
    cc(at,_7899,_7921),
    traceprint(4,it20,_7922,_7921,_7941),
    !,
    accept(_7961,_7941,_7976),
    pushstack(first,([noen],w(verb(_7747,past,fin)),negation(_7743),[at]),nil,_7976,_8025),
    state(_7702,_7703,_7985,_8025,_7790).

itstatem(_7702,_7703,[itstatem,_7825,_7849,_7888,_7912,_7941,_7970,_8004,!,_8043,_8067],_7808,_7810) --> 
    blei(_7825,_7808,_7840),
    preadverbial0(_7747,_7748,_7749,_7849,_7840,_7870),
    redundant0(_7888,_7870,_7903),
    negation0(_7755,_7912,_7903,_7929),
    w(verb(_7759,past,part),_7941,_7929,_7958),
    object(_7763,_7764,_7970,_7958,_7989),
    traceprint(4,it21,_8004,_7989,_8023),
    !,
    accept(_8043,_8023,_8058),
    pushstack(first,(xnp(_7763,_7764),w(verb(be,pres,fin)),negation(_7755),w(verb(_7759,past,part)),adverbial1(_7747,_7748,_7749)),nil,_8058,_8170),
    state(_7702,_7703,_8067,_8170,_7810).

itstatem(_7702,_7703,[itstatem,_7786,_7815,_7844,!,_7883],_7769,_7771) --> 
    w(verb(_7730,_7731,pass),_7786,_7769,_7803),
    negation0(_7726,_7815,_7803,_7832),
    traceprint(4,it23,_7844,_7832,_7863),
    !,
    pushstack(first,([noen],w(verb(_7730,_7731,fin)),negation(_7726)),nil,_7863,_7923),
    state(_7702,_7703,_7883,_7923,_7771).

itstatem(_7702,_7703,[itstatem,_7821,_7850,_7874,{},_7913,_7937,!,_7976],_7804,_7806) --> 
    w(verb(be,_7746,fin),_7821,_7804,_7838),
    redundant0(_7850,_7838,_7865),
    w(adj2(_7740,nil),_7874,_7865,_7891),
    {user:testmember(_7740,[certain,uncertain,good,bad])},
    atom(_7913,_7891,_7928),
    traceprint(4,it24,_7937,_7928,_7956),
    !,
    pushstack(first,state(_7702,_7703)\(xnp(_7770,_7771),w(verb(be,_7746,fin)),w(adj2(_7740,nil))),nil,_7956,_8019),
    clausal_object1(_7770,_7771,_7976,_8019,_7806).

atom([atom,lit(at)],_7719,_7721) --> 
    cc(at,_7719,_7721).

atom([atom,lit(om)],_7719,_7721) --> 
    cc(om,_7719,_7721).

itstatem(_7702,_7703,[itstatem,_7843,_7872,_7896,lit(å),_7936,_7965,_7994,_8018,!,_8057,_8100],_7826,_7828) --> 
    w(verb(be,_7752,fin),_7843,_7826,_7860),
    redundant0(_7872,_7860,_7887),
    w(adj2(_7746,nil),_7896,_7887,_7913),
    cc(å,_7913,_7935),
    w(verb(_7764,inf,fin),_7936,_7935,_7953),
    reflexiv0(_7764,_7965,_7953,_7982),
    not_look_ahead_np(_7994,_7982,_8009),
    traceprint(4,it25,_8018,_8009,_8037),
    !,
    pushstack(first,([noen],w(verb(_7764,pres,fin)),[dette]),nil,_8037,_8070),clausal_object1(_7784,_7785,_8057,_8070,_8085),
    pushstack(first,(xnp(_7784,_7785),w(verb(be,_7752,fin)),w(adj2(_7746,nil))),nil,_8085,_8141),
    state(_7702,_7703,_8100,_8141,_7828).

itstatem(_7702,_7703,[itstatem,_7800,_7829,_7858,_7887,!,_7926],_7783,_7785) --> 
    w(verb(be,_7739,fin),_7800,_7783,_7817),
    negation0(_7742,_7829,_7817,_7846),
    w(prep(_7734),_7858,_7846,_7875),
    traceprint(4,it26,_7887,_7875,_7906),
    !,
    pushstack(first,([dette],w(verb(be,_7739,fin)),negation(_7742),w(prep(_7734))),nil,_7906,_7966),
    state(_7702,_7703,_7926,_7966,_7785).

itstatem(_7702,_7703,[itstatem,_7830,_7859,lit(å),_7899,_7928,!,_7967,!,_8015],_7813,_7815) --> 
    w(verb(be,pres,fin),_7830,_7813,_7847),
    w(adj2(_7740,nil),_7859,_7847,_7876),
    cc(å,_7876,_7898),
    w(verb(_7758,inf,fin),_7899,_7898,_7916),
    traceprint(4,it27,_7928,_7916,_7947),
    !,
    pushstack(first,([jeg],w(verb(_7758,pres,fin))),nil,_7947,_7980),clausal_object1(_7777,_7778,_7967,_7980,_7995),
    !,
    pushstack(first,(xnp(_7777,_7778),w(verb(be,pres,fin)),w(adj2(_7740,nil))),nil,_7995,_8056),
    state(_7702,_7703,_8015,_8056,_7815).

itstatem(_7702,_7703,[itstatem,_7796,{},_7835,_7869,!,_7908],_7779,_7781) --> 
    w(verb(_7733,_7734,fin),_7796,_7779,_7813),
    {user:verbtype(_7733,rv)},
    subject(_7742,_7743,_7835,_7813,_7854),
    traceprint(4,it28,_7869,_7854,_7888),
    !,
    pushstack(first,(xnp(_7742,_7743),w(verb(_7733,pres,fin)),[dette]),nil,_7888,_7949),
    state(_7702,_7703,_7908,_7949,_7781).

itstatem(_7702,_7703,[itstatem,_7837,_7866,_7900,_7924,_7953,{},lit(noe),lit(om),_8014,_8048],_7820,_7822) --> 
    w(verb(have,_7755,fin),_7837,_7820,_7854),
    subject(_7758,_7759,_7866,_7854,_7885),
    redundant0(_7900,_7885,_7915),
    negation0(_7761,_7924,_7915,_7941),
    w(verb(_7765,past,part),_7953,_7941,_7970),
    {user:testmember(_7765,[tell])},
    cc(noe,_7970,_8002),
    cc(om,_8002,_8013),
    traceprint(4,it29,_8014,_8013,_8033),
    pushstack(first,(xnp(_7758,_7759),w(verb(_7765,past,fin)),negation(_7761),[noe],[om],[det]),nil,_8033,_8119),
    state(_7702,_7703,_8048,_8119,_7822).

itstatem(_7702,_7703,[itstatem,_7791,{},_7830,!,_7869],_7774,_7776) --> 
    w(verb(_7725,_7732,fin),_7791,_7774,_7808),
    {user:testmember(_7725,[concern])},
    traceprint(4,it30,_7830,_7808,_7849),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_7725,pres,fin))),nil,_7849,_7879),
    state(_7702,_7703,_7869,_7879,_7776).

itstatem(_7702,_7703,[itstatem,_7818,{},_7857,_7886,_7930,!,_7969],_7801,_7803) --> 
    w(verb(_7738,_7739,fin),_7818,_7801,_7835),
    {user:testmember(_7738,[go,look,see,function])},
    w(adv(_7734),_7857,_7835,_7874),
    optional([ut],_7886,_7874,_7918),
    traceprint(4,it31,_7930,_7918,_7949),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_7738,pres,fin)),w(adv(_7734))),nil,_7949,_7979),
    state(_7702,_7703,_7969,_7979,_7803).

itstatem(_7702,_7705::_7706,[itstatem,_7795,{},_7834,!,_7873],_7778,_7780) --> 
    w(verb(_7727,_7734,fin),_7795,_7778,_7812),
    {user:testmember(_7727,[rain,snow,look,be_urgent])},
    traceprint(4,it32,_7834,_7812,_7853),
    !,
    pushstack(first,(something,lexv(iv,_7727,pres,fin)),nil,_7853,_7947),
    state(_7702,_7705::_7706,_7873,_7947,_7780).

itstatem(_7702,_7705::_7706,[itstatem,_7782,{},_7826,_7860],_7765,_7767) --> 
    pvimodal(_7722,_7727,_7782,_7765,_7801),
    {user:constrainit(_7731,thing)},
    traceprint(4,it32,_7826,_7801,_7845),
    pushstack(first,w(verb(_7722,pres,fin)),nil,_7845,_7870),
    verb_phrase1(_7722,_7731,id,_7702,_7705::_7706,_7860,_7870,_7767).

itstatem(_7702,_7705::_7706,[itstatem,_7792,_7826,_7860,_7894,{}],_7775,_7777) --> 
    beginverb(_7726,_7722,_7792,_7775,_7811),
    np1(_7729,_7730,_7826,_7811,_7845),
    traceprint(4,it33,_7860,_7845,_7879),
    pushstack(first,(np1(_7729,_7730),w(verb(_7726,pres,fin))),nil,_7879,_7940),state(_7702,_7705::_7723,_7894,_7940,_7777),
    {user:negate(_7722,_7723,_7706)}.

itstatem(_7702,_7705::_7706,[itstatem,_7782,_7806,_7845,_7869,_7903],_7765,_7767) --> 
    be(_7782,_7765,_7797),
    adverbial(_7723,_7724,_7727::_7728,_7806,_7797,_7827),
    that(_7845,_7827,_7860),
    traceprint(4,it34,_7869,_7860,_7888),
    lock(last,_7888,_7953),
    pushstack(last,adverbial(_7723,_7724,_7727::_7728),nil,_7953,_7959),
    state(_7702,_7705::_7706,_7903,_7959,_7948),
    unlock(_7948,_7767).

itstatem(_7702,_7705::_7706,[itstatem,_7801,_7825,_7854,_7878,_7907,_7936,_7965,!,_8004,_8028],_7784,_7786) --> 
    be(_7801,_7784,_7816),
    negation0(_7741,_7825,_7816,_7842),
    saa0(_7854,_7842,_7869),
    not_look_ahead(w(verb(_7747,past,part)),_7878,_7869,_7895),
    w(adj2(_7753,nil),_7907,_7895,_7924),
    one_of_lit([at,om],_7936,_7924,_7953),
    traceprint(4,it35,_7965,_7953,_7984),
    !,
    accept(_8004,_7984,_8019),
    statem(_7702,_7705::_7706,_8028,_8019,_7786).

itstatem(_7702,_7705::_7706,[itstatem,_7797,_7821,_7850,_7874,{},_7913,_7942,_7976],_7780,_7782) --> 
    be(_7797,_7780,_7812),
    negation0(_7735,_7821,_7812,_7838),
    saa0(_7850,_7838,_7865),
    w(adj2(_7739,nil),_7874,_7865,_7891),
    {user:testmember(_7739,[good])},
    not_look_ahead(w(noun(_7753,_7754,_7755,_7756)),_7913,_7891,_7930),
    traceprint(4,it36,_7942,_7930,_7961),
    statem(_7702,_7705::_7706,_7976,_7961,_7782).

itstatem(_7702,_7705::_7706,[itstatem,_7844,{},_7883,_7907,_7936,{},_7975,_8009,{}],_7827,_7829) --> 
    be(_7734,_7844,_7827,_7861),
    {user:it_template(_7742)},
    so0(_7883,_7861,_7898),
    gradverb0(_7744,_7907,_7898,_7924),
    w(adj2(_7748,nil),_7936,_7924,_7953),
    {user:testmember(_7748,[difficult,easy,expensive,free,funny,good,intelligent,mild,hot,cold,wet,dark,bright,cloudy,sad,stupid,tedious])},
    traceprint(4,it37,_7975,_7953,_7994),
    pushstack(first,w(adj2(_7748,nil)),nil,_7994,_8022),be_complements(_7742,_7702,_7705::_7735,_8009,_8022,_7829),
    {user:negate(_7734,_7735,_7706)}.

itstatem(_7702,_7705::_7706,[itstatem,_7808,{},_7862,_7891,_7930,!,_7969],_7791,_7793) --> 
    lexv(iv,_7739,_7740,fin,_7808,_7791,_7831),
    {user:(\+testmember(_7739,be))},
    negation0(_7750,_7862,_7831,_7879),
    adverb(_7735,_7736,_7754,_7891,_7879,_7912),
    traceprint(4,it38,_7930,_7912,_7949),
    !,
    pushstack(free,(lexv(iv,_7739,_7740,fin),negation(_7750),xadverb(_7735,_7736)),nil,_7949,_8071),
    state(_7702,_7705::_7706,_7969,_8071,_7793).

itstatem(_7702,_7703,[itstatem,_7787,_7816,_7850,!,_7889,!],_7770,_7772) --> 
    be(_7720,_7787,_7770,_7804),
    subject(_7722,_7723,_7816,_7804,_7835),
    traceprint(4,it39,_7850,_7835,_7869),
    !,
    pushstack(first,(xnp(_7722,_7723),w(verb(exist,pres,fin)),negation(_7720)),nil,_7869,_7963),state(_7702,_7703,_7889,_7963,_7772),
    !.

statreal(_7702,[statreal,_7738],_7724,_7726) --> 
    stat(real,_7702,_7738,_7724,_7726).

stat(_7702,_7703,[stat,_7758,_7792],_7741,_7743) --> 
    state(_7709,_7716::_7717,_7758,_7741,_7777),
    worldcomp(_7702,_7709,_7716::_7717,_7703,_7792,_7777,_7743).

statreal1(_7702,[statreal1,_7746,_7780],_7732,_7734) --> 
    state1(_7708,_7709,_7746,_7732,_7765),
    worldcomp(real,_7708,_7709,_7702,_7780,_7765,_7734).

state1(_7702,_7705::_7706,[state1,_7793,_7827,_7856,!,_7885,{},{},!],_7776,_7778) --> 
    np(_7729,_7732::_7706,_7793,_7776,_7812),
    negation0(_7735,_7827,_7812,_7844),
    redundant0(_7856,_7844,_7871),
    !,
    vp(_7729,_7738,_7702,_7705::_7743,_7885,_7871,_7778),
    {user:bigno(_7735,_7738,_7749)},
    {user:negate(_7749,_7743,_7732)},
    !.

substate(_7702,_7705::_7706,[substate,_7790,_7824,_7848,!,_7882,{},{}],_7773,_7775) --> 
    subject(_7732,_7730::_7706,_7790,_7773,_7809),
    preadverbials0(_7824,_7809,_7839),
    negation0(_7738,_7848,_7839,_7865),
    !,
    vp(_7732,_7741,_7702,_7705::_7729,_7882,_7865,_7775),
    {user:bigno(_7738,_7741,_7728)},
    {user:negate(_7728,_7729,_7730)}.

state(_7702,_7705::_7706,[state,_7787,_7821,_7845,_7874,{},{}],_7770,_7772) --> 
    subject(_7729,_7727::_7706,_7787,_7770,_7806),
    redundant0(_7821,_7806,_7836),
    negation0(_7735,_7845,_7836,_7862),
    vp(_7729,_7738,_7702,_7705::_7726,_7874,_7862,_7772),
    {user:bigno(_7735,_7738,_7725)},
    {user:negate(_7725,_7726,_7727)}.

beginverb(_7702,_7703,[beginverb,_7764,_7793,_7822,_7846],_7747,_7749) --> 
    w(verb(start,_7723,fin),_7764,_7747,_7781),
    negation0(_7703,_7793,_7781,_7810),
    infinitiveand(_7822,_7810,_7837),
    w(verb(_7702,_7717,fin),_7846,_7837,_7749).

question(_7702,[question,_7777,_7806,!,_7835],_7763,_7765) --> 
    w(noun(clock,sin,_7733,n),_7777,_7763,_7794),
    terminator(_7806,_7794,_7821),
    !,
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(clock,sin,def,n))),nil,_7821,_7845),
    whatq(_7702,_7835,_7845,_7765).

question(_7702,[question,_7737],_7723,_7725) --> 
    whichq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    whoq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    whenq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    howadjq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    whereq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    wherefromq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    whatq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    howmuchq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    whyq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    howq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    ppq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7737],_7723,_7725) --> 
    whoseq(_7702,_7737,_7723,_7725).

question(_7702,[question,_7786,_7810,!,_7844,_7878,!,_7907],_7772,_7774) --> 
    be(_7786,_7772,_7801),
    w(noun(clock,_7744,_7745,_7746),_7810,_7801,_7827),
    !,
    np1(_7748,_7749,_7844,_7827,_7863),
    danow0(_7878,_7863,_7893),
    !,
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_7893,_7976),
    whatq(_7702,_7907,_7976,_7774).

question(_7702,[question,_7737],_7723,_7725) --> 
    question1(_7702,_7737,_7723,_7725).

question1(test:::_7705,[question1,lit(får),_7776,!,_7815],_7751,_7753) --> 
    cc(får,_7751,_7775),
    specific_phrase(_7726,_7727,_7776,_7775,_7795),
    !,
    pushstack(first,(np(_7726,_7727),[får]),nil,_7795,_7856),
    statement(_7705,_7815,_7856,_7753).

question1(new:::_7705,[question1,_7794,_7823,{},_7862,!,_7896],_7780,_7782) --> 
    w(verb(have,pres,fin),_7794,_7780,_7811),
    w(verb(_7730,past,part),_7823,_7811,_7840),
    {user:testmember(_7730,[want,think])},
    not_look_ahead([du],_7862,_7840,_7879),
    !,
    pushstack(first,([jeg],w(verb(_7730,pres,fin))),nil,_7879,_7906),
    statement(_7705,_7896,_7906,_7782).

question1(new:::_7705,[question1,_7793,{},_7832,_7866,!,_7900],_7779,_7781) --> 
    w(verb(_7736,pres,fin),_7793,_7779,_7810),
    {user:testmember(_7736,[want,think,hope])},
    particlev0(_7736,_7730,_7832,_7810,_7851),
    not_look_ahead([du],_7866,_7851,_7883),
    !,
    pushstack(first,([jeg],w(verb(_7730,pres,fin))),nil,_7883,_7910),
    statement(_7705,_7900,_7910,_7781).

question1(test:::_7705,[question1,_7740],_7726,_7728) --> 
    question0(_7705,_7740,_7726,_7728).

np_question(which(_7707):::_7705,[np_question,_7746],_7732,_7734) --> 
    np1(_7707,true::_7705,_7746,_7732,_7734).

question0(_7702,[question0,_7737],_7723,_7725) --> 
    isq(_7702,_7737,_7723,_7725).

question0(_7702,[question0,_7737],_7723,_7725) --> 
    ynqs(_7702,_7737,_7723,_7725).

question0(_7702,[question0,_7737],_7723,_7725) --> 
    hasq(_7702,_7737,_7723,_7725).

question0(_7702,[question0,_7740,_7764],_7726,_7728) --> 
    hoq(_7740,_7726,_7755),
    statement(_7702,_7764,_7755,_7728).

implicitq(new:::_7705,[implicitq,_7859,{},_7898,{},{},lit(som),_7958,_7982,_8025,!,_8064,_8088,!,_8142],_7845,_7847) --> 
    w(prep(_7748),_7859,_7845,_7876),
    {user:testmember(_7748,[from,to])},
    w(name(_7761,n,_7763),_7898,_7876,_7915),
    {user:testmember(_7763,[station,neighbourhood])},
    {user:no_unprotected_verb},
    cc(som,_7915,_7957),
    look_ahead_vp(_7958,_7957,_7973),
    pushstack(first,(w(noun(bus,sin,u,n)),w(prep(_7748)),w(name(_7761,n,_7763))),nil,_7973,_7995),np1_accept(_7793,_7796::_7705,_7982,_7995,_8010),
    traceprint(4,iq00,_8025,_8010,_8044),
    !,
    accept(_8064,_8044,_8079),
    verb_phrase1(_7813,_7793,id,_7816,event/real/_7816::_7796,_8088,_8079,_8113),
    !,
    accept(_8142,_8113,_7847).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,_7847,lit(når),{},_7897,_7926,_7970,{},_8009,!,{},_8058,_8097],_7833,_7835) --> 
    not_look_ahead([nr],_7847,_7833,_7864),
    cc(når,_7864,_7886),
    {user:(\+user:value(dialog,1))},
    w(verb(go,_7773,fin),_7897,_7886,_7914),
    optional([neste],_7926,_7914,_7958),
    w(name(_7750,n,_7752),_7970,_7958,_7987),
    {user:testmember(_7752,[station,neighbourhood])},
    traceprint(4,iq01,_8009,_7987,_8028),
    !,
    {user:setvartype(_7800,vehicle)},
    realcomp(_7710,_7804,_7708,_8058,_8028,_8079),
    pushstack(first,w(name(_7750,n,_7752)),nil,_8079,_8107),
    verb_modifiers(go,_7800,_7710,_7707::true,_7804,_8097,_8107,_7835).

implicitq(_7702,[implicitq,_7805,lit(når),{},{},_7865,{},!,_7909,_7933,_7967],_7791,_7793) --> 
    not_look_ahead([nr],_7805,_7791,_7822),
    cc(når,_7822,_7844),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    look_ahead(w(name(_7760,_7761,_7762)),_7865,_7844,_7882),
    {user:subclass0(_7762,place)},
    !,
    accept(_7909,_7882,_7924),
    traceprint(4,iq2,_7933,_7924,_7952),
    pushstack(first,w(prep(to)),nil,_7952,_7977),
    implicitq(_7702,_7967,_7977,_7793).

implicitq(test:::_7705,[implicitq,{},_7806,lit(når),lit(nr),{},!,_7872,_7896,_7930],_7782,_7784) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead([nr],_7806,_7782,_7823),
    cc(når,_7823,_7845),
    cc(nr,_7845,_7856),
    {user:no_unprotected_verb},
    !,
    accept(_7872,_7856,_7887),
    traceprint(4,iq3,_7896,_7887,_7915),
    pushstack(first,w(verb(go,pres,fin)),nil,_7915,_7940),
    ynq(_7705,_7930,_7940,_7784).

implicitq(test:::_7705,[implicitq,_7798,lit(når),{},{},_7858,!,_7907,_7931,_7965],_7784,_7786) --> 
    not_look_ahead([nr],_7798,_7784,_7815),
    cc(når,_7815,_7837),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    optional([det],_7858,_7837,_7890),
    !,
    accept(_7907,_7890,_7922),
    traceprint(4,iq4,_7931,_7922,_7950),
    pushstack(first,w(verb(go,pres,fin)),nil,_7950,_7975),
    ynq(_7705,_7965,_7975,_7786).

implicitq(_7702,[implicitq,_7741,!,_7770],_7727,_7729) --> 
    reject_implicitq(_7741,_7727,_7756),
    !,
    reject(_7770,_7756,_7729).

implicitq(new:::_7705,[implicitq,_7864,{},{},_7913,{},{},_7967,_7996,_8025,_8054,!,_8083,_8107,_8141,_8199,_8243,!,_8272],_7850,_7852) --> 
    look_ahead(w(noun(_7762,sin,u,n)),_7864,_7850,_7881),
    {user:subclass0(_7762,vehicle)},
    {user:no_unprotected_verb},
    np1_accept(_7774,_7777::_7705,_7913,_7881,_7932),
    {user:(\+vartypeid(_7774,time))},
    {user:(\+vartypeid(_7774,clock))},
    constrainvehdep(_7774,_7967,_7932,_7984),
    not_look_ahead([som],_7996,_7984,_8013),
    not_look_ahead([om],_8025,_8013,_8042),
    point0(_8054,_8042,_8069),
    !,
    accept(_8083,_8069,_8098),
    traceprint(4,iq4b,_8107,_8098,_8126),
    pushstack(first,w(verb(go,pres,fin)),nil,_8126,_8154),verb_phrase1(go,_7774,id,_7819,event/real/_7819::_7777,_8141,_8154,_8175),
    optional(itrailer,_8199,_8175,_8231),
    endofline(_8243,_8231,_8258),
    !,
    accept(_8272,_8258,_7852).

implicitq(which(_7707):::_7705,[implicitq,{},_7837,_7866,_7895,_7934,!,_7963,_7997,!,_8091],_7813,_7815) --> 
    {user:value(teleflag,true)},
    w(noun(_7746,_7747,_7748,n),_7837,_7813,_7854),
    not_look_ahead(w(prep(_7755)),_7866,_7854,_7883),
    person_name(_7761:person,_7758,_7759,_7895,_7883,_7916),
    endofline(_7934,_7916,_7949),
    !,
    traceprint(4,iq5,_7963,_7949,_7982),
    lock(exact,_7982,_8050),pushstack(exact,(w(noun(_7746,sin,u,n)),w(prep(to)),nameq1(_7761:person,_7758)),nil,_8050,_8056),no_phrases(_7707,_7705,_7997,_8056,_8045),unlock(_8045,_8046),
    !,
    accept(_8091,_8046,_7815).

implicitq(which(_7707):::_7705,[implicitq,{},_7779,_7813,_7837,!,_7876],_7755,_7757) --> 
    {user:value(teleflag,true)},
    no_phrases(_7707,_7705,_7779,_7755,_7798),
    endofline(_7813,_7798,_7828),
    traceprint(4,iq7,_7837,_7828,_7856),
    !,
    accept(_7876,_7856,_7757).

implicitq(new:::_7705,[implicitq,{},_7858,{},_7897,_7926,_7955,_7998,!,_8037,_8061,_8119,!,_8148],_7834,_7836) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead(w(prep(_7757)),_7858,_7834,_7875),
    {user:no_unprotected_verb},
    w(noun(time,_7764,_7765,_7766),_7897,_7875,_7914),
    look_ahead(w(prep(_7772)),_7926,_7914,_7943),
    pushstack(first,w(noun(departure,sin,u,_7766)),nil,_7943,_7968),np0(_7784,_7787::_7705,_7955,_7968,_7983),
    traceprint(4,iq8,_7998,_7983,_8017),
    !,
    accept(_8037,_8017,_8052),
    pushstack(first,w(verb(go,pres,fin)),nil,_8052,_8074),verb_phrase1(_7802,_7784,id,_7805,event/real/_7805::_7787,_8061,_8074,_8095),
    endofline(_8119,_8095,_8134),
    !,
    accept(_8148,_8134,_7836).

implicitq(new:::_7705,[implicitq,_7863,_7892,{},_7931,{},{},_7985,_8014,_8043,_8072,!,_8101,_8125,_8159,_8217,_8261,!,_8290],_7849,_7851) --> 
    not_look_ahead(w(nb(_7762,num)),_7863,_7849,_7880),
    not_look_ahead(w(prep(_7769)),_7892,_7880,_7909),
    {user:no_unprotected_verb},
    np1_accept(_7773,_7776::_7705,_7931,_7909,_7950),
    {user:(\+vartypeid(_7773,time))},
    {user:(\+vartypeid(_7773,clock))},
    constrainvehdep(_7773,_7985,_7950,_8002),
    not_look_ahead([som],_8014,_8002,_8031),
    not_look_ahead([om],_8043,_8031,_8060),
    point0(_8072,_8060,_8087),
    !,
    accept(_8101,_8087,_8116),
    traceprint(4,iq9,_8125,_8116,_8144),
    pushstack(first,w(verb(go,pres,fin)),nil,_8144,_8172),verb_phrase1(_7815,_7773,id,_7818,event/real/_7818::_7776,_8159,_8172,_8193),
    optional(itrailer,_8217,_8193,_8249),
    endofline(_8261,_8249,_8276),
    !,
    accept(_8290,_8276,_7851).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,{},_7844,_7873,_7902,{},_7936,_7960,{},_7994,_8033,_8057,_8148,!,_8187,_8211],_7820,_7822) --> 
    {user:value(dialog,1)},
    not_look_ahead([nå],_7844,_7820,_7861),
    time1(_7766,_7873,_7861,_7890),
    endofline(_7902,_7890,_7917),
    {user:no_unprotected_verb},
    no_harmful_adj(_7936,_7917,_7951),
    no_harmful_noun(_7960,_7951,_7975),
    {user:setvartype(_7772,vehicle)},
    realcomp(_7710,_7776,_7708,_7994,_7975,_8015),
    deter0(_8033,_8015,_8048),
    pushstack(first,obviousclock1(_7766:clock,_7766 isa clock),nil,_8048,_8103),verb_modifiers(go,_7772,_7710,_7707::true,_7776,_8057,_8103,_8124),
    traceprint(4,iq10,_8148,_8124,_8167),
    !,
    accept(_8187,_8167,_8202),
    qtrailer0(_8211,_8202,_7822).

implicitq(new:::_7705,[implicitq,{},_7866,_7895,{},_7929,{},{},_7983,_8012,_8041,!,_8075,_8099,_8133,_8191,!,_8220],_7842,_7844) --> 
    {user:value(dialog,1)},
    not_look_ahead(w(prep(_7764)),_7866,_7842,_7883),
    not_look_ahead_flnp(_7895,_7883,_7910),
    {user:no_unprotected_verb},
    np0(_7768,_7771::_7705,_7929,_7910,_7948),
    {user:(\+vartypeid(_7768,time))},
    {user:(\+vartypeid(_7768,clock))},
    constrainvehdep(_7768,_7983,_7948,_8000),
    not_look_ahead([om],_8012,_8000,_8029),
    not_look_ahead([som],_8041,_8029,_8058),
    !,
    accept(_8075,_8058,_8090),
    traceprint(4,iq11,_8099,_8090,_8118),
    pushstack(first,w(verb(go,pres,fin)),nil,_8118,_8146),verb_phrase1(_7810,_7768,id,_7813,event/real/_7813::_7771,_8133,_8146,_8167),
    endofline(_8191,_8167,_8206),
    !,
    accept(_8220,_8206,_7844).

implicitq(_7702,[implicitq,_7805,_7829,_7858,_7887,!,_7921,_7945,_7979],_7791,_7793) --> 
    the0(_7805,_7791,_7820),
    w(nb(_7743,num),_7829,_7820,_7846),
    flnp(_7746,_7858,_7846,_7875),
    w(prep(_7739),_7887,_7875,_7904),
    !,
    accept(_7921,_7904,_7936),
    traceprint(4,iq12,_7945,_7936,_7964),
    pushstack(first,(w(nb(_7743,num)),w(adj2(_7746,nil)),w(noun(route,plu,u,n)),w(prep(_7739))),nil,_7964,_7989),
    implicitq(_7702,_7979,_7989,_7793).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,_7822,_7851,_7880,!,_7914,_7938,_7972,_8011,!,_8074],_7808,_7810) --> 
    flnp(_7739,_7822,_7808,_7839),
    not_look_ahead([p],_7851,_7839,_7868),
    therightprep(_7745,_7880,_7868,_7897),
    !,
    accept(_7914,_7897,_7929),
    traceprint(4,iq13,_7938,_7929,_7957),
    realcomp(_7710,_7751,_7708,_7972,_7957,_7993),
    pushstack(first,w(prep(_7745)),nil,_7993,_8024),verb_modifiers(go,_7767:vehicle,_7710,_7707::_7767 isa vehicle and adj/nil/_7739/_7767/_7710,_7751,_8011,_8024,_8045),
    !,
    accept(_8074,_8045,_7810).

implicitq(_7702,[implicitq,{},_7827,_7856,{},_7895,{},!,_7939,_7963,_7997],_7803,_7805) --> 
    {user:(\+value(dialog,1))},
    w(noun(_7739,_7740,_7741,_7742),_7827,_7803,_7844),
    not_look_ahead(w(name(_7762,_7763,_7764)),_7856,_7844,_7873),
    {user:testmember(_7739,[station])},
    look_ahead(w(prep(_7777)),_7895,_7873,_7912),
    {user:no_unprotected_verb},
    !,
    accept(_7939,_7912,_7954),
    traceprint(4,iq14,_7963,_7954,_7982),
    pushstack(first,(whatbe,w(noun(_7739,_7740,_7741,_7742))),nil,_7982,_8040),
    whatq(_7702,_7997,_8040,_7805).

implicitq(_7702,[implicitq,{},_7815,_7844,{},{},!,_7898,_7922,_7956],_7791,_7793) --> 
    {user:(\+value(dialog,1))},
    w(adj2(nearest,nil),_7815,_7791,_7832),
    look_ahead(w(noun(_7755,_7756,_7757,_7758)),_7844,_7832,_7861),
    {user:testmember(_7755,[station])},
    {user:no_unprotected_verb},
    !,
    accept(_7898,_7861,_7913),
    traceprint(4,iq14b,_7922,_7913,_7941),
    pushstack(first,(whatbe,w(adj2(nearest,nil))),nil,_7941,_7994),
    whatq(_7702,_7956,_7994,_7793).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,lit(nå),{},{},{},_7880,_7909,_7938,{},_7972,_8011,_8069,!,_8108],_7825,_7827) --> 
    cc(nå,_7825,_7849),
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(adj2(_7770,nil)),_7880,_7849,_7897),
    not_look_ahead(w(noun(_7777,_7778,_7779,_7780)),_7909,_7897,_7926),
    not_fnlp(_7938,_7926,_7953),
    {user:setvartype(_7784,vehicle)},
    realcomp(_7710,_7788,_7708,_7972,_7953,_7993),
    pushstack(free,[nå],nil,_7993,_8024),verb_modifiers(go,_7784,_7710,_7707::true,_7788,_8011,_8024,_8045),
    traceprint(4,iq15,_8069,_8045,_8088),
    !,
    accept(_8108,_8088,_7827).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,{},{},{},_7869,_7898,{},_7942,_7981,_8005,!,_8099,_8123,_8157],_7825,_7827) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_7768,_7769)),_7869,_7825,_7886),
    obviousclock1(_7771,_7772,_7898,_7886,_7917),
    {user:setvartype(_7776,vehicle)},
    realcomp(_7710,_7780,_7708,_7942,_7917,_7963),
    deter0(_7981,_7963,_7996),
    pushstack(first,(w(prep(after)),obviousclock1(_7771,_7772)),nil,_7996,_8049),verb_modifiers(go,_7776,_7710,_7707::true,_7780,_8005,_8049,_8070),
    !,
    accept(_8099,_8070,_8114),
    traceprint(4,iq17,_8123,_8114,_8142),
    qtrailer0(_8157,_8142,_7827).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,{},{},_7841,_7880,{},_7914,_7943,_7972,_8011,_8060,!,_8099],_7807,_7809) --> 
    {user:(\+value(dialog,1))},
    {user:no_unprotected_verb},
    namep(_7754,_7755,_7756,_7841,_7807,_7862),
    no_harmful_adj(_7880,_7862,_7895),
    {user:constrain(_7755,vehicle)},
    not_look_ahead([om],_7914,_7895,_7931),
    not_look_ahead(w(nb(_7771,_7772)),_7943,_7931,_7960),
    realcomp(_7710,_7775,_7708,_7972,_7960,_7993),
    verb_modifiers(go,_7755,_7710,_7707::_7756,_7775,_8011,_7993,_8036),
    traceprint(4,iq18,_8060,_8036,_8079),
    !,
    accept(_8099,_8079,_7809).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,_7827,_7856,{},{},_7905,_7944,_8002,!,_8041],_7813,_7815) --> 
    not_look_ahead(w(name(_7740,_7741,_7742)),_7827,_7813,_7844),
    w(noun(_7746,sin,u,n),_7856,_7844,_7873),
    {user:test(_7746 ako day)},
    {user:setvartype(_7760,vehicle)},
    realcomp(_7710,_7764,_7708,_7905,_7873,_7926),
    pushstack(first,(w(prep(on)),w(noun(_7746,sin,u,n))),nil,_7926,_7957),verb_modifiers(go,_7760,_7710,_7707::true,_7764,_7944,_7957,_7978),
    traceprint(4,iq19,_8002,_7978,_8021),
    !,
    accept(_8041,_8021,_7815).

implicitq(new:::_7705,[implicitq,{},_7889,_7918,{},{},{},{},{},_8002,_8031,_8060,!,_8094,_8118,_8152,_8210,!,_8239],_7865,_7867) --> 
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_7764,_7765)),_7889,_7865,_7906),
    np1_accept(_7767,_7770::_7705,_7918,_7906,_7937),
    {user:(\+vartypeid(_7767,thing))},
    {user:(\+vartypeid(_7767,time))},
    {user:(\+vartypeid(_7767,clock))},
    {user:(\+vartypeid(_7767,arrival))},
    {user:(\+vartypeid(_7767,departure))},
    not_look_ahead([om],_8002,_7937,_8019),
    not_look_ahead(w(nb(_7816,_7817)),_8031,_8019,_8048),
    constrainvehdep(_7767,_8060,_8048,_8077),
    !,
    accept(_8094,_8077,_8109),
    traceprint(4,iq20,_8118,_8109,_8137),
    pushstack(first,w(verb(go,pres,fin)),nil,_8137,_8165),verb_phrase1(_7833,_7767,id,_7836,event/real/_7836::_7770,_8152,_8165,_8186),
    endofline(_8210,_8186,_8225),
    !,
    accept(_8239,_8225,_7867).

implicitq(new:::_7705,[implicitq,lit(når),_7821,!,_7865,_7889,!,_7923,_7957,_8032],_7796,_7798) --> 
    cc(når,_7796,_7820),
    np_kernel(_7742,_7743,_7744,_7821,_7820,_7842),
    !,
    accept(_7865,_7842,_7880),
    constrainvehdep(_7743,_7889,_7880,_7906),
    !,
    traceprint(4,iq21,_7923,_7906,_7942),
    pushstack(first,np_kernel(0,_7743,_7744),nil,_7942,_8002),np1(_7743,_7761::_7705,_7957,_8002,_8017),
    pushstack(first,w(verb(go,pres,fin)),nil,_8017,_8042),
    verb_phrase1(_7764,_7743,id,_7767,event/real/_7767::_7761,_8032,_8042,_7798).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,_7838,_7862,_7891,_7920,_7949,!,_7983,_8007,_8041,_8080,!,_8134],_7824,_7826) --> 
    athe0(_7838,_7824,_7853),
    flnp(_7745,_7862,_7853,_7879),
    not_look_ahead(w(nb(_7751,_7752)),_7891,_7879,_7908),
    not_look_ahead(w(name(_7758,_7759,route)),_7920,_7908,_7937),
    look_ahead(w(name(_7766,_7767,_7768)),_7949,_7937,_7966),
    !,
    accept(_7983,_7966,_7998),
    traceprint(4,iq22,_8007,_7998,_8026),
    realcomp(_7710,_7774,_7708,_8041,_8026,_8062),
    verb_modifiers(go,_7783:vehicle,_7710,_7707::_7783 isa vehicle and adj/nil/_7745/_7783/_7710,_7774,_8080,_8062,_8105),
    !,
    accept(_8134,_8105,_7826).

implicitq(_7702,[implicitq,{},_7862,_7891,_7920,_7949,_7978,_8007,{},_8046,!,_8085,_8109,_8143],_7838,_7840) --> 
    {user:(\+value(dialog,1))},
    not_look_ahead(w(noun(clock,_7761,_7762,_7763)),_7862,_7838,_7879),
    not_look_ahead(w(noun(thing,_7770,_7771,_7772)),_7891,_7879,_7908),
    not_look_ahead(w(noun(answer,_7779,_7780,_7781)),_7920,_7908,_7937),
    not_look_ahead([det],_7949,_7937,_7966),
    not_look_ahead(w(name(_7791,n,_7793)),_7978,_7966,_7995),
    look_ahead(w(noun(_7799,_7800,_7801,n)),_8007,_7995,_8024),
    {user:testmember(_7799,[ticket,price])},
    np1_accept(_7746,_7747,_8046,_8024,_8065),
    !,
    accept(_8085,_8065,_8100),
    traceprint(4,iq23,_8109,_8100,_8128),
    pushstack(first,(whatbe,xnp(_7746,_7747)),nil,_8128,_8212),
    whatq(_7702,_8143,_8212,_7840).

implicitq(_7702,[implicitq,{},_7814,{},_7853,!,_7887,_7911,_7945],_7790,_7792) --> 
    {user:(\+value(dialog,1))},
    w(noun(_7733,_7748,_7749,_7750),_7814,_7790,_7831),
    {user:testmember(_7733,[clock,date])},
    not_look_ahead(w(nb(_7765,_7766)),_7853,_7831,_7870),
    !,
    accept(_7887,_7870,_7902),
    traceprint(4,iq24,_7911,_7902,_7930),
    pushstack(first,(whatbe,w(noun(_7733,_7734,_7735,_7736))),nil,_7930,_7983),
    whatq(_7702,_7945,_7983,_7792).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,{},{},{},_7913,{},_7952,{},{},_8001,_8040,_8069,_8103,!,_8166,_8190],_7869,_7871) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    w(name(_7772,n,_7774),_7913,_7869,_7930),
    {user:subclass0(_7774,place)},
    w(name(_7783,n,_7785),_7952,_7930,_7969),
    {user:subclass0(_7785,place)},
    {user:setvartype(_7794,vehicle)},
    realcomp(_7710,_7798,_7708,_8001,_7969,_8022),
    not_look_ahead(w(nb(_7805,_7806)),_8040,_8022,_8057),
    traceprint(4,iq25,_8069,_8057,_8088),
    pushstack(first,(w(prep(from)),w(name(_7772,n,_7774)),w(prep(to)),w(name(_7783,n,_7785))),nil,_8088,_8116),verb_modifiers(go,_7794,_7710,_7707::true,_7798,_8103,_8116,_8137),
    !,
    accept(_8166,_8137,_8181),
    qtrailer0(_8190,_8181,_7871).

implicitq(modifier(_7710):::_7707 and _7708,[implicitq,{},{},{},_7869,_7893,_7917,{},_7956,_7995,_8019,_8048,_8072,_8096,_8130,!,_8184,_8208],_7825,_7827) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    no_harmful_adj(_7869,_7825,_7884),
    no_harmful_noun(_7893,_7884,_7908),
    not_look_ahead([du],_7917,_7908,_7934),
    {user:setvartype(_7782,vehicle)},
    realcomp(_7710,_7786,_7708,_7956,_7934,_7977),
    deter0(_7995,_7977,_8010),
    not_look_ahead(w(nb(_7793,_7794)),_8019,_8010,_8036),
    no_harmful_adj(_8048,_8036,_8063),
    redundants0(_8072,_8063,_8087),
    traceprint(4,iq26,_8096,_8087,_8115),
    verb_modifiers(go,_7782,_7710,_7707::true,_7786,_8130,_8115,_8155),
    !,
    accept(_8184,_8155,_8199),
    qtrailer0(_8208,_8199,_7827).

reject_implicitq([reject_implicitq,lit(hvilke)],_7719,_7721) --> 
    cc(hvilke,_7719,_7721).

reject_implicitq([reject_implicitq,_7763,_7792,_7821,_7850,_7879],_7752,_7754) --> 
    look_ahead(w(nb(1000,num)),_7763,_7752,_7780),
    not_look_ahead([en],_7792,_7780,_7809),
    not_look_ahead([et],_7821,_7809,_7838),
    not_look_ahead([to],_7850,_7838,_7867),
    not_look_ahead([tre],_7879,_7867,_7754).

reject_implicitq([reject_implicitq,lit(at)],_7719,_7721) --> 
    cc(at,_7719,_7721).

reject_implicitq([reject_implicitq,_7735],_7724,_7726) --> 
    w(noun(error,_7705,_7706,_7707),_7735,_7724,_7726).

reject_implicitq([reject_implicitq,_7753,_7782,_7811],_7742,_7744) --> 
    not_look_ahead(w(adj2(fast,_7718)),_7753,_7742,_7770),
    not_look_ahead(w(adj2(best,_7725)),_7782,_7770,_7799),
    w(adj2(good,nil),_7811,_7799,_7744).

reject_implicitq([reject_implicitq,lit(kan)],_7719,_7721) --> 
    cc(kan,_7719,_7721).

reject_implicitq([reject_implicitq,_7749,_7778,{}],_7738,_7740) --> 
    not_look_ahead([e],_7749,_7738,_7766),
    w(verb(_7710,_7720,_7721),_7778,_7766,_7740),
    {user:_7710\==reach}.

reject_implicitq([reject_implicitq,_7744,_7773],_7733,_7735) --> 
    w(noun(_7713,_7714,_7715,_7716),_7744,_7733,_7761),
    w(verb(_7707,_7708,_7709),_7773,_7761,_7735).

reject_implicitq([reject_implicitq,_7766,_7795,_7824,_7853,_7882,_7911],_7755,_7757) --> 
    not_look_ahead([de],_7766,_7755,_7783),
    not_look_ahead([den],_7795,_7783,_7812),
    not_look_ahead([det],_7824,_7812,_7841),
    not_look_ahead([alle],_7853,_7841,_7870),
    not_look_ahead([en],_7882,_7870,_7899),
    quant_pron(_7717,_7718,_7911,_7899,_7757).

reject_implicitq([reject_implicitq,_7740,_7769],_7729,_7731) --> 
    w(noun(_7709,_7710,_7711,_7712),_7740,_7729,_7757),
    posspron(_7705,_7769,_7757,_7731).

reject_implicitq([reject_implicitq,_7747,{}],_7736,_7738) --> 
    w(noun(_7707,_7717,_7718,_7719),_7747,_7736,_7738),
    {user:testmember(_7707,[possibility,necessity])}.

reject_implicitq([reject_implicitq,_7728],_7717,_7719) --> 
    what(_7728,_7717,_7719).

reject_implicitq([reject_implicitq,lit(der)],_7719,_7721) --> 
    cc(der,_7719,_7721).

reject_implicitq([reject_implicitq,lit(hvor)],_7719,_7721) --> 
    cc(hvor,_7719,_7721).

reject_implicitq([reject_implicitq,lit(hvem)],_7719,_7721) --> 
    cc(hvem,_7719,_7721).

reject_implicitq([reject_implicitq,_7753,_7782,lit(når),_7822],_7742,_7744) --> 
    not_look_ahead([nr],_7753,_7742,_7770),
    not_look_ahead([n],_7782,_7770,_7799),
    cc(når,_7799,_7821),
    not_look_ahead(w(prep(from)),_7822,_7821,_7744).

reject_implicitq([reject_implicitq,_7728],_7717,_7719) --> 
    so(_7728,_7717,_7719).

reject_implicitq([reject_implicitq,_7740,_7769],_7729,_7731) --> 
    w(nb(1000,num),_7740,_7729,_7757),
    look_ahead([takk],_7769,_7757,_7731).

reject_implicitq([reject_implicitq,lit(da)],_7719,_7721) --> 
    cc(da,_7719,_7721).

reject_implicitq([reject_implicitq,lit(og)],_7719,_7721) --> 
    cc(og,_7719,_7721).

reject_implicitq([reject_implicitq,lit(men)],_7719,_7721) --> 
    cc(men,_7719,_7721).

reject_implicitq([reject_implicitq,_7737,lit(hvis)],_7726,_7728) --> 
    not_look_ahead([om],_7737,_7726,_7754),
    cc(hvis,_7754,_7728).

reject_implicitq([reject_implicitq,lit(fordi)],_7719,_7721) --> 
    cc(fordi,_7719,_7721).

reject_implicitq([reject_implicitq,lit(ja)],_7719,_7721) --> 
    cc(ja,_7719,_7721).

reject_implicitq([reject_implicitq,lit(nei)],_7719,_7721) --> 
    cc(nei,_7719,_7721).

reject_implicitq([reject_implicitq,{},lit(det)],_7727,_7729) --> 
    {user:value(notimeoutflag,true)},
    cc(det,_7727,_7729).

reject_implicitq([reject_implicitq,lit(det),_7750],_7728,_7730) --> 
    cc(det,_7728,_7749),
    w(verb(be,_7708,_7709),_7750,_7749,_7730).

reject_implicitq([reject_implicitq,_7771,_7800,{}],_7760,_7762) --> 
    w(adj2(good,nil),_7771,_7760,_7788),
    w(noun(_7710,_7741,_7742,_7743),_7800,_7788,_7762),
    {user:testmember(_7710,[morrow,morning,day,night,evening,midnight,afternoon,prenoon,saturday,sunday])}.

reject_implicitq([reject_implicitq,_7745,{}],_7734,_7736) --> 
    w(noun(_7707,_7715,def,_7717),_7745,_7734,_7736),
    {user:testmember(_7707,[midnight])}.

reject_implicitq([reject_implicitq,lit(på),lit(forhånd),lit(takk)],_7729,_7731) --> 
    cc(på,_7729,_7750),
    cc(forhånd,_7750,_7761),
    cc(takk,_7761,_7731).

reject_implicitq([reject_implicitq,_7768,{},_7807,{},!,_7846],_7757,_7759) --> 
    w(noun(_7719,_7720,_7721,_7722),_7768,_7757,_7785),
    {user:(\+testmember(_7719,[nightbus,airplane,airbus]))},
    endofline(_7807,_7785,_7822),
    {user:value(notimeoutflag,true)},
    !,
    reject(_7846,_7822,_7759).

reject_implicitq([reject_implicitq,lit(nå),_7750,!,_7779],_7728,_7730) --> 
    cc(nå,_7728,_7749),
    endofline(_7750,_7749,_7765),
    !,
    reject(_7779,_7765,_7730).

no_harmful_adj([no_harmful_adj,_7755,{},!,_7799],_7744,_7746) --> 
    look_ahead(w(adj2(_7715,nil)),_7755,_7744,_7772),
    {user:testmember(_7715,[nearest,good,next])},
    !,
    reject(_7799,_7772,_7746).

no_harmful_adj([no_harmful_adj,[]],_7717,_7717) --> 
    [].

no_harmful_noun([no_harmful_noun,_7753,_7782,!,_7821],_7742,_7744) --> 
    look_ahead(w(noun(_7715,_7716,_7717,n)),_7753,_7742,_7770),
    gmem(_7715,[airport,bridge],_7782,_7770,_7801),
    !,
    accept(_7821,_7801,_7744).

','({\+testmember(_7709,[airport])},no_harmful_noun,[',',_7772,{},!,_7816],_7755,_7757) --> 
    look_ahead(w(name(_7727,_7728,_7709)),_7772,_7755,_7789),
    {user:subclass0(_7709,place)},
    !,
    accept(_7816,_7789,_7757).

no_harmful_noun([no_harmful_noun,_7757,_7801,{},!],_7746,_7748) --> 
    optional([alle],_7757,_7746,_7789),
    look_ahead(w(noun(_7719,sin,_7721,_7722)),_7801,_7789,_7748),
    {user:testmember(_7719,[station])},
    !.

no_harmful_noun([no_harmful_noun,_7756,{},!],_7745,_7747) --> 
    look_ahead(w(noun(_7712,sin,u,n)),_7756,_7745,_7747),
    {user:testmember(_7712,[arrival,departure,station,student])},
    !.

no_harmful_noun([no_harmful_noun,_7747,{}],_7736,_7738) --> 
    not_look_ahead(w(noun(_7709,_7717,_7718,_7719)),_7747,_7736,_7738),
    {user:(\+testmember(_7709,airport))}.

therightprep(from,[therightprep,_7742,!],_7728,_7730) --> 
    w(prep(from),_7742,_7728,_7730),
    !.

therightprep(_7702,[therightprep,_7742,!],_7728,_7730) --> 
    w(prep(_7702),_7742,_7728,_7730),
    !.

not_adjective_only([not_adjective_only,_7739,!],_7728,_7730) --> 
    look_ahead(w(name(_7709,n,_7711)),_7739,_7728,_7730),
    !.

not_adjective_only([not_adjective_only,_7735],_7724,_7726) --> 
    look_ahead(w(adj2(_7706,_7707)),_7735,_7724,_7726).

not_fnlp([not_fnlp,_7757,{},!,_7801],_7746,_7748) --> 
    look_ahead(w(adj2(_7715,nil)),_7757,_7746,_7774),
    {user:testmember(_7715,[first,next,last,previous])},
    !,
    reject(_7801,_7774,_7748).

not_fnlp([not_fnlp,[]],_7717,_7717) --> 
    [].

constrainvehdep(_7702,[constrainvehdep,{},!,_7761],_7732,_7734) --> 
    {user:vartypeid(_7702,thing)},
    !,
    reject(_7761,_7732,_7734).

constrainvehdep(_7702,[constrainvehdep,{},!,_7761],_7732,_7734) --> 
    {user:constrain(_7702,clock)},
    !,
    reject(_7761,_7732,_7734).

constrainvehdep(_7704:_7705,[constrainvehdep,{},{},!,_7784],_7745,_7747) --> 
    {user:constrain(_7704:_7722,number)},
    {user:plausible_busno(_7704)},
    !,
    accept(_7784,_7745,_7747).

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,summerroute)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,winterroute)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,route)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,route_plan)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,vehicle)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,departure)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,arrival)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,connection)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,tram_route)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,tram_route_plan)},
    !.

constrainvehdep(_7702,[constrainvehdep,{},!],_7729,_7729) --> 
    {user:constrain(_7702,trip)},
    !.

hasq(_7702,[hasq,_7774,_7798,_7827,!,_7861,_7885],_7760,_7762) --> 
    has(_7774,_7760,_7789),
    thereit(_7731,_7798,_7789,_7815),
    w(verb(_7727,past,part),_7827,_7815,_7844),
    !,
    accept(_7861,_7844,_7876),
    pushstack(free,([det],w(verb(_7727,pres,fin))),nil,_7876,_7895),
    statement(_7702,_7885,_7895,_7762).

hasq(_7702,[hasq,_7795,_7824,_7853,_7877,_7911,_7940,_7964,_7988,_8012,!,_8041],_7781,_7783) --> 
    w(verb(have,_7749,fin),_7795,_7781,_7812),
    negation0(_7752,_7824,_7812,_7841),
    so0(_7853,_7841,_7868),
    subject(_7754,_7755,_7877,_7868,_7896),
    negation0(_7757,_7911,_7896,_7928),
    adverbx0(_7940,_7928,_7955),
    hatt0(_7964,_7955,_7979),
    negatino(_7988,_7979,_8003),
    sometimes0(_8012,_8003,_8027),
    !,
    pushstack(first,(xnp(_7754,_7755),w(verb(have,pres,fin))),nil,_8027,_8082),
    statement(_7702,_8041,_8082,_7783).

hasq(_7702,[hasq,_7760,_7789,_7818],_7746,_7748) --> 
    w(verb(have,_7716,fin),_7760,_7746,_7777),
    negation0(_7725,_7789,_7777,_7806),
    lock(last,_7806,_7835),
    pushstack(last,w(verb(have,_7716,fin)),nil,_7835,_7841),
    statement(_7702,_7818,_7841,_7830),
    unlock(_7830,_7748).

isq(_7702,[isq,_7825,_7849,_7878,_7907,_7936,_7960,_7989,lit(å),!,_8039,!,_8087],_7811,_7813) --> 
    be(_7825,_7811,_7840),
    negation0(_7751,_7849,_7840,_7866),
    thereit(_7753,_7878,_7866,_7895),
    negation0(_7755,_7907,_7895,_7924),
    so0(_7936,_7924,_7951),
    w(adj2(_7748,nil),_7960,_7951,_7977),
    gmem(_7748,[true,false,wrong,correct],_7989,_7977,_8008),
    cc(å,_8008,_8033),
    !,
    pushstack(first,[jeg],nil,_8033,_8052),clausal_object1(_7780,_7781,_8039,_8052,_8067),
    !,
    pushstack(first,(xnp(_7780,_7781),w(verb(be,pres,fin)),w(adj2(_7748,nil))),nil,_8067,_8128),
    substatement1(_7702,_8087,_8128,_7813).

isq(_7702,[isq,_7820,_7844,_7873,_7902,_7931,_7955,_7984,lit(at),!,_8034,!,_8073],_7806,_7808) --> 
    be(_7820,_7806,_7835),
    negation0(_7751,_7844,_7835,_7861),
    thereit(_7753,_7873,_7861,_7890),
    negation0(_7755,_7902,_7890,_7919),
    so0(_7931,_7919,_7946),
    w(adj2(_7748,nil),_7955,_7946,_7972),
    gmem(_7748,[true,false,wrong,correct],_7984,_7972,_8003),
    cc(at,_8003,_8028),
    !,
    clausal_object1(_7775,_7776,_8034,_8028,_8053),
    !,
    pushstack(first,(xnp(_7775,_7776),w(verb(be,pres,fin)),w(adj2(_7748,nil))),nil,_8053,_8114),
    substatement1(_7702,_8073,_8114,_7808).

isq(_7702,[isq,_7780,_7809,_7838,_7867,!,[],_7915],_7766,_7768) --> 
    w(verb(be,_7727,fin),_7780,_7766,_7797),
    negation0(_7730,_7809,_7797,_7826),
    thereit(_7732,_7838,_7826,_7855),
    w(verb(_7736,past,part),_7867,_7855,_7884),
    !,
    pushstack(free,w(verb(_7736,_7727,fin)),nil,_7884,_7914),[],
    statement(_7702,_7915,_7914,_7768).

isq(_7702,[isq,_7782,_7806,_7835,_7864,_7893,_7917,!,_7951],_7768,_7770) --> 
    be(_7782,_7768,_7797),
    negation0(_7737,_7806,_7797,_7823),
    pronoun(_7739,_7835,_7823,_7852),
    negation0(_7741,_7864,_7852,_7881),
    not_look_ahead_np(_7893,_7881,_7908),
    not_look_ahead([som],_7917,_7908,_7934),
    !,
    pushstack(first,(pronoun(_7739),w(verb(be,pres,fin))),nil,_7934,_7992),
    substatement1(_7702,_7951,_7992,_7770).

isq(_7702,[isq,_7816,lit(det),_7851,_7880,_7904,_7933,_7962,lit(å),!,_8012,_8086],_7802,_7804) --> 
    be(_7816,_7802,_7831),
    cc(det,_7831,_7850),
    negation0(_7750,_7851,_7850,_7868),
    so0(_7880,_7868,_7895),
    w(adj2(_7745,nil),_7904,_7895,_7921),
    w(prep(for),_7933,_7921,_7950),
    object(_7761,_7762,_7962,_7950,_7981),
    cc(å,_7981,_8006),
    !,
    pushstack(first,(xnp(_7761,_7762),[vil]),nil,_8006,_8056),clausal_object1(_7774,_7775,_8012,_8056,_8071),
    pushstack(first,(xnp(_7774,_7775),be,w(adj2(_7745,nil))),nil,_8071,_8155),
    substatement1(_7702,_8086,_8155,_7804).

isq(_7702,[isq,_7791,_7815,_7844,_7873,_7897,_7926,!,_7965],_7777,_7779) --> 
    be(_7791,_7777,_7806),
    thereit(_7741,_7815,_7806,_7832),
    negation0(_7743,_7844,_7832,_7861),
    so0(_7873,_7861,_7888),
    w(adj2(_7747,nil),_7897,_7888,_7914),
    prepnog(_7747,_7739,_7926,_7914,_7945),
    !,
    pushstack(first,(something,be,w(adj2(_7747,nil)),w(prep(_7739))),nil,_7945,_8031),
    substatement1(_7702,_7965,_8031,_7779).

isq(_7702,[isq,_7811,_7835,_7864,_7893,_7922,_7946,{},lit(å),!,_8001],_7797,_7799) --> 
    be(_7811,_7797,_7826),
    negation0(_7745,_7835,_7826,_7852),
    thereit(_7747,_7864,_7852,_7881),
    negation0(_7749,_7893,_7881,_7910),
    so0(_7922,_7910,_7937),
    w(adj2(_7753,nil),_7946,_7937,_7963),
    {user:(\+testmember(_7753,[]))},
    cc(å,_7963,_7995),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7753,nil)),[å]),nil,_7995,_8011),
    substatement1(_7702,_8001,_8011,_7799).

isq(_7702,[isq,_7791,_7815,_7844,_7873,_7902,_7926,!,_7960],_7777,_7779) --> 
    be(_7791,_7777,_7806),
    negation0(_7739,_7815,_7806,_7832),
    thereit(_7741,_7844,_7832,_7861),
    negation0(_7743,_7873,_7861,_7890),
    so0(_7902,_7890,_7917),
    w(adj2(_7736,nil),_7926,_7917,_7943),
    !,
    pushstack(first,([noe],w(verb(be,pres,fin)),w(adj2(_7736,nil))),nil,_7943,_7970),
    substatement1(_7702,_7960,_7970,_7779).

isq(_7702,[isq,_7765,_7789,_7813,!,_7847],_7751,_7753) --> 
    be(_7765,_7751,_7780),
    dette(_7789,_7780,_7804),
    negation0(_7728,_7813,_7804,_7830),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin))),nil,_7830,_7857),
    substatement1(_7702,_7847,_7857,_7753).

isq(_7702,[isq,_7763,_7787,_7811,!,_7840],_7749,_7751) --> 
    be(_7763,_7749,_7778),
    thereit(_7787,_7778,_7802),
    ikkeingen0(_7811,_7802,_7826),
    !,
    pushstack(free,([det],w(verb(be,pres,fin))),nil,_7826,_7850),
    substatement1(_7702,_7840,_7850,_7751).

isq(_7702,[isq,_7774,_7798,_7827,_7861,!,_7895],_7760,_7762) --> 
    be(_7774,_7760,_7789),
    negation0(_7731,_7798,_7789,_7815),
    subject(_7733,_7734,_7827,_7815,_7846),
    negation0(_7736,_7861,_7846,_7878),
    !,
    pushstack(first,(xnp(_7733,_7734),w(verb(be,pres,fin))),nil,_7878,_7936),
    substatement1(_7702,_7895,_7936,_7762).

isq(_7702,[isq,_7760,_7784,_7808,!,_7842],_7746,_7748) --> 
    be(_7760,_7746,_7775),
    det0(_7784,_7775,_7799),
    negation0(_7725,_7808,_7799,_7825),
    !,
    pushstack(free,w(verb(be,pres,fin)),nil,_7825,_7852),
    substatement1(_7702,_7842,_7852,_7748).

ikkeingen0([ikkeingen0,lit(ingen),!],_7722,_7724) --> 
    cc(ingen,_7722,_7724),
    !.

ikkeingen0([ikkeingen0,_7730],_7719,_7721) --> 
    negation0(_7702,_7730,_7719,_7721).

ynqs(_7702,[ynqs,_7749,_7778,!,_7817],_7735,_7737) --> 
    isynq(_7713,_7749,_7735,_7766),
    orwill(_7713,_7702,_7778,_7766,_7797),
    !,
    accept(_7817,_7797,_7737).

isynq(_7702,[isynq,_7737],_7723,_7725) --> 
    isq(_7702,_7737,_7723,_7725).

isynq(_7702,[isynq,_7737],_7723,_7725) --> 
    ynq(_7702,_7737,_7723,_7725).

orwill(_7702,_7702,[orwill,lit(eller),_7763,!,_7792],_7735,_7737) --> 
    cc(eller,_7735,_7762),
    endofline(_7763,_7762,_7778),
    !,
    accept(_7792,_7778,_7737).

orwill(_7702,_7702 or _7706,[orwill,lit(eller),_7784,!,_7818,_7842,_7871],_7756,_7758) --> 
    cc(eller,_7756,_7783),
    not_look_ahead(w(nb(_7732,_7733)),_7784,_7783,_7801),
    !,
    accept(_7818,_7801,_7833),
    isynq(_7723,_7842,_7833,_7859),
    orwill(_7723,_7706,_7871,_7859,_7758).

orwill(_7702,_7702,[orwill,[]],_7724,_7724) --> 
    [].

ynq(_7702,[ynq,_7797,{},lit(det),_7847,_7876,!,_7910],_7783,_7785) --> 
    w(verb(_7730,_7731,fin),_7797,_7783,_7814),
    {user:(\+testmember(_7730,[be,have]))},
    cc(det,_7814,_7846),
    negation0(_7753,_7847,_7846,_7864),
    look_ahead(w(adj2(_7759,_7760)),_7876,_7864,_7893),
    !,
    pushstack(free,([dette],w(verb(_7730,_7731,fin))),nil,_7893,_7920),
    statreal(_7702,_7910,_7920,_7785).

ynq(_7702,[ynq,_7812,{},lit(det),_7862,lit(å),_7907,!,_7955],_7798,_7800) --> 
    w(verb(_7739,_7740,fin),_7812,_7798,_7829),
    {user:testmember(_7739,[cost])},
    cc(det,_7829,_7861),
    np0_accept(_7734,_7735,_7862,_7861,_7881),
    cc(å,_7881,_7906),
    pushstack(first,([noen],[vil]),nil,_7906,_7920),clausal_object1(_7765,_7766,_7907,_7920,_7935),
    !,
    pushstack(first,(xnp(_7765,_7766),w(verb(_7739,pres,fin)),xnp(_7734,_7735)),nil,_7935,_8027),
    statreal1(_7702,_7955,_8027,_7800).

ynq(_7702,[ynq,_7789,lit(det),_7824,_7853,_7882,_7916,_7940,!,_8014],_7775,_7777) --> 
    aux1(_7789,_7775,_7804),
    cc(det,_7804,_7823),
    negation0(_7730,_7824,_7823,_7841),
    w(verb(happen,inf,fin),_7853,_7841,_7870),
    subject(_7738,_7739,_7882,_7870,_7901),
    not_look_ahead_vp(_7916,_7901,_7931),
    pushstack(first,(xnp(_7738,_7739),w(verb(happen,pres,fin))),nil,_7931,_7984),statreal1(_7702,_7940,_7984,_7997),
    !,
    accept(_8014,_7997,_7777).

ynq(_7702,[ynq,lit(kan),_7793,_7822,_7856,_7885,_7909,!,_7983],_7768,_7770) --> 
    cc(kan,_7768,_7792),
    negation0(_7727,_7793,_7792,_7810),
    subject(_7729,_7730,_7822,_7810,_7841),
    negation0(_7732,_7856,_7841,_7873),
    not_look_ahead_vp(_7885,_7873,_7900),
    pushstack(first,(xnp(_7729,_7730),w(verb(know1,pres,fin))),nil,_7900,_7953),statreal1(_7702,_7909,_7953,_7966),
    !,
    accept(_7983,_7966,_7770).

ynq(_7702,[ynq,lit(_7727),{},_7807,_7836,_7870,!,_7904],_7772,_7774) --> 
    cc(_7727,_7772,_7796),
    {user:testmember(_7727,[får,kan,kunne])},
    negation0(_7743,_7807,_7796,_7824),
    subject(_7745,_7746,_7836,_7824,_7855),
    negation0(_7748,_7870,_7855,_7887),
    !,
    pushstack(first,(xnp(_7745,_7746),[_7727]),nil,_7887,_7945),
    statreal1(_7702,_7904,_7945,_7774).

ynq(_7702,[ynq,_7799,_7823,_7857,_7886,{},_7925,!,_7959],_7785,_7787) --> 
    aux1(_7799,_7785,_7814),
    subject(_7737,_7738,_7823,_7814,_7842),
    w(verb(_7733,inf,fin),_7857,_7842,_7874),
    not_look_ahead(w(verb(_7750,_7751,_7752)),_7886,_7874,_7903),
    {user:(\+verbtype(_7733,rv))},
    negation0(_7761,_7925,_7903,_7942),
    !,
    pushstack(first,(xnp(_7737,_7738),w(verb(_7733,pres,fin))),nil,_7942,_8000),
    statreal1(_7702,_7959,_8000,_7787).

ynq(_7702,[ynq,lit(så),!,_7759],_7729,_7731) --> 
    cc(så,_7729,_7753),
    !,
    reject(_7759,_7753,_7731).

ynq(_7702,[ynq,_7796,_7820,_7849,lit(av),!,_7899,_7923,_7947,_7976],_7782,_7784) --> 
    aux1(_7796,_7782,_7811),
    not_look_ahead(w(verb(go,_7744,_7745)),_7820,_7811,_7837),
    subject(_7747,_7748,_7849,_7837,_7868),
    cc(av,_7868,_7893),
    !,
    accept(_7899,_7893,_7914),
    adverbx0(_7923,_7914,_7938),
    negation0(_7752,_7947,_7938,_7964),
    pushstack(first,(xnp(_7747,_7748),w(verb(go,pres,fin)),[av]),nil,_7964,_8017),
    statreal1(_7702,_7976,_8017,_7784).

ynq(_7702,[ynq,_7811,_7835,_7864,_7898,_7922,{},!,_7966,_7990,_8014,_8043],_7797,_7799) --> 
    aux1(_7811,_7797,_7826),
    not_look_ahead(w(verb(go,_7752,_7753)),_7835,_7826,_7852),
    subject(_7755,_7756,_7864,_7852,_7883),
    redundant0(_7898,_7883,_7913),
    w(prep(_7745),_7922,_7913,_7939),
    {user:_7745\==av},
    !,
    accept(_7966,_7939,_7981),
    adverbx0(_7990,_7981,_8005),
    negation0(_7767,_8014,_8005,_8031),
    pushstack(first,(xnp(_7755,_7756),w(verb(go,pres,fin)),w(prep(_7745))),nil,_8031,_8084),
    statreal1(_7702,_8043,_8084,_7799).

ynq(_7702,[ynq,_7826,_7860,_7889,_7918,_7947,_7976,_8010,_8049,!,_8083,_8107,_8131,[],_8206,!,_8308],_7812,_7814) --> 
    aux1(_7749,_7750,_7826,_7812,_7845),
    negation0(_7752,_7860,_7845,_7877),
    not_look_ahead([man],_7889,_7877,_7906),
    not_look_ahead([jeg],_7918,_7906,_7935),
    not_look_ahead([du],_7947,_7935,_7964),
    subject(_7766,_7767,_7976,_7964,_7995),
    preadverbial0(_7769,_7770,_7771,_8010,_7995,_8031),
    negation0(_7773,_8049,_8031,_8066),
    !,
    accept(_8083,_8066,_8098),
    adverbx0(_8107,_8098,_8122),
    negation0(_7775,_8131,_8122,_8148),
    pushstack(free,adverbial1(_7769,_7770,_7771),nil,_8148,_8205),[],
    pushstack(first,(noun_phrase1(_7766,_7767),aux1),nil,_8205,_8278),statreal1(_7702,_8206,_8278,_8291),
    !,
    accept(_8308,_8291,_7814).

ynq(_7702,[ynq,_7779,_7803,_7827,{},!,_7871],_7765,_7767) --> 
    do(_7779,_7765,_7794),
    you(_7803,_7794,_7818),
    w(verb(_7724,_7731,fin),_7827,_7818,_7844),
    {user:testmember(_7724,[list,show])},
    !,
    pushstack(first,w(verb(_7724,imp,fin)),nil,_7844,_7881),
    command(doit:::_7702,_7871,_7881,_7767).

ynq(_7702,[ynq,_7745,_7769,_7798],_7731,_7733) --> 
    do(_7745,_7731,_7760),
    negation0(_7712,_7769,_7760,_7786),
    statreal1(_7702,_7798,_7786,_7733).

ynq(_7702,[ynq,_7746,_7770,!,_7804],_7732,_7734) --> 
    aux1(_7746,_7732,_7761),
    prep(_7713,_7770,_7761,_7787),
    !,
    reject(_7804,_7787,_7734).

ynq(_7702,[ynq,_7814,_7843,lit(det),_7888,lit(å),!,_7938,_7981],_7800,_7802) --> 
    w(verb(_7739,_7740,fin),_7814,_7800,_7831),
    gmem(_7739,[cost,take,be],_7843,_7831,_7862),
    cc(det,_7862,_7887),
    np0_accept(_7734,_7735,_7888,_7887,_7907),
    cc(å,_7907,_7932),
    !,
    pushstack(first,([noen],[vil]),nil,_7932,_7951),clausal_object1(_7767,_7768,_7938,_7951,_7966),
    pushstack(first,(xnp(_7767,_7768),w(verb(_7739,pres,fin)),xnp(_7734,_7735)),nil,_7966,_8053),
    statreal1(_7702,_7981,_8053,_7802).

ynq(_7702,[ynq,_7775,{},_7814,!,_7848],_7761,_7763) --> 
    w(verb(_7721,_7722,fin),_7775,_7761,_7792),
    {user:testmember(_7721,[know,find])},
    negation0(_7740,_7814,_7792,_7831),
    !,
    pushstack(free,w(verb(_7721,_7722,fin)),nil,_7831,_7858),
    statreal1(_7702,_7848,_7858,_7763).

ynq(_7702,[ynq,_7792,{},{},_7856,_7885,!,_7914],_7778,_7780) --> 
    lexv(tv,_7727,_7728,fin,_7792,_7778,_7815),
    {user:_7728\==imp},
    {user:(\+testmember(_7727,[have,think]))},
    not_look_ahead(w(adj2(_7756,_7757)),_7856,_7815,_7873),
    anyadverb0(_7885,_7873,_7900),
    !,
    pushstack(free,w(verb(_7727,_7728,fin)),nil,_7900,_7924),
    statreal1(_7702,_7914,_7924,_7780).

ynq(_7702,[ynq,_7775,_7819,lit(til),lit(å),!,_7880],_7761,_7763) --> 
    lexv(iv,come,_7729,fin,_7775,_7761,_7798),
    subject(_7732,_7733,_7819,_7798,_7838),
    cc(til,_7838,_7863),
    cc(å,_7863,_7874),
    !,
    pushstack(first,(xnp(_7732,_7733),[vil]),nil,_7874,_7921),
    statreal(_7702,_7880,_7921,_7763).

ynq(_7702,[ynq,_7784,_7828,_7862,lit(hva),!,_7907],_7770,_7772) --> 
    lexv(rv,know,_7732,fin,_7784,_7770,_7807),
    subject(_7735,_7736,_7828,_7807,_7847),
    negation0(_7738,_7862,_7847,_7879),
    cc(hva,_7879,_7901),
    !,
    pushstack(first,(xnp(_7735,_7736),w(verb(know,_7732,fin)),[hva]),nil,_7901,_7948),
    statreal(_7702,_7907,_7948,_7772).

ynq(_7702,[ynq,_7777,_7821,_7855,!,_7884],_7763,_7765) --> 
    lexv(rv,_7728,_7729,fin,_7777,_7763,_7800),
    subject(_7732,_7733,_7821,_7800,_7840),
    infinitive(_7855,_7840,_7870),
    !,
    pushstack(first,(xnp(_7732,_7733),w(verb(_7728,_7729,fin)),[å]),nil,_7870,_7925),
    statreal(_7702,_7884,_7925,_7765).

ynq(_7702,[ynq,_7830,{},_7869,_7898,_7927,_7966,_8000,_8029,_8058,!,_8092],_7816,_7818) --> 
    w(verb(_7749,_7750,fin),_7830,_7816,_7847),
    {user:(\+testmember(_7749,[be,have]))},
    not_look_ahead([det],_7869,_7847,_7886),
    not_look_ahead(w(adj2(_7772,_7773)),_7898,_7886,_7915),
    adverb0(_7745,_7776,_7777,_7927,_7915,_7948),
    subject(_7779,_7780,_7966,_7948,_7985),
    reflexiv0(_7749,_8000,_7985,_8017),
    negation0(_7784,_8029,_8017,_8046),
    rep_particlev0(_7749,_8058,_8046,_8075),
    !,
    pushstack(free,(xnp(_7779,_7780),w(verb(_7749,_7750,fin)),w(adv(_7745))),nil,_8075,_8133),
    statreal(_7702,_8092,_8133,_7818).

ynq(_7702,[ynq,_7787,_7816,_7850,!,_7879,_7903,_7927,_7956,!,_8030],_7773,_7775) --> 
    w(verb(reach,pres,fin),_7787,_7773,_7804),
    np1_accept(_7737,_7740::_7741,_7816,_7804,_7835),
    infinitive(_7850,_7835,_7865),
    !,
    accept(_7879,_7865,_7894),
    adverbx0(_7903,_7894,_7918),
    negation0(_7743,_7927,_7918,_7944),
    pushstack(first,noun_phrase1(_7737,_7740::_7741),nil,_7944,_8000),statreal1(_7702,_7956,_8000,_8013),
    !,
    accept(_8030,_8013,_7775).

ynq(_7702,[ynq,_7752,_7781,!,_7810],_7738,_7740) --> 
    not_look_ahead(w(verb(go,_7718,fin)),_7752,_7738,_7769),
    be(_7781,_7769,_7796),
    !,
    reject(_7810,_7796,_7740).

ynq(_7702,[ynq,_7770,!,_7804,_7828],_7756,_7758) --> 
    w(verb(_7721,pres,pass),_7770,_7756,_7787),
    !,
    thereit0(_7804,_7787,_7819),
    pushstack(free,(w(verb(be,pres,fin)),w(verb(_7721,past,part))),nil,_7819,_7838),
    isq(_7702,_7828,_7838,_7758).

ynq(_7702,[ynq,_7761,_7790,_7819,!,_7853],_7747,_7749) --> 
    w(verb(want,pres,fin),_7761,_7747,_7778),
    not_look_ahead([du],_7790,_7778,_7807),
    not_look_ahead([jeg],_7819,_7807,_7836),
    !,
    reject(_7853,_7836,_7749).

ynq(_7702,[ynq,_7763,_7792,_7816,_7845,!,_7874],_7749,_7751) --> 
    w(verb(go,_7725,fin),_7763,_7749,_7780),
    thereit(_7792,_7780,_7807),
    negation0(_7728,_7816,_7807,_7833),
    anaa(_7845,_7833,_7860),
    !,
    pushstack(first,someone,nil,_7860,_7912),
    statement(_7702,_7874,_7912,_7751).

ynq(_7702,[ynq,_7779,lit(det),{},!,_7849],_7765,_7767) --> 
    lexv(iv,_7724,_7725,fin,_7779,_7765,_7802),
    cc(det,_7802,_7833),
    {user:testmember(_7724,[rain,snow])},
    !,
    pushstack(first,([det],w(verb(_7724,_7725,fin))),nil,_7833,_7859),
    statement(_7702,_7849,_7859,_7767).

ynq(_7702,[ynq,_7789,lit(det),_7829,_7858,!,_7892],_7775,_7777) --> 
    w(verb(_7727,_7728,fin),_7789,_7775,_7806),
    cc(det,_7806,_7828),
    look_ahead(w(prep(_7743)),_7829,_7828,_7846),
    not_look_ahead([e],_7858,_7846,_7875),
    !,
    pushstack(first,(w(noun(vehicle,plu,u,n)),w(verb(_7727,_7728,fin))),nil,_7875,_7902),
    statement(_7702,_7892,_7902,_7777).

ynq(_7702,[ynq,_7783,{},_7822,_7851,!,_7885],_7769,_7771) --> 
    w(verb(_7727,_7728,fin),_7783,_7769,_7800),
    {user:(\+rv_templ(_7727,_7742))},
    negation0(_7744,_7822,_7800,_7839),
    thereit(_7746,_7851,_7839,_7868),
    !,
    pushstack(first,([det],w(verb(_7727,_7728,fin))),nil,_7868,_7895),
    statement(_7702,_7885,_7895,_7771).

ynq(_7702,[ynq,_7790,_7819,_7848,_7877,{},_7911,!,_7945],_7776,_7778) --> 
    w(verb(_7730,_7731,fin),_7790,_7776,_7807),
    not_look_ahead(w(verb,_7743,_7744),_7819,_7807,_7836),
    not_look_ahead([det],_7848,_7836,_7865),
    saa0(_7877,_7865,_7892),
    {user:_7730\==have},
    negation0(_7755,_7911,_7892,_7928),
    !,
    pushstack(free,w(verb(_7730,_7731,fin)),nil,_7928,_7955),
    statreal(_7702,_7945,_7955,_7778).

ynq(_7702,[ynq,{},_7779,_7808,!,_7837],_7755,_7757) --> 
    {user:value(smsflag,true)},
    w(verb(have,pres,fin),_7779,_7755,_7796),
    look_ahead_bus(_7808,_7796,_7823),
    !,
    pushstack(free,w(verb(go,pres,fin)),nil,_7823,_7847),
    statreal(_7702,_7837,_7847,_7757).

ynq(_7702,[ynq,_7787,_7816,{},_7870,{},_7904,!,_7933],_7773,_7775) --> 
    not_look_ahead([vil],_7787,_7773,_7804),
    lexv(iv,_7729,_7730,fin,_7816,_7804,_7839),
    {user:(\+rv_templ(_7729,_7747))},
    saa0(_7870,_7839,_7885),
    {user:_7730\==imp},
    anyadverb0(_7904,_7885,_7919),
    !,
    lock(last,_7919,_7983),
    pushstack(last,lexv(iv,_7729,_7730,fin),nil,_7983,_7989),
    statreal1(_7702,_7933,_7989,_7978),
    unlock(_7978,_7775).

look_ahead_bus([look_ahead_bus,_7751,{}],_7740,_7742) --> 
    look_ahead(w(noun(_7707,_7721,_7722,n)),_7751,_7740,_7742),
    {user:testmember(_7707,[bus,nightbus,number])}.

look_ahead_bus([look_ahead_bus,_7735],_7724,_7726) --> 
    look_ahead(w(adj2(next,nil)),_7735,_7724,_7726).

ppq(_7704:::_7705,[ppq,_7837,_7866,_7905,!,_7939,!,_7978,_8002,_8127],_7823,_7825) --> 
    prep(_7750,_7837,_7823,_7854),
    whx_phrase(_7752,_7704,_7756::_7757,_7866,_7854,_7887),
    w(verb(_7761,pres,pass),_7905,_7887,_7922),
    !,
    noun_phrase1(_7765,_7768::_7769,_7939,_7922,_7958),
    !,
    accept(_7978,_7958,_7993),
    lock(exact,_7993,_8086),pushstack(exact,(prep(_7750),noun_phrase1(_7752,_7756::_7757)),nil,_8086,_8092),adverbial1(_7743,_7744,_7747::_7748,_8002,_8092,_8081),unlock(_8081,_8082),
    pushstack(first,(someone,w(verb(_7761,pres,fin)),noun_phrase1(_7765,_7768::_7769),adverbial1(_7743,_7744,_7747::_7748)),nil,_8082,_8234),
    statreal(_7705,_8127,_8234,_7825).

ppq(_7704:::_7705,[ppq,_7784,_7813,{},!,_7867,_7911,!,_7945],_7770,_7772) --> 
    prepnof(_7728,_7784,_7770,_7801),
    whx_phrase(_7730,_7704,_7734::_7735,_7813,_7801,_7834),
    {user:adjustprep(_7730,_7728,_7741)},
    !,
    forwq(_7705,_7741,_7730,_7734::_7735,_7867,_7834,_7890),
    optionalprep(_7741,_7911,_7890,_7928),
    !,
    accept(_7945,_7928,_7772).

optionalprep(in,[optionalprep,_7743,!,_7777],_7729,_7731) --> 
    prep1(_7710,_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

optionalprep(_7702,[optionalprep,[]],_7721,_7721) --> 
    [].

forwq(_7702,_7703,_7704,_7707::_7708,[forwq,_7791,!,_7840,_7864],_7768,_7770) --> 
    lexv(_7732,be1,_7734,fin,_7791,_7768,_7814),
    !,
    thereit0(_7840,_7814,_7855),
    pushstack(free,(w(verb(be1,pres,fin)),adverbial1(_7703,_7704,_7707::_7708)),nil,_7855,_7909),
    statreal(_7702,_7864,_7909,_7770).

forwq(_7702,_7703,_7704,_7707::_7708,[forwq,_7774,!,_7803],_7751,_7753) --> 
    do(_7774,_7751,_7789),
    !,
    pushstack(free,adverbial1(_7703,_7704,_7707::_7708),nil,_7789,_7848),
    statreal(_7702,_7803,_7848,_7753).

forwq(_7702,_7703,_7704,_7707::_7708,[forwq,_7797,{},_7836,_7860],_7774,_7776) --> 
    w(verb(_7734,_7735,_7736),_7797,_7774,_7814),
    {user:_7734\==understand},
    thereit0(_7836,_7814,_7851),
    pushstack(free,(w(verb(_7734,_7735,_7736)),adverbial1(_7703,_7704,_7707::_7708)),nil,_7851,_7905),
    statreal(_7702,_7860,_7905,_7776).

whichq(_7704:::_7707 and _7708,[whichq,_7816,_7855,_7884,_7908,_7932,!,_7966,_7990],_7802,_7804) --> 
    whx_phrase(_7746,_7704,true::_7707,_7816,_7802,_7837),
    w(verb(recommend,_7758,pass),_7855,_7837,_7872),
    det0(_7884,_7872,_7899),
    infinitive(_7908,_7899,_7923),
    w(verb(_7763,inf,_7765),_7932,_7923,_7949),
    !,
    accept(_7966,_7949,_7981),
    pushstack(first,([noen],w(verb(recommend,_7758,fin)),[å],w(verb(_7763,inf,_7783)),npgap(_7746)),nil,_7981,_8031),
    statreal(_7708,_7990,_8031,_7804).

whichq(_7704:::_7707 and _7708,[whichq,_7794,_7833,_7857,_7886,!,_7925],_7780,_7782) --> 
    whx_phrase(_7734,_7704,true::_7707,_7794,_7780,_7815),
    paux0(_7833,_7815,_7848),
    w(verb(_7745,_7746,pass),_7857,_7848,_7874),
    whodidit(_7749,_7750,_7886,_7874,_7905),
    !,
    pushstack(first,(xnp(_7749,_7750),w(verb(_7745,_7746,fin)),npgap(_7734)),nil,_7905,_7996),
    statreal(_7708,_7925,_7996,_7782).

whichq(_7704:::_7705,[whichq,_7769,_7808,_7847,{}],_7755,_7757) --> 
    whx_phrase(_7722,_7704,_7720::_7705,_7769,_7755,_7790),
    realcomp(_7729,_7730,_7719,_7808,_7790,_7829),
    qverb_phrase(_7722,_7718,_7729,_7730,_7847,_7829,_7757),
    {user:negate(_7718,_7719,_7720)}.

whx_phrase(_7702,_7703,_7706::_7707,[whx_phrase,{},_7828,_7862,{},!,_7906,!,_7967],_7798,_7800) --> 
    {user:value(busflag,true)},
    whichf(_7702,_7703,_7828,_7798,_7847),
    look_ahead(w(verb(_7742,_7743,fin)),_7862,_7847,_7879),
    {user:testmember(_7742,[go,pass,leave,depart,arrive])},
    !,
    lock(exact,_7879,_7926),pushstack(exact,w(noun(vehicle,plu,u,n)),nil,_7926,_7932),noun_phrase1(_7702,_7706::_7707,_7906,_7932,_7921),unlock(_7921,_7922),
    !,
    accept(_7967,_7922,_7800).

whx_phrase(_7702,_7703,_7706::_7707,[whx_phrase,_7796,_7830,_7854,_7883,!,_7912],_7776,_7778) --> 
    whichf(_7702,_7703,_7796,_7776,_7815),
    oter(_7830,_7815,_7845),
    w(noun(_7737,_7738,u,n),_7854,_7845,_7871),
    enn(_7883,_7871,_7898),
    !,
    pushstack(first,(w(noun(_7737,_7738,u,n)),[ulik]),nil,_7898,_7922),
    noun_phrase1(_7702,_7706::_7707,_7912,_7922,_7778).

whx_phrase(_7702,which(_7702),_7706::_7707,[whx_phrase,_7803,_7827,_7856,{},!,_7900],_7783,_7785) --> 
    hvordan(_7803,_7783,_7818),
    not_look_ahead(w(verb(_7740,pres,fin)),_7827,_7818,_7844),
    w(noun(_7731,_7747,_7748,_7749),_7856,_7844,_7873),
    {user:_7731\==type},
    !,
    pushstack(first,w(noun(_7731,sin,u,n)),nil,_7873,_7910),
    noun_phrase1(_7702,_7706::_7707,_7900,_7910,_7785).

whx_phrase(_7702,which(_7702),_7706::_7707,[whx_phrase,lit(hva),_7808,_7837,{},!,_7881],_7777,_7779) --> 
    cc(hva,_7777,_7807),
    not_look_ahead(w(verb(_7738,_7739,_7740)),_7808,_7807,_7825),
    look_ahead(w(noun(_7746,_7747,_7748,_7749)),_7837,_7825,_7854),
    {user:_7746\==type},
    !,
    noun_phrase1(_7702,_7706::_7707,_7881,_7854,_7779).

whx_phrase(_7702,_7703,_7706::_7707,[whx_phrase,_7771,_7805,_7829,!,_7868],_7751,_7753) --> 
    whichf(_7702,_7703,_7771,_7751,_7790),
    type0(_7805,_7790,_7820),
    noun_phrase1(_7702,_7706::_7707,_7829,_7820,_7848),
    !,
    accept(_7868,_7848,_7753).

whx_phrase(_7702,_7703,_7706::_7707,[whx_phrase,_7787,_7821,!,_7855,!,_7903],_7767,_7769) --> 
    whichf(_7702,_7703,_7787,_7767,_7806),
    w(nb(_7729,num),_7821,_7806,_7838),
    !,
    pushstack(first,w(nb(_7729,num)),nil,_7838,_7868),noun_phrase1(_7702,_7706::_7707,_7855,_7868,_7883),
    !,
    accept(_7903,_7883,_7769).

whichf(_7702,which(_7702),[whichf,_7743],_7726,_7728) --> 
    which2(_7743,_7726,_7728).

whichg00(_7702,_7703,_7713:_7702,which(_7713):::_7713 isa _7702 and _7703,[whichg00,[]],_7744,_7744) --> 
    [].

qstatement(_7702,_7705:::_7706,[qstatement,{},_7764],_7737,_7739) --> 
    {user:which_thing(_7702,_7705)},
    statreal(_7706,_7764,_7737,_7739).

what_phrase(_7706:thing,which(_7706:thing),_7706 isa thing,[what_phrase,lit(hva)],_7740,_7742) --> 
    cc(hva,_7740,_7742).

whatq(_7702,[whatq,lit(hva),_7822,_7851,_7885,_7919,_7948,!,_7977,_8001],_7797,_7799) --> 
    cc(hva,_7797,_7821),
    w(verb(use,_7750,fin),_7822,_7821,_7839),
    subject(_7753,_7754,_7851,_7839,_7870),
    np1_accept(_7756,_7757,_7885,_7870,_7904),
    prep1(_7759,_7919,_7904,_7936),
    not_look_ahead_np(_7948,_7936,_7963),
    !,
    accept(_7977,_7963,_7992),
    pushstack(first,(xnp(_7753,_7754),w(verb(use,_7750,fin)),np(_7756,_7757),w(prep(_7759)),npgap(_7743)),nil,_7992,_8103),
    qstatement(_7743,_7702,_8001,_8103,_7799).

whatq(which(_7708):::_7707 ako _7708,[whatq,{},_7782,_7806,_7830,_7859,!],_7758,_7760) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_7782,_7758,_7797),
    art1(_7806,_7797,_7821),
    w(noun(_7707,_7737,u,n),_7830,_7821,_7847),
    endofline(_7859,_7847,_7760),
    !.

whatq(which(_7708):::_7707 ako _7708,[whatq,{},_7796,_7820,{},_7859],_7772,_7774) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_7796,_7772,_7811),
    w(noun(_7707,_7734,u,n),_7820,_7811,_7837),
    {user:(\+testmember(_7707,[clock,special_ticket,price,bus,station]))},
    endofline(_7859,_7837,_7774).

whatq(_7702,[whatq,{},_7786,_7810,_7839,!,_7868],_7762,_7764) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_7786,_7762,_7801),
    look_ahead(w(name(_7739,_7740,_7741)),_7810,_7801,_7827),
    redundant0(_7839,_7827,_7854),
    !,
    pushstack(first,w(verb(describe,imp,fin)),nil,_7854,_7878),
    command(_7702,_7868,_7878,_7764).

whatq(which(_7709:thing):::_7705,[whatq,lit(hva),_7818,_7862,_7896,_7930,_7964],_7793,_7795) --> 
    cc(hva,_7793,_7817),
    lexv(tv,_7744,_7745,fin,_7818,_7817,_7841),
    gmem(_7744,[hold,keep,drive,operate],_7862,_7841,_7881),
    subject(_7759,_7760,_7896,_7881,_7915),
    particlev2(_7744,_7763,_7930,_7915,_7949),
    pushstack(first,(xnp(_7759,_7760),w(verb(_7763,pres,fin)),npgap(_7709:thing)),nil,_7949,_8036),
    statreal(_7705,_7964,_8036,_7795).

whatq(_7704:::_7705,[whatq,{},lit(hva),_7855,_7879,_7913,_7942,lit(kunne),_7997,!,_8031],_7820,_7822) --> 
    {user:which_thing(_7752,_7704)},
    cc(hva,_7820,_7854),
    has(_7855,_7854,_7870),
    subject(_7761,_7762,_7879,_7870,_7898),
    w(verb(expect,past,part),_7913,_7898,_7930),
    optional([at],_7942,_7930,_7974),
    cc(kunne,_7974,_7996),
    w(verb(_7778,_7779,pass),_7997,_7996,_8014),
    !,
    pushstack(first,(xnp(_7761,_7762),w(verb(expect,past,fin)),[at],[noen],w(verb(_7778,pres,fin)),npgap(_7752)),nil,_8014,_8102),
    statreal(_7705,_8031,_8102,_7822).

whatq(_7704:::_7707 and _7708,[whatq,_7791,_7830,_7854,_7883,!,_7922],_7777,_7779) --> 
    what_phrase(_7734,_7704,_7707,_7791,_7777,_7812),
    paux0(_7830,_7812,_7845),
    w(verb(_7742,_7743,pass),_7854,_7845,_7871),
    whodidit(_7746,_7747,_7883,_7871,_7902),
    !,
    pushstack(first,(xnp(_7746,_7747),w(verb(_7742,_7743,fin)),npgap(_7734)),nil,_7902,_7993),
    statreal(_7708,_7922,_7993,_7779).

whatq(_7704:::_7707 and _7708,[whatq,_7828,_7867,{},_7921,_7955,_7989,!,_8028,[],_8101],_7814,_7816) --> 
    what_phrase(_7752,_7704,_7707,_7828,_7814,_7849),
    lexv(rv,_7757,_7758,fin,_7867,_7849,_7890),
    {user:(\+testmember(_7757,[]))},
    subject(_7768,_7769,_7921,_7890,_7940),
    that0(_7757,that,_7955,_7940,_7974),
    subject(_7749,_7750,_7989,_7974,_8008),
    !,
    negation0(_7777,_8028,_8008,_8045),
    pushstack(free,npgap(_7752),nil,_8045,_8100),[],
    pushstack(first,(xnp(_7768,_7769),w(verb(_7757,pres,fin)),[at],xnp(_7749,_7750)),nil,_8100,_8173),
    statreal(_7708,_8101,_8173,_7816).

whatq(_7704:::_7707 and _7708,[whatq,_7791,_7830,lit(det),_7870,_7914,!,_7953],_7777,_7779) --> 
    what_phrase(_7734,_7704,_7707,_7791,_7777,_7812),
    w(verb(be,_7743,fin),_7830,_7812,_7847),
    cc(det,_7847,_7869),
    optional([som],_7870,_7869,_7902),
    specific_phrase(_7752,_7753,_7914,_7902,_7933),
    !,
    pushstack(free,(xnp(_7752,_7753),npgap(_7734)),nil,_7933,_8024),
    statreal(_7708,_7953,_8024,_7779).

whatq(which(_7709:thing):::_7705,[whatq,lit(hva),_7818,_7862,_7886,_7920,_7949,_7978],_7793,_7795) --> 
    cc(hva,_7793,_7817),
    lexv(rv,_7750,_7751,fin,_7818,_7817,_7841),
    look_ahead_subject(_7862,_7841,_7877),
    np0_accept(_7754,_7755,_7886,_7877,_7905),
    negation0(_7757,_7920,_7905,_7937),
    prepnom(_7759,_7949,_7937,_7966),
    pushstack(first,(xnp(_7754,_7755),w(verb(_7750,pres,fin)),w(prep(_7759)),npgap(_7709:thing)),nil,_7966,_8052),
    statreal(_7705,_7978,_8052,_7795).

whatq(_7704:::_7707 and _7708,[whatq,_7819,_7858,{},_7912,_7946,_7975,_8004,_8033],_7805,_7807) --> 
    what_phrase(_7740,_7704,_7707,_7819,_7805,_7840),
    lexv(tv,do,_7748,fin,_7858,_7840,_7881),
    {user:(\+testmember(do,[cost,be2,have]))},
    subject(_7764,_7765,_7912,_7881,_7931),
    not_look_ahead([at],_7946,_7931,_7963),
    not_look_ahead([å],_7975,_7963,_7992),
    negation0(_7775,_8004,_7992,_8021),
    pushstack(first,(xnp(_7764,_7765),w(verb(do,pres,fin)),npgap(_7740)),nil,_8021,_8104),
    statreal(_7708,_8033,_8104,_7807).

whatq(_7704:::_7705,[whatq,{},lit(hva),_7815,_7839,_7873,!,_7907],_7780,_7782) --> 
    {user:which_thing(_7734,_7704)},
    cc(hva,_7780,_7814),
    has(_7815,_7814,_7830),
    subject(_7743,_7744,_7839,_7830,_7858),
    w(verb(_7748,past,part),_7873,_7858,_7890),
    !,
    pushstack(first,(xnp(_7743,_7744),w(verb(_7748,past,fin)),npgap(_7734)),nil,_7890,_7978),
    statreal(_7705,_7907,_7978,_7782).

whatq(_7704:::_7705,[whatq,{},lit(hva),_7850,_7874,_7908,_7962,!,_7996,_8113],_7815,_7817) --> 
    {user:which_thing(_7745,_7704)},
    cc(hva,_7815,_7849),
    has(_7850,_7849,_7865),
    subject(_7750,_7751,_7874,_7865,_7893),
    noun(_7753,_7754,_7755,_7756,_7740,_7758,_7908,_7893,_7935),
    prepnom(_7760,_7962,_7935,_7979),
    !,
    lock(exact,_7979,_8077),pushstack(exact,(noun(_7753,_7754,_7755,_7756,_7740,_7758),w(prep(_7760)),npgap(_7745)),nil,_8077,_8083),np1(_7740,_7741,_7996,_8083,_8072),unlock(_8072,_8073),
    pushstack(first,(xnp(_7750,_7751),w(verb(have,pres,fin)),xnp(_7740,_7741)),nil,_8073,_8185),
    statreal(_7705,_8113,_8185,_7817).

whatq(which(_7709:thing):::_7705,[whatq,lit(hva),_7835,{},lit(det),_7885,lit(å),_7920,!,_7968],_7810,_7812) --> 
    cc(hva,_7810,_7834),
    w(verb(_7754,_7755,fin),_7835,_7834,_7852),
    {user:testmember(_7754,[cost])},
    cc(det,_7852,_7884),
    for0(_7885,_7884,_7900),
    cc(å,_7900,_7919),
    pushstack(first,([noen],[vil]),nil,_7919,_7933),clausal_object1(_7777,_7778,_7920,_7933,_7948),
    !,
    pushstack(first,(xnp(_7777,_7778),w(verb(_7754,pres,fin)),npgap(_7709:thing)),nil,_7948,_8042),
    statreal1(_7705,_7968,_8042,_7812).

for0([for0,lit(for),!],_7722,_7724) --> 
    cc(for,_7722,_7724),
    !.

for0([for0,[]],_7717,_7717) --> 
    [].

whatq(_7704:::_7705,[whatq,lit(hva),_7846,{},lit(det),_7896,!,_7930,{},_7964,_8020],_7821,_7823) --> 
    cc(hva,_7821,_7845),
    w(verb(_7749,_7750,fin),_7846,_7845,_7863),
    {user:testmember(_7749,[cost,weigh])},
    cc(det,_7863,_7895),
    look_ahead(w(prep(_7768)),_7896,_7895,_7913),
    !,
    accept(_7930,_7913,_7945),
    {user:which_thing(_7743,_7704)},
    lock(exact,_7945,_7984),pushstack(exact,w(noun(ticket,sin,u,n)),nil,_7984,_7990),noun_phrase1(_7785,_7788::_7789,_7964,_7990,_7979),unlock(_7979,_7980),
    pushstack(first,(noun_phrase1(_7785,_7788::_7789),lexv(tv,_7749,_7750,fin),npgap(_7743)),nil,_7980,_8125),
    statreal(_7705,_8020,_8125,_7823).

whatq(_7704:::_7707 and _7708,[whatq,_7807,_7846,_7875,_7909,{},!,_7958],_7793,_7795) --> 
    what_phrase(_7737,_7704,_7707,_7807,_7793,_7828),
    w(verb(_7745,_7746,fin),_7846,_7828,_7863),
    gmem(_7745,[cost,weigh],_7875,_7863,_7894),
    np1_accept(_7756,_7757,_7909,_7894,_7928),
    {user:(\+constrain(_7756,place))},
    !,
    pushstack(first,(xnp(_7756,_7757),lexv(tv,_7745,_7746,fin),npgap(_7737)),nil,_7928,_8062),
    statreal(_7708,_7958,_8062,_7795).

whatq(_7704:::_7707 and _7708,[whatq,_7760,_7799,_7838],_7746,_7748) --> 
    what_phrase(_7716,_7704,_7707,_7760,_7746,_7781),
    realcomp(_7718,_7719,_7708,_7799,_7781,_7820),
    qverb_phrase(_7716,id,_7718,_7719,_7838,_7820,_7748).

whatq(which(_7709:thing):::_7705,[whatq,_7791,lit(det),_7826,_7855,_7889,!,_7923],_7777,_7779) --> 
    whatbe(_7791,_7777,_7806),
    cc(det,_7806,_7825),
    not_look_ahead(w(adj2(_7747,nil)),_7826,_7825,_7843),
    subject(_7750,_7751,_7855,_7843,_7874),
    negation0(_7753,_7889,_7874,_7906),
    !,
    pushstack(free,(xnp(_7750,_7751),npgap(_7709:thing)),nil,_7906,_7997),
    statement(_7705,_7923,_7997,_7779).

whatq(_7702,[whatq,_7813,_7837,_7861,_7885,_7914,{},!,_7958],_7799,_7801) --> 
    whatbe(_7813,_7799,_7828),
    so0(_7837,_7828,_7852),
    dent0(_7861,_7852,_7876),
    not_look_ahead(w(nb(_7746,_7747)),_7885,_7876,_7902),
    w(adj2(_7739,nil),_7914,_7902,_7931),
    {user:(\+testmember(_7739,[near,nearest,next]))},
    !,
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin)),w(adj2(_7739,nil))),nil,_7931,_7999),
    whichq(_7702,_7958,_7999,_7801).

whatq(which(_7707):::_7705,[whatq,_7763,_7787,_7811,!,_7845,_7879],_7749,_7751) --> 
    whatbe(_7763,_7749,_7778),
    thereit(_7787,_7778,_7802),
    prep1(for,_7811,_7802,_7828),
    !,
    noun_phrase1(_7707,true::_7705,_7845,_7828,_7864),
    danow0(_7879,_7864,_7751).

whatq(which(_7707):::_7705,[whatq,_7807,lit(det),lit(som),!,_7858,_7882,_7916,_7972],_7793,_7795) --> 
    whatbe(_7807,_7793,_7822),
    cc(det,_7822,_7841),
    cc(som,_7841,_7852),
    !,
    accept(_7858,_7852,_7873),
    np(_7746,_7749::_7750,_7882,_7873,_7901),
    lock(exact,_7901,_7936),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7936,_7942),np(_7707,_7739::_7740,_7916,_7942,_7931),unlock(_7931,_7932),
    pushstack(free,(np(_7746,_7749::_7750),np(_7707,_7739::_7740)),nil,_7932,_8050),
    statreal(_7705,_7972,_8050,_7795).

whatq(which(_7707):::_7705,[whatq,_7787,_7811,_7840,_7869,_7912,!,_7941],_7773,_7775) --> 
    whatbe(_7787,_7773,_7802),
    w(noun(time,_7730,_7731,n),_7811,_7802,_7828),
    look_ahead(w(prep(_7738)),_7840,_7828,_7857),
    pushstack(first,w(noun(departure,sin,u,n)),nil,_7857,_7882),noun_phrase1(_7707,true::_7705,_7869,_7882,_7897),
    danow0(_7912,_7897,_7927),
    !,
    accept(_7941,_7927,_7775).

whatq(_7704:::_7705,[whatq,{},_7807,lit(det),_7842,_7871,_7905,!,_7939],_7783,_7785) --> 
    {user:which_thing(_7734,_7704)},
    whatbe(_7807,_7783,_7822),
    cc(det,_7822,_7841),
    not_look_ahead(w(adj2(_7747,nil)),_7842,_7841,_7859),
    noun_phrase1(_7750,_7753::_7754,_7871,_7859,_7890),
    negation0(_7756,_7905,_7890,_7922),
    !,
    pushstack(free,(np(_7750,_7753::_7754),npgap(_7734)),nil,_7922,_8013),
    statement(_7705,_7939,_8013,_7785).

whatq(which(_7709:thing):::_7705,[whatq,_7804,_7828,_7857,_7886,_7920,_7944,!,_7973],_7790,_7792) --> 
    whatbe(_7804,_7790,_7819),
    not_look_ahead([det],_7828,_7819,_7845),
    not_look_ahead(w(name(_7755,n,_7757)),_7857,_7845,_7874),
    np(_7759,_7760,_7886,_7874,_7905),
    danow0(_7920,_7905,_7935),
    endofline(_7944,_7935,_7959),
    !,
    lock(exact,_7959,_8054),
    pushstack(exact,(xnp(_7759,_7760),w(verb(be,pres,fin)),npgap(_7709:thing)),nil,_8054,_8060),
    statreal(_7705,_7973,_8060,_8049),
    unlock(_8049,_7792).

whatq(which(_7707):::_7705,[whatq,_7770,_7794,_7823,_7852,_7886],_7756,_7758) --> 
    whatbe(_7770,_7756,_7785),
    not_look_ahead([det],_7794,_7785,_7811),
    not_look_ahead(w(name(_7729,n,_7731)),_7823,_7811,_7840),
    np1_accept(_7707,true::_7705,_7852,_7840,_7871),
    danow0(_7886,_7871,_7758).

whatq(which(_7709:thing):::_7705,[whatq,_7810,_7834,_7868,_7897,!,_7931],_7796,_7798) --> 
    whatbe(_7810,_7796,_7825),
    noun_phrase1(_7747,_7748,_7834,_7825,_7853),
    w(verb(_7752,past,part),_7868,_7853,_7885),
    prep(_7756,_7897,_7885,_7914),
    !,
    pushstack(first,(noun_phrase1(_7747,_7748),w(verb(be,pres,fin)),w(verb(_7752,past,part)),w(prep(_7756)),npgap(_7709:thing)),nil,_7914,_8005),
    statement(_7705,_7931,_8005,_7798).

whatq(_7702,[whatq,_7762,_7786],_7748,_7750) --> 
    whatbe(_7762,_7748,_7777),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin))),nil,_7777,_7824),
    whichq(_7702,_7786,_7824,_7750).

whatq(_7702,[whatq,lit(hva),_7821,_7845,_7879,_7908,!,_7942,_7966],_7796,_7798) --> 
    cc(hva,_7796,_7820),
    aux1(_7821,_7820,_7836),
    np1_accept(_7744,_7747::_7748,_7845,_7836,_7864),
    w(verb(use,_7753,pass),_7879,_7864,_7896),
    prep1(_7756,_7908,_7896,_7925),
    !,
    accept(_7942,_7925,_7957),
    pushstack(first,([noen],w(verb(use,_7753,fin)),np(_7744,_7747::_7748),w(prep(_7756)),npgap(_7740)),nil,_7957,_8040),
    qstatement(_7740,_7702,_7966,_8040,_7798).

whatq(_7702,[whatq,lit(hva),_7818,_7847,_7881,!,_7915,_7939],_7793,_7795) --> 
    cc(hva,_7793,_7817),
    w(verb(use,_7744,pass),_7818,_7817,_7835),
    np1_accept(_7747,_7750::_7751,_7847,_7835,_7866),
    prep1(_7753,_7881,_7866,_7898),
    !,
    accept(_7915,_7898,_7930),
    pushstack(first,([noen],w(verb(use,_7744,fin)),np(_7747,_7750::_7751),w(prep(_7753)),npgap(_7737)),nil,_7930,_8013),
    qstatement(_7737,_7702,_7939,_8013,_7795).

whatq(which(_7709:thing):::_7705,[whatq,_7826,_7850,_7884,_7908,_7937,_7966,_7995,{},!,_8039],_7812,_7814) --> 
    whatcan(_7826,_7812,_7841),
    subject(_7756,_7757,_7850,_7841,_7869),
    redundant0(_7884,_7869,_7899),
    negation0(_7759,_7908,_7899,_7925),
    w(verb(_7763,_7764,_7765),_7937,_7925,_7954),
    reflexiv0(_7763,_7966,_7954,_7983),
    prepnom(_7769,_7995,_7983,_8012),
    {user:testmember(_7769,[regarding,with])},
    !,
    pushstack(first,(xnp(_7756,_7757),w(verb(_7763,_7764,_7765)),w(prep(_7769)),npgap(_7709:thing)),nil,_8012,_8113),
    statreal(_7705,_8039,_8113,_7814).

whatq(_7704:::_7705,[whatq,_7795,{},_7829,_7863,lit(om),!,_7908],_7781,_7783) --> 
    whatcan(_7795,_7781,_7810),
    {user:which_thing(_7741,_7704)},
    specific_phrase(_7744,_7745,_7829,_7810,_7848),
    negation0(_7747,_7863,_7848,_7880),
    cc(om,_7880,_7902),
    !,
    pushstack(first,(noun_phrase1(_7744,_7745),w(verb(know1,pres,fin)),npgap(_7741),[om]),nil,_7902,_7979),
    statreal(_7705,_7908,_7979,_7783).

whatq(_7704:::_7705,[whatq,_7836,{},_7870,_7904,_7933,_7962,lit(_7768),{},_8012,!,_8046],_7822,_7824) --> 
    whatcan(_7836,_7822,_7851),
    {user:which_thing(_7746,_7704)},
    specific_phrase(_7753,_7756::_7757,_7870,_7851,_7889),
    negation0(_7759,_7904,_7889,_7921),
    w(verb(_7763,_7764,_7765),_7933,_7921,_7950),
    reflexiv0(_7763,_7962,_7950,_7979),
    cc(_7768,_7979,_8001),
    {user:testmember(_7768,[på,om,til])},
    not_look_ahead(w(noun(_7786,_7787,_7788,_7789)),_8012,_8001,_8029),
    !,
    pushstack(first,(noun_phrase1(_7753,_7756::_7757),w(verb(_7763,_7764,_7765)),npgap(_7746)),nil,_8029,_8120),
    statreal(_7705,_8046,_8120,_7824).

whatq(_7704:::_7705,[whatq,_7829,{},_7863,_7897,_7926,_7955,lit(om),_7995,!,_8034],_7815,_7817) --> 
    whatcan(_7829,_7815,_7844),
    {user:which_thing(_7754,_7704)},
    specific_phrase(_7757,_7760::_7761,_7863,_7844,_7882),
    negation0(_7763,_7897,_7882,_7914),
    w(verb(_7767,_7768,_7769),_7926,_7914,_7943),
    reflexiv0(_7767,_7955,_7943,_7972),
    cc(om,_7972,_7994),
    noun_phrase1(_7749,_7750,_7995,_7994,_8014),
    !,
    pushstack(first,(noun_phrase1(_7757,_7760::_7761),w(verb(_7767,_7768,_7769)),npgap(_7754),w(prep(regarding)),np(_7749,_7750)),nil,_8014,_8139),
    statreal(_7705,_8034,_8139,_7817).

whatq(_7704:::_7705,[whatq,_7829,{},_7863,_7897,_7926,_7970,_8004,!,_8038],_7815,_7817) --> 
    whatcan(_7829,_7815,_7844),
    {user:which_thing(_7746,_7704)},
    specific_phrase(_7753,_7756::_7757,_7863,_7844,_7882),
    negation0(_7759,_7897,_7882,_7914),
    lexv(tv,_7762,_7763,_7764,_7926,_7914,_7949),
    np1(_7766,_7769::_7770,_7970,_7949,_7989),
    prepnom(_7772,_8004,_7989,_8021),
    !,
    pushstack(first,(noun_phrase1(_7753,_7756::_7757),w(verb(_7762,_7763,_7764)),np1(_7766,_7769::_7770),w(prep(_7772)),npgap(_7746)),nil,_8021,_8143),
    statreal(_7705,_8038,_8143,_7817).

whatq(_7704:::_7705,[whatq,_7830,_7854,_7888,_7917,_7946,_7980,!,{},_8024],_7816,_7818) --> 
    whatcan(_7830,_7816,_7845),
    specific_phrase(_7752,_7755::_7756,_7854,_7845,_7873),
    negation0(_7758,_7888,_7873,_7905),
    w(verb(_7762,_7763,_7764),_7917,_7905,_7934),
    noun_phrase1(_7746,_7749::_7750,_7946,_7934,_7965),
    prepnom(_7772,_7980,_7965,_7997),
    !,
    {user:which_thing(_7776,_7704)},
    pushstack(first,(noun_phrase1(_7752,_7755::_7756),w(verb(_7762,_7763,_7764)),npgap(_7776),w(prep(_7772)),np(_7746,_7749::_7750)),nil,_7997,_8132),
    statreal(_7705,_8024,_8132,_7818).

whatq(_7704:::_7705,[whatq,_7802,{},_7836,_7870,_7899,!,_7933],_7788,_7790) --> 
    whatcan(_7802,_7788,_7817),
    {user:which_thing(_7734,_7704)},
    specific_phrase(_7741,_7744::_7745,_7836,_7817,_7855),
    negation0(_7747,_7870,_7855,_7887),
    not_look_ahead(w(verb(_7753,_7754,_7755)),_7899,_7887,_7916),
    !,
    pushstack(first,(noun_phrase1(_7741,_7744::_7745),w(verb(do1,pres,fin)),npgap(_7734)),nil,_7916,_8007),
    statreal(_7705,_7933,_8007,_7790).

whatq(_7704:::_7705,[whatq,_7805,{},_7839,_7873,_7902,_7931,!,_7965],_7791,_7793) --> 
    whatcan(_7805,_7791,_7820),
    {user:which_thing(_7737,_7704)},
    specific_phrase(_7744,_7747::_7748,_7839,_7820,_7858),
    negation0(_7750,_7873,_7858,_7890),
    w(verb(_7754,_7755,_7756),_7902,_7890,_7919),
    reflexiv0(_7754,_7931,_7919,_7948),
    !,
    pushstack(first,(noun_phrase1(_7744,_7747::_7748),w(verb(_7754,_7755,_7756)),npgap(_7737)),nil,_7948,_8039),
    statreal(_7705,_7965,_8039,_7793).

whatq(_7704:::_7705,[whatq,lit(hva),{},_7817,_7846,!,_7885],_7782,_7784) --> 
    cc(hva,_7782,_7806),
    {user:which_thing(_7731,_7704)},
    w(verb(know,_7743,fin),_7817,_7806,_7834),
    specific_phrase(_7746,_7749::_7750,_7846,_7834,_7865),
    !,
    pushstack(first,(noun_phrase1(_7746,_7749::_7750),lexv(tv,know1,_7743,fin),npgap(_7731)),nil,_7865,_7990),
    statreal(_7705,_7885,_7990,_7784).

whatq(_7702,[whatq,lit(hva),_7772,_7796],_7747,_7749) --> 
    cc(hva,_7747,_7771),
    do(_7772,_7771,_7787),
    pushstack(first,(which,w(noun(thing,sin,u,n)),do),nil,_7787,_7865),
    whichq(_7702,_7796,_7865,_7749).

whatq(_7702,[whatq,lit(hva),_7794,!,_7843,_7867,_7896],_7769,_7771) --> 
    cc(hva,_7769,_7793),
    lexv(iv,_7730,_7738,fin,_7794,_7793,_7817),
    !,
    accept(_7843,_7817,_7858),
    negation0(_7741,_7867,_7858,_7884),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(_7730,pres,fin))),nil,_7884,_7934),
    whichq(_7702,_7896,_7934,_7771).

whenq(which(_7707):::_7705,[whenq,_7776,_7815,lit(det),_7850,!,_7879],_7762,_7764) --> 
    when_adverbialq(_7727,_7707,_7731::_7732,_7776,_7762,_7797),
    be(_7815,_7797,_7830),
    cc(det,_7830,_7849),
    that0(_7850,_7849,_7865),
    !,
    pushstack(free,xadverbial1(_7727,_7707,_7731::_7732),nil,_7865,_7920),
    statreal(_7705,_7879,_7920,_7764).

whenq(which(_7707):::_7705,[whenq,_7780,_7819,!,_7853,_7877],_7766,_7768) --> 
    when_adverbialq(_7724,_7707,_7728::_7729,_7780,_7766,_7801),
    look_ahead(w(noun(bus,_7743,_7744,n)),_7819,_7801,_7836),
    !,
    accept(_7853,_7836,_7868),
    pushstack(free,xadverbial1(_7724,_7707,_7728::_7729),nil,_7868,_7922),
    statreal(_7705,_7877,_7922,_7768).

whenq(which(_7707):::_7705,[whenq,_7814,_7853,_7882,{},!,_7926],_7800,_7802) --> 
    when_adverbialq(_7733,_7707,_7737::_7738,_7814,_7800,_7835),
    w(verb(go,_7750,fin),_7853,_7835,_7870),
    look_ahead(w(prep(_7757)),_7882,_7870,_7899),
    {user:testmember(_7757,[from,to])},
    !,
    pushstack(free,(w(noun(bus,sin,u,n)),w(verb(go,_7750,fin)),xadverbial1(_7733,_7707,_7737::_7738)),nil,_7899,_7971),
    statreal(_7705,_7926,_7971,_7802).

whenq(which(_7707):::_7705,[whenq,_7789,_7828,_7852,_7876,!,_7915,_7939,_7968],_7775,_7777) --> 
    when_adverbialq(_7732,_7707,_7741::_7742,_7789,_7775,_7810),
    be(_7828,_7810,_7843),
    detnexttime(_7852,_7843,_7867),
    np1(_7730,_7747::_7748,_7876,_7867,_7895),
    !,
    accept(_7915,_7895,_7930),
    negation0(_7750,_7939,_7930,_7956),
    whencomplex(_7730,_7747::_7748,_7732,_7707,_7741::_7742,_7705,_7968,_7956,_7777).

whenq(which(_7707):::_7705,[whenq,_7767,_7791,{},!,_7835],_7753,_7755) --> 
    when(_7767,_7753,_7782),
    look_ahead(w(prep(_7725)),_7791,_7782,_7808),
    {user:testmember(_7725,[from,to])},
    !,
    reject(_7835,_7808,_7755).

whenq(which(_7707):::_7705,[whenq,_7832,_7856,_7895,!,_7939,_7963,!,_8047,_8071],_7818,_7820) --> 
    when(_7832,_7818,_7847),
    preadverbial1(_7749,_7750,_7753::_7754,_7856,_7847,_7877),
    preadverbial1(_7742,_7743,_7746::_7747,_7895,_7877,_7916),
    !,
    accept(_7939,_7916,_7954),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_7954,_8007),adverbial1(_7776,_7707,_7780::_7781,_7963,_8007,_8024),
    !,
    accept(_8047,_8024,_8062),
    lock(last,_8062,_8189),
    pushstack(last,(adverbial1(in,_7707,_7780::_7781),adverbial1(_7749,_7750,_7753::_7754),adverbial1(_7742,_7743,_7746::_7747)),nil,_8189,_8195),
    question0(_7705,_8071,_8195,_8184),
    unlock(_8184,_7820).

whenq(which(_7707):::_7705,[whenq,_7819,_7843,_7872,!,_7916,_7940,!,_8023,_8047],_7805,_7807) --> 
    when(_7819,_7805,_7834),
    not_look_ahead([e],_7843,_7834,_7860),
    adverbial1(_7739,_7740,_7743::_7744,_7872,_7860,_7893),
    !,
    accept(_7916,_7893,_7931),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_7931,_7983),adverbial1(_7770,_7707,_7774::_7775,_7940,_7983,_8000),
    !,
    accept(_8023,_8000,_8038),
    lock(last,_8038,_8130),
    pushstack(last,(xadverbial1(in,_7707,_7774::_7775),xadverbial1(_7739,_7740,_7743::_7744)),nil,_8130,_8136),
    question0(_7705,_8047,_8136,_8125),
    unlock(_8125,_7807).

whenq(which(_7707):::_7705,[whenq,_7799,_7823,!,_7867,!,_7963],_7785,_7787) --> 
    when(_7799,_7785,_7814),
    adverb(_7730,_7731,pre,_7823,_7814,_7844),
    !,
    lock(exact,_7844,_7917),pushstack(exact,(prep(in),w(noun(time,sin,u,n))),nil,_7917,_7923),adverbial1(_7750,_7707,_7754::_7755,_7867,_7923,_7912),unlock(_7912,_7913),
    !,
    pushstack(free,(xadverbial1(in,_7707,_7754::_7755),xadverb(_7730,_7731)),nil,_7913,_8039),
    question0(_7705,_7963,_8039,_7787).

whenq(which(_7707):::_7705,[whenq,_7811,_7850,{},_7889,_7913,!,_7947],_7797,_7799) --> 
    howlongto(_7736,_7707,_7740::_7741,_7811,_7797,_7832),
    w(adj2(_7752,nil),_7850,_7832,_7867),
    {user:testmember(_7752,[easy,possible,good])},
    infinitive(_7889,_7867,_7904),
    w(verb(_7768,inf,fin),_7913,_7904,_7930),
    !,
    lock(last,_7930,_8027),
    pushstack(last,(someone,w(verb(_7768,pres,fin)),adverbial1(_7736,_7707,_7740::_7741)),nil,_8027,_8033),
    statement(_7705,_7947,_8033,_8022),
    unlock(_8022,_7799).

whenq(which(_7707):::_7705,[whenq,_7783,_7822,!,_7856],_7769,_7771) --> 
    howlongto(_7724,_7707,_7728::_7729,_7783,_7769,_7804),
    w(verb(_7740,_7741,fin),_7822,_7804,_7839),
    !,
    lock(last,_7839,_7908),
    pushstack(last,(w(verb(_7740,pres,fin)),adverbial1(_7724,_7707,_7728::_7729)),nil,_7908,_7914),
    statement(_7705,_7856,_7914,_7903),
    unlock(_7903,_7771).

whenq(which(_7707):::_7705,[whenq,_7777,!,_7821,_7894,_7923],_7763,_7765) --> 
    when_adverbialq(_7723,_7707,_7727::_7728,_7777,_7763,_7798),
    !,
    pushstack(free,xadverbial1(_7723,_7707,_7727::_7728),nil,_7798,_7869),question0(_7705,_7821,_7869,_7882),
    not_look_ahead([a],_7894,_7882,_7911),
    prep0(_7721,_7923,_7911,_7765).

detnexttime([detnexttime,lit(det),_7750,_7774,!],_7728,_7730) --> 
    cc(det,_7728,_7749),
    nexttime0(_7750,_7749,_7765),
    that0(_7774,_7765,_7730),
    !.

detnexttime([detnexttime,_7734,_7758,!],_7723,_7725) --> 
    nexttime(_7734,_7723,_7749),
    that0(_7758,_7749,_7725),
    !.

detnexttime([detnexttime,lit(at),!],_7722,_7724) --> 
    cc(at,_7722,_7724),
    !.

nexttime0([nexttime0,_7728],_7717,_7719) --> 
    nexttime(_7728,_7717,_7719).

nexttime0([nexttime0,[]],_7717,_7717) --> 
    [].

nexttime([nexttime,_7740,_7769],_7729,_7731) --> 
    w(adj2(next,nil),_7740,_7729,_7757),
    optional([gang],_7769,_7757,_7731).

whencomplex(_7702,_7709::_7710,_7704,_7705,_7712::_7713,_7707,[whencomplex,_7819,_7843,!,_7877,_7901],_7790,_7792) --> 
    do0(_7819,_7790,_7834),
    w(verb(_7745,_7746,finy),_7843,_7834,_7860),
    !,
    accept(_7877,_7860,_7892),
    pushstack(free,(np(_7702,_7709::_7710),w(verb(_7745,pres,fin)),adverbial1(_7704,_7705,_7712::_7713)),nil,_7892,_7980),
    statreal(_7707,_7901,_7980,_7792).

whencomplex(_7702,_7709::_7710,_7704,_7705,_7712::_7713,_7707,[whencomplex,_7801],_7772,_7774) --> 
    pushstack(free,(np(_7702,_7709::_7710),w(verb(be,pres,fin)),adverbial1(_7704,_7705,_7712::_7713)),nil,_7772,_7880),
    statreal(_7707,_7801,_7880,_7774).

verb0(_7702,[verb0,_7747,!,_7781],_7733,_7735) --> 
    w(verb(_7702,_7713,_7714),_7747,_7733,_7764),
    !,
    accept(_7781,_7764,_7735).

verb0(be1,[verb0,[]],_7721,_7721) --> 
    [].

subjectverb(_7702,_7703,_7704,[subjectverb,_7762,_7791,!],_7742,_7744) --> 
    w(verb(_7704,_7715,fin),_7762,_7742,_7779),
    subject(_7702,_7703,_7791,_7779,_7744),
    !.

subjectverb(_7702,_7703,_7704,[subjectverb,_7762,_7786,_7820],_7742,_7744) --> 
    aux1(_7762,_7742,_7777),
    subject(_7702,_7703,_7786,_7777,_7805),
    w(verb(_7704,inf,fin),_7820,_7805,_7744).

whereq(which(_7707):::_7705,[whereq,_7826,_7850,_7889,_7918,_7942,_7971,!,_8010,_8034,!,_8063,[],_8133,!,_8207],_7812,_7814) --> 
    dummyprep0(_7826,_7812,_7841),
    where_adverbial(_7751,_7707,_7753,_7850,_7841,_7871),
    w(verb(_7757,_7758,fin),_7889,_7871,_7906),
    thereit0(_7918,_7906,_7933),
    not_look_ahead(w(nb(_7765,_7766)),_7942,_7933,_7959),
    subject(_7768,_7769,_7971,_7959,_7990),
    !,
    accept(_8010,_7990,_8025),
    dummyprep0(_8034,_8025,_8049),
    !,
    accept(_8063,_8049,_8078),
    pushstack(free,adverbial1(_7751,_7707,_7753),nil,_8078,_8132),[],
    pushstack(first,(xnp(_7768,_7769),w(verb(_7757,_7758,fin))),nil,_8132,_8177),substatement1(_7705,_8133,_8177,_8190),
    !,
    accept(_8207,_8190,_7814).

whereq(which(_7707):::_7705,[whereq,{},_7822,_7846,!,_7880,!,_7946,_8015],_7798,_7800) --> 
    {user:(\+value(dialog,1))},
    where(_7822,_7798,_7837),
    w(verb(go,_7740,fin),_7846,_7837,_7863),
    !,
    lock(exact,_7863,_7900),pushstack(exact,w(noun(place,sin,u,n)),nil,_7900,_7906),adverbial1(nil,_7707,_7757::_7758,_7880,_7906,_7895),unlock(_7895,_7896),
    !,
    pushstack(free,(w(verb(go,pres,fin)),adverbial1(nil,_7707,_7757::_7758)),nil,_7896,_7990),ynq(_7705,_7946,_7990,_8003),
    dummyprep0(_8015,_8003,_7800).

whereq(which(_7707):::_7705,[whereq,_7815,_7839,_7868,!,_7912,!,_8008],_7801,_7803) --> 
    where(_7815,_7801,_7830),
    not_look_ahead(w(prep(after)),_7839,_7830,_7856),
    adverbial1(_7733,_7734,_7737::_7738,_7868,_7856,_7889),
    !,
    lock(exact,_7889,_7962),pushstack(exact,(prep(in),w(noun(place,sin,u,n))),nil,_7962,_7968),adverbial1(_7766,_7707,_7770::_7771,_7912,_7968,_7957),unlock(_7957,_7958),
    !,
    pushstack(free,(adverbial1(in,_7707,_7770::_7771),adverbial1(_7733,_7734,_7737::_7738)),nil,_7958,_8088),
    question0(_7705,_8008,_8088,_7803).

whereq(which(_7707):::_7705,[whereq,_7800,_7839,lit(det),_7874,!,[],_7957],_7786,_7788) --> 
    where_adverbial(_7741,_7707,_7745::_7746,_7800,_7786,_7821),
    be(_7839,_7821,_7854),
    cc(det,_7854,_7873),
    w(adj2(_7738,_7739),_7874,_7873,_7891),
    !,
    pushstack(free,adverbial1(_7741,_7707,_7745::_7746),nil,_7891,_7956),[],
    pushstack(first,([det],be,w(adj2(_7738,_7739))),nil,_7956,_7995),
    substatement1(_7705,_7957,_7995,_7788).

whereq(which(_7707):::_7705,[whereq,_7776,_7815,lit(det),_7850,!,_7879],_7762,_7764) --> 
    where_adverbial(_7727,_7707,_7731::_7732,_7776,_7762,_7797),
    be(_7815,_7797,_7830),
    cc(det,_7830,_7849),
    that0(_7850,_7849,_7865),
    !,
    pushstack(free,adverbial1(_7727,_7707,_7731::_7732),nil,_7865,_7924),
    statreal(_7705,_7879,_7924,_7764).

whereq(_7702,[whereq,_7770,_7794,_7818],_7756,_7758) --> 
    where(_7770,_7756,_7785),
    be(_7794,_7785,_7809),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),w(verb(be1,pres,fin))),nil,_7809,_7886),
    ppq(_7702,_7818,_7886,_7758).

whereq(which(_7707):::_7705,[whereq,_7749,_7773,!,_7802],_7735,_7737) --> 
    where(_7749,_7735,_7764),
    many1(_7773,_7764,_7788),
    !,
    reject(_7802,_7788,_7737).

whereq(_7702,[whereq,_7764,_7788,_7812],_7750,_7752) --> 
    where(_7764,_7750,_7779),
    aux1(_7788,_7779,_7803),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),do),nil,_7803,_7908),
    ppq(_7702,_7812,_7908,_7752).

whereq(_7702,[whereq,_7756,_7780,_7804],_7742,_7744) --> 
    where(_7756,_7742,_7771),
    look_ahead_vp(_7780,_7771,_7795),
    pushstack(first,(which,w(noun(place,sin,u,n))),nil,_7795,_7842),
    whichq(_7702,_7804,_7842,_7744).

when_adverbial(in,_7703,_7706::_7707,[when_adverbial,_7770,_7794,!,{}],_7750,_7752) --> 
    which(_7770,_7750,_7785),
    np1(_7703,_7706::_7707,_7794,_7785,_7752),
    !,
    {user:testconstraint(_7703,time)}.

when_adverbialq(in,_7712:time,_7706::_7712 isa time and _7706,[when_adverbialq,_7759],_7739,_7741) --> 
    when(_7759,_7739,_7741).

when_adverbial(in,_7712:time,_7706::_7712 isa time and _7706,[when_adverbial,_7759],_7739,_7741) --> 
    whenx(_7759,_7739,_7741).

where_adverbial(nil,_7703,_7704,[where_adverbial,_7764,_7788,!,{}],_7744,_7746) --> 
    which(_7764,_7744,_7779),
    np1(_7703,_7704,_7788,_7779,_7746),
    !,
    {user:testconstraint(_7703,place)}.

where_adverbial(nil,_7703,_7704,[where_adverbial,lit(hvor),_7770,!],_7739,_7741) --> 
    cc(hvor,_7739,_7769),
    np00(place,_7703,_7704,_7770,_7769,_7741),
    !.

dummyprep0([dummyprep0,_7731,!],_7720,_7722) --> 
    dummyprep(_7731,_7720,_7722),
    !.

dummyprep0([dummyprep0,[]],_7717,_7717) --> 
    [].

dummyprep([dummyprep,_7736,!,_7770],_7725,_7727) --> 
    prep1(from,_7736,_7725,_7753),
    !,
    accept(_7770,_7753,_7727).

dummyprep([dummyprep,_7736,!,_7770],_7725,_7727) --> 
    prep1(to,_7736,_7725,_7753),
    !,
    accept(_7770,_7753,_7727).

wherefromq(_7702,[wherefromq,_7761,!,_7790],_7747,_7749) --> 
    wherefrom(_7761,_7747,_7776),
    !,
    pushstack(first,(prep(from),which,w(noun(place,sin,u,n))),nil,_7776,_7859),
    ppq(_7702,_7790,_7859,_7749).

whoq(_7702,[whoq,_7786,_7810,_7839,!,_7873],_7772,_7774) --> 
    who(_7786,_7772,_7801),
    look_ahead(w(noun(_7735,sin,def,n)),_7810,_7801,_7827),
    w(verb(_7727,_7728,fin),_7839,_7827,_7856),
    !,
    pushstack(first,(which,w(noun(agent,sin,u,n)),w(verb(_7727,_7728,fin))),nil,_7856,_7911),
    whichq(_7702,_7873,_7911,_7774).

whoq(_7702,[whoq,_7753,_7777],_7739,_7741) --> 
    who(_7753,_7739,_7768),
    pushstack(first,(which,w(noun(agent,sin,u,n))),nil,_7768,_7815),
    whichq(_7702,_7777,_7815,_7741).

whoseq(_7702,[whoseq,_7778,_7802,_7856],_7764,_7766) --> 
    whose(_7778,_7764,_7793),
    noun(_7725,_7726,u,n,_7729,_7730,_7802,_7793,_7829),
    pushstack(first,(who,w(verb(have,pres,fin)),a,noun(_7725,_7726,u,n,_7729,_7730),that),nil,_7829,_7990),
    whoq(_7702,_7856,_7990,_7766).

whyq(explain:::_7705,[whyq,_7743,_7767],_7729,_7731) --> 
    hvorfor(_7743,_7729,_7758),
    isq(_7705,_7767,_7758,_7731).

whyq(explain:::_7705,[whyq,_7743,_7767],_7729,_7731) --> 
    hvorfor(_7743,_7729,_7758),
    ynq(_7705,_7767,_7758,_7731).

whyq(explain:::_7705,[whyq,_7743,_7767],_7729,_7731) --> 
    hvorfor(_7743,_7729,_7758),
    hasq(_7705,_7767,_7758,_7731).

howq(doit:::reply('OK'),[howq,lit(hvordan),_7773,lit(det),!,_7818],_7748,_7750) --> 
    cc(hvordan,_7748,_7772),
    w(verb(go,_7726,fin),_7773,_7772,_7790),
    cc(det,_7790,_7812),
    !,
    skip_rest(_7818,_7812,_7750).

howq(explain:::_7705,[howq,lit(hvordan),_7788,_7812,_7841,!,_7870],_7763,_7765) --> 
    cc(hvordan,_7763,_7787),
    erdetaa0(_7788,_7787,_7803),
    w(verb(_7730,inf,fin),_7812,_7803,_7829),
    mex0(_7841,_7829,_7856),
    !,
    pushstack(first,([jeg],w(verb(_7730,pres,fin))),nil,_7856,_7880),
    statreal1(_7705,_7870,_7880,_7765).

howq(explain:::_7705,[howq,lit(hvorfor),_7782,!,_7816],_7757,_7759) --> 
    cc(hvorfor,_7757,_7781),
    w(verb(_7724,inf,fin),_7782,_7781,_7799),
    !,
    pushstack(first,([jeg],w(verb(_7724,pres,fin))),nil,_7799,_7826),
    statreal1(_7705,_7816,_7826,_7759).

howq(explain:::_7705,[howq,lit(hvordan),_7780,[],_7854],_7755,_7757) --> 
    cc(hvordan,_7755,_7779),
    look_ahead(w(verb(be,_7725,fin)),_7780,_7779,_7797),
    pushstack(free,xadverbial1(how,nil,_7735::_7735),nil,_7797,_7853),[],
    isq(_7705,_7854,_7853,_7757).

howq(explain:::_7705,[howq,_7767,_7791,_7815,_7849],_7753,_7755) --> 
    how(_7767,_7753,_7782),
    be(_7791,_7782,_7806),
    np1_accept(_7728,_7729,_7815,_7806,_7834),
    pushstack(first,(xnp(_7728,_7729),w(verb(be,pres,fin))),nil,_7834,_7890),
    substatement1(_7705,_7849,_7890,_7755).

howq(explain:::_7705,[howq,_7773,_7797,lit(det),_7832,!,_7866],_7759,_7761) --> 
    how(_7773,_7759,_7788),
    be(_7797,_7788,_7812),
    cc(det,_7812,_7831),
    negation0(_7736,_7832,_7831,_7849),
    !,
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_7849,_7876),
    substatement1(_7705,_7866,_7876,_7761).

howq(explain:::_7705,[howq,_7757,_7801,_7825,!,_7854],_7743,_7745) --> 
    lexv(iv,tell,imp,fin,_7757,_7743,_7780),
    me0(_7801,_7780,_7816),
    how(_7825,_7816,_7840),
    !,
    statreal1(_7705,_7854,_7840,_7745).

howq(_7702,[howq,_7752,_7776,_7800,!,_7829],_7738,_7740) --> 
    how(_7752,_7738,_7767),
    be(_7776,_7767,_7791),
    thereit(_7800,_7791,_7815),
    !,
    pushstack(first,whatbe,nil,_7815,_7867),
    whatq(_7702,_7829,_7867,_7740).

howq(_7702,[howq,_7759,_7783,lit(det),_7818,!,_7852],_7745,_7747) --> 
    how(_7759,_7745,_7774),
    be(_7783,_7774,_7798),
    cc(det,_7798,_7817),
    prep1(with,_7818,_7817,_7835),
    !,
    pushstack(first,whatbe,nil,_7835,_7890),
    whatq(_7702,_7852,_7890,_7747).

howq(explain:::_7705,[howq,_7743,_7767],_7729,_7731) --> 
    how(_7743,_7729,_7758),
    ynq(_7705,_7767,_7758,_7731).

howq(explain:::_7705,[howq,_7743,_7767],_7729,_7731) --> 
    how(_7743,_7729,_7758),
    hasq(_7705,_7767,_7758,_7731).

erdetaa0([erdetaa0,_7744,lit(det),lit(å),!,_7795],_7733,_7735) --> 
    be(_7744,_7733,_7759),
    cc(det,_7759,_7778),
    cc(å,_7778,_7789),
    !,
    accept(_7795,_7789,_7735).

erdetaa0([erdetaa0,[]],_7717,_7717) --> 
    [].

howlongto(_7702,_7703,_7706::_7707,[howlongto,_7780,lit(det),lit(lenge),_7826,_7855],_7760,_7762) --> 
    be(_7780,_7760,_7795),
    cc(det,_7795,_7814),
    cc(lenge,_7814,_7825),
    prep1(to,_7826,_7825,_7843),
    lock(exact,_7843,_7872),
    pushstack(exact,[når],nil,_7872,_7878),
    when_adverbial(_7702,_7703,_7706::_7707,_7855,_7878,_7867),
    unlock(_7867,_7762).

howlongto(_7702,_7703,_7706::_7707,[howlongto,lit(hvor),lit(lenge),_7807,lit(det),_7842,_7871],_7765,_7767) --> 
    cc(hvor,_7765,_7795),
    cc(lenge,_7795,_7806),
    be(_7807,_7806,_7822),
    cc(det,_7822,_7841),
    prep1(to,_7842,_7841,_7859),
    lock(exact,_7859,_7888),
    pushstack(exact,[når],nil,_7888,_7894),
    when_adverbial(_7702,_7703,_7706::_7707,_7871,_7894,_7883),
    unlock(_7883,_7767).

howlongto(_7702,_7703,_7706::_7707,[howlongto,_7766,_7805,_7829,_7853],_7746,_7748) --> 
    when_adverbial(_7702,_7703,_7706::_7707,_7766,_7746,_7787),
    be(_7805,_7787,_7820),
    thereit(_7829,_7820,_7844),
    that0(_7853,_7844,_7748).

howadjq(_7702,[howadjq,_7828,_7852,{},_7891,{},lit(det),_7941,_7970,_7994,_8023,!,_8094],_7814,_7816) --> 
    hvor(_7828,_7814,_7843),
    howadj1(_7737,_7852,_7843,_7869),
    {user:testmember(_7737,[duration])},
    w(verb(_7748,_7749,fin),_7891,_7869,_7908),
    {user:testmember(_7748,[take,be])},
    cc(det,_7908,_7940),
    not_look_ahead([å],_7941,_7940,_7958),
    redundant0(_7970,_7958,_7985),
    not_look_ahead(w(prep(with)),_7994,_7985,_8011),
    pushstack(first,(which,w(noun(_7737,sin,u,n)),w(verb(_7748,_7749,fin))),nil,_8011,_8064),whichq(_7702,_8023,_8064,_8077),
    !,
    accept(_8094,_8077,_7816).

howadjq(_7702,[howadjq,_7792,_7816,_7845,{},!,_7884],_7778,_7780) --> 
    hvor(_7792,_7778,_7807),
    howadj1(_7731,_7816,_7807,_7833),
    docan(_7845,_7833,_7860),
    {user:testmember(_7731,[frequency,speed,lateness,earliness,duration,distance])},
    !,
    pushstack(first,(prep(with),which,w(noun(_7731,sin,u,n)),do),nil,_7860,_7981),
    ppq(_7702,_7884,_7981,_7780).

howadjq(_7702,[howadjq,_7808,_7832,{},_7871,{},!,_7915],_7794,_7796) --> 
    hvor(_7808,_7794,_7823),
    howadj1(_7740,_7832,_7823,_7849),
    {user:testmember(_7740,[frequency,earliness,lateness])},
    w(verb(_7736,_7756,_7738),_7871,_7849,_7888),
    {user:(\+_7736=be)},
    !,
    pushstack(first,(prep(with),which,w(noun(_7740,sin,u,n)),w(verb(_7736,pres,_7738))),nil,_7888,_7983),
    ppq(_7702,_7915,_7983,_7796).

howadjq(_7702,[howadjq,_7778,_7802,_7831,_7865,_7889],_7764,_7766) --> 
    hvor(_7778,_7764,_7793),
    howadj1(_7731,_7802,_7793,_7819),
    gmem(_7731,[distance],_7831,_7819,_7850),
    be(_7865,_7850,_7880),
    pushstack(first,(which,w(noun(_7731,sin,u,n)),w(verb(have,pres,fin))),nil,_7880,_7927),
    whichq(_7702,_7889,_7927,_7766).

howadjq(which(_7712:time):::_7712 isa time and _7708,[howadjq,_7819,_7843,_7872,lit(det),lit(til),_7923,!,_7962,_8001],_7805,_7807) --> 
    hvor(_7819,_7805,_7834),
    howadj1(duration,_7843,_7834,_7860),
    w(verb(be,_7760,fin),_7872,_7860,_7889),
    cc(det,_7889,_7911),
    cc(til,_7911,_7922),
    clausal_object0(_7767,_7768,_7923,_7922,_7942),
    !,
    np00(time,_7712:time,_7753,_7962,_7942,_7983),
    pushstack(first,(xnp(_7767,_7768),w(verb(exist,_7760,fin)),xadverbial1(nil,_7712,_7753)),nil,_7983,_8073),
    statreal(_7708,_8001,_8073,_7807).

howadjq(_7702,[howadjq,_7816,_7860,_7884,_7913,_7942,_7976,!,_8010,_8049],_7802,_7804) --> 
    whichg00(duration,_7745,_7741,_7702,_7816,_7802,_7839),
    hvor(_7860,_7839,_7875),
    howadj1(duration,_7884,_7875,_7901),
    w(verb(be,_7754,fin),_7913,_7901,_7930),
    np1_accept(_7757,_7758,_7942,_7930,_7961),
    w(adj2(_7762,nil),_7976,_7961,_7993),
    !,
    np00(duration,_7741,_7742,_8010,_7993,_8031),
    pushstack(first,(xnp(_7757,_7758),w(verb(be,_7754,fin)),w(adj2(_7762,nil)),xadverbial1(nil,_7741,_7742)),nil,_8031,_8122),
    statreal(_7745,_8049,_8122,_7804).

howadjq(_7702,[howadjq,_7809,_7853,_7877,_7906,_7935,_7969,!,_8003,_8042],_7795,_7797) --> 
    whichg00(duration,_7742,_7738,_7702,_7809,_7795,_7832),
    hvor(_7853,_7832,_7868),
    howadj1(duration,_7877,_7868,_7894),
    w(verb(have,_7751,fin),_7906,_7894,_7923),
    subject(_7754,_7755,_7935,_7923,_7954),
    w(verb(_7759,past,part),_7969,_7954,_7986),
    !,
    np00(duration,_7738,_7739,_8003,_7986,_8024),
    pushstack(first,(xnp(_7754,_7755),w(verb(_7759,past,fin)),xadverbial1(nil,_7738,_7739)),nil,_8024,_8115),
    statreal(_7742,_8042,_8115,_7797).

howadjq(which(_7710):::_7710 isa _7713 and _7708,[howadjq,_7826,_7850,_7879,_7908,_7942,!,{},_7991,_8030],_7812,_7814) --> 
    hvor(_7826,_7812,_7841),
    howadj1(_7713,_7850,_7841,_7867),
    w(verb(have,_7760,fin),_7879,_7867,_7896),
    subject(_7763,_7764,_7908,_7896,_7927),
    object(_7766,_7767,_7942,_7927,_7961),
    !,
    {user:_7752=(_7710:_7713)},
    np00(_7713,_7752,_7753,_7991,_7961,_8012),
    pushstack(first,(xnp(_7763,_7764),w(verb(have,_7760,fin)),xnp(_7766,_7767),xadverbial1(nil,_7752,_7753)),nil,_8012,_8134),
    statreal(_7708,_8030,_8134,_7814).

howadjq(which(_7710):::_7710 isa _7713 and _7708,[howadjq,_7834,_7858,_7887,{},_7926,_7955,!,{},_8004,_8043],_7820,_7822) --> 
    hvor(_7834,_7820,_7849),
    howadj1(duration,_7858,_7849,_7875),
    w(verb(_7758,_7759,fin),_7887,_7875,_7904),
    {user:(\+testmember(_7758,[expect,be]))},
    not_look_ahead([det],_7926,_7904,_7943),
    np1(_7777,_7778,_7955,_7943,_7974),
    !,
    {user:_7751=(_7710:duration)},
    np00(_7713,_7751,_7752,_8004,_7974,_8025),
    pushstack(first,(xnp(_7777,_7778),w(verb(_7758,_7759,fin)),xnp(_7751,_7752)),nil,_8025,_8115),
    statreal(_7708,_8043,_8115,_7822).

howadjq(_7702,[howadjq,lit(hvor),lit(lenge),_7819,lit(det),_7859,!,_7893,_7927],_7783,_7785) --> 
    cc(hvor,_7783,_7807),
    cc(lenge,_7807,_7818),
    w(verb(be,pres,fin),_7819,_7818,_7836),
    cc(det,_7836,_7858),
    w(prep(to),_7859,_7858,_7876),
    !,
    clausal_object0(_7734,_7735,_7893,_7876,_7912),
    pushstack(first,([når],w(verb(be,pres,fin)),xnp(_7734,_7735)),nil,_7912,_7968),
    whenq(_7702,_7927,_7968,_7785).

howadjq(_7702,[howadjq,lit(hvor),lit(mange),_7827,_7856,lit(det),_7896,!,_7930],_7791,_7793) --> 
    cc(hvor,_7791,_7815),
    cc(mange,_7815,_7826),
    w(noun(minute,plu,u,n),_7827,_7826,_7844),
    w(verb(be,pres,fin),_7856,_7844,_7873),
    cc(det,_7873,_7895),
    w(prep(to),_7896,_7895,_7913),
    !,
    pushstack(free,([når],w(verb(be,pres,fin)),[det],[at]),nil,_7913,_7940),
    whenq(_7702,_7930,_7940,_7793).

howadjq(_7702,[howadjq,_7801,_7825,lit(blir),_7865,_7899,!,_7933],_7787,_7789) --> 
    hvor(_7801,_7787,_7816),
    howadj1(_7740,_7825,_7816,_7842),
    cc(blir,_7842,_7864),
    np1(_7737,_7738,_7865,_7864,_7884),
    w(verb(_7749,past,part),_7899,_7884,_7916),
    !,
    pushstack(first,(prep(with),which,w(noun(_7740,sin,u,n)),w(verb(_7749,pres,pass)),xnp(_7737,_7738)),nil,_7916,_8032),
    ppq(_7702,_7933,_8032,_7789).

howadjq(_7702,[howadjq,_7827,_7851,{},_7890,_7914,_7948,{},_7987,_8026],_7813,_7815) --> 
    hvor(_7827,_7813,_7842),
    howadj1(_7746,_7851,_7842,_7868),
    {user:testmember(_7746,[frequency])},
    be(_7890,_7868,_7905),
    subject(_7755,_7756,_7914,_7905,_7933),
    w(adj2(_7760,nil),_7948,_7933,_7965),
    {user:testmember(_7760,[delayed,tooearly])},
    np00(frequency,_7743,_7744,_7987,_7965,_8008),
    pushstack(first,(xnp(_7755,_7756),w(verb(be,pres,fin)),w(adj2(_7760,nil)),w(prep(with)),xnp(_7743,_7744)),nil,_8008,_8098),
    statreal1(_7702,_8026,_8098,_7815).

howadjq(_7702,[howadjq,_7786,_7810,{},_7849,_7873],_7772,_7774) --> 
    hvor(_7786,_7772,_7801),
    howadj1(_7731,_7810,_7801,_7827),
    {user:(\+testmember(_7731,[duration,distance,time]))},
    be(_7849,_7827,_7864),
    pushstack(first,(which,w(noun(_7731,sin,u,n)),w(verb(have,pres,fin))),nil,_7864,_7911),
    whichq(_7702,_7873,_7911,_7774).

howadjq(_7702,[howadjq,_7809,_7833,_7862,_7886,_7920,{},_7959,!,_8061],_7795,_7797) --> 
    hvor(_7809,_7795,_7824),
    howadj1(_7728,_7833,_7824,_7850),
    do(_7862,_7850,_7877),
    np(_7730,_7731,_7886,_7877,_7905),
    w(verb(_7735,_7736,_7737),_7920,_7905,_7937),
    {user:testmember(_7735,[use,take])},
    pushstack(first,(which,w(noun(_7728,sin,u,n)),w(verb(_7735,inf,fin)),xnp(_7730,_7731)),nil,_7937,_8031),whichq(_7702,_7959,_8031,_8044),
    !,
    accept(_8061,_8044,_7797).

howadjq(which(_7707):::_7705,[howadjq,_7837,_7861,{},_7900,{},_7939,!,_7978,!,_8083],_7823,_7825) --> 
    hvor(_7837,_7823,_7852),
    howadj1(_7736,_7861,_7852,_7878),
    {user:testmember(_7736,[speed,distance])},
    w(verb(_7749,pres,fin),_7900,_7878,_7917),
    {user:(\+testmember(_7749,[know,be]))},
    np1(_7764,_7765,_7939,_7917,_7958),
    !,
    pushstack(first,(xnp(_7764,_7765),w(verb(_7749,pres,fin)),w(prep(with)),the(_7707),w(noun(_7736,sin,u,n))),nil,_7958,_8053),statreal(_7705,_7978,_8053,_8066),
    !,
    accept(_8083,_8066,_7825).

howadjq(_7702,[howadjq,_7787,lit(lenge),_7822,_7846,!,_7880],_7773,_7775) --> 
    hvor(_7787,_7773,_7802),
    cc(lenge,_7802,_7821),
    be(_7822,_7821,_7837),
    not_look_ahead([det],_7846,_7837,_7863),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),w(verb(be,pres,fin))),nil,_7863,_7918),
    ppq(_7702,_7880,_7918,_7775).

howadjq(_7702,[howadjq,_7823,_7847,{},_7886,{},lit(det),_7936,_7960,!,_7994,_8018,!,_8089],_7809,_7811) --> 
    hvor(_7823,_7809,_7838),
    howadj1(_7740,_7847,_7838,_7864),
    {user:testmember(_7740,[duration])},
    w(verb(_7751,pres,fin),_7886,_7864,_7903),
    {user:testmember(_7751,[take,be])},
    cc(det,_7903,_7935),
    redundant0(_7936,_7935,_7951),
    prep(with,_7960,_7951,_7977),
    !,
    accept(_7994,_7977,_8009),
    pushstack(first,(which,w(noun(_7740,sin,u,n)),w(verb(_7751,pres,fin))),nil,_8009,_8059),whichq(_7702,_8018,_8059,_8072),
    !,
    accept(_8089,_8072,_7811).

howadjq(_7702,[howadjq,_7842,_7866,{},_7905,{},lit(det),_7955,_7984,_8008,!,_8042,_8066,!,_8137],_7828,_7830) --> 
    hvor(_7842,_7828,_7857),
    howadj1(_7743,_7866,_7857,_7883),
    {user:testmember(_7743,[duration])},
    w(verb(_7754,pres,fin),_7905,_7883,_7922),
    {user:testmember(_7754,[take])},
    cc(det,_7922,_7954),
    not_look_ahead([å],_7955,_7954,_7972),
    redundant0(_7984,_7972,_7999),
    look_ahead(w(prep(_7775)),_8008,_7999,_8025),
    !,
    accept(_8042,_8025,_8057),
    pushstack(first,(which,w(noun(_7743,sin,u,n)),w(verb(_7754,pres,fin)),w(noun(vehicle,sin,def,n))),nil,_8057,_8107),whichq(_7702,_8066,_8107,_8120),
    !,
    accept(_8137,_8120,_7830).

howadjq(_7702,[howadjq,_7819,_7843,{},_7882,lit(det),_7922,{},_7961,_7985,!,_8056],_7805,_7807) --> 
    hvor(_7819,_7805,_7834),
    howadj1(_7734,_7843,_7834,_7860),
    {user:testmember(_7734,[duration])},
    w(verb(_7745,pres,fin),_7882,_7860,_7899),
    cc(det,_7899,_7921),
    not_look_ahead([å],_7922,_7921,_7939),
    {user:testmember(_7745,[take,be])},
    redundant0(_7961,_7939,_7976),
    pushstack(first,(which,w(noun(_7734,sin,u,n)),w(verb(exist,pres,fin))),nil,_7976,_8026),whichq(_7702,_7985,_8026,_8039),
    !,
    accept(_8056,_8039,_7807).

howadjq(_7702,[howadjq,_7758,_7782,_7811],_7744,_7746) --> 
    ihvor(_7758,_7744,_7773),
    howadj1(_7718,_7782,_7773,_7799),
    pushstack(first,(which,w(noun(_7718,sin,u,n))),nil,_7799,_7849),
    whichq(_7702,_7811,_7849,_7746).

howadjq(_7702,[howadjq,_7774,lit(lenge),_7809,!,_7838],_7760,_7762) --> 
    hvor(_7774,_7760,_7789),
    cc(lenge,_7789,_7808),
    be(_7809,_7808,_7824),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),be),nil,_7824,_7904),
    ppq(_7702,_7838,_7904,_7762).

howadjq(_7702,[howadjq,_7777,_7801,_7825,_7849,_7878],_7763,_7765) --> 
    hvor(_7777,_7763,_7792),
    meny(_7801,_7792,_7816),
    be(_7825,_7816,_7840),
    w(noun(clock,_7738,_7739,_7740),_7849,_7840,_7866),
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_7866,_7944),
    whatq(_7702,_7878,_7944,_7765).

howadjq(_7702,[howadjq,_7792,lit(lenge),_7827,{},!,_7871],_7778,_7780) --> 
    hvor(_7792,_7778,_7807),
    cc(lenge,_7807,_7826),
    w(verb(_7733,pres,fin),_7827,_7826,_7844),
    {user:_7733\==take},
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(_7733,pres,fin))),nil,_7844,_7939),
    ppq(_7702,_7871,_7939,_7780).

howadjq(_7702,[howadjq,_7784,_7808,_7837,!,_7871],_7770,_7772) --> 
    hvor(_7784,_7770,_7799),
    howadj1(duration,_7808,_7799,_7825),
    w(verb(use,pres,fin),_7837,_7825,_7854),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_7854,_7939),
    ppq(_7702,_7871,_7939,_7772).

howadjq(_7702,[howadjq,_7775,_7799,_7828,_7852,!,_7981],_7761,_7763) --> 
    hvor(_7775,_7761,_7790),
    howadj1(_7719,_7799,_7790,_7816),
    do(_7828,_7816,_7843),
    pushstack(first,(prep(with),which,w(noun(_7719,sin,u,n)),do),nil,_7843,_7951),ppq(_7702,_7852,_7951,_7964),
    !,
    accept(_7981,_7964,_7763).

howadjq(_7702,[howadjq,_7775,_7799,_7828,_7852,_7876],_7761,_7763) --> 
    hvor(_7775,_7761,_7790),
    howadj1(duration,_7799,_7790,_7816),
    betake(_7828,_7816,_7843),
    thereit(_7852,_7843,_7867),
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(duration,sin,def,n))),nil,_7867,_7886),
    whatq(_7702,_7876,_7886,_7763).

howadjq(_7702,[howadjq,_7791,_7815,_7844,_7873,!,_7907],_7777,_7779) --> 
    hvor(_7791,_7777,_7806),
    howadj1(duration,_7815,_7806,_7832),
    w(verb(take,pres,fin),_7844,_7832,_7861),
    not_look_ahead([det],_7873,_7861,_7890),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_7890,_7975),
    ppq(_7702,_7907,_7975,_7779).

howmuchq(which(_7707):::_7705,[howmuchq,_7799,lit(lenge),_7834,lit(det),!,_7879],_7785,_7787) --> 
    hvor(_7799,_7785,_7814),
    cc(lenge,_7814,_7833),
    w(verb(be,_7743,fin),_7834,_7833,_7851),
    cc(det,_7851,_7873),
    !,
    pushstack(first,(which,w(noun(duration,plu,u,n)),w(verb(be,_7743,fin)),[det]),nil,_7873,_7917),
    whichq(which(_7707):::_7705,_7879,_7917,_7787).

howmuchq(which(_7707):::_7705,[howmuchq,_7816,_7840,_7864,{},lit(det),lit(å),_7925,!,_7973],_7802,_7804) --> 
    hvor(_7816,_7802,_7831),
    much(_7840,_7831,_7855),
    w(verb(_7746,_7747,fin),_7864,_7855,_7881),
    {user:testmember(_7746,[cost])},
    cc(det,_7881,_7913),
    cc(å,_7913,_7924),
    pushstack(first,([noen],[vil]),nil,_7924,_7938),clausal_object1(_7769,_7770,_7925,_7938,_7953),
    !,
    pushstack(first,(xnp(_7769,_7770),w(verb(_7746,pres,fin)),npgap(_7707)),nil,_7953,_8044),
    statreal1(_7705,_7973,_8044,_7804).

howmuchq(test:::_7705,[howmuchq,_7799,_7823,_7847,_7876,_7910,!,_7944,_7968],_7785,_7787) --> 
    hvor(_7799,_7785,_7814),
    much(_7823,_7814,_7838),
    w(verb(be,_7745,fin),_7847,_7838,_7864),
    np0_accept(_7748,_7749,_7876,_7864,_7895),
    w(adj2(_7739,nil),_7910,_7895,_7927),
    !,
    accept(_7944,_7927,_7959),
    pushstack(first,(xnp(_7748,_7749),w(verb(be,pres,fin)),w(adj2(_7739,nil))),nil,_7959,_8009),
    statemen1(real,_7705,_7968,_8009,_7787).

howmuchq(_7702,[howmuchq,_7762,_7786,_7810,!,_7844],_7748,_7750) --> 
    hvor(_7762,_7748,_7777),
    many1(_7786,_7777,_7801),
    look_ahead(w(verb(be,_7726,fin)),_7810,_7801,_7827),
    !,
    pushstack(first,[hva],nil,_7827,_7854),
    whatq(_7702,_7844,_7854,_7750).

howmuchq(howmany(_7707):::_7705,[howmuchq,_7756,_7780,_7804],_7742,_7744) --> 
    hvor(_7756,_7742,_7771),
    many1(_7780,_7771,_7795),
    pushstack(first,which,nil,_7795,_7842),
    whichq(which(_7707):::_7705,_7804,_7842,_7744).

howmuchq(howmany(_7707):::_7705,[howmuchq,_7766,_7790,_7814],_7752,_7754) --> 
    hvor(_7766,_7752,_7781),
    manypersons(_7790,_7781,_7805),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_7805,_7852),
    whichq(which(_7707):::_7705,_7814,_7852,_7754).

howmuchq(howmany(_7707):::_7705,[howmuchq,_7776,lit(det),_7811,lit(som),_7846],_7762,_7764) --> 
    be(_7776,_7762,_7791),
    cc(det,_7791,_7810),
    manypersons(_7811,_7810,_7826),
    cc(som,_7826,_7845),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_7845,_7884),
    whichq(which(_7707):::_7705,_7846,_7884,_7764).

howmuchq(which(_7707):::_7705,[howmuchq,_7771,_7795,_7819,{},_7858],_7757,_7759) --> 
    hvor(_7771,_7757,_7786),
    much(_7795,_7786,_7810),
    w(verb(_7721,_7728,fin),_7819,_7810,_7836),
    {user:testmember(_7721,[earn,cost])},
    whattrans(_7721,_7707,_7705,_7858,_7836,_7759).

howmuchq(_7702,[howmuchq,_7755,_7779,_7803,!,_7832],_7741,_7743) --> 
    hvor(_7755,_7741,_7770),
    much(_7779,_7770,_7794),
    of(_7803,_7794,_7818),
    !,
    pushstack(first,(which,of),nil,_7818,_7901),
    whichq(_7702,_7832,_7901,_7743).

howmuchq(_7702,[howmuchq,_7772,_7796,_7820,_7849,!,_7920],_7758,_7760) --> 
    hvor(_7772,_7758,_7787),
    much(_7796,_7787,_7811),
    w(noun(_7721,_7722,u,n),_7820,_7811,_7837),
    pushstack(first,(which,w(noun(_7721,sin,u,n))),nil,_7837,_7890),whichq(_7702,_7849,_7890,_7903),
    !,
    accept(_7920,_7903,_7760).

howmuchq(_7702,[howmuchq,_7748,_7772,_7796],_7734,_7736) --> 
    hvor(_7748,_7734,_7763),
    much(_7772,_7763,_7787),
    pushstack(first,[hva],nil,_7787,_7806),
    question(_7702,_7796,_7806,_7736).

whattrans(_7702,_7703,_7704,[whattrans,_7791,_7820,!,_7859],_7771,_7773) --> 
    not_look_ahead([det],_7791,_7771,_7808),
    noun_phrase1(_7730,_7733::_7734,_7820,_7808,_7839),
    !,
    pushstack(first,(noun_phrase1(_7730,_7733::_7734),w(verb(_7702,pres,fin)),npgap(_7703)),nil,_7839,_7933),
    statreal1(_7704,_7859,_7933,_7773).

howadj1(_7702,[howadj1,_7740,!],_7726,_7728) --> 
    howadj(_7702,_7740,_7726,_7728),
    !.

howadj(duration,[howadj,lit(langt)],_7723,_7725) --> 
    cc(langt,_7723,_7725).

howadj(age,[howadj,_7740],_7726,_7728) --> 
    w(adj2(old,nil),_7740,_7726,_7728).

howadj(age,[howadj,lit(mange),_7758],_7733,_7735) --> 
    cc(mange,_7733,_7757),
    w(noun(year,plu,u,n),_7758,_7757,_7735).

howadj(delay,[howadj,_7740],_7726,_7728) --> 
    w(adj2(slow,nil),_7740,_7726,_7728).

howadj(delay,[howadj,_7745,_7789],_7731,_7733) --> 
    optional(much,_7745,_7731,_7777),
    w(adj2(delayed,nil),_7789,_7777,_7733).

howadj(delay,[howadj,_7740],_7726,_7728) --> 
    w(adj2(punctual,nil),_7740,_7726,_7728).

howadj(earliness,[howadj,_7740],_7726,_7728) --> 
    w(adj2(early,nil),_7740,_7726,_7728).

howadj(lateness,[howadj,_7740],_7726,_7728) --> 
    w(adj2(late,nil),_7740,_7726,_7728).

howadj(lateness,[howadj,lit(sent)],_7723,_7725) --> 
    cc(sent,_7723,_7725).

howadj(distance,[howadj,lit(langt)],_7723,_7725) --> 
    cc(langt,_7723,_7725).

howadj(distance,[howadj,_7761,_7785,{}],_7747,_7749) --> 
    many(_7761,_7747,_7776),
    w(noun(_7712,_7726,u,n),_7785,_7776,_7749),
    {user:testmember(_7712,[mil,mile,kilometer,meter])}.

howadj(duration,[howadj,lit(mange),_7758],_7733,_7735) --> 
    cc(mange,_7733,_7757),
    w(noun(minute,_7710,_7711,n),_7758,_7757,_7735).

howadj(duration,[howadj,lit(lenge)],_7723,_7725) --> 
    cc(lenge,_7723,_7725).

howadj(duration,[howadj,_7748,_7772,!],_7734,_7736) --> 
    long(_7748,_7734,_7763),
    w(noun(time,_7713,u,n),_7772,_7763,_7736),
    !.

howadj(duration,[howadj,_7748,_7772,!],_7734,_7736) --> 
    much(_7748,_7734,_7763),
    w(noun(time,_7713,u,n),_7772,_7763,_7736),
    !.

howadj(duration,[howadj,_7740],_7726,_7728) --> 
    w(adj2(short,nil),_7740,_7726,_7728).

howadj(frequency,[howadj,_7735],_7721,_7723) --> 
    often(_7735,_7721,_7723).

howadj(frequency,[howadj,lit(mange),_7767,_7796,!,_7825],_7742,_7744) --> 
    cc(mange,_7742,_7766),
    w(noun(time_count,_7721,_7722,n),_7767,_7766,_7784),
    inperiod0(_7796,_7784,_7811),
    !,
    accept(_7825,_7811,_7744).

howadj(intelligence,[howadj,_7740],_7726,_7728) --> 
    w(adj2(intelligent,nil),_7740,_7726,_7728).

howadj(intelligence,[howadj,_7740],_7726,_7728) --> 
    w(adj2(stupid,_7707),_7740,_7726,_7728).

howadj(intelligence,[howadj,_7750,_7779],_7736,_7738) --> 
    w(adj2(_7716,nil),_7750,_7736,_7767),
    w(noun(intelligence,sin,_7711,n),_7779,_7767,_7738).

howadj(price,[howadj,_7740],_7726,_7728) --> 
    w(adj2(expensive,nil),_7740,_7726,_7728).

howadj(price,[howadj,_7740],_7726,_7728) --> 
    w(adj2(cheap,nil),_7740,_7726,_7728).

howadj(size,[howadj,_7735],_7721,_7723) --> 
    great(_7735,_7721,_7723).

howadj(length,[howadj,_7740],_7726,_7728) --> 
    w(adj2(long,nil),_7740,_7726,_7728).

howadj(length,[howadj,_7740],_7726,_7728) --> 
    w(adj2(short,nil),_7740,_7726,_7728).

howadj(speed,[howadj,lit(fort)],_7723,_7725) --> 
    cc(fort,_7723,_7725).

howadj(speed,[howadj,_7740],_7726,_7728) --> 
    w(adj2(fast,_7707),_7740,_7726,_7728).

howadj(speed,[howadj,_7740],_7726,_7728) --> 
    w(adj2(slow,_7707),_7740,_7726,_7728).

howadj(temperature,[howadj,_7740],_7726,_7728) --> 
    w(adj2(cold,nil),_7740,_7726,_7728).

howadj(temperature,[howadj,_7740],_7726,_7728) --> 
    w(adj2(hot,nil),_7740,_7726,_7728).

howadj(weather,[howadj,_7740],_7726,_7728) --> 
    w(adj2(hot,nil),_7740,_7726,_7728).

howadj(weather,[howadj,_7740],_7726,_7728) --> 
    w(adj2(cold,nil),_7740,_7726,_7728).

howadj(weight,[howadj,_7740],_7726,_7728) --> 
    w(adj2(heavy,nil),_7740,_7726,_7728).

vp(_7702,_7703,_7704,_7707::true,[vp,lit(:),_7775,!],_7741,_7743) --> 
    cc(:,_7741,_7774),
    end_of_line(_7775,_7774,_7743),
    !.

vp(_7702,_7703,_7704,_7705,[vp,_7758],_7735,_7737) --> 
    verb_phrase(_7702,_7703,_7704,_7705,_7758,_7735,_7737).

verb_phrase(_7702,_7703,_7704,_7705,[verb_phrase,_7826,{},{},{},{},!,_7895,_7919,!],_7803,_7805) --> 
    endofline(_7826,_7803,_7841),
    {user:value(busflag,true)},
    {user:(\+value(dialog,1))},
    {user:vartypeid(_7702,_7746)},
    {user:testmember(_7746,[neighbourhood,bus,tram,station,departure,arrival])},
    !,
    accept(_7895,_7841,_7910),
    pushstack(first,w(verb(exist,pres,fin)),nil,_7910,_7932),verb_phrase1(exist,_7702,_7703,_7704,_7705,_7919,_7932,_7805),
    !.

verb_phrase(_7702,_7703,_7704,_7707::_7708,[verb_phrase,_7862,{},lit(og),_7912,{},_7951,!,_7990,!,_8097],_7839,_7841) --> 
    w(verb(_7750,_7751,fin),_7862,_7839,_7879),
    {user:verbtype(_7750,tv)},
    cc(og,_7879,_7911),
    w(verb(_7763,_7764,fin),_7912,_7911,_7929),
    {user:verbtype(_7763,tv)},
    object(_7746,_7773,_7951,_7929,_7970),
    !,
    lock(exact,_7970,_8041),pushstack(exact,(w(verb(_7750,_7796,fin)),xnp(_7746,_7773)),nil,_8041,_8047),verb_phrase1(_7750,_7702,_7703,_7704,_7707::_7791,_7990,_8047,_8036),unlock(_8036,_8037),
    !,
    lock(exact,_8037,_8144),
    pushstack(exact,([og],w(verb(_7763,_7813,fin)),npgap(_7746)),nil,_8144,_8150),
    verb_phrases0(_7763,_7702,_7704,_7791,_7707::_7708,_8097,_8150,_8139),
    unlock(_8139,_7841).

verb_phrase(_7702,_7703,_7704,_7707::_7708,[verb_phrase,_7777,_7826],_7754,_7756) --> 
    verb_phrase1(_7713,_7702,_7703,_7704,_7707::_7716,_7777,_7754,_7802),
    verb_phrases0(_7713,_7702,_7704,_7716,_7707::_7708,_7826,_7802,_7756).

verb_phrases0(_7702,_7703,_7704,_7705,_7708::_7705 and _7712,[verb_phrases0,_7824,lit(ikke),!,_7864,{},{},_7942],_7798,_7800) --> 
    vp_conjunction(_7824,_7798,_7839),
    cc(ikke,_7839,_7858),
    !,
    pushstack(first,w(verb(_7702,pres,fin)),nil,_7858,_7877),verb_phrase1(_7702,_7703,_7754,_7704,_7708::_7759,_7864,_7877,_7898),
    {user:bigno(not,_7754,_7765)},
    {user:negate(_7765,_7759,_7735)},
    verb_phrases0(_7702,_7703,_7704,_7735,_7708::_7712,_7942,_7898,_7800).

verb_phrases0(_7702,_7703,_7704,_7705,_7708::_7705 and _7712,[verb_phrases0,_7805,_7829,_7858,{},_7917],_7779,_7781) --> 
    vp_conjunction(_7805,_7779,_7820),
    not_look_ahead([så],_7829,_7820,_7846),
    verb_phrase1(_7739,_7703,_7741,_7704,_7708::_7746,_7858,_7846,_7883),
    {user:negate(_7741,_7746,_7729)},
    verb_phrases0(_7726,_7703,_7704,_7729,_7708::_7712,_7917,_7883,_7781).

verb_phrases0(be,_7703,_7704,_7705,_7708::_7705 and _7712,[verb_phrases0,_7812,{},!,_7856],_7786,_7788) --> 
    w(adj2(_7731,nil),_7812,_7786,_7829),
    {user:testmember(_7731,[enclosed])},
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_7731,nil))),nil,_7829,_7866),
    verb_phrase1(be,_7703,id,_7704,_7708::_7712,_7856,_7866,_7788).

verb_phrases0(_7702,_7703,_7704,_7705,_7708::_7705,[verb_phrases0,[]],_7736,_7736) --> 
    [].

vp_conjunction([vp_conjunction,lit(som),_7744],_7722,_7724) --> 
    cc(som,_7722,_7743),
    look_ahead_vp(_7744,_7743,_7724).

vp_conjunction([vp_conjunction,lit(å),_7752],_7730,_7732) --> 
    cc(å,_7730,_7751),
    look_ahead(w(verb(_7709,pres,fin)),_7752,_7751,_7732).

vp_conjunction([vp_conjunction,lit(evt)],_7719,_7721) --> 
    cc(evt,_7719,_7721).

vp_conjunction([vp_conjunction,_7754,_7778,_7807,_7836,!],_7743,_7745) --> 
    and1(_7754,_7743,_7769),
    not_look_ahead([nå],_7778,_7769,_7795),
    not_look_ahead([så],_7807,_7795,_7824),
    not_look_ahead(w(adv(redundantly)),_7836,_7824,_7745),
    !.

vp_conjunction([vp_conjunction,lit(men),_7760,_7789,!],_7738,_7740) --> 
    cc(men,_7738,_7759),
    not_look_ahead([så],_7760,_7759,_7777),
    look_ahead_lit([skal,vil],_7789,_7777,_7740),
    !.

vp_conjunction([vp_conjunction,lit(men),_7762,_7791,!],_7740,_7742) --> 
    cc(men,_7740,_7761),
    not_look_ahead([så],_7762,_7761,_7779),
    look_ahead(w(verb(_7721,_7722,_7723)),_7791,_7779,_7742),
    !.

vp_conjunction([vp_conjunction,_7739,_7763],_7728,_7730) --> 
    or1(_7739,_7728,_7754),
    look_ahead(w(verb(_7709,_7710,fin)),_7763,_7754,_7730).

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7805,_7829,_7858,!,_7892,_7916],_7779,_7781) --> 
    aux1(_7805,_7779,_7820),
    not_look_ahead(w(verb(_7736,_7737,_7738)),_7829,_7820,_7846),
    look_ahead_lit([så,tilbake,fram],_7858,_7846,_7875),
    !,
    accept(_7892,_7875,_7907),
    pushstack(first,w(verb(go,pres,fin)),nil,_7907,_7926),
    do_phrase(_7702,_7703,_7704,_7705,_7706,_7916,_7926,_7781).

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7828,_7852,_7881,{},{},!,_7940,_7964],_7802,_7804) --> 
    aux1(_7828,_7802,_7843),
    not_look_ahead(w(verb(_7742,_7743,_7744)),_7852,_7843,_7869),
    np0_accept(_7735,_7736,_7881,_7869,_7900),
    {user:vartypeid(_7735,_7752)},
    {user:testmember(_7752,[thing,coevent,activity])},
    !,
    accept(_7940,_7900,_7955),
    pushstack(first,(w(verb(do1,pres,fin)),xnp(_7735,_7736)),nil,_7955,_8005),
    do_phrase(_7702,_7703,_7704,_7705,_7706,_7964,_8005,_7804).

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7855,_7879,_7908,_7932,_7961,{},_8000,_8024,{},!,_8073,_8097],_7829,_7831) --> 
    aux1(_7855,_7829,_7870),
    negation0(_7704,_7879,_7870,_7896),
    redundant0(_7908,_7896,_7923),
    not_look_ahead(w(verb(_7759,_7760,_7761)),_7932,_7923,_7949),
    w(prep(_7765),_7961,_7949,_7978),
    {user:testmember(_7765,[from,to,on,towards])},
    look_ahead_np(_8000,_7978,_8015),
    np0_accept(_7750,_7751,_8024,_8015,_8043),
    {user:constrain(_7750,place)},
    !,
    accept(_8073,_8043,_8088),
    pushstack(first,(w(verb(go,pres,fin)),w(prep(_7765)),xnp(_7750,_7751)),nil,_8088,_8138),
    do_phrase(_7702,_7703,_7704,_7705,_7706,_8097,_8138,_7831).

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7815,_7839,_7868,{},_7907,!,_7936,_7960],_7789,_7791) --> 
    aux1(_7815,_7789,_7830),
    not_look_ahead(w(verb(_7739,_7740,_7741)),_7839,_7830,_7856),
    look_ahead(w(prep(_7747)),_7868,_7856,_7885),
    {user:(\+testmember(_7747,[from,to,on,towards]))},
    preadverbials0(_7907,_7885,_7922),
    !,
    accept(_7936,_7922,_7951),
    do_phrase(_7702,_7703,_7704,_7705,_7706,_7960,_7951,_7791).

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7794,_7818,_7847,!,_7881,_7905],_7768,_7770) --> 
    aux1(_7794,_7768,_7809),
    not_look_ahead(w(verb(_7733,_7734,_7735)),_7818,_7809,_7835),
    one_of_lit([da,nå],_7847,_7835,_7864),
    !,
    accept(_7881,_7864,_7896),
    do_phrase(_7702,_7703,_7704,_7705,_7706,_7905,_7896,_7770).

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7822,_7846,_7875,_7904,_7928,{},!,_7977,_8001],_7796,_7798) --> 
    aux1(_7822,_7796,_7837),
    not_look_ahead(w(verb(_7745,_7746,_7747)),_7846,_7837,_7863),
    w(prep(_7751),_7875,_7863,_7892),
    look_ahead_np(_7904,_7892,_7919),
    np0_accept(_7738,_7739,_7928,_7919,_7947),
    {user:constrain(_7738,time)},
    !,
    accept(_7977,_7947,_7992),
    lock(last,_7992,_8049),
    pushstack(last,(w(prep(_7751)),xnp(_7738,_7739)),nil,_8049,_8055),
    do_phrase(_7702,_7703,_7704,_7705,_7706,_8001,_8055,_8044),
    unlock(_8044,_7798).

verb_phrase1(be1,_7703,_7704,_7705,_7706,[verb_phrase1,lit(skal),_7830,_7859,lit(med),_7914,_7938,{}],_7793,_7795) --> 
    cc(skal,_7793,_7829),
    negation0(_7728,_7830,_7829,_7847),
    optional(w(verb(be,inf,fin)),_7859,_7847,_7891),
    cc(med,_7891,_7913),
    not_look_ahead_np(_7914,_7913,_7929),
    pushstack(first,(w(verb(be1,inf,fin)),w(adv(inside))),nil,_7929,_7951),do_phrase(be1,_7703,_7729,_7705,_7706,_7938,_7951,_7795),
    {user:bigno(_7728,_7729,_7704)}.

verb_phrase1(be,_7703,id,_7705,_7706,[verb_phrase1,_7789,{},_7828],_7763,_7765) --> 
    w(adj2(_7719,nil),_7789,_7763,_7806),
    {user:testmember(_7719,[enclosed])},
    pushstack(first,w(adj2(_7719,nil)),nil,_7806,_7838),
    be_pred(_7703,_7705,_7706,_7828,_7838,_7765).

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7837,_7866,_7895,_7924,{},!,_7968,_8026,{}],_7811,_7813) --> 
    constrainvehdep(_7703,_7837,_7811,_7854),
    w(verb(be,_7743,fin),_7866,_7854,_7883),
    negation0(_7734,_7895,_7883,_7912),
    w(verb(_7702,past,part),_7924,_7912,_7941),
    {user:testmember(_7702,[go,run,pass])},
    !,
    pushstack(first,w(verb(_7702,_7743,fin)),nil,_7941,_7981),vp_kernel(_7702,_7703,_7735,_7705,_7778,_7968,_7981,_8002),
    verb_modifiers0(_7702,_7703,_7705,_7778,_7706,_8026,_8002,_7813),
    {user:bigno(_7734,_7735,_7704)}.

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7802,_7826,_7855,_7884,!,_7933],_7776,_7778) --> 
    blei(_7802,_7776,_7817),
    one_of_lit([siden,derfor,dermed],_7826,_7817,_7843),
    negation0(_7704,_7855,_7843,_7872),
    lexv(tv,_7702,past,part,_7884,_7872,_7907),
    !,
    pushstack(first,w(verb(_7702,past,part)),nil,_7907,_7943),
    passive(_7703,_7705,_7706,_7933,_7943,_7778).

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7797,_7821,_7845,_7874,_7898,!,_7947],_7771,_7773) --> 
    aux1(_7797,_7771,_7812),
    redundant0(_7821,_7812,_7836),
    negation0(_7704,_7845,_7836,_7862),
    blei(_7874,_7862,_7889),
    lexv(tv,_7702,past,part,_7898,_7889,_7921),
    !,
    pushstack(first,w(verb(_7702,past,part)),nil,_7921,_7957),
    passive(_7703,_7705,_7706,_7947,_7957,_7773).

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7804,_7828,_7857,_7881,_7925,!,_7964],_7778,_7780) --> 
    redundant0(_7804,_7778,_7819),
    blei(_7704,_7828,_7819,_7845),
    redundant0(_7857,_7845,_7872),
    lexv(_7737,_7702,past,part,_7881,_7872,_7904),
    gmem(_7737,[tv,dtv],_7925,_7904,_7944),
    !,
    pushstack(first,w(verb(_7702,past,part)),nil,_7944,_7974),
    passive(_7703,_7705,_7706,_7964,_7974,_7780).

verb_phrase1(be,_7703,_7704,_7705,_7706,[verb_phrase1,_7797,_7826,_7850,_7874,_7903,_7927,_7951,_7975,_7999],_7771,_7773) --> 
    not_look_ahead(w(verb(go,_7741,fin)),_7797,_7771,_7814),
    aux10(_7826,_7814,_7841),
    redundants0(_7850,_7841,_7865),
    be(_7704,_7874,_7865,_7891),
    not_look_ahead_verbx(_7903,_7891,_7918),
    danow0(_7927,_7918,_7942),
    redundant0(_7951,_7942,_7966),
    not_look_ahead_prepx(_7975,_7966,_7990),
    be_complements(_7703,_7705,_7706,_7999,_7990,_7773).

not_look_ahead_verbx([not_look_ahead_verbx,lit(så),!],_7722,_7724) --> 
    cc(så,_7722,_7724),
    !.

not_look_ahead_verbx([not_look_ahead_verbx,_7736],_7725,_7727) --> 
    not_look_ahead(w(verb(_7706,_7707,_7708)),_7736,_7725,_7727).

not_look_ahead_prepx([not_look_ahead_prepx,_7752,{},!,_7796],_7741,_7743) --> 
    look_ahead(w(prep(_7715)),_7752,_7741,_7769),
    {user:(\+testmember(_7715,[for]))},
    !,
    reject(_7796,_7769,_7743).

not_look_ahead_prepx([not_look_ahead_prepx,[]],_7717,_7717) --> 
    [].

verb_phrase1(_7702,_7703,_7704,_7705,_7706,[verb_phrase1,_7814,_7848,_7877,_7901,{},_7940,{},!,_8004],_7788,_7790) --> 
    auxs0(_7732,_7733,_7814,_7788,_7833),
    not_look_ahead(w(verb(_7739,_7740,pass)),_7848,_7833,_7865),
    redundants0(_7877,_7865,_7892),
    negation0(_7743,_7901,_7892,_7918),
    {user:bigno(_7732,_7743,_7749)},
    do_phrase(_7702,_7703,_7753,_7705,_7706,_7940,_7918,_7965),
    {user:bigno(_7749,_7753,_7704)},
    !,
    accept(_8004,_7965,_7790).

verb_phrase1(go,_7703,_7704,_7705,_7706,[verb_phrase1,_7804,_7828,lit(av),!,_7873,_7897],_7778,_7780) --> 
    aux1(_7804,_7778,_7819),
    not_look_ahead(w(verb(_7735,_7736,_7737)),_7828,_7819,_7845),
    cc(av,_7845,_7867),
    !,
    accept(_7873,_7867,_7888),
    pushstack(first,(w(verb(go,pres,fin)),[av]),nil,_7888,_7907),
    do_phrase(go,_7703,_7704,_7705,_7706,_7897,_7907,_7780).

verb_phrase1(_7702,_7703,id,_7705,_7708::_7709,[verb_phrase1,_7793,_7817,_7841,_7870],_7767,_7769) --> 
    paux0(_7793,_7767,_7808),
    redundant0(_7817,_7808,_7832),
    w(verb(_7702,_7732,pass),_7841,_7832,_7858),
    pushstack(first,w(verb(_7702,past,part)),nil,_7858,_7880),
    passive(_7703,_7705,_7708::_7709,_7870,_7880,_7769).

verb_phrase1(live,_7703,id,_7705,_7706,[verb_phrase1,_7828,_7852,_7876,_7905,_7934,!,_7983],_7802,_7804) --> 
    be(_7828,_7802,_7843),
    redundant0(_7852,_7843,_7867),
    number(_7745,_7876,_7867,_7893),
    w(noun(year,_7750,u,n),_7905,_7893,_7922),
    optional(w(adj2(old,nil)),_7934,_7922,_7966),
    !,
    pushstack(first,(w(verb(live,pres,fin)),prep1(in),number(_7745),w(noun(year,plu,u,n))),nil,_7966,_8057),
    do_phrase(live,_7703,id,_7705,_7706,_7983,_8057,_7804).

verb_phrase1(be,_7703,_7704,_7705,_7706,[verb_phrase1,_7781,_7810,lit(som),!,_7850],_7755,_7757) --> 
    be(_7704,_7781,_7755,_7798),
    dudet(_7810,_7798,_7825),
    cc(som,_7825,_7844),
    !,
    do_phrase(be,_7703,_7704,_7705,_7706,_7850,_7844,_7757).

verb_phrase1(be,_7703,_7704,_7705,_7706,[verb_phrase1,_7842,_7871,_7900,!,_7934,_7958,_7987,_8016,_8040,_8064,{}],_7816,_7818) --> 
    not_look_ahead(w(verb(go,_7749,fin)),_7842,_7816,_7859),
    w(verb(be,_7755,fin),_7871,_7859,_7888),
    not_look_ahead(w(verb(_7762,_7763,part)),_7900,_7888,_7917),
    !,
    accept(_7934,_7917,_7949),
    not_look_ahead(w(name(_7770,_7771,_7772)),_7958,_7949,_7975),
    negation0(_7740,_7987,_7975,_8004),
    it0(_8016,_8004,_8031),
    redundant0(_8040,_8031,_8055),
    pushstack(first,w(verb(be,pres,fin)),nil,_8055,_8077),do_phrase(be,_7703,_7741,_7705,_7706,_8064,_8077,_7818),
    {user:bigno(_7740,_7741,_7704)}.

verb_phrase1(_7702,_7703,id,_7705,_7706,[verb_phrase1,_7786,_7810,_7839,_7863],_7760,_7762) --> 
    paux0(_7786,_7760,_7801),
    w(verb(_7702,pres,pass),_7810,_7801,_7827),
    thereit0(_7839,_7827,_7854),
    pushstack(first,w(adj2(_7702,nil)),nil,_7854,_7873),
    be_complements(_7703,_7705,_7706,_7863,_7873,_7762).

do_phrase(_7702,_7703,_7704,_7705,_7706,[do_phrase,_7887,{},_7926,_7955,_7979,_8008,_8037,{},!,_8081,_8105,_8171],_7861,_7863) --> 
    w(verb(_7702,_7760,fin),_7887,_7861,_7904),
    {user:testmember(_7702,[go,come])},
    negation0(_7704,_7926,_7904,_7943),
    morethan0(_7955,_7943,_7970),
    w(nb(_7776,num),_7979,_7970,_7996),
    w(noun(minute,_7782,u,n),_8008,_7996,_8025),
    w(adj2(_7788,_7789),_8037,_8025,_8054),
    {user:testmember(_7788,[delayed,tooearly,late])},
    !,
    accept(_8081,_8054,_8096),
    lock(exact,_8096,_8125),pushstack(exact,w(adj2(_7788,_7789)),nil,_8125,_8131),ap(_7788,_7703,_7705,_7813,_8105,_8131,_8120),unlock(_8120,_8121),
    pushstack(first,(w(prep(with)),w(nb(_7776,num)),w(noun(minute,plu,u,n))),nil,_8121,_8181),
    verb_modifiers0(adj/nil/_7788,_7703,_7705,_7813,_7706,_8171,_8181,_7863).

morethan0([morethan0,lit(ca),!],_7722,_7724) --> 
    cc(ca,_7722,_7724),
    !.

morethan0([morethan0,lit(minst),!],_7722,_7724) --> 
    cc(minst,_7722,_7724),
    !.

morethan0([morethan0,lit(mer),lit(enn),!],_7727,_7729) --> 
    cc(mer,_7727,_7748),
    cc(enn,_7748,_7729),
    !.

morethan0([morethan0,[]],_7717,_7717) --> 
    [].

do_phrase(_7702,_7703,id,_7705,_7708::_7711 and _7712,[do_phrase,_7843,_7872,_7901,{},_7945,_7969,!,_8003,{}],_7817,_7819) --> 
    w(verb(ask,_7750,fin),_7843,_7817,_7860),
    not_look_ahead([om],_7872,_7860,_7889),
    object(_7757,_7758,_7901,_7889,_7920),
    {user:constrain(_7757,agent)},
    omaa0(_7945,_7920,_7960),
    w(verb(_7767,inf,fin),_7969,_7960,_7986),
    !,
    pushstack(first,(xnp(_7757,_7758),w(verb(_7767,pres,fin))),nil,_7986,_8047),clausal_object1(_7743,_7708::_7712,_8003,_8047,_7819),
    {user:co_template(_7702,that,_7703,_7743,_7705,_7711)}.

omaa0([omaa0,[]],_7717,_7717) --> 
    [].

omaa([omaa,lit(om),lit(å)],_7724,_7726) --> 
    cc(om,_7724,_7745),
    cc(å,_7745,_7726).

omaa([omaa,lit(om),lit(og)],_7724,_7726) --> 
    cc(om,_7724,_7745),
    cc(og,_7745,_7726).

omaa([omaa,lit(å)],_7719,_7721) --> 
    cc(å,_7719,_7721).

do_phrase(_7702,_7703,_7704,_7705,_7706,[do_phrase,_7774,_7823],_7748,_7750) --> 
    rvp_kernel(_7702,_7703,_7704,_7705,_7714,_7774,_7748,_7799),
    verb_modifiers0(_7702,_7703,_7705,_7714,_7706,_7823,_7799,_7750).

do_phrase(have,_7703,id,_7705,_7708::_7711 and _7712,[do_phrase,_7833,_7857,{},lit(for),lit(å),!,_7923,_7947,{}],_7807,_7809) --> 
    has(_7833,_7807,_7848),
    w(adj2(_7748,nil),_7857,_7848,_7874),
    {user:testmember(_7748,[difficult])},
    cc(for,_7874,_7906),
    cc(å,_7906,_7917),
    !,
    accept(_7923,_7917,_7938),
    pushstack(first,(npgap(_7703),aux1),nil,_7938,_8018),clausal_object1(_7774:coevent,_7708::_7712,_7947,_8018,_7809),
    {user:tv_template(dislike,_7703,_7774:coevent,_7705,_7711)}.

do_phrase(_7702,_7703,_7704,_7705,_7706,[do_phrase,_7780,_7829,_7878],_7754,_7756) --> 
    vp_kernel(_7702,_7703,_7714,_7705,_7721,_7780,_7754,_7805),
    verb_modifiers0(_7702,_7703,_7705,_7721,_7706,_7829,_7805,_7854),
    negation2(_7714,_7704,_7878,_7854,_7756).

do_phrase(_7702,_7703,_7704,_7705,_7706,[do_phrase,_7809,_7838,!,_7872,_7930,_7954],_7783,_7785) --> 
    not_look_ahead(w(verb(_7733,_7734,_7735)),_7809,_7783,_7826),
    look_ahead(w(prep(_7741)),_7838,_7826,_7855),
    !,
    pushstack(first,w(verb(do1,pres,fin)),nil,_7855,_7885),vp_kernel(_7702,_7703,_7704,_7705,_7726,_7872,_7885,_7906),
    it0(_7930,_7906,_7945),
    verb_modifiers0(_7702,_7703,_7705,_7726,_7706,_7954,_7945,_7785).

rvp_kernel(_7702,_7703,_7704,_7705,_7706,[rvp_kernel,_7899,{},_7958,_7987,_8016,_8045,_8074,{},_8118,_8162,_8191,!,_8230,_8350],_7873,_7875) --> 
    hlexv(dtv,_7702,_7758,_7759,_7760,_7899,_7873,_7924),
    {user:testmember(_7702,[ask,tell,answer,answer1])},
    not_look_ahead([om],_7958,_7924,_7975),
    not_look_ahead([et],_7987,_7975,_8004),
    not_look_ahead([en],_8016,_8004,_8033),
    not_look_ahead(w(nb(_7791,_7792)),_8045,_8033,_8062),
    ind_object(_7794,_7795,_8074,_8062,_8093),
    {user:constrain(_7794,agent)},
    optional([om],_8118,_8093,_8150),
    not_look_ahead([at],_8162,_8150,_8179),
    np1_accept(_7753,_7754,_8191,_8179,_8210),
    !,
    pushstack(first,(lexv(dtv,_7702,_7758,_7759),xnp(_7794,_7795),[noe]),nil,_8210,_8305),vp_kernel(_7702,_7703,_7704,_7705,_7828,_8230,_8305,_8326),
    pushstack(first,(w(prep(about)),xnp(_7753,_7754)),nil,_8326,_8391),
    verb_modifiers0(_7702,_7703,_7705,_7828,_7706,_8350,_8391,_7875).

rvp_kernel(_7702,_7703,_7704,_7705,_7706,[rvp_kernel,_7782,_7831,_7860,!],_7756,_7758) --> 
    lexvaccept(rv,_7702,_7719,_7720,_7704,_7782,_7756,_7807),
    reflexiv0(_7702,_7831,_7807,_7848),
    rvpk(_7702,_7703,id,_7705,_7706,_7860,_7848,_7758),
    !.

rvp_kernel(_7702,_7703,id,_7705,event/real/_7705::_7711 and _7712,[rvp_kernel,_7847,{},_7906,_7935,{},_7974,!,_8003,_8027,{}],_7821,_7823) --> 
    hlexv(rv,_7702,_7757,_7758,_7759,_7847,_7821,_7872),
    {user:testmember(_7702,[know,say])},
    reflexiv0(_7702,_7906,_7872,_7923),
    w(prep(_7774),_7935,_7923,_7952),
    {user:(\+testmember(_7774,[]))},
    which(_7974,_7952,_7989),
    !,
    accept(_8003,_7989,_8018),
    pushstack(first,(w(prep(_7774)),which),nil,_8018,_8068),ppstnp(_7751,_7711,_8027,_8068,_7823),
    {user:tv_template(_7702,_7703,_7751,_7705,_7712)}.

rvp_kernel(adj/nil/_7715,_7703,_7704,_7705,_7708::_7711 and _7712,[rvp_kernel,_7820,_7849,_7878,_7907,_7931,{}],_7794,_7796) --> 
    w(verb(be,_7747,fin),_7820,_7794,_7837),
    negation0(_7704,_7849,_7837,_7866),
    w(adj2(_7715,nil),_7878,_7866,_7895),
    forat(_7907,_7895,_7922),
    clausal_object1(_7763:_7764,_7708::_7712,_7931,_7922,_7796),
    {user:atv_template(_7715,because_of,_7703,_7763:_7764,_7705,_7711)}.

rvpk(_7702,_7703,id,_7705,_7708::_7711 and _7712,[rvpk,{},_7855,lit(hvordan),_7890,!,_7919,_7943,{}],_7819,_7821) --> 
    {user:testmember(_7702,[ask,answer,answer1,discuss,know,know1])},
    omut0(_7855,_7819,_7870),
    cc(hvordan,_7870,_7889),
    endofline0(_7890,_7889,_7905),
    !,
    accept(_7919,_7905,_7934),
    pushstack(first,(w(noun(bus,sin,def,n)),w(verb(go,pres,fin))),nil,_7934,_7956),clausal_object1(_7781:_7782,_7708::_7712,_7943,_7956,_7821),
    {user:co_template(_7702,how,_7703,_7781:_7782,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},_7851,lit(hvordan),!,_7891,{},!,_7935,_7959,{}],_7815,_7817) --> 
    {user:testmember(_7702,[ask,answer,answer1,discuss,know,know1])},
    omut0(_7851,_7815,_7866),
    cc(hvordan,_7866,_7885),
    !,
    negation0(_7704,_7891,_7885,_7908),
    {user:test(rv_templ(_7702,_7776))},
    !,
    accept(_7935,_7908,_7950),
    clausal_object1(_7784:_7785,_7708::_7712,_7959,_7950,_7817),
    {user:co_template(_7702,how,_7703,_7784:_7785,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,_7848,_7882,lit(at),_7922,!,_7956,_7995,{}],_7822,_7824) --> 
    gmem(_7702,[calculate,say,tell,know,decide,believe,doubt,think],_7848,_7822,_7867),
    negation0(_7704,_7882,_7867,_7899),
    cc(at,_7899,_7921),
    look_ahead_lit([hvis,når,selvom],_7922,_7921,_7939),
    !,
    subordinate(_7774,_7775,_7776,_7956,_7939,_7977),
    lock(last,_7977,_8047),pushstack(last,subordinate(_7774,_7775,_7776),nil,_8047,_8053),clausal_object1(_7791:_7792,_7708::_7712,_7995,_8053,_8042),unlock(_8042,_7824),
    {user:tv_template(_7702,_7703,_7791:_7792,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,_7827,_7861,_7885,_7914,_7943,{}],_7801,_7803) --> 
    gmem(_7702,[calculate,fear,hope,know,mean,recognize,think,understand],_7827,_7801,_7846),
    redundant0(_7861,_7846,_7876),
    negation0(_7704,_7885,_7876,_7902),
    not_look_ahead_lit([at,om],_7914,_7902,_7931),
    clausal_object0(_7770:_7771,_7708::_7712,_7943,_7931,_7803),
    {user:tv_template(_7702,_7703,_7770:_7771,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,_7835,_7869,lit(at),_7909,!,_7948,_7972,{}],_7809,_7811) --> 
    gmem(_7702,[do1,paint],_7835,_7809,_7854),
    negation0(_7704,_7869,_7854,_7886),
    cc(at,_7886,_7908),
    np0_accept(_7754,_7755,_7909,_7908,_7928),
    !,
    accept(_7948,_7928,_7963),
    pushstack(first,(xnp(_7754,_7755),w(verb(be,pres,fin))),nil,_7963,_8016),clausal_object1(_7775:_7776,_7708::_7712,_7972,_8016,_7811),
    {user:tv_template(_7702,_7703,_7775:_7776,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},_7828,_7857,lit(at),!,_7897,{}],_7792,_7794) --> 
    {user:testmember(_7702,[base,say,tell])},
    negation0(_7704,_7828,_7792,_7845),
    preadverbials0(_7857,_7845,_7872),
    cc(at,_7872,_7891),
    !,
    clausal_object1(_7761:_7762,_7708::_7712,_7897,_7891,_7794),
    {user:tv_template(_7702,_7703,_7761:_7762,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},_7831,_7860,!,_7894,_7918,{}],_7795,_7797) --> 
    {user:testmember(_7702,[mean,think])},
    pronoun(_7749,_7831,_7795,_7848),
    negation0(_7704,_7860,_7848,_7877),
    !,
    accept(_7894,_7877,_7909),
    pushstack(first,pronoun(_7749),nil,_7909,_7961),clausal_object1(_7764:_7765,_7708::_7712,_7918,_7961,_7797),
    {user:tv_template(_7702,_7703,_7764:_7765,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},_7834,_7863,_7897,lit(å),!,_7957,{}],_7798,_7800) --> 
    {user:testmember(_7702,[regard])},
    negation0(_7704,_7834,_7798,_7851),
    object1(_7752,_7753,_7863,_7851,_7882),
    optional([for],_7897,_7882,_7929),
    cc(å,_7929,_7951),
    !,
    pushstack(first,xnp(_7752,_7753),nil,_7951,_8001),clausal_object1(_7739,_7708::_7712,_7957,_8001,_7800),
    {user:tv_template(_7702,_7703,_7739,_7705,_7711)}.

rvpk(_7702,_7703,id,_7705,_7708::_7711 and _7712,[rvpk,{},_7834,_7878,lit(når),!,_7938,_7962,{}],_7798,_7800) --> 
    {user:testmember(_7702,[wonder])},
    optional([på],_7834,_7798,_7866),
    optional([om],_7878,_7866,_7910),
    cc(når,_7910,_7932),
    !,
    accept(_7938,_7932,_7953),
    clausal_object1(_7767:coevent,_7708::_7712,_7962,_7953,_7800),
    {user:co_template(_7702,when,_7703,_7767:coevent,_7705,_7711)}.

rvpk(_7702,_7703,id,_7705,_7708::_7711 and _7712,[rvpk,{},_7829,lit(om),!,_7889,_7913,{}],_7793,_7795) --> 
    {user:testmember(_7702,[think,wonder])},
    optional([på],_7829,_7793,_7861),
    cc(om,_7861,_7883),
    !,
    accept(_7889,_7883,_7904),
    clausal_object1(_7762:coevent,_7708::_7712,_7913,_7904,_7795),
    {user:co_template(_7702,whether,_7703,_7762:coevent,_7705,_7711)}.

altsogå([altsogå,lit(altså),lit(å)],_7724,_7726) --> 
    cc(altså,_7724,_7745),
    cc(å,_7745,_7726).

altsogå([altsogå,lit(og),lit(å)],_7724,_7726) --> 
    cc(og,_7724,_7745),
    cc(å,_7745,_7726).

ppstnp(_7702,_7703,[ppstnp,_7763,_7792,_7816,_7855],_7746,_7748) --> 
    w(prep(_7715),_7763,_7746,_7780),
    which(_7792,_7780,_7807),
    np_kernel(0,_7702,_7717,_7816,_7807,_7837),
    forwst(_7703,_7715,_7702,_7717,_7855,_7837,_7748).

forwst(_7702,_7703,_7704,_7705,[forwst,_7762],_7739,_7741) --> 
    pushstack(free,adverbial1(_7703,_7704,_7705),nil,_7739,_7804),
    statreal(_7702,_7762,_7804,_7741).

forat([forat,lit(at)],_7719,_7721) --> 
    cc(at,_7719,_7721).

forat([forat,lit(for),lit(at)],_7724,_7726) --> 
    cc(for,_7724,_7745),
    cc(at,_7745,_7726).

forat([forat,lit(fordi)],_7719,_7721) --> 
    cc(fordi,_7719,_7721).

forat([forat,lit(av),lit(at)],_7724,_7726) --> 
    cc(av,_7724,_7745),
    cc(at,_7745,_7726).

forat([forat,lit(over),lit(at)],_7724,_7726) --> 
    cc(over,_7724,_7745),
    cc(at,_7745,_7726).

forat([forat,lit(til),lit(at)],_7724,_7726) --> 
    cc(til,_7724,_7745),
    cc(at,_7745,_7726).

forat([forat,lit(om)],_7719,_7721) --> 
    cc(om,_7719,_7721).

rvpk(_7702,_7703,id,_7705,_7708::_7711 and _7712,[rvpk,{},_7846,lit(hvor),_7881,!,_7915,{}],_7810,_7812) --> 
    {user:testmember(_7702,[ask,answer,answer1,discuss,know,know1])},
    omut0(_7846,_7810,_7861),
    cc(hvor,_7861,_7880),
    w(adj2(_7762,nil),_7881,_7880,_7898),
    !,
    pushstack(free,w(adj2(_7762,nil)),nil,_7898,_7928),clausal_object1(_7779:_7780,_7708::_7712,_7915,_7928,_7812),
    {user:co_template(_7702,how,_7703,_7779:_7780,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,_7851,_7885,_7914,_7938,lit(når),{},!,_7988,!,_8022,_8046,{}],_7825,_7827) --> 
    gmem(_7702,[ask,answer,answer1,discover,discuss,know,know1,say],_7851,_7825,_7870),
    reflexiv0(_7702,_7885,_7870,_7902),
    redundant0(_7914,_7902,_7929),
    omut0(_7938,_7929,_7953),
    cc(når,_7953,_7972),
    {user:test(rv_templ(_7702,_7784))},
    !,
    negation0(_7704,_7988,_7972,_8005),
    !,
    accept(_8022,_8005,_8037),
    clausal_object1(_7794:_7795,_7708::_7712,_8046,_8037,_7827),
    {user:co_template(_7702,when,_7703,_7794:_7795,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},{},lit(_7775),{},!,_7898,!,_7932,_7956,{}],_7826,_7828) --> 
    {user:(\+testmember(_7702,[fail,help,let,lie2,slip,try]))},
    {user:test(rv_templ(_7702,_7774))},
    cc(_7775,_7826,_7882),
    {user:testmember(_7775,[hvorfor,hvordan])},
    !,
    negation0(_7704,_7898,_7882,_7915),
    !,
    accept(_7932,_7915,_7947),
    clausal_object1(_7795:_7796,_7708::_7712,_7956,_7947,_7828),
    {user:co_template(_7702,why,_7703,_7795:_7796,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},_7840,_7869,lit(at),!,_7924,{},[]],_7804,_7806) --> 
    {user:testmember(_7702,[say,tell])},
    negation0(_7704,_7840,_7804,_7857),
    pp(_7738,_7739,_7740,_7869,_7857,_7890),
    cc(at,_7890,_7918),
    !,
    clausal_object1(_7765:_7766,_7708::_7712,_7924,_7918,_7943),
    {user:tv_template(_7702,_7703,_7765:_7766,_7705,_7711)},
    pushstack(free,adverbial1(_7738,_7739,_7740),nil,_7943,_7806),
    [].

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},_7863,_7892,_7916,{},{},!,_7970,_7994,{}],_7827,_7829) --> 
    {user:(\+testmember(_7702,[fail,help,let,lie2,slip,think,try,propose]))},
    reflexiv0(_7702,_7863,_7827,_7880),
    omut0(_7892,_7880,_7907),
    negation0(_7704,_7916,_7907,_7933),
    {user:test(rv_templ(_7702,_7781))},
    {user:(\+verbtype(_7702,tv))},
    !,
    accept(_7970,_7933,_7985),
    clausal_object0(_7796:_7797,_7708::_7712,_7994,_7985,_7829),
    {user:tv_template(_7702,_7703,_7796:_7797,_7705,_7711)}.

at0([at0,lit(at),!],_7722,_7724) --> 
    cc(at,_7722,_7724),
    !.

at0([at0,_7746],_7735,_7737) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de,det],_7746,_7735,_7737).

omut0([omut0,lit(om),!],_7722,_7724) --> 
    cc(om,_7722,_7724),
    !.

omut0([omut0,lit(ut),!],_7722,_7724) --> 
    cc(ut,_7722,_7724),
    !.

omut0([omut0,[]],_7717,_7717) --> 
    [].

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},_7852,lit(om),_7892,!,_7926,!,_7960,_7984,{}],_7816,_7818) --> 
    {user:testmember(_7702,[ask,say,know,know1,answer,answer1])},
    reflexiv0(_7702,_7852,_7816,_7869),
    cc(om,_7869,_7891),
    not_look_ahead_lit([et,en],_7892,_7891,_7909),
    !,
    negation0(_7704,_7926,_7909,_7943),
    !,
    accept(_7960,_7943,_7975),
    clausal_object1(_7785:_7786,_7708::_7712,_7984,_7975,_7818),
    {user:co_template(_7702,whether,_7703,_7785:_7786,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},{},_7867,_7896,lit(at),!,_7936,!,_7970,_7994,{}],_7821,_7823) --> 
    {user:test(rv_templ(_7702,_7757))},
    {user:(\+testmember(_7702,[fail,help,let,lie2,slip,try]))},
    reflexiv0(_7702,_7867,_7821,_7884),
    omut0(_7896,_7884,_7911),
    cc(at,_7911,_7930),
    !,
    negation0(_7704,_7936,_7930,_7953),
    !,
    accept(_7970,_7953,_7985),
    clausal_object1(_7790:_7791,_7708::_7712,_7994,_7985,_7823),
    {user:tv_template(_7702,_7703,_7790:_7791,_7705,_7711)}.

at0([at0,lit(at),!],_7722,_7724) --> 
    cc(at,_7722,_7724),
    !.

at0([at0,_7744],_7733,_7735) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_7744,_7733,_7735).

omut0([omut0,lit(om),!],_7722,_7724) --> 
    cc(om,_7722,_7724),
    !.

omut0([omut0,lit(ut),!],_7722,_7724) --> 
    cc(ut,_7722,_7724),
    !.

omut0([omut0,[]],_7717,_7717) --> 
    [].

rvpk(_7702,_7703,_7704,_7705,_7706,[rvpk,{},_7836,_7880,_7904,!,_7943],_7800,_7802) --> 
    {user:testmember(_7702,[ask,check,discuss,know,know1,tell])},
    optional([om],_7836,_7800,_7868),
    hvilkemange(_7880,_7868,_7895),
    clausal_object0(_7732,_7733,_7904,_7895,_7923),
    !,
    pushstack(first,(w(verb(_7702,pres,fin)),w(prep(about)),xnp(_7732,_7733)),nil,_7923,_7984),
    do_phrase(_7702,_7703,_7704,_7705,_7706,_7943,_7984,_7802).

hvilkemange([hvilkemange,lit(hvilke)],_7719,_7721) --> 
    cc(hvilke,_7719,_7721).

hvilkemange([hvilkemange,lit(hvor),lit(mange)],_7724,_7726) --> 
    cc(hvor,_7724,_7745),
    cc(mange,_7745,_7726).

rvpk(_7702,_7703,id,_7705,_7708::_7711 and _7712,[rvpk,lit(om),lit(å),{},{},!,_7876,{}],_7803,_7805) --> 
    cc(om,_7803,_7839),
    cc(å,_7839,_7850),
    {user:testmember(_7702,[ask])},
    {user:test(rv_templ(_7702,_7756))},
    !,
    pushstack(first,(npgap(_7703),aux1),nil,_7850,_7947),clausal_object1(_7770:coevent,_7708::_7712,_7876,_7947,_7805),
    {user:tv_template(_7702,_7703,_7770:coevent,_7705,_7711)}.

rvpk(_7702,_7703,id,_7705,_7708::_7711 and _7712,[rvpk,_7822,_7856,!,_7905,{}],_7796,_7798) --> 
    gmem(_7702,[need,start,stop,try,use2],_7822,_7796,_7841),
    optional([å],_7856,_7841,_7888),
    !,
    pushstack(first,(npgap(_7703),aux1),nil,_7888,_7976),clausal_object1(_7763:coevent,_7708::_7712,_7905,_7976,_7798),
    {user:tv_template(_7702,_7703,_7763:coevent,_7705,_7711)}.

rvpk(_7702,_7703,id,_7705,_7708::_7711 and _7712,[rvpk,_7884,lit(å),{},!,_7954,_7978,{}],_7858,_7860) --> 
    optional([på],_7884,_7858,_7916),
    cc(å,_7916,_7938),
    {user:testmember(_7702,[avoid,choose,consider,deny,end,expect,forget,hate,hope,learn,like,manage,need,postpone,promise,propose,reach,recommend,refuse,remember,resist,risk,seem,slip,start,think,try,use2,want,wish,wonder])},
    !,
    accept(_7954,_7938,_7969),
    pushstack(first,(npgap(_7703),aux1),nil,_7969,_8049),clausal_object1(_7825:coevent,_7708::_7712,_7978,_8049,_7860),
    {user:tv_template(_7702,_7703,_7825:coevent,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},_7896,_7925,lit(om),_7980,_8014,_8043,!,_8072,_8096,{},_8150,{},{}],_7860,_7862) --> 
    {user:testmember(_7702,[answer,answer1,say])},
    reflexiv0(_7702,_7896,_7860,_7913),
    optional([på],_7925,_7913,_7957),
    cc(om,_7957,_7979),
    np1_accept(_7778,_7779,_7980,_7979,_7999),
    negation0(_7781,_8014,_7999,_8031),
    look_ahead_vp(_8043,_8031,_8058),
    !,
    accept(_8072,_8058,_8087),
    lexv(_7783,_7784,_7785,fin,_8096,_8087,_8119),
    {user:test(rv_templ(_7702,_7793))},
    pushstack(first,(xnp(_7778,_7779),w(verb(_7784,_7785,fin)),negation0(_7781)),nil,_8119,_8227),clausal_object1(_7812:coevent,_7708::_7712,_8150,_8227,_7862),
    {user:tv_template(_7702,_7703,_7812:coevent,_7705,_7756)},
    {user:negate(_7704,_7756,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7706,[rvpk,{},lit(om),_7845,_7884,!,_7918],_7798,_7800) --> 
    {user:testmember(_7702,[ask,worry,tell])},
    cc(om,_7798,_7844),
    np_kernel(0,_7733,_7734,_7845,_7844,_7866),
    look_ahead([som],_7884,_7866,_7901),
    !,
    pushstack(first,(w(verb(_7702,pres,fin)),w(prep(about)),np_kernel(0,_7733,_7734)),nil,_7901,_7960),
    do_phrase(_7702,_7703,_7704,_7705,_7706,_7918,_7960,_7800).

rvpk(_7702,_7703,id,_7705,_7708::_7711 and _7712,[rvpk,{},lit(om),_7834,{}],_7787,_7789) --> 
    {user:testmember(_7702,[ask,check,discuss,know,know1,see])},
    cc(om,_7787,_7833),
    clausal_object1(_7756:coevent,_7708::_7712,_7834,_7833,_7789),
    {user:tv_template(_7702,_7703,_7756:coevent,_7705,_7711)}.

rvpk(_7702,_7703,_7704,_7705,_7706,[rvpk,{},lit(om),_7836,!,_7875],_7789,_7791) --> 
    {user:testmember(_7702,[ask,worry,tell])},
    cc(om,_7789,_7835),
    np1_accept(_7729,_7730,_7836,_7835,_7855),
    !,
    pushstack(first,(w(verb(_7702,pres,fin)),w(prep(about)),xnp(_7729,_7730)),nil,_7855,_7916),
    do_phrase(_7702,_7703,_7704,_7705,_7706,_7875,_7916,_7791).

rvpk(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[rvpk,{},_7853,_7882,_7911,{},!,_7955,_7979,{}],_7817,_7819) --> 
    {user:testmember(_7702,[believe,clculate,know,know1,mean,tell,say])},
    negation0(_7704,_7853,_7817,_7870),
    reflexiv0(_7702,_7882,_7870,_7899),
    not_look_ahead([om],_7911,_7899,_7928),
    {user:test(rv_templ(_7702,_7778))},
    !,
    accept(_7955,_7928,_7970),
    clausal_object0(_7786:_7787,_7708::_7712,_7979,_7970,_7819),
    {user:tv_template(_7702,_7703,_7786:_7787,_7705,_7711)}.

clausal_object0(_7702,_7703,[clausal_object0,_7760,_7789,!,_7828],_7743,_7745) --> 
    look_ahead(w(nb(_7718,_7719)),_7760,_7743,_7777),
    obviousdate(_7702,_7703,_7789,_7777,_7808),
    !,
    accept(_7828,_7808,_7745).

clausal_object0(_7702,_7703,[clausal_object0,_7762,_7791,_7825],_7745,_7747) --> 
    not_look_ahead(w(nb(_7720,_7721)),_7762,_7745,_7779),
    np(_7711,_7712,_7791,_7779,_7810),
    cond_vp(_7711,_7712,_7702,_7703,_7825,_7810,_7747).

cond_vp(_7702,_7703,_7704,_7705,[cond_vp,_7784,{},_7823,!],_7761,_7763) --> 
    look_ahead([_7717],_7784,_7761,_7801),
    {user:testmember(_7717,[du,jeg])},
    lock(last,_7801,_7874),pushstack(last,xnp(_7702,_7703),nil,_7874,_7880),clausal_object1(_7704,_7705,_7823,_7880,_7869),unlock(_7869,_7763),
    !.

cond_vp(_7702,_7703,_7704,_7705,[cond_vp,_7775,_7804,_7828,!],_7752,_7754) --> 
    not_look_ahead([så],_7775,_7752,_7792),
    look_ahead_vp(_7804,_7792,_7819),
    pushstack(first,xnp(_7702,_7703),nil,_7819,_7872),clausal_object1(_7704,_7705,_7828,_7872,_7754),
    !.

cond_vp(_7702,_7703,_7702,_7703,[cond_vp,[]],_7730,_7730) --> 
    [].

clausal_object1(_7717:coevent,_7705::exists(_7717:coevent)::_7717 isa coevent and event/_7717/_7729 and _7715,[clausal_object1,_7776],_7759,_7761) --> 
    substatem(_7729,_7705::_7715,_7776,_7759,_7761).

clausal_object2(_7717:coevent,_7705::exists(_7717:coevent)::_7717 isa coevent and event/_7717/_7729 and _7715,[clausal_object2,_7776],_7759,_7761) --> 
    sostatem(_7729,_7705::_7715,_7776,_7759,_7761).

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7840,{},_7899,_7933,_7977,{},_8061,_8100],_7814,_7816) --> 
    hlexv(dtv,_7702,_7737,_7738,_7732,_7840,_7814,_7865),
    {user:testmember(_7702,[allow,let])},
    ind_object(_7750,_7751,_7899,_7865,_7918),
    optional([å],_7933,_7918,_7965),
    pushstack(first,(xnp(_7750,_7751),[vil]),nil,_7965,_8021),clausal_object1(_7765,_7768::_7709,_7977,_8021,_8036),
    {user:tv_template(_7702,_7703,_7765,_7705,_7780)},
    someevent00(_7705,_7780,_7708::_7768,_8061,_8036,_8082),
    negation2(_7732,_7704,_8100,_8082,_7816).

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7711 and _7712,[vp_kernel,_7882,_7926,_7955,_7984,_8013,_8042,_8076,_8105,{},_8144,{},_8188,_8232],_7856,_7858) --> 
    lexv(dtv,_7702,_7759,fin,_7882,_7856,_7905),
    not_look_ahead(w(adj2(_7766,nil)),_7926,_7905,_7943),
    not_look_ahead(w(nb(_7773,_7774)),_7955,_7943,_7972),
    not_look_ahead_lit([en,et,den,det,han,hun,vi],_7984,_7972,_8001),
    negation0(_7792,_8013,_8001,_8030),
    ind_object(_7794,_7755::_7711,_8042,_8030,_8061),
    negation0(_7800,_8076,_8061,_8093),
    not_look_ahead([så],_8105,_8093,_8122),
    {user:bigno(_7792,_7800,_7704)},
    object(_7812,_7755::_7712,_8144,_8122,_8163),
    {user:dtv_template(_7702,_7703,_7794,_7812,_7705,_7751)},
    optional([til],_8188,_8163,_8220),
    someevent00(_7705,_7751,_7708::_7755,_8232,_8220,_7858).

vp_kernel(notify,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7819,_7868,!,_7902,_7926,{},_7992],_7793,_7795) --> 
    hlexv(tv,notify,_7738,_7739,_7704,_7819,_7793,_7844),
    look_ahead(w(nb(_7746,_7747)),_7868,_7844,_7885),
    !,
    accept(_7902,_7885,_7917),
    lock(exact,_7917,_7946),pushstack(exact,[meg],nil,_7946,_7952),np0_accept(_7754,_7734::_7709,_7926,_7952,_7941),unlock(_7941,_7942),
    {user:tv_template(notify,_7703,_7754,_7705,_7730)},
    someevent00(_7705,_7730,_7708::_7734,_7992,_7942,_7795).

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7825,_7874,_7898,_7937,!,_7981,{},_8015,[]],_7799,_7801) --> 
    lexvaccept(tv,_7702,_7744,fin,_7704,_7825,_7799,_7850),
    redundant0(_7874,_7850,_7889),
    adverbx(_7738,_7739,_7740,_7898,_7889,_7919),
    object2(_7703,_7753,_7756::_7709,_7937,_7919,_7958),
    !,
    accept(_7981,_7958,_7996),
    {user:tv_template(_7702,_7703,_7753,_7705,_7765)},
    someevent00(_7705,_7765,_7708::_7756,_8015,_7996,_8036),
    pushstack(free,adverbx(_7738,_7739,_7740),nil,_8036,_7801),
    [].

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7870,_7919,_7948,{},{},{},{},{},!,_8042,{},_8076],_7844,_7846) --> 
    hlexv(tv,_7702,_7753,_7754,_7704,_7870,_7844,_7895),
    not_look_ahead_lit([om,hver],_7919,_7895,_7936),
    object2(_7703,_7764,_7749::_7709,_7948,_7936,_7969),
    {user:(\+constrain(_7764,date);_7702==have)},
    {user:(\+constrain(_7764,distance))},
    {user:(\+constrain(_7764,minute))},
    {user:(\+constrain(_7764,hour))},
    {user:(\+constrain(_7764,clock))},
    !,
    accept(_8042,_7969,_8057),
    {user:tv_template(_7702,_7703,_7764,_7705,_7745)},
    someevent00(_7705,_7745,_7708::_7749,_8076,_8057,_7846).

vp_kernel(_7702,_7703,_7704,_7705,_7706,[vp_kernel,_7814,_7863,{},{},!,_7922,_7946,_7970,_7999],_7788,_7790) --> 
    hlexv(iv,_7702,_7738,fin,_7704,_7814,_7788,_7839),
    gmem(_7702,[run,pass],_7863,_7839,_7882),
    {user:iv_template(_7702,_7703,_7705,_7733)},
    {user:_7738\==imp},
    !,
    redundants0(_7922,_7882,_7937),
    it0(_7946,_7937,_7961),
    reflexiv0(_7702,_7970,_7961,_7987),
    someevent00(_7705,_7733,_7706,_7999,_7987,_7790).

vp_kernel(have,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7857,_7886,_7910,{},_7949,lit(om),_7989,!,_8023,{},_8076],_7831,_7833) --> 
    negation0(_7748,_7857,_7831,_7874),
    has(_7886,_7874,_7901),
    negation0(_7750,_7910,_7901,_7927),
    {user:bigno(_7748,_7750,_7704)},
    w(noun(information,sin,u,n),_7949,_7927,_7966),
    cc(om,_7966,_7988),
    not_look_ahead_lit([når,å,at],_7989,_7988,_8006),
    !,
    pushstack(first,(w(noun(information,sin,u,n)),w(prep(regarding))),nil,_8006,_8036),np1(_7785,_7746::_7709,_8023,_8036,_8051),
    {user:tv_template(have,_7703,_7785,_7705,_7742)},
    someevent00(_7705,_7742,_7708::_7746,_8076,_8051,_7833).

vp_kernel(have,_7703,_7704,_7705,_7706,[vp_kernel,_7802,_7831,_7855,{},!,_7899],_7776,_7778) --> 
    negation0(_7704,_7802,_7776,_7819),
    has(_7831,_7819,_7846),
    w(adj2(_7728,nil),_7855,_7846,_7872),
    {user:testmember(_7728,[open,closed])},
    !,
    pushstack(first,w(adj2(_7728,nil)),nil,_7872,_7909),
    be_complement(_7703,_7705,_7706,_7899,_7909,_7778).

vp_kernel(have,_7703,_7704,_7705,_7706,[vp_kernel,_7802,lit(det),_7837,_7866,_7895,!,_7944],_7776,_7778) --> 
    has(_7802,_7776,_7817),
    cc(det,_7817,_7836),
    negation0(_7704,_7837,_7836,_7854),
    w(adj2(_7731,nil),_7866,_7854,_7883),
    optional([da],_7895,_7883,_7927),
    !,
    pushstack(first,w(adj2(_7731,nil)),nil,_7927,_7954),
    be_complement(_7703,_7705,_7706,_7944,_7954,_7778).

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7871,_7900,_7929,_7978,{},{},_8027,_8056,_8085,_8109,!,_8153,{},_8187,_8226],_7845,_7847) --> 
    not_look_ahead(w(verb(have,_7761,_7762)),_7871,_7845,_7888),
    not_look_ahead(w(verb(be2,_7769,_7770)),_7900,_7888,_7917),
    hlexv(tv,_7702,_7774,_7775,_7753,_7929,_7917,_7954),
    not_look_ahead(w(prep(_7782)),_7978,_7954,_7995),
    {user:_7702\==have},
    {user:_7702\==be2},
    reflexiv0(_7702,_8027,_7995,_8044),
    particle0(_7702,_8056,_8044,_8073),
    redundant0(_8085,_8073,_8100),
    object2(_7703,_7799,_7802::_7709,_8109,_8100,_8130),
    !,
    accept(_8153,_8130,_8168),
    {user:tv_template(_7702,_7703,_7799,_7705,_7811)},
    someevent00(_7705,_7811,_7708::_7802,_8187,_8168,_8208),
    negation2(_7753,_7704,_8226,_8208,_7847).

menbare([menbare,lit(men)],_7719,_7721) --> 
    cc(men,_7719,_7721).

menbare([menbare,lit(bare)],_7719,_7721) --> 
    cc(bare,_7719,_7721).

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7881,_7910,_7939,{},{},{},_8018,_8057,_8086,{},_8135,_8174,[]],_7855,_7857) --> 
    not_look_ahead(w(verb(have,_7758,_7759)),_7881,_7855,_7898),
    not_look_ahead(w(verb(be2,_7766,_7767)),_7910,_7898,_7927),
    hlexv(tv,_7702,_7771,_7772,_7773,_7939,_7927,_7964),
    {user:_7702\==have},
    {user:_7702\==be2},
    {user:(\+verbtype(_7702,iv))},
    adverb(_7750,_7751,pre,_8018,_7964,_8039),
    not_look_ahead(w(noun(night,_7801,_7802,_7803)),_8057,_8039,_8074),
    object2(_7703,_7806,_7809::_7709,_8086,_8074,_8107),
    {user:tv_template(_7702,_7703,_7806,_7705,_7818)},
    someevent00(_7705,_7818,_7708::_7809,_8135,_8107,_8156),
    negation2(_7773,_7704,_8174,_8156,_8193),
    pushstack(free,xadverb(_7750,_7751),nil,_8193,_7857),
    [].

vp_kernel(be1,_7703,_7704,_7705,_7706,[vp_kernel,_7811,_7835,_7864,{},{},_7913,[]],_7785,_7787) --> 
    be(_7811,_7785,_7826),
    negation0(_7704,_7835,_7826,_7852),
    look_ahead(w(noun(_7739,_7740,_7741,_7742)),_7864,_7852,_7881),
    {user:subclass0(_7739,time)},
    {user:iv_template(be1,_7703,_7705,_7754)},
    someevent00(_7705,_7754,_7706,_7913,_7881,_7934),
    pushstack(free,w(prep(on)),nil,_7934,_7787),
    [].

vp_kernel(be1,_7703,id,_7705,_7706,[vp_kernel,_7813,{},_7847,{},{},_7896,[]],_7787,_7789) --> 
    be(_7813,_7787,_7828),
    {user:vartypeid(_7703,self)},
    look_ahead(w(name(_7742,n,_7744)),_7847,_7828,_7864),
    {user:subclass0(_7744,place)},
    {user:iv_template(be1,_7703,_7705,_7756)},
    someevent00(_7705,_7756,_7706,_7896,_7864,_7917),
    pushstack(free,w(prep(in)),nil,_7917,_7789),
    [].

vp_kernel(be1,_7703,_7704,_7705,_7706,[vp_kernel,_7787,_7811,_7840,{},_7874,_7898],_7761,_7763) --> 
    be(_7787,_7761,_7802),
    negation0(_7704,_7811,_7802,_7828),
    not_look_ahead_np(_7840,_7828,_7855),
    {user:iv_template(be1,_7703,_7705,_7724)},
    redundant0(_7874,_7855,_7889),
    someevent00(_7705,_7724,_7706,_7898,_7889,_7763).

vp_kernel(be1,_7703,_7704,_7705,_7706,[vp_kernel,_7807,_7831,_7860,{},!,{},_7914],_7781,_7783) --> 
    be(_7807,_7781,_7822),
    negation0(_7704,_7831,_7822,_7848),
    look_ahead(w(adv(_7736)),_7860,_7848,_7877),
    {user:testmember(_7736,[redundantly,inside,outside])},
    !,
    {user:iv_template(be1,_7703,_7705,_7727)},
    someevent00(_7705,_7727,_7706,_7914,_7877,_7783).

vp_kernel(be1,_7703,_7704,_7705,_7706,[vp_kernel,_7805,_7829,_7858,{},{},_7907,_7931],_7779,_7781) --> 
    be(_7805,_7779,_7820),
    negation0(_7704,_7829,_7820,_7846),
    look_ahead([_7733],_7858,_7846,_7875),
    {user:testmember(_7733,[her,der,overalt])},
    {user:iv_template(be1,_7703,_7705,_7727)},
    redundant0(_7907,_7875,_7922),
    someevent00(_7705,_7727,_7706,_7931,_7922,_7781).

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7851,{},_7890,_7919,_7953,_7982,_8006,_8035,{},_8084,_8123,!,_8162],_7825,_7827) --> 
    w(verb(_7749,_7750,fin),_7851,_7825,_7868),
    {user:testmember(_7749,[have])},
    negation0(_7760,_7890,_7868,_7907),
    particlev2(_7749,_7702,_7919,_7907,_7938),
    reflexiv0(_7702,_7953,_7938,_7970),
    redundant0(_7982,_7970,_7997),
    not_look_ahead(w(verb(_7771,past,part)),_8006,_7997,_8023),
    object2(_7703,_7776,_7779::_7709,_8035,_8023,_8056),
    {user:tv_template(_7702,_7703,_7776,_7705,_7788)},
    someevent00(_7705,_7788,_7708::_7779,_8084,_8056,_8105),
    negation2(_7760,_7704,_8123,_8105,_8142),
    !,
    accept(_8162,_8142,_7827).

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7862,{},!,_7921,_7950,_7999,_8028,_8052,{},_8101,!,_8145,[]],_7836,_7838) --> 
    lexv(tv,_7702,_7764,_7765,_7862,_7836,_7885),
    {user:testmember(_7702,[lay])},
    !,
    negation0(_7704,_7921,_7885,_7938),
    verb_mod1(_7702,_7754,_7705,_7756,_7759::_7760,_7950,_7938,_7975),
    particle(_7702,_7999,_7975,_8016),
    redundant0(_8028,_8016,_8043),
    object2(_7703,_7788,_7791::_7709,_8052,_8043,_8073),
    {user:tv_template(_7702,_7703,_7788,_7705,_7800)},
    someevent00(_7705,_7800,_7708::_7791,_8101,_8073,_8122),
    !,
    accept(_8145,_8122,_8160),
    pushstack(free,(particle(_7702),verb_mod1(_7702,_7754,_7705,_7756,_7759::_7760)),nil,_8160,_7838),
    [].

vp_kernel(evah,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7801,_7845,_7874,{},_7923],_7775,_7777) --> 
    lexv(tv,evah,_7732,fin,_7801,_7775,_7824),
    negation0(_7704,_7845,_7824,_7862),
    subject2(_7703,_7738,_7741::_7724,_7874,_7862,_7895),
    {user:has_template(_7738,_7703,_7741)},
    someevent00(_7705,_7724,_7708::_7709,_7923,_7895,_7777).

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7709,[vp_kernel,_7830,{},_7889,{},_7928,_7952,{},_8001,_8040],_7804,_7806) --> 
    hlexv(tv,_7702,_7740,_7741,_7735,_7830,_7804,_7855),
    {user:_7702==be2},
    reflexiv0(_7702,_7889,_7855,_7906),
    {user:compliancetest2(tv,_7702,_7703)},
    redundant0(_7928,_7906,_7943),
    object2(_7703,_7758,_7761::_7709,_7952,_7943,_7973),
    {user:tv_template(_7702,_7703,_7758,_7705,_7770)},
    someevent00(_7705,_7770,_7708::_7761,_8001,_7973,_8022),
    negation2(_7735,_7704,_8040,_8022,_7806).

vp_kernel(_7702,_7703,_7704,_7705,_7706,[vp_kernel,_7801,{},{},_7870,_7894,_7918,_7947],_7775,_7777) --> 
    hlexv(iv,_7702,_7732,fin,_7704,_7801,_7775,_7826),
    {user:iv_template(_7702,_7703,_7705,_7727)},
    {user:_7732\==imp},
    redundants0(_7870,_7826,_7885),
    it0(_7894,_7885,_7909),
    reflexiv0(_7702,_7918,_7909,_7935),
    someevent00(_7705,_7727,_7706,_7947,_7935,_7777).

vp_kernel(_7702,_7703,_7704,_7705,_7708::_7709,[vp_kernel,{},_7853,lit(_7750),{},_7903,!,_7937,_8005,_8039],_7817,_7819) --> 
    {user:constrain(_7703,person)},
    not_look_ahead([kan],_7853,_7817,_7870),
    cc(_7750,_7870,_7892),
    {user:testmember(_7750,[må,skal,vil])},
    not_look_ahead(w(verb(_7768,_7769,_7770)),_7903,_7892,_7920),
    !,
    pushstack(first,w(verb(arrive,pres,fin)),nil,_7920,_7950),intrans_verb(_7702,_7703,_7783,_7705,_7736,_7786,_7787,_7937,_7950,_7975),
    negation2(_7783,_7704,_8005,_7975,_8024),
    someevent00(_7705,_7736,_7708::_7709,_8039,_8024,_7819).

worldcomp(_7702,_7703,event/_7702/_7703::_7705,_7705,[worldcomp,[]],_7739,_7739) --> 
    [].

realcomp(_7702,event/real/_7702::_7704,_7704,[realcomp,[]],_7736,_7736) --> 
    [].

someevent00(_7702,_7703,_7706::exists(_7702:event)::_7703 and _7706,[someevent00,[]],_7741,_7741) --> 
    [].

thatto0(_7702,that,_7704,[thatto0,_7758,!,[]],_7738,_7740) --> 
    infinitive(_7758,_7738,_7773),
    !,
    pushstack(free,npgap(_7704),nil,_7773,_7740),
    [].

thatto0(_7702,_7703,_7704,[thatto0,_7757,!,_7791],_7737,_7739) --> 
    w(prep(on),_7757,_7737,_7774),
    !,
    reject(_7791,_7774,_7739).

thatto0(_7702,_7703,_7704,[thatto0,lit(om),_7777,!,_7811],_7746,_7748) --> 
    cc(om,_7746,_7776),
    look_ahead(w(name(_7721,_7722,_7723)),_7777,_7776,_7794),
    !,
    reject(_7811,_7794,_7748).

thatto0(_7702,_7703,_7704,[thatto0,lit(om),_7778,!,_7812],_7747,_7749) --> 
    cc(om,_7747,_7777),
    look_ahead(w(noun(departure,_7722,_7723,n)),_7778,_7777,_7795),
    !,
    reject(_7812,_7795,_7749).

that0(_7702,that,[that0,lit(på),!,_7765],_7732,_7734) --> 
    cc(på,_7732,_7759),
    !,
    reject(_7765,_7759,_7734).

that0(_7702,when,[that0,_7806,lit(når),_7851,_7880,!,_7919,[],!,_7993],_7789,_7791) --> 
    gmem(_7702,[know,know1,think,ask,notify,tell],_7806,_7789,_7825),
    cc(når,_7825,_7850),
    w(verb(_7748,_7749,fin),_7851,_7850,_7868),
    np1(_7752,_7753,_7880,_7868,_7899),
    !,
    accept(_7919,_7899,_7934),
    pushstack(free,(xnp(_7752,_7753),w(verb(_7748,_7749,fin))),nil,_7934,_7987),[],
    !,
    accept(_7993,_7987,_7791).

that0(ask,that,[that0,_7749],_7732,_7734) --> 
    look_ahead(w(verb(_7709,inf,_7711)),_7749,_7732,_7734).

that0(answer,whether,[that0,_7746,lit(om)],_7729,_7731) --> 
    on0(_7746,_7729,_7761),
    cc(om,_7761,_7731).

that0(ask,that,[that0,lit(om),_7763,!,_7792],_7735,_7737) --> 
    cc(om,_7735,_7762),
    infinitive(_7763,_7762,_7778),
    !,
    accept(_7792,_7778,_7737).

that0(ask,whether,[that0,lit(om),!,_7765],_7732,_7734) --> 
    cc(om,_7732,_7759),
    !,
    accept(_7765,_7759,_7734).

that0(ask,that,[that0,_7747,!,_7776],_7730,_7732) --> 
    infinitive(_7747,_7730,_7762),
    !,
    accept(_7776,_7762,_7732).

that0(believe,that,[that0,lit(at),!],_7729,_7731) --> 
    cc(at,_7729,_7731),
    !.

that0(believe,that,[that0,[]],_7724,_7724) --> 
    [].

that0(know,whether,[that0,lit(om),!],_7729,_7731) --> 
    cc(om,_7729,_7731),
    !.

that0(know,that,[that0,lit(at),!],_7729,_7731) --> 
    cc(at,_7729,_7731),
    !.

that0(know,that,[that0,_7757,_7786],_7740,_7742) --> 
    not_look_ahead([en],_7757,_7740,_7774),
    not_look_ahead(w(noun(_7712,_7713,_7714,_7715)),_7786,_7774,_7742).

that0(know1,whether,[that0,lit(om),!],_7729,_7731) --> 
    cc(om,_7729,_7731),
    !.

that0(know1,that,[that0,lit(at),!],_7729,_7731) --> 
    cc(at,_7729,_7731),
    !.

that0(know1,that,[that0,_7757,_7786],_7740,_7742) --> 
    not_look_ahead([en],_7757,_7740,_7774),
    not_look_ahead(w(noun(_7712,_7713,_7714,_7715)),_7786,_7774,_7742).

that0(let,that,[that0,[]],_7724,_7724) --> 
    [].

that0(mean,that,[that0,lit(at),!],_7729,_7731) --> 
    cc(at,_7729,_7731),
    !.

that0(mean,that,[that0,[]],_7724,_7724) --> 
    [].

that0(notify,that,[that0,lit(at)],_7726,_7728) --> 
    cc(at,_7726,_7728).

that0(notify,that,[that0,lit(om),lit(at),!,_7781],_7737,_7739) --> 
    cc(om,_7737,_7764),
    cc(at,_7764,_7775),
    !,
    accept(_7781,_7775,_7739).

that0(notify,_7703,[that0,lit(om),!,_7765],_7732,_7734) --> 
    cc(om,_7732,_7759),
    !,
    reject(_7765,_7759,_7734).

that0(say,that,[that0,lit(at),!],_7729,_7731) --> 
    cc(at,_7729,_7731),
    !.

that0(say,that,[that0,[]],_7724,_7724) --> 
    [].

that0(tell,that,[that0,_7751,!,_7785],_7734,_7736) --> 
    look_ahead([et],_7751,_7734,_7768),
    !,
    reject(_7785,_7768,_7736).

that0(tell,that,[that0,_7751,!,_7785],_7734,_7736) --> 
    look_ahead([en],_7751,_7734,_7768),
    !,
    reject(_7785,_7768,_7736).

that0(tell,that,[that0,lit(at),!],_7729,_7731) --> 
    cc(at,_7729,_7731),
    !.

that0(think,that,[that0,lit(at),!],_7729,_7731) --> 
    cc(at,_7729,_7731),
    !.

that0(think,that,[that0,[]],_7724,_7724) --> 
    [].

that0(understand,how,[that0,lit(hvordan)],_7726,_7728) --> 
    cc(hvordan,_7726,_7728).

that0(want,that,[that0,lit(at),!],_7729,_7731) --> 
    cc(at,_7729,_7731),
    !.

that0(want,to,[that0,lit(og)],_7726,_7728) --> 
    cc(og,_7726,_7728).

that0(wish,that,[that0,_7749],_7732,_7734) --> 
    look_ahead(w(verb(_7709,_7710,_7711)),_7749,_7732,_7734).

that0(_7702,_7703,[that0,_7761,!,_7795,_7824],_7744,_7746) --> 
    that(_7703,_7761,_7744,_7778),
    !,
    not_look_ahead(w(noun(departure,_7721,_7722,_7723)),_7795,_7778,_7812),
    accept(_7824,_7812,_7746).

rep_modifiers0(_7702,_7703,_7704,_7705,_7706,[rep_modifiers0,lit(hvor),!,_7783],_7741,_7743) --> 
    cc(hvor,_7741,_7777),
    !,
    reject(_7783,_7777,_7743).

rep_modifiers0(_7702,_7703,_7704,_7705,_7706,[rep_modifiers0,lit(hva),!,_7783],_7741,_7743) --> 
    cc(hva,_7741,_7777),
    !,
    reject(_7783,_7777,_7743).

rep_modifiers0(_7702,_7703,_7704,_7705,_7706,[rep_modifiers0,{},_7804,{},_7843],_7768,_7770) --> 
    {user:testmember(_7702,[see])},
    look_ahead(w(prep(_7734)),_7804,_7768,_7821),
    {user:testmember(_7734,[in])},
    verb_modifier(_7702,_7703,_7704,_7705,_7706,_7843,_7821,_7770).

rep_modifiers0(_7702,_7703,_7704,_7705,_7706,[rep_modifiers0,{},_7797,_7826],_7761,_7763) --> 
    {user:testmember(_7702,[say,tell])},
    prep1(to,_7797,_7761,_7814),
    pushstack(first,prep(to),nil,_7814,_7866),
    verb_modifiers(_7702,_7703,_7704,_7705,_7706,_7826,_7866,_7763).

rep_modifiers0(_7702,_7703,_7704,_7705,_7705,[rep_modifiers0,[]],_7733,_7733) --> 
    [].

be_complements(_7702,_7703,_7706::_7709 and _7710,[be_complements,lit(at),_7801,!,_7835,_7859,{}],_7770,_7772) --> 
    cc(at,_7770,_7800),
    look_ahead(w(prep(_7741)),_7801,_7800,_7818),
    !,
    preadverbials(_7835,_7818,_7850),
    clausal_object2(_7730,_7706::_7710,_7859,_7850,_7772),
    {user:bealign(_7702,_7730,_7703,_7710,_7709)}.

be_complements(_7702,_7703,_7706::_7709 and _7710,[be_complements,lit(at),!,_7797,_7821,{}],_7761,_7763) --> 
    cc(at,_7761,_7791),
    !,
    accept(_7797,_7791,_7812),
    clausal_object1(_7727,_7706::_7710,_7821,_7812,_7763),
    {user:bealign(_7702,_7727,_7703,_7710,_7709)}.

be_complements(_7702,_7703,_7706::_7709 and _7710,[be_complements,lit(å),!,_7800,_7824,{}],_7764,_7766) --> 
    cc(å,_7764,_7794),
    !,
    accept(_7800,_7794,_7815),
    pushstack(first,someone,nil,_7815,_7865),clausal_object1(_7727,_7706::_7710,_7824,_7865,_7766),
    {user:bealign(_7702,_7727,_7703,_7710,_7709)}.

be_complements(_7702,_7703,_7704,[be_complements,_7765,_7804],_7745,_7747) --> 
    be_complement(_7702,_7703,_7718::_7719,_7765,_7745,_7786),
    be_complements20(_7702,_7703,_7718::_7719,_7704,_7804,_7786,_7747).

be_complements20(_7702,_7703,_7707::_7710,_7707::_7710 or _7711,[be_complements20,lit(eller),_7811,!,_7845,_7884],_7777,_7779) --> 
    cc(eller,_7777,_7810),
    not_look_ahead_lit(['.',?],_7811,_7810,_7828),
    !,
    be_complement(_7702,_7703,_7707::_7749,_7845,_7828,_7866),
    be_complements20(_7702,_7703,_7707::_7749,_7707::_7711,_7884,_7866,_7779).

be_complements20(_7702,_7703,_7707::_7710,_7707::_7710 and _7711,[be_complements20,_7780,_7804,_7843],_7757,_7759) --> 
    be_compl_conjunction(_7780,_7757,_7795),
    be_pred(_7702,_7703,_7724,_7804,_7795,_7825),
    be_complements20(_7702,_7703,_7724,_7707::_7711,_7843,_7825,_7759).

be_complements20(_7702,_7703,_7704,_7704,[be_complements20,_7753],_7730,_7732) --> 
    redundant0(_7753,_7730,_7732).

be_compl_conjunction([be_compl_conjunction,lit(og),!],_7722,_7724) --> 
    cc(og,_7722,_7724),
    !.

be_compl_conjunction([be_compl_conjunction,lit(men),_7755,!],_7733,_7735) --> 
    cc(men,_7733,_7754),
    look_ahead(w(verb(_7714,past,part)),_7755,_7754,_7735),
    !.

be_complement(_7702,_7703,_7704,[be_complement,_7760,_7789],_7740,_7742) --> 
    not_look_ahead_lit([der,her],_7760,_7740,_7777),
    be_pred(_7702,_7703,_7704,_7789,_7777,_7742).

be_complement(_7702,_7703,_7704,[be_complement,_7760,_7789],_7740,_7742) --> 
    not_look_ahead_lit([der,her],_7760,_7740,_7777),
    be_noun(_7702,_7703,_7704,_7789,_7777,_7742).

be_pred(_7702,_7703,_7704,[be_pred,_7784,{},_7838,_7862],_7764,_7766) --> 
    ap(_7721,_7702,_7703,_7718,_7784,_7764,_7807),
    {user:(\+testmember(_7721,[true,whole]))},
    not_look_ahead_nounx(_7838,_7807,_7853),
    verb_modifiers0(adj/nil/_7721,_7702,_7703,_7718,_7704,_7862,_7853,_7766).

be_pred(_7702,_7703,_7704,[be_pred,_7771,_7800,{}],_7751,_7753) --> 
    look_ahead(w(prep(_7722)),_7771,_7751,_7788),
    verb_mod1(be1,_7702,_7703,_7714,_7715,_7800,_7788,_7753),
    {user:thenwhat(_7714,_7715,_7704)}.

be_pred(_7702,_7703,_7704,[be_pred,_7838,_7867,_7896,{},_7935,_8001],_7818,_7820) --> 
    w(nb(_7739,num),_7838,_7818,_7855),
    w(noun(percent,_7733,u,n),_7867,_7855,_7884),
    w(adj2(_7751,nil),_7896,_7884,_7913),
    {user:testmember(_7751,[certain,safe])},
    lock(exact,_7913,_7955),pushstack(exact,w(adj2(_7751,nil)),nil,_7955,_7961),ap(_7751,_7702,_7703,_7774,_7935,_7961,_7950),unlock(_7950,_7951),
    pushstack(first,(w(prep(with)),w(nb(_7739,num)),w(noun(percent,_7733,u,n))),nil,_7951,_8011),
    verb_modifiers0(adj/nil/_7751,_7702,_7703,_7774,_7704,_8001,_8011,_7820).

be_pred(_7702,_7703,_7704,[be_pred,_7831,_7855,_7879,!,_7913,{},_7952,_8018],_7811,_7813) --> 
    ofte0(_7831,_7811,_7846),
    mangenoen(_7855,_7846,_7870),
    w(noun(minute,_7743,u,n),_7879,_7870,_7896),
    !,
    w(adj2(_7749,nil),_7913,_7896,_7930),
    {user:testmember(_7749,[delayed,tooearly])},
    lock(exact,_7930,_7972),pushstack(exact,w(adj2(_7749,nil)),nil,_7972,_7978),ap(_7749,_7702,_7703,_7772,_7952,_7978,_7967),unlock(_7967,_7968),
    pushstack(first,(w(prep(with)),w(noun(minute,plu,u,n))),nil,_7968,_8028),
    verb_modifiers0(adj/nil/_7749,_7702,_7703,_7772,_7704,_8018,_8028,_7813).

ofte0([ofte0,lit(ofte)],_7719,_7721) --> 
    cc(ofte,_7719,_7721).

ofte0([ofte0,[]],_7717,_7717) --> 
    [].

mangenoen([mangenoen,lit(mange)],_7719,_7721) --> 
    cc(mange,_7719,_7721).

mangenoen([mangenoen,lit(flere)],_7719,_7721) --> 
    cc(flere,_7719,_7721).

mangenoen([mangenoen,lit(noen)],_7719,_7721) --> 
    cc(noen,_7719,_7721).

be_pred(_7702,_7703,_7704,[be_pred,_7838,_7867,_7896,{},_7935,_8001],_7818,_7820) --> 
    w(nb(_7739,num),_7838,_7818,_7855),
    w(noun(minute,_7733,u,n),_7867,_7855,_7884),
    w(adj2(_7751,nil),_7896,_7884,_7913),
    {user:testmember(_7751,[delayed,tooearly])},
    lock(exact,_7913,_7955),pushstack(exact,w(adj2(_7751,nil)),nil,_7955,_7961),ap(_7751,_7702,_7703,_7774,_7935,_7961,_7950),unlock(_7950,_7951),
    pushstack(first,(w(prep(with)),w(nb(_7739,num)),w(noun(minute,_7733,u,n))),nil,_7951,_8011),
    verb_modifiers0(adj/nil/_7751,_7702,_7703,_7774,_7704,_8001,_8011,_7820).

be_pred(_7702,_7703,_7704,[be_pred,lit(mer),_7798,_7827,_7893],_7767,_7769) --> 
    cc(mer,_7767,_7797),
    look_ahead([enn],_7798,_7797,_7815),
    lock(exact,_7815,_7847),pushstack(exact,w(adj2(great,nil)),nil,_7847,_7853),ap(_7735,_7702,_7703,_7718,_7827,_7853,_7842),unlock(_7842,_7843),
    verb_modifiers0(adj/nil/_7735,_7702,_7703,_7718,_7704,_7893,_7843,_7769).

be_pred(_7702,_7703,_7706::_7707,[be_pred,_7757],_7737,_7739) --> 
    passive(_7702,_7703,_7706::_7707,_7757,_7737,_7739).

be_pred(_7702,_7703,_7704,[be_pred,_7758,_7797],_7738,_7740) --> 
    comparisons(_7702,_7703,_7710,_7758,_7738,_7779),
    someevent00(_7703,_7710,_7704,_7797,_7779,_7740).

be_pred(_7702,_7703,_7706::_7707,[be_pred,_7771,_7795],_7751,_7753) --> 
    sure(_7771,_7751,_7786),
    pushstack(first,w(verb(know,pres,fin)),nil,_7786,_7805),
    do_phrase(know,_7702,id,_7703,_7706::_7707,_7795,_7805,_7753).

be_pred(_7702,_7703,_7704,[be_pred,_7795,_7839,{},_7878],_7775,_7777) --> 
    ap(_7722,_7702,_7703,_7725,_7795,_7775,_7818),
    look_ahead([hva],_7839,_7818,_7856),
    {user:(\+testmember(_7722,[true,whole]))},
    pushstack(first,w(prep(on)),nil,_7856,_7888),
    verb_modifiers0(adj/nil/_7722,_7702,_7703,_7725,_7704,_7878,_7888,_7777).

fordent0(_7702,[fordent0,_7740,!],_7726,_7728) --> 
    gradverb(_7702,_7740,_7726,_7728),
    !.

fordent0(nil,[fordent0,_7735],_7721,_7723) --> 
    dent0(_7735,_7721,_7723).

not_look_ahead_nounx([not_look_ahead_nounx,_7740,!],_7729,_7731) --> 
    look_ahead(w(noun(clock,sin,def,n)),_7740,_7729,_7731),
    !.

not_look_ahead_nounx([not_look_ahead_nounx,_7737],_7726,_7728) --> 
    not_look_ahead(w(noun(_7706,_7707,_7708,_7709)),_7737,_7726,_7728).

be_noun(_7702,_7703,_7706::exists(_7703:event)::_7710,[be_noun,lit(at),_7794,{},!],_7763,_7765) --> 
    cc(at,_7763,_7793),
    clausal_object1(_7728,_7706::_7732,_7794,_7793,_7765),
    {user:bealign(_7702,_7728,_7703,_7732,_7710)},
    !.

be_noun(_7702,_7703,_7706::exists(_7703:event)::_7710,[be_noun,_7813,_7842,{},!,_7900],_7793,_7795) --> 
    look_ahead(w(nb(_7742,_7743)),_7813,_7793,_7830),
    pushstack(first,w(noun(clock,sin,def,n)),nil,_7830,_7855),obviousclock(_7755,_7758::_7759,_7842,_7855,_7870),
    {user:bealign(_7702,_7755,_7703,_7759,_7767)},
    !,
    verb_modifiers0(exist,_7702,_7703,_7758::_7767,_7706::_7710,_7900,_7870,_7795).

be_noun(_7702,_7703,_7706::exists(_7703:event)::_7710,[be_noun,_7803,_7827,{},_7871,!,_7920],_7783,_7785) --> 
    redundant0(_7803,_7783,_7818),
    object(_7741,_7744::_7745,_7827,_7818,_7846),
    {user:bealign(_7702,_7741,_7703,_7745,_7753)},
    optional([bare],_7871,_7846,_7903),
    !,
    verb_modifiers0(exist,_7702,_7703,_7744::_7753,_7706::_7710,_7920,_7903,_7785).

ap(_7702,_7703,_7704,_7705,[ap,_7771,_7795,_7839,_7863],_7748,_7750) --> 
    mthe10(_7771,_7748,_7786),
    adj1s(_7702,_7703,_7704,_7717,_7795,_7786,_7818),
    redundant0(_7839,_7818,_7854),
    someevent00(_7704,_7717,_7705,_7863,_7854,_7750).

ap(_7702,_7703,_7704,_7705,[ap,_7794,{},{},_7843],_7771,_7773) --> 
    w(verb(_7702,past,part),_7794,_7771,_7811),
    {user:(\+testmember(_7702,[be,have]))},
    {user:adj_template(nil,be/_7702,_7703,_7704,_7717)},
    someevent00(_7704,_7717,_7705,_7843,_7811,_7773).

mthe10([mthe10,lit(mye)],_7719,_7721) --> 
    cc(mye,_7719,_7721).

mthe10([mthe10,_7728],_7717,_7719) --> 
    the0(_7728,_7717,_7719).

passive(_7702,_7703,_7704,[passive,_7838,_7867,_7901,{},_7955,!,_7994],_7818,_7820) --> 
    w(noun(_7741,sin,u,n),_7838,_7818,_7855),
    gmem(_7741,[video,camera],_7867,_7855,_7886),
    lexv(tv,_7761,_7762,part,_7901,_7886,_7924),
    {user:(\+testmember(_7761,[be2,have]))},
    whodidit(_7776,_7777,_7955,_7924,_7974),
    !,
    pushstack(first,(np(_7776,_7777),w(verb(_7761,_7762,fin)),npgap(_7702),w(prep(by)),w(noun(_7741,sin,u,n))),nil,_7974,_8065),
    state(_7703,_7704,_7994,_8065,_7820).

passive(_7702,_7703,_7704,[passive,_7815,{},_7869,_7898,!,_7937],_7795,_7797) --> 
    lexv(dtv,_7733,past,part,_7815,_7795,_7838),
    {user:(\+testmember(_7733,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_7756,_7757)),_7869,_7838,_7886),
    whodidit(_7759,_7760,_7898,_7886,_7917),
    !,
    pushstack(first,(np(_7759,_7760),w(verb(_7733,past,fin)),npgap(_7702)),nil,_7917,_8008),
    state(_7703,_7704,_7937,_8008,_7797).

passive(_7702,_7703,_7704,[passive,_7827,{},_7881,_7910,_7944,!,_7983],_7807,_7809) --> 
    lexv(dtv,_7740,_7741,part,_7827,_7807,_7850),
    {user:(\+testmember(_7740,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_7763,_7764)),_7881,_7850,_7898),
    ind_object(_7736,_7737,_7910,_7898,_7929),
    whodidit(_7769,_7770,_7944,_7929,_7963),
    !,
    pushstack(free,(np(_7769,_7770),w(verb(_7740,_7741,fin)),npgap(_7702),noun_phrase1(_7736,_7737)),nil,_7963,_8085),
    state(_7703,_7704,_7983,_8085,_7809).

passive(_7702,_7703,_7706::_7707,[passive,_7805,lit(om),_7860,!,_7899],_7785,_7787) --> 
    lexv(tv,notify,past,part,_7805,_7785,_7828),
    cc(om,_7828,_7859),
    whodidit(_7742,_7743,_7860,_7859,_7879),
    !,
    lock(last,_7879,_7977),
    pushstack(last,(xnp(_7742,_7743),w(verb(notify,pres,fin)),w(prep(regarding)),npgap(_7702)),nil,_7977,_7983),
    state(_7703,_7706::_7707,_7899,_7983,_7972),
    unlock(_7972,_7787).

passive(_7702,_7703,_7704,[passive,_7818,!,_7862,{},_7916,!,_7955],_7798,_7800) --> 
    adverbial1(_7736,_7737,_7738,_7818,_7798,_7839),
    !,
    lexv(tv,_7745,_7746,part,_7862,_7839,_7885),
    {user:(\+testmember(_7745,[be2,have]))},
    whodidit(_7760,_7761,_7916,_7885,_7935),
    !,
    pushstack(first,(np(_7760,_7761),w(verb(_7745,_7746,fin)),npgap(_7702),adverbial1(_7736,_7737,_7738)),nil,_7935,_8058),
    state(_7703,_7704,_7955,_8058,_7800).

passive(_7702,_7703,_7704,[passive,_7810,{},_7864,_7898,_7922,!,_7961],_7790,_7792) --> 
    lexv(tv,_7736,_7737,part,_7810,_7790,_7833),
    {user:(\+testmember(_7736,[be2,have]))},
    particlev0(_7736,_7752,_7864,_7833,_7883),
    redundant0(_7898,_7883,_7913),
    whodidit(_7754,_7755,_7922,_7913,_7941),
    !,
    pushstack(first,(np(_7754,_7755),w(verb(_7752,_7737,fin)),npgap(_7702)),nil,_7941,_8032),
    state(_7703,_7704,_7961,_8032,_7792).

passive(_7702,_7703,_7704,[passive,_7849,{},_7903,lit(og),_7938,{},!,_8002,!,_8041],_7829,_7831) --> 
    lexv(tv,_7751,past,part,_7849,_7829,_7872),
    {user:(\+testmember(_7751,[be2,have]))},
    redundant0(_7903,_7872,_7918),
    cc(og,_7918,_7937),
    hlexv(tv,_7769,past,part,id,_7938,_7937,_7963),
    {user:(\+testmember(_7751,[be2,have]))},
    !,
    whodidit(_7785,_7786,_8002,_7963,_8021),
    !,
    pushstack(first,(np(_7785,_7786),w(verb(_7751,past,fin)),[og],w(verb(_7769,past,fin)),npgap(_7702)),nil,_8021,_8112),
    state(_7703,_7704,_8041,_8112,_7831).

whodidit(_7702,_7703,[whodidit,lit(av),lit(at),_7782,!,_7821],_7743,_7745) --> 
    cc(av,_7743,_7770),
    cc(at,_7770,_7781),
    clausal_object1(_7702,_7703,_7782,_7781,_7801),
    !,
    accept(_7821,_7801,_7745).

whodidit(_7702,_7703,[whodidit,_7750,!,_7779],_7733,_7735) --> 
    by(_7750,_7733,_7765),
    !,
    np(_7702,_7703,_7779,_7765,_7735).

whodidit(_7702,_7703,[whodidit,_7760,!,_7821],_7743,_7745) --> 
    lock(exact,_7743,_7780),pushstack(exact,w(noun(agent,sin,u,n)),nil,_7780,_7786),np1(_7702,_7703,_7760,_7786,_7775),unlock(_7775,_7776),
    !,
    accept(_7821,_7776,_7745).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7810,lit(det),lit(å),_7876,_7919,!,_7958],_7787,_7789) --> 
    lexv(tv,_7735,_7736,fin,_7810,_7787,_7833),
    cc(det,_7833,_7864),
    cc(å,_7864,_7875),
    pushstack(first,[noen],nil,_7875,_7889),clausal_object1(_7748,_7732,_7876,_7889,_7904),
    traceprint(4,qv0a,_7919,_7904,_7938),
    !,
    pushstack(first,(lexv(tv,_7735,_7736,fin),xnp(_7702,_7732)),nil,_7938,_8032),
    verb_phrase(_7748,_7703,_7704,_7705,_7958,_8032,_7789).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7865,{},{},_7929,_7963,_7992,_8021,{},_8065,_8094,_8118,!,_8157],_7842,_7844) --> 
    lexv(tv,_7761,_7762,fin,_7865,_7842,_7888),
    {user:_7761\==ask},
    {user:_7761\==have},
    subject(_7775,_7776,_7929,_7888,_7948),
    negation0(_7703,_7963,_7948,_7980),
    not_look_ahead([om],_7992,_7980,_8009),
    object(_7784,_7785,_8021,_8009,_8040),
    {user:subject_object_test(_7761,_7775,_7784)},
    w(prep(_7795),_8065,_8040,_8082),
    not_look_ahead_np(_8094,_8082,_8109),
    traceprint(4,qv0b,_8118,_8109,_8137),
    !,
    pushstack(first,(xnp(_7775,_7776),w(verb(_7761,pres,fin)),xnp(_7784,_7785),w(prep(_7795)),npgap(_7702)),nil,_8137,_8259),
    state(_7704,_7705,_8157,_8259,_7844).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7845,{},_7899,_7933,_7962,_7991,_8015,!,_8054,{},_8088],_7822,_7824) --> 
    lexv(iv,_7752,_7753,fin,_7845,_7822,_7868),
    {user:(\+testmember(_7752,[think]))},
    subject(_7765,_7766,_7899,_7868,_7918),
    negation0(_7703,_7933,_7918,_7950),
    w(prep(_7772),_7962,_7950,_7979),
    not_look_ahead_np(_7991,_7979,_8006),
    traceprint(4,qv1,_8015,_8006,_8034),
    !,
    accept(_8054,_8034,_8069),
    {user:adjustprepv(_7752,_7772,_7781)},
    pushstack(first,(xnp(_7765,_7766),w(verb(_7752,_7753,fin)),w(prep(_7781)),npgap(_7702)),nil,_8069,_8159),
    state(_7704,_7705,_8088,_8159,_7824).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7825,_7869,_7903,_7927,[],_8001,!,_8040],_7802,_7804) --> 
    lexv(rv,_7744,pres,fin,_7825,_7802,_7848),
    subject(_7748,_7749,_7869,_7848,_7888),
    infinitive(_7903,_7888,_7918),
    w(verb(do,inf,fin),_7927,_7918,_7944),
    pushstack(free,xnp(_7702,_7749),nil,_7944,_8000),[],
    traceprint(4,qv2,_8001,_8000,_8020),
    !,
    pushstack(first,(w(verb(_7744,pres,fin)),[å],w(verb(do,inf,fin))),nil,_8020,_8050),
    verb_phrase(_7748,_7703,_7704,_7705,_8040,_8050,_7804).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7824,_7868,_7902,_7936,_7960,!,[],_8044],_7801,_7803) --> 
    lexv(dtv,_7743,_7744,fin,_7824,_7801,_7847),
    subject(_7747,_7748,_7868,_7847,_7887),
    ind_object(_7750,_7751,_7902,_7887,_7921),
    omaa(_7936,_7921,_7951),
    traceprint(4,qv3,_7960,_7951,_7979),
    !,
    pushstack(free,xnp(_7702,_7748),nil,_7979,_8043),[],
    pushstack(first,(w(verb(_7743,_7744,fin)),xnp(_7750,_7751),[om],[å]),nil,_8043,_8085),
    verb_phrase(_7747,_7703,_7704,_7705,_8044,_8085,_7803).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7826,{},{},_7890,_7924,{},_7968,!,_8007],_7803,_7805) --> 
    lexv(tv,_7741,_7742,fin,_7826,_7803,_7849),
    {user:_7741\==ask},
    {user:_7741\==have},
    subject(_7755,_7738,_7890,_7849,_7909),
    particlev0(_7741,_7759,_7924,_7909,_7943),
    {user:subject_object_test(_7741,_7755,_7702)},
    traceprint(4,qv4,_7968,_7943,_7987),
    !,
    pushstack(first,(lexv(tv,_7759,_7742,fin),xnp(_7702,_7738)),nil,_7987,_8081),
    verb_phrase(_7755,_7703,_7704,_7705,_8007,_8081,_7805).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7840,_7864,_7893,_7927,_7971,{},{},_8020,!,_8059,{}],_7817,_7819) --> 
    aux1(_7840,_7817,_7855),
    negation0(_7739,_7864,_7855,_7881),
    subject(_7745,_7746,_7893,_7881,_7912),
    lexv(tv,_7749,inf,fin,_7927,_7912,_7950),
    not_look_ahead([om],_7971,_7950,_7988),
    {user:_7749\==have},
    {user:test(tv_template(_7749,_7745,_7702,_7704,_7770))},
    traceprint(4,qv5,_8020,_7988,_8039),
    !,
    pushstack(first,(lexv(tv,_7749,pres,fin),xnp(_7702,_7746)),nil,_8039,_8134),verb_phrase(_7745,_7740,_7704,_7705,_8059,_8134,_7819),
    {user:bigno(_7739,_7740,_7703)}.

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7830,_7854,_7888,_7917,_7946,_7975,!,_8014],_7807,_7809) --> 
    aux1(_7830,_7807,_7845),
    subject(_7743,_7741,_7854,_7845,_7873),
    w(verb(be,inf,fin),_7888,_7873,_7905),
    w(adj2(_7754,_7755),_7917,_7905,_7934),
    w(prep(_7759),_7946,_7934,_7963),
    traceprint(4,qv6,_7975,_7963,_7994),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_7754,_7755)),w(prep(_7759)),xnp(_7702,_7741)),nil,_7994,_8055),
    verb_phrase(_7743,_7703,_7704,_7705,_8014,_8055,_7809).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7809,lit(du),_7844,_7873,_7902,!,_7941],_7786,_7788) --> 
    has(_7809,_7786,_7824),
    cc(du,_7824,_7843),
    negation0(_7703,_7844,_7843,_7861),
    prepnom(_7739,_7873,_7861,_7890),
    traceprint(4,qv7,_7902,_7890,_7921),
    !,
    pushstack(first,([du],w(verb(have,pres,fin)),npgap(_7702),w(prep(_7739))),nil,_7921,_7981),
    state(_7704,_7705,_7941,_7981,_7788).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7830,_7854,_7888,_7917,_7946,!,_7985],_7807,_7809) --> 
    has(_7830,_7807,_7845),
    np1_accept(_7743,_7740::_7741,_7854,_7845,_7873),
    w(noun(_7751,_7752,_7753,n),_7888,_7873,_7905),
    prepnom(_7756,_7917,_7905,_7934),
    traceprint(4,qv8,_7946,_7934,_7965),
    !,
    pushstack(free,(w(verb(have,pres,fin)),w(noun(_7751,sin,u,n)),w(prep(_7756)),noun_phrase1(_7702,_7740::_7741)),nil,_7965,_8029),
    do_phrase(have,_7743,_7703,_7704,_7705,_7985,_8029,_7809).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7830,_7854,_7888,_7917,{},_7956,_7995,!,_8034],_7807,_7809) --> 
    has(_7830,_7807,_7845),
    subject(_7745,_7746,_7854,_7845,_7873),
    negation0(_7703,_7888,_7873,_7905),
    w(verb(_7752,_7753,part),_7917,_7905,_7934),
    {user:testmember(_7752,[go])},
    defaultprep(_7752,_7702,_7765,_7956,_7934,_7977),
    traceprint(4,qv9,_7995,_7977,_8014),
    !,
    pushstack(first,(xnp(_7745,_7746),w(verb(_7752,_7753,fin)),prep1(_7765),npgap(_7702)),nil,_8014,_8136),
    state(_7704,_7705,_8034,_8136,_7809).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7808,_7832,_7866,_7895,_7924,!,_7963],_7785,_7787) --> 
    has(_7808,_7785,_7823),
    subject(_7736,_7737,_7832,_7823,_7851),
    negation0(_7703,_7866,_7851,_7883),
    w(verb(_7743,past,part),_7895,_7883,_7912),
    traceprint(4,qv10,_7924,_7912,_7943),
    !,
    pushstack(first,(xnp(_7736,_7737),w(verb(_7743,past,fin)),npgap(_7702)),nil,_7943,_8034),
    state(_7704,_7705,_7963,_8034,_7787).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7805,_7829,_7863,_7892,_7921,!,_7960],_7782,_7784) --> 
    has(_7805,_7782,_7820),
    np1_accept(_7737,_7738,_7829,_7820,_7848),
    negation0(_7703,_7863,_7848,_7880),
    w(verb(_7733,_7734,part),_7892,_7880,_7909),
    traceprint(4,qv11,_7921,_7909,_7940),
    !,
    pushstack(first,(xnp(_7737,_7738),w(verb(_7733,_7734,fin))),nil,_7940,_8001),
    verb_phrase(_7702,id,_7704,_7705,_7960,_8001,_7784).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,lit(kan),_7822,_7856,_7890,_7919,!,_7958],_7788,_7790) --> 
    cc(kan,_7788,_7821),
    subject(_7736,_7732,_7822,_7821,_7841),
    negation2(id,_7703,_7856,_7841,_7875),
    not_look_ahead(w(verb(_7746,_7747,_7748)),_7890,_7875,_7907),
    traceprint(4,qv12,_7919,_7907,_7938),
    !,
    lock(last,_7938,_8006),
    pushstack(last,(w(verb(know1,pres,fin)),xnp(_7702,_7732)),nil,_8006,_8012),
    do_phrase(_7753,_7736,id,_7704,_7705,_7958,_8012,_8001),
    unlock(_8001,_7790).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7827,_7856,_7890,_7924,_7953,_7982,!,_8021],_7804,_7806) --> 
    w(verb(_7741,_7742,fin),_7827,_7804,_7844),
    gmem(_7741,[talk,speak],_7856,_7844,_7875),
    subject(_7752,_7753,_7890,_7875,_7909),
    negation0(_7703,_7924,_7909,_7941),
    look_ahead(w(prep(_7761)),_7953,_7941,_7970),
    traceprint(4,qv13a,_7982,_7970,_8001),
    !,
    lock(last,_8001,_8099),
    pushstack(last,(xnp(_7702,_7753),w(verb(_7741,_7742,fin)),negation(_7703)),nil,_8099,_8105),
    do_phrase(_7766,_7752,id,_7704,_7705,_8021,_8105,_8094),
    unlock(_8094,_7806).

qverb_phrase(_7702,id,_7704,_7705,[qverb_phrase,_7803,_7827,_7861,_7890,!,_7929],_7780,_7782) --> 
    aux1(_7803,_7780,_7818),
    subject(_7733,_7734,_7827,_7818,_7846),
    w(verb(be,_7739,fin),_7861,_7846,_7878),
    traceprint(4,qv15c,_7890,_7878,_7909),
    !,
    pushstack(first,(xnp(_7733,_7734),w(verb(be,pres,fin)),npgap(_7702)),nil,_7909,_8000),
    state(_7704,_7705,_7929,_8000,_7782).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7789,_7813,_7847,_7881,!,_7920],_7766,_7768) --> 
    docan(_7789,_7766,_7804),
    subject(_7728,_7726,_7813,_7804,_7832),
    negation2(id,_7703,_7847,_7832,_7866),
    traceprint(4,qv13b,_7881,_7866,_7900),
    !,
    lock(last,_7900,_7968),
    pushstack(last,xnp(_7702,_7726),nil,_7968,_7974),
    do_phrase(_7737,_7728,id,_7704,_7705,_7920,_7974,_7963),
    unlock(_7963,_7768).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,{},_7833,_7857,_7891,lit(av),_7931,!,_7970],_7800,_7802) --> 
    {user:constrain(_7702,place)},
    aux1(_7833,_7800,_7848),
    np1_accept(_7747,_7750::_7751,_7857,_7848,_7876),
    negation0(_7703,_7891,_7876,_7908),
    cc(av,_7908,_7930),
    traceprint(4,qv14,_7931,_7930,_7950),
    !,
    pushstack(first,(noun_phrase1(_7747,_7750::_7751),w(verb(go,pres,fin)),[av],npgap(_7702)),nil,_7950,_8044),
    state(_7704,_7705,_7970,_8044,_7802).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7838,_7867,_7891,_7925,_7954,_7983,_8012,!,_8051],_7815,_7817) --> 
    w(verb(be,pres,_7752),_7838,_7815,_7855),
    thereit0(_7867,_7855,_7882),
    np1_accept(_7754,_7757::_7758,_7891,_7882,_7910),
    negation0(_7703,_7925,_7910,_7942),
    w(verb(_7764,_7765,part),_7954,_7942,_7971),
    prep(_7768,_7983,_7971,_8000),
    traceprint(4,qv15,_8012,_8000,_8031),
    !,
    pushstack(first,(someone,w(verb(_7764,_7765,fin)),noun_phrase1(_7754,_7757::_7758),w(prep(_7768)),npgap(_7702)),nil,_8031,_8153),
    state(_7704,_7705,_8051,_8153,_7817).

qverb_phrase(_7702,id,_7704,_7705,[qverb_phrase,_7830,_7859,_7893,_7922,_7951,!,_7990],_7807,_7809) --> 
    w(verb(be,_7745,fin),_7830,_7807,_7847),
    subject(_7748,_7749,_7859,_7847,_7878),
    w(adj2(_7753,nil),_7893,_7878,_7910),
    w(prep(_7758),_7922,_7910,_7939),
    traceprint(4,qv15a,_7951,_7939,_7970),
    !,
    pushstack(first,(xnp(_7748,_7749),w(verb(be,pres,fin)),w(adj2(_7753,nil)),w(prep(_7758)),npgap(_7702)),nil,_7970,_8061),
    state(_7704,_7705,_7990,_8061,_7809).

qverb_phrase(_7702,id,_7704,_7705,[qverb_phrase,_7800,_7829,_7863,!,_7902],_7777,_7779) --> 
    w(verb(be,_7733,fin),_7800,_7777,_7817),
    subject(_7736,_7737,_7829,_7817,_7848),
    traceprint(4,qv15b,_7863,_7848,_7882),
    !,
    pushstack(first,(xnp(_7736,_7737),w(verb(be,pres,fin)),npgap(_7702)),nil,_7882,_7973),
    state(_7704,_7705,_7902,_7973,_7779).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7829,_7858,_7882,_7916,_7945,_7974,{},_8008,!,_8047],_7806,_7808) --> 
    w(verb(be,_7751,fin),_7829,_7806,_7846),
    thereit0(_7858,_7846,_7873),
    np1_accept(_7754,_7755,_7882,_7873,_7901),
    negation0(_7703,_7916,_7901,_7933),
    prep(_7759,_7945,_7933,_7962),
    not_look_ahead_np(_7974,_7962,_7989),
    {user:_7759\==towards},
    traceprint(4,qv16,_8008,_7989,_8027),
    !,
    pushstack(first,(xnp(_7754,_7755),w(verb(be1,pres,fin)),prep(_7759),npgap(_7702)),nil,_8027,_8148),
    state(_7704,_7705,_8047,_8148,_7808).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7892,{},_7946,_7980,_8009,_8043,_8072,_8096,!,{},{},_8155],_7869,_7871) --> 
    lexv(tv,_7758,_7759,fin,_7892,_7869,_7915),
    {user:(\+testmember(_7758,[pass,be1,be,be2,cost,have,know1]))},
    np1_accept(_7783,_7786::_7787,_7946,_7915,_7965),
    negation0(_7703,_7980,_7965,_7997),
    np1_accept(_7702,_7794::_7795,_8009,_7997,_8028),
    prep1(_7797,_8043,_8028,_8060),
    endofline(_8072,_8060,_8087),
    traceprint(4,qv17,_8096,_8087,_8115),
    !,
    {user:(\+testmember(_7797,[off,of]))},
    {user:test(verb_compl(_7758,_7797,_7783,_7702,_7821,_7822))},
    pushstack(first,(noun_phrase1(_7783,_7786::_7787),lexv(tv,_7758,_7759,fin),noun_phrase1(_7702,_7794::_7795),prep1(_7797),npgap(_7702)),nil,_8115,_8326),
    state(_7704,_7705,_8155,_8326,_7871).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7900,_7929,_7958,{},{},_8022,_8046,_8080,_8109,{},{},_8168,_8192,!,_8231],_7877,_7879) --> 
    not_look_ahead([kan],_7900,_7877,_7917),
    not_look_ahead(w(verb(be,_7772,_7773)),_7929,_7917,_7946),
    lexv(_7775,_7776,_7777,fin,_7958,_7946,_7981),
    {user:(_7775==iv;_7775==rv)},
    {user:(\+testmember(_7776,[pass]))},
    thereit0(_8022,_7981,_8037),
    np1_accept(_7800,_7803::_7804,_8046,_8037,_8065),
    negation0(_7703,_8080,_8065,_8097),
    defaultprep(_7776,_7702,_7810,_8109,_8097,_8130),
    {user:(\+testmember(_7810,[off,of]))},
    {user:test(verb_compl(_7776,_7810,_7800,_7702,_7831,_7832))},
    qtrailer0(_8168,_8130,_8183),
    traceprint(4,qv18,_8192,_8183,_8211),
    !,
    pushstack(first,(noun_phrase1(_7800,_7803::_7804),w(verb(_7776,_7777,fin)),prep1(_7810),npgap(_7702)),nil,_8211,_8335),
    state(_7704,_7705,_8231,_8335,_7879).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,{},_7864,{},_7903,_7932,_7966,_7995,_8034,!,_8073],_7831,_7833) --> 
    {user:constrain(_7702,place)},
    w(verb(_7755,_7756,fin),_7864,_7831,_7881),
    {user:(\+testmember(_7755,[be,take,pass]))},
    not_look_ahead([det],_7903,_7881,_7920),
    np1_accept(_7776,_7779::_7780,_7932,_7920,_7951),
    negation0(_7703,_7966,_7951,_7983),
    defaultprep(_7755,_7702,_7786,_7995,_7983,_8016),
    traceprint(4,qv19,_8034,_8016,_8053),
    !,
    pushstack(first,(noun_phrase1(_7776,_7779:_7780),w(verb(_7755,pres,fin)),prep1(_7786),npgap(_7702)),nil,_8053,_8174),
    state(_7704,_7705,_8073,_8174,_7833).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7854,{},_7908,_7942,{},_7981,{},_8020,!,_8059],_7831,_7833) --> 
    lexv(iv,_7749,_7750,fin,_7854,_7831,_7877),
    {user:_7749\==be1},
    np1_accept(_7758,_7761::_7762,_7908,_7877,_7927),
    negation0(_7703,_7942,_7927,_7959),
    {user:constrain(_7758,vehicle)},
    prep1(_7771,_7981,_7959,_7998),
    {user:testmember(_7771,[to,from,past,by,on])},
    traceprint(4,qv20,_8020,_7998,_8039),
    !,
    pushstack(first,(noun_phrase1(_7758,_7761::_7762),w(verb(_7749,pres,fin)),prep1(_7771),npgap(_7702)),nil,_8039,_8163),
    state(_7704,_7705,_8059,_8163,_7833).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7804,_7828,_7862,_7906,!,_7945],_7781,_7783) --> 
    do(_7804,_7781,_7819),
    noun_phrase1(_7734,_7731::_7732,_7828,_7819,_7847),
    lexv(_7740,know1,_7742,fin,_7862,_7847,_7885),
    traceprint(4,qv21,_7906,_7885,_7925),
    !,
    pushstack(first,(lexv(_7740,know1,_7742,fin),np(_7702,_7731::_7732)),nil,_7925,_8020),
    verb_phrase(_7734,_7703,_7704,_7705,_7945,_8020,_7783).

qverb_phrase(_7702,_7703,_7704,_7707::_7708,[qverb_phrase,_7798,_7822,_7856,_7880,!,_7919],_7775,_7777) --> 
    use(_7798,_7775,_7813),
    noun_phrase1(_7733,_7736::_7708,_7822,_7813,_7841),
    in_order_to(_7856,_7841,_7871),
    traceprint(4,qv22,_7880,_7871,_7899),
    !,
    pushstack(free,(prep(with),npgap(_7702)),nil,_7899,_7989),
    verb_phrase(_7733,_7703,_7704,_7707::_7736,_7919,_7989,_7777).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7797,_7821,_7850,_7879,!,_7918],_7774,_7776) --> 
    be(_7797,_7774,_7812),
    thereit2(be,_7821,_7812,_7838),
    not_look_ahead(w(noun(_7737,_7738,u,_7740)),_7850,_7838,_7867),
    traceprint(4,qv23,_7879,_7867,_7898),
    !,
    pushstack(first,w(verb(exist,pres,fin)),nil,_7898,_7928),
    verb_phrase1(exist,_7702,_7703,_7704,_7705,_7918,_7928,_7776).

qverb_phrase(_7702,id,_7704,_7705,[qverb_phrase,{},_7835,{},_7889,{},_7933,!,_7972],_7802,_7804) --> 
    {user:constrain(_7702,route)},
    lexv(iv,_7745,_7746,fin,_7835,_7802,_7858),
    {user:testmember(_7745,[go])},
    subject(_7756,_7757,_7889,_7858,_7908),
    {user:constrain(_7756,vehicle)},
    traceprint(4,qv24,_7933,_7908,_7952),
    !,
    lock(last,_7952,_8050),
    pushstack(last,(xnp(_7756,_7757),w(verb(_7745,_7746,fin)),npgap(_7702)),nil,_8050,_8056),
    state(_7704,_7705,_7972,_8056,_8045),
    unlock(_8045,_7804).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7813,_7857,{},_7901,_7930,!,_7969],_7790,_7792) --> 
    lexv(tv,_7735,_7736,fin,_7813,_7790,_7836),
    subject(_7739,_7732,_7857,_7836,_7876),
    {user:subject_object_test(_7735,_7739,_7702)},
    not_look_ahead(w(prep(_7752)),_7901,_7876,_7918),
    traceprint(4,qv25,_7930,_7918,_7949),
    !,
    pushstack(first,(lexv(tv,_7735,_7736,fin),xnp(_7702,_7732)),nil,_7949,_8043),
    verb_phrase(_7739,_7703,_7704,_7705,_7969,_8043,_7792).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7778,_7807,!,_7846],_7755,_7757) --> 
    look_ahead(w(verb(be,_7726,fin)),_7778,_7755,_7795),
    traceprint(4,qv26,_7807,_7795,_7826),
    !,
    verb_phrase(_7702,_7703,_7704,_7705,_7846,_7826,_7757).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7797,{},_7836,_7865,!,_7904],_7774,_7776) --> 
    not_look_ahead(w(verb(be,_7732,fin)),_7797,_7774,_7814),
    {user:vartypeid(_7702,thing)},
    look_ahead(w(verb(_7744,_7745,fin)),_7836,_7814,_7853),
    traceprint(4,qv27,_7865,_7853,_7884),
    !,
    verb_phrase(_7702,_7703,_7704,_7705,_7904,_7884,_7776).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7808,lit(du),_7848,_7872,_7906,lit(kan),_7951,!,_7990],_7785,_7787) --> 
    w(verb(believe,pres,fin),_7808,_7785,_7825),
    cc(du,_7825,_7847),
    that0(_7848,_7847,_7863),
    noun_phrase1(_7745,_7735,_7872,_7863,_7891),
    negation2(id,_7703,_7906,_7891,_7925),
    cc(kan,_7925,_7950),
    traceprint(4,qv28,_7951,_7950,_7970),
    !,
    pushstack(free,xnp(_7702,_7735),nil,_7970,_8031),
    do_phrase(believe,_7745,id,_7704,_7705,_7990,_8031,_7787).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7792,_7816,_7850,_7884,_7908,!,_7947],_7769,_7771) --> 
    do(_7792,_7769,_7807),
    noun_phrase1(_7731,_7729,_7816,_7807,_7835),
    negation2(id,_7703,_7850,_7835,_7869),
    redundant0x(_7884,_7869,_7899),
    traceprint(4,qv29,_7908,_7899,_7927),
    !,
    lock(last,_7927,_7995),
    pushstack(last,xnp(_7702,_7729),nil,_7995,_8001),
    do_phrase(_7740,_7731,id,_7704,_7705,_7947,_8001,_7990),
    unlock(_7990,_7771).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7827,{},_7881,_7905,_7939,_7963,_7992,!,_8031],_7804,_7806) --> 
    lexv(iv,_7744,_7745,fin,_7827,_7804,_7850),
    {user:(\+testmember(_7744,[know,know1,be1]))},
    thereit(_7881,_7850,_7896),
    noun_phrase1(_7761,_7741,_7905,_7896,_7924),
    adverbx0(_7939,_7924,_7954),
    prep0(_7764,_7963,_7954,_7980),
    traceprint(4,qv30,_7992,_7980,_8011),
    !,
    pushstack(first,(lexv(iv,_7744,_7745,fin),prep(_7764),xnp(_7702,_7741)),nil,_8011,_8135),
    verb_phrase(_7761,_7703,_7704,_7705,_8031,_8135,_7806).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7815,_7839,_7873,_7917,_7941,_7985,!,_8024],_7792,_7794) --> 
    has(_7815,_7792,_7830),
    np1_accept(_7740,_7737::_7738,_7839,_7830,_7858),
    lexv(rv,_7747,past,part,_7873,_7858,_7896),
    infinitive(_7917,_7896,_7932),
    lexv(tv,_7752,inf,fin,_7941,_7932,_7964),
    traceprint(4,qv31,_7985,_7964,_8004),
    !,
    pushstack(first,(lexv(tv,_7752,pres,fin),np(_7702,_7737::_7738)),nil,_8004,_8101),
    verb_phrase(_7740,_7703,_7704,_7705,_8024,_8101,_7794).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7804,_7828,_7862,_7906,!,_7945],_7781,_7783) --> 
    has(_7804,_7781,_7819),
    np1_accept(_7734,_7731::_7732,_7828,_7819,_7847),
    lexv(tv,_7741,past,part,_7862,_7847,_7885),
    traceprint(4,qv32,_7906,_7885,_7925),
    !,
    pushstack(first,(lexv(tv,_7741,past,fin),np(_7702,_7731::_7732)),nil,_7925,_8020),
    verb_phrase(_7734,_7703,_7704,_7705,_7945,_8020,_7783).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7801,_7825,{},_7869,!,_7908],_7778,_7780) --> 
    has(_7801,_7778,_7816),
    np1_accept(_7731,_7729,_7825,_7816,_7844),
    {user:has_template(_7731,_7702,_7738)},
    traceprint(4,qv33,_7869,_7844,_7888),
    !,
    pushstack(free,(w(verb(have,pres,fin)),noun_phrase1(_7702,_7729)),nil,_7888,_7949),
    do_phrase(have,_7731,_7703,_7704,_7705,_7908,_7949,_7780).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7832,_7856,_7890,_7934,_7968,_7997,!,_8036],_7809,_7811) --> 
    has(_7832,_7809,_7847),
    np1_accept(_7746,_7743::_7744,_7856,_7847,_7875),
    lexv(tv,_7753,past,part,_7890,_7875,_7913),
    noun_phrase1(_7757,_7760::_7761,_7934,_7913,_7953),
    prep(_7763,_7968,_7953,_7985),
    traceprint(4,qv34,_7997,_7985,_8016),
    !,
    pushstack(first,(lexv(tv,_7753,past,fin),np(_7757,_7760::_7761),prep(_7763),np(_7702,_7743::_7744)),nil,_8016,_8177),
    verb_phrase(_7746,_7703,_7704,_7705,_8036,_8177,_7811).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7788,{},_7827,!,_7866],_7765,_7767) --> 
    not_look_ahead(w(verb(be,_7729,fin)),_7788,_7765,_7805),
    {user:(\+vartypeid(_7702,thing))},
    traceprint(4,qv35,_7827,_7805,_7846),
    !,
    verb_phrase(_7702,_7703,_7704,_7705,_7866,_7846,_7767).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,{},_7808,_7837,_7861,!,_7900],_7775,_7777) --> 
    {user:(\+vartypeid(_7702,thing))},
    w(verb(_7727,_7728,fin),_7808,_7775,_7825),
    thereit0(_7837,_7825,_7852),
    traceprint(4,qv36,_7861,_7852,_7880),
    !,
    pushstack(first,w(verb(_7727,_7728,fin)),nil,_7880,_7910),
    verb_phrase(_7702,_7703,_7704,_7705,_7900,_7910,_7777).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7801,_7845,_7869,_7956,!,_7995],_7778,_7780) --> 
    lexv(_7731,_7732,_7733,fin,_7801,_7778,_7824),
    thereit(_7845,_7824,_7860),
    lock(exact,_7860,_7920),pushstack(exact,this,nil,_7920,_7926),npa(_7739,_7729,_7869,_7926,_7915),unlock(_7915,_7916),
    traceprint(4,qv37,_7956,_7916,_7975),
    !,
    pushstack(first,(lexv(_7731,_7732,_7733,fin),xnp(_7702,_7729)),nil,_7975,_8069),
    verb_phrase(_7739,_7703,_7704,_7705,_7995,_8069,_7780).

qverb_phrase(_7702,_7703,_7704,_7705,[qverb_phrase,_7850,{},_7904,_7938,_7967,_8006,!,_8045,_8069,_8108],_7827,_7829) --> 
    lexv(iv,_7752,_7753,fin,_7850,_7827,_7873),
    {user:(\+testmember(_7752,[think]))},
    np1_accept(_7765,_7766,_7904,_7873,_7923),
    negation0(_7703,_7938,_7923,_7955),
    adverbial1(_7770,_7771,_7774::_7775,_7967,_7955,_7988),
    traceprint(4,qv38,_8006,_7988,_8025),
    !,
    accept(_8045,_8025,_8060),
    defaultprep(_7752,_7702,_7782,_8069,_8060,_8090),
    pushstack(first,(xnp(_7765,_7766),lexv(iv,_7752,_7753,fin),adverbial1(_7770,_7771,_7774::_7775),prep1(_7782),npgap(_7702)),nil,_8090,_8277),
    state(_7704,_7705,_8108,_8277,_7829).

verb_modifiers0(_7702,_7703,_7704,_7705,_7706,[verb_modifiers0,lit(hva),!,_7783],_7741,_7743) --> 
    cc(hva,_7741,_7777),
    !,
    reject(_7783,_7777,_7743).

verb_modifiers0(_7702,_7703,_7704,_7705,_7706,[verb_modifiers0,_7765],_7739,_7741) --> 
    verb_modifiers(_7702,_7703,_7704,_7705,_7706,_7765,_7739,_7741).

verb_modifiers0(_7702,_7703,_7704,_7705,_7706,[verb_modifiers0,_7771,!,_7800],_7745,_7747) --> 
    redundant(_7771,_7745,_7786),
    !,
    verb_modifiers(_7702,_7703,_7704,_7705,_7706,_7800,_7786,_7747).

verb_modifiers0(_7702,_7703,_7704,_7705,_7705,[verb_modifiers0,{}],_7740,_7740) --> 
    {user:(\+_7702=be1)}.

verb_modifiers(_7702,_7703,_7704,_7705,_7706,[verb_modifiers,_7780,!,_7834,_7858],_7754,_7756) --> 
    verb_modifier(_7702,_7703,_7704,_7705,_7720,_7780,_7754,_7805),
    !,
    accept(_7834,_7805,_7849),
    verb_modifiers10(_7702,_7703,_7704,_7720,_7706,_7858,_7849,_7756).

verb_modifiers10(_7702,_7703,_7704,_7705,_7706,[verb_modifiers10,_7771,_7795,_7819],_7745,_7747) --> 
    vmod_conjunction(_7771,_7745,_7786),
    look_ahead_prepadv(_7795,_7786,_7810),
    verb_modifiers(_7702,_7703,_7704,_7705,_7706,_7819,_7810,_7747).

verb_modifiers10(go,_7703,_7704,_7705,_7706,[verb_modifiers10,_7791,_7815,!,_7849,_7873],_7765,_7767) --> 
    numberroute(_7791,_7765,_7806),
    look_ahead(w(nb(_7731,num)),_7815,_7806,_7832),
    !,
    accept(_7849,_7832,_7864),
    pushstack(first,w(prep(with)),nil,_7864,_7883),
    verb_modifiers(go,_7703,_7704,_7705,_7706,_7873,_7883,_7767).

verb_modifiers10(_7702,_7703,_7704,_7705,_7706,[verb_modifiers10,_7779,_7803,_7832],_7753,_7755) --> 
    point(_7779,_7753,_7794),
    look_ahead(w(name(_7724,_7725,_7726)),_7803,_7794,_7820),
    verb_modifiers0(_7702,_7703,_7704,_7705,_7706,_7832,_7820,_7755).

verb_modifiers10(_7702,_7703,_7704,_7705,_7706,[verb_modifiers10,_7765],_7739,_7741) --> 
    verb_modifiers0(_7702,_7703,_7704,_7705,_7706,_7765,_7739,_7741).

verb_modifiers10(_7702,_7703,_7704,_7705,_7705,[verb_modifiers10,[]],_7733,_7733) --> 
    [].

look_ahead_prepadv([look_ahead_prepadv,_7737,!],_7726,_7728) --> 
    look_ahead(w(prep(_7709)),_7737,_7726,_7728),
    !.

look_ahead_prepadv([look_ahead_prepadv,_7737,!],_7726,_7728) --> 
    look_ahead(w(adv(_7709)),_7737,_7726,_7728),
    !.

verb_modifier(_7702,_7703,_7704,_7714 and _7708::_7709,_7708::_7709,[verb_modifier,_7814,_7843,{},{}],_7788,_7790) --> 
    thisplace(_7737,_7814,_7788,_7831),
    not_look_ahead([jegdu],_7843,_7831,_7790),
    {user:verb_compl(_7702,_7737,_7703,_7752:place,_7704,_7735)},
    {user:_7714=(findexternal(_7752:place)::_7752 isa place and _7735)}.

verb_modifier(_7702,_7703,_7704,_7714 and _7708::_7712,_7708::_7709,[verb_modifier,_7777],_7751,_7753) --> 
    verb_mod1(_7702,_7703,_7704,_7714,_7712::_7709,_7777,_7751,_7753).

verb_modifier(_7702,_7703,_7704,_7714 and _7708::_7709,_7708::_7709,[verb_modifier,_7783,!,{}],_7757,_7759) --> 
    today(_7783,_7757,_7759),
    !,
    {user:adv_compl(_7702,today,_7703,time,_7704,_7714)}.

verb_modifier(_7702,_7703,_7704,_7705,_7705,[verb_modifier,_7767,!,_7801],_7741,_7743) --> 
    particlev1(_7702,_7767,_7741,_7784),
    !,
    accept(_7801,_7784,_7743).

verb_modifier(_7702,_7703,_7704,_7705,_7705,[verb_modifier,{},_7781],_7745,_7747) --> 
    {user:testmember(_7702,[want])},
    reflexiv(_7702,_7781,_7745,_7747).

verb_modifier(_7702,_7703,_7704,_7714 and _7708::_7712,_7708::_7709,[verb_modifier,{},_7812,_7856,{}],_7776,_7778) --> 
    {user:_7702\==be1},
    lexv(iv,_7741,pres,part,_7812,_7776,_7835),
    verb_modifier3(_7741,_7703,_7731,_7712,_7709,_7856,_7835,_7778),
    {user:verb_compl(_7702,during,_7703,_7731,_7704,_7714)}.

verb_modifier(_7702,_7703,_7704,_7708 and _7715::_7712,_7708::_7709,[verb_modifier,_7798,_7822,{}],_7772,_7774) --> 
    this(_7798,_7772,_7813),
    pushstack(first,(prep(in),this),nil,_7813,_7893),adverbial(_7726,_7728,_7712::_7709,_7822,_7893,_7774),
    {user:verb_compl(_7702,_7726,_7703,_7728,_7704,_7715)}.

verb_modifier(_7702,_7703,_7704,_7714 and _7708::_7709,_7708::_7709,[verb_modifier,_7784,{}],_7758,_7760) --> 
    partday(_7723,_7725,_7731,_7784,_7758,_7760),
    {user:adv_compl(_7702,_7723,_7703,_7725,_7704,_7714)}.

verb_modifier(_7702,_7703,_7704,_7714 and _7708::_7712,_7708::_7709,[verb_modifier,_7798,_7827,{},!,_7881],_7772,_7774) --> 
    nil_compl(_7702,_7798,_7772,_7815),
    adjunct1(nil,_7732,_7712::_7709,_7827,_7815,_7848),
    {user:verb_compl(_7702,nil,_7703,_7732,_7704,_7714)},
    !,
    accept(_7881,_7848,_7774).

verb_modifier(_7702,_7703,_7704,_7714 and _7708::_7712,_7708::_7709,[verb_modifier,_7798,_7827,{},!,_7881],_7772,_7774) --> 
    dir_compl(_7702,_7798,_7772,_7815),
    adjunct1(dir,_7732,_7712::_7709,_7827,_7815,_7848),
    {user:verb_compl(_7702,dir,_7703,_7732,_7704,_7714)},
    !,
    accept(_7881,_7848,_7774).

verb_modifier(adj/nil/_7712,_7703,_7704,_7720 and _7708::_7718,_7708::_7709,[verb_modifier,_7811,_7835,_7884,{}],_7785,_7787) --> 
    infinitive(_7811,_7785,_7826),
    subordinateinfnosubj(nil,coevent,_7703,_7737,_7745,_7835,_7826,_7860),
    determiner00(_7737,_7718,_7745::_7709,_7884,_7860,_7787),
    {user:verb_compl(adj/nil/_7712,in_order_to,_7703,_7737,_7704,_7720)}.

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,_7815,_7849,{},_7888,!,_7927,{}],_7789,_7791) --> 
    gmem(_7702,[be1,go,arrive,depart],_7815,_7789,_7834),
    w(prep(_7729),_7849,_7834,_7866),
    {user:testmember(_7729,[before,after,between])},
    plausibleclock(_7731,_7706,_7888,_7866,_7907),
    !,
    accept(_7927,_7907,_7791),
    {user:verb_compl(_7702,_7729,_7703,_7731,_7704,_7705)}.

verb_mod1(look,_7703,_7704,_7705,_7708::_7709,[verb_mod1,_7804,lit(ut),!,_7849,{}],_7778,_7780) --> 
    w(adj2(_7734,_7735),_7804,_7778,_7821),
    cc(ut,_7821,_7843),
    !,
    lock(exact,_7843,_7869),pushstack(exact,w(adv(_7734)),nil,_7869,_7875),adverbix(_7726,_7728,_7708::_7709,_7849,_7875,_7864),unlock(_7864,_7780),
    {user:verb_compl(look,_7726,_7703,_7728,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,_7806,_7840,{},!,_7884,{}],_7780,_7782) --> 
    gmem(_7702,[be1],_7806,_7780,_7825),
    w(prep(_7726),_7840,_7825,_7857),
    {user:(\+member(_7726,[between,for]))},
    !,
    np1_accept(_7728,_7706,_7884,_7857,_7782),
    {user:verb_compl(_7702,_7726,_7703,_7728,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,lit(som),_7800,!,_7834,{}],_7763,_7765) --> 
    cc(som,_7763,_7799),
    w(prep(in),_7800,_7799,_7817),
    !,
    np1_accept(_7725,_7706,_7834,_7817,_7765),
    {user:verb_compl(_7702,as_in,_7703,_7725,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,lit(som),!,_7798,{}],_7756,_7758) --> 
    cc(som,_7756,_7792),
    !,
    np1_accept(_7722,_7706,_7798,_7792,_7758),
    {user:verb_compl(_7702,as,_7703,_7722,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,_7819,_7853,{},_7892,!,_7926,{}],_7793,_7795) --> 
    gmem(_7702,[exist],_7819,_7793,_7838),
    one_of_lit([til,før],_7853,_7838,_7870),
    {user:(vartypeid(_7703,_7751),subclass0(_7751,duration))},
    not_look_ahead(w(name(_7761,n,place)),_7892,_7870,_7909),
    !,
    clausal_object0(_7731,_7706,_7926,_7909,_7795),
    {user:verb_compl(_7702,until,_7703,_7731,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,{},lit(_7741),{},{},!,_7862,{}],_7790,_7792) --> 
    {user:testmember(_7702,[exist])},
    cc(_7741,_7790,_7836),
    {user:testmember(_7741,[siden])},
    {user:(vartypeid(_7703,_7756),subclass0(_7756,duration))},
    !,
    clausal_object0(_7731,_7706,_7862,_7836,_7792),
    {user:verb_compl(_7702,since,_7703,_7731,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,{},lit(med),lit(at),!,_7834,{}],_7771,_7773) --> 
    {user:testmember(_7702,[mean])},
    cc(med,_7771,_7817),
    cc(at,_7817,_7828),
    !,
    clausal_object1(_7728,_7706,_7834,_7828,_7773),
    {user:verb_compl(_7702,with,_7703,_7728,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},_7831,_7860,!,_7894,{}],_7795,_7797) --> 
    {user:testmember(_7702,[ask])},
    not_look_ahead([nå],_7831,_7795,_7848),
    look_ahead(w(verb(_7750,inf,fin)),_7860,_7848,_7877),
    !,
    pushstack(first,(npgap(_7703),[vil]),nil,_7877,_7937),clausal_object1(_7731,_7708::_7709,_7894,_7937,_7797),
    {user:verb_compl(_7702,regarding,_7703,_7731,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,{},lit(om),_7822,!,_7856,{}],_7775,_7777) --> 
    {user:testmember(_7702,[notify,take])},
    cc(om,_7775,_7821),
    not_look_ahead([en],_7822,_7821,_7839),
    !,
    clausal_object0(_7728,_7706,_7856,_7839,_7777),
    {user:verb_compl(_7702,regarding,_7703,_7728,_7704,_7705)}.

verb_mod1(adj/nil/_7709,_7703,_7704,_7705,_7706,[verb_mod1,{},_7827,!,_7861,{}],_7791,_7793) --> 
    {user:testmember(_7709,[delayed])},
    w(nb(_7744,num),_7827,_7791,_7844),
    !,
    pushstack(first,(w(prep(with)),w(nb(_7744,num))),nil,_7844,_7874),pp(with,_7731,_7706,_7861,_7874,_7793),
    {user:adj_compl(_7709,with,_7703,_7731,_7704,_7705)}.

utenå([utenå,lit(uten),_7750,_7774,!],_7728,_7730) --> 
    cc(uten,_7728,_7749),
    ogå(_7750,_7749,_7765),
    måtte(_7774,_7765,_7730),
    !.

utenå([utenå,lit(uten),_7744],_7722,_7724) --> 
    cc(uten,_7722,_7743),
    ogå(_7744,_7743,_7724).

måtte([måtte,_7740],_7729,_7731) --> 
    one_of_lit([måtte,ville,skulle,burde,kunne],_7740,_7729,_7731).

verb_mod1(adj/nil/_7709,_7703,_7704,_7705,_7706,[verb_mod1,{},_7808,!,_7837,{}],_7772,_7774) --> 
    {user:testmember(_7709,[afraid,happy])},
    foratx0(_7808,_7772,_7823),
    !,
    clausal_object1(_7731,_7706,_7837,_7823,_7774),
    {user:adj_compl(_7709,because_of,_7703,_7731,_7704,_7705)}.

foratx0([foratx0,lit(for),lit(at)],_7724,_7726) --> 
    cc(for,_7724,_7745),
    cc(at,_7745,_7726).

foratx0([foratx0,lit(at)],_7719,_7721) --> 
    cc(at,_7719,_7721).

foratx0([foratx0,_7744],_7733,_7735) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_7744,_7733,_7735).

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,{},_7802,_7826,{},!],_7766,_7768) --> 
    {user:testmember(_7702,[label,be_named])},
    look_ahead_np(_7802,_7766,_7817),
    np0_accept(_7729,_7706,_7826,_7817,_7768),
    {user:verb_compl(_7702,with,_7703,_7729,_7704,_7705)},
    !.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},lit(enn),lit(å),!,_7851,{}],_7788,_7790) --> 
    {user:(\+testmember(_7702,[be,be1,be2]))},
    cc(enn,_7788,_7834),
    cc(å,_7834,_7845),
    !,
    pushstack(first,[noen],nil,_7845,_7864),clausal_object1(_7731,_7708::_7709,_7851,_7864,_7790),
    {user:verb_compl(_7702,than,_7703,_7731,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},lit(enn),lit(at),!,_7846,{}],_7783,_7785) --> 
    {user:(\+testmember(_7702,[be,be1,be2]))},
    cc(enn,_7783,_7829),
    cc(at,_7829,_7840),
    !,
    clausal_object1(_7731,_7708::_7709,_7846,_7840,_7785),
    {user:verb_compl(_7702,than,_7703,_7731,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},lit(enn),_7822,{}],_7775,_7777) --> 
    {user:(\+testmember(_7702,[be,be1,be2]))},
    cc(enn,_7775,_7821),
    np1(_7725,_7708::_7709,_7822,_7821,_7777),
    {user:verb_compl(_7702,than,_7703,_7725,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,{},_7818,{},!,_7862,{}],_7782,_7784) --> 
    {user:testmember(_7702,[notify,wait])},
    w(prep(_7726),_7818,_7782,_7835),
    {user:(\+testmember(_7726,[for]))},
    !,
    clausal_object0(_7728,_7706,_7862,_7835,_7784),
    {user:verb_compl(_7702,_7726,_7703,_7728,_7704,_7705)}.

verb_mod1(adj/nil/_7712,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},_7842,lit(å),!,_7902,{}],_7806,_7808) --> 
    {user:testmember(_7712,[nice,good,bad,interested,interesting])},
    optional(w(prep(_7760)),_7842,_7806,_7874),
    cc(å,_7874,_7896),
    !,
    pushstack(first,npgap(_7703),nil,_7896,_7945),clausal_object1(_7737,_7708::_7709,_7902,_7945,_7808),
    {user:verb_compl(adj/nil/_7712,because_of,_7703,_7737,_7704,_7705)}.

overat([overat,lit(fordi)],_7719,_7721) --> 
    cc(fordi,_7719,_7721).

overat([overat,lit(av),lit(at)],_7724,_7726) --> 
    cc(av,_7724,_7745),
    cc(at,_7745,_7726).

overat([overat,lit(over),lit(at)],_7724,_7726) --> 
    cc(over,_7724,_7745),
    cc(at,_7745,_7726).

overat([overat,lit(til),lit(at)],_7724,_7726) --> 
    cc(til,_7724,_7745),
    cc(at,_7745,_7726).

verb_mod1(adj/nil/_7709,_7703,_7704,_7705,_7706,[verb_mod1,{},lit(av),lit(hvilken),!,_7846,{}],_7783,_7785) --> 
    {user:(\+testmember(_7709,[]))},
    cc(av,_7783,_7829),
    cc(hvilken,_7829,_7840),
    !,
    np1(_7734,_7706,_7846,_7840,_7785),
    {user:verb_compl(adj/nil/_7709,of,_7703,_7734,_7704,_7705)}.

verb_mod1(adj/nil/_7712,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},_7823,!,_7852,{}],_7787,_7789) --> 
    {user:(\+testmember(_7712,[]))},
    overaa(_7823,_7787,_7838),
    !,
    pushstack(first,npgap(_7703),nil,_7838,_7895),clausal_object1(_7734,_7708::_7709,_7852,_7895,_7789),
    {user:verb_compl(adj/nil/_7712,because_of,_7703,_7734,_7704,_7705)}.

overaa([overaa,lit(av),lit(å)],_7724,_7726) --> 
    cc(av,_7724,_7745),
    cc(å,_7745,_7726).

overaa([overaa,lit(over),lit(å)],_7724,_7726) --> 
    cc(over,_7724,_7745),
    cc(å,_7745,_7726).

overaa([overaa,lit(til),lit(å)],_7724,_7726) --> 
    cc(til,_7724,_7745),
    cc(å,_7745,_7726).

verb_mod1(_7702,_7703,_7704,_7705,_7706,[verb_mod1,{},_7810,lit(å),!,_7850,{}],_7774,_7776) --> 
    {user:(\+testmember(_7702,[]))},
    instead_of(_7810,_7774,_7825),
    cc(å,_7825,_7844),
    !,
    pushstack(first,npgap(_7703),nil,_7844,_7893),clausal_object1(_7728,_7706,_7850,_7893,_7776),
    {user:verb_compl(_7702,instead_of,_7703,_7728,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7708,[verb_mod1,_7804,_7833,{},_7882,{}],_7778,_7780) --> 
    gradverb0(_7732,_7804,_7778,_7821),
    adverb(_7726,_7728,_7736,_7833,_7821,_7854),
    {user:testmember(_7726,[slowly,fast,thereafter])},
    not_look_ahead([det],_7882,_7854,_7780),
    {user:adv_compl(_7702,_7726,_7703,_7728,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},lit(om),lit(å),!,_7845,{}],_7782,_7784) --> 
    {user:testmember(_7702,[ask])},
    cc(om,_7782,_7828),
    cc(å,_7828,_7839),
    !,
    pushstack(first,npgap(_7703),nil,_7839,_7888),clausal_object1(_7731,_7708::_7709,_7845,_7888,_7784),
    {user:verb_compl(_7702,regarding,_7703,_7731,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},_7829,_7873,lit(å),!,_7933,{}],_7793,_7795) --> 
    {user:testmember(_7702,[extend,help])},
    optional([til],_7829,_7793,_7861),
    optional([med],_7873,_7861,_7905),
    cc(å,_7905,_7927),
    !,
    pushstack(first,npgap(_7703),nil,_7927,_7976),clausal_object1(_7734,_7708::_7709,_7933,_7976,_7795),
    {user:verb_compl(_7702,with,_7703,_7734,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,_7784,!,{}],_7758,_7760) --> 
    xadverbial1(_7720,_7722,_7708::_7709,_7784,_7758,_7760),
    !,
    {user:verb_compl(_7702,_7720,_7703,_7722,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},_7816,!,_7850,_7874,{}],_7780,_7782) --> 
    {user:testmember(_7702,[talk,speak])},
    look_ahead([om],_7816,_7780,_7833),
    !,
    accept(_7850,_7833,_7865),
    adverbial1(regarding,_7731,_7708::_7709,_7874,_7865,_7782),
    {user:verb_compl(_7702,regarding,_7703,_7731,_7704,_7705)}.

verb_mod1(adj/_7715/_7712,_7703,_7704,_7705,_7708::_7709,[verb_mod1,_7787,{}],_7761,_7763) --> 
    adverbial4(_7723,_7725,_7708::_7709,_7787,_7761,_7763),
    {user:adj_compl(_7712,_7723,_7703,_7725,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},_7809,{}],_7773,_7775) --> 
    {user:(\+testmember(_7702,[know,know1,speak,hope]))},
    adverbial3(_7720,_7722,_7708::_7709,_7809,_7773,_7775),
    {user:verb_compl(_7702,_7720,_7703,_7722,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},_7824,!,_7858,_7882,{}],_7788,_7790) --> 
    {user:testmember(_7702,[know,know1,ask,tell,speak,think])},
    look_ahead([om],_7824,_7788,_7841),
    !,
    accept(_7858,_7841,_7873),
    adverbial1(regarding,_7731,_7708::_7709,_7882,_7873,_7790),
    {user:verb_compl(_7702,regarding,_7703,_7731,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,srel/_7721/time/_7715/_7704,_7708::_7708,[verb_mod1,_7828,{},_7867,{},{},!,_7921],_7802,_7804) --> 
    w(prep(_7721),_7828,_7802,_7845),
    {user:testmember(_7721,[to,until])},
    w(adv(_7715),_7867,_7845,_7884),
    {user:testmember(_7715,[tomorrow])},
    {user:verb_compl(_7702,_7721,_7703,_7774:time,_7704,_7772)},
    !,
    accept(_7921,_7884,_7804).

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7708,[verb_mod1,_7777,{}],_7751,_7753) --> 
    xadverb(_7717,_7719,_7777,_7751,_7753),
    {user:adv_compl(_7702,_7717,_7703,_7719,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,_7781,{}],_7755,_7757) --> 
    adverbix(_7717,_7719,_7708::_7709,_7781,_7755,_7757),
    {user:verb_compl(_7702,_7717,_7703,_7719,_7704,_7705)}.

verb_mod1(_7702,_7703,_7704,_7705,_7708::_7709,[verb_mod1,{},_7852,_7881,{},{},!,_7945],_7816,_7818) --> 
    {user:(\+testmember(_7702,[go]))},
    nil_compl(_7702,_7852,_7816,_7869),
    adjunct1(nil,_7741,_7708::_7709,_7881,_7869,_7902),
    {user:(constrain(_7741,time);constrain(_7741,departure);constrain(_7741,arrival);constrain(_7741,route);constrain(_7741,number);constrain(_7741,bus))},
    {user:verb_compl(_7702,nil,_7703,_7741,_7704,_7705)},
    !,
    accept(_7945,_7902,_7818).

dir_compl(_7702,[dir_compl,{},!,_7763],_7734,_7736) --> 
    {user:v_compl(_7702,_7713,dir,_7715)},
    !,
    accept(_7763,_7734,_7736).

nil_compl(_7702,[nil_compl,_7750,_7784,!],_7736,_7738) --> 
    gmem(_7702,[have],_7750,_7736,_7769),
    look_ahead_lit([hver],_7784,_7769,_7738),
    !.

nil_compl(be/_7705,[nil_compl,{},!,_7766],_7737,_7739) --> 
    {user:a_compl(_7705,_7716,nil,_7718)},
    !,
    accept(_7766,_7737,_7739).

nil_compl(adj/nil/_7705,[nil_compl,{},!],_7737,_7737) --> 
    {user:(\+testmember(_7705,[]))},
    !.

nil_compl(adj/nil/_7705,[nil_compl,{},!,_7768],_7739,_7741) --> 
    {user:(\+post_adjective(_7705))},
    !,
    reject(_7768,_7739,_7741).

nil_compl(go,[nil_compl,_7957,{},_7996,_8025,_8054,_8083,_8112,_8141,_8170,_8199,_8228,_8257,_8286,_8315,_8344,_8373,_8402,_8431,_8460,_8489,_8518,_8547,_8576,!,_8610],_7943,_7945) --> 
    w(nb(_7778,num),_7957,_7943,_7974),
    {user:_7778<100},
    not_look_ahead(w(noun(time_count,plu,u,n)),_7996,_7974,_8013),
    not_look_ahead(w(nb(_7799,num)),_8025,_8013,_8042),
    not_look_ahead([:],_8054,_8042,_8071),
    not_look_ahead([?],_8083,_8071,_8100),
    not_look_ahead(['.'],_8112,_8100,_8129),
    not_look_ahead([/],_8141,_8129,_8158),
    not_look_ahead([den],_8170,_8158,_8187),
    not_look_ahead(w(name(_7826,_7827,month)),_8199,_8187,_8216),
    not_look_ahead(w(name(new_years_day,_7835,date)),_8228,_8216,_8245),
    not_look_ahead(w(name(whitsun_day,_7843,date)),_8257,_8245,_8274),
    not_look_ahead(w(name(christmas_day,_7851,date)),_8286,_8274,_8303),
    not_look_ahead(w(name(easterday,_7859,date)),_8315,_8303,_8332),
    not_look_ahead(w(prep(_7866)),_8344,_8332,_8361),
    not_look_ahead(w(prep(over)),_8373,_8361,_8390),
    not_look_ahead(w(prep(on)),_8402,_8390,_8419),
    not_look_ahead(w(prep(in)),_8431,_8419,_8448),
    not_look_ahead(w(noun(day,_7891,_7892,_7893)),_8460,_8448,_8477),
    not_look_ahead(w(noun(hour,_7900,_7901,_7902)),_8489,_8477,_8506),
    not_look_ahead(w(noun(minute,_7909,_7910,_7911)),_8518,_8506,_8535),
    not_look_ahead(w(noun(second,_7918,_7919,_7920)),_8547,_8535,_8564),
    not_look_ahead([om],_8576,_8564,_8593),
    !,
    reject(_8610,_8593,_7945).

nil_compl(_7702,[nil_compl,{},{},{},_7805,!,_7834],_7761,_7763) --> 
    {user:(\+abnormalverb(_7702,_7724))},
    {user:(\+testmember(_7702,[have,be_named]))},
    {user:v_compl(_7702,_7740,nil,_7742)},
    hver0(_7805,_7761,_7820),
    !,
    accept(_7834,_7820,_7763).

verb_modifier3(_7702,_7703,_7704,_7705,_7706,[verb_modifier3,_7799,_7930],_7773,_7775) --> 
    pushstack(free,(npgap(_7703),lexv(iv,_7702,pres,fin),prep(in),w(noun(time,sin,u,n))),nil,_7773,_7905),statreal(_7715,_7799,_7905,_7918),
    determiner00(_7704,_7705,_7715::_7706,_7930,_7918,_7775).

adverbix0(_7702,_7703,_7704,[adverbix0,_7754,!],_7734,_7736) --> 
    adverbix(_7702,_7703,_7704,_7754,_7734,_7736),
    !.

adverbix0(redundantly,nil:thing,_7706::_7706,[adverbix0,[]],_7733,_7733) --> 
    [].

adverbix(_7702,nil:_7710,_7706::_7706,[adverbix,_7766,{}],_7746,_7748) --> 
    w(adv(_7702),_7766,_7746,_7748),
    {user:particle(_7702,_7710,_7719)}.

adverbix(redundantly,nil:thing,_7706::_7706,[adverbix,_7760,!],_7740,_7742) --> 
    w(adv(redundantly),_7760,_7740,_7742),
    !.

adverbix(_7702,_7703,_7706::_7707,[adverbix,_7757],_7737,_7739) --> 
    adverbial1(_7702,_7703,_7706::_7707,_7757,_7737,_7739).

adverbix(_7702,nil:_7710,_7706::_7706,[adverbix,_7762,_7791],_7742,_7744) --> 
    gradverbs0(_7719,_7762,_7742,_7779),
    adverbx(_7702,_7710,_7717,_7791,_7779,_7744).

adverbix(nil,_7703,_7704,[adverbix,_7770,_7799,_7833],_7750,_7752) --> 
    look_ahead(w(noun(_7719,sin,u,n)),_7770,_7750,_7787),
    gmem(_7719,[midnight],_7799,_7787,_7818),
    complement_nil(_7703,_7704,_7833,_7818,_7752).

adverbix(nil,_7703,_7704,[adverbix,lit(den),_7776,_7805],_7745,_7747) --> 
    cc(den,_7745,_7775),
    look_ahead(w(nb(_7721,_7722)),_7776,_7775,_7793),
    complement_nil(_7703,_7704,_7805,_7793,_7747).

adverbial(_7702,_7703,_7706::_7707,[adverbial,_7757],_7737,_7739) --> 
    adverbial3(_7702,_7703,_7706::_7707,_7757,_7737,_7739).

adverbial(_7702,_7703,_7706::_7707,[adverbial,_7757],_7737,_7739) --> 
    adverbial1(_7702,_7703,_7706::_7707,_7757,_7737,_7739).

preadverbial0(_7702,_7703,_7704,[preadverbial0,_7754,!],_7734,_7736) --> 
    adverbial1(_7702,_7703,_7704,_7754,_7734,_7736),
    !.

preadverbial0(redundantly,nil:thing,_7706::_7706,[preadverbial0,[]],_7733,_7733) --> 
    [].

preadverbial1(_7702,_7703,_7704,[preadverbial1,_7793,_7822,_7851,{},_7890,!],_7773,_7775) --> 
    w(nb(_7723,num),_7793,_7773,_7810),
    w(noun(minute,_7729,_7730,_7731),_7822,_7810,_7839),
    look_ahead(w(prep(_7737)),_7851,_7839,_7868),
    {user:testmember(_7737,[before,after])},
    adverbial1(_7702,_7703,_7704,_7890,_7868,_7775),
    !.

preadverbial1(_7702,_7703,_7704,[preadverbial1,_7761,_7790,_7814],_7741,_7743) --> 
    not_look_ahead([e],_7761,_7741,_7778),
    not_look_ahead_np(_7790,_7778,_7805),
    adverbix(_7702,_7703,_7704,_7814,_7805,_7743).

preadverbial1(nil,_7703,_7704,[preadverbial1,_7775,!,_7809,_7833],_7755,_7757) --> 
    w(adj2(early,nil),_7775,_7755,_7792),
    !,
    accept(_7809,_7792,_7824),
    pushstack(first,w(noun(morning,sin,u,n)),nil,_7824,_7843),
    adjunct1(nil,_7703,_7704,_7833,_7843,_7757).

preadverbial1(before,1200:clock,_7706::_7706 and 1200 isa clock,[preadverbial1,_7766],_7746,_7748) --> 
    w(noun(morning,sin,u,n),_7766,_7746,_7748).

preadverbial1(before,1200:clock,_7706::_7706 and 1200 isa clock,[preadverbial1,_7766],_7746,_7748) --> 
    w(noun(prenoon,sin,u,n),_7766,_7746,_7748).

preadverbial1(after,1200:clock,_7706::_7706 and 1200 isa clock,[preadverbial1,_7766],_7746,_7748) --> 
    w(noun(afternoon,sin,u,n),_7766,_7746,_7748).

preadverbial1(after,1800:clock,_7706::_7706 and 1800 isa clock,[preadverbial1,_7766],_7746,_7748) --> 
    w(noun(night,sin,u,n),_7766,_7746,_7748).

preadverbial1(nil,_7703,_7704,[preadverbial1,_7756,!,_7795],_7736,_7738) --> 
    obviousclock1(_7703,_7704,_7756,_7736,_7775),
    !,
    accept(_7795,_7775,_7738).

preadverbial1(nil,_7703,_7704,[preadverbial1,_7756,!,_7795],_7736,_7738) --> 
    obviousdate1(_7703,_7704,_7756,_7736,_7775),
    !,
    accept(_7795,_7775,_7738).

preadverbials([preadverbials,_7734,!,_7763],_7723,_7725) --> 
    redundant(_7734,_7723,_7749),
    !,
    preadverbials(_7763,_7749,_7725).

preadverbials([preadverbials,_7751,!,[],_7841,_7865],_7740,_7742) --> 
    adverbix(_7714,_7715,_7716,_7751,_7740,_7772),
    !,
    pushstack(free,xadverbial1(_7714,_7715,_7716),nil,_7772,_7840),[],
    adverbial_conjunction0(_7841,_7840,_7856),
    preadverbials0(_7865,_7856,_7742).

preadverbials0([preadverbials0,_7731,!],_7720,_7722) --> 
    preadverbials(_7731,_7720,_7722),
    !.

preadverbials0([preadverbials0,[]],_7717,_7717) --> 
    [].

adverbial_conjunction0([adverbial_conjunction0,_7731,!],_7720,_7722) --> 
    adverbial_conjunction(_7731,_7720,_7722),
    !.

adverbial_conjunction0([adverbial_conjunction0,[]],_7717,_7717) --> 
    [].

adverbial_conjunction([adverbial_conjunction,lit(og),_7753,!],_7731,_7733) --> 
    cc(og,_7731,_7752),
    look_ahead(w(prep(_7714)),_7753,_7752,_7733),
    !.

adverbial1(_7702,_7703,_7704,[adverbial1,lit(slik),!,_7797],_7761,_7763) --> 
    cc(slik,_7761,_7791),
    !,
    pushstack(first,(w(prep(in)),w(noun(way,sin,def,n)),[som]),nil,_7791,_7807),
    adjunct1(_7702,_7703,_7704,_7797,_7807,_7763).

adverbial1(_7702,_7703,_7704,[adverbial1,lit(dit),_7807,!,_7846],_7776,_7778) --> 
    cc(dit,_7776,_7806),
    lit_of(_7726,[jeg,du],_7807,_7806,_7826),
    !,
    pushstack(first,(w(prep(to)),w(noun(place,sin,def,n)),[som],[_7726]),nil,_7826,_7856),
    adjunct1(_7702,_7703,_7704,_7846,_7856,_7778).

adverbial1(ago,_7703,_7704,[adverbial1,_7793,_7822,_7851,lit(siden),!,_7896],_7773,_7775) --> 
    prep1(for,_7793,_7773,_7810),
    anumber(_7736,_7822,_7810,_7839),
    w(noun(_7729,_7741,u,n),_7851,_7839,_7868),
    cc(siden,_7868,_7890),
    !,
    lock(exact,_7890,_7943),
    pushstack(exact,(number(_7736),w(noun(_7729,plu,u,n))),nil,_7943,_7949),
    np1(_7703,_7704,_7896,_7949,_7938),
    unlock(_7938,_7775).

adverbial1(in,_7715:day,_7706::exists(_7715:morrow)::_7715 isa morrow and _7706,[adverbial1,_7773,!,_7802],_7753,_7755) --> 
    tomorrow(_7773,_7753,_7788),
    !,
    accept(_7802,_7788,_7755).

adverbial1(_7702,_7703,_7704,[adverbial1,_7751],_7731,_7733) --> 
    adjunct1(_7702,_7703,_7704,_7751,_7731,_7733).

adverbial1(in,_7715:_7716,_7706::exists(_7715:_7716)::_7715 isa _7716 and _7706,[adverbial1,_7802,{},!,_7846],_7782,_7784) --> 
    w(noun(_7716,_7738,_7739,n),_7802,_7782,_7819),
    {user:testmember(_7716,[monday,tuesday,wednesday,thursday,friday,saturday,sunday])},
    !,
    accept(_7846,_7819,_7784).

adverbial3(_7702,_7709:_7710,_7706::_7707,[adverbial3,_7805,_7844,[],_7923,_7989],_7785,_7787) --> 
    xsubjunction(_7702,_7710,_7733,_7805,_7785,_7826),
    adverbial_object00(_7709:_7710,_7736,_7844,_7826,_7863),
    pushstack(free,adverbial1(_7733,_7709:_7710,_7736),nil,_7863,_7922),[],
    pushstack(first,([jeg],aux1),nil,_7922,_7964),substatement1(_7728,_7923,_7964,_7977),
    determiner00(_7709:_7710,_7706,_7728::_7707,_7989,_7977,_7787).

adverbial3(_7702,_7703,_7704,[adverbial3,lit(før),_7769,!,_7798],_7738,_7740) --> 
    cc(før,_7738,_7768),
    look_ahead_time(_7769,_7768,_7784),
    !,
    reject(_7798,_7784,_7740).

adverbial3(_7702,_7703,_7706::_7707,[adverbial3,lit(til),_7804,_7833,!,_7867,_7915],_7773,_7775) --> 
    cc(til,_7773,_7803),
    not_look_ahead([j],_7804,_7803,_7821),
    look_ahead([jeg],_7833,_7821,_7850),
    !,
    pushstack(first,w(prep(to)),nil,_7850,_7880),subordinate(_7702,_7703,_7728,_7867,_7880,_7897),
    determiner00(_7703,_7706,_7728::_7707,_7915,_7897,_7775).

adverbial3(_7702,_7703,_7706::_7707,[adverbial3,_7771,_7800,_7839],_7751,_7753) --> 
    not_look_ahead([til],_7771,_7751,_7788),
    subordinate(_7702,_7703,_7719,_7800,_7788,_7821),
    determiner00(_7703,_7706,_7719::_7707,_7839,_7821,_7753).

adverbial4(_7702,_7703,_7706::_7706 and _7710,[adverbial4,_7780,_7809,_7838,{}],_7760,_7762) --> 
    not_look_ahead([om],_7780,_7760,_7797),
    prep(_7724,_7809,_7797,_7826),
    clausal_object0(_7703,true::_7710,_7838,_7826,_7762),
    {user:adjustprep(_7703,_7724,_7702)}.

adverbial4(_7702,_7703,_7706::_7706 and _7710,[adverbial4,_7785,_7814,lit(at),_7854,{}],_7765,_7767) --> 
    not_look_ahead([om],_7785,_7765,_7802),
    prep(_7727,_7814,_7802,_7831),
    cc(at,_7831,_7853),
    clausal_object1(_7703,true::_7710,_7854,_7853,_7767),
    {user:adjustprep(_7703,_7727,_7702)}.

subordinate(nil,_7706:coevent,_7704,[subordinate,lit(de),lit(samme),lit(som),_7833,_7867],_7780,_7782) --> 
    cc(de,_7780,_7810),
    cc(samme,_7810,_7821),
    cc(som,_7821,_7832),
    adverbial_object00(_7706:coevent,_7732,_7833,_7832,_7852),
    lock(last,_7852,_7915),
    pushstack(last,([de],w(verb(be,pres,fin)),adverbial1(nil,_7706:coevent,_7732)),nil,_7915,_7921),
    substatement1(_7704,_7867,_7921,_7910),
    unlock(_7910,_7782).

subordinate(_7702,_7703,_7704,[subordinate,_7776,{},_7815,!,_7849],_7756,_7758) --> 
    w(prep(_7720),_7776,_7756,_7793),
    {user:testmember(_7720,[instead_of])},
    not_look_ahead_lit([at,å],_7815,_7793,_7832),
    !,
    reject(_7849,_7832,_7758).

subordinate(_7702,_7703,_7704,[subordinate,_7784,_7813,_7842,{},!,_7886],_7764,_7766) --> 
    not_look_ahead([siden],_7784,_7764,_7801),
    w(prep(_7727),_7813,_7801,_7830),
    look_ahead(w(noun(_7733,_7734,_7735,_7736)),_7842,_7830,_7859),
    {user:subclass0(_7733,time)},
    !,
    reject(_7886,_7859,_7766).

subordinate(_7702,_7703,_7704,[subordinate,_7770,_7809,_7838],_7750,_7752) --> 
    subjunction(_7702,_7713,_7712,_7770,_7750,_7791),
    not_look_ahead(w(verb(_7725,_7726,_7727)),_7809,_7791,_7826),
    subord_clause(_7712,_7713,_7703,_7704,_7838,_7826,_7752).

subord_clause(_7702,_7703,_7707:_7703,_7705,[subord_clause,_7780,!,_7819],_7757,_7759) --> 
    adverbial_object00(_7707:_7703,_7721,_7780,_7757,_7799),
    !,
    lock(last,_7799,_7867),
    pushstack(last,xadverbial1(_7702,_7707:_7703,_7721),nil,_7867,_7873),
    substatement1(_7705,_7819,_7873,_7862),
    unlock(_7862,_7759).

adverbial_object00(_7714:_7715,_7705::exists(_7714:_7715)::_7714 isa _7715 and _7705,[adverbial_object00,[]],_7744,_7744) --> 
    [].

subordinateinfnosubj(_7702,_7703,_7704,_7705,_7706,[subordinateinfnosubj,{},_7806,!,_7850],_7770,_7772) --> 
    {user:it_template(_7704)},
    np00(_7703,_7724,_7727::_7728,_7806,_7770,_7827),
    !,
    pushstack(free,(npgap(_7704),adverbial1(_7702,_7724,_7727::_7728)),nil,_7827,_7925),
    statreal(_7706,_7850,_7925,_7772).

subordinateinfnosubj(_7702,_7703,_7704,_7705,_7706,[subordinateinfnosubj,{},_7841,{},!,_7900,!,_7944],_7805,_7807) --> 
    {user:(\+it_template(_7704))},
    lexv(tv,_7752,_7753,fin,_7841,_7805,_7864),
    {user:testmember(_7752,[take])},
    !,
    np00(_7703,_7739,_7742::_7743,_7900,_7864,_7921),
    !,
    pushstack(free,(someone,w(verb(_7752,pres,fin)),npgap(_7704),adverbial1(_7702,_7739,_7742::_7743)),nil,_7921,_8047),
    statreal(_7706,_7944,_8047,_7807).

subordinateinfnosubj(_7702,_7703,_7704,_7705,_7706,[subordinateinfnosubj,{},_7841,{},!,_7900,!,_7944],_7805,_7807) --> 
    {user:(\+it_template(_7704))},
    lexv(tv,_7752,_7753,fin,_7841,_7805,_7864),
    {user:testmember(_7752,[help])},
    !,
    np00(_7703,_7739,_7742::_7743,_7900,_7864,_7921),
    !,
    pushstack(free,(npgap(_7704),w(verb(_7752,pres,fin)),someone,adverbial1(_7702,_7739,_7742::_7743)),nil,_7921,_8047),
    statreal(_7706,_7944,_8047,_7807).

partday(_7702,_7703,_7704,[partday,_7766,{},!],_7746,_7748) --> 
    w(noun(_7702,_7715,_7716,n),_7766,_7746,_7748),
    {user:particle(_7702,_7703,_7704)},
    !.

partday(tomorrow,_7703,_7704,[partday,_7781,_7805,_7834,_7863,!,{}],_7761,_7763) --> 
    to0(_7781,_7761,_7796),
    prep1(in,_7805,_7796,_7822),
    not_look_ahead([formiddag],_7834,_7822,_7851),
    w(noun(morning,_7736,_7737,n),_7863,_7851,_7763),
    !,
    {user:particle(tomorrow,_7703,_7704)}.

partday(tomorrow,_7703,_7704,[partday,_7774,_7798,_7827,!,{}],_7754,_7756) --> 
    to0(_7774,_7754,_7789),
    prep1(in,_7798,_7789,_7815),
    w(noun(morrow,_7729,_7730,n),_7827,_7815,_7756),
    !,
    {user:particle(tomorrow,_7703,_7704)}.

partday(_7702,_7703,_7704,[partday,_7780,_7809,!,{},{}],_7760,_7762) --> 
    inom(_7724,_7780,_7760,_7797),
    w(noun(_7728,_7729,_7730,n),_7809,_7797,_7762),
    !,
    {user:norpart(_7724,_7728,_7702)},
    {user:particle(_7702,_7703,_7704)}.

adverbx(with,mode,post,[adverbx,lit(med),_7766,!],_7735,_7737) --> 
    cc(med,_7735,_7765),
    not_look_ahead_np(_7766,_7765,_7737),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),_7766,!],_7735,_7737) --> 
    cc(etter,_7735,_7765),
    terminatore(_7766,_7765,_7737),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),lit(det),!],_7737,_7739) --> 
    cc(etter,_7737,_7767),
    cc(det,_7767,_7739),
    !.

adverbx(earlier,time,post,[adverbx,lit(før),lit(det),!],_7737,_7739) --> 
    cc(før,_7737,_7767),
    cc(det,_7767,_7739),
    !.

adverbx(_7702,_7703,_7704,[adverbx,lit(slik),lit(at),!,_7787],_7740,_7742) --> 
    cc(slik,_7740,_7770),
    cc(at,_7770,_7781),
    !,
    reject(_7787,_7781,_7742).

adverbx(_7702,_7703,_7704,[adverbx,_7766,_7790,!,{}],_7746,_7748) --> 
    not_look_ahead_prepx(_7766,_7746,_7781),
    w(adv(_7702),_7790,_7781,_7748),
    !,
    {user:particle(_7702,_7703,_7704)}.

not_look_ahead_prepx([not_look_ahead_prepx,lit(med),_7747,!],_7725,_7727) --> 
    cc(med,_7725,_7746),
    look_ahead_np(_7747,_7746,_7727),
    !.

not_look_ahead_prepx([not_look_ahead_prepx,_7734],_7723,_7725) --> 
    not_look_ahead(w(prep(_7706)),_7734,_7723,_7725).

adverbx(_7702,_7703,_7704,[adverbx,_7751],_7731,_7733) --> 
    adverb(_7702,_7703,_7704,_7751,_7731,_7733).

adverbx(_7702,_7703,_7704,[adverbx,_7751],_7731,_7733) --> 
    partday(_7702,_7703,_7704,_7751,_7731,_7733).

adverbx(yesterday,_7703,_7704,[adverbx,_7766,lit(går),!,{}],_7746,_7748) --> 
    prep1(in,_7766,_7746,_7783),
    cc(går,_7783,_7748),
    !,
    {user:particle(yesterday,_7703,_7704)}.

anyadverb0([anyadverb0,_7748,_7772,!,[]],_7737,_7739) --> 
    therenot0(_7748,_7737,_7763),
    adverb(_7714,_7715,_7716,_7772,_7763,_7793),
    !,
    pushstack(free,adverb(_7714,_7715,_7716),nil,_7793,_7739),
    [].

anyadverb0([anyadverb0,_7728],_7717,_7719) --> 
    therenot0(_7728,_7717,_7719).

adverbx0([adverbx0,_7735,!],_7724,_7726) --> 
    w(adv(redundantly),_7735,_7724,_7726),
    !.

adverbx0([adverbx0,_7778,_7807,_7836,{},!,[]],_7767,_7769) --> 
    not_look_ahead(w(noun(_7728,sin,u,n)),_7778,_7767,_7795),
    not_look_ahead(w(prep(_7737)),_7807,_7795,_7824),
    adverb(_7720,_7721,_7722,_7836,_7824,_7857),
    {user:(\+testmember(_7720,[home]))},
    !,
    pushstack(free,adverb(_7720,_7721,_7722),nil,_7857,_7769),
    [].

adverbx0([adverbx0,[]],_7717,_7717) --> 
    [].

adverb0(_7702,_7703,_7704,[adverb0,_7754,!],_7734,_7736) --> 
    adverb(_7702,_7703,_7704,_7754,_7734,_7736),
    !.

adverb0(redundantly,thing,post,[adverb0,[]],_7727,_7727) --> 
    [].

adverb(delayed,time,post,[adverb,_7755,!],_7735,_7737) --> 
    w(adj2(delayed,nil),_7755,_7735,_7737),
    !.

adverb(_7702,_7703,_7704,[adverb,_7773,_7802,_7831,{}],_7753,_7755) --> 
    gradverb0(_7721,_7773,_7753,_7790),
    not_look_ahead([siste],_7802,_7790,_7819),
    w(adj2(_7702,nil),_7831,_7819,_7755),
    {user:particle(_7702,_7703,_7704)}.

adverb(now,_7703,_7704,[adverb,_7761,_7790,{}],_7741,_7743) --> 
    prep1(with,_7761,_7741,_7778),
    detsamme(_7790,_7778,_7743),
    {user:particle(now,_7703,_7704)}.

adverb(first,time,_7704,[adverb,lit(først)],_7729,_7731) --> 
    cc(først,_7729,_7731).

adverb(today,day,pre,[adverb,_7759,_7788],_7739,_7741) --> 
    prep1(in,_7759,_7739,_7776),
    w(noun(day,sin,u,n),_7788,_7776,_7741).

adverb(tomorrow,day,pre,[adverb,_7754,lit(morgen)],_7734,_7736) --> 
    prep1(in,_7754,_7734,_7771),
    cc(morgen,_7771,_7736).

adverb(day_after_tomorrow,day,pre,[adverb,_7754,lit(overimorgen)],_7734,_7736) --> 
    prep1(in,_7754,_7734,_7771),
    cc(overimorgen,_7771,_7736).

adverb(day_before_yesterday,day,pre,[adverb,_7754,lit(forgårs)],_7734,_7736) --> 
    prep1(in,_7754,_7734,_7771),
    cc(forgårs,_7771,_7736).

adverb(tonight,daypart,pre,[adverb,_7759,_7788],_7739,_7741) --> 
    prep1(in,_7759,_7739,_7776),
    w(noun(night,_7712,_7713,_7714),_7788,_7776,_7741).

adverb(today,day,pre,[adverb,_7759,_7788],_7739,_7741) --> 
    prep1(in,_7759,_7739,_7776),
    w(noun(day,_7712,_7713,_7714),_7788,_7776,_7741).

adverb(locally,place,post,[adverb,lit(lokalt)],_7729,_7731) --> 
    cc(lokalt,_7729,_7731).

adverb(_7702,_7703,_7704,[adverb,_7760,_7789,!,_7818],_7740,_7742) --> 
    w(prep(_7717),_7760,_7740,_7777),
    look_ahead_np(_7789,_7777,_7804),
    !,
    reject(_7818,_7804,_7742).

adverb(_7702,_7703,_7704,[adverb,_7758,{}],_7738,_7740) --> 
    particle(_7702,_7758,_7738,_7740),
    {user:particle(_7702,_7703,_7704)}.

adverb(_7702,_7703,_7704,[adverb,_7796,{},_7835,_7864,{},_7903],_7776,_7778) --> 
    particle(_7702,_7796,_7776,_7813),
    {user:testmember(_7702,[on,off])},
    not_look_ahead(w(noun(_7736,_7737,_7738,_7739)),_7835,_7813,_7852),
    not_look_ahead(w(name(_7745,_7746,_7747)),_7864,_7852,_7881),
    {user:particle(_7702,_7703,_7704)},
    da0(_7903,_7881,_7778).

particlev0(_7702,_7703,[particlev0,_7747,!],_7730,_7732) --> 
    particlev2(_7702,_7703,_7747,_7730,_7732),
    !.

particlev0(_7702,_7702,[particlev0,_7743],_7726,_7728) --> 
    particlev1(_7702,_7743,_7726,_7728).

particlev0(_7702,_7702,[particlev0,[]],_7724,_7724) --> 
    [].

particle0(_7702,[particle0,_7740,!],_7726,_7728) --> 
    particle(_7702,_7740,_7726,_7728),
    !.

particle0(_7702,[particle0,[]],_7721,_7721) --> 
    [].

particlev1(believe,[particlev1,lit(på)],_7723,_7725) --> 
    cc(på,_7723,_7725).

particlev1(calculate,[particlev1,lit(med)],_7723,_7725) --> 
    cc(med,_7723,_7725).

particlev1(check,[particlev1,lit(opp)],_7723,_7725) --> 
    cc(opp,_7723,_7725).

particlev1(come,[particlev1,lit(med),_7751],_7726,_7728) --> 
    cc(med,_7726,_7750),
    not_look_ahead_np(_7751,_7750,_7728).

particlev1(come,[particlev1,lit(til),_7751],_7726,_7728) --> 
    cc(til,_7726,_7750),
    not_look_ahead_np(_7751,_7750,_7728).

particlev1(come,[particlev1,lit(opp)],_7723,_7725) --> 
    cc(opp,_7723,_7725).

particlev1(correct,[particlev1,lit(opp)],_7723,_7725) --> 
    cc(opp,_7723,_7725).

particlev1(fetch,[particlev1,lit(ned)],_7723,_7725) --> 
    cc(ned,_7723,_7725).

particlev1(fetch,[particlev1,lit(opp)],_7723,_7725) --> 
    cc(opp,_7723,_7725).

particlev1(find,[particlev1,lit(ut),lit(av)],_7728,_7730) --> 
    cc(ut,_7728,_7752),
    cc(av,_7752,_7730).

particlev1(get,[particlev1,lit(med)],_7723,_7725) --> 
    cc(med,_7723,_7725).

particlev1(get,[particlev1,lit(opp)],_7723,_7725) --> 
    cc(opp,_7723,_7725).

particlev1(have,[particlev1,lit(på)],_7723,_7725) --> 
    cc(på,_7723,_7725).

particlev1(help,[particlev1,lit(til),lit(med)],_7728,_7730) --> 
    cc(til,_7728,_7752),
    cc(med,_7752,_7730).

particlev1(help,[particlev1,lit(til)],_7723,_7725) --> 
    cc(til,_7723,_7725).

particlev1(improve,[particlev1,lit(inn)],_7723,_7725) --> 
    cc(inn,_7723,_7725).

particlev1(indicte,[particlev1,lit(på)],_7723,_7725) --> 
    cc(på,_7723,_7725).

particlev1(lay,[particlev1,lit(inn)],_7723,_7725) --> 
    cc(inn,_7723,_7725).

particlev1(lie1,[particlev1,lit(med)],_7723,_7725) --> 
    cc(med,_7723,_7725).

particlev1(name,[particlev1,lit(til)],_7723,_7725) --> 
    cc(til,_7723,_7725).

particlev1(reach,[particlev1,lit(til)],_7723,_7725) --> 
    cc(til,_7723,_7725).

particlev1(reach,[particlev1,lit(fram),lit(til)],_7728,_7730) --> 
    cc(fram,_7728,_7752),
    cc(til,_7752,_7730).

particlev1(read,[particlev1,lit(gjennom)],_7723,_7725) --> 
    cc(gjennom,_7723,_7725).

particlev1(receive,[particlev1,lit(opp)],_7723,_7725) --> 
    cc(opp,_7723,_7725).

particlev1(get,[particlev1,lit(opp)],_7723,_7725) --> 
    cc(opp,_7723,_7725).

particlev1(send,[particlev1,lit(med)],_7723,_7725) --> 
    cc(med,_7723,_7725).

particlev1(send,[particlev1,lit(over)],_7723,_7725) --> 
    cc(over,_7723,_7725).

particlev1(send,[particlev1,lit(ved)],_7723,_7725) --> 
    cc(ved,_7723,_7725).

particlev1(sing,[particlev1,lit(ut)],_7723,_7725) --> 
    cc(ut,_7723,_7725).

particlev1(take,[particlev1,lit(ut)],_7723,_7725) --> 
    cc(ut,_7723,_7725).

particlev1(throw,[particlev1,lit(av)],_7723,_7725) --> 
    cc(av,_7723,_7725).

particlev1(tell,[particlev1,lit(inn)],_7723,_7725) --> 
    cc(inn,_7723,_7725).

particlev1(tell,[particlev1,lit(om)],_7723,_7725) --> 
    cc(om,_7723,_7725).

particlev1(tell,[particlev1,lit(fra),lit(om),!],_7731,_7733) --> 
    cc(fra,_7731,_7755),
    cc(om,_7755,_7733),
    !.

particlev1(tell,[particlev1,lit(fra)],_7723,_7725) --> 
    cc(fra,_7723,_7725).

particlev1(tell,[particlev1,lit(ifra)],_7723,_7725) --> 
    cc(ifra,_7723,_7725).

particlev1(tell,[particlev1,_7739],_7725,_7727) --> 
    w(prep(regarding),_7739,_7725,_7727).

particlev1(wonder,[particlev1,lit(på)],_7723,_7725) --> 
    cc(på,_7723,_7725).

particlev1(write,[particlev1,lit(inn)],_7723,_7725) --> 
    cc(inn,_7723,_7725).

particlev2(avoid,release,[particlev2,lit(fri)],_7726,_7728) --> 
    cc(fri,_7726,_7728).

particlev2(be,come,[particlev2,lit(med)],_7726,_7728) --> 
    cc(med,_7726,_7728).

particlev2(belong,belong_to,[particlev2,lit(til)],_7726,_7728) --> 
    cc(til,_7726,_7728).

particlev2(hear,belong_to,[particlev2,lit(til)],_7726,_7728) --> 
    cc(til,_7726,_7728).

particlev2(calculate,expect,[particlev2,lit(med)],_7726,_7728) --> 
    cc(med,_7726,_7728).

particlev2(care1,ensure,[particlev2,lit(for)],_7726,_7728) --> 
    cc(for,_7726,_7728).

particlev2(come,appear,[particlev2,lit(fram)],_7726,_7728) --> 
    cc(fram,_7726,_7728).

particlev2(come,disappear,[particlev2,lit(bort),_7763],_7735,_7737) --> 
    cc(bort,_7735,_7762),
    not_look_ahead(w(prep(to)),_7763,_7762,_7737).

particlev2(comment,remove,[particlev2,lit(ut)],_7726,_7728) --> 
    cc(ut,_7726,_7728).

particlev2(do1,finish,[particlev2,lit(ferdig)],_7726,_7728) --> 
    cc(ferdig,_7726,_7728).

particlev2(do1,make,[particlev2,lit(meg)],_7726,_7728) --> 
    cc(meg,_7726,_7728).

particlev2(find,do1,[particlev2,lit(på)],_7726,_7728) --> 
    cc(på,_7726,_7728).

particlev2(find,discover,[particlev2,lit(ut)],_7726,_7728) --> 
    cc(ut,_7726,_7728).

particlev2(fool,wonder,[particlev2,lit(på)],_7726,_7728) --> 
    cc(på,_7726,_7728).

particlev2(go,stop,[particlev2,lit(ned)],_7726,_7728) --> 
    cc(ned,_7726,_7728).

particlev2(get,manage,[particlev2,lit(til)],_7726,_7728) --> 
    cc(til,_7726,_7728).

particlev2(have,bring,[particlev2,lit(med)],_7726,_7728) --> 
    cc(med,_7726,_7728).

particlev2(hold,be,[particlev2,lit(deg)],_7726,_7728) --> 
    cc(deg,_7726,_7728).

particlev2(hold,be,[particlev2,lit(meg)],_7726,_7728) --> 
    cc(meg,_7726,_7728).

particlev2(hold,be,[particlev2,lit(seg)],_7726,_7728) --> 
    cc(seg,_7726,_7728).

particlev2(hold,do1,[particlev2,lit(på),lit(med)],_7731,_7733) --> 
    cc(på,_7731,_7758),
    cc(med,_7758,_7733).

particlev2(hold,be1,[particlev2,lit(til)],_7726,_7728) --> 
    cc(til,_7726,_7728).

particlev2(hold,wait,[particlev2,lit(ut)],_7726,_7728) --> 
    cc(ut,_7726,_7728).

particlev2(improve,ensure,[particlev2,lit(inn)],_7726,_7728) --> 
    cc(inn,_7726,_7728).

particlev2(lay,include,[particlev2,lit(inn)],_7726,_7728) --> 
    cc(inn,_7726,_7728).

particlev2(lay,include,[particlev2,lit(på)],_7726,_7728) --> 
    cc(på,_7726,_7728).

particlev2(lay,enclose,[particlev2,lit(ved)],_7726,_7728) --> 
    cc(ved,_7726,_7728).

particlev2(lay,stop,[particlev2,lit(ned)],_7726,_7728) --> 
    cc(ned,_7726,_7728).

particlev2(lay,change,[particlev2,lit(om)],_7726,_7728) --> 
    cc(om,_7726,_7728).

particlev2(lead,cause,[particlev2,lit(til)],_7726,_7728) --> 
    cc(til,_7726,_7728).

particlev2(lie1,belong_to,[particlev2,lit(under)],_7726,_7728) --> 
    cc(under,_7726,_7728).

particlev2(list,list,[particlev2,lit(opp)],_7726,_7728) --> 
    cc(opp,_7726,_7728).

particlev2(long,want,[particlev2,lit(etter)],_7726,_7728) --> 
    cc(etter,_7726,_7728).

particlev2(look,appear,[particlev2,lit(ut)],_7726,_7728) --> 
    cc(ut,_7726,_7728).

particlev2(meet,meetup,[particlev2,lit(opp)],_7726,_7728) --> 
    cc(opp,_7726,_7728).

particlev2(negotiate,discuss,[particlev2,lit(om)],_7726,_7728) --> 
    cc(om,_7726,_7728).

particlev2(operate,do1,[particlev2,_7750,lit(med)],_7733,_7735) --> 
    optional([på],_7750,_7733,_7782),
    cc(med,_7782,_7735).

particlev2(pay,pay2,[particlev2,lit(seg)],_7726,_7728) --> 
    cc(seg,_7726,_7728).

particlev2(put,arrange,[particlev2,lit(opp)],_7726,_7728) --> 
    cc(opp,_7726,_7728).

particlev2(say,tell,[particlev2,lit(fra)],_7726,_7728) --> 
    cc(fra,_7726,_7728).

particlev2(say,tell,[particlev2,lit(ifra)],_7726,_7728) --> 
    cc(ifra,_7726,_7728).

particlev2(see,appear,[particlev2,lit(ut)],_7726,_7728) --> 
    cc(ut,_7726,_7728).

particlev2(see,appear,[particlev2,lit(ut)],_7726,_7728) --> 
    cc(ut,_7726,_7728).

particlev2(stand,indicate,[particlev2,lit(for)],_7726,_7728) --> 
    cc(for,_7726,_7728).

particlev2(take,bring,[particlev2,lit(med)],_7726,_7728) --> 
    cc(med,_7726,_7728).

particlev2(take,manage,[particlev2,lit(over)],_7726,_7728) --> 
    cc(over,_7726,_7728).

particlev2(take,get,[particlev2,lit(til),_7757],_7729,_7731) --> 
    cc(til,_7729,_7756),
    rfxpron(_7757,_7756,_7731).

particlev2(take,get,[particlev2,lit(mot)],_7726,_7728) --> 
    cc(mot,_7726,_7728).

particlev2(take,get,[particlev2,lit(imot)],_7726,_7728) --> 
    cc(imot,_7726,_7728).

particlev2(take,get,[particlev2,lit(i),lit(mot)],_7731,_7733) --> 
    cc(i,_7731,_7758),
    cc(mot,_7758,_7733).

particlev2(take,treat,[particlev2,lit(opp)],_7726,_7728) --> 
    cc(opp,_7726,_7728).

particlev2(turn,stop,[particlev2,lit(av)],_7726,_7728) --> 
    cc(av,_7726,_7728).

particlev2(turn,start,[particlev2,lit(på)],_7726,_7728) --> 
    cc(på,_7726,_7728).

particlev2(write,print,[particlev2,lit(ut)],_7726,_7728) --> 
    cc(ut,_7726,_7728).

rep_particlev0(_7702,[rep_particlev0,_7740,!],_7726,_7728) --> 
    rep_particlev(_7702,_7740,_7726,_7728),
    !.

rep_particlev0(_7702,[rep_particlev0,[]],_7721,_7721) --> 
    [].

rep_particlev(ask,[rep_particlev,lit(:),!],_7726,_7728) --> 
    cc(:,_7726,_7728),
    !.

rep_particlev(deny,[rep_particlev,lit(for)],_7723,_7725) --> 
    cc(for,_7723,_7725).

rep_particlev(wonder,[rep_particlev,lit(på),_7757,!,_7786],_7732,_7734) --> 
    cc(på,_7732,_7756),
    which0(_7757,_7756,_7772),
    !,
    accept(_7786,_7772,_7734).

rep_particlev(know,[rep_particlev,_7743,!,_7777],_7729,_7731) --> 
    prep1(to,_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

rep_particlev(find,[rep_particlev,lit(ut)],_7723,_7725) --> 
    cc(ut,_7723,_7725).

rep_particlev(recognize,[rep_particlev,lit(til)],_7723,_7725) --> 
    cc(til,_7723,_7725).

rep_particlev(think,[rep_particlev,lit(på),_7761,!,_7795],_7736,_7738) --> 
    cc(på,_7736,_7760),
    not_look_ahead([om],_7761,_7760,_7778),
    !,
    reject(_7795,_7778,_7738).

rep_particlev(think,[rep_particlev,lit(på),_7761,!,_7795],_7736,_7738) --> 
    cc(på,_7736,_7760),
    not_look_ahead([at],_7761,_7760,_7778),
    !,
    reject(_7795,_7778,_7738).

rep_particlev(think,[rep_particlev,lit(på),!,_7759],_7729,_7731) --> 
    cc(på,_7729,_7753),
    !,
    accept(_7759,_7753,_7731).

particle(redundantly,[particle,_7735],_7721,_7723) --> 
    redundant(_7735,_7721,_7723).

particle(_7702,[particle,_7742,!],_7728,_7730) --> 
    w(adv(_7702),_7742,_7728,_7730),
    !.

particle(back,[particle,lit(tilbake)],_7723,_7725) --> 
    cc(tilbake,_7723,_7725).

particle(badly,[particle,lit(dårlig)],_7723,_7725) --> 
    cc(dårlig,_7723,_7725).

particle(beforethat,[particle,_7735],_7721,_7723) --> 
    beforethat(_7735,_7721,_7723).

particle(daily,[particle,lit(daglig)],_7723,_7725) --> 
    cc(daglig,_7723,_7725).

particle(day_after_tomorrow,[particle,lit(overimorgen)],_7723,_7725) --> 
    cc(overimorgen,_7723,_7725).

particle(directly,[particle,lit(direkte)],_7723,_7725) --> 
    cc(direkte,_7723,_7725).

particle(down,[particle,lit(ned)],_7723,_7725) --> 
    cc(ned,_7723,_7725).

particle(down,[particle,lit(under)],_7723,_7725) --> 
    cc(under,_7723,_7725).

particle(earlier,[particle,_7735],_7721,_7723) --> 
    earlier(_7735,_7721,_7723).

particle(early,[particle,lit(så),lit(tidlig),lit(som),_7794,!,_7828],_7747,_7749) --> 
    cc(så,_7747,_7771),
    cc(tidlig,_7771,_7782),
    cc(som,_7782,_7793),
    w(adj2(possible,nil),_7794,_7793,_7811),
    !,
    accept(_7828,_7811,_7749).

particle(early,[particle,lit(tidligst),_7762,!,_7796],_7737,_7739) --> 
    cc(tidligst,_7737,_7761),
    w(adj2(possible,nil),_7762,_7761,_7779),
    !,
    accept(_7796,_7779,_7739).

particle(early,[particle,lit(tidlig)],_7723,_7725) --> 
    cc(tidlig,_7723,_7725).

particle(early,[particle,lit(am)],_7723,_7725) --> 
    cc(am,_7723,_7725).

particle(eastward,[particle,lit(østover)],_7723,_7725) --> 
    cc(østover,_7723,_7725).

particle(everywhere,[particle,lit(overalt)],_7723,_7725) --> 
    cc(overalt,_7723,_7725).

particle(far,[particle,lit(langt)],_7723,_7725) --> 
    cc(langt,_7723,_7725).

particle(fast,[particle,lit(fort)],_7723,_7725) --> 
    cc(fort,_7723,_7725).

particle(fast,[particle,_7740],_7726,_7728) --> 
    w(adj2(fast,comp),_7740,_7726,_7728).

particle(from,[particle,lit(ifra)],_7723,_7725) --> 
    cc(ifra,_7723,_7725).

particle(gratis,[particle,lit(gratis)],_7723,_7725) --> 
    cc(gratis,_7723,_7725).

particle(home,[particle,lit(hjem),_7759,!,_7793],_7734,_7736) --> 
    cc(hjem,_7734,_7758),
    prep1(to,_7759,_7758,_7776),
    !,
    reject(_7793,_7776,_7736).

particle(home,[particle,_7740,lit(hjem)],_7726,_7728) --> 
    to0(_7740,_7726,_7755),
    cc(hjem,_7755,_7728).

particle(here,[particle,_7740,lit(hit)],_7726,_7728) --> 
    to0(_7740,_7726,_7755),
    cc(hit,_7755,_7728).

particle(here,[particle,_7740,lit(her)],_7726,_7728) --> 
    to0(_7740,_7726,_7755),
    cc(her,_7755,_7728).

particle(hereafter,[particle,_7735],_7721,_7723) --> 
    hereafter(_7735,_7721,_7723).

particle(in,[particle,lit(inn)],_7723,_7725) --> 
    cc(inn,_7723,_7725).

particle(in_morning,[particle,lit(ommorgenen)],_7723,_7725) --> 
    cc(ommorgenen,_7723,_7725).

particle(late,[particle,_7740,lit(sent)],_7726,_7728) --> 
    so0(_7740,_7726,_7755),
    cc(sent,_7755,_7728).

particle(late,[particle,_7740,lit(sent)],_7726,_7728) --> 
    too(_7740,_7726,_7755),
    cc(sent,_7755,_7728).

particle(lay,[particle,lit(ut)],_7723,_7725) --> 
    cc(ut,_7723,_7725).

particle(lay,[particle,lit(inn)],_7723,_7725) --> 
    cc(inn,_7723,_7725).

particle(lay,[particle,lit(ved)],_7723,_7725) --> 
    cc(ved,_7723,_7725).

particle(logically,[particle,lit(logisk)],_7723,_7725) --> 
    cc(logisk,_7723,_7725).

particle(much,[particle,_7740,lit(mye)],_7726,_7728) --> 
    so(_7740,_7726,_7755),
    cc(mye,_7755,_7728).

particle(normally,[particle,lit(normalt)],_7723,_7725) --> 
    cc(normalt,_7723,_7725).

particle(northward,[particle,lit(nordover)],_7723,_7725) --> 
    cc(nordover,_7723,_7725).

particle(now,[particle,_7735],_7721,_7723) --> 
    now1(_7735,_7721,_7723).

particle(now,[particle,_7742,lit(øyeblikket)],_7728,_7730) --> 
    prep1(for,_7742,_7728,_7759),
    cc(øyeblikket,_7759,_7730).

particle(on,[particle,_7737],_7723,_7725) --> 
    prep1(on,_7737,_7723,_7725).

particle(off,[particle,lit(av)],_7723,_7725) --> 
    cc(av,_7723,_7725).

particle(offside,[particle,_7738,_7762],_7724,_7726) --> 
    and0(_7738,_7724,_7753),
    compassly(_7762,_7753,_7726).

particle(often,[particle,_7740,lit(ofte)],_7726,_7728) --> 
    so0(_7740,_7726,_7755),
    cc(ofte,_7755,_7728).

particle(recently,[particle,_7735],_7721,_7723) --> 
    recently(_7735,_7721,_7723).

particle(out,[particle,lit(ut)],_7723,_7725) --> 
    cc(ut,_7723,_7725).

particle(past,[particle,lit(forbi)],_7723,_7725) --> 
    cc(forbi,_7723,_7725).

particle(present,[particle,lit(framme)],_7723,_7725) --> 
    cc(framme,_7723,_7725).

particle(punctually,[particle,lit(presis)],_7723,_7725) --> 
    cc(presis,_7723,_7725).

particle(punctually,[particle,_7740],_7726,_7728) --> 
    w(adj2(punctual,nil),_7740,_7726,_7728).

particle(punctually,[particle,_7742,lit(tide)],_7728,_7730) --> 
    prep1(in,_7742,_7728,_7759),
    cc(tide,_7759,_7730).

particle(regularly,[particle,lit(som),lit(normalt)],_7728,_7730) --> 
    cc(som,_7728,_7752),
    cc(normalt,_7752,_7730).

particle(silent,[particle,lit(stille)],_7723,_7725) --> 
    cc(stille,_7723,_7725).

particle(simultaneously,[particle,lit(samtidig)],_7723,_7725) --> 
    cc(samtidig,_7723,_7725).

particle(slowly,[particle,lit(langsomt)],_7723,_7725) --> 
    cc(langsomt,_7723,_7725).

particle(somewhere,[particle,lit(noensted)],_7723,_7725) --> 
    cc(noensted,_7723,_7725).

particle(southward,[particle,lit(sørover)],_7723,_7725) --> 
    cc(sørover,_7723,_7725).

particle(there,[particle,lit(dit)],_7723,_7725) --> 
    cc(dit,_7723,_7725).

particle(there,[particle,lit(der)],_7723,_7725) --> 
    cc(der,_7723,_7725).

particle(there,[particle,_7740],_7726,_7728) --> 
    w(adj2(present,nil),_7740,_7726,_7728).

particle(thereafter,[particle,_7735],_7721,_7723) --> 
    thereafter(_7735,_7721,_7723).

particle(this_midnight,[particle,lit(inatt)],_7723,_7725) --> 
    cc(inatt,_7723,_7725).

particle(today,[particle,lit(idag)],_7723,_7725) --> 
    cc(idag,_7723,_7725).

particle(together,[particle,lit(sammen)],_7723,_7725) --> 
    cc(sammen,_7723,_7725).

particle(tomorrow,[particle,lit(imorgen)],_7723,_7725) --> 
    cc(imorgen,_7723,_7725).

particle(tonight,[particle,lit(ikveld)],_7723,_7725) --> 
    cc(ikveld,_7723,_7725).

particle(up,[particle,lit(opp)],_7723,_7725) --> 
    cc(opp,_7723,_7725).

particle(well,[particle,lit(bra)],_7723,_7725) --> 
    cc(bra,_7723,_7725).

particle(well,[particle,lit(best)],_7723,_7725) --> 
    cc(best,_7723,_7725).

particle(well,[particle,lit(vel)],_7723,_7725) --> 
    cc(vel,_7723,_7725).

particle(westward,[particle,lit(vestover)],_7723,_7725) --> 
    cc(vestover,_7723,_7725).

particle(with1,[particle,lit(med),_7759],_7734,_7736) --> 
    cc(med,_7734,_7758),
    not_look_ahead(w(name(_7711,_7712,_7713)),_7759,_7758,_7736).

particle(wrongly,[particle,_7740,lit(feil)],_7726,_7728) --> 
    saa0(_7740,_7726,_7755),
    cc(feil,_7755,_7728).

particle(yesterday,[particle,lit(igår)],_7723,_7725) --> 
    cc(igår,_7723,_7725).

adjunct1(_7702,_7703,_7706::_7707,[adjunct1,{},_7850,_7879,_7903,{},!,_7947,!,_8008],_7820,_7822) --> 
    {user:_7702==nil},
    w(nb(_7740,_7741),_7850,_7820,_7867),
    point0(_7879,_7867,_7894),
    w(noun(_7745,_7746,u,n),_7903,_7894,_7920),
    {user:testmember(_7745,[year,month,week,day,hour,minute,second,mile,kilometer,meter])},
    !,
    lock(exact,_7920,_7967),pushstack(exact,(w(nb(_7740,num)),w(noun(_7745,sin,u,n))),nil,_7967,_7973),np0_accept(_7703,_7706::_7707,_7947,_7973,_7962),unlock(_7962,_7963),
    !,
    accept(_8008,_7963,_7822).

adjunct1(after,_7703,_7704,[adjunct1,_7773,lit(å),!,_7818],_7753,_7755) --> 
    w(prep(after),_7773,_7753,_7790),
    cc(å,_7790,_7812),
    !,
    lock(last,_7812,_7863),
    pushstack(last,([noen],aux1),nil,_7863,_7869),
    clausal_object1(_7703,_7704,_7818,_7869,_7858),
    unlock(_7858,_7755).

adjunct1(when,_7703,_7704,[adjunct1,lit(om),lit(når),!,_7790],_7743,_7745) --> 
    cc(om,_7743,_7773),
    cc(når,_7773,_7784),
    !,
    clausal_object1(_7703,_7704,_7790,_7784,_7745).

adjunct1(where,_7703,_7704,[adjunct1,lit(om),lit(hvor),!,_7790],_7743,_7745) --> 
    cc(om,_7743,_7773),
    cc(hvor,_7773,_7784),
    !,
    clausal_object1(_7703,_7704,_7790,_7784,_7745).

adjunct1(regarding,_7703,_7704,[adjunct1,lit(om),lit(at),!,_7790],_7743,_7745) --> 
    cc(om,_7743,_7773),
    cc(at,_7773,_7784),
    !,
    clausal_object1(_7703,_7704,_7790,_7784,_7745).

adjunct1(with,_7703,_7704,[adjunct1,lit(med),lit(det),lit(å),!,_7812],_7754,_7756) --> 
    cc(med,_7754,_7784),
    cc(det,_7784,_7795),
    cc(å,_7795,_7806),
    !,
    pushstack(first,(someone,aux1),nil,_7806,_7878),
    clausal_object1(_7703,_7704,_7812,_7878,_7756).

adjunct1(_7702,_7703,_7704,[adjunct1,lit(hva),!,_7771],_7735,_7737) --> 
    cc(hva,_7735,_7765),
    !,
    reject(_7771,_7765,_7737).

adjunct1(_7702,_7703,_7704,[adjunct1,_7765,_7794,!,_7828],_7745,_7747) --> 
    prep1(in,_7765,_7745,_7782),
    w(noun(morning,_7720,_7721,_7722),_7794,_7782,_7811),
    !,
    reject(_7828,_7811,_7747).

adjunct1(_7702,_7703,_7706::_7707,[adjunct1,{},!,_7782],_7747,_7749) --> 
    {user:_7702==nil},
    !,
    complement_nil(_7703,_7706::_7707,_7782,_7747,_7749).

adjunct1(ago,_7703,_7706::_7707,[adjunct1,_7802,_7831,_7860,lit(siden),!,_7905,!],_7782,_7784) --> 
    prep1(for,_7802,_7782,_7819),
    anumber(_7729,_7831,_7819,_7848),
    w(noun(_7733,_7734,u,n),_7860,_7848,_7877),
    cc(siden,_7877,_7899),
    !,
    lock(exact,_7899,_7955),pushstack(exact,(number(_7729),w(noun(_7733,plu,u,n))),nil,_7955,_7961),np0_accept(_7703,_7706::_7707,_7905,_7961,_7950),unlock(_7950,_7784),
    !.

adjunct1(after,_7703,_7706::_7707,[adjunct1,lit(om),_7815,_7844,_7873,!,_7907],_7784,_7786) --> 
    cc(om,_7784,_7814),
    anumber(_7739,_7815,_7814,_7832),
    w(noun(_7732,_7744,u,gen),_7844,_7832,_7861),
    w(noun(time,sin,u,n),_7873,_7861,_7890),
    !,
    pushstack(first,(number(_7739),w(noun(_7732,sin,u,n))),nil,_7890,_7947),
    np1(_7703,_7706::_7707,_7907,_7947,_7786).

adjunct1(in,_7703,_7704,[adjunct1,_7810,_7839,{},_7878,!,_7912],_7790,_7792) --> 
    prep(in,_7810,_7790,_7827),
    w(nb(_7729,num),_7839,_7827,_7856),
    {user:(1000=<_7729,_7729=<9999)},
    not_look_ahead(w(noun(time,_7755,_7756,_7757)),_7878,_7856,_7895),
    !,
    lock(exact,_7895,_7929),
    pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_7729,num))),nil,_7929,_7935),
    np1(_7703,_7704,_7912,_7935,_7924),
    unlock(_7924,_7792).

adjunct1(around,_7703,_7704,[adjunct1,_7796,{},_7835,_7859,_7893,_7917,!,_7951],_7776,_7778) --> 
    prep1(_7730,_7796,_7776,_7813),
    {user:testmember(_7730,[in,at,around])},
    ca0(_7835,_7813,_7850),
    clock_kernel(_7703,_7727,_7859,_7850,_7878),
    point0(_7893,_7878,_7908),
    not_look_ahead(w(noun(_7750,_7751,_7752,_7753)),_7917,_7908,_7934),
    !,
    raise_object00(_7727,_7704,_7951,_7934,_7778).

adjunct1(_7702,_7703,_7704,[adjunct1,lit(med),lit(en),lit(gang),!,_7803],_7745,_7747) --> 
    cc(med,_7745,_7775),
    cc(en,_7775,_7786),
    cc(gang,_7786,_7797),
    !,
    reject(_7803,_7797,_7747).

adjunct1(between,(_7718,_7719):clock,_7706::_7706 and _7712 and _7713,[adjunct1,_7797,_7826,_7850,_7884,_7908,_7932,!,_7971],_7777,_7779) --> 
    prep1(between,_7797,_7777,_7814),
    clock0(_7826,_7814,_7841),
    clock_kernel(_7718:clock,_7712,_7850,_7841,_7869),
    betwand0(_7884,_7869,_7899),
    clock0(_7908,_7899,_7923),
    clock_kernel(_7719:clock,_7713,_7932,_7923,_7951),
    !,
    accept(_7971,_7951,_7779).

adjunct1(between,_7703,_7704,[adjunct1,_7761,_7790,!,_7829],_7741,_7743) --> 
    prep1(between,_7761,_7741,_7778),
    noun_phrases2(_7703,_7704,_7790,_7778,_7809),
    !,
    accept(_7829,_7809,_7743).

adjunct1(_7702,_7703,_7704,[adjunct1,lit(om),_7781,!,_7810,{}],_7750,_7752) --> 
    cc(om,_7750,_7780),
    not_look_ahead_subject(_7781,_7780,_7796),
    !,
    np(_7703,_7704,_7810,_7796,_7752),
    {user:adjustprep(_7703,om,_7702)}.

adjunct1(_7702,_7703,_7704,[adjunct1,_7751],_7731,_7733) --> 
    pp(_7702,_7703,_7704,_7751,_7731,_7733).

adjunct1(_7702,_7703,_7704,[adjunct1,{},_7768],_7738,_7740) --> 
    {user:_7702==dir},
    noun_phrase1(_7703,_7704,_7768,_7738,_7740).

pp(on,_7703,_7704,[pp,_7760,lit(at),_7800],_7740,_7742) --> 
    prep(on,_7760,_7740,_7777),
    cc(at,_7777,_7799),
    clausal_object1(_7703,_7704,_7800,_7799,_7742).

pp(as,_7703,_7704,[pp,lit(som),_7786,!,_7820],_7755,_7757) --> 
    cc(som,_7755,_7785),
    look_ahead_lit([meg,deg,ham,henne,oss,dem],_7786,_7785,_7803),
    !,
    np(_7703,_7704,_7820,_7803,_7757).

pp(_7702,_7703,_7704,[pp,_7769,_7798,_7827,_7856],_7749,_7751) --> 
    look_ahead([om],_7769,_7749,_7786),
    prep(_7702,_7798,_7786,_7815),
    not_look_ahead([jeg],_7827,_7815,_7844),
    np(_7703,_7704,_7856,_7844,_7751).

pp(_7702,_7703,_7704,[pp,lit(før),lit(det),!,_7787],_7740,_7742) --> 
    cc(før,_7740,_7770),
    cc(det,_7770,_7781),
    !,
    reject(_7787,_7781,_7742).

pp(_7702,_7703,_7704,[pp,_7774,_7803,_7832,_7856,{}],_7754,_7756) --> 
    not_look_ahead_lit([om],_7774,_7754,_7791),
    prep(_7721,_7803,_7791,_7820),
    redundant0(_7832,_7820,_7847),
    object(_7703,_7704,_7856,_7847,_7756),
    {user:adjustprep(_7703,_7721,_7702)}.

pp(_7702,_7703,_7706::_7706 and _7710,[pp,_7837,{},_7876,_7905,_7934,_7968,_7997,_8026,!,_8060],_7817,_7819) --> 
    prep(_7702,_7837,_7817,_7854),
    {user:testmember(_7702,[before,after,around,to,over,within])},
    not_look_ahead([et],_7876,_7854,_7893),
    not_look_ahead([en],_7905,_7893,_7922),
    clock_kernel(_7703,_7710,_7934,_7922,_7953),
    not_look_ahead(w(noun(station,_7774,_7775,_7776)),_7968,_7953,_7985),
    not_look_ahead(w(noun(hour,_7783,_7784,_7785)),_7997,_7985,_8014),
    not_look_ahead(w(noun(minute,_7792,_7793,_7794)),_8026,_8014,_8043),
    !,
    accept(_8060,_8043,_7819).

complement_nil(_7702,_7703,[complement_nil,_7809,_7838,_7867,!,_7911,_7945],_7792,_7794) --> 
    w(nb(_7737,num),_7809,_7792,_7826),
    w(noun(minute,_7743,_7744,_7745),_7838,_7826,_7855),
    subjunction(_7747,time,_7749,_7867,_7855,_7888),
    !,
    clausal_object0(_7732,_7733,_7911,_7888,_7930),
    lock(exact,_7930,_7993),
    pushstack(exact,(w(nb(_7737,num)),w(noun(minute,plu,u,n)),w(prep(_7747)),xnp(_7732,_7733)),nil,_7993,_7999),
    np1(_7702,_7703,_7945,_7999,_7988),
    unlock(_7988,_7794).

complement_nil(_7702,_7703,[complement_nil,_7792,_7821,_7850,!,_7884],_7775,_7777) --> 
    w(nb(_7732,num),_7792,_7775,_7809),
    w(noun(minute,_7738,_7739,_7740),_7821,_7809,_7838),
    look_ahead(w(prep(_7746)),_7850,_7838,_7867),
    !,
    lock(exact,_7867,_7901),
    pushstack(exact,(w(nb(_7732,num)),w(noun(minute,_7726,_7727,_7728))),nil,_7901,_7907),
    noun_phrase1(_7702,_7703,_7884,_7907,_7896),
    unlock(_7896,_7777).

complement_nil(_7702,_7703,[complement_nil,_7744],_7727,_7729) --> 
    obviousclock(_7702,_7703,_7744,_7727,_7729).

complement_nil(_7702,_7703,[complement_nil,_7754,!,_7788],_7737,_7739) --> 
    w(prep(nil),_7754,_7737,_7771),
    !,
    noun_phrase1(_7702,_7703,_7788,_7771,_7739).

complement_nil(_7702,_7705::_7706,[complement_nil,_7798,{},!,_7842,_7866],_7781,_7783) --> 
    w(noun(_7728,_7736,_7737,n),_7798,_7781,_7815),
    {user:testmember(_7728,[nightbus,summerroute,winterroute])},
    !,
    accept(_7842,_7815,_7857),
    lock(exact,_7857,_7883),
    pushstack(exact,(w(prep(with)),w(noun(_7728,sin,u,n))),nil,_7883,_7889),
    adjunct1(_7751,_7702,_7705::_7706,_7866,_7889,_7878),
    unlock(_7878,_7783).

complement_nil(_7702,_7703,[complement_nil,_7784,_7813,_7842,_7871,_7900,!,_7934],_7767,_7769) --> 
    not_look_ahead(w(noun(street,sin,u,n)),_7784,_7767,_7801),
    not_look_ahead([den],_7813,_7801,_7830),
    not_look_ahead([det],_7842,_7830,_7859),
    not_look_ahead(w(prep(with)),_7871,_7859,_7888),
    pronoun1(_7746,_7900,_7888,_7917),
    !,
    reject(_7934,_7917,_7769).

complement_nil(_7702,_7705::_7705 and _7709,[complement_nil,_7750],_7733,_7735) --> 
    plausibleclock1(_7702,_7709,_7750,_7733,_7735).

complement_nil(_7702,_7705::_7706,[complement_nil,_7753,!],_7736,_7738) --> 
    obviousdate(_7702,_7705::_7706,_7753,_7736,_7738),
    !.

complement_nil(_7702,_7705::_7705 and _7709,[complement_nil,_7750],_7733,_7735) --> 
    plausibledate1(_7702,_7709,_7750,_7733,_7735).

complement_nil(_7702,_7705::_7706,[complement_nil,_7773,_7802,!,_7841],_7756,_7758) --> 
    look_ahead(w(adj2(_7727,nil)),_7773,_7756,_7790),
    gmem(_7727,[short,long],_7802,_7790,_7821),
    !,
    noun_phrase1(_7702,_7705::_7706,_7841,_7821,_7758).

complement_nil(_7702,_7703,[complement_nil,_7783,_7812,!,_7846],_7766,_7768) --> 
    w(nb(_7729,num),_7783,_7766,_7800),
    w(noun(time_count,_7723,_7724,_7725),_7812,_7800,_7829),
    !,
    lock(exact,_7829,_7863),
    pushstack(exact,(w(nb(_7729,num)),w(noun(time_count,_7723,_7724,_7725))),nil,_7863,_7869),
    np0(_7702,_7703,_7846,_7869,_7858),
    unlock(_7858,_7768).

complement_nil(_7702,_7703,[complement_nil,_7806,_7835,_7864,_7893,_7922,_7951,!,_7985],_7789,_7791) --> 
    not_look_ahead(w(name(_7730,_7731,_7732)),_7806,_7789,_7823),
    w(nb(_7736,num),_7835,_7823,_7852),
    not_look_ahead([ganger],_7864,_7852,_7881),
    not_look_ahead(w(noun(hour,_7748,_7749,_7750)),_7893,_7881,_7910),
    not_look_ahead(w(noun(minute,_7757,_7758,_7759)),_7922,_7910,_7939),
    not_look_ahead(w(noun(second,_7766,_7767,_7768)),_7951,_7939,_7968),
    !,
    reject(_7985,_7968,_7791).

complement_nil(_7702,_7703,[complement_nil,_7828,_7857,_7886,_7915,_7944,_7973,_8002,_8031,!],_7811,_7813) --> 
    not_look_ahead(w(nb(_7733,_7734)),_7828,_7811,_7845),
    not_look_ahead(w(_7738,name(_7738,_7742,month)),_7857,_7845,_7874),
    not_look_ahead_lit([sin,sitt,sine],_7886,_7874,_7903),
    not_look_ahead(w(noun(hour,plu,u,n)),_7915,_7903,_7932),
    not_look_ahead(w(noun(minute,plu,u,n)),_7944,_7932,_7961),
    not_look_ahead(w(noun(second,plu,u,n)),_7973,_7961,_7990),
    not_look_ahead(w(noun(room,_7785,u,n)),_8002,_7990,_8019),
    object(_7702,_7703,_8031,_8019,_7813),
    !.

complement1_accept(_7702,_7703,_7704,[complement1_accept,lit(idag),!,_7793,!],_7757,_7759) --> 
    cc(idag,_7757,_7787),
    !,
    pushstack(first,(prep(in),w(noun(day,sin,u,n))),nil,_7787,_7836),complement1_accept(_7702,_7703,_7704,_7793,_7836,_7759),
    !.

complement1_accept(_7702,_7703,_7706::_7707,[complement1_accept,_7795,{},_7834,_7863,_7892,!,_7931],_7775,_7777) --> 
    prep(_7702,_7795,_7775,_7812),
    {user:(\+testmember(_7702,[of,between]))},
    not_look_ahead([jeg],_7834,_7812,_7851),
    not_look_ahead([man],_7863,_7851,_7880),
    noun_phrase_accept(_7703,_7706::_7707,_7892,_7880,_7911),
    !,
    accept(_7931,_7911,_7777).

plausibledate1(_7705:date,_7705 isa date,[plausibledate1,_7825,{},_7864,_7888,{},_7927,_7951,{},!,_7995,{}],_7808,_7810) --> 
    num_na(_7746,_7825,_7808,_7842),
    {user:(_7746>=1000,_7746=<9999)},
    dashpoint0(_7864,_7842,_7879),
    num_na(_7747,_7888,_7879,_7905),
    {user:(_7747>=1,_7747=<12)},
    dashpoint0(_7927,_7905,_7942),
    num_na(_7748,_7951,_7942,_7968),
    {user:(_7748>=1,_7748=<31)},
    !,
    accept(_7995,_7968,_7810),
    {user:_7705=date(_7746,_7747,_7748)}.

plausibledate1(_7705:date,_7705 isa date,[plausibledate1,_7805,{},_7844,_7868,{},{},!,_7922,{}],_7788,_7790) --> 
    num_na(_7745,_7805,_7788,_7822),
    {user:_7745=<31},
    slashpoint0(_7844,_7822,_7859),
    num_na(_7744,_7868,_7859,_7885),
    {user:_7744=<12},
    {user:this_year(_7763)},
    !,
    accept(_7922,_7885,_7790),
    {user:(adjust_year(_7744,_7763,_7743),_7705=date(_7743,_7744,_7745))}.

obviousdate(_7702,_7705::_7708 and _7705,[obviousdate,_7750],_7733,_7735) --> 
    obviousdate1(_7702,_7708,_7750,_7733,_7735).

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7784,_7808,_7837,_7861,_7890,!,_7929,{}],_7767,_7769) --> 
    point0(_7784,_7767,_7799),
    dayno(_7739,_7808,_7799,_7825),
    slashpoint0(_7837,_7825,_7852),
    monthname(_7738,_7861,_7852,_7878),
    xyear0(_7738,_7737,_7890,_7878,_7909),
    !,
    accept(_7929,_7909,_7769),
    {user:_7705=date(_7737,_7738,_7739)}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7828,_7852,{},_7891,_7915,{},_7954,_7978,{},!,_8022,{}],_7811,_7813) --> 
    point0(_7828,_7811,_7843),
    num_na(_7749,_7852,_7843,_7869),
    {user:(_7749>=1000,_7749=<9999)},
    dashpoint0(_7891,_7869,_7906),
    num_na(_7750,_7915,_7906,_7932),
    {user:(_7750>=1,_7750=<12)},
    dashpoint0(_7954,_7932,_7969),
    num_na(_7751,_7978,_7969,_7995),
    {user:(_7751>=1,_7751=<31)},
    !,
    accept(_8022,_7995,_7813),
    {user:_7705=date(_7749,_7750,_7751)}.

obviousdate1(_7702,_7708 isa day and _7706,[obviousdate1,_7768,{},_7807,!,_7846],_7751,_7753) --> 
    dendagen(_7708,_7768,_7751,_7785),
    {user:dayname(_7708)},
    date(_7702,_7706,_7807,_7785,_7826),
    !,
    accept(_7846,_7826,_7753).

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7806,_7830,{},_7869,_7893,{},_7932,!,_7971,{}],_7789,_7791) --> 
    point0(_7806,_7789,_7821),
    num_na(_7745,_7830,_7821,_7847),
    {user:(_7745>=25,_7745=<31)},
    slash(_7869,_7847,_7884),
    num_na(_7744,_7893,_7884,_7910),
    {user:_7744=<12},
    xyear0(_7744,_7743,_7932,_7910,_7951),
    !,
    accept(_7971,_7951,_7791),
    {user:_7705=date(_7743,_7744,_7745)}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7847,_7871,{},_7910,_7934,{},_7973,_8017,!,{}],_7830,_7832) --> 
    den0(_7847,_7830,_7862),
    num_na(_7756,_7871,_7862,_7888),
    {user:(_7756>=1,_7756=<7)},
    point0(_7910,_7888,_7925),
    w(name(_7771,n,date),_7934,_7925,_7951),
    {user:testmember(_7771,[easterday])},
    optional(w(noun(year,_7787,_7788,n)),_7973,_7951,_8005),
    w(nb(_7793,num),_8017,_8005,_7832),
    !,
    {user:(easterdate(_7793,_7752),_7793>=1000,_7793=<9999,_7753 is _7756-1,add_days(_7752,_7753,_7705))}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,{},_7817,{},_7856,!,{}],_7790,_7792) --> 
    {user:_7705=date(_7740,_7732,_7733)},
    w(name(_7728,n,date),_7817,_7790,_7834),
    {user:testmember(_7728,[christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day,may17])},
    year_expression(_7740,_7856,_7834,_7792),
    !,
    {user:named_date(_7728,date(_7731,_7732,_7733))}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7851,_7875,{},_7914,_7938,{},_7977,_8006,!,{}],_7834,_7836) --> 
    den0(_7851,_7834,_7866),
    num_na(_7750,_7875,_7866,_7892),
    {user:(_7750>=1,_7750=<7)},
    point0(_7914,_7892,_7929),
    w(name(_7765,n,date),_7938,_7929,_7955),
    {user:testmember(_7765,[whitsun_day,easterday,christmas_day,new_years_day])},
    not_look_ahead(w(noun(year,_7787,_7788,_7789)),_7977,_7955,_7994),
    not_look_ahead(w(nb(_7795,num)),_8006,_7994,_7836),
    !,
    {user:(named_date(_7765,date(_7801,_7802,_7803)),_7747 is _7750-1,add_days(date(_7801,_7802,_7803),_7747,_7705))}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7819,{},_7858,_7887,!,{}],_7802,_7804) --> 
    w(name(_7728,n,date),_7819,_7802,_7836),
    {user:testmember(_7728,[whitsun_eve,whitsun_day,palm_sunday,maundy_thursday,good_friday,eastereve,easterday,christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day])},
    not_look_ahead(w(prep(in)),_7858,_7836,_7875),
    not_look_ahead(w(noun(year,_7779,_7780,_7781)),_7887,_7875,_7804),
    !,
    {user:named_date(_7728,_7705)}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7764,{},!],_7747,_7749) --> 
    w(name(_7719,n,date),_7764,_7747,_7749),
    {user:named_date(_7719,_7705)},
    !.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7776,{},_7815,{},!,_7859],_7759,_7761) --> 
    dendagen(_7726,_7776,_7759,_7793),
    {user:_7726\==nil},
    num_na(_7726,_7815,_7793,_7832),
    {user:numberdate(_7726,_7705)},
    !,
    accept(_7859,_7832,_7761).

obviousdate1(_7702,_7703,[obviousdate1,_7752,_7781,!],_7735,_7737) --> 
    dendagen(_7711,_7752,_7735,_7769),
    date(_7702,_7703,_7781,_7769,_7737),
    !.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7798,_7822,{},_7861,_7885,_7914,_7938,!,{}],_7781,_7783) --> 
    den(_7798,_7781,_7813),
    num_na(_7742,_7822,_7813,_7839),
    {user:(_7742>=1,_7742=<31)},
    slashpoint0(_7861,_7839,_7876),
    monthname(_7741,_7885,_7876,_7902),
    slashpoint0(_7914,_7902,_7929),
    xyear0(_7741,_7740,_7938,_7929,_7783),
    !,
    {user:_7705=date(_7740,_7741,_7742)}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7811,_7835,{},_7874,_7898,{},_7937,_7961,!,{}],_7794,_7796) --> 
    den0(_7811,_7794,_7826),
    num_na(_7745,_7835,_7826,_7852),
    {user:(_7745>=1,_7745=<31)},
    slashpoint0(_7874,_7852,_7889),
    month(_7744,_7898,_7889,_7915),
    {user:(_7744>=1,_7744=<12)},
    slashpoint0(_7937,_7915,_7952),
    year(_7743,_7961,_7952,_7796),
    !,
    {user:_7705=date(_7743,_7744,_7745)}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7784,_7813,_7842,_7871,!,{}],_7767,_7769) --> 
    not_look_ahead(w(nb(_7739,num)),_7784,_7767,_7801),
    month(_7732,_7813,_7801,_7830),
    num_na(_7733,_7842,_7830,_7859),
    year0(_7731,_7871,_7859,_7769),
    !,
    {user:_7705=date(_7731,_7732,_7733)}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7787,_7811,_7840,_7864,!,{}],_7770,_7772) --> 
    den(_7787,_7770,_7802),
    num_na(_7739,_7811,_7802,_7828),
    slashpoint(_7840,_7828,_7855),
    month(_7738,_7864,_7855,_7772),
    !,
    {user:(this_year(_7745),adjust_year(_7738,_7745,_7737),_7705=date(_7737,_7738,_7739))}.

obviousdate1(_7702,_7703,[obviousdate1,_7764,_7793,_7822,!,_7856],_7747,_7749) --> 
    dendagen(_7717,_7764,_7747,_7781),
    num_na(_7719,_7793,_7781,_7810),
    w(noun(_7723,plu,_7725,_7726),_7822,_7810,_7839),
    !,
    reject(_7856,_7839,_7749).

obviousdate1(_7702,_7703,[obviousdate1,lit(den),_7768,!,_7802],_7740,_7742) --> 
    cc(den,_7740,_7767),
    w(nb(_7718,ord),_7768,_7767,_7785),
    !,
    reject(_7802,_7785,_7742).

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,{},_7802,_7831,_7855,_7884,{}],_7775,_7777) --> 
    {user:value(busflag,true)},
    num_na(_7736,_7802,_7775,_7819),
    slashpoint0(_7831,_7819,_7846),
    num_na(_7735,_7855,_7846,_7872),
    slashpoint0(_7884,_7872,_7777),
    {user:(dedicated_date(date(_7734,_7735,_7736)),_7705=date(_7734,_7735,_7736))}.

obviousdate1(_7705:date,_7703,[obviousdate1,_7776,_7805,{},_7844,!,_7878],_7759,_7761) --> 
    dendagen(_7723,_7776,_7759,_7793),
    num_na(_7725,_7805,_7793,_7822),
    {user:(_7725>=1,_7725=<31)},
    colemin(_7738,_7844,_7822,_7861),
    !,
    reject(_7878,_7861,_7761).

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7815,{},_7854,{},_7893,_7917,!,{},{}],_7798,_7800) --> 
    dendagen(_7744,_7815,_7798,_7832),
    {user:_7744\==nil},
    num_na(_7742,_7854,_7832,_7871),
    {user:(_7742>=1,_7742=<31)},
    point(_7893,_7871,_7908),
    not_look_ahead(w(nb(_7768,_7769)),_7917,_7908,_7800),
    !,
    {user:todaysdate(date(_7740,_7741,_7777))},
    {user:_7705=date(_7740,_7741,_7742)}.

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,lit(den),_7779,{},!,_7823],_7751,_7753) --> 
    cc(den,_7751,_7778),
    num_na(_7725,_7779,_7778,_7796),
    {user:numberdate(_7725,_7705)},
    !,
    accept(_7823,_7796,_7753).

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7783,{},_7822,{},!,_7866],_7766,_7768) --> 
    num_na(_7726,_7783,_7766,_7800),
    {user:_7726>=10101},
    not_look_ahead(w(noun(_7737,plu,_7739,_7740)),_7822,_7800,_7839),
    {user:numberdate(_7726,_7705)},
    !,
    accept(_7866,_7839,_7768).

obviousdate1(_7705:date,_7705 isa date,[obviousdate1,_7783,{},_7822,{},!,_7866],_7766,_7768) --> 
    num_na(_7726,_7783,_7766,_7800),
    {user:_7726>=2501},
    not_look_ahead(w(noun(_7737,plu,_7739,_7740)),_7822,_7800,_7839),
    {user:numberdate(_7726,_7705)},
    !,
    accept(_7866,_7839,_7768).

year_expression(_7702,[year_expression,_7772,_7816,_7860,{},!],_7758,_7760) --> 
    optional(w(prep(in)),_7772,_7758,_7804),
    optional(w(noun(year,sin,u,n)),_7816,_7804,_7848),
    w(nb(_7702,num),_7860,_7848,_7760),
    {user:_7702=<9999},
    !.

year_expression(_7702,[year_expression,_7754,!,{}],_7740,_7742) --> 
    lastyear(_7754,_7740,_7742),
    !,
    {user:(this_year(_7718),_7702 is _7718-1)}.

year_expression(_7702,[year_expression,_7754,!,{}],_7740,_7742) --> 
    nextyear(_7754,_7740,_7742),
    !,
    {user:(this_year(_7718),_7702 is _7718+1)}.

lastyear([lastyear,_7747,lit(siste),_7802],_7736,_7738) --> 
    optional([i],_7747,_7736,_7779),
    cc(siste,_7779,_7801),
    w(noun(year,sin,_7712,n),_7802,_7801,_7738).

lastyear([lastyear,_7742,_7786],_7731,_7733) --> 
    optional([i],_7742,_7731,_7774),
    w(noun(lastyear,sin,_7709,n),_7786,_7774,_7733).

lastyear([lastyear,lit(ifjor),!],_7722,_7724) --> 
    cc(ifjor,_7722,_7724),
    !.

nextyear([nextyear,_7747,lit(neste),_7802],_7736,_7738) --> 
    optional([i],_7747,_7736,_7779),
    cc(neste,_7779,_7801),
    w(noun(year,sin,u,n),_7802,_7801,_7738).

plausibleclock(_7702,_7705::_7705 and _7709,[plausibleclock,_7763,!,_7797],_7746,_7748) --> 
    look_ahead(w(nb(_7724,_7725)),_7763,_7746,_7780),
    !,
    clock_sequel(_7702,_7709,_7797,_7780,_7748).

plausibleclock1(_7705:clock,_7705 isa clock,[plausibleclock1,_7817,{},_7856,_7880,_7909,_7953,_7982,{},!],_7800,_7802) --> 
    w(nb(_7737,num),_7817,_7800,_7834),
    {user:(_7737>=1,_7737=<24)},
    point0(_7856,_7834,_7871),
    w(nb(_7753,num),_7880,_7871,_7897),
    optional(['.'],_7909,_7897,_7941),
    not_look_ahead(w(nb(_7764,_7765)),_7953,_7941,_7970),
    not_look_ahead(w(name(_7771,_7772,month)),_7982,_7970,_7802),
    {user:plausibleclocktest(_7737,_7753,_7705)},
    !.

obviousclock(_7702,_7703,[obviousclock,_7774,_7803,_7827,{},!,_7871],_7757,_7759) --> 
    w(nb(_7722,num),_7774,_7757,_7791),
    pointNO(_7803,_7791,_7818),
    w(nb(_7727,num),_7827,_7818,_7844),
    {user:dedicated_date(date(_7734,_7727,_7722))},
    !,
    reject(_7871,_7844,_7759).

obviousclock(_7702,_7705::_7705 and _7709,[obviousclock,_7750],_7733,_7735) --> 
    obviousclock1(_7702,_7709,_7750,_7733,_7735).

obviousclock1(_7702,_7703,[obviousclock1,_7750,!,_7779],_7733,_7735) --> 
    clock(_7750,_7733,_7765),
    !,
    clock_sequel(_7702,_7703,_7779,_7765,_7735).

obviousclock1(_7702,_7703,[obviousclock1,_7760,_7794,!,_7828],_7743,_7745) --> 
    clock_kernel(_7702,_7703,_7760,_7743,_7779),
    w(noun(time,sin,def,n),_7794,_7779,_7811),
    !,
    accept(_7828,_7811,_7745).

obviousclock1(_7705:clock,_7705 isa clock,[obviousclock1,_7848,_7877,_7906,{},_7945,_7974,_8003,_8032,_8061,_8090,!,_8139],_7831,_7833) --> 
    not_look_ahead(w(name(_7748,n,route)),_7848,_7831,_7865),
    not_look_ahead(w(name(_7756,n,nightbus)),_7877,_7865,_7894),
    w(nb(_7705,num),_7906,_7894,_7923),
    {user:(_7705>=100,clock_test(_7705))},
    not_look_ahead([-],_7945,_7923,_7962),
    not_look_ahead(w(nb(_7783,_7784)),_7974,_7962,_7991),
    not_look_ahead(w(noun(_7790,plu,_7792,_7793)),_8003,_7991,_8020),
    not_look_ahead([tusen],_8032,_8020,_8049),
    not_look_ahead([millioner],_8061,_8049,_8078),
    optional(w(noun(time,sin,def,n)),_8090,_8078,_8122),
    !,
    accept(_8139,_8122,_7833).

obviousclock1(_7705:clock,_7705 isa clock,[obviousclock1,_7749],_7732,_7734) --> 
    time2(_7705,_7749,_7732,_7734).

obviousclock1(_7705:clock,_7705 isa clock,[obviousclock1,_7756,_7785],_7739,_7741) --> 
    hours100(_7705,_7756,_7739,_7773),
    look_ahead([om],_7785,_7773,_7741).

rel_clauses(_7702,_7703,_7704,[rel_clauses,lit(hva),!,_7771],_7735,_7737) --> 
    cc(hva,_7735,_7765),
    !,
    reject(_7771,_7765,_7737).

rel_clauses(_7702,_7703,_7703 and _7707,[rel_clauses,_7791,lit(det),_7826,_7917],_7771,_7773) --> 
    derhvor(_7791,_7771,_7806),
    cc(det,_7806,_7825),
    lock(exact,_7825,_7876),pushstack(exact,(w(prep(in)),npgap(_7702)),nil,_7876,_7882),adverbial1(_7724,_7725,_7726,_7826,_7882,_7871),unlock(_7871,_7872),
    lock(last,_7872,_7966),
    pushstack(last,([det],xadverbial1(_7724,_7725,_7726)),nil,_7966,_7972),
    substatement1(_7707,_7917,_7972,_7961),
    unlock(_7961,_7773).

rel_clauses(_7702,_7703,_7703 and _7707,[rel_clauses,_7812,_7841,_7870,!,_7904],_7792,_7794) --> 
    w(noun(_7737,_7738,_7739,n),_7812,_7792,_7829),
    w(verb(apply,_7745,fin),_7841,_7829,_7858),
    w(prep(_7750),_7870,_7858,_7887),
    !,
    pushstack(first,(w(noun(_7737,_7738,_7739,n)),w(verb(apply,_7745,fin)),w(prep(_7750)),npgap(_7702)),nil,_7887,_7944),
    statreal(_7707,_7904,_7944,_7794).

rel_clauses(_7702,_7703,_7704,[rel_clauses,_7779,_7813],_7759,_7761) --> 
    lit_of(_7714,[jeg,hun,han,vi,man,du],_7779,_7759,_7798),
    pushstack(first,([som],[_7714]),nil,_7798,_7823),
    rel_clause(_7702,_7703,_7704,_7813,_7823,_7761).

rel_clauses(_7702,_7703,_7703 and _7707,[rel_clauses,_7791,lit(det),_7826,_7917],_7771,_7773) --> 
    derhvor(_7791,_7771,_7806),
    cc(det,_7806,_7825),
    lock(exact,_7825,_7876),pushstack(exact,(w(prep(in)),npgap(_7702)),nil,_7876,_7882),adverbial1(_7724,_7725,_7726,_7826,_7882,_7871),unlock(_7871,_7872),
    lock(last,_7872,_7966),
    pushstack(last,([det],xadverbial1(_7724,_7725,_7726)),nil,_7966,_7972),
    substatement1(_7707,_7917,_7972,_7961),
    unlock(_7961,_7773).

rel_clauses(_7702,_7703,_7703 and _7707,[rel_clauses,_7779,_7803,_7837],_7759,_7761) --> 
    derhvor(_7779,_7759,_7794),
    subject(_7726,_7727,_7803,_7794,_7822),
    lock(last,_7822,_7915),
    pushstack(last,(xnp(_7726,_7727),w(prep(in)),npgap(_7702)),nil,_7915,_7921),
    statreal(_7707,_7837,_7921,_7910),
    unlock(_7910,_7761).

rel_clauses(_7702,_7703,_7704,[rel_clauses,lit(som),_7812,_7836,_7865,_7899,!,[],_7989],_7781,_7783) --> 
    cc(som,_7781,_7811),
    danow0(_7812,_7811,_7827),
    look_ahead(w(prep(_7738)),_7836,_7827,_7853),
    gmem(_7738,[of],_7865,_7853,_7884),
    adverbix(_7745,_7746,_7747,_7899,_7884,_7920),
    !,
    pushstack(free,xadverbial1(_7745,_7746,_7747),nil,_7920,_7988),[],
    pushstack(first,[som],nil,_7988,_7999),
    rel_clause(_7702,_7703,_7704,_7989,_7999,_7783).

rel_clauses(_7702,_7703,_7704,[rel_clauses,_7758,_7797],_7738,_7740) --> 
    rel_clause(_7702,_7703,_7710,_7758,_7738,_7779),
    rel_clauses0(_7702,_7710,_7704,_7797,_7779,_7740).

rel_clauses0(_7702,_7703,_7704,[rel_clauses0,_7754,_7778],_7734,_7736) --> 
    and1x(_7754,_7734,_7769),
    rel_clauses(_7702,_7703,_7704,_7778,_7769,_7736).

rel_clauses0(_7702,_7703,_7703,[rel_clauses0,[]],_7727,_7727) --> 
    [].

derhvor([derhvor,_7739,!],_7728,_7730) --> 
    one_of_lit([der,hvor,dit],_7739,_7728,_7730),
    !.

and1x([and1x,_7728],_7717,_7719) --> 
    and1(_7728,_7717,_7719).

and1x([and1x,_7732],_7721,_7723) --> 
    look_ahead([som],_7732,_7721,_7723).

dvs([dvs,lit(dvs)],_7719,_7721) --> 
    cc(dvs,_7719,_7721).

dvs([dvs,lit(altså)],_7719,_7721) --> 
    cc(altså,_7719,_7721).

dvs([dvs,lit(a),lit(la)],_7724,_7726) --> 
    cc(a,_7724,_7745),
    cc(la,_7745,_7726).

rel_clause(_7702,_7703,_7703 and _7707,[rel_clause,_7772,!,_7801],_7752,_7754) --> 
    dvs(_7772,_7752,_7787),
    !,
    lock(last,_7787,_7848),
    pushstack(last,(npgap(_7702),w(verb(be,pres,fin))),nil,_7848,_7854),
    statreal(_7707,_7801,_7854,_7843),
    unlock(_7843,_7754).

rel_clause(_7702,_7703,_7703 and _7707,[rel_clause,_7802,_7831,!,_7870],_7782,_7784) --> 
    w(verb(_7731,past,part),_7802,_7782,_7819),
    gmem(_7731,[adapt,label,be_named,register],_7831,_7819,_7850),
    !,
    lock(last,_7850,_7917),
    pushstack(last,(w(noun(agent,sin,u,n)),w(verb(_7731,past,fin)),npgap(_7702)),nil,_7917,_7923),
    statreal(_7707,_7870,_7923,_7912),
    unlock(_7912,_7784).

rel_clause(_7702,_7703,_7703 and _7707,[rel_clause,_7795,_7824,_7858,!,_7887],_7775,_7777) --> 
    rel(_7702,_7795,_7775,_7812),
    lit_of(_7731,[du,jeg,de,han,hun,vi,dere,man],_7824,_7812,_7843),
    look_ahead_vp(_7858,_7843,_7873),
    !,
    lock(last,_7873,_7934),
    pushstack(last,([_7731],npgap(_7702)),nil,_7934,_7940),
    statreal(_7707,_7887,_7940,_7929),
    unlock(_7929,_7777).

rel_clause(_7702,_7703,_7703 and _7707,[rel_clause,_7769,_7798,_7827],_7749,_7751) --> 
    rel(_7702,_7769,_7749,_7786),
    not_look_ahead([at],_7798,_7786,_7815),
    pushstack(free,npgap(_7702),nil,_7815,_7867),
    statreal(_7707,_7827,_7867,_7751).

rel_clause(_7702,_7703,_7703 and _7707,[rel_clause,_7775,lit(det),!,_7820],_7755,_7757) --> 
    rel(_7702,_7775,_7755,_7792),
    cc(det,_7792,_7814),
    !,
    lock(last,_7814,_7867),
    pushstack(last,([det],npgap(_7702)),nil,_7867,_7873),
    statreal(_7707,_7820,_7873,_7862),
    unlock(_7862,_7757).

relneg(_7702,[relneg,_7743,_7767,!],_7729,_7731) --> 
    relblabla(_7743,_7729,_7758),
    negation0(_7702,_7767,_7758,_7731),
    !.

relneg(_7702,[relneg,_7743,_7772,!],_7729,_7731) --> 
    negation0(_7702,_7743,_7729,_7760),
    relblabla(_7772,_7760,_7731),
    !.

relblabla([relblabla,lit(nå),!],_7722,_7724) --> 
    cc(nå,_7722,_7724),
    !.

relblabla([relblabla,lit(bare),!],_7722,_7724) --> 
    cc(bare,_7722,_7724),
    !.

relblabla([relblabla,_7728],_7717,_7719) --> 
    redundant0(_7728,_7717,_7719).

whose_noun(_7702,_7703,[whose_noun,_7751,_7775],_7734,_7736) --> 
    whose(_7751,_7734,_7766),
    noun(_7708,_7709,u,n,_7702,_7703,_7775,_7766,_7736).

relwhat(_7702,[relwhat,_7752,_7776,{},!,_7815],_7738,_7740) --> 
    hva(_7752,_7738,_7767),
    som0(_7776,_7767,_7791),
    {user:constrain(_7702,thing)},
    !,
    accept(_7815,_7791,_7740).

relwhat(_7702,[relwhat,lit(hvem),_7765,{},!,_7804],_7740,_7742) --> 
    cc(hvem,_7740,_7764),
    som0(_7765,_7764,_7780),
    {user:constrain(_7702,agent)},
    !,
    accept(_7804,_7780,_7742).

rel(_7702,[rel,_7767,_7796,_7825,{},!,_7884],_7753,_7755) --> 
    relpron(_7719,_7767,_7753,_7784),
    not_look_ahead(w(quote(_7725)),_7796,_7784,_7813),
    optional([nå],_7825,_7813,_7857),
    {user:constrain(_7702,_7719)},
    !,
    accept(_7884,_7857,_7755).

comparisons(_7702,_7703,_7704,[comparisons,_7759,_7798],_7739,_7741) --> 
    comparison(_7702,_7703,_7711,_7759,_7739,_7780),
    comparisons0(_7702,_7703,_7711,_7704,_7798,_7780,_7741).

comparisons0(_7702,_7703,_7704,_7704 and _7708,[comparisons0,_7771,_7795,_7834],_7748,_7750) --> 
    and1(_7771,_7748,_7786),
    comparison(_7702,_7703,_7718,_7795,_7786,_7816),
    comparisons0(_7702,_7703,_7718,_7708,_7834,_7816,_7750).

comparisons0(_7702,_7703,_7704,_7704,[comparisons0,[]],_7730,_7730) --> 
    [].

comparison(_7702,_7703,_7704,[comparison,{},{},_7811,!,{}],_7771,_7773) --> 
    {user:vartypeid(_7702,_7729)},
    {user:testmember(_7729,[speed,price,name,description])},
    np1_accept(_7723,_7724::_7704,_7811,_7771,_7773),
    !,
    {user:compare(eq,thing,_7702,_7723,_7724)}.

comparison(_7702,_7703,_7704,[comparison,_7784,{},{},{},!,_7848],_7764,_7766) --> 
    comparator1(_7721,_7784,_7764,_7801),
    {user:_7721==gt},
    {user:vartype(_7702,_7731,_7732)},
    {user:testmember(_7732,[information,minute])},
    !,
    reject(_7848,_7801,_7766).

comparison(_7702,_7703,_7704,[comparison,_7781,{},_7820,{}],_7761,_7763) --> 
    comparator1(_7717,_7781,_7761,_7798),
    {user:testmember(_7717,[eq,ne])},
    noun_phrase1(_7720,_7721::_7704,_7820,_7798,_7763),
    {user:compare(_7717,thing,_7702,_7720,_7721)}.

comparison(_7702,_7703,_7704,[comparison,_7785,{},_7824,{}],_7765,_7767) --> 
    comparator1(_7717,_7785,_7765,_7802),
    {user:testmember(_7717,[gt,ge,le,lt])},
    noun_phrase1(_7720,_7721::_7704,_7824,_7802,_7767),
    {user:compare(_7717,number,_7702,_7720,_7721)}.

comparison(_7702,_7703,_7704,[comparison,_7770,_7804,{}],_7750,_7752) --> 
    comparator2(_7714,_7715,_7770,_7750,_7789),
    noun_phrase1(_7717,_7718::_7704,_7804,_7789,_7752),
    {user:compare(_7714,_7715,_7702,_7717,_7718)}.

comparison(_7702,_7703,_7704,[comparison,_7770,_7804,{}],_7750,_7752) --> 
    comparator3(_7714,_7715,_7770,_7750,_7789),
    noun_phrase1(_7717,_7718::_7704,_7804,_7789,_7752),
    {user:comparad(_7714,_7715,_7702,_7717,_7718)}.

np(_7702,_7703,[np,_7744],_7727,_7729) --> 
    xnp(_7702,_7703,_7744,_7727,_7729).

np(_7702,_7705::_7706,[np,_7750],_7733,_7735) --> 
    noun_phrases(_7702,_7705::_7706,_7750,_7733,_7735).

np(_7702,_7705::_7705,[np,_7746],_7729,_7731) --> 
    npgap(_7702,_7746,_7729,_7731).

np0_accept(_7702,_7705::_7706,[np0_accept,_7756,!,_7795],_7739,_7741) --> 
    np0(_7702,_7705::_7706,_7756,_7739,_7775),
    !,
    accept(_7795,_7775,_7741).

np00(_7702,_7715:_7702,_7706::exists(_7715:_7702)::_7715 isa _7702 and _7706,[np00,[]],_7747,_7747) --> 
    [].

raise_object00(_7702,_7705::_7705 and _7702,[raise_object00,[]],_7730,_7730) --> 
    [].

subject(_7702,_7703,[subject,_7787,_7816,_7845,_7874],_7770,_7772) --> 
    not_look_ahead(w(name(være,n,_7723)),_7787,_7770,_7804),
    not_look_ahead(w(name(norwegian,n,language)),_7816,_7804,_7833),
    not_look_ahead_lit([meg,deg,ham,henne,seg,oss,dem,det],_7845,_7833,_7862),
    np(_7702,_7703,_7874,_7862,_7772).

object1(_7702,_7703,[object1,_7762,_7791,!],_7745,_7747) --> 
    not_look_ahead_lit([jeg,du,han,hun,vi],_7762,_7745,_7779),
    np0(_7702,_7703,_7791,_7779,_7747),
    !.

object(_7702,_7703,[object,_7747,_7771],_7730,_7732) --> 
    not_look_ahead_subject(_7747,_7730,_7762),
    noun_phrase_accept(_7702,_7703,_7771,_7762,_7732).

ind_object(_7702,_7703,[ind_object,_7747,_7771],_7730,_7732) --> 
    not_look_ahead_subject(_7747,_7730,_7762),
    noun_phrase_accept(_7702,_7703,_7771,_7762,_7732).

not_look_ahead_time([not_look_ahead_time,_7734,!,_7763],_7723,_7725) --> 
    look_ahead_time(_7734,_7723,_7749),
    !,
    reject(_7763,_7749,_7725).

look_ahead_time([look_ahead_time,_7733],_7722,_7724) --> 
    w(nb(_7704,_7705),_7733,_7722,_7724).

look_ahead_time([look_ahead_time,_7734],_7723,_7725) --> 
    one_of_lit([halv,kvart],_7734,_7723,_7725).

look_ahead_time([look_ahead_time,_7746,{},!],_7735,_7737) --> 
    w(noun(_7710,_7711,_7712,_7713),_7746,_7735,_7737),
    {user:subclass0(_7710,time)},
    !.

not_look_ahead_subject([not_look_ahead_subject,_7734,!,_7763],_7723,_7725) --> 
    look_ahead_subject(_7734,_7723,_7749),
    !,
    reject(_7763,_7749,_7725).

not_look_ahead_subject([not_look_ahead_subject,[]],_7717,_7717) --> 
    [].

look_ahead_subject([look_ahead_subject,_7742],_7731,_7733) --> 
    look_ahead_lit([jeg,du,han,hun,vi,man],_7742,_7731,_7733).

subject2(_7702,_7703,_7704,[subject2,_7757,!,_7801],_7737,_7739) --> 
    noun_phrase2(_7702,_7703,_7704,_7757,_7737,_7778),
    !,
    accept(_7801,_7778,_7739).

object2hnn(_7702,_7703,_7704,[object2hnn,_7787,_7816,_7845,_7874,!,_7908],_7767,_7769) --> 
    w(name(_7723,_7724,_7725),_7787,_7767,_7804),
    not_look_ahead(w(prep(on)),_7816,_7804,_7833),
    not_look_ahead(w(noun(_7737,_7738,_7739,_7740)),_7845,_7833,_7862),
    not_look_ahead([deg],_7874,_7862,_7891),
    !,
    reject(_7908,_7891,_7769).

object2hnn(_7702,_7703,_7704,[object2hnn,_7757,!,_7801],_7737,_7739) --> 
    object2h(_7702,_7703,_7704,_7757,_7737,_7778),
    !,
    accept(_7801,_7778,_7739).

object2h(_7702,_7703,_7704,[object2h,lit(dere),!,_7771],_7735,_7737) --> 
    cc(dere,_7735,_7765),
    !,
    reject(_7771,_7765,_7737).

object2h(_7702,_7703,_7704,[object2h,_7751],_7731,_7733) --> 
    object2(_7702,_7703,_7704,_7751,_7731,_7733).

object2(_7702,_7703,_7704,[object2,lit(en),lit(gang),!,_7787],_7740,_7742) --> 
    cc(en,_7740,_7770),
    cc(gang,_7770,_7781),
    !,
    reject(_7787,_7781,_7742).

object2(_7702,_7703,_7704,[object2,_7769,_7793,{},!,_7842],_7749,_7751) --> 
    which(_7769,_7749,_7784),
    np(_7703,_7704,_7793,_7784,_7812),
    {user:(\+vartypeid(_7703,place))},
    !,
    accept(_7842,_7812,_7751).

object2(_7702,_7702,_7706::_7706 and _7710,[object2,_7767,_7796,!,_7825],_7747,_7749) --> 
    prep1(around,_7767,_7747,_7784),
    clock(_7796,_7784,_7811),
    !,
    clock_kernel(_7702,_7710,_7825,_7811,_7749).

object2(_7702,_7703,_7706::_7707,[object2,_7764,_7793],_7744,_7746) --> 
    not_look_ahead_lit([middag],_7764,_7744,_7781),
    noun_phrase2(_7702,_7703,_7706::_7707,_7793,_7781,_7746).

object2(_7702,_7703,_7704,[object2,_7770,_7799,!,_7833],_7750,_7752) --> 
    one_of_lit([jeg,du,hun,vi],_7770,_7750,_7787),
    not_look_ahead([som],_7799,_7787,_7816),
    !,
    reject(_7833,_7816,_7752).

noun_phrase2(_7702,_7703,_7706::_7706 and _7710,[noun_phrase2,_7772,!,_7806,_7830],_7752,_7754) --> 
    look_ahead([hvor],_7772,_7752,_7789),
    !,
    accept(_7806,_7789,_7821),
    adverbial_noun_phrase1(_7703,_7706::_7710,_7830,_7821,_7754).

noun_phrase2(_7702,_7702,_7706::_7707,[noun_phrase2,_7766,_7795],_7746,_7748) --> 
    recipron(_7717,_7766,_7746,_7783),
    pushstack(first,npgap(_7702),nil,_7783,_7835),
    noun_phrase1(_7702,_7706::_7707,_7795,_7835,_7748).

noun_phrase2(_7702,_7703,_7706::findalt(diff,_7702,_7703)::_7712 and _7706,[noun_phrase2,_7778,_7802,_7856],_7758,_7760) --> 
    another(_7778,_7758,_7793),
    noun(_7730,sin,u,n,_7703,_7727,_7802,_7793,_7829),
    noun_modsx0(0,_7703,_7727,_7712,_7856,_7829,_7760).

noun_phrase2(_7702,_7703,_7704,[noun_phrase2,_7781,_7810,_7839,!,_7873],_7761,_7763) --> 
    not_look_ahead(w(noun(_7722,_7723,_7724,_7725)),_7781,_7761,_7798),
    not_look_ahead(w(adj2(_7731,_7732)),_7810,_7798,_7827),
    w(verb(_7736,past,part),_7839,_7827,_7856),
    !,
    reject(_7873,_7856,_7763).

noun_phrase2(_7702,_7703,_7704,[noun_phrase2,_7760,!,_7794],_7740,_7742) --> 
    look_ahead([hva],_7760,_7740,_7777),
    !,
    np(_7703,_7704,_7794,_7777,_7742).

noun_phrase2(_7702,_7703,_7704,[noun_phrase2,_7760,_7789,_7813],_7740,_7742) --> 
    not_look_ahead([hva],_7760,_7740,_7777),
    which0(_7789,_7777,_7804),
    np(_7703,_7704,_7813,_7804,_7742).

adverbial_noun_phrase1(_7702,_7705::_7705 and _7709,[adverbial_noun_phrase1,lit(hvor),_7812,_7841,!,_7907],_7784,_7786) --> 
    cc(hvor,_7784,_7811),
    not_look_ahead([mye],_7812,_7811,_7829),
    lock(exact,_7829,_7861),pushstack(exact,(w(prep(in)),w(noun(place,sin,u,n))),nil,_7861,_7867),adverbial1(_7726,_7702,_7730::_7731,_7841,_7867,_7856),unlock(_7856,_7857),
    !,
    lock(last,_7857,_7959),
    pushstack(last,adverbial1(_7726,_7702,_7730::_7731),nil,_7959,_7965),
    statreal(_7709,_7907,_7965,_7954),
    unlock(_7954,_7786).

noun_phrase_accept(_7702,_7703,[noun_phrase_accept,_7750,!,_7789],_7733,_7735) --> 
    np(_7702,_7703,_7750,_7733,_7769),
    !,
    accept(_7789,_7769,_7735).

np1_accept(_7702,_7703,[np1_accept,_7750,!,_7789],_7733,_7735) --> 
    noun_phrase1(_7702,_7703,_7750,_7733,_7769),
    !,
    accept(_7789,_7769,_7735).

noun_phrases2(_7702,_7705::_7708 and _7709,[noun_phrases2,_7781,_7815,_7839,{},!,_7888],_7764,_7766) --> 
    np1_accept(_7726,_7705::_7708,_7781,_7764,_7800),
    and0(_7815,_7800,_7830),
    np1_accept(_7732,_7705::_7709,_7839,_7830,_7858),
    {user:latin(and,_7726,_7732,_7702)},
    !,
    accept(_7888,_7858,_7766).

noun_phrases(_7702,_7705::_7708 and _7711 and _7712,[noun_phrases,_7820,_7849,{},{},_7903,_7937,{},!,_7986],_7803,_7805) --> 
    look_ahead(w(noun(distance,sin,def,n)),_7820,_7803,_7837),
    noun_phrase1(_7747,_7705::_7708,_7849,_7837,_7868),
    {user:vartypeid(_7747,_7756)},
    {user:testmember(_7756,[distance])},
    noun_phrase1(_7765,_7705::_7711,_7903,_7868,_7922),
    noun_phrase1(_7771,_7705::_7712,_7937,_7922,_7956),
    {user:latin(and,_7765,_7771,_7702)},
    !,
    accept(_7986,_7956,_7805).

noun_phrases(_7702,_7705::_7706,[noun_phrases,_7767,_7801,!,_7850],_7750,_7752) --> 
    noun_phrase1(_7717,_7705::_7721,_7767,_7750,_7786),
    noun_phrases0(_7717,_7702,true::_7721,_7706,_7801,_7786,_7824),
    !,
    accept(_7850,_7824,_7752).

noun_phrases0(_7702,_7702,_7707::_7705,_7705,[noun_phrases0,{},!],_7741,_7741) --> 
    {user:constrain(_7702,number)},
    !.

noun_phrases0(_7702,_7702,_7707::_7705,_7705,[noun_phrases0,_7766,!],_7743,_7745) --> 
    look_ahead(w(nb(_7717,_7718)),_7766,_7743,_7745),
    !.

noun_phrases0(_7702,_7702,_7707::_7705,_7705,[noun_phrases0,_7765,!],_7742,_7744) --> 
    look_ahead_lit([etc,samme],_7765,_7742,_7744),
    !.

noun_phrases0(_7702,_7702,_7707::_7705,_7705,[noun_phrases0,_7779,{},!],_7756,_7758) --> 
    look_ahead(w(verb(_7720,inf,fin)),_7779,_7756,_7758),
    {user:testmember(_7720,[be,use])},
    !.

noun_phrases0(_7702,_7702,_7707::_7705,_7705,[noun_phrases0,_7779,{},!],_7756,_7758) --> 
    look_ahead(w(verb(_7720,pres,fin)),_7779,_7756,_7758),
    {user:testmember(_7720,[wish,want])},
    !.

noun_phrases0(_7702,_7703,_7710::_7707,_7707 and _7708,[noun_phrases0,_7808,_7837,_7866,_7895,_7929,{}],_7785,_7787) --> 
    not_look_ahead([','],_7808,_7785,_7825),
    np_conjunction(_7730,_7837,_7825,_7854),
    not_look_ahead(w(noun(_7745,sin,def,n)),_7866,_7854,_7883),
    noun_phrase1(_7750,_7710::_7754,_7895,_7883,_7914),
    noun_phrases20(_7750,_7732,_7710,_7754,_7708,_7929,_7914,_7787),
    {user:latin(_7730,_7702,_7732,_7703)}.

noun_phrases0(_7702,_7703,_7710::_7707,_7707 and _7708,[noun_phrases0,{},_7804,_7838,{}],_7771,_7773) --> 
    {user:(\+vartypeid(_7702,savant))},
    noun_phrase1(_7736,_7710::_7740,_7804,_7771,_7823),
    noun_phrases10(_7736,_7726,_7710,_7740,_7708,_7838,_7823,_7773),
    {user:latin(and,_7702,_7726,_7703)}.

noun_phrases0(_7702,_7702,_7707::_7705,_7705,[noun_phrases0,[]],_7733,_7733) --> 
    [].

noun_phrases10(_7702,_7703,_7704,_7705,_7705 and _7709,[noun_phrases10,_7797,_7826,_7860,{},lit(etc)],_7771,_7773) --> 
    andor(_7725,_7797,_7771,_7814),
    noun_phrase1(_7727,_7704::_7731,_7826,_7814,_7845),
    noun_phrases20(_7727,_7734,_7704,_7731,_7709,_7860,_7845,_7885),
    {user:latin(_7725,_7702,_7734,_7703)},
    cc(etc,_7885,_7773).

noun_phrases10(_7702,_7703,_7704,_7705,_7705 and _7709,[noun_phrases10,_7797,_7826,_7860,{}],_7771,_7773) --> 
    not_look_ahead(w(nb(_7731,_7732)),_7797,_7771,_7814),
    noun_phrase1(_7734,_7704::_7738,_7826,_7814,_7845),
    noun_phrases10(_7734,_7724,_7704,_7738,_7709,_7860,_7845,_7773),
    {user:latin(and,_7702,_7724,_7703)}.

noun_phrases10(_7702,_7702,_7704,_7705,_7705,[noun_phrases10,lit(etc)],_7735,_7737) --> 
    cc(etc,_7735,_7737).

noun_phrases20(_7702,_7703,_7704,_7705,_7705 and _7709,[noun_phrases20,_7792,_7821,_7855,{}],_7766,_7768) --> 
    andor(_7722,_7792,_7766,_7809),
    noun_phrase1(_7729,_7704::_7733,_7821,_7809,_7840),
    noun_phrases20(_7729,_7724,_7704,_7733,_7709,_7855,_7840,_7768),
    {user:latin(_7722,_7702,_7724,_7703)}.

noun_phrases20(_7702,_7702,_7704,_7705,_7705,[noun_phrases20,[]],_7733,_7733) --> 
    [].

no_phrases(_7702,_7703,[no_phrases,{},!,_7773],_7741,_7743) --> 
    {user:value(teleflag,true)},
    !,
    np(_7702,true::_7703,_7773,_7741,_7743).

no_phrases(_7702,_7703,[no_phrases,_7750,_7774],_7733,_7735) --> 
    the0(_7750,_7733,_7765),
    np(_7702,true::_7703,_7774,_7765,_7735).

no_phrase(_7702,_7703,[no_phrase,_7750,_7774],_7733,_7735) --> 
    the0(_7750,_7733,_7765),
    noun_phrase1(_7702,true::_7703,_7774,_7765,_7735).

noun_phrase1(_7702,_7703,[noun_phrase1,lit(og),!,_7765],_7732,_7734) --> 
    cc(og,_7732,_7759),
    !,
    reject(_7765,_7759,_7734).

noun_phrase1(_7702,_7703,[noun_phrase1,_7744],_7727,_7729) --> 
    np2(_7702,_7703,_7744,_7727,_7729).

noun_phrase1(_7702,_7703,[noun_phrase1,_7744],_7727,_7729) --> 
    np1(_7702,_7703,_7744,_7727,_7729).

noun_phrase1(_7702,_7703,[noun_phrase1,_7771,_7800,_7829,_7858,_7882],_7754,_7756) --> 
    one_of_lit([noen,mange],_7771,_7754,_7788),
    not_look_ahead([som],_7800,_7788,_7817),
    not_look_ahead([av],_7829,_7817,_7846),
    not_look_ahead_np(_7858,_7846,_7873),
    np00(agent,_7702,_7703,_7882,_7873,_7756).

noun_phrase1(_7702,_7703,[noun_phrase1,_7768,_7797,_7826,_7850],_7751,_7753) --> 
    one_of_lit([den,det],_7768,_7751,_7785),
    not_look_ahead(w(verb(_7728,_7729,pass)),_7797,_7785,_7814),
    not_look_ahead_np(_7826,_7814,_7841),
    np00(thing,_7702,_7703,_7850,_7841,_7753).

noun_phrase1(_7702,_7705::_7706,[noun_phrase1,_7808,_7837,_7866,_7900,_7929,!,_7963,_7987],_7791,_7793) --> 
    not_look_ahead([de],_7808,_7791,_7825),
    not_look_ahead([det],_7837,_7825,_7854),
    quant_pron(some,_7737,_7866,_7854,_7885),
    not_look_ahead([som],_7900,_7885,_7917),
    not_look_ahead(w(noun(_7761,_7762,_7763,_7764)),_7929,_7917,_7946),
    !,
    accept(_7963,_7946,_7978),
    lock(exact,_7978,_8037),
    pushstack(exact,(some,w(noun(_7737,sin,u,n))),nil,_8037,_8043),
    np1(_7702,_7705::_7706,_7987,_8043,_8032),
    unlock(_8032,_7793).

noun_phrase1(_7702,_7703,[noun_phrase1,_7800,_7829,_7863,_7892,!,_7926,_7950],_7783,_7785) --> 
    not_look_ahead([de],_7800,_7783,_7817),
    quant_pron(every,thing,_7829,_7817,_7848),
    not_look_ahead(w(noun(_7747,_7748,_7749,_7750)),_7863,_7848,_7880),
    not_look_ahead(w(adj2(_7756,_7757)),_7892,_7880,_7909),
    !,
    accept(_7926,_7909,_7941),
    pushstack(first,([alle],w(noun(thing,sin,u,n))),nil,_7941,_7960),
    np1(_7702,_7703,_7950,_7960,_7785).

noun_phrase1(_7702,_7703,[noun_phrase1,_7744],_7727,_7729) --> 
    npa(_7702,_7703,_7744,_7727,_7729).

noun_phrase1(_7702,_7705::_7706,[noun_phrase1,_7769,_7803],_7752,_7754) --> 
    quant_pron(much,_7719,_7769,_7752,_7788),
    lock(exact,_7788,_7853),
    pushstack(exact,(much,w(noun(_7719,sin,u,n))),nil,_7853,_7859),
    np1(_7702,_7705::_7706,_7803,_7859,_7848),
    unlock(_7848,_7754).

noun_phrase1(_7702,_7705::_7706,[noun_phrase1,_7769,_7803],_7752,_7754) --> 
    quant_pron(little,_7719,_7769,_7752,_7788),
    lock(exact,_7788,_7853),
    pushstack(exact,(little,w(noun(_7719,sin,u,n))),nil,_7853,_7859),
    np1(_7702,_7705::_7706,_7803,_7859,_7848),
    unlock(_7848,_7754).

noun_phrase1(_7702,_7705::not _7708,[noun_phrase1,_7771,_7805],_7754,_7756) --> 
    quant_pron(no,_7721,_7771,_7754,_7790),
    lock(exact,_7790,_7855),
    pushstack(exact,(every,w(noun(_7721,sin,u,n))),nil,_7855,_7861),
    np1(_7702,_7705::_7708,_7805,_7861,_7850),
    unlock(_7850,_7756).

noun_phrase1(_7702,_7703,[noun_phrase1,_7744],_7727,_7729) --> 
    xnp(_7702,_7703,_7744,_7727,_7729).

noun_phrase1(_7702,_7705::_7705,[noun_phrase1,_7746],_7729,_7731) --> 
    npgap(_7702,_7746,_7729,_7731).

specific_phrase(_7702,_7703,[specific_phrase,_7753,!,_7787],_7736,_7738) --> 
    w(name(_7713,gen,_7715),_7753,_7736,_7770),
    !,
    reject(_7787,_7770,_7738).

specific_phrase(_7702,_7703,[specific_phrase,_7756,_7785,!,_7814],_7739,_7741) --> 
    w(name(_7716,_7717,_7718),_7756,_7739,_7773),
    sin(_7785,_7773,_7800),
    !,
    reject(_7814,_7800,_7741).

specific_phrase(_7702,_7705::_7706,[specific_phrase,_7750],_7733,_7735) --> 
    sp1(_7702,_7705::_7706,_7750,_7733,_7735).

sp1(_7714:_7715,_7705::findpron(_7714:_7715)::_7714 isa _7723 and _7705,[sp1,_7771,{}],_7754,_7756) --> 
    pronoun(_7723,_7771,_7754,_7756),
    {user:type(_7723,_7715)}.

sp1(_7702,_7703,[sp1,_7757,_7796],_7740,_7742) --> 
    name_phrase(name,_7702,_7703,_7757,_7740,_7778),
    not_look_ahead(w(noun(_7712,_7713,_7714,_7715)),_7796,_7778,_7742).

np0(_7702,_7703,[np0,lit(mye),_7790,_7814,_7843,!,_7909],_7762,_7764) --> 
    cc(mye,_7762,_7789),
    not_look_ahead_np(_7790,_7789,_7805),
    not_look_ahead(w(adj(_7726,_7727)),_7814,_7805,_7831),
    lock(exact,_7831,_7863),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7863,_7869),np_kernel(0,_7702,_7703,_7843,_7869,_7858),unlock(_7858,_7859),
    !,
    accept(_7909,_7859,_7764).

np0(_7702,_7705::_7706,[np0,_7757,!,_7801],_7740,_7742) --> 
    np_head1(_7714,_7702,_7705::_7706,_7757,_7740,_7778),
    !,
    accept(_7801,_7778,_7742).

np0(_7702,_7705::_7706,[np0,_7754,_7778],_7737,_7739) --> 
    the10(_7754,_7737,_7769),
    aname_phrase(_7711,_7702,_7705::_7706,_7778,_7769,_7739).

np0(_7702,_7705::_7706,[np0,_7751],_7734,_7736) --> 
    np_kernel(_7708,_7702,_7705::_7706,_7751,_7734,_7736).

np0(_7702,_7705::_7706,[np0,_7750],_7733,_7735) --> 
    npa(_7702,_7705::_7706,_7750,_7733,_7735).

np0(_7702,_7705::_7705,[np0,_7746],_7729,_7731) --> 
    npgap(_7702,_7746,_7729,_7731).

obvious_object(_7702,_7703,[obvious_object,lit(det),_7771,!,_7805],_7743,_7745) --> 
    cc(det,_7743,_7770),
    not_look_ahead(w(verb(_7720,_7721,pass)),_7771,_7770,_7788),
    !,
    reject(_7805,_7788,_7745).

obvious_object(_7702,_7703,[obvious_object,_7754,_7783,!],_7737,_7739) --> 
    look_ahead([alt],_7754,_7737,_7771),
    np1_accept(_7702,_7703,_7783,_7771,_7739),
    !.

obvious_object(_7702,_7703,[obvious_object,_7751,_7780],_7734,_7736) --> 
    not_look_ahead([noen],_7751,_7734,_7768),
    np0_accept(_7702,_7703,_7780,_7768,_7736).

np1(_7702,_7705::_7705 and _7709,[np1,_7813,lit(det),_7848,lit(å),!,_7893,!,_7941],_7796,_7798) --> 
    hvormye(_7813,_7796,_7828),
    cc(det,_7828,_7847),
    w(verb(_7747,_7748,fin),_7848,_7847,_7865),
    cc(å,_7865,_7887),
    !,
    pushstack(first,([noen],[vil]),nil,_7887,_7906),clausal_object1(_7761,_7762,_7893,_7906,_7921),
    !,
    lock(exact,_7921,_8019),
    pushstack(exact,(xnp(_7761,_7762),w(verb(_7747,_7748,fin)),npgap(_7702)),nil,_8019,_8025),
    statreal1(_7709,_7941,_8025,_8014),
    unlock(_8014,_7798).

np1(_7702,_7703,[np1,lit(noe),_7791,!,_7825,_7886],_7763,_7765) --> 
    cc(noe,_7763,_7790),
    look_ahead(w(prep(_7728)),_7791,_7790,_7808),
    !,
    lock(exact,_7808,_7845),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7845,_7851),np_kernel(0,_7702,_7719,_7825,_7851,_7840),unlock(_7840,_7841),
    noun_modifiers0(0,_7702,_7719,_7703,_7886,_7841,_7765).

np1(_7702,_7703,[np1,_7847,_7871,_7900,_7929,{},!,_7973,_7997,_8058],_7830,_7832) --> 
    a(_7847,_7830,_7862),
    w(noun(_7746,sin,u,n),_7871,_7862,_7888),
    w(name(_7740,n,_7742),_7900,_7888,_7917),
    w(noun(_7759,sin,u,n),_7929,_7917,_7946),
    {user:(\+testmember(_7759,[minute,hour,direction,home,station]))},
    !,
    accept(_7973,_7946,_7988),
    lock(exact,_7988,_8017),pushstack(exact,w(noun(_7759,sin,u,n)),nil,_8017,_8023),np_kernel(_7791,_7702,_7793,_7997,_8023,_8012),unlock(_8012,_8013),
    lock(exact,_8013,_8075),
    pushstack(exact,(w(prep(with)),w(noun(_7746,sin,u,n)),w(name(_7740,n,_7742))),nil,_8075,_8081),
    noun_modifiers0(0,_7702,_7793,_7703,_8058,_8081,_8070),
    unlock(_8070,_7832).

np1(_7702,_7703,[np1,lit(hvem),_7790,!,_7824,_7863],_7762,_7764) --> 
    cc(hvem,_7762,_7789),
    look_ahead_lit([man,jeg,du,vi],_7790,_7789,_7807),
    !,
    np00(agent,_7702,_7736,_7824,_7807,_7845),
    pushstack(first,relpron(agent),nil,_7845,_7906),
    noun_modifiers0(0,_7702,_7736,_7703,_7863,_7906,_7764).

np1(_7702,_7703,[np1,lit(hvem),lit(som),!,_7798,_7837],_7754,_7756) --> 
    cc(hvem,_7754,_7781),
    cc(som,_7781,_7792),
    !,
    np00(agent,_7702,_7728,_7798,_7792,_7819),
    pushstack(first,relpron(agent),nil,_7819,_7877),
    noun_modifiers0(0,_7702,_7728,_7703,_7837,_7877,_7756).

np1(_7702,_7703,[np1,_7777,_7801,!,_7830,_7891],_7760,_7762) --> 
    hvormye(_7777,_7760,_7792),
    dette(_7801,_7792,_7816),
    !,
    lock(exact,_7816,_7850),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7850,_7856),np_kernel(0,_7702,_7734,_7830,_7856,_7845),unlock(_7845,_7846),
    pushstack(first,relpron(thing),nil,_7846,_7932),
    noun_modifiers0(0,_7702,_7734,_7703,_7891,_7932,_7762).

np1(_7702,_7703,[np1,lit(hva),lit(som),!,_7798,_7837],_7754,_7756) --> 
    cc(hva,_7754,_7781),
    cc(som,_7781,_7792),
    !,
    np00(thing,_7702,_7728,_7798,_7792,_7819),
    pushstack(first,relpron(thing),nil,_7819,_7877),
    noun_modifiers0(0,_7702,_7728,_7703,_7837,_7877,_7756).

np1(_7702,_7703,[np1,lit(hva),_7790,!,_7819,_7880],_7762,_7764) --> 
    cc(hva,_7762,_7789),
    look_ahead_np(_7790,_7789,_7805),
    !,
    lock(exact,_7805,_7839),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7839,_7845),np_kernel(0,_7702,_7736,_7819,_7845,_7834),unlock(_7834,_7835),
    pushstack(first,relpron(thing),nil,_7835,_7920),
    noun_modifiers0(0,_7702,_7736,_7703,_7880,_7920,_7764).

np1(_7702,_7703,[np1,lit(de),_7786,_7815,!,_7849],_7758,_7760) --> 
    cc(de,_7758,_7785),
    not_look_ahead(w(nb(_7727,_7728)),_7786,_7785,_7803),
    look_ahead(w(noun(_7734,sin,_7736,_7737)),_7815,_7803,_7832),
    !,
    np00(agent,_7702,_7703,_7849,_7832,_7760).

np1(_7702,_7703,[np1,_7805,!,_7834,lit(å),_7879,!,_7913,_7974],_7788,_7790) --> 
    noemed(_7805,_7788,_7820),
    !,
    np0_accept(_7732,_7733,_7834,_7820,_7853),
    cc(å,_7853,_7878),
    w(verb(do1,inf,fin),_7879,_7878,_7896),
    !,
    lock(exact,_7896,_7933),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7933,_7939),np_kernel(_7756,_7702,_7758,_7913,_7939,_7928),unlock(_7928,_7929),
    pushstack(first,(w(prep(with)),xnp(_7732,_7733)),nil,_7929,_8015),
    noun_modifiers0(_7756,_7702,_7758,_7703,_7974,_8015,_7790).

noemed([noemed,lit(noe),lit(med)],_7724,_7726) --> 
    cc(noe,_7724,_7745),
    cc(med,_7745,_7726).

np1(_7702,_7703,[np1,_7779,!,_7808,_7869],_7762,_7764) --> 
    noeå(_7779,_7762,_7794),
    !,
    lock(exact,_7794,_7828),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7828,_7834),np_kernel(0,_7702,_7734,_7808,_7834,_7823),unlock(_7823,_7824),
    pushstack(first,([som],[jeg]),nil,_7824,_7879),
    noun_modifiers0(0,_7702,_7734,_7703,_7869,_7879,_7764).

noeå([noeå,lit(noe),lit(å)],_7724,_7726) --> 
    cc(noe,_7724,_7745),
    cc(å,_7745,_7726).

np1(_7702,_7703,[np1,_7774,!,_7803,_7864],_7757,_7759) --> 
    noesom(_7774,_7757,_7789),
    !,
    lock(exact,_7789,_7823),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7823,_7829),np_kernel(0,_7702,_7731,_7803,_7829,_7818),unlock(_7818,_7819),
    pushstack(first,[som],nil,_7819,_7874),
    noun_modifiers0(0,_7702,_7731,_7703,_7864,_7874,_7759).

noesom([noesom,lit(det),_7754],_7732,_7734) --> 
    cc(det,_7732,_7753),
    look_ahead_lit([man,jeg,du,vi],_7754,_7753,_7734).

noesom([noesom,lit(det),lit(som)],_7724,_7726) --> 
    cc(det,_7724,_7745),
    cc(som,_7745,_7726).

noesom([noesom,lit(noe),lit(som)],_7724,_7726) --> 
    cc(noe,_7724,_7745),
    cc(som,_7745,_7726).

noesom([noesom,lit(noe),_7754],_7732,_7734) --> 
    cc(noe,_7732,_7753),
    look_ahead_lit([jeg,du,han,hun],_7754,_7753,_7734).

noesom([noesom,lit(hva),lit(som)],_7724,_7726) --> 
    cc(hva,_7724,_7745),
    cc(som,_7745,_7726).

noesom([noesom,lit(det),_7753,!],_7731,_7733) --> 
    cc(det,_7731,_7752),
    look_ahead_lit([jeg,du],_7753,_7752,_7733),
    !.

np1(_7702,_7703,[np1,lit(det),_7784,!,_7818,_7857],_7756,_7758) --> 
    cc(det,_7756,_7783),
    look_ahead([de],_7784,_7783,_7801),
    !,
    np00(agent,_7702,_7730,_7818,_7801,_7839),
    pushstack(first,[som],nil,_7839,_7867),
    noun_modifiers0(0,_7702,_7730,_7703,_7857,_7867,_7758).

np1(_7702,_7703,[np1,lit(noen),_7784,!,_7818,_7857],_7756,_7758) --> 
    cc(noen,_7756,_7783),
    look_ahead([de],_7784,_7783,_7801),
    !,
    np00(agent,_7702,_7730,_7818,_7801,_7839),
    pushstack(first,[som],nil,_7839,_7867),
    noun_modifiers0(0,_7702,_7730,_7703,_7857,_7867,_7758).

np1(_7702,_7703,[np1,lit(hvilke),_7787,_7826,_7855,!,_7884],_7759,_7761) --> 
    cc(hvilke,_7759,_7786),
    np_kernel(_7727,_7702,_7729,_7787,_7786,_7808),
    not_look_ahead([som],_7826,_7808,_7843),
    look_ahead_np(_7855,_7843,_7870),
    !,
    pushstack(first,[som],nil,_7870,_7894),
    noun_modifiers0(_7727,_7702,_7729,_7703,_7884,_7894,_7761).

np1(_7702,_7703,[np1,lit(hvilke),_7779,_7818,!,_7852],_7751,_7753) --> 
    cc(hvilke,_7751,_7778),
    np_kernel(_7717,_7702,_7719,_7779,_7778,_7800),
    look_ahead([som],_7818,_7800,_7835),
    !,
    noun_modifiers0(_7717,_7702,_7719,_7703,_7852,_7835,_7753).

np1(_7702,_7703,[np1,{},lit(de),_7861,_7890,_7919,_7948,!,_7982,[],_8020,_8068],_7823,_7825) --> 
    {user:value(busflag,true)},
    cc(de,_7823,_7860),
    w(nb(_7749,num),_7861,_7860,_7878),
    flnp(_7752,_7890,_7878,_7907),
    not_look_ahead(w(noun(_7758,_7759,_7760,_7761)),_7919,_7907,_7936),
    w(prep(_7765),_7948,_7936,_7965),
    !,
    accept(_7982,_7965,_7997),
    pushstack(free,w(prep(_7765)),nil,_7997,_8019),[],
    pushstack(first,(w(nb(_7749,num)),w(adj2(_7752,nil)),w(noun(vehicle,sin,u,n))),nil,_8019,_8033),np_kernel(_7735,_7702,_7737,_8020,_8033,_8050),
    noun_modifiers0(_7735,_7702,_7737,_7703,_8068,_8050,_7825).

np1(_7702,_7705::_7706,[np1,_7756,!,_7795],_7739,_7741) --> 
    obviousclock(_7702,_7705::_7706,_7756,_7739,_7775),
    !,
    accept(_7795,_7775,_7741).

np1(_7702,_7703,[np1,{},lit(en),_7838,{},_7877,!,_7911,_7935,_7983],_7800,_7802) --> 
    {user:value(busflag,true)},
    cc(en,_7800,_7837),
    w(nb(_7743,num),_7838,_7837,_7855),
    {user:plausible_busno(_7743)},
    not_look_ahead(w(noun(_7754,_7755,_7756,_7757)),_7877,_7855,_7894),
    !,
    accept(_7911,_7894,_7926),
    pushstack(first,(w(noun(vehicle,sin,u,n)),w(nb(_7743,num))),nil,_7926,_7948),np_kernel(_7729,_7702,_7731,_7935,_7948,_7965),
    noun_modifiers0(_7729,_7702,_7731,_7703,_7983,_7965,_7802).

np1(_7702,_7705::_7706,[np1,_7765,_7804],_7748,_7750) --> 
    np_kernel(_7711,_7702,_7723::_7724,_7765,_7748,_7786),
    noun_modifiers0(_7711,_7702,_7723::_7724,_7705::_7706,_7804,_7786,_7750).

np_kernel(0,_7715:thing,_7706::findpron(_7715:thing)::_7715 isa thing and _7706,[np_kernel,_7773,_7797,!],_7753,_7755) --> 
    dette(_7773,_7753,_7788),
    not_look_ahead_np(_7797,_7788,_7755),
    !.

np_kernel(0,_7715:agent,_7706::findpron(_7715:agent)::_7715 isa agent and _7706,[np_kernel,lit(de),_7814,_7843,_7872,!],_7783,_7785) --> 
    cc(de,_7783,_7813),
    not_look_ahead(w(nb(_7744,_7745)),_7814,_7813,_7831),
    not_look_ahead(w(adj2(_7751,_7752)),_7843,_7831,_7860),
    look_ahead(w(verb(_7758,pres,fin)),_7872,_7860,_7785),
    !.

np_kernel(0,_7703,_7706::_7707,[np_kernel,_7762,!,_7801],_7742,_7744) --> 
    obviousdate(_7703,_7706::_7707,_7762,_7742,_7781),
    !,
    accept(_7801,_7781,_7744).

np_kernel(0,_7715:thing,_7706::findpron(_7715:thing)::_7715 isa thing and _7706,[np_kernel,lit(en),_7802,!],_7771,_7773) --> 
    cc(en,_7771,_7801),
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_7802,_7801,_7773),
    !.

np_kernel(name,_7715:_7716,_7706::findpron(_7715:_7716)::_7715 isa _7716 and _7706,[np_kernel,_7785,_7814,!],_7765,_7767) --> 
    not_look_ahead_lit([de,den,det,et],_7785,_7765,_7802),
    pronoun(_7716,_7814,_7802,_7767),
    !.

np_kernel(0,_7715:thing,_7706::exists(_7715:thing)::_7715 isa thing and _7706,[np_kernel,_7785,_7814,!],_7765,_7767) --> 
    one_of_lit([alt,noe],_7785,_7765,_7802),
    look_ahead_lit([som,å],_7814,_7802,_7767),
    !.

np_kernel(_7702,_7703,_7706::_7707,[np_kernel,_7757],_7737,_7739) --> 
    np_head1(_7702,_7703,_7706::_7707,_7757,_7737,_7739).

np_kernel(_7702,_7703,_7704,[np_kernel,_7774,_7803,_7832],_7754,_7756) --> 
    look_ahead(w(name(_7720,n,_7722)),_7774,_7754,_7791),
    not_look_ahead(w(noun(_7728,_7729,_7730,_7731)),_7803,_7791,_7820),
    aname_phrase(_7702,_7703,_7704,_7832,_7820,_7756).

np_kernel(_7702,_7703,_7706::_7707,[np_kernel,_7757],_7737,_7739) --> 
    np_head(_7702,_7703,_7706::_7707,_7757,_7737,_7739).

np_kernel(_7702,_7703,_7706::_7707,[np_kernel,_7768,_7797],_7748,_7750) --> 
    not_look_ahead(w(name(_7723,n,_7725)),_7768,_7748,_7785),
    aname_phrase(_7702,_7703,_7706::_7707,_7797,_7785,_7750).

np_head1(_7702,_7703,_7706::_7707,[np_head1,{},_7799,_7848,_7877,{}],_7769,_7771) --> 
    {user:value(teleflag,true)},
    determiner0(_7733,_7702,_7703,_7726,_7706::_7707,_7799,_7769,_7824),
    preadjs0(_7723,_7848,_7824,_7865),
    noun_list2(_7744,_7703,_7725,_7877,_7865,_7771),
    {user:preadjs_template(_7723,_7703,_7725,_7726)}.

np_head1(0,_7709:_7710,_7706::_7707,[np_head1,{},_7838,_7882,_7936,!,{},{},{}],_7808,_7810) --> 
    {user:value(busflag,true)},
    optional([denne],_7838,_7808,_7870),
    bus_head(_7749,_7735,_7751,_7710,_7753,_7709,_7882,_7870,_7909),
    not_look_ahead_lit([sin,sitt,sine],_7936,_7909,_7810),
    !,
    {user:decide_adjective(_7751,_7709,_7768)},
    {user:_7772=(_7709 isa _7710 and _7768)},
    {user:decide_quantifier(_7735,_7709:_7710,_7772 and _7706,_7707)}.

np_head1(0,_7703,_7706::_7707,[np_head1,{},lit(den),_7852,{},_7891,!,_7925,_7949,!,_8015],_7811,_7813) --> 
    {user:value(busflag,true)},
    cc(den,_7811,_7851),
    w(adj2(_7745,nil),_7852,_7851,_7869),
    {user:testmember(_7745,[first,last,next,previous])},
    look_ahead([som],_7891,_7869,_7908),
    !,
    accept(_7925,_7908,_7940),
    lock(exact,_7940,_7969),pushstack(exact,(w(adj2(_7745,nil)),w(noun(vehicle,sin,u,n))),nil,_7969,_7975),np_head(0,_7703,_7706::_7707,_7949,_7975,_7964),unlock(_7964,_7965),
    !,
    accept(_8015,_7965,_7813).

np_head1(0,_7703,_7706::exists(_7703)::_7712 and _7715 and _7706,[np_head1,_7799,_7828,_7857,{},!,_7926],_7779,_7781) --> 
    not_look_ahead([dere],_7799,_7779,_7816),
    w(name(_7741,_7742,_7743),_7828,_7816,_7845),
    noun(_7745,_7746,_7747,n,_7703,_7715,_7857,_7845,_7884),
    {user:adjnamecomp_template(_7741,_7703,_7712)},
    !,
    accept(_7926,_7884,_7781).

bus_head(_7702,_7703,_7704,_7705,_7705,_7707,[bus_head,_7808,_7842,_7876,{},{},_7930,_7964],_7779,_7781) --> 
    traceprint(5,bx01,_7808,_7779,_7827),
    art0(_7702,_7734,_7842,_7827,_7861),
    quantnext(_7703,_7704,_7876,_7861,_7895),
    {user:_7704\==nil},
    {user:_7703=<5},
    busnumber(_7707,_7705,_7930,_7895,_7949),
    traceprint(4,bh01,_7964,_7949,_7781).

bus_head(_7702,_7703,_7704,_7705,_7706,_7707,[bus_head,_7801,_7835,_7869,{},_7913,_7952],_7772,_7774) --> 
    traceprint(5,bx02,_7801,_7772,_7820),
    art0(_7702,_7731,_7835,_7820,_7854),
    quantnext(_7703,_7704,_7869,_7854,_7888),
    {user:_7703=<5},
    busseno(_7707,_7705,_7706,_7913,_7888,_7934),
    traceprint(4,bh02,_7952,_7934,_7774).

bus_head(_7702,_7703,_7704,_7705,_7705,_7707,[bus_head,_7813,_7847,_7881,{},_7925,_7954,_7978,_8012],_7784,_7786) --> 
    traceprint(5,bx03,_7813,_7784,_7832),
    art0(_7702,_7737,_7847,_7832,_7866),
    quantnext(_7703,_7704,_7881,_7866,_7900),
    {user:_7703=<5},
    not_look_ahead(w(nb(_7751,_7752)),_7925,_7900,_7942),
    nr0(_7954,_7942,_7969),
    busnumber(_7707,_7705,_7978,_7969,_7997),
    traceprint(4,bh03,_8012,_7997,_7786).

bus_head(_7702,_7703,_7704,_7705,_7705,_7707,[bus_head,_7822,_7856,_7890,{},_7934,_7963,_8019,!],_7793,_7795) --> 
    traceprint(5,bx04,_7822,_7793,_7841),
    art0(_7702,_7734,_7856,_7841,_7875),
    quantnext(_7703,_7704,_7890,_7875,_7909),
    {user:_7703=<5},
    look_ahead(w(prep(_7748)),_7934,_7909,_7951),
    lock(exact,_7951,_7983),pushstack(exact,w(noun(bus,plu,def,n)),nil,_7983,_7989),busnumber(_7707,_7705,_7963,_7989,_7978),unlock(_7978,_7979),
    traceprint(4,bh04,_8019,_7979,_7795),
    !.

bus_head(_7702,1,_7704,_7705,_7706,_7707,[bus_head,_7802,_7836,_7870,_7899,_7923,_7957,_8001],_7773,_7775) --> 
    traceprint(5,bx05,_7802,_7773,_7821),
    art0(_7702,_7734,_7836,_7821,_7855),
    flnp(_7704,_7870,_7855,_7887),
    nr1(_7899,_7887,_7914),
    busnumber(_7707,_7706,_7923,_7914,_7942),
    busse0(_7706,_7705,_7743,_7744,_7957,_7942,_7980),
    traceprint(4,bh05,_8001,_7980,_7775).

bus_head(_7702,_7703,nil,_7705,_7706,_7707,[bus_head,_7802,_7836,_7870,_7899,_7923,_7957,_8001],_7773,_7775) --> 
    traceprint(5,bx06,_7802,_7773,_7821),
    art0(_7702,_7734,_7836,_7821,_7855),
    quant(_7703,_7870,_7855,_7887),
    nr1(_7899,_7887,_7914),
    busnumber(_7707,_7706,_7923,_7914,_7942),
    busse0(_7706,_7705,_7743,_7744,_7957,_7942,_7980),
    traceprint(4,bh06,_8001,_7980,_7775).

bus_head(_7702,_7703,nil,_7705,_7706,_7707,[bus_head,_7801,_7835,_7869,_7898,_7937,_7961,_7995],_7772,_7774) --> 
    traceprint(5,bx07,_7801,_7772,_7820),
    art0(_7702,_7734,_7835,_7820,_7854),
    quant(_7703,_7869,_7854,_7886),
    busnoun(_7705,_7739,_7740,_7898,_7886,_7919),
    nr0(_7937,_7919,_7952),
    busnumber(_7707,_7706,_7961,_7952,_7980),
    traceprint(4,bh07,_7995,_7980,_7774).

bus_head(_7702,_7703,nil,_7705,_7706,_7707,[bus_head,_7798,_7832,_7866,_7895,_7929,_7968],_7769,_7771) --> 
    traceprint(5,bx08,_7798,_7769,_7817),
    art0(_7702,_7731,_7832,_7817,_7851),
    quant(_7703,_7866,_7851,_7883),
    busnumber(_7707,_7706,_7895,_7883,_7914),
    busnoun(_7705,_7739,_7740,_7929,_7914,_7950),
    traceprint(4,bh08,_7968,_7950,_7771).

bus_head(_7702,1,_7704,_7705,_7706,_7707,[bus_head,_7801,_7835,_7869,_7898,_7922,_7956,_7995],_7772,_7774) --> 
    traceprint(5,bx09,_7801,_7772,_7820),
    art0(_7702,_7734,_7835,_7820,_7854),
    filanepr(_7704,_7869,_7854,_7886),
    nr1(_7898,_7886,_7913),
    busnumber(_7707,_7706,_7922,_7913,_7941),
    busnoun(_7705,_7742,_7743,_7956,_7941,_7977),
    traceprint(4,bh09,_7995,_7977,_7774).

bus_head(_7702,1,_7704,route,_7706,_7707,[bus_head,_7802,_7836,{},_7880,_7909,_7933,_7967],_7773,_7775) --> 
    traceprint(5,bx10,_7802,_7773,_7821),
    art0(_7702,_7734,_7836,_7821,_7855),
    {user:_7734\==plu},
    filanepr(_7704,_7880,_7855,_7897),
    nr1(_7909,_7897,_7924),
    busnumber(_7707,_7706,_7933,_7924,_7952),
    traceprint(4,bh10,_7967,_7952,_7775).

bus_head(_7702,1,_7704,_7705,_7706,_7707,[bus_head,_7824,_7858,{},_7902,_7931,_7970,_7994,_8018,_8052,_8081],_7795,_7797) --> 
    traceprint(5,bx11,_7824,_7795,_7843),
    art0(_7702,_7743,_7858,_7843,_7877),
    {user:_7743\==plu},
    filanepr(_7704,_7902,_7877,_7919),
    busnoun(_7705,_7753,_7754,_7931,_7919,_7952),
    nr0(_7970,_7952,_7985),
    colon0(_7994,_7985,_8009),
    busnumber(_7707,_7706,_8018,_8009,_8037),
    not_look_ahead(w(noun(minute,_7764,_7765,_7766)),_8052,_8037,_8069),
    traceprint(4,bh11,_8081,_8069,_7797).

bus_head(_7702,_7703,_7704,_7705,_7706,_7707,[bus_head,_7807,_7841,_7875,{},_7919,_7958,_7992],_7778,_7780) --> 
    traceprint(5,bx12,_7807,_7778,_7826),
    art0(_7702,_7734,_7841,_7826,_7860),
    quantnext(_7703,_7704,_7875,_7860,_7894),
    {user:_7703<10},
    busnoun(_7705,_7745,plu,_7919,_7894,_7940),
    busnumber(_7707,_7706,_7958,_7940,_7977),
    traceprint(4,bh12,_7992,_7977,_7780).

bus_head(_7702,_7703,_7704,_7705,nil,_7707,[bus_head,_7801,_7835,_7869,{},_7913,_7952],_7772,_7774) --> 
    traceprint(5,bx13,_7801,_7772,_7820),
    art0(_7702,plu,_7835,_7820,_7854),
    quantnext(_7703,_7704,_7869,_7854,_7888),
    {user:_7703<100},
    busnoun(_7705,_7742,_7743,_7913,_7888,_7934),
    traceprint(4,bh13,_7952,_7934,_7774).

bus_head(_7702,_7703,_7704,_7705,nil,_7707,[bus_head,_7801,_7835,_7869,{},_7913,_7952],_7772,_7774) --> 
    traceprint(5,bx14,_7801,_7772,_7820),
    art0(_7702,_7731,_7835,_7820,_7854),
    quantnext(_7703,_7704,_7869,_7854,_7888),
    {user:_7703=<5},
    busnoun(_7705,_7742,plu,_7913,_7888,_7934),
    traceprint(4,bh14,_7952,_7934,_7774).

bus_head(_7702,1,_7704,_7705,_7706,_7707,[bus_head,_7811,_7845,_7879,_7908,{},_7952,_7991],_7782,_7784) --> 
    traceprint(5,bx15,_7811,_7782,_7830),
    art0(_7702,_7734,_7845,_7830,_7864),
    filanepr(_7704,_7879,_7864,_7896),
    busnumber(_7707,_7706,_7908,_7896,_7927),
    {user:(number(_7707),_7707>5)},
    busnoun(_7705,_7752,_7753,_7952,_7927,_7973),
    traceprint(4,bh15,_7991,_7973,_7784).

bus_head(_7702,1,_7704,_7705,_7706,_7707,[bus_head,_7806,_7840,_7874,_7903,{},_7947,_7986],_7777,_7779) --> 
    traceprint(5,bx16,_7806,_7777,_7825),
    art0(_7702,_7734,_7840,_7825,_7859),
    filanepr(_7704,_7874,_7859,_7891),
    busnumber(_7707,_7706,_7903,_7891,_7922),
    {user:_7707\==1},
    busnoun(_7705,_7747,sin,_7947,_7922,_7968),
    traceprint(4,bh16,_7986,_7968,_7779).

bus_head(u,1,nil,bus,number,_7707,[bus_head,_7819,_7853,_7882,{},_7921,_7960],_7790,_7792) --> 
    traceprint(5,bx17,_7819,_7790,_7838),
    not_look_ahead(w(name(_7734,n,route)),_7853,_7838,_7870),
    w(nb(_7707,num),_7882,_7870,_7899),
    {user:(number(_7707),_7707>5,_7707=<9999)},
    busnoun(bus,def,sin,_7921,_7899,_7942),
    traceprint(4,bh17,_7960,_7942,_7792).

bus_head(def,_7703,_7704,route,nil,_7707,[bus_head,_7796,lit(de),_7841,{},_7885,_7909],_7767,_7769) --> 
    traceprint(5,bx18,_7796,_7767,_7815),
    cc(de,_7815,_7840),
    quantnext(_7703,_7704,_7841,_7840,_7860),
    {user:_7703=<5},
    not_look_ahead_np(_7885,_7860,_7900),
    traceprint(4,bh18,_7909,_7900,_7769).

bus_head(_7702,_7703,_7704,route,nil,_7707,[bus_head,_7814,_7848,_7882,{},{},_7936,_7960,!],_7785,_7787) --> 
    traceprint(5,bx19,_7814,_7785,_7833),
    art0(_7702,_7734,_7848,_7833,_7867),
    quantnext(_7703,_7704,_7882,_7867,_7901),
    {user:_7704\==nil},
    {user:(_7703>0,_7703=<5)},
    not_look_ahead_np(_7936,_7901,_7951),
    traceprint(4,bh19,_7960,_7951,_7787),
    !.

bus_head(_7702,1,_7704,_7705,_7706,_7707,[bus_head,_7816,_7850,_7884,_7913,_7952,_7976,_8000,_8034,_8063],_7787,_7789) --> 
    traceprint(5,bx20,_7816,_7787,_7835),
    art0(_7702,_7740,_7850,_7835,_7869),
    filanepr(_7704,_7884,_7869,_7901),
    busnoun(_7705,_7745,sin,_7913,_7901,_7934),
    nr0(_7952,_7934,_7967),
    colon0(_7976,_7967,_7991),
    busnumber(_7707,_7706,_8000,_7991,_8019),
    not_look_ahead(w(noun(minute,_7756,_7757,_7758)),_8034,_8019,_8051),
    traceprint(4,bh20,_8063,_8051,_7789).

art0(u,plu,[art0,lit(noen),_7760,!],_7732,_7734) --> 
    cc(noen,_7732,_7759),
    look_ahead_np(_7760,_7759,_7734),
    !.

art0(u,sin,[art0,lit(noe),!],_7729,_7731) --> 
    cc(noe,_7729,_7731),
    !.

art0(_7702,_7703,[art0,_7747,!],_7730,_7732) --> 
    art(_7702,_7703,_7747,_7730,_7732),
    !.

art0(u,nil,[art0,[]],_7724,_7724) --> 
    [].

art(u,sin,[art,lit(en),!],_7729,_7731) --> 
    cc(en,_7729,_7731),
    !.

art(u,sin,[art,lit(et),!],_7729,_7731) --> 
    cc(et,_7729,_7731),
    !.

art(u,sin,[art,lit(ei),!],_7729,_7731) --> 
    cc(ei,_7729,_7731),
    !.

art(def,sin,[art,lit(den),!],_7729,_7731) --> 
    cc(den,_7729,_7731),
    !.

art(def,plu,[art,lit(det),!],_7729,_7731) --> 
    cc(det,_7729,_7731),
    !.

art(def,plu,[art,lit(de),!],_7729,_7731) --> 
    cc(de,_7729,_7731),
    !.

quantnext(_7702,_7703,[quantnext,_7751,_7780,!],_7734,_7736) --> 
    quant(_7702,_7751,_7734,_7768),
    filanepr(_7703,_7780,_7768,_7736),
    !.

quantnext(_7702,_7703,[quantnext,_7751,_7780,!],_7734,_7736) --> 
    filanepr(_7703,_7751,_7734,_7768),
    quant(_7702,_7780,_7768,_7736),
    !.

quant00(1,[quant00,[]],_7721,_7721) --> 
    [].

quant(_7702,[quant,_7740],_7726,_7728) --> 
    w(nb(_7702,num),_7740,_7726,_7728).

filanepr(_7702,[filanepr,_7740,!],_7726,_7728) --> 
    flnp(_7702,_7740,_7726,_7728),
    !.

filanepr(nil,[filanepr,[]],_7721,_7721) --> 
    [].

busseno(_7702,_7703,_7704,[busseno,_7766,_7805,_7829,_7853,!],_7746,_7748) --> 
    busnoun(_7703,_7719,_7720,_7766,_7746,_7787),
    nr0(_7805,_7787,_7820),
    colon0(_7829,_7820,_7844),
    busnumber(_7702,_7704,_7853,_7844,_7748),
    !.

busseno(_7702,_7703,_7704,[busseno,_7763,_7787,_7821,!],_7743,_7745) --> 
    nr0(_7763,_7743,_7778),
    busnumber(_7702,_7704,_7787,_7778,_7806),
    busnoun(_7703,_7719,_7720,_7821,_7806,_7745),
    !.

busnumber(_7702,_7703,[busnumber,_7857,_7901,{},_7940,_7969,_7998,_8022,_8051,_8080,_8109,_8138,_8167],_7840,_7842) --> 
    optional(w(noun(route,sin,u,n)),_7857,_7840,_7889),
    w(name(_7702,n,_7703),_7901,_7889,_7918),
    {user:test(subclass0(_7703,vehicle))},
    not_look_ahead(w(noun(minute,_7773,_7774,_7775)),_7940,_7918,_7957),
    not_look_ahead([:],_7969,_7957,_7986),
    point0(_7998,_7986,_8013),
    not_look_ahead(w(name(_7785,_7786,month)),_8022,_8013,_8039),
    not_look_ahead(w(name(_7785,_7794,day)),_8051,_8039,_8068),
    not_look_ahead(w(name(whitsun_day,_7802,date)),_8080,_8068,_8097),
    not_look_ahead(w(name(christmas_day,_7810,date)),_8109,_8097,_8126),
    not_look_ahead(w(name(easterday,_7818,date)),_8138,_8126,_8155),
    not_look_ahead(w(name(new_years_day,_7743,date)),_8167,_8155,_7842).

busnumber(_7702,number,[busnumber,_7846,_7890,_7919,_7948,_7977,_8001,_8030,_8059,_8088,_8117,_8146],_7829,_7831) --> 
    optional(w(noun(route,sin,u,n)),_7846,_7829,_7878),
    w(nb(_7702,num),_7890,_7878,_7907),
    not_look_ahead(w(noun(minute,_7762,_7763,_7764)),_7919,_7907,_7936),
    not_look_ahead([:],_7948,_7936,_7965),
    point0(_7977,_7965,_7992),
    not_look_ahead(w(name(_7774,_7775,month)),_8001,_7992,_8018),
    not_look_ahead(w(name(_7774,_7783,day)),_8030,_8018,_8047),
    not_look_ahead(w(name(whitsun_day,_7791,date)),_8059,_8047,_8076),
    not_look_ahead(w(name(christmas_day,_7799,date)),_8088,_8076,_8105),
    not_look_ahead(w(name(easterday,_7807,date)),_8117,_8105,_8134),
    not_look_ahead(w(name(new_years_day,_7740,date)),_8146,_8134,_7831).

busse0(_7702,_7703,_7704,_7705,[busse0,_7760,!],_7737,_7739) --> 
    busnoun(_7703,_7704,_7705,_7760,_7737,_7739),
    !.

busse0(_7702,_7702,u,sin,[busse0,[]],_7730,_7730) --> 
    [].

busnoun(_7702,_7703,_7704,[busnoun,_7776,!,{},_7820],_7756,_7758) --> 
    w(noun(_7702,_7704,_7703,n),_7776,_7756,_7793),
    !,
    {user:(test(subclass0(_7702,vehicle));_7702=number)},
    point0(_7820,_7793,_7758).

aname_phrase(0,_7703,_7706::_7706 and _7710,[aname_phrase,_7791,_7815,_7844,_7873,{},!],_7771,_7773) --> 
    a0(_7791,_7771,_7806),
    look_ahead(w(name(_7731,n,_7733)),_7815,_7806,_7832),
    preadjs(_7735,_7844,_7832,_7861),
    noun2(_7737,_7738,n,_7703,_7741,_7873,_7861,_7773),
    {user:preadjs_template(_7735,_7703,_7741,_7710)},
    !.

aname_phrase(_7702,_7703,_7706::_7706 and _7710,[aname_phrase,_7794,_7823,lit(gang),!,_7868,_7892],_7774,_7776) --> 
    w(name(_7732,n,route),_7794,_7774,_7811),
    w(adj2(next,nil),_7823,_7811,_7840),
    cc(gang,_7840,_7862),
    !,
    accept(_7868,_7862,_7883),
    pushstack(first,w(name(_7732,n,route)),nil,_7883,_7902),
    namep(_7702,_7703,_7710,_7892,_7902,_7776).

aname_phrase(_7702,_7703,_7704,[aname_phrase,_7767,_7796,_7825,!,_7854],_7747,_7749) --> 
    number(_7718,_7767,_7747,_7784),
    not_look_ahead(w(prep(from)),_7796,_7784,_7813),
    filanepr(_7825,_7813,_7840),
    !,
    reject(_7854,_7840,_7749).

aname_phrase(_7702,_7703,_7704,[aname_phrase,_7781,_7805,_7829,_7858,{},!,_7902],_7761,_7763) --> 
    dent0(_7781,_7761,_7796),
    filanepr(_7805,_7796,_7820),
    bus_number(_7724,_7829,_7820,_7846),
    w(noun(_7728,plu,_7730,_7731),_7858,_7846,_7875),
    {user:testmember(_7728,[bus])},
    !,
    reject(_7902,_7875,_7763).

aname_phrase(_7702,_7703,_7704,[aname_phrase,_7787,_7811,_7840,_7874,{},!,_7918],_7767,_7769) --> 
    dent0(_7787,_7767,_7802),
    w(adj2(_7726,nil),_7811,_7802,_7828),
    gmem(_7726,[nearest],_7840,_7828,_7859),
    w(name(_7736,_7737,_7738),_7874,_7859,_7891),
    {user:(\+number(_7736))},
    !,
    reject(_7918,_7891,_7769).

aname_phrase(_7702,_7703,_7706::_7707,[aname_phrase,_7789,_7813,_7842,_7871,_7900,{}],_7769,_7771) --> 
    a0(_7789,_7769,_7804),
    preadjs0(_7726,_7813,_7804,_7830),
    not_look_ahead([jeg],_7842,_7830,_7859),
    not_look_ahead([du],_7871,_7859,_7888),
    name_phrase(_7702,_7703,_7706::_7728,_7900,_7888,_7771),
    {user:preadjs_template(_7726,_7703,_7728,_7707)}.

aname_phrase(_7702,_7703,_7706::_7707,[aname_phrase,_7767,_7796,_7820],_7747,_7749) --> 
    not_look_ahead([ett],_7767,_7747,_7784),
    a0(_7796,_7784,_7811),
    name_phrase(_7702,_7703,_7706::_7707,_7820,_7811,_7749).

aname_phrase(name,_7703,_7704,[aname_phrase,_7751],_7731,_7733) --> 
    person_name(_7703,_7704,_7708,_7751,_7731,_7733).

name_phrase(0,_7703,_7706::_7707,[name_phrase,_7845,_7874,_7903,_7932,_7956,_7985,!,{},{},_8039],_7825,_7827) --> 
    w(noun(time,sin,def,n),_7845,_7825,_7862),
    w(nb(_7756,num),_7874,_7862,_7891),
    w(nb(_7761,num),_7903,_7891,_7920),
    to0(_7932,_7920,_7947),
    w(nb(_7766,num),_7956,_7947,_7973),
    w(nb(_7771,num),_7985,_7973,_8002),
    !,
    {user:_7776 is _7756*100+_7761},
    {user:_7745 is _7766*100+_7771},
    lock(exact,_8002,_8152),
    pushstack(exact,(time1(_7776),and1,time1(_7745)),nil,_8152,_8158),
    noun_phrases(_7703,_7706::_7707,_8039,_8158,_8147),
    unlock(_8147,_7827).

name_phrase(0,_7703,_7706::_7707,[name_phrase,_7795,_7824,_7853,_7877,!,_7911],_7775,_7777) --> 
    w(noun(time,sin,def,n),_7795,_7775,_7812),
    timexp(_7742,_7824,_7812,_7841),
    to0(_7853,_7841,_7868),
    timexp(_7733,_7877,_7868,_7894),
    !,
    pushstack(first,(time1(_7742),and1,time1(_7733)),nil,_7894,_8009),
    noun_phrases(_7703,_7706::_7707,_7911,_8009,_7777).

name_phrase(_7702,_7703,_7706::_7709 and _7706,[name_phrase,_7779,_7808,_7847],_7759,_7761) --> 
    look_ahead(w(nb(_7731,_7732)),_7779,_7759,_7796),
    namep(_7702,_7703,_7709,_7808,_7796,_7829),
    not_look_ahead(w(noun(minute,_7723,_7724,_7725)),_7847,_7829,_7761).

name_phrase(_7702,_7703,_7706::_7709 and _7706,[name_phrase,_7779,_7808,_7847],_7759,_7761) --> 
    look_ahead(w(nb(_7731,_7732)),_7779,_7759,_7796),
    namep(_7702,_7703,_7709,_7808,_7796,_7829),
    not_look_ahead(w(noun(minute,_7723,_7724,_7725)),_7847,_7829,_7761).

name_phrase(_7702,_7703,_7706::_7709 and _7706,[name_phrase,_7757],_7737,_7739) --> 
    namep(_7702,_7703,_7709,_7757,_7737,_7739).

person_name((_7709,_7712,_7713):person,_7715 and _7718 and _7719,_7704,[person_name,_7786,_7825,_7864,!,_7908],_7766,_7768) --> 
    properfirstname(_7709,_7715,_7735,_7786,_7766,_7807),
    properfirstname(_7712,_7718,_7739,_7825,_7807,_7846),
    properlastname(_7713,_7719,_7704,_7864,_7846,_7885),
    !,
    accept(_7908,_7885,_7768).

person_name((_7709,_7710):person,_7712 and _7713,_7704,[person_name,_7773,_7812,!,_7856],_7753,_7755) --> 
    properfirstname(_7709,_7712,_7726,_7773,_7753,_7794),
    properlastname(_7710,_7713,_7704,_7812,_7794,_7833),
    !,
    accept(_7856,_7833,_7755).

properfirstname(_7702,_7703,_7704,[properfirstname,_7754],_7734,_7736) --> 
    name1g(_7702:firstname,_7703,_7704,_7754,_7734,_7736).

properlastname(_7702,_7703,_7704,[properlastname,_7754],_7734,_7736) --> 
    name1g(_7702:lastname,_7703,_7704,_7754,_7734,_7736).

np_head(_7702,_7703,_7704,[np_head,lit(ett),_7776,!,_7810],_7745,_7747) --> 
    cc(ett,_7745,_7775),
    w(noun(time,_7720,def,_7722),_7776,_7775,_7793),
    !,
    reject(_7810,_7793,_7747).

np_head(0,_7703,_7706::_7707,[np_head,_7803,_7827,_7856,!,_7900,_7929,{},{}],_7783,_7785) --> 
    the0(_7803,_7783,_7818),
    preadjs0(_7737,_7827,_7818,_7844),
    quantifier(_7703,_7735,_7735 and _7706::_7707,_7856,_7844,_7877),
    !,
    preadjs0(_7732,_7900,_7877,_7917),
    noun_complex(_7751,_7703,_7753,_7929,_7917,_7785),
    {user:preadjs_template(_7737,_7703,_7753,_7734)},
    {user:preadjs_template(_7732,_7703,_7734,_7735)}.

np_head(_7702,_7703,_7704,[np_head,_7807,_7856,{},_7895,_7924,{}],_7787,_7789) --> 
    determiner0(_7728,_7702,_7703,_7726,_7704,_7807,_7787,_7832),
    preadjs0(_7723,_7856,_7832,_7873),
    {user:(_7723=true->_7741=_7728;_7741=_7742)},
    not_look_ahead(w(noun(crown,_7758,_7759,_7760)),_7895,_7873,_7912),
    noun_complex(_7741,_7703,_7725,_7924,_7912,_7789),
    {user:preadjs_template(_7723,_7703,_7725,_7726)}.

np_head(0,_7703,_7706::findpron(_7721)::exists(_7703)::_7715 and _7718 and _7706,[np_head,_7807,_7831,_7885,!,_7919,{}],_7787,_7789) --> 
    thispron(_7807,_7787,_7822),
    noun(_7746,_7747,_7748,gen,_7721,_7718,_7831,_7822,_7858),
    look_ahead(w(nb(_7757,num)),_7885,_7858,_7902),
    !,
    np0_accept(_7703,_7744::_7715,_7919,_7902,_7789),
    {user:has_template(_7721,_7703,_7744)}.

np_head(0,_7703,_7706::findpron(_7727)::exists(_7703)::_7715 and _7718 and _7721 and _7724 and _7706,[np_head,_7819,_7843,!,_7902,_7931,_7970,{},{}],_7799,_7801) --> 
    thispron(_7819,_7799,_7834),
    noun(_7758,_7759,_7760,gen,_7727,_7721,_7843,_7834,_7870),
    !,
    preadjs0(_7765,_7902,_7870,_7919),
    noun_compound(_7703,_7718,_7769,_7931,_7919,_7952),
    not_look_aheadnounx(_7970,_7952,_7801),
    {user:preadjs_template(_7765,_7703,_7718,_7715)},
    {user:has_template(_7727,_7703,_7724)}.

not_look_aheadnounx([not_look_aheadnounx,_7739,!],_7728,_7730) --> 
    look_ahead(w(verb(_7709,_7710,fin)),_7739,_7728,_7730),
    !.

not_look_aheadnounx([not_look_aheadnounx,_7740,!],_7729,_7731) --> 
    look_ahead(w(noun(clock,_7710,_7711,_7712)),_7740,_7729,_7731),
    !.

not_look_aheadnounx([not_look_aheadnounx,_7737],_7726,_7728) --> 
    not_look_ahead(w(noun(_7706,_7707,_7708,_7709)),_7737,_7726,_7728).

noun_complex(_7702,_7706:_7707,_7706 isa _7707,[noun_complex,_7802,_7831,_7860,_7889,{},!],_7782,_7784) --> 
    not_look_ahead(w(nb(_7731,_7732)),_7802,_7782,_7819),
    w(name(_7706,n,_7738),_7831,_7819,_7848),
    not_look_ahead(w(verb(_7744,pres,fin)),_7860,_7848,_7877),
    w(noun(_7750,_7702,_7752,n),_7889,_7877,_7784),
    {user:joinclass(_7750,_7738,_7707)},
    !.

noun_complex(sin,_7706:_7707,_7706 isa _7707,[noun_complex,_7770,_7799,!],_7750,_7752) --> 
    w(noun(_7707,sin,_7722,n),_7770,_7750,_7787),
    w(quote(_7706),_7799,_7787,_7752),
    !.

noun_complex(sin,_7706:_7710,_7706 isa _7707,[noun_complex,_7820,_7849,_7878,_7907,_7936,_7960,{},!],_7800,_7802) --> 
    w(noun(_7707,sin,_7737,n),_7820,_7800,_7837),
    not_look_ahead([du],_7849,_7837,_7866),
    w(name(_7706,n,_7748),_7878,_7866,_7895),
    not_look_ahead(w(noun(minute,_7755,_7756,_7757)),_7907,_7895,_7924),
    point0(_7936,_7924,_7951),
    not_look_ahead(w(name(_7763,_7764,date)),_7960,_7951,_7802),
    {user:(joinclass(_7707,_7748,_7710),_7710\==nil)},
    !.

noun_complex(sin,_7706:_7707,_7706 isa _7707,[noun_complex,_7802,_7831,{},_7870,_7894,!],_7782,_7784) --> 
    w(noun(_7707,_7730,_7731,n),_7802,_7782,_7819),
    w(nb(_7706,num),_7831,_7819,_7848),
    {user:testmember(_7707,[footnote,page,sms,telephone,week,year])},
    and1(_7870,_7848,_7885),
    w(nb(_7758,_7759),_7894,_7885,_7784),
    !.

noun_complex(_7702,_7706:_7707,_7706 isa _7707,[noun_complex,_7793,_7822,{},!],_7773,_7775) --> 
    w(noun(_7707,_7702,_7725,n),_7793,_7773,_7810),
    w(nb(_7706,num),_7822,_7810,_7775),
    {user:testmember(_7707,[footnote,page,sms,telephone,week,year,number])},
    !.

noun_complex(_7702,_7706:_7707,_7706 isa _7707,[noun_complex,_7838,{},_7877,_7911,_7940,_7974,_8003,_8032,_8061,!,_8095],_7818,_7820) --> 
    w(noun(_7707,_7702,_7746,n),_7838,_7818,_7855),
    {user:subtype0(_7707,vehicle)},
    plausibleno(_7707,_7706,_7877,_7855,_7896),
    not_look_ahead([ganger],_7911,_7896,_7928),
    plausibleno(_7707,_7706,_7940,_7928,_7959),
    not_look_ahead_lit([sin,sitt,sine],_7974,_7959,_7991),
    not_look_ahead(w(name(_7776,_7777,month)),_8003,_7991,_8020),
    not_look_ahead(w(name(_7776,_7785,date)),_8032,_8020,_8049),
    not_look_ahead(w(noun(_7792,plu,_7794,_7795)),_8061,_8049,_8078),
    !,
    accept(_8095,_8078,_7820).

noun_complex(plu,_7706:_7707,_7706 isa _7707,[noun_complex,_7774,_7808,{}],_7754,_7756) --> 
    plausibleno(_7707,_7706,_7774,_7754,_7793),
    w(noun(_7707,sin,u,n),_7808,_7793,_7756),
    {user:subtype0(_7707,vehicle)}.

noun_complex(_7702,_7703,_7704,[noun_complex,_7772,_7811,_7840],_7752,_7754) --> 
    noun_list(_7702,_7703,_7704,_7772,_7752,_7793),
    not_look_ahead_lit([sin,sitt,sine],_7811,_7793,_7828),
    not_look_ahead(w(nb(_7716,_7717)),_7840,_7828,_7754).

noun_complex(_7702,_7703,_7704,[noun_complex,_7765,_7794,_7823],_7745,_7747) --> 
    not_look_ahead([noe],_7765,_7745,_7782),
    not_look_ahead([min],_7794,_7782,_7811),
    noun_compound(_7703,_7704,_7702,_7823,_7811,_7747).

plausibleno(_7702,_7703,[plausibleno,_7755,_7784,_7808,!,_7837],_7738,_7740) --> 
    num(_7717,_7755,_7738,_7772),
    point(_7784,_7772,_7799),
    monthnamex(_7808,_7799,_7823),
    !,
    reject(_7837,_7823,_7740).

plausibleno(_7702,_7703,[plausibleno,_7752,_7781,!,_7810],_7735,_7737) --> 
    num(_7714,_7752,_7735,_7769),
    colon(_7781,_7769,_7796),
    !,
    reject(_7810,_7796,_7737).

plausibleno(_7702,_7703,[plausibleno,_7754,_7783,!,_7817],_7737,_7739) --> 
    num(_7714,_7754,_7737,_7771),
    monthname(_7716,_7783,_7771,_7800),
    !,
    reject(_7817,_7800,_7739).

plausibleno(_7702,_7703,[plausibleno,_7760,_7784,{}],_7743,_7745) --> 
    nr0(_7760,_7743,_7775),
    num(_7703,_7784,_7775,_7745),
    {user:(_7703>0,_7703<1000)}.

plausibleno(_7702,_7703,[plausibleno,_7757,_7781,{}],_7740,_7742) --> 
    nr0(_7757,_7740,_7772),
    w(nb(_7703,alf),_7781,_7772,_7742),
    {user:_7703<1000}.

npa(_7714:_7715,_7705::findexternal(_7714:_7715)::_7714 isa _7715 and _7705,[npa,_7787,_7816,!,{}],_7770,_7772) --> 
    one_of_lit([det,dette],_7787,_7770,_7804),
    look_ahead(w(adv(_7749)),_7816,_7804,_7772),
    !,
    {user:_7715=thing}.

npa(_7714:_7715,_7705::findexternal(_7714:_7715)::_7714 isa _7715 and _7705,[npa,lit(dette),_7785,{}],_7757,_7759) --> 
    cc(dette,_7757,_7784),
    not_look_ahead_np(_7785,_7784,_7759),
    {user:_7715=thing}.

npa(_7714:_7715,_7705::findexternal(_7714:thing)::_7714 isa _7715 and _7705,[npa,lit(det),_7788,_7817],_7760,_7762) --> 
    cc(det,_7760,_7787),
    look_ahead(w(verb(_7737,_7738,fin)),_7788,_7787,_7805),
    not_look_ahead_np(_7817,_7805,_7762).

npa(_7702,_7705::findit(_7711)::_7709,[npa,_7778,_7802,_7841,{}],_7761,_7763) --> 
    its(_7778,_7761,_7793),
    determiner00(_7702,_7735 and _7726,_7705::_7709,_7802,_7793,_7823),
    noun_compound(_7702,_7735,_7740,_7841,_7823,_7763),
    {user:has_template(_7711,_7702,_7726)}.

npa(_7702,_7703,[npa,_7750,_7774,!,_7803],_7733,_7735) --> 
    this(_7750,_7733,_7765),
    look_ahead_np(_7774,_7765,_7789),
    !,
    reject(_7803,_7789,_7735).

npa(_7702,_7705::find(_7702)::_7711 and _7705,[npa,_7759],_7742,_7744) --> 
    noun(_7716,_7717,def,n,_7702,_7711,_7759,_7742,_7744).

npa(_7714:_7715,_7705::findexternal(_7714:_7715)::_7714 isa _7723 and _7705,[npa,lit(denne),_7809,_7838,{},{}],_7781,_7783) --> 
    cc(denne,_7781,_7808),
    not_look_ahead(w(adj),_7809,_7808,_7826),
    not_look_ahead(w(noun(_7752,_7753,_7754,_7755)),_7838,_7826,_7783),
    {user:_7723=thing},
    {user:type(_7723,_7715)}.

npa(_7714:_7715,_7705::findpron(_7714:_7715)::_7714 isa thing and _7705,[npa,lit(det),_7785,{}],_7757,_7759) --> 
    cc(det,_7757,_7784),
    endofline(_7785,_7784,_7759),
    {user:type(thing,_7715)}.

npa(_7702,_7705::_7706,[npa,_7787,_7811,_7840,_7869],_7770,_7772) --> 
    allsome0(_7787,_7770,_7802),
    posspron(_7731,_7811,_7802,_7828),
    w(nb(_7728,num),_7840,_7828,_7857),
    pushstack(first,(thispron,w(noun(_7731,sin,u,gen)),w(nb(_7728,num))),nil,_7857,_7910),
    np1(_7702,_7705::_7706,_7869,_7910,_7772).

npa(_7702,_7705::_7706,[npa,_7771,_7795,_7824],_7754,_7756) --> 
    allsome0(_7771,_7754,_7786),
    posspron(_7722,_7795,_7786,_7812),
    pushstack(first,(thispron,w(noun(_7722,sin,u,gen))),nil,_7812,_7862),
    np1(_7702,_7705::_7706,_7824,_7862,_7756).

npa(_7702,_7703,[npa,lit(de),_7825,_7854,_7883,_7912,!,_7946],_7797,_7799) --> 
    cc(de,_7797,_7824),
    w(nb(_7743,num),_7825,_7824,_7842),
    flnp(_7746,_7854,_7842,_7871),
    not_look_ahead(w(name(_7752,_7753,_7754)),_7883,_7871,_7900),
    not_look_ahead(w(noun(_7760,_7761,_7762,_7763)),_7912,_7900,_7929),
    !,
    pushstack(first,(w(nb(_7743,num)),w(adj2(_7746,nil)),w(noun(vehicle,sin,u,n))),nil,_7929,_7956),
    np1(_7702,_7703,_7946,_7956,_7799).

npa(_7702,_7705::_7706,[npa,_7830,_7854,_7883,_7912,_7941,_7970,_7994,_8023,!,_8057],_7813,_7815) --> 
    dent0(_7830,_7813,_7845),
    not_look_ahead([først],_7854,_7845,_7871),
    not_look_ahead([sist],_7883,_7871,_7900),
    not_look_ahead([senest],_7912,_7900,_7929),
    not_look_ahead([tidligst],_7941,_7929,_7958),
    nest(_7970,_7958,_7985),
    flnp(_7767,_7994,_7985,_8011),
    not_look_ahead(w(noun(_7773,_7774,_7775,_7776)),_8023,_8011,_8040),
    !,
    pushstack(first,(w(adj2(second,nil)),w(adj2(_7767,nil)),w(noun(vehicle,sin,u,n))),nil,_8040,_8067),
    np1(_7702,_7705::_7706,_8057,_8067,_7815).

npa(_7702,_7705::_7706,[npa,_7834,_7858,_7887,_7916,_7945,!,_7979,_8050],_7817,_7819) --> 
    dent0(_7834,_7817,_7849),
    not_look_ahead([f,s,først,sist,senest,tidligst],_7858,_7849,_7875),
    flnp(_7752,_7887,_7875,_7904),
    not_look_ahead(w(name(_7758,_7759,_7760)),_7916,_7904,_7933),
    not_look_ahead(w(noun(_7766,_7767,_7768,_7769)),_7945,_7933,_7962),
    !,
    pushstack(first,(a,w(adj2(_7752,nil)),w(noun(vehicle,sin,u,n))),nil,_7962,_8020),np1(_7702,_7705::_7706,_7979,_8020,_8035),
    optional(w(noun(bus,sin,_7735,_7736)),_8050,_8035,_7819).

npa(_7702,_7703,[npa,{},lit(den),_7803,_7832,!,_7866],_7765,_7767) --> 
    {user:value(busflag,true)},
    cc(den,_7765,_7802),
    not_look_ahead(w(adj2(_7734,nil)),_7803,_7802,_7820),
    not_look_ahead(w(noun(_7741,_7742,_7743,_7744)),_7832,_7820,_7849),
    !,
    npit(_7702,_7703,_7866,_7849,_7767).

npa(_7702,_7705::_7706,[npa,lit(den),_7804,_7833,!,_7867],_7776,_7778) --> 
    cc(den,_7776,_7803),
    not_look_ahead(w(adj2(_7739,nil)),_7804,_7803,_7821),
    not_look_ahead(w(noun(_7746,_7747,_7748,_7749)),_7833,_7821,_7850),
    !,
    lock(exact,_7850,_7912),
    pushstack(exact,(this,w(noun(thing,sin,u,n))),nil,_7912,_7918),
    np1(_7702,_7705::_7706,_7867,_7918,_7907),
    unlock(_7907,_7778).

npit(_7711:_7712,_7705::_7711 isa _7712 and _7705,[npit,{}],_7743,_7743) --> 
    {user:it_template(_7711:_7712)}.

adjnoun([adjnoun,_7733],_7722,_7724) --> 
    w(adj2(nil,nil),_7733,_7722,_7724).

adjnoun([adjnoun,_7735],_7724,_7726) --> 
    w(noun(_7704,plu,u,_7707),_7735,_7724,_7726).

np2(_7702,_7703,[np2,lit(noe),_7793,_7822,!,_7851],_7765,_7767) --> 
    cc(noe,_7765,_7792),
    w(adj2(_7734,_7735),_7793,_7792,_7810),
    not_look_ahead_np(_7822,_7810,_7837),
    !,
    lock(exact,_7837,_7868),
    pushstack(exact,(w(adj2(_7734,_7735)),w(noun(thing,sin,u,n))),nil,_7868,_7874),
    np_kernel(0,_7702,_7703,_7851,_7874,_7863),
    unlock(_7863,_7767).

np2(_7702,_7703,[np2,lit(noe),_7791,!,_7825,_7886],_7763,_7765) --> 
    cc(noe,_7763,_7790),
    look_ahead(w(prep(_7728)),_7791,_7790,_7808),
    !,
    lock(exact,_7808,_7845),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7845,_7851),np_kernel(0,_7702,_7719,_7825,_7851,_7840),unlock(_7840,_7841),
    noun_modifiers0(0,_7702,_7719,_7703,_7886,_7841,_7765).

np2(_7702,_7703,[np2,_7813,_7847,{},!,_7891,!],_7796,_7798) --> 
    clock_kernel(_7723:clock,_7723 isa clock,_7813,_7796,_7832),
    w(noun(_7731,sin,_7733,n),_7847,_7832,_7864),
    {user:testmember(_7731,[departure,arrival])},
    !,
    lock(exact,_7864,_7944),pushstack(exact,(w(noun(_7731,sin,def,n)),w(prep(at)),clock_kernel(_7723:clock,_7723 isa clock)),nil,_7944,_7950),np1(_7702,_7703,_7891,_7950,_7939),unlock(_7939,_7798),
    !.

np2(_7702,_7703,[np2,_7800,_7824,lit(enn),!,_7869,!,_7908,!],_7783,_7785) --> 
    anders(_7800,_7783,_7815),
    w(noun(_7728,_7729,_7730,n),_7824,_7815,_7841),
    cc(enn,_7841,_7863),
    !,
    np1(_7735,_7736,_7869,_7863,_7888),
    !,
    lock(exact,_7888,_7959),pushstack(exact,(w(noun(_7728,_7729,_7730,n)),w(prep(except)),xnp(_7735,_7736)),nil,_7959,_7965),np1(_7702,_7703,_7908,_7965,_7954),unlock(_7954,_7785),
    !.

anders([anders,lit(andre),!],_7722,_7724) --> 
    cc(andre,_7722,_7724),
    !.

anders([anders,lit(en),lit(annen),!],_7727,_7729) --> 
    cc(en,_7727,_7748),
    cc(annen,_7748,_7729),
    !.

np2(_7702,_7703,[np2,lit(samme),_7813,lit(som),!,_7858,!,_7897,!],_7785,_7787) --> 
    cc(samme,_7785,_7812),
    w(noun(_7730,sin,u,n),_7813,_7812,_7830),
    cc(som,_7830,_7852),
    !,
    np1(_7737,_7738,_7858,_7852,_7877),
    !,
    lock(exact,_7877,_7948),pushstack(exact,(w(noun(_7730,sin,def,n)),w(prep(as)),xnp(_7737,_7738)),nil,_7948,_7954),np1(_7702,_7703,_7897,_7954,_7943),unlock(_7943,_7787),
    !.

np2(_7711:_7712,_7705::_7708 and _7705,[np2,_7819,_7848,_7882,{},{}],_7802,_7804) --> 
    w(name(_7745,n,_7747),_7819,_7802,_7836),
    gmem(_7747,[company],_7848,_7836,_7867),
    w(noun(_7712,_7757,_7758,n),_7882,_7867,_7804),
    {user:subclass0(_7712,vehicle)},
    {user:_7708=(exists(_7711)::_7711 isa _7712 and _7745 isa _7747 and adj/nil/_7745/_7711/real)}.

np2(_7702,_7703,[np2,_7849,{},{},_7898,_7927,_7956,{},!,_8000,_8024,!],_7832,_7834) --> 
    w(name(_7737,n,_7739),_7849,_7832,_7866),
    {user:testmember(_7739,[neighbourhood,station,street])},
    {user:(\+testmember(_7737,[sentrum]))},
    w(noun(_7763,_7764,_7765,n),_7898,_7866,_7915),
    not_look_ahead([nr],_7927,_7915,_7944),
    not_look_ahead(w(nb(_7776,_7777)),_7956,_7944,_7973),
    {user:subclass0(_7763,vehicle)},
    !,
    accept(_8000,_7973,_8015),
    lock(exact,_8015,_8044),pushstack(exact,(w(noun(_7763,sin,def,n)),w(prep(to)),w(name(_7737,n,_7739))),nil,_8044,_8050),np1(_7702,_7703,_8024,_8050,_8039),unlock(_8039,_7834),
    !.

np2(_7702,_7703,[np2,_7803,{},_7842,_7871,!,_7905,_7929,!],_7786,_7788) --> 
    w(nb(_7728,num),_7803,_7786,_7820),
    {user:this_year(_7728)},
    not_look_ahead([-],_7842,_7820,_7859),
    not_look_ahead(w(nb(_7743,_7744)),_7871,_7859,_7888),
    !,
    accept(_7905,_7888,_7920),
    lock(exact,_7920,_7949),pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_7728,num))),nil,_7949,_7955),np1(_7702,_7703,_7929,_7955,_7944),unlock(_7944,_7788),
    !.

np2(_7702,_7703,[np2,_7783,_7807,lit(enn),!,_7852],_7766,_7768) --> 
    oter(_7783,_7766,_7798),
    w(noun(_7730,_7731,u,n),_7807,_7798,_7824),
    cc(enn,_7824,_7846),
    !,
    pushstack(first,(a,w(noun(_7730,sin,u,n)),[ulik]),nil,_7846,_7890),
    np1(_7702,_7703,_7852,_7890,_7768).

np2(_7702,_7705::_7706,[np2,_7787,_7816,_7845,_7879],_7770,_7772) --> 
    not_look_ahead([alle],_7787,_7770,_7804),
    not_look_ahead(w(name(_7738,_7739,_7740)),_7816,_7804,_7833),
    quant_pron(every,_7725,_7845,_7833,_7864),
    pushstack(first,(every,w(noun(_7725,sin,u,n))),nil,_7864,_7917),
    np1(_7702,_7705::_7706,_7879,_7917,_7772).

np2(_7702,_7703,[np2,_7773,_7807,_7836,_7860],_7756,_7758) --> 
    quant_pron(every,_7722,_7773,_7756,_7792),
    not_look_ahead([som],_7807,_7792,_7824),
    not_look_ahead_np(_7836,_7824,_7851),
    pushstack(first,(every,w(noun(_7722,sin,u,n))),nil,_7851,_7898),
    np0_accept(_7702,_7703,_7860,_7898,_7758).

np2(_7702,_7703,[np2,_7764,_7798,_7822,_7851,_7875],_7747,_7749) --> 
    quant_pron(some,_7717,_7764,_7747,_7783),
    rfxpron0(_7798,_7783,_7813),
    not_look_ahead([som],_7822,_7813,_7839),
    not_look_ahead_np(_7851,_7839,_7866),
    np00(_7717,_7702,_7703,_7875,_7866,_7749).

clock_number(_7704:_7705,[clock_number,_7753,{},!],_7739,_7741) --> 
    number(_7704:_7705,_7753,_7739,_7741),
    {user:clock_test(_7704)},
    !.

bus_number(_7704:_7705,[bus_number,_7750,{}],_7736,_7738) --> 
    number(_7704:_7705,_7750,_7736,_7738),
    {user:plausible_busno(_7704)}.

road_number(_7704:_7705,[road_number,_7751,{}],_7737,_7739) --> 
    number(_7704:_7705,_7751,_7737,_7739),
    {user:_7704=<200}.

noun_list2(_7702,_7703,_7704,[noun_list2,_7762,_7816],_7742,_7744) --> 
    noun(_7714,_7702,u,n,_7709,_7710,_7762,_7742,_7789),
    nlists10(_7709,_7710,_7703,_7704,_7816,_7789,_7744).

nlists10(_7710:_7711,_7703,(_7710,_7720):(_7711,_7717),_7703 and _7708,[nlists10,_7789,_7813,_7867],_7766,_7768) --> 
    comma(_7789,_7766,_7804),
    noun(_7733,_7734,_7735,n,_7728,_7729,_7813,_7804,_7840),
    nlists10(_7728,_7729,_7720:_7717,_7708,_7867,_7840,_7768).

nlists10(_7710:_7711,_7703,(_7710,_7720):(_7711,_7717),_7703 and _7708,[nlists10,_7783,_7812],_7760,_7762) --> 
    andor(_7732,_7783,_7760,_7800),
    noun(_7725,_7726,_7727,n,_7720:_7717,_7708,_7812,_7800,_7762).

noun_list(_7702,_7703,_7704,[noun_list,_7805,_7834,_7863,_7892,_7921,{},_7985],_7785,_7787) --> 
    not_look_ahead([noe],_7805,_7785,_7822),
    not_look_ahead([noen],_7834,_7822,_7851),
    not_look_ahead([min],_7863,_7851,_7880),
    not_look_ahead(w(adj2(_7745,nil)),_7892,_7880,_7909),
    noun(_7748,_7702,_7750,n,_7724,_7725,_7921,_7909,_7948),
    {user:(\+testmember(_7748,[clock]))},
    nlists0join(_7724,_7725,_7703,_7704,_7985,_7948,_7787).

nlists0join(_7702,_7703,_7707:_7708,_7705,[nlists0join,_7786,{},!,_7845,{}],_7763,_7765) --> 
    nlists0(_7702,_7703,_7707:_7733,_7705,_7786,_7763,_7809),
    {user:joinclasses(_7733,_7708)},
    !,
    accept(_7845,_7809,_7765),
    {user:_7708\==thing}.

nlists0(_7710:_7711,_7703,(_7710,_7720):(_7711,_7717),_7703 and _7708,[nlists0,lit(og),_7845,_7874,_7928,{},{},_7977],_7811,_7813) --> 
    cc(og,_7811,_7844),
    not_look_ahead_lit([da,så,min],_7845,_7844,_7862),
    noun(_7755,_7756,_7757,n,_7740,_7741,_7874,_7862,_7901),
    not_look_ahead(w(prep(_7766)),_7928,_7901,_7945),
    {user:joinclass(_7711,_7755,_7772)},
    {user:(_7772\==thing,_7772\==nil)},
    nlists0(_7740,_7741,_7720:_7717,_7708,_7977,_7945,_7813).

nlists0(_7702,_7703,_7702,_7703,[nlists0,[],_7770],_7742,_7744) --> 
    [],
    not_look_ahead(w(noun(_7714,_7715,_7716,_7717)),_7770,_7742,_7744).

postcode(_7702,[postcode,_7784,{},_7823,{}],_7770,_7772) --> 
    w(nb(_7702,num),_7784,_7770,_7801),
    {user:(number(_7702),_7702>=1000,_7702=<9999)},
    look_ahead(w(name(_7749,n,_7715)),_7823,_7801,_7772),
    {user:testmember(_7715,[city,neighbourhood,station])}.

noun_compound(_7702,_7703,sin,[noun_compound,_7771,_7800,_7839,_7863],_7751,_7753) --> 
    not_look_ahead([man],_7771,_7751,_7788),
    namep(_7726,_7717,_7718,_7800,_7788,_7821),
    sin(_7839,_7821,_7854),
    ncomps0(gen,_7702,_7717,_7718,_7703,_7720,_7863,_7854,_7753).

noun_compound(_7702,_7706 and _7707,_7704,[noun_compound,_7782,_7811,_7840,{}],_7762,_7764) --> 
    not_look_ahead([dere],_7782,_7762,_7799),
    w(name(_7720,_7731,_7732),_7811,_7799,_7828),
    noun(_7734,_7704,u,n,_7702,_7706,_7840,_7828,_7764),
    {user:adjnamecomp_template(_7720,_7702,_7707)}.

noun_compound(_7702,_7703,_7704,[noun_compound,_7786,_7815,{},_7874,_7918],_7766,_7768) --> 
    not_look_ahead([man],_7786,_7766,_7803),
    noun2(_7729,_7730,_7731,_7720,_7721,_7815,_7803,_7840),
    {user:_7704=_7729},
    s0(_7729,_7730,_7731,_7718,_7874,_7840,_7897),
    ncomps0(_7718,_7702,_7720,_7721,_7703,_7723,_7918,_7897,_7768).

morenames(_7702,(_7702,_7706),[morenames,_7752,_7781],_7735,_7737) --> 
    unplausible_name(_7711,_7752,_7735,_7769),
    morenames(_7711,_7706,_7781,_7769,_7737).

morenames(_7702,_7702,[morenames,[]],_7724,_7724) --> 
    [].

unplausible_name(_7702,[unplausible_name,_7747,!,_7781],_7733,_7735) --> 
    w(name(_7702,unknown,_7714),_7747,_7733,_7764),
    !,
    accept(_7781,_7764,_7735).

ncomps0(gen,_7703,_7704,_7705,_7706,0,[ncomps0,_7785,_7814,{}],_7756,_7758) --> 
    preadjs0(_7717,_7785,_7756,_7802),
    ncomps(_7703,_7704,_7720,_7706,_7814,_7802,_7758),
    {user:preadjs_template(_7717,_7703,_7705,_7720)}.

ncomps0(n,_7709:_7710,_7709:_7710,_7705,_7705,0,[ncomps0,_7778],_7749,_7751) --> 
    w(noun(_7710,_7718,_7719,n),_7778,_7749,_7751).

ncomps0(n,_7703,_7704,_7705,_7705,name,[ncomps0,{}],_7741,_7741) --> 
    {user:compatvar(_7703,_7704)}.

ncomps(_7702,_7703,_7704,_7705,[ncomps,_7784,{},_7843],_7761,_7763) --> 
    noun2(_7720,_7721,_7713,_7715,_7724,_7784,_7761,_7809),
    {user:has_template(_7703,_7715,_7730)},
    ncomps0(_7713,_7702,_7715,_7704 and _7724 and _7730,_7705,_7718,_7843,_7809,_7763).

s0(_7702,_7703,n,gen,[s0,_7753],_7730,_7732) --> 
    sin(_7753,_7730,_7732).

s0(_7702,_7703,n,gen,[s0,lit(s)],_7732,_7734) --> 
    cc(s,_7732,_7734).

s0(sin,u,n,n,[s0,[]],_7730,_7730) --> 
    [].

s0(sin,def,n,n,[s0,[]],_7730,_7730) --> 
    [].

s0(plu,u,n,n,[s0,[]],_7730,_7730) --> 
    [].

s0(plu,def,n,n,[s0,[]],_7730,_7730) --> 
    [].

s0(_7702,_7703,gen,gen,[s0,[]],_7730,_7730) --> 
    [].

noun_modifiers0(_7702,_7703,_7710::_7708,_7707::_7708,[noun_modifiers0,_7764],_7741,_7743) --> 
    noun_modsx0(_7702,_7703,_7707,_7710,_7764,_7741,_7743).

noun_modsx0(0,_7703,_7704,_7705,[noun_modsx0,_7757],_7734,_7736) --> 
    rel_clauses(_7703,_7704,_7705,_7757,_7734,_7736).

noun_modsx0(0,_7716:_7717,_7704,_7704 and _7719 isa coevent and _7713 and _7714,[noun_modsx0,{},lit(til),lit(at),!,_7859,{},!,_7908],_7799,_7801) --> 
    {user:testmember(_7717,[cause])},
    cc(til,_7799,_7842),
    cc(at,_7842,_7853),
    !,
    clausal_object1(_7719:coevent,true::_7714,_7859,_7853,_7878),
    {user:noun_compl(to,_7716:_7717,_7719:coevent,_7713)},
    !,
    accept(_7908,_7878,_7801).

noun_modsx0(0,_7716:_7717,_7704,_7704 and _7719 isa coevent and _7713 and _7714,[noun_modsx0,{},lit(for),lit(å),!,_7864,{},!,_7922],_7804,_7806) --> 
    {user:testmember(_7717,[way])},
    cc(for,_7804,_7847),
    cc(å,_7847,_7858),
    !,
    pushstack(first,[noen],nil,_7858,_7877),clausal_object1(_7719:coevent,true::_7714,_7864,_7877,_7892),
    {user:noun_compl(regarding,_7716:_7717,_7719:coevent,_7713)},
    !,
    accept(_7922,_7892,_7806).

noun_modsx0(0,_7716:_7717,_7704,_7704 and _7719 isa coevent and _7713 and _7714,[noun_modsx0,{},lit(for),lit(hvordan),!,_7859,{},!,_7908],_7799,_7801) --> 
    {user:testmember(_7717,[way])},
    cc(for,_7799,_7842),
    cc(hvordan,_7842,_7853),
    !,
    clausal_object1(_7719:coevent,true::_7714,_7859,_7853,_7878),
    {user:noun_compl(regarding,_7716:_7717,_7719:coevent,_7713)},
    !,
    accept(_7908,_7878,_7801).

noun_modsx0(0,_7716:_7717,_7704,_7704 and _7719 isa coevent and _7713 and _7714,[noun_modsx0,{},lit(om),lit(hvor),_7870,!,_7904,{},!,_7962],_7815,_7817) --> 
    {user:testmember(_7717,[question])},
    cc(om,_7815,_7858),
    cc(hvor,_7858,_7869),
    w(adj2(_7759,nil),_7870,_7869,_7887),
    !,
    pushstack(free,w(adj2(_7759,nil)),nil,_7887,_7917),clausal_object1(_7719:coevent,true::_7714,_7904,_7917,_7932),
    {user:noun_compl(regarding,_7716:_7717,_7719:coevent,_7713)},
    !,
    accept(_7962,_7932,_7817).

noun_modsx0(0,_7716:_7717,_7704,_7704 and _7719 isa coevent and _7713 and _7714,[noun_modsx0,{},lit(der),!,_7843,{},!,_7892],_7794,_7796) --> 
    {user:testmember(_7717,[example])},
    cc(der,_7794,_7837),
    !,
    clausal_object1(_7719:coevent,true::_7714,_7843,_7837,_7862),
    {user:noun_compl(on,_7716:_7717,_7719:coevent,_7713)},
    !,
    accept(_7892,_7862,_7796).

noun_modsx0(0,_7716:_7717,_7704,_7704 and _7719 isa coevent and _7713 and _7714,[noun_modsx0,{},_7840,lit(å),!,_7900,{},!,_8014],_7807,_7809) --> 
    {user:testmember(_7717,[cause])},
    optional([for],_7840,_7807,_7872),
    cc(å,_7872,_7894),
    !,
    pushstack(first,(someone,aux1),nil,_7894,_7969),clausal_object1(_7719:coevent,true::_7714,_7900,_7969,_7984),
    {user:noun_compl(for,_7716:_7717,_7719:coevent,_7713)},
    !,
    accept(_8014,_7984,_7809).

noun_modsx0(0,_7716:_7717,_7704,_7704 and _7719 isa coevent and _7713 and _7714,[noun_modsx0,{},_7842,lit(å),!,_7902,{},!,_8016],_7809,_7811) --> 
    {user:testmember(_7717,[permission,possibility])},
    optional([til],_7842,_7809,_7874),
    cc(å,_7874,_7896),
    !,
    pushstack(first,(someone,aux1),nil,_7896,_7971),clausal_object1(_7719:coevent,true::_7714,_7902,_7971,_7986),
    {user:noun_compl(to,_7716:_7717,_7719:coevent,_7713)},
    !,
    accept(_8016,_7986,_7811).

noun_modsx0(0,_7716:_7717,_7704,_7704 and _7719 isa coevent and _7713 and _7714,[noun_modsx0,{},lit(om),lit(å),!,_7871,{},!,_7985],_7811,_7813) --> 
    {user:testmember(_7717,[notification,request,plan,wish])},
    cc(om,_7811,_7854),
    cc(å,_7854,_7865),
    !,
    pushstack(first,(someone,aux1),nil,_7865,_7940),clausal_object1(_7719:coevent,true::_7714,_7871,_7940,_7955),
    {user:noun_compl(about,_7716:_7717,_7719:coevent,_7713)},
    !,
    accept(_7985,_7955,_7813).

noun_modsx0(0,_7716:_7717,_7704,_7704 and _7719 isa coevent and _7713 and _7714,[noun_modsx0,{},_7835,lit(at),!,_7880,{},!,_7929],_7802,_7804) --> 
    {user:constrain(_7716:_7717,connection)},
    w(prep(with),_7835,_7802,_7852),
    cc(at,_7852,_7874),
    !,
    clausal_object1(_7719:coevent,true::_7714,_7880,_7874,_7899),
    {user:noun_compl(with,_7716:_7717,_7719:coevent,_7713)},
    !,
    accept(_7929,_7899,_7804).

noun_modsx0(0,_7703,_7704,_7704 and _7708,[noun_modsx0,{},_7836,_7860,_7904,_7938,!,_7977],_7803,_7805) --> 
    {user:constrain(_7703,way)},
    in_order_tox(_7836,_7803,_7851),
    lexv(tv,_7751,inf,fin,_7860,_7851,_7883),
    np1(_7755,_7758::_7759,_7904,_7883,_7923),
    fictitiousprep(way,_7762,_7938,_7923,_7957),
    !,
    pushstack(first,(someone,w(verb(_7751,pres,fin)),np1(_7755,_7758::_7759),prep(_7762),npgap(_7703)),nil,_7957,_8109),
    statreal(_7708,_7977,_8109,_7805).

noun_modsx0(0,_7703,_7704,_7704 and _7708,[noun_modsx0,{},_7818,_7842,_7886,!,_7925],_7785,_7787) --> 
    {user:constrain(_7703,way)},
    in_order_tox(_7818,_7785,_7833),
    lexv(iv,_7745,inf,fin,_7842,_7833,_7865),
    fictitiousprep(way,_7750,_7886,_7865,_7905),
    !,
    pushstack(first,(someone,w(verb(_7745,pres,fin)),prep(_7750),npgap(_7703)),nil,_7905,_8023),
    statreal(_7708,_7925,_8023,_7787).

noun_modsx0(_7702,_7703,_7704,_7704,[noun_modsx0,_7763,!,_7797],_7740,_7742) --> 
    look_ahead([den],_7763,_7740,_7780),
    !,
    accept(_7797,_7780,_7742).

noun_modsx0(_7702,_7703,_7704,_7704,[noun_modsx0,{},_7789,!,_7823],_7756,_7758) --> 
    {user:(vartypeid(_7703,_7721),subclass(_7721,daypart))},
    not_look_ahead(w(prep(_7731)),_7789,_7756,_7806),
    !,
    accept(_7823,_7806,_7758).

noun_modsx0(_7702,_7703,_7704,_7705,[noun_modsx0,_7761,!],_7738,_7740) --> 
    noun_mods(_7702,_7703,_7704,_7705,_7761,_7738,_7740),
    !.

noun_modsx0(_7702,_7703,_7704,_7704,[noun_modsx0,[]],_7730,_7730) --> 
    [].

fictitiousprep(way,in,[fictitiousprep,[]],_7724,_7724) --> 
    [].

fictitiousprep(abstract,with,[fictitiousprep,[]],_7724,_7724) --> 
    [].

noun_mods(0,_7703,_7704,_7704 and _7708,[noun_mods,{},_7906,{},_7945,_7974,_8003,_8032,_8061,_8090,_8119,_8148],_7873,_7875) --> 
    {user:(vartypeid(_7703,_7757),testmember(_7757,[address,email,mind,mailaddress,telephone,webaddress]))},
    prep1(to,_7906,_7873,_7923),
    {user:(vartypeid(_7703,_7784),\+testmember(_7784,[name]))},
    not_look_ahead(w(nb(_7796,_7797)),_7945,_7923,_7962),
    not_look_ahead(w(prep(_7803)),_7974,_7962,_7991),
    not_look_ahead_lit([deg,meg,seg],_8003,_7991,_8020),
    not_look_ahead(w(noun(station,_7818,_7819,_7820)),_8032,_8020,_8049),
    not_look_ahead(w(name(_7826,_7827,station)),_8061,_8049,_8078),
    not_look_ahead(w(name(_7834,_7835,neighbourhood)),_8090,_8078,_8107),
    not_look_ahead(w(name(_7842,_7843,city)),_8119,_8107,_8136),
    pushstack(first,(npgap(_7703),w(verb(evah,pres,fin))),nil,_8136,_8188),
    statreal(_7708,_8148,_8188,_7875).

noun_mods(0,_7703,_7704,_7704 and _7708,[noun_mods,{},_7817,{},{},_7866],_7784,_7786) --> 
    {user:value(teleflag,true)},
    not_look_ahead(w(prep(_7743)),_7817,_7784,_7834),
    {user:vartypeid(_7703,_7748)},
    {user:(\+vartypid(_7748,[]))},
    pushstack(first,(npgap(_7703),w(verb(evah,pres,fin))),nil,_7834,_7906),
    statreal(_7708,_7866,_7906,_7786).

noun_mods(0,_7703,_7704,_7705,[noun_mods,_7771,!,_7815,_7839],_7748,_7750) --> 
    noun_mod(_7703,_7704,_7718,_7771,_7748,_7792),
    !,
    accept(_7815,_7792,_7830),
    noun_modsx0(0,_7703,_7718,_7705,_7839,_7830,_7750).

noun_mods(name,_7703,_7704,_7705,[noun_mods,{},_7816,{},_7855,!,_7899,_7923],_7783,_7785) --> 
    {user:(vartypeid(_7703,_7735),subclass0(_7735,vehicle))},
    look_ahead(w(prep(_7745)),_7816,_7783,_7833),
    {user:testmember(_7745,[to,from])},
    noun_mod(_7703,_7704,_7727,_7855,_7833,_7876),
    !,
    accept(_7899,_7876,_7914),
    noun_mods(name,_7703,_7727,_7705,_7923,_7914,_7785).

noun_mods(name,_7703,_7704,_7705,[noun_mods,_7806,{},{},_7855,!,_7899,_7923],_7783,_7785) --> 
    look_ahead(w(prep(_7734)),_7806,_7783,_7823),
    {user:testmember(_7734,[on,towards])},
    {user:(vartypeid(_7703,_7750),subclass0(_7750,place))},
    noun_mod(_7703,_7704,_7727,_7855,_7823,_7876),
    !,
    accept(_7899,_7876,_7914),
    noun_mods(name,_7703,_7727,_7705,_7923,_7914,_7785).

noun_mods(name,_7703,_7704,_7705,[noun_mods,{},_7789,_7828],_7756,_7758) --> 
    {user:(value(textflag,true);value(teleflag,true))},
    noun_mod(_7703,_7704,_7715,_7789,_7756,_7810),
    noun_mods(name,_7703,_7715,_7705,_7828,_7810,_7758).

noun_mods(name,_7703,_7704,_7704 and _7708,[noun_mods,{},{},_7833,{},_7872],_7790,_7792) --> 
    {user:value(teleflag,true)},
    {user:constrain(_7703,person)},
    w(name(_7730,n,_7732),_7833,_7790,_7850),
    {user:subclass0(_7732,place)},
    pushstack(first,(prep1(in),w(name(_7730,n,_7732))),nil,_7850,_7912),
    noun_mod(_7703,_7704,_7708,_7872,_7912,_7792).

noun_mod(_7712:_7713,_7703,nrel/nil/day/clock/_7712/_7716 and _7703 and _7710,[noun_mod,{},_7801,_7825],_7771,_7773) --> 
    {user:constrain(_7712:_7713,day)},
    clock(_7801,_7771,_7816),
    clock_sequel(_7716:_7748,_7710,_7825,_7816,_7773).

noun_mod(_7702,_7703,_7703 and _7707,[noun_mod,_7767,{},!],_7747,_7749) --> 
    adverb(_7715,_7716,_7717,_7767,_7747,_7749),
    {user:noun_adverb(_7702,_7715,_7716,_7707)},
    !.

noun_mod(_7712:_7713,_7703,_7703 and _7709 and _7710,[noun_mod,lit(for),lit(å),_7835,!,_7874,{},!,_7932],_7793,_7795) --> 
    cc(for,_7793,_7823),
    cc(å,_7823,_7834),
    gmem(_7713,[condition],_7835,_7834,_7854),
    !,
    pushstack(first,[noen],nil,_7854,_7887),clausal_object1(_7756:coevent,true::_7710,_7874,_7887,_7902),
    {user:noun_compl(for,_7712:_7713,_7756:coevent,_7709)},
    !,
    accept(_7932,_7902,_7795).

noun_mod(_7712:_7713,_7703,_7703 and _7709 and _7710,[noun_mod,lit(om),lit(at),{},!,_7861,{},{},!,_7920],_7804,_7806) --> 
    cc(om,_7804,_7834),
    cc(at,_7834,_7845),
    {user:testmember(_7713,[information,message,notification,question])},
    !,
    clausal_object1(_7762:coevent,_7759::_7710,_7861,_7845,_7880),
    {user:_7759=true},
    {user:noun_compl(regarding,_7712:_7713,_7762:coevent,_7709)},
    !,
    accept(_7920,_7880,_7806).

noun_mod(_7702,_7703,_7703 and _7707,[noun_mod,_7776,_7805],_7756,_7758) --> 
    posspron(_7723,_7776,_7756,_7793),
    lock(exact,_7793,_7882),
    pushstack(exact,(pronoun(_7723),w(verb(have,pres,fin)),npgap(_7702)),nil,_7882,_7888),
    statreal(_7707,_7805,_7888,_7877),
    unlock(_7877,_7758).

noun_mod(_7702,_7703,_7703 and _7707,[noun_mod,_7764,_7793],_7744,_7746) --> 
    look_ahead(w(adj(_7720,comp)),_7764,_7744,_7781),
    comparison(_7702,_7713,_7707,_7793,_7781,_7746).

noun_mod(_7702,_7703,_7703 and _7707,[noun_mod,_7797,{},_7836,{},!,_7890,{}],_7777,_7779) --> 
    negation0(_7729,_7797,_7777,_7814),
    {user:(\+vartypeid(_7702,self))},
    adjunct1(_7742,_7743,_7731::_7707,_7836,_7814,_7857),
    {user:noun_compl(_7742,_7702,_7743,_7730)},
    !,
    accept(_7890,_7857,_7779),
    {user:negate(_7729,_7730,_7731)}.

noun_mod(_7706:_7707,_7703,_7703,[noun_mod,{},_7784,_7808,{}],_7754,_7756) --> 
    {user:constrain(_7706:_7707,vehicle)},
    numberroute(_7784,_7754,_7799),
    num_na(_7720,_7808,_7799,_7756),
    {user:_7720=_7706}.

noun_mod(_7702,_7703,_7703 and _7707,[noun_mod,_7787,_7816,{},!,_7887],_7767,_7769) --> 
    day(_7721,_7787,_7767,_7804),
    lock(exact,_7804,_7836),pushstack(exact,w(noun(_7721,sin,u,n)),nil,_7836,_7842),np1(_7733,_7736::_7707,_7816,_7842,_7831),unlock(_7831,_7832),
    {user:noun_compl(nil,_7702,_7733,_7736)},
    !,
    accept(_7887,_7832,_7769).

noun_mod(_7702,_7703,_7703 and _7707,[noun_mod,_7792,_7821,{},!,_7879],_7772,_7774) --> 
    w(noun(midnight,_7724,_7725,n),_7792,_7772,_7809),
    pushstack(first,w(noun(midnight,sin,u,n)),nil,_7809,_7834),np1(_7738,_7741::_7707,_7821,_7834,_7849),
    {user:noun_compl(nil,_7702,_7738,_7741)},
    !,
    accept(_7879,_7849,_7774).

noun_mod(_7702,_7703,_7703 and _7707,[noun_mod,_7772,{},!,_7821],_7752,_7754) --> 
    obviousdate(_7718,_7721::_7707,_7772,_7752,_7791),
    {user:noun_compl(nil,_7702,_7718,_7721)},
    !,
    accept(_7821,_7791,_7754).

noun_mod(_7702,_7703,_7703 and _7707,[noun_mod,_7772,{},!,_7821],_7752,_7754) --> 
    obviousclock(_7718,_7721::_7707,_7772,_7752,_7791),
    {user:noun_compl(nil,_7702,_7718,_7721)},
    !,
    accept(_7821,_7791,_7754).

noun_mod(_7702,_7703,_7704,[noun_mod,_7789,_7818,!,_7857,!,_7941],_7769,_7771) --> 
    w(noun(direction,_7724,_7725,_7726),_7789,_7769,_7806),
    nameq1(_7728,_7729,_7818,_7806,_7837),
    !,
    pushstack(first,(w(prep(towards)),nameq1(_7728,_7729)),nil,_7837,_7901),noun_mod(_7702,_7703,_7704,_7857,_7901,_7918),
    !,
    accept(_7941,_7918,_7771).

noun_mod(_7709:_7710,_7703,_7703 and _7707,[noun_mod,{},_7799,{},!,_7848],_7769,_7771) --> 
    {user:test(n_compl(nil,_7710,_7730))},
    np1_accept(_7732,_7735::_7707,_7799,_7769,_7818),
    {user:noun_compl(nil,_7709:_7710,_7732,_7735)},
    !,
    accept(_7848,_7818,_7771).

begin([begin,[]],_7717,_7717) --> 
    [].

end([end,[]],_7717,_7717) --> 
    [].

accept([accept,[]],_7717,_7717) --> 
    [].

reject([reject,{}],_7719,_7719) --> 
    {user:fail}.

look_ahead_place([look_ahead_place,_7746,{}],_7735,_7737) --> 
    look_ahead(w(name(_7716,_7717,_7709)),_7746,_7735,_7737),
    {user:test(subclass0(_7709,place))}.

look_ahead_conjuction([look_ahead_conjuction,_7732],_7721,_7723) --> 
    look_ahead([før],_7732,_7721,_7723).

look_ahead_conjuction([look_ahead_conjuction,_7732],_7721,_7723) --> 
    look_ahead([etter],_7732,_7721,_7723).

look_ahead_conjuction([look_ahead_conjuction,_7732],_7721,_7723) --> 
    look_ahead([når],_7732,_7721,_7723).

not_look_ahead_flnp([not_look_ahead_flnp,_7757,{},!,_7801],_7746,_7748) --> 
    look_ahead(w(adj2(_7715,nil)),_7757,_7746,_7774),
    {user:testmember(_7715,[first,last,next,previous])},
    !,
    reject(_7801,_7774,_7748).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_7717,_7717) --> 
    [].

not_look_ahead_flnp([not_look_ahead_flnp,_7757,{},!,_7801],_7746,_7748) --> 
    look_ahead(w(adj2(_7715,nil)),_7757,_7746,_7774),
    {user:testmember(_7715,[first,last,next,previous])},
    !,
    reject(_7801,_7774,_7748).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_7717,_7717) --> 
    [].

not_look_ahead_vehicle([not_look_ahead_vehicle,_7753,{},!,_7797],_7742,_7744) --> 
    look_ahead(w(noun(_7715,_7716,_7717,_7718)),_7753,_7742,_7770),
    {user:test(subclass0(_7715,vehicle))},
    !,
    reject(_7797,_7770,_7744).

not_look_ahead_vehicle([not_look_ahead_vehicle,_7755,{},!,_7799],_7744,_7746) --> 
    look_ahead(w(noun(_7715,_7716,_7717,_7718)),_7755,_7744,_7772),
    {user:testmember(_7715,[departure,arrival])},
    !,
    reject(_7799,_7772,_7746).

not_look_ahead_vehicle([not_look_ahead_vehicle,[]],_7717,_7717) --> 
    [].

not_look_ahead_day([not_look_ahead_day,_7751,{},!,_7795],_7740,_7742) --> 
    look_ahead(w(noun(_7715,_7716,_7717,_7718)),_7751,_7740,_7768),
    {user:_7715 ako day},
    !,
    reject(_7795,_7768,_7742).

not_look_ahead_day([not_look_ahead_day,[]],_7717,_7717) --> 
    [].

not_look_ahead_noun([not_look_ahead_noun,_7737],_7726,_7728) --> 
    not_look_ahead(w(noun(_7706,_7707,_7708,_7709)),_7737,_7726,_7728).

look_ahead_timeclause([look_ahead_timeclause,_7737],_7726,_7728) --> 
    look_ahead(w(noun(clock,_7707,_7708,_7709)),_7737,_7726,_7728).

look_ahead_timeclause([look_ahead_timeclause,_7745,{}],_7734,_7736) --> 
    look_ahead(w(noun(_7707,sin,u,n)),_7745,_7734,_7736),
    {user:subclass(_7707,day)}.

look_ahead_clock([look_ahead_clock,_7734],_7723,_7725) --> 
    look_ahead_lit([kl,klokken],_7734,_7723,_7725).

look_ahead_clock([look_ahead_clock,_7737],_7726,_7728) --> 
    look_ahead(w(noun(clock,sin,def,n)),_7737,_7726,_7728).

look_ahead_clock([look_ahead_clock,_7735],_7724,_7726) --> 
    look_ahead(w(nb(_7706,_7707)),_7735,_7724,_7726).

not_look_ahead_vp([not_look_ahead_vp,_7734,!,_7763],_7723,_7725) --> 
    look_ahead_vp(_7734,_7723,_7749),
    !,
    reject(_7763,_7749,_7725).

not_look_ahead_vp([not_look_ahead_vp,[]],_7717,_7717) --> 
    [].

look_ahead_vp([look_ahead_vp,_7736],_7725,_7727) --> 
    look_ahead(w(verb(_7706,_7707,_7708)),_7736,_7725,_7727).

look_ahead_vp([look_ahead_vp,_7732],_7721,_7723) --> 
    look_ahead([ikke],_7732,_7721,_7723).

look_ahead_vp([look_ahead_vp,_7728],_7717,_7719) --> 
    look_ahead_aux(_7728,_7717,_7719).

look_ahead_aux([look_ahead_aux,_7750],_7739,_7741) --> 
    look_ahead_lit([vil,skal,bør,må,kan,ville,skulle,burde,måtte,kunne],_7750,_7739,_7741).

not_look_ahead_lit(_7702,[not_look_ahead_lit,_7743,!,_7777],_7729,_7731) --> 
    look_ahead_lit(_7702,_7743,_7729,_7760),
    !,
    reject(_7777,_7760,_7731).

not_look_ahead_lit(_7702,[not_look_ahead_lit,[]],_7721,_7721) --> 
    [].

look_ahead_lit(_7702,[look_ahead_lit,_7750,{},!],_7736,_7738) --> 
    look_ahead([_7711],_7750,_7736,_7738),
    {user:testmember(_7711,_7702)},
    !.

lit_of(_7702,_7703,[lit_of,lit(_7702),{},!],_7737,_7739) --> 
    cc(_7702,_7737,_7739),
    {user:member(_7702,_7703)},
    !.

one_of_lit(_7702,[one_of_lit,lit(_7709),{},!],_7734,_7736) --> 
    cc(_7709,_7734,_7736),
    {user:member(_7709,_7702)},
    !.

not_one_of_lit(_7702,[not_one_of_lit,_7743,!,_7777],_7729,_7731) --> 
    one_of_lit(_7702,_7743,_7729,_7760),
    !,
    reject(_7777,_7760,_7731).

not_one_of_lit(_7702,[not_one_of_lit,[]],_7721,_7721) --> 
    [].

not_look_ahead_number([not_look_ahead_number,lit(ett),!],_7722,_7724) --> 
    cc(ett,_7722,_7724),
    !.

not_look_ahead_number([not_look_ahead_number,_7739,!,_7773],_7728,_7730) --> 
    w(nb(_7710,_7711),_7739,_7728,_7756),
    !,
    fail(_7773,_7756,_7730).

not_look_ahead_number([not_look_ahead_number,[]],_7717,_7717) --> 
    [].

not_look_ahead_np([not_look_ahead_np,_7753,_7782,!],_7742,_7744) --> 
    look_ahead(w(adv(_7712)),_7753,_7742,_7770),
    gmem(_7712,[klokken,kloka,kl,directly,correctly],_7782,_7770,_7744),
    !.

not_look_ahead_np([not_look_ahead_np,_7734,!,_7763],_7723,_7725) --> 
    look_ahead_np(_7734,_7723,_7749),
    !,
    reject(_7763,_7749,_7725).

not_look_ahead_np([not_look_ahead_np,[]],_7717,_7717) --> 
    [].

look_ahead_np([look_ahead_np,_7796],_7785,_7787) --> 
    look_ahead_lit([den,det,de,denne,dere,dette,disse,du,en,et,ei,han,hun,jeg,noe,noen,vi,meg,deg,seg,min,mine,din,dine,hans,hennes,seg,vår,våre,deres,mange,noen,noe],_7796,_7785,_7787).

look_ahead_np([look_ahead_np,_7745,{}],_7734,_7736) --> 
    look_ahead(w(adj2(_7709,_7717)),_7745,_7734,_7736),
    {user:(\+testmember(_7709,[]))}.

look_ahead_np([look_ahead_np,_7737],_7726,_7728) --> 
    look_ahead(w(noun(_7706,_7707,_7708,_7709)),_7737,_7726,_7728).

look_ahead_np([look_ahead_np,_7735],_7724,_7726) --> 
    look_ahead(w(nb(_7706,_7707)),_7735,_7724,_7726).

look_ahead_np([look_ahead_np,_7734],_7723,_7725) --> 
    look_ahead_lit([halv,kvart],_7734,_7723,_7725).

look_ahead_np([look_ahead_np,_7746,{}],_7735,_7737) --> 
    look_ahead(w(name(_7709,_7717,_7718)),_7746,_7735,_7737),
    {user:(\+testmember(_7709,[]))}.

look_ahead_subject([look_ahead_subject,lit(_7707),{}],_7737,_7739) --> 
    cc(_7707,_7737,_7739),
    {user:testmember(_7707,[jeg,du,han,hun,vi])}.

look_ahead_pron([look_ahead_pron,_7738],_7727,_7729) --> 
    look_ahead_lit([jeg,vi,du,dere],_7738,_7727,_7729).

not_look_ahead_pron([not_look_ahead_pron,_7736,!,_7770],_7725,_7727) --> 
    posspron(_7708,_7736,_7725,_7753),
    !,
    reject(_7770,_7753,_7727).

not_look_ahead_pron([not_look_ahead_pron,_7738],_7727,_7729) --> 
    not_look_ahead_lit([jeg,du,han,hun],_7738,_7727,_7729).

determiner0(plu,0,_7704,_7705,_7708::quant(approx/_7721,_7704)::_7705 and _7708,[determiner0,lit(mellom),_7816,lit(og),_7856,{}],_7779,_7781) --> 
    cc(mellom,_7779,_7815),
    w(nb(_7721,num),_7816,_7815,_7833),
    cc(og,_7833,_7855),
    w(nb(_7738,num),_7856,_7855,_7781),
    {user:_7721<_7738}.

determiner0(plu,0,_7704,_7705,_7708::quant(eq/_7721,_7704)::_7705 and _7708,[determiner0,_7835,_7859,{},_7898,_7927,!,_7961,[]],_7809,_7811) --> 
    theplu0(_7835,_7809,_7850),
    w(adj2(_7749,nil),_7859,_7850,_7876),
    {user:testmember(_7749,[first,last,next,previous])},
    number(_7721:_7773,_7898,_7876,_7915),
    look_ahead(w(noun(_7779,plu,_7781,_7782)),_7927,_7915,_7944),
    !,
    accept(_7961,_7944,_7976),
    pushstack(free,w(adj2(_7749,nil)),nil,_7976,_7811),
    [].

determiner0(sin,0,_7704,_7705,_7708::_7709,[determiner0,{},_7793,_7817],_7757,_7759) --> 
    {user:value(dialog,1)},
    the(_7793,_7757,_7808),
    pushstack(first,this,nil,_7808,_7855),
    determiner(_7704,_7705,_7708::_7709,_7817,_7855,_7759).

determiner0(_7702,_7703,_7704,_7705,_7706,[determiner0,_7790,_7814,_7843,{},!,_7887],_7764,_7766) --> 
    theplu0(_7790,_7764,_7805),
    number(_7725:_7726,_7814,_7805,_7831),
    w(noun(_7730,_7731,_7732,_7733),_7843,_7831,_7860),
    {user:measureclass(_7730)},
    !,
    reject(_7887,_7860,_7766).

determiner0(plu,0,_7704,_7705,_7708::quant(approx/_7721,_7704)::_7705 and _7708,[determiner0,_7785,!,_7814],_7759,_7761) --> 
    approx(_7785,_7759,_7800),
    !,
    number(_7721:_7732,_7814,_7800,_7761).

approx([approx,lit(ca),!],_7722,_7724) --> 
    cc(ca,_7722,_7724),
    !.

approx([approx,lit(rundt),!],_7722,_7724) --> 
    cc(rundt,_7722,_7724),
    !.

determiner0(plu,0,_7704,_7705,_7708::quant(ge/_7721,_7704)::_7705 and _7708,[determiner0,_7782,_7806],_7756,_7758) --> 
    morethan(_7782,_7756,_7797),
    number(_7721:_7729,_7806,_7797,_7758).

morethan([morethan,lit(minst)],_7719,_7721) --> 
    cc(minst,_7719,_7721).

morethan([morethan,lit(over)],_7719,_7721) --> 
    cc(over,_7719,_7721).

morethan([morethan,lit(mer),lit(enn)],_7724,_7726) --> 
    cc(mer,_7724,_7745),
    cc(enn,_7745,_7726).

determiner0(plu,0,_7704,_7705,_7708::quant(eq/_7721,_7704)::_7705 and _7708,[determiner0,_7794,_7818,_7847],_7768,_7770) --> 
    theplu0(_7794,_7768,_7809),
    number(_7721:_7741,_7818,_7809,_7835),
    not_look_ahead(w(noun(time,_7734,def,n)),_7847,_7835,_7770).

determiner0(sin,0,_7704,_7705,_7708::quant(eq/1,_7704)::_7705 and _7708,[determiner0,_7794,_7823,!],_7768,_7770) --> 
    w(nb(1,num),_7794,_7768,_7811),
    not_look_ahead(w(noun(time,_7739,def,n)),_7823,_7811,_7770),
    !.

determiner0(sin,0,_7704,_7705,_7708::_7709,[determiner0,{},_7793,_7817],_7757,_7759) --> 
    {user:value(dialog,1)},
    the(_7793,_7757,_7808),
    pushstack(first,this,nil,_7808,_7855),
    determiner(_7704,_7705,_7708::_7709,_7817,_7855,_7759).

determiner0(plu,0,_7704,_7705,_7708::_7709,[determiner0,_7783,_7807,_7836],_7757,_7759) --> 
    the(_7783,_7757,_7798),
    not_look_ahead(w(verb(_7728,pres,fin)),_7807,_7798,_7824),
    determiner00(_7704,_7705,_7708::_7709,_7836,_7824,_7759).

determiner0(_7702,0,_7704,_7705,_7708::_7709,[determiner0,_7769],_7743,_7745) --> 
    determiner(_7704,_7705,_7708::_7709,_7769,_7743,_7745).

determiner0(_7702,0,_7704,_7705,_7708::_7709,[determiner0,_7769],_7743,_7745) --> 
    determiner00(_7704,_7705,_7708::_7709,_7769,_7743,_7745).

determiner0(_7702,0,_7704,_7705,_7708::exists(_7704)::_7705 and _7708,[determiner0,_7770],_7744,_7746) --> 
    the0(_7770,_7744,_7746).

determiner00(_7712:_7713,_7703,_7706::_7703 and _7706,[determiner00,_7764,!],_7744,_7746) --> 
    the(_7712:_7713,_7764,_7744,_7746),
    !.

determiner00(_7702,_7703,_7706::exists(_7702)::_7703 and _7706,[determiner00,[]],_7738,_7738) --> 
    [].

determiner(_7702,_7703,_7706::forall(_7702)::_7703=>_7706,[determiner,lit(alle),_7774],_7743,_7745) --> 
    cc(alle,_7743,_7773),
    look_ahead_np(_7774,_7773,_7745).

determiner(_7702,_7703,_7706::forall(_7702)::_7703=>_7706,[determiner,lit(hver)],_7740,_7742) --> 
    cc(hver,_7740,_7742).

determiner(_7702,_7703,_7706::find(_7702)::_7703 and _7706,[determiner,_7761,_7785],_7741,_7743) --> 
    this(_7761,_7741,_7776),
    look_ahead_np(_7785,_7776,_7743).

determiner(_7702,_7703,_7706::_7703 and _7706,[determiner,_7755],_7735,_7737) --> 
    the(_7702,_7755,_7735,_7737).

determiner(_7702,_7703,_7706::exists(_7702)::_7703 and _7706,[determiner,_7779,_7803,_7827,_7856,!],_7759,_7761) --> 
    only0(_7779,_7759,_7794),
    art(_7803,_7794,_7818),
    look_ahead(w(noun(_7733,sin,u,n)),_7827,_7818,_7844),
    off0(_7856,_7844,_7761),
    !.

determiner(_7702,_7703,_7706::exists(_7702)::_7703 and _7706,[determiner,_7764,_7788,_7812],_7744,_7746) --> 
    only0(_7764,_7744,_7779),
    art(_7788,_7779,_7803),
    off0(_7812,_7803,_7746).

determiner(_7702,_7703,_7706::forall(_7702)::_7703=>_7706,[determiner,_7761,_7785],_7741,_7743) --> 
    every(_7761,_7741,_7776),
    look_ahead_np(_7785,_7776,_7743).

determiner(_7702,_7703,_7706::not (exists(_7702)::_7703 and _7706),[determiner,_7763,_7787],_7743,_7745) --> 
    no(_7763,_7743,_7778),
    look_ahead_np(_7787,_7778,_7745).

determiner(_7702,_7703,_7706::exists(_7702)::_7703 and not _7706,[determiner,_7763,_7787],_7743,_7745) --> 
    notall(_7763,_7743,_7778),
    look_ahead_np(_7787,_7778,_7745).

determiner(_7702,_7703,_7706::quant(all,_7702)::_7703 and _7706,[determiner,lit(hele)],_7741,_7743) --> 
    cc(hele,_7741,_7743).

determiner(_7702,_7703,_7706::_7707,[determiner,_7757],_7737,_7739) --> 
    quantifier(_7702,_7703,_7706::_7707,_7757,_7737,_7739).

quantifier(_7702,_7703,_7706::quant(eq/_7719,_7702)::_7703 and _7706,[quantifier,lit(bare),_7783],_7752,_7754) --> 
    cc(bare,_7752,_7782),
    w(nb(_7719,_7727),_7783,_7782,_7754).

quantifier(_7702,_7703,_7706::quant(few,_7702)::_7703 and _7706,[quantifier,_7765,_7789,_7813],_7745,_7747) --> 
    aso0(_7765,_7745,_7780),
    few(_7789,_7780,_7804),
    look_ahead_np(_7813,_7804,_7747).

quantifier(_7702,_7703,_7706::quant(most,_7702)::_7703 and _7706,[quantifier,lit(de),lit(fleste),_7791],_7749,_7751) --> 
    cc(de,_7749,_7779),
    cc(fleste,_7779,_7790),
    look_ahead_np(_7791,_7790,_7751).

quantifier(_7702,_7703,_7706::quant(much,_7702)::_7703 and _7706,[quantifier,_7769,_7793],_7749,_7751) --> 
    much(_7769,_7749,_7784),
    not_look_ahead(w(adj2(_7725,nil)),_7793,_7784,_7751).

quantifier(_7702,_7703,_7706::quant(little,_7702)::_7703 and _7706,[quantifier,_7769,_7793],_7749,_7751) --> 
    little(_7769,_7749,_7784),
    not_look_ahead(w(adj2(_7725,nil)),_7793,_7784,_7751).

quantifier(_7702,_7703,_7706::quant(many,_7702)::_7703 and _7706,[quantifier,_7765,_7789,_7813],_7745,_7747) --> 
    aso0(_7765,_7745,_7780),
    many(_7789,_7780,_7804),
    look_ahead_np(_7813,_7804,_7747).

quantifier(_7702,_7703,_7706::quant(most,_7702)::_7703 and _7706,[quantifier,_7765,_7789,_7813],_7745,_7747) --> 
    aso0(_7765,_7745,_7780),
    most(_7789,_7780,_7804),
    look_ahead_np(_7813,_7804,_7747).

quantifier(_7702,_7703,_7706::quant(all,_7702)::_7703 and _7706,[quantifier,lit(alle),_7775],_7744,_7746) --> 
    cc(alle,_7744,_7774),
    look_ahead_np(_7775,_7774,_7746).

quantifier(_7702,_7703,_7706::quant(ge/2,_7702)::_7703 and _7706,[quantifier,_7765,_7789],_7745,_7747) --> 
    several(_7765,_7745,_7780),
    look_ahead_np(_7789,_7780,_7747).

quantifier(_7702,_7703,_7706::quant(count,_7702)::_7703 and _7706,[quantifier,_7776,_7805,_7849],_7756,_7758) --> 
    w(noun(count,_7727,_7728,_7729),_7776,_7756,_7793),
    optional([av],_7805,_7793,_7837),
    look_ahead_np(_7849,_7837,_7758).

few([few,lit(få)],_7719,_7721) --> 
    cc(få,_7719,_7721).

few([few,lit(færre)],_7719,_7721) --> 
    cc(færre,_7719,_7721).

plausible_name(_7706:person,_7706 isa person,_7704,[plausible_name,_7781,_7820,{},!,_7874],_7761,_7763) --> 
    properfirstname(_7724,_7725,_7726,_7781,_7761,_7802),
    properlastname(_7728,_7729,_7704,_7820,_7802,_7841),
    {user:_7706=(_7724,_7728)},
    !,
    accept(_7874,_7841,_7763).

plausible_name(_7706:_7707,_7706 isa _7707,_7704,[plausible_name,_7777,{}],_7757,_7759) --> 
    w(name(_7706,_7704,_7707),_7777,_7757,_7759),
    {user:(\+_7707=0,\+_7707=date)}.

name_compound(_7702,_7703,_7704,[name_compound,_7793,_7822,_7851,_7880,_7919,_7963],_7773,_7775) --> 
    not_look_ahead([dere],_7793,_7773,_7810),
    not_look_ahead([du],_7822,_7810,_7839),
    not_look_ahead(w(nb(_7740,_7741)),_7851,_7839,_7868),
    plausible_name(_7723,_7724,_7745,_7880,_7868,_7901),
    s0(sin,u,_7745,_7721,_7919,_7901,_7942),
    ncomps0(_7721,_7703,_7723,_7724,_7704,_7702,_7963,_7942,_7775).

namep(name,_7706:street,_7706 isa street,[namep,_7796,_7825,_7849,_7878,{},!,_7922],_7776,_7778) --> 
    w(name(_7706,n,street),_7796,_7776,_7813),
    comma0(_7825,_7813,_7840),
    postcode(_7736,_7849,_7840,_7866),
    w(name(_7740,n,_7742),_7878,_7866,_7895),
    {user:testmember(_7742,[neighbourhood,city,station])},
    !,
    accept(_7922,_7895,_7778).

namep(_7702,_7703,_7704,[namep,_7793,_7822,_7851,_7880,_7919,_7963],_7773,_7775) --> 
    not_look_ahead([dere],_7793,_7773,_7810),
    not_look_ahead([du],_7822,_7810,_7839),
    not_look_ahead(w(nb(_7740,_7741)),_7851,_7839,_7868),
    plausible_name(_7723,_7724,_7745,_7880,_7868,_7901),
    s0(sin,u,_7745,_7721,_7919,_7901,_7942),
    ncomps0(_7721,_7703,_7723,_7724,_7704,_7702,_7963,_7942,_7775).

namep(name,_7706:thing,_7706 isa unkn,[namep,{},_7779,_7808],_7749,_7751) --> 
    {user:value(unknownflag,true)},
    unplausible_name(_7718,_7779,_7749,_7796),
    morenames(_7718,_7706,_7808,_7796,_7751).

namep(0,_7703,_7704,[namep,_7750],_7730,_7732) --> 
    measure(_7703,_7704,_7750,_7730,_7732).

namep(name,_7703,_7704,[namep,_7762,_7786],_7742,_7744) --> 
    you(_7762,_7742,_7777),
    pushstack(first,w(name(tuc,n,savant)),nil,_7777,_7796),
    nameq(_7703,_7704,_7786,_7796,_7744).

namep(0,_7703,_7704,[namep,_7765,_7794,!,_7853],_7745,_7747) --> 
    number(_7715,_7765,_7745,_7782),
    noun(_7717,plu,_7719,n,_7721,_7722,_7794,_7782,_7821),
    !,
    reject(_7853,_7821,_7747).

namep(0,_7703,_7704,[namep,_7850,_7874,{},_7933,_7962,_7991,_8025,{},{},_8074,_8103,!,_8137],_7830,_7832) --> 
    athe0(_7850,_7830,_7865),
    noun2(_7742,_7743,n,_7748:_7749,_7746,_7874,_7865,_7899),
    {user:(\+testmember(_7749,[thing]))},
    not_look_ahead([jeg],_7933,_7899,_7950),
    not_look_ahead([du],_7962,_7950,_7979),
    nameq(_7768,_7769,_7991,_7979,_8010),
    not_look_ahead([:],_8025,_8010,_8042),
    {user:compoundtest(_7742,_7743,_7748:_7749,_7768)},
    {user:align_noun_name(_7748:_7749,_7768,_7746,_7703,_7704)},
    optional_suffix(_7748:_7749,_8074,_8042,_8091),
    not_look_ahead(w(name(_7805,_7806,date)),_8103,_8091,_8120),
    !,
    accept(_8137,_8120,_7832).

namep(0,_7703,_7704,[namep,_7792,_7816,_7840,_7874,{},!,{}],_7772,_7774) --> 
    athe0(_7792,_7772,_7807),
    nr0(_7816,_7807,_7831),
    nameq1(_7727,_7733,_7840,_7831,_7859),
    noun(_7735,sin,u,n,_7726,_7728,_7874,_7859,_7774),
    {user:testmember(_7735,[bus,tram])},
    !,
    {user:align_noun_name(_7726,_7727,_7728,_7703,_7704)}.

namep(0,_7703,_7704,[namep,_7793,_7817,_7846,_7880,{},{}],_7773,_7775) --> 
    athe0(_7793,_7773,_7808),
    not_look_ahead([_7730],_7817,_7808,_7834),
    nameq1(_7724,_7734,_7846,_7834,_7865),
    noun(_7736,sin,_7738,n,_7723,_7725,_7880,_7865,_7775),
    {user:(\+testmember(_7736,[thing]))},
    {user:align_noun_name(_7723,_7724,_7725,_7703,_7704)}.

namep(name,_7703,_7704,[namep,_7757,_7786],_7737,_7739) --> 
    not_look_ahead([ett],_7757,_7737,_7774),
    nameq(_7703,_7704,_7786,_7774,_7739).

optional_suffix(_7704:_7705,[optional_suffix,_7759,{},!,_7803],_7745,_7747) --> 
    w(noun(_7718,_7719,_7720,n),_7759,_7745,_7776),
    {user:alignable(_7705,_7718)},
    !,
    accept(_7803,_7776,_7747).

optional_suffix(_7704:_7705,[optional_suffix,_7759,{},!,_7803],_7745,_7747) --> 
    w(noun(_7718,_7719,_7720,n),_7759,_7745,_7776),
    {user:alignable(_7705,_7718)},
    !,
    accept(_7803,_7776,_7747).

optional_suffix(_7704:_7705,[optional_suffix,_7738],_7724,_7726) --> 
    point0(_7738,_7724,_7726).

noun2(sin,u,n,_7708:thing,_7708 isa thing,[noun2,lit(_7723),{},_7809],_7762,_7764) --> 
    cc(_7723,_7762,_7798),
    {user:testmember(_7723,[de,disse,dem])},
    look_ahead([som],_7809,_7798,_7764).

noun2(plu,u,n,_7708:thing,_7708 isa thing,[noun2,lit(_7719),{},_7805],_7758,_7760) --> 
    cc(_7719,_7758,_7794),
    {user:testmember(_7719,[de,disse,dem])},
    not_look_ahead_np(_7805,_7794,_7760).

noun2(sin,u,n,_7708:agent,_7708 isa agent,[noun2,_7772,_7796],_7746,_7748) --> 
    agent_pronoun(_7772,_7746,_7787),
    look_ahead([som],_7796,_7787,_7748).

noun2(sin,u,n,_7708:thing,_7708 isa thing,[noun2,lit(det),_7785],_7748,_7750) --> 
    cc(det,_7748,_7784),
    look_ahead([som],_7785,_7784,_7750).

noun2(_7702,_7703,_7704,_7705,_7706,[noun2,_7799,{},_7863,!,_7892],_7773,_7775) --> 
    noun(_7720,_7702,_7703,_7704,_7705,_7706,_7799,_7773,_7826),
    {user:testmember(_7720,[monday,tuesday,wednesday,thursday,friday,saturday,sunday,month])},
    point0(_7863,_7826,_7878),
    !,
    accept(_7892,_7878,_7775).

noun2(_7702,_7703,_7704,_7708:_7709,_7706,[noun2,_7828,_7857,_7886,_7915,_7944,{},!,_7988],_7802,_7804) --> 
    w(noun(_7734,_7735,u,n),_7828,_7802,_7845),
    not_look_ahead(w(noun(number,sin,_7745,n)),_7857,_7845,_7874),
    not_look_ahead([nr],_7886,_7874,_7903),
    not_look_ahead(w(verb(_7756,_7757,_7758)),_7915,_7903,_7932),
    w(noun(_7762,_7702,_7703,_7704),_7944,_7932,_7961),
    {user:adjnoun_template(_7734,_7762,_7708:_7709,_7706)},
    !,
    accept(_7988,_7961,_7804).

noun2(_7702,_7703,_7704,_7705,_7706,[noun2,_7766],_7740,_7742) --> 
    noun(_7708,_7702,_7703,_7704,_7705,_7706,_7766,_7740,_7742).

noun2(sin,u,n,_7708:thing,_7708 isa thing,[noun2,_7775,_7799,!],_7749,_7751) --> 
    someone(_7775,_7749,_7790),
    look_ahead([som],_7799,_7790,_7751),
    !.

agent_pronoun([agent_pronoun,lit(jeg)],_7719,_7721) --> 
    cc(jeg,_7719,_7721).

agent_pronoun([agent_pronoun,lit(du)],_7719,_7721) --> 
    cc(du,_7719,_7721).

agent_pronoun([agent_pronoun,lit(noen)],_7719,_7721) --> 
    cc(noen,_7719,_7721).

agent_pronoun([agent_pronoun,lit(mange)],_7719,_7721) --> 
    cc(mange,_7719,_7721).

agent_pronoun([agent_pronoun,lit(få)],_7719,_7721) --> 
    cc(få,_7719,_7721).

agent_pronoun([agent_pronoun,lit(han)],_7719,_7721) --> 
    cc(han,_7719,_7721).

agent_pronoun([agent_pronoun,lit(ham)],_7719,_7721) --> 
    cc(ham,_7719,_7721).

agent_pronoun([agent_pronoun,lit(hun)],_7719,_7721) --> 
    cc(hun,_7719,_7721).

agent_pronoun([agent_pronoun,lit(henne)],_7719,_7721) --> 
    cc(henne,_7719,_7721).

agent_pronoun([agent_pronoun,lit(dere)],_7719,_7721) --> 
    cc(dere,_7719,_7721).

agent_pronoun([agent_pronoun,lit(alle)],_7719,_7721) --> 
    cc(alle,_7719,_7721).

noun(_7702,_7703,_7704,_7705,_7709:_7702,_7709 isa _7702,[noun,_7778],_7749,_7751) --> 
    w(noun(_7702,_7703,_7704,_7705),_7778,_7749,_7751).

measure(_7702,_7703,[measure,_7785,{},_7849,_7883,_7907,!,{}],_7768,_7770) --> 
    noun(_7731,_7732,_7733,n,_7725,_7727,_7785,_7768,_7812),
    {user:measureclass(_7731)},
    gmem(_7731,[crown],_7849,_7812,_7868),
    point0(_7883,_7868,_7898),
    anumber(_7726,_7907,_7898,_7770),
    !,
    {user:align_measure(_7725,_7726,_7727,_7702,_7703)}.

measure(_7702,_7703,[measure,_7782,_7811,_7835,_7889,_7913,{},{}],_7765,_7767) --> 
    anumber(_7726,_7782,_7765,_7799),
    point0(_7811,_7799,_7826),
    noun(_7733,_7734,_7735,n,_7725,_7727,_7835,_7826,_7862),
    point0(_7889,_7862,_7904),
    not_overon_clock(_7733,_7913,_7904,_7767),
    {user:measureclass(_7733)},
    {user:align_measure(_7725,_7726,_7727,_7702,_7703)}.

not_overon_clock(_7702,[not_overon_clock,{},_7793,{},_7832,!,_7866],_7769,_7771) --> 
    {user:testmember(_7702,[hour,minute,second])},
    prep1(_7730,_7793,_7769,_7810),
    {user:testmember(_7730,[on,before,over,after])},
    look_ahead(w(nb(_7749,_7750)),_7832,_7810,_7849),
    !,
    reject(_7866,_7849,_7771).

not_overon_clock(_7702,[not_overon_clock,[]],_7721,_7721) --> 
    [].

nameq(_7702,_7703,[nameq,_7754,_7788],_7737,_7739) --> 
    nameq1(_7702,_7703,_7754,_7737,_7773),
    not_look_ahead(w(nb(_7712,_7713)),_7788,_7773,_7739).

nameq(_7702,_7703,[nameq,_7754,_7788],_7737,_7739) --> 
    nameq2(_7702,_7703,_7754,_7737,_7773),
    not_look_ahead(w(nb(_7712,_7713)),_7788,_7773,_7739).

name1g(_7706:lastname,_7706 isa lastname,_7704,[name1g,{},_7805,_7834,_7863,!,_7897],_7775,_7777) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7706,_7737,firstname)),_7805,_7775,_7822),
    w(name(_7706,_7704,lastname),_7834,_7822,_7851),
    not_look_ahead(w(name(_7750,_7751,lastname)),_7863,_7851,_7880),
    !,
    accept(_7897,_7880,_7777).

name1g(_7706:firstname,_7706 isa firstname,n,[name1g,{},_7805,_7834,_7863,!,_7897],_7775,_7777) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7706,_7737,lastname)),_7805,_7775,_7822),
    w(name(_7706,n,firstname),_7834,_7822,_7851),
    look_ahead(w(name(_7750,_7751,lastname)),_7863,_7851,_7880),
    !,
    accept(_7897,_7880,_7777).

name1g(_7706:lastname,_7706 isa lastname,_7704,[name1g,{},_7805,_7834,_7863,!,_7897],_7775,_7777) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7706,_7737,firstname)),_7805,_7775,_7822),
    w(name(_7706,_7704,lastname),_7834,_7822,_7851),
    not_look_ahead(w(name(_7750,n,lastname)),_7863,_7851,_7880),
    !,
    accept(_7897,_7880,_7777).

name1g(_7706:firstname,_7706 isa firstname,n,[name1g,{},_7805,_7834,_7863,!,_7897],_7775,_7777) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7706,_7737,lastname)),_7805,_7775,_7822),
    w(name(_7706,n,firstname),_7834,_7822,_7851),
    look_ahead(w(name(_7750,n,lastname)),_7863,_7851,_7880),
    !,
    accept(_7897,_7880,_7777).

name1g(_7706:_7707,_7706 isa _7707,_7704,[name1g,_7760],_7740,_7742) --> 
    wnameg(_7706:_7707,_7704,_7707,_7760,_7740,_7742).

wnameg(_7706:_7704,gen,_7704,[wnameg,_7762,_7791,!],_7742,_7744) --> 
    w(name(_7706,n,_7704),_7762,_7742,_7779),
    sin(_7791,_7779,_7744),
    !.

wnameg(_7706:_7704,gen,_7704,[wnameg,_7762,_7791,!],_7742,_7744) --> 
    w(name(_7706,gen,_7704),_7762,_7742,_7779),
    sin(_7791,_7779,_7744),
    !.

wnameg(_7706:_7704,gen,_7704,[wnameg,_7759,!],_7739,_7741) --> 
    w(name(_7706,gen,_7704),_7759,_7739,_7741),
    !.

wnameg(_7706:_7704,n,_7704,[wnameg,_7756],_7736,_7738) --> 
    w(name(_7706,n,_7704),_7756,_7736,_7738).

nameq1(_7705:lastname,_7705 isa lastname,[nameq1,{},_7799,_7828,_7857,!,_7891],_7772,_7774) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7705,n,firstname)),_7799,_7772,_7816),
    w(name(_7705,n,lastname),_7828,_7816,_7845),
    not_look_ahead(w(name(_7749,n,lastname)),_7857,_7845,_7874),
    !,
    accept(_7891,_7874,_7774).

nameq1(_7705:firstname,_7705 isa firstname,[nameq1,{},_7799,_7828,_7857,!,_7891],_7772,_7774) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7705,n,lastname)),_7799,_7772,_7816),
    w(name(_7705,n,firstname),_7828,_7816,_7845),
    look_ahead(w(name(_7749,n,lastname)),_7857,_7845,_7874),
    !,
    accept(_7891,_7874,_7774).

nameq1(quote(_7711):_7709,quote(_7711)isa thing,[nameq1,_7766,!,{}],_7749,_7751) --> 
    w(quote(_7711),_7766,_7749,_7751),
    !,
    {user:type(thing,_7709)}.

nameq1(_7702,_7703,[nameq1,_7755,_7784,_7808,!,_7837],_7738,_7740) --> 
    number(_7717,_7755,_7738,_7772),
    point0(_7784,_7772,_7799),
    monthnamex(_7808,_7799,_7823),
    !,
    reject(_7837,_7823,_7740).

nameq1(_7702,_7703,[nameq1,_7759,_7788,!,_7822],_7742,_7744) --> 
    number(_7714,_7759,_7742,_7776),
    w(noun(hour,_7719,_7720,_7721),_7788,_7776,_7805),
    !,
    reject(_7822,_7805,_7744).

nameq1(_7702,_7703,[nameq1,_7762,_7791,_7815,!,_7849],_7745,_7747) --> 
    number(_7717,_7762,_7745,_7779),
    point(_7791,_7779,_7806),
    w(noun(_7721,_7722,_7723,_7724),_7815,_7806,_7832),
    !,
    reject(_7849,_7832,_7747).

nameq1(_7702,_7703,[nameq1,_7750,!,_7789],_7733,_7735) --> 
    obviousclock1(_7702,_7703,_7750,_7733,_7769),
    !,
    accept(_7789,_7769,_7735).

nameq1(_7705:_7709,_7705 isa clock,[nameq1,_7763,_7787,!,{}],_7746,_7748) --> 
    clock0(_7763,_7746,_7778),
    time2(_7705,_7787,_7778,_7748),
    !,
    {user:type(clock,_7709)}.

nameq1(_7705:_7709,_7705 isa clock,[nameq1,_7756],_7739,_7741) --> 
    plausibleclock1(_7705:_7709,_7705 isa clock,_7756,_7739,_7741).

nameq1(_7702,_7703,[nameq1,_7744],_7727,_7729) --> 
    date(_7702,_7703,_7744,_7727,_7729).

nameq1(_7705:_7706,_7703,[nameq1,_7760,_7784,!,_7818],_7743,_7745) --> 
    one(_7760,_7743,_7775),
    w(noun(_7719,sin,u,n),_7784,_7775,_7801),
    !,
    reject(_7818,_7801,_7745).

nameq1(_7705:_7709,_7705 isa _7706,[nameq1,_7790,{},{},_7839,!,_7873],_7773,_7775) --> 
    w(name(_7705,_7729,_7706),_7790,_7773,_7807),
    {user:atom(_7705)},
    {user:testmember(_7706,[language,colour])},
    look_ahead(w(noun(_7749,_7750,_7751,_7752)),_7839,_7807,_7856),
    !,
    reject(_7873,_7856,_7775).

nameq1(_7705:_7709,_7705 isa _7706,[nameq1,_7804,_7833,{},{},{},{}],_7787,_7789) --> 
    not_look_ahead(w(name,_7734,gen,_7736),_7804,_7787,_7821),
    w(name(_7705,_7741,_7706),_7833,_7821,_7789),
    {user:_7705\==1},
    {user:(_7706==unkn->value(unknownflag,true);true)},
    {user:_7741\==gen},
    {user:type(_7706,_7709)}.

nameq1(_7705:_7709,_7705 isa _7706,[nameq1,_7799,_7823,_7852,_7876,{},{},{}],_7782,_7784) --> 
    nr0(_7799,_7782,_7814),
    w(name(_7705,n,_7706),_7823,_7814,_7840),
    point0(_7852,_7840,_7867),
    not_look_ahead(w(name(_7744,_7745,date)),_7876,_7867,_7784),
    {user:(_7706==unkn->value(unknownflag,true))},
    {user:number(_7705)},
    {user:type(_7706,_7709)}.

nameq1(_7705:_7706,_7703,[nameq1,_7763,{}],_7746,_7748) --> 
    timeq1(_7705:_7706,_7703,_7763,_7746,_7748),
    {user:(number(_7705),_7705>=100)}.

nameq1(_7705:year,_7705 isa year,[nameq1,_7771,{}],_7754,_7756) --> 
    w(nb(_7705,num),_7771,_7754,_7756),
    {user:(number(_7705),_7705>=1900,_7705=<2099)}.

date(_7705:date,_7705 isa date,[date,_7833,{},_7872,_7896,!,{},{},{},{}],_7816,_7818) --> 
    num_na(_7744,_7833,_7816,_7850),
    {user:(_7744>=1,_7744=<7)},
    slashpoint0(_7872,_7850,_7887),
    w(name(new_years_day,n,date),_7896,_7887,_7818),
    !,
    {user:datetime(_7765,_7766,_7767,_7768,_7769,_7770)},
    {user:(_7766>1->_7740 is _7765+1;_7740 is _7765)},
    {user:_7742 is _7744},
    {user:_7705=date(_7740,1,_7742)}.

date(_7705:date,_7705 isa date,[date,_7824,{},_7863,_7887,{},!,{}],_7807,_7809) --> 
    num_na(_7741,_7824,_7807,_7841),
    {user:(_7741>=1,_7741=<7)},
    slashpoint0(_7863,_7841,_7878),
    w(name(_7756,n,date),_7887,_7878,_7809),
    {user:testmember(_7756,[whitsun_day,easterday,christmas_day])},
    !,
    {user:(named_date(_7756,date(_7774,_7775,_7776)),_7738 is _7741-1,add_days(date(_7774,_7775,_7776),_7738,_7705))}.

date(_7705:date,_7705 isa date,[date,_7780,_7809,_7833,_7862,_7886,!,{}],_7763,_7765) --> 
    dayno(_7736,_7780,_7763,_7797),
    slashpoint0(_7809,_7797,_7824),
    month(_7735,_7833,_7824,_7850),
    slashpoint0(_7862,_7850,_7877),
    year(_7734,_7886,_7877,_7765),
    !,
    {user:_7705=date(_7734,_7735,_7736)}.

date(_7705:date,_7705 isa date,[date,_7795,_7824,_7848,_7877,{},!,_7916,{}],_7778,_7780) --> 
    dayno(_7739,_7795,_7778,_7812),
    slashpoint(_7824,_7812,_7839),
    month(_7738,_7848,_7839,_7865),
    point0(_7877,_7865,_7892),
    {user:(_7739>24;_7738>0)},
    !,
    xyear0(_7738,_7737,_7916,_7892,_7780),
    {user:_7705=date(_7737,_7738,_7739)}.

date(_7705:date,_7705 isa date,[date,_7781,_7810,_7834,_7863,!,_7902,{}],_7764,_7766) --> 
    dayno(_7736,_7781,_7764,_7798),
    slashpoint0(_7810,_7798,_7825),
    monthname(_7735,_7834,_7825,_7851),
    xyear0(_7735,_7734,_7863,_7851,_7882),
    !,
    accept(_7902,_7882,_7766),
    {user:_7705=date(_7734,_7735,_7736)}.

date(_7705:date,_7705 isa date,[date,_7783,_7812,_7841,!,_7875,{},!,_7914],_7766,_7768) --> 
    year(_7732,_7783,_7766,_7800),
    month(_7734,_7812,_7800,_7829),
    dayno(_7736,_7841,_7829,_7858),
    !,
    accept(_7875,_7858,_7890),
    {user:_7705=date(_7732,_7734,_7736)},
    !,
    accept(_7914,_7890,_7768).

timeq1(_7705:clock,_7705 isa clock,[timeq1,lit(halv),_7785,{},!,_7829],_7757,_7759) --> 
    cc(halv,_7757,_7784),
    hours(_7725,_7785,_7784,_7802),
    {user:_7705 is _7725*100-70},
    !,
    accept(_7829,_7802,_7759).

timeq1(_7705:clock,_7705 isa clock,[timeq1,_7755,!,_7789],_7738,_7740) --> 
    time12(_7705,_7755,_7738,_7772),
    !,
    accept(_7789,_7772,_7740).

clock_sequel(_7705:clock,_7705 isa clock,[clock_sequel,_7759,!],_7742,_7744) --> 
    clock_kernel(_7705:clock,_7705 isa clock,_7759,_7742,_7744),
    !.

clock_sequel(_7705:clock,_7705 isa clock,[clock_sequel,_7803,{},_7842,_7871,_7895,{},!,{}],_7786,_7788) --> 
    w(nb(_7742,num),_7803,_7786,_7820),
    {user:_7742<100},
    not_look_ahead([/],_7842,_7820,_7859),
    point(_7871,_7859,_7886),
    w(nb(_7738,num),_7895,_7886,_7788),
    {user:_7738<100},
    !,
    {user:_7705 is _7742*100+_7738}.

clock_sequel(_7705:clock,_7705 isa clock,[clock_sequel,_7788,_7817,{}],_7771,_7773) --> 
    w(nb(_7723,num),_7788,_7771,_7805),
    not_look_ahead([/],_7817,_7805,_7773),
    {user:(_7723>0,_7723<25->_7705 is _7723*100;_7705 is _7723)}.

clock_kernel(_7705:clock,_7705 isa clock,[clock_kernel,_7770,{},!],_7753,_7755) --> 
    number(_7705:_7720,_7770,_7753,_7755),
    {user:(_7705>2500,\+clock_test(_7705))},
    !.

clock_kernel(_7702,_7703,[clock_kernel,lit(nå),!,_7765],_7732,_7734) --> 
    cc(nå,_7732,_7759),
    !,
    reject(_7765,_7759,_7734).

clock_kernel(_7702,_7703,[clock_kernel,lit(en),!,_7765],_7732,_7734) --> 
    cc(en,_7732,_7759),
    !,
    reject(_7765,_7759,_7734).

clock_kernel(_7702,_7703,[clock_kernel,lit(et),!,_7765],_7732,_7734) --> 
    cc(et,_7732,_7759),
    !,
    reject(_7765,_7759,_7734).

clock_kernel(_7705:clock,_7705 isa clock,[clock_kernel,_7831,_7860,_7889,{},_7928,_7957,_7986,_8015,!,_8064],_7814,_7816) --> 
    not_look_ahead(w(name(_7742,n,route)),_7831,_7814,_7848),
    not_look_ahead(w(name(_7750,n,nightbus)),_7860,_7848,_7877),
    w(nb(_7705,num),_7889,_7877,_7906),
    {user:(_7705>=100,clock_test(_7705))},
    not_look_ahead(w(noun(_7773,plu,_7775,_7776)),_7928,_7906,_7945),
    not_look_ahead([tusen],_7957,_7945,_7974),
    not_look_ahead([millioner],_7986,_7974,_8003),
    optional(w(noun(time,sin,def,n)),_8015,_8003,_8047),
    !,
    accept(_8064,_8047,_7816).

clock_kernel(_7702,_7703,[clock_kernel,_7757,_7786,_7810,!,_7844],_7740,_7742) --> 
    num_na(_7717,_7757,_7740,_7774),
    point0(_7786,_7774,_7801),
    monthname(_7719,_7810,_7801,_7827),
    !,
    reject(_7844,_7827,_7742).

clock_kernel(_7705:clock,_7705 isa clock,[clock_kernel,{},_7790,_7819,_7848,!,_7882],_7763,_7765) --> 
    {user:value(busflag,true)},
    hours(_7734,_7790,_7763,_7807),
    colemin0(_7736,_7819,_7807,_7836),
    w(name(_7740,_7741,month),_7848,_7836,_7865),
    !,
    reject(_7882,_7865,_7765).

clock_kernel(_7705:clock,_7705 isa clock,[clock_kernel,{},_7792,_7821,{},!,_7865],_7765,_7767) --> 
    {user:value(busflag,true)},
    hours(_7734,_7792,_7765,_7809),
    colemin0(_7736,_7821,_7809,_7838),
    {user:dedicated_date(date(_7742,_7734,_7736))},
    !,
    reject(_7865,_7838,_7767).

clock_kernel(_7702,_7703,[clock_kernel,_7770,_7799,_7828,{},!,_7872],_7753,_7755) --> 
    hours(_7720,_7770,_7753,_7787),
    colemin2(_7722,_7799,_7787,_7816),
    w(nb(_7726,num),_7828,_7816,_7845),
    {user:_7726>=60},
    !,
    reject(_7872,_7845,_7755).

clock_kernel(_7705:clock,_7705 isa clock,[clock_kernel,_7783,_7812,!,_7846,{}],_7766,_7768) --> 
    hours24(_7731,_7783,_7766,_7800),
    colemin2(_7729,_7812,_7800,_7829),
    !,
    optional(w(noun(time,sin,def,n)),_7846,_7829,_7768),
    {user:_7705 is _7731*100+_7729}.

clock_kernel(_7705:clock,_7705 isa clock,[clock_kernel,_7755,!,_7789],_7738,_7740) --> 
    time012(_7705,_7755,_7738,_7772),
    !,
    accept(_7789,_7772,_7740).

clock_kernel(_7705:clock,_7705 isa clock,[clock_kernel,_7749],_7732,_7734) --> 
    timeoff(_7705,_7749,_7732,_7734).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(et)],_7732,_7734) --> 
    cc(et,_7732,_7734).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(en)],_7732,_7734) --> 
    cc(en,_7732,_7734).

clock_kernel(_7705:clock,_7705 isa clock,[clock_kernel,_7805,{},_7844,_7873,{}],_7788,_7790) --> 
    w(nb(_7730,num),_7805,_7788,_7822),
    {user:_7730>9},
    not_look_ahead(w(noun(minute,_7743,_7744,_7745)),_7844,_7822,_7861),
    not_look_ahead([/],_7873,_7861,_7790),
    {user:(_7730>0,_7730<25->_7705 is _7730*100;fail)}.

namenb(1,[namenb,lit(ett),_7764,!,_7798],_7739,_7741) --> 
    cc(ett,_7739,_7763),
    w(noun(_7717,_7718,_7719,_7720),_7764,_7763,_7781),
    !,
    reject(_7798,_7781,_7741).

namenb(1,[namenb,lit(ett),!,_7759],_7729,_7731) --> 
    cc(ett,_7729,_7753),
    !,
    accept(_7759,_7753,_7731).

namenb(_7702,[namenb,_7741,!,_7770],_7727,_7729) --> 
    a(_7741,_7727,_7756),
    !,
    reject(_7770,_7756,_7729).

namenb(_7702,[namenb,_7741],_7727,_7729) --> 
    w(name(_7702,n,_7708),_7741,_7727,_7729).

namenb(_7702,[namenb,_7740],_7726,_7728) --> 
    w(nb(_7702,num),_7740,_7726,_7728).

dayno(_7702,[dayno,_7751,{}],_7737,_7739) --> 
    num_na(_7702,_7751,_7737,_7739),
    {user:(_7702>0,_7702=<31)}.

month(_7702,[month,_7740,!],_7726,_7728) --> 
    monthnamed(_7702,_7740,_7726,_7728),
    !.

month(_7702,[month,_7737],_7723,_7725) --> 
    monthnum(_7702,_7737,_7723,_7725).

monthnamed(_7702,[monthnamed,_7743,_7772,!],_7729,_7731) --> 
    monthname(_7702,_7743,_7729,_7760),
    point0(_7772,_7760,_7731),
    !.

monthname(_7702,[monthname,_7749,{}],_7735,_7737) --> 
    w(name(_7709,n,_7716),_7749,_7735,_7737),
    {user:monthnumber(_7709,_7702)}.

monthnum(_7702,[monthnum,_7754,{}],_7740,_7742) --> 
    number(_7702:_7718,_7754,_7740,_7742),
    {user:(_7702>0,_7702=<12)}.

monthnamex([monthnamex,_7730],_7719,_7721) --> 
    monthname(_7702,_7730,_7719,_7721).

monthnamex([monthnamex,_7742,{}],_7731,_7733) --> 
    w(name(_7707,_7713,_7714),_7742,_7731,_7733),
    {user:named_date(_7707,_7708)}.

day(_7702,[day,_7749,{}],_7735,_7737) --> 
    w(noun(_7702,_7714,_7715,_7716),_7749,_7735,_7737),
    {user:dayname(_7702)}.

day(weekday,[day,_7742],_7728,_7730) --> 
    w(noun(weekday,_7707,_7708,_7709),_7742,_7728,_7730).

xyear0(_7702,_7703,[xyear0,_7752,_7776,!,_7810],_7735,_7737) --> 
    aar0(_7752,_7735,_7767),
    year(_7703,_7776,_7767,_7793),
    !,
    accept(_7810,_7793,_7737).

xyear0(_7702,_7703,[xyear0,{},{}],_7737,_7737) --> 
    {user:this_year(_7711)},
    {user:adjust_year(_7702,_7711,_7703)}.

year0(_7702,[year0,_7746,_7770,!,_7804],_7732,_7734) --> 
    aar0(_7746,_7732,_7761),
    year(_7702,_7770,_7761,_7787),
    !,
    accept(_7804,_7787,_7734).

year0(_7702,[year0,{}],_7725,_7725) --> 
    {user:this_year(_7702)}.

aar0([aar0,_7741,_7765,!],_7730,_7732) --> 
    point0(_7741,_7730,_7756),
    w(noun(year,_7711,_7712,n),_7765,_7756,_7732),
    !.

aar0([aar0,_7728],_7717,_7719) --> 
    point0(_7728,_7717,_7719).

year(_7702,[year,{},_7781,{},!,_7825],_7757,_7759) --> 
    {user:value(busflag,true)},
    number(_7702:_7727,_7781,_7757,_7798),
    {user:(_7702>=2000,_7702=<9999)},
    !,
    accept(_7825,_7798,_7759).

year(_7702,[year,_7760,{},!,_7804],_7746,_7748) --> 
    number(_7702:_7716,_7760,_7746,_7777),
    {user:(_7702>=1000,_7702=<9999)},
    !,
    accept(_7804,_7777,_7748).

year(_7702,[year,_7771,{},!,_7815,{}],_7757,_7759) --> 
    number(_7721:_7727,_7771,_7757,_7788),
    {user:(_7721>=0,_7721=<99)},
    !,
    accept(_7815,_7788,_7759),
    {user:_7702 is _7721+2000}.

timexp(_7702,[timexp,_7740,_7764],_7726,_7728) --> 
    clock0(_7740,_7726,_7755),
    time2(_7702,_7764,_7755,_7728).

timexp(_7702,[timexp,_7740,_7764],_7726,_7728) --> 
    clock0(_7740,_7726,_7755),
    time1(_7702,_7764,_7755,_7728).

timenexp(_7702,[timenexp,_7740,_7764],_7726,_7728) --> 
    clock(_7740,_7726,_7755),
    time2(_7702,_7764,_7755,_7728).

timenexp(_7702,[timenexp,_7740,_7764],_7726,_7728) --> 
    clock(_7740,_7726,_7755),
    time1(_7702,_7764,_7755,_7728).

clock_time(1300,[clock_time,_7741,!,_7770],_7727,_7729) --> 
    a(_7741,_7727,_7756),
    !,
    accept(_7770,_7756,_7729).

clock_time(1300,[clock_time,lit(nå),!,_7759],_7729,_7731) --> 
    cc(nå,_7729,_7753),
    !,
    reject(_7759,_7753,_7731).

clock_time(_7702,[clock_time,_7762,_7791,{},_7830],_7748,_7750) --> 
    hours(_7716,_7762,_7748,_7779),
    colemin0(_7718,_7791,_7779,_7808),
    {user:_7713 is _7716*100+_7718},
    ampm0(_7713,_7702,_7830,_7808,_7750).

clock_time(_7702,[clock_time,_7737],_7723,_7725) --> 
    time12(_7702,_7737,_7723,_7725).

time012(_7702,[time012,_7737],_7723,_7725) --> 
    time12(_7702,_7737,_7723,_7725).

time012(_7702,[time012,_7790,{},_7829,_7858,{}],_7776,_7778) --> 
    w(nb(_7727,num),_7790,_7776,_7807),
    {user:_7727>1},
    not_look_ahead(w(noun(minute,_7745,_7746,_7747)),_7829,_7807,_7846),
    not_look_ahead([/],_7858,_7846,_7778),
    {user:(_7727>0,_7727<25,_7702 is _7727*100)}.

time012(100,[time012,_7753,_7782,_7811,!],_7739,_7741) --> 
    w(nb(1,num),_7753,_7739,_7770),
    not_look_ahead([/],_7782,_7770,_7799),
    not_look_ahead_np(_7811,_7799,_7741),
    !.

time12(_7702,[time12,_7747,_7776],_7733,_7735) --> 
    time2(_7702,_7747,_7733,_7764),
    w(noun(time,sin,def,n),_7776,_7764,_7735).

time12(_7702,[time12,_7737],_7723,_7725) --> 
    time2(_7702,_7737,_7723,_7725).

time12(_7702,[time12,_7750,_7779,_7803],_7736,_7738) --> 
    time1(_7702,_7750,_7736,_7767),
    point0(_7779,_7767,_7794),
    w(noun(time,sin,def,n),_7803,_7794,_7738).

timeoff(_7702,[timeoff,_7781,{},_7820,_7844,{},{}],_7767,_7769) --> 
    w(nb(_7729,num),_7781,_7767,_7798),
    {user:_7729<100},
    colon0(_7820,_7798,_7835),
    w(nb(_7725,num),_7844,_7835,_7769),
    {user:_7725<100},
    {user:_7702 is _7729*100+_7725}.

time1(_7702,[time1,_7746,!,_7780],_7732,_7734) --> 
    w(nb(0,_7713),_7746,_7732,_7763),
    !,
    reject(_7780,_7763,_7734).

time1(_7702,[time1,lit(ett),_7776,_7805,!,_7839],_7751,_7753) --> 
    cc(ett,_7751,_7775),
    not_look_ahead(w(noun(time,_7723,def,_7725)),_7776,_7775,_7793),
    w(noun(_7729,_7730,_7731,_7732),_7805,_7793,_7822),
    !,
    reject(_7839,_7822,_7753).

time1(100,[time1,lit(ett),_7766,!,_7815],_7741,_7743) --> 
    cc(ett,_7741,_7765),
    optional(w(noun(time,_7720,def,_7722)),_7766,_7765,_7798),
    !,
    accept(_7815,_7798,_7743).

time1(_7702,[time1,_7753,_7777,!,_7811],_7739,_7741) --> 
    a(_7753,_7739,_7768),
    not_look_ahead(w(noun(time,_7718,def,_7720)),_7777,_7768,_7794),
    !,
    reject(_7811,_7794,_7741).

time1(_7702,[time1,_7749,_7778,!,_7817],_7735,_7737) --> 
    time3(_7713,_7749,_7735,_7766),
    ampm0(_7713,_7702,_7778,_7766,_7797),
    !,
    accept(_7817,_7797,_7737).

time1(_7702,[time1,_7787,_7816,_7845,{},!,{},_7899],_7773,_7775) --> 
    w(nb(_7727,num),_7787,_7773,_7804),
    not_look_ahead(w(noun(hour,_7735,_7736,_7737)),_7816,_7804,_7833),
    not_look_ahead([t],_7845,_7833,_7862),
    {user:_7727<25},
    !,
    {user:_7722 is _7727*100},
    ampm0(_7722,_7702,_7899,_7862,_7775).

time1(now,[time1,lit(nå),lit(av),!,_7775],_7734,_7736) --> 
    cc(nå,_7734,_7758),
    cc(av,_7758,_7769),
    !,
    reject(_7775,_7769,_7736).

time1(now,[time1,lit(nå)],_7723,_7725) --> 
    cc(nå,_7723,_7725).

time2(_7702,[time2,_7787,{},_7826,_7850,{},!,_7894,{}],_7773,_7775) --> 
    hours24(_7733,_7787,_7773,_7804),
    {user:_7733=<25},
    point(_7826,_7804,_7841),
    num(_7731,_7850,_7841,_7867),
    {user:(_7731>12,_7731<60)},
    !,
    accept(_7894,_7867,_7775),
    {user:_7702 is _7733*100+_7731}.

time2(_7702,[time2,_7771,_7800,!,{},_7844,{}],_7757,_7759) --> 
    num(_7725,_7771,_7757,_7788),
    w(prep(over),_7800,_7788,_7817),
    !,
    {user:_7725<60},
    hours30(_7724,_7844,_7817,_7759),
    {user:_7702 is _7724+_7725}.

time2(_7702,[time2,_7770,_7799,_7823,!,{},_7862,{}],_7756,_7758) --> 
    num(_7728,_7770,_7756,_7787),
    minutes(_7799,_7787,_7814),
    overclock(_7823,_7814,_7838),
    !,
    {user:_7728<60},
    hours30(_7727,_7862,_7838,_7758),
    {user:_7702 is _7727+_7728}.

time2(_7702,[time2,_7769,{},_7808,!,_7842,{}],_7755,_7757) --> 
    num(_7722,_7769,_7755,_7786),
    {user:_7722<60},
    w(prep(on),_7808,_7786,_7825),
    !,
    hours30(_7721,_7842,_7825,_7757),
    {user:subfromtime(_7721,_7722,_7702)}.

time2(_7702,[time2,_7771,_7800,_7824,!,{},_7863,_7887,{}],_7757,_7759) --> 
    num(_7728,_7771,_7757,_7788),
    minutes(_7800,_7788,_7815),
    onclock(_7824,_7815,_7839),
    !,
    {user:_7728<60},
    clock0(_7863,_7839,_7878),
    hours30(_7727,_7887,_7878,_7759),
    {user:subfromtime(_7727,_7728,_7702)}.

time2(_7702,[time2,_7777,lit(halv),_7832,{},_7871],_7763,_7765) --> 
    optional(w(prep(in)),_7777,_7763,_7809),
    cc(halv,_7809,_7831),
    hours100(_7733,_7832,_7831,_7849),
    {user:_7702 is _7733-100+30},
    optional(w(noun(time,sin,def,n)),_7871,_7849,_7765).

time2(_7702,[time2,lit(halv),_7772,!,_7806,{}],_7747,_7749) --> 
    cc(halv,_7747,_7771),
    prep1(over,_7772,_7771,_7789),
    !,
    hours100(_7721,_7806,_7789,_7749),
    {user:_7702 is _7721+30}.

time2(_7702,[time2,lit(kvart),_7770,_7794,{}],_7745,_7747) --> 
    cc(kvart,_7745,_7769),
    onclock(_7770,_7769,_7785),
    hours100(_7723,_7794,_7785,_7747),
    {user:_7702 is _7723-100+45}.

time2(_7702,[time2,lit(kvart),_7770,_7794,{}],_7745,_7747) --> 
    cc(kvart,_7745,_7769),
    overclock(_7770,_7769,_7785),
    hours(_7723,_7794,_7785,_7747),
    {user:_7702 is _7723*100+15}.

time2(_7702,[time2,_7764,_7793,_7822,{},!,_7866],_7750,_7752) --> 
    hours(_7719,_7764,_7750,_7781),
    minutes(_7721,_7793,_7781,_7810),
    number(_7725:_7726,_7822,_7810,_7839),
    {user:_7725>24},
    !,
    reject(_7866,_7839,_7752).

time2(_7702,[time2,_7757,_7786,_7815,!,_7849],_7743,_7745) --> 
    hours(_7716,_7757,_7743,_7774),
    minutes(_7718,_7786,_7774,_7803),
    w(name(_7722,_7723,month),_7815,_7803,_7832),
    !,
    reject(_7849,_7832,_7745).

time2(_7702,[time2,_7762,_7791,{},_7830],_7748,_7750) --> 
    hours24(_7716,_7762,_7748,_7779),
    colemin(_7718,_7791,_7779,_7808),
    {user:_7713 is _7716*100+_7718},
    ampm0(_7713,_7702,_7830,_7808,_7750).

time2(_7702,[time2,_7756,_7785,_7814,_7838,!,_7872],_7742,_7744) --> 
    hours(_7719,_7756,_7742,_7773),
    minutes(_7721,_7785,_7773,_7802),
    point(_7814,_7802,_7829),
    minutes(_7723,_7838,_7829,_7855),
    !,
    reject(_7872,_7855,_7744).

time2(_7702,[time2,_7770,_7799,{},{},_7848],_7756,_7758) --> 
    hours24(_7719,_7770,_7756,_7787),
    minutes(_7721,_7799,_7787,_7816),
    {user:_7721>12},
    {user:_7716 is _7719*100+_7721},
    ampm0(_7716,_7702,_7848,_7816,_7758).

onclock([onclock,_7747,{},_7786],_7736,_7738) --> 
    w(prep(_7710),_7747,_7736,_7764),
    {user:testmember(_7710,[on,before])},
    clock0(_7786,_7764,_7738).

overclock([overclock,_7747,{},_7786],_7736,_7738) --> 
    w(prep(_7710),_7747,_7736,_7764),
    {user:testmember(_7710,[over,after])},
    clock0(_7786,_7764,_7738).

hours30(_7702,[hours30,lit(halv),_7773,{},!,_7817],_7748,_7750) --> 
    cc(halv,_7748,_7772),
    hours(_7718,_7773,_7772,_7790),
    {user:_7702 is _7718*100-70},
    !,
    accept(_7817,_7790,_7750).

hours30(_7702,[hours30,_7737],_7723,_7725) --> 
    hours100(_7702,_7737,_7723,_7725).

hours100(_7702,[hours100,_7748,_7777,!,_7811],_7734,_7736) --> 
    num(_7702,_7748,_7734,_7765),
    monthname(_7715,_7777,_7765,_7794),
    !,
    reject(_7811,_7794,_7736).

hours100(_7702,[hours100,_7769,{},!,_7813],_7755,_7757) --> 
    num(_7702,_7769,_7755,_7786),
    {user:(_7702 is _7702//100*100,_7702>100,_7702<2500)},
    !,
    accept(_7813,_7786,_7757).

hours100(_7702,[hours100,_7748,{}],_7734,_7736) --> 
    hours(_7712,_7748,_7734,_7736),
    {user:_7702 is _7712*100}.

hours100(100,[hours100,lit(ett),!,_7759],_7729,_7731) --> 
    cc(ett,_7729,_7753),
    !,
    accept(_7759,_7753,_7731).

hours100(1300,[hours100,lit(et),!,_7759],_7729,_7731) --> 
    cc(et,_7729,_7753),
    !,
    accept(_7759,_7753,_7731).

time3(_7702,[time3,_7748,{}],_7734,_7736) --> 
    w(nb(_7702,num),_7748,_7734,_7736),
    {user:_7702>=60}.

ampm0(_7702,_7702,[ampm0,_7747,!,_7776],_7730,_7732) --> 
    amtime(_7747,_7730,_7762),
    !,
    accept(_7776,_7762,_7732).

ampm0(_7702,_7703,[ampm0,_7767,!,{}],_7750,_7752) --> 
    pmtime(_7767,_7750,_7752),
    !,
    {user:(_7702>1200->_7703 is _7702;_7703 is _7702+1200)}.

ampm0(_7702,_7702,[ampm0,lit(h),!],_7729,_7731) --> 
    cc(h,_7729,_7731),
    !.

ampm0(_7702,_7702,[ampm0,[]],_7724,_7724) --> 
    [].

amtime([amtime,lit(am)],_7719,_7721) --> 
    cc(am,_7719,_7721).

amtime([amtime,lit(a),lit(m)],_7724,_7726) --> 
    cc(a,_7724,_7745),
    cc(m,_7745,_7726).

pmtime([pmtime,lit(pm)],_7719,_7721) --> 
    cc(pm,_7719,_7721).

pmtime([pmtime,lit(p),lit(m)],_7724,_7726) --> 
    cc(p,_7724,_7745),
    cc(m,_7745,_7726).

hours24(_7702,[hours24,_7737],_7723,_7725) --> 
    hours(_7702,_7737,_7723,_7725).

hours(_7702,[hours,_7755,_7784,_7813,!,_7842],_7741,_7743) --> 
    not_look_ahead([ett],_7755,_7741,_7772),
    not_look_ahead([et],_7784,_7772,_7801),
    a(_7813,_7801,_7828),
    !,
    reject(_7842,_7828,_7743).

hours(_7702,[hours,_7755,{},_7794],_7741,_7743) --> 
    w(nb(_7702,num),_7755,_7741,_7772),
    {user:_7702=<25},
    optional([h],_7794,_7772,_7743).

smallhours(_7702,[smallhours,_7754,{}],_7740,_7742) --> 
    w(nb(_7702,num),_7754,_7740,_7742),
    {user:(_7702>31,_7702=<59)}.

minutes0([minutes0,_7734,!,_7763],_7723,_7725) --> 
    minutes(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

minutes0([minutes0,[]],_7717,_7717) --> 
    [].

minutes([minutes,_7741,!,_7775],_7730,_7732) --> 
    w(noun(minute,_7711,_7712,_7713),_7741,_7730,_7758),
    !,
    accept(_7775,_7758,_7732).

colemin0(_7702,[colemin0,_7743,!,_7777],_7729,_7731) --> 
    colemin(_7702,_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

colemin0(_7702,[colemin0,_7746,_7770,!,_7804],_7732,_7734) --> 
    point0(_7746,_7732,_7761),
    minutes0(_7702,_7770,_7761,_7787),
    !,
    accept(_7804,_7787,_7734).

colemin2(_7702,[colemin2,_7751,_7780,_7804,!,_7838],_7737,_7739) --> 
    minutes(_7716,_7751,_7737,_7768),
    point(_7780,_7768,_7795),
    minutes(_7718,_7804,_7795,_7821),
    !,
    reject(_7838,_7821,_7739).

colemin2(_7702,[colemin2,_7749,_7773,_7802,!,_7831],_7735,_7737) --> 
    colon(_7749,_7735,_7764),
    minutes(_7702,_7773,_7764,_7790),
    colesec0(_7802,_7790,_7817),
    !,
    accept(_7831,_7817,_7737).

colemin2(_7702,[colemin2,_7749,_7773,!,_7807],_7735,_7737) --> 
    colon(_7749,_7735,_7764),
    w(nb(_7702,num),_7773,_7764,_7790),
    !,
    reject(_7807,_7790,_7737).

colemin2(0,[colemin2,_7741,!,_7770],_7727,_7729) --> 
    colon(_7741,_7727,_7756),
    !,
    accept(_7770,_7756,_7729).

colemin2(_7702,[colemin2,_7746,_7770,_7799,!],_7732,_7734) --> 
    point0(_7746,_7732,_7761),
    minutes(_7702,_7770,_7761,_7787),
    point0(_7799,_7787,_7734),
    !.

colemin2(_7702,[colemin2,_7743,_7772,!],_7729,_7731) --> 
    minutes(_7702,_7743,_7729,_7760),
    point0(_7772,_7760,_7731),
    !.

colemin(_7702,[colemin,_7759,{},_7798,_7822,!,_7856],_7745,_7747) --> 
    minutes(_7719,_7759,_7745,_7776),
    {user:_7719\==0},
    point(_7798,_7776,_7813),
    minutes(_7726,_7822,_7813,_7839),
    !,
    reject(_7856,_7839,_7747).

colemin(_7702,[colemin,_7749,_7773,!,_7807,_7831],_7735,_7737) --> 
    colon(_7749,_7735,_7764),
    minutes(_7702,_7773,_7764,_7790),
    !,
    accept(_7807,_7790,_7822),
    colesec0(_7831,_7822,_7737).

colemin(_7702,[colemin,_7760,_7784,{},!,_7828],_7746,_7748) --> 
    point(_7760,_7746,_7775),
    minutes(_7702,_7784,_7775,_7801),
    {user:(_7702=0;_7702>12)},
    !,
    colesec0(_7828,_7801,_7748).

colemin(_7702,[colemin,_7749,_7773,!,_7807],_7735,_7737) --> 
    colon(_7749,_7735,_7764),
    w(nb(_7702,num),_7773,_7764,_7790),
    !,
    reject(_7807,_7790,_7737).

colemin(0,[colemin,_7741,!,_7770],_7727,_7729) --> 
    colon(_7741,_7727,_7756),
    !,
    accept(_7770,_7756,_7729).

colesec0([colesec0,lit(:),_7749,!],_7727,_7729) --> 
    cc(:,_7727,_7748),
    minutes(_7710,_7749,_7748,_7729),
    !.

colesec0([colesec0,[]],_7717,_7717) --> 
    [].

minutes0(_7702,[minutes0,_7743,!,_7777],_7729,_7731) --> 
    minutes(_7702,_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

minutes0(0,[minutes0,[]],_7721,_7721) --> 
    [].

minutes(_7702,[minutes,_7741,!,_7770],_7727,_7729) --> 
    a(_7741,_7727,_7756),
    !,
    reject(_7770,_7756,_7729).

minutes(_7702,[minutes,_7748,{}],_7734,_7736) --> 
    w(nb(_7702,num),_7748,_7734,_7736),
    {user:_7702<100}.

nameq2(_7705:_7709,_7705 isa number,[nameq2,_7764,_7793,_7817,!,_7846],_7747,_7749) --> 
    number(_7705:_7709,_7764,_7747,_7781),
    point0(_7793,_7781,_7808),
    monthnamex(_7817,_7808,_7832),
    !,
    reject(_7846,_7832,_7749).

nameq2(_7702,_7703,[nameq2,_7757,_7781,!,_7815],_7740,_7742) --> 
    one(_7757,_7740,_7772),
    w(noun(_7716,sin,u,n),_7781,_7772,_7798),
    !,
    reject(_7815,_7798,_7742).

nameq2(_7705:_7706,_7705 isa _7706,[nameq2,_7786,_7815,{},_7849,{},!],_7769,_7771) --> 
    number(_7705:_7729,_7786,_7769,_7803),
    point(_7815,_7803,_7830),
    {user:(\+_7705=1)},
    w(noun(_7706,sin,u,n),_7849,_7830,_7771),
    {user:alignable(_7706,number)},
    !.

nameq2(_7705:_7709,_7705 isa clock,[nameq2,{},_7788,{},{},!],_7761,_7763) --> 
    {user:type(clock,_7709)},
    number(_7705:_7731,_7788,_7761,_7763),
    {user:_7705>=1000},
    {user:clock_test(_7705)},
    !.

nameq2(_7705:_7709,_7705 isa number,[nameq2,_7752],_7735,_7737) --> 
    number(_7705:_7709,_7752,_7735,_7737).

number(_7704:number,[number,_7781,lit('.'),_7821,{},!,{}],_7767,_7769) --> 
    num(_7730,_7781,_7767,_7798),
    cc('.',_7798,_7820),
    num(_7728,_7821,_7820,_7769),
    {user:(_7728>=100,_7728<1000)},
    !,
    {user:_7704 is _7730*1000+_7728}.

number(2:_7705,[number,_7756,_7780,{}],_7742,_7744) --> 
    a(_7756,_7742,_7771),
    w(noun(pair,_7721,_7722,_7723),_7780,_7771,_7744),
    {user:type(number,_7705)}.

number(_7704:_7705,[number,_7767,_7791,{},_7830,{}],_7753,_7755) --> 
    only0(_7767,_7753,_7782),
    num(_7724,_7791,_7782,_7808),
    {user:type(number,_7705)},
    thousands0(_7725,_7830,_7808,_7755),
    {user:_7704 is _7724*_7725}.

number(_7702,[number,_7753,_7777,!,_7811],_7739,_7741) --> 
    a(_7753,_7739,_7768),
    not_look_ahead(w(noun(time,_7718,def,_7720)),_7777,_7768,_7794),
    !,
    reject(_7811,_7794,_7741).

thousands0(1000,[thousands0,_7738,!],_7724,_7726) --> 
    tusen(_7738,_7724,_7726),
    !.

thousands0(1000000,[thousands0,_7738,!],_7724,_7726) --> 
    million(_7738,_7724,_7726),
    !.

thousands0(1000000000,[thousands0,_7741,!],_7727,_7729) --> 
    milliard(_7741,_7727,_7729),
    !.

thousands0(1,[thousands0,[]],_7721,_7721) --> 
    [].

tusen([tusen,lit(tusen)],_7719,_7721) --> 
    cc(tusen,_7719,_7721).

tusen([tusen,lit(tusener)],_7719,_7721) --> 
    cc(tusener,_7719,_7721).

million([million,lit(million)],_7719,_7721) --> 
    cc(million,_7719,_7721).

million([million,lit(millioner)],_7719,_7721) --> 
    cc(millioner,_7719,_7721).

milliard([milliard,lit(milliard)],_7719,_7721) --> 
    cc(milliard,_7719,_7721).

milliard([milliard,lit(milliarder)],_7719,_7721) --> 
    cc(milliarder,_7719,_7721).

anumber(_7702,[anumber,_7746,_7770,!,_7804],_7732,_7734) --> 
    a0(_7746,_7732,_7761),
    number(_7702,_7770,_7761,_7787),
    !,
    accept(_7804,_7787,_7734).

anumber(1:_7705,[anumber,_7749,!,{}],_7735,_7737) --> 
    art1(_7749,_7735,_7737),
    !,
    {user:type(number,_7705)}.

intrans_verb(work,_7703,id,_7705,_7706,_7707,_7708,[intrans_verb,_7793,_7837,{}],_7761,_7763) --> 
    lexv(tv,hold,_7707,_7708,_7793,_7761,_7816),
    w(prep(on),_7837,_7816,_7763),
    {user:iv_template(work,_7703,_7705,_7706)}.

intrans_verb(be1,_7703,id,_7705,_7706,_7707,_7708,[intrans_verb,_7793,_7837,{}],_7761,_7763) --> 
    lexv(tv,hold,_7707,_7708,_7793,_7761,_7816),
    w(prep(to),_7837,_7816,_7763),
    {user:iv_template(be1,_7703,_7705,_7706)}.

intrans_verb(_7702,_7703,id,_7705,_7706,_7707,_7708,[intrans_verb,_7786,{}],_7754,_7756) --> 
    lexv(iv,_7702,_7707,_7708,_7786,_7754,_7756),
    {user:iv_template(_7702,_7703,_7705,_7706)}.

intrans_verb(be1,_7703,_7704,_7705,_7706,pres,fin,[intrans_verb,_7805,_7834,_7863,{}],_7773,_7775) --> 
    not_look_ahead(w(verb(go,_7731,fin)),_7805,_7773,_7822),
    be1(_7704,_7834,_7822,_7851),
    not_look_ahead(w(verb(_7740,_7741,_7742)),_7863,_7851,_7775),
    {user:iv_template(be1,_7703,_7705,_7706)}.

intrans_verb(_7702,_7703,_7704,_7705,_7706,past,fin,[intrans_verb,_7794,_7823,_7847,{}],_7762,_7764) --> 
    has(_7704,_7794,_7762,_7811),
    now0(_7823,_7811,_7838),
    lexv(iv,_7702,past,part,_7847,_7838,_7764),
    {user:iv_template(_7702,_7703,_7705,_7706)}.

trans_verbs(_7702,_7703,_7704,_7705,_7706,[trans_verbs,_7778,_7842],_7752,_7754) --> 
    trans_verb(_7711,_7703,_7704,id,_7705,_7723,_7724,_7725,_7778,_7752,_7809),
    trans_verbs0(_7711,_7702,_7703,_7704,_7705,_7706,_7842,_7809,_7754).

trans_verbs0(_7702,_7703,_7704,_7705,_7706,_7707,[trans_verbs0,_7790,_7814,_7878],_7761,_7763) --> 
    andor(_7790,_7761,_7805),
    trans_verb(_7722,_7704,_7705,id,_7706,_7727,_7728,_7729,_7814,_7805,_7845),
    trans_verbs0((_7702,_7722),_7703,_7704,_7705,_7706,_7707,_7878,_7845,_7763).

trans_verbs0(_7702,_7702,_7712:_7713,_7715:_7716,_7706,_7702/_7712/_7715/_7706,[trans_verbs0,[]],_7751,_7751) --> 
    [].

trans_verb(tell,_7703,_7704,id,_7706,_7707,_7708,fin,[trans_verb,_7798,_7842,{}],_7763,_7765) --> 
    lexv(tv,tell,_7708,fin,_7798,_7763,_7821),
    particle0(tell,_7842,_7821,_7765),
    {user:tv_template(tell,_7703,_7704,_7706,_7707)}.

trans_verb(_7702,_7703,_7704,_7705,_7706,_7707,past,fin,[trans_verb,_7798,_7827,{}],_7763,_7765) --> 
    has(_7705,_7798,_7763,_7815),
    lexv(tv,_7702,past,part,_7827,_7815,_7765),
    {user:tv_template(_7702,_7703,_7704,_7706,_7707)}.

trans_verb(_7702,_7703,_7704,id,_7706,_7707,_7708,_7709,[trans_verb,_7793,{}],_7758,_7760) --> 
    lexv(tv,_7702,_7708,_7709,_7793,_7758,_7760),
    {user:tv_template(_7702,_7703,_7704,_7706,_7707)}.

rep_v(be_free,pres,fin,[rep_v,_7752],_7732,_7734) --> 
    w(adj2(free,nil),_7752,_7732,_7734).

rep_v(_7702,_7703,_7704,[rep_v,_7765,_7789,_7833,_7862],_7745,_7747) --> 
    aux0(_7765,_7745,_7780),
    lexv(rv,_7702,_7703,_7704,_7789,_7780,_7812),
    reflexiv0(_7702,_7833,_7812,_7850),
    rep_particlev0(_7702,_7862,_7850,_7747).

rep_v(want,pres,fin,[rep_v,lit(skal),!,_7771],_7735,_7737) --> 
    cc(skal,_7735,_7765),
    !,
    reject(_7771,_7765,_7737).

there_be_modal(think,[there_be_modal,_7749,_7773,lit(an)],_7735,_7737) --> 
    thereit(_7749,_7735,_7764),
    w(verb(go,_7715,_7716),_7773,_7764,_7790),
    cc(an,_7790,_7737).

there_be_modal(_7702,[there_be_modal,_7740,_7764],_7726,_7728) --> 
    thereit(_7740,_7726,_7755),
    be_modal(_7702,_7764,_7755,_7728).

be_there_modal(_7702,[be_there_modal,_7743,_7767,_7791],_7729,_7731) --> 
    be(_7743,_7729,_7758),
    thereit(_7767,_7758,_7782),
    be_modal(_7702,_7791,_7782,_7731).

be_modal(_7702,[be_modal,_7740,_7764],_7726,_7728) --> 
    be(_7740,_7726,_7755),
    modal(_7702,_7764,_7755,_7728).

be_modal(seem,[be_modal,_7741],_7727,_7729) --> 
    w(verb(seem,_7707,fin),_7741,_7727,_7729).

modal(_7702,[modal,_7744,_7783],_7730,_7732) --> 
    rep_v(_7702,past,part,_7744,_7730,_7765),
    tobetrue(_7707,_7783,_7765,_7732).

modal(_7702,[modal,_7739],_7725,_7727) --> 
    rep_v(_7702,_7705,fin,_7739,_7725,_7727).

modal(think,[modal,_7740],_7726,_7728) --> 
    w(adj2(possible,nil),_7740,_7726,_7728).

modal(think,[modal,_7740],_7726,_7728) --> 
    w(adj2(best,nil),_7740,_7726,_7728).

modal(free,[modal,_7740],_7726,_7728) --> 
    w(adj2(free,nil),_7740,_7726,_7728).

tobetrue(_7702,[tobetrue,_7740,_7764],_7726,_7728) --> 
    infinitive(_7740,_7726,_7755),
    be_truefalse(_7702,_7764,_7755,_7728).

tobetrue(id,[tobetrue,[]],_7721,_7721) --> 
    [].

pvimodal(_7702,_7703,[pvimodal,_7762,{},{}],_7745,_7747) --> 
    lexv(tv,_7702,_7718,fin,_7762,_7745,_7747),
    {user:_7702\==be},
    {user:pvi_templ(_7702,_7703)}.

lexvaccept(_7702,_7703,_7704,_7705,_7706,[lexvaccept,_7768,!],_7742,_7744) --> 
    hlexv(_7702,_7703,_7704,_7705,_7706,_7768,_7742,_7744),
    !.

hlexv(_7702,_7703,_7704,_7705,_7706,[hlexv,_7801,_7825,_7854,_7883,{},_7927,{}],_7775,_7777) --> 
    aux0(_7801,_7775,_7816),
    negation0(_7728,_7825,_7816,_7842),
    w(verb(_7736,_7704,_7705),_7854,_7842,_7871),
    particlev0(_7736,_7703,_7883,_7871,_7902),
    {user:verbtype(_7703,_7702)},
    negation0(_7729,_7927,_7902,_7777),
    {user:bigno(_7728,_7729,_7706)}.

hlexv(iv,_7703,_7704,fin,_7706,[hlexv,_7782,_7811,_7835,_7864,!],_7756,_7758) --> 
    w(verb(be,_7704,fin),_7782,_7756,_7799),
    now0(_7811,_7799,_7826),
    negation0(_7706,_7835,_7826,_7852),
    particlev2(be,_7703,_7864,_7852,_7758),
    !.

hlexv(_7702,_7703,past,fin,_7706,[hlexv,_7780,_7804,_7828,_7857,_7901],_7754,_7756) --> 
    has(_7780,_7754,_7795),
    danow0(_7804,_7795,_7819),
    negation0(_7706,_7828,_7819,_7845),
    lexv(_7702,_7703,past,part,_7857,_7845,_7880),
    reflexiv0(_7703,_7901,_7880,_7756).

hlexv(tv,bring,_7704,_7705,id,[hlexv,_7770,_7799],_7744,_7746) --> 
    w(verb(have,_7704,_7705),_7770,_7744,_7787),
    prep1(with,_7799,_7787,_7746).

hlexv(_7702,_7703,past,fin,_7706,[hlexv,_7787,_7816,_7845,{}],_7761,_7763) --> 
    w(verb(get,_7725,fin),_7787,_7761,_7804),
    negation0(_7706,_7816,_7804,_7833),
    w(verb(_7703,past,part),_7845,_7833,_7763),
    {user:verbtype(_7703,_7702)}.

hlexv(_7702,_7703,_7704,fin,_7706,[hlexv,_7795,_7824,_7853,{},!],_7769,_7771) --> 
    w(verb(get,_7704,fin),_7795,_7769,_7812),
    negation0(_7706,_7824,_7812,_7841),
    lexv(_7702,_7703,_7730,_7731,_7853,_7841,_7771),
    {user:(_7730\==imp,_7731\=fin)},
    !.

hlexv(_7702,_7703,past,fin,_7706,[hlexv,_7784,_7813,_7837,_7866,!],_7758,_7760) --> 
    w(verb(be,_7723,fin),_7784,_7758,_7801),
    now0(_7813,_7801,_7828),
    negation0(_7706,_7837,_7828,_7854),
    lexv(_7702,_7703,past,part,_7866,_7854,_7760),
    !.

hlexv(_7702,_7703,past,fin,_7706,[hlexv,_7775,_7799,_7823,_7852],_7749,_7751) --> 
    has(_7775,_7749,_7790),
    redundant0(_7799,_7790,_7814),
    negation0(_7706,_7823,_7814,_7840),
    lexv(_7702,_7703,past,part,_7852,_7840,_7751).

hlexv(_7702,know1,_7704,_7705,_7706,[hlexv,_7806,_7835,_7864,{},!,{}],_7780,_7782) --> 
    w(verb(know,_7704,_7705),_7806,_7780,_7823),
    negation0(_7706,_7835,_7823,_7852),
    look_ahead([_7737],_7864,_7852,_7782),
    {user:testmember(_7737,[hva,hvem,hvilken,hvilket,hvilke])},
    !,
    {user:_7702=tv}.

hlexv(tv,know1,_7704,_7705,_7706,[hlexv,_7775,_7804,lit(om)],_7749,_7751) --> 
    w(verb(know,_7704,_7705),_7775,_7749,_7792),
    negation0(_7706,_7804,_7792,_7821),
    cc(om,_7821,_7751).

hlexv(tv,_7703,_7704,fin,_7706,[hlexv,_7800,_7829,_7858,_7882,_7916,!,[]],_7774,_7776) --> 
    w(verb(get,_7704,fin),_7800,_7774,_7817),
    negation0(_7706,_7829,_7817,_7846),
    look_ahead_np(_7858,_7846,_7873),
    np1_accept(_7729,_7730,_7882,_7873,_7901),
    w(verb(_7703,past,part),_7916,_7901,_7933),
    !,
    pushstack(free,xnp(_7729,_7730),nil,_7933,_7776),
    [].

hlexv(tv,get,pres,fin,_7706,[hlexv,lit(får),_7798,_7827,_7856,!],_7761,_7763) --> 
    cc(får,_7761,_7797),
    not_look_ahead(w(verb(_7726,inf,_7728)),_7798,_7797,_7815),
    negation0(_7706,_7827,_7815,_7844),
    optional([opp],_7856,_7844,_7763),
    !.

hlexv(iv,_7703,_7704,_7705,_7706,[hlexv,_7794,{},{},_7843,_7872],_7768,_7770) --> 
    w(verb(_7703,_7704,_7705),_7794,_7768,_7811),
    {user:rv_templ(_7703,_7733)},
    {user:tv_templ(_7703,_7738,nil)},
    negation0(_7706,_7843,_7811,_7860),
    look_ahead([om],_7872,_7860,_7770).

hlexv(_7702,_7703,_7704,_7705,_7706,[hlexv,_7808,{},_7847,_7876,!,{}],_7782,_7784) --> 
    w(verb(_7703,_7704,_7705),_7808,_7782,_7825),
    {user:testmember(_7703,[understand,believe,know])},
    negation0(_7706,_7847,_7825,_7864),
    look_ahead_lit([at,hvordan,hvorfor,når],_7876,_7864,_7784),
    !,
    {user:_7702=rv}.

hlexv(_7702,_7703,_7704,_7705,_7706,[hlexv,_7791,{},_7830,!,{}],_7765,_7767) --> 
    w(verb(_7703,_7704,_7705),_7791,_7765,_7808),
    {user:testmember(_7703,[believe])},
    negation0(_7706,_7830,_7808,_7767),
    !,
    {user:_7702=rv}.

hlexv(_7702,_7703,_7704,_7705,_7706,[hlexv,_7791,{},_7830,!,{}],_7765,_7767) --> 
    w(verb(_7703,_7704,_7705),_7791,_7765,_7808),
    {user:testmember(_7703,[understand])},
    negation0(_7706,_7830,_7808,_7767),
    !,
    {user:_7702=tv}.

hlexv(rv,_7703,_7704,_7705,_7706,[hlexv,{},_7812,_7856,_7885,_7914,_7943,!,_7977],_7776,_7778) --> 
    {user:value(textflag,true)},
    lexv(rv,_7703,_7704,_7705,_7812,_7776,_7835),
    negation0(_7706,_7856,_7835,_7873),
    not_look_ahead([det],_7885,_7873,_7902),
    not_look_ahead([hva],_7914,_7902,_7931),
    rep_particlev0(_7703,_7943,_7931,_7960),
    !,
    accept(_7977,_7960,_7778).

hlexv(tv,know1,pres,fin,_7706,[hlexv,lit(kan),_7802,_7831,_7860,_7889],_7765,_7767) --> 
    cc(kan,_7765,_7801),
    negation0(_7706,_7802,_7801,_7819),
    not_look_ahead([jeg],_7831,_7819,_7848),
    not_look_ahead([du],_7860,_7848,_7877),
    not_look_ahead(w(verb(_7724,_7725,_7726)),_7889,_7877,_7767).

hlexv(_7702,_7703,_7704,_7705,_7706,[hlexv,{},_7789,_7833,!],_7753,_7755) --> 
    {user:nonvar(_7702)},
    lexv(_7702,_7703,_7704,_7705,_7789,_7753,_7812),
    negation0(_7706,_7833,_7812,_7755),
    !.

hlexv(_7702,_7703,_7704,_7705,_7706,[hlexv,_7769,_7813],_7743,_7745) --> 
    lexv(_7702,_7703,_7704,_7705,_7769,_7743,_7792),
    negation0(_7706,_7813,_7792,_7745).

lexv(_7702,_7703,past,fin,[lexv,_7791,_7820,_7844,_7873,!,{},!],_7768,_7770) --> 
    w(verb(have,_7728,fin),_7791,_7768,_7808),
    redundant0(_7820,_7808,_7835),
    w(verb(_7733,past,part),_7844,_7835,_7861),
    particlev2(_7733,_7703,_7873,_7861,_7770),
    !,
    {user:verbtype(_7703,_7702)},
    !.

lexv(_7702,_7703,_7704,part,[lexv,_7776,_7805,{},!],_7753,_7755) --> 
    w(verb(_7718,_7704,part),_7776,_7753,_7793),
    particlev2(_7718,_7703,_7805,_7793,_7755),
    {user:verbtype(_7703,_7702)},
    !.

lexv(iv,_7703,past,fin,[lexv,_7770,{},!],_7747,_7749) --> 
    w(verb(_7703,past,part),_7770,_7747,_7749),
    {user:verbtype(_7703,iv)},
    !.

lexv(iv,_7703,pres,part,[lexv,_7770,{},!],_7747,_7749) --> 
    w(verb(_7703,pres,part),_7770,_7747,_7749),
    {user:verbtype(_7703,iv)},
    !.

lexv(dtv,_7703,_7704,_7705,[lexv,_7767,{}],_7744,_7746) --> 
    w(verb(_7703,_7704,_7705),_7767,_7744,_7746),
    {user:verbtype(_7703,dtv)}.

lexv(iv,be1,pres,fin,[lexv,_7759],_7736,_7738) --> 
    w(verb(be,inf,fin),_7759,_7736,_7738).

lexv(tv,_7703,past,part,[lexv,_7779,_7808,{},!],_7756,_7758) --> 
    w(verb(be,past,part),_7779,_7756,_7796),
    w(verb(_7703,past,part),_7808,_7796,_7758),
    {user:verbtype(_7703,tv)},
    !.

lexv(_7702,_7703,past,part,[lexv,_7770,{},!],_7747,_7749) --> 
    w(verb(_7703,past,part),_7770,_7747,_7749),
    {user:verbtype(_7703,_7702)},
    !.

lexv(tv,tell,_7704,_7705,[lexv,_7777,_7806,_7835,!,_7884],_7754,_7756) --> 
    w(verb(tell,_7704,_7705),_7777,_7754,_7794),
    reflexiv0(tell,_7806,_7794,_7823),
    optional([om],_7835,_7823,_7867),
    !,
    accept(_7884,_7867,_7756).

lexv(rv,_7703,_7704,_7705,[lexv,_7774,{},_7813],_7751,_7753) --> 
    w(verb(_7703,_7704,_7705),_7774,_7751,_7791),
    {user:rv_templ(_7703,_7726)},
    not_look_ahead([hva],_7813,_7791,_7753).

lexv(iv,_7703,_7704,fin,[lexv,_7771,_7800,!],_7748,_7750) --> 
    w(verb(be,_7704,fin),_7771,_7748,_7788),
    w(verb(_7703,pres,part),_7800,_7788,_7750),
    !.

lexv(iv,_7703,past,fin,[lexv,_7771,_7800,!],_7748,_7750) --> 
    w(verb(be,_7716,fin),_7771,_7748,_7788),
    w(verb(_7703,pres,part),_7800,_7788,_7750),
    !.

lexv(rv,_7703,_7704,_7705,[lexv,_7789,{},_7828,_7857,!,_7891],_7766,_7768) --> 
    w(verb(_7703,_7704,_7705),_7789,_7766,_7806),
    {user:testmember(_7703,[tell,notify])},
    reflexiv0(_7703,_7828,_7806,_7845),
    not_look_ahead([hva],_7857,_7845,_7874),
    !,
    accept(_7891,_7874,_7768).

lexv(rv,show,_7704,_7705,[lexv,_7764,_7793],_7741,_7743) --> 
    w(verb(show,_7704,_7705),_7764,_7741,_7781),
    reflexiv0(show,_7793,_7781,_7743).

lexv(rv,mean,_7704,_7705,[lexv,_7769,_7798,!],_7746,_7748) --> 
    w(verb(mean,_7704,_7705),_7769,_7746,_7786),
    look_ahead([at],_7798,_7786,_7748),
    !.

lexv(rv,mean,_7704,_7705,[lexv,_7780,_7809,_7838,_7867],_7757,_7759) --> 
    w(verb(mean,_7704,_7705),_7780,_7757,_7797),
    not_look_ahead([hva],_7809,_7797,_7826),
    not_look_ahead([en],_7838,_7826,_7855),
    not_look_ahead([noe],_7867,_7855,_7759).

lexv(tv,know1,_7704,_7705,[lexv,_7773,_7802,_7831],_7750,_7752) --> 
    w(verb(know,_7704,_7705),_7773,_7750,_7790),
    not_look_ahead([når],_7802,_7790,_7819),
    not_look_ahead([at],_7831,_7819,_7752).

lexv(_7702,_7703,_7704,_7705,[lexv,_7779,_7803,_7827,{},!,_7871],_7756,_7758) --> 
    do(_7779,_7756,_7794),
    faa(_7803,_7794,_7818),
    w(verb(_7703,_7704,_7705),_7827,_7818,_7844),
    {user:verbtype(_7703,_7702)},
    !,
    accept(_7871,_7844,_7758).

lexv(_7702,_7703,_7704,_7705,[lexv,_7783,_7807,_7836,{},!,_7880],_7760,_7762) --> 
    do(_7783,_7760,_7798),
    not_look_ahead([nå],_7807,_7798,_7824),
    w(verb(_7703,_7704,_7705),_7836,_7824,_7853),
    {user:verbtype(_7703,_7702)},
    !,
    accept(_7880,_7853,_7762).

lexv(_7702,_7703,_7704,_7705,[lexv,_7786,_7810,_7839,{},{}],_7763,_7765) --> 
    faa(_7786,_7763,_7801),
    not_look_ahead([nå],_7810,_7801,_7827),
    lexv(_7702,_7703,_7704,_7705,_7839,_7827,_7765),
    {user:verbtype(_7703,_7702)},
    {user:(\+_7703=manage)}.

lexv(tv,run,_7704,_7705,[lexv,_7770,_7799,!,_7833],_7747,_7749) --> 
    w(verb(run,_7704,_7705),_7770,_7747,_7787),
    prep1(with,_7799,_7787,_7816),
    !,
    reject(_7833,_7816,_7749).

lexv(tv,evah,pres,fin,[lexv,_7765,!,_7799],_7742,_7744) --> 
    w(verb(evah,pres,fin),_7765,_7742,_7782),
    !,
    accept(_7799,_7782,_7744).

lexv(cv,be,pres,fin,[lexv,_7756,_7780],_7733,_7735) --> 
    aux0(_7756,_7733,_7771),
    be(_7780,_7771,_7735).

lexv(tv,wonder,_7704,_7705,[lexv,_7759],_7736,_7738) --> 
    w(verb(wonder,_7704,_7705),_7759,_7736,_7738).

lexv(tv,want,_7704,_7705,[lexv,_7762,_7791],_7739,_7741) --> 
    w(verb(think,_7704,_7705),_7762,_7739,_7779),
    rfxpron(_7791,_7779,_7741).

lexv(_7702,_7703,past,fin,[lexv,_7796,_7820,_7849,{},_7888,_7917,{}],_7773,_7775) --> 
    aux1(_7796,_7773,_7811),
    w(verb(_7732,past,part),_7820,_7811,_7837),
    not_look_ahead([om],_7849,_7837,_7866),
    {user:_7732\==have},
    reflexiv0(_7732,_7888,_7866,_7905),
    particlev0(_7732,_7703,_7917,_7905,_7775),
    {user:verbtype(_7703,_7702)}.

lexv(_7702,_7703,_7704,_7705,[lexv,{},_7805,_7834,{},_7873,{}],_7772,_7774) --> 
    {user:_7702==tv},
    w(verb(_7703,_7704,_7705),_7805,_7772,_7822),
    not_look_ahead([om],_7834,_7822,_7851),
    {user:_7703\==have},
    reflexiv0(_7703,_7873,_7851,_7774),
    {user:verbtype(_7703,_7702)}.

lexv(_7702,_7703,_7704,_7705,[lexv,{},_7820,{},_7859,{},_7898,_7927,{}],_7787,_7789) --> 
    {user:var(_7702)},
    w(verb(_7739,_7704,_7705),_7820,_7787,_7837),
    {user:(\+rv_templ(_7739,_7748))},
    not_look_ahead([om],_7859,_7837,_7876),
    {user:_7739\==have},
    reflexiv0(_7739,_7898,_7876,_7915),
    particlev0(_7739,_7703,_7927,_7915,_7789),
    {user:verbtype(_7703,_7702)}.

lexv(iv,_7703,_7704,_7705,[lexv,_7797,_7821,{},{},_7870,_7899,{}],_7774,_7776) --> 
    aux0(_7797,_7774,_7812),
    w(verb(_7732,_7704,_7705),_7821,_7812,_7838),
    {user:_7705==fin},
    {user:_7732\==have},
    reflexiv0(_7732,_7870,_7838,_7887),
    particlev0(_7732,_7703,_7899,_7887,_7776),
    {user:verbtype(_7703,iv)}.

lexv(_7702,have,_7704,_7705,[lexv,_7782,_7806,{},_7845],_7759,_7761) --> 
    aux0(_7782,_7759,_7797),
    w(verb(have,_7704,_7705),_7806,_7797,_7823),
    {user:verbtype(have,_7702)},
    not_look_ahead(w(noun(arrival,_7721,_7722,n)),_7845,_7823,_7761).

lexv(_7702,_7703,past,fin,[lexv,_7770,_7794,{}],_7747,_7749) --> 
    has(_7770,_7747,_7785),
    w(verb(_7703,past,part),_7794,_7785,_7749),
    {user:verbtype(_7703,_7702)}.

lexv(tv,bring,_7704,_7705,[lexv,_7764,_7793],_7741,_7743) --> 
    w(verb(take,_7704,_7705),_7764,_7741,_7781),
    prep1(with,_7793,_7781,_7743).

lexv(_7702,_7703,_7704,_7705,[lexv,_7779,_7808,_7832,{},!],_7756,_7758) --> 
    w(verb(_7721,_7704,_7705),_7779,_7756,_7796),
    redundant0(_7808,_7796,_7823),
    particlev0(_7721,_7703,_7832,_7823,_7758),
    {user:verbtype(_7703,_7702)},
    !.

preadjs0(_7702,[preadjs0,lit(s),_7757,!,_7786],_7732,_7734) --> 
    cc(s,_7732,_7756),
    look_ahead_clock(_7757,_7756,_7772),
    !,
    reject(_7786,_7772,_7734).

preadjs0(_7702,[preadjs0,_7743,_7767,!],_7729,_7731) --> 
    so(_7743,_7729,_7758),
    preadjs(_7702,_7767,_7758,_7731),
    !.

preadjs0((_7704,_7705),[preadjs0,_7751,_7775,_7804,_7828],_7737,_7739) --> 
    dent0(_7751,_7737,_7766),
    preadj1(_7704,_7775,_7766,_7792),
    adj_conjunction(_7804,_7792,_7819),
    preadj1(_7705,_7828,_7819,_7739).

preadjs0((_7704,_7705),[preadjs0,_7757,_7781,_7810,_7839],_7743,_7745) --> 
    dent0(_7757,_7743,_7772),
    preadj1(_7704,_7781,_7772,_7798),
    not_look_ahead(w(prep(_7724)),_7810,_7798,_7827),
    preadjs0(_7705,_7839,_7827,_7745).

preadjs0(true,[preadjs0,[]],_7721,_7721) --> 
    [].

preadjs((_7704,_7705),[preadjs,_7754,_7783,_7812],_7740,_7742) --> 
    preadj1(_7704,_7754,_7740,_7771),
    not_look_ahead(w(prep(_7721)),_7783,_7771,_7800),
    preadjs0(_7705,_7812,_7800,_7742).

preadj1(nil/first,[preadj1,_7749,_7778,!],_7735,_7737) --> 
    w(nb(1,num),_7749,_7735,_7766),
    point(_7778,_7766,_7737),
    !.

preadj1(nil/second,[preadj1,_7749,_7778,!],_7735,_7737) --> 
    w(nb(2,num),_7749,_7735,_7766),
    point(_7778,_7766,_7737),
    !.

preadj1(nil/third,[preadj1,_7749,_7778,!],_7735,_7737) --> 
    w(nb(3,num),_7749,_7735,_7766),
    point(_7778,_7766,_7737),
    !.

preadj1(nil/_7705,[preadj1,_7760,{},!,_7804],_7746,_7748) --> 
    w(name(_7705,n,station),_7760,_7746,_7777),
    {user:(\+adjname_templ(_7705,_7727))},
    !,
    reject(_7804,_7777,_7748).

preadj1(nil/_7705,[preadj1,_7755,{},!],_7741,_7743) --> 
    w(name(_7705,n,_7717),_7755,_7741,_7743),
    {user:adjname_templ(_7705,_7722)},
    !.

preadj1(_7704/_7705,[preadj1,_7748,_7777],_7734,_7736) --> 
    gradverb(_7704,_7748,_7734,_7765),
    w(adj2(_7705,nil),_7777,_7765,_7736).

preadj1(_7704/_7705,[preadj1,_7785,_7814,_7843,_7887,{},!],_7771,_7773) --> 
    not_look_ahead_lit([først,senest,tidligst],_7785,_7771,_7802),
    not_look_ahead(w(prep(_7734)),_7814,_7802,_7831),
    optional([mye],_7843,_7831,_7875),
    w(adj2(_7705,_7704),_7887,_7875,_7773),
    {user:(\+user:post_adjective(_7705))},
    !.

adj_conjunction0([adj_conjunction0,_7731,!],_7720,_7722) --> 
    adj_conjunction(_7731,_7720,_7722),
    !.

adj_conjunction0([adj_conjunction0,[]],_7717,_7717) --> 
    [].

adj_conjunction([adj_conjunction,lit(og)],_7719,_7721) --> 
    cc(og,_7719,_7721).

adj_conjunction([adj_conjunction,lit(men)],_7719,_7721) --> 
    cc(men,_7719,_7721).

adj_conjunction([adj_conjunction,lit(eller)],_7719,_7721) --> 
    cc(eller,_7719,_7721).

adj_conjunction([adj_conjunction,lit(/)],_7719,_7721) --> 
    cc(/,_7719,_7721).

adj1s((_7710;_7711),_7703,_7704,_7707 or _7708,[adj1s,_7780,lit(eller),_7835,!],_7757,_7759) --> 
    adj1(_7710,_7703,_7704,_7707,_7780,_7757,_7803),
    cc(eller,_7803,_7834),
    adj1(_7711,_7703,_7704,_7708,_7835,_7834,_7759),
    !.

adj1s((_7710,_7711),_7703,_7704,_7707 and _7708,[adj1s,_7789,lit(og),_7844,_7888,!],_7766,_7768) --> 
    adj1(_7710,_7703,_7704,_7707,_7789,_7766,_7812),
    cc(og,_7812,_7843),
    adj1(_7711,_7703,_7704,_7708,_7844,_7843,_7867),
    not_look_ahead(w(prep(_7741)),_7888,_7867,_7768),
    !.

adj1s(_7702,_7703,_7704,_7705,[adj1s,_7758],_7735,_7737) --> 
    adj1(_7702,_7703,_7704,_7705,_7758,_7735,_7737).

adj1(_7702,_7703,_7704,_7705,[adj1,_7774,_7803,{}],_7751,_7753) --> 
    gradverbs0(_7715,_7774,_7751,_7791),
    w(adj2(_7702,nil),_7803,_7791,_7753),
    {user:adj_template(_7715,_7702,_7703,_7704,_7705)}.

adj1(_7702,_7703,_7704,_7705,[adj1,_7769,{}],_7746,_7748) --> 
    w(adj2(_7702,_7712),_7769,_7746,_7748),
    {user:adj_template(_7712,_7702,_7703,_7704,_7705)}.

gradverbs0(_7702,[gradverbs0,_7745,!,_7779],_7731,_7733) --> 
    gradverb(_7702,_7745,_7731,_7762),
    !,
    gradverbs0(_7710,_7779,_7762,_7733).

gradverbs0(nil,[gradverbs0,[]],_7721,_7721) --> 
    [].

gradverb0(more,[gradverb0,lit(mer),_7761,!],_7736,_7738) --> 
    cc(mer,_7736,_7760),
    look_ahead(w(adj2(_7716,nil)),_7761,_7760,_7738),
    !.

gradverb0(_7702,[gradverb0,_7749,_7778,!],_7735,_7737) --> 
    gradverb(_7702,_7749,_7735,_7766),
    not_look_ahead(w(prep(_7716)),_7778,_7766,_7737),
    !.

gradverb0(nil,[gradverb0,[]],_7721,_7721) --> 
    [].

gradverb(little,[gradverb,lit(dårlig)],_7723,_7725) --> 
    cc(dårlig,_7723,_7725).

gradverb(more,[gradverb,lit(litt),lit(mer),!],_7731,_7733) --> 
    cc(litt,_7731,_7755),
    cc(mer,_7755,_7733),
    !.

gradverb(more,[gradverb,lit(mye),lit(mer),!],_7731,_7733) --> 
    cc(mye,_7731,_7755),
    cc(mer,_7755,_7733),
    !.

gradverb(more,[gradverb,lit(mer)],_7723,_7725) --> 
    cc(mer,_7723,_7725).

gradverb(only,[gradverb,lit(bare)],_7723,_7725) --> 
    cc(bare,_7723,_7725).

gradverb(too,[gradverb,lit(for)],_7723,_7725) --> 
    cc(for,_7723,_7725).

gradverb(very,[gradverb,lit(meget)],_7723,_7725) --> 
    cc(meget,_7723,_7725).

gradverb(very,[gradverb,lit(veldig)],_7723,_7725) --> 
    cc(veldig,_7723,_7725).

gradverb(little,[gradverb,lit(litt)],_7723,_7725) --> 
    cc(litt,_7723,_7725).

gradverb(somewhat,[gradverb,lit(noe)],_7723,_7725) --> 
    cc(noe,_7723,_7725).

gradverb(often,[gradverb,lit(ofte)],_7723,_7725) --> 
    cc(ofte,_7723,_7725).

gradverb(nil,[gradverb,lit(så)],_7723,_7725) --> 
    cc(så,_7723,_7725).

prepnom(_7702,[prepnom,_7751,{},!,_7795],_7737,_7739) --> 
    prep(_7702,_7751,_7737,_7768),
    {user:_7702==regarding},
    !,
    accept(_7795,_7768,_7739).

prepnom(_7702,[prepnom,_7737],_7723,_7725) --> 
    prepnof(_7702,_7737,_7723,_7725).

prepnog(long,from,[prepnog,_7749,!,_7783],_7732,_7734) --> 
    prep1(from,_7749,_7732,_7766),
    !,
    accept(_7783,_7766,_7734).

prepnog(possible,_7703,[prepnog,!,_7749],_7727,_7729) --> 
    !,
    reject(_7749,_7727,_7729).

prepnog(_7702,_7703,[prepnog,_7749,!,_7783],_7732,_7734) --> 
    prepnof(_7703,_7749,_7732,_7766),
    !,
    accept(_7783,_7766,_7734).

prepnof(_7702,[prepnof,_7747,{}],_7733,_7735) --> 
    prep(_7702,_7747,_7733,_7735),
    {user:(\+_7702=of)}.

defaultprep(_7702,_7703,_7704,[defaultprep,{},{},_7793,!,_7837],_7753,_7755) --> 
    {user:_7702\==be},
    {user:vartypeid(_7703,_7726)},
    adjustprep0(_7702,_7726,_7704,_7793,_7753,_7814),
    !,
    accept(_7837,_7814,_7755).

adjustprep0(_7702,_7703,_7704,[adjustprep0,_7754,!],_7734,_7736) --> 
    adjustprep(_7702,_7703,_7704,_7754,_7734,_7736),
    !.

adjustprep0(_7702,_7703,_7704,[adjustprep0,_7751],_7731,_7733) --> 
    missingprep(_7702,_7703,_7704,_7751,_7731,_7733).

adjustprep(ask,_7703,regarding,[adjustprep,lit(om)],_7729,_7731) --> 
    cc(om,_7729,_7731).

adjustprep(dream,_7703,regarding,[adjustprep,lit(om)],_7729,_7731) --> 
    cc(om,_7729,_7731).

adjustprep(handle2,_7703,regarding,[adjustprep,lit(om)],_7729,_7731) --> 
    cc(om,_7729,_7731).

adjustprep(know,_7703,regarding,[adjustprep,lit(om)],_7729,_7731) --> 
    cc(om,_7729,_7731).

adjustprep(know1,_7703,regarding,[adjustprep,lit(om)],_7729,_7731) --> 
    cc(om,_7729,_7731).

adjustprep(go,_7703,from,[adjustprep,_7749],_7729,_7731) --> 
    prep(after,_7749,_7729,_7731).

adjustprep(go,_7703,to,[adjustprep,_7749],_7729,_7731) --> 
    prep(of,_7749,_7729,_7731).

adjustprep(_7702,_7703,_7704,[adjustprep,_7749],_7729,_7731) --> 
    prep(_7704,_7749,_7729,_7731).

missingprep(_7702,duration,with,[missingprep,!],_7727,_7727) --> 
    !.

missingprep(pass,_7703,_7704,[missingprep,!,_7755],_7730,_7732) --> 
    !,
    reject(_7755,_7730,_7732).

missingprep(_7702,thing,_7704,[missingprep,!,_7755],_7730,_7732) --> 
    !,
    reject(_7755,_7730,_7732).

missingprep(go,direction,in,[missingprep,[]],_7727,_7727) --> 
    [].

missingprep(arrive,_7703,at,[missingprep,[]],_7727,_7727) --> 
    [].

missingprep(depart,_7703,from,[missingprep,[]],_7727,_7727) --> 
    [].

missingprep(go,direction,in,[missingprep,[]],_7727,_7727) --> 
    [].

missingprep(go,_7703,at,[missingprep,[]],_7727,_7727) --> 
    [].

missingprep(start,_7703,at,[missingprep,[]],_7727,_7727) --> 
    [].

missingprep(stop,_7703,at,[missingprep,[]],_7727,_7727) --> 
    [].

prep0(from,[prep0,_7743,!,_7777],_7729,_7731) --> 
    prep(from,_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

prep0(_7702,[prep0,_7745,{}],_7731,_7733) --> 
    prep(_7702,_7745,_7731,_7733),
    {user:_7702\==of}.

prep0(in,[prep0,[]],_7721,_7721) --> 
    [].

prep(_7702,[prep,lit(m),_7762,!,_7796],_7737,_7739) --> 
    cc(m,_7737,_7761),
    w(nb(_7717,_7718),_7762,_7761,_7779),
    !,
    reject(_7796,_7779,_7739).

prep(from,[prep,lit(dra),{},_7777],_7742,_7744) --> 
    cc(dra,_7742,_7766),
    {user:value(smsflag,true)},
    look_ahead(w(name(_7714,n,_7716)),_7777,_7766,_7744).

prep(_7702,[prep,_7737],_7723,_7725) --> 
    prep2(_7702,_7737,_7723,_7725).

prep(_7702,[prep,_7737],_7723,_7725) --> 
    prep1(_7702,_7737,_7723,_7725).

prep1(after,[prep1,lit(e),_7758,!],_7733,_7735) --> 
    cc(e,_7733,_7757),
    not_look_ahead(['.'],_7758,_7757,_7735),
    !.

prep1(_7702,[prep1,_7746,_7775],_7732,_7734) --> 
    w(prep(_7702),_7746,_7732,_7763),
    not_look_ahead([å],_7775,_7763,_7734).

prep1(to,[prep1,lit(ti),_7759],_7734,_7736) --> 
    cc(ti,_7734,_7758),
    look_ahead(w(name(_7711,_7712,_7713)),_7759,_7758,_7736).

atom(_7702,[atom,_7749,{}],_7735,_7737) --> 
    w(name(_7709,_7715,_7716),_7749,_7735,_7737),
    {user:atom_templ(_7709,_7702)}.

atomlist(_7702,[atomlist,_7751,_7780,_7809],_7737,_7739) --> 
    atom1(_7713,_7751,_7737,_7768),
    atom1(_7715,_7780,_7768,_7797),
    atoms0(_7713-_7715,_7702,_7809,_7797,_7739).

atom1(_7702,[atom1,_7749,{}],_7735,_7737) --> 
    w(name(_7702,n,_7709),_7749,_7735,_7737),
    {user:_7709\==unkn}.

atoms0(_7702,_7703,[atoms0,_7752,_7781],_7735,_7737) --> 
    atom1(_7711,_7752,_7735,_7769),
    atoms0(_7702-_7711,_7703,_7781,_7769,_7737).

atoms0(_7702,_7702,[atoms0,[]],_7724,_7724) --> 
    [].

newatom(_7702,[newatom,_7749,{}],_7735,_7737) --> 
    w(name(_7709,_7715,_7716),_7749,_7735,_7737),
    {user:atom_templ(_7709,_7702)}.

newatomid(_7702,[newatomid,_7741],_7727,_7729) --> 
    w(name(_7702,_7707,_7708),_7741,_7727,_7729).

xsubjunction(nil,coevent,instead_of,[xsubjunction,lit(fremfor)],_7729,_7731) --> 
    cc(fremfor,_7729,_7731).

xsubjunction(nil,coevent,in_order_to,[xsubjunction,_7747],_7727,_7729) --> 
    in_order_to(_7747,_7727,_7729).

xsubjunction(nil,coevent,without,[xsubjunction,_7747],_7727,_7729) --> 
    utenå(_7747,_7727,_7729).

xsubjunction(nil,coevent,by,[xsubjunction,lit(ved),lit(å)],_7734,_7736) --> 
    cc(ved,_7734,_7764),
    cc(å,_7764,_7736).

subjunction(before,time,in,[subjunction,_7752,_7781],_7732,_7734) --> 
    prep1(to,_7752,_7732,_7769),
    look_ahead_np(_7781,_7769,_7734).

subjunction(after,time,in,[subjunction,_7752,_7781],_7732,_7734) --> 
    prep1(after,_7752,_7732,_7769),
    that(_7781,_7769,_7734).

subjunction(after,time,in,[subjunction,_7781,_7810,_7839,_7868,!],_7761,_7763) --> 
    prep1(after,_7781,_7761,_7798),
    not_look_ahead(w(noun(clock,sin,def,n)),_7810,_7798,_7827),
    not_look_ahead(w(nb(_7733,_7734)),_7839,_7827,_7856),
    look_ahead([jeg],_7868,_7856,_7763),
    !.

subjunction(before,time,in,[subjunction,lit(før),_7782,_7811],_7751,_7753) --> 
    cc(før,_7751,_7781),
    not_look_ahead(w(nb(_7727,_7728)),_7782,_7781,_7799),
    not_look_ahead(w(noun(clock,sin,def,n)),_7811,_7799,_7753).

subjunction(before,time,in,[subjunction,lit(til),_7771],_7740,_7742) --> 
    cc(til,_7740,_7770),
    not_look_ahead(w(name(_7713,_7714,_7715)),_7771,_7770,_7742).

subjunction(not_withstanding,coevent,nil,[subjunction,_7752,lit(om)],_7732,_7734) --> 
    uansett(_7752,_7732,_7767),
    cc(om,_7767,_7734).

subjunction(not_withstanding,coevent,nil,[subjunction,lit(selvom)],_7729,_7731) --> 
    cc(selvom,_7729,_7731).

uansett([uansett,lit(uansett)],_7719,_7721) --> 
    cc(uansett,_7719,_7721).

uansett([uansett,lit(selv)],_7719,_7721) --> 
    cc(selv,_7719,_7721).

subjunction(unless,coevent,nil,[subjunction,lit(med),lit(mindre)],_7734,_7736) --> 
    cc(med,_7734,_7764),
    cc(mindre,_7764,_7736).

subjunction(nil,coevent,so_that,[subjunction,_7747],_7727,_7729) --> 
    because(_7747,_7727,_7729).

subjunction(nil,coevent,so_that,[subjunction,_7747],_7727,_7729) --> 
    if1(_7747,_7727,_7729).

subjunction(nil,coevent,despite_of,[subjunction,_7754,lit(at)],_7734,_7736) --> 
    prep1(without,_7754,_7734,_7771),
    cc(at,_7771,_7736).

subjunction(nil,coevent,instead_of,[subjunction,_7747],_7727,_7729) --> 
    instead_of(_7747,_7727,_7729).

subjunction(nil,coevent,because_of,[subjunction,lit(med),lit(at)],_7734,_7736) --> 
    cc(med,_7734,_7764),
    cc(at,_7764,_7736).

subjunction(nil,coevent,because_of,[subjunction,_7747],_7727,_7729) --> 
    so_that(_7747,_7727,_7729).

subjunction(nil,coevent,because_of,[subjunction,lit(slik)],_7729,_7731) --> 
    cc(slik,_7729,_7731).

subjunction(during,time,in,[subjunction,_7747],_7727,_7729) --> 
    while(_7747,_7727,_7729).

subjunction(in,time,in,[subjunction,lit(om),_7763],_7732,_7734) --> 
    cc(om,_7732,_7762),
    when1(_7763,_7762,_7734).

subjunction(in,time,in,[subjunction,_7747],_7727,_7729) --> 
    when1(_7747,_7727,_7729).

subjunction(in,time,in,[subjunction,lit(så),_7767],_7736,_7738) --> 
    cc(så,_7736,_7766),
    w(adv(fast),_7767,_7766,_7738).

subjunction(in,time,in,[subjunction,lit(om),lit(hvordan)],_7734,_7736) --> 
    cc(om,_7734,_7764),
    cc(hvordan,_7764,_7736).

subjunction(in,time,in,[subjunction,lit(på),lit(hvordan)],_7734,_7736) --> 
    cc(på,_7734,_7764),
    cc(hvordan,_7764,_7736).

subjunction(in,time,in,[subjunction,lit(da)],_7729,_7731) --> 
    cc(da,_7729,_7731).

subjunction(in,place,in,[subjunction,lit(der)],_7729,_7731) --> 
    cc(der,_7729,_7731).

subjunction(in,place,in,[subjunction,lit(hvor),_7770],_7739,_7741) --> 
    cc(hvor,_7739,_7769),
    not_look_ahead(w(adj2(_7713,_7714)),_7770,_7769,_7741).

subjunction(until,time,in,[subjunction,_7747],_7727,_7729) --> 
    until(_7747,_7727,_7729).

subjunction(in,time,in,[subjunction,lit(i),lit(det)],_7734,_7736) --> 
    cc(i,_7734,_7764),
    cc(det,_7764,_7736).

because([because,lit(fordi)],_7719,_7721) --> 
    cc(fordi,_7719,_7721).

because([because,lit(for),_7753,!],_7731,_7733) --> 
    cc(for,_7731,_7752),
    look_ahead_lit([da,den],_7753,_7752,_7733),
    !.

because([because,lit(siden),_7765,{},!,_7809],_7743,_7745) --> 
    cc(siden,_7743,_7764),
    w(noun(_7718,_7719,_7720,_7721),_7765,_7764,_7782),
    {user:constrain(_7718,time)},
    !,
    reject(_7809,_7782,_7745).

because([because,lit(siden)],_7719,_7721) --> 
    cc(siden,_7719,_7721).

erdetdet([erdetdet,_7739,lit(det),_7774,_7798],_7728,_7730) --> 
    be(_7739,_7728,_7754),
    cc(det,_7754,_7773),
    that0(_7774,_7773,_7789),
    det0(_7798,_7789,_7730).

be_it_tf_that(_7702,[be_it_tf_that,_7766,lit(det),_7806,lit(ut),lit(til),lit(at)],_7752,_7754) --> 
    w(verb(see,_7724,fin),_7766,_7752,_7783),
    cc(det,_7783,_7805),
    negation0(_7702,_7806,_7805,_7823),
    cc(ut,_7823,_7845),
    cc(til,_7845,_7856),
    cc(at,_7856,_7754).

omaa([omaa,lit(om),lit(å),!],_7727,_7729) --> 
    cc(om,_7727,_7748),
    cc(å,_7748,_7729),
    !.

omaa([omaa,lit(å),!],_7722,_7724) --> 
    cc(å,_7722,_7724),
    !.

gadd([gadd,lit(vil)],_7719,_7721) --> 
    cc(vil,_7719,_7721).

hvormye([hvormye,lit(hvor),lit(mye)],_7724,_7726) --> 
    cc(hvor,_7724,_7745),
    cc(mye,_7745,_7726).

hvormye([hvormye,lit(hvor),lit(mange)],_7724,_7726) --> 
    cc(hvor,_7724,_7745),
    cc(mange,_7745,_7726).

hvormye([hvormye,lit(hvor),lit(meget)],_7724,_7726) --> 
    cc(hvor,_7724,_7745),
    cc(meget,_7745,_7726).

hvormye([hvormye,lit(hva)],_7719,_7721) --> 
    cc(hva,_7719,_7721).

whatcan([whatcan,lit(hva),lit(kan)],_7724,_7726) --> 
    cc(hva,_7724,_7745),
    cc(kan,_7745,_7726).

whatcan([whatcan,lit(hva),_7744],_7722,_7724) --> 
    cc(hva,_7722,_7743),
    aux1(_7744,_7743,_7724).

ompa([ompa,lit(om)],_7719,_7721) --> 
    cc(om,_7719,_7721).

ompa([ompa,_7732],_7721,_7723) --> 
    w(prep(on),_7732,_7721,_7723).

ompa([ompa,_7732],_7721,_7723) --> 
    w(prep(for),_7732,_7721,_7723).

hver0([hver0,lit(hvert),!],_7722,_7724) --> 
    cc(hvert,_7722,_7724),
    !.

hver0([hver0,lit(hver),!],_7722,_7724) --> 
    cc(hver,_7722,_7724),
    !.

hver0([hver0,[]],_7717,_7717) --> 
    [].

detå([detå,lit(det),_7747,!],_7725,_7727) --> 
    cc(det,_7725,_7746),
    infinitive(_7747,_7746,_7727),
    !.

detå([detå,lit(det),lit(og),!],_7727,_7729) --> 
    cc(det,_7727,_7748),
    cc(og,_7748,_7729),
    !.

detå([detå,lit(det),lit(for),_7763,!],_7730,_7732) --> 
    cc(det,_7730,_7751),
    cc(for,_7751,_7762),
    infinitive(_7763,_7762,_7732),
    !.

detå([detå,lit(det),lit(for),lit(og),!],_7732,_7734) --> 
    cc(det,_7732,_7753),
    cc(for,_7753,_7764),
    cc(og,_7764,_7734),
    !.

numberroute([numberroute,_7734,_7758,!],_7723,_7725) --> 
    optionalbus(_7734,_7723,_7749),
    num1(_7758,_7749,_7725),
    !.

numberroute([numberroute,_7731,!],_7720,_7722) --> 
    bus1(_7731,_7720,_7722),
    !.

optionalbus([optionalbus,_7735,_7759],_7724,_7726) --> 
    bus1(_7735,_7724,_7750),
    optional([nr],_7759,_7750,_7726).

optionalbus([optionalbus,_7728],_7717,_7719) --> 
    num1(_7728,_7717,_7719).

optionalbus([optionalbus,[]],_7717,_7717) --> 
    [].

num1([num1,_7741,_7770,!],_7730,_7732) --> 
    w(noun(number,sin,_7712,n),_7741,_7730,_7758),
    point0(_7770,_7758,_7732),
    !.

num1([num1,lit(nr),_7747,!],_7725,_7727) --> 
    cc(nr,_7725,_7746),
    point0(_7747,_7746,_7727),
    !.

bus1([bus1,_7735],_7724,_7726) --> 
    w(noun(route,sin,_7706,_7707),_7735,_7724,_7726).

bus1([bus1,_7735],_7724,_7726) --> 
    w(noun(bus,sin,_7706,_7707),_7735,_7724,_7726).

commas0([commas0,_7734,!,_7763],_7723,_7725) --> 
    comma(_7734,_7723,_7749),
    !,
    commas0(_7763,_7749,_7725).

commas0([commas0,[]],_7717,_7717) --> 
    [].

comma0([comma0,lit(','),!],_7722,_7724) --> 
    cc(',',_7722,_7724),
    !.

comma0([comma0,[]],_7717,_7717) --> 
    [].

comma([comma,lit(',')],_7719,_7721) --> 
    cc(',',_7719,_7721).

streetno([streetno,_7734,!,_7763],_7723,_7725) --> 
    a(_7734,_7723,_7749),
    !,
    reject(_7763,_7749,_7725).

streetno([streetno,lit(veg)],_7719,_7721) --> 
    cc(veg,_7719,_7721).

streetno([streetno,_7741,{}],_7730,_7732) --> 
    w(nb(_7707,num),_7741,_7730,_7732),
    {user:_7707<500}.

tilsiden([tilsiden,_7730],_7719,_7721) --> 
    prep1(to,_7730,_7719,_7721).

tilsiden([tilsiden,_7730],_7719,_7721) --> 
    prep1(before,_7730,_7719,_7721).

tilsiden([tilsiden,lit(siden)],_7719,_7721) --> 
    cc(siden,_7719,_7721).

hva([hva,lit(hva),!,_7752],_7725,_7727) --> 
    cc(hva,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

hva([hva,lit(hvor),_7750,!,_7779],_7728,_7730) --> 
    cc(hvor,_7728,_7749),
    meny(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

addressat0([addressat0,_7740,!,_7774],_7729,_7731) --> 
    w(name(tuc,n,_7712),_7740,_7729,_7757),
    !,
    accept(_7774,_7757,_7731).

addressat0([addressat0,_7740,!,_7774],_7729,_7731) --> 
    w(name(busstuc,n,_7712),_7740,_7729,_7757),
    !,
    accept(_7774,_7757,_7731).

addressat0([addressat0,_7740,!,_7774],_7729,_7731) --> 
    w(name(bustuc,n,_7712),_7740,_7729,_7757),
    !,
    accept(_7774,_7757,_7731).

addressat0([addressat0,_7740,!,_7774],_7729,_7731) --> 
    w(name(hal,n,_7712),_7740,_7729,_7757),
    !,
    accept(_7774,_7757,_7731).

addressat0([addressat0,[]],_7717,_7717) --> 
    [].

enn([enn,lit(enn)],_7719,_7721) --> 
    cc(enn,_7719,_7721).

enn([enn,lit(en)],_7719,_7721) --> 
    cc(en,_7719,_7721).

hatt0([hatt0,_7737,!],_7726,_7728) --> 
    w(verb(have,past,part),_7737,_7726,_7728),
    !.

hatt0([hatt0,[]],_7717,_7717) --> 
    [].

out0([out0,lit(ut),!,_7752],_7725,_7727) --> 
    cc(ut,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

out0([out0,lit(opp),!,_7752],_7725,_7727) --> 
    cc(opp,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

out0([out0,[]],_7717,_7717) --> 
    [].

a0([a0,_7728],_7717,_7719) --> 
    a(_7728,_7717,_7719).

a0([a0,[]],_7717,_7717) --> 
    [].

a([a,lit(ett),_7753],_7731,_7733) --> 
    cc(ett,_7731,_7752),
    not_look_ahead(w(noun(time,_7710,def,_7712)),_7753,_7752,_7733).

a([a,lit(noen),lit(av),!],_7727,_7729) --> 
    cc(noen,_7727,_7748),
    cc(av,_7748,_7729),
    !.

a([a,lit(noen),_7758,_7787,_7816],_7736,_7738) --> 
    cc(noen,_7736,_7757),
    not_look_ahead([av],_7758,_7757,_7775),
    not_look_ahead([de],_7787,_7775,_7804),
    look_ahead_np(_7816,_7804,_7738).

a([a,lit(noe),_7751,_7780],_7729,_7731) --> 
    cc(noe,_7729,_7750),
    not_look_ahead([de],_7751,_7750,_7768),
    look_ahead_np(_7780,_7768,_7731).

a([a,_7735,_7759],_7724,_7726) --> 
    art1(_7735,_7724,_7750),
    optional([slik],_7759,_7750,_7726).

art([art,_7728],_7717,_7719) --> 
    a(_7728,_7717,_7719).

art([art,_7736,lit(eller),_7771],_7725,_7727) --> 
    a(_7736,_7725,_7751),
    cc(eller,_7751,_7770),
    more(_7771,_7770,_7727).

art([art,lit(de)],_7719,_7721) --> 
    cc(de,_7719,_7721).

art([art,lit(all)],_7719,_7721) --> 
    cc(all,_7719,_7721).

art([art,_7741,lit(alt)],_7730,_7732) --> 
    not_look_ahead(w(name(_7711,_7712,_7713)),_7741,_7730,_7758),
    cc(alt,_7758,_7732).

art([art,_7738,{}],_7727,_7729) --> 
    every(_7738,_7727,_7729),
    {user:(\+value(textflag,true))}.

art1([art1,lit(en)],_7719,_7721) --> 
    cc(en,_7719,_7721).

art1([art1,lit(et)],_7719,_7721) --> 
    cc(et,_7719,_7721).

art1([art1,lit(ei)],_7719,_7721) --> 
    cc(ei,_7719,_7721).

allsome0([allsome0,lit(noen),lit(av)],_7724,_7726) --> 
    cc(noen,_7724,_7745),
    cc(av,_7745,_7726).

allsome0([allsome0,_7731,!],_7720,_7722) --> 
    all(_7731,_7720,_7722),
    !.

allsome0([allsome0,[]],_7717,_7717) --> 
    [].

all0([all0,_7731,!],_7720,_7722) --> 
    all(_7731,_7720,_7722),
    !.

all0([all0,[]],_7717,_7717) --> 
    [].

all([all,_7728],_7717,_7719) --> 
    every(_7728,_7717,_7719).

always([always,lit(alltid)],_7719,_7721) --> 
    cc(alltid,_7719,_7721).

always([always,_7743,_7772],_7732,_7734) --> 
    w(adj2(whole,nil),_7743,_7732,_7760),
    w(noun(time,sin,def,n),_7772,_7760,_7734).

and0([and0,_7734,!,_7763],_7723,_7725) --> 
    and1(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

and0([and0,[]],_7717,_7717) --> 
    [].

andor0([andor0,_7734,!,_7763],_7723,_7725) --> 
    andor(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

andor0([andor0,[]],_7717,_7717) --> 
    [].

andor([andor,lit(og),!],_7722,_7724) --> 
    cc(og,_7722,_7724),
    !.

andor([andor,lit(eller),!],_7722,_7724) --> 
    cc(eller,_7722,_7724),
    !.

betwand0([betwand0,lit(å),!],_7722,_7724) --> 
    cc(å,_7722,_7724),
    !.

betwand0([betwand0,lit(og),!],_7722,_7724) --> 
    cc(og,_7722,_7724),
    !.

betwand0([betwand0,_7735,!],_7724,_7726) --> 
    w(prep(to),_7735,_7724,_7726),
    !.

betwand0([betwand0,[]],_7717,_7717) --> 
    [].

and1([and1,lit(og)],_7719,_7721) --> 
    cc(og,_7719,_7721).

and1([and1,lit(men),_7750],_7728,_7730) --> 
    cc(men,_7728,_7749),
    look_ahead_lit([en,et],_7750,_7749,_7730).

vmod_conjunction([vmod_conjunction,lit(mao)],_7719,_7721) --> 
    cc(mao,_7719,_7721).

vmod_conjunction([vmod_conjunction,lit(men),_7750],_7728,_7730) --> 
    cc(men,_7728,_7749),
    not_look_ahead_lit([med,nå],_7750,_7749,_7730).

vmod_conjunction([vmod_conjunction,_7790,_7819,_7863,_7892,_7921,_7950,_7979],_7779,_7781) --> 
    one_of_lit([og,eller],_7790,_7779,_7807),
    optional([så],_7819,_7807,_7851),
    not_look_ahead_lit([da,så,nå],_7863,_7851,_7880),
    not_look_ahead(w(prep(in)),_7892,_7880,_7909),
    not_look_ahead(w([ikveld]),_7921,_7909,_7938),
    not_look_ahead(w([imorgen]),_7950,_7938,_7967),
    not_look_ahead(w(name(_7724,_7725,_7726)),_7979,_7967,_7781).

andwhen0([andwhen0,_7737,_7761,!,_7790],_7726,_7728) --> 
    and1(_7737,_7726,_7752),
    when(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

andwhen0([andwhen0,[]],_7717,_7717) --> 
    [].

andwhere0([andwhere0,_7742,_7766,_7795,!,_7824],_7731,_7733) --> 
    and1(_7742,_7731,_7757),
    prep1(from,_7766,_7757,_7783),
    where(_7795,_7783,_7810),
    !,
    accept(_7824,_7810,_7733).

andwhere0([andwhere0,_7737,_7761,!,_7790],_7726,_7728) --> 
    and1(_7737,_7726,_7752),
    where(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

andwhere0([andwhere0,_7739,lit(hvorfra),!,_7779],_7728,_7730) --> 
    and1(_7739,_7728,_7754),
    cc(hvorfra,_7754,_7773),
    !,
    accept(_7779,_7773,_7730).

andwhere0([andwhere0,[]],_7717,_7717) --> 
    [].

np_conjunction(_7702,[np_conjunction,_7751,lit(det),_7791,!,_7820],_7737,_7739) --> 
    andor(_7716,_7751,_7737,_7768),
    cc(det,_7768,_7790),
    look_ahead_vp(_7791,_7790,_7806),
    !,
    reject(_7820,_7806,_7739).

np_conjunction(_7702,[np_conjunction,_7762,_7791,_7820,_7849],_7748,_7750) --> 
    andor(_7702,_7762,_7748,_7779),
    not_look_ahead_lit([da,så],_7791,_7779,_7808),
    not_look_ahead(w(prep(_7729)),_7820,_7808,_7837),
    not_look_ahead(['.'],_7849,_7837,_7750).

andor0(_7702,[andor0,_7737],_7723,_7725) --> 
    andor(_7702,_7737,_7723,_7725).

andor0(and,[andor0,{}],_7729,_7729) --> 
    {user:value(textflag,true)}.

andor(and,[andor,_7761,_7785,_7814],_7747,_7749) --> 
    and1(_7761,_7747,_7776),
    not_look_ahead(['.'],_7785,_7776,_7802),
    not_look_ahead_lit([jeg,mange,ikke,ingen,noen,disse,dette],_7814,_7802,_7749).

andor(or,[andor,lit(eller),_7759],_7734,_7736) --> 
    cc(eller,_7734,_7758),
    not_look_ahead(w(verb(_7711,_7712,_7713)),_7759,_7758,_7736).

andor(and,[andor,{},_7762,!,_7791],_7738,_7740) --> 
    {user:value(teleflag,true)},
    art(_7762,_7738,_7777),
    !,
    reject(_7791,_7777,_7740).

andor(and,[andor,{}],_7729,_7729) --> 
    {user:value(teleflag,true)}.

also0([also0,lit(også),lit(samtidig),!],_7727,_7729) --> 
    cc(også,_7727,_7748),
    cc(samtidig,_7748,_7729),
    !.

also0([also0,lit(samtidig),lit(også),!],_7727,_7729) --> 
    cc(samtidig,_7727,_7748),
    cc(også,_7748,_7729),
    !.

also0([also0,lit(også),!],_7722,_7724) --> 
    cc(også,_7722,_7724),
    !.

also0([also0,lit(samtidig),!],_7722,_7724) --> 
    cc(samtidig,_7722,_7724),
    !.

also0([also0,lit(deretter),!],_7722,_7724) --> 
    cc(deretter,_7722,_7724),
    !.

also0([also0,[]],_7717,_7717) --> 
    [].

anaa([anaa,_7734,_7758,!],_7723,_7725) --> 
    ann0(_7734,_7723,_7749),
    ogaa(_7758,_7749,_7725),
    !.

ogaa([ogaa,lit(å)],_7719,_7721) --> 
    cc(å,_7719,_7721).

ogaa([ogaa,lit(og)],_7719,_7721) --> 
    cc(og,_7719,_7721).

ann0([ann0,lit(an),!,_7752],_7725,_7727) --> 
    cc(an,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

ann0([ann0,[]],_7717,_7717) --> 
    [].

anorder(a,_7703,[anorder,_7749,_7773],_7732,_7734) --> 
    a(_7749,_7732,_7764),
    w(nb(_7703,ord),_7773,_7764,_7734).

anorder(the,_7703,[anorder,_7749,_7773],_7732,_7734) --> 
    the(_7749,_7732,_7764),
    w(nb(_7703,ord),_7773,_7764,_7734).

another([another,_7731,_7755],_7720,_7722) --> 
    a(_7731,_7720,_7746),
    other(_7755,_7746,_7722).

around0([around0,_7728],_7717,_7719) --> 
    around1(_7728,_7717,_7719).

around0([around0,[]],_7717,_7717) --> 
    [].

around1([around1,_7728],_7717,_7719) --> 
    ca(_7728,_7717,_7719).

around1([around1,lit(om),lit(lag)],_7724,_7726) --> 
    cc(om,_7724,_7745),
    cc(lag,_7745,_7726).

around1([around1,_7730],_7719,_7721) --> 
    prep1(around,_7730,_7719,_7721).

as([as,lit(som)],_7719,_7721) --> 
    cc(som,_7719,_7721).

as0([as0,_7728],_7717,_7719) --> 
    as(_7728,_7717,_7719).

as0([as0,[]],_7717,_7717) --> 
    [].

andsoon([andsoon,lit(og),_7744],_7722,_7724) --> 
    cc(og,_7722,_7743),
    sovidere0(_7744,_7743,_7724).

sovidere0([sovidere0,_7731,_7755],_7720,_7722) --> 
    sov0(_7731,_7720,_7746),
    videre0(_7755,_7746,_7722).

sov0([sov0,lit(så)],_7719,_7721) --> 
    cc(så,_7719,_7721).

sov0([sov0,[]],_7717,_7717) --> 
    [].

videre0([videre0,lit(videre)],_7719,_7721) --> 
    cc(videre,_7719,_7721).

videre0([videre0,[]],_7717,_7717) --> 
    [].

aspossible0([aspossible0,_7734,!,_7763],_7723,_7725) --> 
    aspossible(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

aspossible0([aspossible0,_7728],_7717,_7719) --> 
    possible0(_7728,_7717,_7719).

aspossible([aspossible,_7736,_7760],_7725,_7727) --> 
    as(_7736,_7725,_7751),
    w(adj2(possible,nil),_7760,_7751,_7727).

aso0([aso0,lit(så),!,_7752],_7725,_7727) --> 
    cc(så,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

aso0([aso0,_7734,!,_7763],_7723,_7725) --> 
    too(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

aso0([aso0,_7728],_7717,_7719) --> 
    as(_7728,_7717,_7719).

aso0([aso0,[]],_7717,_7717) --> 
    [].

at([at,_7730],_7719,_7721) --> 
    prep(at,_7730,_7719,_7721).

athe([athe,_7728],_7717,_7719) --> 
    the(_7728,_7717,_7719).

athe([athe,_7728],_7717,_7719) --> 
    a(_7728,_7717,_7719).

athe0([athe0,_7731,!],_7720,_7722) --> 
    athe(_7731,_7720,_7722),
    !.

athe0([athe0,[]],_7717,_7717) --> 
    [].

blei(_7702,[blei,_7760,_7789,_7818,!],_7746,_7748) --> 
    w(verb(stand,pres,fin),_7760,_7746,_7777),
    negation0(_7702,_7789,_7777,_7806),
    look_ahead(w(verb(_7725,past,part)),_7818,_7806,_7748),
    !.

blei(_7702,[blei,_7740,_7764],_7726,_7728) --> 
    blei(_7740,_7726,_7755),
    negation0(_7702,_7764,_7755,_7728).

blei([blei,_7748,_7777,!],_7737,_7739) --> 
    w(verb(stand,pres,fin),_7748,_7737,_7765),
    look_ahead(w(verb(_7718,past,part)),_7777,_7765,_7739),
    !.

blei([blei,_7737,!],_7726,_7728) --> 
    w(verb(be,_7708,fin),_7737,_7726,_7728),
    !.

blei([blei,_7743,_7767,_7791,!],_7732,_7734) --> 
    has(_7743,_7732,_7758),
    redundant0(_7767,_7758,_7782),
    w(verb(be,past,part),_7791,_7782,_7734),
    !.

blei([blei,_7740,_7764,!],_7729,_7731) --> 
    aux1(_7740,_7729,_7755),
    w(verb(be,past,part),_7764,_7755,_7731),
    !.

blei([blei,_7740,_7764,!],_7729,_7731) --> 
    aux1(_7740,_7729,_7755),
    w(verb(be,inf,fin),_7764,_7755,_7731),
    !.

aux0(_7702,_7703,[aux0,_7747,!],_7730,_7732) --> 
    aux1(_7702,_7703,_7747,_7730,_7732),
    !.

aux0(id,pres,[aux0,_7741],_7724,_7726) --> 
    aux0(_7741,_7724,_7726).

auxs0(_7702,_7703,[auxs0,_7747,!],_7730,_7732) --> 
    aux1(_7702,_7703,_7747,_7730,_7732),
    !.

auxs0(_7702,_7703,[auxs0,[]],_7724,_7724) --> 
    [].

auxs([auxs,_7731,_7755],_7720,_7722) --> 
    aux1(_7731,_7720,_7746),
    auxs0(_7755,_7746,_7722).

auxs0([auxs0,_7734,!,_7763],_7723,_7725) --> 
    aux1(_7734,_7723,_7749),
    !,
    auxs0(_7763,_7749,_7725).

auxs0([auxs0,[]],_7717,_7717) --> 
    [].

aux1(_7702,pres,[aux1,lit(kan),_7776,_7800,_7829,!],_7748,_7750) --> 
    cc(kan,_7748,_7775),
    redundant0(_7776,_7775,_7791),
    negation0(_7702,_7800,_7791,_7817),
    look_ahead(w(verb(_7725,_7726,_7727)),_7829,_7817,_7750),
    !.

aux1(_7702,past,[aux1,lit(kunne),_7773,_7802,!],_7745,_7747) --> 
    cc(kunne,_7745,_7772),
    negation0(_7702,_7773,_7772,_7790),
    look_ahead(w(verb(_7722,_7723,_7724)),_7802,_7790,_7747),
    !.

aux1(_7702,past,[aux1,lit(burde),_7762,!],_7734,_7736) --> 
    cc(burde,_7734,_7761),
    negation0(_7702,_7762,_7761,_7736),
    !.

aux1(_7702,past,[aux1,lit(kunne),_7762,!],_7734,_7736) --> 
    cc(kunne,_7734,_7761),
    negation0(_7702,_7762,_7761,_7736),
    !.

aux1(_7702,pres,[aux1,_7746,_7770],_7729,_7731) --> 
    aux1(_7746,_7729,_7761),
    negation0(_7702,_7770,_7761,_7731).

skalsaa([skalsaa,_7731,_7755],_7720,_7722) --> 
    aux1(_7731,_7720,_7746),
    so0(_7755,_7746,_7722).

faux1([faux1,_7737,!],_7726,_7728) --> 
    w(verb(get,_7708,fin),_7737,_7726,_7728),
    !.

faux1([faux1,_7728],_7717,_7719) --> 
    aux1(_7728,_7717,_7719).

aux1([aux1,_7759,_7788,_7817,!],_7748,_7750) --> 
    one_of_lit([kan,kunne,får,fikk],_7759,_7748,_7776),
    not_look_ahead([nå],_7788,_7776,_7805),
    look_ahead(w(verb(_7729,inf,_7731)),_7817,_7805,_7750),
    !.

aux1([aux1,_7734],_7723,_7725) --> 
    one_of_lit([kan,kunne],_7734,_7723,_7725).

aux1([aux1,_7746],_7735,_7737) --> 
    one_of_lit([bør,burde,må,måtte,skal,skulle,vil,ville],_7746,_7735,_7737).

aux10([aux10,_7731,!],_7720,_7722) --> 
    aux1(_7731,_7720,_7722),
    !.

aux10([aux10,[]],_7717,_7717) --> 
    [].

aux0([aux0,_7742,_7766,!],_7731,_7733) --> 
    faa(_7742,_7731,_7757),
    look_ahead(w(verb(_7712,_7713,_7714)),_7766,_7757,_7733),
    !.

aux0([aux0,lit(må)],_7719,_7721) --> 
    cc(må,_7719,_7721).

aux0([aux0,_7752,lit(så),_7787,lit(å),!,_7832],_7741,_7743) --> 
    be(_7752,_7741,_7767),
    cc(så,_7767,_7786),
    w(adj2(good,nil),_7787,_7786,_7804),
    cc(å,_7804,_7826),
    !,
    accept(_7832,_7826,_7743).

aux0([aux0,_7728],_7717,_7719) --> 
    do(_7728,_7717,_7719).

aux0([aux0,[]],_7717,_7717) --> 
    [].

paux0([paux0,_7736,lit(blitt),!],_7725,_7727) --> 
    has(_7736,_7725,_7751),
    cc(blitt,_7751,_7727),
    !.

paux0([paux0,lit(vil),lit(bli),!],_7727,_7729) --> 
    cc(vil,_7727,_7748),
    cc(bli,_7748,_7729),
    !.

paux0([paux0,lit(_7707),{},!],_7750,_7752) --> 
    cc(_7707,_7750,_7752),
    {user:testmember(_7707,[skal,vil,bør,må,kan,skulle,ville,burde,måtte,kunne])},
    !.

paux0([paux0,[]],_7717,_7717) --> 
    [].

do(_7702,[do,_7743,_7767,_7796],_7729,_7731) --> 
    use(_7743,_7729,_7758),
    negation0(_7702,_7767,_7758,_7784),
    infinitive(_7796,_7784,_7731).

do(_7702,[do,_7743,_7767,_7796],_7729,_7731) --> 
    do(_7743,_7729,_7758),
    negation0(_7702,_7767,_7758,_7784),
    hasto0(_7796,_7784,_7731).

do(id,[do,[]],_7721,_7721) --> 
    [].

do0([do0,_7728],_7717,_7719) --> 
    do(_7728,_7717,_7719).

do0([do0,[]],_7717,_7717) --> 
    [].

docan([docan,lit(kan)],_7719,_7721) --> 
    cc(kan,_7719,_7721).

docan([docan,lit(må)],_7719,_7721) --> 
    cc(må,_7719,_7721).

docan([docan,lit(får)],_7719,_7721) --> 
    cc(får,_7719,_7721).

docan([docan,_7731,!],_7720,_7722) --> 
    do(_7731,_7720,_7722),
    !.

do([do,_7744,_7768,!,_7802],_7733,_7735) --> 
    faa(_7744,_7733,_7759),
    w(noun(information,_7714,_7715,_7716),_7768,_7759,_7785),
    !,
    reject(_7802,_7785,_7735).

do([do,lit(vil),lit(vil),!,_7768],_7730,_7732) --> 
    cc(vil,_7730,_7751),
    cc(vil,_7751,_7762),
    !,
    accept(_7768,_7762,_7732).

do([do,_7728],_7717,_7719) --> 
    skalsaa(_7728,_7717,_7719).

do([do,_7728],_7717,_7719) --> 
    may(_7728,_7717,_7719).

do([do,_7728],_7717,_7719) --> 
    must(_7728,_7717,_7719).

may([may,lit(kan),_7752],_7730,_7732) --> 
    cc(kan,_7730,_7751),
    look_ahead(w(verb(_7709,_7710,_7711)),_7752,_7751,_7732).

may([may,lit(får),_7752],_7730,_7732) --> 
    cc(får,_7730,_7751),
    look_ahead(w(verb(_7709,_7710,_7711)),_7752,_7751,_7732).

may([may,lit(bør)],_7719,_7721) --> 
    cc(bør,_7719,_7721).

may([may,lit(må)],_7719,_7721) --> 
    cc(må,_7719,_7721).

must([must,lit(må)],_7719,_7721) --> 
    cc(må,_7719,_7721).

must([must,lit(skal)],_7719,_7721) --> 
    cc(skal,_7719,_7721).

be(_7702,[be,_7766,_7795,_7824,!,_7853,{}],_7752,_7754) --> 
    w(verb(hold,_7728,fin),_7766,_7752,_7783),
    negation0(_7721,_7795,_7783,_7812),
    rfxpron(_7824,_7812,_7839),
    !,
    negation0(_7722,_7853,_7839,_7754),
    {user:bigno(_7721,_7722,_7702)}.

be(_7702,[be,_7743,!,_7777],_7729,_7731) --> 
    be1(_7702,_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

be(not,[be,_7738,_7762],_7724,_7726) --> 
    not(_7738,_7724,_7753),
    be(_7762,_7753,_7726).

be(id,[be,_7735],_7721,_7723) --> 
    be(_7735,_7721,_7723).

be0([be0,_7730],_7719,_7721) --> 
    optional(be,_7730,_7719,_7721).

be([be,_7740,_7764,!],_7729,_7731) --> 
    aux1(_7740,_7729,_7755),
    w(verb(be,inf,fin),_7764,_7755,_7731),
    !.

be([be,_7749,_7778,_7802,!],_7738,_7740) --> 
    w(verb(have,_7714,fin),_7749,_7738,_7766),
    redundant0(_7778,_7766,_7793),
    w(verb(be,past,part),_7802,_7793,_7740),
    !.

be([be,_7737,!],_7726,_7728) --> 
    w(verb(be,_7708,part),_7737,_7726,_7728),
    !.

be([be,_7740,_7769,!],_7729,_7731) --> 
    w(verb(be,_7711,fin),_7740,_7729,_7757),
    been0(_7769,_7757,_7731),
    !.

be1(_7702,[be1,_7749,_7778,_7802],_7735,_7737) --> 
    w(verb(be,_7715,fin),_7749,_7735,_7766),
    redundant0(_7778,_7766,_7793),
    negation0(_7702,_7802,_7793,_7737).

be1(_7702,[be1,_7752,_7776,_7800,_7829],_7738,_7740) --> 
    aux1(_7752,_7738,_7767),
    redundant0(_7776,_7767,_7791),
    negation0(_7702,_7800,_7791,_7817),
    w(verb(be,inf,fin),_7829,_7817,_7740).

be1(_7702,[be1,_7758,_7787,_7811,_7845,!],_7744,_7746) --> 
    negation0(_7716,_7758,_7744,_7775),
    aux1(_7787,_7775,_7802),
    negation2(_7716,_7702,_7811,_7802,_7830),
    w(verb(be,inf,fin),_7845,_7830,_7746),
    !.

be1(_7702,[be1,_7758,_7787,_7816,!],_7744,_7746) --> 
    w(verb(have,_7716,fin),_7758,_7744,_7775),
    negation0(_7702,_7787,_7775,_7804),
    w(verb(be,past,part),_7816,_7804,_7746),
    !.

be1(_7702,[be1,_7749,_7778,_7802,_7826],_7735,_7737) --> 
    negation0(_7713,_7749,_7735,_7766),
    be(_7778,_7766,_7793),
    redundant0(_7802,_7793,_7817),
    negation2(_7713,_7702,_7826,_7817,_7737).

be1(_7702,[be1,_7751,_7780,lit(blitt)],_7737,_7739) --> 
    w(verb(have,_7715,fin),_7751,_7737,_7768),
    negation0(_7702,_7780,_7768,_7797),
    cc(blitt,_7797,_7739).

be1(id,[be1,lit(blitt)],_7723,_7725) --> 
    cc(blitt,_7723,_7725).

be1(not,[be1,_7749,_7778,_7807],_7735,_7737) --> 
    w(verb(reject,_7713,fin),_7749,_7735,_7766),
    prep(to,_7778,_7766,_7795),
    be(_7807,_7795,_7737).

be_truefalse_that(_7702,[be_truefalse_that,_7769,{},_7808,lit(ut),_7848,!],_7755,_7757) --> 
    w(verb(_7721,_7722,fin),_7769,_7755,_7786),
    {user:testmember(_7721,[look,see])},
    negation0(_7702,_7808,_7786,_7825),
    cc(ut,_7825,_7847),
    somatom0(_7848,_7847,_7757),
    !.

be_truefalse_that(_7702,[be_truefalse_that,_7769,{},_7808,lit(ut),_7848,!],_7755,_7757) --> 
    w(verb(_7721,_7722,fin),_7769,_7755,_7786),
    {user:testmember(_7721,[look,see])},
    negation0(_7702,_7808,_7786,_7825),
    cc(ut,_7825,_7847),
    somatom0(_7848,_7847,_7757),
    !.

be_truefalse_that(_7702,[be_truefalse_that,_7764,{},_7803,_7832,!],_7750,_7752) --> 
    w(verb(_7718,_7719,fin),_7764,_7750,_7781),
    {user:testmember(_7718,[appear,be])},
    negation0(_7702,_7803,_7781,_7820),
    somatom0(_7832,_7820,_7752),
    !.

somatom0([somatom0,_7731,!],_7720,_7722) --> 
    somatom(_7731,_7720,_7722),
    !.

somatom0([somatom0,[]],_7717,_7717) --> 
    [].

somatom([somatom,_7741,lit(at),!],_7730,_7732) --> 
    w(adj2(true,nil),_7741,_7730,_7758),
    cc(at,_7758,_7732),
    !.

somatom([somatom,lit(som),lit(at),!],_7727,_7729) --> 
    cc(som,_7727,_7748),
    cc(at,_7748,_7729),
    !.

somatom([somatom,lit(som),lit(om),!],_7727,_7729) --> 
    cc(som,_7727,_7748),
    cc(om,_7748,_7729),
    !.

somatom([somatom,lit(som)],_7719,_7721) --> 
    cc(som,_7719,_7721).

somatom([somatom,lit(at)],_7719,_7721) --> 
    cc(at,_7719,_7721).

somatom([somatom,lit(til),lit(at),!],_7727,_7729) --> 
    cc(til,_7727,_7748),
    cc(at,_7748,_7729),
    !.

somatom([somatom,lit(til)],_7719,_7721) --> 
    cc(til,_7719,_7721).

be_truefalse_that(_7702,[be_truefalse_that,_7766,_7795,_7829,_7858,!],_7752,_7754) --> 
    w(verb(_7718,_7719,fin),_7766,_7752,_7783),
    gmem(_7718,[agree,appear],_7795,_7783,_7814),
    negation0(_7702,_7829,_7814,_7846),
    optional([at],_7858,_7846,_7754),
    !.

be_truefalse_that(_7702,[be_truefalse_that,_7756,_7785,_7814,!],_7742,_7744) --> 
    negation0(_7702,_7756,_7742,_7773),
    one_of_lit([så,slik],_7785,_7773,_7802),
    optional([at],_7814,_7802,_7744),
    !.

be_truefalse_that(id,[be_truefalse_that,_7756,_7785,lit(at),!],_7742,_7744) --> 
    w(verb(show,_7716,fin),_7756,_7742,_7773),
    optional([seg],_7785,_7773,_7817),
    cc(at,_7817,_7744),
    !.

be_truefalse_that(_7702,[be_truefalse_that,_7769,{},_7808,lit(ut),_7848,!],_7755,_7757) --> 
    w(verb(_7721,_7722,fin),_7769,_7755,_7786),
    {user:testmember(_7721,[see,look])},
    negation0(_7702,_7808,_7786,_7825),
    cc(ut,_7825,_7847),
    somatom(_7848,_7847,_7757),
    !.

be_truefalse_that(_7702,[be_truefalse_that,_7764,{},_7803,_7832,!],_7750,_7752) --> 
    w(verb(_7718,_7719,fin),_7764,_7750,_7781),
    {user:testmember(_7718,[be,appear])},
    negation0(_7702,_7803,_7781,_7820),
    somatom(_7832,_7820,_7752),
    !.

be_truefalse_that(_7702,[be_truefalse_that,_7747,_7776,!],_7733,_7735) --> 
    be_truefalse(_7702,_7747,_7733,_7764),
    optional([at],_7776,_7764,_7735),
    !.

be_truefalse(_7702,[be_truefalse,_7764,{},_7803,_7832,!],_7750,_7752) --> 
    w(verb(_7718,_7719,fin),_7764,_7750,_7781),
    {user:testmember(_7718,[be,appear])},
    negation0(_7702,_7803,_7781,_7820),
    somatom(_7832,_7820,_7752),
    !.

be_truefalse(_7702,[be_truefalse,_7756,_7805,!],_7742,_7744) --> 
    lexvaccept(rv,_7711,_7712,fin,_7702,_7756,_7742,_7781),
    gmem(_7711,[stand,mean2,indicate],_7805,_7781,_7744),
    !.

be_truefalse(_7702,[be_truefalse,_7771,{},_7810,lit(ut),lit(til),!],_7757,_7759) --> 
    w(verb(_7721,_7722,fin),_7771,_7757,_7788),
    {user:testmember(_7721,[see,look])},
    negation0(_7702,_7810,_7788,_7827),
    cc(ut,_7827,_7849),
    cc(til,_7849,_7759),
    !.

be_truefalse(_7702,[be_truefalse,_7771,{},_7810,lit(ut),lit(for),!],_7757,_7759) --> 
    w(verb(_7721,_7722,fin),_7771,_7757,_7788),
    {user:testmember(_7721,[see,look])},
    negation0(_7702,_7810,_7788,_7827),
    cc(ut,_7827,_7849),
    cc(for,_7849,_7759),
    !.

be_truefalse(_7702,[be_truefalse,_7771,{},_7810,lit(ut),lit(som),!],_7757,_7759) --> 
    w(verb(_7721,_7722,fin),_7771,_7757,_7788),
    {user:testmember(_7721,[see,look])},
    negation0(_7702,_7810,_7788,_7827),
    cc(ut,_7827,_7849),
    cc(som,_7849,_7759),
    !.

be_truefalse(_7702,[be_truefalse,_7749,!,_7783],_7735,_7737) --> 
    w(verb(agree,_7715,fin),_7749,_7735,_7766),
    !,
    negation0(_7702,_7783,_7766,_7737).

be_truefalse(_7702,[be_truefalse,_7740,_7764],_7726,_7728) --> 
    be(_7740,_7726,_7755),
    truefalse(_7702,_7764,_7755,_7728).

be_truefalse(not,[be_truefalse,_7750,_7779,_7803,_7827],_7736,_7738) --> 
    w(verb(reject,_7716,fin),_7750,_7736,_7767),
    infinitive(_7779,_7767,_7794),
    be(_7803,_7794,_7818),
    true(_7827,_7818,_7738).

been0([been0,_7734,!,_7763],_7723,_7725) --> 
    been(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

been0([been0,[]],_7717,_7717) --> 
    [].

been([been,_7734],_7723,_7725) --> 
    w(verb(be,past,part),_7734,_7723,_7725).

betake([betake,_7728],_7717,_7719) --> 
    be(_7728,_7717,_7719).

betake([betake,_7734],_7723,_7725) --> 
    w(verb(take,_7705,fin),_7734,_7723,_7725).

both0([both0,lit(både)],_7719,_7721) --> 
    cc(både,_7719,_7721).

both0([both0,[]],_7717,_7717) --> 
    [].

by([by,lit(av),_7748],_7726,_7728) --> 
    cc(av,_7726,_7747),
    not_look_ahead([hensyn],_7748,_7747,_7728).

ca0([ca0,_7734,!,_7763],_7723,_7725) --> 
    ca(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

ca0([ca0,[]],_7717,_7717) --> 
    [].

ca([ca,_7739,_7768,!,_7797],_7728,_7730) --> 
    prep1(around,_7739,_7728,_7756),
    point0(_7768,_7756,_7783),
    !,
    accept(_7797,_7783,_7730).

clock0([clock0,_7728],_7717,_7719) --> 
    clock(_7728,_7717,_7719).

clock0([clock0,[]],_7717,_7717) --> 
    [].

clock([clock,lit(k),_7754,!],_7732,_7734) --> 
    cc(k,_7732,_7753),
    look_ahead(w(nb(_7714,_7715)),_7754,_7753,_7734),
    !.

clock([clock,lit(k),_7757,_7781,!],_7735,_7737) --> 
    cc(k,_7735,_7756),
    point(_7757,_7756,_7772),
    look_ahead(w(nb(_7717,_7718)),_7781,_7772,_7737),
    !.

clock([clock,lit(kl),_7747,!],_7725,_7727) --> 
    cc(kl,_7725,_7746),
    colon(_7747,_7746,_7727),
    !.

clock([clock,_7737,_7761,_7785,_7809],_7726,_7728) --> 
    point0(_7737,_7726,_7752),
    klokken(_7761,_7752,_7776),
    point0(_7785,_7776,_7800),
    ca0(_7809,_7800,_7728).

clock([clock,_7734,_7758,_7782],_7723,_7725) --> 
    point0(_7734,_7723,_7749),
    klokken(_7758,_7749,_7773),
    colon0(_7782,_7773,_7725).

klokken([klokken,lit(kl)],_7719,_7721) --> 
    cc(kl,_7719,_7721).

klokken([klokken,_7735],_7724,_7726) --> 
    w(noun(clock,sin,_7706,n),_7735,_7724,_7726).

colon0([colon0,_7734,!,_7763],_7723,_7725) --> 
    colon(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

colon0([colon0,_7732],_7721,_7723) --> 
    not_look_ahead(['.'],_7732,_7721,_7723).

colon([colon,lit(:)],_7719,_7721) --> 
    cc(:,_7719,_7721).

colon([colon,lit(;)],_7719,_7721) --> 
    cc(;,_7719,_7721).

comparator1(_7702,[comparator1,_7740,!],_7726,_7728) --> 
    comparel(_7702,_7740,_7726,_7728),
    !.

comparel(eq,[comparel,_7738,_7762],_7724,_7726) --> 
    equal(_7738,_7724,_7753),
    tomed0(_7762,_7753,_7726).

comparel(ge,[comparel,_7747,_7771,_7795,_7819,_7843],_7733,_7735) --> 
    greater(_7747,_7733,_7762),
    than0(_7771,_7762,_7786),
    or1(_7795,_7786,_7810),
    equal(_7819,_7810,_7834),
    to0(_7843,_7834,_7735).

comparel(ge,[comparel,_7741,_7765,_7789],_7727,_7729) --> 
    not(_7741,_7727,_7756),
    less(_7765,_7756,_7780),
    than(_7789,_7780,_7729).

comparel(ge,[comparel,lit(minst)],_7723,_7725) --> 
    cc(minst,_7723,_7725).

comparel(gt,[comparel,_7738,_7762],_7724,_7726) --> 
    greater(_7738,_7724,_7753),
    than(_7762,_7753,_7726).

comparel(gt,[comparel,lit(mer),_7751],_7726,_7728) --> 
    cc(mer,_7726,_7750),
    than(_7751,_7750,_7728).

comparel(gt,[comparel,_7737],_7723,_7725) --> 
    prep1(over,_7737,_7723,_7725).

comparel(le,[comparel,_7747,_7771,_7795,_7819,_7843],_7733,_7735) --> 
    less(_7747,_7733,_7762),
    than0(_7771,_7762,_7786),
    or1(_7795,_7786,_7810),
    equal(_7819,_7810,_7834),
    to0(_7843,_7834,_7735).

comparel(le,[comparel,_7741,_7765,_7789],_7727,_7729) --> 
    not(_7741,_7727,_7756),
    more(_7765,_7756,_7780),
    than(_7789,_7780,_7729).

comparel(le,[comparel,_7741,_7765,_7789],_7727,_7729) --> 
    not(_7741,_7727,_7756),
    greater(_7765,_7756,_7780),
    than(_7789,_7780,_7729).

comparel(le,[comparel,_7738,_7762],_7724,_7726) --> 
    at(_7738,_7724,_7753),
    most(_7762,_7753,_7726).

comparel(lt,[comparel,_7738,_7762],_7724,_7726) --> 
    less(_7738,_7724,_7753),
    than(_7762,_7753,_7726).

comparel(ne,[comparel,lit(forskjellig),_7753],_7728,_7730) --> 
    cc(forskjellig,_7728,_7752),
    prep1(from,_7753,_7752,_7730).

comparel(ne,[comparel,lit(annet),lit(enn)],_7728,_7730) --> 
    cc(annet,_7728,_7752),
    cc(enn,_7752,_7730).

comparel(ne,[comparel,lit(ulik)],_7723,_7725) --> 
    cc(ulik,_7723,_7725).

comparel(ne,[comparel,lit(unntatt)],_7723,_7725) --> 
    cc(unntatt,_7723,_7725).

comparel(ne,[comparel,_7738,_7762],_7724,_7726) --> 
    unequal(_7738,_7724,_7753),
    to0(_7762,_7753,_7726).

comparel(_7702,[comparel,_7745,lit(enn)],_7731,_7733) --> 
    w(adj2(_7702,comp),_7745,_7731,_7762),
    cc(enn,_7762,_7733).

comparel(_7702,[comparel,lit(mer),_7761,lit(enn)],_7736,_7738) --> 
    cc(mer,_7736,_7760),
    w(adj2(_7702,nil),_7761,_7760,_7778),
    cc(enn,_7778,_7738).

comparator2(gt,intelligent,[comparator2,_7749,_7778],_7732,_7734) --> 
    w(adj2(intelligent,nil),_7749,_7732,_7766),
    than(_7778,_7766,_7734).

comparator2(lt,intelligent,[comparator2,_7749,_7778],_7732,_7734) --> 
    w(adj2(stupid,nil),_7749,_7732,_7766),
    than(_7778,_7766,_7734).

comparator2(gt,quality,[comparator2,_7749,_7778],_7732,_7734) --> 
    w(adj2(good,comp),_7749,_7732,_7766),
    than(_7778,_7766,_7734).

comparator2(gt,age,[comparator2,_7744,_7768],_7727,_7729) --> 
    older(_7744,_7727,_7759),
    than(_7768,_7759,_7729).

comparator2(lt,age,[comparator2,_7744,_7768],_7727,_7729) --> 
    younger(_7744,_7727,_7759),
    than(_7768,_7759,_7729).

comparator2(gt,latitude,[comparator2,lit(nord),lit(for)],_7731,_7733) --> 
    cc(nord,_7731,_7758),
    cc(for,_7758,_7733).

comparator2(lt,latitude,[comparator2,lit(sør),lit(for)],_7731,_7733) --> 
    cc(sør,_7731,_7758),
    cc(for,_7758,_7733).

comparator2(gt,longitude,[comparator2,lit(vest),lit(for)],_7731,_7733) --> 
    cc(vest,_7731,_7758),
    cc(for,_7758,_7733).

comparator2(lt,longitude,[comparator2,lit(øst),lit(for)],_7731,_7733) --> 
    cc(øst,_7731,_7758),
    cc(for,_7758,_7733).

comparator2(gt,size,[comparator2,_7744,_7768],_7727,_7729) --> 
    greater(_7744,_7727,_7759),
    than(_7768,_7759,_7729).

comparator2(lt,size,[comparator2,lit(mindre),_7757],_7729,_7731) --> 
    cc(mindre,_7729,_7756),
    than(_7757,_7756,_7731).

comparator3(eq,_7703,[comparator3,lit(like),_7767,lit(som)],_7739,_7741) --> 
    cc(like,_7739,_7766),
    w(adj2(_7703,nil),_7767,_7766,_7784),
    cc(som,_7784,_7741).

comparator3(gt,_7703,[comparator3,lit(mer),_7767,lit(enn)],_7739,_7741) --> 
    cc(mer,_7739,_7766),
    w(adj2(_7703,nil),_7767,_7766,_7784),
    cc(enn,_7784,_7741).

comparator3(lt,_7703,[comparator3,lit(mindre),_7767,lit(enn)],_7739,_7741) --> 
    cc(mindre,_7739,_7766),
    w(adj2(_7703,nil),_7767,_7766,_7784),
    cc(enn,_7784,_7741).

comparator3(lt,_7703,[comparator3,lit(ikke),lit(så),_7783,lit(som)],_7744,_7746) --> 
    cc(ikke,_7744,_7771),
    cc(så,_7771,_7782),
    w(adj2(_7703,nil),_7783,_7782,_7800),
    cc(som,_7800,_7746).

comparator3(ge,_7703,[comparator3,lit(minst),lit(like),_7783,lit(som)],_7744,_7746) --> 
    cc(minst,_7744,_7771),
    cc(like,_7771,_7782),
    w(adj2(_7703,nil),_7783,_7782,_7800),
    cc(som,_7800,_7746).

comparator3(le,_7703,[comparator3,lit(høyst),lit(så),_7783,lit(som)],_7744,_7746) --> 
    cc(høyst,_7744,_7771),
    cc(så,_7771,_7782),
    w(adj2(_7703,nil),_7783,_7782,_7800),
    cc(som,_7800,_7746).

superlative(_7702,_7703,[superlative,_7756,_7795,!,_7829],_7739,_7741) --> 
    filanepr(_7702,_7715,_7703,_7756,_7739,_7777),
    quant1(_7715,_7795,_7777,_7812),
    !,
    accept(_7829,_7812,_7741).

superlative(_7702,_7703,[superlative,_7750,_7779],_7733,_7735) --> 
    quant0(_7709,_7750,_7733,_7767),
    filanepr(_7702,_7709,_7703,_7779,_7767,_7735).

flnp(_7702,[flnp,_7754,_7783],_7740,_7742) --> 
    w(adj2(_7702,nil),_7754,_7740,_7771),
    gmem(_7702,[first,last,next,previous],_7783,_7771,_7742).

flnp(next,[flnp,lit(nest)],_7723,_7725) --> 
    cc(nest,_7723,_7725).

flnp(last,[flnp,_7743,!],_7729,_7731) --> 
    w(adj2(late,sup),_7743,_7729,_7731),
    !.

flnp(first,[flnp,_7740],_7726,_7728) --> 
    w(nb(1,ord),_7740,_7726,_7728).

flnpproper(_7702,[flnpproper,lit(først),!,_7759],_7729,_7731) --> 
    cc(først,_7729,_7753),
    !,
    reject(_7759,_7753,_7731).

flnpproper(_7702,[flnpproper,lit(sist),!,_7759],_7729,_7731) --> 
    cc(sist,_7729,_7753),
    !,
    reject(_7759,_7753,_7731).

flnpproper(_7702,[flnpproper,lit(nest),!,_7759],_7729,_7731) --> 
    cc(nest,_7729,_7753),
    !,
    reject(_7759,_7753,_7731).

flnpproper(_7702,[flnpproper,_7737],_7723,_7725) --> 
    flnp(_7702,_7737,_7723,_7725).

filanepr([filanepr,_7736,!],_7725,_7727) --> 
    w(adj2(first,nil),_7736,_7725,_7727),
    !.

filanepr([filanepr,_7736,!],_7725,_7727) --> 
    w(adj2(last,nil),_7736,_7725,_7727),
    !.

filanepr([filanepr,_7736,!],_7725,_7727) --> 
    w(adj2(next,nil),_7736,_7725,_7727),
    !.

filanepr([filanepr,_7736,!],_7725,_7727) --> 
    w(adj2(previous,nil),_7736,_7725,_7727),
    !.

filanepr(min(_7703),_7703,time,[filanepr,_7749],_7729,_7731) --> 
    first(_7749,_7729,_7731).

filanepr(max(_7703),_7703,time,[filanepr,_7749],_7729,_7731) --> 
    latest(_7749,_7729,_7731).

filanepr(min(_7703),_7703,next,[filanepr,_7749],_7729,_7731) --> 
    next(_7749,_7729,_7731).

filanepr(max(_7703),_7703,previous,[filanepr,_7749],_7729,_7731) --> 
    previous(_7749,_7729,_7731).

filanepr(max(_7703),_7703,size,[filanepr,_7749],_7729,_7731) --> 
    greatest(_7749,_7729,_7731).

filanepr(min(_7703),_7703,size,[filanepr,lit(minste)],_7731,_7733) --> 
    cc(minste,_7731,_7733).

faaverb(_7702,[faaverb,_7747,_7771,!],_7733,_7735) --> 
    faa(_7747,_7733,_7762),
    w(verb(_7702,_7713,_7714),_7771,_7762,_7735),
    !.

faaverb(_7702,[faaverb,_7744,!],_7730,_7732) --> 
    w(verb(_7702,inf,fin),_7744,_7730,_7732),
    !.

da0([da0,lit(da),!,_7752],_7725,_7727) --> 
    cc(da,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

da0([da0,[]],_7717,_7717) --> 
    [].

de0([de0,lit(de),!,_7752],_7725,_7727) --> 
    cc(de,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

de0([de0,[]],_7717,_7717) --> 
    [].

dendagen(_7702,[dendagen,lit(om),_7762,_7791,!,_7820],_7737,_7739) --> 
    cc(om,_7737,_7761),
    day(_7702,_7762,_7761,_7779),
    den0(_7791,_7779,_7806),
    !,
    accept(_7820,_7806,_7739).

dendagen(nil,[dendagen,_7744,_7768,!,_7797],_7730,_7732) --> 
    today(_7744,_7730,_7759),
    den0(_7768,_7759,_7783),
    !,
    accept(_7797,_7783,_7732).

dendagen(nil,[dendagen,_7744,_7768,!,_7797],_7730,_7732) --> 
    yesterday(_7744,_7730,_7759),
    den0(_7768,_7759,_7783),
    !,
    accept(_7797,_7783,_7732).

dendagen(nil,[dendagen,_7744,_7768,!,_7797],_7730,_7732) --> 
    tomorrow(_7744,_7730,_7759),
    den0(_7768,_7759,_7783),
    !,
    accept(_7797,_7783,_7732).

dendagen(_7702,[dendagen,_7749,_7773,_7802,!,_7831],_7735,_7737) --> 
    on0(_7749,_7735,_7764),
    day(_7702,_7773,_7764,_7790),
    den0(_7802,_7790,_7817),
    !,
    accept(_7831,_7817,_7737).

dendagen(nil,[dendagen,_7746,lit(den),!,_7786],_7732,_7734) --> 
    on0(_7746,_7732,_7761),
    cc(den,_7761,_7780),
    !,
    accept(_7786,_7780,_7734).

dendagen(nil,[dendagen,_7746,_7775,!,_7804],_7732,_7734) --> 
    prep1(for,_7746,_7732,_7763),
    den0(_7775,_7763,_7790),
    !,
    accept(_7804,_7790,_7734).

dendagen(nil,[dendagen,_7743,!,_7777],_7729,_7731) --> 
    prep1(on,_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

der0([der0,lit(der),_7750,!,_7779],_7728,_7730) --> 
    cc(der,_7728,_7749),
    qm0(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

der0([der0,_7728],_7717,_7719) --> 
    qm0(_7728,_7717,_7719).

qm0([qm0,lit(?)],_7719,_7721) --> 
    cc(?,_7719,_7721).

qm0([qm0,[]],_7717,_7717) --> 
    [].

detsamme([detsamme,lit(en),lit(gang)],_7724,_7726) --> 
    cc(en,_7724,_7745),
    cc(gang,_7745,_7726).

detsamme([detsamme,_7740,lit(det),lit(samme)],_7729,_7731) --> 
    prep1(with,_7740,_7729,_7757),
    cc(det,_7757,_7779),
    cc(samme,_7779,_7731).

den0([den0,_7731,!],_7720,_7722) --> 
    den(_7731,_7720,_7722),
    !.

den0([den0,[]],_7717,_7717) --> 
    [].

den([den,lit(den)],_7719,_7721) --> 
    cc(den,_7719,_7721).

dendet0([dendet0,_7735,!],_7724,_7726) --> 
    look_ahead([d],_7735,_7724,_7726),
    !.

dendet0([dendet0,lit(den),_7757,!,_7791],_7735,_7737) --> 
    cc(den,_7735,_7756),
    not_look_ahead(w(nb(_7717,_7718)),_7757,_7756,_7774),
    !,
    accept(_7791,_7774,_7737).

dendet0([dendet0,lit(det),!,_7752],_7725,_7727) --> 
    cc(det,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

dendet0([dendet0,[]],_7717,_7717) --> 
    [].

dent0([dent0,lit(den),!],_7722,_7724) --> 
    cc(den,_7722,_7724),
    !.

dent0([dent0,lit(det),!],_7722,_7724) --> 
    cc(det,_7722,_7724),
    !.

dent0([dent0,lit(de),!,_7752],_7725,_7727) --> 
    cc(de,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

dent0([dent0,lit(noen),!],_7722,_7724) --> 
    cc(noen,_7722,_7724),
    !.

dent0([dent0,lit(en),!],_7722,_7724) --> 
    cc(en,_7722,_7724),
    !.

dent0([dent0,[]],_7717,_7717) --> 
    [].

det0([det0,_7737,_7761,!,_7790],_7726,_7728) --> 
    thereit(_7737,_7726,_7752),
    thereit_not_pronoun(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

det0([det0,[]],_7717,_7717) --> 
    [].

dudet([dudet,lit(du)],_7719,_7721) --> 
    cc(du,_7719,_7721).

dudet([dudet,lit(det)],_7719,_7721) --> 
    cc(det,_7719,_7721).

dudet([dudet,_7730],_7719,_7721) --> 
    pronoun(_7702,_7730,_7719,_7721).

each([each,lit(alle),_7744],_7722,_7724) --> 
    cc(alle,_7722,_7743),
    the(_7744,_7743,_7724).

earlier([earlier,lit(tidligere)],_7719,_7721) --> 
    cc(tidligere,_7719,_7721).

earlier([earlier,_7735,lit(forhånd)],_7724,_7726) --> 
    prep1(on,_7735,_7724,_7752),
    cc(forhånd,_7752,_7726).

earlier([earlier,lit(derfør)],_7719,_7721) --> 
    cc(derfør,_7719,_7721).

either0([either0,lit(enten),!,_7752],_7725,_7727) --> 
    cc(enten,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

either0([either0,[]],_7717,_7717) --> 
    [].

equal([equal,lit(lik)],_7719,_7721) --> 
    cc(lik,_7719,_7721).

equal([equal,lit(likt)],_7719,_7721) --> 
    cc(likt,_7719,_7721).

iyou(du,[iyou,lit(du)],_7723,_7725) --> 
    cc(du,_7723,_7725).

iyou(jeg,[iyou,lit(jeg)],_7723,_7725) --> 
    cc(jeg,_7723,_7725).

iyou(vi,[iyou,lit(vi)],_7723,_7725) --> 
    cc(vi,_7723,_7725).

areyou([areyou,lit(erru),_7746],_7724,_7726) --> 
    cc(erru,_7724,_7745),
    negation0(_7705,_7746,_7745,_7726).

areyou([areyou,_7744,lit(du),_7784],_7733,_7735) --> 
    w(verb(be,_7713,fin),_7744,_7733,_7761),
    cc(du,_7761,_7783),
    negation0(_7708,_7784,_7783,_7735).

areyou([areyou,lit(vil),lit(du),_7771,_7800],_7738,_7740) --> 
    cc(vil,_7738,_7759),
    cc(du,_7759,_7770),
    negation0(_7721,_7771,_7770,_7788),
    w(verb(be,_7714,fin),_7800,_7788,_7740).

every([every,lit(alle),_7744],_7722,_7724) --> 
    cc(alle,_7722,_7743),
    de0(_7744,_7743,_7724).

every([every,lit(en),lit(hver)],_7724,_7726) --> 
    cc(en,_7724,_7745),
    cc(hver,_7745,_7726).

false([false,lit(galt)],_7719,_7721) --> 
    cc(galt,_7719,_7721).

false([false,lit(usant)],_7719,_7721) --> 
    cc(usant,_7719,_7721).

false([false,lit(feil)],_7719,_7721) --> 
    cc(feil,_7719,_7721).

false([false,lit(uriktig)],_7719,_7721) --> 
    cc(uriktig,_7719,_7721).

few([few,lit(få)],_7719,_7721) --> 
    cc(få,_7719,_7721).

few([few,lit(fåtallig)],_7719,_7721) --> 
    cc(fåtallig,_7719,_7721).

first([first,_7733],_7722,_7724) --> 
    w(adj2(first,nil),_7733,_7722,_7724).

first([first,lit(tidligste)],_7719,_7721) --> 
    cc(tidligste,_7719,_7721).

faa([faa,lit(få)],_7719,_7721) --> 
    cc(få,_7719,_7721).

faa([faa,lit(får)],_7719,_7721) --> 
    cc(får,_7719,_7721).

faa0([faa0,_7734,!,_7763],_7723,_7725) --> 
    faa(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

faa0([faa0,[]],_7717,_7717) --> 
    [].

fast([fast,lit(fort)],_7719,_7721) --> 
    cc(fort,_7719,_7721).

fast([fast,_7733],_7722,_7724) --> 
    w(adj2(fast,nil),_7733,_7722,_7724).

fast([fast,_7738,lit(mulig)],_7727,_7729) --> 
    w(adj2(fast,nil),_7738,_7727,_7755),
    cc(mulig,_7755,_7729).

fast([fast,_7728],_7717,_7719) --> 
    hereafter(_7728,_7717,_7719).

from([from,_7730],_7719,_7721) --> 
    prep(from,_7730,_7719,_7721).

førnår([førnår,lit(når)],_7719,_7721) --> 
    cc(når,_7719,_7721).

førnår([førnår,lit(før)],_7719,_7721) --> 
    cc(før,_7719,_7721).

great([great,_7733],_7722,_7724) --> 
    w(adj2(great,nil),_7733,_7722,_7724).

great([great,lit(høy)],_7719,_7721) --> 
    cc(høy,_7719,_7721).

greater([greater,_7730],_7719,_7721) --> 
    prep(after,_7730,_7719,_7721).

greater([greater,lit(større)],_7719,_7721) --> 
    cc(større,_7719,_7721).

greater([greater,lit(høyere)],_7719,_7721) --> 
    cc(høyere,_7719,_7721).

greater([greater,lit(mer)],_7719,_7721) --> 
    cc(mer,_7719,_7721).

greater([greater,_7728],_7717,_7719) --> 
    great(_7728,_7717,_7719).

greatest([greatest,lit(størst)],_7719,_7721) --> 
    cc(størst,_7719,_7721).

greatest([greatest,lit(største)],_7719,_7721) --> 
    cc(største,_7719,_7721).

halfhour([halfhour,lit(halv),_7751],_7729,_7731) --> 
    cc(halv,_7729,_7750),
    w(noun(hour,_7708,_7709,n),_7751,_7750,_7731).

halfhour([halfhour,lit(halvtime)],_7719,_7721) --> 
    cc(halvtime,_7719,_7721).

has(_7702,[has,_7752,_7776,_7805],_7738,_7740) --> 
    has(_7752,_7738,_7767),
    negation0(_7702,_7776,_7767,_7793),
    not_look_ahead(w(noun(arrival,_7715,_7716,n)),_7805,_7793,_7740).

has0([has0,_7731,!],_7720,_7722) --> 
    has(_7731,_7720,_7722),
    !.

has0([has0,[]],_7717,_7717) --> 
    [].

has([has,_7746,_7775],_7735,_7737) --> 
    w(verb(have,_7717,fin),_7746,_7735,_7763),
    not_look_ahead(w(noun(arrival,_7710,_7711,n)),_7775,_7763,_7737).

hashad0([hashad0,_7731,!],_7720,_7722) --> 
    hashad(_7731,_7720,_7722),
    !.

hashad0([hashad0,[]],_7717,_7717) --> 
    [].

hashad([hashad,_7749,_7778,!,_7812],_7738,_7740) --> 
    w(verb(have,_7714,_7715),_7749,_7738,_7766),
    w(verb(have,_7720,_7721),_7778,_7766,_7795),
    !,
    accept(_7812,_7795,_7740).

hashad([hashad,_7734],_7723,_7725) --> 
    w(verb(have,_7705,_7706),_7734,_7723,_7725).

hasto0([hasto0,_7737,_7766],_7726,_7728) --> 
    w(verb(have,_7708,fin),_7737,_7726,_7754),
    infinitive(_7766,_7754,_7728).

hasto0([hasto0,[]],_7717,_7717) --> 
    [].

hereafter([hereafter,lit(om),lit(ikke),lit(så),lit(lenge)],_7734,_7736) --> 
    cc(om,_7734,_7755),
    cc(ikke,_7755,_7766),
    cc(så,_7766,_7777),
    cc(lenge,_7777,_7736).

hereafter([hereafter,_7731,_7755],_7720,_7722) --> 
    soonar(_7731,_7720,_7746),
    aspossible0(_7755,_7746,_7722).

hereafter([hereafter,lit(så),_7760,lit(som),_7795,!],_7738,_7740) --> 
    cc(så,_7738,_7759),
    soon(_7760,_7759,_7775),
    cc(som,_7775,_7794),
    w(adj2(possible,nil),_7795,_7794,_7740),
    !.

hereafter([hereafter,_7746,_7775,_7799,!],_7735,_7737) --> 
    prep1(in,_7746,_7735,_7763),
    near(_7775,_7763,_7790),
    w(noun(future,_7716,_7717,_7718),_7799,_7790,_7737),
    !.

hereafter([hereafter,lit(med),lit(en),lit(gang)],_7729,_7731) --> 
    cc(med,_7729,_7750),
    cc(en,_7750,_7761),
    cc(gang,_7761,_7731).

hereafter([hereafter,lit(heretter)],_7719,_7721) --> 
    cc(heretter,_7719,_7721).

hereafter([hereafter,_7733,_7762],_7722,_7724) --> 
    prep1(from,_7733,_7722,_7750),
    nowon(_7762,_7750,_7724).

hereafter([hereafter,_7748,_7777,_7806],_7737,_7739) --> 
    prep1(in,_7748,_7737,_7765),
    w(adj2(nearest,nil),_7777,_7765,_7794),
    w(noun(future,_7711,_7712,n),_7806,_7794,_7739).

hereafter([hereafter,_7748,_7777,_7806],_7737,_7739) --> 
    prep1(on,_7748,_7737,_7765),
    w(adj2(_7719,nil),_7777,_7765,_7794),
    w(noun(way,_7711,u,n),_7806,_7794,_7739).

hereafter([hereafter,_7733,_7762],_7722,_7724) --> 
    prep1(after,_7733,_7722,_7750),
    now1(_7762,_7750,_7724).

hereafter([hereafter,_7735,lit(dette)],_7724,_7726) --> 
    prep1(after,_7735,_7724,_7752),
    cc(dette,_7752,_7726).

hereafter([hereafter,lit(raskest),lit(mulig)],_7724,_7726) --> 
    cc(raskest,_7724,_7745),
    cc(mulig,_7745,_7726).

hereafter([hereafter,_7738,lit(gang)],_7727,_7729) --> 
    w(adj2(next,nil),_7738,_7727,_7755),
    cc(gang,_7755,_7729).

hereafter([hereafter,lit(raskest)],_7719,_7721) --> 
    cc(raskest,_7719,_7721).

herefrom([herefrom,_7741,lit(her),!,_7786],_7730,_7732) --> 
    prep1(from,_7741,_7730,_7758),
    cc(her,_7758,_7780),
    !,
    accept(_7786,_7780,_7732).

herefrom([herefrom,lit(herfra)],_7719,_7721) --> 
    cc(herfra,_7719,_7721).

herefrom([herefrom,lit(derfra)],_7719,_7721) --> 
    cc(derfra,_7719,_7721).

how([how,lit(hvordan),_7744],_7722,_7724) --> 
    cc(hvordan,_7722,_7743),
    ialle0(_7744,_7743,_7724).

how([how,lit(hvorfor),_7744],_7722,_7724) --> 
    cc(hvorfor,_7722,_7743),
    ialle0(_7744,_7743,_7724).

hoq([hoq,lit(vil),lit(du),lit(at)],_7729,_7731) --> 
    cc(vil,_7729,_7750),
    cc(du,_7750,_7761),
    cc(at,_7761,_7731).

hoq([hoq,_7744,lit(det),lit(at)],_7733,_7735) --> 
    w(verb(mean,_7713,fin),_7744,_7733,_7761),
    cc(det,_7761,_7783),
    cc(at,_7783,_7735).

hoq([hoq,_7746,lit(det),lit(seg),_7792,lit(at)],_7735,_7737) --> 
    has(_7746,_7735,_7761),
    cc(det,_7761,_7780),
    cc(seg,_7780,_7791),
    redundant0(_7792,_7791,_7807),
    cc(at,_7807,_7737).

hoq([hoq,_7741,lit(det),_7776,lit(at)],_7730,_7732) --> 
    be(_7741,_7730,_7756),
    cc(det,_7756,_7775),
    redundant0(_7776,_7775,_7791),
    cc(at,_7791,_7732).

hoq([hoq,_7749,lit(det),lit(an),lit(at)],_7738,_7740) --> 
    w(verb(go,_7716,fin),_7749,_7738,_7766),
    cc(det,_7766,_7788),
    cc(an,_7788,_7799),
    cc(at,_7799,_7740).

hoq([hoq,_7749,lit(det),_7789,lit(at)],_7738,_7740) --> 
    w(verb(agree,_7716,fin),_7749,_7738,_7766),
    cc(det,_7766,_7788),
    negation0(_7721,_7789,_7788,_7806),
    cc(at,_7806,_7740).

ihvor([ihvor,lit(i),lit(hvor),!],_7727,_7729) --> 
    cc(i,_7727,_7748),
    cc(hvor,_7748,_7729),
    !.

ihvor([ihvor,lit(hvor)],_7719,_7721) --> 
    cc(hvor,_7719,_7721).

hvor([hvor,lit(hvor)],_7719,_7721) --> 
    cc(hvor,_7719,_7721).

hvordan([hvordan,lit(hvordan),!,_7752],_7725,_7727) --> 
    cc(hvordan,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

hvordan([hvordan,lit(hva),lit(slags),_7766,!,_7795],_7733,_7735) --> 
    cc(hva,_7733,_7754),
    cc(slags,_7754,_7765),
    type0(_7766,_7765,_7781),
    !,
    accept(_7795,_7781,_7735).

hvordan([hvordan,lit(hva),!,_7752],_7725,_7727) --> 
    cc(hva,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

hvordan([hvordan,lit(hvor),_7755,!,_7789],_7733,_7735) --> 
    cc(hvor,_7733,_7754),
    w(adj2(great,nil),_7755,_7754,_7772),
    !,
    accept(_7789,_7772,_7735).

hvorfor([hvorfor,lit(hvorfor),_7744],_7722,_7724) --> 
    cc(hvorfor,_7722,_7743),
    ialle0(_7744,_7743,_7724).

type0([type0,_7734,!,_7763],_7723,_7725) --> 
    type(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

type0([type0,[]],_7717,_7717) --> 
    [].

type([type,_7741,!,_7775],_7730,_7732) --> 
    w(noun(type,_7711,u,n),_7741,_7730,_7758),
    !,
    accept(_7775,_7758,_7732).

i([i,lit(jeg)],_7719,_7721) --> 
    cc(jeg,_7719,_7721).

i([i,lit(meg)],_7719,_7721) --> 
    cc(meg,_7719,_7721).

i([i,lit(oss)],_7719,_7721) --> 
    cc(oss,_7719,_7721).

ialle0([ialle0,[]],_7717,_7717) --> 
    [].

if1([if1,lit(hvis)],_7719,_7721) --> 
    cc(hvis,_7719,_7721).

if1([if1,lit(om),_7762,{}],_7740,_7742) --> 
    cc(om,_7740,_7761),
    look_ahead(w(name(_7721,_7722,_7712)),_7762,_7761,_7742),
    {user:(\+subclass0(_7712,place))}.

if1([if1,lit(om),_7763,{}],_7741,_7743) --> 
    cc(om,_7741,_7762),
    look_ahead(w(noun(_7712,_7722,_7723,_7724)),_7763,_7762,_7743),
    {user:(\+subclass0(_7712,place))}.

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([jeg],_7748,_7747,_7728).

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([du],_7748,_7747,_7728).

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([han],_7748,_7747,_7728).

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([hun],_7748,_7747,_7728).

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([man],_7748,_7747,_7728).

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([vi],_7748,_7747,_7728).

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([dere],_7748,_7747,_7728).

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([de],_7748,_7747,_7728).

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([en],_7748,_7747,_7728).

if1([if1,lit(om),_7748],_7726,_7728) --> 
    cc(om,_7726,_7747),
    look_ahead([et],_7748,_7747,_7728).

ifra([ifra,lit(fra)],_7719,_7721) --> 
    cc(fra,_7719,_7721).

ifra([ifra,lit(ifra)],_7719,_7721) --> 
    cc(ifra,_7719,_7721).

iman([iman,lit(jeg)],_7719,_7721) --> 
    cc(jeg,_7719,_7721).

iman([iman,lit(man)],_7719,_7721) --> 
    cc(man,_7719,_7721).

iman([iman,lit(en)],_7719,_7721) --> 
    cc(en,_7719,_7721).

iman([iman,lit(du)],_7719,_7721) --> 
    cc(du,_7719,_7721).

inperiod0([inperiod0,_7746,_7775,!,_7809],_7735,_7737) --> 
    prep1(in,_7746,_7735,_7763),
    w(noun(hour,_7716,def,n),_7775,_7763,_7792),
    !,
    accept(_7809,_7792,_7737).

inperiod0([inperiod0,lit(om),_7757,!,_7791],_7735,_7737) --> 
    cc(om,_7735,_7756),
    w(noun(day,_7716,def,n),_7757,_7756,_7774),
    !,
    accept(_7791,_7774,_7737).

inperiod0([inperiod0,lit(hver),_7757,!,_7791],_7735,_7737) --> 
    cc(hver,_7735,_7756),
    w(noun(day,sin,u,n),_7757,_7756,_7774),
    !,
    accept(_7791,_7774,_7737).

inperiod0([inperiod0,[]],_7717,_7717) --> 
    [].

in_order_to(adj/nil/_7706,id,[in_order_to,_7747],_7730,_7732) --> 
    infinitiveand(_7747,_7730,_7732).

in_order_to(begin,id,[in_order_to,_7747,!,_7776],_7730,_7732) --> 
    infinitive(_7747,_7730,_7762),
    !,
    accept(_7776,_7762,_7732).

in_order_to(like,id,[in_order_to,_7747,!,_7776],_7730,_7732) --> 
    infinitive(_7747,_7730,_7762),
    !,
    accept(_7776,_7762,_7732).

in_order_to(start,id,[in_order_to,_7747,!,_7776],_7730,_7732) --> 
    infinitive(_7747,_7730,_7762),
    !,
    accept(_7776,_7762,_7732).

in_order_to(stop,id,[in_order_to,_7747,!,_7776],_7730,_7732) --> 
    infinitive(_7747,_7730,_7762),
    !,
    accept(_7776,_7762,_7732).

in_order_to(use,id,[in_order_to,_7768,{},_7807,!,_7836],_7751,_7753) --> 
    prepnof(_7717,_7768,_7751,_7785),
    {user:testmember(_7717,[on,to,for,with])},
    infinitive(_7807,_7785,_7822),
    !,
    accept(_7836,_7822,_7753).

in_order_to(use2,id,[in_order_to,_7747,!,_7776],_7730,_7732) --> 
    infinitive(_7747,_7730,_7762),
    !,
    accept(_7776,_7762,_7732).

in_order_to(have,id,[in_order_to,_7741],_7724,_7726) --> 
    infinitive(_7741,_7724,_7726).

in_order_to(think,id,[in_order_to,[]],_7724,_7724) --> 
    [].

in_order_to(_7702,not,[in_order_to,lit(uten),_7757],_7729,_7731) --> 
    cc(uten,_7729,_7756),
    infinitive(_7757,_7756,_7731).

in_order_to(_7702,id,[in_order_to,_7741],_7724,_7726) --> 
    in_order_to(_7741,_7724,_7726).

in_order_tox([in_order_tox,_7731,!],_7720,_7722) --> 
    infinitive(_7731,_7720,_7722),
    !.

in_order_tox([in_order_tox,_7728],_7717,_7719) --> 
    in_order_to(_7728,_7717,_7719).

in_order_to([in_order_to,_7728],_7717,_7719) --> 
    forå(_7728,_7717,_7719).

in_order_to([in_order_to,lit(får),_7747,!],_7725,_7727) --> 
    cc(får,_7725,_7746),
    infinitive(_7747,_7746,_7727),
    !.

in_order_to([in_order_to,lit(for),_7747,!],_7725,_7727) --> 
    cc(for,_7725,_7746),
    infinitiveand(_7747,_7746,_7727),
    !.

in_order_to([in_order_to,lit(før),_7747,!],_7725,_7727) --> 
    cc(før,_7725,_7746),
    infinitive(_7747,_7746,_7727),
    !.

in_order_to([in_order_to,_7736,_7765,!],_7725,_7727) --> 
    prep1(on,_7736,_7725,_7753),
    infinitive(_7765,_7753,_7727),
    !.

in_order_to([in_order_to,_7736,_7765,!],_7725,_7727) --> 
    prep1(with,_7736,_7725,_7753),
    infinitive(_7765,_7753,_7727),
    !.

in_order_to([in_order_to,_7736,_7765,!],_7725,_7727) --> 
    prep1(to,_7736,_7725,_7753),
    infinitiveand(_7765,_7753,_7727),
    !.

in_order_to([in_order_to,lit(av),_7747,!],_7725,_7727) --> 
    cc(av,_7725,_7746),
    infinitive(_7747,_7746,_7727),
    !.

in_order_to([in_order_to,lit(for),lit(og),!],_7727,_7729) --> 
    cc(for,_7727,_7748),
    cc(og,_7748,_7729),
    !.

in_order_to([in_order_to,lit(får),lit(å),!],_7727,_7729) --> 
    cc(får,_7727,_7748),
    cc(å,_7748,_7729),
    !.

in_order_to([in_order_to,lit(får),lit(og),!],_7727,_7729) --> 
    cc(får,_7727,_7748),
    cc(og,_7748,_7729),
    !.

forå([forå,lit(i),_7744],_7722,_7724) --> 
    cc(i,_7722,_7743),
    ogå(_7744,_7743,_7724).

forå([forå,lit(med),_7744],_7722,_7724) --> 
    cc(med,_7722,_7743),
    ogå(_7744,_7743,_7724).

forå([forå,lit(mot),_7744],_7722,_7724) --> 
    cc(mot,_7722,_7743),
    ogå(_7744,_7743,_7724).

forå([forå,lit(for),_7744],_7722,_7724) --> 
    cc(for,_7722,_7743),
    ogå(_7744,_7743,_7724).

forå([forå,lit(til),_7744],_7722,_7724) --> 
    cc(til,_7722,_7743),
    ogå(_7744,_7743,_7724).

forå([forå,lit(over),_7744],_7722,_7724) --> 
    cc(over,_7722,_7743),
    ogå(_7744,_7743,_7724).

forå([forå,lit(før),lit(å)],_7724,_7726) --> 
    cc(før,_7724,_7745),
    cc(å,_7745,_7726).

forå([forå,lit(ved),lit(å)],_7724,_7726) --> 
    cc(ved,_7724,_7745),
    cc(å,_7745,_7726).

ogå([ogå,lit(å)],_7719,_7721) --> 
    cc(å,_7719,_7721).

ogå([ogå,lit(og)],_7719,_7721) --> 
    cc(og,_7719,_7721).

infinitiveand([infinitiveand,lit(å)],_7719,_7721) --> 
    cc(å,_7719,_7721).

infinitiveand([infinitiveand,lit(og)],_7719,_7721) --> 
    cc(og,_7719,_7721).

infinitive([infinitive,lit(å),_7758,_7782,!],_7736,_7738) --> 
    cc(å,_7736,_7757),
    faa(_7758,_7757,_7773),
    look_ahead(w(verb(_7717,_7718,_7719)),_7782,_7773,_7738),
    !.

infinitive([infinitive,lit(å)],_7719,_7721) --> 
    cc(å,_7719,_7721).

infinitive([infinitive,lit(til),lit(å)],_7724,_7726) --> 
    cc(til,_7724,_7745),
    cc(å,_7745,_7726).

inom(in,[inom,_7737],_7723,_7725) --> 
    prep1(in,_7737,_7723,_7725).

inom(om,[inom,lit(om)],_7723,_7725) --> 
    cc(om,_7723,_7725).

inom(om,[inom,_7737],_7723,_7725) --> 
    prep1(on,_7737,_7723,_7725).

instead_of([instead_of,lit(fremfor)],_7719,_7721) --> 
    cc(fremfor,_7719,_7721).

instead_of([instead_of,_7748,_7777,lit(for),!],_7737,_7739) --> 
    prep1(in,_7748,_7737,_7765),
    w(noun(place,sin,def,n),_7777,_7765,_7794),
    cc(for,_7794,_7739),
    !.

instead_of([instead_of,lit(istedenfor)],_7719,_7721) --> 
    cc(istedenfor,_7719,_7721).

instead_of([instead_of,lit(heller),lit(enn)],_7724,_7726) --> 
    cc(heller,_7724,_7745),
    cc(enn,_7745,_7726).

it0([it0,lit(det),_7751,!],_7729,_7731) --> 
    cc(det,_7729,_7750),
    not_look_ahead([vil],_7751,_7750,_7731),
    !.

it0([it0,[]],_7717,_7717) --> 
    [].

it([it,lit(den)],_7719,_7721) --> 
    cc(den,_7719,_7721).

its([its,lit(dens),_7744],_7722,_7724) --> 
    cc(dens,_7722,_7743),
    own0(_7744,_7743,_7724).

its([its,lit(dets),_7744],_7722,_7724) --> 
    cc(dets,_7722,_7743),
    own0(_7744,_7743,_7724).

later([later,lit(senere)],_7719,_7721) --> 
    cc(senere,_7719,_7721).

later([later,lit(siden),_7744],_7722,_7724) --> 
    cc(siden,_7722,_7743),
    not_look_ahead_np(_7744,_7743,_7724).

later([later,lit(deretter)],_7719,_7721) --> 
    cc(deretter,_7719,_7721).

latest([latest,_7733],_7722,_7724) --> 
    w(adj2(sup,late),_7733,_7722,_7724).

latest([latest,_7733],_7722,_7724) --> 
    w(adj2(last,nil),_7733,_7722,_7724).

less([less,lit(før)],_7719,_7721) --> 
    cc(før,_7719,_7721).

less([less,lit(tidligere)],_7719,_7721) --> 
    cc(tidligere,_7719,_7721).

less([less,lit(mindre)],_7719,_7721) --> 
    cc(mindre,_7719,_7721).

less([less,lit(lavere)],_7719,_7721) --> 
    cc(lavere,_7719,_7721).

let([let,_7734],_7723,_7725) --> 
    w(verb(let,pres,fin),_7734,_7723,_7725).

little([little,lit(lite)],_7719,_7721) --> 
    cc(lite,_7719,_7721).

long([long,_7733],_7722,_7724) --> 
    w(adj2(short,nil),_7733,_7722,_7724).

long([long,_7733],_7722,_7724) --> 
    w(adj2(long,nil),_7733,_7722,_7724).

longadj([longadj,_7733],_7722,_7724) --> 
    w(adj2(long,nil),_7733,_7722,_7724).

manypersons([manypersons,lit(mange),_7750,!,_7779],_7728,_7730) --> 
    cc(mange,_7728,_7749),
    adjnoun(_7750,_7749,_7765),
    !,
    reject(_7779,_7765,_7730).

manypersons([manypersons,lit(mange)],_7719,_7721) --> 
    cc(mange,_7719,_7721).

many1([many1,lit(mange),_7744],_7722,_7724) --> 
    cc(mange,_7722,_7743),
    off0(_7744,_7743,_7724).

many([many,_7736,lit(mange),_7771],_7725,_7727) --> 
    so0(_7736,_7725,_7751),
    cc(mange,_7751,_7770),
    off0(_7771,_7770,_7727).

meny([meny,lit(mange)],_7719,_7721) --> 
    cc(mange,_7719,_7721).

meny([meny,lit(meget)],_7719,_7721) --> 
    cc(meget,_7719,_7721).

meny([meny,lit(mye)],_7719,_7721) --> 
    cc(mye,_7719,_7721).

me0([me0,lit(jeg),!],_7722,_7724) --> 
    cc(jeg,_7722,_7724),
    !.

me0([me0,lit(meg),!],_7722,_7724) --> 
    cc(meg,_7722,_7724),
    !.

me0([me0,lit(oss),!],_7722,_7724) --> 
    cc(oss,_7722,_7724),
    !.

me0([me0,lit(seg),!],_7722,_7724) --> 
    cc(seg,_7722,_7724),
    !.

me0([me0,[]],_7717,_7717) --> 
    [].

mineyour0([mineyour0,_7733,!],_7722,_7724) --> 
    posspron(_7705,_7733,_7722,_7724),
    !.

mineyour0([mineyour0,[]],_7717,_7717) --> 
    [].

more([more,lit(mer)],_7719,_7721) --> 
    cc(mer,_7719,_7721).

more([more,lit(fler)],_7719,_7721) --> 
    cc(fler,_7719,_7721).

more([more,lit(flere)],_7719,_7721) --> 
    cc(flere,_7719,_7721).

most([most,lit(de),lit(fleste)],_7724,_7726) --> 
    cc(de,_7724,_7745),
    cc(fleste,_7745,_7726).

most([most,lit(flest)],_7719,_7721) --> 
    cc(flest,_7719,_7721).

much([much,lit(mye)],_7719,_7721) --> 
    cc(mye,_7719,_7721).

much([much,lit(meget)],_7719,_7721) --> 
    cc(meget,_7719,_7721).

my([my,lit(min)],_7719,_7721) --> 
    cc(min,_7719,_7721).

my([my,lit(mitt)],_7719,_7721) --> 
    cc(mitt,_7719,_7721).

my([my,lit(mine)],_7719,_7721) --> 
    cc(mine,_7719,_7721).

when10([when10,_7728],_7717,_7719) --> 
    when1(_7728,_7717,_7719).

when10([when10,[]],_7717,_7717) --> 
    [].

when1([when1,lit(da)],_7719,_7721) --> 
    cc(da,_7719,_7721).

when1([when1,lit(når)],_7719,_7721) --> 
    cc(når,_7719,_7721).

when1([when1,lit(n),{},!],_7730,_7732) --> 
    cc(n,_7730,_7732),
    {user:value(smsflag,true)},
    !.

when1([when1,lit(tid),_7748],_7726,_7728) --> 
    cc(tid,_7726,_7747),
    look_ahead([går],_7748,_7747,_7728).

negation2(only,only,[negation2,[],!],_7727,_7727) --> 
    [],
    !.

negation2(id,only,[negation2,_7743],_7726,_7728) --> 
    negation(only,_7743,_7726,_7728).

negation2(id,only,[negation2,_7743],_7726,_7728) --> 
    negation(only,_7743,_7726,_7728).

negation2(not,id,[negation2,_7743],_7726,_7728) --> 
    negation(only,_7743,_7726,_7728).

negation2(not,id,[negation2,_7749,!,_7783],_7732,_7734) --> 
    negation(not,_7749,_7732,_7766),
    !,
    reject(_7783,_7766,_7734).

negation2(not,not,[negation2,_7743],_7726,_7728) --> 
    negation0(id,_7743,_7726,_7728).

negation2(id,_7703,[negation2,_7743],_7726,_7728) --> 
    negation0(_7703,_7743,_7726,_7728).

negation2(often,often,[negation2,[]],_7724,_7724) --> 
    [].

negation0(_7702,[negation0,{},!],_7734,_7734) --> 
    {user:(nonvar(_7702),_7702==not)},
    !.

negation0(_7702,[negation0,_7740,!],_7726,_7728) --> 
    negation(_7702,_7740,_7726,_7728),
    !.

negation0(id,[negation0,[]],_7721,_7721) --> 
    [].

negation(id,[negation,_7743,lit(bare),!],_7729,_7731) --> 
    not(_7743,_7729,_7758),
    cc(bare,_7758,_7731),
    !.

negation(not,[negation,lit(bare),_7751],_7726,_7728) --> 
    cc(bare,_7726,_7750),
    not(_7751,_7750,_7728).

negation(not,[negation,_7735],_7721,_7723) --> 
    not(_7735,_7721,_7723).

negation(only,[negation,lit(bare)],_7723,_7725) --> 
    cc(bare,_7723,_7725).

negation(atleast,[negation,lit(minst)],_7723,_7725) --> 
    cc(minst,_7723,_7725).

negation(often,[negation,lit(ofte)],_7723,_7725) --> 
    cc(ofte,_7723,_7725).

negatino([negatino,lit(ikke),!],_7722,_7724) --> 
    cc(ikke,_7722,_7724),
    !.

negatino([negatino,lit(ingen),!],_7722,_7724) --> 
    cc(ingen,_7722,_7724),
    !.

negatino([negatino,[]],_7717,_7717) --> 
    [].

near([near,_7733],_7722,_7724) --> 
    w(adj2(near,nil),_7733,_7722,_7724).

near([near,_7736,_7760],_7725,_7727) --> 
    the0(_7736,_7725,_7751),
    w(adj2(nearest,nil),_7760,_7751,_7727).

nearest([nearest,_7733],_7722,_7724) --> 
    w(adj2(near,sup),_7733,_7722,_7724).

nearest([nearest,_7733],_7722,_7724) --> 
    w(adj2(nearest,nil),_7733,_7722,_7724).

nearest([nearest,_7730],_7719,_7721) --> 
    prep1(nearest,_7730,_7719,_7721).

nest([nest,lit(nest)],_7719,_7721) --> 
    cc(nest,_7719,_7721).

nest([nest,_7733],_7722,_7724) --> 
    w(adj2(next,nil),_7733,_7722,_7724).

next0([next0,_7731,!],_7720,_7722) --> 
    next(_7731,_7720,_7722),
    !.

next0([next0,[]],_7717,_7717) --> 
    [].

next([next,_7733],_7722,_7724) --> 
    w(adj2(next,nil),_7733,_7722,_7724).

no([no,lit(ingen),_7744],_7722,_7724) --> 
    cc(ingen,_7722,_7743),
    look_ahead_np(_7744,_7743,_7724).

notall([notall,lit(ikke),lit(alle)],_7724,_7726) --> 
    cc(ikke,_7724,_7745),
    cc(alle,_7745,_7726).

not0([not0,_7731,!],_7720,_7722) --> 
    not(_7731,_7720,_7722),
    !.

not0([not0,[]],_7717,_7717) --> 
    [].

not([not,lit(ikke)],_7719,_7721) --> 
    cc(ikke,_7719,_7721).

not([not,lit(intet),_7744],_7722,_7724) --> 
    cc(intet,_7722,_7743),
    look_ahead_np(_7744,_7743,_7724).

notwithstanding([notwithstanding,lit(selv_om)],_7719,_7721) --> 
    cc(selv_om,_7719,_7721).

notwithstanding([notwithstanding,lit(selv),lit(om)],_7724,_7726) --> 
    cc(selv,_7724,_7745),
    cc(om,_7745,_7726).

now0([now0,_7731,!],_7720,_7722) --> 
    now1(_7731,_7720,_7722),
    !.

now0([now0,_7728],_7717,_7719) --> 
    today(_7728,_7717,_7719).

now0([now0,[]],_7717,_7717) --> 
    [].

now1([now1,lit(ennå)],_7719,_7721) --> 
    cc(ennå,_7719,_7721).

now1([now1,lit(nå)],_7719,_7721) --> 
    cc(nå,_7719,_7721).

now1([now1,lit(no)],_7719,_7721) --> 
    cc(no,_7719,_7721).

nowon([nowon,_7736,lit(av),!],_7725,_7727) --> 
    now1(_7736,_7725,_7751),
    cc(av,_7751,_7727),
    !.

nowon([nowon,_7728],_7717,_7719) --> 
    now1(_7728,_7717,_7719).

nr0([nr0,_7731,!],_7720,_7722) --> 
    nr1(_7731,_7720,_7722),
    !.

nr0([nr0,[]],_7717,_7717) --> 
    [].

nr1([nr1,lit(nr),_7747,!],_7725,_7727) --> 
    cc(nr,_7725,_7746),
    point0(_7747,_7746,_7727),
    !.

nr1([nr1,lit(n),_7747,!],_7725,_7727) --> 
    cc(n,_7725,_7746),
    point0(_7747,_7746,_7727),
    !.

nr1([nr1,_7734,_7758,!],_7723,_7725) --> 
    number1(_7734,_7723,_7749),
    point0(_7758,_7749,_7725),
    !.

number0([number0,_7733,!],_7722,_7724) --> 
    num(_7705,_7733,_7722,_7724),
    !.

number0([number0,[]],_7717,_7717) --> 
    [].

number1([number1,_7738,_7767],_7727,_7729) --> 
    w(noun(number,sin,_7709,n),_7738,_7727,_7755),
    colon0(_7767,_7755,_7729).

of_course0([of_course0,_7728],_7717,_7719) --> 
    of_course(_7728,_7717,_7719).

of_course0([of_course0,_7736],_7725,_7727) --> 
    not_look_ahead(w(verb(_7706,_7707,_7708)),_7736,_7725,_7727).

of_coursenot0([of_coursenot0,_7733,lit(ikke)],_7722,_7724) --> 
    of_course(_7733,_7722,_7748),
    cc(ikke,_7748,_7724).

of_coursenot0([of_coursenot0,_7736],_7725,_7727) --> 
    not_look_ahead(w(verb(_7706,_7707,_7708)),_7736,_7725,_7727).

of_course([of_course,lit(naturligvis)],_7719,_7721) --> 
    cc(naturligvis,_7719,_7721).

of_course([of_course,lit(selvfølgelig)],_7719,_7721) --> 
    cc(selvfølgelig,_7719,_7721).

of_course([of_course,lit(det),_7750],_7728,_7730) --> 
    cc(det,_7728,_7749),
    w(verb(agree,pres,fin),_7750,_7749,_7730).

of0([of0,_7731,!],_7720,_7722) --> 
    of(_7731,_7720,_7722),
    !.

of0([of0,[]],_7717,_7717) --> 
    [].

of([of,_7730],_7719,_7721) --> 
    prep(of,_7730,_7719,_7721).

of([of,_7730],_7719,_7721) --> 
    prep1(to,_7730,_7719,_7721).

off0([off0,lit(av),!],_7722,_7724) --> 
    cc(av,_7722,_7724),
    !.

off0([off0,[]],_7717,_7717) --> 
    [].

offrom([offrom,lit(av)],_7719,_7721) --> 
    cc(av,_7719,_7721).

offrom([offrom,_7730],_7719,_7721) --> 
    prep1(from,_7730,_7719,_7721).

offrom([offrom,lit(ifra)],_7719,_7721) --> 
    cc(ifra,_7719,_7721).

often([often,_7733],_7722,_7724) --> 
    w(adj2(often,nil),_7733,_7722,_7724).

often([often,lit(ofte)],_7719,_7721) --> 
    cc(ofte,_7719,_7721).

often([often,lit(sjelden)],_7719,_7721) --> 
    cc(sjelden,_7719,_7721).

often([often,lit(jevnlig)],_7719,_7721) --> 
    cc(jevnlig,_7719,_7721).

ofthe([ofthe,_7731,_7755],_7720,_7722) --> 
    of(_7731,_7720,_7746),
    the(_7755,_7746,_7722).

ofthe0([ofthe0,_7728],_7717,_7719) --> 
    ofthe(_7728,_7717,_7719).

ofthe0([ofthe0,[]],_7717,_7717) --> 
    [].

older([older,lit(eldre)],_7719,_7721) --> 
    cc(eldre,_7719,_7721).

on0([on0,_7733,!],_7722,_7724) --> 
    prep1(on,_7733,_7722,_7724),
    !.

on0([on0,[]],_7717,_7717) --> 
    [].

newyear([newyear,_7743,_7772],_7732,_7734) --> 
    w(adj2(new,nil),_7743,_7732,_7760),
    w(noun(year,_7708,_7709,_7710),_7772,_7760,_7734).

newyear([newyear,lit(nyttår)],_7719,_7721) --> 
    cc(nyttår,_7719,_7721).

om0([om0,lit(om),!],_7722,_7724) --> 
    cc(om,_7722,_7724),
    !.

om0([om0,[]],_7717,_7717) --> 
    [].

on0([on0,lit(på),!],_7722,_7724) --> 
    cc(på,_7722,_7724),
    !.

on0([on0,[]],_7717,_7717) --> 
    [].

one([one,_7733],_7722,_7724) --> 
    w(nb(1,num),_7733,_7722,_7724).

one([one,_7728],_7717,_7719) --> 
    a(_7728,_7717,_7719).

only0([only0,lit(bare),!],_7722,_7724) --> 
    cc(bare,_7722,_7724),
    !.

only0([only0,lit(hele),!],_7722,_7724) --> 
    cc(hele,_7722,_7724),
    !.

only0([only0,lit(nesten),!],_7722,_7724) --> 
    cc(nesten,_7722,_7724),
    !.

only0([only0,[]],_7717,_7717) --> 
    [].

or1([or1,lit(eller)],_7719,_7721) --> 
    cc(eller,_7719,_7721).

ordinal(_7702,[ordinal,_7740],_7726,_7728) --> 
    w(nb(_7702,ord),_7740,_7726,_7728).

oter([oter,_7728],_7717,_7719) --> 
    other(_7728,_7717,_7719).

oter([oter,_7728],_7717,_7719) --> 
    others(_7728,_7717,_7719).

other([other,lit(annen)],_7719,_7721) --> 
    cc(annen,_7719,_7721).

other([other,lit(annet)],_7719,_7721) --> 
    cc(annet,_7719,_7721).

others([others,lit(andre)],_7719,_7721) --> 
    cc(andre,_7719,_7721).

own0([own0,lit(egen)],_7719,_7721) --> 
    cc(egen,_7719,_7721).

own0([own0,lit(egne)],_7719,_7721) --> 
    cc(egne,_7719,_7721).

own0([own0,[]],_7717,_7717) --> 
    [].

possible0([possible0,_7736,!],_7725,_7727) --> 
    w(adj2(possible,nil),_7736,_7725,_7727),
    !.

possible0([possible0,[]],_7717,_7717) --> 
    [].

reflexiv0(_7702,[reflexiv0,_7743,!,_7777],_7729,_7731) --> 
    reflexiv(_7702,_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

reflexiv0(_7702,[reflexiv0,{},!,_7761],_7732,_7734) --> 
    {user:verbtype(_7702,dtv)},
    !,
    accept(_7761,_7732,_7734).

reflexiv0(_7702,[reflexiv0,[]],_7721,_7721) --> 
    [].

reflexiv(ask,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(befind,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(beworry,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(buy,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(change,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(come,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(cost,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(decide,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(feel,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(fit,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(find,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(give,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(go,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(have,[reflexiv,lit(meg)],_7723,_7725) --> 
    cc(meg,_7723,_7725).

reflexiv(have,[reflexiv,lit(seg)],_7723,_7725) --> 
    cc(seg,_7723,_7725).

reflexiv(hurry,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(learn,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(move,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(pass,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(pay2,[reflexiv,lit(seg)],_7723,_7725) --> 
    cc(seg,_7723,_7725).

reflexiv(promise,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(get,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(get,[reflexiv,lit(med)],_7723,_7725) --> 
    cc(med,_7723,_7725).

reflexiv(receive,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(receive,[reflexiv,lit(med)],_7723,_7725) --> 
    cc(med,_7723,_7725).

reflexiv(retire,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(run,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(say,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(send,[reflexiv,_7738,_7762],_7724,_7726) --> 
    to0(_7738,_7724,_7753),
    rfxpron(_7762,_7753,_7726).

reflexiv(show,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(sneak,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(take,[reflexiv,lit(med),_7751],_7726,_7728) --> 
    cc(med,_7726,_7750),
    rfxpron(_7751,_7750,_7728).

reflexiv(take,[reflexiv,lit(med)],_7723,_7725) --> 
    cc(med,_7723,_7725).

reflexiv(take,[reflexiv,_7742,_7771],_7728,_7730) --> 
    not_look_ahead([dere],_7742,_7728,_7759),
    rfxpron(_7771,_7759,_7730).

reflexiv(tell,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(think,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(turn,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(want,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(wish,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(worry,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

reflexiv(write,[reflexiv,_7735],_7721,_7723) --> 
    rfxpron(_7735,_7721,_7723).

rfxpron0([rfxpron0,_7731,!],_7720,_7722) --> 
    rfxpron(_7731,_7720,_7722),
    !.

rfxpron0([rfxpron0,[]],_7717,_7717) --> 
    [].

rfxpron([rfxpron,lit(meg)],_7719,_7721) --> 
    cc(meg,_7719,_7721).

rfxpron([rfxpron,lit(deg)],_7719,_7721) --> 
    cc(deg,_7719,_7721).

rfxpron([rfxpron,lit(seg)],_7719,_7721) --> 
    cc(seg,_7719,_7721).

rfxpron([rfxpron,lit(oss)],_7719,_7721) --> 
    cc(oss,_7719,_7721).

rfxpron([rfxpron,lit(dere)],_7719,_7721) --> 
    cc(dere,_7719,_7721).

rfxpron([rfxpron,lit(selv),_7748],_7726,_7728) --> 
    cc(selv,_7726,_7747),
    not_look_ahead([om],_7748,_7747,_7728).

compassly([compassly,lit(nordfra)],_7719,_7721) --> 
    cc(nordfra,_7719,_7721).

compassly([compassly,lit(nordover)],_7719,_7721) --> 
    cc(nordover,_7719,_7721).

compassly([compassly,lit(sydfra)],_7719,_7721) --> 
    cc(sydfra,_7719,_7721).

compassly([compassly,lit(sydover)],_7719,_7721) --> 
    cc(sydover,_7719,_7721).

compassly([compassly,lit(sørfra)],_7719,_7721) --> 
    cc(sørfra,_7719,_7721).

compassly([compassly,lit(sørover)],_7719,_7721) --> 
    cc(sørover,_7719,_7721).

compassly([compassly,lit(vestfra)],_7719,_7721) --> 
    cc(vestfra,_7719,_7721).

compassly([compassly,lit(vestover)],_7719,_7721) --> 
    cc(vestover,_7719,_7721).

compassly([compassly,lit(østfra)],_7719,_7721) --> 
    cc(østfra,_7719,_7721).

compassly([compassly,lit(østover)],_7719,_7721) --> 
    cc(østover,_7719,_7721).

redundant0x([redundant0x,lit(så)],_7719,_7721) --> 
    cc(så,_7719,_7721).

redundant0x([redundant0x,_7728],_7717,_7719) --> 
    redundants0(_7728,_7717,_7719).

redundant0([redundant0,_7731,!],_7720,_7722) --> 
    redundant(_7731,_7720,_7722),
    !.

redundant0([redundant0,[]],_7717,_7717) --> 
    [].

redundants0([redundants0,_7734,_7758,!],_7723,_7725) --> 
    redundant(_7734,_7723,_7749),
    redundants0(_7758,_7749,_7725),
    !.

redundants0([redundants0,[]],_7717,_7717) --> 
    [].

redundantsx0([redundantsx0,_7734,!,_7763],_7723,_7725) --> 
    redundant(_7734,_7723,_7749),
    !,
    redxxx0(_7763,_7749,_7725).

redundantsx0([redundantsx0,[]],_7717,_7717) --> 
    [].

redxxx0([redxxx0,lit(og),_7747,!],_7725,_7727) --> 
    cc(og,_7725,_7746),
    redundant(_7747,_7746,_7727),
    !.

redxxx0([redxxx0,[]],_7717,_7717) --> 
    [].

redundant([redundant,_7735,!],_7724,_7726) --> 
    w(adv(redundantly),_7735,_7724,_7726),
    !.

redundant([redundant,_7740,_7769],_7729,_7731) --> 
    prep1(in,_7740,_7729,_7757),
    w(noun(average,_7708,_7709,_7710),_7769,_7757,_7731).

redundant([redundant,_7735,lit(allverden)],_7724,_7726) --> 
    prep1(in,_7735,_7724,_7752),
    cc(allverden,_7752,_7726).

redundant([redundant,_7752,lit(det),_7792,_7821],_7741,_7743) --> 
    prep1(in,_7752,_7741,_7769),
    cc(det,_7769,_7791),
    w(adj2(whole,nil),_7792,_7791,_7809),
    w(verb(take,past,part),_7821,_7809,_7743).

redundant([redundant,_7735,lit(hvertfall)],_7724,_7726) --> 
    prep1(in,_7735,_7724,_7752),
    cc(hvertfall,_7752,_7726).

redundant([redundant,_7735,lit(gjen)],_7724,_7726) --> 
    prep1(in,_7735,_7724,_7752),
    cc(gjen,_7752,_7726).

redundant([redundant,_7740,_7769],_7729,_7731) --> 
    prep1(for,_7740,_7729,_7757),
    w(noun(time,sin,def,n),_7769,_7757,_7731).

redundant([redundant,_7749,_7778,_7802,!,_7836],_7738,_7740) --> 
    prep1(from,_7749,_7738,_7766),
    a(_7778,_7766,_7793),
    w(noun(place,sin,u,n),_7802,_7793,_7819),
    !,
    accept(_7836,_7819,_7740).

redundant([redundant,_7738,_7767],_7727,_7729) --> 
    prep1(on,_7738,_7727,_7755),
    w(adj2(new,nil),_7767,_7755,_7729).

redundant([redundant,_7745,lit(en),_7785],_7734,_7736) --> 
    prep1(on,_7745,_7734,_7762),
    cc(en,_7762,_7784),
    w(noun(time_count,sin,u,n),_7785,_7784,_7736).

redundant([redundant,_7733,_7762],_7722,_7724) --> 
    prep1(to,_7733,_7722,_7750),
    slutt(_7762,_7750,_7724).

redundant([redundant,_7735,lit(sammen)],_7724,_7726) --> 
    prep1(to,_7735,_7724,_7752),
    cc(sammen,_7752,_7726).

redundant([redundant,_7750,_7779,_7808],_7739,_7741) --> 
    prep1(to,_7750,_7739,_7767),
    w(adj2(ordinary,nil),_7779,_7767,_7796),
    not_look_ahead(w(noun(time,_7713,_7714,_7715)),_7808,_7796,_7741).

redundant([redundant,_7728],_7717,_7719) --> 
    always(_7728,_7717,_7719).

redundant([redundant,_7728],_7717,_7719) --> 
    aspossible(_7728,_7717,_7719).

redundant([redundant,lit(altså),_7750],_7728,_7730) --> 
    cc(altså,_7728,_7749),
    not_look_ahead_lit([at,å],_7750,_7749,_7730).

redundant([redundant,lit(bare)],_7719,_7721) --> 
    cc(bare,_7719,_7721).

redundant([redundant,lit(da),_7744],_7722,_7724) --> 
    cc(da,_7722,_7743),
    not_look_ahead_np(_7744,_7743,_7724).

redundant([redundant,lit(den),lit(gang)],_7724,_7726) --> 
    cc(den,_7724,_7745),
    cc(gang,_7745,_7726).

redundant([redundant,lit(derfra)],_7719,_7721) --> 
    cc(derfra,_7719,_7721).

redundant([redundant,lit(derfor)],_7719,_7721) --> 
    cc(derfor,_7719,_7721).

redundant([redundant,lit(alene)],_7719,_7721) --> 
    cc(alene,_7719,_7721).

redundant([redundant,lit(bort)],_7719,_7721) --> 
    cc(bort,_7719,_7721).

redundant([redundant,lit(dessverre)],_7719,_7721) --> 
    cc(dessverre,_7719,_7721).

redundant([redundant,lit(egentlig)],_7719,_7721) --> 
    cc(egentlig,_7719,_7721).

redundant([redundant,lit(ellers)],_7719,_7721) --> 
    cc(ellers,_7719,_7721).

redundant([redundant,lit(engang)],_7719,_7721) --> 
    cc(engang,_7719,_7721).

redundant([redundant,lit(enklest),lit(mulig)],_7724,_7726) --> 
    cc(enklest,_7724,_7745),
    cc(mulig,_7745,_7726).

redundant([redundant,lit(enklest)],_7719,_7721) --> 
    cc(enklest,_7719,_7721).

redundant([redundant,lit(ergo)],_7719,_7721) --> 
    cc(ergo,_7719,_7721).

redundant([redundant,lit(farefritt)],_7719,_7721) --> 
    cc(farefritt,_7719,_7721).

redundant([redundant,lit(faktisk)],_7719,_7721) --> 
    cc(faktisk,_7719,_7721).

redundant([redundant,lit(forøvrig)],_7719,_7721) --> 
    cc(forøvrig,_7719,_7721).

redundant([redundant,lit(forøvrig)],_7719,_7721) --> 
    cc(forøvrig,_7719,_7721).

redundant([redundant,lit(fram)],_7719,_7721) --> 
    cc(fram,_7719,_7721).

redundant([redundant,lit(gjerne)],_7719,_7721) --> 
    cc(gjerne,_7719,_7721).

redundant([redundant,lit(heller)],_7719,_7721) --> 
    cc(heller,_7719,_7721).

redundant([redundant,lit(helst)],_7719,_7721) --> 
    cc(helst,_7719,_7721).

redundant([redundant,lit(heldigvis)],_7719,_7721) --> 
    cc(heldigvis,_7719,_7721).

redundant([redundant,lit(herfra)],_7719,_7721) --> 
    cc(herfra,_7719,_7721).

redundant([redundant,lit(jo)],_7719,_7721) --> 
    cc(jo,_7719,_7721).

redundant([redundant,lit(jovisst)],_7719,_7721) --> 
    cc(jovisst,_7719,_7721).

redundant([redundant,lit(ikke),lit(sant)],_7724,_7726) --> 
    cc(ikke,_7724,_7745),
    cc(sant,_7745,_7726).

redundant([redundant,lit(ihvertfall)],_7719,_7721) --> 
    cc(ihvertfall,_7719,_7721).

redundant([redundant,lit(imens)],_7719,_7721) --> 
    cc(imens,_7719,_7721).

redundant([redundant,lit(inne)],_7719,_7721) --> 
    cc(inne,_7719,_7721).

redundant([redundant,lit(kanskje)],_7719,_7721) --> 
    cc(kanskje,_7719,_7721).

redundant([redundant,lit(langt),lit(bort)],_7724,_7726) --> 
    cc(langt,_7724,_7745),
    cc(bort,_7745,_7726).

redundant([redundant,lit(lenge)],_7719,_7721) --> 
    cc(lenge,_7719,_7721).

redundant([redundant,lit(likevel)],_7719,_7721) --> 
    cc(likevel,_7719,_7721).

redundant([redundant,lit(minst)],_7719,_7721) --> 
    cc(minst,_7719,_7721).

redundant([redundant,lit(mon),_7750],_7728,_7730) --> 
    cc(mon,_7728,_7749),
    w(verb(believe,imp,fin),_7750,_7749,_7730).

redundant([redundant,lit(normalt)],_7719,_7721) --> 
    cc(normalt,_7719,_7721).

redundant([redundant,lit(når),lit(som),lit(helst)],_7729,_7731) --> 
    cc(når,_7729,_7750),
    cc(som,_7750,_7761),
    cc(helst,_7761,_7731).

redundant([redundant,lit(også)],_7719,_7721) --> 
    cc(også,_7719,_7721).

redundant([redundant,_7728],_7717,_7719) --> 
    sometimes(_7728,_7717,_7719).

redundant([redundant,lit(om),_7751],_7729,_7731) --> 
    cc(om,_7729,_7750),
    w(noun(time_count,sin,def,n),_7751,_7750,_7731).

redundant([redundant,lit(ad),_7751],_7729,_7731) --> 
    cc(ad,_7729,_7750),
    w(noun(time_count,sin,def,n),_7751,_7750,_7731).

redundant([redundant,lit(sikkert)],_7719,_7721) --> 
    cc(sikkert,_7719,_7721).

redundant([redundant,lit(straks)],_7719,_7721) --> 
    cc(straks,_7719,_7721).

redundant([redundant,lit(selvsagt)],_7719,_7721) --> 
    cc(selvsagt,_7719,_7721).

redundant([redundant,lit(totalt)],_7719,_7721) --> 
    cc(totalt,_7719,_7721).

redundant([redundant,lit(uansett)],_7719,_7721) --> 
    cc(uansett,_7719,_7721).

redundant([redundant,lit(vanligvis)],_7719,_7721) --> 
    cc(vanligvis,_7719,_7721).

redundant([redundant,lit(vel)],_7719,_7721) --> 
    cc(vel,_7719,_7721).

redundant([redundant,lit(videre)],_7719,_7721) --> 
    cc(videre,_7719,_7721).

slutt([slutt,lit(sist)],_7719,_7721) --> 
    cc(sist,_7719,_7721).

slutt([slutt,lit(slutt)],_7719,_7721) --> 
    cc(slutt,_7719,_7721).

please0([please0,_7734,!,_7763],_7723,_7725) --> 
    please(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

please0([please0,lit(bare),!,_7752],_7725,_7727) --> 
    cc(bare,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

please0([please0,[]],_7717,_7717) --> 
    [].

please([please,_7737,_7761,_7785,_7809],_7726,_7728) --> 
    be(_7737,_7726,_7752),
    so(_7761,_7752,_7776),
    good(_7785,_7776,_7800),
    infinitive(_7809,_7800,_7728).

please([please,lit(kan),_7763,_7787,_7811,_7835,lit(å)],_7741,_7743) --> 
    cc(kan,_7741,_7762),
    you(_7763,_7762,_7778),
    be(_7787,_7778,_7802),
    so0(_7811,_7802,_7826),
    w(adj2(good,nil),_7835,_7826,_7852),
    cc(å,_7852,_7743).

slashpoint0([slashpoint0,_7731,!],_7720,_7722) --> 
    slashpoint(_7731,_7720,_7722),
    !.

slashpoint0([slashpoint0,[]],_7717,_7717) --> 
    [].

slashpoint([slashpoint,lit(ende),!],_7722,_7724) --> 
    cc(ende,_7722,_7724),
    !.

slashpoint([slashpoint,lit(/),!],_7722,_7724) --> 
    cc(/,_7722,_7724),
    !.

slashpoint([slashpoint,lit(i),_7754,!],_7732,_7734) --> 
    cc(i,_7732,_7753),
    look_ahead(w(nb(_7714,_7715)),_7754,_7753,_7734),
    !.

slashpoint([slashpoint,lit('.'),lit(i),_7770,!],_7737,_7739) --> 
    cc('.',_7737,_7758),
    cc(i,_7758,_7769),
    look_ahead(w(nb(_7719,_7720)),_7770,_7769,_7739),
    !.

slashpoint([slashpoint,lit('.'),!],_7722,_7724) --> 
    cc('.',_7722,_7724),
    !.

slash([slash,lit(/)],_7719,_7721) --> 
    cc(/,_7719,_7721).

dashpoint0([dashpoint0,_7731,!],_7720,_7722) --> 
    dashpoint(_7731,_7720,_7722),
    !.

dashpoint0([dashpoint0,[]],_7717,_7717) --> 
    [].

dashpoint([dashpoint,lit(-)],_7719,_7721) --> 
    cc(-,_7719,_7721).

dashpoint([dashpoint,lit('.')],_7719,_7721) --> 
    cc('.',_7719,_7721).

point0([point0,_7734,!,_7763],_7723,_7725) --> 
    point(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

point0([point0,[]],_7717,_7717) --> 
    [].

pointNO([pointNO,_7734,!,_7763],_7723,_7725) --> 
    point(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

pointNO([pointNO,{}],_7722,_7722) --> 
    {user:value(nodotflag,true)}.

point([point,lit('.')],_7719,_7721) --> 
    cc('.',_7719,_7721).

itrailer([itrailer,lit(n)],_7719,_7721) --> 
    cc(n,_7719,_7721).

itrailer([itrailer,_7737,lit(når)],_7726,_7728) --> 
    not_look_ahead([n],_7737,_7726,_7754),
    cc(når,_7754,_7728).

itrailer([itrailer,_7740,_7769],_7729,_7731) --> 
    not_look_ahead([n],_7740,_7729,_7757),
    w(adj2(next,nil),_7769,_7757,_7731).

itrailer([itrailer,lit(takk)],_7719,_7721) --> 
    cc(takk,_7719,_7721).

qtrailer0([qtrailer0,lit(?),_7747,!],_7725,_7727) --> 
    cc(?,_7725,_7746),
    qtrailer(_7747,_7746,_7727),
    !.

qtrailer0([qtrailer0,lit('.'),_7747,!],_7725,_7727) --> 
    cc('.',_7725,_7746),
    qtrailer(_7747,_7746,_7727),
    !.

qtrailer0([qtrailer0,lit(a),_7747,!],_7725,_7727) --> 
    cc(a,_7725,_7746),
    qtrailer(_7747,_7746,_7727),
    !.

qtrailer0([qtrailer0,_7731,!],_7720,_7722) --> 
    qtrailer(_7731,_7720,_7722),
    !.

qtrailer0([qtrailer0,[]],_7717,_7717) --> 
    [].

qtrailer([qtrailer,lit(a)],_7719,_7721) --> 
    cc(a,_7719,_7721).

qtrailer([qtrailer,lit(takk)],_7719,_7721) --> 
    cc(takk,_7719,_7721).

qtrailer([qtrailer,_7736,lit(du),_7771],_7725,_7727) --> 
    be(_7736,_7725,_7751),
    cc(du,_7751,_7770),
    good(_7771,_7770,_7727).

qtrailer([qtrailer,lit(ca)],_7719,_7721) --> 
    cc(ca,_7719,_7721).

qtrailer([qtrailer,lit(da)],_7719,_7721) --> 
    cc(da,_7719,_7721).

qtrailer([qtrailer,lit(eller),lit(ikke)],_7724,_7726) --> 
    cc(eller,_7724,_7745),
    cc(ikke,_7745,_7726).

qtrailer([qtrailer,lit(eller)],_7719,_7721) --> 
    cc(eller,_7719,_7721).

qtrailer([qtrailer,_7737,!],_7726,_7728) --> 
    w(name(hal,_7708,_7709),_7737,_7726,_7728),
    !.

qtrailer([qtrailer,_7748,_7792,!],_7737,_7739) --> 
    optional(w(adj2(great,nil)),_7748,_7737,_7780),
    w(noun(oracle,sin,u,n),_7792,_7780,_7739),
    !.

qtrailer([qtrailer,_7752,{},!],_7741,_7743) --> 
    w(noun(_7710,sin,u,n),_7752,_7741,_7743),
    {user:testmember(_7710,[program,oracle,boss])},
    !.

qtrailer([qtrailer,lit(og)],_7719,_7721) --> 
    cc(og,_7719,_7721).

qtrailer([qtrailer,lit(og),lit(når)],_7724,_7726) --> 
    cc(og,_7724,_7745),
    cc(når,_7745,_7726).

qtrailer([qtrailer,lit(lenger),!],_7722,_7724) --> 
    cc(lenger,_7722,_7724),
    !.

qtrailer([qtrailer,lit(lengre),!],_7722,_7724) --> 
    cc(lengre,_7722,_7724),
    !.

qtrailer([qtrailer,lit(så),_7766,lit(du),_7806,!],_7744,_7746) --> 
    cc(så,_7744,_7765),
    w(verb(be,_7719,_7720),_7766,_7765,_7783),
    cc(du,_7783,_7805),
    w(adj2(nice,nil),_7806,_7805,_7746),
    !.

qtrailer([qtrailer,_7734],_7723,_7725) --> 
    w(verb(believe,inf,fin),_7734,_7723,_7725).

qtrailer([qtrailer,_7739,lit(du)],_7728,_7730) --> 
    w(verb(believe,pres,fin),_7739,_7728,_7756),
    cc(du,_7756,_7730).

qtrailer([qtrailer,lit(ø)],_7719,_7721) --> 
    cc(ø,_7719,_7721).

qtrailer([qtrailer,_7737,lit(når)],_7726,_7728) --> 
    not_look_ahead([n],_7737,_7726,_7754),
    cc(når,_7754,_7728).

qtrailer([qtrailer,lit(din),_7761,_7805],_7739,_7741) --> 
    cc(din,_7739,_7760),
    optional(w(adj2(_7721,nil)),_7761,_7760,_7793),
    w(noun(_7710,sin,_7712,_7713),_7805,_7793,_7741).

qtrailer([qtrailer,_7749,{},!],_7738,_7740) --> 
    w(name(_7710,_7711,_7712),_7749,_7738,_7740),
    {user:testmember(_7712,[man,woman])},
    !.

qtrailer([qtrailer,lit(uansett)],_7719,_7721) --> 
    cc(uansett,_7719,_7721).

ctrailer0([ctrailer0,_7731,!],_7720,_7722) --> 
    ctrailer(_7731,_7720,_7722),
    !.

ctrailer0([ctrailer0,[]],_7717,_7717) --> 
    [].

ctrailer([ctrailer,_7728],_7717,_7719) --> 
    please(_7728,_7717,_7719).

ctrailer([ctrailer,lit(takk)],_7719,_7721) --> 
    cc(takk,_7719,_7721).

ctrailer([ctrailer,_7747,lit(du),_7787],_7736,_7738) --> 
    w(verb(be,pres,fin),_7747,_7736,_7764),
    cc(du,_7764,_7786),
    w(adj2(nice,nil),_7787,_7786,_7738).

ctrailer([ctrailer,lit(da)],_7719,_7721) --> 
    cc(da,_7719,_7721).

ctrailer([ctrailer,lit(din),_7761,_7805],_7739,_7741) --> 
    cc(din,_7739,_7760),
    optional(w(adj2(_7721,nil)),_7761,_7760,_7793),
    w(noun(_7710,sin,_7712,_7713),_7805,_7793,_7741).

dtrailer0([dtrailer0,{},_7751,!],_7730,_7732) --> 
    {user:(\+value(dialog,1))},
    dtrailer(_7751,_7730,_7732),
    !.

dtrailer0([dtrailer0,[]],_7717,_7717) --> 
    [].

dtrailer([dtrailer,_7734],_7723,_7725) --> 
    w(name(tore,n,firstname),_7734,_7723,_7725).

dtrailer([dtrailer,_7739,lit(jeg)],_7728,_7730) --> 
    w(verb(think,_7710,fin),_7739,_7728,_7756),
    cc(jeg,_7756,_7730).

dtrailer([dtrailer,_7739,lit(jeg)],_7728,_7730) --> 
    w(verb(mean,_7710,fin),_7739,_7728,_7756),
    cc(jeg,_7756,_7730).

dtrailer([dtrailer,_7734],_7723,_7725) --> 
    w(name(bustuc,_7705,_7706),_7734,_7723,_7725).

dtrailer([dtrailer,lit(ass)],_7719,_7721) --> 
    cc(ass,_7719,_7721).

dtrailer([dtrailer,lit(da)],_7719,_7721) --> 
    cc(da,_7719,_7721).

dtrailer([dtrailer,lit(din),_7761,_7805],_7739,_7741) --> 
    cc(din,_7739,_7760),
    optional(w(adj2(_7721,nil)),_7761,_7760,_7793),
    w(noun(fool,sin,u,n),_7805,_7793,_7741).

dtrailer([dtrailer,lit(du)],_7719,_7721) --> 
    cc(du,_7719,_7721).

dtrailer([dtrailer,lit(eller),lit(hva)],_7724,_7726) --> 
    cc(eller,_7724,_7745),
    cc(hva,_7745,_7726).

dtrailer([dtrailer,lit(eller)],_7719,_7721) --> 
    cc(eller,_7719,_7721).

dtrailer([dtrailer,lit(gitt)],_7719,_7721) --> 
    cc(gitt,_7719,_7721).

dtrailer([dtrailer,lit(hvordan)],_7719,_7721) --> 
    cc(hvordan,_7719,_7721).

dtrailer([dtrailer,lit(hei)],_7719,_7721) --> 
    cc(hei,_7719,_7721).

dtrailer([dtrailer,lit(ja)],_7719,_7721) --> 
    cc(ja,_7719,_7721).

dtrailer([dtrailer,lit(jeg)],_7719,_7721) --> 
    cc(jeg,_7719,_7721).

dtrailer([dtrailer,lit(men),lit(når)],_7724,_7726) --> 
    cc(men,_7724,_7745),
    cc(når,_7745,_7726).

dtrailer([dtrailer,lit(ok)],_7719,_7721) --> 
    cc(ok,_7719,_7721).

dtrailer([dtrailer,lit(sjø)],_7719,_7721) --> 
    cc(sjø,_7719,_7721).

dtrailer([dtrailer,lit(?),lit(takk)],_7724,_7726) --> 
    cc(?,_7724,_7745),
    cc(takk,_7745,_7726).

dtrailer([dtrailer,_7740,lit(hilsen),_7795],_7729,_7731) --> 
    optional([med],_7740,_7729,_7772),
    cc(hilsen,_7772,_7794),
    skip_rest(_7795,_7794,_7731).

posspron(self,[posspron,_7738,_7762],_7724,_7726) --> 
    my(_7738,_7724,_7753),
    own0(_7762,_7753,_7726).

posspron(man,[posspron,lit(hans),_7751],_7726,_7728) --> 
    cc(hans,_7726,_7750),
    own0(_7751,_7750,_7728).

posspron(woman,[posspron,lit(hennes),_7751],_7726,_7728) --> 
    cc(hennes,_7726,_7750),
    own0(_7751,_7750,_7728).

posspron(savant,[posspron,_7735],_7721,_7723) --> 
    your(_7735,_7721,_7723).

posspron(person,[posspron,_7738,_7762],_7724,_7726) --> 
    their(_7738,_7724,_7753),
    own0(_7762,_7753,_7726).

posspron(thing,[posspron,_7735],_7721,_7723) --> 
    sin(_7735,_7721,_7723).

previous([previous,_7733],_7722,_7724) --> 
    w(adj2(previous,nil),_7733,_7722,_7724).

thereafter([thereafter,_7731,_7755],_7720,_7722) --> 
    andor0(_7731,_7720,_7746),
    later(_7755,_7746,_7722).

thereafter([thereafter,_7735,lit(det)],_7724,_7726) --> 
    prep1(after,_7735,_7724,_7752),
    cc(det,_7752,_7726).

thereafter([thereafter,_7735,lit(dette)],_7724,_7726) --> 
    prep1(after,_7735,_7724,_7752),
    cc(dette,_7752,_7726).

thereafter([thereafter,_7735,lit(der)],_7724,_7726) --> 
    prep1(after,_7735,_7724,_7752),
    cc(der,_7752,_7726).

thereafter([thereafter,lit(nest),_7751,lit(der)],_7729,_7731) --> 
    cc(nest,_7729,_7750),
    prep1(after,_7751,_7750,_7768),
    cc(der,_7768,_7731).

thereafter([thereafter,_7735,lit(hvert)],_7724,_7726) --> 
    prep1(after,_7735,_7724,_7752),
    cc(hvert,_7752,_7726).

beforethat([beforethat,lit(derfør)],_7719,_7721) --> 
    cc(derfør,_7719,_7721).

beforethat([beforethat,_7731,_7755],_7720,_7722) --> 
    andor0(_7731,_7720,_7746),
    earlier(_7755,_7746,_7722).

beforethat([beforethat,_7735,lit(det)],_7724,_7726) --> 
    prep1(before,_7735,_7724,_7752),
    cc(det,_7752,_7726).

beforethat([beforethat,_7735,lit(dette)],_7724,_7726) --> 
    prep1(after,_7735,_7724,_7752),
    cc(dette,_7752,_7726).

beforethat([beforethat,_7735,lit(der)],_7724,_7726) --> 
    prep1(after,_7735,_7724,_7752),
    cc(der,_7752,_7726).

beforethat([beforethat,_7735,lit(dette)],_7724,_7726) --> 
    prep1(before,_7735,_7724,_7752),
    cc(dette,_7752,_7726).

beforethat([beforethat,lit(nest),_7751,lit(der)],_7729,_7731) --> 
    cc(nest,_7729,_7750),
    prep1(before,_7751,_7750,_7768),
    cc(der,_7768,_7731).

preperly([preperly,lit(en),lit(del)],_7724,_7726) --> 
    cc(en,_7724,_7745),
    cc(del,_7745,_7726).

preperly([preperly,lit(enda)],_7719,_7721) --> 
    cc(enda,_7719,_7721).

preperly([preperly,lit(ekte)],_7719,_7721) --> 
    cc(ekte,_7719,_7721).

preperly([preperly,lit(litt)],_7719,_7721) --> 
    cc(litt,_7719,_7721).

preperly([preperly,lit(noe)],_7719,_7721) --> 
    cc(noe,_7719,_7721).

preperly([preperly,lit(reellt)],_7719,_7721) --> 
    cc(reellt,_7719,_7721).

preperly([preperly,lit(strengt)],_7719,_7721) --> 
    cc(strengt,_7719,_7721).

preperly([preperly,lit(strikt)],_7719,_7721) --> 
    cc(strikt,_7719,_7721).

preperly([preperly,lit(virkelig)],_7719,_7721) --> 
    cc(virkelig,_7719,_7721).

prep2(after,[prep2,lit(avgang),_7757],_7732,_7734) --> 
    cc(avgang,_7732,_7756),
    not_look_ahead(w(prep(_7711)),_7757,_7756,_7734).

prep2(before,[prep2,lit(ankomst),_7757],_7732,_7734) --> 
    cc(ankomst,_7732,_7756),
    not_look_ahead(w(prep(_7711)),_7757,_7756,_7734).

prep2(after,[prep2,_7740,_7764],_7726,_7728) --> 
    preperly(_7740,_7726,_7755),
    prep1(after,_7764,_7755,_7728).

prep2(after,[prep2,_7748,_7772,lit(enn)],_7734,_7736) --> 
    preperly(_7748,_7734,_7763),
    w(adj2(later,nil),_7772,_7763,_7789),
    cc(enn,_7789,_7736).

prep2(before,[prep2,_7740,_7764],_7726,_7728) --> 
    preperly(_7740,_7726,_7755),
    prep1(before,_7764,_7755,_7728).

prep2(before,[prep2,_7748,_7772,lit(enn)],_7734,_7736) --> 
    preperly(_7748,_7734,_7763),
    w(adj2(earlier,nil),_7772,_7763,_7789),
    cc(enn,_7789,_7736).

prep2(according_to,[prep2,_7742,lit(følge)],_7728,_7730) --> 
    prep1(in,_7742,_7728,_7759),
    cc(følge,_7759,_7730).

prep2(after,[prep2,_7740,_7764],_7726,_7728) --> 
    clock(_7740,_7726,_7755),
    prep1(after,_7764,_7755,_7728).

prep2(after,[prep2,_7740,_7764],_7726,_7728) --> 
    around1(_7740,_7726,_7755),
    prep1(after,_7764,_7755,_7728).

prep2(after,[prep2,lit(ca),_7753],_7728,_7730) --> 
    cc(ca,_7728,_7752),
    prep1(after,_7753,_7752,_7730).

prep2(after,[prep2,_7740,_7769],_7726,_7728) --> 
    prep1(after,_7740,_7726,_7757),
    around1(_7769,_7757,_7728).

prep2(after,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(from,_7742,_7728,_7759),
    prep1(after,_7771,_7759,_7730).

prep2(after,[prep2,_7749,_7778,_7807],_7735,_7737) --> 
    prep1(to,_7749,_7735,_7766),
    not_look_ahead([e],_7778,_7766,_7795),
    prep1(after,_7807,_7795,_7737).

prep2(after,[prep2,_7747,lit(og),_7787],_7733,_7735) --> 
    prep1(from,_7747,_7733,_7764),
    cc(og,_7764,_7786),
    prep1(with,_7787,_7786,_7735).

prep2(after,[prep2,lit(like),_7753],_7728,_7730) --> 
    cc(like,_7728,_7752),
    prep1(after,_7753,_7752,_7730).

prep2(after,[prep2,_7740,_7764],_7726,_7728) --> 
    not(_7740,_7726,_7755),
    prep(before,_7764,_7755,_7728).

prep2(after,[prep2,lit(senere),lit(enn)],_7728,_7730) --> 
    cc(senere,_7728,_7752),
    cc(enn,_7752,_7730).

prep2(after,[prep2,lit(resten),_7753],_7728,_7730) --> 
    cc(resten,_7728,_7752),
    prep1(off,_7753,_7752,_7730).

prep2(around,[prep2,_7738,_7762],_7724,_7726) --> 
    around1(_7738,_7724,_7753),
    around0(_7762,_7753,_7726).

prep2(at,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(in,_7742,_7728,_7759),
    prep1(at,_7771,_7759,_7730).

prep2(at,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(on,_7742,_7728,_7759),
    prep1(at,_7771,_7759,_7730).

prep2(at,[prep2,_7752,_7781,lit(av)],_7738,_7740) --> 
    prep1(at,_7752,_7738,_7769),
    w(noun(side,_7717,_7718,_7719),_7781,_7769,_7798),
    cc(av,_7798,_7740).

prep2(before,[prep2,lit(for),_7758],_7733,_7735) --> 
    cc(for,_7733,_7757),
    look_ahead(w(nb(_7711,num)),_7758,_7757,_7735).

prep2(before,[prep2,_7750,_7779,!],_7736,_7738) --> 
    w(noun(arrival,sin,u,n),_7750,_7736,_7767),
    prep1(before,_7779,_7767,_7738),
    !.

prep2(before,[prep2,_7740,_7769],_7726,_7728) --> 
    prep1(before,_7740,_7726,_7757),
    ca(_7769,_7757,_7728).

prep2(before,[prep2,lit(like),_7753],_7728,_7730) --> 
    cc(like,_7728,_7752),
    prep1(before,_7753,_7752,_7730).

prep2(before,[prep2,_7740,_7764],_7726,_7728) --> 
    not(_7740,_7726,_7755),
    prep(after,_7764,_7755,_7728).

prep2(before,[prep2,lit(senest),_7753],_7728,_7730) --> 
    cc(senest,_7728,_7752),
    prep1(before,_7753,_7752,_7730).

prep2(before,[prep2,lit(senest)],_7723,_7725) --> 
    cc(senest,_7723,_7725).

prep2(before,[prep2,_7745,_7774],_7731,_7733) --> 
    w(adj2(present,nil),_7745,_7731,_7762),
    prep1(before,_7774,_7762,_7733).

prep2(before,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(to,_7742,_7728,_7759),
    prep1(before,_7771,_7759,_7730).

prep2(before,[prep2,_7742,lit(ca)],_7728,_7730) --> 
    prep1(to,_7742,_7728,_7759),
    cc(ca,_7759,_7730).

prep2(between,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(from,_7742,_7728,_7759),
    prep1(between,_7771,_7759,_7730).

prep2(between,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(in,_7742,_7728,_7759),
    prep1(between,_7771,_7759,_7730).

prep2(between,[prep2,_7750,_7774,_7803],_7736,_7738) --> 
    a0(_7750,_7736,_7765),
    w(noun(place,_7715,_7716,n),_7774,_7765,_7791),
    prep1(between,_7803,_7791,_7738).

prep2(during,[prep2,_7747,lit(løpet),lit(av)],_7733,_7735) --> 
    prep1(in,_7747,_7733,_7764),
    cc(løpet,_7764,_7786),
    cc(av,_7786,_7735).

prep2(during2,[prep2,lit(om),_7751],_7726,_7728) --> 
    cc(om,_7726,_7750),
    ca(_7751,_7750,_7728).

prep2(from,[prep2,_7740,_7769],_7726,_7728) --> 
    prep1(from,_7740,_7726,_7757),
    colon0(_7769,_7757,_7728).

prep2(from,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(from,_7742,_7728,_7759),
    prep1(near,_7771,_7759,_7730).

prep2(from,[prep2,_7756,_7785,_7814,!,_7848],_7742,_7744) --> 
    prep1(from,_7756,_7742,_7773),
    w(adj2(up,nil),_7785,_7773,_7802),
    prep1(at,_7814,_7802,_7831),
    !,
    accept(_7848,_7831,_7744).

prep2(from,[prep2,_7748,_7777,!,_7811],_7734,_7736) --> 
    prep1(from,_7748,_7734,_7765),
    prep1(from,_7777,_7765,_7794),
    !,
    accept(_7811,_7794,_7736).

prep2(from,[prep2,lit(med),_7753],_7728,_7730) --> 
    cc(med,_7728,_7752),
    prep1(from,_7753,_7752,_7730).

prep2(from,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(in,_7742,_7728,_7759),
    prep1(from,_7771,_7759,_7730).

prep2(from,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(over,_7742,_7728,_7759),
    prep1(from,_7771,_7759,_7730).

prep2(from,[prep2,lit(ifra)],_7723,_7725) --> 
    cc(ifra,_7723,_7725).

prep2(from,[prep2,lit(inn),_7753],_7728,_7730) --> 
    cc(inn,_7728,_7752),
    prep1(from,_7753,_7752,_7730).

prep2(from,[prep2,lit(ut),_7751],_7726,_7728) --> 
    cc(ut,_7726,_7750),
    offrom(_7751,_7750,_7728).

prep2(from,[prep2,_7752,_7781,_7810],_7738,_7740) --> 
    prep1(with,_7752,_7738,_7769),
    w(noun(start,sin,_7718,_7719),_7781,_7769,_7798),
    prep1(in,_7810,_7798,_7740).

prep2(from,[prep2,_7740,_7764],_7726,_7728) --> 
    umpover(_7740,_7726,_7755),
    prep1(from,_7764,_7755,_7728).

prep2(from,[prep2,_7752,_7781,lit(nærheten),lit(av)],_7738,_7740) --> 
    prep1(from,_7752,_7738,_7769),
    prep1(in,_7781,_7769,_7798),
    cc(nærheten,_7798,_7820),
    cc(av,_7820,_7740).

prep2(in,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(around,_7742,_7728,_7759),
    prep1(in,_7771,_7759,_7730).

prep2(in,[prep2,lit(inne),_7753],_7728,_7730) --> 
    cc(inne,_7728,_7752),
    prep1(in,_7753,_7752,_7730).

prep2(in,[prep2,lit(nede),_7753],_7728,_7730) --> 
    cc(nede,_7728,_7752),
    prep1(in,_7753,_7752,_7730).

prep2(instead_of,[prep2,lit(i),lit(stedet),lit(for)],_7733,_7735) --> 
    cc(i,_7733,_7757),
    cc(stedet,_7757,_7768),
    cc(for,_7768,_7735).

prep2(near,[prep2,_7743,_7767,_7796],_7729,_7731) --> 
    so0(_7743,_7729,_7758),
    prep1(near,_7767,_7758,_7784),
    to0(_7796,_7784,_7731).

prep2(near,[prep2,_7747,lit(nærheten),lit(av)],_7733,_7735) --> 
    prep1(in,_7747,_7733,_7764),
    cc(nærheten,_7764,_7786),
    cc(av,_7786,_7735).

prep2(near,[prep2,lit(like),_7753],_7728,_7730) --> 
    cc(like,_7728,_7752),
    prep1(at,_7753,_7752,_7730).

prep2(near,[prep2,_7749,_7773,_7802,_7826],_7735,_7737) --> 
    and0(_7749,_7735,_7764),
    w(adj2(nearest,nil),_7773,_7764,_7790),
    possible0(_7802,_7790,_7817),
    to0(_7826,_7817,_7737).

prep2(near,[prep2,_7745,_7774],_7731,_7733) --> 
    w(adj2(near,nil),_7745,_7731,_7762),
    prep1(at,_7774,_7762,_7733).

prep2(near,[prep2,_7750,lit(eller),_7790],_7736,_7738) --> 
    prep1(to,_7750,_7736,_7767),
    cc(eller,_7767,_7789),
    w(adj2(near,nil),_7790,_7789,_7738).

prep2(near,[prep2,_7750,lit(eller),_7790],_7736,_7738) --> 
    prep1(past,_7750,_7736,_7767),
    cc(eller,_7767,_7789),
    w(adj2(near,nil),_7790,_7789,_7738).

prep2(on,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(in,_7742,_7728,_7759),
    prep1(on,_7771,_7759,_7730).

prep2(on,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(with,_7742,_7728,_7759),
    prep1(on,_7771,_7759,_7730).

prep2(on,[prep2,_7751,lit(midt),_7786,!,_7820],_7737,_7739) --> 
    ca0(_7751,_7737,_7766),
    cc(midt,_7766,_7785),
    prep1(on,_7786,_7785,_7803),
    !,
    accept(_7820,_7803,_7739).

prep2(on,[prep2,lit(nede),_7753],_7728,_7730) --> 
    cc(nede,_7728,_7752),
    prep1(on,_7753,_7752,_7730).

prep2(out_of,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(to,_7742,_7728,_7759),
    prep1(outside,_7771,_7759,_7730).

prep2(outside,[prep2,lit(ikke),_7753],_7728,_7730) --> 
    cc(ikke,_7728,_7752),
    prep1(past,_7753,_7752,_7730).

prep2(outside,[prep2,lit(ikke),_7753],_7728,_7730) --> 
    cc(ikke,_7728,_7752),
    prep1(to,_7753,_7752,_7730).

prep2(over,[prep2,lit(litt),_7753],_7728,_7730) --> 
    cc(litt,_7728,_7752),
    prep1(over,_7753,_7752,_7730).

prep2(over,[prep2,_7742,lit(hvilke)],_7728,_7730) --> 
    prep1(over,_7742,_7728,_7759),
    cc(hvilke,_7759,_7730).

prep2(past,[prep2,lit(og),lit(ned)],_7728,_7730) --> 
    cc(og,_7728,_7752),
    cc(ned,_7752,_7730).

prep2(past,[prep2,lit(og),_7753],_7728,_7730) --> 
    cc(og,_7728,_7752),
    prep1(past,_7753,_7752,_7730).

prep2(past,[prep2,lit(ned)],_7723,_7725) --> 
    cc(ned,_7723,_7725).

prep2(past,[prep2,_7757,lit(/),_7797,lit(nærheten),lit(av)],_7743,_7745) --> 
    prep1(past,_7757,_7743,_7774),
    cc(/,_7774,_7796),
    prep1(in,_7797,_7796,_7814),
    cc(nærheten,_7814,_7836),
    cc(av,_7836,_7745).

prep2(past,[prep2,_7757,lit(eller),_7797,lit(nærheten),lit(av)],_7743,_7745) --> 
    prep1(past,_7757,_7743,_7774),
    cc(eller,_7774,_7796),
    prep1(in,_7797,_7796,_7814),
    cc(nærheten,_7814,_7836),
    cc(av,_7836,_7745).

prep2(past,[prep2,_7753,lit(/),_7793,!,_7827],_7739,_7741) --> 
    prep1(to,_7753,_7739,_7770),
    cc(/,_7770,_7792),
    prep1(from,_7793,_7792,_7810),
    !,
    accept(_7827,_7810,_7741).

prep2(past,[prep2,_7751,_7780,_7804,!,_7838],_7737,_7739) --> 
    prep1(to,_7751,_7737,_7768),
    and0(_7780,_7768,_7795),
    prep1(from,_7804,_7795,_7821),
    !,
    accept(_7838,_7821,_7739).

prep2(past,[prep2,_7751,_7780,_7804,!,_7838],_7737,_7739) --> 
    prep1(from,_7751,_7737,_7768),
    and1(_7780,_7768,_7795),
    prep1(to,_7804,_7795,_7821),
    !,
    accept(_7838,_7821,_7739).

prep2(past,[prep2,_7747,_7776],_7733,_7735) --> 
    prep1(with,_7747,_7733,_7764),
    w(noun(departure,_7710,_7711,_7712),_7776,_7764,_7735).

prep2(past,[prep2,_7747,lit(/),_7787],_7733,_7735) --> 
    prep1(past,_7747,_7733,_7764),
    cc(/,_7764,_7786),
    prep1(past,_7787,_7786,_7735).

prep2(to,[prep2,_7740,_7769],_7726,_7728) --> 
    prep1(to,_7740,_7726,_7757),
    colon0(_7769,_7757,_7728).

prep2(to,[prep2,_7748,_7777,!,_7811],_7734,_7736) --> 
    prep1(to,_7748,_7734,_7765),
    prep1(to,_7777,_7765,_7794),
    !,
    accept(_7811,_7794,_7736).

prep2(to,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(to,_7742,_7728,_7759),
    prep1(near,_7771,_7759,_7730).

prep2(to,[prep2,_7752,_7781,_7810],_7738,_7740) --> 
    prep1(in,_7752,_7738,_7769),
    w(noun(connection,_7717,u,n),_7781,_7769,_7798),
    prep1(with,_7810,_7798,_7740).

prep2(to,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(over,_7742,_7728,_7759),
    prep1(to,_7771,_7759,_7730).

prep2(to,[prep2,_7747,_7776],_7733,_7735) --> 
    prep1(with,_7747,_7733,_7764),
    w(noun(arrival,_7710,_7711,_7712),_7776,_7764,_7735).

prep2(to,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(with,_7742,_7728,_7759),
    prep1(to,_7771,_7759,_7730).

prep2(to,[prep2,_7740,_7764],_7726,_7728) --> 
    andsoon(_7740,_7726,_7755),
    prep1(to,_7764,_7755,_7728).

prep2(to,[prep2,lit(hjem),_7753],_7728,_7730) --> 
    cc(hjem,_7728,_7752),
    prep1(to,_7753,_7752,_7730).

prep2(to,[prep2,lit(inn),_7753],_7728,_7730) --> 
    cc(inn,_7728,_7752),
    prep1(to,_7753,_7752,_7730).

prep2(to,[prep2,lit(ned),_7753],_7728,_7730) --> 
    cc(ned,_7728,_7752),
    prep1(to,_7753,_7752,_7730).

prep2(to,[prep2,lit(opp),_7753],_7728,_7730) --> 
    cc(opp,_7728,_7752),
    prep1(to,_7753,_7752,_7730).

prep2(to,[prep2,lit(tur),lit(retur)],_7728,_7730) --> 
    cc(tur,_7728,_7752),
    cc(retur,_7752,_7730).

prep2(to,[prep2,_7740,_7764],_7726,_7728) --> 
    umpover(_7740,_7726,_7755),
    prep1(to,_7764,_7755,_7728).

prep2(towards,[prep2,lit(inn),_7753],_7728,_7730) --> 
    cc(inn,_7728,_7752),
    prep1(towards,_7753,_7752,_7730).

prep2(towards,[prep2,lit(ut),_7753],_7728,_7730) --> 
    cc(ut,_7728,_7752),
    prep1(towards,_7753,_7752,_7730).

prep2(towards,[prep2,lit(ned),_7753],_7728,_7730) --> 
    cc(ned,_7728,_7752),
    prep1(towards,_7753,_7752,_7730).

prep2(towards,[prep2,_7740,_7764],_7726,_7728) --> 
    umpover(_7740,_7726,_7755),
    prep1(towards,_7764,_7755,_7728).

prep2(until,[prep2,_7735],_7721,_7723) --> 
    until(_7735,_7721,_7723).

prep2(with,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(with,_7742,_7728,_7759),
    prep1(on,_7771,_7759,_7730).

prep2(with,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(with,_7742,_7728,_7759),
    prep1(in,_7771,_7759,_7730).

prep2(with,[prep2,_7743,lit(bruk),_7778],_7729,_7731) --> 
    by(_7743,_7729,_7758),
    cc(bruk,_7758,_7777),
    of(_7778,_7777,_7731).

prep2(within,[prep2,_7742,_7771],_7728,_7730) --> 
    prep1(on,_7742,_7728,_7759),
    prep1(under,_7771,_7759,_7730).

prep2(without,[prep2,lit(fri),lit(for)],_7728,_7730) --> 
    cc(fri,_7728,_7752),
    cc(for,_7752,_7730).

umpover([umpover,lit(opp),_7746],_7724,_7726) --> 
    cc(opp,_7724,_7745),
    prep1(over,_7746,_7745,_7726).

umpover([umpover,lit(bort)],_7719,_7721) --> 
    cc(bort,_7719,_7721).

umpover([umpover,_7730],_7719,_7721) --> 
    prep1(over,_7730,_7719,_7721).

umpover([umpover,lit(bortover)],_7719,_7721) --> 
    cc(bortover,_7719,_7721).

umpover([umpover,lit(utover)],_7719,_7721) --> 
    cc(utover,_7719,_7721).

umpover([umpover,lit(innover)],_7719,_7721) --> 
    cc(innover,_7719,_7721).

umpover([umpover,lit(oppover)],_7719,_7721) --> 
    cc(oppover,_7719,_7721).

umpover([umpover,lit(nedover)],_7719,_7721) --> 
    cc(nedover,_7719,_7721).

umpover([umpover,lit(hitover)],_7719,_7721) --> 
    cc(hitover,_7719,_7721).

umpover([umpover,_7740,_7769],_7729,_7731) --> 
    prep1(on,_7740,_7729,_7757),
    w(noun(route,sin,_7709,n),_7769,_7757,_7731).

umpover([umpover,_7740,_7769],_7729,_7731) --> 
    prep1(on,_7740,_7729,_7757),
    w(noun(direction,sin,_7709,n),_7769,_7757,_7731).

pronoun1(_7702,[pronoun1,lit(de),!,_7759],_7729,_7731) --> 
    cc(de,_7729,_7753),
    !,
    reject(_7759,_7753,_7731).

pronoun1(_7702,[pronoun1,lit(en),!,_7759],_7729,_7731) --> 
    cc(en,_7729,_7753),
    !,
    reject(_7759,_7753,_7731).

pronoun1(_7702,[pronoun1,_7737],_7723,_7725) --> 
    pronoun(_7702,_7737,_7723,_7725).

pronoun(thing,[pronoun,_7750,_7779,!,_7808],_7736,_7738) --> 
    one_of_lit([noe,det],_7750,_7736,_7767),
    not_look_ahead_np(_7779,_7767,_7794),
    !,
    accept(_7808,_7794,_7738).

pronoun(thing,[pronoun,lit(det),_7779,_7803,_7832,!,_7866],_7754,_7756) --> 
    cc(det,_7754,_7778),
    look_ahead_vp(_7779,_7778,_7794),
    not_look_ahead(w(adj2(_7725,_7726)),_7803,_7794,_7820),
    not_look_ahead(w(noun(_7732,_7733,_7734,_7735)),_7832,_7820,_7849),
    !,
    accept(_7866,_7849,_7756).

pronoun(agent,[pronoun,lit(man)],_7723,_7725) --> 
    cc(man,_7723,_7725).

pronoun(self,[pronoun,lit(jeg),_7766,_7795],_7741,_7743) --> 
    cc(jeg,_7741,_7765),
    not_look_ahead(['.'],_7766,_7765,_7783),
    not_look_ahead(w(name(_7714,_7715,_7716)),_7795,_7783,_7743).

pronoun(self,[pronoun,lit(meg)],_7723,_7725) --> 
    cc(meg,_7723,_7725).

pronoun(vehicle,[pronoun,lit(den),_7759,{}],_7734,_7736) --> 
    cc(den,_7734,_7758),
    not_look_ahead_np(_7759,_7758,_7736),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(de),_7759,{}],_7734,_7736) --> 
    cc(de,_7734,_7758),
    not_look_ahead_np(_7759,_7758,_7736),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(_7712),{},_7784,!],_7749,_7751) --> 
    cc(_7712,_7749,_7773),
    {user:testmember(_7712,[den,det,en,et])},
    look_ahead([som],_7784,_7773,_7751),
    !.

pronoun(_7702,[pronoun,lit(_7716),{},_7779],_7744,_7746) --> 
    cc(_7716,_7744,_7768),
    {dict_n:pronoun(_7716,_7702)},
    not_look_ahead(w(nb(_7714,_7715)),_7779,_7768,_7746).

pronoun(thing,[pronoun,lit(dette),_7776,_7805,!,_7839],_7751,_7753) --> 
    cc(dette,_7751,_7775),
    not_look_ahead(w(adj2(_7722,_7723)),_7776,_7775,_7793),
    not_look_ahead(w(noun(_7729,_7730,_7731,_7732)),_7805,_7793,_7822),
    !,
    accept(_7839,_7822,_7753).

pronoun(thing,[pronoun,lit(denne),_7757,!,_7786],_7732,_7734) --> 
    cc(denne,_7732,_7756),
    not_look_ahead_np(_7757,_7756,_7772),
    !,
    accept(_7786,_7772,_7734).

pronoun(agent,[pronoun,lit(vi)],_7723,_7725) --> 
    cc(vi,_7723,_7725).

pronoun(savant,[pronoun,lit(du)],_7723,_7725) --> 
    cc(du,_7723,_7725).

pronoun(agent,[pronoun,lit(dere)],_7723,_7725) --> 
    cc(dere,_7723,_7725).

quant_pron(some,person,[quant_pron,lit(en),_7768,!],_7740,_7742) --> 
    cc(en,_7740,_7767),
    look_ahead(w(verb(_7717,_7718,_7719)),_7768,_7767,_7742),
    !.

quant_pron(some,thing,[quant_pron,lit(mye),_7760,!],_7732,_7734) --> 
    cc(mye,_7732,_7759),
    not_look_ahead_np(_7760,_7759,_7734),
    !.

quant_pron(every,person,[quant_pron,_7753,lit(alle),_7793],_7736,_7738) --> 
    not_look_ahead([hver],_7753,_7736,_7770),
    cc(alle,_7770,_7792),
    not_look_ahead_np(_7793,_7792,_7738).

quant_pron(every,thing,[quant_pron,_7757,lit(alt),_7797],_7740,_7742) --> 
    not_look_ahead(w(name(_7715,_7716,_7717)),_7757,_7740,_7774),
    cc(alt,_7774,_7796),
    sammen0(_7797,_7796,_7742).

quant_pron(some,person,[quant_pron,lit(den),_7764,!],_7736,_7738) --> 
    cc(den,_7736,_7763),
    look_ahead([som],_7764,_7763,_7738),
    !.

quant_pron(some,thing,[quant_pron,lit(det),_7764,!],_7736,_7738) --> 
    cc(det,_7736,_7763),
    look_ahead([som],_7764,_7763,_7738),
    !.

quant_pron(some,person,[quant_pron,lit(man)],_7726,_7728) --> 
    cc(man,_7726,_7728).

quant_pron(some,thing,[quant_pron,lit(mer),_7761],_7733,_7735) --> 
    cc(mer,_7733,_7760),
    not_look_ahead([enn],_7761,_7760,_7735).

quant_pron(some,thing,[quant_pron,lit(noe)],_7726,_7728) --> 
    cc(noe,_7726,_7728).

quant_pron(some,agent,[quant_pron,lit(noen),_7767,_7791],_7739,_7741) --> 
    cc(noen,_7739,_7766),
    avdem0(_7767,_7766,_7782),
    not_look_ahead(w(adj(_7715,_7716)),_7791,_7782,_7741).

avdem0([avdem0,lit(av),lit(våre),!,_7768],_7730,_7732) --> 
    cc(av,_7730,_7751),
    cc(våre,_7751,_7762),
    !,
    reject(_7768,_7762,_7732).

avdem0([avdem0,lit(av),lit(dem),!],_7727,_7729) --> 
    cc(av,_7727,_7748),
    cc(dem,_7748,_7729),
    !.

avdem0([avdem0,[]],_7717,_7717) --> 
    [].

quant_pron(some,vehicle,[quant_pron,lit(noen),_7761],_7733,_7735) --> 
    cc(noen,_7733,_7760),
    not_look_ahead([av],_7761,_7760,_7735).

quant_pron(some,agent,[quant_pron,_7741],_7724,_7726) --> 
    someone(_7741,_7724,_7726).

quant_pron(some,thing,[quant_pron,_7752,_7776],_7735,_7737) --> 
    something(_7752,_7735,_7767),
    not_look_ahead(w(verb(_7712,_7713,pass)),_7776,_7767,_7737).

quant_pron(no,person,[quant_pron,lit(ingen),_7757],_7729,_7731) --> 
    cc(ingen,_7729,_7756),
    not_look_ahead_np(_7757,_7756,_7731).

quant_pron(no,thing,[quant_pron,lit(intet),_7766],_7738,_7740) --> 
    cc(intet,_7738,_7765),
    not_look_ahead(w(noun(_7712,_7713,_7714,_7715)),_7766,_7765,_7740).

quant_pron(no,thing,[quant_pron,lit(ingen),lit(ting)],_7731,_7733) --> 
    cc(ingen,_7731,_7758),
    cc(ting,_7758,_7733).

quant_pron(no,thing,[quant_pron,lit(ingenting)],_7726,_7728) --> 
    cc(ingenting,_7726,_7728).

quant_pron(much,thing,[quant_pron,_7751,_7775],_7734,_7736) --> 
    somuch(_7751,_7734,_7766),
    not_look_ahead(w(adj2(_7712,nil)),_7775,_7766,_7736).

quant_pron(little,thing,[quant_pron,_7767,_7796,_7820,_7849],_7750,_7752) --> 
    not_look_ahead(w(adv(_7725)),_7767,_7750,_7784),
    solittle(_7796,_7784,_7811),
    not_look_ahead([å],_7820,_7811,_7837),
    not_look_ahead(w(adj2(late,nil)),_7849,_7837,_7752).

quant_pron(some,feeling,[quant_pron,_7741],_7724,_7726) --> 
    somegood(_7741,_7724,_7726).

denbussen([denbussen,lit(den),_7755,!,_7789],_7733,_7735) --> 
    cc(den,_7733,_7754),
    w(adj2(_7715,nil),_7755,_7754,_7772),
    !,
    reject(_7789,_7772,_7735).

denbussen([denbussen,lit(den)],_7719,_7721) --> 
    cc(den,_7719,_7721).

sammen0([sammen0,lit(sammen),!],_7722,_7724) --> 
    cc(sammen,_7722,_7724),
    !.

sammen0([sammen0,_7736,!],_7725,_7727) --> 
    w(adj2(possible,nil),_7736,_7725,_7727),
    !.

sammen0([sammen0,[]],_7717,_7717) --> 
    [].

somuch([somuch,_7731,_7755],_7720,_7722) --> 
    so0(_7731,_7720,_7746),
    much(_7755,_7746,_7722).

solittle([solittle,_7731,_7755],_7720,_7722) --> 
    so0(_7731,_7720,_7746),
    little(_7755,_7746,_7722).

quant0(_7702,[quant0,_7743,!,_7777],_7729,_7731) --> 
    quant1(_7702,_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

quant0(1,[quant0,[]],_7721,_7721) --> 
    [].

quant1(+(_7704),[quant1,_7742],_7728,_7730) --> 
    w(nb(_7704,num),_7742,_7728,_7730).

quant1(-(_7704),[quant1,_7739],_7725,_7727) --> 
    ordinal(_7704,_7739,_7725,_7727).

recently([recently,lit(nylig)],_7719,_7721) --> 
    cc(nylig,_7719,_7721).

recently([recently,_7738,lit(det),_7778],_7727,_7729) --> 
    prep1(in,_7738,_7727,_7755),
    cc(det,_7755,_7777),
    latest(_7778,_7777,_7729).

everything([everything,_7741,lit(alt)],_7730,_7732) --> 
    not_look_ahead(w(name(_7711,_7712,_7713)),_7741,_7730,_7758),
    cc(alt,_7758,_7732).

something([something,lit(noe),lit(mer),!,_7768],_7730,_7732) --> 
    cc(noe,_7730,_7751),
    cc(mer,_7751,_7762),
    !,
    accept(_7768,_7762,_7732).

something([something,lit(noe),lit(som),lit(helst),!,_7784],_7735,_7737) --> 
    cc(noe,_7735,_7756),
    cc(som,_7756,_7767),
    cc(helst,_7767,_7778),
    !,
    accept(_7784,_7778,_7737).

something([something,lit(noe)],_7719,_7721) --> 
    cc(noe,_7719,_7721).

something([something,lit(det),_7747,!],_7725,_7727) --> 
    cc(det,_7725,_7746),
    endofline(_7747,_7746,_7727),
    !.

something([something,lit(det),_7760,_7789],_7738,_7740) --> 
    cc(det,_7738,_7759),
    not_look_ahead([å],_7760,_7759,_7777),
    not_look_ahead(w(noun(_7712,_7713,_7714,_7715)),_7789,_7777,_7740).

somegood([somegood,lit(det),_7755,_7779,!],_7733,_7735) --> 
    cc(det,_7733,_7754),
    so0(_7755,_7754,_7770),
    w(adj2(good,nil),_7779,_7770,_7735),
    !.

somegood([somegood,lit(det),_7755,_7779,!],_7733,_7735) --> 
    cc(det,_7733,_7754),
    so0(_7755,_7754,_7770),
    w(adj2(bad,nil),_7779,_7770,_7735),
    !.

sometimes0([sometimes0,_7730],_7719,_7721) --> 
    optional(sometimes,_7730,_7719,_7721).

sometimes([sometimes,lit(noen),_7757,!,_7791],_7735,_7737) --> 
    cc(noen,_7735,_7756),
    w(noun(time_count,_7716,_7717,_7718),_7757,_7756,_7774),
    !,
    accept(_7791,_7774,_7737).

sometimes([sometimes,lit(tidvis)],_7719,_7721) --> 
    cc(tidvis,_7719,_7721).

sometimes0([sometimes0,[]],_7717,_7717) --> 
    [].

notrel([notrel,_7738,!,_7772],_7727,_7729) --> 
    look_ahead([som],_7738,_7727,_7755),
    !,
    reject(_7772,_7755,_7729).

notrel([notrel,[]],_7717,_7717) --> 
    [].

relpron(thing,[relpron,lit(som),_7751],_7726,_7728) --> 
    cc(som,_7726,_7750),
    also0(_7751,_7750,_7728).

recipron(man,[recipron,lit(han),_7751],_7726,_7728) --> 
    cc(han,_7726,_7750),
    self(_7751,_7750,_7728).

recipron(person,[recipron,lit(seg),_7751],_7726,_7728) --> 
    cc(seg,_7726,_7750),
    self(_7751,_7750,_7728).

recipron(woman,[recipron,lit(henne),_7751],_7726,_7728) --> 
    cc(henne,_7726,_7750),
    self(_7751,_7750,_7728).

recipron(thing,[recipron,lit(seg),_7751],_7726,_7728) --> 
    cc(seg,_7726,_7750),
    self0(_7751,_7750,_7728).

recipron(thing,[recipron,lit(hverandre)],_7723,_7725) --> 
    cc(hverandre,_7723,_7725).

same([same,lit(samme)],_7719,_7721) --> 
    cc(samme,_7719,_7721).

self0([self0,_7728],_7717,_7719) --> 
    self(_7728,_7717,_7719).

self0([self0,[]],_7717,_7717) --> 
    [].

self([self,lit(selv)],_7719,_7721) --> 
    cc(selv,_7719,_7721).

set([set,_7735],_7724,_7726) --> 
    w(noun(set,_7705,_7706,n),_7735,_7724,_7726).

setlist([setlist,_7728],_7717,_7719) --> 
    set(_7728,_7717,_7719).

setlist([setlist,_7735],_7724,_7726) --> 
    w(noun(list,_7705,_7706,n),_7735,_7724,_7726).

several([several,lit(fler)],_7719,_7721) --> 
    cc(fler,_7719,_7721).

several([several,lit(flere)],_7719,_7721) --> 
    cc(flere,_7719,_7721).

several([several,lit(mer),lit(enn),_7760],_7727,_7729) --> 
    cc(mer,_7727,_7748),
    cc(enn,_7748,_7759),
    one(_7760,_7759,_7729).

sin([sin,lit(sin)],_7719,_7721) --> 
    cc(sin,_7719,_7721).

sin([sin,lit(sine)],_7719,_7721) --> 
    cc(sine,_7719,_7721).

sin([sin,lit(sitt)],_7719,_7721) --> 
    cc(sitt,_7719,_7721).

saa0([saa0,lit(bare),!,_7752],_7725,_7727) --> 
    cc(bare,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

saa0([saa0,lit(så),_7754,!,_7803],_7732,_7734) --> 
    cc(så,_7732,_7753),
    optional([ofte],_7754,_7753,_7786),
    !,
    accept(_7803,_7786,_7734).

saa0([saa0,lit(mye),!,_7752],_7725,_7727) --> 
    cc(mye,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

saa0([saa0,lit(da),!,_7752],_7725,_7727) --> 
    cc(da,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

saa0([saa0,[]],_7717,_7717) --> 
    [].

so0([so0,_7731,!],_7720,_7722) --> 
    so(_7731,_7720,_7722),
    !.

so0([so0,[]],_7717,_7717) --> 
    [].

so([so,lit(så)],_7719,_7721) --> 
    cc(så,_7719,_7721).

so([so,_7728],_7717,_7719) --> 
    too(_7728,_7717,_7719).

so([so,lit(heretter)],_7719,_7721) --> 
    cc(heretter,_7719,_7721).

so_that([so_that,lit(forat)],_7719,_7721) --> 
    cc(forat,_7719,_7721).

so_that([so_that,lit(som),lit(at)],_7724,_7726) --> 
    cc(som,_7724,_7745),
    cc(at,_7745,_7726).

so_that([so_that,lit(slik),_7751,_7775],_7729,_7731) --> 
    cc(slik,_7729,_7750),
    that(_7751,_7750,_7766),
    optional([bare],_7775,_7766,_7731).

so_that([so_that,lit(så),_7744],_7722,_7724) --> 
    cc(så,_7722,_7743),
    that(_7744,_7743,_7724).

so_that([so_that,lit(som),_7753,_7782],_7731,_7733) --> 
    cc(som,_7731,_7752),
    w(verb(do1,_7713,fin),_7753,_7752,_7770),
    that(_7782,_7770,_7733).

so_that([so_that,lit(så),_7757,!],_7735,_7737) --> 
    cc(så,_7735,_7756),
    look_ahead_lit([jeg,da,den,det],_7757,_7756,_7737),
    !.

so_that([so_that,lit(så),_7756,!],_7734,_7736) --> 
    cc(så,_7734,_7755),
    look_ahead(w(noun(_7714,_7715,_7716,_7717)),_7756,_7755,_7736),
    !.

so_that([so_that,lit(til),lit(at),!],_7727,_7729) --> 
    cc(til,_7727,_7748),
    cc(at,_7748,_7729),
    !.

so_that([so_that,_7735,lit(at)],_7724,_7726) --> 
    prep1(for,_7735,_7724,_7752),
    cc(at,_7752,_7726).

som0([som0,_7728],_7717,_7719) --> 
    som(_7728,_7717,_7719).

som0([som0,[]],_7717,_7717) --> 
    [].

som([som,lit(som)],_7719,_7721) --> 
    cc(som,_7719,_7721).

some([some,lit(noen),_7744],_7722,_7724) --> 
    cc(noen,_7722,_7743),
    of0(_7744,_7743,_7724).

someonex([someonex,_7728],_7717,_7719) --> 
    someone(_7728,_7717,_7719).

someone([someone,lit(dere)],_7719,_7721) --> 
    cc(dere,_7719,_7721).

someone([someone,lit(noen),_7744],_7722,_7724) --> 
    cc(noen,_7722,_7743),
    endofline(_7744,_7743,_7724).

someone([someone,lit(noen),_7752],_7730,_7732) --> 
    cc(noen,_7730,_7751),
    look_ahead(w(verb(_7709,_7710,_7711)),_7752,_7751,_7732).

someone([someone,_7733,lit(mange)],_7722,_7724) --> 
    so0(_7733,_7722,_7748),
    cc(mange,_7748,_7724).

someone([someone,lit(den),_7748],_7726,_7728) --> 
    cc(den,_7726,_7747),
    look_ahead([som],_7748,_7747,_7728).

someone([someone,lit(en),_7748],_7726,_7728) --> 
    cc(en,_7726,_7747),
    look_ahead([som],_7748,_7747,_7728).

soonar([soonar,lit(snart)],_7719,_7721) --> 
    cc(snart,_7719,_7721).

soonar([soonar,lit(snarest)],_7719,_7721) --> 
    cc(snarest,_7719,_7721).

soonar([soonar,lit(fort)],_7719,_7721) --> 
    cc(fort,_7719,_7721).

soon([soon,lit(fort)],_7719,_7721) --> 
    cc(fort,_7719,_7721).

soon([soon,_7733],_7722,_7724) --> 
    w(adj2(fast,nil),_7733,_7722,_7724).

soon([soon,lit(snart)],_7719,_7721) --> 
    cc(snart,_7719,_7721).

soon([soon,lit(snarest)],_7719,_7721) --> 
    cc(snarest,_7719,_7721).

statics(avg,[statics,lit(gjennomsnittet),_7751],_7726,_7728) --> 
    cc(gjennomsnittet,_7726,_7750),
    ofthe0(_7751,_7750,_7728).

statics(max(1),[statics,lit(maksimum),_7753],_7728,_7730) --> 
    cc(maksimum,_7728,_7752),
    ofthe0(_7753,_7752,_7730).

statics(min(1),[statics,lit(minimum),_7753],_7728,_7730) --> 
    cc(minimum,_7728,_7752),
    ofthe0(_7753,_7752,_7730).

statics(sum,[statics,_7738,_7762],_7724,_7726) --> 
    total(_7738,_7724,_7753),
    ofthe0(_7762,_7753,_7726).

statics(number,[statics,lit(antall),_7751],_7726,_7728) --> 
    cc(antall,_7726,_7750),
    ofthe0(_7751,_7750,_7728).

sure([sure,lit(sikker)],_7719,_7721) --> 
    cc(sikker,_7719,_7721).

sure([sure,lit(sikkert)],_7719,_7721) --> 
    cc(sikkert,_7719,_7721).

sure([sure,lit(sikre)],_7719,_7721) --> 
    cc(sikre,_7719,_7721).

terminator([terminator,_7734,!,_7763],_7723,_7725) --> 
    termchar(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

termchar0([termchar0,_7731,!],_7720,_7722) --> 
    termchar(_7731,_7720,_7722),
    !.

termchar0([termchar0,[]],_7717,_7717) --> 
    [].

termchar([termchar,lit('.')],_7719,_7721) --> 
    cc('.',_7719,_7721).

termchar([termchar,lit(?)],_7719,_7721) --> 
    cc(?,_7719,_7721).

termchar([termchar,lit(!)],_7719,_7721) --> 
    cc(!,_7719,_7721).

termchar([termchar,lit(:)],_7719,_7721) --> 
    cc(:,_7719,_7721).

than0([than0,_7728],_7717,_7719) --> 
    than(_7728,_7717,_7719).

than0([than0,[]],_7717,_7717) --> 
    [].

than([than,lit(enn)],_7719,_7721) --> 
    cc(enn,_7719,_7721).

that([that,lit(om),lit(at),!,_7768],_7730,_7732) --> 
    cc(om,_7730,_7751),
    cc(at,_7751,_7762),
    !,
    accept(_7768,_7762,_7732).

that([that,lit(at)],_7719,_7721) --> 
    cc(at,_7719,_7721).

that(that,[that,_7735],_7721,_7723) --> 
    that(_7735,_7721,_7723).

that(how,[that,_7735],_7721,_7723) --> 
    how(_7735,_7721,_7723).

that(when,[that,_7735],_7721,_7723) --> 
    when(_7735,_7721,_7723).

that(where,[that,_7735],_7721,_7723) --> 
    where(_7735,_7721,_7723).

that(whether,[that,_7740,lit(hvorvidt)],_7726,_7728) --> 
    paa0(_7740,_7726,_7755),
    cc(hvorvidt,_7755,_7728).

that(whether,[that,_7740,lit(om)],_7726,_7728) --> 
    paa0(_7740,_7726,_7755),
    cc(om,_7755,_7728).

that(why,[that,lit(hvorfor)],_7723,_7725) --> 
    cc(hvorfor,_7723,_7725).

paa0([paa0,lit(på),!,_7752],_7725,_7727) --> 
    cc(på,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

paa0([paa0,[]],_7717,_7717) --> 
    [].

that0([that0,_7728],_7717,_7719) --> 
    that(_7728,_7717,_7719).

that0([that0,[]],_7717,_7717) --> 
    [].

the([the,lit(den)],_7719,_7721) --> 
    cc(den,_7719,_7721).

the([the,lit(denne)],_7719,_7721) --> 
    cc(denne,_7719,_7721).

the([the,lit(det)],_7719,_7721) --> 
    cc(det,_7719,_7721).

the([the,lit(de)],_7719,_7721) --> 
    cc(de,_7719,_7721).

the([the,lit(dette)],_7719,_7721) --> 
    cc(dette,_7719,_7721).

the([the,lit(disse),_7744],_7722,_7724) --> 
    cc(disse,_7722,_7743),
    look_ahead_np(_7744,_7743,_7724).

themost([themost,_7733,lit(mest)],_7722,_7724) --> 
    the(_7733,_7722,_7748),
    cc(mest,_7748,_7724).

the0([the0,_7737,_7761,!,_7790],_7726,_7728) --> 
    the(_7737,_7726,_7752),
    der0(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

the0([the0,{},_7746],_7725,_7727) --> 
    {user:value(textflag,true)},
    art(_7746,_7725,_7727).

the0([the0,[]],_7717,_7717) --> 
    [].

the10([the10,lit(det)],_7719,_7721) --> 
    cc(det,_7719,_7721).

the10([the10,lit(den)],_7719,_7721) --> 
    cc(den,_7719,_7721).

the10([the10,[]],_7717,_7717) --> 
    [].

theplu0([theplu0,_7737,_7761,!,_7790],_7726,_7728) --> 
    all0(_7737,_7726,_7752),
    theplu(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

theplu0([theplu0,lit(den)],_7719,_7721) --> 
    cc(den,_7719,_7721).

theplu0([theplu0,_7728],_7717,_7719) --> 
    all0(_7728,_7717,_7719).

theplu([theplu,lit(de)],_7719,_7721) --> 
    cc(de,_7719,_7721).

their([their,lit(deres)],_7719,_7721) --> 
    cc(deres,_7719,_7721).

their([their,lit(de),lit(andres)],_7724,_7726) --> 
    cc(de,_7724,_7745),
    cc(andres,_7745,_7726).

then0([then0,_7734,!,_7763],_7723,_7725) --> 
    then1(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

then0([then0,[]],_7717,_7717) --> 
    [].

then1([then1,lit(da)],_7719,_7721) --> 
    cc(da,_7719,_7721).

then1([then1,lit(så)],_7719,_7721) --> 
    cc(så,_7719,_7721).

theonly0([theonly0,_7731,_7755],_7720,_7722) --> 
    the0(_7731,_7720,_7746),
    only0(_7755,_7746,_7722).

thereit0([thereit0,_7734,!,_7763],_7723,_7725) --> 
    thereit(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

thereit0([thereit0,[]],_7717,_7717) --> 
    [].

therenot0([therenot0,_7737,_7761,!,_7790],_7726,_7728) --> 
    thereit(_7737,_7726,_7752),
    not0(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

therenot0([therenot0,_7737,_7761,!,_7790],_7726,_7728) --> 
    not(_7737,_7726,_7752),
    thereit0(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

therenot0([therenot0,[]],_7717,_7717) --> 
    [].

thereit(_7702,[thereit,_7752,_7776,_7805,_7829,!,_7858],_7738,_7740) --> 
    thereit(_7752,_7738,_7767),
    negation0(_7702,_7776,_7767,_7793),
    redundant0(_7805,_7793,_7820),
    been0(_7829,_7820,_7844),
    !,
    accept(_7858,_7844,_7740).

thereitN([thereitN,_7738,_7762,!],_7727,_7729) --> 
    thereit(_7738,_7727,_7753),
    look_ahead([ikke],_7762,_7753,_7729),
    !.

thereitN([thereitN,_7728],_7717,_7719) --> 
    thereit(_7728,_7717,_7719).

dette([dette,lit(det),_7744],_7722,_7724) --> 
    cc(det,_7722,_7743),
    it_was_pronoun(_7744,_7743,_7724).

dette([dette,lit(dette)],_7719,_7721) --> 
    cc(dette,_7719,_7721).

thereit2(be,[thereit2,lit(det),!],_7726,_7728) --> 
    cc(det,_7726,_7728),
    !.

thereit2(_7702,[thereit2,_7738,!],_7724,_7726) --> 
    thereit(_7738,_7724,_7726),
    !.

thereit2(be,[thereit2,_7742,!],_7728,_7730) --> 
    look_ahead([til],_7742,_7728,_7730),
    !.

init([init,lit(det)],_7719,_7721) --> 
    cc(det,_7719,_7721).

init([init,lit(dette),_7744],_7722,_7724) --> 
    cc(dette,_7722,_7743),
    look_ahead_vp(_7744,_7743,_7724).

thereit([thereit,lit(de),_7748],_7726,_7728) --> 
    cc(de,_7726,_7747),
    look_ahead([noe],_7748,_7747,_7728).

thereit([thereit,lit(det),_7750,!,_7779],_7728,_7730) --> 
    cc(det,_7728,_7749),
    thereit_not_pronoun(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

thereit([thereit,lit(der)],_7719,_7721) --> 
    cc(der,_7719,_7721).

thereit([thereit,lit(her)],_7719,_7721) --> 
    cc(her,_7719,_7721).

thereit_not_pronoun([thereit_not_pronoun,_7734,!,_7763],_7723,_7725) --> 
    it_was_pronoun(_7734,_7723,_7749),
    !,
    reject(_7763,_7749,_7725).

thereit_not_pronoun([thereit_not_pronoun,[]],_7717,_7717) --> 
    [].

it_was_pronoun([it_was_pronoun,_7728],_7717,_7719) --> 
    endofline(_7728,_7717,_7719).

it_was_pronoun([it_was_pronoun,_7728],_7717,_7719) --> 
    look_ahead_vp(_7728,_7717,_7719).

this(_7702,[this,_7742,{}],_7728,_7730) --> 
    this(_7742,_7728,_7730),
    {user:it_template(_7702)}.

this(_7702,[this,_7742,{}],_7728,_7730) --> 
    thereit(_7742,_7728,_7730),
    {user:it_template(_7702)}.

this([this,lit(denne)],_7719,_7721) --> 
    cc(denne,_7719,_7721).

this([this,lit(dette)],_7719,_7721) --> 
    cc(dette,_7719,_7721).

this([this,lit(disse),_7744],_7722,_7724) --> 
    cc(disse,_7722,_7743),
    not_look_ahead_np(_7744,_7743,_7724).

this([this,lit(det),_7751,_7780],_7729,_7731) --> 
    cc(det,_7729,_7750),
    look_ahead(['.'],_7751,_7750,_7768),
    accept(_7780,_7768,_7731).

this([this,lit(det),_7751,_7780],_7729,_7731) --> 
    cc(det,_7729,_7750),
    look_ahead([?],_7751,_7750,_7768),
    accept(_7780,_7768,_7731).

this([this,lit(det),lit(da),!,_7768],_7730,_7732) --> 
    cc(det,_7730,_7751),
    cc(da,_7751,_7762),
    !,
    accept(_7768,_7762,_7732).

this([this,lit(det),_7750,!,_7779],_7728,_7730) --> 
    cc(det,_7728,_7749),
    end_of_line(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

this([this,lit(slik),_7750],_7728,_7730) --> 
    cc(slik,_7728,_7749),
    not_look_ahead_lit([at,som],_7750,_7749,_7730).

thisplace(in,[thisplace,lit(her)],_7723,_7725) --> 
    cc(her,_7723,_7725).

thisplace(to,[thisplace,lit(hit)],_7723,_7725) --> 
    cc(hit,_7723,_7725).

thisplace(in,[thisplace,lit(der)],_7723,_7725) --> 
    cc(der,_7723,_7725).

thisplace(to,[thisplace,lit(dit)],_7723,_7725) --> 
    cc(dit,_7723,_7725).

timepoint([timepoint,_7735],_7724,_7726) --> 
    w(noun(time,_7705,u,n),_7735,_7724,_7726).

timepoint([timepoint,_7735],_7724,_7726) --> 
    w(noun(clock,sin,u,n),_7735,_7724,_7726).

to([to,_7730],_7719,_7721) --> 
    prep(to,_7730,_7719,_7721).

forto0([forto0,_7731,!],_7720,_7722) --> 
    forto(_7731,_7720,_7722),
    !.

forto0([forto0,[]],_7717,_7717) --> 
    [].

forto([forto,lit(for)],_7719,_7721) --> 
    cc(for,_7719,_7721).

forto([forto,lit(til)],_7719,_7721) --> 
    cc(til,_7719,_7721).

forto([forto,lit(om)],_7719,_7721) --> 
    cc(om,_7719,_7721).

slikat([slikat,lit(slik),lit(at)],_7724,_7726) --> 
    cc(slik,_7724,_7745),
    cc(at,_7745,_7726).

slikat([slikat,lit(sikkert),lit(at)],_7724,_7726) --> 
    cc(sikkert,_7724,_7745),
    cc(at,_7745,_7726).

to0([to0,_7731,!],_7720,_7722) --> 
    to(_7731,_7720,_7722),
    !.

to0([to0,[]],_7717,_7717) --> 
    [].

tomed0([tomed0,lit(til),!],_7722,_7724) --> 
    cc(til,_7722,_7724),
    !.

tomed0([tomed0,lit(med),!],_7722,_7724) --> 
    cc(med,_7722,_7724),
    !.

tomed0([tomed0,[]],_7717,_7717) --> 
    [].

too([too,lit(for),_7751],_7729,_7731) --> 
    cc(for,_7729,_7750),
    look_ahead(w(adj(_7709,nil)),_7751,_7750,_7731).

today0([today0,_7728],_7717,_7719) --> 
    today(_7728,_7717,_7719).

today0([today0,[]],_7717,_7717) --> 
    [].

today([today,lit(idag)],_7719,_7721) --> 
    cc(idag,_7719,_7721).

today([today,_7740,_7769],_7729,_7731) --> 
    prep(in,_7740,_7729,_7757),
    w(noun(day,sin,u,n),_7769,_7757,_7731).

tomorrow([tomorrow,lit(imorgen)],_7719,_7721) --> 
    cc(imorgen,_7719,_7721).

tomorrow([tomorrow,_7735,lit(morgen)],_7724,_7726) --> 
    prep1(in,_7735,_7724,_7752),
    cc(morgen,_7752,_7726).

total([total,lit(total)],_7719,_7721) --> 
    cc(total,_7719,_7721).

total([total,lit(totalt)],_7719,_7721) --> 
    cc(totalt,_7719,_7721).

total([total,lit(totale)],_7719,_7721) --> 
    cc(totale,_7719,_7721).

total([total,lit(sum),_7744],_7722,_7724) --> 
    cc(sum,_7722,_7743),
    of(_7744,_7743,_7724).

true([true,lit(sann)],_7719,_7721) --> 
    cc(sann,_7719,_7721).

true([true,lit(sant)],_7719,_7721) --> 
    cc(sant,_7719,_7721).

true([true,lit(sanne)],_7719,_7721) --> 
    cc(sanne,_7719,_7721).

true([true,lit(slik)],_7719,_7721) --> 
    cc(slik,_7719,_7721).

truefalse(id,[truefalse,_7735],_7721,_7723) --> 
    true(_7735,_7721,_7723).

truefalse(id,[truefalse,_7738,_7762],_7724,_7726) --> 
    not(_7738,_7724,_7753),
    false(_7762,_7753,_7726).

truefalse(not,[truefalse,_7735],_7721,_7723) --> 
    false(_7735,_7721,_7723).

truefalse(not,[truefalse,_7738,_7762],_7724,_7726) --> 
    not(_7738,_7724,_7753),
    true(_7762,_7753,_7726).

unequal([unequal,lit(ulik)],_7719,_7721) --> 
    cc(ulik,_7719,_7721).

unequal([unequal,lit(ulikt)],_7719,_7721) --> 
    cc(ulikt,_7719,_7721).

unequal([unequal,lit(ulike)],_7719,_7721) --> 
    cc(ulike,_7719,_7721).

unequal([unequal,_7731,_7755],_7720,_7722) --> 
    not(_7731,_7720,_7746),
    equal(_7755,_7746,_7722).

until([until,lit(inntil)],_7719,_7721) --> 
    cc(inntil,_7719,_7721).

until([until,lit(fram),_7746],_7724,_7726) --> 
    cc(fram,_7724,_7745),
    prep1(to,_7746,_7745,_7726).

use([use,_7734],_7723,_7725) --> 
    w(verb(use,_7705,fin),_7734,_7723,_7725).

use([use,_7734],_7723,_7725) --> 
    w(verb(want,_7705,fin),_7734,_7723,_7725).

what([what,lit(hva)],_7719,_7721) --> 
    cc(hva,_7719,_7721).

whatbe([whatbe,_7737,_7761,!,_7790],_7726,_7728) --> 
    what(_7737,_7726,_7752),
    be(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

whatbe([whatbe,lit(hvilke),_7750,!,_7779],_7728,_7730) --> 
    cc(hvilke,_7728,_7749),
    be(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

whatbe([whatbe,lit(hvilken),_7750,!,_7779],_7728,_7730) --> 
    cc(hvilken,_7728,_7749),
    be(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

whatbe([whatbe,lit(hvilket),_7750,!,_7779],_7728,_7730) --> 
    cc(hvilket,_7728,_7749),
    be(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

whatbemean([whatbemean,lit(hva),_7750],_7728,_7730) --> 
    cc(hva,_7728,_7749),
    w(verb(be,pres,fin),_7750,_7749,_7730).

whatbemean([whatbemean,lit(hva),_7750],_7728,_7730) --> 
    cc(hva,_7728,_7749),
    w(verb(mean2,pres,fin),_7750,_7749,_7730).

whatbemean([whatbemean,lit(hva),_7750],_7728,_7730) --> 
    cc(hva,_7728,_7749),
    w(verb(indicate,pres,fin),_7750,_7749,_7730).

when0([when0,_7734,!,_7763],_7723,_7725) --> 
    when(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

when0([when0,[]],_7717,_7717) --> 
    [].

whenx([whenx,_7739,lit(jeg),!,_7779],_7728,_7730) --> 
    when1(_7739,_7728,_7754),
    cc(jeg,_7754,_7773),
    !,
    reject(_7779,_7773,_7730).

whenx([whenx,_7728],_7717,_7719) --> 
    when(_7728,_7717,_7719).

when([when,lit(når),_7750,!,_7779],_7728,_7730) --> 
    cc(når,_7728,_7749),
    timepoint(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

when([when,lit(når)],_7719,_7721) --> 
    cc(når,_7719,_7721).

when([when,lit(hvordan),_7757,!,_7791],_7735,_7737) --> 
    cc(hvordan,_7735,_7756),
    w(noun(time,_7716,u,n),_7757,_7756,_7774),
    !,
    accept(_7791,_7774,_7737).

when([when,lit(hvor),_7750,!,_7779],_7728,_7730) --> 
    cc(hvor,_7728,_7749),
    timepoint(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

when([when,lit(hva),_7750,!,_7779],_7728,_7730) --> 
    cc(hva,_7728,_7749),
    timepoint(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

when([when,_7737,_7761,!,_7790],_7726,_7728) --> 
    which(_7737,_7726,_7752),
    timepoint(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

when([when,_7742,_7771,_7795,!,_7824],_7731,_7733) --> 
    prep1(to,_7742,_7731,_7759),
    which(_7771,_7759,_7786),
    timepoint(_7795,_7786,_7810),
    !,
    accept(_7824,_7810,_7733).

when([when,_7742,_7771,_7795,!,_7824],_7731,_7733) --> 
    prep1(on,_7742,_7731,_7759),
    which(_7771,_7759,_7786),
    timepoint(_7795,_7786,_7810),
    !,
    accept(_7824,_7810,_7733).

when([when,lit(så),lit(snart),!,_7768],_7730,_7732) --> 
    cc(så,_7730,_7751),
    cc(snart,_7751,_7762),
    !,
    accept(_7768,_7762,_7732).

when([when,lit(hva),lit(ti)],_7724,_7726) --> 
    cc(hva,_7724,_7745),
    cc(ti,_7745,_7726).

when([when,lit(hvordan),lit(ti)],_7724,_7726) --> 
    cc(hvordan,_7724,_7745),
    cc(ti,_7745,_7726).

when([when,lit(tid),_7748],_7726,_7728) --> 
    cc(tid,_7726,_7747),
    look_ahead([går],_7748,_7747,_7728).

where([where,lit(hvor),_7759,_7788,!,_7817],_7737,_7739) --> 
    cc(hvor,_7737,_7758),
    not_look_ahead(w(prep(from)),_7759,_7758,_7776),
    andwhen0(_7788,_7776,_7803),
    !,
    accept(_7817,_7803,_7739).

where([where,_7744,_7768,!,_7802],_7733,_7735) --> 
    which(_7744,_7733,_7759),
    w(noun(place,_7714,_7715,_7716),_7768,_7759,_7785),
    !,
    accept(_7802,_7785,_7735).

where1([where1,lit(der),lit(hvor),!,_7768],_7730,_7732) --> 
    cc(der,_7730,_7751),
    cc(hvor,_7751,_7762),
    !,
    accept(_7768,_7762,_7732).

where1([where1,lit(hvor),_7750,!,_7779],_7728,_7730) --> 
    cc(hvor,_7728,_7749),
    meny(_7750,_7749,_7765),
    !,
    reject(_7779,_7765,_7730).

where1([where1,lit(hvor)],_7719,_7721) --> 
    cc(hvor,_7719,_7721).

where1([where1,lit(der)],_7719,_7721) --> 
    cc(der,_7719,_7721).

wherefrom([wherefrom,_7749,_7778,_7802,!,_7836],_7738,_7740) --> 
    prep1(from,_7749,_7738,_7766),
    which(_7778,_7766,_7793),
    w(noun(place,_7719,_7720,_7721),_7802,_7793,_7819),
    !,
    accept(_7836,_7819,_7740).

wherefrom([wherefrom,_7741,lit(hvor),!,_7786],_7730,_7732) --> 
    prep1(from,_7741,_7730,_7758),
    cc(hvor,_7758,_7780),
    !,
    accept(_7786,_7780,_7732).

wherefrom([wherefrom,lit(hvorfra)],_7719,_7721) --> 
    cc(hvorfra,_7719,_7721).

wherefrom([wherefrom,lit(hvor),lit(fra)],_7724,_7726) --> 
    cc(hvor,_7724,_7745),
    cc(fra,_7745,_7726).

wherefrom([wherefrom,lit(hvor),lit(ifra)],_7724,_7726) --> 
    cc(hvor,_7724,_7745),
    cc(ifra,_7745,_7726).

while([while,lit(mens)],_7719,_7721) --> 
    cc(mens,_7719,_7721).

which0([which0,_7734,!,_7763],_7723,_7725) --> 
    which(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

which0([which0,[]],_7717,_7717) --> 
    [].

which([which,lit(hva),_7752,_7781,!],_7730,_7732) --> 
    cc(hva,_7730,_7751),
    prep1(for,_7752,_7751,_7769),
    a0(_7781,_7769,_7732),
    !.

which([which,lit(hva),lit(slags),!],_7727,_7729) --> 
    cc(hva,_7727,_7748),
    cc(slags,_7748,_7729),
    !.

which([which,lit(hvilken),lit(slags),!],_7727,_7729) --> 
    cc(hvilken,_7727,_7748),
    cc(slags,_7748,_7729),
    !.

which([which,lit(hvilken)],_7719,_7721) --> 
    cc(hvilken,_7719,_7721).

which([which,lit(hvilket)],_7719,_7721) --> 
    cc(hvilket,_7719,_7721).

which([which,lit(hvilke),_7744],_7722,_7724) --> 
    cc(hvilke,_7722,_7743),
    off0(_7744,_7743,_7724).

which2([which2,_7734,_7758,_7782],_7723,_7725) --> 
    which(_7734,_7723,_7749),
    numbertype0(_7758,_7749,_7773),
    ofthe0(_7782,_7773,_7725).

which2([which2,lit(hvem),_7768,_7797,!],_7746,_7748) --> 
    cc(hvem,_7746,_7767),
    look_ahead(w(noun(_7717,sin,u,n)),_7768,_7767,_7785),
    gmem(_7717,[bus,tram,day],_7797,_7785,_7748),
    !.

which2([which2,lit(hvordan),_7770,_7799,!],_7748,_7750) --> 
    cc(hvordan,_7748,_7769),
    look_ahead(w(noun(_7717,sin,u,n)),_7770,_7769,_7787),
    gmem(_7717,[label,bus,tram,day],_7799,_7787,_7750),
    !.

numbertype0([numbertype0,_7734,!,_7763],_7723,_7725) --> 
    type(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

numbertype0([numbertype0,[]],_7717,_7717) --> 
    [].

with0([with0,_7736,!,_7770],_7725,_7727) --> 
    prep(with,_7736,_7725,_7753),
    !,
    accept(_7770,_7753,_7727).

with0([with0,[]],_7717,_7717) --> 
    [].

who([who,lit(hvem)],_7719,_7721) --> 
    cc(hvem,_7719,_7721).

whose([whose,lit(hvis)],_7719,_7721) --> 
    cc(hvis,_7719,_7721).

mex0([mex0,_7738,!,_7772],_7727,_7729) --> 
    look_ahead([jeg],_7738,_7727,_7755),
    !,
    reject(_7772,_7755,_7729).

mex0([mex0,_7738,!,_7772],_7727,_7729) --> 
    look_ahead([du],_7738,_7727,_7755),
    !,
    reject(_7772,_7755,_7729).

mex0([mex0,lit(seg),!,_7752],_7725,_7727) --> 
    cc(seg,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

mex0([mex0,lit(meg),!,_7752],_7725,_7727) --> 
    cc(meg,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

mex0([mex0,lit(oss),!,_7752],_7725,_7727) --> 
    cc(oss,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

mex0([mex0,[]],_7717,_7717) --> 
    [].

you([you,lit(du),_7748],_7726,_7728) --> 
    cc(du,_7726,_7747),
    not_look_ahead([jeg],_7748,_7747,_7728).

yesterday([yesterday,_7735,lit(går)],_7724,_7726) --> 
    prep1(in,_7735,_7724,_7752),
    cc(går,_7752,_7726).

younger([younger,lit(yngre)],_7719,_7721) --> 
    cc(yngre,_7719,_7721).

your([your,lit(din)],_7719,_7721) --> 
    cc(din,_7719,_7721).

your([your,lit(ditt)],_7719,_7721) --> 
    cc(ditt,_7719,_7721).

your([your,lit(dine)],_7719,_7721) --> 
    cc(dine,_7719,_7721).

your([your,lit(di)],_7719,_7721) --> 
    cc(di,_7719,_7721).

num_na(_7702,[num_na,_7741,!,_7770],_7727,_7729) --> 
    art(_7741,_7727,_7756),
    !,
    reject(_7770,_7756,_7729).

num_na(_7702,[num_na,_7740],_7726,_7728) --> 
    w(nb(_7702,_7707),_7740,_7726,_7728).

num(_7702,[num,_7743,!],_7729,_7731) --> 
    w(nb(_7702,num),_7743,_7729,_7731),
    !.

personal('    ',[personal,lit(hysj)],_7723,_7725) --> 
    cc(hysj,_7723,_7725).

personal('RPGOLRAM',[personal,lit(rpgol)],_7723,_7725) --> 
    cc(rpgol,_7723,_7725).

personal('OK',[personal,lit(rpgolram)],_7723,_7725) --> 
    cc(rpgolram,_7723,_7725).

personal('Takk',[personal,lit(værsågod)],_7723,_7725) --> 
    cc(værsågod,_7723,_7725).

personal('Takk',[personal,_7754,lit(så),_7794],_7740,_7742) --> 
    w(verb(be,imp,fin),_7754,_7740,_7771),
    cc(så,_7771,_7793),
    w(adj2(good,nil),_7794,_7793,_7742).

personal('Takk',[personal,_7744,_7768,_7792,_7816],_7730,_7732) --> 
    so(_7744,_7730,_7759),
    good(_7768,_7759,_7783),
    you(_7792,_7783,_7807),
    be(_7816,_7807,_7732).

personal('Takk',[personal,lit(bravo)],_7723,_7725) --> 
    cc(bravo,_7723,_7725).

personal('Takk',[personal,_7747,_7776,_7800],_7733,_7735) --> 
    w(verb(congratulate,pres,fin),_7747,_7733,_7764),
    with0(_7776,_7764,_7791),
    skip_rest(_7800,_7791,_7735).

personal(pong,[personal,lit(ping)],_7723,_7725) --> 
    cc(ping,_7723,_7725).

personal(_7702,[personal,_7737],_7723,_7725) --> 
    greetings(_7702,_7737,_7723,_7725).

greetings0([greetings0,_7740,_7769,!],_7729,_7731) --> 
    w(verb(help,imp,fin),_7740,_7729,_7757),
    optoken(_7769,_7757,_7731),
    !.

greetings0([greetings0,_7739,_7783,_7807,!],_7728,_7730) --> 
    optional(grums,_7739,_7728,_7771),
    greetings(_7783,_7771,_7798),
    optoken(_7807,_7798,_7730),
    !.

greetings0([greetings0,_7730],_7719,_7721) --> 
    optional(grums,_7730,_7719,_7721).

greetings('OK',[greetings,_7738,_7762],_7724,_7726) --> 
    okeys(_7738,_7724,_7753),
    endofline(_7762,_7753,_7726).

greetings('Hei på deg',[greetings,_7738,_7762],_7724,_7726) --> 
    hello(_7738,_7724,_7753),
    daddy(_7762,_7753,_7726).

greetings('Hei',[greetings,_7735],_7721,_7723) --> 
    greetings(_7735,_7721,_7723).

daddy([daddy,_7738,!],_7727,_7729) --> 
    w(noun(father,sin,u,n),_7738,_7727,_7729),
    !.

daddy([daddy,_7738,!],_7727,_7729) --> 
    w(noun(mother,sin,u,n),_7738,_7727,_7729),
    !.

daddy([daddy,_7737,!],_7726,_7728) --> 
    w(name(_7707,n,man),_7737,_7726,_7728),
    !.

optoken([optoken,lit(:)],_7719,_7721) --> 
    cc(:,_7719,_7721).

optoken([optoken,lit(!)],_7719,_7721) --> 
    cc(!,_7719,_7721).

optoken([optoken,lit('.')],_7719,_7721) --> 
    cc('.',_7719,_7721).

optoken([optoken,[]],_7717,_7717) --> 
    [].

greetings([greetings,lit(_7707),{}],_7737,_7739) --> 
    cc(_7707,_7737,_7739),
    {user:testmember(_7707,[ja,jo,joda,nei,neida])}.

greetings([greetings,_7728],_7717,_7719) --> 
    hellos(_7728,_7717,_7719).

greetings([greetings,lit(hva),lit(om)],_7724,_7726) --> 
    cc(hva,_7724,_7745),
    cc(om,_7745,_7726).

greetings([greetings,lit(nei)],_7719,_7721) --> 
    cc(nei,_7719,_7721).

greetings([greetings,lit(o),_7750,_7774],_7728,_7730) --> 
    cc(o,_7728,_7749),
    adj0(_7750,_7749,_7765),
    np0(_7708,_7709,_7774,_7765,_7730).

greetings([greetings,_7739,lit(meg)],_7728,_7730) --> 
    w(verb(say,inf,fin),_7739,_7728,_7756),
    cc(meg,_7756,_7730).

greetings([greetings,_7762,{},_7801,_7825,!],_7751,_7753) --> 
    w(noun(_7716,sin,u,n),_7762,_7751,_7779),
    {user:testmember(_7716,[oracle,brother,sister])},
    colon0(_7801,_7779,_7816),
    look_ahead([når],_7825,_7816,_7753),
    !.

greetings([greetings,_7763,{},_7802,_7826],_7752,_7754) --> 
    w(noun(_7721,sin,u,n),_7763,_7752,_7780),
    {user:testmember(_7721,[oracle,brother,sister])},
    colon0(_7802,_7780,_7817),
    not_look_ahead(w(verb(_7715,_7716,fin)),_7826,_7817,_7754).

greetings([greetings,_7770,_7799,_7828,_7857,_7881,_7910,_7934],_7759,_7761) --> 
    w(name(bustuc,n,_7724),_7770,_7759,_7787),
    not_look_ahead([som],_7799,_7787,_7816),
    not_look_ahead(w(prep(_7734)),_7828,_7816,_7845),
    colon0(_7857,_7845,_7872),
    not_look_ahead(w(verb(_7740,_7741,_7742)),_7881,_7872,_7898),
    not_look_ahead_vp(_7910,_7898,_7925),
    not_look_ahead_np(_7934,_7925,_7761).

trafikk([trafikk,lit(trafikk)],_7719,_7721) --> 
    cc(trafikk,_7719,_7721).

trafikk([trafikk,lit(t)],_7719,_7721) --> 
    cc(t,_7719,_7721).

grums0([grums0,[]],_7717,_7717) --> 
    [].

grums([grums,lit(rute),{}],_7727,_7729) --> 
    cc(rute,_7727,_7729),
    {user:value(smsflag,true)}.

grums([grums,lit('.')],_7719,_7721) --> 
    cc('.',_7719,_7721).

grums([grums,lit(?)],_7719,_7721) --> 
    cc(?,_7719,_7721).

grums([grums,lit(:),!],_7722,_7724) --> 
    cc(:,_7722,_7724),
    !.

grums([grums,lit(/),!],_7722,_7724) --> 
    cc(/,_7722,_7724),
    !.

grums([grums,lit(!),!],_7722,_7724) --> 
    cc(!,_7722,_7724),
    !.

grums([grums,lit(-),!],_7722,_7724) --> 
    cc(-,_7722,_7724),
    !.

grums([grums,lit(eksempelvis),lit(:)],_7724,_7726) --> 
    cc(eksempelvis,_7724,_7745),
    cc(:,_7745,_7726).

grums([grums,_7733,lit(at)],_7722,_7724) --> 
    redundant(_7733,_7722,_7748),
    cc(at,_7748,_7724).

grums([grums,_7757,lit(:),_7797,!],_7746,_7748) --> 
    w(noun(_7713,sin,u,n),_7757,_7746,_7774),
    cc(:,_7774,_7796),
    gmem(_7713,[error,thing,subject,example],_7797,_7796,_7748),
    !.

grums([grums,_7741,lit(om),!],_7730,_7732) --> 
    w(adj2(good,nil),_7741,_7730,_7758),
    cc(om,_7758,_7732),
    !.

grums([grums,lit(bare)],_7719,_7721) --> 
    cc(bare,_7719,_7721).

grums([grums,lit(eller)],_7719,_7721) --> 
    cc(eller,_7719,_7721).

grums([grums,lit(fyi),_7744],_7722,_7724) --> 
    cc(fyi,_7722,_7743),
    point0(_7744,_7743,_7724).

grums([grums,lit(grr)],_7719,_7721) --> 
    cc(grr,_7719,_7721).

grums([grums,lit(huff)],_7719,_7721) --> 
    cc(huff,_7719,_7721).

grums([grums,lit(igjen)],_7719,_7721) --> 
    cc(igjen,_7719,_7721).

grums([grums,lit(jo)],_7719,_7721) --> 
    cc(jo,_7719,_7721).

grums([grums,lit(og)],_7719,_7721) --> 
    cc(og,_7719,_7721).

grums([grums,lit(kort),lit(sagt)],_7724,_7726) --> 
    cc(kort,_7724,_7745),
    cc(sagt,_7745,_7726).

grums([grums,lit(men)],_7719,_7721) --> 
    cc(men,_7719,_7721).

grums([grums,lit(nei),lit(men)],_7724,_7726) --> 
    cc(nei,_7724,_7745),
    cc(men,_7745,_7726).

grums([grums,lit(nb)],_7719,_7721) --> 
    cc(nb,_7719,_7721).

grums([grums,lit(nei),_7752],_7730,_7732) --> 
    cc(nei,_7730,_7751),
    look_ahead(w(verb(_7709,_7710,_7711)),_7752,_7751,_7732).

grums([grums,lit(ja),_7752],_7730,_7732) --> 
    cc(ja,_7730,_7751),
    look_ahead(w(verb(_7709,_7710,_7711)),_7752,_7751,_7732).

grums([grums,lit(typisk)],_7719,_7721) --> 
    cc(typisk,_7719,_7721).

grums([grums,lit(uff)],_7719,_7721) --> 
    cc(uff,_7719,_7721).

grums([grums,lit(vel)],_7719,_7721) --> 
    cc(vel,_7719,_7721).

grums([grums,lit(å),_7744],_7722,_7724) --> 
    cc(å,_7722,_7743),
    not_look_ahead_vp(_7744,_7743,_7724).

grums([grums,_7736,_7765],_7725,_7727) --> 
    w(nb(1939,num),_7736,_7725,_7753),
    point0(_7765,_7753,_7727).

grums([grums,_7749,_7793,_7822],_7738,_7740) --> 
    optional([for],_7749,_7738,_7781),
    w(noun(example,sin,u,n),_7793,_7781,_7810),
    optional([:],_7822,_7810,_7740).

grums([grums,_7740,lit(:)],_7729,_7731) --> 
    w(noun(question,sin,u,n),_7740,_7729,_7757),
    cc(:,_7757,_7731).

grums([grums,lit(svar),_7748],_7726,_7728) --> 
    cc(svar,_7726,_7747),
    optional([:],_7748,_7747,_7728).

grums([grums,lit(n),lit(:)],_7724,_7726) --> 
    cc(n,_7724,_7745),
    cc(:,_7745,_7726).

grums([grums,_7741,_7770,!],_7730,_7732) --> 
    w(noun(traffic,sin,u,n),_7741,_7730,_7758),
    colon(_7770,_7758,_7732),
    !.

grums([grums,_7737,lit(tt)],_7726,_7728) --> 
    not_look_ahead([dere],_7737,_7726,_7754),
    cc(tt,_7754,_7728).

grums([grums,lit(så),_7752,!],_7730,_7732) --> 
    cc(så,_7730,_7751),
    w(adj2(funny,nil),_7752,_7751,_7732),
    !.

grums([grums,lit(så),_7744],_7722,_7724) --> 
    cc(så,_7722,_7743),
    not_look_ahead_vp(_7744,_7743,_7724).

grums([grums,lit(ja),lit(så),_7760],_7727,_7729) --> 
    cc(ja,_7727,_7748),
    cc(så,_7748,_7759),
    not_look_ahead_vp(_7760,_7759,_7729).

grums([grums,lit(nb),_7752],_7730,_7732) --> 
    cc(nb,_7730,_7751),
    one_of_lit(['.',:,!],_7752,_7751,_7732).

grums([grums,lit(obs),_7752],_7730,_7732) --> 
    cc(obs,_7730,_7751),
    one_of_lit(['.',:,!],_7752,_7751,_7732).

grums([grums,lit(unnskyld),lit(men)],_7724,_7726) --> 
    cc(unnskyld,_7724,_7745),
    cc(men,_7745,_7726).

grums([grums,lit(ok),_7752],_7730,_7732) --> 
    cc(ok,_7730,_7751),
    look_ahead(w(verb(_7709,imp,fin)),_7752,_7751,_7732).

grums([grums,lit(supert)],_7719,_7721) --> 
    cc(supert,_7719,_7721).

team([team,_7734],_7723,_7725) --> 
    w(name(team,_7705,_7706),_7734,_7723,_7725).

team([team,lit(team)],_7719,_7721) --> 
    cc(team,_7719,_7721).

hellos([hellos,_7734,_7758,_7782],_7723,_7725) --> 
    hello(_7734,_7723,_7749),
    sludder0(_7758,_7749,_7773),
    hellos0(_7782,_7773,_7725).

hellos0([hellos0,_7728],_7717,_7719) --> 
    hellos(_7728,_7717,_7719).

hellos0([hellos0,[]],_7717,_7717) --> 
    [].

adj0([adj0,_7739,!,_7773],_7728,_7730) --> 
    w(adj2(_7710,_7711),_7739,_7728,_7756),
    !,
    accept(_7773,_7756,_7730).

adj0([adj0,[]],_7717,_7717) --> 
    [].

hei([hei,lit(hei),_7744],_7722,_7724) --> 
    cc(hei,_7722,_7743),
    der0(_7744,_7743,_7724).

hei([hei,lit(hallo),_7744],_7722,_7724) --> 
    cc(hallo,_7722,_7743),
    der0(_7744,_7743,_7724).

sludder0([sludder0,_7731,!],_7720,_7722) --> 
    sludder(_7731,_7720,_7722),
    !.

sludder0([sludder0,[]],_7717,_7717) --> 
    [].

sludder([sludder,lit(alle),lit(sammen),!],_7727,_7729) --> 
    cc(alle,_7727,_7748),
    cc(sammen,_7748,_7729),
    !.

sludder([sludder,lit(der),!],_7722,_7724) --> 
    cc(der,_7722,_7724),
    !.

sludder([sludder,lit(du),_7755,!],_7733,_7735) --> 
    cc(du,_7733,_7754),
    not_look_ahead(w(verb(_7714,_7715,_7716)),_7755,_7754,_7735),
    !.

sludder([sludder,_7748,_7777,!],_7737,_7739) --> 
    w(name(tuc,n,_7712),_7748,_7737,_7765),
    not_look_ahead(w(verb(_7718,_7719,_7720)),_7777,_7765,_7739),
    !.

sludder([sludder,_7737,!],_7726,_7728) --> 
    w(name(bustuc,n,_7709),_7737,_7726,_7728),
    !.

sludder([sludder,_7737,!],_7726,_7728) --> 
    w(name(tt,n,_7709),_7737,_7726,_7728),
    !.

sludder([sludder,_7737,!],_7726,_7728) --> 
    w(name(tagore,n,_7709),_7737,_7726,_7728),
    !.

sludder([sludder,_7737,!],_7726,_7728) --> 
    w(name(tore,n,_7709),_7737,_7726,_7728),
    !.

sludder([sludder,_7738,!],_7727,_7729) --> 
    w(noun(computer,sin,u,n),_7738,_7727,_7729),
    !.

sludder([sludder,_7738,!],_7727,_7729) --> 
    w(noun(oracle,sin,_7709,n),_7738,_7727,_7729),
    !.

sludder([sludder,_7738,!],_7727,_7729) --> 
    w(noun(man,sin,u,n),_7738,_7727,_7729),
    !.

sludder([sludder,_7738,!],_7727,_7729) --> 
    w(noun(sweetheart,sin,u,n),_7738,_7727,_7729),
    !.

okeys0([okeys0,_7728],_7717,_7719) --> 
    okeys(_7728,_7717,_7719).

okeys0([okeys0,[]],_7717,_7717) --> 
    [].

okeys([okeys,lit(ok),_7758,_7802,_7846],_7736,_7738) --> 
    cc(ok,_7736,_7757),
    optional([ja],_7758,_7757,_7790),
    optional([men],_7802,_7790,_7834),
    optoken(_7846,_7834,_7738).

hello([hello,lit(bra)],_7719,_7721) --> 
    cc(bra,_7719,_7721).

hello([hello,_7728],_7717,_7719) --> 
    okeys(_7728,_7717,_7719).

hello([hello,_7736,_7760,_7804],_7725,_7727) --> 
    hei(_7736,_7725,_7751),
    optional(paadeg,_7760,_7751,_7792),
    sludder0(_7804,_7792,_7727).

hello([hello,lit(goddag)],_7719,_7721) --> 
    cc(goddag,_7719,_7721).

hello([hello,_7761,_7790,{}],_7750,_7752) --> 
    w(adj2(good,nil),_7761,_7750,_7778),
    w(noun(_7710,_7731,_7732,_7733),_7790,_7778,_7752),
    {user:testmember(_7710,[day,morning,evening,night,afternoon])}.

paadeg([paadeg,_7741,lit(deg),!,_7786],_7730,_7732) --> 
    prep1(on,_7741,_7730,_7758),
    cc(deg,_7758,_7780),
    !,
    accept(_7786,_7780,_7732).

paadeg([paadeg,lit(og),lit(hå),!,_7768],_7730,_7732) --> 
    cc(og,_7730,_7751),
    cc(hå,_7751,_7762),
    !,
    accept(_7768,_7762,_7732).

forhjelpen0([forhjelpen0,_7738,lit(alt),!],_7727,_7729) --> 
    prep1(for,_7738,_7727,_7755),
    cc(alt,_7755,_7729),
    !.

forhjelpen0([forhjelpen0,_7749,_7778,_7807,!],_7738,_7740) --> 
    prep1(for,_7749,_7738,_7766),
    w(noun(_7715,sin,def,n),_7778,_7766,_7795),
    np1(_7720,_7721,_7807,_7795,_7740),
    !.

forhjelpen0([forhjelpen0,_7743,_7772,!],_7732,_7734) --> 
    prep1(for,_7743,_7732,_7760),
    w(noun(_7712,sin,def,n),_7772,_7760,_7734),
    !.

forhjelpen0([forhjelpen0,_7739,_7768,!],_7728,_7730) --> 
    prep1(for,_7739,_7728,_7756),
    np1(_7710,_7711,_7768,_7756,_7730),
    !.

forhjelpen0([forhjelpen0,lit(skal),lit(du),_7766],_7733,_7735) --> 
    cc(skal,_7733,_7754),
    cc(du,_7754,_7765),
    w(verb(have,imp,fin),_7766,_7765,_7735).

forhjelpen0([forhjelpen0,[]],_7717,_7717) --> 
    [].

hadet([hadet,lit(ha),lit(de),_7760],_7727,_7729) --> 
    cc(ha,_7727,_7748),
    cc(de,_7748,_7759),
    paabadet0(_7760,_7759,_7729).

hadet([hadet,lit(ha),lit(det),_7760],_7727,_7729) --> 
    cc(ha,_7727,_7748),
    cc(det,_7748,_7759),
    paabadet0(_7760,_7759,_7729).

hadet([hadet,lit(hadet),_7744],_7722,_7724) --> 
    cc(hadet,_7722,_7743),
    paabadet0(_7744,_7743,_7724).

hadet([hadet,lit(hade),_7744],_7722,_7724) --> 
    cc(hade,_7722,_7743),
    paabadet0(_7744,_7743,_7724).

kan([kan,_7734],_7723,_7725) --> 
    w(verb(know,_7705,fin),_7734,_7723,_7725).

kan([kan,lit(kan)],_7719,_7721) --> 
    cc(kan,_7719,_7721).

paabadet0([paabadet0,_7741,lit(badet),!,_7786],_7730,_7732) --> 
    prep1(on,_7741,_7730,_7758),
    cc(badet,_7758,_7780),
    !,
    accept(_7786,_7780,_7732).

paabadet0([paabadet0,[]],_7717,_7717) --> 
    [].

quit(thanks,[quit,_7753,_7782,!],_7739,_7741) --> 
    w(adj2(good,nil),_7753,_7739,_7770),
    w(noun(trip,sin,u,n),_7782,_7770,_7741),
    !.

quit(bye,[quit,_7744,_7773],_7730,_7732) --> 
    w(verb(hear,pres,pass),_7744,_7730,_7761),
    skip_rest(_7773,_7761,_7732).

quit(bye,[quit,_7744,_7773],_7730,_7732) --> 
    w(verb(see,pres,pass),_7744,_7730,_7761),
    skip_rest(_7773,_7761,_7732).

quit(bye,[quit,_7744,_7773],_7730,_7732) --> 
    w(verb(tals,pres,pass),_7744,_7730,_7761),
    skip_rest(_7773,_7761,_7732).

quit(bye,[quit,lit(med),lit(vennlig),_7777,_7806],_7741,_7743) --> 
    cc(med,_7741,_7765),
    cc(vennlig,_7765,_7776),
    w(noun(greeting,_7720,_7721,_7722),_7777,_7776,_7794),
    skip_rest(_7806,_7794,_7743).

quit(bye,[quit,lit(vennlig),_7761,_7790],_7736,_7738) --> 
    cc(vennlig,_7736,_7760),
    w(noun(greeting,_7715,_7716,_7717),_7761,_7760,_7778),
    skip_rest(_7790,_7778,_7738).

quit(bye,[quit,_7745,_7774],_7731,_7733) --> 
    w(noun(greeting,_7710,_7711,_7712),_7745,_7731,_7762),
    skip_rest(_7774,_7762,_7733).

quit(bye,[quit,_7742],_7728,_7730) --> 
    w(noun(midnight,plu,def,n),_7742,_7728,_7730).

quit(bye,[quit,lit(jeg),lit(snakkes),_7767],_7731,_7733) --> 
    cc(jeg,_7731,_7755),
    cc(snakkes,_7755,_7766),
    skip_rest(_7767,_7766,_7733).

quit(bye,[quit,_7741],_7727,_7729) --> 
    w(verb(stop,imp,_7708),_7741,_7727,_7729).

quit(bye,[quit,lit(adjø)],_7723,_7725) --> 
    cc(adjø,_7723,_7725).

quit(bye,[quit,lit(på),lit(gjensyn)],_7728,_7730) --> 
    cc(på,_7728,_7752),
    cc(gjensyn,_7752,_7730).

quit(bye,[quit,_7735],_7721,_7723) --> 
    hadet(_7735,_7721,_7723).

quit(bye,[quit,_7738,_7762],_7724,_7726) --> 
    hadet(_7738,_7724,_7753),
    godt(_7762,_7753,_7726).

quit(bye,[quit,lit(hei),lit(da)],_7728,_7730) --> 
    cc(hei,_7728,_7752),
    cc(da,_7752,_7730).

quit(bye,[quit,lit(godnatt)],_7723,_7725) --> 
    cc(godnatt,_7723,_7725).

quit(bye,[quit,_7764,_7788,_7812,{}],_7750,_7752) --> 
    haen0(_7764,_7750,_7779),
    godt(_7788,_7779,_7803),
    w(noun(_7715,_7729,_7730,_7731),_7812,_7803,_7752),
    {user:testmember(_7715,[midnight,weekend,easter,summer])}.

quit(bye,[quit,lit(takk),_7768,_7797,_7826],_7743,_7745) --> 
    cc(takk,_7743,_7767),
    prep1(for,_7768,_7767,_7785),
    prep1(in,_7797,_7785,_7814),
    w(noun(day,sin,u,n),_7826,_7814,_7745).

quit(bye,[quit,_7754,_7778,_7807],_7740,_7742) --> 
    good0(_7754,_7740,_7769),
    w(noun(greeting,_7719,_7720,_7721),_7778,_7769,_7795),
    w(name(_7712,_7713,_7714),_7807,_7795,_7742).

quit(bye,[quit,_7755,_7779,_7808],_7741,_7743) --> 
    good0(_7755,_7741,_7770),
    w(noun(greeting,_7720,_7721,_7722),_7779,_7770,_7796),
    w(noun(_7712,_7713,_7714,_7715),_7808,_7796,_7743).

quit(bye,[quit,lit(far),lit(vel)],_7728,_7730) --> 
    cc(far,_7728,_7752),
    cc(vel,_7752,_7730).

quit(bye,[quit,_7764,_7808,lit(en),_7848,_7872],_7750,_7752) --> 
    optional(hello,_7764,_7750,_7796),
    w(verb(have,imp,_7729),_7808,_7796,_7825),
    cc(en,_7825,_7847),
    godt(_7848,_7847,_7863),
    w(noun(_7718,_7719,_7720,_7721),_7872,_7863,_7752).

quit(you_are_welcome,[quit,lit(på),lit(forhånd),_7770,!],_7734,_7736) --> 
    cc(på,_7734,_7758),
    cc(forhånd,_7758,_7769),
    thanks(_7770,_7769,_7736),
    !.

quit(you_are_welcome,[quit,_7746,_7775,!],_7732,_7734) --> 
    w(nb(1000,_7713),_7746,_7732,_7763),
    thanks(_7775,_7763,_7734),
    !.

quit(you_are_welcome,[quit,_7738,_7762],_7724,_7726) --> 
    thanks(_7738,_7724,_7753),
    alot(_7762,_7753,_7726).

quit(you_are_welcome,[quit,_7764,lit(å),_7804,_7833,lit(deg)],_7750,_7752) --> 
    w(adj2(nice,nil),_7764,_7750,_7781),
    cc(å,_7781,_7803),
    w(verb(speak,_7728,_7729),_7804,_7803,_7821),
    prep1(with,_7833,_7821,_7850),
    cc(deg,_7850,_7752).

quit(merry_christmas,[quit,_7740,lit(jul)],_7726,_7728) --> 
    godt(_7740,_7726,_7755),
    cc(jul,_7755,_7728).

quit(happy_new_year,[quit,_7738,_7762],_7724,_7726) --> 
    godt(_7738,_7724,_7753),
    newyear(_7762,_7753,_7726).

quit(bye,[quit,lit(hilsen),_7751],_7726,_7728) --> 
    cc(hilsen,_7726,_7750),
    skip_rest(_7751,_7750,_7728).

alot([alot,[]],_7717,_7717) --> 
    [].

alot([alot,lit(så),lit(mye)],_7724,_7726) --> 
    cc(så,_7724,_7745),
    cc(mye,_7745,_7726).

alot([alot,lit(så),lit(meget)],_7724,_7726) --> 
    cc(så,_7724,_7745),
    cc(meget,_7745,_7726).

alot([alot,lit(skal),lit(du),_7766],_7733,_7735) --> 
    cc(skal,_7733,_7754),
    cc(du,_7754,_7765),
    w(verb(have,inf,fin),_7766,_7765,_7735).

godt([godt,_7733],_7722,_7724) --> 
    w(adj2(good,nil),_7733,_7722,_7724).

godt([godt,_7734],_7723,_7725) --> 
    w(verb(go,past,part),_7734,_7723,_7725).

godt([godt,_7743,_7772],_7732,_7734) --> 
    w(adj2(good,nil),_7743,_7732,_7760),
    w(noun(day,sin,u,n),_7772,_7760,_7734).

deter0([deter0,_7734,!,_7763],_7723,_7725) --> 
    deter(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

deter0([deter0,_7734,!,_7763],_7723,_7725) --> 
    endofline(_7734,_7723,_7749),
    !,
    reject(_7763,_7749,_7725).

deter0([deter0,[]],_7717,_7717) --> 
    [].

deter([deter,lit(det),_7750,!,_7779],_7728,_7730) --> 
    cc(det,_7728,_7749),
    be(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

deter([deter,lit(dette),_7750,!,_7779],_7728,_7730) --> 
    cc(dette,_7728,_7749),
    be(_7750,_7749,_7765),
    !,
    accept(_7779,_7765,_7730).

haen0([haen0,lit(ha),lit(en),!,_7768],_7730,_7732) --> 
    cc(ha,_7730,_7751),
    cc(en,_7751,_7762),
    !,
    accept(_7768,_7762,_7732).

haen0([haen0,[]],_7717,_7717) --> 
    [].

personal('Takk',[personal,lit(velkommen),lit(til),!,_7775],_7734,_7736) --> 
    cc(velkommen,_7734,_7758),
    cc(til,_7758,_7769),
    !,
    skip_rest(_7775,_7769,_7736).

personal('Takk',[personal,lit(velkommen)],_7723,_7725) --> 
    cc(velkommen,_7723,_7725).

personal('Takk',[personal,lit(god),_7758],_7733,_7735) --> 
    cc(god,_7733,_7757),
    w(noun(health,sin,u,n),_7758,_7757,_7735).

personal('OK',[personal,lit(ps)],_7723,_7725) --> 
    cc(ps,_7723,_7725).

personal('OK',[personal,_7743,_7787,_7811],_7729,_7731) --> 
    optional(hello,_7743,_7729,_7775),
    so0(_7787,_7775,_7802),
    persok(_7811,_7802,_7731).

persok([persok,_7728],_7717,_7719) --> 
    okeys(_7728,_7717,_7719).

persok([persok,_7734],_7723,_7725) --> 
    w(verb(test,imp,fin),_7734,_7723,_7725).

persok([persok,lit(bra),_7744],_7722,_7724) --> 
    cc(bra,_7722,_7743),
    endofline(_7744,_7743,_7724).

persok([persok,lit(sorry)],_7719,_7721) --> 
    cc(sorry,_7719,_7721).

persok([persok,_7747,lit(så),_7787],_7736,_7738) --> 
    w(verb(be,imp,fin),_7747,_7736,_7764),
    cc(så,_7764,_7786),
    w(adj2(good,nil),_7787,_7786,_7738).

persok([persok,_7739,lit(det)],_7728,_7730) --> 
    w(verb(forget,imp,fin),_7739,_7728,_7756),
    cc(det,_7756,_7730).

persok([persok,_7743,_7772],_7732,_7734) --> 
    w(verb(forget,imp,fin),_7743,_7732,_7760),
    np(_7705,_7708:_7709,_7772,_7760,_7734).

persok([persok,_7745,lit(du),_7785,_7809],_7734,_7736) --> 
    w(verb(be,_7714,fin),_7745,_7734,_7762),
    cc(du,_7762,_7784),
    good(_7785,_7784,_7800),
    dadanow0(_7809,_7800,_7736).

persok([persok,lit(unnskyld)],_7719,_7721) --> 
    cc(unnskyld,_7719,_7721).

persok([persok,lit(hvordan),_7763,lit(du),lit(det),_7814],_7741,_7743) --> 
    cc(hvordan,_7741,_7762),
    w(verb(have,_7719,fin),_7763,_7762,_7780),
    cc(du,_7780,_7802),
    cc(det,_7802,_7813),
    dadanow0(_7814,_7813,_7743).

persok([persok,lit(hvordan),_7766,lit(det),_7806,_7835,_7859],_7744,_7746) --> 
    cc(hvordan,_7744,_7765),
    w(verb(stand,pres,fin),_7766,_7765,_7783),
    cc(det,_7783,_7805),
    prep1(to,_7806,_7805,_7823),
    withyou0(_7835,_7823,_7850),
    dadanow0(_7859,_7850,_7746).

persok([persok,_7758,lit(det),_7798,_7827,_7856,_7880],_7747,_7749) --> 
    w(verb(stand,pres,fin),_7758,_7747,_7775),
    cc(det,_7775,_7797),
    w(adj2(good,nil),_7798,_7797,_7815),
    prep1(to,_7827,_7815,_7844),
    withyou0(_7856,_7844,_7871),
    dadanow0(_7880,_7871,_7749).

persok([persok,_7739,_7768],_7728,_7730) --> 
    w(verb(stand,pres,fin),_7739,_7728,_7756),
    prep1(to,_7768,_7756,_7730).

persok([persok,lit(hvordan),_7754,_7778],_7732,_7734) --> 
    cc(hvordan,_7732,_7753),
    be(_7754,_7753,_7769),
    w(noun(situation,sin,def,n),_7778,_7769,_7734).

persok([persok,lit(hva),_7754,_7778],_7732,_7734) --> 
    cc(hva,_7732,_7753),
    be(_7754,_7753,_7769),
    w(noun(situation,sin,def,n),_7778,_7769,_7734).

persok([persok,_7755,lit(du),lit(det),_7806,_7835],_7744,_7746) --> 
    w(verb(have,_7717,fin),_7755,_7744,_7772),
    cc(du,_7772,_7794),
    cc(det,_7794,_7805),
    w(adj2(_7726,nil),_7806,_7805,_7823),
    dadanow0(_7835,_7823,_7746).

persok([persok,lit(jeg),_7769,lit(det),_7809,_7838,_7862,_7886],_7747,_7749) --> 
    cc(jeg,_7747,_7768),
    w(verb(have,_7725,fin),_7769,_7768,_7786),
    cc(det,_7786,_7808),
    negation0(_7730,_7809,_7808,_7826),
    so0(_7838,_7826,_7853),
    good(_7862,_7853,_7877),
    dadanow0(_7886,_7877,_7749).

persok([persok,lit(hvordan),_7761,lit(det),_7801,_7825],_7739,_7741) --> 
    cc(hvordan,_7739,_7760),
    w(verb(go,pres,fin),_7761,_7760,_7778),
    cc(det,_7778,_7800),
    withyou0(_7801,_7800,_7816),
    dadanow0(_7825,_7816,_7741).

persok([persok,_7760,lit(det),_7800,_7844,_7873,_7897],_7749,_7751) --> 
    w(verb(go,pres,fin),_7760,_7749,_7777),
    cc(det,_7777,_7799),
    optional([ikke],_7800,_7799,_7832),
    w(adj2(good,nil),_7844,_7832,_7861),
    withyou0(_7873,_7861,_7888),
    dadanow0(_7897,_7888,_7751).

persok([persok,lit(greitt)],_7719,_7721) --> 
    cc(greitt,_7719,_7721).

persok([persok,_7736,_7765],_7725,_7727) --> 
    w(adj2(good,nil),_7736,_7725,_7753),
    endofline(_7765,_7753,_7727).

thanks([thanks,_7737,_7761,_7785,_7809],_7726,_7728) --> 
    ogmen0(_7737,_7726,_7752),
    thousands0(_7761,_7752,_7776),
    takk(_7785,_7776,_7800),
    forhjelpen0(_7809,_7800,_7728).

takk([takk,_7733,lit(takk)],_7722,_7724) --> 
    hellos0(_7733,_7722,_7748),
    cc(takk,_7748,_7724).

takk([takk,_7734],_7723,_7725) --> 
    w(verb(thank,pres,fin),_7734,_7723,_7725).

takk([takk,lit(jeg),lit(vil),_7766],_7733,_7735) --> 
    cc(jeg,_7733,_7754),
    cc(vil,_7754,_7765),
    w(verb(thank,inf,_7712),_7766,_7765,_7735).

ogmen0([ogmen0,lit(og),!,_7752],_7725,_7727) --> 
    cc(og,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

ogmen0([ogmen0,lit(men),!,_7752],_7725,_7727) --> 
    cc(men,_7725,_7746),
    !,
    accept(_7752,_7746,_7727).

ogmen0([ogmen0,[]],_7717,_7717) --> 
    [].

thousands0([thousands0,_7734,!,_7763],_7723,_7725) --> 
    thousand(_7734,_7723,_7749),
    !,
    thousands0(_7763,_7749,_7725).

thousands0([thousands0,[]],_7717,_7717) --> 
    [].

thousand0([thousand0,_7734,!,_7763],_7723,_7725) --> 
    thousand(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

thousand0([thousand0,[]],_7717,_7717) --> 
    [].

thousand([thousand,_7739,!,_7773],_7728,_7730) --> 
    number(1000:_7711,_7739,_7728,_7756),
    !,
    accept(_7773,_7756,_7730).

thousand([thousand,_7728],_7717,_7719) --> 
    many1(_7728,_7717,_7719).

withyou0([withyou0,_7741,lit(_7712),!,_7786],_7730,_7732) --> 
    prep1(with,_7741,_7730,_7758),
    cc(_7712,_7758,_7780),
    !,
    accept(_7786,_7780,_7732).

withyou0([withyou0,[]],_7717,_7717) --> 
    [].

dadanow0([dadanow0,_7731,_7755],_7720,_7722) --> 
    todax(_7731,_7720,_7746),
    danow0(_7755,_7746,_7722).

dadanow0([dadanow0,_7728],_7717,_7719) --> 
    danow0(_7728,_7717,_7719).

danow0([danow0,_7743,_7772,lit(nå),!],_7732,_7734) --> 
    look_ahead([nå],_7743,_7732,_7760),
    notreachphrase(_7772,_7760,_7787),
    cc(nå,_7787,_7734),
    !.

danow0([danow0,[]],_7717,_7717) --> 
    [].

notreachphrase([notreachphrase,_7734,!,_7763],_7723,_7725) --> 
    reachphrase(_7734,_7723,_7749),
    !,
    reject(_7763,_7749,_7725).

notreachphrase([notreachphrase,[]],_7717,_7717) --> 
    [].

reachphrase([reachphrase,_7740,_7769,!],_7729,_7731) --> 
    w(verb(reach,inf,fin),_7740,_7729,_7757),
    look_ahead_np(_7769,_7757,_7731),
    !.

danow0([danow0,_7731,!],_7720,_7722) --> 
    danow(_7731,_7720,_7722),
    !.

danow0([danow0,[]],_7717,_7717) --> 
    [].

danow([danow,_7738,_7767,!],_7727,_7729) --> 
    w(adv(now),_7738,_7727,_7755),
    danow(_7767,_7755,_7729),
    !.

danow([danow,_7732],_7721,_7723) --> 
    w(adv(now),_7732,_7721,_7723).

danow([danow,lit(da),_7744],_7722,_7724) --> 
    cc(da,_7722,_7743),
    danow(_7744,_7743,_7724).

todax([todax,_7734,!,_7763],_7723,_7725) --> 
    today(_7734,_7723,_7749),
    !,
    accept(_7763,_7749,_7725).

todax([todax,_7741,lit(går),!,_7786],_7730,_7732) --> 
    prep1(in,_7741,_7730,_7758),
    cc(går,_7758,_7780),
    !,
    accept(_7786,_7780,_7732).

good0([good0,_7737,_7761,!,_7790],_7726,_7728) --> 
    so0(_7737,_7726,_7752),
    good(_7761,_7752,_7776),
    !,
    accept(_7790,_7776,_7728).

good0([good0,[]],_7717,_7717) --> 
    [].

good([good,_7733],_7722,_7724) --> 
    w(adj2(good,nil),_7733,_7722,_7724).

good([good,_7733],_7722,_7724) --> 
    w(adj2(clever,nil),_7733,_7722,_7724).

good([good,_7733],_7722,_7724) --> 
    w(adj2(fast,nil),_7733,_7722,_7724).

good([good,_7733],_7722,_7724) --> 
    w(adj2(funny,nil),_7733,_7722,_7724).

good([good,_7733],_7722,_7724) --> 
    w(adj2(honest,nil),_7733,_7722,_7724).

good([good,_7733],_7722,_7724) --> 
    w(adj2(nice,nil),_7733,_7722,_7724).

good([good,_7728],_7717,_7719) --> 
    okeys(_7728,_7717,_7719).

gmem(_7702,_7703,[gmem,{}],_7729,_7729) --> 
    {user:testmember(_7702,_7703)}.

panic(_7702,[panic,{}],_7725,_7725) --> 
    {user:write(_7702)}.

traceprint(_7702,_7703,[traceprint,{}],_7729,_7729) --> 
    {user:traceprint(_7702,_7703)}.

% Auxillary tables created datetime(2012,2,15,17,59,20)

%% Automatically created by metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

optional(itrailer,[optional,_7953,!],_7939,_7941) --> 
    itrailer(_7953,_7939,_7941),
    !.

optional([kanskje],[optional,lit(kanskje),!],_7941,_7943) --> 
    cc(kanskje,_7941,_7943),
    !.

optional([at],[optional,lit(at),!],_7941,_7943) --> 
    cc(at,_7941,_7943),
    !.

optional(grums,[optional,_7953,!],_7939,_7941) --> 
    grums(_7953,_7939,_7941),
    !.

optional(grums,[optional,_7953,!],_7939,_7941) --> 
    grums(_7953,_7939,_7941),
    !.

optional([ofte],[optional,lit(ofte),!],_7941,_7943) --> 
    cc(ofte,_7941,_7943),
    !.

optional([som],[optional,lit(som),!],_7941,_7943) --> 
    cc(som,_7941,_7943),
    !.

optional([','],[optional,lit(','),!],_7941,_7943) --> 
    cc(',',_7941,_7943),
    !.

optional([at],[optional,lit(at),!],_7941,_7943) --> 
    cc(at,_7941,_7943),
    !.

optional([meget],[optional,lit(meget),!],_7941,_7943) --> 
    cc(meget,_7941,_7943),
    !.

optional([det],[optional,lit(det),!],_7941,_7943) --> 
    cc(det,_7941,_7943),
    !.

optional([å],[optional,lit(å),!],_7941,_7943) --> 
    cc(å,_7941,_7943),
    !.

optional([å],[optional,lit(å),!],_7941,_7943) --> 
    cc(å,_7941,_7943),
    !.

optional([an],[optional,lit(an),!],_7941,_7943) --> 
    cc(an,_7941,_7943),
    !.

optional([ut],[optional,lit(ut),!],_7941,_7943) --> 
    cc(ut,_7941,_7943),
    !.

optional([neste],[optional,lit(neste),!],_7941,_7943) --> 
    cc(neste,_7941,_7943),
    !.

optional([det],[optional,lit(det),!],_7941,_7943) --> 
    cc(det,_7941,_7943),
    !.

optional(itrailer,[optional,_7953,!],_7939,_7941) --> 
    itrailer(_7953,_7939,_7941),
    !.

optional(itrailer,[optional,_7953,!],_7939,_7941) --> 
    itrailer(_7953,_7939,_7941),
    !.

optional([alle],[optional,lit(alle),!],_7941,_7943) --> 
    cc(alle,_7941,_7943),
    !.

optional([at],[optional,lit(at),!],_7941,_7943) --> 
    cc(at,_7941,_7943),
    !.

optional([som],[optional,lit(som),!],_7941,_7943) --> 
    cc(som,_7941,_7943),
    !.

optional([gang],[optional,lit(gang),!],_7941,_7943) --> 
    cc(gang,_7941,_7943),
    !.

optional(much,[optional,_7953,!],_7939,_7941) --> 
    much(_7953,_7939,_7941),
    !.

optional(w(verb(be,inf,fin)),[optional,_7959,!],_7945,_7947) --> 
    w(verb(be,inf,fin),_7959,_7945,_7947),
    !.

optional(w(adj2(old,nil)),[optional,_7958,!],_7944,_7946) --> 
    w(adj2(old,nil),_7958,_7944,_7946),
    !.

optional([om],[optional,lit(om),!],_7941,_7943) --> 
    cc(om,_7941,_7943),
    !.

optional([for],[optional,lit(for),!],_7941,_7943) --> 
    cc(for,_7941,_7943),
    !.

optional([på],[optional,lit(på),!],_7941,_7943) --> 
    cc(på,_7941,_7943),
    !.

optional([om],[optional,lit(om),!],_7941,_7943) --> 
    cc(om,_7941,_7943),
    !.

optional([på],[optional,lit(på),!],_7941,_7943) --> 
    cc(på,_7941,_7943),
    !.

optional([om],[optional,lit(om),!],_7941,_7943) --> 
    cc(om,_7941,_7943),
    !.

optional([å],[optional,lit(å),!],_7941,_7943) --> 
    cc(å,_7941,_7943),
    !.

optional([på],[optional,lit(på),!],_7941,_7943) --> 
    cc(på,_7941,_7943),
    !.

optional([på],[optional,lit(på),!],_7941,_7943) --> 
    cc(på,_7941,_7943),
    !.

optional([å],[optional,lit(å),!],_7941,_7943) --> 
    cc(å,_7941,_7943),
    !.

optional([til],[optional,lit(til),!],_7941,_7943) --> 
    cc(til,_7941,_7943),
    !.

optional([da],[optional,lit(da),!],_7941,_7943) --> 
    cc(da,_7941,_7943),
    !.

optional([bare],[optional,lit(bare),!],_7941,_7943) --> 
    cc(bare,_7941,_7943),
    !.

optional(w(prep(_7922)),[optional,_7957,!],_7943,_7945) --> 
    w(prep(_7922),_7957,_7943,_7945),
    !.

optional([til],[optional,lit(til),!],_7941,_7943) --> 
    cc(til,_7941,_7943),
    !.

optional([med],[optional,lit(med),!],_7941,_7943) --> 
    cc(med,_7941,_7943),
    !.

optional([på],[optional,lit(på),!],_7941,_7943) --> 
    cc(på,_7941,_7943),
    !.

optional(w(noun(year,_7923,_7924,n)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(year,_7923,_7924,n),_7960,_7946,_7948),
    !.

optional(w(prep(in)),[optional,_7957,!],_7943,_7945) --> 
    w(prep(in),_7957,_7943,_7945),
    !.

optional(w(noun(year,sin,u,n)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(year,sin,u,n),_7960,_7946,_7948),
    !.

optional([i],[optional,lit(i),!],_7941,_7943) --> 
    cc(i,_7941,_7943),
    !.

optional([i],[optional,lit(i),!],_7941,_7943) --> 
    cc(i,_7941,_7943),
    !.

optional([i],[optional,lit(i),!],_7941,_7943) --> 
    cc(i,_7941,_7943),
    !.

optional(['.'],[optional,lit('.'),!],_7941,_7943) --> 
    cc('.',_7941,_7943),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(time,sin,def,n),_7960,_7946,_7948),
    !.

optional([nå],[optional,lit(nå),!],_7941,_7943) --> 
    cc(nå,_7941,_7943),
    !.

optional([denne],[optional,lit(denne),!],_7941,_7943) --> 
    cc(denne,_7941,_7943),
    !.

optional(w(noun(route,sin,u,n)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(route,sin,u,n),_7960,_7946,_7948),
    !.

optional(w(noun(route,sin,u,n)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(route,sin,u,n),_7960,_7946,_7948),
    !.

optional(w(noun(bus,sin,_7924,_7925)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(bus,sin,_7924,_7925),_7960,_7946,_7948),
    !.

optional([for],[optional,lit(for),!],_7941,_7943) --> 
    cc(for,_7941,_7943),
    !.

optional([til],[optional,lit(til),!],_7941,_7943) --> 
    cc(til,_7941,_7943),
    !.

optional([av],[optional,lit(av),!],_7941,_7943) --> 
    cc(av,_7941,_7943),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(time,sin,def,n),_7960,_7946,_7948),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(time,sin,def,n),_7960,_7946,_7948),
    !.

optional(w(noun(time,_7923,def,_7925)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(time,_7923,def,_7925),_7960,_7946,_7948),
    !.

optional(w(prep(in)),[optional,_7957,!],_7943,_7945) --> 
    w(prep(in),_7957,_7943,_7945),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7960,!],_7946,_7948) --> 
    w(noun(time,sin,def,n),_7960,_7946,_7948),
    !.

optional([h],[optional,lit(h),!],_7941,_7943) --> 
    cc(h,_7941,_7943),
    !.

optional([opp],[optional,lit(opp),!],_7941,_7943) --> 
    cc(opp,_7941,_7943),
    !.

optional([om],[optional,lit(om),!],_7941,_7943) --> 
    cc(om,_7941,_7943),
    !.

optional([mye],[optional,lit(mye),!],_7941,_7943) --> 
    cc(mye,_7941,_7943),
    !.

optional([nr],[optional,lit(nr),!],_7941,_7943) --> 
    cc(nr,_7941,_7943),
    !.

optional([slik],[optional,lit(slik),!],_7941,_7943) --> 
    cc(slik,_7941,_7943),
    !.

optional([så],[optional,lit(så),!],_7941,_7943) --> 
    cc(så,_7941,_7943),
    !.

optional(be,[optional,_7953,!],_7939,_7941) --> 
    be(_7953,_7939,_7941),
    !.

optional([at],[optional,lit(at),!],_7941,_7943) --> 
    cc(at,_7941,_7943),
    !.

optional([at],[optional,lit(at),!],_7941,_7943) --> 
    cc(at,_7941,_7943),
    !.

optional([seg],[optional,lit(seg),!],_7941,_7943) --> 
    cc(seg,_7941,_7943),
    !.

optional([at],[optional,lit(at),!],_7941,_7943) --> 
    cc(at,_7941,_7943),
    !.

optional(w(adj2(great,nil)),[optional,_7958,!],_7944,_7946) --> 
    w(adj2(great,nil),_7958,_7944,_7946),
    !.

optional(w(adj2(_7922,nil)),[optional,_7958,!],_7944,_7946) --> 
    w(adj2(_7922,nil),_7958,_7944,_7946),
    !.

optional(w(adj2(_7922,nil)),[optional,_7958,!],_7944,_7946) --> 
    w(adj2(_7922,nil),_7958,_7944,_7946),
    !.

optional(w(adj2(_7922,nil)),[optional,_7958,!],_7944,_7946) --> 
    w(adj2(_7922,nil),_7958,_7944,_7946),
    !.

optional([med],[optional,lit(med),!],_7941,_7943) --> 
    cc(med,_7941,_7943),
    !.

optional(sometimes,[optional,_7953,!],_7939,_7941) --> 
    sometimes(_7953,_7939,_7941),
    !.

optional([ofte],[optional,lit(ofte),!],_7941,_7943) --> 
    cc(ofte,_7941,_7943),
    !.

optional([bare],[optional,lit(bare),!],_7941,_7943) --> 
    cc(bare,_7941,_7943),
    !.

optional(grums,[optional,_7953,!],_7939,_7941) --> 
    grums(_7953,_7939,_7941),
    !.

optional(grums,[optional,_7953,!],_7939,_7941) --> 
    grums(_7953,_7939,_7941),
    !.

optional([for],[optional,lit(for),!],_7941,_7943) --> 
    cc(for,_7941,_7943),
    !.

optional([:],[optional,lit(:),!],_7941,_7943) --> 
    cc(:,_7941,_7943),
    !.

optional([:],[optional,lit(:),!],_7941,_7943) --> 
    cc(:,_7941,_7943),
    !.

optional([ja],[optional,lit(ja),!],_7941,_7943) --> 
    cc(ja,_7941,_7943),
    !.

optional([men],[optional,lit(men),!],_7941,_7943) --> 
    cc(men,_7941,_7943),
    !.

optional(paadeg,[optional,_7953,!],_7939,_7941) --> 
    paadeg(_7953,_7939,_7941),
    !.

optional(hello,[optional,_7953,!],_7939,_7941) --> 
    hello(_7953,_7939,_7941),
    !.

optional(hello,[optional,_7953,!],_7939,_7941) --> 
    hello(_7953,_7939,_7941),
    !.

optional([ikke],[optional,lit(ikke),!],_7941,_7943) --> 
    cc(ikke,_7941,_7943),
    !.

optional(_7913,[],_7693,_7693) --> 
    [].

xnp(_8075,_8076,[xnp,_8118],_8101,_8103) --> 
    virtual(xnp(_8075,_8076),_8118,_8101,_8103).

negation(_8075,[negation,_8112],_8098,_8100) --> 
    virtual(negation(_8075),_8112,_8098,_8100).

aux1([aux1,_8105],_8094,_8096) --> 
    virtual(aux1,_8105,_8094,_8096).

adverbial1(_8075,_8076,_8077,[adverbial1,_8124],_8104,_8106) --> 
    virtual(adverbial1(_8075,_8076,_8077),_8124,_8104,_8106).

xadverbial1(_8075,_8076,_8077,[xadverbial1,_8124],_8104,_8106) --> 
    virtual(xadverbial1(_8075,_8076,_8077),_8124,_8104,_8106).

subordinate(in_order_to,_8076,_8077,[subordinate,_8124],_8104,_8106) --> 
    virtual(subordinate(in_order_to,_8076,_8077),_8124,_8104,_8106).

subordinate(_8075,_8076,_8077,[subordinate,_8124],_8104,_8106) --> 
    virtual(subordinate(_8075,_8076,_8077),_8124,_8104,_8106).

adj1(_8075,_8080:_8081,_8077,_8078,[adj1,_8133],_8110,_8112) --> 
    virtual(adj1(_8075,_8080:_8081,_8077,_8078),_8133,_8110,_8112).

someone([someone,_8105],_8094,_8096) --> 
    virtual(someone,_8105,_8094,_8096).

obviousdate1(_8075,_8076,[obviousdate1,_8118],_8101,_8103) --> 
    virtual(obviousdate1(_8075,_8076),_8118,_8101,_8103).

np_kernel(0,_8076,_8077,[np_kernel,_8124],_8104,_8106) --> 
    virtual(np_kernel(0,_8076,_8077),_8124,_8104,_8106).

xnp(_8075,_8078::_8079,[xnp,_8121],_8104,_8106) --> 
    virtual(xnp(_8075,_8078::_8079),_8121,_8104,_8106).

pp(_8075,_8076,_8077,[pp,_8124],_8104,_8106) --> 
    virtual(pp(_8075,_8076,_8077),_8124,_8104,_8106).

np(_8075,_8076,[np,_8118],_8101,_8103) --> 
    virtual(np(_8075,_8076),_8118,_8101,_8103).

prep(to,[prep,_8112],_8098,_8100) --> 
    virtual(prep(to),_8112,_8098,_8100).

prep(_8075,[prep,_8112],_8098,_8100) --> 
    virtual(prep(_8075),_8112,_8098,_8100).

noun_phrase1(_8075,_8076,[noun_phrase1,_8118],_8101,_8103) --> 
    virtual(noun_phrase1(_8075,_8076),_8118,_8101,_8103).

xadverb(_8075,_8076,[xadverb,_8118],_8101,_8103) --> 
    virtual(xadverb(_8075,_8076),_8118,_8101,_8103).

np(_8075,_8078::_8079,[np,_8121],_8104,_8106) --> 
    virtual(np(_8075,_8078::_8079),_8121,_8104,_8106).

be(_8075,[be,_8112],_8098,_8100) --> 
    virtual(be(_8075),_8112,_8098,_8100).

thereit([thereit,_8105],_8094,_8096) --> 
    virtual(thereit,_8105,_8094,_8096).

be([be,_8105],_8094,_8096) --> 
    virtual(be,_8105,_8094,_8096).

adverbial1(_8075,_8076,_8079::_8080,[adverbial1,_8127],_8107,_8109) --> 
    virtual(adverbial1(_8075,_8076,_8079::_8080),_8127,_8107,_8109).

lexv(_8075,_8076,_8077,fin,[lexv,_8130],_8107,_8109) --> 
    virtual(lexv(_8075,_8076,_8077,fin),_8130,_8107,_8109).

ap(_8075,_8076,_8077,_8078,[ap,_8130],_8107,_8109) --> 
    virtual(ap(_8075,_8076,_8077,_8078),_8130,_8107,_8109).

adj1(_8075,_8076,_8077,_8078,[adj1,_8130],_8107,_8109) --> 
    virtual(adj1(_8075,_8076,_8077,_8078),_8130,_8107,_8109).

\(state(_8078,_8079),(xnp(_8084,_8085),w(verb(be,_8093,fin)),w(adj2(_8098,nil))),[\,_8141],_8124,_8126) --> 
    virtual(state(_8078,_8079)\(xnp(_8084,_8085),w(verb(be,_8093,fin)),w(adj2(_8098,nil))),_8141,_8124,_8126).

something([something,_8105],_8094,_8096) --> 
    virtual(something,_8105,_8094,_8096).

lexv(iv,_8076,pres,fin,[lexv,_8130],_8107,_8109) --> 
    virtual(lexv(iv,_8076,pres,fin),_8130,_8107,_8109).

np1(_8075,_8076,[np1,_8118],_8101,_8103) --> 
    virtual(np1(_8075,_8076),_8118,_8101,_8103).

adverbial(_8075,_8076,_8079::_8080,[adverbial,_8127],_8107,_8109) --> 
    virtual(adverbial(_8075,_8076,_8079::_8080),_8127,_8107,_8109).

lexv(iv,_8076,_8077,fin,[lexv,_8130],_8107,_8109) --> 
    virtual(lexv(iv,_8076,_8077,fin),_8130,_8107,_8109).

the([the,_8105],_8094,_8096) --> 
    virtual(the,_8105,_8094,_8096).

nameq1(_8078:person,_8076,[nameq1,_8121],_8104,_8106) --> 
    virtual(nameq1(_8078:person,_8076),_8121,_8104,_8106).

obviousclock1(_8078:clock,_8078 isa clock,[obviousclock1,_8124],_8107,_8109) --> 
    virtual(obviousclock1(_8078:clock,_8078 isa clock),_8124,_8107,_8109).

whatbe([whatbe,_8105],_8094,_8096) --> 
    virtual(whatbe,_8105,_8094,_8096).

obviousclock1(_8075,_8076,[obviousclock1,_8118],_8101,_8103) --> 
    virtual(obviousclock1(_8075,_8076),_8118,_8101,_8103).

pronoun(_8075,[pronoun,_8112],_8098,_8100) --> 
    virtual(pronoun(_8075),_8112,_8098,_8100).

noun_phrase1(_8075,_8078::_8079,[noun_phrase1,_8121],_8104,_8106) --> 
    virtual(noun_phrase1(_8075,_8078::_8079),_8121,_8104,_8106).

npgap(_8075,[npgap,_8112],_8098,_8100) --> 
    virtual(npgap(_8075),_8112,_8098,_8100).

npgap(_8077:thing,[npgap,_8115],_8101,_8103) --> 
    virtual(npgap(_8077:thing),_8115,_8101,_8103).

noun(_8075,_8076,_8077,_8078,_8079,_8080,[noun,_8142],_8113,_8115) --> 
    virtual(noun(_8075,_8076,_8077,_8078,_8079,_8080),_8142,_8113,_8115).

lexv(tv,_8076,_8077,fin,[lexv,_8130],_8107,_8109) --> 
    virtual(lexv(tv,_8076,_8077,fin),_8130,_8107,_8109).

which([which,_8105],_8094,_8096) --> 
    virtual(which,_8105,_8094,_8096).

np1(_8075,_8078::_8079,[np1,_8121],_8104,_8106) --> 
    virtual(np1(_8075,_8078::_8079),_8121,_8104,_8106).

lexv(tv,know1,_8077,fin,[lexv,_8130],_8107,_8109) --> 
    virtual(lexv(tv,know1,_8077,fin),_8130,_8107,_8109).

do([do,_8105],_8094,_8096) --> 
    virtual(do,_8105,_8094,_8096).

xadverbial1(_8075,_8076,_8079::_8080,[xadverbial1,_8127],_8107,_8109) --> 
    virtual(xadverbial1(_8075,_8076,_8079::_8080),_8127,_8107,_8109).

prep(in,[prep,_8112],_8098,_8100) --> 
    virtual(prep(in),_8112,_8098,_8100).

adverbial1(in,_8076,_8079::_8080,[adverbial1,_8127],_8107,_8109) --> 
    virtual(adverbial1(in,_8076,_8079::_8080),_8127,_8107,_8109).

xadverbial1(in,_8076,_8079::_8080,[xadverbial1,_8127],_8107,_8109) --> 
    virtual(xadverbial1(in,_8076,_8079::_8080),_8127,_8107,_8109).

adverbial1(nil,_8076,_8079::_8080,[adverbial1,_8127],_8107,_8109) --> 
    virtual(adverbial1(nil,_8076,_8079::_8080),_8127,_8107,_8109).

prep(from,[prep,_8112],_8098,_8100) --> 
    virtual(prep(from),_8112,_8098,_8100).

who([who,_8105],_8094,_8096) --> 
    virtual(who,_8105,_8094,_8096).

a([a,_8105],_8094,_8096) --> 
    virtual(a,_8105,_8094,_8096).

noun(_8075,_8076,u,n,_8079,_8080,[noun,_8142],_8113,_8115) --> 
    virtual(noun(_8075,_8076,u,n,_8079,_8080),_8142,_8113,_8115).

that([that,_8105],_8094,_8096) --> 
    virtual(that,_8105,_8094,_8096).

xadverbial1(how,nil,_8079::_8079,[xadverbial1,_8127],_8107,_8109) --> 
    virtual(xadverbial1(how,nil,_8079::_8079),_8127,_8107,_8109).

prep(with,[prep,_8112],_8098,_8100) --> 
    virtual(prep(with),_8112,_8098,_8100).

xadverbial1(nil,_8076,_8077,[xadverbial1,_8124],_8104,_8106) --> 
    virtual(xadverbial1(nil,_8076,_8077),_8124,_8104,_8106).

the(_8075,[the,_8112],_8098,_8100) --> 
    virtual(the(_8075),_8112,_8098,_8100).

of([of,_8105],_8094,_8096) --> 
    virtual(of,_8105,_8094,_8096).

prep1(in,[prep1,_8112],_8098,_8100) --> 
    virtual(prep1(in),_8112,_8098,_8100).

number(_8075,[number,_8112],_8098,_8100) --> 
    virtual(number(_8075),_8112,_8098,_8100).

lexv(dtv,_8076,_8077,_8078,[lexv,_8130],_8107,_8109) --> 
    virtual(lexv(dtv,_8076,_8077,_8078),_8130,_8107,_8109).

negation0(_8075,[negation0,_8112],_8098,_8100) --> 
    virtual(negation0(_8075),_8112,_8098,_8100).

adverbx(_8075,_8076,_8077,[adverbx,_8124],_8104,_8106) --> 
    virtual(adverbx(_8075,_8076,_8077),_8124,_8104,_8106).

particle(_8075,[particle,_8112],_8098,_8100) --> 
    virtual(particle(_8075),_8112,_8098,_8100).

verb_mod1(_8075,_8076,_8077,_8078,_8081::_8082,[verb_mod1,_8139],_8113,_8115) --> 
    virtual(verb_mod1(_8075,_8076,_8077,_8078,_8081::_8082),_8139,_8113,_8115).

lexv(tv,_8076,pres,fin,[lexv,_8130],_8107,_8109) --> 
    virtual(lexv(tv,_8076,pres,fin),_8130,_8107,_8109).

prep1(_8075,[prep1,_8112],_8098,_8100) --> 
    virtual(prep1(_8075),_8112,_8098,_8100).

noun_phrase1(_8075,_8078:_8079,[noun_phrase1,_8121],_8104,_8106) --> 
    virtual(noun_phrase1(_8075,_8078:_8079),_8121,_8104,_8106).

lexv(_8075,know1,_8077,fin,[lexv,_8130],_8107,_8109) --> 
    virtual(lexv(_8075,know1,_8077,fin),_8130,_8107,_8109).

lexv(tv,_8076,past,fin,[lexv,_8130],_8107,_8109) --> 
    virtual(lexv(tv,_8076,past,fin),_8130,_8107,_8109).

this([this,_8105],_8094,_8096) --> 
    virtual(this,_8105,_8094,_8096).

adverbial1(_8075,_8079:_8080,_8077,[adverbial1,_8127],_8107,_8109) --> 
    virtual(adverbial1(_8075,_8079:_8080,_8077),_8127,_8107,_8109).

adverbial1(nil,_8079:coevent,_8077,[adverbial1,_8127],_8107,_8109) --> 
    virtual(adverbial1(nil,_8079:coevent,_8077),_8127,_8107,_8109).

xadverbial1(_8075,_8079:_8080,_8077,[xadverbial1,_8127],_8107,_8109) --> 
    virtual(xadverbial1(_8075,_8079:_8080,_8077),_8127,_8107,_8109).

adverb(_8075,_8076,_8077,[adverb,_8124],_8104,_8106) --> 
    virtual(adverb(_8075,_8076,_8077),_8124,_8104,_8106).

some([some,_8105],_8094,_8096) --> 
    virtual(some,_8105,_8094,_8096).

much([much,_8105],_8094,_8096) --> 
    virtual(much,_8105,_8094,_8096).

little([little,_8105],_8094,_8096) --> 
    virtual(little,_8105,_8094,_8096).

every([every,_8105],_8094,_8096) --> 
    virtual(every,_8105,_8094,_8096).

relpron(agent,[relpron,_8112],_8098,_8100) --> 
    virtual(relpron(agent),_8112,_8098,_8100).

relpron(thing,[relpron,_8112],_8098,_8100) --> 
    virtual(relpron(thing),_8112,_8098,_8100).

time1(_8075,[time1,_8112],_8098,_8100) --> 
    virtual(time1(_8075),_8112,_8098,_8100).

and1([and1,_8105],_8094,_8096) --> 
    virtual(and1,_8105,_8094,_8096).

thispron([thispron,_8105],_8094,_8096) --> 
    virtual(thispron,_8105,_8094,_8096).

clock_kernel(_8078:clock,_8078 isa clock,[clock_kernel,_8124],_8107,_8109) --> 
    virtual(clock_kernel(_8078:clock,_8078 isa clock),_8124,_8107,_8109).

nameq1(_8075,_8076,[nameq1,_8118],_8101,_8103) --> 
    virtual(nameq1(_8075,_8076),_8118,_8101,_8103).

