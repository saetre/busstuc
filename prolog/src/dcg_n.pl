% Auxillary tables created datetime(2012,3,16,21,25,44)

%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

:- :-prolog_flag(discontiguous_warnings,_,off).

sentence([gpsflag:::_7703|_7700],[sentence,{},_7764,!,_7798],_7740,_7742) --> 
    {user:value(gpsflag,true)},
    origin_phrase(_7703,_7764,_7740,_7781),
    !,
    sentences(_7700,_7798,_7781,_7742).

sentence(_7698,[sentence,{},_7753],_7729,_7731) --> 
    {user:(\+value(gpsflag,true))},
    sentences(_7698,_7753,_7729,_7731).

origin_phrase([_7699|_7700],[origin_phrase,lit('('),!,_7772,{},_7811],_7742,_7744) --> 
    cc('(',_7742,_7766),
    !,
    origin_element(_7699,_7772,_7766,_7789),
    {user:set(new_origin,true)},
    origin_phrase0n(_7700,_7811,_7789,_7744).

origin_phrase([],[origin_phrase,[]],_7717,_7717) --> 
    [].

origin_phrase0n([_7699|_7700],[origin_phrase0n,_7743,!,_7777],_7729,_7731) --> 
    origin_element(_7699,_7743,_7729,_7760),
    !,
    origin_phrase0n(_7700,_7777,_7760,_7731).

origin_phrase0n([],[origin_phrase0n,lit(')')],_7719,_7721) --> 
    cc(')',_7719,_7721).

origin_element(gps_origin(_7700,_7701),[origin_element,_7746,lit(+),_7786],_7732,_7734) --> 
    gps_origin(_7700,_7746,_7732,_7763),
    cc(+,_7763,_7785),
    gps_time(_7701,_7786,_7785,_7734).

gps_origin(_7698,[gps_origin,_7741,!],_7727,_7729) --> 
    name_phrase(name,_7698:_7708,_7705,_7741,_7727,_7729),
    !.

gps_time(_7698,[gps_time,_7736],_7722,_7724) --> 
    w(nb(_7698,num),_7736,_7722,_7724).

sentence01(_7698,[sentence01,_7733],_7719,_7721) --> 
    implicitq(_7698,_7733,_7719,_7721).

sentence01(_7698,[sentence01,_7733],_7719,_7721) --> 
    sentence1(_7698,_7733,_7719,_7721).

sentences([new:::_7703],[sentences,{},_7768,_7797,!,_7826],_7744,_7746) --> 
    {user:value(queryflag,false)},
    declaration(_7703,_7768,_7744,_7785),
    terminatore(_7797,_7785,_7812),
    !,
    accept(_7826,_7812,_7746).

sentences([_7699],[sentences,{},_7773,_7797,_7826,_7870,!,_7899],_7749,_7751) --> 
    {user:value(queryflag,true)},
    greetings0(_7773,_7749,_7788),
    implicitq(_7699,_7797,_7788,_7814),
    optional(itrailer,_7826,_7814,_7858),
    terminatores(_7870,_7858,_7885),
    !,
    accept(_7899,_7885,_7751).

sentences(_7698,[sentences,_7750,{},_7789,_7813],_7736,_7738) --> 
    onesentence(_7709,_7750,_7736,_7767),
    {user:_7709\==error},
    check_stop(_7789,_7767,_7804),
    moresentences0(_7709,_7698,_7813,_7804,_7738).

moresentences0(_7698,_7699,[moresentences0,_7755,_7784,!,_7813,_7837],_7738,_7740) --> 
    onesentence(_7714,_7755,_7738,_7772),
    check_stop(_7784,_7772,_7799),
    !,
    accept(_7813,_7799,_7828),
    evenmore0(_7698,_7714,_7699,_7837,_7828,_7740).

evenmore0(_7698,error,[_7698,error],[evenmore0,!,_7755],_7730,_7732) --> 
    !,
    skip_rest(_7755,_7730,_7732).

evenmore0(_7698,[],[_7698],[evenmore0,[],!],_7728,_7728) --> 
    [],
    !.

evenmore0(_7698,_7699,[_7698|_7702],[evenmore0,_7748],_7728,_7730) --> 
    moresentences0(_7699,_7702,_7748,_7728,_7730).

onesentence([],[onesentence,_7737,!,_7766],_7723,_7725) --> 
    endofline(_7737,_7723,_7752),
    !,
    accept(_7766,_7752,_7725).

onesentence(_7698,[onesentence,_7742,_7771,!,_7800],_7728,_7730) --> 
    conf_statement(_7698,_7742,_7728,_7759),
    endofline(_7771,_7759,_7786),
    !,
    accept(_7800,_7786,_7730).

onesentence(_7698,[onesentence,_7742,_7766,_7795,_7819],_7728,_7730) --> 
    grums0(_7742,_7728,_7757),
    sentence1(_7698,_7766,_7757,_7783),
    sentence_delimiter(_7795,_7783,_7810),
    accept(_7819,_7810,_7730).

onesentence(error,[onesentence,_7731],_7717,_7719) --> 
    skip_rest(_7731,_7717,_7719).

notify([notify,_7730],_7719,_7721) --> 
    w(verb(notify,_7701,_7702),_7730,_7719,_7721).

notify([notify,_7731],_7720,_7722) --> 
    w(noun(notification,_7701,_7702,_7703),_7731,_7720,_7722).

conf_statement(confirm:::_7701,[conf_statement,_7736],_7722,_7724) --> 
    confirm(_7701,_7736,_7722,_7724).

confirm(false,[confirm,lit(jeg),_7761,lit(ikke),_7801],_7736,_7738) --> 
    cc(jeg,_7736,_7760),
    w(verb(know,pres,fin),_7761,_7760,_7778),
    cc(ikke,_7778,_7800),
    endofline(_7801,_7800,_7738).

confirm(true,[confirm,lit(ja),_7747],_7722,_7724) --> 
    cc(ja,_7722,_7746),
    of_course0(_7747,_7746,_7724).

confirm(true,[confirm,lit(jo),_7747],_7722,_7724) --> 
    cc(jo,_7722,_7746),
    of_course0(_7747,_7746,_7724).

confirm(false,[confirm,lit(nei),_7747],_7722,_7724) --> 
    cc(nei,_7722,_7746),
    of_coursenot0(_7747,_7746,_7724).

confirm(true,[confirm,_7731],_7717,_7719) --> 
    of_course(_7731,_7717,_7719).

confirm(false,[confirm,_7736,lit(ikke)],_7722,_7724) --> 
    of_course(_7736,_7722,_7751),
    cc(ikke,_7751,_7724).

sentence_delimiter([sentence_delimiter,lit(for),_7744],_7722,_7724) --> 
    cc(for,_7722,_7743),
    look_ahead([hvis],_7744,_7743,_7724).

sentence_delimiter([sentence_delimiter,lit(;)],_7715,_7717) --> 
    cc(;,_7715,_7717).

sentence_delimiter([sentence_delimiter,_7724],_7713,_7715) --> 
    terminatore(_7724,_7713,_7715).

terminatore0([terminatore0,_7730,!,_7759],_7719,_7721) --> 
    terminatore(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

terminatore0([terminatore0,[]],_7713,_7713) --> 
    [].

terminatores([terminatores,_7730,!,_7759],_7719,_7721) --> 
    terminator(_7730,_7719,_7745),
    !,
    terminatores(_7759,_7745,_7721).

terminatores([terminatores,_7733,_7757,!,_7786],_7722,_7724) --> 
    check_stop(_7733,_7722,_7748),
    endofline(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

terminatore([terminatore,_7724],_7713,_7715) --> 
    terminator1(_7724,_7713,_7715).

terminator1([terminator1,_7773,_7797,_7826,_7855,_7884,!,_7918],_7762,_7764) --> 
    terminator(_7773,_7762,_7788),
    not_look_ahead(w(nb(_7720,num)),_7797,_7788,_7814),
    not_look_ahead(w(name(_7727,_7728,month)),_7826,_7814,_7843),
    not_look_ahead(w(name(_7727,_7736,day)),_7855,_7843,_7872),
    not_look_ahead(w(name(_7727,_7744,date)),_7884,_7872,_7901),
    !,
    accept(_7918,_7901,_7764).

terminator1([terminator1,_7733,_7757,!,_7786],_7722,_7724) --> 
    check_stop_locations(_7733,_7722,_7748),
    endofline(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

look_ahead_endofline([look_ahead_endofline,_7735,!],_7724,_7726) --> 
    look_ahead_lit(['.',?,!],_7735,_7724,_7726),
    !.

look_ahead_endofline([look_ahead_endofline,_7724],_7713,_7715) --> 
    end_of_line(_7724,_7713,_7715).

endofline0([endofline0,_7730,!,_7759],_7719,_7721) --> 
    terminator(_7730,_7719,_7745),
    !,
    endofline0(_7759,_7745,_7721).

endofline0([endofline0,_7724],_7713,_7715) --> 
    end_of_line0(_7724,_7713,_7715).

endofline([endofline,_7733,_7757,!,_7786],_7722,_7724) --> 
    terminator(_7733,_7722,_7748),
    endofline(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

endofline([endofline,lit(:),_7743,!],_7721,_7723) --> 
    cc(:,_7721,_7742),
    end_of_line(_7743,_7742,_7723),
    !.

endofline([endofline,lit(+),{},_7764,!,_7793],_7732,_7734) --> 
    cc(+,_7732,_7753),
    {user:value(busflag,true)},
    endofline(_7764,_7753,_7779),
    !,
    accept(_7793,_7779,_7734).

endofline([endofline,_7724],_7713,_7715) --> 
    end_of_line(_7724,_7713,_7715).

endofline1([endofline1,lit('.')],_7715,_7717) --> 
    cc('.',_7715,_7717).

endofline1([endofline1,lit(?)],_7715,_7717) --> 
    cc(?,_7715,_7717).

endofline1([endofline1,lit(!)],_7715,_7717) --> 
    cc(!,_7715,_7717).

check_stop_locations([check_stop_locations,_7727,!],_7716,_7718) --> 
    check_stop(_7727,_7716,_7718),
    !.

assemble_stop_locations([_7702+_7703|_7700],[assemble_stop_locations,_7763,lit(+),_7803,!,_7837],_7749,_7751) --> 
    w(name(_7702,n,_7723),_7763,_7749,_7780),
    cc(+,_7780,_7802),
    w(nb(_7703,num),_7803,_7802,_7820),
    !,
    check_stop_locations(_7700,_7837,_7820,_7751).

assemble_stop_locations([],[assemble_stop_locations,_7731],_7717,_7719) --> 
    end_of_line(_7731,_7717,_7719).

sentence1(new:::_7701,[sentence1,_7784,_7808,lit(at),!,_7853,_7887],_7770,_7772) --> 
    hellos0(_7784,_7770,_7799),
    w(adj2(_7729,_7730),_7808,_7799,_7825),
    cc(at,_7825,_7847),
    !,
    clausal_object1(_7739,_7740,_7853,_7847,_7872),
    pushstack(first,(xnp(_7739,_7740),w(verb(be,pres,fin)),w(adj2(_7729,_7730))),nil,_7872,_7930),
    statreal(_7701,_7887,_7930,_7772).

sentence1(new:::_7701,[sentence1,_7759,_7783,!,_7831],_7745,_7747) --> 
    detaa(_7759,_7745,_7774),
    pushstack(first,[noen],nil,_7774,_7796),clausal_object1(_7715,_7716,_7783,_7796,_7811),
    !,
    pushstack(first,xnp(_7715,_7716),nil,_7811,_7872),
    statreal(_7701,_7831,_7872,_7747).

detaa([detaa,lit(det),lit(å)],_7720,_7722) --> 
    cc(det,_7720,_7741),
    cc(å,_7741,_7722).

detaa([detaa,lit(å)],_7715,_7717) --> 
    cc(å,_7715,_7717).

sentence1(new:::_7701,[sentence1,_7754,_7778,!,_7817],_7740,_7742) --> 
    hvorvidt(_7754,_7740,_7769),
    clausal_object1(_7715,_7716,_7778,_7769,_7797),
    !,
    pushstack(first,xnp(_7715,_7716),nil,_7797,_7858),
    statreal(_7701,_7817,_7858,_7742).

hvorvidt([hvorvidt,lit(hvorvidt)],_7715,_7717) --> 
    cc(hvorvidt,_7715,_7717).

hvorvidt([hvorvidt,lit(det),lit(at)],_7720,_7722) --> 
    cc(det,_7720,_7741),
    cc(at,_7741,_7722).

hvorvidt([hvorvidt,lit(at)],_7715,_7717) --> 
    cc(at,_7715,_7717).

sentence1(new:::_7701,[sentence1,_7747,_7771,!,_7805],_7733,_7735) --> 
    redundant(_7747,_7733,_7762),
    be_it_tf_that(_7714,_7771,_7762,_7788),
    !,
    statreal(_7701,_7805,_7788,_7735).

sentence1(new:::_7701,[sentence1,_7766,_7795,_7824],_7752,_7754) --> 
    w(verb(be,_7724,fin),_7766,_7752,_7783),
    look_ahead_lit([mye],_7795,_7783,_7812),
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_7812,_7834),
    statement(_7701,_7824,_7834,_7754).

sentence1(new:::_7701,[sentence1,_7780,_7809,lit(som),!,_7849],_7766,_7768) --> 
    w(verb(_7731,_7732,pass),_7780,_7766,_7797),
    redundant0(_7809,_7797,_7824),
    cc(som,_7824,_7843),
    !,
    pushstack(first,([noen],w(verb(_7731,_7732,fin)),[dette],[som]),nil,_7843,_7859),
    statreal(_7701,_7849,_7859,_7768).

sentence1(new:::_7701,[sentence1,_7774,_7818,_7847,_7876],_7760,_7762) --> 
    optional([kanskje],_7774,_7760,_7806),
    negation(_7721,_7818,_7806,_7835),
    not_look_ahead([alle],_7847,_7835,_7864),
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_7721)),nil,_7864,_7919),
    statreal(_7701,_7876,_7919,_7762).

sentence1(new:::_7701,[sentence1,_7862,_7891,_7920,_7949,_7983,_8012,lit(å),_8052,!,_8086],_7848,_7850) --> 
    one_of_lit([den,det,dette,disse,slike],_7862,_7848,_7879),
    w(noun(_7753,_7754,_7755,n),_7891,_7879,_7908),
    w(verb(be,_7780,fin),_7920,_7908,_7937),
    subject(_7783,_7784,_7949,_7937,_7968),
    w(adj2(_7788,nil),_7983,_7968,_8000),
    w(prep(_7793),_8012,_8000,_8029),
    cc(å,_8029,_8051),
    w(verb(_7799,inf,fin),_8052,_8051,_8069),
    !,
    pushstack(first,(xnp(_7783,_7784),w(verb(be,_7780,fin)),w(adj2(_7788,nil)),w(prep(_7793)),[å],w(verb(_7799,inf,fin)),w(noun(_7753,_7754,_7755,n))),nil,_8069,_8127),
    statreal(_7701,_8086,_8127,_7850).

sentence1(new:::_7701,[sentence1,_7834,_7863,_7892,_7921,_7955,_7984,!,_8018],_7820,_7822) --> 
    one_of_lit([den,det,dette,disse,slike],_7834,_7820,_7851),
    w(noun(_7741,_7742,_7743,n),_7863,_7851,_7880),
    w(verb(be,_7768,fin),_7892,_7880,_7909),
    subject(_7771,_7772,_7921,_7909,_7940),
    w(adj2(_7776,nil),_7955,_7940,_7972),
    w(prep(_7781),_7984,_7972,_8001),
    !,
    pushstack(free,(xnp(_7771,_7772),w(verb(be,_7768,fin)),w(adj2(_7776,nil)),w(prep(_7781)),w(noun(_7741,_7742,_7743,n))),nil,_8001,_8059),
    statreal(_7701,_8018,_8059,_7822).

sentence1(new:::_7701,[sentence1,_7838,_7867,_7896,_7925,_7959,_7988,!,_8022],_7824,_7826) --> 
    one_of_lit([den,det,dette,disse,slike],_7838,_7824,_7855),
    w(noun(_7741,_7742,_7743,n),_7867,_7855,_7884),
    w(verb(_7767,_7768,fin),_7896,_7884,_7913),
    subject(_7771,_7772,_7925,_7913,_7944),
    w(noun(_7776,sin,u,n),_7959,_7944,_7976),
    w(prep(_7783),_7988,_7976,_8005),
    !,
    pushstack(first,(xnp(_7771,_7772),w(verb(_7767,_7768,fin)),w(noun(_7776,sin,u,n)),w(prep(_7783)),w(noun(_7741,_7742,_7743,n))),nil,_8005,_8063),
    statreal(_7701,_8022,_8063,_7826).

sentence1(new:::_7701,[sentence1,_7818,_7847,_7876,{},_7915,!,_7954],_7804,_7806) --> 
    one_of_lit([den,det,dette,disse,slike],_7818,_7804,_7835),
    w(noun(_7732,_7733,_7734,n),_7847,_7835,_7864),
    w(verb(_7758,_7759,fin),_7876,_7864,_7893),
    {user:(\+testmember(_7758,[have,get]))},
    subject(_7773,_7774,_7915,_7893,_7934),
    !,
    pushstack(first,(xnp(_7773,_7774),w(verb(_7758,_7759,fin)),w(noun(_7732,_7733,_7734,n))),nil,_7934,_7995),
    statreal(_7701,_7954,_7995,_7806).

sentence1(new:::_7701,[sentence1,lit(hvorvidt),_7798,!,lit(kan),_7848,!,_7882],_7773,_7775) --> 
    cc(hvorvidt,_7773,_7797),
    clausal_object1(_7730,_7731,_7798,_7797,_7817),
    !,
    cc(kan,_7817,_7847),
    w(verb(_7742,_7743,pass),_7848,_7847,_7865),
    !,
    pushstack(first,([dere],w(verb(_7742,_7743,fin)),xnp(_7730,_7731)),nil,_7865,_7923),
    statreal(_7701,_7882,_7923,_7775).

sentence1(new:::_7701,[sentence1,_7780,_7809,_7843,!,_7877],_7766,_7768) --> 
    w(verb(_7723,_7729,_7730),_7780,_7766,_7797),
    gmem(_7723,[talk,speak],_7809,_7797,_7828),
    look_ahead(w(prep(_7743)),_7843,_7828,_7860),
    !,
    pushstack(first,([du],w(verb(_7723,pres))),nil,_7860,_7887),
    statreal(_7701,_7877,_7887,_7768).

sentence1(new:::_7701,[sentence1,_7753,_7777,!,_7806],_7739,_7741) --> 
    aux1(_7753,_7739,_7768),
    not_look_ahead_np(_7777,_7768,_7792),
    !,
    pushstack(first,([jeg],aux1),nil,_7792,_7849),
    statreal(_7701,_7806,_7849,_7741).

sentence1(new:::_7701,[sentence1,_7762,!,_7796],_7748,_7750) --> 
    w(verb(_7717,past,part),_7762,_7748,_7779),
    !,
    pushstack(first,([jeg],w(verb(_7717,past,fin))),nil,_7779,_7806),
    statreal(_7701,_7796,_7806,_7750).

sentence1(new:::_7701,[sentence1,_7762,!,_7796],_7748,_7750) --> 
    w(verb(_7717,past,part),_7762,_7748,_7779),
    !,
    pushstack(first,([jeg],w(verb(_7717,past,fin))),nil,_7779,_7806),
    statreal(_7701,_7796,_7806,_7750).

sentence1(new:::_7701,[sentence1,lit(har),_7788,_7817,!,_7851],_7763,_7765) --> 
    cc(har,_7763,_7787),
    negation0(_7724,_7788,_7787,_7805),
    w(verb(_7732,past,part),_7817,_7805,_7834),
    !,
    pushstack(first,([jeg],w(verb(_7732,past,fin)),negation(_7724)),nil,_7834,_7891),
    statreal(_7701,_7851,_7891,_7765).

sentence1(new:::_7701,[sentence1,_7800,_7829,_7858,_7892,_7916,_7945,!,_7979],_7786,_7788) --> 
    not_look_ahead([så],_7800,_7786,_7817),
    w(verb(_7732,pres,fin),_7829,_7817,_7846),
    gmem(_7732,[go,think],_7858,_7846,_7877),
    not_look_ahead_np(_7892,_7877,_7907),
    not_look_ahead([ikke],_7916,_7907,_7933),
    not_look_ahead_lit([jeg,meg,du],_7945,_7933,_7962),
    !,
    pushstack(first,([jeg],w(verb(_7732,pres,fin))),nil,_7962,_7989),
    statreal(_7701,_7979,_7989,_7788).

sentence1(new:::_7701,[sentence1,_7834,_7863,_7892,_7926,_7960,_7989,_8018,!,_8052],_7820,_7822) --> 
    not_look_ahead([så],_7834,_7820,_7851),
    w(verb(_7735,_7746,fin),_7863,_7851,_7880),
    gmem(_7746,[pres],_7892,_7880,_7911),
    gmem(_7735,[arrive,calculate,discover,give,hope,pass,run,send,start,take,think,try,wait],_7926,_7911,_7945),
    particlev1(_7735,_7960,_7945,_7977),
    not_look_ahead([ikke],_7989,_7977,_8006),
    not_look_ahead_lit([jeg,meg,du,vi],_8018,_8006,_8035),
    !,
    pushstack(first,([jeg],w(verb(_7735,pres,fin))),nil,_8035,_8062),
    statreal(_7701,_8052,_8062,_7822).

sentence1(new:::_7701,[sentence1,_7826,_7855,_7884,_7918,_7952,_7981,_8010,!,_8044],_7812,_7814) --> 
    not_look_ahead([så],_7826,_7812,_7843),
    w(verb(_7735,_7746,fin),_7855,_7843,_7872),
    gmem(_7746,[imp,inf],_7884,_7872,_7903),
    gmem(_7735,[arrive,discover,pass,run,send,start,take,try],_7918,_7903,_7937),
    reflexiv0(_7735,_7952,_7937,_7969),
    not_look_ahead([ikke],_7981,_7969,_7998),
    not_look_ahead_lit([jeg,meg,du,vi],_8010,_7998,_8027),
    !,
    pushstack(first,([jeg],w(verb(_7735,pres,fin))),nil,_8027,_8054),
    statreal(_7701,_8044,_8054,_7814).

sentence1(new:::_7701,[sentence1,_7816,_7845,{},_7884,_7913,_7942,_7966,!,_8015],_7802,_7804) --> 
    not_look_ahead([så],_7816,_7802,_7833),
    w(verb(_7744,pres,fin),_7845,_7833,_7862),
    {user:testmember(_7744,[believe,calculate,think,see,know])},
    not_look_ahead([det],_7884,_7862,_7901),
    not_look_ahead([du],_7913,_7901,_7930),
    redundant0(_7942,_7930,_7957),
    optional([at],_7966,_7957,_7998),
    !,
    pushstack(first,([jeg],w(verb(_7744,pres,fin)),[at]),nil,_7998,_8025),
    statreal(_7701,_8015,_8025,_7804).

sentence1(new:::_7701,[sentence1,_7785,_7814,_7843,lit(jeg),_7878,!,_7907],_7771,_7773) --> 
    not_look_ahead([så],_7785,_7771,_7802),
    w(verb(_7738,_7739,fin),_7814,_7802,_7831),
    redundant0(_7843,_7831,_7858),
    cc(jeg,_7858,_7877),
    aux1(_7878,_7877,_7893),
    !,
    pushstack(first,([jeg],w(verb(_7738,pres,fin)),[å]),nil,_7893,_7917),
    statement(_7701,_7907,_7917,_7773).

sentence1(new:::_7701,[sentence1,_7778,_7802,_7826,_7855,!,_7889],_7764,_7766) --> 
    aux1(_7778,_7764,_7793),
    redundants0(_7802,_7793,_7817),
    negation0(_7727,_7826,_7817,_7843),
    w(verb(_7733,inf,fin),_7855,_7843,_7872),
    !,
    pushstack(first,([jeg],w(verb(_7733,pres,fin)),negation(_7727)),nil,_7872,_7929),
    statement(_7701,_7889,_7929,_7766).

sentence1(_7698,[sentence1,_7733],_7719,_7721) --> 
    command(_7698,_7733,_7719,_7721).

sentence1(_7698,[sentence1,_7739,_7763,_7792],_7725,_7727) --> 
    greetings0(_7739,_7725,_7754),
    question(_7698,_7763,_7754,_7780),
    qtrailer0(_7792,_7780,_7727).

sentence1(modifier(_7710):::_7714 isa clock and srel/nil/time/_7714/_7710 and event/real/_7710,[sentence1,{},_7803,_7832,{},!,_7871],_7779,_7781) --> 
    {user:value(dialog,1)},
    item(_7752,_7803,_7779,_7820),
    endofline(_7832,_7820,_7847),
    {user:_7752=(_7714 isa clock)},
    !,
    accept(_7871,_7847,_7781).

sentence1(item:::_7701,[sentence1,{},_7763,_7792,!,_7821],_7739,_7741) --> 
    {user:value(dialog,1)},
    item(_7701,_7763,_7739,_7780),
    endofline(_7792,_7780,_7807),
    !,
    accept(_7821,_7807,_7741).

sentence1(item:::_7703 isa clock,[sentence1,{},lit(nå),_7787,!,_7816,{}],_7752,_7754) --> 
    {user:value(dialog,1)},
    cc(nå,_7752,_7786),
    terminator1(_7787,_7786,_7802),
    !,
    accept(_7816,_7802,_7754),
    {user:timenow(_7703)}.

sentence1(item:::_7701,[sentence1,_7764,{},_7828,!,_7857],_7750,_7752) --> 
    noun(_7715,_7716,_7717,n,it:_7723,_7701,_7764,_7750,_7791),
    {user:value(dialog,1)},
    endofline(_7828,_7791,_7843),
    !,
    accept(_7857,_7843,_7752).

sentence1(item:::it isa _7704,[sentence1,{},_7774,_7798,!,_7827,{}],_7750,_7752) --> 
    {user:value(dialog,1)},
    today(_7774,_7750,_7789),
    terminator1(_7798,_7789,_7813),
    !,
    accept(_7827,_7813,_7752),
    {user:today(_7704)}.

sentence1(new:::_7701,[sentence1,lit(ble),_7787,!,_7821],_7762,_7764) --> 
    cc(ble,_7762,_7786),
    look_ahead(w(adj2(_7723,nil)),_7787,_7786,_7804),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),w(adj2(_7723,nil))),nil,_7804,_7831),
    statement(_7701,_7821,_7831,_7764).

sentence1(new:::_7701,[sentence1,_7796,_7825,_7849,{},!,_7893,_7917],_7782,_7784) --> 
    w(verb(be,_7737,_7738),_7796,_7782,_7813),
    now0(_7825,_7813,_7840),
    w(prep(_7742),_7849,_7840,_7866),
    {user:testmember(_7742,[in,on,at])},
    !,
    accept(_7893,_7866,_7908),
    pushstack(first,([jeg],w(verb(be,pres,fin)),w(prep(on))),nil,_7908,_7927),
    statement(_7701,_7917,_7927,_7784).

sentence1(new:::_7701,[sentence1,_7781,_7805,{},_7844,_7868],_7767,_7769) --> 
    has(_7781,_7767,_7796),
    w(verb(_7723,past,part),_7805,_7796,_7822),
    {user:testmember(_7723,[send,get,receive,lay])},
    now0(_7844,_7822,_7859),
    pushstack(first,([jeg],w(verb(_7723,past,fin))),nil,_7859,_7878),
    statement(_7701,_7868,_7878,_7769).

sentence1(new:::_7701,[sentence1,_7780,{},_7819,_7843],_7766,_7768) --> 
    w(verb(_7720,_7727,fin),_7780,_7766,_7797),
    {user:testmember(_7720,[send,get,receive,lay,check])},
    now0(_7819,_7797,_7834),
    pushstack(first,([jeg],w(verb(_7720,pres,fin))),nil,_7834,_7853),
    statement(_7701,_7843,_7853,_7768).

sentence1(new:::_7701,[sentence1,_7742,_7766,_7795],_7728,_7730) --> 
    greetings0(_7742,_7728,_7757),
    statement(_7701,_7766,_7757,_7783),
    dtrailer0(_7795,_7783,_7730).

sentence1(item:::_7701,[sentence1,_7745,_7774,!,_7803],_7731,_7733) --> 
    item(_7701,_7745,_7731,_7762),
    terminator1(_7774,_7762,_7789),
    !,
    accept(_7803,_7789,_7733).

item(_7700 isa clock,[item,{},_7765,{},_7804],_7741,_7743) --> 
    {user:value(dialog,1)},
    time12(_7700,_7765,_7741,_7782),
    {user:_7700\==now},
    endofline(_7804,_7782,_7743).

item(_7698,[item,{},_7755,_7789],_7731,_7733) --> 
    {user:value(dialog,1)},
    obviousdate1(_7711,_7698,_7755,_7731,_7774),
    endofline(_7789,_7774,_7733).

item(_7698,[item,_7735],_7721,_7723) --> 
    namep(_7700,_7701,_7698,_7735,_7721,_7723).

command(_7698,[command,lit(vil),!,_7755],_7725,_7727) --> 
    cc(vil,_7725,_7749),
    !,
    reject(_7755,_7749,_7727).

command(_7698,[command,lit(skal),!,_7755],_7725,_7727) --> 
    cc(skal,_7725,_7749),
    !,
    reject(_7755,_7749,_7727).

command(doit:::_7701,[command,lit(du),lit(må),_7801,_7830,!,_7864],_7765,_7767) --> 
    cc(du,_7765,_7789),
    cc(må,_7789,_7800),
    not_look_ahead([ikke],_7801,_7800,_7818),
    w(verb(_7726,inf,fin),_7830,_7818,_7847),
    !,
    pushstack(first,([du],w(verb(_7726,pres,fin))),nil,_7847,_7874),
    statreal(_7701,_7864,_7874,_7767).

command(doit:::quit(_7703),[command,_7747,_7771,_7795,_7824],_7733,_7735) --> 
    grums0(_7747,_7733,_7762),
    okeys0(_7771,_7762,_7786),
    quit(_7703,_7795,_7786,_7812),
    skip_rest(_7824,_7812,_7735).

command(doit:::reply(_7703),[command,_7744,_7773,_7797],_7730,_7732) --> 
    personal(_7703,_7744,_7730,_7761),
    dtrailer0(_7773,_7761,_7788),
    endofline(_7797,_7788,_7732).

command(doit:::replyq('Hei'),[command,_7739,!],_7725,_7727) --> 
    hellos(_7739,_7725,_7727),
    !.

command(new:::_7701,[command,_7774,_7803,lit(ut),_7843,_7877,!,_7906],_7760,_7762) --> 
    w(verb(_7726,pres,fin),_7774,_7760,_7791),
    not_look_ahead([du],_7803,_7791,_7820),
    cc(ut,_7820,_7842),
    gmem(_7726,[see,look],_7843,_7842,_7862),
    tilat(_7877,_7862,_7892),
    !,
    substateme1(real,_7701,_7906,_7892,_7762).

tilat([tilat,lit(til),lit(at),!],_7723,_7725) --> 
    cc(til,_7723,_7744),
    cc(at,_7744,_7725),
    !.

tilat([tilat,lit(som),lit(om),!],_7723,_7725) --> 
    cc(som,_7723,_7744),
    cc(om,_7744,_7725),
    !.

tilat([tilat,lit(som)],_7715,_7717) --> 
    cc(som,_7715,_7717).

command(new:::_7701,[command,_7789,_7818,_7847,!,_7886],_7775,_7777) --> 
    w(verb(_7723,pres,fin),_7789,_7775,_7806),
    not_look_ahead([du],_7818,_7806,_7835),
    gmem(_7723,[expect,miss,need,get,receive,see,understand],_7847,_7835,_7866),
    !,
    pushstack(first,([jeg],w(verb(_7723,pres,fin))),nil,_7866,_7896),
    statreal(_7701,_7886,_7896,_7777).

command(new:::_7701,[command,_7825,_7854,_7883,{},_7922,{},!,_7966],_7811,_7813) --> 
    not_look_ahead([nå],_7825,_7811,_7842),
    not_look_ahead(w(verb(come,imp,fin)),_7854,_7842,_7871),
    w(verb(_7732,_7751,fin),_7883,_7871,_7900),
    {user:testmember(_7732,[go,take,run,arrive,leave,leave2,depart,start,pass])},
    not_look_ahead([meg],_7922,_7900,_7939),
    {user:testmember(_7751,[imp,inf])},
    !,
    pushstack(first,([jeg],w(verb(_7732,pres,fin))),nil,_7939,_7976),
    statreal(_7701,_7966,_7976,_7813).

command(new:::_7701,[command,_7790,_7819,{},_7858,lit(jeg),_7903,!,_7937],_7776,_7778) --> 
    w(verb(_7731,pres,fin),_7790,_7776,_7807),
    not_look_ahead([du],_7819,_7807,_7836),
    {user:testmember(_7731,[believe])},
    that0(_7731,that,_7858,_7836,_7877),
    cc(jeg,_7877,_7902),
    not_look_ahead(w(prep(_7755)),_7903,_7902,_7920),
    !,
    pushstack(first,[jeg],nil,_7920,_7947),
    statreal(_7701,_7937,_7947,_7778).

command(new:::_7701,[command,_7777,_7806,_7840,!,_7869],_7763,_7765) --> 
    w(verb(_7723,pres,fin),_7777,_7763,_7794),
    gmem(_7723,[arrive,leave2,depart],_7806,_7794,_7825),
    look_ahead_place(_7840,_7825,_7855),
    !,
    pushstack(first,([jeg],w(verb(_7723,pres,fin))),nil,_7855,_7879),
    statreal(_7701,_7869,_7879,_7765).

command(doit:::_7701,[command,_7791,_7835,_7859,_7888,{},_7927,!,_7956],_7777,_7779) --> 
    optional(grums,_7791,_7777,_7823),
    please0(_7835,_7823,_7850),
    negation0(_7733,_7859,_7850,_7876),
    w(verb(_7741,imp,fin),_7888,_7876,_7905),
    {user:verbtype(_7741,tv)},
    look_ahead_np(_7927,_7905,_7942),
    !,
    pushstack(first,([du],w(verb(_7741,pres,fin)),negation(_7733)),nil,_7942,_7996),
    statreal(_7701,_7956,_7996,_7779).

command(doit:::_7701,[command,_7786,_7830,_7854,_7883,_7912,!,_7951],_7772,_7774) --> 
    optional(grums,_7786,_7772,_7818),
    please0(_7830,_7818,_7845),
    negation0(_7730,_7854,_7845,_7871),
    w(verb(_7738,imp,fin),_7883,_7871,_7900),
    particlev0(_7738,_7743,_7912,_7900,_7931),
    !,
    pushstack(first,([du],w(verb(_7743,pres,fin)),negation(_7730)),nil,_7931,_7991),
    statreal(_7701,_7951,_7991,_7774).

command(doit:::replyq(?),[command,_7736],_7722,_7724) --> 
    end_of_line(_7736,_7722,_7724).

imp_phrase(_7698,[imp_phrase,_7753,lit(oss),_7808,!],_7739,_7741) --> 
    lexv(_7709,let,imp,fin,_7753,_7739,_7776),
    cc(oss,_7776,_7807),
    w(verb(_7698,inf,fin),_7808,_7807,_7741),
    !.

imp_phrase(let,[imp_phrase,_7742,!,_7791],_7728,_7730) --> 
    lexv(rv,let,imp,fin,_7742,_7728,_7765),
    !,
    accept(_7791,_7765,_7730).

imp_phrase(list,[imp_phrase,_7745,_7769,!,_7818],_7731,_7733) --> 
    faa(_7745,_7731,_7760),
    lexv(_7709,see,imp,fin,_7769,_7760,_7792),
    !,
    accept(_7818,_7792,_7733).

imp_phrase(wait,[imp_phrase,_7740,!],_7726,_7728) --> 
    w(verb(wait,imp,fin),_7740,_7726,_7728),
    !.

imp_phrase(_7698,[imp_phrase,_7768,_7797,_7821,{},{}],_7754,_7756) --> 
    not_look_ahead([må],_7768,_7754,_7785),
    comeand0(_7797,_7785,_7812),
    lexv(_7727,_7698,imp,fin,_7821,_7812,_7756),
    {user:_7727\==rv},
    {user:(\+testmember(_7698,[have,expect]))}.

imp_phrase(_7698,[imp_phrase,_7767,_7796,_7820,{},{},_7884],_7753,_7755) --> 
    not_look_ahead([må],_7767,_7753,_7784),
    comeand0(_7796,_7784,_7811),
    lexv(rv,_7698,imp,fin,_7820,_7811,_7843),
    {user:_7698\==be},
    {user:_7698\==wonder},
    reflexiv0(_7698,_7884,_7843,_7755).

imp_phrase(_7698,[imp_phrase,_7768,_7797,_7821,{},{}],_7754,_7756) --> 
    not_look_ahead([må],_7768,_7754,_7785),
    comeand0(_7797,_7785,_7812),
    lexv(_7721,_7698,inf,fin,_7821,_7812,_7756),
    {user:testmember(_7698,[list,show,make])},
    {user:_7698\==be}.

comeand0([comeand0,_7738,lit(å),!],_7727,_7729) --> 
    w(verb(come,imp,fin),_7738,_7727,_7755),
    cc(å,_7755,_7729),
    !.

comeand0([comeand0,[]],_7713,_7713) --> 
    [].

declaration(_7700 isa self,[declaration,_7745,_7769,!,_7798],_7731,_7733) --> 
    i(_7745,_7731,_7760),
    be(_7769,_7760,_7784),
    !,
    newatomid(_7700,_7798,_7784,_7733).

declaration(_7698,[declaration,_7752,_7781,_7805,!,_7834],_7738,_7740) --> 
    newatom(_7716,_7752,_7738,_7769),
    be(_7781,_7769,_7796),
    a(_7805,_7796,_7820),
    !,
    noun(_7712,sin,u,n,_7716,_7698,_7834,_7820,_7740).

statement(_7698,[statement,lit(det),_7796,lit(at),_7836,_7865,_7904,!,_7933,[],_8004],_7771,_7773) --> 
    cc(det,_7771,_7795),
    be_truefalse(_7731,_7796,_7795,_7813),
    cc(at,_7813,_7835),
    look_ahead_lit([før,etter,når],_7836,_7835,_7853),
    adverbial3(_7743,_7744,_7745,_7865,_7853,_7886),
    comma0(_7904,_7886,_7919),
    !,
    accept(_7933,_7919,_7948),
    pushstack(free,adverbial1(_7743,_7744,_7745),nil,_7948,_8003),[],
    substatement1(_7698,_8004,_8003,_7773).

statement(_7698,[statement,_7771,_7800,_7839,!,_7868],_7757,_7759) --> 
    look_ahead_lit([hvis,om,selvom,da],_7771,_7757,_7788),
    adverbial3(_7718,_7719,_7720,_7800,_7788,_7821),
    soredundant(_7839,_7821,_7854),
    !,
    lock(last,_7854,_7918),
    pushstack(last,([så],xadverbial1(_7718,_7719,_7720)),nil,_7918,_7924),
    substatement1(_7698,_7868,_7924,_7913),
    unlock(_7913,_7759).

statement(_7698,[statement,_7795,_7824,_7863,_7892,lit(det),!,_7937,_7961],_7781,_7783) --> 
    look_ahead([hvis],_7795,_7781,_7812),
    adverbial3(_7730,_7731,_7732,_7824,_7812,_7845),
    not_look_ahead([så],_7863,_7845,_7880),
    w(verb(_7748,_7749,fin),_7892,_7880,_7909),
    cc(det,_7909,_7931),
    !,
    accept(_7937,_7931,_7952),
    lock(last,_7952,_8010),
    pushstack(last,([det],w(verb(_7748,_7749,fin)),xadverbial1(_7730,_7731,_7732)),nil,_8010,_8016),
    substatement1(_7698,_7961,_8016,_8005),
    unlock(_8005,_7783).

statement(_7698,[statement,_7793,_7822,_7861,_7890,lit(det),_7925,!,_7959,_7983],_7779,_7781) --> 
    look_ahead([hvis],_7793,_7779,_7810),
    adverbial3(_7736,_7737,_7738,_7822,_7810,_7843),
    not_look_ahead([så],_7861,_7843,_7878),
    aux1(_7890,_7878,_7905),
    cc(det,_7905,_7924),
    negation0(_7754,_7925,_7924,_7942),
    !,
    accept(_7959,_7942,_7974),
    lock(last,_7974,_8090),
    pushstack(last,([det],aux1,negation(_7754),xadverbial1(_7736,_7737,_7738)),nil,_8090,_8096),
    substatement1(_7698,_7983,_8096,_8085),
    unlock(_8085,_7781).

statement(_7698,[statement,_7798,_7827,_7866,_7895,_7919,_7953,_7977,!,_8011,_8035],_7784,_7786) --> 
    look_ahead([hvis],_7798,_7784,_7815),
    adverbial3(_7739,_7740,_7741,_7827,_7815,_7848),
    not_look_ahead([så],_7866,_7848,_7883),
    aux1(_7895,_7883,_7910),
    subject(_7755,_7756,_7919,_7910,_7938),
    redundant0(_7953,_7938,_7968),
    negation0(_7758,_7977,_7968,_7994),
    !,
    accept(_8011,_7994,_8026),
    lock(last,_8026,_8173),
    pushstack(last,(xnp(_7755,_7756),aux1,negation(_7758),xadverbial1(_7739,_7740,_7741)),nil,_8173,_8179),
    substatement1(_7698,_8035,_8179,_8168),
    unlock(_8168,_7786).

statement(_7698,[statement,_7800,_7829,_7868,_7897,!,_7931,!,_7970,_7994],_7786,_7788) --> 
    look_ahead([hvis],_7800,_7786,_7817),
    adverbial3(_7733,_7734,_7735,_7829,_7817,_7850),
    not_look_ahead([så],_7868,_7850,_7885),
    w(verb(_7751,_7752,fin),_7897,_7885,_7914),
    !,
    subject(_7755,_7756,_7931,_7914,_7950),
    !,
    accept(_7970,_7950,_7985),
    lock(last,_7985,_8074),
    pushstack(last,(xnp(_7755,_7756),w(verb(_7751,_7752,fin)),xadverbial1(_7733,_7734,_7735)),nil,_8074,_8080),
    substatement1(_7698,_7994,_8080,_8069),
    unlock(_8069,_7788).

statement(_7698,[statement,_7770,_7799,_7838,!,_7867,[],_7937],_7756,_7758) --> 
    look_ahead_lit([før,etter,når],_7770,_7756,_7787),
    adverbial3(_7728,_7729,_7730,_7799,_7787,_7820),
    comma0(_7838,_7820,_7853),
    !,
    accept(_7867,_7853,_7882),
    pushstack(free,adverbial1(_7728,_7729,_7730),nil,_7882,_7936),[],
    substatement1(_7698,_7937,_7936,_7758).

statement(_7698,[statement,_7734],_7720,_7722) --> 
    statemens(real,_7698,_7734,_7720,_7722).

substatement1(_7698,[substatement1,_7786,_7810,_7839,_7883,_7917,_7961,!,_8000],_7772,_7774) --> 
    dether(_7786,_7772,_7801),
    w(verb(be,_7733,fin),_7810,_7801,_7827),
    optional([ofte],_7839,_7827,_7871),
    np0_accept(_7727,_7728,_7883,_7871,_7902),
    optional([som],_7917,_7902,_7949),
    subject(_7747,_7748,_7961,_7949,_7980),
    !,
    pushstack(free,(xnp(_7747,_7748),xnp(_7727,_7728)),nil,_7980,_8072),
    statreal(_7698,_8000,_8072,_7774).

dether([dether,lit(det)],_7715,_7717) --> 
    cc(det,_7715,_7717).

dether([dether,lit(det),lit(her)],_7720,_7722) --> 
    cc(det,_7720,_7741),
    cc(her,_7741,_7722).

dether([dether,lit(dette)],_7715,_7717) --> 
    cc(dette,_7715,_7717).

substatement1(_7698,[substatement1,_7734],_7720,_7722) --> 
    statemen1(real,_7698,_7734,_7720,_7722).

statemens(_7698,_7699,[statemens,_7747,_7781],_7730,_7732) --> 
    statemen1(_7698,_7705,_7747,_7730,_7766),
    statemens0(_7698,_7705,_7699,_7781,_7766,_7732).

statemens0(_7698,_7699,_7699 and _7703,[statemens0,_7763,_7787,!,_7816],_7743,_7745) --> 
    stm_conjunction(_7763,_7743,_7778),
    aux1(_7787,_7778,_7802),
    !,
    pushstack(first,[jeg],nil,_7802,_7826),
    statemens(_7698,_7703,_7816,_7826,_7745).

statemens0(_7698,_7699,_7699 and _7703,[statemens0,_7766,_7790,!,_7824],_7746,_7748) --> 
    stm_conjunction(_7766,_7746,_7781),
    look_ahead_lit([så,nå,da],_7790,_7781,_7807),
    !,
    statemens(_7698,_7703,_7824,_7807,_7748).

statemens0(_7698,_7699,_7699 and _7703,[statemens0,_7759,!,_7793],_7739,_7741) --> 
    look_ahead([så],_7759,_7739,_7776),
    !,
    statemens(_7698,_7703,_7793,_7776,_7741).

statemens0(_7698,_7699,_7699 and _7703,[statemens0,_7769,_7793,_7822,!,_7851],_7749,_7751) --> 
    stm_conjunction(_7769,_7749,_7784),
    not_look_ahead(w(verb(_7724,_7725,_7726)),_7793,_7784,_7810),
    not_look_ahead_number(_7822,_7810,_7837),
    !,
    statemens(_7698,_7703,_7851,_7837,_7751).

statemens0(_7698,_7699,_7699,[statemens0,[]],_7723,_7723) --> 
    [].

stm_conjunction([stm_conjunction,lit(hvorav)],_7715,_7717) --> 
    cc(hvorav,_7715,_7717).

stm_conjunction([stm_conjunction,lit(å),_7744],_7722,_7724) --> 
    cc(å,_7722,_7743),
    look_ahead([så],_7744,_7743,_7724).

stm_conjunction([stm_conjunction,lit(å),_7744],_7722,_7724) --> 
    cc(å,_7722,_7743),
    look_ahead([nå],_7744,_7743,_7724).

stm_conjunction([stm_conjunction,lit(og),_7744],_7722,_7724) --> 
    cc(og,_7722,_7743),
    look_ahead([nå],_7744,_7743,_7724).

stm_conjunction([stm_conjunction,lit(og),lit(at)],_7720,_7722) --> 
    cc(og,_7720,_7741),
    cc(at,_7741,_7722).

stm_conjunction([stm_conjunction,lit(men),lit(at)],_7720,_7722) --> 
    cc(men,_7720,_7741),
    cc(at,_7741,_7722).

stm_conjunction([stm_conjunction,lit(altså),lit(at)],_7720,_7722) --> 
    cc(altså,_7720,_7741),
    cc(at,_7741,_7722).

stm_conjunction([stm_conjunction,_7724],_7713,_7715) --> 
    and1(_7724,_7713,_7715).

stm_conjunction([stm_conjunction,lit(men)],_7715,_7717) --> 
    cc(men,_7715,_7717).

stm_conjunction([stm_conjunction,_7728],_7717,_7719) --> 
    look_ahead([så],_7728,_7717,_7719).

stm_conjunction([stm_conjunction,_7735,_7779],_7724,_7726) --> 
    optional([','],_7735,_7724,_7767),
    look_ahead([ikke],_7779,_7767,_7726).

stm_conjunction([stm_conjunction,lit(mens)],_7715,_7717) --> 
    cc(mens,_7715,_7717).

statemen1(_7698,_7699,[statemen1,_7740],_7723,_7725) --> 
    stateme1(_7698,_7699,_7740,_7723,_7725).

statemen1(_7698,_7699,[statemen1,_7799,{},_7838,!,_7887],_7782,_7784) --> 
    w(adj2(_7729,nil),_7799,_7782,_7816),
    {user:testmember(_7729,[possible,clear,ready])},
    optional([at],_7838,_7816,_7870),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7729,nil)),[at]),nil,_7870,_7897),
    substateme1(_7698,_7699,_7887,_7897,_7784).

statemen1(_7698,_7699,[statemen1,_7823,{},_7862,{},{},_7911,!,_7950,!,_8029],_7806,_7808) --> 
    w(adj2(_7730,nil),_7823,_7806,_7840),
    {user:testmember(_7730,[enclosed])},
    w(verb(_7742,_7743,fin),_7862,_7840,_7879),
    {user:(\+testmember(_7742,[]))},
    {user:verbtype(_7742,iv)},
    subject(_7758,_7759,_7911,_7879,_7930),
    !,
    pushstack(first,(xnp(_7758,_7759),w(verb(_7742,_7743,fin)),w(adj2(_7730,nil))),nil,_7930,_7994),substateme1(_7698,_7699,_7950,_7994,_8009),
    !,
    accept(_8029,_8009,_7808).

statemen1(_7698,_7699,[statemen1,_7790,_7814,{},lit(det),_7864,_7888,!,_7936],_7773,_7775) --> 
    redundant(_7790,_7773,_7805),
    w(verb(_7724,_7725,fin),_7814,_7805,_7831),
    {user:(\+testmember(_7724,[]))},
    cc(det,_7831,_7863),
    danow0(_7864,_7863,_7879),
    pushstack(first,([det],w(verb(_7724,pres,fin))),nil,_7879,_7901),substateme1(_7698,_7699,_7888,_7901,_7916),
    !,
    accept(_7936,_7916,_7775).

statemen1(_7698,_7699,[statemen1,_7799,_7843,{},_7882,!,_7930],_7782,_7784) --> 
    optional([meget],_7799,_7782,_7831),
    w(adj2(_7722,nil),_7843,_7831,_7860),
    {user:testmember(_7722,[good,bad,interesting,nice])},
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7722,nil))),nil,_7860,_7895),substateme1(_7698,_7699,_7882,_7895,_7910),
    !,
    accept(_7930,_7910,_7784).

statemen1(_7698,_7699,[statemen1,_7760,{},_7799],_7743,_7745) --> 
    not_look_ahead_lit([hva,hvem,hvilke,hvilken,hvilket],_7760,_7743,_7777),
    {user:unprotected_verb},
    substateme1(_7698,_7699,_7799,_7777,_7745).

statemen1(_7698,_7699,[statemen1,lit(som),lit(du),_7825,{},_7864,_7893,_7927],_7786,_7788) --> 
    cc(som,_7786,_7813),
    cc(du,_7813,_7824),
    w(verb(_7737,_7738,fin),_7825,_7824,_7842),
    {user:testmember(_7737,[know,see,understand])},
    w(verb(_7727,_7755,fin),_7864,_7842,_7881),
    subject(_7758,_7759,_7893,_7881,_7912),
    pushstack(first,(xnp(_7758,_7759),w(verb(_7727,pres,fin))),nil,_7912,_7968),
    substateme1(_7698,_7699,_7927,_7968,_7788).

statemen1(_7698,_7699,[statemen1,_7774,_7798,lit(det),_7838,!],_7757,_7759) --> 
    soredundant(_7774,_7757,_7789),
    w(verb(_7715,_7716,fin),_7798,_7789,_7815),
    cc(det,_7815,_7837),
    pushstack(first,([noe],w(verb(_7715,_7716,fin))),nil,_7837,_7851),substateme1(_7698,_7699,_7838,_7851,_7759),
    !.

stateme1(_7698,_7699,[stateme1,_7749],_7732,_7734) --> 
    statem(_7701,event/_7698/_7701::_7699,_7749,_7732,_7734).

substateme1(_7698,_7699,[substateme1,_7749],_7732,_7734) --> 
    substatem1(_7701,event/_7698/_7701::_7699,_7749,_7732,_7734).

substatem(_7698,_7699,[substatem,_7747,_7781],_7730,_7732) --> 
    substatem1(_7698,_7705,_7747,_7730,_7766),
    ogat(_7698,_7705,_7699,_7781,_7766,_7732).

ogat(_7698,_7702::_7705,_7702::_7705 and _7706,[ogat,lit(og),lit(at),!,_7798],_7751,_7753) --> 
    cc(og,_7751,_7781),
    cc(at,_7781,_7792),
    !,
    substatem1(_7698,_7702::_7706,_7798,_7792,_7753).

ogat(_7698,_7699,_7699,[ogat,[]],_7723,_7723) --> 
    [].

substatem1(_7698,_7699,[substatem1,lit(det),_7800,_7829,{},!,[],_7917],_7772,_7774) --> 
    cc(det,_7772,_7799),
    negation0(_7733,_7800,_7799,_7817),
    be(_7735,_7829,_7817,_7846),
    {user:bigno(_7733,_7735,_7741)},
    !,
    pushstack(free,negation(_7741),nil,_7846,_7916),[],
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_7916,_7927),
    statem(_7698,_7699,_7917,_7927,_7774).

substatem1(_7698,_7699,[substatem1,lit(det),_7801,_7830,{},!,_7894],_7773,_7775) --> 
    cc(det,_7773,_7800),
    negation0(_7729,_7801,_7800,_7818),
    hlexv(_7731,_7732,_7733,fin,_7735,_7830,_7818,_7855),
    {user:bigno(_7729,_7735,_7725)},
    !,
    pushstack(first,([det],w(verb(_7732,pres,fin)),negation(_7725)),nil,_7855,_7934),
    statem(_7698,_7699,_7894,_7934,_7775).

substatem1(_7698,_7699,[substatem1,lit(å),!,_7784,!,_7832],_7751,_7753) --> 
    cc(å,_7751,_7778),
    !,
    pushstack(first,[jeg],nil,_7778,_7797),clausal_object1(_7716,_7717,_7784,_7797,_7812),
    !,
    lock(last,_7812,_7880),
    pushstack(last,xnp(_7716,_7717),nil,_7880,_7886),
    statem(_7698,_7699,_7832,_7886,_7875),
    unlock(_7875,_7753).

substatem1(_7698,_7699,[substatem1,_7793,_7817,_7846,_7889,!,_7918],_7776,_7778) --> 
    forå(_7793,_7776,_7808),
    w(verb(_7728,inf,fin),_7817,_7808,_7834),
    pushstack(first,([jeg],w(verb(_7728,pres,fin))),nil,_7834,_7859),clausal_object1(_7723,true::_7724,_7846,_7859,_7874),
    hvisaa0(_7889,_7874,_7904),
    !,
    lock(last,_7904,_7968),
    pushstack(last,([så],subordinate(in_order_to,_7723,_7724)),nil,_7968,_7974),
    statem(_7698,_7699,_7918,_7974,_7963),
    unlock(_7963,_7778).

substatem1(_7698,_7699,[substatem1,_7813,_7842,[],_7926,_7950,lit(det),_7985,_8009,!,_8043],_7796,_7798) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom],_7813,_7796,_7830),
    subordinate(_7755,_7756,_7757,_7842,_7830,_7863),
    pushstack(free,subordinate(_7755,_7756,_7757),nil,_7863,_7925),[],
    hvisaa0(_7926,_7925,_7941),
    has(_7950,_7941,_7965),
    cc(det,_7965,_7984),
    redundant0(_7985,_7984,_8000),
    w(verb(be,past,part),_8009,_8000,_8026),
    !,
    pushstack(first,w(verb(be,past,fin)),nil,_8026,_8053),
    itstatem(_7698,_7699,_8043,_8053,_7798).

substatem1(_7698,_7699,[substatem1,_7790,_7819,_7858,!,_7887],_7773,_7775) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom,da,når],_7790,_7773,_7807),
    subordinate(_7719,_7720,_7721,_7819,_7807,_7840),
    hvisaa0(_7858,_7840,_7873),
    !,
    lock(last,_7873,_7936),
    pushstack(last,([så],subordinate(_7719,_7720,_7721)),nil,_7936,_7942),
    statem(_7698,_7699,_7887,_7942,_7931),
    unlock(_7931,_7775).

substatem1(_7698,_7699,[substatem1,_7740],_7723,_7725) --> 
    substate(_7698,_7699,_7740,_7723,_7725).

hvisaa0([hvisaa0,lit(så),!],_7718,_7720) --> 
    cc(så,_7718,_7720),
    !.

hvisaa0([hvisaa0,_7731,!],_7720,_7722) --> 
    look_ahead_lit([ble],_7731,_7720,_7722),
    !.

hvisaa0([hvisaa0,_7733,!],_7722,_7724) --> 
    look_ahead_lit([kan,får],_7733,_7722,_7724),
    !.

hvisaa0([hvisaa0,_7748,{}],_7737,_7739) --> 
    look_ahead(w(verb(_7703,_7719,fin)),_7748,_7737,_7739),
    {user:testmember(_7703,[avoid,be,come,have])}.

hvisaa0([hvisaa0,[]],_7713,_7713) --> 
    [].

sostatem(_7698,_7699,[sostatem,_7795,_7819,_7853,_7877,_7906,!,_7940,!],_7778,_7780) --> 
    faux1(_7795,_7778,_7810),
    subject(_7722,_7723,_7819,_7810,_7838),
    redundant0(_7853,_7838,_7868),
    negation0(_7725,_7877,_7868,_7894),
    w(verb(_7729,inf,fin),_7906,_7894,_7923),
    !,
    pushstack(first,(xnp(_7722,_7723),aux1,negation(_7725),w(verb(_7729,inf,fin))),nil,_7923,_8042),state(_7698,_7699,_7940,_8042,_7780),
    !.

sostatem(_7698,_7699,[sostatem,_7815,lit(det),_7855,_7884,lit(at),!,_7944,_7978],_7798,_7800) --> 
    w(verb(_7741,_7742,fin),_7815,_7798,_7832),
    cc(det,_7832,_7854),
    negation0(_7747,_7855,_7854,_7872),
    adj1(_7734,_7754:_7755,_7736,_7737,_7884,_7872,_7907),
    cc(at,_7907,_7938),
    !,
    clausal_object1(_7759,_7760,_7944,_7938,_7963),
    pushstack(first,(xnp(_7759,_7760),w(verb(_7741,_7742,fin)),negation(_7747),adj1(_7734,_7754:_7777,_7736,_7737)),nil,_7963,_8082),
    state(_7698,_7699,_7978,_8082,_7800).

sostatem(_7698,_7699,[sostatem,_7794,lit(det),_7829,_7853,_7882,_7911,_7945,!],_7777,_7779) --> 
    has(_7794,_7777,_7809),
    cc(det,_7809,_7828),
    preadverbials0(_7829,_7828,_7844),
    negation0(_7724,_7853,_7844,_7870),
    w(verb(_7728,past,part),_7882,_7870,_7899),
    subject(_7732,_7733,_7911,_7899,_7930),
    pushstack(first,(xnp(_7732,_7733),w(verb(_7728,past,fin)),negation(_7724)),nil,_7930,_8019),state(_7698,_7699,_7945,_8019,_7779),
    !.

sostatem(_7698,_7699,[sostatem,_7793,_7842,_7871,_7895,{},_7934,!],_7776,_7778) --> 
    lexvaccept(rv,_7720,_7721,fin,_7723,_7793,_7776,_7818),
    negation0(_7725,_7842,_7818,_7859),
    thereit(_7871,_7859,_7886),
    negation0(_7727,_7895,_7886,_7912),
    {user:bigno(_7725,_7727,_7723)},
    pushstack(first,([noe],w(verb(_7720,_7721,fin)),negation(_7723)),nil,_7912,_7977),state(_7698,_7699,_7934,_7977,_7778),
    !.

sostatem(_7698,_7699,[sostatem,_7797,_7826,_7855,_7889,{},_7928,!],_7780,_7782) --> 
    w(verb(_7721,_7722,fin),_7797,_7780,_7814),
    negation0(_7725,_7826,_7814,_7843),
    subject(_7727,_7728,_7855,_7843,_7874),
    negation0(_7730,_7889,_7874,_7906),
    {user:bigno(_7725,_7730,_7736)},
    pushstack(first,(xnp(_7727,_7728),w(verb(_7721,_7722,fin)),negation(_7736)),nil,_7906,_8002),state(_7698,_7699,_7928,_8002,_7782),
    !.

sostatem(_7698,_7699,[sostatem,_7779,_7808,_7832,_7861,!],_7762,_7764) --> 
    w(verb(_7715,_7716,pass),_7779,_7762,_7796),
    thereit0(_7808,_7796,_7823),
    negation0(_7719,_7832,_7823,_7849),
    pushstack(first,([noen],w(verb(_7715,_7716,fin)),negation(_7719)),nil,_7849,_7904),state(_7698,_7699,_7861,_7904,_7764),
    !.

sostatem(_7698,_7699,[sostatem,_7791,lit(det),_7826,{},!,_7870,!],_7774,_7776) --> 
    aux1(_7791,_7774,_7806),
    cc(det,_7806,_7825),
    w(verb(_7723,_7724,_7725),_7826,_7825,_7843),
    {user:(_7724=inf;_7725=part)},
    !,
    pushstack(first,([noe],w(verb(_7723,pres,fin))),nil,_7843,_7883),state(_7698,_7699,_7870,_7883,_7776),
    !.

sostatem(_7698,_7699,[sostatem,_7775,lit(det),_7810,!,_7844,!],_7758,_7760) --> 
    aux1(_7775,_7758,_7790),
    cc(det,_7790,_7809),
    w(verb(_7720,pres,pass),_7810,_7809,_7827),
    !,
    pushstack(first,(someone,w(verb(_7720,pres,fin))),nil,_7827,_7888),state(_7698,_7699,_7844,_7888,_7760),
    !.

sostatem(_7698,_7699,[sostatem,_7782,_7806,_7840,!,_7874,!],_7765,_7767) --> 
    aux1(_7782,_7765,_7797),
    object(_7716,_7717,_7806,_7797,_7825),
    w(verb(_7721,pres,pass),_7840,_7825,_7857),
    !,
    pushstack(first,(someone,w(verb(_7721,pres,fin)),xnp(_7716,_7717)),nil,_7857,_7946),state(_7698,_7699,_7874,_7946,_7767),
    !.

sostatem(_7698,_7699,[sostatem,_7784,_7813,{},lit(det),!,_7868,!],_7767,_7769) --> 
    not_look_ahead([så],_7784,_7767,_7801),
    w(verb(_7725,_7726,fin),_7813,_7801,_7830),
    {user:_7726\==inf},
    cc(det,_7830,_7862),
    !,
    pushstack(free,w(verb(_7725,pres,fin)),nil,_7862,_7881),state(_7698,_7699,_7868,_7881,_7769),
    !.

sostatem(_7698,_7699,[sostatem,_7782,_7806,_7840,!,_7874,!],_7765,_7767) --> 
    docan(_7782,_7765,_7797),
    subject(_7716,_7717,_7806,_7797,_7825),
    w(verb(_7721,pres,pass),_7840,_7825,_7857),
    !,
    pushstack(first,(someone,w(verb(_7721,pres,fin)),xnp(_7716,_7717)),nil,_7857,_7946),state(_7698,_7699,_7874,_7946,_7767),
    !.

statem(_7698,_7699,[statem,lit(det),_7809,_7838,_7872,!,_7906],_7781,_7783) --> 
    cc(det,_7781,_7808),
    w(verb(_7734,_7735,pass),_7809,_7808,_7826),
    gmem(_7734,[want,wish,need],_7838,_7826,_7857),
    negation0(_7747,_7872,_7857,_7889),
    !,
    pushstack(first,([noen],w(verb(_7734,_7735,fin)),negation(_7747),[dette]),nil,_7889,_7946),
    state(_7698,_7699,_7906,_7946,_7783).

statem(_7698,_7699,[statem,_7746,!,_7775],_7729,_7731) --> 
    preadverbials(_7746,_7729,_7761),
    !,
    prestatem(_7698,_7699,_7775,_7761,_7731).

statem(_7698,_7699,[statem,_7791,_7825,_7854,_7878,!,[],_7964],_7774,_7776) --> 
    obviousdate1(_7731,_7732,_7791,_7774,_7810),
    w(verb(_7727,_7728,fin),_7825,_7810,_7842),
    det0(_7854,_7842,_7869),
    subject(_7740,_7741,_7878,_7869,_7897),
    !,
    pushstack(free,obviousdate1(_7731,_7732),nil,_7897,_7963),[],
    pushstack(first,(xnp(_7740,_7741),w(verb(_7727,_7728,fin))),nil,_7963,_8005),
    state(_7698,_7699,_7964,_8005,_7776).

statem(_7698,_7699,[statem,_7785,_7819,_7848,!,_7897],_7768,_7770) --> 
    obviousdate1(_7722,_7723,_7785,_7768,_7804),
    w(verb(_7730,_7731,pass),_7819,_7804,_7836),
    optional([det],_7848,_7836,_7880),
    !,
    pushstack(free,([noen],w(verb(_7730,_7731,fin)),obviousdate1(_7722,_7723)),nil,_7880,_7938),
    state(_7698,_7699,_7897,_7938,_7770).

statem(_7698,_7699,[statem,_7832,_7866,_7895,_7929,_7963,_7992,lit(om),!,[],[],_8065],_7815,_7817) --> 
    lit_of(_7742,[det,dette],_7832,_7815,_7851),
    w(verb(_7751,_7752,fin),_7866,_7851,_7883),
    gmem(_7751,[worry],_7895,_7883,_7914),
    lit_of(_7760,[jeg,du,man],_7929,_7914,_7948),
    reflexiv0(_7751,_7963,_7948,_7980),
    negation0(_7740,_7992,_7980,_8009),
    cc(om,_8009,_8031),
    !,
    pushstack(free,[dette],nil,_8031,_8050),[],
    pushstack(free,[om],nil,_8050,_8064),[],
    pushstack(first,([_7760],w(verb(_7751,_7752,fin)),negation(_7740)),nil,_8064,_8105),
    state(_7698,_7699,_8065,_8105,_7817).

statem(_7698,_7699,[statem,_7826,_7860,_7889,_7923,lit(om),!,[],[],[],_8053],_7809,_7811) --> 
    lit_of(_7740,[det,dette],_7826,_7809,_7845),
    w(verb(_7736,_7737,fin),_7860,_7845,_7877),
    lit_of(_7753,[jeg,du,man],_7889,_7877,_7908),
    np_kernel(0,_7763,_7764,_7923,_7908,_7944),
    cc(om,_7944,_7972),
    !,
    pushstack(free,[dette],nil,_7972,_7991),[],
    pushstack(free,[om],nil,_7991,_8005),[],
    pushstack(free,np_kernel(0,_7763,_7764),nil,_8005,_8052),[],
    pushstack(first,([_7753],w(verb(_7736,_7737,fin))),nil,_8052,_8063),
    state(_7698,_7699,_8053,_8063,_7811).

statem(_7698,_7699,[statem,_7826,_7860,_7889,_7923,lit(om),!,[],[],[],_8052],_7809,_7811) --> 
    lit_of(_7740,[det,dette],_7826,_7809,_7845),
    w(verb(have,_7737,fin),_7860,_7845,_7877),
    lit_of(_7753,[jeg,du,man],_7889,_7877,_7908),
    np_kernel(0,_7763,_7764,_7923,_7908,_7944),
    cc(om,_7944,_7972),
    !,
    pushstack(free,[dette],nil,_7972,_7991),[],
    pushstack(free,[om],nil,_7991,_8005),[],
    pushstack(free,np_kernel(0,_7763,_7764),nil,_8005,_8051),[],
    pushstack(first,([_7753],w(verb(have,_7737,fin))),nil,_8051,_8062),
    state(_7698,_7699,_8052,_8062,_7811).

statem(_7698,_7699,[statem,_7818,_7857,lit(det),_7892,_7931,_7960,!,_7999],_7801,_7803) --> 
    preadverbial1(_7741,_7742,_7743,_7818,_7801,_7839),
    blei(_7857,_7839,_7872),
    cc(det,_7872,_7891),
    preadverbial0(_7737,_7738,_7739,_7892,_7891,_7913),
    w(verb(_7753,past,part),_7931,_7913,_7948),
    object(_7757,_7758,_7960,_7948,_7979),
    !,
    pushstack(first,(xnp(_7757,_7758),w(verb(be,pres,fin)),w(verb(_7753,past,part)),adverbial1(_7741,_7742,_7743),adverbial1(_7737,_7738,_7739)),nil,_7979,_8104),
    state(_7698,_7699,_7999,_8104,_7803).

statem(_7698,_7699,[statem,_7853,_7882,_7916,_7945,_7979,_8013,_8042,_8086,!,_8120],_7836,_7838) --> 
    not_look_ahead([det],_7853,_7836,_7870),
    obvious_object(_7746,_7747,_7882,_7870,_7901),
    w(verb(_7758,_7759,fin),_7916,_7901,_7933),
    gmem(_7758,[want,wish,need],_7945,_7933,_7964),
    lit_of(_7771,[jeg,vi,han,hun,du],_7979,_7964,_7998),
    negation0(_7784,_8013,_7998,_8030),
    optional([å],_8042,_8030,_8074),
    w(verb(_7792,inf,fin),_8086,_8074,_8103),
    !,
    pushstack(first,([_7771],w(verb(_7758,_7759,fin)),negation(_7784),[å],w(verb(_7792,_7759,fin)),xnp(_7746,_7747)),nil,_8103,_8191),
    state(_7698,_7699,_8120,_8191,_7838).

statem(_7698,_7699,[statem,_7820,_7849,_7883,_7912,_7946,_7980,!,_8014],_7803,_7805) --> 
    not_look_ahead([det],_7820,_7803,_7837),
    obvious_object(_7731,_7732,_7849,_7837,_7868),
    w(verb(_7743,_7744,fin),_7883,_7868,_7900),
    gmem(_7743,[have,get],_7912,_7900,_7931),
    lit_of(_7754,[jeg,vi,han,hun,du],_7946,_7931,_7965),
    w(verb(_7769,past,part),_7980,_7965,_7997),
    !,
    pushstack(first,([_7754],w(verb(_7769,_7744,fin)),xnp(_7731,_7732)),nil,_7997,_8055),
    state(_7698,_7699,_8014,_8055,_7805).

statem(_7698,_7699,[statem,_7823,_7852,_7886,{},_7925,_7959,!,_7993],_7806,_7808) --> 
    not_look_ahead([det],_7823,_7806,_7840),
    obvious_object(_7734,_7735,_7852,_7840,_7871),
    w(verb(_7746,_7747,fin),_7886,_7871,_7903),
    {user:(\+testmember(_7746,[give]))},
    lit_of(_7759,[jeg,vi,han,hun,du],_7925,_7903,_7944),
    negation0(_7772,_7959,_7944,_7976),
    !,
    pushstack(first,([_7759],w(verb(_7746,_7747,fin)),negation(_7772),xnp(_7734,_7735)),nil,_7976,_8064),
    state(_7698,_7699,_7993,_8064,_7808).

statem(_7698,_7699,[statem,_7857,_7886,_7920,_7949,_7983,_8017,_8061,_8090,!,_8124],_7840,_7842) --> 
    not_look_ahead([det],_7857,_7840,_7874),
    obvious_object(_7746,_7747,_7886,_7874,_7905),
    w(verb(_7758,_7759,fin),_7920,_7905,_7937),
    gmem(_7758,[want,wish,need],_7949,_7937,_7968),
    lit_of(_7771,[jeg,vi,han,hun,du],_7983,_7968,_8002),
    optional([å],_8017,_8002,_8049),
    w(verb(_7790,inf,fin),_8061,_8049,_8078),
    w(prep(_7796),_8090,_8078,_8107),
    !,
    pushstack(first,([_7771],w(verb(_7758,_7759,fin)),[å],w(verb(_7790,_7759,fin)),w(prep(_7796)),xnp(_7746,_7747)),nil,_8107,_8165),
    state(_7698,_7699,_8124,_8165,_7842).

statem(_7698,_7699,[statem,_7801,lit(kan),_7846,_7880,!,_7914],_7784,_7786) --> 
    obvious_object(_7725,_7726,_7801,_7784,_7820),
    cc(kan,_7820,_7845),
    lit_of(_7733,[jeg,vi,han,hun,du],_7846,_7845,_7865),
    not_look_ahead(w(verb(_7750,_7751,_7752)),_7880,_7865,_7897),
    !,
    pushstack(first,([_7733],w(verb(do1,pres,fin)),xnp(_7725,_7726)),nil,_7897,_7955),
    state(_7698,_7699,_7914,_7955,_7786).

statem(_7698,_7699,[statem,_7804,_7833,_7867,_7891,_7925,!,_7959],_7787,_7789) --> 
    not_look_ahead([det],_7804,_7787,_7821),
    obvious_object(_7728,_7729,_7833,_7821,_7852),
    aux1(_7867,_7852,_7882),
    lit_of(_7738,[jeg,vi,han,hun,du],_7891,_7882,_7910),
    w(verb(_7753,inf,fin),_7925,_7910,_7942),
    !,
    pushstack(first,([_7738],w(verb(_7753,pres,fin)),xnp(_7728,_7729)),nil,_7942,_8000),
    state(_7698,_7699,_7959,_8000,_7789).

statem(_7698,_7699,[statem,_7804,_7833,_7867,_7891,_7925,!,_7959],_7787,_7789) --> 
    not_look_ahead([det],_7804,_7787,_7821),
    obvious_object(_7728,_7729,_7833,_7821,_7852),
    aux1(_7867,_7852,_7882),
    lit_of(_7738,[jeg,vi,han,hun,du],_7891,_7882,_7910),
    w(verb(_7753,inf,fin),_7925,_7910,_7942),
    !,
    pushstack(first,([_7738],w(verb(_7753,pres,fin)),xnp(_7728,_7729)),nil,_7942,_8000),
    state(_7698,_7699,_7959,_8000,_7789).

statem(_7698,_7699,[statem,lit(det),lit(som),!,_7800],_7756,_7758) --> 
    cc(det,_7756,_7783),
    cc(som,_7783,_7794),
    !,
    pushstack(first,([en],w(noun(thing,sin,u,n)),[som]),nil,_7794,_7810),
    state(_7698,_7699,_7800,_7810,_7758).

statem(_7698,_7699,[statem,_7794,_7823,_7847,lit(å),!,_7892],_7777,_7779) --> 
    one_of_lit([nå,så,da,redundant0],_7794,_7777,_7811),
    shoulditbe(_7823,_7811,_7838),
    w(adj2(_7739,_7740),_7847,_7838,_7864),
    cc(å,_7864,_7886),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_7739,_7740)),[å]),nil,_7886,_7902),
    itstatem(_7698,_7699,_7892,_7902,_7779).

statem(_7698,_7699,[statem,_7766,_7795,_7819,!],_7749,_7751) --> 
    one_of_lit([nå,så,da],_7766,_7749,_7783),
    shoulditbe(_7795,_7783,_7810),
    pushstack(first,w(verb(be,pres,fin)),nil,_7810,_7832),itstatem(_7698,_7699,_7819,_7832,_7751),
    !.

shoulditbe([shoulditbe,_7738,_7767,lit(det)],_7727,_7729) --> 
    w(verb(be,_7709,fin),_7738,_7727,_7755),
    redundant0(_7767,_7755,_7782),
    cc(det,_7782,_7729).

shoulditbe([shoulditbe,_7741,_7765,lit(det),_7800],_7730,_7732) --> 
    aux1(_7741,_7730,_7756),
    redundant0(_7765,_7756,_7780),
    cc(det,_7780,_7799),
    w(verb(be,inf,fin),_7800,_7799,_7732).

shoulditbe([shoulditbe,_7742,lit(det),_7782],_7731,_7733) --> 
    one_of_lit([kan,kunne,får,fikk],_7742,_7731,_7759),
    cc(det,_7759,_7781),
    vaere(_7782,_7781,_7733).

vaere([vaere,_7734],_7723,_7725) --> 
    one_of_lit([være,vært,bli,blitt],_7734,_7723,_7725).

statem(_7698,_7699,[statem,lit(det),_7817,_7841,_7875,{},{},!,_7929],_7789,_7791) --> 
    cc(det,_7789,_7816),
    aux1(_7817,_7816,_7832),
    subject(_7735,_7736,_7841,_7832,_7860),
    w(verb(_7740,inf,fin),_7875,_7860,_7892),
    {user:testmember(_7740,[believe,know])},
    {user:verbtype(_7740,rv)},
    !,
    pushstack(first,(xnp(_7735,_7736),w(verb(_7740,pres,fin)),[dette]),nil,_7892,_7970),
    state(_7698,_7699,_7929,_7970,_7791).

statem(_7698,_7699,[statem,_7810,_7844,{},{},_7893,!,_7932],_7793,_7795) --> 
    obvious_object(_7731,_7732,_7810,_7793,_7829),
    w(verb(_7739,_7740,fin),_7844,_7829,_7861),
    {user:testmember(_7739,[believe,know])},
    {user:verbtype(_7739,rv)},
    subject(_7757,_7758,_7893,_7861,_7912),
    !,
    pushstack(first,(xnp(_7757,_7758),w(verb(_7739,_7740,fin)),[at],xnp(_7731,_7732)),nil,_7912,_8004),
    state(_7698,_7699,_7932,_8004,_7795).

statem(_7698,_7699,[statem,_7788,_7822,_7846,_7880,!,_7914],_7771,_7773) --> 
    obvious_object(_7725,_7726,_7788,_7771,_7807),
    has(_7822,_7807,_7837),
    subject(_7731,_7732,_7846,_7837,_7865),
    w(verb(_7736,past,part),_7880,_7865,_7897),
    !,
    pushstack(first,(xnp(_7731,_7732),w(verb(_7736,past,fin)),xnp(_7725,_7726)),nil,_7897,_7986),
    state(_7698,_7699,_7914,_7986,_7773).

statem(_7698,_7699,[statem,lit(å),_7811,_7840,_7883,!,_7917],_7783,_7785) --> 
    cc(å,_7783,_7810),
    w(verb(_7729,inf,fin),_7811,_7810,_7828),
    pushstack(first,([noen],w(verb(_7729,pres,fin))),nil,_7828,_7853),clausal_object1(_7719,_7722::_7723,_7840,_7853,_7868),
    look_ahead(w(verb(be,pres,fin)),_7883,_7868,_7900),
    !,
    pushstack(first,xnp(_7719,_7722::_7723),nil,_7900,_7958),
    state(_7698,_7699,_7917,_7958,_7785).

statem(_7698,_7699,[statem,lit(det),_7813,lit(seg),_7853,_7882,lit(å),!,_7927,!],_7785,_7787) --> 
    cc(det,_7785,_7812),
    w(verb(let,_7730,fin),_7813,_7812,_7830),
    cc(seg,_7830,_7852),
    negation0(_7735,_7853,_7852,_7870),
    w(verb(do1,inf,fin),_7882,_7870,_7899),
    cc(å,_7899,_7921),
    !,
    pushstack(first,(w(noun(agent,sin,u,n)),aux1,negation(_7735)),nil,_7921,_7998),state(_7698,_7699,_7927,_7998,_7787),
    !.

statem(_7698,_7699,[statem,_7743,_7767],_7726,_7728) --> 
    soredundant(_7743,_7726,_7758),
    sostatem(_7698,_7699,_7767,_7758,_7728).

statem(_7698,_7699,[statem,_7793,_7822,{},_7861,_7900],_7776,_7778) --> 
    w(noun(_7725,_7726,_7727,n),_7793,_7776,_7810),
    look_ahead(w(prep(_7719)),_7822,_7810,_7839),
    {user:testmember(_7719,[at])},
    pp(_7719,_7720,_7721,_7861,_7839,_7882),
    pushstack(free,(w(noun(_7725,_7726,_7727,n)),pp(_7719,_7720,_7721)),nil,_7882,_7943),
    state(_7698,_7699,_7900,_7943,_7778).

statem(_7698,_7699,[statem,_7817,_7851,{},_7890,_7924,!,_7958,!],_7800,_7802) --> 
    lit_of(_7722,[dette],_7817,_7800,_7836),
    w(verb(_7729,_7730,fin),_7851,_7836,_7868),
    {user:(\+testmember(_7729,[be,give,take,cost]))},
    subject(_7748,_7749,_7890,_7868,_7909),
    negation0(_7751,_7924,_7909,_7941),
    !,
    pushstack(first,(xnp(_7748,_7749),w(verb(_7729,_7730,fin)),negation(_7751),[_7722]),nil,_7941,_8032),state(_7698,_7699,_7958,_8032,_7802),
    !.

statem(_7698,_7699,[statem,_7809,{},_7848,!,_7882],_7792,_7794) --> 
    w(adj2(_7731,nil),_7809,_7792,_7826),
    {user:testmember(_7731,[good,bad,correct,true,mild,hot,cold])},
    w(prep(_7727),_7848,_7826,_7865),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7731,nil)),w(prep(_7727))),nil,_7865,_7892),
    state(_7698,_7699,_7882,_7892,_7794).

statem(_7698,_7699,[statem,_7809,{},_7848,!,_7882],_7792,_7794) --> 
    w(adj2(_7731,nil),_7809,_7792,_7826),
    {user:testmember(_7731,[good,bad,correct,true,mild,hot,cold])},
    w(adv(_7727),_7848,_7826,_7865),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7731,nil)),w(adv(_7727))),nil,_7865,_7892),
    state(_7698,_7699,_7882,_7892,_7794).

statem(_7698,_7699,[statem,_7773,_7797,_7826,!,_7860,!,_7938],_7756,_7758) --> 
    init(_7773,_7756,_7788),
    negation(_7719,_7797,_7788,_7814),
    not_look_ahead(w(verb(_7725,_7726,pass)),_7826,_7814,_7843),
    !,
    pushstack(free,negation(_7719),nil,_7843,_7903),itstatem(_7698,_7699,_7860,_7903,_7918),
    !,
    accept(_7938,_7918,_7758).

statem(_7698,_7699,[statem,_7782,_7806,_7830,_7854,_7883,!,[],_7936],_7765,_7767) --> 
    redundants0(_7782,_7765,_7797),
    dette(_7806,_7797,_7821),
    aux1(_7830,_7821,_7845),
    not_look_ahead([være],_7854,_7845,_7871),
    obvious_object(_7732,_7733,_7883,_7871,_7902),
    !,
    pushstack(free,[dette],nil,_7902,_7935),[],
    pushstack(first,(xnp(_7732,_7733),aux1),nil,_7935,_8005),
    state(_7698,_7699,_7936,_8005,_7767).

statem(_7698,_7699,[statem,_7752,!,_7781,!,_7820],_7735,_7737) --> 
    init(_7752,_7735,_7767),
    !,
    itstatem(_7698,_7699,_7781,_7767,_7800),
    !,
    accept(_7820,_7800,_7737).

statem(_7698,_7701::_7702,[statem,_7752,!,_7791],_7735,_7737) --> 
    state(_7698,_7701::_7702,_7752,_7735,_7771),
    !,
    accept(_7791,_7771,_7737).

statem(_7698,_7701::_7702,[statem,_7845,_7879,_7908,_7932,_7961,lit(å),{},[],{},_8066,{}],_7828,_7830) --> 
    subject(_7740,_7741,_7845,_7828,_7864),
    be(_7736,_7879,_7864,_7896),
    so0(_7908,_7896,_7923),
    gradverb0(_7745,_7932,_7923,_7949),
    w(adj2(_7749,nil),_7961,_7949,_7978),
    cc(å,_7978,_8000),
    {user:testmember(_7749,[difficult,easy,expensive,free,funny,good,intelligent,sad,stupid,tedious])},
    pushstack(free,xnp(_7740,_7741),nil,_8000,_8055),[],
    {user:it_template(_7787)},
    pushstack(first,(w(adj2(_7749,nil)),[å]),nil,_8055,_8079),be_complements(_7787,_7698,_7701::_7737,_8066,_8079,_7830),
    {user:negate(_7736,_7737,_7702)}.

statem(_7698,_7701::_7702,[statem,_7800,_7834,_7858,{},!,_7902,_7926],_7783,_7785) --> 
    np1_accept(_7733,_7734,_7800,_7783,_7819),
    aux1(_7834,_7819,_7849),
    prepnof(_7736,_7858,_7849,_7875),
    {user:testmember(_7736,[on,to,towards])},
    !,
    accept(_7902,_7875,_7917),
    pushstack(first,(np(_7733,_7734),w(verb(go,pres,fin)),prep(to)),nil,_7917,_8000),
    state(_7698,_7701::_7702,_7926,_8000,_7785).

statem(_7698,_7701::_7702,[statem,_7814,_7843,_7872,_7906,_7930,{},_7969],_7797,_7799) --> 
    not_look_ahead([dette],_7814,_7797,_7831),
    not_look_ahead([det],_7843,_7831,_7860),
    np1_accept(_7741,_7742,_7872,_7860,_7891),
    aux1(_7906,_7891,_7921),
    prepnof(_7731,_7930,_7921,_7947),
    {user:testmember(_7731,[to,from,near,in,on,past])},
    pushstack(first,(np(_7741,_7742),w(verb(go,pres,fin)),prep(_7731)),nil,_7947,_8041),
    state(_7698,_7701::_7702,_7969,_8041,_7799).

statem(_7698,_7701::_7702,[statem,_7816,_7845,_7874,_7908,_7937,_7961,_7990,_8019,_8048],_7799,_7801) --> 
    not_look_ahead([dette],_7816,_7799,_7833),
    not_look_ahead([det],_7845,_7833,_7862),
    np1_accept(_7748,_7749,_7874,_7862,_7893),
    not_look_ahead([kan],_7908,_7893,_7925),
    aux1(_7937,_7925,_7952),
    look_ahead([hjem],_7961,_7952,_7978),
    not_look_ahead([kunne],_7990,_7978,_8007),
    not_look_ahead(w(verb(_7767,_7768,_7769)),_8019,_8007,_8036),
    pushstack(first,(np(_7748,_7749),w(verb(go,pres,fin))),nil,_8036,_8089),
    state(_7698,_7701::_7702,_8048,_8089,_7801).

statem(_7698,_7699,[statem,_7769,_7793,_7817,[],_7865],_7752,_7754) --> 
    dedette(_7769,_7752,_7784),
    aux1(_7793,_7784,_7808),
    np1_accept(_7719,_7720,_7817,_7808,_7836),
    pushstack(free,[dette],nil,_7836,_7864),[],
    pushstack(first,(xnp(_7719,_7720),aux1),nil,_7864,_7934),
    state(_7698,_7699,_7865,_7934,_7754).

dedette([dedette,lit(det)],_7715,_7717) --> 
    cc(det,_7715,_7717).

dedette([dedette,lit(dette)],_7715,_7717) --> 
    cc(dette,_7715,_7717).

soredundant0([soredundant0,_7727,!],_7716,_7718) --> 
    soredundant(_7727,_7716,_7718),
    !.

soredundant([soredundant,lit(når),!],_7718,_7720) --> 
    cc(når,_7718,_7720),
    !.

soredundant([soredundant,_7727,!],_7716,_7718) --> 
    so(_7727,_7716,_7718),
    !.

soredundant([soredundant,_7724],_7713,_7715) --> 
    redundant(_7724,_7713,_7715).

so([so,lit(så),!],_7718,_7720) --> 
    cc(så,_7718,_7720),
    !.

so([so,lit(derfor),!],_7718,_7720) --> 
    cc(derfor,_7718,_7720),
    !.

so([so,_7736],_7725,_7727) --> 
    look_ahead_lit([kan,må,vil,skal,bør],_7736,_7725,_7727).

so([so,_7732],_7721,_7723) --> 
    look_ahead(w(verb(know,_7703,fin)),_7732,_7721,_7723).

statem(_7698,_7701::_7702,[statem,_7790,_7829,lit(kan),_7864,_7888,_7922,_7946],_7773,_7775) --> 
    adverbx(_7731,_7732,pre,_7790,_7773,_7811),
    saa0(_7829,_7811,_7844),
    cc(kan,_7844,_7863),
    redundant0(_7864,_7863,_7879),
    np1_accept(_7740,_7741,_7888,_7879,_7907),
    redundant0(_7922,_7907,_7937),
    pushstack(free,(noun_phrase1(_7740,_7741),[kan],xadverb(_7731,_7732)),nil,_7937,_8022),
    state(_7698,_7701::_7702,_7946,_8022,_7775).

statem(_7698,_7701::_7702,[statem,_7786,_7825,_7849,_7873,_7897,_7931,_7955],_7769,_7771) --> 
    adverbx(_7731,_7732,pre,_7786,_7769,_7807),
    saa0(_7825,_7807,_7840),
    aux1(_7849,_7840,_7864),
    redundant0(_7873,_7864,_7888),
    np1_accept(_7738,_7739,_7897,_7888,_7916),
    redundant0(_7931,_7916,_7946),
    pushstack(free,(noun_phrase1(_7738,_7739),aux1,xadverb(_7731,_7732)),nil,_7946,_8055),
    state(_7698,_7701::_7702,_7955,_8055,_7771).

statem(_7698,_7701::_7702,[statem,_7789,_7828,_7852,lit(jeg),_7887,!,_7916,_7940],_7772,_7774) --> 
    adverbx(_7734,_7735,pre,_7789,_7772,_7810),
    saa0(_7828,_7810,_7843),
    aux1(_7852,_7843,_7867),
    cc(jeg,_7867,_7886),
    redundant0(_7887,_7886,_7902),
    !,
    accept(_7916,_7902,_7931),
    pushstack(free,([jeg],[skal],xadverb(_7734,_7735)),nil,_7931,_7981),
    state(_7698,_7701::_7702,_7940,_7981,_7774).

statem(_7698,_7701::_7702,[statem,lit(at),_7776,_7810,{}],_7748,_7750) --> 
    cc(at,_7748,_7775),
    statem(_7698,_7701::_7716,_7776,_7775,_7795),
    be_truefalse(_7715,_7810,_7795,_7750),
    {user:negate(_7715,_7716,_7702)}.

statem(_7698,_7701::_7702,[statem,_7790,_7829,_7853,_7882,_7911],_7773,_7775) --> 
    adverbx(_7725,_7726,pre,_7790,_7773,_7811),
    saa0(_7829,_7811,_7844),
    w(verb(_7734,_7735,_7736),_7853,_7844,_7870),
    negation0(_7738,_7882,_7870,_7899),
    lock(last,_7899,_7989),
    pushstack(last,(w(verb(_7734,_7735,_7736)),negation(_7738),xadverb(_7725,_7726)),nil,_7989,_7995),
    state(_7698,_7701::_7702,_7911,_7995,_7984),
    unlock(_7984,_7775).

statem(_7698,_7701::_7702,[statem,_7801,_7840,_7869,_7903,!,_7937],_7784,_7786) --> 
    adverbx(_7728,_7729,pre,_7801,_7784,_7822),
    w(verb(be,_7738,fin),_7840,_7822,_7857),
    np1_accept(_7741,_7742,_7869,_7857,_7888),
    w(verb(_7746,_7747,part),_7903,_7888,_7920),
    !,
    lock(last,_7920,_8016),
    pushstack(last,(np(_7741,_7742),w(verb(_7746,_7747,fin)),xadverb(_7728,_7729)),nil,_8016,_8022),
    state(_7698,_7701::_7702,_7937,_8022,_8011),
    unlock(_8011,_7786).

statem(_7698,_7701::_7702,[statem,_7793,_7832,_7856,_7890,!,_7924],_7776,_7778) --> 
    adverbx(_7728,_7729,pre,_7793,_7776,_7814),
    be(_7832,_7814,_7847),
    specific_phrase(_7735,_7738::_7739,_7856,_7847,_7875),
    negation0(_7741,_7890,_7875,_7907),
    !,
    pushstack(free,(np(_7735,_7738::_7739),be(_7741),xadverb(_7728,_7729)),nil,_7907,_8029),
    state(_7698,_7701::_7702,_7924,_8029,_7778).

statem(_7698,_7701::_7702,[statem,_7781,_7820,_7849,!,_7883],_7764,_7766) --> 
    adverbx(_7722,_7723,pre,_7781,_7764,_7802),
    w(verb(be,_7732,fin),_7820,_7802,_7837),
    negation0(_7735,_7849,_7837,_7866),
    !,
    pushstack(free,(be(_7735),xadverb(_7722,_7723)),nil,_7866,_7954),
    state(_7698,_7701::_7702,_7883,_7954,_7766).

statem(_7698,_7701::_7702,[statem,_7765,_7804,_7828,_7852],_7748,_7750) --> 
    adverbx(_7716,_7717,pre,_7765,_7748,_7786),
    saa0(_7804,_7786,_7819),
    do(_7828,_7819,_7843),
    pushstack(free,xadverb(_7716,_7717),nil,_7843,_7893),
    state(_7698,_7701::_7702,_7852,_7893,_7750).

statem(_7698,_7699,[statem,_7786,_7825,_7849,_7883,_7912],_7769,_7771) --> 
    adverbx(_7722,_7723,pre,_7786,_7769,_7807),
    has(_7825,_7807,_7840),
    specific_phrase(_7729,_7730,_7849,_7840,_7868),
    w(verb(_7734,past,part),_7883,_7868,_7900),
    lock(last,_7900,_7991),
    pushstack(last,(xnp(_7729,_7730),w(verb(_7734,past,fin)),xadverb(_7722,_7723)),nil,_7991,_7997),
    state(_7698,_7699,_7912,_7997,_7986),
    unlock(_7986,_7771).

statem(_7698,_7699,[statem,_7772,_7811,_7840],_7755,_7757) --> 
    preadverbial1(_7713,_7714,_7715,_7772,_7755,_7793),
    w(verb(be,pres,fin),_7811,_7793,_7828),
    pushstack(free,(w(verb(be,pres,fin)),adverbial1(_7713,_7714,_7715)),nil,_7828,_7882),
    state(_7698,_7699,_7840,_7882,_7757).

statem(_7698,_7699,[statem,_7752,_7776,!,_7805,_7829],_7735,_7737) --> 
    preadverbials0(_7752,_7735,_7767),
    aux1(_7776,_7767,_7791),
    !,
    accept(_7805,_7791,_7820),
    state(_7698,_7699,_7829,_7820,_7737).

statem(_7698,_7701::_7702,[statem,_7778,_7817,!,_7846],_7761,_7763) --> 
    adverbial1(_7722,_7723,_7726::_7727,_7778,_7761,_7799),
    be(_7817,_7799,_7832),
    !,
    pushstack(free,(thereit,be,adverbial1(_7722,_7723,_7726::_7727)),nil,_7832,_7951),
    statem(_7698,_7701::_7702,_7846,_7951,_7763).

statem(_7698,_7701::_7702,[statem,_7813,_7852,_7876,_7910,!,_7944],_7796,_7798) --> 
    preadverbial1(_7731,_7732,_7735::_7736,_7813,_7796,_7834),
    do(_7852,_7834,_7867),
    specific_phrase(_7745,_7748::_7749,_7876,_7867,_7895),
    w(prep(_7753),_7910,_7895,_7927),
    !,
    pushstack(free,(np(_7745,_7748::_7749),w(verb(go,pres,fin)),w(prep(_7753)),adverbial1(_7731,_7732,_7735::_7736)),nil,_7927,_8023),
    state(_7698,_7701::_7702,_7944,_8023,_7798).

statem(_7698,_7701::_7702,[statem,_7772,_7811,!,_7840],_7755,_7757) --> 
    preadverbial1(_7716,_7717,_7720::_7721,_7772,_7755,_7793),
    do(_7811,_7793,_7826),
    !,
    pushstack(free,adverbial1(_7716,_7717,_7720::_7721),nil,_7826,_7885),
    state(_7698,_7701::_7702,_7840,_7885,_7757).

statem(_7698,_7699,[statem,_7790,_7829,_7853,_7882,!,_7921],_7773,_7775) --> 
    preadverbial1(_7725,_7726,_7727,_7790,_7773,_7811),
    so0(_7829,_7811,_7844),
    w(verb(have,_7736,fin),_7853,_7844,_7870),
    subject(_7739,_7740,_7882,_7870,_7901),
    !,
    pushstack(free,(xnp(_7739,_7740),w(verb(have,_7736,fin)),adverbial1(_7725,_7726,_7727)),nil,_7901,_7994),
    state(_7698,_7699,_7921,_7994,_7775).

statem(_7698,_7701::_7702,[statem,{},_7829,_7868,_7907,!,_7956,_7980],_7802,_7804) --> 
    {user:value(dialog,1)},
    preadverbial1(_7746,_7747,_7750::_7751,_7829,_7802,_7850),
    preadverbial1(_7731,_7732,_7735::_7736,_7868,_7850,_7889),
    lexv(_7760,_7761,_7762,fin,_7907,_7889,_7930),
    !,
    accept(_7956,_7930,_7971),
    lock(last,_7971,_8098),
    pushstack(last,(lexv(_7760,_7761,_7762,fin),adverbial1(_7746,_7747,_7750::_7751),adverbial1(_7731,_7732,_7735::_7736)),nil,_8098,_8104),
    state(_7698,_7701::_7702,_7980,_8104,_8093),
    unlock(_8093,_7804).

prestatem(_7698,_7699,[prestatem,_7792,_7821,lit(det),_7866,!,_7900],_7775,_7777) --> 
    w(verb(_7729,_7730,fin),_7792,_7775,_7809),
    gmem(_7729,[be,stand],_7821,_7809,_7840),
    cc(det,_7840,_7865),
    w(adj2(_7724,_7725),_7866,_7865,_7883),
    !,
    pushstack(first,(w(verb(be,_7730,fin)),w(adj2(_7724,_7725))),nil,_7883,_7910),
    itstatem(_7698,_7699,_7900,_7910,_7777).

prestatem(_7698,_7699,[prestatem,_7819,_7843,_7867,_7896,_7920,_7954,_7978,{},_8017,!,_8056],_7802,_7804) --> 
    so0(_7819,_7802,_7834),
    aux1(_7843,_7834,_7858),
    negation0(_7746,_7867,_7858,_7884),
    redundant0(_7896,_7884,_7911),
    object(_7743,_7744,_7920,_7911,_7939),
    redundant0(_7954,_7939,_7969),
    w(verb(_7753,_7754,pass),_7978,_7969,_7995),
    {user:(\+testmember(_7753,[be]))},
    whodidit(_7766,_7767,_8017,_7995,_8036),
    !,
    pushstack(first,(xnp(_7766,_7767),w(verb(_7753,_7754,fin)),negation(_7746),xnp(_7743,_7744)),nil,_8036,_8158),
    state(_7698,_7699,_8056,_8158,_7804).

prestatem(_7698,_7699,[prestatem,_7779,_7803,_7832,!,_7876],_7762,_7764) --> 
    shoulditbe(_7779,_7762,_7794),
    not_look_ahead(w(adj2(_7727,_7728)),_7803,_7794,_7820),
    adverbix0(_7719,_7720,_7721,_7832,_7820,_7853),
    !,
    pushstack(free,(w(verb(be,pres,fin)),xadverbial1(_7719,_7720,_7721)),nil,_7853,_7918),
    itstatem(_7698,_7699,_7876,_7918,_7764).

prestatem(_7698,_7699,[prestatem,_7760,lit(det),_7800,!,_7829],_7743,_7745) --> 
    w(verb(be,_7719,fin),_7760,_7743,_7777),
    cc(det,_7777,_7799),
    slikat(_7800,_7799,_7815),
    !,
    state(_7698,_7699,_7829,_7815,_7745).

prestatem(_7698,_7699,[prestatem,_7803,_7832,lit(det),_7877,_7901,_7930,!,_7959,_7993],_7786,_7788) --> 
    w(verb(_7739,_7740,fin),_7803,_7786,_7820),
    gmem(_7739,[have,be],_7832,_7820,_7851),
    cc(det,_7851,_7876),
    redundant0(_7877,_7876,_7892),
    w(verb(_7733,past,part),_7901,_7892,_7918),
    look_ahead_np(_7930,_7918,_7945),
    !,
    subject(_7758,_7759,_7959,_7945,_7978),
    pushstack(first,(xnp(_7758,_7759),w(verb(_7733,past,fin))),nil,_7978,_8034),
    state(_7698,_7699,_7993,_8034,_7788).

prestatem(_7698,_7699,[prestatem,_7788,_7812,_7846,_7875,!,_7914],_7771,_7773) --> 
    has(_7788,_7771,_7803),
    subject(_7728,_7729,_7812,_7803,_7831),
    w(verb(_7733,past,part),_7846,_7831,_7863),
    object(_7725,_7726,_7875,_7863,_7894),
    !,
    pushstack(first,(xnp(_7728,_7729),w(verb(_7733,past,fin)),xnp(_7725,_7726)),nil,_7894,_7986),
    state(_7698,_7699,_7914,_7986,_7773).

prestatem(_7698,_7699,[prestatem,_7806,{},_7845,_7879,_7908,!,_7947],_7789,_7791) --> 
    w(verb(_7733,_7734,fin),_7806,_7789,_7823),
    {user:(\+member(_7733,[]))},
    subject(_7744,_7745,_7845,_7823,_7864),
    not_look_ahead(w(verb(_7751,_7752,_7753)),_7879,_7864,_7896),
    object(_7728,_7729,_7908,_7896,_7927),
    !,
    pushstack(first,(xnp(_7744,_7745),w(verb(_7733,past,fin)),xnp(_7728,_7729)),nil,_7927,_8019),
    state(_7698,_7699,_7947,_8019,_7791).

prestatem(_7698,_7699,[prestatem,_7809,_7838,_7867,_7891,lit(det),_7931,_7955,!,_7989],_7792,_7794) --> 
    not_look_ahead(w(verb(be,_7741,_7742)),_7809,_7792,_7826),
    not_look_ahead(w(verb(be1,_7749,_7750)),_7838,_7826,_7855),
    so0(_7867,_7855,_7882),
    w(verb(_7754,_7755,fin),_7891,_7882,_7908),
    cc(det,_7908,_7930),
    not_look_ahead_np(_7931,_7930,_7946),
    negation0(_7734,_7955,_7946,_7972),
    !,
    pushstack(first,([dette],w(verb(_7754,_7755,fin)),negation(_7734)),nil,_7972,_8029),
    state(_7698,_7699,_7989,_8029,_7794).

prestatem(_7698,_7699,[prestatem,_7805,_7834,_7863,_7887,_7916,_7940,_7974,!,_8008],_7788,_7790) --> 
    not_look_ahead(w(verb(be,_7738,_7739)),_7805,_7788,_7822),
    not_look_ahead(w(verb(be1,_7746,_7747)),_7834,_7822,_7851),
    so0(_7863,_7851,_7878),
    w(verb(_7751,_7752,fin),_7887,_7878,_7904),
    det0(_7916,_7904,_7931),
    particlev0(_7751,_7756,_7940,_7931,_7959),
    negation0(_7731,_7974,_7959,_7991),
    !,
    pushstack(free,(w(verb(_7756,_7752,fin)),negation(_7731)),nil,_7991,_8048),
    state(_7698,_7699,_8008,_8048,_7790).

prestatem(_7698,_7699,[prestatem,_7806,_7830,{},_7869,_7893,!,_7927,_7961],_7789,_7791) --> 
    so0(_7806,_7789,_7821),
    w(verb(_7739,_7740,pass),_7830,_7821,_7847),
    {user:(\+testmember(_7739,[be]))},
    thereit0(_7869,_7847,_7884),
    negation0(_7752,_7893,_7884,_7910),
    !,
    object(_7734,_7735,_7927,_7910,_7946),
    pushstack(first,([noen],w(verb(_7739,_7740,fin)),negation(_7752),xnp(_7734,_7735)),nil,_7946,_8032),
    state(_7698,_7699,_7961,_8032,_7791).

prestatem(_7698,_7699,[prestatem,_7783,_7812,!,_7846,_7880],_7766,_7768) --> 
    w(verb(be,_7727,fin),_7783,_7766,_7800),
    negation0(_7722,_7812,_7800,_7829),
    !,
    subject(_7732,_7733,_7846,_7829,_7865),
    pushstack(first,(xnp(_7732,_7733),w(verb(be,_7727,fin)),negation(_7722)),nil,_7865,_7951),
    state(_7698,_7699,_7880,_7951,_7768).

prestatem(_7698,_7699,[prestatem,_7793,lit(kan),_7828,_7862,_7886,_7915,!,_7949],_7776,_7778) --> 
    so0(_7793,_7776,_7808),
    cc(kan,_7808,_7827),
    subject(_7736,_7737,_7828,_7827,_7847),
    redundant0(_7862,_7847,_7877),
    not_look_ahead(w(verb(_7743,_7744,_7745)),_7886,_7877,_7903),
    not_look_ahead([ikke],_7915,_7903,_7932),
    !,
    pushstack(free,(xnp(_7736,_7737),w(verb(do1,pres,fin))),nil,_7932,_7990),
    state(_7698,_7699,_7949,_7990,_7778).

prestatem(_7698,_7699,[prestatem,_7774,_7798,_7822,_7856,!,_7890],_7757,_7759) --> 
    so0(_7774,_7757,_7789),
    aux1(_7798,_7789,_7813),
    subject(_7727,_7728,_7822,_7813,_7841),
    negation0(_7725,_7856,_7841,_7873),
    !,
    pushstack(free,(xnp(_7727,_7728),aux1,negation(_7725)),nil,_7873,_7989),
    state(_7698,_7699,_7890,_7989,_7759).

itstatem(_7698,_7699,[itstatem,_7790,_7814,lit(at),_7859,!,_7898,_7932],_7773,_7775) --> 
    be(_7790,_7773,_7805),
    np0_accept(_7728,_7729,_7814,_7805,_7833),
    cc(at,_7833,_7858),
    traceprint(4,it00,_7859,_7858,_7878),
    !,
    clausal_object1(_7739,_7740,_7898,_7878,_7917),
    pushstack(first,(xnp(_7739,_7740),w(verb(be,pres,fin)),xnp(_7728,_7729)),nil,_7917,_8004),
    state(_7698,_7699,_7932,_8004,_7775).

itstatem(_7698,_7699,[itstatem,_7774,_7798,_7827,_7851,!,_7890],_7757,_7759) --> 
    be(_7774,_7757,_7789),
    not_look_ahead(w(adj2(_7729,_7730)),_7798,_7789,_7815),
    look_ahead_np(_7827,_7815,_7842),
    traceprint(4,it01,_7851,_7842,_7870),
    !,
    pushstack(free,w(verb(exist,pres,fin)),nil,_7870,_7900),
    state(_7698,_7699,_7890,_7900,_7759).

itstatem(_7698,_7699,[itstatem,_7778,{},_7817,_7841,!,_7880],_7761,_7763) --> 
    w(verb(_7721,_7722,fin),_7778,_7761,_7795),
    {user:_7721\==be},
    look_ahead_np(_7817,_7795,_7832),
    traceprint(4,it02,_7841,_7832,_7860),
    !,
    pushstack(free,w(verb(_7721,_7722,fin)),nil,_7860,_7890),
    state(_7698,_7699,_7880,_7890,_7763).

itstatem(_7698,_7699,[itstatem,_7805,_7834,{},_7893,_7927,!,_7966],_7788,_7790) --> 
    negation0(_7730,_7805,_7788,_7822),
    hlexv(_7732,_7733,_7734,fin,_7736,_7834,_7822,_7859),
    {user:bigno(_7730,_7736,_7728)},
    gmem(_7733,[help,give,make,create],_7893,_7859,_7912),
    traceprint(4,it0,_7927,_7912,_7946),
    !,
    pushstack(first,([dette],w(verb(_7733,_7734,fin)),negation(_7728)),nil,_7946,_8006),
    state(_7698,_7699,_7966,_8006,_7790).

itstatem(_7698,_7699,[itstatem,_7789,_7818,_7852,_7886,_7920],_7772,_7774) --> 
    w(verb(_7726,_7727,fin),_7789,_7772,_7806),
    gmem(_7726,[have],_7818,_7806,_7837),
    subject(_7735,_7736,_7852,_7837,_7871),
    traceprint(4,it1,_7886,_7871,_7905),
    pushstack(first,(xnp(_7735,_7736),w(verb(_7726,_7727,fin)),[dette]),nil,_7905,_7961),
    state(_7698,_7699,_7920,_7961,_7774).

itstatem(_7698,_7699,[itstatem,_7785,lit(at),_7845,_7869,!,_7908],_7768,_7770) --> 
    lexvaccept(rv,_7728,_7729,fin,_7725,_7785,_7768,_7810),
    cc(at,_7810,_7844),
    look_ahead_np(_7845,_7844,_7860),
    traceprint(4,it2,_7869,_7860,_7888),
    !,
    pushstack(first,([dette],w(verb(_7728,_7729,fin)),negation(_7725)),nil,_7888,_7948),
    state(_7698,_7699,_7908,_7948,_7770).

itstatem(_7698,_7699,[itstatem,_7825,_7849,_7873,_7902,_7931,_7960,lit(som),_8005,_8034,!,_8073,!,_8182],_7808,_7810) --> 
    be(_7825,_7808,_7840),
    redundant0(_7849,_7840,_7864),
    negation0(_7737,_7873,_7864,_7890),
    not_look_ahead(w(nb(_7743,_7744)),_7902,_7890,_7919),
    not_look_ahead_lit([jeg,du],_7931,_7919,_7948),
    np0_accept(_7752,_7753,_7960,_7948,_7979),
    cc(som,_7979,_8004),
    w(verb(_7759,_7760,fin),_8005,_8004,_8022),
    traceprint(4,it3,_8034,_8022,_8053),
    !,
    pushstack(first,(xnp(_7752,_7753),w(verb(_7759,_7760,fin)),negation(_7737)),nil,_8053,_8147),state(_7698,_7699,_8073,_8147,_8162),
    !,
    accept(_8182,_8162,_7810).

itstatem(_7698,_7699,[itstatem,_7828,_7852,_7886,_7915,_7944,_7973,_8002,!,_8041],_7811,_7813) --> 
    be(_7828,_7811,_7843),
    subject(_7745,_7746,_7852,_7843,_7871),
    negation0(_7748,_7886,_7871,_7903),
    not_look_ahead(noun(_7752,_7753,_7754,_7755),_7915,_7903,_7932),
    w(adj2(_7759,nil),_7944,_7932,_7961),
    w(prep(_7764),_7973,_7961,_7990),
    traceprint(4,it4,_8002,_7990,_8021),
    !,
    pushstack(first,(xnp(_7745,_7746),w(verb(be,pres,fin)),negation(_7748),w(adj2(_7759,nil)),w(prep(_7764)),[dette]),nil,_8021,_8112),
    state(_7698,_7699,_8041,_8112,_7813).

itstatem(_7698,_7699,[itstatem,_7797,_7821,_7855,_7884,_7913,!,_7952],_7780,_7782) --> 
    aux1(_7797,_7780,_7812),
    subject(_7733,_7734,_7821,_7812,_7840),
    negation0(_7736,_7855,_7840,_7872),
    w(verb(_7740,_7741,fin),_7884,_7872,_7901),
    traceprint(4,it5,_7913,_7901,_7932),
    !,
    pushstack(first,(xnp(_7733,_7734),w(verb(_7740,pres,fin)),negation(_7736),[dette]),nil,_7932,_8023),
    state(_7698,_7699,_7952,_8023,_7782).

itstatem(_7698,_7699,[itstatem,_7816,_7845,_7874,lit(å),_7914,!,_7953,_7996],_7799,_7801) --> 
    be(_7739,_7816,_7799,_7833),
    gradverb0(_7741,_7845,_7833,_7862),
    w(adj2(_7736,_7737),_7874,_7862,_7891),
    cc(å,_7891,_7913),
    traceprint(4,it7,_7914,_7913,_7933),
    !,
    pushstack(first,([jeg],[vil]),nil,_7933,_7966),clausal_object1(_7761,_7762,_7953,_7966,_7981),
    pushstack(first,(xnp(_7761,_7762),w(verb(be,pres,fin)),negation(_7739),w(adj2(_7736,_7737))),nil,_7981,_8067),
    state(_7698,_7699,_7996,_8067,_7801).

itstatem(_7698,_7699,[itstatem,_7797,_7826,_7870,_7909,!,_7948],_7780,_7782) --> 
    be(_7733,_7797,_7780,_7814),
    ap(_7728,_7729,_7698,_7731,_7826,_7814,_7849),
    pp(with,_7741,_7742,_7870,_7849,_7891),
    traceprint(4,it8,_7909,_7891,_7928),
    !,
    pushstack(first,(xnp(_7741,_7742),w(verb(be,pres,fin)),negation(_7733),ap(_7728,_7729,_7698,_7731)),nil,_7928,_8052),
    state(_7698,_7699,_7948,_8052,_7782).

itstatem(_7698,_7699,[itstatem,_7806,_7835,_7864,lit(at),_7904,!,_7943,_7977],_7789,_7791) --> 
    be(_7739,_7806,_7789,_7823),
    gradverb0(_7741,_7835,_7823,_7852),
    w(adj2(_7736,_7737),_7864,_7852,_7881),
    cc(at,_7881,_7903),
    traceprint(4,it9,_7904,_7903,_7923),
    !,
    clausal_object1(_7753,_7754,_7943,_7923,_7962),
    pushstack(first,(xnp(_7753,_7754),w(verb(be,pres,fin)),negation(_7739),w(adj2(_7736,_7737))),nil,_7962,_8048),
    state(_7698,_7699,_7977,_8048,_7791).

itstatem(_7698,_7699,[itstatem,_7833,_7862,_7891,_7920,_7949,lit(å),_7994,!,_8033,_8057,_8131],_7816,_7818) --> 
    be(_7748,_7833,_7816,_7850),
    gradverb0(_7750,_7862,_7850,_7879),
    w(adj2(_7745,_7746),_7891,_7879,_7908),
    w(prep(for),_7920,_7908,_7937),
    object(_7761,_7762,_7949,_7937,_7968),
    cc(å,_7968,_7993),
    traceprint(4,it10,_7994,_7993,_8013),
    !,
    accept(_8033,_8013,_8048),
    pushstack(first,(xnp(_7761,_7762),[vil]),nil,_8048,_8101),clausal_object1(_7777,_7778,_8057,_8101,_8116),
    pushstack(first,(xnp(_7777,_7778),w(verb(be,pres,fin)),negation(_7748),w(adj2(_7745,_7746))),nil,_8116,_8202),
    state(_7698,_7699,_8131,_8202,_7818).

itstatem(_7698,_7699,[itstatem,_7823,_7852,_7881,lit(å),_7931,!,_7970,_7994,_8037],_7806,_7808) --> 
    be(_7744,_7823,_7806,_7840),
    w(adj2(_7748,_7749),_7852,_7840,_7869),
    pp(_7740,_7741,_7742,_7881,_7869,_7902),
    cc(å,_7902,_7930),
    traceprint(4,it11,_7931,_7930,_7950),
    !,
    accept(_7970,_7950,_7985),
    pushstack(first,[noen],nil,_7985,_8007),clausal_object1(_7765,_7766,_7994,_8007,_8022),
    pushstack(first,(xnp(_7765,_7766),w(verb(be,pres,fin)),negation(_7744),w(adj2(_7748,_7749)),pp(_7740,_7741,_7742)),nil,_8022,_8140),
    state(_7698,_7699,_8037,_8140,_7808).

itstatem(_7698,_7699,[itstatem,_7835,_7864,lit(å),_7919,_7948,_7977,!,_8016,_8059],_7818,_7820) --> 
    be(_7742,_7835,_7818,_7852),
    adj1(_7737,_7749:_7750,_7739,_7740,_7864,_7852,_7887),
    cc(å,_7887,_7918),
    w(verb(_7756,inf,fin),_7919,_7918,_7936),
    reflexiv0(_7756,_7948,_7936,_7965),
    traceprint(4,it12,_7977,_7965,_7996),
    !,
    pushstack(first,([noen],w(verb(_7756,pres,fin))),nil,_7996,_8029),clausal_object1(_7777,_7778,_8016,_8029,_8044),
    pushstack(first,(xnp(_7777,_7778),w(verb(be,pres,fin)),negation(_7742),adj1(_7737,_7749:_7797,_7739,_7740)),nil,_8044,_8166),
    state(_7698,_7699,_8059,_8166,_7820).

itstatem(_7698,_7699,[itstatem,_7792,_7821,_7865,_7889,!,_7928],_7775,_7777) --> 
    be(_7733,_7792,_7775,_7809),
    adj1(_7728,_7729,_7730,_7731,_7821,_7809,_7844),
    not_look_ahead_np(_7865,_7844,_7880),
    traceprint(4,it13,_7889,_7880,_7908),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_7733),adj1(_7728,_7729,_7730,_7731)),nil,_7908,_7999),
    state(_7698,_7699,_7928,_7999,_7777).

itstatem(_7698,_7701::_7702,[itstatem,_7829,_7853,_7877,_7901,_7930,_7959,_7988,_8017,lit(som),_8062,_8096,!,_8205],_7812,_7814) --> 
    be(_7829,_7812,_7844),
    preadverbials0(_7853,_7844,_7868),
    redundant0(_7877,_7868,_7892),
    negation0(_7740,_7901,_7892,_7918),
    not_look_ahead(w(nb(_7746,_7747)),_7930,_7918,_7947),
    not_look_ahead_lit([jeg,du],_7959,_7947,_7976),
    not_look_ahead([det],_7988,_7976,_8005),
    np1_accept(_7759,_7760,_8017,_8005,_8036),
    cc(som,_8036,_8061),
    traceprint(4,it14a,_8062,_8061,_8081),
    pushstack(first,(xnp(_7759,_7760),w(verb(be,pres,fin)),negation(_7740)),nil,_8081,_8170),state(_7698,_7701::_7702,_8096,_8170,_8185),
    !,
    accept(_8205,_8185,_7814).

itstatem(_7698,_7699,[itstatem,_7779,_7803,_7832,_7856,!,_7895],_7762,_7764) --> 
    be(_7779,_7762,_7794),
    negation0(_7725,_7803,_7794,_7820),
    not_look_ahead_np(_7832,_7820,_7847),
    traceprint(4,it14b,_7856,_7847,_7875),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_7725)),nil,_7875,_7935),
    state(_7698,_7699,_7895,_7935,_7764).

itstatem(_7698,_7699,[itstatem,_7794,_7823,lit(med),_7868,_7902,!,_7941],_7777,_7779) --> 
    w(verb(_7727,_7728,fin),_7794,_7777,_7811),
    gmem(_7727,[help,function],_7823,_7811,_7842),
    cc(med,_7842,_7867),
    np0_accept(_7746,_7747,_7868,_7867,_7887),
    traceprint(4,it15,_7902,_7887,_7921),
    !,
    pushstack(first,(xnp(_7746,_7747),w(verb(_7727,_7728,fin))),nil,_7921,_7982),
    state(_7698,_7699,_7941,_7982,_7779).

itstatem(_7698,_7699,[itstatem,_7816,_7845,_7879,lit(å),_7924,!,_7963,_8006],_7799,_7801) --> 
    w(verb(_7736,_7737,fin),_7816,_7799,_7833),
    gmem(_7736,[cost,take],_7845,_7833,_7864),
    np0_accept(_7731,_7732,_7879,_7864,_7898),
    cc(å,_7898,_7923),
    traceprint(4,it16,_7924,_7923,_7943),
    !,
    pushstack(first,([noen],[vil]),nil,_7943,_7976),clausal_object1(_7763,_7764,_7963,_7976,_7991),
    pushstack(first,(xnp(_7763,_7764),w(verb(_7736,_7737,fin)),xnp(_7731,_7732)),nil,_7991,_8078),
    state(_7698,_7699,_8006,_8078,_7801).

itstatem(_7698,_7701::_7702,[itstatem,_7787,_7816,_7840,_7869,_7893,_7917,_7951,{}],_7770,_7772) --> 
    w(verb(go,pres,fin),_7787,_7770,_7804),
    redundants0(_7816,_7804,_7831),
    negation0(_7727,_7840,_7831,_7857),
    ann0(_7869,_7857,_7884),
    infinitive(_7893,_7884,_7908),
    traceprint(4,it17,_7917,_7908,_7936),
    pushstack(first,someone,nil,_7936,_7992),state(_7698,_7701::_7728,_7951,_7992,_7772),
    {user:negate(_7727,_7728,_7702)}.

itstatem(_7698,_7699,[itstatem,_7809,_7838,{},_7897,_7941,_7965,!,_8004],_7792,_7794) --> 
    negation0(_7739,_7809,_7792,_7826),
    hlexv(_7741,go,_7743,fin,_7745,_7838,_7826,_7863),
    {user:bigno(_7739,_7745,_7751)},
    optional([an],_7897,_7863,_7929),
    not_look_ahead_np(_7941,_7929,_7956),
    traceprint(4,it17b,_7965,_7956,_7984),
    !,
    pushstack(first,([dette],w(verb(be,_7743,fin)),negation(_7751),w(adj2(possible,nil))),nil,_7984,_8044),
    state(_7698,_7699,_8004,_8044,_7794).

itstatem(_7698,_7699,[itstatem,_7818,_7847,{},{},_7916,_7940,_7964,!,_8003,_8037],_7801,_7803) --> 
    negation0(_7739,_7818,_7801,_7835),
    hlexv(_7741,_7742,_7743,fin,_7745,_7847,_7835,_7872),
    {user:bigno(_7739,_7745,_7737)},
    {user:(\+testmember(_7742,[cost,take]))},
    preadverbials0(_7916,_7872,_7931),
    look_ahead_np(_7940,_7931,_7955),
    traceprint(4,it18,_7964,_7955,_7983),
    !,
    subject(_7767,_7768,_8003,_7983,_8022),
    pushstack(first,(xnp(_7767,_7768),w(verb(_7742,_7743,fin)),negation(_7737)),nil,_8022,_8108),
    state(_7698,_7699,_8037,_8108,_7803).

itstatem(_7698,_7699,[itstatem,_7794,lit(å),_7834,!,_7873,_7916],_7777,_7779) --> 
    w(verb(_7724,_7725,fin),_7794,_7777,_7811),
    cc(å,_7811,_7833),
    traceprint(4,it19,_7834,_7833,_7853),
    !,
    pushstack(first,([noen],[vil]),nil,_7853,_7886),clausal_object1(_7747,_7748,_7873,_7886,_7901),
    pushstack(first,(xnp(_7747,_7748),w(verb(_7724,_7725,fin))),nil,_7901,_7957),
    state(_7698,_7699,_7916,_7957,_7779).

itstatem(_7698,_7699,[itstatem,_7801,_7825,_7849,_7878,lit(at),_7918,!,_7957,_7981],_7784,_7786) --> 
    blei(_7801,_7784,_7816),
    redundant0(_7825,_7816,_7840),
    negation0(_7739,_7849,_7840,_7866),
    w(verb(_7743,past,part),_7878,_7866,_7895),
    cc(at,_7895,_7917),
    traceprint(4,it20,_7918,_7917,_7937),
    !,
    accept(_7957,_7937,_7972),
    pushstack(first,([noen],w(verb(_7743,past,fin)),negation(_7739),[at]),nil,_7972,_8021),
    state(_7698,_7699,_7981,_8021,_7786).

itstatem(_7698,_7699,[itstatem,_7821,_7845,_7884,_7908,_7937,_7966,_8000,!,_8039,_8063],_7804,_7806) --> 
    blei(_7821,_7804,_7836),
    preadverbial0(_7743,_7744,_7745,_7845,_7836,_7866),
    redundant0(_7884,_7866,_7899),
    negation0(_7751,_7908,_7899,_7925),
    w(verb(_7755,past,part),_7937,_7925,_7954),
    object(_7759,_7760,_7966,_7954,_7985),
    traceprint(4,it21,_8000,_7985,_8019),
    !,
    accept(_8039,_8019,_8054),
    pushstack(first,(xnp(_7759,_7760),w(verb(be,pres,fin)),negation(_7751),w(verb(_7755,past,part)),adverbial1(_7743,_7744,_7745)),nil,_8054,_8166),
    state(_7698,_7699,_8063,_8166,_7806).

itstatem(_7698,_7699,[itstatem,_7782,_7811,_7840,!,_7879],_7765,_7767) --> 
    w(verb(_7726,_7727,pass),_7782,_7765,_7799),
    negation0(_7722,_7811,_7799,_7828),
    traceprint(4,it23,_7840,_7828,_7859),
    !,
    pushstack(first,([noen],w(verb(_7726,_7727,fin)),negation(_7722)),nil,_7859,_7919),
    state(_7698,_7699,_7879,_7919,_7767).

itstatem(_7698,_7699,[itstatem,_7817,_7846,_7870,{},_7909,_7933,!,_7972],_7800,_7802) --> 
    w(verb(be,_7742,fin),_7817,_7800,_7834),
    redundant0(_7846,_7834,_7861),
    w(adj2(_7736,nil),_7870,_7861,_7887),
    {user:testmember(_7736,[certain,uncertain,good,bad])},
    atom(_7909,_7887,_7924),
    traceprint(4,it24,_7933,_7924,_7952),
    !,
    pushstack(first,state(_7698,_7699)\(xnp(_7766,_7767),w(verb(be,_7742,fin)),w(adj2(_7736,nil))),nil,_7952,_8015),
    clausal_object1(_7766,_7767,_7972,_8015,_7802).

atom([atom,lit(at)],_7715,_7717) --> 
    cc(at,_7715,_7717).

atom([atom,lit(om)],_7715,_7717) --> 
    cc(om,_7715,_7717).

itstatem(_7698,_7699,[itstatem,_7839,_7868,_7892,lit(å),_7932,_7961,_7990,_8014,!,_8053,_8096],_7822,_7824) --> 
    w(verb(be,_7748,fin),_7839,_7822,_7856),
    redundant0(_7868,_7856,_7883),
    w(adj2(_7742,nil),_7892,_7883,_7909),
    cc(å,_7909,_7931),
    w(verb(_7760,inf,fin),_7932,_7931,_7949),
    reflexiv0(_7760,_7961,_7949,_7978),
    not_look_ahead_np(_7990,_7978,_8005),
    traceprint(4,it25,_8014,_8005,_8033),
    !,
    pushstack(first,([noen],w(verb(_7760,pres,fin)),[dette]),nil,_8033,_8066),clausal_object1(_7780,_7781,_8053,_8066,_8081),
    pushstack(first,(xnp(_7780,_7781),w(verb(be,_7748,fin)),w(adj2(_7742,nil))),nil,_8081,_8137),
    state(_7698,_7699,_8096,_8137,_7824).

itstatem(_7698,_7699,[itstatem,_7796,_7825,_7854,_7883,!,_7922],_7779,_7781) --> 
    w(verb(be,_7735,fin),_7796,_7779,_7813),
    negation0(_7738,_7825,_7813,_7842),
    w(prep(_7730),_7854,_7842,_7871),
    traceprint(4,it26,_7883,_7871,_7902),
    !,
    pushstack(first,([dette],w(verb(be,_7735,fin)),negation(_7738),w(prep(_7730))),nil,_7902,_7962),
    state(_7698,_7699,_7922,_7962,_7781).

itstatem(_7698,_7699,[itstatem,_7826,_7855,lit(å),_7895,_7924,!,_7963,!,_8011],_7809,_7811) --> 
    w(verb(be,pres,fin),_7826,_7809,_7843),
    w(adj2(_7736,nil),_7855,_7843,_7872),
    cc(å,_7872,_7894),
    w(verb(_7754,inf,fin),_7895,_7894,_7912),
    traceprint(4,it27,_7924,_7912,_7943),
    !,
    pushstack(first,([jeg],w(verb(_7754,pres,fin))),nil,_7943,_7976),clausal_object1(_7773,_7774,_7963,_7976,_7991),
    !,
    pushstack(first,(xnp(_7773,_7774),w(verb(be,pres,fin)),w(adj2(_7736,nil))),nil,_7991,_8052),
    state(_7698,_7699,_8011,_8052,_7811).

itstatem(_7698,_7699,[itstatem,_7792,{},_7831,_7865,!,_7904],_7775,_7777) --> 
    w(verb(_7729,_7730,fin),_7792,_7775,_7809),
    {user:verbtype(_7729,rv)},
    subject(_7738,_7739,_7831,_7809,_7850),
    traceprint(4,it28,_7865,_7850,_7884),
    !,
    pushstack(first,(xnp(_7738,_7739),w(verb(_7729,pres,fin)),[dette]),nil,_7884,_7945),
    state(_7698,_7699,_7904,_7945,_7777).

itstatem(_7698,_7699,[itstatem,_7833,_7862,_7896,_7920,_7949,{},lit(noe),lit(om),_8010,_8044],_7816,_7818) --> 
    w(verb(have,_7751,fin),_7833,_7816,_7850),
    subject(_7754,_7755,_7862,_7850,_7881),
    redundant0(_7896,_7881,_7911),
    negation0(_7757,_7920,_7911,_7937),
    w(verb(_7761,past,part),_7949,_7937,_7966),
    {user:testmember(_7761,[tell])},
    cc(noe,_7966,_7998),
    cc(om,_7998,_8009),
    traceprint(4,it29,_8010,_8009,_8029),
    pushstack(first,(xnp(_7754,_7755),w(verb(_7761,past,fin)),negation(_7757),[noe],[om],[det]),nil,_8029,_8115),
    state(_7698,_7699,_8044,_8115,_7818).

itstatem(_7698,_7699,[itstatem,_7787,{},_7826,!,_7865],_7770,_7772) --> 
    w(verb(_7721,_7728,fin),_7787,_7770,_7804),
    {user:testmember(_7721,[concern])},
    traceprint(4,it30,_7826,_7804,_7845),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_7721,pres,fin))),nil,_7845,_7875),
    state(_7698,_7699,_7865,_7875,_7772).

itstatem(_7698,_7699,[itstatem,_7814,{},_7853,_7882,_7926,!,_7965],_7797,_7799) --> 
    w(verb(_7734,_7735,fin),_7814,_7797,_7831),
    {user:testmember(_7734,[go,look,see,function])},
    w(adv(_7730),_7853,_7831,_7870),
    optional([ut],_7882,_7870,_7914),
    traceprint(4,it31,_7926,_7914,_7945),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_7734,pres,fin)),w(adv(_7730))),nil,_7945,_7975),
    state(_7698,_7699,_7965,_7975,_7799).

itstatem(_7698,_7701::_7702,[itstatem,_7791,{},_7830,!,_7869],_7774,_7776) --> 
    w(verb(_7723,_7730,fin),_7791,_7774,_7808),
    {user:testmember(_7723,[rain,snow,look,be_urgent])},
    traceprint(4,it32,_7830,_7808,_7849),
    !,
    pushstack(first,(something,lexv(iv,_7723,pres,fin)),nil,_7849,_7943),
    state(_7698,_7701::_7702,_7869,_7943,_7776).

itstatem(_7698,_7701::_7702,[itstatem,_7778,{},_7822,_7856],_7761,_7763) --> 
    pvimodal(_7718,_7723,_7778,_7761,_7797),
    {user:constrainit(_7727,thing)},
    traceprint(4,it32,_7822,_7797,_7841),
    pushstack(first,w(verb(_7718,pres,fin)),nil,_7841,_7866),
    verb_phrase1(_7718,_7727,id,_7698,_7701::_7702,_7856,_7866,_7763).

itstatem(_7698,_7701::_7702,[itstatem,_7788,_7822,_7856,_7890,{}],_7771,_7773) --> 
    beginverb(_7722,_7718,_7788,_7771,_7807),
    np1(_7725,_7726,_7822,_7807,_7841),
    traceprint(4,it33,_7856,_7841,_7875),
    pushstack(first,(np1(_7725,_7726),w(verb(_7722,pres,fin))),nil,_7875,_7936),state(_7698,_7701::_7719,_7890,_7936,_7773),
    {user:negate(_7718,_7719,_7702)}.

itstatem(_7698,_7701::_7702,[itstatem,_7778,_7802,_7841,_7865,_7899],_7761,_7763) --> 
    be(_7778,_7761,_7793),
    adverbial(_7719,_7720,_7723::_7724,_7802,_7793,_7823),
    that(_7841,_7823,_7856),
    traceprint(4,it34,_7865,_7856,_7884),
    lock(last,_7884,_7949),
    pushstack(last,adverbial(_7719,_7720,_7723::_7724),nil,_7949,_7955),
    state(_7698,_7701::_7702,_7899,_7955,_7944),
    unlock(_7944,_7763).

itstatem(_7698,_7701::_7702,[itstatem,_7797,_7821,_7850,_7874,_7903,_7932,_7961,!,_8000,_8024],_7780,_7782) --> 
    be(_7797,_7780,_7812),
    negation0(_7737,_7821,_7812,_7838),
    saa0(_7850,_7838,_7865),
    not_look_ahead(w(verb(_7743,past,part)),_7874,_7865,_7891),
    w(adj2(_7749,nil),_7903,_7891,_7920),
    one_of_lit([at,om],_7932,_7920,_7949),
    traceprint(4,it35,_7961,_7949,_7980),
    !,
    accept(_8000,_7980,_8015),
    statem(_7698,_7701::_7702,_8024,_8015,_7782).

itstatem(_7698,_7701::_7702,[itstatem,_7793,_7817,_7846,_7870,{},_7909,_7938,_7972],_7776,_7778) --> 
    be(_7793,_7776,_7808),
    negation0(_7731,_7817,_7808,_7834),
    saa0(_7846,_7834,_7861),
    w(adj2(_7735,nil),_7870,_7861,_7887),
    {user:testmember(_7735,[good])},
    not_look_ahead(w(noun(_7749,_7750,_7751,_7752)),_7909,_7887,_7926),
    traceprint(4,it36,_7938,_7926,_7957),
    statem(_7698,_7701::_7702,_7972,_7957,_7778).

itstatem(_7698,_7701::_7702,[itstatem,_7840,{},_7879,_7903,_7932,{},_7971,_8005,{}],_7823,_7825) --> 
    be(_7730,_7840,_7823,_7857),
    {user:it_template(_7738)},
    so0(_7879,_7857,_7894),
    gradverb0(_7740,_7903,_7894,_7920),
    w(adj2(_7744,nil),_7932,_7920,_7949),
    {user:testmember(_7744,[difficult,easy,expensive,free,funny,good,intelligent,mild,hot,cold,wet,dark,bright,cloudy,sad,stupid,tedious])},
    traceprint(4,it37,_7971,_7949,_7990),
    pushstack(first,w(adj2(_7744,nil)),nil,_7990,_8018),be_complements(_7738,_7698,_7701::_7731,_8005,_8018,_7825),
    {user:negate(_7730,_7731,_7702)}.

itstatem(_7698,_7701::_7702,[itstatem,_7804,{},_7858,_7887,_7926,!,_7965],_7787,_7789) --> 
    lexv(iv,_7735,_7736,fin,_7804,_7787,_7827),
    {user:(\+testmember(_7735,be))},
    negation0(_7746,_7858,_7827,_7875),
    adverb(_7731,_7732,_7750,_7887,_7875,_7908),
    traceprint(4,it38,_7926,_7908,_7945),
    !,
    pushstack(free,(lexv(iv,_7735,_7736,fin),negation(_7746),xadverb(_7731,_7732)),nil,_7945,_8067),
    state(_7698,_7701::_7702,_7965,_8067,_7789).

itstatem(_7698,_7699,[itstatem,_7783,_7812,_7846,!,_7885,!],_7766,_7768) --> 
    be(_7716,_7783,_7766,_7800),
    subject(_7718,_7719,_7812,_7800,_7831),
    traceprint(4,it39,_7846,_7831,_7865),
    !,
    pushstack(first,(xnp(_7718,_7719),w(verb(exist,pres,fin)),negation(_7716)),nil,_7865,_7959),state(_7698,_7699,_7885,_7959,_7768),
    !.

statreal(_7698,[statreal,_7734],_7720,_7722) --> 
    stat(real,_7698,_7734,_7720,_7722).

stat(_7698,_7699,[stat,_7754,_7788],_7737,_7739) --> 
    state(_7705,_7712::_7713,_7754,_7737,_7773),
    worldcomp(_7698,_7705,_7712::_7713,_7699,_7788,_7773,_7739).

statreal1(_7698,[statreal1,_7742,_7776],_7728,_7730) --> 
    state1(_7704,_7705,_7742,_7728,_7761),
    worldcomp(real,_7704,_7705,_7698,_7776,_7761,_7730).

state1(_7698,_7701::_7702,[state1,_7789,_7823,_7852,!,_7881,{},{},!],_7772,_7774) --> 
    np(_7725,_7728::_7702,_7789,_7772,_7808),
    negation0(_7731,_7823,_7808,_7840),
    redundant0(_7852,_7840,_7867),
    !,
    vp(_7725,_7734,_7698,_7701::_7739,_7881,_7867,_7774),
    {user:bigno(_7731,_7734,_7745)},
    {user:negate(_7745,_7739,_7728)},
    !.

substate(_7698,_7701::_7702,[substate,_7786,_7820,_7844,!,_7878,{},{}],_7769,_7771) --> 
    subject(_7728,_7726::_7702,_7786,_7769,_7805),
    preadverbials0(_7820,_7805,_7835),
    negation0(_7734,_7844,_7835,_7861),
    !,
    vp(_7728,_7737,_7698,_7701::_7725,_7878,_7861,_7771),
    {user:bigno(_7734,_7737,_7724)},
    {user:negate(_7724,_7725,_7726)}.

state(_7698,_7701::_7702,[state,_7783,_7817,_7841,_7870,{},{}],_7766,_7768) --> 
    subject(_7725,_7723::_7702,_7783,_7766,_7802),
    redundant0(_7817,_7802,_7832),
    negation0(_7731,_7841,_7832,_7858),
    vp(_7725,_7734,_7698,_7701::_7722,_7870,_7858,_7768),
    {user:bigno(_7731,_7734,_7721)},
    {user:negate(_7721,_7722,_7723)}.

beginverb(_7698,_7699,[beginverb,_7760,_7789,_7818,_7842],_7743,_7745) --> 
    w(verb(start,_7719,fin),_7760,_7743,_7777),
    negation0(_7699,_7789,_7777,_7806),
    infinitiveand(_7818,_7806,_7833),
    w(verb(_7698,_7713,fin),_7842,_7833,_7745).

question(_7698,[question,_7773,_7802,!,_7831],_7759,_7761) --> 
    w(noun(clock,sin,_7729,n),_7773,_7759,_7790),
    terminator(_7802,_7790,_7817),
    !,
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(clock,sin,def,n))),nil,_7817,_7841),
    whatq(_7698,_7831,_7841,_7761).

question(_7698,[question,_7733],_7719,_7721) --> 
    whichq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    whoq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    whenq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    howadjq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    whereq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    wherefromq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    whatq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    howmuchq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    whyq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    howq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    ppq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7733],_7719,_7721) --> 
    whoseq(_7698,_7733,_7719,_7721).

question(_7698,[question,_7782,_7806,!,_7840,_7874,!,_7903],_7768,_7770) --> 
    be(_7782,_7768,_7797),
    w(noun(clock,_7740,_7741,_7742),_7806,_7797,_7823),
    !,
    np1(_7744,_7745,_7840,_7823,_7859),
    danow0(_7874,_7859,_7889),
    !,
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_7889,_7972),
    whatq(_7698,_7903,_7972,_7770).

question(_7698,[question,_7733],_7719,_7721) --> 
    question1(_7698,_7733,_7719,_7721).

question1(test:::_7701,[question1,lit(får),_7772,!,_7811],_7747,_7749) --> 
    cc(får,_7747,_7771),
    specific_phrase(_7722,_7723,_7772,_7771,_7791),
    !,
    pushstack(first,(np(_7722,_7723),[får]),nil,_7791,_7852),
    statement(_7701,_7811,_7852,_7749).

question1(new:::_7701,[question1,_7790,_7819,{},_7858,!,_7892],_7776,_7778) --> 
    w(verb(have,pres,fin),_7790,_7776,_7807),
    w(verb(_7726,past,part),_7819,_7807,_7836),
    {user:testmember(_7726,[want,think])},
    not_look_ahead([du],_7858,_7836,_7875),
    !,
    pushstack(first,([jeg],w(verb(_7726,pres,fin))),nil,_7875,_7902),
    statement(_7701,_7892,_7902,_7778).

question1(new:::_7701,[question1,_7789,{},_7828,_7862,!,_7896],_7775,_7777) --> 
    w(verb(_7732,pres,fin),_7789,_7775,_7806),
    {user:testmember(_7732,[want,think,hope])},
    particlev0(_7732,_7726,_7828,_7806,_7847),
    not_look_ahead([du],_7862,_7847,_7879),
    !,
    pushstack(first,([jeg],w(verb(_7726,pres,fin))),nil,_7879,_7906),
    statement(_7701,_7896,_7906,_7777).

question1(test:::_7701,[question1,_7736],_7722,_7724) --> 
    question0(_7701,_7736,_7722,_7724).

np_question(which(_7703):::_7701,[np_question,_7742],_7728,_7730) --> 
    np1(_7703,true::_7701,_7742,_7728,_7730).

question0(_7698,[question0,_7733],_7719,_7721) --> 
    isq(_7698,_7733,_7719,_7721).

question0(_7698,[question0,_7733],_7719,_7721) --> 
    ynqs(_7698,_7733,_7719,_7721).

question0(_7698,[question0,_7733],_7719,_7721) --> 
    hasq(_7698,_7733,_7719,_7721).

question0(_7698,[question0,_7736,_7760],_7722,_7724) --> 
    hoq(_7736,_7722,_7751),
    statement(_7698,_7760,_7751,_7724).

implicitq(new:::_7701,[implicitq,_7855,{},_7894,{},{},lit(som),_7954,_7978,_8021,!,_8060,_8084,!,_8138],_7841,_7843) --> 
    w(prep(_7744),_7855,_7841,_7872),
    {user:testmember(_7744,[from,to])},
    w(name(_7757,n,_7759),_7894,_7872,_7911),
    {user:testmember(_7759,[station,neighbourhood])},
    {user:no_unprotected_verb},
    cc(som,_7911,_7953),
    look_ahead_vp(_7954,_7953,_7969),
    pushstack(first,(w(noun(bus,sin,u,n)),w(prep(_7744)),w(name(_7757,n,_7759))),nil,_7969,_7991),np1_accept(_7789,_7792::_7701,_7978,_7991,_8006),
    traceprint(4,iq00,_8021,_8006,_8040),
    !,
    accept(_8060,_8040,_8075),
    verb_phrase1(_7809,_7789,id,_7812,event/real/_7812::_7792,_8084,_8075,_8109),
    !,
    accept(_8138,_8109,_7843).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,_7843,lit(når),{},_7893,_7922,_7966,{},_8005,!,{},_8054,_8093],_7829,_7831) --> 
    not_look_ahead([nr],_7843,_7829,_7860),
    cc(når,_7860,_7882),
    {user:(\+user:value(dialog,1))},
    w(verb(go,_7769,fin),_7893,_7882,_7910),
    optional([neste],_7922,_7910,_7954),
    w(name(_7746,n,_7748),_7966,_7954,_7983),
    {user:testmember(_7748,[station,neighbourhood])},
    traceprint(4,iq01,_8005,_7983,_8024),
    !,
    {user:setvartype(_7796,vehicle)},
    realcomp(_7706,_7800,_7704,_8054,_8024,_8075),
    pushstack(first,w(name(_7746,n,_7748)),nil,_8075,_8103),
    verb_modifiers(go,_7796,_7706,_7703::true,_7800,_8093,_8103,_7831).

implicitq(_7698,[implicitq,_7801,lit(når),{},{},_7861,{},!,_7905,_7929,_7963],_7787,_7789) --> 
    not_look_ahead([nr],_7801,_7787,_7818),
    cc(når,_7818,_7840),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    look_ahead(w(name(_7756,_7757,_7758)),_7861,_7840,_7878),
    {user:subclass0(_7758,place)},
    !,
    accept(_7905,_7878,_7920),
    traceprint(4,iq2,_7929,_7920,_7948),
    pushstack(first,w(prep(to)),nil,_7948,_7973),
    implicitq(_7698,_7963,_7973,_7789).

implicitq(test:::_7701,[implicitq,{},_7802,lit(når),lit(nr),{},!,_7868,_7892,_7926],_7778,_7780) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead([nr],_7802,_7778,_7819),
    cc(når,_7819,_7841),
    cc(nr,_7841,_7852),
    {user:no_unprotected_verb},
    !,
    accept(_7868,_7852,_7883),
    traceprint(4,iq3,_7892,_7883,_7911),
    pushstack(first,w(verb(go,pres,fin)),nil,_7911,_7936),
    ynq(_7701,_7926,_7936,_7780).

implicitq(test:::_7701,[implicitq,_7794,lit(når),{},{},_7854,!,_7903,_7927,_7961],_7780,_7782) --> 
    not_look_ahead([nr],_7794,_7780,_7811),
    cc(når,_7811,_7833),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    optional([det],_7854,_7833,_7886),
    !,
    accept(_7903,_7886,_7918),
    traceprint(4,iq4,_7927,_7918,_7946),
    pushstack(first,w(verb(go,pres,fin)),nil,_7946,_7971),
    ynq(_7701,_7961,_7971,_7782).

implicitq(_7698,[implicitq,_7737,!,_7766],_7723,_7725) --> 
    reject_implicitq(_7737,_7723,_7752),
    !,
    reject(_7766,_7752,_7725).

implicitq(new:::_7701,[implicitq,_7860,{},{},_7909,{},{},_7963,_7992,_8021,_8050,!,_8079,_8103,_8137,_8195,_8239,!,_8268],_7846,_7848) --> 
    look_ahead(w(noun(_7758,sin,u,n)),_7860,_7846,_7877),
    {user:subclass0(_7758,vehicle)},
    {user:no_unprotected_verb},
    np1_accept(_7770,_7773::_7701,_7909,_7877,_7928),
    {user:(\+vartypeid(_7770,time))},
    {user:(\+vartypeid(_7770,clock))},
    constrainvehdep(_7770,_7963,_7928,_7980),
    not_look_ahead([som],_7992,_7980,_8009),
    not_look_ahead([om],_8021,_8009,_8038),
    point0(_8050,_8038,_8065),
    !,
    accept(_8079,_8065,_8094),
    traceprint(4,iq4b,_8103,_8094,_8122),
    pushstack(first,w(verb(go,pres,fin)),nil,_8122,_8150),verb_phrase1(go,_7770,id,_7815,event/real/_7815::_7773,_8137,_8150,_8171),
    optional(itrailer,_8195,_8171,_8227),
    endofline(_8239,_8227,_8254),
    !,
    accept(_8268,_8254,_7848).

implicitq(which(_7703):::_7701,[implicitq,{},_7833,_7862,_7891,_7930,!,_7959,_7993,!,_8087],_7809,_7811) --> 
    {user:value(teleflag,true)},
    w(noun(_7742,_7743,_7744,n),_7833,_7809,_7850),
    not_look_ahead(w(prep(_7751)),_7862,_7850,_7879),
    person_name(_7757:person,_7754,_7755,_7891,_7879,_7912),
    endofline(_7930,_7912,_7945),
    !,
    traceprint(4,iq5,_7959,_7945,_7978),
    lock(exact,_7978,_8046),pushstack(exact,(w(noun(_7742,sin,u,n)),w(prep(to)),nameq1(_7757:person,_7754)),nil,_8046,_8052),no_phrases(_7703,_7701,_7993,_8052,_8041),unlock(_8041,_8042),
    !,
    accept(_8087,_8042,_7811).

implicitq(which(_7703):::_7701,[implicitq,{},_7775,_7809,_7833,!,_7872],_7751,_7753) --> 
    {user:value(teleflag,true)},
    no_phrases(_7703,_7701,_7775,_7751,_7794),
    endofline(_7809,_7794,_7824),
    traceprint(4,iq7,_7833,_7824,_7852),
    !,
    accept(_7872,_7852,_7753).

implicitq(new:::_7701,[implicitq,{},_7854,{},_7893,_7922,_7951,_7994,!,_8033,_8057,_8115,!,_8144],_7830,_7832) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead(w(prep(_7753)),_7854,_7830,_7871),
    {user:no_unprotected_verb},
    w(noun(time,_7760,_7761,_7762),_7893,_7871,_7910),
    look_ahead(w(prep(_7768)),_7922,_7910,_7939),
    pushstack(first,w(noun(departure,sin,u,_7762)),nil,_7939,_7964),np0(_7780,_7783::_7701,_7951,_7964,_7979),
    traceprint(4,iq8,_7994,_7979,_8013),
    !,
    accept(_8033,_8013,_8048),
    pushstack(first,w(verb(go,pres,fin)),nil,_8048,_8070),verb_phrase1(_7798,_7780,id,_7801,event/real/_7801::_7783,_8057,_8070,_8091),
    endofline(_8115,_8091,_8130),
    !,
    accept(_8144,_8130,_7832).

implicitq(new:::_7701,[implicitq,_7859,_7888,{},_7927,{},{},_7981,_8010,_8039,_8068,!,_8097,_8121,_8155,_8213,_8257,!,_8286],_7845,_7847) --> 
    not_look_ahead(w(nb(_7758,num)),_7859,_7845,_7876),
    not_look_ahead(w(prep(_7765)),_7888,_7876,_7905),
    {user:no_unprotected_verb},
    np1_accept(_7769,_7772::_7701,_7927,_7905,_7946),
    {user:(\+vartypeid(_7769,time))},
    {user:(\+vartypeid(_7769,clock))},
    constrainvehdep(_7769,_7981,_7946,_7998),
    not_look_ahead([som],_8010,_7998,_8027),
    not_look_ahead([om],_8039,_8027,_8056),
    point0(_8068,_8056,_8083),
    !,
    accept(_8097,_8083,_8112),
    traceprint(4,iq9,_8121,_8112,_8140),
    pushstack(first,w(verb(go,pres,fin)),nil,_8140,_8168),verb_phrase1(_7811,_7769,id,_7814,event/real/_7814::_7772,_8155,_8168,_8189),
    optional(itrailer,_8213,_8189,_8245),
    endofline(_8257,_8245,_8272),
    !,
    accept(_8286,_8272,_7847).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,{},_7840,_7869,_7898,{},_7932,_7956,{},_7990,_8029,_8053,_8144,!,_8183,_8207],_7816,_7818) --> 
    {user:value(dialog,1)},
    not_look_ahead([nå],_7840,_7816,_7857),
    time1(_7762,_7869,_7857,_7886),
    endofline(_7898,_7886,_7913),
    {user:no_unprotected_verb},
    no_harmful_adj(_7932,_7913,_7947),
    no_harmful_noun(_7956,_7947,_7971),
    {user:setvartype(_7768,vehicle)},
    realcomp(_7706,_7772,_7704,_7990,_7971,_8011),
    deter0(_8029,_8011,_8044),
    pushstack(first,obviousclock1(_7762:clock,_7762 isa clock),nil,_8044,_8099),verb_modifiers(go,_7768,_7706,_7703::true,_7772,_8053,_8099,_8120),
    traceprint(4,iq10,_8144,_8120,_8163),
    !,
    accept(_8183,_8163,_8198),
    qtrailer0(_8207,_8198,_7818).

implicitq(new:::_7701,[implicitq,{},_7862,_7891,{},_7925,{},{},_7979,_8008,_8037,!,_8071,_8095,_8129,_8187,!,_8216],_7838,_7840) --> 
    {user:value(dialog,1)},
    not_look_ahead(w(prep(_7760)),_7862,_7838,_7879),
    not_look_ahead_flnp(_7891,_7879,_7906),
    {user:no_unprotected_verb},
    np0(_7764,_7767::_7701,_7925,_7906,_7944),
    {user:(\+vartypeid(_7764,time))},
    {user:(\+vartypeid(_7764,clock))},
    constrainvehdep(_7764,_7979,_7944,_7996),
    not_look_ahead([om],_8008,_7996,_8025),
    not_look_ahead([som],_8037,_8025,_8054),
    !,
    accept(_8071,_8054,_8086),
    traceprint(4,iq11,_8095,_8086,_8114),
    pushstack(first,w(verb(go,pres,fin)),nil,_8114,_8142),verb_phrase1(_7806,_7764,id,_7809,event/real/_7809::_7767,_8129,_8142,_8163),
    endofline(_8187,_8163,_8202),
    !,
    accept(_8216,_8202,_7840).

implicitq(_7698,[implicitq,_7801,_7825,_7854,_7883,!,_7917,_7941,_7975],_7787,_7789) --> 
    the0(_7801,_7787,_7816),
    w(nb(_7739,num),_7825,_7816,_7842),
    flnp(_7742,_7854,_7842,_7871),
    w(prep(_7735),_7883,_7871,_7900),
    !,
    accept(_7917,_7900,_7932),
    traceprint(4,iq12,_7941,_7932,_7960),
    pushstack(first,(w(nb(_7739,num)),w(adj2(_7742,nil)),w(noun(route,plu,u,n)),w(prep(_7735))),nil,_7960,_7985),
    implicitq(_7698,_7975,_7985,_7789).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,_7818,_7847,_7876,!,_7910,_7934,_7968,_8007,!,_8070],_7804,_7806) --> 
    flnp(_7735,_7818,_7804,_7835),
    not_look_ahead([p],_7847,_7835,_7864),
    therightprep(_7741,_7876,_7864,_7893),
    !,
    accept(_7910,_7893,_7925),
    traceprint(4,iq13,_7934,_7925,_7953),
    realcomp(_7706,_7747,_7704,_7968,_7953,_7989),
    pushstack(first,w(prep(_7741)),nil,_7989,_8020),verb_modifiers(go,_7763:vehicle,_7706,_7703::_7763 isa vehicle and adj/nil/_7735/_7763/_7706,_7747,_8007,_8020,_8041),
    !,
    accept(_8070,_8041,_7806).

implicitq(_7698,[implicitq,{},_7823,_7852,{},_7891,{},!,_7935,_7959,_7993],_7799,_7801) --> 
    {user:(\+value(dialog,1))},
    w(noun(_7735,_7736,_7737,_7738),_7823,_7799,_7840),
    not_look_ahead(w(name(_7758,_7759,_7760)),_7852,_7840,_7869),
    {user:testmember(_7735,[station])},
    look_ahead(w(prep(_7773)),_7891,_7869,_7908),
    {user:no_unprotected_verb},
    !,
    accept(_7935,_7908,_7950),
    traceprint(4,iq14,_7959,_7950,_7978),
    pushstack(first,(whatbe,w(noun(_7735,_7736,_7737,_7738))),nil,_7978,_8036),
    whatq(_7698,_7993,_8036,_7801).

implicitq(_7698,[implicitq,{},_7811,_7840,{},{},!,_7894,_7918,_7952],_7787,_7789) --> 
    {user:(\+value(dialog,1))},
    w(adj2(nearest,nil),_7811,_7787,_7828),
    look_ahead(w(noun(_7751,_7752,_7753,_7754)),_7840,_7828,_7857),
    {user:testmember(_7751,[station])},
    {user:no_unprotected_verb},
    !,
    accept(_7894,_7857,_7909),
    traceprint(4,iq14b,_7918,_7909,_7937),
    pushstack(first,(whatbe,w(adj2(nearest,nil))),nil,_7937,_7990),
    whatq(_7698,_7952,_7990,_7789).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,lit(nå),{},{},{},_7876,_7905,_7934,{},_7968,_8007,_8065,!,_8104],_7821,_7823) --> 
    cc(nå,_7821,_7845),
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(adj2(_7766,nil)),_7876,_7845,_7893),
    not_look_ahead(w(noun(_7773,_7774,_7775,_7776)),_7905,_7893,_7922),
    not_fnlp(_7934,_7922,_7949),
    {user:setvartype(_7780,vehicle)},
    realcomp(_7706,_7784,_7704,_7968,_7949,_7989),
    pushstack(free,[nå],nil,_7989,_8020),verb_modifiers(go,_7780,_7706,_7703::true,_7784,_8007,_8020,_8041),
    traceprint(4,iq15,_8065,_8041,_8084),
    !,
    accept(_8104,_8084,_7823).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,{},{},{},_7865,_7894,{},_7938,_7977,_8001,!,_8095,_8119,_8153],_7821,_7823) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_7764,_7765)),_7865,_7821,_7882),
    obviousclock1(_7767,_7768,_7894,_7882,_7913),
    {user:setvartype(_7772,vehicle)},
    realcomp(_7706,_7776,_7704,_7938,_7913,_7959),
    deter0(_7977,_7959,_7992),
    pushstack(first,(w(prep(after)),obviousclock1(_7767,_7768)),nil,_7992,_8045),verb_modifiers(go,_7772,_7706,_7703::true,_7776,_8001,_8045,_8066),
    !,
    accept(_8095,_8066,_8110),
    traceprint(4,iq17,_8119,_8110,_8138),
    qtrailer0(_8153,_8138,_7823).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,{},{},_7837,_7876,{},_7910,_7939,_7968,_8007,_8056,!,_8095],_7803,_7805) --> 
    {user:(\+value(dialog,1))},
    {user:no_unprotected_verb},
    namep(_7750,_7751,_7752,_7837,_7803,_7858),
    no_harmful_adj(_7876,_7858,_7891),
    {user:constrain(_7751,vehicle)},
    not_look_ahead([om],_7910,_7891,_7927),
    not_look_ahead(w(nb(_7767,_7768)),_7939,_7927,_7956),
    realcomp(_7706,_7771,_7704,_7968,_7956,_7989),
    verb_modifiers(go,_7751,_7706,_7703::_7752,_7771,_8007,_7989,_8032),
    traceprint(4,iq18,_8056,_8032,_8075),
    !,
    accept(_8095,_8075,_7805).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,_7823,_7852,{},{},_7901,_7940,_7998,!,_8037],_7809,_7811) --> 
    not_look_ahead(w(name(_7736,_7737,_7738)),_7823,_7809,_7840),
    w(noun(_7742,sin,u,n),_7852,_7840,_7869),
    {user:test(_7742 ako day)},
    {user:setvartype(_7756,vehicle)},
    realcomp(_7706,_7760,_7704,_7901,_7869,_7922),
    pushstack(first,(w(prep(on)),w(noun(_7742,sin,u,n))),nil,_7922,_7953),verb_modifiers(go,_7756,_7706,_7703::true,_7760,_7940,_7953,_7974),
    traceprint(4,iq19,_7998,_7974,_8017),
    !,
    accept(_8037,_8017,_7811).

implicitq(new:::_7701,[implicitq,{},_7885,_7914,{},{},{},{},{},_7998,_8027,_8056,!,_8090,_8114,_8148,_8206,!,_8235],_7861,_7863) --> 
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_7760,_7761)),_7885,_7861,_7902),
    np1_accept(_7763,_7766::_7701,_7914,_7902,_7933),
    {user:(\+vartypeid(_7763,thing))},
    {user:(\+vartypeid(_7763,time))},
    {user:(\+vartypeid(_7763,clock))},
    {user:(\+vartypeid(_7763,arrival))},
    {user:(\+vartypeid(_7763,departure))},
    not_look_ahead([om],_7998,_7933,_8015),
    not_look_ahead(w(nb(_7812,_7813)),_8027,_8015,_8044),
    constrainvehdep(_7763,_8056,_8044,_8073),
    !,
    accept(_8090,_8073,_8105),
    traceprint(4,iq20,_8114,_8105,_8133),
    pushstack(first,w(verb(go,pres,fin)),nil,_8133,_8161),verb_phrase1(_7829,_7763,id,_7832,event/real/_7832::_7766,_8148,_8161,_8182),
    endofline(_8206,_8182,_8221),
    !,
    accept(_8235,_8221,_7863).

implicitq(new:::_7701,[implicitq,lit(når),_7817,!,_7861,_7885,!,_7919,_7953,_8028],_7792,_7794) --> 
    cc(når,_7792,_7816),
    np_kernel(_7738,_7739,_7740,_7817,_7816,_7838),
    !,
    accept(_7861,_7838,_7876),
    constrainvehdep(_7739,_7885,_7876,_7902),
    !,
    traceprint(4,iq21,_7919,_7902,_7938),
    pushstack(first,np_kernel(0,_7739,_7740),nil,_7938,_7998),np1(_7739,_7757::_7701,_7953,_7998,_8013),
    pushstack(first,w(verb(go,pres,fin)),nil,_8013,_8038),
    verb_phrase1(_7760,_7739,id,_7763,event/real/_7763::_7757,_8028,_8038,_7794).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,_7834,_7858,_7887,_7916,_7945,!,_7979,_8003,_8037,_8076,!,_8130],_7820,_7822) --> 
    athe0(_7834,_7820,_7849),
    flnp(_7741,_7858,_7849,_7875),
    not_look_ahead(w(nb(_7747,_7748)),_7887,_7875,_7904),
    not_look_ahead(w(name(_7754,_7755,route)),_7916,_7904,_7933),
    look_ahead(w(name(_7762,_7763,_7764)),_7945,_7933,_7962),
    !,
    accept(_7979,_7962,_7994),
    traceprint(4,iq22,_8003,_7994,_8022),
    realcomp(_7706,_7770,_7704,_8037,_8022,_8058),
    verb_modifiers(go,_7779:vehicle,_7706,_7703::_7779 isa vehicle and adj/nil/_7741/_7779/_7706,_7770,_8076,_8058,_8101),
    !,
    accept(_8130,_8101,_7822).

implicitq(_7698,[implicitq,{},_7858,_7887,_7916,_7945,_7974,_8003,{},_8042,!,_8081,_8105,_8139],_7834,_7836) --> 
    {user:(\+value(dialog,1))},
    not_look_ahead(w(noun(clock,_7757,_7758,_7759)),_7858,_7834,_7875),
    not_look_ahead(w(noun(thing,_7766,_7767,_7768)),_7887,_7875,_7904),
    not_look_ahead(w(noun(answer,_7775,_7776,_7777)),_7916,_7904,_7933),
    not_look_ahead([det],_7945,_7933,_7962),
    not_look_ahead(w(name(_7787,n,_7789)),_7974,_7962,_7991),
    look_ahead(w(noun(_7795,_7796,_7797,n)),_8003,_7991,_8020),
    {user:testmember(_7795,[ticket,price])},
    np1_accept(_7742,_7743,_8042,_8020,_8061),
    !,
    accept(_8081,_8061,_8096),
    traceprint(4,iq23,_8105,_8096,_8124),
    pushstack(first,(whatbe,xnp(_7742,_7743)),nil,_8124,_8208),
    whatq(_7698,_8139,_8208,_7836).

implicitq(_7698,[implicitq,{},_7810,{},_7849,!,_7883,_7907,_7941],_7786,_7788) --> 
    {user:(\+value(dialog,1))},
    w(noun(_7729,_7744,_7745,_7746),_7810,_7786,_7827),
    {user:testmember(_7729,[clock,date])},
    not_look_ahead(w(nb(_7761,_7762)),_7849,_7827,_7866),
    !,
    accept(_7883,_7866,_7898),
    traceprint(4,iq24,_7907,_7898,_7926),
    pushstack(first,(whatbe,w(noun(_7729,_7730,_7731,_7732))),nil,_7926,_7979),
    whatq(_7698,_7941,_7979,_7788).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,{},{},{},_7909,{},_7948,{},{},_7997,_8036,_8065,_8099,!,_8162,_8186],_7865,_7867) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    w(name(_7768,n,_7770),_7909,_7865,_7926),
    {user:subclass0(_7770,place)},
    w(name(_7779,n,_7781),_7948,_7926,_7965),
    {user:subclass0(_7781,place)},
    {user:setvartype(_7790,vehicle)},
    realcomp(_7706,_7794,_7704,_7997,_7965,_8018),
    not_look_ahead(w(nb(_7801,_7802)),_8036,_8018,_8053),
    traceprint(4,iq25,_8065,_8053,_8084),
    pushstack(first,(w(prep(from)),w(name(_7768,n,_7770)),w(prep(to)),w(name(_7779,n,_7781))),nil,_8084,_8112),verb_modifiers(go,_7790,_7706,_7703::true,_7794,_8099,_8112,_8133),
    !,
    accept(_8162,_8133,_8177),
    qtrailer0(_8186,_8177,_7867).

implicitq(modifier(_7706):::_7703 and _7704,[implicitq,{},{},{},_7865,_7889,_7913,{},_7952,_7991,_8015,_8044,_8068,_8092,_8126,!,_8180,_8204],_7821,_7823) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    no_harmful_adj(_7865,_7821,_7880),
    no_harmful_noun(_7889,_7880,_7904),
    not_look_ahead([du],_7913,_7904,_7930),
    {user:setvartype(_7778,vehicle)},
    realcomp(_7706,_7782,_7704,_7952,_7930,_7973),
    deter0(_7991,_7973,_8006),
    not_look_ahead(w(nb(_7789,_7790)),_8015,_8006,_8032),
    no_harmful_adj(_8044,_8032,_8059),
    redundants0(_8068,_8059,_8083),
    traceprint(4,iq26,_8092,_8083,_8111),
    verb_modifiers(go,_7778,_7706,_7703::true,_7782,_8126,_8111,_8151),
    !,
    accept(_8180,_8151,_8195),
    qtrailer0(_8204,_8195,_7823).

reject_implicitq([reject_implicitq,lit(hvilke)],_7715,_7717) --> 
    cc(hvilke,_7715,_7717).

reject_implicitq([reject_implicitq,_7759,_7788,_7817,_7846,_7875],_7748,_7750) --> 
    look_ahead(w(nb(1000,num)),_7759,_7748,_7776),
    not_look_ahead([en],_7788,_7776,_7805),
    not_look_ahead([et],_7817,_7805,_7834),
    not_look_ahead([to],_7846,_7834,_7863),
    not_look_ahead([tre],_7875,_7863,_7750).

reject_implicitq([reject_implicitq,lit(at)],_7715,_7717) --> 
    cc(at,_7715,_7717).

reject_implicitq([reject_implicitq,_7731],_7720,_7722) --> 
    w(noun(error,_7701,_7702,_7703),_7731,_7720,_7722).

reject_implicitq([reject_implicitq,_7749,_7778,_7807],_7738,_7740) --> 
    not_look_ahead(w(adj2(fast,_7714)),_7749,_7738,_7766),
    not_look_ahead(w(adj2(best,_7721)),_7778,_7766,_7795),
    w(adj2(good,nil),_7807,_7795,_7740).

reject_implicitq([reject_implicitq,lit(kan)],_7715,_7717) --> 
    cc(kan,_7715,_7717).

reject_implicitq([reject_implicitq,_7745,_7774,{}],_7734,_7736) --> 
    not_look_ahead([e],_7745,_7734,_7762),
    w(verb(_7706,_7716,_7717),_7774,_7762,_7736),
    {user:_7706\==reach}.

reject_implicitq([reject_implicitq,_7740,_7769],_7729,_7731) --> 
    w(noun(_7709,_7710,_7711,_7712),_7740,_7729,_7757),
    w(verb(_7703,_7704,_7705),_7769,_7757,_7731).

reject_implicitq([reject_implicitq,_7762,_7791,_7820,_7849,_7878,_7907],_7751,_7753) --> 
    not_look_ahead([de],_7762,_7751,_7779),
    not_look_ahead([den],_7791,_7779,_7808),
    not_look_ahead([det],_7820,_7808,_7837),
    not_look_ahead([alle],_7849,_7837,_7866),
    not_look_ahead([en],_7878,_7866,_7895),
    quant_pron(_7713,_7714,_7907,_7895,_7753).

reject_implicitq([reject_implicitq,_7736,_7765],_7725,_7727) --> 
    w(noun(_7705,_7706,_7707,_7708),_7736,_7725,_7753),
    posspron(_7701,_7765,_7753,_7727).

reject_implicitq([reject_implicitq,_7743,{}],_7732,_7734) --> 
    w(noun(_7703,_7713,_7714,_7715),_7743,_7732,_7734),
    {user:testmember(_7703,[possibility,necessity])}.

reject_implicitq([reject_implicitq,_7724],_7713,_7715) --> 
    what(_7724,_7713,_7715).

reject_implicitq([reject_implicitq,lit(der)],_7715,_7717) --> 
    cc(der,_7715,_7717).

reject_implicitq([reject_implicitq,lit(hvor)],_7715,_7717) --> 
    cc(hvor,_7715,_7717).

reject_implicitq([reject_implicitq,lit(hvem)],_7715,_7717) --> 
    cc(hvem,_7715,_7717).

reject_implicitq([reject_implicitq,_7749,_7778,lit(når),_7818],_7738,_7740) --> 
    not_look_ahead([nr],_7749,_7738,_7766),
    not_look_ahead([n],_7778,_7766,_7795),
    cc(når,_7795,_7817),
    not_look_ahead(w(prep(from)),_7818,_7817,_7740).

reject_implicitq([reject_implicitq,_7724],_7713,_7715) --> 
    so(_7724,_7713,_7715).

reject_implicitq([reject_implicitq,_7736,_7765],_7725,_7727) --> 
    w(nb(1000,num),_7736,_7725,_7753),
    look_ahead([takk],_7765,_7753,_7727).

reject_implicitq([reject_implicitq,lit(da)],_7715,_7717) --> 
    cc(da,_7715,_7717).

reject_implicitq([reject_implicitq,lit(og)],_7715,_7717) --> 
    cc(og,_7715,_7717).

reject_implicitq([reject_implicitq,lit(men)],_7715,_7717) --> 
    cc(men,_7715,_7717).

reject_implicitq([reject_implicitq,_7733,lit(hvis)],_7722,_7724) --> 
    not_look_ahead([om],_7733,_7722,_7750),
    cc(hvis,_7750,_7724).

reject_implicitq([reject_implicitq,lit(fordi)],_7715,_7717) --> 
    cc(fordi,_7715,_7717).

reject_implicitq([reject_implicitq,lit(ja)],_7715,_7717) --> 
    cc(ja,_7715,_7717).

reject_implicitq([reject_implicitq,lit(nei)],_7715,_7717) --> 
    cc(nei,_7715,_7717).

reject_implicitq([reject_implicitq,{},lit(det)],_7723,_7725) --> 
    {user:value(notimeoutflag,true)},
    cc(det,_7723,_7725).

reject_implicitq([reject_implicitq,lit(det),_7746],_7724,_7726) --> 
    cc(det,_7724,_7745),
    w(verb(be,_7704,_7705),_7746,_7745,_7726).

reject_implicitq([reject_implicitq,_7767,_7796,{}],_7756,_7758) --> 
    w(adj2(good,nil),_7767,_7756,_7784),
    w(noun(_7706,_7737,_7738,_7739),_7796,_7784,_7758),
    {user:testmember(_7706,[morrow,morning,day,night,evening,midnight,afternoon,prenoon,saturday,sunday])}.

reject_implicitq([reject_implicitq,_7741,{}],_7730,_7732) --> 
    w(noun(_7703,_7711,def,_7713),_7741,_7730,_7732),
    {user:testmember(_7703,[midnight])}.

reject_implicitq([reject_implicitq,lit(på),lit(forhånd),lit(takk)],_7725,_7727) --> 
    cc(på,_7725,_7746),
    cc(forhånd,_7746,_7757),
    cc(takk,_7757,_7727).

reject_implicitq([reject_implicitq,_7764,{},_7803,{},!,_7842],_7753,_7755) --> 
    w(noun(_7715,_7716,_7717,_7718),_7764,_7753,_7781),
    {user:(\+testmember(_7715,[nightbus,airplane,airbus]))},
    endofline(_7803,_7781,_7818),
    {user:value(notimeoutflag,true)},
    !,
    reject(_7842,_7818,_7755).

reject_implicitq([reject_implicitq,lit(nå),_7746,!,_7775],_7724,_7726) --> 
    cc(nå,_7724,_7745),
    endofline(_7746,_7745,_7761),
    !,
    reject(_7775,_7761,_7726).

no_harmful_adj([no_harmful_adj,_7751,{},!,_7795],_7740,_7742) --> 
    look_ahead(w(adj2(_7711,nil)),_7751,_7740,_7768),
    {user:testmember(_7711,[nearest,good,next])},
    !,
    reject(_7795,_7768,_7742).

no_harmful_adj([no_harmful_adj,[]],_7713,_7713) --> 
    [].

no_harmful_noun([no_harmful_noun,_7749,_7778,!,_7817],_7738,_7740) --> 
    look_ahead(w(noun(_7711,_7712,_7713,n)),_7749,_7738,_7766),
    gmem(_7711,[airport,bridge],_7778,_7766,_7797),
    !,
    accept(_7817,_7797,_7740).

','({\+testmember(_7705,[airport])},no_harmful_noun,[',',_7768,{},!,_7812],_7751,_7753) --> 
    look_ahead(w(name(_7723,_7724,_7705)),_7768,_7751,_7785),
    {user:subclass0(_7705,place)},
    !,
    accept(_7812,_7785,_7753).

no_harmful_noun([no_harmful_noun,_7753,_7797,{},!],_7742,_7744) --> 
    optional([alle],_7753,_7742,_7785),
    look_ahead(w(noun(_7715,sin,_7717,_7718)),_7797,_7785,_7744),
    {user:testmember(_7715,[station])},
    !.

no_harmful_noun([no_harmful_noun,_7752,{},!],_7741,_7743) --> 
    look_ahead(w(noun(_7708,sin,u,n)),_7752,_7741,_7743),
    {user:testmember(_7708,[arrival,departure,station,student])},
    !.

no_harmful_noun([no_harmful_noun,_7743,{}],_7732,_7734) --> 
    not_look_ahead(w(noun(_7705,_7713,_7714,_7715)),_7743,_7732,_7734),
    {user:(\+testmember(_7705,airport))}.

therightprep(from,[therightprep,_7738,!],_7724,_7726) --> 
    w(prep(from),_7738,_7724,_7726),
    !.

therightprep(_7698,[therightprep,_7738,!],_7724,_7726) --> 
    w(prep(_7698),_7738,_7724,_7726),
    !.

not_adjective_only([not_adjective_only,_7735,!],_7724,_7726) --> 
    look_ahead(w(name(_7705,n,_7707)),_7735,_7724,_7726),
    !.

not_adjective_only([not_adjective_only,_7731],_7720,_7722) --> 
    look_ahead(w(adj2(_7702,_7703)),_7731,_7720,_7722).

not_fnlp([not_fnlp,_7753,{},!,_7797],_7742,_7744) --> 
    look_ahead(w(adj2(_7711,nil)),_7753,_7742,_7770),
    {user:testmember(_7711,[first,next,last,previous])},
    !,
    reject(_7797,_7770,_7744).

not_fnlp([not_fnlp,[]],_7713,_7713) --> 
    [].

constrainvehdep(_7698,[constrainvehdep,{},!,_7757],_7728,_7730) --> 
    {user:vartypeid(_7698,thing)},
    !,
    reject(_7757,_7728,_7730).

constrainvehdep(_7698,[constrainvehdep,{},!,_7757],_7728,_7730) --> 
    {user:constrain(_7698,clock)},
    !,
    reject(_7757,_7728,_7730).

constrainvehdep(_7700:_7701,[constrainvehdep,{},{},!,_7780],_7741,_7743) --> 
    {user:constrain(_7700:_7718,number)},
    {user:plausible_busno(_7700)},
    !,
    accept(_7780,_7741,_7743).

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,summerroute)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,winterroute)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,route)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,route_plan)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,vehicle)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,departure)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,arrival)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,connection)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,tram_route)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,tram_route_plan)},
    !.

constrainvehdep(_7698,[constrainvehdep,{},!],_7725,_7725) --> 
    {user:constrain(_7698,trip)},
    !.

hasq(_7698,[hasq,_7770,_7794,_7823,!,_7857,_7881],_7756,_7758) --> 
    has(_7770,_7756,_7785),
    thereit(_7727,_7794,_7785,_7811),
    w(verb(_7723,past,part),_7823,_7811,_7840),
    !,
    accept(_7857,_7840,_7872),
    pushstack(free,([det],w(verb(_7723,pres,fin))),nil,_7872,_7891),
    statement(_7698,_7881,_7891,_7758).

hasq(_7698,[hasq,_7791,_7820,_7849,_7873,_7907,_7936,_7960,_7984,_8008,!,_8037],_7777,_7779) --> 
    w(verb(have,_7745,fin),_7791,_7777,_7808),
    negation0(_7748,_7820,_7808,_7837),
    so0(_7849,_7837,_7864),
    subject(_7750,_7751,_7873,_7864,_7892),
    negation0(_7753,_7907,_7892,_7924),
    adverbx0(_7936,_7924,_7951),
    hatt0(_7960,_7951,_7975),
    negatino(_7984,_7975,_7999),
    sometimes0(_8008,_7999,_8023),
    !,
    pushstack(first,(xnp(_7750,_7751),w(verb(have,pres,fin))),nil,_8023,_8078),
    statement(_7698,_8037,_8078,_7779).

hasq(_7698,[hasq,_7756,_7785,_7814],_7742,_7744) --> 
    w(verb(have,_7712,fin),_7756,_7742,_7773),
    negation0(_7721,_7785,_7773,_7802),
    lock(last,_7802,_7831),
    pushstack(last,w(verb(have,_7712,fin)),nil,_7831,_7837),
    statement(_7698,_7814,_7837,_7826),
    unlock(_7826,_7744).

isq(_7698,[isq,_7821,_7845,_7874,_7903,_7932,_7956,_7985,lit(å),!,_8035,!,_8083],_7807,_7809) --> 
    be(_7821,_7807,_7836),
    negation0(_7747,_7845,_7836,_7862),
    thereit(_7749,_7874,_7862,_7891),
    negation0(_7751,_7903,_7891,_7920),
    so0(_7932,_7920,_7947),
    w(adj2(_7744,nil),_7956,_7947,_7973),
    gmem(_7744,[true,false,wrong,correct],_7985,_7973,_8004),
    cc(å,_8004,_8029),
    !,
    pushstack(first,[jeg],nil,_8029,_8048),clausal_object1(_7776,_7777,_8035,_8048,_8063),
    !,
    pushstack(first,(xnp(_7776,_7777),w(verb(be,pres,fin)),w(adj2(_7744,nil))),nil,_8063,_8124),
    substatement1(_7698,_8083,_8124,_7809).

isq(_7698,[isq,_7816,_7840,_7869,_7898,_7927,_7951,_7980,lit(at),!,_8030,!,_8069],_7802,_7804) --> 
    be(_7816,_7802,_7831),
    negation0(_7747,_7840,_7831,_7857),
    thereit(_7749,_7869,_7857,_7886),
    negation0(_7751,_7898,_7886,_7915),
    so0(_7927,_7915,_7942),
    w(adj2(_7744,nil),_7951,_7942,_7968),
    gmem(_7744,[true,false,wrong,correct],_7980,_7968,_7999),
    cc(at,_7999,_8024),
    !,
    clausal_object1(_7771,_7772,_8030,_8024,_8049),
    !,
    pushstack(first,(xnp(_7771,_7772),w(verb(be,pres,fin)),w(adj2(_7744,nil))),nil,_8049,_8110),
    substatement1(_7698,_8069,_8110,_7804).

isq(_7698,[isq,_7776,_7805,_7834,_7863,!,[],_7911],_7762,_7764) --> 
    w(verb(be,_7723,fin),_7776,_7762,_7793),
    negation0(_7726,_7805,_7793,_7822),
    thereit(_7728,_7834,_7822,_7851),
    w(verb(_7732,past,part),_7863,_7851,_7880),
    !,
    pushstack(free,w(verb(_7732,_7723,fin)),nil,_7880,_7910),[],
    statement(_7698,_7911,_7910,_7764).

isq(_7698,[isq,_7778,_7802,_7831,_7860,_7889,_7913,!,_7947],_7764,_7766) --> 
    be(_7778,_7764,_7793),
    negation0(_7733,_7802,_7793,_7819),
    pronoun(_7735,_7831,_7819,_7848),
    negation0(_7737,_7860,_7848,_7877),
    not_look_ahead_np(_7889,_7877,_7904),
    not_look_ahead([som],_7913,_7904,_7930),
    !,
    pushstack(first,(pronoun(_7735),w(verb(be,pres,fin))),nil,_7930,_7988),
    substatement1(_7698,_7947,_7988,_7766).

isq(_7698,[isq,_7812,lit(det),_7847,_7876,_7900,_7929,_7958,lit(å),!,_8008,_8082],_7798,_7800) --> 
    be(_7812,_7798,_7827),
    cc(det,_7827,_7846),
    negation0(_7746,_7847,_7846,_7864),
    so0(_7876,_7864,_7891),
    w(adj2(_7741,nil),_7900,_7891,_7917),
    w(prep(for),_7929,_7917,_7946),
    object(_7757,_7758,_7958,_7946,_7977),
    cc(å,_7977,_8002),
    !,
    pushstack(first,(xnp(_7757,_7758),[vil]),nil,_8002,_8052),clausal_object1(_7770,_7771,_8008,_8052,_8067),
    pushstack(first,(xnp(_7770,_7771),be,w(adj2(_7741,nil))),nil,_8067,_8151),
    substatement1(_7698,_8082,_8151,_7800).

isq(_7698,[isq,_7787,_7811,_7840,_7869,_7893,_7922,!,_7961],_7773,_7775) --> 
    be(_7787,_7773,_7802),
    thereit(_7737,_7811,_7802,_7828),
    negation0(_7739,_7840,_7828,_7857),
    so0(_7869,_7857,_7884),
    w(adj2(_7743,nil),_7893,_7884,_7910),
    prepnog(_7743,_7735,_7922,_7910,_7941),
    !,
    pushstack(first,(something,be,w(adj2(_7743,nil)),w(prep(_7735))),nil,_7941,_8027),
    substatement1(_7698,_7961,_8027,_7775).

isq(_7698,[isq,_7807,_7831,_7860,_7889,_7918,_7942,{},lit(å),!,_7997],_7793,_7795) --> 
    be(_7807,_7793,_7822),
    negation0(_7741,_7831,_7822,_7848),
    thereit(_7743,_7860,_7848,_7877),
    negation0(_7745,_7889,_7877,_7906),
    so0(_7918,_7906,_7933),
    w(adj2(_7749,nil),_7942,_7933,_7959),
    {user:(\+testmember(_7749,[]))},
    cc(å,_7959,_7991),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7749,nil)),[å]),nil,_7991,_8007),
    substatement1(_7698,_7997,_8007,_7795).

isq(_7698,[isq,_7787,_7811,_7840,_7869,_7898,_7922,!,_7956],_7773,_7775) --> 
    be(_7787,_7773,_7802),
    negation0(_7735,_7811,_7802,_7828),
    thereit(_7737,_7840,_7828,_7857),
    negation0(_7739,_7869,_7857,_7886),
    so0(_7898,_7886,_7913),
    w(adj2(_7732,nil),_7922,_7913,_7939),
    !,
    pushstack(first,([noe],w(verb(be,pres,fin)),w(adj2(_7732,nil))),nil,_7939,_7966),
    substatement1(_7698,_7956,_7966,_7775).

isq(_7698,[isq,_7761,_7785,_7809,!,_7843],_7747,_7749) --> 
    be(_7761,_7747,_7776),
    dette(_7785,_7776,_7800),
    negation0(_7724,_7809,_7800,_7826),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin))),nil,_7826,_7853),
    substatement1(_7698,_7843,_7853,_7749).

isq(_7698,[isq,_7759,_7783,_7807,!,_7836],_7745,_7747) --> 
    be(_7759,_7745,_7774),
    thereit(_7783,_7774,_7798),
    ikkeingen0(_7807,_7798,_7822),
    !,
    pushstack(free,([det],w(verb(be,pres,fin))),nil,_7822,_7846),
    substatement1(_7698,_7836,_7846,_7747).

isq(_7698,[isq,_7770,_7794,_7823,_7857,!,_7891],_7756,_7758) --> 
    be(_7770,_7756,_7785),
    negation0(_7727,_7794,_7785,_7811),
    subject(_7729,_7730,_7823,_7811,_7842),
    negation0(_7732,_7857,_7842,_7874),
    !,
    pushstack(first,(xnp(_7729,_7730),w(verb(be,pres,fin))),nil,_7874,_7932),
    substatement1(_7698,_7891,_7932,_7758).

isq(_7698,[isq,_7756,_7780,_7804,!,_7838],_7742,_7744) --> 
    be(_7756,_7742,_7771),
    det0(_7780,_7771,_7795),
    negation0(_7721,_7804,_7795,_7821),
    !,
    pushstack(free,w(verb(be,pres,fin)),nil,_7821,_7848),
    substatement1(_7698,_7838,_7848,_7744).

ikkeingen0([ikkeingen0,lit(ingen),!],_7718,_7720) --> 
    cc(ingen,_7718,_7720),
    !.

ikkeingen0([ikkeingen0,_7726],_7715,_7717) --> 
    negation0(_7698,_7726,_7715,_7717).

ynqs(_7698,[ynqs,_7745,_7774,!,_7813],_7731,_7733) --> 
    isynq(_7709,_7745,_7731,_7762),
    orwill(_7709,_7698,_7774,_7762,_7793),
    !,
    accept(_7813,_7793,_7733).

isynq(_7698,[isynq,_7733],_7719,_7721) --> 
    isq(_7698,_7733,_7719,_7721).

isynq(_7698,[isynq,_7733],_7719,_7721) --> 
    ynq(_7698,_7733,_7719,_7721).

orwill(_7698,_7698,[orwill,lit(eller),_7759,!,_7788],_7731,_7733) --> 
    cc(eller,_7731,_7758),
    endofline(_7759,_7758,_7774),
    !,
    accept(_7788,_7774,_7733).

orwill(_7698,_7698 or _7702,[orwill,lit(eller),_7780,!,_7814,_7838,_7867],_7752,_7754) --> 
    cc(eller,_7752,_7779),
    not_look_ahead(w(nb(_7728,_7729)),_7780,_7779,_7797),
    !,
    accept(_7814,_7797,_7829),
    isynq(_7719,_7838,_7829,_7855),
    orwill(_7719,_7702,_7867,_7855,_7754).

orwill(_7698,_7698,[orwill,[]],_7720,_7720) --> 
    [].

ynq(_7698,[ynq,_7793,{},lit(det),_7843,_7872,!,_7906],_7779,_7781) --> 
    w(verb(_7726,_7727,fin),_7793,_7779,_7810),
    {user:(\+testmember(_7726,[be,have]))},
    cc(det,_7810,_7842),
    negation0(_7749,_7843,_7842,_7860),
    look_ahead(w(adj2(_7755,_7756)),_7872,_7860,_7889),
    !,
    pushstack(free,([dette],w(verb(_7726,_7727,fin))),nil,_7889,_7916),
    statreal(_7698,_7906,_7916,_7781).

ynq(_7698,[ynq,_7808,{},lit(det),_7858,lit(å),_7903,!,_7951],_7794,_7796) --> 
    w(verb(_7735,_7736,fin),_7808,_7794,_7825),
    {user:testmember(_7735,[cost])},
    cc(det,_7825,_7857),
    np0_accept(_7730,_7731,_7858,_7857,_7877),
    cc(å,_7877,_7902),
    pushstack(first,([noen],[vil]),nil,_7902,_7916),clausal_object1(_7761,_7762,_7903,_7916,_7931),
    !,
    pushstack(first,(xnp(_7761,_7762),w(verb(_7735,pres,fin)),xnp(_7730,_7731)),nil,_7931,_8023),
    statreal1(_7698,_7951,_8023,_7796).

ynq(_7698,[ynq,_7785,lit(det),_7820,_7849,_7878,_7912,_7936,!,_8010],_7771,_7773) --> 
    aux1(_7785,_7771,_7800),
    cc(det,_7800,_7819),
    negation0(_7726,_7820,_7819,_7837),
    w(verb(happen,inf,fin),_7849,_7837,_7866),
    subject(_7734,_7735,_7878,_7866,_7897),
    not_look_ahead_vp(_7912,_7897,_7927),
    pushstack(first,(xnp(_7734,_7735),w(verb(happen,pres,fin))),nil,_7927,_7980),statreal1(_7698,_7936,_7980,_7993),
    !,
    accept(_8010,_7993,_7773).

ynq(_7698,[ynq,lit(kan),_7789,_7818,_7852,_7881,_7905,!,_7979],_7764,_7766) --> 
    cc(kan,_7764,_7788),
    negation0(_7723,_7789,_7788,_7806),
    subject(_7725,_7726,_7818,_7806,_7837),
    negation0(_7728,_7852,_7837,_7869),
    not_look_ahead_vp(_7881,_7869,_7896),
    pushstack(first,(xnp(_7725,_7726),w(verb(know1,pres,fin))),nil,_7896,_7949),statreal1(_7698,_7905,_7949,_7962),
    !,
    accept(_7979,_7962,_7766).

ynq(_7698,[ynq,lit(_7723),{},_7803,_7832,_7866,!,_7900],_7768,_7770) --> 
    cc(_7723,_7768,_7792),
    {user:testmember(_7723,[får,kan,kunne])},
    negation0(_7739,_7803,_7792,_7820),
    subject(_7741,_7742,_7832,_7820,_7851),
    negation0(_7744,_7866,_7851,_7883),
    !,
    pushstack(first,(xnp(_7741,_7742),[_7723]),nil,_7883,_7941),
    statreal1(_7698,_7900,_7941,_7770).

ynq(_7698,[ynq,_7795,_7819,_7853,_7882,{},_7921,!,_7955],_7781,_7783) --> 
    aux1(_7795,_7781,_7810),
    subject(_7733,_7734,_7819,_7810,_7838),
    w(verb(_7729,inf,fin),_7853,_7838,_7870),
    not_look_ahead(w(verb(_7746,_7747,_7748)),_7882,_7870,_7899),
    {user:(\+verbtype(_7729,rv))},
    negation0(_7757,_7921,_7899,_7938),
    !,
    pushstack(first,(xnp(_7733,_7734),w(verb(_7729,pres,fin))),nil,_7938,_7996),
    statreal1(_7698,_7955,_7996,_7783).

ynq(_7698,[ynq,lit(så),!,_7755],_7725,_7727) --> 
    cc(så,_7725,_7749),
    !,
    reject(_7755,_7749,_7727).

ynq(_7698,[ynq,_7792,_7816,_7845,lit(av),!,_7895,_7919,_7943,_7972],_7778,_7780) --> 
    aux1(_7792,_7778,_7807),
    not_look_ahead(w(verb(go,_7740,_7741)),_7816,_7807,_7833),
    subject(_7743,_7744,_7845,_7833,_7864),
    cc(av,_7864,_7889),
    !,
    accept(_7895,_7889,_7910),
    adverbx0(_7919,_7910,_7934),
    negation0(_7748,_7943,_7934,_7960),
    pushstack(first,(xnp(_7743,_7744),w(verb(go,pres,fin)),[av]),nil,_7960,_8013),
    statreal1(_7698,_7972,_8013,_7780).

ynq(_7698,[ynq,_7807,_7831,_7860,_7894,_7918,{},!,_7962,_7986,_8010,_8039],_7793,_7795) --> 
    aux1(_7807,_7793,_7822),
    not_look_ahead(w(verb(go,_7748,_7749)),_7831,_7822,_7848),
    subject(_7751,_7752,_7860,_7848,_7879),
    redundant0(_7894,_7879,_7909),
    w(prep(_7741),_7918,_7909,_7935),
    {user:_7741\==av},
    !,
    accept(_7962,_7935,_7977),
    adverbx0(_7986,_7977,_8001),
    negation0(_7763,_8010,_8001,_8027),
    pushstack(first,(xnp(_7751,_7752),w(verb(go,pres,fin)),w(prep(_7741))),nil,_8027,_8080),
    statreal1(_7698,_8039,_8080,_7795).

ynq(_7698,[ynq,_7822,_7856,_7885,_7914,_7943,_7972,_8006,_8045,!,_8079,_8103,_8127,[],_8202,!,_8304],_7808,_7810) --> 
    aux1(_7745,_7746,_7822,_7808,_7841),
    negation0(_7748,_7856,_7841,_7873),
    not_look_ahead([man],_7885,_7873,_7902),
    not_look_ahead([jeg],_7914,_7902,_7931),
    not_look_ahead([du],_7943,_7931,_7960),
    subject(_7762,_7763,_7972,_7960,_7991),
    preadverbial0(_7765,_7766,_7767,_8006,_7991,_8027),
    negation0(_7769,_8045,_8027,_8062),
    !,
    accept(_8079,_8062,_8094),
    adverbx0(_8103,_8094,_8118),
    negation0(_7771,_8127,_8118,_8144),
    pushstack(free,adverbial1(_7765,_7766,_7767),nil,_8144,_8201),[],
    pushstack(first,(noun_phrase1(_7762,_7763),aux1),nil,_8201,_8274),statreal1(_7698,_8202,_8274,_8287),
    !,
    accept(_8304,_8287,_7810).

ynq(_7698,[ynq,_7775,_7799,_7823,{},!,_7867],_7761,_7763) --> 
    do(_7775,_7761,_7790),
    you(_7799,_7790,_7814),
    w(verb(_7720,_7727,fin),_7823,_7814,_7840),
    {user:testmember(_7720,[list,show])},
    !,
    pushstack(first,w(verb(_7720,imp,fin)),nil,_7840,_7877),
    command(doit:::_7698,_7867,_7877,_7763).

ynq(_7698,[ynq,_7741,_7765,_7794],_7727,_7729) --> 
    do(_7741,_7727,_7756),
    negation0(_7708,_7765,_7756,_7782),
    statreal1(_7698,_7794,_7782,_7729).

ynq(_7698,[ynq,_7742,_7766,!,_7800],_7728,_7730) --> 
    aux1(_7742,_7728,_7757),
    prep(_7709,_7766,_7757,_7783),
    !,
    reject(_7800,_7783,_7730).

ynq(_7698,[ynq,_7810,_7839,lit(det),_7884,lit(å),!,_7934,_7977],_7796,_7798) --> 
    w(verb(_7735,_7736,fin),_7810,_7796,_7827),
    gmem(_7735,[cost,take,be],_7839,_7827,_7858),
    cc(det,_7858,_7883),
    np0_accept(_7730,_7731,_7884,_7883,_7903),
    cc(å,_7903,_7928),
    !,
    pushstack(first,([noen],[vil]),nil,_7928,_7947),clausal_object1(_7763,_7764,_7934,_7947,_7962),
    pushstack(first,(xnp(_7763,_7764),w(verb(_7735,pres,fin)),xnp(_7730,_7731)),nil,_7962,_8049),
    statreal1(_7698,_7977,_8049,_7798).

ynq(_7698,[ynq,_7771,{},_7810,!,_7844],_7757,_7759) --> 
    w(verb(_7717,_7718,fin),_7771,_7757,_7788),
    {user:testmember(_7717,[know,find])},
    negation0(_7736,_7810,_7788,_7827),
    !,
    pushstack(free,w(verb(_7717,_7718,fin)),nil,_7827,_7854),
    statreal1(_7698,_7844,_7854,_7759).

ynq(_7698,[ynq,_7788,{},{},_7852,_7881,!,_7910],_7774,_7776) --> 
    lexv(tv,_7723,_7724,fin,_7788,_7774,_7811),
    {user:_7724\==imp},
    {user:(\+testmember(_7723,[have,think]))},
    not_look_ahead(w(adj2(_7752,_7753)),_7852,_7811,_7869),
    anyadverb0(_7881,_7869,_7896),
    !,
    pushstack(free,w(verb(_7723,_7724,fin)),nil,_7896,_7920),
    statreal1(_7698,_7910,_7920,_7776).

ynq(_7698,[ynq,_7771,_7815,lit(til),lit(å),!,_7876],_7757,_7759) --> 
    lexv(iv,come,_7725,fin,_7771,_7757,_7794),
    subject(_7728,_7729,_7815,_7794,_7834),
    cc(til,_7834,_7859),
    cc(å,_7859,_7870),
    !,
    pushstack(first,(xnp(_7728,_7729),[vil]),nil,_7870,_7917),
    statreal(_7698,_7876,_7917,_7759).

ynq(_7698,[ynq,_7780,_7824,_7858,lit(hva),!,_7903],_7766,_7768) --> 
    lexv(rv,know,_7728,fin,_7780,_7766,_7803),
    subject(_7731,_7732,_7824,_7803,_7843),
    negation0(_7734,_7858,_7843,_7875),
    cc(hva,_7875,_7897),
    !,
    pushstack(first,(xnp(_7731,_7732),w(verb(know,_7728,fin)),[hva]),nil,_7897,_7944),
    statreal(_7698,_7903,_7944,_7768).

ynq(_7698,[ynq,_7773,_7817,_7851,!,_7880],_7759,_7761) --> 
    lexv(rv,_7724,_7725,fin,_7773,_7759,_7796),
    subject(_7728,_7729,_7817,_7796,_7836),
    infinitive(_7851,_7836,_7866),
    !,
    pushstack(first,(xnp(_7728,_7729),w(verb(_7724,_7725,fin)),[å]),nil,_7866,_7921),
    statreal(_7698,_7880,_7921,_7761).

ynq(_7698,[ynq,_7826,{},_7865,_7894,_7923,_7962,_7996,_8025,_8054,!,_8088],_7812,_7814) --> 
    w(verb(_7745,_7746,fin),_7826,_7812,_7843),
    {user:(\+testmember(_7745,[be,have]))},
    not_look_ahead([det],_7865,_7843,_7882),
    not_look_ahead(w(adj2(_7768,_7769)),_7894,_7882,_7911),
    adverb0(_7741,_7772,_7773,_7923,_7911,_7944),
    subject(_7775,_7776,_7962,_7944,_7981),
    reflexiv0(_7745,_7996,_7981,_8013),
    negation0(_7780,_8025,_8013,_8042),
    rep_particlev0(_7745,_8054,_8042,_8071),
    !,
    pushstack(free,(xnp(_7775,_7776),w(verb(_7745,_7746,fin)),w(adv(_7741))),nil,_8071,_8129),
    statreal(_7698,_8088,_8129,_7814).

ynq(_7698,[ynq,_7783,_7812,_7846,!,_7875,_7899,_7923,_7952,!,_8026],_7769,_7771) --> 
    w(verb(reach,pres,fin),_7783,_7769,_7800),
    np1_accept(_7733,_7736::_7737,_7812,_7800,_7831),
    infinitive(_7846,_7831,_7861),
    !,
    accept(_7875,_7861,_7890),
    adverbx0(_7899,_7890,_7914),
    negation0(_7739,_7923,_7914,_7940),
    pushstack(first,noun_phrase1(_7733,_7736::_7737),nil,_7940,_7996),statreal1(_7698,_7952,_7996,_8009),
    !,
    accept(_8026,_8009,_7771).

ynq(_7698,[ynq,_7748,_7777,!,_7806],_7734,_7736) --> 
    not_look_ahead(w(verb(go,_7714,fin)),_7748,_7734,_7765),
    be(_7777,_7765,_7792),
    !,
    reject(_7806,_7792,_7736).

ynq(_7698,[ynq,_7766,!,_7800,_7824],_7752,_7754) --> 
    w(verb(_7717,pres,pass),_7766,_7752,_7783),
    !,
    thereit0(_7800,_7783,_7815),
    pushstack(free,(w(verb(be,pres,fin)),w(verb(_7717,past,part))),nil,_7815,_7834),
    isq(_7698,_7824,_7834,_7754).

ynq(_7698,[ynq,_7757,_7786,_7815,!,_7849],_7743,_7745) --> 
    w(verb(want,pres,fin),_7757,_7743,_7774),
    not_look_ahead([du],_7786,_7774,_7803),
    not_look_ahead([jeg],_7815,_7803,_7832),
    !,
    reject(_7849,_7832,_7745).

ynq(_7698,[ynq,_7759,_7788,_7812,_7841,!,_7870],_7745,_7747) --> 
    w(verb(go,_7721,fin),_7759,_7745,_7776),
    thereit(_7788,_7776,_7803),
    negation0(_7724,_7812,_7803,_7829),
    anaa(_7841,_7829,_7856),
    !,
    pushstack(first,someone,nil,_7856,_7908),
    statement(_7698,_7870,_7908,_7747).

ynq(_7698,[ynq,_7775,lit(det),{},!,_7845],_7761,_7763) --> 
    lexv(iv,_7720,_7721,fin,_7775,_7761,_7798),
    cc(det,_7798,_7829),
    {user:testmember(_7720,[rain,snow])},
    !,
    pushstack(first,([det],w(verb(_7720,_7721,fin))),nil,_7829,_7855),
    statement(_7698,_7845,_7855,_7763).

ynq(_7698,[ynq,_7785,lit(det),_7825,_7854,!,_7888],_7771,_7773) --> 
    w(verb(_7723,_7724,fin),_7785,_7771,_7802),
    cc(det,_7802,_7824),
    look_ahead(w(prep(_7739)),_7825,_7824,_7842),
    not_look_ahead([e],_7854,_7842,_7871),
    !,
    pushstack(first,(w(noun(vehicle,plu,u,n)),w(verb(_7723,_7724,fin))),nil,_7871,_7898),
    statement(_7698,_7888,_7898,_7773).

ynq(_7698,[ynq,_7779,{},_7818,_7847,!,_7881],_7765,_7767) --> 
    w(verb(_7723,_7724,fin),_7779,_7765,_7796),
    {user:(\+rv_templ(_7723,_7738))},
    negation0(_7740,_7818,_7796,_7835),
    thereit(_7742,_7847,_7835,_7864),
    !,
    pushstack(first,([det],w(verb(_7723,_7724,fin))),nil,_7864,_7891),
    statement(_7698,_7881,_7891,_7767).

ynq(_7698,[ynq,_7786,_7815,_7844,_7873,{},_7907,!,_7941],_7772,_7774) --> 
    w(verb(_7726,_7727,fin),_7786,_7772,_7803),
    not_look_ahead(w(verb,_7739,_7740),_7815,_7803,_7832),
    not_look_ahead([det],_7844,_7832,_7861),
    saa0(_7873,_7861,_7888),
    {user:_7726\==have},
    negation0(_7751,_7907,_7888,_7924),
    !,
    pushstack(free,w(verb(_7726,_7727,fin)),nil,_7924,_7951),
    statreal(_7698,_7941,_7951,_7774).

ynq(_7698,[ynq,{},_7775,_7804,!,_7833],_7751,_7753) --> 
    {user:value(smsflag,true)},
    w(verb(have,pres,fin),_7775,_7751,_7792),
    look_ahead_bus(_7804,_7792,_7819),
    !,
    pushstack(free,w(verb(go,pres,fin)),nil,_7819,_7843),
    statreal(_7698,_7833,_7843,_7753).

ynq(_7698,[ynq,_7783,_7812,{},_7866,{},_7900,!,_7929],_7769,_7771) --> 
    not_look_ahead([vil],_7783,_7769,_7800),
    lexv(iv,_7725,_7726,fin,_7812,_7800,_7835),
    {user:(\+rv_templ(_7725,_7743))},
    saa0(_7866,_7835,_7881),
    {user:_7726\==imp},
    anyadverb0(_7900,_7881,_7915),
    !,
    lock(last,_7915,_7979),
    pushstack(last,lexv(iv,_7725,_7726,fin),nil,_7979,_7985),
    statreal1(_7698,_7929,_7985,_7974),
    unlock(_7974,_7771).

look_ahead_bus([look_ahead_bus,_7747,{}],_7736,_7738) --> 
    look_ahead(w(noun(_7703,_7717,_7718,n)),_7747,_7736,_7738),
    {user:testmember(_7703,[bus,nightbus,number])}.

look_ahead_bus([look_ahead_bus,_7731],_7720,_7722) --> 
    look_ahead(w(adj2(next,nil)),_7731,_7720,_7722).

ppq(_7700:::_7701,[ppq,_7833,_7862,_7901,!,_7935,!,_7974,_7998,_8123],_7819,_7821) --> 
    prep(_7746,_7833,_7819,_7850),
    whx_phrase(_7748,_7700,_7752::_7753,_7862,_7850,_7883),
    w(verb(_7757,pres,pass),_7901,_7883,_7918),
    !,
    noun_phrase1(_7761,_7764::_7765,_7935,_7918,_7954),
    !,
    accept(_7974,_7954,_7989),
    lock(exact,_7989,_8082),pushstack(exact,(prep(_7746),noun_phrase1(_7748,_7752::_7753)),nil,_8082,_8088),adverbial1(_7739,_7740,_7743::_7744,_7998,_8088,_8077),unlock(_8077,_8078),
    pushstack(first,(someone,w(verb(_7757,pres,fin)),noun_phrase1(_7761,_7764::_7765),adverbial1(_7739,_7740,_7743::_7744)),nil,_8078,_8230),
    statreal(_7701,_8123,_8230,_7821).

ppq(_7700:::_7701,[ppq,_7780,_7809,{},!,_7863,_7907,!,_7941],_7766,_7768) --> 
    prepnof(_7724,_7780,_7766,_7797),
    whx_phrase(_7726,_7700,_7730::_7731,_7809,_7797,_7830),
    {user:adjustprep(_7726,_7724,_7737)},
    !,
    forwq(_7701,_7737,_7726,_7730::_7731,_7863,_7830,_7886),
    optionalprep(_7737,_7907,_7886,_7924),
    !,
    accept(_7941,_7924,_7768).

optionalprep(in,[optionalprep,_7739,!,_7773],_7725,_7727) --> 
    prep1(_7706,_7739,_7725,_7756),
    !,
    accept(_7773,_7756,_7727).

optionalprep(_7698,[optionalprep,[]],_7717,_7717) --> 
    [].

forwq(_7698,_7699,_7700,_7703::_7704,[forwq,_7787,!,_7836,_7860],_7764,_7766) --> 
    lexv(_7728,be1,_7730,fin,_7787,_7764,_7810),
    !,
    thereit0(_7836,_7810,_7851),
    pushstack(free,(w(verb(be1,pres,fin)),adverbial1(_7699,_7700,_7703::_7704)),nil,_7851,_7905),
    statreal(_7698,_7860,_7905,_7766).

forwq(_7698,_7699,_7700,_7703::_7704,[forwq,_7770,!,_7799],_7747,_7749) --> 
    do(_7770,_7747,_7785),
    !,
    pushstack(free,adverbial1(_7699,_7700,_7703::_7704),nil,_7785,_7844),
    statreal(_7698,_7799,_7844,_7749).

forwq(_7698,_7699,_7700,_7703::_7704,[forwq,_7793,{},_7832,_7856],_7770,_7772) --> 
    w(verb(_7730,_7731,_7732),_7793,_7770,_7810),
    {user:_7730\==understand},
    thereit0(_7832,_7810,_7847),
    pushstack(free,(w(verb(_7730,_7731,_7732)),adverbial1(_7699,_7700,_7703::_7704)),nil,_7847,_7901),
    statreal(_7698,_7856,_7901,_7772).

whichq(_7700:::_7703 and _7704,[whichq,_7812,_7851,_7880,_7904,_7928,!,_7962,_7986],_7798,_7800) --> 
    whx_phrase(_7742,_7700,true::_7703,_7812,_7798,_7833),
    w(verb(recommend,_7754,pass),_7851,_7833,_7868),
    det0(_7880,_7868,_7895),
    infinitive(_7904,_7895,_7919),
    w(verb(_7759,inf,_7761),_7928,_7919,_7945),
    !,
    accept(_7962,_7945,_7977),
    pushstack(first,([noen],w(verb(recommend,_7754,fin)),[å],w(verb(_7759,inf,_7779)),npgap(_7742)),nil,_7977,_8027),
    statreal(_7704,_7986,_8027,_7800).

whichq(_7700:::_7703 and _7704,[whichq,_7790,_7829,_7853,_7882,!,_7921],_7776,_7778) --> 
    whx_phrase(_7730,_7700,true::_7703,_7790,_7776,_7811),
    paux0(_7829,_7811,_7844),
    w(verb(_7741,_7742,pass),_7853,_7844,_7870),
    whodidit(_7745,_7746,_7882,_7870,_7901),
    !,
    pushstack(first,(xnp(_7745,_7746),w(verb(_7741,_7742,fin)),npgap(_7730)),nil,_7901,_7992),
    statreal(_7704,_7921,_7992,_7778).

whichq(_7700:::_7701,[whichq,_7765,_7804,_7843,{}],_7751,_7753) --> 
    whx_phrase(_7718,_7700,_7716::_7701,_7765,_7751,_7786),
    realcomp(_7725,_7726,_7715,_7804,_7786,_7825),
    qverb_phrase(_7718,_7714,_7725,_7726,_7843,_7825,_7753),
    {user:negate(_7714,_7715,_7716)}.

whx_phrase(_7698,_7699,_7702::_7703,[whx_phrase,{},_7824,_7858,{},!,_7902,!,_7963],_7794,_7796) --> 
    {user:value(busflag,true)},
    whichf(_7698,_7699,_7824,_7794,_7843),
    look_ahead(w(verb(_7738,_7739,fin)),_7858,_7843,_7875),
    {user:testmember(_7738,[go,pass,leave,depart,arrive])},
    !,
    lock(exact,_7875,_7922),pushstack(exact,w(noun(vehicle,plu,u,n)),nil,_7922,_7928),noun_phrase1(_7698,_7702::_7703,_7902,_7928,_7917),unlock(_7917,_7918),
    !,
    accept(_7963,_7918,_7796).

whx_phrase(_7698,_7699,_7702::_7703,[whx_phrase,_7792,_7826,_7850,_7879,!,_7908],_7772,_7774) --> 
    whichf(_7698,_7699,_7792,_7772,_7811),
    oter(_7826,_7811,_7841),
    w(noun(_7733,_7734,u,n),_7850,_7841,_7867),
    enn(_7879,_7867,_7894),
    !,
    pushstack(first,(w(noun(_7733,_7734,u,n)),[ulik]),nil,_7894,_7918),
    noun_phrase1(_7698,_7702::_7703,_7908,_7918,_7774).

whx_phrase(_7698,which(_7698),_7702::_7703,[whx_phrase,_7799,_7823,_7852,{},!,_7896],_7779,_7781) --> 
    hvordan(_7799,_7779,_7814),
    not_look_ahead(w(verb(_7736,pres,fin)),_7823,_7814,_7840),
    w(noun(_7727,_7743,_7744,_7745),_7852,_7840,_7869),
    {user:_7727\==type},
    !,
    pushstack(first,w(noun(_7727,sin,u,n)),nil,_7869,_7906),
    noun_phrase1(_7698,_7702::_7703,_7896,_7906,_7781).

whx_phrase(_7698,which(_7698),_7702::_7703,[whx_phrase,lit(hva),_7804,_7833,{},!,_7877],_7773,_7775) --> 
    cc(hva,_7773,_7803),
    not_look_ahead(w(verb(_7734,_7735,_7736)),_7804,_7803,_7821),
    look_ahead(w(noun(_7742,_7743,_7744,_7745)),_7833,_7821,_7850),
    {user:_7742\==type},
    !,
    noun_phrase1(_7698,_7702::_7703,_7877,_7850,_7775).

whx_phrase(_7698,_7699,_7702::_7703,[whx_phrase,_7767,_7801,_7825,!,_7864],_7747,_7749) --> 
    whichf(_7698,_7699,_7767,_7747,_7786),
    type0(_7801,_7786,_7816),
    noun_phrase1(_7698,_7702::_7703,_7825,_7816,_7844),
    !,
    accept(_7864,_7844,_7749).

whx_phrase(_7698,_7699,_7702::_7703,[whx_phrase,_7783,_7817,!,_7851,!,_7899],_7763,_7765) --> 
    whichf(_7698,_7699,_7783,_7763,_7802),
    w(nb(_7725,num),_7817,_7802,_7834),
    !,
    pushstack(first,w(nb(_7725,num)),nil,_7834,_7864),noun_phrase1(_7698,_7702::_7703,_7851,_7864,_7879),
    !,
    accept(_7899,_7879,_7765).

whichf(_7698,which(_7698),[whichf,_7739],_7722,_7724) --> 
    which2(_7739,_7722,_7724).

whichg00(_7698,_7699,_7709:_7698,which(_7709):::_7709 isa _7698 and _7699,[whichg00,[]],_7740,_7740) --> 
    [].

qstatement(_7698,_7701:::_7702,[qstatement,{},_7760],_7733,_7735) --> 
    {user:which_thing(_7698,_7701)},
    statreal(_7702,_7760,_7733,_7735).

what_phrase(_7702:thing,which(_7702:thing),_7702 isa thing,[what_phrase,lit(hva)],_7736,_7738) --> 
    cc(hva,_7736,_7738).

whatq(_7698,[whatq,lit(hva),_7818,_7847,_7881,_7915,_7944,!,_7973,_7997],_7793,_7795) --> 
    cc(hva,_7793,_7817),
    w(verb(use,_7746,fin),_7818,_7817,_7835),
    subject(_7749,_7750,_7847,_7835,_7866),
    np1_accept(_7752,_7753,_7881,_7866,_7900),
    prep1(_7755,_7915,_7900,_7932),
    not_look_ahead_np(_7944,_7932,_7959),
    !,
    accept(_7973,_7959,_7988),
    pushstack(first,(xnp(_7749,_7750),w(verb(use,_7746,fin)),np(_7752,_7753),w(prep(_7755)),npgap(_7739)),nil,_7988,_8099),
    qstatement(_7739,_7698,_7997,_8099,_7795).

whatq(which(_7704):::_7703 ako _7704,[whatq,{},_7778,_7802,_7826,_7855,!],_7754,_7756) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_7778,_7754,_7793),
    art1(_7802,_7793,_7817),
    w(noun(_7703,_7733,u,n),_7826,_7817,_7843),
    endofline(_7855,_7843,_7756),
    !.

whatq(which(_7704):::_7703 ako _7704,[whatq,{},_7792,_7816,{},_7855],_7768,_7770) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_7792,_7768,_7807),
    w(noun(_7703,_7730,u,n),_7816,_7807,_7833),
    {user:(\+testmember(_7703,[clock,special_ticket,price,bus,station]))},
    endofline(_7855,_7833,_7770).

whatq(_7698,[whatq,{},_7782,_7806,_7835,!,_7864],_7758,_7760) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_7782,_7758,_7797),
    look_ahead(w(name(_7735,_7736,_7737)),_7806,_7797,_7823),
    redundant0(_7835,_7823,_7850),
    !,
    pushstack(first,w(verb(describe,imp,fin)),nil,_7850,_7874),
    command(_7698,_7864,_7874,_7760).

whatq(which(_7705:thing):::_7701,[whatq,lit(hva),_7814,_7858,_7892,_7926,_7960],_7789,_7791) --> 
    cc(hva,_7789,_7813),
    lexv(tv,_7740,_7741,fin,_7814,_7813,_7837),
    gmem(_7740,[hold,keep,drive,operate],_7858,_7837,_7877),
    subject(_7755,_7756,_7892,_7877,_7911),
    particlev2(_7740,_7759,_7926,_7911,_7945),
    pushstack(first,(xnp(_7755,_7756),w(verb(_7759,pres,fin)),npgap(_7705:thing)),nil,_7945,_8032),
    statreal(_7701,_7960,_8032,_7791).

whatq(_7700:::_7701,[whatq,{},lit(hva),_7851,_7875,_7909,_7938,lit(kunne),_7993,!,_8027],_7816,_7818) --> 
    {user:which_thing(_7748,_7700)},
    cc(hva,_7816,_7850),
    has(_7851,_7850,_7866),
    subject(_7757,_7758,_7875,_7866,_7894),
    w(verb(expect,past,part),_7909,_7894,_7926),
    optional([at],_7938,_7926,_7970),
    cc(kunne,_7970,_7992),
    w(verb(_7774,_7775,pass),_7993,_7992,_8010),
    !,
    pushstack(first,(xnp(_7757,_7758),w(verb(expect,past,fin)),[at],[noen],w(verb(_7774,pres,fin)),npgap(_7748)),nil,_8010,_8098),
    statreal(_7701,_8027,_8098,_7818).

whatq(_7700:::_7703 and _7704,[whatq,_7787,_7826,_7850,_7879,!,_7918],_7773,_7775) --> 
    what_phrase(_7730,_7700,_7703,_7787,_7773,_7808),
    paux0(_7826,_7808,_7841),
    w(verb(_7738,_7739,pass),_7850,_7841,_7867),
    whodidit(_7742,_7743,_7879,_7867,_7898),
    !,
    pushstack(first,(xnp(_7742,_7743),w(verb(_7738,_7739,fin)),npgap(_7730)),nil,_7898,_7989),
    statreal(_7704,_7918,_7989,_7775).

whatq(_7700:::_7703 and _7704,[whatq,_7824,_7863,{},_7917,_7951,_7985,!,_8024,[],_8097],_7810,_7812) --> 
    what_phrase(_7748,_7700,_7703,_7824,_7810,_7845),
    lexv(rv,_7753,_7754,fin,_7863,_7845,_7886),
    {user:(\+testmember(_7753,[]))},
    subject(_7764,_7765,_7917,_7886,_7936),
    that0(_7753,that,_7951,_7936,_7970),
    subject(_7745,_7746,_7985,_7970,_8004),
    !,
    negation0(_7773,_8024,_8004,_8041),
    pushstack(free,npgap(_7748),nil,_8041,_8096),[],
    pushstack(first,(xnp(_7764,_7765),w(verb(_7753,pres,fin)),[at],xnp(_7745,_7746)),nil,_8096,_8169),
    statreal(_7704,_8097,_8169,_7812).

whatq(_7700:::_7703 and _7704,[whatq,_7787,_7826,lit(det),_7866,_7910,!,_7949],_7773,_7775) --> 
    what_phrase(_7730,_7700,_7703,_7787,_7773,_7808),
    w(verb(be,_7739,fin),_7826,_7808,_7843),
    cc(det,_7843,_7865),
    optional([som],_7866,_7865,_7898),
    specific_phrase(_7748,_7749,_7910,_7898,_7929),
    !,
    pushstack(free,(xnp(_7748,_7749),npgap(_7730)),nil,_7929,_8020),
    statreal(_7704,_7949,_8020,_7775).

whatq(which(_7705:thing):::_7701,[whatq,lit(hva),_7814,_7858,_7882,_7916,_7945,_7974],_7789,_7791) --> 
    cc(hva,_7789,_7813),
    lexv(rv,_7746,_7747,fin,_7814,_7813,_7837),
    look_ahead_subject(_7858,_7837,_7873),
    np0_accept(_7750,_7751,_7882,_7873,_7901),
    negation0(_7753,_7916,_7901,_7933),
    prepnom(_7755,_7945,_7933,_7962),
    pushstack(first,(xnp(_7750,_7751),w(verb(_7746,pres,fin)),w(prep(_7755)),npgap(_7705:thing)),nil,_7962,_8048),
    statreal(_7701,_7974,_8048,_7791).

whatq(_7700:::_7703 and _7704,[whatq,_7815,_7854,{},_7908,_7942,_7971,_8000,_8029],_7801,_7803) --> 
    what_phrase(_7736,_7700,_7703,_7815,_7801,_7836),
    lexv(tv,do,_7744,fin,_7854,_7836,_7877),
    {user:(\+testmember(do,[cost,be2,have]))},
    subject(_7760,_7761,_7908,_7877,_7927),
    not_look_ahead([at],_7942,_7927,_7959),
    not_look_ahead([å],_7971,_7959,_7988),
    negation0(_7771,_8000,_7988,_8017),
    pushstack(first,(xnp(_7760,_7761),w(verb(do,pres,fin)),npgap(_7736)),nil,_8017,_8100),
    statreal(_7704,_8029,_8100,_7803).

whatq(_7700:::_7701,[whatq,{},lit(hva),_7811,_7835,_7869,!,_7903],_7776,_7778) --> 
    {user:which_thing(_7730,_7700)},
    cc(hva,_7776,_7810),
    has(_7811,_7810,_7826),
    subject(_7739,_7740,_7835,_7826,_7854),
    w(verb(_7744,past,part),_7869,_7854,_7886),
    !,
    pushstack(first,(xnp(_7739,_7740),w(verb(_7744,past,fin)),npgap(_7730)),nil,_7886,_7974),
    statreal(_7701,_7903,_7974,_7778).

whatq(_7700:::_7701,[whatq,{},lit(hva),_7846,_7870,_7904,_7958,!,_7992,_8109],_7811,_7813) --> 
    {user:which_thing(_7741,_7700)},
    cc(hva,_7811,_7845),
    has(_7846,_7845,_7861),
    subject(_7746,_7747,_7870,_7861,_7889),
    noun(_7749,_7750,_7751,_7752,_7736,_7754,_7904,_7889,_7931),
    prepnom(_7756,_7958,_7931,_7975),
    !,
    lock(exact,_7975,_8073),pushstack(exact,(noun(_7749,_7750,_7751,_7752,_7736,_7754),w(prep(_7756)),npgap(_7741)),nil,_8073,_8079),np1(_7736,_7737,_7992,_8079,_8068),unlock(_8068,_8069),
    pushstack(first,(xnp(_7746,_7747),w(verb(have,pres,fin)),xnp(_7736,_7737)),nil,_8069,_8181),
    statreal(_7701,_8109,_8181,_7813).

whatq(which(_7705:thing):::_7701,[whatq,lit(hva),_7831,{},lit(det),_7881,lit(å),_7916,!,_7964],_7806,_7808) --> 
    cc(hva,_7806,_7830),
    w(verb(_7750,_7751,fin),_7831,_7830,_7848),
    {user:testmember(_7750,[cost])},
    cc(det,_7848,_7880),
    for0(_7881,_7880,_7896),
    cc(å,_7896,_7915),
    pushstack(first,([noen],[vil]),nil,_7915,_7929),clausal_object1(_7773,_7774,_7916,_7929,_7944),
    !,
    pushstack(first,(xnp(_7773,_7774),w(verb(_7750,pres,fin)),npgap(_7705:thing)),nil,_7944,_8038),
    statreal1(_7701,_7964,_8038,_7808).

for0([for0,lit(for),!],_7718,_7720) --> 
    cc(for,_7718,_7720),
    !.

for0([for0,[]],_7713,_7713) --> 
    [].

whatq(_7700:::_7701,[whatq,lit(hva),_7842,{},lit(det),_7892,!,_7926,{},_7960,_8016],_7817,_7819) --> 
    cc(hva,_7817,_7841),
    w(verb(_7745,_7746,fin),_7842,_7841,_7859),
    {user:testmember(_7745,[cost,weigh])},
    cc(det,_7859,_7891),
    look_ahead(w(prep(_7764)),_7892,_7891,_7909),
    !,
    accept(_7926,_7909,_7941),
    {user:which_thing(_7739,_7700)},
    lock(exact,_7941,_7980),pushstack(exact,w(noun(ticket,sin,u,n)),nil,_7980,_7986),noun_phrase1(_7781,_7784::_7785,_7960,_7986,_7975),unlock(_7975,_7976),
    pushstack(first,(noun_phrase1(_7781,_7784::_7785),lexv(tv,_7745,_7746,fin),npgap(_7739)),nil,_7976,_8121),
    statreal(_7701,_8016,_8121,_7819).

whatq(_7700:::_7703 and _7704,[whatq,_7803,_7842,_7871,_7905,{},!,_7954],_7789,_7791) --> 
    what_phrase(_7733,_7700,_7703,_7803,_7789,_7824),
    w(verb(_7741,_7742,fin),_7842,_7824,_7859),
    gmem(_7741,[cost,weigh],_7871,_7859,_7890),
    np1_accept(_7752,_7753,_7905,_7890,_7924),
    {user:(\+constrain(_7752,place))},
    !,
    pushstack(first,(xnp(_7752,_7753),lexv(tv,_7741,_7742,fin),npgap(_7733)),nil,_7924,_8058),
    statreal(_7704,_7954,_8058,_7791).

whatq(_7700:::_7703 and _7704,[whatq,_7756,_7795,_7834],_7742,_7744) --> 
    what_phrase(_7712,_7700,_7703,_7756,_7742,_7777),
    realcomp(_7714,_7715,_7704,_7795,_7777,_7816),
    qverb_phrase(_7712,id,_7714,_7715,_7834,_7816,_7744).

whatq(which(_7705:thing):::_7701,[whatq,_7787,lit(det),_7822,_7851,_7885,!,_7919],_7773,_7775) --> 
    whatbe(_7787,_7773,_7802),
    cc(det,_7802,_7821),
    not_look_ahead(w(adj2(_7743,nil)),_7822,_7821,_7839),
    subject(_7746,_7747,_7851,_7839,_7870),
    negation0(_7749,_7885,_7870,_7902),
    !,
    pushstack(free,(xnp(_7746,_7747),npgap(_7705:thing)),nil,_7902,_7993),
    statement(_7701,_7919,_7993,_7775).

whatq(_7698,[whatq,_7809,_7833,_7857,_7881,_7910,{},!,_7954],_7795,_7797) --> 
    whatbe(_7809,_7795,_7824),
    so0(_7833,_7824,_7848),
    dent0(_7857,_7848,_7872),
    not_look_ahead(w(nb(_7742,_7743)),_7881,_7872,_7898),
    w(adj2(_7735,nil),_7910,_7898,_7927),
    {user:(\+testmember(_7735,[near,nearest,next]))},
    !,
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin)),w(adj2(_7735,nil))),nil,_7927,_7995),
    whichq(_7698,_7954,_7995,_7797).

whatq(which(_7703):::_7701,[whatq,_7759,_7783,_7807,!,_7841,_7875],_7745,_7747) --> 
    whatbe(_7759,_7745,_7774),
    thereit(_7783,_7774,_7798),
    prep1(for,_7807,_7798,_7824),
    !,
    noun_phrase1(_7703,true::_7701,_7841,_7824,_7860),
    danow0(_7875,_7860,_7747).

whatq(which(_7703):::_7701,[whatq,_7803,lit(det),lit(som),!,_7854,_7878,_7912,_7968],_7789,_7791) --> 
    whatbe(_7803,_7789,_7818),
    cc(det,_7818,_7837),
    cc(som,_7837,_7848),
    !,
    accept(_7854,_7848,_7869),
    np(_7742,_7745::_7746,_7878,_7869,_7897),
    lock(exact,_7897,_7932),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7932,_7938),np(_7703,_7735::_7736,_7912,_7938,_7927),unlock(_7927,_7928),
    pushstack(free,(np(_7742,_7745::_7746),np(_7703,_7735::_7736)),nil,_7928,_8046),
    statreal(_7701,_7968,_8046,_7791).

whatq(which(_7703):::_7701,[whatq,_7783,_7807,_7836,_7865,_7908,!,_7937],_7769,_7771) --> 
    whatbe(_7783,_7769,_7798),
    w(noun(time,_7726,_7727,n),_7807,_7798,_7824),
    look_ahead(w(prep(_7734)),_7836,_7824,_7853),
    pushstack(first,w(noun(departure,sin,u,n)),nil,_7853,_7878),noun_phrase1(_7703,true::_7701,_7865,_7878,_7893),
    danow0(_7908,_7893,_7923),
    !,
    accept(_7937,_7923,_7771).

whatq(_7700:::_7701,[whatq,{},_7803,lit(det),_7838,_7867,_7901,!,_7935],_7779,_7781) --> 
    {user:which_thing(_7730,_7700)},
    whatbe(_7803,_7779,_7818),
    cc(det,_7818,_7837),
    not_look_ahead(w(adj2(_7743,nil)),_7838,_7837,_7855),
    noun_phrase1(_7746,_7749::_7750,_7867,_7855,_7886),
    negation0(_7752,_7901,_7886,_7918),
    !,
    pushstack(free,(np(_7746,_7749::_7750),npgap(_7730)),nil,_7918,_8009),
    statement(_7701,_7935,_8009,_7781).

whatq(which(_7705:thing):::_7701,[whatq,_7800,_7824,_7853,_7882,_7916,_7940,!,_7969],_7786,_7788) --> 
    whatbe(_7800,_7786,_7815),
    not_look_ahead([det],_7824,_7815,_7841),
    not_look_ahead(w(name(_7751,n,_7753)),_7853,_7841,_7870),
    np(_7755,_7756,_7882,_7870,_7901),
    danow0(_7916,_7901,_7931),
    endofline(_7940,_7931,_7955),
    !,
    lock(exact,_7955,_8050),
    pushstack(exact,(xnp(_7755,_7756),w(verb(be,pres,fin)),npgap(_7705:thing)),nil,_8050,_8056),
    statreal(_7701,_7969,_8056,_8045),
    unlock(_8045,_7788).

whatq(which(_7703):::_7701,[whatq,_7766,_7790,_7819,_7848,_7882],_7752,_7754) --> 
    whatbe(_7766,_7752,_7781),
    not_look_ahead([det],_7790,_7781,_7807),
    not_look_ahead(w(name(_7725,n,_7727)),_7819,_7807,_7836),
    np1_accept(_7703,true::_7701,_7848,_7836,_7867),
    danow0(_7882,_7867,_7754).

whatq(which(_7705:thing):::_7701,[whatq,_7806,_7830,_7864,_7893,!,_7927],_7792,_7794) --> 
    whatbe(_7806,_7792,_7821),
    noun_phrase1(_7743,_7744,_7830,_7821,_7849),
    w(verb(_7748,past,part),_7864,_7849,_7881),
    prep(_7752,_7893,_7881,_7910),
    !,
    pushstack(first,(noun_phrase1(_7743,_7744),w(verb(be,pres,fin)),w(verb(_7748,past,part)),w(prep(_7752)),npgap(_7705:thing)),nil,_7910,_8001),
    statement(_7701,_7927,_8001,_7794).

whatq(_7698,[whatq,_7758,_7782],_7744,_7746) --> 
    whatbe(_7758,_7744,_7773),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin))),nil,_7773,_7820),
    whichq(_7698,_7782,_7820,_7746).

whatq(_7698,[whatq,lit(hva),_7817,_7841,_7875,_7904,!,_7938,_7962],_7792,_7794) --> 
    cc(hva,_7792,_7816),
    aux1(_7817,_7816,_7832),
    np1_accept(_7740,_7743::_7744,_7841,_7832,_7860),
    w(verb(use,_7749,pass),_7875,_7860,_7892),
    prep1(_7752,_7904,_7892,_7921),
    !,
    accept(_7938,_7921,_7953),
    pushstack(first,([noen],w(verb(use,_7749,fin)),np(_7740,_7743::_7744),w(prep(_7752)),npgap(_7736)),nil,_7953,_8036),
    qstatement(_7736,_7698,_7962,_8036,_7794).

whatq(_7698,[whatq,lit(hva),_7814,_7843,_7877,!,_7911,_7935],_7789,_7791) --> 
    cc(hva,_7789,_7813),
    w(verb(use,_7740,pass),_7814,_7813,_7831),
    np1_accept(_7743,_7746::_7747,_7843,_7831,_7862),
    prep1(_7749,_7877,_7862,_7894),
    !,
    accept(_7911,_7894,_7926),
    pushstack(first,([noen],w(verb(use,_7740,fin)),np(_7743,_7746::_7747),w(prep(_7749)),npgap(_7733)),nil,_7926,_8009),
    qstatement(_7733,_7698,_7935,_8009,_7791).

whatq(which(_7705:thing):::_7701,[whatq,_7822,_7846,_7880,_7904,_7933,_7962,_7991,{},!,_8035],_7808,_7810) --> 
    whatcan(_7822,_7808,_7837),
    subject(_7752,_7753,_7846,_7837,_7865),
    redundant0(_7880,_7865,_7895),
    negation0(_7755,_7904,_7895,_7921),
    w(verb(_7759,_7760,_7761),_7933,_7921,_7950),
    reflexiv0(_7759,_7962,_7950,_7979),
    prepnom(_7765,_7991,_7979,_8008),
    {user:testmember(_7765,[regarding,with])},
    !,
    pushstack(first,(xnp(_7752,_7753),w(verb(_7759,_7760,_7761)),w(prep(_7765)),npgap(_7705:thing)),nil,_8008,_8109),
    statreal(_7701,_8035,_8109,_7810).

whatq(_7700:::_7701,[whatq,_7791,{},_7825,_7859,lit(om),!,_7904],_7777,_7779) --> 
    whatcan(_7791,_7777,_7806),
    {user:which_thing(_7737,_7700)},
    specific_phrase(_7740,_7741,_7825,_7806,_7844),
    negation0(_7743,_7859,_7844,_7876),
    cc(om,_7876,_7898),
    !,
    pushstack(first,(noun_phrase1(_7740,_7741),w(verb(know1,pres,fin)),npgap(_7737),[om]),nil,_7898,_7975),
    statreal(_7701,_7904,_7975,_7779).

whatq(_7700:::_7701,[whatq,_7832,{},_7866,_7900,_7929,_7958,lit(_7764),{},_8008,!,_8042],_7818,_7820) --> 
    whatcan(_7832,_7818,_7847),
    {user:which_thing(_7742,_7700)},
    specific_phrase(_7749,_7752::_7753,_7866,_7847,_7885),
    negation0(_7755,_7900,_7885,_7917),
    w(verb(_7759,_7760,_7761),_7929,_7917,_7946),
    reflexiv0(_7759,_7958,_7946,_7975),
    cc(_7764,_7975,_7997),
    {user:testmember(_7764,[på,om,til])},
    not_look_ahead(w(noun(_7782,_7783,_7784,_7785)),_8008,_7997,_8025),
    !,
    pushstack(first,(noun_phrase1(_7749,_7752::_7753),w(verb(_7759,_7760,_7761)),npgap(_7742)),nil,_8025,_8116),
    statreal(_7701,_8042,_8116,_7820).

whatq(_7700:::_7701,[whatq,_7825,{},_7859,_7893,_7922,_7951,lit(om),_7991,!,_8030],_7811,_7813) --> 
    whatcan(_7825,_7811,_7840),
    {user:which_thing(_7750,_7700)},
    specific_phrase(_7753,_7756::_7757,_7859,_7840,_7878),
    negation0(_7759,_7893,_7878,_7910),
    w(verb(_7763,_7764,_7765),_7922,_7910,_7939),
    reflexiv0(_7763,_7951,_7939,_7968),
    cc(om,_7968,_7990),
    noun_phrase1(_7745,_7746,_7991,_7990,_8010),
    !,
    pushstack(first,(noun_phrase1(_7753,_7756::_7757),w(verb(_7763,_7764,_7765)),npgap(_7750),w(prep(regarding)),np(_7745,_7746)),nil,_8010,_8135),
    statreal(_7701,_8030,_8135,_7813).

whatq(_7700:::_7701,[whatq,_7825,{},_7859,_7893,_7922,_7966,_8000,!,_8034],_7811,_7813) --> 
    whatcan(_7825,_7811,_7840),
    {user:which_thing(_7742,_7700)},
    specific_phrase(_7749,_7752::_7753,_7859,_7840,_7878),
    negation0(_7755,_7893,_7878,_7910),
    lexv(tv,_7758,_7759,_7760,_7922,_7910,_7945),
    np1(_7762,_7765::_7766,_7966,_7945,_7985),
    prepnom(_7768,_8000,_7985,_8017),
    !,
    pushstack(first,(noun_phrase1(_7749,_7752::_7753),w(verb(_7758,_7759,_7760)),np1(_7762,_7765::_7766),w(prep(_7768)),npgap(_7742)),nil,_8017,_8139),
    statreal(_7701,_8034,_8139,_7813).

whatq(_7700:::_7701,[whatq,_7826,_7850,_7884,_7913,_7942,_7976,!,{},_8020],_7812,_7814) --> 
    whatcan(_7826,_7812,_7841),
    specific_phrase(_7748,_7751::_7752,_7850,_7841,_7869),
    negation0(_7754,_7884,_7869,_7901),
    w(verb(_7758,_7759,_7760),_7913,_7901,_7930),
    noun_phrase1(_7742,_7745::_7746,_7942,_7930,_7961),
    prepnom(_7768,_7976,_7961,_7993),
    !,
    {user:which_thing(_7772,_7700)},
    pushstack(first,(noun_phrase1(_7748,_7751::_7752),w(verb(_7758,_7759,_7760)),npgap(_7772),w(prep(_7768)),np(_7742,_7745::_7746)),nil,_7993,_8128),
    statreal(_7701,_8020,_8128,_7814).

whatq(_7700:::_7701,[whatq,_7798,{},_7832,_7866,_7895,!,_7929],_7784,_7786) --> 
    whatcan(_7798,_7784,_7813),
    {user:which_thing(_7730,_7700)},
    specific_phrase(_7737,_7740::_7741,_7832,_7813,_7851),
    negation0(_7743,_7866,_7851,_7883),
    not_look_ahead(w(verb(_7749,_7750,_7751)),_7895,_7883,_7912),
    !,
    pushstack(first,(noun_phrase1(_7737,_7740::_7741),w(verb(do1,pres,fin)),npgap(_7730)),nil,_7912,_8003),
    statreal(_7701,_7929,_8003,_7786).

whatq(_7700:::_7701,[whatq,_7801,{},_7835,_7869,_7898,_7927,!,_7961],_7787,_7789) --> 
    whatcan(_7801,_7787,_7816),
    {user:which_thing(_7733,_7700)},
    specific_phrase(_7740,_7743::_7744,_7835,_7816,_7854),
    negation0(_7746,_7869,_7854,_7886),
    w(verb(_7750,_7751,_7752),_7898,_7886,_7915),
    reflexiv0(_7750,_7927,_7915,_7944),
    !,
    pushstack(first,(noun_phrase1(_7740,_7743::_7744),w(verb(_7750,_7751,_7752)),npgap(_7733)),nil,_7944,_8035),
    statreal(_7701,_7961,_8035,_7789).

whatq(_7700:::_7701,[whatq,lit(hva),{},_7813,_7842,!,_7881],_7778,_7780) --> 
    cc(hva,_7778,_7802),
    {user:which_thing(_7727,_7700)},
    w(verb(know,_7739,fin),_7813,_7802,_7830),
    specific_phrase(_7742,_7745::_7746,_7842,_7830,_7861),
    !,
    pushstack(first,(noun_phrase1(_7742,_7745::_7746),lexv(tv,know1,_7739,fin),npgap(_7727)),nil,_7861,_7986),
    statreal(_7701,_7881,_7986,_7780).

whatq(_7698,[whatq,lit(hva),_7768,_7792],_7743,_7745) --> 
    cc(hva,_7743,_7767),
    do(_7768,_7767,_7783),
    pushstack(first,(which,w(noun(thing,sin,u,n)),do),nil,_7783,_7861),
    whichq(_7698,_7792,_7861,_7745).

whatq(_7698,[whatq,lit(hva),_7790,!,_7839,_7863,_7892],_7765,_7767) --> 
    cc(hva,_7765,_7789),
    lexv(iv,_7726,_7734,fin,_7790,_7789,_7813),
    !,
    accept(_7839,_7813,_7854),
    negation0(_7737,_7863,_7854,_7880),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(_7726,pres,fin))),nil,_7880,_7930),
    whichq(_7698,_7892,_7930,_7767).

whenq(which(_7703):::_7701,[whenq,_7772,_7811,lit(det),_7846,!,_7875],_7758,_7760) --> 
    when_adverbialq(_7723,_7703,_7727::_7728,_7772,_7758,_7793),
    be(_7811,_7793,_7826),
    cc(det,_7826,_7845),
    that0(_7846,_7845,_7861),
    !,
    pushstack(free,xadverbial1(_7723,_7703,_7727::_7728),nil,_7861,_7916),
    statreal(_7701,_7875,_7916,_7760).

whenq(which(_7703):::_7701,[whenq,_7776,_7815,!,_7849,_7873],_7762,_7764) --> 
    when_adverbialq(_7720,_7703,_7724::_7725,_7776,_7762,_7797),
    look_ahead(w(noun(bus,_7739,_7740,n)),_7815,_7797,_7832),
    !,
    accept(_7849,_7832,_7864),
    pushstack(free,xadverbial1(_7720,_7703,_7724::_7725),nil,_7864,_7918),
    statreal(_7701,_7873,_7918,_7764).

whenq(which(_7703):::_7701,[whenq,_7810,_7849,_7878,{},!,_7922],_7796,_7798) --> 
    when_adverbialq(_7729,_7703,_7733::_7734,_7810,_7796,_7831),
    w(verb(go,_7746,fin),_7849,_7831,_7866),
    look_ahead(w(prep(_7753)),_7878,_7866,_7895),
    {user:testmember(_7753,[from,to])},
    !,
    pushstack(free,(w(noun(bus,sin,u,n)),w(verb(go,_7746,fin)),xadverbial1(_7729,_7703,_7733::_7734)),nil,_7895,_7967),
    statreal(_7701,_7922,_7967,_7798).

whenq(which(_7703):::_7701,[whenq,_7785,_7824,_7848,_7872,!,_7911,_7935,_7964],_7771,_7773) --> 
    when_adverbialq(_7728,_7703,_7737::_7738,_7785,_7771,_7806),
    be(_7824,_7806,_7839),
    detnexttime(_7848,_7839,_7863),
    np1(_7726,_7743::_7744,_7872,_7863,_7891),
    !,
    accept(_7911,_7891,_7926),
    negation0(_7746,_7935,_7926,_7952),
    whencomplex(_7726,_7743::_7744,_7728,_7703,_7737::_7738,_7701,_7964,_7952,_7773).

whenq(which(_7703):::_7701,[whenq,_7763,_7787,{},!,_7831],_7749,_7751) --> 
    when(_7763,_7749,_7778),
    look_ahead(w(prep(_7721)),_7787,_7778,_7804),
    {user:testmember(_7721,[from,to])},
    !,
    reject(_7831,_7804,_7751).

whenq(which(_7703):::_7701,[whenq,_7828,_7852,_7891,!,_7935,_7959,!,_8043,_8067],_7814,_7816) --> 
    when(_7828,_7814,_7843),
    preadverbial1(_7745,_7746,_7749::_7750,_7852,_7843,_7873),
    preadverbial1(_7738,_7739,_7742::_7743,_7891,_7873,_7912),
    !,
    accept(_7935,_7912,_7950),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_7950,_8003),adverbial1(_7772,_7703,_7776::_7777,_7959,_8003,_8020),
    !,
    accept(_8043,_8020,_8058),
    lock(last,_8058,_8185),
    pushstack(last,(adverbial1(in,_7703,_7776::_7777),adverbial1(_7745,_7746,_7749::_7750),adverbial1(_7738,_7739,_7742::_7743)),nil,_8185,_8191),
    question0(_7701,_8067,_8191,_8180),
    unlock(_8180,_7816).

whenq(which(_7703):::_7701,[whenq,_7815,_7839,_7868,!,_7912,_7936,!,_8019,_8043],_7801,_7803) --> 
    when(_7815,_7801,_7830),
    not_look_ahead([e],_7839,_7830,_7856),
    adverbial1(_7735,_7736,_7739::_7740,_7868,_7856,_7889),
    !,
    accept(_7912,_7889,_7927),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_7927,_7979),adverbial1(_7766,_7703,_7770::_7771,_7936,_7979,_7996),
    !,
    accept(_8019,_7996,_8034),
    lock(last,_8034,_8126),
    pushstack(last,(xadverbial1(in,_7703,_7770::_7771),xadverbial1(_7735,_7736,_7739::_7740)),nil,_8126,_8132),
    question0(_7701,_8043,_8132,_8121),
    unlock(_8121,_7803).

whenq(which(_7703):::_7701,[whenq,_7795,_7819,!,_7863,!,_7959],_7781,_7783) --> 
    when(_7795,_7781,_7810),
    adverb(_7726,_7727,pre,_7819,_7810,_7840),
    !,
    lock(exact,_7840,_7913),pushstack(exact,(prep(in),w(noun(time,sin,u,n))),nil,_7913,_7919),adverbial1(_7746,_7703,_7750::_7751,_7863,_7919,_7908),unlock(_7908,_7909),
    !,
    pushstack(free,(xadverbial1(in,_7703,_7750::_7751),xadverb(_7726,_7727)),nil,_7909,_8035),
    question0(_7701,_7959,_8035,_7783).

whenq(which(_7703):::_7701,[whenq,_7807,_7846,{},_7885,_7909,!,_7943],_7793,_7795) --> 
    howlongto(_7732,_7703,_7736::_7737,_7807,_7793,_7828),
    w(adj2(_7748,nil),_7846,_7828,_7863),
    {user:testmember(_7748,[easy,possible,good])},
    infinitive(_7885,_7863,_7900),
    w(verb(_7764,inf,fin),_7909,_7900,_7926),
    !,
    lock(last,_7926,_8023),
    pushstack(last,(someone,w(verb(_7764,pres,fin)),adverbial1(_7732,_7703,_7736::_7737)),nil,_8023,_8029),
    statement(_7701,_7943,_8029,_8018),
    unlock(_8018,_7795).

whenq(which(_7703):::_7701,[whenq,_7779,_7818,!,_7852],_7765,_7767) --> 
    howlongto(_7720,_7703,_7724::_7725,_7779,_7765,_7800),
    w(verb(_7736,_7737,fin),_7818,_7800,_7835),
    !,
    lock(last,_7835,_7904),
    pushstack(last,(w(verb(_7736,pres,fin)),adverbial1(_7720,_7703,_7724::_7725)),nil,_7904,_7910),
    statement(_7701,_7852,_7910,_7899),
    unlock(_7899,_7767).

whenq(which(_7703):::_7701,[whenq,_7773,!,_7817,_7890,_7919],_7759,_7761) --> 
    when_adverbialq(_7719,_7703,_7723::_7724,_7773,_7759,_7794),
    !,
    pushstack(free,xadverbial1(_7719,_7703,_7723::_7724),nil,_7794,_7865),question0(_7701,_7817,_7865,_7878),
    not_look_ahead([a],_7890,_7878,_7907),
    prep0(_7717,_7919,_7907,_7761).

detnexttime([detnexttime,lit(det),_7746,_7770,!],_7724,_7726) --> 
    cc(det,_7724,_7745),
    nexttime0(_7746,_7745,_7761),
    that0(_7770,_7761,_7726),
    !.

detnexttime([detnexttime,_7730,_7754,!],_7719,_7721) --> 
    nexttime(_7730,_7719,_7745),
    that0(_7754,_7745,_7721),
    !.

detnexttime([detnexttime,lit(at),!],_7718,_7720) --> 
    cc(at,_7718,_7720),
    !.

nexttime0([nexttime0,_7724],_7713,_7715) --> 
    nexttime(_7724,_7713,_7715).

nexttime0([nexttime0,[]],_7713,_7713) --> 
    [].

nexttime([nexttime,_7736,_7765],_7725,_7727) --> 
    w(adj2(next,nil),_7736,_7725,_7753),
    optional([gang],_7765,_7753,_7727).

whencomplex(_7698,_7705::_7706,_7700,_7701,_7708::_7709,_7703,[whencomplex,_7815,_7839,!,_7873,_7897],_7786,_7788) --> 
    do0(_7815,_7786,_7830),
    w(verb(_7741,_7742,finy),_7839,_7830,_7856),
    !,
    accept(_7873,_7856,_7888),
    pushstack(free,(np(_7698,_7705::_7706),w(verb(_7741,pres,fin)),adverbial1(_7700,_7701,_7708::_7709)),nil,_7888,_7976),
    statreal(_7703,_7897,_7976,_7788).

whencomplex(_7698,_7705::_7706,_7700,_7701,_7708::_7709,_7703,[whencomplex,_7797],_7768,_7770) --> 
    pushstack(free,(np(_7698,_7705::_7706),w(verb(be,pres,fin)),adverbial1(_7700,_7701,_7708::_7709)),nil,_7768,_7876),
    statreal(_7703,_7797,_7876,_7770).

verb0(_7698,[verb0,_7743,!,_7777],_7729,_7731) --> 
    w(verb(_7698,_7709,_7710),_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

verb0(be1,[verb0,[]],_7717,_7717) --> 
    [].

subjectverb(_7698,_7699,_7700,[subjectverb,_7758,_7787,!],_7738,_7740) --> 
    w(verb(_7700,_7711,fin),_7758,_7738,_7775),
    subject(_7698,_7699,_7787,_7775,_7740),
    !.

subjectverb(_7698,_7699,_7700,[subjectverb,_7758,_7782,_7816],_7738,_7740) --> 
    aux1(_7758,_7738,_7773),
    subject(_7698,_7699,_7782,_7773,_7801),
    w(verb(_7700,inf,fin),_7816,_7801,_7740).

whereq(which(_7703):::_7701,[whereq,_7822,_7846,_7885,_7914,_7938,_7967,!,_8006,_8030,!,_8059,[],_8129,!,_8203],_7808,_7810) --> 
    dummyprep0(_7822,_7808,_7837),
    where_adverbial(_7747,_7703,_7749,_7846,_7837,_7867),
    w(verb(_7753,_7754,fin),_7885,_7867,_7902),
    thereit0(_7914,_7902,_7929),
    not_look_ahead(w(nb(_7761,_7762)),_7938,_7929,_7955),
    subject(_7764,_7765,_7967,_7955,_7986),
    !,
    accept(_8006,_7986,_8021),
    dummyprep0(_8030,_8021,_8045),
    !,
    accept(_8059,_8045,_8074),
    pushstack(free,adverbial1(_7747,_7703,_7749),nil,_8074,_8128),[],
    pushstack(first,(xnp(_7764,_7765),w(verb(_7753,_7754,fin))),nil,_8128,_8173),substatement1(_7701,_8129,_8173,_8186),
    !,
    accept(_8203,_8186,_7810).

whereq(which(_7703):::_7701,[whereq,{},_7818,_7842,!,_7876,!,_7942,_8011],_7794,_7796) --> 
    {user:(\+value(dialog,1))},
    where(_7818,_7794,_7833),
    w(verb(go,_7736,fin),_7842,_7833,_7859),
    !,
    lock(exact,_7859,_7896),pushstack(exact,w(noun(place,sin,u,n)),nil,_7896,_7902),adverbial1(nil,_7703,_7753::_7754,_7876,_7902,_7891),unlock(_7891,_7892),
    !,
    pushstack(free,(w(verb(go,pres,fin)),adverbial1(nil,_7703,_7753::_7754)),nil,_7892,_7986),ynq(_7701,_7942,_7986,_7999),
    dummyprep0(_8011,_7999,_7796).

whereq(which(_7703):::_7701,[whereq,_7811,_7835,_7864,!,_7908,!,_8004],_7797,_7799) --> 
    where(_7811,_7797,_7826),
    not_look_ahead(w(prep(after)),_7835,_7826,_7852),
    adverbial1(_7729,_7730,_7733::_7734,_7864,_7852,_7885),
    !,
    lock(exact,_7885,_7958),pushstack(exact,(prep(in),w(noun(place,sin,u,n))),nil,_7958,_7964),adverbial1(_7762,_7703,_7766::_7767,_7908,_7964,_7953),unlock(_7953,_7954),
    !,
    pushstack(free,(adverbial1(in,_7703,_7766::_7767),adverbial1(_7729,_7730,_7733::_7734)),nil,_7954,_8084),
    question0(_7701,_8004,_8084,_7799).

whereq(which(_7703):::_7701,[whereq,_7796,_7835,lit(det),_7870,!,[],_7953],_7782,_7784) --> 
    where_adverbial(_7737,_7703,_7741::_7742,_7796,_7782,_7817),
    be(_7835,_7817,_7850),
    cc(det,_7850,_7869),
    w(adj2(_7734,_7735),_7870,_7869,_7887),
    !,
    pushstack(free,adverbial1(_7737,_7703,_7741::_7742),nil,_7887,_7952),[],
    pushstack(first,([det],be,w(adj2(_7734,_7735))),nil,_7952,_7991),
    substatement1(_7701,_7953,_7991,_7784).

whereq(which(_7703):::_7701,[whereq,_7772,_7811,lit(det),_7846,!,_7875],_7758,_7760) --> 
    where_adverbial(_7723,_7703,_7727::_7728,_7772,_7758,_7793),
    be(_7811,_7793,_7826),
    cc(det,_7826,_7845),
    that0(_7846,_7845,_7861),
    !,
    pushstack(free,adverbial1(_7723,_7703,_7727::_7728),nil,_7861,_7920),
    statreal(_7701,_7875,_7920,_7760).

whereq(_7698,[whereq,_7766,_7790,_7814],_7752,_7754) --> 
    where(_7766,_7752,_7781),
    be(_7790,_7781,_7805),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),w(verb(be1,pres,fin))),nil,_7805,_7882),
    ppq(_7698,_7814,_7882,_7754).

whereq(which(_7703):::_7701,[whereq,_7745,_7769,!,_7798],_7731,_7733) --> 
    where(_7745,_7731,_7760),
    many1(_7769,_7760,_7784),
    !,
    reject(_7798,_7784,_7733).

whereq(_7698,[whereq,_7760,_7784,_7808],_7746,_7748) --> 
    where(_7760,_7746,_7775),
    aux1(_7784,_7775,_7799),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),do),nil,_7799,_7904),
    ppq(_7698,_7808,_7904,_7748).

whereq(_7698,[whereq,_7752,_7776,_7800],_7738,_7740) --> 
    where(_7752,_7738,_7767),
    look_ahead_vp(_7776,_7767,_7791),
    pushstack(first,(which,w(noun(place,sin,u,n))),nil,_7791,_7838),
    whichq(_7698,_7800,_7838,_7740).

when_adverbial(in,_7699,_7702::_7703,[when_adverbial,_7766,_7790,!,{}],_7746,_7748) --> 
    which(_7766,_7746,_7781),
    np1(_7699,_7702::_7703,_7790,_7781,_7748),
    !,
    {user:testconstraint(_7699,time)}.

when_adverbialq(in,_7708:time,_7702::_7708 isa time and _7702,[when_adverbialq,_7755],_7735,_7737) --> 
    when(_7755,_7735,_7737).

when_adverbial(in,_7708:time,_7702::_7708 isa time and _7702,[when_adverbial,_7755],_7735,_7737) --> 
    whenx(_7755,_7735,_7737).

where_adverbial(nil,_7699,_7700,[where_adverbial,_7760,_7784,!,{}],_7740,_7742) --> 
    which(_7760,_7740,_7775),
    np1(_7699,_7700,_7784,_7775,_7742),
    !,
    {user:testconstraint(_7699,place)}.

where_adverbial(nil,_7699,_7700,[where_adverbial,lit(hvor),_7766,!],_7735,_7737) --> 
    cc(hvor,_7735,_7765),
    np00(place,_7699,_7700,_7766,_7765,_7737),
    !.

dummyprep0([dummyprep0,_7727,!],_7716,_7718) --> 
    dummyprep(_7727,_7716,_7718),
    !.

dummyprep0([dummyprep0,[]],_7713,_7713) --> 
    [].

dummyprep([dummyprep,_7732,!,_7766],_7721,_7723) --> 
    prep1(from,_7732,_7721,_7749),
    !,
    accept(_7766,_7749,_7723).

dummyprep([dummyprep,_7732,!,_7766],_7721,_7723) --> 
    prep1(to,_7732,_7721,_7749),
    !,
    accept(_7766,_7749,_7723).

wherefromq(_7698,[wherefromq,_7757,!,_7786],_7743,_7745) --> 
    wherefrom(_7757,_7743,_7772),
    !,
    pushstack(first,(prep(from),which,w(noun(place,sin,u,n))),nil,_7772,_7855),
    ppq(_7698,_7786,_7855,_7745).

whoq(_7698,[whoq,_7782,_7806,_7835,!,_7869],_7768,_7770) --> 
    who(_7782,_7768,_7797),
    look_ahead(w(noun(_7731,sin,def,n)),_7806,_7797,_7823),
    w(verb(_7723,_7724,fin),_7835,_7823,_7852),
    !,
    pushstack(first,(which,w(noun(agent,sin,u,n)),w(verb(_7723,_7724,fin))),nil,_7852,_7907),
    whichq(_7698,_7869,_7907,_7770).

whoq(_7698,[whoq,_7749,_7773],_7735,_7737) --> 
    who(_7749,_7735,_7764),
    pushstack(first,(which,w(noun(agent,sin,u,n))),nil,_7764,_7811),
    whichq(_7698,_7773,_7811,_7737).

whoseq(_7698,[whoseq,_7774,_7798,_7852],_7760,_7762) --> 
    whose(_7774,_7760,_7789),
    noun(_7721,_7722,u,n,_7725,_7726,_7798,_7789,_7825),
    pushstack(first,(who,w(verb(have,pres,fin)),a,noun(_7721,_7722,u,n,_7725,_7726),that),nil,_7825,_7986),
    whoq(_7698,_7852,_7986,_7762).

whyq(explain:::_7701,[whyq,_7739,_7763],_7725,_7727) --> 
    hvorfor(_7739,_7725,_7754),
    isq(_7701,_7763,_7754,_7727).

whyq(explain:::_7701,[whyq,_7739,_7763],_7725,_7727) --> 
    hvorfor(_7739,_7725,_7754),
    ynq(_7701,_7763,_7754,_7727).

whyq(explain:::_7701,[whyq,_7739,_7763],_7725,_7727) --> 
    hvorfor(_7739,_7725,_7754),
    hasq(_7701,_7763,_7754,_7727).

howq(doit:::reply('OK'),[howq,lit(hvordan),_7769,lit(det),!,_7814],_7744,_7746) --> 
    cc(hvordan,_7744,_7768),
    w(verb(go,_7722,fin),_7769,_7768,_7786),
    cc(det,_7786,_7808),
    !,
    skip_rest(_7814,_7808,_7746).

howq(explain:::_7701,[howq,lit(hvordan),_7784,_7808,_7837,!,_7866],_7759,_7761) --> 
    cc(hvordan,_7759,_7783),
    erdetaa0(_7784,_7783,_7799),
    w(verb(_7726,inf,fin),_7808,_7799,_7825),
    mex0(_7837,_7825,_7852),
    !,
    pushstack(first,([jeg],w(verb(_7726,pres,fin))),nil,_7852,_7876),
    statreal1(_7701,_7866,_7876,_7761).

howq(explain:::_7701,[howq,lit(hvorfor),_7778,!,_7812],_7753,_7755) --> 
    cc(hvorfor,_7753,_7777),
    w(verb(_7720,inf,fin),_7778,_7777,_7795),
    !,
    pushstack(first,([jeg],w(verb(_7720,pres,fin))),nil,_7795,_7822),
    statreal1(_7701,_7812,_7822,_7755).

howq(explain:::_7701,[howq,lit(hvordan),_7776,[],_7850],_7751,_7753) --> 
    cc(hvordan,_7751,_7775),
    look_ahead(w(verb(be,_7721,fin)),_7776,_7775,_7793),
    pushstack(free,xadverbial1(how,nil,_7731::_7731),nil,_7793,_7849),[],
    isq(_7701,_7850,_7849,_7753).

howq(explain:::_7701,[howq,_7763,_7787,_7811,_7845],_7749,_7751) --> 
    how(_7763,_7749,_7778),
    be(_7787,_7778,_7802),
    np1_accept(_7724,_7725,_7811,_7802,_7830),
    pushstack(first,(xnp(_7724,_7725),w(verb(be,pres,fin))),nil,_7830,_7886),
    substatement1(_7701,_7845,_7886,_7751).

howq(explain:::_7701,[howq,_7769,_7793,lit(det),_7828,!,_7862],_7755,_7757) --> 
    how(_7769,_7755,_7784),
    be(_7793,_7784,_7808),
    cc(det,_7808,_7827),
    negation0(_7732,_7828,_7827,_7845),
    !,
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_7845,_7872),
    substatement1(_7701,_7862,_7872,_7757).

howq(explain:::_7701,[howq,_7753,_7797,_7821,!,_7850],_7739,_7741) --> 
    lexv(iv,tell,imp,fin,_7753,_7739,_7776),
    me0(_7797,_7776,_7812),
    how(_7821,_7812,_7836),
    !,
    statreal1(_7701,_7850,_7836,_7741).

howq(_7698,[howq,_7748,_7772,_7796,!,_7825],_7734,_7736) --> 
    how(_7748,_7734,_7763),
    be(_7772,_7763,_7787),
    thereit(_7796,_7787,_7811),
    !,
    pushstack(first,whatbe,nil,_7811,_7863),
    whatq(_7698,_7825,_7863,_7736).

howq(_7698,[howq,_7755,_7779,lit(det),_7814,!,_7848],_7741,_7743) --> 
    how(_7755,_7741,_7770),
    be(_7779,_7770,_7794),
    cc(det,_7794,_7813),
    prep1(with,_7814,_7813,_7831),
    !,
    pushstack(first,whatbe,nil,_7831,_7886),
    whatq(_7698,_7848,_7886,_7743).

howq(explain:::_7701,[howq,_7739,_7763],_7725,_7727) --> 
    how(_7739,_7725,_7754),
    ynq(_7701,_7763,_7754,_7727).

howq(explain:::_7701,[howq,_7739,_7763],_7725,_7727) --> 
    how(_7739,_7725,_7754),
    hasq(_7701,_7763,_7754,_7727).

erdetaa0([erdetaa0,_7740,lit(det),lit(å),!,_7791],_7729,_7731) --> 
    be(_7740,_7729,_7755),
    cc(det,_7755,_7774),
    cc(å,_7774,_7785),
    !,
    accept(_7791,_7785,_7731).

erdetaa0([erdetaa0,[]],_7713,_7713) --> 
    [].

howlongto(_7698,_7699,_7702::_7703,[howlongto,_7776,lit(det),lit(lenge),_7822,_7851],_7756,_7758) --> 
    be(_7776,_7756,_7791),
    cc(det,_7791,_7810),
    cc(lenge,_7810,_7821),
    prep1(to,_7822,_7821,_7839),
    lock(exact,_7839,_7868),
    pushstack(exact,[når],nil,_7868,_7874),
    when_adverbial(_7698,_7699,_7702::_7703,_7851,_7874,_7863),
    unlock(_7863,_7758).

howlongto(_7698,_7699,_7702::_7703,[howlongto,lit(hvor),lit(lenge),_7803,lit(det),_7838,_7867],_7761,_7763) --> 
    cc(hvor,_7761,_7791),
    cc(lenge,_7791,_7802),
    be(_7803,_7802,_7818),
    cc(det,_7818,_7837),
    prep1(to,_7838,_7837,_7855),
    lock(exact,_7855,_7884),
    pushstack(exact,[når],nil,_7884,_7890),
    when_adverbial(_7698,_7699,_7702::_7703,_7867,_7890,_7879),
    unlock(_7879,_7763).

howlongto(_7698,_7699,_7702::_7703,[howlongto,_7762,_7801,_7825,_7849],_7742,_7744) --> 
    when_adverbial(_7698,_7699,_7702::_7703,_7762,_7742,_7783),
    be(_7801,_7783,_7816),
    thereit(_7825,_7816,_7840),
    that0(_7849,_7840,_7744).

howadjq(_7698,[howadjq,_7824,_7848,{},_7887,{},lit(det),_7937,_7966,_7990,_8019,!,_8090],_7810,_7812) --> 
    hvor(_7824,_7810,_7839),
    howadj1(_7733,_7848,_7839,_7865),
    {user:testmember(_7733,[duration])},
    w(verb(_7744,_7745,fin),_7887,_7865,_7904),
    {user:testmember(_7744,[take,be])},
    cc(det,_7904,_7936),
    not_look_ahead([å],_7937,_7936,_7954),
    redundant0(_7966,_7954,_7981),
    not_look_ahead(w(prep(with)),_7990,_7981,_8007),
    pushstack(first,(which,w(noun(_7733,sin,u,n)),w(verb(_7744,_7745,fin))),nil,_8007,_8060),whichq(_7698,_8019,_8060,_8073),
    !,
    accept(_8090,_8073,_7812).

howadjq(_7698,[howadjq,_7788,_7812,_7841,{},!,_7880],_7774,_7776) --> 
    hvor(_7788,_7774,_7803),
    howadj1(_7727,_7812,_7803,_7829),
    docan(_7841,_7829,_7856),
    {user:testmember(_7727,[frequency,speed,lateness,earliness,duration,distance])},
    !,
    pushstack(first,(prep(with),which,w(noun(_7727,sin,u,n)),do),nil,_7856,_7977),
    ppq(_7698,_7880,_7977,_7776).

howadjq(_7698,[howadjq,_7804,_7828,{},_7867,{},!,_7911],_7790,_7792) --> 
    hvor(_7804,_7790,_7819),
    howadj1(_7736,_7828,_7819,_7845),
    {user:testmember(_7736,[frequency,earliness,lateness])},
    w(verb(_7732,_7752,_7734),_7867,_7845,_7884),
    {user:(\+_7732=be)},
    !,
    pushstack(first,(prep(with),which,w(noun(_7736,sin,u,n)),w(verb(_7732,pres,_7734))),nil,_7884,_7979),
    ppq(_7698,_7911,_7979,_7792).

howadjq(_7698,[howadjq,_7774,_7798,_7827,_7861,_7885],_7760,_7762) --> 
    hvor(_7774,_7760,_7789),
    howadj1(_7727,_7798,_7789,_7815),
    gmem(_7727,[distance],_7827,_7815,_7846),
    be(_7861,_7846,_7876),
    pushstack(first,(which,w(noun(_7727,sin,u,n)),w(verb(have,pres,fin))),nil,_7876,_7923),
    whichq(_7698,_7885,_7923,_7762).

howadjq(which(_7708:time):::_7708 isa time and _7704,[howadjq,_7815,_7839,_7868,lit(det),lit(til),_7919,!,_7958,_7997],_7801,_7803) --> 
    hvor(_7815,_7801,_7830),
    howadj1(duration,_7839,_7830,_7856),
    w(verb(be,_7756,fin),_7868,_7856,_7885),
    cc(det,_7885,_7907),
    cc(til,_7907,_7918),
    clausal_object0(_7763,_7764,_7919,_7918,_7938),
    !,
    np00(time,_7708:time,_7749,_7958,_7938,_7979),
    pushstack(first,(xnp(_7763,_7764),w(verb(exist,_7756,fin)),xadverbial1(nil,_7708,_7749)),nil,_7979,_8069),
    statreal(_7704,_7997,_8069,_7803).

howadjq(_7698,[howadjq,_7812,_7856,_7880,_7909,_7938,_7972,!,_8006,_8045],_7798,_7800) --> 
    whichg00(duration,_7741,_7737,_7698,_7812,_7798,_7835),
    hvor(_7856,_7835,_7871),
    howadj1(duration,_7880,_7871,_7897),
    w(verb(be,_7750,fin),_7909,_7897,_7926),
    np1_accept(_7753,_7754,_7938,_7926,_7957),
    w(adj2(_7758,nil),_7972,_7957,_7989),
    !,
    np00(duration,_7737,_7738,_8006,_7989,_8027),
    pushstack(first,(xnp(_7753,_7754),w(verb(be,_7750,fin)),w(adj2(_7758,nil)),xadverbial1(nil,_7737,_7738)),nil,_8027,_8118),
    statreal(_7741,_8045,_8118,_7800).

howadjq(_7698,[howadjq,_7805,_7849,_7873,_7902,_7931,_7965,!,_7999,_8038],_7791,_7793) --> 
    whichg00(duration,_7738,_7734,_7698,_7805,_7791,_7828),
    hvor(_7849,_7828,_7864),
    howadj1(duration,_7873,_7864,_7890),
    w(verb(have,_7747,fin),_7902,_7890,_7919),
    subject(_7750,_7751,_7931,_7919,_7950),
    w(verb(_7755,past,part),_7965,_7950,_7982),
    !,
    np00(duration,_7734,_7735,_7999,_7982,_8020),
    pushstack(first,(xnp(_7750,_7751),w(verb(_7755,past,fin)),xadverbial1(nil,_7734,_7735)),nil,_8020,_8111),
    statreal(_7738,_8038,_8111,_7793).

howadjq(which(_7706):::_7706 isa _7709 and _7704,[howadjq,_7822,_7846,_7875,_7904,_7938,!,{},_7987,_8026],_7808,_7810) --> 
    hvor(_7822,_7808,_7837),
    howadj1(_7709,_7846,_7837,_7863),
    w(verb(have,_7756,fin),_7875,_7863,_7892),
    subject(_7759,_7760,_7904,_7892,_7923),
    object(_7762,_7763,_7938,_7923,_7957),
    !,
    {user:_7748=(_7706:_7709)},
    np00(_7709,_7748,_7749,_7987,_7957,_8008),
    pushstack(first,(xnp(_7759,_7760),w(verb(have,_7756,fin)),xnp(_7762,_7763),xadverbial1(nil,_7748,_7749)),nil,_8008,_8130),
    statreal(_7704,_8026,_8130,_7810).

howadjq(which(_7706):::_7706 isa _7709 and _7704,[howadjq,_7830,_7854,_7883,{},_7922,_7951,!,{},_8000,_8039],_7816,_7818) --> 
    hvor(_7830,_7816,_7845),
    howadj1(duration,_7854,_7845,_7871),
    w(verb(_7754,_7755,fin),_7883,_7871,_7900),
    {user:(\+testmember(_7754,[expect,be]))},
    not_look_ahead([det],_7922,_7900,_7939),
    np1(_7773,_7774,_7951,_7939,_7970),
    !,
    {user:_7747=(_7706:duration)},
    np00(_7709,_7747,_7748,_8000,_7970,_8021),
    pushstack(first,(xnp(_7773,_7774),w(verb(_7754,_7755,fin)),xnp(_7747,_7748)),nil,_8021,_8111),
    statreal(_7704,_8039,_8111,_7818).

howadjq(_7698,[howadjq,lit(hvor),lit(lenge),_7815,lit(det),_7855,!,_7889,_7923],_7779,_7781) --> 
    cc(hvor,_7779,_7803),
    cc(lenge,_7803,_7814),
    w(verb(be,pres,fin),_7815,_7814,_7832),
    cc(det,_7832,_7854),
    w(prep(to),_7855,_7854,_7872),
    !,
    clausal_object0(_7730,_7731,_7889,_7872,_7908),
    pushstack(first,([når],w(verb(be,pres,fin)),xnp(_7730,_7731)),nil,_7908,_7964),
    whenq(_7698,_7923,_7964,_7781).

howadjq(_7698,[howadjq,lit(hvor),lit(mange),_7823,_7852,lit(det),_7892,!,_7926],_7787,_7789) --> 
    cc(hvor,_7787,_7811),
    cc(mange,_7811,_7822),
    w(noun(minute,plu,u,n),_7823,_7822,_7840),
    w(verb(be,pres,fin),_7852,_7840,_7869),
    cc(det,_7869,_7891),
    w(prep(to),_7892,_7891,_7909),
    !,
    pushstack(free,([når],w(verb(be,pres,fin)),[det],[at]),nil,_7909,_7936),
    whenq(_7698,_7926,_7936,_7789).

howadjq(_7698,[howadjq,_7797,_7821,lit(blir),_7861,_7895,!,_7929],_7783,_7785) --> 
    hvor(_7797,_7783,_7812),
    howadj1(_7736,_7821,_7812,_7838),
    cc(blir,_7838,_7860),
    np1(_7733,_7734,_7861,_7860,_7880),
    w(verb(_7745,past,part),_7895,_7880,_7912),
    !,
    pushstack(first,(prep(with),which,w(noun(_7736,sin,u,n)),w(verb(_7745,pres,pass)),xnp(_7733,_7734)),nil,_7912,_8028),
    ppq(_7698,_7929,_8028,_7785).

howadjq(_7698,[howadjq,_7823,_7847,{},_7886,_7910,_7944,{},_7983,_8022],_7809,_7811) --> 
    hvor(_7823,_7809,_7838),
    howadj1(_7742,_7847,_7838,_7864),
    {user:testmember(_7742,[frequency])},
    be(_7886,_7864,_7901),
    subject(_7751,_7752,_7910,_7901,_7929),
    w(adj2(_7756,nil),_7944,_7929,_7961),
    {user:testmember(_7756,[delayed,tooearly])},
    np00(frequency,_7739,_7740,_7983,_7961,_8004),
    pushstack(first,(xnp(_7751,_7752),w(verb(be,pres,fin)),w(adj2(_7756,nil)),w(prep(with)),xnp(_7739,_7740)),nil,_8004,_8094),
    statreal1(_7698,_8022,_8094,_7811).

howadjq(_7698,[howadjq,_7782,_7806,{},_7845,_7869],_7768,_7770) --> 
    hvor(_7782,_7768,_7797),
    howadj1(_7727,_7806,_7797,_7823),
    {user:(\+testmember(_7727,[duration,distance,time]))},
    be(_7845,_7823,_7860),
    pushstack(first,(which,w(noun(_7727,sin,u,n)),w(verb(have,pres,fin))),nil,_7860,_7907),
    whichq(_7698,_7869,_7907,_7770).

howadjq(_7698,[howadjq,_7805,_7829,_7858,_7882,_7916,{},_7955,!,_8057],_7791,_7793) --> 
    hvor(_7805,_7791,_7820),
    howadj1(_7724,_7829,_7820,_7846),
    do(_7858,_7846,_7873),
    np(_7726,_7727,_7882,_7873,_7901),
    w(verb(_7731,_7732,_7733),_7916,_7901,_7933),
    {user:testmember(_7731,[use,take])},
    pushstack(first,(which,w(noun(_7724,sin,u,n)),w(verb(_7731,inf,fin)),xnp(_7726,_7727)),nil,_7933,_8027),whichq(_7698,_7955,_8027,_8040),
    !,
    accept(_8057,_8040,_7793).

howadjq(which(_7703):::_7701,[howadjq,_7833,_7857,{},_7896,{},_7935,!,_7974,!,_8079],_7819,_7821) --> 
    hvor(_7833,_7819,_7848),
    howadj1(_7732,_7857,_7848,_7874),
    {user:testmember(_7732,[speed,distance])},
    w(verb(_7745,pres,fin),_7896,_7874,_7913),
    {user:(\+testmember(_7745,[know,be]))},
    np1(_7760,_7761,_7935,_7913,_7954),
    !,
    pushstack(first,(xnp(_7760,_7761),w(verb(_7745,pres,fin)),w(prep(with)),the(_7703),w(noun(_7732,sin,u,n))),nil,_7954,_8049),statreal(_7701,_7974,_8049,_8062),
    !,
    accept(_8079,_8062,_7821).

howadjq(_7698,[howadjq,_7783,lit(lenge),_7818,_7842,!,_7876],_7769,_7771) --> 
    hvor(_7783,_7769,_7798),
    cc(lenge,_7798,_7817),
    be(_7818,_7817,_7833),
    not_look_ahead([det],_7842,_7833,_7859),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),w(verb(be,pres,fin))),nil,_7859,_7914),
    ppq(_7698,_7876,_7914,_7771).

howadjq(_7698,[howadjq,_7819,_7843,{},_7882,{},lit(det),_7932,_7956,!,_7990,_8014,!,_8085],_7805,_7807) --> 
    hvor(_7819,_7805,_7834),
    howadj1(_7736,_7843,_7834,_7860),
    {user:testmember(_7736,[duration])},
    w(verb(_7747,pres,fin),_7882,_7860,_7899),
    {user:testmember(_7747,[take,be])},
    cc(det,_7899,_7931),
    redundant0(_7932,_7931,_7947),
    prep(with,_7956,_7947,_7973),
    !,
    accept(_7990,_7973,_8005),
    pushstack(first,(which,w(noun(_7736,sin,u,n)),w(verb(_7747,pres,fin))),nil,_8005,_8055),whichq(_7698,_8014,_8055,_8068),
    !,
    accept(_8085,_8068,_7807).

howadjq(_7698,[howadjq,_7838,_7862,{},_7901,{},lit(det),_7951,_7980,_8004,!,_8038,_8062,!,_8133],_7824,_7826) --> 
    hvor(_7838,_7824,_7853),
    howadj1(_7739,_7862,_7853,_7879),
    {user:testmember(_7739,[duration])},
    w(verb(_7750,pres,fin),_7901,_7879,_7918),
    {user:testmember(_7750,[take])},
    cc(det,_7918,_7950),
    not_look_ahead([å],_7951,_7950,_7968),
    redundant0(_7980,_7968,_7995),
    look_ahead(w(prep(_7771)),_8004,_7995,_8021),
    !,
    accept(_8038,_8021,_8053),
    pushstack(first,(which,w(noun(_7739,sin,u,n)),w(verb(_7750,pres,fin)),w(noun(vehicle,sin,def,n))),nil,_8053,_8103),whichq(_7698,_8062,_8103,_8116),
    !,
    accept(_8133,_8116,_7826).

howadjq(_7698,[howadjq,_7815,_7839,{},_7878,lit(det),_7918,{},_7957,_7981,!,_8052],_7801,_7803) --> 
    hvor(_7815,_7801,_7830),
    howadj1(_7730,_7839,_7830,_7856),
    {user:testmember(_7730,[duration])},
    w(verb(_7741,pres,fin),_7878,_7856,_7895),
    cc(det,_7895,_7917),
    not_look_ahead([å],_7918,_7917,_7935),
    {user:testmember(_7741,[take,be])},
    redundant0(_7957,_7935,_7972),
    pushstack(first,(which,w(noun(_7730,sin,u,n)),w(verb(exist,pres,fin))),nil,_7972,_8022),whichq(_7698,_7981,_8022,_8035),
    !,
    accept(_8052,_8035,_7803).

howadjq(_7698,[howadjq,_7754,_7778,_7807],_7740,_7742) --> 
    ihvor(_7754,_7740,_7769),
    howadj1(_7714,_7778,_7769,_7795),
    pushstack(first,(which,w(noun(_7714,sin,u,n))),nil,_7795,_7845),
    whichq(_7698,_7807,_7845,_7742).

howadjq(_7698,[howadjq,_7770,lit(lenge),_7805,!,_7834],_7756,_7758) --> 
    hvor(_7770,_7756,_7785),
    cc(lenge,_7785,_7804),
    be(_7805,_7804,_7820),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),be),nil,_7820,_7900),
    ppq(_7698,_7834,_7900,_7758).

howadjq(_7698,[howadjq,_7773,_7797,_7821,_7845,_7874],_7759,_7761) --> 
    hvor(_7773,_7759,_7788),
    meny(_7797,_7788,_7812),
    be(_7821,_7812,_7836),
    w(noun(clock,_7734,_7735,_7736),_7845,_7836,_7862),
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_7862,_7940),
    whatq(_7698,_7874,_7940,_7761).

howadjq(_7698,[howadjq,_7788,lit(lenge),_7823,{},!,_7867],_7774,_7776) --> 
    hvor(_7788,_7774,_7803),
    cc(lenge,_7803,_7822),
    w(verb(_7729,pres,fin),_7823,_7822,_7840),
    {user:_7729\==take},
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(_7729,pres,fin))),nil,_7840,_7935),
    ppq(_7698,_7867,_7935,_7776).

howadjq(_7698,[howadjq,_7780,_7804,_7833,!,_7867],_7766,_7768) --> 
    hvor(_7780,_7766,_7795),
    howadj1(duration,_7804,_7795,_7821),
    w(verb(use,pres,fin),_7833,_7821,_7850),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_7850,_7935),
    ppq(_7698,_7867,_7935,_7768).

howadjq(_7698,[howadjq,_7771,_7795,_7824,_7848,!,_7977],_7757,_7759) --> 
    hvor(_7771,_7757,_7786),
    howadj1(_7715,_7795,_7786,_7812),
    do(_7824,_7812,_7839),
    pushstack(first,(prep(with),which,w(noun(_7715,sin,u,n)),do),nil,_7839,_7947),ppq(_7698,_7848,_7947,_7960),
    !,
    accept(_7977,_7960,_7759).

howadjq(_7698,[howadjq,_7771,_7795,_7824,_7848,_7872],_7757,_7759) --> 
    hvor(_7771,_7757,_7786),
    howadj1(duration,_7795,_7786,_7812),
    betake(_7824,_7812,_7839),
    thereit(_7848,_7839,_7863),
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(duration,sin,def,n))),nil,_7863,_7882),
    whatq(_7698,_7872,_7882,_7759).

howadjq(_7698,[howadjq,_7787,_7811,_7840,_7869,!,_7903],_7773,_7775) --> 
    hvor(_7787,_7773,_7802),
    howadj1(duration,_7811,_7802,_7828),
    w(verb(take,pres,fin),_7840,_7828,_7857),
    not_look_ahead([det],_7869,_7857,_7886),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_7886,_7971),
    ppq(_7698,_7903,_7971,_7775).

howmuchq(which(_7703):::_7701,[howmuchq,_7795,lit(lenge),_7830,lit(det),!,_7875],_7781,_7783) --> 
    hvor(_7795,_7781,_7810),
    cc(lenge,_7810,_7829),
    w(verb(be,_7739,fin),_7830,_7829,_7847),
    cc(det,_7847,_7869),
    !,
    pushstack(first,(which,w(noun(duration,plu,u,n)),w(verb(be,_7739,fin)),[det]),nil,_7869,_7913),
    whichq(which(_7703):::_7701,_7875,_7913,_7783).

howmuchq(which(_7703):::_7701,[howmuchq,_7812,_7836,_7860,{},lit(det),lit(å),_7921,!,_7969],_7798,_7800) --> 
    hvor(_7812,_7798,_7827),
    much(_7836,_7827,_7851),
    w(verb(_7742,_7743,fin),_7860,_7851,_7877),
    {user:testmember(_7742,[cost])},
    cc(det,_7877,_7909),
    cc(å,_7909,_7920),
    pushstack(first,([noen],[vil]),nil,_7920,_7934),clausal_object1(_7765,_7766,_7921,_7934,_7949),
    !,
    pushstack(first,(xnp(_7765,_7766),w(verb(_7742,pres,fin)),npgap(_7703)),nil,_7949,_8040),
    statreal1(_7701,_7969,_8040,_7800).

howmuchq(test:::_7701,[howmuchq,_7795,_7819,_7843,_7872,_7906,!,_7940,_7964],_7781,_7783) --> 
    hvor(_7795,_7781,_7810),
    much(_7819,_7810,_7834),
    w(verb(be,_7741,fin),_7843,_7834,_7860),
    np0_accept(_7744,_7745,_7872,_7860,_7891),
    w(adj2(_7735,nil),_7906,_7891,_7923),
    !,
    accept(_7940,_7923,_7955),
    pushstack(first,(xnp(_7744,_7745),w(verb(be,pres,fin)),w(adj2(_7735,nil))),nil,_7955,_8005),
    statemen1(real,_7701,_7964,_8005,_7783).

howmuchq(_7698,[howmuchq,_7758,_7782,_7806,!,_7840],_7744,_7746) --> 
    hvor(_7758,_7744,_7773),
    many1(_7782,_7773,_7797),
    look_ahead(w(verb(be,_7722,fin)),_7806,_7797,_7823),
    !,
    pushstack(first,[hva],nil,_7823,_7850),
    whatq(_7698,_7840,_7850,_7746).

howmuchq(howmany(_7703):::_7701,[howmuchq,_7752,_7776,_7800],_7738,_7740) --> 
    hvor(_7752,_7738,_7767),
    many1(_7776,_7767,_7791),
    pushstack(first,which,nil,_7791,_7838),
    whichq(which(_7703):::_7701,_7800,_7838,_7740).

howmuchq(howmany(_7703):::_7701,[howmuchq,_7762,_7786,_7810],_7748,_7750) --> 
    hvor(_7762,_7748,_7777),
    manypersons(_7786,_7777,_7801),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_7801,_7848),
    whichq(which(_7703):::_7701,_7810,_7848,_7750).

howmuchq(howmany(_7703):::_7701,[howmuchq,_7772,lit(det),_7807,lit(som),_7842],_7758,_7760) --> 
    be(_7772,_7758,_7787),
    cc(det,_7787,_7806),
    manypersons(_7807,_7806,_7822),
    cc(som,_7822,_7841),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_7841,_7880),
    whichq(which(_7703):::_7701,_7842,_7880,_7760).

howmuchq(which(_7703):::_7701,[howmuchq,_7767,_7791,_7815,{},_7854],_7753,_7755) --> 
    hvor(_7767,_7753,_7782),
    much(_7791,_7782,_7806),
    w(verb(_7717,_7724,fin),_7815,_7806,_7832),
    {user:testmember(_7717,[earn,cost])},
    whattrans(_7717,_7703,_7701,_7854,_7832,_7755).

howmuchq(_7698,[howmuchq,_7751,_7775,_7799,!,_7828],_7737,_7739) --> 
    hvor(_7751,_7737,_7766),
    much(_7775,_7766,_7790),
    of(_7799,_7790,_7814),
    !,
    pushstack(first,(which,of),nil,_7814,_7897),
    whichq(_7698,_7828,_7897,_7739).

howmuchq(_7698,[howmuchq,_7768,_7792,_7816,_7845,!,_7916],_7754,_7756) --> 
    hvor(_7768,_7754,_7783),
    much(_7792,_7783,_7807),
    w(noun(_7717,_7718,u,n),_7816,_7807,_7833),
    pushstack(first,(which,w(noun(_7717,sin,u,n))),nil,_7833,_7886),whichq(_7698,_7845,_7886,_7899),
    !,
    accept(_7916,_7899,_7756).

howmuchq(_7698,[howmuchq,_7744,_7768,_7792],_7730,_7732) --> 
    hvor(_7744,_7730,_7759),
    much(_7768,_7759,_7783),
    pushstack(first,[hva],nil,_7783,_7802),
    question(_7698,_7792,_7802,_7732).

whattrans(_7698,_7699,_7700,[whattrans,_7787,_7816,!,_7855],_7767,_7769) --> 
    not_look_ahead([det],_7787,_7767,_7804),
    noun_phrase1(_7726,_7729::_7730,_7816,_7804,_7835),
    !,
    pushstack(first,(noun_phrase1(_7726,_7729::_7730),w(verb(_7698,pres,fin)),npgap(_7699)),nil,_7835,_7929),
    statreal1(_7700,_7855,_7929,_7769).

howadj1(_7698,[howadj1,_7736,!],_7722,_7724) --> 
    howadj(_7698,_7736,_7722,_7724),
    !.

howadj(duration,[howadj,lit(langt)],_7719,_7721) --> 
    cc(langt,_7719,_7721).

howadj(age,[howadj,_7736],_7722,_7724) --> 
    w(adj2(old,nil),_7736,_7722,_7724).

howadj(age,[howadj,lit(mange),_7754],_7729,_7731) --> 
    cc(mange,_7729,_7753),
    w(noun(year,plu,u,n),_7754,_7753,_7731).

howadj(delay,[howadj,_7736],_7722,_7724) --> 
    w(adj2(slow,nil),_7736,_7722,_7724).

howadj(delay,[howadj,_7741,_7785],_7727,_7729) --> 
    optional(much,_7741,_7727,_7773),
    w(adj2(delayed,nil),_7785,_7773,_7729).

howadj(delay,[howadj,_7736],_7722,_7724) --> 
    w(adj2(punctual,nil),_7736,_7722,_7724).

howadj(earliness,[howadj,_7736],_7722,_7724) --> 
    w(adj2(early,nil),_7736,_7722,_7724).

howadj(lateness,[howadj,_7736],_7722,_7724) --> 
    w(adj2(late,nil),_7736,_7722,_7724).

howadj(lateness,[howadj,lit(sent)],_7719,_7721) --> 
    cc(sent,_7719,_7721).

howadj(distance,[howadj,lit(langt)],_7719,_7721) --> 
    cc(langt,_7719,_7721).

howadj(distance,[howadj,_7757,_7781,{}],_7743,_7745) --> 
    many(_7757,_7743,_7772),
    w(noun(_7708,_7722,u,n),_7781,_7772,_7745),
    {user:testmember(_7708,[mil,mile,kilometer,meter])}.

howadj(duration,[howadj,lit(mange),_7754],_7729,_7731) --> 
    cc(mange,_7729,_7753),
    w(noun(minute,_7706,_7707,n),_7754,_7753,_7731).

howadj(duration,[howadj,lit(lenge)],_7719,_7721) --> 
    cc(lenge,_7719,_7721).

howadj(duration,[howadj,_7744,_7768,!],_7730,_7732) --> 
    long(_7744,_7730,_7759),
    w(noun(time,_7709,u,n),_7768,_7759,_7732),
    !.

howadj(duration,[howadj,_7744,_7768,!],_7730,_7732) --> 
    much(_7744,_7730,_7759),
    w(noun(time,_7709,u,n),_7768,_7759,_7732),
    !.

howadj(duration,[howadj,_7736],_7722,_7724) --> 
    w(adj2(short,nil),_7736,_7722,_7724).

howadj(frequency,[howadj,_7731],_7717,_7719) --> 
    often(_7731,_7717,_7719).

howadj(frequency,[howadj,lit(mange),_7763,_7792,!,_7821],_7738,_7740) --> 
    cc(mange,_7738,_7762),
    w(noun(time_count,_7717,_7718,n),_7763,_7762,_7780),
    inperiod0(_7792,_7780,_7807),
    !,
    accept(_7821,_7807,_7740).

howadj(intelligence,[howadj,_7736],_7722,_7724) --> 
    w(adj2(intelligent,nil),_7736,_7722,_7724).

howadj(intelligence,[howadj,_7736],_7722,_7724) --> 
    w(adj2(stupid,_7703),_7736,_7722,_7724).

howadj(intelligence,[howadj,_7746,_7775],_7732,_7734) --> 
    w(adj2(_7712,nil),_7746,_7732,_7763),
    w(noun(intelligence,sin,_7707,n),_7775,_7763,_7734).

howadj(price,[howadj,_7736],_7722,_7724) --> 
    w(adj2(expensive,nil),_7736,_7722,_7724).

howadj(price,[howadj,_7736],_7722,_7724) --> 
    w(adj2(cheap,nil),_7736,_7722,_7724).

howadj(size,[howadj,_7731],_7717,_7719) --> 
    great(_7731,_7717,_7719).

howadj(length,[howadj,_7736],_7722,_7724) --> 
    w(adj2(long,nil),_7736,_7722,_7724).

howadj(length,[howadj,_7736],_7722,_7724) --> 
    w(adj2(short,nil),_7736,_7722,_7724).

howadj(speed,[howadj,lit(fort)],_7719,_7721) --> 
    cc(fort,_7719,_7721).

howadj(speed,[howadj,_7736],_7722,_7724) --> 
    w(adj2(fast,_7703),_7736,_7722,_7724).

howadj(speed,[howadj,_7736],_7722,_7724) --> 
    w(adj2(slow,_7703),_7736,_7722,_7724).

howadj(temperature,[howadj,_7736],_7722,_7724) --> 
    w(adj2(cold,nil),_7736,_7722,_7724).

howadj(temperature,[howadj,_7736],_7722,_7724) --> 
    w(adj2(hot,nil),_7736,_7722,_7724).

howadj(weather,[howadj,_7736],_7722,_7724) --> 
    w(adj2(hot,nil),_7736,_7722,_7724).

howadj(weather,[howadj,_7736],_7722,_7724) --> 
    w(adj2(cold,nil),_7736,_7722,_7724).

howadj(weight,[howadj,_7736],_7722,_7724) --> 
    w(adj2(heavy,nil),_7736,_7722,_7724).

vp(_7698,_7699,_7700,_7703::true,[vp,lit(:),_7771,!],_7737,_7739) --> 
    cc(:,_7737,_7770),
    end_of_line(_7771,_7770,_7739),
    !.

vp(_7698,_7699,_7700,_7701,[vp,_7754],_7731,_7733) --> 
    verb_phrase(_7698,_7699,_7700,_7701,_7754,_7731,_7733).

verb_phrase(_7698,_7699,_7700,_7701,[verb_phrase,_7822,{},{},{},{},!,_7891,_7915,!],_7799,_7801) --> 
    endofline(_7822,_7799,_7837),
    {user:value(busflag,true)},
    {user:(\+value(dialog,1))},
    {user:vartypeid(_7698,_7742)},
    {user:testmember(_7742,[neighbourhood,bus,tram,station,departure,arrival])},
    !,
    accept(_7891,_7837,_7906),
    pushstack(first,w(verb(exist,pres,fin)),nil,_7906,_7928),verb_phrase1(exist,_7698,_7699,_7700,_7701,_7915,_7928,_7801),
    !.

verb_phrase(_7698,_7699,_7700,_7703::_7704,[verb_phrase,_7858,{},lit(og),_7908,{},_7947,!,_7986,!,_8093],_7835,_7837) --> 
    w(verb(_7746,_7747,fin),_7858,_7835,_7875),
    {user:verbtype(_7746,tv)},
    cc(og,_7875,_7907),
    w(verb(_7759,_7760,fin),_7908,_7907,_7925),
    {user:verbtype(_7759,tv)},
    object(_7742,_7769,_7947,_7925,_7966),
    !,
    lock(exact,_7966,_8037),pushstack(exact,(w(verb(_7746,_7792,fin)),xnp(_7742,_7769)),nil,_8037,_8043),verb_phrase1(_7746,_7698,_7699,_7700,_7703::_7787,_7986,_8043,_8032),unlock(_8032,_8033),
    !,
    lock(exact,_8033,_8140),
    pushstack(exact,([og],w(verb(_7759,_7809,fin)),npgap(_7742)),nil,_8140,_8146),
    verb_phrases0(_7759,_7698,_7700,_7787,_7703::_7704,_8093,_8146,_8135),
    unlock(_8135,_7837).

verb_phrase(_7698,_7699,_7700,_7703::_7704,[verb_phrase,_7773,_7822],_7750,_7752) --> 
    verb_phrase1(_7709,_7698,_7699,_7700,_7703::_7712,_7773,_7750,_7798),
    verb_phrases0(_7709,_7698,_7700,_7712,_7703::_7704,_7822,_7798,_7752).

verb_phrases0(_7698,_7699,_7700,_7701,_7704::_7701 and _7708,[verb_phrases0,_7820,lit(ikke),!,_7860,{},{},_7938],_7794,_7796) --> 
    vp_conjunction(_7820,_7794,_7835),
    cc(ikke,_7835,_7854),
    !,
    pushstack(first,w(verb(_7698,pres,fin)),nil,_7854,_7873),verb_phrase1(_7698,_7699,_7750,_7700,_7704::_7755,_7860,_7873,_7894),
    {user:bigno(not,_7750,_7761)},
    {user:negate(_7761,_7755,_7731)},
    verb_phrases0(_7698,_7699,_7700,_7731,_7704::_7708,_7938,_7894,_7796).

verb_phrases0(_7698,_7699,_7700,_7701,_7704::_7701 and _7708,[verb_phrases0,_7801,_7825,_7854,{},_7913],_7775,_7777) --> 
    vp_conjunction(_7801,_7775,_7816),
    not_look_ahead([så],_7825,_7816,_7842),
    verb_phrase1(_7735,_7699,_7737,_7700,_7704::_7742,_7854,_7842,_7879),
    {user:negate(_7737,_7742,_7725)},
    verb_phrases0(_7722,_7699,_7700,_7725,_7704::_7708,_7913,_7879,_7777).

verb_phrases0(be,_7699,_7700,_7701,_7704::_7701 and _7708,[verb_phrases0,_7808,{},!,_7852],_7782,_7784) --> 
    w(adj2(_7727,nil),_7808,_7782,_7825),
    {user:testmember(_7727,[enclosed])},
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_7727,nil))),nil,_7825,_7862),
    verb_phrase1(be,_7699,id,_7700,_7704::_7708,_7852,_7862,_7784).

verb_phrases0(_7698,_7699,_7700,_7701,_7704::_7701,[verb_phrases0,[]],_7732,_7732) --> 
    [].

vp_conjunction([vp_conjunction,lit(som),_7740],_7718,_7720) --> 
    cc(som,_7718,_7739),
    look_ahead_vp(_7740,_7739,_7720).

vp_conjunction([vp_conjunction,lit(å),_7748],_7726,_7728) --> 
    cc(å,_7726,_7747),
    look_ahead(w(verb(_7705,pres,fin)),_7748,_7747,_7728).

vp_conjunction([vp_conjunction,lit(evt)],_7715,_7717) --> 
    cc(evt,_7715,_7717).

vp_conjunction([vp_conjunction,_7750,_7774,_7803,_7832,!],_7739,_7741) --> 
    and1(_7750,_7739,_7765),
    not_look_ahead([nå],_7774,_7765,_7791),
    not_look_ahead([så],_7803,_7791,_7820),
    not_look_ahead(w(adv(redundantly)),_7832,_7820,_7741),
    !.

vp_conjunction([vp_conjunction,lit(men),_7756,_7785,!],_7734,_7736) --> 
    cc(men,_7734,_7755),
    not_look_ahead([så],_7756,_7755,_7773),
    look_ahead_lit([skal,vil],_7785,_7773,_7736),
    !.

vp_conjunction([vp_conjunction,lit(men),_7758,_7787,!],_7736,_7738) --> 
    cc(men,_7736,_7757),
    not_look_ahead([så],_7758,_7757,_7775),
    look_ahead(w(verb(_7717,_7718,_7719)),_7787,_7775,_7738),
    !.

vp_conjunction([vp_conjunction,_7735,_7759],_7724,_7726) --> 
    or1(_7735,_7724,_7750),
    look_ahead(w(verb(_7705,_7706,fin)),_7759,_7750,_7726).

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7801,_7825,_7854,!,_7888,_7912],_7775,_7777) --> 
    aux1(_7801,_7775,_7816),
    not_look_ahead(w(verb(_7732,_7733,_7734)),_7825,_7816,_7842),
    look_ahead_lit([så,tilbake,fram],_7854,_7842,_7871),
    !,
    accept(_7888,_7871,_7903),
    pushstack(first,w(verb(go,pres,fin)),nil,_7903,_7922),
    do_phrase(_7698,_7699,_7700,_7701,_7702,_7912,_7922,_7777).

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7824,_7848,_7877,{},{},!,_7936,_7960],_7798,_7800) --> 
    aux1(_7824,_7798,_7839),
    not_look_ahead(w(verb(_7738,_7739,_7740)),_7848,_7839,_7865),
    np0_accept(_7731,_7732,_7877,_7865,_7896),
    {user:vartypeid(_7731,_7748)},
    {user:testmember(_7748,[thing,coevent,activity])},
    !,
    accept(_7936,_7896,_7951),
    pushstack(first,(w(verb(do1,pres,fin)),xnp(_7731,_7732)),nil,_7951,_8001),
    do_phrase(_7698,_7699,_7700,_7701,_7702,_7960,_8001,_7800).

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7851,_7875,_7904,_7928,_7957,{},_7996,_8020,{},!,_8069,_8093],_7825,_7827) --> 
    aux1(_7851,_7825,_7866),
    negation0(_7700,_7875,_7866,_7892),
    redundant0(_7904,_7892,_7919),
    not_look_ahead(w(verb(_7755,_7756,_7757)),_7928,_7919,_7945),
    w(prep(_7761),_7957,_7945,_7974),
    {user:testmember(_7761,[from,to,on,towards])},
    look_ahead_np(_7996,_7974,_8011),
    np0_accept(_7746,_7747,_8020,_8011,_8039),
    {user:constrain(_7746,place)},
    !,
    accept(_8069,_8039,_8084),
    pushstack(first,(w(verb(go,pres,fin)),w(prep(_7761)),xnp(_7746,_7747)),nil,_8084,_8134),
    do_phrase(_7698,_7699,_7700,_7701,_7702,_8093,_8134,_7827).

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7811,_7835,_7864,{},_7903,!,_7932,_7956],_7785,_7787) --> 
    aux1(_7811,_7785,_7826),
    not_look_ahead(w(verb(_7735,_7736,_7737)),_7835,_7826,_7852),
    look_ahead(w(prep(_7743)),_7864,_7852,_7881),
    {user:(\+testmember(_7743,[from,to,on,towards]))},
    preadverbials0(_7903,_7881,_7918),
    !,
    accept(_7932,_7918,_7947),
    do_phrase(_7698,_7699,_7700,_7701,_7702,_7956,_7947,_7787).

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7790,_7814,_7843,!,_7877,_7901],_7764,_7766) --> 
    aux1(_7790,_7764,_7805),
    not_look_ahead(w(verb(_7729,_7730,_7731)),_7814,_7805,_7831),
    one_of_lit([da,nå],_7843,_7831,_7860),
    !,
    accept(_7877,_7860,_7892),
    do_phrase(_7698,_7699,_7700,_7701,_7702,_7901,_7892,_7766).

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7818,_7842,_7871,_7900,_7924,{},!,_7973,_7997],_7792,_7794) --> 
    aux1(_7818,_7792,_7833),
    not_look_ahead(w(verb(_7741,_7742,_7743)),_7842,_7833,_7859),
    w(prep(_7747),_7871,_7859,_7888),
    look_ahead_np(_7900,_7888,_7915),
    np0_accept(_7734,_7735,_7924,_7915,_7943),
    {user:constrain(_7734,time)},
    !,
    accept(_7973,_7943,_7988),
    lock(last,_7988,_8045),
    pushstack(last,(w(prep(_7747)),xnp(_7734,_7735)),nil,_8045,_8051),
    do_phrase(_7698,_7699,_7700,_7701,_7702,_7997,_8051,_8040),
    unlock(_8040,_7794).

verb_phrase1(be1,_7699,_7700,_7701,_7702,[verb_phrase1,lit(skal),_7826,_7855,lit(med),_7910,_7934,{}],_7789,_7791) --> 
    cc(skal,_7789,_7825),
    negation0(_7724,_7826,_7825,_7843),
    optional(w(verb(be,inf,fin)),_7855,_7843,_7887),
    cc(med,_7887,_7909),
    not_look_ahead_np(_7910,_7909,_7925),
    pushstack(first,(w(verb(be1,inf,fin)),w(adv(inside))),nil,_7925,_7947),do_phrase(be1,_7699,_7725,_7701,_7702,_7934,_7947,_7791),
    {user:bigno(_7724,_7725,_7700)}.

verb_phrase1(be,_7699,id,_7701,_7702,[verb_phrase1,_7785,{},_7824],_7759,_7761) --> 
    w(adj2(_7715,nil),_7785,_7759,_7802),
    {user:testmember(_7715,[enclosed])},
    pushstack(first,w(adj2(_7715,nil)),nil,_7802,_7834),
    be_pred(_7699,_7701,_7702,_7824,_7834,_7761).

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7833,_7862,_7891,_7920,{},!,_7964,_8022,{}],_7807,_7809) --> 
    constrainvehdep(_7699,_7833,_7807,_7850),
    w(verb(be,_7739,fin),_7862,_7850,_7879),
    negation0(_7730,_7891,_7879,_7908),
    w(verb(_7698,past,part),_7920,_7908,_7937),
    {user:testmember(_7698,[go,run,pass])},
    !,
    pushstack(first,w(verb(_7698,_7739,fin)),nil,_7937,_7977),vp_kernel(_7698,_7699,_7731,_7701,_7774,_7964,_7977,_7998),
    verb_modifiers0(_7698,_7699,_7701,_7774,_7702,_8022,_7998,_7809),
    {user:bigno(_7730,_7731,_7700)}.

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7798,_7822,_7851,_7880,!,_7929],_7772,_7774) --> 
    blei(_7798,_7772,_7813),
    one_of_lit([siden,derfor,dermed],_7822,_7813,_7839),
    negation0(_7700,_7851,_7839,_7868),
    lexv(tv,_7698,past,part,_7880,_7868,_7903),
    !,
    pushstack(first,w(verb(_7698,past,part)),nil,_7903,_7939),
    passive(_7699,_7701,_7702,_7929,_7939,_7774).

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7793,_7817,_7841,_7870,_7894,!,_7943],_7767,_7769) --> 
    aux1(_7793,_7767,_7808),
    redundant0(_7817,_7808,_7832),
    negation0(_7700,_7841,_7832,_7858),
    blei(_7870,_7858,_7885),
    lexv(tv,_7698,past,part,_7894,_7885,_7917),
    !,
    pushstack(first,w(verb(_7698,past,part)),nil,_7917,_7953),
    passive(_7699,_7701,_7702,_7943,_7953,_7769).

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7800,_7824,_7853,_7877,_7921,!,_7960],_7774,_7776) --> 
    redundant0(_7800,_7774,_7815),
    blei(_7700,_7824,_7815,_7841),
    redundant0(_7853,_7841,_7868),
    lexv(_7733,_7698,past,part,_7877,_7868,_7900),
    gmem(_7733,[tv,dtv],_7921,_7900,_7940),
    !,
    pushstack(first,w(verb(_7698,past,part)),nil,_7940,_7970),
    passive(_7699,_7701,_7702,_7960,_7970,_7776).

verb_phrase1(be,_7699,_7700,_7701,_7702,[verb_phrase1,_7793,_7822,_7846,_7870,_7899,_7923,_7947,_7971,_7995],_7767,_7769) --> 
    not_look_ahead(w(verb(go,_7737,fin)),_7793,_7767,_7810),
    aux10(_7822,_7810,_7837),
    redundants0(_7846,_7837,_7861),
    be(_7700,_7870,_7861,_7887),
    not_look_ahead_verbx(_7899,_7887,_7914),
    danow0(_7923,_7914,_7938),
    redundant0(_7947,_7938,_7962),
    not_look_ahead_prepx(_7971,_7962,_7986),
    be_complements(_7699,_7701,_7702,_7995,_7986,_7769).

not_look_ahead_verbx([not_look_ahead_verbx,lit(så),!],_7718,_7720) --> 
    cc(så,_7718,_7720),
    !.

not_look_ahead_verbx([not_look_ahead_verbx,_7732],_7721,_7723) --> 
    not_look_ahead(w(verb(_7702,_7703,_7704)),_7732,_7721,_7723).

not_look_ahead_prepx([not_look_ahead_prepx,_7748,{},!,_7792],_7737,_7739) --> 
    look_ahead(w(prep(_7711)),_7748,_7737,_7765),
    {user:(\+testmember(_7711,[for]))},
    !,
    reject(_7792,_7765,_7739).

not_look_ahead_prepx([not_look_ahead_prepx,[]],_7713,_7713) --> 
    [].

verb_phrase1(_7698,_7699,_7700,_7701,_7702,[verb_phrase1,_7810,_7844,_7873,_7897,{},_7936,{},!,_8000],_7784,_7786) --> 
    auxs0(_7728,_7729,_7810,_7784,_7829),
    not_look_ahead(w(verb(_7735,_7736,pass)),_7844,_7829,_7861),
    redundants0(_7873,_7861,_7888),
    negation0(_7739,_7897,_7888,_7914),
    {user:bigno(_7728,_7739,_7745)},
    do_phrase(_7698,_7699,_7749,_7701,_7702,_7936,_7914,_7961),
    {user:bigno(_7745,_7749,_7700)},
    !,
    accept(_8000,_7961,_7786).

verb_phrase1(go,_7699,_7700,_7701,_7702,[verb_phrase1,_7800,_7824,lit(av),!,_7869,_7893],_7774,_7776) --> 
    aux1(_7800,_7774,_7815),
    not_look_ahead(w(verb(_7731,_7732,_7733)),_7824,_7815,_7841),
    cc(av,_7841,_7863),
    !,
    accept(_7869,_7863,_7884),
    pushstack(first,(w(verb(go,pres,fin)),[av]),nil,_7884,_7903),
    do_phrase(go,_7699,_7700,_7701,_7702,_7893,_7903,_7776).

verb_phrase1(_7698,_7699,id,_7701,_7704::_7705,[verb_phrase1,_7789,_7813,_7837,_7866],_7763,_7765) --> 
    paux0(_7789,_7763,_7804),
    redundant0(_7813,_7804,_7828),
    w(verb(_7698,_7728,pass),_7837,_7828,_7854),
    pushstack(first,w(verb(_7698,past,part)),nil,_7854,_7876),
    passive(_7699,_7701,_7704::_7705,_7866,_7876,_7765).

verb_phrase1(live,_7699,id,_7701,_7702,[verb_phrase1,_7824,_7848,_7872,_7901,_7930,!,_7979],_7798,_7800) --> 
    be(_7824,_7798,_7839),
    redundant0(_7848,_7839,_7863),
    number(_7741,_7872,_7863,_7889),
    w(noun(year,_7746,u,n),_7901,_7889,_7918),
    optional(w(adj2(old,nil)),_7930,_7918,_7962),
    !,
    pushstack(first,(w(verb(live,pres,fin)),prep1(in),number(_7741),w(noun(year,plu,u,n))),nil,_7962,_8053),
    do_phrase(live,_7699,id,_7701,_7702,_7979,_8053,_7800).

verb_phrase1(be,_7699,_7700,_7701,_7702,[verb_phrase1,_7777,_7806,lit(som),!,_7846],_7751,_7753) --> 
    be(_7700,_7777,_7751,_7794),
    dudet(_7806,_7794,_7821),
    cc(som,_7821,_7840),
    !,
    do_phrase(be,_7699,_7700,_7701,_7702,_7846,_7840,_7753).

verb_phrase1(be,_7699,_7700,_7701,_7702,[verb_phrase1,_7838,_7867,_7896,!,_7930,_7954,_7983,_8012,_8036,_8060,{}],_7812,_7814) --> 
    not_look_ahead(w(verb(go,_7745,fin)),_7838,_7812,_7855),
    w(verb(be,_7751,fin),_7867,_7855,_7884),
    not_look_ahead(w(verb(_7758,_7759,part)),_7896,_7884,_7913),
    !,
    accept(_7930,_7913,_7945),
    not_look_ahead(w(name(_7766,_7767,_7768)),_7954,_7945,_7971),
    negation0(_7736,_7983,_7971,_8000),
    it0(_8012,_8000,_8027),
    redundant0(_8036,_8027,_8051),
    pushstack(first,w(verb(be,pres,fin)),nil,_8051,_8073),do_phrase(be,_7699,_7737,_7701,_7702,_8060,_8073,_7814),
    {user:bigno(_7736,_7737,_7700)}.

verb_phrase1(_7698,_7699,id,_7701,_7702,[verb_phrase1,_7782,_7806,_7835,_7859],_7756,_7758) --> 
    paux0(_7782,_7756,_7797),
    w(verb(_7698,pres,pass),_7806,_7797,_7823),
    thereit0(_7835,_7823,_7850),
    pushstack(first,w(adj2(_7698,nil)),nil,_7850,_7869),
    be_complements(_7699,_7701,_7702,_7859,_7869,_7758).

do_phrase(_7698,_7699,_7700,_7701,_7702,[do_phrase,_7883,{},_7922,_7951,_7975,_8004,_8033,{},!,_8077,_8101,_8167],_7857,_7859) --> 
    w(verb(_7698,_7756,fin),_7883,_7857,_7900),
    {user:testmember(_7698,[go,come])},
    negation0(_7700,_7922,_7900,_7939),
    morethan0(_7951,_7939,_7966),
    w(nb(_7772,num),_7975,_7966,_7992),
    w(noun(minute,_7778,u,n),_8004,_7992,_8021),
    w(adj2(_7784,_7785),_8033,_8021,_8050),
    {user:testmember(_7784,[delayed,tooearly,late])},
    !,
    accept(_8077,_8050,_8092),
    lock(exact,_8092,_8121),pushstack(exact,w(adj2(_7784,_7785)),nil,_8121,_8127),ap(_7784,_7699,_7701,_7809,_8101,_8127,_8116),unlock(_8116,_8117),
    pushstack(first,(w(prep(with)),w(nb(_7772,num)),w(noun(minute,plu,u,n))),nil,_8117,_8177),
    verb_modifiers0(adj/nil/_7784,_7699,_7701,_7809,_7702,_8167,_8177,_7859).

morethan0([morethan0,lit(ca),!],_7718,_7720) --> 
    cc(ca,_7718,_7720),
    !.

morethan0([morethan0,lit(minst),!],_7718,_7720) --> 
    cc(minst,_7718,_7720),
    !.

morethan0([morethan0,lit(mer),lit(enn),!],_7723,_7725) --> 
    cc(mer,_7723,_7744),
    cc(enn,_7744,_7725),
    !.

morethan0([morethan0,[]],_7713,_7713) --> 
    [].

do_phrase(_7698,_7699,id,_7701,_7704::_7707 and _7708,[do_phrase,_7839,_7868,_7897,{},_7941,_7965,!,_7999,{}],_7813,_7815) --> 
    w(verb(ask,_7746,fin),_7839,_7813,_7856),
    not_look_ahead([om],_7868,_7856,_7885),
    object(_7753,_7754,_7897,_7885,_7916),
    {user:constrain(_7753,agent)},
    omaa0(_7941,_7916,_7956),
    w(verb(_7763,inf,fin),_7965,_7956,_7982),
    !,
    pushstack(first,(xnp(_7753,_7754),w(verb(_7763,pres,fin))),nil,_7982,_8043),clausal_object1(_7739,_7704::_7708,_7999,_8043,_7815),
    {user:co_template(_7698,that,_7699,_7739,_7701,_7707)}.

omaa0([omaa0,[]],_7713,_7713) --> 
    [].

omaa([omaa,lit(om),lit(å)],_7720,_7722) --> 
    cc(om,_7720,_7741),
    cc(å,_7741,_7722).

omaa([omaa,lit(om),lit(og)],_7720,_7722) --> 
    cc(om,_7720,_7741),
    cc(og,_7741,_7722).

omaa([omaa,lit(å)],_7715,_7717) --> 
    cc(å,_7715,_7717).

do_phrase(_7698,_7699,_7700,_7701,_7702,[do_phrase,_7770,_7819],_7744,_7746) --> 
    rvp_kernel(_7698,_7699,_7700,_7701,_7710,_7770,_7744,_7795),
    verb_modifiers0(_7698,_7699,_7701,_7710,_7702,_7819,_7795,_7746).

do_phrase(have,_7699,id,_7701,_7704::_7707 and _7708,[do_phrase,_7829,_7853,{},lit(for),lit(å),!,_7919,_7943,{}],_7803,_7805) --> 
    has(_7829,_7803,_7844),
    w(adj2(_7744,nil),_7853,_7844,_7870),
    {user:testmember(_7744,[difficult])},
    cc(for,_7870,_7902),
    cc(å,_7902,_7913),
    !,
    accept(_7919,_7913,_7934),
    pushstack(first,(npgap(_7699),aux1),nil,_7934,_8014),clausal_object1(_7770:coevent,_7704::_7708,_7943,_8014,_7805),
    {user:tv_template(dislike,_7699,_7770:coevent,_7701,_7707)}.

do_phrase(_7698,_7699,_7700,_7701,_7702,[do_phrase,_7776,_7825,_7874],_7750,_7752) --> 
    vp_kernel(_7698,_7699,_7710,_7701,_7717,_7776,_7750,_7801),
    verb_modifiers0(_7698,_7699,_7701,_7717,_7702,_7825,_7801,_7850),
    negation2(_7710,_7700,_7874,_7850,_7752).

do_phrase(_7698,_7699,_7700,_7701,_7702,[do_phrase,_7805,_7834,!,_7868,_7926,_7950],_7779,_7781) --> 
    not_look_ahead(w(verb(_7729,_7730,_7731)),_7805,_7779,_7822),
    look_ahead(w(prep(_7737)),_7834,_7822,_7851),
    !,
    pushstack(first,w(verb(do1,pres,fin)),nil,_7851,_7881),vp_kernel(_7698,_7699,_7700,_7701,_7722,_7868,_7881,_7902),
    it0(_7926,_7902,_7941),
    verb_modifiers0(_7698,_7699,_7701,_7722,_7702,_7950,_7941,_7781).

rvp_kernel(_7698,_7699,_7700,_7701,_7702,[rvp_kernel,_7895,{},_7954,_7983,_8012,_8041,_8070,{},_8114,_8158,_8187,!,_8226,_8346],_7869,_7871) --> 
    hlexv(dtv,_7698,_7754,_7755,_7756,_7895,_7869,_7920),
    {user:testmember(_7698,[ask,tell,answer,answer1])},
    not_look_ahead([om],_7954,_7920,_7971),
    not_look_ahead([et],_7983,_7971,_8000),
    not_look_ahead([en],_8012,_8000,_8029),
    not_look_ahead(w(nb(_7787,_7788)),_8041,_8029,_8058),
    ind_object(_7790,_7791,_8070,_8058,_8089),
    {user:constrain(_7790,agent)},
    optional([om],_8114,_8089,_8146),
    not_look_ahead([at],_8158,_8146,_8175),
    np1_accept(_7749,_7750,_8187,_8175,_8206),
    !,
    pushstack(first,(lexv(dtv,_7698,_7754,_7755),xnp(_7790,_7791),[noe]),nil,_8206,_8301),vp_kernel(_7698,_7699,_7700,_7701,_7824,_8226,_8301,_8322),
    pushstack(first,(w(prep(about)),xnp(_7749,_7750)),nil,_8322,_8387),
    verb_modifiers0(_7698,_7699,_7701,_7824,_7702,_8346,_8387,_7871).

rvp_kernel(_7698,_7699,_7700,_7701,_7702,[rvp_kernel,_7778,_7827,_7856,!],_7752,_7754) --> 
    lexvaccept(rv,_7698,_7715,_7716,_7700,_7778,_7752,_7803),
    reflexiv0(_7698,_7827,_7803,_7844),
    rvpk(_7698,_7699,id,_7701,_7702,_7856,_7844,_7754),
    !.

rvp_kernel(_7698,_7699,id,_7701,event/real/_7701::_7707 and _7708,[rvp_kernel,_7843,{},_7902,_7931,{},_7970,!,_7999,_8023,{}],_7817,_7819) --> 
    hlexv(rv,_7698,_7753,_7754,_7755,_7843,_7817,_7868),
    {user:testmember(_7698,[know,say])},
    reflexiv0(_7698,_7902,_7868,_7919),
    w(prep(_7770),_7931,_7919,_7948),
    {user:(\+testmember(_7770,[]))},
    which(_7970,_7948,_7985),
    !,
    accept(_7999,_7985,_8014),
    pushstack(first,(w(prep(_7770)),which),nil,_8014,_8064),ppstnp(_7747,_7707,_8023,_8064,_7819),
    {user:tv_template(_7698,_7699,_7747,_7701,_7708)}.

rvp_kernel(adj/nil/_7711,_7699,_7700,_7701,_7704::_7707 and _7708,[rvp_kernel,_7816,_7845,_7874,_7903,_7927,{}],_7790,_7792) --> 
    w(verb(be,_7743,fin),_7816,_7790,_7833),
    negation0(_7700,_7845,_7833,_7862),
    w(adj2(_7711,nil),_7874,_7862,_7891),
    forat(_7903,_7891,_7918),
    clausal_object1(_7759:_7760,_7704::_7708,_7927,_7918,_7792),
    {user:atv_template(_7711,because_of,_7699,_7759:_7760,_7701,_7707)}.

rvpk(_7698,_7699,id,_7701,_7704::_7707 and _7708,[rvpk,{},_7851,lit(hvordan),_7886,!,_7915,_7939,{}],_7815,_7817) --> 
    {user:testmember(_7698,[ask,answer,answer1,discuss,know,know1])},
    omut0(_7851,_7815,_7866),
    cc(hvordan,_7866,_7885),
    endofline0(_7886,_7885,_7901),
    !,
    accept(_7915,_7901,_7930),
    pushstack(first,(w(noun(bus,sin,def,n)),w(verb(go,pres,fin))),nil,_7930,_7952),clausal_object1(_7777:_7778,_7704::_7708,_7939,_7952,_7817),
    {user:co_template(_7698,how,_7699,_7777:_7778,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},_7847,lit(hvordan),!,_7887,{},!,_7931,_7955,{}],_7811,_7813) --> 
    {user:testmember(_7698,[ask,answer,answer1,discuss,know,know1])},
    omut0(_7847,_7811,_7862),
    cc(hvordan,_7862,_7881),
    !,
    negation0(_7700,_7887,_7881,_7904),
    {user:test(rv_templ(_7698,_7772))},
    !,
    accept(_7931,_7904,_7946),
    clausal_object1(_7780:_7781,_7704::_7708,_7955,_7946,_7813),
    {user:co_template(_7698,how,_7699,_7780:_7781,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,_7844,_7878,lit(at),_7918,!,_7952,_7991,{}],_7818,_7820) --> 
    gmem(_7698,[calculate,say,tell,know,decide,believe,doubt,think],_7844,_7818,_7863),
    negation0(_7700,_7878,_7863,_7895),
    cc(at,_7895,_7917),
    look_ahead_lit([hvis,når,selvom],_7918,_7917,_7935),
    !,
    subordinate(_7770,_7771,_7772,_7952,_7935,_7973),
    lock(last,_7973,_8043),pushstack(last,subordinate(_7770,_7771,_7772),nil,_8043,_8049),clausal_object1(_7787:_7788,_7704::_7708,_7991,_8049,_8038),unlock(_8038,_7820),
    {user:tv_template(_7698,_7699,_7787:_7788,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,_7823,_7857,_7881,_7910,_7939,{}],_7797,_7799) --> 
    gmem(_7698,[calculate,fear,hope,know,mean,recognize,think,understand],_7823,_7797,_7842),
    redundant0(_7857,_7842,_7872),
    negation0(_7700,_7881,_7872,_7898),
    not_look_ahead_lit([at,om],_7910,_7898,_7927),
    clausal_object0(_7766:_7767,_7704::_7708,_7939,_7927,_7799),
    {user:tv_template(_7698,_7699,_7766:_7767,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,_7831,_7865,lit(at),_7905,!,_7944,_7968,{}],_7805,_7807) --> 
    gmem(_7698,[do1,paint],_7831,_7805,_7850),
    negation0(_7700,_7865,_7850,_7882),
    cc(at,_7882,_7904),
    np0_accept(_7750,_7751,_7905,_7904,_7924),
    !,
    accept(_7944,_7924,_7959),
    pushstack(first,(xnp(_7750,_7751),w(verb(be,pres,fin))),nil,_7959,_8012),clausal_object1(_7771:_7772,_7704::_7708,_7968,_8012,_7807),
    {user:tv_template(_7698,_7699,_7771:_7772,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},_7824,_7853,lit(at),!,_7893,{}],_7788,_7790) --> 
    {user:testmember(_7698,[base,say,tell])},
    negation0(_7700,_7824,_7788,_7841),
    preadverbials0(_7853,_7841,_7868),
    cc(at,_7868,_7887),
    !,
    clausal_object1(_7757:_7758,_7704::_7708,_7893,_7887,_7790),
    {user:tv_template(_7698,_7699,_7757:_7758,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},_7827,_7856,!,_7890,_7914,{}],_7791,_7793) --> 
    {user:testmember(_7698,[mean,think])},
    pronoun(_7745,_7827,_7791,_7844),
    negation0(_7700,_7856,_7844,_7873),
    !,
    accept(_7890,_7873,_7905),
    pushstack(first,pronoun(_7745),nil,_7905,_7957),clausal_object1(_7760:_7761,_7704::_7708,_7914,_7957,_7793),
    {user:tv_template(_7698,_7699,_7760:_7761,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},_7830,_7859,_7893,lit(å),!,_7953,{}],_7794,_7796) --> 
    {user:testmember(_7698,[regard])},
    negation0(_7700,_7830,_7794,_7847),
    object1(_7748,_7749,_7859,_7847,_7878),
    optional([for],_7893,_7878,_7925),
    cc(å,_7925,_7947),
    !,
    pushstack(first,xnp(_7748,_7749),nil,_7947,_7997),clausal_object1(_7735,_7704::_7708,_7953,_7997,_7796),
    {user:tv_template(_7698,_7699,_7735,_7701,_7707)}.

rvpk(_7698,_7699,id,_7701,_7704::_7707 and _7708,[rvpk,{},_7830,_7874,lit(når),!,_7934,_7958,{}],_7794,_7796) --> 
    {user:testmember(_7698,[wonder])},
    optional([på],_7830,_7794,_7862),
    optional([om],_7874,_7862,_7906),
    cc(når,_7906,_7928),
    !,
    accept(_7934,_7928,_7949),
    clausal_object1(_7763:coevent,_7704::_7708,_7958,_7949,_7796),
    {user:co_template(_7698,when,_7699,_7763:coevent,_7701,_7707)}.

rvpk(_7698,_7699,id,_7701,_7704::_7707 and _7708,[rvpk,{},_7825,lit(om),!,_7885,_7909,{}],_7789,_7791) --> 
    {user:testmember(_7698,[think,wonder])},
    optional([på],_7825,_7789,_7857),
    cc(om,_7857,_7879),
    !,
    accept(_7885,_7879,_7900),
    clausal_object1(_7758:coevent,_7704::_7708,_7909,_7900,_7791),
    {user:co_template(_7698,whether,_7699,_7758:coevent,_7701,_7707)}.

altsogå([altsogå,lit(altså),lit(å)],_7720,_7722) --> 
    cc(altså,_7720,_7741),
    cc(å,_7741,_7722).

altsogå([altsogå,lit(og),lit(å)],_7720,_7722) --> 
    cc(og,_7720,_7741),
    cc(å,_7741,_7722).

ppstnp(_7698,_7699,[ppstnp,_7759,_7788,_7812,_7851],_7742,_7744) --> 
    w(prep(_7711),_7759,_7742,_7776),
    which(_7788,_7776,_7803),
    np_kernel(0,_7698,_7713,_7812,_7803,_7833),
    forwst(_7699,_7711,_7698,_7713,_7851,_7833,_7744).

forwst(_7698,_7699,_7700,_7701,[forwst,_7758],_7735,_7737) --> 
    pushstack(free,adverbial1(_7699,_7700,_7701),nil,_7735,_7800),
    statreal(_7698,_7758,_7800,_7737).

forat([forat,lit(at)],_7715,_7717) --> 
    cc(at,_7715,_7717).

forat([forat,lit(for),lit(at)],_7720,_7722) --> 
    cc(for,_7720,_7741),
    cc(at,_7741,_7722).

forat([forat,lit(fordi)],_7715,_7717) --> 
    cc(fordi,_7715,_7717).

forat([forat,lit(av),lit(at)],_7720,_7722) --> 
    cc(av,_7720,_7741),
    cc(at,_7741,_7722).

forat([forat,lit(over),lit(at)],_7720,_7722) --> 
    cc(over,_7720,_7741),
    cc(at,_7741,_7722).

forat([forat,lit(til),lit(at)],_7720,_7722) --> 
    cc(til,_7720,_7741),
    cc(at,_7741,_7722).

forat([forat,lit(om)],_7715,_7717) --> 
    cc(om,_7715,_7717).

rvpk(_7698,_7699,id,_7701,_7704::_7707 and _7708,[rvpk,{},_7842,lit(hvor),_7877,!,_7911,{}],_7806,_7808) --> 
    {user:testmember(_7698,[ask,answer,answer1,discuss,know,know1])},
    omut0(_7842,_7806,_7857),
    cc(hvor,_7857,_7876),
    w(adj2(_7758,nil),_7877,_7876,_7894),
    !,
    pushstack(free,w(adj2(_7758,nil)),nil,_7894,_7924),clausal_object1(_7775:_7776,_7704::_7708,_7911,_7924,_7808),
    {user:co_template(_7698,how,_7699,_7775:_7776,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,_7847,_7881,_7910,_7934,lit(når),{},!,_7984,!,_8018,_8042,{}],_7821,_7823) --> 
    gmem(_7698,[ask,answer,answer1,discover,discuss,know,know1,say],_7847,_7821,_7866),
    reflexiv0(_7698,_7881,_7866,_7898),
    redundant0(_7910,_7898,_7925),
    omut0(_7934,_7925,_7949),
    cc(når,_7949,_7968),
    {user:test(rv_templ(_7698,_7780))},
    !,
    negation0(_7700,_7984,_7968,_8001),
    !,
    accept(_8018,_8001,_8033),
    clausal_object1(_7790:_7791,_7704::_7708,_8042,_8033,_7823),
    {user:co_template(_7698,when,_7699,_7790:_7791,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},{},lit(_7771),{},!,_7894,!,_7928,_7952,{}],_7822,_7824) --> 
    {user:(\+testmember(_7698,[fail,help,let,lie2,slip,try]))},
    {user:test(rv_templ(_7698,_7770))},
    cc(_7771,_7822,_7878),
    {user:testmember(_7771,[hvorfor,hvordan])},
    !,
    negation0(_7700,_7894,_7878,_7911),
    !,
    accept(_7928,_7911,_7943),
    clausal_object1(_7791:_7792,_7704::_7708,_7952,_7943,_7824),
    {user:co_template(_7698,why,_7699,_7791:_7792,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},_7836,_7865,lit(at),!,_7920,{},[]],_7800,_7802) --> 
    {user:testmember(_7698,[say,tell])},
    negation0(_7700,_7836,_7800,_7853),
    pp(_7734,_7735,_7736,_7865,_7853,_7886),
    cc(at,_7886,_7914),
    !,
    clausal_object1(_7761:_7762,_7704::_7708,_7920,_7914,_7939),
    {user:tv_template(_7698,_7699,_7761:_7762,_7701,_7707)},
    pushstack(free,adverbial1(_7734,_7735,_7736),nil,_7939,_7802),
    [].

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},_7859,_7888,_7912,{},{},!,_7966,_7990,{}],_7823,_7825) --> 
    {user:(\+testmember(_7698,[fail,help,let,lie2,slip,think,try,propose]))},
    reflexiv0(_7698,_7859,_7823,_7876),
    omut0(_7888,_7876,_7903),
    negation0(_7700,_7912,_7903,_7929),
    {user:test(rv_templ(_7698,_7777))},
    {user:(\+verbtype(_7698,tv))},
    !,
    accept(_7966,_7929,_7981),
    clausal_object0(_7792:_7793,_7704::_7708,_7990,_7981,_7825),
    {user:tv_template(_7698,_7699,_7792:_7793,_7701,_7707)}.

at0([at0,lit(at),!],_7718,_7720) --> 
    cc(at,_7718,_7720),
    !.

at0([at0,_7742],_7731,_7733) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de,det],_7742,_7731,_7733).

omut0([omut0,lit(om),!],_7718,_7720) --> 
    cc(om,_7718,_7720),
    !.

omut0([omut0,lit(ut),!],_7718,_7720) --> 
    cc(ut,_7718,_7720),
    !.

omut0([omut0,[]],_7713,_7713) --> 
    [].

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},_7848,lit(om),_7888,!,_7922,!,_7956,_7980,{}],_7812,_7814) --> 
    {user:testmember(_7698,[ask,say,know,know1,answer,answer1])},
    reflexiv0(_7698,_7848,_7812,_7865),
    cc(om,_7865,_7887),
    not_look_ahead_lit([et,en],_7888,_7887,_7905),
    !,
    negation0(_7700,_7922,_7905,_7939),
    !,
    accept(_7956,_7939,_7971),
    clausal_object1(_7781:_7782,_7704::_7708,_7980,_7971,_7814),
    {user:co_template(_7698,whether,_7699,_7781:_7782,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},{},_7863,_7892,lit(at),!,_7932,!,_7966,_7990,{}],_7817,_7819) --> 
    {user:test(rv_templ(_7698,_7753))},
    {user:(\+testmember(_7698,[fail,help,let,lie2,slip,try]))},
    reflexiv0(_7698,_7863,_7817,_7880),
    omut0(_7892,_7880,_7907),
    cc(at,_7907,_7926),
    !,
    negation0(_7700,_7932,_7926,_7949),
    !,
    accept(_7966,_7949,_7981),
    clausal_object1(_7786:_7787,_7704::_7708,_7990,_7981,_7819),
    {user:tv_template(_7698,_7699,_7786:_7787,_7701,_7707)}.

at0([at0,lit(at),!],_7718,_7720) --> 
    cc(at,_7718,_7720),
    !.

at0([at0,_7740],_7729,_7731) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_7740,_7729,_7731).

omut0([omut0,lit(om),!],_7718,_7720) --> 
    cc(om,_7718,_7720),
    !.

omut0([omut0,lit(ut),!],_7718,_7720) --> 
    cc(ut,_7718,_7720),
    !.

omut0([omut0,[]],_7713,_7713) --> 
    [].

rvpk(_7698,_7699,_7700,_7701,_7702,[rvpk,{},_7832,_7876,_7900,!,_7939],_7796,_7798) --> 
    {user:testmember(_7698,[ask,check,discuss,know,know1,tell])},
    optional([om],_7832,_7796,_7864),
    hvilkemange(_7876,_7864,_7891),
    clausal_object0(_7728,_7729,_7900,_7891,_7919),
    !,
    pushstack(first,(w(verb(_7698,pres,fin)),w(prep(about)),xnp(_7728,_7729)),nil,_7919,_7980),
    do_phrase(_7698,_7699,_7700,_7701,_7702,_7939,_7980,_7798).

hvilkemange([hvilkemange,lit(hvilke)],_7715,_7717) --> 
    cc(hvilke,_7715,_7717).

hvilkemange([hvilkemange,lit(hvor),lit(mange)],_7720,_7722) --> 
    cc(hvor,_7720,_7741),
    cc(mange,_7741,_7722).

rvpk(_7698,_7699,id,_7701,_7704::_7707 and _7708,[rvpk,lit(om),lit(å),{},{},!,_7872,{}],_7799,_7801) --> 
    cc(om,_7799,_7835),
    cc(å,_7835,_7846),
    {user:testmember(_7698,[ask])},
    {user:test(rv_templ(_7698,_7752))},
    !,
    pushstack(first,(npgap(_7699),aux1),nil,_7846,_7943),clausal_object1(_7766:coevent,_7704::_7708,_7872,_7943,_7801),
    {user:tv_template(_7698,_7699,_7766:coevent,_7701,_7707)}.

rvpk(_7698,_7699,id,_7701,_7704::_7707 and _7708,[rvpk,_7818,_7852,!,_7901,{}],_7792,_7794) --> 
    gmem(_7698,[need,start,stop,try,use2],_7818,_7792,_7837),
    optional([å],_7852,_7837,_7884),
    !,
    pushstack(first,(npgap(_7699),aux1),nil,_7884,_7972),clausal_object1(_7759:coevent,_7704::_7708,_7901,_7972,_7794),
    {user:tv_template(_7698,_7699,_7759:coevent,_7701,_7707)}.

rvpk(_7698,_7699,id,_7701,_7704::_7707 and _7708,[rvpk,_7880,lit(å),{},!,_7950,_7974,{}],_7854,_7856) --> 
    optional([på],_7880,_7854,_7912),
    cc(å,_7912,_7934),
    {user:testmember(_7698,[avoid,choose,consider,deny,end,expect,forget,hate,hope,learn,like,manage,need,postpone,promise,propose,reach,recommend,refuse,remember,resist,risk,seem,slip,start,think,try,use2,want,wish,wonder])},
    !,
    accept(_7950,_7934,_7965),
    pushstack(first,(npgap(_7699),aux1),nil,_7965,_8045),clausal_object1(_7821:coevent,_7704::_7708,_7974,_8045,_7856),
    {user:tv_template(_7698,_7699,_7821:coevent,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},_7892,_7921,lit(om),_7976,_8010,_8039,!,_8068,_8092,{},_8146,{},{}],_7856,_7858) --> 
    {user:testmember(_7698,[answer,answer1,say])},
    reflexiv0(_7698,_7892,_7856,_7909),
    optional([på],_7921,_7909,_7953),
    cc(om,_7953,_7975),
    np1_accept(_7774,_7775,_7976,_7975,_7995),
    negation0(_7777,_8010,_7995,_8027),
    look_ahead_vp(_8039,_8027,_8054),
    !,
    accept(_8068,_8054,_8083),
    lexv(_7779,_7780,_7781,fin,_8092,_8083,_8115),
    {user:test(rv_templ(_7698,_7789))},
    pushstack(first,(xnp(_7774,_7775),w(verb(_7780,_7781,fin)),negation0(_7777)),nil,_8115,_8223),clausal_object1(_7808:coevent,_7704::_7708,_8146,_8223,_7858),
    {user:tv_template(_7698,_7699,_7808:coevent,_7701,_7752)},
    {user:negate(_7700,_7752,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7702,[rvpk,{},lit(om),_7841,_7880,!,_7914],_7794,_7796) --> 
    {user:testmember(_7698,[ask,worry,tell])},
    cc(om,_7794,_7840),
    np_kernel(0,_7729,_7730,_7841,_7840,_7862),
    look_ahead([som],_7880,_7862,_7897),
    !,
    pushstack(first,(w(verb(_7698,pres,fin)),w(prep(about)),np_kernel(0,_7729,_7730)),nil,_7897,_7956),
    do_phrase(_7698,_7699,_7700,_7701,_7702,_7914,_7956,_7796).

rvpk(_7698,_7699,id,_7701,_7704::_7707 and _7708,[rvpk,{},lit(om),_7830,{}],_7783,_7785) --> 
    {user:testmember(_7698,[ask,check,discuss,know,know1,see])},
    cc(om,_7783,_7829),
    clausal_object1(_7752:coevent,_7704::_7708,_7830,_7829,_7785),
    {user:tv_template(_7698,_7699,_7752:coevent,_7701,_7707)}.

rvpk(_7698,_7699,_7700,_7701,_7702,[rvpk,{},lit(om),_7832,!,_7871],_7785,_7787) --> 
    {user:testmember(_7698,[ask,worry,tell])},
    cc(om,_7785,_7831),
    np1_accept(_7725,_7726,_7832,_7831,_7851),
    !,
    pushstack(first,(w(verb(_7698,pres,fin)),w(prep(about)),xnp(_7725,_7726)),nil,_7851,_7912),
    do_phrase(_7698,_7699,_7700,_7701,_7702,_7871,_7912,_7787).

rvpk(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[rvpk,{},_7849,_7878,_7907,{},!,_7951,_7975,{}],_7813,_7815) --> 
    {user:testmember(_7698,[believe,clculate,know,know1,mean,tell,say])},
    negation0(_7700,_7849,_7813,_7866),
    reflexiv0(_7698,_7878,_7866,_7895),
    not_look_ahead([om],_7907,_7895,_7924),
    {user:test(rv_templ(_7698,_7774))},
    !,
    accept(_7951,_7924,_7966),
    clausal_object0(_7782:_7783,_7704::_7708,_7975,_7966,_7815),
    {user:tv_template(_7698,_7699,_7782:_7783,_7701,_7707)}.

clausal_object0(_7698,_7699,[clausal_object0,_7756,_7785,!,_7824],_7739,_7741) --> 
    look_ahead(w(nb(_7714,_7715)),_7756,_7739,_7773),
    obviousdate(_7698,_7699,_7785,_7773,_7804),
    !,
    accept(_7824,_7804,_7741).

clausal_object0(_7698,_7699,[clausal_object0,_7758,_7787,_7821],_7741,_7743) --> 
    not_look_ahead(w(nb(_7716,_7717)),_7758,_7741,_7775),
    np(_7707,_7708,_7787,_7775,_7806),
    cond_vp(_7707,_7708,_7698,_7699,_7821,_7806,_7743).

cond_vp(_7698,_7699,_7700,_7701,[cond_vp,_7780,{},_7819,!],_7757,_7759) --> 
    look_ahead([_7713],_7780,_7757,_7797),
    {user:testmember(_7713,[du,jeg])},
    lock(last,_7797,_7870),pushstack(last,xnp(_7698,_7699),nil,_7870,_7876),clausal_object1(_7700,_7701,_7819,_7876,_7865),unlock(_7865,_7759),
    !.

cond_vp(_7698,_7699,_7700,_7701,[cond_vp,_7771,_7800,_7824,!],_7748,_7750) --> 
    not_look_ahead([så],_7771,_7748,_7788),
    look_ahead_vp(_7800,_7788,_7815),
    pushstack(first,xnp(_7698,_7699),nil,_7815,_7868),clausal_object1(_7700,_7701,_7824,_7868,_7750),
    !.

cond_vp(_7698,_7699,_7698,_7699,[cond_vp,[]],_7726,_7726) --> 
    [].

clausal_object1(_7713:coevent,_7701::exists(_7713:coevent)::_7713 isa coevent and event/_7713/_7725 and _7711,[clausal_object1,_7772],_7755,_7757) --> 
    substatem(_7725,_7701::_7711,_7772,_7755,_7757).

clausal_object2(_7713:coevent,_7701::exists(_7713:coevent)::_7713 isa coevent and event/_7713/_7725 and _7711,[clausal_object2,_7772],_7755,_7757) --> 
    sostatem(_7725,_7701::_7711,_7772,_7755,_7757).

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7836,{},_7895,_7929,_7973,{},_8057,_8096],_7810,_7812) --> 
    hlexv(dtv,_7698,_7733,_7734,_7728,_7836,_7810,_7861),
    {user:testmember(_7698,[allow,let])},
    ind_object(_7746,_7747,_7895,_7861,_7914),
    optional([å],_7929,_7914,_7961),
    pushstack(first,(xnp(_7746,_7747),[vil]),nil,_7961,_8017),clausal_object1(_7761,_7764::_7705,_7973,_8017,_8032),
    {user:tv_template(_7698,_7699,_7761,_7701,_7776)},
    someevent00(_7701,_7776,_7704::_7764,_8057,_8032,_8078),
    negation2(_7728,_7700,_8096,_8078,_7812).

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7707 and _7708,[vp_kernel,_7878,_7922,_7951,_7980,_8009,_8038,_8072,_8101,{},_8140,{},_8184,_8228],_7852,_7854) --> 
    lexv(dtv,_7698,_7755,fin,_7878,_7852,_7901),
    not_look_ahead(w(adj2(_7762,nil)),_7922,_7901,_7939),
    not_look_ahead(w(nb(_7769,_7770)),_7951,_7939,_7968),
    not_look_ahead_lit([en,et,den,det,han,hun,vi],_7980,_7968,_7997),
    negation0(_7788,_8009,_7997,_8026),
    ind_object(_7790,_7751::_7707,_8038,_8026,_8057),
    negation0(_7796,_8072,_8057,_8089),
    not_look_ahead([så],_8101,_8089,_8118),
    {user:bigno(_7788,_7796,_7700)},
    object(_7808,_7751::_7708,_8140,_8118,_8159),
    {user:dtv_template(_7698,_7699,_7790,_7808,_7701,_7747)},
    optional([til],_8184,_8159,_8216),
    someevent00(_7701,_7747,_7704::_7751,_8228,_8216,_7854).

vp_kernel(notify,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7815,_7864,!,_7898,_7922,{},_7988],_7789,_7791) --> 
    hlexv(tv,notify,_7734,_7735,_7700,_7815,_7789,_7840),
    look_ahead(w(nb(_7742,_7743)),_7864,_7840,_7881),
    !,
    accept(_7898,_7881,_7913),
    lock(exact,_7913,_7942),pushstack(exact,[meg],nil,_7942,_7948),np0_accept(_7750,_7730::_7705,_7922,_7948,_7937),unlock(_7937,_7938),
    {user:tv_template(notify,_7699,_7750,_7701,_7726)},
    someevent00(_7701,_7726,_7704::_7730,_7988,_7938,_7791).

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7821,_7870,_7894,_7933,!,_7977,{},_8011,[]],_7795,_7797) --> 
    lexvaccept(tv,_7698,_7740,fin,_7700,_7821,_7795,_7846),
    redundant0(_7870,_7846,_7885),
    adverbx(_7734,_7735,_7736,_7894,_7885,_7915),
    object2(_7699,_7749,_7752::_7705,_7933,_7915,_7954),
    !,
    accept(_7977,_7954,_7992),
    {user:tv_template(_7698,_7699,_7749,_7701,_7761)},
    someevent00(_7701,_7761,_7704::_7752,_8011,_7992,_8032),
    pushstack(free,adverbx(_7734,_7735,_7736),nil,_8032,_7797),
    [].

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7866,_7915,_7944,{},{},{},{},{},!,_8038,{},_8072],_7840,_7842) --> 
    hlexv(tv,_7698,_7749,_7750,_7700,_7866,_7840,_7891),
    not_look_ahead_lit([om,hver],_7915,_7891,_7932),
    object2(_7699,_7760,_7745::_7705,_7944,_7932,_7965),
    {user:(\+constrain(_7760,date);_7698==have)},
    {user:(\+constrain(_7760,distance))},
    {user:(\+constrain(_7760,minute))},
    {user:(\+constrain(_7760,hour))},
    {user:(\+constrain(_7760,clock))},
    !,
    accept(_8038,_7965,_8053),
    {user:tv_template(_7698,_7699,_7760,_7701,_7741)},
    someevent00(_7701,_7741,_7704::_7745,_8072,_8053,_7842).

vp_kernel(_7698,_7699,_7700,_7701,_7702,[vp_kernel,_7810,_7859,{},{},!,_7918,_7942,_7966,_7995],_7784,_7786) --> 
    hlexv(iv,_7698,_7734,fin,_7700,_7810,_7784,_7835),
    gmem(_7698,[run,pass],_7859,_7835,_7878),
    {user:iv_template(_7698,_7699,_7701,_7729)},
    {user:_7734\==imp},
    !,
    redundants0(_7918,_7878,_7933),
    it0(_7942,_7933,_7957),
    reflexiv0(_7698,_7966,_7957,_7983),
    someevent00(_7701,_7729,_7702,_7995,_7983,_7786).

vp_kernel(have,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7853,_7882,_7906,{},_7945,lit(om),_7985,!,_8019,{},_8072],_7827,_7829) --> 
    negation0(_7744,_7853,_7827,_7870),
    has(_7882,_7870,_7897),
    negation0(_7746,_7906,_7897,_7923),
    {user:bigno(_7744,_7746,_7700)},
    w(noun(information,sin,u,n),_7945,_7923,_7962),
    cc(om,_7962,_7984),
    not_look_ahead_lit([når,å,at],_7985,_7984,_8002),
    !,
    pushstack(first,(w(noun(information,sin,u,n)),w(prep(regarding))),nil,_8002,_8032),np1(_7781,_7742::_7705,_8019,_8032,_8047),
    {user:tv_template(have,_7699,_7781,_7701,_7738)},
    someevent00(_7701,_7738,_7704::_7742,_8072,_8047,_7829).

vp_kernel(have,_7699,_7700,_7701,_7702,[vp_kernel,_7798,_7827,_7851,{},!,_7895],_7772,_7774) --> 
    negation0(_7700,_7798,_7772,_7815),
    has(_7827,_7815,_7842),
    w(adj2(_7724,nil),_7851,_7842,_7868),
    {user:testmember(_7724,[open,closed])},
    !,
    pushstack(first,w(adj2(_7724,nil)),nil,_7868,_7905),
    be_complement(_7699,_7701,_7702,_7895,_7905,_7774).

vp_kernel(have,_7699,_7700,_7701,_7702,[vp_kernel,_7798,lit(det),_7833,_7862,_7891,!,_7940],_7772,_7774) --> 
    has(_7798,_7772,_7813),
    cc(det,_7813,_7832),
    negation0(_7700,_7833,_7832,_7850),
    w(adj2(_7727,nil),_7862,_7850,_7879),
    optional([da],_7891,_7879,_7923),
    !,
    pushstack(first,w(adj2(_7727,nil)),nil,_7923,_7950),
    be_complement(_7699,_7701,_7702,_7940,_7950,_7774).

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7867,_7896,_7925,_7974,{},{},_8023,_8052,_8081,_8105,!,_8149,{},_8183,_8222],_7841,_7843) --> 
    not_look_ahead(w(verb(have,_7757,_7758)),_7867,_7841,_7884),
    not_look_ahead(w(verb(be2,_7765,_7766)),_7896,_7884,_7913),
    hlexv(tv,_7698,_7770,_7771,_7749,_7925,_7913,_7950),
    not_look_ahead(w(prep(_7778)),_7974,_7950,_7991),
    {user:_7698\==have},
    {user:_7698\==be2},
    reflexiv0(_7698,_8023,_7991,_8040),
    particle0(_7698,_8052,_8040,_8069),
    redundant0(_8081,_8069,_8096),
    object2(_7699,_7795,_7798::_7705,_8105,_8096,_8126),
    !,
    accept(_8149,_8126,_8164),
    {user:tv_template(_7698,_7699,_7795,_7701,_7807)},
    someevent00(_7701,_7807,_7704::_7798,_8183,_8164,_8204),
    negation2(_7749,_7700,_8222,_8204,_7843).

menbare([menbare,lit(men)],_7715,_7717) --> 
    cc(men,_7715,_7717).

menbare([menbare,lit(bare)],_7715,_7717) --> 
    cc(bare,_7715,_7717).

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7877,_7906,_7935,{},{},{},_8014,_8053,_8082,{},_8131,_8170,[]],_7851,_7853) --> 
    not_look_ahead(w(verb(have,_7754,_7755)),_7877,_7851,_7894),
    not_look_ahead(w(verb(be2,_7762,_7763)),_7906,_7894,_7923),
    hlexv(tv,_7698,_7767,_7768,_7769,_7935,_7923,_7960),
    {user:_7698\==have},
    {user:_7698\==be2},
    {user:(\+verbtype(_7698,iv))},
    adverb(_7746,_7747,pre,_8014,_7960,_8035),
    not_look_ahead(w(noun(night,_7797,_7798,_7799)),_8053,_8035,_8070),
    object2(_7699,_7802,_7805::_7705,_8082,_8070,_8103),
    {user:tv_template(_7698,_7699,_7802,_7701,_7814)},
    someevent00(_7701,_7814,_7704::_7805,_8131,_8103,_8152),
    negation2(_7769,_7700,_8170,_8152,_8189),
    pushstack(free,xadverb(_7746,_7747),nil,_8189,_7853),
    [].

vp_kernel(be1,_7699,_7700,_7701,_7702,[vp_kernel,_7807,_7831,_7860,{},{},_7909,[]],_7781,_7783) --> 
    be(_7807,_7781,_7822),
    negation0(_7700,_7831,_7822,_7848),
    look_ahead(w(noun(_7735,_7736,_7737,_7738)),_7860,_7848,_7877),
    {user:subclass0(_7735,time)},
    {user:iv_template(be1,_7699,_7701,_7750)},
    someevent00(_7701,_7750,_7702,_7909,_7877,_7930),
    pushstack(free,w(prep(on)),nil,_7930,_7783),
    [].

vp_kernel(be1,_7699,id,_7701,_7702,[vp_kernel,_7809,{},_7843,{},{},_7892,[]],_7783,_7785) --> 
    be(_7809,_7783,_7824),
    {user:vartypeid(_7699,self)},
    look_ahead(w(name(_7738,n,_7740)),_7843,_7824,_7860),
    {user:subclass0(_7740,place)},
    {user:iv_template(be1,_7699,_7701,_7752)},
    someevent00(_7701,_7752,_7702,_7892,_7860,_7913),
    pushstack(free,w(prep(in)),nil,_7913,_7785),
    [].

vp_kernel(be1,_7699,_7700,_7701,_7702,[vp_kernel,_7783,_7807,_7836,{},_7870,_7894],_7757,_7759) --> 
    be(_7783,_7757,_7798),
    negation0(_7700,_7807,_7798,_7824),
    not_look_ahead_np(_7836,_7824,_7851),
    {user:iv_template(be1,_7699,_7701,_7720)},
    redundant0(_7870,_7851,_7885),
    someevent00(_7701,_7720,_7702,_7894,_7885,_7759).

vp_kernel(be1,_7699,_7700,_7701,_7702,[vp_kernel,_7803,_7827,_7856,{},!,{},_7910],_7777,_7779) --> 
    be(_7803,_7777,_7818),
    negation0(_7700,_7827,_7818,_7844),
    look_ahead(w(adv(_7732)),_7856,_7844,_7873),
    {user:testmember(_7732,[redundantly,inside,outside])},
    !,
    {user:iv_template(be1,_7699,_7701,_7723)},
    someevent00(_7701,_7723,_7702,_7910,_7873,_7779).

vp_kernel(be1,_7699,_7700,_7701,_7702,[vp_kernel,_7801,_7825,_7854,{},{},_7903,_7927],_7775,_7777) --> 
    be(_7801,_7775,_7816),
    negation0(_7700,_7825,_7816,_7842),
    look_ahead([_7729],_7854,_7842,_7871),
    {user:testmember(_7729,[her,der,overalt])},
    {user:iv_template(be1,_7699,_7701,_7723)},
    redundant0(_7903,_7871,_7918),
    someevent00(_7701,_7723,_7702,_7927,_7918,_7777).

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7847,{},_7886,_7915,_7949,_7978,_8002,_8031,{},_8080,_8119,!,_8158],_7821,_7823) --> 
    w(verb(_7745,_7746,fin),_7847,_7821,_7864),
    {user:testmember(_7745,[have])},
    negation0(_7756,_7886,_7864,_7903),
    particlev2(_7745,_7698,_7915,_7903,_7934),
    reflexiv0(_7698,_7949,_7934,_7966),
    redundant0(_7978,_7966,_7993),
    not_look_ahead(w(verb(_7767,past,part)),_8002,_7993,_8019),
    object2(_7699,_7772,_7775::_7705,_8031,_8019,_8052),
    {user:tv_template(_7698,_7699,_7772,_7701,_7784)},
    someevent00(_7701,_7784,_7704::_7775,_8080,_8052,_8101),
    negation2(_7756,_7700,_8119,_8101,_8138),
    !,
    accept(_8158,_8138,_7823).

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7858,{},!,_7917,_7946,_7995,_8024,_8048,{},_8097,!,_8141,[]],_7832,_7834) --> 
    lexv(tv,_7698,_7760,_7761,_7858,_7832,_7881),
    {user:testmember(_7698,[lay])},
    !,
    negation0(_7700,_7917,_7881,_7934),
    verb_mod1(_7698,_7750,_7701,_7752,_7755::_7756,_7946,_7934,_7971),
    particle(_7698,_7995,_7971,_8012),
    redundant0(_8024,_8012,_8039),
    object2(_7699,_7784,_7787::_7705,_8048,_8039,_8069),
    {user:tv_template(_7698,_7699,_7784,_7701,_7796)},
    someevent00(_7701,_7796,_7704::_7787,_8097,_8069,_8118),
    !,
    accept(_8141,_8118,_8156),
    pushstack(free,(particle(_7698),verb_mod1(_7698,_7750,_7701,_7752,_7755::_7756)),nil,_8156,_7834),
    [].

vp_kernel(evah,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7797,_7841,_7870,{},_7919],_7771,_7773) --> 
    lexv(tv,evah,_7728,fin,_7797,_7771,_7820),
    negation0(_7700,_7841,_7820,_7858),
    subject2(_7699,_7734,_7737::_7720,_7870,_7858,_7891),
    {user:has_template(_7734,_7699,_7737)},
    someevent00(_7701,_7720,_7704::_7705,_7919,_7891,_7773).

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7705,[vp_kernel,_7826,{},_7885,{},_7924,_7948,{},_7997,_8036],_7800,_7802) --> 
    hlexv(tv,_7698,_7736,_7737,_7731,_7826,_7800,_7851),
    {user:_7698==be2},
    reflexiv0(_7698,_7885,_7851,_7902),
    {user:compliancetest2(tv,_7698,_7699)},
    redundant0(_7924,_7902,_7939),
    object2(_7699,_7754,_7757::_7705,_7948,_7939,_7969),
    {user:tv_template(_7698,_7699,_7754,_7701,_7766)},
    someevent00(_7701,_7766,_7704::_7757,_7997,_7969,_8018),
    negation2(_7731,_7700,_8036,_8018,_7802).

vp_kernel(_7698,_7699,_7700,_7701,_7702,[vp_kernel,_7797,{},{},_7866,_7890,_7914,_7943],_7771,_7773) --> 
    hlexv(iv,_7698,_7728,fin,_7700,_7797,_7771,_7822),
    {user:iv_template(_7698,_7699,_7701,_7723)},
    {user:_7728\==imp},
    redundants0(_7866,_7822,_7881),
    it0(_7890,_7881,_7905),
    reflexiv0(_7698,_7914,_7905,_7931),
    someevent00(_7701,_7723,_7702,_7943,_7931,_7773).

vp_kernel(_7698,_7699,_7700,_7701,_7704::_7705,[vp_kernel,{},_7849,lit(_7746),{},_7899,!,_7933,_8001,_8035],_7813,_7815) --> 
    {user:constrain(_7699,person)},
    not_look_ahead([kan],_7849,_7813,_7866),
    cc(_7746,_7866,_7888),
    {user:testmember(_7746,[må,skal,vil])},
    not_look_ahead(w(verb(_7764,_7765,_7766)),_7899,_7888,_7916),
    !,
    pushstack(first,w(verb(arrive,pres,fin)),nil,_7916,_7946),intrans_verb(_7698,_7699,_7779,_7701,_7732,_7782,_7783,_7933,_7946,_7971),
    negation2(_7779,_7700,_8001,_7971,_8020),
    someevent00(_7701,_7732,_7704::_7705,_8035,_8020,_7815).

worldcomp(_7698,_7699,event/_7698/_7699::_7701,_7701,[worldcomp,[]],_7735,_7735) --> 
    [].

realcomp(_7698,event/real/_7698::_7700,_7700,[realcomp,[]],_7732,_7732) --> 
    [].

someevent00(_7698,_7699,_7702::exists(_7698:event)::_7699 and _7702,[someevent00,[]],_7737,_7737) --> 
    [].

thatto0(_7698,that,_7700,[thatto0,_7754,!,[]],_7734,_7736) --> 
    infinitive(_7754,_7734,_7769),
    !,
    pushstack(free,npgap(_7700),nil,_7769,_7736),
    [].

thatto0(_7698,_7699,_7700,[thatto0,_7753,!,_7787],_7733,_7735) --> 
    w(prep(on),_7753,_7733,_7770),
    !,
    reject(_7787,_7770,_7735).

thatto0(_7698,_7699,_7700,[thatto0,lit(om),_7773,!,_7807],_7742,_7744) --> 
    cc(om,_7742,_7772),
    look_ahead(w(name(_7717,_7718,_7719)),_7773,_7772,_7790),
    !,
    reject(_7807,_7790,_7744).

thatto0(_7698,_7699,_7700,[thatto0,lit(om),_7774,!,_7808],_7743,_7745) --> 
    cc(om,_7743,_7773),
    look_ahead(w(noun(departure,_7718,_7719,n)),_7774,_7773,_7791),
    !,
    reject(_7808,_7791,_7745).

that0(_7698,that,[that0,lit(på),!,_7761],_7728,_7730) --> 
    cc(på,_7728,_7755),
    !,
    reject(_7761,_7755,_7730).

that0(_7698,when,[that0,_7802,lit(når),_7847,_7876,!,_7915,[],!,_7989],_7785,_7787) --> 
    gmem(_7698,[know,know1,think,ask,notify,tell],_7802,_7785,_7821),
    cc(når,_7821,_7846),
    w(verb(_7744,_7745,fin),_7847,_7846,_7864),
    np1(_7748,_7749,_7876,_7864,_7895),
    !,
    accept(_7915,_7895,_7930),
    pushstack(free,(xnp(_7748,_7749),w(verb(_7744,_7745,fin))),nil,_7930,_7983),[],
    !,
    accept(_7989,_7983,_7787).

that0(ask,that,[that0,_7745],_7728,_7730) --> 
    look_ahead(w(verb(_7705,inf,_7707)),_7745,_7728,_7730).

that0(answer,whether,[that0,_7742,lit(om)],_7725,_7727) --> 
    on0(_7742,_7725,_7757),
    cc(om,_7757,_7727).

that0(ask,that,[that0,lit(om),_7759,!,_7788],_7731,_7733) --> 
    cc(om,_7731,_7758),
    infinitive(_7759,_7758,_7774),
    !,
    accept(_7788,_7774,_7733).

that0(ask,whether,[that0,lit(om),!,_7761],_7728,_7730) --> 
    cc(om,_7728,_7755),
    !,
    accept(_7761,_7755,_7730).

that0(ask,that,[that0,_7743,!,_7772],_7726,_7728) --> 
    infinitive(_7743,_7726,_7758),
    !,
    accept(_7772,_7758,_7728).

that0(believe,that,[that0,lit(at),!],_7725,_7727) --> 
    cc(at,_7725,_7727),
    !.

that0(believe,that,[that0,[]],_7720,_7720) --> 
    [].

that0(know,whether,[that0,lit(om),!],_7725,_7727) --> 
    cc(om,_7725,_7727),
    !.

that0(know,that,[that0,lit(at),!],_7725,_7727) --> 
    cc(at,_7725,_7727),
    !.

that0(know,that,[that0,_7753,_7782],_7736,_7738) --> 
    not_look_ahead([en],_7753,_7736,_7770),
    not_look_ahead(w(noun(_7708,_7709,_7710,_7711)),_7782,_7770,_7738).

that0(know1,whether,[that0,lit(om),!],_7725,_7727) --> 
    cc(om,_7725,_7727),
    !.

that0(know1,that,[that0,lit(at),!],_7725,_7727) --> 
    cc(at,_7725,_7727),
    !.

that0(know1,that,[that0,_7753,_7782],_7736,_7738) --> 
    not_look_ahead([en],_7753,_7736,_7770),
    not_look_ahead(w(noun(_7708,_7709,_7710,_7711)),_7782,_7770,_7738).

that0(let,that,[that0,[]],_7720,_7720) --> 
    [].

that0(mean,that,[that0,lit(at),!],_7725,_7727) --> 
    cc(at,_7725,_7727),
    !.

that0(mean,that,[that0,[]],_7720,_7720) --> 
    [].

that0(notify,that,[that0,lit(at)],_7722,_7724) --> 
    cc(at,_7722,_7724).

that0(notify,that,[that0,lit(om),lit(at),!,_7777],_7733,_7735) --> 
    cc(om,_7733,_7760),
    cc(at,_7760,_7771),
    !,
    accept(_7777,_7771,_7735).

that0(notify,_7699,[that0,lit(om),!,_7761],_7728,_7730) --> 
    cc(om,_7728,_7755),
    !,
    reject(_7761,_7755,_7730).

that0(say,that,[that0,lit(at),!],_7725,_7727) --> 
    cc(at,_7725,_7727),
    !.

that0(say,that,[that0,[]],_7720,_7720) --> 
    [].

that0(tell,that,[that0,_7747,!,_7781],_7730,_7732) --> 
    look_ahead([et],_7747,_7730,_7764),
    !,
    reject(_7781,_7764,_7732).

that0(tell,that,[that0,_7747,!,_7781],_7730,_7732) --> 
    look_ahead([en],_7747,_7730,_7764),
    !,
    reject(_7781,_7764,_7732).

that0(tell,that,[that0,lit(at),!],_7725,_7727) --> 
    cc(at,_7725,_7727),
    !.

that0(think,that,[that0,lit(at),!],_7725,_7727) --> 
    cc(at,_7725,_7727),
    !.

that0(think,that,[that0,[]],_7720,_7720) --> 
    [].

that0(understand,how,[that0,lit(hvordan)],_7722,_7724) --> 
    cc(hvordan,_7722,_7724).

that0(want,that,[that0,lit(at),!],_7725,_7727) --> 
    cc(at,_7725,_7727),
    !.

that0(want,to,[that0,lit(og)],_7722,_7724) --> 
    cc(og,_7722,_7724).

that0(wish,that,[that0,_7745],_7728,_7730) --> 
    look_ahead(w(verb(_7705,_7706,_7707)),_7745,_7728,_7730).

that0(_7698,_7699,[that0,_7757,!,_7791,_7820],_7740,_7742) --> 
    that(_7699,_7757,_7740,_7774),
    !,
    not_look_ahead(w(noun(departure,_7717,_7718,_7719)),_7791,_7774,_7808),
    accept(_7820,_7808,_7742).

rep_modifiers0(_7698,_7699,_7700,_7701,_7702,[rep_modifiers0,lit(hvor),!,_7779],_7737,_7739) --> 
    cc(hvor,_7737,_7773),
    !,
    reject(_7779,_7773,_7739).

rep_modifiers0(_7698,_7699,_7700,_7701,_7702,[rep_modifiers0,lit(hva),!,_7779],_7737,_7739) --> 
    cc(hva,_7737,_7773),
    !,
    reject(_7779,_7773,_7739).

rep_modifiers0(_7698,_7699,_7700,_7701,_7702,[rep_modifiers0,{},_7800,{},_7839],_7764,_7766) --> 
    {user:testmember(_7698,[see])},
    look_ahead(w(prep(_7730)),_7800,_7764,_7817),
    {user:testmember(_7730,[in])},
    verb_modifier(_7698,_7699,_7700,_7701,_7702,_7839,_7817,_7766).

rep_modifiers0(_7698,_7699,_7700,_7701,_7702,[rep_modifiers0,{},_7793,_7822],_7757,_7759) --> 
    {user:testmember(_7698,[say,tell])},
    prep1(to,_7793,_7757,_7810),
    pushstack(first,prep(to),nil,_7810,_7862),
    verb_modifiers(_7698,_7699,_7700,_7701,_7702,_7822,_7862,_7759).

rep_modifiers0(_7698,_7699,_7700,_7701,_7701,[rep_modifiers0,[]],_7729,_7729) --> 
    [].

be_complements(_7698,_7699,_7702::_7705 and _7706,[be_complements,lit(at),_7797,!,_7831,_7855,{}],_7766,_7768) --> 
    cc(at,_7766,_7796),
    look_ahead(w(prep(_7737)),_7797,_7796,_7814),
    !,
    preadverbials(_7831,_7814,_7846),
    clausal_object2(_7726,_7702::_7706,_7855,_7846,_7768),
    {user:bealign(_7698,_7726,_7699,_7706,_7705)}.

be_complements(_7698,_7699,_7702::_7705 and _7706,[be_complements,lit(at),!,_7793,_7817,{}],_7757,_7759) --> 
    cc(at,_7757,_7787),
    !,
    accept(_7793,_7787,_7808),
    clausal_object1(_7723,_7702::_7706,_7817,_7808,_7759),
    {user:bealign(_7698,_7723,_7699,_7706,_7705)}.

be_complements(_7698,_7699,_7702::_7705 and _7706,[be_complements,lit(å),!,_7796,_7820,{}],_7760,_7762) --> 
    cc(å,_7760,_7790),
    !,
    accept(_7796,_7790,_7811),
    pushstack(first,someone,nil,_7811,_7861),clausal_object1(_7723,_7702::_7706,_7820,_7861,_7762),
    {user:bealign(_7698,_7723,_7699,_7706,_7705)}.

be_complements(_7698,_7699,_7700,[be_complements,_7761,_7800],_7741,_7743) --> 
    be_complement(_7698,_7699,_7714::_7715,_7761,_7741,_7782),
    be_complements20(_7698,_7699,_7714::_7715,_7700,_7800,_7782,_7743).

be_complements20(_7698,_7699,_7703::_7706,_7703::_7706 or _7707,[be_complements20,lit(eller),_7807,!,_7841,_7880],_7773,_7775) --> 
    cc(eller,_7773,_7806),
    not_look_ahead_lit(['.',?],_7807,_7806,_7824),
    !,
    be_complement(_7698,_7699,_7703::_7745,_7841,_7824,_7862),
    be_complements20(_7698,_7699,_7703::_7745,_7703::_7707,_7880,_7862,_7775).

be_complements20(_7698,_7699,_7703::_7706,_7703::_7706 and _7707,[be_complements20,_7776,_7800,_7839],_7753,_7755) --> 
    be_compl_conjunction(_7776,_7753,_7791),
    be_pred(_7698,_7699,_7720,_7800,_7791,_7821),
    be_complements20(_7698,_7699,_7720,_7703::_7707,_7839,_7821,_7755).

be_complements20(_7698,_7699,_7700,_7700,[be_complements20,_7749],_7726,_7728) --> 
    redundant0(_7749,_7726,_7728).

be_compl_conjunction([be_compl_conjunction,lit(og),!],_7718,_7720) --> 
    cc(og,_7718,_7720),
    !.

be_compl_conjunction([be_compl_conjunction,lit(men),_7751,!],_7729,_7731) --> 
    cc(men,_7729,_7750),
    look_ahead(w(verb(_7710,past,part)),_7751,_7750,_7731),
    !.

be_complement(_7698,_7699,_7700,[be_complement,_7756,_7785],_7736,_7738) --> 
    not_look_ahead_lit([der,her],_7756,_7736,_7773),
    be_pred(_7698,_7699,_7700,_7785,_7773,_7738).

be_complement(_7698,_7699,_7700,[be_complement,_7756,_7785],_7736,_7738) --> 
    not_look_ahead_lit([der,her],_7756,_7736,_7773),
    be_noun(_7698,_7699,_7700,_7785,_7773,_7738).

be_pred(_7698,_7699,_7700,[be_pred,_7780,{},_7834,_7858],_7760,_7762) --> 
    ap(_7717,_7698,_7699,_7714,_7780,_7760,_7803),
    {user:(\+testmember(_7717,[true,whole]))},
    not_look_ahead_nounx(_7834,_7803,_7849),
    verb_modifiers0(adj/nil/_7717,_7698,_7699,_7714,_7700,_7858,_7849,_7762).

be_pred(_7698,_7699,_7700,[be_pred,_7767,_7796,{}],_7747,_7749) --> 
    look_ahead(w(prep(_7718)),_7767,_7747,_7784),
    verb_mod1(be1,_7698,_7699,_7710,_7711,_7796,_7784,_7749),
    {user:thenwhat(_7710,_7711,_7700)}.

be_pred(_7698,_7699,_7700,[be_pred,_7834,_7863,_7892,{},_7931,_7997],_7814,_7816) --> 
    w(nb(_7735,num),_7834,_7814,_7851),
    w(noun(percent,_7729,u,n),_7863,_7851,_7880),
    w(adj2(_7747,nil),_7892,_7880,_7909),
    {user:testmember(_7747,[certain,safe])},
    lock(exact,_7909,_7951),pushstack(exact,w(adj2(_7747,nil)),nil,_7951,_7957),ap(_7747,_7698,_7699,_7770,_7931,_7957,_7946),unlock(_7946,_7947),
    pushstack(first,(w(prep(with)),w(nb(_7735,num)),w(noun(percent,_7729,u,n))),nil,_7947,_8007),
    verb_modifiers0(adj/nil/_7747,_7698,_7699,_7770,_7700,_7997,_8007,_7816).

be_pred(_7698,_7699,_7700,[be_pred,_7827,_7851,_7875,!,_7909,{},_7948,_8014],_7807,_7809) --> 
    ofte0(_7827,_7807,_7842),
    mangenoen(_7851,_7842,_7866),
    w(noun(minute,_7739,u,n),_7875,_7866,_7892),
    !,
    w(adj2(_7745,nil),_7909,_7892,_7926),
    {user:testmember(_7745,[delayed,tooearly])},
    lock(exact,_7926,_7968),pushstack(exact,w(adj2(_7745,nil)),nil,_7968,_7974),ap(_7745,_7698,_7699,_7768,_7948,_7974,_7963),unlock(_7963,_7964),
    pushstack(first,(w(prep(with)),w(noun(minute,plu,u,n))),nil,_7964,_8024),
    verb_modifiers0(adj/nil/_7745,_7698,_7699,_7768,_7700,_8014,_8024,_7809).

ofte0([ofte0,lit(ofte)],_7715,_7717) --> 
    cc(ofte,_7715,_7717).

ofte0([ofte0,[]],_7713,_7713) --> 
    [].

mangenoen([mangenoen,lit(mange)],_7715,_7717) --> 
    cc(mange,_7715,_7717).

mangenoen([mangenoen,lit(flere)],_7715,_7717) --> 
    cc(flere,_7715,_7717).

mangenoen([mangenoen,lit(noen)],_7715,_7717) --> 
    cc(noen,_7715,_7717).

be_pred(_7698,_7699,_7700,[be_pred,_7834,_7863,_7892,{},_7931,_7997],_7814,_7816) --> 
    w(nb(_7735,num),_7834,_7814,_7851),
    w(noun(minute,_7729,u,n),_7863,_7851,_7880),
    w(adj2(_7747,nil),_7892,_7880,_7909),
    {user:testmember(_7747,[delayed,tooearly])},
    lock(exact,_7909,_7951),pushstack(exact,w(adj2(_7747,nil)),nil,_7951,_7957),ap(_7747,_7698,_7699,_7770,_7931,_7957,_7946),unlock(_7946,_7947),
    pushstack(first,(w(prep(with)),w(nb(_7735,num)),w(noun(minute,_7729,u,n))),nil,_7947,_8007),
    verb_modifiers0(adj/nil/_7747,_7698,_7699,_7770,_7700,_7997,_8007,_7816).

be_pred(_7698,_7699,_7700,[be_pred,lit(mer),_7794,_7823,_7889],_7763,_7765) --> 
    cc(mer,_7763,_7793),
    look_ahead([enn],_7794,_7793,_7811),
    lock(exact,_7811,_7843),pushstack(exact,w(adj2(great,nil)),nil,_7843,_7849),ap(_7731,_7698,_7699,_7714,_7823,_7849,_7838),unlock(_7838,_7839),
    verb_modifiers0(adj/nil/_7731,_7698,_7699,_7714,_7700,_7889,_7839,_7765).

be_pred(_7698,_7699,_7702::_7703,[be_pred,_7753],_7733,_7735) --> 
    passive(_7698,_7699,_7702::_7703,_7753,_7733,_7735).

be_pred(_7698,_7699,_7700,[be_pred,_7754,_7793],_7734,_7736) --> 
    comparisons(_7698,_7699,_7706,_7754,_7734,_7775),
    someevent00(_7699,_7706,_7700,_7793,_7775,_7736).

be_pred(_7698,_7699,_7702::_7703,[be_pred,_7767,_7791],_7747,_7749) --> 
    sure(_7767,_7747,_7782),
    pushstack(first,w(verb(know,pres,fin)),nil,_7782,_7801),
    do_phrase(know,_7698,id,_7699,_7702::_7703,_7791,_7801,_7749).

be_pred(_7698,_7699,_7700,[be_pred,_7791,_7835,{},_7874],_7771,_7773) --> 
    ap(_7718,_7698,_7699,_7721,_7791,_7771,_7814),
    look_ahead([hva],_7835,_7814,_7852),
    {user:(\+testmember(_7718,[true,whole]))},
    pushstack(first,w(prep(on)),nil,_7852,_7884),
    verb_modifiers0(adj/nil/_7718,_7698,_7699,_7721,_7700,_7874,_7884,_7773).

fordent0(_7698,[fordent0,_7736,!],_7722,_7724) --> 
    gradverb(_7698,_7736,_7722,_7724),
    !.

fordent0(nil,[fordent0,_7731],_7717,_7719) --> 
    dent0(_7731,_7717,_7719).

not_look_ahead_nounx([not_look_ahead_nounx,_7736,!],_7725,_7727) --> 
    look_ahead(w(noun(clock,sin,def,n)),_7736,_7725,_7727),
    !.

not_look_ahead_nounx([not_look_ahead_nounx,_7733],_7722,_7724) --> 
    not_look_ahead(w(noun(_7702,_7703,_7704,_7705)),_7733,_7722,_7724).

be_noun(_7698,_7699,_7702::exists(_7699:event)::_7706,[be_noun,lit(at),_7790,{},!],_7759,_7761) --> 
    cc(at,_7759,_7789),
    clausal_object1(_7724,_7702::_7728,_7790,_7789,_7761),
    {user:bealign(_7698,_7724,_7699,_7728,_7706)},
    !.

be_noun(_7698,_7699,_7702::exists(_7699:event)::_7706,[be_noun,_7809,_7838,{},!,_7896],_7789,_7791) --> 
    look_ahead(w(nb(_7738,_7739)),_7809,_7789,_7826),
    pushstack(first,w(noun(clock,sin,def,n)),nil,_7826,_7851),obviousclock(_7751,_7754::_7755,_7838,_7851,_7866),
    {user:bealign(_7698,_7751,_7699,_7755,_7763)},
    !,
    verb_modifiers0(exist,_7698,_7699,_7754::_7763,_7702::_7706,_7896,_7866,_7791).

be_noun(_7698,_7699,_7702::exists(_7699:event)::_7706,[be_noun,_7799,_7823,{},_7867,!,_7916],_7779,_7781) --> 
    redundant0(_7799,_7779,_7814),
    object(_7737,_7740::_7741,_7823,_7814,_7842),
    {user:bealign(_7698,_7737,_7699,_7741,_7749)},
    optional([bare],_7867,_7842,_7899),
    !,
    verb_modifiers0(exist,_7698,_7699,_7740::_7749,_7702::_7706,_7916,_7899,_7781).

ap(_7698,_7699,_7700,_7701,[ap,_7767,_7791,_7835,_7859],_7744,_7746) --> 
    mthe10(_7767,_7744,_7782),
    adj1s(_7698,_7699,_7700,_7713,_7791,_7782,_7814),
    redundant0(_7835,_7814,_7850),
    someevent00(_7700,_7713,_7701,_7859,_7850,_7746).

ap(_7698,_7699,_7700,_7701,[ap,_7790,{},{},_7839],_7767,_7769) --> 
    w(verb(_7698,past,part),_7790,_7767,_7807),
    {user:(\+testmember(_7698,[be,have]))},
    {user:adj_template(nil,be/_7698,_7699,_7700,_7713)},
    someevent00(_7700,_7713,_7701,_7839,_7807,_7769).

mthe10([mthe10,lit(mye)],_7715,_7717) --> 
    cc(mye,_7715,_7717).

mthe10([mthe10,_7724],_7713,_7715) --> 
    the0(_7724,_7713,_7715).

passive(_7698,_7699,_7700,[passive,_7834,_7863,_7897,{},_7951,!,_7990],_7814,_7816) --> 
    w(noun(_7737,sin,u,n),_7834,_7814,_7851),
    gmem(_7737,[video,camera],_7863,_7851,_7882),
    lexv(tv,_7757,_7758,part,_7897,_7882,_7920),
    {user:(\+testmember(_7757,[be2,have]))},
    whodidit(_7772,_7773,_7951,_7920,_7970),
    !,
    pushstack(first,(np(_7772,_7773),w(verb(_7757,_7758,fin)),npgap(_7698),w(prep(by)),w(noun(_7737,sin,u,n))),nil,_7970,_8061),
    state(_7699,_7700,_7990,_8061,_7816).

passive(_7698,_7699,_7700,[passive,_7811,{},_7865,_7894,!,_7933],_7791,_7793) --> 
    lexv(dtv,_7729,past,part,_7811,_7791,_7834),
    {user:(\+testmember(_7729,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_7752,_7753)),_7865,_7834,_7882),
    whodidit(_7755,_7756,_7894,_7882,_7913),
    !,
    pushstack(first,(np(_7755,_7756),w(verb(_7729,past,fin)),npgap(_7698)),nil,_7913,_8004),
    state(_7699,_7700,_7933,_8004,_7793).

passive(_7698,_7699,_7700,[passive,_7823,{},_7877,_7906,_7940,!,_7979],_7803,_7805) --> 
    lexv(dtv,_7736,_7737,part,_7823,_7803,_7846),
    {user:(\+testmember(_7736,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_7759,_7760)),_7877,_7846,_7894),
    ind_object(_7732,_7733,_7906,_7894,_7925),
    whodidit(_7765,_7766,_7940,_7925,_7959),
    !,
    pushstack(free,(np(_7765,_7766),w(verb(_7736,_7737,fin)),npgap(_7698),noun_phrase1(_7732,_7733)),nil,_7959,_8081),
    state(_7699,_7700,_7979,_8081,_7805).

passive(_7698,_7699,_7702::_7703,[passive,_7801,lit(om),_7856,!,_7895],_7781,_7783) --> 
    lexv(tv,notify,past,part,_7801,_7781,_7824),
    cc(om,_7824,_7855),
    whodidit(_7738,_7739,_7856,_7855,_7875),
    !,
    lock(last,_7875,_7973),
    pushstack(last,(xnp(_7738,_7739),w(verb(notify,pres,fin)),w(prep(regarding)),npgap(_7698)),nil,_7973,_7979),
    state(_7699,_7702::_7703,_7895,_7979,_7968),
    unlock(_7968,_7783).

passive(_7698,_7699,_7700,[passive,_7814,!,_7858,{},_7912,!,_7951],_7794,_7796) --> 
    adverbial1(_7732,_7733,_7734,_7814,_7794,_7835),
    !,
    lexv(tv,_7741,_7742,part,_7858,_7835,_7881),
    {user:(\+testmember(_7741,[be2,have]))},
    whodidit(_7756,_7757,_7912,_7881,_7931),
    !,
    pushstack(first,(np(_7756,_7757),w(verb(_7741,_7742,fin)),npgap(_7698),adverbial1(_7732,_7733,_7734)),nil,_7931,_8054),
    state(_7699,_7700,_7951,_8054,_7796).

passive(_7698,_7699,_7700,[passive,_7806,{},_7860,_7894,_7918,!,_7957],_7786,_7788) --> 
    lexv(tv,_7732,_7733,part,_7806,_7786,_7829),
    {user:(\+testmember(_7732,[be2,have]))},
    particlev0(_7732,_7748,_7860,_7829,_7879),
    redundant0(_7894,_7879,_7909),
    whodidit(_7750,_7751,_7918,_7909,_7937),
    !,
    pushstack(first,(np(_7750,_7751),w(verb(_7748,_7733,fin)),npgap(_7698)),nil,_7937,_8028),
    state(_7699,_7700,_7957,_8028,_7788).

passive(_7698,_7699,_7700,[passive,_7845,{},_7899,lit(og),_7934,{},!,_7998,!,_8037],_7825,_7827) --> 
    lexv(tv,_7747,past,part,_7845,_7825,_7868),
    {user:(\+testmember(_7747,[be2,have]))},
    redundant0(_7899,_7868,_7914),
    cc(og,_7914,_7933),
    hlexv(tv,_7765,past,part,id,_7934,_7933,_7959),
    {user:(\+testmember(_7747,[be2,have]))},
    !,
    whodidit(_7781,_7782,_7998,_7959,_8017),
    !,
    pushstack(first,(np(_7781,_7782),w(verb(_7747,past,fin)),[og],w(verb(_7765,past,fin)),npgap(_7698)),nil,_8017,_8108),
    state(_7699,_7700,_8037,_8108,_7827).

whodidit(_7698,_7699,[whodidit,lit(av),lit(at),_7778,!,_7817],_7739,_7741) --> 
    cc(av,_7739,_7766),
    cc(at,_7766,_7777),
    clausal_object1(_7698,_7699,_7778,_7777,_7797),
    !,
    accept(_7817,_7797,_7741).

whodidit(_7698,_7699,[whodidit,_7746,!,_7775],_7729,_7731) --> 
    by(_7746,_7729,_7761),
    !,
    np(_7698,_7699,_7775,_7761,_7731).

whodidit(_7698,_7699,[whodidit,_7756,!,_7817],_7739,_7741) --> 
    lock(exact,_7739,_7776),pushstack(exact,w(noun(agent,sin,u,n)),nil,_7776,_7782),np1(_7698,_7699,_7756,_7782,_7771),unlock(_7771,_7772),
    !,
    accept(_7817,_7772,_7741).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7806,lit(det),lit(å),_7872,_7915,!,_7954],_7783,_7785) --> 
    lexv(tv,_7731,_7732,fin,_7806,_7783,_7829),
    cc(det,_7829,_7860),
    cc(å,_7860,_7871),
    pushstack(first,[noen],nil,_7871,_7885),clausal_object1(_7744,_7728,_7872,_7885,_7900),
    traceprint(4,qv0a,_7915,_7900,_7934),
    !,
    pushstack(first,(lexv(tv,_7731,_7732,fin),xnp(_7698,_7728)),nil,_7934,_8028),
    verb_phrase(_7744,_7699,_7700,_7701,_7954,_8028,_7785).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7861,{},{},_7925,_7959,_7988,_8017,{},_8061,_8090,_8114,!,_8153],_7838,_7840) --> 
    lexv(tv,_7757,_7758,fin,_7861,_7838,_7884),
    {user:_7757\==ask},
    {user:_7757\==have},
    subject(_7771,_7772,_7925,_7884,_7944),
    negation0(_7699,_7959,_7944,_7976),
    not_look_ahead([om],_7988,_7976,_8005),
    object(_7780,_7781,_8017,_8005,_8036),
    {user:subject_object_test(_7757,_7771,_7780)},
    w(prep(_7791),_8061,_8036,_8078),
    not_look_ahead_np(_8090,_8078,_8105),
    traceprint(4,qv0b,_8114,_8105,_8133),
    !,
    pushstack(first,(xnp(_7771,_7772),w(verb(_7757,pres,fin)),xnp(_7780,_7781),w(prep(_7791)),npgap(_7698)),nil,_8133,_8255),
    state(_7700,_7701,_8153,_8255,_7840).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7841,{},_7895,_7929,_7958,_7987,_8011,!,_8050,{},_8084],_7818,_7820) --> 
    lexv(iv,_7748,_7749,fin,_7841,_7818,_7864),
    {user:(\+testmember(_7748,[think]))},
    subject(_7761,_7762,_7895,_7864,_7914),
    negation0(_7699,_7929,_7914,_7946),
    w(prep(_7768),_7958,_7946,_7975),
    not_look_ahead_np(_7987,_7975,_8002),
    traceprint(4,qv1,_8011,_8002,_8030),
    !,
    accept(_8050,_8030,_8065),
    {user:adjustprepv(_7748,_7768,_7777)},
    pushstack(first,(xnp(_7761,_7762),w(verb(_7748,_7749,fin)),w(prep(_7777)),npgap(_7698)),nil,_8065,_8155),
    state(_7700,_7701,_8084,_8155,_7820).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7821,_7865,_7899,_7923,[],_7997,!,_8036],_7798,_7800) --> 
    lexv(rv,_7740,pres,fin,_7821,_7798,_7844),
    subject(_7744,_7745,_7865,_7844,_7884),
    infinitive(_7899,_7884,_7914),
    w(verb(do,inf,fin),_7923,_7914,_7940),
    pushstack(free,xnp(_7698,_7745),nil,_7940,_7996),[],
    traceprint(4,qv2,_7997,_7996,_8016),
    !,
    pushstack(first,(w(verb(_7740,pres,fin)),[å],w(verb(do,inf,fin))),nil,_8016,_8046),
    verb_phrase(_7744,_7699,_7700,_7701,_8036,_8046,_7800).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7820,_7864,_7898,_7932,_7956,!,[],_8040],_7797,_7799) --> 
    lexv(dtv,_7739,_7740,fin,_7820,_7797,_7843),
    subject(_7743,_7744,_7864,_7843,_7883),
    ind_object(_7746,_7747,_7898,_7883,_7917),
    omaa(_7932,_7917,_7947),
    traceprint(4,qv3,_7956,_7947,_7975),
    !,
    pushstack(free,xnp(_7698,_7744),nil,_7975,_8039),[],
    pushstack(first,(w(verb(_7739,_7740,fin)),xnp(_7746,_7747),[om],[å]),nil,_8039,_8081),
    verb_phrase(_7743,_7699,_7700,_7701,_8040,_8081,_7799).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7822,{},{},_7886,_7920,{},_7964,!,_8003],_7799,_7801) --> 
    lexv(tv,_7737,_7738,fin,_7822,_7799,_7845),
    {user:_7737\==ask},
    {user:_7737\==have},
    subject(_7751,_7734,_7886,_7845,_7905),
    particlev0(_7737,_7755,_7920,_7905,_7939),
    {user:subject_object_test(_7737,_7751,_7698)},
    traceprint(4,qv4,_7964,_7939,_7983),
    !,
    pushstack(first,(lexv(tv,_7755,_7738,fin),xnp(_7698,_7734)),nil,_7983,_8077),
    verb_phrase(_7751,_7699,_7700,_7701,_8003,_8077,_7801).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7836,_7860,_7889,_7923,_7967,{},{},_8016,!,_8055,{}],_7813,_7815) --> 
    aux1(_7836,_7813,_7851),
    negation0(_7735,_7860,_7851,_7877),
    subject(_7741,_7742,_7889,_7877,_7908),
    lexv(tv,_7745,inf,fin,_7923,_7908,_7946),
    not_look_ahead([om],_7967,_7946,_7984),
    {user:_7745\==have},
    {user:test(tv_template(_7745,_7741,_7698,_7700,_7766))},
    traceprint(4,qv5,_8016,_7984,_8035),
    !,
    pushstack(first,(lexv(tv,_7745,pres,fin),xnp(_7698,_7742)),nil,_8035,_8130),verb_phrase(_7741,_7736,_7700,_7701,_8055,_8130,_7815),
    {user:bigno(_7735,_7736,_7699)}.

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7826,_7850,_7884,_7913,_7942,_7971,!,_8010],_7803,_7805) --> 
    aux1(_7826,_7803,_7841),
    subject(_7739,_7737,_7850,_7841,_7869),
    w(verb(be,inf,fin),_7884,_7869,_7901),
    w(adj2(_7750,_7751),_7913,_7901,_7930),
    w(prep(_7755),_7942,_7930,_7959),
    traceprint(4,qv6,_7971,_7959,_7990),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_7750,_7751)),w(prep(_7755)),xnp(_7698,_7737)),nil,_7990,_8051),
    verb_phrase(_7739,_7699,_7700,_7701,_8010,_8051,_7805).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7805,lit(du),_7840,_7869,_7898,!,_7937],_7782,_7784) --> 
    has(_7805,_7782,_7820),
    cc(du,_7820,_7839),
    negation0(_7699,_7840,_7839,_7857),
    prepnom(_7735,_7869,_7857,_7886),
    traceprint(4,qv7,_7898,_7886,_7917),
    !,
    pushstack(first,([du],w(verb(have,pres,fin)),npgap(_7698),w(prep(_7735))),nil,_7917,_7977),
    state(_7700,_7701,_7937,_7977,_7784).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7826,_7850,_7884,_7913,_7942,!,_7981],_7803,_7805) --> 
    has(_7826,_7803,_7841),
    np1_accept(_7739,_7736::_7737,_7850,_7841,_7869),
    w(noun(_7747,_7748,_7749,n),_7884,_7869,_7901),
    prepnom(_7752,_7913,_7901,_7930),
    traceprint(4,qv8,_7942,_7930,_7961),
    !,
    pushstack(free,(w(verb(have,pres,fin)),w(noun(_7747,sin,u,n)),w(prep(_7752)),noun_phrase1(_7698,_7736::_7737)),nil,_7961,_8025),
    do_phrase(have,_7739,_7699,_7700,_7701,_7981,_8025,_7805).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7826,_7850,_7884,_7913,{},_7952,_7991,!,_8030],_7803,_7805) --> 
    has(_7826,_7803,_7841),
    subject(_7741,_7742,_7850,_7841,_7869),
    negation0(_7699,_7884,_7869,_7901),
    w(verb(_7748,_7749,part),_7913,_7901,_7930),
    {user:testmember(_7748,[go])},
    defaultprep(_7748,_7698,_7761,_7952,_7930,_7973),
    traceprint(4,qv9,_7991,_7973,_8010),
    !,
    pushstack(first,(xnp(_7741,_7742),w(verb(_7748,_7749,fin)),prep1(_7761),npgap(_7698)),nil,_8010,_8132),
    state(_7700,_7701,_8030,_8132,_7805).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7804,_7828,_7862,_7891,_7920,!,_7959],_7781,_7783) --> 
    has(_7804,_7781,_7819),
    subject(_7732,_7733,_7828,_7819,_7847),
    negation0(_7699,_7862,_7847,_7879),
    w(verb(_7739,past,part),_7891,_7879,_7908),
    traceprint(4,qv10,_7920,_7908,_7939),
    !,
    pushstack(first,(xnp(_7732,_7733),w(verb(_7739,past,fin)),npgap(_7698)),nil,_7939,_8030),
    state(_7700,_7701,_7959,_8030,_7783).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7801,_7825,_7859,_7888,_7917,!,_7956],_7778,_7780) --> 
    has(_7801,_7778,_7816),
    np1_accept(_7733,_7734,_7825,_7816,_7844),
    negation0(_7699,_7859,_7844,_7876),
    w(verb(_7729,_7730,part),_7888,_7876,_7905),
    traceprint(4,qv11,_7917,_7905,_7936),
    !,
    pushstack(first,(xnp(_7733,_7734),w(verb(_7729,_7730,fin))),nil,_7936,_7997),
    verb_phrase(_7698,id,_7700,_7701,_7956,_7997,_7780).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,lit(kan),_7818,_7852,_7886,_7915,!,_7954],_7784,_7786) --> 
    cc(kan,_7784,_7817),
    subject(_7732,_7728,_7818,_7817,_7837),
    negation2(id,_7699,_7852,_7837,_7871),
    not_look_ahead(w(verb(_7742,_7743,_7744)),_7886,_7871,_7903),
    traceprint(4,qv12,_7915,_7903,_7934),
    !,
    lock(last,_7934,_8002),
    pushstack(last,(w(verb(know1,pres,fin)),xnp(_7698,_7728)),nil,_8002,_8008),
    do_phrase(_7749,_7732,id,_7700,_7701,_7954,_8008,_7997),
    unlock(_7997,_7786).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7823,_7852,_7886,_7920,_7949,_7978,!,_8017],_7800,_7802) --> 
    w(verb(_7737,_7738,fin),_7823,_7800,_7840),
    gmem(_7737,[talk,speak],_7852,_7840,_7871),
    subject(_7748,_7749,_7886,_7871,_7905),
    negation0(_7699,_7920,_7905,_7937),
    look_ahead(w(prep(_7757)),_7949,_7937,_7966),
    traceprint(4,qv13a,_7978,_7966,_7997),
    !,
    lock(last,_7997,_8095),
    pushstack(last,(xnp(_7698,_7749),w(verb(_7737,_7738,fin)),negation(_7699)),nil,_8095,_8101),
    do_phrase(_7762,_7748,id,_7700,_7701,_8017,_8101,_8090),
    unlock(_8090,_7802).

qverb_phrase(_7698,id,_7700,_7701,[qverb_phrase,_7799,_7823,_7857,_7886,!,_7925],_7776,_7778) --> 
    aux1(_7799,_7776,_7814),
    subject(_7729,_7730,_7823,_7814,_7842),
    w(verb(be,_7735,fin),_7857,_7842,_7874),
    traceprint(4,qv15c,_7886,_7874,_7905),
    !,
    pushstack(first,(xnp(_7729,_7730),w(verb(be,pres,fin)),npgap(_7698)),nil,_7905,_7996),
    state(_7700,_7701,_7925,_7996,_7778).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7785,_7809,_7843,_7877,!,_7916],_7762,_7764) --> 
    docan(_7785,_7762,_7800),
    subject(_7724,_7722,_7809,_7800,_7828),
    negation2(id,_7699,_7843,_7828,_7862),
    traceprint(4,qv13b,_7877,_7862,_7896),
    !,
    lock(last,_7896,_7964),
    pushstack(last,xnp(_7698,_7722),nil,_7964,_7970),
    do_phrase(_7733,_7724,id,_7700,_7701,_7916,_7970,_7959),
    unlock(_7959,_7764).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,{},_7829,_7853,_7887,lit(av),_7927,!,_7966],_7796,_7798) --> 
    {user:constrain(_7698,place)},
    aux1(_7829,_7796,_7844),
    np1_accept(_7743,_7746::_7747,_7853,_7844,_7872),
    negation0(_7699,_7887,_7872,_7904),
    cc(av,_7904,_7926),
    traceprint(4,qv14,_7927,_7926,_7946),
    !,
    pushstack(first,(noun_phrase1(_7743,_7746::_7747),w(verb(go,pres,fin)),[av],npgap(_7698)),nil,_7946,_8040),
    state(_7700,_7701,_7966,_8040,_7798).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7834,_7863,_7887,_7921,_7950,_7979,_8008,!,_8047],_7811,_7813) --> 
    w(verb(be,pres,_7748),_7834,_7811,_7851),
    thereit0(_7863,_7851,_7878),
    np1_accept(_7750,_7753::_7754,_7887,_7878,_7906),
    negation0(_7699,_7921,_7906,_7938),
    w(verb(_7760,_7761,part),_7950,_7938,_7967),
    prep(_7764,_7979,_7967,_7996),
    traceprint(4,qv15,_8008,_7996,_8027),
    !,
    pushstack(first,(someone,w(verb(_7760,_7761,fin)),noun_phrase1(_7750,_7753::_7754),w(prep(_7764)),npgap(_7698)),nil,_8027,_8149),
    state(_7700,_7701,_8047,_8149,_7813).

qverb_phrase(_7698,id,_7700,_7701,[qverb_phrase,_7826,_7855,_7889,_7918,_7947,!,_7986],_7803,_7805) --> 
    w(verb(be,_7741,fin),_7826,_7803,_7843),
    subject(_7744,_7745,_7855,_7843,_7874),
    w(adj2(_7749,nil),_7889,_7874,_7906),
    w(prep(_7754),_7918,_7906,_7935),
    traceprint(4,qv15a,_7947,_7935,_7966),
    !,
    pushstack(first,(xnp(_7744,_7745),w(verb(be,pres,fin)),w(adj2(_7749,nil)),w(prep(_7754)),npgap(_7698)),nil,_7966,_8057),
    state(_7700,_7701,_7986,_8057,_7805).

qverb_phrase(_7698,id,_7700,_7701,[qverb_phrase,_7796,_7825,_7859,!,_7898],_7773,_7775) --> 
    w(verb(be,_7729,fin),_7796,_7773,_7813),
    subject(_7732,_7733,_7825,_7813,_7844),
    traceprint(4,qv15b,_7859,_7844,_7878),
    !,
    pushstack(first,(xnp(_7732,_7733),w(verb(be,pres,fin)),npgap(_7698)),nil,_7878,_7969),
    state(_7700,_7701,_7898,_7969,_7775).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7825,_7854,_7878,_7912,_7941,_7970,{},_8004,!,_8043],_7802,_7804) --> 
    w(verb(be,_7747,fin),_7825,_7802,_7842),
    thereit0(_7854,_7842,_7869),
    np1_accept(_7750,_7751,_7878,_7869,_7897),
    negation0(_7699,_7912,_7897,_7929),
    prep(_7755,_7941,_7929,_7958),
    not_look_ahead_np(_7970,_7958,_7985),
    {user:_7755\==towards},
    traceprint(4,qv16,_8004,_7985,_8023),
    !,
    pushstack(first,(xnp(_7750,_7751),w(verb(be1,pres,fin)),prep(_7755),npgap(_7698)),nil,_8023,_8144),
    state(_7700,_7701,_8043,_8144,_7804).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7888,{},_7942,_7976,_8005,_8039,_8068,_8092,!,{},{},_8151],_7865,_7867) --> 
    lexv(tv,_7754,_7755,fin,_7888,_7865,_7911),
    {user:(\+testmember(_7754,[pass,be1,be,be2,cost,have,know1]))},
    np1_accept(_7779,_7782::_7783,_7942,_7911,_7961),
    negation0(_7699,_7976,_7961,_7993),
    np1_accept(_7698,_7790::_7791,_8005,_7993,_8024),
    prep1(_7793,_8039,_8024,_8056),
    endofline(_8068,_8056,_8083),
    traceprint(4,qv17,_8092,_8083,_8111),
    !,
    {user:(\+testmember(_7793,[off,of]))},
    {user:test(verb_compl(_7754,_7793,_7779,_7698,_7817,_7818))},
    pushstack(first,(noun_phrase1(_7779,_7782::_7783),lexv(tv,_7754,_7755,fin),noun_phrase1(_7698,_7790::_7791),prep1(_7793),npgap(_7698)),nil,_8111,_8322),
    state(_7700,_7701,_8151,_8322,_7867).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7896,_7925,_7954,{},{},_8018,_8042,_8076,_8105,{},{},_8164,_8188,!,_8227],_7873,_7875) --> 
    not_look_ahead([kan],_7896,_7873,_7913),
    not_look_ahead(w(verb(be,_7768,_7769)),_7925,_7913,_7942),
    lexv(_7771,_7772,_7773,fin,_7954,_7942,_7977),
    {user:(_7771==iv;_7771==rv)},
    {user:(\+testmember(_7772,[pass]))},
    thereit0(_8018,_7977,_8033),
    np1_accept(_7796,_7799::_7800,_8042,_8033,_8061),
    negation0(_7699,_8076,_8061,_8093),
    defaultprep(_7772,_7698,_7806,_8105,_8093,_8126),
    {user:(\+testmember(_7806,[off,of]))},
    {user:test(verb_compl(_7772,_7806,_7796,_7698,_7827,_7828))},
    qtrailer0(_8164,_8126,_8179),
    traceprint(4,qv18,_8188,_8179,_8207),
    !,
    pushstack(first,(noun_phrase1(_7796,_7799::_7800),w(verb(_7772,_7773,fin)),prep1(_7806),npgap(_7698)),nil,_8207,_8331),
    state(_7700,_7701,_8227,_8331,_7875).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,{},_7860,{},_7899,_7928,_7962,_7991,_8030,!,_8069],_7827,_7829) --> 
    {user:constrain(_7698,place)},
    w(verb(_7751,_7752,fin),_7860,_7827,_7877),
    {user:(\+testmember(_7751,[be,take,pass]))},
    not_look_ahead([det],_7899,_7877,_7916),
    np1_accept(_7772,_7775::_7776,_7928,_7916,_7947),
    negation0(_7699,_7962,_7947,_7979),
    defaultprep(_7751,_7698,_7782,_7991,_7979,_8012),
    traceprint(4,qv19,_8030,_8012,_8049),
    !,
    pushstack(first,(noun_phrase1(_7772,_7775:_7776),w(verb(_7751,pres,fin)),prep1(_7782),npgap(_7698)),nil,_8049,_8170),
    state(_7700,_7701,_8069,_8170,_7829).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7850,{},_7904,_7938,{},_7977,{},_8016,!,_8055],_7827,_7829) --> 
    lexv(iv,_7745,_7746,fin,_7850,_7827,_7873),
    {user:_7745\==be1},
    np1_accept(_7754,_7757::_7758,_7904,_7873,_7923),
    negation0(_7699,_7938,_7923,_7955),
    {user:constrain(_7754,vehicle)},
    prep1(_7767,_7977,_7955,_7994),
    {user:testmember(_7767,[to,from,past,by,on])},
    traceprint(4,qv20,_8016,_7994,_8035),
    !,
    pushstack(first,(noun_phrase1(_7754,_7757::_7758),w(verb(_7745,pres,fin)),prep1(_7767),npgap(_7698)),nil,_8035,_8159),
    state(_7700,_7701,_8055,_8159,_7829).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7800,_7824,_7858,_7902,!,_7941],_7777,_7779) --> 
    do(_7800,_7777,_7815),
    noun_phrase1(_7730,_7727::_7728,_7824,_7815,_7843),
    lexv(_7736,know1,_7738,fin,_7858,_7843,_7881),
    traceprint(4,qv21,_7902,_7881,_7921),
    !,
    pushstack(first,(lexv(_7736,know1,_7738,fin),np(_7698,_7727::_7728)),nil,_7921,_8016),
    verb_phrase(_7730,_7699,_7700,_7701,_7941,_8016,_7779).

qverb_phrase(_7698,_7699,_7700,_7703::_7704,[qverb_phrase,_7794,_7818,_7852,_7876,!,_7915],_7771,_7773) --> 
    use(_7794,_7771,_7809),
    noun_phrase1(_7729,_7732::_7704,_7818,_7809,_7837),
    in_order_to(_7852,_7837,_7867),
    traceprint(4,qv22,_7876,_7867,_7895),
    !,
    pushstack(free,(prep(with),npgap(_7698)),nil,_7895,_7985),
    verb_phrase(_7729,_7699,_7700,_7703::_7732,_7915,_7985,_7773).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7793,_7817,_7846,_7875,!,_7914],_7770,_7772) --> 
    be(_7793,_7770,_7808),
    thereit2(be,_7817,_7808,_7834),
    not_look_ahead(w(noun(_7733,_7734,u,_7736)),_7846,_7834,_7863),
    traceprint(4,qv23,_7875,_7863,_7894),
    !,
    pushstack(first,w(verb(exist,pres,fin)),nil,_7894,_7924),
    verb_phrase1(exist,_7698,_7699,_7700,_7701,_7914,_7924,_7772).

qverb_phrase(_7698,id,_7700,_7701,[qverb_phrase,{},_7831,{},_7885,{},_7929,!,_7968],_7798,_7800) --> 
    {user:constrain(_7698,route)},
    lexv(iv,_7741,_7742,fin,_7831,_7798,_7854),
    {user:testmember(_7741,[go])},
    subject(_7752,_7753,_7885,_7854,_7904),
    {user:constrain(_7752,vehicle)},
    traceprint(4,qv24,_7929,_7904,_7948),
    !,
    lock(last,_7948,_8046),
    pushstack(last,(xnp(_7752,_7753),w(verb(_7741,_7742,fin)),npgap(_7698)),nil,_8046,_8052),
    state(_7700,_7701,_7968,_8052,_8041),
    unlock(_8041,_7800).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7809,_7853,{},_7897,_7926,!,_7965],_7786,_7788) --> 
    lexv(tv,_7731,_7732,fin,_7809,_7786,_7832),
    subject(_7735,_7728,_7853,_7832,_7872),
    {user:subject_object_test(_7731,_7735,_7698)},
    not_look_ahead(w(prep(_7748)),_7897,_7872,_7914),
    traceprint(4,qv25,_7926,_7914,_7945),
    !,
    pushstack(first,(lexv(tv,_7731,_7732,fin),xnp(_7698,_7728)),nil,_7945,_8039),
    verb_phrase(_7735,_7699,_7700,_7701,_7965,_8039,_7788).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7774,_7803,!,_7842],_7751,_7753) --> 
    look_ahead(w(verb(be,_7722,fin)),_7774,_7751,_7791),
    traceprint(4,qv26,_7803,_7791,_7822),
    !,
    verb_phrase(_7698,_7699,_7700,_7701,_7842,_7822,_7753).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7793,{},_7832,_7861,!,_7900],_7770,_7772) --> 
    not_look_ahead(w(verb(be,_7728,fin)),_7793,_7770,_7810),
    {user:vartypeid(_7698,thing)},
    look_ahead(w(verb(_7740,_7741,fin)),_7832,_7810,_7849),
    traceprint(4,qv27,_7861,_7849,_7880),
    !,
    verb_phrase(_7698,_7699,_7700,_7701,_7900,_7880,_7772).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7804,lit(du),_7844,_7868,_7902,lit(kan),_7947,!,_7986],_7781,_7783) --> 
    w(verb(believe,pres,fin),_7804,_7781,_7821),
    cc(du,_7821,_7843),
    that0(_7844,_7843,_7859),
    noun_phrase1(_7741,_7731,_7868,_7859,_7887),
    negation2(id,_7699,_7902,_7887,_7921),
    cc(kan,_7921,_7946),
    traceprint(4,qv28,_7947,_7946,_7966),
    !,
    pushstack(free,xnp(_7698,_7731),nil,_7966,_8027),
    do_phrase(believe,_7741,id,_7700,_7701,_7986,_8027,_7783).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7788,_7812,_7846,_7880,_7904,!,_7943],_7765,_7767) --> 
    do(_7788,_7765,_7803),
    noun_phrase1(_7727,_7725,_7812,_7803,_7831),
    negation2(id,_7699,_7846,_7831,_7865),
    redundant0x(_7880,_7865,_7895),
    traceprint(4,qv29,_7904,_7895,_7923),
    !,
    lock(last,_7923,_7991),
    pushstack(last,xnp(_7698,_7725),nil,_7991,_7997),
    do_phrase(_7736,_7727,id,_7700,_7701,_7943,_7997,_7986),
    unlock(_7986,_7767).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7823,{},_7877,_7901,_7935,_7959,_7988,!,_8027],_7800,_7802) --> 
    lexv(iv,_7740,_7741,fin,_7823,_7800,_7846),
    {user:(\+testmember(_7740,[know,know1,be1]))},
    thereit(_7877,_7846,_7892),
    noun_phrase1(_7757,_7737,_7901,_7892,_7920),
    adverbx0(_7935,_7920,_7950),
    prep0(_7760,_7959,_7950,_7976),
    traceprint(4,qv30,_7988,_7976,_8007),
    !,
    pushstack(first,(lexv(iv,_7740,_7741,fin),prep(_7760),xnp(_7698,_7737)),nil,_8007,_8131),
    verb_phrase(_7757,_7699,_7700,_7701,_8027,_8131,_7802).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7811,_7835,_7869,_7913,_7937,_7981,!,_8020],_7788,_7790) --> 
    has(_7811,_7788,_7826),
    np1_accept(_7736,_7733::_7734,_7835,_7826,_7854),
    lexv(rv,_7743,past,part,_7869,_7854,_7892),
    infinitive(_7913,_7892,_7928),
    lexv(tv,_7748,inf,fin,_7937,_7928,_7960),
    traceprint(4,qv31,_7981,_7960,_8000),
    !,
    pushstack(first,(lexv(tv,_7748,pres,fin),np(_7698,_7733::_7734)),nil,_8000,_8097),
    verb_phrase(_7736,_7699,_7700,_7701,_8020,_8097,_7790).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7800,_7824,_7858,_7902,!,_7941],_7777,_7779) --> 
    has(_7800,_7777,_7815),
    np1_accept(_7730,_7727::_7728,_7824,_7815,_7843),
    lexv(tv,_7737,past,part,_7858,_7843,_7881),
    traceprint(4,qv32,_7902,_7881,_7921),
    !,
    pushstack(first,(lexv(tv,_7737,past,fin),np(_7698,_7727::_7728)),nil,_7921,_8016),
    verb_phrase(_7730,_7699,_7700,_7701,_7941,_8016,_7779).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7797,_7821,{},_7865,!,_7904],_7774,_7776) --> 
    has(_7797,_7774,_7812),
    np1_accept(_7727,_7725,_7821,_7812,_7840),
    {user:has_template(_7727,_7698,_7734)},
    traceprint(4,qv33,_7865,_7840,_7884),
    !,
    pushstack(free,(w(verb(have,pres,fin)),noun_phrase1(_7698,_7725)),nil,_7884,_7945),
    do_phrase(have,_7727,_7699,_7700,_7701,_7904,_7945,_7776).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7828,_7852,_7886,_7930,_7964,_7993,!,_8032],_7805,_7807) --> 
    has(_7828,_7805,_7843),
    np1_accept(_7742,_7739::_7740,_7852,_7843,_7871),
    lexv(tv,_7749,past,part,_7886,_7871,_7909),
    noun_phrase1(_7753,_7756::_7757,_7930,_7909,_7949),
    prep(_7759,_7964,_7949,_7981),
    traceprint(4,qv34,_7993,_7981,_8012),
    !,
    pushstack(first,(lexv(tv,_7749,past,fin),np(_7753,_7756::_7757),prep(_7759),np(_7698,_7739::_7740)),nil,_8012,_8173),
    verb_phrase(_7742,_7699,_7700,_7701,_8032,_8173,_7807).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7784,{},_7823,!,_7862],_7761,_7763) --> 
    not_look_ahead(w(verb(be,_7725,fin)),_7784,_7761,_7801),
    {user:(\+vartypeid(_7698,thing))},
    traceprint(4,qv35,_7823,_7801,_7842),
    !,
    verb_phrase(_7698,_7699,_7700,_7701,_7862,_7842,_7763).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,{},_7804,_7833,_7857,!,_7896],_7771,_7773) --> 
    {user:(\+vartypeid(_7698,thing))},
    w(verb(_7723,_7724,fin),_7804,_7771,_7821),
    thereit0(_7833,_7821,_7848),
    traceprint(4,qv36,_7857,_7848,_7876),
    !,
    pushstack(first,w(verb(_7723,_7724,fin)),nil,_7876,_7906),
    verb_phrase(_7698,_7699,_7700,_7701,_7896,_7906,_7773).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7797,_7841,_7865,_7952,!,_7991],_7774,_7776) --> 
    lexv(_7727,_7728,_7729,fin,_7797,_7774,_7820),
    thereit(_7841,_7820,_7856),
    lock(exact,_7856,_7916),pushstack(exact,this,nil,_7916,_7922),npa(_7735,_7725,_7865,_7922,_7911),unlock(_7911,_7912),
    traceprint(4,qv37,_7952,_7912,_7971),
    !,
    pushstack(first,(lexv(_7727,_7728,_7729,fin),xnp(_7698,_7725)),nil,_7971,_8065),
    verb_phrase(_7735,_7699,_7700,_7701,_7991,_8065,_7776).

qverb_phrase(_7698,_7699,_7700,_7701,[qverb_phrase,_7846,{},_7900,_7934,_7963,_8002,!,_8041,_8065,_8104],_7823,_7825) --> 
    lexv(iv,_7748,_7749,fin,_7846,_7823,_7869),
    {user:(\+testmember(_7748,[think]))},
    np1_accept(_7761,_7762,_7900,_7869,_7919),
    negation0(_7699,_7934,_7919,_7951),
    adverbial1(_7766,_7767,_7770::_7771,_7963,_7951,_7984),
    traceprint(4,qv38,_8002,_7984,_8021),
    !,
    accept(_8041,_8021,_8056),
    defaultprep(_7748,_7698,_7778,_8065,_8056,_8086),
    pushstack(first,(xnp(_7761,_7762),lexv(iv,_7748,_7749,fin),adverbial1(_7766,_7767,_7770::_7771),prep1(_7778),npgap(_7698)),nil,_8086,_8273),
    state(_7700,_7701,_8104,_8273,_7825).

verb_modifiers0(_7698,_7699,_7700,_7701,_7702,[verb_modifiers0,lit(hva),!,_7779],_7737,_7739) --> 
    cc(hva,_7737,_7773),
    !,
    reject(_7779,_7773,_7739).

verb_modifiers0(_7698,_7699,_7700,_7701,_7702,[verb_modifiers0,_7761],_7735,_7737) --> 
    verb_modifiers(_7698,_7699,_7700,_7701,_7702,_7761,_7735,_7737).

verb_modifiers0(_7698,_7699,_7700,_7701,_7702,[verb_modifiers0,_7767,!,_7796],_7741,_7743) --> 
    redundant(_7767,_7741,_7782),
    !,
    verb_modifiers(_7698,_7699,_7700,_7701,_7702,_7796,_7782,_7743).

verb_modifiers0(_7698,_7699,_7700,_7701,_7701,[verb_modifiers0,{}],_7736,_7736) --> 
    {user:(\+_7698=be1)}.

verb_modifiers(_7698,_7699,_7700,_7701,_7702,[verb_modifiers,_7776,!,_7830,_7854],_7750,_7752) --> 
    verb_modifier(_7698,_7699,_7700,_7701,_7716,_7776,_7750,_7801),
    !,
    accept(_7830,_7801,_7845),
    verb_modifiers10(_7698,_7699,_7700,_7716,_7702,_7854,_7845,_7752).

verb_modifiers10(_7698,_7699,_7700,_7701,_7702,[verb_modifiers10,_7767,_7791,_7815],_7741,_7743) --> 
    vmod_conjunction(_7767,_7741,_7782),
    look_ahead_prepadv(_7791,_7782,_7806),
    verb_modifiers(_7698,_7699,_7700,_7701,_7702,_7815,_7806,_7743).

verb_modifiers10(go,_7699,_7700,_7701,_7702,[verb_modifiers10,_7787,_7811,!,_7845,_7869],_7761,_7763) --> 
    numberroute(_7787,_7761,_7802),
    look_ahead(w(nb(_7727,num)),_7811,_7802,_7828),
    !,
    accept(_7845,_7828,_7860),
    pushstack(first,w(prep(with)),nil,_7860,_7879),
    verb_modifiers(go,_7699,_7700,_7701,_7702,_7869,_7879,_7763).

verb_modifiers10(_7698,_7699,_7700,_7701,_7702,[verb_modifiers10,_7775,_7799,_7828],_7749,_7751) --> 
    point(_7775,_7749,_7790),
    look_ahead(w(name(_7720,_7721,_7722)),_7799,_7790,_7816),
    verb_modifiers0(_7698,_7699,_7700,_7701,_7702,_7828,_7816,_7751).

verb_modifiers10(_7698,_7699,_7700,_7701,_7702,[verb_modifiers10,_7761],_7735,_7737) --> 
    verb_modifiers0(_7698,_7699,_7700,_7701,_7702,_7761,_7735,_7737).

verb_modifiers10(_7698,_7699,_7700,_7701,_7701,[verb_modifiers10,[]],_7729,_7729) --> 
    [].

look_ahead_prepadv([look_ahead_prepadv,_7733,!],_7722,_7724) --> 
    look_ahead(w(prep(_7705)),_7733,_7722,_7724),
    !.

look_ahead_prepadv([look_ahead_prepadv,_7733,!],_7722,_7724) --> 
    look_ahead(w(adv(_7705)),_7733,_7722,_7724),
    !.

verb_modifier(_7698,_7699,_7700,_7710 and _7704::_7705,_7704::_7705,[verb_modifier,_7810,_7839,{},{}],_7784,_7786) --> 
    thisplace(_7733,_7810,_7784,_7827),
    not_look_ahead([jegdu],_7839,_7827,_7786),
    {user:verb_compl(_7698,_7733,_7699,_7748:place,_7700,_7731)},
    {user:_7710=(findexternal(_7748:place)::_7748 isa place and _7731)}.

verb_modifier(_7698,_7699,_7700,_7710 and _7704::_7708,_7704::_7705,[verb_modifier,_7773],_7747,_7749) --> 
    verb_mod1(_7698,_7699,_7700,_7710,_7708::_7705,_7773,_7747,_7749).

verb_modifier(_7698,_7699,_7700,_7710 and _7704::_7705,_7704::_7705,[verb_modifier,_7779,!,{}],_7753,_7755) --> 
    today(_7779,_7753,_7755),
    !,
    {user:adv_compl(_7698,today,_7699,time,_7700,_7710)}.

verb_modifier(_7698,_7699,_7700,_7701,_7701,[verb_modifier,_7763,!,_7797],_7737,_7739) --> 
    particlev1(_7698,_7763,_7737,_7780),
    !,
    accept(_7797,_7780,_7739).

verb_modifier(_7698,_7699,_7700,_7701,_7701,[verb_modifier,{},_7777],_7741,_7743) --> 
    {user:testmember(_7698,[want])},
    reflexiv(_7698,_7777,_7741,_7743).

verb_modifier(_7698,_7699,_7700,_7710 and _7704::_7708,_7704::_7705,[verb_modifier,{},_7808,_7852,{}],_7772,_7774) --> 
    {user:_7698\==be1},
    lexv(iv,_7737,pres,part,_7808,_7772,_7831),
    verb_modifier3(_7737,_7699,_7727,_7708,_7705,_7852,_7831,_7774),
    {user:verb_compl(_7698,during,_7699,_7727,_7700,_7710)}.

verb_modifier(_7698,_7699,_7700,_7704 and _7711::_7708,_7704::_7705,[verb_modifier,_7794,_7818,{}],_7768,_7770) --> 
    this(_7794,_7768,_7809),
    pushstack(first,(prep(in),this),nil,_7809,_7889),adverbial(_7722,_7724,_7708::_7705,_7818,_7889,_7770),
    {user:verb_compl(_7698,_7722,_7699,_7724,_7700,_7711)}.

verb_modifier(_7698,_7699,_7700,_7710 and _7704::_7705,_7704::_7705,[verb_modifier,_7780,{}],_7754,_7756) --> 
    partday(_7719,_7721,_7727,_7780,_7754,_7756),
    {user:adv_compl(_7698,_7719,_7699,_7721,_7700,_7710)}.

verb_modifier(_7698,_7699,_7700,_7710 and _7704::_7708,_7704::_7705,[verb_modifier,_7794,_7823,{},!,_7877],_7768,_7770) --> 
    nil_compl(_7698,_7794,_7768,_7811),
    adjunct1(nil,_7728,_7708::_7705,_7823,_7811,_7844),
    {user:verb_compl(_7698,nil,_7699,_7728,_7700,_7710)},
    !,
    accept(_7877,_7844,_7770).

verb_modifier(_7698,_7699,_7700,_7710 and _7704::_7708,_7704::_7705,[verb_modifier,_7794,_7823,{},!,_7877],_7768,_7770) --> 
    dir_compl(_7698,_7794,_7768,_7811),
    adjunct1(dir,_7728,_7708::_7705,_7823,_7811,_7844),
    {user:verb_compl(_7698,dir,_7699,_7728,_7700,_7710)},
    !,
    accept(_7877,_7844,_7770).

verb_modifier(adj/nil/_7708,_7699,_7700,_7716 and _7704::_7714,_7704::_7705,[verb_modifier,_7807,_7831,_7880,{}],_7781,_7783) --> 
    infinitive(_7807,_7781,_7822),
    subordinateinfnosubj(nil,coevent,_7699,_7733,_7741,_7831,_7822,_7856),
    determiner00(_7733,_7714,_7741::_7705,_7880,_7856,_7783),
    {user:verb_compl(adj/nil/_7708,in_order_to,_7699,_7733,_7700,_7716)}.

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,_7811,_7845,{},_7884,!,_7923,{}],_7785,_7787) --> 
    gmem(_7698,[be1,go,arrive,depart],_7811,_7785,_7830),
    w(prep(_7725),_7845,_7830,_7862),
    {user:testmember(_7725,[before,after,between])},
    plausibleclock(_7727,_7702,_7884,_7862,_7903),
    !,
    accept(_7923,_7903,_7787),
    {user:verb_compl(_7698,_7725,_7699,_7727,_7700,_7701)}.

verb_mod1(look,_7699,_7700,_7701,_7704::_7705,[verb_mod1,_7800,lit(ut),!,_7845,{}],_7774,_7776) --> 
    w(adj2(_7730,_7731),_7800,_7774,_7817),
    cc(ut,_7817,_7839),
    !,
    lock(exact,_7839,_7865),pushstack(exact,w(adv(_7730)),nil,_7865,_7871),adverbix(_7722,_7724,_7704::_7705,_7845,_7871,_7860),unlock(_7860,_7776),
    {user:verb_compl(look,_7722,_7699,_7724,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,_7802,_7836,{},!,_7880,{}],_7776,_7778) --> 
    gmem(_7698,[be1],_7802,_7776,_7821),
    w(prep(_7722),_7836,_7821,_7853),
    {user:(\+member(_7722,[between,for]))},
    !,
    np1_accept(_7724,_7702,_7880,_7853,_7778),
    {user:verb_compl(_7698,_7722,_7699,_7724,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,lit(som),_7796,!,_7830,{}],_7759,_7761) --> 
    cc(som,_7759,_7795),
    w(prep(in),_7796,_7795,_7813),
    !,
    np1_accept(_7721,_7702,_7830,_7813,_7761),
    {user:verb_compl(_7698,as_in,_7699,_7721,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,lit(som),!,_7794,{}],_7752,_7754) --> 
    cc(som,_7752,_7788),
    !,
    np1_accept(_7718,_7702,_7794,_7788,_7754),
    {user:verb_compl(_7698,as,_7699,_7718,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,_7815,_7849,{},_7888,!,_7922,{}],_7789,_7791) --> 
    gmem(_7698,[exist],_7815,_7789,_7834),
    one_of_lit([til,før],_7849,_7834,_7866),
    {user:(vartypeid(_7699,_7747),subclass0(_7747,duration))},
    not_look_ahead(w(name(_7757,n,place)),_7888,_7866,_7905),
    !,
    clausal_object0(_7727,_7702,_7922,_7905,_7791),
    {user:verb_compl(_7698,until,_7699,_7727,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,{},lit(_7737),{},{},!,_7858,{}],_7786,_7788) --> 
    {user:testmember(_7698,[exist])},
    cc(_7737,_7786,_7832),
    {user:testmember(_7737,[siden])},
    {user:(vartypeid(_7699,_7752),subclass0(_7752,duration))},
    !,
    clausal_object0(_7727,_7702,_7858,_7832,_7788),
    {user:verb_compl(_7698,since,_7699,_7727,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,{},lit(med),lit(at),!,_7830,{}],_7767,_7769) --> 
    {user:testmember(_7698,[mean])},
    cc(med,_7767,_7813),
    cc(at,_7813,_7824),
    !,
    clausal_object1(_7724,_7702,_7830,_7824,_7769),
    {user:verb_compl(_7698,with,_7699,_7724,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},_7827,_7856,!,_7890,{}],_7791,_7793) --> 
    {user:testmember(_7698,[ask])},
    not_look_ahead([nå],_7827,_7791,_7844),
    look_ahead(w(verb(_7746,inf,fin)),_7856,_7844,_7873),
    !,
    pushstack(first,(npgap(_7699),[vil]),nil,_7873,_7933),clausal_object1(_7727,_7704::_7705,_7890,_7933,_7793),
    {user:verb_compl(_7698,regarding,_7699,_7727,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,{},lit(om),_7818,!,_7852,{}],_7771,_7773) --> 
    {user:testmember(_7698,[notify,take])},
    cc(om,_7771,_7817),
    not_look_ahead([en],_7818,_7817,_7835),
    !,
    clausal_object0(_7724,_7702,_7852,_7835,_7773),
    {user:verb_compl(_7698,regarding,_7699,_7724,_7700,_7701)}.

verb_mod1(adj/nil/_7705,_7699,_7700,_7701,_7702,[verb_mod1,{},_7823,!,_7857,{}],_7787,_7789) --> 
    {user:testmember(_7705,[delayed])},
    w(nb(_7740,num),_7823,_7787,_7840),
    !,
    pushstack(first,(w(prep(with)),w(nb(_7740,num))),nil,_7840,_7870),pp(with,_7727,_7702,_7857,_7870,_7789),
    {user:adj_compl(_7705,with,_7699,_7727,_7700,_7701)}.

utenå([utenå,lit(uten),_7746,_7770,!],_7724,_7726) --> 
    cc(uten,_7724,_7745),
    ogå(_7746,_7745,_7761),
    måtte(_7770,_7761,_7726),
    !.

utenå([utenå,lit(uten),_7740],_7718,_7720) --> 
    cc(uten,_7718,_7739),
    ogå(_7740,_7739,_7720).

måtte([måtte,_7736],_7725,_7727) --> 
    one_of_lit([måtte,ville,skulle,burde,kunne],_7736,_7725,_7727).

verb_mod1(adj/nil/_7705,_7699,_7700,_7701,_7702,[verb_mod1,{},_7804,!,_7833,{}],_7768,_7770) --> 
    {user:testmember(_7705,[afraid,happy])},
    foratx0(_7804,_7768,_7819),
    !,
    clausal_object1(_7727,_7702,_7833,_7819,_7770),
    {user:adj_compl(_7705,because_of,_7699,_7727,_7700,_7701)}.

foratx0([foratx0,lit(for),lit(at)],_7720,_7722) --> 
    cc(for,_7720,_7741),
    cc(at,_7741,_7722).

foratx0([foratx0,lit(at)],_7715,_7717) --> 
    cc(at,_7715,_7717).

foratx0([foratx0,_7740],_7729,_7731) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_7740,_7729,_7731).

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,{},_7798,_7822,{},!],_7762,_7764) --> 
    {user:testmember(_7698,[label,be_named])},
    look_ahead_np(_7798,_7762,_7813),
    np0_accept(_7725,_7702,_7822,_7813,_7764),
    {user:verb_compl(_7698,with,_7699,_7725,_7700,_7701)},
    !.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},lit(enn),lit(å),!,_7847,{}],_7784,_7786) --> 
    {user:(\+testmember(_7698,[be,be1,be2]))},
    cc(enn,_7784,_7830),
    cc(å,_7830,_7841),
    !,
    pushstack(first,[noen],nil,_7841,_7860),clausal_object1(_7727,_7704::_7705,_7847,_7860,_7786),
    {user:verb_compl(_7698,than,_7699,_7727,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},lit(enn),lit(at),!,_7842,{}],_7779,_7781) --> 
    {user:(\+testmember(_7698,[be,be1,be2]))},
    cc(enn,_7779,_7825),
    cc(at,_7825,_7836),
    !,
    clausal_object1(_7727,_7704::_7705,_7842,_7836,_7781),
    {user:verb_compl(_7698,than,_7699,_7727,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},lit(enn),_7818,{}],_7771,_7773) --> 
    {user:(\+testmember(_7698,[be,be1,be2]))},
    cc(enn,_7771,_7817),
    np1(_7721,_7704::_7705,_7818,_7817,_7773),
    {user:verb_compl(_7698,than,_7699,_7721,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,{},_7814,{},!,_7858,{}],_7778,_7780) --> 
    {user:testmember(_7698,[notify,wait])},
    w(prep(_7722),_7814,_7778,_7831),
    {user:(\+testmember(_7722,[for]))},
    !,
    clausal_object0(_7724,_7702,_7858,_7831,_7780),
    {user:verb_compl(_7698,_7722,_7699,_7724,_7700,_7701)}.

verb_mod1(adj/nil/_7708,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},_7838,lit(å),!,_7898,{}],_7802,_7804) --> 
    {user:testmember(_7708,[nice,good,bad,interested,interesting])},
    optional(w(prep(_7756)),_7838,_7802,_7870),
    cc(å,_7870,_7892),
    !,
    pushstack(first,npgap(_7699),nil,_7892,_7941),clausal_object1(_7733,_7704::_7705,_7898,_7941,_7804),
    {user:verb_compl(adj/nil/_7708,because_of,_7699,_7733,_7700,_7701)}.

overat([overat,lit(fordi)],_7715,_7717) --> 
    cc(fordi,_7715,_7717).

overat([overat,lit(av),lit(at)],_7720,_7722) --> 
    cc(av,_7720,_7741),
    cc(at,_7741,_7722).

overat([overat,lit(over),lit(at)],_7720,_7722) --> 
    cc(over,_7720,_7741),
    cc(at,_7741,_7722).

overat([overat,lit(til),lit(at)],_7720,_7722) --> 
    cc(til,_7720,_7741),
    cc(at,_7741,_7722).

verb_mod1(adj/nil/_7705,_7699,_7700,_7701,_7702,[verb_mod1,{},lit(av),lit(hvilken),!,_7842,{}],_7779,_7781) --> 
    {user:(\+testmember(_7705,[]))},
    cc(av,_7779,_7825),
    cc(hvilken,_7825,_7836),
    !,
    np1(_7730,_7702,_7842,_7836,_7781),
    {user:verb_compl(adj/nil/_7705,of,_7699,_7730,_7700,_7701)}.

verb_mod1(adj/nil/_7708,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},_7819,!,_7848,{}],_7783,_7785) --> 
    {user:(\+testmember(_7708,[]))},
    overaa(_7819,_7783,_7834),
    !,
    pushstack(first,npgap(_7699),nil,_7834,_7891),clausal_object1(_7730,_7704::_7705,_7848,_7891,_7785),
    {user:verb_compl(adj/nil/_7708,because_of,_7699,_7730,_7700,_7701)}.

overaa([overaa,lit(av),lit(å)],_7720,_7722) --> 
    cc(av,_7720,_7741),
    cc(å,_7741,_7722).

overaa([overaa,lit(over),lit(å)],_7720,_7722) --> 
    cc(over,_7720,_7741),
    cc(å,_7741,_7722).

overaa([overaa,lit(til),lit(å)],_7720,_7722) --> 
    cc(til,_7720,_7741),
    cc(å,_7741,_7722).

verb_mod1(_7698,_7699,_7700,_7701,_7702,[verb_mod1,{},_7806,lit(å),!,_7846,{}],_7770,_7772) --> 
    {user:(\+testmember(_7698,[]))},
    instead_of(_7806,_7770,_7821),
    cc(å,_7821,_7840),
    !,
    pushstack(first,npgap(_7699),nil,_7840,_7889),clausal_object1(_7724,_7702,_7846,_7889,_7772),
    {user:verb_compl(_7698,instead_of,_7699,_7724,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7704,[verb_mod1,_7800,_7829,{},_7878,{}],_7774,_7776) --> 
    gradverb0(_7728,_7800,_7774,_7817),
    adverb(_7722,_7724,_7732,_7829,_7817,_7850),
    {user:testmember(_7722,[slowly,fast,thereafter])},
    not_look_ahead([det],_7878,_7850,_7776),
    {user:adv_compl(_7698,_7722,_7699,_7724,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},lit(om),lit(å),!,_7841,{}],_7778,_7780) --> 
    {user:testmember(_7698,[ask])},
    cc(om,_7778,_7824),
    cc(å,_7824,_7835),
    !,
    pushstack(first,npgap(_7699),nil,_7835,_7884),clausal_object1(_7727,_7704::_7705,_7841,_7884,_7780),
    {user:verb_compl(_7698,regarding,_7699,_7727,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},_7825,_7869,lit(å),!,_7929,{}],_7789,_7791) --> 
    {user:testmember(_7698,[extend,help])},
    optional([til],_7825,_7789,_7857),
    optional([med],_7869,_7857,_7901),
    cc(å,_7901,_7923),
    !,
    pushstack(first,npgap(_7699),nil,_7923,_7972),clausal_object1(_7730,_7704::_7705,_7929,_7972,_7791),
    {user:verb_compl(_7698,with,_7699,_7730,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,_7780,!,{}],_7754,_7756) --> 
    xadverbial1(_7716,_7718,_7704::_7705,_7780,_7754,_7756),
    !,
    {user:verb_compl(_7698,_7716,_7699,_7718,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},_7812,!,_7846,_7870,{}],_7776,_7778) --> 
    {user:testmember(_7698,[talk,speak])},
    look_ahead([om],_7812,_7776,_7829),
    !,
    accept(_7846,_7829,_7861),
    adverbial1(regarding,_7727,_7704::_7705,_7870,_7861,_7778),
    {user:verb_compl(_7698,regarding,_7699,_7727,_7700,_7701)}.

verb_mod1(adj/_7711/_7708,_7699,_7700,_7701,_7704::_7705,[verb_mod1,_7783,{}],_7757,_7759) --> 
    adverbial4(_7719,_7721,_7704::_7705,_7783,_7757,_7759),
    {user:adj_compl(_7708,_7719,_7699,_7721,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},_7805,{}],_7769,_7771) --> 
    {user:(\+testmember(_7698,[know,know1,speak,hope]))},
    adverbial3(_7716,_7718,_7704::_7705,_7805,_7769,_7771),
    {user:verb_compl(_7698,_7716,_7699,_7718,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},_7820,!,_7854,_7878,{}],_7784,_7786) --> 
    {user:testmember(_7698,[know,know1,ask,tell,speak,think])},
    look_ahead([om],_7820,_7784,_7837),
    !,
    accept(_7854,_7837,_7869),
    adverbial1(regarding,_7727,_7704::_7705,_7878,_7869,_7786),
    {user:verb_compl(_7698,regarding,_7699,_7727,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,srel/_7717/time/_7711/_7700,_7704::_7704,[verb_mod1,_7824,{},_7863,{},{},!,_7917],_7798,_7800) --> 
    w(prep(_7717),_7824,_7798,_7841),
    {user:testmember(_7717,[to,until])},
    w(adv(_7711),_7863,_7841,_7880),
    {user:testmember(_7711,[tomorrow])},
    {user:verb_compl(_7698,_7717,_7699,_7770:time,_7700,_7768)},
    !,
    accept(_7917,_7880,_7800).

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7704,[verb_mod1,_7773,{}],_7747,_7749) --> 
    xadverb(_7713,_7715,_7773,_7747,_7749),
    {user:adv_compl(_7698,_7713,_7699,_7715,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,_7777,{}],_7751,_7753) --> 
    adverbix(_7713,_7715,_7704::_7705,_7777,_7751,_7753),
    {user:verb_compl(_7698,_7713,_7699,_7715,_7700,_7701)}.

verb_mod1(_7698,_7699,_7700,_7701,_7704::_7705,[verb_mod1,{},_7848,_7877,{},{},!,_7941],_7812,_7814) --> 
    {user:(\+testmember(_7698,[go]))},
    nil_compl(_7698,_7848,_7812,_7865),
    adjunct1(nil,_7737,_7704::_7705,_7877,_7865,_7898),
    {user:(constrain(_7737,time);constrain(_7737,departure);constrain(_7737,arrival);constrain(_7737,route);constrain(_7737,number);constrain(_7737,bus))},
    {user:verb_compl(_7698,nil,_7699,_7737,_7700,_7701)},
    !,
    accept(_7941,_7898,_7814).

dir_compl(_7698,[dir_compl,{},!,_7759],_7730,_7732) --> 
    {user:v_compl(_7698,_7709,dir,_7711)},
    !,
    accept(_7759,_7730,_7732).

nil_compl(_7698,[nil_compl,_7746,_7780,!],_7732,_7734) --> 
    gmem(_7698,[have],_7746,_7732,_7765),
    look_ahead_lit([hver],_7780,_7765,_7734),
    !.

nil_compl(be/_7701,[nil_compl,{},!,_7762],_7733,_7735) --> 
    {user:a_compl(_7701,_7712,nil,_7714)},
    !,
    accept(_7762,_7733,_7735).

nil_compl(adj/nil/_7701,[nil_compl,{},!],_7733,_7733) --> 
    {user:(\+testmember(_7701,[]))},
    !.

nil_compl(adj/nil/_7701,[nil_compl,{},!,_7764],_7735,_7737) --> 
    {user:(\+post_adjective(_7701))},
    !,
    reject(_7764,_7735,_7737).

nil_compl(go,[nil_compl,_7953,{},_7992,_8021,_8050,_8079,_8108,_8137,_8166,_8195,_8224,_8253,_8282,_8311,_8340,_8369,_8398,_8427,_8456,_8485,_8514,_8543,_8572,!,_8606],_7939,_7941) --> 
    w(nb(_7774,num),_7953,_7939,_7970),
    {user:_7774<100},
    not_look_ahead(w(noun(time_count,plu,u,n)),_7992,_7970,_8009),
    not_look_ahead(w(nb(_7795,num)),_8021,_8009,_8038),
    not_look_ahead([:],_8050,_8038,_8067),
    not_look_ahead([?],_8079,_8067,_8096),
    not_look_ahead(['.'],_8108,_8096,_8125),
    not_look_ahead([/],_8137,_8125,_8154),
    not_look_ahead([den],_8166,_8154,_8183),
    not_look_ahead(w(name(_7822,_7823,month)),_8195,_8183,_8212),
    not_look_ahead(w(name(new_years_day,_7831,date)),_8224,_8212,_8241),
    not_look_ahead(w(name(whitsun_day,_7839,date)),_8253,_8241,_8270),
    not_look_ahead(w(name(christmas_day,_7847,date)),_8282,_8270,_8299),
    not_look_ahead(w(name(easterday,_7855,date)),_8311,_8299,_8328),
    not_look_ahead(w(prep(_7862)),_8340,_8328,_8357),
    not_look_ahead(w(prep(over)),_8369,_8357,_8386),
    not_look_ahead(w(prep(on)),_8398,_8386,_8415),
    not_look_ahead(w(prep(in)),_8427,_8415,_8444),
    not_look_ahead(w(noun(day,_7887,_7888,_7889)),_8456,_8444,_8473),
    not_look_ahead(w(noun(hour,_7896,_7897,_7898)),_8485,_8473,_8502),
    not_look_ahead(w(noun(minute,_7905,_7906,_7907)),_8514,_8502,_8531),
    not_look_ahead(w(noun(second,_7914,_7915,_7916)),_8543,_8531,_8560),
    not_look_ahead([om],_8572,_8560,_8589),
    !,
    reject(_8606,_8589,_7941).

nil_compl(_7698,[nil_compl,{},{},{},_7801,!,_7830],_7757,_7759) --> 
    {user:(\+abnormalverb(_7698,_7720))},
    {user:(\+testmember(_7698,[have,be_named]))},
    {user:v_compl(_7698,_7736,nil,_7738)},
    hver0(_7801,_7757,_7816),
    !,
    accept(_7830,_7816,_7759).

verb_modifier3(_7698,_7699,_7700,_7701,_7702,[verb_modifier3,_7795,_7926],_7769,_7771) --> 
    pushstack(free,(npgap(_7699),lexv(iv,_7698,pres,fin),prep(in),w(noun(time,sin,u,n))),nil,_7769,_7901),statreal(_7711,_7795,_7901,_7914),
    determiner00(_7700,_7701,_7711::_7702,_7926,_7914,_7771).

adverbix0(_7698,_7699,_7700,[adverbix0,_7750,!],_7730,_7732) --> 
    adverbix(_7698,_7699,_7700,_7750,_7730,_7732),
    !.

adverbix0(redundantly,nil:thing,_7702::_7702,[adverbix0,[]],_7729,_7729) --> 
    [].

adverbix(_7698,nil:_7706,_7702::_7702,[adverbix,_7762,{}],_7742,_7744) --> 
    w(adv(_7698),_7762,_7742,_7744),
    {user:particle(_7698,_7706,_7715)}.

adverbix(redundantly,nil:thing,_7702::_7702,[adverbix,_7756,!],_7736,_7738) --> 
    w(adv(redundantly),_7756,_7736,_7738),
    !.

adverbix(_7698,_7699,_7702::_7703,[adverbix,_7753],_7733,_7735) --> 
    adverbial1(_7698,_7699,_7702::_7703,_7753,_7733,_7735).

adverbix(_7698,nil:_7706,_7702::_7702,[adverbix,_7758,_7787],_7738,_7740) --> 
    gradverbs0(_7715,_7758,_7738,_7775),
    adverbx(_7698,_7706,_7713,_7787,_7775,_7740).

adverbix(nil,_7699,_7700,[adverbix,_7766,_7795,_7829],_7746,_7748) --> 
    look_ahead(w(noun(_7715,sin,u,n)),_7766,_7746,_7783),
    gmem(_7715,[midnight],_7795,_7783,_7814),
    complement_nil(_7699,_7700,_7829,_7814,_7748).

adverbix(nil,_7699,_7700,[adverbix,lit(den),_7772,_7801],_7741,_7743) --> 
    cc(den,_7741,_7771),
    look_ahead(w(nb(_7717,_7718)),_7772,_7771,_7789),
    complement_nil(_7699,_7700,_7801,_7789,_7743).

adverbial(_7698,_7699,_7702::_7703,[adverbial,_7753],_7733,_7735) --> 
    adverbial3(_7698,_7699,_7702::_7703,_7753,_7733,_7735).

adverbial(_7698,_7699,_7702::_7703,[adverbial,_7753],_7733,_7735) --> 
    adverbial1(_7698,_7699,_7702::_7703,_7753,_7733,_7735).

preadverbial0(_7698,_7699,_7700,[preadverbial0,_7750,!],_7730,_7732) --> 
    adverbial1(_7698,_7699,_7700,_7750,_7730,_7732),
    !.

preadverbial0(redundantly,nil:thing,_7702::_7702,[preadverbial0,[]],_7729,_7729) --> 
    [].

preadverbial1(_7698,_7699,_7700,[preadverbial1,_7789,_7818,_7847,{},_7886,!],_7769,_7771) --> 
    w(nb(_7719,num),_7789,_7769,_7806),
    w(noun(minute,_7725,_7726,_7727),_7818,_7806,_7835),
    look_ahead(w(prep(_7733)),_7847,_7835,_7864),
    {user:testmember(_7733,[before,after])},
    adverbial1(_7698,_7699,_7700,_7886,_7864,_7771),
    !.

preadverbial1(_7698,_7699,_7700,[preadverbial1,_7757,_7786,_7810],_7737,_7739) --> 
    not_look_ahead([e],_7757,_7737,_7774),
    not_look_ahead_np(_7786,_7774,_7801),
    adverbix(_7698,_7699,_7700,_7810,_7801,_7739).

preadverbial1(nil,_7699,_7700,[preadverbial1,_7771,!,_7805,_7829],_7751,_7753) --> 
    w(adj2(early,nil),_7771,_7751,_7788),
    !,
    accept(_7805,_7788,_7820),
    pushstack(first,w(noun(morning,sin,u,n)),nil,_7820,_7839),
    adjunct1(nil,_7699,_7700,_7829,_7839,_7753).

preadverbial1(before,1200:clock,_7702::_7702 and 1200 isa clock,[preadverbial1,_7762],_7742,_7744) --> 
    w(noun(morning,sin,u,n),_7762,_7742,_7744).

preadverbial1(before,1200:clock,_7702::_7702 and 1200 isa clock,[preadverbial1,_7762],_7742,_7744) --> 
    w(noun(prenoon,sin,u,n),_7762,_7742,_7744).

preadverbial1(after,1200:clock,_7702::_7702 and 1200 isa clock,[preadverbial1,_7762],_7742,_7744) --> 
    w(noun(afternoon,sin,u,n),_7762,_7742,_7744).

preadverbial1(after,1800:clock,_7702::_7702 and 1800 isa clock,[preadverbial1,_7762],_7742,_7744) --> 
    w(noun(night,sin,u,n),_7762,_7742,_7744).

preadverbial1(nil,_7699,_7700,[preadverbial1,_7752,!,_7791],_7732,_7734) --> 
    obviousclock1(_7699,_7700,_7752,_7732,_7771),
    !,
    accept(_7791,_7771,_7734).

preadverbial1(nil,_7699,_7700,[preadverbial1,_7752,!,_7791],_7732,_7734) --> 
    obviousdate1(_7699,_7700,_7752,_7732,_7771),
    !,
    accept(_7791,_7771,_7734).

preadverbials([preadverbials,_7730,!,_7759],_7719,_7721) --> 
    redundant(_7730,_7719,_7745),
    !,
    preadverbials(_7759,_7745,_7721).

preadverbials([preadverbials,_7747,!,[],_7837,_7861],_7736,_7738) --> 
    adverbix(_7710,_7711,_7712,_7747,_7736,_7768),
    !,
    pushstack(free,xadverbial1(_7710,_7711,_7712),nil,_7768,_7836),[],
    adverbial_conjunction0(_7837,_7836,_7852),
    preadverbials0(_7861,_7852,_7738).

preadverbials0([preadverbials0,_7727,!],_7716,_7718) --> 
    preadverbials(_7727,_7716,_7718),
    !.

preadverbials0([preadverbials0,[]],_7713,_7713) --> 
    [].

adverbial_conjunction0([adverbial_conjunction0,_7727,!],_7716,_7718) --> 
    adverbial_conjunction(_7727,_7716,_7718),
    !.

adverbial_conjunction0([adverbial_conjunction0,[]],_7713,_7713) --> 
    [].

adverbial_conjunction([adverbial_conjunction,lit(og),_7749,!],_7727,_7729) --> 
    cc(og,_7727,_7748),
    look_ahead(w(prep(_7710)),_7749,_7748,_7729),
    !.

adverbial1(_7698,_7699,_7700,[adverbial1,lit(slik),!,_7793],_7757,_7759) --> 
    cc(slik,_7757,_7787),
    !,
    pushstack(first,(w(prep(in)),w(noun(way,sin,def,n)),[som]),nil,_7787,_7803),
    adjunct1(_7698,_7699,_7700,_7793,_7803,_7759).

adverbial1(_7698,_7699,_7700,[adverbial1,lit(dit),_7803,!,_7842],_7772,_7774) --> 
    cc(dit,_7772,_7802),
    lit_of(_7722,[jeg,du],_7803,_7802,_7822),
    !,
    pushstack(first,(w(prep(to)),w(noun(place,sin,def,n)),[som],[_7722]),nil,_7822,_7852),
    adjunct1(_7698,_7699,_7700,_7842,_7852,_7774).

adverbial1(ago,_7699,_7700,[adverbial1,_7789,_7818,_7847,lit(siden),!,_7892],_7769,_7771) --> 
    prep1(for,_7789,_7769,_7806),
    anumber(_7732,_7818,_7806,_7835),
    w(noun(_7725,_7737,u,n),_7847,_7835,_7864),
    cc(siden,_7864,_7886),
    !,
    lock(exact,_7886,_7939),
    pushstack(exact,(number(_7732),w(noun(_7725,plu,u,n))),nil,_7939,_7945),
    np1(_7699,_7700,_7892,_7945,_7934),
    unlock(_7934,_7771).

adverbial1(in,_7711:day,_7702::exists(_7711:morrow)::_7711 isa morrow and _7702,[adverbial1,_7769,!,_7798],_7749,_7751) --> 
    tomorrow(_7769,_7749,_7784),
    !,
    accept(_7798,_7784,_7751).

adverbial1(_7698,_7699,_7700,[adverbial1,_7747],_7727,_7729) --> 
    adjunct1(_7698,_7699,_7700,_7747,_7727,_7729).

adverbial1(in,_7711:_7712,_7702::exists(_7711:_7712)::_7711 isa _7712 and _7702,[adverbial1,_7798,{},!,_7842],_7778,_7780) --> 
    w(noun(_7712,_7734,_7735,n),_7798,_7778,_7815),
    {user:testmember(_7712,[monday,tuesday,wednesday,thursday,friday,saturday,sunday])},
    !,
    accept(_7842,_7815,_7780).

adverbial3(_7698,_7705:_7706,_7702::_7703,[adverbial3,_7801,_7840,[],_7919,_7985],_7781,_7783) --> 
    xsubjunction(_7698,_7706,_7729,_7801,_7781,_7822),
    adverbial_object00(_7705:_7706,_7732,_7840,_7822,_7859),
    pushstack(free,adverbial1(_7729,_7705:_7706,_7732),nil,_7859,_7918),[],
    pushstack(first,([jeg],aux1),nil,_7918,_7960),substatement1(_7724,_7919,_7960,_7973),
    determiner00(_7705:_7706,_7702,_7724::_7703,_7985,_7973,_7783).

adverbial3(_7698,_7699,_7700,[adverbial3,lit(før),_7765,!,_7794],_7734,_7736) --> 
    cc(før,_7734,_7764),
    look_ahead_time(_7765,_7764,_7780),
    !,
    reject(_7794,_7780,_7736).

adverbial3(_7698,_7699,_7702::_7703,[adverbial3,lit(til),_7800,_7829,!,_7863,_7911],_7769,_7771) --> 
    cc(til,_7769,_7799),
    not_look_ahead([j],_7800,_7799,_7817),
    look_ahead([jeg],_7829,_7817,_7846),
    !,
    pushstack(first,w(prep(to)),nil,_7846,_7876),subordinate(_7698,_7699,_7724,_7863,_7876,_7893),
    determiner00(_7699,_7702,_7724::_7703,_7911,_7893,_7771).

adverbial3(_7698,_7699,_7702::_7703,[adverbial3,_7767,_7796,_7835],_7747,_7749) --> 
    not_look_ahead([til],_7767,_7747,_7784),
    subordinate(_7698,_7699,_7715,_7796,_7784,_7817),
    determiner00(_7699,_7702,_7715::_7703,_7835,_7817,_7749).

adverbial4(_7698,_7699,_7702::_7702 and _7706,[adverbial4,_7776,_7805,_7834,{}],_7756,_7758) --> 
    not_look_ahead([om],_7776,_7756,_7793),
    prep(_7720,_7805,_7793,_7822),
    clausal_object0(_7699,true::_7706,_7834,_7822,_7758),
    {user:adjustprep(_7699,_7720,_7698)}.

adverbial4(_7698,_7699,_7702::_7702 and _7706,[adverbial4,_7781,_7810,lit(at),_7850,{}],_7761,_7763) --> 
    not_look_ahead([om],_7781,_7761,_7798),
    prep(_7723,_7810,_7798,_7827),
    cc(at,_7827,_7849),
    clausal_object1(_7699,true::_7706,_7850,_7849,_7763),
    {user:adjustprep(_7699,_7723,_7698)}.

subordinate(nil,_7702:coevent,_7700,[subordinate,lit(de),lit(samme),lit(som),_7829,_7863],_7776,_7778) --> 
    cc(de,_7776,_7806),
    cc(samme,_7806,_7817),
    cc(som,_7817,_7828),
    adverbial_object00(_7702:coevent,_7728,_7829,_7828,_7848),
    lock(last,_7848,_7911),
    pushstack(last,([de],w(verb(be,pres,fin)),adverbial1(nil,_7702:coevent,_7728)),nil,_7911,_7917),
    substatement1(_7700,_7863,_7917,_7906),
    unlock(_7906,_7778).

subordinate(_7698,_7699,_7700,[subordinate,_7772,{},_7811,!,_7845],_7752,_7754) --> 
    w(prep(_7716),_7772,_7752,_7789),
    {user:testmember(_7716,[instead_of])},
    not_look_ahead_lit([at,å],_7811,_7789,_7828),
    !,
    reject(_7845,_7828,_7754).

subordinate(_7698,_7699,_7700,[subordinate,_7780,_7809,_7838,{},!,_7882],_7760,_7762) --> 
    not_look_ahead([siden],_7780,_7760,_7797),
    w(prep(_7723),_7809,_7797,_7826),
    look_ahead(w(noun(_7729,_7730,_7731,_7732)),_7838,_7826,_7855),
    {user:subclass0(_7729,time)},
    !,
    reject(_7882,_7855,_7762).

subordinate(_7698,_7699,_7700,[subordinate,_7766,_7805,_7834],_7746,_7748) --> 
    subjunction(_7698,_7709,_7708,_7766,_7746,_7787),
    not_look_ahead(w(verb(_7721,_7722,_7723)),_7805,_7787,_7822),
    subord_clause(_7708,_7709,_7699,_7700,_7834,_7822,_7748).

subord_clause(_7698,_7699,_7703:_7699,_7701,[subord_clause,_7776,!,_7815],_7753,_7755) --> 
    adverbial_object00(_7703:_7699,_7717,_7776,_7753,_7795),
    !,
    lock(last,_7795,_7863),
    pushstack(last,xadverbial1(_7698,_7703:_7699,_7717),nil,_7863,_7869),
    substatement1(_7701,_7815,_7869,_7858),
    unlock(_7858,_7755).

adverbial_object00(_7710:_7711,_7701::exists(_7710:_7711)::_7710 isa _7711 and _7701,[adverbial_object00,[]],_7740,_7740) --> 
    [].

subordinateinfnosubj(_7698,_7699,_7700,_7701,_7702,[subordinateinfnosubj,{},_7802,!,_7846],_7766,_7768) --> 
    {user:it_template(_7700)},
    np00(_7699,_7720,_7723::_7724,_7802,_7766,_7823),
    !,
    pushstack(free,(npgap(_7700),adverbial1(_7698,_7720,_7723::_7724)),nil,_7823,_7921),
    statreal(_7702,_7846,_7921,_7768).

subordinateinfnosubj(_7698,_7699,_7700,_7701,_7702,[subordinateinfnosubj,{},_7837,{},!,_7896,!,_7940],_7801,_7803) --> 
    {user:(\+it_template(_7700))},
    lexv(tv,_7748,_7749,fin,_7837,_7801,_7860),
    {user:testmember(_7748,[take])},
    !,
    np00(_7699,_7735,_7738::_7739,_7896,_7860,_7917),
    !,
    pushstack(free,(someone,w(verb(_7748,pres,fin)),npgap(_7700),adverbial1(_7698,_7735,_7738::_7739)),nil,_7917,_8043),
    statreal(_7702,_7940,_8043,_7803).

subordinateinfnosubj(_7698,_7699,_7700,_7701,_7702,[subordinateinfnosubj,{},_7837,{},!,_7896,!,_7940],_7801,_7803) --> 
    {user:(\+it_template(_7700))},
    lexv(tv,_7748,_7749,fin,_7837,_7801,_7860),
    {user:testmember(_7748,[help])},
    !,
    np00(_7699,_7735,_7738::_7739,_7896,_7860,_7917),
    !,
    pushstack(free,(npgap(_7700),w(verb(_7748,pres,fin)),someone,adverbial1(_7698,_7735,_7738::_7739)),nil,_7917,_8043),
    statreal(_7702,_7940,_8043,_7803).

partday(_7698,_7699,_7700,[partday,_7762,{},!],_7742,_7744) --> 
    w(noun(_7698,_7711,_7712,n),_7762,_7742,_7744),
    {user:particle(_7698,_7699,_7700)},
    !.

partday(tomorrow,_7699,_7700,[partday,_7777,_7801,_7830,_7859,!,{}],_7757,_7759) --> 
    to0(_7777,_7757,_7792),
    prep1(in,_7801,_7792,_7818),
    not_look_ahead([formiddag],_7830,_7818,_7847),
    w(noun(morning,_7732,_7733,n),_7859,_7847,_7759),
    !,
    {user:particle(tomorrow,_7699,_7700)}.

partday(tomorrow,_7699,_7700,[partday,_7770,_7794,_7823,!,{}],_7750,_7752) --> 
    to0(_7770,_7750,_7785),
    prep1(in,_7794,_7785,_7811),
    w(noun(morrow,_7725,_7726,n),_7823,_7811,_7752),
    !,
    {user:particle(tomorrow,_7699,_7700)}.

partday(_7698,_7699,_7700,[partday,_7776,_7805,!,{},{}],_7756,_7758) --> 
    inom(_7720,_7776,_7756,_7793),
    w(noun(_7724,_7725,_7726,n),_7805,_7793,_7758),
    !,
    {user:norpart(_7720,_7724,_7698)},
    {user:particle(_7698,_7699,_7700)}.

adverbx(with,mode,post,[adverbx,lit(med),_7762,!],_7731,_7733) --> 
    cc(med,_7731,_7761),
    not_look_ahead_np(_7762,_7761,_7733),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),_7762,!],_7731,_7733) --> 
    cc(etter,_7731,_7761),
    terminatore(_7762,_7761,_7733),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),lit(det),!],_7733,_7735) --> 
    cc(etter,_7733,_7763),
    cc(det,_7763,_7735),
    !.

adverbx(earlier,time,post,[adverbx,lit(før),lit(det),!],_7733,_7735) --> 
    cc(før,_7733,_7763),
    cc(det,_7763,_7735),
    !.

adverbx(_7698,_7699,_7700,[adverbx,lit(slik),lit(at),!,_7783],_7736,_7738) --> 
    cc(slik,_7736,_7766),
    cc(at,_7766,_7777),
    !,
    reject(_7783,_7777,_7738).

adverbx(_7698,_7699,_7700,[adverbx,_7762,_7786,!,{}],_7742,_7744) --> 
    not_look_ahead_prepx(_7762,_7742,_7777),
    w(adv(_7698),_7786,_7777,_7744),
    !,
    {user:particle(_7698,_7699,_7700)}.

not_look_ahead_prepx([not_look_ahead_prepx,lit(med),_7743,!],_7721,_7723) --> 
    cc(med,_7721,_7742),
    look_ahead_np(_7743,_7742,_7723),
    !.

not_look_ahead_prepx([not_look_ahead_prepx,_7730],_7719,_7721) --> 
    not_look_ahead(w(prep(_7702)),_7730,_7719,_7721).

adverbx(_7698,_7699,_7700,[adverbx,_7747],_7727,_7729) --> 
    adverb(_7698,_7699,_7700,_7747,_7727,_7729).

adverbx(_7698,_7699,_7700,[adverbx,_7747],_7727,_7729) --> 
    partday(_7698,_7699,_7700,_7747,_7727,_7729).

adverbx(yesterday,_7699,_7700,[adverbx,_7762,lit(går),!,{}],_7742,_7744) --> 
    prep1(in,_7762,_7742,_7779),
    cc(går,_7779,_7744),
    !,
    {user:particle(yesterday,_7699,_7700)}.

anyadverb0([anyadverb0,_7744,_7768,!,[]],_7733,_7735) --> 
    therenot0(_7744,_7733,_7759),
    adverb(_7710,_7711,_7712,_7768,_7759,_7789),
    !,
    pushstack(free,adverb(_7710,_7711,_7712),nil,_7789,_7735),
    [].

anyadverb0([anyadverb0,_7724],_7713,_7715) --> 
    therenot0(_7724,_7713,_7715).

adverbx0([adverbx0,_7731,!],_7720,_7722) --> 
    w(adv(redundantly),_7731,_7720,_7722),
    !.

adverbx0([adverbx0,_7774,_7803,_7832,{},!,[]],_7763,_7765) --> 
    not_look_ahead(w(noun(_7724,sin,u,n)),_7774,_7763,_7791),
    not_look_ahead(w(prep(_7733)),_7803,_7791,_7820),
    adverb(_7716,_7717,_7718,_7832,_7820,_7853),
    {user:(\+testmember(_7716,[home]))},
    !,
    pushstack(free,adverb(_7716,_7717,_7718),nil,_7853,_7765),
    [].

adverbx0([adverbx0,[]],_7713,_7713) --> 
    [].

adverb0(_7698,_7699,_7700,[adverb0,_7750,!],_7730,_7732) --> 
    adverb(_7698,_7699,_7700,_7750,_7730,_7732),
    !.

adverb0(redundantly,thing,post,[adverb0,[]],_7723,_7723) --> 
    [].

adverb(delayed,time,post,[adverb,_7751,!],_7731,_7733) --> 
    w(adj2(delayed,nil),_7751,_7731,_7733),
    !.

adverb(_7698,_7699,_7700,[adverb,_7769,_7798,_7827,{}],_7749,_7751) --> 
    gradverb0(_7717,_7769,_7749,_7786),
    not_look_ahead([siste],_7798,_7786,_7815),
    w(adj2(_7698,nil),_7827,_7815,_7751),
    {user:particle(_7698,_7699,_7700)}.

adverb(now,_7699,_7700,[adverb,_7757,_7786,{}],_7737,_7739) --> 
    prep1(with,_7757,_7737,_7774),
    detsamme(_7786,_7774,_7739),
    {user:particle(now,_7699,_7700)}.

adverb(first,time,_7700,[adverb,lit(først)],_7725,_7727) --> 
    cc(først,_7725,_7727).

adverb(today,day,pre,[adverb,_7755,_7784],_7735,_7737) --> 
    prep1(in,_7755,_7735,_7772),
    w(noun(day,sin,u,n),_7784,_7772,_7737).

adverb(tomorrow,day,pre,[adverb,_7750,lit(morgen)],_7730,_7732) --> 
    prep1(in,_7750,_7730,_7767),
    cc(morgen,_7767,_7732).

adverb(day_after_tomorrow,day,pre,[adverb,_7750,lit(overimorgen)],_7730,_7732) --> 
    prep1(in,_7750,_7730,_7767),
    cc(overimorgen,_7767,_7732).

adverb(day_before_yesterday,day,pre,[adverb,_7750,lit(forgårs)],_7730,_7732) --> 
    prep1(in,_7750,_7730,_7767),
    cc(forgårs,_7767,_7732).

adverb(tonight,daypart,pre,[adverb,_7755,_7784],_7735,_7737) --> 
    prep1(in,_7755,_7735,_7772),
    w(noun(night,_7708,_7709,_7710),_7784,_7772,_7737).

adverb(today,day,pre,[adverb,_7755,_7784],_7735,_7737) --> 
    prep1(in,_7755,_7735,_7772),
    w(noun(day,_7708,_7709,_7710),_7784,_7772,_7737).

adverb(locally,place,post,[adverb,lit(lokalt)],_7725,_7727) --> 
    cc(lokalt,_7725,_7727).

adverb(_7698,_7699,_7700,[adverb,_7756,_7785,!,_7814],_7736,_7738) --> 
    w(prep(_7713),_7756,_7736,_7773),
    look_ahead_np(_7785,_7773,_7800),
    !,
    reject(_7814,_7800,_7738).

adverb(_7698,_7699,_7700,[adverb,_7754,{}],_7734,_7736) --> 
    particle(_7698,_7754,_7734,_7736),
    {user:particle(_7698,_7699,_7700)}.

adverb(_7698,_7699,_7700,[adverb,_7792,{},_7831,_7860,{},_7899],_7772,_7774) --> 
    particle(_7698,_7792,_7772,_7809),
    {user:testmember(_7698,[on,off])},
    not_look_ahead(w(noun(_7732,_7733,_7734,_7735)),_7831,_7809,_7848),
    not_look_ahead(w(name(_7741,_7742,_7743)),_7860,_7848,_7877),
    {user:particle(_7698,_7699,_7700)},
    da0(_7899,_7877,_7774).

particlev0(_7698,_7699,[particlev0,_7743,!],_7726,_7728) --> 
    particlev2(_7698,_7699,_7743,_7726,_7728),
    !.

particlev0(_7698,_7698,[particlev0,_7739],_7722,_7724) --> 
    particlev1(_7698,_7739,_7722,_7724).

particlev0(_7698,_7698,[particlev0,[]],_7720,_7720) --> 
    [].

particle0(_7698,[particle0,_7736,!],_7722,_7724) --> 
    particle(_7698,_7736,_7722,_7724),
    !.

particle0(_7698,[particle0,[]],_7717,_7717) --> 
    [].

particlev1(believe,[particlev1,lit(på)],_7719,_7721) --> 
    cc(på,_7719,_7721).

particlev1(calculate,[particlev1,lit(med)],_7719,_7721) --> 
    cc(med,_7719,_7721).

particlev1(check,[particlev1,lit(opp)],_7719,_7721) --> 
    cc(opp,_7719,_7721).

particlev1(come,[particlev1,lit(med),_7747],_7722,_7724) --> 
    cc(med,_7722,_7746),
    not_look_ahead_np(_7747,_7746,_7724).

particlev1(come,[particlev1,lit(til),_7747],_7722,_7724) --> 
    cc(til,_7722,_7746),
    not_look_ahead_np(_7747,_7746,_7724).

particlev1(come,[particlev1,lit(opp)],_7719,_7721) --> 
    cc(opp,_7719,_7721).

particlev1(correct,[particlev1,lit(opp)],_7719,_7721) --> 
    cc(opp,_7719,_7721).

particlev1(fetch,[particlev1,lit(ned)],_7719,_7721) --> 
    cc(ned,_7719,_7721).

particlev1(fetch,[particlev1,lit(opp)],_7719,_7721) --> 
    cc(opp,_7719,_7721).

particlev1(find,[particlev1,lit(ut),lit(av)],_7724,_7726) --> 
    cc(ut,_7724,_7748),
    cc(av,_7748,_7726).

particlev1(get,[particlev1,lit(med)],_7719,_7721) --> 
    cc(med,_7719,_7721).

particlev1(get,[particlev1,lit(opp)],_7719,_7721) --> 
    cc(opp,_7719,_7721).

particlev1(have,[particlev1,lit(på)],_7719,_7721) --> 
    cc(på,_7719,_7721).

particlev1(help,[particlev1,lit(til),lit(med)],_7724,_7726) --> 
    cc(til,_7724,_7748),
    cc(med,_7748,_7726).

particlev1(help,[particlev1,lit(til)],_7719,_7721) --> 
    cc(til,_7719,_7721).

particlev1(improve,[particlev1,lit(inn)],_7719,_7721) --> 
    cc(inn,_7719,_7721).

particlev1(indicte,[particlev1,lit(på)],_7719,_7721) --> 
    cc(på,_7719,_7721).

particlev1(lay,[particlev1,lit(inn)],_7719,_7721) --> 
    cc(inn,_7719,_7721).

particlev1(lie1,[particlev1,lit(med)],_7719,_7721) --> 
    cc(med,_7719,_7721).

particlev1(name,[particlev1,lit(til)],_7719,_7721) --> 
    cc(til,_7719,_7721).

particlev1(reach,[particlev1,lit(til)],_7719,_7721) --> 
    cc(til,_7719,_7721).

particlev1(reach,[particlev1,lit(fram),lit(til)],_7724,_7726) --> 
    cc(fram,_7724,_7748),
    cc(til,_7748,_7726).

particlev1(read,[particlev1,lit(gjennom)],_7719,_7721) --> 
    cc(gjennom,_7719,_7721).

particlev1(receive,[particlev1,lit(opp)],_7719,_7721) --> 
    cc(opp,_7719,_7721).

particlev1(get,[particlev1,lit(opp)],_7719,_7721) --> 
    cc(opp,_7719,_7721).

particlev1(send,[particlev1,lit(med)],_7719,_7721) --> 
    cc(med,_7719,_7721).

particlev1(send,[particlev1,lit(over)],_7719,_7721) --> 
    cc(over,_7719,_7721).

particlev1(send,[particlev1,lit(ved)],_7719,_7721) --> 
    cc(ved,_7719,_7721).

particlev1(sing,[particlev1,lit(ut)],_7719,_7721) --> 
    cc(ut,_7719,_7721).

particlev1(take,[particlev1,lit(ut)],_7719,_7721) --> 
    cc(ut,_7719,_7721).

particlev1(throw,[particlev1,lit(av)],_7719,_7721) --> 
    cc(av,_7719,_7721).

particlev1(tell,[particlev1,lit(inn)],_7719,_7721) --> 
    cc(inn,_7719,_7721).

particlev1(tell,[particlev1,lit(om)],_7719,_7721) --> 
    cc(om,_7719,_7721).

particlev1(tell,[particlev1,lit(fra),lit(om),!],_7727,_7729) --> 
    cc(fra,_7727,_7751),
    cc(om,_7751,_7729),
    !.

particlev1(tell,[particlev1,lit(fra)],_7719,_7721) --> 
    cc(fra,_7719,_7721).

particlev1(tell,[particlev1,lit(ifra)],_7719,_7721) --> 
    cc(ifra,_7719,_7721).

particlev1(tell,[particlev1,_7735],_7721,_7723) --> 
    w(prep(regarding),_7735,_7721,_7723).

particlev1(wonder,[particlev1,lit(på)],_7719,_7721) --> 
    cc(på,_7719,_7721).

particlev1(write,[particlev1,lit(inn)],_7719,_7721) --> 
    cc(inn,_7719,_7721).

particlev2(avoid,release,[particlev2,lit(fri)],_7722,_7724) --> 
    cc(fri,_7722,_7724).

particlev2(be,come,[particlev2,lit(med)],_7722,_7724) --> 
    cc(med,_7722,_7724).

particlev2(belong,belong_to,[particlev2,lit(til)],_7722,_7724) --> 
    cc(til,_7722,_7724).

particlev2(hear,belong_to,[particlev2,lit(til)],_7722,_7724) --> 
    cc(til,_7722,_7724).

particlev2(calculate,expect,[particlev2,lit(med)],_7722,_7724) --> 
    cc(med,_7722,_7724).

particlev2(care1,ensure,[particlev2,lit(for)],_7722,_7724) --> 
    cc(for,_7722,_7724).

particlev2(come,appear,[particlev2,lit(fram)],_7722,_7724) --> 
    cc(fram,_7722,_7724).

particlev2(come,disappear,[particlev2,lit(bort),_7759],_7731,_7733) --> 
    cc(bort,_7731,_7758),
    not_look_ahead(w(prep(to)),_7759,_7758,_7733).

particlev2(comment,remove,[particlev2,lit(ut)],_7722,_7724) --> 
    cc(ut,_7722,_7724).

particlev2(do1,finish,[particlev2,lit(ferdig)],_7722,_7724) --> 
    cc(ferdig,_7722,_7724).

particlev2(do1,make,[particlev2,lit(meg)],_7722,_7724) --> 
    cc(meg,_7722,_7724).

particlev2(find,do1,[particlev2,lit(på)],_7722,_7724) --> 
    cc(på,_7722,_7724).

particlev2(find,discover,[particlev2,lit(ut)],_7722,_7724) --> 
    cc(ut,_7722,_7724).

particlev2(fool,wonder,[particlev2,lit(på)],_7722,_7724) --> 
    cc(på,_7722,_7724).

particlev2(go,stop,[particlev2,lit(ned)],_7722,_7724) --> 
    cc(ned,_7722,_7724).

particlev2(get,manage,[particlev2,lit(til)],_7722,_7724) --> 
    cc(til,_7722,_7724).

particlev2(have,bring,[particlev2,lit(med)],_7722,_7724) --> 
    cc(med,_7722,_7724).

particlev2(hold,be,[particlev2,lit(deg)],_7722,_7724) --> 
    cc(deg,_7722,_7724).

particlev2(hold,be,[particlev2,lit(meg)],_7722,_7724) --> 
    cc(meg,_7722,_7724).

particlev2(hold,be,[particlev2,lit(seg)],_7722,_7724) --> 
    cc(seg,_7722,_7724).

particlev2(hold,do1,[particlev2,lit(på),lit(med)],_7727,_7729) --> 
    cc(på,_7727,_7754),
    cc(med,_7754,_7729).

particlev2(hold,be1,[particlev2,lit(til)],_7722,_7724) --> 
    cc(til,_7722,_7724).

particlev2(hold,wait,[particlev2,lit(ut)],_7722,_7724) --> 
    cc(ut,_7722,_7724).

particlev2(improve,ensure,[particlev2,lit(inn)],_7722,_7724) --> 
    cc(inn,_7722,_7724).

particlev2(lay,include,[particlev2,lit(inn)],_7722,_7724) --> 
    cc(inn,_7722,_7724).

particlev2(lay,include,[particlev2,lit(på)],_7722,_7724) --> 
    cc(på,_7722,_7724).

particlev2(lay,enclose,[particlev2,lit(ved)],_7722,_7724) --> 
    cc(ved,_7722,_7724).

particlev2(lay,stop,[particlev2,lit(ned)],_7722,_7724) --> 
    cc(ned,_7722,_7724).

particlev2(lay,change,[particlev2,lit(om)],_7722,_7724) --> 
    cc(om,_7722,_7724).

particlev2(lead,cause,[particlev2,lit(til)],_7722,_7724) --> 
    cc(til,_7722,_7724).

particlev2(lie1,belong_to,[particlev2,lit(under)],_7722,_7724) --> 
    cc(under,_7722,_7724).

particlev2(list,list,[particlev2,lit(opp)],_7722,_7724) --> 
    cc(opp,_7722,_7724).

particlev2(long,want,[particlev2,lit(etter)],_7722,_7724) --> 
    cc(etter,_7722,_7724).

particlev2(look,appear,[particlev2,lit(ut)],_7722,_7724) --> 
    cc(ut,_7722,_7724).

particlev2(meet,meetup,[particlev2,lit(opp)],_7722,_7724) --> 
    cc(opp,_7722,_7724).

particlev2(negotiate,discuss,[particlev2,lit(om)],_7722,_7724) --> 
    cc(om,_7722,_7724).

particlev2(operate,do1,[particlev2,_7746,lit(med)],_7729,_7731) --> 
    optional([på],_7746,_7729,_7778),
    cc(med,_7778,_7731).

particlev2(pay,pay2,[particlev2,lit(seg)],_7722,_7724) --> 
    cc(seg,_7722,_7724).

particlev2(put,arrange,[particlev2,lit(opp)],_7722,_7724) --> 
    cc(opp,_7722,_7724).

particlev2(say,tell,[particlev2,lit(fra)],_7722,_7724) --> 
    cc(fra,_7722,_7724).

particlev2(say,tell,[particlev2,lit(ifra)],_7722,_7724) --> 
    cc(ifra,_7722,_7724).

particlev2(see,appear,[particlev2,lit(ut)],_7722,_7724) --> 
    cc(ut,_7722,_7724).

particlev2(see,appear,[particlev2,lit(ut)],_7722,_7724) --> 
    cc(ut,_7722,_7724).

particlev2(stand,indicate,[particlev2,lit(for)],_7722,_7724) --> 
    cc(for,_7722,_7724).

particlev2(take,bring,[particlev2,lit(med)],_7722,_7724) --> 
    cc(med,_7722,_7724).

particlev2(take,manage,[particlev2,lit(over)],_7722,_7724) --> 
    cc(over,_7722,_7724).

particlev2(take,get,[particlev2,lit(til),_7753],_7725,_7727) --> 
    cc(til,_7725,_7752),
    rfxpron(_7753,_7752,_7727).

particlev2(take,get,[particlev2,lit(mot)],_7722,_7724) --> 
    cc(mot,_7722,_7724).

particlev2(take,get,[particlev2,lit(imot)],_7722,_7724) --> 
    cc(imot,_7722,_7724).

particlev2(take,get,[particlev2,lit(i),lit(mot)],_7727,_7729) --> 
    cc(i,_7727,_7754),
    cc(mot,_7754,_7729).

particlev2(take,treat,[particlev2,lit(opp)],_7722,_7724) --> 
    cc(opp,_7722,_7724).

particlev2(turn,stop,[particlev2,lit(av)],_7722,_7724) --> 
    cc(av,_7722,_7724).

particlev2(turn,start,[particlev2,lit(på)],_7722,_7724) --> 
    cc(på,_7722,_7724).

particlev2(write,print,[particlev2,lit(ut)],_7722,_7724) --> 
    cc(ut,_7722,_7724).

rep_particlev0(_7698,[rep_particlev0,_7736,!],_7722,_7724) --> 
    rep_particlev(_7698,_7736,_7722,_7724),
    !.

rep_particlev0(_7698,[rep_particlev0,[]],_7717,_7717) --> 
    [].

rep_particlev(ask,[rep_particlev,lit(:),!],_7722,_7724) --> 
    cc(:,_7722,_7724),
    !.

rep_particlev(deny,[rep_particlev,lit(for)],_7719,_7721) --> 
    cc(for,_7719,_7721).

rep_particlev(wonder,[rep_particlev,lit(på),_7753,!,_7782],_7728,_7730) --> 
    cc(på,_7728,_7752),
    which0(_7753,_7752,_7768),
    !,
    accept(_7782,_7768,_7730).

rep_particlev(know,[rep_particlev,_7739,!,_7773],_7725,_7727) --> 
    prep1(to,_7739,_7725,_7756),
    !,
    accept(_7773,_7756,_7727).

rep_particlev(find,[rep_particlev,lit(ut)],_7719,_7721) --> 
    cc(ut,_7719,_7721).

rep_particlev(recognize,[rep_particlev,lit(til)],_7719,_7721) --> 
    cc(til,_7719,_7721).

rep_particlev(think,[rep_particlev,lit(på),_7757,!,_7791],_7732,_7734) --> 
    cc(på,_7732,_7756),
    not_look_ahead([om],_7757,_7756,_7774),
    !,
    reject(_7791,_7774,_7734).

rep_particlev(think,[rep_particlev,lit(på),_7757,!,_7791],_7732,_7734) --> 
    cc(på,_7732,_7756),
    not_look_ahead([at],_7757,_7756,_7774),
    !,
    reject(_7791,_7774,_7734).

rep_particlev(think,[rep_particlev,lit(på),!,_7755],_7725,_7727) --> 
    cc(på,_7725,_7749),
    !,
    accept(_7755,_7749,_7727).

particle(redundantly,[particle,_7731],_7717,_7719) --> 
    redundant(_7731,_7717,_7719).

particle(_7698,[particle,_7738,!],_7724,_7726) --> 
    w(adv(_7698),_7738,_7724,_7726),
    !.

particle(back,[particle,lit(tilbake)],_7719,_7721) --> 
    cc(tilbake,_7719,_7721).

particle(badly,[particle,lit(dårlig)],_7719,_7721) --> 
    cc(dårlig,_7719,_7721).

particle(beforethat,[particle,_7731],_7717,_7719) --> 
    beforethat(_7731,_7717,_7719).

particle(daily,[particle,lit(daglig)],_7719,_7721) --> 
    cc(daglig,_7719,_7721).

particle(day_after_tomorrow,[particle,lit(overimorgen)],_7719,_7721) --> 
    cc(overimorgen,_7719,_7721).

particle(directly,[particle,lit(direkte)],_7719,_7721) --> 
    cc(direkte,_7719,_7721).

particle(down,[particle,lit(ned)],_7719,_7721) --> 
    cc(ned,_7719,_7721).

particle(down,[particle,lit(under)],_7719,_7721) --> 
    cc(under,_7719,_7721).

particle(earlier,[particle,_7731],_7717,_7719) --> 
    earlier(_7731,_7717,_7719).

particle(early,[particle,lit(så),lit(tidlig),lit(som),_7790,!,_7824],_7743,_7745) --> 
    cc(så,_7743,_7767),
    cc(tidlig,_7767,_7778),
    cc(som,_7778,_7789),
    w(adj2(possible,nil),_7790,_7789,_7807),
    !,
    accept(_7824,_7807,_7745).

particle(early,[particle,lit(tidligst),_7758,!,_7792],_7733,_7735) --> 
    cc(tidligst,_7733,_7757),
    w(adj2(possible,nil),_7758,_7757,_7775),
    !,
    accept(_7792,_7775,_7735).

particle(early,[particle,lit(tidlig)],_7719,_7721) --> 
    cc(tidlig,_7719,_7721).

particle(early,[particle,lit(am)],_7719,_7721) --> 
    cc(am,_7719,_7721).

particle(eastward,[particle,lit(østover)],_7719,_7721) --> 
    cc(østover,_7719,_7721).

particle(everywhere,[particle,lit(overalt)],_7719,_7721) --> 
    cc(overalt,_7719,_7721).

particle(far,[particle,lit(langt)],_7719,_7721) --> 
    cc(langt,_7719,_7721).

particle(fast,[particle,lit(fort)],_7719,_7721) --> 
    cc(fort,_7719,_7721).

particle(fast,[particle,_7736],_7722,_7724) --> 
    w(adj2(fast,comp),_7736,_7722,_7724).

particle(from,[particle,lit(ifra)],_7719,_7721) --> 
    cc(ifra,_7719,_7721).

particle(gratis,[particle,lit(gratis)],_7719,_7721) --> 
    cc(gratis,_7719,_7721).

particle(home,[particle,lit(hjem),_7755,!,_7789],_7730,_7732) --> 
    cc(hjem,_7730,_7754),
    prep1(to,_7755,_7754,_7772),
    !,
    reject(_7789,_7772,_7732).

particle(home,[particle,_7736,lit(hjem)],_7722,_7724) --> 
    to0(_7736,_7722,_7751),
    cc(hjem,_7751,_7724).

particle(here,[particle,_7736,lit(hit)],_7722,_7724) --> 
    to0(_7736,_7722,_7751),
    cc(hit,_7751,_7724).

particle(here,[particle,_7736,lit(her)],_7722,_7724) --> 
    to0(_7736,_7722,_7751),
    cc(her,_7751,_7724).

particle(hereafter,[particle,_7731],_7717,_7719) --> 
    hereafter(_7731,_7717,_7719).

particle(in,[particle,lit(inn)],_7719,_7721) --> 
    cc(inn,_7719,_7721).

particle(in_morning,[particle,lit(ommorgenen)],_7719,_7721) --> 
    cc(ommorgenen,_7719,_7721).

particle(late,[particle,_7736,lit(sent)],_7722,_7724) --> 
    so0(_7736,_7722,_7751),
    cc(sent,_7751,_7724).

particle(late,[particle,_7736,lit(sent)],_7722,_7724) --> 
    too(_7736,_7722,_7751),
    cc(sent,_7751,_7724).

particle(lay,[particle,lit(ut)],_7719,_7721) --> 
    cc(ut,_7719,_7721).

particle(lay,[particle,lit(inn)],_7719,_7721) --> 
    cc(inn,_7719,_7721).

particle(lay,[particle,lit(ved)],_7719,_7721) --> 
    cc(ved,_7719,_7721).

particle(logically,[particle,lit(logisk)],_7719,_7721) --> 
    cc(logisk,_7719,_7721).

particle(much,[particle,_7736,lit(mye)],_7722,_7724) --> 
    so(_7736,_7722,_7751),
    cc(mye,_7751,_7724).

particle(normally,[particle,lit(normalt)],_7719,_7721) --> 
    cc(normalt,_7719,_7721).

particle(northward,[particle,lit(nordover)],_7719,_7721) --> 
    cc(nordover,_7719,_7721).

particle(now,[particle,_7731],_7717,_7719) --> 
    now1(_7731,_7717,_7719).

particle(now,[particle,_7738,lit(øyeblikket)],_7724,_7726) --> 
    prep1(for,_7738,_7724,_7755),
    cc(øyeblikket,_7755,_7726).

particle(on,[particle,_7733],_7719,_7721) --> 
    prep1(on,_7733,_7719,_7721).

particle(off,[particle,lit(av)],_7719,_7721) --> 
    cc(av,_7719,_7721).

particle(offside,[particle,_7734,_7758],_7720,_7722) --> 
    and0(_7734,_7720,_7749),
    compassly(_7758,_7749,_7722).

particle(often,[particle,_7736,lit(ofte)],_7722,_7724) --> 
    so0(_7736,_7722,_7751),
    cc(ofte,_7751,_7724).

particle(recently,[particle,_7731],_7717,_7719) --> 
    recently(_7731,_7717,_7719).

particle(out,[particle,lit(ut)],_7719,_7721) --> 
    cc(ut,_7719,_7721).

particle(past,[particle,lit(forbi)],_7719,_7721) --> 
    cc(forbi,_7719,_7721).

particle(present,[particle,lit(framme)],_7719,_7721) --> 
    cc(framme,_7719,_7721).

particle(punctually,[particle,lit(presis)],_7719,_7721) --> 
    cc(presis,_7719,_7721).

particle(punctually,[particle,_7736],_7722,_7724) --> 
    w(adj2(punctual,nil),_7736,_7722,_7724).

particle(punctually,[particle,_7738,lit(tide)],_7724,_7726) --> 
    prep1(in,_7738,_7724,_7755),
    cc(tide,_7755,_7726).

particle(regularly,[particle,lit(som),lit(normalt)],_7724,_7726) --> 
    cc(som,_7724,_7748),
    cc(normalt,_7748,_7726).

particle(silent,[particle,lit(stille)],_7719,_7721) --> 
    cc(stille,_7719,_7721).

particle(simultaneously,[particle,lit(samtidig)],_7719,_7721) --> 
    cc(samtidig,_7719,_7721).

particle(slowly,[particle,lit(langsomt)],_7719,_7721) --> 
    cc(langsomt,_7719,_7721).

particle(somewhere,[particle,lit(noensted)],_7719,_7721) --> 
    cc(noensted,_7719,_7721).

particle(southward,[particle,lit(sørover)],_7719,_7721) --> 
    cc(sørover,_7719,_7721).

particle(there,[particle,lit(dit)],_7719,_7721) --> 
    cc(dit,_7719,_7721).

particle(there,[particle,lit(der)],_7719,_7721) --> 
    cc(der,_7719,_7721).

particle(there,[particle,_7736],_7722,_7724) --> 
    w(adj2(present,nil),_7736,_7722,_7724).

particle(thereafter,[particle,_7731],_7717,_7719) --> 
    thereafter(_7731,_7717,_7719).

particle(this_midnight,[particle,lit(inatt)],_7719,_7721) --> 
    cc(inatt,_7719,_7721).

particle(today,[particle,lit(idag)],_7719,_7721) --> 
    cc(idag,_7719,_7721).

particle(together,[particle,lit(sammen)],_7719,_7721) --> 
    cc(sammen,_7719,_7721).

particle(tomorrow,[particle,lit(imorgen)],_7719,_7721) --> 
    cc(imorgen,_7719,_7721).

particle(tonight,[particle,lit(ikveld)],_7719,_7721) --> 
    cc(ikveld,_7719,_7721).

particle(up,[particle,lit(opp)],_7719,_7721) --> 
    cc(opp,_7719,_7721).

particle(well,[particle,lit(bra)],_7719,_7721) --> 
    cc(bra,_7719,_7721).

particle(well,[particle,lit(best)],_7719,_7721) --> 
    cc(best,_7719,_7721).

particle(well,[particle,lit(vel)],_7719,_7721) --> 
    cc(vel,_7719,_7721).

particle(westward,[particle,lit(vestover)],_7719,_7721) --> 
    cc(vestover,_7719,_7721).

particle(with1,[particle,lit(med),_7755],_7730,_7732) --> 
    cc(med,_7730,_7754),
    not_look_ahead(w(name(_7707,_7708,_7709)),_7755,_7754,_7732).

particle(wrongly,[particle,_7736,lit(feil)],_7722,_7724) --> 
    saa0(_7736,_7722,_7751),
    cc(feil,_7751,_7724).

particle(yesterday,[particle,lit(igår)],_7719,_7721) --> 
    cc(igår,_7719,_7721).

adjunct1(_7698,_7699,_7702::_7703,[adjunct1,{},_7846,_7875,_7899,{},!,_7943,!,_8004],_7816,_7818) --> 
    {user:_7698==nil},
    w(nb(_7736,_7737),_7846,_7816,_7863),
    point0(_7875,_7863,_7890),
    w(noun(_7741,_7742,u,n),_7899,_7890,_7916),
    {user:testmember(_7741,[year,month,week,day,hour,minute,second,mile,kilometer,meter])},
    !,
    lock(exact,_7916,_7963),pushstack(exact,(w(nb(_7736,num)),w(noun(_7741,sin,u,n))),nil,_7963,_7969),np0_accept(_7699,_7702::_7703,_7943,_7969,_7958),unlock(_7958,_7959),
    !,
    accept(_8004,_7959,_7818).

adjunct1(after,_7699,_7700,[adjunct1,_7769,lit(å),!,_7814],_7749,_7751) --> 
    w(prep(after),_7769,_7749,_7786),
    cc(å,_7786,_7808),
    !,
    lock(last,_7808,_7859),
    pushstack(last,([noen],aux1),nil,_7859,_7865),
    clausal_object1(_7699,_7700,_7814,_7865,_7854),
    unlock(_7854,_7751).

adjunct1(when,_7699,_7700,[adjunct1,lit(om),lit(når),!,_7786],_7739,_7741) --> 
    cc(om,_7739,_7769),
    cc(når,_7769,_7780),
    !,
    clausal_object1(_7699,_7700,_7786,_7780,_7741).

adjunct1(where,_7699,_7700,[adjunct1,lit(om),lit(hvor),!,_7786],_7739,_7741) --> 
    cc(om,_7739,_7769),
    cc(hvor,_7769,_7780),
    !,
    clausal_object1(_7699,_7700,_7786,_7780,_7741).

adjunct1(regarding,_7699,_7700,[adjunct1,lit(om),lit(at),!,_7786],_7739,_7741) --> 
    cc(om,_7739,_7769),
    cc(at,_7769,_7780),
    !,
    clausal_object1(_7699,_7700,_7786,_7780,_7741).

adjunct1(with,_7699,_7700,[adjunct1,lit(med),lit(det),lit(å),!,_7808],_7750,_7752) --> 
    cc(med,_7750,_7780),
    cc(det,_7780,_7791),
    cc(å,_7791,_7802),
    !,
    pushstack(first,(someone,aux1),nil,_7802,_7874),
    clausal_object1(_7699,_7700,_7808,_7874,_7752).

adjunct1(_7698,_7699,_7700,[adjunct1,lit(hva),!,_7767],_7731,_7733) --> 
    cc(hva,_7731,_7761),
    !,
    reject(_7767,_7761,_7733).

adjunct1(_7698,_7699,_7700,[adjunct1,_7761,_7790,!,_7824],_7741,_7743) --> 
    prep1(in,_7761,_7741,_7778),
    w(noun(morning,_7716,_7717,_7718),_7790,_7778,_7807),
    !,
    reject(_7824,_7807,_7743).

adjunct1(_7698,_7699,_7702::_7703,[adjunct1,{},!,_7778],_7743,_7745) --> 
    {user:_7698==nil},
    !,
    complement_nil(_7699,_7702::_7703,_7778,_7743,_7745).

adjunct1(ago,_7699,_7702::_7703,[adjunct1,_7798,_7827,_7856,lit(siden),!,_7901,!],_7778,_7780) --> 
    prep1(for,_7798,_7778,_7815),
    anumber(_7725,_7827,_7815,_7844),
    w(noun(_7729,_7730,u,n),_7856,_7844,_7873),
    cc(siden,_7873,_7895),
    !,
    lock(exact,_7895,_7951),pushstack(exact,(number(_7725),w(noun(_7729,plu,u,n))),nil,_7951,_7957),np0_accept(_7699,_7702::_7703,_7901,_7957,_7946),unlock(_7946,_7780),
    !.

adjunct1(after,_7699,_7702::_7703,[adjunct1,lit(om),_7811,_7840,_7869,!,_7903],_7780,_7782) --> 
    cc(om,_7780,_7810),
    anumber(_7735,_7811,_7810,_7828),
    w(noun(_7728,_7740,u,gen),_7840,_7828,_7857),
    w(noun(time,sin,u,n),_7869,_7857,_7886),
    !,
    pushstack(first,(number(_7735),w(noun(_7728,sin,u,n))),nil,_7886,_7943),
    np1(_7699,_7702::_7703,_7903,_7943,_7782).

adjunct1(in,_7699,_7700,[adjunct1,_7806,_7835,{},_7874,!,_7908],_7786,_7788) --> 
    prep(in,_7806,_7786,_7823),
    w(nb(_7725,num),_7835,_7823,_7852),
    {user:(1000=<_7725,_7725=<9999)},
    not_look_ahead(w(noun(time,_7751,_7752,_7753)),_7874,_7852,_7891),
    !,
    lock(exact,_7891,_7925),
    pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_7725,num))),nil,_7925,_7931),
    np1(_7699,_7700,_7908,_7931,_7920),
    unlock(_7920,_7788).

adjunct1(around,_7699,_7700,[adjunct1,_7792,{},_7831,_7855,_7889,_7913,!,_7947],_7772,_7774) --> 
    prep1(_7726,_7792,_7772,_7809),
    {user:testmember(_7726,[in,at,around])},
    ca0(_7831,_7809,_7846),
    clock_kernel(_7699,_7723,_7855,_7846,_7874),
    point0(_7889,_7874,_7904),
    not_look_ahead(w(noun(_7746,_7747,_7748,_7749)),_7913,_7904,_7930),
    !,
    raise_object00(_7723,_7700,_7947,_7930,_7774).

adjunct1(_7698,_7699,_7700,[adjunct1,lit(med),lit(en),lit(gang),!,_7799],_7741,_7743) --> 
    cc(med,_7741,_7771),
    cc(en,_7771,_7782),
    cc(gang,_7782,_7793),
    !,
    reject(_7799,_7793,_7743).

adjunct1(between,(_7714,_7715):clock,_7702::_7702 and _7708 and _7709,[adjunct1,_7793,_7822,_7846,_7880,_7904,_7928,!,_7967],_7773,_7775) --> 
    prep1(between,_7793,_7773,_7810),
    clock0(_7822,_7810,_7837),
    clock_kernel(_7714:clock,_7708,_7846,_7837,_7865),
    betwand0(_7880,_7865,_7895),
    clock0(_7904,_7895,_7919),
    clock_kernel(_7715:clock,_7709,_7928,_7919,_7947),
    !,
    accept(_7967,_7947,_7775).

adjunct1(between,_7699,_7700,[adjunct1,_7757,_7786,!,_7825],_7737,_7739) --> 
    prep1(between,_7757,_7737,_7774),
    noun_phrases2(_7699,_7700,_7786,_7774,_7805),
    !,
    accept(_7825,_7805,_7739).

adjunct1(_7698,_7699,_7700,[adjunct1,lit(om),_7777,!,_7806,{}],_7746,_7748) --> 
    cc(om,_7746,_7776),
    not_look_ahead_subject(_7777,_7776,_7792),
    !,
    np(_7699,_7700,_7806,_7792,_7748),
    {user:adjustprep(_7699,om,_7698)}.

adjunct1(_7698,_7699,_7700,[adjunct1,_7747],_7727,_7729) --> 
    pp(_7698,_7699,_7700,_7747,_7727,_7729).

adjunct1(_7698,_7699,_7700,[adjunct1,{},_7764],_7734,_7736) --> 
    {user:_7698==dir},
    noun_phrase1(_7699,_7700,_7764,_7734,_7736).

pp(on,_7699,_7700,[pp,_7756,lit(at),_7796],_7736,_7738) --> 
    prep(on,_7756,_7736,_7773),
    cc(at,_7773,_7795),
    clausal_object1(_7699,_7700,_7796,_7795,_7738).

pp(as,_7699,_7700,[pp,lit(som),_7782,!,_7816],_7751,_7753) --> 
    cc(som,_7751,_7781),
    look_ahead_lit([meg,deg,ham,henne,oss,dem],_7782,_7781,_7799),
    !,
    np(_7699,_7700,_7816,_7799,_7753).

pp(_7698,_7699,_7700,[pp,_7765,_7794,_7823,_7852],_7745,_7747) --> 
    look_ahead([om],_7765,_7745,_7782),
    prep(_7698,_7794,_7782,_7811),
    not_look_ahead([jeg],_7823,_7811,_7840),
    np(_7699,_7700,_7852,_7840,_7747).

pp(_7698,_7699,_7700,[pp,lit(før),lit(det),!,_7783],_7736,_7738) --> 
    cc(før,_7736,_7766),
    cc(det,_7766,_7777),
    !,
    reject(_7783,_7777,_7738).

pp(_7698,_7699,_7700,[pp,_7770,_7799,_7828,_7852,{}],_7750,_7752) --> 
    not_look_ahead_lit([om],_7770,_7750,_7787),
    prep(_7717,_7799,_7787,_7816),
    redundant0(_7828,_7816,_7843),
    object(_7699,_7700,_7852,_7843,_7752),
    {user:adjustprep(_7699,_7717,_7698)}.

pp(_7698,_7699,_7702::_7702 and _7706,[pp,_7833,{},_7872,_7901,_7930,_7964,_7993,_8022,!,_8056],_7813,_7815) --> 
    prep(_7698,_7833,_7813,_7850),
    {user:testmember(_7698,[before,after,around,to,over,within])},
    not_look_ahead([et],_7872,_7850,_7889),
    not_look_ahead([en],_7901,_7889,_7918),
    clock_kernel(_7699,_7706,_7930,_7918,_7949),
    not_look_ahead(w(noun(station,_7770,_7771,_7772)),_7964,_7949,_7981),
    not_look_ahead(w(noun(hour,_7779,_7780,_7781)),_7993,_7981,_8010),
    not_look_ahead(w(noun(minute,_7788,_7789,_7790)),_8022,_8010,_8039),
    !,
    accept(_8056,_8039,_7815).

complement_nil(_7698,_7699,[complement_nil,_7805,_7834,_7863,!,_7907,_7941],_7788,_7790) --> 
    w(nb(_7733,num),_7805,_7788,_7822),
    w(noun(minute,_7739,_7740,_7741),_7834,_7822,_7851),
    subjunction(_7743,time,_7745,_7863,_7851,_7884),
    !,
    clausal_object0(_7728,_7729,_7907,_7884,_7926),
    lock(exact,_7926,_7989),
    pushstack(exact,(w(nb(_7733,num)),w(noun(minute,plu,u,n)),w(prep(_7743)),xnp(_7728,_7729)),nil,_7989,_7995),
    np1(_7698,_7699,_7941,_7995,_7984),
    unlock(_7984,_7790).

complement_nil(_7698,_7699,[complement_nil,_7788,_7817,_7846,!,_7880],_7771,_7773) --> 
    w(nb(_7728,num),_7788,_7771,_7805),
    w(noun(minute,_7734,_7735,_7736),_7817,_7805,_7834),
    look_ahead(w(prep(_7742)),_7846,_7834,_7863),
    !,
    lock(exact,_7863,_7897),
    pushstack(exact,(w(nb(_7728,num)),w(noun(minute,_7722,_7723,_7724))),nil,_7897,_7903),
    noun_phrase1(_7698,_7699,_7880,_7903,_7892),
    unlock(_7892,_7773).

complement_nil(_7698,_7699,[complement_nil,_7740],_7723,_7725) --> 
    obviousclock(_7698,_7699,_7740,_7723,_7725).

complement_nil(_7698,_7699,[complement_nil,_7750,!,_7784],_7733,_7735) --> 
    w(prep(nil),_7750,_7733,_7767),
    !,
    noun_phrase1(_7698,_7699,_7784,_7767,_7735).

complement_nil(_7698,_7701::_7702,[complement_nil,_7794,{},!,_7838,_7862],_7777,_7779) --> 
    w(noun(_7724,_7732,_7733,n),_7794,_7777,_7811),
    {user:testmember(_7724,[nightbus,summerroute,winterroute])},
    !,
    accept(_7838,_7811,_7853),
    lock(exact,_7853,_7879),
    pushstack(exact,(w(prep(with)),w(noun(_7724,sin,u,n))),nil,_7879,_7885),
    adjunct1(_7747,_7698,_7701::_7702,_7862,_7885,_7874),
    unlock(_7874,_7779).

complement_nil(_7698,_7699,[complement_nil,_7780,_7809,_7838,_7867,_7896,!,_7930],_7763,_7765) --> 
    not_look_ahead(w(noun(street,sin,u,n)),_7780,_7763,_7797),
    not_look_ahead([den],_7809,_7797,_7826),
    not_look_ahead([det],_7838,_7826,_7855),
    not_look_ahead(w(prep(with)),_7867,_7855,_7884),
    pronoun1(_7742,_7896,_7884,_7913),
    !,
    reject(_7930,_7913,_7765).

complement_nil(_7698,_7701::_7701 and _7705,[complement_nil,_7746],_7729,_7731) --> 
    plausibleclock1(_7698,_7705,_7746,_7729,_7731).

complement_nil(_7698,_7701::_7702,[complement_nil,_7749,!],_7732,_7734) --> 
    obviousdate(_7698,_7701::_7702,_7749,_7732,_7734),
    !.

complement_nil(_7698,_7701::_7701 and _7705,[complement_nil,_7746],_7729,_7731) --> 
    plausibledate1(_7698,_7705,_7746,_7729,_7731).

complement_nil(_7698,_7701::_7702,[complement_nil,_7769,_7798,!,_7837],_7752,_7754) --> 
    look_ahead(w(adj2(_7723,nil)),_7769,_7752,_7786),
    gmem(_7723,[short,long],_7798,_7786,_7817),
    !,
    noun_phrase1(_7698,_7701::_7702,_7837,_7817,_7754).

complement_nil(_7698,_7699,[complement_nil,_7779,_7808,!,_7842],_7762,_7764) --> 
    w(nb(_7725,num),_7779,_7762,_7796),
    w(noun(time_count,_7719,_7720,_7721),_7808,_7796,_7825),
    !,
    lock(exact,_7825,_7859),
    pushstack(exact,(w(nb(_7725,num)),w(noun(time_count,_7719,_7720,_7721))),nil,_7859,_7865),
    np0(_7698,_7699,_7842,_7865,_7854),
    unlock(_7854,_7764).

complement_nil(_7698,_7699,[complement_nil,_7802,_7831,_7860,_7889,_7918,_7947,!,_7981],_7785,_7787) --> 
    not_look_ahead(w(name(_7726,_7727,_7728)),_7802,_7785,_7819),
    w(nb(_7732,num),_7831,_7819,_7848),
    not_look_ahead([ganger],_7860,_7848,_7877),
    not_look_ahead(w(noun(hour,_7744,_7745,_7746)),_7889,_7877,_7906),
    not_look_ahead(w(noun(minute,_7753,_7754,_7755)),_7918,_7906,_7935),
    not_look_ahead(w(noun(second,_7762,_7763,_7764)),_7947,_7935,_7964),
    !,
    reject(_7981,_7964,_7787).

complement_nil(_7698,_7699,[complement_nil,_7824,_7853,_7882,_7911,_7940,_7969,_7998,_8027,!],_7807,_7809) --> 
    not_look_ahead(w(nb(_7729,_7730)),_7824,_7807,_7841),
    not_look_ahead(w(_7734,name(_7734,_7738,month)),_7853,_7841,_7870),
    not_look_ahead_lit([sin,sitt,sine],_7882,_7870,_7899),
    not_look_ahead(w(noun(hour,plu,u,n)),_7911,_7899,_7928),
    not_look_ahead(w(noun(minute,plu,u,n)),_7940,_7928,_7957),
    not_look_ahead(w(noun(second,plu,u,n)),_7969,_7957,_7986),
    not_look_ahead(w(noun(room,_7781,u,n)),_7998,_7986,_8015),
    object(_7698,_7699,_8027,_8015,_7809),
    !.

complement1_accept(_7698,_7699,_7700,[complement1_accept,lit(idag),!,_7789,!],_7753,_7755) --> 
    cc(idag,_7753,_7783),
    !,
    pushstack(first,(prep(in),w(noun(day,sin,u,n))),nil,_7783,_7832),complement1_accept(_7698,_7699,_7700,_7789,_7832,_7755),
    !.

complement1_accept(_7698,_7699,_7702::_7703,[complement1_accept,_7791,{},_7830,_7859,_7888,!,_7927],_7771,_7773) --> 
    prep(_7698,_7791,_7771,_7808),
    {user:(\+testmember(_7698,[of,between]))},
    not_look_ahead([jeg],_7830,_7808,_7847),
    not_look_ahead([man],_7859,_7847,_7876),
    noun_phrase_accept(_7699,_7702::_7703,_7888,_7876,_7907),
    !,
    accept(_7927,_7907,_7773).

plausibledate1(_7701:date,_7701 isa date,[plausibledate1,_7821,{},_7860,_7884,{},_7923,_7947,{},!,_7991,{}],_7804,_7806) --> 
    num_na(_7742,_7821,_7804,_7838),
    {user:(_7742>=1000,_7742=<9999)},
    dashpoint0(_7860,_7838,_7875),
    num_na(_7743,_7884,_7875,_7901),
    {user:(_7743>=1,_7743=<12)},
    dashpoint0(_7923,_7901,_7938),
    num_na(_7744,_7947,_7938,_7964),
    {user:(_7744>=1,_7744=<31)},
    !,
    accept(_7991,_7964,_7806),
    {user:_7701=date(_7742,_7743,_7744)}.

plausibledate1(_7701:date,_7701 isa date,[plausibledate1,_7801,{},_7840,_7864,{},{},!,_7918,{}],_7784,_7786) --> 
    num_na(_7741,_7801,_7784,_7818),
    {user:_7741=<31},
    slashpoint0(_7840,_7818,_7855),
    num_na(_7740,_7864,_7855,_7881),
    {user:_7740=<12},
    {user:this_year(_7759)},
    !,
    accept(_7918,_7881,_7786),
    {user:(adjust_year(_7740,_7759,_7739),_7701=date(_7739,_7740,_7741))}.

obviousdate(_7698,_7701::_7704 and _7701,[obviousdate,_7746],_7729,_7731) --> 
    obviousdate1(_7698,_7704,_7746,_7729,_7731).

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7780,_7804,_7833,_7857,_7886,!,_7925,{}],_7763,_7765) --> 
    point0(_7780,_7763,_7795),
    dayno(_7735,_7804,_7795,_7821),
    slashpoint0(_7833,_7821,_7848),
    monthname(_7734,_7857,_7848,_7874),
    xyear0(_7734,_7733,_7886,_7874,_7905),
    !,
    accept(_7925,_7905,_7765),
    {user:_7701=date(_7733,_7734,_7735)}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7824,_7848,{},_7887,_7911,{},_7950,_7974,{},!,_8018,{}],_7807,_7809) --> 
    point0(_7824,_7807,_7839),
    num_na(_7745,_7848,_7839,_7865),
    {user:(_7745>=1000,_7745=<9999)},
    dashpoint0(_7887,_7865,_7902),
    num_na(_7746,_7911,_7902,_7928),
    {user:(_7746>=1,_7746=<12)},
    dashpoint0(_7950,_7928,_7965),
    num_na(_7747,_7974,_7965,_7991),
    {user:(_7747>=1,_7747=<31)},
    !,
    accept(_8018,_7991,_7809),
    {user:_7701=date(_7745,_7746,_7747)}.

obviousdate1(_7698,_7704 isa day and _7702,[obviousdate1,_7764,{},_7803,!,_7842],_7747,_7749) --> 
    dendagen(_7704,_7764,_7747,_7781),
    {user:dayname(_7704)},
    date(_7698,_7702,_7803,_7781,_7822),
    !,
    accept(_7842,_7822,_7749).

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7802,_7826,{},_7865,_7889,{},_7928,!,_7967,{}],_7785,_7787) --> 
    point0(_7802,_7785,_7817),
    num_na(_7741,_7826,_7817,_7843),
    {user:(_7741>=25,_7741=<31)},
    slash(_7865,_7843,_7880),
    num_na(_7740,_7889,_7880,_7906),
    {user:_7740=<12},
    xyear0(_7740,_7739,_7928,_7906,_7947),
    !,
    accept(_7967,_7947,_7787),
    {user:_7701=date(_7739,_7740,_7741)}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7843,_7867,{},_7906,_7930,{},_7969,_8013,!,{}],_7826,_7828) --> 
    den0(_7843,_7826,_7858),
    num_na(_7752,_7867,_7858,_7884),
    {user:(_7752>=1,_7752=<7)},
    point0(_7906,_7884,_7921),
    w(name(_7767,n,date),_7930,_7921,_7947),
    {user:testmember(_7767,[easterday])},
    optional(w(noun(year,_7783,_7784,n)),_7969,_7947,_8001),
    w(nb(_7789,num),_8013,_8001,_7828),
    !,
    {user:(easterdate(_7789,_7748),_7789>=1000,_7789=<9999,_7749 is _7752-1,add_days(_7748,_7749,_7701))}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,{},_7813,{},_7852,!,{}],_7786,_7788) --> 
    {user:_7701=date(_7736,_7728,_7729)},
    w(name(_7724,n,date),_7813,_7786,_7830),
    {user:testmember(_7724,[christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day,may17])},
    year_expression(_7736,_7852,_7830,_7788),
    !,
    {user:named_date(_7724,date(_7727,_7728,_7729))}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7847,_7871,{},_7910,_7934,{},_7973,_8002,!,{}],_7830,_7832) --> 
    den0(_7847,_7830,_7862),
    num_na(_7746,_7871,_7862,_7888),
    {user:(_7746>=1,_7746=<7)},
    point0(_7910,_7888,_7925),
    w(name(_7761,n,date),_7934,_7925,_7951),
    {user:testmember(_7761,[whitsun_day,easterday,christmas_day,new_years_day])},
    not_look_ahead(w(noun(year,_7783,_7784,_7785)),_7973,_7951,_7990),
    not_look_ahead(w(nb(_7791,num)),_8002,_7990,_7832),
    !,
    {user:(named_date(_7761,date(_7797,_7798,_7799)),_7743 is _7746-1,add_days(date(_7797,_7798,_7799),_7743,_7701))}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7815,{},_7854,_7883,!,{}],_7798,_7800) --> 
    w(name(_7724,n,date),_7815,_7798,_7832),
    {user:testmember(_7724,[whitsun_eve,whitsun_day,palm_sunday,maundy_thursday,good_friday,eastereve,easterday,christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day])},
    not_look_ahead(w(prep(in)),_7854,_7832,_7871),
    not_look_ahead(w(noun(year,_7775,_7776,_7777)),_7883,_7871,_7800),
    !,
    {user:named_date(_7724,_7701)}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7760,{},!],_7743,_7745) --> 
    w(name(_7715,n,date),_7760,_7743,_7745),
    {user:named_date(_7715,_7701)},
    !.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7772,{},_7811,{},!,_7855],_7755,_7757) --> 
    dendagen(_7722,_7772,_7755,_7789),
    {user:_7722\==nil},
    num_na(_7722,_7811,_7789,_7828),
    {user:numberdate(_7722,_7701)},
    !,
    accept(_7855,_7828,_7757).

obviousdate1(_7698,_7699,[obviousdate1,_7748,_7777,!],_7731,_7733) --> 
    dendagen(_7707,_7748,_7731,_7765),
    date(_7698,_7699,_7777,_7765,_7733),
    !.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7794,_7818,{},_7857,_7881,_7910,_7934,!,{}],_7777,_7779) --> 
    den(_7794,_7777,_7809),
    num_na(_7738,_7818,_7809,_7835),
    {user:(_7738>=1,_7738=<31)},
    slashpoint0(_7857,_7835,_7872),
    monthname(_7737,_7881,_7872,_7898),
    slashpoint0(_7910,_7898,_7925),
    xyear0(_7737,_7736,_7934,_7925,_7779),
    !,
    {user:_7701=date(_7736,_7737,_7738)}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7807,_7831,{},_7870,_7894,{},_7933,_7957,!,{}],_7790,_7792) --> 
    den0(_7807,_7790,_7822),
    num_na(_7741,_7831,_7822,_7848),
    {user:(_7741>=1,_7741=<31)},
    slashpoint0(_7870,_7848,_7885),
    month(_7740,_7894,_7885,_7911),
    {user:(_7740>=1,_7740=<12)},
    slashpoint0(_7933,_7911,_7948),
    year(_7739,_7957,_7948,_7792),
    !,
    {user:_7701=date(_7739,_7740,_7741)}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7780,_7809,_7838,_7867,!,{}],_7763,_7765) --> 
    not_look_ahead(w(nb(_7735,num)),_7780,_7763,_7797),
    month(_7728,_7809,_7797,_7826),
    num_na(_7729,_7838,_7826,_7855),
    year0(_7727,_7867,_7855,_7765),
    !,
    {user:_7701=date(_7727,_7728,_7729)}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7783,_7807,_7836,_7860,!,{}],_7766,_7768) --> 
    den(_7783,_7766,_7798),
    num_na(_7735,_7807,_7798,_7824),
    slashpoint(_7836,_7824,_7851),
    month(_7734,_7860,_7851,_7768),
    !,
    {user:(this_year(_7741),adjust_year(_7734,_7741,_7733),_7701=date(_7733,_7734,_7735))}.

obviousdate1(_7698,_7699,[obviousdate1,_7760,_7789,_7818,!,_7852],_7743,_7745) --> 
    dendagen(_7713,_7760,_7743,_7777),
    num_na(_7715,_7789,_7777,_7806),
    w(noun(_7719,plu,_7721,_7722),_7818,_7806,_7835),
    !,
    reject(_7852,_7835,_7745).

obviousdate1(_7698,_7699,[obviousdate1,lit(den),_7764,!,_7798],_7736,_7738) --> 
    cc(den,_7736,_7763),
    w(nb(_7714,ord),_7764,_7763,_7781),
    !,
    reject(_7798,_7781,_7738).

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,{},_7798,_7827,_7851,_7880,{}],_7771,_7773) --> 
    {user:value(busflag,true)},
    num_na(_7732,_7798,_7771,_7815),
    slashpoint0(_7827,_7815,_7842),
    num_na(_7731,_7851,_7842,_7868),
    slashpoint0(_7880,_7868,_7773),
    {user:(dedicated_date(date(_7730,_7731,_7732)),_7701=date(_7730,_7731,_7732))}.

obviousdate1(_7701:date,_7699,[obviousdate1,_7772,_7801,{},_7840,!,_7874],_7755,_7757) --> 
    dendagen(_7719,_7772,_7755,_7789),
    num_na(_7721,_7801,_7789,_7818),
    {user:(_7721>=1,_7721=<31)},
    colemin(_7734,_7840,_7818,_7857),
    !,
    reject(_7874,_7857,_7757).

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7811,{},_7850,{},_7889,_7913,!,{},{}],_7794,_7796) --> 
    dendagen(_7740,_7811,_7794,_7828),
    {user:_7740\==nil},
    num_na(_7738,_7850,_7828,_7867),
    {user:(_7738>=1,_7738=<31)},
    point(_7889,_7867,_7904),
    not_look_ahead(w(nb(_7764,_7765)),_7913,_7904,_7796),
    !,
    {user:todaysdate(date(_7736,_7737,_7773))},
    {user:_7701=date(_7736,_7737,_7738)}.

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,lit(den),_7775,{},!,_7819],_7747,_7749) --> 
    cc(den,_7747,_7774),
    num_na(_7721,_7775,_7774,_7792),
    {user:numberdate(_7721,_7701)},
    !,
    accept(_7819,_7792,_7749).

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7779,{},_7818,{},!,_7862],_7762,_7764) --> 
    num_na(_7722,_7779,_7762,_7796),
    {user:_7722>=10101},
    not_look_ahead(w(noun(_7733,plu,_7735,_7736)),_7818,_7796,_7835),
    {user:numberdate(_7722,_7701)},
    !,
    accept(_7862,_7835,_7764).

obviousdate1(_7701:date,_7701 isa date,[obviousdate1,_7779,{},_7818,{},!,_7862],_7762,_7764) --> 
    num_na(_7722,_7779,_7762,_7796),
    {user:_7722>=2501},
    not_look_ahead(w(noun(_7733,plu,_7735,_7736)),_7818,_7796,_7835),
    {user:numberdate(_7722,_7701)},
    !,
    accept(_7862,_7835,_7764).

year_expression(_7698,[year_expression,_7768,_7812,_7856,{},!],_7754,_7756) --> 
    optional(w(prep(in)),_7768,_7754,_7800),
    optional(w(noun(year,sin,u,n)),_7812,_7800,_7844),
    w(nb(_7698,num),_7856,_7844,_7756),
    {user:_7698=<9999},
    !.

year_expression(_7698,[year_expression,_7750,!,{}],_7736,_7738) --> 
    lastyear(_7750,_7736,_7738),
    !,
    {user:(this_year(_7714),_7698 is _7714-1)}.

year_expression(_7698,[year_expression,_7750,!,{}],_7736,_7738) --> 
    nextyear(_7750,_7736,_7738),
    !,
    {user:(this_year(_7714),_7698 is _7714+1)}.

lastyear([lastyear,_7743,lit(siste),_7798],_7732,_7734) --> 
    optional([i],_7743,_7732,_7775),
    cc(siste,_7775,_7797),
    w(noun(year,sin,_7708,n),_7798,_7797,_7734).

lastyear([lastyear,_7738,_7782],_7727,_7729) --> 
    optional([i],_7738,_7727,_7770),
    w(noun(lastyear,sin,_7705,n),_7782,_7770,_7729).

lastyear([lastyear,lit(ifjor),!],_7718,_7720) --> 
    cc(ifjor,_7718,_7720),
    !.

nextyear([nextyear,_7743,lit(neste),_7798],_7732,_7734) --> 
    optional([i],_7743,_7732,_7775),
    cc(neste,_7775,_7797),
    w(noun(year,sin,u,n),_7798,_7797,_7734).

plausibleclock(_7698,_7701::_7701 and _7705,[plausibleclock,_7759,!,_7793],_7742,_7744) --> 
    look_ahead(w(nb(_7720,_7721)),_7759,_7742,_7776),
    !,
    clock_sequel(_7698,_7705,_7793,_7776,_7744).

plausibleclock1(_7701:clock,_7701 isa clock,[plausibleclock1,_7813,{},_7852,_7876,_7905,_7949,_7978,{},!],_7796,_7798) --> 
    w(nb(_7733,num),_7813,_7796,_7830),
    {user:(_7733>=1,_7733=<24)},
    point0(_7852,_7830,_7867),
    w(nb(_7749,num),_7876,_7867,_7893),
    optional(['.'],_7905,_7893,_7937),
    not_look_ahead(w(nb(_7760,_7761)),_7949,_7937,_7966),
    not_look_ahead(w(name(_7767,_7768,month)),_7978,_7966,_7798),
    {user:plausibleclocktest(_7733,_7749,_7701)},
    !.

obviousclock(_7698,_7699,[obviousclock,_7770,_7799,_7823,{},!,_7867],_7753,_7755) --> 
    w(nb(_7718,num),_7770,_7753,_7787),
    pointNO(_7799,_7787,_7814),
    w(nb(_7723,num),_7823,_7814,_7840),
    {user:dedicated_date(date(_7730,_7723,_7718))},
    !,
    reject(_7867,_7840,_7755).

obviousclock(_7698,_7701::_7701 and _7705,[obviousclock,_7746],_7729,_7731) --> 
    obviousclock1(_7698,_7705,_7746,_7729,_7731).

obviousclock1(_7698,_7699,[obviousclock1,_7746,!,_7775],_7729,_7731) --> 
    clock(_7746,_7729,_7761),
    !,
    clock_sequel(_7698,_7699,_7775,_7761,_7731).

obviousclock1(_7698,_7699,[obviousclock1,_7756,_7790,!,_7824],_7739,_7741) --> 
    clock_kernel(_7698,_7699,_7756,_7739,_7775),
    w(noun(time,sin,def,n),_7790,_7775,_7807),
    !,
    accept(_7824,_7807,_7741).

obviousclock1(_7701:clock,_7701 isa clock,[obviousclock1,_7844,_7873,_7902,{},_7941,_7970,_7999,_8028,_8057,_8086,!,_8135],_7827,_7829) --> 
    not_look_ahead(w(name(_7744,n,route)),_7844,_7827,_7861),
    not_look_ahead(w(name(_7752,n,nightbus)),_7873,_7861,_7890),
    w(nb(_7701,num),_7902,_7890,_7919),
    {user:(_7701>=100,clock_test(_7701))},
    not_look_ahead([-],_7941,_7919,_7958),
    not_look_ahead(w(nb(_7779,_7780)),_7970,_7958,_7987),
    not_look_ahead(w(noun(_7786,plu,_7788,_7789)),_7999,_7987,_8016),
    not_look_ahead([tusen],_8028,_8016,_8045),
    not_look_ahead([millioner],_8057,_8045,_8074),
    optional(w(noun(time,sin,def,n)),_8086,_8074,_8118),
    !,
    accept(_8135,_8118,_7829).

obviousclock1(_7701:clock,_7701 isa clock,[obviousclock1,_7745],_7728,_7730) --> 
    time2(_7701,_7745,_7728,_7730).

obviousclock1(_7701:clock,_7701 isa clock,[obviousclock1,_7752,_7781],_7735,_7737) --> 
    hours100(_7701,_7752,_7735,_7769),
    look_ahead([om],_7781,_7769,_7737).

rel_clauses(_7698,_7699,_7700,[rel_clauses,lit(hva),!,_7767],_7731,_7733) --> 
    cc(hva,_7731,_7761),
    !,
    reject(_7767,_7761,_7733).

rel_clauses(_7698,_7699,_7699 and _7703,[rel_clauses,_7787,lit(det),_7822,_7913],_7767,_7769) --> 
    derhvor(_7787,_7767,_7802),
    cc(det,_7802,_7821),
    lock(exact,_7821,_7872),pushstack(exact,(w(prep(in)),npgap(_7698)),nil,_7872,_7878),adverbial1(_7720,_7721,_7722,_7822,_7878,_7867),unlock(_7867,_7868),
    lock(last,_7868,_7962),
    pushstack(last,([det],xadverbial1(_7720,_7721,_7722)),nil,_7962,_7968),
    substatement1(_7703,_7913,_7968,_7957),
    unlock(_7957,_7769).

rel_clauses(_7698,_7699,_7699 and _7703,[rel_clauses,_7808,_7837,_7866,!,_7900],_7788,_7790) --> 
    w(noun(_7733,_7734,_7735,n),_7808,_7788,_7825),
    w(verb(apply,_7741,fin),_7837,_7825,_7854),
    w(prep(_7746),_7866,_7854,_7883),
    !,
    pushstack(first,(w(noun(_7733,_7734,_7735,n)),w(verb(apply,_7741,fin)),w(prep(_7746)),npgap(_7698)),nil,_7883,_7940),
    statreal(_7703,_7900,_7940,_7790).

rel_clauses(_7698,_7699,_7700,[rel_clauses,_7775,_7809],_7755,_7757) --> 
    lit_of(_7710,[jeg,hun,han,vi,man,du],_7775,_7755,_7794),
    pushstack(first,([som],[_7710]),nil,_7794,_7819),
    rel_clause(_7698,_7699,_7700,_7809,_7819,_7757).

rel_clauses(_7698,_7699,_7699 and _7703,[rel_clauses,_7787,lit(det),_7822,_7913],_7767,_7769) --> 
    derhvor(_7787,_7767,_7802),
    cc(det,_7802,_7821),
    lock(exact,_7821,_7872),pushstack(exact,(w(prep(in)),npgap(_7698)),nil,_7872,_7878),adverbial1(_7720,_7721,_7722,_7822,_7878,_7867),unlock(_7867,_7868),
    lock(last,_7868,_7962),
    pushstack(last,([det],xadverbial1(_7720,_7721,_7722)),nil,_7962,_7968),
    substatement1(_7703,_7913,_7968,_7957),
    unlock(_7957,_7769).

rel_clauses(_7698,_7699,_7699 and _7703,[rel_clauses,_7775,_7799,_7833],_7755,_7757) --> 
    derhvor(_7775,_7755,_7790),
    subject(_7722,_7723,_7799,_7790,_7818),
    lock(last,_7818,_7911),
    pushstack(last,(xnp(_7722,_7723),w(prep(in)),npgap(_7698)),nil,_7911,_7917),
    statreal(_7703,_7833,_7917,_7906),
    unlock(_7906,_7757).

rel_clauses(_7698,_7699,_7700,[rel_clauses,lit(som),_7808,_7832,_7861,_7895,!,[],_7985],_7777,_7779) --> 
    cc(som,_7777,_7807),
    danow0(_7808,_7807,_7823),
    look_ahead(w(prep(_7734)),_7832,_7823,_7849),
    gmem(_7734,[of],_7861,_7849,_7880),
    adverbix(_7741,_7742,_7743,_7895,_7880,_7916),
    !,
    pushstack(free,xadverbial1(_7741,_7742,_7743),nil,_7916,_7984),[],
    pushstack(first,[som],nil,_7984,_7995),
    rel_clause(_7698,_7699,_7700,_7985,_7995,_7779).

rel_clauses(_7698,_7699,_7700,[rel_clauses,_7754,_7793],_7734,_7736) --> 
    rel_clause(_7698,_7699,_7706,_7754,_7734,_7775),
    rel_clauses0(_7698,_7706,_7700,_7793,_7775,_7736).

rel_clauses0(_7698,_7699,_7700,[rel_clauses0,_7750,_7774],_7730,_7732) --> 
    and1x(_7750,_7730,_7765),
    rel_clauses(_7698,_7699,_7700,_7774,_7765,_7732).

rel_clauses0(_7698,_7699,_7699,[rel_clauses0,[]],_7723,_7723) --> 
    [].

derhvor([derhvor,_7735,!],_7724,_7726) --> 
    one_of_lit([der,hvor,dit],_7735,_7724,_7726),
    !.

and1x([and1x,_7724],_7713,_7715) --> 
    and1(_7724,_7713,_7715).

and1x([and1x,_7728],_7717,_7719) --> 
    look_ahead([som],_7728,_7717,_7719).

dvs([dvs,lit(dvs)],_7715,_7717) --> 
    cc(dvs,_7715,_7717).

dvs([dvs,lit(altså)],_7715,_7717) --> 
    cc(altså,_7715,_7717).

dvs([dvs,lit(a),lit(la)],_7720,_7722) --> 
    cc(a,_7720,_7741),
    cc(la,_7741,_7722).

rel_clause(_7698,_7699,_7699 and _7703,[rel_clause,_7768,!,_7797],_7748,_7750) --> 
    dvs(_7768,_7748,_7783),
    !,
    lock(last,_7783,_7844),
    pushstack(last,(npgap(_7698),w(verb(be,pres,fin))),nil,_7844,_7850),
    statreal(_7703,_7797,_7850,_7839),
    unlock(_7839,_7750).

rel_clause(_7698,_7699,_7699 and _7703,[rel_clause,_7798,_7827,!,_7866],_7778,_7780) --> 
    w(verb(_7727,past,part),_7798,_7778,_7815),
    gmem(_7727,[adapt,label,be_named,register],_7827,_7815,_7846),
    !,
    lock(last,_7846,_7913),
    pushstack(last,(w(noun(agent,sin,u,n)),w(verb(_7727,past,fin)),npgap(_7698)),nil,_7913,_7919),
    statreal(_7703,_7866,_7919,_7908),
    unlock(_7908,_7780).

rel_clause(_7698,_7699,_7699 and _7703,[rel_clause,_7791,_7820,_7854,!,_7883],_7771,_7773) --> 
    rel(_7698,_7791,_7771,_7808),
    lit_of(_7727,[du,jeg,de,han,hun,vi,dere,man],_7820,_7808,_7839),
    look_ahead_vp(_7854,_7839,_7869),
    !,
    lock(last,_7869,_7930),
    pushstack(last,([_7727],npgap(_7698)),nil,_7930,_7936),
    statreal(_7703,_7883,_7936,_7925),
    unlock(_7925,_7773).

rel_clause(_7698,_7699,_7699 and _7703,[rel_clause,_7765,_7794,_7823],_7745,_7747) --> 
    rel(_7698,_7765,_7745,_7782),
    not_look_ahead([at],_7794,_7782,_7811),
    pushstack(free,npgap(_7698),nil,_7811,_7863),
    statreal(_7703,_7823,_7863,_7747).

rel_clause(_7698,_7699,_7699 and _7703,[rel_clause,_7771,lit(det),!,_7816],_7751,_7753) --> 
    rel(_7698,_7771,_7751,_7788),
    cc(det,_7788,_7810),
    !,
    lock(last,_7810,_7863),
    pushstack(last,([det],npgap(_7698)),nil,_7863,_7869),
    statreal(_7703,_7816,_7869,_7858),
    unlock(_7858,_7753).

relneg(_7698,[relneg,_7739,_7763,!],_7725,_7727) --> 
    relblabla(_7739,_7725,_7754),
    negation0(_7698,_7763,_7754,_7727),
    !.

relneg(_7698,[relneg,_7739,_7768,!],_7725,_7727) --> 
    negation0(_7698,_7739,_7725,_7756),
    relblabla(_7768,_7756,_7727),
    !.

relblabla([relblabla,lit(nå),!],_7718,_7720) --> 
    cc(nå,_7718,_7720),
    !.

relblabla([relblabla,lit(bare),!],_7718,_7720) --> 
    cc(bare,_7718,_7720),
    !.

relblabla([relblabla,_7724],_7713,_7715) --> 
    redundant0(_7724,_7713,_7715).

whose_noun(_7698,_7699,[whose_noun,_7747,_7771],_7730,_7732) --> 
    whose(_7747,_7730,_7762),
    noun(_7704,_7705,u,n,_7698,_7699,_7771,_7762,_7732).

relwhat(_7698,[relwhat,_7748,_7772,{},!,_7811],_7734,_7736) --> 
    hva(_7748,_7734,_7763),
    som0(_7772,_7763,_7787),
    {user:constrain(_7698,thing)},
    !,
    accept(_7811,_7787,_7736).

relwhat(_7698,[relwhat,lit(hvem),_7761,{},!,_7800],_7736,_7738) --> 
    cc(hvem,_7736,_7760),
    som0(_7761,_7760,_7776),
    {user:constrain(_7698,agent)},
    !,
    accept(_7800,_7776,_7738).

rel(_7698,[rel,_7763,_7792,_7821,{},!,_7880],_7749,_7751) --> 
    relpron(_7715,_7763,_7749,_7780),
    not_look_ahead(w(quote(_7721)),_7792,_7780,_7809),
    optional([nå],_7821,_7809,_7853),
    {user:constrain(_7698,_7715)},
    !,
    accept(_7880,_7853,_7751).

comparisons(_7698,_7699,_7700,[comparisons,_7755,_7794],_7735,_7737) --> 
    comparison(_7698,_7699,_7707,_7755,_7735,_7776),
    comparisons0(_7698,_7699,_7707,_7700,_7794,_7776,_7737).

comparisons0(_7698,_7699,_7700,_7700 and _7704,[comparisons0,_7767,_7791,_7830],_7744,_7746) --> 
    and1(_7767,_7744,_7782),
    comparison(_7698,_7699,_7714,_7791,_7782,_7812),
    comparisons0(_7698,_7699,_7714,_7704,_7830,_7812,_7746).

comparisons0(_7698,_7699,_7700,_7700,[comparisons0,[]],_7726,_7726) --> 
    [].

comparison(_7698,_7699,_7700,[comparison,{},{},_7807,!,{}],_7767,_7769) --> 
    {user:vartypeid(_7698,_7725)},
    {user:testmember(_7725,[speed,price,name,description])},
    np1_accept(_7719,_7720::_7700,_7807,_7767,_7769),
    !,
    {user:compare(eq,thing,_7698,_7719,_7720)}.

comparison(_7698,_7699,_7700,[comparison,_7780,{},{},{},!,_7844],_7760,_7762) --> 
    comparator1(_7717,_7780,_7760,_7797),
    {user:_7717==gt},
    {user:vartype(_7698,_7727,_7728)},
    {user:testmember(_7728,[information,minute])},
    !,
    reject(_7844,_7797,_7762).

comparison(_7698,_7699,_7700,[comparison,_7777,{},_7816,{}],_7757,_7759) --> 
    comparator1(_7713,_7777,_7757,_7794),
    {user:testmember(_7713,[eq,ne])},
    noun_phrase1(_7716,_7717::_7700,_7816,_7794,_7759),
    {user:compare(_7713,thing,_7698,_7716,_7717)}.

comparison(_7698,_7699,_7700,[comparison,_7781,{},_7820,{}],_7761,_7763) --> 
    comparator1(_7713,_7781,_7761,_7798),
    {user:testmember(_7713,[gt,ge,le,lt])},
    noun_phrase1(_7716,_7717::_7700,_7820,_7798,_7763),
    {user:compare(_7713,number,_7698,_7716,_7717)}.

comparison(_7698,_7699,_7700,[comparison,_7766,_7800,{}],_7746,_7748) --> 
    comparator2(_7710,_7711,_7766,_7746,_7785),
    noun_phrase1(_7713,_7714::_7700,_7800,_7785,_7748),
    {user:compare(_7710,_7711,_7698,_7713,_7714)}.

comparison(_7698,_7699,_7700,[comparison,_7766,_7800,{}],_7746,_7748) --> 
    comparator3(_7710,_7711,_7766,_7746,_7785),
    noun_phrase1(_7713,_7714::_7700,_7800,_7785,_7748),
    {user:comparad(_7710,_7711,_7698,_7713,_7714)}.

np(_7698,_7699,[np,_7740],_7723,_7725) --> 
    xnp(_7698,_7699,_7740,_7723,_7725).

np(_7698,_7701::_7702,[np,_7746],_7729,_7731) --> 
    noun_phrases(_7698,_7701::_7702,_7746,_7729,_7731).

np(_7698,_7701::_7701,[np,_7742],_7725,_7727) --> 
    npgap(_7698,_7742,_7725,_7727).

np0_accept(_7698,_7701::_7702,[np0_accept,_7752,!,_7791],_7735,_7737) --> 
    np0(_7698,_7701::_7702,_7752,_7735,_7771),
    !,
    accept(_7791,_7771,_7737).

np00(_7698,_7711:_7698,_7702::exists(_7711:_7698)::_7711 isa _7698 and _7702,[np00,[]],_7743,_7743) --> 
    [].

raise_object00(_7698,_7701::_7701 and _7698,[raise_object00,[]],_7726,_7726) --> 
    [].

subject(_7698,_7699,[subject,_7783,_7812,_7841,_7870],_7766,_7768) --> 
    not_look_ahead(w(name(være,n,_7719)),_7783,_7766,_7800),
    not_look_ahead(w(name(norwegian,n,language)),_7812,_7800,_7829),
    not_look_ahead_lit([meg,deg,ham,henne,seg,oss,dem,det],_7841,_7829,_7858),
    np(_7698,_7699,_7870,_7858,_7768).

object1(_7698,_7699,[object1,_7758,_7787,!],_7741,_7743) --> 
    not_look_ahead_lit([jeg,du,han,hun,vi],_7758,_7741,_7775),
    np0(_7698,_7699,_7787,_7775,_7743),
    !.

object(_7698,_7699,[object,_7743,_7767],_7726,_7728) --> 
    not_look_ahead_subject(_7743,_7726,_7758),
    noun_phrase_accept(_7698,_7699,_7767,_7758,_7728).

ind_object(_7698,_7699,[ind_object,_7743,_7767],_7726,_7728) --> 
    not_look_ahead_subject(_7743,_7726,_7758),
    noun_phrase_accept(_7698,_7699,_7767,_7758,_7728).

not_look_ahead_time([not_look_ahead_time,_7730,!,_7759],_7719,_7721) --> 
    look_ahead_time(_7730,_7719,_7745),
    !,
    reject(_7759,_7745,_7721).

look_ahead_time([look_ahead_time,_7729],_7718,_7720) --> 
    w(nb(_7700,_7701),_7729,_7718,_7720).

look_ahead_time([look_ahead_time,_7730],_7719,_7721) --> 
    one_of_lit([halv,kvart],_7730,_7719,_7721).

look_ahead_time([look_ahead_time,_7742,{},!],_7731,_7733) --> 
    w(noun(_7706,_7707,_7708,_7709),_7742,_7731,_7733),
    {user:subclass0(_7706,time)},
    !.

not_look_ahead_subject([not_look_ahead_subject,_7730,!,_7759],_7719,_7721) --> 
    look_ahead_subject(_7730,_7719,_7745),
    !,
    reject(_7759,_7745,_7721).

not_look_ahead_subject([not_look_ahead_subject,[]],_7713,_7713) --> 
    [].

look_ahead_subject([look_ahead_subject,_7738],_7727,_7729) --> 
    look_ahead_lit([jeg,du,han,hun,vi,man],_7738,_7727,_7729).

subject2(_7698,_7699,_7700,[subject2,_7753,!,_7797],_7733,_7735) --> 
    noun_phrase2(_7698,_7699,_7700,_7753,_7733,_7774),
    !,
    accept(_7797,_7774,_7735).

object2hnn(_7698,_7699,_7700,[object2hnn,_7783,_7812,_7841,_7870,!,_7904],_7763,_7765) --> 
    w(name(_7719,_7720,_7721),_7783,_7763,_7800),
    not_look_ahead(w(prep(on)),_7812,_7800,_7829),
    not_look_ahead(w(noun(_7733,_7734,_7735,_7736)),_7841,_7829,_7858),
    not_look_ahead([deg],_7870,_7858,_7887),
    !,
    reject(_7904,_7887,_7765).

object2hnn(_7698,_7699,_7700,[object2hnn,_7753,!,_7797],_7733,_7735) --> 
    object2h(_7698,_7699,_7700,_7753,_7733,_7774),
    !,
    accept(_7797,_7774,_7735).

object2h(_7698,_7699,_7700,[object2h,lit(dere),!,_7767],_7731,_7733) --> 
    cc(dere,_7731,_7761),
    !,
    reject(_7767,_7761,_7733).

object2h(_7698,_7699,_7700,[object2h,_7747],_7727,_7729) --> 
    object2(_7698,_7699,_7700,_7747,_7727,_7729).

object2(_7698,_7699,_7700,[object2,lit(en),lit(gang),!,_7783],_7736,_7738) --> 
    cc(en,_7736,_7766),
    cc(gang,_7766,_7777),
    !,
    reject(_7783,_7777,_7738).

object2(_7698,_7699,_7700,[object2,_7765,_7789,{},!,_7838],_7745,_7747) --> 
    which(_7765,_7745,_7780),
    np(_7699,_7700,_7789,_7780,_7808),
    {user:(\+vartypeid(_7699,place))},
    !,
    accept(_7838,_7808,_7747).

object2(_7698,_7698,_7702::_7702 and _7706,[object2,_7763,_7792,!,_7821],_7743,_7745) --> 
    prep1(around,_7763,_7743,_7780),
    clock(_7792,_7780,_7807),
    !,
    clock_kernel(_7698,_7706,_7821,_7807,_7745).

object2(_7698,_7699,_7702::_7703,[object2,_7760,_7789],_7740,_7742) --> 
    not_look_ahead_lit([middag],_7760,_7740,_7777),
    noun_phrase2(_7698,_7699,_7702::_7703,_7789,_7777,_7742).

object2(_7698,_7699,_7700,[object2,_7766,_7795,!,_7829],_7746,_7748) --> 
    one_of_lit([jeg,du,hun,vi],_7766,_7746,_7783),
    not_look_ahead([som],_7795,_7783,_7812),
    !,
    reject(_7829,_7812,_7748).

noun_phrase2(_7698,_7699,_7702::_7702 and _7706,[noun_phrase2,_7768,!,_7802,_7826],_7748,_7750) --> 
    look_ahead([hvor],_7768,_7748,_7785),
    !,
    accept(_7802,_7785,_7817),
    adverbial_noun_phrase1(_7699,_7702::_7706,_7826,_7817,_7750).

noun_phrase2(_7698,_7698,_7702::_7703,[noun_phrase2,_7762,_7791],_7742,_7744) --> 
    recipron(_7713,_7762,_7742,_7779),
    pushstack(first,npgap(_7698),nil,_7779,_7831),
    noun_phrase1(_7698,_7702::_7703,_7791,_7831,_7744).

noun_phrase2(_7698,_7699,_7702::findalt(diff,_7698,_7699)::_7708 and _7702,[noun_phrase2,_7774,_7798,_7852],_7754,_7756) --> 
    another(_7774,_7754,_7789),
    noun(_7726,sin,u,n,_7699,_7723,_7798,_7789,_7825),
    noun_modsx0(0,_7699,_7723,_7708,_7852,_7825,_7756).

noun_phrase2(_7698,_7699,_7700,[noun_phrase2,_7777,_7806,_7835,!,_7869],_7757,_7759) --> 
    not_look_ahead(w(noun(_7718,_7719,_7720,_7721)),_7777,_7757,_7794),
    not_look_ahead(w(adj2(_7727,_7728)),_7806,_7794,_7823),
    w(verb(_7732,past,part),_7835,_7823,_7852),
    !,
    reject(_7869,_7852,_7759).

noun_phrase2(_7698,_7699,_7700,[noun_phrase2,_7756,!,_7790],_7736,_7738) --> 
    look_ahead([hva],_7756,_7736,_7773),
    !,
    np(_7699,_7700,_7790,_7773,_7738).

noun_phrase2(_7698,_7699,_7700,[noun_phrase2,_7756,_7785,_7809],_7736,_7738) --> 
    not_look_ahead([hva],_7756,_7736,_7773),
    which0(_7785,_7773,_7800),
    np(_7699,_7700,_7809,_7800,_7738).

adverbial_noun_phrase1(_7698,_7701::_7701 and _7705,[adverbial_noun_phrase1,lit(hvor),_7808,_7837,!,_7903],_7780,_7782) --> 
    cc(hvor,_7780,_7807),
    not_look_ahead([mye],_7808,_7807,_7825),
    lock(exact,_7825,_7857),pushstack(exact,(w(prep(in)),w(noun(place,sin,u,n))),nil,_7857,_7863),adverbial1(_7722,_7698,_7726::_7727,_7837,_7863,_7852),unlock(_7852,_7853),
    !,
    lock(last,_7853,_7955),
    pushstack(last,adverbial1(_7722,_7698,_7726::_7727),nil,_7955,_7961),
    statreal(_7705,_7903,_7961,_7950),
    unlock(_7950,_7782).

noun_phrase_accept(_7698,_7699,[noun_phrase_accept,_7746,!,_7785],_7729,_7731) --> 
    np(_7698,_7699,_7746,_7729,_7765),
    !,
    accept(_7785,_7765,_7731).

np1_accept(_7698,_7699,[np1_accept,_7746,!,_7785],_7729,_7731) --> 
    noun_phrase1(_7698,_7699,_7746,_7729,_7765),
    !,
    accept(_7785,_7765,_7731).

noun_phrases2(_7698,_7701::_7704 and _7705,[noun_phrases2,_7777,_7811,_7835,{},!,_7884],_7760,_7762) --> 
    np1_accept(_7722,_7701::_7704,_7777,_7760,_7796),
    and0(_7811,_7796,_7826),
    np1_accept(_7728,_7701::_7705,_7835,_7826,_7854),
    {user:latin(and,_7722,_7728,_7698)},
    !,
    accept(_7884,_7854,_7762).

noun_phrases(_7698,_7701::_7704 and _7707 and _7708,[noun_phrases,_7816,_7845,{},{},_7899,_7933,{},!,_7982],_7799,_7801) --> 
    look_ahead(w(noun(distance,sin,def,n)),_7816,_7799,_7833),
    noun_phrase1(_7743,_7701::_7704,_7845,_7833,_7864),
    {user:vartypeid(_7743,_7752)},
    {user:testmember(_7752,[distance])},
    noun_phrase1(_7761,_7701::_7707,_7899,_7864,_7918),
    noun_phrase1(_7767,_7701::_7708,_7933,_7918,_7952),
    {user:latin(and,_7761,_7767,_7698)},
    !,
    accept(_7982,_7952,_7801).

noun_phrases(_7698,_7701::_7702,[noun_phrases,_7763,_7797,!,_7846],_7746,_7748) --> 
    noun_phrase1(_7713,_7701::_7717,_7763,_7746,_7782),
    noun_phrases0(_7713,_7698,true::_7717,_7702,_7797,_7782,_7820),
    !,
    accept(_7846,_7820,_7748).

noun_phrases0(_7698,_7698,_7703::_7701,_7701,[noun_phrases0,{},!],_7737,_7737) --> 
    {user:constrain(_7698,number)},
    !.

noun_phrases0(_7698,_7698,_7703::_7701,_7701,[noun_phrases0,_7762,!],_7739,_7741) --> 
    look_ahead(w(nb(_7713,_7714)),_7762,_7739,_7741),
    !.

noun_phrases0(_7698,_7698,_7703::_7701,_7701,[noun_phrases0,_7761,!],_7738,_7740) --> 
    look_ahead_lit([etc,samme],_7761,_7738,_7740),
    !.

noun_phrases0(_7698,_7698,_7703::_7701,_7701,[noun_phrases0,_7775,{},!],_7752,_7754) --> 
    look_ahead(w(verb(_7716,inf,fin)),_7775,_7752,_7754),
    {user:testmember(_7716,[be,use])},
    !.

noun_phrases0(_7698,_7698,_7703::_7701,_7701,[noun_phrases0,_7775,{},!],_7752,_7754) --> 
    look_ahead(w(verb(_7716,pres,fin)),_7775,_7752,_7754),
    {user:testmember(_7716,[wish,want])},
    !.

noun_phrases0(_7698,_7699,_7706::_7703,_7703 and _7704,[noun_phrases0,_7804,_7833,_7862,_7891,_7925,{}],_7781,_7783) --> 
    not_look_ahead([','],_7804,_7781,_7821),
    np_conjunction(_7726,_7833,_7821,_7850),
    not_look_ahead(w(noun(_7741,sin,def,n)),_7862,_7850,_7879),
    noun_phrase1(_7746,_7706::_7750,_7891,_7879,_7910),
    noun_phrases20(_7746,_7728,_7706,_7750,_7704,_7925,_7910,_7783),
    {user:latin(_7726,_7698,_7728,_7699)}.

noun_phrases0(_7698,_7699,_7706::_7703,_7703 and _7704,[noun_phrases0,{},_7800,_7834,{}],_7767,_7769) --> 
    {user:(\+vartypeid(_7698,savant))},
    noun_phrase1(_7732,_7706::_7736,_7800,_7767,_7819),
    noun_phrases10(_7732,_7722,_7706,_7736,_7704,_7834,_7819,_7769),
    {user:latin(and,_7698,_7722,_7699)}.

noun_phrases0(_7698,_7698,_7703::_7701,_7701,[noun_phrases0,[]],_7729,_7729) --> 
    [].

noun_phrases10(_7698,_7699,_7700,_7701,_7701 and _7705,[noun_phrases10,_7793,_7822,_7856,{},lit(etc)],_7767,_7769) --> 
    andor(_7721,_7793,_7767,_7810),
    noun_phrase1(_7723,_7700::_7727,_7822,_7810,_7841),
    noun_phrases20(_7723,_7730,_7700,_7727,_7705,_7856,_7841,_7881),
    {user:latin(_7721,_7698,_7730,_7699)},
    cc(etc,_7881,_7769).

noun_phrases10(_7698,_7699,_7700,_7701,_7701 and _7705,[noun_phrases10,_7793,_7822,_7856,{}],_7767,_7769) --> 
    not_look_ahead(w(nb(_7727,_7728)),_7793,_7767,_7810),
    noun_phrase1(_7730,_7700::_7734,_7822,_7810,_7841),
    noun_phrases10(_7730,_7720,_7700,_7734,_7705,_7856,_7841,_7769),
    {user:latin(and,_7698,_7720,_7699)}.

noun_phrases10(_7698,_7698,_7700,_7701,_7701,[noun_phrases10,lit(etc)],_7731,_7733) --> 
    cc(etc,_7731,_7733).

noun_phrases20(_7698,_7699,_7700,_7701,_7701 and _7705,[noun_phrases20,_7788,_7817,_7851,{}],_7762,_7764) --> 
    andor(_7718,_7788,_7762,_7805),
    noun_phrase1(_7725,_7700::_7729,_7817,_7805,_7836),
    noun_phrases20(_7725,_7720,_7700,_7729,_7705,_7851,_7836,_7764),
    {user:latin(_7718,_7698,_7720,_7699)}.

noun_phrases20(_7698,_7698,_7700,_7701,_7701,[noun_phrases20,[]],_7729,_7729) --> 
    [].

no_phrases(_7698,_7699,[no_phrases,{},!,_7769],_7737,_7739) --> 
    {user:value(teleflag,true)},
    !,
    np(_7698,true::_7699,_7769,_7737,_7739).

no_phrases(_7698,_7699,[no_phrases,_7746,_7770],_7729,_7731) --> 
    the0(_7746,_7729,_7761),
    np(_7698,true::_7699,_7770,_7761,_7731).

no_phrase(_7698,_7699,[no_phrase,_7746,_7770],_7729,_7731) --> 
    the0(_7746,_7729,_7761),
    noun_phrase1(_7698,true::_7699,_7770,_7761,_7731).

noun_phrase1(_7698,_7699,[noun_phrase1,lit(og),!,_7761],_7728,_7730) --> 
    cc(og,_7728,_7755),
    !,
    reject(_7761,_7755,_7730).

noun_phrase1(_7698,_7699,[noun_phrase1,_7740],_7723,_7725) --> 
    np2(_7698,_7699,_7740,_7723,_7725).

noun_phrase1(_7698,_7699,[noun_phrase1,_7740],_7723,_7725) --> 
    np1(_7698,_7699,_7740,_7723,_7725).

noun_phrase1(_7698,_7699,[noun_phrase1,_7767,_7796,_7825,_7854,_7878],_7750,_7752) --> 
    one_of_lit([noen,mange],_7767,_7750,_7784),
    not_look_ahead([som],_7796,_7784,_7813),
    not_look_ahead([av],_7825,_7813,_7842),
    not_look_ahead_np(_7854,_7842,_7869),
    np00(agent,_7698,_7699,_7878,_7869,_7752).

noun_phrase1(_7698,_7699,[noun_phrase1,_7764,_7793,_7822,_7846],_7747,_7749) --> 
    one_of_lit([den,det],_7764,_7747,_7781),
    not_look_ahead(w(verb(_7724,_7725,pass)),_7793,_7781,_7810),
    not_look_ahead_np(_7822,_7810,_7837),
    np00(thing,_7698,_7699,_7846,_7837,_7749).

noun_phrase1(_7698,_7701::_7702,[noun_phrase1,_7804,_7833,_7862,_7896,_7925,!,_7959,_7983],_7787,_7789) --> 
    not_look_ahead([de],_7804,_7787,_7821),
    not_look_ahead([det],_7833,_7821,_7850),
    quant_pron(some,_7733,_7862,_7850,_7881),
    not_look_ahead([som],_7896,_7881,_7913),
    not_look_ahead(w(noun(_7757,_7758,_7759,_7760)),_7925,_7913,_7942),
    !,
    accept(_7959,_7942,_7974),
    lock(exact,_7974,_8033),
    pushstack(exact,(some,w(noun(_7733,sin,u,n))),nil,_8033,_8039),
    np1(_7698,_7701::_7702,_7983,_8039,_8028),
    unlock(_8028,_7789).

noun_phrase1(_7698,_7699,[noun_phrase1,_7796,_7825,_7859,_7888,!,_7922,_7946],_7779,_7781) --> 
    not_look_ahead([de],_7796,_7779,_7813),
    quant_pron(every,thing,_7825,_7813,_7844),
    not_look_ahead(w(noun(_7743,_7744,_7745,_7746)),_7859,_7844,_7876),
    not_look_ahead(w(adj2(_7752,_7753)),_7888,_7876,_7905),
    !,
    accept(_7922,_7905,_7937),
    pushstack(first,([alle],w(noun(thing,sin,u,n))),nil,_7937,_7956),
    np1(_7698,_7699,_7946,_7956,_7781).

noun_phrase1(_7698,_7699,[noun_phrase1,_7740],_7723,_7725) --> 
    npa(_7698,_7699,_7740,_7723,_7725).

noun_phrase1(_7698,_7701::_7702,[noun_phrase1,_7765,_7799],_7748,_7750) --> 
    quant_pron(much,_7715,_7765,_7748,_7784),
    lock(exact,_7784,_7849),
    pushstack(exact,(much,w(noun(_7715,sin,u,n))),nil,_7849,_7855),
    np1(_7698,_7701::_7702,_7799,_7855,_7844),
    unlock(_7844,_7750).

noun_phrase1(_7698,_7701::_7702,[noun_phrase1,_7765,_7799],_7748,_7750) --> 
    quant_pron(little,_7715,_7765,_7748,_7784),
    lock(exact,_7784,_7849),
    pushstack(exact,(little,w(noun(_7715,sin,u,n))),nil,_7849,_7855),
    np1(_7698,_7701::_7702,_7799,_7855,_7844),
    unlock(_7844,_7750).

noun_phrase1(_7698,_7701::not _7704,[noun_phrase1,_7767,_7801],_7750,_7752) --> 
    quant_pron(no,_7717,_7767,_7750,_7786),
    lock(exact,_7786,_7851),
    pushstack(exact,(every,w(noun(_7717,sin,u,n))),nil,_7851,_7857),
    np1(_7698,_7701::_7704,_7801,_7857,_7846),
    unlock(_7846,_7752).

noun_phrase1(_7698,_7699,[noun_phrase1,_7740],_7723,_7725) --> 
    xnp(_7698,_7699,_7740,_7723,_7725).

noun_phrase1(_7698,_7701::_7701,[noun_phrase1,_7742],_7725,_7727) --> 
    npgap(_7698,_7742,_7725,_7727).

specific_phrase(_7698,_7699,[specific_phrase,_7749,!,_7783],_7732,_7734) --> 
    w(name(_7709,gen,_7711),_7749,_7732,_7766),
    !,
    reject(_7783,_7766,_7734).

specific_phrase(_7698,_7699,[specific_phrase,_7752,_7781,!,_7810],_7735,_7737) --> 
    w(name(_7712,_7713,_7714),_7752,_7735,_7769),
    sin(_7781,_7769,_7796),
    !,
    reject(_7810,_7796,_7737).

specific_phrase(_7698,_7701::_7702,[specific_phrase,_7746],_7729,_7731) --> 
    sp1(_7698,_7701::_7702,_7746,_7729,_7731).

sp1(_7710:_7711,_7701::findpron(_7710:_7711)::_7710 isa _7719 and _7701,[sp1,_7767,{}],_7750,_7752) --> 
    pronoun(_7719,_7767,_7750,_7752),
    {user:type(_7719,_7711)}.

sp1(_7698,_7699,[sp1,_7753,_7792],_7736,_7738) --> 
    name_phrase(name,_7698,_7699,_7753,_7736,_7774),
    not_look_ahead(w(noun(_7708,_7709,_7710,_7711)),_7792,_7774,_7738).

np0(_7698,_7699,[np0,lit(mye),_7786,_7810,_7839,!,_7905],_7758,_7760) --> 
    cc(mye,_7758,_7785),
    not_look_ahead_np(_7786,_7785,_7801),
    not_look_ahead(w(adj(_7722,_7723)),_7810,_7801,_7827),
    lock(exact,_7827,_7859),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7859,_7865),np_kernel(0,_7698,_7699,_7839,_7865,_7854),unlock(_7854,_7855),
    !,
    accept(_7905,_7855,_7760).

np0(_7698,_7701::_7702,[np0,_7753,!,_7797],_7736,_7738) --> 
    np_head1(_7710,_7698,_7701::_7702,_7753,_7736,_7774),
    !,
    accept(_7797,_7774,_7738).

np0(_7698,_7701::_7702,[np0,_7750,_7774],_7733,_7735) --> 
    the10(_7750,_7733,_7765),
    aname_phrase(_7707,_7698,_7701::_7702,_7774,_7765,_7735).

np0(_7698,_7701::_7702,[np0,_7747],_7730,_7732) --> 
    np_kernel(_7704,_7698,_7701::_7702,_7747,_7730,_7732).

np0(_7698,_7701::_7702,[np0,_7746],_7729,_7731) --> 
    npa(_7698,_7701::_7702,_7746,_7729,_7731).

np0(_7698,_7701::_7701,[np0,_7742],_7725,_7727) --> 
    npgap(_7698,_7742,_7725,_7727).

obvious_object(_7698,_7699,[obvious_object,lit(det),_7767,!,_7801],_7739,_7741) --> 
    cc(det,_7739,_7766),
    not_look_ahead(w(verb(_7716,_7717,pass)),_7767,_7766,_7784),
    !,
    reject(_7801,_7784,_7741).

obvious_object(_7698,_7699,[obvious_object,_7750,_7779,!],_7733,_7735) --> 
    look_ahead([alt],_7750,_7733,_7767),
    np1_accept(_7698,_7699,_7779,_7767,_7735),
    !.

obvious_object(_7698,_7699,[obvious_object,_7747,_7776],_7730,_7732) --> 
    not_look_ahead([noen],_7747,_7730,_7764),
    np0_accept(_7698,_7699,_7776,_7764,_7732).

np1(_7698,_7701::_7701 and _7705,[np1,_7809,lit(det),_7844,lit(å),!,_7889,!,_7937],_7792,_7794) --> 
    hvormye(_7809,_7792,_7824),
    cc(det,_7824,_7843),
    w(verb(_7743,_7744,fin),_7844,_7843,_7861),
    cc(å,_7861,_7883),
    !,
    pushstack(first,([noen],[vil]),nil,_7883,_7902),clausal_object1(_7757,_7758,_7889,_7902,_7917),
    !,
    lock(exact,_7917,_8015),
    pushstack(exact,(xnp(_7757,_7758),w(verb(_7743,_7744,fin)),npgap(_7698)),nil,_8015,_8021),
    statreal1(_7705,_7937,_8021,_8010),
    unlock(_8010,_7794).

np1(_7698,_7699,[np1,lit(noe),_7787,!,_7821,_7882],_7759,_7761) --> 
    cc(noe,_7759,_7786),
    look_ahead(w(prep(_7724)),_7787,_7786,_7804),
    !,
    lock(exact,_7804,_7841),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7841,_7847),np_kernel(0,_7698,_7715,_7821,_7847,_7836),unlock(_7836,_7837),
    noun_modifiers0(0,_7698,_7715,_7699,_7882,_7837,_7761).

np1(_7698,_7699,[np1,_7843,_7867,_7896,_7925,{},!,_7969,_7993,_8054],_7826,_7828) --> 
    a(_7843,_7826,_7858),
    w(noun(_7742,sin,u,n),_7867,_7858,_7884),
    w(name(_7736,n,_7738),_7896,_7884,_7913),
    w(noun(_7755,sin,u,n),_7925,_7913,_7942),
    {user:(\+testmember(_7755,[minute,hour,direction,home,station]))},
    !,
    accept(_7969,_7942,_7984),
    lock(exact,_7984,_8013),pushstack(exact,w(noun(_7755,sin,u,n)),nil,_8013,_8019),np_kernel(_7787,_7698,_7789,_7993,_8019,_8008),unlock(_8008,_8009),
    lock(exact,_8009,_8071),
    pushstack(exact,(w(prep(with)),w(noun(_7742,sin,u,n)),w(name(_7736,n,_7738))),nil,_8071,_8077),
    noun_modifiers0(0,_7698,_7789,_7699,_8054,_8077,_8066),
    unlock(_8066,_7828).

np1(_7698,_7699,[np1,lit(hvem),_7786,!,_7820,_7859],_7758,_7760) --> 
    cc(hvem,_7758,_7785),
    look_ahead_lit([man,jeg,du,vi],_7786,_7785,_7803),
    !,
    np00(agent,_7698,_7732,_7820,_7803,_7841),
    pushstack(first,relpron(agent),nil,_7841,_7902),
    noun_modifiers0(0,_7698,_7732,_7699,_7859,_7902,_7760).

np1(_7698,_7699,[np1,lit(hvem),lit(som),!,_7794,_7833],_7750,_7752) --> 
    cc(hvem,_7750,_7777),
    cc(som,_7777,_7788),
    !,
    np00(agent,_7698,_7724,_7794,_7788,_7815),
    pushstack(first,relpron(agent),nil,_7815,_7873),
    noun_modifiers0(0,_7698,_7724,_7699,_7833,_7873,_7752).

np1(_7698,_7699,[np1,_7773,_7797,!,_7826,_7887],_7756,_7758) --> 
    hvormye(_7773,_7756,_7788),
    dette(_7797,_7788,_7812),
    !,
    lock(exact,_7812,_7846),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7846,_7852),np_kernel(0,_7698,_7730,_7826,_7852,_7841),unlock(_7841,_7842),
    pushstack(first,relpron(thing),nil,_7842,_7928),
    noun_modifiers0(0,_7698,_7730,_7699,_7887,_7928,_7758).

np1(_7698,_7699,[np1,lit(hva),lit(som),!,_7794,_7833],_7750,_7752) --> 
    cc(hva,_7750,_7777),
    cc(som,_7777,_7788),
    !,
    np00(thing,_7698,_7724,_7794,_7788,_7815),
    pushstack(first,relpron(thing),nil,_7815,_7873),
    noun_modifiers0(0,_7698,_7724,_7699,_7833,_7873,_7752).

np1(_7698,_7699,[np1,lit(hva),_7786,!,_7815,_7876],_7758,_7760) --> 
    cc(hva,_7758,_7785),
    look_ahead_np(_7786,_7785,_7801),
    !,
    lock(exact,_7801,_7835),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7835,_7841),np_kernel(0,_7698,_7732,_7815,_7841,_7830),unlock(_7830,_7831),
    pushstack(first,relpron(thing),nil,_7831,_7916),
    noun_modifiers0(0,_7698,_7732,_7699,_7876,_7916,_7760).

np1(_7698,_7699,[np1,lit(de),_7782,_7811,!,_7845],_7754,_7756) --> 
    cc(de,_7754,_7781),
    not_look_ahead(w(nb(_7723,_7724)),_7782,_7781,_7799),
    look_ahead(w(noun(_7730,sin,_7732,_7733)),_7811,_7799,_7828),
    !,
    np00(agent,_7698,_7699,_7845,_7828,_7756).

np1(_7698,_7699,[np1,_7801,!,_7830,lit(å),_7875,!,_7909,_7970],_7784,_7786) --> 
    noemed(_7801,_7784,_7816),
    !,
    np0_accept(_7728,_7729,_7830,_7816,_7849),
    cc(å,_7849,_7874),
    w(verb(do1,inf,fin),_7875,_7874,_7892),
    !,
    lock(exact,_7892,_7929),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7929,_7935),np_kernel(_7752,_7698,_7754,_7909,_7935,_7924),unlock(_7924,_7925),
    pushstack(first,(w(prep(with)),xnp(_7728,_7729)),nil,_7925,_8011),
    noun_modifiers0(_7752,_7698,_7754,_7699,_7970,_8011,_7786).

noemed([noemed,lit(noe),lit(med)],_7720,_7722) --> 
    cc(noe,_7720,_7741),
    cc(med,_7741,_7722).

np1(_7698,_7699,[np1,_7775,!,_7804,_7865],_7758,_7760) --> 
    noeå(_7775,_7758,_7790),
    !,
    lock(exact,_7790,_7824),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7824,_7830),np_kernel(0,_7698,_7730,_7804,_7830,_7819),unlock(_7819,_7820),
    pushstack(first,([som],[jeg]),nil,_7820,_7875),
    noun_modifiers0(0,_7698,_7730,_7699,_7865,_7875,_7760).

noeå([noeå,lit(noe),lit(å)],_7720,_7722) --> 
    cc(noe,_7720,_7741),
    cc(å,_7741,_7722).

np1(_7698,_7699,[np1,_7770,!,_7799,_7860],_7753,_7755) --> 
    noesom(_7770,_7753,_7785),
    !,
    lock(exact,_7785,_7819),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7819,_7825),np_kernel(0,_7698,_7727,_7799,_7825,_7814),unlock(_7814,_7815),
    pushstack(first,[som],nil,_7815,_7870),
    noun_modifiers0(0,_7698,_7727,_7699,_7860,_7870,_7755).

noesom([noesom,lit(det),_7750],_7728,_7730) --> 
    cc(det,_7728,_7749),
    look_ahead_lit([man,jeg,du,vi],_7750,_7749,_7730).

noesom([noesom,lit(det),lit(som)],_7720,_7722) --> 
    cc(det,_7720,_7741),
    cc(som,_7741,_7722).

noesom([noesom,lit(noe),lit(som)],_7720,_7722) --> 
    cc(noe,_7720,_7741),
    cc(som,_7741,_7722).

noesom([noesom,lit(noe),_7750],_7728,_7730) --> 
    cc(noe,_7728,_7749),
    look_ahead_lit([jeg,du,han,hun],_7750,_7749,_7730).

noesom([noesom,lit(hva),lit(som)],_7720,_7722) --> 
    cc(hva,_7720,_7741),
    cc(som,_7741,_7722).

noesom([noesom,lit(det),_7749,!],_7727,_7729) --> 
    cc(det,_7727,_7748),
    look_ahead_lit([jeg,du],_7749,_7748,_7729),
    !.

np1(_7698,_7699,[np1,lit(det),_7780,!,_7814,_7853],_7752,_7754) --> 
    cc(det,_7752,_7779),
    look_ahead([de],_7780,_7779,_7797),
    !,
    np00(agent,_7698,_7726,_7814,_7797,_7835),
    pushstack(first,[som],nil,_7835,_7863),
    noun_modifiers0(0,_7698,_7726,_7699,_7853,_7863,_7754).

np1(_7698,_7699,[np1,lit(noen),_7780,!,_7814,_7853],_7752,_7754) --> 
    cc(noen,_7752,_7779),
    look_ahead([de],_7780,_7779,_7797),
    !,
    np00(agent,_7698,_7726,_7814,_7797,_7835),
    pushstack(first,[som],nil,_7835,_7863),
    noun_modifiers0(0,_7698,_7726,_7699,_7853,_7863,_7754).

np1(_7698,_7699,[np1,lit(hvilke),_7783,_7822,_7851,!,_7880],_7755,_7757) --> 
    cc(hvilke,_7755,_7782),
    np_kernel(_7723,_7698,_7725,_7783,_7782,_7804),
    not_look_ahead([som],_7822,_7804,_7839),
    look_ahead_np(_7851,_7839,_7866),
    !,
    pushstack(first,[som],nil,_7866,_7890),
    noun_modifiers0(_7723,_7698,_7725,_7699,_7880,_7890,_7757).

np1(_7698,_7699,[np1,lit(hvilke),_7775,_7814,!,_7848],_7747,_7749) --> 
    cc(hvilke,_7747,_7774),
    np_kernel(_7713,_7698,_7715,_7775,_7774,_7796),
    look_ahead([som],_7814,_7796,_7831),
    !,
    noun_modifiers0(_7713,_7698,_7715,_7699,_7848,_7831,_7749).

np1(_7698,_7699,[np1,{},lit(de),_7857,_7886,_7915,_7944,!,_7978,[],_8016,_8064],_7819,_7821) --> 
    {user:value(busflag,true)},
    cc(de,_7819,_7856),
    w(nb(_7745,num),_7857,_7856,_7874),
    flnp(_7748,_7886,_7874,_7903),
    not_look_ahead(w(noun(_7754,_7755,_7756,_7757)),_7915,_7903,_7932),
    w(prep(_7761),_7944,_7932,_7961),
    !,
    accept(_7978,_7961,_7993),
    pushstack(free,w(prep(_7761)),nil,_7993,_8015),[],
    pushstack(first,(w(nb(_7745,num)),w(adj2(_7748,nil)),w(noun(vehicle,sin,u,n))),nil,_8015,_8029),np_kernel(_7731,_7698,_7733,_8016,_8029,_8046),
    noun_modifiers0(_7731,_7698,_7733,_7699,_8064,_8046,_7821).

np1(_7698,_7701::_7702,[np1,_7752,!,_7791],_7735,_7737) --> 
    obviousclock(_7698,_7701::_7702,_7752,_7735,_7771),
    !,
    accept(_7791,_7771,_7737).

np1(_7698,_7699,[np1,{},lit(en),_7834,{},_7873,!,_7907,_7931,_7979],_7796,_7798) --> 
    {user:value(busflag,true)},
    cc(en,_7796,_7833),
    w(nb(_7739,num),_7834,_7833,_7851),
    {user:plausible_busno(_7739)},
    not_look_ahead(w(noun(_7750,_7751,_7752,_7753)),_7873,_7851,_7890),
    !,
    accept(_7907,_7890,_7922),
    pushstack(first,(w(noun(vehicle,sin,u,n)),w(nb(_7739,num))),nil,_7922,_7944),np_kernel(_7725,_7698,_7727,_7931,_7944,_7961),
    noun_modifiers0(_7725,_7698,_7727,_7699,_7979,_7961,_7798).

np1(_7698,_7701::_7702,[np1,_7761,_7800],_7744,_7746) --> 
    np_kernel(_7707,_7698,_7719::_7720,_7761,_7744,_7782),
    noun_modifiers0(_7707,_7698,_7719::_7720,_7701::_7702,_7800,_7782,_7746).

np_kernel(0,_7711:thing,_7702::findpron(_7711:thing)::_7711 isa thing and _7702,[np_kernel,_7769,_7793,!],_7749,_7751) --> 
    dette(_7769,_7749,_7784),
    not_look_ahead_np(_7793,_7784,_7751),
    !.

np_kernel(0,_7711:agent,_7702::findpron(_7711:agent)::_7711 isa agent and _7702,[np_kernel,lit(de),_7810,_7839,_7868,!],_7779,_7781) --> 
    cc(de,_7779,_7809),
    not_look_ahead(w(nb(_7740,_7741)),_7810,_7809,_7827),
    not_look_ahead(w(adj2(_7747,_7748)),_7839,_7827,_7856),
    look_ahead(w(verb(_7754,pres,fin)),_7868,_7856,_7781),
    !.

np_kernel(0,_7699,_7702::_7703,[np_kernel,_7758,!,_7797],_7738,_7740) --> 
    obviousdate(_7699,_7702::_7703,_7758,_7738,_7777),
    !,
    accept(_7797,_7777,_7740).

np_kernel(0,_7711:thing,_7702::findpron(_7711:thing)::_7711 isa thing and _7702,[np_kernel,lit(en),_7798,!],_7767,_7769) --> 
    cc(en,_7767,_7797),
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_7798,_7797,_7769),
    !.

np_kernel(name,_7711:_7712,_7702::findpron(_7711:_7712)::_7711 isa _7712 and _7702,[np_kernel,_7781,_7810,!],_7761,_7763) --> 
    not_look_ahead_lit([de,den,det,et],_7781,_7761,_7798),
    pronoun(_7712,_7810,_7798,_7763),
    !.

np_kernel(0,_7711:thing,_7702::exists(_7711:thing)::_7711 isa thing and _7702,[np_kernel,_7781,_7810,!],_7761,_7763) --> 
    one_of_lit([alt,noe],_7781,_7761,_7798),
    look_ahead_lit([som,å],_7810,_7798,_7763),
    !.

np_kernel(_7698,_7699,_7702::_7703,[np_kernel,_7753],_7733,_7735) --> 
    np_head1(_7698,_7699,_7702::_7703,_7753,_7733,_7735).

np_kernel(_7698,_7699,_7700,[np_kernel,_7770,_7799,_7828],_7750,_7752) --> 
    look_ahead(w(name(_7716,n,_7718)),_7770,_7750,_7787),
    not_look_ahead(w(noun(_7724,_7725,_7726,_7727)),_7799,_7787,_7816),
    aname_phrase(_7698,_7699,_7700,_7828,_7816,_7752).

np_kernel(_7698,_7699,_7702::_7703,[np_kernel,_7753],_7733,_7735) --> 
    np_head(_7698,_7699,_7702::_7703,_7753,_7733,_7735).

np_kernel(_7698,_7699,_7702::_7703,[np_kernel,_7764,_7793],_7744,_7746) --> 
    not_look_ahead(w(name(_7719,n,_7721)),_7764,_7744,_7781),
    aname_phrase(_7698,_7699,_7702::_7703,_7793,_7781,_7746).

np_head1(_7698,_7699,_7702::_7703,[np_head1,{},_7795,_7844,_7873,{}],_7765,_7767) --> 
    {user:value(teleflag,true)},
    determiner0(_7729,_7698,_7699,_7722,_7702::_7703,_7795,_7765,_7820),
    preadjs0(_7719,_7844,_7820,_7861),
    noun_list2(_7740,_7699,_7721,_7873,_7861,_7767),
    {user:preadjs_template(_7719,_7699,_7721,_7722)}.

np_head1(0,_7705:_7706,_7702::_7703,[np_head1,{},_7834,_7878,_7932,!,{},{},{}],_7804,_7806) --> 
    {user:value(busflag,true)},
    optional([denne],_7834,_7804,_7866),
    bus_head(_7745,_7731,_7747,_7706,_7749,_7705,_7878,_7866,_7905),
    not_look_ahead_lit([sin,sitt,sine],_7932,_7905,_7806),
    !,
    {user:decide_adjective(_7747,_7705,_7764)},
    {user:_7768=(_7705 isa _7706 and _7764)},
    {user:decide_quantifier(_7731,_7705:_7706,_7768 and _7702,_7703)}.

np_head1(0,_7699,_7702::_7703,[np_head1,{},lit(den),_7848,{},_7887,!,_7921,_7945,!,_8011],_7807,_7809) --> 
    {user:value(busflag,true)},
    cc(den,_7807,_7847),
    w(adj2(_7741,nil),_7848,_7847,_7865),
    {user:testmember(_7741,[first,last,next,previous])},
    look_ahead([som],_7887,_7865,_7904),
    !,
    accept(_7921,_7904,_7936),
    lock(exact,_7936,_7965),pushstack(exact,(w(adj2(_7741,nil)),w(noun(vehicle,sin,u,n))),nil,_7965,_7971),np_head(0,_7699,_7702::_7703,_7945,_7971,_7960),unlock(_7960,_7961),
    !,
    accept(_8011,_7961,_7809).

np_head1(0,_7699,_7702::exists(_7699)::_7708 and _7711 and _7702,[np_head1,_7795,_7824,_7853,{},!,_7922],_7775,_7777) --> 
    not_look_ahead([dere],_7795,_7775,_7812),
    w(name(_7737,_7738,_7739),_7824,_7812,_7841),
    noun(_7741,_7742,_7743,n,_7699,_7711,_7853,_7841,_7880),
    {user:adjnamecomp_template(_7737,_7699,_7708)},
    !,
    accept(_7922,_7880,_7777).

bus_head(_7698,_7699,_7700,_7701,_7701,_7703,[bus_head,_7804,_7838,_7872,{},{},_7926,_7960],_7775,_7777) --> 
    traceprint(5,bx01,_7804,_7775,_7823),
    art0(_7698,_7730,_7838,_7823,_7857),
    quantnext(_7699,_7700,_7872,_7857,_7891),
    {user:_7700\==nil},
    {user:_7699=<5},
    busnumber(_7703,_7701,_7926,_7891,_7945),
    traceprint(4,bh01,_7960,_7945,_7777).

bus_head(_7698,_7699,_7700,_7701,_7702,_7703,[bus_head,_7797,_7831,_7865,{},_7909,_7948],_7768,_7770) --> 
    traceprint(5,bx02,_7797,_7768,_7816),
    art0(_7698,_7727,_7831,_7816,_7850),
    quantnext(_7699,_7700,_7865,_7850,_7884),
    {user:_7699=<5},
    busseno(_7703,_7701,_7702,_7909,_7884,_7930),
    traceprint(4,bh02,_7948,_7930,_7770).

bus_head(_7698,_7699,_7700,_7701,_7701,_7703,[bus_head,_7809,_7843,_7877,{},_7921,_7950,_7974,_8008],_7780,_7782) --> 
    traceprint(5,bx03,_7809,_7780,_7828),
    art0(_7698,_7733,_7843,_7828,_7862),
    quantnext(_7699,_7700,_7877,_7862,_7896),
    {user:_7699=<5},
    not_look_ahead(w(nb(_7747,_7748)),_7921,_7896,_7938),
    nr0(_7950,_7938,_7965),
    busnumber(_7703,_7701,_7974,_7965,_7993),
    traceprint(4,bh03,_8008,_7993,_7782).

bus_head(_7698,_7699,_7700,_7701,_7701,_7703,[bus_head,_7818,_7852,_7886,{},_7930,_7959,_8015,!],_7789,_7791) --> 
    traceprint(5,bx04,_7818,_7789,_7837),
    art0(_7698,_7730,_7852,_7837,_7871),
    quantnext(_7699,_7700,_7886,_7871,_7905),
    {user:_7699=<5},
    look_ahead(w(prep(_7744)),_7930,_7905,_7947),
    lock(exact,_7947,_7979),pushstack(exact,w(noun(bus,plu,def,n)),nil,_7979,_7985),busnumber(_7703,_7701,_7959,_7985,_7974),unlock(_7974,_7975),
    traceprint(4,bh04,_8015,_7975,_7791),
    !.

bus_head(_7698,1,_7700,_7701,_7702,_7703,[bus_head,_7798,_7832,_7866,_7895,_7919,_7953,_7997],_7769,_7771) --> 
    traceprint(5,bx05,_7798,_7769,_7817),
    art0(_7698,_7730,_7832,_7817,_7851),
    flnp(_7700,_7866,_7851,_7883),
    nr1(_7895,_7883,_7910),
    busnumber(_7703,_7702,_7919,_7910,_7938),
    busse0(_7702,_7701,_7739,_7740,_7953,_7938,_7976),
    traceprint(4,bh05,_7997,_7976,_7771).

bus_head(_7698,_7699,nil,_7701,_7702,_7703,[bus_head,_7798,_7832,_7866,_7895,_7919,_7953,_7997],_7769,_7771) --> 
    traceprint(5,bx06,_7798,_7769,_7817),
    art0(_7698,_7730,_7832,_7817,_7851),
    quant(_7699,_7866,_7851,_7883),
    nr1(_7895,_7883,_7910),
    busnumber(_7703,_7702,_7919,_7910,_7938),
    busse0(_7702,_7701,_7739,_7740,_7953,_7938,_7976),
    traceprint(4,bh06,_7997,_7976,_7771).

bus_head(_7698,_7699,nil,_7701,_7702,_7703,[bus_head,_7797,_7831,_7865,_7894,_7933,_7957,_7991],_7768,_7770) --> 
    traceprint(5,bx07,_7797,_7768,_7816),
    art0(_7698,_7730,_7831,_7816,_7850),
    quant(_7699,_7865,_7850,_7882),
    busnoun(_7701,_7735,_7736,_7894,_7882,_7915),
    nr0(_7933,_7915,_7948),
    busnumber(_7703,_7702,_7957,_7948,_7976),
    traceprint(4,bh07,_7991,_7976,_7770).

bus_head(_7698,_7699,nil,_7701,_7702,_7703,[bus_head,_7794,_7828,_7862,_7891,_7925,_7964],_7765,_7767) --> 
    traceprint(5,bx08,_7794,_7765,_7813),
    art0(_7698,_7727,_7828,_7813,_7847),
    quant(_7699,_7862,_7847,_7879),
    busnumber(_7703,_7702,_7891,_7879,_7910),
    busnoun(_7701,_7735,_7736,_7925,_7910,_7946),
    traceprint(4,bh08,_7964,_7946,_7767).

bus_head(_7698,1,_7700,_7701,_7702,_7703,[bus_head,_7797,_7831,_7865,_7894,_7918,_7952,_7991],_7768,_7770) --> 
    traceprint(5,bx09,_7797,_7768,_7816),
    art0(_7698,_7730,_7831,_7816,_7850),
    filanepr(_7700,_7865,_7850,_7882),
    nr1(_7894,_7882,_7909),
    busnumber(_7703,_7702,_7918,_7909,_7937),
    busnoun(_7701,_7738,_7739,_7952,_7937,_7973),
    traceprint(4,bh09,_7991,_7973,_7770).

bus_head(_7698,1,_7700,route,_7702,_7703,[bus_head,_7798,_7832,{},_7876,_7905,_7929,_7963],_7769,_7771) --> 
    traceprint(5,bx10,_7798,_7769,_7817),
    art0(_7698,_7730,_7832,_7817,_7851),
    {user:_7730\==plu},
    filanepr(_7700,_7876,_7851,_7893),
    nr1(_7905,_7893,_7920),
    busnumber(_7703,_7702,_7929,_7920,_7948),
    traceprint(4,bh10,_7963,_7948,_7771).

bus_head(_7698,1,_7700,_7701,_7702,_7703,[bus_head,_7820,_7854,{},_7898,_7927,_7966,_7990,_8014,_8048,_8077],_7791,_7793) --> 
    traceprint(5,bx11,_7820,_7791,_7839),
    art0(_7698,_7739,_7854,_7839,_7873),
    {user:_7739\==plu},
    filanepr(_7700,_7898,_7873,_7915),
    busnoun(_7701,_7749,_7750,_7927,_7915,_7948),
    nr0(_7966,_7948,_7981),
    colon0(_7990,_7981,_8005),
    busnumber(_7703,_7702,_8014,_8005,_8033),
    not_look_ahead(w(noun(minute,_7760,_7761,_7762)),_8048,_8033,_8065),
    traceprint(4,bh11,_8077,_8065,_7793).

bus_head(_7698,_7699,_7700,_7701,_7702,_7703,[bus_head,_7803,_7837,_7871,{},_7915,_7954,_7988],_7774,_7776) --> 
    traceprint(5,bx12,_7803,_7774,_7822),
    art0(_7698,_7730,_7837,_7822,_7856),
    quantnext(_7699,_7700,_7871,_7856,_7890),
    {user:_7699<10},
    busnoun(_7701,_7741,plu,_7915,_7890,_7936),
    busnumber(_7703,_7702,_7954,_7936,_7973),
    traceprint(4,bh12,_7988,_7973,_7776).

bus_head(_7698,_7699,_7700,_7701,nil,_7703,[bus_head,_7797,_7831,_7865,{},_7909,_7948],_7768,_7770) --> 
    traceprint(5,bx13,_7797,_7768,_7816),
    art0(_7698,plu,_7831,_7816,_7850),
    quantnext(_7699,_7700,_7865,_7850,_7884),
    {user:_7699<100},
    busnoun(_7701,_7738,_7739,_7909,_7884,_7930),
    traceprint(4,bh13,_7948,_7930,_7770).

bus_head(_7698,_7699,_7700,_7701,nil,_7703,[bus_head,_7797,_7831,_7865,{},_7909,_7948],_7768,_7770) --> 
    traceprint(5,bx14,_7797,_7768,_7816),
    art0(_7698,_7727,_7831,_7816,_7850),
    quantnext(_7699,_7700,_7865,_7850,_7884),
    {user:_7699=<5},
    busnoun(_7701,_7738,plu,_7909,_7884,_7930),
    traceprint(4,bh14,_7948,_7930,_7770).

bus_head(_7698,1,_7700,_7701,_7702,_7703,[bus_head,_7807,_7841,_7875,_7904,{},_7948,_7987],_7778,_7780) --> 
    traceprint(5,bx15,_7807,_7778,_7826),
    art0(_7698,_7730,_7841,_7826,_7860),
    filanepr(_7700,_7875,_7860,_7892),
    busnumber(_7703,_7702,_7904,_7892,_7923),
    {user:(number(_7703),_7703>5)},
    busnoun(_7701,_7748,_7749,_7948,_7923,_7969),
    traceprint(4,bh15,_7987,_7969,_7780).

bus_head(_7698,1,_7700,_7701,_7702,_7703,[bus_head,_7802,_7836,_7870,_7899,{},_7943,_7982],_7773,_7775) --> 
    traceprint(5,bx16,_7802,_7773,_7821),
    art0(_7698,_7730,_7836,_7821,_7855),
    filanepr(_7700,_7870,_7855,_7887),
    busnumber(_7703,_7702,_7899,_7887,_7918),
    {user:_7703\==1},
    busnoun(_7701,_7743,sin,_7943,_7918,_7964),
    traceprint(4,bh16,_7982,_7964,_7775).

bus_head(u,1,nil,bus,number,_7703,[bus_head,_7815,_7849,_7878,{},_7917,_7956],_7786,_7788) --> 
    traceprint(5,bx17,_7815,_7786,_7834),
    not_look_ahead(w(name(_7730,n,route)),_7849,_7834,_7866),
    w(nb(_7703,num),_7878,_7866,_7895),
    {user:(number(_7703),_7703>5,_7703=<9999)},
    busnoun(bus,def,sin,_7917,_7895,_7938),
    traceprint(4,bh17,_7956,_7938,_7788).

bus_head(def,_7699,_7700,route,nil,_7703,[bus_head,_7792,lit(de),_7837,{},_7881,_7905],_7763,_7765) --> 
    traceprint(5,bx18,_7792,_7763,_7811),
    cc(de,_7811,_7836),
    quantnext(_7699,_7700,_7837,_7836,_7856),
    {user:_7699=<5},
    not_look_ahead_np(_7881,_7856,_7896),
    traceprint(4,bh18,_7905,_7896,_7765).

bus_head(_7698,_7699,_7700,route,nil,_7703,[bus_head,_7810,_7844,_7878,{},{},_7932,_7956,!],_7781,_7783) --> 
    traceprint(5,bx19,_7810,_7781,_7829),
    art0(_7698,_7730,_7844,_7829,_7863),
    quantnext(_7699,_7700,_7878,_7863,_7897),
    {user:_7700\==nil},
    {user:(_7699>0,_7699=<5)},
    not_look_ahead_np(_7932,_7897,_7947),
    traceprint(4,bh19,_7956,_7947,_7783),
    !.

bus_head(_7698,1,_7700,_7701,_7702,_7703,[bus_head,_7812,_7846,_7880,_7909,_7948,_7972,_7996,_8030,_8059],_7783,_7785) --> 
    traceprint(5,bx20,_7812,_7783,_7831),
    art0(_7698,_7736,_7846,_7831,_7865),
    filanepr(_7700,_7880,_7865,_7897),
    busnoun(_7701,_7741,sin,_7909,_7897,_7930),
    nr0(_7948,_7930,_7963),
    colon0(_7972,_7963,_7987),
    busnumber(_7703,_7702,_7996,_7987,_8015),
    not_look_ahead(w(noun(minute,_7752,_7753,_7754)),_8030,_8015,_8047),
    traceprint(4,bh20,_8059,_8047,_7785).

art0(u,plu,[art0,lit(noen),_7756,!],_7728,_7730) --> 
    cc(noen,_7728,_7755),
    look_ahead_np(_7756,_7755,_7730),
    !.

art0(u,sin,[art0,lit(noe),!],_7725,_7727) --> 
    cc(noe,_7725,_7727),
    !.

art0(_7698,_7699,[art0,_7743,!],_7726,_7728) --> 
    art(_7698,_7699,_7743,_7726,_7728),
    !.

art0(u,nil,[art0,[]],_7720,_7720) --> 
    [].

art(u,sin,[art,lit(en),!],_7725,_7727) --> 
    cc(en,_7725,_7727),
    !.

art(u,sin,[art,lit(et),!],_7725,_7727) --> 
    cc(et,_7725,_7727),
    !.

art(u,sin,[art,lit(ei),!],_7725,_7727) --> 
    cc(ei,_7725,_7727),
    !.

art(def,sin,[art,lit(den),!],_7725,_7727) --> 
    cc(den,_7725,_7727),
    !.

art(def,plu,[art,lit(det),!],_7725,_7727) --> 
    cc(det,_7725,_7727),
    !.

art(def,plu,[art,lit(de),!],_7725,_7727) --> 
    cc(de,_7725,_7727),
    !.

quantnext(_7698,_7699,[quantnext,_7747,_7776,!],_7730,_7732) --> 
    quant(_7698,_7747,_7730,_7764),
    filanepr(_7699,_7776,_7764,_7732),
    !.

quantnext(_7698,_7699,[quantnext,_7747,_7776,!],_7730,_7732) --> 
    filanepr(_7699,_7747,_7730,_7764),
    quant(_7698,_7776,_7764,_7732),
    !.

quant00(1,[quant00,[]],_7717,_7717) --> 
    [].

quant(_7698,[quant,_7736],_7722,_7724) --> 
    w(nb(_7698,num),_7736,_7722,_7724).

filanepr(_7698,[filanepr,_7736,!],_7722,_7724) --> 
    flnp(_7698,_7736,_7722,_7724),
    !.

filanepr(nil,[filanepr,[]],_7717,_7717) --> 
    [].

busseno(_7698,_7699,_7700,[busseno,_7762,_7801,_7825,_7849,!],_7742,_7744) --> 
    busnoun(_7699,_7715,_7716,_7762,_7742,_7783),
    nr0(_7801,_7783,_7816),
    colon0(_7825,_7816,_7840),
    busnumber(_7698,_7700,_7849,_7840,_7744),
    !.

busseno(_7698,_7699,_7700,[busseno,_7759,_7783,_7817,!],_7739,_7741) --> 
    nr0(_7759,_7739,_7774),
    busnumber(_7698,_7700,_7783,_7774,_7802),
    busnoun(_7699,_7715,_7716,_7817,_7802,_7741),
    !.

busnumber(_7698,_7699,[busnumber,_7853,_7897,{},_7936,_7965,_7994,_8018,_8047,_8076,_8105,_8134,_8163],_7836,_7838) --> 
    optional(w(noun(route,sin,u,n)),_7853,_7836,_7885),
    w(name(_7698,n,_7699),_7897,_7885,_7914),
    {user:test(subclass0(_7699,vehicle))},
    not_look_ahead(w(noun(minute,_7769,_7770,_7771)),_7936,_7914,_7953),
    not_look_ahead([:],_7965,_7953,_7982),
    point0(_7994,_7982,_8009),
    not_look_ahead(w(name(_7781,_7782,month)),_8018,_8009,_8035),
    not_look_ahead(w(name(_7781,_7790,day)),_8047,_8035,_8064),
    not_look_ahead(w(name(whitsun_day,_7798,date)),_8076,_8064,_8093),
    not_look_ahead(w(name(christmas_day,_7806,date)),_8105,_8093,_8122),
    not_look_ahead(w(name(easterday,_7814,date)),_8134,_8122,_8151),
    not_look_ahead(w(name(new_years_day,_7739,date)),_8163,_8151,_7838).

busnumber(_7698,number,[busnumber,_7842,_7886,_7915,_7944,_7973,_7997,_8026,_8055,_8084,_8113,_8142],_7825,_7827) --> 
    optional(w(noun(route,sin,u,n)),_7842,_7825,_7874),
    w(nb(_7698,num),_7886,_7874,_7903),
    not_look_ahead(w(noun(minute,_7758,_7759,_7760)),_7915,_7903,_7932),
    not_look_ahead([:],_7944,_7932,_7961),
    point0(_7973,_7961,_7988),
    not_look_ahead(w(name(_7770,_7771,month)),_7997,_7988,_8014),
    not_look_ahead(w(name(_7770,_7779,day)),_8026,_8014,_8043),
    not_look_ahead(w(name(whitsun_day,_7787,date)),_8055,_8043,_8072),
    not_look_ahead(w(name(christmas_day,_7795,date)),_8084,_8072,_8101),
    not_look_ahead(w(name(easterday,_7803,date)),_8113,_8101,_8130),
    not_look_ahead(w(name(new_years_day,_7736,date)),_8142,_8130,_7827).

busse0(_7698,_7699,_7700,_7701,[busse0,_7756,!],_7733,_7735) --> 
    busnoun(_7699,_7700,_7701,_7756,_7733,_7735),
    !.

busse0(_7698,_7698,u,sin,[busse0,[]],_7726,_7726) --> 
    [].

busnoun(_7698,_7699,_7700,[busnoun,_7772,!,{},_7816],_7752,_7754) --> 
    w(noun(_7698,_7700,_7699,n),_7772,_7752,_7789),
    !,
    {user:(test(subclass0(_7698,vehicle));_7698=number)},
    point0(_7816,_7789,_7754).

aname_phrase(0,_7699,_7702::_7702 and _7706,[aname_phrase,_7787,_7811,_7840,_7869,{},!],_7767,_7769) --> 
    a0(_7787,_7767,_7802),
    look_ahead(w(name(_7727,n,_7729)),_7811,_7802,_7828),
    preadjs(_7731,_7840,_7828,_7857),
    noun2(_7733,_7734,n,_7699,_7737,_7869,_7857,_7769),
    {user:preadjs_template(_7731,_7699,_7737,_7706)},
    !.

aname_phrase(_7698,_7699,_7702::_7702 and _7706,[aname_phrase,_7790,_7819,lit(gang),!,_7864,_7888],_7770,_7772) --> 
    w(name(_7728,n,route),_7790,_7770,_7807),
    w(adj2(next,nil),_7819,_7807,_7836),
    cc(gang,_7836,_7858),
    !,
    accept(_7864,_7858,_7879),
    pushstack(first,w(name(_7728,n,route)),nil,_7879,_7898),
    namep(_7698,_7699,_7706,_7888,_7898,_7772).

aname_phrase(_7698,_7699,_7700,[aname_phrase,_7763,_7792,_7821,!,_7850],_7743,_7745) --> 
    number(_7714,_7763,_7743,_7780),
    not_look_ahead(w(prep(from)),_7792,_7780,_7809),
    filanepr(_7821,_7809,_7836),
    !,
    reject(_7850,_7836,_7745).

aname_phrase(_7698,_7699,_7700,[aname_phrase,_7777,_7801,_7825,_7854,{},!,_7898],_7757,_7759) --> 
    dent0(_7777,_7757,_7792),
    filanepr(_7801,_7792,_7816),
    bus_number(_7720,_7825,_7816,_7842),
    w(noun(_7724,plu,_7726,_7727),_7854,_7842,_7871),
    {user:testmember(_7724,[bus])},
    !,
    reject(_7898,_7871,_7759).

aname_phrase(_7698,_7699,_7700,[aname_phrase,_7783,_7807,_7836,_7870,{},!,_7914],_7763,_7765) --> 
    dent0(_7783,_7763,_7798),
    w(adj2(_7722,nil),_7807,_7798,_7824),
    gmem(_7722,[nearest],_7836,_7824,_7855),
    w(name(_7732,_7733,_7734),_7870,_7855,_7887),
    {user:(\+number(_7732))},
    !,
    reject(_7914,_7887,_7765).

aname_phrase(_7698,_7699,_7702::_7703,[aname_phrase,_7785,_7809,_7838,_7867,_7896,{}],_7765,_7767) --> 
    a0(_7785,_7765,_7800),
    preadjs0(_7722,_7809,_7800,_7826),
    not_look_ahead([jeg],_7838,_7826,_7855),
    not_look_ahead([du],_7867,_7855,_7884),
    name_phrase(_7698,_7699,_7702::_7724,_7896,_7884,_7767),
    {user:preadjs_template(_7722,_7699,_7724,_7703)}.

aname_phrase(_7698,_7699,_7702::_7703,[aname_phrase,_7763,_7792,_7816],_7743,_7745) --> 
    not_look_ahead([ett],_7763,_7743,_7780),
    a0(_7792,_7780,_7807),
    name_phrase(_7698,_7699,_7702::_7703,_7816,_7807,_7745).

aname_phrase(name,_7699,_7700,[aname_phrase,_7747],_7727,_7729) --> 
    person_name(_7699,_7700,_7704,_7747,_7727,_7729).

name_phrase(0,_7699,_7702::_7703,[name_phrase,_7841,_7870,_7899,_7928,_7952,_7981,!,{},{},_8035],_7821,_7823) --> 
    w(noun(time,sin,def,n),_7841,_7821,_7858),
    w(nb(_7752,num),_7870,_7858,_7887),
    w(nb(_7757,num),_7899,_7887,_7916),
    to0(_7928,_7916,_7943),
    w(nb(_7762,num),_7952,_7943,_7969),
    w(nb(_7767,num),_7981,_7969,_7998),
    !,
    {user:_7772 is _7752*100+_7757},
    {user:_7741 is _7762*100+_7767},
    lock(exact,_7998,_8148),
    pushstack(exact,(time1(_7772),and1,time1(_7741)),nil,_8148,_8154),
    noun_phrases(_7699,_7702::_7703,_8035,_8154,_8143),
    unlock(_8143,_7823).

name_phrase(0,_7699,_7702::_7703,[name_phrase,_7791,_7820,_7849,_7873,!,_7907],_7771,_7773) --> 
    w(noun(time,sin,def,n),_7791,_7771,_7808),
    timexp(_7738,_7820,_7808,_7837),
    to0(_7849,_7837,_7864),
    timexp(_7729,_7873,_7864,_7890),
    !,
    pushstack(first,(time1(_7738),and1,time1(_7729)),nil,_7890,_8005),
    noun_phrases(_7699,_7702::_7703,_7907,_8005,_7773).

name_phrase(_7698,_7699,_7702::_7705 and _7702,[name_phrase,_7775,_7804,_7843],_7755,_7757) --> 
    look_ahead(w(nb(_7727,_7728)),_7775,_7755,_7792),
    namep(_7698,_7699,_7705,_7804,_7792,_7825),
    not_look_ahead(w(noun(minute,_7719,_7720,_7721)),_7843,_7825,_7757).

name_phrase(_7698,_7699,_7702::_7705 and _7702,[name_phrase,_7775,_7804,_7843],_7755,_7757) --> 
    look_ahead(w(nb(_7727,_7728)),_7775,_7755,_7792),
    namep(_7698,_7699,_7705,_7804,_7792,_7825),
    not_look_ahead(w(noun(minute,_7719,_7720,_7721)),_7843,_7825,_7757).

name_phrase(_7698,_7699,_7702::_7705 and _7702,[name_phrase,_7753],_7733,_7735) --> 
    namep(_7698,_7699,_7705,_7753,_7733,_7735).

person_name((_7705,_7708,_7709):person,_7711 and _7714 and _7715,_7700,[person_name,_7782,_7821,_7860,!,_7904],_7762,_7764) --> 
    properfirstname(_7705,_7711,_7731,_7782,_7762,_7803),
    properfirstname(_7708,_7714,_7735,_7821,_7803,_7842),
    properlastname(_7709,_7715,_7700,_7860,_7842,_7881),
    !,
    accept(_7904,_7881,_7764).

person_name((_7705,_7706):person,_7708 and _7709,_7700,[person_name,_7769,_7808,!,_7852],_7749,_7751) --> 
    properfirstname(_7705,_7708,_7722,_7769,_7749,_7790),
    properlastname(_7706,_7709,_7700,_7808,_7790,_7829),
    !,
    accept(_7852,_7829,_7751).

properfirstname(_7698,_7699,_7700,[properfirstname,_7750],_7730,_7732) --> 
    name1g(_7698:firstname,_7699,_7700,_7750,_7730,_7732).

properlastname(_7698,_7699,_7700,[properlastname,_7750],_7730,_7732) --> 
    name1g(_7698:lastname,_7699,_7700,_7750,_7730,_7732).

np_head(_7698,_7699,_7700,[np_head,lit(ett),_7772,!,_7806],_7741,_7743) --> 
    cc(ett,_7741,_7771),
    w(noun(time,_7716,def,_7718),_7772,_7771,_7789),
    !,
    reject(_7806,_7789,_7743).

np_head(0,_7699,_7702::_7703,[np_head,_7799,_7823,_7852,!,_7896,_7925,{},{}],_7779,_7781) --> 
    the0(_7799,_7779,_7814),
    preadjs0(_7733,_7823,_7814,_7840),
    quantifier(_7699,_7731,_7731 and _7702::_7703,_7852,_7840,_7873),
    !,
    preadjs0(_7728,_7896,_7873,_7913),
    noun_complex(_7747,_7699,_7749,_7925,_7913,_7781),
    {user:preadjs_template(_7733,_7699,_7749,_7730)},
    {user:preadjs_template(_7728,_7699,_7730,_7731)}.

np_head(_7698,_7699,_7700,[np_head,_7803,_7852,{},_7891,_7920,{}],_7783,_7785) --> 
    determiner0(_7724,_7698,_7699,_7722,_7700,_7803,_7783,_7828),
    preadjs0(_7719,_7852,_7828,_7869),
    {user:(_7719=true->_7737=_7724;_7737=_7738)},
    not_look_ahead(w(noun(crown,_7754,_7755,_7756)),_7891,_7869,_7908),
    noun_complex(_7737,_7699,_7721,_7920,_7908,_7785),
    {user:preadjs_template(_7719,_7699,_7721,_7722)}.

np_head(0,_7699,_7702::findpron(_7717)::exists(_7699)::_7711 and _7714 and _7702,[np_head,_7803,_7827,_7881,!,_7915,{}],_7783,_7785) --> 
    thispron(_7803,_7783,_7818),
    noun(_7742,_7743,_7744,gen,_7717,_7714,_7827,_7818,_7854),
    look_ahead(w(nb(_7753,num)),_7881,_7854,_7898),
    !,
    np0_accept(_7699,_7740::_7711,_7915,_7898,_7785),
    {user:has_template(_7717,_7699,_7740)}.

np_head(0,_7699,_7702::findpron(_7723)::exists(_7699)::_7711 and _7714 and _7717 and _7720 and _7702,[np_head,_7815,_7839,!,_7898,_7927,_7966,{},{}],_7795,_7797) --> 
    thispron(_7815,_7795,_7830),
    noun(_7754,_7755,_7756,gen,_7723,_7717,_7839,_7830,_7866),
    !,
    preadjs0(_7761,_7898,_7866,_7915),
    noun_compound(_7699,_7714,_7765,_7927,_7915,_7948),
    not_look_aheadnounx(_7966,_7948,_7797),
    {user:preadjs_template(_7761,_7699,_7714,_7711)},
    {user:has_template(_7723,_7699,_7720)}.

not_look_aheadnounx([not_look_aheadnounx,_7735,!],_7724,_7726) --> 
    look_ahead(w(verb(_7705,_7706,fin)),_7735,_7724,_7726),
    !.

not_look_aheadnounx([not_look_aheadnounx,_7736,!],_7725,_7727) --> 
    look_ahead(w(noun(clock,_7706,_7707,_7708)),_7736,_7725,_7727),
    !.

not_look_aheadnounx([not_look_aheadnounx,_7733],_7722,_7724) --> 
    not_look_ahead(w(noun(_7702,_7703,_7704,_7705)),_7733,_7722,_7724).

noun_complex(_7698,_7702:_7703,_7702 isa _7703,[noun_complex,_7798,_7827,_7856,_7885,{},!],_7778,_7780) --> 
    not_look_ahead(w(nb(_7727,_7728)),_7798,_7778,_7815),
    w(name(_7702,n,_7734),_7827,_7815,_7844),
    not_look_ahead(w(verb(_7740,pres,fin)),_7856,_7844,_7873),
    w(noun(_7746,_7698,_7748,n),_7885,_7873,_7780),
    {user:joinclass(_7746,_7734,_7703)},
    !.

noun_complex(sin,_7702:_7703,_7702 isa _7703,[noun_complex,_7766,_7795,!],_7746,_7748) --> 
    w(noun(_7703,sin,_7718,n),_7766,_7746,_7783),
    w(quote(_7702),_7795,_7783,_7748),
    !.

noun_complex(sin,_7702:_7706,_7702 isa _7703,[noun_complex,_7816,_7845,_7874,_7903,_7932,_7956,{},!],_7796,_7798) --> 
    w(noun(_7703,sin,_7733,n),_7816,_7796,_7833),
    not_look_ahead([du],_7845,_7833,_7862),
    w(name(_7702,n,_7744),_7874,_7862,_7891),
    not_look_ahead(w(noun(minute,_7751,_7752,_7753)),_7903,_7891,_7920),
    point0(_7932,_7920,_7947),
    not_look_ahead(w(name(_7759,_7760,date)),_7956,_7947,_7798),
    {user:(joinclass(_7703,_7744,_7706),_7706\==nil)},
    !.

noun_complex(sin,_7702:_7703,_7702 isa _7703,[noun_complex,_7798,_7827,{},_7866,_7890,!],_7778,_7780) --> 
    w(noun(_7703,_7726,_7727,n),_7798,_7778,_7815),
    w(nb(_7702,num),_7827,_7815,_7844),
    {user:testmember(_7703,[footnote,page,sms,telephone,week,year])},
    and1(_7866,_7844,_7881),
    w(nb(_7754,_7755),_7890,_7881,_7780),
    !.

noun_complex(_7698,_7702:_7703,_7702 isa _7703,[noun_complex,_7789,_7818,{},!],_7769,_7771) --> 
    w(noun(_7703,_7698,_7721,n),_7789,_7769,_7806),
    w(nb(_7702,num),_7818,_7806,_7771),
    {user:testmember(_7703,[footnote,page,sms,telephone,week,year,number])},
    !.

noun_complex(_7698,_7702:_7703,_7702 isa _7703,[noun_complex,_7834,{},_7873,_7907,_7936,_7970,_7999,_8028,_8057,!,_8091],_7814,_7816) --> 
    w(noun(_7703,_7698,_7742,n),_7834,_7814,_7851),
    {user:subtype0(_7703,vehicle)},
    plausibleno(_7703,_7702,_7873,_7851,_7892),
    not_look_ahead([ganger],_7907,_7892,_7924),
    plausibleno(_7703,_7702,_7936,_7924,_7955),
    not_look_ahead_lit([sin,sitt,sine],_7970,_7955,_7987),
    not_look_ahead(w(name(_7772,_7773,month)),_7999,_7987,_8016),
    not_look_ahead(w(name(_7772,_7781,date)),_8028,_8016,_8045),
    not_look_ahead(w(noun(_7788,plu,_7790,_7791)),_8057,_8045,_8074),
    !,
    accept(_8091,_8074,_7816).

noun_complex(plu,_7702:_7703,_7702 isa _7703,[noun_complex,_7770,_7804,{}],_7750,_7752) --> 
    plausibleno(_7703,_7702,_7770,_7750,_7789),
    w(noun(_7703,sin,u,n),_7804,_7789,_7752),
    {user:subtype0(_7703,vehicle)}.

noun_complex(_7698,_7699,_7700,[noun_complex,_7768,_7807,_7836],_7748,_7750) --> 
    noun_list(_7698,_7699,_7700,_7768,_7748,_7789),
    not_look_ahead_lit([sin,sitt,sine],_7807,_7789,_7824),
    not_look_ahead(w(nb(_7712,_7713)),_7836,_7824,_7750).

noun_complex(_7698,_7699,_7700,[noun_complex,_7761,_7790,_7819],_7741,_7743) --> 
    not_look_ahead([noe],_7761,_7741,_7778),
    not_look_ahead([min],_7790,_7778,_7807),
    noun_compound(_7699,_7700,_7698,_7819,_7807,_7743).

plausibleno(_7698,_7699,[plausibleno,_7751,_7780,_7804,!,_7833],_7734,_7736) --> 
    num(_7713,_7751,_7734,_7768),
    point(_7780,_7768,_7795),
    monthnamex(_7804,_7795,_7819),
    !,
    reject(_7833,_7819,_7736).

plausibleno(_7698,_7699,[plausibleno,_7748,_7777,!,_7806],_7731,_7733) --> 
    num(_7710,_7748,_7731,_7765),
    colon(_7777,_7765,_7792),
    !,
    reject(_7806,_7792,_7733).

plausibleno(_7698,_7699,[plausibleno,_7750,_7779,!,_7813],_7733,_7735) --> 
    num(_7710,_7750,_7733,_7767),
    monthname(_7712,_7779,_7767,_7796),
    !,
    reject(_7813,_7796,_7735).

plausibleno(_7698,_7699,[plausibleno,_7756,_7780,{}],_7739,_7741) --> 
    nr0(_7756,_7739,_7771),
    num(_7699,_7780,_7771,_7741),
    {user:(_7699>0,_7699<1000)}.

plausibleno(_7698,_7699,[plausibleno,_7753,_7777,{}],_7736,_7738) --> 
    nr0(_7753,_7736,_7768),
    w(nb(_7699,alf),_7777,_7768,_7738),
    {user:_7699<1000}.

npa(_7710:_7711,_7701::findexternal(_7710:_7711)::_7710 isa _7711 and _7701,[npa,_7783,_7812,!,{}],_7766,_7768) --> 
    one_of_lit([det,dette],_7783,_7766,_7800),
    look_ahead(w(adv(_7745)),_7812,_7800,_7768),
    !,
    {user:_7711=thing}.

npa(_7710:_7711,_7701::findexternal(_7710:_7711)::_7710 isa _7711 and _7701,[npa,lit(dette),_7781,{}],_7753,_7755) --> 
    cc(dette,_7753,_7780),
    not_look_ahead_np(_7781,_7780,_7755),
    {user:_7711=thing}.

npa(_7710:_7711,_7701::findexternal(_7710:thing)::_7710 isa _7711 and _7701,[npa,lit(det),_7784,_7813],_7756,_7758) --> 
    cc(det,_7756,_7783),
    look_ahead(w(verb(_7733,_7734,fin)),_7784,_7783,_7801),
    not_look_ahead_np(_7813,_7801,_7758).

npa(_7698,_7701::findit(_7707)::_7705,[npa,_7774,_7798,_7837,{}],_7757,_7759) --> 
    its(_7774,_7757,_7789),
    determiner00(_7698,_7731 and _7722,_7701::_7705,_7798,_7789,_7819),
    noun_compound(_7698,_7731,_7736,_7837,_7819,_7759),
    {user:has_template(_7707,_7698,_7722)}.

npa(_7698,_7699,[npa,_7746,_7770,!,_7799],_7729,_7731) --> 
    this(_7746,_7729,_7761),
    look_ahead_np(_7770,_7761,_7785),
    !,
    reject(_7799,_7785,_7731).

npa(_7698,_7701::find(_7698)::_7707 and _7701,[npa,_7755],_7738,_7740) --> 
    noun(_7712,_7713,def,n,_7698,_7707,_7755,_7738,_7740).

npa(_7710:_7711,_7701::findexternal(_7710:_7711)::_7710 isa _7719 and _7701,[npa,lit(denne),_7805,_7834,{},{}],_7777,_7779) --> 
    cc(denne,_7777,_7804),
    not_look_ahead(w(adj),_7805,_7804,_7822),
    not_look_ahead(w(noun(_7748,_7749,_7750,_7751)),_7834,_7822,_7779),
    {user:_7719=thing},
    {user:type(_7719,_7711)}.

npa(_7710:_7711,_7701::findpron(_7710:_7711)::_7710 isa thing and _7701,[npa,lit(det),_7781,{}],_7753,_7755) --> 
    cc(det,_7753,_7780),
    endofline(_7781,_7780,_7755),
    {user:type(thing,_7711)}.

npa(_7698,_7701::_7702,[npa,_7783,_7807,_7836,_7865],_7766,_7768) --> 
    allsome0(_7783,_7766,_7798),
    posspron(_7727,_7807,_7798,_7824),
    w(nb(_7724,num),_7836,_7824,_7853),
    pushstack(first,(thispron,w(noun(_7727,sin,u,gen)),w(nb(_7724,num))),nil,_7853,_7906),
    np1(_7698,_7701::_7702,_7865,_7906,_7768).

npa(_7698,_7701::_7702,[npa,_7767,_7791,_7820],_7750,_7752) --> 
    allsome0(_7767,_7750,_7782),
    posspron(_7718,_7791,_7782,_7808),
    pushstack(first,(thispron,w(noun(_7718,sin,u,gen))),nil,_7808,_7858),
    np1(_7698,_7701::_7702,_7820,_7858,_7752).

npa(_7698,_7699,[npa,lit(de),_7821,_7850,_7879,_7908,!,_7942],_7793,_7795) --> 
    cc(de,_7793,_7820),
    w(nb(_7739,num),_7821,_7820,_7838),
    flnp(_7742,_7850,_7838,_7867),
    not_look_ahead(w(name(_7748,_7749,_7750)),_7879,_7867,_7896),
    not_look_ahead(w(noun(_7756,_7757,_7758,_7759)),_7908,_7896,_7925),
    !,
    pushstack(first,(w(nb(_7739,num)),w(adj2(_7742,nil)),w(noun(vehicle,sin,u,n))),nil,_7925,_7952),
    np1(_7698,_7699,_7942,_7952,_7795).

npa(_7698,_7701::_7702,[npa,_7826,_7850,_7879,_7908,_7937,_7966,_7990,_8019,!,_8053],_7809,_7811) --> 
    dent0(_7826,_7809,_7841),
    not_look_ahead([først],_7850,_7841,_7867),
    not_look_ahead([sist],_7879,_7867,_7896),
    not_look_ahead([senest],_7908,_7896,_7925),
    not_look_ahead([tidligst],_7937,_7925,_7954),
    nest(_7966,_7954,_7981),
    flnp(_7763,_7990,_7981,_8007),
    not_look_ahead(w(noun(_7769,_7770,_7771,_7772)),_8019,_8007,_8036),
    !,
    pushstack(first,(w(adj2(second,nil)),w(adj2(_7763,nil)),w(noun(vehicle,sin,u,n))),nil,_8036,_8063),
    np1(_7698,_7701::_7702,_8053,_8063,_7811).

npa(_7698,_7701::_7702,[npa,_7830,_7854,_7883,_7912,_7941,!,_7975,_8046],_7813,_7815) --> 
    dent0(_7830,_7813,_7845),
    not_look_ahead([f,s,først,sist,senest,tidligst],_7854,_7845,_7871),
    flnp(_7748,_7883,_7871,_7900),
    not_look_ahead(w(name(_7754,_7755,_7756)),_7912,_7900,_7929),
    not_look_ahead(w(noun(_7762,_7763,_7764,_7765)),_7941,_7929,_7958),
    !,
    pushstack(first,(a,w(adj2(_7748,nil)),w(noun(vehicle,sin,u,n))),nil,_7958,_8016),np1(_7698,_7701::_7702,_7975,_8016,_8031),
    optional(w(noun(bus,sin,_7731,_7732)),_8046,_8031,_7815).

npa(_7698,_7699,[npa,{},lit(den),_7799,_7828,!,_7862],_7761,_7763) --> 
    {user:value(busflag,true)},
    cc(den,_7761,_7798),
    not_look_ahead(w(adj2(_7730,nil)),_7799,_7798,_7816),
    not_look_ahead(w(noun(_7737,_7738,_7739,_7740)),_7828,_7816,_7845),
    !,
    npit(_7698,_7699,_7862,_7845,_7763).

npa(_7698,_7701::_7702,[npa,lit(den),_7800,_7829,!,_7863],_7772,_7774) --> 
    cc(den,_7772,_7799),
    not_look_ahead(w(adj2(_7735,nil)),_7800,_7799,_7817),
    not_look_ahead(w(noun(_7742,_7743,_7744,_7745)),_7829,_7817,_7846),
    !,
    lock(exact,_7846,_7908),
    pushstack(exact,(this,w(noun(thing,sin,u,n))),nil,_7908,_7914),
    np1(_7698,_7701::_7702,_7863,_7914,_7903),
    unlock(_7903,_7774).

npit(_7707:_7708,_7701::_7707 isa _7708 and _7701,[npit,{}],_7739,_7739) --> 
    {user:it_template(_7707:_7708)}.

adjnoun([adjnoun,_7729],_7718,_7720) --> 
    w(adj2(nil,nil),_7729,_7718,_7720).

adjnoun([adjnoun,_7731],_7720,_7722) --> 
    w(noun(_7700,plu,u,_7703),_7731,_7720,_7722).

np2(_7698,_7699,[np2,lit(noe),_7789,_7818,!,_7847],_7761,_7763) --> 
    cc(noe,_7761,_7788),
    w(adj2(_7730,_7731),_7789,_7788,_7806),
    not_look_ahead_np(_7818,_7806,_7833),
    !,
    lock(exact,_7833,_7864),
    pushstack(exact,(w(adj2(_7730,_7731)),w(noun(thing,sin,u,n))),nil,_7864,_7870),
    np_kernel(0,_7698,_7699,_7847,_7870,_7859),
    unlock(_7859,_7763).

np2(_7698,_7699,[np2,lit(noe),_7787,!,_7821,_7882],_7759,_7761) --> 
    cc(noe,_7759,_7786),
    look_ahead(w(prep(_7724)),_7787,_7786,_7804),
    !,
    lock(exact,_7804,_7841),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7841,_7847),np_kernel(0,_7698,_7715,_7821,_7847,_7836),unlock(_7836,_7837),
    noun_modifiers0(0,_7698,_7715,_7699,_7882,_7837,_7761).

np2(_7698,_7699,[np2,_7809,_7843,{},!,_7887,!],_7792,_7794) --> 
    clock_kernel(_7719:clock,_7719 isa clock,_7809,_7792,_7828),
    w(noun(_7727,sin,_7729,n),_7843,_7828,_7860),
    {user:testmember(_7727,[departure,arrival])},
    !,
    lock(exact,_7860,_7940),pushstack(exact,(w(noun(_7727,sin,def,n)),w(prep(at)),clock_kernel(_7719:clock,_7719 isa clock)),nil,_7940,_7946),np1(_7698,_7699,_7887,_7946,_7935),unlock(_7935,_7794),
    !.

np2(_7698,_7699,[np2,_7796,_7820,lit(enn),!,_7865,!,_7904,!],_7779,_7781) --> 
    anders(_7796,_7779,_7811),
    w(noun(_7724,_7725,_7726,n),_7820,_7811,_7837),
    cc(enn,_7837,_7859),
    !,
    np1(_7731,_7732,_7865,_7859,_7884),
    !,
    lock(exact,_7884,_7955),pushstack(exact,(w(noun(_7724,_7725,_7726,n)),w(prep(except)),xnp(_7731,_7732)),nil,_7955,_7961),np1(_7698,_7699,_7904,_7961,_7950),unlock(_7950,_7781),
    !.

anders([anders,lit(andre),!],_7718,_7720) --> 
    cc(andre,_7718,_7720),
    !.

anders([anders,lit(en),lit(annen),!],_7723,_7725) --> 
    cc(en,_7723,_7744),
    cc(annen,_7744,_7725),
    !.

np2(_7698,_7699,[np2,lit(samme),_7809,lit(som),!,_7854,!,_7893,!],_7781,_7783) --> 
    cc(samme,_7781,_7808),
    w(noun(_7726,sin,u,n),_7809,_7808,_7826),
    cc(som,_7826,_7848),
    !,
    np1(_7733,_7734,_7854,_7848,_7873),
    !,
    lock(exact,_7873,_7944),pushstack(exact,(w(noun(_7726,sin,def,n)),w(prep(as)),xnp(_7733,_7734)),nil,_7944,_7950),np1(_7698,_7699,_7893,_7950,_7939),unlock(_7939,_7783),
    !.

np2(_7707:_7708,_7701::_7704 and _7701,[np2,_7815,_7844,_7878,{},{}],_7798,_7800) --> 
    w(name(_7741,n,_7743),_7815,_7798,_7832),
    gmem(_7743,[company],_7844,_7832,_7863),
    w(noun(_7708,_7753,_7754,n),_7878,_7863,_7800),
    {user:subclass0(_7708,vehicle)},
    {user:_7704=(exists(_7707)::_7707 isa _7708 and _7741 isa _7743 and adj/nil/_7741/_7707/real)}.

np2(_7698,_7699,[np2,_7845,{},{},_7894,_7923,_7952,{},!,_7996,_8020,!],_7828,_7830) --> 
    w(name(_7733,n,_7735),_7845,_7828,_7862),
    {user:testmember(_7735,[neighbourhood,station,street])},
    {user:(\+testmember(_7733,[sentrum]))},
    w(noun(_7759,_7760,_7761,n),_7894,_7862,_7911),
    not_look_ahead([nr],_7923,_7911,_7940),
    not_look_ahead(w(nb(_7772,_7773)),_7952,_7940,_7969),
    {user:subclass0(_7759,vehicle)},
    !,
    accept(_7996,_7969,_8011),
    lock(exact,_8011,_8040),pushstack(exact,(w(noun(_7759,sin,def,n)),w(prep(to)),w(name(_7733,n,_7735))),nil,_8040,_8046),np1(_7698,_7699,_8020,_8046,_8035),unlock(_8035,_7830),
    !.

np2(_7698,_7699,[np2,_7799,{},_7838,_7867,!,_7901,_7925,!],_7782,_7784) --> 
    w(nb(_7724,num),_7799,_7782,_7816),
    {user:this_year(_7724)},
    not_look_ahead([-],_7838,_7816,_7855),
    not_look_ahead(w(nb(_7739,_7740)),_7867,_7855,_7884),
    !,
    accept(_7901,_7884,_7916),
    lock(exact,_7916,_7945),pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_7724,num))),nil,_7945,_7951),np1(_7698,_7699,_7925,_7951,_7940),unlock(_7940,_7784),
    !.

np2(_7698,_7699,[np2,_7779,_7803,lit(enn),!,_7848],_7762,_7764) --> 
    oter(_7779,_7762,_7794),
    w(noun(_7726,_7727,u,n),_7803,_7794,_7820),
    cc(enn,_7820,_7842),
    !,
    pushstack(first,(a,w(noun(_7726,sin,u,n)),[ulik]),nil,_7842,_7886),
    np1(_7698,_7699,_7848,_7886,_7764).

np2(_7698,_7701::_7702,[np2,_7783,_7812,_7841,_7875],_7766,_7768) --> 
    not_look_ahead([alle],_7783,_7766,_7800),
    not_look_ahead(w(name(_7734,_7735,_7736)),_7812,_7800,_7829),
    quant_pron(every,_7721,_7841,_7829,_7860),
    pushstack(first,(every,w(noun(_7721,sin,u,n))),nil,_7860,_7913),
    np1(_7698,_7701::_7702,_7875,_7913,_7768).

np2(_7698,_7699,[np2,_7769,_7803,_7832,_7856],_7752,_7754) --> 
    quant_pron(every,_7718,_7769,_7752,_7788),
    not_look_ahead([som],_7803,_7788,_7820),
    not_look_ahead_np(_7832,_7820,_7847),
    pushstack(first,(every,w(noun(_7718,sin,u,n))),nil,_7847,_7894),
    np0_accept(_7698,_7699,_7856,_7894,_7754).

np2(_7698,_7699,[np2,_7760,_7794,_7818,_7847,_7871],_7743,_7745) --> 
    quant_pron(some,_7713,_7760,_7743,_7779),
    rfxpron0(_7794,_7779,_7809),
    not_look_ahead([som],_7818,_7809,_7835),
    not_look_ahead_np(_7847,_7835,_7862),
    np00(_7713,_7698,_7699,_7871,_7862,_7745).

clock_number(_7700:_7701,[clock_number,_7749,{},!],_7735,_7737) --> 
    number(_7700:_7701,_7749,_7735,_7737),
    {user:clock_test(_7700)},
    !.

bus_number(_7700:_7701,[bus_number,_7746,{}],_7732,_7734) --> 
    number(_7700:_7701,_7746,_7732,_7734),
    {user:plausible_busno(_7700)}.

road_number(_7700:_7701,[road_number,_7747,{}],_7733,_7735) --> 
    number(_7700:_7701,_7747,_7733,_7735),
    {user:_7700=<200}.

noun_list2(_7698,_7699,_7700,[noun_list2,_7758,_7812],_7738,_7740) --> 
    noun(_7710,_7698,u,n,_7705,_7706,_7758,_7738,_7785),
    nlists10(_7705,_7706,_7699,_7700,_7812,_7785,_7740).

nlists10(_7706:_7707,_7699,(_7706,_7716):(_7707,_7713),_7699 and _7704,[nlists10,_7785,_7809,_7863],_7762,_7764) --> 
    comma(_7785,_7762,_7800),
    noun(_7729,_7730,_7731,n,_7724,_7725,_7809,_7800,_7836),
    nlists10(_7724,_7725,_7716:_7713,_7704,_7863,_7836,_7764).

nlists10(_7706:_7707,_7699,(_7706,_7716):(_7707,_7713),_7699 and _7704,[nlists10,_7779,_7808],_7756,_7758) --> 
    andor(_7728,_7779,_7756,_7796),
    noun(_7721,_7722,_7723,n,_7716:_7713,_7704,_7808,_7796,_7758).

noun_list(_7698,_7699,_7700,[noun_list,_7801,_7830,_7859,_7888,_7917,{},_7981],_7781,_7783) --> 
    not_look_ahead([noe],_7801,_7781,_7818),
    not_look_ahead([noen],_7830,_7818,_7847),
    not_look_ahead([min],_7859,_7847,_7876),
    not_look_ahead(w(adj2(_7741,nil)),_7888,_7876,_7905),
    noun(_7744,_7698,_7746,n,_7720,_7721,_7917,_7905,_7944),
    {user:(\+testmember(_7744,[clock]))},
    nlists0join(_7720,_7721,_7699,_7700,_7981,_7944,_7783).

nlists0join(_7698,_7699,_7703:_7704,_7701,[nlists0join,_7782,{},!,_7841,{}],_7759,_7761) --> 
    nlists0(_7698,_7699,_7703:_7729,_7701,_7782,_7759,_7805),
    {user:joinclasses(_7729,_7704)},
    !,
    accept(_7841,_7805,_7761),
    {user:_7704\==thing}.

nlists0(_7706:_7707,_7699,(_7706,_7716):(_7707,_7713),_7699 and _7704,[nlists0,lit(og),_7841,_7870,_7924,{},{},_7973],_7807,_7809) --> 
    cc(og,_7807,_7840),
    not_look_ahead_lit([da,så,min],_7841,_7840,_7858),
    noun(_7751,_7752,_7753,n,_7736,_7737,_7870,_7858,_7897),
    not_look_ahead(w(prep(_7762)),_7924,_7897,_7941),
    {user:joinclass(_7707,_7751,_7768)},
    {user:(_7768\==thing,_7768\==nil)},
    nlists0(_7736,_7737,_7716:_7713,_7704,_7973,_7941,_7809).

nlists0(_7698,_7699,_7698,_7699,[nlists0,[],_7766],_7738,_7740) --> 
    [],
    not_look_ahead(w(noun(_7710,_7711,_7712,_7713)),_7766,_7738,_7740).

postcode(_7698,[postcode,_7780,{},_7819,{}],_7766,_7768) --> 
    w(nb(_7698,num),_7780,_7766,_7797),
    {user:(number(_7698),_7698>=1000,_7698=<9999)},
    look_ahead(w(name(_7745,n,_7711)),_7819,_7797,_7768),
    {user:testmember(_7711,[city,neighbourhood,station])}.

noun_compound(_7698,_7699,sin,[noun_compound,_7767,_7796,_7835,_7859],_7747,_7749) --> 
    not_look_ahead([man],_7767,_7747,_7784),
    namep(_7722,_7713,_7714,_7796,_7784,_7817),
    sin(_7835,_7817,_7850),
    ncomps0(gen,_7698,_7713,_7714,_7699,_7716,_7859,_7850,_7749).

noun_compound(_7698,_7702 and _7703,_7700,[noun_compound,_7778,_7807,_7836,{}],_7758,_7760) --> 
    not_look_ahead([dere],_7778,_7758,_7795),
    w(name(_7716,_7727,_7728),_7807,_7795,_7824),
    noun(_7730,_7700,u,n,_7698,_7702,_7836,_7824,_7760),
    {user:adjnamecomp_template(_7716,_7698,_7703)}.

noun_compound(_7698,_7699,_7700,[noun_compound,_7782,_7811,{},_7870,_7914],_7762,_7764) --> 
    not_look_ahead([man],_7782,_7762,_7799),
    noun2(_7725,_7726,_7727,_7716,_7717,_7811,_7799,_7836),
    {user:_7700=_7725},
    s0(_7725,_7726,_7727,_7714,_7870,_7836,_7893),
    ncomps0(_7714,_7698,_7716,_7717,_7699,_7719,_7914,_7893,_7764).

morenames(_7698,(_7698,_7702),[morenames,_7748,_7777],_7731,_7733) --> 
    unplausible_name(_7707,_7748,_7731,_7765),
    morenames(_7707,_7702,_7777,_7765,_7733).

morenames(_7698,_7698,[morenames,[]],_7720,_7720) --> 
    [].

unplausible_name(_7698,[unplausible_name,_7743,!,_7777],_7729,_7731) --> 
    w(name(_7698,unknown,_7710),_7743,_7729,_7760),
    !,
    accept(_7777,_7760,_7731).

ncomps0(gen,_7699,_7700,_7701,_7702,0,[ncomps0,_7781,_7810,{}],_7752,_7754) --> 
    preadjs0(_7713,_7781,_7752,_7798),
    ncomps(_7699,_7700,_7716,_7702,_7810,_7798,_7754),
    {user:preadjs_template(_7713,_7699,_7701,_7716)}.

ncomps0(n,_7705:_7706,_7705:_7706,_7701,_7701,0,[ncomps0,_7774],_7745,_7747) --> 
    w(noun(_7706,_7714,_7715,n),_7774,_7745,_7747).

ncomps0(n,_7699,_7700,_7701,_7701,name,[ncomps0,{}],_7737,_7737) --> 
    {user:compatvar(_7699,_7700)}.

ncomps(_7698,_7699,_7700,_7701,[ncomps,_7780,{},_7839],_7757,_7759) --> 
    noun2(_7716,_7717,_7709,_7711,_7720,_7780,_7757,_7805),
    {user:has_template(_7699,_7711,_7726)},
    ncomps0(_7709,_7698,_7711,_7700 and _7720 and _7726,_7701,_7714,_7839,_7805,_7759).

s0(_7698,_7699,n,gen,[s0,_7749],_7726,_7728) --> 
    sin(_7749,_7726,_7728).

s0(_7698,_7699,n,gen,[s0,lit(s)],_7728,_7730) --> 
    cc(s,_7728,_7730).

s0(sin,u,n,n,[s0,[]],_7726,_7726) --> 
    [].

s0(sin,def,n,n,[s0,[]],_7726,_7726) --> 
    [].

s0(plu,u,n,n,[s0,[]],_7726,_7726) --> 
    [].

s0(plu,def,n,n,[s0,[]],_7726,_7726) --> 
    [].

s0(_7698,_7699,gen,gen,[s0,[]],_7726,_7726) --> 
    [].

noun_modifiers0(_7698,_7699,_7706::_7704,_7703::_7704,[noun_modifiers0,_7760],_7737,_7739) --> 
    noun_modsx0(_7698,_7699,_7703,_7706,_7760,_7737,_7739).

noun_modsx0(0,_7699,_7700,_7701,[noun_modsx0,_7753],_7730,_7732) --> 
    rel_clauses(_7699,_7700,_7701,_7753,_7730,_7732).

noun_modsx0(0,_7712:_7713,_7700,_7700 and _7715 isa coevent and _7709 and _7710,[noun_modsx0,{},lit(til),lit(at),!,_7855,{},!,_7904],_7795,_7797) --> 
    {user:testmember(_7713,[cause])},
    cc(til,_7795,_7838),
    cc(at,_7838,_7849),
    !,
    clausal_object1(_7715:coevent,true::_7710,_7855,_7849,_7874),
    {user:noun_compl(to,_7712:_7713,_7715:coevent,_7709)},
    !,
    accept(_7904,_7874,_7797).

noun_modsx0(0,_7712:_7713,_7700,_7700 and _7715 isa coevent and _7709 and _7710,[noun_modsx0,{},lit(for),lit(å),!,_7860,{},!,_7918],_7800,_7802) --> 
    {user:testmember(_7713,[way])},
    cc(for,_7800,_7843),
    cc(å,_7843,_7854),
    !,
    pushstack(first,[noen],nil,_7854,_7873),clausal_object1(_7715:coevent,true::_7710,_7860,_7873,_7888),
    {user:noun_compl(regarding,_7712:_7713,_7715:coevent,_7709)},
    !,
    accept(_7918,_7888,_7802).

noun_modsx0(0,_7712:_7713,_7700,_7700 and _7715 isa coevent and _7709 and _7710,[noun_modsx0,{},lit(for),lit(hvordan),!,_7855,{},!,_7904],_7795,_7797) --> 
    {user:testmember(_7713,[way])},
    cc(for,_7795,_7838),
    cc(hvordan,_7838,_7849),
    !,
    clausal_object1(_7715:coevent,true::_7710,_7855,_7849,_7874),
    {user:noun_compl(regarding,_7712:_7713,_7715:coevent,_7709)},
    !,
    accept(_7904,_7874,_7797).

noun_modsx0(0,_7712:_7713,_7700,_7700 and _7715 isa coevent and _7709 and _7710,[noun_modsx0,{},lit(om),lit(hvor),_7866,!,_7900,{},!,_7958],_7811,_7813) --> 
    {user:testmember(_7713,[question])},
    cc(om,_7811,_7854),
    cc(hvor,_7854,_7865),
    w(adj2(_7755,nil),_7866,_7865,_7883),
    !,
    pushstack(free,w(adj2(_7755,nil)),nil,_7883,_7913),clausal_object1(_7715:coevent,true::_7710,_7900,_7913,_7928),
    {user:noun_compl(regarding,_7712:_7713,_7715:coevent,_7709)},
    !,
    accept(_7958,_7928,_7813).

noun_modsx0(0,_7712:_7713,_7700,_7700 and _7715 isa coevent and _7709 and _7710,[noun_modsx0,{},lit(der),!,_7839,{},!,_7888],_7790,_7792) --> 
    {user:testmember(_7713,[example])},
    cc(der,_7790,_7833),
    !,
    clausal_object1(_7715:coevent,true::_7710,_7839,_7833,_7858),
    {user:noun_compl(on,_7712:_7713,_7715:coevent,_7709)},
    !,
    accept(_7888,_7858,_7792).

noun_modsx0(0,_7712:_7713,_7700,_7700 and _7715 isa coevent and _7709 and _7710,[noun_modsx0,{},_7836,lit(å),!,_7896,{},!,_8010],_7803,_7805) --> 
    {user:testmember(_7713,[cause])},
    optional([for],_7836,_7803,_7868),
    cc(å,_7868,_7890),
    !,
    pushstack(first,(someone,aux1),nil,_7890,_7965),clausal_object1(_7715:coevent,true::_7710,_7896,_7965,_7980),
    {user:noun_compl(for,_7712:_7713,_7715:coevent,_7709)},
    !,
    accept(_8010,_7980,_7805).

noun_modsx0(0,_7712:_7713,_7700,_7700 and _7715 isa coevent and _7709 and _7710,[noun_modsx0,{},_7838,lit(å),!,_7898,{},!,_8012],_7805,_7807) --> 
    {user:testmember(_7713,[permission,possibility])},
    optional([til],_7838,_7805,_7870),
    cc(å,_7870,_7892),
    !,
    pushstack(first,(someone,aux1),nil,_7892,_7967),clausal_object1(_7715:coevent,true::_7710,_7898,_7967,_7982),
    {user:noun_compl(to,_7712:_7713,_7715:coevent,_7709)},
    !,
    accept(_8012,_7982,_7807).

noun_modsx0(0,_7712:_7713,_7700,_7700 and _7715 isa coevent and _7709 and _7710,[noun_modsx0,{},lit(om),lit(å),!,_7867,{},!,_7981],_7807,_7809) --> 
    {user:testmember(_7713,[notification,request,plan,wish])},
    cc(om,_7807,_7850),
    cc(å,_7850,_7861),
    !,
    pushstack(first,(someone,aux1),nil,_7861,_7936),clausal_object1(_7715:coevent,true::_7710,_7867,_7936,_7951),
    {user:noun_compl(about,_7712:_7713,_7715:coevent,_7709)},
    !,
    accept(_7981,_7951,_7809).

noun_modsx0(0,_7712:_7713,_7700,_7700 and _7715 isa coevent and _7709 and _7710,[noun_modsx0,{},_7831,lit(at),!,_7876,{},!,_7925],_7798,_7800) --> 
    {user:constrain(_7712:_7713,connection)},
    w(prep(with),_7831,_7798,_7848),
    cc(at,_7848,_7870),
    !,
    clausal_object1(_7715:coevent,true::_7710,_7876,_7870,_7895),
    {user:noun_compl(with,_7712:_7713,_7715:coevent,_7709)},
    !,
    accept(_7925,_7895,_7800).

noun_modsx0(0,_7699,_7700,_7700 and _7704,[noun_modsx0,{},_7832,_7856,_7900,_7934,!,_7973],_7799,_7801) --> 
    {user:constrain(_7699,way)},
    in_order_tox(_7832,_7799,_7847),
    lexv(tv,_7747,inf,fin,_7856,_7847,_7879),
    np1(_7751,_7754::_7755,_7900,_7879,_7919),
    fictitiousprep(way,_7758,_7934,_7919,_7953),
    !,
    pushstack(first,(someone,w(verb(_7747,pres,fin)),np1(_7751,_7754::_7755),prep(_7758),npgap(_7699)),nil,_7953,_8105),
    statreal(_7704,_7973,_8105,_7801).

noun_modsx0(0,_7699,_7700,_7700 and _7704,[noun_modsx0,{},_7814,_7838,_7882,!,_7921],_7781,_7783) --> 
    {user:constrain(_7699,way)},
    in_order_tox(_7814,_7781,_7829),
    lexv(iv,_7741,inf,fin,_7838,_7829,_7861),
    fictitiousprep(way,_7746,_7882,_7861,_7901),
    !,
    pushstack(first,(someone,w(verb(_7741,pres,fin)),prep(_7746),npgap(_7699)),nil,_7901,_8019),
    statreal(_7704,_7921,_8019,_7783).

noun_modsx0(_7698,_7699,_7700,_7700,[noun_modsx0,_7759,!,_7793],_7736,_7738) --> 
    look_ahead([den],_7759,_7736,_7776),
    !,
    accept(_7793,_7776,_7738).

noun_modsx0(_7698,_7699,_7700,_7700,[noun_modsx0,{},_7785,!,_7819],_7752,_7754) --> 
    {user:(vartypeid(_7699,_7717),subclass(_7717,daypart))},
    not_look_ahead(w(prep(_7727)),_7785,_7752,_7802),
    !,
    accept(_7819,_7802,_7754).

noun_modsx0(_7698,_7699,_7700,_7701,[noun_modsx0,_7757,!],_7734,_7736) --> 
    noun_mods(_7698,_7699,_7700,_7701,_7757,_7734,_7736),
    !.

noun_modsx0(_7698,_7699,_7700,_7700,[noun_modsx0,[]],_7726,_7726) --> 
    [].

fictitiousprep(way,in,[fictitiousprep,[]],_7720,_7720) --> 
    [].

fictitiousprep(abstract,with,[fictitiousprep,[]],_7720,_7720) --> 
    [].

noun_mods(0,_7699,_7700,_7700 and _7704,[noun_mods,{},_7902,{},_7941,_7970,_7999,_8028,_8057,_8086,_8115,_8144],_7869,_7871) --> 
    {user:(vartypeid(_7699,_7753),testmember(_7753,[address,email,mind,mailaddress,telephone,webaddress]))},
    prep1(to,_7902,_7869,_7919),
    {user:(vartypeid(_7699,_7780),\+testmember(_7780,[name]))},
    not_look_ahead(w(nb(_7792,_7793)),_7941,_7919,_7958),
    not_look_ahead(w(prep(_7799)),_7970,_7958,_7987),
    not_look_ahead_lit([deg,meg,seg],_7999,_7987,_8016),
    not_look_ahead(w(noun(station,_7814,_7815,_7816)),_8028,_8016,_8045),
    not_look_ahead(w(name(_7822,_7823,station)),_8057,_8045,_8074),
    not_look_ahead(w(name(_7830,_7831,neighbourhood)),_8086,_8074,_8103),
    not_look_ahead(w(name(_7838,_7839,city)),_8115,_8103,_8132),
    pushstack(first,(npgap(_7699),w(verb(evah,pres,fin))),nil,_8132,_8184),
    statreal(_7704,_8144,_8184,_7871).

noun_mods(0,_7699,_7700,_7700 and _7704,[noun_mods,{},_7813,{},{},_7862],_7780,_7782) --> 
    {user:value(teleflag,true)},
    not_look_ahead(w(prep(_7739)),_7813,_7780,_7830),
    {user:vartypeid(_7699,_7744)},
    {user:(\+vartypid(_7744,[]))},
    pushstack(first,(npgap(_7699),w(verb(evah,pres,fin))),nil,_7830,_7902),
    statreal(_7704,_7862,_7902,_7782).

noun_mods(0,_7699,_7700,_7701,[noun_mods,_7767,!,_7811,_7835],_7744,_7746) --> 
    noun_mod(_7699,_7700,_7714,_7767,_7744,_7788),
    !,
    accept(_7811,_7788,_7826),
    noun_modsx0(0,_7699,_7714,_7701,_7835,_7826,_7746).

noun_mods(name,_7699,_7700,_7701,[noun_mods,{},_7812,{},_7851,!,_7895,_7919],_7779,_7781) --> 
    {user:(vartypeid(_7699,_7731),subclass0(_7731,vehicle))},
    look_ahead(w(prep(_7741)),_7812,_7779,_7829),
    {user:testmember(_7741,[to,from])},
    noun_mod(_7699,_7700,_7723,_7851,_7829,_7872),
    !,
    accept(_7895,_7872,_7910),
    noun_mods(name,_7699,_7723,_7701,_7919,_7910,_7781).

noun_mods(name,_7699,_7700,_7701,[noun_mods,_7802,{},{},_7851,!,_7895,_7919],_7779,_7781) --> 
    look_ahead(w(prep(_7730)),_7802,_7779,_7819),
    {user:testmember(_7730,[on,towards])},
    {user:(vartypeid(_7699,_7746),subclass0(_7746,place))},
    noun_mod(_7699,_7700,_7723,_7851,_7819,_7872),
    !,
    accept(_7895,_7872,_7910),
    noun_mods(name,_7699,_7723,_7701,_7919,_7910,_7781).

noun_mods(name,_7699,_7700,_7701,[noun_mods,{},_7785,_7824],_7752,_7754) --> 
    {user:(value(textflag,true);value(teleflag,true))},
    noun_mod(_7699,_7700,_7711,_7785,_7752,_7806),
    noun_mods(name,_7699,_7711,_7701,_7824,_7806,_7754).

noun_mods(name,_7699,_7700,_7700 and _7704,[noun_mods,{},{},_7829,{},_7868],_7786,_7788) --> 
    {user:value(teleflag,true)},
    {user:constrain(_7699,person)},
    w(name(_7726,n,_7728),_7829,_7786,_7846),
    {user:subclass0(_7728,place)},
    pushstack(first,(prep1(in),w(name(_7726,n,_7728))),nil,_7846,_7908),
    noun_mod(_7699,_7700,_7704,_7868,_7908,_7788).

noun_mod(_7708:_7709,_7699,nrel/nil/day/clock/_7708/_7712 and _7699 and _7706,[noun_mod,{},_7797,_7821],_7767,_7769) --> 
    {user:constrain(_7708:_7709,day)},
    clock(_7797,_7767,_7812),
    clock_sequel(_7712:_7744,_7706,_7821,_7812,_7769).

noun_mod(_7698,_7699,_7699 and _7703,[noun_mod,_7763,{},!],_7743,_7745) --> 
    adverb(_7711,_7712,_7713,_7763,_7743,_7745),
    {user:noun_adverb(_7698,_7711,_7712,_7703)},
    !.

noun_mod(_7708:_7709,_7699,_7699 and _7705 and _7706,[noun_mod,lit(for),lit(å),_7831,!,_7870,{},!,_7928],_7789,_7791) --> 
    cc(for,_7789,_7819),
    cc(å,_7819,_7830),
    gmem(_7709,[condition],_7831,_7830,_7850),
    !,
    pushstack(first,[noen],nil,_7850,_7883),clausal_object1(_7752:coevent,true::_7706,_7870,_7883,_7898),
    {user:noun_compl(for,_7708:_7709,_7752:coevent,_7705)},
    !,
    accept(_7928,_7898,_7791).

noun_mod(_7708:_7709,_7699,_7699 and _7705 and _7706,[noun_mod,lit(om),lit(at),{},!,_7857,{},{},!,_7916],_7800,_7802) --> 
    cc(om,_7800,_7830),
    cc(at,_7830,_7841),
    {user:testmember(_7709,[information,message,notification,question])},
    !,
    clausal_object1(_7758:coevent,_7755::_7706,_7857,_7841,_7876),
    {user:_7755=true},
    {user:noun_compl(regarding,_7708:_7709,_7758:coevent,_7705)},
    !,
    accept(_7916,_7876,_7802).

noun_mod(_7698,_7699,_7699 and _7703,[noun_mod,_7772,_7801],_7752,_7754) --> 
    posspron(_7719,_7772,_7752,_7789),
    lock(exact,_7789,_7878),
    pushstack(exact,(pronoun(_7719),w(verb(have,pres,fin)),npgap(_7698)),nil,_7878,_7884),
    statreal(_7703,_7801,_7884,_7873),
    unlock(_7873,_7754).

noun_mod(_7698,_7699,_7699 and _7703,[noun_mod,_7760,_7789],_7740,_7742) --> 
    look_ahead(w(adj(_7716,comp)),_7760,_7740,_7777),
    comparison(_7698,_7709,_7703,_7789,_7777,_7742).

noun_mod(_7698,_7699,_7699 and _7703,[noun_mod,_7793,{},_7832,{},!,_7886,{}],_7773,_7775) --> 
    negation0(_7725,_7793,_7773,_7810),
    {user:(\+vartypeid(_7698,self))},
    adjunct1(_7738,_7739,_7727::_7703,_7832,_7810,_7853),
    {user:noun_compl(_7738,_7698,_7739,_7726)},
    !,
    accept(_7886,_7853,_7775),
    {user:negate(_7725,_7726,_7727)}.

noun_mod(_7702:_7703,_7699,_7699,[noun_mod,{},_7780,_7804,{}],_7750,_7752) --> 
    {user:constrain(_7702:_7703,vehicle)},
    numberroute(_7780,_7750,_7795),
    num_na(_7716,_7804,_7795,_7752),
    {user:_7716=_7702}.

noun_mod(_7698,_7699,_7699 and _7703,[noun_mod,_7783,_7812,{},!,_7883],_7763,_7765) --> 
    day(_7717,_7783,_7763,_7800),
    lock(exact,_7800,_7832),pushstack(exact,w(noun(_7717,sin,u,n)),nil,_7832,_7838),np1(_7729,_7732::_7703,_7812,_7838,_7827),unlock(_7827,_7828),
    {user:noun_compl(nil,_7698,_7729,_7732)},
    !,
    accept(_7883,_7828,_7765).

noun_mod(_7698,_7699,_7699 and _7703,[noun_mod,_7788,_7817,{},!,_7875],_7768,_7770) --> 
    w(noun(midnight,_7720,_7721,n),_7788,_7768,_7805),
    pushstack(first,w(noun(midnight,sin,u,n)),nil,_7805,_7830),np1(_7734,_7737::_7703,_7817,_7830,_7845),
    {user:noun_compl(nil,_7698,_7734,_7737)},
    !,
    accept(_7875,_7845,_7770).

noun_mod(_7698,_7699,_7699 and _7703,[noun_mod,_7768,{},!,_7817],_7748,_7750) --> 
    obviousdate(_7714,_7717::_7703,_7768,_7748,_7787),
    {user:noun_compl(nil,_7698,_7714,_7717)},
    !,
    accept(_7817,_7787,_7750).

noun_mod(_7698,_7699,_7699 and _7703,[noun_mod,_7768,{},!,_7817],_7748,_7750) --> 
    obviousclock(_7714,_7717::_7703,_7768,_7748,_7787),
    {user:noun_compl(nil,_7698,_7714,_7717)},
    !,
    accept(_7817,_7787,_7750).

noun_mod(_7698,_7699,_7700,[noun_mod,_7785,_7814,!,_7853,!,_7937],_7765,_7767) --> 
    w(noun(direction,_7720,_7721,_7722),_7785,_7765,_7802),
    nameq1(_7724,_7725,_7814,_7802,_7833),
    !,
    pushstack(first,(w(prep(towards)),nameq1(_7724,_7725)),nil,_7833,_7897),noun_mod(_7698,_7699,_7700,_7853,_7897,_7914),
    !,
    accept(_7937,_7914,_7767).

noun_mod(_7705:_7706,_7699,_7699 and _7703,[noun_mod,{},_7795,{},!,_7844],_7765,_7767) --> 
    {user:test(n_compl(nil,_7706,_7726))},
    np1_accept(_7728,_7731::_7703,_7795,_7765,_7814),
    {user:noun_compl(nil,_7705:_7706,_7728,_7731)},
    !,
    accept(_7844,_7814,_7767).

begin([begin,[]],_7713,_7713) --> 
    [].

end([end,[]],_7713,_7713) --> 
    [].

accept([accept,[]],_7713,_7713) --> 
    [].

reject([reject,{}],_7715,_7715) --> 
    {user:fail}.

look_ahead_place([look_ahead_place,_7742,{}],_7731,_7733) --> 
    look_ahead(w(name(_7712,_7713,_7705)),_7742,_7731,_7733),
    {user:test(subclass0(_7705,place))}.

look_ahead_conjuction([look_ahead_conjuction,_7728],_7717,_7719) --> 
    look_ahead([før],_7728,_7717,_7719).

look_ahead_conjuction([look_ahead_conjuction,_7728],_7717,_7719) --> 
    look_ahead([etter],_7728,_7717,_7719).

look_ahead_conjuction([look_ahead_conjuction,_7728],_7717,_7719) --> 
    look_ahead([når],_7728,_7717,_7719).

not_look_ahead_flnp([not_look_ahead_flnp,_7753,{},!,_7797],_7742,_7744) --> 
    look_ahead(w(adj2(_7711,nil)),_7753,_7742,_7770),
    {user:testmember(_7711,[first,last,next,previous])},
    !,
    reject(_7797,_7770,_7744).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_7713,_7713) --> 
    [].

not_look_ahead_flnp([not_look_ahead_flnp,_7753,{},!,_7797],_7742,_7744) --> 
    look_ahead(w(adj2(_7711,nil)),_7753,_7742,_7770),
    {user:testmember(_7711,[first,last,next,previous])},
    !,
    reject(_7797,_7770,_7744).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_7713,_7713) --> 
    [].

not_look_ahead_vehicle([not_look_ahead_vehicle,_7749,{},!,_7793],_7738,_7740) --> 
    look_ahead(w(noun(_7711,_7712,_7713,_7714)),_7749,_7738,_7766),
    {user:test(subclass0(_7711,vehicle))},
    !,
    reject(_7793,_7766,_7740).

not_look_ahead_vehicle([not_look_ahead_vehicle,_7751,{},!,_7795],_7740,_7742) --> 
    look_ahead(w(noun(_7711,_7712,_7713,_7714)),_7751,_7740,_7768),
    {user:testmember(_7711,[departure,arrival])},
    !,
    reject(_7795,_7768,_7742).

not_look_ahead_vehicle([not_look_ahead_vehicle,[]],_7713,_7713) --> 
    [].

not_look_ahead_day([not_look_ahead_day,_7747,{},!,_7791],_7736,_7738) --> 
    look_ahead(w(noun(_7711,_7712,_7713,_7714)),_7747,_7736,_7764),
    {user:_7711 ako day},
    !,
    reject(_7791,_7764,_7738).

not_look_ahead_day([not_look_ahead_day,[]],_7713,_7713) --> 
    [].

not_look_ahead_noun([not_look_ahead_noun,_7733],_7722,_7724) --> 
    not_look_ahead(w(noun(_7702,_7703,_7704,_7705)),_7733,_7722,_7724).

look_ahead_timeclause([look_ahead_timeclause,_7733],_7722,_7724) --> 
    look_ahead(w(noun(clock,_7703,_7704,_7705)),_7733,_7722,_7724).

look_ahead_timeclause([look_ahead_timeclause,_7741,{}],_7730,_7732) --> 
    look_ahead(w(noun(_7703,sin,u,n)),_7741,_7730,_7732),
    {user:subclass(_7703,day)}.

look_ahead_clock([look_ahead_clock,_7730],_7719,_7721) --> 
    look_ahead_lit([kl,klokken],_7730,_7719,_7721).

look_ahead_clock([look_ahead_clock,_7733],_7722,_7724) --> 
    look_ahead(w(noun(clock,sin,def,n)),_7733,_7722,_7724).

look_ahead_clock([look_ahead_clock,_7731],_7720,_7722) --> 
    look_ahead(w(nb(_7702,_7703)),_7731,_7720,_7722).

not_look_ahead_vp([not_look_ahead_vp,_7730,!,_7759],_7719,_7721) --> 
    look_ahead_vp(_7730,_7719,_7745),
    !,
    reject(_7759,_7745,_7721).

not_look_ahead_vp([not_look_ahead_vp,[]],_7713,_7713) --> 
    [].

look_ahead_vp([look_ahead_vp,_7732],_7721,_7723) --> 
    look_ahead(w(verb(_7702,_7703,_7704)),_7732,_7721,_7723).

look_ahead_vp([look_ahead_vp,_7728],_7717,_7719) --> 
    look_ahead([ikke],_7728,_7717,_7719).

look_ahead_vp([look_ahead_vp,_7724],_7713,_7715) --> 
    look_ahead_aux(_7724,_7713,_7715).

look_ahead_aux([look_ahead_aux,_7746],_7735,_7737) --> 
    look_ahead_lit([vil,skal,bør,må,kan,ville,skulle,burde,måtte,kunne],_7746,_7735,_7737).

not_look_ahead_lit(_7698,[not_look_ahead_lit,_7739,!,_7773],_7725,_7727) --> 
    look_ahead_lit(_7698,_7739,_7725,_7756),
    !,
    reject(_7773,_7756,_7727).

not_look_ahead_lit(_7698,[not_look_ahead_lit,[]],_7717,_7717) --> 
    [].

look_ahead_lit(_7698,[look_ahead_lit,_7746,{},!],_7732,_7734) --> 
    look_ahead([_7707],_7746,_7732,_7734),
    {user:testmember(_7707,_7698)},
    !.

lit_of(_7698,_7699,[lit_of,lit(_7698),{},!],_7733,_7735) --> 
    cc(_7698,_7733,_7735),
    {user:member(_7698,_7699)},
    !.

one_of_lit(_7698,[one_of_lit,lit(_7705),{},!],_7730,_7732) --> 
    cc(_7705,_7730,_7732),
    {user:member(_7705,_7698)},
    !.

not_one_of_lit(_7698,[not_one_of_lit,_7739,!,_7773],_7725,_7727) --> 
    one_of_lit(_7698,_7739,_7725,_7756),
    !,
    reject(_7773,_7756,_7727).

not_one_of_lit(_7698,[not_one_of_lit,[]],_7717,_7717) --> 
    [].

not_look_ahead_number([not_look_ahead_number,lit(ett),!],_7718,_7720) --> 
    cc(ett,_7718,_7720),
    !.

not_look_ahead_number([not_look_ahead_number,_7735,!,_7769],_7724,_7726) --> 
    w(nb(_7706,_7707),_7735,_7724,_7752),
    !,
    fail(_7769,_7752,_7726).

not_look_ahead_number([not_look_ahead_number,[]],_7713,_7713) --> 
    [].

not_look_ahead_np([not_look_ahead_np,_7749,_7778,!],_7738,_7740) --> 
    look_ahead(w(adv(_7708)),_7749,_7738,_7766),
    gmem(_7708,[klokken,kloka,kl,directly,correctly],_7778,_7766,_7740),
    !.

not_look_ahead_np([not_look_ahead_np,_7730,!,_7759],_7719,_7721) --> 
    look_ahead_np(_7730,_7719,_7745),
    !,
    reject(_7759,_7745,_7721).

not_look_ahead_np([not_look_ahead_np,[]],_7713,_7713) --> 
    [].

look_ahead_np([look_ahead_np,_7792],_7781,_7783) --> 
    look_ahead_lit([den,det,de,denne,dere,dette,disse,du,en,et,ei,han,hun,jeg,noe,noen,vi,meg,deg,seg,min,mine,din,dine,hans,hennes,seg,vår,våre,deres,mange,noen,noe],_7792,_7781,_7783).

look_ahead_np([look_ahead_np,_7741,{}],_7730,_7732) --> 
    look_ahead(w(adj2(_7705,_7713)),_7741,_7730,_7732),
    {user:(\+testmember(_7705,[]))}.

look_ahead_np([look_ahead_np,_7733],_7722,_7724) --> 
    look_ahead(w(noun(_7702,_7703,_7704,_7705)),_7733,_7722,_7724).

look_ahead_np([look_ahead_np,_7731],_7720,_7722) --> 
    look_ahead(w(nb(_7702,_7703)),_7731,_7720,_7722).

look_ahead_np([look_ahead_np,_7730],_7719,_7721) --> 
    look_ahead_lit([halv,kvart],_7730,_7719,_7721).

look_ahead_np([look_ahead_np,_7742,{}],_7731,_7733) --> 
    look_ahead(w(name(_7705,_7713,_7714)),_7742,_7731,_7733),
    {user:(\+testmember(_7705,[]))}.

look_ahead_subject([look_ahead_subject,lit(_7703),{}],_7733,_7735) --> 
    cc(_7703,_7733,_7735),
    {user:testmember(_7703,[jeg,du,han,hun,vi])}.

look_ahead_pron([look_ahead_pron,_7734],_7723,_7725) --> 
    look_ahead_lit([jeg,vi,du,dere],_7734,_7723,_7725).

not_look_ahead_pron([not_look_ahead_pron,_7732,!,_7766],_7721,_7723) --> 
    posspron(_7704,_7732,_7721,_7749),
    !,
    reject(_7766,_7749,_7723).

not_look_ahead_pron([not_look_ahead_pron,_7734],_7723,_7725) --> 
    not_look_ahead_lit([jeg,du,han,hun],_7734,_7723,_7725).

determiner0(plu,0,_7700,_7701,_7704::quant(approx/_7717,_7700)::_7701 and _7704,[determiner0,lit(mellom),_7812,lit(og),_7852,{}],_7775,_7777) --> 
    cc(mellom,_7775,_7811),
    w(nb(_7717,num),_7812,_7811,_7829),
    cc(og,_7829,_7851),
    w(nb(_7734,num),_7852,_7851,_7777),
    {user:_7717<_7734}.

determiner0(plu,0,_7700,_7701,_7704::quant(eq/_7717,_7700)::_7701 and _7704,[determiner0,_7831,_7855,{},_7894,_7923,!,_7957,[]],_7805,_7807) --> 
    theplu0(_7831,_7805,_7846),
    w(adj2(_7745,nil),_7855,_7846,_7872),
    {user:testmember(_7745,[first,last,next,previous])},
    number(_7717:_7769,_7894,_7872,_7911),
    look_ahead(w(noun(_7775,plu,_7777,_7778)),_7923,_7911,_7940),
    !,
    accept(_7957,_7940,_7972),
    pushstack(free,w(adj2(_7745,nil)),nil,_7972,_7807),
    [].

determiner0(sin,0,_7700,_7701,_7704::_7705,[determiner0,{},_7789,_7813],_7753,_7755) --> 
    {user:value(dialog,1)},
    the(_7789,_7753,_7804),
    pushstack(first,this,nil,_7804,_7851),
    determiner(_7700,_7701,_7704::_7705,_7813,_7851,_7755).

determiner0(_7698,_7699,_7700,_7701,_7702,[determiner0,_7786,_7810,_7839,{},!,_7883],_7760,_7762) --> 
    theplu0(_7786,_7760,_7801),
    number(_7721:_7722,_7810,_7801,_7827),
    w(noun(_7726,_7727,_7728,_7729),_7839,_7827,_7856),
    {user:measureclass(_7726)},
    !,
    reject(_7883,_7856,_7762).

determiner0(plu,0,_7700,_7701,_7704::quant(approx/_7717,_7700)::_7701 and _7704,[determiner0,_7781,!,_7810],_7755,_7757) --> 
    approx(_7781,_7755,_7796),
    !,
    number(_7717:_7728,_7810,_7796,_7757).

approx([approx,lit(ca),!],_7718,_7720) --> 
    cc(ca,_7718,_7720),
    !.

approx([approx,lit(rundt),!],_7718,_7720) --> 
    cc(rundt,_7718,_7720),
    !.

determiner0(plu,0,_7700,_7701,_7704::quant(ge/_7717,_7700)::_7701 and _7704,[determiner0,_7778,_7802],_7752,_7754) --> 
    morethan(_7778,_7752,_7793),
    number(_7717:_7725,_7802,_7793,_7754).

morethan([morethan,lit(minst)],_7715,_7717) --> 
    cc(minst,_7715,_7717).

morethan([morethan,lit(over)],_7715,_7717) --> 
    cc(over,_7715,_7717).

morethan([morethan,lit(mer),lit(enn)],_7720,_7722) --> 
    cc(mer,_7720,_7741),
    cc(enn,_7741,_7722).

determiner0(plu,0,_7700,_7701,_7704::quant(eq/_7717,_7700)::_7701 and _7704,[determiner0,_7790,_7814,_7843],_7764,_7766) --> 
    theplu0(_7790,_7764,_7805),
    number(_7717:_7737,_7814,_7805,_7831),
    not_look_ahead(w(noun(time,_7730,def,n)),_7843,_7831,_7766).

determiner0(sin,0,_7700,_7701,_7704::quant(eq/1,_7700)::_7701 and _7704,[determiner0,_7790,_7819,!],_7764,_7766) --> 
    w(nb(1,num),_7790,_7764,_7807),
    not_look_ahead(w(noun(time,_7735,def,n)),_7819,_7807,_7766),
    !.

determiner0(sin,0,_7700,_7701,_7704::_7705,[determiner0,{},_7789,_7813],_7753,_7755) --> 
    {user:value(dialog,1)},
    the(_7789,_7753,_7804),
    pushstack(first,this,nil,_7804,_7851),
    determiner(_7700,_7701,_7704::_7705,_7813,_7851,_7755).

determiner0(plu,0,_7700,_7701,_7704::_7705,[determiner0,_7779,_7803,_7832],_7753,_7755) --> 
    the(_7779,_7753,_7794),
    not_look_ahead(w(verb(_7724,pres,fin)),_7803,_7794,_7820),
    determiner00(_7700,_7701,_7704::_7705,_7832,_7820,_7755).

determiner0(_7698,0,_7700,_7701,_7704::_7705,[determiner0,_7765],_7739,_7741) --> 
    determiner(_7700,_7701,_7704::_7705,_7765,_7739,_7741).

determiner0(_7698,0,_7700,_7701,_7704::_7705,[determiner0,_7765],_7739,_7741) --> 
    determiner00(_7700,_7701,_7704::_7705,_7765,_7739,_7741).

determiner0(_7698,0,_7700,_7701,_7704::exists(_7700)::_7701 and _7704,[determiner0,_7766],_7740,_7742) --> 
    the0(_7766,_7740,_7742).

determiner00(_7708:_7709,_7699,_7702::_7699 and _7702,[determiner00,_7760,!],_7740,_7742) --> 
    the(_7708:_7709,_7760,_7740,_7742),
    !.

determiner00(_7698,_7699,_7702::exists(_7698)::_7699 and _7702,[determiner00,[]],_7734,_7734) --> 
    [].

determiner(_7698,_7699,_7702::forall(_7698)::_7699=>_7702,[determiner,lit(alle),_7770],_7739,_7741) --> 
    cc(alle,_7739,_7769),
    look_ahead_np(_7770,_7769,_7741).

determiner(_7698,_7699,_7702::forall(_7698)::_7699=>_7702,[determiner,lit(hver)],_7736,_7738) --> 
    cc(hver,_7736,_7738).

determiner(_7698,_7699,_7702::find(_7698)::_7699 and _7702,[determiner,_7757,_7781],_7737,_7739) --> 
    this(_7757,_7737,_7772),
    look_ahead_np(_7781,_7772,_7739).

determiner(_7698,_7699,_7702::_7699 and _7702,[determiner,_7751],_7731,_7733) --> 
    the(_7698,_7751,_7731,_7733).

determiner(_7698,_7699,_7702::exists(_7698)::_7699 and _7702,[determiner,_7775,_7799,_7823,_7852,!],_7755,_7757) --> 
    only0(_7775,_7755,_7790),
    art(_7799,_7790,_7814),
    look_ahead(w(noun(_7729,sin,u,n)),_7823,_7814,_7840),
    off0(_7852,_7840,_7757),
    !.

determiner(_7698,_7699,_7702::exists(_7698)::_7699 and _7702,[determiner,_7760,_7784,_7808],_7740,_7742) --> 
    only0(_7760,_7740,_7775),
    art(_7784,_7775,_7799),
    off0(_7808,_7799,_7742).

determiner(_7698,_7699,_7702::forall(_7698)::_7699=>_7702,[determiner,_7757,_7781],_7737,_7739) --> 
    every(_7757,_7737,_7772),
    look_ahead_np(_7781,_7772,_7739).

determiner(_7698,_7699,_7702::not (exists(_7698)::_7699 and _7702),[determiner,_7759,_7783],_7739,_7741) --> 
    no(_7759,_7739,_7774),
    look_ahead_np(_7783,_7774,_7741).

determiner(_7698,_7699,_7702::exists(_7698)::_7699 and not _7702,[determiner,_7759,_7783],_7739,_7741) --> 
    notall(_7759,_7739,_7774),
    look_ahead_np(_7783,_7774,_7741).

determiner(_7698,_7699,_7702::quant(all,_7698)::_7699 and _7702,[determiner,lit(hele)],_7737,_7739) --> 
    cc(hele,_7737,_7739).

determiner(_7698,_7699,_7702::_7703,[determiner,_7753],_7733,_7735) --> 
    quantifier(_7698,_7699,_7702::_7703,_7753,_7733,_7735).

quantifier(_7698,_7699,_7702::quant(eq/_7715,_7698)::_7699 and _7702,[quantifier,lit(bare),_7779],_7748,_7750) --> 
    cc(bare,_7748,_7778),
    w(nb(_7715,_7723),_7779,_7778,_7750).

quantifier(_7698,_7699,_7702::quant(few,_7698)::_7699 and _7702,[quantifier,_7761,_7785,_7809],_7741,_7743) --> 
    aso0(_7761,_7741,_7776),
    few(_7785,_7776,_7800),
    look_ahead_np(_7809,_7800,_7743).

quantifier(_7698,_7699,_7702::quant(most,_7698)::_7699 and _7702,[quantifier,lit(de),lit(fleste),_7787],_7745,_7747) --> 
    cc(de,_7745,_7775),
    cc(fleste,_7775,_7786),
    look_ahead_np(_7787,_7786,_7747).

quantifier(_7698,_7699,_7702::quant(much,_7698)::_7699 and _7702,[quantifier,_7765,_7789],_7745,_7747) --> 
    much(_7765,_7745,_7780),
    not_look_ahead(w(adj2(_7721,nil)),_7789,_7780,_7747).

quantifier(_7698,_7699,_7702::quant(little,_7698)::_7699 and _7702,[quantifier,_7765,_7789],_7745,_7747) --> 
    little(_7765,_7745,_7780),
    not_look_ahead(w(adj2(_7721,nil)),_7789,_7780,_7747).

quantifier(_7698,_7699,_7702::quant(many,_7698)::_7699 and _7702,[quantifier,_7761,_7785,_7809],_7741,_7743) --> 
    aso0(_7761,_7741,_7776),
    many(_7785,_7776,_7800),
    look_ahead_np(_7809,_7800,_7743).

quantifier(_7698,_7699,_7702::quant(most,_7698)::_7699 and _7702,[quantifier,_7761,_7785,_7809],_7741,_7743) --> 
    aso0(_7761,_7741,_7776),
    most(_7785,_7776,_7800),
    look_ahead_np(_7809,_7800,_7743).

quantifier(_7698,_7699,_7702::quant(all,_7698)::_7699 and _7702,[quantifier,lit(alle),_7771],_7740,_7742) --> 
    cc(alle,_7740,_7770),
    look_ahead_np(_7771,_7770,_7742).

quantifier(_7698,_7699,_7702::quant(ge/2,_7698)::_7699 and _7702,[quantifier,_7761,_7785],_7741,_7743) --> 
    several(_7761,_7741,_7776),
    look_ahead_np(_7785,_7776,_7743).

quantifier(_7698,_7699,_7702::quant(count,_7698)::_7699 and _7702,[quantifier,_7772,_7801,_7845],_7752,_7754) --> 
    w(noun(count,_7723,_7724,_7725),_7772,_7752,_7789),
    optional([av],_7801,_7789,_7833),
    look_ahead_np(_7845,_7833,_7754).

few([few,lit(få)],_7715,_7717) --> 
    cc(få,_7715,_7717).

few([few,lit(færre)],_7715,_7717) --> 
    cc(færre,_7715,_7717).

plausible_name(_7702:person,_7702 isa person,_7700,[plausible_name,_7777,_7816,{},!,_7870],_7757,_7759) --> 
    properfirstname(_7720,_7721,_7722,_7777,_7757,_7798),
    properlastname(_7724,_7725,_7700,_7816,_7798,_7837),
    {user:_7702=(_7720,_7724)},
    !,
    accept(_7870,_7837,_7759).

plausible_name(_7702:_7703,_7702 isa _7703,_7700,[plausible_name,_7773,{}],_7753,_7755) --> 
    w(name(_7702,_7700,_7703),_7773,_7753,_7755),
    {user:(\+_7703=0,\+_7703=date)}.

name_compound(_7698,_7699,_7700,[name_compound,_7789,_7818,_7847,_7876,_7915,_7959],_7769,_7771) --> 
    not_look_ahead([dere],_7789,_7769,_7806),
    not_look_ahead([du],_7818,_7806,_7835),
    not_look_ahead(w(nb(_7736,_7737)),_7847,_7835,_7864),
    plausible_name(_7719,_7720,_7741,_7876,_7864,_7897),
    s0(sin,u,_7741,_7717,_7915,_7897,_7938),
    ncomps0(_7717,_7699,_7719,_7720,_7700,_7698,_7959,_7938,_7771).

namep(name,_7702:street,_7702 isa street,[namep,_7792,_7821,_7845,_7874,{},!,_7918],_7772,_7774) --> 
    w(name(_7702,n,street),_7792,_7772,_7809),
    comma0(_7821,_7809,_7836),
    postcode(_7732,_7845,_7836,_7862),
    w(name(_7736,n,_7738),_7874,_7862,_7891),
    {user:testmember(_7738,[neighbourhood,city,station])},
    !,
    accept(_7918,_7891,_7774).

namep(_7698,_7699,_7700,[namep,_7789,_7818,_7847,_7876,_7915,_7959],_7769,_7771) --> 
    not_look_ahead([dere],_7789,_7769,_7806),
    not_look_ahead([du],_7818,_7806,_7835),
    not_look_ahead(w(nb(_7736,_7737)),_7847,_7835,_7864),
    plausible_name(_7719,_7720,_7741,_7876,_7864,_7897),
    s0(sin,u,_7741,_7717,_7915,_7897,_7938),
    ncomps0(_7717,_7699,_7719,_7720,_7700,_7698,_7959,_7938,_7771).

namep(name,_7702:thing,_7702 isa unkn,[namep,{},_7775,_7804],_7745,_7747) --> 
    {user:value(unknownflag,true)},
    unplausible_name(_7714,_7775,_7745,_7792),
    morenames(_7714,_7702,_7804,_7792,_7747).

namep(0,_7699,_7700,[namep,_7746],_7726,_7728) --> 
    measure(_7699,_7700,_7746,_7726,_7728).

namep(name,_7699,_7700,[namep,_7758,_7782],_7738,_7740) --> 
    you(_7758,_7738,_7773),
    pushstack(first,w(name(tuc,n,savant)),nil,_7773,_7792),
    nameq(_7699,_7700,_7782,_7792,_7740).

namep(0,_7699,_7700,[namep,_7761,_7790,!,_7849],_7741,_7743) --> 
    number(_7711,_7761,_7741,_7778),
    noun(_7713,plu,_7715,n,_7717,_7718,_7790,_7778,_7817),
    !,
    reject(_7849,_7817,_7743).

namep(0,_7699,_7700,[namep,_7846,_7870,{},_7929,_7958,_7987,_8021,{},{},_8070,_8099,!,_8133],_7826,_7828) --> 
    athe0(_7846,_7826,_7861),
    noun2(_7738,_7739,n,_7744:_7745,_7742,_7870,_7861,_7895),
    {user:(\+testmember(_7745,[thing]))},
    not_look_ahead([jeg],_7929,_7895,_7946),
    not_look_ahead([du],_7958,_7946,_7975),
    nameq(_7764,_7765,_7987,_7975,_8006),
    not_look_ahead([:],_8021,_8006,_8038),
    {user:compoundtest(_7738,_7739,_7744:_7745,_7764)},
    {user:align_noun_name(_7744:_7745,_7764,_7742,_7699,_7700)},
    optional_suffix(_7744:_7745,_8070,_8038,_8087),
    not_look_ahead(w(name(_7801,_7802,date)),_8099,_8087,_8116),
    !,
    accept(_8133,_8116,_7828).

namep(0,_7699,_7700,[namep,_7788,_7812,_7836,_7870,{},!,{}],_7768,_7770) --> 
    athe0(_7788,_7768,_7803),
    nr0(_7812,_7803,_7827),
    nameq1(_7723,_7729,_7836,_7827,_7855),
    noun(_7731,sin,u,n,_7722,_7724,_7870,_7855,_7770),
    {user:testmember(_7731,[bus,tram])},
    !,
    {user:align_noun_name(_7722,_7723,_7724,_7699,_7700)}.

namep(0,_7699,_7700,[namep,_7789,_7813,_7842,_7876,{},{}],_7769,_7771) --> 
    athe0(_7789,_7769,_7804),
    not_look_ahead([_7726],_7813,_7804,_7830),
    nameq1(_7720,_7730,_7842,_7830,_7861),
    noun(_7732,sin,_7734,n,_7719,_7721,_7876,_7861,_7771),
    {user:(\+testmember(_7732,[thing]))},
    {user:align_noun_name(_7719,_7720,_7721,_7699,_7700)}.

namep(name,_7699,_7700,[namep,_7753,_7782],_7733,_7735) --> 
    not_look_ahead([ett],_7753,_7733,_7770),
    nameq(_7699,_7700,_7782,_7770,_7735).

optional_suffix(_7700:_7701,[optional_suffix,_7755,{},!,_7799],_7741,_7743) --> 
    w(noun(_7714,_7715,_7716,n),_7755,_7741,_7772),
    {user:alignable(_7701,_7714)},
    !,
    accept(_7799,_7772,_7743).

optional_suffix(_7700:_7701,[optional_suffix,_7755,{},!,_7799],_7741,_7743) --> 
    w(noun(_7714,_7715,_7716,n),_7755,_7741,_7772),
    {user:alignable(_7701,_7714)},
    !,
    accept(_7799,_7772,_7743).

optional_suffix(_7700:_7701,[optional_suffix,_7734],_7720,_7722) --> 
    point0(_7734,_7720,_7722).

noun2(sin,u,n,_7704:thing,_7704 isa thing,[noun2,lit(_7719),{},_7805],_7758,_7760) --> 
    cc(_7719,_7758,_7794),
    {user:testmember(_7719,[de,disse,dem])},
    look_ahead([som],_7805,_7794,_7760).

noun2(plu,u,n,_7704:thing,_7704 isa thing,[noun2,lit(_7715),{},_7801],_7754,_7756) --> 
    cc(_7715,_7754,_7790),
    {user:testmember(_7715,[de,disse,dem])},
    not_look_ahead_np(_7801,_7790,_7756).

noun2(sin,u,n,_7704:agent,_7704 isa agent,[noun2,_7768,_7792],_7742,_7744) --> 
    agent_pronoun(_7768,_7742,_7783),
    look_ahead([som],_7792,_7783,_7744).

noun2(sin,u,n,_7704:thing,_7704 isa thing,[noun2,lit(det),_7781],_7744,_7746) --> 
    cc(det,_7744,_7780),
    look_ahead([som],_7781,_7780,_7746).

noun2(_7698,_7699,_7700,_7701,_7702,[noun2,_7795,{},_7859,!,_7888],_7769,_7771) --> 
    noun(_7716,_7698,_7699,_7700,_7701,_7702,_7795,_7769,_7822),
    {user:testmember(_7716,[monday,tuesday,wednesday,thursday,friday,saturday,sunday,month])},
    point0(_7859,_7822,_7874),
    !,
    accept(_7888,_7874,_7771).

noun2(_7698,_7699,_7700,_7704:_7705,_7702,[noun2,_7824,_7853,_7882,_7911,_7940,{},!,_7984],_7798,_7800) --> 
    w(noun(_7730,_7731,u,n),_7824,_7798,_7841),
    not_look_ahead(w(noun(number,sin,_7741,n)),_7853,_7841,_7870),
    not_look_ahead([nr],_7882,_7870,_7899),
    not_look_ahead(w(verb(_7752,_7753,_7754)),_7911,_7899,_7928),
    w(noun(_7758,_7698,_7699,_7700),_7940,_7928,_7957),
    {user:adjnoun_template(_7730,_7758,_7704:_7705,_7702)},
    !,
    accept(_7984,_7957,_7800).

noun2(_7698,_7699,_7700,_7701,_7702,[noun2,_7762],_7736,_7738) --> 
    noun(_7704,_7698,_7699,_7700,_7701,_7702,_7762,_7736,_7738).

noun2(sin,u,n,_7704:thing,_7704 isa thing,[noun2,_7771,_7795,!],_7745,_7747) --> 
    someone(_7771,_7745,_7786),
    look_ahead([som],_7795,_7786,_7747),
    !.

agent_pronoun([agent_pronoun,lit(jeg)],_7715,_7717) --> 
    cc(jeg,_7715,_7717).

agent_pronoun([agent_pronoun,lit(du)],_7715,_7717) --> 
    cc(du,_7715,_7717).

agent_pronoun([agent_pronoun,lit(noen)],_7715,_7717) --> 
    cc(noen,_7715,_7717).

agent_pronoun([agent_pronoun,lit(mange)],_7715,_7717) --> 
    cc(mange,_7715,_7717).

agent_pronoun([agent_pronoun,lit(få)],_7715,_7717) --> 
    cc(få,_7715,_7717).

agent_pronoun([agent_pronoun,lit(han)],_7715,_7717) --> 
    cc(han,_7715,_7717).

agent_pronoun([agent_pronoun,lit(ham)],_7715,_7717) --> 
    cc(ham,_7715,_7717).

agent_pronoun([agent_pronoun,lit(hun)],_7715,_7717) --> 
    cc(hun,_7715,_7717).

agent_pronoun([agent_pronoun,lit(henne)],_7715,_7717) --> 
    cc(henne,_7715,_7717).

agent_pronoun([agent_pronoun,lit(dere)],_7715,_7717) --> 
    cc(dere,_7715,_7717).

agent_pronoun([agent_pronoun,lit(alle)],_7715,_7717) --> 
    cc(alle,_7715,_7717).

noun(_7698,_7699,_7700,_7701,_7705:_7698,_7705 isa _7698,[noun,_7774],_7745,_7747) --> 
    w(noun(_7698,_7699,_7700,_7701),_7774,_7745,_7747).

measure(_7698,_7699,[measure,_7781,{},_7845,_7879,_7903,!,{}],_7764,_7766) --> 
    noun(_7727,_7728,_7729,n,_7721,_7723,_7781,_7764,_7808),
    {user:measureclass(_7727)},
    gmem(_7727,[crown],_7845,_7808,_7864),
    point0(_7879,_7864,_7894),
    anumber(_7722,_7903,_7894,_7766),
    !,
    {user:align_measure(_7721,_7722,_7723,_7698,_7699)}.

measure(_7698,_7699,[measure,_7778,_7807,_7831,_7885,_7909,{},{}],_7761,_7763) --> 
    anumber(_7722,_7778,_7761,_7795),
    point0(_7807,_7795,_7822),
    noun(_7729,_7730,_7731,n,_7721,_7723,_7831,_7822,_7858),
    point0(_7885,_7858,_7900),
    not_overon_clock(_7729,_7909,_7900,_7763),
    {user:measureclass(_7729)},
    {user:align_measure(_7721,_7722,_7723,_7698,_7699)}.

not_overon_clock(_7698,[not_overon_clock,{},_7789,{},_7828,!,_7862],_7765,_7767) --> 
    {user:testmember(_7698,[hour,minute,second])},
    prep1(_7726,_7789,_7765,_7806),
    {user:testmember(_7726,[on,before,over,after])},
    look_ahead(w(nb(_7745,_7746)),_7828,_7806,_7845),
    !,
    reject(_7862,_7845,_7767).

not_overon_clock(_7698,[not_overon_clock,[]],_7717,_7717) --> 
    [].

nameq(_7698,_7699,[nameq,_7750,_7784],_7733,_7735) --> 
    nameq1(_7698,_7699,_7750,_7733,_7769),
    not_look_ahead(w(nb(_7708,_7709)),_7784,_7769,_7735).

nameq(_7698,_7699,[nameq,_7750,_7784],_7733,_7735) --> 
    nameq2(_7698,_7699,_7750,_7733,_7769),
    not_look_ahead(w(nb(_7708,_7709)),_7784,_7769,_7735).

name1g(_7702:lastname,_7702 isa lastname,_7700,[name1g,{},_7801,_7830,_7859,!,_7893],_7771,_7773) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7702,_7733,firstname)),_7801,_7771,_7818),
    w(name(_7702,_7700,lastname),_7830,_7818,_7847),
    not_look_ahead(w(name(_7746,_7747,lastname)),_7859,_7847,_7876),
    !,
    accept(_7893,_7876,_7773).

name1g(_7702:firstname,_7702 isa firstname,n,[name1g,{},_7801,_7830,_7859,!,_7893],_7771,_7773) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7702,_7733,lastname)),_7801,_7771,_7818),
    w(name(_7702,n,firstname),_7830,_7818,_7847),
    look_ahead(w(name(_7746,_7747,lastname)),_7859,_7847,_7876),
    !,
    accept(_7893,_7876,_7773).

name1g(_7702:lastname,_7702 isa lastname,_7700,[name1g,{},_7801,_7830,_7859,!,_7893],_7771,_7773) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7702,_7733,firstname)),_7801,_7771,_7818),
    w(name(_7702,_7700,lastname),_7830,_7818,_7847),
    not_look_ahead(w(name(_7746,n,lastname)),_7859,_7847,_7876),
    !,
    accept(_7893,_7876,_7773).

name1g(_7702:firstname,_7702 isa firstname,n,[name1g,{},_7801,_7830,_7859,!,_7893],_7771,_7773) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7702,_7733,lastname)),_7801,_7771,_7818),
    w(name(_7702,n,firstname),_7830,_7818,_7847),
    look_ahead(w(name(_7746,n,lastname)),_7859,_7847,_7876),
    !,
    accept(_7893,_7876,_7773).

name1g(_7702:_7703,_7702 isa _7703,_7700,[name1g,_7756],_7736,_7738) --> 
    wnameg(_7702:_7703,_7700,_7703,_7756,_7736,_7738).

wnameg(_7702:_7700,gen,_7700,[wnameg,_7758,_7787,!],_7738,_7740) --> 
    w(name(_7702,n,_7700),_7758,_7738,_7775),
    sin(_7787,_7775,_7740),
    !.

wnameg(_7702:_7700,gen,_7700,[wnameg,_7758,_7787,!],_7738,_7740) --> 
    w(name(_7702,gen,_7700),_7758,_7738,_7775),
    sin(_7787,_7775,_7740),
    !.

wnameg(_7702:_7700,gen,_7700,[wnameg,_7755,!],_7735,_7737) --> 
    w(name(_7702,gen,_7700),_7755,_7735,_7737),
    !.

wnameg(_7702:_7700,n,_7700,[wnameg,_7752],_7732,_7734) --> 
    w(name(_7702,n,_7700),_7752,_7732,_7734).

nameq1(_7701:lastname,_7701 isa lastname,[nameq1,{},_7795,_7824,_7853,!,_7887],_7768,_7770) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7701,n,firstname)),_7795,_7768,_7812),
    w(name(_7701,n,lastname),_7824,_7812,_7841),
    not_look_ahead(w(name(_7745,n,lastname)),_7853,_7841,_7870),
    !,
    accept(_7887,_7870,_7770).

nameq1(_7701:firstname,_7701 isa firstname,[nameq1,{},_7795,_7824,_7853,!,_7887],_7768,_7770) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_7701,n,lastname)),_7795,_7768,_7812),
    w(name(_7701,n,firstname),_7824,_7812,_7841),
    look_ahead(w(name(_7745,n,lastname)),_7853,_7841,_7870),
    !,
    accept(_7887,_7870,_7770).

nameq1(quote(_7707):_7705,quote(_7707)isa thing,[nameq1,_7762,!,{}],_7745,_7747) --> 
    w(quote(_7707),_7762,_7745,_7747),
    !,
    {user:type(thing,_7705)}.

nameq1(_7698,_7699,[nameq1,_7751,_7780,_7804,!,_7833],_7734,_7736) --> 
    number(_7713,_7751,_7734,_7768),
    point0(_7780,_7768,_7795),
    monthnamex(_7804,_7795,_7819),
    !,
    reject(_7833,_7819,_7736).

nameq1(_7698,_7699,[nameq1,_7755,_7784,!,_7818],_7738,_7740) --> 
    number(_7710,_7755,_7738,_7772),
    w(noun(hour,_7715,_7716,_7717),_7784,_7772,_7801),
    !,
    reject(_7818,_7801,_7740).

nameq1(_7698,_7699,[nameq1,_7758,_7787,_7811,!,_7845],_7741,_7743) --> 
    number(_7713,_7758,_7741,_7775),
    point(_7787,_7775,_7802),
    w(noun(_7717,_7718,_7719,_7720),_7811,_7802,_7828),
    !,
    reject(_7845,_7828,_7743).

nameq1(_7698,_7699,[nameq1,_7746,!,_7785],_7729,_7731) --> 
    obviousclock1(_7698,_7699,_7746,_7729,_7765),
    !,
    accept(_7785,_7765,_7731).

nameq1(_7701:_7705,_7701 isa clock,[nameq1,_7759,_7783,!,{}],_7742,_7744) --> 
    clock0(_7759,_7742,_7774),
    time2(_7701,_7783,_7774,_7744),
    !,
    {user:type(clock,_7705)}.

nameq1(_7701:_7705,_7701 isa clock,[nameq1,_7752],_7735,_7737) --> 
    plausibleclock1(_7701:_7705,_7701 isa clock,_7752,_7735,_7737).

nameq1(_7698,_7699,[nameq1,_7740],_7723,_7725) --> 
    date(_7698,_7699,_7740,_7723,_7725).

nameq1(_7701:_7702,_7699,[nameq1,_7756,_7780,!,_7814],_7739,_7741) --> 
    one(_7756,_7739,_7771),
    w(noun(_7715,sin,u,n),_7780,_7771,_7797),
    !,
    reject(_7814,_7797,_7741).

nameq1(_7701:_7705,_7701 isa _7702,[nameq1,_7786,{},{},_7835,!,_7869],_7769,_7771) --> 
    w(name(_7701,_7725,_7702),_7786,_7769,_7803),
    {user:atom(_7701)},
    {user:testmember(_7702,[language,colour])},
    look_ahead(w(noun(_7745,_7746,_7747,_7748)),_7835,_7803,_7852),
    !,
    reject(_7869,_7852,_7771).

nameq1(_7701:_7705,_7701 isa _7702,[nameq1,_7800,_7829,{},{},{},{}],_7783,_7785) --> 
    not_look_ahead(w(name,_7730,gen,_7732),_7800,_7783,_7817),
    w(name(_7701,_7737,_7702),_7829,_7817,_7785),
    {user:_7701\==1},
    {user:(_7702==unkn->value(unknownflag,true);true)},
    {user:_7737\==gen},
    {user:type(_7702,_7705)}.

nameq1(_7701:_7705,_7701 isa _7702,[nameq1,_7795,_7819,_7848,_7872,{},{},{}],_7778,_7780) --> 
    nr0(_7795,_7778,_7810),
    w(name(_7701,n,_7702),_7819,_7810,_7836),
    point0(_7848,_7836,_7863),
    not_look_ahead(w(name(_7740,_7741,date)),_7872,_7863,_7780),
    {user:(_7702==unkn->value(unknownflag,true))},
    {user:number(_7701)},
    {user:type(_7702,_7705)}.

nameq1(_7701:_7702,_7699,[nameq1,_7759,{}],_7742,_7744) --> 
    timeq1(_7701:_7702,_7699,_7759,_7742,_7744),
    {user:(number(_7701),_7701>=100)}.

nameq1(_7701:year,_7701 isa year,[nameq1,_7767,{}],_7750,_7752) --> 
    w(nb(_7701,num),_7767,_7750,_7752),
    {user:(number(_7701),_7701>=1900,_7701=<2099)}.

date(_7701:date,_7701 isa date,[date,_7829,{},_7868,_7892,!,{},{},{},{}],_7812,_7814) --> 
    num_na(_7740,_7829,_7812,_7846),
    {user:(_7740>=1,_7740=<7)},
    slashpoint0(_7868,_7846,_7883),
    w(name(new_years_day,n,date),_7892,_7883,_7814),
    !,
    {user:datetime(_7761,_7762,_7763,_7764,_7765,_7766)},
    {user:(_7762>1->_7736 is _7761+1;_7736 is _7761)},
    {user:_7738 is _7740},
    {user:_7701=date(_7736,1,_7738)}.

date(_7701:date,_7701 isa date,[date,_7820,{},_7859,_7883,{},!,{}],_7803,_7805) --> 
    num_na(_7737,_7820,_7803,_7837),
    {user:(_7737>=1,_7737=<7)},
    slashpoint0(_7859,_7837,_7874),
    w(name(_7752,n,date),_7883,_7874,_7805),
    {user:testmember(_7752,[whitsun_day,easterday,christmas_day])},
    !,
    {user:(named_date(_7752,date(_7770,_7771,_7772)),_7734 is _7737-1,add_days(date(_7770,_7771,_7772),_7734,_7701))}.

date(_7701:date,_7701 isa date,[date,_7776,_7805,_7829,_7858,_7882,!,{}],_7759,_7761) --> 
    dayno(_7732,_7776,_7759,_7793),
    slashpoint0(_7805,_7793,_7820),
    month(_7731,_7829,_7820,_7846),
    slashpoint0(_7858,_7846,_7873),
    year(_7730,_7882,_7873,_7761),
    !,
    {user:_7701=date(_7730,_7731,_7732)}.

date(_7701:date,_7701 isa date,[date,_7791,_7820,_7844,_7873,{},!,_7912,{}],_7774,_7776) --> 
    dayno(_7735,_7791,_7774,_7808),
    slashpoint(_7820,_7808,_7835),
    month(_7734,_7844,_7835,_7861),
    point0(_7873,_7861,_7888),
    {user:(_7735>24;_7734>0)},
    !,
    xyear0(_7734,_7733,_7912,_7888,_7776),
    {user:_7701=date(_7733,_7734,_7735)}.

date(_7701:date,_7701 isa date,[date,_7777,_7806,_7830,_7859,!,_7898,{}],_7760,_7762) --> 
    dayno(_7732,_7777,_7760,_7794),
    slashpoint0(_7806,_7794,_7821),
    monthname(_7731,_7830,_7821,_7847),
    xyear0(_7731,_7730,_7859,_7847,_7878),
    !,
    accept(_7898,_7878,_7762),
    {user:_7701=date(_7730,_7731,_7732)}.

date(_7701:date,_7701 isa date,[date,_7779,_7808,_7837,!,_7871,{},!,_7910],_7762,_7764) --> 
    year(_7728,_7779,_7762,_7796),
    month(_7730,_7808,_7796,_7825),
    dayno(_7732,_7837,_7825,_7854),
    !,
    accept(_7871,_7854,_7886),
    {user:_7701=date(_7728,_7730,_7732)},
    !,
    accept(_7910,_7886,_7764).

timeq1(_7701:clock,_7701 isa clock,[timeq1,lit(halv),_7781,{},!,_7825],_7753,_7755) --> 
    cc(halv,_7753,_7780),
    hours(_7721,_7781,_7780,_7798),
    {user:_7701 is _7721*100-70},
    !,
    accept(_7825,_7798,_7755).

timeq1(_7701:clock,_7701 isa clock,[timeq1,_7751,!,_7785],_7734,_7736) --> 
    time12(_7701,_7751,_7734,_7768),
    !,
    accept(_7785,_7768,_7736).

clock_sequel(_7701:clock,_7701 isa clock,[clock_sequel,_7755,!],_7738,_7740) --> 
    clock_kernel(_7701:clock,_7701 isa clock,_7755,_7738,_7740),
    !.

clock_sequel(_7701:clock,_7701 isa clock,[clock_sequel,_7799,{},_7838,_7867,_7891,{},!,{}],_7782,_7784) --> 
    w(nb(_7738,num),_7799,_7782,_7816),
    {user:_7738<100},
    not_look_ahead([/],_7838,_7816,_7855),
    point(_7867,_7855,_7882),
    w(nb(_7734,num),_7891,_7882,_7784),
    {user:_7734<100},
    !,
    {user:_7701 is _7738*100+_7734}.

clock_sequel(_7701:clock,_7701 isa clock,[clock_sequel,_7784,_7813,{}],_7767,_7769) --> 
    w(nb(_7719,num),_7784,_7767,_7801),
    not_look_ahead([/],_7813,_7801,_7769),
    {user:(_7719>0,_7719<25->_7701 is _7719*100;_7701 is _7719)}.

clock_kernel(_7701:clock,_7701 isa clock,[clock_kernel,_7766,{},!],_7749,_7751) --> 
    number(_7701:_7716,_7766,_7749,_7751),
    {user:(_7701>2500,\+clock_test(_7701))},
    !.

clock_kernel(_7698,_7699,[clock_kernel,lit(nå),!,_7761],_7728,_7730) --> 
    cc(nå,_7728,_7755),
    !,
    reject(_7761,_7755,_7730).

clock_kernel(_7698,_7699,[clock_kernel,lit(en),!,_7761],_7728,_7730) --> 
    cc(en,_7728,_7755),
    !,
    reject(_7761,_7755,_7730).

clock_kernel(_7698,_7699,[clock_kernel,lit(et),!,_7761],_7728,_7730) --> 
    cc(et,_7728,_7755),
    !,
    reject(_7761,_7755,_7730).

clock_kernel(_7701:clock,_7701 isa clock,[clock_kernel,_7827,_7856,_7885,{},_7924,_7953,_7982,_8011,!,_8060],_7810,_7812) --> 
    not_look_ahead(w(name(_7738,n,route)),_7827,_7810,_7844),
    not_look_ahead(w(name(_7746,n,nightbus)),_7856,_7844,_7873),
    w(nb(_7701,num),_7885,_7873,_7902),
    {user:(_7701>=100,clock_test(_7701))},
    not_look_ahead(w(noun(_7769,plu,_7771,_7772)),_7924,_7902,_7941),
    not_look_ahead([tusen],_7953,_7941,_7970),
    not_look_ahead([millioner],_7982,_7970,_7999),
    optional(w(noun(time,sin,def,n)),_8011,_7999,_8043),
    !,
    accept(_8060,_8043,_7812).

clock_kernel(_7698,_7699,[clock_kernel,_7753,_7782,_7806,!,_7840],_7736,_7738) --> 
    num_na(_7713,_7753,_7736,_7770),
    point0(_7782,_7770,_7797),
    monthname(_7715,_7806,_7797,_7823),
    !,
    reject(_7840,_7823,_7738).

clock_kernel(_7701:clock,_7701 isa clock,[clock_kernel,{},_7786,_7815,_7844,!,_7878],_7759,_7761) --> 
    {user:value(busflag,true)},
    hours(_7730,_7786,_7759,_7803),
    colemin0(_7732,_7815,_7803,_7832),
    w(name(_7736,_7737,month),_7844,_7832,_7861),
    !,
    reject(_7878,_7861,_7761).

clock_kernel(_7701:clock,_7701 isa clock,[clock_kernel,{},_7788,_7817,{},!,_7861],_7761,_7763) --> 
    {user:value(busflag,true)},
    hours(_7730,_7788,_7761,_7805),
    colemin0(_7732,_7817,_7805,_7834),
    {user:dedicated_date(date(_7738,_7730,_7732))},
    !,
    reject(_7861,_7834,_7763).

clock_kernel(_7698,_7699,[clock_kernel,_7766,_7795,_7824,{},!,_7868],_7749,_7751) --> 
    hours(_7716,_7766,_7749,_7783),
    colemin2(_7718,_7795,_7783,_7812),
    w(nb(_7722,num),_7824,_7812,_7841),
    {user:_7722>=60},
    !,
    reject(_7868,_7841,_7751).

clock_kernel(_7701:clock,_7701 isa clock,[clock_kernel,_7779,_7808,!,_7842,{}],_7762,_7764) --> 
    hours24(_7727,_7779,_7762,_7796),
    colemin2(_7725,_7808,_7796,_7825),
    !,
    optional(w(noun(time,sin,def,n)),_7842,_7825,_7764),
    {user:_7701 is _7727*100+_7725}.

clock_kernel(_7701:clock,_7701 isa clock,[clock_kernel,_7751,!,_7785],_7734,_7736) --> 
    time012(_7701,_7751,_7734,_7768),
    !,
    accept(_7785,_7768,_7736).

clock_kernel(_7701:clock,_7701 isa clock,[clock_kernel,_7745],_7728,_7730) --> 
    timeoff(_7701,_7745,_7728,_7730).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(et)],_7728,_7730) --> 
    cc(et,_7728,_7730).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(en)],_7728,_7730) --> 
    cc(en,_7728,_7730).

clock_kernel(_7701:clock,_7701 isa clock,[clock_kernel,_7801,{},_7840,_7869,{}],_7784,_7786) --> 
    w(nb(_7726,num),_7801,_7784,_7818),
    {user:_7726>9},
    not_look_ahead(w(noun(minute,_7739,_7740,_7741)),_7840,_7818,_7857),
    not_look_ahead([/],_7869,_7857,_7786),
    {user:(_7726>0,_7726<25->_7701 is _7726*100;fail)}.

namenb(1,[namenb,lit(ett),_7760,!,_7794],_7735,_7737) --> 
    cc(ett,_7735,_7759),
    w(noun(_7713,_7714,_7715,_7716),_7760,_7759,_7777),
    !,
    reject(_7794,_7777,_7737).

namenb(1,[namenb,lit(ett),!,_7755],_7725,_7727) --> 
    cc(ett,_7725,_7749),
    !,
    accept(_7755,_7749,_7727).

namenb(_7698,[namenb,_7737,!,_7766],_7723,_7725) --> 
    a(_7737,_7723,_7752),
    !,
    reject(_7766,_7752,_7725).

namenb(_7698,[namenb,_7737],_7723,_7725) --> 
    w(name(_7698,n,_7704),_7737,_7723,_7725).

namenb(_7698,[namenb,_7736],_7722,_7724) --> 
    w(nb(_7698,num),_7736,_7722,_7724).

dayno(_7698,[dayno,_7747,{}],_7733,_7735) --> 
    num_na(_7698,_7747,_7733,_7735),
    {user:(_7698>0,_7698=<31)}.

month(_7698,[month,_7736,!],_7722,_7724) --> 
    monthnamed(_7698,_7736,_7722,_7724),
    !.

month(_7698,[month,_7733],_7719,_7721) --> 
    monthnum(_7698,_7733,_7719,_7721).

monthnamed(_7698,[monthnamed,_7739,_7768,!],_7725,_7727) --> 
    monthname(_7698,_7739,_7725,_7756),
    point0(_7768,_7756,_7727),
    !.

monthname(_7698,[monthname,_7745,{}],_7731,_7733) --> 
    w(name(_7705,n,_7712),_7745,_7731,_7733),
    {user:monthnumber(_7705,_7698)}.

monthnum(_7698,[monthnum,_7750,{}],_7736,_7738) --> 
    number(_7698:_7714,_7750,_7736,_7738),
    {user:(_7698>0,_7698=<12)}.

monthnamex([monthnamex,_7726],_7715,_7717) --> 
    monthname(_7698,_7726,_7715,_7717).

monthnamex([monthnamex,_7738,{}],_7727,_7729) --> 
    w(name(_7703,_7709,_7710),_7738,_7727,_7729),
    {user:named_date(_7703,_7704)}.

day(_7698,[day,_7745,{}],_7731,_7733) --> 
    w(noun(_7698,_7710,_7711,_7712),_7745,_7731,_7733),
    {user:dayname(_7698)}.

day(weekday,[day,_7738],_7724,_7726) --> 
    w(noun(weekday,_7703,_7704,_7705),_7738,_7724,_7726).

xyear0(_7698,_7699,[xyear0,_7748,_7772,!,_7806],_7731,_7733) --> 
    aar0(_7748,_7731,_7763),
    year(_7699,_7772,_7763,_7789),
    !,
    accept(_7806,_7789,_7733).

xyear0(_7698,_7699,[xyear0,{},{}],_7733,_7733) --> 
    {user:this_year(_7707)},
    {user:adjust_year(_7698,_7707,_7699)}.

year0(_7698,[year0,_7742,_7766,!,_7800],_7728,_7730) --> 
    aar0(_7742,_7728,_7757),
    year(_7698,_7766,_7757,_7783),
    !,
    accept(_7800,_7783,_7730).

year0(_7698,[year0,{}],_7721,_7721) --> 
    {user:this_year(_7698)}.

aar0([aar0,_7737,_7761,!],_7726,_7728) --> 
    point0(_7737,_7726,_7752),
    w(noun(year,_7707,_7708,n),_7761,_7752,_7728),
    !.

aar0([aar0,_7724],_7713,_7715) --> 
    point0(_7724,_7713,_7715).

year(_7698,[year,{},_7777,{},!,_7821],_7753,_7755) --> 
    {user:value(busflag,true)},
    number(_7698:_7723,_7777,_7753,_7794),
    {user:(_7698>=2000,_7698=<9999)},
    !,
    accept(_7821,_7794,_7755).

year(_7698,[year,_7756,{},!,_7800],_7742,_7744) --> 
    number(_7698:_7712,_7756,_7742,_7773),
    {user:(_7698>=1000,_7698=<9999)},
    !,
    accept(_7800,_7773,_7744).

year(_7698,[year,_7767,{},!,_7811,{}],_7753,_7755) --> 
    number(_7717:_7723,_7767,_7753,_7784),
    {user:(_7717>=0,_7717=<99)},
    !,
    accept(_7811,_7784,_7755),
    {user:_7698 is _7717+2000}.

timexp(_7698,[timexp,_7736,_7760],_7722,_7724) --> 
    clock0(_7736,_7722,_7751),
    time2(_7698,_7760,_7751,_7724).

timexp(_7698,[timexp,_7736,_7760],_7722,_7724) --> 
    clock0(_7736,_7722,_7751),
    time1(_7698,_7760,_7751,_7724).

timenexp(_7698,[timenexp,_7736,_7760],_7722,_7724) --> 
    clock(_7736,_7722,_7751),
    time2(_7698,_7760,_7751,_7724).

timenexp(_7698,[timenexp,_7736,_7760],_7722,_7724) --> 
    clock(_7736,_7722,_7751),
    time1(_7698,_7760,_7751,_7724).

clock_time(1300,[clock_time,_7737,!,_7766],_7723,_7725) --> 
    a(_7737,_7723,_7752),
    !,
    accept(_7766,_7752,_7725).

clock_time(1300,[clock_time,lit(nå),!,_7755],_7725,_7727) --> 
    cc(nå,_7725,_7749),
    !,
    reject(_7755,_7749,_7727).

clock_time(_7698,[clock_time,_7758,_7787,{},_7826],_7744,_7746) --> 
    hours(_7712,_7758,_7744,_7775),
    colemin0(_7714,_7787,_7775,_7804),
    {user:_7709 is _7712*100+_7714},
    ampm0(_7709,_7698,_7826,_7804,_7746).

clock_time(_7698,[clock_time,_7733],_7719,_7721) --> 
    time12(_7698,_7733,_7719,_7721).

time012(_7698,[time012,_7733],_7719,_7721) --> 
    time12(_7698,_7733,_7719,_7721).

time012(_7698,[time012,_7786,{},_7825,_7854,{}],_7772,_7774) --> 
    w(nb(_7723,num),_7786,_7772,_7803),
    {user:_7723>1},
    not_look_ahead(w(noun(minute,_7741,_7742,_7743)),_7825,_7803,_7842),
    not_look_ahead([/],_7854,_7842,_7774),
    {user:(_7723>0,_7723<25,_7698 is _7723*100)}.

time012(100,[time012,_7749,_7778,_7807,!],_7735,_7737) --> 
    w(nb(1,num),_7749,_7735,_7766),
    not_look_ahead([/],_7778,_7766,_7795),
    not_look_ahead_np(_7807,_7795,_7737),
    !.

time12(_7698,[time12,_7743,_7772],_7729,_7731) --> 
    time2(_7698,_7743,_7729,_7760),
    w(noun(time,sin,def,n),_7772,_7760,_7731).

time12(_7698,[time12,_7733],_7719,_7721) --> 
    time2(_7698,_7733,_7719,_7721).

time12(_7698,[time12,_7746,_7775,_7799],_7732,_7734) --> 
    time1(_7698,_7746,_7732,_7763),
    point0(_7775,_7763,_7790),
    w(noun(time,sin,def,n),_7799,_7790,_7734).

timeoff(_7698,[timeoff,_7777,{},_7816,_7840,{},{}],_7763,_7765) --> 
    w(nb(_7725,num),_7777,_7763,_7794),
    {user:_7725<100},
    colon0(_7816,_7794,_7831),
    w(nb(_7721,num),_7840,_7831,_7765),
    {user:_7721<100},
    {user:_7698 is _7725*100+_7721}.

time1(_7698,[time1,_7742,!,_7776],_7728,_7730) --> 
    w(nb(0,_7709),_7742,_7728,_7759),
    !,
    reject(_7776,_7759,_7730).

time1(_7698,[time1,lit(ett),_7772,_7801,!,_7835],_7747,_7749) --> 
    cc(ett,_7747,_7771),
    not_look_ahead(w(noun(time,_7719,def,_7721)),_7772,_7771,_7789),
    w(noun(_7725,_7726,_7727,_7728),_7801,_7789,_7818),
    !,
    reject(_7835,_7818,_7749).

time1(100,[time1,lit(ett),_7762,!,_7811],_7737,_7739) --> 
    cc(ett,_7737,_7761),
    optional(w(noun(time,_7716,def,_7718)),_7762,_7761,_7794),
    !,
    accept(_7811,_7794,_7739).

time1(_7698,[time1,_7749,_7773,!,_7807],_7735,_7737) --> 
    a(_7749,_7735,_7764),
    not_look_ahead(w(noun(time,_7714,def,_7716)),_7773,_7764,_7790),
    !,
    reject(_7807,_7790,_7737).

time1(_7698,[time1,_7745,_7774,!,_7813],_7731,_7733) --> 
    time3(_7709,_7745,_7731,_7762),
    ampm0(_7709,_7698,_7774,_7762,_7793),
    !,
    accept(_7813,_7793,_7733).

time1(_7698,[time1,_7783,_7812,_7841,{},!,{},_7895],_7769,_7771) --> 
    w(nb(_7723,num),_7783,_7769,_7800),
    not_look_ahead(w(noun(hour,_7731,_7732,_7733)),_7812,_7800,_7829),
    not_look_ahead([t],_7841,_7829,_7858),
    {user:_7723<25},
    !,
    {user:_7718 is _7723*100},
    ampm0(_7718,_7698,_7895,_7858,_7771).

time1(now,[time1,lit(nå),lit(av),!,_7771],_7730,_7732) --> 
    cc(nå,_7730,_7754),
    cc(av,_7754,_7765),
    !,
    reject(_7771,_7765,_7732).

time1(now,[time1,lit(nå)],_7719,_7721) --> 
    cc(nå,_7719,_7721).

time2(_7698,[time2,_7783,{},_7822,_7846,{},!,_7890,{}],_7769,_7771) --> 
    hours24(_7729,_7783,_7769,_7800),
    {user:_7729=<25},
    point(_7822,_7800,_7837),
    num(_7727,_7846,_7837,_7863),
    {user:(_7727>12,_7727<60)},
    !,
    accept(_7890,_7863,_7771),
    {user:_7698 is _7729*100+_7727}.

time2(_7698,[time2,_7767,_7796,!,{},_7840,{}],_7753,_7755) --> 
    num(_7721,_7767,_7753,_7784),
    w(prep(over),_7796,_7784,_7813),
    !,
    {user:_7721<60},
    hours30(_7720,_7840,_7813,_7755),
    {user:_7698 is _7720+_7721}.

time2(_7698,[time2,_7766,_7795,_7819,!,{},_7858,{}],_7752,_7754) --> 
    num(_7724,_7766,_7752,_7783),
    minutes(_7795,_7783,_7810),
    overclock(_7819,_7810,_7834),
    !,
    {user:_7724<60},
    hours30(_7723,_7858,_7834,_7754),
    {user:_7698 is _7723+_7724}.

time2(_7698,[time2,_7765,{},_7804,!,_7838,{}],_7751,_7753) --> 
    num(_7718,_7765,_7751,_7782),
    {user:_7718<60},
    w(prep(on),_7804,_7782,_7821),
    !,
    hours30(_7717,_7838,_7821,_7753),
    {user:subfromtime(_7717,_7718,_7698)}.

time2(_7698,[time2,_7767,_7796,_7820,!,{},_7859,_7883,{}],_7753,_7755) --> 
    num(_7724,_7767,_7753,_7784),
    minutes(_7796,_7784,_7811),
    onclock(_7820,_7811,_7835),
    !,
    {user:_7724<60},
    clock0(_7859,_7835,_7874),
    hours30(_7723,_7883,_7874,_7755),
    {user:subfromtime(_7723,_7724,_7698)}.

time2(_7698,[time2,_7773,lit(halv),_7828,{},_7867],_7759,_7761) --> 
    optional(w(prep(in)),_7773,_7759,_7805),
    cc(halv,_7805,_7827),
    hours100(_7729,_7828,_7827,_7845),
    {user:_7698 is _7729-100+30},
    optional(w(noun(time,sin,def,n)),_7867,_7845,_7761).

time2(_7698,[time2,lit(halv),_7768,!,_7802,{}],_7743,_7745) --> 
    cc(halv,_7743,_7767),
    prep1(over,_7768,_7767,_7785),
    !,
    hours100(_7717,_7802,_7785,_7745),
    {user:_7698 is _7717+30}.

time2(_7698,[time2,lit(kvart),_7766,_7790,{}],_7741,_7743) --> 
    cc(kvart,_7741,_7765),
    onclock(_7766,_7765,_7781),
    hours100(_7719,_7790,_7781,_7743),
    {user:_7698 is _7719-100+45}.

time2(_7698,[time2,lit(kvart),_7766,_7790,{}],_7741,_7743) --> 
    cc(kvart,_7741,_7765),
    overclock(_7766,_7765,_7781),
    hours(_7719,_7790,_7781,_7743),
    {user:_7698 is _7719*100+15}.

time2(_7698,[time2,_7760,_7789,_7818,{},!,_7862],_7746,_7748) --> 
    hours(_7715,_7760,_7746,_7777),
    minutes(_7717,_7789,_7777,_7806),
    number(_7721:_7722,_7818,_7806,_7835),
    {user:_7721>24},
    !,
    reject(_7862,_7835,_7748).

time2(_7698,[time2,_7753,_7782,_7811,!,_7845],_7739,_7741) --> 
    hours(_7712,_7753,_7739,_7770),
    minutes(_7714,_7782,_7770,_7799),
    w(name(_7718,_7719,month),_7811,_7799,_7828),
    !,
    reject(_7845,_7828,_7741).

time2(_7698,[time2,_7758,_7787,{},_7826],_7744,_7746) --> 
    hours24(_7712,_7758,_7744,_7775),
    colemin(_7714,_7787,_7775,_7804),
    {user:_7709 is _7712*100+_7714},
    ampm0(_7709,_7698,_7826,_7804,_7746).

time2(_7698,[time2,_7752,_7781,_7810,_7834,!,_7868],_7738,_7740) --> 
    hours(_7715,_7752,_7738,_7769),
    minutes(_7717,_7781,_7769,_7798),
    point(_7810,_7798,_7825),
    minutes(_7719,_7834,_7825,_7851),
    !,
    reject(_7868,_7851,_7740).

time2(_7698,[time2,_7766,_7795,{},{},_7844],_7752,_7754) --> 
    hours24(_7715,_7766,_7752,_7783),
    minutes(_7717,_7795,_7783,_7812),
    {user:_7717>12},
    {user:_7712 is _7715*100+_7717},
    ampm0(_7712,_7698,_7844,_7812,_7754).

onclock([onclock,_7743,{},_7782],_7732,_7734) --> 
    w(prep(_7706),_7743,_7732,_7760),
    {user:testmember(_7706,[on,before])},
    clock0(_7782,_7760,_7734).

overclock([overclock,_7743,{},_7782],_7732,_7734) --> 
    w(prep(_7706),_7743,_7732,_7760),
    {user:testmember(_7706,[over,after])},
    clock0(_7782,_7760,_7734).

hours30(_7698,[hours30,lit(halv),_7769,{},!,_7813],_7744,_7746) --> 
    cc(halv,_7744,_7768),
    hours(_7714,_7769,_7768,_7786),
    {user:_7698 is _7714*100-70},
    !,
    accept(_7813,_7786,_7746).

hours30(_7698,[hours30,_7733],_7719,_7721) --> 
    hours100(_7698,_7733,_7719,_7721).

hours100(_7698,[hours100,_7744,_7773,!,_7807],_7730,_7732) --> 
    num(_7698,_7744,_7730,_7761),
    monthname(_7711,_7773,_7761,_7790),
    !,
    reject(_7807,_7790,_7732).

hours100(_7698,[hours100,_7765,{},!,_7809],_7751,_7753) --> 
    num(_7698,_7765,_7751,_7782),
    {user:(_7698 is _7698//100*100,_7698>100,_7698<2500)},
    !,
    accept(_7809,_7782,_7753).

hours100(_7698,[hours100,_7744,{}],_7730,_7732) --> 
    hours(_7708,_7744,_7730,_7732),
    {user:_7698 is _7708*100}.

hours100(100,[hours100,lit(ett),!,_7755],_7725,_7727) --> 
    cc(ett,_7725,_7749),
    !,
    accept(_7755,_7749,_7727).

hours100(1300,[hours100,lit(et),!,_7755],_7725,_7727) --> 
    cc(et,_7725,_7749),
    !,
    accept(_7755,_7749,_7727).

time3(_7698,[time3,_7744,{}],_7730,_7732) --> 
    w(nb(_7698,num),_7744,_7730,_7732),
    {user:_7698>=60}.

ampm0(_7698,_7698,[ampm0,_7743,!,_7772],_7726,_7728) --> 
    amtime(_7743,_7726,_7758),
    !,
    accept(_7772,_7758,_7728).

ampm0(_7698,_7699,[ampm0,_7763,!,{}],_7746,_7748) --> 
    pmtime(_7763,_7746,_7748),
    !,
    {user:(_7698>1200->_7699 is _7698;_7699 is _7698+1200)}.

ampm0(_7698,_7698,[ampm0,lit(h),!],_7725,_7727) --> 
    cc(h,_7725,_7727),
    !.

ampm0(_7698,_7698,[ampm0,[]],_7720,_7720) --> 
    [].

amtime([amtime,lit(am)],_7715,_7717) --> 
    cc(am,_7715,_7717).

amtime([amtime,lit(a),lit(m)],_7720,_7722) --> 
    cc(a,_7720,_7741),
    cc(m,_7741,_7722).

pmtime([pmtime,lit(pm)],_7715,_7717) --> 
    cc(pm,_7715,_7717).

pmtime([pmtime,lit(p),lit(m)],_7720,_7722) --> 
    cc(p,_7720,_7741),
    cc(m,_7741,_7722).

hours24(_7698,[hours24,_7733],_7719,_7721) --> 
    hours(_7698,_7733,_7719,_7721).

hours(_7698,[hours,_7751,_7780,_7809,!,_7838],_7737,_7739) --> 
    not_look_ahead([ett],_7751,_7737,_7768),
    not_look_ahead([et],_7780,_7768,_7797),
    a(_7809,_7797,_7824),
    !,
    reject(_7838,_7824,_7739).

hours(_7698,[hours,_7751,{},_7790],_7737,_7739) --> 
    w(nb(_7698,num),_7751,_7737,_7768),
    {user:_7698=<25},
    optional([h],_7790,_7768,_7739).

smallhours(_7698,[smallhours,_7750,{}],_7736,_7738) --> 
    w(nb(_7698,num),_7750,_7736,_7738),
    {user:(_7698>31,_7698=<59)}.

minutes0([minutes0,_7730,!,_7759],_7719,_7721) --> 
    minutes(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

minutes0([minutes0,[]],_7713,_7713) --> 
    [].

minutes([minutes,_7737,!,_7771],_7726,_7728) --> 
    w(noun(minute,_7707,_7708,_7709),_7737,_7726,_7754),
    !,
    accept(_7771,_7754,_7728).

colemin0(_7698,[colemin0,_7739,!,_7773],_7725,_7727) --> 
    colemin(_7698,_7739,_7725,_7756),
    !,
    accept(_7773,_7756,_7727).

colemin0(_7698,[colemin0,_7742,_7766,!,_7800],_7728,_7730) --> 
    point0(_7742,_7728,_7757),
    minutes0(_7698,_7766,_7757,_7783),
    !,
    accept(_7800,_7783,_7730).

colemin2(_7698,[colemin2,_7747,_7776,_7800,!,_7834],_7733,_7735) --> 
    minutes(_7712,_7747,_7733,_7764),
    point(_7776,_7764,_7791),
    minutes(_7714,_7800,_7791,_7817),
    !,
    reject(_7834,_7817,_7735).

colemin2(_7698,[colemin2,_7745,_7769,_7798,!,_7827],_7731,_7733) --> 
    colon(_7745,_7731,_7760),
    minutes(_7698,_7769,_7760,_7786),
    colesec0(_7798,_7786,_7813),
    !,
    accept(_7827,_7813,_7733).

colemin2(_7698,[colemin2,_7745,_7769,!,_7803],_7731,_7733) --> 
    colon(_7745,_7731,_7760),
    w(nb(_7698,num),_7769,_7760,_7786),
    !,
    reject(_7803,_7786,_7733).

colemin2(0,[colemin2,_7737,!,_7766],_7723,_7725) --> 
    colon(_7737,_7723,_7752),
    !,
    accept(_7766,_7752,_7725).

colemin2(_7698,[colemin2,_7742,_7766,_7795,!],_7728,_7730) --> 
    point0(_7742,_7728,_7757),
    minutes(_7698,_7766,_7757,_7783),
    point0(_7795,_7783,_7730),
    !.

colemin2(_7698,[colemin2,_7739,_7768,!],_7725,_7727) --> 
    minutes(_7698,_7739,_7725,_7756),
    point0(_7768,_7756,_7727),
    !.

colemin(_7698,[colemin,_7755,{},_7794,_7818,!,_7852],_7741,_7743) --> 
    minutes(_7715,_7755,_7741,_7772),
    {user:_7715\==0},
    point(_7794,_7772,_7809),
    minutes(_7722,_7818,_7809,_7835),
    !,
    reject(_7852,_7835,_7743).

colemin(_7698,[colemin,_7745,_7769,!,_7803,_7827],_7731,_7733) --> 
    colon(_7745,_7731,_7760),
    minutes(_7698,_7769,_7760,_7786),
    !,
    accept(_7803,_7786,_7818),
    colesec0(_7827,_7818,_7733).

colemin(_7698,[colemin,_7756,_7780,{},!,_7824],_7742,_7744) --> 
    point(_7756,_7742,_7771),
    minutes(_7698,_7780,_7771,_7797),
    {user:(_7698=0;_7698>12)},
    !,
    colesec0(_7824,_7797,_7744).

colemin(_7698,[colemin,_7745,_7769,!,_7803],_7731,_7733) --> 
    colon(_7745,_7731,_7760),
    w(nb(_7698,num),_7769,_7760,_7786),
    !,
    reject(_7803,_7786,_7733).

colemin(0,[colemin,_7737,!,_7766],_7723,_7725) --> 
    colon(_7737,_7723,_7752),
    !,
    accept(_7766,_7752,_7725).

colesec0([colesec0,lit(:),_7745,!],_7723,_7725) --> 
    cc(:,_7723,_7744),
    minutes(_7706,_7745,_7744,_7725),
    !.

colesec0([colesec0,[]],_7713,_7713) --> 
    [].

minutes0(_7698,[minutes0,_7739,!,_7773],_7725,_7727) --> 
    minutes(_7698,_7739,_7725,_7756),
    !,
    accept(_7773,_7756,_7727).

minutes0(0,[minutes0,[]],_7717,_7717) --> 
    [].

minutes(_7698,[minutes,_7737,!,_7766],_7723,_7725) --> 
    a(_7737,_7723,_7752),
    !,
    reject(_7766,_7752,_7725).

minutes(_7698,[minutes,_7744,{}],_7730,_7732) --> 
    w(nb(_7698,num),_7744,_7730,_7732),
    {user:_7698<100}.

nameq2(_7701:_7705,_7701 isa number,[nameq2,_7760,_7789,_7813,!,_7842],_7743,_7745) --> 
    number(_7701:_7705,_7760,_7743,_7777),
    point0(_7789,_7777,_7804),
    monthnamex(_7813,_7804,_7828),
    !,
    reject(_7842,_7828,_7745).

nameq2(_7698,_7699,[nameq2,_7753,_7777,!,_7811],_7736,_7738) --> 
    one(_7753,_7736,_7768),
    w(noun(_7712,sin,u,n),_7777,_7768,_7794),
    !,
    reject(_7811,_7794,_7738).

nameq2(_7701:_7702,_7701 isa _7702,[nameq2,_7782,_7811,{},_7845,{},!],_7765,_7767) --> 
    number(_7701:_7725,_7782,_7765,_7799),
    point(_7811,_7799,_7826),
    {user:(\+_7701=1)},
    w(noun(_7702,sin,u,n),_7845,_7826,_7767),
    {user:alignable(_7702,number)},
    !.

nameq2(_7701:_7705,_7701 isa clock,[nameq2,{},_7784,{},{},!],_7757,_7759) --> 
    {user:type(clock,_7705)},
    number(_7701:_7727,_7784,_7757,_7759),
    {user:_7701>=1000},
    {user:clock_test(_7701)},
    !.

nameq2(_7701:_7705,_7701 isa number,[nameq2,_7748],_7731,_7733) --> 
    number(_7701:_7705,_7748,_7731,_7733).

number(_7700:number,[number,_7777,lit('.'),_7817,{},!,{}],_7763,_7765) --> 
    num(_7726,_7777,_7763,_7794),
    cc('.',_7794,_7816),
    num(_7724,_7817,_7816,_7765),
    {user:(_7724>=100,_7724<1000)},
    !,
    {user:_7700 is _7726*1000+_7724}.

number(2:_7701,[number,_7752,_7776,{}],_7738,_7740) --> 
    a(_7752,_7738,_7767),
    w(noun(pair,_7717,_7718,_7719),_7776,_7767,_7740),
    {user:type(number,_7701)}.

number(_7700:_7701,[number,_7763,_7787,{},_7826,{}],_7749,_7751) --> 
    only0(_7763,_7749,_7778),
    num(_7720,_7787,_7778,_7804),
    {user:type(number,_7701)},
    thousands0(_7721,_7826,_7804,_7751),
    {user:_7700 is _7720*_7721}.

number(_7698,[number,_7749,_7773,!,_7807],_7735,_7737) --> 
    a(_7749,_7735,_7764),
    not_look_ahead(w(noun(time,_7714,def,_7716)),_7773,_7764,_7790),
    !,
    reject(_7807,_7790,_7737).

thousands0(1000,[thousands0,_7734,!],_7720,_7722) --> 
    tusen(_7734,_7720,_7722),
    !.

thousands0(1000000,[thousands0,_7734,!],_7720,_7722) --> 
    million(_7734,_7720,_7722),
    !.

thousands0(1000000000,[thousands0,_7737,!],_7723,_7725) --> 
    milliard(_7737,_7723,_7725),
    !.

thousands0(1,[thousands0,[]],_7717,_7717) --> 
    [].

tusen([tusen,lit(tusen)],_7715,_7717) --> 
    cc(tusen,_7715,_7717).

tusen([tusen,lit(tusener)],_7715,_7717) --> 
    cc(tusener,_7715,_7717).

million([million,lit(million)],_7715,_7717) --> 
    cc(million,_7715,_7717).

million([million,lit(millioner)],_7715,_7717) --> 
    cc(millioner,_7715,_7717).

milliard([milliard,lit(milliard)],_7715,_7717) --> 
    cc(milliard,_7715,_7717).

milliard([milliard,lit(milliarder)],_7715,_7717) --> 
    cc(milliarder,_7715,_7717).

anumber(_7698,[anumber,_7742,_7766,!,_7800],_7728,_7730) --> 
    a0(_7742,_7728,_7757),
    number(_7698,_7766,_7757,_7783),
    !,
    accept(_7800,_7783,_7730).

anumber(1:_7701,[anumber,_7745,!,{}],_7731,_7733) --> 
    art1(_7745,_7731,_7733),
    !,
    {user:type(number,_7701)}.

intrans_verb(work,_7699,id,_7701,_7702,_7703,_7704,[intrans_verb,_7789,_7833,{}],_7757,_7759) --> 
    lexv(tv,hold,_7703,_7704,_7789,_7757,_7812),
    w(prep(on),_7833,_7812,_7759),
    {user:iv_template(work,_7699,_7701,_7702)}.

intrans_verb(be1,_7699,id,_7701,_7702,_7703,_7704,[intrans_verb,_7789,_7833,{}],_7757,_7759) --> 
    lexv(tv,hold,_7703,_7704,_7789,_7757,_7812),
    w(prep(to),_7833,_7812,_7759),
    {user:iv_template(be1,_7699,_7701,_7702)}.

intrans_verb(_7698,_7699,id,_7701,_7702,_7703,_7704,[intrans_verb,_7782,{}],_7750,_7752) --> 
    lexv(iv,_7698,_7703,_7704,_7782,_7750,_7752),
    {user:iv_template(_7698,_7699,_7701,_7702)}.

intrans_verb(be1,_7699,_7700,_7701,_7702,pres,fin,[intrans_verb,_7801,_7830,_7859,{}],_7769,_7771) --> 
    not_look_ahead(w(verb(go,_7727,fin)),_7801,_7769,_7818),
    be1(_7700,_7830,_7818,_7847),
    not_look_ahead(w(verb(_7736,_7737,_7738)),_7859,_7847,_7771),
    {user:iv_template(be1,_7699,_7701,_7702)}.

intrans_verb(_7698,_7699,_7700,_7701,_7702,past,fin,[intrans_verb,_7790,_7819,_7843,{}],_7758,_7760) --> 
    has(_7700,_7790,_7758,_7807),
    now0(_7819,_7807,_7834),
    lexv(iv,_7698,past,part,_7843,_7834,_7760),
    {user:iv_template(_7698,_7699,_7701,_7702)}.

trans_verbs(_7698,_7699,_7700,_7701,_7702,[trans_verbs,_7774,_7838],_7748,_7750) --> 
    trans_verb(_7707,_7699,_7700,id,_7701,_7719,_7720,_7721,_7774,_7748,_7805),
    trans_verbs0(_7707,_7698,_7699,_7700,_7701,_7702,_7838,_7805,_7750).

trans_verbs0(_7698,_7699,_7700,_7701,_7702,_7703,[trans_verbs0,_7786,_7810,_7874],_7757,_7759) --> 
    andor(_7786,_7757,_7801),
    trans_verb(_7718,_7700,_7701,id,_7702,_7723,_7724,_7725,_7810,_7801,_7841),
    trans_verbs0((_7698,_7718),_7699,_7700,_7701,_7702,_7703,_7874,_7841,_7759).

trans_verbs0(_7698,_7698,_7708:_7709,_7711:_7712,_7702,_7698/_7708/_7711/_7702,[trans_verbs0,[]],_7747,_7747) --> 
    [].

trans_verb(tell,_7699,_7700,id,_7702,_7703,_7704,fin,[trans_verb,_7794,_7838,{}],_7759,_7761) --> 
    lexv(tv,tell,_7704,fin,_7794,_7759,_7817),
    particle0(tell,_7838,_7817,_7761),
    {user:tv_template(tell,_7699,_7700,_7702,_7703)}.

trans_verb(_7698,_7699,_7700,_7701,_7702,_7703,past,fin,[trans_verb,_7794,_7823,{}],_7759,_7761) --> 
    has(_7701,_7794,_7759,_7811),
    lexv(tv,_7698,past,part,_7823,_7811,_7761),
    {user:tv_template(_7698,_7699,_7700,_7702,_7703)}.

trans_verb(_7698,_7699,_7700,id,_7702,_7703,_7704,_7705,[trans_verb,_7789,{}],_7754,_7756) --> 
    lexv(tv,_7698,_7704,_7705,_7789,_7754,_7756),
    {user:tv_template(_7698,_7699,_7700,_7702,_7703)}.

rep_v(be_free,pres,fin,[rep_v,_7748],_7728,_7730) --> 
    w(adj2(free,nil),_7748,_7728,_7730).

rep_v(_7698,_7699,_7700,[rep_v,_7761,_7785,_7829,_7858],_7741,_7743) --> 
    aux0(_7761,_7741,_7776),
    lexv(rv,_7698,_7699,_7700,_7785,_7776,_7808),
    reflexiv0(_7698,_7829,_7808,_7846),
    rep_particlev0(_7698,_7858,_7846,_7743).

rep_v(want,pres,fin,[rep_v,lit(skal),!,_7767],_7731,_7733) --> 
    cc(skal,_7731,_7761),
    !,
    reject(_7767,_7761,_7733).

there_be_modal(think,[there_be_modal,_7745,_7769,lit(an)],_7731,_7733) --> 
    thereit(_7745,_7731,_7760),
    w(verb(go,_7711,_7712),_7769,_7760,_7786),
    cc(an,_7786,_7733).

there_be_modal(_7698,[there_be_modal,_7736,_7760],_7722,_7724) --> 
    thereit(_7736,_7722,_7751),
    be_modal(_7698,_7760,_7751,_7724).

be_there_modal(_7698,[be_there_modal,_7739,_7763,_7787],_7725,_7727) --> 
    be(_7739,_7725,_7754),
    thereit(_7763,_7754,_7778),
    be_modal(_7698,_7787,_7778,_7727).

be_modal(_7698,[be_modal,_7736,_7760],_7722,_7724) --> 
    be(_7736,_7722,_7751),
    modal(_7698,_7760,_7751,_7724).

be_modal(seem,[be_modal,_7737],_7723,_7725) --> 
    w(verb(seem,_7703,fin),_7737,_7723,_7725).

modal(_7698,[modal,_7740,_7779],_7726,_7728) --> 
    rep_v(_7698,past,part,_7740,_7726,_7761),
    tobetrue(_7703,_7779,_7761,_7728).

modal(_7698,[modal,_7735],_7721,_7723) --> 
    rep_v(_7698,_7701,fin,_7735,_7721,_7723).

modal(think,[modal,_7736],_7722,_7724) --> 
    w(adj2(possible,nil),_7736,_7722,_7724).

modal(think,[modal,_7736],_7722,_7724) --> 
    w(adj2(best,nil),_7736,_7722,_7724).

modal(free,[modal,_7736],_7722,_7724) --> 
    w(adj2(free,nil),_7736,_7722,_7724).

tobetrue(_7698,[tobetrue,_7736,_7760],_7722,_7724) --> 
    infinitive(_7736,_7722,_7751),
    be_truefalse(_7698,_7760,_7751,_7724).

tobetrue(id,[tobetrue,[]],_7717,_7717) --> 
    [].

pvimodal(_7698,_7699,[pvimodal,_7758,{},{}],_7741,_7743) --> 
    lexv(tv,_7698,_7714,fin,_7758,_7741,_7743),
    {user:_7698\==be},
    {user:pvi_templ(_7698,_7699)}.

lexvaccept(_7698,_7699,_7700,_7701,_7702,[lexvaccept,_7764,!],_7738,_7740) --> 
    hlexv(_7698,_7699,_7700,_7701,_7702,_7764,_7738,_7740),
    !.

hlexv(_7698,_7699,_7700,_7701,_7702,[hlexv,_7797,_7821,_7850,_7879,{},_7923,{}],_7771,_7773) --> 
    aux0(_7797,_7771,_7812),
    negation0(_7724,_7821,_7812,_7838),
    w(verb(_7732,_7700,_7701),_7850,_7838,_7867),
    particlev0(_7732,_7699,_7879,_7867,_7898),
    {user:verbtype(_7699,_7698)},
    negation0(_7725,_7923,_7898,_7773),
    {user:bigno(_7724,_7725,_7702)}.

hlexv(iv,_7699,_7700,fin,_7702,[hlexv,_7778,_7807,_7831,_7860,!],_7752,_7754) --> 
    w(verb(be,_7700,fin),_7778,_7752,_7795),
    now0(_7807,_7795,_7822),
    negation0(_7702,_7831,_7822,_7848),
    particlev2(be,_7699,_7860,_7848,_7754),
    !.

hlexv(_7698,_7699,past,fin,_7702,[hlexv,_7776,_7800,_7824,_7853,_7897],_7750,_7752) --> 
    has(_7776,_7750,_7791),
    danow0(_7800,_7791,_7815),
    negation0(_7702,_7824,_7815,_7841),
    lexv(_7698,_7699,past,part,_7853,_7841,_7876),
    reflexiv0(_7699,_7897,_7876,_7752).

hlexv(tv,bring,_7700,_7701,id,[hlexv,_7766,_7795],_7740,_7742) --> 
    w(verb(have,_7700,_7701),_7766,_7740,_7783),
    prep1(with,_7795,_7783,_7742).

hlexv(_7698,_7699,past,fin,_7702,[hlexv,_7783,_7812,_7841,{}],_7757,_7759) --> 
    w(verb(get,_7721,fin),_7783,_7757,_7800),
    negation0(_7702,_7812,_7800,_7829),
    w(verb(_7699,past,part),_7841,_7829,_7759),
    {user:verbtype(_7699,_7698)}.

hlexv(_7698,_7699,_7700,fin,_7702,[hlexv,_7791,_7820,_7849,{},!],_7765,_7767) --> 
    w(verb(get,_7700,fin),_7791,_7765,_7808),
    negation0(_7702,_7820,_7808,_7837),
    lexv(_7698,_7699,_7726,_7727,_7849,_7837,_7767),
    {user:(_7726\==imp,_7727\=fin)},
    !.

hlexv(_7698,_7699,past,fin,_7702,[hlexv,_7780,_7809,_7833,_7862,!],_7754,_7756) --> 
    w(verb(be,_7719,fin),_7780,_7754,_7797),
    now0(_7809,_7797,_7824),
    negation0(_7702,_7833,_7824,_7850),
    lexv(_7698,_7699,past,part,_7862,_7850,_7756),
    !.

hlexv(_7698,_7699,past,fin,_7702,[hlexv,_7771,_7795,_7819,_7848],_7745,_7747) --> 
    has(_7771,_7745,_7786),
    redundant0(_7795,_7786,_7810),
    negation0(_7702,_7819,_7810,_7836),
    lexv(_7698,_7699,past,part,_7848,_7836,_7747).

hlexv(_7698,know1,_7700,_7701,_7702,[hlexv,_7802,_7831,_7860,{},!,{}],_7776,_7778) --> 
    w(verb(know,_7700,_7701),_7802,_7776,_7819),
    negation0(_7702,_7831,_7819,_7848),
    look_ahead([_7733],_7860,_7848,_7778),
    {user:testmember(_7733,[hva,hvem,hvilken,hvilket,hvilke])},
    !,
    {user:_7698=tv}.

hlexv(tv,know1,_7700,_7701,_7702,[hlexv,_7771,_7800,lit(om)],_7745,_7747) --> 
    w(verb(know,_7700,_7701),_7771,_7745,_7788),
    negation0(_7702,_7800,_7788,_7817),
    cc(om,_7817,_7747).

hlexv(tv,_7699,_7700,fin,_7702,[hlexv,_7796,_7825,_7854,_7878,_7912,!,[]],_7770,_7772) --> 
    w(verb(get,_7700,fin),_7796,_7770,_7813),
    negation0(_7702,_7825,_7813,_7842),
    look_ahead_np(_7854,_7842,_7869),
    np1_accept(_7725,_7726,_7878,_7869,_7897),
    w(verb(_7699,past,part),_7912,_7897,_7929),
    !,
    pushstack(free,xnp(_7725,_7726),nil,_7929,_7772),
    [].

hlexv(tv,get,pres,fin,_7702,[hlexv,lit(får),_7794,_7823,_7852,!],_7757,_7759) --> 
    cc(får,_7757,_7793),
    not_look_ahead(w(verb(_7722,inf,_7724)),_7794,_7793,_7811),
    negation0(_7702,_7823,_7811,_7840),
    optional([opp],_7852,_7840,_7759),
    !.

hlexv(iv,_7699,_7700,_7701,_7702,[hlexv,_7790,{},{},_7839,_7868],_7764,_7766) --> 
    w(verb(_7699,_7700,_7701),_7790,_7764,_7807),
    {user:rv_templ(_7699,_7729)},
    {user:tv_templ(_7699,_7734,nil)},
    negation0(_7702,_7839,_7807,_7856),
    look_ahead([om],_7868,_7856,_7766).

hlexv(_7698,_7699,_7700,_7701,_7702,[hlexv,_7804,{},_7843,_7872,!,{}],_7778,_7780) --> 
    w(verb(_7699,_7700,_7701),_7804,_7778,_7821),
    {user:testmember(_7699,[understand,believe,know])},
    negation0(_7702,_7843,_7821,_7860),
    look_ahead_lit([at,hvordan,hvorfor,når],_7872,_7860,_7780),
    !,
    {user:_7698=rv}.

hlexv(_7698,_7699,_7700,_7701,_7702,[hlexv,_7787,{},_7826,!,{}],_7761,_7763) --> 
    w(verb(_7699,_7700,_7701),_7787,_7761,_7804),
    {user:testmember(_7699,[believe])},
    negation0(_7702,_7826,_7804,_7763),
    !,
    {user:_7698=rv}.

hlexv(_7698,_7699,_7700,_7701,_7702,[hlexv,_7787,{},_7826,!,{}],_7761,_7763) --> 
    w(verb(_7699,_7700,_7701),_7787,_7761,_7804),
    {user:testmember(_7699,[understand])},
    negation0(_7702,_7826,_7804,_7763),
    !,
    {user:_7698=tv}.

hlexv(rv,_7699,_7700,_7701,_7702,[hlexv,{},_7808,_7852,_7881,_7910,_7939,!,_7973],_7772,_7774) --> 
    {user:value(textflag,true)},
    lexv(rv,_7699,_7700,_7701,_7808,_7772,_7831),
    negation0(_7702,_7852,_7831,_7869),
    not_look_ahead([det],_7881,_7869,_7898),
    not_look_ahead([hva],_7910,_7898,_7927),
    rep_particlev0(_7699,_7939,_7927,_7956),
    !,
    accept(_7973,_7956,_7774).

hlexv(tv,know1,pres,fin,_7702,[hlexv,lit(kan),_7798,_7827,_7856,_7885],_7761,_7763) --> 
    cc(kan,_7761,_7797),
    negation0(_7702,_7798,_7797,_7815),
    not_look_ahead([jeg],_7827,_7815,_7844),
    not_look_ahead([du],_7856,_7844,_7873),
    not_look_ahead(w(verb(_7720,_7721,_7722)),_7885,_7873,_7763).

hlexv(_7698,_7699,_7700,_7701,_7702,[hlexv,{},_7785,_7829,!],_7749,_7751) --> 
    {user:nonvar(_7698)},
    lexv(_7698,_7699,_7700,_7701,_7785,_7749,_7808),
    negation0(_7702,_7829,_7808,_7751),
    !.

hlexv(_7698,_7699,_7700,_7701,_7702,[hlexv,_7765,_7809],_7739,_7741) --> 
    lexv(_7698,_7699,_7700,_7701,_7765,_7739,_7788),
    negation0(_7702,_7809,_7788,_7741).

lexv(_7698,_7699,past,fin,[lexv,_7787,_7816,_7840,_7869,!,{},!],_7764,_7766) --> 
    w(verb(have,_7724,fin),_7787,_7764,_7804),
    redundant0(_7816,_7804,_7831),
    w(verb(_7729,past,part),_7840,_7831,_7857),
    particlev2(_7729,_7699,_7869,_7857,_7766),
    !,
    {user:verbtype(_7699,_7698)},
    !.

lexv(_7698,_7699,_7700,part,[lexv,_7772,_7801,{},!],_7749,_7751) --> 
    w(verb(_7714,_7700,part),_7772,_7749,_7789),
    particlev2(_7714,_7699,_7801,_7789,_7751),
    {user:verbtype(_7699,_7698)},
    !.

lexv(iv,_7699,past,fin,[lexv,_7766,{},!],_7743,_7745) --> 
    w(verb(_7699,past,part),_7766,_7743,_7745),
    {user:verbtype(_7699,iv)},
    !.

lexv(iv,_7699,pres,part,[lexv,_7766,{},!],_7743,_7745) --> 
    w(verb(_7699,pres,part),_7766,_7743,_7745),
    {user:verbtype(_7699,iv)},
    !.

lexv(dtv,_7699,_7700,_7701,[lexv,_7763,{}],_7740,_7742) --> 
    w(verb(_7699,_7700,_7701),_7763,_7740,_7742),
    {user:verbtype(_7699,dtv)}.

lexv(iv,be1,pres,fin,[lexv,_7755],_7732,_7734) --> 
    w(verb(be,inf,fin),_7755,_7732,_7734).

lexv(tv,_7699,past,part,[lexv,_7775,_7804,{},!],_7752,_7754) --> 
    w(verb(be,past,part),_7775,_7752,_7792),
    w(verb(_7699,past,part),_7804,_7792,_7754),
    {user:verbtype(_7699,tv)},
    !.

lexv(_7698,_7699,past,part,[lexv,_7766,{},!],_7743,_7745) --> 
    w(verb(_7699,past,part),_7766,_7743,_7745),
    {user:verbtype(_7699,_7698)},
    !.

lexv(tv,tell,_7700,_7701,[lexv,_7773,_7802,_7831,!,_7880],_7750,_7752) --> 
    w(verb(tell,_7700,_7701),_7773,_7750,_7790),
    reflexiv0(tell,_7802,_7790,_7819),
    optional([om],_7831,_7819,_7863),
    !,
    accept(_7880,_7863,_7752).

lexv(rv,_7699,_7700,_7701,[lexv,_7770,{},_7809],_7747,_7749) --> 
    w(verb(_7699,_7700,_7701),_7770,_7747,_7787),
    {user:rv_templ(_7699,_7722)},
    not_look_ahead([hva],_7809,_7787,_7749).

lexv(iv,_7699,_7700,fin,[lexv,_7767,_7796,!],_7744,_7746) --> 
    w(verb(be,_7700,fin),_7767,_7744,_7784),
    w(verb(_7699,pres,part),_7796,_7784,_7746),
    !.

lexv(iv,_7699,past,fin,[lexv,_7767,_7796,!],_7744,_7746) --> 
    w(verb(be,_7712,fin),_7767,_7744,_7784),
    w(verb(_7699,pres,part),_7796,_7784,_7746),
    !.

lexv(rv,_7699,_7700,_7701,[lexv,_7785,{},_7824,_7853,!,_7887],_7762,_7764) --> 
    w(verb(_7699,_7700,_7701),_7785,_7762,_7802),
    {user:testmember(_7699,[tell,notify])},
    reflexiv0(_7699,_7824,_7802,_7841),
    not_look_ahead([hva],_7853,_7841,_7870),
    !,
    accept(_7887,_7870,_7764).

lexv(rv,show,_7700,_7701,[lexv,_7760,_7789],_7737,_7739) --> 
    w(verb(show,_7700,_7701),_7760,_7737,_7777),
    reflexiv0(show,_7789,_7777,_7739).

lexv(rv,mean,_7700,_7701,[lexv,_7765,_7794,!],_7742,_7744) --> 
    w(verb(mean,_7700,_7701),_7765,_7742,_7782),
    look_ahead([at],_7794,_7782,_7744),
    !.

lexv(rv,mean,_7700,_7701,[lexv,_7776,_7805,_7834,_7863],_7753,_7755) --> 
    w(verb(mean,_7700,_7701),_7776,_7753,_7793),
    not_look_ahead([hva],_7805,_7793,_7822),
    not_look_ahead([en],_7834,_7822,_7851),
    not_look_ahead([noe],_7863,_7851,_7755).

lexv(tv,know1,_7700,_7701,[lexv,_7769,_7798,_7827],_7746,_7748) --> 
    w(verb(know,_7700,_7701),_7769,_7746,_7786),
    not_look_ahead([når],_7798,_7786,_7815),
    not_look_ahead([at],_7827,_7815,_7748).

lexv(_7698,_7699,_7700,_7701,[lexv,_7775,_7799,_7823,{},!,_7867],_7752,_7754) --> 
    do(_7775,_7752,_7790),
    faa(_7799,_7790,_7814),
    w(verb(_7699,_7700,_7701),_7823,_7814,_7840),
    {user:verbtype(_7699,_7698)},
    !,
    accept(_7867,_7840,_7754).

lexv(_7698,_7699,_7700,_7701,[lexv,_7779,_7803,_7832,{},!,_7876],_7756,_7758) --> 
    do(_7779,_7756,_7794),
    not_look_ahead([nå],_7803,_7794,_7820),
    w(verb(_7699,_7700,_7701),_7832,_7820,_7849),
    {user:verbtype(_7699,_7698)},
    !,
    accept(_7876,_7849,_7758).

lexv(_7698,_7699,_7700,_7701,[lexv,_7782,_7806,_7835,{},{}],_7759,_7761) --> 
    faa(_7782,_7759,_7797),
    not_look_ahead([nå],_7806,_7797,_7823),
    lexv(_7698,_7699,_7700,_7701,_7835,_7823,_7761),
    {user:verbtype(_7699,_7698)},
    {user:(\+_7699=manage)}.

lexv(tv,run,_7700,_7701,[lexv,_7766,_7795,!,_7829],_7743,_7745) --> 
    w(verb(run,_7700,_7701),_7766,_7743,_7783),
    prep1(with,_7795,_7783,_7812),
    !,
    reject(_7829,_7812,_7745).

lexv(tv,evah,pres,fin,[lexv,_7761,!,_7795],_7738,_7740) --> 
    w(verb(evah,pres,fin),_7761,_7738,_7778),
    !,
    accept(_7795,_7778,_7740).

lexv(cv,be,pres,fin,[lexv,_7752,_7776],_7729,_7731) --> 
    aux0(_7752,_7729,_7767),
    be(_7776,_7767,_7731).

lexv(tv,wonder,_7700,_7701,[lexv,_7755],_7732,_7734) --> 
    w(verb(wonder,_7700,_7701),_7755,_7732,_7734).

lexv(tv,want,_7700,_7701,[lexv,_7758,_7787],_7735,_7737) --> 
    w(verb(think,_7700,_7701),_7758,_7735,_7775),
    rfxpron(_7787,_7775,_7737).

lexv(_7698,_7699,past,fin,[lexv,_7792,_7816,_7845,{},_7884,_7913,{}],_7769,_7771) --> 
    aux1(_7792,_7769,_7807),
    w(verb(_7728,past,part),_7816,_7807,_7833),
    not_look_ahead([om],_7845,_7833,_7862),
    {user:_7728\==have},
    reflexiv0(_7728,_7884,_7862,_7901),
    particlev0(_7728,_7699,_7913,_7901,_7771),
    {user:verbtype(_7699,_7698)}.

lexv(_7698,_7699,_7700,_7701,[lexv,{},_7801,_7830,{},_7869,{}],_7768,_7770) --> 
    {user:_7698==tv},
    w(verb(_7699,_7700,_7701),_7801,_7768,_7818),
    not_look_ahead([om],_7830,_7818,_7847),
    {user:_7699\==have},
    reflexiv0(_7699,_7869,_7847,_7770),
    {user:verbtype(_7699,_7698)}.

lexv(_7698,_7699,_7700,_7701,[lexv,{},_7816,{},_7855,{},_7894,_7923,{}],_7783,_7785) --> 
    {user:var(_7698)},
    w(verb(_7735,_7700,_7701),_7816,_7783,_7833),
    {user:(\+rv_templ(_7735,_7744))},
    not_look_ahead([om],_7855,_7833,_7872),
    {user:_7735\==have},
    reflexiv0(_7735,_7894,_7872,_7911),
    particlev0(_7735,_7699,_7923,_7911,_7785),
    {user:verbtype(_7699,_7698)}.

lexv(iv,_7699,_7700,_7701,[lexv,_7793,_7817,{},{},_7866,_7895,{}],_7770,_7772) --> 
    aux0(_7793,_7770,_7808),
    w(verb(_7728,_7700,_7701),_7817,_7808,_7834),
    {user:_7701==fin},
    {user:_7728\==have},
    reflexiv0(_7728,_7866,_7834,_7883),
    particlev0(_7728,_7699,_7895,_7883,_7772),
    {user:verbtype(_7699,iv)}.

lexv(_7698,have,_7700,_7701,[lexv,_7778,_7802,{},_7841],_7755,_7757) --> 
    aux0(_7778,_7755,_7793),
    w(verb(have,_7700,_7701),_7802,_7793,_7819),
    {user:verbtype(have,_7698)},
    not_look_ahead(w(noun(arrival,_7717,_7718,n)),_7841,_7819,_7757).

lexv(_7698,_7699,past,fin,[lexv,_7766,_7790,{}],_7743,_7745) --> 
    has(_7766,_7743,_7781),
    w(verb(_7699,past,part),_7790,_7781,_7745),
    {user:verbtype(_7699,_7698)}.

lexv(tv,bring,_7700,_7701,[lexv,_7760,_7789],_7737,_7739) --> 
    w(verb(take,_7700,_7701),_7760,_7737,_7777),
    prep1(with,_7789,_7777,_7739).

lexv(_7698,_7699,_7700,_7701,[lexv,_7775,_7804,_7828,{},!],_7752,_7754) --> 
    w(verb(_7717,_7700,_7701),_7775,_7752,_7792),
    redundant0(_7804,_7792,_7819),
    particlev0(_7717,_7699,_7828,_7819,_7754),
    {user:verbtype(_7699,_7698)},
    !.

preadjs0(_7698,[preadjs0,lit(s),_7753,!,_7782],_7728,_7730) --> 
    cc(s,_7728,_7752),
    look_ahead_clock(_7753,_7752,_7768),
    !,
    reject(_7782,_7768,_7730).

preadjs0(_7698,[preadjs0,_7739,_7763,!],_7725,_7727) --> 
    so(_7739,_7725,_7754),
    preadjs(_7698,_7763,_7754,_7727),
    !.

preadjs0((_7700,_7701),[preadjs0,_7747,_7771,_7800,_7824],_7733,_7735) --> 
    dent0(_7747,_7733,_7762),
    preadj1(_7700,_7771,_7762,_7788),
    adj_conjunction(_7800,_7788,_7815),
    preadj1(_7701,_7824,_7815,_7735).

preadjs0((_7700,_7701),[preadjs0,_7753,_7777,_7806,_7835],_7739,_7741) --> 
    dent0(_7753,_7739,_7768),
    preadj1(_7700,_7777,_7768,_7794),
    not_look_ahead(w(prep(_7720)),_7806,_7794,_7823),
    preadjs0(_7701,_7835,_7823,_7741).

preadjs0(true,[preadjs0,[]],_7717,_7717) --> 
    [].

preadjs((_7700,_7701),[preadjs,_7750,_7779,_7808],_7736,_7738) --> 
    preadj1(_7700,_7750,_7736,_7767),
    not_look_ahead(w(prep(_7717)),_7779,_7767,_7796),
    preadjs0(_7701,_7808,_7796,_7738).

preadj1(nil/first,[preadj1,_7745,_7774,!],_7731,_7733) --> 
    w(nb(1,num),_7745,_7731,_7762),
    point(_7774,_7762,_7733),
    !.

preadj1(nil/second,[preadj1,_7745,_7774,!],_7731,_7733) --> 
    w(nb(2,num),_7745,_7731,_7762),
    point(_7774,_7762,_7733),
    !.

preadj1(nil/third,[preadj1,_7745,_7774,!],_7731,_7733) --> 
    w(nb(3,num),_7745,_7731,_7762),
    point(_7774,_7762,_7733),
    !.

preadj1(nil/_7701,[preadj1,_7756,{},!,_7800],_7742,_7744) --> 
    w(name(_7701,n,station),_7756,_7742,_7773),
    {user:(\+adjname_templ(_7701,_7723))},
    !,
    reject(_7800,_7773,_7744).

preadj1(nil/_7701,[preadj1,_7751,{},!],_7737,_7739) --> 
    w(name(_7701,n,_7713),_7751,_7737,_7739),
    {user:adjname_templ(_7701,_7718)},
    !.

preadj1(_7700/_7701,[preadj1,_7744,_7773],_7730,_7732) --> 
    gradverb(_7700,_7744,_7730,_7761),
    w(adj2(_7701,nil),_7773,_7761,_7732).

preadj1(_7700/_7701,[preadj1,_7781,_7810,_7839,_7883,{},!],_7767,_7769) --> 
    not_look_ahead_lit([først,senest,tidligst],_7781,_7767,_7798),
    not_look_ahead(w(prep(_7730)),_7810,_7798,_7827),
    optional([mye],_7839,_7827,_7871),
    w(adj2(_7701,_7700),_7883,_7871,_7769),
    {user:(\+user:post_adjective(_7701))},
    !.

adj_conjunction0([adj_conjunction0,_7727,!],_7716,_7718) --> 
    adj_conjunction(_7727,_7716,_7718),
    !.

adj_conjunction0([adj_conjunction0,[]],_7713,_7713) --> 
    [].

adj_conjunction([adj_conjunction,lit(og)],_7715,_7717) --> 
    cc(og,_7715,_7717).

adj_conjunction([adj_conjunction,lit(men)],_7715,_7717) --> 
    cc(men,_7715,_7717).

adj_conjunction([adj_conjunction,lit(eller)],_7715,_7717) --> 
    cc(eller,_7715,_7717).

adj_conjunction([adj_conjunction,lit(/)],_7715,_7717) --> 
    cc(/,_7715,_7717).

adj1s((_7706;_7707),_7699,_7700,_7703 or _7704,[adj1s,_7776,lit(eller),_7831,!],_7753,_7755) --> 
    adj1(_7706,_7699,_7700,_7703,_7776,_7753,_7799),
    cc(eller,_7799,_7830),
    adj1(_7707,_7699,_7700,_7704,_7831,_7830,_7755),
    !.

adj1s((_7706,_7707),_7699,_7700,_7703 and _7704,[adj1s,_7785,lit(og),_7840,_7884,!],_7762,_7764) --> 
    adj1(_7706,_7699,_7700,_7703,_7785,_7762,_7808),
    cc(og,_7808,_7839),
    adj1(_7707,_7699,_7700,_7704,_7840,_7839,_7863),
    not_look_ahead(w(prep(_7737)),_7884,_7863,_7764),
    !.

adj1s(_7698,_7699,_7700,_7701,[adj1s,_7754],_7731,_7733) --> 
    adj1(_7698,_7699,_7700,_7701,_7754,_7731,_7733).

adj1(_7698,_7699,_7700,_7701,[adj1,_7770,_7799,{}],_7747,_7749) --> 
    gradverbs0(_7711,_7770,_7747,_7787),
    w(adj2(_7698,nil),_7799,_7787,_7749),
    {user:adj_template(_7711,_7698,_7699,_7700,_7701)}.

adj1(_7698,_7699,_7700,_7701,[adj1,_7765,{}],_7742,_7744) --> 
    w(adj2(_7698,_7708),_7765,_7742,_7744),
    {user:adj_template(_7708,_7698,_7699,_7700,_7701)}.

gradverbs0(_7698,[gradverbs0,_7741,!,_7775],_7727,_7729) --> 
    gradverb(_7698,_7741,_7727,_7758),
    !,
    gradverbs0(_7706,_7775,_7758,_7729).

gradverbs0(nil,[gradverbs0,[]],_7717,_7717) --> 
    [].

gradverb0(more,[gradverb0,lit(mer),_7757,!],_7732,_7734) --> 
    cc(mer,_7732,_7756),
    look_ahead(w(adj2(_7712,nil)),_7757,_7756,_7734),
    !.

gradverb0(_7698,[gradverb0,_7745,_7774,!],_7731,_7733) --> 
    gradverb(_7698,_7745,_7731,_7762),
    not_look_ahead(w(prep(_7712)),_7774,_7762,_7733),
    !.

gradverb0(nil,[gradverb0,[]],_7717,_7717) --> 
    [].

gradverb(little,[gradverb,lit(dårlig)],_7719,_7721) --> 
    cc(dårlig,_7719,_7721).

gradverb(more,[gradverb,lit(litt),lit(mer),!],_7727,_7729) --> 
    cc(litt,_7727,_7751),
    cc(mer,_7751,_7729),
    !.

gradverb(more,[gradverb,lit(mye),lit(mer),!],_7727,_7729) --> 
    cc(mye,_7727,_7751),
    cc(mer,_7751,_7729),
    !.

gradverb(more,[gradverb,lit(mer)],_7719,_7721) --> 
    cc(mer,_7719,_7721).

gradverb(only,[gradverb,lit(bare)],_7719,_7721) --> 
    cc(bare,_7719,_7721).

gradverb(too,[gradverb,lit(for)],_7719,_7721) --> 
    cc(for,_7719,_7721).

gradverb(very,[gradverb,lit(meget)],_7719,_7721) --> 
    cc(meget,_7719,_7721).

gradverb(very,[gradverb,lit(veldig)],_7719,_7721) --> 
    cc(veldig,_7719,_7721).

gradverb(little,[gradverb,lit(litt)],_7719,_7721) --> 
    cc(litt,_7719,_7721).

gradverb(somewhat,[gradverb,lit(noe)],_7719,_7721) --> 
    cc(noe,_7719,_7721).

gradverb(often,[gradverb,lit(ofte)],_7719,_7721) --> 
    cc(ofte,_7719,_7721).

gradverb(nil,[gradverb,lit(så)],_7719,_7721) --> 
    cc(så,_7719,_7721).

prepnom(_7698,[prepnom,_7747,{},!,_7791],_7733,_7735) --> 
    prep(_7698,_7747,_7733,_7764),
    {user:_7698==regarding},
    !,
    accept(_7791,_7764,_7735).

prepnom(_7698,[prepnom,_7733],_7719,_7721) --> 
    prepnof(_7698,_7733,_7719,_7721).

prepnog(long,from,[prepnog,_7745,!,_7779],_7728,_7730) --> 
    prep1(from,_7745,_7728,_7762),
    !,
    accept(_7779,_7762,_7730).

prepnog(possible,_7699,[prepnog,!,_7745],_7723,_7725) --> 
    !,
    reject(_7745,_7723,_7725).

prepnog(_7698,_7699,[prepnog,_7745,!,_7779],_7728,_7730) --> 
    prepnof(_7699,_7745,_7728,_7762),
    !,
    accept(_7779,_7762,_7730).

prepnof(_7698,[prepnof,_7743,{}],_7729,_7731) --> 
    prep(_7698,_7743,_7729,_7731),
    {user:(\+_7698=of)}.

defaultprep(_7698,_7699,_7700,[defaultprep,{},{},_7789,!,_7833],_7749,_7751) --> 
    {user:_7698\==be},
    {user:vartypeid(_7699,_7722)},
    adjustprep0(_7698,_7722,_7700,_7789,_7749,_7810),
    !,
    accept(_7833,_7810,_7751).

adjustprep0(_7698,_7699,_7700,[adjustprep0,_7750,!],_7730,_7732) --> 
    adjustprep(_7698,_7699,_7700,_7750,_7730,_7732),
    !.

adjustprep0(_7698,_7699,_7700,[adjustprep0,_7747],_7727,_7729) --> 
    missingprep(_7698,_7699,_7700,_7747,_7727,_7729).

adjustprep(ask,_7699,regarding,[adjustprep,lit(om)],_7725,_7727) --> 
    cc(om,_7725,_7727).

adjustprep(dream,_7699,regarding,[adjustprep,lit(om)],_7725,_7727) --> 
    cc(om,_7725,_7727).

adjustprep(handle2,_7699,regarding,[adjustprep,lit(om)],_7725,_7727) --> 
    cc(om,_7725,_7727).

adjustprep(know,_7699,regarding,[adjustprep,lit(om)],_7725,_7727) --> 
    cc(om,_7725,_7727).

adjustprep(know1,_7699,regarding,[adjustprep,lit(om)],_7725,_7727) --> 
    cc(om,_7725,_7727).

adjustprep(go,_7699,from,[adjustprep,_7745],_7725,_7727) --> 
    prep(after,_7745,_7725,_7727).

adjustprep(go,_7699,to,[adjustprep,_7745],_7725,_7727) --> 
    prep(of,_7745,_7725,_7727).

adjustprep(_7698,_7699,_7700,[adjustprep,_7745],_7725,_7727) --> 
    prep(_7700,_7745,_7725,_7727).

missingprep(_7698,duration,with,[missingprep,!],_7723,_7723) --> 
    !.

missingprep(pass,_7699,_7700,[missingprep,!,_7751],_7726,_7728) --> 
    !,
    reject(_7751,_7726,_7728).

missingprep(_7698,thing,_7700,[missingprep,!,_7751],_7726,_7728) --> 
    !,
    reject(_7751,_7726,_7728).

missingprep(go,direction,in,[missingprep,[]],_7723,_7723) --> 
    [].

missingprep(arrive,_7699,at,[missingprep,[]],_7723,_7723) --> 
    [].

missingprep(depart,_7699,from,[missingprep,[]],_7723,_7723) --> 
    [].

missingprep(go,direction,in,[missingprep,[]],_7723,_7723) --> 
    [].

missingprep(go,_7699,at,[missingprep,[]],_7723,_7723) --> 
    [].

missingprep(start,_7699,at,[missingprep,[]],_7723,_7723) --> 
    [].

missingprep(stop,_7699,at,[missingprep,[]],_7723,_7723) --> 
    [].

prep0(from,[prep0,_7739,!,_7773],_7725,_7727) --> 
    prep(from,_7739,_7725,_7756),
    !,
    accept(_7773,_7756,_7727).

prep0(_7698,[prep0,_7741,{}],_7727,_7729) --> 
    prep(_7698,_7741,_7727,_7729),
    {user:_7698\==of}.

prep0(in,[prep0,[]],_7717,_7717) --> 
    [].

prep(_7698,[prep,lit(m),_7758,!,_7792],_7733,_7735) --> 
    cc(m,_7733,_7757),
    w(nb(_7713,_7714),_7758,_7757,_7775),
    !,
    reject(_7792,_7775,_7735).

prep(from,[prep,lit(dra),{},_7773],_7738,_7740) --> 
    cc(dra,_7738,_7762),
    {user:value(smsflag,true)},
    look_ahead(w(name(_7710,n,_7712)),_7773,_7762,_7740).

prep(_7698,[prep,_7733],_7719,_7721) --> 
    prep2(_7698,_7733,_7719,_7721).

prep(_7698,[prep,_7733],_7719,_7721) --> 
    prep1(_7698,_7733,_7719,_7721).

prep1(after,[prep1,lit(e),_7754,!],_7729,_7731) --> 
    cc(e,_7729,_7753),
    not_look_ahead(['.'],_7754,_7753,_7731),
    !.

prep1(_7698,[prep1,_7742,_7771],_7728,_7730) --> 
    w(prep(_7698),_7742,_7728,_7759),
    not_look_ahead([å],_7771,_7759,_7730).

prep1(to,[prep1,lit(ti),_7755],_7730,_7732) --> 
    cc(ti,_7730,_7754),
    look_ahead(w(name(_7707,_7708,_7709)),_7755,_7754,_7732).

atom(_7698,[atom,_7745,{}],_7731,_7733) --> 
    w(name(_7705,_7711,_7712),_7745,_7731,_7733),
    {user:atom_templ(_7705,_7698)}.

atomlist(_7698,[atomlist,_7747,_7776,_7805],_7733,_7735) --> 
    atom1(_7709,_7747,_7733,_7764),
    atom1(_7711,_7776,_7764,_7793),
    atoms0(_7709-_7711,_7698,_7805,_7793,_7735).

atom1(_7698,[atom1,_7745,{}],_7731,_7733) --> 
    w(name(_7698,n,_7705),_7745,_7731,_7733),
    {user:_7705\==unkn}.

atoms0(_7698,_7699,[atoms0,_7748,_7777],_7731,_7733) --> 
    atom1(_7707,_7748,_7731,_7765),
    atoms0(_7698-_7707,_7699,_7777,_7765,_7733).

atoms0(_7698,_7698,[atoms0,[]],_7720,_7720) --> 
    [].

newatom(_7698,[newatom,_7745,{}],_7731,_7733) --> 
    w(name(_7705,_7711,_7712),_7745,_7731,_7733),
    {user:atom_templ(_7705,_7698)}.

newatomid(_7698,[newatomid,_7737],_7723,_7725) --> 
    w(name(_7698,_7703,_7704),_7737,_7723,_7725).

xsubjunction(nil,coevent,instead_of,[xsubjunction,lit(fremfor)],_7725,_7727) --> 
    cc(fremfor,_7725,_7727).

xsubjunction(nil,coevent,in_order_to,[xsubjunction,_7743],_7723,_7725) --> 
    in_order_to(_7743,_7723,_7725).

xsubjunction(nil,coevent,without,[xsubjunction,_7743],_7723,_7725) --> 
    utenå(_7743,_7723,_7725).

xsubjunction(nil,coevent,by,[xsubjunction,lit(ved),lit(å)],_7730,_7732) --> 
    cc(ved,_7730,_7760),
    cc(å,_7760,_7732).

subjunction(before,time,in,[subjunction,_7748,_7777],_7728,_7730) --> 
    prep1(to,_7748,_7728,_7765),
    look_ahead_np(_7777,_7765,_7730).

subjunction(after,time,in,[subjunction,_7748,_7777],_7728,_7730) --> 
    prep1(after,_7748,_7728,_7765),
    that(_7777,_7765,_7730).

subjunction(after,time,in,[subjunction,_7777,_7806,_7835,_7864,!],_7757,_7759) --> 
    prep1(after,_7777,_7757,_7794),
    not_look_ahead(w(noun(clock,sin,def,n)),_7806,_7794,_7823),
    not_look_ahead(w(nb(_7729,_7730)),_7835,_7823,_7852),
    look_ahead([jeg],_7864,_7852,_7759),
    !.

subjunction(before,time,in,[subjunction,lit(før),_7778,_7807],_7747,_7749) --> 
    cc(før,_7747,_7777),
    not_look_ahead(w(nb(_7723,_7724)),_7778,_7777,_7795),
    not_look_ahead(w(noun(clock,sin,def,n)),_7807,_7795,_7749).

subjunction(before,time,in,[subjunction,lit(til),_7767],_7736,_7738) --> 
    cc(til,_7736,_7766),
    not_look_ahead(w(name(_7709,_7710,_7711)),_7767,_7766,_7738).

subjunction(not_withstanding,coevent,nil,[subjunction,_7748,lit(om)],_7728,_7730) --> 
    uansett(_7748,_7728,_7763),
    cc(om,_7763,_7730).

subjunction(not_withstanding,coevent,nil,[subjunction,lit(selvom)],_7725,_7727) --> 
    cc(selvom,_7725,_7727).

uansett([uansett,lit(uansett)],_7715,_7717) --> 
    cc(uansett,_7715,_7717).

uansett([uansett,lit(selv)],_7715,_7717) --> 
    cc(selv,_7715,_7717).

subjunction(unless,coevent,nil,[subjunction,lit(med),lit(mindre)],_7730,_7732) --> 
    cc(med,_7730,_7760),
    cc(mindre,_7760,_7732).

subjunction(nil,coevent,so_that,[subjunction,_7743],_7723,_7725) --> 
    because(_7743,_7723,_7725).

subjunction(nil,coevent,so_that,[subjunction,_7743],_7723,_7725) --> 
    if1(_7743,_7723,_7725).

subjunction(nil,coevent,despite_of,[subjunction,_7750,lit(at)],_7730,_7732) --> 
    prep1(without,_7750,_7730,_7767),
    cc(at,_7767,_7732).

subjunction(nil,coevent,instead_of,[subjunction,_7743],_7723,_7725) --> 
    instead_of(_7743,_7723,_7725).

subjunction(nil,coevent,because_of,[subjunction,lit(med),lit(at)],_7730,_7732) --> 
    cc(med,_7730,_7760),
    cc(at,_7760,_7732).

subjunction(nil,coevent,because_of,[subjunction,_7743],_7723,_7725) --> 
    so_that(_7743,_7723,_7725).

subjunction(nil,coevent,because_of,[subjunction,lit(slik)],_7725,_7727) --> 
    cc(slik,_7725,_7727).

subjunction(during,time,in,[subjunction,_7743],_7723,_7725) --> 
    while(_7743,_7723,_7725).

subjunction(in,time,in,[subjunction,lit(om),_7759],_7728,_7730) --> 
    cc(om,_7728,_7758),
    when1(_7759,_7758,_7730).

subjunction(in,time,in,[subjunction,_7743],_7723,_7725) --> 
    when1(_7743,_7723,_7725).

subjunction(in,time,in,[subjunction,lit(så),_7763],_7732,_7734) --> 
    cc(så,_7732,_7762),
    w(adv(fast),_7763,_7762,_7734).

subjunction(in,time,in,[subjunction,lit(om),lit(hvordan)],_7730,_7732) --> 
    cc(om,_7730,_7760),
    cc(hvordan,_7760,_7732).

subjunction(in,time,in,[subjunction,lit(på),lit(hvordan)],_7730,_7732) --> 
    cc(på,_7730,_7760),
    cc(hvordan,_7760,_7732).

subjunction(in,time,in,[subjunction,lit(da)],_7725,_7727) --> 
    cc(da,_7725,_7727).

subjunction(in,place,in,[subjunction,lit(der)],_7725,_7727) --> 
    cc(der,_7725,_7727).

subjunction(in,place,in,[subjunction,lit(hvor),_7766],_7735,_7737) --> 
    cc(hvor,_7735,_7765),
    not_look_ahead(w(adj2(_7709,_7710)),_7766,_7765,_7737).

subjunction(until,time,in,[subjunction,_7743],_7723,_7725) --> 
    until(_7743,_7723,_7725).

subjunction(in,time,in,[subjunction,lit(i),lit(det)],_7730,_7732) --> 
    cc(i,_7730,_7760),
    cc(det,_7760,_7732).

because([because,lit(fordi)],_7715,_7717) --> 
    cc(fordi,_7715,_7717).

because([because,lit(for),_7749,!],_7727,_7729) --> 
    cc(for,_7727,_7748),
    look_ahead_lit([da,den],_7749,_7748,_7729),
    !.

because([because,lit(siden),_7761,{},!,_7805],_7739,_7741) --> 
    cc(siden,_7739,_7760),
    w(noun(_7714,_7715,_7716,_7717),_7761,_7760,_7778),
    {user:constrain(_7714,time)},
    !,
    reject(_7805,_7778,_7741).

because([because,lit(siden)],_7715,_7717) --> 
    cc(siden,_7715,_7717).

erdetdet([erdetdet,_7735,lit(det),_7770,_7794],_7724,_7726) --> 
    be(_7735,_7724,_7750),
    cc(det,_7750,_7769),
    that0(_7770,_7769,_7785),
    det0(_7794,_7785,_7726).

be_it_tf_that(_7698,[be_it_tf_that,_7762,lit(det),_7802,lit(ut),lit(til),lit(at)],_7748,_7750) --> 
    w(verb(see,_7720,fin),_7762,_7748,_7779),
    cc(det,_7779,_7801),
    negation0(_7698,_7802,_7801,_7819),
    cc(ut,_7819,_7841),
    cc(til,_7841,_7852),
    cc(at,_7852,_7750).

omaa([omaa,lit(om),lit(å),!],_7723,_7725) --> 
    cc(om,_7723,_7744),
    cc(å,_7744,_7725),
    !.

omaa([omaa,lit(å),!],_7718,_7720) --> 
    cc(å,_7718,_7720),
    !.

gadd([gadd,lit(vil)],_7715,_7717) --> 
    cc(vil,_7715,_7717).

hvormye([hvormye,lit(hvor),lit(mye)],_7720,_7722) --> 
    cc(hvor,_7720,_7741),
    cc(mye,_7741,_7722).

hvormye([hvormye,lit(hvor),lit(mange)],_7720,_7722) --> 
    cc(hvor,_7720,_7741),
    cc(mange,_7741,_7722).

hvormye([hvormye,lit(hvor),lit(meget)],_7720,_7722) --> 
    cc(hvor,_7720,_7741),
    cc(meget,_7741,_7722).

hvormye([hvormye,lit(hva)],_7715,_7717) --> 
    cc(hva,_7715,_7717).

whatcan([whatcan,lit(hva),lit(kan)],_7720,_7722) --> 
    cc(hva,_7720,_7741),
    cc(kan,_7741,_7722).

whatcan([whatcan,lit(hva),_7740],_7718,_7720) --> 
    cc(hva,_7718,_7739),
    aux1(_7740,_7739,_7720).

ompa([ompa,lit(om)],_7715,_7717) --> 
    cc(om,_7715,_7717).

ompa([ompa,_7728],_7717,_7719) --> 
    w(prep(on),_7728,_7717,_7719).

ompa([ompa,_7728],_7717,_7719) --> 
    w(prep(for),_7728,_7717,_7719).

hver0([hver0,lit(hvert),!],_7718,_7720) --> 
    cc(hvert,_7718,_7720),
    !.

hver0([hver0,lit(hver),!],_7718,_7720) --> 
    cc(hver,_7718,_7720),
    !.

hver0([hver0,[]],_7713,_7713) --> 
    [].

detå([detå,lit(det),_7743,!],_7721,_7723) --> 
    cc(det,_7721,_7742),
    infinitive(_7743,_7742,_7723),
    !.

detå([detå,lit(det),lit(og),!],_7723,_7725) --> 
    cc(det,_7723,_7744),
    cc(og,_7744,_7725),
    !.

detå([detå,lit(det),lit(for),_7759,!],_7726,_7728) --> 
    cc(det,_7726,_7747),
    cc(for,_7747,_7758),
    infinitive(_7759,_7758,_7728),
    !.

detå([detå,lit(det),lit(for),lit(og),!],_7728,_7730) --> 
    cc(det,_7728,_7749),
    cc(for,_7749,_7760),
    cc(og,_7760,_7730),
    !.

numberroute([numberroute,_7730,_7754,!],_7719,_7721) --> 
    optionalbus(_7730,_7719,_7745),
    num1(_7754,_7745,_7721),
    !.

numberroute([numberroute,_7727,!],_7716,_7718) --> 
    bus1(_7727,_7716,_7718),
    !.

optionalbus([optionalbus,_7731,_7755],_7720,_7722) --> 
    bus1(_7731,_7720,_7746),
    optional([nr],_7755,_7746,_7722).

optionalbus([optionalbus,_7724],_7713,_7715) --> 
    num1(_7724,_7713,_7715).

optionalbus([optionalbus,[]],_7713,_7713) --> 
    [].

num1([num1,_7737,_7766,!],_7726,_7728) --> 
    w(noun(number,sin,_7708,n),_7737,_7726,_7754),
    point0(_7766,_7754,_7728),
    !.

num1([num1,lit(nr),_7743,!],_7721,_7723) --> 
    cc(nr,_7721,_7742),
    point0(_7743,_7742,_7723),
    !.

bus1([bus1,_7731],_7720,_7722) --> 
    w(noun(route,sin,_7702,_7703),_7731,_7720,_7722).

bus1([bus1,_7731],_7720,_7722) --> 
    w(noun(bus,sin,_7702,_7703),_7731,_7720,_7722).

commas0([commas0,_7730,!,_7759],_7719,_7721) --> 
    comma(_7730,_7719,_7745),
    !,
    commas0(_7759,_7745,_7721).

commas0([commas0,[]],_7713,_7713) --> 
    [].

comma0([comma0,lit(','),!],_7718,_7720) --> 
    cc(',',_7718,_7720),
    !.

comma0([comma0,[]],_7713,_7713) --> 
    [].

comma([comma,lit(',')],_7715,_7717) --> 
    cc(',',_7715,_7717).

streetno([streetno,_7730,!,_7759],_7719,_7721) --> 
    a(_7730,_7719,_7745),
    !,
    reject(_7759,_7745,_7721).

streetno([streetno,lit(veg)],_7715,_7717) --> 
    cc(veg,_7715,_7717).

streetno([streetno,_7737,{}],_7726,_7728) --> 
    w(nb(_7703,num),_7737,_7726,_7728),
    {user:_7703<500}.

tilsiden([tilsiden,_7726],_7715,_7717) --> 
    prep1(to,_7726,_7715,_7717).

tilsiden([tilsiden,_7726],_7715,_7717) --> 
    prep1(before,_7726,_7715,_7717).

tilsiden([tilsiden,lit(siden)],_7715,_7717) --> 
    cc(siden,_7715,_7717).

hva([hva,lit(hva),!,_7748],_7721,_7723) --> 
    cc(hva,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

hva([hva,lit(hvor),_7746,!,_7775],_7724,_7726) --> 
    cc(hvor,_7724,_7745),
    meny(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

addressat0([addressat0,_7736,!,_7770],_7725,_7727) --> 
    w(name(tuc,n,_7708),_7736,_7725,_7753),
    !,
    accept(_7770,_7753,_7727).

addressat0([addressat0,_7736,!,_7770],_7725,_7727) --> 
    w(name(busstuc,n,_7708),_7736,_7725,_7753),
    !,
    accept(_7770,_7753,_7727).

addressat0([addressat0,_7736,!,_7770],_7725,_7727) --> 
    w(name(bustuc,n,_7708),_7736,_7725,_7753),
    !,
    accept(_7770,_7753,_7727).

addressat0([addressat0,_7736,!,_7770],_7725,_7727) --> 
    w(name(hal,n,_7708),_7736,_7725,_7753),
    !,
    accept(_7770,_7753,_7727).

addressat0([addressat0,[]],_7713,_7713) --> 
    [].

enn([enn,lit(enn)],_7715,_7717) --> 
    cc(enn,_7715,_7717).

enn([enn,lit(en)],_7715,_7717) --> 
    cc(en,_7715,_7717).

hatt0([hatt0,_7733,!],_7722,_7724) --> 
    w(verb(have,past,part),_7733,_7722,_7724),
    !.

hatt0([hatt0,[]],_7713,_7713) --> 
    [].

out0([out0,lit(ut),!,_7748],_7721,_7723) --> 
    cc(ut,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

out0([out0,lit(opp),!,_7748],_7721,_7723) --> 
    cc(opp,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

out0([out0,[]],_7713,_7713) --> 
    [].

a0([a0,_7724],_7713,_7715) --> 
    a(_7724,_7713,_7715).

a0([a0,[]],_7713,_7713) --> 
    [].

a([a,lit(ett),_7749],_7727,_7729) --> 
    cc(ett,_7727,_7748),
    not_look_ahead(w(noun(time,_7706,def,_7708)),_7749,_7748,_7729).

a([a,lit(noen),lit(av),!],_7723,_7725) --> 
    cc(noen,_7723,_7744),
    cc(av,_7744,_7725),
    !.

a([a,lit(noen),_7754,_7783,_7812],_7732,_7734) --> 
    cc(noen,_7732,_7753),
    not_look_ahead([av],_7754,_7753,_7771),
    not_look_ahead([de],_7783,_7771,_7800),
    look_ahead_np(_7812,_7800,_7734).

a([a,lit(noe),_7747,_7776],_7725,_7727) --> 
    cc(noe,_7725,_7746),
    not_look_ahead([de],_7747,_7746,_7764),
    look_ahead_np(_7776,_7764,_7727).

a([a,_7731,_7755],_7720,_7722) --> 
    art1(_7731,_7720,_7746),
    optional([slik],_7755,_7746,_7722).

art([art,_7724],_7713,_7715) --> 
    a(_7724,_7713,_7715).

art([art,_7732,lit(eller),_7767],_7721,_7723) --> 
    a(_7732,_7721,_7747),
    cc(eller,_7747,_7766),
    more(_7767,_7766,_7723).

art([art,lit(de)],_7715,_7717) --> 
    cc(de,_7715,_7717).

art([art,lit(all)],_7715,_7717) --> 
    cc(all,_7715,_7717).

art([art,_7737,lit(alt)],_7726,_7728) --> 
    not_look_ahead(w(name(_7707,_7708,_7709)),_7737,_7726,_7754),
    cc(alt,_7754,_7728).

art([art,_7734,{}],_7723,_7725) --> 
    every(_7734,_7723,_7725),
    {user:(\+value(textflag,true))}.

art1([art1,lit(en)],_7715,_7717) --> 
    cc(en,_7715,_7717).

art1([art1,lit(et)],_7715,_7717) --> 
    cc(et,_7715,_7717).

art1([art1,lit(ei)],_7715,_7717) --> 
    cc(ei,_7715,_7717).

allsome0([allsome0,lit(noen),lit(av)],_7720,_7722) --> 
    cc(noen,_7720,_7741),
    cc(av,_7741,_7722).

allsome0([allsome0,_7727,!],_7716,_7718) --> 
    all(_7727,_7716,_7718),
    !.

allsome0([allsome0,[]],_7713,_7713) --> 
    [].

all0([all0,_7727,!],_7716,_7718) --> 
    all(_7727,_7716,_7718),
    !.

all0([all0,[]],_7713,_7713) --> 
    [].

all([all,_7724],_7713,_7715) --> 
    every(_7724,_7713,_7715).

always([always,lit(alltid)],_7715,_7717) --> 
    cc(alltid,_7715,_7717).

always([always,_7739,_7768],_7728,_7730) --> 
    w(adj2(whole,nil),_7739,_7728,_7756),
    w(noun(time,sin,def,n),_7768,_7756,_7730).

and0([and0,_7730,!,_7759],_7719,_7721) --> 
    and1(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

and0([and0,[]],_7713,_7713) --> 
    [].

andor0([andor0,_7730,!,_7759],_7719,_7721) --> 
    andor(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

andor0([andor0,[]],_7713,_7713) --> 
    [].

andor([andor,lit(og),!],_7718,_7720) --> 
    cc(og,_7718,_7720),
    !.

andor([andor,lit(eller),!],_7718,_7720) --> 
    cc(eller,_7718,_7720),
    !.

betwand0([betwand0,lit(å),!],_7718,_7720) --> 
    cc(å,_7718,_7720),
    !.

betwand0([betwand0,lit(og),!],_7718,_7720) --> 
    cc(og,_7718,_7720),
    !.

betwand0([betwand0,_7731,!],_7720,_7722) --> 
    w(prep(to),_7731,_7720,_7722),
    !.

betwand0([betwand0,[]],_7713,_7713) --> 
    [].

and1([and1,lit(og)],_7715,_7717) --> 
    cc(og,_7715,_7717).

and1([and1,lit(men),_7746],_7724,_7726) --> 
    cc(men,_7724,_7745),
    look_ahead_lit([en,et],_7746,_7745,_7726).

vmod_conjunction([vmod_conjunction,lit(mao)],_7715,_7717) --> 
    cc(mao,_7715,_7717).

vmod_conjunction([vmod_conjunction,lit(men),_7746],_7724,_7726) --> 
    cc(men,_7724,_7745),
    not_look_ahead_lit([med,nå],_7746,_7745,_7726).

vmod_conjunction([vmod_conjunction,_7786,_7815,_7859,_7888,_7917,_7946,_7975],_7775,_7777) --> 
    one_of_lit([og,eller],_7786,_7775,_7803),
    optional([så],_7815,_7803,_7847),
    not_look_ahead_lit([da,så,nå],_7859,_7847,_7876),
    not_look_ahead(w(prep(in)),_7888,_7876,_7905),
    not_look_ahead(w([ikveld]),_7917,_7905,_7934),
    not_look_ahead(w([imorgen]),_7946,_7934,_7963),
    not_look_ahead(w(name(_7720,_7721,_7722)),_7975,_7963,_7777).

andwhen0([andwhen0,_7733,_7757,!,_7786],_7722,_7724) --> 
    and1(_7733,_7722,_7748),
    when(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

andwhen0([andwhen0,[]],_7713,_7713) --> 
    [].

andwhere0([andwhere0,_7738,_7762,_7791,!,_7820],_7727,_7729) --> 
    and1(_7738,_7727,_7753),
    prep1(from,_7762,_7753,_7779),
    where(_7791,_7779,_7806),
    !,
    accept(_7820,_7806,_7729).

andwhere0([andwhere0,_7733,_7757,!,_7786],_7722,_7724) --> 
    and1(_7733,_7722,_7748),
    where(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

andwhere0([andwhere0,_7735,lit(hvorfra),!,_7775],_7724,_7726) --> 
    and1(_7735,_7724,_7750),
    cc(hvorfra,_7750,_7769),
    !,
    accept(_7775,_7769,_7726).

andwhere0([andwhere0,[]],_7713,_7713) --> 
    [].

np_conjunction(_7698,[np_conjunction,_7747,lit(det),_7787,!,_7816],_7733,_7735) --> 
    andor(_7712,_7747,_7733,_7764),
    cc(det,_7764,_7786),
    look_ahead_vp(_7787,_7786,_7802),
    !,
    reject(_7816,_7802,_7735).

np_conjunction(_7698,[np_conjunction,_7758,_7787,_7816,_7845],_7744,_7746) --> 
    andor(_7698,_7758,_7744,_7775),
    not_look_ahead_lit([da,så],_7787,_7775,_7804),
    not_look_ahead(w(prep(_7725)),_7816,_7804,_7833),
    not_look_ahead(['.'],_7845,_7833,_7746).

andor0(_7698,[andor0,_7733],_7719,_7721) --> 
    andor(_7698,_7733,_7719,_7721).

andor0(and,[andor0,{}],_7725,_7725) --> 
    {user:value(textflag,true)}.

andor(and,[andor,_7757,_7781,_7810],_7743,_7745) --> 
    and1(_7757,_7743,_7772),
    not_look_ahead(['.'],_7781,_7772,_7798),
    not_look_ahead_lit([jeg,mange,ikke,ingen,noen,disse,dette],_7810,_7798,_7745).

andor(or,[andor,lit(eller),_7755],_7730,_7732) --> 
    cc(eller,_7730,_7754),
    not_look_ahead(w(verb(_7707,_7708,_7709)),_7755,_7754,_7732).

andor(and,[andor,{},_7758,!,_7787],_7734,_7736) --> 
    {user:value(teleflag,true)},
    art(_7758,_7734,_7773),
    !,
    reject(_7787,_7773,_7736).

andor(and,[andor,{}],_7725,_7725) --> 
    {user:value(teleflag,true)}.

also0([also0,lit(også),lit(samtidig),!],_7723,_7725) --> 
    cc(også,_7723,_7744),
    cc(samtidig,_7744,_7725),
    !.

also0([also0,lit(samtidig),lit(også),!],_7723,_7725) --> 
    cc(samtidig,_7723,_7744),
    cc(også,_7744,_7725),
    !.

also0([also0,lit(også),!],_7718,_7720) --> 
    cc(også,_7718,_7720),
    !.

also0([also0,lit(samtidig),!],_7718,_7720) --> 
    cc(samtidig,_7718,_7720),
    !.

also0([also0,lit(deretter),!],_7718,_7720) --> 
    cc(deretter,_7718,_7720),
    !.

also0([also0,[]],_7713,_7713) --> 
    [].

anaa([anaa,_7730,_7754,!],_7719,_7721) --> 
    ann0(_7730,_7719,_7745),
    ogaa(_7754,_7745,_7721),
    !.

ogaa([ogaa,lit(å)],_7715,_7717) --> 
    cc(å,_7715,_7717).

ogaa([ogaa,lit(og)],_7715,_7717) --> 
    cc(og,_7715,_7717).

ann0([ann0,lit(an),!,_7748],_7721,_7723) --> 
    cc(an,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

ann0([ann0,[]],_7713,_7713) --> 
    [].

anorder(a,_7699,[anorder,_7745,_7769],_7728,_7730) --> 
    a(_7745,_7728,_7760),
    w(nb(_7699,ord),_7769,_7760,_7730).

anorder(the,_7699,[anorder,_7745,_7769],_7728,_7730) --> 
    the(_7745,_7728,_7760),
    w(nb(_7699,ord),_7769,_7760,_7730).

another([another,_7727,_7751],_7716,_7718) --> 
    a(_7727,_7716,_7742),
    other(_7751,_7742,_7718).

around0([around0,_7724],_7713,_7715) --> 
    around1(_7724,_7713,_7715).

around0([around0,[]],_7713,_7713) --> 
    [].

around1([around1,_7724],_7713,_7715) --> 
    ca(_7724,_7713,_7715).

around1([around1,lit(om),lit(lag)],_7720,_7722) --> 
    cc(om,_7720,_7741),
    cc(lag,_7741,_7722).

around1([around1,_7726],_7715,_7717) --> 
    prep1(around,_7726,_7715,_7717).

as([as,lit(som)],_7715,_7717) --> 
    cc(som,_7715,_7717).

as0([as0,_7724],_7713,_7715) --> 
    as(_7724,_7713,_7715).

as0([as0,[]],_7713,_7713) --> 
    [].

andsoon([andsoon,lit(og),_7740],_7718,_7720) --> 
    cc(og,_7718,_7739),
    sovidere0(_7740,_7739,_7720).

sovidere0([sovidere0,_7727,_7751],_7716,_7718) --> 
    sov0(_7727,_7716,_7742),
    videre0(_7751,_7742,_7718).

sov0([sov0,lit(så)],_7715,_7717) --> 
    cc(så,_7715,_7717).

sov0([sov0,[]],_7713,_7713) --> 
    [].

videre0([videre0,lit(videre)],_7715,_7717) --> 
    cc(videre,_7715,_7717).

videre0([videre0,[]],_7713,_7713) --> 
    [].

aspossible0([aspossible0,_7730,!,_7759],_7719,_7721) --> 
    aspossible(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

aspossible0([aspossible0,_7724],_7713,_7715) --> 
    possible0(_7724,_7713,_7715).

aspossible([aspossible,_7732,_7756],_7721,_7723) --> 
    as(_7732,_7721,_7747),
    w(adj2(possible,nil),_7756,_7747,_7723).

aso0([aso0,lit(så),!,_7748],_7721,_7723) --> 
    cc(så,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

aso0([aso0,_7730,!,_7759],_7719,_7721) --> 
    too(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

aso0([aso0,_7724],_7713,_7715) --> 
    as(_7724,_7713,_7715).

aso0([aso0,[]],_7713,_7713) --> 
    [].

at([at,_7726],_7715,_7717) --> 
    prep(at,_7726,_7715,_7717).

athe([athe,_7724],_7713,_7715) --> 
    the(_7724,_7713,_7715).

athe([athe,_7724],_7713,_7715) --> 
    a(_7724,_7713,_7715).

athe0([athe0,_7727,!],_7716,_7718) --> 
    athe(_7727,_7716,_7718),
    !.

athe0([athe0,[]],_7713,_7713) --> 
    [].

blei(_7698,[blei,_7756,_7785,_7814,!],_7742,_7744) --> 
    w(verb(stand,pres,fin),_7756,_7742,_7773),
    negation0(_7698,_7785,_7773,_7802),
    look_ahead(w(verb(_7721,past,part)),_7814,_7802,_7744),
    !.

blei(_7698,[blei,_7736,_7760],_7722,_7724) --> 
    blei(_7736,_7722,_7751),
    negation0(_7698,_7760,_7751,_7724).

blei([blei,_7744,_7773,!],_7733,_7735) --> 
    w(verb(stand,pres,fin),_7744,_7733,_7761),
    look_ahead(w(verb(_7714,past,part)),_7773,_7761,_7735),
    !.

blei([blei,_7733,!],_7722,_7724) --> 
    w(verb(be,_7704,fin),_7733,_7722,_7724),
    !.

blei([blei,_7739,_7763,_7787,!],_7728,_7730) --> 
    has(_7739,_7728,_7754),
    redundant0(_7763,_7754,_7778),
    w(verb(be,past,part),_7787,_7778,_7730),
    !.

blei([blei,_7736,_7760,!],_7725,_7727) --> 
    aux1(_7736,_7725,_7751),
    w(verb(be,past,part),_7760,_7751,_7727),
    !.

blei([blei,_7736,_7760,!],_7725,_7727) --> 
    aux1(_7736,_7725,_7751),
    w(verb(be,inf,fin),_7760,_7751,_7727),
    !.

aux0(_7698,_7699,[aux0,_7743,!],_7726,_7728) --> 
    aux1(_7698,_7699,_7743,_7726,_7728),
    !.

aux0(id,pres,[aux0,_7737],_7720,_7722) --> 
    aux0(_7737,_7720,_7722).

auxs0(_7698,_7699,[auxs0,_7743,!],_7726,_7728) --> 
    aux1(_7698,_7699,_7743,_7726,_7728),
    !.

auxs0(_7698,_7699,[auxs0,[]],_7720,_7720) --> 
    [].

auxs([auxs,_7727,_7751],_7716,_7718) --> 
    aux1(_7727,_7716,_7742),
    auxs0(_7751,_7742,_7718).

auxs0([auxs0,_7730,!,_7759],_7719,_7721) --> 
    aux1(_7730,_7719,_7745),
    !,
    auxs0(_7759,_7745,_7721).

auxs0([auxs0,[]],_7713,_7713) --> 
    [].

aux1(_7698,pres,[aux1,lit(kan),_7772,_7796,_7825,!],_7744,_7746) --> 
    cc(kan,_7744,_7771),
    redundant0(_7772,_7771,_7787),
    negation0(_7698,_7796,_7787,_7813),
    look_ahead(w(verb(_7721,_7722,_7723)),_7825,_7813,_7746),
    !.

aux1(_7698,past,[aux1,lit(kunne),_7769,_7798,!],_7741,_7743) --> 
    cc(kunne,_7741,_7768),
    negation0(_7698,_7769,_7768,_7786),
    look_ahead(w(verb(_7718,_7719,_7720)),_7798,_7786,_7743),
    !.

aux1(_7698,past,[aux1,lit(burde),_7758,!],_7730,_7732) --> 
    cc(burde,_7730,_7757),
    negation0(_7698,_7758,_7757,_7732),
    !.

aux1(_7698,past,[aux1,lit(kunne),_7758,!],_7730,_7732) --> 
    cc(kunne,_7730,_7757),
    negation0(_7698,_7758,_7757,_7732),
    !.

aux1(_7698,pres,[aux1,_7742,_7766],_7725,_7727) --> 
    aux1(_7742,_7725,_7757),
    negation0(_7698,_7766,_7757,_7727).

skalsaa([skalsaa,_7727,_7751],_7716,_7718) --> 
    aux1(_7727,_7716,_7742),
    so0(_7751,_7742,_7718).

faux1([faux1,_7733,!],_7722,_7724) --> 
    w(verb(get,_7704,fin),_7733,_7722,_7724),
    !.

faux1([faux1,_7724],_7713,_7715) --> 
    aux1(_7724,_7713,_7715).

aux1([aux1,_7755,_7784,_7813,!],_7744,_7746) --> 
    one_of_lit([kan,kunne,får,fikk],_7755,_7744,_7772),
    not_look_ahead([nå],_7784,_7772,_7801),
    look_ahead(w(verb(_7725,inf,_7727)),_7813,_7801,_7746),
    !.

aux1([aux1,_7730],_7719,_7721) --> 
    one_of_lit([kan,kunne],_7730,_7719,_7721).

aux1([aux1,_7742],_7731,_7733) --> 
    one_of_lit([bør,burde,må,måtte,skal,skulle,vil,ville],_7742,_7731,_7733).

aux10([aux10,_7727,!],_7716,_7718) --> 
    aux1(_7727,_7716,_7718),
    !.

aux10([aux10,[]],_7713,_7713) --> 
    [].

aux0([aux0,_7738,_7762,!],_7727,_7729) --> 
    faa(_7738,_7727,_7753),
    look_ahead(w(verb(_7708,_7709,_7710)),_7762,_7753,_7729),
    !.

aux0([aux0,lit(må)],_7715,_7717) --> 
    cc(må,_7715,_7717).

aux0([aux0,_7748,lit(så),_7783,lit(å),!,_7828],_7737,_7739) --> 
    be(_7748,_7737,_7763),
    cc(så,_7763,_7782),
    w(adj2(good,nil),_7783,_7782,_7800),
    cc(å,_7800,_7822),
    !,
    accept(_7828,_7822,_7739).

aux0([aux0,_7724],_7713,_7715) --> 
    do(_7724,_7713,_7715).

aux0([aux0,[]],_7713,_7713) --> 
    [].

paux0([paux0,_7732,lit(blitt),!],_7721,_7723) --> 
    has(_7732,_7721,_7747),
    cc(blitt,_7747,_7723),
    !.

paux0([paux0,lit(vil),lit(bli),!],_7723,_7725) --> 
    cc(vil,_7723,_7744),
    cc(bli,_7744,_7725),
    !.

paux0([paux0,lit(_7703),{},!],_7746,_7748) --> 
    cc(_7703,_7746,_7748),
    {user:testmember(_7703,[skal,vil,bør,må,kan,skulle,ville,burde,måtte,kunne])},
    !.

paux0([paux0,[]],_7713,_7713) --> 
    [].

do(_7698,[do,_7739,_7763,_7792],_7725,_7727) --> 
    use(_7739,_7725,_7754),
    negation0(_7698,_7763,_7754,_7780),
    infinitive(_7792,_7780,_7727).

do(_7698,[do,_7739,_7763,_7792],_7725,_7727) --> 
    do(_7739,_7725,_7754),
    negation0(_7698,_7763,_7754,_7780),
    hasto0(_7792,_7780,_7727).

do(id,[do,[]],_7717,_7717) --> 
    [].

do0([do0,_7724],_7713,_7715) --> 
    do(_7724,_7713,_7715).

do0([do0,[]],_7713,_7713) --> 
    [].

docan([docan,lit(kan)],_7715,_7717) --> 
    cc(kan,_7715,_7717).

docan([docan,lit(må)],_7715,_7717) --> 
    cc(må,_7715,_7717).

docan([docan,lit(får)],_7715,_7717) --> 
    cc(får,_7715,_7717).

docan([docan,_7727,!],_7716,_7718) --> 
    do(_7727,_7716,_7718),
    !.

do([do,_7740,_7764,!,_7798],_7729,_7731) --> 
    faa(_7740,_7729,_7755),
    w(noun(information,_7710,_7711,_7712),_7764,_7755,_7781),
    !,
    reject(_7798,_7781,_7731).

do([do,lit(vil),lit(vil),!,_7764],_7726,_7728) --> 
    cc(vil,_7726,_7747),
    cc(vil,_7747,_7758),
    !,
    accept(_7764,_7758,_7728).

do([do,_7724],_7713,_7715) --> 
    skalsaa(_7724,_7713,_7715).

do([do,_7724],_7713,_7715) --> 
    may(_7724,_7713,_7715).

do([do,_7724],_7713,_7715) --> 
    must(_7724,_7713,_7715).

may([may,lit(kan),_7748],_7726,_7728) --> 
    cc(kan,_7726,_7747),
    look_ahead(w(verb(_7705,_7706,_7707)),_7748,_7747,_7728).

may([may,lit(får),_7748],_7726,_7728) --> 
    cc(får,_7726,_7747),
    look_ahead(w(verb(_7705,_7706,_7707)),_7748,_7747,_7728).

may([may,lit(bør)],_7715,_7717) --> 
    cc(bør,_7715,_7717).

may([may,lit(må)],_7715,_7717) --> 
    cc(må,_7715,_7717).

must([must,lit(må)],_7715,_7717) --> 
    cc(må,_7715,_7717).

must([must,lit(skal)],_7715,_7717) --> 
    cc(skal,_7715,_7717).

be(_7698,[be,_7762,_7791,_7820,!,_7849,{}],_7748,_7750) --> 
    w(verb(hold,_7724,fin),_7762,_7748,_7779),
    negation0(_7717,_7791,_7779,_7808),
    rfxpron(_7820,_7808,_7835),
    !,
    negation0(_7718,_7849,_7835,_7750),
    {user:bigno(_7717,_7718,_7698)}.

be(_7698,[be,_7739,!,_7773],_7725,_7727) --> 
    be1(_7698,_7739,_7725,_7756),
    !,
    accept(_7773,_7756,_7727).

be(not,[be,_7734,_7758],_7720,_7722) --> 
    not(_7734,_7720,_7749),
    be(_7758,_7749,_7722).

be(id,[be,_7731],_7717,_7719) --> 
    be(_7731,_7717,_7719).

be0([be0,_7726],_7715,_7717) --> 
    optional(be,_7726,_7715,_7717).

be([be,_7736,_7760,!],_7725,_7727) --> 
    aux1(_7736,_7725,_7751),
    w(verb(be,inf,fin),_7760,_7751,_7727),
    !.

be([be,_7745,_7774,_7798,!],_7734,_7736) --> 
    w(verb(have,_7710,fin),_7745,_7734,_7762),
    redundant0(_7774,_7762,_7789),
    w(verb(be,past,part),_7798,_7789,_7736),
    !.

be([be,_7733,!],_7722,_7724) --> 
    w(verb(be,_7704,part),_7733,_7722,_7724),
    !.

be([be,_7736,_7765,!],_7725,_7727) --> 
    w(verb(be,_7707,fin),_7736,_7725,_7753),
    been0(_7765,_7753,_7727),
    !.

be1(_7698,[be1,_7745,_7774,_7798],_7731,_7733) --> 
    w(verb(be,_7711,fin),_7745,_7731,_7762),
    redundant0(_7774,_7762,_7789),
    negation0(_7698,_7798,_7789,_7733).

be1(_7698,[be1,_7748,_7772,_7796,_7825],_7734,_7736) --> 
    aux1(_7748,_7734,_7763),
    redundant0(_7772,_7763,_7787),
    negation0(_7698,_7796,_7787,_7813),
    w(verb(be,inf,fin),_7825,_7813,_7736).

be1(_7698,[be1,_7754,_7783,_7807,_7841,!],_7740,_7742) --> 
    negation0(_7712,_7754,_7740,_7771),
    aux1(_7783,_7771,_7798),
    negation2(_7712,_7698,_7807,_7798,_7826),
    w(verb(be,inf,fin),_7841,_7826,_7742),
    !.

be1(_7698,[be1,_7754,_7783,_7812,!],_7740,_7742) --> 
    w(verb(have,_7712,fin),_7754,_7740,_7771),
    negation0(_7698,_7783,_7771,_7800),
    w(verb(be,past,part),_7812,_7800,_7742),
    !.

be1(_7698,[be1,_7745,_7774,_7798,_7822],_7731,_7733) --> 
    negation0(_7709,_7745,_7731,_7762),
    be(_7774,_7762,_7789),
    redundant0(_7798,_7789,_7813),
    negation2(_7709,_7698,_7822,_7813,_7733).

be1(_7698,[be1,_7747,_7776,lit(blitt)],_7733,_7735) --> 
    w(verb(have,_7711,fin),_7747,_7733,_7764),
    negation0(_7698,_7776,_7764,_7793),
    cc(blitt,_7793,_7735).

be1(id,[be1,lit(blitt)],_7719,_7721) --> 
    cc(blitt,_7719,_7721).

be1(not,[be1,_7745,_7774,_7803],_7731,_7733) --> 
    w(verb(reject,_7709,fin),_7745,_7731,_7762),
    prep(to,_7774,_7762,_7791),
    be(_7803,_7791,_7733).

be_truefalse_that(_7698,[be_truefalse_that,_7765,{},_7804,lit(ut),_7844,!],_7751,_7753) --> 
    w(verb(_7717,_7718,fin),_7765,_7751,_7782),
    {user:testmember(_7717,[look,see])},
    negation0(_7698,_7804,_7782,_7821),
    cc(ut,_7821,_7843),
    somatom0(_7844,_7843,_7753),
    !.

be_truefalse_that(_7698,[be_truefalse_that,_7765,{},_7804,lit(ut),_7844,!],_7751,_7753) --> 
    w(verb(_7717,_7718,fin),_7765,_7751,_7782),
    {user:testmember(_7717,[look,see])},
    negation0(_7698,_7804,_7782,_7821),
    cc(ut,_7821,_7843),
    somatom0(_7844,_7843,_7753),
    !.

be_truefalse_that(_7698,[be_truefalse_that,_7760,{},_7799,_7828,!],_7746,_7748) --> 
    w(verb(_7714,_7715,fin),_7760,_7746,_7777),
    {user:testmember(_7714,[appear,be])},
    negation0(_7698,_7799,_7777,_7816),
    somatom0(_7828,_7816,_7748),
    !.

somatom0([somatom0,_7727,!],_7716,_7718) --> 
    somatom(_7727,_7716,_7718),
    !.

somatom0([somatom0,[]],_7713,_7713) --> 
    [].

somatom([somatom,_7737,lit(at),!],_7726,_7728) --> 
    w(adj2(true,nil),_7737,_7726,_7754),
    cc(at,_7754,_7728),
    !.

somatom([somatom,lit(som),lit(at),!],_7723,_7725) --> 
    cc(som,_7723,_7744),
    cc(at,_7744,_7725),
    !.

somatom([somatom,lit(som),lit(om),!],_7723,_7725) --> 
    cc(som,_7723,_7744),
    cc(om,_7744,_7725),
    !.

somatom([somatom,lit(som)],_7715,_7717) --> 
    cc(som,_7715,_7717).

somatom([somatom,lit(at)],_7715,_7717) --> 
    cc(at,_7715,_7717).

somatom([somatom,lit(til),lit(at),!],_7723,_7725) --> 
    cc(til,_7723,_7744),
    cc(at,_7744,_7725),
    !.

somatom([somatom,lit(til)],_7715,_7717) --> 
    cc(til,_7715,_7717).

be_truefalse_that(_7698,[be_truefalse_that,_7762,_7791,_7825,_7854,!],_7748,_7750) --> 
    w(verb(_7714,_7715,fin),_7762,_7748,_7779),
    gmem(_7714,[agree,appear],_7791,_7779,_7810),
    negation0(_7698,_7825,_7810,_7842),
    optional([at],_7854,_7842,_7750),
    !.

be_truefalse_that(_7698,[be_truefalse_that,_7752,_7781,_7810,!],_7738,_7740) --> 
    negation0(_7698,_7752,_7738,_7769),
    one_of_lit([så,slik],_7781,_7769,_7798),
    optional([at],_7810,_7798,_7740),
    !.

be_truefalse_that(id,[be_truefalse_that,_7752,_7781,lit(at),!],_7738,_7740) --> 
    w(verb(show,_7712,fin),_7752,_7738,_7769),
    optional([seg],_7781,_7769,_7813),
    cc(at,_7813,_7740),
    !.

be_truefalse_that(_7698,[be_truefalse_that,_7765,{},_7804,lit(ut),_7844,!],_7751,_7753) --> 
    w(verb(_7717,_7718,fin),_7765,_7751,_7782),
    {user:testmember(_7717,[see,look])},
    negation0(_7698,_7804,_7782,_7821),
    cc(ut,_7821,_7843),
    somatom(_7844,_7843,_7753),
    !.

be_truefalse_that(_7698,[be_truefalse_that,_7760,{},_7799,_7828,!],_7746,_7748) --> 
    w(verb(_7714,_7715,fin),_7760,_7746,_7777),
    {user:testmember(_7714,[be,appear])},
    negation0(_7698,_7799,_7777,_7816),
    somatom(_7828,_7816,_7748),
    !.

be_truefalse_that(_7698,[be_truefalse_that,_7743,_7772,!],_7729,_7731) --> 
    be_truefalse(_7698,_7743,_7729,_7760),
    optional([at],_7772,_7760,_7731),
    !.

be_truefalse(_7698,[be_truefalse,_7760,{},_7799,_7828,!],_7746,_7748) --> 
    w(verb(_7714,_7715,fin),_7760,_7746,_7777),
    {user:testmember(_7714,[be,appear])},
    negation0(_7698,_7799,_7777,_7816),
    somatom(_7828,_7816,_7748),
    !.

be_truefalse(_7698,[be_truefalse,_7752,_7801,!],_7738,_7740) --> 
    lexvaccept(rv,_7707,_7708,fin,_7698,_7752,_7738,_7777),
    gmem(_7707,[stand,mean2,indicate],_7801,_7777,_7740),
    !.

be_truefalse(_7698,[be_truefalse,_7767,{},_7806,lit(ut),lit(til),!],_7753,_7755) --> 
    w(verb(_7717,_7718,fin),_7767,_7753,_7784),
    {user:testmember(_7717,[see,look])},
    negation0(_7698,_7806,_7784,_7823),
    cc(ut,_7823,_7845),
    cc(til,_7845,_7755),
    !.

be_truefalse(_7698,[be_truefalse,_7767,{},_7806,lit(ut),lit(for),!],_7753,_7755) --> 
    w(verb(_7717,_7718,fin),_7767,_7753,_7784),
    {user:testmember(_7717,[see,look])},
    negation0(_7698,_7806,_7784,_7823),
    cc(ut,_7823,_7845),
    cc(for,_7845,_7755),
    !.

be_truefalse(_7698,[be_truefalse,_7767,{},_7806,lit(ut),lit(som),!],_7753,_7755) --> 
    w(verb(_7717,_7718,fin),_7767,_7753,_7784),
    {user:testmember(_7717,[see,look])},
    negation0(_7698,_7806,_7784,_7823),
    cc(ut,_7823,_7845),
    cc(som,_7845,_7755),
    !.

be_truefalse(_7698,[be_truefalse,_7745,!,_7779],_7731,_7733) --> 
    w(verb(agree,_7711,fin),_7745,_7731,_7762),
    !,
    negation0(_7698,_7779,_7762,_7733).

be_truefalse(_7698,[be_truefalse,_7736,_7760],_7722,_7724) --> 
    be(_7736,_7722,_7751),
    truefalse(_7698,_7760,_7751,_7724).

be_truefalse(not,[be_truefalse,_7746,_7775,_7799,_7823],_7732,_7734) --> 
    w(verb(reject,_7712,fin),_7746,_7732,_7763),
    infinitive(_7775,_7763,_7790),
    be(_7799,_7790,_7814),
    true(_7823,_7814,_7734).

been0([been0,_7730,!,_7759],_7719,_7721) --> 
    been(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

been0([been0,[]],_7713,_7713) --> 
    [].

been([been,_7730],_7719,_7721) --> 
    w(verb(be,past,part),_7730,_7719,_7721).

betake([betake,_7724],_7713,_7715) --> 
    be(_7724,_7713,_7715).

betake([betake,_7730],_7719,_7721) --> 
    w(verb(take,_7701,fin),_7730,_7719,_7721).

both0([both0,lit(både)],_7715,_7717) --> 
    cc(både,_7715,_7717).

both0([both0,[]],_7713,_7713) --> 
    [].

by([by,lit(av),_7744],_7722,_7724) --> 
    cc(av,_7722,_7743),
    not_look_ahead([hensyn],_7744,_7743,_7724).

ca0([ca0,_7730,!,_7759],_7719,_7721) --> 
    ca(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

ca0([ca0,[]],_7713,_7713) --> 
    [].

ca([ca,_7735,_7764,!,_7793],_7724,_7726) --> 
    prep1(around,_7735,_7724,_7752),
    point0(_7764,_7752,_7779),
    !,
    accept(_7793,_7779,_7726).

clock0([clock0,_7724],_7713,_7715) --> 
    clock(_7724,_7713,_7715).

clock0([clock0,[]],_7713,_7713) --> 
    [].

clock([clock,lit(k),_7750,!],_7728,_7730) --> 
    cc(k,_7728,_7749),
    look_ahead(w(nb(_7710,_7711)),_7750,_7749,_7730),
    !.

clock([clock,lit(k),_7753,_7777,!],_7731,_7733) --> 
    cc(k,_7731,_7752),
    point(_7753,_7752,_7768),
    look_ahead(w(nb(_7713,_7714)),_7777,_7768,_7733),
    !.

clock([clock,lit(kl),_7743,!],_7721,_7723) --> 
    cc(kl,_7721,_7742),
    colon(_7743,_7742,_7723),
    !.

clock([clock,_7733,_7757,_7781,_7805],_7722,_7724) --> 
    point0(_7733,_7722,_7748),
    klokken(_7757,_7748,_7772),
    point0(_7781,_7772,_7796),
    ca0(_7805,_7796,_7724).

clock([clock,_7730,_7754,_7778],_7719,_7721) --> 
    point0(_7730,_7719,_7745),
    klokken(_7754,_7745,_7769),
    colon0(_7778,_7769,_7721).

klokken([klokken,lit(kl)],_7715,_7717) --> 
    cc(kl,_7715,_7717).

klokken([klokken,_7731],_7720,_7722) --> 
    w(noun(clock,sin,_7702,n),_7731,_7720,_7722).

colon0([colon0,_7730,!,_7759],_7719,_7721) --> 
    colon(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

colon0([colon0,_7728],_7717,_7719) --> 
    not_look_ahead(['.'],_7728,_7717,_7719).

colon([colon,lit(:)],_7715,_7717) --> 
    cc(:,_7715,_7717).

colon([colon,lit(;)],_7715,_7717) --> 
    cc(;,_7715,_7717).

comparator1(_7698,[comparator1,_7736,!],_7722,_7724) --> 
    comparel(_7698,_7736,_7722,_7724),
    !.

comparel(eq,[comparel,_7734,_7758],_7720,_7722) --> 
    equal(_7734,_7720,_7749),
    tomed0(_7758,_7749,_7722).

comparel(ge,[comparel,_7743,_7767,_7791,_7815,_7839],_7729,_7731) --> 
    greater(_7743,_7729,_7758),
    than0(_7767,_7758,_7782),
    or1(_7791,_7782,_7806),
    equal(_7815,_7806,_7830),
    to0(_7839,_7830,_7731).

comparel(ge,[comparel,_7737,_7761,_7785],_7723,_7725) --> 
    not(_7737,_7723,_7752),
    less(_7761,_7752,_7776),
    than(_7785,_7776,_7725).

comparel(ge,[comparel,lit(minst)],_7719,_7721) --> 
    cc(minst,_7719,_7721).

comparel(gt,[comparel,_7734,_7758],_7720,_7722) --> 
    greater(_7734,_7720,_7749),
    than(_7758,_7749,_7722).

comparel(gt,[comparel,lit(mer),_7747],_7722,_7724) --> 
    cc(mer,_7722,_7746),
    than(_7747,_7746,_7724).

comparel(gt,[comparel,_7733],_7719,_7721) --> 
    prep1(over,_7733,_7719,_7721).

comparel(le,[comparel,_7743,_7767,_7791,_7815,_7839],_7729,_7731) --> 
    less(_7743,_7729,_7758),
    than0(_7767,_7758,_7782),
    or1(_7791,_7782,_7806),
    equal(_7815,_7806,_7830),
    to0(_7839,_7830,_7731).

comparel(le,[comparel,_7737,_7761,_7785],_7723,_7725) --> 
    not(_7737,_7723,_7752),
    more(_7761,_7752,_7776),
    than(_7785,_7776,_7725).

comparel(le,[comparel,_7737,_7761,_7785],_7723,_7725) --> 
    not(_7737,_7723,_7752),
    greater(_7761,_7752,_7776),
    than(_7785,_7776,_7725).

comparel(le,[comparel,_7734,_7758],_7720,_7722) --> 
    at(_7734,_7720,_7749),
    most(_7758,_7749,_7722).

comparel(lt,[comparel,_7734,_7758],_7720,_7722) --> 
    less(_7734,_7720,_7749),
    than(_7758,_7749,_7722).

comparel(ne,[comparel,lit(forskjellig),_7749],_7724,_7726) --> 
    cc(forskjellig,_7724,_7748),
    prep1(from,_7749,_7748,_7726).

comparel(ne,[comparel,lit(annet),lit(enn)],_7724,_7726) --> 
    cc(annet,_7724,_7748),
    cc(enn,_7748,_7726).

comparel(ne,[comparel,lit(ulik)],_7719,_7721) --> 
    cc(ulik,_7719,_7721).

comparel(ne,[comparel,lit(unntatt)],_7719,_7721) --> 
    cc(unntatt,_7719,_7721).

comparel(ne,[comparel,_7734,_7758],_7720,_7722) --> 
    unequal(_7734,_7720,_7749),
    to0(_7758,_7749,_7722).

comparel(_7698,[comparel,_7741,lit(enn)],_7727,_7729) --> 
    w(adj2(_7698,comp),_7741,_7727,_7758),
    cc(enn,_7758,_7729).

comparel(_7698,[comparel,lit(mer),_7757,lit(enn)],_7732,_7734) --> 
    cc(mer,_7732,_7756),
    w(adj2(_7698,nil),_7757,_7756,_7774),
    cc(enn,_7774,_7734).

comparator2(gt,intelligent,[comparator2,_7745,_7774],_7728,_7730) --> 
    w(adj2(intelligent,nil),_7745,_7728,_7762),
    than(_7774,_7762,_7730).

comparator2(lt,intelligent,[comparator2,_7745,_7774],_7728,_7730) --> 
    w(adj2(stupid,nil),_7745,_7728,_7762),
    than(_7774,_7762,_7730).

comparator2(gt,quality,[comparator2,_7745,_7774],_7728,_7730) --> 
    w(adj2(good,comp),_7745,_7728,_7762),
    than(_7774,_7762,_7730).

comparator2(gt,age,[comparator2,_7740,_7764],_7723,_7725) --> 
    older(_7740,_7723,_7755),
    than(_7764,_7755,_7725).

comparator2(lt,age,[comparator2,_7740,_7764],_7723,_7725) --> 
    younger(_7740,_7723,_7755),
    than(_7764,_7755,_7725).

comparator2(gt,latitude,[comparator2,lit(nord),lit(for)],_7727,_7729) --> 
    cc(nord,_7727,_7754),
    cc(for,_7754,_7729).

comparator2(lt,latitude,[comparator2,lit(sør),lit(for)],_7727,_7729) --> 
    cc(sør,_7727,_7754),
    cc(for,_7754,_7729).

comparator2(gt,longitude,[comparator2,lit(vest),lit(for)],_7727,_7729) --> 
    cc(vest,_7727,_7754),
    cc(for,_7754,_7729).

comparator2(lt,longitude,[comparator2,lit(øst),lit(for)],_7727,_7729) --> 
    cc(øst,_7727,_7754),
    cc(for,_7754,_7729).

comparator2(gt,size,[comparator2,_7740,_7764],_7723,_7725) --> 
    greater(_7740,_7723,_7755),
    than(_7764,_7755,_7725).

comparator2(lt,size,[comparator2,lit(mindre),_7753],_7725,_7727) --> 
    cc(mindre,_7725,_7752),
    than(_7753,_7752,_7727).

comparator3(eq,_7699,[comparator3,lit(like),_7763,lit(som)],_7735,_7737) --> 
    cc(like,_7735,_7762),
    w(adj2(_7699,nil),_7763,_7762,_7780),
    cc(som,_7780,_7737).

comparator3(gt,_7699,[comparator3,lit(mer),_7763,lit(enn)],_7735,_7737) --> 
    cc(mer,_7735,_7762),
    w(adj2(_7699,nil),_7763,_7762,_7780),
    cc(enn,_7780,_7737).

comparator3(lt,_7699,[comparator3,lit(mindre),_7763,lit(enn)],_7735,_7737) --> 
    cc(mindre,_7735,_7762),
    w(adj2(_7699,nil),_7763,_7762,_7780),
    cc(enn,_7780,_7737).

comparator3(lt,_7699,[comparator3,lit(ikke),lit(så),_7779,lit(som)],_7740,_7742) --> 
    cc(ikke,_7740,_7767),
    cc(så,_7767,_7778),
    w(adj2(_7699,nil),_7779,_7778,_7796),
    cc(som,_7796,_7742).

comparator3(ge,_7699,[comparator3,lit(minst),lit(like),_7779,lit(som)],_7740,_7742) --> 
    cc(minst,_7740,_7767),
    cc(like,_7767,_7778),
    w(adj2(_7699,nil),_7779,_7778,_7796),
    cc(som,_7796,_7742).

comparator3(le,_7699,[comparator3,lit(høyst),lit(så),_7779,lit(som)],_7740,_7742) --> 
    cc(høyst,_7740,_7767),
    cc(så,_7767,_7778),
    w(adj2(_7699,nil),_7779,_7778,_7796),
    cc(som,_7796,_7742).

superlative(_7698,_7699,[superlative,_7752,_7791,!,_7825],_7735,_7737) --> 
    filanepr(_7698,_7711,_7699,_7752,_7735,_7773),
    quant1(_7711,_7791,_7773,_7808),
    !,
    accept(_7825,_7808,_7737).

superlative(_7698,_7699,[superlative,_7746,_7775],_7729,_7731) --> 
    quant0(_7705,_7746,_7729,_7763),
    filanepr(_7698,_7705,_7699,_7775,_7763,_7731).

flnp(_7698,[flnp,_7750,_7779],_7736,_7738) --> 
    w(adj2(_7698,nil),_7750,_7736,_7767),
    gmem(_7698,[first,last,next,previous],_7779,_7767,_7738).

flnp(next,[flnp,lit(nest)],_7719,_7721) --> 
    cc(nest,_7719,_7721).

flnp(last,[flnp,_7739,!],_7725,_7727) --> 
    w(adj2(late,sup),_7739,_7725,_7727),
    !.

flnp(first,[flnp,_7736],_7722,_7724) --> 
    w(nb(1,ord),_7736,_7722,_7724).

flnpproper(_7698,[flnpproper,lit(først),!,_7755],_7725,_7727) --> 
    cc(først,_7725,_7749),
    !,
    reject(_7755,_7749,_7727).

flnpproper(_7698,[flnpproper,lit(sist),!,_7755],_7725,_7727) --> 
    cc(sist,_7725,_7749),
    !,
    reject(_7755,_7749,_7727).

flnpproper(_7698,[flnpproper,lit(nest),!,_7755],_7725,_7727) --> 
    cc(nest,_7725,_7749),
    !,
    reject(_7755,_7749,_7727).

flnpproper(_7698,[flnpproper,_7733],_7719,_7721) --> 
    flnp(_7698,_7733,_7719,_7721).

filanepr([filanepr,_7732,!],_7721,_7723) --> 
    w(adj2(first,nil),_7732,_7721,_7723),
    !.

filanepr([filanepr,_7732,!],_7721,_7723) --> 
    w(adj2(last,nil),_7732,_7721,_7723),
    !.

filanepr([filanepr,_7732,!],_7721,_7723) --> 
    w(adj2(next,nil),_7732,_7721,_7723),
    !.

filanepr([filanepr,_7732,!],_7721,_7723) --> 
    w(adj2(previous,nil),_7732,_7721,_7723),
    !.

filanepr(min(_7699),_7699,time,[filanepr,_7745],_7725,_7727) --> 
    first(_7745,_7725,_7727).

filanepr(max(_7699),_7699,time,[filanepr,_7745],_7725,_7727) --> 
    latest(_7745,_7725,_7727).

filanepr(min(_7699),_7699,next,[filanepr,_7745],_7725,_7727) --> 
    next(_7745,_7725,_7727).

filanepr(max(_7699),_7699,previous,[filanepr,_7745],_7725,_7727) --> 
    previous(_7745,_7725,_7727).

filanepr(max(_7699),_7699,size,[filanepr,_7745],_7725,_7727) --> 
    greatest(_7745,_7725,_7727).

filanepr(min(_7699),_7699,size,[filanepr,lit(minste)],_7727,_7729) --> 
    cc(minste,_7727,_7729).

faaverb(_7698,[faaverb,_7743,_7767,!],_7729,_7731) --> 
    faa(_7743,_7729,_7758),
    w(verb(_7698,_7709,_7710),_7767,_7758,_7731),
    !.

faaverb(_7698,[faaverb,_7740,!],_7726,_7728) --> 
    w(verb(_7698,inf,fin),_7740,_7726,_7728),
    !.

da0([da0,lit(da),!,_7748],_7721,_7723) --> 
    cc(da,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

da0([da0,[]],_7713,_7713) --> 
    [].

de0([de0,lit(de),!,_7748],_7721,_7723) --> 
    cc(de,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

de0([de0,[]],_7713,_7713) --> 
    [].

dendagen(_7698,[dendagen,lit(om),_7758,_7787,!,_7816],_7733,_7735) --> 
    cc(om,_7733,_7757),
    day(_7698,_7758,_7757,_7775),
    den0(_7787,_7775,_7802),
    !,
    accept(_7816,_7802,_7735).

dendagen(nil,[dendagen,_7740,_7764,!,_7793],_7726,_7728) --> 
    today(_7740,_7726,_7755),
    den0(_7764,_7755,_7779),
    !,
    accept(_7793,_7779,_7728).

dendagen(nil,[dendagen,_7740,_7764,!,_7793],_7726,_7728) --> 
    yesterday(_7740,_7726,_7755),
    den0(_7764,_7755,_7779),
    !,
    accept(_7793,_7779,_7728).

dendagen(nil,[dendagen,_7740,_7764,!,_7793],_7726,_7728) --> 
    tomorrow(_7740,_7726,_7755),
    den0(_7764,_7755,_7779),
    !,
    accept(_7793,_7779,_7728).

dendagen(_7698,[dendagen,_7745,_7769,_7798,!,_7827],_7731,_7733) --> 
    on0(_7745,_7731,_7760),
    day(_7698,_7769,_7760,_7786),
    den0(_7798,_7786,_7813),
    !,
    accept(_7827,_7813,_7733).

dendagen(nil,[dendagen,_7742,lit(den),!,_7782],_7728,_7730) --> 
    on0(_7742,_7728,_7757),
    cc(den,_7757,_7776),
    !,
    accept(_7782,_7776,_7730).

dendagen(nil,[dendagen,_7742,_7771,!,_7800],_7728,_7730) --> 
    prep1(for,_7742,_7728,_7759),
    den0(_7771,_7759,_7786),
    !,
    accept(_7800,_7786,_7730).

dendagen(nil,[dendagen,_7739,!,_7773],_7725,_7727) --> 
    prep1(on,_7739,_7725,_7756),
    !,
    accept(_7773,_7756,_7727).

der0([der0,lit(der),_7746,!,_7775],_7724,_7726) --> 
    cc(der,_7724,_7745),
    qm0(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

der0([der0,_7724],_7713,_7715) --> 
    qm0(_7724,_7713,_7715).

qm0([qm0,lit(?)],_7715,_7717) --> 
    cc(?,_7715,_7717).

qm0([qm0,[]],_7713,_7713) --> 
    [].

detsamme([detsamme,lit(en),lit(gang)],_7720,_7722) --> 
    cc(en,_7720,_7741),
    cc(gang,_7741,_7722).

detsamme([detsamme,_7736,lit(det),lit(samme)],_7725,_7727) --> 
    prep1(with,_7736,_7725,_7753),
    cc(det,_7753,_7775),
    cc(samme,_7775,_7727).

den0([den0,_7727,!],_7716,_7718) --> 
    den(_7727,_7716,_7718),
    !.

den0([den0,[]],_7713,_7713) --> 
    [].

den([den,lit(den)],_7715,_7717) --> 
    cc(den,_7715,_7717).

dendet0([dendet0,_7731,!],_7720,_7722) --> 
    look_ahead([d],_7731,_7720,_7722),
    !.

dendet0([dendet0,lit(den),_7753,!,_7787],_7731,_7733) --> 
    cc(den,_7731,_7752),
    not_look_ahead(w(nb(_7713,_7714)),_7753,_7752,_7770),
    !,
    accept(_7787,_7770,_7733).

dendet0([dendet0,lit(det),!,_7748],_7721,_7723) --> 
    cc(det,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

dendet0([dendet0,[]],_7713,_7713) --> 
    [].

dent0([dent0,lit(den),!],_7718,_7720) --> 
    cc(den,_7718,_7720),
    !.

dent0([dent0,lit(det),!],_7718,_7720) --> 
    cc(det,_7718,_7720),
    !.

dent0([dent0,lit(de),!,_7748],_7721,_7723) --> 
    cc(de,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

dent0([dent0,lit(noen),!],_7718,_7720) --> 
    cc(noen,_7718,_7720),
    !.

dent0([dent0,lit(en),!],_7718,_7720) --> 
    cc(en,_7718,_7720),
    !.

dent0([dent0,[]],_7713,_7713) --> 
    [].

det0([det0,_7733,_7757,!,_7786],_7722,_7724) --> 
    thereit(_7733,_7722,_7748),
    thereit_not_pronoun(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

det0([det0,[]],_7713,_7713) --> 
    [].

dudet([dudet,lit(du)],_7715,_7717) --> 
    cc(du,_7715,_7717).

dudet([dudet,lit(det)],_7715,_7717) --> 
    cc(det,_7715,_7717).

dudet([dudet,_7726],_7715,_7717) --> 
    pronoun(_7698,_7726,_7715,_7717).

each([each,lit(alle),_7740],_7718,_7720) --> 
    cc(alle,_7718,_7739),
    the(_7740,_7739,_7720).

earlier([earlier,lit(tidligere)],_7715,_7717) --> 
    cc(tidligere,_7715,_7717).

earlier([earlier,_7731,lit(forhånd)],_7720,_7722) --> 
    prep1(on,_7731,_7720,_7748),
    cc(forhånd,_7748,_7722).

earlier([earlier,lit(derfør)],_7715,_7717) --> 
    cc(derfør,_7715,_7717).

either0([either0,lit(enten),!,_7748],_7721,_7723) --> 
    cc(enten,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

either0([either0,[]],_7713,_7713) --> 
    [].

equal([equal,lit(lik)],_7715,_7717) --> 
    cc(lik,_7715,_7717).

equal([equal,lit(likt)],_7715,_7717) --> 
    cc(likt,_7715,_7717).

iyou(du,[iyou,lit(du)],_7719,_7721) --> 
    cc(du,_7719,_7721).

iyou(jeg,[iyou,lit(jeg)],_7719,_7721) --> 
    cc(jeg,_7719,_7721).

iyou(vi,[iyou,lit(vi)],_7719,_7721) --> 
    cc(vi,_7719,_7721).

areyou([areyou,lit(erru),_7742],_7720,_7722) --> 
    cc(erru,_7720,_7741),
    negation0(_7701,_7742,_7741,_7722).

areyou([areyou,_7740,lit(du),_7780],_7729,_7731) --> 
    w(verb(be,_7709,fin),_7740,_7729,_7757),
    cc(du,_7757,_7779),
    negation0(_7704,_7780,_7779,_7731).

areyou([areyou,lit(vil),lit(du),_7767,_7796],_7734,_7736) --> 
    cc(vil,_7734,_7755),
    cc(du,_7755,_7766),
    negation0(_7717,_7767,_7766,_7784),
    w(verb(be,_7710,fin),_7796,_7784,_7736).

every([every,lit(alle),_7740],_7718,_7720) --> 
    cc(alle,_7718,_7739),
    de0(_7740,_7739,_7720).

every([every,lit(en),lit(hver)],_7720,_7722) --> 
    cc(en,_7720,_7741),
    cc(hver,_7741,_7722).

false([false,lit(galt)],_7715,_7717) --> 
    cc(galt,_7715,_7717).

false([false,lit(usant)],_7715,_7717) --> 
    cc(usant,_7715,_7717).

false([false,lit(feil)],_7715,_7717) --> 
    cc(feil,_7715,_7717).

false([false,lit(uriktig)],_7715,_7717) --> 
    cc(uriktig,_7715,_7717).

few([few,lit(få)],_7715,_7717) --> 
    cc(få,_7715,_7717).

few([few,lit(fåtallig)],_7715,_7717) --> 
    cc(fåtallig,_7715,_7717).

first([first,_7729],_7718,_7720) --> 
    w(adj2(first,nil),_7729,_7718,_7720).

first([first,lit(tidligste)],_7715,_7717) --> 
    cc(tidligste,_7715,_7717).

faa([faa,lit(få)],_7715,_7717) --> 
    cc(få,_7715,_7717).

faa([faa,lit(får)],_7715,_7717) --> 
    cc(får,_7715,_7717).

faa0([faa0,_7730,!,_7759],_7719,_7721) --> 
    faa(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

faa0([faa0,[]],_7713,_7713) --> 
    [].

fast([fast,lit(fort)],_7715,_7717) --> 
    cc(fort,_7715,_7717).

fast([fast,_7729],_7718,_7720) --> 
    w(adj2(fast,nil),_7729,_7718,_7720).

fast([fast,_7734,lit(mulig)],_7723,_7725) --> 
    w(adj2(fast,nil),_7734,_7723,_7751),
    cc(mulig,_7751,_7725).

fast([fast,_7724],_7713,_7715) --> 
    hereafter(_7724,_7713,_7715).

from([from,_7726],_7715,_7717) --> 
    prep(from,_7726,_7715,_7717).

førnår([førnår,lit(når)],_7715,_7717) --> 
    cc(når,_7715,_7717).

førnår([førnår,lit(før)],_7715,_7717) --> 
    cc(før,_7715,_7717).

great([great,_7729],_7718,_7720) --> 
    w(adj2(great,nil),_7729,_7718,_7720).

great([great,lit(høy)],_7715,_7717) --> 
    cc(høy,_7715,_7717).

greater([greater,_7726],_7715,_7717) --> 
    prep(after,_7726,_7715,_7717).

greater([greater,lit(større)],_7715,_7717) --> 
    cc(større,_7715,_7717).

greater([greater,lit(høyere)],_7715,_7717) --> 
    cc(høyere,_7715,_7717).

greater([greater,lit(mer)],_7715,_7717) --> 
    cc(mer,_7715,_7717).

greater([greater,_7724],_7713,_7715) --> 
    great(_7724,_7713,_7715).

greatest([greatest,lit(størst)],_7715,_7717) --> 
    cc(størst,_7715,_7717).

greatest([greatest,lit(største)],_7715,_7717) --> 
    cc(største,_7715,_7717).

halfhour([halfhour,lit(halv),_7747],_7725,_7727) --> 
    cc(halv,_7725,_7746),
    w(noun(hour,_7704,_7705,n),_7747,_7746,_7727).

halfhour([halfhour,lit(halvtime)],_7715,_7717) --> 
    cc(halvtime,_7715,_7717).

has(_7698,[has,_7748,_7772,_7801],_7734,_7736) --> 
    has(_7748,_7734,_7763),
    negation0(_7698,_7772,_7763,_7789),
    not_look_ahead(w(noun(arrival,_7711,_7712,n)),_7801,_7789,_7736).

has0([has0,_7727,!],_7716,_7718) --> 
    has(_7727,_7716,_7718),
    !.

has0([has0,[]],_7713,_7713) --> 
    [].

has([has,_7742,_7771],_7731,_7733) --> 
    w(verb(have,_7713,fin),_7742,_7731,_7759),
    not_look_ahead(w(noun(arrival,_7706,_7707,n)),_7771,_7759,_7733).

hashad0([hashad0,_7727,!],_7716,_7718) --> 
    hashad(_7727,_7716,_7718),
    !.

hashad0([hashad0,[]],_7713,_7713) --> 
    [].

hashad([hashad,_7745,_7774,!,_7808],_7734,_7736) --> 
    w(verb(have,_7710,_7711),_7745,_7734,_7762),
    w(verb(have,_7716,_7717),_7774,_7762,_7791),
    !,
    accept(_7808,_7791,_7736).

hashad([hashad,_7730],_7719,_7721) --> 
    w(verb(have,_7701,_7702),_7730,_7719,_7721).

hasto0([hasto0,_7733,_7762],_7722,_7724) --> 
    w(verb(have,_7704,fin),_7733,_7722,_7750),
    infinitive(_7762,_7750,_7724).

hasto0([hasto0,[]],_7713,_7713) --> 
    [].

hereafter([hereafter,lit(om),lit(ikke),lit(så),lit(lenge)],_7730,_7732) --> 
    cc(om,_7730,_7751),
    cc(ikke,_7751,_7762),
    cc(så,_7762,_7773),
    cc(lenge,_7773,_7732).

hereafter([hereafter,_7727,_7751],_7716,_7718) --> 
    soonar(_7727,_7716,_7742),
    aspossible0(_7751,_7742,_7718).

hereafter([hereafter,lit(så),_7756,lit(som),_7791,!],_7734,_7736) --> 
    cc(så,_7734,_7755),
    soon(_7756,_7755,_7771),
    cc(som,_7771,_7790),
    w(adj2(possible,nil),_7791,_7790,_7736),
    !.

hereafter([hereafter,_7742,_7771,_7795,!],_7731,_7733) --> 
    prep1(in,_7742,_7731,_7759),
    near(_7771,_7759,_7786),
    w(noun(future,_7712,_7713,_7714),_7795,_7786,_7733),
    !.

hereafter([hereafter,lit(med),lit(en),lit(gang)],_7725,_7727) --> 
    cc(med,_7725,_7746),
    cc(en,_7746,_7757),
    cc(gang,_7757,_7727).

hereafter([hereafter,lit(heretter)],_7715,_7717) --> 
    cc(heretter,_7715,_7717).

hereafter([hereafter,_7729,_7758],_7718,_7720) --> 
    prep1(from,_7729,_7718,_7746),
    nowon(_7758,_7746,_7720).

hereafter([hereafter,_7744,_7773,_7802],_7733,_7735) --> 
    prep1(in,_7744,_7733,_7761),
    w(adj2(nearest,nil),_7773,_7761,_7790),
    w(noun(future,_7707,_7708,n),_7802,_7790,_7735).

hereafter([hereafter,_7744,_7773,_7802],_7733,_7735) --> 
    prep1(on,_7744,_7733,_7761),
    w(adj2(_7715,nil),_7773,_7761,_7790),
    w(noun(way,_7707,u,n),_7802,_7790,_7735).

hereafter([hereafter,_7729,_7758],_7718,_7720) --> 
    prep1(after,_7729,_7718,_7746),
    now1(_7758,_7746,_7720).

hereafter([hereafter,_7731,lit(dette)],_7720,_7722) --> 
    prep1(after,_7731,_7720,_7748),
    cc(dette,_7748,_7722).

hereafter([hereafter,lit(raskest),lit(mulig)],_7720,_7722) --> 
    cc(raskest,_7720,_7741),
    cc(mulig,_7741,_7722).

hereafter([hereafter,_7734,lit(gang)],_7723,_7725) --> 
    w(adj2(next,nil),_7734,_7723,_7751),
    cc(gang,_7751,_7725).

hereafter([hereafter,lit(raskest)],_7715,_7717) --> 
    cc(raskest,_7715,_7717).

herefrom([herefrom,_7737,lit(her),!,_7782],_7726,_7728) --> 
    prep1(from,_7737,_7726,_7754),
    cc(her,_7754,_7776),
    !,
    accept(_7782,_7776,_7728).

herefrom([herefrom,lit(herfra)],_7715,_7717) --> 
    cc(herfra,_7715,_7717).

herefrom([herefrom,lit(derfra)],_7715,_7717) --> 
    cc(derfra,_7715,_7717).

how([how,lit(hvordan),_7740],_7718,_7720) --> 
    cc(hvordan,_7718,_7739),
    ialle0(_7740,_7739,_7720).

how([how,lit(hvorfor),_7740],_7718,_7720) --> 
    cc(hvorfor,_7718,_7739),
    ialle0(_7740,_7739,_7720).

hoq([hoq,lit(vil),lit(du),lit(at)],_7725,_7727) --> 
    cc(vil,_7725,_7746),
    cc(du,_7746,_7757),
    cc(at,_7757,_7727).

hoq([hoq,_7740,lit(det),lit(at)],_7729,_7731) --> 
    w(verb(mean,_7709,fin),_7740,_7729,_7757),
    cc(det,_7757,_7779),
    cc(at,_7779,_7731).

hoq([hoq,_7742,lit(det),lit(seg),_7788,lit(at)],_7731,_7733) --> 
    has(_7742,_7731,_7757),
    cc(det,_7757,_7776),
    cc(seg,_7776,_7787),
    redundant0(_7788,_7787,_7803),
    cc(at,_7803,_7733).

hoq([hoq,_7737,lit(det),_7772,lit(at)],_7726,_7728) --> 
    be(_7737,_7726,_7752),
    cc(det,_7752,_7771),
    redundant0(_7772,_7771,_7787),
    cc(at,_7787,_7728).

hoq([hoq,_7745,lit(det),lit(an),lit(at)],_7734,_7736) --> 
    w(verb(go,_7712,fin),_7745,_7734,_7762),
    cc(det,_7762,_7784),
    cc(an,_7784,_7795),
    cc(at,_7795,_7736).

hoq([hoq,_7745,lit(det),_7785,lit(at)],_7734,_7736) --> 
    w(verb(agree,_7712,fin),_7745,_7734,_7762),
    cc(det,_7762,_7784),
    negation0(_7717,_7785,_7784,_7802),
    cc(at,_7802,_7736).

ihvor([ihvor,lit(i),lit(hvor),!],_7723,_7725) --> 
    cc(i,_7723,_7744),
    cc(hvor,_7744,_7725),
    !.

ihvor([ihvor,lit(hvor)],_7715,_7717) --> 
    cc(hvor,_7715,_7717).

hvor([hvor,lit(hvor)],_7715,_7717) --> 
    cc(hvor,_7715,_7717).

hvordan([hvordan,lit(hvordan),!,_7748],_7721,_7723) --> 
    cc(hvordan,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

hvordan([hvordan,lit(hva),lit(slags),_7762,!,_7791],_7729,_7731) --> 
    cc(hva,_7729,_7750),
    cc(slags,_7750,_7761),
    type0(_7762,_7761,_7777),
    !,
    accept(_7791,_7777,_7731).

hvordan([hvordan,lit(hva),!,_7748],_7721,_7723) --> 
    cc(hva,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

hvordan([hvordan,lit(hvor),_7751,!,_7785],_7729,_7731) --> 
    cc(hvor,_7729,_7750),
    w(adj2(great,nil),_7751,_7750,_7768),
    !,
    accept(_7785,_7768,_7731).

hvorfor([hvorfor,lit(hvorfor),_7740],_7718,_7720) --> 
    cc(hvorfor,_7718,_7739),
    ialle0(_7740,_7739,_7720).

type0([type0,_7730,!,_7759],_7719,_7721) --> 
    type(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

type0([type0,[]],_7713,_7713) --> 
    [].

type([type,_7737,!,_7771],_7726,_7728) --> 
    w(noun(type,_7707,u,n),_7737,_7726,_7754),
    !,
    accept(_7771,_7754,_7728).

i([i,lit(jeg)],_7715,_7717) --> 
    cc(jeg,_7715,_7717).

i([i,lit(meg)],_7715,_7717) --> 
    cc(meg,_7715,_7717).

i([i,lit(oss)],_7715,_7717) --> 
    cc(oss,_7715,_7717).

ialle0([ialle0,[]],_7713,_7713) --> 
    [].

if1([if1,lit(hvis)],_7715,_7717) --> 
    cc(hvis,_7715,_7717).

if1([if1,lit(om),_7758,{}],_7736,_7738) --> 
    cc(om,_7736,_7757),
    look_ahead(w(name(_7717,_7718,_7708)),_7758,_7757,_7738),
    {user:(\+subclass0(_7708,place))}.

if1([if1,lit(om),_7759,{}],_7737,_7739) --> 
    cc(om,_7737,_7758),
    look_ahead(w(noun(_7708,_7718,_7719,_7720)),_7759,_7758,_7739),
    {user:(\+subclass0(_7708,place))}.

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([jeg],_7744,_7743,_7724).

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([du],_7744,_7743,_7724).

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([han],_7744,_7743,_7724).

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([hun],_7744,_7743,_7724).

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([man],_7744,_7743,_7724).

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([vi],_7744,_7743,_7724).

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([dere],_7744,_7743,_7724).

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([de],_7744,_7743,_7724).

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([en],_7744,_7743,_7724).

if1([if1,lit(om),_7744],_7722,_7724) --> 
    cc(om,_7722,_7743),
    look_ahead([et],_7744,_7743,_7724).

ifra([ifra,lit(fra)],_7715,_7717) --> 
    cc(fra,_7715,_7717).

ifra([ifra,lit(ifra)],_7715,_7717) --> 
    cc(ifra,_7715,_7717).

iman([iman,lit(jeg)],_7715,_7717) --> 
    cc(jeg,_7715,_7717).

iman([iman,lit(man)],_7715,_7717) --> 
    cc(man,_7715,_7717).

iman([iman,lit(en)],_7715,_7717) --> 
    cc(en,_7715,_7717).

iman([iman,lit(du)],_7715,_7717) --> 
    cc(du,_7715,_7717).

inperiod0([inperiod0,_7742,_7771,!,_7805],_7731,_7733) --> 
    prep1(in,_7742,_7731,_7759),
    w(noun(hour,_7712,def,n),_7771,_7759,_7788),
    !,
    accept(_7805,_7788,_7733).

inperiod0([inperiod0,lit(om),_7753,!,_7787],_7731,_7733) --> 
    cc(om,_7731,_7752),
    w(noun(day,_7712,def,n),_7753,_7752,_7770),
    !,
    accept(_7787,_7770,_7733).

inperiod0([inperiod0,lit(hver),_7753,!,_7787],_7731,_7733) --> 
    cc(hver,_7731,_7752),
    w(noun(day,sin,u,n),_7753,_7752,_7770),
    !,
    accept(_7787,_7770,_7733).

inperiod0([inperiod0,[]],_7713,_7713) --> 
    [].

in_order_to(adj/nil/_7702,id,[in_order_to,_7743],_7726,_7728) --> 
    infinitiveand(_7743,_7726,_7728).

in_order_to(begin,id,[in_order_to,_7743,!,_7772],_7726,_7728) --> 
    infinitive(_7743,_7726,_7758),
    !,
    accept(_7772,_7758,_7728).

in_order_to(like,id,[in_order_to,_7743,!,_7772],_7726,_7728) --> 
    infinitive(_7743,_7726,_7758),
    !,
    accept(_7772,_7758,_7728).

in_order_to(start,id,[in_order_to,_7743,!,_7772],_7726,_7728) --> 
    infinitive(_7743,_7726,_7758),
    !,
    accept(_7772,_7758,_7728).

in_order_to(stop,id,[in_order_to,_7743,!,_7772],_7726,_7728) --> 
    infinitive(_7743,_7726,_7758),
    !,
    accept(_7772,_7758,_7728).

in_order_to(use,id,[in_order_to,_7764,{},_7803,!,_7832],_7747,_7749) --> 
    prepnof(_7713,_7764,_7747,_7781),
    {user:testmember(_7713,[on,to,for,with])},
    infinitive(_7803,_7781,_7818),
    !,
    accept(_7832,_7818,_7749).

in_order_to(use2,id,[in_order_to,_7743,!,_7772],_7726,_7728) --> 
    infinitive(_7743,_7726,_7758),
    !,
    accept(_7772,_7758,_7728).

in_order_to(have,id,[in_order_to,_7737],_7720,_7722) --> 
    infinitive(_7737,_7720,_7722).

in_order_to(think,id,[in_order_to,[]],_7720,_7720) --> 
    [].

in_order_to(_7698,not,[in_order_to,lit(uten),_7753],_7725,_7727) --> 
    cc(uten,_7725,_7752),
    infinitive(_7753,_7752,_7727).

in_order_to(_7698,id,[in_order_to,_7737],_7720,_7722) --> 
    in_order_to(_7737,_7720,_7722).

in_order_tox([in_order_tox,_7727,!],_7716,_7718) --> 
    infinitive(_7727,_7716,_7718),
    !.

in_order_tox([in_order_tox,_7724],_7713,_7715) --> 
    in_order_to(_7724,_7713,_7715).

in_order_to([in_order_to,_7724],_7713,_7715) --> 
    forå(_7724,_7713,_7715).

in_order_to([in_order_to,lit(får),_7743,!],_7721,_7723) --> 
    cc(får,_7721,_7742),
    infinitive(_7743,_7742,_7723),
    !.

in_order_to([in_order_to,lit(for),_7743,!],_7721,_7723) --> 
    cc(for,_7721,_7742),
    infinitiveand(_7743,_7742,_7723),
    !.

in_order_to([in_order_to,lit(før),_7743,!],_7721,_7723) --> 
    cc(før,_7721,_7742),
    infinitive(_7743,_7742,_7723),
    !.

in_order_to([in_order_to,_7732,_7761,!],_7721,_7723) --> 
    prep1(on,_7732,_7721,_7749),
    infinitive(_7761,_7749,_7723),
    !.

in_order_to([in_order_to,_7732,_7761,!],_7721,_7723) --> 
    prep1(with,_7732,_7721,_7749),
    infinitive(_7761,_7749,_7723),
    !.

in_order_to([in_order_to,_7732,_7761,!],_7721,_7723) --> 
    prep1(to,_7732,_7721,_7749),
    infinitiveand(_7761,_7749,_7723),
    !.

in_order_to([in_order_to,lit(av),_7743,!],_7721,_7723) --> 
    cc(av,_7721,_7742),
    infinitive(_7743,_7742,_7723),
    !.

in_order_to([in_order_to,lit(for),lit(og),!],_7723,_7725) --> 
    cc(for,_7723,_7744),
    cc(og,_7744,_7725),
    !.

in_order_to([in_order_to,lit(får),lit(å),!],_7723,_7725) --> 
    cc(får,_7723,_7744),
    cc(å,_7744,_7725),
    !.

in_order_to([in_order_to,lit(får),lit(og),!],_7723,_7725) --> 
    cc(får,_7723,_7744),
    cc(og,_7744,_7725),
    !.

forå([forå,lit(i),_7740],_7718,_7720) --> 
    cc(i,_7718,_7739),
    ogå(_7740,_7739,_7720).

forå([forå,lit(med),_7740],_7718,_7720) --> 
    cc(med,_7718,_7739),
    ogå(_7740,_7739,_7720).

forå([forå,lit(mot),_7740],_7718,_7720) --> 
    cc(mot,_7718,_7739),
    ogå(_7740,_7739,_7720).

forå([forå,lit(for),_7740],_7718,_7720) --> 
    cc(for,_7718,_7739),
    ogå(_7740,_7739,_7720).

forå([forå,lit(til),_7740],_7718,_7720) --> 
    cc(til,_7718,_7739),
    ogå(_7740,_7739,_7720).

forå([forå,lit(over),_7740],_7718,_7720) --> 
    cc(over,_7718,_7739),
    ogå(_7740,_7739,_7720).

forå([forå,lit(før),lit(å)],_7720,_7722) --> 
    cc(før,_7720,_7741),
    cc(å,_7741,_7722).

forå([forå,lit(ved),lit(å)],_7720,_7722) --> 
    cc(ved,_7720,_7741),
    cc(å,_7741,_7722).

ogå([ogå,lit(å)],_7715,_7717) --> 
    cc(å,_7715,_7717).

ogå([ogå,lit(og)],_7715,_7717) --> 
    cc(og,_7715,_7717).

infinitiveand([infinitiveand,lit(å)],_7715,_7717) --> 
    cc(å,_7715,_7717).

infinitiveand([infinitiveand,lit(og)],_7715,_7717) --> 
    cc(og,_7715,_7717).

infinitive([infinitive,lit(å),_7754,_7778,!],_7732,_7734) --> 
    cc(å,_7732,_7753),
    faa(_7754,_7753,_7769),
    look_ahead(w(verb(_7713,_7714,_7715)),_7778,_7769,_7734),
    !.

infinitive([infinitive,lit(å)],_7715,_7717) --> 
    cc(å,_7715,_7717).

infinitive([infinitive,lit(til),lit(å)],_7720,_7722) --> 
    cc(til,_7720,_7741),
    cc(å,_7741,_7722).

inom(in,[inom,_7733],_7719,_7721) --> 
    prep1(in,_7733,_7719,_7721).

inom(om,[inom,lit(om)],_7719,_7721) --> 
    cc(om,_7719,_7721).

inom(om,[inom,_7733],_7719,_7721) --> 
    prep1(on,_7733,_7719,_7721).

instead_of([instead_of,lit(fremfor)],_7715,_7717) --> 
    cc(fremfor,_7715,_7717).

instead_of([instead_of,_7744,_7773,lit(for),!],_7733,_7735) --> 
    prep1(in,_7744,_7733,_7761),
    w(noun(place,sin,def,n),_7773,_7761,_7790),
    cc(for,_7790,_7735),
    !.

instead_of([instead_of,lit(istedenfor)],_7715,_7717) --> 
    cc(istedenfor,_7715,_7717).

instead_of([instead_of,lit(heller),lit(enn)],_7720,_7722) --> 
    cc(heller,_7720,_7741),
    cc(enn,_7741,_7722).

it0([it0,lit(det),_7747,!],_7725,_7727) --> 
    cc(det,_7725,_7746),
    not_look_ahead([vil],_7747,_7746,_7727),
    !.

it0([it0,[]],_7713,_7713) --> 
    [].

it([it,lit(den)],_7715,_7717) --> 
    cc(den,_7715,_7717).

its([its,lit(dens),_7740],_7718,_7720) --> 
    cc(dens,_7718,_7739),
    own0(_7740,_7739,_7720).

its([its,lit(dets),_7740],_7718,_7720) --> 
    cc(dets,_7718,_7739),
    own0(_7740,_7739,_7720).

later([later,lit(senere)],_7715,_7717) --> 
    cc(senere,_7715,_7717).

later([later,lit(siden),_7740],_7718,_7720) --> 
    cc(siden,_7718,_7739),
    not_look_ahead_np(_7740,_7739,_7720).

later([later,lit(deretter)],_7715,_7717) --> 
    cc(deretter,_7715,_7717).

latest([latest,_7729],_7718,_7720) --> 
    w(adj2(sup,late),_7729,_7718,_7720).

latest([latest,_7729],_7718,_7720) --> 
    w(adj2(last,nil),_7729,_7718,_7720).

less([less,lit(før)],_7715,_7717) --> 
    cc(før,_7715,_7717).

less([less,lit(tidligere)],_7715,_7717) --> 
    cc(tidligere,_7715,_7717).

less([less,lit(mindre)],_7715,_7717) --> 
    cc(mindre,_7715,_7717).

less([less,lit(lavere)],_7715,_7717) --> 
    cc(lavere,_7715,_7717).

let([let,_7730],_7719,_7721) --> 
    w(verb(let,pres,fin),_7730,_7719,_7721).

little([little,lit(lite)],_7715,_7717) --> 
    cc(lite,_7715,_7717).

long([long,_7729],_7718,_7720) --> 
    w(adj2(short,nil),_7729,_7718,_7720).

long([long,_7729],_7718,_7720) --> 
    w(adj2(long,nil),_7729,_7718,_7720).

longadj([longadj,_7729],_7718,_7720) --> 
    w(adj2(long,nil),_7729,_7718,_7720).

manypersons([manypersons,lit(mange),_7746,!,_7775],_7724,_7726) --> 
    cc(mange,_7724,_7745),
    adjnoun(_7746,_7745,_7761),
    !,
    reject(_7775,_7761,_7726).

manypersons([manypersons,lit(mange)],_7715,_7717) --> 
    cc(mange,_7715,_7717).

many1([many1,lit(mange),_7740],_7718,_7720) --> 
    cc(mange,_7718,_7739),
    off0(_7740,_7739,_7720).

many([many,_7732,lit(mange),_7767],_7721,_7723) --> 
    so0(_7732,_7721,_7747),
    cc(mange,_7747,_7766),
    off0(_7767,_7766,_7723).

meny([meny,lit(mange)],_7715,_7717) --> 
    cc(mange,_7715,_7717).

meny([meny,lit(meget)],_7715,_7717) --> 
    cc(meget,_7715,_7717).

meny([meny,lit(mye)],_7715,_7717) --> 
    cc(mye,_7715,_7717).

me0([me0,lit(jeg),!],_7718,_7720) --> 
    cc(jeg,_7718,_7720),
    !.

me0([me0,lit(meg),!],_7718,_7720) --> 
    cc(meg,_7718,_7720),
    !.

me0([me0,lit(oss),!],_7718,_7720) --> 
    cc(oss,_7718,_7720),
    !.

me0([me0,lit(seg),!],_7718,_7720) --> 
    cc(seg,_7718,_7720),
    !.

me0([me0,[]],_7713,_7713) --> 
    [].

mineyour0([mineyour0,_7729,!],_7718,_7720) --> 
    posspron(_7701,_7729,_7718,_7720),
    !.

mineyour0([mineyour0,[]],_7713,_7713) --> 
    [].

more([more,lit(mer)],_7715,_7717) --> 
    cc(mer,_7715,_7717).

more([more,lit(fler)],_7715,_7717) --> 
    cc(fler,_7715,_7717).

more([more,lit(flere)],_7715,_7717) --> 
    cc(flere,_7715,_7717).

most([most,lit(de),lit(fleste)],_7720,_7722) --> 
    cc(de,_7720,_7741),
    cc(fleste,_7741,_7722).

most([most,lit(flest)],_7715,_7717) --> 
    cc(flest,_7715,_7717).

much([much,lit(mye)],_7715,_7717) --> 
    cc(mye,_7715,_7717).

much([much,lit(meget)],_7715,_7717) --> 
    cc(meget,_7715,_7717).

my([my,lit(min)],_7715,_7717) --> 
    cc(min,_7715,_7717).

my([my,lit(mitt)],_7715,_7717) --> 
    cc(mitt,_7715,_7717).

my([my,lit(mine)],_7715,_7717) --> 
    cc(mine,_7715,_7717).

when10([when10,_7724],_7713,_7715) --> 
    when1(_7724,_7713,_7715).

when10([when10,[]],_7713,_7713) --> 
    [].

when1([when1,lit(da)],_7715,_7717) --> 
    cc(da,_7715,_7717).

when1([when1,lit(når)],_7715,_7717) --> 
    cc(når,_7715,_7717).

when1([when1,lit(n),{},!],_7726,_7728) --> 
    cc(n,_7726,_7728),
    {user:value(smsflag,true)},
    !.

when1([when1,lit(tid),_7744],_7722,_7724) --> 
    cc(tid,_7722,_7743),
    look_ahead([går],_7744,_7743,_7724).

negation2(only,only,[negation2,[],!],_7723,_7723) --> 
    [],
    !.

negation2(id,only,[negation2,_7739],_7722,_7724) --> 
    negation(only,_7739,_7722,_7724).

negation2(id,only,[negation2,_7739],_7722,_7724) --> 
    negation(only,_7739,_7722,_7724).

negation2(not,id,[negation2,_7739],_7722,_7724) --> 
    negation(only,_7739,_7722,_7724).

negation2(not,id,[negation2,_7745,!,_7779],_7728,_7730) --> 
    negation(not,_7745,_7728,_7762),
    !,
    reject(_7779,_7762,_7730).

negation2(not,not,[negation2,_7739],_7722,_7724) --> 
    negation0(id,_7739,_7722,_7724).

negation2(id,_7699,[negation2,_7739],_7722,_7724) --> 
    negation0(_7699,_7739,_7722,_7724).

negation2(often,often,[negation2,[]],_7720,_7720) --> 
    [].

negation0(_7698,[negation0,{},!],_7730,_7730) --> 
    {user:(nonvar(_7698),_7698==not)},
    !.

negation0(_7698,[negation0,_7736,!],_7722,_7724) --> 
    negation(_7698,_7736,_7722,_7724),
    !.

negation0(id,[negation0,[]],_7717,_7717) --> 
    [].

negation(id,[negation,_7739,lit(bare),!],_7725,_7727) --> 
    not(_7739,_7725,_7754),
    cc(bare,_7754,_7727),
    !.

negation(not,[negation,lit(bare),_7747],_7722,_7724) --> 
    cc(bare,_7722,_7746),
    not(_7747,_7746,_7724).

negation(not,[negation,_7731],_7717,_7719) --> 
    not(_7731,_7717,_7719).

negation(only,[negation,lit(bare)],_7719,_7721) --> 
    cc(bare,_7719,_7721).

negation(atleast,[negation,lit(minst)],_7719,_7721) --> 
    cc(minst,_7719,_7721).

negation(often,[negation,lit(ofte)],_7719,_7721) --> 
    cc(ofte,_7719,_7721).

negatino([negatino,lit(ikke),!],_7718,_7720) --> 
    cc(ikke,_7718,_7720),
    !.

negatino([negatino,lit(ingen),!],_7718,_7720) --> 
    cc(ingen,_7718,_7720),
    !.

negatino([negatino,[]],_7713,_7713) --> 
    [].

near([near,_7729],_7718,_7720) --> 
    w(adj2(near,nil),_7729,_7718,_7720).

near([near,_7732,_7756],_7721,_7723) --> 
    the0(_7732,_7721,_7747),
    w(adj2(nearest,nil),_7756,_7747,_7723).

nearest([nearest,_7729],_7718,_7720) --> 
    w(adj2(near,sup),_7729,_7718,_7720).

nearest([nearest,_7729],_7718,_7720) --> 
    w(adj2(nearest,nil),_7729,_7718,_7720).

nearest([nearest,_7726],_7715,_7717) --> 
    prep1(nearest,_7726,_7715,_7717).

nest([nest,lit(nest)],_7715,_7717) --> 
    cc(nest,_7715,_7717).

nest([nest,_7729],_7718,_7720) --> 
    w(adj2(next,nil),_7729,_7718,_7720).

next0([next0,_7727,!],_7716,_7718) --> 
    next(_7727,_7716,_7718),
    !.

next0([next0,[]],_7713,_7713) --> 
    [].

next([next,_7729],_7718,_7720) --> 
    w(adj2(next,nil),_7729,_7718,_7720).

no([no,lit(ingen),_7740],_7718,_7720) --> 
    cc(ingen,_7718,_7739),
    look_ahead_np(_7740,_7739,_7720).

notall([notall,lit(ikke),lit(alle)],_7720,_7722) --> 
    cc(ikke,_7720,_7741),
    cc(alle,_7741,_7722).

not0([not0,_7727,!],_7716,_7718) --> 
    not(_7727,_7716,_7718),
    !.

not0([not0,[]],_7713,_7713) --> 
    [].

not([not,lit(ikke)],_7715,_7717) --> 
    cc(ikke,_7715,_7717).

not([not,lit(intet),_7740],_7718,_7720) --> 
    cc(intet,_7718,_7739),
    look_ahead_np(_7740,_7739,_7720).

notwithstanding([notwithstanding,lit(selv_om)],_7715,_7717) --> 
    cc(selv_om,_7715,_7717).

notwithstanding([notwithstanding,lit(selv),lit(om)],_7720,_7722) --> 
    cc(selv,_7720,_7741),
    cc(om,_7741,_7722).

now0([now0,_7727,!],_7716,_7718) --> 
    now1(_7727,_7716,_7718),
    !.

now0([now0,_7724],_7713,_7715) --> 
    today(_7724,_7713,_7715).

now0([now0,[]],_7713,_7713) --> 
    [].

now1([now1,lit(ennå)],_7715,_7717) --> 
    cc(ennå,_7715,_7717).

now1([now1,lit(nå)],_7715,_7717) --> 
    cc(nå,_7715,_7717).

now1([now1,lit(no)],_7715,_7717) --> 
    cc(no,_7715,_7717).

nowon([nowon,_7732,lit(av),!],_7721,_7723) --> 
    now1(_7732,_7721,_7747),
    cc(av,_7747,_7723),
    !.

nowon([nowon,_7724],_7713,_7715) --> 
    now1(_7724,_7713,_7715).

nr0([nr0,_7727,!],_7716,_7718) --> 
    nr1(_7727,_7716,_7718),
    !.

nr0([nr0,[]],_7713,_7713) --> 
    [].

nr1([nr1,lit(nr),_7743,!],_7721,_7723) --> 
    cc(nr,_7721,_7742),
    point0(_7743,_7742,_7723),
    !.

nr1([nr1,lit(n),_7743,!],_7721,_7723) --> 
    cc(n,_7721,_7742),
    point0(_7743,_7742,_7723),
    !.

nr1([nr1,_7730,_7754,!],_7719,_7721) --> 
    number1(_7730,_7719,_7745),
    point0(_7754,_7745,_7721),
    !.

number0([number0,_7729,!],_7718,_7720) --> 
    num(_7701,_7729,_7718,_7720),
    !.

number0([number0,[]],_7713,_7713) --> 
    [].

number1([number1,_7734,_7763],_7723,_7725) --> 
    w(noun(number,sin,_7705,n),_7734,_7723,_7751),
    colon0(_7763,_7751,_7725).

of_course0([of_course0,_7724],_7713,_7715) --> 
    of_course(_7724,_7713,_7715).

of_course0([of_course0,_7732],_7721,_7723) --> 
    not_look_ahead(w(verb(_7702,_7703,_7704)),_7732,_7721,_7723).

of_coursenot0([of_coursenot0,_7729,lit(ikke)],_7718,_7720) --> 
    of_course(_7729,_7718,_7744),
    cc(ikke,_7744,_7720).

of_coursenot0([of_coursenot0,_7732],_7721,_7723) --> 
    not_look_ahead(w(verb(_7702,_7703,_7704)),_7732,_7721,_7723).

of_course([of_course,lit(naturligvis)],_7715,_7717) --> 
    cc(naturligvis,_7715,_7717).

of_course([of_course,lit(selvfølgelig)],_7715,_7717) --> 
    cc(selvfølgelig,_7715,_7717).

of_course([of_course,lit(det),_7746],_7724,_7726) --> 
    cc(det,_7724,_7745),
    w(verb(agree,pres,fin),_7746,_7745,_7726).

of0([of0,_7727,!],_7716,_7718) --> 
    of(_7727,_7716,_7718),
    !.

of0([of0,[]],_7713,_7713) --> 
    [].

of([of,_7726],_7715,_7717) --> 
    prep(of,_7726,_7715,_7717).

of([of,_7726],_7715,_7717) --> 
    prep1(to,_7726,_7715,_7717).

off0([off0,lit(av),!],_7718,_7720) --> 
    cc(av,_7718,_7720),
    !.

off0([off0,[]],_7713,_7713) --> 
    [].

offrom([offrom,lit(av)],_7715,_7717) --> 
    cc(av,_7715,_7717).

offrom([offrom,_7726],_7715,_7717) --> 
    prep1(from,_7726,_7715,_7717).

offrom([offrom,lit(ifra)],_7715,_7717) --> 
    cc(ifra,_7715,_7717).

often([often,_7729],_7718,_7720) --> 
    w(adj2(often,nil),_7729,_7718,_7720).

often([often,lit(ofte)],_7715,_7717) --> 
    cc(ofte,_7715,_7717).

often([often,lit(sjelden)],_7715,_7717) --> 
    cc(sjelden,_7715,_7717).

often([often,lit(jevnlig)],_7715,_7717) --> 
    cc(jevnlig,_7715,_7717).

ofthe([ofthe,_7727,_7751],_7716,_7718) --> 
    of(_7727,_7716,_7742),
    the(_7751,_7742,_7718).

ofthe0([ofthe0,_7724],_7713,_7715) --> 
    ofthe(_7724,_7713,_7715).

ofthe0([ofthe0,[]],_7713,_7713) --> 
    [].

older([older,lit(eldre)],_7715,_7717) --> 
    cc(eldre,_7715,_7717).

on0([on0,_7729,!],_7718,_7720) --> 
    prep1(on,_7729,_7718,_7720),
    !.

on0([on0,[]],_7713,_7713) --> 
    [].

newyear([newyear,_7739,_7768],_7728,_7730) --> 
    w(adj2(new,nil),_7739,_7728,_7756),
    w(noun(year,_7704,_7705,_7706),_7768,_7756,_7730).

newyear([newyear,lit(nyttår)],_7715,_7717) --> 
    cc(nyttår,_7715,_7717).

om0([om0,lit(om),!],_7718,_7720) --> 
    cc(om,_7718,_7720),
    !.

om0([om0,[]],_7713,_7713) --> 
    [].

on0([on0,lit(på),!],_7718,_7720) --> 
    cc(på,_7718,_7720),
    !.

on0([on0,[]],_7713,_7713) --> 
    [].

one([one,_7729],_7718,_7720) --> 
    w(nb(1,num),_7729,_7718,_7720).

one([one,_7724],_7713,_7715) --> 
    a(_7724,_7713,_7715).

only0([only0,lit(bare),!],_7718,_7720) --> 
    cc(bare,_7718,_7720),
    !.

only0([only0,lit(hele),!],_7718,_7720) --> 
    cc(hele,_7718,_7720),
    !.

only0([only0,lit(nesten),!],_7718,_7720) --> 
    cc(nesten,_7718,_7720),
    !.

only0([only0,[]],_7713,_7713) --> 
    [].

or1([or1,lit(eller)],_7715,_7717) --> 
    cc(eller,_7715,_7717).

ordinal(_7698,[ordinal,_7736],_7722,_7724) --> 
    w(nb(_7698,ord),_7736,_7722,_7724).

oter([oter,_7724],_7713,_7715) --> 
    other(_7724,_7713,_7715).

oter([oter,_7724],_7713,_7715) --> 
    others(_7724,_7713,_7715).

other([other,lit(annen)],_7715,_7717) --> 
    cc(annen,_7715,_7717).

other([other,lit(annet)],_7715,_7717) --> 
    cc(annet,_7715,_7717).

others([others,lit(andre)],_7715,_7717) --> 
    cc(andre,_7715,_7717).

own0([own0,lit(egen)],_7715,_7717) --> 
    cc(egen,_7715,_7717).

own0([own0,lit(egne)],_7715,_7717) --> 
    cc(egne,_7715,_7717).

own0([own0,[]],_7713,_7713) --> 
    [].

possible0([possible0,_7732,!],_7721,_7723) --> 
    w(adj2(possible,nil),_7732,_7721,_7723),
    !.

possible0([possible0,[]],_7713,_7713) --> 
    [].

reflexiv0(_7698,[reflexiv0,_7739,!,_7773],_7725,_7727) --> 
    reflexiv(_7698,_7739,_7725,_7756),
    !,
    accept(_7773,_7756,_7727).

reflexiv0(_7698,[reflexiv0,{},!,_7757],_7728,_7730) --> 
    {user:verbtype(_7698,dtv)},
    !,
    accept(_7757,_7728,_7730).

reflexiv0(_7698,[reflexiv0,[]],_7717,_7717) --> 
    [].

reflexiv(ask,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(befind,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(beworry,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(buy,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(change,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(come,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(cost,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(decide,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(feel,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(fit,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(find,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(give,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(go,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(have,[reflexiv,lit(meg)],_7719,_7721) --> 
    cc(meg,_7719,_7721).

reflexiv(have,[reflexiv,lit(seg)],_7719,_7721) --> 
    cc(seg,_7719,_7721).

reflexiv(hurry,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(learn,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(move,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(pass,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(pay2,[reflexiv,lit(seg)],_7719,_7721) --> 
    cc(seg,_7719,_7721).

reflexiv(promise,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(get,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(get,[reflexiv,lit(med)],_7719,_7721) --> 
    cc(med,_7719,_7721).

reflexiv(receive,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(receive,[reflexiv,lit(med)],_7719,_7721) --> 
    cc(med,_7719,_7721).

reflexiv(retire,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(run,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(say,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(send,[reflexiv,_7734,_7758],_7720,_7722) --> 
    to0(_7734,_7720,_7749),
    rfxpron(_7758,_7749,_7722).

reflexiv(show,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(sneak,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(take,[reflexiv,lit(med),_7747],_7722,_7724) --> 
    cc(med,_7722,_7746),
    rfxpron(_7747,_7746,_7724).

reflexiv(take,[reflexiv,lit(med)],_7719,_7721) --> 
    cc(med,_7719,_7721).

reflexiv(take,[reflexiv,_7738,_7767],_7724,_7726) --> 
    not_look_ahead([dere],_7738,_7724,_7755),
    rfxpron(_7767,_7755,_7726).

reflexiv(tell,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(think,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(turn,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(want,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(wish,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(worry,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

reflexiv(write,[reflexiv,_7731],_7717,_7719) --> 
    rfxpron(_7731,_7717,_7719).

rfxpron0([rfxpron0,_7727,!],_7716,_7718) --> 
    rfxpron(_7727,_7716,_7718),
    !.

rfxpron0([rfxpron0,[]],_7713,_7713) --> 
    [].

rfxpron([rfxpron,lit(meg)],_7715,_7717) --> 
    cc(meg,_7715,_7717).

rfxpron([rfxpron,lit(deg)],_7715,_7717) --> 
    cc(deg,_7715,_7717).

rfxpron([rfxpron,lit(seg)],_7715,_7717) --> 
    cc(seg,_7715,_7717).

rfxpron([rfxpron,lit(oss)],_7715,_7717) --> 
    cc(oss,_7715,_7717).

rfxpron([rfxpron,lit(dere)],_7715,_7717) --> 
    cc(dere,_7715,_7717).

rfxpron([rfxpron,lit(selv),_7744],_7722,_7724) --> 
    cc(selv,_7722,_7743),
    not_look_ahead([om],_7744,_7743,_7724).

compassly([compassly,lit(nordfra)],_7715,_7717) --> 
    cc(nordfra,_7715,_7717).

compassly([compassly,lit(nordover)],_7715,_7717) --> 
    cc(nordover,_7715,_7717).

compassly([compassly,lit(sydfra)],_7715,_7717) --> 
    cc(sydfra,_7715,_7717).

compassly([compassly,lit(sydover)],_7715,_7717) --> 
    cc(sydover,_7715,_7717).

compassly([compassly,lit(sørfra)],_7715,_7717) --> 
    cc(sørfra,_7715,_7717).

compassly([compassly,lit(sørover)],_7715,_7717) --> 
    cc(sørover,_7715,_7717).

compassly([compassly,lit(vestfra)],_7715,_7717) --> 
    cc(vestfra,_7715,_7717).

compassly([compassly,lit(vestover)],_7715,_7717) --> 
    cc(vestover,_7715,_7717).

compassly([compassly,lit(østfra)],_7715,_7717) --> 
    cc(østfra,_7715,_7717).

compassly([compassly,lit(østover)],_7715,_7717) --> 
    cc(østover,_7715,_7717).

redundant0x([redundant0x,lit(så)],_7715,_7717) --> 
    cc(så,_7715,_7717).

redundant0x([redundant0x,_7724],_7713,_7715) --> 
    redundants0(_7724,_7713,_7715).

redundant0([redundant0,_7727,!],_7716,_7718) --> 
    redundant(_7727,_7716,_7718),
    !.

redundant0([redundant0,[]],_7713,_7713) --> 
    [].

redundants0([redundants0,_7730,_7754,!],_7719,_7721) --> 
    redundant(_7730,_7719,_7745),
    redundants0(_7754,_7745,_7721),
    !.

redundants0([redundants0,[]],_7713,_7713) --> 
    [].

redundantsx0([redundantsx0,_7730,!,_7759],_7719,_7721) --> 
    redundant(_7730,_7719,_7745),
    !,
    redxxx0(_7759,_7745,_7721).

redundantsx0([redundantsx0,[]],_7713,_7713) --> 
    [].

redxxx0([redxxx0,lit(og),_7743,!],_7721,_7723) --> 
    cc(og,_7721,_7742),
    redundant(_7743,_7742,_7723),
    !.

redxxx0([redxxx0,[]],_7713,_7713) --> 
    [].

redundant([redundant,_7731,!],_7720,_7722) --> 
    w(adv(redundantly),_7731,_7720,_7722),
    !.

redundant([redundant,_7736,_7765],_7725,_7727) --> 
    prep1(in,_7736,_7725,_7753),
    w(noun(average,_7704,_7705,_7706),_7765,_7753,_7727).

redundant([redundant,_7731,lit(allverden)],_7720,_7722) --> 
    prep1(in,_7731,_7720,_7748),
    cc(allverden,_7748,_7722).

redundant([redundant,_7748,lit(det),_7788,_7817],_7737,_7739) --> 
    prep1(in,_7748,_7737,_7765),
    cc(det,_7765,_7787),
    w(adj2(whole,nil),_7788,_7787,_7805),
    w(verb(take,past,part),_7817,_7805,_7739).

redundant([redundant,_7731,lit(hvertfall)],_7720,_7722) --> 
    prep1(in,_7731,_7720,_7748),
    cc(hvertfall,_7748,_7722).

redundant([redundant,_7731,lit(gjen)],_7720,_7722) --> 
    prep1(in,_7731,_7720,_7748),
    cc(gjen,_7748,_7722).

redundant([redundant,_7736,_7765],_7725,_7727) --> 
    prep1(for,_7736,_7725,_7753),
    w(noun(time,sin,def,n),_7765,_7753,_7727).

redundant([redundant,_7745,_7774,_7798,!,_7832],_7734,_7736) --> 
    prep1(from,_7745,_7734,_7762),
    a(_7774,_7762,_7789),
    w(noun(place,sin,u,n),_7798,_7789,_7815),
    !,
    accept(_7832,_7815,_7736).

redundant([redundant,_7734,_7763],_7723,_7725) --> 
    prep1(on,_7734,_7723,_7751),
    w(adj2(new,nil),_7763,_7751,_7725).

redundant([redundant,_7741,lit(en),_7781],_7730,_7732) --> 
    prep1(on,_7741,_7730,_7758),
    cc(en,_7758,_7780),
    w(noun(time_count,sin,u,n),_7781,_7780,_7732).

redundant([redundant,_7729,_7758],_7718,_7720) --> 
    prep1(to,_7729,_7718,_7746),
    slutt(_7758,_7746,_7720).

redundant([redundant,_7731,lit(sammen)],_7720,_7722) --> 
    prep1(to,_7731,_7720,_7748),
    cc(sammen,_7748,_7722).

redundant([redundant,_7746,_7775,_7804],_7735,_7737) --> 
    prep1(to,_7746,_7735,_7763),
    w(adj2(ordinary,nil),_7775,_7763,_7792),
    not_look_ahead(w(noun(time,_7709,_7710,_7711)),_7804,_7792,_7737).

redundant([redundant,_7724],_7713,_7715) --> 
    always(_7724,_7713,_7715).

redundant([redundant,_7724],_7713,_7715) --> 
    aspossible(_7724,_7713,_7715).

redundant([redundant,lit(altså),_7746],_7724,_7726) --> 
    cc(altså,_7724,_7745),
    not_look_ahead_lit([at,å],_7746,_7745,_7726).

redundant([redundant,lit(bare)],_7715,_7717) --> 
    cc(bare,_7715,_7717).

redundant([redundant,lit(da),_7740],_7718,_7720) --> 
    cc(da,_7718,_7739),
    not_look_ahead_np(_7740,_7739,_7720).

redundant([redundant,lit(den),lit(gang)],_7720,_7722) --> 
    cc(den,_7720,_7741),
    cc(gang,_7741,_7722).

redundant([redundant,lit(derfra)],_7715,_7717) --> 
    cc(derfra,_7715,_7717).

redundant([redundant,lit(derfor)],_7715,_7717) --> 
    cc(derfor,_7715,_7717).

redundant([redundant,lit(alene)],_7715,_7717) --> 
    cc(alene,_7715,_7717).

redundant([redundant,lit(bort)],_7715,_7717) --> 
    cc(bort,_7715,_7717).

redundant([redundant,lit(dessverre)],_7715,_7717) --> 
    cc(dessverre,_7715,_7717).

redundant([redundant,lit(egentlig)],_7715,_7717) --> 
    cc(egentlig,_7715,_7717).

redundant([redundant,lit(ellers)],_7715,_7717) --> 
    cc(ellers,_7715,_7717).

redundant([redundant,lit(engang)],_7715,_7717) --> 
    cc(engang,_7715,_7717).

redundant([redundant,lit(enklest),lit(mulig)],_7720,_7722) --> 
    cc(enklest,_7720,_7741),
    cc(mulig,_7741,_7722).

redundant([redundant,lit(enklest)],_7715,_7717) --> 
    cc(enklest,_7715,_7717).

redundant([redundant,lit(ergo)],_7715,_7717) --> 
    cc(ergo,_7715,_7717).

redundant([redundant,lit(farefritt)],_7715,_7717) --> 
    cc(farefritt,_7715,_7717).

redundant([redundant,lit(faktisk)],_7715,_7717) --> 
    cc(faktisk,_7715,_7717).

redundant([redundant,lit(forøvrig)],_7715,_7717) --> 
    cc(forøvrig,_7715,_7717).

redundant([redundant,lit(forøvrig)],_7715,_7717) --> 
    cc(forøvrig,_7715,_7717).

redundant([redundant,lit(fram)],_7715,_7717) --> 
    cc(fram,_7715,_7717).

redundant([redundant,lit(gjerne)],_7715,_7717) --> 
    cc(gjerne,_7715,_7717).

redundant([redundant,lit(heller)],_7715,_7717) --> 
    cc(heller,_7715,_7717).

redundant([redundant,lit(helst)],_7715,_7717) --> 
    cc(helst,_7715,_7717).

redundant([redundant,lit(heldigvis)],_7715,_7717) --> 
    cc(heldigvis,_7715,_7717).

redundant([redundant,lit(herfra)],_7715,_7717) --> 
    cc(herfra,_7715,_7717).

redundant([redundant,lit(jo)],_7715,_7717) --> 
    cc(jo,_7715,_7717).

redundant([redundant,lit(jovisst)],_7715,_7717) --> 
    cc(jovisst,_7715,_7717).

redundant([redundant,lit(ikke),lit(sant)],_7720,_7722) --> 
    cc(ikke,_7720,_7741),
    cc(sant,_7741,_7722).

redundant([redundant,lit(ihvertfall)],_7715,_7717) --> 
    cc(ihvertfall,_7715,_7717).

redundant([redundant,lit(imens)],_7715,_7717) --> 
    cc(imens,_7715,_7717).

redundant([redundant,lit(inne)],_7715,_7717) --> 
    cc(inne,_7715,_7717).

redundant([redundant,lit(kanskje)],_7715,_7717) --> 
    cc(kanskje,_7715,_7717).

redundant([redundant,lit(langt),lit(bort)],_7720,_7722) --> 
    cc(langt,_7720,_7741),
    cc(bort,_7741,_7722).

redundant([redundant,lit(lenge)],_7715,_7717) --> 
    cc(lenge,_7715,_7717).

redundant([redundant,lit(likevel)],_7715,_7717) --> 
    cc(likevel,_7715,_7717).

redundant([redundant,lit(minst)],_7715,_7717) --> 
    cc(minst,_7715,_7717).

redundant([redundant,lit(mon),_7746],_7724,_7726) --> 
    cc(mon,_7724,_7745),
    w(verb(believe,imp,fin),_7746,_7745,_7726).

redundant([redundant,lit(normalt)],_7715,_7717) --> 
    cc(normalt,_7715,_7717).

redundant([redundant,lit(når),lit(som),lit(helst)],_7725,_7727) --> 
    cc(når,_7725,_7746),
    cc(som,_7746,_7757),
    cc(helst,_7757,_7727).

redundant([redundant,lit(også)],_7715,_7717) --> 
    cc(også,_7715,_7717).

redundant([redundant,_7724],_7713,_7715) --> 
    sometimes(_7724,_7713,_7715).

redundant([redundant,lit(om),_7747],_7725,_7727) --> 
    cc(om,_7725,_7746),
    w(noun(time_count,sin,def,n),_7747,_7746,_7727).

redundant([redundant,lit(ad),_7747],_7725,_7727) --> 
    cc(ad,_7725,_7746),
    w(noun(time_count,sin,def,n),_7747,_7746,_7727).

redundant([redundant,lit(sikkert)],_7715,_7717) --> 
    cc(sikkert,_7715,_7717).

redundant([redundant,lit(straks)],_7715,_7717) --> 
    cc(straks,_7715,_7717).

redundant([redundant,lit(selvsagt)],_7715,_7717) --> 
    cc(selvsagt,_7715,_7717).

redundant([redundant,lit(totalt)],_7715,_7717) --> 
    cc(totalt,_7715,_7717).

redundant([redundant,lit(uansett)],_7715,_7717) --> 
    cc(uansett,_7715,_7717).

redundant([redundant,lit(vanligvis)],_7715,_7717) --> 
    cc(vanligvis,_7715,_7717).

redundant([redundant,lit(vel)],_7715,_7717) --> 
    cc(vel,_7715,_7717).

redundant([redundant,lit(videre)],_7715,_7717) --> 
    cc(videre,_7715,_7717).

slutt([slutt,lit(sist)],_7715,_7717) --> 
    cc(sist,_7715,_7717).

slutt([slutt,lit(slutt)],_7715,_7717) --> 
    cc(slutt,_7715,_7717).

please0([please0,_7730,!,_7759],_7719,_7721) --> 
    please(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

please0([please0,lit(bare),!,_7748],_7721,_7723) --> 
    cc(bare,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

please0([please0,[]],_7713,_7713) --> 
    [].

please([please,_7733,_7757,_7781,_7805],_7722,_7724) --> 
    be(_7733,_7722,_7748),
    so(_7757,_7748,_7772),
    good(_7781,_7772,_7796),
    infinitive(_7805,_7796,_7724).

please([please,lit(kan),_7759,_7783,_7807,_7831,lit(å)],_7737,_7739) --> 
    cc(kan,_7737,_7758),
    you(_7759,_7758,_7774),
    be(_7783,_7774,_7798),
    so0(_7807,_7798,_7822),
    w(adj2(good,nil),_7831,_7822,_7848),
    cc(å,_7848,_7739).

slashpoint0([slashpoint0,_7727,!],_7716,_7718) --> 
    slashpoint(_7727,_7716,_7718),
    !.

slashpoint0([slashpoint0,[]],_7713,_7713) --> 
    [].

slashpoint([slashpoint,lit(ende),!],_7718,_7720) --> 
    cc(ende,_7718,_7720),
    !.

slashpoint([slashpoint,lit(/),!],_7718,_7720) --> 
    cc(/,_7718,_7720),
    !.

slashpoint([slashpoint,lit(i),_7750,!],_7728,_7730) --> 
    cc(i,_7728,_7749),
    look_ahead(w(nb(_7710,_7711)),_7750,_7749,_7730),
    !.

slashpoint([slashpoint,lit('.'),lit(i),_7766,!],_7733,_7735) --> 
    cc('.',_7733,_7754),
    cc(i,_7754,_7765),
    look_ahead(w(nb(_7715,_7716)),_7766,_7765,_7735),
    !.

slashpoint([slashpoint,lit('.'),!],_7718,_7720) --> 
    cc('.',_7718,_7720),
    !.

slash([slash,lit(/)],_7715,_7717) --> 
    cc(/,_7715,_7717).

dashpoint0([dashpoint0,_7727,!],_7716,_7718) --> 
    dashpoint(_7727,_7716,_7718),
    !.

dashpoint0([dashpoint0,[]],_7713,_7713) --> 
    [].

dashpoint([dashpoint,lit(-)],_7715,_7717) --> 
    cc(-,_7715,_7717).

dashpoint([dashpoint,lit('.')],_7715,_7717) --> 
    cc('.',_7715,_7717).

point0([point0,_7730,!,_7759],_7719,_7721) --> 
    point(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

point0([point0,[]],_7713,_7713) --> 
    [].

pointNO([pointNO,_7730,!,_7759],_7719,_7721) --> 
    point(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

pointNO([pointNO,{}],_7718,_7718) --> 
    {user:value(nodotflag,true)}.

point([point,lit('.')],_7715,_7717) --> 
    cc('.',_7715,_7717).

itrailer([itrailer,lit(n)],_7715,_7717) --> 
    cc(n,_7715,_7717).

itrailer([itrailer,_7733,lit(når)],_7722,_7724) --> 
    not_look_ahead([n],_7733,_7722,_7750),
    cc(når,_7750,_7724).

itrailer([itrailer,_7736,_7765],_7725,_7727) --> 
    not_look_ahead([n],_7736,_7725,_7753),
    w(adj2(next,nil),_7765,_7753,_7727).

itrailer([itrailer,lit(takk)],_7715,_7717) --> 
    cc(takk,_7715,_7717).

qtrailer0([qtrailer0,lit(?),_7743,!],_7721,_7723) --> 
    cc(?,_7721,_7742),
    qtrailer(_7743,_7742,_7723),
    !.

qtrailer0([qtrailer0,lit('.'),_7743,!],_7721,_7723) --> 
    cc('.',_7721,_7742),
    qtrailer(_7743,_7742,_7723),
    !.

qtrailer0([qtrailer0,lit(a),_7743,!],_7721,_7723) --> 
    cc(a,_7721,_7742),
    qtrailer(_7743,_7742,_7723),
    !.

qtrailer0([qtrailer0,_7727,!],_7716,_7718) --> 
    qtrailer(_7727,_7716,_7718),
    !.

qtrailer0([qtrailer0,[]],_7713,_7713) --> 
    [].

qtrailer([qtrailer,lit(a)],_7715,_7717) --> 
    cc(a,_7715,_7717).

qtrailer([qtrailer,lit(takk)],_7715,_7717) --> 
    cc(takk,_7715,_7717).

qtrailer([qtrailer,_7732,lit(du),_7767],_7721,_7723) --> 
    be(_7732,_7721,_7747),
    cc(du,_7747,_7766),
    good(_7767,_7766,_7723).

qtrailer([qtrailer,lit(ca)],_7715,_7717) --> 
    cc(ca,_7715,_7717).

qtrailer([qtrailer,lit(da)],_7715,_7717) --> 
    cc(da,_7715,_7717).

qtrailer([qtrailer,lit(eller),lit(ikke)],_7720,_7722) --> 
    cc(eller,_7720,_7741),
    cc(ikke,_7741,_7722).

qtrailer([qtrailer,lit(eller)],_7715,_7717) --> 
    cc(eller,_7715,_7717).

qtrailer([qtrailer,_7733,!],_7722,_7724) --> 
    w(name(hal,_7704,_7705),_7733,_7722,_7724),
    !.

qtrailer([qtrailer,_7744,_7788,!],_7733,_7735) --> 
    optional(w(adj2(great,nil)),_7744,_7733,_7776),
    w(noun(oracle,sin,u,n),_7788,_7776,_7735),
    !.

qtrailer([qtrailer,_7748,{},!],_7737,_7739) --> 
    w(noun(_7706,sin,u,n),_7748,_7737,_7739),
    {user:testmember(_7706,[program,oracle,boss])},
    !.

qtrailer([qtrailer,lit(og)],_7715,_7717) --> 
    cc(og,_7715,_7717).

qtrailer([qtrailer,lit(og),lit(når)],_7720,_7722) --> 
    cc(og,_7720,_7741),
    cc(når,_7741,_7722).

qtrailer([qtrailer,lit(lenger),!],_7718,_7720) --> 
    cc(lenger,_7718,_7720),
    !.

qtrailer([qtrailer,lit(lengre),!],_7718,_7720) --> 
    cc(lengre,_7718,_7720),
    !.

qtrailer([qtrailer,lit(så),_7762,lit(du),_7802,!],_7740,_7742) --> 
    cc(så,_7740,_7761),
    w(verb(be,_7715,_7716),_7762,_7761,_7779),
    cc(du,_7779,_7801),
    w(adj2(nice,nil),_7802,_7801,_7742),
    !.

qtrailer([qtrailer,_7730],_7719,_7721) --> 
    w(verb(believe,inf,fin),_7730,_7719,_7721).

qtrailer([qtrailer,_7735,lit(du)],_7724,_7726) --> 
    w(verb(believe,pres,fin),_7735,_7724,_7752),
    cc(du,_7752,_7726).

qtrailer([qtrailer,lit(ø)],_7715,_7717) --> 
    cc(ø,_7715,_7717).

qtrailer([qtrailer,_7733,lit(når)],_7722,_7724) --> 
    not_look_ahead([n],_7733,_7722,_7750),
    cc(når,_7750,_7724).

qtrailer([qtrailer,lit(din),_7757,_7801],_7735,_7737) --> 
    cc(din,_7735,_7756),
    optional(w(adj2(_7717,nil)),_7757,_7756,_7789),
    w(noun(_7706,sin,_7708,_7709),_7801,_7789,_7737).

qtrailer([qtrailer,_7745,{},!],_7734,_7736) --> 
    w(name(_7706,_7707,_7708),_7745,_7734,_7736),
    {user:testmember(_7708,[man,woman])},
    !.

qtrailer([qtrailer,lit(uansett)],_7715,_7717) --> 
    cc(uansett,_7715,_7717).

ctrailer0([ctrailer0,_7727,!],_7716,_7718) --> 
    ctrailer(_7727,_7716,_7718),
    !.

ctrailer0([ctrailer0,[]],_7713,_7713) --> 
    [].

ctrailer([ctrailer,_7724],_7713,_7715) --> 
    please(_7724,_7713,_7715).

ctrailer([ctrailer,lit(takk)],_7715,_7717) --> 
    cc(takk,_7715,_7717).

ctrailer([ctrailer,_7743,lit(du),_7783],_7732,_7734) --> 
    w(verb(be,pres,fin),_7743,_7732,_7760),
    cc(du,_7760,_7782),
    w(adj2(nice,nil),_7783,_7782,_7734).

ctrailer([ctrailer,lit(da)],_7715,_7717) --> 
    cc(da,_7715,_7717).

ctrailer([ctrailer,lit(din),_7757,_7801],_7735,_7737) --> 
    cc(din,_7735,_7756),
    optional(w(adj2(_7717,nil)),_7757,_7756,_7789),
    w(noun(_7706,sin,_7708,_7709),_7801,_7789,_7737).

dtrailer0([dtrailer0,{},_7747,!],_7726,_7728) --> 
    {user:(\+value(dialog,1))},
    dtrailer(_7747,_7726,_7728),
    !.

dtrailer0([dtrailer0,[]],_7713,_7713) --> 
    [].

dtrailer([dtrailer,_7730],_7719,_7721) --> 
    w(name(tore,n,firstname),_7730,_7719,_7721).

dtrailer([dtrailer,_7735,lit(jeg)],_7724,_7726) --> 
    w(verb(think,_7706,fin),_7735,_7724,_7752),
    cc(jeg,_7752,_7726).

dtrailer([dtrailer,_7735,lit(jeg)],_7724,_7726) --> 
    w(verb(mean,_7706,fin),_7735,_7724,_7752),
    cc(jeg,_7752,_7726).

dtrailer([dtrailer,_7730],_7719,_7721) --> 
    w(name(bustuc,_7701,_7702),_7730,_7719,_7721).

dtrailer([dtrailer,lit(ass)],_7715,_7717) --> 
    cc(ass,_7715,_7717).

dtrailer([dtrailer,lit(da)],_7715,_7717) --> 
    cc(da,_7715,_7717).

dtrailer([dtrailer,lit(din),_7757,_7801],_7735,_7737) --> 
    cc(din,_7735,_7756),
    optional(w(adj2(_7717,nil)),_7757,_7756,_7789),
    w(noun(fool,sin,u,n),_7801,_7789,_7737).

dtrailer([dtrailer,lit(du)],_7715,_7717) --> 
    cc(du,_7715,_7717).

dtrailer([dtrailer,lit(eller),lit(hva)],_7720,_7722) --> 
    cc(eller,_7720,_7741),
    cc(hva,_7741,_7722).

dtrailer([dtrailer,lit(eller)],_7715,_7717) --> 
    cc(eller,_7715,_7717).

dtrailer([dtrailer,lit(gitt)],_7715,_7717) --> 
    cc(gitt,_7715,_7717).

dtrailer([dtrailer,lit(hvordan)],_7715,_7717) --> 
    cc(hvordan,_7715,_7717).

dtrailer([dtrailer,lit(hei)],_7715,_7717) --> 
    cc(hei,_7715,_7717).

dtrailer([dtrailer,lit(ja)],_7715,_7717) --> 
    cc(ja,_7715,_7717).

dtrailer([dtrailer,lit(jeg)],_7715,_7717) --> 
    cc(jeg,_7715,_7717).

dtrailer([dtrailer,lit(men),lit(når)],_7720,_7722) --> 
    cc(men,_7720,_7741),
    cc(når,_7741,_7722).

dtrailer([dtrailer,lit(ok)],_7715,_7717) --> 
    cc(ok,_7715,_7717).

dtrailer([dtrailer,lit(sjø)],_7715,_7717) --> 
    cc(sjø,_7715,_7717).

dtrailer([dtrailer,lit(?),lit(takk)],_7720,_7722) --> 
    cc(?,_7720,_7741),
    cc(takk,_7741,_7722).

dtrailer([dtrailer,_7736,lit(hilsen),_7791],_7725,_7727) --> 
    optional([med],_7736,_7725,_7768),
    cc(hilsen,_7768,_7790),
    skip_rest(_7791,_7790,_7727).

posspron(self,[posspron,_7734,_7758],_7720,_7722) --> 
    my(_7734,_7720,_7749),
    own0(_7758,_7749,_7722).

posspron(man,[posspron,lit(hans),_7747],_7722,_7724) --> 
    cc(hans,_7722,_7746),
    own0(_7747,_7746,_7724).

posspron(woman,[posspron,lit(hennes),_7747],_7722,_7724) --> 
    cc(hennes,_7722,_7746),
    own0(_7747,_7746,_7724).

posspron(savant,[posspron,_7731],_7717,_7719) --> 
    your(_7731,_7717,_7719).

posspron(person,[posspron,_7734,_7758],_7720,_7722) --> 
    their(_7734,_7720,_7749),
    own0(_7758,_7749,_7722).

posspron(thing,[posspron,_7731],_7717,_7719) --> 
    sin(_7731,_7717,_7719).

previous([previous,_7729],_7718,_7720) --> 
    w(adj2(previous,nil),_7729,_7718,_7720).

thereafter([thereafter,_7727,_7751],_7716,_7718) --> 
    andor0(_7727,_7716,_7742),
    later(_7751,_7742,_7718).

thereafter([thereafter,_7731,lit(det)],_7720,_7722) --> 
    prep1(after,_7731,_7720,_7748),
    cc(det,_7748,_7722).

thereafter([thereafter,_7731,lit(dette)],_7720,_7722) --> 
    prep1(after,_7731,_7720,_7748),
    cc(dette,_7748,_7722).

thereafter([thereafter,_7731,lit(der)],_7720,_7722) --> 
    prep1(after,_7731,_7720,_7748),
    cc(der,_7748,_7722).

thereafter([thereafter,lit(nest),_7747,lit(der)],_7725,_7727) --> 
    cc(nest,_7725,_7746),
    prep1(after,_7747,_7746,_7764),
    cc(der,_7764,_7727).

thereafter([thereafter,_7731,lit(hvert)],_7720,_7722) --> 
    prep1(after,_7731,_7720,_7748),
    cc(hvert,_7748,_7722).

beforethat([beforethat,lit(derfør)],_7715,_7717) --> 
    cc(derfør,_7715,_7717).

beforethat([beforethat,_7727,_7751],_7716,_7718) --> 
    andor0(_7727,_7716,_7742),
    earlier(_7751,_7742,_7718).

beforethat([beforethat,_7731,lit(det)],_7720,_7722) --> 
    prep1(before,_7731,_7720,_7748),
    cc(det,_7748,_7722).

beforethat([beforethat,_7731,lit(dette)],_7720,_7722) --> 
    prep1(after,_7731,_7720,_7748),
    cc(dette,_7748,_7722).

beforethat([beforethat,_7731,lit(der)],_7720,_7722) --> 
    prep1(after,_7731,_7720,_7748),
    cc(der,_7748,_7722).

beforethat([beforethat,_7731,lit(dette)],_7720,_7722) --> 
    prep1(before,_7731,_7720,_7748),
    cc(dette,_7748,_7722).

beforethat([beforethat,lit(nest),_7747,lit(der)],_7725,_7727) --> 
    cc(nest,_7725,_7746),
    prep1(before,_7747,_7746,_7764),
    cc(der,_7764,_7727).

preperly([preperly,lit(en),lit(del)],_7720,_7722) --> 
    cc(en,_7720,_7741),
    cc(del,_7741,_7722).

preperly([preperly,lit(enda)],_7715,_7717) --> 
    cc(enda,_7715,_7717).

preperly([preperly,lit(ekte)],_7715,_7717) --> 
    cc(ekte,_7715,_7717).

preperly([preperly,lit(litt)],_7715,_7717) --> 
    cc(litt,_7715,_7717).

preperly([preperly,lit(noe)],_7715,_7717) --> 
    cc(noe,_7715,_7717).

preperly([preperly,lit(reellt)],_7715,_7717) --> 
    cc(reellt,_7715,_7717).

preperly([preperly,lit(strengt)],_7715,_7717) --> 
    cc(strengt,_7715,_7717).

preperly([preperly,lit(strikt)],_7715,_7717) --> 
    cc(strikt,_7715,_7717).

preperly([preperly,lit(virkelig)],_7715,_7717) --> 
    cc(virkelig,_7715,_7717).

prep2(after,[prep2,lit(avgang),_7753],_7728,_7730) --> 
    cc(avgang,_7728,_7752),
    not_look_ahead(w(prep(_7707)),_7753,_7752,_7730).

prep2(before,[prep2,lit(ankomst),_7753],_7728,_7730) --> 
    cc(ankomst,_7728,_7752),
    not_look_ahead(w(prep(_7707)),_7753,_7752,_7730).

prep2(after,[prep2,_7736,_7760],_7722,_7724) --> 
    preperly(_7736,_7722,_7751),
    prep1(after,_7760,_7751,_7724).

prep2(after,[prep2,_7744,_7768,lit(enn)],_7730,_7732) --> 
    preperly(_7744,_7730,_7759),
    w(adj2(later,nil),_7768,_7759,_7785),
    cc(enn,_7785,_7732).

prep2(before,[prep2,_7736,_7760],_7722,_7724) --> 
    preperly(_7736,_7722,_7751),
    prep1(before,_7760,_7751,_7724).

prep2(before,[prep2,_7744,_7768,lit(enn)],_7730,_7732) --> 
    preperly(_7744,_7730,_7759),
    w(adj2(earlier,nil),_7768,_7759,_7785),
    cc(enn,_7785,_7732).

prep2(according_to,[prep2,_7738,lit(følge)],_7724,_7726) --> 
    prep1(in,_7738,_7724,_7755),
    cc(følge,_7755,_7726).

prep2(after,[prep2,_7736,_7760],_7722,_7724) --> 
    clock(_7736,_7722,_7751),
    prep1(after,_7760,_7751,_7724).

prep2(after,[prep2,_7736,_7760],_7722,_7724) --> 
    around1(_7736,_7722,_7751),
    prep1(after,_7760,_7751,_7724).

prep2(after,[prep2,lit(ca),_7749],_7724,_7726) --> 
    cc(ca,_7724,_7748),
    prep1(after,_7749,_7748,_7726).

prep2(after,[prep2,_7736,_7765],_7722,_7724) --> 
    prep1(after,_7736,_7722,_7753),
    around1(_7765,_7753,_7724).

prep2(after,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(from,_7738,_7724,_7755),
    prep1(after,_7767,_7755,_7726).

prep2(after,[prep2,_7745,_7774,_7803],_7731,_7733) --> 
    prep1(to,_7745,_7731,_7762),
    not_look_ahead([e],_7774,_7762,_7791),
    prep1(after,_7803,_7791,_7733).

prep2(after,[prep2,_7743,lit(og),_7783],_7729,_7731) --> 
    prep1(from,_7743,_7729,_7760),
    cc(og,_7760,_7782),
    prep1(with,_7783,_7782,_7731).

prep2(after,[prep2,lit(like),_7749],_7724,_7726) --> 
    cc(like,_7724,_7748),
    prep1(after,_7749,_7748,_7726).

prep2(after,[prep2,_7736,_7760],_7722,_7724) --> 
    not(_7736,_7722,_7751),
    prep(before,_7760,_7751,_7724).

prep2(after,[prep2,lit(senere),lit(enn)],_7724,_7726) --> 
    cc(senere,_7724,_7748),
    cc(enn,_7748,_7726).

prep2(after,[prep2,lit(resten),_7749],_7724,_7726) --> 
    cc(resten,_7724,_7748),
    prep1(off,_7749,_7748,_7726).

prep2(around,[prep2,_7734,_7758],_7720,_7722) --> 
    around1(_7734,_7720,_7749),
    around0(_7758,_7749,_7722).

prep2(at,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(in,_7738,_7724,_7755),
    prep1(at,_7767,_7755,_7726).

prep2(at,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(on,_7738,_7724,_7755),
    prep1(at,_7767,_7755,_7726).

prep2(at,[prep2,_7748,_7777,lit(av)],_7734,_7736) --> 
    prep1(at,_7748,_7734,_7765),
    w(noun(side,_7713,_7714,_7715),_7777,_7765,_7794),
    cc(av,_7794,_7736).

prep2(before,[prep2,lit(for),_7754],_7729,_7731) --> 
    cc(for,_7729,_7753),
    look_ahead(w(nb(_7707,num)),_7754,_7753,_7731).

prep2(before,[prep2,_7746,_7775,!],_7732,_7734) --> 
    w(noun(arrival,sin,u,n),_7746,_7732,_7763),
    prep1(before,_7775,_7763,_7734),
    !.

prep2(before,[prep2,_7736,_7765],_7722,_7724) --> 
    prep1(before,_7736,_7722,_7753),
    ca(_7765,_7753,_7724).

prep2(before,[prep2,lit(like),_7749],_7724,_7726) --> 
    cc(like,_7724,_7748),
    prep1(before,_7749,_7748,_7726).

prep2(before,[prep2,_7736,_7760],_7722,_7724) --> 
    not(_7736,_7722,_7751),
    prep(after,_7760,_7751,_7724).

prep2(before,[prep2,lit(senest),_7749],_7724,_7726) --> 
    cc(senest,_7724,_7748),
    prep1(before,_7749,_7748,_7726).

prep2(before,[prep2,lit(senest)],_7719,_7721) --> 
    cc(senest,_7719,_7721).

prep2(before,[prep2,_7741,_7770],_7727,_7729) --> 
    w(adj2(present,nil),_7741,_7727,_7758),
    prep1(before,_7770,_7758,_7729).

prep2(before,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(to,_7738,_7724,_7755),
    prep1(before,_7767,_7755,_7726).

prep2(before,[prep2,_7738,lit(ca)],_7724,_7726) --> 
    prep1(to,_7738,_7724,_7755),
    cc(ca,_7755,_7726).

prep2(between,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(from,_7738,_7724,_7755),
    prep1(between,_7767,_7755,_7726).

prep2(between,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(in,_7738,_7724,_7755),
    prep1(between,_7767,_7755,_7726).

prep2(between,[prep2,_7746,_7770,_7799],_7732,_7734) --> 
    a0(_7746,_7732,_7761),
    w(noun(place,_7711,_7712,n),_7770,_7761,_7787),
    prep1(between,_7799,_7787,_7734).

prep2(during,[prep2,_7743,lit(løpet),lit(av)],_7729,_7731) --> 
    prep1(in,_7743,_7729,_7760),
    cc(løpet,_7760,_7782),
    cc(av,_7782,_7731).

prep2(during2,[prep2,lit(om),_7747],_7722,_7724) --> 
    cc(om,_7722,_7746),
    ca(_7747,_7746,_7724).

prep2(from,[prep2,_7736,_7765],_7722,_7724) --> 
    prep1(from,_7736,_7722,_7753),
    colon0(_7765,_7753,_7724).

prep2(from,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(from,_7738,_7724,_7755),
    prep1(near,_7767,_7755,_7726).

prep2(from,[prep2,_7752,_7781,_7810,!,_7844],_7738,_7740) --> 
    prep1(from,_7752,_7738,_7769),
    w(adj2(up,nil),_7781,_7769,_7798),
    prep1(at,_7810,_7798,_7827),
    !,
    accept(_7844,_7827,_7740).

prep2(from,[prep2,_7744,_7773,!,_7807],_7730,_7732) --> 
    prep1(from,_7744,_7730,_7761),
    prep1(from,_7773,_7761,_7790),
    !,
    accept(_7807,_7790,_7732).

prep2(from,[prep2,lit(med),_7749],_7724,_7726) --> 
    cc(med,_7724,_7748),
    prep1(from,_7749,_7748,_7726).

prep2(from,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(in,_7738,_7724,_7755),
    prep1(from,_7767,_7755,_7726).

prep2(from,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(over,_7738,_7724,_7755),
    prep1(from,_7767,_7755,_7726).

prep2(from,[prep2,lit(ifra)],_7719,_7721) --> 
    cc(ifra,_7719,_7721).

prep2(from,[prep2,lit(inn),_7749],_7724,_7726) --> 
    cc(inn,_7724,_7748),
    prep1(from,_7749,_7748,_7726).

prep2(from,[prep2,lit(ut),_7747],_7722,_7724) --> 
    cc(ut,_7722,_7746),
    offrom(_7747,_7746,_7724).

prep2(from,[prep2,_7748,_7777,_7806],_7734,_7736) --> 
    prep1(with,_7748,_7734,_7765),
    w(noun(start,sin,_7714,_7715),_7777,_7765,_7794),
    prep1(in,_7806,_7794,_7736).

prep2(from,[prep2,_7736,_7760],_7722,_7724) --> 
    umpover(_7736,_7722,_7751),
    prep1(from,_7760,_7751,_7724).

prep2(from,[prep2,_7748,_7777,lit(nærheten),lit(av)],_7734,_7736) --> 
    prep1(from,_7748,_7734,_7765),
    prep1(in,_7777,_7765,_7794),
    cc(nærheten,_7794,_7816),
    cc(av,_7816,_7736).

prep2(in,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(around,_7738,_7724,_7755),
    prep1(in,_7767,_7755,_7726).

prep2(in,[prep2,lit(inne),_7749],_7724,_7726) --> 
    cc(inne,_7724,_7748),
    prep1(in,_7749,_7748,_7726).

prep2(in,[prep2,lit(nede),_7749],_7724,_7726) --> 
    cc(nede,_7724,_7748),
    prep1(in,_7749,_7748,_7726).

prep2(instead_of,[prep2,lit(i),lit(stedet),lit(for)],_7729,_7731) --> 
    cc(i,_7729,_7753),
    cc(stedet,_7753,_7764),
    cc(for,_7764,_7731).

prep2(near,[prep2,_7739,_7763,_7792],_7725,_7727) --> 
    so0(_7739,_7725,_7754),
    prep1(near,_7763,_7754,_7780),
    to0(_7792,_7780,_7727).

prep2(near,[prep2,_7743,lit(nærheten),lit(av)],_7729,_7731) --> 
    prep1(in,_7743,_7729,_7760),
    cc(nærheten,_7760,_7782),
    cc(av,_7782,_7731).

prep2(near,[prep2,lit(like),_7749],_7724,_7726) --> 
    cc(like,_7724,_7748),
    prep1(at,_7749,_7748,_7726).

prep2(near,[prep2,_7745,_7769,_7798,_7822],_7731,_7733) --> 
    and0(_7745,_7731,_7760),
    w(adj2(nearest,nil),_7769,_7760,_7786),
    possible0(_7798,_7786,_7813),
    to0(_7822,_7813,_7733).

prep2(near,[prep2,_7741,_7770],_7727,_7729) --> 
    w(adj2(near,nil),_7741,_7727,_7758),
    prep1(at,_7770,_7758,_7729).

prep2(near,[prep2,_7746,lit(eller),_7786],_7732,_7734) --> 
    prep1(to,_7746,_7732,_7763),
    cc(eller,_7763,_7785),
    w(adj2(near,nil),_7786,_7785,_7734).

prep2(near,[prep2,_7746,lit(eller),_7786],_7732,_7734) --> 
    prep1(past,_7746,_7732,_7763),
    cc(eller,_7763,_7785),
    w(adj2(near,nil),_7786,_7785,_7734).

prep2(on,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(in,_7738,_7724,_7755),
    prep1(on,_7767,_7755,_7726).

prep2(on,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(with,_7738,_7724,_7755),
    prep1(on,_7767,_7755,_7726).

prep2(on,[prep2,_7747,lit(midt),_7782,!,_7816],_7733,_7735) --> 
    ca0(_7747,_7733,_7762),
    cc(midt,_7762,_7781),
    prep1(on,_7782,_7781,_7799),
    !,
    accept(_7816,_7799,_7735).

prep2(on,[prep2,lit(nede),_7749],_7724,_7726) --> 
    cc(nede,_7724,_7748),
    prep1(on,_7749,_7748,_7726).

prep2(out_of,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(to,_7738,_7724,_7755),
    prep1(outside,_7767,_7755,_7726).

prep2(outside,[prep2,lit(ikke),_7749],_7724,_7726) --> 
    cc(ikke,_7724,_7748),
    prep1(past,_7749,_7748,_7726).

prep2(outside,[prep2,lit(ikke),_7749],_7724,_7726) --> 
    cc(ikke,_7724,_7748),
    prep1(to,_7749,_7748,_7726).

prep2(over,[prep2,lit(litt),_7749],_7724,_7726) --> 
    cc(litt,_7724,_7748),
    prep1(over,_7749,_7748,_7726).

prep2(over,[prep2,_7738,lit(hvilke)],_7724,_7726) --> 
    prep1(over,_7738,_7724,_7755),
    cc(hvilke,_7755,_7726).

prep2(past,[prep2,lit(og),lit(ned)],_7724,_7726) --> 
    cc(og,_7724,_7748),
    cc(ned,_7748,_7726).

prep2(past,[prep2,lit(og),_7749],_7724,_7726) --> 
    cc(og,_7724,_7748),
    prep1(past,_7749,_7748,_7726).

prep2(past,[prep2,lit(ned)],_7719,_7721) --> 
    cc(ned,_7719,_7721).

prep2(past,[prep2,_7753,lit(/),_7793,lit(nærheten),lit(av)],_7739,_7741) --> 
    prep1(past,_7753,_7739,_7770),
    cc(/,_7770,_7792),
    prep1(in,_7793,_7792,_7810),
    cc(nærheten,_7810,_7832),
    cc(av,_7832,_7741).

prep2(past,[prep2,_7753,lit(eller),_7793,lit(nærheten),lit(av)],_7739,_7741) --> 
    prep1(past,_7753,_7739,_7770),
    cc(eller,_7770,_7792),
    prep1(in,_7793,_7792,_7810),
    cc(nærheten,_7810,_7832),
    cc(av,_7832,_7741).

prep2(past,[prep2,_7749,lit(/),_7789,!,_7823],_7735,_7737) --> 
    prep1(to,_7749,_7735,_7766),
    cc(/,_7766,_7788),
    prep1(from,_7789,_7788,_7806),
    !,
    accept(_7823,_7806,_7737).

prep2(past,[prep2,_7747,_7776,_7800,!,_7834],_7733,_7735) --> 
    prep1(to,_7747,_7733,_7764),
    and0(_7776,_7764,_7791),
    prep1(from,_7800,_7791,_7817),
    !,
    accept(_7834,_7817,_7735).

prep2(past,[prep2,_7747,_7776,_7800,!,_7834],_7733,_7735) --> 
    prep1(from,_7747,_7733,_7764),
    and1(_7776,_7764,_7791),
    prep1(to,_7800,_7791,_7817),
    !,
    accept(_7834,_7817,_7735).

prep2(past,[prep2,_7743,_7772],_7729,_7731) --> 
    prep1(with,_7743,_7729,_7760),
    w(noun(departure,_7706,_7707,_7708),_7772,_7760,_7731).

prep2(past,[prep2,_7743,lit(/),_7783],_7729,_7731) --> 
    prep1(past,_7743,_7729,_7760),
    cc(/,_7760,_7782),
    prep1(past,_7783,_7782,_7731).

prep2(to,[prep2,_7736,_7765],_7722,_7724) --> 
    prep1(to,_7736,_7722,_7753),
    colon0(_7765,_7753,_7724).

prep2(to,[prep2,_7744,_7773,!,_7807],_7730,_7732) --> 
    prep1(to,_7744,_7730,_7761),
    prep1(to,_7773,_7761,_7790),
    !,
    accept(_7807,_7790,_7732).

prep2(to,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(to,_7738,_7724,_7755),
    prep1(near,_7767,_7755,_7726).

prep2(to,[prep2,_7748,_7777,_7806],_7734,_7736) --> 
    prep1(in,_7748,_7734,_7765),
    w(noun(connection,_7713,u,n),_7777,_7765,_7794),
    prep1(with,_7806,_7794,_7736).

prep2(to,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(over,_7738,_7724,_7755),
    prep1(to,_7767,_7755,_7726).

prep2(to,[prep2,_7743,_7772],_7729,_7731) --> 
    prep1(with,_7743,_7729,_7760),
    w(noun(arrival,_7706,_7707,_7708),_7772,_7760,_7731).

prep2(to,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(with,_7738,_7724,_7755),
    prep1(to,_7767,_7755,_7726).

prep2(to,[prep2,_7736,_7760],_7722,_7724) --> 
    andsoon(_7736,_7722,_7751),
    prep1(to,_7760,_7751,_7724).

prep2(to,[prep2,lit(hjem),_7749],_7724,_7726) --> 
    cc(hjem,_7724,_7748),
    prep1(to,_7749,_7748,_7726).

prep2(to,[prep2,lit(inn),_7749],_7724,_7726) --> 
    cc(inn,_7724,_7748),
    prep1(to,_7749,_7748,_7726).

prep2(to,[prep2,lit(ned),_7749],_7724,_7726) --> 
    cc(ned,_7724,_7748),
    prep1(to,_7749,_7748,_7726).

prep2(to,[prep2,lit(opp),_7749],_7724,_7726) --> 
    cc(opp,_7724,_7748),
    prep1(to,_7749,_7748,_7726).

prep2(to,[prep2,lit(tur),lit(retur)],_7724,_7726) --> 
    cc(tur,_7724,_7748),
    cc(retur,_7748,_7726).

prep2(to,[prep2,_7736,_7760],_7722,_7724) --> 
    umpover(_7736,_7722,_7751),
    prep1(to,_7760,_7751,_7724).

prep2(towards,[prep2,lit(inn),_7749],_7724,_7726) --> 
    cc(inn,_7724,_7748),
    prep1(towards,_7749,_7748,_7726).

prep2(towards,[prep2,lit(ut),_7749],_7724,_7726) --> 
    cc(ut,_7724,_7748),
    prep1(towards,_7749,_7748,_7726).

prep2(towards,[prep2,lit(ned),_7749],_7724,_7726) --> 
    cc(ned,_7724,_7748),
    prep1(towards,_7749,_7748,_7726).

prep2(towards,[prep2,_7736,_7760],_7722,_7724) --> 
    umpover(_7736,_7722,_7751),
    prep1(towards,_7760,_7751,_7724).

prep2(until,[prep2,_7731],_7717,_7719) --> 
    until(_7731,_7717,_7719).

prep2(with,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(with,_7738,_7724,_7755),
    prep1(on,_7767,_7755,_7726).

prep2(with,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(with,_7738,_7724,_7755),
    prep1(in,_7767,_7755,_7726).

prep2(with,[prep2,_7739,lit(bruk),_7774],_7725,_7727) --> 
    by(_7739,_7725,_7754),
    cc(bruk,_7754,_7773),
    of(_7774,_7773,_7727).

prep2(within,[prep2,_7738,_7767],_7724,_7726) --> 
    prep1(on,_7738,_7724,_7755),
    prep1(under,_7767,_7755,_7726).

prep2(without,[prep2,lit(fri),lit(for)],_7724,_7726) --> 
    cc(fri,_7724,_7748),
    cc(for,_7748,_7726).

umpover([umpover,lit(opp),_7742],_7720,_7722) --> 
    cc(opp,_7720,_7741),
    prep1(over,_7742,_7741,_7722).

umpover([umpover,lit(bort)],_7715,_7717) --> 
    cc(bort,_7715,_7717).

umpover([umpover,_7726],_7715,_7717) --> 
    prep1(over,_7726,_7715,_7717).

umpover([umpover,lit(bortover)],_7715,_7717) --> 
    cc(bortover,_7715,_7717).

umpover([umpover,lit(utover)],_7715,_7717) --> 
    cc(utover,_7715,_7717).

umpover([umpover,lit(innover)],_7715,_7717) --> 
    cc(innover,_7715,_7717).

umpover([umpover,lit(oppover)],_7715,_7717) --> 
    cc(oppover,_7715,_7717).

umpover([umpover,lit(nedover)],_7715,_7717) --> 
    cc(nedover,_7715,_7717).

umpover([umpover,lit(hitover)],_7715,_7717) --> 
    cc(hitover,_7715,_7717).

umpover([umpover,_7736,_7765],_7725,_7727) --> 
    prep1(on,_7736,_7725,_7753),
    w(noun(route,sin,_7705,n),_7765,_7753,_7727).

umpover([umpover,_7736,_7765],_7725,_7727) --> 
    prep1(on,_7736,_7725,_7753),
    w(noun(direction,sin,_7705,n),_7765,_7753,_7727).

pronoun1(_7698,[pronoun1,lit(de),!,_7755],_7725,_7727) --> 
    cc(de,_7725,_7749),
    !,
    reject(_7755,_7749,_7727).

pronoun1(_7698,[pronoun1,lit(en),!,_7755],_7725,_7727) --> 
    cc(en,_7725,_7749),
    !,
    reject(_7755,_7749,_7727).

pronoun1(_7698,[pronoun1,_7733],_7719,_7721) --> 
    pronoun(_7698,_7733,_7719,_7721).

pronoun(thing,[pronoun,_7746,_7775,!,_7804],_7732,_7734) --> 
    one_of_lit([noe,det],_7746,_7732,_7763),
    not_look_ahead_np(_7775,_7763,_7790),
    !,
    accept(_7804,_7790,_7734).

pronoun(thing,[pronoun,lit(det),_7775,_7799,_7828,!,_7862],_7750,_7752) --> 
    cc(det,_7750,_7774),
    look_ahead_vp(_7775,_7774,_7790),
    not_look_ahead(w(adj2(_7721,_7722)),_7799,_7790,_7816),
    not_look_ahead(w(noun(_7728,_7729,_7730,_7731)),_7828,_7816,_7845),
    !,
    accept(_7862,_7845,_7752).

pronoun(agent,[pronoun,lit(man)],_7719,_7721) --> 
    cc(man,_7719,_7721).

pronoun(self,[pronoun,lit(jeg),_7762,_7791],_7737,_7739) --> 
    cc(jeg,_7737,_7761),
    not_look_ahead(['.'],_7762,_7761,_7779),
    not_look_ahead(w(name(_7710,_7711,_7712)),_7791,_7779,_7739).

pronoun(self,[pronoun,lit(meg)],_7719,_7721) --> 
    cc(meg,_7719,_7721).

pronoun(vehicle,[pronoun,lit(den),_7755,{}],_7730,_7732) --> 
    cc(den,_7730,_7754),
    not_look_ahead_np(_7755,_7754,_7732),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(de),_7755,{}],_7730,_7732) --> 
    cc(de,_7730,_7754),
    not_look_ahead_np(_7755,_7754,_7732),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(_7708),{},_7780,!],_7745,_7747) --> 
    cc(_7708,_7745,_7769),
    {user:testmember(_7708,[den,det,en,et])},
    look_ahead([som],_7780,_7769,_7747),
    !.

pronoun(_7698,[pronoun,lit(_7712),{},_7775],_7740,_7742) --> 
    cc(_7712,_7740,_7764),
    {dict_n:pronoun(_7712,_7698)},
    not_look_ahead(w(nb(_7710,_7711)),_7775,_7764,_7742).

pronoun(thing,[pronoun,lit(dette),_7772,_7801,!,_7835],_7747,_7749) --> 
    cc(dette,_7747,_7771),
    not_look_ahead(w(adj2(_7718,_7719)),_7772,_7771,_7789),
    not_look_ahead(w(noun(_7725,_7726,_7727,_7728)),_7801,_7789,_7818),
    !,
    accept(_7835,_7818,_7749).

pronoun(thing,[pronoun,lit(denne),_7753,!,_7782],_7728,_7730) --> 
    cc(denne,_7728,_7752),
    not_look_ahead_np(_7753,_7752,_7768),
    !,
    accept(_7782,_7768,_7730).

pronoun(agent,[pronoun,lit(vi)],_7719,_7721) --> 
    cc(vi,_7719,_7721).

pronoun(savant,[pronoun,lit(du)],_7719,_7721) --> 
    cc(du,_7719,_7721).

pronoun(agent,[pronoun,lit(dere)],_7719,_7721) --> 
    cc(dere,_7719,_7721).

quant_pron(some,person,[quant_pron,lit(en),_7764,!],_7736,_7738) --> 
    cc(en,_7736,_7763),
    look_ahead(w(verb(_7713,_7714,_7715)),_7764,_7763,_7738),
    !.

quant_pron(some,thing,[quant_pron,lit(mye),_7756,!],_7728,_7730) --> 
    cc(mye,_7728,_7755),
    not_look_ahead_np(_7756,_7755,_7730),
    !.

quant_pron(every,person,[quant_pron,_7749,lit(alle),_7789],_7732,_7734) --> 
    not_look_ahead([hver],_7749,_7732,_7766),
    cc(alle,_7766,_7788),
    not_look_ahead_np(_7789,_7788,_7734).

quant_pron(every,thing,[quant_pron,_7753,lit(alt),_7793],_7736,_7738) --> 
    not_look_ahead(w(name(_7711,_7712,_7713)),_7753,_7736,_7770),
    cc(alt,_7770,_7792),
    sammen0(_7793,_7792,_7738).

quant_pron(some,person,[quant_pron,lit(den),_7760,!],_7732,_7734) --> 
    cc(den,_7732,_7759),
    look_ahead([som],_7760,_7759,_7734),
    !.

quant_pron(some,thing,[quant_pron,lit(det),_7760,!],_7732,_7734) --> 
    cc(det,_7732,_7759),
    look_ahead([som],_7760,_7759,_7734),
    !.

quant_pron(some,person,[quant_pron,lit(man)],_7722,_7724) --> 
    cc(man,_7722,_7724).

quant_pron(some,thing,[quant_pron,lit(mer),_7757],_7729,_7731) --> 
    cc(mer,_7729,_7756),
    not_look_ahead([enn],_7757,_7756,_7731).

quant_pron(some,thing,[quant_pron,lit(noe)],_7722,_7724) --> 
    cc(noe,_7722,_7724).

quant_pron(some,agent,[quant_pron,lit(noen),_7763,_7787],_7735,_7737) --> 
    cc(noen,_7735,_7762),
    avdem0(_7763,_7762,_7778),
    not_look_ahead(w(adj(_7711,_7712)),_7787,_7778,_7737).

avdem0([avdem0,lit(av),lit(våre),!,_7764],_7726,_7728) --> 
    cc(av,_7726,_7747),
    cc(våre,_7747,_7758),
    !,
    reject(_7764,_7758,_7728).

avdem0([avdem0,lit(av),lit(dem),!],_7723,_7725) --> 
    cc(av,_7723,_7744),
    cc(dem,_7744,_7725),
    !.

avdem0([avdem0,[]],_7713,_7713) --> 
    [].

quant_pron(some,vehicle,[quant_pron,lit(noen),_7757],_7729,_7731) --> 
    cc(noen,_7729,_7756),
    not_look_ahead([av],_7757,_7756,_7731).

quant_pron(some,agent,[quant_pron,_7737],_7720,_7722) --> 
    someone(_7737,_7720,_7722).

quant_pron(some,thing,[quant_pron,_7748,_7772],_7731,_7733) --> 
    something(_7748,_7731,_7763),
    not_look_ahead(w(verb(_7708,_7709,pass)),_7772,_7763,_7733).

quant_pron(no,person,[quant_pron,lit(ingen),_7753],_7725,_7727) --> 
    cc(ingen,_7725,_7752),
    not_look_ahead_np(_7753,_7752,_7727).

quant_pron(no,thing,[quant_pron,lit(intet),_7762],_7734,_7736) --> 
    cc(intet,_7734,_7761),
    not_look_ahead(w(noun(_7708,_7709,_7710,_7711)),_7762,_7761,_7736).

quant_pron(no,thing,[quant_pron,lit(ingen),lit(ting)],_7727,_7729) --> 
    cc(ingen,_7727,_7754),
    cc(ting,_7754,_7729).

quant_pron(no,thing,[quant_pron,lit(ingenting)],_7722,_7724) --> 
    cc(ingenting,_7722,_7724).

quant_pron(much,thing,[quant_pron,_7747,_7771],_7730,_7732) --> 
    somuch(_7747,_7730,_7762),
    not_look_ahead(w(adj2(_7708,nil)),_7771,_7762,_7732).

quant_pron(little,thing,[quant_pron,_7763,_7792,_7816,_7845],_7746,_7748) --> 
    not_look_ahead(w(adv(_7721)),_7763,_7746,_7780),
    solittle(_7792,_7780,_7807),
    not_look_ahead([å],_7816,_7807,_7833),
    not_look_ahead(w(adj2(late,nil)),_7845,_7833,_7748).

quant_pron(some,feeling,[quant_pron,_7737],_7720,_7722) --> 
    somegood(_7737,_7720,_7722).

denbussen([denbussen,lit(den),_7751,!,_7785],_7729,_7731) --> 
    cc(den,_7729,_7750),
    w(adj2(_7711,nil),_7751,_7750,_7768),
    !,
    reject(_7785,_7768,_7731).

denbussen([denbussen,lit(den)],_7715,_7717) --> 
    cc(den,_7715,_7717).

sammen0([sammen0,lit(sammen),!],_7718,_7720) --> 
    cc(sammen,_7718,_7720),
    !.

sammen0([sammen0,_7732,!],_7721,_7723) --> 
    w(adj2(possible,nil),_7732,_7721,_7723),
    !.

sammen0([sammen0,[]],_7713,_7713) --> 
    [].

somuch([somuch,_7727,_7751],_7716,_7718) --> 
    so0(_7727,_7716,_7742),
    much(_7751,_7742,_7718).

solittle([solittle,_7727,_7751],_7716,_7718) --> 
    so0(_7727,_7716,_7742),
    little(_7751,_7742,_7718).

quant0(_7698,[quant0,_7739,!,_7773],_7725,_7727) --> 
    quant1(_7698,_7739,_7725,_7756),
    !,
    accept(_7773,_7756,_7727).

quant0(1,[quant0,[]],_7717,_7717) --> 
    [].

quant1(+(_7700),[quant1,_7738],_7724,_7726) --> 
    w(nb(_7700,num),_7738,_7724,_7726).

quant1(-(_7700),[quant1,_7735],_7721,_7723) --> 
    ordinal(_7700,_7735,_7721,_7723).

recently([recently,lit(nylig)],_7715,_7717) --> 
    cc(nylig,_7715,_7717).

recently([recently,_7734,lit(det),_7774],_7723,_7725) --> 
    prep1(in,_7734,_7723,_7751),
    cc(det,_7751,_7773),
    latest(_7774,_7773,_7725).

everything([everything,_7737,lit(alt)],_7726,_7728) --> 
    not_look_ahead(w(name(_7707,_7708,_7709)),_7737,_7726,_7754),
    cc(alt,_7754,_7728).

something([something,lit(noe),lit(mer),!,_7764],_7726,_7728) --> 
    cc(noe,_7726,_7747),
    cc(mer,_7747,_7758),
    !,
    accept(_7764,_7758,_7728).

something([something,lit(noe),lit(som),lit(helst),!,_7780],_7731,_7733) --> 
    cc(noe,_7731,_7752),
    cc(som,_7752,_7763),
    cc(helst,_7763,_7774),
    !,
    accept(_7780,_7774,_7733).

something([something,lit(noe)],_7715,_7717) --> 
    cc(noe,_7715,_7717).

something([something,lit(det),_7743,!],_7721,_7723) --> 
    cc(det,_7721,_7742),
    endofline(_7743,_7742,_7723),
    !.

something([something,lit(det),_7756,_7785],_7734,_7736) --> 
    cc(det,_7734,_7755),
    not_look_ahead([å],_7756,_7755,_7773),
    not_look_ahead(w(noun(_7708,_7709,_7710,_7711)),_7785,_7773,_7736).

somegood([somegood,lit(det),_7751,_7775,!],_7729,_7731) --> 
    cc(det,_7729,_7750),
    so0(_7751,_7750,_7766),
    w(adj2(good,nil),_7775,_7766,_7731),
    !.

somegood([somegood,lit(det),_7751,_7775,!],_7729,_7731) --> 
    cc(det,_7729,_7750),
    so0(_7751,_7750,_7766),
    w(adj2(bad,nil),_7775,_7766,_7731),
    !.

sometimes0([sometimes0,_7726],_7715,_7717) --> 
    optional(sometimes,_7726,_7715,_7717).

sometimes([sometimes,lit(noen),_7753,!,_7787],_7731,_7733) --> 
    cc(noen,_7731,_7752),
    w(noun(time_count,_7712,_7713,_7714),_7753,_7752,_7770),
    !,
    accept(_7787,_7770,_7733).

sometimes([sometimes,lit(tidvis)],_7715,_7717) --> 
    cc(tidvis,_7715,_7717).

sometimes0([sometimes0,[]],_7713,_7713) --> 
    [].

notrel([notrel,_7734,!,_7768],_7723,_7725) --> 
    look_ahead([som],_7734,_7723,_7751),
    !,
    reject(_7768,_7751,_7725).

notrel([notrel,[]],_7713,_7713) --> 
    [].

relpron(thing,[relpron,lit(som),_7747],_7722,_7724) --> 
    cc(som,_7722,_7746),
    also0(_7747,_7746,_7724).

recipron(man,[recipron,lit(han),_7747],_7722,_7724) --> 
    cc(han,_7722,_7746),
    self(_7747,_7746,_7724).

recipron(person,[recipron,lit(seg),_7747],_7722,_7724) --> 
    cc(seg,_7722,_7746),
    self(_7747,_7746,_7724).

recipron(woman,[recipron,lit(henne),_7747],_7722,_7724) --> 
    cc(henne,_7722,_7746),
    self(_7747,_7746,_7724).

recipron(thing,[recipron,lit(seg),_7747],_7722,_7724) --> 
    cc(seg,_7722,_7746),
    self0(_7747,_7746,_7724).

recipron(thing,[recipron,lit(hverandre)],_7719,_7721) --> 
    cc(hverandre,_7719,_7721).

same([same,lit(samme)],_7715,_7717) --> 
    cc(samme,_7715,_7717).

self0([self0,_7724],_7713,_7715) --> 
    self(_7724,_7713,_7715).

self0([self0,[]],_7713,_7713) --> 
    [].

self([self,lit(selv)],_7715,_7717) --> 
    cc(selv,_7715,_7717).

set([set,_7731],_7720,_7722) --> 
    w(noun(set,_7701,_7702,n),_7731,_7720,_7722).

setlist([setlist,_7724],_7713,_7715) --> 
    set(_7724,_7713,_7715).

setlist([setlist,_7731],_7720,_7722) --> 
    w(noun(list,_7701,_7702,n),_7731,_7720,_7722).

several([several,lit(fler)],_7715,_7717) --> 
    cc(fler,_7715,_7717).

several([several,lit(flere)],_7715,_7717) --> 
    cc(flere,_7715,_7717).

several([several,lit(mer),lit(enn),_7756],_7723,_7725) --> 
    cc(mer,_7723,_7744),
    cc(enn,_7744,_7755),
    one(_7756,_7755,_7725).

sin([sin,lit(sin)],_7715,_7717) --> 
    cc(sin,_7715,_7717).

sin([sin,lit(sine)],_7715,_7717) --> 
    cc(sine,_7715,_7717).

sin([sin,lit(sitt)],_7715,_7717) --> 
    cc(sitt,_7715,_7717).

saa0([saa0,lit(bare),!,_7748],_7721,_7723) --> 
    cc(bare,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

saa0([saa0,lit(så),_7750,!,_7799],_7728,_7730) --> 
    cc(så,_7728,_7749),
    optional([ofte],_7750,_7749,_7782),
    !,
    accept(_7799,_7782,_7730).

saa0([saa0,lit(mye),!,_7748],_7721,_7723) --> 
    cc(mye,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

saa0([saa0,lit(da),!,_7748],_7721,_7723) --> 
    cc(da,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

saa0([saa0,[]],_7713,_7713) --> 
    [].

so0([so0,_7727,!],_7716,_7718) --> 
    so(_7727,_7716,_7718),
    !.

so0([so0,[]],_7713,_7713) --> 
    [].

so([so,lit(så)],_7715,_7717) --> 
    cc(så,_7715,_7717).

so([so,_7724],_7713,_7715) --> 
    too(_7724,_7713,_7715).

so([so,lit(heretter)],_7715,_7717) --> 
    cc(heretter,_7715,_7717).

so_that([so_that,lit(forat)],_7715,_7717) --> 
    cc(forat,_7715,_7717).

so_that([so_that,lit(som),lit(at)],_7720,_7722) --> 
    cc(som,_7720,_7741),
    cc(at,_7741,_7722).

so_that([so_that,lit(slik),_7747,_7771],_7725,_7727) --> 
    cc(slik,_7725,_7746),
    that(_7747,_7746,_7762),
    optional([bare],_7771,_7762,_7727).

so_that([so_that,lit(så),_7740],_7718,_7720) --> 
    cc(så,_7718,_7739),
    that(_7740,_7739,_7720).

so_that([so_that,lit(som),_7749,_7778],_7727,_7729) --> 
    cc(som,_7727,_7748),
    w(verb(do1,_7709,fin),_7749,_7748,_7766),
    that(_7778,_7766,_7729).

so_that([so_that,lit(så),_7753,!],_7731,_7733) --> 
    cc(så,_7731,_7752),
    look_ahead_lit([jeg,da,den,det],_7753,_7752,_7733),
    !.

so_that([so_that,lit(så),_7752,!],_7730,_7732) --> 
    cc(så,_7730,_7751),
    look_ahead(w(noun(_7710,_7711,_7712,_7713)),_7752,_7751,_7732),
    !.

so_that([so_that,lit(til),lit(at),!],_7723,_7725) --> 
    cc(til,_7723,_7744),
    cc(at,_7744,_7725),
    !.

so_that([so_that,_7731,lit(at)],_7720,_7722) --> 
    prep1(for,_7731,_7720,_7748),
    cc(at,_7748,_7722).

som0([som0,_7724],_7713,_7715) --> 
    som(_7724,_7713,_7715).

som0([som0,[]],_7713,_7713) --> 
    [].

som([som,lit(som)],_7715,_7717) --> 
    cc(som,_7715,_7717).

some([some,lit(noen),_7740],_7718,_7720) --> 
    cc(noen,_7718,_7739),
    of0(_7740,_7739,_7720).

someonex([someonex,_7724],_7713,_7715) --> 
    someone(_7724,_7713,_7715).

someone([someone,lit(dere)],_7715,_7717) --> 
    cc(dere,_7715,_7717).

someone([someone,lit(noen),_7740],_7718,_7720) --> 
    cc(noen,_7718,_7739),
    endofline(_7740,_7739,_7720).

someone([someone,lit(noen),_7748],_7726,_7728) --> 
    cc(noen,_7726,_7747),
    look_ahead(w(verb(_7705,_7706,_7707)),_7748,_7747,_7728).

someone([someone,_7729,lit(mange)],_7718,_7720) --> 
    so0(_7729,_7718,_7744),
    cc(mange,_7744,_7720).

someone([someone,lit(den),_7744],_7722,_7724) --> 
    cc(den,_7722,_7743),
    look_ahead([som],_7744,_7743,_7724).

someone([someone,lit(en),_7744],_7722,_7724) --> 
    cc(en,_7722,_7743),
    look_ahead([som],_7744,_7743,_7724).

soonar([soonar,lit(snart)],_7715,_7717) --> 
    cc(snart,_7715,_7717).

soonar([soonar,lit(snarest)],_7715,_7717) --> 
    cc(snarest,_7715,_7717).

soonar([soonar,lit(fort)],_7715,_7717) --> 
    cc(fort,_7715,_7717).

soon([soon,lit(fort)],_7715,_7717) --> 
    cc(fort,_7715,_7717).

soon([soon,_7729],_7718,_7720) --> 
    w(adj2(fast,nil),_7729,_7718,_7720).

soon([soon,lit(snart)],_7715,_7717) --> 
    cc(snart,_7715,_7717).

soon([soon,lit(snarest)],_7715,_7717) --> 
    cc(snarest,_7715,_7717).

statics(avg,[statics,lit(gjennomsnittet),_7747],_7722,_7724) --> 
    cc(gjennomsnittet,_7722,_7746),
    ofthe0(_7747,_7746,_7724).

statics(max(1),[statics,lit(maksimum),_7749],_7724,_7726) --> 
    cc(maksimum,_7724,_7748),
    ofthe0(_7749,_7748,_7726).

statics(min(1),[statics,lit(minimum),_7749],_7724,_7726) --> 
    cc(minimum,_7724,_7748),
    ofthe0(_7749,_7748,_7726).

statics(sum,[statics,_7734,_7758],_7720,_7722) --> 
    total(_7734,_7720,_7749),
    ofthe0(_7758,_7749,_7722).

statics(number,[statics,lit(antall),_7747],_7722,_7724) --> 
    cc(antall,_7722,_7746),
    ofthe0(_7747,_7746,_7724).

sure([sure,lit(sikker)],_7715,_7717) --> 
    cc(sikker,_7715,_7717).

sure([sure,lit(sikkert)],_7715,_7717) --> 
    cc(sikkert,_7715,_7717).

sure([sure,lit(sikre)],_7715,_7717) --> 
    cc(sikre,_7715,_7717).

terminator([terminator,_7730,!,_7759],_7719,_7721) --> 
    termchar(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

termchar0([termchar0,_7727,!],_7716,_7718) --> 
    termchar(_7727,_7716,_7718),
    !.

termchar0([termchar0,[]],_7713,_7713) --> 
    [].

termchar([termchar,lit('.')],_7715,_7717) --> 
    cc('.',_7715,_7717).

termchar([termchar,lit(?)],_7715,_7717) --> 
    cc(?,_7715,_7717).

termchar([termchar,lit(!)],_7715,_7717) --> 
    cc(!,_7715,_7717).

termchar([termchar,lit(:)],_7715,_7717) --> 
    cc(:,_7715,_7717).

than0([than0,_7724],_7713,_7715) --> 
    than(_7724,_7713,_7715).

than0([than0,[]],_7713,_7713) --> 
    [].

than([than,lit(enn)],_7715,_7717) --> 
    cc(enn,_7715,_7717).

that([that,lit(om),lit(at),!,_7764],_7726,_7728) --> 
    cc(om,_7726,_7747),
    cc(at,_7747,_7758),
    !,
    accept(_7764,_7758,_7728).

that([that,lit(at)],_7715,_7717) --> 
    cc(at,_7715,_7717).

that(that,[that,_7731],_7717,_7719) --> 
    that(_7731,_7717,_7719).

that(how,[that,_7731],_7717,_7719) --> 
    how(_7731,_7717,_7719).

that(when,[that,_7731],_7717,_7719) --> 
    when(_7731,_7717,_7719).

that(where,[that,_7731],_7717,_7719) --> 
    where(_7731,_7717,_7719).

that(whether,[that,_7736,lit(hvorvidt)],_7722,_7724) --> 
    paa0(_7736,_7722,_7751),
    cc(hvorvidt,_7751,_7724).

that(whether,[that,_7736,lit(om)],_7722,_7724) --> 
    paa0(_7736,_7722,_7751),
    cc(om,_7751,_7724).

that(why,[that,lit(hvorfor)],_7719,_7721) --> 
    cc(hvorfor,_7719,_7721).

paa0([paa0,lit(på),!,_7748],_7721,_7723) --> 
    cc(på,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

paa0([paa0,[]],_7713,_7713) --> 
    [].

that0([that0,_7724],_7713,_7715) --> 
    that(_7724,_7713,_7715).

that0([that0,[]],_7713,_7713) --> 
    [].

the([the,lit(den)],_7715,_7717) --> 
    cc(den,_7715,_7717).

the([the,lit(denne)],_7715,_7717) --> 
    cc(denne,_7715,_7717).

the([the,lit(det)],_7715,_7717) --> 
    cc(det,_7715,_7717).

the([the,lit(de)],_7715,_7717) --> 
    cc(de,_7715,_7717).

the([the,lit(dette)],_7715,_7717) --> 
    cc(dette,_7715,_7717).

the([the,lit(disse),_7740],_7718,_7720) --> 
    cc(disse,_7718,_7739),
    look_ahead_np(_7740,_7739,_7720).

themost([themost,_7729,lit(mest)],_7718,_7720) --> 
    the(_7729,_7718,_7744),
    cc(mest,_7744,_7720).

the0([the0,_7733,_7757,!,_7786],_7722,_7724) --> 
    the(_7733,_7722,_7748),
    der0(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

the0([the0,{},_7742],_7721,_7723) --> 
    {user:value(textflag,true)},
    art(_7742,_7721,_7723).

the0([the0,[]],_7713,_7713) --> 
    [].

the10([the10,lit(det)],_7715,_7717) --> 
    cc(det,_7715,_7717).

the10([the10,lit(den)],_7715,_7717) --> 
    cc(den,_7715,_7717).

the10([the10,[]],_7713,_7713) --> 
    [].

theplu0([theplu0,_7733,_7757,!,_7786],_7722,_7724) --> 
    all0(_7733,_7722,_7748),
    theplu(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

theplu0([theplu0,lit(den)],_7715,_7717) --> 
    cc(den,_7715,_7717).

theplu0([theplu0,_7724],_7713,_7715) --> 
    all0(_7724,_7713,_7715).

theplu([theplu,lit(de)],_7715,_7717) --> 
    cc(de,_7715,_7717).

their([their,lit(deres)],_7715,_7717) --> 
    cc(deres,_7715,_7717).

their([their,lit(de),lit(andres)],_7720,_7722) --> 
    cc(de,_7720,_7741),
    cc(andres,_7741,_7722).

then0([then0,_7730,!,_7759],_7719,_7721) --> 
    then1(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

then0([then0,[]],_7713,_7713) --> 
    [].

then1([then1,lit(da)],_7715,_7717) --> 
    cc(da,_7715,_7717).

then1([then1,lit(så)],_7715,_7717) --> 
    cc(så,_7715,_7717).

theonly0([theonly0,_7727,_7751],_7716,_7718) --> 
    the0(_7727,_7716,_7742),
    only0(_7751,_7742,_7718).

thereit0([thereit0,_7730,!,_7759],_7719,_7721) --> 
    thereit(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

thereit0([thereit0,[]],_7713,_7713) --> 
    [].

therenot0([therenot0,_7733,_7757,!,_7786],_7722,_7724) --> 
    thereit(_7733,_7722,_7748),
    not0(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

therenot0([therenot0,_7733,_7757,!,_7786],_7722,_7724) --> 
    not(_7733,_7722,_7748),
    thereit0(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

therenot0([therenot0,[]],_7713,_7713) --> 
    [].

thereit(_7698,[thereit,_7748,_7772,_7801,_7825,!,_7854],_7734,_7736) --> 
    thereit(_7748,_7734,_7763),
    negation0(_7698,_7772,_7763,_7789),
    redundant0(_7801,_7789,_7816),
    been0(_7825,_7816,_7840),
    !,
    accept(_7854,_7840,_7736).

thereitN([thereitN,_7734,_7758,!],_7723,_7725) --> 
    thereit(_7734,_7723,_7749),
    look_ahead([ikke],_7758,_7749,_7725),
    !.

thereitN([thereitN,_7724],_7713,_7715) --> 
    thereit(_7724,_7713,_7715).

dette([dette,lit(det),_7740],_7718,_7720) --> 
    cc(det,_7718,_7739),
    it_was_pronoun(_7740,_7739,_7720).

dette([dette,lit(dette)],_7715,_7717) --> 
    cc(dette,_7715,_7717).

thereit2(be,[thereit2,lit(det),!],_7722,_7724) --> 
    cc(det,_7722,_7724),
    !.

thereit2(_7698,[thereit2,_7734,!],_7720,_7722) --> 
    thereit(_7734,_7720,_7722),
    !.

thereit2(be,[thereit2,_7738,!],_7724,_7726) --> 
    look_ahead([til],_7738,_7724,_7726),
    !.

init([init,lit(det)],_7715,_7717) --> 
    cc(det,_7715,_7717).

init([init,lit(dette),_7740],_7718,_7720) --> 
    cc(dette,_7718,_7739),
    look_ahead_vp(_7740,_7739,_7720).

thereit([thereit,lit(de),_7744],_7722,_7724) --> 
    cc(de,_7722,_7743),
    look_ahead([noe],_7744,_7743,_7724).

thereit([thereit,lit(det),_7746,!,_7775],_7724,_7726) --> 
    cc(det,_7724,_7745),
    thereit_not_pronoun(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

thereit([thereit,lit(der)],_7715,_7717) --> 
    cc(der,_7715,_7717).

thereit([thereit,lit(her)],_7715,_7717) --> 
    cc(her,_7715,_7717).

thereit_not_pronoun([thereit_not_pronoun,_7730,!,_7759],_7719,_7721) --> 
    it_was_pronoun(_7730,_7719,_7745),
    !,
    reject(_7759,_7745,_7721).

thereit_not_pronoun([thereit_not_pronoun,[]],_7713,_7713) --> 
    [].

it_was_pronoun([it_was_pronoun,_7724],_7713,_7715) --> 
    endofline(_7724,_7713,_7715).

it_was_pronoun([it_was_pronoun,_7724],_7713,_7715) --> 
    look_ahead_vp(_7724,_7713,_7715).

this(_7698,[this,_7738,{}],_7724,_7726) --> 
    this(_7738,_7724,_7726),
    {user:it_template(_7698)}.

this(_7698,[this,_7738,{}],_7724,_7726) --> 
    thereit(_7738,_7724,_7726),
    {user:it_template(_7698)}.

this([this,lit(denne)],_7715,_7717) --> 
    cc(denne,_7715,_7717).

this([this,lit(dette)],_7715,_7717) --> 
    cc(dette,_7715,_7717).

this([this,lit(disse),_7740],_7718,_7720) --> 
    cc(disse,_7718,_7739),
    not_look_ahead_np(_7740,_7739,_7720).

this([this,lit(det),_7747,_7776],_7725,_7727) --> 
    cc(det,_7725,_7746),
    look_ahead(['.'],_7747,_7746,_7764),
    accept(_7776,_7764,_7727).

this([this,lit(det),_7747,_7776],_7725,_7727) --> 
    cc(det,_7725,_7746),
    look_ahead([?],_7747,_7746,_7764),
    accept(_7776,_7764,_7727).

this([this,lit(det),lit(da),!,_7764],_7726,_7728) --> 
    cc(det,_7726,_7747),
    cc(da,_7747,_7758),
    !,
    accept(_7764,_7758,_7728).

this([this,lit(det),_7746,!,_7775],_7724,_7726) --> 
    cc(det,_7724,_7745),
    end_of_line(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

this([this,lit(slik),_7746],_7724,_7726) --> 
    cc(slik,_7724,_7745),
    not_look_ahead_lit([at,som],_7746,_7745,_7726).

thisplace(in,[thisplace,lit(her)],_7719,_7721) --> 
    cc(her,_7719,_7721).

thisplace(to,[thisplace,lit(hit)],_7719,_7721) --> 
    cc(hit,_7719,_7721).

thisplace(in,[thisplace,lit(der)],_7719,_7721) --> 
    cc(der,_7719,_7721).

thisplace(to,[thisplace,lit(dit)],_7719,_7721) --> 
    cc(dit,_7719,_7721).

timepoint([timepoint,_7731],_7720,_7722) --> 
    w(noun(time,_7701,u,n),_7731,_7720,_7722).

timepoint([timepoint,_7731],_7720,_7722) --> 
    w(noun(clock,sin,u,n),_7731,_7720,_7722).

to([to,_7726],_7715,_7717) --> 
    prep(to,_7726,_7715,_7717).

forto0([forto0,_7727,!],_7716,_7718) --> 
    forto(_7727,_7716,_7718),
    !.

forto0([forto0,[]],_7713,_7713) --> 
    [].

forto([forto,lit(for)],_7715,_7717) --> 
    cc(for,_7715,_7717).

forto([forto,lit(til)],_7715,_7717) --> 
    cc(til,_7715,_7717).

forto([forto,lit(om)],_7715,_7717) --> 
    cc(om,_7715,_7717).

slikat([slikat,lit(slik),lit(at)],_7720,_7722) --> 
    cc(slik,_7720,_7741),
    cc(at,_7741,_7722).

slikat([slikat,lit(sikkert),lit(at)],_7720,_7722) --> 
    cc(sikkert,_7720,_7741),
    cc(at,_7741,_7722).

to0([to0,_7727,!],_7716,_7718) --> 
    to(_7727,_7716,_7718),
    !.

to0([to0,[]],_7713,_7713) --> 
    [].

tomed0([tomed0,lit(til),!],_7718,_7720) --> 
    cc(til,_7718,_7720),
    !.

tomed0([tomed0,lit(med),!],_7718,_7720) --> 
    cc(med,_7718,_7720),
    !.

tomed0([tomed0,[]],_7713,_7713) --> 
    [].

too([too,lit(for),_7747],_7725,_7727) --> 
    cc(for,_7725,_7746),
    look_ahead(w(adj(_7705,nil)),_7747,_7746,_7727).

today0([today0,_7724],_7713,_7715) --> 
    today(_7724,_7713,_7715).

today0([today0,[]],_7713,_7713) --> 
    [].

today([today,lit(idag)],_7715,_7717) --> 
    cc(idag,_7715,_7717).

today([today,_7736,_7765],_7725,_7727) --> 
    prep(in,_7736,_7725,_7753),
    w(noun(day,sin,u,n),_7765,_7753,_7727).

tomorrow([tomorrow,lit(imorgen)],_7715,_7717) --> 
    cc(imorgen,_7715,_7717).

tomorrow([tomorrow,_7731,lit(morgen)],_7720,_7722) --> 
    prep1(in,_7731,_7720,_7748),
    cc(morgen,_7748,_7722).

total([total,lit(total)],_7715,_7717) --> 
    cc(total,_7715,_7717).

total([total,lit(totalt)],_7715,_7717) --> 
    cc(totalt,_7715,_7717).

total([total,lit(totale)],_7715,_7717) --> 
    cc(totale,_7715,_7717).

total([total,lit(sum),_7740],_7718,_7720) --> 
    cc(sum,_7718,_7739),
    of(_7740,_7739,_7720).

true([true,lit(sann)],_7715,_7717) --> 
    cc(sann,_7715,_7717).

true([true,lit(sant)],_7715,_7717) --> 
    cc(sant,_7715,_7717).

true([true,lit(sanne)],_7715,_7717) --> 
    cc(sanne,_7715,_7717).

true([true,lit(slik)],_7715,_7717) --> 
    cc(slik,_7715,_7717).

truefalse(id,[truefalse,_7731],_7717,_7719) --> 
    true(_7731,_7717,_7719).

truefalse(id,[truefalse,_7734,_7758],_7720,_7722) --> 
    not(_7734,_7720,_7749),
    false(_7758,_7749,_7722).

truefalse(not,[truefalse,_7731],_7717,_7719) --> 
    false(_7731,_7717,_7719).

truefalse(not,[truefalse,_7734,_7758],_7720,_7722) --> 
    not(_7734,_7720,_7749),
    true(_7758,_7749,_7722).

unequal([unequal,lit(ulik)],_7715,_7717) --> 
    cc(ulik,_7715,_7717).

unequal([unequal,lit(ulikt)],_7715,_7717) --> 
    cc(ulikt,_7715,_7717).

unequal([unequal,lit(ulike)],_7715,_7717) --> 
    cc(ulike,_7715,_7717).

unequal([unequal,_7727,_7751],_7716,_7718) --> 
    not(_7727,_7716,_7742),
    equal(_7751,_7742,_7718).

until([until,lit(inntil)],_7715,_7717) --> 
    cc(inntil,_7715,_7717).

until([until,lit(fram),_7742],_7720,_7722) --> 
    cc(fram,_7720,_7741),
    prep1(to,_7742,_7741,_7722).

use([use,_7730],_7719,_7721) --> 
    w(verb(use,_7701,fin),_7730,_7719,_7721).

use([use,_7730],_7719,_7721) --> 
    w(verb(want,_7701,fin),_7730,_7719,_7721).

what([what,lit(hva)],_7715,_7717) --> 
    cc(hva,_7715,_7717).

whatbe([whatbe,_7733,_7757,!,_7786],_7722,_7724) --> 
    what(_7733,_7722,_7748),
    be(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

whatbe([whatbe,lit(hvilke),_7746,!,_7775],_7724,_7726) --> 
    cc(hvilke,_7724,_7745),
    be(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

whatbe([whatbe,lit(hvilken),_7746,!,_7775],_7724,_7726) --> 
    cc(hvilken,_7724,_7745),
    be(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

whatbe([whatbe,lit(hvilket),_7746,!,_7775],_7724,_7726) --> 
    cc(hvilket,_7724,_7745),
    be(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

whatbemean([whatbemean,lit(hva),_7746],_7724,_7726) --> 
    cc(hva,_7724,_7745),
    w(verb(be,pres,fin),_7746,_7745,_7726).

whatbemean([whatbemean,lit(hva),_7746],_7724,_7726) --> 
    cc(hva,_7724,_7745),
    w(verb(mean2,pres,fin),_7746,_7745,_7726).

whatbemean([whatbemean,lit(hva),_7746],_7724,_7726) --> 
    cc(hva,_7724,_7745),
    w(verb(indicate,pres,fin),_7746,_7745,_7726).

when0([when0,_7730,!,_7759],_7719,_7721) --> 
    when(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

when0([when0,[]],_7713,_7713) --> 
    [].

whenx([whenx,_7735,lit(jeg),!,_7775],_7724,_7726) --> 
    when1(_7735,_7724,_7750),
    cc(jeg,_7750,_7769),
    !,
    reject(_7775,_7769,_7726).

whenx([whenx,_7724],_7713,_7715) --> 
    when(_7724,_7713,_7715).

when([when,lit(når),_7746,!,_7775],_7724,_7726) --> 
    cc(når,_7724,_7745),
    timepoint(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

when([when,lit(når)],_7715,_7717) --> 
    cc(når,_7715,_7717).

when([when,lit(hvordan),_7753,!,_7787],_7731,_7733) --> 
    cc(hvordan,_7731,_7752),
    w(noun(time,_7712,u,n),_7753,_7752,_7770),
    !,
    accept(_7787,_7770,_7733).

when([when,lit(hvor),_7746,!,_7775],_7724,_7726) --> 
    cc(hvor,_7724,_7745),
    timepoint(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

when([when,lit(hva),_7746,!,_7775],_7724,_7726) --> 
    cc(hva,_7724,_7745),
    timepoint(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

when([when,_7733,_7757,!,_7786],_7722,_7724) --> 
    which(_7733,_7722,_7748),
    timepoint(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

when([when,_7738,_7767,_7791,!,_7820],_7727,_7729) --> 
    prep1(to,_7738,_7727,_7755),
    which(_7767,_7755,_7782),
    timepoint(_7791,_7782,_7806),
    !,
    accept(_7820,_7806,_7729).

when([when,_7738,_7767,_7791,!,_7820],_7727,_7729) --> 
    prep1(on,_7738,_7727,_7755),
    which(_7767,_7755,_7782),
    timepoint(_7791,_7782,_7806),
    !,
    accept(_7820,_7806,_7729).

when([when,lit(så),lit(snart),!,_7764],_7726,_7728) --> 
    cc(så,_7726,_7747),
    cc(snart,_7747,_7758),
    !,
    accept(_7764,_7758,_7728).

when([when,lit(hva),lit(ti)],_7720,_7722) --> 
    cc(hva,_7720,_7741),
    cc(ti,_7741,_7722).

when([when,lit(hvordan),lit(ti)],_7720,_7722) --> 
    cc(hvordan,_7720,_7741),
    cc(ti,_7741,_7722).

when([when,lit(tid),_7744],_7722,_7724) --> 
    cc(tid,_7722,_7743),
    look_ahead([går],_7744,_7743,_7724).

where([where,lit(hvor),_7755,_7784,!,_7813],_7733,_7735) --> 
    cc(hvor,_7733,_7754),
    not_look_ahead(w(prep(from)),_7755,_7754,_7772),
    andwhen0(_7784,_7772,_7799),
    !,
    accept(_7813,_7799,_7735).

where([where,_7740,_7764,!,_7798],_7729,_7731) --> 
    which(_7740,_7729,_7755),
    w(noun(place,_7710,_7711,_7712),_7764,_7755,_7781),
    !,
    accept(_7798,_7781,_7731).

where1([where1,lit(der),lit(hvor),!,_7764],_7726,_7728) --> 
    cc(der,_7726,_7747),
    cc(hvor,_7747,_7758),
    !,
    accept(_7764,_7758,_7728).

where1([where1,lit(hvor),_7746,!,_7775],_7724,_7726) --> 
    cc(hvor,_7724,_7745),
    meny(_7746,_7745,_7761),
    !,
    reject(_7775,_7761,_7726).

where1([where1,lit(hvor)],_7715,_7717) --> 
    cc(hvor,_7715,_7717).

where1([where1,lit(der)],_7715,_7717) --> 
    cc(der,_7715,_7717).

wherefrom([wherefrom,_7745,_7774,_7798,!,_7832],_7734,_7736) --> 
    prep1(from,_7745,_7734,_7762),
    which(_7774,_7762,_7789),
    w(noun(place,_7715,_7716,_7717),_7798,_7789,_7815),
    !,
    accept(_7832,_7815,_7736).

wherefrom([wherefrom,_7737,lit(hvor),!,_7782],_7726,_7728) --> 
    prep1(from,_7737,_7726,_7754),
    cc(hvor,_7754,_7776),
    !,
    accept(_7782,_7776,_7728).

wherefrom([wherefrom,lit(hvorfra)],_7715,_7717) --> 
    cc(hvorfra,_7715,_7717).

wherefrom([wherefrom,lit(hvor),lit(fra)],_7720,_7722) --> 
    cc(hvor,_7720,_7741),
    cc(fra,_7741,_7722).

wherefrom([wherefrom,lit(hvor),lit(ifra)],_7720,_7722) --> 
    cc(hvor,_7720,_7741),
    cc(ifra,_7741,_7722).

while([while,lit(mens)],_7715,_7717) --> 
    cc(mens,_7715,_7717).

which0([which0,_7730,!,_7759],_7719,_7721) --> 
    which(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

which0([which0,[]],_7713,_7713) --> 
    [].

which([which,lit(hva),_7748,_7777,!],_7726,_7728) --> 
    cc(hva,_7726,_7747),
    prep1(for,_7748,_7747,_7765),
    a0(_7777,_7765,_7728),
    !.

which([which,lit(hva),lit(slags),!],_7723,_7725) --> 
    cc(hva,_7723,_7744),
    cc(slags,_7744,_7725),
    !.

which([which,lit(hvilken),lit(slags),!],_7723,_7725) --> 
    cc(hvilken,_7723,_7744),
    cc(slags,_7744,_7725),
    !.

which([which,lit(hvilken)],_7715,_7717) --> 
    cc(hvilken,_7715,_7717).

which([which,lit(hvilket)],_7715,_7717) --> 
    cc(hvilket,_7715,_7717).

which([which,lit(hvilke),_7740],_7718,_7720) --> 
    cc(hvilke,_7718,_7739),
    off0(_7740,_7739,_7720).

which2([which2,_7730,_7754,_7778],_7719,_7721) --> 
    which(_7730,_7719,_7745),
    numbertype0(_7754,_7745,_7769),
    ofthe0(_7778,_7769,_7721).

which2([which2,lit(hvem),_7764,_7793,!],_7742,_7744) --> 
    cc(hvem,_7742,_7763),
    look_ahead(w(noun(_7713,sin,u,n)),_7764,_7763,_7781),
    gmem(_7713,[bus,tram,day],_7793,_7781,_7744),
    !.

which2([which2,lit(hvordan),_7766,_7795,!],_7744,_7746) --> 
    cc(hvordan,_7744,_7765),
    look_ahead(w(noun(_7713,sin,u,n)),_7766,_7765,_7783),
    gmem(_7713,[label,bus,tram,day],_7795,_7783,_7746),
    !.

numbertype0([numbertype0,_7730,!,_7759],_7719,_7721) --> 
    type(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

numbertype0([numbertype0,[]],_7713,_7713) --> 
    [].

with0([with0,_7732,!,_7766],_7721,_7723) --> 
    prep(with,_7732,_7721,_7749),
    !,
    accept(_7766,_7749,_7723).

with0([with0,[]],_7713,_7713) --> 
    [].

who([who,lit(hvem)],_7715,_7717) --> 
    cc(hvem,_7715,_7717).

whose([whose,lit(hvis)],_7715,_7717) --> 
    cc(hvis,_7715,_7717).

mex0([mex0,_7734,!,_7768],_7723,_7725) --> 
    look_ahead([jeg],_7734,_7723,_7751),
    !,
    reject(_7768,_7751,_7725).

mex0([mex0,_7734,!,_7768],_7723,_7725) --> 
    look_ahead([du],_7734,_7723,_7751),
    !,
    reject(_7768,_7751,_7725).

mex0([mex0,lit(seg),!,_7748],_7721,_7723) --> 
    cc(seg,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

mex0([mex0,lit(meg),!,_7748],_7721,_7723) --> 
    cc(meg,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

mex0([mex0,lit(oss),!,_7748],_7721,_7723) --> 
    cc(oss,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

mex0([mex0,[]],_7713,_7713) --> 
    [].

you([you,lit(du),_7744],_7722,_7724) --> 
    cc(du,_7722,_7743),
    not_look_ahead([jeg],_7744,_7743,_7724).

yesterday([yesterday,_7731,lit(går)],_7720,_7722) --> 
    prep1(in,_7731,_7720,_7748),
    cc(går,_7748,_7722).

younger([younger,lit(yngre)],_7715,_7717) --> 
    cc(yngre,_7715,_7717).

your([your,lit(din)],_7715,_7717) --> 
    cc(din,_7715,_7717).

your([your,lit(ditt)],_7715,_7717) --> 
    cc(ditt,_7715,_7717).

your([your,lit(dine)],_7715,_7717) --> 
    cc(dine,_7715,_7717).

your([your,lit(di)],_7715,_7717) --> 
    cc(di,_7715,_7717).

num_na(_7698,[num_na,_7737,!,_7766],_7723,_7725) --> 
    art(_7737,_7723,_7752),
    !,
    reject(_7766,_7752,_7725).

num_na(_7698,[num_na,_7736],_7722,_7724) --> 
    w(nb(_7698,_7703),_7736,_7722,_7724).

num(_7698,[num,_7739,!],_7725,_7727) --> 
    w(nb(_7698,num),_7739,_7725,_7727),
    !.

personal('    ',[personal,lit(hysj)],_7719,_7721) --> 
    cc(hysj,_7719,_7721).

personal('RPGOLRAM',[personal,lit(rpgol)],_7719,_7721) --> 
    cc(rpgol,_7719,_7721).

personal('OK',[personal,lit(rpgolram)],_7719,_7721) --> 
    cc(rpgolram,_7719,_7721).

personal('Takk',[personal,lit(værsågod)],_7719,_7721) --> 
    cc(værsågod,_7719,_7721).

personal('Takk',[personal,_7750,lit(så),_7790],_7736,_7738) --> 
    w(verb(be,imp,fin),_7750,_7736,_7767),
    cc(så,_7767,_7789),
    w(adj2(good,nil),_7790,_7789,_7738).

personal('Takk',[personal,_7740,_7764,_7788,_7812],_7726,_7728) --> 
    so(_7740,_7726,_7755),
    good(_7764,_7755,_7779),
    you(_7788,_7779,_7803),
    be(_7812,_7803,_7728).

personal('Takk',[personal,lit(bravo)],_7719,_7721) --> 
    cc(bravo,_7719,_7721).

personal('Takk',[personal,_7743,_7772,_7796],_7729,_7731) --> 
    w(verb(congratulate,pres,fin),_7743,_7729,_7760),
    with0(_7772,_7760,_7787),
    skip_rest(_7796,_7787,_7731).

personal(pong,[personal,lit(ping)],_7719,_7721) --> 
    cc(ping,_7719,_7721).

personal(_7698,[personal,_7733],_7719,_7721) --> 
    greetings(_7698,_7733,_7719,_7721).

greetings0([greetings0,_7736,_7765,!],_7725,_7727) --> 
    w(verb(help,imp,fin),_7736,_7725,_7753),
    optoken(_7765,_7753,_7727),
    !.

greetings0([greetings0,_7735,_7779,_7803,!],_7724,_7726) --> 
    optional(grums,_7735,_7724,_7767),
    greetings(_7779,_7767,_7794),
    optoken(_7803,_7794,_7726),
    !.

greetings0([greetings0,_7726],_7715,_7717) --> 
    optional(grums,_7726,_7715,_7717).

greetings('OK',[greetings,_7734,_7758],_7720,_7722) --> 
    okeys(_7734,_7720,_7749),
    endofline(_7758,_7749,_7722).

greetings('Hei på deg',[greetings,_7734,_7758],_7720,_7722) --> 
    hello(_7734,_7720,_7749),
    daddy(_7758,_7749,_7722).

greetings('Hei',[greetings,_7731],_7717,_7719) --> 
    greetings(_7731,_7717,_7719).

daddy([daddy,_7734,!],_7723,_7725) --> 
    w(noun(father,sin,u,n),_7734,_7723,_7725),
    !.

daddy([daddy,_7734,!],_7723,_7725) --> 
    w(noun(mother,sin,u,n),_7734,_7723,_7725),
    !.

daddy([daddy,_7733,!],_7722,_7724) --> 
    w(name(_7703,n,man),_7733,_7722,_7724),
    !.

optoken([optoken,lit(:)],_7715,_7717) --> 
    cc(:,_7715,_7717).

optoken([optoken,lit(!)],_7715,_7717) --> 
    cc(!,_7715,_7717).

optoken([optoken,lit('.')],_7715,_7717) --> 
    cc('.',_7715,_7717).

optoken([optoken,[]],_7713,_7713) --> 
    [].

greetings([greetings,lit(_7703),{}],_7733,_7735) --> 
    cc(_7703,_7733,_7735),
    {user:testmember(_7703,[ja,jo,joda,nei,neida])}.

greetings([greetings,_7724],_7713,_7715) --> 
    hellos(_7724,_7713,_7715).

greetings([greetings,lit(hva),lit(om)],_7720,_7722) --> 
    cc(hva,_7720,_7741),
    cc(om,_7741,_7722).

greetings([greetings,lit(nei)],_7715,_7717) --> 
    cc(nei,_7715,_7717).

greetings([greetings,lit(o),_7746,_7770],_7724,_7726) --> 
    cc(o,_7724,_7745),
    adj0(_7746,_7745,_7761),
    np0(_7704,_7705,_7770,_7761,_7726).

greetings([greetings,_7735,lit(meg)],_7724,_7726) --> 
    w(verb(say,inf,fin),_7735,_7724,_7752),
    cc(meg,_7752,_7726).

greetings([greetings,_7758,{},_7797,_7821,!],_7747,_7749) --> 
    w(noun(_7712,sin,u,n),_7758,_7747,_7775),
    {user:testmember(_7712,[oracle,brother,sister])},
    colon0(_7797,_7775,_7812),
    look_ahead([når],_7821,_7812,_7749),
    !.

greetings([greetings,_7759,{},_7798,_7822],_7748,_7750) --> 
    w(noun(_7717,sin,u,n),_7759,_7748,_7776),
    {user:testmember(_7717,[oracle,brother,sister])},
    colon0(_7798,_7776,_7813),
    not_look_ahead(w(verb(_7711,_7712,fin)),_7822,_7813,_7750).

greetings([greetings,_7766,_7795,_7824,_7853,_7877,_7906,_7930],_7755,_7757) --> 
    w(name(bustuc,n,_7720),_7766,_7755,_7783),
    not_look_ahead([som],_7795,_7783,_7812),
    not_look_ahead(w(prep(_7730)),_7824,_7812,_7841),
    colon0(_7853,_7841,_7868),
    not_look_ahead(w(verb(_7736,_7737,_7738)),_7877,_7868,_7894),
    not_look_ahead_vp(_7906,_7894,_7921),
    not_look_ahead_np(_7930,_7921,_7757).

trafikk([trafikk,lit(trafikk)],_7715,_7717) --> 
    cc(trafikk,_7715,_7717).

trafikk([trafikk,lit(t)],_7715,_7717) --> 
    cc(t,_7715,_7717).

grums0([grums0,[]],_7713,_7713) --> 
    [].

grums([grums,lit(rute),{}],_7723,_7725) --> 
    cc(rute,_7723,_7725),
    {user:value(smsflag,true)}.

grums([grums,lit('.')],_7715,_7717) --> 
    cc('.',_7715,_7717).

grums([grums,lit(?)],_7715,_7717) --> 
    cc(?,_7715,_7717).

grums([grums,lit(:),!],_7718,_7720) --> 
    cc(:,_7718,_7720),
    !.

grums([grums,lit(/),!],_7718,_7720) --> 
    cc(/,_7718,_7720),
    !.

grums([grums,lit(!),!],_7718,_7720) --> 
    cc(!,_7718,_7720),
    !.

grums([grums,lit(-),!],_7718,_7720) --> 
    cc(-,_7718,_7720),
    !.

grums([grums,lit(eksempelvis),lit(:)],_7720,_7722) --> 
    cc(eksempelvis,_7720,_7741),
    cc(:,_7741,_7722).

grums([grums,_7729,lit(at)],_7718,_7720) --> 
    redundant(_7729,_7718,_7744),
    cc(at,_7744,_7720).

grums([grums,_7753,lit(:),_7793,!],_7742,_7744) --> 
    w(noun(_7709,sin,u,n),_7753,_7742,_7770),
    cc(:,_7770,_7792),
    gmem(_7709,[error,thing,subject,example],_7793,_7792,_7744),
    !.

grums([grums,_7737,lit(om),!],_7726,_7728) --> 
    w(adj2(good,nil),_7737,_7726,_7754),
    cc(om,_7754,_7728),
    !.

grums([grums,lit(bare)],_7715,_7717) --> 
    cc(bare,_7715,_7717).

grums([grums,lit(eller)],_7715,_7717) --> 
    cc(eller,_7715,_7717).

grums([grums,lit(fyi),_7740],_7718,_7720) --> 
    cc(fyi,_7718,_7739),
    point0(_7740,_7739,_7720).

grums([grums,lit(grr)],_7715,_7717) --> 
    cc(grr,_7715,_7717).

grums([grums,lit(huff)],_7715,_7717) --> 
    cc(huff,_7715,_7717).

grums([grums,lit(igjen)],_7715,_7717) --> 
    cc(igjen,_7715,_7717).

grums([grums,lit(jo)],_7715,_7717) --> 
    cc(jo,_7715,_7717).

grums([grums,lit(og)],_7715,_7717) --> 
    cc(og,_7715,_7717).

grums([grums,lit(kort),lit(sagt)],_7720,_7722) --> 
    cc(kort,_7720,_7741),
    cc(sagt,_7741,_7722).

grums([grums,lit(men)],_7715,_7717) --> 
    cc(men,_7715,_7717).

grums([grums,lit(nei),lit(men)],_7720,_7722) --> 
    cc(nei,_7720,_7741),
    cc(men,_7741,_7722).

grums([grums,lit(nb)],_7715,_7717) --> 
    cc(nb,_7715,_7717).

grums([grums,lit(nei),_7748],_7726,_7728) --> 
    cc(nei,_7726,_7747),
    look_ahead(w(verb(_7705,_7706,_7707)),_7748,_7747,_7728).

grums([grums,lit(ja),_7748],_7726,_7728) --> 
    cc(ja,_7726,_7747),
    look_ahead(w(verb(_7705,_7706,_7707)),_7748,_7747,_7728).

grums([grums,lit(typisk)],_7715,_7717) --> 
    cc(typisk,_7715,_7717).

grums([grums,lit(uff)],_7715,_7717) --> 
    cc(uff,_7715,_7717).

grums([grums,lit(vel)],_7715,_7717) --> 
    cc(vel,_7715,_7717).

grums([grums,lit(å),_7740],_7718,_7720) --> 
    cc(å,_7718,_7739),
    not_look_ahead_vp(_7740,_7739,_7720).

grums([grums,_7732,_7761],_7721,_7723) --> 
    w(nb(1939,num),_7732,_7721,_7749),
    point0(_7761,_7749,_7723).

grums([grums,_7745,_7789,_7818],_7734,_7736) --> 
    optional([for],_7745,_7734,_7777),
    w(noun(example,sin,u,n),_7789,_7777,_7806),
    optional([:],_7818,_7806,_7736).

grums([grums,_7736,lit(:)],_7725,_7727) --> 
    w(noun(question,sin,u,n),_7736,_7725,_7753),
    cc(:,_7753,_7727).

grums([grums,lit(svar),_7744],_7722,_7724) --> 
    cc(svar,_7722,_7743),
    optional([:],_7744,_7743,_7724).

grums([grums,lit(n),lit(:)],_7720,_7722) --> 
    cc(n,_7720,_7741),
    cc(:,_7741,_7722).

grums([grums,_7737,_7766,!],_7726,_7728) --> 
    w(noun(traffic,sin,u,n),_7737,_7726,_7754),
    colon(_7766,_7754,_7728),
    !.

grums([grums,_7733,lit(tt)],_7722,_7724) --> 
    not_look_ahead([dere],_7733,_7722,_7750),
    cc(tt,_7750,_7724).

grums([grums,lit(så),_7748,!],_7726,_7728) --> 
    cc(så,_7726,_7747),
    w(adj2(funny,nil),_7748,_7747,_7728),
    !.

grums([grums,lit(så),_7740],_7718,_7720) --> 
    cc(så,_7718,_7739),
    not_look_ahead_vp(_7740,_7739,_7720).

grums([grums,lit(ja),lit(så),_7756],_7723,_7725) --> 
    cc(ja,_7723,_7744),
    cc(så,_7744,_7755),
    not_look_ahead_vp(_7756,_7755,_7725).

grums([grums,lit(nb),_7748],_7726,_7728) --> 
    cc(nb,_7726,_7747),
    one_of_lit(['.',:,!],_7748,_7747,_7728).

grums([grums,lit(obs),_7748],_7726,_7728) --> 
    cc(obs,_7726,_7747),
    one_of_lit(['.',:,!],_7748,_7747,_7728).

grums([grums,lit(unnskyld),lit(men)],_7720,_7722) --> 
    cc(unnskyld,_7720,_7741),
    cc(men,_7741,_7722).

grums([grums,lit(ok),_7748],_7726,_7728) --> 
    cc(ok,_7726,_7747),
    look_ahead(w(verb(_7705,imp,fin)),_7748,_7747,_7728).

grums([grums,lit(supert)],_7715,_7717) --> 
    cc(supert,_7715,_7717).

team([team,_7730],_7719,_7721) --> 
    w(name(team,_7701,_7702),_7730,_7719,_7721).

team([team,lit(team)],_7715,_7717) --> 
    cc(team,_7715,_7717).

hellos([hellos,_7730,_7754,_7778],_7719,_7721) --> 
    hello(_7730,_7719,_7745),
    sludder0(_7754,_7745,_7769),
    hellos0(_7778,_7769,_7721).

hellos0([hellos0,_7724],_7713,_7715) --> 
    hellos(_7724,_7713,_7715).

hellos0([hellos0,[]],_7713,_7713) --> 
    [].

adj0([adj0,_7735,!,_7769],_7724,_7726) --> 
    w(adj2(_7706,_7707),_7735,_7724,_7752),
    !,
    accept(_7769,_7752,_7726).

adj0([adj0,[]],_7713,_7713) --> 
    [].

hei([hei,lit(hei),_7740],_7718,_7720) --> 
    cc(hei,_7718,_7739),
    der0(_7740,_7739,_7720).

hei([hei,lit(hallo),_7740],_7718,_7720) --> 
    cc(hallo,_7718,_7739),
    der0(_7740,_7739,_7720).

sludder0([sludder0,_7727,!],_7716,_7718) --> 
    sludder(_7727,_7716,_7718),
    !.

sludder0([sludder0,[]],_7713,_7713) --> 
    [].

sludder([sludder,lit(alle),lit(sammen),!],_7723,_7725) --> 
    cc(alle,_7723,_7744),
    cc(sammen,_7744,_7725),
    !.

sludder([sludder,lit(der),!],_7718,_7720) --> 
    cc(der,_7718,_7720),
    !.

sludder([sludder,lit(du),_7751,!],_7729,_7731) --> 
    cc(du,_7729,_7750),
    not_look_ahead(w(verb(_7710,_7711,_7712)),_7751,_7750,_7731),
    !.

sludder([sludder,_7744,_7773,!],_7733,_7735) --> 
    w(name(tuc,n,_7708),_7744,_7733,_7761),
    not_look_ahead(w(verb(_7714,_7715,_7716)),_7773,_7761,_7735),
    !.

sludder([sludder,_7733,!],_7722,_7724) --> 
    w(name(bustuc,n,_7705),_7733,_7722,_7724),
    !.

sludder([sludder,_7733,!],_7722,_7724) --> 
    w(name(tt,n,_7705),_7733,_7722,_7724),
    !.

sludder([sludder,_7733,!],_7722,_7724) --> 
    w(name(tagore,n,_7705),_7733,_7722,_7724),
    !.

sludder([sludder,_7733,!],_7722,_7724) --> 
    w(name(tore,n,_7705),_7733,_7722,_7724),
    !.

sludder([sludder,_7734,!],_7723,_7725) --> 
    w(noun(computer,sin,u,n),_7734,_7723,_7725),
    !.

sludder([sludder,_7734,!],_7723,_7725) --> 
    w(noun(oracle,sin,_7705,n),_7734,_7723,_7725),
    !.

sludder([sludder,_7734,!],_7723,_7725) --> 
    w(noun(man,sin,u,n),_7734,_7723,_7725),
    !.

sludder([sludder,_7734,!],_7723,_7725) --> 
    w(noun(sweetheart,sin,u,n),_7734,_7723,_7725),
    !.

okeys0([okeys0,_7724],_7713,_7715) --> 
    okeys(_7724,_7713,_7715).

okeys0([okeys0,[]],_7713,_7713) --> 
    [].

okeys([okeys,lit(ok),_7754,_7798,_7842],_7732,_7734) --> 
    cc(ok,_7732,_7753),
    optional([ja],_7754,_7753,_7786),
    optional([men],_7798,_7786,_7830),
    optoken(_7842,_7830,_7734).

hello([hello,lit(bra)],_7715,_7717) --> 
    cc(bra,_7715,_7717).

hello([hello,_7724],_7713,_7715) --> 
    okeys(_7724,_7713,_7715).

hello([hello,_7732,_7756,_7800],_7721,_7723) --> 
    hei(_7732,_7721,_7747),
    optional(paadeg,_7756,_7747,_7788),
    sludder0(_7800,_7788,_7723).

hello([hello,lit(goddag)],_7715,_7717) --> 
    cc(goddag,_7715,_7717).

hello([hello,_7757,_7786,{}],_7746,_7748) --> 
    w(adj2(good,nil),_7757,_7746,_7774),
    w(noun(_7706,_7727,_7728,_7729),_7786,_7774,_7748),
    {user:testmember(_7706,[day,morning,evening,night,afternoon])}.

paadeg([paadeg,_7737,lit(deg),!,_7782],_7726,_7728) --> 
    prep1(on,_7737,_7726,_7754),
    cc(deg,_7754,_7776),
    !,
    accept(_7782,_7776,_7728).

paadeg([paadeg,lit(og),lit(hå),!,_7764],_7726,_7728) --> 
    cc(og,_7726,_7747),
    cc(hå,_7747,_7758),
    !,
    accept(_7764,_7758,_7728).

forhjelpen0([forhjelpen0,_7734,lit(alt),!],_7723,_7725) --> 
    prep1(for,_7734,_7723,_7751),
    cc(alt,_7751,_7725),
    !.

forhjelpen0([forhjelpen0,_7745,_7774,_7803,!],_7734,_7736) --> 
    prep1(for,_7745,_7734,_7762),
    w(noun(_7711,sin,def,n),_7774,_7762,_7791),
    np1(_7716,_7717,_7803,_7791,_7736),
    !.

forhjelpen0([forhjelpen0,_7739,_7768,!],_7728,_7730) --> 
    prep1(for,_7739,_7728,_7756),
    w(noun(_7708,sin,def,n),_7768,_7756,_7730),
    !.

forhjelpen0([forhjelpen0,_7735,_7764,!],_7724,_7726) --> 
    prep1(for,_7735,_7724,_7752),
    np1(_7706,_7707,_7764,_7752,_7726),
    !.

forhjelpen0([forhjelpen0,lit(skal),lit(du),_7762],_7729,_7731) --> 
    cc(skal,_7729,_7750),
    cc(du,_7750,_7761),
    w(verb(have,imp,fin),_7762,_7761,_7731).

forhjelpen0([forhjelpen0,[]],_7713,_7713) --> 
    [].

hadet([hadet,lit(ha),lit(de),_7756],_7723,_7725) --> 
    cc(ha,_7723,_7744),
    cc(de,_7744,_7755),
    paabadet0(_7756,_7755,_7725).

hadet([hadet,lit(ha),lit(det),_7756],_7723,_7725) --> 
    cc(ha,_7723,_7744),
    cc(det,_7744,_7755),
    paabadet0(_7756,_7755,_7725).

hadet([hadet,lit(hadet),_7740],_7718,_7720) --> 
    cc(hadet,_7718,_7739),
    paabadet0(_7740,_7739,_7720).

hadet([hadet,lit(hade),_7740],_7718,_7720) --> 
    cc(hade,_7718,_7739),
    paabadet0(_7740,_7739,_7720).

kan([kan,_7730],_7719,_7721) --> 
    w(verb(know,_7701,fin),_7730,_7719,_7721).

kan([kan,lit(kan)],_7715,_7717) --> 
    cc(kan,_7715,_7717).

paabadet0([paabadet0,_7737,lit(badet),!,_7782],_7726,_7728) --> 
    prep1(on,_7737,_7726,_7754),
    cc(badet,_7754,_7776),
    !,
    accept(_7782,_7776,_7728).

paabadet0([paabadet0,[]],_7713,_7713) --> 
    [].

quit(thanks,[quit,_7749,_7778,!],_7735,_7737) --> 
    w(adj2(good,nil),_7749,_7735,_7766),
    w(noun(trip,sin,u,n),_7778,_7766,_7737),
    !.

quit(bye,[quit,_7740,_7769],_7726,_7728) --> 
    w(verb(hear,pres,pass),_7740,_7726,_7757),
    skip_rest(_7769,_7757,_7728).

quit(bye,[quit,_7740,_7769],_7726,_7728) --> 
    w(verb(see,pres,pass),_7740,_7726,_7757),
    skip_rest(_7769,_7757,_7728).

quit(bye,[quit,_7740,_7769],_7726,_7728) --> 
    w(verb(tals,pres,pass),_7740,_7726,_7757),
    skip_rest(_7769,_7757,_7728).

quit(bye,[quit,lit(med),lit(vennlig),_7773,_7802],_7737,_7739) --> 
    cc(med,_7737,_7761),
    cc(vennlig,_7761,_7772),
    w(noun(greeting,_7716,_7717,_7718),_7773,_7772,_7790),
    skip_rest(_7802,_7790,_7739).

quit(bye,[quit,lit(vennlig),_7757,_7786],_7732,_7734) --> 
    cc(vennlig,_7732,_7756),
    w(noun(greeting,_7711,_7712,_7713),_7757,_7756,_7774),
    skip_rest(_7786,_7774,_7734).

quit(bye,[quit,_7741,_7770],_7727,_7729) --> 
    w(noun(greeting,_7706,_7707,_7708),_7741,_7727,_7758),
    skip_rest(_7770,_7758,_7729).

quit(bye,[quit,_7738],_7724,_7726) --> 
    w(noun(midnight,plu,def,n),_7738,_7724,_7726).

quit(bye,[quit,lit(jeg),lit(snakkes),_7763],_7727,_7729) --> 
    cc(jeg,_7727,_7751),
    cc(snakkes,_7751,_7762),
    skip_rest(_7763,_7762,_7729).

quit(bye,[quit,_7737],_7723,_7725) --> 
    w(verb(stop,imp,_7704),_7737,_7723,_7725).

quit(bye,[quit,lit(adjø)],_7719,_7721) --> 
    cc(adjø,_7719,_7721).

quit(bye,[quit,lit(på),lit(gjensyn)],_7724,_7726) --> 
    cc(på,_7724,_7748),
    cc(gjensyn,_7748,_7726).

quit(bye,[quit,_7731],_7717,_7719) --> 
    hadet(_7731,_7717,_7719).

quit(bye,[quit,_7734,_7758],_7720,_7722) --> 
    hadet(_7734,_7720,_7749),
    godt(_7758,_7749,_7722).

quit(bye,[quit,lit(hei),lit(da)],_7724,_7726) --> 
    cc(hei,_7724,_7748),
    cc(da,_7748,_7726).

quit(bye,[quit,lit(godnatt)],_7719,_7721) --> 
    cc(godnatt,_7719,_7721).

quit(bye,[quit,_7760,_7784,_7808,{}],_7746,_7748) --> 
    haen0(_7760,_7746,_7775),
    godt(_7784,_7775,_7799),
    w(noun(_7711,_7725,_7726,_7727),_7808,_7799,_7748),
    {user:testmember(_7711,[midnight,weekend,easter,summer])}.

quit(bye,[quit,lit(takk),_7764,_7793,_7822],_7739,_7741) --> 
    cc(takk,_7739,_7763),
    prep1(for,_7764,_7763,_7781),
    prep1(in,_7793,_7781,_7810),
    w(noun(day,sin,u,n),_7822,_7810,_7741).

quit(bye,[quit,_7750,_7774,_7803],_7736,_7738) --> 
    good0(_7750,_7736,_7765),
    w(noun(greeting,_7715,_7716,_7717),_7774,_7765,_7791),
    w(name(_7708,_7709,_7710),_7803,_7791,_7738).

quit(bye,[quit,_7751,_7775,_7804],_7737,_7739) --> 
    good0(_7751,_7737,_7766),
    w(noun(greeting,_7716,_7717,_7718),_7775,_7766,_7792),
    w(noun(_7708,_7709,_7710,_7711),_7804,_7792,_7739).

quit(bye,[quit,lit(far),lit(vel)],_7724,_7726) --> 
    cc(far,_7724,_7748),
    cc(vel,_7748,_7726).

quit(bye,[quit,_7760,_7804,lit(en),_7844,_7868],_7746,_7748) --> 
    optional(hello,_7760,_7746,_7792),
    w(verb(have,imp,_7725),_7804,_7792,_7821),
    cc(en,_7821,_7843),
    godt(_7844,_7843,_7859),
    w(noun(_7714,_7715,_7716,_7717),_7868,_7859,_7748).

quit(you_are_welcome,[quit,lit(på),lit(forhånd),_7766,!],_7730,_7732) --> 
    cc(på,_7730,_7754),
    cc(forhånd,_7754,_7765),
    thanks(_7766,_7765,_7732),
    !.

quit(you_are_welcome,[quit,_7742,_7771,!],_7728,_7730) --> 
    w(nb(1000,_7709),_7742,_7728,_7759),
    thanks(_7771,_7759,_7730),
    !.

quit(you_are_welcome,[quit,_7734,_7758],_7720,_7722) --> 
    thanks(_7734,_7720,_7749),
    alot(_7758,_7749,_7722).

quit(you_are_welcome,[quit,_7760,lit(å),_7800,_7829,lit(deg)],_7746,_7748) --> 
    w(adj2(nice,nil),_7760,_7746,_7777),
    cc(å,_7777,_7799),
    w(verb(speak,_7724,_7725),_7800,_7799,_7817),
    prep1(with,_7829,_7817,_7846),
    cc(deg,_7846,_7748).

quit(merry_christmas,[quit,_7736,lit(jul)],_7722,_7724) --> 
    godt(_7736,_7722,_7751),
    cc(jul,_7751,_7724).

quit(happy_new_year,[quit,_7734,_7758],_7720,_7722) --> 
    godt(_7734,_7720,_7749),
    newyear(_7758,_7749,_7722).

quit(bye,[quit,lit(hilsen),_7747],_7722,_7724) --> 
    cc(hilsen,_7722,_7746),
    skip_rest(_7747,_7746,_7724).

alot([alot,[]],_7713,_7713) --> 
    [].

alot([alot,lit(så),lit(mye)],_7720,_7722) --> 
    cc(så,_7720,_7741),
    cc(mye,_7741,_7722).

alot([alot,lit(så),lit(meget)],_7720,_7722) --> 
    cc(så,_7720,_7741),
    cc(meget,_7741,_7722).

alot([alot,lit(skal),lit(du),_7762],_7729,_7731) --> 
    cc(skal,_7729,_7750),
    cc(du,_7750,_7761),
    w(verb(have,inf,fin),_7762,_7761,_7731).

godt([godt,_7729],_7718,_7720) --> 
    w(adj2(good,nil),_7729,_7718,_7720).

godt([godt,_7730],_7719,_7721) --> 
    w(verb(go,past,part),_7730,_7719,_7721).

godt([godt,_7739,_7768],_7728,_7730) --> 
    w(adj2(good,nil),_7739,_7728,_7756),
    w(noun(day,sin,u,n),_7768,_7756,_7730).

deter0([deter0,_7730,!,_7759],_7719,_7721) --> 
    deter(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

deter0([deter0,_7730,!,_7759],_7719,_7721) --> 
    endofline(_7730,_7719,_7745),
    !,
    reject(_7759,_7745,_7721).

deter0([deter0,[]],_7713,_7713) --> 
    [].

deter([deter,lit(det),_7746,!,_7775],_7724,_7726) --> 
    cc(det,_7724,_7745),
    be(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

deter([deter,lit(dette),_7746,!,_7775],_7724,_7726) --> 
    cc(dette,_7724,_7745),
    be(_7746,_7745,_7761),
    !,
    accept(_7775,_7761,_7726).

haen0([haen0,lit(ha),lit(en),!,_7764],_7726,_7728) --> 
    cc(ha,_7726,_7747),
    cc(en,_7747,_7758),
    !,
    accept(_7764,_7758,_7728).

haen0([haen0,[]],_7713,_7713) --> 
    [].

personal('Takk',[personal,lit(velkommen),lit(til),!,_7771],_7730,_7732) --> 
    cc(velkommen,_7730,_7754),
    cc(til,_7754,_7765),
    !,
    skip_rest(_7771,_7765,_7732).

personal('Takk',[personal,lit(velkommen)],_7719,_7721) --> 
    cc(velkommen,_7719,_7721).

personal('Takk',[personal,lit(god),_7754],_7729,_7731) --> 
    cc(god,_7729,_7753),
    w(noun(health,sin,u,n),_7754,_7753,_7731).

personal('OK',[personal,lit(ps)],_7719,_7721) --> 
    cc(ps,_7719,_7721).

personal('OK',[personal,_7739,_7783,_7807],_7725,_7727) --> 
    optional(hello,_7739,_7725,_7771),
    so0(_7783,_7771,_7798),
    persok(_7807,_7798,_7727).

persok([persok,_7724],_7713,_7715) --> 
    okeys(_7724,_7713,_7715).

persok([persok,_7730],_7719,_7721) --> 
    w(verb(test,imp,fin),_7730,_7719,_7721).

persok([persok,lit(bra),_7740],_7718,_7720) --> 
    cc(bra,_7718,_7739),
    endofline(_7740,_7739,_7720).

persok([persok,lit(sorry)],_7715,_7717) --> 
    cc(sorry,_7715,_7717).

persok([persok,_7743,lit(så),_7783],_7732,_7734) --> 
    w(verb(be,imp,fin),_7743,_7732,_7760),
    cc(så,_7760,_7782),
    w(adj2(good,nil),_7783,_7782,_7734).

persok([persok,_7735,lit(det)],_7724,_7726) --> 
    w(verb(forget,imp,fin),_7735,_7724,_7752),
    cc(det,_7752,_7726).

persok([persok,_7739,_7768],_7728,_7730) --> 
    w(verb(forget,imp,fin),_7739,_7728,_7756),
    np(_7701,_7704:_7705,_7768,_7756,_7730).

persok([persok,_7741,lit(du),_7781,_7805],_7730,_7732) --> 
    w(verb(be,_7710,fin),_7741,_7730,_7758),
    cc(du,_7758,_7780),
    good(_7781,_7780,_7796),
    dadanow0(_7805,_7796,_7732).

persok([persok,lit(unnskyld)],_7715,_7717) --> 
    cc(unnskyld,_7715,_7717).

persok([persok,lit(hvordan),_7759,lit(du),lit(det),_7810],_7737,_7739) --> 
    cc(hvordan,_7737,_7758),
    w(verb(have,_7715,fin),_7759,_7758,_7776),
    cc(du,_7776,_7798),
    cc(det,_7798,_7809),
    dadanow0(_7810,_7809,_7739).

persok([persok,lit(hvordan),_7762,lit(det),_7802,_7831,_7855],_7740,_7742) --> 
    cc(hvordan,_7740,_7761),
    w(verb(stand,pres,fin),_7762,_7761,_7779),
    cc(det,_7779,_7801),
    prep1(to,_7802,_7801,_7819),
    withyou0(_7831,_7819,_7846),
    dadanow0(_7855,_7846,_7742).

persok([persok,_7754,lit(det),_7794,_7823,_7852,_7876],_7743,_7745) --> 
    w(verb(stand,pres,fin),_7754,_7743,_7771),
    cc(det,_7771,_7793),
    w(adj2(good,nil),_7794,_7793,_7811),
    prep1(to,_7823,_7811,_7840),
    withyou0(_7852,_7840,_7867),
    dadanow0(_7876,_7867,_7745).

persok([persok,_7735,_7764],_7724,_7726) --> 
    w(verb(stand,pres,fin),_7735,_7724,_7752),
    prep1(to,_7764,_7752,_7726).

persok([persok,lit(hvordan),_7750,_7774],_7728,_7730) --> 
    cc(hvordan,_7728,_7749),
    be(_7750,_7749,_7765),
    w(noun(situation,sin,def,n),_7774,_7765,_7730).

persok([persok,lit(hva),_7750,_7774],_7728,_7730) --> 
    cc(hva,_7728,_7749),
    be(_7750,_7749,_7765),
    w(noun(situation,sin,def,n),_7774,_7765,_7730).

persok([persok,_7751,lit(du),lit(det),_7802,_7831],_7740,_7742) --> 
    w(verb(have,_7713,fin),_7751,_7740,_7768),
    cc(du,_7768,_7790),
    cc(det,_7790,_7801),
    w(adj2(_7722,nil),_7802,_7801,_7819),
    dadanow0(_7831,_7819,_7742).

persok([persok,lit(jeg),_7765,lit(det),_7805,_7834,_7858,_7882],_7743,_7745) --> 
    cc(jeg,_7743,_7764),
    w(verb(have,_7721,fin),_7765,_7764,_7782),
    cc(det,_7782,_7804),
    negation0(_7726,_7805,_7804,_7822),
    so0(_7834,_7822,_7849),
    good(_7858,_7849,_7873),
    dadanow0(_7882,_7873,_7745).

persok([persok,lit(hvordan),_7757,lit(det),_7797,_7821],_7735,_7737) --> 
    cc(hvordan,_7735,_7756),
    w(verb(go,pres,fin),_7757,_7756,_7774),
    cc(det,_7774,_7796),
    withyou0(_7797,_7796,_7812),
    dadanow0(_7821,_7812,_7737).

persok([persok,_7756,lit(det),_7796,_7840,_7869,_7893],_7745,_7747) --> 
    w(verb(go,pres,fin),_7756,_7745,_7773),
    cc(det,_7773,_7795),
    optional([ikke],_7796,_7795,_7828),
    w(adj2(good,nil),_7840,_7828,_7857),
    withyou0(_7869,_7857,_7884),
    dadanow0(_7893,_7884,_7747).

persok([persok,lit(greitt)],_7715,_7717) --> 
    cc(greitt,_7715,_7717).

persok([persok,_7732,_7761],_7721,_7723) --> 
    w(adj2(good,nil),_7732,_7721,_7749),
    endofline(_7761,_7749,_7723).

thanks([thanks,_7733,_7757,_7781,_7805],_7722,_7724) --> 
    ogmen0(_7733,_7722,_7748),
    thousands0(_7757,_7748,_7772),
    takk(_7781,_7772,_7796),
    forhjelpen0(_7805,_7796,_7724).

takk([takk,_7729,lit(takk)],_7718,_7720) --> 
    hellos0(_7729,_7718,_7744),
    cc(takk,_7744,_7720).

takk([takk,_7730],_7719,_7721) --> 
    w(verb(thank,pres,fin),_7730,_7719,_7721).

takk([takk,lit(jeg),lit(vil),_7762],_7729,_7731) --> 
    cc(jeg,_7729,_7750),
    cc(vil,_7750,_7761),
    w(verb(thank,inf,_7708),_7762,_7761,_7731).

ogmen0([ogmen0,lit(og),!,_7748],_7721,_7723) --> 
    cc(og,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

ogmen0([ogmen0,lit(men),!,_7748],_7721,_7723) --> 
    cc(men,_7721,_7742),
    !,
    accept(_7748,_7742,_7723).

ogmen0([ogmen0,[]],_7713,_7713) --> 
    [].

thousands0([thousands0,_7730,!,_7759],_7719,_7721) --> 
    thousand(_7730,_7719,_7745),
    !,
    thousands0(_7759,_7745,_7721).

thousands0([thousands0,[]],_7713,_7713) --> 
    [].

thousand0([thousand0,_7730,!,_7759],_7719,_7721) --> 
    thousand(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

thousand0([thousand0,[]],_7713,_7713) --> 
    [].

thousand([thousand,_7735,!,_7769],_7724,_7726) --> 
    number(1000:_7707,_7735,_7724,_7752),
    !,
    accept(_7769,_7752,_7726).

thousand([thousand,_7724],_7713,_7715) --> 
    many1(_7724,_7713,_7715).

withyou0([withyou0,_7737,lit(_7708),!,_7782],_7726,_7728) --> 
    prep1(with,_7737,_7726,_7754),
    cc(_7708,_7754,_7776),
    !,
    accept(_7782,_7776,_7728).

withyou0([withyou0,[]],_7713,_7713) --> 
    [].

dadanow0([dadanow0,_7727,_7751],_7716,_7718) --> 
    todax(_7727,_7716,_7742),
    danow0(_7751,_7742,_7718).

dadanow0([dadanow0,_7724],_7713,_7715) --> 
    danow0(_7724,_7713,_7715).

danow0([danow0,_7739,_7768,lit(nå),!],_7728,_7730) --> 
    look_ahead([nå],_7739,_7728,_7756),
    notreachphrase(_7768,_7756,_7783),
    cc(nå,_7783,_7730),
    !.

danow0([danow0,[]],_7713,_7713) --> 
    [].

notreachphrase([notreachphrase,_7730,!,_7759],_7719,_7721) --> 
    reachphrase(_7730,_7719,_7745),
    !,
    reject(_7759,_7745,_7721).

notreachphrase([notreachphrase,[]],_7713,_7713) --> 
    [].

reachphrase([reachphrase,_7736,_7765,!],_7725,_7727) --> 
    w(verb(reach,inf,fin),_7736,_7725,_7753),
    look_ahead_np(_7765,_7753,_7727),
    !.

danow0([danow0,_7727,!],_7716,_7718) --> 
    danow(_7727,_7716,_7718),
    !.

danow0([danow0,[]],_7713,_7713) --> 
    [].

danow([danow,_7734,_7763,!],_7723,_7725) --> 
    w(adv(now),_7734,_7723,_7751),
    danow(_7763,_7751,_7725),
    !.

danow([danow,_7728],_7717,_7719) --> 
    w(adv(now),_7728,_7717,_7719).

danow([danow,lit(da),_7740],_7718,_7720) --> 
    cc(da,_7718,_7739),
    danow(_7740,_7739,_7720).

todax([todax,_7730,!,_7759],_7719,_7721) --> 
    today(_7730,_7719,_7745),
    !,
    accept(_7759,_7745,_7721).

todax([todax,_7737,lit(går),!,_7782],_7726,_7728) --> 
    prep1(in,_7737,_7726,_7754),
    cc(går,_7754,_7776),
    !,
    accept(_7782,_7776,_7728).

good0([good0,_7733,_7757,!,_7786],_7722,_7724) --> 
    so0(_7733,_7722,_7748),
    good(_7757,_7748,_7772),
    !,
    accept(_7786,_7772,_7724).

good0([good0,[]],_7713,_7713) --> 
    [].

good([good,_7729],_7718,_7720) --> 
    w(adj2(good,nil),_7729,_7718,_7720).

good([good,_7729],_7718,_7720) --> 
    w(adj2(clever,nil),_7729,_7718,_7720).

good([good,_7729],_7718,_7720) --> 
    w(adj2(fast,nil),_7729,_7718,_7720).

good([good,_7729],_7718,_7720) --> 
    w(adj2(funny,nil),_7729,_7718,_7720).

good([good,_7729],_7718,_7720) --> 
    w(adj2(honest,nil),_7729,_7718,_7720).

good([good,_7729],_7718,_7720) --> 
    w(adj2(nice,nil),_7729,_7718,_7720).

good([good,_7724],_7713,_7715) --> 
    okeys(_7724,_7713,_7715).

gmem(_7698,_7699,[gmem,{}],_7725,_7725) --> 
    {user:testmember(_7698,_7699)}.

panic(_7698,[panic,{}],_7721,_7721) --> 
    {user:write(_7698)}.

traceprint(_7698,_7699,[traceprint,{}],_7725,_7725) --> 
    {user:traceprint(_7698,_7699)}.

% Auxillary tables created datetime(2012,3,16,21,25,44)

%% Automatically created by metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

optional(itrailer,[optional,_7949,!],_7935,_7937) --> 
    itrailer(_7949,_7935,_7937),
    !.

optional([kanskje],[optional,lit(kanskje),!],_7937,_7939) --> 
    cc(kanskje,_7937,_7939),
    !.

optional([at],[optional,lit(at),!],_7937,_7939) --> 
    cc(at,_7937,_7939),
    !.

optional(grums,[optional,_7949,!],_7935,_7937) --> 
    grums(_7949,_7935,_7937),
    !.

optional(grums,[optional,_7949,!],_7935,_7937) --> 
    grums(_7949,_7935,_7937),
    !.

optional([ofte],[optional,lit(ofte),!],_7937,_7939) --> 
    cc(ofte,_7937,_7939),
    !.

optional([som],[optional,lit(som),!],_7937,_7939) --> 
    cc(som,_7937,_7939),
    !.

optional([','],[optional,lit(','),!],_7937,_7939) --> 
    cc(',',_7937,_7939),
    !.

optional([at],[optional,lit(at),!],_7937,_7939) --> 
    cc(at,_7937,_7939),
    !.

optional([meget],[optional,lit(meget),!],_7937,_7939) --> 
    cc(meget,_7937,_7939),
    !.

optional([det],[optional,lit(det),!],_7937,_7939) --> 
    cc(det,_7937,_7939),
    !.

optional([å],[optional,lit(å),!],_7937,_7939) --> 
    cc(å,_7937,_7939),
    !.

optional([å],[optional,lit(å),!],_7937,_7939) --> 
    cc(å,_7937,_7939),
    !.

optional([an],[optional,lit(an),!],_7937,_7939) --> 
    cc(an,_7937,_7939),
    !.

optional([ut],[optional,lit(ut),!],_7937,_7939) --> 
    cc(ut,_7937,_7939),
    !.

optional([neste],[optional,lit(neste),!],_7937,_7939) --> 
    cc(neste,_7937,_7939),
    !.

optional([det],[optional,lit(det),!],_7937,_7939) --> 
    cc(det,_7937,_7939),
    !.

optional(itrailer,[optional,_7949,!],_7935,_7937) --> 
    itrailer(_7949,_7935,_7937),
    !.

optional(itrailer,[optional,_7949,!],_7935,_7937) --> 
    itrailer(_7949,_7935,_7937),
    !.

optional([alle],[optional,lit(alle),!],_7937,_7939) --> 
    cc(alle,_7937,_7939),
    !.

optional([at],[optional,lit(at),!],_7937,_7939) --> 
    cc(at,_7937,_7939),
    !.

optional([som],[optional,lit(som),!],_7937,_7939) --> 
    cc(som,_7937,_7939),
    !.

optional([gang],[optional,lit(gang),!],_7937,_7939) --> 
    cc(gang,_7937,_7939),
    !.

optional(much,[optional,_7949,!],_7935,_7937) --> 
    much(_7949,_7935,_7937),
    !.

optional(w(verb(be,inf,fin)),[optional,_7955,!],_7941,_7943) --> 
    w(verb(be,inf,fin),_7955,_7941,_7943),
    !.

optional(w(adj2(old,nil)),[optional,_7954,!],_7940,_7942) --> 
    w(adj2(old,nil),_7954,_7940,_7942),
    !.

optional([om],[optional,lit(om),!],_7937,_7939) --> 
    cc(om,_7937,_7939),
    !.

optional([for],[optional,lit(for),!],_7937,_7939) --> 
    cc(for,_7937,_7939),
    !.

optional([på],[optional,lit(på),!],_7937,_7939) --> 
    cc(på,_7937,_7939),
    !.

optional([om],[optional,lit(om),!],_7937,_7939) --> 
    cc(om,_7937,_7939),
    !.

optional([på],[optional,lit(på),!],_7937,_7939) --> 
    cc(på,_7937,_7939),
    !.

optional([om],[optional,lit(om),!],_7937,_7939) --> 
    cc(om,_7937,_7939),
    !.

optional([å],[optional,lit(å),!],_7937,_7939) --> 
    cc(å,_7937,_7939),
    !.

optional([på],[optional,lit(på),!],_7937,_7939) --> 
    cc(på,_7937,_7939),
    !.

optional([på],[optional,lit(på),!],_7937,_7939) --> 
    cc(på,_7937,_7939),
    !.

optional([å],[optional,lit(å),!],_7937,_7939) --> 
    cc(å,_7937,_7939),
    !.

optional([til],[optional,lit(til),!],_7937,_7939) --> 
    cc(til,_7937,_7939),
    !.

optional([da],[optional,lit(da),!],_7937,_7939) --> 
    cc(da,_7937,_7939),
    !.

optional([bare],[optional,lit(bare),!],_7937,_7939) --> 
    cc(bare,_7937,_7939),
    !.

optional(w(prep(_7918)),[optional,_7953,!],_7939,_7941) --> 
    w(prep(_7918),_7953,_7939,_7941),
    !.

optional([til],[optional,lit(til),!],_7937,_7939) --> 
    cc(til,_7937,_7939),
    !.

optional([med],[optional,lit(med),!],_7937,_7939) --> 
    cc(med,_7937,_7939),
    !.

optional([på],[optional,lit(på),!],_7937,_7939) --> 
    cc(på,_7937,_7939),
    !.

optional(w(noun(year,_7919,_7920,n)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(year,_7919,_7920,n),_7956,_7942,_7944),
    !.

optional(w(prep(in)),[optional,_7953,!],_7939,_7941) --> 
    w(prep(in),_7953,_7939,_7941),
    !.

optional(w(noun(year,sin,u,n)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(year,sin,u,n),_7956,_7942,_7944),
    !.

optional([i],[optional,lit(i),!],_7937,_7939) --> 
    cc(i,_7937,_7939),
    !.

optional([i],[optional,lit(i),!],_7937,_7939) --> 
    cc(i,_7937,_7939),
    !.

optional([i],[optional,lit(i),!],_7937,_7939) --> 
    cc(i,_7937,_7939),
    !.

optional(['.'],[optional,lit('.'),!],_7937,_7939) --> 
    cc('.',_7937,_7939),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(time,sin,def,n),_7956,_7942,_7944),
    !.

optional([nå],[optional,lit(nå),!],_7937,_7939) --> 
    cc(nå,_7937,_7939),
    !.

optional([denne],[optional,lit(denne),!],_7937,_7939) --> 
    cc(denne,_7937,_7939),
    !.

optional(w(noun(route,sin,u,n)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(route,sin,u,n),_7956,_7942,_7944),
    !.

optional(w(noun(route,sin,u,n)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(route,sin,u,n),_7956,_7942,_7944),
    !.

optional(w(noun(bus,sin,_7920,_7921)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(bus,sin,_7920,_7921),_7956,_7942,_7944),
    !.

optional([for],[optional,lit(for),!],_7937,_7939) --> 
    cc(for,_7937,_7939),
    !.

optional([til],[optional,lit(til),!],_7937,_7939) --> 
    cc(til,_7937,_7939),
    !.

optional([av],[optional,lit(av),!],_7937,_7939) --> 
    cc(av,_7937,_7939),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(time,sin,def,n),_7956,_7942,_7944),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(time,sin,def,n),_7956,_7942,_7944),
    !.

optional(w(noun(time,_7919,def,_7921)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(time,_7919,def,_7921),_7956,_7942,_7944),
    !.

optional(w(prep(in)),[optional,_7953,!],_7939,_7941) --> 
    w(prep(in),_7953,_7939,_7941),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7956,!],_7942,_7944) --> 
    w(noun(time,sin,def,n),_7956,_7942,_7944),
    !.

optional([h],[optional,lit(h),!],_7937,_7939) --> 
    cc(h,_7937,_7939),
    !.

optional([opp],[optional,lit(opp),!],_7937,_7939) --> 
    cc(opp,_7937,_7939),
    !.

optional([om],[optional,lit(om),!],_7937,_7939) --> 
    cc(om,_7937,_7939),
    !.

optional([mye],[optional,lit(mye),!],_7937,_7939) --> 
    cc(mye,_7937,_7939),
    !.

optional([nr],[optional,lit(nr),!],_7937,_7939) --> 
    cc(nr,_7937,_7939),
    !.

optional([slik],[optional,lit(slik),!],_7937,_7939) --> 
    cc(slik,_7937,_7939),
    !.

optional([så],[optional,lit(så),!],_7937,_7939) --> 
    cc(så,_7937,_7939),
    !.

optional(be,[optional,_7949,!],_7935,_7937) --> 
    be(_7949,_7935,_7937),
    !.

optional([at],[optional,lit(at),!],_7937,_7939) --> 
    cc(at,_7937,_7939),
    !.

optional([at],[optional,lit(at),!],_7937,_7939) --> 
    cc(at,_7937,_7939),
    !.

optional([seg],[optional,lit(seg),!],_7937,_7939) --> 
    cc(seg,_7937,_7939),
    !.

optional([at],[optional,lit(at),!],_7937,_7939) --> 
    cc(at,_7937,_7939),
    !.

optional(w(adj2(great,nil)),[optional,_7954,!],_7940,_7942) --> 
    w(adj2(great,nil),_7954,_7940,_7942),
    !.

optional(w(adj2(_7918,nil)),[optional,_7954,!],_7940,_7942) --> 
    w(adj2(_7918,nil),_7954,_7940,_7942),
    !.

optional(w(adj2(_7918,nil)),[optional,_7954,!],_7940,_7942) --> 
    w(adj2(_7918,nil),_7954,_7940,_7942),
    !.

optional(w(adj2(_7918,nil)),[optional,_7954,!],_7940,_7942) --> 
    w(adj2(_7918,nil),_7954,_7940,_7942),
    !.

optional([med],[optional,lit(med),!],_7937,_7939) --> 
    cc(med,_7937,_7939),
    !.

optional(sometimes,[optional,_7949,!],_7935,_7937) --> 
    sometimes(_7949,_7935,_7937),
    !.

optional([ofte],[optional,lit(ofte),!],_7937,_7939) --> 
    cc(ofte,_7937,_7939),
    !.

optional([bare],[optional,lit(bare),!],_7937,_7939) --> 
    cc(bare,_7937,_7939),
    !.

optional(grums,[optional,_7949,!],_7935,_7937) --> 
    grums(_7949,_7935,_7937),
    !.

optional(grums,[optional,_7949,!],_7935,_7937) --> 
    grums(_7949,_7935,_7937),
    !.

optional([for],[optional,lit(for),!],_7937,_7939) --> 
    cc(for,_7937,_7939),
    !.

optional([:],[optional,lit(:),!],_7937,_7939) --> 
    cc(:,_7937,_7939),
    !.

optional([:],[optional,lit(:),!],_7937,_7939) --> 
    cc(:,_7937,_7939),
    !.

optional([ja],[optional,lit(ja),!],_7937,_7939) --> 
    cc(ja,_7937,_7939),
    !.

optional([men],[optional,lit(men),!],_7937,_7939) --> 
    cc(men,_7937,_7939),
    !.

optional(paadeg,[optional,_7949,!],_7935,_7937) --> 
    paadeg(_7949,_7935,_7937),
    !.

optional(hello,[optional,_7949,!],_7935,_7937) --> 
    hello(_7949,_7935,_7937),
    !.

optional(hello,[optional,_7949,!],_7935,_7937) --> 
    hello(_7949,_7935,_7937),
    !.

optional([ikke],[optional,lit(ikke),!],_7937,_7939) --> 
    cc(ikke,_7937,_7939),
    !.

optional(_7909,[],_7689,_7689) --> 
    [].

xnp(_8071,_8072,[xnp,_8114],_8097,_8099) --> 
    virtual(xnp(_8071,_8072),_8114,_8097,_8099).

negation(_8071,[negation,_8108],_8094,_8096) --> 
    virtual(negation(_8071),_8108,_8094,_8096).

aux1([aux1,_8101],_8090,_8092) --> 
    virtual(aux1,_8101,_8090,_8092).

adverbial1(_8071,_8072,_8073,[adverbial1,_8120],_8100,_8102) --> 
    virtual(adverbial1(_8071,_8072,_8073),_8120,_8100,_8102).

xadverbial1(_8071,_8072,_8073,[xadverbial1,_8120],_8100,_8102) --> 
    virtual(xadverbial1(_8071,_8072,_8073),_8120,_8100,_8102).

subordinate(in_order_to,_8072,_8073,[subordinate,_8120],_8100,_8102) --> 
    virtual(subordinate(in_order_to,_8072,_8073),_8120,_8100,_8102).

subordinate(_8071,_8072,_8073,[subordinate,_8120],_8100,_8102) --> 
    virtual(subordinate(_8071,_8072,_8073),_8120,_8100,_8102).

adj1(_8071,_8076:_8077,_8073,_8074,[adj1,_8129],_8106,_8108) --> 
    virtual(adj1(_8071,_8076:_8077,_8073,_8074),_8129,_8106,_8108).

someone([someone,_8101],_8090,_8092) --> 
    virtual(someone,_8101,_8090,_8092).

obviousdate1(_8071,_8072,[obviousdate1,_8114],_8097,_8099) --> 
    virtual(obviousdate1(_8071,_8072),_8114,_8097,_8099).

np_kernel(0,_8072,_8073,[np_kernel,_8120],_8100,_8102) --> 
    virtual(np_kernel(0,_8072,_8073),_8120,_8100,_8102).

xnp(_8071,_8074::_8075,[xnp,_8117],_8100,_8102) --> 
    virtual(xnp(_8071,_8074::_8075),_8117,_8100,_8102).

pp(_8071,_8072,_8073,[pp,_8120],_8100,_8102) --> 
    virtual(pp(_8071,_8072,_8073),_8120,_8100,_8102).

np(_8071,_8072,[np,_8114],_8097,_8099) --> 
    virtual(np(_8071,_8072),_8114,_8097,_8099).

prep(to,[prep,_8108],_8094,_8096) --> 
    virtual(prep(to),_8108,_8094,_8096).

prep(_8071,[prep,_8108],_8094,_8096) --> 
    virtual(prep(_8071),_8108,_8094,_8096).

noun_phrase1(_8071,_8072,[noun_phrase1,_8114],_8097,_8099) --> 
    virtual(noun_phrase1(_8071,_8072),_8114,_8097,_8099).

xadverb(_8071,_8072,[xadverb,_8114],_8097,_8099) --> 
    virtual(xadverb(_8071,_8072),_8114,_8097,_8099).

np(_8071,_8074::_8075,[np,_8117],_8100,_8102) --> 
    virtual(np(_8071,_8074::_8075),_8117,_8100,_8102).

be(_8071,[be,_8108],_8094,_8096) --> 
    virtual(be(_8071),_8108,_8094,_8096).

thereit([thereit,_8101],_8090,_8092) --> 
    virtual(thereit,_8101,_8090,_8092).

be([be,_8101],_8090,_8092) --> 
    virtual(be,_8101,_8090,_8092).

adverbial1(_8071,_8072,_8075::_8076,[adverbial1,_8123],_8103,_8105) --> 
    virtual(adverbial1(_8071,_8072,_8075::_8076),_8123,_8103,_8105).

lexv(_8071,_8072,_8073,fin,[lexv,_8126],_8103,_8105) --> 
    virtual(lexv(_8071,_8072,_8073,fin),_8126,_8103,_8105).

ap(_8071,_8072,_8073,_8074,[ap,_8126],_8103,_8105) --> 
    virtual(ap(_8071,_8072,_8073,_8074),_8126,_8103,_8105).

adj1(_8071,_8072,_8073,_8074,[adj1,_8126],_8103,_8105) --> 
    virtual(adj1(_8071,_8072,_8073,_8074),_8126,_8103,_8105).

\(state(_8074,_8075),(xnp(_8080,_8081),w(verb(be,_8089,fin)),w(adj2(_8094,nil))),[\,_8137],_8120,_8122) --> 
    virtual(state(_8074,_8075)\(xnp(_8080,_8081),w(verb(be,_8089,fin)),w(adj2(_8094,nil))),_8137,_8120,_8122).

something([something,_8101],_8090,_8092) --> 
    virtual(something,_8101,_8090,_8092).

lexv(iv,_8072,pres,fin,[lexv,_8126],_8103,_8105) --> 
    virtual(lexv(iv,_8072,pres,fin),_8126,_8103,_8105).

np1(_8071,_8072,[np1,_8114],_8097,_8099) --> 
    virtual(np1(_8071,_8072),_8114,_8097,_8099).

adverbial(_8071,_8072,_8075::_8076,[adverbial,_8123],_8103,_8105) --> 
    virtual(adverbial(_8071,_8072,_8075::_8076),_8123,_8103,_8105).

lexv(iv,_8072,_8073,fin,[lexv,_8126],_8103,_8105) --> 
    virtual(lexv(iv,_8072,_8073,fin),_8126,_8103,_8105).

the([the,_8101],_8090,_8092) --> 
    virtual(the,_8101,_8090,_8092).

nameq1(_8074:person,_8072,[nameq1,_8117],_8100,_8102) --> 
    virtual(nameq1(_8074:person,_8072),_8117,_8100,_8102).

obviousclock1(_8074:clock,_8074 isa clock,[obviousclock1,_8120],_8103,_8105) --> 
    virtual(obviousclock1(_8074:clock,_8074 isa clock),_8120,_8103,_8105).

whatbe([whatbe,_8101],_8090,_8092) --> 
    virtual(whatbe,_8101,_8090,_8092).

obviousclock1(_8071,_8072,[obviousclock1,_8114],_8097,_8099) --> 
    virtual(obviousclock1(_8071,_8072),_8114,_8097,_8099).

pronoun(_8071,[pronoun,_8108],_8094,_8096) --> 
    virtual(pronoun(_8071),_8108,_8094,_8096).

noun_phrase1(_8071,_8074::_8075,[noun_phrase1,_8117],_8100,_8102) --> 
    virtual(noun_phrase1(_8071,_8074::_8075),_8117,_8100,_8102).

npgap(_8071,[npgap,_8108],_8094,_8096) --> 
    virtual(npgap(_8071),_8108,_8094,_8096).

npgap(_8073:thing,[npgap,_8111],_8097,_8099) --> 
    virtual(npgap(_8073:thing),_8111,_8097,_8099).

noun(_8071,_8072,_8073,_8074,_8075,_8076,[noun,_8138],_8109,_8111) --> 
    virtual(noun(_8071,_8072,_8073,_8074,_8075,_8076),_8138,_8109,_8111).

lexv(tv,_8072,_8073,fin,[lexv,_8126],_8103,_8105) --> 
    virtual(lexv(tv,_8072,_8073,fin),_8126,_8103,_8105).

which([which,_8101],_8090,_8092) --> 
    virtual(which,_8101,_8090,_8092).

np1(_8071,_8074::_8075,[np1,_8117],_8100,_8102) --> 
    virtual(np1(_8071,_8074::_8075),_8117,_8100,_8102).

lexv(tv,know1,_8073,fin,[lexv,_8126],_8103,_8105) --> 
    virtual(lexv(tv,know1,_8073,fin),_8126,_8103,_8105).

do([do,_8101],_8090,_8092) --> 
    virtual(do,_8101,_8090,_8092).

xadverbial1(_8071,_8072,_8075::_8076,[xadverbial1,_8123],_8103,_8105) --> 
    virtual(xadverbial1(_8071,_8072,_8075::_8076),_8123,_8103,_8105).

prep(in,[prep,_8108],_8094,_8096) --> 
    virtual(prep(in),_8108,_8094,_8096).

adverbial1(in,_8072,_8075::_8076,[adverbial1,_8123],_8103,_8105) --> 
    virtual(adverbial1(in,_8072,_8075::_8076),_8123,_8103,_8105).

xadverbial1(in,_8072,_8075::_8076,[xadverbial1,_8123],_8103,_8105) --> 
    virtual(xadverbial1(in,_8072,_8075::_8076),_8123,_8103,_8105).

adverbial1(nil,_8072,_8075::_8076,[adverbial1,_8123],_8103,_8105) --> 
    virtual(adverbial1(nil,_8072,_8075::_8076),_8123,_8103,_8105).

prep(from,[prep,_8108],_8094,_8096) --> 
    virtual(prep(from),_8108,_8094,_8096).

who([who,_8101],_8090,_8092) --> 
    virtual(who,_8101,_8090,_8092).

a([a,_8101],_8090,_8092) --> 
    virtual(a,_8101,_8090,_8092).

noun(_8071,_8072,u,n,_8075,_8076,[noun,_8138],_8109,_8111) --> 
    virtual(noun(_8071,_8072,u,n,_8075,_8076),_8138,_8109,_8111).

that([that,_8101],_8090,_8092) --> 
    virtual(that,_8101,_8090,_8092).

xadverbial1(how,nil,_8075::_8075,[xadverbial1,_8123],_8103,_8105) --> 
    virtual(xadverbial1(how,nil,_8075::_8075),_8123,_8103,_8105).

prep(with,[prep,_8108],_8094,_8096) --> 
    virtual(prep(with),_8108,_8094,_8096).

xadverbial1(nil,_8072,_8073,[xadverbial1,_8120],_8100,_8102) --> 
    virtual(xadverbial1(nil,_8072,_8073),_8120,_8100,_8102).

the(_8071,[the,_8108],_8094,_8096) --> 
    virtual(the(_8071),_8108,_8094,_8096).

of([of,_8101],_8090,_8092) --> 
    virtual(of,_8101,_8090,_8092).

prep1(in,[prep1,_8108],_8094,_8096) --> 
    virtual(prep1(in),_8108,_8094,_8096).

number(_8071,[number,_8108],_8094,_8096) --> 
    virtual(number(_8071),_8108,_8094,_8096).

lexv(dtv,_8072,_8073,_8074,[lexv,_8126],_8103,_8105) --> 
    virtual(lexv(dtv,_8072,_8073,_8074),_8126,_8103,_8105).

negation0(_8071,[negation0,_8108],_8094,_8096) --> 
    virtual(negation0(_8071),_8108,_8094,_8096).

adverbx(_8071,_8072,_8073,[adverbx,_8120],_8100,_8102) --> 
    virtual(adverbx(_8071,_8072,_8073),_8120,_8100,_8102).

particle(_8071,[particle,_8108],_8094,_8096) --> 
    virtual(particle(_8071),_8108,_8094,_8096).

verb_mod1(_8071,_8072,_8073,_8074,_8077::_8078,[verb_mod1,_8135],_8109,_8111) --> 
    virtual(verb_mod1(_8071,_8072,_8073,_8074,_8077::_8078),_8135,_8109,_8111).

lexv(tv,_8072,pres,fin,[lexv,_8126],_8103,_8105) --> 
    virtual(lexv(tv,_8072,pres,fin),_8126,_8103,_8105).

prep1(_8071,[prep1,_8108],_8094,_8096) --> 
    virtual(prep1(_8071),_8108,_8094,_8096).

noun_phrase1(_8071,_8074:_8075,[noun_phrase1,_8117],_8100,_8102) --> 
    virtual(noun_phrase1(_8071,_8074:_8075),_8117,_8100,_8102).

lexv(_8071,know1,_8073,fin,[lexv,_8126],_8103,_8105) --> 
    virtual(lexv(_8071,know1,_8073,fin),_8126,_8103,_8105).

lexv(tv,_8072,past,fin,[lexv,_8126],_8103,_8105) --> 
    virtual(lexv(tv,_8072,past,fin),_8126,_8103,_8105).

this([this,_8101],_8090,_8092) --> 
    virtual(this,_8101,_8090,_8092).

adverbial1(_8071,_8075:_8076,_8073,[adverbial1,_8123],_8103,_8105) --> 
    virtual(adverbial1(_8071,_8075:_8076,_8073),_8123,_8103,_8105).

adverbial1(nil,_8075:coevent,_8073,[adverbial1,_8123],_8103,_8105) --> 
    virtual(adverbial1(nil,_8075:coevent,_8073),_8123,_8103,_8105).

xadverbial1(_8071,_8075:_8076,_8073,[xadverbial1,_8123],_8103,_8105) --> 
    virtual(xadverbial1(_8071,_8075:_8076,_8073),_8123,_8103,_8105).

adverb(_8071,_8072,_8073,[adverb,_8120],_8100,_8102) --> 
    virtual(adverb(_8071,_8072,_8073),_8120,_8100,_8102).

some([some,_8101],_8090,_8092) --> 
    virtual(some,_8101,_8090,_8092).

much([much,_8101],_8090,_8092) --> 
    virtual(much,_8101,_8090,_8092).

little([little,_8101],_8090,_8092) --> 
    virtual(little,_8101,_8090,_8092).

every([every,_8101],_8090,_8092) --> 
    virtual(every,_8101,_8090,_8092).

relpron(agent,[relpron,_8108],_8094,_8096) --> 
    virtual(relpron(agent),_8108,_8094,_8096).

relpron(thing,[relpron,_8108],_8094,_8096) --> 
    virtual(relpron(thing),_8108,_8094,_8096).

time1(_8071,[time1,_8108],_8094,_8096) --> 
    virtual(time1(_8071),_8108,_8094,_8096).

and1([and1,_8101],_8090,_8092) --> 
    virtual(and1,_8101,_8090,_8092).

thispron([thispron,_8101],_8090,_8092) --> 
    virtual(thispron,_8101,_8090,_8092).

clock_kernel(_8074:clock,_8074 isa clock,[clock_kernel,_8120],_8103,_8105) --> 
    virtual(clock_kernel(_8074:clock,_8074 isa clock),_8120,_8103,_8105).

nameq1(_8071,_8072,[nameq1,_8114],_8097,_8099) --> 
    virtual(nameq1(_8071,_8072),_8114,_8097,_8099).

