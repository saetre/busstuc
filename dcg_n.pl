% Auxillary tables created datetime(2012,1,20,11,11,15)

%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

:-prolog_flag(discontiguous_warnings, off).

sentence([gpsflag:::_9855|_9852],[sentence,{},_9916,!,_9950],_9892,_9894) --> 
    {user:value(gpsflag,true)},
    origin_phrase(_9855,_9916,_9892,_9933),
    !,
    sentences(_9852,_9950,_9933,_9894).

sentence(_9850,[sentence,{},_9905],_9881,_9883) --> 
    {user:(\+value(gpsflag,true))},
    sentences(_9850,_9905,_9881,_9883).

origin_phrase([_9851|_9852],[origin_phrase,lit('('),!,_9924,{},_9963],_9894,_9896) --> 
    cc('(',_9894,_9918),
    !,
    origin_element(_9851,_9924,_9918,_9941),
    {user:set(new_origin,true)},
    origin_phrase0n(_9852,_9963,_9941,_9896).

origin_phrase([],[origin_phrase,[]],_9869,_9869) --> 
    [].

origin_phrase0n([_9851|_9852],[origin_phrase0n,_9895,!,_9929],_9881,_9883) --> 
    origin_element(_9851,_9895,_9881,_9912),
    !,
    origin_phrase0n(_9852,_9929,_9912,_9883).

origin_phrase0n([],[origin_phrase0n,lit(')')],_9871,_9873) --> 
    cc(')',_9871,_9873).

origin_element(gps_origin(_9852,_9853),[origin_element,_9898,lit(+),_9938],_9884,_9886) --> 
    gps_origin(_9852,_9898,_9884,_9915),
    cc(+,_9915,_9937),
    gps_time(_9853,_9938,_9937,_9886).

gps_origin(_9850,[gps_origin,_9893,!],_9879,_9881) --> 
    name_phrase(name,_9850:_9860,_9857,_9893,_9879,_9881),
    !.

gps_time(_9850,[gps_time,_9888],_9874,_9876) --> 
    w(nb(_9850,num),_9888,_9874,_9876).

sentence01(_9850,[sentence01,_9885],_9871,_9873) --> 
    implicitq(_9850,_9885,_9871,_9873).

sentence01(_9850,[sentence01,_9885],_9871,_9873) --> 
    sentence1(_9850,_9885,_9871,_9873).

sentences([new:::_9855],[sentences,{},_9920,_9949,!,_9978],_9896,_9898) --> 
    {user:value(queryflag,false)},
    declaration(_9855,_9920,_9896,_9937),
    terminatore(_9949,_9937,_9964),
    !,
    accept(_9978,_9964,_9898).

sentences([_9851],[sentences,{},_9925,_9949,_9978,_10022,!,_10051],_9901,_9903) --> 
    {user:value(queryflag,true)},
    greetings0(_9925,_9901,_9940),
    implicitq(_9851,_9949,_9940,_9966),
    optional(itrailer,_9978,_9966,_10010),
    terminatores(_10022,_10010,_10037),
    !,
    accept(_10051,_10037,_9903).

sentences(_9850,[sentences,_9902,{},_9941,_9965],_9888,_9890) --> 
    onesentence(_9861,_9902,_9888,_9919),
    {user:_9861\==error},
    check_stop(_9941,_9919,_9956),
    moresentences0(_9861,_9850,_9965,_9956,_9890).

moresentences0(_9850,_9851,[moresentences0,_9907,_9936,!,_9965,_9989],_9890,_9892) --> 
    onesentence(_9866,_9907,_9890,_9924),
    check_stop(_9936,_9924,_9951),
    !,
    accept(_9965,_9951,_9980),
    evenmore0(_9850,_9866,_9851,_9989,_9980,_9892).

evenmore0(_9850,error,[_9850,error],[evenmore0,!,_9907],_9882,_9884) --> 
    !,
    skip_rest(_9907,_9882,_9884).

evenmore0(_9850,[],[_9850],[evenmore0,[],!],_9880,_9880) --> 
    [],
    !.

evenmore0(_9850,_9851,[_9850|_9854],[evenmore0,_9900],_9880,_9882) --> 
    moresentences0(_9851,_9854,_9900,_9880,_9882).

onesentence([],[onesentence,_9889,!,_9918],_9875,_9877) --> 
    endofline(_9889,_9875,_9904),
    !,
    accept(_9918,_9904,_9877).

onesentence(_9850,[onesentence,_9894,_9923,!,_9952],_9880,_9882) --> 
    conf_statement(_9850,_9894,_9880,_9911),
    endofline(_9923,_9911,_9938),
    !,
    accept(_9952,_9938,_9882).

onesentence(_9850,[onesentence,_9894,_9918,_9947,_9971],_9880,_9882) --> 
    grums0(_9894,_9880,_9909),
    sentence1(_9850,_9918,_9909,_9935),
    sentence_delimiter(_9947,_9935,_9962),
    accept(_9971,_9962,_9882).

onesentence(error,[onesentence,_9883],_9869,_9871) --> 
    skip_rest(_9883,_9869,_9871).

notify([notify,_9882],_9871,_9873) --> 
    w(verb(notify,_9853,_9854),_9882,_9871,_9873).

notify([notify,_9883],_9872,_9874) --> 
    w(noun(notification,_9853,_9854,_9855),_9883,_9872,_9874).

conf_statement(confirm:::_9853,[conf_statement,_9888],_9874,_9876) --> 
    confirm(_9853,_9888,_9874,_9876).

confirm(false,[confirm,lit(jeg),_9913,lit(ikke),_9953],_9888,_9890) --> 
    cc(jeg,_9888,_9912),
    w(verb(know,pres,fin),_9913,_9912,_9930),
    cc(ikke,_9930,_9952),
    endofline(_9953,_9952,_9890).

confirm(true,[confirm,lit(ja),_9899],_9874,_9876) --> 
    cc(ja,_9874,_9898),
    of_course0(_9899,_9898,_9876).

confirm(true,[confirm,lit(jo),_9899],_9874,_9876) --> 
    cc(jo,_9874,_9898),
    of_course0(_9899,_9898,_9876).

confirm(false,[confirm,lit(nei),_9899],_9874,_9876) --> 
    cc(nei,_9874,_9898),
    of_coursenot0(_9899,_9898,_9876).

confirm(true,[confirm,_9883],_9869,_9871) --> 
    of_course(_9883,_9869,_9871).

confirm(false,[confirm,_9888,lit(ikke)],_9874,_9876) --> 
    of_course(_9888,_9874,_9903),
    cc(ikke,_9903,_9876).

sentence_delimiter([sentence_delimiter,lit(for),_9896],_9874,_9876) --> 
    cc(for,_9874,_9895),
    look_ahead([hvis],_9896,_9895,_9876).

sentence_delimiter([sentence_delimiter,lit(;)],_9867,_9869) --> 
    cc(;,_9867,_9869).

sentence_delimiter([sentence_delimiter,_9876],_9865,_9867) --> 
    terminatore(_9876,_9865,_9867).

terminatore0([terminatore0,_9882,!,_9911],_9871,_9873) --> 
    terminatore(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

terminatore0([terminatore0,[]],_9865,_9865) --> 
    [].

terminatores([terminatores,_9882,!,_9911],_9871,_9873) --> 
    terminator(_9882,_9871,_9897),
    !,
    terminatores(_9911,_9897,_9873).

terminatores([terminatores,_9885,_9909,!,_9938],_9874,_9876) --> 
    check_stop(_9885,_9874,_9900),
    endofline(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

terminatore([terminatore,_9876],_9865,_9867) --> 
    terminator1(_9876,_9865,_9867).

terminator1([terminator1,_9925,_9949,_9978,_10007,_10036,!,_10070],_9914,_9916) --> 
    terminator(_9925,_9914,_9940),
    not_look_ahead(w(nb(_9872,num)),_9949,_9940,_9966),
    not_look_ahead(w(name(_9879,_9880,month)),_9978,_9966,_9995),
    not_look_ahead(w(name(_9879,_9888,day)),_10007,_9995,_10024),
    not_look_ahead(w(name(_9879,_9896,date)),_10036,_10024,_10053),
    !,
    accept(_10070,_10053,_9916).

terminator1([terminator1,_9885,_9909,!,_9938],_9874,_9876) --> 
    check_stop_locations(_9885,_9874,_9900),
    endofline(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

look_ahead_endofline([look_ahead_endofline,_9887,!],_9876,_9878) --> 
    look_ahead_lit(['.',?,!],_9887,_9876,_9878),
    !.

look_ahead_endofline([look_ahead_endofline,_9876],_9865,_9867) --> 
    end_of_line(_9876,_9865,_9867).

endofline0([endofline0,_9882,!,_9911],_9871,_9873) --> 
    terminator(_9882,_9871,_9897),
    !,
    endofline0(_9911,_9897,_9873).

endofline0([endofline0,_9876],_9865,_9867) --> 
    end_of_line0(_9876,_9865,_9867).

endofline([endofline,_9885,_9909,!,_9938],_9874,_9876) --> 
    terminator(_9885,_9874,_9900),
    endofline(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

endofline([endofline,lit(:),_9895,!],_9873,_9875) --> 
    cc(:,_9873,_9894),
    end_of_line(_9895,_9894,_9875),
    !.

endofline([endofline,lit(+),{},_9916,!,_9945],_9884,_9886) --> 
    cc(+,_9884,_9905),
    {user:value(busflag,true)},
    endofline(_9916,_9905,_9931),
    !,
    accept(_9945,_9931,_9886).

endofline([endofline,_9876],_9865,_9867) --> 
    end_of_line(_9876,_9865,_9867).

endofline1([endofline1,lit('.')],_9867,_9869) --> 
    cc('.',_9867,_9869).

endofline1([endofline1,lit(?)],_9867,_9869) --> 
    cc(?,_9867,_9869).

endofline1([endofline1,lit(!)],_9867,_9869) --> 
    cc(!,_9867,_9869).

check_stop_locations([check_stop_locations,_9879,!],_9868,_9870) --> 
    check_stop(_9879,_9868,_9870),
    !.

assemble_stop_locations([_9854+_9855|_9852],[assemble_stop_locations,_9915,lit(+),_9955,!,_9989],_9901,_9903) --> 
    w(name(_9854,n,_9875),_9915,_9901,_9932),
    cc(+,_9932,_9954),
    w(nb(_9855,num),_9955,_9954,_9972),
    !,
    check_stop_locations(_9852,_9989,_9972,_9903).

assemble_stop_locations([],[assemble_stop_locations,_9883],_9869,_9871) --> 
    end_of_line(_9883,_9869,_9871).

sentence1(new:::_9853,[sentence1,_9936,_9960,lit(at),!,_10005,_10039],_9922,_9924) --> 
    hellos0(_9936,_9922,_9951),
    w(adj2(_9881,_9882),_9960,_9951,_9977),
    cc(at,_9977,_9999),
    !,
    clausal_object1(_9891,_9892,_10005,_9999,_10024),
    pushstack(first,(xnp(_9891,_9892),w(verb(be,pres,fin)),w(adj2(_9881,_9882))),nil,_10024,_10082),
    statreal(_9853,_10039,_10082,_9924).

sentence1(new:::_9853,[sentence1,_9911,_9935,!,_9983],_9897,_9899) --> 
    detaa(_9911,_9897,_9926),
    pushstack(first,[noen],nil,_9926,_9948),clausal_object1(_9867,_9868,_9935,_9948,_9963),
    !,
    pushstack(first,xnp(_9867,_9868),nil,_9963,_10024),
    statreal(_9853,_9983,_10024,_9899).

detaa([detaa,lit(det),lit('å')],_9872,_9874) --> 
    cc(det,_9872,_9893),
    cc('å',_9893,_9874).

detaa([detaa,lit('å')],_9867,_9869) --> 
    cc('å',_9867,_9869).

sentence1(new:::_9853,[sentence1,_9906,_9930,!,_9969],_9892,_9894) --> 
    hvorvidt(_9906,_9892,_9921),
    clausal_object1(_9867,_9868,_9930,_9921,_9949),
    !,
    pushstack(first,xnp(_9867,_9868),nil,_9949,_10010),
    statreal(_9853,_9969,_10010,_9894).

hvorvidt([hvorvidt,lit(hvorvidt)],_9867,_9869) --> 
    cc(hvorvidt,_9867,_9869).

hvorvidt([hvorvidt,lit(det),lit(at)],_9872,_9874) --> 
    cc(det,_9872,_9893),
    cc(at,_9893,_9874).

hvorvidt([hvorvidt,lit(at)],_9867,_9869) --> 
    cc(at,_9867,_9869).

sentence1(new:::_9853,[sentence1,_9899,_9923,!,_9957],_9885,_9887) --> 
    redundant(_9899,_9885,_9914),
    be_it_tf_that(_9866,_9923,_9914,_9940),
    !,
    statreal(_9853,_9957,_9940,_9887).

sentence1(new:::_9853,[sentence1,_9918,_9947,_9976],_9904,_9906) --> 
    w(verb(be,_9876,fin),_9918,_9904,_9935),
    look_ahead_lit([mye],_9947,_9935,_9964),
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_9964,_9986),
    statement(_9853,_9976,_9986,_9906).

sentence1(new:::_9853,[sentence1,_9932,_9961,lit(som),!,_10001],_9918,_9920) --> 
    w(verb(_9883,_9884,pass),_9932,_9918,_9949),
    redundant0(_9961,_9949,_9976),
    cc(som,_9976,_9995),
    !,
    pushstack(first,([noen],w(verb(_9883,_9884,fin)),[dette],[som]),nil,_9995,_10011),
    statreal(_9853,_10001,_10011,_9920).

sentence1(new:::_9853,[sentence1,_9926,_9970,_9999,_10028],_9912,_9914) --> 
    optional([kanskje],_9926,_9912,_9958),
    negation(_9873,_9970,_9958,_9987),
    not_look_ahead([alle],_9999,_9987,_10016),
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_9873)),nil,_10016,_10071),
    statreal(_9853,_10028,_10071,_9914).

sentence1(new:::_9853,[sentence1,_10014,_10043,_10072,_10101,_10135,_10164,lit('å'),_10204,!,_10238],_10000,_10002) --> 
    one_of_lit([den,det,dette,disse,slike],_10014,_10000,_10031),
    w(noun(_9905,_9906,_9907,n),_10043,_10031,_10060),
    w(verb(be,_9932,fin),_10072,_10060,_10089),
    subject(_9935,_9936,_10101,_10089,_10120),
    w(adj2(_9940,nil),_10135,_10120,_10152),
    w(prep(_9945),_10164,_10152,_10181),
    cc('å',_10181,_10203),
    w(verb(_9951,inf,fin),_10204,_10203,_10221),
    !,
    pushstack(first,(xnp(_9935,_9936),w(verb(be,_9932,fin)),w(adj2(_9940,nil)),w(prep(_9945)),['å'],w(verb(_9951,inf,fin)),w(noun(_9905,_9906,_9907,n))),nil,_10221,_10279),
    statreal(_9853,_10238,_10279,_10002).

sentence1(new:::_9853,[sentence1,_9986,_10015,_10044,_10073,_10107,_10136,!,_10170],_9972,_9974) --> 
    one_of_lit([den,det,dette,disse,slike],_9986,_9972,_10003),
    w(noun(_9893,_9894,_9895,n),_10015,_10003,_10032),
    w(verb(be,_9920,fin),_10044,_10032,_10061),
    subject(_9923,_9924,_10073,_10061,_10092),
    w(adj2(_9928,nil),_10107,_10092,_10124),
    w(prep(_9933),_10136,_10124,_10153),
    !,
    pushstack(free,(xnp(_9923,_9924),w(verb(be,_9920,fin)),w(adj2(_9928,nil)),w(prep(_9933)),w(noun(_9893,_9894,_9895,n))),nil,_10153,_10211),
    statreal(_9853,_10170,_10211,_9974).

sentence1(new:::_9853,[sentence1,_9990,_10019,_10048,_10077,_10111,_10140,!,_10174],_9976,_9978) --> 
    one_of_lit([den,det,dette,disse,slike],_9990,_9976,_10007),
    w(noun(_9893,_9894,_9895,n),_10019,_10007,_10036),
    w(verb(_9919,_9920,fin),_10048,_10036,_10065),
    subject(_9923,_9924,_10077,_10065,_10096),
    w(noun(_9928,sin,u,n),_10111,_10096,_10128),
    w(prep(_9935),_10140,_10128,_10157),
    !,
    pushstack(first,(xnp(_9923,_9924),w(verb(_9919,_9920,fin)),w(noun(_9928,sin,u,n)),w(prep(_9935)),w(noun(_9893,_9894,_9895,n))),nil,_10157,_10215),
    statreal(_9853,_10174,_10215,_9978).

sentence1(new:::_9853,[sentence1,_9970,_9999,_10028,{},_10067,!,_10106],_9956,_9958) --> 
    one_of_lit([den,det,dette,disse,slike],_9970,_9956,_9987),
    w(noun(_9884,_9885,_9886,n),_9999,_9987,_10016),
    w(verb(_9910,_9911,fin),_10028,_10016,_10045),
    {user:(\+testmember(_9910,[have,get]))},
    subject(_9925,_9926,_10067,_10045,_10086),
    !,
    pushstack(first,(xnp(_9925,_9926),w(verb(_9910,_9911,fin)),w(noun(_9884,_9885,_9886,n))),nil,_10086,_10147),
    statreal(_9853,_10106,_10147,_9958).

sentence1(new:::_9853,[sentence1,lit(hvorvidt),_9950,!,lit(kan),_10000,!,_10034],_9925,_9927) --> 
    cc(hvorvidt,_9925,_9949),
    clausal_object1(_9882,_9883,_9950,_9949,_9969),
    !,
    cc(kan,_9969,_9999),
    w(verb(_9894,_9895,pass),_10000,_9999,_10017),
    !,
    pushstack(first,([dere],w(verb(_9894,_9895,fin)),xnp(_9882,_9883)),nil,_10017,_10075),
    statreal(_9853,_10034,_10075,_9927).

sentence1(new:::_9853,[sentence1,_9932,_9961,_9995,!,_10029],_9918,_9920) --> 
    w(verb(_9875,_9881,_9882),_9932,_9918,_9949),
    gmem(_9875,[talk,speak],_9961,_9949,_9980),
    look_ahead(w(prep(_9895)),_9995,_9980,_10012),
    !,
    pushstack(first,([du],w(verb(_9875,pres))),nil,_10012,_10039),
    statreal(_9853,_10029,_10039,_9920).

sentence1(new:::_9853,[sentence1,_9905,_9929,!,_9958],_9891,_9893) --> 
    aux1(_9905,_9891,_9920),
    not_look_ahead_np(_9929,_9920,_9944),
    !,
    pushstack(first,([jeg],aux1),nil,_9944,_10001),
    statreal(_9853,_9958,_10001,_9893).

sentence1(new:::_9853,[sentence1,_9914,!,_9948],_9900,_9902) --> 
    w(verb(_9869,past,part),_9914,_9900,_9931),
    !,
    pushstack(first,([jeg],w(verb(_9869,past,fin))),nil,_9931,_9958),
    statreal(_9853,_9948,_9958,_9902).

sentence1(new:::_9853,[sentence1,_9914,!,_9948],_9900,_9902) --> 
    w(verb(_9869,past,part),_9914,_9900,_9931),
    !,
    pushstack(first,([jeg],w(verb(_9869,past,fin))),nil,_9931,_9958),
    statreal(_9853,_9948,_9958,_9902).

sentence1(new:::_9853,[sentence1,lit(har),_9940,_9969,!,_10003],_9915,_9917) --> 
    cc(har,_9915,_9939),
    negation0(_9876,_9940,_9939,_9957),
    w(verb(_9884,past,part),_9969,_9957,_9986),
    !,
    pushstack(first,([jeg],w(verb(_9884,past,fin)),negation(_9876)),nil,_9986,_10043),
    statreal(_9853,_10003,_10043,_9917).

sentence1(new:::_9853,[sentence1,_9952,_9981,_10010,_10044,_10068,_10097,!,_10131],_9938,_9940) --> 
    not_look_ahead(['så'],_9952,_9938,_9969),
    w(verb(_9884,pres,fin),_9981,_9969,_9998),
    gmem(_9884,[go,think],_10010,_9998,_10029),
    not_look_ahead_np(_10044,_10029,_10059),
    not_look_ahead([ikke],_10068,_10059,_10085),
    not_look_ahead_lit([jeg,meg,du],_10097,_10085,_10114),
    !,
    pushstack(first,([jeg],w(verb(_9884,pres,fin))),nil,_10114,_10141),
    statreal(_9853,_10131,_10141,_9940).

sentence1(new:::_9853,[sentence1,_9986,_10015,_10044,_10078,_10112,_10141,_10170,!,_10204],_9972,_9974) --> 
    not_look_ahead(['så'],_9986,_9972,_10003),
    w(verb(_9887,_9898,fin),_10015,_10003,_10032),
    gmem(_9898,[pres],_10044,_10032,_10063),
    gmem(_9887,[arrive,calculate,discover,give,hope,pass,run,send,start,take,think,try,wait],_10078,_10063,_10097),
    particlev1(_9887,_10112,_10097,_10129),
    not_look_ahead([ikke],_10141,_10129,_10158),
    not_look_ahead_lit([jeg,meg,du,vi],_10170,_10158,_10187),
    !,
    pushstack(first,([jeg],w(verb(_9887,pres,fin))),nil,_10187,_10214),
    statreal(_9853,_10204,_10214,_9974).

sentence1(new:::_9853,[sentence1,_9978,_10007,_10036,_10070,_10104,_10133,_10162,!,_10196],_9964,_9966) --> 
    not_look_ahead(['så'],_9978,_9964,_9995),
    w(verb(_9887,_9898,fin),_10007,_9995,_10024),
    gmem(_9898,[imp,inf],_10036,_10024,_10055),
    gmem(_9887,[arrive,discover,pass,run,send,start,take,try],_10070,_10055,_10089),
    reflexiv0(_9887,_10104,_10089,_10121),
    not_look_ahead([ikke],_10133,_10121,_10150),
    not_look_ahead_lit([jeg,meg,du,vi],_10162,_10150,_10179),
    !,
    pushstack(first,([jeg],w(verb(_9887,pres,fin))),nil,_10179,_10206),
    statreal(_9853,_10196,_10206,_9966).

sentence1(new:::_9853,[sentence1,_9968,_9997,{},_10036,_10065,_10094,_10118,!,_10167],_9954,_9956) --> 
    not_look_ahead(['så'],_9968,_9954,_9985),
    w(verb(_9896,pres,fin),_9997,_9985,_10014),
    {user:testmember(_9896,[believe,calculate,think,see,know])},
    not_look_ahead([det],_10036,_10014,_10053),
    not_look_ahead([du],_10065,_10053,_10082),
    redundant0(_10094,_10082,_10109),
    optional([at],_10118,_10109,_10150),
    !,
    pushstack(first,([jeg],w(verb(_9896,pres,fin)),[at]),nil,_10150,_10177),
    statreal(_9853,_10167,_10177,_9956).

sentence1(new:::_9853,[sentence1,_9937,_9966,_9995,lit(jeg),_10030,!,_10059],_9923,_9925) --> 
    not_look_ahead(['så'],_9937,_9923,_9954),
    w(verb(_9890,_9891,fin),_9966,_9954,_9983),
    redundant0(_9995,_9983,_10010),
    cc(jeg,_10010,_10029),
    aux1(_10030,_10029,_10045),
    !,
    pushstack(first,([jeg],w(verb(_9890,pres,fin)),['å']),nil,_10045,_10069),
    statement(_9853,_10059,_10069,_9925).

sentence1(new:::_9853,[sentence1,_9930,_9954,_9978,_10007,!,_10041],_9916,_9918) --> 
    aux1(_9930,_9916,_9945),
    redundants0(_9954,_9945,_9969),
    negation0(_9879,_9978,_9969,_9995),
    w(verb(_9885,inf,fin),_10007,_9995,_10024),
    !,
    pushstack(first,([jeg],w(verb(_9885,pres,fin)),negation(_9879)),nil,_10024,_10081),
    statement(_9853,_10041,_10081,_9918).

sentence1(_9850,[sentence1,_9885],_9871,_9873) --> 
    command(_9850,_9885,_9871,_9873).

sentence1(_9850,[sentence1,_9891,_9915,_9944],_9877,_9879) --> 
    greetings0(_9891,_9877,_9906),
    question(_9850,_9915,_9906,_9932),
    qtrailer0(_9944,_9932,_9879).

sentence1(modifier(_9862):::_9866 isa clock and srel/nil/time/_9866/_9862 and event/real/_9862,[sentence1,{},_9955,_9984,{},!,_10023],_9931,_9933) --> 
    {user:value(dialog,1)},
    item(_9904,_9955,_9931,_9972),
    endofline(_9984,_9972,_9999),
    {user:_9904=(_9866 isa clock)},
    !,
    accept(_10023,_9999,_9933).

sentence1(item:::_9853,[sentence1,{},_9915,_9944,!,_9973],_9891,_9893) --> 
    {user:value(dialog,1)},
    item(_9853,_9915,_9891,_9932),
    endofline(_9944,_9932,_9959),
    !,
    accept(_9973,_9959,_9893).

sentence1(item:::_9855 isa clock,[sentence1,{},lit('nå'),_9939,!,_9968,{}],_9904,_9906) --> 
    {user:value(dialog,1)},
    cc('nå',_9904,_9938),
    terminator1(_9939,_9938,_9954),
    !,
    accept(_9968,_9954,_9906),
    {user:timenow(_9855)}.

sentence1(item:::_9853,[sentence1,_9916,{},_9980,!,_10009],_9902,_9904) --> 
    noun(_9867,_9868,_9869,n,it:_9875,_9853,_9916,_9902,_9943),
    {user:value(dialog,1)},
    endofline(_9980,_9943,_9995),
    !,
    accept(_10009,_9995,_9904).

sentence1(item:::it isa _9856,[sentence1,{},_9926,_9950,!,_9979,{}],_9902,_9904) --> 
    {user:value(dialog,1)},
    today(_9926,_9902,_9941),
    terminator1(_9950,_9941,_9965),
    !,
    accept(_9979,_9965,_9904),
    {user:today(_9856)}.

sentence1(new:::_9853,[sentence1,lit(ble),_9939,!,_9973],_9914,_9916) --> 
    cc(ble,_9914,_9938),
    look_ahead(w(adj2(_9875,nil)),_9939,_9938,_9956),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),w(adj2(_9875,nil))),nil,_9956,_9983),
    statement(_9853,_9973,_9983,_9916).

sentence1(new:::_9853,[sentence1,_9948,_9977,_10001,{},!,_10045,_10069],_9934,_9936) --> 
    w(verb(be,_9889,_9890),_9948,_9934,_9965),
    now0(_9977,_9965,_9992),
    w(prep(_9894),_10001,_9992,_10018),
    {user:testmember(_9894,[in,on,at])},
    !,
    accept(_10045,_10018,_10060),
    pushstack(first,([jeg],w(verb(be,pres,fin)),w(prep(on))),nil,_10060,_10079),
    statement(_9853,_10069,_10079,_9936).

sentence1(new:::_9853,[sentence1,_9933,_9957,{},_9996,_10020],_9919,_9921) --> 
    has(_9933,_9919,_9948),
    w(verb(_9875,past,part),_9957,_9948,_9974),
    {user:testmember(_9875,[send,get,receive,lay])},
    now0(_9996,_9974,_10011),
    pushstack(first,([jeg],w(verb(_9875,past,fin))),nil,_10011,_10030),
    statement(_9853,_10020,_10030,_9921).

sentence1(new:::_9853,[sentence1,_9932,{},_9971,_9995],_9918,_9920) --> 
    w(verb(_9872,_9879,fin),_9932,_9918,_9949),
    {user:testmember(_9872,[send,get,receive,lay,check])},
    now0(_9971,_9949,_9986),
    pushstack(first,([jeg],w(verb(_9872,pres,fin))),nil,_9986,_10005),
    statement(_9853,_9995,_10005,_9920).

sentence1(new:::_9853,[sentence1,_9894,_9918,_9947],_9880,_9882) --> 
    greetings0(_9894,_9880,_9909),
    statement(_9853,_9918,_9909,_9935),
    dtrailer0(_9947,_9935,_9882).

sentence1(item:::_9853,[sentence1,_9897,_9926,!,_9955],_9883,_9885) --> 
    item(_9853,_9897,_9883,_9914),
    terminator1(_9926,_9914,_9941),
    !,
    accept(_9955,_9941,_9885).

item(_9852 isa clock,[item,{},_9917,{},_9956],_9893,_9895) --> 
    {user:value(dialog,1)},
    time12(_9852,_9917,_9893,_9934),
    {user:_9852\==now},
    endofline(_9956,_9934,_9895).

item(_9850,[item,{},_9907,_9941],_9883,_9885) --> 
    {user:value(dialog,1)},
    obviousdate1(_9863,_9850,_9907,_9883,_9926),
    endofline(_9941,_9926,_9885).

item(_9850,[item,_9887],_9873,_9875) --> 
    namep(_9852,_9853,_9850,_9887,_9873,_9875).

command(_9850,[command,lit(vil),!,_9907],_9877,_9879) --> 
    cc(vil,_9877,_9901),
    !,
    reject(_9907,_9901,_9879).

command(_9850,[command,lit(skal),!,_9907],_9877,_9879) --> 
    cc(skal,_9877,_9901),
    !,
    reject(_9907,_9901,_9879).

command(doit:::_9853,[command,lit(du),lit('må'),_9953,_9982,!,_10016],_9917,_9919) --> 
    cc(du,_9917,_9941),
    cc('må',_9941,_9952),
    not_look_ahead([ikke],_9953,_9952,_9970),
    w(verb(_9878,inf,fin),_9982,_9970,_9999),
    !,
    pushstack(first,([du],w(verb(_9878,pres,fin))),nil,_9999,_10026),
    statreal(_9853,_10016,_10026,_9919).

command(doit:::quit(_9855),[command,_9899,_9923,_9947,_9976],_9885,_9887) --> 
    grums0(_9899,_9885,_9914),
    okeys0(_9923,_9914,_9938),
    quit(_9855,_9947,_9938,_9964),
    skip_rest(_9976,_9964,_9887).

command(doit:::reply(_9855),[command,_9896,_9925,_9949],_9882,_9884) --> 
    personal(_9855,_9896,_9882,_9913),
    dtrailer0(_9925,_9913,_9940),
    endofline(_9949,_9940,_9884).

command(doit:::replyq('Hei'),[command,_9891,!],_9877,_9879) --> 
    hellos(_9891,_9877,_9879),
    !.

command(new:::_9853,[command,_9926,_9955,lit(ut),_9995,_10029,!,_10058],_9912,_9914) --> 
    w(verb(_9878,pres,fin),_9926,_9912,_9943),
    not_look_ahead([du],_9955,_9943,_9972),
    cc(ut,_9972,_9994),
    gmem(_9878,[see,look],_9995,_9994,_10014),
    tilat(_10029,_10014,_10044),
    !,
    substateme1(real,_9853,_10058,_10044,_9914).

tilat([tilat,lit(til),lit(at),!],_9875,_9877) --> 
    cc(til,_9875,_9896),
    cc(at,_9896,_9877),
    !.

tilat([tilat,lit(som),lit(om),!],_9875,_9877) --> 
    cc(som,_9875,_9896),
    cc(om,_9896,_9877),
    !.

tilat([tilat,lit(som)],_9867,_9869) --> 
    cc(som,_9867,_9869).

command(new:::_9853,[command,_9941,_9970,_9999,!,_10038],_9927,_9929) --> 
    w(verb(_9875,pres,fin),_9941,_9927,_9958),
    not_look_ahead([du],_9970,_9958,_9987),
    gmem(_9875,[expect,miss,need,get,receive,see,understand],_9999,_9987,_10018),
    !,
    pushstack(first,([jeg],w(verb(_9875,pres,fin))),nil,_10018,_10048),
    statreal(_9853,_10038,_10048,_9929).

command(new:::_9853,[command,_9977,_10006,_10035,{},_10074,{},!,_10118],_9963,_9965) --> 
    not_look_ahead(['nå'],_9977,_9963,_9994),
    not_look_ahead(w(verb(come,imp,fin)),_10006,_9994,_10023),
    w(verb(_9884,_9903,fin),_10035,_10023,_10052),
    {user:testmember(_9884,[go,take,run,arrive,leave,leave2,depart,start,pass])},
    not_look_ahead([meg],_10074,_10052,_10091),
    {user:testmember(_9903,[imp,inf])},
    !,
    pushstack(first,([jeg],w(verb(_9884,pres,fin))),nil,_10091,_10128),
    statreal(_9853,_10118,_10128,_9965).

command(new:::_9853,[command,_9942,_9971,{},_10010,lit(jeg),_10055,!,_10089],_9928,_9930) --> 
    w(verb(_9883,pres,fin),_9942,_9928,_9959),
    not_look_ahead([du],_9971,_9959,_9988),
    {user:testmember(_9883,[believe])},
    that0(_9883,that,_10010,_9988,_10029),
    cc(jeg,_10029,_10054),
    not_look_ahead(w(prep(_9907)),_10055,_10054,_10072),
    !,
    pushstack(first,[jeg],nil,_10072,_10099),
    statreal(_9853,_10089,_10099,_9930).

command(new:::_9853,[command,_9929,_9958,_9992,!,_10021],_9915,_9917) --> 
    w(verb(_9875,pres,fin),_9929,_9915,_9946),
    gmem(_9875,[arrive,leave2,depart],_9958,_9946,_9977),
    look_ahead_place(_9992,_9977,_10007),
    !,
    pushstack(first,([jeg],w(verb(_9875,pres,fin))),nil,_10007,_10031),
    statreal(_9853,_10021,_10031,_9917).

command(doit:::_9853,[command,_9943,_9987,_10011,_10040,{},_10079,!,_10108],_9929,_9931) --> 
    optional(grums,_9943,_9929,_9975),
    please0(_9987,_9975,_10002),
    negation0(_9885,_10011,_10002,_10028),
    w(verb(_9893,imp,fin),_10040,_10028,_10057),
    {user:verbtype(_9893,tv)},
    look_ahead_np(_10079,_10057,_10094),
    !,
    pushstack(first,([du],w(verb(_9893,pres,fin)),negation(_9885)),nil,_10094,_10148),
    statreal(_9853,_10108,_10148,_9931).

command(doit:::_9853,[command,_9938,_9982,_10006,_10035,_10064,!,_10103],_9924,_9926) --> 
    optional(grums,_9938,_9924,_9970),
    please0(_9982,_9970,_9997),
    negation0(_9882,_10006,_9997,_10023),
    w(verb(_9890,imp,fin),_10035,_10023,_10052),
    particlev0(_9890,_9895,_10064,_10052,_10083),
    !,
    pushstack(first,([du],w(verb(_9895,pres,fin)),negation(_9882)),nil,_10083,_10143),
    statreal(_9853,_10103,_10143,_9926).

command(doit:::replyq(?),[command,_9888],_9874,_9876) --> 
    end_of_line(_9888,_9874,_9876).

imp_phrase(_9850,[imp_phrase,_9905,lit(oss),_9960,!],_9891,_9893) --> 
    lexv(_9861,let,imp,fin,_9905,_9891,_9928),
    cc(oss,_9928,_9959),
    w(verb(_9850,inf,fin),_9960,_9959,_9893),
    !.

imp_phrase(let,[imp_phrase,_9894,!,_9943],_9880,_9882) --> 
    lexv(rv,let,imp,fin,_9894,_9880,_9917),
    !,
    accept(_9943,_9917,_9882).

imp_phrase(list,[imp_phrase,_9897,_9921,!,_9970],_9883,_9885) --> 
    faa(_9897,_9883,_9912),
    lexv(_9861,see,imp,fin,_9921,_9912,_9944),
    !,
    accept(_9970,_9944,_9885).

imp_phrase(wait,[imp_phrase,_9892,!],_9878,_9880) --> 
    w(verb(wait,imp,fin),_9892,_9878,_9880),
    !.

imp_phrase(_9850,[imp_phrase,_9920,_9949,_9973,{},{}],_9906,_9908) --> 
    not_look_ahead(['må'],_9920,_9906,_9937),
    comeand0(_9949,_9937,_9964),
    lexv(_9879,_9850,imp,fin,_9973,_9964,_9908),
    {user:_9879\==rv},
    {user:(\+testmember(_9850,[have,expect]))}.

imp_phrase(_9850,[imp_phrase,_9919,_9948,_9972,{},{},_10036],_9905,_9907) --> 
    not_look_ahead(['må'],_9919,_9905,_9936),
    comeand0(_9948,_9936,_9963),
    lexv(rv,_9850,imp,fin,_9972,_9963,_9995),
    {user:_9850\==be},
    {user:_9850\==wonder},
    reflexiv0(_9850,_10036,_9995,_9907).

imp_phrase(_9850,[imp_phrase,_9920,_9949,_9973,{},{}],_9906,_9908) --> 
    not_look_ahead(['må'],_9920,_9906,_9937),
    comeand0(_9949,_9937,_9964),
    lexv(_9873,_9850,inf,fin,_9973,_9964,_9908),
    {user:testmember(_9850,[list,show,make])},
    {user:_9850\==be}.

comeand0([comeand0,_9890,lit('å'),!],_9879,_9881) --> 
    w(verb(come,imp,fin),_9890,_9879,_9907),
    cc('å',_9907,_9881),
    !.

comeand0([comeand0,[]],_9865,_9865) --> 
    [].

declaration(_9852 isa self,[declaration,_9897,_9921,!,_9950],_9883,_9885) --> 
    i(_9897,_9883,_9912),
    be(_9921,_9912,_9936),
    !,
    newatomid(_9852,_9950,_9936,_9885).

declaration(_9850,[declaration,_9904,_9933,_9957,!,_9986],_9890,_9892) --> 
    newatom(_9868,_9904,_9890,_9921),
    be(_9933,_9921,_9948),
    a(_9957,_9948,_9972),
    !,
    noun(_9864,sin,u,n,_9868,_9850,_9986,_9972,_9892).

statement(_9850,[statement,lit(det),_9948,lit(at),_9988,_10017,_10056,!,_10085,[],_10156],_9923,_9925) --> 
    cc(det,_9923,_9947),
    be_truefalse(_9883,_9948,_9947,_9965),
    cc(at,_9965,_9987),
    look_ahead_lit(['før',etter,'når'],_9988,_9987,_10005),
    adverbial3(_9895,_9896,_9897,_10017,_10005,_10038),
    comma0(_10056,_10038,_10071),
    !,
    accept(_10085,_10071,_10100),
    pushstack(free,adverbial1(_9895,_9896,_9897),nil,_10100,_10155),[],
    substatement1(_9850,_10156,_10155,_9925).

statement(_9850,[statement,_9923,_9952,_9991,!,_10020],_9909,_9911) --> 
    look_ahead_lit([hvis,om,selvom,da],_9923,_9909,_9940),
    adverbial3(_9870,_9871,_9872,_9952,_9940,_9973),
    soredundant(_9991,_9973,_10006),
    !,
    lock(last,_10006,_10070),
    pushstack(last,(['så'],xadverbial1(_9870,_9871,_9872)),nil,_10070,_10076),
    substatement1(_9850,_10020,_10076,_10065),
    unlock(_10065,_9911).

statement(_9850,[statement,_9947,_9976,_10015,_10044,lit(det),!,_10089,_10113],_9933,_9935) --> 
    look_ahead([hvis],_9947,_9933,_9964),
    adverbial3(_9882,_9883,_9884,_9976,_9964,_9997),
    not_look_ahead(['så'],_10015,_9997,_10032),
    w(verb(_9900,_9901,fin),_10044,_10032,_10061),
    cc(det,_10061,_10083),
    !,
    accept(_10089,_10083,_10104),
    lock(last,_10104,_10162),
    pushstack(last,([det],w(verb(_9900,_9901,fin)),xadverbial1(_9882,_9883,_9884)),nil,_10162,_10168),
    substatement1(_9850,_10113,_10168,_10157),
    unlock(_10157,_9935).

statement(_9850,[statement,_9945,_9974,_10013,_10042,lit(det),_10077,!,_10111,_10135],_9931,_9933) --> 
    look_ahead([hvis],_9945,_9931,_9962),
    adverbial3(_9888,_9889,_9890,_9974,_9962,_9995),
    not_look_ahead(['så'],_10013,_9995,_10030),
    aux1(_10042,_10030,_10057),
    cc(det,_10057,_10076),
    negation0(_9906,_10077,_10076,_10094),
    !,
    accept(_10111,_10094,_10126),
    lock(last,_10126,_10242),
    pushstack(last,([det],aux1,negation(_9906),xadverbial1(_9888,_9889,_9890)),nil,_10242,_10248),
    substatement1(_9850,_10135,_10248,_10237),
    unlock(_10237,_9933).

statement(_9850,[statement,_9950,_9979,_10018,_10047,_10071,_10105,_10129,!,_10163,_10187],_9936,_9938) --> 
    look_ahead([hvis],_9950,_9936,_9967),
    adverbial3(_9891,_9892,_9893,_9979,_9967,_10000),
    not_look_ahead(['så'],_10018,_10000,_10035),
    aux1(_10047,_10035,_10062),
    subject(_9907,_9908,_10071,_10062,_10090),
    redundant0(_10105,_10090,_10120),
    negation0(_9910,_10129,_10120,_10146),
    !,
    accept(_10163,_10146,_10178),
    lock(last,_10178,_10325),
    pushstack(last,(xnp(_9907,_9908),aux1,negation(_9910),xadverbial1(_9891,_9892,_9893)),nil,_10325,_10331),
    substatement1(_9850,_10187,_10331,_10320),
    unlock(_10320,_9938).

statement(_9850,[statement,_9952,_9981,_10020,_10049,!,_10083,!,_10122,_10146],_9938,_9940) --> 
    look_ahead([hvis],_9952,_9938,_9969),
    adverbial3(_9885,_9886,_9887,_9981,_9969,_10002),
    not_look_ahead(['så'],_10020,_10002,_10037),
    w(verb(_9903,_9904,fin),_10049,_10037,_10066),
    !,
    subject(_9907,_9908,_10083,_10066,_10102),
    !,
    accept(_10122,_10102,_10137),
    lock(last,_10137,_10226),
    pushstack(last,(xnp(_9907,_9908),w(verb(_9903,_9904,fin)),xadverbial1(_9885,_9886,_9887)),nil,_10226,_10232),
    substatement1(_9850,_10146,_10232,_10221),
    unlock(_10221,_9940).

statement(_9850,[statement,_9922,_9951,_9990,!,_10019,[],_10089],_9908,_9910) --> 
    look_ahead_lit(['før',etter,'når'],_9922,_9908,_9939),
    adverbial3(_9880,_9881,_9882,_9951,_9939,_9972),
    comma0(_9990,_9972,_10005),
    !,
    accept(_10019,_10005,_10034),
    pushstack(free,adverbial1(_9880,_9881,_9882),nil,_10034,_10088),[],
    substatement1(_9850,_10089,_10088,_9910).

statement(_9850,[statement,_9886],_9872,_9874) --> 
    statemens(real,_9850,_9886,_9872,_9874).

substatement1(_9850,[substatement1,_9938,_9962,_9991,_10035,_10069,_10113,!,_10152],_9924,_9926) --> 
    dether(_9938,_9924,_9953),
    w(verb(be,_9885,fin),_9962,_9953,_9979),
    optional([ofte],_9991,_9979,_10023),
    np0_accept(_9879,_9880,_10035,_10023,_10054),
    optional([som],_10069,_10054,_10101),
    subject(_9899,_9900,_10113,_10101,_10132),
    !,
    pushstack(free,(xnp(_9899,_9900),xnp(_9879,_9880)),nil,_10132,_10224),
    statreal(_9850,_10152,_10224,_9926).

dether([dether,lit(det)],_9867,_9869) --> 
    cc(det,_9867,_9869).

dether([dether,lit(det),lit(her)],_9872,_9874) --> 
    cc(det,_9872,_9893),
    cc(her,_9893,_9874).

dether([dether,lit(dette)],_9867,_9869) --> 
    cc(dette,_9867,_9869).

substatement1(_9850,[substatement1,_9886],_9872,_9874) --> 
    statemen1(real,_9850,_9886,_9872,_9874).

statemens(_9850,_9851,[statemens,_9899,_9933],_9882,_9884) --> 
    statemen1(_9850,_9857,_9899,_9882,_9918),
    statemens0(_9850,_9857,_9851,_9933,_9918,_9884).

statemens0(_9850,_9851,_9851 and _9855,[statemens0,_9915,_9939,!,_9968],_9895,_9897) --> 
    stm_conjunction(_9915,_9895,_9930),
    aux1(_9939,_9930,_9954),
    !,
    pushstack(first,[jeg],nil,_9954,_9978),
    statemens(_9850,_9855,_9968,_9978,_9897).

statemens0(_9850,_9851,_9851 and _9855,[statemens0,_9918,_9942,!,_9976],_9898,_9900) --> 
    stm_conjunction(_9918,_9898,_9933),
    look_ahead_lit(['så','nå',da],_9942,_9933,_9959),
    !,
    statemens(_9850,_9855,_9976,_9959,_9900).

statemens0(_9850,_9851,_9851 and _9855,[statemens0,_9911,!,_9945],_9891,_9893) --> 
    look_ahead(['så'],_9911,_9891,_9928),
    !,
    statemens(_9850,_9855,_9945,_9928,_9893).

statemens0(_9850,_9851,_9851 and _9855,[statemens0,_9921,_9945,_9974,!,_10003],_9901,_9903) --> 
    stm_conjunction(_9921,_9901,_9936),
    not_look_ahead(w(verb(_9876,_9877,_9878)),_9945,_9936,_9962),
    not_look_ahead_number(_9974,_9962,_9989),
    !,
    statemens(_9850,_9855,_10003,_9989,_9903).

statemens0(_9850,_9851,_9851,[statemens0,[]],_9875,_9875) --> 
    [].

stm_conjunction([stm_conjunction,lit(hvorav)],_9867,_9869) --> 
    cc(hvorav,_9867,_9869).

stm_conjunction([stm_conjunction,lit('å'),_9896],_9874,_9876) --> 
    cc('å',_9874,_9895),
    look_ahead(['så'],_9896,_9895,_9876).

stm_conjunction([stm_conjunction,lit('å'),_9896],_9874,_9876) --> 
    cc('å',_9874,_9895),
    look_ahead(['nå'],_9896,_9895,_9876).

stm_conjunction([stm_conjunction,lit(og),_9896],_9874,_9876) --> 
    cc(og,_9874,_9895),
    look_ahead(['nå'],_9896,_9895,_9876).

stm_conjunction([stm_conjunction,lit(og),lit(at)],_9872,_9874) --> 
    cc(og,_9872,_9893),
    cc(at,_9893,_9874).

stm_conjunction([stm_conjunction,lit(men),lit(at)],_9872,_9874) --> 
    cc(men,_9872,_9893),
    cc(at,_9893,_9874).

stm_conjunction([stm_conjunction,lit('altså'),lit(at)],_9872,_9874) --> 
    cc('altså',_9872,_9893),
    cc(at,_9893,_9874).

stm_conjunction([stm_conjunction,_9876],_9865,_9867) --> 
    and1(_9876,_9865,_9867).

stm_conjunction([stm_conjunction,lit(men)],_9867,_9869) --> 
    cc(men,_9867,_9869).

stm_conjunction([stm_conjunction,_9880],_9869,_9871) --> 
    look_ahead(['så'],_9880,_9869,_9871).

stm_conjunction([stm_conjunction,_9887,_9931],_9876,_9878) --> 
    optional([','],_9887,_9876,_9919),
    look_ahead([ikke],_9931,_9919,_9878).

stm_conjunction([stm_conjunction,lit(mens)],_9867,_9869) --> 
    cc(mens,_9867,_9869).

statemen1(_9850,_9851,[statemen1,_9892],_9875,_9877) --> 
    stateme1(_9850,_9851,_9892,_9875,_9877).

statemen1(_9850,_9851,[statemen1,_9951,{},_9990,!,_10039],_9934,_9936) --> 
    w(adj2(_9881,nil),_9951,_9934,_9968),
    {user:testmember(_9881,[possible,clear,ready])},
    optional([at],_9990,_9968,_10022),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_9881,nil)),[at]),nil,_10022,_10049),
    substateme1(_9850,_9851,_10039,_10049,_9936).

statemen1(_9850,_9851,[statemen1,_9975,{},_10014,{},{},_10063,!,_10102,!,_10181],_9958,_9960) --> 
    w(adj2(_9882,nil),_9975,_9958,_9992),
    {user:testmember(_9882,[enclosed])},
    w(verb(_9894,_9895,fin),_10014,_9992,_10031),
    {user:(\+testmember(_9894,[]))},
    {user:verbtype(_9894,iv)},
    subject(_9910,_9911,_10063,_10031,_10082),
    !,
    pushstack(first,(xnp(_9910,_9911),w(verb(_9894,_9895,fin)),w(adj2(_9882,nil))),nil,_10082,_10146),substateme1(_9850,_9851,_10102,_10146,_10161),
    !,
    accept(_10181,_10161,_9960).

statemen1(_9850,_9851,[statemen1,_9942,_9966,{},lit(det),_10016,_10040,!,_10088],_9925,_9927) --> 
    redundant(_9942,_9925,_9957),
    w(verb(_9876,_9877,fin),_9966,_9957,_9983),
    {user:(\+testmember(_9876,[]))},
    cc(det,_9983,_10015),
    danow0(_10016,_10015,_10031),
    pushstack(first,([det],w(verb(_9876,pres,fin))),nil,_10031,_10053),substateme1(_9850,_9851,_10040,_10053,_10068),
    !,
    accept(_10088,_10068,_9927).

statemen1(_9850,_9851,[statemen1,_9951,_9995,{},_10034,!,_10082],_9934,_9936) --> 
    optional([meget],_9951,_9934,_9983),
    w(adj2(_9874,nil),_9995,_9983,_10012),
    {user:testmember(_9874,[good,bad,interesting,nice])},
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_9874,nil))),nil,_10012,_10047),substateme1(_9850,_9851,_10034,_10047,_10062),
    !,
    accept(_10082,_10062,_9936).

statemen1(_9850,_9851,[statemen1,_9912,{},_9951],_9895,_9897) --> 
    not_look_ahead_lit([hva,hvem,hvilke,hvilken,hvilket],_9912,_9895,_9929),
    {user:unprotected_verb},
    substateme1(_9850,_9851,_9951,_9929,_9897).

statemen1(_9850,_9851,[statemen1,lit(som),lit(du),_9977,{},_10016,_10045,_10079],_9938,_9940) --> 
    cc(som,_9938,_9965),
    cc(du,_9965,_9976),
    w(verb(_9889,_9890,fin),_9977,_9976,_9994),
    {user:testmember(_9889,[know,see,understand])},
    w(verb(_9879,_9907,fin),_10016,_9994,_10033),
    subject(_9910,_9911,_10045,_10033,_10064),
    pushstack(first,(xnp(_9910,_9911),w(verb(_9879,pres,fin))),nil,_10064,_10120),
    substateme1(_9850,_9851,_10079,_10120,_9940).

statemen1(_9850,_9851,[statemen1,_9926,_9950,lit(det),_9990,!],_9909,_9911) --> 
    soredundant(_9926,_9909,_9941),
    w(verb(_9867,_9868,fin),_9950,_9941,_9967),
    cc(det,_9967,_9989),
    pushstack(first,([noe],w(verb(_9867,_9868,fin))),nil,_9989,_10003),substateme1(_9850,_9851,_9990,_10003,_9911),
    !.

stateme1(_9850,_9851,[stateme1,_9901],_9884,_9886) --> 
    statem(_9853,event/_9850/_9853::_9851,_9901,_9884,_9886).

substateme1(_9850,_9851,[substateme1,_9901],_9884,_9886) --> 
    substatem1(_9853,event/_9850/_9853::_9851,_9901,_9884,_9886).

substatem(_9850,_9851,[substatem,_9899,_9933],_9882,_9884) --> 
    substatem1(_9850,_9857,_9899,_9882,_9918),
    ogat(_9850,_9857,_9851,_9933,_9918,_9884).

ogat(_9850,_9854::_9857,_9854::_9857 and _9858,[ogat,lit(og),lit(at),!,_9950],_9903,_9905) --> 
    cc(og,_9903,_9933),
    cc(at,_9933,_9944),
    !,
    substatem1(_9850,_9854::_9858,_9950,_9944,_9905).

ogat(_9850,_9851,_9851,[ogat,[]],_9875,_9875) --> 
    [].

substatem1(_9850,_9851,[substatem1,lit(det),_9952,_9981,{},!,[],_10069],_9924,_9926) --> 
    cc(det,_9924,_9951),
    negation0(_9885,_9952,_9951,_9969),
    be(_9887,_9981,_9969,_9998),
    {user:bigno(_9885,_9887,_9893)},
    !,
    pushstack(free,negation(_9893),nil,_9998,_10068),[],
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_10068,_10079),
    statem(_9850,_9851,_10069,_10079,_9926).

substatem1(_9850,_9851,[substatem1,lit(det),_9953,_9982,{},!,_10046],_9925,_9927) --> 
    cc(det,_9925,_9952),
    negation0(_9881,_9953,_9952,_9970),
    hlexv(_9883,_9884,_9885,fin,_9887,_9982,_9970,_10007),
    {user:bigno(_9881,_9887,_9877)},
    !,
    pushstack(first,([det],w(verb(_9884,pres,fin)),negation(_9877)),nil,_10007,_10086),
    statem(_9850,_9851,_10046,_10086,_9927).

substatem1(_9850,_9851,[substatem1,lit('å'),!,_9936,!,_9984],_9903,_9905) --> 
    cc('å',_9903,_9930),
    !,
    pushstack(first,[jeg],nil,_9930,_9949),clausal_object1(_9868,_9869,_9936,_9949,_9964),
    !,
    lock(last,_9964,_10032),
    pushstack(last,xnp(_9868,_9869),nil,_10032,_10038),
    statem(_9850,_9851,_9984,_10038,_10027),
    unlock(_10027,_9905).

substatem1(_9850,_9851,[substatem1,_9945,_9969,_9998,_10041,!,_10070],_9928,_9930) --> 
    'forå'(_9945,_9928,_9960),
    w(verb(_9880,inf,fin),_9969,_9960,_9986),
    pushstack(first,([jeg],w(verb(_9880,pres,fin))),nil,_9986,_10011),clausal_object1(_9875,true::_9876,_9998,_10011,_10026),
    hvisaa0(_10041,_10026,_10056),
    !,
    lock(last,_10056,_10120),
    pushstack(last,(['så'],subordinate(in_order_to,_9875,_9876)),nil,_10120,_10126),
    statem(_9850,_9851,_10070,_10126,_10115),
    unlock(_10115,_9930).

substatem1(_9850,_9851,[substatem1,_9965,_9994,[],_10078,_10102,lit(det),_10137,_10161,!,_10195],_9948,_9950) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom],_9965,_9948,_9982),
    subordinate(_9907,_9908,_9909,_9994,_9982,_10015),
    pushstack(free,subordinate(_9907,_9908,_9909),nil,_10015,_10077),[],
    hvisaa0(_10078,_10077,_10093),
    has(_10102,_10093,_10117),
    cc(det,_10117,_10136),
    redundant0(_10137,_10136,_10152),
    w(verb(be,past,part),_10161,_10152,_10178),
    !,
    pushstack(first,w(verb(be,past,fin)),nil,_10178,_10205),
    itstatem(_9850,_9851,_10195,_10205,_9950).

substatem1(_9850,_9851,[substatem1,_9942,_9971,_10010,!,_10039],_9925,_9927) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom,da,'når'],_9942,_9925,_9959),
    subordinate(_9871,_9872,_9873,_9971,_9959,_9992),
    hvisaa0(_10010,_9992,_10025),
    !,
    lock(last,_10025,_10088),
    pushstack(last,(['så'],subordinate(_9871,_9872,_9873)),nil,_10088,_10094),
    statem(_9850,_9851,_10039,_10094,_10083),
    unlock(_10083,_9927).

substatem1(_9850,_9851,[substatem1,_9892],_9875,_9877) --> 
    substate(_9850,_9851,_9892,_9875,_9877).

hvisaa0([hvisaa0,lit('så'),!],_9870,_9872) --> 
    cc('så',_9870,_9872),
    !.

hvisaa0([hvisaa0,_9883,!],_9872,_9874) --> 
    look_ahead_lit([ble],_9883,_9872,_9874),
    !.

hvisaa0([hvisaa0,_9885,!],_9874,_9876) --> 
    look_ahead_lit([kan,'får'],_9885,_9874,_9876),
    !.

hvisaa0([hvisaa0,_9900,{}],_9889,_9891) --> 
    look_ahead(w(verb(_9855,_9871,fin)),_9900,_9889,_9891),
    {user:testmember(_9855,[avoid,be,come,have])}.

hvisaa0([hvisaa0,[]],_9865,_9865) --> 
    [].

sostatem(_9850,_9851,[sostatem,_9947,_9971,_10005,_10029,_10058,!,_10092,!],_9930,_9932) --> 
    faux1(_9947,_9930,_9962),
    subject(_9874,_9875,_9971,_9962,_9990),
    redundant0(_10005,_9990,_10020),
    negation0(_9877,_10029,_10020,_10046),
    w(verb(_9881,inf,fin),_10058,_10046,_10075),
    !,
    pushstack(first,(xnp(_9874,_9875),aux1,negation(_9877),w(verb(_9881,inf,fin))),nil,_10075,_10194),state(_9850,_9851,_10092,_10194,_9932),
    !.

sostatem(_9850,_9851,[sostatem,_9967,lit(det),_10007,_10036,lit(at),!,_10096,_10130],_9950,_9952) --> 
    w(verb(_9893,_9894,fin),_9967,_9950,_9984),
    cc(det,_9984,_10006),
    negation0(_9899,_10007,_10006,_10024),
    adj1(_9886,_9906:_9907,_9888,_9889,_10036,_10024,_10059),
    cc(at,_10059,_10090),
    !,
    clausal_object1(_9911,_9912,_10096,_10090,_10115),
    pushstack(first,(xnp(_9911,_9912),w(verb(_9893,_9894,fin)),negation(_9899),adj1(_9886,_9906:_9929,_9888,_9889)),nil,_10115,_10234),
    state(_9850,_9851,_10130,_10234,_9952).

sostatem(_9850,_9851,[sostatem,_9946,lit(det),_9981,_10005,_10034,_10063,_10097,!],_9929,_9931) --> 
    has(_9946,_9929,_9961),
    cc(det,_9961,_9980),
    preadverbials0(_9981,_9980,_9996),
    negation0(_9876,_10005,_9996,_10022),
    w(verb(_9880,past,part),_10034,_10022,_10051),
    subject(_9884,_9885,_10063,_10051,_10082),
    pushstack(first,(xnp(_9884,_9885),w(verb(_9880,past,fin)),negation(_9876)),nil,_10082,_10171),state(_9850,_9851,_10097,_10171,_9931),
    !.

sostatem(_9850,_9851,[sostatem,_9945,_9994,_10023,_10047,{},_10086,!],_9928,_9930) --> 
    lexvaccept(rv,_9872,_9873,fin,_9875,_9945,_9928,_9970),
    negation0(_9877,_9994,_9970,_10011),
    thereit(_10023,_10011,_10038),
    negation0(_9879,_10047,_10038,_10064),
    {user:bigno(_9877,_9879,_9875)},
    pushstack(first,([noe],w(verb(_9872,_9873,fin)),negation(_9875)),nil,_10064,_10129),state(_9850,_9851,_10086,_10129,_9930),
    !.

sostatem(_9850,_9851,[sostatem,_9949,_9978,_10007,_10041,{},_10080,!],_9932,_9934) --> 
    w(verb(_9873,_9874,fin),_9949,_9932,_9966),
    negation0(_9877,_9978,_9966,_9995),
    subject(_9879,_9880,_10007,_9995,_10026),
    negation0(_9882,_10041,_10026,_10058),
    {user:bigno(_9877,_9882,_9888)},
    pushstack(first,(xnp(_9879,_9880),w(verb(_9873,_9874,fin)),negation(_9888)),nil,_10058,_10154),state(_9850,_9851,_10080,_10154,_9934),
    !.

sostatem(_9850,_9851,[sostatem,_9931,_9960,_9984,_10013,!],_9914,_9916) --> 
    w(verb(_9867,_9868,pass),_9931,_9914,_9948),
    thereit0(_9960,_9948,_9975),
    negation0(_9871,_9984,_9975,_10001),
    pushstack(first,([noen],w(verb(_9867,_9868,fin)),negation(_9871)),nil,_10001,_10056),state(_9850,_9851,_10013,_10056,_9916),
    !.

sostatem(_9850,_9851,[sostatem,_9943,lit(det),_9978,{},!,_10022,!],_9926,_9928) --> 
    aux1(_9943,_9926,_9958),
    cc(det,_9958,_9977),
    w(verb(_9875,_9876,_9877),_9978,_9977,_9995),
    {user:(_9876=inf;_9877=part)},
    !,
    pushstack(first,([noe],w(verb(_9875,pres,fin))),nil,_9995,_10035),state(_9850,_9851,_10022,_10035,_9928),
    !.

sostatem(_9850,_9851,[sostatem,_9927,lit(det),_9962,!,_9996,!],_9910,_9912) --> 
    aux1(_9927,_9910,_9942),
    cc(det,_9942,_9961),
    w(verb(_9872,pres,pass),_9962,_9961,_9979),
    !,
    pushstack(first,(someone,w(verb(_9872,pres,fin))),nil,_9979,_10040),state(_9850,_9851,_9996,_10040,_9912),
    !.

sostatem(_9850,_9851,[sostatem,_9934,_9958,_9992,!,_10026,!],_9917,_9919) --> 
    aux1(_9934,_9917,_9949),
    object(_9868,_9869,_9958,_9949,_9977),
    w(verb(_9873,pres,pass),_9992,_9977,_10009),
    !,
    pushstack(first,(someone,w(verb(_9873,pres,fin)),xnp(_9868,_9869)),nil,_10009,_10098),state(_9850,_9851,_10026,_10098,_9919),
    !.

sostatem(_9850,_9851,[sostatem,_9936,_9965,{},lit(det),!,_10020,!],_9919,_9921) --> 
    not_look_ahead(['så'],_9936,_9919,_9953),
    w(verb(_9877,_9878,fin),_9965,_9953,_9982),
    {user:_9878\==inf},
    cc(det,_9982,_10014),
    !,
    pushstack(free,w(verb(_9877,pres,fin)),nil,_10014,_10033),state(_9850,_9851,_10020,_10033,_9921),
    !.

sostatem(_9850,_9851,[sostatem,_9934,_9958,_9992,!,_10026,!],_9917,_9919) --> 
    docan(_9934,_9917,_9949),
    subject(_9868,_9869,_9958,_9949,_9977),
    w(verb(_9873,pres,pass),_9992,_9977,_10009),
    !,
    pushstack(first,(someone,w(verb(_9873,pres,fin)),xnp(_9868,_9869)),nil,_10009,_10098),state(_9850,_9851,_10026,_10098,_9919),
    !.

statem(_9850,_9851,[statem,lit(det),_9961,_9990,_10024,!,_10058],_9933,_9935) --> 
    cc(det,_9933,_9960),
    w(verb(_9886,_9887,pass),_9961,_9960,_9978),
    gmem(_9886,[want,wish,need],_9990,_9978,_10009),
    negation0(_9899,_10024,_10009,_10041),
    !,
    pushstack(first,([noen],w(verb(_9886,_9887,fin)),negation(_9899),[dette]),nil,_10041,_10098),
    state(_9850,_9851,_10058,_10098,_9935).

statem(_9850,_9851,[statem,_9898,!,_9927],_9881,_9883) --> 
    preadverbials(_9898,_9881,_9913),
    !,
    prestatem(_9850,_9851,_9927,_9913,_9883).

statem(_9850,_9851,[statem,_9943,_9977,_10006,_10030,!,[],_10116],_9926,_9928) --> 
    obviousdate1(_9883,_9884,_9943,_9926,_9962),
    w(verb(_9879,_9880,fin),_9977,_9962,_9994),
    det0(_10006,_9994,_10021),
    subject(_9892,_9893,_10030,_10021,_10049),
    !,
    pushstack(free,obviousdate1(_9883,_9884),nil,_10049,_10115),[],
    pushstack(first,(xnp(_9892,_9893),w(verb(_9879,_9880,fin))),nil,_10115,_10157),
    state(_9850,_9851,_10116,_10157,_9928).

statem(_9850,_9851,[statem,_9937,_9971,_10000,!,_10049],_9920,_9922) --> 
    obviousdate1(_9874,_9875,_9937,_9920,_9956),
    w(verb(_9882,_9883,pass),_9971,_9956,_9988),
    optional([det],_10000,_9988,_10032),
    !,
    pushstack(free,([noen],w(verb(_9882,_9883,fin)),obviousdate1(_9874,_9875)),nil,_10032,_10090),
    state(_9850,_9851,_10049,_10090,_9922).

statem(_9850,_9851,[statem,_9984,_10018,_10047,_10081,_10115,_10144,lit(om),!,[],[],_10217],_9967,_9969) --> 
    lit_of(_9894,[det,dette],_9984,_9967,_10003),
    w(verb(_9903,_9904,fin),_10018,_10003,_10035),
    gmem(_9903,[worry],_10047,_10035,_10066),
    lit_of(_9912,[jeg,du,man],_10081,_10066,_10100),
    reflexiv0(_9903,_10115,_10100,_10132),
    negation0(_9892,_10144,_10132,_10161),
    cc(om,_10161,_10183),
    !,
    pushstack(free,[dette],nil,_10183,_10202),[],
    pushstack(free,[om],nil,_10202,_10216),[],
    pushstack(first,([_9912],w(verb(_9903,_9904,fin)),negation(_9892)),nil,_10216,_10257),
    state(_9850,_9851,_10217,_10257,_9969).

statem(_9850,_9851,[statem,_9978,_10012,_10041,_10075,lit(om),!,[],[],[],_10205],_9961,_9963) --> 
    lit_of(_9892,[det,dette],_9978,_9961,_9997),
    w(verb(_9888,_9889,fin),_10012,_9997,_10029),
    lit_of(_9905,[jeg,du,man],_10041,_10029,_10060),
    np_kernel(0,_9915,_9916,_10075,_10060,_10096),
    cc(om,_10096,_10124),
    !,
    pushstack(free,[dette],nil,_10124,_10143),[],
    pushstack(free,[om],nil,_10143,_10157),[],
    pushstack(free,np_kernel(0,_9915,_9916),nil,_10157,_10204),[],
    pushstack(first,([_9905],w(verb(_9888,_9889,fin))),nil,_10204,_10215),
    state(_9850,_9851,_10205,_10215,_9963).

statem(_9850,_9851,[statem,_9978,_10012,_10041,_10075,lit(om),!,[],[],[],_10204],_9961,_9963) --> 
    lit_of(_9892,[det,dette],_9978,_9961,_9997),
    w(verb(have,_9889,fin),_10012,_9997,_10029),
    lit_of(_9905,[jeg,du,man],_10041,_10029,_10060),
    np_kernel(0,_9915,_9916,_10075,_10060,_10096),
    cc(om,_10096,_10124),
    !,
    pushstack(free,[dette],nil,_10124,_10143),[],
    pushstack(free,[om],nil,_10143,_10157),[],
    pushstack(free,np_kernel(0,_9915,_9916),nil,_10157,_10203),[],
    pushstack(first,([_9905],w(verb(have,_9889,fin))),nil,_10203,_10214),
    state(_9850,_9851,_10204,_10214,_9963).

statem(_9850,_9851,[statem,_9970,_10009,lit(det),_10044,_10083,_10112,!,_10151],_9953,_9955) --> 
    preadverbial1(_9893,_9894,_9895,_9970,_9953,_9991),
    blei(_10009,_9991,_10024),
    cc(det,_10024,_10043),
    preadverbial0(_9889,_9890,_9891,_10044,_10043,_10065),
    w(verb(_9905,past,part),_10083,_10065,_10100),
    object(_9909,_9910,_10112,_10100,_10131),
    !,
    pushstack(first,(xnp(_9909,_9910),w(verb(be,pres,fin)),w(verb(_9905,past,part)),adverbial1(_9893,_9894,_9895),adverbial1(_9889,_9890,_9891)),nil,_10131,_10256),
    state(_9850,_9851,_10151,_10256,_9955).

statem(_9850,_9851,[statem,_10005,_10034,_10068,_10097,_10131,_10165,_10194,_10238,!,_10272],_9988,_9990) --> 
    not_look_ahead([det],_10005,_9988,_10022),
    obvious_object(_9898,_9899,_10034,_10022,_10053),
    w(verb(_9910,_9911,fin),_10068,_10053,_10085),
    gmem(_9910,[want,wish,need],_10097,_10085,_10116),
    lit_of(_9923,[jeg,vi,han,hun,du],_10131,_10116,_10150),
    negation0(_9936,_10165,_10150,_10182),
    optional(['å'],_10194,_10182,_10226),
    w(verb(_9944,inf,fin),_10238,_10226,_10255),
    !,
    pushstack(first,([_9923],w(verb(_9910,_9911,fin)),negation(_9936),['å'],w(verb(_9944,_9911,fin)),xnp(_9898,_9899)),nil,_10255,_10343),
    state(_9850,_9851,_10272,_10343,_9990).

statem(_9850,_9851,[statem,_9972,_10001,_10035,_10064,_10098,_10132,!,_10166],_9955,_9957) --> 
    not_look_ahead([det],_9972,_9955,_9989),
    obvious_object(_9883,_9884,_10001,_9989,_10020),
    w(verb(_9895,_9896,fin),_10035,_10020,_10052),
    gmem(_9895,[have,get],_10064,_10052,_10083),
    lit_of(_9906,[jeg,vi,han,hun,du],_10098,_10083,_10117),
    w(verb(_9921,past,part),_10132,_10117,_10149),
    !,
    pushstack(first,([_9906],w(verb(_9921,_9896,fin)),xnp(_9883,_9884)),nil,_10149,_10207),
    state(_9850,_9851,_10166,_10207,_9957).

statem(_9850,_9851,[statem,_9975,_10004,_10038,{},_10077,_10111,!,_10145],_9958,_9960) --> 
    not_look_ahead([det],_9975,_9958,_9992),
    obvious_object(_9886,_9887,_10004,_9992,_10023),
    w(verb(_9898,_9899,fin),_10038,_10023,_10055),
    {user:(\+testmember(_9898,[give]))},
    lit_of(_9911,[jeg,vi,han,hun,du],_10077,_10055,_10096),
    negation0(_9924,_10111,_10096,_10128),
    !,
    pushstack(first,([_9911],w(verb(_9898,_9899,fin)),negation(_9924),xnp(_9886,_9887)),nil,_10128,_10216),
    state(_9850,_9851,_10145,_10216,_9960).

statem(_9850,_9851,[statem,_10009,_10038,_10072,_10101,_10135,_10169,_10213,_10242,!,_10276],_9992,_9994) --> 
    not_look_ahead([det],_10009,_9992,_10026),
    obvious_object(_9898,_9899,_10038,_10026,_10057),
    w(verb(_9910,_9911,fin),_10072,_10057,_10089),
    gmem(_9910,[want,wish,need],_10101,_10089,_10120),
    lit_of(_9923,[jeg,vi,han,hun,du],_10135,_10120,_10154),
    optional(['å'],_10169,_10154,_10201),
    w(verb(_9942,inf,fin),_10213,_10201,_10230),
    w(prep(_9948),_10242,_10230,_10259),
    !,
    pushstack(first,([_9923],w(verb(_9910,_9911,fin)),['å'],w(verb(_9942,_9911,fin)),w(prep(_9948)),xnp(_9898,_9899)),nil,_10259,_10317),
    state(_9850,_9851,_10276,_10317,_9994).

statem(_9850,_9851,[statem,_9953,lit(kan),_9998,_10032,!,_10066],_9936,_9938) --> 
    obvious_object(_9877,_9878,_9953,_9936,_9972),
    cc(kan,_9972,_9997),
    lit_of(_9885,[jeg,vi,han,hun,du],_9998,_9997,_10017),
    not_look_ahead(w(verb(_9902,_9903,_9904)),_10032,_10017,_10049),
    !,
    pushstack(first,([_9885],w(verb(do1,pres,fin)),xnp(_9877,_9878)),nil,_10049,_10107),
    state(_9850,_9851,_10066,_10107,_9938).

statem(_9850,_9851,[statem,_9956,_9985,_10019,_10043,_10077,!,_10111],_9939,_9941) --> 
    not_look_ahead([det],_9956,_9939,_9973),
    obvious_object(_9880,_9881,_9985,_9973,_10004),
    aux1(_10019,_10004,_10034),
    lit_of(_9890,[jeg,vi,han,hun,du],_10043,_10034,_10062),
    w(verb(_9905,inf,fin),_10077,_10062,_10094),
    !,
    pushstack(first,([_9890],w(verb(_9905,pres,fin)),xnp(_9880,_9881)),nil,_10094,_10152),
    state(_9850,_9851,_10111,_10152,_9941).

statem(_9850,_9851,[statem,_9956,_9985,_10019,_10043,_10077,!,_10111],_9939,_9941) --> 
    not_look_ahead([det],_9956,_9939,_9973),
    obvious_object(_9880,_9881,_9985,_9973,_10004),
    aux1(_10019,_10004,_10034),
    lit_of(_9890,[jeg,vi,han,hun,du],_10043,_10034,_10062),
    w(verb(_9905,inf,fin),_10077,_10062,_10094),
    !,
    pushstack(first,([_9890],w(verb(_9905,pres,fin)),xnp(_9880,_9881)),nil,_10094,_10152),
    state(_9850,_9851,_10111,_10152,_9941).

statem(_9850,_9851,[statem,lit(det),lit(som),!,_9952],_9908,_9910) --> 
    cc(det,_9908,_9935),
    cc(som,_9935,_9946),
    !,
    pushstack(first,([en],w(noun(thing,sin,u,n)),[som]),nil,_9946,_9962),
    state(_9850,_9851,_9952,_9962,_9910).

statem(_9850,_9851,[statem,_9946,_9975,_9999,lit('å'),!,_10044],_9929,_9931) --> 
    one_of_lit(['nå','så',da,redundant0],_9946,_9929,_9963),
    shoulditbe(_9975,_9963,_9990),
    w(adj2(_9891,_9892),_9999,_9990,_10016),
    cc('å',_10016,_10038),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_9891,_9892)),['å']),nil,_10038,_10054),
    itstatem(_9850,_9851,_10044,_10054,_9931).

statem(_9850,_9851,[statem,_9918,_9947,_9971,!],_9901,_9903) --> 
    one_of_lit(['nå','så',da],_9918,_9901,_9935),
    shoulditbe(_9947,_9935,_9962),
    pushstack(first,w(verb(be,pres,fin)),nil,_9962,_9984),itstatem(_9850,_9851,_9971,_9984,_9903),
    !.

shoulditbe([shoulditbe,_9890,_9919,lit(det)],_9879,_9881) --> 
    w(verb(be,_9861,fin),_9890,_9879,_9907),
    redundant0(_9919,_9907,_9934),
    cc(det,_9934,_9881).

shoulditbe([shoulditbe,_9893,_9917,lit(det),_9952],_9882,_9884) --> 
    aux1(_9893,_9882,_9908),
    redundant0(_9917,_9908,_9932),
    cc(det,_9932,_9951),
    w(verb(be,inf,fin),_9952,_9951,_9884).

shoulditbe([shoulditbe,_9894,lit(det),_9934],_9883,_9885) --> 
    one_of_lit([kan,kunne,'får',fikk],_9894,_9883,_9911),
    cc(det,_9911,_9933),
    vaere(_9934,_9933,_9885).

vaere([vaere,_9886],_9875,_9877) --> 
    one_of_lit(['være','vært',bli,blitt],_9886,_9875,_9877).

statem(_9850,_9851,[statem,lit(det),_9969,_9993,_10027,{},{},!,_10081],_9941,_9943) --> 
    cc(det,_9941,_9968),
    aux1(_9969,_9968,_9984),
    subject(_9887,_9888,_9993,_9984,_10012),
    w(verb(_9892,inf,fin),_10027,_10012,_10044),
    {user:testmember(_9892,[believe,know])},
    {user:verbtype(_9892,rv)},
    !,
    pushstack(first,(xnp(_9887,_9888),w(verb(_9892,pres,fin)),[dette]),nil,_10044,_10122),
    state(_9850,_9851,_10081,_10122,_9943).

statem(_9850,_9851,[statem,_9962,_9996,{},{},_10045,!,_10084],_9945,_9947) --> 
    obvious_object(_9883,_9884,_9962,_9945,_9981),
    w(verb(_9891,_9892,fin),_9996,_9981,_10013),
    {user:testmember(_9891,[believe,know])},
    {user:verbtype(_9891,rv)},
    subject(_9909,_9910,_10045,_10013,_10064),
    !,
    pushstack(first,(xnp(_9909,_9910),w(verb(_9891,_9892,fin)),[at],xnp(_9883,_9884)),nil,_10064,_10156),
    state(_9850,_9851,_10084,_10156,_9947).

statem(_9850,_9851,[statem,_9940,_9974,_9998,_10032,!,_10066],_9923,_9925) --> 
    obvious_object(_9877,_9878,_9940,_9923,_9959),
    has(_9974,_9959,_9989),
    subject(_9883,_9884,_9998,_9989,_10017),
    w(verb(_9888,past,part),_10032,_10017,_10049),
    !,
    pushstack(first,(xnp(_9883,_9884),w(verb(_9888,past,fin)),xnp(_9877,_9878)),nil,_10049,_10138),
    state(_9850,_9851,_10066,_10138,_9925).

statem(_9850,_9851,[statem,lit('å'),_9963,_9992,_10035,!,_10069],_9935,_9937) --> 
    cc('å',_9935,_9962),
    w(verb(_9881,inf,fin),_9963,_9962,_9980),
    pushstack(first,([noen],w(verb(_9881,pres,fin))),nil,_9980,_10005),clausal_object1(_9871,_9874::_9875,_9992,_10005,_10020),
    look_ahead(w(verb(be,pres,fin)),_10035,_10020,_10052),
    !,
    pushstack(first,xnp(_9871,_9874::_9875),nil,_10052,_10110),
    state(_9850,_9851,_10069,_10110,_9937).

statem(_9850,_9851,[statem,lit(det),_9965,lit(seg),_10005,_10034,lit('å'),!,_10079,!],_9937,_9939) --> 
    cc(det,_9937,_9964),
    w(verb(let,_9882,fin),_9965,_9964,_9982),
    cc(seg,_9982,_10004),
    negation0(_9887,_10005,_10004,_10022),
    w(verb(do1,inf,fin),_10034,_10022,_10051),
    cc('å',_10051,_10073),
    !,
    pushstack(first,(w(noun(agent,sin,u,n)),aux1,negation(_9887)),nil,_10073,_10150),state(_9850,_9851,_10079,_10150,_9939),
    !.

statem(_9850,_9851,[statem,_9895,_9919],_9878,_9880) --> 
    soredundant(_9895,_9878,_9910),
    sostatem(_9850,_9851,_9919,_9910,_9880).

statem(_9850,_9851,[statem,_9945,_9974,{},_10013,_10052],_9928,_9930) --> 
    w(noun(_9877,_9878,_9879,n),_9945,_9928,_9962),
    look_ahead(w(prep(_9871)),_9974,_9962,_9991),
    {user:testmember(_9871,[at])},
    pp(_9871,_9872,_9873,_10013,_9991,_10034),
    pushstack(free,(w(noun(_9877,_9878,_9879,n)),pp(_9871,_9872,_9873)),nil,_10034,_10095),
    state(_9850,_9851,_10052,_10095,_9930).

statem(_9850,_9851,[statem,_9969,_10003,{},_10042,_10076,!,_10110,!],_9952,_9954) --> 
    lit_of(_9874,[dette],_9969,_9952,_9988),
    w(verb(_9881,_9882,fin),_10003,_9988,_10020),
    {user:(\+testmember(_9881,[be,give,take,cost]))},
    subject(_9900,_9901,_10042,_10020,_10061),
    negation0(_9903,_10076,_10061,_10093),
    !,
    pushstack(first,(xnp(_9900,_9901),w(verb(_9881,_9882,fin)),negation(_9903),[_9874]),nil,_10093,_10184),state(_9850,_9851,_10110,_10184,_9954),
    !.

statem(_9850,_9851,[statem,_9961,{},_10000,!,_10034],_9944,_9946) --> 
    w(adj2(_9883,nil),_9961,_9944,_9978),
    {user:testmember(_9883,[good,bad,correct,true,mild,hot,cold])},
    w(prep(_9879),_10000,_9978,_10017),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_9883,nil)),w(prep(_9879))),nil,_10017,_10044),
    state(_9850,_9851,_10034,_10044,_9946).

statem(_9850,_9851,[statem,_9961,{},_10000,!,_10034],_9944,_9946) --> 
    w(adj2(_9883,nil),_9961,_9944,_9978),
    {user:testmember(_9883,[good,bad,correct,true,mild,hot,cold])},
    w(adv(_9879),_10000,_9978,_10017),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_9883,nil)),w(adv(_9879))),nil,_10017,_10044),
    state(_9850,_9851,_10034,_10044,_9946).

statem(_9850,_9851,[statem,_9925,_9949,_9978,!,_10012,!,_10090],_9908,_9910) --> 
    init(_9925,_9908,_9940),
    negation(_9871,_9949,_9940,_9966),
    not_look_ahead(w(verb(_9877,_9878,pass)),_9978,_9966,_9995),
    !,
    pushstack(free,negation(_9871),nil,_9995,_10055),itstatem(_9850,_9851,_10012,_10055,_10070),
    !,
    accept(_10090,_10070,_9910).

statem(_9850,_9851,[statem,_9934,_9958,_9982,_10006,_10035,!,[],_10088],_9917,_9919) --> 
    redundants0(_9934,_9917,_9949),
    dette(_9958,_9949,_9973),
    aux1(_9982,_9973,_9997),
    not_look_ahead(['være'],_10006,_9997,_10023),
    obvious_object(_9884,_9885,_10035,_10023,_10054),
    !,
    pushstack(free,[dette],nil,_10054,_10087),[],
    pushstack(first,(xnp(_9884,_9885),aux1),nil,_10087,_10157),
    state(_9850,_9851,_10088,_10157,_9919).

statem(_9850,_9851,[statem,_9904,!,_9933,!,_9972],_9887,_9889) --> 
    init(_9904,_9887,_9919),
    !,
    itstatem(_9850,_9851,_9933,_9919,_9952),
    !,
    accept(_9972,_9952,_9889).

statem(_9850,_9853::_9854,[statem,_9904,!,_9943],_9887,_9889) --> 
    state(_9850,_9853::_9854,_9904,_9887,_9923),
    !,
    accept(_9943,_9923,_9889).

statem(_9850,_9853::_9854,[statem,_9997,_10031,_10060,_10084,_10113,lit('å'),{},[],{},_10218,{}],_9980,_9982) --> 
    subject(_9892,_9893,_9997,_9980,_10016),
    be(_9888,_10031,_10016,_10048),
    so0(_10060,_10048,_10075),
    gradverb0(_9897,_10084,_10075,_10101),
    w(adj2(_9901,nil),_10113,_10101,_10130),
    cc('å',_10130,_10152),
    {user:testmember(_9901,[difficult,easy,expensive,free,funny,good,intelligent,sad,stupid,tedious])},
    pushstack(free,xnp(_9892,_9893),nil,_10152,_10207),[],
    {user:it_template(_9939)},
    pushstack(first,(w(adj2(_9901,nil)),['å']),nil,_10207,_10231),be_complements(_9939,_9850,_9853::_9889,_10218,_10231,_9982),
    {user:negate(_9888,_9889,_9854)}.

statem(_9850,_9853::_9854,[statem,_9952,_9986,_10010,{},!,_10054,_10078],_9935,_9937) --> 
    np1_accept(_9885,_9886,_9952,_9935,_9971),
    aux1(_9986,_9971,_10001),
    prepnof(_9888,_10010,_10001,_10027),
    {user:testmember(_9888,[on,to,towards])},
    !,
    accept(_10054,_10027,_10069),
    pushstack(first,(np(_9885,_9886),w(verb(go,pres,fin)),prep(to)),nil,_10069,_10152),
    state(_9850,_9853::_9854,_10078,_10152,_9937).

statem(_9850,_9853::_9854,[statem,_9966,_9995,_10024,_10058,_10082,{},_10121],_9949,_9951) --> 
    not_look_ahead([dette],_9966,_9949,_9983),
    not_look_ahead([det],_9995,_9983,_10012),
    np1_accept(_9893,_9894,_10024,_10012,_10043),
    aux1(_10058,_10043,_10073),
    prepnof(_9883,_10082,_10073,_10099),
    {user:testmember(_9883,[to,from,near,in,on,past])},
    pushstack(first,(np(_9893,_9894),w(verb(go,pres,fin)),prep(_9883)),nil,_10099,_10193),
    state(_9850,_9853::_9854,_10121,_10193,_9951).

statem(_9850,_9853::_9854,[statem,_9968,_9997,_10026,_10060,_10089,_10113,_10142,_10171,_10200],_9951,_9953) --> 
    not_look_ahead([dette],_9968,_9951,_9985),
    not_look_ahead([det],_9997,_9985,_10014),
    np1_accept(_9900,_9901,_10026,_10014,_10045),
    not_look_ahead([kan],_10060,_10045,_10077),
    aux1(_10089,_10077,_10104),
    look_ahead([hjem],_10113,_10104,_10130),
    not_look_ahead([kunne],_10142,_10130,_10159),
    not_look_ahead(w(verb(_9919,_9920,_9921)),_10171,_10159,_10188),
    pushstack(first,(np(_9900,_9901),w(verb(go,pres,fin))),nil,_10188,_10241),
    state(_9850,_9853::_9854,_10200,_10241,_9953).

statem(_9850,_9851,[statem,_9921,_9945,_9969,[],_10017],_9904,_9906) --> 
    dedette(_9921,_9904,_9936),
    aux1(_9945,_9936,_9960),
    np1_accept(_9871,_9872,_9969,_9960,_9988),
    pushstack(free,[dette],nil,_9988,_10016),[],
    pushstack(first,(xnp(_9871,_9872),aux1),nil,_10016,_10086),
    state(_9850,_9851,_10017,_10086,_9906).

dedette([dedette,lit(det)],_9867,_9869) --> 
    cc(det,_9867,_9869).

dedette([dedette,lit(dette)],_9867,_9869) --> 
    cc(dette,_9867,_9869).

soredundant0([soredundant0,_9879,!],_9868,_9870) --> 
    soredundant(_9879,_9868,_9870),
    !.

soredundant([soredundant,lit('når'),!],_9870,_9872) --> 
    cc('når',_9870,_9872),
    !.

soredundant([soredundant,_9879,!],_9868,_9870) --> 
    so(_9879,_9868,_9870),
    !.

soredundant([soredundant,_9876],_9865,_9867) --> 
    redundant(_9876,_9865,_9867).

so([so,lit('så'),!],_9870,_9872) --> 
    cc('så',_9870,_9872),
    !.

so([so,lit(derfor),!],_9870,_9872) --> 
    cc(derfor,_9870,_9872),
    !.

so([so,_9888],_9877,_9879) --> 
    look_ahead_lit([kan,'må',vil,skal,'bør'],_9888,_9877,_9879).

so([so,_9884],_9873,_9875) --> 
    look_ahead(w(verb(know,_9855,fin)),_9884,_9873,_9875).

statem(_9850,_9853::_9854,[statem,_9942,_9981,lit(kan),_10016,_10040,_10074,_10098],_9925,_9927) --> 
    adverbx(_9883,_9884,pre,_9942,_9925,_9963),
    saa0(_9981,_9963,_9996),
    cc(kan,_9996,_10015),
    redundant0(_10016,_10015,_10031),
    np1_accept(_9892,_9893,_10040,_10031,_10059),
    redundant0(_10074,_10059,_10089),
    pushstack(free,(noun_phrase1(_9892,_9893),[kan],xadverb(_9883,_9884)),nil,_10089,_10174),
    state(_9850,_9853::_9854,_10098,_10174,_9927).

statem(_9850,_9853::_9854,[statem,_9938,_9977,_10001,_10025,_10049,_10083,_10107],_9921,_9923) --> 
    adverbx(_9883,_9884,pre,_9938,_9921,_9959),
    saa0(_9977,_9959,_9992),
    aux1(_10001,_9992,_10016),
    redundant0(_10025,_10016,_10040),
    np1_accept(_9890,_9891,_10049,_10040,_10068),
    redundant0(_10083,_10068,_10098),
    pushstack(free,(noun_phrase1(_9890,_9891),aux1,xadverb(_9883,_9884)),nil,_10098,_10207),
    state(_9850,_9853::_9854,_10107,_10207,_9923).

statem(_9850,_9853::_9854,[statem,_9941,_9980,_10004,lit(jeg),_10039,!,_10068,_10092],_9924,_9926) --> 
    adverbx(_9886,_9887,pre,_9941,_9924,_9962),
    saa0(_9980,_9962,_9995),
    aux1(_10004,_9995,_10019),
    cc(jeg,_10019,_10038),
    redundant0(_10039,_10038,_10054),
    !,
    accept(_10068,_10054,_10083),
    pushstack(free,([jeg],[skal],xadverb(_9886,_9887)),nil,_10083,_10133),
    state(_9850,_9853::_9854,_10092,_10133,_9926).

statem(_9850,_9853::_9854,[statem,lit(at),_9928,_9962,{}],_9900,_9902) --> 
    cc(at,_9900,_9927),
    statem(_9850,_9853::_9868,_9928,_9927,_9947),
    be_truefalse(_9867,_9962,_9947,_9902),
    {user:negate(_9867,_9868,_9854)}.

statem(_9850,_9853::_9854,[statem,_9942,_9981,_10005,_10034,_10063],_9925,_9927) --> 
    adverbx(_9877,_9878,pre,_9942,_9925,_9963),
    saa0(_9981,_9963,_9996),
    w(verb(_9886,_9887,_9888),_10005,_9996,_10022),
    negation0(_9890,_10034,_10022,_10051),
    lock(last,_10051,_10141),
    pushstack(last,(w(verb(_9886,_9887,_9888)),negation(_9890),xadverb(_9877,_9878)),nil,_10141,_10147),
    state(_9850,_9853::_9854,_10063,_10147,_10136),
    unlock(_10136,_9927).

statem(_9850,_9853::_9854,[statem,_9953,_9992,_10021,_10055,!,_10089],_9936,_9938) --> 
    adverbx(_9880,_9881,pre,_9953,_9936,_9974),
    w(verb(be,_9890,fin),_9992,_9974,_10009),
    np1_accept(_9893,_9894,_10021,_10009,_10040),
    w(verb(_9898,_9899,part),_10055,_10040,_10072),
    !,
    lock(last,_10072,_10168),
    pushstack(last,(np(_9893,_9894),w(verb(_9898,_9899,fin)),xadverb(_9880,_9881)),nil,_10168,_10174),
    state(_9850,_9853::_9854,_10089,_10174,_10163),
    unlock(_10163,_9938).

statem(_9850,_9853::_9854,[statem,_9945,_9984,_10008,_10042,!,_10076],_9928,_9930) --> 
    adverbx(_9880,_9881,pre,_9945,_9928,_9966),
    be(_9984,_9966,_9999),
    specific_phrase(_9887,_9890::_9891,_10008,_9999,_10027),
    negation0(_9893,_10042,_10027,_10059),
    !,
    pushstack(free,(np(_9887,_9890::_9891),be(_9893),xadverb(_9880,_9881)),nil,_10059,_10181),
    state(_9850,_9853::_9854,_10076,_10181,_9930).

statem(_9850,_9853::_9854,[statem,_9933,_9972,_10001,!,_10035],_9916,_9918) --> 
    adverbx(_9874,_9875,pre,_9933,_9916,_9954),
    w(verb(be,_9884,fin),_9972,_9954,_9989),
    negation0(_9887,_10001,_9989,_10018),
    !,
    pushstack(free,(be(_9887),xadverb(_9874,_9875)),nil,_10018,_10106),
    state(_9850,_9853::_9854,_10035,_10106,_9918).

statem(_9850,_9853::_9854,[statem,_9917,_9956,_9980,_10004],_9900,_9902) --> 
    adverbx(_9868,_9869,pre,_9917,_9900,_9938),
    saa0(_9956,_9938,_9971),
    doit(_9980,_9971,_9995),
    pushstack(free,xadverb(_9868,_9869),nil,_9995,_10045),
    state(_9850,_9853::_9854,_10004,_10045,_9902).

statem(_9850,_9851,[statem,_9938,_9977,_10001,_10035,_10064],_9921,_9923) --> 
    adverbx(_9874,_9875,pre,_9938,_9921,_9959),
    has(_9977,_9959,_9992),
    specific_phrase(_9881,_9882,_10001,_9992,_10020),
    w(verb(_9886,past,part),_10035,_10020,_10052),
    lock(last,_10052,_10143),
    pushstack(last,(xnp(_9881,_9882),w(verb(_9886,past,fin)),xadverb(_9874,_9875)),nil,_10143,_10149),
    state(_9850,_9851,_10064,_10149,_10138),
    unlock(_10138,_9923).

statem(_9850,_9851,[statem,_9924,_9963,_9992],_9907,_9909) --> 
    preadverbial1(_9865,_9866,_9867,_9924,_9907,_9945),
    w(verb(be,pres,fin),_9963,_9945,_9980),
    pushstack(free,(w(verb(be,pres,fin)),adverbial1(_9865,_9866,_9867)),nil,_9980,_10034),
    state(_9850,_9851,_9992,_10034,_9909).

statem(_9850,_9851,[statem,_9904,_9928,!,_9957,_9981],_9887,_9889) --> 
    preadverbials0(_9904,_9887,_9919),
    aux1(_9928,_9919,_9943),
    !,
    accept(_9957,_9943,_9972),
    state(_9850,_9851,_9981,_9972,_9889).

statem(_9850,_9853::_9854,[statem,_9930,_9969,!,_9998],_9913,_9915) --> 
    adverbial1(_9874,_9875,_9878::_9879,_9930,_9913,_9951),
    be(_9969,_9951,_9984),
    !,
    pushstack(free,(thereit,be,adverbial1(_9874,_9875,_9878::_9879)),nil,_9984,_10103),
    statem(_9850,_9853::_9854,_9998,_10103,_9915).

statem(_9850,_9853::_9854,[statem,_9965,_10004,_10028,_10062,!,_10096],_9948,_9950) --> 
    preadverbial1(_9883,_9884,_9887::_9888,_9965,_9948,_9986),
    doit(_10004,_9986,_10019),
    specific_phrase(_9897,_9900::_9901,_10028,_10019,_10047),
    w(prep(_9905),_10062,_10047,_10079),
    !,
    pushstack(free,(np(_9897,_9900::_9901),w(verb(go,pres,fin)),w(prep(_9905)),adverbial1(_9883,_9884,_9887::_9888)),nil,_10079,_10175),
    state(_9850,_9853::_9854,_10096,_10175,_9950).

statem(_9850,_9853::_9854,[statem,_9924,_9963,!,_9992],_9907,_9909) --> 
    preadverbial1(_9868,_9869,_9872::_9873,_9924,_9907,_9945),
    doit(_9963,_9945,_9978),
    !,
    pushstack(free,adverbial1(_9868,_9869,_9872::_9873),nil,_9978,_10037),
    state(_9850,_9853::_9854,_9992,_10037,_9909).

statem(_9850,_9851,[statem,_9942,_9981,_10005,_10034,!,_10073],_9925,_9927) --> 
    preadverbial1(_9877,_9878,_9879,_9942,_9925,_9963),
    so0(_9981,_9963,_9996),
    w(verb(have,_9888,fin),_10005,_9996,_10022),
    subject(_9891,_9892,_10034,_10022,_10053),
    !,
    pushstack(free,(xnp(_9891,_9892),w(verb(have,_9888,fin)),adverbial1(_9877,_9878,_9879)),nil,_10053,_10146),
    state(_9850,_9851,_10073,_10146,_9927).

statem(_9850,_9853::_9854,[statem,{},_9981,_10020,_10059,!,_10108,_10132],_9954,_9956) --> 
    {user:value(dialog,1)},
    preadverbial1(_9898,_9899,_9902::_9903,_9981,_9954,_10002),
    preadverbial1(_9883,_9884,_9887::_9888,_10020,_10002,_10041),
    lexv(_9912,_9913,_9914,fin,_10059,_10041,_10082),
    !,
    accept(_10108,_10082,_10123),
    lock(last,_10123,_10250),
    pushstack(last,(lexv(_9912,_9913,_9914,fin),adverbial1(_9898,_9899,_9902::_9903),adverbial1(_9883,_9884,_9887::_9888)),nil,_10250,_10256),
    state(_9850,_9853::_9854,_10132,_10256,_10245),
    unlock(_10245,_9956).

prestatem(_9850,_9851,[prestatem,_9944,_9973,lit(det),_10018,!,_10052],_9927,_9929) --> 
    w(verb(_9881,_9882,fin),_9944,_9927,_9961),
    gmem(_9881,[be,stand],_9973,_9961,_9992),
    cc(det,_9992,_10017),
    w(adj2(_9876,_9877),_10018,_10017,_10035),
    !,
    pushstack(first,(w(verb(be,_9882,fin)),w(adj2(_9876,_9877))),nil,_10035,_10062),
    itstatem(_9850,_9851,_10052,_10062,_9929).

prestatem(_9850,_9851,[prestatem,_9971,_9995,_10019,_10048,_10072,_10106,_10130,{},_10169,!,_10208],_9954,_9956) --> 
    so0(_9971,_9954,_9986),
    aux1(_9995,_9986,_10010),
    negation0(_9898,_10019,_10010,_10036),
    redundant0(_10048,_10036,_10063),
    object(_9895,_9896,_10072,_10063,_10091),
    redundant0(_10106,_10091,_10121),
    w(verb(_9905,_9906,pass),_10130,_10121,_10147),
    {user:(\+testmember(_9905,[be]))},
    whodidit(_9918,_9919,_10169,_10147,_10188),
    !,
    pushstack(first,(xnp(_9918,_9919),w(verb(_9905,_9906,fin)),negation(_9898),xnp(_9895,_9896)),nil,_10188,_10310),
    state(_9850,_9851,_10208,_10310,_9956).

prestatem(_9850,_9851,[prestatem,_9931,_9955,_9984,!,_10028],_9914,_9916) --> 
    shoulditbe(_9931,_9914,_9946),
    not_look_ahead(w(adj2(_9879,_9880)),_9955,_9946,_9972),
    adverbix0(_9871,_9872,_9873,_9984,_9972,_10005),
    !,
    pushstack(free,(w(verb(be,pres,fin)),xadverbial1(_9871,_9872,_9873)),nil,_10005,_10070),
    itstatem(_9850,_9851,_10028,_10070,_9916).

prestatem(_9850,_9851,[prestatem,_9912,lit(det),_9952,!,_9981],_9895,_9897) --> 
    w(verb(be,_9871,fin),_9912,_9895,_9929),
    cc(det,_9929,_9951),
    slikat(_9952,_9951,_9967),
    !,
    state(_9850,_9851,_9981,_9967,_9897).

prestatem(_9850,_9851,[prestatem,_9955,_9984,lit(det),_10029,_10053,_10082,!,_10111,_10145],_9938,_9940) --> 
    w(verb(_9891,_9892,fin),_9955,_9938,_9972),
    gmem(_9891,[have,be],_9984,_9972,_10003),
    cc(det,_10003,_10028),
    redundant0(_10029,_10028,_10044),
    w(verb(_9885,past,part),_10053,_10044,_10070),
    look_ahead_np(_10082,_10070,_10097),
    !,
    subject(_9910,_9911,_10111,_10097,_10130),
    pushstack(first,(xnp(_9910,_9911),w(verb(_9885,past,fin))),nil,_10130,_10186),
    state(_9850,_9851,_10145,_10186,_9940).

prestatem(_9850,_9851,[prestatem,_9940,_9964,_9998,_10027,!,_10066],_9923,_9925) --> 
    has(_9940,_9923,_9955),
    subject(_9880,_9881,_9964,_9955,_9983),
    w(verb(_9885,past,part),_9998,_9983,_10015),
    object(_9877,_9878,_10027,_10015,_10046),
    !,
    pushstack(first,(xnp(_9880,_9881),w(verb(_9885,past,fin)),xnp(_9877,_9878)),nil,_10046,_10138),
    state(_9850,_9851,_10066,_10138,_9925).

prestatem(_9850,_9851,[prestatem,_9958,{},_9997,_10031,_10060,!,_10099],_9941,_9943) --> 
    w(verb(_9885,_9886,fin),_9958,_9941,_9975),
    {user:(\+member(_9885,[]))},
    subject(_9896,_9897,_9997,_9975,_10016),
    not_look_ahead(w(verb(_9903,_9904,_9905)),_10031,_10016,_10048),
    object(_9880,_9881,_10060,_10048,_10079),
    !,
    pushstack(first,(xnp(_9896,_9897),w(verb(_9885,past,fin)),xnp(_9880,_9881)),nil,_10079,_10171),
    state(_9850,_9851,_10099,_10171,_9943).

prestatem(_9850,_9851,[prestatem,_9961,_9990,_10019,_10043,lit(det),_10083,_10107,!,_10141],_9944,_9946) --> 
    not_look_ahead(w(verb(be,_9893,_9894)),_9961,_9944,_9978),
    not_look_ahead(w(verb(be1,_9901,_9902)),_9990,_9978,_10007),
    so0(_10019,_10007,_10034),
    w(verb(_9906,_9907,fin),_10043,_10034,_10060),
    cc(det,_10060,_10082),
    not_look_ahead_np(_10083,_10082,_10098),
    negation0(_9886,_10107,_10098,_10124),
    !,
    pushstack(first,([dette],w(verb(_9906,_9907,fin)),negation(_9886)),nil,_10124,_10181),
    state(_9850,_9851,_10141,_10181,_9946).

prestatem(_9850,_9851,[prestatem,_9957,_9986,_10015,_10039,_10068,_10092,_10126,!,_10160],_9940,_9942) --> 
    not_look_ahead(w(verb(be,_9890,_9891)),_9957,_9940,_9974),
    not_look_ahead(w(verb(be1,_9898,_9899)),_9986,_9974,_10003),
    so0(_10015,_10003,_10030),
    w(verb(_9903,_9904,fin),_10039,_10030,_10056),
    det0(_10068,_10056,_10083),
    particlev0(_9903,_9908,_10092,_10083,_10111),
    negation0(_9883,_10126,_10111,_10143),
    !,
    pushstack(free,(w(verb(_9908,_9904,fin)),negation(_9883)),nil,_10143,_10200),
    state(_9850,_9851,_10160,_10200,_9942).

prestatem(_9850,_9851,[prestatem,_9958,_9982,{},_10021,_10045,!,_10079,_10113],_9941,_9943) --> 
    so0(_9958,_9941,_9973),
    w(verb(_9891,_9892,pass),_9982,_9973,_9999),
    {user:(\+testmember(_9891,[be]))},
    thereit0(_10021,_9999,_10036),
    negation0(_9904,_10045,_10036,_10062),
    !,
    object(_9886,_9887,_10079,_10062,_10098),
    pushstack(first,([noen],w(verb(_9891,_9892,fin)),negation(_9904),xnp(_9886,_9887)),nil,_10098,_10184),
    state(_9850,_9851,_10113,_10184,_9943).

prestatem(_9850,_9851,[prestatem,_9935,_9964,!,_9998,_10032],_9918,_9920) --> 
    w(verb(be,_9879,fin),_9935,_9918,_9952),
    negation0(_9874,_9964,_9952,_9981),
    !,
    subject(_9884,_9885,_9998,_9981,_10017),
    pushstack(first,(xnp(_9884,_9885),w(verb(be,_9879,fin)),negation(_9874)),nil,_10017,_10103),
    state(_9850,_9851,_10032,_10103,_9920).

prestatem(_9850,_9851,[prestatem,_9945,lit(kan),_9980,_10014,_10038,_10067,!,_10101],_9928,_9930) --> 
    so0(_9945,_9928,_9960),
    cc(kan,_9960,_9979),
    subject(_9888,_9889,_9980,_9979,_9999),
    redundant0(_10014,_9999,_10029),
    not_look_ahead(w(verb(_9895,_9896,_9897)),_10038,_10029,_10055),
    not_look_ahead([ikke],_10067,_10055,_10084),
    !,
    pushstack(free,(xnp(_9888,_9889),w(verb(do1,pres,fin))),nil,_10084,_10142),
    state(_9850,_9851,_10101,_10142,_9930).

prestatem(_9850,_9851,[prestatem,_9926,_9950,_9974,_10008,!,_10042],_9909,_9911) --> 
    so0(_9926,_9909,_9941),
    aux1(_9950,_9941,_9965),
    subject(_9879,_9880,_9974,_9965,_9993),
    negation0(_9877,_10008,_9993,_10025),
    !,
    pushstack(free,(xnp(_9879,_9880),aux1,negation(_9877)),nil,_10025,_10141),
    state(_9850,_9851,_10042,_10141,_9911).

itstatem(_9850,_9851,[itstatem,_9942,_9966,lit(at),_10011,!,_10050,_10084],_9925,_9927) --> 
    be(_9942,_9925,_9957),
    np0_accept(_9880,_9881,_9966,_9957,_9985),
    cc(at,_9985,_10010),
    traceprint(4,it00,_10011,_10010,_10030),
    !,
    clausal_object1(_9891,_9892,_10050,_10030,_10069),
    pushstack(first,(xnp(_9891,_9892),w(verb(be,pres,fin)),xnp(_9880,_9881)),nil,_10069,_10156),
    state(_9850,_9851,_10084,_10156,_9927).

itstatem(_9850,_9851,[itstatem,_9926,_9950,_9979,_10003,!,_10042],_9909,_9911) --> 
    be(_9926,_9909,_9941),
    not_look_ahead(w(adj2(_9881,_9882)),_9950,_9941,_9967),
    look_ahead_np(_9979,_9967,_9994),
    traceprint(4,it01,_10003,_9994,_10022),
    !,
    pushstack(free,w(verb(exist,pres,fin)),nil,_10022,_10052),
    state(_9850,_9851,_10042,_10052,_9911).

itstatem(_9850,_9851,[itstatem,_9930,{},_9969,_9993,!,_10032],_9913,_9915) --> 
    w(verb(_9873,_9874,fin),_9930,_9913,_9947),
    {user:_9873\==be},
    look_ahead_np(_9969,_9947,_9984),
    traceprint(4,it02,_9993,_9984,_10012),
    !,
    pushstack(free,w(verb(_9873,_9874,fin)),nil,_10012,_10042),
    state(_9850,_9851,_10032,_10042,_9915).

itstatem(_9850,_9851,[itstatem,_9957,_9986,{},_10045,_10079,!,_10118],_9940,_9942) --> 
    negation0(_9882,_9957,_9940,_9974),
    hlexv(_9884,_9885,_9886,fin,_9888,_9986,_9974,_10011),
    {user:bigno(_9882,_9888,_9880)},
    gmem(_9885,[help,give,make,create],_10045,_10011,_10064),
    traceprint(4,it0,_10079,_10064,_10098),
    !,
    pushstack(first,([dette],w(verb(_9885,_9886,fin)),negation(_9880)),nil,_10098,_10158),
    state(_9850,_9851,_10118,_10158,_9942).

itstatem(_9850,_9851,[itstatem,_9941,_9970,_10004,_10038,_10072],_9924,_9926) --> 
    w(verb(_9878,_9879,fin),_9941,_9924,_9958),
    gmem(_9878,[have],_9970,_9958,_9989),
    subject(_9887,_9888,_10004,_9989,_10023),
    traceprint(4,it1,_10038,_10023,_10057),
    pushstack(first,(xnp(_9887,_9888),w(verb(_9878,_9879,fin)),[dette]),nil,_10057,_10113),
    state(_9850,_9851,_10072,_10113,_9926).

itstatem(_9850,_9851,[itstatem,_9937,lit(at),_9997,_10021,!,_10060],_9920,_9922) --> 
    lexvaccept(rv,_9880,_9881,fin,_9877,_9937,_9920,_9962),
    cc(at,_9962,_9996),
    look_ahead_np(_9997,_9996,_10012),
    traceprint(4,it2,_10021,_10012,_10040),
    !,
    pushstack(first,([dette],w(verb(_9880,_9881,fin)),negation(_9877)),nil,_10040,_10100),
    state(_9850,_9851,_10060,_10100,_9922).

itstatem(_9850,_9851,[itstatem,_9977,_10001,_10025,_10054,_10083,_10112,lit(som),_10157,_10186,!,_10225,!,_10334],_9960,_9962) --> 
    be(_9977,_9960,_9992),
    redundant0(_10001,_9992,_10016),
    negation0(_9889,_10025,_10016,_10042),
    not_look_ahead(w(nb(_9895,_9896)),_10054,_10042,_10071),
    not_look_ahead_lit([jeg,du],_10083,_10071,_10100),
    np0_accept(_9904,_9905,_10112,_10100,_10131),
    cc(som,_10131,_10156),
    w(verb(_9911,_9912,fin),_10157,_10156,_10174),
    traceprint(4,it3,_10186,_10174,_10205),
    !,
    pushstack(first,(xnp(_9904,_9905),w(verb(_9911,_9912,fin)),negation(_9889)),nil,_10205,_10299),state(_9850,_9851,_10225,_10299,_10314),
    !,
    accept(_10334,_10314,_9962).

itstatem(_9850,_9851,[itstatem,_9980,_10004,_10038,_10067,_10096,_10125,_10154,!,_10193],_9963,_9965) --> 
    be(_9980,_9963,_9995),
    subject(_9897,_9898,_10004,_9995,_10023),
    negation0(_9900,_10038,_10023,_10055),
    not_look_ahead(noun(_9904,_9905,_9906,_9907),_10067,_10055,_10084),
    w(adj2(_9911,nil),_10096,_10084,_10113),
    w(prep(_9916),_10125,_10113,_10142),
    traceprint(4,it4,_10154,_10142,_10173),
    !,
    pushstack(first,(xnp(_9897,_9898),w(verb(be,pres,fin)),negation(_9900),w(adj2(_9911,nil)),w(prep(_9916)),[dette]),nil,_10173,_10264),
    state(_9850,_9851,_10193,_10264,_9965).

itstatem(_9850,_9851,[itstatem,_9949,_9973,_10007,_10036,_10065,!,_10104],_9932,_9934) --> 
    aux1(_9949,_9932,_9964),
    subject(_9885,_9886,_9973,_9964,_9992),
    negation0(_9888,_10007,_9992,_10024),
    w(verb(_9892,_9893,fin),_10036,_10024,_10053),
    traceprint(4,it5,_10065,_10053,_10084),
    !,
    pushstack(first,(xnp(_9885,_9886),w(verb(_9892,pres,fin)),negation(_9888),[dette]),nil,_10084,_10175),
    state(_9850,_9851,_10104,_10175,_9934).

itstatem(_9850,_9851,[itstatem,_9968,_9997,_10026,lit('å'),_10066,!,_10105,_10148],_9951,_9953) --> 
    be(_9891,_9968,_9951,_9985),
    gradverb0(_9893,_9997,_9985,_10014),
    w(adj2(_9888,_9889),_10026,_10014,_10043),
    cc('å',_10043,_10065),
    traceprint(4,it7,_10066,_10065,_10085),
    !,
    pushstack(first,([jeg],[vil]),nil,_10085,_10118),clausal_object1(_9913,_9914,_10105,_10118,_10133),
    pushstack(first,(xnp(_9913,_9914),w(verb(be,pres,fin)),negation(_9891),w(adj2(_9888,_9889))),nil,_10133,_10219),
    state(_9850,_9851,_10148,_10219,_9953).

itstatem(_9850,_9851,[itstatem,_9949,_9978,_10022,_10061,!,_10100],_9932,_9934) --> 
    be(_9885,_9949,_9932,_9966),
    ap(_9880,_9881,_9850,_9883,_9978,_9966,_10001),
    pp(with,_9893,_9894,_10022,_10001,_10043),
    traceprint(4,it8,_10061,_10043,_10080),
    !,
    pushstack(first,(xnp(_9893,_9894),w(verb(be,pres,fin)),negation(_9885),ap(_9880,_9881,_9850,_9883)),nil,_10080,_10204),
    state(_9850,_9851,_10100,_10204,_9934).

itstatem(_9850,_9851,[itstatem,_9958,_9987,_10016,lit(at),_10056,!,_10095,_10129],_9941,_9943) --> 
    be(_9891,_9958,_9941,_9975),
    gradverb0(_9893,_9987,_9975,_10004),
    w(adj2(_9888,_9889),_10016,_10004,_10033),
    cc(at,_10033,_10055),
    traceprint(4,it9,_10056,_10055,_10075),
    !,
    clausal_object1(_9905,_9906,_10095,_10075,_10114),
    pushstack(first,(xnp(_9905,_9906),w(verb(be,pres,fin)),negation(_9891),w(adj2(_9888,_9889))),nil,_10114,_10200),
    state(_9850,_9851,_10129,_10200,_9943).

itstatem(_9850,_9851,[itstatem,_9985,_10014,_10043,_10072,_10101,lit('å'),_10146,!,_10185,_10209,_10283],_9968,_9970) --> 
    be(_9900,_9985,_9968,_10002),
    gradverb0(_9902,_10014,_10002,_10031),
    w(adj2(_9897,_9898),_10043,_10031,_10060),
    w(prep(for),_10072,_10060,_10089),
    object(_9913,_9914,_10101,_10089,_10120),
    cc('å',_10120,_10145),
    traceprint(4,it10,_10146,_10145,_10165),
    !,
    accept(_10185,_10165,_10200),
    pushstack(first,(xnp(_9913,_9914),[vil]),nil,_10200,_10253),clausal_object1(_9929,_9930,_10209,_10253,_10268),
    pushstack(first,(xnp(_9929,_9930),w(verb(be,pres,fin)),negation(_9900),w(adj2(_9897,_9898))),nil,_10268,_10354),
    state(_9850,_9851,_10283,_10354,_9970).

itstatem(_9850,_9851,[itstatem,_9975,_10004,_10033,lit('å'),_10083,!,_10122,_10146,_10189],_9958,_9960) --> 
    be(_9896,_9975,_9958,_9992),
    w(adj2(_9900,_9901),_10004,_9992,_10021),
    pp(_9892,_9893,_9894,_10033,_10021,_10054),
    cc('å',_10054,_10082),
    traceprint(4,it11,_10083,_10082,_10102),
    !,
    accept(_10122,_10102,_10137),
    pushstack(first,[noen],nil,_10137,_10159),clausal_object1(_9917,_9918,_10146,_10159,_10174),
    pushstack(first,(xnp(_9917,_9918),w(verb(be,pres,fin)),negation(_9896),w(adj2(_9900,_9901)),pp(_9892,_9893,_9894)),nil,_10174,_10292),
    state(_9850,_9851,_10189,_10292,_9960).

itstatem(_9850,_9851,[itstatem,_9987,_10016,lit('å'),_10071,_10100,_10129,!,_10168,_10211],_9970,_9972) --> 
    be(_9894,_9987,_9970,_10004),
    adj1(_9889,_9901:_9902,_9891,_9892,_10016,_10004,_10039),
    cc('å',_10039,_10070),
    w(verb(_9908,inf,fin),_10071,_10070,_10088),
    reflexiv0(_9908,_10100,_10088,_10117),
    traceprint(4,it12,_10129,_10117,_10148),
    !,
    pushstack(first,([noen],w(verb(_9908,pres,fin))),nil,_10148,_10181),clausal_object1(_9929,_9930,_10168,_10181,_10196),
    pushstack(first,(xnp(_9929,_9930),w(verb(be,pres,fin)),negation(_9894),adj1(_9889,_9901:_9949,_9891,_9892)),nil,_10196,_10318),
    state(_9850,_9851,_10211,_10318,_9972).

itstatem(_9850,_9851,[itstatem,_9944,_9973,_10017,_10041,!,_10080],_9927,_9929) --> 
    be(_9885,_9944,_9927,_9961),
    adj1(_9880,_9881,_9882,_9883,_9973,_9961,_9996),
    not_look_ahead_np(_10017,_9996,_10032),
    traceprint(4,it13,_10041,_10032,_10060),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_9885),adj1(_9880,_9881,_9882,_9883)),nil,_10060,_10151),
    state(_9850,_9851,_10080,_10151,_9929).

itstatem(_9850,_9853::_9854,[itstatem,_9981,_10005,_10029,_10053,_10082,_10111,_10140,_10169,lit(som),_10214,_10248,!,_10357],_9964,_9966) --> 
    be(_9981,_9964,_9996),
    preadverbials0(_10005,_9996,_10020),
    redundant0(_10029,_10020,_10044),
    negation0(_9892,_10053,_10044,_10070),
    not_look_ahead(w(nb(_9898,_9899)),_10082,_10070,_10099),
    not_look_ahead_lit([jeg,du],_10111,_10099,_10128),
    not_look_ahead([det],_10140,_10128,_10157),
    np1_accept(_9911,_9912,_10169,_10157,_10188),
    cc(som,_10188,_10213),
    traceprint(4,it14a,_10214,_10213,_10233),
    pushstack(first,(xnp(_9911,_9912),w(verb(be,pres,fin)),negation(_9892)),nil,_10233,_10322),state(_9850,_9853::_9854,_10248,_10322,_10337),
    !,
    accept(_10357,_10337,_9966).

itstatem(_9850,_9851,[itstatem,_9931,_9955,_9984,_10008,!,_10047],_9914,_9916) --> 
    be(_9931,_9914,_9946),
    negation0(_9877,_9955,_9946,_9972),
    not_look_ahead_np(_9984,_9972,_9999),
    traceprint(4,it14b,_10008,_9999,_10027),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_9877)),nil,_10027,_10087),
    state(_9850,_9851,_10047,_10087,_9916).

itstatem(_9850,_9851,[itstatem,_9946,_9975,lit(med),_10020,_10054,!,_10093],_9929,_9931) --> 
    w(verb(_9879,_9880,fin),_9946,_9929,_9963),
    gmem(_9879,[help,function],_9975,_9963,_9994),
    cc(med,_9994,_10019),
    np0_accept(_9898,_9899,_10020,_10019,_10039),
    traceprint(4,it15,_10054,_10039,_10073),
    !,
    pushstack(first,(xnp(_9898,_9899),w(verb(_9879,_9880,fin))),nil,_10073,_10134),
    state(_9850,_9851,_10093,_10134,_9931).

itstatem(_9850,_9851,[itstatem,_9968,_9997,_10031,lit('å'),_10076,!,_10115,_10158],_9951,_9953) --> 
    w(verb(_9888,_9889,fin),_9968,_9951,_9985),
    gmem(_9888,[cost,take],_9997,_9985,_10016),
    np0_accept(_9883,_9884,_10031,_10016,_10050),
    cc('å',_10050,_10075),
    traceprint(4,it16,_10076,_10075,_10095),
    !,
    pushstack(first,([noen],[vil]),nil,_10095,_10128),clausal_object1(_9915,_9916,_10115,_10128,_10143),
    pushstack(first,(xnp(_9915,_9916),w(verb(_9888,_9889,fin)),xnp(_9883,_9884)),nil,_10143,_10230),
    state(_9850,_9851,_10158,_10230,_9953).

itstatem(_9850,_9853::_9854,[itstatem,_9939,_9968,_9992,_10021,_10045,_10069,_10103,{}],_9922,_9924) --> 
    w(verb(go,pres,fin),_9939,_9922,_9956),
    redundants0(_9968,_9956,_9983),
    negation0(_9879,_9992,_9983,_10009),
    ann0(_10021,_10009,_10036),
    infinitive(_10045,_10036,_10060),
    traceprint(4,it17,_10069,_10060,_10088),
    pushstack(first,someone,nil,_10088,_10144),state(_9850,_9853::_9880,_10103,_10144,_9924),
    {user:negate(_9879,_9880,_9854)}.

itstatem(_9850,_9851,[itstatem,_9961,_9990,{},_10049,_10093,_10117,!,_10156],_9944,_9946) --> 
    negation0(_9891,_9961,_9944,_9978),
    hlexv(_9893,go,_9895,fin,_9897,_9990,_9978,_10015),
    {user:bigno(_9891,_9897,_9903)},
    optional([an],_10049,_10015,_10081),
    not_look_ahead_np(_10093,_10081,_10108),
    traceprint(4,it17b,_10117,_10108,_10136),
    !,
    pushstack(first,([dette],w(verb(be,_9895,fin)),negation(_9903),w(adj2(possible,nil))),nil,_10136,_10196),
    state(_9850,_9851,_10156,_10196,_9946).

itstatem(_9850,_9851,[itstatem,_9970,_9999,{},{},_10068,_10092,_10116,!,_10155,_10189],_9953,_9955) --> 
    negation0(_9891,_9970,_9953,_9987),
    hlexv(_9893,_9894,_9895,fin,_9897,_9999,_9987,_10024),
    {user:bigno(_9891,_9897,_9889)},
    {user:(\+testmember(_9894,[cost,take]))},
    preadverbials0(_10068,_10024,_10083),
    look_ahead_np(_10092,_10083,_10107),
    traceprint(4,it18,_10116,_10107,_10135),
    !,
    subject(_9919,_9920,_10155,_10135,_10174),
    pushstack(first,(xnp(_9919,_9920),w(verb(_9894,_9895,fin)),negation(_9889)),nil,_10174,_10260),
    state(_9850,_9851,_10189,_10260,_9955).

itstatem(_9850,_9851,[itstatem,_9946,lit('å'),_9986,!,_10025,_10068],_9929,_9931) --> 
    w(verb(_9876,_9877,fin),_9946,_9929,_9963),
    cc('å',_9963,_9985),
    traceprint(4,it19,_9986,_9985,_10005),
    !,
    pushstack(first,([noen],[vil]),nil,_10005,_10038),clausal_object1(_9899,_9900,_10025,_10038,_10053),
    pushstack(first,(xnp(_9899,_9900),w(verb(_9876,_9877,fin))),nil,_10053,_10109),
    state(_9850,_9851,_10068,_10109,_9931).

itstatem(_9850,_9851,[itstatem,_9953,_9977,_10001,_10030,lit(at),_10070,!,_10109,_10133],_9936,_9938) --> 
    blei(_9953,_9936,_9968),
    redundant0(_9977,_9968,_9992),
    negation0(_9891,_10001,_9992,_10018),
    w(verb(_9895,past,part),_10030,_10018,_10047),
    cc(at,_10047,_10069),
    traceprint(4,it20,_10070,_10069,_10089),
    !,
    accept(_10109,_10089,_10124),
    pushstack(first,([noen],w(verb(_9895,past,fin)),negation(_9891),[at]),nil,_10124,_10173),
    state(_9850,_9851,_10133,_10173,_9938).

itstatem(_9850,_9851,[itstatem,_9973,_9997,_10036,_10060,_10089,_10118,_10152,!,_10191,_10215],_9956,_9958) --> 
    blei(_9973,_9956,_9988),
    preadverbial0(_9895,_9896,_9897,_9997,_9988,_10018),
    redundant0(_10036,_10018,_10051),
    negation0(_9903,_10060,_10051,_10077),
    w(verb(_9907,past,part),_10089,_10077,_10106),
    object(_9911,_9912,_10118,_10106,_10137),
    traceprint(4,it21,_10152,_10137,_10171),
    !,
    accept(_10191,_10171,_10206),
    pushstack(first,(xnp(_9911,_9912),w(verb(be,pres,fin)),negation(_9903),w(verb(_9907,past,part)),adverbial1(_9895,_9896,_9897)),nil,_10206,_10318),
    state(_9850,_9851,_10215,_10318,_9958).

itstatem(_9850,_9851,[itstatem,_9934,_9963,_9992,!,_10031],_9917,_9919) --> 
    w(verb(_9878,_9879,pass),_9934,_9917,_9951),
    negation0(_9874,_9963,_9951,_9980),
    traceprint(4,it23,_9992,_9980,_10011),
    !,
    pushstack(first,([noen],w(verb(_9878,_9879,fin)),negation(_9874)),nil,_10011,_10071),
    state(_9850,_9851,_10031,_10071,_9919).

itstatem(_9850,_9851,[itstatem,_9969,_9998,_10022,{},_10061,_10085,!,_10124],_9952,_9954) --> 
    w(verb(be,_9894,fin),_9969,_9952,_9986),
    redundant0(_9998,_9986,_10013),
    w(adj2(_9888,nil),_10022,_10013,_10039),
    {user:testmember(_9888,[certain,uncertain,good,bad])},
    atom(_10061,_10039,_10076),
    traceprint(4,it24,_10085,_10076,_10104),
    !,
    pushstack(first,state(_9850,_9851)\(xnp(_9918,_9919),w(verb(be,_9894,fin)),w(adj2(_9888,nil))),nil,_10104,_10167),
    clausal_object1(_9918,_9919,_10124,_10167,_9954).

atom([atom,lit(at)],_9867,_9869) --> 
    cc(at,_9867,_9869).

atom([atom,lit(om)],_9867,_9869) --> 
    cc(om,_9867,_9869).

itstatem(_9850,_9851,[itstatem,_9991,_10020,_10044,lit('å'),_10084,_10113,_10142,_10166,!,_10205,_10248],_9974,_9976) --> 
    w(verb(be,_9900,fin),_9991,_9974,_10008),
    redundant0(_10020,_10008,_10035),
    w(adj2(_9894,nil),_10044,_10035,_10061),
    cc('å',_10061,_10083),
    w(verb(_9912,inf,fin),_10084,_10083,_10101),
    reflexiv0(_9912,_10113,_10101,_10130),
    not_look_ahead_np(_10142,_10130,_10157),
    traceprint(4,it25,_10166,_10157,_10185),
    !,
    pushstack(first,([noen],w(verb(_9912,pres,fin)),[dette]),nil,_10185,_10218),clausal_object1(_9932,_9933,_10205,_10218,_10233),
    pushstack(first,(xnp(_9932,_9933),w(verb(be,_9900,fin)),w(adj2(_9894,nil))),nil,_10233,_10289),
    state(_9850,_9851,_10248,_10289,_9976).

itstatem(_9850,_9851,[itstatem,_9948,_9977,_10006,_10035,!,_10074],_9931,_9933) --> 
    w(verb(be,_9887,fin),_9948,_9931,_9965),
    negation0(_9890,_9977,_9965,_9994),
    w(prep(_9882),_10006,_9994,_10023),
    traceprint(4,it26,_10035,_10023,_10054),
    !,
    pushstack(first,([dette],w(verb(be,_9887,fin)),negation(_9890),w(prep(_9882))),nil,_10054,_10114),
    state(_9850,_9851,_10074,_10114,_9933).

itstatem(_9850,_9851,[itstatem,_9978,_10007,lit('å'),_10047,_10076,!,_10115,!,_10163],_9961,_9963) --> 
    w(verb(be,pres,fin),_9978,_9961,_9995),
    w(adj2(_9888,nil),_10007,_9995,_10024),
    cc('å',_10024,_10046),
    w(verb(_9906,inf,fin),_10047,_10046,_10064),
    traceprint(4,it27,_10076,_10064,_10095),
    !,
    pushstack(first,([jeg],w(verb(_9906,pres,fin))),nil,_10095,_10128),clausal_object1(_9925,_9926,_10115,_10128,_10143),
    !,
    pushstack(first,(xnp(_9925,_9926),w(verb(be,pres,fin)),w(adj2(_9888,nil))),nil,_10143,_10204),
    state(_9850,_9851,_10163,_10204,_9963).

itstatem(_9850,_9851,[itstatem,_9944,{},_9983,_10017,!,_10056],_9927,_9929) --> 
    w(verb(_9881,_9882,fin),_9944,_9927,_9961),
    {user:verbtype(_9881,rv)},
    subject(_9890,_9891,_9983,_9961,_10002),
    traceprint(4,it28,_10017,_10002,_10036),
    !,
    pushstack(first,(xnp(_9890,_9891),w(verb(_9881,pres,fin)),[dette]),nil,_10036,_10097),
    state(_9850,_9851,_10056,_10097,_9929).

itstatem(_9850,_9851,[itstatem,_9985,_10014,_10048,_10072,_10101,{},lit(noe),lit(om),_10162,_10196],_9968,_9970) --> 
    w(verb(have,_9903,fin),_9985,_9968,_10002),
    subject(_9906,_9907,_10014,_10002,_10033),
    redundant0(_10048,_10033,_10063),
    negation0(_9909,_10072,_10063,_10089),
    w(verb(_9913,past,part),_10101,_10089,_10118),
    {user:testmember(_9913,[tell])},
    cc(noe,_10118,_10150),
    cc(om,_10150,_10161),
    traceprint(4,it29,_10162,_10161,_10181),
    pushstack(first,(xnp(_9906,_9907),w(verb(_9913,past,fin)),negation(_9909),[noe],[om],[det]),nil,_10181,_10267),
    state(_9850,_9851,_10196,_10267,_9970).

itstatem(_9850,_9851,[itstatem,_9939,{},_9978,!,_10017],_9922,_9924) --> 
    w(verb(_9873,_9880,fin),_9939,_9922,_9956),
    {user:testmember(_9873,[concern])},
    traceprint(4,it30,_9978,_9956,_9997),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_9873,pres,fin))),nil,_9997,_10027),
    state(_9850,_9851,_10017,_10027,_9924).

itstatem(_9850,_9851,[itstatem,_9966,{},_10005,_10034,_10078,!,_10117],_9949,_9951) --> 
    w(verb(_9886,_9887,fin),_9966,_9949,_9983),
    {user:testmember(_9886,[go,look,see,function])},
    w(adv(_9882),_10005,_9983,_10022),
    optional([ut],_10034,_10022,_10066),
    traceprint(4,it31,_10078,_10066,_10097),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_9886,pres,fin)),w(adv(_9882))),nil,_10097,_10127),
    state(_9850,_9851,_10117,_10127,_9951).

itstatem(_9850,_9853::_9854,[itstatem,_9943,{},_9982,!,_10021],_9926,_9928) --> 
    w(verb(_9875,_9882,fin),_9943,_9926,_9960),
    {user:testmember(_9875,[rain,snow,look,be_urgent])},
    traceprint(4,it32,_9982,_9960,_10001),
    !,
    pushstack(first,(something,lexv(iv,_9875,pres,fin)),nil,_10001,_10095),
    state(_9850,_9853::_9854,_10021,_10095,_9928).

itstatem(_9850,_9853::_9854,[itstatem,_9930,{},_9974,_10008],_9913,_9915) --> 
    pvimodal(_9870,_9875,_9930,_9913,_9949),
    {user:constrainit(_9879,thing)},
    traceprint(4,it32,_9974,_9949,_9993),
    pushstack(first,w(verb(_9870,pres,fin)),nil,_9993,_10018),
    verb_phrase1(_9870,_9879,id,_9850,_9853::_9854,_10008,_10018,_9915).

itstatem(_9850,_9853::_9854,[itstatem,_9940,_9974,_10008,_10042,{}],_9923,_9925) --> 
    beginverb(_9874,_9870,_9940,_9923,_9959),
    np1(_9877,_9878,_9974,_9959,_9993),
    traceprint(4,it33,_10008,_9993,_10027),
    pushstack(first,(np1(_9877,_9878),w(verb(_9874,pres,fin))),nil,_10027,_10088),state(_9850,_9853::_9871,_10042,_10088,_9925),
    {user:negate(_9870,_9871,_9854)}.

itstatem(_9850,_9853::_9854,[itstatem,_9930,_9954,_9993,_10017,_10051],_9913,_9915) --> 
    be(_9930,_9913,_9945),
    adverbial(_9871,_9872,_9875::_9876,_9954,_9945,_9975),
    that(_9993,_9975,_10008),
    traceprint(4,it34,_10017,_10008,_10036),
    lock(last,_10036,_10101),
    pushstack(last,adverbial(_9871,_9872,_9875::_9876),nil,_10101,_10107),
    state(_9850,_9853::_9854,_10051,_10107,_10096),
    unlock(_10096,_9915).

itstatem(_9850,_9853::_9854,[itstatem,_9949,_9973,_10002,_10026,_10055,_10084,_10113,!,_10152,_10176],_9932,_9934) --> 
    be(_9949,_9932,_9964),
    negation0(_9889,_9973,_9964,_9990),
    saa0(_10002,_9990,_10017),
    not_look_ahead(w(verb(_9895,past,part)),_10026,_10017,_10043),
    w(adj2(_9901,nil),_10055,_10043,_10072),
    one_of_lit([at,om],_10084,_10072,_10101),
    traceprint(4,it35,_10113,_10101,_10132),
    !,
    accept(_10152,_10132,_10167),
    statem(_9850,_9853::_9854,_10176,_10167,_9934).

itstatem(_9850,_9853::_9854,[itstatem,_9945,_9969,_9998,_10022,{},_10061,_10090,_10124],_9928,_9930) --> 
    be(_9945,_9928,_9960),
    negation0(_9883,_9969,_9960,_9986),
    saa0(_9998,_9986,_10013),
    w(adj2(_9887,nil),_10022,_10013,_10039),
    {user:testmember(_9887,[good])},
    not_look_ahead(w(noun(_9901,_9902,_9903,_9904)),_10061,_10039,_10078),
    traceprint(4,it36,_10090,_10078,_10109),
    statem(_9850,_9853::_9854,_10124,_10109,_9930).

itstatem(_9850,_9853::_9854,[itstatem,_9992,{},_10031,_10055,_10084,{},_10123,_10157,{}],_9975,_9977) --> 
    be(_9882,_9992,_9975,_10009),
    {user:it_template(_9890)},
    so0(_10031,_10009,_10046),
    gradverb0(_9892,_10055,_10046,_10072),
    w(adj2(_9896,nil),_10084,_10072,_10101),
    {user:testmember(_9896,[difficult,easy,expensive,free,funny,good,intelligent,mild,hot,cold,wet,dark,bright,cloudy,sad,stupid,tedious])},
    traceprint(4,it37,_10123,_10101,_10142),
    pushstack(first,w(adj2(_9896,nil)),nil,_10142,_10170),be_complements(_9890,_9850,_9853::_9883,_10157,_10170,_9977),
    {user:negate(_9882,_9883,_9854)}.

itstatem(_9850,_9853::_9854,[itstatem,_9956,{},_10010,_10039,_10078,!,_10117],_9939,_9941) --> 
    lexv(iv,_9887,_9888,fin,_9956,_9939,_9979),
    {user:(\+testmember(_9887,be))},
    negation0(_9898,_10010,_9979,_10027),
    adverb(_9883,_9884,_9902,_10039,_10027,_10060),
    traceprint(4,it38,_10078,_10060,_10097),
    !,
    pushstack(free,(lexv(iv,_9887,_9888,fin),negation(_9898),xadverb(_9883,_9884)),nil,_10097,_10219),
    state(_9850,_9853::_9854,_10117,_10219,_9941).

itstatem(_9850,_9851,[itstatem,_9935,_9964,_9998,!,_10037,!],_9918,_9920) --> 
    be(_9868,_9935,_9918,_9952),
    subject(_9870,_9871,_9964,_9952,_9983),
    traceprint(4,it39,_9998,_9983,_10017),
    !,
    pushstack(first,(xnp(_9870,_9871),w(verb(exist,pres,fin)),negation(_9868)),nil,_10017,_10111),state(_9850,_9851,_10037,_10111,_9920),
    !.

statreal(_9850,[statreal,_9886],_9872,_9874) --> 
    stat(real,_9850,_9886,_9872,_9874).

stat(_9850,_9851,[stat,_9906,_9940],_9889,_9891) --> 
    state(_9857,_9864::_9865,_9906,_9889,_9925),
    worldcomp(_9850,_9857,_9864::_9865,_9851,_9940,_9925,_9891).

statreal1(_9850,[statreal1,_9894,_9928],_9880,_9882) --> 
    state1(_9856,_9857,_9894,_9880,_9913),
    worldcomp(real,_9856,_9857,_9850,_9928,_9913,_9882).

state1(_9850,_9853::_9854,[state1,_9941,_9975,_10004,!,_10033,{},{},!],_9924,_9926) --> 
    np(_9877,_9880::_9854,_9941,_9924,_9960),
    negation0(_9883,_9975,_9960,_9992),
    redundant0(_10004,_9992,_10019),
    !,
    vp(_9877,_9886,_9850,_9853::_9891,_10033,_10019,_9926),
    {user:bigno(_9883,_9886,_9897)},
    {user:negate(_9897,_9891,_9880)},
    !.

substate(_9850,_9853::_9854,[substate,_9938,_9972,_9996,!,_10030,{},{}],_9921,_9923) --> 
    subject(_9880,_9878::_9854,_9938,_9921,_9957),
    preadverbials0(_9972,_9957,_9987),
    negation0(_9886,_9996,_9987,_10013),
    !,
    vp(_9880,_9889,_9850,_9853::_9877,_10030,_10013,_9923),
    {user:bigno(_9886,_9889,_9876)},
    {user:negate(_9876,_9877,_9878)}.

state(_9850,_9853::_9854,[state,_9935,_9969,_9993,_10022,{},{}],_9918,_9920) --> 
    subject(_9877,_9875::_9854,_9935,_9918,_9954),
    redundant0(_9969,_9954,_9984),
    negation0(_9883,_9993,_9984,_10010),
    vp(_9877,_9886,_9850,_9853::_9874,_10022,_10010,_9920),
    {user:bigno(_9883,_9886,_9873)},
    {user:negate(_9873,_9874,_9875)}.

beginverb(_9850,_9851,[beginverb,_9912,_9941,_9970,_9994],_9895,_9897) --> 
    w(verb(start,_9871,fin),_9912,_9895,_9929),
    negation0(_9851,_9941,_9929,_9958),
    infinitiveand(_9970,_9958,_9985),
    w(verb(_9850,_9865,fin),_9994,_9985,_9897).

question(_9850,[question,_9925,_9954,!,_9983],_9911,_9913) --> 
    w(noun(clock,sin,_9881,n),_9925,_9911,_9942),
    terminator(_9954,_9942,_9969),
    !,
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(clock,sin,def,n))),nil,_9969,_9993),
    whatq(_9850,_9983,_9993,_9913).

question(_9850,[question,_9885],_9871,_9873) --> 
    whichq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    whoq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    whenq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    howadjq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    whereq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    wherefromq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    whatq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    howmuchq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    whyq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    howq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    ppq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9885],_9871,_9873) --> 
    whoseq(_9850,_9885,_9871,_9873).

question(_9850,[question,_9934,_9958,!,_9992,_10026,!,_10055],_9920,_9922) --> 
    be(_9934,_9920,_9949),
    w(noun(clock,_9892,_9893,_9894),_9958,_9949,_9975),
    !,
    np1(_9896,_9897,_9992,_9975,_10011),
    danow0(_10026,_10011,_10041),
    !,
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_10041,_10124),
    whatq(_9850,_10055,_10124,_9922).

question(_9850,[question,_9885],_9871,_9873) --> 
    question1(_9850,_9885,_9871,_9873).

question1(test:::_9853,[question1,lit('får'),_9924,!,_9963],_9899,_9901) --> 
    cc('får',_9899,_9923),
    specific_phrase(_9874,_9875,_9924,_9923,_9943),
    !,
    pushstack(first,(np(_9874,_9875),['får']),nil,_9943,_10004),
    statement(_9853,_9963,_10004,_9901).

question1(new:::_9853,[question1,_9942,_9971,{},_10010,!,_10044],_9928,_9930) --> 
    w(verb(have,pres,fin),_9942,_9928,_9959),
    w(verb(_9878,past,part),_9971,_9959,_9988),
    {user:testmember(_9878,[want,think])},
    not_look_ahead([du],_10010,_9988,_10027),
    !,
    pushstack(first,([jeg],w(verb(_9878,pres,fin))),nil,_10027,_10054),
    statement(_9853,_10044,_10054,_9930).

question1(new:::_9853,[question1,_9941,{},_9980,_10014,!,_10048],_9927,_9929) --> 
    w(verb(_9884,pres,fin),_9941,_9927,_9958),
    {user:testmember(_9884,[want,think,hope])},
    particlev0(_9884,_9878,_9980,_9958,_9999),
    not_look_ahead([du],_10014,_9999,_10031),
    !,
    pushstack(first,([jeg],w(verb(_9878,pres,fin))),nil,_10031,_10058),
    statement(_9853,_10048,_10058,_9929).

question1(test:::_9853,[question1,_9888],_9874,_9876) --> 
    question0(_9853,_9888,_9874,_9876).

np_question(which(_9855):::_9853,[np_question,_9894],_9880,_9882) --> 
    np1(_9855,true::_9853,_9894,_9880,_9882).

question0(_9850,[question0,_9885],_9871,_9873) --> 
    isq(_9850,_9885,_9871,_9873).

question0(_9850,[question0,_9885],_9871,_9873) --> 
    ynqs(_9850,_9885,_9871,_9873).

question0(_9850,[question0,_9885],_9871,_9873) --> 
    hasq(_9850,_9885,_9871,_9873).

question0(_9850,[question0,_9888,_9912],_9874,_9876) --> 
    hoq(_9888,_9874,_9903),
    statement(_9850,_9912,_9903,_9876).

implicitq(new:::_9853,[implicitq,_10007,{},_10046,{},{},lit(som),_10106,_10130,_10173,!,_10212,_10236,!,_10290],_9993,_9995) --> 
    w(prep(_9896),_10007,_9993,_10024),
    {user:testmember(_9896,[from,to])},
    w(name(_9909,n,_9911),_10046,_10024,_10063),
    {user:testmember(_9911,[station,neighbourhood])},
    {user:no_unprotected_verb},
    cc(som,_10063,_10105),
    look_ahead_vp(_10106,_10105,_10121),
    pushstack(first,(w(noun(bus,sin,u,n)),w(prep(_9896)),w(name(_9909,n,_9911))),nil,_10121,_10143),np1_accept(_9941,_9944::_9853,_10130,_10143,_10158),
    traceprint(4,iq00,_10173,_10158,_10192),
    !,
    accept(_10212,_10192,_10227),
    verb_phrase1(_9961,_9941,id,_9964,event/real/_9964::_9944,_10236,_10227,_10261),
    !,
    accept(_10290,_10261,_9995).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,_9995,lit('når'),{},_10045,_10074,_10118,{},_10157,!,{},_10206,_10245],_9981,_9983) --> 
    not_look_ahead([nr],_9995,_9981,_10012),
    cc('når',_10012,_10034),
    {user:(\+user:value(dialog,1))},
    w(verb(go,_9921,fin),_10045,_10034,_10062),
    optional([neste],_10074,_10062,_10106),
    w(name(_9898,n,_9900),_10118,_10106,_10135),
    {user:testmember(_9900,[station,neighbourhood])},
    traceprint(4,iq01,_10157,_10135,_10176),
    !,
    {user:setvartype(_9948,vehicle)},
    realcomp(_9858,_9952,_9856,_10206,_10176,_10227),
    pushstack(first,w(name(_9898,n,_9900)),nil,_10227,_10255),
    verb_modifiers(go,_9948,_9858,_9855::true,_9952,_10245,_10255,_9983).

implicitq(_9850,[implicitq,_9953,lit('når'),{},{},_10013,{},!,_10057,_10081,_10115],_9939,_9941) --> 
    not_look_ahead([nr],_9953,_9939,_9970),
    cc('når',_9970,_9992),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    look_ahead(w(name(_9908,_9909,_9910)),_10013,_9992,_10030),
    {user:subclass0(_9910,place)},
    !,
    accept(_10057,_10030,_10072),
    traceprint(4,iq2,_10081,_10072,_10100),
    pushstack(first,w(prep(to)),nil,_10100,_10125),
    implicitq(_9850,_10115,_10125,_9941).

implicitq(test:::_9853,[implicitq,{},_9954,lit('når'),lit(nr),{},!,_10020,_10044,_10078],_9930,_9932) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead([nr],_9954,_9930,_9971),
    cc('når',_9971,_9993),
    cc(nr,_9993,_10004),
    {user:no_unprotected_verb},
    !,
    accept(_10020,_10004,_10035),
    traceprint(4,iq3,_10044,_10035,_10063),
    pushstack(first,w(verb(go,pres,fin)),nil,_10063,_10088),
    ynq(_9853,_10078,_10088,_9932).

implicitq(test:::_9853,[implicitq,_9946,lit('når'),{},{},_10006,!,_10055,_10079,_10113],_9932,_9934) --> 
    not_look_ahead([nr],_9946,_9932,_9963),
    cc('når',_9963,_9985),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    optional([det],_10006,_9985,_10038),
    !,
    accept(_10055,_10038,_10070),
    traceprint(4,iq4,_10079,_10070,_10098),
    pushstack(first,w(verb(go,pres,fin)),nil,_10098,_10123),
    ynq(_9853,_10113,_10123,_9934).

implicitq(_9850,[implicitq,_9889,!,_9918],_9875,_9877) --> 
    reject_implicitq(_9889,_9875,_9904),
    !,
    reject(_9918,_9904,_9877).

implicitq(new:::_9853,[implicitq,_10012,{},{},_10061,{},{},_10115,_10144,_10173,_10202,!,_10231,_10255,_10289,_10347,_10391,!,_10420],_9998,_10000) --> 
    look_ahead(w(noun(_9910,sin,u,n)),_10012,_9998,_10029),
    {user:subclass0(_9910,vehicle)},
    {user:no_unprotected_verb},
    np1_accept(_9922,_9925::_9853,_10061,_10029,_10080),
    {user:(\+vartypeid(_9922,time))},
    {user:(\+vartypeid(_9922,clock))},
    constrainvehdep(_9922,_10115,_10080,_10132),
    not_look_ahead([som],_10144,_10132,_10161),
    not_look_ahead([om],_10173,_10161,_10190),
    point0(_10202,_10190,_10217),
    !,
    accept(_10231,_10217,_10246),
    traceprint(4,iq4b,_10255,_10246,_10274),
    pushstack(first,w(verb(go,pres,fin)),nil,_10274,_10302),verb_phrase1(go,_9922,id,_9967,event/real/_9967::_9925,_10289,_10302,_10323),
    optional(itrailer,_10347,_10323,_10379),
    endofline(_10391,_10379,_10406),
    !,
    accept(_10420,_10406,_10000).

implicitq(which(_9855):::_9853,[implicitq,{},_9985,_10014,_10043,_10082,!,_10111,_10145,!,_10239],_9961,_9963) --> 
    {user:value(teleflag,true)},
    w(noun(_9894,_9895,_9896,n),_9985,_9961,_10002),
    not_look_ahead(w(prep(_9903)),_10014,_10002,_10031),
    person_name(_9909:person,_9906,_9907,_10043,_10031,_10064),
    endofline(_10082,_10064,_10097),
    !,
    traceprint(4,iq5,_10111,_10097,_10130),
    lock(exact,_10130,_10198),pushstack(exact,(w(noun(_9894,sin,u,n)),w(prep(to)),nameq1(_9909:person,_9906)),nil,_10198,_10204),no_phrases(_9855,_9853,_10145,_10204,_10193),unlock(_10193,_10194),
    !,
    accept(_10239,_10194,_9963).

implicitq(which(_9855):::_9853,[implicitq,{},_9927,_9961,_9985,!,_10024],_9903,_9905) --> 
    {user:value(teleflag,true)},
    no_phrases(_9855,_9853,_9927,_9903,_9946),
    endofline(_9961,_9946,_9976),
    traceprint(4,iq7,_9985,_9976,_10004),
    !,
    accept(_10024,_10004,_9905).

implicitq(new:::_9853,[implicitq,{},_10006,{},_10045,_10074,_10103,_10146,!,_10185,_10209,_10267,!,_10296],_9982,_9984) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead(w(prep(_9905)),_10006,_9982,_10023),
    {user:no_unprotected_verb},
    w(noun(time,_9912,_9913,_9914),_10045,_10023,_10062),
    look_ahead(w(prep(_9920)),_10074,_10062,_10091),
    pushstack(first,w(noun(departure,sin,u,_9914)),nil,_10091,_10116),np0(_9932,_9935::_9853,_10103,_10116,_10131),
    traceprint(4,iq8,_10146,_10131,_10165),
    !,
    accept(_10185,_10165,_10200),
    pushstack(first,w(verb(go,pres,fin)),nil,_10200,_10222),verb_phrase1(_9950,_9932,id,_9953,event/real/_9953::_9935,_10209,_10222,_10243),
    endofline(_10267,_10243,_10282),
    !,
    accept(_10296,_10282,_9984).

implicitq(new:::_9853,[implicitq,_10011,_10040,{},_10079,{},{},_10133,_10162,_10191,_10220,!,_10249,_10273,_10307,_10365,_10409,!,_10438],_9997,_9999) --> 
    not_look_ahead(w(nb(_9910,num)),_10011,_9997,_10028),
    not_look_ahead(w(prep(_9917)),_10040,_10028,_10057),
    {user:no_unprotected_verb},
    np1_accept(_9921,_9924::_9853,_10079,_10057,_10098),
    {user:(\+vartypeid(_9921,time))},
    {user:(\+vartypeid(_9921,clock))},
    constrainvehdep(_9921,_10133,_10098,_10150),
    not_look_ahead([som],_10162,_10150,_10179),
    not_look_ahead([om],_10191,_10179,_10208),
    point0(_10220,_10208,_10235),
    !,
    accept(_10249,_10235,_10264),
    traceprint(4,iq9,_10273,_10264,_10292),
    pushstack(first,w(verb(go,pres,fin)),nil,_10292,_10320),verb_phrase1(_9963,_9921,id,_9966,event/real/_9966::_9924,_10307,_10320,_10341),
    optional(itrailer,_10365,_10341,_10397),
    endofline(_10409,_10397,_10424),
    !,
    accept(_10438,_10424,_9999).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,{},_9992,_10021,_10050,{},_10084,_10108,{},_10142,_10181,_10205,_10296,!,_10335,_10359],_9968,_9970) --> 
    {user:value(dialog,1)},
    not_look_ahead(['nå'],_9992,_9968,_10009),
    time1(_9914,_10021,_10009,_10038),
    endofline(_10050,_10038,_10065),
    {user:no_unprotected_verb},
    no_harmful_adj(_10084,_10065,_10099),
    no_harmful_noun(_10108,_10099,_10123),
    {user:setvartype(_9920,vehicle)},
    realcomp(_9858,_9924,_9856,_10142,_10123,_10163),
    deter0(_10181,_10163,_10196),
    pushstack(first,obviousclock1(_9914:clock,_9914 isa clock),nil,_10196,_10251),verb_modifiers(go,_9920,_9858,_9855::true,_9924,_10205,_10251,_10272),
    traceprint(4,iq10,_10296,_10272,_10315),
    !,
    accept(_10335,_10315,_10350),
    qtrailer0(_10359,_10350,_9970).

implicitq(new:::_9853,[implicitq,{},_10014,_10043,{},_10077,{},{},_10131,_10160,_10189,!,_10223,_10247,_10281,_10339,!,_10368],_9990,_9992) --> 
    {user:value(dialog,1)},
    not_look_ahead(w(prep(_9912)),_10014,_9990,_10031),
    not_look_ahead_flnp(_10043,_10031,_10058),
    {user:no_unprotected_verb},
    np0(_9916,_9919::_9853,_10077,_10058,_10096),
    {user:(\+vartypeid(_9916,time))},
    {user:(\+vartypeid(_9916,clock))},
    constrainvehdep(_9916,_10131,_10096,_10148),
    not_look_ahead([om],_10160,_10148,_10177),
    not_look_ahead([som],_10189,_10177,_10206),
    !,
    accept(_10223,_10206,_10238),
    traceprint(4,iq11,_10247,_10238,_10266),
    pushstack(first,w(verb(go,pres,fin)),nil,_10266,_10294),verb_phrase1(_9958,_9916,id,_9961,event/real/_9961::_9919,_10281,_10294,_10315),
    endofline(_10339,_10315,_10354),
    !,
    accept(_10368,_10354,_9992).

implicitq(_9850,[implicitq,_9953,_9977,_10006,_10035,!,_10069,_10093,_10127],_9939,_9941) --> 
    the0(_9953,_9939,_9968),
    w(nb(_9891,num),_9977,_9968,_9994),
    flnp(_9894,_10006,_9994,_10023),
    w(prep(_9887),_10035,_10023,_10052),
    !,
    accept(_10069,_10052,_10084),
    traceprint(4,iq12,_10093,_10084,_10112),
    pushstack(first,(w(nb(_9891,num)),w(adj2(_9894,nil)),w(noun(route,plu,u,n)),w(prep(_9887))),nil,_10112,_10137),
    implicitq(_9850,_10127,_10137,_9941).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,_9970,_9999,_10028,!,_10062,_10086,_10120,_10159,!,_10222],_9956,_9958) --> 
    flnp(_9887,_9970,_9956,_9987),
    not_look_ahead([p],_9999,_9987,_10016),
    therightprep(_9893,_10028,_10016,_10045),
    !,
    accept(_10062,_10045,_10077),
    traceprint(4,iq13,_10086,_10077,_10105),
    realcomp(_9858,_9899,_9856,_10120,_10105,_10141),
    pushstack(first,w(prep(_9893)),nil,_10141,_10172),verb_modifiers(go,_9915:vehicle,_9858,_9855::_9915 isa vehicle and adj/nil/_9887/_9915/_9858,_9899,_10159,_10172,_10193),
    !,
    accept(_10222,_10193,_9958).

implicitq(_9850,[implicitq,{},_9975,_10004,{},_10043,{},!,_10087,_10111,_10145],_9951,_9953) --> 
    {user:(\+value(dialog,1))},
    w(noun(_9887,_9888,_9889,_9890),_9975,_9951,_9992),
    not_look_ahead(w(name(_9910,_9911,_9912)),_10004,_9992,_10021),
    {user:testmember(_9887,[station])},
    look_ahead(w(prep(_9925)),_10043,_10021,_10060),
    {user:no_unprotected_verb},
    !,
    accept(_10087,_10060,_10102),
    traceprint(4,iq14,_10111,_10102,_10130),
    pushstack(first,(whatbe,w(noun(_9887,_9888,_9889,_9890))),nil,_10130,_10188),
    whatq(_9850,_10145,_10188,_9953).

implicitq(_9850,[implicitq,{},_9963,_9992,{},{},!,_10046,_10070,_10104],_9939,_9941) --> 
    {user:(\+value(dialog,1))},
    w(adj2(nearest,nil),_9963,_9939,_9980),
    look_ahead(w(noun(_9903,_9904,_9905,_9906)),_9992,_9980,_10009),
    {user:testmember(_9903,[station])},
    {user:no_unprotected_verb},
    !,
    accept(_10046,_10009,_10061),
    traceprint(4,iq14b,_10070,_10061,_10089),
    pushstack(first,(whatbe,w(adj2(nearest,nil))),nil,_10089,_10142),
    whatq(_9850,_10104,_10142,_9941).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,lit('nå'),{},{},{},_10028,_10057,_10086,{},_10120,_10159,_10217,!,_10256],_9973,_9975) --> 
    cc('nå',_9973,_9997),
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(adj2(_9918,nil)),_10028,_9997,_10045),
    not_look_ahead(w(noun(_9925,_9926,_9927,_9928)),_10057,_10045,_10074),
    not_fnlp(_10086,_10074,_10101),
    {user:setvartype(_9932,vehicle)},
    realcomp(_9858,_9936,_9856,_10120,_10101,_10141),
    pushstack(free,['nå'],nil,_10141,_10172),verb_modifiers(go,_9932,_9858,_9855::true,_9936,_10159,_10172,_10193),
    traceprint(4,iq15,_10217,_10193,_10236),
    !,
    accept(_10256,_10236,_9975).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,{},{},{},_10017,_10046,{},_10090,_10129,_10153,!,_10247,_10271,_10305],_9973,_9975) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_9916,_9917)),_10017,_9973,_10034),
    obviousclock1(_9919,_9920,_10046,_10034,_10065),
    {user:setvartype(_9924,vehicle)},
    realcomp(_9858,_9928,_9856,_10090,_10065,_10111),
    deter0(_10129,_10111,_10144),
    pushstack(first,(w(prep(after)),obviousclock1(_9919,_9920)),nil,_10144,_10197),verb_modifiers(go,_9924,_9858,_9855::true,_9928,_10153,_10197,_10218),
    !,
    accept(_10247,_10218,_10262),
    traceprint(4,iq17,_10271,_10262,_10290),
    qtrailer0(_10305,_10290,_9975).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,{},{},_9989,_10028,{},_10062,_10091,_10120,_10159,_10208,!,_10247],_9955,_9957) --> 
    {user:(\+value(dialog,1))},
    {user:no_unprotected_verb},
    namep(_9902,_9903,_9904,_9989,_9955,_10010),
    no_harmful_adj(_10028,_10010,_10043),
    {user:constrain(_9903,vehicle)},
    not_look_ahead([om],_10062,_10043,_10079),
    not_look_ahead(w(nb(_9919,_9920)),_10091,_10079,_10108),
    realcomp(_9858,_9923,_9856,_10120,_10108,_10141),
    verb_modifiers(go,_9903,_9858,_9855::_9904,_9923,_10159,_10141,_10184),
    traceprint(4,iq18,_10208,_10184,_10227),
    !,
    accept(_10247,_10227,_9957).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,_9975,_10004,{},{},_10053,_10092,_10150,!,_10189],_9961,_9963) --> 
    not_look_ahead(w(name(_9888,_9889,_9890)),_9975,_9961,_9992),
    w(noun(_9894,sin,u,n),_10004,_9992,_10021),
    {user:test(_9894 ako day)},
    {user:setvartype(_9908,vehicle)},
    realcomp(_9858,_9912,_9856,_10053,_10021,_10074),
    pushstack(first,(w(prep(on)),w(noun(_9894,sin,u,n))),nil,_10074,_10105),verb_modifiers(go,_9908,_9858,_9855::true,_9912,_10092,_10105,_10126),
    traceprint(4,iq19,_10150,_10126,_10169),
    !,
    accept(_10189,_10169,_9963).

implicitq(new:::_9853,[implicitq,{},_10037,_10066,{},{},{},{},{},_10150,_10179,_10208,!,_10242,_10266,_10300,_10358,!,_10387],_10013,_10015) --> 
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_9912,_9913)),_10037,_10013,_10054),
    np1_accept(_9915,_9918::_9853,_10066,_10054,_10085),
    {user:(\+vartypeid(_9915,thing))},
    {user:(\+vartypeid(_9915,time))},
    {user:(\+vartypeid(_9915,clock))},
    {user:(\+vartypeid(_9915,arrival))},
    {user:(\+vartypeid(_9915,departure))},
    not_look_ahead([om],_10150,_10085,_10167),
    not_look_ahead(w(nb(_9964,_9965)),_10179,_10167,_10196),
    constrainvehdep(_9915,_10208,_10196,_10225),
    !,
    accept(_10242,_10225,_10257),
    traceprint(4,iq20,_10266,_10257,_10285),
    pushstack(first,w(verb(go,pres,fin)),nil,_10285,_10313),verb_phrase1(_9981,_9915,id,_9984,event/real/_9984::_9918,_10300,_10313,_10334),
    endofline(_10358,_10334,_10373),
    !,
    accept(_10387,_10373,_10015).

implicitq(new:::_9853,[implicitq,lit('når'),_9969,!,_10013,_10037,!,_10071,_10105,_10180],_9944,_9946) --> 
    cc('når',_9944,_9968),
    np_kernel(_9890,_9891,_9892,_9969,_9968,_9990),
    !,
    accept(_10013,_9990,_10028),
    constrainvehdep(_9891,_10037,_10028,_10054),
    !,
    traceprint(4,iq21,_10071,_10054,_10090),
    pushstack(first,np_kernel(0,_9891,_9892),nil,_10090,_10150),np1(_9891,_9909::_9853,_10105,_10150,_10165),
    pushstack(first,w(verb(go,pres,fin)),nil,_10165,_10190),
    verb_phrase1(_9912,_9891,id,_9915,event/real/_9915::_9909,_10180,_10190,_9946).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,_9986,_10010,_10039,_10068,_10097,!,_10131,_10155,_10189,_10228,!,_10282],_9972,_9974) --> 
    athe0(_9986,_9972,_10001),
    flnp(_9893,_10010,_10001,_10027),
    not_look_ahead(w(nb(_9899,_9900)),_10039,_10027,_10056),
    not_look_ahead(w(name(_9906,_9907,route)),_10068,_10056,_10085),
    look_ahead(w(name(_9914,_9915,_9916)),_10097,_10085,_10114),
    !,
    accept(_10131,_10114,_10146),
    traceprint(4,iq22,_10155,_10146,_10174),
    realcomp(_9858,_9922,_9856,_10189,_10174,_10210),
    verb_modifiers(go,_9931:vehicle,_9858,_9855::_9931 isa vehicle and adj/nil/_9893/_9931/_9858,_9922,_10228,_10210,_10253),
    !,
    accept(_10282,_10253,_9974).

implicitq(_9850,[implicitq,{},_10010,_10039,_10068,_10097,_10126,_10155,{},_10194,!,_10233,_10257,_10291],_9986,_9988) --> 
    {user:(\+value(dialog,1))},
    not_look_ahead(w(noun(clock,_9909,_9910,_9911)),_10010,_9986,_10027),
    not_look_ahead(w(noun(thing,_9918,_9919,_9920)),_10039,_10027,_10056),
    not_look_ahead(w(noun(answer,_9927,_9928,_9929)),_10068,_10056,_10085),
    not_look_ahead([det],_10097,_10085,_10114),
    not_look_ahead(w(name(_9939,n,_9941)),_10126,_10114,_10143),
    look_ahead(w(noun(_9947,_9948,_9949,n)),_10155,_10143,_10172),
    {user:testmember(_9947,[ticket,price])},
    np1_accept(_9894,_9895,_10194,_10172,_10213),
    !,
    accept(_10233,_10213,_10248),
    traceprint(4,iq23,_10257,_10248,_10276),
    pushstack(first,(whatbe,xnp(_9894,_9895)),nil,_10276,_10360),
    whatq(_9850,_10291,_10360,_9988).

implicitq(_9850,[implicitq,{},_9962,{},_10001,!,_10035,_10059,_10093],_9938,_9940) --> 
    {user:(\+value(dialog,1))},
    w(noun(_9881,_9896,_9897,_9898),_9962,_9938,_9979),
    {user:testmember(_9881,[clock,date])},
    not_look_ahead(w(nb(_9913,_9914)),_10001,_9979,_10018),
    !,
    accept(_10035,_10018,_10050),
    traceprint(4,iq24,_10059,_10050,_10078),
    pushstack(first,(whatbe,w(noun(_9881,_9882,_9883,_9884))),nil,_10078,_10131),
    whatq(_9850,_10093,_10131,_9940).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,{},{},{},_10061,{},_10100,{},{},_10149,_10188,_10217,_10251,!,_10314,_10338],_10017,_10019) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    w(name(_9920,n,_9922),_10061,_10017,_10078),
    {user:subclass0(_9922,place)},
    w(name(_9931,n,_9933),_10100,_10078,_10117),
    {user:subclass0(_9933,place)},
    {user:setvartype(_9942,vehicle)},
    realcomp(_9858,_9946,_9856,_10149,_10117,_10170),
    not_look_ahead(w(nb(_9953,_9954)),_10188,_10170,_10205),
    traceprint(4,iq25,_10217,_10205,_10236),
    pushstack(first,(w(prep(from)),w(name(_9920,n,_9922)),w(prep(to)),w(name(_9931,n,_9933))),nil,_10236,_10264),verb_modifiers(go,_9942,_9858,_9855::true,_9946,_10251,_10264,_10285),
    !,
    accept(_10314,_10285,_10329),
    qtrailer0(_10338,_10329,_10019).

implicitq(modifier(_9858):::_9855 and _9856,[implicitq,{},{},{},_10017,_10041,_10065,{},_10104,_10143,_10167,_10196,_10220,_10244,_10278,!,_10332,_10356],_9973,_9975) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    no_harmful_adj(_10017,_9973,_10032),
    no_harmful_noun(_10041,_10032,_10056),
    not_look_ahead([du],_10065,_10056,_10082),
    {user:setvartype(_9930,vehicle)},
    realcomp(_9858,_9934,_9856,_10104,_10082,_10125),
    deter0(_10143,_10125,_10158),
    not_look_ahead(w(nb(_9941,_9942)),_10167,_10158,_10184),
    no_harmful_adj(_10196,_10184,_10211),
    redundants0(_10220,_10211,_10235),
    traceprint(4,iq26,_10244,_10235,_10263),
    verb_modifiers(go,_9930,_9858,_9855::true,_9934,_10278,_10263,_10303),
    !,
    accept(_10332,_10303,_10347),
    qtrailer0(_10356,_10347,_9975).

reject_implicitq([reject_implicitq,lit(hvilke)],_9867,_9869) --> 
    cc(hvilke,_9867,_9869).

reject_implicitq([reject_implicitq,_9911,_9940,_9969,_9998,_10027],_9900,_9902) --> 
    look_ahead(w(nb(1000,num)),_9911,_9900,_9928),
    not_look_ahead([en],_9940,_9928,_9957),
    not_look_ahead([et],_9969,_9957,_9986),
    not_look_ahead([to],_9998,_9986,_10015),
    not_look_ahead([tre],_10027,_10015,_9902).

reject_implicitq([reject_implicitq,lit(at)],_9867,_9869) --> 
    cc(at,_9867,_9869).

reject_implicitq([reject_implicitq,_9883],_9872,_9874) --> 
    w(noun(error,_9853,_9854,_9855),_9883,_9872,_9874).

reject_implicitq([reject_implicitq,_9901,_9930,_9959],_9890,_9892) --> 
    not_look_ahead(w(adj2(fast,_9866)),_9901,_9890,_9918),
    not_look_ahead(w(adj2(best,_9873)),_9930,_9918,_9947),
    w(adj2(good,nil),_9959,_9947,_9892).

reject_implicitq([reject_implicitq,lit(kan)],_9867,_9869) --> 
    cc(kan,_9867,_9869).

reject_implicitq([reject_implicitq,_9897,_9926,{}],_9886,_9888) --> 
    not_look_ahead([e],_9897,_9886,_9914),
    w(verb(_9858,_9868,_9869),_9926,_9914,_9888),
    {user:_9858\==reach}.

reject_implicitq([reject_implicitq,_9892,_9921],_9881,_9883) --> 
    w(noun(_9861,_9862,_9863,_9864),_9892,_9881,_9909),
    w(verb(_9855,_9856,_9857),_9921,_9909,_9883).

reject_implicitq([reject_implicitq,_9914,_9943,_9972,_10001,_10030,_10059],_9903,_9905) --> 
    not_look_ahead([de],_9914,_9903,_9931),
    not_look_ahead([den],_9943,_9931,_9960),
    not_look_ahead([det],_9972,_9960,_9989),
    not_look_ahead([alle],_10001,_9989,_10018),
    not_look_ahead([en],_10030,_10018,_10047),
    quant_pron(_9865,_9866,_10059,_10047,_9905).

reject_implicitq([reject_implicitq,_9888,_9917],_9877,_9879) --> 
    w(noun(_9857,_9858,_9859,_9860),_9888,_9877,_9905),
    posspron(_9853,_9917,_9905,_9879).

reject_implicitq([reject_implicitq,_9895,{}],_9884,_9886) --> 
    w(noun(_9855,_9865,_9866,_9867),_9895,_9884,_9886),
    {user:testmember(_9855,[possibility,necessity])}.

reject_implicitq([reject_implicitq,_9876],_9865,_9867) --> 
    what(_9876,_9865,_9867).

reject_implicitq([reject_implicitq,lit(der)],_9867,_9869) --> 
    cc(der,_9867,_9869).

reject_implicitq([reject_implicitq,lit(hvor)],_9867,_9869) --> 
    cc(hvor,_9867,_9869).

reject_implicitq([reject_implicitq,lit(hvem)],_9867,_9869) --> 
    cc(hvem,_9867,_9869).

reject_implicitq([reject_implicitq,_9901,_9930,lit('når'),_9970],_9890,_9892) --> 
    not_look_ahead([nr],_9901,_9890,_9918),
    not_look_ahead([n],_9930,_9918,_9947),
    cc('når',_9947,_9969),
    not_look_ahead(w(prep(from)),_9970,_9969,_9892).

reject_implicitq([reject_implicitq,_9876],_9865,_9867) --> 
    so(_9876,_9865,_9867).

reject_implicitq([reject_implicitq,_9888,_9917],_9877,_9879) --> 
    w(nb(1000,num),_9888,_9877,_9905),
    look_ahead([takk],_9917,_9905,_9879).

reject_implicitq([reject_implicitq,lit(da)],_9867,_9869) --> 
    cc(da,_9867,_9869).

reject_implicitq([reject_implicitq,lit(og)],_9867,_9869) --> 
    cc(og,_9867,_9869).

reject_implicitq([reject_implicitq,lit(men)],_9867,_9869) --> 
    cc(men,_9867,_9869).

reject_implicitq([reject_implicitq,_9885,lit(hvis)],_9874,_9876) --> 
    not_look_ahead([om],_9885,_9874,_9902),
    cc(hvis,_9902,_9876).

reject_implicitq([reject_implicitq,lit(fordi)],_9867,_9869) --> 
    cc(fordi,_9867,_9869).

reject_implicitq([reject_implicitq,lit(ja)],_9867,_9869) --> 
    cc(ja,_9867,_9869).

reject_implicitq([reject_implicitq,lit(nei)],_9867,_9869) --> 
    cc(nei,_9867,_9869).

reject_implicitq([reject_implicitq,{},lit(det)],_9875,_9877) --> 
    {user:value(notimeoutflag,true)},
    cc(det,_9875,_9877).

reject_implicitq([reject_implicitq,lit(det),_9898],_9876,_9878) --> 
    cc(det,_9876,_9897),
    w(verb(be,_9856,_9857),_9898,_9897,_9878).

reject_implicitq([reject_implicitq,_9919,_9948,{}],_9908,_9910) --> 
    w(adj2(good,nil),_9919,_9908,_9936),
    w(noun(_9858,_9889,_9890,_9891),_9948,_9936,_9910),
    {user:testmember(_9858,[morrow,morning,day,night,evening,midnight,afternoon,prenoon,saturday,sunday])}.

reject_implicitq([reject_implicitq,_9893,{}],_9882,_9884) --> 
    w(noun(_9855,_9863,def,_9865),_9893,_9882,_9884),
    {user:testmember(_9855,[midnight])}.

reject_implicitq([reject_implicitq,lit('på'),lit('forhånd'),lit(takk)],_9877,_9879) --> 
    cc('på',_9877,_9898),
    cc('forhånd',_9898,_9909),
    cc(takk,_9909,_9879).

reject_implicitq([reject_implicitq,_9916,{},_9955,{},!,_9994],_9905,_9907) --> 
    w(noun(_9867,_9868,_9869,_9870),_9916,_9905,_9933),
    {user:(\+testmember(_9867,[nightbus,airplane,airbus]))},
    endofline(_9955,_9933,_9970),
    {user:value(notimeoutflag,true)},
    !,
    reject(_9994,_9970,_9907).

reject_implicitq([reject_implicitq,lit('nå'),_9898,!,_9927],_9876,_9878) --> 
    cc('nå',_9876,_9897),
    endofline(_9898,_9897,_9913),
    !,
    reject(_9927,_9913,_9878).

no_harmful_adj([no_harmful_adj,_9903,{},!,_9947],_9892,_9894) --> 
    look_ahead(w(adj2(_9863,nil)),_9903,_9892,_9920),
    {user:testmember(_9863,[nearest,good,next])},
    !,
    reject(_9947,_9920,_9894).

no_harmful_adj([no_harmful_adj,[]],_9865,_9865) --> 
    [].

no_harmful_noun([no_harmful_noun,_9901,_9930,!,_9969],_9890,_9892) --> 
    look_ahead(w(noun(_9863,_9864,_9865,n)),_9901,_9890,_9918),
    gmem(_9863,[airport,bridge],_9930,_9918,_9949),
    !,
    accept(_9969,_9949,_9892).

','({\+testmember(_9857,[airport])},no_harmful_noun,[',',_9920,{},!,_9964],_9903,_9905) --> 
    look_ahead(w(name(_9875,_9876,_9857)),_9920,_9903,_9937),
    {user:subclass0(_9857,place)},
    !,
    accept(_9964,_9937,_9905).

no_harmful_noun([no_harmful_noun,_9905,_9949,{},!],_9894,_9896) --> 
    optional([alle],_9905,_9894,_9937),
    look_ahead(w(noun(_9867,sin,_9869,_9870)),_9949,_9937,_9896),
    {user:testmember(_9867,[station])},
    !.

no_harmful_noun([no_harmful_noun,_9904,{},!],_9893,_9895) --> 
    look_ahead(w(noun(_9860,sin,u,n)),_9904,_9893,_9895),
    {user:testmember(_9860,[arrival,departure,station,student])},
    !.

no_harmful_noun([no_harmful_noun,_9895,{}],_9884,_9886) --> 
    not_look_ahead(w(noun(_9857,_9865,_9866,_9867)),_9895,_9884,_9886),
    {user:(\+testmember(_9857,airport))}.

therightprep(from,[therightprep,_9890,!],_9876,_9878) --> 
    w(prep(from),_9890,_9876,_9878),
    !.

therightprep(_9850,[therightprep,_9890,!],_9876,_9878) --> 
    w(prep(_9850),_9890,_9876,_9878),
    !.

not_adjective_only([not_adjective_only,_9887,!],_9876,_9878) --> 
    look_ahead(w(name(_9857,n,_9859)),_9887,_9876,_9878),
    !.

not_adjective_only([not_adjective_only,_9883],_9872,_9874) --> 
    look_ahead(w(adj2(_9854,_9855)),_9883,_9872,_9874).

not_fnlp([not_fnlp,_9905,{},!,_9949],_9894,_9896) --> 
    look_ahead(w(adj2(_9863,nil)),_9905,_9894,_9922),
    {user:testmember(_9863,[first,next,last,previous])},
    !,
    reject(_9949,_9922,_9896).

not_fnlp([not_fnlp,[]],_9865,_9865) --> 
    [].

constrainvehdep(_9850,[constrainvehdep,{},!,_9909],_9880,_9882) --> 
    {user:vartypeid(_9850,thing)},
    !,
    reject(_9909,_9880,_9882).

constrainvehdep(_9850,[constrainvehdep,{},!,_9909],_9880,_9882) --> 
    {user:constrain(_9850,clock)},
    !,
    reject(_9909,_9880,_9882).

constrainvehdep(_9852:_9853,[constrainvehdep,{},{},!,_9932],_9893,_9895) --> 
    {user:constrain(_9852:_9870,number)},
    {user:plausible_busno(_9852)},
    !,
    accept(_9932,_9893,_9895).

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,summerroute)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,winterroute)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,route)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,route_plan)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,vehicle)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,departure)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,arrival)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,connection)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,tram_route)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,tram_route_plan)},
    !.

constrainvehdep(_9850,[constrainvehdep,{},!],_9877,_9877) --> 
    {user:constrain(_9850,trip)},
    !.

hasq(_9850,[hasq,_9922,_9946,_9975,!,_10009,_10033],_9908,_9910) --> 
    has(_9922,_9908,_9937),
    thereit(_9879,_9946,_9937,_9963),
    w(verb(_9875,past,part),_9975,_9963,_9992),
    !,
    accept(_10009,_9992,_10024),
    pushstack(free,([det],w(verb(_9875,pres,fin))),nil,_10024,_10043),
    statement(_9850,_10033,_10043,_9910).

hasq(_9850,[hasq,_9943,_9972,_10001,_10025,_10059,_10088,_10112,_10136,_10160,!,_10189],_9929,_9931) --> 
    w(verb(have,_9897,fin),_9943,_9929,_9960),
    negation0(_9900,_9972,_9960,_9989),
    so0(_10001,_9989,_10016),
    subject(_9902,_9903,_10025,_10016,_10044),
    negation0(_9905,_10059,_10044,_10076),
    adverbx0(_10088,_10076,_10103),
    hatt0(_10112,_10103,_10127),
    negatino(_10136,_10127,_10151),
    sometimes0(_10160,_10151,_10175),
    !,
    pushstack(first,(xnp(_9902,_9903),w(verb(have,pres,fin))),nil,_10175,_10230),
    statement(_9850,_10189,_10230,_9931).

hasq(_9850,[hasq,_9908,_9937,_9966],_9894,_9896) --> 
    w(verb(have,_9864,fin),_9908,_9894,_9925),
    negation0(_9873,_9937,_9925,_9954),
    lock(last,_9954,_9983),
    pushstack(last,w(verb(have,_9864,fin)),nil,_9983,_9989),
    statement(_9850,_9966,_9989,_9978),
    unlock(_9978,_9896).

isq(_9850,[isq,_9973,_9997,_10026,_10055,_10084,_10108,_10137,lit('å'),!,_10187,!,_10235],_9959,_9961) --> 
    be(_9973,_9959,_9988),
    negation0(_9899,_9997,_9988,_10014),
    thereit(_9901,_10026,_10014,_10043),
    negation0(_9903,_10055,_10043,_10072),
    so0(_10084,_10072,_10099),
    w(adj2(_9896,nil),_10108,_10099,_10125),
    gmem(_9896,[true,false,wrong,correct],_10137,_10125,_10156),
    cc('å',_10156,_10181),
    !,
    pushstack(first,[jeg],nil,_10181,_10200),clausal_object1(_9928,_9929,_10187,_10200,_10215),
    !,
    pushstack(first,(xnp(_9928,_9929),w(verb(be,pres,fin)),w(adj2(_9896,nil))),nil,_10215,_10276),
    substatement1(_9850,_10235,_10276,_9961).

isq(_9850,[isq,_9968,_9992,_10021,_10050,_10079,_10103,_10132,lit(at),!,_10182,!,_10221],_9954,_9956) --> 
    be(_9968,_9954,_9983),
    negation0(_9899,_9992,_9983,_10009),
    thereit(_9901,_10021,_10009,_10038),
    negation0(_9903,_10050,_10038,_10067),
    so0(_10079,_10067,_10094),
    w(adj2(_9896,nil),_10103,_10094,_10120),
    gmem(_9896,[true,false,wrong,correct],_10132,_10120,_10151),
    cc(at,_10151,_10176),
    !,
    clausal_object1(_9923,_9924,_10182,_10176,_10201),
    !,
    pushstack(first,(xnp(_9923,_9924),w(verb(be,pres,fin)),w(adj2(_9896,nil))),nil,_10201,_10262),
    substatement1(_9850,_10221,_10262,_9956).

isq(_9850,[isq,_9928,_9957,_9986,_10015,!,[],_10063],_9914,_9916) --> 
    w(verb(be,_9875,fin),_9928,_9914,_9945),
    negation0(_9878,_9957,_9945,_9974),
    thereit(_9880,_9986,_9974,_10003),
    w(verb(_9884,past,part),_10015,_10003,_10032),
    !,
    pushstack(free,w(verb(_9884,_9875,fin)),nil,_10032,_10062),[],
    statement(_9850,_10063,_10062,_9916).

isq(_9850,[isq,_9930,_9954,_9983,_10012,_10041,_10065,!,_10099],_9916,_9918) --> 
    be(_9930,_9916,_9945),
    negation0(_9885,_9954,_9945,_9971),
    pronoun(_9887,_9983,_9971,_10000),
    negation0(_9889,_10012,_10000,_10029),
    not_look_ahead_np(_10041,_10029,_10056),
    not_look_ahead([som],_10065,_10056,_10082),
    !,
    pushstack(first,(pronoun(_9887),w(verb(be,pres,fin))),nil,_10082,_10140),
    substatement1(_9850,_10099,_10140,_9918).

isq(_9850,[isq,_9964,lit(det),_9999,_10028,_10052,_10081,_10110,lit('å'),!,_10160,_10234],_9950,_9952) --> 
    be(_9964,_9950,_9979),
    cc(det,_9979,_9998),
    negation0(_9898,_9999,_9998,_10016),
    so0(_10028,_10016,_10043),
    w(adj2(_9893,nil),_10052,_10043,_10069),
    w(prep(for),_10081,_10069,_10098),
    object(_9909,_9910,_10110,_10098,_10129),
    cc('å',_10129,_10154),
    !,
    pushstack(first,(xnp(_9909,_9910),[vil]),nil,_10154,_10204),clausal_object1(_9922,_9923,_10160,_10204,_10219),
    pushstack(first,(xnp(_9922,_9923),be,w(adj2(_9893,nil))),nil,_10219,_10303),
    substatement1(_9850,_10234,_10303,_9952).

isq(_9850,[isq,_9939,_9963,_9992,_10021,_10045,_10074,!,_10113],_9925,_9927) --> 
    be(_9939,_9925,_9954),
    thereit(_9889,_9963,_9954,_9980),
    negation0(_9891,_9992,_9980,_10009),
    so0(_10021,_10009,_10036),
    w(adj2(_9895,nil),_10045,_10036,_10062),
    prepnog(_9895,_9887,_10074,_10062,_10093),
    !,
    pushstack(first,(something,be,w(adj2(_9895,nil)),w(prep(_9887))),nil,_10093,_10179),
    substatement1(_9850,_10113,_10179,_9927).

isq(_9850,[isq,_9959,_9983,_10012,_10041,_10070,_10094,{},lit('å'),!,_10149],_9945,_9947) --> 
    be(_9959,_9945,_9974),
    negation0(_9893,_9983,_9974,_10000),
    thereit(_9895,_10012,_10000,_10029),
    negation0(_9897,_10041,_10029,_10058),
    so0(_10070,_10058,_10085),
    w(adj2(_9901,nil),_10094,_10085,_10111),
    {user:(\+testmember(_9901,[]))},
    cc('å',_10111,_10143),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_9901,nil)),['å']),nil,_10143,_10159),
    substatement1(_9850,_10149,_10159,_9947).

isq(_9850,[isq,_9939,_9963,_9992,_10021,_10050,_10074,!,_10108],_9925,_9927) --> 
    be(_9939,_9925,_9954),
    negation0(_9887,_9963,_9954,_9980),
    thereit(_9889,_9992,_9980,_10009),
    negation0(_9891,_10021,_10009,_10038),
    so0(_10050,_10038,_10065),
    w(adj2(_9884,nil),_10074,_10065,_10091),
    !,
    pushstack(first,([noe],w(verb(be,pres,fin)),w(adj2(_9884,nil))),nil,_10091,_10118),
    substatement1(_9850,_10108,_10118,_9927).

isq(_9850,[isq,_9913,_9937,_9961,!,_9995],_9899,_9901) --> 
    be(_9913,_9899,_9928),
    dette(_9937,_9928,_9952),
    negation0(_9876,_9961,_9952,_9978),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin))),nil,_9978,_10005),
    substatement1(_9850,_9995,_10005,_9901).

isq(_9850,[isq,_9911,_9935,_9959,!,_9988],_9897,_9899) --> 
    be(_9911,_9897,_9926),
    thereit(_9935,_9926,_9950),
    ikkeingen0(_9959,_9950,_9974),
    !,
    pushstack(free,([det],w(verb(be,pres,fin))),nil,_9974,_9998),
    substatement1(_9850,_9988,_9998,_9899).

isq(_9850,[isq,_9922,_9946,_9975,_10009,!,_10043],_9908,_9910) --> 
    be(_9922,_9908,_9937),
    negation0(_9879,_9946,_9937,_9963),
    subject(_9881,_9882,_9975,_9963,_9994),
    negation0(_9884,_10009,_9994,_10026),
    !,
    pushstack(first,(xnp(_9881,_9882),w(verb(be,pres,fin))),nil,_10026,_10084),
    substatement1(_9850,_10043,_10084,_9910).

isq(_9850,[isq,_9908,_9932,_9956,!,_9990],_9894,_9896) --> 
    be(_9908,_9894,_9923),
    det0(_9932,_9923,_9947),
    negation0(_9873,_9956,_9947,_9973),
    !,
    pushstack(free,w(verb(be,pres,fin)),nil,_9973,_10000),
    substatement1(_9850,_9990,_10000,_9896).

ikkeingen0([ikkeingen0,lit(ingen),!],_9870,_9872) --> 
    cc(ingen,_9870,_9872),
    !.

ikkeingen0([ikkeingen0,_9878],_9867,_9869) --> 
    negation0(_9850,_9878,_9867,_9869).

ynqs(_9850,[ynqs,_9897,_9926,!,_9965],_9883,_9885) --> 
    isynq(_9861,_9897,_9883,_9914),
    orwill(_9861,_9850,_9926,_9914,_9945),
    !,
    accept(_9965,_9945,_9885).

isynq(_9850,[isynq,_9885],_9871,_9873) --> 
    isq(_9850,_9885,_9871,_9873).

isynq(_9850,[isynq,_9885],_9871,_9873) --> 
    ynq(_9850,_9885,_9871,_9873).

orwill(_9850,_9850,[orwill,lit(eller),_9911,!,_9940],_9883,_9885) --> 
    cc(eller,_9883,_9910),
    endofline(_9911,_9910,_9926),
    !,
    accept(_9940,_9926,_9885).

orwill(_9850,_9850 or _9854,[orwill,lit(eller),_9932,!,_9966,_9990,_10019],_9904,_9906) --> 
    cc(eller,_9904,_9931),
    not_look_ahead(w(nb(_9880,_9881)),_9932,_9931,_9949),
    !,
    accept(_9966,_9949,_9981),
    isynq(_9871,_9990,_9981,_10007),
    orwill(_9871,_9854,_10019,_10007,_9906).

orwill(_9850,_9850,[orwill,[]],_9872,_9872) --> 
    [].

ynq(_9850,[ynq,_9945,{},lit(det),_9995,_10024,!,_10058],_9931,_9933) --> 
    w(verb(_9878,_9879,fin),_9945,_9931,_9962),
    {user:(\+testmember(_9878,[be,have]))},
    cc(det,_9962,_9994),
    negation0(_9901,_9995,_9994,_10012),
    look_ahead(w(adj2(_9907,_9908)),_10024,_10012,_10041),
    !,
    pushstack(free,([dette],w(verb(_9878,_9879,fin))),nil,_10041,_10068),
    statreal(_9850,_10058,_10068,_9933).

ynq(_9850,[ynq,_9960,{},lit(det),_10010,lit('å'),_10055,!,_10103],_9946,_9948) --> 
    w(verb(_9887,_9888,fin),_9960,_9946,_9977),
    {user:testmember(_9887,[cost])},
    cc(det,_9977,_10009),
    np0_accept(_9882,_9883,_10010,_10009,_10029),
    cc('å',_10029,_10054),
    pushstack(first,([noen],[vil]),nil,_10054,_10068),clausal_object1(_9913,_9914,_10055,_10068,_10083),
    !,
    pushstack(first,(xnp(_9913,_9914),w(verb(_9887,pres,fin)),xnp(_9882,_9883)),nil,_10083,_10175),
    statreal1(_9850,_10103,_10175,_9948).

ynq(_9850,[ynq,_9937,lit(det),_9972,_10001,_10030,_10064,_10088,!,_10162],_9923,_9925) --> 
    aux1(_9937,_9923,_9952),
    cc(det,_9952,_9971),
    negation0(_9878,_9972,_9971,_9989),
    w(verb(happen,inf,fin),_10001,_9989,_10018),
    subject(_9886,_9887,_10030,_10018,_10049),
    not_look_ahead_vp(_10064,_10049,_10079),
    pushstack(first,(xnp(_9886,_9887),w(verb(happen,pres,fin))),nil,_10079,_10132),statreal1(_9850,_10088,_10132,_10145),
    !,
    accept(_10162,_10145,_9925).

ynq(_9850,[ynq,lit(kan),_9941,_9970,_10004,_10033,_10057,!,_10131],_9916,_9918) --> 
    cc(kan,_9916,_9940),
    negation0(_9875,_9941,_9940,_9958),
    subject(_9877,_9878,_9970,_9958,_9989),
    negation0(_9880,_10004,_9989,_10021),
    not_look_ahead_vp(_10033,_10021,_10048),
    pushstack(first,(xnp(_9877,_9878),w(verb(know1,pres,fin))),nil,_10048,_10101),statreal1(_9850,_10057,_10101,_10114),
    !,
    accept(_10131,_10114,_9918).

ynq(_9850,[ynq,lit('Får'),{},_9955,_9984,_10018,!,_10052],_9920,_9922) --> 
    cc('Får',_9920,_9944),
    {user:testmember('Får',['får',kan,kunne])},
    negation0(_9891,_9955,_9944,_9972),
    subject(_9893,_9894,_9984,_9972,_10003),
    negation0(_9896,_10018,_10003,_10035),
    !,
    pushstack(first,(xnp(_9893,_9894),['Får']),nil,_10035,_10093),
    statreal1(_9850,_10052,_10093,_9922).

ynq(_9850,[ynq,_9947,_9971,_10005,_10034,{},_10073,!,_10107],_9933,_9935) --> 
    aux1(_9947,_9933,_9962),
    subject(_9885,_9886,_9971,_9962,_9990),
    w(verb(_9881,inf,fin),_10005,_9990,_10022),
    not_look_ahead(w(verb(_9898,_9899,_9900)),_10034,_10022,_10051),
    {user:(\+verbtype(_9881,rv))},
    negation0(_9909,_10073,_10051,_10090),
    !,
    pushstack(first,(xnp(_9885,_9886),w(verb(_9881,pres,fin))),nil,_10090,_10148),
    statreal1(_9850,_10107,_10148,_9935).

ynq(_9850,[ynq,lit('så'),!,_9907],_9877,_9879) --> 
    cc('så',_9877,_9901),
    !,
    reject(_9907,_9901,_9879).

ynq(_9850,[ynq,_9944,_9968,_9997,lit(av),!,_10047,_10071,_10095,_10124],_9930,_9932) --> 
    aux1(_9944,_9930,_9959),
    not_look_ahead(w(verb(go,_9892,_9893)),_9968,_9959,_9985),
    subject(_9895,_9896,_9997,_9985,_10016),
    cc(av,_10016,_10041),
    !,
    accept(_10047,_10041,_10062),
    adverbx0(_10071,_10062,_10086),
    negation0(_9900,_10095,_10086,_10112),
    pushstack(first,(xnp(_9895,_9896),w(verb(go,pres,fin)),[av]),nil,_10112,_10165),
    statreal1(_9850,_10124,_10165,_9932).

ynq(_9850,[ynq,_9959,_9983,_10012,_10046,_10070,{},!,_10114,_10138,_10162,_10191],_9945,_9947) --> 
    aux1(_9959,_9945,_9974),
    not_look_ahead(w(verb(go,_9900,_9901)),_9983,_9974,_10000),
    subject(_9903,_9904,_10012,_10000,_10031),
    redundant0(_10046,_10031,_10061),
    w(prep(_9893),_10070,_10061,_10087),
    {user:_9893\==av},
    !,
    accept(_10114,_10087,_10129),
    adverbx0(_10138,_10129,_10153),
    negation0(_9915,_10162,_10153,_10179),
    pushstack(first,(xnp(_9903,_9904),w(verb(go,pres,fin)),w(prep(_9893))),nil,_10179,_10232),
    statreal1(_9850,_10191,_10232,_9947).

ynq(_9850,[ynq,_9974,_10008,_10037,_10066,_10095,_10124,_10158,_10197,!,_10231,_10255,_10279,[],_10354,!,_10456],_9960,_9962) --> 
    aux1(_9897,_9898,_9974,_9960,_9993),
    negation0(_9900,_10008,_9993,_10025),
    not_look_ahead([man],_10037,_10025,_10054),
    not_look_ahead([jeg],_10066,_10054,_10083),
    not_look_ahead([du],_10095,_10083,_10112),
    subject(_9914,_9915,_10124,_10112,_10143),
    preadverbial0(_9917,_9918,_9919,_10158,_10143,_10179),
    negation0(_9921,_10197,_10179,_10214),
    !,
    accept(_10231,_10214,_10246),
    adverbx0(_10255,_10246,_10270),
    negation0(_9923,_10279,_10270,_10296),
    pushstack(free,adverbial1(_9917,_9918,_9919),nil,_10296,_10353),[],
    pushstack(first,(noun_phrase1(_9914,_9915),aux1),nil,_10353,_10426),statreal1(_9850,_10354,_10426,_10439),
    !,
    accept(_10456,_10439,_9962).

ynq(_9850,[ynq,_9927,_9951,_9975,{},!,_10019],_9913,_9915) --> 
    doit(_9927,_9913,_9942),
    you(_9951,_9942,_9966),
    w(verb(_9872,_9879,fin),_9975,_9966,_9992),
    {user:testmember(_9872,[list,show])},
    !,
    pushstack(first,w(verb(_9872,imp,fin)),nil,_9992,_10029),
    command(doit:::_9850,_10019,_10029,_9915).

ynq(_9850,[ynq,_9893,_9917,_9946],_9879,_9881) --> 
    doit(_9893,_9879,_9908),
    negation0(_9860,_9917,_9908,_9934),
    statreal1(_9850,_9946,_9934,_9881).

ynq(_9850,[ynq,_9894,_9918,!,_9952],_9880,_9882) --> 
    aux1(_9894,_9880,_9909),
    prep(_9861,_9918,_9909,_9935),
    !,
    reject(_9952,_9935,_9882).

ynq(_9850,[ynq,_9962,_9991,lit(det),_10036,lit('å'),!,_10086,_10129],_9948,_9950) --> 
    w(verb(_9887,_9888,fin),_9962,_9948,_9979),
    gmem(_9887,[cost,take,be],_9991,_9979,_10010),
    cc(det,_10010,_10035),
    np0_accept(_9882,_9883,_10036,_10035,_10055),
    cc('å',_10055,_10080),
    !,
    pushstack(first,([noen],[vil]),nil,_10080,_10099),clausal_object1(_9915,_9916,_10086,_10099,_10114),
    pushstack(first,(xnp(_9915,_9916),w(verb(_9887,pres,fin)),xnp(_9882,_9883)),nil,_10114,_10201),
    statreal1(_9850,_10129,_10201,_9950).

ynq(_9850,[ynq,_9923,{},_9962,!,_9996],_9909,_9911) --> 
    w(verb(_9869,_9870,fin),_9923,_9909,_9940),
    {user:testmember(_9869,[know,find])},
    negation0(_9888,_9962,_9940,_9979),
    !,
    pushstack(free,w(verb(_9869,_9870,fin)),nil,_9979,_10006),
    statreal1(_9850,_9996,_10006,_9911).

ynq(_9850,[ynq,_9940,{},{},_10004,_10033,!,_10062],_9926,_9928) --> 
    lexv(tv,_9875,_9876,fin,_9940,_9926,_9963),
    {user:_9876\==imp},
    {user:(\+testmember(_9875,[have,think]))},
    not_look_ahead(w(adj2(_9904,_9905)),_10004,_9963,_10021),
    anyadverb0(_10033,_10021,_10048),
    !,
    pushstack(free,w(verb(_9875,_9876,fin)),nil,_10048,_10072),
    statreal1(_9850,_10062,_10072,_9928).

ynq(_9850,[ynq,_9923,_9967,lit(til),lit('å'),!,_10028],_9909,_9911) --> 
    lexv(iv,come,_9877,fin,_9923,_9909,_9946),
    subject(_9880,_9881,_9967,_9946,_9986),
    cc(til,_9986,_10011),
    cc('å',_10011,_10022),
    !,
    pushstack(first,(xnp(_9880,_9881),[vil]),nil,_10022,_10069),
    statreal(_9850,_10028,_10069,_9911).

ynq(_9850,[ynq,_9932,_9976,_10010,lit(hva),!,_10055],_9918,_9920) --> 
    lexv(rv,know,_9880,fin,_9932,_9918,_9955),
    subject(_9883,_9884,_9976,_9955,_9995),
    negation0(_9886,_10010,_9995,_10027),
    cc(hva,_10027,_10049),
    !,
    pushstack(first,(xnp(_9883,_9884),w(verb(know,_9880,fin)),[hva]),nil,_10049,_10096),
    statreal(_9850,_10055,_10096,_9920).

ynq(_9850,[ynq,_9925,_9969,_10003,!,_10032],_9911,_9913) --> 
    lexv(rv,_9876,_9877,fin,_9925,_9911,_9948),
    subject(_9880,_9881,_9969,_9948,_9988),
    infinitive(_10003,_9988,_10018),
    !,
    pushstack(first,(xnp(_9880,_9881),w(verb(_9876,_9877,fin)),['å']),nil,_10018,_10073),
    statreal(_9850,_10032,_10073,_9913).

ynq(_9850,[ynq,_9978,{},_10017,_10046,_10075,_10114,_10148,_10177,_10206,!,_10240],_9964,_9966) --> 
    w(verb(_9897,_9898,fin),_9978,_9964,_9995),
    {user:(\+testmember(_9897,[be,have]))},
    not_look_ahead([det],_10017,_9995,_10034),
    not_look_ahead(w(adj2(_9920,_9921)),_10046,_10034,_10063),
    adverb0(_9893,_9924,_9925,_10075,_10063,_10096),
    subject(_9927,_9928,_10114,_10096,_10133),
    reflexiv0(_9897,_10148,_10133,_10165),
    negation0(_9932,_10177,_10165,_10194),
    rep_particlev0(_9897,_10206,_10194,_10223),
    !,
    pushstack(free,(xnp(_9927,_9928),w(verb(_9897,_9898,fin)),w(adv(_9893))),nil,_10223,_10281),
    statreal(_9850,_10240,_10281,_9966).

ynq(_9850,[ynq,_9935,_9964,_9998,!,_10027,_10051,_10075,_10104,!,_10178],_9921,_9923) --> 
    w(verb(reach,pres,fin),_9935,_9921,_9952),
    np1_accept(_9885,_9888::_9889,_9964,_9952,_9983),
    infinitive(_9998,_9983,_10013),
    !,
    accept(_10027,_10013,_10042),
    adverbx0(_10051,_10042,_10066),
    negation0(_9891,_10075,_10066,_10092),
    pushstack(first,noun_phrase1(_9885,_9888::_9889),nil,_10092,_10148),statreal1(_9850,_10104,_10148,_10161),
    !,
    accept(_10178,_10161,_9923).

ynq(_9850,[ynq,_9900,_9929,!,_9958],_9886,_9888) --> 
    not_look_ahead(w(verb(go,_9866,fin)),_9900,_9886,_9917),
    be(_9929,_9917,_9944),
    !,
    reject(_9958,_9944,_9888).

ynq(_9850,[ynq,_9918,!,_9952,_9976],_9904,_9906) --> 
    w(verb(_9869,pres,pass),_9918,_9904,_9935),
    !,
    thereit0(_9952,_9935,_9967),
    pushstack(free,(w(verb(be,pres,fin)),w(verb(_9869,past,part))),nil,_9967,_9986),
    isq(_9850,_9976,_9986,_9906).

ynq(_9850,[ynq,_9909,_9938,_9967,!,_10001],_9895,_9897) --> 
    w(verb(want,pres,fin),_9909,_9895,_9926),
    not_look_ahead([du],_9938,_9926,_9955),
    not_look_ahead([jeg],_9967,_9955,_9984),
    !,
    reject(_10001,_9984,_9897).

ynq(_9850,[ynq,_9911,_9940,_9964,_9993,!,_10022],_9897,_9899) --> 
    w(verb(go,_9873,fin),_9911,_9897,_9928),
    thereit(_9940,_9928,_9955),
    negation0(_9876,_9964,_9955,_9981),
    anaa(_9993,_9981,_10008),
    !,
    pushstack(first,someone,nil,_10008,_10060),
    statement(_9850,_10022,_10060,_9899).

ynq(_9850,[ynq,_9927,lit(det),{},!,_9997],_9913,_9915) --> 
    lexv(iv,_9872,_9873,fin,_9927,_9913,_9950),
    cc(det,_9950,_9981),
    {user:testmember(_9872,[rain,snow])},
    !,
    pushstack(first,([det],w(verb(_9872,_9873,fin))),nil,_9981,_10007),
    statement(_9850,_9997,_10007,_9915).

ynq(_9850,[ynq,_9937,lit(det),_9977,_10006,!,_10040],_9923,_9925) --> 
    w(verb(_9875,_9876,fin),_9937,_9923,_9954),
    cc(det,_9954,_9976),
    look_ahead(w(prep(_9891)),_9977,_9976,_9994),
    not_look_ahead([e],_10006,_9994,_10023),
    !,
    pushstack(first,(w(noun(vehicle,plu,u,n)),w(verb(_9875,_9876,fin))),nil,_10023,_10050),
    statement(_9850,_10040,_10050,_9925).

ynq(_9850,[ynq,_9931,{},_9970,_9999,!,_10033],_9917,_9919) --> 
    w(verb(_9875,_9876,fin),_9931,_9917,_9948),
    {user:(\+rv_templ(_9875,_9890))},
    negation0(_9892,_9970,_9948,_9987),
    thereit(_9894,_9999,_9987,_10016),
    !,
    pushstack(first,([det],w(verb(_9875,_9876,fin))),nil,_10016,_10043),
    statement(_9850,_10033,_10043,_9919).

ynq(_9850,[ynq,_9938,_9967,_9996,_10025,{},_10059,!,_10093],_9924,_9926) --> 
    w(verb(_9878,_9879,fin),_9938,_9924,_9955),
    not_look_ahead(w(verb,_9891,_9892),_9967,_9955,_9984),
    not_look_ahead([det],_9996,_9984,_10013),
    saa0(_10025,_10013,_10040),
    {user:_9878\==have},
    negation0(_9903,_10059,_10040,_10076),
    !,
    pushstack(free,w(verb(_9878,_9879,fin)),nil,_10076,_10103),
    statreal(_9850,_10093,_10103,_9926).

ynq(_9850,[ynq,{},_9927,_9956,!,_9985],_9903,_9905) --> 
    {user:value(smsflag,true)},
    w(verb(have,pres,fin),_9927,_9903,_9944),
    look_ahead_bus(_9956,_9944,_9971),
    !,
    pushstack(free,w(verb(go,pres,fin)),nil,_9971,_9995),
    statreal(_9850,_9985,_9995,_9905).

ynq(_9850,[ynq,_9935,_9964,{},_10018,{},_10052,!,_10081],_9921,_9923) --> 
    not_look_ahead([vil],_9935,_9921,_9952),
    lexv(iv,_9877,_9878,fin,_9964,_9952,_9987),
    {user:(\+rv_templ(_9877,_9895))},
    saa0(_10018,_9987,_10033),
    {user:_9878\==imp},
    anyadverb0(_10052,_10033,_10067),
    !,
    lock(last,_10067,_10131),
    pushstack(last,lexv(iv,_9877,_9878,fin),nil,_10131,_10137),
    statreal1(_9850,_10081,_10137,_10126),
    unlock(_10126,_9923).

look_ahead_bus([look_ahead_bus,_9899,{}],_9888,_9890) --> 
    look_ahead(w(noun(_9855,_9869,_9870,n)),_9899,_9888,_9890),
    {user:testmember(_9855,[bus,nightbus,number])}.

look_ahead_bus([look_ahead_bus,_9883],_9872,_9874) --> 
    look_ahead(w(adj2(next,nil)),_9883,_9872,_9874).

ppq(_9852:::_9853,[ppq,_9985,_10014,_10053,!,_10087,!,_10126,_10150,_10275],_9971,_9973) --> 
    prep(_9898,_9985,_9971,_10002),
    whx_phrase(_9900,_9852,_9904::_9905,_10014,_10002,_10035),
    w(verb(_9909,pres,pass),_10053,_10035,_10070),
    !,
    noun_phrase1(_9913,_9916::_9917,_10087,_10070,_10106),
    !,
    accept(_10126,_10106,_10141),
    lock(exact,_10141,_10234),pushstack(exact,(prep(_9898),noun_phrase1(_9900,_9904::_9905)),nil,_10234,_10240),adverbial1(_9891,_9892,_9895::_9896,_10150,_10240,_10229),unlock(_10229,_10230),
    pushstack(first,(someone,w(verb(_9909,pres,fin)),noun_phrase1(_9913,_9916::_9917),adverbial1(_9891,_9892,_9895::_9896)),nil,_10230,_10382),
    statreal(_9853,_10275,_10382,_9973).

ppq(_9852:::_9853,[ppq,_9932,_9961,{},!,_10015,_10059,!,_10093],_9918,_9920) --> 
    prepnof(_9876,_9932,_9918,_9949),
    whx_phrase(_9878,_9852,_9882::_9883,_9961,_9949,_9982),
    {user:adjustprep(_9878,_9876,_9889)},
    !,
    forwq(_9853,_9889,_9878,_9882::_9883,_10015,_9982,_10038),
    optionalprep(_9889,_10059,_10038,_10076),
    !,
    accept(_10093,_10076,_9920).

optionalprep(in,[optionalprep,_9891,!,_9925],_9877,_9879) --> 
    prep1(_9858,_9891,_9877,_9908),
    !,
    accept(_9925,_9908,_9879).

optionalprep(_9850,[optionalprep,[]],_9869,_9869) --> 
    [].

forwq(_9850,_9851,_9852,_9855::_9856,[forwq,_9939,!,_9988,_10012],_9916,_9918) --> 
    lexv(_9880,be1,_9882,fin,_9939,_9916,_9962),
    !,
    thereit0(_9988,_9962,_10003),
    pushstack(free,(w(verb(be1,pres,fin)),adverbial1(_9851,_9852,_9855::_9856)),nil,_10003,_10057),
    statreal(_9850,_10012,_10057,_9918).

forwq(_9850,_9851,_9852,_9855::_9856,[forwq,_9922,!,_9951],_9899,_9901) --> 
    doit(_9922,_9899,_9937),
    !,
    pushstack(free,adverbial1(_9851,_9852,_9855::_9856),nil,_9937,_9996),
    statreal(_9850,_9951,_9996,_9901).

forwq(_9850,_9851,_9852,_9855::_9856,[forwq,_9945,{},_9984,_10008],_9922,_9924) --> 
    w(verb(_9882,_9883,_9884),_9945,_9922,_9962),
    {user:_9882\==understand},
    thereit0(_9984,_9962,_9999),
    pushstack(free,(w(verb(_9882,_9883,_9884)),adverbial1(_9851,_9852,_9855::_9856)),nil,_9999,_10053),
    statreal(_9850,_10008,_10053,_9924).

whichq(_9852:::_9855 and _9856,[whichq,_9964,_10003,_10032,_10056,_10080,!,_10114,_10138],_9950,_9952) --> 
    whx_phrase(_9894,_9852,true::_9855,_9964,_9950,_9985),
    w(verb(recommend,_9906,pass),_10003,_9985,_10020),
    det0(_10032,_10020,_10047),
    infinitive(_10056,_10047,_10071),
    w(verb(_9911,inf,_9913),_10080,_10071,_10097),
    !,
    accept(_10114,_10097,_10129),
    pushstack(first,([noen],w(verb(recommend,_9906,fin)),['å'],w(verb(_9911,inf,_9931)),npgap(_9894)),nil,_10129,_10179),
    statreal(_9856,_10138,_10179,_9952).

whichq(_9852:::_9855 and _9856,[whichq,_9942,_9981,_10005,_10034,!,_10073],_9928,_9930) --> 
    whx_phrase(_9882,_9852,true::_9855,_9942,_9928,_9963),
    paux0(_9981,_9963,_9996),
    w(verb(_9893,_9894,pass),_10005,_9996,_10022),
    whodidit(_9897,_9898,_10034,_10022,_10053),
    !,
    pushstack(first,(xnp(_9897,_9898),w(verb(_9893,_9894,fin)),npgap(_9882)),nil,_10053,_10144),
    statreal(_9856,_10073,_10144,_9930).

whichq(_9852:::_9853,[whichq,_9917,_9956,_9995,{}],_9903,_9905) --> 
    whx_phrase(_9870,_9852,_9868::_9853,_9917,_9903,_9938),
    realcomp(_9877,_9878,_9867,_9956,_9938,_9977),
    qverb_phrase(_9870,_9866,_9877,_9878,_9995,_9977,_9905),
    {user:negate(_9866,_9867,_9868)}.

whx_phrase(_9850,_9851,_9854::_9855,[whx_phrase,{},_9976,_10010,{},!,_10054,!,_10115],_9946,_9948) --> 
    {user:value(busflag,true)},
    whichf(_9850,_9851,_9976,_9946,_9995),
    look_ahead(w(verb(_9890,_9891,fin)),_10010,_9995,_10027),
    {user:testmember(_9890,[go,pass,leave,depart,arrive])},
    !,
    lock(exact,_10027,_10074),pushstack(exact,w(noun(vehicle,plu,u,n)),nil,_10074,_10080),noun_phrase1(_9850,_9854::_9855,_10054,_10080,_10069),unlock(_10069,_10070),
    !,
    accept(_10115,_10070,_9948).

whx_phrase(_9850,_9851,_9854::_9855,[whx_phrase,_9944,_9978,_10002,_10031,!,_10060],_9924,_9926) --> 
    whichf(_9850,_9851,_9944,_9924,_9963),
    oter(_9978,_9963,_9993),
    w(noun(_9885,_9886,u,n),_10002,_9993,_10019),
    enn(_10031,_10019,_10046),
    !,
    pushstack(first,(w(noun(_9885,_9886,u,n)),[ulik]),nil,_10046,_10070),
    noun_phrase1(_9850,_9854::_9855,_10060,_10070,_9926).

whx_phrase(_9850,which(_9850),_9854::_9855,[whx_phrase,_9951,_9975,_10004,{},!,_10048],_9931,_9933) --> 
    hvordan(_9951,_9931,_9966),
    not_look_ahead(w(verb(_9888,pres,fin)),_9975,_9966,_9992),
    w(noun(_9879,_9895,_9896,_9897),_10004,_9992,_10021),
    {user:_9879\==type},
    !,
    pushstack(first,w(noun(_9879,sin,u,n)),nil,_10021,_10058),
    noun_phrase1(_9850,_9854::_9855,_10048,_10058,_9933).

whx_phrase(_9850,which(_9850),_9854::_9855,[whx_phrase,lit(hva),_9956,_9985,{},!,_10029],_9925,_9927) --> 
    cc(hva,_9925,_9955),
    not_look_ahead(w(verb(_9886,_9887,_9888)),_9956,_9955,_9973),
    look_ahead(w(noun(_9894,_9895,_9896,_9897)),_9985,_9973,_10002),
    {user:_9894\==type},
    !,
    noun_phrase1(_9850,_9854::_9855,_10029,_10002,_9927).

whx_phrase(_9850,_9851,_9854::_9855,[whx_phrase,_9919,_9953,_9977,!,_10016],_9899,_9901) --> 
    whichf(_9850,_9851,_9919,_9899,_9938),
    type0(_9953,_9938,_9968),
    noun_phrase1(_9850,_9854::_9855,_9977,_9968,_9996),
    !,
    accept(_10016,_9996,_9901).

whx_phrase(_9850,_9851,_9854::_9855,[whx_phrase,_9935,_9969,!,_10003,!,_10051],_9915,_9917) --> 
    whichf(_9850,_9851,_9935,_9915,_9954),
    w(nb(_9877,num),_9969,_9954,_9986),
    !,
    pushstack(first,w(nb(_9877,num)),nil,_9986,_10016),noun_phrase1(_9850,_9854::_9855,_10003,_10016,_10031),
    !,
    accept(_10051,_10031,_9917).

whichf(_9850,which(_9850),[whichf,_9891],_9874,_9876) --> 
    which2(_9891,_9874,_9876).

whichg00(_9850,_9851,_9861:_9850,which(_9861):::_9861 isa _9850 and _9851,[whichg00,[]],_9892,_9892) --> 
    [].

qstatement(_9850,_9853:::_9854,[qstatement,{},_9912],_9885,_9887) --> 
    {user:which_thing(_9850,_9853)},
    statreal(_9854,_9912,_9885,_9887).

what_phrase(_9854:thing,which(_9854:thing),_9854 isa thing,[what_phrase,lit(hva)],_9888,_9890) --> 
    cc(hva,_9888,_9890).

whatq(_9850,[whatq,lit(hva),_9970,_9999,_10033,_10067,_10096,!,_10125,_10149],_9945,_9947) --> 
    cc(hva,_9945,_9969),
    w(verb(use,_9898,fin),_9970,_9969,_9987),
    subject(_9901,_9902,_9999,_9987,_10018),
    np1_accept(_9904,_9905,_10033,_10018,_10052),
    prep1(_9907,_10067,_10052,_10084),
    not_look_ahead_np(_10096,_10084,_10111),
    !,
    accept(_10125,_10111,_10140),
    pushstack(first,(xnp(_9901,_9902),w(verb(use,_9898,fin)),np(_9904,_9905),w(prep(_9907)),npgap(_9891)),nil,_10140,_10251),
    qstatement(_9891,_9850,_10149,_10251,_9947).

whatq(which(_9856):::_9855 ako _9856,[whatq,{},_9930,_9954,_9978,_10007,!],_9906,_9908) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_9930,_9906,_9945),
    art1(_9954,_9945,_9969),
    w(noun(_9855,_9885,u,n),_9978,_9969,_9995),
    endofline(_10007,_9995,_9908),
    !.

whatq(which(_9856):::_9855 ako _9856,[whatq,{},_9944,_9968,{},_10007],_9920,_9922) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_9944,_9920,_9959),
    w(noun(_9855,_9882,u,n),_9968,_9959,_9985),
    {user:(\+testmember(_9855,[clock,special_ticket,price,bus,station]))},
    endofline(_10007,_9985,_9922).

whatq(_9850,[whatq,{},_9934,_9958,_9987,!,_10016],_9910,_9912) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_9934,_9910,_9949),
    look_ahead(w(name(_9887,_9888,_9889)),_9958,_9949,_9975),
    redundant0(_9987,_9975,_10002),
    !,
    pushstack(first,w(verb(describe,imp,fin)),nil,_10002,_10026),
    command(_9850,_10016,_10026,_9912).

whatq(which(_9857:thing):::_9853,[whatq,lit(hva),_9966,_10010,_10044,_10078,_10112],_9941,_9943) --> 
    cc(hva,_9941,_9965),
    lexv(tv,_9892,_9893,fin,_9966,_9965,_9989),
    gmem(_9892,[hold,keep,drive,operate],_10010,_9989,_10029),
    subject(_9907,_9908,_10044,_10029,_10063),
    particlev2(_9892,_9911,_10078,_10063,_10097),
    pushstack(first,(xnp(_9907,_9908),w(verb(_9911,pres,fin)),npgap(_9857:thing)),nil,_10097,_10184),
    statreal(_9853,_10112,_10184,_9943).

whatq(_9852:::_9853,[whatq,{},lit(hva),_10003,_10027,_10061,_10090,lit(kunne),_10145,!,_10179],_9968,_9970) --> 
    {user:which_thing(_9900,_9852)},
    cc(hva,_9968,_10002),
    has(_10003,_10002,_10018),
    subject(_9909,_9910,_10027,_10018,_10046),
    w(verb(expect,past,part),_10061,_10046,_10078),
    optional([at],_10090,_10078,_10122),
    cc(kunne,_10122,_10144),
    w(verb(_9926,_9927,pass),_10145,_10144,_10162),
    !,
    pushstack(first,(xnp(_9909,_9910),w(verb(expect,past,fin)),[at],[noen],w(verb(_9926,pres,fin)),npgap(_9900)),nil,_10162,_10250),
    statreal(_9853,_10179,_10250,_9970).

whatq(_9852:::_9855 and _9856,[whatq,_9939,_9978,_10002,_10031,!,_10070],_9925,_9927) --> 
    what_phrase(_9882,_9852,_9855,_9939,_9925,_9960),
    paux0(_9978,_9960,_9993),
    w(verb(_9890,_9891,pass),_10002,_9993,_10019),
    whodidit(_9894,_9895,_10031,_10019,_10050),
    !,
    pushstack(first,(xnp(_9894,_9895),w(verb(_9890,_9891,fin)),npgap(_9882)),nil,_10050,_10141),
    statreal(_9856,_10070,_10141,_9927).

whatq(_9852:::_9855 and _9856,[whatq,_9976,_10015,{},_10069,_10103,_10137,!,_10176,[],_10249],_9962,_9964) --> 
    what_phrase(_9900,_9852,_9855,_9976,_9962,_9997),
    lexv(rv,_9905,_9906,fin,_10015,_9997,_10038),
    {user:(\+testmember(_9905,[]))},
    subject(_9916,_9917,_10069,_10038,_10088),
    that0(_9905,that,_10103,_10088,_10122),
    subject(_9897,_9898,_10137,_10122,_10156),
    !,
    negation0(_9925,_10176,_10156,_10193),
    pushstack(free,npgap(_9900),nil,_10193,_10248),[],
    pushstack(first,(xnp(_9916,_9917),w(verb(_9905,pres,fin)),[at],xnp(_9897,_9898)),nil,_10248,_10321),
    statreal(_9856,_10249,_10321,_9964).

whatq(_9852:::_9855 and _9856,[whatq,_9939,_9978,lit(det),_10018,_10062,!,_10101],_9925,_9927) --> 
    what_phrase(_9882,_9852,_9855,_9939,_9925,_9960),
    w(verb(be,_9891,fin),_9978,_9960,_9995),
    cc(det,_9995,_10017),
    optional([som],_10018,_10017,_10050),
    specific_phrase(_9900,_9901,_10062,_10050,_10081),
    !,
    pushstack(free,(xnp(_9900,_9901),npgap(_9882)),nil,_10081,_10172),
    statreal(_9856,_10101,_10172,_9927).

whatq(which(_9857:thing):::_9853,[whatq,lit(hva),_9966,_10010,_10034,_10068,_10097,_10126],_9941,_9943) --> 
    cc(hva,_9941,_9965),
    lexv(rv,_9898,_9899,fin,_9966,_9965,_9989),
    look_ahead_subject(_10010,_9989,_10025),
    np0_accept(_9902,_9903,_10034,_10025,_10053),
    negation0(_9905,_10068,_10053,_10085),
    prepnom(_9907,_10097,_10085,_10114),
    pushstack(first,(xnp(_9902,_9903),w(verb(_9898,pres,fin)),w(prep(_9907)),npgap(_9857:thing)),nil,_10114,_10200),
    statreal(_9853,_10126,_10200,_9943).

whatq(_9852:::_9855 and _9856,[whatq,_9967,_10006,{},_10060,_10094,_10123,_10152,_10181],_9953,_9955) --> 
    what_phrase(_9888,_9852,_9855,_9967,_9953,_9988),
    lexv(tv,do,_9896,fin,_10006,_9988,_10029),
    {user:(\+testmember(do,[cost,be2,have]))},
    subject(_9912,_9913,_10060,_10029,_10079),
    not_look_ahead([at],_10094,_10079,_10111),
    not_look_ahead(['å'],_10123,_10111,_10140),
    negation0(_9923,_10152,_10140,_10169),
    pushstack(first,(xnp(_9912,_9913),w(verb(do,pres,fin)),npgap(_9888)),nil,_10169,_10252),
    statreal(_9856,_10181,_10252,_9955).

whatq(_9852:::_9853,[whatq,{},lit(hva),_9963,_9987,_10021,!,_10055],_9928,_9930) --> 
    {user:which_thing(_9882,_9852)},
    cc(hva,_9928,_9962),
    has(_9963,_9962,_9978),
    subject(_9891,_9892,_9987,_9978,_10006),
    w(verb(_9896,past,part),_10021,_10006,_10038),
    !,
    pushstack(first,(xnp(_9891,_9892),w(verb(_9896,past,fin)),npgap(_9882)),nil,_10038,_10126),
    statreal(_9853,_10055,_10126,_9930).

whatq(_9852:::_9853,[whatq,{},lit(hva),_9998,_10022,_10056,_10110,!,_10144,_10261],_9963,_9965) --> 
    {user:which_thing(_9893,_9852)},
    cc(hva,_9963,_9997),
    has(_9998,_9997,_10013),
    subject(_9898,_9899,_10022,_10013,_10041),
    noun(_9901,_9902,_9903,_9904,_9888,_9906,_10056,_10041,_10083),
    prepnom(_9908,_10110,_10083,_10127),
    !,
    lock(exact,_10127,_10225),pushstack(exact,(noun(_9901,_9902,_9903,_9904,_9888,_9906),w(prep(_9908)),npgap(_9893)),nil,_10225,_10231),np1(_9888,_9889,_10144,_10231,_10220),unlock(_10220,_10221),
    pushstack(first,(xnp(_9898,_9899),w(verb(have,pres,fin)),xnp(_9888,_9889)),nil,_10221,_10333),
    statreal(_9853,_10261,_10333,_9965).

whatq(which(_9857:thing):::_9853,[whatq,lit(hva),_9983,{},lit(det),_10033,lit('å'),_10068,!,_10116],_9958,_9960) --> 
    cc(hva,_9958,_9982),
    w(verb(_9902,_9903,fin),_9983,_9982,_10000),
    {user:testmember(_9902,[cost])},
    cc(det,_10000,_10032),
    for0(_10033,_10032,_10048),
    cc('å',_10048,_10067),
    pushstack(first,([noen],[vil]),nil,_10067,_10081),clausal_object1(_9925,_9926,_10068,_10081,_10096),
    !,
    pushstack(first,(xnp(_9925,_9926),w(verb(_9902,pres,fin)),npgap(_9857:thing)),nil,_10096,_10190),
    statreal1(_9853,_10116,_10190,_9960).

for0([for0,lit(for),!],_9870,_9872) --> 
    cc(for,_9870,_9872),
    !.

for0([for0,[]],_9865,_9865) --> 
    [].

whatq(_9852:::_9853,[whatq,lit(hva),_9994,{},lit(det),_10044,!,_10078,{},_10112,_10168],_9969,_9971) --> 
    cc(hva,_9969,_9993),
    w(verb(_9897,_9898,fin),_9994,_9993,_10011),
    {user:testmember(_9897,[cost,weigh])},
    cc(det,_10011,_10043),
    look_ahead(w(prep(_9916)),_10044,_10043,_10061),
    !,
    accept(_10078,_10061,_10093),
    {user:which_thing(_9891,_9852)},
    lock(exact,_10093,_10132),pushstack(exact,w(noun(ticket,sin,u,n)),nil,_10132,_10138),noun_phrase1(_9933,_9936::_9937,_10112,_10138,_10127),unlock(_10127,_10128),
    pushstack(first,(noun_phrase1(_9933,_9936::_9937),lexv(tv,_9897,_9898,fin),npgap(_9891)),nil,_10128,_10273),
    statreal(_9853,_10168,_10273,_9971).

whatq(_9852:::_9855 and _9856,[whatq,_9955,_9994,_10023,_10057,{},!,_10106],_9941,_9943) --> 
    what_phrase(_9885,_9852,_9855,_9955,_9941,_9976),
    w(verb(_9893,_9894,fin),_9994,_9976,_10011),
    gmem(_9893,[cost,weigh],_10023,_10011,_10042),
    np1_accept(_9904,_9905,_10057,_10042,_10076),
    {user:(\+constrain(_9904,place))},
    !,
    pushstack(first,(xnp(_9904,_9905),lexv(tv,_9893,_9894,fin),npgap(_9885)),nil,_10076,_10210),
    statreal(_9856,_10106,_10210,_9943).

whatq(_9852:::_9855 and _9856,[whatq,_9908,_9947,_9986],_9894,_9896) --> 
    what_phrase(_9864,_9852,_9855,_9908,_9894,_9929),
    realcomp(_9866,_9867,_9856,_9947,_9929,_9968),
    qverb_phrase(_9864,id,_9866,_9867,_9986,_9968,_9896).

whatq(which(_9857:thing):::_9853,[whatq,_9939,lit(det),_9974,_10003,_10037,!,_10071],_9925,_9927) --> 
    whatbe(_9939,_9925,_9954),
    cc(det,_9954,_9973),
    not_look_ahead(w(adj2(_9895,nil)),_9974,_9973,_9991),
    subject(_9898,_9899,_10003,_9991,_10022),
    negation0(_9901,_10037,_10022,_10054),
    !,
    pushstack(free,(xnp(_9898,_9899),npgap(_9857:thing)),nil,_10054,_10145),
    statement(_9853,_10071,_10145,_9927).

whatq(_9850,[whatq,_9961,_9985,_10009,_10033,_10062,{},!,_10106],_9947,_9949) --> 
    whatbe(_9961,_9947,_9976),
    so0(_9985,_9976,_10000),
    dent0(_10009,_10000,_10024),
    not_look_ahead(w(nb(_9894,_9895)),_10033,_10024,_10050),
    w(adj2(_9887,nil),_10062,_10050,_10079),
    {user:(\+testmember(_9887,[near,nearest,next]))},
    !,
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin)),w(adj2(_9887,nil))),nil,_10079,_10147),
    whichq(_9850,_10106,_10147,_9949).

whatq(which(_9855):::_9853,[whatq,_9911,_9935,_9959,!,_9993,_10027],_9897,_9899) --> 
    whatbe(_9911,_9897,_9926),
    thereit(_9935,_9926,_9950),
    prep1(for,_9959,_9950,_9976),
    !,
    noun_phrase1(_9855,true::_9853,_9993,_9976,_10012),
    danow0(_10027,_10012,_9899).

whatq(which(_9855):::_9853,[whatq,_9955,lit(det),lit(som),!,_10006,_10030,_10064,_10120],_9941,_9943) --> 
    whatbe(_9955,_9941,_9970),
    cc(det,_9970,_9989),
    cc(som,_9989,_10000),
    !,
    accept(_10006,_10000,_10021),
    np(_9894,_9897::_9898,_10030,_10021,_10049),
    lock(exact,_10049,_10084),pushstack(exact,w(noun(thing,sin,u,n)),nil,_10084,_10090),np(_9855,_9887::_9888,_10064,_10090,_10079),unlock(_10079,_10080),
    pushstack(free,(np(_9894,_9897::_9898),np(_9855,_9887::_9888)),nil,_10080,_10198),
    statreal(_9853,_10120,_10198,_9943).

whatq(which(_9855):::_9853,[whatq,_9935,_9959,_9988,_10017,_10060,!,_10089],_9921,_9923) --> 
    whatbe(_9935,_9921,_9950),
    w(noun(time,_9878,_9879,n),_9959,_9950,_9976),
    look_ahead(w(prep(_9886)),_9988,_9976,_10005),
    pushstack(first,w(noun(departure,sin,u,n)),nil,_10005,_10030),noun_phrase1(_9855,true::_9853,_10017,_10030,_10045),
    danow0(_10060,_10045,_10075),
    !,
    accept(_10089,_10075,_9923).

whatq(_9852:::_9853,[whatq,{},_9955,lit(det),_9990,_10019,_10053,!,_10087],_9931,_9933) --> 
    {user:which_thing(_9882,_9852)},
    whatbe(_9955,_9931,_9970),
    cc(det,_9970,_9989),
    not_look_ahead(w(adj2(_9895,nil)),_9990,_9989,_10007),
    noun_phrase1(_9898,_9901::_9902,_10019,_10007,_10038),
    negation0(_9904,_10053,_10038,_10070),
    !,
    pushstack(free,(np(_9898,_9901::_9902),npgap(_9882)),nil,_10070,_10161),
    statement(_9853,_10087,_10161,_9933).

whatq(which(_9857:thing):::_9853,[whatq,_9952,_9976,_10005,_10034,_10068,_10092,!,_10121],_9938,_9940) --> 
    whatbe(_9952,_9938,_9967),
    not_look_ahead([det],_9976,_9967,_9993),
    not_look_ahead(w(name(_9903,n,_9905)),_10005,_9993,_10022),
    np(_9907,_9908,_10034,_10022,_10053),
    danow0(_10068,_10053,_10083),
    endofline(_10092,_10083,_10107),
    !,
    lock(exact,_10107,_10202),
    pushstack(exact,(xnp(_9907,_9908),w(verb(be,pres,fin)),npgap(_9857:thing)),nil,_10202,_10208),
    statreal(_9853,_10121,_10208,_10197),
    unlock(_10197,_9940).

whatq(which(_9855):::_9853,[whatq,_9918,_9942,_9971,_10000,_10034],_9904,_9906) --> 
    whatbe(_9918,_9904,_9933),
    not_look_ahead([det],_9942,_9933,_9959),
    not_look_ahead(w(name(_9877,n,_9879)),_9971,_9959,_9988),
    np1_accept(_9855,true::_9853,_10000,_9988,_10019),
    danow0(_10034,_10019,_9906).

whatq(which(_9857:thing):::_9853,[whatq,_9958,_9982,_10016,_10045,!,_10079],_9944,_9946) --> 
    whatbe(_9958,_9944,_9973),
    noun_phrase1(_9895,_9896,_9982,_9973,_10001),
    w(verb(_9900,past,part),_10016,_10001,_10033),
    prep(_9904,_10045,_10033,_10062),
    !,
    pushstack(first,(noun_phrase1(_9895,_9896),w(verb(be,pres,fin)),w(verb(_9900,past,part)),w(prep(_9904)),npgap(_9857:thing)),nil,_10062,_10153),
    statement(_9853,_10079,_10153,_9946).

whatq(_9850,[whatq,_9910,_9934],_9896,_9898) --> 
    whatbe(_9910,_9896,_9925),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin))),nil,_9925,_9972),
    whichq(_9850,_9934,_9972,_9898).

whatq(_9850,[whatq,lit(hva),_9969,_9993,_10027,_10056,!,_10090,_10114],_9944,_9946) --> 
    cc(hva,_9944,_9968),
    aux1(_9969,_9968,_9984),
    np1_accept(_9892,_9895::_9896,_9993,_9984,_10012),
    w(verb(use,_9901,pass),_10027,_10012,_10044),
    prep1(_9904,_10056,_10044,_10073),
    !,
    accept(_10090,_10073,_10105),
    pushstack(first,([noen],w(verb(use,_9901,fin)),np(_9892,_9895::_9896),w(prep(_9904)),npgap(_9888)),nil,_10105,_10188),
    qstatement(_9888,_9850,_10114,_10188,_9946).

whatq(_9850,[whatq,lit(hva),_9966,_9995,_10029,!,_10063,_10087],_9941,_9943) --> 
    cc(hva,_9941,_9965),
    w(verb(use,_9892,pass),_9966,_9965,_9983),
    np1_accept(_9895,_9898::_9899,_9995,_9983,_10014),
    prep1(_9901,_10029,_10014,_10046),
    !,
    accept(_10063,_10046,_10078),
    pushstack(first,([noen],w(verb(use,_9892,fin)),np(_9895,_9898::_9899),w(prep(_9901)),npgap(_9885)),nil,_10078,_10161),
    qstatement(_9885,_9850,_10087,_10161,_9943).

whatq(which(_9857:thing):::_9853,[whatq,_9974,_9998,_10032,_10056,_10085,_10114,_10143,{},!,_10187],_9960,_9962) --> 
    whatcan(_9974,_9960,_9989),
    subject(_9904,_9905,_9998,_9989,_10017),
    redundant0(_10032,_10017,_10047),
    negation0(_9907,_10056,_10047,_10073),
    w(verb(_9911,_9912,_9913),_10085,_10073,_10102),
    reflexiv0(_9911,_10114,_10102,_10131),
    prepnom(_9917,_10143,_10131,_10160),
    {user:testmember(_9917,[regarding,with])},
    !,
    pushstack(first,(xnp(_9904,_9905),w(verb(_9911,_9912,_9913)),w(prep(_9917)),npgap(_9857:thing)),nil,_10160,_10261),
    statreal(_9853,_10187,_10261,_9962).

whatq(_9852:::_9853,[whatq,_9943,{},_9977,_10011,lit(om),!,_10056],_9929,_9931) --> 
    whatcan(_9943,_9929,_9958),
    {user:which_thing(_9889,_9852)},
    specific_phrase(_9892,_9893,_9977,_9958,_9996),
    negation0(_9895,_10011,_9996,_10028),
    cc(om,_10028,_10050),
    !,
    pushstack(first,(noun_phrase1(_9892,_9893),w(verb(know1,pres,fin)),npgap(_9889),[om]),nil,_10050,_10127),
    statreal(_9853,_10056,_10127,_9931).

whatq(_9852:::_9853,[whatq,_9984,{},_10018,_10052,_10081,_10110,lit(_9916),{},_10160,!,_10194],_9970,_9972) --> 
    whatcan(_9984,_9970,_9999),
    {user:which_thing(_9894,_9852)},
    specific_phrase(_9901,_9904::_9905,_10018,_9999,_10037),
    negation0(_9907,_10052,_10037,_10069),
    w(verb(_9911,_9912,_9913),_10081,_10069,_10098),
    reflexiv0(_9911,_10110,_10098,_10127),
    cc(_9916,_10127,_10149),
    {user:testmember(_9916,['på',om,til])},
    not_look_ahead(w(noun(_9934,_9935,_9936,_9937)),_10160,_10149,_10177),
    !,
    pushstack(first,(noun_phrase1(_9901,_9904::_9905),w(verb(_9911,_9912,_9913)),npgap(_9894)),nil,_10177,_10268),
    statreal(_9853,_10194,_10268,_9972).

whatq(_9852:::_9853,[whatq,_9977,{},_10011,_10045,_10074,_10103,lit(om),_10143,!,_10182],_9963,_9965) --> 
    whatcan(_9977,_9963,_9992),
    {user:which_thing(_9902,_9852)},
    specific_phrase(_9905,_9908::_9909,_10011,_9992,_10030),
    negation0(_9911,_10045,_10030,_10062),
    w(verb(_9915,_9916,_9917),_10074,_10062,_10091),
    reflexiv0(_9915,_10103,_10091,_10120),
    cc(om,_10120,_10142),
    noun_phrase1(_9897,_9898,_10143,_10142,_10162),
    !,
    pushstack(first,(noun_phrase1(_9905,_9908::_9909),w(verb(_9915,_9916,_9917)),npgap(_9902),w(prep(regarding)),np(_9897,_9898)),nil,_10162,_10287),
    statreal(_9853,_10182,_10287,_9965).

whatq(_9852:::_9853,[whatq,_9977,{},_10011,_10045,_10074,_10118,_10152,!,_10186],_9963,_9965) --> 
    whatcan(_9977,_9963,_9992),
    {user:which_thing(_9894,_9852)},
    specific_phrase(_9901,_9904::_9905,_10011,_9992,_10030),
    negation0(_9907,_10045,_10030,_10062),
    lexv(tv,_9910,_9911,_9912,_10074,_10062,_10097),
    np1(_9914,_9917::_9918,_10118,_10097,_10137),
    prepnom(_9920,_10152,_10137,_10169),
    !,
    pushstack(first,(noun_phrase1(_9901,_9904::_9905),w(verb(_9910,_9911,_9912)),np1(_9914,_9917::_9918),w(prep(_9920)),npgap(_9894)),nil,_10169,_10291),
    statreal(_9853,_10186,_10291,_9965).

whatq(_9852:::_9853,[whatq,_9978,_10002,_10036,_10065,_10094,_10128,!,{},_10172],_9964,_9966) --> 
    whatcan(_9978,_9964,_9993),
    specific_phrase(_9900,_9903::_9904,_10002,_9993,_10021),
    negation0(_9906,_10036,_10021,_10053),
    w(verb(_9910,_9911,_9912),_10065,_10053,_10082),
    noun_phrase1(_9894,_9897::_9898,_10094,_10082,_10113),
    prepnom(_9920,_10128,_10113,_10145),
    !,
    {user:which_thing(_9924,_9852)},
    pushstack(first,(noun_phrase1(_9900,_9903::_9904),w(verb(_9910,_9911,_9912)),npgap(_9924),w(prep(_9920)),np(_9894,_9897::_9898)),nil,_10145,_10280),
    statreal(_9853,_10172,_10280,_9966).

whatq(_9852:::_9853,[whatq,_9950,{},_9984,_10018,_10047,!,_10081],_9936,_9938) --> 
    whatcan(_9950,_9936,_9965),
    {user:which_thing(_9882,_9852)},
    specific_phrase(_9889,_9892::_9893,_9984,_9965,_10003),
    negation0(_9895,_10018,_10003,_10035),
    not_look_ahead(w(verb('_gjøre_',_9902,_9903)),_10047,_10035,_10064),
    !,
    pushstack(first,(noun_phrase1(_9889,_9892::_9893),w(verb(do1,pres,fin)),npgap(_9882)),nil,_10064,_10155),
    statreal(_9853,_10081,_10155,_9938).

whatq(_9852:::_9853,[whatq,_9953,{},_9987,_10021,_10050,_10079,!,_10113],_9939,_9941) --> 
    whatcan(_9953,_9939,_9968),
    {user:which_thing(_9885,_9852)},
    specific_phrase(_9892,_9895::_9896,_9987,_9968,_10006),
    negation0(_9898,_10021,_10006,_10038),
    w(verb(_9902,_9903,_9904),_10050,_10038,_10067),
    reflexiv0(_9902,_10079,_10067,_10096),
    !,
    pushstack(first,(noun_phrase1(_9892,_9895::_9896),w(verb(_9902,_9903,_9904)),npgap(_9885)),nil,_10096,_10187),
    statreal(_9853,_10113,_10187,_9941).

whatq(_9852:::_9853,[whatq,lit(hva),{},_9965,_9994,!,_10033],_9930,_9932) --> 
    cc(hva,_9930,_9954),
    {user:which_thing(_9879,_9852)},
    w(verb(know,_9891,fin),_9965,_9954,_9982),
    specific_phrase(_9894,_9897::_9898,_9994,_9982,_10013),
    !,
    pushstack(first,(noun_phrase1(_9894,_9897::_9898),lexv(tv,know1,_9891,fin),npgap(_9879)),nil,_10013,_10138),
    statreal(_9853,_10033,_10138,_9932).

whatq(_9850,[whatq,lit(hva),_9920,_9944],_9895,_9897) --> 
    cc(hva,_9895,_9919),
    doit(_9920,_9919,_9935),
    pushstack(first,(which,w(noun(thing,sin,u,n)),doit),nil,_9935,_10013),
    whichq(_9850,_9944,_10013,_9897).

whatq(_9850,[whatq,lit(hva),_9942,!,_9991,_10015,_10044],_9917,_9919) --> 
    cc(hva,_9917,_9941),
    lexv(iv,_9878,_9886,fin,_9942,_9941,_9965),
    !,
    accept(_9991,_9965,_10006),
    negation0(_9889,_10015,_10006,_10032),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(_9878,pres,fin))),nil,_10032,_10082),
    whichq(_9850,_10044,_10082,_9919).

whenq(which(_9855):::_9853,[whenq,_9924,_9963,lit(det),_9998,!,_10027],_9910,_9912) --> 
    when_adverbialq(_9875,_9855,_9879::_9880,_9924,_9910,_9945),
    be(_9963,_9945,_9978),
    cc(det,_9978,_9997),
    that0(_9998,_9997,_10013),
    !,
    pushstack(free,xadverbial1(_9875,_9855,_9879::_9880),nil,_10013,_10068),
    statreal(_9853,_10027,_10068,_9912).

whenq(which(_9855):::_9853,[whenq,_9928,_9967,!,_10001,_10025],_9914,_9916) --> 
    when_adverbialq(_9872,_9855,_9876::_9877,_9928,_9914,_9949),
    look_ahead(w(noun(bus,_9891,_9892,n)),_9967,_9949,_9984),
    !,
    accept(_10001,_9984,_10016),
    pushstack(free,xadverbial1(_9872,_9855,_9876::_9877),nil,_10016,_10070),
    statreal(_9853,_10025,_10070,_9916).

whenq(which(_9855):::_9853,[whenq,_9962,_10001,_10030,{},!,_10074],_9948,_9950) --> 
    when_adverbialq(_9881,_9855,_9885::_9886,_9962,_9948,_9983),
    w(verb(go,_9898,fin),_10001,_9983,_10018),
    look_ahead(w(prep(_9905)),_10030,_10018,_10047),
    {user:testmember(_9905,[from,to])},
    !,
    pushstack(free,(w(noun(bus,sin,u,n)),w(verb(go,_9898,fin)),xadverbial1(_9881,_9855,_9885::_9886)),nil,_10047,_10119),
    statreal(_9853,_10074,_10119,_9950).

whenq(which(_9855):::_9853,[whenq,_9937,_9976,_10000,_10024,!,_10063,_10087,_10116],_9923,_9925) --> 
    when_adverbialq(_9880,_9855,_9889::_9890,_9937,_9923,_9958),
    be(_9976,_9958,_9991),
    detnexttime(_10000,_9991,_10015),
    np1(_9878,_9895::_9896,_10024,_10015,_10043),
    !,
    accept(_10063,_10043,_10078),
    negation0(_9898,_10087,_10078,_10104),
    whencomplex(_9878,_9895::_9896,_9880,_9855,_9889::_9890,_9853,_10116,_10104,_9925).

whenq(which(_9855):::_9853,[whenq,_9915,_9939,{},!,_9983],_9901,_9903) --> 
    when(_9915,_9901,_9930),
    look_ahead(w(prep(_9873)),_9939,_9930,_9956),
    {user:testmember(_9873,[from,to])},
    !,
    reject(_9983,_9956,_9903).

whenq(which(_9855):::_9853,[whenq,_9980,_10004,_10043,!,_10087,_10111,!,_10195,_10219],_9966,_9968) --> 
    when(_9980,_9966,_9995),
    preadverbial1(_9897,_9898,_9901::_9902,_10004,_9995,_10025),
    preadverbial1(_9890,_9891,_9894::_9895,_10043,_10025,_10064),
    !,
    accept(_10087,_10064,_10102),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_10102,_10155),adverbial1(_9924,_9855,_9928::_9929,_10111,_10155,_10172),
    !,
    accept(_10195,_10172,_10210),
    lock(last,_10210,_10337),
    pushstack(last,(adverbial1(in,_9855,_9928::_9929),adverbial1(_9897,_9898,_9901::_9902),adverbial1(_9890,_9891,_9894::_9895)),nil,_10337,_10343),
    question0(_9853,_10219,_10343,_10332),
    unlock(_10332,_9968).

whenq(which(_9855):::_9853,[whenq,_9967,_9991,_10020,!,_10064,_10088,!,_10171,_10195],_9953,_9955) --> 
    when(_9967,_9953,_9982),
    not_look_ahead([e],_9991,_9982,_10008),
    adverbial1(_9887,_9888,_9891::_9892,_10020,_10008,_10041),
    !,
    accept(_10064,_10041,_10079),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_10079,_10131),adverbial1(_9918,_9855,_9922::_9923,_10088,_10131,_10148),
    !,
    accept(_10171,_10148,_10186),
    lock(last,_10186,_10278),
    pushstack(last,(xadverbial1(in,_9855,_9922::_9923),xadverbial1(_9887,_9888,_9891::_9892)),nil,_10278,_10284),
    question0(_9853,_10195,_10284,_10273),
    unlock(_10273,_9955).

whenq(which(_9855):::_9853,[whenq,_9947,_9971,!,_10015,!,_10111],_9933,_9935) --> 
    when(_9947,_9933,_9962),
    adverb(_9878,_9879,pre,_9971,_9962,_9992),
    !,
    lock(exact,_9992,_10065),pushstack(exact,(prep(in),w(noun(time,sin,u,n))),nil,_10065,_10071),adverbial1(_9898,_9855,_9902::_9903,_10015,_10071,_10060),unlock(_10060,_10061),
    !,
    pushstack(free,(xadverbial1(in,_9855,_9902::_9903),xadverb(_9878,_9879)),nil,_10061,_10187),
    question0(_9853,_10111,_10187,_9935).

whenq(which(_9855):::_9853,[whenq,_9959,_9998,{},_10037,_10061,!,_10095],_9945,_9947) --> 
    howlongto(_9884,_9855,_9888::_9889,_9959,_9945,_9980),
    w(adj2(_9900,nil),_9998,_9980,_10015),
    {user:testmember(_9900,[easy,possible,good])},
    infinitive(_10037,_10015,_10052),
    w(verb(_9916,inf,fin),_10061,_10052,_10078),
    !,
    lock(last,_10078,_10175),
    pushstack(last,(someone,w(verb(_9916,pres,fin)),adverbial1(_9884,_9855,_9888::_9889)),nil,_10175,_10181),
    statement(_9853,_10095,_10181,_10170),
    unlock(_10170,_9947).

whenq(which(_9855):::_9853,[whenq,_9931,_9970,!,_10004],_9917,_9919) --> 
    howlongto(_9872,_9855,_9876::_9877,_9931,_9917,_9952),
    w(verb(_9888,_9889,fin),_9970,_9952,_9987),
    !,
    lock(last,_9987,_10056),
    pushstack(last,(w(verb(_9888,pres,fin)),adverbial1(_9872,_9855,_9876::_9877)),nil,_10056,_10062),
    statement(_9853,_10004,_10062,_10051),
    unlock(_10051,_9919).

whenq(which(_9855):::_9853,[whenq,_9925,!,_9969,_10042,_10071],_9911,_9913) --> 
    when_adverbialq(_9871,_9855,_9875::_9876,_9925,_9911,_9946),
    !,
    pushstack(free,xadverbial1(_9871,_9855,_9875::_9876),nil,_9946,_10017),question0(_9853,_9969,_10017,_10030),
    not_look_ahead([a],_10042,_10030,_10059),
    prep0(_9869,_10071,_10059,_9913).

detnexttime([detnexttime,lit(det),_9898,_9922,!],_9876,_9878) --> 
    cc(det,_9876,_9897),
    nexttime0(_9898,_9897,_9913),
    that0(_9922,_9913,_9878),
    !.

detnexttime([detnexttime,_9882,_9906,!],_9871,_9873) --> 
    nexttime(_9882,_9871,_9897),
    that0(_9906,_9897,_9873),
    !.

detnexttime([detnexttime,lit(at),!],_9870,_9872) --> 
    cc(at,_9870,_9872),
    !.

nexttime0([nexttime0,_9876],_9865,_9867) --> 
    nexttime(_9876,_9865,_9867).

nexttime0([nexttime0,[]],_9865,_9865) --> 
    [].

nexttime([nexttime,_9888,_9917],_9877,_9879) --> 
    w(adj2(next,nil),_9888,_9877,_9905),
    optional([gang],_9917,_9905,_9879).

whencomplex(_9850,_9857::_9858,_9852,_9853,_9860::_9861,_9855,[whencomplex,_9967,_9991,!,_10025,_10049],_9938,_9940) --> 
    do0(_9967,_9938,_9982),
    w(verb(_9893,_9894,finy),_9991,_9982,_10008),
    !,
    accept(_10025,_10008,_10040),
    pushstack(free,(np(_9850,_9857::_9858),w(verb(_9893,pres,fin)),adverbial1(_9852,_9853,_9860::_9861)),nil,_10040,_10128),
    statreal(_9855,_10049,_10128,_9940).

whencomplex(_9850,_9857::_9858,_9852,_9853,_9860::_9861,_9855,[whencomplex,_9949],_9920,_9922) --> 
    pushstack(free,(np(_9850,_9857::_9858),w(verb(be,pres,fin)),adverbial1(_9852,_9853,_9860::_9861)),nil,_9920,_10028),
    statreal(_9855,_9949,_10028,_9922).

verb0(_9850,[verb0,_9895,!,_9929],_9881,_9883) --> 
    w(verb(_9850,_9861,_9862),_9895,_9881,_9912),
    !,
    accept(_9929,_9912,_9883).

verb0(be1,[verb0,[]],_9869,_9869) --> 
    [].

subjectverb(_9850,_9851,_9852,[subjectverb,_9910,_9939,!],_9890,_9892) --> 
    w(verb(_9852,_9863,fin),_9910,_9890,_9927),
    subject(_9850,_9851,_9939,_9927,_9892),
    !.

subjectverb(_9850,_9851,_9852,[subjectverb,_9910,_9934,_9968],_9890,_9892) --> 
    aux1(_9910,_9890,_9925),
    subject(_9850,_9851,_9934,_9925,_9953),
    w(verb(_9852,inf,fin),_9968,_9953,_9892).

whereq(which(_9855):::_9853,[whereq,_9974,_9998,_10037,_10066,_10090,_10119,!,_10158,_10182,!,_10211,[],_10281,!,_10355],_9960,_9962) --> 
    dummyprep0(_9974,_9960,_9989),
    where_adverbial(_9899,_9855,_9901,_9998,_9989,_10019),
    w(verb(_9905,_9906,fin),_10037,_10019,_10054),
    thereit0(_10066,_10054,_10081),
    not_look_ahead(w(nb(_9913,_9914)),_10090,_10081,_10107),
    subject(_9916,_9917,_10119,_10107,_10138),
    !,
    accept(_10158,_10138,_10173),
    dummyprep0(_10182,_10173,_10197),
    !,
    accept(_10211,_10197,_10226),
    pushstack(free,adverbial1(_9899,_9855,_9901),nil,_10226,_10280),[],
    pushstack(first,(xnp(_9916,_9917),w(verb(_9905,_9906,fin))),nil,_10280,_10325),substatement1(_9853,_10281,_10325,_10338),
    !,
    accept(_10355,_10338,_9962).

whereq(which(_9855):::_9853,[whereq,{},_9970,_9994,!,_10028,!,_10094,_10163],_9946,_9948) --> 
    {user:(\+value(dialog,1))},
    where(_9970,_9946,_9985),
    w(verb(go,_9888,fin),_9994,_9985,_10011),
    !,
    lock(exact,_10011,_10048),pushstack(exact,w(noun(place,sin,u,n)),nil,_10048,_10054),adverbial1(nil,_9855,_9905::_9906,_10028,_10054,_10043),unlock(_10043,_10044),
    !,
    pushstack(free,(w(verb(go,pres,fin)),adverbial1(nil,_9855,_9905::_9906)),nil,_10044,_10138),ynq(_9853,_10094,_10138,_10151),
    dummyprep0(_10163,_10151,_9948).

whereq(which(_9855):::_9853,[whereq,_9963,_9987,_10016,!,_10060,!,_10156],_9949,_9951) --> 
    where(_9963,_9949,_9978),
    not_look_ahead(w(prep(after)),_9987,_9978,_10004),
    adverbial1(_9881,_9882,_9885::_9886,_10016,_10004,_10037),
    !,
    lock(exact,_10037,_10110),pushstack(exact,(prep(in),w(noun(place,sin,u,n))),nil,_10110,_10116),adverbial1(_9914,_9855,_9918::_9919,_10060,_10116,_10105),unlock(_10105,_10106),
    !,
    pushstack(free,(adverbial1(in,_9855,_9918::_9919),adverbial1(_9881,_9882,_9885::_9886)),nil,_10106,_10236),
    question0(_9853,_10156,_10236,_9951).

whereq(which(_9855):::_9853,[whereq,_9948,_9987,lit(det),_10022,!,[],_10105],_9934,_9936) --> 
    where_adverbial(_9889,_9855,_9893::_9894,_9948,_9934,_9969),
    be(_9987,_9969,_10002),
    cc(det,_10002,_10021),
    w(adj2(_9886,_9887),_10022,_10021,_10039),
    !,
    pushstack(free,adverbial1(_9889,_9855,_9893::_9894),nil,_10039,_10104),[],
    pushstack(first,([det],be,w(adj2(_9886,_9887))),nil,_10104,_10143),
    substatement1(_9853,_10105,_10143,_9936).

whereq(which(_9855):::_9853,[whereq,_9924,_9963,lit(det),_9998,!,_10027],_9910,_9912) --> 
    where_adverbial(_9875,_9855,_9879::_9880,_9924,_9910,_9945),
    be(_9963,_9945,_9978),
    cc(det,_9978,_9997),
    that0(_9998,_9997,_10013),
    !,
    pushstack(free,adverbial1(_9875,_9855,_9879::_9880),nil,_10013,_10072),
    statreal(_9853,_10027,_10072,_9912).

whereq(_9850,[whereq,_9918,_9942,_9966],_9904,_9906) --> 
    where(_9918,_9904,_9933),
    be(_9942,_9933,_9957),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),w(verb(be1,pres,fin))),nil,_9957,_10034),
    ppq(_9850,_9966,_10034,_9906).

whereq(which(_9855):::_9853,[whereq,_9897,_9921,!,_9950],_9883,_9885) --> 
    where(_9897,_9883,_9912),
    many1(_9921,_9912,_9936),
    !,
    reject(_9950,_9936,_9885).

whereq(_9850,[whereq,_9912,_9936,_9960],_9898,_9900) --> 
    where(_9912,_9898,_9927),
    aux1(_9936,_9927,_9951),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),doit),nil,_9951,_10056),
    ppq(_9850,_9960,_10056,_9900).

whereq(_9850,[whereq,_9904,_9928,_9952],_9890,_9892) --> 
    where(_9904,_9890,_9919),
    look_ahead_vp(_9928,_9919,_9943),
    pushstack(first,(which,w(noun(place,sin,u,n))),nil,_9943,_9990),
    whichq(_9850,_9952,_9990,_9892).

when_adverbial(in,_9851,_9854::_9855,[when_adverbial,_9918,_9942,!,{}],_9898,_9900) --> 
    which(_9918,_9898,_9933),
    np1(_9851,_9854::_9855,_9942,_9933,_9900),
    !,
    {user:testconstraint(_9851,time)}.

when_adverbialq(in,_9860:time,_9854::_9860 isa time and _9854,[when_adverbialq,_9907],_9887,_9889) --> 
    when(_9907,_9887,_9889).

when_adverbial(in,_9860:time,_9854::_9860 isa time and _9854,[when_adverbial,_9907],_9887,_9889) --> 
    whenx(_9907,_9887,_9889).

where_adverbial(nil,_9851,_9852,[where_adverbial,_9912,_9936,!,{}],_9892,_9894) --> 
    which(_9912,_9892,_9927),
    np1(_9851,_9852,_9936,_9927,_9894),
    !,
    {user:testconstraint(_9851,place)}.

where_adverbial(nil,_9851,_9852,[where_adverbial,lit(hvor),_9918,!],_9887,_9889) --> 
    cc(hvor,_9887,_9917),
    np00(place,_9851,_9852,_9918,_9917,_9889),
    !.

dummyprep0([dummyprep0,_9879,!],_9868,_9870) --> 
    dummyprep(_9879,_9868,_9870),
    !.

dummyprep0([dummyprep0,[]],_9865,_9865) --> 
    [].

dummyprep([dummyprep,_9884,!,_9918],_9873,_9875) --> 
    prep1(from,_9884,_9873,_9901),
    !,
    accept(_9918,_9901,_9875).

dummyprep([dummyprep,_9884,!,_9918],_9873,_9875) --> 
    prep1(to,_9884,_9873,_9901),
    !,
    accept(_9918,_9901,_9875).

wherefromq(_9850,[wherefromq,_9909,!,_9938],_9895,_9897) --> 
    wherefrom(_9909,_9895,_9924),
    !,
    pushstack(first,(prep(from),which,w(noun(place,sin,u,n))),nil,_9924,_10007),
    ppq(_9850,_9938,_10007,_9897).

whoq(_9850,[whoq,_9934,_9958,_9987,!,_10021],_9920,_9922) --> 
    who(_9934,_9920,_9949),
    look_ahead(w(noun(_9883,sin,def,n)),_9958,_9949,_9975),
    w(verb(_9875,_9876,fin),_9987,_9975,_10004),
    !,
    pushstack(first,(which,w(noun(agent,sin,u,n)),w(verb(_9875,_9876,fin))),nil,_10004,_10059),
    whichq(_9850,_10021,_10059,_9922).

whoq(_9850,[whoq,_9901,_9925],_9887,_9889) --> 
    who(_9901,_9887,_9916),
    pushstack(first,(which,w(noun(agent,sin,u,n))),nil,_9916,_9963),
    whichq(_9850,_9925,_9963,_9889).

whoseq(_9850,[whoseq,_9926,_9950,_10004],_9912,_9914) --> 
    whose(_9926,_9912,_9941),
    noun(_9873,_9874,u,n,_9877,_9878,_9950,_9941,_9977),
    pushstack(first,(who,w(verb(have,pres,fin)),a,noun(_9873,_9874,u,n,_9877,_9878),that),nil,_9977,_10138),
    whoq(_9850,_10004,_10138,_9914).

whyq(explain:::_9853,[whyq,_9891,_9915],_9877,_9879) --> 
    hvorfor(_9891,_9877,_9906),
    isq(_9853,_9915,_9906,_9879).

whyq(explain:::_9853,[whyq,_9891,_9915],_9877,_9879) --> 
    hvorfor(_9891,_9877,_9906),
    ynq(_9853,_9915,_9906,_9879).

whyq(explain:::_9853,[whyq,_9891,_9915],_9877,_9879) --> 
    hvorfor(_9891,_9877,_9906),
    hasq(_9853,_9915,_9906,_9879).

howq(doit:::reply('OK'),[howq,lit(hvordan),_9921,lit(det),!,_9966],_9896,_9898) --> 
    cc(hvordan,_9896,_9920),
    w(verb(go,_9874,fin),_9921,_9920,_9938),
    cc(det,_9938,_9960),
    !,
    skip_rest(_9966,_9960,_9898).

howq(explain:::_9853,[howq,lit(hvordan),_9936,_9960,_9989,!,_10018],_9911,_9913) --> 
    cc(hvordan,_9911,_9935),
    erdetaa0(_9936,_9935,_9951),
    w(verb(_9878,inf,fin),_9960,_9951,_9977),
    mex0(_9989,_9977,_10004),
    !,
    pushstack(first,([jeg],w(verb(_9878,pres,fin))),nil,_10004,_10028),
    statreal1(_9853,_10018,_10028,_9913).

howq(explain:::_9853,[howq,lit(hvorfor),_9930,!,_9964],_9905,_9907) --> 
    cc(hvorfor,_9905,_9929),
    w(verb(_9872,inf,fin),_9930,_9929,_9947),
    !,
    pushstack(first,([jeg],w(verb(_9872,pres,fin))),nil,_9947,_9974),
    statreal1(_9853,_9964,_9974,_9907).

howq(explain:::_9853,[howq,lit(hvordan),_9928,[],_10002],_9903,_9905) --> 
    cc(hvordan,_9903,_9927),
    look_ahead(w(verb(be,_9873,fin)),_9928,_9927,_9945),
    pushstack(free,xadverbial1(how,nil,_9883::_9883),nil,_9945,_10001),[],
    isq(_9853,_10002,_10001,_9905).

howq(explain:::_9853,[howq,_9915,_9939,_9963,_9997],_9901,_9903) --> 
    how(_9915,_9901,_9930),
    be(_9939,_9930,_9954),
    np1_accept(_9876,_9877,_9963,_9954,_9982),
    pushstack(first,(xnp(_9876,_9877),w(verb(be,pres,fin))),nil,_9982,_10038),
    substatement1(_9853,_9997,_10038,_9903).

howq(explain:::_9853,[howq,_9921,_9945,lit(det),_9980,!,_10014],_9907,_9909) --> 
    how(_9921,_9907,_9936),
    be(_9945,_9936,_9960),
    cc(det,_9960,_9979),
    negation0(_9884,_9980,_9979,_9997),
    !,
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_9997,_10024),
    substatement1(_9853,_10014,_10024,_9909).

howq(explain:::_9853,[howq,_9905,_9949,_9973,!,_10002],_9891,_9893) --> 
    lexv(iv,tell,imp,fin,_9905,_9891,_9928),
    me0(_9949,_9928,_9964),
    how(_9973,_9964,_9988),
    !,
    statreal1(_9853,_10002,_9988,_9893).

howq(_9850,[howq,_9900,_9924,_9948,!,_9977],_9886,_9888) --> 
    how(_9900,_9886,_9915),
    be(_9924,_9915,_9939),
    thereit(_9948,_9939,_9963),
    !,
    pushstack(first,whatbe,nil,_9963,_10015),
    whatq(_9850,_9977,_10015,_9888).

howq(_9850,[howq,_9907,_9931,lit(det),_9966,!,_10000],_9893,_9895) --> 
    how(_9907,_9893,_9922),
    be(_9931,_9922,_9946),
    cc(det,_9946,_9965),
    prep1(with,_9966,_9965,_9983),
    !,
    pushstack(first,whatbe,nil,_9983,_10038),
    whatq(_9850,_10000,_10038,_9895).

howq(explain:::_9853,[howq,_9891,_9915],_9877,_9879) --> 
    how(_9891,_9877,_9906),
    ynq(_9853,_9915,_9906,_9879).

howq(explain:::_9853,[howq,_9891,_9915],_9877,_9879) --> 
    how(_9891,_9877,_9906),
    hasq(_9853,_9915,_9906,_9879).

erdetaa0([erdetaa0,_9892,lit(det),lit('å'),!,_9943],_9881,_9883) --> 
    be(_9892,_9881,_9907),
    cc(det,_9907,_9926),
    cc('å',_9926,_9937),
    !,
    accept(_9943,_9937,_9883).

erdetaa0([erdetaa0,[]],_9865,_9865) --> 
    [].

howlongto(_9850,_9851,_9854::_9855,[howlongto,_9928,lit(det),lit(lenge),_9974,_10003],_9908,_9910) --> 
    be(_9928,_9908,_9943),
    cc(det,_9943,_9962),
    cc(lenge,_9962,_9973),
    prep1(to,_9974,_9973,_9991),
    lock(exact,_9991,_10020),
    pushstack(exact,['når'],nil,_10020,_10026),
    when_adverbial(_9850,_9851,_9854::_9855,_10003,_10026,_10015),
    unlock(_10015,_9910).

howlongto(_9850,_9851,_9854::_9855,[howlongto,lit(hvor),lit(lenge),_9955,lit(det),_9990,_10019],_9913,_9915) --> 
    cc(hvor,_9913,_9943),
    cc(lenge,_9943,_9954),
    be(_9955,_9954,_9970),
    cc(det,_9970,_9989),
    prep1(to,_9990,_9989,_10007),
    lock(exact,_10007,_10036),
    pushstack(exact,['når'],nil,_10036,_10042),
    when_adverbial(_9850,_9851,_9854::_9855,_10019,_10042,_10031),
    unlock(_10031,_9915).

howlongto(_9850,_9851,_9854::_9855,[howlongto,_9914,_9953,_9977,_10001],_9894,_9896) --> 
    when_adverbial(_9850,_9851,_9854::_9855,_9914,_9894,_9935),
    be(_9953,_9935,_9968),
    thereit(_9977,_9968,_9992),
    that0(_10001,_9992,_9896).

howadjq(_9850,[howadjq,_9976,_10000,{},_10039,{},lit(det),_10089,_10118,_10142,_10171,!,_10242],_9962,_9964) --> 
    hvor(_9976,_9962,_9991),
    howadj1(_9885,_10000,_9991,_10017),
    {user:testmember(_9885,[duration])},
    w(verb(_9896,_9897,fin),_10039,_10017,_10056),
    {user:testmember(_9896,[take,be])},
    cc(det,_10056,_10088),
    not_look_ahead(['å'],_10089,_10088,_10106),
    redundant0(_10118,_10106,_10133),
    not_look_ahead(w(prep(with)),_10142,_10133,_10159),
    pushstack(first,(which,w(noun(_9885,sin,u,n)),w(verb(_9896,_9897,fin))),nil,_10159,_10212),whichq(_9850,_10171,_10212,_10225),
    !,
    accept(_10242,_10225,_9964).

howadjq(_9850,[howadjq,_9940,_9964,_9993,{},!,_10032],_9926,_9928) --> 
    hvor(_9940,_9926,_9955),
    howadj1(_9879,_9964,_9955,_9981),
    docan(_9993,_9981,_10008),
    {user:testmember(_9879,[frequency,speed,lateness,earliness,duration,distance])},
    !,
    pushstack(first,(prep(with),which,w(noun(_9879,sin,u,n)),doit),nil,_10008,_10129),
    ppq(_9850,_10032,_10129,_9928).

howadjq(_9850,[howadjq,_9956,_9980,{},_10019,{},!,_10063],_9942,_9944) --> 
    hvor(_9956,_9942,_9971),
    howadj1(_9888,_9980,_9971,_9997),
    {user:testmember(_9888,[frequency,earliness,lateness])},
    w(verb(_9884,_9904,_9886),_10019,_9997,_10036),
    {user:(\+_9884=be)},
    !,
    pushstack(first,(prep(with),which,w(noun(_9888,sin,u,n)),w(verb(_9884,pres,_9886))),nil,_10036,_10131),
    ppq(_9850,_10063,_10131,_9944).

howadjq(_9850,[howadjq,_9926,_9950,_9979,_10013,_10037],_9912,_9914) --> 
    hvor(_9926,_9912,_9941),
    howadj1(_9879,_9950,_9941,_9967),
    gmem(_9879,[distance],_9979,_9967,_9998),
    be(_10013,_9998,_10028),
    pushstack(first,(which,w(noun(_9879,sin,u,n)),w(verb(have,pres,fin))),nil,_10028,_10075),
    whichq(_9850,_10037,_10075,_9914).

howadjq(which(_9860:time):::_9860 isa time and _9856,[howadjq,_9967,_9991,_10020,lit(det),lit(til),_10071,!,_10110,_10149],_9953,_9955) --> 
    hvor(_9967,_9953,_9982),
    howadj1(duration,_9991,_9982,_10008),
    w(verb(be,_9908,fin),_10020,_10008,_10037),
    cc(det,_10037,_10059),
    cc(til,_10059,_10070),
    clausal_object0(_9915,_9916,_10071,_10070,_10090),
    !,
    np00(time,_9860:time,_9901,_10110,_10090,_10131),
    pushstack(first,(xnp(_9915,_9916),w(verb(exist,_9908,fin)),xadverbial1(nil,_9860,_9901)),nil,_10131,_10221),
    statreal(_9856,_10149,_10221,_9955).

howadjq(_9850,[howadjq,_9964,_10008,_10032,_10061,_10090,_10124,!,_10158,_10197],_9950,_9952) --> 
    whichg00(duration,_9893,_9889,_9850,_9964,_9950,_9987),
    hvor(_10008,_9987,_10023),
    howadj1(duration,_10032,_10023,_10049),
    w(verb(be,_9902,fin),_10061,_10049,_10078),
    np1_accept(_9905,_9906,_10090,_10078,_10109),
    w(adj2(_9910,nil),_10124,_10109,_10141),
    !,
    np00(duration,_9889,_9890,_10158,_10141,_10179),
    pushstack(first,(xnp(_9905,_9906),w(verb(be,_9902,fin)),w(adj2(_9910,nil)),xadverbial1(nil,_9889,_9890)),nil,_10179,_10270),
    statreal(_9893,_10197,_10270,_9952).

howadjq(_9850,[howadjq,_9957,_10001,_10025,_10054,_10083,_10117,!,_10151,_10190],_9943,_9945) --> 
    whichg00(duration,_9890,_9886,_9850,_9957,_9943,_9980),
    hvor(_10001,_9980,_10016),
    howadj1(duration,_10025,_10016,_10042),
    w(verb(have,_9899,fin),_10054,_10042,_10071),
    subject(_9902,_9903,_10083,_10071,_10102),
    w(verb(_9907,past,part),_10117,_10102,_10134),
    !,
    np00(duration,_9886,_9887,_10151,_10134,_10172),
    pushstack(first,(xnp(_9902,_9903),w(verb(_9907,past,fin)),xadverbial1(nil,_9886,_9887)),nil,_10172,_10263),
    statreal(_9890,_10190,_10263,_9945).

howadjq(which(_9858):::_9858 isa _9861 and _9856,[howadjq,_9974,_9998,_10027,_10056,_10090,!,{},_10139,_10178],_9960,_9962) --> 
    hvor(_9974,_9960,_9989),
    howadj1(_9861,_9998,_9989,_10015),
    w(verb(have,_9908,fin),_10027,_10015,_10044),
    subject(_9911,_9912,_10056,_10044,_10075),
    object(_9914,_9915,_10090,_10075,_10109),
    !,
    {user:_9900=(_9858:_9861)},
    np00(_9861,_9900,_9901,_10139,_10109,_10160),
    pushstack(first,(xnp(_9911,_9912),w(verb(have,_9908,fin)),xnp(_9914,_9915),xadverbial1(nil,_9900,_9901)),nil,_10160,_10282),
    statreal(_9856,_10178,_10282,_9962).

howadjq(which(_9858):::_9858 isa _9861 and _9856,[howadjq,_9982,_10006,_10035,{},_10074,_10103,!,{},_10152,_10191],_9968,_9970) --> 
    hvor(_9982,_9968,_9997),
    howadj1(duration,_10006,_9997,_10023),
    w(verb(_9906,_9907,fin),_10035,_10023,_10052),
    {user:(\+testmember(_9906,[expect,be]))},
    not_look_ahead([det],_10074,_10052,_10091),
    np1(_9925,_9926,_10103,_10091,_10122),
    !,
    {user:_9899=(_9858:duration)},
    np00(_9861,_9899,_9900,_10152,_10122,_10173),
    pushstack(first,(xnp(_9925,_9926),w(verb(_9906,_9907,fin)),xnp(_9899,_9900)),nil,_10173,_10263),
    statreal(_9856,_10191,_10263,_9970).

howadjq(_9850,[howadjq,lit(hvor),lit(lenge),_9967,lit(det),_10007,!,_10041,_10075],_9931,_9933) --> 
    cc(hvor,_9931,_9955),
    cc(lenge,_9955,_9966),
    w(verb(be,pres,fin),_9967,_9966,_9984),
    cc(det,_9984,_10006),
    w(prep(to),_10007,_10006,_10024),
    !,
    clausal_object0(_9882,_9883,_10041,_10024,_10060),
    pushstack(first,(['når'],w(verb(be,pres,fin)),xnp(_9882,_9883)),nil,_10060,_10116),
    whenq(_9850,_10075,_10116,_9933).

howadjq(_9850,[howadjq,lit(hvor),lit(mange),_9975,_10004,lit(det),_10044,!,_10078],_9939,_9941) --> 
    cc(hvor,_9939,_9963),
    cc(mange,_9963,_9974),
    w(noun(minute,plu,u,n),_9975,_9974,_9992),
    w(verb(be,pres,fin),_10004,_9992,_10021),
    cc(det,_10021,_10043),
    w(prep(to),_10044,_10043,_10061),
    !,
    pushstack(free,(['når'],w(verb(be,pres,fin)),[det],[at]),nil,_10061,_10088),
    whenq(_9850,_10078,_10088,_9941).

howadjq(_9850,[howadjq,_9949,_9973,lit(blir),_10013,_10047,!,_10081],_9935,_9937) --> 
    hvor(_9949,_9935,_9964),
    howadj1(_9888,_9973,_9964,_9990),
    cc(blir,_9990,_10012),
    np1(_9885,_9886,_10013,_10012,_10032),
    w(verb(_9897,past,part),_10047,_10032,_10064),
    !,
    pushstack(first,(prep(with),which,w(noun(_9888,sin,u,n)),w(verb(_9897,pres,pass)),xnp(_9885,_9886)),nil,_10064,_10180),
    ppq(_9850,_10081,_10180,_9937).

howadjq(_9850,[howadjq,_9975,_9999,{},_10038,_10062,_10096,{},_10135,_10174],_9961,_9963) --> 
    hvor(_9975,_9961,_9990),
    howadj1(_9894,_9999,_9990,_10016),
    {user:testmember(_9894,[frequency])},
    be(_10038,_10016,_10053),
    subject(_9903,_9904,_10062,_10053,_10081),
    w(adj2(_9908,nil),_10096,_10081,_10113),
    {user:testmember(_9908,[delayed,tooearly])},
    np00(frequency,_9891,_9892,_10135,_10113,_10156),
    pushstack(first,(xnp(_9903,_9904),w(verb(be,pres,fin)),w(adj2(_9908,nil)),w(prep(with)),xnp(_9891,_9892)),nil,_10156,_10246),
    statreal1(_9850,_10174,_10246,_9963).

howadjq(_9850,[howadjq,_9934,_9958,{},_9997,_10021],_9920,_9922) --> 
    hvor(_9934,_9920,_9949),
    howadj1(_9879,_9958,_9949,_9975),
    {user:(\+testmember(_9879,[duration,distance,time]))},
    be(_9997,_9975,_10012),
    pushstack(first,(which,w(noun(_9879,sin,u,n)),w(verb(have,pres,fin))),nil,_10012,_10059),
    whichq(_9850,_10021,_10059,_9922).

howadjq(_9850,[howadjq,_9957,_9981,_10010,_10034,_10068,{},_10107,!,_10209],_9943,_9945) --> 
    hvor(_9957,_9943,_9972),
    howadj1(_9876,_9981,_9972,_9998),
    doit(_10010,_9998,_10025),
    np(_9878,_9879,_10034,_10025,_10053),
    w(verb(_9883,_9884,_9885),_10068,_10053,_10085),
    {user:testmember(_9883,[use,take])},
    pushstack(first,(which,w(noun(_9876,sin,u,n)),w(verb(_9883,inf,fin)),xnp(_9878,_9879)),nil,_10085,_10179),whichq(_9850,_10107,_10179,_10192),
    !,
    accept(_10209,_10192,_9945).

howadjq(which(_9855):::_9853,[howadjq,_9985,_10009,{},_10048,{},_10087,!,_10126,!,_10231],_9971,_9973) --> 
    hvor(_9985,_9971,_10000),
    howadj1(_9884,_10009,_10000,_10026),
    {user:testmember(_9884,[speed,distance])},
    w(verb(_9897,pres,fin),_10048,_10026,_10065),
    {user:(\+testmember(_9897,[know,be]))},
    np1(_9912,_9913,_10087,_10065,_10106),
    !,
    pushstack(first,(xnp(_9912,_9913),w(verb(_9897,pres,fin)),w(prep(with)),the(_9855),w(noun(_9884,sin,u,n))),nil,_10106,_10201),statreal(_9853,_10126,_10201,_10214),
    !,
    accept(_10231,_10214,_9973).

howadjq(_9850,[howadjq,_9935,lit(lenge),_9970,_9994,!,_10028],_9921,_9923) --> 
    hvor(_9935,_9921,_9950),
    cc(lenge,_9950,_9969),
    be(_9970,_9969,_9985),
    not_look_ahead([det],_9994,_9985,_10011),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),w(verb(be,pres,fin))),nil,_10011,_10066),
    ppq(_9850,_10028,_10066,_9923).

howadjq(_9850,[howadjq,_9971,_9995,{},_10034,{},lit(det),_10084,_10108,!,_10142,_10166,!,_10237],_9957,_9959) --> 
    hvor(_9971,_9957,_9986),
    howadj1(_9888,_9995,_9986,_10012),
    {user:testmember(_9888,[duration])},
    w(verb(_9899,pres,fin),_10034,_10012,_10051),
    {user:testmember(_9899,[take,be])},
    cc(det,_10051,_10083),
    redundant0(_10084,_10083,_10099),
    prep(with,_10108,_10099,_10125),
    !,
    accept(_10142,_10125,_10157),
    pushstack(first,(which,w(noun(_9888,sin,u,n)),w(verb(_9899,pres,fin))),nil,_10157,_10207),whichq(_9850,_10166,_10207,_10220),
    !,
    accept(_10237,_10220,_9959).

howadjq(_9850,[howadjq,_9990,_10014,{},_10053,{},lit(det),_10103,_10132,_10156,!,_10190,_10214,!,_10285],_9976,_9978) --> 
    hvor(_9990,_9976,_10005),
    howadj1(_9891,_10014,_10005,_10031),
    {user:testmember(_9891,[duration])},
    w(verb(_9902,pres,fin),_10053,_10031,_10070),
    {user:testmember(_9902,[take])},
    cc(det,_10070,_10102),
    not_look_ahead(['å'],_10103,_10102,_10120),
    redundant0(_10132,_10120,_10147),
    look_ahead(w(prep(_9923)),_10156,_10147,_10173),
    !,
    accept(_10190,_10173,_10205),
    pushstack(first,(which,w(noun(_9891,sin,u,n)),w(verb(_9902,pres,fin)),w(noun(vehicle,sin,def,n))),nil,_10205,_10255),whichq(_9850,_10214,_10255,_10268),
    !,
    accept(_10285,_10268,_9978).

howadjq(_9850,[howadjq,_9967,_9991,{},_10030,lit(det),_10070,{},_10109,_10133,!,_10204],_9953,_9955) --> 
    hvor(_9967,_9953,_9982),
    howadj1(_9882,_9991,_9982,_10008),
    {user:testmember(_9882,[duration])},
    w(verb(_9893,pres,fin),_10030,_10008,_10047),
    cc(det,_10047,_10069),
    not_look_ahead(['å'],_10070,_10069,_10087),
    {user:testmember(_9893,[take,be])},
    redundant0(_10109,_10087,_10124),
    pushstack(first,(which,w(noun(_9882,sin,u,n)),w(verb(exist,pres,fin))),nil,_10124,_10174),whichq(_9850,_10133,_10174,_10187),
    !,
    accept(_10204,_10187,_9955).

howadjq(_9850,[howadjq,_9906,_9930,_9959],_9892,_9894) --> 
    ihvor(_9906,_9892,_9921),
    howadj1(_9866,_9930,_9921,_9947),
    pushstack(first,(which,w(noun(_9866,sin,u,n))),nil,_9947,_9997),
    whichq(_9850,_9959,_9997,_9894).

howadjq(_9850,[howadjq,_9922,lit(lenge),_9957,!,_9986],_9908,_9910) --> 
    hvor(_9922,_9908,_9937),
    cc(lenge,_9937,_9956),
    be(_9957,_9956,_9972),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),be),nil,_9972,_10052),
    ppq(_9850,_9986,_10052,_9910).

howadjq(_9850,[howadjq,_9925,_9949,_9973,_9997,_10026],_9911,_9913) --> 
    hvor(_9925,_9911,_9940),
    meny(_9949,_9940,_9964),
    be(_9973,_9964,_9988),
    w(noun(clock,_9886,_9887,_9888),_9997,_9988,_10014),
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_10014,_10092),
    whatq(_9850,_10026,_10092,_9913).

howadjq(_9850,[howadjq,_9940,lit(lenge),_9975,{},!,_10019],_9926,_9928) --> 
    hvor(_9940,_9926,_9955),
    cc(lenge,_9955,_9974),
    w(verb(_9881,pres,fin),_9975,_9974,_9992),
    {user:_9881\==take},
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(_9881,pres,fin))),nil,_9992,_10087),
    ppq(_9850,_10019,_10087,_9928).

howadjq(_9850,[howadjq,_9932,_9956,_9985,!,_10019],_9918,_9920) --> 
    hvor(_9932,_9918,_9947),
    howadj1(duration,_9956,_9947,_9973),
    w(verb(use,pres,fin),_9985,_9973,_10002),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_10002,_10087),
    ppq(_9850,_10019,_10087,_9920).

howadjq(_9850,[howadjq,_9923,_9947,_9976,_10000,!,_10129],_9909,_9911) --> 
    hvor(_9923,_9909,_9938),
    howadj1(_9867,_9947,_9938,_9964),
    doit(_9976,_9964,_9991),
    pushstack(first,(prep(with),which,w(noun(_9867,sin,u,n)),doit),nil,_9991,_10099),ppq(_9850,_10000,_10099,_10112),
    !,
    accept(_10129,_10112,_9911).

howadjq(_9850,[howadjq,_9923,_9947,_9976,_10000,_10024],_9909,_9911) --> 
    hvor(_9923,_9909,_9938),
    howadj1(duration,_9947,_9938,_9964),
    betake(_9976,_9964,_9991),
    thereit(_10000,_9991,_10015),
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(duration,sin,def,n))),nil,_10015,_10034),
    whatq(_9850,_10024,_10034,_9911).

howadjq(_9850,[howadjq,_9939,_9963,_9992,_10021,!,_10055],_9925,_9927) --> 
    hvor(_9939,_9925,_9954),
    howadj1(duration,_9963,_9954,_9980),
    w(verb(take,pres,fin),_9992,_9980,_10009),
    not_look_ahead([det],_10021,_10009,_10038),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_10038,_10123),
    ppq(_9850,_10055,_10123,_9927).

howmuchq(which(_9855):::_9853,[howmuchq,_9947,lit(lenge),_9982,lit(det),!,_10027],_9933,_9935) --> 
    hvor(_9947,_9933,_9962),
    cc(lenge,_9962,_9981),
    w(verb(be,_9891,fin),_9982,_9981,_9999),
    cc(det,_9999,_10021),
    !,
    pushstack(first,(which,w(noun(duration,plu,u,n)),w(verb(be,_9891,fin)),[det]),nil,_10021,_10065),
    whichq(which(_9855):::_9853,_10027,_10065,_9935).

howmuchq(which(_9855):::_9853,[howmuchq,_9964,_9988,_10012,{},lit(det),lit('å'),_10073,!,_10121],_9950,_9952) --> 
    hvor(_9964,_9950,_9979),
    much(_9988,_9979,_10003),
    w(verb(_9894,_9895,fin),_10012,_10003,_10029),
    {user:testmember(_9894,[cost])},
    cc(det,_10029,_10061),
    cc('å',_10061,_10072),
    pushstack(first,([noen],[vil]),nil,_10072,_10086),clausal_object1(_9917,_9918,_10073,_10086,_10101),
    !,
    pushstack(first,(xnp(_9917,_9918),w(verb(_9894,pres,fin)),npgap(_9855)),nil,_10101,_10192),
    statreal1(_9853,_10121,_10192,_9952).

howmuchq(test:::_9853,[howmuchq,_9947,_9971,_9995,_10024,_10058,!,_10092,_10116],_9933,_9935) --> 
    hvor(_9947,_9933,_9962),
    much(_9971,_9962,_9986),
    w(verb(be,_9893,fin),_9995,_9986,_10012),
    np0_accept(_9896,_9897,_10024,_10012,_10043),
    w(adj2(_9887,nil),_10058,_10043,_10075),
    !,
    accept(_10092,_10075,_10107),
    pushstack(first,(xnp(_9896,_9897),w(verb(be,pres,fin)),w(adj2(_9887,nil))),nil,_10107,_10157),
    statemen1(real,_9853,_10116,_10157,_9935).

howmuchq(_9850,[howmuchq,_9910,_9934,_9958,!,_9992],_9896,_9898) --> 
    hvor(_9910,_9896,_9925),
    many1(_9934,_9925,_9949),
    look_ahead(w(verb(be,_9874,fin)),_9958,_9949,_9975),
    !,
    pushstack(first,[hva],nil,_9975,_10002),
    whatq(_9850,_9992,_10002,_9898).

howmuchq(howmany(_9855):::_9853,[howmuchq,_9904,_9928,_9952],_9890,_9892) --> 
    hvor(_9904,_9890,_9919),
    many1(_9928,_9919,_9943),
    pushstack(first,which,nil,_9943,_9990),
    whichq(which(_9855):::_9853,_9952,_9990,_9892).

howmuchq(howmany(_9855):::_9853,[howmuchq,_9914,_9938,_9962],_9900,_9902) --> 
    hvor(_9914,_9900,_9929),
    manypersons(_9938,_9929,_9953),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_9953,_10000),
    whichq(which(_9855):::_9853,_9962,_10000,_9902).

howmuchq(howmany(_9855):::_9853,[howmuchq,_9924,lit(det),_9959,lit(som),_9994],_9910,_9912) --> 
    be(_9924,_9910,_9939),
    cc(det,_9939,_9958),
    manypersons(_9959,_9958,_9974),
    cc(som,_9974,_9993),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_9993,_10032),
    whichq(which(_9855):::_9853,_9994,_10032,_9912).

howmuchq(which(_9855):::_9853,[howmuchq,_9919,_9943,_9967,{},_10006],_9905,_9907) --> 
    hvor(_9919,_9905,_9934),
    much(_9943,_9934,_9958),
    w(verb(_9869,_9876,fin),_9967,_9958,_9984),
    {user:testmember(_9869,[earn,cost])},
    whattrans(_9869,_9855,_9853,_10006,_9984,_9907).

howmuchq(_9850,[howmuchq,_9903,_9927,_9951,!,_9980],_9889,_9891) --> 
    hvor(_9903,_9889,_9918),
    much(_9927,_9918,_9942),
    of(_9951,_9942,_9966),
    !,
    pushstack(first,(which,of),nil,_9966,_10049),
    whichq(_9850,_9980,_10049,_9891).

howmuchq(_9850,[howmuchq,_9920,_9944,_9968,_9997,!,_10068],_9906,_9908) --> 
    hvor(_9920,_9906,_9935),
    much(_9944,_9935,_9959),
    w(noun(_9869,_9870,u,n),_9968,_9959,_9985),
    pushstack(first,(which,w(noun(_9869,sin,u,n))),nil,_9985,_10038),whichq(_9850,_9997,_10038,_10051),
    !,
    accept(_10068,_10051,_9908).

howmuchq(_9850,[howmuchq,_9896,_9920,_9944],_9882,_9884) --> 
    hvor(_9896,_9882,_9911),
    much(_9920,_9911,_9935),
    pushstack(first,[hva],nil,_9935,_9954),
    question(_9850,_9944,_9954,_9884).

whattrans(_9850,_9851,_9852,[whattrans,_9939,_9968,!,_10007],_9919,_9921) --> 
    not_look_ahead([det],_9939,_9919,_9956),
    noun_phrase1(_9878,_9881::_9882,_9968,_9956,_9987),
    !,
    pushstack(first,(noun_phrase1(_9878,_9881::_9882),w(verb(_9850,pres,fin)),npgap(_9851)),nil,_9987,_10081),
    statreal1(_9852,_10007,_10081,_9921).

howadj1(_9850,[howadj1,_9888,!],_9874,_9876) --> 
    howadj(_9850,_9888,_9874,_9876),
    !.

howadj(duration,[howadj,lit(langt)],_9871,_9873) --> 
    cc(langt,_9871,_9873).

howadj(age,[howadj,_9888],_9874,_9876) --> 
    w(adj2(old,nil),_9888,_9874,_9876).

howadj(age,[howadj,lit(mange),_9906],_9881,_9883) --> 
    cc(mange,_9881,_9905),
    w(noun(year,plu,u,n),_9906,_9905,_9883).

howadj(delay,[howadj,_9888],_9874,_9876) --> 
    w(adj2(slow,nil),_9888,_9874,_9876).

howadj(delay,[howadj,_9893,_9937],_9879,_9881) --> 
    optional(much,_9893,_9879,_9925),
    w(adj2(delayed,nil),_9937,_9925,_9881).

howadj(delay,[howadj,_9888],_9874,_9876) --> 
    w(adj2(punctual,nil),_9888,_9874,_9876).

howadj(earliness,[howadj,_9888],_9874,_9876) --> 
    w(adj2(early,nil),_9888,_9874,_9876).

howadj(lateness,[howadj,_9888],_9874,_9876) --> 
    w(adj2(late,nil),_9888,_9874,_9876).

howadj(lateness,[howadj,lit(sent)],_9871,_9873) --> 
    cc(sent,_9871,_9873).

howadj(distance,[howadj,lit(langt)],_9871,_9873) --> 
    cc(langt,_9871,_9873).

howadj(distance,[howadj,_9909,_9933,{}],_9895,_9897) --> 
    many(_9909,_9895,_9924),
    w(noun(_9860,_9874,u,n),_9933,_9924,_9897),
    {user:testmember(_9860,[mil,mile,kilometer,meter])}.

howadj(duration,[howadj,lit(mange),_9906],_9881,_9883) --> 
    cc(mange,_9881,_9905),
    w(noun(minute,_9858,_9859,n),_9906,_9905,_9883).

howadj(duration,[howadj,lit(lenge)],_9871,_9873) --> 
    cc(lenge,_9871,_9873).

howadj(duration,[howadj,_9896,_9920,!],_9882,_9884) --> 
    long(_9896,_9882,_9911),
    w(noun(time,_9861,u,n),_9920,_9911,_9884),
    !.

howadj(duration,[howadj,_9896,_9920,!],_9882,_9884) --> 
    much(_9896,_9882,_9911),
    w(noun(time,_9861,u,n),_9920,_9911,_9884),
    !.

howadj(duration,[howadj,_9888],_9874,_9876) --> 
    w(adj2(short,nil),_9888,_9874,_9876).

howadj(frequency,[howadj,_9883],_9869,_9871) --> 
    often(_9883,_9869,_9871).

howadj(frequency,[howadj,lit(mange),_9915,_9944,!,_9973],_9890,_9892) --> 
    cc(mange,_9890,_9914),
    w(noun(time_count,_9869,_9870,n),_9915,_9914,_9932),
    inperiod0(_9944,_9932,_9959),
    !,
    accept(_9973,_9959,_9892).

howadj(intelligence,[howadj,_9888],_9874,_9876) --> 
    w(adj2(intelligent,nil),_9888,_9874,_9876).

howadj(intelligence,[howadj,_9888],_9874,_9876) --> 
    w(adj2(stupid,_9855),_9888,_9874,_9876).

howadj(intelligence,[howadj,_9898,_9927],_9884,_9886) --> 
    w(adj2(_9864,nil),_9898,_9884,_9915),
    w(noun(intelligence,sin,_9859,n),_9927,_9915,_9886).

howadj(price,[howadj,_9888],_9874,_9876) --> 
    w(adj2(expensive,nil),_9888,_9874,_9876).

howadj(price,[howadj,_9888],_9874,_9876) --> 
    w(adj2(cheap,nil),_9888,_9874,_9876).

howadj(size,[howadj,_9883],_9869,_9871) --> 
    great(_9883,_9869,_9871).

howadj(length,[howadj,_9888],_9874,_9876) --> 
    w(adj2(long,nil),_9888,_9874,_9876).

howadj(length,[howadj,_9888],_9874,_9876) --> 
    w(adj2(short,nil),_9888,_9874,_9876).

howadj(speed,[howadj,lit(fort)],_9871,_9873) --> 
    cc(fort,_9871,_9873).

howadj(speed,[howadj,_9888],_9874,_9876) --> 
    w(adj2(fast,_9855),_9888,_9874,_9876).

howadj(speed,[howadj,_9888],_9874,_9876) --> 
    w(adj2(slow,_9855),_9888,_9874,_9876).

howadj(temperature,[howadj,_9888],_9874,_9876) --> 
    w(adj2(cold,nil),_9888,_9874,_9876).

howadj(temperature,[howadj,_9888],_9874,_9876) --> 
    w(adj2(hot,nil),_9888,_9874,_9876).

howadj(weather,[howadj,_9888],_9874,_9876) --> 
    w(adj2(hot,nil),_9888,_9874,_9876).

howadj(weather,[howadj,_9888],_9874,_9876) --> 
    w(adj2(cold,nil),_9888,_9874,_9876).

howadj(weight,[howadj,_9888],_9874,_9876) --> 
    w(adj2(heavy,nil),_9888,_9874,_9876).

vp(_9850,_9851,_9852,_9855::true,[vp,lit(:),_9923,!],_9889,_9891) --> 
    cc(:,_9889,_9922),
    end_of_line(_9923,_9922,_9891),
    !.

vp(_9850,_9851,_9852,_9853,[vp,_9906],_9883,_9885) --> 
    verb_phrase(_9850,_9851,_9852,_9853,_9906,_9883,_9885).

verb_phrase(_9850,_9851,_9852,_9853,[verb_phrase,_9974,{},{},{},{},!,_10043,_10067,!],_9951,_9953) --> 
    endofline(_9974,_9951,_9989),
    {user:value(busflag,true)},
    {user:(\+value(dialog,1))},
    {user:vartypeid(_9850,_9894)},
    {user:testmember(_9894,[neighbourhood,bus,tram,station,departure,arrival])},
    !,
    accept(_10043,_9989,_10058),
    pushstack(first,w(verb(exist,pres,fin)),nil,_10058,_10080),verb_phrase1(exist,_9850,_9851,_9852,_9853,_10067,_10080,_9953),
    !.

verb_phrase(_9850,_9851,_9852,_9855::_9856,[verb_phrase,_10010,{},lit(og),_10060,{},_10099,!,_10138,!,_10245],_9987,_9989) --> 
    w(verb(_9898,_9899,fin),_10010,_9987,_10027),
    {user:verbtype(_9898,tv)},
    cc(og,_10027,_10059),
    w(verb(_9911,_9912,fin),_10060,_10059,_10077),
    {user:verbtype(_9911,tv)},
    object(_9894,_9921,_10099,_10077,_10118),
    !,
    lock(exact,_10118,_10189),pushstack(exact,(w(verb(_9898,_9944,fin)),xnp(_9894,_9921)),nil,_10189,_10195),verb_phrase1(_9898,_9850,_9851,_9852,_9855::_9939,_10138,_10195,_10184),unlock(_10184,_10185),
    !,
    lock(exact,_10185,_10292),
    pushstack(exact,([og],w(verb(_9911,_9961,fin)),npgap(_9894)),nil,_10292,_10298),
    verb_phrases0(_9911,_9850,_9852,_9939,_9855::_9856,_10245,_10298,_10287),
    unlock(_10287,_9989).

verb_phrase(_9850,_9851,_9852,_9855::_9856,[verb_phrase,_9925,_9974],_9902,_9904) --> 
    verb_phrase1(_9861,_9850,_9851,_9852,_9855::_9864,_9925,_9902,_9950),
    verb_phrases0(_9861,_9850,_9852,_9864,_9855::_9856,_9974,_9950,_9904).

verb_phrases0(_9850,_9851,_9852,_9853,_9856::_9853 and _9860,[verb_phrases0,_9972,lit(ikke),!,_10012,{},{},_10090],_9946,_9948) --> 
    vp_conjunction(_9972,_9946,_9987),
    cc(ikke,_9987,_10006),
    !,
    pushstack(first,w(verb(_9850,pres,fin)),nil,_10006,_10025),verb_phrase1(_9850,_9851,_9902,_9852,_9856::_9907,_10012,_10025,_10046),
    {user:bigno(not,_9902,_9913)},
    {user:negate(_9913,_9907,_9883)},
    verb_phrases0(_9850,_9851,_9852,_9883,_9856::_9860,_10090,_10046,_9948).

verb_phrases0(_9850,_9851,_9852,_9853,_9856::_9853 and _9860,[verb_phrases0,_9953,_9977,_10006,{},_10065],_9927,_9929) --> 
    vp_conjunction(_9953,_9927,_9968),
    not_look_ahead(['så'],_9977,_9968,_9994),
    verb_phrase1(_9887,_9851,_9889,_9852,_9856::_9894,_10006,_9994,_10031),
    {user:negate(_9889,_9894,_9877)},
    verb_phrases0(_9874,_9851,_9852,_9877,_9856::_9860,_10065,_10031,_9929).

verb_phrases0(be,_9851,_9852,_9853,_9856::_9853 and _9860,[verb_phrases0,_9960,{},!,_10004],_9934,_9936) --> 
    w(adj2(_9879,nil),_9960,_9934,_9977),
    {user:testmember(_9879,[enclosed])},
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_9879,nil))),nil,_9977,_10014),
    verb_phrase1(be,_9851,id,_9852,_9856::_9860,_10004,_10014,_9936).

verb_phrases0(_9850,_9851,_9852,_9853,_9856::_9853,[verb_phrases0,[]],_9884,_9884) --> 
    [].

vp_conjunction([vp_conjunction,lit(som),_9892],_9870,_9872) --> 
    cc(som,_9870,_9891),
    look_ahead_vp(_9892,_9891,_9872).

vp_conjunction([vp_conjunction,lit('å'),_9900],_9878,_9880) --> 
    cc('å',_9878,_9899),
    look_ahead(w(verb(_9857,pres,fin)),_9900,_9899,_9880).

vp_conjunction([vp_conjunction,lit(evt)],_9867,_9869) --> 
    cc(evt,_9867,_9869).

vp_conjunction([vp_conjunction,_9902,_9926,_9955,_9984,!],_9891,_9893) --> 
    and1(_9902,_9891,_9917),
    not_look_ahead(['nå'],_9926,_9917,_9943),
    not_look_ahead(['så'],_9955,_9943,_9972),
    not_look_ahead(w(adv(redundantly)),_9984,_9972,_9893),
    !.

vp_conjunction([vp_conjunction,lit(men),_9908,_9937,!],_9886,_9888) --> 
    cc(men,_9886,_9907),
    not_look_ahead(['så'],_9908,_9907,_9925),
    look_ahead_lit([skal,vil],_9937,_9925,_9888),
    !.

vp_conjunction([vp_conjunction,lit(men),_9910,_9939,!],_9888,_9890) --> 
    cc(men,_9888,_9909),
    not_look_ahead(['så'],_9910,_9909,_9927),
    look_ahead(w(verb(_9869,_9870,_9871)),_9939,_9927,_9890),
    !.

vp_conjunction([vp_conjunction,_9887,_9911],_9876,_9878) --> 
    or1(_9887,_9876,_9902),
    look_ahead(w(verb(_9857,_9858,fin)),_9911,_9902,_9878).

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9953,_9977,_10006,!,_10040,_10064],_9927,_9929) --> 
    aux1(_9953,_9927,_9968),
    not_look_ahead(w(verb(_9884,_9885,_9886)),_9977,_9968,_9994),
    look_ahead_lit(['så',tilbake,fram],_10006,_9994,_10023),
    !,
    accept(_10040,_10023,_10055),
    pushstack(first,w(verb(go,pres,fin)),nil,_10055,_10074),
    do_phrase(_9850,_9851,_9852,_9853,_9854,_10064,_10074,_9929).

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9976,_10000,_10029,{},{},!,_10088,_10112],_9950,_9952) --> 
    aux1(_9976,_9950,_9991),
    not_look_ahead(w(verb(_9890,_9891,_9892)),_10000,_9991,_10017),
    np0_accept(_9883,_9884,_10029,_10017,_10048),
    {user:vartypeid(_9883,_9900)},
    {user:testmember(_9900,[thing,coevent,activity])},
    !,
    accept(_10088,_10048,_10103),
    pushstack(first,(w(verb(do1,pres,fin)),xnp(_9883,_9884)),nil,_10103,_10153),
    do_phrase(_9850,_9851,_9852,_9853,_9854,_10112,_10153,_9952).

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_10003,_10027,_10056,_10080,_10109,{},_10148,_10172,{},!,_10221,_10245],_9977,_9979) --> 
    aux1(_10003,_9977,_10018),
    negation0(_9852,_10027,_10018,_10044),
    redundant0(_10056,_10044,_10071),
    not_look_ahead(w(verb(_9907,_9908,_9909)),_10080,_10071,_10097),
    w(prep(_9913),_10109,_10097,_10126),
    {user:testmember(_9913,[from,to,on,towards])},
    look_ahead_np(_10148,_10126,_10163),
    np0_accept(_9898,_9899,_10172,_10163,_10191),
    {user:constrain(_9898,place)},
    !,
    accept(_10221,_10191,_10236),
    pushstack(first,(w(verb(go,pres,fin)),w(prep(_9913)),xnp(_9898,_9899)),nil,_10236,_10286),
    do_phrase(_9850,_9851,_9852,_9853,_9854,_10245,_10286,_9979).

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9963,_9987,_10016,{},_10055,!,_10084,_10108],_9937,_9939) --> 
    aux1(_9963,_9937,_9978),
    not_look_ahead(w(verb(_9887,_9888,_9889)),_9987,_9978,_10004),
    look_ahead(w(prep(_9895)),_10016,_10004,_10033),
    {user:(\+testmember(_9895,[from,to,on,towards]))},
    preadverbials0(_10055,_10033,_10070),
    !,
    accept(_10084,_10070,_10099),
    do_phrase(_9850,_9851,_9852,_9853,_9854,_10108,_10099,_9939).

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9942,_9966,_9995,!,_10029,_10053],_9916,_9918) --> 
    aux1(_9942,_9916,_9957),
    not_look_ahead(w(verb(_9881,_9882,_9883)),_9966,_9957,_9983),
    one_of_lit([da,'nå'],_9995,_9983,_10012),
    !,
    accept(_10029,_10012,_10044),
    do_phrase(_9850,_9851,_9852,_9853,_9854,_10053,_10044,_9918).

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9970,_9994,_10023,_10052,_10076,{},!,_10125,_10149],_9944,_9946) --> 
    aux1(_9970,_9944,_9985),
    not_look_ahead(w(verb(_9893,_9894,_9895)),_9994,_9985,_10011),
    w(prep(_9899),_10023,_10011,_10040),
    look_ahead_np(_10052,_10040,_10067),
    np0_accept(_9886,_9887,_10076,_10067,_10095),
    {user:constrain(_9886,time)},
    !,
    accept(_10125,_10095,_10140),
    lock(last,_10140,_10197),
    pushstack(last,(w(prep(_9899)),xnp(_9886,_9887)),nil,_10197,_10203),
    do_phrase(_9850,_9851,_9852,_9853,_9854,_10149,_10203,_10192),
    unlock(_10192,_9946).

verb_phrase1(be1,_9851,_9852,_9853,_9854,[verb_phrase1,lit(skal),_9978,_10007,lit(med),_10062,_10086,{}],_9941,_9943) --> 
    cc(skal,_9941,_9977),
    negation0(_9876,_9978,_9977,_9995),
    optional(w(verb(be,inf,fin)),_10007,_9995,_10039),
    cc(med,_10039,_10061),
    not_look_ahead_np(_10062,_10061,_10077),
    pushstack(first,(w(verb(be1,inf,fin)),w(adv(inside))),nil,_10077,_10099),do_phrase(be1,_9851,_9877,_9853,_9854,_10086,_10099,_9943),
    {user:bigno(_9876,_9877,_9852)}.

verb_phrase1(be,_9851,id,_9853,_9854,[verb_phrase1,_9937,{},_9976],_9911,_9913) --> 
    w(adj2(_9867,nil),_9937,_9911,_9954),
    {user:testmember(_9867,[enclosed])},
    pushstack(first,w(adj2(_9867,nil)),nil,_9954,_9986),
    be_pred(_9851,_9853,_9854,_9976,_9986,_9913).

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9985,_10014,_10043,_10072,{},!,_10116,_10174,{}],_9959,_9961) --> 
    constrainvehdep(_9851,_9985,_9959,_10002),
    w(verb(be,_9891,fin),_10014,_10002,_10031),
    negation0(_9882,_10043,_10031,_10060),
    w(verb(_9850,past,part),_10072,_10060,_10089),
    {user:testmember(_9850,[go,run,pass])},
    !,
    pushstack(first,w(verb(_9850,_9891,fin)),nil,_10089,_10129),vp_kernel(_9850,_9851,_9883,_9853,_9926,_10116,_10129,_10150),
    verb_modifiers0(_9850,_9851,_9853,_9926,_9854,_10174,_10150,_9961),
    {user:bigno(_9882,_9883,_9852)}.

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9950,_9974,_10003,_10032,!,_10081],_9924,_9926) --> 
    blei(_9950,_9924,_9965),
    one_of_lit([siden,derfor,dermed],_9974,_9965,_9991),
    negation0(_9852,_10003,_9991,_10020),
    lexv(tv,_9850,past,part,_10032,_10020,_10055),
    !,
    pushstack(first,w(verb(_9850,past,part)),nil,_10055,_10091),
    passive(_9851,_9853,_9854,_10081,_10091,_9926).

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9945,_9969,_9993,_10022,_10046,!,_10095],_9919,_9921) --> 
    aux1(_9945,_9919,_9960),
    redundant0(_9969,_9960,_9984),
    negation0(_9852,_9993,_9984,_10010),
    blei(_10022,_10010,_10037),
    lexv(tv,_9850,past,part,_10046,_10037,_10069),
    !,
    pushstack(first,w(verb(_9850,past,part)),nil,_10069,_10105),
    passive(_9851,_9853,_9854,_10095,_10105,_9921).

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9952,_9976,_10005,_10029,_10073,!,_10112],_9926,_9928) --> 
    redundant0(_9952,_9926,_9967),
    blei(_9852,_9976,_9967,_9993),
    redundant0(_10005,_9993,_10020),
    lexv(_9885,_9850,past,part,_10029,_10020,_10052),
    gmem(_9885,[tv,dtv],_10073,_10052,_10092),
    !,
    pushstack(first,w(verb(_9850,past,part)),nil,_10092,_10122),
    passive(_9851,_9853,_9854,_10112,_10122,_9928).

verb_phrase1(be,_9851,_9852,_9853,_9854,[verb_phrase1,_9945,_9974,_9998,_10022,_10051,_10075,_10099,_10123,_10147],_9919,_9921) --> 
    not_look_ahead(w(verb(go,_9889,fin)),_9945,_9919,_9962),
    aux10(_9974,_9962,_9989),
    redundants0(_9998,_9989,_10013),
    be(_9852,_10022,_10013,_10039),
    not_look_ahead_verbx(_10051,_10039,_10066),
    danow0(_10075,_10066,_10090),
    redundant0(_10099,_10090,_10114),
    not_look_ahead_prepx(_10123,_10114,_10138),
    be_complements(_9851,_9853,_9854,_10147,_10138,_9921).

not_look_ahead_verbx([not_look_ahead_verbx,lit('så'),!],_9870,_9872) --> 
    cc('så',_9870,_9872),
    !.

not_look_ahead_verbx([not_look_ahead_verbx,_9884],_9873,_9875) --> 
    not_look_ahead(w(verb(_9854,_9855,_9856)),_9884,_9873,_9875).

not_look_ahead_prepx([not_look_ahead_prepx,_9900,{},!,_9944],_9889,_9891) --> 
    look_ahead(w(prep(_9863)),_9900,_9889,_9917),
    {user:(\+testmember(_9863,[for]))},
    !,
    reject(_9944,_9917,_9891).

not_look_ahead_prepx([not_look_ahead_prepx,[]],_9865,_9865) --> 
    [].

verb_phrase1(_9850,_9851,_9852,_9853,_9854,[verb_phrase1,_9962,_9996,_10025,_10049,{},_10088,{},!,_10152],_9936,_9938) --> 
    auxs0(_9880,_9881,_9962,_9936,_9981),
    not_look_ahead(w(verb(_9887,_9888,pass)),_9996,_9981,_10013),
    redundants0(_10025,_10013,_10040),
    negation0(_9891,_10049,_10040,_10066),
    {user:bigno(_9880,_9891,_9897)},
    do_phrase(_9850,_9851,_9901,_9853,_9854,_10088,_10066,_10113),
    {user:bigno(_9897,_9901,_9852)},
    !,
    accept(_10152,_10113,_9938).

verb_phrase1(go,_9851,_9852,_9853,_9854,[verb_phrase1,_9952,_9976,lit(av),!,_10021,_10045],_9926,_9928) --> 
    aux1(_9952,_9926,_9967),
    not_look_ahead(w(verb(_9883,_9884,_9885)),_9976,_9967,_9993),
    cc(av,_9993,_10015),
    !,
    accept(_10021,_10015,_10036),
    pushstack(first,(w(verb(go,pres,fin)),[av]),nil,_10036,_10055),
    do_phrase(go,_9851,_9852,_9853,_9854,_10045,_10055,_9928).

verb_phrase1(_9850,_9851,id,_9853,_9856::_9857,[verb_phrase1,_9941,_9965,_9989,_10018],_9915,_9917) --> 
    paux0(_9941,_9915,_9956),
    redundant0(_9965,_9956,_9980),
    w(verb(_9850,_9880,pass),_9989,_9980,_10006),
    pushstack(first,w(verb(_9850,past,part)),nil,_10006,_10028),
    passive(_9851,_9853,_9856::_9857,_10018,_10028,_9917).

verb_phrase1(live,_9851,id,_9853,_9854,[verb_phrase1,_9976,_10000,_10024,_10053,_10082,!,_10131],_9950,_9952) --> 
    be(_9976,_9950,_9991),
    redundant0(_10000,_9991,_10015),
    number(_9893,_10024,_10015,_10041),
    w(noun(year,_9898,u,n),_10053,_10041,_10070),
    optional(w(adj2(old,nil)),_10082,_10070,_10114),
    !,
    pushstack(first,(w(verb(live,pres,fin)),prep1(in),number(_9893),w(noun(year,plu,u,n))),nil,_10114,_10205),
    do_phrase(live,_9851,id,_9853,_9854,_10131,_10205,_9952).

verb_phrase1(be,_9851,_9852,_9853,_9854,[verb_phrase1,_9929,_9958,lit(som),!,_9998],_9903,_9905) --> 
    be(_9852,_9929,_9903,_9946),
    dudet(_9958,_9946,_9973),
    cc(som,_9973,_9992),
    !,
    do_phrase(be,_9851,_9852,_9853,_9854,_9998,_9992,_9905).

verb_phrase1(be,_9851,_9852,_9853,_9854,[verb_phrase1,_9990,_10019,_10048,!,_10082,_10106,_10135,_10164,_10188,_10212,{}],_9964,_9966) --> 
    not_look_ahead(w(verb(go,_9897,fin)),_9990,_9964,_10007),
    w(verb(be,_9903,fin),_10019,_10007,_10036),
    not_look_ahead(w(verb(_9910,_9911,part)),_10048,_10036,_10065),
    !,
    accept(_10082,_10065,_10097),
    not_look_ahead(w(name(_9918,_9919,_9920)),_10106,_10097,_10123),
    negation0(_9888,_10135,_10123,_10152),
    it0(_10164,_10152,_10179),
    redundant0(_10188,_10179,_10203),
    pushstack(first,w(verb(be,pres,fin)),nil,_10203,_10225),do_phrase(be,_9851,_9889,_9853,_9854,_10212,_10225,_9966),
    {user:bigno(_9888,_9889,_9852)}.

verb_phrase1(_9850,_9851,id,_9853,_9854,[verb_phrase1,_9934,_9958,_9987,_10011],_9908,_9910) --> 
    paux0(_9934,_9908,_9949),
    w(verb(_9850,pres,pass),_9958,_9949,_9975),
    thereit0(_9987,_9975,_10002),
    pushstack(first,w(adj2(_9850,nil)),nil,_10002,_10021),
    be_complements(_9851,_9853,_9854,_10011,_10021,_9910).

do_phrase(_9850,_9851,_9852,_9853,_9854,[do_phrase,_10035,{},_10074,_10103,_10127,_10156,_10185,{},!,_10229,_10253,_10319],_10009,_10011) --> 
    w(verb(_9850,_9908,fin),_10035,_10009,_10052),
    {user:testmember(_9850,[go,come])},
    negation0(_9852,_10074,_10052,_10091),
    morethan0(_10103,_10091,_10118),
    w(nb(_9924,num),_10127,_10118,_10144),
    w(noun(minute,_9930,u,n),_10156,_10144,_10173),
    w(adj2(_9936,_9937),_10185,_10173,_10202),
    {user:testmember(_9936,[delayed,tooearly,late])},
    !,
    accept(_10229,_10202,_10244),
    lock(exact,_10244,_10273),pushstack(exact,w(adj2(_9936,_9937)),nil,_10273,_10279),ap(_9936,_9851,_9853,_9961,_10253,_10279,_10268),unlock(_10268,_10269),
    pushstack(first,(w(prep(with)),w(nb(_9924,num)),w(noun(minute,plu,u,n))),nil,_10269,_10329),
    verb_modifiers0(adj/nil/_9936,_9851,_9853,_9961,_9854,_10319,_10329,_10011).

morethan0([morethan0,lit(ca),!],_9870,_9872) --> 
    cc(ca,_9870,_9872),
    !.

morethan0([morethan0,lit(minst),!],_9870,_9872) --> 
    cc(minst,_9870,_9872),
    !.

morethan0([morethan0,lit(mer),lit(enn),!],_9875,_9877) --> 
    cc(mer,_9875,_9896),
    cc(enn,_9896,_9877),
    !.

morethan0([morethan0,[]],_9865,_9865) --> 
    [].

do_phrase(_9850,_9851,id,_9853,_9856::_9859 and _9860,[do_phrase,_9991,_10020,_10049,{},_10093,_10117,!,_10151,{}],_9965,_9967) --> 
    w(verb(ask,_9898,fin),_9991,_9965,_10008),
    not_look_ahead([om],_10020,_10008,_10037),
    object(_9905,_9906,_10049,_10037,_10068),
    {user:constrain(_9905,agent)},
    omaa0(_10093,_10068,_10108),
    w(verb(_9915,inf,fin),_10117,_10108,_10134),
    !,
    pushstack(first,(xnp(_9905,_9906),w(verb(_9915,pres,fin))),nil,_10134,_10195),clausal_object1(_9891,_9856::_9860,_10151,_10195,_9967),
    {user:co_template(_9850,that,_9851,_9891,_9853,_9859)}.

omaa0([omaa0,[]],_9865,_9865) --> 
    [].

omaa([omaa,lit(om),lit('å')],_9872,_9874) --> 
    cc(om,_9872,_9893),
    cc('å',_9893,_9874).

omaa([omaa,lit(om),lit(og)],_9872,_9874) --> 
    cc(om,_9872,_9893),
    cc(og,_9893,_9874).

omaa([omaa,lit('å')],_9867,_9869) --> 
    cc('å',_9867,_9869).

do_phrase(_9850,_9851,_9852,_9853,_9854,[do_phrase,_9922,_9971],_9896,_9898) --> 
    rvp_kernel(_9850,_9851,_9852,_9853,_9862,_9922,_9896,_9947),
    verb_modifiers0(_9850,_9851,_9853,_9862,_9854,_9971,_9947,_9898).

do_phrase(have,_9851,id,_9853,_9856::_9859 and _9860,[do_phrase,_9981,_10005,{},lit(for),lit('å'),!,_10071,_10095,{}],_9955,_9957) --> 
    has(_9981,_9955,_9996),
    w(adj2(_9896,nil),_10005,_9996,_10022),
    {user:testmember(_9896,[difficult])},
    cc(for,_10022,_10054),
    cc('å',_10054,_10065),
    !,
    accept(_10071,_10065,_10086),
    pushstack(first,(npgap(_9851),aux1),nil,_10086,_10166),clausal_object1(_9922:coevent,_9856::_9860,_10095,_10166,_9957),
    {user:tv_template(dislike,_9851,_9922:coevent,_9853,_9859)}.

do_phrase(_9850,_9851,_9852,_9853,_9854,[do_phrase,_9928,_9977,_10026],_9902,_9904) --> 
    vp_kernel(_9850,_9851,_9862,_9853,_9869,_9928,_9902,_9953),
    verb_modifiers0(_9850,_9851,_9853,_9869,_9854,_9977,_9953,_10002),
    negation2(_9862,_9852,_10026,_10002,_9904).

do_phrase(_9850,_9851,_9852,_9853,_9854,[do_phrase,_9957,_9986,!,_10020,_10078,_10102],_9931,_9933) --> 
    not_look_ahead(w(verb(_9881,_9882,_9883)),_9957,_9931,_9974),
    look_ahead(w(prep(_9889)),_9986,_9974,_10003),
    !,
    pushstack(first,w(verb(do1,pres,fin)),nil,_10003,_10033),vp_kernel(_9850,_9851,_9852,_9853,_9874,_10020,_10033,_10054),
    it0(_10078,_10054,_10093),
    verb_modifiers0(_9850,_9851,_9853,_9874,_9854,_10102,_10093,_9933).

rvp_kernel(_9850,_9851,_9852,_9853,_9854,[rvp_kernel,_10047,{},_10106,_10135,_10164,_10193,_10222,{},_10266,_10310,_10339,!,_10378,_10498],_10021,_10023) --> 
    hlexv(dtv,_9850,_9906,_9907,_9908,_10047,_10021,_10072),
    {user:testmember(_9850,[ask,tell,answer,answer1])},
    not_look_ahead([om],_10106,_10072,_10123),
    not_look_ahead([et],_10135,_10123,_10152),
    not_look_ahead([en],_10164,_10152,_10181),
    not_look_ahead(w(nb(_9939,_9940)),_10193,_10181,_10210),
    ind_object(_9942,_9943,_10222,_10210,_10241),
    {user:constrain(_9942,agent)},
    optional([om],_10266,_10241,_10298),
    not_look_ahead([at],_10310,_10298,_10327),
    np1_accept(_9901,_9902,_10339,_10327,_10358),
    !,
    pushstack(first,(lexv(dtv,_9850,_9906,_9907),xnp(_9942,_9943),[noe]),nil,_10358,_10453),vp_kernel(_9850,_9851,_9852,_9853,_9976,_10378,_10453,_10474),
    pushstack(first,(w(prep(about)),xnp(_9901,_9902)),nil,_10474,_10539),
    verb_modifiers0(_9850,_9851,_9853,_9976,_9854,_10498,_10539,_10023).

rvp_kernel(_9850,_9851,_9852,_9853,_9854,[rvp_kernel,_9930,_9979,_10008,!],_9904,_9906) --> 
    lexvaccept(rv,_9850,_9867,_9868,_9852,_9930,_9904,_9955),
    reflexiv0(_9850,_9979,_9955,_9996),
    rvpk(_9850,_9851,id,_9853,_9854,_10008,_9996,_9906),
    !.

rvp_kernel(_9850,_9851,id,_9853,event/real/_9853::_9859 and _9860,[rvp_kernel,_9995,{},_10054,_10083,{},_10122,!,_10151,_10175,{}],_9969,_9971) --> 
    hlexv(rv,_9850,_9905,_9906,_9907,_9995,_9969,_10020),
    {user:testmember(_9850,[know,say])},
    reflexiv0(_9850,_10054,_10020,_10071),
    w(prep(_9922),_10083,_10071,_10100),
    {user:(\+testmember(_9922,[]))},
    which(_10122,_10100,_10137),
    !,
    accept(_10151,_10137,_10166),
    pushstack(first,(w(prep(_9922)),which),nil,_10166,_10216),ppstnp(_9899,_9859,_10175,_10216,_9971),
    {user:tv_template(_9850,_9851,_9899,_9853,_9860)}.

rvp_kernel(adj/nil/_9863,_9851,_9852,_9853,_9856::_9859 and _9860,[rvp_kernel,_9968,_9997,_10026,_10055,_10079,{}],_9942,_9944) --> 
    w(verb(be,_9895,fin),_9968,_9942,_9985),
    negation0(_9852,_9997,_9985,_10014),
    w(adj2(_9863,nil),_10026,_10014,_10043),
    forat(_10055,_10043,_10070),
    clausal_object1(_9911:_9912,_9856::_9860,_10079,_10070,_9944),
    {user:atv_template(_9863,because_of,_9851,_9911:_9912,_9853,_9859)}.

rvpk(_9850,_9851,id,_9853,_9856::_9859 and _9860,[rvpk,{},_10003,lit(hvordan),_10038,!,_10067,_10091,{}],_9967,_9969) --> 
    {user:testmember(_9850,[ask,answer,answer1,discuss,know,know1])},
    omut0(_10003,_9967,_10018),
    cc(hvordan,_10018,_10037),
    endofline0(_10038,_10037,_10053),
    !,
    accept(_10067,_10053,_10082),
    pushstack(first,(w(noun(bus,sin,def,n)),w(verb(go,pres,fin))),nil,_10082,_10104),clausal_object1(_9929:_9930,_9856::_9860,_10091,_10104,_9969),
    {user:co_template(_9850,how,_9851,_9929:_9930,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},_9999,lit(hvordan),!,_10039,{},!,_10083,_10107,{}],_9963,_9965) --> 
    {user:testmember(_9850,[ask,answer,answer1,discuss,know,know1])},
    omut0(_9999,_9963,_10014),
    cc(hvordan,_10014,_10033),
    !,
    negation0(_9852,_10039,_10033,_10056),
    {user:test(rv_templ(_9850,_9924))},
    !,
    accept(_10083,_10056,_10098),
    clausal_object1(_9932:_9933,_9856::_9860,_10107,_10098,_9965),
    {user:co_template(_9850,how,_9851,_9932:_9933,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,_9996,_10030,lit(at),_10070,!,_10104,_10143,{}],_9970,_9972) --> 
    gmem(_9850,[calculate,say,tell,know,decide,believe,doubt,think],_9996,_9970,_10015),
    negation0(_9852,_10030,_10015,_10047),
    cc(at,_10047,_10069),
    look_ahead_lit([hvis,'når',selvom],_10070,_10069,_10087),
    !,
    subordinate(_9922,_9923,_9924,_10104,_10087,_10125),
    lock(last,_10125,_10195),pushstack(last,subordinate(_9922,_9923,_9924),nil,_10195,_10201),clausal_object1(_9939:_9940,_9856::_9860,_10143,_10201,_10190),unlock(_10190,_9972),
    {user:tv_template(_9850,_9851,_9939:_9940,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,_9975,_10009,_10033,_10062,_10091,{}],_9949,_9951) --> 
    gmem(_9850,[calculate,fear,hope,know,mean,recognize,think,understand],_9975,_9949,_9994),
    redundant0(_10009,_9994,_10024),
    negation0(_9852,_10033,_10024,_10050),
    not_look_ahead_lit([at,om],_10062,_10050,_10079),
    clausal_object0(_9918:_9919,_9856::_9860,_10091,_10079,_9951),
    {user:tv_template(_9850,_9851,_9918:_9919,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,_9983,_10017,lit(at),_10057,!,_10096,_10120,{}],_9957,_9959) --> 
    gmem(_9850,[do1,paint],_9983,_9957,_10002),
    negation0(_9852,_10017,_10002,_10034),
    cc(at,_10034,_10056),
    np0_accept(_9902,_9903,_10057,_10056,_10076),
    !,
    accept(_10096,_10076,_10111),
    pushstack(first,(xnp(_9902,_9903),w(verb(be,pres,fin))),nil,_10111,_10164),clausal_object1(_9923:_9924,_9856::_9860,_10120,_10164,_9959),
    {user:tv_template(_9850,_9851,_9923:_9924,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},_9976,_10005,lit(at),!,_10045,{}],_9940,_9942) --> 
    {user:testmember(_9850,[base,say,tell])},
    negation0(_9852,_9976,_9940,_9993),
    preadverbials0(_10005,_9993,_10020),
    cc(at,_10020,_10039),
    !,
    clausal_object1(_9909:_9910,_9856::_9860,_10045,_10039,_9942),
    {user:tv_template(_9850,_9851,_9909:_9910,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},_9979,_10008,!,_10042,_10066,{}],_9943,_9945) --> 
    {user:testmember(_9850,[mean,think])},
    pronoun(_9897,_9979,_9943,_9996),
    negation0(_9852,_10008,_9996,_10025),
    !,
    accept(_10042,_10025,_10057),
    pushstack(first,pronoun(_9897),nil,_10057,_10109),clausal_object1(_9912:_9913,_9856::_9860,_10066,_10109,_9945),
    {user:tv_template(_9850,_9851,_9912:_9913,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},_9982,_10011,_10045,lit('å'),!,_10105,{}],_9946,_9948) --> 
    {user:testmember(_9850,[regard])},
    negation0(_9852,_9982,_9946,_9999),
    object1(_9900,_9901,_10011,_9999,_10030),
    optional([for],_10045,_10030,_10077),
    cc('å',_10077,_10099),
    !,
    pushstack(first,xnp(_9900,_9901),nil,_10099,_10149),clausal_object1(_9887,_9856::_9860,_10105,_10149,_9948),
    {user:tv_template(_9850,_9851,_9887,_9853,_9859)}.

rvpk(_9850,_9851,id,_9853,_9856::_9859 and _9860,[rvpk,{},_9982,_10026,lit('når'),!,_10086,_10110,{}],_9946,_9948) --> 
    {user:testmember(_9850,[wonder])},
    optional(['på'],_9982,_9946,_10014),
    optional([om],_10026,_10014,_10058),
    cc('når',_10058,_10080),
    !,
    accept(_10086,_10080,_10101),
    clausal_object1(_9915:coevent,_9856::_9860,_10110,_10101,_9948),
    {user:co_template(_9850,when,_9851,_9915:coevent,_9853,_9859)}.

rvpk(_9850,_9851,id,_9853,_9856::_9859 and _9860,[rvpk,{},_9977,lit(om),!,_10037,_10061,{}],_9941,_9943) --> 
    {user:testmember(_9850,[think,wonder])},
    optional(['på'],_9977,_9941,_10009),
    cc(om,_10009,_10031),
    !,
    accept(_10037,_10031,_10052),
    clausal_object1(_9910:coevent,_9856::_9860,_10061,_10052,_9943),
    {user:co_template(_9850,whether,_9851,_9910:coevent,_9853,_9859)}.

'altsogå'(['altsogå',lit('altså'),lit('å')],_9872,_9874) --> 
    cc('altså',_9872,_9893),
    cc('å',_9893,_9874).

'altsogå'(['altsogå',lit(og),lit('å')],_9872,_9874) --> 
    cc(og,_9872,_9893),
    cc('å',_9893,_9874).

ppstnp(_9850,_9851,[ppstnp,_9911,_9940,_9964,_10003],_9894,_9896) --> 
    w(prep(_9863),_9911,_9894,_9928),
    which(_9940,_9928,_9955),
    np_kernel(0,_9850,_9865,_9964,_9955,_9985),
    forwst(_9851,_9863,_9850,_9865,_10003,_9985,_9896).

forwst(_9850,_9851,_9852,_9853,[forwst,_9910],_9887,_9889) --> 
    pushstack(free,adverbial1(_9851,_9852,_9853),nil,_9887,_9952),
    statreal(_9850,_9910,_9952,_9889).

forat([forat,lit(at)],_9867,_9869) --> 
    cc(at,_9867,_9869).

forat([forat,lit(for),lit(at)],_9872,_9874) --> 
    cc(for,_9872,_9893),
    cc(at,_9893,_9874).

forat([forat,lit(fordi)],_9867,_9869) --> 
    cc(fordi,_9867,_9869).

forat([forat,lit(av),lit(at)],_9872,_9874) --> 
    cc(av,_9872,_9893),
    cc(at,_9893,_9874).

forat([forat,lit(over),lit(at)],_9872,_9874) --> 
    cc(over,_9872,_9893),
    cc(at,_9893,_9874).

forat([forat,lit(til),lit(at)],_9872,_9874) --> 
    cc(til,_9872,_9893),
    cc(at,_9893,_9874).

forat([forat,lit(om)],_9867,_9869) --> 
    cc(om,_9867,_9869).

rvpk(_9850,_9851,id,_9853,_9856::_9859 and _9860,[rvpk,{},_9994,lit(hvor),_10029,!,_10063,{}],_9958,_9960) --> 
    {user:testmember(_9850,[ask,answer,answer1,discuss,know,know1])},
    omut0(_9994,_9958,_10009),
    cc(hvor,_10009,_10028),
    w(adj2(_9910,nil),_10029,_10028,_10046),
    !,
    pushstack(free,w(adj2(_9910,nil)),nil,_10046,_10076),clausal_object1(_9927:_9928,_9856::_9860,_10063,_10076,_9960),
    {user:co_template(_9850,how,_9851,_9927:_9928,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,_9999,_10033,_10062,_10086,lit('når'),{},!,_10136,!,_10170,_10194,{}],_9973,_9975) --> 
    gmem(_9850,[ask,answer,answer1,discover,discuss,know,know1,say],_9999,_9973,_10018),
    reflexiv0(_9850,_10033,_10018,_10050),
    redundant0(_10062,_10050,_10077),
    omut0(_10086,_10077,_10101),
    cc('når',_10101,_10120),
    {user:test(rv_templ(_9850,_9932))},
    !,
    negation0(_9852,_10136,_10120,_10153),
    !,
    accept(_10170,_10153,_10185),
    clausal_object1(_9942:_9943,_9856::_9860,_10194,_10185,_9975),
    {user:co_template(_9850,when,_9851,_9942:_9943,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},{},lit(_9923),{},!,_10046,!,_10080,_10104,{}],_9974,_9976) --> 
    {user:(\+testmember(_9850,[fail,help,let,lie2,slip,try]))},
    {user:test(rv_templ(_9850,_9922))},
    cc(_9923,_9974,_10030),
    {user:testmember(_9923,[hvorfor,hvordan])},
    !,
    negation0(_9852,_10046,_10030,_10063),
    !,
    accept(_10080,_10063,_10095),
    clausal_object1(_9943:_9944,_9856::_9860,_10104,_10095,_9976),
    {user:co_template(_9850,why,_9851,_9943:_9944,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},_9988,_10017,lit(at),!,_10072,{},[]],_9952,_9954) --> 
    {user:testmember(_9850,[say,tell])},
    negation0(_9852,_9988,_9952,_10005),
    pp(_9886,_9887,_9888,_10017,_10005,_10038),
    cc(at,_10038,_10066),
    !,
    clausal_object1(_9913:_9914,_9856::_9860,_10072,_10066,_10091),
    {user:tv_template(_9850,_9851,_9913:_9914,_9853,_9859)},
    pushstack(free,adverbial1(_9886,_9887,_9888),nil,_10091,_9954),
    [].

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},_10011,_10040,_10064,{},{},!,_10118,_10142,{}],_9975,_9977) --> 
    {user:(\+testmember(_9850,[fail,help,let,lie2,slip,think,try,propose]))},
    reflexiv0(_9850,_10011,_9975,_10028),
    omut0(_10040,_10028,_10055),
    negation0(_9852,_10064,_10055,_10081),
    {user:test(rv_templ(_9850,_9929))},
    {user:(\+verbtype(_9850,tv))},
    !,
    accept(_10118,_10081,_10133),
    clausal_object0(_9944:_9945,_9856::_9860,_10142,_10133,_9977),
    {user:tv_template(_9850,_9851,_9944:_9945,_9853,_9859)}.

at0([at0,lit(at),!],_9870,_9872) --> 
    cc(at,_9870,_9872),
    !.

at0([at0,_9894],_9883,_9885) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de,det],_9894,_9883,_9885).

omut0([omut0,lit(om),!],_9870,_9872) --> 
    cc(om,_9870,_9872),
    !.

omut0([omut0,lit(ut),!],_9870,_9872) --> 
    cc(ut,_9870,_9872),
    !.

omut0([omut0,[]],_9865,_9865) --> 
    [].

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},_10000,lit(om),_10040,!,_10074,!,_10108,_10132,{}],_9964,_9966) --> 
    {user:testmember(_9850,[ask,say,know,know1,answer,answer1])},
    reflexiv0(_9850,_10000,_9964,_10017),
    cc(om,_10017,_10039),
    not_look_ahead_lit([et,en],_10040,_10039,_10057),
    !,
    negation0(_9852,_10074,_10057,_10091),
    !,
    accept(_10108,_10091,_10123),
    clausal_object1(_9933:_9934,_9856::_9860,_10132,_10123,_9966),
    {user:co_template(_9850,whether,_9851,_9933:_9934,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},{},_10015,_10044,lit(at),!,_10084,!,_10118,_10142,{}],_9969,_9971) --> 
    {user:test(rv_templ(_9850,_9905))},
    {user:(\+testmember(_9850,[fail,help,let,lie2,slip,try]))},
    reflexiv0(_9850,_10015,_9969,_10032),
    omut0(_10044,_10032,_10059),
    cc(at,_10059,_10078),
    !,
    negation0(_9852,_10084,_10078,_10101),
    !,
    accept(_10118,_10101,_10133),
    clausal_object1(_9938:_9939,_9856::_9860,_10142,_10133,_9971),
    {user:tv_template(_9850,_9851,_9938:_9939,_9853,_9859)}.

at0([at0,lit(at),!],_9870,_9872) --> 
    cc(at,_9870,_9872),
    !.

at0([at0,_9892],_9881,_9883) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_9892,_9881,_9883).

omut0([omut0,lit(om),!],_9870,_9872) --> 
    cc(om,_9870,_9872),
    !.

omut0([omut0,lit(ut),!],_9870,_9872) --> 
    cc(ut,_9870,_9872),
    !.

omut0([omut0,[]],_9865,_9865) --> 
    [].

rvpk(_9850,_9851,_9852,_9853,_9854,[rvpk,{},_9984,_10028,_10052,!,_10091],_9948,_9950) --> 
    {user:testmember(_9850,[ask,check,discuss,know,know1,tell])},
    optional([om],_9984,_9948,_10016),
    hvilkemange(_10028,_10016,_10043),
    clausal_object0(_9880,_9881,_10052,_10043,_10071),
    !,
    pushstack(first,(w(verb(_9850,pres,fin)),w(prep(about)),xnp(_9880,_9881)),nil,_10071,_10132),
    do_phrase(_9850,_9851,_9852,_9853,_9854,_10091,_10132,_9950).

hvilkemange([hvilkemange,lit(hvilke)],_9867,_9869) --> 
    cc(hvilke,_9867,_9869).

hvilkemange([hvilkemange,lit(hvor),lit(mange)],_9872,_9874) --> 
    cc(hvor,_9872,_9893),
    cc(mange,_9893,_9874).

rvpk(_9850,_9851,id,_9853,_9856::_9859 and _9860,[rvpk,lit(om),lit('å'),{},{},!,_10024,{}],_9951,_9953) --> 
    cc(om,_9951,_9987),
    cc('å',_9987,_9998),
    {user:testmember(_9850,[ask])},
    {user:test(rv_templ(_9850,_9904))},
    !,
    pushstack(first,(npgap(_9851),aux1),nil,_9998,_10095),clausal_object1(_9918:coevent,_9856::_9860,_10024,_10095,_9953),
    {user:tv_template(_9850,_9851,_9918:coevent,_9853,_9859)}.

rvpk(_9850,_9851,id,_9853,_9856::_9859 and _9860,[rvpk,_9970,_10004,!,_10053,{}],_9944,_9946) --> 
    gmem(_9850,[need,start,stop,try,use2],_9970,_9944,_9989),
    optional(['å'],_10004,_9989,_10036),
    !,
    pushstack(first,(npgap(_9851),aux1),nil,_10036,_10124),clausal_object1(_9911:coevent,_9856::_9860,_10053,_10124,_9946),
    {user:tv_template(_9850,_9851,_9911:coevent,_9853,_9859)}.

rvpk(_9850,_9851,id,_9853,_9856::_9859 and _9860,[rvpk,_10032,lit('å'),{},!,_10102,_10126,{}],_10006,_10008) --> 
    optional(['på'],_10032,_10006,_10064),
    cc('å',_10064,_10086),
    {user:testmember(_9850,[avoid,choose,consider,deny,end,expect,forget,hate,hope,learn,like,manage,need,postpone,promise,propose,reach,recommend,refuse,remember,resist,risk,seem,slip,start,think,try,use2,want,wish,wonder])},
    !,
    accept(_10102,_10086,_10117),
    pushstack(first,(npgap(_9851),aux1),nil,_10117,_10197),clausal_object1(_9973:coevent,_9856::_9860,_10126,_10197,_10008),
    {user:tv_template(_9850,_9851,_9973:coevent,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},_10044,_10073,lit(om),_10128,_10162,_10191,!,_10220,_10244,{},_10298,{},{}],_10008,_10010) --> 
    {user:testmember(_9850,[answer,answer1,say])},
    reflexiv0(_9850,_10044,_10008,_10061),
    optional(['på'],_10073,_10061,_10105),
    cc(om,_10105,_10127),
    np1_accept(_9926,_9927,_10128,_10127,_10147),
    negation0(_9929,_10162,_10147,_10179),
    look_ahead_vp(_10191,_10179,_10206),
    !,
    accept(_10220,_10206,_10235),
    lexv(_9931,_9932,_9933,fin,_10244,_10235,_10267),
    {user:test(rv_templ(_9850,_9941))},
    pushstack(first,(xnp(_9926,_9927),w(verb(_9932,_9933,fin)),negation0(_9929)),nil,_10267,_10375),clausal_object1(_9960:coevent,_9856::_9860,_10298,_10375,_10010),
    {user:tv_template(_9850,_9851,_9960:coevent,_9853,_9904)},
    {user:negate(_9852,_9904,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9854,[rvpk,{},lit(om),_9993,_10032,!,_10066],_9946,_9948) --> 
    {user:testmember(_9850,[ask,worry,tell])},
    cc(om,_9946,_9992),
    np_kernel(0,_9881,_9882,_9993,_9992,_10014),
    look_ahead([som],_10032,_10014,_10049),
    !,
    pushstack(first,(w(verb(_9850,pres,fin)),w(prep(about)),np_kernel(0,_9881,_9882)),nil,_10049,_10108),
    do_phrase(_9850,_9851,_9852,_9853,_9854,_10066,_10108,_9948).

rvpk(_9850,_9851,id,_9853,_9856::_9859 and _9860,[rvpk,{},lit(om),_9982,{}],_9935,_9937) --> 
    {user:testmember(_9850,[ask,check,discuss,know,know1,see])},
    cc(om,_9935,_9981),
    clausal_object1(_9904:coevent,_9856::_9860,_9982,_9981,_9937),
    {user:tv_template(_9850,_9851,_9904:coevent,_9853,_9859)}.

rvpk(_9850,_9851,_9852,_9853,_9854,[rvpk,{},lit(om),_9984,!,_10023],_9937,_9939) --> 
    {user:testmember(_9850,[ask,worry,tell])},
    cc(om,_9937,_9983),
    np1_accept(_9877,_9878,_9984,_9983,_10003),
    !,
    pushstack(first,(w(verb(_9850,pres,fin)),w(prep(about)),xnp(_9877,_9878)),nil,_10003,_10064),
    do_phrase(_9850,_9851,_9852,_9853,_9854,_10023,_10064,_9939).

rvpk(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[rvpk,{},_10001,_10030,_10059,{},!,_10103,_10127,{}],_9965,_9967) --> 
    {user:testmember(_9850,[believe,clculate,know,know1,mean,tell,say])},
    negation0(_9852,_10001,_9965,_10018),
    reflexiv0(_9850,_10030,_10018,_10047),
    not_look_ahead([om],_10059,_10047,_10076),
    {user:test(rv_templ(_9850,_9926))},
    !,
    accept(_10103,_10076,_10118),
    clausal_object0(_9934:_9935,_9856::_9860,_10127,_10118,_9967),
    {user:tv_template(_9850,_9851,_9934:_9935,_9853,_9859)}.

clausal_object0(_9850,_9851,[clausal_object0,_9908,_9937,!,_9976],_9891,_9893) --> 
    look_ahead(w(nb(_9866,_9867)),_9908,_9891,_9925),
    obviousdate(_9850,_9851,_9937,_9925,_9956),
    !,
    accept(_9976,_9956,_9893).

clausal_object0(_9850,_9851,[clausal_object0,_9910,_9939,_9973],_9893,_9895) --> 
    not_look_ahead(w(nb(_9868,_9869)),_9910,_9893,_9927),
    np(_9859,_9860,_9939,_9927,_9958),
    cond_vp(_9859,_9860,_9850,_9851,_9973,_9958,_9895).

cond_vp(_9850,_9851,_9852,_9853,[cond_vp,_9932,{},_9971,!],_9909,_9911) --> 
    look_ahead([_9865],_9932,_9909,_9949),
    {user:testmember(_9865,[du,jeg])},
    lock(last,_9949,_10022),pushstack(last,xnp(_9850,_9851),nil,_10022,_10028),clausal_object1(_9852,_9853,_9971,_10028,_10017),unlock(_10017,_9911),
    !.

cond_vp(_9850,_9851,_9852,_9853,[cond_vp,_9923,_9952,_9976,!],_9900,_9902) --> 
    not_look_ahead(['så'],_9923,_9900,_9940),
    look_ahead_vp(_9952,_9940,_9967),
    pushstack(first,xnp(_9850,_9851),nil,_9967,_10020),clausal_object1(_9852,_9853,_9976,_10020,_9902),
    !.

cond_vp(_9850,_9851,_9850,_9851,[cond_vp,[]],_9878,_9878) --> 
    [].

clausal_object1(_9865:coevent,_9853::exists(_9865:coevent)::_9865 isa coevent and event/_9865/_9877 and _9863,[clausal_object1,_9924],_9907,_9909) --> 
    substatem(_9877,_9853::_9863,_9924,_9907,_9909).

clausal_object2(_9865:coevent,_9853::exists(_9865:coevent)::_9865 isa coevent and event/_9865/_9877 and _9863,[clausal_object2,_9924],_9907,_9909) --> 
    sostatem(_9877,_9853::_9863,_9924,_9907,_9909).

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_9988,{},_10047,_10081,_10125,{},_10209,_10248],_9962,_9964) --> 
    hlexv(dtv,_9850,_9885,_9886,_9880,_9988,_9962,_10013),
    {user:testmember(_9850,[allow,let])},
    ind_object(_9898,_9899,_10047,_10013,_10066),
    optional(['å'],_10081,_10066,_10113),
    pushstack(first,(xnp(_9898,_9899),[vil]),nil,_10113,_10169),clausal_object1(_9913,_9916::_9857,_10125,_10169,_10184),
    {user:tv_template(_9850,_9851,_9913,_9853,_9928)},
    someevent00(_9853,_9928,_9856::_9916,_10209,_10184,_10230),
    negation2(_9880,_9852,_10248,_10230,_9964).

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9859 and _9860,[vp_kernel,_10030,_10074,_10103,_10132,_10161,_10190,_10224,_10253,{},_10292,{},_10336,_10380],_10004,_10006) --> 
    lexv(dtv,_9850,_9907,fin,_10030,_10004,_10053),
    not_look_ahead(w(adj2(_9914,nil)),_10074,_10053,_10091),
    not_look_ahead(w(nb(_9921,_9922)),_10103,_10091,_10120),
    not_look_ahead_lit([en,et,den,det,han,hun,vi],_10132,_10120,_10149),
    negation0(_9940,_10161,_10149,_10178),
    ind_object(_9942,_9903::_9859,_10190,_10178,_10209),
    negation0(_9948,_10224,_10209,_10241),
    not_look_ahead(['så'],_10253,_10241,_10270),
    {user:bigno(_9940,_9948,_9852)},
    object(_9960,_9903::_9860,_10292,_10270,_10311),
    {user:dtv_template(_9850,_9851,_9942,_9960,_9853,_9899)},
    optional([til],_10336,_10311,_10368),
    someevent00(_9853,_9899,_9856::_9903,_10380,_10368,_10006).

vp_kernel(notify,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_9967,_10016,!,_10050,_10074,{},_10140],_9941,_9943) --> 
    hlexv(tv,notify,_9886,_9887,_9852,_9967,_9941,_9992),
    look_ahead(w(nb(_9894,_9895)),_10016,_9992,_10033),
    !,
    accept(_10050,_10033,_10065),
    lock(exact,_10065,_10094),pushstack(exact,[meg],nil,_10094,_10100),np0_accept(_9902,_9882::_9857,_10074,_10100,_10089),unlock(_10089,_10090),
    {user:tv_template(notify,_9851,_9902,_9853,_9878)},
    someevent00(_9853,_9878,_9856::_9882,_10140,_10090,_9943).

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_9973,_10022,_10046,_10085,!,_10129,{},_10163,[]],_9947,_9949) --> 
    lexvaccept(tv,_9850,_9892,fin,_9852,_9973,_9947,_9998),
    redundant0(_10022,_9998,_10037),
    adverbx(_9886,_9887,_9888,_10046,_10037,_10067),
    object2(_9851,_9901,_9904::_9857,_10085,_10067,_10106),
    !,
    accept(_10129,_10106,_10144),
    {user:tv_template(_9850,_9851,_9901,_9853,_9913)},
    someevent00(_9853,_9913,_9856::_9904,_10163,_10144,_10184),
    pushstack(free,adverbx(_9886,_9887,_9888),nil,_10184,_9949),
    [].

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_10018,_10067,_10096,{},{},{},{},{},!,_10190,{},_10224],_9992,_9994) --> 
    hlexv(tv,_9850,_9901,_9902,_9852,_10018,_9992,_10043),
    not_look_ahead_lit([om,hver],_10067,_10043,_10084),
    object2(_9851,_9912,_9897::_9857,_10096,_10084,_10117),
    {user:(\+constrain(_9912,date);_9850==have)},
    {user:(\+constrain(_9912,distance))},
    {user:(\+constrain(_9912,minute))},
    {user:(\+constrain(_9912,hour))},
    {user:(\+constrain(_9912,clock))},
    !,
    accept(_10190,_10117,_10205),
    {user:tv_template(_9850,_9851,_9912,_9853,_9893)},
    someevent00(_9853,_9893,_9856::_9897,_10224,_10205,_9994).

vp_kernel(_9850,_9851,_9852,_9853,_9854,[vp_kernel,_9962,_10011,{},{},!,_10070,_10094,_10118,_10147],_9936,_9938) --> 
    hlexv(iv,_9850,_9886,fin,_9852,_9962,_9936,_9987),
    gmem(_9850,[run,pass],_10011,_9987,_10030),
    {user:iv_template(_9850,_9851,_9853,_9881)},
    {user:_9886\==imp},
    !,
    redundants0(_10070,_10030,_10085),
    it0(_10094,_10085,_10109),
    reflexiv0(_9850,_10118,_10109,_10135),
    someevent00(_9853,_9881,_9854,_10147,_10135,_9938).

vp_kernel(have,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_10005,_10034,_10058,{},_10097,lit(om),_10137,!,_10171,{},_10224],_9979,_9981) --> 
    negation0(_9896,_10005,_9979,_10022),
    has(_10034,_10022,_10049),
    negation0(_9898,_10058,_10049,_10075),
    {user:bigno(_9896,_9898,_9852)},
    w(noun(information,sin,u,n),_10097,_10075,_10114),
    cc(om,_10114,_10136),
    not_look_ahead_lit(['når','å',at],_10137,_10136,_10154),
    !,
    pushstack(first,(w(noun(information,sin,u,n)),w(prep(regarding))),nil,_10154,_10184),np1(_9933,_9894::_9857,_10171,_10184,_10199),
    {user:tv_template(have,_9851,_9933,_9853,_9890)},
    someevent00(_9853,_9890,_9856::_9894,_10224,_10199,_9981).

vp_kernel(have,_9851,_9852,_9853,_9854,[vp_kernel,_9950,_9979,_10003,{},!,_10047],_9924,_9926) --> 
    negation0(_9852,_9950,_9924,_9967),
    has(_9979,_9967,_9994),
    w(adj2(_9876,nil),_10003,_9994,_10020),
    {user:testmember(_9876,[open,closed])},
    !,
    pushstack(first,w(adj2(_9876,nil)),nil,_10020,_10057),
    be_complement(_9851,_9853,_9854,_10047,_10057,_9926).

vp_kernel(have,_9851,_9852,_9853,_9854,[vp_kernel,_9950,lit(det),_9985,_10014,_10043,!,_10092],_9924,_9926) --> 
    has(_9950,_9924,_9965),
    cc(det,_9965,_9984),
    negation0(_9852,_9985,_9984,_10002),
    w(adj2(_9879,nil),_10014,_10002,_10031),
    optional([da],_10043,_10031,_10075),
    !,
    pushstack(first,w(adj2(_9879,nil)),nil,_10075,_10102),
    be_complement(_9851,_9853,_9854,_10092,_10102,_9926).

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_10019,_10048,_10077,_10126,{},{},_10175,_10204,_10233,_10257,!,_10301,{},_10335,_10374],_9993,_9995) --> 
    not_look_ahead(w(verb(have,_9909,_9910)),_10019,_9993,_10036),
    not_look_ahead(w(verb(be2,_9917,_9918)),_10048,_10036,_10065),
    hlexv(tv,_9850,_9922,_9923,_9901,_10077,_10065,_10102),
    not_look_ahead(w(prep(_9930)),_10126,_10102,_10143),
    {user:_9850\==have},
    {user:_9850\==be2},
    reflexiv0(_9850,_10175,_10143,_10192),
    particle0(_9850,_10204,_10192,_10221),
    redundant0(_10233,_10221,_10248),
    object2(_9851,_9947,_9950::_9857,_10257,_10248,_10278),
    !,
    accept(_10301,_10278,_10316),
    {user:tv_template(_9850,_9851,_9947,_9853,_9959)},
    someevent00(_9853,_9959,_9856::_9950,_10335,_10316,_10356),
    negation2(_9901,_9852,_10374,_10356,_9995).

menbare([menbare,lit(men)],_9867,_9869) --> 
    cc(men,_9867,_9869).

menbare([menbare,lit(bare)],_9867,_9869) --> 
    cc(bare,_9867,_9869).

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_10029,_10058,_10087,{},{},{},_10166,_10205,_10234,{},_10283,_10322,[]],_10003,_10005) --> 
    not_look_ahead(w(verb(have,_9906,_9907)),_10029,_10003,_10046),
    not_look_ahead(w(verb(be2,_9914,_9915)),_10058,_10046,_10075),
    hlexv(tv,_9850,_9919,_9920,_9921,_10087,_10075,_10112),
    {user:_9850\==have},
    {user:_9850\==be2},
    {user:(\+verbtype(_9850,iv))},
    adverb(_9898,_9899,pre,_10166,_10112,_10187),
    not_look_ahead(w(noun(night,_9949,_9950,_9951)),_10205,_10187,_10222),
    object2(_9851,_9954,_9957::_9857,_10234,_10222,_10255),
    {user:tv_template(_9850,_9851,_9954,_9853,_9966)},
    someevent00(_9853,_9966,_9856::_9957,_10283,_10255,_10304),
    negation2(_9921,_9852,_10322,_10304,_10341),
    pushstack(free,xadverb(_9898,_9899),nil,_10341,_10005),
    [].

vp_kernel(be1,_9851,_9852,_9853,_9854,[vp_kernel,_9959,_9983,_10012,{},{},_10061,[]],_9933,_9935) --> 
    be(_9959,_9933,_9974),
    negation0(_9852,_9983,_9974,_10000),
    look_ahead(w(noun(_9887,_9888,_9889,_9890)),_10012,_10000,_10029),
    {user:subclass0(_9887,time)},
    {user:iv_template(be1,_9851,_9853,_9902)},
    someevent00(_9853,_9902,_9854,_10061,_10029,_10082),
    pushstack(free,w(prep(on)),nil,_10082,_9935),
    [].

vp_kernel(be1,_9851,id,_9853,_9854,[vp_kernel,_9961,{},_9995,{},{},_10044,[]],_9935,_9937) --> 
    be(_9961,_9935,_9976),
    {user:vartypeid(_9851,self)},
    look_ahead(w(name(_9890,n,_9892)),_9995,_9976,_10012),
    {user:subclass0(_9892,place)},
    {user:iv_template(be1,_9851,_9853,_9904)},
    someevent00(_9853,_9904,_9854,_10044,_10012,_10065),
    pushstack(free,w(prep(in)),nil,_10065,_9937),
    [].

vp_kernel(be1,_9851,_9852,_9853,_9854,[vp_kernel,_9935,_9959,_9988,{},_10022,_10046],_9909,_9911) --> 
    be(_9935,_9909,_9950),
    negation0(_9852,_9959,_9950,_9976),
    not_look_ahead_np(_9988,_9976,_10003),
    {user:iv_template(be1,_9851,_9853,_9872)},
    redundant0(_10022,_10003,_10037),
    someevent00(_9853,_9872,_9854,_10046,_10037,_9911).

vp_kernel(be1,_9851,_9852,_9853,_9854,[vp_kernel,_9955,_9979,_10008,{},!,{},_10062],_9929,_9931) --> 
    be(_9955,_9929,_9970),
    negation0(_9852,_9979,_9970,_9996),
    look_ahead(w(adv(_9884)),_10008,_9996,_10025),
    {user:testmember(_9884,[redundantly,inside,outside])},
    !,
    {user:iv_template(be1,_9851,_9853,_9875)},
    someevent00(_9853,_9875,_9854,_10062,_10025,_9931).

vp_kernel(be1,_9851,_9852,_9853,_9854,[vp_kernel,_9953,_9977,_10006,{},{},_10055,_10079],_9927,_9929) --> 
    be(_9953,_9927,_9968),
    negation0(_9852,_9977,_9968,_9994),
    look_ahead([_9881],_10006,_9994,_10023),
    {user:testmember(_9881,[her,der,overalt])},
    {user:iv_template(be1,_9851,_9853,_9875)},
    redundant0(_10055,_10023,_10070),
    someevent00(_9853,_9875,_9854,_10079,_10070,_9929).

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_9999,{},_10038,_10067,_10101,_10130,_10154,_10183,{},_10232,_10271,!,_10310],_9973,_9975) --> 
    w(verb(_9897,_9898,fin),_9999,_9973,_10016),
    {user:testmember(_9897,[have])},
    negation0(_9908,_10038,_10016,_10055),
    particlev2(_9897,_9850,_10067,_10055,_10086),
    reflexiv0(_9850,_10101,_10086,_10118),
    redundant0(_10130,_10118,_10145),
    not_look_ahead(w(verb(_9919,past,part)),_10154,_10145,_10171),
    object2(_9851,_9924,_9927::_9857,_10183,_10171,_10204),
    {user:tv_template(_9850,_9851,_9924,_9853,_9936)},
    someevent00(_9853,_9936,_9856::_9927,_10232,_10204,_10253),
    negation2(_9908,_9852,_10271,_10253,_10290),
    !,
    accept(_10310,_10290,_9975).

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_10010,{},!,_10069,_10098,_10147,_10176,_10200,{},_10249,!,_10293,[]],_9984,_9986) --> 
    lexv(tv,_9850,_9912,_9913,_10010,_9984,_10033),
    {user:testmember(_9850,[lay])},
    !,
    negation0(_9852,_10069,_10033,_10086),
    verb_mod1(_9850,_9902,_9853,_9904,_9907::_9908,_10098,_10086,_10123),
    particle(_9850,_10147,_10123,_10164),
    redundant0(_10176,_10164,_10191),
    object2(_9851,_9936,_9939::_9857,_10200,_10191,_10221),
    {user:tv_template(_9850,_9851,_9936,_9853,_9948)},
    someevent00(_9853,_9948,_9856::_9939,_10249,_10221,_10270),
    !,
    accept(_10293,_10270,_10308),
    pushstack(free,(particle(_9850),verb_mod1(_9850,_9902,_9853,_9904,_9907::_9908)),nil,_10308,_9986),
    [].

vp_kernel(evah,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_9949,_9993,_10022,{},_10071],_9923,_9925) --> 
    lexv(tv,evah,_9880,fin,_9949,_9923,_9972),
    negation0(_9852,_9993,_9972,_10010),
    subject2(_9851,_9886,_9889::_9872,_10022,_10010,_10043),
    {user:has_template(_9886,_9851,_9889)},
    someevent00(_9853,_9872,_9856::_9857,_10071,_10043,_9925).

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9857,[vp_kernel,_9978,{},_10037,{},_10076,_10100,{},_10149,_10188],_9952,_9954) --> 
    hlexv(tv,_9850,_9888,_9889,_9883,_9978,_9952,_10003),
    {user:_9850==be2},
    reflexiv0(_9850,_10037,_10003,_10054),
    {user:compliancetest2(tv,_9850,_9851)},
    redundant0(_10076,_10054,_10091),
    object2(_9851,_9906,_9909::_9857,_10100,_10091,_10121),
    {user:tv_template(_9850,_9851,_9906,_9853,_9918)},
    someevent00(_9853,_9918,_9856::_9909,_10149,_10121,_10170),
    negation2(_9883,_9852,_10188,_10170,_9954).

vp_kernel(_9850,_9851,_9852,_9853,_9854,[vp_kernel,_9949,{},{},_10018,_10042,_10066,_10095],_9923,_9925) --> 
    hlexv(iv,_9850,_9880,fin,_9852,_9949,_9923,_9974),
    {user:iv_template(_9850,_9851,_9853,_9875)},
    {user:_9880\==imp},
    redundants0(_10018,_9974,_10033),
    it0(_10042,_10033,_10057),
    reflexiv0(_9850,_10066,_10057,_10083),
    someevent00(_9853,_9875,_9854,_10095,_10083,_9925).

vp_kernel(_9850,_9851,_9852,_9853,_9856::_9857,[vp_kernel,{},_10001,lit('Må'),{},_10051,!,_10085,_10153,_10187],_9965,_9967) --> 
    {user:constrain(_9851,person)},
    not_look_ahead([kan],_10001,_9965,_10018),
    cc('Må',_10018,_10040),
    {user:testmember('Må',['må',skal,vil])},
    not_look_ahead(w(verb(_9916,_9917,_9918)),_10051,_10040,_10068),
    !,
    pushstack(first,w(verb(arrive,pres,fin)),nil,_10068,_10098),intrans_verb(_9850,_9851,_9931,_9853,_9884,_9934,_9935,_10085,_10098,_10123),
    negation2(_9931,_9852,_10153,_10123,_10172),
    someevent00(_9853,_9884,_9856::_9857,_10187,_10172,_9967).

worldcomp(_9850,_9851,event/_9850/_9851::_9853,_9853,[worldcomp,[]],_9887,_9887) --> 
    [].

realcomp(_9850,event/real/_9850::_9852,_9852,[realcomp,[]],_9884,_9884) --> 
    [].

someevent00(_9850,_9851,_9854::exists(_9850:event)::_9851 and _9854,[someevent00,[]],_9889,_9889) --> 
    [].

thatto0(_9850,that,_9852,[thatto0,_9906,!,[]],_9886,_9888) --> 
    infinitive(_9906,_9886,_9921),
    !,
    pushstack(free,npgap(_9852),nil,_9921,_9888),
    [].

thatto0(_9850,_9851,_9852,[thatto0,_9905,!,_9939],_9885,_9887) --> 
    w(prep(on),_9905,_9885,_9922),
    !,
    reject(_9939,_9922,_9887).

thatto0(_9850,_9851,_9852,[thatto0,lit(om),_9925,!,_9959],_9894,_9896) --> 
    cc(om,_9894,_9924),
    look_ahead(w(name(_9869,_9870,_9871)),_9925,_9924,_9942),
    !,
    reject(_9959,_9942,_9896).

thatto0(_9850,_9851,_9852,[thatto0,lit(om),_9926,!,_9960],_9895,_9897) --> 
    cc(om,_9895,_9925),
    look_ahead(w(noun(departure,_9870,_9871,n)),_9926,_9925,_9943),
    !,
    reject(_9960,_9943,_9897).

that0(_9850,that,[that0,lit('på'),!,_9913],_9880,_9882) --> 
    cc('på',_9880,_9907),
    !,
    reject(_9913,_9907,_9882).

that0(_9850,when,[that0,_9954,lit('når'),_9999,_10028,!,_10067,[],!,_10141],_9937,_9939) --> 
    gmem(_9850,[know,know1,think,ask,notify,tell],_9954,_9937,_9973),
    cc('når',_9973,_9998),
    w(verb(_9896,_9897,fin),_9999,_9998,_10016),
    np1(_9900,_9901,_10028,_10016,_10047),
    !,
    accept(_10067,_10047,_10082),
    pushstack(free,(xnp(_9900,_9901),w(verb(_9896,_9897,fin))),nil,_10082,_10135),[],
    !,
    accept(_10141,_10135,_9939).

that0(ask,that,[that0,_9897],_9880,_9882) --> 
    look_ahead(w(verb(_9857,inf,_9859)),_9897,_9880,_9882).

that0(answer,whether,[that0,_9894,lit(om)],_9877,_9879) --> 
    on0(_9894,_9877,_9909),
    cc(om,_9909,_9879).

that0(ask,that,[that0,lit(om),_9911,!,_9940],_9883,_9885) --> 
    cc(om,_9883,_9910),
    infinitive(_9911,_9910,_9926),
    !,
    accept(_9940,_9926,_9885).

that0(ask,whether,[that0,lit(om),!,_9913],_9880,_9882) --> 
    cc(om,_9880,_9907),
    !,
    accept(_9913,_9907,_9882).

that0(ask,that,[that0,_9895,!,_9924],_9878,_9880) --> 
    infinitive(_9895,_9878,_9910),
    !,
    accept(_9924,_9910,_9880).

that0(believe,that,[that0,lit(at),!],_9877,_9879) --> 
    cc(at,_9877,_9879),
    !.

that0(believe,that,[that0,[]],_9872,_9872) --> 
    [].

that0(know,whether,[that0,lit(om),!],_9877,_9879) --> 
    cc(om,_9877,_9879),
    !.

that0(know,that,[that0,lit(at),!],_9877,_9879) --> 
    cc(at,_9877,_9879),
    !.

that0(know,that,[that0,_9905,_9934],_9888,_9890) --> 
    not_look_ahead([en],_9905,_9888,_9922),
    not_look_ahead(w(noun(_9860,_9861,_9862,_9863)),_9934,_9922,_9890).

that0(know1,whether,[that0,lit(om),!],_9877,_9879) --> 
    cc(om,_9877,_9879),
    !.

that0(know1,that,[that0,lit(at),!],_9877,_9879) --> 
    cc(at,_9877,_9879),
    !.

that0(know1,that,[that0,_9905,_9934],_9888,_9890) --> 
    not_look_ahead([en],_9905,_9888,_9922),
    not_look_ahead(w(noun(_9860,_9861,_9862,_9863)),_9934,_9922,_9890).

that0(let,that,[that0,[]],_9872,_9872) --> 
    [].

that0(mean,that,[that0,lit(at),!],_9877,_9879) --> 
    cc(at,_9877,_9879),
    !.

that0(mean,that,[that0,[]],_9872,_9872) --> 
    [].

that0(notify,that,[that0,lit(at)],_9874,_9876) --> 
    cc(at,_9874,_9876).

that0(notify,that,[that0,lit(om),lit(at),!,_9929],_9885,_9887) --> 
    cc(om,_9885,_9912),
    cc(at,_9912,_9923),
    !,
    accept(_9929,_9923,_9887).

that0(notify,_9851,[that0,lit(om),!,_9913],_9880,_9882) --> 
    cc(om,_9880,_9907),
    !,
    reject(_9913,_9907,_9882).

that0(say,that,[that0,lit(at),!],_9877,_9879) --> 
    cc(at,_9877,_9879),
    !.

that0(say,that,[that0,[]],_9872,_9872) --> 
    [].

that0(tell,that,[that0,_9899,!,_9933],_9882,_9884) --> 
    look_ahead([et],_9899,_9882,_9916),
    !,
    reject(_9933,_9916,_9884).

that0(tell,that,[that0,_9899,!,_9933],_9882,_9884) --> 
    look_ahead([en],_9899,_9882,_9916),
    !,
    reject(_9933,_9916,_9884).

that0(tell,that,[that0,lit(at),!],_9877,_9879) --> 
    cc(at,_9877,_9879),
    !.

that0(think,that,[that0,lit(at),!],_9877,_9879) --> 
    cc(at,_9877,_9879),
    !.

that0(think,that,[that0,[]],_9872,_9872) --> 
    [].

that0(understand,how,[that0,lit(hvordan)],_9874,_9876) --> 
    cc(hvordan,_9874,_9876).

that0(want,that,[that0,lit(at),!],_9877,_9879) --> 
    cc(at,_9877,_9879),
    !.

that0(want,to,[that0,lit(og)],_9874,_9876) --> 
    cc(og,_9874,_9876).

that0(wish,that,[that0,_9897],_9880,_9882) --> 
    look_ahead(w(verb(_9857,_9858,_9859)),_9897,_9880,_9882).

that0(_9850,_9851,[that0,_9909,!,_9943,_9972],_9892,_9894) --> 
    that(_9851,_9909,_9892,_9926),
    !,
    not_look_ahead(w(noun(departure,_9869,_9870,_9871)),_9943,_9926,_9960),
    accept(_9972,_9960,_9894).

rep_modifiers0(_9850,_9851,_9852,_9853,_9854,[rep_modifiers0,lit(hvor),!,_9931],_9889,_9891) --> 
    cc(hvor,_9889,_9925),
    !,
    reject(_9931,_9925,_9891).

rep_modifiers0(_9850,_9851,_9852,_9853,_9854,[rep_modifiers0,lit(hva),!,_9931],_9889,_9891) --> 
    cc(hva,_9889,_9925),
    !,
    reject(_9931,_9925,_9891).

rep_modifiers0(_9850,_9851,_9852,_9853,_9854,[rep_modifiers0,{},_9952,{},_9991],_9916,_9918) --> 
    {user:testmember(_9850,[see])},
    look_ahead(w(prep(_9882)),_9952,_9916,_9969),
    {user:testmember(_9882,[in])},
    verb_modifier(_9850,_9851,_9852,_9853,_9854,_9991,_9969,_9918).

rep_modifiers0(_9850,_9851,_9852,_9853,_9854,[rep_modifiers0,{},_9945,_9974],_9909,_9911) --> 
    {user:testmember(_9850,[say,tell])},
    prep1(to,_9945,_9909,_9962),
    pushstack(first,prep(to),nil,_9962,_10014),
    verb_modifiers(_9850,_9851,_9852,_9853,_9854,_9974,_10014,_9911).

rep_modifiers0(_9850,_9851,_9852,_9853,_9853,[rep_modifiers0,[]],_9881,_9881) --> 
    [].

be_complements(_9850,_9851,_9854::_9857 and _9858,[be_complements,lit(at),_9949,!,_9983,_10007,{}],_9918,_9920) --> 
    cc(at,_9918,_9948),
    look_ahead(w(prep(_9889)),_9949,_9948,_9966),
    !,
    preadverbials(_9983,_9966,_9998),
    clausal_object2(_9878,_9854::_9858,_10007,_9998,_9920),
    {user:bealign(_9850,_9878,_9851,_9858,_9857)}.

be_complements(_9850,_9851,_9854::_9857 and _9858,[be_complements,lit(at),!,_9945,_9969,{}],_9909,_9911) --> 
    cc(at,_9909,_9939),
    !,
    accept(_9945,_9939,_9960),
    clausal_object1(_9875,_9854::_9858,_9969,_9960,_9911),
    {user:bealign(_9850,_9875,_9851,_9858,_9857)}.

be_complements(_9850,_9851,_9854::_9857 and _9858,[be_complements,lit('å'),!,_9948,_9972,{}],_9912,_9914) --> 
    cc('å',_9912,_9942),
    !,
    accept(_9948,_9942,_9963),
    pushstack(first,someone,nil,_9963,_10013),clausal_object1(_9875,_9854::_9858,_9972,_10013,_9914),
    {user:bealign(_9850,_9875,_9851,_9858,_9857)}.

be_complements(_9850,_9851,_9852,[be_complements,_9913,_9952],_9893,_9895) --> 
    be_complement(_9850,_9851,_9866::_9867,_9913,_9893,_9934),
    be_complements20(_9850,_9851,_9866::_9867,_9852,_9952,_9934,_9895).

be_complements20(_9850,_9851,_9855::_9858,_9855::_9858 or _9859,[be_complements20,lit(eller),_9959,!,_9993,_10032],_9925,_9927) --> 
    cc(eller,_9925,_9958),
    not_look_ahead_lit(['.',?],_9959,_9958,_9976),
    !,
    be_complement(_9850,_9851,_9855::_9897,_9993,_9976,_10014),
    be_complements20(_9850,_9851,_9855::_9897,_9855::_9859,_10032,_10014,_9927).

be_complements20(_9850,_9851,_9855::_9858,_9855::_9858 and _9859,[be_complements20,_9928,_9952,_9991],_9905,_9907) --> 
    be_compl_conjunction(_9928,_9905,_9943),
    be_pred(_9850,_9851,_9872,_9952,_9943,_9973),
    be_complements20(_9850,_9851,_9872,_9855::_9859,_9991,_9973,_9907).

be_complements20(_9850,_9851,_9852,_9852,[be_complements20,_9901],_9878,_9880) --> 
    redundant0(_9901,_9878,_9880).

be_compl_conjunction([be_compl_conjunction,lit(og),!],_9870,_9872) --> 
    cc(og,_9870,_9872),
    !.

be_compl_conjunction([be_compl_conjunction,lit(men),_9903,!],_9881,_9883) --> 
    cc(men,_9881,_9902),
    look_ahead(w(verb(_9862,past,part)),_9903,_9902,_9883),
    !.

be_complement(_9850,_9851,_9852,[be_complement,_9908,_9937],_9888,_9890) --> 
    not_look_ahead_lit([der,her],_9908,_9888,_9925),
    be_pred(_9850,_9851,_9852,_9937,_9925,_9890).

be_complement(_9850,_9851,_9852,[be_complement,_9908,_9937],_9888,_9890) --> 
    not_look_ahead_lit([der,her],_9908,_9888,_9925),
    be_noun(_9850,_9851,_9852,_9937,_9925,_9890).

be_pred(_9850,_9851,_9852,[be_pred,_9932,{},_9986,_10010],_9912,_9914) --> 
    ap(_9869,_9850,_9851,_9866,_9932,_9912,_9955),
    {user:(\+testmember(_9869,[true,whole]))},
    not_look_ahead_nounx(_9986,_9955,_10001),
    verb_modifiers0(adj/nil/_9869,_9850,_9851,_9866,_9852,_10010,_10001,_9914).

be_pred(_9850,_9851,_9852,[be_pred,_9919,_9948,{}],_9899,_9901) --> 
    look_ahead(w(prep(_9870)),_9919,_9899,_9936),
    verb_mod1(be1,_9850,_9851,_9862,_9863,_9948,_9936,_9901),
    {user:thenwhat(_9862,_9863,_9852)}.

be_pred(_9850,_9851,_9852,[be_pred,_9986,_10015,_10044,{},_10083,_10149],_9966,_9968) --> 
    w(nb(_9887,num),_9986,_9966,_10003),
    w(noun(percent,_9881,u,n),_10015,_10003,_10032),
    w(adj2(_9899,nil),_10044,_10032,_10061),
    {user:testmember(_9899,[certain,safe])},
    lock(exact,_10061,_10103),pushstack(exact,w(adj2(_9899,nil)),nil,_10103,_10109),ap(_9899,_9850,_9851,_9922,_10083,_10109,_10098),unlock(_10098,_10099),
    pushstack(first,(w(prep(with)),w(nb(_9887,num)),w(noun(percent,_9881,u,n))),nil,_10099,_10159),
    verb_modifiers0(adj/nil/_9899,_9850,_9851,_9922,_9852,_10149,_10159,_9968).

be_pred(_9850,_9851,_9852,[be_pred,_9979,_10003,_10027,!,_10061,{},_10100,_10166],_9959,_9961) --> 
    ofte0(_9979,_9959,_9994),
    mangenoen(_10003,_9994,_10018),
    w(noun(minute,_9891,u,n),_10027,_10018,_10044),
    !,
    w(adj2(_9897,nil),_10061,_10044,_10078),
    {user:testmember(_9897,[delayed,tooearly])},
    lock(exact,_10078,_10120),pushstack(exact,w(adj2(_9897,nil)),nil,_10120,_10126),ap(_9897,_9850,_9851,_9920,_10100,_10126,_10115),unlock(_10115,_10116),
    pushstack(first,(w(prep(with)),w(noun(minute,plu,u,n))),nil,_10116,_10176),
    verb_modifiers0(adj/nil/_9897,_9850,_9851,_9920,_9852,_10166,_10176,_9961).

ofte0([ofte0,lit(ofte)],_9867,_9869) --> 
    cc(ofte,_9867,_9869).

ofte0([ofte0,[]],_9865,_9865) --> 
    [].

mangenoen([mangenoen,lit(mange)],_9867,_9869) --> 
    cc(mange,_9867,_9869).

mangenoen([mangenoen,lit(flere)],_9867,_9869) --> 
    cc(flere,_9867,_9869).

mangenoen([mangenoen,lit(noen)],_9867,_9869) --> 
    cc(noen,_9867,_9869).

be_pred(_9850,_9851,_9852,[be_pred,_9986,_10015,_10044,{},_10083,_10149],_9966,_9968) --> 
    w(nb(_9887,num),_9986,_9966,_10003),
    w(noun(minute,_9881,u,n),_10015,_10003,_10032),
    w(adj2(_9899,nil),_10044,_10032,_10061),
    {user:testmember(_9899,[delayed,tooearly])},
    lock(exact,_10061,_10103),pushstack(exact,w(adj2(_9899,nil)),nil,_10103,_10109),ap(_9899,_9850,_9851,_9922,_10083,_10109,_10098),unlock(_10098,_10099),
    pushstack(first,(w(prep(with)),w(nb(_9887,num)),w(noun(minute,_9881,u,n))),nil,_10099,_10159),
    verb_modifiers0(adj/nil/_9899,_9850,_9851,_9922,_9852,_10149,_10159,_9968).

be_pred(_9850,_9851,_9852,[be_pred,lit(mer),_9946,_9975,_10041],_9915,_9917) --> 
    cc(mer,_9915,_9945),
    look_ahead([enn],_9946,_9945,_9963),
    lock(exact,_9963,_9995),pushstack(exact,w(adj2(great,nil)),nil,_9995,_10001),ap(_9883,_9850,_9851,_9866,_9975,_10001,_9990),unlock(_9990,_9991),
    verb_modifiers0(adj/nil/_9883,_9850,_9851,_9866,_9852,_10041,_9991,_9917).

be_pred(_9850,_9851,_9854::_9855,[be_pred,_9905],_9885,_9887) --> 
    passive(_9850,_9851,_9854::_9855,_9905,_9885,_9887).

be_pred(_9850,_9851,_9852,[be_pred,_9906,_9945],_9886,_9888) --> 
    comparisons(_9850,_9851,_9858,_9906,_9886,_9927),
    someevent00(_9851,_9858,_9852,_9945,_9927,_9888).

be_pred(_9850,_9851,_9854::_9855,[be_pred,_9919,_9943],_9899,_9901) --> 
    sure(_9919,_9899,_9934),
    pushstack(first,w(verb(know,pres,fin)),nil,_9934,_9953),
    do_phrase(know,_9850,id,_9851,_9854::_9855,_9943,_9953,_9901).

be_pred(_9850,_9851,_9852,[be_pred,_9943,_9987,{},_10026],_9923,_9925) --> 
    ap(_9870,_9850,_9851,_9873,_9943,_9923,_9966),
    look_ahead([hva],_9987,_9966,_10004),
    {user:(\+testmember(_9870,[true,whole]))},
    pushstack(first,w(prep(on)),nil,_10004,_10036),
    verb_modifiers0(adj/nil/_9870,_9850,_9851,_9873,_9852,_10026,_10036,_9925).

fordent0(_9850,[fordent0,_9888,!],_9874,_9876) --> 
    gradverb(_9850,_9888,_9874,_9876),
    !.

fordent0(nil,[fordent0,_9883],_9869,_9871) --> 
    dent0(_9883,_9869,_9871).

not_look_ahead_nounx([not_look_ahead_nounx,_9888,!],_9877,_9879) --> 
    look_ahead(w(noun(clock,sin,def,n)),_9888,_9877,_9879),
    !.

not_look_ahead_nounx([not_look_ahead_nounx,_9885],_9874,_9876) --> 
    not_look_ahead(w(noun(_9854,_9855,_9856,_9857)),_9885,_9874,_9876).

be_noun(_9850,_9851,_9854::exists(_9851:event)::_9858,[be_noun,lit(at),_9942,{},!],_9911,_9913) --> 
    cc(at,_9911,_9941),
    clausal_object1(_9876,_9854::_9880,_9942,_9941,_9913),
    {user:bealign(_9850,_9876,_9851,_9880,_9858)},
    !.

be_noun(_9850,_9851,_9854::exists(_9851:event)::_9858,[be_noun,_9961,_9990,{},!,_10048],_9941,_9943) --> 
    look_ahead(w(nb(_9890,_9891)),_9961,_9941,_9978),
    pushstack(first,w(noun(clock,sin,def,n)),nil,_9978,_10003),obviousclock(_9903,_9906::_9907,_9990,_10003,_10018),
    {user:bealign(_9850,_9903,_9851,_9907,_9915)},
    !,
    verb_modifiers0(exist,_9850,_9851,_9906::_9915,_9854::_9858,_10048,_10018,_9943).

be_noun(_9850,_9851,_9854::exists(_9851:event)::_9858,[be_noun,_9951,_9975,{},_10019,!,_10068],_9931,_9933) --> 
    redundant0(_9951,_9931,_9966),
    object(_9889,_9892::_9893,_9975,_9966,_9994),
    {user:bealign(_9850,_9889,_9851,_9893,_9901)},
    optional([bare],_10019,_9994,_10051),
    !,
    verb_modifiers0(exist,_9850,_9851,_9892::_9901,_9854::_9858,_10068,_10051,_9933).

ap(_9850,_9851,_9852,_9853,[ap,_9919,_9943,_9987,_10011],_9896,_9898) --> 
    mthe10(_9919,_9896,_9934),
    adj1s(_9850,_9851,_9852,_9865,_9943,_9934,_9966),
    redundant0(_9987,_9966,_10002),
    someevent00(_9852,_9865,_9853,_10011,_10002,_9898).

ap(_9850,_9851,_9852,_9853,[ap,_9942,{},{},_9991],_9919,_9921) --> 
    w(verb(_9850,past,part),_9942,_9919,_9959),
    {user:(\+testmember(_9850,[be,have]))},
    {user:adj_template(nil,be/_9850,_9851,_9852,_9865)},
    someevent00(_9852,_9865,_9853,_9991,_9959,_9921).

mthe10([mthe10,lit(mye)],_9867,_9869) --> 
    cc(mye,_9867,_9869).

mthe10([mthe10,_9876],_9865,_9867) --> 
    the0(_9876,_9865,_9867).

passive(_9850,_9851,_9852,[passive,_9986,_10015,_10049,{},_10103,!,_10142],_9966,_9968) --> 
    w(noun(_9889,sin,u,n),_9986,_9966,_10003),
    gmem(_9889,[video,camera],_10015,_10003,_10034),
    lexv(tv,_9909,_9910,part,_10049,_10034,_10072),
    {user:(\+testmember(_9909,[be2,have]))},
    whodidit(_9924,_9925,_10103,_10072,_10122),
    !,
    pushstack(first,(np(_9924,_9925),w(verb(_9909,_9910,fin)),npgap(_9850),w(prep(by)),w(noun(_9889,sin,u,n))),nil,_10122,_10213),
    state(_9851,_9852,_10142,_10213,_9968).

passive(_9850,_9851,_9852,[passive,_9963,{},_10017,_10046,!,_10085],_9943,_9945) --> 
    lexv(dtv,_9881,past,part,_9963,_9943,_9986),
    {user:(\+testmember(_9881,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_9904,_9905)),_10017,_9986,_10034),
    whodidit(_9907,_9908,_10046,_10034,_10065),
    !,
    pushstack(first,(np(_9907,_9908),w(verb(_9881,past,fin)),npgap(_9850)),nil,_10065,_10156),
    state(_9851,_9852,_10085,_10156,_9945).

passive(_9850,_9851,_9852,[passive,_9975,{},_10029,_10058,_10092,!,_10131],_9955,_9957) --> 
    lexv(dtv,_9888,_9889,part,_9975,_9955,_9998),
    {user:(\+testmember(_9888,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_9911,_9912)),_10029,_9998,_10046),
    ind_object(_9884,_9885,_10058,_10046,_10077),
    whodidit(_9917,_9918,_10092,_10077,_10111),
    !,
    pushstack(free,(np(_9917,_9918),w(verb(_9888,_9889,fin)),npgap(_9850),noun_phrase1(_9884,_9885)),nil,_10111,_10233),
    state(_9851,_9852,_10131,_10233,_9957).

passive(_9850,_9851,_9854::_9855,[passive,_9953,lit(om),_10008,!,_10047],_9933,_9935) --> 
    lexv(tv,notify,past,part,_9953,_9933,_9976),
    cc(om,_9976,_10007),
    whodidit(_9890,_9891,_10008,_10007,_10027),
    !,
    lock(last,_10027,_10125),
    pushstack(last,(xnp(_9890,_9891),w(verb(notify,pres,fin)),w(prep(regarding)),npgap(_9850)),nil,_10125,_10131),
    state(_9851,_9854::_9855,_10047,_10131,_10120),
    unlock(_10120,_9935).

passive(_9850,_9851,_9852,[passive,_9966,!,_10010,{},_10064,!,_10103],_9946,_9948) --> 
    adverbial1(_9884,_9885,_9886,_9966,_9946,_9987),
    !,
    lexv(tv,_9893,_9894,part,_10010,_9987,_10033),
    {user:(\+testmember(_9893,[be2,have]))},
    whodidit(_9908,_9909,_10064,_10033,_10083),
    !,
    pushstack(first,(np(_9908,_9909),w(verb(_9893,_9894,fin)),npgap(_9850),adverbial1(_9884,_9885,_9886)),nil,_10083,_10206),
    state(_9851,_9852,_10103,_10206,_9948).

passive(_9850,_9851,_9852,[passive,_9958,{},_10012,_10046,_10070,!,_10109],_9938,_9940) --> 
    lexv(tv,_9884,_9885,part,_9958,_9938,_9981),
    {user:(\+testmember(_9884,[be2,have]))},
    particlev0(_9884,_9900,_10012,_9981,_10031),
    redundant0(_10046,_10031,_10061),
    whodidit(_9902,_9903,_10070,_10061,_10089),
    !,
    pushstack(first,(np(_9902,_9903),w(verb(_9900,_9885,fin)),npgap(_9850)),nil,_10089,_10180),
    state(_9851,_9852,_10109,_10180,_9940).

passive(_9850,_9851,_9852,[passive,_9997,{},_10051,lit(og),_10086,{},!,_10150,!,_10189],_9977,_9979) --> 
    lexv(tv,_9899,past,part,_9997,_9977,_10020),
    {user:(\+testmember(_9899,[be2,have]))},
    redundant0(_10051,_10020,_10066),
    cc(og,_10066,_10085),
    hlexv(tv,_9917,past,part,id,_10086,_10085,_10111),
    {user:(\+testmember(_9899,[be2,have]))},
    !,
    whodidit(_9933,_9934,_10150,_10111,_10169),
    !,
    pushstack(first,(np(_9933,_9934),w(verb(_9899,past,fin)),[og],w(verb(_9917,past,fin)),npgap(_9850)),nil,_10169,_10260),
    state(_9851,_9852,_10189,_10260,_9979).

whodidit(_9850,_9851,[whodidit,lit(av),lit(at),_9930,!,_9969],_9891,_9893) --> 
    cc(av,_9891,_9918),
    cc(at,_9918,_9929),
    clausal_object1(_9850,_9851,_9930,_9929,_9949),
    !,
    accept(_9969,_9949,_9893).

whodidit(_9850,_9851,[whodidit,_9898,!,_9927],_9881,_9883) --> 
    by(_9898,_9881,_9913),
    !,
    np(_9850,_9851,_9927,_9913,_9883).

whodidit(_9850,_9851,[whodidit,_9908,!,_9969],_9891,_9893) --> 
    lock(exact,_9891,_9928),pushstack(exact,w(noun(agent,sin,u,n)),nil,_9928,_9934),np1(_9850,_9851,_9908,_9934,_9923),unlock(_9923,_9924),
    !,
    accept(_9969,_9924,_9893).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9958,lit(det),lit('å'),_10024,_10067,!,_10106],_9935,_9937) --> 
    lexv(tv,_9883,_9884,fin,_9958,_9935,_9981),
    cc(det,_9981,_10012),
    cc('å',_10012,_10023),
    pushstack(first,[noen],nil,_10023,_10037),clausal_object1(_9896,_9880,_10024,_10037,_10052),
    traceprint(4,qv0a,_10067,_10052,_10086),
    !,
    pushstack(first,(lexv(tv,_9883,_9884,fin),xnp(_9850,_9880)),nil,_10086,_10180),
    verb_phrase(_9896,_9851,_9852,_9853,_10106,_10180,_9937).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_10013,{},{},_10077,_10111,_10140,_10169,{},_10213,_10242,_10266,!,_10305],_9990,_9992) --> 
    lexv(tv,_9909,_9910,fin,_10013,_9990,_10036),
    {user:_9909\==ask},
    {user:_9909\==have},
    subject(_9923,_9924,_10077,_10036,_10096),
    negation0(_9851,_10111,_10096,_10128),
    not_look_ahead([om],_10140,_10128,_10157),
    object(_9932,_9933,_10169,_10157,_10188),
    {user:subject_object_test(_9909,_9923,_9932)},
    w(prep(_9943),_10213,_10188,_10230),
    not_look_ahead_np(_10242,_10230,_10257),
    traceprint(4,qv0b,_10266,_10257,_10285),
    !,
    pushstack(first,(xnp(_9923,_9924),w(verb(_9909,pres,fin)),xnp(_9932,_9933),w(prep(_9943)),npgap(_9850)),nil,_10285,_10407),
    state(_9852,_9853,_10305,_10407,_9992).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9993,{},_10047,_10081,_10110,_10139,_10163,!,_10202,{},_10236],_9970,_9972) --> 
    lexv(iv,_9900,_9901,fin,_9993,_9970,_10016),
    {user:(\+testmember(_9900,[think]))},
    subject(_9913,_9914,_10047,_10016,_10066),
    negation0(_9851,_10081,_10066,_10098),
    w(prep(_9920),_10110,_10098,_10127),
    not_look_ahead_np(_10139,_10127,_10154),
    traceprint(4,qv1,_10163,_10154,_10182),
    !,
    accept(_10202,_10182,_10217),
    {user:adjustprepv(_9900,_9920,_9929)},
    pushstack(first,(xnp(_9913,_9914),w(verb(_9900,_9901,fin)),w(prep(_9929)),npgap(_9850)),nil,_10217,_10307),
    state(_9852,_9853,_10236,_10307,_9972).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9973,_10017,_10051,_10075,[],_10149,!,_10188],_9950,_9952) --> 
    lexv(rv,_9892,pres,fin,_9973,_9950,_9996),
    subject(_9896,_9897,_10017,_9996,_10036),
    infinitive(_10051,_10036,_10066),
    w(verb(do,inf,fin),_10075,_10066,_10092),
    pushstack(free,xnp(_9850,_9897),nil,_10092,_10148),[],
    traceprint(4,qv2,_10149,_10148,_10168),
    !,
    pushstack(first,(w(verb(_9892,pres,fin)),['å'],w(verb(do,inf,fin))),nil,_10168,_10198),
    verb_phrase(_9896,_9851,_9852,_9853,_10188,_10198,_9952).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9972,_10016,_10050,_10084,_10108,!,[],_10192],_9949,_9951) --> 
    lexv(dtv,_9891,_9892,fin,_9972,_9949,_9995),
    subject(_9895,_9896,_10016,_9995,_10035),
    ind_object(_9898,_9899,_10050,_10035,_10069),
    omaa(_10084,_10069,_10099),
    traceprint(4,qv3,_10108,_10099,_10127),
    !,
    pushstack(free,xnp(_9850,_9896),nil,_10127,_10191),[],
    pushstack(first,(w(verb(_9891,_9892,fin)),xnp(_9898,_9899),[om],['å']),nil,_10191,_10233),
    verb_phrase(_9895,_9851,_9852,_9853,_10192,_10233,_9951).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9974,{},{},_10038,_10072,{},_10116,!,_10155],_9951,_9953) --> 
    lexv(tv,_9889,_9890,fin,_9974,_9951,_9997),
    {user:_9889\==ask},
    {user:_9889\==have},
    subject(_9903,_9886,_10038,_9997,_10057),
    particlev0(_9889,_9907,_10072,_10057,_10091),
    {user:subject_object_test(_9889,_9903,_9850)},
    traceprint(4,qv4,_10116,_10091,_10135),
    !,
    pushstack(first,(lexv(tv,_9907,_9890,fin),xnp(_9850,_9886)),nil,_10135,_10229),
    verb_phrase(_9903,_9851,_9852,_9853,_10155,_10229,_9953).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9988,_10012,_10041,_10075,_10119,{},{},_10168,!,_10207,{}],_9965,_9967) --> 
    aux1(_9988,_9965,_10003),
    negation0(_9887,_10012,_10003,_10029),
    subject(_9893,_9894,_10041,_10029,_10060),
    lexv(tv,_9897,inf,fin,_10075,_10060,_10098),
    not_look_ahead([om],_10119,_10098,_10136),
    {user:_9897\==have},
    {user:test(tv_template(_9897,_9893,_9850,_9852,_9918))},
    traceprint(4,qv5,_10168,_10136,_10187),
    !,
    pushstack(first,(lexv(tv,_9897,pres,fin),xnp(_9850,_9894)),nil,_10187,_10282),verb_phrase(_9893,_9888,_9852,_9853,_10207,_10282,_9967),
    {user:bigno(_9887,_9888,_9851)}.

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9978,_10002,_10036,_10065,_10094,_10123,!,_10162],_9955,_9957) --> 
    aux1(_9978,_9955,_9993),
    subject(_9891,_9889,_10002,_9993,_10021),
    w(verb(be,inf,fin),_10036,_10021,_10053),
    w(adj2(_9902,_9903),_10065,_10053,_10082),
    w(prep(_9907),_10094,_10082,_10111),
    traceprint(4,qv6,_10123,_10111,_10142),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_9902,_9903)),w(prep(_9907)),xnp(_9850,_9889)),nil,_10142,_10203),
    verb_phrase(_9891,_9851,_9852,_9853,_10162,_10203,_9957).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9957,lit(du),_9992,_10021,_10050,!,_10089],_9934,_9936) --> 
    has(_9957,_9934,_9972),
    cc(du,_9972,_9991),
    negation0(_9851,_9992,_9991,_10009),
    prepnom(_9887,_10021,_10009,_10038),
    traceprint(4,qv7,_10050,_10038,_10069),
    !,
    pushstack(first,([du],w(verb(have,pres,fin)),npgap(_9850),w(prep(_9887))),nil,_10069,_10129),
    state(_9852,_9853,_10089,_10129,_9936).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9978,_10002,_10036,_10065,_10094,!,_10133],_9955,_9957) --> 
    has(_9978,_9955,_9993),
    np1_accept(_9891,_9888::_9889,_10002,_9993,_10021),
    w(noun(_9899,_9900,_9901,n),_10036,_10021,_10053),
    prepnom(_9904,_10065,_10053,_10082),
    traceprint(4,qv8,_10094,_10082,_10113),
    !,
    pushstack(free,(w(verb(have,pres,fin)),w(noun(_9899,sin,u,n)),w(prep(_9904)),noun_phrase1(_9850,_9888::_9889)),nil,_10113,_10177),
    do_phrase(have,_9891,_9851,_9852,_9853,_10133,_10177,_9957).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9978,_10002,_10036,_10065,{},_10104,_10143,!,_10182],_9955,_9957) --> 
    has(_9978,_9955,_9993),
    subject(_9893,_9894,_10002,_9993,_10021),
    negation0(_9851,_10036,_10021,_10053),
    w(verb(_9900,_9901,part),_10065,_10053,_10082),
    {user:testmember(_9900,[go])},
    defaultprep(_9900,_9850,_9913,_10104,_10082,_10125),
    traceprint(4,qv9,_10143,_10125,_10162),
    !,
    pushstack(first,(xnp(_9893,_9894),w(verb(_9900,_9901,fin)),prep1(_9913),npgap(_9850)),nil,_10162,_10284),
    state(_9852,_9853,_10182,_10284,_9957).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9956,_9980,_10014,_10043,_10072,!,_10111],_9933,_9935) --> 
    has(_9956,_9933,_9971),
    subject(_9884,_9885,_9980,_9971,_9999),
    negation0(_9851,_10014,_9999,_10031),
    w(verb(_9891,past,part),_10043,_10031,_10060),
    traceprint(4,qv10,_10072,_10060,_10091),
    !,
    pushstack(first,(xnp(_9884,_9885),w(verb(_9891,past,fin)),npgap(_9850)),nil,_10091,_10182),
    state(_9852,_9853,_10111,_10182,_9935).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9953,_9977,_10011,_10040,_10069,!,_10108],_9930,_9932) --> 
    has(_9953,_9930,_9968),
    np1_accept(_9885,_9886,_9977,_9968,_9996),
    negation0(_9851,_10011,_9996,_10028),
    w(verb(_9881,_9882,part),_10040,_10028,_10057),
    traceprint(4,qv11,_10069,_10057,_10088),
    !,
    pushstack(first,(xnp(_9885,_9886),w(verb(_9881,_9882,fin))),nil,_10088,_10149),
    verb_phrase(_9850,id,_9852,_9853,_10108,_10149,_9932).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,lit(kan),_9970,_10004,_10038,_10067,!,_10106],_9936,_9938) --> 
    cc(kan,_9936,_9969),
    subject(_9884,_9880,_9970,_9969,_9989),
    negation2(id,_9851,_10004,_9989,_10023),
    not_look_ahead(w(verb(_9894,_9895,_9896)),_10038,_10023,_10055),
    traceprint(4,qv12,_10067,_10055,_10086),
    !,
    lock(last,_10086,_10154),
    pushstack(last,(w(verb(know1,pres,fin)),xnp(_9850,_9880)),nil,_10154,_10160),
    do_phrase(_9901,_9884,id,_9852,_9853,_10106,_10160,_10149),
    unlock(_10149,_9938).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9975,_10004,_10038,_10072,_10101,_10130,!,_10169],_9952,_9954) --> 
    w(verb(_9889,_9890,fin),_9975,_9952,_9992),
    gmem(_9889,[talk,speak],_10004,_9992,_10023),
    subject(_9900,_9901,_10038,_10023,_10057),
    negation0(_9851,_10072,_10057,_10089),
    look_ahead(w(prep(_9909)),_10101,_10089,_10118),
    traceprint(4,qv13a,_10130,_10118,_10149),
    !,
    lock(last,_10149,_10247),
    pushstack(last,(xnp(_9850,_9901),w(verb(_9889,_9890,fin)),negation(_9851)),nil,_10247,_10253),
    do_phrase(_9914,_9900,id,_9852,_9853,_10169,_10253,_10242),
    unlock(_10242,_9954).

qverb_phrase(_9850,id,_9852,_9853,[qverb_phrase,_9951,_9975,_10009,_10038,!,_10077],_9928,_9930) --> 
    aux1(_9951,_9928,_9966),
    subject(_9881,_9882,_9975,_9966,_9994),
    w(verb(be,_9887,fin),_10009,_9994,_10026),
    traceprint(4,qv15c,_10038,_10026,_10057),
    !,
    pushstack(first,(xnp(_9881,_9882),w(verb(be,pres,fin)),npgap(_9850)),nil,_10057,_10148),
    state(_9852,_9853,_10077,_10148,_9930).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9937,_9961,_9995,_10029,!,_10068],_9914,_9916) --> 
    docan(_9937,_9914,_9952),
    subject(_9876,_9874,_9961,_9952,_9980),
    negation2(id,_9851,_9995,_9980,_10014),
    traceprint(4,qv13b,_10029,_10014,_10048),
    !,
    lock(last,_10048,_10116),
    pushstack(last,xnp(_9850,_9874),nil,_10116,_10122),
    do_phrase(_9885,_9876,id,_9852,_9853,_10068,_10122,_10111),
    unlock(_10111,_9916).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,{},_9981,_10005,_10039,lit(av),_10079,!,_10118],_9948,_9950) --> 
    {user:constrain(_9850,place)},
    aux1(_9981,_9948,_9996),
    np1_accept(_9895,_9898::_9899,_10005,_9996,_10024),
    negation0(_9851,_10039,_10024,_10056),
    cc(av,_10056,_10078),
    traceprint(4,qv14,_10079,_10078,_10098),
    !,
    pushstack(first,(noun_phrase1(_9895,_9898::_9899),w(verb(go,pres,fin)),[av],npgap(_9850)),nil,_10098,_10192),
    state(_9852,_9853,_10118,_10192,_9950).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9986,_10015,_10039,_10073,_10102,_10131,_10160,!,_10199],_9963,_9965) --> 
    w(verb(be,pres,_9900),_9986,_9963,_10003),
    thereit0(_10015,_10003,_10030),
    np1_accept(_9902,_9905::_9906,_10039,_10030,_10058),
    negation0(_9851,_10073,_10058,_10090),
    w(verb(_9912,_9913,part),_10102,_10090,_10119),
    prep(_9916,_10131,_10119,_10148),
    traceprint(4,qv15,_10160,_10148,_10179),
    !,
    pushstack(first,(someone,w(verb(_9912,_9913,fin)),noun_phrase1(_9902,_9905::_9906),w(prep(_9916)),npgap(_9850)),nil,_10179,_10301),
    state(_9852,_9853,_10199,_10301,_9965).

qverb_phrase(_9850,id,_9852,_9853,[qverb_phrase,_9978,_10007,_10041,_10070,_10099,!,_10138],_9955,_9957) --> 
    w(verb(be,_9893,fin),_9978,_9955,_9995),
    subject(_9896,_9897,_10007,_9995,_10026),
    w(adj2(_9901,nil),_10041,_10026,_10058),
    w(prep(_9906),_10070,_10058,_10087),
    traceprint(4,qv15a,_10099,_10087,_10118),
    !,
    pushstack(first,(xnp(_9896,_9897),w(verb(be,pres,fin)),w(adj2(_9901,nil)),w(prep(_9906)),npgap(_9850)),nil,_10118,_10209),
    state(_9852,_9853,_10138,_10209,_9957).

qverb_phrase(_9850,id,_9852,_9853,[qverb_phrase,_9948,_9977,_10011,!,_10050],_9925,_9927) --> 
    w(verb(be,_9881,fin),_9948,_9925,_9965),
    subject(_9884,_9885,_9977,_9965,_9996),
    traceprint(4,qv15b,_10011,_9996,_10030),
    !,
    pushstack(first,(xnp(_9884,_9885),w(verb(be,pres,fin)),npgap(_9850)),nil,_10030,_10121),
    state(_9852,_9853,_10050,_10121,_9927).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9977,_10006,_10030,_10064,_10093,_10122,{},_10156,!,_10195],_9954,_9956) --> 
    w(verb(be,_9899,fin),_9977,_9954,_9994),
    thereit0(_10006,_9994,_10021),
    np1_accept(_9902,_9903,_10030,_10021,_10049),
    negation0(_9851,_10064,_10049,_10081),
    prep(_9907,_10093,_10081,_10110),
    not_look_ahead_np(_10122,_10110,_10137),
    {user:_9907\==towards},
    traceprint(4,qv16,_10156,_10137,_10175),
    !,
    pushstack(first,(xnp(_9902,_9903),w(verb(be1,pres,fin)),prep(_9907),npgap(_9850)),nil,_10175,_10296),
    state(_9852,_9853,_10195,_10296,_9956).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_10040,{},_10094,_10128,_10157,_10191,_10220,_10244,!,{},{},_10303],_10017,_10019) --> 
    lexv(tv,_9906,_9907,fin,_10040,_10017,_10063),
    {user:(\+testmember(_9906,[pass,be1,be,be2,cost,have,know1]))},
    np1_accept(_9931,_9934::_9935,_10094,_10063,_10113),
    negation0(_9851,_10128,_10113,_10145),
    np1_accept(_9850,_9942::_9943,_10157,_10145,_10176),
    prep1(_9945,_10191,_10176,_10208),
    endofline(_10220,_10208,_10235),
    traceprint(4,qv17,_10244,_10235,_10263),
    !,
    {user:(\+testmember(_9945,[off,of]))},
    {user:test(verb_compl(_9906,_9945,_9931,_9850,_9969,_9970))},
    pushstack(first,(noun_phrase1(_9931,_9934::_9935),lexv(tv,_9906,_9907,fin),noun_phrase1(_9850,_9942::_9943),prep1(_9945),npgap(_9850)),nil,_10263,_10474),
    state(_9852,_9853,_10303,_10474,_10019).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_10048,_10077,_10106,{},{},_10170,_10194,_10228,_10257,{},{},_10316,_10340,!,_10379],_10025,_10027) --> 
    not_look_ahead([kan],_10048,_10025,_10065),
    not_look_ahead(w(verb(be,_9920,_9921)),_10077,_10065,_10094),
    lexv(_9923,_9924,_9925,fin,_10106,_10094,_10129),
    {user:(_9923==iv;_9923==rv)},
    {user:(\+testmember(_9924,[pass]))},
    thereit0(_10170,_10129,_10185),
    np1_accept(_9948,_9951::_9952,_10194,_10185,_10213),
    negation0(_9851,_10228,_10213,_10245),
    defaultprep(_9924,_9850,_9958,_10257,_10245,_10278),
    {user:(\+testmember(_9958,[off,of]))},
    {user:test(verb_compl(_9924,_9958,_9948,_9850,_9979,_9980))},
    qtrailer0(_10316,_10278,_10331),
    traceprint(4,qv18,_10340,_10331,_10359),
    !,
    pushstack(first,(noun_phrase1(_9948,_9951::_9952),w(verb(_9924,_9925,fin)),prep1(_9958),npgap(_9850)),nil,_10359,_10483),
    state(_9852,_9853,_10379,_10483,_10027).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,{},_10012,{},_10051,_10080,_10114,_10143,_10182,!,_10221],_9979,_9981) --> 
    {user:constrain(_9850,place)},
    w(verb(_9903,_9904,fin),_10012,_9979,_10029),
    {user:(\+testmember(_9903,[be,take,pass]))},
    not_look_ahead([det],_10051,_10029,_10068),
    np1_accept(_9924,_9927::_9928,_10080,_10068,_10099),
    negation0(_9851,_10114,_10099,_10131),
    defaultprep(_9903,_9850,_9934,_10143,_10131,_10164),
    traceprint(4,qv19,_10182,_10164,_10201),
    !,
    pushstack(first,(noun_phrase1(_9924,_9927:_9928),w(verb(_9903,pres,fin)),prep1(_9934),npgap(_9850)),nil,_10201,_10322),
    state(_9852,_9853,_10221,_10322,_9981).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_10002,{},_10056,_10090,{},_10129,{},_10168,!,_10207],_9979,_9981) --> 
    lexv(iv,_9897,_9898,fin,_10002,_9979,_10025),
    {user:_9897\==be1},
    np1_accept(_9906,_9909::_9910,_10056,_10025,_10075),
    negation0(_9851,_10090,_10075,_10107),
    {user:constrain(_9906,vehicle)},
    prep1(_9919,_10129,_10107,_10146),
    {user:testmember(_9919,[to,from,past,by,on])},
    traceprint(4,qv20,_10168,_10146,_10187),
    !,
    pushstack(first,(noun_phrase1(_9906,_9909::_9910),w(verb(_9897,pres,fin)),prep1(_9919),npgap(_9850)),nil,_10187,_10311),
    state(_9852,_9853,_10207,_10311,_9981).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9952,_9976,_10010,_10054,!,_10093],_9929,_9931) --> 
    doit(_9952,_9929,_9967),
    noun_phrase1(_9882,_9879::_9880,_9976,_9967,_9995),
    lexv(_9888,know1,_9890,fin,_10010,_9995,_10033),
    traceprint(4,qv21,_10054,_10033,_10073),
    !,
    pushstack(first,(lexv(_9888,know1,_9890,fin),np(_9850,_9879::_9880)),nil,_10073,_10168),
    verb_phrase(_9882,_9851,_9852,_9853,_10093,_10168,_9931).

qverb_phrase(_9850,_9851,_9852,_9855::_9856,[qverb_phrase,_9946,_9970,_10004,_10028,!,_10067],_9923,_9925) --> 
    use(_9946,_9923,_9961),
    noun_phrase1(_9881,_9884::_9856,_9970,_9961,_9989),
    in_order_to(_10004,_9989,_10019),
    traceprint(4,qv22,_10028,_10019,_10047),
    !,
    pushstack(free,(prep(with),npgap(_9850)),nil,_10047,_10137),
    verb_phrase(_9881,_9851,_9852,_9855::_9884,_10067,_10137,_9925).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9945,_9969,_9998,_10027,!,_10066],_9922,_9924) --> 
    be(_9945,_9922,_9960),
    thereit2(be,_9969,_9960,_9986),
    not_look_ahead(w(noun(_9885,_9886,u,_9888)),_9998,_9986,_10015),
    traceprint(4,qv23,_10027,_10015,_10046),
    !,
    pushstack(first,w(verb(exist,pres,fin)),nil,_10046,_10076),
    verb_phrase1(exist,_9850,_9851,_9852,_9853,_10066,_10076,_9924).

qverb_phrase(_9850,id,_9852,_9853,[qverb_phrase,{},_9983,{},_10037,{},_10081,!,_10120],_9950,_9952) --> 
    {user:constrain(_9850,route)},
    lexv(iv,_9893,_9894,fin,_9983,_9950,_10006),
    {user:testmember(_9893,[go])},
    subject(_9904,_9905,_10037,_10006,_10056),
    {user:constrain(_9904,vehicle)},
    traceprint(4,qv24,_10081,_10056,_10100),
    !,
    lock(last,_10100,_10198),
    pushstack(last,(xnp(_9904,_9905),w(verb(_9893,_9894,fin)),npgap(_9850)),nil,_10198,_10204),
    state(_9852,_9853,_10120,_10204,_10193),
    unlock(_10193,_9952).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9961,_10005,{},_10049,_10078,!,_10117],_9938,_9940) --> 
    lexv(tv,_9883,_9884,fin,_9961,_9938,_9984),
    subject(_9887,_9880,_10005,_9984,_10024),
    {user:subject_object_test(_9883,_9887,_9850)},
    not_look_ahead(w(prep(_9900)),_10049,_10024,_10066),
    traceprint(4,qv25,_10078,_10066,_10097),
    !,
    pushstack(first,(lexv(tv,_9883,_9884,fin),xnp(_9850,_9880)),nil,_10097,_10191),
    verb_phrase(_9887,_9851,_9852,_9853,_10117,_10191,_9940).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9926,_9955,!,_9994],_9903,_9905) --> 
    look_ahead(w(verb(be,_9874,fin)),_9926,_9903,_9943),
    traceprint(4,qv26,_9955,_9943,_9974),
    !,
    verb_phrase(_9850,_9851,_9852,_9853,_9994,_9974,_9905).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9945,{},_9984,_10013,!,_10052],_9922,_9924) --> 
    not_look_ahead(w(verb(be,_9880,fin)),_9945,_9922,_9962),
    {user:vartypeid(_9850,thing)},
    look_ahead(w(verb(_9892,_9893,fin)),_9984,_9962,_10001),
    traceprint(4,qv27,_10013,_10001,_10032),
    !,
    verb_phrase(_9850,_9851,_9852,_9853,_10052,_10032,_9924).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9956,lit(du),_9996,_10020,_10054,lit(kan),_10099,!,_10138],_9933,_9935) --> 
    w(verb(believe,pres,fin),_9956,_9933,_9973),
    cc(du,_9973,_9995),
    that0(_9996,_9995,_10011),
    noun_phrase1(_9893,_9883,_10020,_10011,_10039),
    negation2(id,_9851,_10054,_10039,_10073),
    cc(kan,_10073,_10098),
    traceprint(4,qv28,_10099,_10098,_10118),
    !,
    pushstack(free,xnp(_9850,_9883),nil,_10118,_10179),
    do_phrase(believe,_9893,id,_9852,_9853,_10138,_10179,_9935).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9940,_9964,_9998,_10032,_10056,!,_10095],_9917,_9919) --> 
    doit(_9940,_9917,_9955),
    noun_phrase1(_9879,_9877,_9964,_9955,_9983),
    negation2(id,_9851,_9998,_9983,_10017),
    redundant0x(_10032,_10017,_10047),
    traceprint(4,qv29,_10056,_10047,_10075),
    !,
    lock(last,_10075,_10143),
    pushstack(last,xnp(_9850,_9877),nil,_10143,_10149),
    do_phrase(_9888,_9879,id,_9852,_9853,_10095,_10149,_10138),
    unlock(_10138,_9919).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9975,{},_10029,_10053,_10087,_10111,_10140,!,_10179],_9952,_9954) --> 
    lexv(iv,_9892,_9893,fin,_9975,_9952,_9998),
    {user:(\+testmember(_9892,[know,know1,be1]))},
    thereit(_10029,_9998,_10044),
    noun_phrase1(_9909,_9889,_10053,_10044,_10072),
    adverbx0(_10087,_10072,_10102),
    prep0(_9912,_10111,_10102,_10128),
    traceprint(4,qv30,_10140,_10128,_10159),
    !,
    pushstack(first,(lexv(iv,_9892,_9893,fin),prep(_9912),xnp(_9850,_9889)),nil,_10159,_10283),
    verb_phrase(_9909,_9851,_9852,_9853,_10179,_10283,_9954).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9963,_9987,_10021,_10065,_10089,_10133,!,_10172],_9940,_9942) --> 
    has(_9963,_9940,_9978),
    np1_accept(_9888,_9885::_9886,_9987,_9978,_10006),
    lexv(rv,_9895,past,part,_10021,_10006,_10044),
    infinitive(_10065,_10044,_10080),
    lexv(tv,_9900,inf,fin,_10089,_10080,_10112),
    traceprint(4,qv31,_10133,_10112,_10152),
    !,
    pushstack(first,(lexv(tv,_9900,pres,fin),np(_9850,_9885::_9886)),nil,_10152,_10249),
    verb_phrase(_9888,_9851,_9852,_9853,_10172,_10249,_9942).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9952,_9976,_10010,_10054,!,_10093],_9929,_9931) --> 
    has(_9952,_9929,_9967),
    np1_accept(_9882,_9879::_9880,_9976,_9967,_9995),
    lexv(tv,_9889,past,part,_10010,_9995,_10033),
    traceprint(4,qv32,_10054,_10033,_10073),
    !,
    pushstack(first,(lexv(tv,_9889,past,fin),np(_9850,_9879::_9880)),nil,_10073,_10168),
    verb_phrase(_9882,_9851,_9852,_9853,_10093,_10168,_9931).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9949,_9973,{},_10017,!,_10056],_9926,_9928) --> 
    has(_9949,_9926,_9964),
    np1_accept(_9879,_9877,_9973,_9964,_9992),
    {user:has_template(_9879,_9850,_9886)},
    traceprint(4,qv33,_10017,_9992,_10036),
    !,
    pushstack(free,(w(verb(have,pres,fin)),noun_phrase1(_9850,_9877)),nil,_10036,_10097),
    do_phrase(have,_9879,_9851,_9852,_9853,_10056,_10097,_9928).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9980,_10004,_10038,_10082,_10116,_10145,!,_10184],_9957,_9959) --> 
    has(_9980,_9957,_9995),
    np1_accept(_9894,_9891::_9892,_10004,_9995,_10023),
    lexv(tv,_9901,past,part,_10038,_10023,_10061),
    noun_phrase1(_9905,_9908::_9909,_10082,_10061,_10101),
    prep(_9911,_10116,_10101,_10133),
    traceprint(4,qv34,_10145,_10133,_10164),
    !,
    pushstack(first,(lexv(tv,_9901,past,fin),np(_9905,_9908::_9909),prep(_9911),np(_9850,_9891::_9892)),nil,_10164,_10325),
    verb_phrase(_9894,_9851,_9852,_9853,_10184,_10325,_9959).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9936,{},_9975,!,_10014],_9913,_9915) --> 
    not_look_ahead(w(verb(be,_9877,fin)),_9936,_9913,_9953),
    {user:(\+vartypeid(_9850,thing))},
    traceprint(4,qv35,_9975,_9953,_9994),
    !,
    verb_phrase(_9850,_9851,_9852,_9853,_10014,_9994,_9915).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,{},_9956,_9985,_10009,!,_10048],_9923,_9925) --> 
    {user:(\+vartypeid(_9850,thing))},
    w(verb(_9875,_9876,fin),_9956,_9923,_9973),
    thereit0(_9985,_9973,_10000),
    traceprint(4,qv36,_10009,_10000,_10028),
    !,
    pushstack(first,w(verb(_9875,_9876,fin)),nil,_10028,_10058),
    verb_phrase(_9850,_9851,_9852,_9853,_10048,_10058,_9925).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9949,_9993,_10017,_10104,!,_10143],_9926,_9928) --> 
    lexv(_9879,_9880,_9881,fin,_9949,_9926,_9972),
    thereit(_9993,_9972,_10008),
    lock(exact,_10008,_10068),pushstack(exact,this,nil,_10068,_10074),npa(_9887,_9877,_10017,_10074,_10063),unlock(_10063,_10064),
    traceprint(4,qv37,_10104,_10064,_10123),
    !,
    pushstack(first,(lexv(_9879,_9880,_9881,fin),xnp(_9850,_9877)),nil,_10123,_10217),
    verb_phrase(_9887,_9851,_9852,_9853,_10143,_10217,_9928).

qverb_phrase(_9850,_9851,_9852,_9853,[qverb_phrase,_9998,{},_10052,_10086,_10115,_10154,!,_10193,_10217,_10256],_9975,_9977) --> 
    lexv(iv,_9900,_9901,fin,_9998,_9975,_10021),
    {user:(\+testmember(_9900,[think]))},
    np1_accept(_9913,_9914,_10052,_10021,_10071),
    negation0(_9851,_10086,_10071,_10103),
    adverbial1(_9918,_9919,_9922::_9923,_10115,_10103,_10136),
    traceprint(4,qv38,_10154,_10136,_10173),
    !,
    accept(_10193,_10173,_10208),
    defaultprep(_9900,_9850,_9930,_10217,_10208,_10238),
    pushstack(first,(xnp(_9913,_9914),lexv(iv,_9900,_9901,fin),adverbial1(_9918,_9919,_9922::_9923),prep1(_9930),npgap(_9850)),nil,_10238,_10425),
    state(_9852,_9853,_10256,_10425,_9977).

verb_modifiers0(_9850,_9851,_9852,_9853,_9854,[verb_modifiers0,lit(hva),!,_9931],_9889,_9891) --> 
    cc(hva,_9889,_9925),
    !,
    reject(_9931,_9925,_9891).

verb_modifiers0(_9850,_9851,_9852,_9853,_9854,[verb_modifiers0,_9913],_9887,_9889) --> 
    verb_modifiers(_9850,_9851,_9852,_9853,_9854,_9913,_9887,_9889).

verb_modifiers0(_9850,_9851,_9852,_9853,_9854,[verb_modifiers0,_9919,!,_9948],_9893,_9895) --> 
    redundant(_9919,_9893,_9934),
    !,
    verb_modifiers(_9850,_9851,_9852,_9853,_9854,_9948,_9934,_9895).

verb_modifiers0(_9850,_9851,_9852,_9853,_9853,[verb_modifiers0,{}],_9888,_9888) --> 
    {user:(\+_9850=be1)}.

verb_modifiers(_9850,_9851,_9852,_9853,_9854,[verb_modifiers,_9928,!,_9982,_10006],_9902,_9904) --> 
    verb_modifier(_9850,_9851,_9852,_9853,_9868,_9928,_9902,_9953),
    !,
    accept(_9982,_9953,_9997),
    verb_modifiers10(_9850,_9851,_9852,_9868,_9854,_10006,_9997,_9904).

verb_modifiers10(_9850,_9851,_9852,_9853,_9854,[verb_modifiers10,_9919,_9943,_9967],_9893,_9895) --> 
    vmod_conjunction(_9919,_9893,_9934),
    look_ahead_prepadv(_9943,_9934,_9958),
    verb_modifiers(_9850,_9851,_9852,_9853,_9854,_9967,_9958,_9895).

verb_modifiers10(go,_9851,_9852,_9853,_9854,[verb_modifiers10,_9939,_9963,!,_9997,_10021],_9913,_9915) --> 
    numberroute(_9939,_9913,_9954),
    look_ahead(w(nb(_9879,num)),_9963,_9954,_9980),
    !,
    accept(_9997,_9980,_10012),
    pushstack(first,w(prep(with)),nil,_10012,_10031),
    verb_modifiers(go,_9851,_9852,_9853,_9854,_10021,_10031,_9915).

verb_modifiers10(_9850,_9851,_9852,_9853,_9854,[verb_modifiers10,_9927,_9951,_9980],_9901,_9903) --> 
    point(_9927,_9901,_9942),
    look_ahead(w(name(_9872,_9873,_9874)),_9951,_9942,_9968),
    verb_modifiers0(_9850,_9851,_9852,_9853,_9854,_9980,_9968,_9903).

verb_modifiers10(_9850,_9851,_9852,_9853,_9854,[verb_modifiers10,_9913],_9887,_9889) --> 
    verb_modifiers0(_9850,_9851,_9852,_9853,_9854,_9913,_9887,_9889).

verb_modifiers10(_9850,_9851,_9852,_9853,_9853,[verb_modifiers10,[]],_9881,_9881) --> 
    [].

look_ahead_prepadv([look_ahead_prepadv,_9885,!],_9874,_9876) --> 
    look_ahead(w(prep(_9857)),_9885,_9874,_9876),
    !.

look_ahead_prepadv([look_ahead_prepadv,_9885,!],_9874,_9876) --> 
    look_ahead(w(adv(_9857)),_9885,_9874,_9876),
    !.

verb_modifier(_9850,_9851,_9852,_9862 and _9856::_9857,_9856::_9857,[verb_modifier,_9962,_9991,{},{}],_9936,_9938) --> 
    thisplace(_9885,_9962,_9936,_9979),
    not_look_ahead([jegdu],_9991,_9979,_9938),
    {user:verb_compl(_9850,_9885,_9851,_9900:place,_9852,_9883)},
    {user:_9862=(findexternal(_9900:place)::_9900 isa place and _9883)}.

verb_modifier(_9850,_9851,_9852,_9862 and _9856::_9860,_9856::_9857,[verb_modifier,_9925],_9899,_9901) --> 
    verb_mod1(_9850,_9851,_9852,_9862,_9860::_9857,_9925,_9899,_9901).

verb_modifier(_9850,_9851,_9852,_9862 and _9856::_9857,_9856::_9857,[verb_modifier,_9931,!,{}],_9905,_9907) --> 
    today(_9931,_9905,_9907),
    !,
    {user:adv_compl(_9850,today,_9851,time,_9852,_9862)}.

verb_modifier(_9850,_9851,_9852,_9853,_9853,[verb_modifier,_9915,!,_9949],_9889,_9891) --> 
    particlev1(_9850,_9915,_9889,_9932),
    !,
    accept(_9949,_9932,_9891).

verb_modifier(_9850,_9851,_9852,_9853,_9853,[verb_modifier,{},_9929],_9893,_9895) --> 
    {user:testmember(_9850,[want])},
    reflexiv(_9850,_9929,_9893,_9895).

verb_modifier(_9850,_9851,_9852,_9862 and _9856::_9860,_9856::_9857,[verb_modifier,{},_9960,_10004,{}],_9924,_9926) --> 
    {user:_9850\==be1},
    lexv(iv,_9889,pres,part,_9960,_9924,_9983),
    verb_modifier3(_9889,_9851,_9879,_9860,_9857,_10004,_9983,_9926),
    {user:verb_compl(_9850,during,_9851,_9879,_9852,_9862)}.

verb_modifier(_9850,_9851,_9852,_9856 and _9863::_9860,_9856::_9857,[verb_modifier,_9946,_9970,{}],_9920,_9922) --> 
    this(_9946,_9920,_9961),
    pushstack(first,(prep(in),this),nil,_9961,_10041),adverbial(_9874,_9876,_9860::_9857,_9970,_10041,_9922),
    {user:verb_compl(_9850,_9874,_9851,_9876,_9852,_9863)}.

verb_modifier(_9850,_9851,_9852,_9862 and _9856::_9857,_9856::_9857,[verb_modifier,_9932,{}],_9906,_9908) --> 
    partday(_9871,_9873,_9879,_9932,_9906,_9908),
    {user:adv_compl(_9850,_9871,_9851,_9873,_9852,_9862)}.

verb_modifier(_9850,_9851,_9852,_9862 and _9856::_9860,_9856::_9857,[verb_modifier,_9946,_9975,{},!,_10029],_9920,_9922) --> 
    nil_compl(_9850,_9946,_9920,_9963),
    adjunct1(nil,_9880,_9860::_9857,_9975,_9963,_9996),
    {user:verb_compl(_9850,nil,_9851,_9880,_9852,_9862)},
    !,
    accept(_10029,_9996,_9922).

verb_modifier(_9850,_9851,_9852,_9862 and _9856::_9860,_9856::_9857,[verb_modifier,_9946,_9975,{},!,_10029],_9920,_9922) --> 
    dir_compl(_9850,_9946,_9920,_9963),
    adjunct1(dir,_9880,_9860::_9857,_9975,_9963,_9996),
    {user:verb_compl(_9850,dir,_9851,_9880,_9852,_9862)},
    !,
    accept(_10029,_9996,_9922).

verb_modifier(adj/nil/_9860,_9851,_9852,_9868 and _9856::_9866,_9856::_9857,[verb_modifier,_9959,_9983,_10032,{}],_9933,_9935) --> 
    infinitive(_9959,_9933,_9974),
    subordinateinfnosubj(nil,coevent,_9851,_9885,_9893,_9983,_9974,_10008),
    determiner00(_9885,_9866,_9893::_9857,_10032,_10008,_9935),
    {user:verb_compl(adj/nil/_9860,in_order_to,_9851,_9885,_9852,_9868)}.

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,_9963,_9997,{},_10036,!,_10075,{}],_9937,_9939) --> 
    gmem(_9850,[be1,go,arrive,depart],_9963,_9937,_9982),
    w(prep(_9877),_9997,_9982,_10014),
    {user:testmember(_9877,[before,after,between])},
    plausibleclock(_9879,_9854,_10036,_10014,_10055),
    !,
    accept(_10075,_10055,_9939),
    {user:verb_compl(_9850,_9877,_9851,_9879,_9852,_9853)}.

verb_mod1(look,_9851,_9852,_9853,_9856::_9857,[verb_mod1,_9952,lit(ut),!,_9997,{}],_9926,_9928) --> 
    w(adj2(_9882,_9883),_9952,_9926,_9969),
    cc(ut,_9969,_9991),
    !,
    lock(exact,_9991,_10017),pushstack(exact,w(adv(_9882)),nil,_10017,_10023),adverbix(_9874,_9876,_9856::_9857,_9997,_10023,_10012),unlock(_10012,_9928),
    {user:verb_compl(look,_9874,_9851,_9876,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,_9954,_9988,{},!,_10032,{}],_9928,_9930) --> 
    gmem(_9850,[be1],_9954,_9928,_9973),
    w(prep(_9874),_9988,_9973,_10005),
    {user:(\+member(_9874,[between,for]))},
    !,
    np1_accept(_9876,_9854,_10032,_10005,_9930),
    {user:verb_compl(_9850,_9874,_9851,_9876,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,lit(som),_9948,!,_9982,{}],_9911,_9913) --> 
    cc(som,_9911,_9947),
    w(prep(in),_9948,_9947,_9965),
    !,
    np1_accept(_9873,_9854,_9982,_9965,_9913),
    {user:verb_compl(_9850,as_in,_9851,_9873,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,lit(som),!,_9946,{}],_9904,_9906) --> 
    cc(som,_9904,_9940),
    !,
    np1_accept(_9870,_9854,_9946,_9940,_9906),
    {user:verb_compl(_9850,as,_9851,_9870,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,_9967,_10001,{},_10040,!,_10074,{}],_9941,_9943) --> 
    gmem(_9850,[exist],_9967,_9941,_9986),
    one_of_lit([til,'før'],_10001,_9986,_10018),
    {user:(vartypeid(_9851,_9899),subclass0(_9899,duration))},
    not_look_ahead(w(name(_9909,n,place)),_10040,_10018,_10057),
    !,
    clausal_object0(_9879,_9854,_10074,_10057,_9943),
    {user:verb_compl(_9850,until,_9851,_9879,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,{},lit(_9889),{},{},!,_10010,{}],_9938,_9940) --> 
    {user:testmember(_9850,[exist])},
    cc(_9889,_9938,_9984),
    {user:testmember(_9889,[siden])},
    {user:(vartypeid(_9851,_9904),subclass0(_9904,duration))},
    !,
    clausal_object0(_9879,_9854,_10010,_9984,_9940),
    {user:verb_compl(_9850,since,_9851,_9879,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,{},lit(med),lit(at),!,_9982,{}],_9919,_9921) --> 
    {user:testmember(_9850,[mean])},
    cc(med,_9919,_9965),
    cc(at,_9965,_9976),
    !,
    clausal_object1(_9876,_9854,_9982,_9976,_9921),
    {user:verb_compl(_9850,with,_9851,_9876,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},_9979,_10008,!,_10042,{}],_9943,_9945) --> 
    {user:testmember(_9850,[ask])},
    not_look_ahead(['nå'],_9979,_9943,_9996),
    look_ahead(w(verb(_9898,inf,fin)),_10008,_9996,_10025),
    !,
    pushstack(first,(npgap(_9851),[vil]),nil,_10025,_10085),clausal_object1(_9879,_9856::_9857,_10042,_10085,_9945),
    {user:verb_compl(_9850,regarding,_9851,_9879,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,{},lit(om),_9970,!,_10004,{}],_9923,_9925) --> 
    {user:testmember(_9850,[notify,take])},
    cc(om,_9923,_9969),
    not_look_ahead([en],_9970,_9969,_9987),
    !,
    clausal_object0(_9876,_9854,_10004,_9987,_9925),
    {user:verb_compl(_9850,regarding,_9851,_9876,_9852,_9853)}.

verb_mod1(adj/nil/_9857,_9851,_9852,_9853,_9854,[verb_mod1,{},_9975,!,_10009,{}],_9939,_9941) --> 
    {user:testmember(_9857,[delayed])},
    w(nb(_9892,num),_9975,_9939,_9992),
    !,
    pushstack(first,(w(prep(with)),w(nb(_9892,num))),nil,_9992,_10022),pp(with,_9879,_9854,_10009,_10022,_9941),
    {user:adj_compl(_9857,with,_9851,_9879,_9852,_9853)}.

'utenå'(['utenå',lit(uten),_9898,_9922,!],_9876,_9878) --> 
    cc(uten,_9876,_9897),
    'ogå'(_9898,_9897,_9913),
    'måtte'(_9922,_9913,_9878),
    !.

'utenå'(['utenå',lit(uten),_9892],_9870,_9872) --> 
    cc(uten,_9870,_9891),
    'ogå'(_9892,_9891,_9872).

'måtte'(['måtte',_9888],_9877,_9879) --> 
    one_of_lit(['måtte',ville,skulle,burde,kunne],_9888,_9877,_9879).

verb_mod1(adj/nil/_9857,_9851,_9852,_9853,_9854,[verb_mod1,{},_9956,!,_9985,{}],_9920,_9922) --> 
    {user:testmember(_9857,[afraid,happy])},
    foratx0(_9956,_9920,_9971),
    !,
    clausal_object1(_9879,_9854,_9985,_9971,_9922),
    {user:adj_compl(_9857,because_of,_9851,_9879,_9852,_9853)}.

foratx0([foratx0,lit(for),lit(at)],_9872,_9874) --> 
    cc(for,_9872,_9893),
    cc(at,_9893,_9874).

foratx0([foratx0,lit(at)],_9867,_9869) --> 
    cc(at,_9867,_9869).

foratx0([foratx0,_9892],_9881,_9883) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_9892,_9881,_9883).

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,{},_9950,_9974,{},!],_9914,_9916) --> 
    {user:testmember(_9850,[label,be_named])},
    look_ahead_np(_9950,_9914,_9965),
    np0_accept(_9877,_9854,_9974,_9965,_9916),
    {user:verb_compl(_9850,with,_9851,_9877,_9852,_9853)},
    !.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},lit(enn),lit('å'),!,_9999,{}],_9936,_9938) --> 
    {user:(\+testmember(_9850,[be,be1,be2]))},
    cc(enn,_9936,_9982),
    cc('å',_9982,_9993),
    !,
    pushstack(first,[noen],nil,_9993,_10012),clausal_object1(_9879,_9856::_9857,_9999,_10012,_9938),
    {user:verb_compl(_9850,than,_9851,_9879,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},lit(enn),lit(at),!,_9994,{}],_9931,_9933) --> 
    {user:(\+testmember(_9850,[be,be1,be2]))},
    cc(enn,_9931,_9977),
    cc(at,_9977,_9988),
    !,
    clausal_object1(_9879,_9856::_9857,_9994,_9988,_9933),
    {user:verb_compl(_9850,than,_9851,_9879,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},lit(enn),_9970,{}],_9923,_9925) --> 
    {user:(\+testmember(_9850,[be,be1,be2]))},
    cc(enn,_9923,_9969),
    np1(_9873,_9856::_9857,_9970,_9969,_9925),
    {user:verb_compl(_9850,than,_9851,_9873,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,{},_9966,{},!,_10010,{}],_9930,_9932) --> 
    {user:testmember(_9850,[notify,wait])},
    w(prep(_9874),_9966,_9930,_9983),
    {user:(\+testmember(_9874,[for]))},
    !,
    clausal_object0(_9876,_9854,_10010,_9983,_9932),
    {user:verb_compl(_9850,_9874,_9851,_9876,_9852,_9853)}.

verb_mod1(adj/nil/_9860,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},_9990,lit('å'),!,_10050,{}],_9954,_9956) --> 
    {user:testmember(_9860,[nice,good,bad,interested,interesting])},
    optional(w(prep(_9908)),_9990,_9954,_10022),
    cc('å',_10022,_10044),
    !,
    pushstack(first,npgap(_9851),nil,_10044,_10093),clausal_object1(_9885,_9856::_9857,_10050,_10093,_9956),
    {user:verb_compl(adj/nil/_9860,because_of,_9851,_9885,_9852,_9853)}.

overat([overat,lit(fordi)],_9867,_9869) --> 
    cc(fordi,_9867,_9869).

overat([overat,lit(av),lit(at)],_9872,_9874) --> 
    cc(av,_9872,_9893),
    cc(at,_9893,_9874).

overat([overat,lit(over),lit(at)],_9872,_9874) --> 
    cc(over,_9872,_9893),
    cc(at,_9893,_9874).

overat([overat,lit(til),lit(at)],_9872,_9874) --> 
    cc(til,_9872,_9893),
    cc(at,_9893,_9874).

verb_mod1(adj/nil/_9857,_9851,_9852,_9853,_9854,[verb_mod1,{},lit(av),lit(hvilken),!,_9994,{}],_9931,_9933) --> 
    {user:(\+testmember(_9857,[]))},
    cc(av,_9931,_9977),
    cc(hvilken,_9977,_9988),
    !,
    np1(_9882,_9854,_9994,_9988,_9933),
    {user:verb_compl(adj/nil/_9857,of,_9851,_9882,_9852,_9853)}.

verb_mod1(adj/nil/_9860,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},_9971,!,_10000,{}],_9935,_9937) --> 
    {user:(\+testmember(_9860,[]))},
    overaa(_9971,_9935,_9986),
    !,
    pushstack(first,npgap(_9851),nil,_9986,_10043),clausal_object1(_9882,_9856::_9857,_10000,_10043,_9937),
    {user:verb_compl(adj/nil/_9860,because_of,_9851,_9882,_9852,_9853)}.

overaa([overaa,lit(av),lit('å')],_9872,_9874) --> 
    cc(av,_9872,_9893),
    cc('å',_9893,_9874).

overaa([overaa,lit(over),lit('å')],_9872,_9874) --> 
    cc(over,_9872,_9893),
    cc('å',_9893,_9874).

overaa([overaa,lit(til),lit('å')],_9872,_9874) --> 
    cc(til,_9872,_9893),
    cc('å',_9893,_9874).

verb_mod1(_9850,_9851,_9852,_9853,_9854,[verb_mod1,{},_9958,lit('å'),!,_9998,{}],_9922,_9924) --> 
    {user:(\+testmember(_9850,[]))},
    instead_of(_9958,_9922,_9973),
    cc('å',_9973,_9992),
    !,
    pushstack(first,npgap(_9851),nil,_9992,_10041),clausal_object1(_9876,_9854,_9998,_10041,_9924),
    {user:verb_compl(_9850,instead_of,_9851,_9876,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9856,[verb_mod1,_9952,_9981,{},_10030,{}],_9926,_9928) --> 
    gradverb0(_9880,_9952,_9926,_9969),
    adverb(_9874,_9876,_9884,_9981,_9969,_10002),
    {user:testmember(_9874,[slowly,fast,thereafter])},
    not_look_ahead([det],_10030,_10002,_9928),
    {user:adv_compl(_9850,_9874,_9851,_9876,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},lit(om),lit('å'),!,_9993,{}],_9930,_9932) --> 
    {user:testmember(_9850,[ask])},
    cc(om,_9930,_9976),
    cc('å',_9976,_9987),
    !,
    pushstack(first,npgap(_9851),nil,_9987,_10036),clausal_object1(_9879,_9856::_9857,_9993,_10036,_9932),
    {user:verb_compl(_9850,regarding,_9851,_9879,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},_9977,_10021,lit('å'),!,_10081,{}],_9941,_9943) --> 
    {user:testmember(_9850,[extend,help])},
    optional([til],_9977,_9941,_10009),
    optional([med],_10021,_10009,_10053),
    cc('å',_10053,_10075),
    !,
    pushstack(first,npgap(_9851),nil,_10075,_10124),clausal_object1(_9882,_9856::_9857,_10081,_10124,_9943),
    {user:verb_compl(_9850,with,_9851,_9882,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,_9932,!,{}],_9906,_9908) --> 
    xadverbial1(_9868,_9870,_9856::_9857,_9932,_9906,_9908),
    !,
    {user:verb_compl(_9850,_9868,_9851,_9870,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},_9964,!,_9998,_10022,{}],_9928,_9930) --> 
    {user:testmember(_9850,[talk,speak])},
    look_ahead([om],_9964,_9928,_9981),
    !,
    accept(_9998,_9981,_10013),
    adverbial1(regarding,_9879,_9856::_9857,_10022,_10013,_9930),
    {user:verb_compl(_9850,regarding,_9851,_9879,_9852,_9853)}.

verb_mod1(adj/_9863/_9860,_9851,_9852,_9853,_9856::_9857,[verb_mod1,_9935,{}],_9909,_9911) --> 
    adverbial4(_9871,_9873,_9856::_9857,_9935,_9909,_9911),
    {user:adj_compl(_9860,_9871,_9851,_9873,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},_9957,{}],_9921,_9923) --> 
    {user:(\+testmember(_9850,[know,know1,speak,hope]))},
    adverbial3(_9868,_9870,_9856::_9857,_9957,_9921,_9923),
    {user:verb_compl(_9850,_9868,_9851,_9870,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},_9972,!,_10006,_10030,{}],_9936,_9938) --> 
    {user:testmember(_9850,[know,know1,ask,tell,speak,think])},
    look_ahead([om],_9972,_9936,_9989),
    !,
    accept(_10006,_9989,_10021),
    adverbial1(regarding,_9879,_9856::_9857,_10030,_10021,_9938),
    {user:verb_compl(_9850,regarding,_9851,_9879,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,srel/_9869/time/_9863/_9852,_9856::_9856,[verb_mod1,_9976,{},_10015,{},{},!,_10069],_9950,_9952) --> 
    w(prep(_9869),_9976,_9950,_9993),
    {user:testmember(_9869,[to,until])},
    w(adv(_9863),_10015,_9993,_10032),
    {user:testmember(_9863,[tomorrow])},
    {user:verb_compl(_9850,_9869,_9851,_9922:time,_9852,_9920)},
    !,
    accept(_10069,_10032,_9952).

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9856,[verb_mod1,_9925,{}],_9899,_9901) --> 
    xadverb(_9865,_9867,_9925,_9899,_9901),
    {user:adv_compl(_9850,_9865,_9851,_9867,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,_9929,{}],_9903,_9905) --> 
    adverbix(_9865,_9867,_9856::_9857,_9929,_9903,_9905),
    {user:verb_compl(_9850,_9865,_9851,_9867,_9852,_9853)}.

verb_mod1(_9850,_9851,_9852,_9853,_9856::_9857,[verb_mod1,{},_10000,_10029,{},{},!,_10093],_9964,_9966) --> 
    {user:(\+testmember(_9850,[go]))},
    nil_compl(_9850,_10000,_9964,_10017),
    adjunct1(nil,_9889,_9856::_9857,_10029,_10017,_10050),
    {user:(constrain(_9889,time);constrain(_9889,departure);constrain(_9889,arrival);constrain(_9889,route);constrain(_9889,number);constrain(_9889,bus))},
    {user:verb_compl(_9850,nil,_9851,_9889,_9852,_9853)},
    !,
    accept(_10093,_10050,_9966).

dir_compl(_9850,[dir_compl,{},!,_9911],_9882,_9884) --> 
    {user:v_compl(_9850,_9861,dir,_9863)},
    !,
    accept(_9911,_9882,_9884).

nil_compl(_9850,[nil_compl,_9898,_9932,!],_9884,_9886) --> 
    gmem(_9850,[have],_9898,_9884,_9917),
    look_ahead_lit([hver],_9932,_9917,_9886),
    !.

nil_compl(be/_9853,[nil_compl,{},!,_9914],_9885,_9887) --> 
    {user:a_compl(_9853,_9864,nil,_9866)},
    !,
    accept(_9914,_9885,_9887).

nil_compl(adj/nil/_9853,[nil_compl,{},!],_9885,_9885) --> 
    {user:(\+testmember(_9853,[]))},
    !.

nil_compl(adj/nil/_9853,[nil_compl,{},!,_9916],_9887,_9889) --> 
    {user:(\+post_adjective(_9853))},
    !,
    reject(_9916,_9887,_9889).

nil_compl(go,[nil_compl,_10105,{},_10144,_10173,_10202,_10231,_10260,_10289,_10318,_10347,_10376,_10405,_10434,_10463,_10492,_10521,_10550,_10579,_10608,_10637,_10666,_10695,_10724,!,_10758],_10091,_10093) --> 
    w(nb(_9926,num),_10105,_10091,_10122),
    {user:_9926<100},
    not_look_ahead(w(noun(time_count,plu,u,n)),_10144,_10122,_10161),
    not_look_ahead(w(nb(_9947,num)),_10173,_10161,_10190),
    not_look_ahead([:],_10202,_10190,_10219),
    not_look_ahead([?],_10231,_10219,_10248),
    not_look_ahead(['.'],_10260,_10248,_10277),
    not_look_ahead([/],_10289,_10277,_10306),
    not_look_ahead([den],_10318,_10306,_10335),
    not_look_ahead(w(name(_9974,_9975,month)),_10347,_10335,_10364),
    not_look_ahead(w(name(new_years_day,_9983,date)),_10376,_10364,_10393),
    not_look_ahead(w(name(whitsun_day,_9991,date)),_10405,_10393,_10422),
    not_look_ahead(w(name(christmas_day,_9999,date)),_10434,_10422,_10451),
    not_look_ahead(w(name(easterday,_10007,date)),_10463,_10451,_10480),
    not_look_ahead(w(prep(_10014)),_10492,_10480,_10509),
    not_look_ahead(w(prep(over)),_10521,_10509,_10538),
    not_look_ahead(w(prep(on)),_10550,_10538,_10567),
    not_look_ahead(w(prep(in)),_10579,_10567,_10596),
    not_look_ahead(w(noun(day,_10039,_10040,_10041)),_10608,_10596,_10625),
    not_look_ahead(w(noun(hour,_10048,_10049,_10050)),_10637,_10625,_10654),
    not_look_ahead(w(noun(minute,_10057,_10058,_10059)),_10666,_10654,_10683),
    not_look_ahead(w(noun(second,_10066,_10067,_10068)),_10695,_10683,_10712),
    not_look_ahead([om],_10724,_10712,_10741),
    !,
    reject(_10758,_10741,_10093).

nil_compl(_9850,[nil_compl,{},{},{},_9953,!,_9982],_9909,_9911) --> 
    {user:(\+abnormalverb(_9850,_9872))},
    {user:(\+testmember(_9850,[have,be_named]))},
    {user:v_compl(_9850,_9888,nil,_9890)},
    hver0(_9953,_9909,_9968),
    !,
    accept(_9982,_9968,_9911).

verb_modifier3(_9850,_9851,_9852,_9853,_9854,[verb_modifier3,_9947,_10078],_9921,_9923) --> 
    pushstack(free,(npgap(_9851),lexv(iv,_9850,pres,fin),prep(in),w(noun(time,sin,u,n))),nil,_9921,_10053),statreal(_9863,_9947,_10053,_10066),
    determiner00(_9852,_9853,_9863::_9854,_10078,_10066,_9923).

adverbix0(_9850,_9851,_9852,[adverbix0,_9902,!],_9882,_9884) --> 
    adverbix(_9850,_9851,_9852,_9902,_9882,_9884),
    !.

adverbix0(redundantly,nil:thing,_9854::_9854,[adverbix0,[]],_9881,_9881) --> 
    [].

adverbix(_9850,nil:_9858,_9854::_9854,[adverbix,_9914,{}],_9894,_9896) --> 
    w(adv(_9850),_9914,_9894,_9896),
    {user:particle(_9850,_9858,_9867)}.

adverbix(redundantly,nil:thing,_9854::_9854,[adverbix,_9908,!],_9888,_9890) --> 
    w(adv(redundantly),_9908,_9888,_9890),
    !.

adverbix(_9850,_9851,_9854::_9855,[adverbix,_9905],_9885,_9887) --> 
    adverbial1(_9850,_9851,_9854::_9855,_9905,_9885,_9887).

adverbix(_9850,nil:_9858,_9854::_9854,[adverbix,_9910,_9939],_9890,_9892) --> 
    gradverbs0(_9867,_9910,_9890,_9927),
    adverbx(_9850,_9858,_9865,_9939,_9927,_9892).

adverbix(nil,_9851,_9852,[adverbix,_9918,_9947,_9981],_9898,_9900) --> 
    look_ahead(w(noun(_9867,sin,u,n)),_9918,_9898,_9935),
    gmem(_9867,[midnight],_9947,_9935,_9966),
    complement_nil(_9851,_9852,_9981,_9966,_9900).

adverbix(nil,_9851,_9852,[adverbix,lit(den),_9924,_9953],_9893,_9895) --> 
    cc(den,_9893,_9923),
    look_ahead(w(nb(_9869,_9870)),_9924,_9923,_9941),
    complement_nil(_9851,_9852,_9953,_9941,_9895).

adverbial(_9850,_9851,_9854::_9855,[adverbial,_9905],_9885,_9887) --> 
    adverbial3(_9850,_9851,_9854::_9855,_9905,_9885,_9887).

adverbial(_9850,_9851,_9854::_9855,[adverbial,_9905],_9885,_9887) --> 
    adverbial1(_9850,_9851,_9854::_9855,_9905,_9885,_9887).

preadverbial0(_9850,_9851,_9852,[preadverbial0,_9902,!],_9882,_9884) --> 
    adverbial1(_9850,_9851,_9852,_9902,_9882,_9884),
    !.

preadverbial0(redundantly,nil:thing,_9854::_9854,[preadverbial0,[]],_9881,_9881) --> 
    [].

preadverbial1(_9850,_9851,_9852,[preadverbial1,_9941,_9970,_9999,{},_10038,!],_9921,_9923) --> 
    w(nb(_9871,num),_9941,_9921,_9958),
    w(noun(minute,_9877,_9878,_9879),_9970,_9958,_9987),
    look_ahead(w(prep(_9885)),_9999,_9987,_10016),
    {user:testmember(_9885,[before,after])},
    adverbial1(_9850,_9851,_9852,_10038,_10016,_9923),
    !.

preadverbial1(_9850,_9851,_9852,[preadverbial1,_9909,_9938,_9962],_9889,_9891) --> 
    not_look_ahead([e],_9909,_9889,_9926),
    not_look_ahead_np(_9938,_9926,_9953),
    adverbix(_9850,_9851,_9852,_9962,_9953,_9891).

preadverbial1(nil,_9851,_9852,[preadverbial1,_9923,!,_9957,_9981],_9903,_9905) --> 
    w(adj2(early,nil),_9923,_9903,_9940),
    !,
    accept(_9957,_9940,_9972),
    pushstack(first,w(noun(morning,sin,u,n)),nil,_9972,_9991),
    adjunct1(nil,_9851,_9852,_9981,_9991,_9905).

preadverbial1(before,1200:clock,_9854::_9854 and 1200 isa clock,[preadverbial1,_9914],_9894,_9896) --> 
    w(noun(morning,sin,u,n),_9914,_9894,_9896).

preadverbial1(before,1200:clock,_9854::_9854 and 1200 isa clock,[preadverbial1,_9914],_9894,_9896) --> 
    w(noun(prenoon,sin,u,n),_9914,_9894,_9896).

preadverbial1(after,1200:clock,_9854::_9854 and 1200 isa clock,[preadverbial1,_9914],_9894,_9896) --> 
    w(noun(afternoon,sin,u,n),_9914,_9894,_9896).

preadverbial1(after,1800:clock,_9854::_9854 and 1800 isa clock,[preadverbial1,_9914],_9894,_9896) --> 
    w(noun(night,sin,u,n),_9914,_9894,_9896).

preadverbial1(nil,_9851,_9852,[preadverbial1,_9904,!,_9943],_9884,_9886) --> 
    obviousclock1(_9851,_9852,_9904,_9884,_9923),
    !,
    accept(_9943,_9923,_9886).

preadverbial1(nil,_9851,_9852,[preadverbial1,_9904,!,_9943],_9884,_9886) --> 
    obviousdate1(_9851,_9852,_9904,_9884,_9923),
    !,
    accept(_9943,_9923,_9886).

preadverbials([preadverbials,_9882,!,_9911],_9871,_9873) --> 
    redundant(_9882,_9871,_9897),
    !,
    preadverbials(_9911,_9897,_9873).

preadverbials([preadverbials,_9899,!,[],_9989,_10013],_9888,_9890) --> 
    adverbix(_9862,_9863,_9864,_9899,_9888,_9920),
    !,
    pushstack(free,xadverbial1(_9862,_9863,_9864),nil,_9920,_9988),[],
    adverbial_conjunction0(_9989,_9988,_10004),
    preadverbials0(_10013,_10004,_9890).

preadverbials0([preadverbials0,_9879,!],_9868,_9870) --> 
    preadverbials(_9879,_9868,_9870),
    !.

preadverbials0([preadverbials0,[]],_9865,_9865) --> 
    [].

adverbial_conjunction0([adverbial_conjunction0,_9879,!],_9868,_9870) --> 
    adverbial_conjunction(_9879,_9868,_9870),
    !.

adverbial_conjunction0([adverbial_conjunction0,[]],_9865,_9865) --> 
    [].

adverbial_conjunction([adverbial_conjunction,lit(og),_9901,!],_9879,_9881) --> 
    cc(og,_9879,_9900),
    look_ahead(w(prep(_9862)),_9901,_9900,_9881),
    !.

adverbial1(_9850,_9851,_9852,[adverbial1,lit(slik),!,_9945],_9909,_9911) --> 
    cc(slik,_9909,_9939),
    !,
    pushstack(first,(w(prep(in)),w(noun(way,sin,def,n)),[som]),nil,_9939,_9955),
    adjunct1(_9850,_9851,_9852,_9945,_9955,_9911).

adverbial1(_9850,_9851,_9852,[adverbial1,lit(dit),_9955,!,_9994],_9924,_9926) --> 
    cc(dit,_9924,_9954),
    lit_of(_9874,[jeg,du],_9955,_9954,_9974),
    !,
    pushstack(first,(w(prep(to)),w(noun(place,sin,def,n)),[som],[_9874]),nil,_9974,_10004),
    adjunct1(_9850,_9851,_9852,_9994,_10004,_9926).

adverbial1(ago,_9851,_9852,[adverbial1,_9941,_9970,_9999,lit(siden),!,_10044],_9921,_9923) --> 
    prep1(for,_9941,_9921,_9958),
    anumber(_9884,_9970,_9958,_9987),
    w(noun(_9877,_9889,u,n),_9999,_9987,_10016),
    cc(siden,_10016,_10038),
    !,
    lock(exact,_10038,_10091),
    pushstack(exact,(number(_9884),w(noun(_9877,plu,u,n))),nil,_10091,_10097),
    np1(_9851,_9852,_10044,_10097,_10086),
    unlock(_10086,_9923).

adverbial1(in,_9863:day,_9854::exists(_9863:morrow)::_9863 isa morrow and _9854,[adverbial1,_9921,!,_9950],_9901,_9903) --> 
    tomorrow(_9921,_9901,_9936),
    !,
    accept(_9950,_9936,_9903).

adverbial1(_9850,_9851,_9852,[adverbial1,_9899],_9879,_9881) --> 
    adjunct1(_9850,_9851,_9852,_9899,_9879,_9881).

adverbial1(in,_9863:_9864,_9854::exists(_9863:_9864)::_9863 isa _9864 and _9854,[adverbial1,_9950,{},!,_9994],_9930,_9932) --> 
    w(noun(_9864,_9886,_9887,n),_9950,_9930,_9967),
    {user:testmember(_9864,[monday,tuesday,wednesday,thursday,friday,saturday,sunday])},
    !,
    accept(_9994,_9967,_9932).

adverbial3(_9850,_9857:_9858,_9854::_9855,[adverbial3,_9953,_9992,[],_10071,_10137],_9933,_9935) --> 
    xsubjunction(_9850,_9858,_9881,_9953,_9933,_9974),
    adverbial_object00(_9857:_9858,_9884,_9992,_9974,_10011),
    pushstack(free,adverbial1(_9881,_9857:_9858,_9884),nil,_10011,_10070),[],
    pushstack(first,([jeg],aux1),nil,_10070,_10112),substatement1(_9876,_10071,_10112,_10125),
    determiner00(_9857:_9858,_9854,_9876::_9855,_10137,_10125,_9935).

adverbial3(_9850,_9851,_9852,[adverbial3,lit('før'),_9917,!,_9946],_9886,_9888) --> 
    cc('før',_9886,_9916),
    look_ahead_time(_9917,_9916,_9932),
    !,
    reject(_9946,_9932,_9888).

adverbial3(_9850,_9851,_9854::_9855,[adverbial3,lit(til),_9952,_9981,!,_10015,_10063],_9921,_9923) --> 
    cc(til,_9921,_9951),
    not_look_ahead([j],_9952,_9951,_9969),
    look_ahead([jeg],_9981,_9969,_9998),
    !,
    pushstack(first,w(prep(to)),nil,_9998,_10028),subordinate(_9850,_9851,_9876,_10015,_10028,_10045),
    determiner00(_9851,_9854,_9876::_9855,_10063,_10045,_9923).

adverbial3(_9850,_9851,_9854::_9855,[adverbial3,_9919,_9948,_9987],_9899,_9901) --> 
    not_look_ahead([til],_9919,_9899,_9936),
    subordinate(_9850,_9851,_9867,_9948,_9936,_9969),
    determiner00(_9851,_9854,_9867::_9855,_9987,_9969,_9901).

adverbial4(_9850,_9851,_9854::_9854 and _9858,[adverbial4,_9928,_9957,_9986,{}],_9908,_9910) --> 
    not_look_ahead([om],_9928,_9908,_9945),
    prep(_9872,_9957,_9945,_9974),
    clausal_object0(_9851,true::_9858,_9986,_9974,_9910),
    {user:adjustprep(_9851,_9872,_9850)}.

adverbial4(_9850,_9851,_9854::_9854 and _9858,[adverbial4,_9933,_9962,lit(at),_10002,{}],_9913,_9915) --> 
    not_look_ahead([om],_9933,_9913,_9950),
    prep(_9875,_9962,_9950,_9979),
    cc(at,_9979,_10001),
    clausal_object1(_9851,true::_9858,_10002,_10001,_9915),
    {user:adjustprep(_9851,_9875,_9850)}.

subordinate(nil,_9854:coevent,_9852,[subordinate,lit(de),lit(samme),lit(som),_9981,_10015],_9928,_9930) --> 
    cc(de,_9928,_9958),
    cc(samme,_9958,_9969),
    cc(som,_9969,_9980),
    adverbial_object00(_9854:coevent,_9880,_9981,_9980,_10000),
    lock(last,_10000,_10063),
    pushstack(last,([de],w(verb(be,pres,fin)),adverbial1(nil,_9854:coevent,_9880)),nil,_10063,_10069),
    substatement1(_9852,_10015,_10069,_10058),
    unlock(_10058,_9930).

subordinate(_9850,_9851,_9852,[subordinate,_9924,{},_9963,!,_9997],_9904,_9906) --> 
    w(prep(_9868),_9924,_9904,_9941),
    {user:testmember(_9868,[instead_of])},
    not_look_ahead_lit([at,'å'],_9963,_9941,_9980),
    !,
    reject(_9997,_9980,_9906).

subordinate(_9850,_9851,_9852,[subordinate,_9932,_9961,_9990,{},!,_10034],_9912,_9914) --> 
    not_look_ahead([siden],_9932,_9912,_9949),
    w(prep(_9875),_9961,_9949,_9978),
    look_ahead(w(noun(_9881,_9882,_9883,_9884)),_9990,_9978,_10007),
    {user:subclass0(_9881,time)},
    !,
    reject(_10034,_10007,_9914).

subordinate(_9850,_9851,_9852,[subordinate,_9918,_9957,_9986],_9898,_9900) --> 
    subjunction(_9850,_9861,_9860,_9918,_9898,_9939),
    not_look_ahead(w(verb(_9873,_9874,_9875)),_9957,_9939,_9974),
    subord_clause(_9860,_9861,_9851,_9852,_9986,_9974,_9900).

subord_clause(_9850,_9851,_9855:_9851,_9853,[subord_clause,_9928,!,_9967],_9905,_9907) --> 
    adverbial_object00(_9855:_9851,_9869,_9928,_9905,_9947),
    !,
    lock(last,_9947,_10015),
    pushstack(last,xadverbial1(_9850,_9855:_9851,_9869),nil,_10015,_10021),
    substatement1(_9853,_9967,_10021,_10010),
    unlock(_10010,_9907).

adverbial_object00(_9862:_9863,_9853::exists(_9862:_9863)::_9862 isa _9863 and _9853,[adverbial_object00,[]],_9892,_9892) --> 
    [].

subordinateinfnosubj(_9850,_9851,_9852,_9853,_9854,[subordinateinfnosubj,{},_9954,!,_9998],_9918,_9920) --> 
    {user:it_template(_9852)},
    np00(_9851,_9872,_9875::_9876,_9954,_9918,_9975),
    !,
    pushstack(free,(npgap(_9852),adverbial1(_9850,_9872,_9875::_9876)),nil,_9975,_10073),
    statreal(_9854,_9998,_10073,_9920).

subordinateinfnosubj(_9850,_9851,_9852,_9853,_9854,[subordinateinfnosubj,{},_9989,{},!,_10048,!,_10092],_9953,_9955) --> 
    {user:(\+it_template(_9852))},
    lexv(tv,_9900,_9901,fin,_9989,_9953,_10012),
    {user:testmember(_9900,[take])},
    !,
    np00(_9851,_9887,_9890::_9891,_10048,_10012,_10069),
    !,
    pushstack(free,(someone,w(verb(_9900,pres,fin)),npgap(_9852),adverbial1(_9850,_9887,_9890::_9891)),nil,_10069,_10195),
    statreal(_9854,_10092,_10195,_9955).

subordinateinfnosubj(_9850,_9851,_9852,_9853,_9854,[subordinateinfnosubj,{},_9989,{},!,_10048,!,_10092],_9953,_9955) --> 
    {user:(\+it_template(_9852))},
    lexv(tv,_9900,_9901,fin,_9989,_9953,_10012),
    {user:testmember(_9900,[help])},
    !,
    np00(_9851,_9887,_9890::_9891,_10048,_10012,_10069),
    !,
    pushstack(free,(npgap(_9852),w(verb(_9900,pres,fin)),someone,adverbial1(_9850,_9887,_9890::_9891)),nil,_10069,_10195),
    statreal(_9854,_10092,_10195,_9955).

partday(_9850,_9851,_9852,[partday,_9914,{},!],_9894,_9896) --> 
    w(noun(_9850,_9863,_9864,n),_9914,_9894,_9896),
    {user:particle(_9850,_9851,_9852)},
    !.

partday(tomorrow,_9851,_9852,[partday,_9929,_9953,_9982,_10011,!,{}],_9909,_9911) --> 
    to0(_9929,_9909,_9944),
    prep1(in,_9953,_9944,_9970),
    not_look_ahead([formiddag],_9982,_9970,_9999),
    w(noun(morning,_9884,_9885,n),_10011,_9999,_9911),
    !,
    {user:particle(tomorrow,_9851,_9852)}.

partday(tomorrow,_9851,_9852,[partday,_9922,_9946,_9975,!,{}],_9902,_9904) --> 
    to0(_9922,_9902,_9937),
    prep1(in,_9946,_9937,_9963),
    w(noun(morrow,_9877,_9878,n),_9975,_9963,_9904),
    !,
    {user:particle(tomorrow,_9851,_9852)}.

partday(_9850,_9851,_9852,[partday,_9928,_9957,!,{},{}],_9908,_9910) --> 
    inom(_9872,_9928,_9908,_9945),
    w(noun(_9876,_9877,_9878,n),_9957,_9945,_9910),
    !,
    {user:norpart(_9872,_9876,_9850)},
    {user:particle(_9850,_9851,_9852)}.

adverbx(with,mode,post,[adverbx,lit(med),_9914,!],_9883,_9885) --> 
    cc(med,_9883,_9913),
    not_look_ahead_np(_9914,_9913,_9885),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),_9914,!],_9883,_9885) --> 
    cc(etter,_9883,_9913),
    terminatore(_9914,_9913,_9885),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),lit(det),!],_9885,_9887) --> 
    cc(etter,_9885,_9915),
    cc(det,_9915,_9887),
    !.

adverbx(earlier,time,post,[adverbx,lit('før'),lit(det),!],_9885,_9887) --> 
    cc('før',_9885,_9915),
    cc(det,_9915,_9887),
    !.

adverbx(_9850,_9851,_9852,[adverbx,lit(slik),lit(at),!,_9935],_9888,_9890) --> 
    cc(slik,_9888,_9918),
    cc(at,_9918,_9929),
    !,
    reject(_9935,_9929,_9890).

adverbx(_9850,_9851,_9852,[adverbx,_9914,_9938,!,{}],_9894,_9896) --> 
    not_look_ahead_prepx(_9914,_9894,_9929),
    w(adv(_9850),_9938,_9929,_9896),
    !,
    {user:particle(_9850,_9851,_9852)}.

not_look_ahead_prepx([not_look_ahead_prepx,lit(med),_9895,!],_9873,_9875) --> 
    cc(med,_9873,_9894),
    look_ahead_np(_9895,_9894,_9875),
    !.

not_look_ahead_prepx([not_look_ahead_prepx,_9882],_9871,_9873) --> 
    not_look_ahead(w(prep(_9854)),_9882,_9871,_9873).

adverbx(_9850,_9851,_9852,[adverbx,_9899],_9879,_9881) --> 
    adverb(_9850,_9851,_9852,_9899,_9879,_9881).

adverbx(_9850,_9851,_9852,[adverbx,_9899],_9879,_9881) --> 
    partday(_9850,_9851,_9852,_9899,_9879,_9881).

adverbx(yesterday,_9851,_9852,[adverbx,_9914,lit('går'),!,{}],_9894,_9896) --> 
    prep1(in,_9914,_9894,_9931),
    cc('går',_9931,_9896),
    !,
    {user:particle(yesterday,_9851,_9852)}.

anyadverb0([anyadverb0,_9896,_9920,!,[]],_9885,_9887) --> 
    therenot0(_9896,_9885,_9911),
    adverb(_9862,_9863,_9864,_9920,_9911,_9941),
    !,
    pushstack(free,adverb(_9862,_9863,_9864),nil,_9941,_9887),
    [].

anyadverb0([anyadverb0,_9876],_9865,_9867) --> 
    therenot0(_9876,_9865,_9867).

adverbx0([adverbx0,_9883,!],_9872,_9874) --> 
    w(adv(redundantly),_9883,_9872,_9874),
    !.

adverbx0([adverbx0,_9926,_9955,_9984,{},!,[]],_9915,_9917) --> 
    not_look_ahead(w(noun(_9876,sin,u,n)),_9926,_9915,_9943),
    not_look_ahead(w(prep(_9885)),_9955,_9943,_9972),
    adverb(_9868,_9869,_9870,_9984,_9972,_10005),
    {user:(\+testmember(_9868,[home]))},
    !,
    pushstack(free,adverb(_9868,_9869,_9870),nil,_10005,_9917),
    [].

adverbx0([adverbx0,[]],_9865,_9865) --> 
    [].

adverb0(_9850,_9851,_9852,[adverb0,_9902,!],_9882,_9884) --> 
    adverb(_9850,_9851,_9852,_9902,_9882,_9884),
    !.

adverb0(redundantly,thing,post,[adverb0,[]],_9875,_9875) --> 
    [].

adverb(delayed,time,post,[adverb,_9903,!],_9883,_9885) --> 
    w(adj2(delayed,nil),_9903,_9883,_9885),
    !.

adverb(_9850,_9851,_9852,[adverb,_9921,_9950,_9979,{}],_9901,_9903) --> 
    gradverb0(_9869,_9921,_9901,_9938),
    not_look_ahead([siste],_9950,_9938,_9967),
    w(adj2(_9850,nil),_9979,_9967,_9903),
    {user:particle(_9850,_9851,_9852)}.

adverb(now,_9851,_9852,[adverb,_9909,_9938,{}],_9889,_9891) --> 
    prep1(with,_9909,_9889,_9926),
    detsamme(_9938,_9926,_9891),
    {user:particle(now,_9851,_9852)}.

adverb(first,time,_9852,[adverb,lit('først')],_9877,_9879) --> 
    cc('først',_9877,_9879).

adverb(today,day,pre,[adverb,_9907,_9936],_9887,_9889) --> 
    prep1(in,_9907,_9887,_9924),
    w(noun(day,sin,u,n),_9936,_9924,_9889).

adverb(tomorrow,day,pre,[adverb,_9902,lit(morgen)],_9882,_9884) --> 
    prep1(in,_9902,_9882,_9919),
    cc(morgen,_9919,_9884).

adverb(day_after_tomorrow,day,pre,[adverb,_9902,lit(overimorgen)],_9882,_9884) --> 
    prep1(in,_9902,_9882,_9919),
    cc(overimorgen,_9919,_9884).

adverb(day_before_yesterday,day,pre,[adverb,_9902,lit('forgårs')],_9882,_9884) --> 
    prep1(in,_9902,_9882,_9919),
    cc('forgårs',_9919,_9884).

adverb(tonight,daypart,pre,[adverb,_9907,_9936],_9887,_9889) --> 
    prep1(in,_9907,_9887,_9924),
    w(noun(night,_9860,_9861,_9862),_9936,_9924,_9889).

adverb(today,day,pre,[adverb,_9907,_9936],_9887,_9889) --> 
    prep1(in,_9907,_9887,_9924),
    w(noun(day,_9860,_9861,_9862),_9936,_9924,_9889).

adverb(locally,place,post,[adverb,lit(lokalt)],_9877,_9879) --> 
    cc(lokalt,_9877,_9879).

adverb(_9850,_9851,_9852,[adverb,_9908,_9937,!,_9966],_9888,_9890) --> 
    w(prep(_9865),_9908,_9888,_9925),
    look_ahead_np(_9937,_9925,_9952),
    !,
    reject(_9966,_9952,_9890).

adverb(_9850,_9851,_9852,[adverb,_9906,{}],_9886,_9888) --> 
    particle(_9850,_9906,_9886,_9888),
    {user:particle(_9850,_9851,_9852)}.

adverb(_9850,_9851,_9852,[adverb,_9944,{},_9983,_10012,{},_10051],_9924,_9926) --> 
    particle(_9850,_9944,_9924,_9961),
    {user:testmember(_9850,[on,off])},
    not_look_ahead(w(noun(_9884,_9885,_9886,_9887)),_9983,_9961,_10000),
    not_look_ahead(w(name(_9893,_9894,_9895)),_10012,_10000,_10029),
    {user:particle(_9850,_9851,_9852)},
    da0(_10051,_10029,_9926).

particlev0(_9850,_9851,[particlev0,_9895,!],_9878,_9880) --> 
    particlev2(_9850,_9851,_9895,_9878,_9880),
    !.

particlev0(_9850,_9850,[particlev0,_9891],_9874,_9876) --> 
    particlev1(_9850,_9891,_9874,_9876).

particlev0(_9850,_9850,[particlev0,[]],_9872,_9872) --> 
    [].

particle0(_9850,[particle0,_9888,!],_9874,_9876) --> 
    particle(_9850,_9888,_9874,_9876),
    !.

particle0(_9850,[particle0,[]],_9869,_9869) --> 
    [].

particlev1(believe,[particlev1,lit('på')],_9871,_9873) --> 
    cc('på',_9871,_9873).

particlev1(calculate,[particlev1,lit(med)],_9871,_9873) --> 
    cc(med,_9871,_9873).

particlev1(check,[particlev1,lit(opp)],_9871,_9873) --> 
    cc(opp,_9871,_9873).

particlev1(come,[particlev1,lit(med),_9899],_9874,_9876) --> 
    cc(med,_9874,_9898),
    not_look_ahead_np(_9899,_9898,_9876).

particlev1(come,[particlev1,lit(til),_9899],_9874,_9876) --> 
    cc(til,_9874,_9898),
    not_look_ahead_np(_9899,_9898,_9876).

particlev1(come,[particlev1,lit(opp)],_9871,_9873) --> 
    cc(opp,_9871,_9873).

particlev1(correct,[particlev1,lit(opp)],_9871,_9873) --> 
    cc(opp,_9871,_9873).

particlev1(fetch,[particlev1,lit(ned)],_9871,_9873) --> 
    cc(ned,_9871,_9873).

particlev1(fetch,[particlev1,lit(opp)],_9871,_9873) --> 
    cc(opp,_9871,_9873).

particlev1(find,[particlev1,lit(ut),lit(av)],_9876,_9878) --> 
    cc(ut,_9876,_9900),
    cc(av,_9900,_9878).

particlev1(get,[particlev1,lit(med)],_9871,_9873) --> 
    cc(med,_9871,_9873).

particlev1(get,[particlev1,lit(opp)],_9871,_9873) --> 
    cc(opp,_9871,_9873).

particlev1(have,[particlev1,lit('på')],_9871,_9873) --> 
    cc('på',_9871,_9873).

particlev1(help,[particlev1,lit(til),lit(med)],_9876,_9878) --> 
    cc(til,_9876,_9900),
    cc(med,_9900,_9878).

particlev1(help,[particlev1,lit(til)],_9871,_9873) --> 
    cc(til,_9871,_9873).

particlev1(improve,[particlev1,lit(inn)],_9871,_9873) --> 
    cc(inn,_9871,_9873).

particlev1(indicte,[particlev1,lit('på')],_9871,_9873) --> 
    cc('på',_9871,_9873).

particlev1(lay,[particlev1,lit(inn)],_9871,_9873) --> 
    cc(inn,_9871,_9873).

particlev1(lie1,[particlev1,lit(med)],_9871,_9873) --> 
    cc(med,_9871,_9873).

particlev1(name,[particlev1,lit(til)],_9871,_9873) --> 
    cc(til,_9871,_9873).

particlev1(reach,[particlev1,lit(til)],_9871,_9873) --> 
    cc(til,_9871,_9873).

particlev1(reach,[particlev1,lit(fram),lit(til)],_9876,_9878) --> 
    cc(fram,_9876,_9900),
    cc(til,_9900,_9878).

particlev1(read,[particlev1,lit(gjennom)],_9871,_9873) --> 
    cc(gjennom,_9871,_9873).

particlev1(receive,[particlev1,lit(opp)],_9871,_9873) --> 
    cc(opp,_9871,_9873).

particlev1(get,[particlev1,lit(opp)],_9871,_9873) --> 
    cc(opp,_9871,_9873).

particlev1(send,[particlev1,lit(med)],_9871,_9873) --> 
    cc(med,_9871,_9873).

particlev1(send,[particlev1,lit(over)],_9871,_9873) --> 
    cc(over,_9871,_9873).

particlev1(send,[particlev1,lit(ved)],_9871,_9873) --> 
    cc(ved,_9871,_9873).

particlev1(sing,[particlev1,lit(ut)],_9871,_9873) --> 
    cc(ut,_9871,_9873).

particlev1(take,[particlev1,lit(ut)],_9871,_9873) --> 
    cc(ut,_9871,_9873).

particlev1(throw,[particlev1,lit(av)],_9871,_9873) --> 
    cc(av,_9871,_9873).

particlev1(tell,[particlev1,lit(inn)],_9871,_9873) --> 
    cc(inn,_9871,_9873).

particlev1(tell,[particlev1,lit(om)],_9871,_9873) --> 
    cc(om,_9871,_9873).

particlev1(tell,[particlev1,lit(fra),lit(om),!],_9879,_9881) --> 
    cc(fra,_9879,_9903),
    cc(om,_9903,_9881),
    !.

particlev1(tell,[particlev1,lit(fra)],_9871,_9873) --> 
    cc(fra,_9871,_9873).

particlev1(tell,[particlev1,lit(ifra)],_9871,_9873) --> 
    cc(ifra,_9871,_9873).

particlev1(tell,[particlev1,_9887],_9873,_9875) --> 
    w(prep(regarding),_9887,_9873,_9875).

particlev1(wonder,[particlev1,lit('på')],_9871,_9873) --> 
    cc('på',_9871,_9873).

particlev1(write,[particlev1,lit(inn)],_9871,_9873) --> 
    cc(inn,_9871,_9873).

particlev2(avoid,release,[particlev2,lit(fri)],_9874,_9876) --> 
    cc(fri,_9874,_9876).

particlev2(be,come,[particlev2,lit(med)],_9874,_9876) --> 
    cc(med,_9874,_9876).

particlev2(belong,belong_to,[particlev2,lit(til)],_9874,_9876) --> 
    cc(til,_9874,_9876).

particlev2(hear,belong_to,[particlev2,lit(til)],_9874,_9876) --> 
    cc(til,_9874,_9876).

particlev2(calculate,expect,[particlev2,lit(med)],_9874,_9876) --> 
    cc(med,_9874,_9876).

particlev2(care1,ensure,[particlev2,lit(for)],_9874,_9876) --> 
    cc(for,_9874,_9876).

particlev2(come,appear,[particlev2,lit(fram)],_9874,_9876) --> 
    cc(fram,_9874,_9876).

particlev2(come,disappear,[particlev2,lit(bort),_9911],_9883,_9885) --> 
    cc(bort,_9883,_9910),
    not_look_ahead(w(prep(to)),_9911,_9910,_9885).

particlev2(comment,remove,[particlev2,lit(ut)],_9874,_9876) --> 
    cc(ut,_9874,_9876).

particlev2(do1,finish,[particlev2,lit(ferdig)],_9874,_9876) --> 
    cc(ferdig,_9874,_9876).

particlev2(do1,make,[particlev2,lit(meg)],_9874,_9876) --> 
    cc(meg,_9874,_9876).

particlev2(find,do1,[particlev2,lit('på')],_9874,_9876) --> 
    cc('på',_9874,_9876).

particlev2(find,discover,[particlev2,lit(ut)],_9874,_9876) --> 
    cc(ut,_9874,_9876).

particlev2(fool,wonder,[particlev2,lit('på')],_9874,_9876) --> 
    cc('på',_9874,_9876).

particlev2(go,stop,[particlev2,lit(ned)],_9874,_9876) --> 
    cc(ned,_9874,_9876).

particlev2(get,manage,[particlev2,lit(til)],_9874,_9876) --> 
    cc(til,_9874,_9876).

particlev2(have,bring,[particlev2,lit(med)],_9874,_9876) --> 
    cc(med,_9874,_9876).

particlev2(hold,be,[particlev2,lit(deg)],_9874,_9876) --> 
    cc(deg,_9874,_9876).

particlev2(hold,be,[particlev2,lit(meg)],_9874,_9876) --> 
    cc(meg,_9874,_9876).

particlev2(hold,be,[particlev2,lit(seg)],_9874,_9876) --> 
    cc(seg,_9874,_9876).

particlev2(hold,do1,[particlev2,lit('på'),lit(med)],_9879,_9881) --> 
    cc('på',_9879,_9906),
    cc(med,_9906,_9881).

particlev2(hold,be1,[particlev2,lit(til)],_9874,_9876) --> 
    cc(til,_9874,_9876).

particlev2(hold,wait,[particlev2,lit(ut)],_9874,_9876) --> 
    cc(ut,_9874,_9876).

particlev2(improve,ensure,[particlev2,lit(inn)],_9874,_9876) --> 
    cc(inn,_9874,_9876).

particlev2(lay,include,[particlev2,lit(inn)],_9874,_9876) --> 
    cc(inn,_9874,_9876).

particlev2(lay,include,[particlev2,lit('på')],_9874,_9876) --> 
    cc('på',_9874,_9876).

particlev2(lay,enclose,[particlev2,lit(ved)],_9874,_9876) --> 
    cc(ved,_9874,_9876).

particlev2(lay,stop,[particlev2,lit(ned)],_9874,_9876) --> 
    cc(ned,_9874,_9876).

particlev2(lay,change,[particlev2,lit(om)],_9874,_9876) --> 
    cc(om,_9874,_9876).

particlev2(lead,cause,[particlev2,lit(til)],_9874,_9876) --> 
    cc(til,_9874,_9876).

particlev2(lie1,belong_to,[particlev2,lit(under)],_9874,_9876) --> 
    cc(under,_9874,_9876).

particlev2(list,list,[particlev2,lit(opp)],_9874,_9876) --> 
    cc(opp,_9874,_9876).

particlev2(long,want,[particlev2,lit(etter)],_9874,_9876) --> 
    cc(etter,_9874,_9876).

particlev2(look,appear,[particlev2,lit(ut)],_9874,_9876) --> 
    cc(ut,_9874,_9876).

particlev2(meet,meetup,[particlev2,lit(opp)],_9874,_9876) --> 
    cc(opp,_9874,_9876).

particlev2(negotiate,discuss,[particlev2,lit(om)],_9874,_9876) --> 
    cc(om,_9874,_9876).

particlev2(operate,do1,[particlev2,_9898,lit(med)],_9881,_9883) --> 
    optional(['på'],_9898,_9881,_9930),
    cc(med,_9930,_9883).

particlev2(pay,pay2,[particlev2,lit(seg)],_9874,_9876) --> 
    cc(seg,_9874,_9876).

particlev2(put,arrange,[particlev2,lit(opp)],_9874,_9876) --> 
    cc(opp,_9874,_9876).

particlev2(say,tell,[particlev2,lit(fra)],_9874,_9876) --> 
    cc(fra,_9874,_9876).

particlev2(say,tell,[particlev2,lit(ifra)],_9874,_9876) --> 
    cc(ifra,_9874,_9876).

particlev2(see,appear,[particlev2,lit(ut)],_9874,_9876) --> 
    cc(ut,_9874,_9876).

particlev2(see,appear,[particlev2,lit(ut)],_9874,_9876) --> 
    cc(ut,_9874,_9876).

particlev2(stand,indicate,[particlev2,lit(for)],_9874,_9876) --> 
    cc(for,_9874,_9876).

particlev2(take,bring,[particlev2,lit(med)],_9874,_9876) --> 
    cc(med,_9874,_9876).

particlev2(take,manage,[particlev2,lit(over)],_9874,_9876) --> 
    cc(over,_9874,_9876).

particlev2(take,get,[particlev2,lit(til),_9905],_9877,_9879) --> 
    cc(til,_9877,_9904),
    rfxpron(_9905,_9904,_9879).

particlev2(take,get,[particlev2,lit(mot)],_9874,_9876) --> 
    cc(mot,_9874,_9876).

particlev2(take,get,[particlev2,lit(imot)],_9874,_9876) --> 
    cc(imot,_9874,_9876).

particlev2(take,get,[particlev2,lit(i),lit(mot)],_9879,_9881) --> 
    cc(i,_9879,_9906),
    cc(mot,_9906,_9881).

particlev2(take,treat,[particlev2,lit(opp)],_9874,_9876) --> 
    cc(opp,_9874,_9876).

particlev2(turn,stop,[particlev2,lit(av)],_9874,_9876) --> 
    cc(av,_9874,_9876).

particlev2(turn,start,[particlev2,lit('på')],_9874,_9876) --> 
    cc('på',_9874,_9876).

particlev2(write,print,[particlev2,lit(ut)],_9874,_9876) --> 
    cc(ut,_9874,_9876).

rep_particlev0(_9850,[rep_particlev0,_9888,!],_9874,_9876) --> 
    rep_particlev(_9850,_9888,_9874,_9876),
    !.

rep_particlev0(_9850,[rep_particlev0,[]],_9869,_9869) --> 
    [].

rep_particlev(ask,[rep_particlev,lit(:),!],_9874,_9876) --> 
    cc(:,_9874,_9876),
    !.

rep_particlev(deny,[rep_particlev,lit(for)],_9871,_9873) --> 
    cc(for,_9871,_9873).

rep_particlev(wonder,[rep_particlev,lit('på'),_9905,!,_9934],_9880,_9882) --> 
    cc('på',_9880,_9904),
    which0(_9905,_9904,_9920),
    !,
    accept(_9934,_9920,_9882).

rep_particlev(know,[rep_particlev,_9891,!,_9925],_9877,_9879) --> 
    prep1(to,_9891,_9877,_9908),
    !,
    accept(_9925,_9908,_9879).

rep_particlev(find,[rep_particlev,lit(ut)],_9871,_9873) --> 
    cc(ut,_9871,_9873).

rep_particlev(recognize,[rep_particlev,lit(til)],_9871,_9873) --> 
    cc(til,_9871,_9873).

rep_particlev(think,[rep_particlev,lit('på'),_9909,!,_9943],_9884,_9886) --> 
    cc('på',_9884,_9908),
    not_look_ahead([om],_9909,_9908,_9926),
    !,
    reject(_9943,_9926,_9886).

rep_particlev(think,[rep_particlev,lit('på'),_9909,!,_9943],_9884,_9886) --> 
    cc('på',_9884,_9908),
    not_look_ahead([at],_9909,_9908,_9926),
    !,
    reject(_9943,_9926,_9886).

rep_particlev(think,[rep_particlev,lit('på'),!,_9907],_9877,_9879) --> 
    cc('på',_9877,_9901),
    !,
    accept(_9907,_9901,_9879).

particle(redundantly,[particle,_9883],_9869,_9871) --> 
    redundant(_9883,_9869,_9871).

particle(_9850,[particle,_9890,!],_9876,_9878) --> 
    w(adv(_9850),_9890,_9876,_9878),
    !.

particle(back,[particle,lit(tilbake)],_9871,_9873) --> 
    cc(tilbake,_9871,_9873).

particle(badly,[particle,lit('dårlig')],_9871,_9873) --> 
    cc('dårlig',_9871,_9873).

particle(beforethat,[particle,_9883],_9869,_9871) --> 
    beforethat(_9883,_9869,_9871).

particle(daily,[particle,lit(daglig)],_9871,_9873) --> 
    cc(daglig,_9871,_9873).

particle(day_after_tomorrow,[particle,lit(overimorgen)],_9871,_9873) --> 
    cc(overimorgen,_9871,_9873).

particle(directly,[particle,lit(direkte)],_9871,_9873) --> 
    cc(direkte,_9871,_9873).

particle(down,[particle,lit(ned)],_9871,_9873) --> 
    cc(ned,_9871,_9873).

particle(down,[particle,lit(under)],_9871,_9873) --> 
    cc(under,_9871,_9873).

particle(earlier,[particle,_9883],_9869,_9871) --> 
    earlier(_9883,_9869,_9871).

particle(early,[particle,lit('så'),lit(tidlig),lit(som),_9942,!,_9976],_9895,_9897) --> 
    cc('så',_9895,_9919),
    cc(tidlig,_9919,_9930),
    cc(som,_9930,_9941),
    w(adj2(possible,nil),_9942,_9941,_9959),
    !,
    accept(_9976,_9959,_9897).

particle(early,[particle,lit(tidligst),_9910,!,_9944],_9885,_9887) --> 
    cc(tidligst,_9885,_9909),
    w(adj2(possible,nil),_9910,_9909,_9927),
    !,
    accept(_9944,_9927,_9887).

particle(early,[particle,lit(tidlig)],_9871,_9873) --> 
    cc(tidlig,_9871,_9873).

particle(early,[particle,lit(am)],_9871,_9873) --> 
    cc(am,_9871,_9873).

particle(eastward,[particle,lit('østover')],_9871,_9873) --> 
    cc('østover',_9871,_9873).

particle(everywhere,[particle,lit(overalt)],_9871,_9873) --> 
    cc(overalt,_9871,_9873).

particle(far,[particle,lit(langt)],_9871,_9873) --> 
    cc(langt,_9871,_9873).

particle(fast,[particle,lit(fort)],_9871,_9873) --> 
    cc(fort,_9871,_9873).

particle(fast,[particle,_9888],_9874,_9876) --> 
    w(adj2(fast,comp),_9888,_9874,_9876).

particle(from,[particle,lit(ifra)],_9871,_9873) --> 
    cc(ifra,_9871,_9873).

particle(gratis,[particle,lit(gratis)],_9871,_9873) --> 
    cc(gratis,_9871,_9873).

particle(home,[particle,lit(hjem),_9907,!,_9941],_9882,_9884) --> 
    cc(hjem,_9882,_9906),
    prep1(to,_9907,_9906,_9924),
    !,
    reject(_9941,_9924,_9884).

particle(home,[particle,_9888,lit(hjem)],_9874,_9876) --> 
    to0(_9888,_9874,_9903),
    cc(hjem,_9903,_9876).

particle(here,[particle,_9888,lit(hit)],_9874,_9876) --> 
    to0(_9888,_9874,_9903),
    cc(hit,_9903,_9876).

particle(here,[particle,_9888,lit(her)],_9874,_9876) --> 
    to0(_9888,_9874,_9903),
    cc(her,_9903,_9876).

particle(hereafter,[particle,_9883],_9869,_9871) --> 
    hereafter(_9883,_9869,_9871).

particle(in,[particle,lit(inn)],_9871,_9873) --> 
    cc(inn,_9871,_9873).

particle(in_morning,[particle,lit(ommorgenen)],_9871,_9873) --> 
    cc(ommorgenen,_9871,_9873).

particle(late,[particle,_9888,lit(sent)],_9874,_9876) --> 
    so0(_9888,_9874,_9903),
    cc(sent,_9903,_9876).

particle(late,[particle,_9888,lit(sent)],_9874,_9876) --> 
    too(_9888,_9874,_9903),
    cc(sent,_9903,_9876).

particle(lay,[particle,lit(ut)],_9871,_9873) --> 
    cc(ut,_9871,_9873).

particle(lay,[particle,lit(inn)],_9871,_9873) --> 
    cc(inn,_9871,_9873).

particle(lay,[particle,lit(ved)],_9871,_9873) --> 
    cc(ved,_9871,_9873).

particle(logically,[particle,lit(logisk)],_9871,_9873) --> 
    cc(logisk,_9871,_9873).

particle(much,[particle,_9888,lit(mye)],_9874,_9876) --> 
    so(_9888,_9874,_9903),
    cc(mye,_9903,_9876).

particle(normally,[particle,lit(normalt)],_9871,_9873) --> 
    cc(normalt,_9871,_9873).

particle(northward,[particle,lit(nordover)],_9871,_9873) --> 
    cc(nordover,_9871,_9873).

particle(now,[particle,_9883],_9869,_9871) --> 
    now1(_9883,_9869,_9871).

particle(now,[particle,_9890,lit('øyeblikket')],_9876,_9878) --> 
    prep1(for,_9890,_9876,_9907),
    cc('øyeblikket',_9907,_9878).

particle(on,[particle,_9885],_9871,_9873) --> 
    prep1(on,_9885,_9871,_9873).

particle(off,[particle,lit(av)],_9871,_9873) --> 
    cc(av,_9871,_9873).

particle(offside,[particle,_9886,_9910],_9872,_9874) --> 
    and0(_9886,_9872,_9901),
    compassly(_9910,_9901,_9874).

particle(often,[particle,_9888,lit(ofte)],_9874,_9876) --> 
    so0(_9888,_9874,_9903),
    cc(ofte,_9903,_9876).

particle(recently,[particle,_9883],_9869,_9871) --> 
    recently(_9883,_9869,_9871).

particle(out,[particle,lit(ut)],_9871,_9873) --> 
    cc(ut,_9871,_9873).

particle(past,[particle,lit(forbi)],_9871,_9873) --> 
    cc(forbi,_9871,_9873).

particle(present,[particle,lit(framme)],_9871,_9873) --> 
    cc(framme,_9871,_9873).

particle(punctually,[particle,lit(presis)],_9871,_9873) --> 
    cc(presis,_9871,_9873).

particle(punctually,[particle,_9888],_9874,_9876) --> 
    w(adj2(punctual,nil),_9888,_9874,_9876).

particle(punctually,[particle,_9890,lit(tide)],_9876,_9878) --> 
    prep1(in,_9890,_9876,_9907),
    cc(tide,_9907,_9878).

particle(regularly,[particle,lit(som),lit(normalt)],_9876,_9878) --> 
    cc(som,_9876,_9900),
    cc(normalt,_9900,_9878).

particle(silent,[particle,lit(stille)],_9871,_9873) --> 
    cc(stille,_9871,_9873).

particle(simultaneously,[particle,lit(samtidig)],_9871,_9873) --> 
    cc(samtidig,_9871,_9873).

particle(slowly,[particle,lit(langsomt)],_9871,_9873) --> 
    cc(langsomt,_9871,_9873).

particle(somewhere,[particle,lit(noensted)],_9871,_9873) --> 
    cc(noensted,_9871,_9873).

particle(southward,[particle,lit('sørover')],_9871,_9873) --> 
    cc('sørover',_9871,_9873).

particle(there,[particle,lit(dit)],_9871,_9873) --> 
    cc(dit,_9871,_9873).

particle(there,[particle,lit(der)],_9871,_9873) --> 
    cc(der,_9871,_9873).

particle(there,[particle,_9888],_9874,_9876) --> 
    w(adj2(present,nil),_9888,_9874,_9876).

particle(thereafter,[particle,_9883],_9869,_9871) --> 
    thereafter(_9883,_9869,_9871).

particle(this_midnight,[particle,lit(inatt)],_9871,_9873) --> 
    cc(inatt,_9871,_9873).

particle(today,[particle,lit(idag)],_9871,_9873) --> 
    cc(idag,_9871,_9873).

particle(together,[particle,lit(sammen)],_9871,_9873) --> 
    cc(sammen,_9871,_9873).

particle(tomorrow,[particle,lit(imorgen)],_9871,_9873) --> 
    cc(imorgen,_9871,_9873).

particle(tonight,[particle,lit(ikveld)],_9871,_9873) --> 
    cc(ikveld,_9871,_9873).

particle(up,[particle,lit(opp)],_9871,_9873) --> 
    cc(opp,_9871,_9873).

particle(well,[particle,lit(bra)],_9871,_9873) --> 
    cc(bra,_9871,_9873).

particle(well,[particle,lit(best)],_9871,_9873) --> 
    cc(best,_9871,_9873).

particle(well,[particle,lit(vel)],_9871,_9873) --> 
    cc(vel,_9871,_9873).

particle(westward,[particle,lit(vestover)],_9871,_9873) --> 
    cc(vestover,_9871,_9873).

particle(with1,[particle,lit(med),_9907],_9882,_9884) --> 
    cc(med,_9882,_9906),
    not_look_ahead(w(name(_9859,_9860,_9861)),_9907,_9906,_9884).

particle(wrongly,[particle,_9888,lit(feil)],_9874,_9876) --> 
    saa0(_9888,_9874,_9903),
    cc(feil,_9903,_9876).

particle(yesterday,[particle,lit('igår')],_9871,_9873) --> 
    cc('igår',_9871,_9873).

adjunct1(_9850,_9851,_9854::_9855,[adjunct1,{},_9998,_10027,_10051,{},!,_10095,!,_10156],_9968,_9970) --> 
    {user:_9850==nil},
    w(nb(_9888,_9889),_9998,_9968,_10015),
    point0(_10027,_10015,_10042),
    w(noun(_9893,_9894,u,n),_10051,_10042,_10068),
    {user:testmember(_9893,[year,month,week,day,hour,minute,second,mile,kilometer,meter])},
    !,
    lock(exact,_10068,_10115),pushstack(exact,(w(nb(_9888,num)),w(noun(_9893,sin,u,n))),nil,_10115,_10121),np0_accept(_9851,_9854::_9855,_10095,_10121,_10110),unlock(_10110,_10111),
    !,
    accept(_10156,_10111,_9970).

adjunct1(after,_9851,_9852,[adjunct1,_9921,lit('å'),!,_9966],_9901,_9903) --> 
    w(prep(after),_9921,_9901,_9938),
    cc('å',_9938,_9960),
    !,
    lock(last,_9960,_10011),
    pushstack(last,([noen],aux1),nil,_10011,_10017),
    clausal_object1(_9851,_9852,_9966,_10017,_10006),
    unlock(_10006,_9903).

adjunct1(when,_9851,_9852,[adjunct1,lit(om),lit('når'),!,_9938],_9891,_9893) --> 
    cc(om,_9891,_9921),
    cc('når',_9921,_9932),
    !,
    clausal_object1(_9851,_9852,_9938,_9932,_9893).

adjunct1(where,_9851,_9852,[adjunct1,lit(om),lit(hvor),!,_9938],_9891,_9893) --> 
    cc(om,_9891,_9921),
    cc(hvor,_9921,_9932),
    !,
    clausal_object1(_9851,_9852,_9938,_9932,_9893).

adjunct1(regarding,_9851,_9852,[adjunct1,lit(om),lit(at),!,_9938],_9891,_9893) --> 
    cc(om,_9891,_9921),
    cc(at,_9921,_9932),
    !,
    clausal_object1(_9851,_9852,_9938,_9932,_9893).

adjunct1(with,_9851,_9852,[adjunct1,lit(med),lit(det),lit('å'),!,_9960],_9902,_9904) --> 
    cc(med,_9902,_9932),
    cc(det,_9932,_9943),
    cc('å',_9943,_9954),
    !,
    pushstack(first,(someone,aux1),nil,_9954,_10026),
    clausal_object1(_9851,_9852,_9960,_10026,_9904).

adjunct1(_9850,_9851,_9852,[adjunct1,lit(hva),!,_9919],_9883,_9885) --> 
    cc(hva,_9883,_9913),
    !,
    reject(_9919,_9913,_9885).

adjunct1(_9850,_9851,_9852,[adjunct1,_9913,_9942,!,_9976],_9893,_9895) --> 
    prep1(in,_9913,_9893,_9930),
    w(noun(morning,_9868,_9869,_9870),_9942,_9930,_9959),
    !,
    reject(_9976,_9959,_9895).

adjunct1(_9850,_9851,_9854::_9855,[adjunct1,{},!,_9930],_9895,_9897) --> 
    {user:_9850==nil},
    !,
    complement_nil(_9851,_9854::_9855,_9930,_9895,_9897).

adjunct1(ago,_9851,_9854::_9855,[adjunct1,_9950,_9979,_10008,lit(siden),!,_10053,!],_9930,_9932) --> 
    prep1(for,_9950,_9930,_9967),
    anumber(_9877,_9979,_9967,_9996),
    w(noun(_9881,_9882,u,n),_10008,_9996,_10025),
    cc(siden,_10025,_10047),
    !,
    lock(exact,_10047,_10103),pushstack(exact,(number(_9877),w(noun(_9881,plu,u,n))),nil,_10103,_10109),np0_accept(_9851,_9854::_9855,_10053,_10109,_10098),unlock(_10098,_9932),
    !.

adjunct1(after,_9851,_9854::_9855,[adjunct1,lit(om),_9963,_9992,_10021,!,_10055],_9932,_9934) --> 
    cc(om,_9932,_9962),
    anumber(_9887,_9963,_9962,_9980),
    w(noun(_9880,_9892,u,gen),_9992,_9980,_10009),
    w(noun(time,sin,u,n),_10021,_10009,_10038),
    !,
    pushstack(first,(number(_9887),w(noun(_9880,sin,u,n))),nil,_10038,_10095),
    np1(_9851,_9854::_9855,_10055,_10095,_9934).

adjunct1(in,_9851,_9852,[adjunct1,_9958,_9987,{},_10026,!,_10060],_9938,_9940) --> 
    prep(in,_9958,_9938,_9975),
    w(nb(_9877,num),_9987,_9975,_10004),
    {user:(1000=<_9877,_9877=<9999)},
    not_look_ahead(w(noun(time,_9903,_9904,_9905)),_10026,_10004,_10043),
    !,
    lock(exact,_10043,_10077),
    pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_9877,num))),nil,_10077,_10083),
    np1(_9851,_9852,_10060,_10083,_10072),
    unlock(_10072,_9940).

adjunct1(around,_9851,_9852,[adjunct1,_9944,{},_9983,_10007,_10041,_10065,!,_10099],_9924,_9926) --> 
    prep1(_9878,_9944,_9924,_9961),
    {user:testmember(_9878,[in,at,around])},
    ca0(_9983,_9961,_9998),
    clock_kernel(_9851,_9875,_10007,_9998,_10026),
    point0(_10041,_10026,_10056),
    not_look_ahead(w(noun(_9898,_9899,_9900,_9901)),_10065,_10056,_10082),
    !,
    raise_object00(_9875,_9852,_10099,_10082,_9926).

adjunct1(_9850,_9851,_9852,[adjunct1,lit(med),lit(en),lit(gang),!,_9951],_9893,_9895) --> 
    cc(med,_9893,_9923),
    cc(en,_9923,_9934),
    cc(gang,_9934,_9945),
    !,
    reject(_9951,_9945,_9895).

adjunct1(between,(_9866,_9867):clock,_9854::_9854 and _9860 and _9861,[adjunct1,_9945,_9974,_9998,_10032,_10056,_10080,!,_10119],_9925,_9927) --> 
    prep1(between,_9945,_9925,_9962),
    clock0(_9974,_9962,_9989),
    clock_kernel(_9866:clock,_9860,_9998,_9989,_10017),
    betwand0(_10032,_10017,_10047),
    clock0(_10056,_10047,_10071),
    clock_kernel(_9867:clock,_9861,_10080,_10071,_10099),
    !,
    accept(_10119,_10099,_9927).

adjunct1(between,_9851,_9852,[adjunct1,_9909,_9938,!,_9977],_9889,_9891) --> 
    prep1(between,_9909,_9889,_9926),
    noun_phrases2(_9851,_9852,_9938,_9926,_9957),
    !,
    accept(_9977,_9957,_9891).

adjunct1(_9850,_9851,_9852,[adjunct1,lit(om),_9929,!,_9958,{}],_9898,_9900) --> 
    cc(om,_9898,_9928),
    not_look_ahead_subject(_9929,_9928,_9944),
    !,
    np(_9851,_9852,_9958,_9944,_9900),
    {user:adjustprep(_9851,om,_9850)}.

adjunct1(_9850,_9851,_9852,[adjunct1,_9899],_9879,_9881) --> 
    pp(_9850,_9851,_9852,_9899,_9879,_9881).

adjunct1(_9850,_9851,_9852,[adjunct1,{},_9916],_9886,_9888) --> 
    {user:_9850==dir},
    noun_phrase1(_9851,_9852,_9916,_9886,_9888).

pp(on,_9851,_9852,[pp,_9908,lit(at),_9948],_9888,_9890) --> 
    prep(on,_9908,_9888,_9925),
    cc(at,_9925,_9947),
    clausal_object1(_9851,_9852,_9948,_9947,_9890).

pp(as,_9851,_9852,[pp,lit(som),_9934,!,_9968],_9903,_9905) --> 
    cc(som,_9903,_9933),
    look_ahead_lit([meg,deg,ham,henne,oss,dem],_9934,_9933,_9951),
    !,
    np(_9851,_9852,_9968,_9951,_9905).

pp(_9850,_9851,_9852,[pp,_9917,_9946,_9975,_10004],_9897,_9899) --> 
    look_ahead([om],_9917,_9897,_9934),
    prep(_9850,_9946,_9934,_9963),
    not_look_ahead([jeg],_9975,_9963,_9992),
    np(_9851,_9852,_10004,_9992,_9899).

pp(_9850,_9851,_9852,[pp,lit('før'),lit(det),!,_9935],_9888,_9890) --> 
    cc('før',_9888,_9918),
    cc(det,_9918,_9929),
    !,
    reject(_9935,_9929,_9890).

pp(_9850,_9851,_9852,[pp,_9922,_9951,_9980,_10004,{}],_9902,_9904) --> 
    not_look_ahead_lit([om],_9922,_9902,_9939),
    prep(_9869,_9951,_9939,_9968),
    redundant0(_9980,_9968,_9995),
    object(_9851,_9852,_10004,_9995,_9904),
    {user:adjustprep(_9851,_9869,_9850)}.

pp(_9850,_9851,_9854::_9854 and _9858,[pp,_9985,{},_10024,_10053,_10082,_10116,_10145,_10174,!,_10208],_9965,_9967) --> 
    prep(_9850,_9985,_9965,_10002),
    {user:testmember(_9850,[before,after,around,to,over,within])},
    not_look_ahead([et],_10024,_10002,_10041),
    not_look_ahead([en],_10053,_10041,_10070),
    clock_kernel(_9851,_9858,_10082,_10070,_10101),
    not_look_ahead(w(noun(station,_9922,_9923,_9924)),_10116,_10101,_10133),
    not_look_ahead(w(noun(hour,_9931,_9932,_9933)),_10145,_10133,_10162),
    not_look_ahead(w(noun(minute,_9940,_9941,_9942)),_10174,_10162,_10191),
    !,
    accept(_10208,_10191,_9967).

complement_nil(_9850,_9851,[complement_nil,_9957,_9986,_10015,!,_10059,_10093],_9940,_9942) --> 
    w(nb(_9885,num),_9957,_9940,_9974),
    w(noun(minute,_9891,_9892,_9893),_9986,_9974,_10003),
    subjunction(_9895,time,_9897,_10015,_10003,_10036),
    !,
    clausal_object0(_9880,_9881,_10059,_10036,_10078),
    lock(exact,_10078,_10141),
    pushstack(exact,(w(nb(_9885,num)),w(noun(minute,plu,u,n)),w(prep(_9895)),xnp(_9880,_9881)),nil,_10141,_10147),
    np1(_9850,_9851,_10093,_10147,_10136),
    unlock(_10136,_9942).

complement_nil(_9850,_9851,[complement_nil,_9940,_9969,_9998,!,_10032],_9923,_9925) --> 
    w(nb(_9880,num),_9940,_9923,_9957),
    w(noun(minute,_9886,_9887,_9888),_9969,_9957,_9986),
    look_ahead(w(prep(_9894)),_9998,_9986,_10015),
    !,
    lock(exact,_10015,_10049),
    pushstack(exact,(w(nb(_9880,num)),w(noun(minute,_9874,_9875,_9876))),nil,_10049,_10055),
    noun_phrase1(_9850,_9851,_10032,_10055,_10044),
    unlock(_10044,_9925).

complement_nil(_9850,_9851,[complement_nil,_9892],_9875,_9877) --> 
    obviousclock(_9850,_9851,_9892,_9875,_9877).

complement_nil(_9850,_9851,[complement_nil,_9902,!,_9936],_9885,_9887) --> 
    w(prep(nil),_9902,_9885,_9919),
    !,
    noun_phrase1(_9850,_9851,_9936,_9919,_9887).

complement_nil(_9850,_9853::_9854,[complement_nil,_9946,{},!,_9990,_10014],_9929,_9931) --> 
    w(noun(_9876,_9884,_9885,n),_9946,_9929,_9963),
    {user:testmember(_9876,[nightbus,summerroute,winterroute])},
    !,
    accept(_9990,_9963,_10005),
    lock(exact,_10005,_10031),
    pushstack(exact,(w(prep(with)),w(noun(_9876,sin,u,n))),nil,_10031,_10037),
    adjunct1(_9899,_9850,_9853::_9854,_10014,_10037,_10026),
    unlock(_10026,_9931).

complement_nil(_9850,_9851,[complement_nil,_9932,_9961,_9990,_10019,_10048,!,_10082],_9915,_9917) --> 
    not_look_ahead(w(noun(street,sin,u,n)),_9932,_9915,_9949),
    not_look_ahead([den],_9961,_9949,_9978),
    not_look_ahead([det],_9990,_9978,_10007),
    not_look_ahead(w(prep(with)),_10019,_10007,_10036),
    pronoun1(_9894,_10048,_10036,_10065),
    !,
    reject(_10082,_10065,_9917).

complement_nil(_9850,_9853::_9853 and _9857,[complement_nil,_9898],_9881,_9883) --> 
    plausibleclock1(_9850,_9857,_9898,_9881,_9883).

complement_nil(_9850,_9853::_9854,[complement_nil,_9901,!],_9884,_9886) --> 
    obviousdate(_9850,_9853::_9854,_9901,_9884,_9886),
    !.

complement_nil(_9850,_9853::_9853 and _9857,[complement_nil,_9898],_9881,_9883) --> 
    plausibledate1(_9850,_9857,_9898,_9881,_9883).

complement_nil(_9850,_9853::_9854,[complement_nil,_9921,_9950,!,_9989],_9904,_9906) --> 
    look_ahead(w(adj2(_9875,nil)),_9921,_9904,_9938),
    gmem(_9875,[short,long],_9950,_9938,_9969),
    !,
    noun_phrase1(_9850,_9853::_9854,_9989,_9969,_9906).

complement_nil(_9850,_9851,[complement_nil,_9931,_9960,!,_9994],_9914,_9916) --> 
    w(nb(_9877,num),_9931,_9914,_9948),
    w(noun(time_count,_9871,_9872,_9873),_9960,_9948,_9977),
    !,
    lock(exact,_9977,_10011),
    pushstack(exact,(w(nb(_9877,num)),w(noun(time_count,_9871,_9872,_9873))),nil,_10011,_10017),
    np0(_9850,_9851,_9994,_10017,_10006),
    unlock(_10006,_9916).

complement_nil(_9850,_9851,[complement_nil,_9954,_9983,_10012,_10041,_10070,_10099,!,_10133],_9937,_9939) --> 
    not_look_ahead(w(name(_9878,_9879,_9880)),_9954,_9937,_9971),
    w(nb(_9884,num),_9983,_9971,_10000),
    not_look_ahead([ganger],_10012,_10000,_10029),
    not_look_ahead(w(noun(hour,_9896,_9897,_9898)),_10041,_10029,_10058),
    not_look_ahead(w(noun(minute,_9905,_9906,_9907)),_10070,_10058,_10087),
    not_look_ahead(w(noun(second,_9914,_9915,_9916)),_10099,_10087,_10116),
    !,
    reject(_10133,_10116,_9939).

complement_nil(_9850,_9851,[complement_nil,_9976,_10005,_10034,_10063,_10092,_10121,_10150,_10179,!],_9959,_9961) --> 
    not_look_ahead(w(nb(_9881,_9882)),_9976,_9959,_9993),
    not_look_ahead(w(_9886,name(_9886,_9890,month)),_10005,_9993,_10022),
    not_look_ahead_lit([sin,sitt,sine],_10034,_10022,_10051),
    not_look_ahead(w(noun(hour,plu,u,n)),_10063,_10051,_10080),
    not_look_ahead(w(noun(minute,plu,u,n)),_10092,_10080,_10109),
    not_look_ahead(w(noun(second,plu,u,n)),_10121,_10109,_10138),
    not_look_ahead(w(noun(room,_9933,u,n)),_10150,_10138,_10167),
    object(_9850,_9851,_10179,_10167,_9961),
    !.

complement1_accept(_9850,_9851,_9852,[complement1_accept,lit(idag),!,_9941,!],_9905,_9907) --> 
    cc(idag,_9905,_9935),
    !,
    pushstack(first,(prep(in),w(noun(day,sin,u,n))),nil,_9935,_9984),complement1_accept(_9850,_9851,_9852,_9941,_9984,_9907),
    !.

complement1_accept(_9850,_9851,_9854::_9855,[complement1_accept,_9943,{},_9982,_10011,_10040,!,_10079],_9923,_9925) --> 
    prep(_9850,_9943,_9923,_9960),
    {user:(\+testmember(_9850,[of,between]))},
    not_look_ahead([jeg],_9982,_9960,_9999),
    not_look_ahead([man],_10011,_9999,_10028),
    noun_phrase_accept(_9851,_9854::_9855,_10040,_10028,_10059),
    !,
    accept(_10079,_10059,_9925).

plausibledate1(_9853:date,_9853 isa date,[plausibledate1,_9973,{},_10012,_10036,{},_10075,_10099,{},!,_10143,{}],_9956,_9958) --> 
    num_na(_9894,_9973,_9956,_9990),
    {user:(_9894>=1000,_9894=<9999)},
    dashpoint0(_10012,_9990,_10027),
    num_na(_9895,_10036,_10027,_10053),
    {user:(_9895>=1,_9895=<12)},
    dashpoint0(_10075,_10053,_10090),
    num_na(_9896,_10099,_10090,_10116),
    {user:(_9896>=1,_9896=<31)},
    !,
    accept(_10143,_10116,_9958),
    {user:_9853=date(_9894,_9895,_9896)}.

plausibledate1(_9853:date,_9853 isa date,[plausibledate1,_9953,{},_9992,_10016,{},{},!,_10070,{}],_9936,_9938) --> 
    num_na(_9893,_9953,_9936,_9970),
    {user:_9893=<31},
    slashpoint0(_9992,_9970,_10007),
    num_na(_9892,_10016,_10007,_10033),
    {user:_9892=<12},
    {user:this_year(_9911)},
    !,
    accept(_10070,_10033,_9938),
    {user:(adjust_year(_9892,_9911,_9891),_9853=date(_9891,_9892,_9893))}.

obviousdate(_9850,_9853::_9856 and _9853,[obviousdate,_9898],_9881,_9883) --> 
    obviousdate1(_9850,_9856,_9898,_9881,_9883).

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9932,_9956,_9985,_10009,_10038,!,_10077,{}],_9915,_9917) --> 
    point0(_9932,_9915,_9947),
    dayno(_9887,_9956,_9947,_9973),
    slashpoint0(_9985,_9973,_10000),
    monthname(_9886,_10009,_10000,_10026),
    xyear0(_9886,_9885,_10038,_10026,_10057),
    !,
    accept(_10077,_10057,_9917),
    {user:_9853=date(_9885,_9886,_9887)}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9976,_10000,{},_10039,_10063,{},_10102,_10126,{},!,_10170,{}],_9959,_9961) --> 
    point0(_9976,_9959,_9991),
    num_na(_9897,_10000,_9991,_10017),
    {user:(_9897>=1000,_9897=<9999)},
    dashpoint0(_10039,_10017,_10054),
    num_na(_9898,_10063,_10054,_10080),
    {user:(_9898>=1,_9898=<12)},
    dashpoint0(_10102,_10080,_10117),
    num_na(_9899,_10126,_10117,_10143),
    {user:(_9899>=1,_9899=<31)},
    !,
    accept(_10170,_10143,_9961),
    {user:_9853=date(_9897,_9898,_9899)}.

obviousdate1(_9850,_9856 isa day and _9854,[obviousdate1,_9916,{},_9955,!,_9994],_9899,_9901) --> 
    dendagen(_9856,_9916,_9899,_9933),
    {user:dayname(_9856)},
    date(_9850,_9854,_9955,_9933,_9974),
    !,
    accept(_9994,_9974,_9901).

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9954,_9978,{},_10017,_10041,{},_10080,!,_10119,{}],_9937,_9939) --> 
    point0(_9954,_9937,_9969),
    num_na(_9893,_9978,_9969,_9995),
    {user:(_9893>=25,_9893=<31)},
    slash(_10017,_9995,_10032),
    num_na(_9892,_10041,_10032,_10058),
    {user:_9892=<12},
    xyear0(_9892,_9891,_10080,_10058,_10099),
    !,
    accept(_10119,_10099,_9939),
    {user:_9853=date(_9891,_9892,_9893)}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9995,_10019,{},_10058,_10082,{},_10121,_10165,!,{}],_9978,_9980) --> 
    den0(_9995,_9978,_10010),
    num_na(_9904,_10019,_10010,_10036),
    {user:(_9904>=1,_9904=<7)},
    point0(_10058,_10036,_10073),
    w(name(_9919,n,date),_10082,_10073,_10099),
    {user:testmember(_9919,[easterday])},
    optional(w(noun(year,_9935,_9936,n)),_10121,_10099,_10153),
    w(nb(_9941,num),_10165,_10153,_9980),
    !,
    {user:(easterdate(_9941,_9900),_9941>=1000,_9941=<9999,_9901 is _9904-1,add_days(_9900,_9901,_9853))}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,{},_9965,{},_10004,!,{}],_9938,_9940) --> 
    {user:_9853=date(_9888,_9880,_9881)},
    w(name(_9876,n,date),_9965,_9938,_9982),
    {user:testmember(_9876,[christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day,may17])},
    year_expression(_9888,_10004,_9982,_9940),
    !,
    {user:named_date(_9876,date(_9879,_9880,_9881))}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9999,_10023,{},_10062,_10086,{},_10125,_10154,!,{}],_9982,_9984) --> 
    den0(_9999,_9982,_10014),
    num_na(_9898,_10023,_10014,_10040),
    {user:(_9898>=1,_9898=<7)},
    point0(_10062,_10040,_10077),
    w(name(_9913,n,date),_10086,_10077,_10103),
    {user:testmember(_9913,[whitsun_day,easterday,christmas_day,new_years_day])},
    not_look_ahead(w(noun(year,_9935,_9936,_9937)),_10125,_10103,_10142),
    not_look_ahead(w(nb(_9943,num)),_10154,_10142,_9984),
    !,
    {user:(named_date(_9913,date(_9949,_9950,_9951)),_9895 is _9898-1,add_days(date(_9949,_9950,_9951),_9895,_9853))}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9967,{},_10006,_10035,!,{}],_9950,_9952) --> 
    w(name(_9876,n,date),_9967,_9950,_9984),
    {user:testmember(_9876,[whitsun_eve,whitsun_day,palm_sunday,maundy_thursday,good_friday,eastereve,easterday,christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day])},
    not_look_ahead(w(prep(in)),_10006,_9984,_10023),
    not_look_ahead(w(noun(year,_9927,_9928,_9929)),_10035,_10023,_9952),
    !,
    {user:named_date(_9876,_9853)}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9912,{},!],_9895,_9897) --> 
    w(name(_9867,n,date),_9912,_9895,_9897),
    {user:named_date(_9867,_9853)},
    !.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9924,{},_9963,{},!,_10007],_9907,_9909) --> 
    dendagen(_9874,_9924,_9907,_9941),
    {user:_9874\==nil},
    num_na(_9874,_9963,_9941,_9980),
    {user:numberdate(_9874,_9853)},
    !,
    accept(_10007,_9980,_9909).

obviousdate1(_9850,_9851,[obviousdate1,_9900,_9929,!],_9883,_9885) --> 
    dendagen(_9859,_9900,_9883,_9917),
    date(_9850,_9851,_9929,_9917,_9885),
    !.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9946,_9970,{},_10009,_10033,_10062,_10086,!,{}],_9929,_9931) --> 
    den(_9946,_9929,_9961),
    num_na(_9890,_9970,_9961,_9987),
    {user:(_9890>=1,_9890=<31)},
    slashpoint0(_10009,_9987,_10024),
    monthname(_9889,_10033,_10024,_10050),
    slashpoint0(_10062,_10050,_10077),
    xyear0(_9889,_9888,_10086,_10077,_9931),
    !,
    {user:_9853=date(_9888,_9889,_9890)}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9959,_9983,{},_10022,_10046,{},_10085,_10109,!,{}],_9942,_9944) --> 
    den0(_9959,_9942,_9974),
    num_na(_9893,_9983,_9974,_10000),
    {user:(_9893>=1,_9893=<31)},
    slashpoint0(_10022,_10000,_10037),
    month(_9892,_10046,_10037,_10063),
    {user:(_9892>=1,_9892=<12)},
    slashpoint0(_10085,_10063,_10100),
    year(_9891,_10109,_10100,_9944),
    !,
    {user:_9853=date(_9891,_9892,_9893)}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9932,_9961,_9990,_10019,!,{}],_9915,_9917) --> 
    not_look_ahead(w(nb(_9887,num)),_9932,_9915,_9949),
    month(_9880,_9961,_9949,_9978),
    num_na(_9881,_9990,_9978,_10007),
    year0(_9879,_10019,_10007,_9917),
    !,
    {user:_9853=date(_9879,_9880,_9881)}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9935,_9959,_9988,_10012,!,{}],_9918,_9920) --> 
    den(_9935,_9918,_9950),
    num_na(_9887,_9959,_9950,_9976),
    slashpoint(_9988,_9976,_10003),
    month(_9886,_10012,_10003,_9920),
    !,
    {user:(this_year(_9893),adjust_year(_9886,_9893,_9885),_9853=date(_9885,_9886,_9887))}.

obviousdate1(_9850,_9851,[obviousdate1,_9912,_9941,_9970,!,_10004],_9895,_9897) --> 
    dendagen(_9865,_9912,_9895,_9929),
    num_na(_9867,_9941,_9929,_9958),
    w(noun(_9871,plu,_9873,_9874),_9970,_9958,_9987),
    !,
    reject(_10004,_9987,_9897).

obviousdate1(_9850,_9851,[obviousdate1,lit(den),_9916,!,_9950],_9888,_9890) --> 
    cc(den,_9888,_9915),
    w(nb(_9866,ord),_9916,_9915,_9933),
    !,
    reject(_9950,_9933,_9890).

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,{},_9950,_9979,_10003,_10032,{}],_9923,_9925) --> 
    {user:value(busflag,true)},
    num_na(_9884,_9950,_9923,_9967),
    slashpoint0(_9979,_9967,_9994),
    num_na(_9883,_10003,_9994,_10020),
    slashpoint0(_10032,_10020,_9925),
    {user:(dedicated_date(date(_9882,_9883,_9884)),_9853=date(_9882,_9883,_9884))}.

obviousdate1(_9853:date,_9851,[obviousdate1,_9924,_9953,{},_9992,!,_10026],_9907,_9909) --> 
    dendagen(_9871,_9924,_9907,_9941),
    num_na(_9873,_9953,_9941,_9970),
    {user:(_9873>=1,_9873=<31)},
    colemin(_9886,_9992,_9970,_10009),
    !,
    reject(_10026,_10009,_9909).

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9963,{},_10002,{},_10041,_10065,!,{},{}],_9946,_9948) --> 
    dendagen(_9892,_9963,_9946,_9980),
    {user:_9892\==nil},
    num_na(_9890,_10002,_9980,_10019),
    {user:(_9890>=1,_9890=<31)},
    point(_10041,_10019,_10056),
    not_look_ahead(w(nb(_9916,_9917)),_10065,_10056,_9948),
    !,
    {user:todaysdate(date(_9888,_9889,_9925))},
    {user:_9853=date(_9888,_9889,_9890)}.

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,lit(den),_9927,{},!,_9971],_9899,_9901) --> 
    cc(den,_9899,_9926),
    num_na(_9873,_9927,_9926,_9944),
    {user:numberdate(_9873,_9853)},
    !,
    accept(_9971,_9944,_9901).

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9931,{},_9970,{},!,_10014],_9914,_9916) --> 
    num_na(_9874,_9931,_9914,_9948),
    {user:_9874>=10101},
    not_look_ahead(w(noun(_9885,plu,_9887,_9888)),_9970,_9948,_9987),
    {user:numberdate(_9874,_9853)},
    !,
    accept(_10014,_9987,_9916).

obviousdate1(_9853:date,_9853 isa date,[obviousdate1,_9931,{},_9970,{},!,_10014],_9914,_9916) --> 
    num_na(_9874,_9931,_9914,_9948),
    {user:_9874>=2501},
    not_look_ahead(w(noun(_9885,plu,_9887,_9888)),_9970,_9948,_9987),
    {user:numberdate(_9874,_9853)},
    !,
    accept(_10014,_9987,_9916).

year_expression(_9850,[year_expression,_9920,_9964,_10008,{},!],_9906,_9908) --> 
    optional(w(prep(in)),_9920,_9906,_9952),
    optional(w(noun(year,sin,u,n)),_9964,_9952,_9996),
    w(nb(_9850,num),_10008,_9996,_9908),
    {user:_9850=<9999},
    !.

year_expression(_9850,[year_expression,_9902,!,{}],_9888,_9890) --> 
    lastyear(_9902,_9888,_9890),
    !,
    {user:(this_year(_9866),_9850 is _9866-1)}.

year_expression(_9850,[year_expression,_9902,!,{}],_9888,_9890) --> 
    nextyear(_9902,_9888,_9890),
    !,
    {user:(this_year(_9866),_9850 is _9866+1)}.

lastyear([lastyear,_9895,lit(siste),_9950],_9884,_9886) --> 
    optional([i],_9895,_9884,_9927),
    cc(siste,_9927,_9949),
    w(noun(year,sin,_9860,n),_9950,_9949,_9886).

lastyear([lastyear,_9890,_9934],_9879,_9881) --> 
    optional([i],_9890,_9879,_9922),
    w(noun(lastyear,sin,_9857,n),_9934,_9922,_9881).

lastyear([lastyear,lit(ifjor),!],_9870,_9872) --> 
    cc(ifjor,_9870,_9872),
    !.

nextyear([nextyear,_9895,lit(neste),_9950],_9884,_9886) --> 
    optional([i],_9895,_9884,_9927),
    cc(neste,_9927,_9949),
    w(noun(year,sin,u,n),_9950,_9949,_9886).

plausibleclock(_9850,_9853::_9853 and _9857,[plausibleclock,_9911,!,_9945],_9894,_9896) --> 
    look_ahead(w(nb(_9872,_9873)),_9911,_9894,_9928),
    !,
    clock_sequel(_9850,_9857,_9945,_9928,_9896).

plausibleclock1(_9853:clock,_9853 isa clock,[plausibleclock1,_9965,{},_10004,_10028,_10057,_10101,_10130,{},!],_9948,_9950) --> 
    w(nb(_9885,num),_9965,_9948,_9982),
    {user:(_9885>=1,_9885=<24)},
    point0(_10004,_9982,_10019),
    w(nb(_9901,num),_10028,_10019,_10045),
    optional(['.'],_10057,_10045,_10089),
    not_look_ahead(w(nb(_9912,_9913)),_10101,_10089,_10118),
    not_look_ahead(w(name(_9919,_9920,month)),_10130,_10118,_9950),
    {user:plausibleclocktest(_9885,_9901,_9853)},
    !.

obviousclock(_9850,_9851,[obviousclock,_9922,_9951,_9975,{},!,_10019],_9905,_9907) --> 
    w(nb(_9870,num),_9922,_9905,_9939),
    pointNO(_9951,_9939,_9966),
    w(nb(_9875,num),_9975,_9966,_9992),
    {user:dedicated_date(date(_9882,_9875,_9870))},
    !,
    reject(_10019,_9992,_9907).

obviousclock(_9850,_9853::_9853 and _9857,[obviousclock,_9898],_9881,_9883) --> 
    obviousclock1(_9850,_9857,_9898,_9881,_9883).

obviousclock1(_9850,_9851,[obviousclock1,_9898,!,_9927],_9881,_9883) --> 
    clock(_9898,_9881,_9913),
    !,
    clock_sequel(_9850,_9851,_9927,_9913,_9883).

obviousclock1(_9850,_9851,[obviousclock1,_9908,_9942,!,_9976],_9891,_9893) --> 
    clock_kernel(_9850,_9851,_9908,_9891,_9927),
    w(noun(time,sin,def,n),_9942,_9927,_9959),
    !,
    accept(_9976,_9959,_9893).

obviousclock1(_9853:clock,_9853 isa clock,[obviousclock1,_9996,_10025,_10054,{},_10093,_10122,_10151,_10180,_10209,_10238,!,_10287],_9979,_9981) --> 
    not_look_ahead(w(name(_9896,n,route)),_9996,_9979,_10013),
    not_look_ahead(w(name(_9904,n,nightbus)),_10025,_10013,_10042),
    w(nb(_9853,num),_10054,_10042,_10071),
    {user:(_9853>=100,clock_test(_9853))},
    not_look_ahead([-],_10093,_10071,_10110),
    not_look_ahead(w(nb(_9931,_9932)),_10122,_10110,_10139),
    not_look_ahead(w(noun(_9938,plu,_9940,_9941)),_10151,_10139,_10168),
    not_look_ahead([tusen],_10180,_10168,_10197),
    not_look_ahead([millioner],_10209,_10197,_10226),
    optional(w(noun(time,sin,def,n)),_10238,_10226,_10270),
    !,
    accept(_10287,_10270,_9981).

obviousclock1(_9853:clock,_9853 isa clock,[obviousclock1,_9897],_9880,_9882) --> 
    time2(_9853,_9897,_9880,_9882).

obviousclock1(_9853:clock,_9853 isa clock,[obviousclock1,_9904,_9933],_9887,_9889) --> 
    hours100(_9853,_9904,_9887,_9921),
    look_ahead([om],_9933,_9921,_9889).

rel_clauses(_9850,_9851,_9852,[rel_clauses,lit(hva),!,_9919],_9883,_9885) --> 
    cc(hva,_9883,_9913),
    !,
    reject(_9919,_9913,_9885).

rel_clauses(_9850,_9851,_9851 and _9855,[rel_clauses,_9939,lit(det),_9974,_10065],_9919,_9921) --> 
    derhvor(_9939,_9919,_9954),
    cc(det,_9954,_9973),
    lock(exact,_9973,_10024),pushstack(exact,(w(prep(in)),npgap(_9850)),nil,_10024,_10030),adverbial1(_9872,_9873,_9874,_9974,_10030,_10019),unlock(_10019,_10020),
    lock(last,_10020,_10114),
    pushstack(last,([det],xadverbial1(_9872,_9873,_9874)),nil,_10114,_10120),
    substatement1(_9855,_10065,_10120,_10109),
    unlock(_10109,_9921).

rel_clauses(_9850,_9851,_9851 and _9855,[rel_clauses,_9960,_9989,_10018,!,_10052],_9940,_9942) --> 
    w(noun(_9885,_9886,_9887,n),_9960,_9940,_9977),
    w(verb(apply,_9893,fin),_9989,_9977,_10006),
    w(prep(_9898),_10018,_10006,_10035),
    !,
    pushstack(first,(w(noun(_9885,_9886,_9887,n)),w(verb(apply,_9893,fin)),w(prep(_9898)),npgap(_9850)),nil,_10035,_10092),
    statreal(_9855,_10052,_10092,_9942).

rel_clauses(_9850,_9851,_9852,[rel_clauses,_9927,_9961],_9907,_9909) --> 
    lit_of(_9862,[jeg,hun,han,vi,man,du],_9927,_9907,_9946),
    pushstack(first,([som],[_9862]),nil,_9946,_9971),
    rel_clause(_9850,_9851,_9852,_9961,_9971,_9909).

rel_clauses(_9850,_9851,_9851 and _9855,[rel_clauses,_9939,lit(det),_9974,_10065],_9919,_9921) --> 
    derhvor(_9939,_9919,_9954),
    cc(det,_9954,_9973),
    lock(exact,_9973,_10024),pushstack(exact,(w(prep(in)),npgap(_9850)),nil,_10024,_10030),adverbial1(_9872,_9873,_9874,_9974,_10030,_10019),unlock(_10019,_10020),
    lock(last,_10020,_10114),
    pushstack(last,([det],xadverbial1(_9872,_9873,_9874)),nil,_10114,_10120),
    substatement1(_9855,_10065,_10120,_10109),
    unlock(_10109,_9921).

rel_clauses(_9850,_9851,_9851 and _9855,[rel_clauses,_9927,_9951,_9985],_9907,_9909) --> 
    derhvor(_9927,_9907,_9942),
    subject(_9874,_9875,_9951,_9942,_9970),
    lock(last,_9970,_10063),
    pushstack(last,(xnp(_9874,_9875),w(prep(in)),npgap(_9850)),nil,_10063,_10069),
    statreal(_9855,_9985,_10069,_10058),
    unlock(_10058,_9909).

rel_clauses(_9850,_9851,_9852,[rel_clauses,lit(som),_9960,_9984,_10013,_10047,!,[],_10137],_9929,_9931) --> 
    cc(som,_9929,_9959),
    danow0(_9960,_9959,_9975),
    look_ahead(w(prep(_9886)),_9984,_9975,_10001),
    gmem(_9886,[of],_10013,_10001,_10032),
    adverbix(_9893,_9894,_9895,_10047,_10032,_10068),
    !,
    pushstack(free,xadverbial1(_9893,_9894,_9895),nil,_10068,_10136),[],
    pushstack(first,[som],nil,_10136,_10147),
    rel_clause(_9850,_9851,_9852,_10137,_10147,_9931).

rel_clauses(_9850,_9851,_9852,[rel_clauses,_9906,_9945],_9886,_9888) --> 
    rel_clause(_9850,_9851,_9858,_9906,_9886,_9927),
    rel_clauses0(_9850,_9858,_9852,_9945,_9927,_9888).

rel_clauses0(_9850,_9851,_9852,[rel_clauses0,_9902,_9926],_9882,_9884) --> 
    and1x(_9902,_9882,_9917),
    rel_clauses(_9850,_9851,_9852,_9926,_9917,_9884).

rel_clauses0(_9850,_9851,_9851,[rel_clauses0,[]],_9875,_9875) --> 
    [].

derhvor([derhvor,_9887,!],_9876,_9878) --> 
    one_of_lit([der,hvor,dit],_9887,_9876,_9878),
    !.

and1x([and1x,_9876],_9865,_9867) --> 
    and1(_9876,_9865,_9867).

and1x([and1x,_9880],_9869,_9871) --> 
    look_ahead([som],_9880,_9869,_9871).

dvs([dvs,lit(dvs)],_9867,_9869) --> 
    cc(dvs,_9867,_9869).

dvs([dvs,lit('altså')],_9867,_9869) --> 
    cc('altså',_9867,_9869).

dvs([dvs,lit(a),lit(la)],_9872,_9874) --> 
    cc(a,_9872,_9893),
    cc(la,_9893,_9874).

rel_clause(_9850,_9851,_9851 and _9855,[rel_clause,_9920,!,_9949],_9900,_9902) --> 
    dvs(_9920,_9900,_9935),
    !,
    lock(last,_9935,_9996),
    pushstack(last,(npgap(_9850),w(verb(be,pres,fin))),nil,_9996,_10002),
    statreal(_9855,_9949,_10002,_9991),
    unlock(_9991,_9902).

rel_clause(_9850,_9851,_9851 and _9855,[rel_clause,_9950,_9979,!,_10018],_9930,_9932) --> 
    w(verb(_9879,past,part),_9950,_9930,_9967),
    gmem(_9879,[adapt,label,be_named,register],_9979,_9967,_9998),
    !,
    lock(last,_9998,_10065),
    pushstack(last,(w(noun(agent,sin,u,n)),w(verb(_9879,past,fin)),npgap(_9850)),nil,_10065,_10071),
    statreal(_9855,_10018,_10071,_10060),
    unlock(_10060,_9932).

rel_clause(_9850,_9851,_9851 and _9855,[rel_clause,_9943,_9972,_10006,!,_10035],_9923,_9925) --> 
    rel(_9850,_9943,_9923,_9960),
    lit_of(_9879,[du,jeg,de,han,hun,vi,dere,man],_9972,_9960,_9991),
    look_ahead_vp(_10006,_9991,_10021),
    !,
    lock(last,_10021,_10082),
    pushstack(last,([_9879],npgap(_9850)),nil,_10082,_10088),
    statreal(_9855,_10035,_10088,_10077),
    unlock(_10077,_9925).

rel_clause(_9850,_9851,_9851 and _9855,[rel_clause,_9917,_9946,_9975],_9897,_9899) --> 
    rel(_9850,_9917,_9897,_9934),
    not_look_ahead([at],_9946,_9934,_9963),
    pushstack(free,npgap(_9850),nil,_9963,_10015),
    statreal(_9855,_9975,_10015,_9899).

rel_clause(_9850,_9851,_9851 and _9855,[rel_clause,_9923,lit(det),!,_9968],_9903,_9905) --> 
    rel(_9850,_9923,_9903,_9940),
    cc(det,_9940,_9962),
    !,
    lock(last,_9962,_10015),
    pushstack(last,([det],npgap(_9850)),nil,_10015,_10021),
    statreal(_9855,_9968,_10021,_10010),
    unlock(_10010,_9905).

relneg(_9850,[relneg,_9891,_9915,!],_9877,_9879) --> 
    relblabla(_9891,_9877,_9906),
    negation0(_9850,_9915,_9906,_9879),
    !.

relneg(_9850,[relneg,_9891,_9920,!],_9877,_9879) --> 
    negation0(_9850,_9891,_9877,_9908),
    relblabla(_9920,_9908,_9879),
    !.

relblabla([relblabla,lit('nå'),!],_9870,_9872) --> 
    cc('nå',_9870,_9872),
    !.

relblabla([relblabla,lit(bare),!],_9870,_9872) --> 
    cc(bare,_9870,_9872),
    !.

relblabla([relblabla,_9876],_9865,_9867) --> 
    redundant0(_9876,_9865,_9867).

whose_noun(_9850,_9851,[whose_noun,_9899,_9923],_9882,_9884) --> 
    whose(_9899,_9882,_9914),
    noun(_9856,_9857,u,n,_9850,_9851,_9923,_9914,_9884).

relwhat(_9850,[relwhat,_9900,_9924,{},!,_9963],_9886,_9888) --> 
    hva(_9900,_9886,_9915),
    som0(_9924,_9915,_9939),
    {user:constrain(_9850,thing)},
    !,
    accept(_9963,_9939,_9888).

relwhat(_9850,[relwhat,lit(hvem),_9913,{},!,_9952],_9888,_9890) --> 
    cc(hvem,_9888,_9912),
    som0(_9913,_9912,_9928),
    {user:constrain(_9850,agent)},
    !,
    accept(_9952,_9928,_9890).

rel(_9850,[rel,_9915,_9944,_9973,{},!,_10032],_9901,_9903) --> 
    relpron(_9867,_9915,_9901,_9932),
    not_look_ahead(w(quote(_9873)),_9944,_9932,_9961),
    optional(['nå'],_9973,_9961,_10005),
    {user:constrain(_9850,_9867)},
    !,
    accept(_10032,_10005,_9903).

comparisons(_9850,_9851,_9852,[comparisons,_9907,_9946],_9887,_9889) --> 
    comparison(_9850,_9851,_9859,_9907,_9887,_9928),
    comparisons0(_9850,_9851,_9859,_9852,_9946,_9928,_9889).

comparisons0(_9850,_9851,_9852,_9852 and _9856,[comparisons0,_9919,_9943,_9982],_9896,_9898) --> 
    and1(_9919,_9896,_9934),
    comparison(_9850,_9851,_9866,_9943,_9934,_9964),
    comparisons0(_9850,_9851,_9866,_9856,_9982,_9964,_9898).

comparisons0(_9850,_9851,_9852,_9852,[comparisons0,[]],_9878,_9878) --> 
    [].

comparison(_9850,_9851,_9852,[comparison,{},{},_9959,!,{}],_9919,_9921) --> 
    {user:vartypeid(_9850,_9877)},
    {user:testmember(_9877,[speed,price,name,description])},
    np1_accept(_9871,_9872::_9852,_9959,_9919,_9921),
    !,
    {user:compare(eq,thing,_9850,_9871,_9872)}.

comparison(_9850,_9851,_9852,[comparison,_9932,{},{},{},!,_9996],_9912,_9914) --> 
    comparator1(_9869,_9932,_9912,_9949),
    {user:_9869==gt},
    {user:vartype(_9850,_9879,_9880)},
    {user:testmember(_9880,[information,minute])},
    !,
    reject(_9996,_9949,_9914).

comparison(_9850,_9851,_9852,[comparison,_9929,{},_9968,{}],_9909,_9911) --> 
    comparator1(_9865,_9929,_9909,_9946),
    {user:testmember(_9865,[eq,ne])},
    noun_phrase1(_9868,_9869::_9852,_9968,_9946,_9911),
    {user:compare(_9865,thing,_9850,_9868,_9869)}.

comparison(_9850,_9851,_9852,[comparison,_9933,{},_9972,{}],_9913,_9915) --> 
    comparator1(_9865,_9933,_9913,_9950),
    {user:testmember(_9865,[gt,ge,le,lt])},
    noun_phrase1(_9868,_9869::_9852,_9972,_9950,_9915),
    {user:compare(_9865,number,_9850,_9868,_9869)}.

comparison(_9850,_9851,_9852,[comparison,_9918,_9952,{}],_9898,_9900) --> 
    comparator2(_9862,_9863,_9918,_9898,_9937),
    noun_phrase1(_9865,_9866::_9852,_9952,_9937,_9900),
    {user:compare(_9862,_9863,_9850,_9865,_9866)}.

comparison(_9850,_9851,_9852,[comparison,_9918,_9952,{}],_9898,_9900) --> 
    comparator3(_9862,_9863,_9918,_9898,_9937),
    noun_phrase1(_9865,_9866::_9852,_9952,_9937,_9900),
    {user:comparad(_9862,_9863,_9850,_9865,_9866)}.

np(_9850,_9851,[np,_9892],_9875,_9877) --> 
    xnp(_9850,_9851,_9892,_9875,_9877).

np(_9850,_9853::_9854,[np,_9898],_9881,_9883) --> 
    noun_phrases(_9850,_9853::_9854,_9898,_9881,_9883).

np(_9850,_9853::_9853,[np,_9894],_9877,_9879) --> 
    npgap(_9850,_9894,_9877,_9879).

np0_accept(_9850,_9853::_9854,[np0_accept,_9904,!,_9943],_9887,_9889) --> 
    np0(_9850,_9853::_9854,_9904,_9887,_9923),
    !,
    accept(_9943,_9923,_9889).

np00(_9850,_9863:_9850,_9854::exists(_9863:_9850)::_9863 isa _9850 and _9854,[np00,[]],_9895,_9895) --> 
    [].

raise_object00(_9850,_9853::_9853 and _9850,[raise_object00,[]],_9878,_9878) --> 
    [].

subject(_9850,_9851,[subject,_9935,_9964,_9993,_10022],_9918,_9920) --> 
    not_look_ahead(w(name('være',n,_9871)),_9935,_9918,_9952),
    not_look_ahead(w(name(norwegian,n,language)),_9964,_9952,_9981),
    not_look_ahead_lit([meg,deg,ham,henne,seg,oss,dem,det],_9993,_9981,_10010),
    np(_9850,_9851,_10022,_10010,_9920).

object1(_9850,_9851,[object1,_9910,_9939,!],_9893,_9895) --> 
    not_look_ahead_lit([jeg,du,han,hun,vi],_9910,_9893,_9927),
    np0(_9850,_9851,_9939,_9927,_9895),
    !.

object(_9850,_9851,[object,_9895,_9919],_9878,_9880) --> 
    not_look_ahead_subject(_9895,_9878,_9910),
    noun_phrase_accept(_9850,_9851,_9919,_9910,_9880).

ind_object(_9850,_9851,[ind_object,_9895,_9919],_9878,_9880) --> 
    not_look_ahead_subject(_9895,_9878,_9910),
    noun_phrase_accept(_9850,_9851,_9919,_9910,_9880).

not_look_ahead_time([not_look_ahead_time,_9882,!,_9911],_9871,_9873) --> 
    look_ahead_time(_9882,_9871,_9897),
    !,
    reject(_9911,_9897,_9873).

look_ahead_time([look_ahead_time,_9881],_9870,_9872) --> 
    w(nb(_9852,_9853),_9881,_9870,_9872).

look_ahead_time([look_ahead_time,_9882],_9871,_9873) --> 
    one_of_lit([halv,kvart],_9882,_9871,_9873).

look_ahead_time([look_ahead_time,_9894,{},!],_9883,_9885) --> 
    w(noun(_9858,_9859,_9860,_9861),_9894,_9883,_9885),
    {user:subclass0(_9858,time)},
    !.

not_look_ahead_subject([not_look_ahead_subject,_9882,!,_9911],_9871,_9873) --> 
    look_ahead_subject(_9882,_9871,_9897),
    !,
    reject(_9911,_9897,_9873).

not_look_ahead_subject([not_look_ahead_subject,[]],_9865,_9865) --> 
    [].

look_ahead_subject([look_ahead_subject,_9890],_9879,_9881) --> 
    look_ahead_lit([jeg,du,han,hun,vi,man],_9890,_9879,_9881).

subject2(_9850,_9851,_9852,[subject2,_9905,!,_9949],_9885,_9887) --> 
    noun_phrase2(_9850,_9851,_9852,_9905,_9885,_9926),
    !,
    accept(_9949,_9926,_9887).

object2hnn(_9850,_9851,_9852,[object2hnn,_9935,_9964,_9993,_10022,!,_10056],_9915,_9917) --> 
    w(name(_9871,_9872,_9873),_9935,_9915,_9952),
    not_look_ahead(w(prep(on)),_9964,_9952,_9981),
    not_look_ahead(w(noun(_9885,_9886,_9887,_9888)),_9993,_9981,_10010),
    not_look_ahead([deg],_10022,_10010,_10039),
    !,
    reject(_10056,_10039,_9917).

object2hnn(_9850,_9851,_9852,[object2hnn,_9905,!,_9949],_9885,_9887) --> 
    object2h(_9850,_9851,_9852,_9905,_9885,_9926),
    !,
    accept(_9949,_9926,_9887).

object2h(_9850,_9851,_9852,[object2h,lit(dere),!,_9919],_9883,_9885) --> 
    cc(dere,_9883,_9913),
    !,
    reject(_9919,_9913,_9885).

object2h(_9850,_9851,_9852,[object2h,_9899],_9879,_9881) --> 
    object2(_9850,_9851,_9852,_9899,_9879,_9881).

object2(_9850,_9851,_9852,[object2,lit(en),lit(gang),!,_9935],_9888,_9890) --> 
    cc(en,_9888,_9918),
    cc(gang,_9918,_9929),
    !,
    reject(_9935,_9929,_9890).

object2(_9850,_9851,_9852,[object2,_9917,_9941,{},!,_9990],_9897,_9899) --> 
    which(_9917,_9897,_9932),
    np(_9851,_9852,_9941,_9932,_9960),
    {user:(\+vartypeid(_9851,place))},
    !,
    accept(_9990,_9960,_9899).

object2(_9850,_9850,_9854::_9854 and _9858,[object2,_9915,_9944,!,_9973],_9895,_9897) --> 
    prep1(around,_9915,_9895,_9932),
    clock(_9944,_9932,_9959),
    !,
    clock_kernel(_9850,_9858,_9973,_9959,_9897).

object2(_9850,_9851,_9854::_9855,[object2,_9912,_9941],_9892,_9894) --> 
    not_look_ahead_lit([middag],_9912,_9892,_9929),
    noun_phrase2(_9850,_9851,_9854::_9855,_9941,_9929,_9894).

object2(_9850,_9851,_9852,[object2,_9918,_9947,!,_9981],_9898,_9900) --> 
    one_of_lit([jeg,du,hun,vi],_9918,_9898,_9935),
    not_look_ahead([som],_9947,_9935,_9964),
    !,
    reject(_9981,_9964,_9900).

noun_phrase2(_9850,_9851,_9854::_9854 and _9858,[noun_phrase2,_9920,!,_9954,_9978],_9900,_9902) --> 
    look_ahead([hvor],_9920,_9900,_9937),
    !,
    accept(_9954,_9937,_9969),
    adverbial_noun_phrase1(_9851,_9854::_9858,_9978,_9969,_9902).

noun_phrase2(_9850,_9850,_9854::_9855,[noun_phrase2,_9914,_9943],_9894,_9896) --> 
    recipron(_9865,_9914,_9894,_9931),
    pushstack(first,npgap(_9850),nil,_9931,_9983),
    noun_phrase1(_9850,_9854::_9855,_9943,_9983,_9896).

noun_phrase2(_9850,_9851,_9854::findalt(diff,_9850,_9851)::_9860 and _9854,[noun_phrase2,_9926,_9950,_10004],_9906,_9908) --> 
    another(_9926,_9906,_9941),
    noun(_9878,sin,u,n,_9851,_9875,_9950,_9941,_9977),
    noun_modsx0(0,_9851,_9875,_9860,_10004,_9977,_9908).

noun_phrase2(_9850,_9851,_9852,[noun_phrase2,_9929,_9958,_9987,!,_10021],_9909,_9911) --> 
    not_look_ahead(w(noun(_9870,_9871,_9872,_9873)),_9929,_9909,_9946),
    not_look_ahead(w(adj2(_9879,_9880)),_9958,_9946,_9975),
    w(verb(_9884,past,part),_9987,_9975,_10004),
    !,
    reject(_10021,_10004,_9911).

noun_phrase2(_9850,_9851,_9852,[noun_phrase2,_9908,!,_9942],_9888,_9890) --> 
    look_ahead([hva],_9908,_9888,_9925),
    !,
    np(_9851,_9852,_9942,_9925,_9890).

noun_phrase2(_9850,_9851,_9852,[noun_phrase2,_9908,_9937,_9961],_9888,_9890) --> 
    not_look_ahead([hva],_9908,_9888,_9925),
    which0(_9937,_9925,_9952),
    np(_9851,_9852,_9961,_9952,_9890).

adverbial_noun_phrase1(_9850,_9853::_9853 and _9857,[adverbial_noun_phrase1,lit(hvor),_9960,_9989,!,_10055],_9932,_9934) --> 
    cc(hvor,_9932,_9959),
    not_look_ahead([mye],_9960,_9959,_9977),
    lock(exact,_9977,_10009),pushstack(exact,(w(prep(in)),w(noun(place,sin,u,n))),nil,_10009,_10015),adverbial1(_9874,_9850,_9878::_9879,_9989,_10015,_10004),unlock(_10004,_10005),
    !,
    lock(last,_10005,_10107),
    pushstack(last,adverbial1(_9874,_9850,_9878::_9879),nil,_10107,_10113),
    statreal(_9857,_10055,_10113,_10102),
    unlock(_10102,_9934).

noun_phrase_accept(_9850,_9851,[noun_phrase_accept,_9898,!,_9937],_9881,_9883) --> 
    np(_9850,_9851,_9898,_9881,_9917),
    !,
    accept(_9937,_9917,_9883).

np1_accept(_9850,_9851,[np1_accept,_9898,!,_9937],_9881,_9883) --> 
    noun_phrase1(_9850,_9851,_9898,_9881,_9917),
    !,
    accept(_9937,_9917,_9883).

noun_phrases2(_9850,_9853::_9856 and _9857,[noun_phrases2,_9929,_9963,_9987,{},!,_10036],_9912,_9914) --> 
    np1_accept(_9874,_9853::_9856,_9929,_9912,_9948),
    and0(_9963,_9948,_9978),
    np1_accept(_9880,_9853::_9857,_9987,_9978,_10006),
    {user:latin(and,_9874,_9880,_9850)},
    !,
    accept(_10036,_10006,_9914).

noun_phrases(_9850,_9853::_9856 and _9859 and _9860,[noun_phrases,_9968,_9997,{},{},_10051,_10085,{},!,_10134],_9951,_9953) --> 
    look_ahead(w(noun(distance,sin,def,n)),_9968,_9951,_9985),
    noun_phrase1(_9895,_9853::_9856,_9997,_9985,_10016),
    {user:vartypeid(_9895,_9904)},
    {user:testmember(_9904,[distance])},
    noun_phrase1(_9913,_9853::_9859,_10051,_10016,_10070),
    noun_phrase1(_9919,_9853::_9860,_10085,_10070,_10104),
    {user:latin(and,_9913,_9919,_9850)},
    !,
    accept(_10134,_10104,_9953).

noun_phrases(_9850,_9853::_9854,[noun_phrases,_9915,_9949,!,_9998],_9898,_9900) --> 
    noun_phrase1(_9865,_9853::_9869,_9915,_9898,_9934),
    noun_phrases0(_9865,_9850,true::_9869,_9854,_9949,_9934,_9972),
    !,
    accept(_9998,_9972,_9900).

noun_phrases0(_9850,_9850,_9855::_9853,_9853,[noun_phrases0,{},!],_9889,_9889) --> 
    {user:constrain(_9850,number)},
    !.

noun_phrases0(_9850,_9850,_9855::_9853,_9853,[noun_phrases0,_9914,!],_9891,_9893) --> 
    look_ahead(w(nb(_9865,_9866)),_9914,_9891,_9893),
    !.

noun_phrases0(_9850,_9850,_9855::_9853,_9853,[noun_phrases0,_9913,!],_9890,_9892) --> 
    look_ahead_lit([etc,samme],_9913,_9890,_9892),
    !.

noun_phrases0(_9850,_9850,_9855::_9853,_9853,[noun_phrases0,_9927,{},!],_9904,_9906) --> 
    look_ahead(w(verb(_9868,inf,fin)),_9927,_9904,_9906),
    {user:testmember(_9868,[be,use])},
    !.

noun_phrases0(_9850,_9850,_9855::_9853,_9853,[noun_phrases0,_9927,{},!],_9904,_9906) --> 
    look_ahead(w(verb(_9868,pres,fin)),_9927,_9904,_9906),
    {user:testmember(_9868,[wish,want])},
    !.

noun_phrases0(_9850,_9851,_9858::_9855,_9855 and _9856,[noun_phrases0,_9956,_9985,_10014,_10043,_10077,{}],_9933,_9935) --> 
    not_look_ahead([','],_9956,_9933,_9973),
    np_conjunction(_9878,_9985,_9973,_10002),
    not_look_ahead(w(noun(_9893,sin,def,n)),_10014,_10002,_10031),
    noun_phrase1(_9898,_9858::_9902,_10043,_10031,_10062),
    noun_phrases20(_9898,_9880,_9858,_9902,_9856,_10077,_10062,_9935),
    {user:latin(_9878,_9850,_9880,_9851)}.

noun_phrases0(_9850,_9851,_9858::_9855,_9855 and _9856,[noun_phrases0,{},_9952,_9986,{}],_9919,_9921) --> 
    {user:(\+vartypeid(_9850,savant))},
    noun_phrase1(_9884,_9858::_9888,_9952,_9919,_9971),
    noun_phrases10(_9884,_9874,_9858,_9888,_9856,_9986,_9971,_9921),
    {user:latin(and,_9850,_9874,_9851)}.

noun_phrases0(_9850,_9850,_9855::_9853,_9853,[noun_phrases0,[]],_9881,_9881) --> 
    [].

noun_phrases10(_9850,_9851,_9852,_9853,_9853 and _9857,[noun_phrases10,_9945,_9974,_10008,{},lit(etc)],_9919,_9921) --> 
    andor(_9873,_9945,_9919,_9962),
    noun_phrase1(_9875,_9852::_9879,_9974,_9962,_9993),
    noun_phrases20(_9875,_9882,_9852,_9879,_9857,_10008,_9993,_10033),
    {user:latin(_9873,_9850,_9882,_9851)},
    cc(etc,_10033,_9921).

noun_phrases10(_9850,_9851,_9852,_9853,_9853 and _9857,[noun_phrases10,_9945,_9974,_10008,{}],_9919,_9921) --> 
    not_look_ahead(w(nb(_9879,_9880)),_9945,_9919,_9962),
    noun_phrase1(_9882,_9852::_9886,_9974,_9962,_9993),
    noun_phrases10(_9882,_9872,_9852,_9886,_9857,_10008,_9993,_9921),
    {user:latin(and,_9850,_9872,_9851)}.

noun_phrases10(_9850,_9850,_9852,_9853,_9853,[noun_phrases10,lit(etc)],_9883,_9885) --> 
    cc(etc,_9883,_9885).

noun_phrases20(_9850,_9851,_9852,_9853,_9853 and _9857,[noun_phrases20,_9940,_9969,_10003,{}],_9914,_9916) --> 
    andor(_9870,_9940,_9914,_9957),
    noun_phrase1(_9877,_9852::_9881,_9969,_9957,_9988),
    noun_phrases20(_9877,_9872,_9852,_9881,_9857,_10003,_9988,_9916),
    {user:latin(_9870,_9850,_9872,_9851)}.

noun_phrases20(_9850,_9850,_9852,_9853,_9853,[noun_phrases20,[]],_9881,_9881) --> 
    [].

no_phrases(_9850,_9851,[no_phrases,{},!,_9921],_9889,_9891) --> 
    {user:value(teleflag,true)},
    !,
    np(_9850,true::_9851,_9921,_9889,_9891).

no_phrases(_9850,_9851,[no_phrases,_9898,_9922],_9881,_9883) --> 
    the0(_9898,_9881,_9913),
    np(_9850,true::_9851,_9922,_9913,_9883).

no_phrase(_9850,_9851,[no_phrase,_9898,_9922],_9881,_9883) --> 
    the0(_9898,_9881,_9913),
    noun_phrase1(_9850,true::_9851,_9922,_9913,_9883).

noun_phrase1(_9850,_9851,[noun_phrase1,lit(og),!,_9913],_9880,_9882) --> 
    cc(og,_9880,_9907),
    !,
    reject(_9913,_9907,_9882).

noun_phrase1(_9850,_9851,[noun_phrase1,_9892],_9875,_9877) --> 
    np2(_9850,_9851,_9892,_9875,_9877).

noun_phrase1(_9850,_9851,[noun_phrase1,_9892],_9875,_9877) --> 
    np1(_9850,_9851,_9892,_9875,_9877).

noun_phrase1(_9850,_9851,[noun_phrase1,_9919,_9948,_9977,_10006,_10030],_9902,_9904) --> 
    one_of_lit([noen,mange],_9919,_9902,_9936),
    not_look_ahead([som],_9948,_9936,_9965),
    not_look_ahead([av],_9977,_9965,_9994),
    not_look_ahead_np(_10006,_9994,_10021),
    np00(agent,_9850,_9851,_10030,_10021,_9904).

noun_phrase1(_9850,_9851,[noun_phrase1,_9916,_9945,_9974,_9998],_9899,_9901) --> 
    one_of_lit([den,det],_9916,_9899,_9933),
    not_look_ahead(w(verb(_9876,_9877,pass)),_9945,_9933,_9962),
    not_look_ahead_np(_9974,_9962,_9989),
    np00(thing,_9850,_9851,_9998,_9989,_9901).

noun_phrase1(_9850,_9853::_9854,[noun_phrase1,_9956,_9985,_10014,_10048,_10077,!,_10111,_10135],_9939,_9941) --> 
    not_look_ahead([de],_9956,_9939,_9973),
    not_look_ahead([det],_9985,_9973,_10002),
    quant_pron(some,_9885,_10014,_10002,_10033),
    not_look_ahead([som],_10048,_10033,_10065),
    not_look_ahead(w(noun(_9909,_9910,_9911,_9912)),_10077,_10065,_10094),
    !,
    accept(_10111,_10094,_10126),
    lock(exact,_10126,_10185),
    pushstack(exact,(some,w(noun(_9885,sin,u,n))),nil,_10185,_10191),
    np1(_9850,_9853::_9854,_10135,_10191,_10180),
    unlock(_10180,_9941).

noun_phrase1(_9850,_9851,[noun_phrase1,_9948,_9977,_10011,_10040,!,_10074,_10098],_9931,_9933) --> 
    not_look_ahead([de],_9948,_9931,_9965),
    quant_pron(every,thing,_9977,_9965,_9996),
    not_look_ahead(w(noun(_9895,_9896,_9897,_9898)),_10011,_9996,_10028),
    not_look_ahead(w(adj2(_9904,_9905)),_10040,_10028,_10057),
    !,
    accept(_10074,_10057,_10089),
    pushstack(first,([alle],w(noun(thing,sin,u,n))),nil,_10089,_10108),
    np1(_9850,_9851,_10098,_10108,_9933).

noun_phrase1(_9850,_9851,[noun_phrase1,_9892],_9875,_9877) --> 
    npa(_9850,_9851,_9892,_9875,_9877).

noun_phrase1(_9850,_9853::_9854,[noun_phrase1,_9917,_9951],_9900,_9902) --> 
    quant_pron(much,_9867,_9917,_9900,_9936),
    lock(exact,_9936,_10001),
    pushstack(exact,(much,w(noun(_9867,sin,u,n))),nil,_10001,_10007),
    np1(_9850,_9853::_9854,_9951,_10007,_9996),
    unlock(_9996,_9902).

noun_phrase1(_9850,_9853::_9854,[noun_phrase1,_9917,_9951],_9900,_9902) --> 
    quant_pron(little,_9867,_9917,_9900,_9936),
    lock(exact,_9936,_10001),
    pushstack(exact,(little,w(noun(_9867,sin,u,n))),nil,_10001,_10007),
    np1(_9850,_9853::_9854,_9951,_10007,_9996),
    unlock(_9996,_9902).

noun_phrase1(_9850,_9853::not _9856,[noun_phrase1,_9919,_9953],_9902,_9904) --> 
    quant_pron(no,_9869,_9919,_9902,_9938),
    lock(exact,_9938,_10003),
    pushstack(exact,(every,w(noun(_9869,sin,u,n))),nil,_10003,_10009),
    np1(_9850,_9853::_9856,_9953,_10009,_9998),
    unlock(_9998,_9904).

noun_phrase1(_9850,_9851,[noun_phrase1,_9892],_9875,_9877) --> 
    xnp(_9850,_9851,_9892,_9875,_9877).

noun_phrase1(_9850,_9853::_9853,[noun_phrase1,_9894],_9877,_9879) --> 
    npgap(_9850,_9894,_9877,_9879).

specific_phrase(_9850,_9851,[specific_phrase,_9901,!,_9935],_9884,_9886) --> 
    w(name(_9861,gen,_9863),_9901,_9884,_9918),
    !,
    reject(_9935,_9918,_9886).

specific_phrase(_9850,_9851,[specific_phrase,_9904,_9933,!,_9962],_9887,_9889) --> 
    w(name(_9864,_9865,_9866),_9904,_9887,_9921),
    sin(_9933,_9921,_9948),
    !,
    reject(_9962,_9948,_9889).

specific_phrase(_9850,_9853::_9854,[specific_phrase,_9898],_9881,_9883) --> 
    sp1(_9850,_9853::_9854,_9898,_9881,_9883).

sp1(_9862:_9863,_9853::findpron(_9862:_9863)::_9862 isa _9871 and _9853,[sp1,_9919,{}],_9902,_9904) --> 
    pronoun(_9871,_9919,_9902,_9904),
    {user:type(_9871,_9863)}.

sp1(_9850,_9851,[sp1,_9905,_9944],_9888,_9890) --> 
    name_phrase(name,_9850,_9851,_9905,_9888,_9926),
    not_look_ahead(w(noun(_9860,_9861,_9862,_9863)),_9944,_9926,_9890).

np0(_9850,_9851,[np0,lit(mye),_9938,_9962,_9991,!,_10057],_9910,_9912) --> 
    cc(mye,_9910,_9937),
    not_look_ahead_np(_9938,_9937,_9953),
    not_look_ahead(w(adj(_9874,_9875)),_9962,_9953,_9979),
    lock(exact,_9979,_10011),pushstack(exact,w(noun(thing,sin,u,n)),nil,_10011,_10017),np_kernel(0,_9850,_9851,_9991,_10017,_10006),unlock(_10006,_10007),
    !,
    accept(_10057,_10007,_9912).

np0(_9850,_9853::_9854,[np0,_9905,!,_9949],_9888,_9890) --> 
    np_head1(_9862,_9850,_9853::_9854,_9905,_9888,_9926),
    !,
    accept(_9949,_9926,_9890).

np0(_9850,_9853::_9854,[np0,_9902,_9926],_9885,_9887) --> 
    the10(_9902,_9885,_9917),
    aname_phrase(_9859,_9850,_9853::_9854,_9926,_9917,_9887).

np0(_9850,_9853::_9854,[np0,_9899],_9882,_9884) --> 
    np_kernel(_9856,_9850,_9853::_9854,_9899,_9882,_9884).

np0(_9850,_9853::_9854,[np0,_9898],_9881,_9883) --> 
    npa(_9850,_9853::_9854,_9898,_9881,_9883).

np0(_9850,_9853::_9853,[np0,_9894],_9877,_9879) --> 
    npgap(_9850,_9894,_9877,_9879).

obvious_object(_9850,_9851,[obvious_object,lit(det),_9919,!,_9953],_9891,_9893) --> 
    cc(det,_9891,_9918),
    not_look_ahead(w(verb(_9868,_9869,pass)),_9919,_9918,_9936),
    !,
    reject(_9953,_9936,_9893).

obvious_object(_9850,_9851,[obvious_object,_9902,_9931,!],_9885,_9887) --> 
    look_ahead([alt],_9902,_9885,_9919),
    np1_accept(_9850,_9851,_9931,_9919,_9887),
    !.

obvious_object(_9850,_9851,[obvious_object,_9899,_9928],_9882,_9884) --> 
    not_look_ahead([noen],_9899,_9882,_9916),
    np0_accept(_9850,_9851,_9928,_9916,_9884).

np1(_9850,_9853::_9853 and _9857,[np1,_9961,lit(det),_9996,lit('å'),!,_10041,!,_10089],_9944,_9946) --> 
    hvormye(_9961,_9944,_9976),
    cc(det,_9976,_9995),
    w(verb(_9895,_9896,fin),_9996,_9995,_10013),
    cc('å',_10013,_10035),
    !,
    pushstack(first,([noen],[vil]),nil,_10035,_10054),clausal_object1(_9909,_9910,_10041,_10054,_10069),
    !,
    lock(exact,_10069,_10167),
    pushstack(exact,(xnp(_9909,_9910),w(verb(_9895,_9896,fin)),npgap(_9850)),nil,_10167,_10173),
    statreal1(_9857,_10089,_10173,_10162),
    unlock(_10162,_9946).

np1(_9850,_9851,[np1,lit(noe),_9939,!,_9973,_10034],_9911,_9913) --> 
    cc(noe,_9911,_9938),
    look_ahead(w(prep(_9876)),_9939,_9938,_9956),
    !,
    lock(exact,_9956,_9993),pushstack(exact,w(noun(thing,sin,u,n)),nil,_9993,_9999),np_kernel(0,_9850,_9867,_9973,_9999,_9988),unlock(_9988,_9989),
    noun_modifiers0(0,_9850,_9867,_9851,_10034,_9989,_9913).

np1(_9850,_9851,[np1,_9995,_10019,_10048,_10077,{},!,_10121,_10145,_10206],_9978,_9980) --> 
    a(_9995,_9978,_10010),
    w(noun(_9894,sin,u,n),_10019,_10010,_10036),
    w(name(_9888,n,_9890),_10048,_10036,_10065),
    w(noun(_9907,sin,u,n),_10077,_10065,_10094),
    {user:(\+testmember(_9907,[minute,hour,direction,home,station]))},
    !,
    accept(_10121,_10094,_10136),
    lock(exact,_10136,_10165),pushstack(exact,w(noun(_9907,sin,u,n)),nil,_10165,_10171),np_kernel(_9939,_9850,_9941,_10145,_10171,_10160),unlock(_10160,_10161),
    lock(exact,_10161,_10223),
    pushstack(exact,(w(prep(with)),w(noun(_9894,sin,u,n)),w(name(_9888,n,_9890))),nil,_10223,_10229),
    noun_modifiers0(0,_9850,_9941,_9851,_10206,_10229,_10218),
    unlock(_10218,_9980).

np1(_9850,_9851,[np1,lit(hvem),_9938,!,_9972,_10011],_9910,_9912) --> 
    cc(hvem,_9910,_9937),
    look_ahead_lit([man,jeg,du,vi],_9938,_9937,_9955),
    !,
    np00(agent,_9850,_9884,_9972,_9955,_9993),
    pushstack(first,relpron(agent),nil,_9993,_10054),
    noun_modifiers0(0,_9850,_9884,_9851,_10011,_10054,_9912).

np1(_9850,_9851,[np1,lit(hvem),lit(som),!,_9946,_9985],_9902,_9904) --> 
    cc(hvem,_9902,_9929),
    cc(som,_9929,_9940),
    !,
    np00(agent,_9850,_9876,_9946,_9940,_9967),
    pushstack(first,relpron(agent),nil,_9967,_10025),
    noun_modifiers0(0,_9850,_9876,_9851,_9985,_10025,_9904).

np1(_9850,_9851,[np1,_9925,_9949,!,_9978,_10039],_9908,_9910) --> 
    hvormye(_9925,_9908,_9940),
    dette(_9949,_9940,_9964),
    !,
    lock(exact,_9964,_9998),pushstack(exact,w(noun(thing,sin,u,n)),nil,_9998,_10004),np_kernel(0,_9850,_9882,_9978,_10004,_9993),unlock(_9993,_9994),
    pushstack(first,relpron(thing),nil,_9994,_10080),
    noun_modifiers0(0,_9850,_9882,_9851,_10039,_10080,_9910).

np1(_9850,_9851,[np1,lit(hva),lit(som),!,_9946,_9985],_9902,_9904) --> 
    cc(hva,_9902,_9929),
    cc(som,_9929,_9940),
    !,
    np00(thing,_9850,_9876,_9946,_9940,_9967),
    pushstack(first,relpron(thing),nil,_9967,_10025),
    noun_modifiers0(0,_9850,_9876,_9851,_9985,_10025,_9904).

np1(_9850,_9851,[np1,lit(hva),_9938,!,_9967,_10028],_9910,_9912) --> 
    cc(hva,_9910,_9937),
    look_ahead_np(_9938,_9937,_9953),
    !,
    lock(exact,_9953,_9987),pushstack(exact,w(noun(thing,sin,u,n)),nil,_9987,_9993),np_kernel(0,_9850,_9884,_9967,_9993,_9982),unlock(_9982,_9983),
    pushstack(first,relpron(thing),nil,_9983,_10068),
    noun_modifiers0(0,_9850,_9884,_9851,_10028,_10068,_9912).

np1(_9850,_9851,[np1,lit(de),_9934,_9963,!,_9997],_9906,_9908) --> 
    cc(de,_9906,_9933),
    not_look_ahead(w(nb(_9875,_9876)),_9934,_9933,_9951),
    look_ahead(w(noun(_9882,sin,_9884,_9885)),_9963,_9951,_9980),
    !,
    np00(agent,_9850,_9851,_9997,_9980,_9908).

np1(_9850,_9851,[np1,_9953,!,_9982,lit('å'),_10027,!,_10061,_10122],_9936,_9938) --> 
    noemed(_9953,_9936,_9968),
    !,
    np0_accept(_9880,_9881,_9982,_9968,_10001),
    cc('å',_10001,_10026),
    w(verb(do1,inf,fin),_10027,_10026,_10044),
    !,
    lock(exact,_10044,_10081),pushstack(exact,w(noun(thing,sin,u,n)),nil,_10081,_10087),np_kernel(_9904,_9850,_9906,_10061,_10087,_10076),unlock(_10076,_10077),
    pushstack(first,(w(prep(with)),xnp(_9880,_9881)),nil,_10077,_10163),
    noun_modifiers0(_9904,_9850,_9906,_9851,_10122,_10163,_9938).

noemed([noemed,lit(noe),lit(med)],_9872,_9874) --> 
    cc(noe,_9872,_9893),
    cc(med,_9893,_9874).

np1(_9850,_9851,[np1,_9927,!,_9956,_10017],_9910,_9912) --> 
    'noeå'(_9927,_9910,_9942),
    !,
    lock(exact,_9942,_9976),pushstack(exact,w(noun(thing,sin,u,n)),nil,_9976,_9982),np_kernel(0,_9850,_9882,_9956,_9982,_9971),unlock(_9971,_9972),
    pushstack(first,([som],[jeg]),nil,_9972,_10027),
    noun_modifiers0(0,_9850,_9882,_9851,_10017,_10027,_9912).

'noeå'(['noeå',lit(noe),lit('å')],_9872,_9874) --> 
    cc(noe,_9872,_9893),
    cc('å',_9893,_9874).

np1(_9850,_9851,[np1,_9922,!,_9951,_10012],_9905,_9907) --> 
    noesom(_9922,_9905,_9937),
    !,
    lock(exact,_9937,_9971),pushstack(exact,w(noun(thing,sin,u,n)),nil,_9971,_9977),np_kernel(0,_9850,_9879,_9951,_9977,_9966),unlock(_9966,_9967),
    pushstack(first,[som],nil,_9967,_10022),
    noun_modifiers0(0,_9850,_9879,_9851,_10012,_10022,_9907).

noesom([noesom,lit(det),_9902],_9880,_9882) --> 
    cc(det,_9880,_9901),
    look_ahead_lit([man,jeg,du,vi],_9902,_9901,_9882).

noesom([noesom,lit(det),lit(som)],_9872,_9874) --> 
    cc(det,_9872,_9893),
    cc(som,_9893,_9874).

noesom([noesom,lit(noe),lit(som)],_9872,_9874) --> 
    cc(noe,_9872,_9893),
    cc(som,_9893,_9874).

noesom([noesom,lit(noe),_9902],_9880,_9882) --> 
    cc(noe,_9880,_9901),
    look_ahead_lit([jeg,du,han,hun],_9902,_9901,_9882).

noesom([noesom,lit(hva),lit(som)],_9872,_9874) --> 
    cc(hva,_9872,_9893),
    cc(som,_9893,_9874).

noesom([noesom,lit(det),_9901,!],_9879,_9881) --> 
    cc(det,_9879,_9900),
    look_ahead_lit([jeg,du],_9901,_9900,_9881),
    !.

np1(_9850,_9851,[np1,lit(det),_9932,!,_9966,_10005],_9904,_9906) --> 
    cc(det,_9904,_9931),
    look_ahead([de],_9932,_9931,_9949),
    !,
    np00(agent,_9850,_9878,_9966,_9949,_9987),
    pushstack(first,[som],nil,_9987,_10015),
    noun_modifiers0(0,_9850,_9878,_9851,_10005,_10015,_9906).

np1(_9850,_9851,[np1,lit(noen),_9932,!,_9966,_10005],_9904,_9906) --> 
    cc(noen,_9904,_9931),
    look_ahead([de],_9932,_9931,_9949),
    !,
    np00(agent,_9850,_9878,_9966,_9949,_9987),
    pushstack(first,[som],nil,_9987,_10015),
    noun_modifiers0(0,_9850,_9878,_9851,_10005,_10015,_9906).

np1(_9850,_9851,[np1,lit(hvilke),_9935,_9974,_10003,!,_10032],_9907,_9909) --> 
    cc(hvilke,_9907,_9934),
    np_kernel(_9875,_9850,_9877,_9935,_9934,_9956),
    not_look_ahead([som],_9974,_9956,_9991),
    look_ahead_np(_10003,_9991,_10018),
    !,
    pushstack(first,[som],nil,_10018,_10042),
    noun_modifiers0(_9875,_9850,_9877,_9851,_10032,_10042,_9909).

np1(_9850,_9851,[np1,lit(hvilke),_9927,_9966,!,_10000],_9899,_9901) --> 
    cc(hvilke,_9899,_9926),
    np_kernel(_9865,_9850,_9867,_9927,_9926,_9948),
    look_ahead([som],_9966,_9948,_9983),
    !,
    noun_modifiers0(_9865,_9850,_9867,_9851,_10000,_9983,_9901).

np1(_9850,_9851,[np1,{},lit(de),_10009,_10038,_10067,_10096,!,_10130,[],_10168,_10216],_9971,_9973) --> 
    {user:value(busflag,true)},
    cc(de,_9971,_10008),
    w(nb(_9897,num),_10009,_10008,_10026),
    flnp(_9900,_10038,_10026,_10055),
    not_look_ahead(w(noun(_9906,_9907,_9908,_9909)),_10067,_10055,_10084),
    w(prep(_9913),_10096,_10084,_10113),
    !,
    accept(_10130,_10113,_10145),
    pushstack(free,w(prep(_9913)),nil,_10145,_10167),[],
    pushstack(first,(w(nb(_9897,num)),w(adj2(_9900,nil)),w(noun(vehicle,sin,u,n))),nil,_10167,_10181),np_kernel(_9883,_9850,_9885,_10168,_10181,_10198),
    noun_modifiers0(_9883,_9850,_9885,_9851,_10216,_10198,_9973).

np1(_9850,_9853::_9854,[np1,_9904,!,_9943],_9887,_9889) --> 
    obviousclock(_9850,_9853::_9854,_9904,_9887,_9923),
    !,
    accept(_9943,_9923,_9889).

np1(_9850,_9851,[np1,{},lit(en),_9986,{},_10025,!,_10059,_10083,_10131],_9948,_9950) --> 
    {user:value(busflag,true)},
    cc(en,_9948,_9985),
    w(nb(_9891,num),_9986,_9985,_10003),
    {user:plausible_busno(_9891)},
    not_look_ahead(w(noun(_9902,_9903,_9904,_9905)),_10025,_10003,_10042),
    !,
    accept(_10059,_10042,_10074),
    pushstack(first,(w(noun(vehicle,sin,u,n)),w(nb(_9891,num))),nil,_10074,_10096),np_kernel(_9877,_9850,_9879,_10083,_10096,_10113),
    noun_modifiers0(_9877,_9850,_9879,_9851,_10131,_10113,_9950).

np1(_9850,_9853::_9854,[np1,_9913,_9952],_9896,_9898) --> 
    np_kernel(_9859,_9850,_9871::_9872,_9913,_9896,_9934),
    noun_modifiers0(_9859,_9850,_9871::_9872,_9853::_9854,_9952,_9934,_9898).

np_kernel(0,_9863:thing,_9854::findpron(_9863:thing)::_9863 isa thing and _9854,[np_kernel,_9921,_9945,!],_9901,_9903) --> 
    dette(_9921,_9901,_9936),
    not_look_ahead_np(_9945,_9936,_9903),
    !.

np_kernel(0,_9863:agent,_9854::findpron(_9863:agent)::_9863 isa agent and _9854,[np_kernel,lit(de),_9962,_9991,_10020,!],_9931,_9933) --> 
    cc(de,_9931,_9961),
    not_look_ahead(w(nb(_9892,_9893)),_9962,_9961,_9979),
    not_look_ahead(w(adj2(_9899,_9900)),_9991,_9979,_10008),
    look_ahead(w(verb(_9906,pres,fin)),_10020,_10008,_9933),
    !.

np_kernel(0,_9851,_9854::_9855,[np_kernel,_9910,!,_9949],_9890,_9892) --> 
    obviousdate(_9851,_9854::_9855,_9910,_9890,_9929),
    !,
    accept(_9949,_9929,_9892).

np_kernel(0,_9863:thing,_9854::findpron(_9863:thing)::_9863 isa thing and _9854,[np_kernel,lit(en),_9950,!],_9919,_9921) --> 
    cc(en,_9919,_9949),
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_9950,_9949,_9921),
    !.

np_kernel(name,_9863:_9864,_9854::findpron(_9863:_9864)::_9863 isa _9864 and _9854,[np_kernel,_9933,_9962,!],_9913,_9915) --> 
    not_look_ahead_lit([de,den,det,et],_9933,_9913,_9950),
    pronoun(_9864,_9962,_9950,_9915),
    !.

np_kernel(0,_9863:thing,_9854::exists(_9863:thing)::_9863 isa thing and _9854,[np_kernel,_9933,_9962,!],_9913,_9915) --> 
    one_of_lit([alt,noe],_9933,_9913,_9950),
    look_ahead_lit([som,'å'],_9962,_9950,_9915),
    !.

np_kernel(_9850,_9851,_9854::_9855,[np_kernel,_9905],_9885,_9887) --> 
    np_head1(_9850,_9851,_9854::_9855,_9905,_9885,_9887).

np_kernel(_9850,_9851,_9852,[np_kernel,_9922,_9951,_9980],_9902,_9904) --> 
    look_ahead(w(name(_9868,n,_9870)),_9922,_9902,_9939),
    not_look_ahead(w(noun(_9876,_9877,_9878,_9879)),_9951,_9939,_9968),
    aname_phrase(_9850,_9851,_9852,_9980,_9968,_9904).

np_kernel(_9850,_9851,_9854::_9855,[np_kernel,_9905],_9885,_9887) --> 
    np_head(_9850,_9851,_9854::_9855,_9905,_9885,_9887).

np_kernel(_9850,_9851,_9854::_9855,[np_kernel,_9916,_9945],_9896,_9898) --> 
    not_look_ahead(w(name(_9871,n,_9873)),_9916,_9896,_9933),
    aname_phrase(_9850,_9851,_9854::_9855,_9945,_9933,_9898).

np_head1(_9850,_9851,_9854::_9855,[np_head1,{},_9947,_9996,_10025,{}],_9917,_9919) --> 
    {user:value(teleflag,true)},
    determiner0(_9881,_9850,_9851,_9874,_9854::_9855,_9947,_9917,_9972),
    preadjs0(_9871,_9996,_9972,_10013),
    noun_list2(_9892,_9851,_9873,_10025,_10013,_9919),
    {user:preadjs_template(_9871,_9851,_9873,_9874)}.

np_head1(0,_9857:_9858,_9854::_9855,[np_head1,{},_9986,_10030,_10084,!,{},{},{}],_9956,_9958) --> 
    {user:value(busflag,true)},
    optional([denne],_9986,_9956,_10018),
    bus_head(_9897,_9883,_9899,_9858,_9901,_9857,_10030,_10018,_10057),
    not_look_ahead_lit([sin,sitt,sine],_10084,_10057,_9958),
    !,
    {user:decide_adjective(_9899,_9857,_9916)},
    {user:_9920=(_9857 isa _9858 and _9916)},
    {user:decide_quantifier(_9883,_9857:_9858,_9920 and _9854,_9855)}.

np_head1(0,_9851,_9854::_9855,[np_head1,{},lit(den),_10000,{},_10039,!,_10073,_10097,!,_10163],_9959,_9961) --> 
    {user:value(busflag,true)},
    cc(den,_9959,_9999),
    w(adj2(_9893,nil),_10000,_9999,_10017),
    {user:testmember(_9893,[first,last,next,previous])},
    look_ahead([som],_10039,_10017,_10056),
    !,
    accept(_10073,_10056,_10088),
    lock(exact,_10088,_10117),pushstack(exact,(w(adj2(_9893,nil)),w(noun(vehicle,sin,u,n))),nil,_10117,_10123),np_head(0,_9851,_9854::_9855,_10097,_10123,_10112),unlock(_10112,_10113),
    !,
    accept(_10163,_10113,_9961).

np_head1(0,_9851,_9854::exists(_9851)::_9860 and _9863 and _9854,[np_head1,_9947,_9976,_10005,{},!,_10074],_9927,_9929) --> 
    not_look_ahead([dere],_9947,_9927,_9964),
    w(name(_9889,_9890,_9891),_9976,_9964,_9993),
    noun(_9893,_9894,_9895,n,_9851,_9863,_10005,_9993,_10032),
    {user:adjnamecomp_template(_9889,_9851,_9860)},
    !,
    accept(_10074,_10032,_9929).

bus_head(_9850,_9851,_9852,_9853,_9853,_9855,[bus_head,_9956,_9990,_10024,{},{},_10078,_10112],_9927,_9929) --> 
    traceprint(5,bx01,_9956,_9927,_9975),
    art0(_9850,_9882,_9990,_9975,_10009),
    quantnext(_9851,_9852,_10024,_10009,_10043),
    {user:_9852\==nil},
    {user:_9851=<5},
    busnumber(_9855,_9853,_10078,_10043,_10097),
    traceprint(4,bh01,_10112,_10097,_9929).

bus_head(_9850,_9851,_9852,_9853,_9854,_9855,[bus_head,_9949,_9983,_10017,{},_10061,_10100],_9920,_9922) --> 
    traceprint(5,bx02,_9949,_9920,_9968),
    art0(_9850,_9879,_9983,_9968,_10002),
    quantnext(_9851,_9852,_10017,_10002,_10036),
    {user:_9851=<5},
    busseno(_9855,_9853,_9854,_10061,_10036,_10082),
    traceprint(4,bh02,_10100,_10082,_9922).

bus_head(_9850,_9851,_9852,_9853,_9853,_9855,[bus_head,_9961,_9995,_10029,{},_10073,_10102,_10126,_10160],_9932,_9934) --> 
    traceprint(5,bx03,_9961,_9932,_9980),
    art0(_9850,_9885,_9995,_9980,_10014),
    quantnext(_9851,_9852,_10029,_10014,_10048),
    {user:_9851=<5},
    not_look_ahead(w(nb(_9899,_9900)),_10073,_10048,_10090),
    nr0(_10102,_10090,_10117),
    busnumber(_9855,_9853,_10126,_10117,_10145),
    traceprint(4,bh03,_10160,_10145,_9934).

bus_head(_9850,_9851,_9852,_9853,_9853,_9855,[bus_head,_9970,_10004,_10038,{},_10082,_10111,_10167,!],_9941,_9943) --> 
    traceprint(5,bx04,_9970,_9941,_9989),
    art0(_9850,_9882,_10004,_9989,_10023),
    quantnext(_9851,_9852,_10038,_10023,_10057),
    {user:_9851=<5},
    look_ahead(w(prep(_9896)),_10082,_10057,_10099),
    lock(exact,_10099,_10131),pushstack(exact,w(noun(bus,plu,def,n)),nil,_10131,_10137),busnumber(_9855,_9853,_10111,_10137,_10126),unlock(_10126,_10127),
    traceprint(4,bh04,_10167,_10127,_9943),
    !.

bus_head(_9850,1,_9852,_9853,_9854,_9855,[bus_head,_9950,_9984,_10018,_10047,_10071,_10105,_10149],_9921,_9923) --> 
    traceprint(5,bx05,_9950,_9921,_9969),
    art0(_9850,_9882,_9984,_9969,_10003),
    flnp(_9852,_10018,_10003,_10035),
    nr1(_10047,_10035,_10062),
    busnumber(_9855,_9854,_10071,_10062,_10090),
    busse0(_9854,_9853,_9891,_9892,_10105,_10090,_10128),
    traceprint(4,bh05,_10149,_10128,_9923).

bus_head(_9850,_9851,nil,_9853,_9854,_9855,[bus_head,_9950,_9984,_10018,_10047,_10071,_10105,_10149],_9921,_9923) --> 
    traceprint(5,bx06,_9950,_9921,_9969),
    art0(_9850,_9882,_9984,_9969,_10003),
    quant(_9851,_10018,_10003,_10035),
    nr1(_10047,_10035,_10062),
    busnumber(_9855,_9854,_10071,_10062,_10090),
    busse0(_9854,_9853,_9891,_9892,_10105,_10090,_10128),
    traceprint(4,bh06,_10149,_10128,_9923).

bus_head(_9850,_9851,nil,_9853,_9854,_9855,[bus_head,_9949,_9983,_10017,_10046,_10085,_10109,_10143],_9920,_9922) --> 
    traceprint(5,bx07,_9949,_9920,_9968),
    art0(_9850,_9882,_9983,_9968,_10002),
    quant(_9851,_10017,_10002,_10034),
    busnoun(_9853,_9887,_9888,_10046,_10034,_10067),
    nr0(_10085,_10067,_10100),
    busnumber(_9855,_9854,_10109,_10100,_10128),
    traceprint(4,bh07,_10143,_10128,_9922).

bus_head(_9850,_9851,nil,_9853,_9854,_9855,[bus_head,_9946,_9980,_10014,_10043,_10077,_10116],_9917,_9919) --> 
    traceprint(5,bx08,_9946,_9917,_9965),
    art0(_9850,_9879,_9980,_9965,_9999),
    quant(_9851,_10014,_9999,_10031),
    busnumber(_9855,_9854,_10043,_10031,_10062),
    busnoun(_9853,_9887,_9888,_10077,_10062,_10098),
    traceprint(4,bh08,_10116,_10098,_9919).

bus_head(_9850,1,_9852,_9853,_9854,_9855,[bus_head,_9949,_9983,_10017,_10046,_10070,_10104,_10143],_9920,_9922) --> 
    traceprint(5,bx09,_9949,_9920,_9968),
    art0(_9850,_9882,_9983,_9968,_10002),
    filanepr(_9852,_10017,_10002,_10034),
    nr1(_10046,_10034,_10061),
    busnumber(_9855,_9854,_10070,_10061,_10089),
    busnoun(_9853,_9890,_9891,_10104,_10089,_10125),
    traceprint(4,bh09,_10143,_10125,_9922).

bus_head(_9850,1,_9852,route,_9854,_9855,[bus_head,_9950,_9984,{},_10028,_10057,_10081,_10115],_9921,_9923) --> 
    traceprint(5,bx10,_9950,_9921,_9969),
    art0(_9850,_9882,_9984,_9969,_10003),
    {user:_9882\==plu},
    filanepr(_9852,_10028,_10003,_10045),
    nr1(_10057,_10045,_10072),
    busnumber(_9855,_9854,_10081,_10072,_10100),
    traceprint(4,bh10,_10115,_10100,_9923).

bus_head(_9850,1,_9852,_9853,_9854,_9855,[bus_head,_9972,_10006,{},_10050,_10079,_10118,_10142,_10166,_10200,_10229],_9943,_9945) --> 
    traceprint(5,bx11,_9972,_9943,_9991),
    art0(_9850,_9891,_10006,_9991,_10025),
    {user:_9891\==plu},
    filanepr(_9852,_10050,_10025,_10067),
    busnoun(_9853,_9901,_9902,_10079,_10067,_10100),
    nr0(_10118,_10100,_10133),
    colon0(_10142,_10133,_10157),
    busnumber(_9855,_9854,_10166,_10157,_10185),
    not_look_ahead(w(noun(minute,_9912,_9913,_9914)),_10200,_10185,_10217),
    traceprint(4,bh11,_10229,_10217,_9945).

bus_head(_9850,_9851,_9852,_9853,_9854,_9855,[bus_head,_9955,_9989,_10023,{},_10067,_10106,_10140],_9926,_9928) --> 
    traceprint(5,bx12,_9955,_9926,_9974),
    art0(_9850,_9882,_9989,_9974,_10008),
    quantnext(_9851,_9852,_10023,_10008,_10042),
    {user:_9851<10},
    busnoun(_9853,_9893,plu,_10067,_10042,_10088),
    busnumber(_9855,_9854,_10106,_10088,_10125),
    traceprint(4,bh12,_10140,_10125,_9928).

bus_head(_9850,_9851,_9852,_9853,nil,_9855,[bus_head,_9949,_9983,_10017,{},_10061,_10100],_9920,_9922) --> 
    traceprint(5,bx13,_9949,_9920,_9968),
    art0(_9850,plu,_9983,_9968,_10002),
    quantnext(_9851,_9852,_10017,_10002,_10036),
    {user:_9851<100},
    busnoun(_9853,_9890,_9891,_10061,_10036,_10082),
    traceprint(4,bh13,_10100,_10082,_9922).

bus_head(_9850,_9851,_9852,_9853,nil,_9855,[bus_head,_9949,_9983,_10017,{},_10061,_10100],_9920,_9922) --> 
    traceprint(5,bx14,_9949,_9920,_9968),
    art0(_9850,_9879,_9983,_9968,_10002),
    quantnext(_9851,_9852,_10017,_10002,_10036),
    {user:_9851=<5},
    busnoun(_9853,_9890,plu,_10061,_10036,_10082),
    traceprint(4,bh14,_10100,_10082,_9922).

bus_head(_9850,1,_9852,_9853,_9854,_9855,[bus_head,_9959,_9993,_10027,_10056,{},_10100,_10139],_9930,_9932) --> 
    traceprint(5,bx15,_9959,_9930,_9978),
    art0(_9850,_9882,_9993,_9978,_10012),
    filanepr(_9852,_10027,_10012,_10044),
    busnumber(_9855,_9854,_10056,_10044,_10075),
    {user:(number(_9855),_9855>5)},
    busnoun(_9853,_9900,_9901,_10100,_10075,_10121),
    traceprint(4,bh15,_10139,_10121,_9932).

bus_head(_9850,1,_9852,_9853,_9854,_9855,[bus_head,_9954,_9988,_10022,_10051,{},_10095,_10134],_9925,_9927) --> 
    traceprint(5,bx16,_9954,_9925,_9973),
    art0(_9850,_9882,_9988,_9973,_10007),
    filanepr(_9852,_10022,_10007,_10039),
    busnumber(_9855,_9854,_10051,_10039,_10070),
    {user:_9855\==1},
    busnoun(_9853,_9895,sin,_10095,_10070,_10116),
    traceprint(4,bh16,_10134,_10116,_9927).

bus_head(u,1,nil,bus,number,_9855,[bus_head,_9967,_10001,_10030,{},_10069,_10108],_9938,_9940) --> 
    traceprint(5,bx17,_9967,_9938,_9986),
    not_look_ahead(w(name(_9882,n,route)),_10001,_9986,_10018),
    w(nb(_9855,num),_10030,_10018,_10047),
    {user:(number(_9855),_9855>5,_9855=<9999)},
    busnoun(bus,def,sin,_10069,_10047,_10090),
    traceprint(4,bh17,_10108,_10090,_9940).

bus_head(def,_9851,_9852,route,nil,_9855,[bus_head,_9944,lit(de),_9989,{},_10033,_10057],_9915,_9917) --> 
    traceprint(5,bx18,_9944,_9915,_9963),
    cc(de,_9963,_9988),
    quantnext(_9851,_9852,_9989,_9988,_10008),
    {user:_9851=<5},
    not_look_ahead_np(_10033,_10008,_10048),
    traceprint(4,bh18,_10057,_10048,_9917).

bus_head(_9850,_9851,_9852,route,nil,_9855,[bus_head,_9962,_9996,_10030,{},{},_10084,_10108,!],_9933,_9935) --> 
    traceprint(5,bx19,_9962,_9933,_9981),
    art0(_9850,_9882,_9996,_9981,_10015),
    quantnext(_9851,_9852,_10030,_10015,_10049),
    {user:_9852\==nil},
    {user:(_9851>0,_9851=<5)},
    not_look_ahead_np(_10084,_10049,_10099),
    traceprint(4,bh19,_10108,_10099,_9935),
    !.

bus_head(_9850,1,_9852,_9853,_9854,_9855,[bus_head,_9964,_9998,_10032,_10061,_10100,_10124,_10148,_10182,_10211],_9935,_9937) --> 
    traceprint(5,bx20,_9964,_9935,_9983),
    art0(_9850,_9888,_9998,_9983,_10017),
    filanepr(_9852,_10032,_10017,_10049),
    busnoun(_9853,_9893,sin,_10061,_10049,_10082),
    nr0(_10100,_10082,_10115),
    colon0(_10124,_10115,_10139),
    busnumber(_9855,_9854,_10148,_10139,_10167),
    not_look_ahead(w(noun(minute,_9904,_9905,_9906)),_10182,_10167,_10199),
    traceprint(4,bh20,_10211,_10199,_9937).

art0(u,plu,[art0,lit(noen),_9908,!],_9880,_9882) --> 
    cc(noen,_9880,_9907),
    look_ahead_np(_9908,_9907,_9882),
    !.

art0(u,sin,[art0,lit(noe),!],_9877,_9879) --> 
    cc(noe,_9877,_9879),
    !.

art0(_9850,_9851,[art0,_9895,!],_9878,_9880) --> 
    art(_9850,_9851,_9895,_9878,_9880),
    !.

art0(u,nil,[art0,[]],_9872,_9872) --> 
    [].

art(u,sin,[art,lit(en),!],_9877,_9879) --> 
    cc(en,_9877,_9879),
    !.

art(u,sin,[art,lit(et),!],_9877,_9879) --> 
    cc(et,_9877,_9879),
    !.

art(u,sin,[art,lit(ei),!],_9877,_9879) --> 
    cc(ei,_9877,_9879),
    !.

art(def,sin,[art,lit(den),!],_9877,_9879) --> 
    cc(den,_9877,_9879),
    !.

art(def,plu,[art,lit(det),!],_9877,_9879) --> 
    cc(det,_9877,_9879),
    !.

art(def,plu,[art,lit(de),!],_9877,_9879) --> 
    cc(de,_9877,_9879),
    !.

quantnext(_9850,_9851,[quantnext,_9899,_9928,!],_9882,_9884) --> 
    quant(_9850,_9899,_9882,_9916),
    filanepr(_9851,_9928,_9916,_9884),
    !.

quantnext(_9850,_9851,[quantnext,_9899,_9928,!],_9882,_9884) --> 
    filanepr(_9851,_9899,_9882,_9916),
    quant(_9850,_9928,_9916,_9884),
    !.

quant00(1,[quant00,[]],_9869,_9869) --> 
    [].

quant(_9850,[quant,_9888],_9874,_9876) --> 
    w(nb(_9850,num),_9888,_9874,_9876).

filanepr(_9850,[filanepr,_9888,!],_9874,_9876) --> 
    flnp(_9850,_9888,_9874,_9876),
    !.

filanepr(nil,[filanepr,[]],_9869,_9869) --> 
    [].

busseno(_9850,_9851,_9852,[busseno,_9914,_9953,_9977,_10001,!],_9894,_9896) --> 
    busnoun(_9851,_9867,_9868,_9914,_9894,_9935),
    nr0(_9953,_9935,_9968),
    colon0(_9977,_9968,_9992),
    busnumber(_9850,_9852,_10001,_9992,_9896),
    !.

busseno(_9850,_9851,_9852,[busseno,_9911,_9935,_9969,!],_9891,_9893) --> 
    nr0(_9911,_9891,_9926),
    busnumber(_9850,_9852,_9935,_9926,_9954),
    busnoun(_9851,_9867,_9868,_9969,_9954,_9893),
    !.

busnumber(_9850,_9851,[busnumber,_10005,_10049,{},_10088,_10117,_10146,_10170,_10199,_10228,_10257,_10286,_10315],_9988,_9990) --> 
    optional(w(noun(route,sin,u,n)),_10005,_9988,_10037),
    w(name(_9850,n,_9851),_10049,_10037,_10066),
    {user:test(subclass0(_9851,vehicle))},
    not_look_ahead(w(noun(minute,_9921,_9922,_9923)),_10088,_10066,_10105),
    not_look_ahead([:],_10117,_10105,_10134),
    point0(_10146,_10134,_10161),
    not_look_ahead(w(name(_9933,_9934,month)),_10170,_10161,_10187),
    not_look_ahead(w(name(_9933,_9942,day)),_10199,_10187,_10216),
    not_look_ahead(w(name(whitsun_day,_9950,date)),_10228,_10216,_10245),
    not_look_ahead(w(name(christmas_day,_9958,date)),_10257,_10245,_10274),
    not_look_ahead(w(name(easterday,_9966,date)),_10286,_10274,_10303),
    not_look_ahead(w(name(new_years_day,_9891,date)),_10315,_10303,_9990).

busnumber(_9850,number,[busnumber,_9994,_10038,_10067,_10096,_10125,_10149,_10178,_10207,_10236,_10265,_10294],_9977,_9979) --> 
    optional(w(noun(route,sin,u,n)),_9994,_9977,_10026),
    w(nb(_9850,num),_10038,_10026,_10055),
    not_look_ahead(w(noun(minute,_9910,_9911,_9912)),_10067,_10055,_10084),
    not_look_ahead([:],_10096,_10084,_10113),
    point0(_10125,_10113,_10140),
    not_look_ahead(w(name(_9922,_9923,month)),_10149,_10140,_10166),
    not_look_ahead(w(name(_9922,_9931,day)),_10178,_10166,_10195),
    not_look_ahead(w(name(whitsun_day,_9939,date)),_10207,_10195,_10224),
    not_look_ahead(w(name(christmas_day,_9947,date)),_10236,_10224,_10253),
    not_look_ahead(w(name(easterday,_9955,date)),_10265,_10253,_10282),
    not_look_ahead(w(name(new_years_day,_9888,date)),_10294,_10282,_9979).

busse0(_9850,_9851,_9852,_9853,[busse0,_9908,!],_9885,_9887) --> 
    busnoun(_9851,_9852,_9853,_9908,_9885,_9887),
    !.

busse0(_9850,_9850,u,sin,[busse0,[]],_9878,_9878) --> 
    [].

busnoun(_9850,_9851,_9852,[busnoun,_9924,!,{},_9968],_9904,_9906) --> 
    w(noun(_9850,_9852,_9851,n),_9924,_9904,_9941),
    !,
    {user:(test(subclass0(_9850,vehicle));_9850=number)},
    point0(_9968,_9941,_9906).

aname_phrase(0,_9851,_9854::_9854 and _9858,[aname_phrase,_9939,_9963,_9992,_10021,{},!],_9919,_9921) --> 
    a0(_9939,_9919,_9954),
    look_ahead(w(name(_9879,n,_9881)),_9963,_9954,_9980),
    preadjs(_9883,_9992,_9980,_10009),
    noun2(_9885,_9886,n,_9851,_9889,_10021,_10009,_9921),
    {user:preadjs_template(_9883,_9851,_9889,_9858)},
    !.

aname_phrase(_9850,_9851,_9854::_9854 and _9858,[aname_phrase,_9942,_9971,lit(gang),!,_10016,_10040],_9922,_9924) --> 
    w(name(_9880,n,route),_9942,_9922,_9959),
    w(adj2(next,nil),_9971,_9959,_9988),
    cc(gang,_9988,_10010),
    !,
    accept(_10016,_10010,_10031),
    pushstack(first,w(name(_9880,n,route)),nil,_10031,_10050),
    namep(_9850,_9851,_9858,_10040,_10050,_9924).

aname_phrase(_9850,_9851,_9852,[aname_phrase,_9915,_9944,_9973,!,_10002],_9895,_9897) --> 
    number(_9866,_9915,_9895,_9932),
    not_look_ahead(w(prep(from)),_9944,_9932,_9961),
    filanepr(_9973,_9961,_9988),
    !,
    reject(_10002,_9988,_9897).

aname_phrase(_9850,_9851,_9852,[aname_phrase,_9929,_9953,_9977,_10006,{},!,_10050],_9909,_9911) --> 
    dent0(_9929,_9909,_9944),
    filanepr(_9953,_9944,_9968),
    bus_number(_9872,_9977,_9968,_9994),
    w(noun(_9876,plu,_9878,_9879),_10006,_9994,_10023),
    {user:testmember(_9876,[bus])},
    !,
    reject(_10050,_10023,_9911).

aname_phrase(_9850,_9851,_9852,[aname_phrase,_9935,_9959,_9988,_10022,{},!,_10066],_9915,_9917) --> 
    dent0(_9935,_9915,_9950),
    w(adj2(_9874,nil),_9959,_9950,_9976),
    gmem(_9874,[nearest],_9988,_9976,_10007),
    w(name(_9884,_9885,_9886),_10022,_10007,_10039),
    {user:(\+number(_9884))},
    !,
    reject(_10066,_10039,_9917).

aname_phrase(_9850,_9851,_9854::_9855,[aname_phrase,_9937,_9961,_9990,_10019,_10048,{}],_9917,_9919) --> 
    a0(_9937,_9917,_9952),
    preadjs0(_9874,_9961,_9952,_9978),
    not_look_ahead([jeg],_9990,_9978,_10007),
    not_look_ahead([du],_10019,_10007,_10036),
    name_phrase(_9850,_9851,_9854::_9876,_10048,_10036,_9919),
    {user:preadjs_template(_9874,_9851,_9876,_9855)}.

aname_phrase(_9850,_9851,_9854::_9855,[aname_phrase,_9915,_9944,_9968],_9895,_9897) --> 
    not_look_ahead([ett],_9915,_9895,_9932),
    a0(_9944,_9932,_9959),
    name_phrase(_9850,_9851,_9854::_9855,_9968,_9959,_9897).

aname_phrase(name,_9851,_9852,[aname_phrase,_9899],_9879,_9881) --> 
    person_name(_9851,_9852,_9856,_9899,_9879,_9881).

name_phrase(0,_9851,_9854::_9855,[name_phrase,_9993,_10022,_10051,_10080,_10104,_10133,!,{},{},_10187],_9973,_9975) --> 
    w(noun(time,sin,def,n),_9993,_9973,_10010),
    w(nb(_9904,num),_10022,_10010,_10039),
    w(nb(_9909,num),_10051,_10039,_10068),
    to0(_10080,_10068,_10095),
    w(nb(_9914,num),_10104,_10095,_10121),
    w(nb(_9919,num),_10133,_10121,_10150),
    !,
    {user:_9924 is _9904*100+_9909},
    {user:_9893 is _9914*100+_9919},
    lock(exact,_10150,_10300),
    pushstack(exact,(time1(_9924),and1,time1(_9893)),nil,_10300,_10306),
    noun_phrases(_9851,_9854::_9855,_10187,_10306,_10295),
    unlock(_10295,_9975).

name_phrase(0,_9851,_9854::_9855,[name_phrase,_9943,_9972,_10001,_10025,!,_10059],_9923,_9925) --> 
    w(noun(time,sin,def,n),_9943,_9923,_9960),
    timexp(_9890,_9972,_9960,_9989),
    to0(_10001,_9989,_10016),
    timexp(_9881,_10025,_10016,_10042),
    !,
    pushstack(first,(time1(_9890),and1,time1(_9881)),nil,_10042,_10157),
    noun_phrases(_9851,_9854::_9855,_10059,_10157,_9925).

name_phrase(_9850,_9851,_9854::_9857 and _9854,[name_phrase,_9927,_9956,_9995],_9907,_9909) --> 
    look_ahead(w(nb(_9879,_9880)),_9927,_9907,_9944),
    namep(_9850,_9851,_9857,_9956,_9944,_9977),
    not_look_ahead(w(noun(minute,_9871,_9872,_9873)),_9995,_9977,_9909).

name_phrase(_9850,_9851,_9854::_9857 and _9854,[name_phrase,_9927,_9956,_9995],_9907,_9909) --> 
    look_ahead(w(nb(_9879,_9880)),_9927,_9907,_9944),
    namep(_9850,_9851,_9857,_9956,_9944,_9977),
    not_look_ahead(w(noun(minute,_9871,_9872,_9873)),_9995,_9977,_9909).

name_phrase(_9850,_9851,_9854::_9857 and _9854,[name_phrase,_9905],_9885,_9887) --> 
    namep(_9850,_9851,_9857,_9905,_9885,_9887).

person_name((_9857,_9860,_9861):person,_9863 and _9866 and _9867,_9852,[person_name,_9934,_9973,_10012,!,_10056],_9914,_9916) --> 
    properfirstname(_9857,_9863,_9883,_9934,_9914,_9955),
    properfirstname(_9860,_9866,_9887,_9973,_9955,_9994),
    properlastname(_9861,_9867,_9852,_10012,_9994,_10033),
    !,
    accept(_10056,_10033,_9916).

person_name((_9857,_9858):person,_9860 and _9861,_9852,[person_name,_9921,_9960,!,_10004],_9901,_9903) --> 
    properfirstname(_9857,_9860,_9874,_9921,_9901,_9942),
    properlastname(_9858,_9861,_9852,_9960,_9942,_9981),
    !,
    accept(_10004,_9981,_9903).

properfirstname('Rønning','RønningP',_9852,[properfirstname,_9902],_9882,_9884) --> 
    name1g('Rønning':firstname,'RønningP',_9852,_9902,_9882,_9884).

properlastname('Rønning','RønningP',_9852,[properlastname,_9902],_9882,_9884) --> 
    name1g('Rønning':lastname,'RønningP',_9852,_9902,_9882,_9884).

np_head(_9850,_9851,_9852,[np_head,lit(ett),_9924,!,_9958],_9893,_9895) --> 
    cc(ett,_9893,_9923),
    w(noun(time,_9868,def,_9870),_9924,_9923,_9941),
    !,
    reject(_9958,_9941,_9895).

np_head(0,_9851,_9854::_9855,[np_head,_9951,_9975,_10004,!,_10048,_10077,{},{}],_9931,_9933) --> 
    the0(_9951,_9931,_9966),
    preadjs0(_9885,_9975,_9966,_9992),
    quantifier(_9851,_9883,_9883 and _9854::_9855,_10004,_9992,_10025),
    !,
    preadjs0(_9880,_10048,_10025,_10065),
    noun_complex(_9899,_9851,_9901,_10077,_10065,_9933),
    {user:preadjs_template(_9885,_9851,_9901,_9882)},
    {user:preadjs_template(_9880,_9851,_9882,_9883)}.

np_head(_9850,_9851,_9852,[np_head,_9955,_10004,{},_10043,_10072,{}],_9935,_9937) --> 
    determiner0(_9876,_9850,_9851,_9874,_9852,_9955,_9935,_9980),
    preadjs0(_9871,_10004,_9980,_10021),
    {user:(_9871=true->_9889=_9876;_9889=_9890)},
    not_look_ahead(w(noun(crown,_9906,_9907,_9908)),_10043,_10021,_10060),
    noun_complex(_9889,_9851,_9873,_10072,_10060,_9937),
    {user:preadjs_template(_9871,_9851,_9873,_9874)}.

np_head(0,_9851,_9854::findpron(_9869)::exists(_9851)::_9863 and _9866 and _9854,[np_head,_9955,_9979,_10033,!,_10067,{}],_9935,_9937) --> 
    thispron(_9955,_9935,_9970),
    noun(_9894,_9895,_9896,gen,_9869,_9866,_9979,_9970,_10006),
    look_ahead(w(nb(_9905,num)),_10033,_10006,_10050),
    !,
    np0_accept(_9851,_9892::_9863,_10067,_10050,_9937),
    {user:has_template(_9869,_9851,_9892)}.

np_head(0,_9851,_9854::findpron(_9875)::exists(_9851)::_9863 and _9866 and _9869 and _9872 and _9854,[np_head,_9967,_9991,!,_10050,_10079,_10118,{},{}],_9947,_9949) --> 
    thispron(_9967,_9947,_9982),
    noun(_9906,_9907,_9908,gen,_9875,_9869,_9991,_9982,_10018),
    !,
    preadjs0(_9913,_10050,_10018,_10067),
    noun_compound(_9851,_9866,_9917,_10079,_10067,_10100),
    not_look_aheadnounx(_10118,_10100,_9949),
    {user:preadjs_template(_9913,_9851,_9866,_9863)},
    {user:has_template(_9875,_9851,_9872)}.

not_look_aheadnounx([not_look_aheadnounx,_9887,!],_9876,_9878) --> 
    look_ahead(w(verb(_9857,_9858,fin)),_9887,_9876,_9878),
    !.

not_look_aheadnounx([not_look_aheadnounx,_9888,!],_9877,_9879) --> 
    look_ahead(w(noun(clock,_9858,_9859,_9860)),_9888,_9877,_9879),
    !.

not_look_aheadnounx([not_look_aheadnounx,_9885],_9874,_9876) --> 
    not_look_ahead(w(noun(_9854,_9855,_9856,_9857)),_9885,_9874,_9876).

noun_complex(_9850,_9854:_9855,_9854 isa _9855,[noun_complex,_9950,_9979,_10008,_10037,{},!],_9930,_9932) --> 
    not_look_ahead(w(nb(_9879,_9880)),_9950,_9930,_9967),
    w(name(_9854,n,_9886),_9979,_9967,_9996),
    not_look_ahead(w(verb(_9892,pres,fin)),_10008,_9996,_10025),
    w(noun(_9898,_9850,_9900,n),_10037,_10025,_9932),
    {user:joinclass(_9898,_9886,_9855)},
    !.

noun_complex(sin,_9854:_9855,_9854 isa _9855,[noun_complex,_9918,_9947,!],_9898,_9900) --> 
    w(noun(_9855,sin,_9870,n),_9918,_9898,_9935),
    w(quote(_9854),_9947,_9935,_9900),
    !.

noun_complex(sin,_9854:_9858,_9854 isa _9855,[noun_complex,_9968,_9997,_10026,_10055,_10084,_10108,{},!],_9948,_9950) --> 
    w(noun(_9855,sin,_9885,n),_9968,_9948,_9985),
    not_look_ahead([du],_9997,_9985,_10014),
    w(name(_9854,n,_9896),_10026,_10014,_10043),
    not_look_ahead(w(noun(minute,_9903,_9904,_9905)),_10055,_10043,_10072),
    point0(_10084,_10072,_10099),
    not_look_ahead(w(name(_9911,_9912,date)),_10108,_10099,_9950),
    {user:(joinclass(_9855,_9896,_9858),_9858\==nil)},
    !.

noun_complex(sin,_9854:_9855,_9854 isa _9855,[noun_complex,_9950,_9979,{},_10018,_10042,!],_9930,_9932) --> 
    w(noun(_9855,_9878,_9879,n),_9950,_9930,_9967),
    w(nb(_9854,num),_9979,_9967,_9996),
    {user:testmember(_9855,[footnote,page,sms,telephone,week,year])},
    and1(_10018,_9996,_10033),
    w(nb(_9906,_9907),_10042,_10033,_9932),
    !.

noun_complex(_9850,_9854:_9855,_9854 isa _9855,[noun_complex,_9941,_9970,{},!],_9921,_9923) --> 
    w(noun(_9855,_9850,_9873,n),_9941,_9921,_9958),
    w(nb(_9854,num),_9970,_9958,_9923),
    {user:testmember(_9855,[footnote,page,sms,telephone,week,year,number])},
    !.

noun_complex(_9850,_9854:_9855,_9854 isa _9855,[noun_complex,_9986,{},_10025,_10059,_10088,_10122,_10151,_10180,_10209,!,_10243],_9966,_9968) --> 
    w(noun(_9855,_9850,_9894,n),_9986,_9966,_10003),
    {user:subtype0(_9855,vehicle)},
    plausibleno(_9855,_9854,_10025,_10003,_10044),
    not_look_ahead([ganger],_10059,_10044,_10076),
    plausibleno(_9855,_9854,_10088,_10076,_10107),
    not_look_ahead_lit([sin,sitt,sine],_10122,_10107,_10139),
    not_look_ahead(w(name(_9924,_9925,month)),_10151,_10139,_10168),
    not_look_ahead(w(name(_9924,_9933,date)),_10180,_10168,_10197),
    not_look_ahead(w(noun(_9940,plu,_9942,_9943)),_10209,_10197,_10226),
    !,
    accept(_10243,_10226,_9968).

noun_complex(plu,_9854:_9855,_9854 isa _9855,[noun_complex,_9922,_9956,{}],_9902,_9904) --> 
    plausibleno(_9855,_9854,_9922,_9902,_9941),
    w(noun(_9855,sin,u,n),_9956,_9941,_9904),
    {user:subtype0(_9855,vehicle)}.

noun_complex(_9850,_9851,_9852,[noun_complex,_9920,_9959,_9988],_9900,_9902) --> 
    noun_list(_9850,_9851,_9852,_9920,_9900,_9941),
    not_look_ahead_lit([sin,sitt,sine],_9959,_9941,_9976),
    not_look_ahead(w(nb(_9864,_9865)),_9988,_9976,_9902).

noun_complex(_9850,_9851,_9852,[noun_complex,_9913,_9942,_9971],_9893,_9895) --> 
    not_look_ahead([noe],_9913,_9893,_9930),
    not_look_ahead([min],_9942,_9930,_9959),
    noun_compound(_9851,_9852,_9850,_9971,_9959,_9895).

plausibleno(_9850,_9851,[plausibleno,_9903,_9932,_9956,!,_9985],_9886,_9888) --> 
    num(_9865,_9903,_9886,_9920),
    point(_9932,_9920,_9947),
    monthnamex(_9956,_9947,_9971),
    !,
    reject(_9985,_9971,_9888).

plausibleno(_9850,_9851,[plausibleno,_9900,_9929,!,_9958],_9883,_9885) --> 
    num(_9862,_9900,_9883,_9917),
    colon(_9929,_9917,_9944),
    !,
    reject(_9958,_9944,_9885).

plausibleno(_9850,_9851,[plausibleno,_9902,_9931,!,_9965],_9885,_9887) --> 
    num(_9862,_9902,_9885,_9919),
    monthname(_9864,_9931,_9919,_9948),
    !,
    reject(_9965,_9948,_9887).

plausibleno(_9850,_9851,[plausibleno,_9908,_9932,{}],_9891,_9893) --> 
    nr0(_9908,_9891,_9923),
    num(_9851,_9932,_9923,_9893),
    {user:(_9851>0,_9851<1000)}.

plausibleno(_9850,_9851,[plausibleno,_9905,_9929,{}],_9888,_9890) --> 
    nr0(_9905,_9888,_9920),
    w(nb(_9851,alf),_9929,_9920,_9890),
    {user:_9851<1000}.

npa(_9862:_9863,_9853::findexternal(_9862:_9863)::_9862 isa _9863 and _9853,[npa,_9935,_9964,!,{}],_9918,_9920) --> 
    one_of_lit([det,dette],_9935,_9918,_9952),
    look_ahead(w(adv(_9897)),_9964,_9952,_9920),
    !,
    {user:_9863=thing}.

npa(_9862:_9863,_9853::findexternal(_9862:_9863)::_9862 isa _9863 and _9853,[npa,lit(dette),_9933,{}],_9905,_9907) --> 
    cc(dette,_9905,_9932),
    not_look_ahead_np(_9933,_9932,_9907),
    {user:_9863=thing}.

npa(_9862:_9863,_9853::findexternal(_9862:thing)::_9862 isa _9863 and _9853,[npa,lit(det),_9936,_9965],_9908,_9910) --> 
    cc(det,_9908,_9935),
    look_ahead(w(verb(_9885,_9886,fin)),_9936,_9935,_9953),
    not_look_ahead_np(_9965,_9953,_9910).

npa(_9850,_9853::findit(_9859)::_9857,[npa,_9926,_9950,_9989,{}],_9909,_9911) --> 
    its(_9926,_9909,_9941),
    determiner00(_9850,_9883 and _9874,_9853::_9857,_9950,_9941,_9971),
    noun_compound(_9850,_9883,_9888,_9989,_9971,_9911),
    {user:has_template(_9859,_9850,_9874)}.

npa(_9850,_9851,[npa,_9898,_9922,!,_9951],_9881,_9883) --> 
    this(_9898,_9881,_9913),
    look_ahead_np(_9922,_9913,_9937),
    !,
    reject(_9951,_9937,_9883).

npa(_9850,_9853::find(_9850)::_9859 and _9853,[npa,_9907],_9890,_9892) --> 
    noun(_9864,_9865,def,n,_9850,_9859,_9907,_9890,_9892).

npa(_9862:_9863,_9853::findexternal(_9862:_9863)::_9862 isa _9871 and _9853,[npa,lit(denne),_9957,_9986,{},{}],_9929,_9931) --> 
    cc(denne,_9929,_9956),
    not_look_ahead(w(adj),_9957,_9956,_9974),
    not_look_ahead(w(noun(_9900,_9901,_9902,_9903)),_9986,_9974,_9931),
    {user:_9871=thing},
    {user:type(_9871,_9863)}.

npa(_9862:_9863,_9853::findpron(_9862:_9863)::_9862 isa thing and _9853,[npa,lit(det),_9933,{}],_9905,_9907) --> 
    cc(det,_9905,_9932),
    endofline(_9933,_9932,_9907),
    {user:type(thing,_9863)}.

npa(_9850,_9853::_9854,[npa,_9935,_9959,_9988,_10017],_9918,_9920) --> 
    allsome0(_9935,_9918,_9950),
    posspron(_9879,_9959,_9950,_9976),
    w(nb(_9876,num),_9988,_9976,_10005),
    pushstack(first,(thispron,w(noun(_9879,sin,u,gen)),w(nb(_9876,num))),nil,_10005,_10058),
    np1(_9850,_9853::_9854,_10017,_10058,_9920).

npa(_9850,_9853::_9854,[npa,_9919,_9943,_9972],_9902,_9904) --> 
    allsome0(_9919,_9902,_9934),
    posspron(_9870,_9943,_9934,_9960),
    pushstack(first,(thispron,w(noun(_9870,sin,u,gen))),nil,_9960,_10010),
    np1(_9850,_9853::_9854,_9972,_10010,_9904).

npa(_9850,_9851,[npa,lit(de),_9973,_10002,_10031,_10060,!,_10094],_9945,_9947) --> 
    cc(de,_9945,_9972),
    w(nb(_9891,num),_9973,_9972,_9990),
    flnp(_9894,_10002,_9990,_10019),
    not_look_ahead(w(name(_9900,_9901,_9902)),_10031,_10019,_10048),
    not_look_ahead(w(noun(_9908,_9909,_9910,_9911)),_10060,_10048,_10077),
    !,
    pushstack(first,(w(nb(_9891,num)),w(adj2(_9894,nil)),w(noun(vehicle,sin,u,n))),nil,_10077,_10104),
    np1(_9850,_9851,_10094,_10104,_9947).

npa(_9850,_9853::_9854,[npa,_9978,_10002,_10031,_10060,_10089,_10118,_10142,_10171,!,_10205],_9961,_9963) --> 
    dent0(_9978,_9961,_9993),
    not_look_ahead(['først'],_10002,_9993,_10019),
    not_look_ahead([sist],_10031,_10019,_10048),
    not_look_ahead([senest],_10060,_10048,_10077),
    not_look_ahead([tidligst],_10089,_10077,_10106),
    nest(_10118,_10106,_10133),
    flnp(_9915,_10142,_10133,_10159),
    not_look_ahead(w(noun(_9921,_9922,_9923,_9924)),_10171,_10159,_10188),
    !,
    pushstack(first,(w(adj2(second,nil)),w(adj2(_9915,nil)),w(noun(vehicle,sin,u,n))),nil,_10188,_10215),
    np1(_9850,_9853::_9854,_10205,_10215,_9963).

npa(_9850,_9853::_9854,[npa,_9982,_10006,_10035,_10064,_10093,!,_10127,_10198],_9965,_9967) --> 
    dent0(_9982,_9965,_9997),
    not_look_ahead([f,s,'først',sist,senest,tidligst],_10006,_9997,_10023),
    flnp(_9900,_10035,_10023,_10052),
    not_look_ahead(w(name(_9906,_9907,_9908)),_10064,_10052,_10081),
    not_look_ahead(w(noun(_9914,_9915,_9916,_9917)),_10093,_10081,_10110),
    !,
    pushstack(first,(a,w(adj2(_9900,nil)),w(noun(vehicle,sin,u,n))),nil,_10110,_10168),np1(_9850,_9853::_9854,_10127,_10168,_10183),
    optional(w(noun(bus,sin,_9883,_9884)),_10198,_10183,_9967).

npa(_9850,_9851,[npa,{},lit(den),_9951,_9980,!,_10014],_9913,_9915) --> 
    {user:value(busflag,true)},
    cc(den,_9913,_9950),
    not_look_ahead(w(adj2(_9882,nil)),_9951,_9950,_9968),
    not_look_ahead(w(noun(_9889,_9890,_9891,_9892)),_9980,_9968,_9997),
    !,
    npit(_9850,_9851,_10014,_9997,_9915).

npa(_9850,_9853::_9854,[npa,lit(den),_9952,_9981,!,_10015],_9924,_9926) --> 
    cc(den,_9924,_9951),
    not_look_ahead(w(adj2(_9887,nil)),_9952,_9951,_9969),
    not_look_ahead(w(noun(_9894,_9895,_9896,_9897)),_9981,_9969,_9998),
    !,
    lock(exact,_9998,_10060),
    pushstack(exact,(this,w(noun(thing,sin,u,n))),nil,_10060,_10066),
    np1(_9850,_9853::_9854,_10015,_10066,_10055),
    unlock(_10055,_9926).

npit(_9859:_9860,_9853::_9859 isa _9860 and _9853,[npit,{}],_9891,_9891) --> 
    {user:it_template(_9859:_9860)}.

adjnoun([adjnoun,_9881],_9870,_9872) --> 
    w(adj2(nil,nil),_9881,_9870,_9872).

adjnoun([adjnoun,_9883],_9872,_9874) --> 
    w(noun(_9852,plu,u,_9855),_9883,_9872,_9874).

np2(_9850,_9851,[np2,lit(noe),_9941,_9970,!,_9999],_9913,_9915) --> 
    cc(noe,_9913,_9940),
    w(adj2(_9882,_9883),_9941,_9940,_9958),
    not_look_ahead_np(_9970,_9958,_9985),
    !,
    lock(exact,_9985,_10016),
    pushstack(exact,(w(adj2(_9882,_9883)),w(noun(thing,sin,u,n))),nil,_10016,_10022),
    np_kernel(0,_9850,_9851,_9999,_10022,_10011),
    unlock(_10011,_9915).

np2(_9850,_9851,[np2,lit(noe),_9939,!,_9973,_10034],_9911,_9913) --> 
    cc(noe,_9911,_9938),
    look_ahead(w(prep(_9876)),_9939,_9938,_9956),
    !,
    lock(exact,_9956,_9993),pushstack(exact,w(noun(thing,sin,u,n)),nil,_9993,_9999),np_kernel(0,_9850,_9867,_9973,_9999,_9988),unlock(_9988,_9989),
    noun_modifiers0(0,_9850,_9867,_9851,_10034,_9989,_9913).

np2(_9850,_9851,[np2,_9961,_9995,{},!,_10039,!],_9944,_9946) --> 
    clock_kernel(_9871:clock,_9871 isa clock,_9961,_9944,_9980),
    w(noun(_9879,sin,_9881,n),_9995,_9980,_10012),
    {user:testmember(_9879,[departure,arrival])},
    !,
    lock(exact,_10012,_10092),pushstack(exact,(w(noun(_9879,sin,def,n)),w(prep(at)),clock_kernel(_9871:clock,_9871 isa clock)),nil,_10092,_10098),np1(_9850,_9851,_10039,_10098,_10087),unlock(_10087,_9946),
    !.

np2(_9850,_9851,[np2,_9948,_9972,lit(enn),!,_10017,!,_10056,!],_9931,_9933) --> 
    anders(_9948,_9931,_9963),
    w(noun(_9876,_9877,_9878,n),_9972,_9963,_9989),
    cc(enn,_9989,_10011),
    !,
    np1(_9883,_9884,_10017,_10011,_10036),
    !,
    lock(exact,_10036,_10107),pushstack(exact,(w(noun(_9876,_9877,_9878,n)),w(prep(except)),xnp(_9883,_9884)),nil,_10107,_10113),np1(_9850,_9851,_10056,_10113,_10102),unlock(_10102,_9933),
    !.

anders([anders,lit(andre),!],_9870,_9872) --> 
    cc(andre,_9870,_9872),
    !.

anders([anders,lit(en),lit(annen),!],_9875,_9877) --> 
    cc(en,_9875,_9896),
    cc(annen,_9896,_9877),
    !.

np2(_9850,_9851,[np2,lit(samme),_9961,lit(som),!,_10006,!,_10045,!],_9933,_9935) --> 
    cc(samme,_9933,_9960),
    w(noun(_9878,sin,u,n),_9961,_9960,_9978),
    cc(som,_9978,_10000),
    !,
    np1(_9885,_9886,_10006,_10000,_10025),
    !,
    lock(exact,_10025,_10096),pushstack(exact,(w(noun(_9878,sin,def,n)),w(prep(as)),xnp(_9885,_9886)),nil,_10096,_10102),np1(_9850,_9851,_10045,_10102,_10091),unlock(_10091,_9935),
    !.

np2(_9859:_9860,_9853::_9856 and _9853,[np2,_9967,_9996,_10030,{},{}],_9950,_9952) --> 
    w(name(_9893,n,_9895),_9967,_9950,_9984),
    gmem(_9895,[company],_9996,_9984,_10015),
    w(noun(_9860,_9905,_9906,n),_10030,_10015,_9952),
    {user:subclass0(_9860,vehicle)},
    {user:_9856=(exists(_9859)::_9859 isa _9860 and _9893 isa _9895 and adj/nil/_9893/_9859/real)}.

np2(_9850,_9851,[np2,_9997,{},{},_10046,_10075,_10104,{},!,_10148,_10172,!],_9980,_9982) --> 
    w(name('Tåsen',n,_9887),_9997,_9980,_10014),
    {user:testmember(_9887,[neighbourhood,station,street])},
    {user:(\+testmember('Tåsen',[sentrum]))},
    w(noun(_9911,_9912,_9913,n),_10046,_10014,_10063),
    not_look_ahead([nr],_10075,_10063,_10092),
    not_look_ahead(w(nb(_9924,_9925)),_10104,_10092,_10121),
    {user:subclass0(_9911,vehicle)},
    !,
    accept(_10148,_10121,_10163),
    lock(exact,_10163,_10192),pushstack(exact,(w(noun(_9911,sin,def,n)),w(prep(to)),w(name('Tåsen',n,_9887))),nil,_10192,_10198),np1(_9850,_9851,_10172,_10198,_10187),unlock(_10187,_9982),
    !.

np2(_9850,_9851,[np2,_9951,{},_9990,_10019,!,_10053,_10077,!],_9934,_9936) --> 
    w(nb(_9876,num),_9951,_9934,_9968),
    {user:this_year(_9876)},
    not_look_ahead([-],_9990,_9968,_10007),
    not_look_ahead(w(nb(_9891,_9892)),_10019,_10007,_10036),
    !,
    accept(_10053,_10036,_10068),
    lock(exact,_10068,_10097),pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_9876,num))),nil,_10097,_10103),np1(_9850,_9851,_10077,_10103,_10092),unlock(_10092,_9936),
    !.

np2(_9850,_9851,[np2,_9931,_9955,lit(enn),!,_10000],_9914,_9916) --> 
    oter(_9931,_9914,_9946),
    w(noun(_9878,_9879,u,n),_9955,_9946,_9972),
    cc(enn,_9972,_9994),
    !,
    pushstack(first,(a,w(noun(_9878,sin,u,n)),[ulik]),nil,_9994,_10038),
    np1(_9850,_9851,_10000,_10038,_9916).

np2(_9850,_9853::_9854,[np2,_9935,_9964,_9993,_10027],_9918,_9920) --> 
    not_look_ahead([alle],_9935,_9918,_9952),
    not_look_ahead(w(name(_9886,_9887,_9888)),_9964,_9952,_9981),
    quant_pron(every,_9873,_9993,_9981,_10012),
    pushstack(first,(every,w(noun(_9873,sin,u,n))),nil,_10012,_10065),
    np1(_9850,_9853::_9854,_10027,_10065,_9920).

np2(_9850,_9851,[np2,_9921,_9955,_9984,_10008],_9904,_9906) --> 
    quant_pron(every,_9870,_9921,_9904,_9940),
    not_look_ahead([som],_9955,_9940,_9972),
    not_look_ahead_np(_9984,_9972,_9999),
    pushstack(first,(every,w(noun(_9870,sin,u,n))),nil,_9999,_10046),
    np0_accept(_9850,_9851,_10008,_10046,_9906).

np2(_9850,_9851,[np2,_9912,_9946,_9970,_9999,_10023],_9895,_9897) --> 
    quant_pron(some,_9865,_9912,_9895,_9931),
    rfxpron0(_9946,_9931,_9961),
    not_look_ahead([som],_9970,_9961,_9987),
    not_look_ahead_np(_9999,_9987,_10014),
    np00(_9865,_9850,_9851,_10023,_10014,_9897).

clock_number(_9852:_9853,[clock_number,_9901,{},!],_9887,_9889) --> 
    number(_9852:_9853,_9901,_9887,_9889),
    {user:clock_test(_9852)},
    !.

bus_number(_9852:_9853,[bus_number,_9898,{}],_9884,_9886) --> 
    number(_9852:_9853,_9898,_9884,_9886),
    {user:plausible_busno(_9852)}.

road_number(_9852:_9853,[road_number,_9899,{}],_9885,_9887) --> 
    number(_9852:_9853,_9899,_9885,_9887),
    {user:_9852=<200}.

noun_list2(_9850,_9851,_9852,[noun_list2,_9910,_9964],_9890,_9892) --> 
    noun(_9862,_9850,u,n,_9857,_9858,_9910,_9890,_9937),
    nlists10(_9857,_9858,_9851,_9852,_9964,_9937,_9892).

nlists10(_9858:_9859,_9851,(_9858,_9868):(_9859,_9865),_9851 and _9856,[nlists10,_9937,_9961,_10015],_9914,_9916) --> 
    comma(_9937,_9914,_9952),
    noun(_9881,_9882,_9883,n,_9876,_9877,_9961,_9952,_9988),
    nlists10(_9876,_9877,_9868:_9865,_9856,_10015,_9988,_9916).

nlists10(_9858:_9859,_9851,(_9858,_9868):(_9859,_9865),_9851 and _9856,[nlists10,_9931,_9960],_9908,_9910) --> 
    andor(_9880,_9931,_9908,_9948),
    noun(_9873,_9874,_9875,n,_9868:_9865,_9856,_9960,_9948,_9910).

noun_list(_9850,_9851,_9852,[noun_list,_9953,_9982,_10011,_10040,_10069,{},_10133],_9933,_9935) --> 
    not_look_ahead([noe],_9953,_9933,_9970),
    not_look_ahead([noen],_9982,_9970,_9999),
    not_look_ahead([min],_10011,_9999,_10028),
    not_look_ahead(w(adj2(_9893,nil)),_10040,_10028,_10057),
    noun(_9896,_9850,_9898,n,_9872,_9873,_10069,_10057,_10096),
    {user:(\+testmember(_9896,[clock]))},
    nlists0join(_9872,_9873,_9851,_9852,_10133,_10096,_9935).

nlists0join(_9850,_9851,_9855:_9856,_9853,[nlists0join,_9934,{},!,_9993,{}],_9911,_9913) --> 
    nlists0(_9850,_9851,_9855:_9881,_9853,_9934,_9911,_9957),
    {user:joinclasses(_9881,_9856)},
    !,
    accept(_9993,_9957,_9913),
    {user:_9856\==thing}.

nlists0(_9858:_9859,_9851,(_9858,_9868):(_9859,_9865),_9851 and _9856,[nlists0,lit(og),_9993,_10022,_10076,{},{},_10125],_9959,_9961) --> 
    cc(og,_9959,_9992),
    not_look_ahead_lit([da,'så',min],_9993,_9992,_10010),
    noun(_9903,_9904,_9905,n,_9888,_9889,_10022,_10010,_10049),
    not_look_ahead(w(prep(_9914)),_10076,_10049,_10093),
    {user:joinclass(_9859,_9903,_9920)},
    {user:(_9920\==thing,_9920\==nil)},
    nlists0(_9888,_9889,_9868:_9865,_9856,_10125,_10093,_9961).

nlists0(_9850,_9851,_9850,_9851,[nlists0,[],_9918],_9890,_9892) --> 
    [],
    not_look_ahead(w(noun(_9862,_9863,_9864,_9865)),_9918,_9890,_9892).

postcode(_9850,[postcode,_9932,{},_9971,{}],_9918,_9920) --> 
    w(nb(_9850,num),_9932,_9918,_9949),
    {user:(number(_9850),_9850>=1000,_9850=<9999)},
    look_ahead(w(name(_9897,n,_9863)),_9971,_9949,_9920),
    {user:testmember(_9863,[city,neighbourhood,station])}.

noun_compound(_9850,_9851,sin,[noun_compound,_9919,_9948,_9987,_10011],_9899,_9901) --> 
    not_look_ahead([man],_9919,_9899,_9936),
    namep(_9874,_9865,_9866,_9948,_9936,_9969),
    sin(_9987,_9969,_10002),
    ncomps0(gen,_9850,_9865,_9866,_9851,_9868,_10011,_10002,_9901).

noun_compound(_9850,_9854 and _9855,_9852,[noun_compound,_9930,_9959,_9988,{}],_9910,_9912) --> 
    not_look_ahead([dere],_9930,_9910,_9947),
    w(name(_9868,_9879,_9880),_9959,_9947,_9976),
    noun(_9882,_9852,u,n,_9850,_9854,_9988,_9976,_9912),
    {user:adjnamecomp_template(_9868,_9850,_9855)}.

noun_compound(_9850,_9851,_9852,[noun_compound,_9934,_9963,{},_10022,_10066],_9914,_9916) --> 
    not_look_ahead([man],_9934,_9914,_9951),
    noun2(_9877,_9878,_9879,_9868,_9869,_9963,_9951,_9988),
    {user:_9852=_9877},
    s0(_9877,_9878,_9879,_9866,_10022,_9988,_10045),
    ncomps0(_9866,_9850,_9868,_9869,_9851,_9871,_10066,_10045,_9916).

morenames(_9850,(_9850,_9854),[morenames,_9900,_9929],_9883,_9885) --> 
    unplausible_name(_9859,_9900,_9883,_9917),
    morenames(_9859,_9854,_9929,_9917,_9885).

morenames(_9850,_9850,[morenames,[]],_9872,_9872) --> 
    [].

unplausible_name(_9850,[unplausible_name,_9895,!,_9929],_9881,_9883) --> 
    w(name(_9850,unknown,_9862),_9895,_9881,_9912),
    !,
    accept(_9929,_9912,_9883).

ncomps0(gen,_9851,_9852,_9853,_9854,0,[ncomps0,_9933,_9962,{}],_9904,_9906) --> 
    preadjs0(_9865,_9933,_9904,_9950),
    ncomps(_9851,_9852,_9868,_9854,_9962,_9950,_9906),
    {user:preadjs_template(_9865,_9851,_9853,_9868)}.

ncomps0(n,_9857:_9858,_9857:_9858,_9853,_9853,0,[ncomps0,_9926],_9897,_9899) --> 
    w(noun(_9858,_9866,_9867,n),_9926,_9897,_9899).

ncomps0(n,_9851,_9852,_9853,_9853,name,[ncomps0,{}],_9889,_9889) --> 
    {user:compatvar(_9851,_9852)}.

ncomps(_9850,_9851,_9852,_9853,[ncomps,_9932,{},_9991],_9909,_9911) --> 
    noun2(_9868,_9869,_9861,_9863,_9872,_9932,_9909,_9957),
    {user:has_template(_9851,_9863,_9878)},
    ncomps0(_9861,_9850,_9863,_9852 and _9872 and _9878,_9853,_9866,_9991,_9957,_9911).

s0(_9850,_9851,n,gen,[s0,_9901],_9878,_9880) --> 
    sin(_9901,_9878,_9880).

s0(_9850,_9851,n,gen,[s0,lit(s)],_9880,_9882) --> 
    cc(s,_9880,_9882).

s0(sin,u,n,n,[s0,[]],_9878,_9878) --> 
    [].

s0(sin,def,n,n,[s0,[]],_9878,_9878) --> 
    [].

s0(plu,u,n,n,[s0,[]],_9878,_9878) --> 
    [].

s0(plu,def,n,n,[s0,[]],_9878,_9878) --> 
    [].

s0(_9850,_9851,gen,gen,[s0,[]],_9878,_9878) --> 
    [].

noun_modifiers0(_9850,_9851,_9858::_9856,_9855::_9856,[noun_modifiers0,_9912],_9889,_9891) --> 
    noun_modsx0(_9850,_9851,_9855,_9858,_9912,_9889,_9891).

noun_modsx0(0,_9851,_9852,_9853,[noun_modsx0,_9905],_9882,_9884) --> 
    rel_clauses(_9851,_9852,_9853,_9905,_9882,_9884).

noun_modsx0(0,_9864:_9865,_9852,_9852 and _9867 isa coevent and _9861 and _9862,[noun_modsx0,{},lit(til),lit(at),!,_10007,{},!,_10056],_9947,_9949) --> 
    {user:testmember(_9865,[cause])},
    cc(til,_9947,_9990),
    cc(at,_9990,_10001),
    !,
    clausal_object1(_9867:coevent,true::_9862,_10007,_10001,_10026),
    {user:noun_compl(to,_9864:_9865,_9867:coevent,_9861)},
    !,
    accept(_10056,_10026,_9949).

noun_modsx0(0,_9864:_9865,_9852,_9852 and _9867 isa coevent and _9861 and _9862,[noun_modsx0,{},lit(for),lit('å'),!,_10012,{},!,_10070],_9952,_9954) --> 
    {user:testmember(_9865,[way])},
    cc(for,_9952,_9995),
    cc('å',_9995,_10006),
    !,
    pushstack(first,[noen],nil,_10006,_10025),clausal_object1(_9867:coevent,true::_9862,_10012,_10025,_10040),
    {user:noun_compl(regarding,_9864:_9865,_9867:coevent,_9861)},
    !,
    accept(_10070,_10040,_9954).

noun_modsx0(0,_9864:_9865,_9852,_9852 and _9867 isa coevent and _9861 and _9862,[noun_modsx0,{},lit(for),lit(hvordan),!,_10007,{},!,_10056],_9947,_9949) --> 
    {user:testmember(_9865,[way])},
    cc(for,_9947,_9990),
    cc(hvordan,_9990,_10001),
    !,
    clausal_object1(_9867:coevent,true::_9862,_10007,_10001,_10026),
    {user:noun_compl(regarding,_9864:_9865,_9867:coevent,_9861)},
    !,
    accept(_10056,_10026,_9949).

noun_modsx0(0,_9864:_9865,_9852,_9852 and _9867 isa coevent and _9861 and _9862,[noun_modsx0,{},lit(om),lit(hvor),_10018,!,_10052,{},!,_10110],_9963,_9965) --> 
    {user:testmember(_9865,[question])},
    cc(om,_9963,_10006),
    cc(hvor,_10006,_10017),
    w(adj2(_9907,nil),_10018,_10017,_10035),
    !,
    pushstack(free,w(adj2(_9907,nil)),nil,_10035,_10065),clausal_object1(_9867:coevent,true::_9862,_10052,_10065,_10080),
    {user:noun_compl(regarding,_9864:_9865,_9867:coevent,_9861)},
    !,
    accept(_10110,_10080,_9965).

noun_modsx0(0,_9864:_9865,_9852,_9852 and _9867 isa coevent and _9861 and _9862,[noun_modsx0,{},lit(der),!,_9991,{},!,_10040],_9942,_9944) --> 
    {user:testmember(_9865,[example])},
    cc(der,_9942,_9985),
    !,
    clausal_object1(_9867:coevent,true::_9862,_9991,_9985,_10010),
    {user:noun_compl(on,_9864:_9865,_9867:coevent,_9861)},
    !,
    accept(_10040,_10010,_9944).

noun_modsx0(0,_9864:_9865,_9852,_9852 and _9867 isa coevent and _9861 and _9862,[noun_modsx0,{},_9988,lit('å'),!,_10048,{},!,_10162],_9955,_9957) --> 
    {user:testmember(_9865,[cause])},
    optional([for],_9988,_9955,_10020),
    cc('å',_10020,_10042),
    !,
    pushstack(first,(someone,aux1),nil,_10042,_10117),clausal_object1(_9867:coevent,true::_9862,_10048,_10117,_10132),
    {user:noun_compl(for,_9864:_9865,_9867:coevent,_9861)},
    !,
    accept(_10162,_10132,_9957).

noun_modsx0(0,_9864:_9865,_9852,_9852 and _9867 isa coevent and _9861 and _9862,[noun_modsx0,{},_9990,lit('å'),!,_10050,{},!,_10164],_9957,_9959) --> 
    {user:testmember(_9865,[permission,possibility])},
    optional([til],_9990,_9957,_10022),
    cc('å',_10022,_10044),
    !,
    pushstack(first,(someone,aux1),nil,_10044,_10119),clausal_object1(_9867:coevent,true::_9862,_10050,_10119,_10134),
    {user:noun_compl(to,_9864:_9865,_9867:coevent,_9861)},
    !,
    accept(_10164,_10134,_9959).

noun_modsx0(0,_9864:_9865,_9852,_9852 and _9867 isa coevent and _9861 and _9862,[noun_modsx0,{},lit(om),lit('å'),!,_10019,{},!,_10133],_9959,_9961) --> 
    {user:testmember(_9865,[notification,request,plan,wish])},
    cc(om,_9959,_10002),
    cc('å',_10002,_10013),
    !,
    pushstack(first,(someone,aux1),nil,_10013,_10088),clausal_object1(_9867:coevent,true::_9862,_10019,_10088,_10103),
    {user:noun_compl(about,_9864:_9865,_9867:coevent,_9861)},
    !,
    accept(_10133,_10103,_9961).

noun_modsx0(0,_9864:_9865,_9852,_9852 and _9867 isa coevent and _9861 and _9862,[noun_modsx0,{},_9983,lit(at),!,_10028,{},!,_10077],_9950,_9952) --> 
    {user:constrain(_9864:_9865,connection)},
    w(prep(with),_9983,_9950,_10000),
    cc(at,_10000,_10022),
    !,
    clausal_object1(_9867:coevent,true::_9862,_10028,_10022,_10047),
    {user:noun_compl(with,_9864:_9865,_9867:coevent,_9861)},
    !,
    accept(_10077,_10047,_9952).

noun_modsx0(0,_9851,_9852,_9852 and _9856,[noun_modsx0,{},_9984,_10008,_10052,_10086,!,_10125],_9951,_9953) --> 
    {user:constrain(_9851,way)},
    in_order_tox(_9984,_9951,_9999),
    lexv(tv,_9899,inf,fin,_10008,_9999,_10031),
    np1(_9903,_9906::_9907,_10052,_10031,_10071),
    fictitiousprep(way,_9910,_10086,_10071,_10105),
    !,
    pushstack(first,(someone,w(verb(_9899,pres,fin)),np1(_9903,_9906::_9907),prep(_9910),npgap(_9851)),nil,_10105,_10257),
    statreal(_9856,_10125,_10257,_9953).

noun_modsx0(0,_9851,_9852,_9852 and _9856,[noun_modsx0,{},_9966,_9990,_10034,!,_10073],_9933,_9935) --> 
    {user:constrain(_9851,way)},
    in_order_tox(_9966,_9933,_9981),
    lexv(iv,_9893,inf,fin,_9990,_9981,_10013),
    fictitiousprep(way,_9898,_10034,_10013,_10053),
    !,
    pushstack(first,(someone,w(verb(_9893,pres,fin)),prep(_9898),npgap(_9851)),nil,_10053,_10171),
    statreal(_9856,_10073,_10171,_9935).

noun_modsx0(_9850,_9851,_9852,_9852,[noun_modsx0,_9911,!,_9945],_9888,_9890) --> 
    look_ahead([den],_9911,_9888,_9928),
    !,
    accept(_9945,_9928,_9890).

noun_modsx0(_9850,_9851,_9852,_9852,[noun_modsx0,{},_9937,!,_9971],_9904,_9906) --> 
    {user:(vartypeid(_9851,_9869),subclass(_9869,daypart))},
    not_look_ahead(w(prep(_9879)),_9937,_9904,_9954),
    !,
    accept(_9971,_9954,_9906).

noun_modsx0(_9850,_9851,_9852,_9853,[noun_modsx0,_9909,!],_9886,_9888) --> 
    noun_mods(_9850,_9851,_9852,_9853,_9909,_9886,_9888),
    !.

noun_modsx0(_9850,_9851,_9852,_9852,[noun_modsx0,[]],_9878,_9878) --> 
    [].

fictitiousprep(way,in,[fictitiousprep,[]],_9872,_9872) --> 
    [].

fictitiousprep(abstract,with,[fictitiousprep,[]],_9872,_9872) --> 
    [].

noun_mods(0,_9851,_9852,_9852 and _9856,[noun_mods,{},_10054,{},_10093,_10122,_10151,_10180,_10209,_10238,_10267,_10296],_10021,_10023) --> 
    {user:(vartypeid(_9851,_9905),testmember(_9905,[address,email,mind,mailaddress,telephone,webaddress]))},
    prep1(to,_10054,_10021,_10071),
    {user:(vartypeid(_9851,_9932),\+testmember(_9932,[name]))},
    not_look_ahead(w(nb(_9944,_9945)),_10093,_10071,_10110),
    not_look_ahead(w(prep(_9951)),_10122,_10110,_10139),
    not_look_ahead_lit([deg,meg,seg],_10151,_10139,_10168),
    not_look_ahead(w(noun(station,_9966,_9967,_9968)),_10180,_10168,_10197),
    not_look_ahead(w(name(_9974,_9975,station)),_10209,_10197,_10226),
    not_look_ahead(w(name(_9982,_9983,neighbourhood)),_10238,_10226,_10255),
    not_look_ahead(w(name(_9990,_9991,city)),_10267,_10255,_10284),
    pushstack(first,(npgap(_9851),w(verb(evah,pres,fin))),nil,_10284,_10336),
    statreal(_9856,_10296,_10336,_10023).

noun_mods(0,_9851,_9852,_9852 and _9856,[noun_mods,{},_9965,{},{},_10014],_9932,_9934) --> 
    {user:value(teleflag,true)},
    not_look_ahead(w(prep(_9891)),_9965,_9932,_9982),
    {user:vartypeid(_9851,_9896)},
    {user:(\+vartypid(_9896,[]))},
    pushstack(first,(npgap(_9851),w(verb(evah,pres,fin))),nil,_9982,_10054),
    statreal(_9856,_10014,_10054,_9934).

noun_mods(0,_9851,_9852,_9853,[noun_mods,_9919,!,_9963,_9987],_9896,_9898) --> 
    noun_mod(_9851,_9852,_9866,_9919,_9896,_9940),
    !,
    accept(_9963,_9940,_9978),
    noun_modsx0(0,_9851,_9866,_9853,_9987,_9978,_9898).

noun_mods(name,_9851,_9852,_9853,[noun_mods,{},_9964,{},_10003,!,_10047,_10071],_9931,_9933) --> 
    {user:(vartypeid(_9851,_9883),subclass0(_9883,vehicle))},
    look_ahead(w(prep(_9893)),_9964,_9931,_9981),
    {user:testmember(_9893,[to,from])},
    noun_mod(_9851,_9852,_9875,_10003,_9981,_10024),
    !,
    accept(_10047,_10024,_10062),
    noun_mods(name,_9851,_9875,_9853,_10071,_10062,_9933).

noun_mods(name,_9851,_9852,_9853,[noun_mods,_9954,{},{},_10003,!,_10047,_10071],_9931,_9933) --> 
    look_ahead(w(prep(_9882)),_9954,_9931,_9971),
    {user:testmember(_9882,[on,towards])},
    {user:(vartypeid(_9851,_9898),subclass0(_9898,place))},
    noun_mod(_9851,_9852,_9875,_10003,_9971,_10024),
    !,
    accept(_10047,_10024,_10062),
    noun_mods(name,_9851,_9875,_9853,_10071,_10062,_9933).

noun_mods(name,_9851,_9852,_9853,[noun_mods,{},_9937,_9976],_9904,_9906) --> 
    {user:(value(textflag,true);value(teleflag,true))},
    noun_mod(_9851,_9852,_9863,_9937,_9904,_9958),
    noun_mods(name,_9851,_9863,_9853,_9976,_9958,_9906).

noun_mods(name,_9851,_9852,_9852 and _9856,[noun_mods,{},{},_9981,{},_10020],_9938,_9940) --> 
    {user:value(teleflag,true)},
    {user:constrain(_9851,person)},
    w(name(_9878,n,_9880),_9981,_9938,_9998),
    {user:subclass0(_9880,place)},
    pushstack(first,(prep1(in),w(name(_9878,n,_9880))),nil,_9998,_10060),
    noun_mod(_9851,_9852,_9856,_10020,_10060,_9940).

noun_mod(_9860:_9861,_9851,nrel/nil/day/clock/_9860/_9864 and _9851 and _9858,[noun_mod,{},_9949,_9973],_9919,_9921) --> 
    {user:constrain(_9860:_9861,day)},
    clock(_9949,_9919,_9964),
    clock_sequel(_9864:_9896,_9858,_9973,_9964,_9921).

noun_mod(_9850,_9851,_9851 and _9855,[noun_mod,_9915,{},!],_9895,_9897) --> 
    adverb(_9863,_9864,_9865,_9915,_9895,_9897),
    {user:noun_adverb(_9850,_9863,_9864,_9855)},
    !.

noun_mod(_9860:_9861,_9851,_9851 and _9857 and _9858,[noun_mod,lit(for),lit('å'),_9983,!,_10022,{},!,_10080],_9941,_9943) --> 
    cc(for,_9941,_9971),
    cc('å',_9971,_9982),
    gmem(_9861,[condition],_9983,_9982,_10002),
    !,
    pushstack(first,[noen],nil,_10002,_10035),clausal_object1(_9904:coevent,true::_9858,_10022,_10035,_10050),
    {user:noun_compl(for,_9860:_9861,_9904:coevent,_9857)},
    !,
    accept(_10080,_10050,_9943).

noun_mod(_9860:_9861,_9851,_9851 and _9857 and _9858,[noun_mod,lit(om),lit(at),{},!,_10009,{},{},!,_10068],_9952,_9954) --> 
    cc(om,_9952,_9982),
    cc(at,_9982,_9993),
    {user:testmember(_9861,[information,message,notification,question])},
    !,
    clausal_object1(_9910:coevent,_9907::_9858,_10009,_9993,_10028),
    {user:_9907=true},
    {user:noun_compl(regarding,_9860:_9861,_9910:coevent,_9857)},
    !,
    accept(_10068,_10028,_9954).

noun_mod(_9850,_9851,_9851 and _9855,[noun_mod,_9924,_9953],_9904,_9906) --> 
    posspron(_9871,_9924,_9904,_9941),
    lock(exact,_9941,_10030),
    pushstack(exact,(pronoun(_9871),w(verb(have,pres,fin)),npgap(_9850)),nil,_10030,_10036),
    statreal(_9855,_9953,_10036,_10025),
    unlock(_10025,_9906).

noun_mod(_9850,_9851,_9851 and _9855,[noun_mod,_9912,_9941],_9892,_9894) --> 
    look_ahead(w(adj(_9868,comp)),_9912,_9892,_9929),
    comparison(_9850,_9861,_9855,_9941,_9929,_9894).

noun_mod(_9850,_9851,_9851 and _9855,[noun_mod,_9945,{},_9984,{},!,_10038,{}],_9925,_9927) --> 
    negation0(_9877,_9945,_9925,_9962),
    {user:(\+vartypeid(_9850,self))},
    adjunct1(_9890,_9891,_9879::_9855,_9984,_9962,_10005),
    {user:noun_compl(_9890,_9850,_9891,_9878)},
    !,
    accept(_10038,_10005,_9927),
    {user:negate(_9877,_9878,_9879)}.

noun_mod(_9854:_9855,_9851,_9851,[noun_mod,{},_9932,_9956,{}],_9902,_9904) --> 
    {user:constrain(_9854:_9855,vehicle)},
    numberroute(_9932,_9902,_9947),
    num_na(_9868,_9956,_9947,_9904),
    {user:_9868=_9854}.

noun_mod(_9850,_9851,_9851 and _9855,[noun_mod,_9935,_9964,{},!,_10035],_9915,_9917) --> 
    day(_9869,_9935,_9915,_9952),
    lock(exact,_9952,_9984),pushstack(exact,w(noun(_9869,sin,u,n)),nil,_9984,_9990),np1(_9881,_9884::_9855,_9964,_9990,_9979),unlock(_9979,_9980),
    {user:noun_compl(nil,_9850,_9881,_9884)},
    !,
    accept(_10035,_9980,_9917).

noun_mod(_9850,_9851,_9851 and _9855,[noun_mod,_9940,_9969,{},!,_10027],_9920,_9922) --> 
    w(noun(midnight,_9872,_9873,n),_9940,_9920,_9957),
    pushstack(first,w(noun(midnight,sin,u,n)),nil,_9957,_9982),np1(_9886,_9889::_9855,_9969,_9982,_9997),
    {user:noun_compl(nil,_9850,_9886,_9889)},
    !,
    accept(_10027,_9997,_9922).

noun_mod(_9850,_9851,_9851 and _9855,[noun_mod,_9920,{},!,_9969],_9900,_9902) --> 
    obviousdate(_9866,_9869::_9855,_9920,_9900,_9939),
    {user:noun_compl(nil,_9850,_9866,_9869)},
    !,
    accept(_9969,_9939,_9902).

noun_mod(_9850,_9851,_9851 and _9855,[noun_mod,_9920,{},!,_9969],_9900,_9902) --> 
    obviousclock(_9866,_9869::_9855,_9920,_9900,_9939),
    {user:noun_compl(nil,_9850,_9866,_9869)},
    !,
    accept(_9969,_9939,_9902).

noun_mod(_9850,_9851,_9852,[noun_mod,_9937,_9966,!,_10005,!,_10089],_9917,_9919) --> 
    w(noun(direction,_9872,_9873,_9874),_9937,_9917,_9954),
    nameq1(_9876,_9877,_9966,_9954,_9985),
    !,
    pushstack(first,(w(prep(towards)),nameq1(_9876,_9877)),nil,_9985,_10049),noun_mod(_9850,_9851,_9852,_10005,_10049,_10066),
    !,
    accept(_10089,_10066,_9919).

noun_mod(_9857:_9858,_9851,_9851 and _9855,[noun_mod,{},_9947,{},!,_9996],_9917,_9919) --> 
    {user:test(n_compl(nil,_9858,_9878))},
    np1_accept(_9880,_9883::_9855,_9947,_9917,_9966),
    {user:noun_compl(nil,_9857:_9858,_9880,_9883)},
    !,
    accept(_9996,_9966,_9919).

begin([begin,[]],_9865,_9865) --> 
    [].

end([end,[]],_9865,_9865) --> 
    [].

accept([accept,[]],_9865,_9865) --> 
    [].

reject([reject,{}],_9867,_9867) --> 
    {user:fail}.

look_ahead_place([look_ahead_place,_9894,{}],_9883,_9885) --> 
    look_ahead(w(name(_9864,_9865,_9857)),_9894,_9883,_9885),
    {user:test(subclass0(_9857,place))}.

look_ahead_conjuction([look_ahead_conjuction,_9880],_9869,_9871) --> 
    look_ahead(['før'],_9880,_9869,_9871).

look_ahead_conjuction([look_ahead_conjuction,_9880],_9869,_9871) --> 
    look_ahead([etter],_9880,_9869,_9871).

look_ahead_conjuction([look_ahead_conjuction,_9880],_9869,_9871) --> 
    look_ahead(['når'],_9880,_9869,_9871).

not_look_ahead_flnp([not_look_ahead_flnp,_9905,{},!,_9949],_9894,_9896) --> 
    look_ahead(w(adj2(_9863,nil)),_9905,_9894,_9922),
    {user:testmember(_9863,[first,last,next,previous])},
    !,
    reject(_9949,_9922,_9896).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_9865,_9865) --> 
    [].

not_look_ahead_flnp([not_look_ahead_flnp,_9905,{},!,_9949],_9894,_9896) --> 
    look_ahead(w(adj2(_9863,nil)),_9905,_9894,_9922),
    {user:testmember(_9863,[first,last,next,previous])},
    !,
    reject(_9949,_9922,_9896).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_9865,_9865) --> 
    [].

not_look_ahead_vehicle([not_look_ahead_vehicle,_9901,{},!,_9945],_9890,_9892) --> 
    look_ahead(w(noun(_9863,_9864,_9865,_9866)),_9901,_9890,_9918),
    {user:test(subclass0(_9863,vehicle))},
    !,
    reject(_9945,_9918,_9892).

not_look_ahead_vehicle([not_look_ahead_vehicle,_9903,{},!,_9947],_9892,_9894) --> 
    look_ahead(w(noun(_9863,_9864,_9865,_9866)),_9903,_9892,_9920),
    {user:testmember(_9863,[departure,arrival])},
    !,
    reject(_9947,_9920,_9894).

not_look_ahead_vehicle([not_look_ahead_vehicle,[]],_9865,_9865) --> 
    [].

not_look_ahead_day([not_look_ahead_day,_9899,{},!,_9943],_9888,_9890) --> 
    look_ahead(w(noun(_9863,_9864,_9865,_9866)),_9899,_9888,_9916),
    {user:_9863 ako day},
    !,
    reject(_9943,_9916,_9890).

not_look_ahead_day([not_look_ahead_day,[]],_9865,_9865) --> 
    [].

not_look_ahead_noun([not_look_ahead_noun,_9885],_9874,_9876) --> 
    not_look_ahead(w(noun(_9854,_9855,_9856,_9857)),_9885,_9874,_9876).

look_ahead_timeclause([look_ahead_timeclause,_9885],_9874,_9876) --> 
    look_ahead(w(noun(clock,_9855,_9856,_9857)),_9885,_9874,_9876).

look_ahead_timeclause([look_ahead_timeclause,_9893,{}],_9882,_9884) --> 
    look_ahead(w(noun(_9855,sin,u,n)),_9893,_9882,_9884),
    {user:subclass(_9855,day)}.

look_ahead_clock([look_ahead_clock,_9882],_9871,_9873) --> 
    look_ahead_lit([kl,klokken],_9882,_9871,_9873).

look_ahead_clock([look_ahead_clock,_9885],_9874,_9876) --> 
    look_ahead(w(noun(clock,sin,def,n)),_9885,_9874,_9876).

look_ahead_clock([look_ahead_clock,_9883],_9872,_9874) --> 
    look_ahead(w(nb(_9854,_9855)),_9883,_9872,_9874).

not_look_ahead_vp([not_look_ahead_vp,_9882,!,_9911],_9871,_9873) --> 
    look_ahead_vp(_9882,_9871,_9897),
    !,
    reject(_9911,_9897,_9873).

not_look_ahead_vp([not_look_ahead_vp,[]],_9865,_9865) --> 
    [].

look_ahead_vp([look_ahead_vp,_9884],_9873,_9875) --> 
    look_ahead(w(verb(_9854,_9855,_9856)),_9884,_9873,_9875).

look_ahead_vp([look_ahead_vp,_9880],_9869,_9871) --> 
    look_ahead([ikke],_9880,_9869,_9871).

look_ahead_vp([look_ahead_vp,_9876],_9865,_9867) --> 
    look_ahead_aux(_9876,_9865,_9867).

look_ahead_aux([look_ahead_aux,_9898],_9887,_9889) --> 
    look_ahead_lit([vil,skal,'bør','må',kan,ville,skulle,burde,'måtte',kunne],_9898,_9887,_9889).

not_look_ahead_lit(_9850,[not_look_ahead_lit,_9891,!,_9925],_9877,_9879) --> 
    look_ahead_lit(_9850,_9891,_9877,_9908),
    !,
    reject(_9925,_9908,_9879).

not_look_ahead_lit(_9850,[not_look_ahead_lit,[]],_9869,_9869) --> 
    [].

look_ahead_lit(_9850,[look_ahead_lit,_9898,{},!],_9884,_9886) --> 
    look_ahead([_9859],_9898,_9884,_9886),
    {user:testmember(_9859,_9850)},
    !.

lit_of(_9850,_9851,[lit_of,lit(_9850),{},!],_9885,_9887) --> 
    cc(_9850,_9885,_9887),
    {user:member(_9850,_9851)},
    !.

one_of_lit(_9850,[one_of_lit,lit(_9857),{},!],_9882,_9884) --> 
    cc(_9857,_9882,_9884),
    {user:member(_9857,_9850)},
    !.

not_one_of_lit(_9850,[not_one_of_lit,_9891,!,_9925],_9877,_9879) --> 
    one_of_lit(_9850,_9891,_9877,_9908),
    !,
    reject(_9925,_9908,_9879).

not_one_of_lit(_9850,[not_one_of_lit,[]],_9869,_9869) --> 
    [].

not_look_ahead_number([not_look_ahead_number,lit(ett),!],_9870,_9872) --> 
    cc(ett,_9870,_9872),
    !.

not_look_ahead_number([not_look_ahead_number,_9887,!,_9921],_9876,_9878) --> 
    w(nb(_9858,_9859),_9887,_9876,_9904),
    !,
    fail(_9921,_9904,_9878).

not_look_ahead_number([not_look_ahead_number,[]],_9865,_9865) --> 
    [].

not_look_ahead_np([not_look_ahead_np,_9901,_9930,!],_9890,_9892) --> 
    look_ahead(w(adv(_9860)),_9901,_9890,_9918),
    gmem(_9860,[klokken,kloka,kl,directly,correctly],_9930,_9918,_9892),
    !.

not_look_ahead_np([not_look_ahead_np,_9882,!,_9911],_9871,_9873) --> 
    look_ahead_np(_9882,_9871,_9897),
    !,
    reject(_9911,_9897,_9873).

not_look_ahead_np([not_look_ahead_np,[]],_9865,_9865) --> 
    [].

look_ahead_np([look_ahead_np,_9944],_9933,_9935) --> 
    look_ahead_lit([den,det,de,denne,dere,dette,disse,du,en,et,ei,han,hun,jeg,noe,noen,vi,meg,deg,seg,min,mine,din,dine,hans,hennes,seg,'vår','våre',deres,mange,noen,noe],_9944,_9933,_9935).

look_ahead_np([look_ahead_np,_9893,{}],_9882,_9884) --> 
    look_ahead(w(adj2(_9857,_9865)),_9893,_9882,_9884),
    {user:(\+testmember(_9857,[]))}.

look_ahead_np([look_ahead_np,_9885],_9874,_9876) --> 
    look_ahead(w(noun(_9854,_9855,_9856,_9857)),_9885,_9874,_9876).

look_ahead_np([look_ahead_np,_9883],_9872,_9874) --> 
    look_ahead(w(nb(_9854,_9855)),_9883,_9872,_9874).

look_ahead_np([look_ahead_np,_9882],_9871,_9873) --> 
    look_ahead_lit([halv,kvart],_9882,_9871,_9873).

look_ahead_np([look_ahead_np,_9894,{}],_9883,_9885) --> 
    look_ahead(w(name(_9857,_9865,_9866)),_9894,_9883,_9885),
    {user:(\+testmember(_9857,[]))}.

look_ahead_subject([look_ahead_subject,lit(_9855),{}],_9885,_9887) --> 
    cc(_9855,_9885,_9887),
    {user:testmember(_9855,[jeg,du,han,hun,vi])}.

look_ahead_pron([look_ahead_pron,_9886],_9875,_9877) --> 
    look_ahead_lit([jeg,vi,du,dere],_9886,_9875,_9877).

not_look_ahead_pron([not_look_ahead_pron,_9884,!,_9918],_9873,_9875) --> 
    posspron(_9856,_9884,_9873,_9901),
    !,
    reject(_9918,_9901,_9875).

not_look_ahead_pron([not_look_ahead_pron,_9886],_9875,_9877) --> 
    not_look_ahead_lit([jeg,du,han,hun],_9886,_9875,_9877).

determiner0(plu,0,_9852,_9853,_9856::quant(approx/_9869,_9852)::_9853 and _9856,[determiner0,lit(mellom),_9964,lit(og),_10004,{}],_9927,_9929) --> 
    cc(mellom,_9927,_9963),
    w(nb(_9869,num),_9964,_9963,_9981),
    cc(og,_9981,_10003),
    w(nb(_9886,num),_10004,_10003,_9929),
    {user:_9869<_9886}.

determiner0(plu,0,_9852,_9853,_9856::quant(eq/_9869,_9852)::_9853 and _9856,[determiner0,_9983,_10007,{},_10046,_10075,!,_10109,[]],_9957,_9959) --> 
    theplu0(_9983,_9957,_9998),
    w(adj2(_9897,nil),_10007,_9998,_10024),
    {user:testmember(_9897,[first,last,next,previous])},
    number(_9869:_9921,_10046,_10024,_10063),
    look_ahead(w(noun(_9927,plu,_9929,_9930)),_10075,_10063,_10092),
    !,
    accept(_10109,_10092,_10124),
    pushstack(free,w(adj2(_9897,nil)),nil,_10124,_9959),
    [].

determiner0(sin,0,_9852,_9853,_9856::_9857,[determiner0,{},_9941,_9965],_9905,_9907) --> 
    {user:value(dialog,1)},
    the(_9941,_9905,_9956),
    pushstack(first,this,nil,_9956,_10003),
    determiner(_9852,_9853,_9856::_9857,_9965,_10003,_9907).

determiner0(_9850,_9851,_9852,_9853,_9854,[determiner0,_9938,_9962,_9991,{},!,_10035],_9912,_9914) --> 
    theplu0(_9938,_9912,_9953),
    number(_9873:_9874,_9962,_9953,_9979),
    w(noun(_9878,_9879,_9880,_9881),_9991,_9979,_10008),
    {user:measureclass(_9878)},
    !,
    reject(_10035,_10008,_9914).

determiner0(plu,0,_9852,_9853,_9856::quant(approx/_9869,_9852)::_9853 and _9856,[determiner0,_9933,!,_9962],_9907,_9909) --> 
    approx(_9933,_9907,_9948),
    !,
    number(_9869:_9880,_9962,_9948,_9909).

approx([approx,lit(ca),!],_9870,_9872) --> 
    cc(ca,_9870,_9872),
    !.

approx([approx,lit(rundt),!],_9870,_9872) --> 
    cc(rundt,_9870,_9872),
    !.

determiner0(plu,0,_9852,_9853,_9856::quant(ge/_9869,_9852)::_9853 and _9856,[determiner0,_9930,_9954],_9904,_9906) --> 
    morethan(_9930,_9904,_9945),
    number(_9869:_9877,_9954,_9945,_9906).

morethan([morethan,lit(minst)],_9867,_9869) --> 
    cc(minst,_9867,_9869).

morethan([morethan,lit(over)],_9867,_9869) --> 
    cc(over,_9867,_9869).

morethan([morethan,lit(mer),lit(enn)],_9872,_9874) --> 
    cc(mer,_9872,_9893),
    cc(enn,_9893,_9874).

determiner0(plu,0,_9852,_9853,_9856::quant(eq/_9869,_9852)::_9853 and _9856,[determiner0,_9942,_9966,_9995],_9916,_9918) --> 
    theplu0(_9942,_9916,_9957),
    number(_9869:_9889,_9966,_9957,_9983),
    not_look_ahead(w(noun(time,_9882,def,n)),_9995,_9983,_9918).

determiner0(sin,0,_9852,_9853,_9856::quant(eq/1,_9852)::_9853 and _9856,[determiner0,_9942,_9971,!],_9916,_9918) --> 
    w(nb(1,num),_9942,_9916,_9959),
    not_look_ahead(w(noun(time,_9887,def,n)),_9971,_9959,_9918),
    !.

determiner0(sin,0,_9852,_9853,_9856::_9857,[determiner0,{},_9941,_9965],_9905,_9907) --> 
    {user:value(dialog,1)},
    the(_9941,_9905,_9956),
    pushstack(first,this,nil,_9956,_10003),
    determiner(_9852,_9853,_9856::_9857,_9965,_10003,_9907).

determiner0(plu,0,_9852,_9853,_9856::_9857,[determiner0,_9931,_9955,_9984],_9905,_9907) --> 
    the(_9931,_9905,_9946),
    not_look_ahead(w(verb(_9876,pres,fin)),_9955,_9946,_9972),
    determiner00(_9852,_9853,_9856::_9857,_9984,_9972,_9907).

determiner0(_9850,0,_9852,_9853,_9856::_9857,[determiner0,_9917],_9891,_9893) --> 
    determiner(_9852,_9853,_9856::_9857,_9917,_9891,_9893).

determiner0(_9850,0,_9852,_9853,_9856::_9857,[determiner0,_9917],_9891,_9893) --> 
    determiner00(_9852,_9853,_9856::_9857,_9917,_9891,_9893).

determiner0(_9850,0,_9852,_9853,_9856::exists(_9852)::_9853 and _9856,[determiner0,_9918],_9892,_9894) --> 
    the0(_9918,_9892,_9894).

determiner00(_9860:_9861,_9851,_9854::_9851 and _9854,[determiner00,_9912,!],_9892,_9894) --> 
    the(_9860:_9861,_9912,_9892,_9894),
    !.

determiner00(_9850,_9851,_9854::exists(_9850)::_9851 and _9854,[determiner00,[]],_9886,_9886) --> 
    [].

determiner(_9850,_9851,_9854::forall(_9850)::_9851=>_9854,[determiner,lit(alle),_9922],_9891,_9893) --> 
    cc(alle,_9891,_9921),
    look_ahead_np(_9922,_9921,_9893).

determiner(_9850,_9851,_9854::forall(_9850)::_9851=>_9854,[determiner,lit(hver)],_9888,_9890) --> 
    cc(hver,_9888,_9890).

determiner(_9850,_9851,_9854::find(_9850)::_9851 and _9854,[determiner,_9909,_9933],_9889,_9891) --> 
    this(_9909,_9889,_9924),
    look_ahead_np(_9933,_9924,_9891).

determiner(_9850,_9851,_9854::_9851 and _9854,[determiner,_9903],_9883,_9885) --> 
    the(_9850,_9903,_9883,_9885).

determiner(_9850,_9851,_9854::exists(_9850)::_9851 and _9854,[determiner,_9927,_9951,_9975,_10004,!],_9907,_9909) --> 
    only0(_9927,_9907,_9942),
    art(_9951,_9942,_9966),
    look_ahead(w(noun(_9881,sin,u,n)),_9975,_9966,_9992),
    off0(_10004,_9992,_9909),
    !.

determiner(_9850,_9851,_9854::exists(_9850)::_9851 and _9854,[determiner,_9912,_9936,_9960],_9892,_9894) --> 
    only0(_9912,_9892,_9927),
    art(_9936,_9927,_9951),
    off0(_9960,_9951,_9894).

determiner(_9850,_9851,_9854::forall(_9850)::_9851=>_9854,[determiner,_9909,_9933],_9889,_9891) --> 
    every(_9909,_9889,_9924),
    look_ahead_np(_9933,_9924,_9891).

determiner(_9850,_9851,_9854::not (exists(_9850)::_9851 and _9854),[determiner,_9911,_9935],_9891,_9893) --> 
    no(_9911,_9891,_9926),
    look_ahead_np(_9935,_9926,_9893).

determiner(_9850,_9851,_9854::exists(_9850)::_9851 and not _9854,[determiner,_9911,_9935],_9891,_9893) --> 
    notall(_9911,_9891,_9926),
    look_ahead_np(_9935,_9926,_9893).

determiner(_9850,_9851,_9854::quant(all,_9850)::_9851 and _9854,[determiner,lit(hele)],_9889,_9891) --> 
    cc(hele,_9889,_9891).

determiner(_9850,_9851,_9854::_9855,[determiner,_9905],_9885,_9887) --> 
    quantifier(_9850,_9851,_9854::_9855,_9905,_9885,_9887).

quantifier(_9850,_9851,_9854::quant(eq/_9867,_9850)::_9851 and _9854,[quantifier,lit(bare),_9931],_9900,_9902) --> 
    cc(bare,_9900,_9930),
    w(nb(_9867,_9875),_9931,_9930,_9902).

quantifier(_9850,_9851,_9854::quant(few,_9850)::_9851 and _9854,[quantifier,_9913,_9937,_9961],_9893,_9895) --> 
    aso0(_9913,_9893,_9928),
    few(_9937,_9928,_9952),
    look_ahead_np(_9961,_9952,_9895).

quantifier(_9850,_9851,_9854::quant(most,_9850)::_9851 and _9854,[quantifier,lit(de),lit(fleste),_9939],_9897,_9899) --> 
    cc(de,_9897,_9927),
    cc(fleste,_9927,_9938),
    look_ahead_np(_9939,_9938,_9899).

quantifier(_9850,_9851,_9854::quant(much,_9850)::_9851 and _9854,[quantifier,_9917,_9941],_9897,_9899) --> 
    much(_9917,_9897,_9932),
    not_look_ahead(w(adj2(_9873,nil)),_9941,_9932,_9899).

quantifier(_9850,_9851,_9854::quant(little,_9850)::_9851 and _9854,[quantifier,_9917,_9941],_9897,_9899) --> 
    little(_9917,_9897,_9932),
    not_look_ahead(w(adj2(_9873,nil)),_9941,_9932,_9899).

quantifier(_9850,_9851,_9854::quant(many,_9850)::_9851 and _9854,[quantifier,_9913,_9937,_9961],_9893,_9895) --> 
    aso0(_9913,_9893,_9928),
    many(_9937,_9928,_9952),
    look_ahead_np(_9961,_9952,_9895).

quantifier(_9850,_9851,_9854::quant(most,_9850)::_9851 and _9854,[quantifier,_9913,_9937,_9961],_9893,_9895) --> 
    aso0(_9913,_9893,_9928),
    most(_9937,_9928,_9952),
    look_ahead_np(_9961,_9952,_9895).

quantifier(_9850,_9851,_9854::quant(all,_9850)::_9851 and _9854,[quantifier,lit(alle),_9923],_9892,_9894) --> 
    cc(alle,_9892,_9922),
    look_ahead_np(_9923,_9922,_9894).

quantifier(_9850,_9851,_9854::quant(ge/2,_9850)::_9851 and _9854,[quantifier,_9913,_9937],_9893,_9895) --> 
    several(_9913,_9893,_9928),
    look_ahead_np(_9937,_9928,_9895).

quantifier(_9850,_9851,_9854::quant(count,_9850)::_9851 and _9854,[quantifier,_9924,_9953,_9997],_9904,_9906) --> 
    w(noun(count,_9875,_9876,_9877),_9924,_9904,_9941),
    optional([av],_9953,_9941,_9985),
    look_ahead_np(_9997,_9985,_9906).

few([few,lit('få')],_9867,_9869) --> 
    cc('få',_9867,_9869).

few([few,lit('færre')],_9867,_9869) --> 
    cc('færre',_9867,_9869).

plausible_name(_9854:person,_9854 isa person,_9852,[plausible_name,_9929,_9968,{},!,_10022],_9909,_9911) --> 
    properfirstname(_9872,_9873,_9874,_9929,_9909,_9950),
    properlastname(_9876,_9877,_9852,_9968,_9950,_9989),
    {user:_9854=(_9872,_9876)},
    !,
    accept(_10022,_9989,_9911).

plausible_name(_9854:_9855,_9854 isa _9855,_9852,[plausible_name,_9925,{}],_9905,_9907) --> 
    w(name(_9854,_9852,_9855),_9925,_9905,_9907),
    {user:(\+_9855=0,\+_9855=date)}.

name_compound(_9850,_9851,_9852,[name_compound,_9941,_9970,_9999,_10028,_10067,_10111],_9921,_9923) --> 
    not_look_ahead([dere],_9941,_9921,_9958),
    not_look_ahead([du],_9970,_9958,_9987),
    not_look_ahead(w(nb(_9888,_9889)),_9999,_9987,_10016),
    plausible_name(_9871,_9872,_9893,_10028,_10016,_10049),
    s0(sin,u,_9893,_9869,_10067,_10049,_10090),
    ncomps0(_9869,_9851,_9871,_9872,_9852,_9850,_10111,_10090,_9923).

namep(name,_9854:street,_9854 isa street,[namep,_9944,_9973,_9997,_10026,{},!,_10070],_9924,_9926) --> 
    w(name(_9854,n,street),_9944,_9924,_9961),
    comma0(_9973,_9961,_9988),
    postcode(_9884,_9997,_9988,_10014),
    w(name(_9888,n,_9890),_10026,_10014,_10043),
    {user:testmember(_9890,[neighbourhood,city,station])},
    !,
    accept(_10070,_10043,_9926).

namep(_9850,_9851,_9852,[namep,_9941,_9970,_9999,_10028,_10067,_10111],_9921,_9923) --> 
    not_look_ahead([dere],_9941,_9921,_9958),
    not_look_ahead([du],_9970,_9958,_9987),
    not_look_ahead(w(nb(_9888,_9889)),_9999,_9987,_10016),
    plausible_name(_9871,_9872,_9893,_10028,_10016,_10049),
    s0(sin,u,_9893,_9869,_10067,_10049,_10090),
    ncomps0(_9869,_9851,_9871,_9872,_9852,_9850,_10111,_10090,_9923).

namep(name,_9854:thing,_9854 isa unkn,[namep,{},_9927,_9956],_9897,_9899) --> 
    {user:value(unknownflag,true)},
    unplausible_name(_9866,_9927,_9897,_9944),
    morenames(_9866,_9854,_9956,_9944,_9899).

namep(0,_9851,_9852,[namep,_9898],_9878,_9880) --> 
    measure(_9851,_9852,_9898,_9878,_9880).

namep(name,_9851,_9852,[namep,_9910,_9934],_9890,_9892) --> 
    you(_9910,_9890,_9925),
    pushstack(first,w(name(tuc,n,savant)),nil,_9925,_9944),
    nameq(_9851,_9852,_9934,_9944,_9892).

namep(0,_9851,_9852,[namep,_9913,_9942,!,_10001],_9893,_9895) --> 
    number(_9863,_9913,_9893,_9930),
    noun(_9865,plu,_9867,n,_9869,_9870,_9942,_9930,_9969),
    !,
    reject(_10001,_9969,_9895).

namep(0,_9851,_9852,[namep,_9998,_10022,{},_10081,_10110,_10139,_10173,{},{},_10222,_10251,!,_10285],_9978,_9980) --> 
    athe0(_9998,_9978,_10013),
    noun2(_9890,_9891,n,_9896:_9897,_9894,_10022,_10013,_10047),
    {user:(\+testmember(_9897,[thing]))},
    not_look_ahead([jeg],_10081,_10047,_10098),
    not_look_ahead([du],_10110,_10098,_10127),
    nameq(_9916,_9917,_10139,_10127,_10158),
    not_look_ahead([:],_10173,_10158,_10190),
    {user:compoundtest(_9890,_9891,_9896:_9897,_9916)},
    {user:align_noun_name(_9896:_9897,_9916,_9894,_9851,_9852)},
    optional_suffix(_9896:_9897,_10222,_10190,_10239),
    not_look_ahead(w(name(_9953,_9954,date)),_10251,_10239,_10268),
    !,
    accept(_10285,_10268,_9980).

namep(0,_9851,_9852,[namep,_9940,_9964,_9988,_10022,{},!,{}],_9920,_9922) --> 
    athe0(_9940,_9920,_9955),
    nr0(_9964,_9955,_9979),
    nameq1(_9875,_9881,_9988,_9979,_10007),
    noun(_9883,sin,u,n,_9874,_9876,_10022,_10007,_9922),
    {user:testmember(_9883,[bus,tram])},
    !,
    {user:align_noun_name(_9874,_9875,_9876,_9851,_9852)}.

namep(0,_9851,_9852,[namep,_9941,_9965,_9994,_10028,{},{}],_9921,_9923) --> 
    athe0(_9941,_9921,_9956),
    not_look_ahead([_9878],_9965,_9956,_9982),
    nameq1(_9872,_9882,_9994,_9982,_10013),
    noun(_9884,sin,_9886,n,_9871,_9873,_10028,_10013,_9923),
    {user:(\+testmember(_9884,[thing]))},
    {user:align_noun_name(_9871,_9872,_9873,_9851,_9852)}.

namep(name,_9851,_9852,[namep,_9905,_9934],_9885,_9887) --> 
    not_look_ahead([ett],_9905,_9885,_9922),
    nameq(_9851,_9852,_9934,_9922,_9887).

optional_suffix(_9852:_9853,[optional_suffix,_9907,{},!,_9951],_9893,_9895) --> 
    w(noun(_9866,_9867,_9868,n),_9907,_9893,_9924),
    {user:alignable(_9853,_9866)},
    !,
    accept(_9951,_9924,_9895).

optional_suffix(_9852:_9853,[optional_suffix,_9907,{},!,_9951],_9893,_9895) --> 
    w(noun(_9866,_9867,_9868,n),_9907,_9893,_9924),
    {user:alignable(_9853,_9866)},
    !,
    accept(_9951,_9924,_9895).

optional_suffix(_9852:_9853,[optional_suffix,_9886],_9872,_9874) --> 
    point0(_9886,_9872,_9874).

noun2(sin,u,n,_9856:thing,_9856 isa thing,[noun2,lit(_9871),{},_9957],_9910,_9912) --> 
    cc(_9871,_9910,_9946),
    {user:testmember(_9871,[de,disse,dem])},
    look_ahead([som],_9957,_9946,_9912).

noun2(plu,u,n,_9856:thing,_9856 isa thing,[noun2,lit(_9867),{},_9953],_9906,_9908) --> 
    cc(_9867,_9906,_9942),
    {user:testmember(_9867,[de,disse,dem])},
    not_look_ahead_np(_9953,_9942,_9908).

noun2(sin,u,n,_9856:agent,_9856 isa agent,[noun2,_9920,_9944],_9894,_9896) --> 
    agent_pronoun(_9920,_9894,_9935),
    look_ahead([som],_9944,_9935,_9896).

noun2(sin,u,n,_9856:thing,_9856 isa thing,[noun2,lit(det),_9933],_9896,_9898) --> 
    cc(det,_9896,_9932),
    look_ahead([som],_9933,_9932,_9898).

noun2(_9850,_9851,_9852,_9853,_9854,[noun2,_9947,{},_10011,!,_10040],_9921,_9923) --> 
    noun(_9868,_9850,_9851,_9852,_9853,_9854,_9947,_9921,_9974),
    {user:testmember(_9868,[monday,tuesday,wednesday,thursday,friday,saturday,sunday,month])},
    point0(_10011,_9974,_10026),
    !,
    accept(_10040,_10026,_9923).

noun2(_9850,_9851,_9852,_9856:_9857,_9854,[noun2,_9976,_10005,_10034,_10063,_10092,{},!,_10136],_9950,_9952) --> 
    w(noun(_9882,_9883,u,n),_9976,_9950,_9993),
    not_look_ahead(w(noun(number,sin,_9893,n)),_10005,_9993,_10022),
    not_look_ahead([nr],_10034,_10022,_10051),
    not_look_ahead(w(verb(_9904,_9905,_9906)),_10063,_10051,_10080),
    w(noun(_9910,_9850,_9851,_9852),_10092,_10080,_10109),
    {user:adjnoun_template(_9882,_9910,_9856:_9857,_9854)},
    !,
    accept(_10136,_10109,_9952).

noun2(_9850,_9851,_9852,_9853,_9854,[noun2,_9914],_9888,_9890) --> 
    noun(_9856,_9850,_9851,_9852,_9853,_9854,_9914,_9888,_9890).

noun2(sin,u,n,_9856:thing,_9856 isa thing,[noun2,_9923,_9947,!],_9897,_9899) --> 
    someone(_9923,_9897,_9938),
    look_ahead([som],_9947,_9938,_9899),
    !.

agent_pronoun([agent_pronoun,lit(jeg)],_9867,_9869) --> 
    cc(jeg,_9867,_9869).

agent_pronoun([agent_pronoun,lit(du)],_9867,_9869) --> 
    cc(du,_9867,_9869).

agent_pronoun([agent_pronoun,lit(noen)],_9867,_9869) --> 
    cc(noen,_9867,_9869).

agent_pronoun([agent_pronoun,lit(mange)],_9867,_9869) --> 
    cc(mange,_9867,_9869).

agent_pronoun([agent_pronoun,lit('få')],_9867,_9869) --> 
    cc('få',_9867,_9869).

agent_pronoun([agent_pronoun,lit(han)],_9867,_9869) --> 
    cc(han,_9867,_9869).

agent_pronoun([agent_pronoun,lit(ham)],_9867,_9869) --> 
    cc(ham,_9867,_9869).

agent_pronoun([agent_pronoun,lit(hun)],_9867,_9869) --> 
    cc(hun,_9867,_9869).

agent_pronoun([agent_pronoun,lit(henne)],_9867,_9869) --> 
    cc(henne,_9867,_9869).

agent_pronoun([agent_pronoun,lit(dere)],_9867,_9869) --> 
    cc(dere,_9867,_9869).

agent_pronoun([agent_pronoun,lit(alle)],_9867,_9869) --> 
    cc(alle,_9867,_9869).

noun(_9850,_9851,_9852,_9853,_9857:_9850,_9857 isa _9850,[noun,_9926],_9897,_9899) --> 
    w(noun(_9850,_9851,_9852,_9853),_9926,_9897,_9899).

measure(_9850,_9851,[measure,_9933,{},_9997,_10031,_10055,!,{}],_9916,_9918) --> 
    noun(_9879,_9880,_9881,n,_9873,_9875,_9933,_9916,_9960),
    {user:measureclass(_9879)},
    gmem(_9879,[crown],_9997,_9960,_10016),
    point0(_10031,_10016,_10046),
    anumber(_9874,_10055,_10046,_9918),
    !,
    {user:align_measure(_9873,_9874,_9875,_9850,_9851)}.

measure(_9850,_9851,[measure,_9930,_9959,_9983,_10037,_10061,{},{}],_9913,_9915) --> 
    anumber(_9874,_9930,_9913,_9947),
    point0(_9959,_9947,_9974),
    noun(_9881,_9882,_9883,n,_9873,_9875,_9983,_9974,_10010),
    point0(_10037,_10010,_10052),
    not_overon_clock(_9881,_10061,_10052,_9915),
    {user:measureclass(_9881)},
    {user:align_measure(_9873,_9874,_9875,_9850,_9851)}.

not_overon_clock(_9850,[not_overon_clock,{},_9941,{},_9980,!,_10014],_9917,_9919) --> 
    {user:testmember(_9850,[hour,minute,second])},
    prep1(_9878,_9941,_9917,_9958),
    {user:testmember(_9878,[on,before,over,after])},
    look_ahead(w(nb(_9897,_9898)),_9980,_9958,_9997),
    !,
    reject(_10014,_9997,_9919).

not_overon_clock(_9850,[not_overon_clock,[]],_9869,_9869) --> 
    [].

nameq(_9850,_9851,[nameq,_9902,_9936],_9885,_9887) --> 
    nameq1(_9850,_9851,_9902,_9885,_9921),
    not_look_ahead(w(nb(_9860,_9861)),_9936,_9921,_9887).

nameq(_9850,_9851,[nameq,_9902,_9936],_9885,_9887) --> 
    nameq2(_9850,_9851,_9902,_9885,_9921),
    not_look_ahead(w(nb(_9860,_9861)),_9936,_9921,_9887).

name1g('Rønning':lastname,'Rønning' isa lastname,_9852,[name1g,{},_9953,_9982,_10011,!,_10045],_9923,_9925) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',_9885,firstname)),_9953,_9923,_9970),
    w(name('Rønning',_9852,lastname),_9982,_9970,_9999),
    not_look_ahead(w(name(_9898,_9899,lastname)),_10011,_9999,_10028),
    !,
    accept(_10045,_10028,_9925).

name1g('Ståle':firstname,'Ståle' isa firstname,n,[name1g,{},_9953,_9982,_10011,!,_10045],_9923,_9925) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Ståle',_9885,lastname)),_9953,_9923,_9970),
    w(name('Ståle',n,firstname),_9982,_9970,_9999),
    look_ahead(w(name(_9898,_9899,lastname)),_10011,_9999,_10028),
    !,
    accept(_10045,_10028,_9925).

name1g('Rønning':lastname,'Rønning' isa lastname,_9852,[name1g,{},_9953,_9982,_10011,!,_10045],_9923,_9925) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',_9885,firstname)),_9953,_9923,_9970),
    w(name('Rønning',_9852,lastname),_9982,_9970,_9999),
    not_look_ahead(w(name(_9898,n,lastname)),_10011,_9999,_10028),
    !,
    accept(_10045,_10028,_9925).

name1g('Rønning':firstname,'Rønning' isa firstname,n,[name1g,{},_9953,_9982,_10011,!,_10045],_9923,_9925) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',_9885,lastname)),_9953,_9923,_9970),
    w(name('Rønning',n,firstname),_9982,_9970,_9999),
    look_ahead(w(name(_9898,n,lastname)),_10011,_9999,_10028),
    !,
    accept(_10045,_10028,_9925).

name1g(_9854:_9855,_9854 isa _9855,_9852,[name1g,_9908],_9888,_9890) --> 
    wnameg(_9854:_9855,_9852,_9855,_9908,_9888,_9890).

wnameg(_9854:_9852,gen,_9852,[wnameg,_9910,_9939,!],_9890,_9892) --> 
    w(name(_9854,n,_9852),_9910,_9890,_9927),
    sin(_9939,_9927,_9892),
    !.

wnameg(_9854:_9852,gen,_9852,[wnameg,_9910,_9939,!],_9890,_9892) --> 
    w(name(_9854,gen,_9852),_9910,_9890,_9927),
    sin(_9939,_9927,_9892),
    !.

wnameg(_9854:_9852,gen,_9852,[wnameg,_9907,!],_9887,_9889) --> 
    w(name(_9854,gen,_9852),_9907,_9887,_9889),
    !.

wnameg(_9854:_9852,n,_9852,[wnameg,_9904],_9884,_9886) --> 
    w(name(_9854,n,_9852),_9904,_9884,_9886).

nameq1('Rønning':lastname,'Rønning' isa lastname,[nameq1,{},_9947,_9976,_10005,!,_10039],_9920,_9922) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',n,firstname)),_9947,_9920,_9964),
    w(name('Rønning',n,lastname),_9976,_9964,_9993),
    not_look_ahead(w(name(_9897,n,lastname)),_10005,_9993,_10022),
    !,
    accept(_10039,_10022,_9922).

nameq1('Rønning':firstname,'Rønning' isa firstname,[nameq1,{},_9947,_9976,_10005,!,_10039],_9920,_9922) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',n,lastname)),_9947,_9920,_9964),
    w(name('Rønning',n,firstname),_9976,_9964,_9993),
    look_ahead(w(name(_9897,n,lastname)),_10005,_9993,_10022),
    !,
    accept(_10039,_10022,_9922).

nameq1(quote(_9859):_9857,quote(_9859)isa thing,[nameq1,_9914,!,{}],_9897,_9899) --> 
    w(quote(_9859),_9914,_9897,_9899),
    !,
    {user:type(thing,_9857)}.

nameq1(_9850,_9851,[nameq1,_9903,_9932,_9956,!,_9985],_9886,_9888) --> 
    number(_9865,_9903,_9886,_9920),
    point0(_9932,_9920,_9947),
    monthnamex(_9956,_9947,_9971),
    !,
    reject(_9985,_9971,_9888).

nameq1(_9850,_9851,[nameq1,_9907,_9936,!,_9970],_9890,_9892) --> 
    number(_9862,_9907,_9890,_9924),
    w(noun(hour,_9867,_9868,_9869),_9936,_9924,_9953),
    !,
    reject(_9970,_9953,_9892).

nameq1(_9850,_9851,[nameq1,_9910,_9939,_9963,!,_9997],_9893,_9895) --> 
    number(_9865,_9910,_9893,_9927),
    point(_9939,_9927,_9954),
    w(noun(_9869,_9870,_9871,_9872),_9963,_9954,_9980),
    !,
    reject(_9997,_9980,_9895).

nameq1(_9850,_9851,[nameq1,_9898,!,_9937],_9881,_9883) --> 
    obviousclock1(_9850,_9851,_9898,_9881,_9917),
    !,
    accept(_9937,_9917,_9883).

nameq1(_9853:_9857,_9853 isa clock,[nameq1,_9911,_9935,!,{}],_9894,_9896) --> 
    clock0(_9911,_9894,_9926),
    time2(_9853,_9935,_9926,_9896),
    !,
    {user:type(clock,_9857)}.

nameq1(_9853:_9857,_9853 isa clock,[nameq1,_9904],_9887,_9889) --> 
    plausibleclock1(_9853:_9857,_9853 isa clock,_9904,_9887,_9889).

nameq1(_9850,_9851,[nameq1,_9892],_9875,_9877) --> 
    date(_9850,_9851,_9892,_9875,_9877).

nameq1(_9853:_9854,_9851,[nameq1,_9908,_9932,!,_9966],_9891,_9893) --> 
    one(_9908,_9891,_9923),
    w(noun(_9867,sin,u,n),_9932,_9923,_9949),
    !,
    reject(_9966,_9949,_9893).

nameq1(_9853:_9857,_9853 isa _9854,[nameq1,_9938,{},{},_9987,!,_10021],_9921,_9923) --> 
    w(name(_9853,_9877,_9854),_9938,_9921,_9955),
    {user:atom(_9853)},
    {user:testmember(_9854,[language,colour])},
    look_ahead(w(noun(_9897,_9898,_9899,_9900)),_9987,_9955,_10004),
    !,
    reject(_10021,_10004,_9923).

nameq1(_9853:_9857,_9853 isa _9854,[nameq1,_9952,_9981,{},{},{},{}],_9935,_9937) --> 
    not_look_ahead(w(name,_9882,gen,_9884),_9952,_9935,_9969),
    w(name(_9853,_9889,_9854),_9981,_9969,_9937),
    {user:_9853\==1},
    {user:(_9854==unkn->value(unknownflag,true);true)},
    {user:_9889\==gen},
    {user:type(_9854,_9857)}.

nameq1(_9853:_9857,_9853 isa _9854,[nameq1,_9947,_9971,_10000,_10024,{},{},{}],_9930,_9932) --> 
    nr0(_9947,_9930,_9962),
    w(name(_9853,n,_9854),_9971,_9962,_9988),
    point0(_10000,_9988,_10015),
    not_look_ahead(w(name(_9892,_9893,date)),_10024,_10015,_9932),
    {user:(_9854==unkn->value(unknownflag,true))},
    {user:number(_9853)},
    {user:type(_9854,_9857)}.

nameq1(_9853:_9854,_9851,[nameq1,_9911,{}],_9894,_9896) --> 
    timeq1(_9853:_9854,_9851,_9911,_9894,_9896),
    {user:(number(_9853),_9853>=100)}.

nameq1(_9853:year,_9853 isa year,[nameq1,_9919,{}],_9902,_9904) --> 
    w(nb(_9853,num),_9919,_9902,_9904),
    {user:(number(_9853),_9853>=1900,_9853=<2099)}.

date(_9853:date,_9853 isa date,[date,_9981,{},_10020,_10044,!,{},{},{},{}],_9964,_9966) --> 
    num_na(_9892,_9981,_9964,_9998),
    {user:(_9892>=1,_9892=<7)},
    slashpoint0(_10020,_9998,_10035),
    w(name(new_years_day,n,date),_10044,_10035,_9966),
    !,
    {user:datetime(_9913,_9914,_9915,_9916,_9917,_9918)},
    {user:(_9914>1->_9888 is _9913+1;_9888 is _9913)},
    {user:_9890 is _9892},
    {user:_9853=date(_9888,1,_9890)}.

date(_9853:date,_9853 isa date,[date,_9972,{},_10011,_10035,{},!,{}],_9955,_9957) --> 
    num_na(_9889,_9972,_9955,_9989),
    {user:(_9889>=1,_9889=<7)},
    slashpoint0(_10011,_9989,_10026),
    w(name(_9904,n,date),_10035,_10026,_9957),
    {user:testmember(_9904,[whitsun_day,easterday,christmas_day])},
    !,
    {user:(named_date(_9904,date(_9922,_9923,_9924)),_9886 is _9889-1,add_days(date(_9922,_9923,_9924),_9886,_9853))}.

date(_9853:date,_9853 isa date,[date,_9928,_9957,_9981,_10010,_10034,!,{}],_9911,_9913) --> 
    dayno(_9884,_9928,_9911,_9945),
    slashpoint0(_9957,_9945,_9972),
    month(_9883,_9981,_9972,_9998),
    slashpoint0(_10010,_9998,_10025),
    year(_9882,_10034,_10025,_9913),
    !,
    {user:_9853=date(_9882,_9883,_9884)}.

date(_9853:date,_9853 isa date,[date,_9943,_9972,_9996,_10025,{},!,_10064,{}],_9926,_9928) --> 
    dayno(_9887,_9943,_9926,_9960),
    slashpoint(_9972,_9960,_9987),
    month(_9886,_9996,_9987,_10013),
    point0(_10025,_10013,_10040),
    {user:(_9887>24;_9886>0)},
    !,
    xyear0(_9886,_9885,_10064,_10040,_9928),
    {user:_9853=date(_9885,_9886,_9887)}.

date(_9853:date,_9853 isa date,[date,_9929,_9958,_9982,_10011,!,_10050,{}],_9912,_9914) --> 
    dayno(_9884,_9929,_9912,_9946),
    slashpoint0(_9958,_9946,_9973),
    monthname(_9883,_9982,_9973,_9999),
    xyear0(_9883,_9882,_10011,_9999,_10030),
    !,
    accept(_10050,_10030,_9914),
    {user:_9853=date(_9882,_9883,_9884)}.

date(_9853:date,_9853 isa date,[date,_9931,_9960,_9989,!,_10023,{},!,_10062],_9914,_9916) --> 
    year(_9880,_9931,_9914,_9948),
    month(_9882,_9960,_9948,_9977),
    dayno(_9884,_9989,_9977,_10006),
    !,
    accept(_10023,_10006,_10038),
    {user:_9853=date(_9880,_9882,_9884)},
    !,
    accept(_10062,_10038,_9916).

timeq1(_9853:clock,_9853 isa clock,[timeq1,lit(halv),_9933,{},!,_9977],_9905,_9907) --> 
    cc(halv,_9905,_9932),
    hours(_9873,_9933,_9932,_9950),
    {user:_9853 is _9873*100-70},
    !,
    accept(_9977,_9950,_9907).

timeq1(_9853:clock,_9853 isa clock,[timeq1,_9903,!,_9937],_9886,_9888) --> 
    time12(_9853,_9903,_9886,_9920),
    !,
    accept(_9937,_9920,_9888).

clock_sequel(_9853:clock,_9853 isa clock,[clock_sequel,_9907,!],_9890,_9892) --> 
    clock_kernel(_9853:clock,_9853 isa clock,_9907,_9890,_9892),
    !.

clock_sequel(_9853:clock,_9853 isa clock,[clock_sequel,_9951,{},_9990,_10019,_10043,{},!,{}],_9934,_9936) --> 
    w(nb(_9890,num),_9951,_9934,_9968),
    {user:_9890<100},
    not_look_ahead([/],_9990,_9968,_10007),
    point(_10019,_10007,_10034),
    w(nb(_9886,num),_10043,_10034,_9936),
    {user:_9886<100},
    !,
    {user:_9853 is _9890*100+_9886}.

clock_sequel(_9853:clock,_9853 isa clock,[clock_sequel,_9936,_9965,{}],_9919,_9921) --> 
    w(nb(_9871,num),_9936,_9919,_9953),
    not_look_ahead([/],_9965,_9953,_9921),
    {user:(_9871>0,_9871<25->_9853 is _9871*100;_9853 is _9871)}.

clock_kernel(_9853:clock,_9853 isa clock,[clock_kernel,_9918,{},!],_9901,_9903) --> 
    number(_9853:_9868,_9918,_9901,_9903),
    {user:(_9853>2500,\+clock_test(_9853))},
    !.

clock_kernel(_9850,_9851,[clock_kernel,lit('nå'),!,_9913],_9880,_9882) --> 
    cc('nå',_9880,_9907),
    !,
    reject(_9913,_9907,_9882).

clock_kernel(_9850,_9851,[clock_kernel,lit(en),!,_9913],_9880,_9882) --> 
    cc(en,_9880,_9907),
    !,
    reject(_9913,_9907,_9882).

clock_kernel(_9850,_9851,[clock_kernel,lit(et),!,_9913],_9880,_9882) --> 
    cc(et,_9880,_9907),
    !,
    reject(_9913,_9907,_9882).

clock_kernel(_9853:clock,_9853 isa clock,[clock_kernel,_9979,_10008,_10037,{},_10076,_10105,_10134,_10163,!,_10212],_9962,_9964) --> 
    not_look_ahead(w(name(_9890,n,route)),_9979,_9962,_9996),
    not_look_ahead(w(name(_9898,n,nightbus)),_10008,_9996,_10025),
    w(nb(_9853,num),_10037,_10025,_10054),
    {user:(_9853>=100,clock_test(_9853))},
    not_look_ahead(w(noun(_9921,plu,_9923,_9924)),_10076,_10054,_10093),
    not_look_ahead([tusen],_10105,_10093,_10122),
    not_look_ahead([millioner],_10134,_10122,_10151),
    optional(w(noun(time,sin,def,n)),_10163,_10151,_10195),
    !,
    accept(_10212,_10195,_9964).

clock_kernel(_9850,_9851,[clock_kernel,_9905,_9934,_9958,!,_9992],_9888,_9890) --> 
    num_na(_9865,_9905,_9888,_9922),
    point0(_9934,_9922,_9949),
    monthname(_9867,_9958,_9949,_9975),
    !,
    reject(_9992,_9975,_9890).

clock_kernel(_9853:clock,_9853 isa clock,[clock_kernel,{},_9938,_9967,_9996,!,_10030],_9911,_9913) --> 
    {user:value(busflag,true)},
    hours(_9882,_9938,_9911,_9955),
    colemin0(_9884,_9967,_9955,_9984),
    w(name(_9888,_9889,month),_9996,_9984,_10013),
    !,
    reject(_10030,_10013,_9913).

clock_kernel(_9853:clock,_9853 isa clock,[clock_kernel,{},_9940,_9969,{},!,_10013],_9913,_9915) --> 
    {user:value(busflag,true)},
    hours(_9882,_9940,_9913,_9957),
    colemin0(_9884,_9969,_9957,_9986),
    {user:dedicated_date(date(_9890,_9882,_9884))},
    !,
    reject(_10013,_9986,_9915).

clock_kernel(_9850,_9851,[clock_kernel,_9918,_9947,_9976,{},!,_10020],_9901,_9903) --> 
    hours(_9868,_9918,_9901,_9935),
    colemin2(_9870,_9947,_9935,_9964),
    w(nb(_9874,num),_9976,_9964,_9993),
    {user:_9874>=60},
    !,
    reject(_10020,_9993,_9903).

clock_kernel(_9853:clock,_9853 isa clock,[clock_kernel,_9931,_9960,!,_9994,{}],_9914,_9916) --> 
    hours24(_9879,_9931,_9914,_9948),
    colemin2(_9877,_9960,_9948,_9977),
    !,
    optional(w(noun(time,sin,def,n)),_9994,_9977,_9916),
    {user:_9853 is _9879*100+_9877}.

clock_kernel(_9853:clock,_9853 isa clock,[clock_kernel,_9903,!,_9937],_9886,_9888) --> 
    time012(_9853,_9903,_9886,_9920),
    !,
    accept(_9937,_9920,_9888).

clock_kernel(_9853:clock,_9853 isa clock,[clock_kernel,_9897],_9880,_9882) --> 
    timeoff(_9853,_9897,_9880,_9882).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(et)],_9880,_9882) --> 
    cc(et,_9880,_9882).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(en)],_9880,_9882) --> 
    cc(en,_9880,_9882).

clock_kernel(_9853:clock,_9853 isa clock,[clock_kernel,_9953,{},_9992,_10021,{}],_9936,_9938) --> 
    w(nb(_9878,num),_9953,_9936,_9970),
    {user:_9878>9},
    not_look_ahead(w(noun(minute,_9891,_9892,_9893)),_9992,_9970,_10009),
    not_look_ahead([/],_10021,_10009,_9938),
    {user:(_9878>0,_9878<25->_9853 is _9878*100;fail)}.

namenb(1,[namenb,lit(ett),_9912,!,_9946],_9887,_9889) --> 
    cc(ett,_9887,_9911),
    w(noun(_9865,_9866,_9867,_9868),_9912,_9911,_9929),
    !,
    reject(_9946,_9929,_9889).

namenb(1,[namenb,lit(ett),!,_9907],_9877,_9879) --> 
    cc(ett,_9877,_9901),
    !,
    accept(_9907,_9901,_9879).

namenb(_9850,[namenb,_9889,!,_9918],_9875,_9877) --> 
    a(_9889,_9875,_9904),
    !,
    reject(_9918,_9904,_9877).

namenb(_9850,[namenb,_9889],_9875,_9877) --> 
    w(name(_9850,n,_9856),_9889,_9875,_9877).

namenb(_9850,[namenb,_9888],_9874,_9876) --> 
    w(nb(_9850,num),_9888,_9874,_9876).

dayno(_9850,[dayno,_9899,{}],_9885,_9887) --> 
    num_na(_9850,_9899,_9885,_9887),
    {user:(_9850>0,_9850=<31)}.

month(_9850,[month,_9888,!],_9874,_9876) --> 
    monthnamed(_9850,_9888,_9874,_9876),
    !.

month(_9850,[month,_9885],_9871,_9873) --> 
    monthnum(_9850,_9885,_9871,_9873).

monthnamed(_9850,[monthnamed,_9891,_9920,!],_9877,_9879) --> 
    monthname(_9850,_9891,_9877,_9908),
    point0(_9920,_9908,_9879),
    !.

monthname(_9850,[monthname,_9897,{}],_9883,_9885) --> 
    w(name(_9857,n,_9864),_9897,_9883,_9885),
    {user:monthnumber(_9857,_9850)}.

monthnum(_9850,[monthnum,_9902,{}],_9888,_9890) --> 
    number(_9850:_9866,_9902,_9888,_9890),
    {user:(_9850>0,_9850=<12)}.

monthnamex([monthnamex,_9878],_9867,_9869) --> 
    monthname(_9850,_9878,_9867,_9869).

monthnamex([monthnamex,_9890,{}],_9879,_9881) --> 
    w(name(_9855,_9861,_9862),_9890,_9879,_9881),
    {user:named_date(_9855,_9856)}.

day(_9850,[day,_9897,{}],_9883,_9885) --> 
    w(noun(_9850,_9862,_9863,_9864),_9897,_9883,_9885),
    {user:dayname(_9850)}.

day(weekday,[day,_9890],_9876,_9878) --> 
    w(noun(weekday,_9855,_9856,_9857),_9890,_9876,_9878).

xyear0(_9850,_9851,[xyear0,_9900,_9924,!,_9958],_9883,_9885) --> 
    aar0(_9900,_9883,_9915),
    year(_9851,_9924,_9915,_9941),
    !,
    accept(_9958,_9941,_9885).

xyear0(_9850,_9851,[xyear0,{},{}],_9885,_9885) --> 
    {user:this_year(_9859)},
    {user:adjust_year(_9850,_9859,_9851)}.

year0(_9850,[year0,_9894,_9918,!,_9952],_9880,_9882) --> 
    aar0(_9894,_9880,_9909),
    year(_9850,_9918,_9909,_9935),
    !,
    accept(_9952,_9935,_9882).

year0(_9850,[year0,{}],_9873,_9873) --> 
    {user:this_year(_9850)}.

aar0([aar0,_9889,_9913,!],_9878,_9880) --> 
    point0(_9889,_9878,_9904),
    w(noun(year,_9859,_9860,n),_9913,_9904,_9880),
    !.

aar0([aar0,_9876],_9865,_9867) --> 
    point0(_9876,_9865,_9867).

year(_9850,[year,{},_9929,{},!,_9973],_9905,_9907) --> 
    {user:value(busflag,true)},
    number(_9850:_9875,_9929,_9905,_9946),
    {user:(_9850>=2000,_9850=<9999)},
    !,
    accept(_9973,_9946,_9907).

year(_9850,[year,_9908,{},!,_9952],_9894,_9896) --> 
    number(_9850:_9864,_9908,_9894,_9925),
    {user:(_9850>=1000,_9850=<9999)},
    !,
    accept(_9952,_9925,_9896).

year(_9850,[year,_9919,{},!,_9963,{}],_9905,_9907) --> 
    number(_9869:_9875,_9919,_9905,_9936),
    {user:(_9869>=0,_9869=<99)},
    !,
    accept(_9963,_9936,_9907),
    {user:_9850 is _9869+2000}.

timexp(_9850,[timexp,_9888,_9912],_9874,_9876) --> 
    clock0(_9888,_9874,_9903),
    time2(_9850,_9912,_9903,_9876).

timexp(_9850,[timexp,_9888,_9912],_9874,_9876) --> 
    clock0(_9888,_9874,_9903),
    time1(_9850,_9912,_9903,_9876).

timenexp(_9850,[timenexp,_9888,_9912],_9874,_9876) --> 
    clock(_9888,_9874,_9903),
    time2(_9850,_9912,_9903,_9876).

timenexp(_9850,[timenexp,_9888,_9912],_9874,_9876) --> 
    clock(_9888,_9874,_9903),
    time1(_9850,_9912,_9903,_9876).

clock_time(1300,[clock_time,_9889,!,_9918],_9875,_9877) --> 
    a(_9889,_9875,_9904),
    !,
    accept(_9918,_9904,_9877).

clock_time(1300,[clock_time,lit('nå'),!,_9907],_9877,_9879) --> 
    cc('nå',_9877,_9901),
    !,
    reject(_9907,_9901,_9879).

clock_time(_9850,[clock_time,_9910,_9939,{},_9978],_9896,_9898) --> 
    hours(_9864,_9910,_9896,_9927),
    colemin0(_9866,_9939,_9927,_9956),
    {user:_9861 is _9864*100+_9866},
    ampm0(_9861,_9850,_9978,_9956,_9898).

clock_time(_9850,[clock_time,_9885],_9871,_9873) --> 
    time12(_9850,_9885,_9871,_9873).

time012(_9850,[time012,_9885],_9871,_9873) --> 
    time12(_9850,_9885,_9871,_9873).

time012(_9850,[time012,_9938,{},_9977,_10006,{}],_9924,_9926) --> 
    w(nb(_9875,num),_9938,_9924,_9955),
    {user:_9875>1},
    not_look_ahead(w(noun(minute,_9893,_9894,_9895)),_9977,_9955,_9994),
    not_look_ahead([/],_10006,_9994,_9926),
    {user:(_9875>0,_9875<25,_9850 is _9875*100)}.

time012(100,[time012,_9901,_9930,_9959,!],_9887,_9889) --> 
    w(nb(1,num),_9901,_9887,_9918),
    not_look_ahead([/],_9930,_9918,_9947),
    not_look_ahead_np(_9959,_9947,_9889),
    !.

time12(_9850,[time12,_9895,_9924],_9881,_9883) --> 
    time2(_9850,_9895,_9881,_9912),
    w(noun(time,sin,def,n),_9924,_9912,_9883).

time12(_9850,[time12,_9885],_9871,_9873) --> 
    time2(_9850,_9885,_9871,_9873).

time12(_9850,[time12,_9898,_9927,_9951],_9884,_9886) --> 
    time1(_9850,_9898,_9884,_9915),
    point0(_9927,_9915,_9942),
    w(noun(time,sin,def,n),_9951,_9942,_9886).

timeoff(_9850,[timeoff,_9929,{},_9968,_9992,{},{}],_9915,_9917) --> 
    w(nb(_9877,num),_9929,_9915,_9946),
    {user:_9877<100},
    colon0(_9968,_9946,_9983),
    w(nb(_9873,num),_9992,_9983,_9917),
    {user:_9873<100},
    {user:_9850 is _9877*100+_9873}.

time1(_9850,[time1,_9894,!,_9928],_9880,_9882) --> 
    w(nb(0,_9861),_9894,_9880,_9911),
    !,
    reject(_9928,_9911,_9882).

time1(_9850,[time1,lit(ett),_9924,_9953,!,_9987],_9899,_9901) --> 
    cc(ett,_9899,_9923),
    not_look_ahead(w(noun(time,_9871,def,_9873)),_9924,_9923,_9941),
    w(noun(_9877,_9878,_9879,_9880),_9953,_9941,_9970),
    !,
    reject(_9987,_9970,_9901).

time1(100,[time1,lit(ett),_9914,!,_9963],_9889,_9891) --> 
    cc(ett,_9889,_9913),
    optional(w(noun(time,_9868,def,_9870)),_9914,_9913,_9946),
    !,
    accept(_9963,_9946,_9891).

time1(_9850,[time1,_9901,_9925,!,_9959],_9887,_9889) --> 
    a(_9901,_9887,_9916),
    not_look_ahead(w(noun(time,_9866,def,_9868)),_9925,_9916,_9942),
    !,
    reject(_9959,_9942,_9889).

time1(_9850,[time1,_9897,_9926,!,_9965],_9883,_9885) --> 
    time3(_9861,_9897,_9883,_9914),
    ampm0(_9861,_9850,_9926,_9914,_9945),
    !,
    accept(_9965,_9945,_9885).

time1(_9850,[time1,_9935,_9964,_9993,{},!,{},_10047],_9921,_9923) --> 
    w(nb(_9875,num),_9935,_9921,_9952),
    not_look_ahead(w(noun(hour,_9883,_9884,_9885)),_9964,_9952,_9981),
    not_look_ahead([t],_9993,_9981,_10010),
    {user:_9875<25},
    !,
    {user:_9870 is _9875*100},
    ampm0(_9870,_9850,_10047,_10010,_9923).

time1(now,[time1,lit('nå'),lit(av),!,_9923],_9882,_9884) --> 
    cc('nå',_9882,_9906),
    cc(av,_9906,_9917),
    !,
    reject(_9923,_9917,_9884).

time1(now,[time1,lit('nå')],_9871,_9873) --> 
    cc('nå',_9871,_9873).

time2(_9850,[time2,_9935,{},_9974,_9998,{},!,_10042,{}],_9921,_9923) --> 
    hours24(_9881,_9935,_9921,_9952),
    {user:_9881=<25},
    point(_9974,_9952,_9989),
    num(_9879,_9998,_9989,_10015),
    {user:(_9879>12,_9879<60)},
    !,
    accept(_10042,_10015,_9923),
    {user:_9850 is _9881*100+_9879}.

time2(_9850,[time2,_9919,_9948,!,{},_9992,{}],_9905,_9907) --> 
    num(_9873,_9919,_9905,_9936),
    w(prep(over),_9948,_9936,_9965),
    !,
    {user:_9873<60},
    hours30(_9872,_9992,_9965,_9907),
    {user:_9850 is _9872+_9873}.

time2(_9850,[time2,_9918,_9947,_9971,!,{},_10010,{}],_9904,_9906) --> 
    num(_9876,_9918,_9904,_9935),
    minutes(_9947,_9935,_9962),
    overclock(_9971,_9962,_9986),
    !,
    {user:_9876<60},
    hours30(_9875,_10010,_9986,_9906),
    {user:_9850 is _9875+_9876}.

time2(_9850,[time2,_9917,{},_9956,!,_9990,{}],_9903,_9905) --> 
    num(_9870,_9917,_9903,_9934),
    {user:_9870<60},
    w(prep(on),_9956,_9934,_9973),
    !,
    hours30(_9869,_9990,_9973,_9905),
    {user:subfromtime(_9869,_9870,_9850)}.

time2(_9850,[time2,_9919,_9948,_9972,!,{},_10011,_10035,{}],_9905,_9907) --> 
    num(_9876,_9919,_9905,_9936),
    minutes(_9948,_9936,_9963),
    onclock(_9972,_9963,_9987),
    !,
    {user:_9876<60},
    clock0(_10011,_9987,_10026),
    hours30(_9875,_10035,_10026,_9907),
    {user:subfromtime(_9875,_9876,_9850)}.

time2(_9850,[time2,_9925,lit(halv),_9980,{},_10019],_9911,_9913) --> 
    optional(w(prep(in)),_9925,_9911,_9957),
    cc(halv,_9957,_9979),
    hours100(_9881,_9980,_9979,_9997),
    {user:_9850 is _9881-100+30},
    optional(w(noun(time,sin,def,n)),_10019,_9997,_9913).

time2(_9850,[time2,lit(halv),_9920,!,_9954,{}],_9895,_9897) --> 
    cc(halv,_9895,_9919),
    prep1(over,_9920,_9919,_9937),
    !,
    hours100(_9869,_9954,_9937,_9897),
    {user:_9850 is _9869+30}.

time2(_9850,[time2,lit(kvart),_9918,_9942,{}],_9893,_9895) --> 
    cc(kvart,_9893,_9917),
    onclock(_9918,_9917,_9933),
    hours100(_9871,_9942,_9933,_9895),
    {user:_9850 is _9871-100+45}.

time2(_9850,[time2,lit(kvart),_9918,_9942,{}],_9893,_9895) --> 
    cc(kvart,_9893,_9917),
    overclock(_9918,_9917,_9933),
    hours(_9871,_9942,_9933,_9895),
    {user:_9850 is _9871*100+15}.

time2(_9850,[time2,_9912,_9941,_9970,{},!,_10014],_9898,_9900) --> 
    hours(_9867,_9912,_9898,_9929),
    minutes(_9869,_9941,_9929,_9958),
    number(_9873:_9874,_9970,_9958,_9987),
    {user:_9873>24},
    !,
    reject(_10014,_9987,_9900).

time2(_9850,[time2,_9905,_9934,_9963,!,_9997],_9891,_9893) --> 
    hours(_9864,_9905,_9891,_9922),
    minutes(_9866,_9934,_9922,_9951),
    w(name(_9870,_9871,month),_9963,_9951,_9980),
    !,
    reject(_9997,_9980,_9893).

time2(_9850,[time2,_9910,_9939,{},_9978],_9896,_9898) --> 
    hours24(_9864,_9910,_9896,_9927),
    colemin(_9866,_9939,_9927,_9956),
    {user:_9861 is _9864*100+_9866},
    ampm0(_9861,_9850,_9978,_9956,_9898).

time2(_9850,[time2,_9904,_9933,_9962,_9986,!,_10020],_9890,_9892) --> 
    hours(_9867,_9904,_9890,_9921),
    minutes(_9869,_9933,_9921,_9950),
    point(_9962,_9950,_9977),
    minutes(_9871,_9986,_9977,_10003),
    !,
    reject(_10020,_10003,_9892).

time2(_9850,[time2,_9918,_9947,{},{},_9996],_9904,_9906) --> 
    hours24(_9867,_9918,_9904,_9935),
    minutes(_9869,_9947,_9935,_9964),
    {user:_9869>12},
    {user:_9864 is _9867*100+_9869},
    ampm0(_9864,_9850,_9996,_9964,_9906).

onclock([onclock,_9895,{},_9934],_9884,_9886) --> 
    w(prep(_9858),_9895,_9884,_9912),
    {user:testmember(_9858,[on,before])},
    clock0(_9934,_9912,_9886).

overclock([overclock,_9895,{},_9934],_9884,_9886) --> 
    w(prep(_9858),_9895,_9884,_9912),
    {user:testmember(_9858,[over,after])},
    clock0(_9934,_9912,_9886).

hours30(_9850,[hours30,lit(halv),_9921,{},!,_9965],_9896,_9898) --> 
    cc(halv,_9896,_9920),
    hours(_9866,_9921,_9920,_9938),
    {user:_9850 is _9866*100-70},
    !,
    accept(_9965,_9938,_9898).

hours30(_9850,[hours30,_9885],_9871,_9873) --> 
    hours100(_9850,_9885,_9871,_9873).

hours100(_9850,[hours100,_9896,_9925,!,_9959],_9882,_9884) --> 
    num(_9850,_9896,_9882,_9913),
    monthname(_9863,_9925,_9913,_9942),
    !,
    reject(_9959,_9942,_9884).

hours100(_9850,[hours100,_9917,{},!,_9961],_9903,_9905) --> 
    num(_9850,_9917,_9903,_9934),
    {user:(_9850 is _9850//100*100,_9850>100,_9850<2500)},
    !,
    accept(_9961,_9934,_9905).

hours100(_9850,[hours100,_9896,{}],_9882,_9884) --> 
    hours(_9860,_9896,_9882,_9884),
    {user:_9850 is _9860*100}.

hours100(100,[hours100,lit(ett),!,_9907],_9877,_9879) --> 
    cc(ett,_9877,_9901),
    !,
    accept(_9907,_9901,_9879).

hours100(1300,[hours100,lit(et),!,_9907],_9877,_9879) --> 
    cc(et,_9877,_9901),
    !,
    accept(_9907,_9901,_9879).

time3(_9850,[time3,_9896,{}],_9882,_9884) --> 
    w(nb(_9850,num),_9896,_9882,_9884),
    {user:_9850>=60}.

ampm0(_9850,_9850,[ampm0,_9895,!,_9924],_9878,_9880) --> 
    amtime(_9895,_9878,_9910),
    !,
    accept(_9924,_9910,_9880).

ampm0(_9850,_9851,[ampm0,_9915,!,{}],_9898,_9900) --> 
    pmtime(_9915,_9898,_9900),
    !,
    {user:(_9850>1200->_9851 is _9850;_9851 is _9850+1200)}.

ampm0(_9850,_9850,[ampm0,lit(h),!],_9877,_9879) --> 
    cc(h,_9877,_9879),
    !.

ampm0(_9850,_9850,[ampm0,[]],_9872,_9872) --> 
    [].

amtime([amtime,lit(am)],_9867,_9869) --> 
    cc(am,_9867,_9869).

amtime([amtime,lit(a),lit(m)],_9872,_9874) --> 
    cc(a,_9872,_9893),
    cc(m,_9893,_9874).

pmtime([pmtime,lit(pm)],_9867,_9869) --> 
    cc(pm,_9867,_9869).

pmtime([pmtime,lit(p),lit(m)],_9872,_9874) --> 
    cc(p,_9872,_9893),
    cc(m,_9893,_9874).

hours24(_9850,[hours24,_9885],_9871,_9873) --> 
    hours(_9850,_9885,_9871,_9873).

hours(_9850,[hours,_9903,_9932,_9961,!,_9990],_9889,_9891) --> 
    not_look_ahead([ett],_9903,_9889,_9920),
    not_look_ahead([et],_9932,_9920,_9949),
    a(_9961,_9949,_9976),
    !,
    reject(_9990,_9976,_9891).

hours(_9850,[hours,_9903,{},_9942],_9889,_9891) --> 
    w(nb(_9850,num),_9903,_9889,_9920),
    {user:_9850=<25},
    optional([h],_9942,_9920,_9891).

smallhours(_9850,[smallhours,_9902,{}],_9888,_9890) --> 
    w(nb(_9850,num),_9902,_9888,_9890),
    {user:(_9850>31,_9850=<59)}.

minutes0([minutes0,_9882,!,_9911],_9871,_9873) --> 
    minutes(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

minutes0([minutes0,[]],_9865,_9865) --> 
    [].

minutes([minutes,_9889,!,_9923],_9878,_9880) --> 
    w(noun(minute,_9859,_9860,_9861),_9889,_9878,_9906),
    !,
    accept(_9923,_9906,_9880).

colemin0(_9850,[colemin0,_9891,!,_9925],_9877,_9879) --> 
    colemin(_9850,_9891,_9877,_9908),
    !,
    accept(_9925,_9908,_9879).

colemin0(_9850,[colemin0,_9894,_9918,!,_9952],_9880,_9882) --> 
    point0(_9894,_9880,_9909),
    minutes0(_9850,_9918,_9909,_9935),
    !,
    accept(_9952,_9935,_9882).

colemin2(_9850,[colemin2,_9899,_9928,_9952,!,_9986],_9885,_9887) --> 
    minutes(_9864,_9899,_9885,_9916),
    point(_9928,_9916,_9943),
    minutes(_9866,_9952,_9943,_9969),
    !,
    reject(_9986,_9969,_9887).

colemin2(_9850,[colemin2,_9897,_9921,_9950,!,_9979],_9883,_9885) --> 
    colon(_9897,_9883,_9912),
    minutes(_9850,_9921,_9912,_9938),
    colesec0(_9950,_9938,_9965),
    !,
    accept(_9979,_9965,_9885).

colemin2(_9850,[colemin2,_9897,_9921,!,_9955],_9883,_9885) --> 
    colon(_9897,_9883,_9912),
    w(nb(_9850,num),_9921,_9912,_9938),
    !,
    reject(_9955,_9938,_9885).

colemin2(0,[colemin2,_9889,!,_9918],_9875,_9877) --> 
    colon(_9889,_9875,_9904),
    !,
    accept(_9918,_9904,_9877).

colemin2(_9850,[colemin2,_9894,_9918,_9947,!],_9880,_9882) --> 
    point0(_9894,_9880,_9909),
    minutes(_9850,_9918,_9909,_9935),
    point0(_9947,_9935,_9882),
    !.

colemin2(_9850,[colemin2,_9891,_9920,!],_9877,_9879) --> 
    minutes(_9850,_9891,_9877,_9908),
    point0(_9920,_9908,_9879),
    !.

colemin(_9850,[colemin,_9907,{},_9946,_9970,!,_10004],_9893,_9895) --> 
    minutes(_9867,_9907,_9893,_9924),
    {user:_9867\==0},
    point(_9946,_9924,_9961),
    minutes(_9874,_9970,_9961,_9987),
    !,
    reject(_10004,_9987,_9895).

colemin(_9850,[colemin,_9897,_9921,!,_9955,_9979],_9883,_9885) --> 
    colon(_9897,_9883,_9912),
    minutes(_9850,_9921,_9912,_9938),
    !,
    accept(_9955,_9938,_9970),
    colesec0(_9979,_9970,_9885).

colemin(_9850,[colemin,_9908,_9932,{},!,_9976],_9894,_9896) --> 
    point(_9908,_9894,_9923),
    minutes(_9850,_9932,_9923,_9949),
    {user:(_9850=0;_9850>12)},
    !,
    colesec0(_9976,_9949,_9896).

colemin(_9850,[colemin,_9897,_9921,!,_9955],_9883,_9885) --> 
    colon(_9897,_9883,_9912),
    w(nb(_9850,num),_9921,_9912,_9938),
    !,
    reject(_9955,_9938,_9885).

colemin(0,[colemin,_9889,!,_9918],_9875,_9877) --> 
    colon(_9889,_9875,_9904),
    !,
    accept(_9918,_9904,_9877).

colesec0([colesec0,lit(:),_9897,!],_9875,_9877) --> 
    cc(:,_9875,_9896),
    minutes(_9858,_9897,_9896,_9877),
    !.

colesec0([colesec0,[]],_9865,_9865) --> 
    [].

minutes0(_9850,[minutes0,_9891,!,_9925],_9877,_9879) --> 
    minutes(_9850,_9891,_9877,_9908),
    !,
    accept(_9925,_9908,_9879).

minutes0(0,[minutes0,[]],_9869,_9869) --> 
    [].

minutes(_9850,[minutes,_9889,!,_9918],_9875,_9877) --> 
    a(_9889,_9875,_9904),
    !,
    reject(_9918,_9904,_9877).

minutes(_9850,[minutes,_9896,{}],_9882,_9884) --> 
    w(nb(_9850,num),_9896,_9882,_9884),
    {user:_9850<100}.

nameq2(_9853:_9857,_9853 isa number,[nameq2,_9912,_9941,_9965,!,_9994],_9895,_9897) --> 
    number(_9853:_9857,_9912,_9895,_9929),
    point0(_9941,_9929,_9956),
    monthnamex(_9965,_9956,_9980),
    !,
    reject(_9994,_9980,_9897).

nameq2(_9850,_9851,[nameq2,_9905,_9929,!,_9963],_9888,_9890) --> 
    one(_9905,_9888,_9920),
    w(noun(_9864,sin,u,n),_9929,_9920,_9946),
    !,
    reject(_9963,_9946,_9890).

nameq2(_9853:_9854,_9853 isa _9854,[nameq2,_9934,_9963,{},_9997,{},!],_9917,_9919) --> 
    number(_9853:_9877,_9934,_9917,_9951),
    point(_9963,_9951,_9978),
    {user:(\+_9853=1)},
    w(noun(_9854,sin,u,n),_9997,_9978,_9919),
    {user:alignable(_9854,number)},
    !.

nameq2(_9853:_9857,_9853 isa clock,[nameq2,{},_9936,{},{},!],_9909,_9911) --> 
    {user:type(clock,_9857)},
    number(_9853:_9879,_9936,_9909,_9911),
    {user:_9853>=1000},
    {user:clock_test(_9853)},
    !.

nameq2(_9853:_9857,_9853 isa number,[nameq2,_9900],_9883,_9885) --> 
    number(_9853:_9857,_9900,_9883,_9885).

number(_9852:number,[number,_9929,lit('.'),_9969,{},!,{}],_9915,_9917) --> 
    num(_9878,_9929,_9915,_9946),
    cc('.',_9946,_9968),
    num(_9876,_9969,_9968,_9917),
    {user:(_9876>=100,_9876<1000)},
    !,
    {user:_9852 is _9878*1000+_9876}.

number(2:_9853,[number,_9904,_9928,{}],_9890,_9892) --> 
    a(_9904,_9890,_9919),
    w(noun(pair,_9869,_9870,_9871),_9928,_9919,_9892),
    {user:type(number,_9853)}.

number(_9852:_9853,[number,_9915,_9939,{},_9978,{}],_9901,_9903) --> 
    only0(_9915,_9901,_9930),
    num(_9872,_9939,_9930,_9956),
    {user:type(number,_9853)},
    thousands0(_9873,_9978,_9956,_9903),
    {user:_9852 is _9872*_9873}.

number(_9850,[number,_9901,_9925,!,_9959],_9887,_9889) --> 
    a(_9901,_9887,_9916),
    not_look_ahead(w(noun(time,_9866,def,_9868)),_9925,_9916,_9942),
    !,
    reject(_9959,_9942,_9889).

thousands0(1000,[thousands0,_9886,!],_9872,_9874) --> 
    tusen(_9886,_9872,_9874),
    !.

thousands0(1000000,[thousands0,_9886,!],_9872,_9874) --> 
    million(_9886,_9872,_9874),
    !.

thousands0(1000000000,[thousands0,_9889,!],_9875,_9877) --> 
    milliard(_9889,_9875,_9877),
    !.

thousands0(1,[thousands0,[]],_9869,_9869) --> 
    [].

tusen([tusen,lit(tusen)],_9867,_9869) --> 
    cc(tusen,_9867,_9869).

tusen([tusen,lit(tusener)],_9867,_9869) --> 
    cc(tusener,_9867,_9869).

million([million,lit(million)],_9867,_9869) --> 
    cc(million,_9867,_9869).

million([million,lit(millioner)],_9867,_9869) --> 
    cc(millioner,_9867,_9869).

milliard([milliard,lit(milliard)],_9867,_9869) --> 
    cc(milliard,_9867,_9869).

milliard([milliard,lit(milliarder)],_9867,_9869) --> 
    cc(milliarder,_9867,_9869).

anumber(_9850,[anumber,_9894,_9918,!,_9952],_9880,_9882) --> 
    a0(_9894,_9880,_9909),
    number(_9850,_9918,_9909,_9935),
    !,
    accept(_9952,_9935,_9882).

anumber(1:_9853,[anumber,_9897,!,{}],_9883,_9885) --> 
    art1(_9897,_9883,_9885),
    !,
    {user:type(number,_9853)}.

intrans_verb(work,_9851,id,_9853,_9854,_9855,_9856,[intrans_verb,_9941,_9985,{}],_9909,_9911) --> 
    lexv(tv,hold,_9855,_9856,_9941,_9909,_9964),
    w(prep(on),_9985,_9964,_9911),
    {user:iv_template(work,_9851,_9853,_9854)}.

intrans_verb(be1,_9851,id,_9853,_9854,_9855,_9856,[intrans_verb,_9941,_9985,{}],_9909,_9911) --> 
    lexv(tv,hold,_9855,_9856,_9941,_9909,_9964),
    w(prep(to),_9985,_9964,_9911),
    {user:iv_template(be1,_9851,_9853,_9854)}.

intrans_verb(_9850,_9851,id,_9853,_9854,_9855,_9856,[intrans_verb,_9934,{}],_9902,_9904) --> 
    lexv(iv,_9850,_9855,_9856,_9934,_9902,_9904),
    {user:iv_template(_9850,_9851,_9853,_9854)}.

intrans_verb(be1,_9851,_9852,_9853,_9854,pres,fin,[intrans_verb,_9953,_9982,_10011,{}],_9921,_9923) --> 
    not_look_ahead(w(verb(go,_9879,fin)),_9953,_9921,_9970),
    be1(_9852,_9982,_9970,_9999),
    not_look_ahead(w(verb(_9888,_9889,_9890)),_10011,_9999,_9923),
    {user:iv_template(be1,_9851,_9853,_9854)}.

intrans_verb(_9850,_9851,_9852,_9853,_9854,past,fin,[intrans_verb,_9942,_9971,_9995,{}],_9910,_9912) --> 
    has(_9852,_9942,_9910,_9959),
    now0(_9971,_9959,_9986),
    lexv(iv,_9850,past,part,_9995,_9986,_9912),
    {user:iv_template(_9850,_9851,_9853,_9854)}.

trans_verbs(_9850,_9851,_9852,_9853,_9854,[trans_verbs,_9926,_9990],_9900,_9902) --> 
    trans_verb(_9859,_9851,_9852,id,_9853,_9871,_9872,_9873,_9926,_9900,_9957),
    trans_verbs0(_9859,_9850,_9851,_9852,_9853,_9854,_9990,_9957,_9902).

trans_verbs0(_9850,_9851,_9852,_9853,_9854,_9855,[trans_verbs0,_9938,_9962,_10026],_9909,_9911) --> 
    andor(_9938,_9909,_9953),
    trans_verb(_9870,_9852,_9853,id,_9854,_9875,_9876,_9877,_9962,_9953,_9993),
    trans_verbs0((_9850,_9870),_9851,_9852,_9853,_9854,_9855,_10026,_9993,_9911).

trans_verbs0(_9850,_9850,_9860:_9861,_9863:_9864,_9854,_9850/_9860/_9863/_9854,[trans_verbs0,[]],_9899,_9899) --> 
    [].

trans_verb(tell,_9851,_9852,id,_9854,_9855,_9856,fin,[trans_verb,_9946,_9990,{}],_9911,_9913) --> 
    lexv(tv,tell,_9856,fin,_9946,_9911,_9969),
    particle0(tell,_9990,_9969,_9913),
    {user:tv_template(tell,_9851,_9852,_9854,_9855)}.

trans_verb(_9850,_9851,_9852,_9853,_9854,_9855,past,fin,[trans_verb,_9946,_9975,{}],_9911,_9913) --> 
    has(_9853,_9946,_9911,_9963),
    lexv(tv,_9850,past,part,_9975,_9963,_9913),
    {user:tv_template(_9850,_9851,_9852,_9854,_9855)}.

trans_verb(_9850,_9851,_9852,id,_9854,_9855,_9856,_9857,[trans_verb,_9941,{}],_9906,_9908) --> 
    lexv(tv,_9850,_9856,_9857,_9941,_9906,_9908),
    {user:tv_template(_9850,_9851,_9852,_9854,_9855)}.

rep_v(be_free,pres,fin,[rep_v,_9900],_9880,_9882) --> 
    w(adj2(free,nil),_9900,_9880,_9882).

rep_v(_9850,_9851,_9852,[rep_v,_9913,_9937,_9981,_10010],_9893,_9895) --> 
    aux0(_9913,_9893,_9928),
    lexv(rv,_9850,_9851,_9852,_9937,_9928,_9960),
    reflexiv0(_9850,_9981,_9960,_9998),
    rep_particlev0(_9850,_10010,_9998,_9895).

rep_v(want,pres,fin,[rep_v,lit(skal),!,_9919],_9883,_9885) --> 
    cc(skal,_9883,_9913),
    !,
    reject(_9919,_9913,_9885).

there_be_modal(think,[there_be_modal,_9897,_9921,lit(an)],_9883,_9885) --> 
    thereit(_9897,_9883,_9912),
    w(verb(go,_9863,_9864),_9921,_9912,_9938),
    cc(an,_9938,_9885).

there_be_modal(_9850,[there_be_modal,_9888,_9912],_9874,_9876) --> 
    thereit(_9888,_9874,_9903),
    be_modal(_9850,_9912,_9903,_9876).

be_there_modal(_9850,[be_there_modal,_9891,_9915,_9939],_9877,_9879) --> 
    be(_9891,_9877,_9906),
    thereit(_9915,_9906,_9930),
    be_modal(_9850,_9939,_9930,_9879).

be_modal(_9850,[be_modal,_9888,_9912],_9874,_9876) --> 
    be(_9888,_9874,_9903),
    modal(_9850,_9912,_9903,_9876).

be_modal(seem,[be_modal,_9889],_9875,_9877) --> 
    w(verb(seem,_9855,fin),_9889,_9875,_9877).

modal(_9850,[modal,_9892,_9931],_9878,_9880) --> 
    rep_v(_9850,past,part,_9892,_9878,_9913),
    tobetrue(_9855,_9931,_9913,_9880).

modal(_9850,[modal,_9887],_9873,_9875) --> 
    rep_v(_9850,_9853,fin,_9887,_9873,_9875).

modal(think,[modal,_9888],_9874,_9876) --> 
    w(adj2(possible,nil),_9888,_9874,_9876).

modal(think,[modal,_9888],_9874,_9876) --> 
    w(adj2(best,nil),_9888,_9874,_9876).

modal(free,[modal,_9888],_9874,_9876) --> 
    w(adj2(free,nil),_9888,_9874,_9876).

tobetrue(_9850,[tobetrue,_9888,_9912],_9874,_9876) --> 
    infinitive(_9888,_9874,_9903),
    be_truefalse(_9850,_9912,_9903,_9876).

tobetrue(id,[tobetrue,[]],_9869,_9869) --> 
    [].

pvimodal(_9850,_9851,[pvimodal,_9910,{},{}],_9893,_9895) --> 
    lexv(tv,_9850,_9866,fin,_9910,_9893,_9895),
    {user:_9850\==be},
    {user:pvi_templ(_9850,_9851)}.

lexvaccept(_9850,_9851,_9852,_9853,_9854,[lexvaccept,_9916,!],_9890,_9892) --> 
    hlexv(_9850,_9851,_9852,_9853,_9854,_9916,_9890,_9892),
    !.

hlexv(_9850,_9851,_9852,_9853,_9854,[hlexv,_9949,_9973,_10002,_10031,{},_10075,{}],_9923,_9925) --> 
    aux0(_9949,_9923,_9964),
    negation0(_9876,_9973,_9964,_9990),
    w(verb(_9884,_9852,_9853),_10002,_9990,_10019),
    particlev0(_9884,_9851,_10031,_10019,_10050),
    {user:verbtype(_9851,_9850)},
    negation0(_9877,_10075,_10050,_9925),
    {user:bigno(_9876,_9877,_9854)}.

hlexv(iv,_9851,_9852,fin,_9854,[hlexv,_9930,_9959,_9983,_10012,!],_9904,_9906) --> 
    w(verb(be,_9852,fin),_9930,_9904,_9947),
    now0(_9959,_9947,_9974),
    negation0(_9854,_9983,_9974,_10000),
    particlev2(be,_9851,_10012,_10000,_9906),
    !.

hlexv(_9850,_9851,past,fin,_9854,[hlexv,_9928,_9952,_9976,_10005,_10049],_9902,_9904) --> 
    has(_9928,_9902,_9943),
    danow0(_9952,_9943,_9967),
    negation0(_9854,_9976,_9967,_9993),
    lexv(_9850,_9851,past,part,_10005,_9993,_10028),
    reflexiv0(_9851,_10049,_10028,_9904).

hlexv(tv,bring,_9852,_9853,id,[hlexv,_9918,_9947],_9892,_9894) --> 
    w(verb(have,_9852,_9853),_9918,_9892,_9935),
    prep1(with,_9947,_9935,_9894).

hlexv(_9850,_9851,past,fin,_9854,[hlexv,_9935,_9964,_9993,{}],_9909,_9911) --> 
    w(verb(get,_9873,fin),_9935,_9909,_9952),
    negation0(_9854,_9964,_9952,_9981),
    w(verb(_9851,past,part),_9993,_9981,_9911),
    {user:verbtype(_9851,_9850)}.

hlexv(_9850,_9851,_9852,fin,_9854,[hlexv,_9943,_9972,_10001,{},!],_9917,_9919) --> 
    w(verb(get,_9852,fin),_9943,_9917,_9960),
    negation0(_9854,_9972,_9960,_9989),
    lexv(_9850,_9851,_9878,_9879,_10001,_9989,_9919),
    {user:(_9878\==imp,_9879\=fin)},
    !.

hlexv(_9850,_9851,past,fin,_9854,[hlexv,_9932,_9961,_9985,_10014,!],_9906,_9908) --> 
    w(verb(be,_9871,fin),_9932,_9906,_9949),
    now0(_9961,_9949,_9976),
    negation0(_9854,_9985,_9976,_10002),
    lexv(_9850,_9851,past,part,_10014,_10002,_9908),
    !.

hlexv(_9850,_9851,past,fin,_9854,[hlexv,_9923,_9947,_9971,_10000],_9897,_9899) --> 
    has(_9923,_9897,_9938),
    redundant0(_9947,_9938,_9962),
    negation0(_9854,_9971,_9962,_9988),
    lexv(_9850,_9851,past,part,_10000,_9988,_9899).

hlexv(_9850,know1,_9852,_9853,_9854,[hlexv,_9954,_9983,_10012,{},!,{}],_9928,_9930) --> 
    w(verb(know,_9852,_9853),_9954,_9928,_9971),
    negation0(_9854,_9983,_9971,_10000),
    look_ahead([_9885],_10012,_10000,_9930),
    {user:testmember(_9885,[hva,hvem,hvilken,hvilket,hvilke])},
    !,
    {user:_9850=tv}.

hlexv(tv,know1,_9852,_9853,_9854,[hlexv,_9923,_9952,lit(om)],_9897,_9899) --> 
    w(verb(know,_9852,_9853),_9923,_9897,_9940),
    negation0(_9854,_9952,_9940,_9969),
    cc(om,_9969,_9899).

hlexv(tv,_9851,_9852,fin,_9854,[hlexv,_9948,_9977,_10006,_10030,_10064,!,[]],_9922,_9924) --> 
    w(verb(get,_9852,fin),_9948,_9922,_9965),
    negation0(_9854,_9977,_9965,_9994),
    look_ahead_np(_10006,_9994,_10021),
    np1_accept(_9877,_9878,_10030,_10021,_10049),
    w(verb(_9851,past,part),_10064,_10049,_10081),
    !,
    pushstack(free,xnp(_9877,_9878),nil,_10081,_9924),
    [].

hlexv(tv,get,pres,fin,_9854,[hlexv,lit('får'),_9946,_9975,_10004,!],_9909,_9911) --> 
    cc('får',_9909,_9945),
    not_look_ahead(w(verb(_9874,inf,_9876)),_9946,_9945,_9963),
    negation0(_9854,_9975,_9963,_9992),
    optional([opp],_10004,_9992,_9911),
    !.

hlexv(iv,_9851,_9852,_9853,_9854,[hlexv,_9942,{},{},_9991,_10020],_9916,_9918) --> 
    w(verb(_9851,_9852,_9853),_9942,_9916,_9959),
    {user:rv_templ(_9851,_9881)},
    {user:tv_templ(_9851,_9886,nil)},
    negation0(_9854,_9991,_9959,_10008),
    look_ahead([om],_10020,_10008,_9918).

hlexv(_9850,_9851,_9852,_9853,_9854,[hlexv,_9956,{},_9995,_10024,!,{}],_9930,_9932) --> 
    w(verb(_9851,_9852,_9853),_9956,_9930,_9973),
    {user:testmember(_9851,[understand,believe,know])},
    negation0(_9854,_9995,_9973,_10012),
    look_ahead_lit([at,hvordan,hvorfor,'når'],_10024,_10012,_9932),
    !,
    {user:_9850=rv}.

hlexv(_9850,_9851,_9852,_9853,_9854,[hlexv,_9939,{},_9978,!,{}],_9913,_9915) --> 
    w(verb(_9851,_9852,_9853),_9939,_9913,_9956),
    {user:testmember(_9851,[believe])},
    negation0(_9854,_9978,_9956,_9915),
    !,
    {user:_9850=rv}.

hlexv(_9850,_9851,_9852,_9853,_9854,[hlexv,_9939,{},_9978,!,{}],_9913,_9915) --> 
    w(verb(_9851,_9852,_9853),_9939,_9913,_9956),
    {user:testmember(_9851,[understand])},
    negation0(_9854,_9978,_9956,_9915),
    !,
    {user:_9850=tv}.

hlexv(rv,_9851,_9852,_9853,_9854,[hlexv,{},_9960,_10004,_10033,_10062,_10091,!,_10125],_9924,_9926) --> 
    {user:value(textflag,true)},
    lexv(rv,_9851,_9852,_9853,_9960,_9924,_9983),
    negation0(_9854,_10004,_9983,_10021),
    not_look_ahead([det],_10033,_10021,_10050),
    not_look_ahead([hva],_10062,_10050,_10079),
    rep_particlev0(_9851,_10091,_10079,_10108),
    !,
    accept(_10125,_10108,_9926).

hlexv(tv,know1,pres,fin,_9854,[hlexv,lit(kan),_9950,_9979,_10008,_10037],_9913,_9915) --> 
    cc(kan,_9913,_9949),
    negation0(_9854,_9950,_9949,_9967),
    not_look_ahead([jeg],_9979,_9967,_9996),
    not_look_ahead([du],_10008,_9996,_10025),
    not_look_ahead(w(verb(_9872,_9873,_9874)),_10037,_10025,_9915).

hlexv(_9850,_9851,_9852,_9853,_9854,[hlexv,{},_9937,_9981,!],_9901,_9903) --> 
    {user:nonvar(_9850)},
    lexv(_9850,_9851,_9852,_9853,_9937,_9901,_9960),
    negation0(_9854,_9981,_9960,_9903),
    !.

hlexv(_9850,_9851,_9852,_9853,_9854,[hlexv,_9917,_9961],_9891,_9893) --> 
    lexv(_9850,_9851,_9852,_9853,_9917,_9891,_9940),
    negation0(_9854,_9961,_9940,_9893).

lexv(_9850,_9851,past,fin,[lexv,_9939,_9968,_9992,_10021,!,{},!],_9916,_9918) --> 
    w(verb(have,_9876,fin),_9939,_9916,_9956),
    redundant0(_9968,_9956,_9983),
    w(verb(_9881,past,part),_9992,_9983,_10009),
    particlev2(_9881,_9851,_10021,_10009,_9918),
    !,
    {user:verbtype(_9851,_9850)},
    !.

lexv(_9850,_9851,_9852,part,[lexv,_9924,_9953,{},!],_9901,_9903) --> 
    w(verb(_9866,_9852,part),_9924,_9901,_9941),
    particlev2(_9866,_9851,_9953,_9941,_9903),
    {user:verbtype(_9851,_9850)},
    !.

lexv(iv,_9851,past,fin,[lexv,_9918,{},!],_9895,_9897) --> 
    w(verb(_9851,past,part),_9918,_9895,_9897),
    {user:verbtype(_9851,iv)},
    !.

lexv(iv,_9851,pres,part,[lexv,_9918,{},!],_9895,_9897) --> 
    w(verb(_9851,pres,part),_9918,_9895,_9897),
    {user:verbtype(_9851,iv)},
    !.

lexv(dtv,_9851,_9852,_9853,[lexv,_9915,{}],_9892,_9894) --> 
    w(verb(_9851,_9852,_9853),_9915,_9892,_9894),
    {user:verbtype(_9851,dtv)}.

lexv(iv,be1,pres,fin,[lexv,_9907],_9884,_9886) --> 
    w(verb(be,inf,fin),_9907,_9884,_9886).

lexv(tv,_9851,past,part,[lexv,_9927,_9956,{},!],_9904,_9906) --> 
    w(verb(be,past,part),_9927,_9904,_9944),
    w(verb(_9851,past,part),_9956,_9944,_9906),
    {user:verbtype(_9851,tv)},
    !.

lexv(_9850,_9851,past,part,[lexv,_9918,{},!],_9895,_9897) --> 
    w(verb(_9851,past,part),_9918,_9895,_9897),
    {user:verbtype(_9851,_9850)},
    !.

lexv(tv,tell,_9852,_9853,[lexv,_9925,_9954,_9983,!,_10032],_9902,_9904) --> 
    w(verb(tell,_9852,_9853),_9925,_9902,_9942),
    reflexiv0(tell,_9954,_9942,_9971),
    optional([om],_9983,_9971,_10015),
    !,
    accept(_10032,_10015,_9904).

lexv(rv,_9851,_9852,_9853,[lexv,_9922,{},_9961],_9899,_9901) --> 
    w(verb(_9851,_9852,_9853),_9922,_9899,_9939),
    {user:rv_templ(_9851,_9874)},
    not_look_ahead([hva],_9961,_9939,_9901).

lexv(iv,_9851,_9852,fin,[lexv,_9919,_9948,!],_9896,_9898) --> 
    w(verb(be,_9852,fin),_9919,_9896,_9936),
    w(verb(_9851,pres,part),_9948,_9936,_9898),
    !.

lexv(iv,_9851,past,fin,[lexv,_9919,_9948,!],_9896,_9898) --> 
    w(verb(be,_9864,fin),_9919,_9896,_9936),
    w(verb(_9851,pres,part),_9948,_9936,_9898),
    !.

lexv(rv,_9851,_9852,_9853,[lexv,_9937,{},_9976,_10005,!,_10039],_9914,_9916) --> 
    w(verb(_9851,_9852,_9853),_9937,_9914,_9954),
    {user:testmember(_9851,[tell,notify])},
    reflexiv0(_9851,_9976,_9954,_9993),
    not_look_ahead([hva],_10005,_9993,_10022),
    !,
    accept(_10039,_10022,_9916).

lexv(rv,show,_9852,_9853,[lexv,_9912,_9941],_9889,_9891) --> 
    w(verb(show,_9852,_9853),_9912,_9889,_9929),
    reflexiv0(show,_9941,_9929,_9891).

lexv(rv,mean,_9852,_9853,[lexv,_9917,_9946,!],_9894,_9896) --> 
    w(verb(mean,_9852,_9853),_9917,_9894,_9934),
    look_ahead([at],_9946,_9934,_9896),
    !.

lexv(rv,mean,_9852,_9853,[lexv,_9928,_9957,_9986,_10015],_9905,_9907) --> 
    w(verb(mean,_9852,_9853),_9928,_9905,_9945),
    not_look_ahead([hva],_9957,_9945,_9974),
    not_look_ahead([en],_9986,_9974,_10003),
    not_look_ahead([noe],_10015,_10003,_9907).

lexv(tv,know1,_9852,_9853,[lexv,_9921,_9950,_9979],_9898,_9900) --> 
    w(verb(know,_9852,_9853),_9921,_9898,_9938),
    not_look_ahead(['når'],_9950,_9938,_9967),
    not_look_ahead([at],_9979,_9967,_9900).

lexv(_9850,_9851,_9852,_9853,[lexv,_9927,_9951,_9975,{},!,_10019],_9904,_9906) --> 
    doit(_9927,_9904,_9942),
    faa(_9951,_9942,_9966),
    w(verb(_9851,_9852,_9853),_9975,_9966,_9992),
    {user:verbtype(_9851,_9850)},
    !,
    accept(_10019,_9992,_9906).

lexv(_9850,_9851,_9852,_9853,[lexv,_9931,_9955,_9984,{},!,_10028],_9908,_9910) --> 
    doit(_9931,_9908,_9946),
    not_look_ahead(['nå'],_9955,_9946,_9972),
    w(verb(_9851,_9852,_9853),_9984,_9972,_10001),
    {user:verbtype(_9851,_9850)},
    !,
    accept(_10028,_10001,_9910).

lexv(_9850,_9851,_9852,_9853,[lexv,_9934,_9958,_9987,{},{}],_9911,_9913) --> 
    faa(_9934,_9911,_9949),
    not_look_ahead(['nå'],_9958,_9949,_9975),
    lexv(_9850,_9851,_9852,_9853,_9987,_9975,_9913),
    {user:verbtype(_9851,_9850)},
    {user:(\+_9851=manage)}.

lexv(tv,run,_9852,_9853,[lexv,_9918,_9947,!,_9981],_9895,_9897) --> 
    w(verb(run,_9852,_9853),_9918,_9895,_9935),
    prep1(with,_9947,_9935,_9964),
    !,
    reject(_9981,_9964,_9897).

lexv(tv,evah,pres,fin,[lexv,_9913,!,_9947],_9890,_9892) --> 
    w(verb(evah,pres,fin),_9913,_9890,_9930),
    !,
    accept(_9947,_9930,_9892).

lexv(cv,be,pres,fin,[lexv,_9904,_9928],_9881,_9883) --> 
    aux0(_9904,_9881,_9919),
    be(_9928,_9919,_9883).

lexv(tv,wonder,_9852,_9853,[lexv,_9907],_9884,_9886) --> 
    w(verb(wonder,_9852,_9853),_9907,_9884,_9886).

lexv(tv,want,_9852,_9853,[lexv,_9910,_9939],_9887,_9889) --> 
    w(verb(think,_9852,_9853),_9910,_9887,_9927),
    rfxpron(_9939,_9927,_9889).

lexv(_9850,_9851,past,fin,[lexv,_9944,_9968,_9997,{},_10036,_10065,{}],_9921,_9923) --> 
    aux1(_9944,_9921,_9959),
    w(verb(_9880,past,part),_9968,_9959,_9985),
    not_look_ahead([om],_9997,_9985,_10014),
    {user:_9880\==have},
    reflexiv0(_9880,_10036,_10014,_10053),
    particlev0(_9880,_9851,_10065,_10053,_9923),
    {user:verbtype(_9851,_9850)}.

lexv(_9850,_9851,_9852,_9853,[lexv,{},_9953,_9982,{},_10021,{}],_9920,_9922) --> 
    {user:_9850==tv},
    w(verb(_9851,_9852,_9853),_9953,_9920,_9970),
    not_look_ahead([om],_9982,_9970,_9999),
    {user:_9851\==have},
    reflexiv0(_9851,_10021,_9999,_9922),
    {user:verbtype(_9851,_9850)}.

lexv(_9850,_9851,_9852,_9853,[lexv,{},_9968,{},_10007,{},_10046,_10075,{}],_9935,_9937) --> 
    {user:var(_9850)},
    w(verb(_9887,_9852,_9853),_9968,_9935,_9985),
    {user:(\+rv_templ(_9887,_9896))},
    not_look_ahead([om],_10007,_9985,_10024),
    {user:_9887\==have},
    reflexiv0(_9887,_10046,_10024,_10063),
    particlev0(_9887,_9851,_10075,_10063,_9937),
    {user:verbtype(_9851,_9850)}.

lexv(iv,_9851,_9852,_9853,[lexv,_9945,_9969,{},{},_10018,_10047,{}],_9922,_9924) --> 
    aux0(_9945,_9922,_9960),
    w(verb(_9880,_9852,_9853),_9969,_9960,_9986),
    {user:_9853==fin},
    {user:_9880\==have},
    reflexiv0(_9880,_10018,_9986,_10035),
    particlev0(_9880,_9851,_10047,_10035,_9924),
    {user:verbtype(_9851,iv)}.

lexv(_9850,have,_9852,_9853,[lexv,_9930,_9954,{},_9993],_9907,_9909) --> 
    aux0(_9930,_9907,_9945),
    w(verb(have,_9852,_9853),_9954,_9945,_9971),
    {user:verbtype(have,_9850)},
    not_look_ahead(w(noun(arrival,_9869,_9870,n)),_9993,_9971,_9909).

lexv(_9850,_9851,past,fin,[lexv,_9918,_9942,{}],_9895,_9897) --> 
    has(_9918,_9895,_9933),
    w(verb(_9851,past,part),_9942,_9933,_9897),
    {user:verbtype(_9851,_9850)}.

lexv(tv,bring,_9852,_9853,[lexv,_9912,_9941],_9889,_9891) --> 
    w(verb(take,_9852,_9853),_9912,_9889,_9929),
    prep1(with,_9941,_9929,_9891).

lexv(_9850,_9851,_9852,_9853,[lexv,_9927,_9956,_9980,{},!],_9904,_9906) --> 
    w(verb(_9869,_9852,_9853),_9927,_9904,_9944),
    redundant0(_9956,_9944,_9971),
    particlev0(_9869,_9851,_9980,_9971,_9906),
    {user:verbtype(_9851,_9850)},
    !.

preadjs0(_9850,[preadjs0,lit(s),_9905,!,_9934],_9880,_9882) --> 
    cc(s,_9880,_9904),
    look_ahead_clock(_9905,_9904,_9920),
    !,
    reject(_9934,_9920,_9882).

preadjs0(_9850,[preadjs0,_9891,_9915,!],_9877,_9879) --> 
    so(_9891,_9877,_9906),
    preadjs(_9850,_9915,_9906,_9879),
    !.

preadjs0((_9852,_9853),[preadjs0,_9899,_9923,_9952,_9976],_9885,_9887) --> 
    dent0(_9899,_9885,_9914),
    preadj1(_9852,_9923,_9914,_9940),
    adj_conjunction(_9952,_9940,_9967),
    preadj1(_9853,_9976,_9967,_9887).

preadjs0((_9852,_9853),[preadjs0,_9905,_9929,_9958,_9987],_9891,_9893) --> 
    dent0(_9905,_9891,_9920),
    preadj1(_9852,_9929,_9920,_9946),
    not_look_ahead(w(prep(_9872)),_9958,_9946,_9975),
    preadjs0(_9853,_9987,_9975,_9893).

preadjs0(true,[preadjs0,[]],_9869,_9869) --> 
    [].

preadjs((_9852,_9853),[preadjs,_9902,_9931,_9960],_9888,_9890) --> 
    preadj1(_9852,_9902,_9888,_9919),
    not_look_ahead(w(prep(_9869)),_9931,_9919,_9948),
    preadjs0(_9853,_9960,_9948,_9890).

preadj1(nil/first,[preadj1,_9897,_9926,!],_9883,_9885) --> 
    w(nb(1,num),_9897,_9883,_9914),
    point(_9926,_9914,_9885),
    !.

preadj1(nil/second,[preadj1,_9897,_9926,!],_9883,_9885) --> 
    w(nb(2,num),_9897,_9883,_9914),
    point(_9926,_9914,_9885),
    !.

preadj1(nil/third,[preadj1,_9897,_9926,!],_9883,_9885) --> 
    w(nb(3,num),_9897,_9883,_9914),
    point(_9926,_9914,_9885),
    !.

preadj1(nil/_9853,[preadj1,_9908,{},!,_9952],_9894,_9896) --> 
    w(name(_9853,n,station),_9908,_9894,_9925),
    {user:(\+adjname_templ(_9853,_9875))},
    !,
    reject(_9952,_9925,_9896).

preadj1(nil/_9853,[preadj1,_9903,{},!],_9889,_9891) --> 
    w(name(_9853,n,_9865),_9903,_9889,_9891),
    {user:adjname_templ(_9853,_9870)},
    !.

preadj1(_9852/_9853,[preadj1,_9896,_9925],_9882,_9884) --> 
    gradverb(_9852,_9896,_9882,_9913),
    w(adj2(_9853,nil),_9925,_9913,_9884).

preadj1(_9852/_9853,[preadj1,_9933,_9962,_9991,_10035,{},!],_9919,_9921) --> 
    not_look_ahead_lit(['først',senest,tidligst],_9933,_9919,_9950),
    not_look_ahead(w(prep(_9882)),_9962,_9950,_9979),
    optional([mye],_9991,_9979,_10023),
    w(adj2(_9853,_9852),_10035,_10023,_9921),
    {user:(\+user:post_adjective(_9853))},
    !.

adj_conjunction0([adj_conjunction0,_9879,!],_9868,_9870) --> 
    adj_conjunction(_9879,_9868,_9870),
    !.

adj_conjunction0([adj_conjunction0,[]],_9865,_9865) --> 
    [].

adj_conjunction([adj_conjunction,lit(og)],_9867,_9869) --> 
    cc(og,_9867,_9869).

adj_conjunction([adj_conjunction,lit(men)],_9867,_9869) --> 
    cc(men,_9867,_9869).

adj_conjunction([adj_conjunction,lit(eller)],_9867,_9869) --> 
    cc(eller,_9867,_9869).

adj_conjunction([adj_conjunction,lit(/)],_9867,_9869) --> 
    cc(/,_9867,_9869).

adj1s((_9858;_9859),_9851,_9852,_9855 or _9856,[adj1s,_9928,lit(eller),_9983,!],_9905,_9907) --> 
    adj1(_9858,_9851,_9852,_9855,_9928,_9905,_9951),
    cc(eller,_9951,_9982),
    adj1(_9859,_9851,_9852,_9856,_9983,_9982,_9907),
    !.

adj1s((_9858,_9859),_9851,_9852,_9855 and _9856,[adj1s,_9937,lit(og),_9992,_10036,!],_9914,_9916) --> 
    adj1(_9858,_9851,_9852,_9855,_9937,_9914,_9960),
    cc(og,_9960,_9991),
    adj1(_9859,_9851,_9852,_9856,_9992,_9991,_10015),
    not_look_ahead(w(prep(_9889)),_10036,_10015,_9916),
    !.

adj1s(_9850,_9851,_9852,_9853,[adj1s,_9906],_9883,_9885) --> 
    adj1(_9850,_9851,_9852,_9853,_9906,_9883,_9885).

adj1(_9850,_9851,_9852,_9853,[adj1,_9922,_9951,{}],_9899,_9901) --> 
    gradverbs0(_9863,_9922,_9899,_9939),
    w(adj2(_9850,nil),_9951,_9939,_9901),
    {user:adj_template(_9863,_9850,_9851,_9852,_9853)}.

adj1(_9850,_9851,_9852,_9853,[adj1,_9917,{}],_9894,_9896) --> 
    w(adj2(_9850,_9860),_9917,_9894,_9896),
    {user:adj_template(_9860,_9850,_9851,_9852,_9853)}.

gradverbs0(_9850,[gradverbs0,_9893,!,_9927],_9879,_9881) --> 
    gradverb(_9850,_9893,_9879,_9910),
    !,
    gradverbs0(_9858,_9927,_9910,_9881).

gradverbs0(nil,[gradverbs0,[]],_9869,_9869) --> 
    [].

gradverb0(more,[gradverb0,lit(mer),_9909,!],_9884,_9886) --> 
    cc(mer,_9884,_9908),
    look_ahead(w(adj2(_9864,nil)),_9909,_9908,_9886),
    !.

gradverb0(_9850,[gradverb0,_9897,_9926,!],_9883,_9885) --> 
    gradverb(_9850,_9897,_9883,_9914),
    not_look_ahead(w(prep(_9864)),_9926,_9914,_9885),
    !.

gradverb0(nil,[gradverb0,[]],_9869,_9869) --> 
    [].

gradverb(little,[gradverb,lit('dårlig')],_9871,_9873) --> 
    cc('dårlig',_9871,_9873).

gradverb(more,[gradverb,lit(litt),lit(mer),!],_9879,_9881) --> 
    cc(litt,_9879,_9903),
    cc(mer,_9903,_9881),
    !.

gradverb(more,[gradverb,lit(mye),lit(mer),!],_9879,_9881) --> 
    cc(mye,_9879,_9903),
    cc(mer,_9903,_9881),
    !.

gradverb(more,[gradverb,lit(mer)],_9871,_9873) --> 
    cc(mer,_9871,_9873).

gradverb(only,[gradverb,lit(bare)],_9871,_9873) --> 
    cc(bare,_9871,_9873).

gradverb(too,[gradverb,lit(for)],_9871,_9873) --> 
    cc(for,_9871,_9873).

gradverb(very,[gradverb,lit(meget)],_9871,_9873) --> 
    cc(meget,_9871,_9873).

gradverb(very,[gradverb,lit(veldig)],_9871,_9873) --> 
    cc(veldig,_9871,_9873).

gradverb(little,[gradverb,lit(litt)],_9871,_9873) --> 
    cc(litt,_9871,_9873).

gradverb(somewhat,[gradverb,lit(noe)],_9871,_9873) --> 
    cc(noe,_9871,_9873).

gradverb(often,[gradverb,lit(ofte)],_9871,_9873) --> 
    cc(ofte,_9871,_9873).

gradverb(nil,[gradverb,lit('så')],_9871,_9873) --> 
    cc('så',_9871,_9873).

prepnom(_9850,[prepnom,_9899,{},!,_9943],_9885,_9887) --> 
    prep(_9850,_9899,_9885,_9916),
    {user:_9850==regarding},
    !,
    accept(_9943,_9916,_9887).

prepnom(_9850,[prepnom,_9885],_9871,_9873) --> 
    prepnof(_9850,_9885,_9871,_9873).

prepnog(long,from,[prepnog,_9897,!,_9931],_9880,_9882) --> 
    prep1(from,_9897,_9880,_9914),
    !,
    accept(_9931,_9914,_9882).

prepnog(possible,_9851,[prepnog,!,_9897],_9875,_9877) --> 
    !,
    reject(_9897,_9875,_9877).

prepnog(_9850,_9851,[prepnog,_9897,!,_9931],_9880,_9882) --> 
    prepnof(_9851,_9897,_9880,_9914),
    !,
    accept(_9931,_9914,_9882).

prepnof(_9850,[prepnof,_9895,{}],_9881,_9883) --> 
    prep(_9850,_9895,_9881,_9883),
    {user:(\+_9850=of)}.

defaultprep(_9850,_9851,_9852,[defaultprep,{},{},_9941,!,_9985],_9901,_9903) --> 
    {user:_9850\==be},
    {user:vartypeid(_9851,_9874)},
    adjustprep0(_9850,_9874,_9852,_9941,_9901,_9962),
    !,
    accept(_9985,_9962,_9903).

adjustprep0(_9850,_9851,_9852,[adjustprep0,_9902,!],_9882,_9884) --> 
    adjustprep(_9850,_9851,_9852,_9902,_9882,_9884),
    !.

adjustprep0(_9850,_9851,_9852,[adjustprep0,_9899],_9879,_9881) --> 
    missingprep(_9850,_9851,_9852,_9899,_9879,_9881).

adjustprep(ask,_9851,regarding,[adjustprep,lit(om)],_9877,_9879) --> 
    cc(om,_9877,_9879).

adjustprep(dream,_9851,regarding,[adjustprep,lit(om)],_9877,_9879) --> 
    cc(om,_9877,_9879).

adjustprep(handle2,_9851,regarding,[adjustprep,lit(om)],_9877,_9879) --> 
    cc(om,_9877,_9879).

adjustprep(know,_9851,regarding,[adjustprep,lit(om)],_9877,_9879) --> 
    cc(om,_9877,_9879).

adjustprep(know1,_9851,regarding,[adjustprep,lit(om)],_9877,_9879) --> 
    cc(om,_9877,_9879).

adjustprep(go,_9851,from,[adjustprep,_9897],_9877,_9879) --> 
    prep(after,_9897,_9877,_9879).

adjustprep(go,_9851,to,[adjustprep,_9897],_9877,_9879) --> 
    prep(of,_9897,_9877,_9879).

adjustprep(_9850,_9851,_9852,[adjustprep,_9897],_9877,_9879) --> 
    prep(_9852,_9897,_9877,_9879).

missingprep(_9850,duration,with,[missingprep,!],_9875,_9875) --> 
    !.

missingprep(pass,_9851,_9852,[missingprep,!,_9903],_9878,_9880) --> 
    !,
    reject(_9903,_9878,_9880).

missingprep(_9850,thing,_9852,[missingprep,!,_9903],_9878,_9880) --> 
    !,
    reject(_9903,_9878,_9880).

missingprep(go,direction,in,[missingprep,[]],_9875,_9875) --> 
    [].

missingprep(arrive,_9851,at,[missingprep,[]],_9875,_9875) --> 
    [].

missingprep(depart,_9851,from,[missingprep,[]],_9875,_9875) --> 
    [].

missingprep(go,direction,in,[missingprep,[]],_9875,_9875) --> 
    [].

missingprep(go,_9851,at,[missingprep,[]],_9875,_9875) --> 
    [].

missingprep(start,_9851,at,[missingprep,[]],_9875,_9875) --> 
    [].

missingprep(stop,_9851,at,[missingprep,[]],_9875,_9875) --> 
    [].

prep0(from,[prep0,_9891,!,_9925],_9877,_9879) --> 
    prep(from,_9891,_9877,_9908),
    !,
    accept(_9925,_9908,_9879).

prep0(_9850,[prep0,_9893,{}],_9879,_9881) --> 
    prep(_9850,_9893,_9879,_9881),
    {user:_9850\==of}.

prep0(in,[prep0,[]],_9869,_9869) --> 
    [].

prep(_9850,[prep,lit(m),_9910,!,_9944],_9885,_9887) --> 
    cc(m,_9885,_9909),
    w(nb(_9865,_9866),_9910,_9909,_9927),
    !,
    reject(_9944,_9927,_9887).

prep(from,[prep,lit(dra),{},_9925],_9890,_9892) --> 
    cc(dra,_9890,_9914),
    {user:value(smsflag,true)},
    look_ahead(w(name(_9862,n,_9864)),_9925,_9914,_9892).

prep(_9850,[prep,_9885],_9871,_9873) --> 
    prep2(_9850,_9885,_9871,_9873).

prep(_9850,[prep,_9885],_9871,_9873) --> 
    prep1(_9850,_9885,_9871,_9873).

prep1(after,[prep1,lit(e),_9906,!],_9881,_9883) --> 
    cc(e,_9881,_9905),
    not_look_ahead(['.'],_9906,_9905,_9883),
    !.

prep1(_9850,[prep1,_9894,_9923],_9880,_9882) --> 
    w(prep(_9850),_9894,_9880,_9911),
    not_look_ahead(['å'],_9923,_9911,_9882).

prep1(to,[prep1,lit(ti),_9907],_9882,_9884) --> 
    cc(ti,_9882,_9906),
    look_ahead(w(name(_9859,_9860,_9861)),_9907,_9906,_9884).

atom(_9850,[atom,_9897,{}],_9883,_9885) --> 
    w(name(_9857,_9863,_9864),_9897,_9883,_9885),
    {user:atom_templ(_9857,_9850)}.

atomlist(_9850,[atomlist,_9899,_9928,_9957],_9885,_9887) --> 
    atom1(_9861,_9899,_9885,_9916),
    atom1(_9863,_9928,_9916,_9945),
    atoms0(_9861-_9863,_9850,_9957,_9945,_9887).

atom1(_9850,[atom1,_9897,{}],_9883,_9885) --> 
    w(name(_9850,n,_9857),_9897,_9883,_9885),
    {user:_9857\==unkn}.

atoms0(_9850,_9851,[atoms0,_9900,_9929],_9883,_9885) --> 
    atom1(_9859,_9900,_9883,_9917),
    atoms0(_9850-_9859,_9851,_9929,_9917,_9885).

atoms0(_9850,_9850,[atoms0,[]],_9872,_9872) --> 
    [].

newatom(_9850,[newatom,_9897,{}],_9883,_9885) --> 
    w(name(_9857,_9863,_9864),_9897,_9883,_9885),
    {user:atom_templ(_9857,_9850)}.

newatomid(_9850,[newatomid,_9889],_9875,_9877) --> 
    w(name(_9850,_9855,_9856),_9889,_9875,_9877).

xsubjunction(nil,coevent,instead_of,[xsubjunction,lit(fremfor)],_9877,_9879) --> 
    cc(fremfor,_9877,_9879).

xsubjunction(nil,coevent,in_order_to,[xsubjunction,_9895],_9875,_9877) --> 
    in_order_to(_9895,_9875,_9877).

xsubjunction(nil,coevent,without,[xsubjunction,_9895],_9875,_9877) --> 
    'utenå'(_9895,_9875,_9877).

xsubjunction(nil,coevent,by,[xsubjunction,lit(ved),lit('å')],_9882,_9884) --> 
    cc(ved,_9882,_9912),
    cc('å',_9912,_9884).

subjunction(before,time,in,[subjunction,_9900,_9929],_9880,_9882) --> 
    prep1(to,_9900,_9880,_9917),
    look_ahead_np(_9929,_9917,_9882).

subjunction(after,time,in,[subjunction,_9900,_9929],_9880,_9882) --> 
    prep1(after,_9900,_9880,_9917),
    that(_9929,_9917,_9882).

subjunction(after,time,in,[subjunction,_9929,_9958,_9987,_10016,!],_9909,_9911) --> 
    prep1(after,_9929,_9909,_9946),
    not_look_ahead(w(noun(clock,sin,def,n)),_9958,_9946,_9975),
    not_look_ahead(w(nb(_9881,_9882)),_9987,_9975,_10004),
    look_ahead([jeg],_10016,_10004,_9911),
    !.

subjunction(before,time,in,[subjunction,lit('før'),_9930,_9959],_9899,_9901) --> 
    cc('før',_9899,_9929),
    not_look_ahead(w(nb(_9875,_9876)),_9930,_9929,_9947),
    not_look_ahead(w(noun(clock,sin,def,n)),_9959,_9947,_9901).

subjunction(before,time,in,[subjunction,lit(til),_9919],_9888,_9890) --> 
    cc(til,_9888,_9918),
    not_look_ahead(w(name(_9861,_9862,_9863)),_9919,_9918,_9890).

subjunction(not_withstanding,coevent,nil,[subjunction,_9900,lit(om)],_9880,_9882) --> 
    uansett(_9900,_9880,_9915),
    cc(om,_9915,_9882).

subjunction(not_withstanding,coevent,nil,[subjunction,lit(selvom)],_9877,_9879) --> 
    cc(selvom,_9877,_9879).

uansett([uansett,lit(uansett)],_9867,_9869) --> 
    cc(uansett,_9867,_9869).

uansett([uansett,lit(selv)],_9867,_9869) --> 
    cc(selv,_9867,_9869).

subjunction(unless,coevent,nil,[subjunction,lit(med),lit(mindre)],_9882,_9884) --> 
    cc(med,_9882,_9912),
    cc(mindre,_9912,_9884).

subjunction(nil,coevent,so_that,[subjunction,_9895],_9875,_9877) --> 
    because(_9895,_9875,_9877).

subjunction(nil,coevent,so_that,[subjunction,_9895],_9875,_9877) --> 
    if1(_9895,_9875,_9877).

subjunction(nil,coevent,despite_of,[subjunction,_9902,lit(at)],_9882,_9884) --> 
    prep1(without,_9902,_9882,_9919),
    cc(at,_9919,_9884).

subjunction(nil,coevent,instead_of,[subjunction,_9895],_9875,_9877) --> 
    instead_of(_9895,_9875,_9877).

subjunction(nil,coevent,because_of,[subjunction,lit(med),lit(at)],_9882,_9884) --> 
    cc(med,_9882,_9912),
    cc(at,_9912,_9884).

subjunction(nil,coevent,because_of,[subjunction,_9895],_9875,_9877) --> 
    so_that(_9895,_9875,_9877).

subjunction(nil,coevent,because_of,[subjunction,lit(slik)],_9877,_9879) --> 
    cc(slik,_9877,_9879).

subjunction(during,time,in,[subjunction,_9895],_9875,_9877) --> 
    while(_9895,_9875,_9877).

subjunction(in,time,in,[subjunction,lit(om),_9911],_9880,_9882) --> 
    cc(om,_9880,_9910),
    when1(_9911,_9910,_9882).

subjunction(in,time,in,[subjunction,_9895],_9875,_9877) --> 
    when1(_9895,_9875,_9877).

subjunction(in,time,in,[subjunction,lit('så'),_9915],_9884,_9886) --> 
    cc('så',_9884,_9914),
    w(adv(fast),_9915,_9914,_9886).

subjunction(in,time,in,[subjunction,lit(om),lit(hvordan)],_9882,_9884) --> 
    cc(om,_9882,_9912),
    cc(hvordan,_9912,_9884).

subjunction(in,time,in,[subjunction,lit('på'),lit(hvordan)],_9882,_9884) --> 
    cc('på',_9882,_9912),
    cc(hvordan,_9912,_9884).

subjunction(in,time,in,[subjunction,lit(da)],_9877,_9879) --> 
    cc(da,_9877,_9879).

subjunction(in,place,in,[subjunction,lit(der)],_9877,_9879) --> 
    cc(der,_9877,_9879).

subjunction(in,place,in,[subjunction,lit(hvor),_9918],_9887,_9889) --> 
    cc(hvor,_9887,_9917),
    not_look_ahead(w(adj2(_9861,_9862)),_9918,_9917,_9889).

subjunction(until,time,in,[subjunction,_9895],_9875,_9877) --> 
    until(_9895,_9875,_9877).

subjunction(in,time,in,[subjunction,lit(i),lit(det)],_9882,_9884) --> 
    cc(i,_9882,_9912),
    cc(det,_9912,_9884).

because([because,lit(fordi)],_9867,_9869) --> 
    cc(fordi,_9867,_9869).

because([because,lit(for),_9901,!],_9879,_9881) --> 
    cc(for,_9879,_9900),
    look_ahead_lit([da,den],_9901,_9900,_9881),
    !.

because([because,lit(siden),_9913,{},!,_9957],_9891,_9893) --> 
    cc(siden,_9891,_9912),
    w(noun(_9866,_9867,_9868,_9869),_9913,_9912,_9930),
    {user:constrain(_9866,time)},
    !,
    reject(_9957,_9930,_9893).

because([because,lit(siden)],_9867,_9869) --> 
    cc(siden,_9867,_9869).

erdetdet([erdetdet,_9887,lit(det),_9922,_9946],_9876,_9878) --> 
    be(_9887,_9876,_9902),
    cc(det,_9902,_9921),
    that0(_9922,_9921,_9937),
    det0(_9946,_9937,_9878).

be_it_tf_that(_9850,[be_it_tf_that,_9914,lit(det),_9954,lit(ut),lit(til),lit(at)],_9900,_9902) --> 
    w(verb(see,_9872,fin),_9914,_9900,_9931),
    cc(det,_9931,_9953),
    negation0(_9850,_9954,_9953,_9971),
    cc(ut,_9971,_9993),
    cc(til,_9993,_10004),
    cc(at,_10004,_9902).

omaa([omaa,lit(om),lit('å'),!],_9875,_9877) --> 
    cc(om,_9875,_9896),
    cc('å',_9896,_9877),
    !.

omaa([omaa,lit('å'),!],_9870,_9872) --> 
    cc('å',_9870,_9872),
    !.

gadd([gadd,lit(vil)],_9867,_9869) --> 
    cc(vil,_9867,_9869).

hvormye([hvormye,lit(hvor),lit(mye)],_9872,_9874) --> 
    cc(hvor,_9872,_9893),
    cc(mye,_9893,_9874).

hvormye([hvormye,lit(hvor),lit(mange)],_9872,_9874) --> 
    cc(hvor,_9872,_9893),
    cc(mange,_9893,_9874).

hvormye([hvormye,lit(hvor),lit(meget)],_9872,_9874) --> 
    cc(hvor,_9872,_9893),
    cc(meget,_9893,_9874).

hvormye([hvormye,lit(hva)],_9867,_9869) --> 
    cc(hva,_9867,_9869).

whatcan([whatcan,lit(hva),lit(kan)],_9872,_9874) --> 
    cc(hva,_9872,_9893),
    cc(kan,_9893,_9874).

whatcan([whatcan,lit(hva),_9892],_9870,_9872) --> 
    cc(hva,_9870,_9891),
    aux1(_9892,_9891,_9872).

ompa([ompa,lit(om)],_9867,_9869) --> 
    cc(om,_9867,_9869).

ompa([ompa,_9880],_9869,_9871) --> 
    w(prep(on),_9880,_9869,_9871).

ompa([ompa,_9880],_9869,_9871) --> 
    w(prep(for),_9880,_9869,_9871).

hver0([hver0,lit(hvert),!],_9870,_9872) --> 
    cc(hvert,_9870,_9872),
    !.

hver0([hver0,lit(hver),!],_9870,_9872) --> 
    cc(hver,_9870,_9872),
    !.

hver0([hver0,[]],_9865,_9865) --> 
    [].

'detå'(['detå',lit(det),_9895,!],_9873,_9875) --> 
    cc(det,_9873,_9894),
    infinitive(_9895,_9894,_9875),
    !.

'detå'(['detå',lit(det),lit(og),!],_9875,_9877) --> 
    cc(det,_9875,_9896),
    cc(og,_9896,_9877),
    !.

'detå'(['detå',lit(det),lit(for),_9911,!],_9878,_9880) --> 
    cc(det,_9878,_9899),
    cc(for,_9899,_9910),
    infinitive(_9911,_9910,_9880),
    !.

'detå'(['detå',lit(det),lit(for),lit(og),!],_9880,_9882) --> 
    cc(det,_9880,_9901),
    cc(for,_9901,_9912),
    cc(og,_9912,_9882),
    !.

numberroute([numberroute,_9882,_9906,!],_9871,_9873) --> 
    optionalbus(_9882,_9871,_9897),
    num1(_9906,_9897,_9873),
    !.

numberroute([numberroute,_9879,!],_9868,_9870) --> 
    bus1(_9879,_9868,_9870),
    !.

optionalbus([optionalbus,_9883,_9907],_9872,_9874) --> 
    bus1(_9883,_9872,_9898),
    optional([nr],_9907,_9898,_9874).

optionalbus([optionalbus,_9876],_9865,_9867) --> 
    num1(_9876,_9865,_9867).

optionalbus([optionalbus,[]],_9865,_9865) --> 
    [].

num1([num1,_9889,_9918,!],_9878,_9880) --> 
    w(noun(number,sin,_9860,n),_9889,_9878,_9906),
    point0(_9918,_9906,_9880),
    !.

num1([num1,lit(nr),_9895,!],_9873,_9875) --> 
    cc(nr,_9873,_9894),
    point0(_9895,_9894,_9875),
    !.

bus1([bus1,_9883],_9872,_9874) --> 
    w(noun(route,sin,_9854,_9855),_9883,_9872,_9874).

bus1([bus1,_9883],_9872,_9874) --> 
    w(noun(bus,sin,_9854,_9855),_9883,_9872,_9874).

commas0([commas0,_9882,!,_9911],_9871,_9873) --> 
    comma(_9882,_9871,_9897),
    !,
    commas0(_9911,_9897,_9873).

commas0([commas0,[]],_9865,_9865) --> 
    [].

comma0([comma0,lit(','),!],_9870,_9872) --> 
    cc(',',_9870,_9872),
    !.

comma0([comma0,[]],_9865,_9865) --> 
    [].

comma([comma,lit(',')],_9867,_9869) --> 
    cc(',',_9867,_9869).

streetno([streetno,_9882,!,_9911],_9871,_9873) --> 
    a(_9882,_9871,_9897),
    !,
    reject(_9911,_9897,_9873).

streetno([streetno,lit(veg)],_9867,_9869) --> 
    cc(veg,_9867,_9869).

streetno([streetno,_9889,{}],_9878,_9880) --> 
    w(nb(_9855,num),_9889,_9878,_9880),
    {user:_9855<500}.

tilsiden([tilsiden,_9878],_9867,_9869) --> 
    prep1(to,_9878,_9867,_9869).

tilsiden([tilsiden,_9878],_9867,_9869) --> 
    prep1(before,_9878,_9867,_9869).

tilsiden([tilsiden,lit(siden)],_9867,_9869) --> 
    cc(siden,_9867,_9869).

hva([hva,lit(hva),!,_9900],_9873,_9875) --> 
    cc(hva,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

hva([hva,lit(hvor),_9898,!,_9927],_9876,_9878) --> 
    cc(hvor,_9876,_9897),
    meny(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

addressat0([addressat0,_9888,!,_9922],_9877,_9879) --> 
    w(name(tuc,n,_9860),_9888,_9877,_9905),
    !,
    accept(_9922,_9905,_9879).

addressat0([addressat0,_9888,!,_9922],_9877,_9879) --> 
    w(name(busstuc,n,_9860),_9888,_9877,_9905),
    !,
    accept(_9922,_9905,_9879).

addressat0([addressat0,_9888,!,_9922],_9877,_9879) --> 
    w(name(bustuc,n,_9860),_9888,_9877,_9905),
    !,
    accept(_9922,_9905,_9879).

addressat0([addressat0,_9888,!,_9922],_9877,_9879) --> 
    w(name(hal,n,_9860),_9888,_9877,_9905),
    !,
    accept(_9922,_9905,_9879).

addressat0([addressat0,[]],_9865,_9865) --> 
    [].

enn([enn,lit(enn)],_9867,_9869) --> 
    cc(enn,_9867,_9869).

enn([enn,lit(en)],_9867,_9869) --> 
    cc(en,_9867,_9869).

hatt0([hatt0,_9885,!],_9874,_9876) --> 
    w(verb(have,past,part),_9885,_9874,_9876),
    !.

hatt0([hatt0,[]],_9865,_9865) --> 
    [].

out0([out0,lit(ut),!,_9900],_9873,_9875) --> 
    cc(ut,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

out0([out0,lit(opp),!,_9900],_9873,_9875) --> 
    cc(opp,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

out0([out0,[]],_9865,_9865) --> 
    [].

a0([a0,_9876],_9865,_9867) --> 
    a(_9876,_9865,_9867).

a0([a0,[]],_9865,_9865) --> 
    [].

a([a,lit(ett),_9901],_9879,_9881) --> 
    cc(ett,_9879,_9900),
    not_look_ahead(w(noun(time,_9858,def,_9860)),_9901,_9900,_9881).

a([a,lit(noen),lit(av),!],_9875,_9877) --> 
    cc(noen,_9875,_9896),
    cc(av,_9896,_9877),
    !.

a([a,lit(noen),_9906,_9935,_9964],_9884,_9886) --> 
    cc(noen,_9884,_9905),
    not_look_ahead([av],_9906,_9905,_9923),
    not_look_ahead([de],_9935,_9923,_9952),
    look_ahead_np(_9964,_9952,_9886).

a([a,lit(noe),_9899,_9928],_9877,_9879) --> 
    cc(noe,_9877,_9898),
    not_look_ahead([de],_9899,_9898,_9916),
    look_ahead_np(_9928,_9916,_9879).

a([a,_9883,_9907],_9872,_9874) --> 
    art1(_9883,_9872,_9898),
    optional([slik],_9907,_9898,_9874).

art([art,_9876],_9865,_9867) --> 
    a(_9876,_9865,_9867).

art([art,_9884,lit(eller),_9919],_9873,_9875) --> 
    a(_9884,_9873,_9899),
    cc(eller,_9899,_9918),
    more(_9919,_9918,_9875).

art([art,lit(de)],_9867,_9869) --> 
    cc(de,_9867,_9869).

art([art,lit(all)],_9867,_9869) --> 
    cc(all,_9867,_9869).

art([art,_9889,lit(alt)],_9878,_9880) --> 
    not_look_ahead(w(name(_9859,_9860,_9861)),_9889,_9878,_9906),
    cc(alt,_9906,_9880).

art([art,_9886,{}],_9875,_9877) --> 
    every(_9886,_9875,_9877),
    {user:(\+value(textflag,true))}.

art1([art1,lit(en)],_9867,_9869) --> 
    cc(en,_9867,_9869).

art1([art1,lit(et)],_9867,_9869) --> 
    cc(et,_9867,_9869).

art1([art1,lit(ei)],_9867,_9869) --> 
    cc(ei,_9867,_9869).

allsome0([allsome0,lit(noen),lit(av)],_9872,_9874) --> 
    cc(noen,_9872,_9893),
    cc(av,_9893,_9874).

allsome0([allsome0,_9879,!],_9868,_9870) --> 
    all(_9879,_9868,_9870),
    !.

allsome0([allsome0,[]],_9865,_9865) --> 
    [].

all0([all0,_9879,!],_9868,_9870) --> 
    all(_9879,_9868,_9870),
    !.

all0([all0,[]],_9865,_9865) --> 
    [].

all([all,_9876],_9865,_9867) --> 
    every(_9876,_9865,_9867).

always([always,lit(alltid)],_9867,_9869) --> 
    cc(alltid,_9867,_9869).

always([always,_9891,_9920],_9880,_9882) --> 
    w(adj2(whole,nil),_9891,_9880,_9908),
    w(noun(time,sin,def,n),_9920,_9908,_9882).

and0([and0,_9882,!,_9911],_9871,_9873) --> 
    and1(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

and0([and0,[]],_9865,_9865) --> 
    [].

andor0([andor0,_9882,!,_9911],_9871,_9873) --> 
    andor(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

andor0([andor0,[]],_9865,_9865) --> 
    [].

andor([andor,lit(og),!],_9870,_9872) --> 
    cc(og,_9870,_9872),
    !.

andor([andor,lit(eller),!],_9870,_9872) --> 
    cc(eller,_9870,_9872),
    !.

betwand0([betwand0,lit('å'),!],_9870,_9872) --> 
    cc('å',_9870,_9872),
    !.

betwand0([betwand0,lit(og),!],_9870,_9872) --> 
    cc(og,_9870,_9872),
    !.

betwand0([betwand0,_9883,!],_9872,_9874) --> 
    w(prep(to),_9883,_9872,_9874),
    !.

betwand0([betwand0,[]],_9865,_9865) --> 
    [].

and1([and1,lit(og)],_9867,_9869) --> 
    cc(og,_9867,_9869).

and1([and1,lit(men),_9898],_9876,_9878) --> 
    cc(men,_9876,_9897),
    look_ahead_lit([en,et],_9898,_9897,_9878).

vmod_conjunction([vmod_conjunction,lit(mao)],_9867,_9869) --> 
    cc(mao,_9867,_9869).

vmod_conjunction([vmod_conjunction,lit(men),_9898],_9876,_9878) --> 
    cc(men,_9876,_9897),
    not_look_ahead_lit([med,'nå'],_9898,_9897,_9878).

vmod_conjunction([vmod_conjunction,_9938,_9967,_10011,_10040,_10069,_10098,_10127],_9927,_9929) --> 
    one_of_lit([og,eller],_9938,_9927,_9955),
    optional(['så'],_9967,_9955,_9999),
    not_look_ahead_lit([da,'så','nå'],_10011,_9999,_10028),
    not_look_ahead(w(prep(in)),_10040,_10028,_10057),
    not_look_ahead(w([ikveld]),_10069,_10057,_10086),
    not_look_ahead(w([imorgen]),_10098,_10086,_10115),
    not_look_ahead(w(name(_9872,_9873,_9874)),_10127,_10115,_9929).

andwhen0([andwhen0,_9885,_9909,!,_9938],_9874,_9876) --> 
    and1(_9885,_9874,_9900),
    when(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

andwhen0([andwhen0,[]],_9865,_9865) --> 
    [].

andwhere0([andwhere0,_9890,_9914,_9943,!,_9972],_9879,_9881) --> 
    and1(_9890,_9879,_9905),
    prep1(from,_9914,_9905,_9931),
    where(_9943,_9931,_9958),
    !,
    accept(_9972,_9958,_9881).

andwhere0([andwhere0,_9885,_9909,!,_9938],_9874,_9876) --> 
    and1(_9885,_9874,_9900),
    where(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

andwhere0([andwhere0,_9887,lit(hvorfra),!,_9927],_9876,_9878) --> 
    and1(_9887,_9876,_9902),
    cc(hvorfra,_9902,_9921),
    !,
    accept(_9927,_9921,_9878).

andwhere0([andwhere0,[]],_9865,_9865) --> 
    [].

np_conjunction(_9850,[np_conjunction,_9899,lit(det),_9939,!,_9968],_9885,_9887) --> 
    andor(_9864,_9899,_9885,_9916),
    cc(det,_9916,_9938),
    look_ahead_vp(_9939,_9938,_9954),
    !,
    reject(_9968,_9954,_9887).

np_conjunction(_9850,[np_conjunction,_9910,_9939,_9968,_9997],_9896,_9898) --> 
    andor(_9850,_9910,_9896,_9927),
    not_look_ahead_lit([da,'så'],_9939,_9927,_9956),
    not_look_ahead(w(prep(_9877)),_9968,_9956,_9985),
    not_look_ahead(['.'],_9997,_9985,_9898).

andor0(_9850,[andor0,_9885],_9871,_9873) --> 
    andor(_9850,_9885,_9871,_9873).

andor0(and,[andor0,{}],_9877,_9877) --> 
    {user:value(textflag,true)}.

andor(and,[andor,_9909,_9933,_9962],_9895,_9897) --> 
    and1(_9909,_9895,_9924),
    not_look_ahead(['.'],_9933,_9924,_9950),
    not_look_ahead_lit([jeg,mange,ikke,ingen,noen,disse,dette],_9962,_9950,_9897).

andor(or,[andor,lit(eller),_9907],_9882,_9884) --> 
    cc(eller,_9882,_9906),
    not_look_ahead(w(verb(_9859,_9860,_9861)),_9907,_9906,_9884).

andor(and,[andor,{},_9910,!,_9939],_9886,_9888) --> 
    {user:value(teleflag,true)},
    art(_9910,_9886,_9925),
    !,
    reject(_9939,_9925,_9888).

andor(and,[andor,{}],_9877,_9877) --> 
    {user:value(teleflag,true)}.

also0([also0,lit('også'),lit(samtidig),!],_9875,_9877) --> 
    cc('også',_9875,_9896),
    cc(samtidig,_9896,_9877),
    !.

also0([also0,lit(samtidig),lit('også'),!],_9875,_9877) --> 
    cc(samtidig,_9875,_9896),
    cc('også',_9896,_9877),
    !.

also0([also0,lit('også'),!],_9870,_9872) --> 
    cc('også',_9870,_9872),
    !.

also0([also0,lit(samtidig),!],_9870,_9872) --> 
    cc(samtidig,_9870,_9872),
    !.

also0([also0,lit(deretter),!],_9870,_9872) --> 
    cc(deretter,_9870,_9872),
    !.

also0([also0,[]],_9865,_9865) --> 
    [].

anaa([anaa,_9882,_9906,!],_9871,_9873) --> 
    ann0(_9882,_9871,_9897),
    ogaa(_9906,_9897,_9873),
    !.

ogaa([ogaa,lit('å')],_9867,_9869) --> 
    cc('å',_9867,_9869).

ogaa([ogaa,lit(og)],_9867,_9869) --> 
    cc(og,_9867,_9869).

ann0([ann0,lit(an),!,_9900],_9873,_9875) --> 
    cc(an,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

ann0([ann0,[]],_9865,_9865) --> 
    [].

anorder(a,_9851,[anorder,_9897,_9921],_9880,_9882) --> 
    a(_9897,_9880,_9912),
    w(nb(_9851,ord),_9921,_9912,_9882).

anorder(the,_9851,[anorder,_9897,_9921],_9880,_9882) --> 
    the(_9897,_9880,_9912),
    w(nb(_9851,ord),_9921,_9912,_9882).

another([another,_9879,_9903],_9868,_9870) --> 
    a(_9879,_9868,_9894),
    other(_9903,_9894,_9870).

around0([around0,_9876],_9865,_9867) --> 
    around1(_9876,_9865,_9867).

around0([around0,[]],_9865,_9865) --> 
    [].

around1([around1,_9876],_9865,_9867) --> 
    ca(_9876,_9865,_9867).

around1([around1,lit(om),lit(lag)],_9872,_9874) --> 
    cc(om,_9872,_9893),
    cc(lag,_9893,_9874).

around1([around1,_9878],_9867,_9869) --> 
    prep1(around,_9878,_9867,_9869).

as([as,lit(som)],_9867,_9869) --> 
    cc(som,_9867,_9869).

as0([as0,_9876],_9865,_9867) --> 
    as(_9876,_9865,_9867).

as0([as0,[]],_9865,_9865) --> 
    [].

andsoon([andsoon,lit(og),_9892],_9870,_9872) --> 
    cc(og,_9870,_9891),
    sovidere0(_9892,_9891,_9872).

sovidere0([sovidere0,_9879,_9903],_9868,_9870) --> 
    sov0(_9879,_9868,_9894),
    videre0(_9903,_9894,_9870).

sov0([sov0,lit('så')],_9867,_9869) --> 
    cc('så',_9867,_9869).

sov0([sov0,[]],_9865,_9865) --> 
    [].

videre0([videre0,lit(videre)],_9867,_9869) --> 
    cc(videre,_9867,_9869).

videre0([videre0,[]],_9865,_9865) --> 
    [].

aspossible0([aspossible0,_9882,!,_9911],_9871,_9873) --> 
    aspossible(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

aspossible0([aspossible0,_9876],_9865,_9867) --> 
    possible0(_9876,_9865,_9867).

aspossible([aspossible,_9884,_9908],_9873,_9875) --> 
    as(_9884,_9873,_9899),
    w(adj2(possible,nil),_9908,_9899,_9875).

aso0([aso0,lit('så'),!,_9900],_9873,_9875) --> 
    cc('så',_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

aso0([aso0,_9882,!,_9911],_9871,_9873) --> 
    too(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

aso0([aso0,_9876],_9865,_9867) --> 
    as(_9876,_9865,_9867).

aso0([aso0,[]],_9865,_9865) --> 
    [].

at([at,_9878],_9867,_9869) --> 
    prep(at,_9878,_9867,_9869).

athe([athe,_9876],_9865,_9867) --> 
    the(_9876,_9865,_9867).

athe([athe,_9876],_9865,_9867) --> 
    a(_9876,_9865,_9867).

athe0([athe0,_9879,!],_9868,_9870) --> 
    athe(_9879,_9868,_9870),
    !.

athe0([athe0,[]],_9865,_9865) --> 
    [].

blei(_9850,[blei,_9908,_9937,_9966,!],_9894,_9896) --> 
    w(verb(stand,pres,fin),_9908,_9894,_9925),
    negation0(_9850,_9937,_9925,_9954),
    look_ahead(w(verb(_9873,past,part)),_9966,_9954,_9896),
    !.

blei(_9850,[blei,_9888,_9912],_9874,_9876) --> 
    blei(_9888,_9874,_9903),
    negation0(_9850,_9912,_9903,_9876).

blei([blei,_9896,_9925,!],_9885,_9887) --> 
    w(verb(stand,pres,fin),_9896,_9885,_9913),
    look_ahead(w(verb(_9866,past,part)),_9925,_9913,_9887),
    !.

blei([blei,_9885,!],_9874,_9876) --> 
    w(verb(be,_9856,fin),_9885,_9874,_9876),
    !.

blei([blei,_9891,_9915,_9939,!],_9880,_9882) --> 
    has(_9891,_9880,_9906),
    redundant0(_9915,_9906,_9930),
    w(verb(be,past,part),_9939,_9930,_9882),
    !.

blei([blei,_9888,_9912,!],_9877,_9879) --> 
    aux1(_9888,_9877,_9903),
    w(verb(be,past,part),_9912,_9903,_9879),
    !.

blei([blei,_9888,_9912,!],_9877,_9879) --> 
    aux1(_9888,_9877,_9903),
    w(verb(be,inf,fin),_9912,_9903,_9879),
    !.

aux0(_9850,_9851,[aux0,_9895,!],_9878,_9880) --> 
    aux1(_9850,_9851,_9895,_9878,_9880),
    !.

aux0(id,pres,[aux0,_9889],_9872,_9874) --> 
    aux0(_9889,_9872,_9874).

auxs0(_9850,_9851,[auxs0,_9895,!],_9878,_9880) --> 
    aux1(_9850,_9851,_9895,_9878,_9880),
    !.

auxs0(_9850,_9851,[auxs0,[]],_9872,_9872) --> 
    [].

auxs([auxs,_9879,_9903],_9868,_9870) --> 
    aux1(_9879,_9868,_9894),
    auxs0(_9903,_9894,_9870).

auxs0([auxs0,_9882,!,_9911],_9871,_9873) --> 
    aux1(_9882,_9871,_9897),
    !,
    auxs0(_9911,_9897,_9873).

auxs0([auxs0,[]],_9865,_9865) --> 
    [].

aux1(_9850,pres,[aux1,lit(kan),_9924,_9948,_9977,!],_9896,_9898) --> 
    cc(kan,_9896,_9923),
    redundant0(_9924,_9923,_9939),
    negation0(_9850,_9948,_9939,_9965),
    look_ahead(w(verb(_9873,_9874,_9875)),_9977,_9965,_9898),
    !.

aux1(_9850,past,[aux1,lit(kunne),_9921,_9950,!],_9893,_9895) --> 
    cc(kunne,_9893,_9920),
    negation0(_9850,_9921,_9920,_9938),
    look_ahead(w(verb(_9870,_9871,_9872)),_9950,_9938,_9895),
    !.

aux1(_9850,past,[aux1,lit(burde),_9910,!],_9882,_9884) --> 
    cc(burde,_9882,_9909),
    negation0(_9850,_9910,_9909,_9884),
    !.

aux1(_9850,past,[aux1,lit(kunne),_9910,!],_9882,_9884) --> 
    cc(kunne,_9882,_9909),
    negation0(_9850,_9910,_9909,_9884),
    !.

aux1(_9850,pres,[aux1,_9894,_9918],_9877,_9879) --> 
    aux1(_9894,_9877,_9909),
    negation0(_9850,_9918,_9909,_9879).

skalsaa([skalsaa,_9879,_9903],_9868,_9870) --> 
    aux1(_9879,_9868,_9894),
    so0(_9903,_9894,_9870).

faux1([faux1,_9885,!],_9874,_9876) --> 
    w(verb(get,_9856,fin),_9885,_9874,_9876),
    !.

faux1([faux1,_9876],_9865,_9867) --> 
    aux1(_9876,_9865,_9867).

aux1([aux1,_9907,_9936,_9965,!],_9896,_9898) --> 
    one_of_lit([kan,kunne,'får',fikk],_9907,_9896,_9924),
    not_look_ahead(['nå'],_9936,_9924,_9953),
    look_ahead(w(verb(_9877,inf,_9879)),_9965,_9953,_9898),
    !.

aux1([aux1,_9882],_9871,_9873) --> 
    one_of_lit([kan,kunne],_9882,_9871,_9873).

aux1([aux1,_9894],_9883,_9885) --> 
    one_of_lit(['bør',burde,'må','måtte',skal,skulle,vil,ville],_9894,_9883,_9885).

aux10([aux10,_9879,!],_9868,_9870) --> 
    aux1(_9879,_9868,_9870),
    !.

aux10([aux10,[]],_9865,_9865) --> 
    [].

aux0([aux0,_9890,_9914,!],_9879,_9881) --> 
    faa(_9890,_9879,_9905),
    look_ahead(w(verb(_9860,_9861,_9862)),_9914,_9905,_9881),
    !.

aux0([aux0,lit('må')],_9867,_9869) --> 
    cc('må',_9867,_9869).

aux0([aux0,_9900,lit('så'),_9935,lit('å'),!,_9980],_9889,_9891) --> 
    be(_9900,_9889,_9915),
    cc('så',_9915,_9934),
    w(adj2(good,nil),_9935,_9934,_9952),
    cc('å',_9952,_9974),
    !,
    accept(_9980,_9974,_9891).

aux0([aux0,_9876],_9865,_9867) --> 
    doit(_9876,_9865,_9867).

aux0([aux0,[]],_9865,_9865) --> 
    [].

paux0([paux0,_9884,lit(blitt),!],_9873,_9875) --> 
    has(_9884,_9873,_9899),
    cc(blitt,_9899,_9875),
    !.

paux0([paux0,lit(vil),lit(bli),!],_9875,_9877) --> 
    cc(vil,_9875,_9896),
    cc(bli,_9896,_9877),
    !.

paux0([paux0,lit(_9855),{},!],_9898,_9900) --> 
    cc(_9855,_9898,_9900),
    {user:testmember(_9855,[skal,vil,'bør','må',kan,skulle,ville,burde,'måtte',kunne])},
    !.

paux0([paux0,[]],_9865,_9865) --> 
    [].

do(_9850,[do,_9891,_9915,_9944],_9877,_9879) --> 
    use(_9891,_9877,_9906),
    negation0(_9850,_9915,_9906,_9932),
    infinitive(_9944,_9932,_9879).

do(_9850,[do,_9891,_9915,_9944],_9877,_9879) --> 
    doit(_9891,_9877,_9906),
    negation0(_9850,_9915,_9906,_9932),
    hasto0(_9944,_9932,_9879).

do(id,[do,[]],_9869,_9869) --> 
    [].

do0([do0,_9876],_9865,_9867) --> 
    doit(_9876,_9865,_9867).

do0([do0,[]],_9865,_9865) --> 
    [].

docan([docan,lit(kan)],_9867,_9869) --> 
    cc(kan,_9867,_9869).

docan([docan,lit('må')],_9867,_9869) --> 
    cc('må',_9867,_9869).

docan([docan,lit('får')],_9867,_9869) --> 
    cc('får',_9867,_9869).

docan([docan,_9879,!],_9868,_9870) --> 
    doit(_9879,_9868,_9870),
    !.

doit([doit,_9892,_9916,!,_9950],_9881,_9883) --> 
    faa(_9892,_9881,_9907),
    w(noun(information,_9862,_9863,_9864),_9916,_9907,_9933),
    !,
    reject(_9950,_9933,_9883).

doit([doit,lit(vil),lit(vil),!,_9916],_9878,_9880) --> 
    cc(vil,_9878,_9899),
    cc(vil,_9899,_9910),
    !,
    accept(_9916,_9910,_9880).

doit([doit,_9876],_9865,_9867) --> 
    skalsaa(_9876,_9865,_9867).

doit([doit,_9876],_9865,_9867) --> 
    may(_9876,_9865,_9867).

doit([doit,_9876],_9865,_9867) --> 
    must(_9876,_9865,_9867).

may([may,lit(kan),_9900],_9878,_9880) --> 
    cc(kan,_9878,_9899),
    look_ahead(w(verb(_9857,_9858,_9859)),_9900,_9899,_9880).

may([may,lit('får'),_9900],_9878,_9880) --> 
    cc('får',_9878,_9899),
    look_ahead(w(verb(_9857,_9858,_9859)),_9900,_9899,_9880).

may([may,lit('bør')],_9867,_9869) --> 
    cc('bør',_9867,_9869).

may([may,lit('må')],_9867,_9869) --> 
    cc('må',_9867,_9869).

must([must,lit('må')],_9867,_9869) --> 
    cc('må',_9867,_9869).

must([must,lit(skal)],_9867,_9869) --> 
    cc(skal,_9867,_9869).

be(_9850,[be,_9914,_9943,_9972,!,_10001,{}],_9900,_9902) --> 
    w(verb(hold,_9876,fin),_9914,_9900,_9931),
    negation0(_9869,_9943,_9931,_9960),
    rfxpron(_9972,_9960,_9987),
    !,
    negation0(_9870,_10001,_9987,_9902),
    {user:bigno(_9869,_9870,_9850)}.

be(_9850,[be,_9891,!,_9925],_9877,_9879) --> 
    be1(_9850,_9891,_9877,_9908),
    !,
    accept(_9925,_9908,_9879).

be(not,[be,_9886,_9910],_9872,_9874) --> 
    not(_9886,_9872,_9901),
    be(_9910,_9901,_9874).

be(id,[be,_9883],_9869,_9871) --> 
    be(_9883,_9869,_9871).

be0([be0,_9878],_9867,_9869) --> 
    optional(be,_9878,_9867,_9869).

be([be,_9888,_9912,!],_9877,_9879) --> 
    aux1(_9888,_9877,_9903),
    w(verb(be,inf,fin),_9912,_9903,_9879),
    !.

be([be,_9897,_9926,_9950,!],_9886,_9888) --> 
    w(verb(have,_9862,fin),_9897,_9886,_9914),
    redundant0(_9926,_9914,_9941),
    w(verb(be,past,part),_9950,_9941,_9888),
    !.

be([be,_9885,!],_9874,_9876) --> 
    w(verb(be,_9856,part),_9885,_9874,_9876),
    !.

be([be,_9888,_9917,!],_9877,_9879) --> 
    w(verb(be,_9859,fin),_9888,_9877,_9905),
    been0(_9917,_9905,_9879),
    !.

be1(_9850,[be1,_9897,_9926,_9950],_9883,_9885) --> 
    w(verb(be,_9863,fin),_9897,_9883,_9914),
    redundant0(_9926,_9914,_9941),
    negation0(_9850,_9950,_9941,_9885).

be1(_9850,[be1,_9900,_9924,_9948,_9977],_9886,_9888) --> 
    aux1(_9900,_9886,_9915),
    redundant0(_9924,_9915,_9939),
    negation0(_9850,_9948,_9939,_9965),
    w(verb(be,inf,fin),_9977,_9965,_9888).

be1(_9850,[be1,_9906,_9935,_9959,_9993,!],_9892,_9894) --> 
    negation0(_9864,_9906,_9892,_9923),
    aux1(_9935,_9923,_9950),
    negation2(_9864,_9850,_9959,_9950,_9978),
    w(verb(be,inf,fin),_9993,_9978,_9894),
    !.

be1(_9850,[be1,_9906,_9935,_9964,!],_9892,_9894) --> 
    w(verb(have,_9864,fin),_9906,_9892,_9923),
    negation0(_9850,_9935,_9923,_9952),
    w(verb(be,past,part),_9964,_9952,_9894),
    !.

be1(_9850,[be1,_9897,_9926,_9950,_9974],_9883,_9885) --> 
    negation0(_9861,_9897,_9883,_9914),
    be(_9926,_9914,_9941),
    redundant0(_9950,_9941,_9965),
    negation2(_9861,_9850,_9974,_9965,_9885).

be1(_9850,[be1,_9899,_9928,lit(blitt)],_9885,_9887) --> 
    w(verb(have,_9863,fin),_9899,_9885,_9916),
    negation0(_9850,_9928,_9916,_9945),
    cc(blitt,_9945,_9887).

be1(id,[be1,lit(blitt)],_9871,_9873) --> 
    cc(blitt,_9871,_9873).

be1(not,[be1,_9897,_9926,_9955],_9883,_9885) --> 
    w(verb(reject,_9861,fin),_9897,_9883,_9914),
    prep(to,_9926,_9914,_9943),
    be(_9955,_9943,_9885).

be_truefalse_that(_9850,[be_truefalse_that,_9917,{},_9956,lit(ut),_9996,!],_9903,_9905) --> 
    w(verb(_9869,_9870,fin),_9917,_9903,_9934),
    {user:testmember(_9869,[look,see])},
    negation0(_9850,_9956,_9934,_9973),
    cc(ut,_9973,_9995),
    somatom0(_9996,_9995,_9905),
    !.

be_truefalse_that(_9850,[be_truefalse_that,_9917,{},_9956,lit(ut),_9996,!],_9903,_9905) --> 
    w(verb(_9869,_9870,fin),_9917,_9903,_9934),
    {user:testmember(_9869,[look,see])},
    negation0(_9850,_9956,_9934,_9973),
    cc(ut,_9973,_9995),
    somatom0(_9996,_9995,_9905),
    !.

be_truefalse_that(_9850,[be_truefalse_that,_9912,{},_9951,_9980,!],_9898,_9900) --> 
    w(verb(_9866,_9867,fin),_9912,_9898,_9929),
    {user:testmember(_9866,[appear,be])},
    negation0(_9850,_9951,_9929,_9968),
    somatom0(_9980,_9968,_9900),
    !.

somatom0([somatom0,_9879,!],_9868,_9870) --> 
    somatom(_9879,_9868,_9870),
    !.

somatom0([somatom0,[]],_9865,_9865) --> 
    [].

somatom([somatom,_9889,lit(at),!],_9878,_9880) --> 
    w(adj2(true,nil),_9889,_9878,_9906),
    cc(at,_9906,_9880),
    !.

somatom([somatom,lit(som),lit(at),!],_9875,_9877) --> 
    cc(som,_9875,_9896),
    cc(at,_9896,_9877),
    !.

somatom([somatom,lit(som),lit(om),!],_9875,_9877) --> 
    cc(som,_9875,_9896),
    cc(om,_9896,_9877),
    !.

somatom([somatom,lit(som)],_9867,_9869) --> 
    cc(som,_9867,_9869).

somatom([somatom,lit(at)],_9867,_9869) --> 
    cc(at,_9867,_9869).

somatom([somatom,lit(til),lit(at),!],_9875,_9877) --> 
    cc(til,_9875,_9896),
    cc(at,_9896,_9877),
    !.

somatom([somatom,lit(til)],_9867,_9869) --> 
    cc(til,_9867,_9869).

be_truefalse_that(_9850,[be_truefalse_that,_9914,_9943,_9977,_10006,!],_9900,_9902) --> 
    w(verb(_9866,_9867,fin),_9914,_9900,_9931),
    gmem(_9866,[agree,appear],_9943,_9931,_9962),
    negation0(_9850,_9977,_9962,_9994),
    optional([at],_10006,_9994,_9902),
    !.

be_truefalse_that(_9850,[be_truefalse_that,_9904,_9933,_9962,!],_9890,_9892) --> 
    negation0(_9850,_9904,_9890,_9921),
    one_of_lit(['så',slik],_9933,_9921,_9950),
    optional([at],_9962,_9950,_9892),
    !.

be_truefalse_that(id,[be_truefalse_that,_9904,_9933,lit(at),!],_9890,_9892) --> 
    w(verb(show,_9864,fin),_9904,_9890,_9921),
    optional([seg],_9933,_9921,_9965),
    cc(at,_9965,_9892),
    !.

be_truefalse_that(_9850,[be_truefalse_that,_9917,{},_9956,lit(ut),_9996,!],_9903,_9905) --> 
    w(verb(_9869,_9870,fin),_9917,_9903,_9934),
    {user:testmember(_9869,[see,look])},
    negation0(_9850,_9956,_9934,_9973),
    cc(ut,_9973,_9995),
    somatom(_9996,_9995,_9905),
    !.

be_truefalse_that(_9850,[be_truefalse_that,_9912,{},_9951,_9980,!],_9898,_9900) --> 
    w(verb(_9866,_9867,fin),_9912,_9898,_9929),
    {user:testmember(_9866,[be,appear])},
    negation0(_9850,_9951,_9929,_9968),
    somatom(_9980,_9968,_9900),
    !.

be_truefalse_that(_9850,[be_truefalse_that,_9895,_9924,!],_9881,_9883) --> 
    be_truefalse(_9850,_9895,_9881,_9912),
    optional([at],_9924,_9912,_9883),
    !.

be_truefalse(_9850,[be_truefalse,_9912,{},_9951,_9980,!],_9898,_9900) --> 
    w(verb(_9866,_9867,fin),_9912,_9898,_9929),
    {user:testmember(_9866,[be,appear])},
    negation0(_9850,_9951,_9929,_9968),
    somatom(_9980,_9968,_9900),
    !.

be_truefalse(_9850,[be_truefalse,_9904,_9953,!],_9890,_9892) --> 
    lexvaccept(rv,_9859,_9860,fin,_9850,_9904,_9890,_9929),
    gmem(_9859,[stand,mean2,indicate],_9953,_9929,_9892),
    !.

be_truefalse(_9850,[be_truefalse,_9919,{},_9958,lit(ut),lit(til),!],_9905,_9907) --> 
    w(verb(_9869,_9870,fin),_9919,_9905,_9936),
    {user:testmember(_9869,[see,look])},
    negation0(_9850,_9958,_9936,_9975),
    cc(ut,_9975,_9997),
    cc(til,_9997,_9907),
    !.

be_truefalse(_9850,[be_truefalse,_9919,{},_9958,lit(ut),lit(for),!],_9905,_9907) --> 
    w(verb(_9869,_9870,fin),_9919,_9905,_9936),
    {user:testmember(_9869,[see,look])},
    negation0(_9850,_9958,_9936,_9975),
    cc(ut,_9975,_9997),
    cc(for,_9997,_9907),
    !.

be_truefalse(_9850,[be_truefalse,_9919,{},_9958,lit(ut),lit(som),!],_9905,_9907) --> 
    w(verb(_9869,_9870,fin),_9919,_9905,_9936),
    {user:testmember(_9869,[see,look])},
    negation0(_9850,_9958,_9936,_9975),
    cc(ut,_9975,_9997),
    cc(som,_9997,_9907),
    !.

be_truefalse(_9850,[be_truefalse,_9897,!,_9931],_9883,_9885) --> 
    w(verb(agree,_9863,fin),_9897,_9883,_9914),
    !,
    negation0(_9850,_9931,_9914,_9885).

be_truefalse(_9850,[be_truefalse,_9888,_9912],_9874,_9876) --> 
    be(_9888,_9874,_9903),
    truefalse(_9850,_9912,_9903,_9876).

be_truefalse(not,[be_truefalse,_9898,_9927,_9951,_9975],_9884,_9886) --> 
    w(verb(reject,_9864,fin),_9898,_9884,_9915),
    infinitive(_9927,_9915,_9942),
    be(_9951,_9942,_9966),
    true(_9975,_9966,_9886).

been0([been0,_9882,!,_9911],_9871,_9873) --> 
    been(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

been0([been0,[]],_9865,_9865) --> 
    [].

been([been,_9882],_9871,_9873) --> 
    w(verb(be,past,part),_9882,_9871,_9873).

betake([betake,_9876],_9865,_9867) --> 
    be(_9876,_9865,_9867).

betake([betake,_9882],_9871,_9873) --> 
    w(verb(take,_9853,fin),_9882,_9871,_9873).

both0([both0,lit('både')],_9867,_9869) --> 
    cc('både',_9867,_9869).

both0([both0,[]],_9865,_9865) --> 
    [].

by([by,lit(av),_9896],_9874,_9876) --> 
    cc(av,_9874,_9895),
    not_look_ahead([hensyn],_9896,_9895,_9876).

ca0([ca0,_9882,!,_9911],_9871,_9873) --> 
    ca(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

ca0([ca0,[]],_9865,_9865) --> 
    [].

ca([ca,_9887,_9916,!,_9945],_9876,_9878) --> 
    prep1(around,_9887,_9876,_9904),
    point0(_9916,_9904,_9931),
    !,
    accept(_9945,_9931,_9878).

clock0([clock0,_9876],_9865,_9867) --> 
    clock(_9876,_9865,_9867).

clock0([clock0,[]],_9865,_9865) --> 
    [].

clock([clock,lit(k),_9902,!],_9880,_9882) --> 
    cc(k,_9880,_9901),
    look_ahead(w(nb(_9862,_9863)),_9902,_9901,_9882),
    !.

clock([clock,lit(k),_9905,_9929,!],_9883,_9885) --> 
    cc(k,_9883,_9904),
    point(_9905,_9904,_9920),
    look_ahead(w(nb(_9865,_9866)),_9929,_9920,_9885),
    !.

clock([clock,lit(kl),_9895,!],_9873,_9875) --> 
    cc(kl,_9873,_9894),
    colon(_9895,_9894,_9875),
    !.

clock([clock,_9885,_9909,_9933,_9957],_9874,_9876) --> 
    point0(_9885,_9874,_9900),
    klokken(_9909,_9900,_9924),
    point0(_9933,_9924,_9948),
    ca0(_9957,_9948,_9876).

clock([clock,_9882,_9906,_9930],_9871,_9873) --> 
    point0(_9882,_9871,_9897),
    klokken(_9906,_9897,_9921),
    colon0(_9930,_9921,_9873).

klokken([klokken,lit(kl)],_9867,_9869) --> 
    cc(kl,_9867,_9869).

klokken([klokken,_9883],_9872,_9874) --> 
    w(noun(clock,sin,_9854,n),_9883,_9872,_9874).

colon0([colon0,_9882,!,_9911],_9871,_9873) --> 
    colon(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

colon0([colon0,_9880],_9869,_9871) --> 
    not_look_ahead(['.'],_9880,_9869,_9871).

colon([colon,lit(:)],_9867,_9869) --> 
    cc(:,_9867,_9869).

colon([colon,lit(;)],_9867,_9869) --> 
    cc(;,_9867,_9869).

comparator1(_9850,[comparator1,_9888,!],_9874,_9876) --> 
    comparel(_9850,_9888,_9874,_9876),
    !.

comparel(eq,[comparel,_9886,_9910],_9872,_9874) --> 
    equal(_9886,_9872,_9901),
    tomed0(_9910,_9901,_9874).

comparel(ge,[comparel,_9895,_9919,_9943,_9967,_9991],_9881,_9883) --> 
    greater(_9895,_9881,_9910),
    than0(_9919,_9910,_9934),
    or1(_9943,_9934,_9958),
    equal(_9967,_9958,_9982),
    to0(_9991,_9982,_9883).

comparel(ge,[comparel,_9889,_9913,_9937],_9875,_9877) --> 
    not(_9889,_9875,_9904),
    less(_9913,_9904,_9928),
    than(_9937,_9928,_9877).

comparel(ge,[comparel,lit(minst)],_9871,_9873) --> 
    cc(minst,_9871,_9873).

comparel(gt,[comparel,_9886,_9910],_9872,_9874) --> 
    greater(_9886,_9872,_9901),
    than(_9910,_9901,_9874).

comparel(gt,[comparel,lit(mer),_9899],_9874,_9876) --> 
    cc(mer,_9874,_9898),
    than(_9899,_9898,_9876).

comparel(gt,[comparel,_9885],_9871,_9873) --> 
    prep1(over,_9885,_9871,_9873).

comparel(le,[comparel,_9895,_9919,_9943,_9967,_9991],_9881,_9883) --> 
    less(_9895,_9881,_9910),
    than0(_9919,_9910,_9934),
    or1(_9943,_9934,_9958),
    equal(_9967,_9958,_9982),
    to0(_9991,_9982,_9883).

comparel(le,[comparel,_9889,_9913,_9937],_9875,_9877) --> 
    not(_9889,_9875,_9904),
    more(_9913,_9904,_9928),
    than(_9937,_9928,_9877).

comparel(le,[comparel,_9889,_9913,_9937],_9875,_9877) --> 
    not(_9889,_9875,_9904),
    greater(_9913,_9904,_9928),
    than(_9937,_9928,_9877).

comparel(le,[comparel,_9886,_9910],_9872,_9874) --> 
    at(_9886,_9872,_9901),
    most(_9910,_9901,_9874).

comparel(lt,[comparel,_9886,_9910],_9872,_9874) --> 
    less(_9886,_9872,_9901),
    than(_9910,_9901,_9874).

comparel(ne,[comparel,lit(forskjellig),_9901],_9876,_9878) --> 
    cc(forskjellig,_9876,_9900),
    prep1(from,_9901,_9900,_9878).

comparel(ne,[comparel,lit(annet),lit(enn)],_9876,_9878) --> 
    cc(annet,_9876,_9900),
    cc(enn,_9900,_9878).

comparel(ne,[comparel,lit(ulik)],_9871,_9873) --> 
    cc(ulik,_9871,_9873).

comparel(ne,[comparel,lit(unntatt)],_9871,_9873) --> 
    cc(unntatt,_9871,_9873).

comparel(ne,[comparel,_9886,_9910],_9872,_9874) --> 
    unequal(_9886,_9872,_9901),
    to0(_9910,_9901,_9874).

comparel(_9850,[comparel,_9893,lit(enn)],_9879,_9881) --> 
    w(adj2(_9850,comp),_9893,_9879,_9910),
    cc(enn,_9910,_9881).

comparel(_9850,[comparel,lit(mer),_9909,lit(enn)],_9884,_9886) --> 
    cc(mer,_9884,_9908),
    w(adj2(_9850,nil),_9909,_9908,_9926),
    cc(enn,_9926,_9886).

comparator2(gt,intelligent,[comparator2,_9897,_9926],_9880,_9882) --> 
    w(adj2(intelligent,nil),_9897,_9880,_9914),
    than(_9926,_9914,_9882).

comparator2(lt,intelligent,[comparator2,_9897,_9926],_9880,_9882) --> 
    w(adj2(stupid,nil),_9897,_9880,_9914),
    than(_9926,_9914,_9882).

comparator2(gt,quality,[comparator2,_9897,_9926],_9880,_9882) --> 
    w(adj2(good,comp),_9897,_9880,_9914),
    than(_9926,_9914,_9882).

comparator2(gt,age,[comparator2,_9892,_9916],_9875,_9877) --> 
    older(_9892,_9875,_9907),
    than(_9916,_9907,_9877).

comparator2(lt,age,[comparator2,_9892,_9916],_9875,_9877) --> 
    younger(_9892,_9875,_9907),
    than(_9916,_9907,_9877).

comparator2(gt,latitude,[comparator2,lit(nord),lit(for)],_9879,_9881) --> 
    cc(nord,_9879,_9906),
    cc(for,_9906,_9881).

comparator2(lt,latitude,[comparator2,lit('sør'),lit(for)],_9879,_9881) --> 
    cc('sør',_9879,_9906),
    cc(for,_9906,_9881).

comparator2(gt,longitude,[comparator2,lit(vest),lit(for)],_9879,_9881) --> 
    cc(vest,_9879,_9906),
    cc(for,_9906,_9881).

comparator2(lt,longitude,[comparator2,lit('øst'),lit(for)],_9879,_9881) --> 
    cc('øst',_9879,_9906),
    cc(for,_9906,_9881).

comparator2(gt,size,[comparator2,_9892,_9916],_9875,_9877) --> 
    greater(_9892,_9875,_9907),
    than(_9916,_9907,_9877).

comparator2(lt,size,[comparator2,lit(mindre),_9905],_9877,_9879) --> 
    cc(mindre,_9877,_9904),
    than(_9905,_9904,_9879).

comparator3(eq,_9851,[comparator3,lit(like),_9915,lit(som)],_9887,_9889) --> 
    cc(like,_9887,_9914),
    w(adj2(_9851,nil),_9915,_9914,_9932),
    cc(som,_9932,_9889).

comparator3(gt,_9851,[comparator3,lit(mer),_9915,lit(enn)],_9887,_9889) --> 
    cc(mer,_9887,_9914),
    w(adj2(_9851,nil),_9915,_9914,_9932),
    cc(enn,_9932,_9889).

comparator3(lt,_9851,[comparator3,lit(mindre),_9915,lit(enn)],_9887,_9889) --> 
    cc(mindre,_9887,_9914),
    w(adj2(_9851,nil),_9915,_9914,_9932),
    cc(enn,_9932,_9889).

comparator3(lt,_9851,[comparator3,lit(ikke),lit('så'),_9931,lit(som)],_9892,_9894) --> 
    cc(ikke,_9892,_9919),
    cc('så',_9919,_9930),
    w(adj2(_9851,nil),_9931,_9930,_9948),
    cc(som,_9948,_9894).

comparator3(ge,_9851,[comparator3,lit(minst),lit(like),_9931,lit(som)],_9892,_9894) --> 
    cc(minst,_9892,_9919),
    cc(like,_9919,_9930),
    w(adj2(_9851,nil),_9931,_9930,_9948),
    cc(som,_9948,_9894).

comparator3(le,_9851,[comparator3,lit('høyst'),lit('så'),_9931,lit(som)],_9892,_9894) --> 
    cc('høyst',_9892,_9919),
    cc('så',_9919,_9930),
    w(adj2(_9851,nil),_9931,_9930,_9948),
    cc(som,_9948,_9894).

superlative(_9850,_9851,[superlative,_9904,_9943,!,_9977],_9887,_9889) --> 
    filanepr(_9850,_9863,_9851,_9904,_9887,_9925),
    quant1(_9863,_9943,_9925,_9960),
    !,
    accept(_9977,_9960,_9889).

superlative(_9850,_9851,[superlative,_9898,_9927],_9881,_9883) --> 
    quant0(_9857,_9898,_9881,_9915),
    filanepr(_9850,_9857,_9851,_9927,_9915,_9883).

flnp(_9850,[flnp,_9902,_9931],_9888,_9890) --> 
    w(adj2(_9850,nil),_9902,_9888,_9919),
    gmem(_9850,[first,last,next,previous],_9931,_9919,_9890).

flnp(next,[flnp,lit(nest)],_9871,_9873) --> 
    cc(nest,_9871,_9873).

flnp(last,[flnp,_9891,!],_9877,_9879) --> 
    w(adj2(late,sup),_9891,_9877,_9879),
    !.

flnp(first,[flnp,_9888],_9874,_9876) --> 
    w(nb(1,ord),_9888,_9874,_9876).

flnpproper(_9850,[flnpproper,lit('først'),!,_9907],_9877,_9879) --> 
    cc('først',_9877,_9901),
    !,
    reject(_9907,_9901,_9879).

flnpproper(_9850,[flnpproper,lit(sist),!,_9907],_9877,_9879) --> 
    cc(sist,_9877,_9901),
    !,
    reject(_9907,_9901,_9879).

flnpproper(_9850,[flnpproper,lit(nest),!,_9907],_9877,_9879) --> 
    cc(nest,_9877,_9901),
    !,
    reject(_9907,_9901,_9879).

flnpproper(_9850,[flnpproper,_9885],_9871,_9873) --> 
    flnp(_9850,_9885,_9871,_9873).

filanepr([filanepr,_9884,!],_9873,_9875) --> 
    w(adj2(first,nil),_9884,_9873,_9875),
    !.

filanepr([filanepr,_9884,!],_9873,_9875) --> 
    w(adj2(last,nil),_9884,_9873,_9875),
    !.

filanepr([filanepr,_9884,!],_9873,_9875) --> 
    w(adj2(next,nil),_9884,_9873,_9875),
    !.

filanepr([filanepr,_9884,!],_9873,_9875) --> 
    w(adj2(previous,nil),_9884,_9873,_9875),
    !.

filanepr(min(_9851),_9851,time,[filanepr,_9897],_9877,_9879) --> 
    first(_9897,_9877,_9879).

filanepr(max(_9851),_9851,time,[filanepr,_9897],_9877,_9879) --> 
    latest(_9897,_9877,_9879).

filanepr(min(_9851),_9851,next,[filanepr,_9897],_9877,_9879) --> 
    next(_9897,_9877,_9879).

filanepr(max(_9851),_9851,previous,[filanepr,_9897],_9877,_9879) --> 
    previous(_9897,_9877,_9879).

filanepr(max(_9851),_9851,size,[filanepr,_9897],_9877,_9879) --> 
    greatest(_9897,_9877,_9879).

filanepr(min(_9851),_9851,size,[filanepr,lit(minste)],_9879,_9881) --> 
    cc(minste,_9879,_9881).

faaverb(_9850,[faaverb,_9895,_9919,!],_9881,_9883) --> 
    faa(_9895,_9881,_9910),
    w(verb(_9850,_9861,_9862),_9919,_9910,_9883),
    !.

faaverb(_9850,[faaverb,_9892,!],_9878,_9880) --> 
    w(verb(_9850,inf,fin),_9892,_9878,_9880),
    !.

da0([da0,lit(da),!,_9900],_9873,_9875) --> 
    cc(da,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

da0([da0,[]],_9865,_9865) --> 
    [].

de0([de0,lit(de),!,_9900],_9873,_9875) --> 
    cc(de,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

de0([de0,[]],_9865,_9865) --> 
    [].

dendagen(_9850,[dendagen,lit(om),_9910,_9939,!,_9968],_9885,_9887) --> 
    cc(om,_9885,_9909),
    day(_9850,_9910,_9909,_9927),
    den0(_9939,_9927,_9954),
    !,
    accept(_9968,_9954,_9887).

dendagen(nil,[dendagen,_9892,_9916,!,_9945],_9878,_9880) --> 
    today(_9892,_9878,_9907),
    den0(_9916,_9907,_9931),
    !,
    accept(_9945,_9931,_9880).

dendagen(nil,[dendagen,_9892,_9916,!,_9945],_9878,_9880) --> 
    yesterday(_9892,_9878,_9907),
    den0(_9916,_9907,_9931),
    !,
    accept(_9945,_9931,_9880).

dendagen(nil,[dendagen,_9892,_9916,!,_9945],_9878,_9880) --> 
    tomorrow(_9892,_9878,_9907),
    den0(_9916,_9907,_9931),
    !,
    accept(_9945,_9931,_9880).

dendagen(_9850,[dendagen,_9897,_9921,_9950,!,_9979],_9883,_9885) --> 
    on0(_9897,_9883,_9912),
    day(_9850,_9921,_9912,_9938),
    den0(_9950,_9938,_9965),
    !,
    accept(_9979,_9965,_9885).

dendagen(nil,[dendagen,_9894,lit(den),!,_9934],_9880,_9882) --> 
    on0(_9894,_9880,_9909),
    cc(den,_9909,_9928),
    !,
    accept(_9934,_9928,_9882).

dendagen(nil,[dendagen,_9894,_9923,!,_9952],_9880,_9882) --> 
    prep1(for,_9894,_9880,_9911),
    den0(_9923,_9911,_9938),
    !,
    accept(_9952,_9938,_9882).

dendagen(nil,[dendagen,_9891,!,_9925],_9877,_9879) --> 
    prep1(on,_9891,_9877,_9908),
    !,
    accept(_9925,_9908,_9879).

der0([der0,lit(der),_9898,!,_9927],_9876,_9878) --> 
    cc(der,_9876,_9897),
    qm0(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

der0([der0,_9876],_9865,_9867) --> 
    qm0(_9876,_9865,_9867).

qm0([qm0,lit(?)],_9867,_9869) --> 
    cc(?,_9867,_9869).

qm0([qm0,[]],_9865,_9865) --> 
    [].

detsamme([detsamme,lit(en),lit(gang)],_9872,_9874) --> 
    cc(en,_9872,_9893),
    cc(gang,_9893,_9874).

detsamme([detsamme,_9888,lit(det),lit(samme)],_9877,_9879) --> 
    prep1(with,_9888,_9877,_9905),
    cc(det,_9905,_9927),
    cc(samme,_9927,_9879).

den0([den0,_9879,!],_9868,_9870) --> 
    den(_9879,_9868,_9870),
    !.

den0([den0,[]],_9865,_9865) --> 
    [].

den([den,lit(den)],_9867,_9869) --> 
    cc(den,_9867,_9869).

dendet0([dendet0,_9883,!],_9872,_9874) --> 
    look_ahead([d],_9883,_9872,_9874),
    !.

dendet0([dendet0,lit(den),_9905,!,_9939],_9883,_9885) --> 
    cc(den,_9883,_9904),
    not_look_ahead(w(nb(_9865,_9866)),_9905,_9904,_9922),
    !,
    accept(_9939,_9922,_9885).

dendet0([dendet0,lit(det),!,_9900],_9873,_9875) --> 
    cc(det,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

dendet0([dendet0,[]],_9865,_9865) --> 
    [].

dent0([dent0,lit(den),!],_9870,_9872) --> 
    cc(den,_9870,_9872),
    !.

dent0([dent0,lit(det),!],_9870,_9872) --> 
    cc(det,_9870,_9872),
    !.

dent0([dent0,lit(de),!,_9900],_9873,_9875) --> 
    cc(de,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

dent0([dent0,lit(noen),!],_9870,_9872) --> 
    cc(noen,_9870,_9872),
    !.

dent0([dent0,lit(en),!],_9870,_9872) --> 
    cc(en,_9870,_9872),
    !.

dent0([dent0,[]],_9865,_9865) --> 
    [].

det0([det0,_9885,_9909,!,_9938],_9874,_9876) --> 
    thereit(_9885,_9874,_9900),
    thereit_not_pronoun(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

det0([det0,[]],_9865,_9865) --> 
    [].

dudet([dudet,lit(du)],_9867,_9869) --> 
    cc(du,_9867,_9869).

dudet([dudet,lit(det)],_9867,_9869) --> 
    cc(det,_9867,_9869).

dudet([dudet,_9878],_9867,_9869) --> 
    pronoun(_9850,_9878,_9867,_9869).

each([each,lit(alle),_9892],_9870,_9872) --> 
    cc(alle,_9870,_9891),
    the(_9892,_9891,_9872).

earlier([earlier,lit(tidligere)],_9867,_9869) --> 
    cc(tidligere,_9867,_9869).

earlier([earlier,_9883,lit('forhånd')],_9872,_9874) --> 
    prep1(on,_9883,_9872,_9900),
    cc('forhånd',_9900,_9874).

earlier([earlier,lit('derfør')],_9867,_9869) --> 
    cc('derfør',_9867,_9869).

either0([either0,lit(enten),!,_9900],_9873,_9875) --> 
    cc(enten,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

either0([either0,[]],_9865,_9865) --> 
    [].

equal([equal,lit(lik)],_9867,_9869) --> 
    cc(lik,_9867,_9869).

equal([equal,lit(likt)],_9867,_9869) --> 
    cc(likt,_9867,_9869).

iyou(du,[iyou,lit(du)],_9871,_9873) --> 
    cc(du,_9871,_9873).

iyou(jeg,[iyou,lit(jeg)],_9871,_9873) --> 
    cc(jeg,_9871,_9873).

iyou(vi,[iyou,lit(vi)],_9871,_9873) --> 
    cc(vi,_9871,_9873).

areyou([areyou,lit(erru),_9894],_9872,_9874) --> 
    cc(erru,_9872,_9893),
    negation0(_9853,_9894,_9893,_9874).

areyou([areyou,_9892,lit(du),_9932],_9881,_9883) --> 
    w(verb(be,_9861,fin),_9892,_9881,_9909),
    cc(du,_9909,_9931),
    negation0(_9856,_9932,_9931,_9883).

areyou([areyou,lit(vil),lit(du),_9919,_9948],_9886,_9888) --> 
    cc(vil,_9886,_9907),
    cc(du,_9907,_9918),
    negation0(_9869,_9919,_9918,_9936),
    w(verb(be,_9862,fin),_9948,_9936,_9888).

every([every,lit(alle),_9892],_9870,_9872) --> 
    cc(alle,_9870,_9891),
    de0(_9892,_9891,_9872).

every([every,lit(en),lit(hver)],_9872,_9874) --> 
    cc(en,_9872,_9893),
    cc(hver,_9893,_9874).

false([false,lit(galt)],_9867,_9869) --> 
    cc(galt,_9867,_9869).

false([false,lit(usant)],_9867,_9869) --> 
    cc(usant,_9867,_9869).

false([false,lit(feil)],_9867,_9869) --> 
    cc(feil,_9867,_9869).

false([false,lit(uriktig)],_9867,_9869) --> 
    cc(uriktig,_9867,_9869).

few([few,lit('få')],_9867,_9869) --> 
    cc('få',_9867,_9869).

few([few,lit('fåtallig')],_9867,_9869) --> 
    cc('fåtallig',_9867,_9869).

first([first,_9881],_9870,_9872) --> 
    w(adj2(first,nil),_9881,_9870,_9872).

first([first,lit(tidligste)],_9867,_9869) --> 
    cc(tidligste,_9867,_9869).

faa([faa,lit('få')],_9867,_9869) --> 
    cc('få',_9867,_9869).

faa([faa,lit('får')],_9867,_9869) --> 
    cc('får',_9867,_9869).

faa0([faa0,_9882,!,_9911],_9871,_9873) --> 
    faa(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

faa0([faa0,[]],_9865,_9865) --> 
    [].

fast([fast,lit(fort)],_9867,_9869) --> 
    cc(fort,_9867,_9869).

fast([fast,_9881],_9870,_9872) --> 
    w(adj2(fast,nil),_9881,_9870,_9872).

fast([fast,_9886,lit(mulig)],_9875,_9877) --> 
    w(adj2(fast,nil),_9886,_9875,_9903),
    cc(mulig,_9903,_9877).

fast([fast,_9876],_9865,_9867) --> 
    hereafter(_9876,_9865,_9867).

from([from,_9878],_9867,_9869) --> 
    prep(from,_9878,_9867,_9869).

'førn\'år'(['førn\'år',lit('når')],_9867,_9869) --> 
    cc('når',_9867,_9869).

'førn\'år'(['førn\'år',lit('før')],_9867,_9869) --> 
    cc('før',_9867,_9869).

great([great,_9881],_9870,_9872) --> 
    w(adj2(great,nil),_9881,_9870,_9872).

great([great,lit('høy')],_9867,_9869) --> 
    cc('høy',_9867,_9869).

greater([greater,_9878],_9867,_9869) --> 
    prep(after,_9878,_9867,_9869).

greater([greater,lit('større')],_9867,_9869) --> 
    cc('større',_9867,_9869).

greater([greater,lit('høyere')],_9867,_9869) --> 
    cc('høyere',_9867,_9869).

greater([greater,lit(mer)],_9867,_9869) --> 
    cc(mer,_9867,_9869).

greater([greater,_9876],_9865,_9867) --> 
    great(_9876,_9865,_9867).

greatest([greatest,lit('størst')],_9867,_9869) --> 
    cc('størst',_9867,_9869).

greatest([greatest,lit('største')],_9867,_9869) --> 
    cc('største',_9867,_9869).

halfhour([halfhour,lit(halv),_9899],_9877,_9879) --> 
    cc(halv,_9877,_9898),
    w(noun(hour,_9856,_9857,n),_9899,_9898,_9879).

halfhour([halfhour,lit(halvtime)],_9867,_9869) --> 
    cc(halvtime,_9867,_9869).

has(_9850,[has,_9900,_9924,_9953],_9886,_9888) --> 
    has(_9900,_9886,_9915),
    negation0(_9850,_9924,_9915,_9941),
    not_look_ahead(w(noun(arrival,_9863,_9864,n)),_9953,_9941,_9888).

has0([has0,_9879,!],_9868,_9870) --> 
    has(_9879,_9868,_9870),
    !.

has0([has0,[]],_9865,_9865) --> 
    [].

has([has,_9894,_9923],_9883,_9885) --> 
    w(verb(have,_9865,fin),_9894,_9883,_9911),
    not_look_ahead(w(noun(arrival,_9858,_9859,n)),_9923,_9911,_9885).

hashad0([hashad0,_9879,!],_9868,_9870) --> 
    hashad(_9879,_9868,_9870),
    !.

hashad0([hashad0,[]],_9865,_9865) --> 
    [].

hashad([hashad,_9897,_9926,!,_9960],_9886,_9888) --> 
    w(verb(have,_9862,_9863),_9897,_9886,_9914),
    w(verb(have,_9868,_9869),_9926,_9914,_9943),
    !,
    accept(_9960,_9943,_9888).

hashad([hashad,_9882],_9871,_9873) --> 
    w(verb(have,_9853,_9854),_9882,_9871,_9873).

hasto0([hasto0,_9885,_9914],_9874,_9876) --> 
    w(verb(have,_9856,fin),_9885,_9874,_9902),
    infinitive(_9914,_9902,_9876).

hasto0([hasto0,[]],_9865,_9865) --> 
    [].

hereafter([hereafter,lit(om),lit(ikke),lit('så'),lit(lenge)],_9882,_9884) --> 
    cc(om,_9882,_9903),
    cc(ikke,_9903,_9914),
    cc('så',_9914,_9925),
    cc(lenge,_9925,_9884).

hereafter([hereafter,_9879,_9903],_9868,_9870) --> 
    soonar(_9879,_9868,_9894),
    aspossible0(_9903,_9894,_9870).

hereafter([hereafter,lit('så'),_9908,lit(som),_9943,!],_9886,_9888) --> 
    cc('så',_9886,_9907),
    soon(_9908,_9907,_9923),
    cc(som,_9923,_9942),
    w(adj2(possible,nil),_9943,_9942,_9888),
    !.

hereafter([hereafter,_9894,_9923,_9947,!],_9883,_9885) --> 
    prep1(in,_9894,_9883,_9911),
    near(_9923,_9911,_9938),
    w(noun(future,_9864,_9865,_9866),_9947,_9938,_9885),
    !.

hereafter([hereafter,lit(med),lit(en),lit(gang)],_9877,_9879) --> 
    cc(med,_9877,_9898),
    cc(en,_9898,_9909),
    cc(gang,_9909,_9879).

hereafter([hereafter,lit(heretter)],_9867,_9869) --> 
    cc(heretter,_9867,_9869).

hereafter([hereafter,_9881,_9910],_9870,_9872) --> 
    prep1(from,_9881,_9870,_9898),
    nowon(_9910,_9898,_9872).

hereafter([hereafter,_9896,_9925,_9954],_9885,_9887) --> 
    prep1(in,_9896,_9885,_9913),
    w(adj2(nearest,nil),_9925,_9913,_9942),
    w(noun(future,_9859,_9860,n),_9954,_9942,_9887).

hereafter([hereafter,_9896,_9925,_9954],_9885,_9887) --> 
    prep1(on,_9896,_9885,_9913),
    w(adj2(_9867,nil),_9925,_9913,_9942),
    w(noun(way,_9859,u,n),_9954,_9942,_9887).

hereafter([hereafter,_9881,_9910],_9870,_9872) --> 
    prep1(after,_9881,_9870,_9898),
    now1(_9910,_9898,_9872).

hereafter([hereafter,_9883,lit(dette)],_9872,_9874) --> 
    prep1(after,_9883,_9872,_9900),
    cc(dette,_9900,_9874).

hereafter([hereafter,lit(raskest),lit(mulig)],_9872,_9874) --> 
    cc(raskest,_9872,_9893),
    cc(mulig,_9893,_9874).

hereafter([hereafter,_9886,lit(gang)],_9875,_9877) --> 
    w(adj2(next,nil),_9886,_9875,_9903),
    cc(gang,_9903,_9877).

hereafter([hereafter,lit(raskest)],_9867,_9869) --> 
    cc(raskest,_9867,_9869).

herefrom([herefrom,_9889,lit(her),!,_9934],_9878,_9880) --> 
    prep1(from,_9889,_9878,_9906),
    cc(her,_9906,_9928),
    !,
    accept(_9934,_9928,_9880).

herefrom([herefrom,lit(herfra)],_9867,_9869) --> 
    cc(herfra,_9867,_9869).

herefrom([herefrom,lit(derfra)],_9867,_9869) --> 
    cc(derfra,_9867,_9869).

how([how,lit(hvordan),_9892],_9870,_9872) --> 
    cc(hvordan,_9870,_9891),
    ialle0(_9892,_9891,_9872).

how([how,lit(hvorfor),_9892],_9870,_9872) --> 
    cc(hvorfor,_9870,_9891),
    ialle0(_9892,_9891,_9872).

hoq([hoq,lit(vil),lit(du),lit(at)],_9877,_9879) --> 
    cc(vil,_9877,_9898),
    cc(du,_9898,_9909),
    cc(at,_9909,_9879).

hoq([hoq,_9892,lit(det),lit(at)],_9881,_9883) --> 
    w(verb(mean,_9861,fin),_9892,_9881,_9909),
    cc(det,_9909,_9931),
    cc(at,_9931,_9883).

hoq([hoq,_9894,lit(det),lit(seg),_9940,lit(at)],_9883,_9885) --> 
    has(_9894,_9883,_9909),
    cc(det,_9909,_9928),
    cc(seg,_9928,_9939),
    redundant0(_9940,_9939,_9955),
    cc(at,_9955,_9885).

hoq([hoq,_9889,lit(det),_9924,lit(at)],_9878,_9880) --> 
    be(_9889,_9878,_9904),
    cc(det,_9904,_9923),
    redundant0(_9924,_9923,_9939),
    cc(at,_9939,_9880).

hoq([hoq,_9897,lit(det),lit(an),lit(at)],_9886,_9888) --> 
    w(verb(go,_9864,fin),_9897,_9886,_9914),
    cc(det,_9914,_9936),
    cc(an,_9936,_9947),
    cc(at,_9947,_9888).

hoq([hoq,_9897,lit(det),_9937,lit(at)],_9886,_9888) --> 
    w(verb(agree,_9864,fin),_9897,_9886,_9914),
    cc(det,_9914,_9936),
    negation0(_9869,_9937,_9936,_9954),
    cc(at,_9954,_9888).

ihvor([ihvor,lit(i),lit(hvor),!],_9875,_9877) --> 
    cc(i,_9875,_9896),
    cc(hvor,_9896,_9877),
    !.

ihvor([ihvor,lit(hvor)],_9867,_9869) --> 
    cc(hvor,_9867,_9869).

hvor([hvor,lit(hvor)],_9867,_9869) --> 
    cc(hvor,_9867,_9869).

hvordan([hvordan,lit(hvordan),!,_9900],_9873,_9875) --> 
    cc(hvordan,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

hvordan([hvordan,lit(hva),lit(slags),_9914,!,_9943],_9881,_9883) --> 
    cc(hva,_9881,_9902),
    cc(slags,_9902,_9913),
    type0(_9914,_9913,_9929),
    !,
    accept(_9943,_9929,_9883).

hvordan([hvordan,lit(hva),!,_9900],_9873,_9875) --> 
    cc(hva,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

hvordan([hvordan,lit(hvor),_9903,!,_9937],_9881,_9883) --> 
    cc(hvor,_9881,_9902),
    w(adj2(great,nil),_9903,_9902,_9920),
    !,
    accept(_9937,_9920,_9883).

hvorfor([hvorfor,lit(hvorfor),_9892],_9870,_9872) --> 
    cc(hvorfor,_9870,_9891),
    ialle0(_9892,_9891,_9872).

type0([type0,_9882,!,_9911],_9871,_9873) --> 
    type(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

type0([type0,[]],_9865,_9865) --> 
    [].

type([type,_9889,!,_9923],_9878,_9880) --> 
    w(noun(type,_9859,u,n),_9889,_9878,_9906),
    !,
    accept(_9923,_9906,_9880).

i([i,lit(jeg)],_9867,_9869) --> 
    cc(jeg,_9867,_9869).

i([i,lit(meg)],_9867,_9869) --> 
    cc(meg,_9867,_9869).

i([i,lit(oss)],_9867,_9869) --> 
    cc(oss,_9867,_9869).

ialle0([ialle0,[]],_9865,_9865) --> 
    [].

if1([if1,lit(hvis)],_9867,_9869) --> 
    cc(hvis,_9867,_9869).

if1([if1,lit(om),_9910,{}],_9888,_9890) --> 
    cc(om,_9888,_9909),
    look_ahead(w(name(_9869,_9870,_9860)),_9910,_9909,_9890),
    {user:(\+subclass0(_9860,place))}.

if1([if1,lit(om),_9911,{}],_9889,_9891) --> 
    cc(om,_9889,_9910),
    look_ahead(w(noun(_9860,_9870,_9871,_9872)),_9911,_9910,_9891),
    {user:(\+subclass0(_9860,place))}.

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([jeg],_9896,_9895,_9876).

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([du],_9896,_9895,_9876).

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([han],_9896,_9895,_9876).

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([hun],_9896,_9895,_9876).

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([man],_9896,_9895,_9876).

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([vi],_9896,_9895,_9876).

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([dere],_9896,_9895,_9876).

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([de],_9896,_9895,_9876).

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([en],_9896,_9895,_9876).

if1([if1,lit(om),_9896],_9874,_9876) --> 
    cc(om,_9874,_9895),
    look_ahead([et],_9896,_9895,_9876).

ifra([ifra,lit(fra)],_9867,_9869) --> 
    cc(fra,_9867,_9869).

ifra([ifra,lit(ifra)],_9867,_9869) --> 
    cc(ifra,_9867,_9869).

iman([iman,lit(jeg)],_9867,_9869) --> 
    cc(jeg,_9867,_9869).

iman([iman,lit(man)],_9867,_9869) --> 
    cc(man,_9867,_9869).

iman([iman,lit(en)],_9867,_9869) --> 
    cc(en,_9867,_9869).

iman([iman,lit(du)],_9867,_9869) --> 
    cc(du,_9867,_9869).

inperiod0([inperiod0,_9894,_9923,!,_9957],_9883,_9885) --> 
    prep1(in,_9894,_9883,_9911),
    w(noun(hour,_9864,def,n),_9923,_9911,_9940),
    !,
    accept(_9957,_9940,_9885).

inperiod0([inperiod0,lit(om),_9905,!,_9939],_9883,_9885) --> 
    cc(om,_9883,_9904),
    w(noun(day,_9864,def,n),_9905,_9904,_9922),
    !,
    accept(_9939,_9922,_9885).

inperiod0([inperiod0,lit(hver),_9905,!,_9939],_9883,_9885) --> 
    cc(hver,_9883,_9904),
    w(noun(day,sin,u,n),_9905,_9904,_9922),
    !,
    accept(_9939,_9922,_9885).

inperiod0([inperiod0,[]],_9865,_9865) --> 
    [].

in_order_to(adj/nil/_9854,id,[in_order_to,_9895],_9878,_9880) --> 
    infinitiveand(_9895,_9878,_9880).

in_order_to(begin,id,[in_order_to,_9895,!,_9924],_9878,_9880) --> 
    infinitive(_9895,_9878,_9910),
    !,
    accept(_9924,_9910,_9880).

in_order_to(like,id,[in_order_to,_9895,!,_9924],_9878,_9880) --> 
    infinitive(_9895,_9878,_9910),
    !,
    accept(_9924,_9910,_9880).

in_order_to(start,id,[in_order_to,_9895,!,_9924],_9878,_9880) --> 
    infinitive(_9895,_9878,_9910),
    !,
    accept(_9924,_9910,_9880).

in_order_to(stop,id,[in_order_to,_9895,!,_9924],_9878,_9880) --> 
    infinitive(_9895,_9878,_9910),
    !,
    accept(_9924,_9910,_9880).

in_order_to(use,id,[in_order_to,_9916,{},_9955,!,_9984],_9899,_9901) --> 
    prepnof(_9865,_9916,_9899,_9933),
    {user:testmember(_9865,[on,to,for,with])},
    infinitive(_9955,_9933,_9970),
    !,
    accept(_9984,_9970,_9901).

in_order_to(use2,id,[in_order_to,_9895,!,_9924],_9878,_9880) --> 
    infinitive(_9895,_9878,_9910),
    !,
    accept(_9924,_9910,_9880).

in_order_to(have,id,[in_order_to,_9889],_9872,_9874) --> 
    infinitive(_9889,_9872,_9874).

in_order_to(think,id,[in_order_to,[]],_9872,_9872) --> 
    [].

in_order_to(_9850,not,[in_order_to,lit(uten),_9905],_9877,_9879) --> 
    cc(uten,_9877,_9904),
    infinitive(_9905,_9904,_9879).

in_order_to(_9850,id,[in_order_to,_9889],_9872,_9874) --> 
    in_order_to(_9889,_9872,_9874).

in_order_tox([in_order_tox,_9879,!],_9868,_9870) --> 
    infinitive(_9879,_9868,_9870),
    !.

in_order_tox([in_order_tox,_9876],_9865,_9867) --> 
    in_order_to(_9876,_9865,_9867).

in_order_to([in_order_to,_9876],_9865,_9867) --> 
    'forå'(_9876,_9865,_9867).

in_order_to([in_order_to,lit('får'),_9895,!],_9873,_9875) --> 
    cc('får',_9873,_9894),
    infinitive(_9895,_9894,_9875),
    !.

in_order_to([in_order_to,lit(for),_9895,!],_9873,_9875) --> 
    cc(for,_9873,_9894),
    infinitiveand(_9895,_9894,_9875),
    !.

in_order_to([in_order_to,lit('før'),_9895,!],_9873,_9875) --> 
    cc('før',_9873,_9894),
    infinitive(_9895,_9894,_9875),
    !.

in_order_to([in_order_to,_9884,_9913,!],_9873,_9875) --> 
    prep1(on,_9884,_9873,_9901),
    infinitive(_9913,_9901,_9875),
    !.

in_order_to([in_order_to,_9884,_9913,!],_9873,_9875) --> 
    prep1(with,_9884,_9873,_9901),
    infinitive(_9913,_9901,_9875),
    !.

in_order_to([in_order_to,_9884,_9913,!],_9873,_9875) --> 
    prep1(to,_9884,_9873,_9901),
    infinitiveand(_9913,_9901,_9875),
    !.

in_order_to([in_order_to,lit(av),_9895,!],_9873,_9875) --> 
    cc(av,_9873,_9894),
    infinitive(_9895,_9894,_9875),
    !.

in_order_to([in_order_to,lit(for),lit(og),!],_9875,_9877) --> 
    cc(for,_9875,_9896),
    cc(og,_9896,_9877),
    !.

in_order_to([in_order_to,lit('får'),lit('å'),!],_9875,_9877) --> 
    cc('får',_9875,_9896),
    cc('å',_9896,_9877),
    !.

in_order_to([in_order_to,lit('får'),lit(og),!],_9875,_9877) --> 
    cc('får',_9875,_9896),
    cc(og,_9896,_9877),
    !.

'forå'(['forå',lit(i),_9892],_9870,_9872) --> 
    cc(i,_9870,_9891),
    'ogå'(_9892,_9891,_9872).

'forå'(['forå',lit(med),_9892],_9870,_9872) --> 
    cc(med,_9870,_9891),
    'ogå'(_9892,_9891,_9872).

'forå'(['forå',lit(mot),_9892],_9870,_9872) --> 
    cc(mot,_9870,_9891),
    'ogå'(_9892,_9891,_9872).

'forå'(['forå',lit(for),_9892],_9870,_9872) --> 
    cc(for,_9870,_9891),
    'ogå'(_9892,_9891,_9872).

'forå'(['forå',lit(til),_9892],_9870,_9872) --> 
    cc(til,_9870,_9891),
    'ogå'(_9892,_9891,_9872).

'forå'(['forå',lit(over),_9892],_9870,_9872) --> 
    cc(over,_9870,_9891),
    'ogå'(_9892,_9891,_9872).

'forå'(['forå',lit('før'),lit('å')],_9872,_9874) --> 
    cc('før',_9872,_9893),
    cc('å',_9893,_9874).

'forå'(['forå',lit(ved),lit('å')],_9872,_9874) --> 
    cc(ved,_9872,_9893),
    cc('å',_9893,_9874).

'ogå'(['ogå',lit('å')],_9867,_9869) --> 
    cc('å',_9867,_9869).

'ogå'(['ogå',lit(og)],_9867,_9869) --> 
    cc(og,_9867,_9869).

infinitiveand([infinitiveand,lit('å')],_9867,_9869) --> 
    cc('å',_9867,_9869).

infinitiveand([infinitiveand,lit(og)],_9867,_9869) --> 
    cc(og,_9867,_9869).

infinitive([infinitive,lit('å'),_9906,_9930,!],_9884,_9886) --> 
    cc('å',_9884,_9905),
    faa(_9906,_9905,_9921),
    look_ahead(w(verb(_9865,_9866,_9867)),_9930,_9921,_9886),
    !.

infinitive([infinitive,lit('å')],_9867,_9869) --> 
    cc('å',_9867,_9869).

infinitive([infinitive,lit(til),lit('å')],_9872,_9874) --> 
    cc(til,_9872,_9893),
    cc('å',_9893,_9874).

inom(in,[inom,_9885],_9871,_9873) --> 
    prep1(in,_9885,_9871,_9873).

inom(om,[inom,lit(om)],_9871,_9873) --> 
    cc(om,_9871,_9873).

inom(om,[inom,_9885],_9871,_9873) --> 
    prep1(on,_9885,_9871,_9873).

instead_of([instead_of,lit(fremfor)],_9867,_9869) --> 
    cc(fremfor,_9867,_9869).

instead_of([instead_of,_9896,_9925,lit(for),!],_9885,_9887) --> 
    prep1(in,_9896,_9885,_9913),
    w(noun(place,sin,def,n),_9925,_9913,_9942),
    cc(for,_9942,_9887),
    !.

instead_of([instead_of,lit(istedenfor)],_9867,_9869) --> 
    cc(istedenfor,_9867,_9869).

instead_of([instead_of,lit(heller),lit(enn)],_9872,_9874) --> 
    cc(heller,_9872,_9893),
    cc(enn,_9893,_9874).

it0([it0,lit(det),_9899,!],_9877,_9879) --> 
    cc(det,_9877,_9898),
    not_look_ahead([vil],_9899,_9898,_9879),
    !.

it0([it0,[]],_9865,_9865) --> 
    [].

it([it,lit(den)],_9867,_9869) --> 
    cc(den,_9867,_9869).

its([its,lit(dens),_9892],_9870,_9872) --> 
    cc(dens,_9870,_9891),
    own0(_9892,_9891,_9872).

its([its,lit(dets),_9892],_9870,_9872) --> 
    cc(dets,_9870,_9891),
    own0(_9892,_9891,_9872).

later([later,lit(senere)],_9867,_9869) --> 
    cc(senere,_9867,_9869).

later([later,lit(siden),_9892],_9870,_9872) --> 
    cc(siden,_9870,_9891),
    not_look_ahead_np(_9892,_9891,_9872).

later([later,lit(deretter)],_9867,_9869) --> 
    cc(deretter,_9867,_9869).

latest([latest,_9881],_9870,_9872) --> 
    w(adj2(sup,late),_9881,_9870,_9872).

latest([latest,_9881],_9870,_9872) --> 
    w(adj2(last,nil),_9881,_9870,_9872).

less([less,lit('før')],_9867,_9869) --> 
    cc('før',_9867,_9869).

less([less,lit(tidligere)],_9867,_9869) --> 
    cc(tidligere,_9867,_9869).

less([less,lit(mindre)],_9867,_9869) --> 
    cc(mindre,_9867,_9869).

less([less,lit(lavere)],_9867,_9869) --> 
    cc(lavere,_9867,_9869).

let([let,_9882],_9871,_9873) --> 
    w(verb(let,pres,fin),_9882,_9871,_9873).

little([little,lit(lite)],_9867,_9869) --> 
    cc(lite,_9867,_9869).

long([long,_9881],_9870,_9872) --> 
    w(adj2(short,nil),_9881,_9870,_9872).

long([long,_9881],_9870,_9872) --> 
    w(adj2(long,nil),_9881,_9870,_9872).

longadj([longadj,_9881],_9870,_9872) --> 
    w(adj2(long,nil),_9881,_9870,_9872).

manypersons([manypersons,lit(mange),_9898,!,_9927],_9876,_9878) --> 
    cc(mange,_9876,_9897),
    adjnoun(_9898,_9897,_9913),
    !,
    reject(_9927,_9913,_9878).

manypersons([manypersons,lit(mange)],_9867,_9869) --> 
    cc(mange,_9867,_9869).

many1([many1,lit(mange),_9892],_9870,_9872) --> 
    cc(mange,_9870,_9891),
    off0(_9892,_9891,_9872).

many([many,_9884,lit(mange),_9919],_9873,_9875) --> 
    so0(_9884,_9873,_9899),
    cc(mange,_9899,_9918),
    off0(_9919,_9918,_9875).

meny([meny,lit(mange)],_9867,_9869) --> 
    cc(mange,_9867,_9869).

meny([meny,lit(meget)],_9867,_9869) --> 
    cc(meget,_9867,_9869).

meny([meny,lit(mye)],_9867,_9869) --> 
    cc(mye,_9867,_9869).

me0([me0,lit(jeg),!],_9870,_9872) --> 
    cc(jeg,_9870,_9872),
    !.

me0([me0,lit(meg),!],_9870,_9872) --> 
    cc(meg,_9870,_9872),
    !.

me0([me0,lit(oss),!],_9870,_9872) --> 
    cc(oss,_9870,_9872),
    !.

me0([me0,lit(seg),!],_9870,_9872) --> 
    cc(seg,_9870,_9872),
    !.

me0([me0,[]],_9865,_9865) --> 
    [].

mineyour0([mineyour0,_9881,!],_9870,_9872) --> 
    posspron(_9853,_9881,_9870,_9872),
    !.

mineyour0([mineyour0,[]],_9865,_9865) --> 
    [].

more([more,lit(mer)],_9867,_9869) --> 
    cc(mer,_9867,_9869).

more([more,lit(fler)],_9867,_9869) --> 
    cc(fler,_9867,_9869).

more([more,lit(flere)],_9867,_9869) --> 
    cc(flere,_9867,_9869).

most([most,lit(de),lit(fleste)],_9872,_9874) --> 
    cc(de,_9872,_9893),
    cc(fleste,_9893,_9874).

most([most,lit(flest)],_9867,_9869) --> 
    cc(flest,_9867,_9869).

much([much,lit(mye)],_9867,_9869) --> 
    cc(mye,_9867,_9869).

much([much,lit(meget)],_9867,_9869) --> 
    cc(meget,_9867,_9869).

my([my,lit(min)],_9867,_9869) --> 
    cc(min,_9867,_9869).

my([my,lit(mitt)],_9867,_9869) --> 
    cc(mitt,_9867,_9869).

my([my,lit(mine)],_9867,_9869) --> 
    cc(mine,_9867,_9869).

when10([when10,_9876],_9865,_9867) --> 
    when1(_9876,_9865,_9867).

when10([when10,[]],_9865,_9865) --> 
    [].

when1([when1,lit(da)],_9867,_9869) --> 
    cc(da,_9867,_9869).

when1([when1,lit('når')],_9867,_9869) --> 
    cc('når',_9867,_9869).

when1([when1,lit(n),{},!],_9878,_9880) --> 
    cc(n,_9878,_9880),
    {user:value(smsflag,true)},
    !.

when1([when1,lit(tid),_9896],_9874,_9876) --> 
    cc(tid,_9874,_9895),
    look_ahead(['går'],_9896,_9895,_9876).

negation2(only,only,[negation2,[],!],_9875,_9875) --> 
    [],
    !.

negation2(id,only,[negation2,_9891],_9874,_9876) --> 
    negation(only,_9891,_9874,_9876).

negation2(id,only,[negation2,_9891],_9874,_9876) --> 
    negation(only,_9891,_9874,_9876).

negation2(not,id,[negation2,_9891],_9874,_9876) --> 
    negation(only,_9891,_9874,_9876).

negation2(not,id,[negation2,_9897,!,_9931],_9880,_9882) --> 
    negation(not,_9897,_9880,_9914),
    !,
    reject(_9931,_9914,_9882).

negation2(not,not,[negation2,_9891],_9874,_9876) --> 
    negation0(id,_9891,_9874,_9876).

negation2(id,_9851,[negation2,_9891],_9874,_9876) --> 
    negation0(_9851,_9891,_9874,_9876).

negation2(often,often,[negation2,[]],_9872,_9872) --> 
    [].

negation0(_9850,[negation0,{},!],_9882,_9882) --> 
    {user:(nonvar(_9850),_9850==not)},
    !.

negation0(_9850,[negation0,_9888,!],_9874,_9876) --> 
    negation(_9850,_9888,_9874,_9876),
    !.

negation0(id,[negation0,[]],_9869,_9869) --> 
    [].

negation(id,[negation,_9891,lit(bare),!],_9877,_9879) --> 
    not(_9891,_9877,_9906),
    cc(bare,_9906,_9879),
    !.

negation(not,[negation,lit(bare),_9899],_9874,_9876) --> 
    cc(bare,_9874,_9898),
    not(_9899,_9898,_9876).

negation(not,[negation,_9883],_9869,_9871) --> 
    not(_9883,_9869,_9871).

negation(only,[negation,lit(bare)],_9871,_9873) --> 
    cc(bare,_9871,_9873).

negation(atleast,[negation,lit(minst)],_9871,_9873) --> 
    cc(minst,_9871,_9873).

negation(often,[negation,lit(ofte)],_9871,_9873) --> 
    cc(ofte,_9871,_9873).

negatino([negatino,lit(ikke),!],_9870,_9872) --> 
    cc(ikke,_9870,_9872),
    !.

negatino([negatino,lit(ingen),!],_9870,_9872) --> 
    cc(ingen,_9870,_9872),
    !.

negatino([negatino,[]],_9865,_9865) --> 
    [].

near([near,_9881],_9870,_9872) --> 
    w(adj2(near,nil),_9881,_9870,_9872).

near([near,_9884,_9908],_9873,_9875) --> 
    the0(_9884,_9873,_9899),
    w(adj2(nearest,nil),_9908,_9899,_9875).

nearest([nearest,_9881],_9870,_9872) --> 
    w(adj2(near,sup),_9881,_9870,_9872).

nearest([nearest,_9881],_9870,_9872) --> 
    w(adj2(nearest,nil),_9881,_9870,_9872).

nearest([nearest,_9878],_9867,_9869) --> 
    prep1(nearest,_9878,_9867,_9869).

nest([nest,lit(nest)],_9867,_9869) --> 
    cc(nest,_9867,_9869).

nest([nest,_9881],_9870,_9872) --> 
    w(adj2(next,nil),_9881,_9870,_9872).

next0([next0,_9879,!],_9868,_9870) --> 
    next(_9879,_9868,_9870),
    !.

next0([next0,[]],_9865,_9865) --> 
    [].

next([next,_9881],_9870,_9872) --> 
    w(adj2(next,nil),_9881,_9870,_9872).

no([no,lit(ingen),_9892],_9870,_9872) --> 
    cc(ingen,_9870,_9891),
    look_ahead_np(_9892,_9891,_9872).

notall([notall,lit(ikke),lit(alle)],_9872,_9874) --> 
    cc(ikke,_9872,_9893),
    cc(alle,_9893,_9874).

not0([not0,_9879,!],_9868,_9870) --> 
    not(_9879,_9868,_9870),
    !.

not0([not0,[]],_9865,_9865) --> 
    [].

not([not,lit(ikke)],_9867,_9869) --> 
    cc(ikke,_9867,_9869).

not([not,lit(intet),_9892],_9870,_9872) --> 
    cc(intet,_9870,_9891),
    look_ahead_np(_9892,_9891,_9872).

notwithstanding([notwithstanding,lit(selv_om)],_9867,_9869) --> 
    cc(selv_om,_9867,_9869).

notwithstanding([notwithstanding,lit(selv),lit(om)],_9872,_9874) --> 
    cc(selv,_9872,_9893),
    cc(om,_9893,_9874).

now0([now0,_9879,!],_9868,_9870) --> 
    now1(_9879,_9868,_9870),
    !.

now0([now0,_9876],_9865,_9867) --> 
    today(_9876,_9865,_9867).

now0([now0,[]],_9865,_9865) --> 
    [].

now1([now1,lit('ennå')],_9867,_9869) --> 
    cc('ennå',_9867,_9869).

now1([now1,lit('nå')],_9867,_9869) --> 
    cc('nå',_9867,_9869).

now1([now1,lit(no)],_9867,_9869) --> 
    cc(no,_9867,_9869).

nowon([nowon,_9884,lit(av),!],_9873,_9875) --> 
    now1(_9884,_9873,_9899),
    cc(av,_9899,_9875),
    !.

nowon([nowon,_9876],_9865,_9867) --> 
    now1(_9876,_9865,_9867).

nr0([nr0,_9879,!],_9868,_9870) --> 
    nr1(_9879,_9868,_9870),
    !.

nr0([nr0,[]],_9865,_9865) --> 
    [].

nr1([nr1,lit(nr),_9895,!],_9873,_9875) --> 
    cc(nr,_9873,_9894),
    point0(_9895,_9894,_9875),
    !.

nr1([nr1,lit(n),_9895,!],_9873,_9875) --> 
    cc(n,_9873,_9894),
    point0(_9895,_9894,_9875),
    !.

nr1([nr1,_9882,_9906,!],_9871,_9873) --> 
    number1(_9882,_9871,_9897),
    point0(_9906,_9897,_9873),
    !.

number0([number0,_9881,!],_9870,_9872) --> 
    num(_9853,_9881,_9870,_9872),
    !.

number0([number0,[]],_9865,_9865) --> 
    [].

number1([number1,_9886,_9915],_9875,_9877) --> 
    w(noun(number,sin,_9857,n),_9886,_9875,_9903),
    colon0(_9915,_9903,_9877).

of_course0([of_course0,_9876],_9865,_9867) --> 
    of_course(_9876,_9865,_9867).

of_course0([of_course0,_9884],_9873,_9875) --> 
    not_look_ahead(w(verb(_9854,_9855,_9856)),_9884,_9873,_9875).

of_coursenot0([of_coursenot0,_9881,lit(ikke)],_9870,_9872) --> 
    of_course(_9881,_9870,_9896),
    cc(ikke,_9896,_9872).

of_coursenot0([of_coursenot0,_9884],_9873,_9875) --> 
    not_look_ahead(w(verb(_9854,_9855,_9856)),_9884,_9873,_9875).

of_course([of_course,lit(naturligvis)],_9867,_9869) --> 
    cc(naturligvis,_9867,_9869).

of_course([of_course,lit('selvfølgelig')],_9867,_9869) --> 
    cc('selvfølgelig',_9867,_9869).

of_course([of_course,lit(det),_9898],_9876,_9878) --> 
    cc(det,_9876,_9897),
    w(verb(agree,pres,fin),_9898,_9897,_9878).

of0([of0,_9879,!],_9868,_9870) --> 
    of(_9879,_9868,_9870),
    !.

of0([of0,[]],_9865,_9865) --> 
    [].

of([of,_9878],_9867,_9869) --> 
    prep(of,_9878,_9867,_9869).

of([of,_9878],_9867,_9869) --> 
    prep1(to,_9878,_9867,_9869).

off0([off0,lit(av),!],_9870,_9872) --> 
    cc(av,_9870,_9872),
    !.

off0([off0,[]],_9865,_9865) --> 
    [].

offrom([offrom,lit(av)],_9867,_9869) --> 
    cc(av,_9867,_9869).

offrom([offrom,_9878],_9867,_9869) --> 
    prep1(from,_9878,_9867,_9869).

offrom([offrom,lit(ifra)],_9867,_9869) --> 
    cc(ifra,_9867,_9869).

often([often,_9881],_9870,_9872) --> 
    w(adj2(often,nil),_9881,_9870,_9872).

often([often,lit(ofte)],_9867,_9869) --> 
    cc(ofte,_9867,_9869).

often([often,lit(sjelden)],_9867,_9869) --> 
    cc(sjelden,_9867,_9869).

often([often,lit(jevnlig)],_9867,_9869) --> 
    cc(jevnlig,_9867,_9869).

ofthe([ofthe,_9879,_9903],_9868,_9870) --> 
    of(_9879,_9868,_9894),
    the(_9903,_9894,_9870).

ofthe0([ofthe0,_9876],_9865,_9867) --> 
    ofthe(_9876,_9865,_9867).

ofthe0([ofthe0,[]],_9865,_9865) --> 
    [].

older([older,lit(eldre)],_9867,_9869) --> 
    cc(eldre,_9867,_9869).

on0([on0,_9881,!],_9870,_9872) --> 
    prep1(on,_9881,_9870,_9872),
    !.

on0([on0,[]],_9865,_9865) --> 
    [].

newyear([newyear,_9891,_9920],_9880,_9882) --> 
    w(adj2(new,nil),_9891,_9880,_9908),
    w(noun(year,_9856,_9857,_9858),_9920,_9908,_9882).

newyear([newyear,lit('nyttår')],_9867,_9869) --> 
    cc('nyttår',_9867,_9869).

om0([om0,lit(om),!],_9870,_9872) --> 
    cc(om,_9870,_9872),
    !.

om0([om0,[]],_9865,_9865) --> 
    [].

on0([on0,lit('på'),!],_9870,_9872) --> 
    cc('på',_9870,_9872),
    !.

on0([on0,[]],_9865,_9865) --> 
    [].

one([one,_9881],_9870,_9872) --> 
    w(nb(1,num),_9881,_9870,_9872).

one([one,_9876],_9865,_9867) --> 
    a(_9876,_9865,_9867).

only0([only0,lit(bare),!],_9870,_9872) --> 
    cc(bare,_9870,_9872),
    !.

only0([only0,lit(hele),!],_9870,_9872) --> 
    cc(hele,_9870,_9872),
    !.

only0([only0,lit(nesten),!],_9870,_9872) --> 
    cc(nesten,_9870,_9872),
    !.

only0([only0,[]],_9865,_9865) --> 
    [].

or1([or1,lit(eller)],_9867,_9869) --> 
    cc(eller,_9867,_9869).

ordinal(_9850,[ordinal,_9888],_9874,_9876) --> 
    w(nb(_9850,ord),_9888,_9874,_9876).

oter([oter,_9876],_9865,_9867) --> 
    other(_9876,_9865,_9867).

oter([oter,_9876],_9865,_9867) --> 
    others(_9876,_9865,_9867).

other([other,lit(annen)],_9867,_9869) --> 
    cc(annen,_9867,_9869).

other([other,lit(annet)],_9867,_9869) --> 
    cc(annet,_9867,_9869).

others([others,lit(andre)],_9867,_9869) --> 
    cc(andre,_9867,_9869).

own0([own0,lit(egen)],_9867,_9869) --> 
    cc(egen,_9867,_9869).

own0([own0,lit(egne)],_9867,_9869) --> 
    cc(egne,_9867,_9869).

own0([own0,[]],_9865,_9865) --> 
    [].

possible0([possible0,_9884,!],_9873,_9875) --> 
    w(adj2(possible,nil),_9884,_9873,_9875),
    !.

possible0([possible0,[]],_9865,_9865) --> 
    [].

reflexiv0(_9850,[reflexiv0,_9891,!,_9925],_9877,_9879) --> 
    reflexiv(_9850,_9891,_9877,_9908),
    !,
    accept(_9925,_9908,_9879).

reflexiv0(_9850,[reflexiv0,{},!,_9909],_9880,_9882) --> 
    {user:verbtype(_9850,dtv)},
    !,
    accept(_9909,_9880,_9882).

reflexiv0(_9850,[reflexiv0,[]],_9869,_9869) --> 
    [].

reflexiv(ask,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(befind,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(beworry,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(buy,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(change,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(come,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(cost,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(decide,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(feel,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(fit,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(find,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(give,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(go,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(have,[reflexiv,lit(meg)],_9871,_9873) --> 
    cc(meg,_9871,_9873).

reflexiv(have,[reflexiv,lit(seg)],_9871,_9873) --> 
    cc(seg,_9871,_9873).

reflexiv(hurry,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(learn,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(move,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(pass,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(pay2,[reflexiv,lit(seg)],_9871,_9873) --> 
    cc(seg,_9871,_9873).

reflexiv(promise,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(get,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(get,[reflexiv,lit(med)],_9871,_9873) --> 
    cc(med,_9871,_9873).

reflexiv(receive,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(receive,[reflexiv,lit(med)],_9871,_9873) --> 
    cc(med,_9871,_9873).

reflexiv(retire,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(run,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(say,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(send,[reflexiv,_9886,_9910],_9872,_9874) --> 
    to0(_9886,_9872,_9901),
    rfxpron(_9910,_9901,_9874).

reflexiv(show,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(sneak,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(take,[reflexiv,lit(med),_9899],_9874,_9876) --> 
    cc(med,_9874,_9898),
    rfxpron(_9899,_9898,_9876).

reflexiv(take,[reflexiv,lit(med)],_9871,_9873) --> 
    cc(med,_9871,_9873).

reflexiv(take,[reflexiv,_9890,_9919],_9876,_9878) --> 
    not_look_ahead([dere],_9890,_9876,_9907),
    rfxpron(_9919,_9907,_9878).

reflexiv(tell,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(think,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(turn,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(want,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(wish,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(worry,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

reflexiv(write,[reflexiv,_9883],_9869,_9871) --> 
    rfxpron(_9883,_9869,_9871).

rfxpron0([rfxpron0,_9879,!],_9868,_9870) --> 
    rfxpron(_9879,_9868,_9870),
    !.

rfxpron0([rfxpron0,[]],_9865,_9865) --> 
    [].

rfxpron([rfxpron,lit(meg)],_9867,_9869) --> 
    cc(meg,_9867,_9869).

rfxpron([rfxpron,lit(deg)],_9867,_9869) --> 
    cc(deg,_9867,_9869).

rfxpron([rfxpron,lit(seg)],_9867,_9869) --> 
    cc(seg,_9867,_9869).

rfxpron([rfxpron,lit(oss)],_9867,_9869) --> 
    cc(oss,_9867,_9869).

rfxpron([rfxpron,lit(dere)],_9867,_9869) --> 
    cc(dere,_9867,_9869).

rfxpron([rfxpron,lit(selv),_9896],_9874,_9876) --> 
    cc(selv,_9874,_9895),
    not_look_ahead([om],_9896,_9895,_9876).

compassly([compassly,lit(nordfra)],_9867,_9869) --> 
    cc(nordfra,_9867,_9869).

compassly([compassly,lit(nordover)],_9867,_9869) --> 
    cc(nordover,_9867,_9869).

compassly([compassly,lit(sydfra)],_9867,_9869) --> 
    cc(sydfra,_9867,_9869).

compassly([compassly,lit(sydover)],_9867,_9869) --> 
    cc(sydover,_9867,_9869).

compassly([compassly,lit('sørfra')],_9867,_9869) --> 
    cc('sørfra',_9867,_9869).

compassly([compassly,lit('sørover')],_9867,_9869) --> 
    cc('sørover',_9867,_9869).

compassly([compassly,lit(vestfra)],_9867,_9869) --> 
    cc(vestfra,_9867,_9869).

compassly([compassly,lit(vestover)],_9867,_9869) --> 
    cc(vestover,_9867,_9869).

compassly([compassly,lit('østfra')],_9867,_9869) --> 
    cc('østfra',_9867,_9869).

compassly([compassly,lit('østover')],_9867,_9869) --> 
    cc('østover',_9867,_9869).

redundant0x([redundant0x,lit('så')],_9867,_9869) --> 
    cc('så',_9867,_9869).

redundant0x([redundant0x,_9876],_9865,_9867) --> 
    redundants0(_9876,_9865,_9867).

redundant0([redundant0,_9879,!],_9868,_9870) --> 
    redundant(_9879,_9868,_9870),
    !.

redundant0([redundant0,[]],_9865,_9865) --> 
    [].

redundants0([redundants0,_9882,_9906,!],_9871,_9873) --> 
    redundant(_9882,_9871,_9897),
    redundants0(_9906,_9897,_9873),
    !.

redundants0([redundants0,[]],_9865,_9865) --> 
    [].

redundantsx0([redundantsx0,_9882,!,_9911],_9871,_9873) --> 
    redundant(_9882,_9871,_9897),
    !,
    redxxx0(_9911,_9897,_9873).

redundantsx0([redundantsx0,[]],_9865,_9865) --> 
    [].

redxxx0([redxxx0,lit(og),_9895,!],_9873,_9875) --> 
    cc(og,_9873,_9894),
    redundant(_9895,_9894,_9875),
    !.

redxxx0([redxxx0,[]],_9865,_9865) --> 
    [].

redundant([redundant,_9883,!],_9872,_9874) --> 
    w(adv(redundantly),_9883,_9872,_9874),
    !.

redundant([redundant,_9888,_9917],_9877,_9879) --> 
    prep1(in,_9888,_9877,_9905),
    w(noun(average,_9856,_9857,_9858),_9917,_9905,_9879).

redundant([redundant,_9883,lit(allverden)],_9872,_9874) --> 
    prep1(in,_9883,_9872,_9900),
    cc(allverden,_9900,_9874).

redundant([redundant,_9900,lit(det),_9940,_9969],_9889,_9891) --> 
    prep1(in,_9900,_9889,_9917),
    cc(det,_9917,_9939),
    w(adj2(whole,nil),_9940,_9939,_9957),
    w(verb(take,past,part),_9969,_9957,_9891).

redundant([redundant,_9883,lit(hvertfall)],_9872,_9874) --> 
    prep1(in,_9883,_9872,_9900),
    cc(hvertfall,_9900,_9874).

redundant([redundant,_9883,lit(gjen)],_9872,_9874) --> 
    prep1(in,_9883,_9872,_9900),
    cc(gjen,_9900,_9874).

redundant([redundant,_9888,_9917],_9877,_9879) --> 
    prep1(for,_9888,_9877,_9905),
    w(noun(time,sin,def,n),_9917,_9905,_9879).

redundant([redundant,_9897,_9926,_9950,!,_9984],_9886,_9888) --> 
    prep1(from,_9897,_9886,_9914),
    a(_9926,_9914,_9941),
    w(noun(place,sin,u,n),_9950,_9941,_9967),
    !,
    accept(_9984,_9967,_9888).

redundant([redundant,_9886,_9915],_9875,_9877) --> 
    prep1(on,_9886,_9875,_9903),
    w(adj2(new,nil),_9915,_9903,_9877).

redundant([redundant,_9893,lit(en),_9933],_9882,_9884) --> 
    prep1(on,_9893,_9882,_9910),
    cc(en,_9910,_9932),
    w(noun(time_count,sin,u,n),_9933,_9932,_9884).

redundant([redundant,_9881,_9910],_9870,_9872) --> 
    prep1(to,_9881,_9870,_9898),
    slutt(_9910,_9898,_9872).

redundant([redundant,_9883,lit(sammen)],_9872,_9874) --> 
    prep1(to,_9883,_9872,_9900),
    cc(sammen,_9900,_9874).

redundant([redundant,_9898,_9927,_9956],_9887,_9889) --> 
    prep1(to,_9898,_9887,_9915),
    w(adj2(ordinary,nil),_9927,_9915,_9944),
    not_look_ahead(w(noun(time,_9861,_9862,_9863)),_9956,_9944,_9889).

redundant([redundant,_9876],_9865,_9867) --> 
    always(_9876,_9865,_9867).

redundant([redundant,_9876],_9865,_9867) --> 
    aspossible(_9876,_9865,_9867).

redundant([redundant,lit('altså'),_9898],_9876,_9878) --> 
    cc('altså',_9876,_9897),
    not_look_ahead_lit([at,'å'],_9898,_9897,_9878).

redundant([redundant,lit(bare)],_9867,_9869) --> 
    cc(bare,_9867,_9869).

redundant([redundant,lit(da),_9892],_9870,_9872) --> 
    cc(da,_9870,_9891),
    not_look_ahead_np(_9892,_9891,_9872).

redundant([redundant,lit(den),lit(gang)],_9872,_9874) --> 
    cc(den,_9872,_9893),
    cc(gang,_9893,_9874).

redundant([redundant,lit(derfra)],_9867,_9869) --> 
    cc(derfra,_9867,_9869).

redundant([redundant,lit(derfor)],_9867,_9869) --> 
    cc(derfor,_9867,_9869).

redundant([redundant,lit(alene)],_9867,_9869) --> 
    cc(alene,_9867,_9869).

redundant([redundant,lit(bort)],_9867,_9869) --> 
    cc(bort,_9867,_9869).

redundant([redundant,lit(dessverre)],_9867,_9869) --> 
    cc(dessverre,_9867,_9869).

redundant([redundant,lit(egentlig)],_9867,_9869) --> 
    cc(egentlig,_9867,_9869).

redundant([redundant,lit(ellers)],_9867,_9869) --> 
    cc(ellers,_9867,_9869).

redundant([redundant,lit(engang)],_9867,_9869) --> 
    cc(engang,_9867,_9869).

redundant([redundant,lit(enklest),lit(mulig)],_9872,_9874) --> 
    cc(enklest,_9872,_9893),
    cc(mulig,_9893,_9874).

redundant([redundant,lit(enklest)],_9867,_9869) --> 
    cc(enklest,_9867,_9869).

redundant([redundant,lit(ergo)],_9867,_9869) --> 
    cc(ergo,_9867,_9869).

redundant([redundant,lit(farefritt)],_9867,_9869) --> 
    cc(farefritt,_9867,_9869).

redundant([redundant,lit(faktisk)],_9867,_9869) --> 
    cc(faktisk,_9867,_9869).

redundant([redundant,lit('forøvrig')],_9867,_9869) --> 
    cc('forøvrig',_9867,_9869).

redundant([redundant,lit('forøvrig')],_9867,_9869) --> 
    cc('forøvrig',_9867,_9869).

redundant([redundant,lit(fram)],_9867,_9869) --> 
    cc(fram,_9867,_9869).

redundant([redundant,lit(gjerne)],_9867,_9869) --> 
    cc(gjerne,_9867,_9869).

redundant([redundant,lit(heller)],_9867,_9869) --> 
    cc(heller,_9867,_9869).

redundant([redundant,lit(helst)],_9867,_9869) --> 
    cc(helst,_9867,_9869).

redundant([redundant,lit(heldigvis)],_9867,_9869) --> 
    cc(heldigvis,_9867,_9869).

redundant([redundant,lit(herfra)],_9867,_9869) --> 
    cc(herfra,_9867,_9869).

redundant([redundant,lit(jo)],_9867,_9869) --> 
    cc(jo,_9867,_9869).

redundant([redundant,lit(jovisst)],_9867,_9869) --> 
    cc(jovisst,_9867,_9869).

redundant([redundant,lit(ikke),lit(sant)],_9872,_9874) --> 
    cc(ikke,_9872,_9893),
    cc(sant,_9893,_9874).

redundant([redundant,lit(ihvertfall)],_9867,_9869) --> 
    cc(ihvertfall,_9867,_9869).

redundant([redundant,lit(imens)],_9867,_9869) --> 
    cc(imens,_9867,_9869).

redundant([redundant,lit(inne)],_9867,_9869) --> 
    cc(inne,_9867,_9869).

redundant([redundant,lit(kanskje)],_9867,_9869) --> 
    cc(kanskje,_9867,_9869).

redundant([redundant,lit(langt),lit(bort)],_9872,_9874) --> 
    cc(langt,_9872,_9893),
    cc(bort,_9893,_9874).

redundant([redundant,lit(lenge)],_9867,_9869) --> 
    cc(lenge,_9867,_9869).

redundant([redundant,lit(likevel)],_9867,_9869) --> 
    cc(likevel,_9867,_9869).

redundant([redundant,lit(minst)],_9867,_9869) --> 
    cc(minst,_9867,_9869).

redundant([redundant,lit(mon),_9898],_9876,_9878) --> 
    cc(mon,_9876,_9897),
    w(verb(believe,imp,fin),_9898,_9897,_9878).

redundant([redundant,lit(normalt)],_9867,_9869) --> 
    cc(normalt,_9867,_9869).

redundant([redundant,lit('når'),lit(som),lit(helst)],_9877,_9879) --> 
    cc('når',_9877,_9898),
    cc(som,_9898,_9909),
    cc(helst,_9909,_9879).

redundant([redundant,lit('også')],_9867,_9869) --> 
    cc('også',_9867,_9869).

redundant([redundant,_9876],_9865,_9867) --> 
    sometimes(_9876,_9865,_9867).

redundant([redundant,lit(om),_9899],_9877,_9879) --> 
    cc(om,_9877,_9898),
    w(noun(time_count,sin,def,n),_9899,_9898,_9879).

redundant([redundant,lit(ad),_9899],_9877,_9879) --> 
    cc(ad,_9877,_9898),
    w(noun(time_count,sin,def,n),_9899,_9898,_9879).

redundant([redundant,lit(sikkert)],_9867,_9869) --> 
    cc(sikkert,_9867,_9869).

redundant([redundant,lit(straks)],_9867,_9869) --> 
    cc(straks,_9867,_9869).

redundant([redundant,lit(selvsagt)],_9867,_9869) --> 
    cc(selvsagt,_9867,_9869).

redundant([redundant,lit(totalt)],_9867,_9869) --> 
    cc(totalt,_9867,_9869).

redundant([redundant,lit(uansett)],_9867,_9869) --> 
    cc(uansett,_9867,_9869).

redundant([redundant,lit(vanligvis)],_9867,_9869) --> 
    cc(vanligvis,_9867,_9869).

redundant([redundant,lit(vel)],_9867,_9869) --> 
    cc(vel,_9867,_9869).

redundant([redundant,lit(videre)],_9867,_9869) --> 
    cc(videre,_9867,_9869).

slutt([slutt,lit(sist)],_9867,_9869) --> 
    cc(sist,_9867,_9869).

slutt([slutt,lit(slutt)],_9867,_9869) --> 
    cc(slutt,_9867,_9869).

please0([please0,_9882,!,_9911],_9871,_9873) --> 
    please(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

please0([please0,lit(bare),!,_9900],_9873,_9875) --> 
    cc(bare,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

please0([please0,[]],_9865,_9865) --> 
    [].

please([please,_9885,_9909,_9933,_9957],_9874,_9876) --> 
    be(_9885,_9874,_9900),
    so(_9909,_9900,_9924),
    good(_9933,_9924,_9948),
    infinitive(_9957,_9948,_9876).

please([please,lit(kan),_9911,_9935,_9959,_9983,lit('å')],_9889,_9891) --> 
    cc(kan,_9889,_9910),
    you(_9911,_9910,_9926),
    be(_9935,_9926,_9950),
    so0(_9959,_9950,_9974),
    w(adj2(good,nil),_9983,_9974,_10000),
    cc('å',_10000,_9891).

slashpoint0([slashpoint0,_9879,!],_9868,_9870) --> 
    slashpoint(_9879,_9868,_9870),
    !.

slashpoint0([slashpoint0,[]],_9865,_9865) --> 
    [].

slashpoint([slashpoint,lit(ende),!],_9870,_9872) --> 
    cc(ende,_9870,_9872),
    !.

slashpoint([slashpoint,lit(/),!],_9870,_9872) --> 
    cc(/,_9870,_9872),
    !.

slashpoint([slashpoint,lit(i),_9902,!],_9880,_9882) --> 
    cc(i,_9880,_9901),
    look_ahead(w(nb(_9862,_9863)),_9902,_9901,_9882),
    !.

slashpoint([slashpoint,lit('.'),lit(i),_9918,!],_9885,_9887) --> 
    cc('.',_9885,_9906),
    cc(i,_9906,_9917),
    look_ahead(w(nb(_9867,_9868)),_9918,_9917,_9887),
    !.

slashpoint([slashpoint,lit('.'),!],_9870,_9872) --> 
    cc('.',_9870,_9872),
    !.

slash([slash,lit(/)],_9867,_9869) --> 
    cc(/,_9867,_9869).

dashpoint0([dashpoint0,_9879,!],_9868,_9870) --> 
    dashpoint(_9879,_9868,_9870),
    !.

dashpoint0([dashpoint0,[]],_9865,_9865) --> 
    [].

dashpoint([dashpoint,lit(-)],_9867,_9869) --> 
    cc(-,_9867,_9869).

dashpoint([dashpoint,lit('.')],_9867,_9869) --> 
    cc('.',_9867,_9869).

point0([point0,_9882,!,_9911],_9871,_9873) --> 
    point(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

point0([point0,[]],_9865,_9865) --> 
    [].

pointNO([pointNO,_9882,!,_9911],_9871,_9873) --> 
    point(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

pointNO([pointNO,{}],_9870,_9870) --> 
    {user:value(nodotflag,true)}.

point([point,lit('.')],_9867,_9869) --> 
    cc('.',_9867,_9869).

itrailer([itrailer,lit(n)],_9867,_9869) --> 
    cc(n,_9867,_9869).

itrailer([itrailer,_9885,lit('når')],_9874,_9876) --> 
    not_look_ahead([n],_9885,_9874,_9902),
    cc('når',_9902,_9876).

itrailer([itrailer,_9888,_9917],_9877,_9879) --> 
    not_look_ahead([n],_9888,_9877,_9905),
    w(adj2(next,nil),_9917,_9905,_9879).

itrailer([itrailer,lit(takk)],_9867,_9869) --> 
    cc(takk,_9867,_9869).

qtrailer0([qtrailer0,lit(?),_9895,!],_9873,_9875) --> 
    cc(?,_9873,_9894),
    qtrailer(_9895,_9894,_9875),
    !.

qtrailer0([qtrailer0,lit('.'),_9895,!],_9873,_9875) --> 
    cc('.',_9873,_9894),
    qtrailer(_9895,_9894,_9875),
    !.

qtrailer0([qtrailer0,lit(a),_9895,!],_9873,_9875) --> 
    cc(a,_9873,_9894),
    qtrailer(_9895,_9894,_9875),
    !.

qtrailer0([qtrailer0,_9879,!],_9868,_9870) --> 
    qtrailer(_9879,_9868,_9870),
    !.

qtrailer0([qtrailer0,[]],_9865,_9865) --> 
    [].

qtrailer([qtrailer,lit(a)],_9867,_9869) --> 
    cc(a,_9867,_9869).

qtrailer([qtrailer,lit(takk)],_9867,_9869) --> 
    cc(takk,_9867,_9869).

qtrailer([qtrailer,_9884,lit(du),_9919],_9873,_9875) --> 
    be(_9884,_9873,_9899),
    cc(du,_9899,_9918),
    good(_9919,_9918,_9875).

qtrailer([qtrailer,lit(ca)],_9867,_9869) --> 
    cc(ca,_9867,_9869).

qtrailer([qtrailer,lit(da)],_9867,_9869) --> 
    cc(da,_9867,_9869).

qtrailer([qtrailer,lit(eller),lit(ikke)],_9872,_9874) --> 
    cc(eller,_9872,_9893),
    cc(ikke,_9893,_9874).

qtrailer([qtrailer,lit(eller)],_9867,_9869) --> 
    cc(eller,_9867,_9869).

qtrailer([qtrailer,_9885,!],_9874,_9876) --> 
    w(name(hal,_9856,_9857),_9885,_9874,_9876),
    !.

qtrailer([qtrailer,_9896,_9940,!],_9885,_9887) --> 
    optional(w(adj2(great,nil)),_9896,_9885,_9928),
    w(noun(oracle,sin,u,n),_9940,_9928,_9887),
    !.

qtrailer([qtrailer,_9900,{},!],_9889,_9891) --> 
    w(noun(_9858,sin,u,n),_9900,_9889,_9891),
    {user:testmember(_9858,[program,oracle,boss])},
    !.

qtrailer([qtrailer,lit(og)],_9867,_9869) --> 
    cc(og,_9867,_9869).

qtrailer([qtrailer,lit(og),lit('når')],_9872,_9874) --> 
    cc(og,_9872,_9893),
    cc('når',_9893,_9874).

qtrailer([qtrailer,lit(lenger),!],_9870,_9872) --> 
    cc(lenger,_9870,_9872),
    !.

qtrailer([qtrailer,lit(lengre),!],_9870,_9872) --> 
    cc(lengre,_9870,_9872),
    !.

qtrailer([qtrailer,lit('så'),_9914,lit(du),_9954,!],_9892,_9894) --> 
    cc('så',_9892,_9913),
    w(verb(be,_9867,_9868),_9914,_9913,_9931),
    cc(du,_9931,_9953),
    w(adj2(nice,nil),_9954,_9953,_9894),
    !.

qtrailer([qtrailer,_9882],_9871,_9873) --> 
    w(verb(believe,inf,fin),_9882,_9871,_9873).

qtrailer([qtrailer,_9887,lit(du)],_9876,_9878) --> 
    w(verb(believe,pres,fin),_9887,_9876,_9904),
    cc(du,_9904,_9878).

qtrailer([qtrailer,lit('ø')],_9867,_9869) --> 
    cc('ø',_9867,_9869).

qtrailer([qtrailer,_9885,lit('når')],_9874,_9876) --> 
    not_look_ahead([n],_9885,_9874,_9902),
    cc('når',_9902,_9876).

qtrailer([qtrailer,lit(din),_9909,_9953],_9887,_9889) --> 
    cc(din,_9887,_9908),
    optional(w(adj2(_9869,nil)),_9909,_9908,_9941),
    w(noun(_9858,sin,_9860,_9861),_9953,_9941,_9889).

qtrailer([qtrailer,_9897,{},!],_9886,_9888) --> 
    w(name(_9858,_9859,_9860),_9897,_9886,_9888),
    {user:testmember(_9860,[man,woman])},
    !.

qtrailer([qtrailer,lit(uansett)],_9867,_9869) --> 
    cc(uansett,_9867,_9869).

ctrailer0([ctrailer0,_9879,!],_9868,_9870) --> 
    ctrailer(_9879,_9868,_9870),
    !.

ctrailer0([ctrailer0,[]],_9865,_9865) --> 
    [].

ctrailer([ctrailer,_9876],_9865,_9867) --> 
    please(_9876,_9865,_9867).

ctrailer([ctrailer,lit(takk)],_9867,_9869) --> 
    cc(takk,_9867,_9869).

ctrailer([ctrailer,_9895,lit(du),_9935],_9884,_9886) --> 
    w(verb(be,pres,fin),_9895,_9884,_9912),
    cc(du,_9912,_9934),
    w(adj2(nice,nil),_9935,_9934,_9886).

ctrailer([ctrailer,lit(da)],_9867,_9869) --> 
    cc(da,_9867,_9869).

ctrailer([ctrailer,lit(din),_9909,_9953],_9887,_9889) --> 
    cc(din,_9887,_9908),
    optional(w(adj2(_9869,nil)),_9909,_9908,_9941),
    w(noun(_9858,sin,_9860,_9861),_9953,_9941,_9889).

dtrailer0([dtrailer0,{},_9899,!],_9878,_9880) --> 
    {user:(\+value(dialog,1))},
    dtrailer(_9899,_9878,_9880),
    !.

dtrailer0([dtrailer0,[]],_9865,_9865) --> 
    [].

dtrailer([dtrailer,_9882],_9871,_9873) --> 
    w(name(tore,n,firstname),_9882,_9871,_9873).

dtrailer([dtrailer,_9887,lit(jeg)],_9876,_9878) --> 
    w(verb(think,_9858,fin),_9887,_9876,_9904),
    cc(jeg,_9904,_9878).

dtrailer([dtrailer,_9887,lit(jeg)],_9876,_9878) --> 
    w(verb(mean,_9858,fin),_9887,_9876,_9904),
    cc(jeg,_9904,_9878).

dtrailer([dtrailer,_9882],_9871,_9873) --> 
    w(name(bustuc,_9853,_9854),_9882,_9871,_9873).

dtrailer([dtrailer,lit(ass)],_9867,_9869) --> 
    cc(ass,_9867,_9869).

dtrailer([dtrailer,lit(da)],_9867,_9869) --> 
    cc(da,_9867,_9869).

dtrailer([dtrailer,lit(din),_9909,_9953],_9887,_9889) --> 
    cc(din,_9887,_9908),
    optional(w(adj2(_9869,nil)),_9909,_9908,_9941),
    w(noun(fool,sin,u,n),_9953,_9941,_9889).

dtrailer([dtrailer,lit(du)],_9867,_9869) --> 
    cc(du,_9867,_9869).

dtrailer([dtrailer,lit(eller),lit(hva)],_9872,_9874) --> 
    cc(eller,_9872,_9893),
    cc(hva,_9893,_9874).

dtrailer([dtrailer,lit(eller)],_9867,_9869) --> 
    cc(eller,_9867,_9869).

dtrailer([dtrailer,lit(gitt)],_9867,_9869) --> 
    cc(gitt,_9867,_9869).

dtrailer([dtrailer,lit(hvordan)],_9867,_9869) --> 
    cc(hvordan,_9867,_9869).

dtrailer([dtrailer,lit(hei)],_9867,_9869) --> 
    cc(hei,_9867,_9869).

dtrailer([dtrailer,lit(ja)],_9867,_9869) --> 
    cc(ja,_9867,_9869).

dtrailer([dtrailer,lit(jeg)],_9867,_9869) --> 
    cc(jeg,_9867,_9869).

dtrailer([dtrailer,lit(men),lit('når')],_9872,_9874) --> 
    cc(men,_9872,_9893),
    cc('når',_9893,_9874).

dtrailer([dtrailer,lit(ok)],_9867,_9869) --> 
    cc(ok,_9867,_9869).

dtrailer([dtrailer,lit('sjø')],_9867,_9869) --> 
    cc('sjø',_9867,_9869).

dtrailer([dtrailer,lit(?),lit(takk)],_9872,_9874) --> 
    cc(?,_9872,_9893),
    cc(takk,_9893,_9874).

dtrailer([dtrailer,_9888,lit(hilsen),_9943],_9877,_9879) --> 
    optional([med],_9888,_9877,_9920),
    cc(hilsen,_9920,_9942),
    skip_rest(_9943,_9942,_9879).

posspron(self,[posspron,_9886,_9910],_9872,_9874) --> 
    my(_9886,_9872,_9901),
    own0(_9910,_9901,_9874).

posspron(man,[posspron,lit(hans),_9899],_9874,_9876) --> 
    cc(hans,_9874,_9898),
    own0(_9899,_9898,_9876).

posspron(woman,[posspron,lit(hennes),_9899],_9874,_9876) --> 
    cc(hennes,_9874,_9898),
    own0(_9899,_9898,_9876).

posspron(savant,[posspron,_9883],_9869,_9871) --> 
    your(_9883,_9869,_9871).

posspron(person,[posspron,_9886,_9910],_9872,_9874) --> 
    their(_9886,_9872,_9901),
    own0(_9910,_9901,_9874).

posspron(thing,[posspron,_9883],_9869,_9871) --> 
    sin(_9883,_9869,_9871).

previous([previous,_9881],_9870,_9872) --> 
    w(adj2(previous,nil),_9881,_9870,_9872).

thereafter([thereafter,_9879,_9903],_9868,_9870) --> 
    andor0(_9879,_9868,_9894),
    later(_9903,_9894,_9870).

thereafter([thereafter,_9883,lit(det)],_9872,_9874) --> 
    prep1(after,_9883,_9872,_9900),
    cc(det,_9900,_9874).

thereafter([thereafter,_9883,lit(dette)],_9872,_9874) --> 
    prep1(after,_9883,_9872,_9900),
    cc(dette,_9900,_9874).

thereafter([thereafter,_9883,lit(der)],_9872,_9874) --> 
    prep1(after,_9883,_9872,_9900),
    cc(der,_9900,_9874).

thereafter([thereafter,lit(nest),_9899,lit(der)],_9877,_9879) --> 
    cc(nest,_9877,_9898),
    prep1(after,_9899,_9898,_9916),
    cc(der,_9916,_9879).

thereafter([thereafter,_9883,lit(hvert)],_9872,_9874) --> 
    prep1(after,_9883,_9872,_9900),
    cc(hvert,_9900,_9874).

beforethat([beforethat,lit('derfør')],_9867,_9869) --> 
    cc('derfør',_9867,_9869).

beforethat([beforethat,_9879,_9903],_9868,_9870) --> 
    andor0(_9879,_9868,_9894),
    earlier(_9903,_9894,_9870).

beforethat([beforethat,_9883,lit(det)],_9872,_9874) --> 
    prep1(before,_9883,_9872,_9900),
    cc(det,_9900,_9874).

beforethat([beforethat,_9883,lit(dette)],_9872,_9874) --> 
    prep1(after,_9883,_9872,_9900),
    cc(dette,_9900,_9874).

beforethat([beforethat,_9883,lit(der)],_9872,_9874) --> 
    prep1(after,_9883,_9872,_9900),
    cc(der,_9900,_9874).

beforethat([beforethat,_9883,lit(dette)],_9872,_9874) --> 
    prep1(before,_9883,_9872,_9900),
    cc(dette,_9900,_9874).

beforethat([beforethat,lit(nest),_9899,lit(der)],_9877,_9879) --> 
    cc(nest,_9877,_9898),
    prep1(before,_9899,_9898,_9916),
    cc(der,_9916,_9879).

preperly([preperly,lit(en),lit(del)],_9872,_9874) --> 
    cc(en,_9872,_9893),
    cc(del,_9893,_9874).

preperly([preperly,lit(enda)],_9867,_9869) --> 
    cc(enda,_9867,_9869).

preperly([preperly,lit(ekte)],_9867,_9869) --> 
    cc(ekte,_9867,_9869).

preperly([preperly,lit(litt)],_9867,_9869) --> 
    cc(litt,_9867,_9869).

preperly([preperly,lit(noe)],_9867,_9869) --> 
    cc(noe,_9867,_9869).

preperly([preperly,lit(reellt)],_9867,_9869) --> 
    cc(reellt,_9867,_9869).

preperly([preperly,lit(strengt)],_9867,_9869) --> 
    cc(strengt,_9867,_9869).

preperly([preperly,lit(strikt)],_9867,_9869) --> 
    cc(strikt,_9867,_9869).

preperly([preperly,lit(virkelig)],_9867,_9869) --> 
    cc(virkelig,_9867,_9869).

prep2(after,[prep2,lit(avgang),_9905],_9880,_9882) --> 
    cc(avgang,_9880,_9904),
    not_look_ahead(w(prep(_9859)),_9905,_9904,_9882).

prep2(before,[prep2,lit(ankomst),_9905],_9880,_9882) --> 
    cc(ankomst,_9880,_9904),
    not_look_ahead(w(prep(_9859)),_9905,_9904,_9882).

prep2(after,[prep2,_9888,_9912],_9874,_9876) --> 
    preperly(_9888,_9874,_9903),
    prep1(after,_9912,_9903,_9876).

prep2(after,[prep2,_9896,_9920,lit(enn)],_9882,_9884) --> 
    preperly(_9896,_9882,_9911),
    w(adj2(later,nil),_9920,_9911,_9937),
    cc(enn,_9937,_9884).

prep2(before,[prep2,_9888,_9912],_9874,_9876) --> 
    preperly(_9888,_9874,_9903),
    prep1(before,_9912,_9903,_9876).

prep2(before,[prep2,_9896,_9920,lit(enn)],_9882,_9884) --> 
    preperly(_9896,_9882,_9911),
    w(adj2(earlier,nil),_9920,_9911,_9937),
    cc(enn,_9937,_9884).

prep2(according_to,[prep2,_9890,lit('følge')],_9876,_9878) --> 
    prep1(in,_9890,_9876,_9907),
    cc('følge',_9907,_9878).

prep2(after,[prep2,_9888,_9912],_9874,_9876) --> 
    clock(_9888,_9874,_9903),
    prep1(after,_9912,_9903,_9876).

prep2(after,[prep2,_9888,_9912],_9874,_9876) --> 
    around1(_9888,_9874,_9903),
    prep1(after,_9912,_9903,_9876).

prep2(after,[prep2,lit(ca),_9901],_9876,_9878) --> 
    cc(ca,_9876,_9900),
    prep1(after,_9901,_9900,_9878).

prep2(after,[prep2,_9888,_9917],_9874,_9876) --> 
    prep1(after,_9888,_9874,_9905),
    around1(_9917,_9905,_9876).

prep2(after,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(from,_9890,_9876,_9907),
    prep1(after,_9919,_9907,_9878).

prep2(after,[prep2,_9897,_9926,_9955],_9883,_9885) --> 
    prep1(to,_9897,_9883,_9914),
    not_look_ahead([e],_9926,_9914,_9943),
    prep1(after,_9955,_9943,_9885).

prep2(after,[prep2,_9895,lit(og),_9935],_9881,_9883) --> 
    prep1(from,_9895,_9881,_9912),
    cc(og,_9912,_9934),
    prep1(with,_9935,_9934,_9883).

prep2(after,[prep2,lit(like),_9901],_9876,_9878) --> 
    cc(like,_9876,_9900),
    prep1(after,_9901,_9900,_9878).

prep2(after,[prep2,_9888,_9912],_9874,_9876) --> 
    not(_9888,_9874,_9903),
    prep(before,_9912,_9903,_9876).

prep2(after,[prep2,lit(senere),lit(enn)],_9876,_9878) --> 
    cc(senere,_9876,_9900),
    cc(enn,_9900,_9878).

prep2(after,[prep2,lit(resten),_9901],_9876,_9878) --> 
    cc(resten,_9876,_9900),
    prep1(off,_9901,_9900,_9878).

prep2(around,[prep2,_9886,_9910],_9872,_9874) --> 
    around1(_9886,_9872,_9901),
    around0(_9910,_9901,_9874).

prep2(at,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(in,_9890,_9876,_9907),
    prep1(at,_9919,_9907,_9878).

prep2(at,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(on,_9890,_9876,_9907),
    prep1(at,_9919,_9907,_9878).

prep2(at,[prep2,_9900,_9929,lit(av)],_9886,_9888) --> 
    prep1(at,_9900,_9886,_9917),
    w(noun(side,_9865,_9866,_9867),_9929,_9917,_9946),
    cc(av,_9946,_9888).

prep2(before,[prep2,lit(for),_9906],_9881,_9883) --> 
    cc(for,_9881,_9905),
    look_ahead(w(nb(_9859,num)),_9906,_9905,_9883).

prep2(before,[prep2,_9898,_9927,!],_9884,_9886) --> 
    w(noun(arrival,sin,u,n),_9898,_9884,_9915),
    prep1(before,_9927,_9915,_9886),
    !.

prep2(before,[prep2,_9888,_9917],_9874,_9876) --> 
    prep1(before,_9888,_9874,_9905),
    ca(_9917,_9905,_9876).

prep2(before,[prep2,lit(like),_9901],_9876,_9878) --> 
    cc(like,_9876,_9900),
    prep1(before,_9901,_9900,_9878).

prep2(before,[prep2,_9888,_9912],_9874,_9876) --> 
    not(_9888,_9874,_9903),
    prep(after,_9912,_9903,_9876).

prep2(before,[prep2,lit(senest),_9901],_9876,_9878) --> 
    cc(senest,_9876,_9900),
    prep1(before,_9901,_9900,_9878).

prep2(before,[prep2,lit(senest)],_9871,_9873) --> 
    cc(senest,_9871,_9873).

prep2(before,[prep2,_9893,_9922],_9879,_9881) --> 
    w(adj2(present,nil),_9893,_9879,_9910),
    prep1(before,_9922,_9910,_9881).

prep2(before,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(to,_9890,_9876,_9907),
    prep1(before,_9919,_9907,_9878).

prep2(before,[prep2,_9890,lit(ca)],_9876,_9878) --> 
    prep1(to,_9890,_9876,_9907),
    cc(ca,_9907,_9878).

prep2(between,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(from,_9890,_9876,_9907),
    prep1(between,_9919,_9907,_9878).

prep2(between,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(in,_9890,_9876,_9907),
    prep1(between,_9919,_9907,_9878).

prep2(between,[prep2,_9898,_9922,_9951],_9884,_9886) --> 
    a0(_9898,_9884,_9913),
    w(noun(place,_9863,_9864,n),_9922,_9913,_9939),
    prep1(between,_9951,_9939,_9886).

prep2(during,[prep2,_9895,lit('løpet'),lit(av)],_9881,_9883) --> 
    prep1(in,_9895,_9881,_9912),
    cc('løpet',_9912,_9934),
    cc(av,_9934,_9883).

prep2(during2,[prep2,lit(om),_9899],_9874,_9876) --> 
    cc(om,_9874,_9898),
    ca(_9899,_9898,_9876).

prep2(from,[prep2,_9888,_9917],_9874,_9876) --> 
    prep1(from,_9888,_9874,_9905),
    colon0(_9917,_9905,_9876).

prep2(from,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(from,_9890,_9876,_9907),
    prep1(near,_9919,_9907,_9878).

prep2(from,[prep2,_9904,_9933,_9962,!,_9996],_9890,_9892) --> 
    prep1(from,_9904,_9890,_9921),
    w(adj2(up,nil),_9933,_9921,_9950),
    prep1(at,_9962,_9950,_9979),
    !,
    accept(_9996,_9979,_9892).

prep2(from,[prep2,_9896,_9925,!,_9959],_9882,_9884) --> 
    prep1(from,_9896,_9882,_9913),
    prep1(from,_9925,_9913,_9942),
    !,
    accept(_9959,_9942,_9884).

prep2(from,[prep2,lit(med),_9901],_9876,_9878) --> 
    cc(med,_9876,_9900),
    prep1(from,_9901,_9900,_9878).

prep2(from,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(in,_9890,_9876,_9907),
    prep1(from,_9919,_9907,_9878).

prep2(from,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(over,_9890,_9876,_9907),
    prep1(from,_9919,_9907,_9878).

prep2(from,[prep2,lit(ifra)],_9871,_9873) --> 
    cc(ifra,_9871,_9873).

prep2(from,[prep2,lit(inn),_9901],_9876,_9878) --> 
    cc(inn,_9876,_9900),
    prep1(from,_9901,_9900,_9878).

prep2(from,[prep2,lit(ut),_9899],_9874,_9876) --> 
    cc(ut,_9874,_9898),
    offrom(_9899,_9898,_9876).

prep2(from,[prep2,_9900,_9929,_9958],_9886,_9888) --> 
    prep1(with,_9900,_9886,_9917),
    w(noun(start,sin,_9866,_9867),_9929,_9917,_9946),
    prep1(in,_9958,_9946,_9888).

prep2(from,[prep2,_9888,_9912],_9874,_9876) --> 
    umpover(_9888,_9874,_9903),
    prep1(from,_9912,_9903,_9876).

prep2(from,[prep2,_9900,_9929,lit('nærheten'),lit(av)],_9886,_9888) --> 
    prep1(from,_9900,_9886,_9917),
    prep1(in,_9929,_9917,_9946),
    cc('nærheten',_9946,_9968),
    cc(av,_9968,_9888).

prep2(in,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(around,_9890,_9876,_9907),
    prep1(in,_9919,_9907,_9878).

prep2(in,[prep2,lit(inne),_9901],_9876,_9878) --> 
    cc(inne,_9876,_9900),
    prep1(in,_9901,_9900,_9878).

prep2(in,[prep2,lit(nede),_9901],_9876,_9878) --> 
    cc(nede,_9876,_9900),
    prep1(in,_9901,_9900,_9878).

prep2(instead_of,[prep2,lit(i),lit(stedet),lit(for)],_9881,_9883) --> 
    cc(i,_9881,_9905),
    cc(stedet,_9905,_9916),
    cc(for,_9916,_9883).

prep2(near,[prep2,_9891,_9915,_9944],_9877,_9879) --> 
    so0(_9891,_9877,_9906),
    prep1(near,_9915,_9906,_9932),
    to0(_9944,_9932,_9879).

prep2(near,[prep2,_9895,lit('nærheten'),lit(av)],_9881,_9883) --> 
    prep1(in,_9895,_9881,_9912),
    cc('nærheten',_9912,_9934),
    cc(av,_9934,_9883).

prep2(near,[prep2,lit(like),_9901],_9876,_9878) --> 
    cc(like,_9876,_9900),
    prep1(at,_9901,_9900,_9878).

prep2(near,[prep2,_9897,_9921,_9950,_9974],_9883,_9885) --> 
    and0(_9897,_9883,_9912),
    w(adj2(nearest,nil),_9921,_9912,_9938),
    possible0(_9950,_9938,_9965),
    to0(_9974,_9965,_9885).

prep2(near,[prep2,_9893,_9922],_9879,_9881) --> 
    w(adj2(near,nil),_9893,_9879,_9910),
    prep1(at,_9922,_9910,_9881).

prep2(near,[prep2,_9898,lit(eller),_9938],_9884,_9886) --> 
    prep1(to,_9898,_9884,_9915),
    cc(eller,_9915,_9937),
    w(adj2(near,nil),_9938,_9937,_9886).

prep2(near,[prep2,_9898,lit(eller),_9938],_9884,_9886) --> 
    prep1(past,_9898,_9884,_9915),
    cc(eller,_9915,_9937),
    w(adj2(near,nil),_9938,_9937,_9886).

prep2(on,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(in,_9890,_9876,_9907),
    prep1(on,_9919,_9907,_9878).

prep2(on,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(with,_9890,_9876,_9907),
    prep1(on,_9919,_9907,_9878).

prep2(on,[prep2,_9899,lit(midt),_9934,!,_9968],_9885,_9887) --> 
    ca0(_9899,_9885,_9914),
    cc(midt,_9914,_9933),
    prep1(on,_9934,_9933,_9951),
    !,
    accept(_9968,_9951,_9887).

prep2(on,[prep2,lit(nede),_9901],_9876,_9878) --> 
    cc(nede,_9876,_9900),
    prep1(on,_9901,_9900,_9878).

prep2(out_of,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(to,_9890,_9876,_9907),
    prep1(outside,_9919,_9907,_9878).

prep2(outside,[prep2,lit(ikke),_9901],_9876,_9878) --> 
    cc(ikke,_9876,_9900),
    prep1(past,_9901,_9900,_9878).

prep2(outside,[prep2,lit(ikke),_9901],_9876,_9878) --> 
    cc(ikke,_9876,_9900),
    prep1(to,_9901,_9900,_9878).

prep2(over,[prep2,lit(litt),_9901],_9876,_9878) --> 
    cc(litt,_9876,_9900),
    prep1(over,_9901,_9900,_9878).

prep2(over,[prep2,_9890,lit(hvilke)],_9876,_9878) --> 
    prep1(over,_9890,_9876,_9907),
    cc(hvilke,_9907,_9878).

prep2(past,[prep2,lit(og),lit(ned)],_9876,_9878) --> 
    cc(og,_9876,_9900),
    cc(ned,_9900,_9878).

prep2(past,[prep2,lit(og),_9901],_9876,_9878) --> 
    cc(og,_9876,_9900),
    prep1(past,_9901,_9900,_9878).

prep2(past,[prep2,lit(ned)],_9871,_9873) --> 
    cc(ned,_9871,_9873).

prep2(past,[prep2,_9905,lit(/),_9945,lit('nærheten'),lit(av)],_9891,_9893) --> 
    prep1(past,_9905,_9891,_9922),
    cc(/,_9922,_9944),
    prep1(in,_9945,_9944,_9962),
    cc('nærheten',_9962,_9984),
    cc(av,_9984,_9893).

prep2(past,[prep2,_9905,lit(eller),_9945,lit('nærheten'),lit(av)],_9891,_9893) --> 
    prep1(past,_9905,_9891,_9922),
    cc(eller,_9922,_9944),
    prep1(in,_9945,_9944,_9962),
    cc('nærheten',_9962,_9984),
    cc(av,_9984,_9893).

prep2(past,[prep2,_9901,lit(/),_9941,!,_9975],_9887,_9889) --> 
    prep1(to,_9901,_9887,_9918),
    cc(/,_9918,_9940),
    prep1(from,_9941,_9940,_9958),
    !,
    accept(_9975,_9958,_9889).

prep2(past,[prep2,_9899,_9928,_9952,!,_9986],_9885,_9887) --> 
    prep1(to,_9899,_9885,_9916),
    and0(_9928,_9916,_9943),
    prep1(from,_9952,_9943,_9969),
    !,
    accept(_9986,_9969,_9887).

prep2(past,[prep2,_9899,_9928,_9952,!,_9986],_9885,_9887) --> 
    prep1(from,_9899,_9885,_9916),
    and1(_9928,_9916,_9943),
    prep1(to,_9952,_9943,_9969),
    !,
    accept(_9986,_9969,_9887).

prep2(past,[prep2,_9895,_9924],_9881,_9883) --> 
    prep1(with,_9895,_9881,_9912),
    w(noun(departure,_9858,_9859,_9860),_9924,_9912,_9883).

prep2(past,[prep2,_9895,lit(/),_9935],_9881,_9883) --> 
    prep1(past,_9895,_9881,_9912),
    cc(/,_9912,_9934),
    prep1(past,_9935,_9934,_9883).

prep2(to,[prep2,_9888,_9917],_9874,_9876) --> 
    prep1(to,_9888,_9874,_9905),
    colon0(_9917,_9905,_9876).

prep2(to,[prep2,_9896,_9925,!,_9959],_9882,_9884) --> 
    prep1(to,_9896,_9882,_9913),
    prep1(to,_9925,_9913,_9942),
    !,
    accept(_9959,_9942,_9884).

prep2(to,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(to,_9890,_9876,_9907),
    prep1(near,_9919,_9907,_9878).

prep2(to,[prep2,_9900,_9929,_9958],_9886,_9888) --> 
    prep1(in,_9900,_9886,_9917),
    w(noun(connection,_9865,u,n),_9929,_9917,_9946),
    prep1(with,_9958,_9946,_9888).

prep2(to,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(over,_9890,_9876,_9907),
    prep1(to,_9919,_9907,_9878).

prep2(to,[prep2,_9895,_9924],_9881,_9883) --> 
    prep1(with,_9895,_9881,_9912),
    w(noun(arrival,_9858,_9859,_9860),_9924,_9912,_9883).

prep2(to,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(with,_9890,_9876,_9907),
    prep1(to,_9919,_9907,_9878).

prep2(to,[prep2,_9888,_9912],_9874,_9876) --> 
    andsoon(_9888,_9874,_9903),
    prep1(to,_9912,_9903,_9876).

prep2(to,[prep2,lit(hjem),_9901],_9876,_9878) --> 
    cc(hjem,_9876,_9900),
    prep1(to,_9901,_9900,_9878).

prep2(to,[prep2,lit(inn),_9901],_9876,_9878) --> 
    cc(inn,_9876,_9900),
    prep1(to,_9901,_9900,_9878).

prep2(to,[prep2,lit(ned),_9901],_9876,_9878) --> 
    cc(ned,_9876,_9900),
    prep1(to,_9901,_9900,_9878).

prep2(to,[prep2,lit(opp),_9901],_9876,_9878) --> 
    cc(opp,_9876,_9900),
    prep1(to,_9901,_9900,_9878).

prep2(to,[prep2,lit(tur),lit(retur)],_9876,_9878) --> 
    cc(tur,_9876,_9900),
    cc(retur,_9900,_9878).

prep2(to,[prep2,_9888,_9912],_9874,_9876) --> 
    umpover(_9888,_9874,_9903),
    prep1(to,_9912,_9903,_9876).

prep2(towards,[prep2,lit(inn),_9901],_9876,_9878) --> 
    cc(inn,_9876,_9900),
    prep1(towards,_9901,_9900,_9878).

prep2(towards,[prep2,lit(ut),_9901],_9876,_9878) --> 
    cc(ut,_9876,_9900),
    prep1(towards,_9901,_9900,_9878).

prep2(towards,[prep2,lit(ned),_9901],_9876,_9878) --> 
    cc(ned,_9876,_9900),
    prep1(towards,_9901,_9900,_9878).

prep2(towards,[prep2,_9888,_9912],_9874,_9876) --> 
    umpover(_9888,_9874,_9903),
    prep1(towards,_9912,_9903,_9876).

prep2(until,[prep2,_9883],_9869,_9871) --> 
    until(_9883,_9869,_9871).

prep2(with,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(with,_9890,_9876,_9907),
    prep1(on,_9919,_9907,_9878).

prep2(with,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(with,_9890,_9876,_9907),
    prep1(in,_9919,_9907,_9878).

prep2(with,[prep2,_9891,lit(bruk),_9926],_9877,_9879) --> 
    by(_9891,_9877,_9906),
    cc(bruk,_9906,_9925),
    of(_9926,_9925,_9879).

prep2(within,[prep2,_9890,_9919],_9876,_9878) --> 
    prep1(on,_9890,_9876,_9907),
    prep1(under,_9919,_9907,_9878).

prep2(without,[prep2,lit(fri),lit(for)],_9876,_9878) --> 
    cc(fri,_9876,_9900),
    cc(for,_9900,_9878).

umpover([umpover,lit(opp),_9894],_9872,_9874) --> 
    cc(opp,_9872,_9893),
    prep1(over,_9894,_9893,_9874).

umpover([umpover,lit(bort)],_9867,_9869) --> 
    cc(bort,_9867,_9869).

umpover([umpover,_9878],_9867,_9869) --> 
    prep1(over,_9878,_9867,_9869).

umpover([umpover,lit(bortover)],_9867,_9869) --> 
    cc(bortover,_9867,_9869).

umpover([umpover,lit(utover)],_9867,_9869) --> 
    cc(utover,_9867,_9869).

umpover([umpover,lit(innover)],_9867,_9869) --> 
    cc(innover,_9867,_9869).

umpover([umpover,lit(oppover)],_9867,_9869) --> 
    cc(oppover,_9867,_9869).

umpover([umpover,lit(nedover)],_9867,_9869) --> 
    cc(nedover,_9867,_9869).

umpover([umpover,lit(hitover)],_9867,_9869) --> 
    cc(hitover,_9867,_9869).

umpover([umpover,_9888,_9917],_9877,_9879) --> 
    prep1(on,_9888,_9877,_9905),
    w(noun(route,sin,_9857,n),_9917,_9905,_9879).

umpover([umpover,_9888,_9917],_9877,_9879) --> 
    prep1(on,_9888,_9877,_9905),
    w(noun(direction,sin,_9857,n),_9917,_9905,_9879).

pronoun1(_9850,[pronoun1,lit(de),!,_9907],_9877,_9879) --> 
    cc(de,_9877,_9901),
    !,
    reject(_9907,_9901,_9879).

pronoun1(_9850,[pronoun1,lit(en),!,_9907],_9877,_9879) --> 
    cc(en,_9877,_9901),
    !,
    reject(_9907,_9901,_9879).

pronoun1(_9850,[pronoun1,_9885],_9871,_9873) --> 
    pronoun(_9850,_9885,_9871,_9873).

pronoun(thing,[pronoun,_9898,_9927,!,_9956],_9884,_9886) --> 
    one_of_lit([noe,det],_9898,_9884,_9915),
    not_look_ahead_np(_9927,_9915,_9942),
    !,
    accept(_9956,_9942,_9886).

pronoun(thing,[pronoun,lit(det),_9927,_9951,_9980,!,_10014],_9902,_9904) --> 
    cc(det,_9902,_9926),
    look_ahead_vp(_9927,_9926,_9942),
    not_look_ahead(w(adj2(_9873,_9874)),_9951,_9942,_9968),
    not_look_ahead(w(noun(_9880,_9881,_9882,_9883)),_9980,_9968,_9997),
    !,
    accept(_10014,_9997,_9904).

pronoun(agent,[pronoun,lit(man)],_9871,_9873) --> 
    cc(man,_9871,_9873).

pronoun(self,[pronoun,lit(jeg),_9914,_9943],_9889,_9891) --> 
    cc(jeg,_9889,_9913),
    not_look_ahead(['.'],_9914,_9913,_9931),
    not_look_ahead(w(name(_9862,_9863,_9864)),_9943,_9931,_9891).

pronoun(self,[pronoun,lit(meg)],_9871,_9873) --> 
    cc(meg,_9871,_9873).

pronoun(vehicle,[pronoun,lit(den),_9907,{}],_9882,_9884) --> 
    cc(den,_9882,_9906),
    not_look_ahead_np(_9907,_9906,_9884),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(de),_9907,{}],_9882,_9884) --> 
    cc(de,_9882,_9906),
    not_look_ahead_np(_9907,_9906,_9884),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(_9860),{},_9932,!],_9897,_9899) --> 
    cc(_9860,_9897,_9921),
    {user:testmember(_9860,[den,det,en,et])},
    look_ahead([som],_9932,_9921,_9899),
    !.

pronoun(_9850,[pronoun,lit(_9864),{},_9927],_9892,_9894) --> 
    cc(_9864,_9892,_9916),
    {dict_n:pronoun(_9864,_9850)},
    not_look_ahead(w(nb(_9862,_9863)),_9927,_9916,_9894).

pronoun(thing,[pronoun,lit(dette),_9924,_9953,!,_9987],_9899,_9901) --> 
    cc(dette,_9899,_9923),
    not_look_ahead(w(adj2(_9870,_9871)),_9924,_9923,_9941),
    not_look_ahead(w(noun(_9877,_9878,_9879,_9880)),_9953,_9941,_9970),
    !,
    accept(_9987,_9970,_9901).

pronoun(thing,[pronoun,lit(denne),_9905,!,_9934],_9880,_9882) --> 
    cc(denne,_9880,_9904),
    not_look_ahead_np(_9905,_9904,_9920),
    !,
    accept(_9934,_9920,_9882).

pronoun(agent,[pronoun,lit(vi)],_9871,_9873) --> 
    cc(vi,_9871,_9873).

pronoun(savant,[pronoun,lit(du)],_9871,_9873) --> 
    cc(du,_9871,_9873).

pronoun(agent,[pronoun,lit(dere)],_9871,_9873) --> 
    cc(dere,_9871,_9873).

quant_pron(some,person,[quant_pron,lit(en),_9916,!],_9888,_9890) --> 
    cc(en,_9888,_9915),
    look_ahead(w(verb(_9865,_9866,_9867)),_9916,_9915,_9890),
    !.

quant_pron(some,thing,[quant_pron,lit(mye),_9908,!],_9880,_9882) --> 
    cc(mye,_9880,_9907),
    not_look_ahead_np(_9908,_9907,_9882),
    !.

quant_pron(every,person,[quant_pron,_9901,lit(alle),_9941],_9884,_9886) --> 
    not_look_ahead([hver],_9901,_9884,_9918),
    cc(alle,_9918,_9940),
    not_look_ahead_np(_9941,_9940,_9886).

quant_pron(every,thing,[quant_pron,_9905,lit(alt),_9945],_9888,_9890) --> 
    not_look_ahead(w(name(_9863,_9864,_9865)),_9905,_9888,_9922),
    cc(alt,_9922,_9944),
    sammen0(_9945,_9944,_9890).

quant_pron(some,person,[quant_pron,lit(den),_9912,!],_9884,_9886) --> 
    cc(den,_9884,_9911),
    look_ahead([som],_9912,_9911,_9886),
    !.

quant_pron(some,thing,[quant_pron,lit(det),_9912,!],_9884,_9886) --> 
    cc(det,_9884,_9911),
    look_ahead([som],_9912,_9911,_9886),
    !.

quant_pron(some,person,[quant_pron,lit(man)],_9874,_9876) --> 
    cc(man,_9874,_9876).

quant_pron(some,thing,[quant_pron,lit(mer),_9909],_9881,_9883) --> 
    cc(mer,_9881,_9908),
    not_look_ahead([enn],_9909,_9908,_9883).

quant_pron(some,thing,[quant_pron,lit(noe)],_9874,_9876) --> 
    cc(noe,_9874,_9876).

quant_pron(some,agent,[quant_pron,lit(noen),_9915,_9939],_9887,_9889) --> 
    cc(noen,_9887,_9914),
    avdem0(_9915,_9914,_9930),
    not_look_ahead(w(adj(_9863,_9864)),_9939,_9930,_9889).

avdem0([avdem0,lit(av),lit('våre'),!,_9916],_9878,_9880) --> 
    cc(av,_9878,_9899),
    cc('våre',_9899,_9910),
    !,
    reject(_9916,_9910,_9880).

avdem0([avdem0,lit(av),lit(dem),!],_9875,_9877) --> 
    cc(av,_9875,_9896),
    cc(dem,_9896,_9877),
    !.

avdem0([avdem0,[]],_9865,_9865) --> 
    [].

quant_pron(some,vehicle,[quant_pron,lit(noen),_9909],_9881,_9883) --> 
    cc(noen,_9881,_9908),
    not_look_ahead([av],_9909,_9908,_9883).

quant_pron(some,agent,[quant_pron,_9889],_9872,_9874) --> 
    someone(_9889,_9872,_9874).

quant_pron(some,thing,[quant_pron,_9900,_9924],_9883,_9885) --> 
    something(_9900,_9883,_9915),
    not_look_ahead(w(verb(_9860,_9861,pass)),_9924,_9915,_9885).

quant_pron(no,person,[quant_pron,lit(ingen),_9905],_9877,_9879) --> 
    cc(ingen,_9877,_9904),
    not_look_ahead_np(_9905,_9904,_9879).

quant_pron(no,thing,[quant_pron,lit(intet),_9914],_9886,_9888) --> 
    cc(intet,_9886,_9913),
    not_look_ahead(w(noun(_9860,_9861,_9862,_9863)),_9914,_9913,_9888).

quant_pron(no,thing,[quant_pron,lit(ingen),lit(ting)],_9879,_9881) --> 
    cc(ingen,_9879,_9906),
    cc(ting,_9906,_9881).

quant_pron(no,thing,[quant_pron,lit(ingenting)],_9874,_9876) --> 
    cc(ingenting,_9874,_9876).

quant_pron(much,thing,[quant_pron,_9899,_9923],_9882,_9884) --> 
    somuch(_9899,_9882,_9914),
    not_look_ahead(w(adj2(_9860,nil)),_9923,_9914,_9884).

quant_pron(little,thing,[quant_pron,_9915,_9944,_9968,_9997],_9898,_9900) --> 
    not_look_ahead(w(adv(_9873)),_9915,_9898,_9932),
    solittle(_9944,_9932,_9959),
    not_look_ahead(['å'],_9968,_9959,_9985),
    not_look_ahead(w(adj2(late,nil)),_9997,_9985,_9900).

quant_pron(some,feeling,[quant_pron,_9889],_9872,_9874) --> 
    somegood(_9889,_9872,_9874).

denbussen([denbussen,lit(den),_9903,!,_9937],_9881,_9883) --> 
    cc(den,_9881,_9902),
    w(adj2(_9863,nil),_9903,_9902,_9920),
    !,
    reject(_9937,_9920,_9883).

denbussen([denbussen,lit(den)],_9867,_9869) --> 
    cc(den,_9867,_9869).

sammen0([sammen0,lit(sammen),!],_9870,_9872) --> 
    cc(sammen,_9870,_9872),
    !.

sammen0([sammen0,_9884,!],_9873,_9875) --> 
    w(adj2(possible,nil),_9884,_9873,_9875),
    !.

sammen0([sammen0,[]],_9865,_9865) --> 
    [].

somuch([somuch,_9879,_9903],_9868,_9870) --> 
    so0(_9879,_9868,_9894),
    much(_9903,_9894,_9870).

solittle([solittle,_9879,_9903],_9868,_9870) --> 
    so0(_9879,_9868,_9894),
    little(_9903,_9894,_9870).

quant0(_9850,[quant0,_9891,!,_9925],_9877,_9879) --> 
    quant1(_9850,_9891,_9877,_9908),
    !,
    accept(_9925,_9908,_9879).

quant0(1,[quant0,[]],_9869,_9869) --> 
    [].

quant1(+(_9852),[quant1,_9890],_9876,_9878) --> 
    w(nb(_9852,num),_9890,_9876,_9878).

quant1(-(_9852),[quant1,_9887],_9873,_9875) --> 
    ordinal(_9852,_9887,_9873,_9875).

recently([recently,lit(nylig)],_9867,_9869) --> 
    cc(nylig,_9867,_9869).

recently([recently,_9886,lit(det),_9926],_9875,_9877) --> 
    prep1(in,_9886,_9875,_9903),
    cc(det,_9903,_9925),
    latest(_9926,_9925,_9877).

everything([everything,_9889,lit(alt)],_9878,_9880) --> 
    not_look_ahead(w(name(_9859,_9860,_9861)),_9889,_9878,_9906),
    cc(alt,_9906,_9880).

something([something,lit(noe),lit(mer),!,_9916],_9878,_9880) --> 
    cc(noe,_9878,_9899),
    cc(mer,_9899,_9910),
    !,
    accept(_9916,_9910,_9880).

something([something,lit(noe),lit(som),lit(helst),!,_9932],_9883,_9885) --> 
    cc(noe,_9883,_9904),
    cc(som,_9904,_9915),
    cc(helst,_9915,_9926),
    !,
    accept(_9932,_9926,_9885).

something([something,lit(noe)],_9867,_9869) --> 
    cc(noe,_9867,_9869).

something([something,lit(det),_9895,!],_9873,_9875) --> 
    cc(det,_9873,_9894),
    endofline(_9895,_9894,_9875),
    !.

something([something,lit(det),_9908,_9937],_9886,_9888) --> 
    cc(det,_9886,_9907),
    not_look_ahead(['å'],_9908,_9907,_9925),
    not_look_ahead(w(noun(_9860,_9861,_9862,_9863)),_9937,_9925,_9888).

somegood([somegood,lit(det),_9903,_9927,!],_9881,_9883) --> 
    cc(det,_9881,_9902),
    so0(_9903,_9902,_9918),
    w(adj2(good,nil),_9927,_9918,_9883),
    !.

somegood([somegood,lit(det),_9903,_9927,!],_9881,_9883) --> 
    cc(det,_9881,_9902),
    so0(_9903,_9902,_9918),
    w(adj2(bad,nil),_9927,_9918,_9883),
    !.

sometimes0([sometimes0,_9878],_9867,_9869) --> 
    optional(sometimes,_9878,_9867,_9869).

sometimes([sometimes,lit(noen),_9905,!,_9939],_9883,_9885) --> 
    cc(noen,_9883,_9904),
    w(noun(time_count,_9864,_9865,_9866),_9905,_9904,_9922),
    !,
    accept(_9939,_9922,_9885).

sometimes([sometimes,lit(tidvis)],_9867,_9869) --> 
    cc(tidvis,_9867,_9869).

sometimes0([sometimes0,[]],_9865,_9865) --> 
    [].

notrel([notrel,_9886,!,_9920],_9875,_9877) --> 
    look_ahead([som],_9886,_9875,_9903),
    !,
    reject(_9920,_9903,_9877).

notrel([notrel,[]],_9865,_9865) --> 
    [].

relpron(thing,[relpron,lit(som),_9899],_9874,_9876) --> 
    cc(som,_9874,_9898),
    also0(_9899,_9898,_9876).

recipron(man,[recipron,lit(han),_9899],_9874,_9876) --> 
    cc(han,_9874,_9898),
    self(_9899,_9898,_9876).

recipron(person,[recipron,lit(seg),_9899],_9874,_9876) --> 
    cc(seg,_9874,_9898),
    self(_9899,_9898,_9876).

recipron(woman,[recipron,lit(henne),_9899],_9874,_9876) --> 
    cc(henne,_9874,_9898),
    self(_9899,_9898,_9876).

recipron(thing,[recipron,lit(seg),_9899],_9874,_9876) --> 
    cc(seg,_9874,_9898),
    self0(_9899,_9898,_9876).

recipron(thing,[recipron,lit(hverandre)],_9871,_9873) --> 
    cc(hverandre,_9871,_9873).

same([same,lit(samme)],_9867,_9869) --> 
    cc(samme,_9867,_9869).

self0([self0,_9876],_9865,_9867) --> 
    self(_9876,_9865,_9867).

self0([self0,[]],_9865,_9865) --> 
    [].

self([self,lit(selv)],_9867,_9869) --> 
    cc(selv,_9867,_9869).

set([set,_9883],_9872,_9874) --> 
    w(noun(set,_9853,_9854,n),_9883,_9872,_9874).

setlist([setlist,_9876],_9865,_9867) --> 
    set(_9876,_9865,_9867).

setlist([setlist,_9883],_9872,_9874) --> 
    w(noun(list,_9853,_9854,n),_9883,_9872,_9874).

several([several,lit(fler)],_9867,_9869) --> 
    cc(fler,_9867,_9869).

several([several,lit(flere)],_9867,_9869) --> 
    cc(flere,_9867,_9869).

several([several,lit(mer),lit(enn),_9908],_9875,_9877) --> 
    cc(mer,_9875,_9896),
    cc(enn,_9896,_9907),
    one(_9908,_9907,_9877).

sin([sin,lit(sin)],_9867,_9869) --> 
    cc(sin,_9867,_9869).

sin([sin,lit(sine)],_9867,_9869) --> 
    cc(sine,_9867,_9869).

sin([sin,lit(sitt)],_9867,_9869) --> 
    cc(sitt,_9867,_9869).

saa0([saa0,lit(bare),!,_9900],_9873,_9875) --> 
    cc(bare,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

saa0([saa0,lit('så'),_9902,!,_9951],_9880,_9882) --> 
    cc('så',_9880,_9901),
    optional([ofte],_9902,_9901,_9934),
    !,
    accept(_9951,_9934,_9882).

saa0([saa0,lit(mye),!,_9900],_9873,_9875) --> 
    cc(mye,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

saa0([saa0,lit(da),!,_9900],_9873,_9875) --> 
    cc(da,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

saa0([saa0,[]],_9865,_9865) --> 
    [].

so0([so0,_9879,!],_9868,_9870) --> 
    so(_9879,_9868,_9870),
    !.

so0([so0,[]],_9865,_9865) --> 
    [].

so([so,lit('så')],_9867,_9869) --> 
    cc('så',_9867,_9869).

so([so,_9876],_9865,_9867) --> 
    too(_9876,_9865,_9867).

so([so,lit(heretter)],_9867,_9869) --> 
    cc(heretter,_9867,_9869).

so_that([so_that,lit(forat)],_9867,_9869) --> 
    cc(forat,_9867,_9869).

so_that([so_that,lit(som),lit(at)],_9872,_9874) --> 
    cc(som,_9872,_9893),
    cc(at,_9893,_9874).

so_that([so_that,lit(slik),_9899,_9923],_9877,_9879) --> 
    cc(slik,_9877,_9898),
    that(_9899,_9898,_9914),
    optional([bare],_9923,_9914,_9879).

so_that([so_that,lit('så'),_9892],_9870,_9872) --> 
    cc('så',_9870,_9891),
    that(_9892,_9891,_9872).

so_that([so_that,lit(som),_9901,_9930],_9879,_9881) --> 
    cc(som,_9879,_9900),
    w(verb(do1,_9861,fin),_9901,_9900,_9918),
    that(_9930,_9918,_9881).

so_that([so_that,lit('så'),_9905,!],_9883,_9885) --> 
    cc('så',_9883,_9904),
    look_ahead_lit([jeg,da,den,det],_9905,_9904,_9885),
    !.

so_that([so_that,lit('så'),_9904,!],_9882,_9884) --> 
    cc('så',_9882,_9903),
    look_ahead(w(noun(_9862,_9863,_9864,_9865)),_9904,_9903,_9884),
    !.

so_that([so_that,lit(til),lit(at),!],_9875,_9877) --> 
    cc(til,_9875,_9896),
    cc(at,_9896,_9877),
    !.

so_that([so_that,_9883,lit(at)],_9872,_9874) --> 
    prep1(for,_9883,_9872,_9900),
    cc(at,_9900,_9874).

som0([som0,_9876],_9865,_9867) --> 
    som(_9876,_9865,_9867).

som0([som0,[]],_9865,_9865) --> 
    [].

som([som,lit(som)],_9867,_9869) --> 
    cc(som,_9867,_9869).

some([some,lit(noen),_9892],_9870,_9872) --> 
    cc(noen,_9870,_9891),
    of0(_9892,_9891,_9872).

someonex([someonex,_9876],_9865,_9867) --> 
    someone(_9876,_9865,_9867).

someone([someone,lit(dere)],_9867,_9869) --> 
    cc(dere,_9867,_9869).

someone([someone,lit(noen),_9892],_9870,_9872) --> 
    cc(noen,_9870,_9891),
    endofline(_9892,_9891,_9872).

someone([someone,lit(noen),_9900],_9878,_9880) --> 
    cc(noen,_9878,_9899),
    look_ahead(w(verb(_9857,_9858,_9859)),_9900,_9899,_9880).

someone([someone,_9881,lit(mange)],_9870,_9872) --> 
    so0(_9881,_9870,_9896),
    cc(mange,_9896,_9872).

someone([someone,lit(den),_9896],_9874,_9876) --> 
    cc(den,_9874,_9895),
    look_ahead([som],_9896,_9895,_9876).

someone([someone,lit(en),_9896],_9874,_9876) --> 
    cc(en,_9874,_9895),
    look_ahead([som],_9896,_9895,_9876).

soonar([soonar,lit(snart)],_9867,_9869) --> 
    cc(snart,_9867,_9869).

soonar([soonar,lit(snarest)],_9867,_9869) --> 
    cc(snarest,_9867,_9869).

soonar([soonar,lit(fort)],_9867,_9869) --> 
    cc(fort,_9867,_9869).

soon([soon,lit(fort)],_9867,_9869) --> 
    cc(fort,_9867,_9869).

soon([soon,_9881],_9870,_9872) --> 
    w(adj2(fast,nil),_9881,_9870,_9872).

soon([soon,lit(snart)],_9867,_9869) --> 
    cc(snart,_9867,_9869).

soon([soon,lit(snarest)],_9867,_9869) --> 
    cc(snarest,_9867,_9869).

statics(avg,[statics,lit(gjennomsnittet),_9899],_9874,_9876) --> 
    cc(gjennomsnittet,_9874,_9898),
    ofthe0(_9899,_9898,_9876).

statics(max(1),[statics,lit(maksimum),_9901],_9876,_9878) --> 
    cc(maksimum,_9876,_9900),
    ofthe0(_9901,_9900,_9878).

statics(min(1),[statics,lit(minimum),_9901],_9876,_9878) --> 
    cc(minimum,_9876,_9900),
    ofthe0(_9901,_9900,_9878).

statics(sum,[statics,_9886,_9910],_9872,_9874) --> 
    total(_9886,_9872,_9901),
    ofthe0(_9910,_9901,_9874).

statics(number,[statics,lit(antall),_9899],_9874,_9876) --> 
    cc(antall,_9874,_9898),
    ofthe0(_9899,_9898,_9876).

sure([sure,lit(sikker)],_9867,_9869) --> 
    cc(sikker,_9867,_9869).

sure([sure,lit(sikkert)],_9867,_9869) --> 
    cc(sikkert,_9867,_9869).

sure([sure,lit(sikre)],_9867,_9869) --> 
    cc(sikre,_9867,_9869).

terminator([terminator,_9882,!,_9911],_9871,_9873) --> 
    termchar(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

termchar0([termchar0,_9879,!],_9868,_9870) --> 
    termchar(_9879,_9868,_9870),
    !.

termchar0([termchar0,[]],_9865,_9865) --> 
    [].

termchar([termchar,lit('.')],_9867,_9869) --> 
    cc('.',_9867,_9869).

termchar([termchar,lit(?)],_9867,_9869) --> 
    cc(?,_9867,_9869).

termchar([termchar,lit(!)],_9867,_9869) --> 
    cc(!,_9867,_9869).

termchar([termchar,lit(:)],_9867,_9869) --> 
    cc(:,_9867,_9869).

than0([than0,_9876],_9865,_9867) --> 
    than(_9876,_9865,_9867).

than0([than0,[]],_9865,_9865) --> 
    [].

than([than,lit(enn)],_9867,_9869) --> 
    cc(enn,_9867,_9869).

that([that,lit(om),lit(at),!,_9916],_9878,_9880) --> 
    cc(om,_9878,_9899),
    cc(at,_9899,_9910),
    !,
    accept(_9916,_9910,_9880).

that([that,lit(at)],_9867,_9869) --> 
    cc(at,_9867,_9869).

that(that,[that,_9883],_9869,_9871) --> 
    that(_9883,_9869,_9871).

that(how,[that,_9883],_9869,_9871) --> 
    how(_9883,_9869,_9871).

that(when,[that,_9883],_9869,_9871) --> 
    when(_9883,_9869,_9871).

that(where,[that,_9883],_9869,_9871) --> 
    where(_9883,_9869,_9871).

that(whether,[that,_9888,lit(hvorvidt)],_9874,_9876) --> 
    paa0(_9888,_9874,_9903),
    cc(hvorvidt,_9903,_9876).

that(whether,[that,_9888,lit(om)],_9874,_9876) --> 
    paa0(_9888,_9874,_9903),
    cc(om,_9903,_9876).

that(why,[that,lit(hvorfor)],_9871,_9873) --> 
    cc(hvorfor,_9871,_9873).

paa0([paa0,lit('på'),!,_9900],_9873,_9875) --> 
    cc('på',_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

paa0([paa0,[]],_9865,_9865) --> 
    [].

that0([that0,_9876],_9865,_9867) --> 
    that(_9876,_9865,_9867).

that0([that0,[]],_9865,_9865) --> 
    [].

the([the,lit(den)],_9867,_9869) --> 
    cc(den,_9867,_9869).

the([the,lit(denne)],_9867,_9869) --> 
    cc(denne,_9867,_9869).

the([the,lit(det)],_9867,_9869) --> 
    cc(det,_9867,_9869).

the([the,lit(de)],_9867,_9869) --> 
    cc(de,_9867,_9869).

the([the,lit(dette)],_9867,_9869) --> 
    cc(dette,_9867,_9869).

the([the,lit(disse),_9892],_9870,_9872) --> 
    cc(disse,_9870,_9891),
    look_ahead_np(_9892,_9891,_9872).

themost([themost,_9881,lit(mest)],_9870,_9872) --> 
    the(_9881,_9870,_9896),
    cc(mest,_9896,_9872).

the0([the0,_9885,_9909,!,_9938],_9874,_9876) --> 
    the(_9885,_9874,_9900),
    der0(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

the0([the0,{},_9894],_9873,_9875) --> 
    {user:value(textflag,true)},
    art(_9894,_9873,_9875).

the0([the0,[]],_9865,_9865) --> 
    [].

the10([the10,lit(det)],_9867,_9869) --> 
    cc(det,_9867,_9869).

the10([the10,lit(den)],_9867,_9869) --> 
    cc(den,_9867,_9869).

the10([the10,[]],_9865,_9865) --> 
    [].

theplu0([theplu0,_9885,_9909,!,_9938],_9874,_9876) --> 
    all0(_9885,_9874,_9900),
    theplu(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

theplu0([theplu0,lit(den)],_9867,_9869) --> 
    cc(den,_9867,_9869).

theplu0([theplu0,_9876],_9865,_9867) --> 
    all0(_9876,_9865,_9867).

theplu([theplu,lit(de)],_9867,_9869) --> 
    cc(de,_9867,_9869).

their([their,lit(deres)],_9867,_9869) --> 
    cc(deres,_9867,_9869).

their([their,lit(de),lit(andres)],_9872,_9874) --> 
    cc(de,_9872,_9893),
    cc(andres,_9893,_9874).

then0([then0,_9882,!,_9911],_9871,_9873) --> 
    then1(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

then0([then0,[]],_9865,_9865) --> 
    [].

then1([then1,lit(da)],_9867,_9869) --> 
    cc(da,_9867,_9869).

then1([then1,lit('så')],_9867,_9869) --> 
    cc('så',_9867,_9869).

theonly0([theonly0,_9879,_9903],_9868,_9870) --> 
    the0(_9879,_9868,_9894),
    only0(_9903,_9894,_9870).

thereit0([thereit0,_9882,!,_9911],_9871,_9873) --> 
    thereit(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

thereit0([thereit0,[]],_9865,_9865) --> 
    [].

therenot0([therenot0,_9885,_9909,!,_9938],_9874,_9876) --> 
    thereit(_9885,_9874,_9900),
    not0(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

therenot0([therenot0,_9885,_9909,!,_9938],_9874,_9876) --> 
    not(_9885,_9874,_9900),
    thereit0(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

therenot0([therenot0,[]],_9865,_9865) --> 
    [].

thereit(_9850,[thereit,_9900,_9924,_9953,_9977,!,_10006],_9886,_9888) --> 
    thereit(_9900,_9886,_9915),
    negation0(_9850,_9924,_9915,_9941),
    redundant0(_9953,_9941,_9968),
    been0(_9977,_9968,_9992),
    !,
    accept(_10006,_9992,_9888).

thereitN([thereitN,_9886,_9910,!],_9875,_9877) --> 
    thereit(_9886,_9875,_9901),
    look_ahead([ikke],_9910,_9901,_9877),
    !.

thereitN([thereitN,_9876],_9865,_9867) --> 
    thereit(_9876,_9865,_9867).

dette([dette,lit(det),_9892],_9870,_9872) --> 
    cc(det,_9870,_9891),
    it_was_pronoun(_9892,_9891,_9872).

dette([dette,lit(dette)],_9867,_9869) --> 
    cc(dette,_9867,_9869).

thereit2(be,[thereit2,lit(det),!],_9874,_9876) --> 
    cc(det,_9874,_9876),
    !.

thereit2(_9850,[thereit2,_9886,!],_9872,_9874) --> 
    thereit(_9886,_9872,_9874),
    !.

thereit2(be,[thereit2,_9890,!],_9876,_9878) --> 
    look_ahead([til],_9890,_9876,_9878),
    !.

init([init,lit(det)],_9867,_9869) --> 
    cc(det,_9867,_9869).

init([init,lit(dette),_9892],_9870,_9872) --> 
    cc(dette,_9870,_9891),
    look_ahead_vp(_9892,_9891,_9872).

thereit([thereit,lit(de),_9896],_9874,_9876) --> 
    cc(de,_9874,_9895),
    look_ahead([noe],_9896,_9895,_9876).

thereit([thereit,lit(det),_9898,!,_9927],_9876,_9878) --> 
    cc(det,_9876,_9897),
    thereit_not_pronoun(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

thereit([thereit,lit(der)],_9867,_9869) --> 
    cc(der,_9867,_9869).

thereit([thereit,lit(her)],_9867,_9869) --> 
    cc(her,_9867,_9869).

thereit_not_pronoun([thereit_not_pronoun,_9882,!,_9911],_9871,_9873) --> 
    it_was_pronoun(_9882,_9871,_9897),
    !,
    reject(_9911,_9897,_9873).

thereit_not_pronoun([thereit_not_pronoun,[]],_9865,_9865) --> 
    [].

it_was_pronoun([it_was_pronoun,_9876],_9865,_9867) --> 
    endofline(_9876,_9865,_9867).

it_was_pronoun([it_was_pronoun,_9876],_9865,_9867) --> 
    look_ahead_vp(_9876,_9865,_9867).

this(_9850,[this,_9890,{}],_9876,_9878) --> 
    this(_9890,_9876,_9878),
    {user:it_template(_9850)}.

this(_9850,[this,_9890,{}],_9876,_9878) --> 
    thereit(_9890,_9876,_9878),
    {user:it_template(_9850)}.

this([this,lit(denne)],_9867,_9869) --> 
    cc(denne,_9867,_9869).

this([this,lit(dette)],_9867,_9869) --> 
    cc(dette,_9867,_9869).

this([this,lit(disse),_9892],_9870,_9872) --> 
    cc(disse,_9870,_9891),
    not_look_ahead_np(_9892,_9891,_9872).

this([this,lit(det),_9899,_9928],_9877,_9879) --> 
    cc(det,_9877,_9898),
    look_ahead(['.'],_9899,_9898,_9916),
    accept(_9928,_9916,_9879).

this([this,lit(det),_9899,_9928],_9877,_9879) --> 
    cc(det,_9877,_9898),
    look_ahead([?],_9899,_9898,_9916),
    accept(_9928,_9916,_9879).

this([this,lit(det),lit(da),!,_9916],_9878,_9880) --> 
    cc(det,_9878,_9899),
    cc(da,_9899,_9910),
    !,
    accept(_9916,_9910,_9880).

this([this,lit(det),_9898,!,_9927],_9876,_9878) --> 
    cc(det,_9876,_9897),
    end_of_line(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

this([this,lit(slik),_9898],_9876,_9878) --> 
    cc(slik,_9876,_9897),
    not_look_ahead_lit([at,som],_9898,_9897,_9878).

thisplace(in,[thisplace,lit(her)],_9871,_9873) --> 
    cc(her,_9871,_9873).

thisplace(to,[thisplace,lit(hit)],_9871,_9873) --> 
    cc(hit,_9871,_9873).

thisplace(in,[thisplace,lit(der)],_9871,_9873) --> 
    cc(der,_9871,_9873).

thisplace(to,[thisplace,lit(dit)],_9871,_9873) --> 
    cc(dit,_9871,_9873).

timepoint([timepoint,_9883],_9872,_9874) --> 
    w(noun(time,_9853,u,n),_9883,_9872,_9874).

timepoint([timepoint,_9883],_9872,_9874) --> 
    w(noun(clock,sin,u,n),_9883,_9872,_9874).

to([to,_9878],_9867,_9869) --> 
    prep(to,_9878,_9867,_9869).

forto0([forto0,_9879,!],_9868,_9870) --> 
    forto(_9879,_9868,_9870),
    !.

forto0([forto0,[]],_9865,_9865) --> 
    [].

forto([forto,lit(for)],_9867,_9869) --> 
    cc(for,_9867,_9869).

forto([forto,lit(til)],_9867,_9869) --> 
    cc(til,_9867,_9869).

forto([forto,lit(om)],_9867,_9869) --> 
    cc(om,_9867,_9869).

slikat([slikat,lit(slik),lit(at)],_9872,_9874) --> 
    cc(slik,_9872,_9893),
    cc(at,_9893,_9874).

slikat([slikat,lit(sikkert),lit(at)],_9872,_9874) --> 
    cc(sikkert,_9872,_9893),
    cc(at,_9893,_9874).

to0([to0,_9879,!],_9868,_9870) --> 
    to(_9879,_9868,_9870),
    !.

to0([to0,[]],_9865,_9865) --> 
    [].

tomed0([tomed0,lit(til),!],_9870,_9872) --> 
    cc(til,_9870,_9872),
    !.

tomed0([tomed0,lit(med),!],_9870,_9872) --> 
    cc(med,_9870,_9872),
    !.

tomed0([tomed0,[]],_9865,_9865) --> 
    [].

too([too,lit(for),_9899],_9877,_9879) --> 
    cc(for,_9877,_9898),
    look_ahead(w(adj(_9857,nil)),_9899,_9898,_9879).

today0([today0,_9876],_9865,_9867) --> 
    today(_9876,_9865,_9867).

today0([today0,[]],_9865,_9865) --> 
    [].

today([today,lit(idag)],_9867,_9869) --> 
    cc(idag,_9867,_9869).

today([today,_9888,_9917],_9877,_9879) --> 
    prep(in,_9888,_9877,_9905),
    w(noun(day,sin,u,n),_9917,_9905,_9879).

tomorrow([tomorrow,lit(imorgen)],_9867,_9869) --> 
    cc(imorgen,_9867,_9869).

tomorrow([tomorrow,_9883,lit(morgen)],_9872,_9874) --> 
    prep1(in,_9883,_9872,_9900),
    cc(morgen,_9900,_9874).

total([total,lit(total)],_9867,_9869) --> 
    cc(total,_9867,_9869).

total([total,lit(totalt)],_9867,_9869) --> 
    cc(totalt,_9867,_9869).

total([total,lit(totale)],_9867,_9869) --> 
    cc(totale,_9867,_9869).

total([total,lit(sum),_9892],_9870,_9872) --> 
    cc(sum,_9870,_9891),
    of(_9892,_9891,_9872).

true([true,lit(sann)],_9867,_9869) --> 
    cc(sann,_9867,_9869).

true([true,lit(sant)],_9867,_9869) --> 
    cc(sant,_9867,_9869).

true([true,lit(sanne)],_9867,_9869) --> 
    cc(sanne,_9867,_9869).

true([true,lit(slik)],_9867,_9869) --> 
    cc(slik,_9867,_9869).

truefalse(id,[truefalse,_9883],_9869,_9871) --> 
    true(_9883,_9869,_9871).

truefalse(id,[truefalse,_9886,_9910],_9872,_9874) --> 
    not(_9886,_9872,_9901),
    false(_9910,_9901,_9874).

truefalse(not,[truefalse,_9883],_9869,_9871) --> 
    false(_9883,_9869,_9871).

truefalse(not,[truefalse,_9886,_9910],_9872,_9874) --> 
    not(_9886,_9872,_9901),
    true(_9910,_9901,_9874).

unequal([unequal,lit(ulik)],_9867,_9869) --> 
    cc(ulik,_9867,_9869).

unequal([unequal,lit(ulikt)],_9867,_9869) --> 
    cc(ulikt,_9867,_9869).

unequal([unequal,lit(ulike)],_9867,_9869) --> 
    cc(ulike,_9867,_9869).

unequal([unequal,_9879,_9903],_9868,_9870) --> 
    not(_9879,_9868,_9894),
    equal(_9903,_9894,_9870).

until([until,lit(inntil)],_9867,_9869) --> 
    cc(inntil,_9867,_9869).

until([until,lit(fram),_9894],_9872,_9874) --> 
    cc(fram,_9872,_9893),
    prep1(to,_9894,_9893,_9874).

use([use,_9882],_9871,_9873) --> 
    w(verb(use,_9853,fin),_9882,_9871,_9873).

use([use,_9882],_9871,_9873) --> 
    w(verb(want,_9853,fin),_9882,_9871,_9873).

what([what,lit(hva)],_9867,_9869) --> 
    cc(hva,_9867,_9869).

whatbe([whatbe,_9885,_9909,!,_9938],_9874,_9876) --> 
    what(_9885,_9874,_9900),
    be(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

whatbe([whatbe,lit(hvilke),_9898,!,_9927],_9876,_9878) --> 
    cc(hvilke,_9876,_9897),
    be(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

whatbe([whatbe,lit(hvilken),_9898,!,_9927],_9876,_9878) --> 
    cc(hvilken,_9876,_9897),
    be(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

whatbe([whatbe,lit(hvilket),_9898,!,_9927],_9876,_9878) --> 
    cc(hvilket,_9876,_9897),
    be(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

whatbemean([whatbemean,lit(hva),_9898],_9876,_9878) --> 
    cc(hva,_9876,_9897),
    w(verb(be,pres,fin),_9898,_9897,_9878).

whatbemean([whatbemean,lit(hva),_9898],_9876,_9878) --> 
    cc(hva,_9876,_9897),
    w(verb(mean2,pres,fin),_9898,_9897,_9878).

whatbemean([whatbemean,lit(hva),_9898],_9876,_9878) --> 
    cc(hva,_9876,_9897),
    w(verb(indicate,pres,fin),_9898,_9897,_9878).

when0([when0,_9882,!,_9911],_9871,_9873) --> 
    when(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

when0([when0,[]],_9865,_9865) --> 
    [].

whenx([whenx,_9887,lit(jeg),!,_9927],_9876,_9878) --> 
    when1(_9887,_9876,_9902),
    cc(jeg,_9902,_9921),
    !,
    reject(_9927,_9921,_9878).

whenx([whenx,_9876],_9865,_9867) --> 
    when(_9876,_9865,_9867).

when([when,lit('når'),_9898,!,_9927],_9876,_9878) --> 
    cc('når',_9876,_9897),
    timepoint(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

when([when,lit('når')],_9867,_9869) --> 
    cc('når',_9867,_9869).

when([when,lit(hvordan),_9905,!,_9939],_9883,_9885) --> 
    cc(hvordan,_9883,_9904),
    w(noun(time,_9864,u,n),_9905,_9904,_9922),
    !,
    accept(_9939,_9922,_9885).

when([when,lit(hvor),_9898,!,_9927],_9876,_9878) --> 
    cc(hvor,_9876,_9897),
    timepoint(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

when([when,lit(hva),_9898,!,_9927],_9876,_9878) --> 
    cc(hva,_9876,_9897),
    timepoint(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

when([when,_9885,_9909,!,_9938],_9874,_9876) --> 
    which(_9885,_9874,_9900),
    timepoint(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

when([when,_9890,_9919,_9943,!,_9972],_9879,_9881) --> 
    prep1(to,_9890,_9879,_9907),
    which(_9919,_9907,_9934),
    timepoint(_9943,_9934,_9958),
    !,
    accept(_9972,_9958,_9881).

when([when,_9890,_9919,_9943,!,_9972],_9879,_9881) --> 
    prep1(on,_9890,_9879,_9907),
    which(_9919,_9907,_9934),
    timepoint(_9943,_9934,_9958),
    !,
    accept(_9972,_9958,_9881).

when([when,lit('så'),lit(snart),!,_9916],_9878,_9880) --> 
    cc('så',_9878,_9899),
    cc(snart,_9899,_9910),
    !,
    accept(_9916,_9910,_9880).

when([when,lit(hva),lit(ti)],_9872,_9874) --> 
    cc(hva,_9872,_9893),
    cc(ti,_9893,_9874).

when([when,lit(hvordan),lit(ti)],_9872,_9874) --> 
    cc(hvordan,_9872,_9893),
    cc(ti,_9893,_9874).

when([when,lit(tid),_9896],_9874,_9876) --> 
    cc(tid,_9874,_9895),
    look_ahead(['går'],_9896,_9895,_9876).

where([where,lit(hvor),_9907,_9936,!,_9965],_9885,_9887) --> 
    cc(hvor,_9885,_9906),
    not_look_ahead(w(prep(from)),_9907,_9906,_9924),
    andwhen0(_9936,_9924,_9951),
    !,
    accept(_9965,_9951,_9887).

where([where,_9892,_9916,!,_9950],_9881,_9883) --> 
    which(_9892,_9881,_9907),
    w(noun(place,_9862,_9863,_9864),_9916,_9907,_9933),
    !,
    accept(_9950,_9933,_9883).

where1([where1,lit(der),lit(hvor),!,_9916],_9878,_9880) --> 
    cc(der,_9878,_9899),
    cc(hvor,_9899,_9910),
    !,
    accept(_9916,_9910,_9880).

where1([where1,lit(hvor),_9898,!,_9927],_9876,_9878) --> 
    cc(hvor,_9876,_9897),
    meny(_9898,_9897,_9913),
    !,
    reject(_9927,_9913,_9878).

where1([where1,lit(hvor)],_9867,_9869) --> 
    cc(hvor,_9867,_9869).

where1([where1,lit(der)],_9867,_9869) --> 
    cc(der,_9867,_9869).

wherefrom([wherefrom,_9897,_9926,_9950,!,_9984],_9886,_9888) --> 
    prep1(from,_9897,_9886,_9914),
    which(_9926,_9914,_9941),
    w(noun(place,_9867,_9868,_9869),_9950,_9941,_9967),
    !,
    accept(_9984,_9967,_9888).

wherefrom([wherefrom,_9889,lit(hvor),!,_9934],_9878,_9880) --> 
    prep1(from,_9889,_9878,_9906),
    cc(hvor,_9906,_9928),
    !,
    accept(_9934,_9928,_9880).

wherefrom([wherefrom,lit(hvorfra)],_9867,_9869) --> 
    cc(hvorfra,_9867,_9869).

wherefrom([wherefrom,lit(hvor),lit(fra)],_9872,_9874) --> 
    cc(hvor,_9872,_9893),
    cc(fra,_9893,_9874).

wherefrom([wherefrom,lit(hvor),lit(ifra)],_9872,_9874) --> 
    cc(hvor,_9872,_9893),
    cc(ifra,_9893,_9874).

while([while,lit(mens)],_9867,_9869) --> 
    cc(mens,_9867,_9869).

which0([which0,_9882,!,_9911],_9871,_9873) --> 
    which(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

which0([which0,[]],_9865,_9865) --> 
    [].

which([which,lit(hva),_9900,_9929,!],_9878,_9880) --> 
    cc(hva,_9878,_9899),
    prep1(for,_9900,_9899,_9917),
    a0(_9929,_9917,_9880),
    !.

which([which,lit(hva),lit(slags),!],_9875,_9877) --> 
    cc(hva,_9875,_9896),
    cc(slags,_9896,_9877),
    !.

which([which,lit(hvilken),lit(slags),!],_9875,_9877) --> 
    cc(hvilken,_9875,_9896),
    cc(slags,_9896,_9877),
    !.

which([which,lit(hvilken)],_9867,_9869) --> 
    cc(hvilken,_9867,_9869).

which([which,lit(hvilket)],_9867,_9869) --> 
    cc(hvilket,_9867,_9869).

which([which,lit(hvilke),_9892],_9870,_9872) --> 
    cc(hvilke,_9870,_9891),
    off0(_9892,_9891,_9872).

which2([which2,_9882,_9906,_9930],_9871,_9873) --> 
    which(_9882,_9871,_9897),
    numbertype0(_9906,_9897,_9921),
    ofthe0(_9930,_9921,_9873).

which2([which2,lit(hvem),_9916,_9945,!],_9894,_9896) --> 
    cc(hvem,_9894,_9915),
    look_ahead(w(noun(_9865,sin,u,n)),_9916,_9915,_9933),
    gmem(_9865,[bus,tram,day],_9945,_9933,_9896),
    !.

which2([which2,lit(hvordan),_9918,_9947,!],_9896,_9898) --> 
    cc(hvordan,_9896,_9917),
    look_ahead(w(noun(_9865,sin,u,n)),_9918,_9917,_9935),
    gmem(_9865,[label,bus,tram,day],_9947,_9935,_9898),
    !.

numbertype0([numbertype0,_9882,!,_9911],_9871,_9873) --> 
    type(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

numbertype0([numbertype0,[]],_9865,_9865) --> 
    [].

with0([with0,_9884,!,_9918],_9873,_9875) --> 
    prep(with,_9884,_9873,_9901),
    !,
    accept(_9918,_9901,_9875).

with0([with0,[]],_9865,_9865) --> 
    [].

who([who,lit(hvem)],_9867,_9869) --> 
    cc(hvem,_9867,_9869).

whose([whose,lit(hvis)],_9867,_9869) --> 
    cc(hvis,_9867,_9869).

mex0([mex0,_9886,!,_9920],_9875,_9877) --> 
    look_ahead([jeg],_9886,_9875,_9903),
    !,
    reject(_9920,_9903,_9877).

mex0([mex0,_9886,!,_9920],_9875,_9877) --> 
    look_ahead([du],_9886,_9875,_9903),
    !,
    reject(_9920,_9903,_9877).

mex0([mex0,lit(seg),!,_9900],_9873,_9875) --> 
    cc(seg,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

mex0([mex0,lit(meg),!,_9900],_9873,_9875) --> 
    cc(meg,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

mex0([mex0,lit(oss),!,_9900],_9873,_9875) --> 
    cc(oss,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

mex0([mex0,[]],_9865,_9865) --> 
    [].

you([you,lit(du),_9896],_9874,_9876) --> 
    cc(du,_9874,_9895),
    not_look_ahead([jeg],_9896,_9895,_9876).

yesterday([yesterday,_9883,lit('går')],_9872,_9874) --> 
    prep1(in,_9883,_9872,_9900),
    cc('går',_9900,_9874).

younger([younger,lit(yngre)],_9867,_9869) --> 
    cc(yngre,_9867,_9869).

your([your,lit(din)],_9867,_9869) --> 
    cc(din,_9867,_9869).

your([your,lit(ditt)],_9867,_9869) --> 
    cc(ditt,_9867,_9869).

your([your,lit(dine)],_9867,_9869) --> 
    cc(dine,_9867,_9869).

your([your,lit(di)],_9867,_9869) --> 
    cc(di,_9867,_9869).

num_na(_9850,[num_na,_9889,!,_9918],_9875,_9877) --> 
    art(_9889,_9875,_9904),
    !,
    reject(_9918,_9904,_9877).

num_na(_9850,[num_na,_9888],_9874,_9876) --> 
    w(nb(_9850,_9855),_9888,_9874,_9876).

num(_9850,[num,_9891,!],_9877,_9879) --> 
    w(nb(_9850,num),_9891,_9877,_9879),
    !.

personal('    ',[personal,lit(hysj)],_9871,_9873) --> 
    cc(hysj,_9871,_9873).

personal('RPGOLRAM',[personal,lit(rpgol)],_9871,_9873) --> 
    cc(rpgol,_9871,_9873).

personal('OK',[personal,lit(rpgolram)],_9871,_9873) --> 
    cc(rpgolram,_9871,_9873).

personal('Takk',[personal,lit('værs\'ågod')],_9871,_9873) --> 
    cc('værs\'ågod',_9871,_9873).

personal('Takk',[personal,_9902,lit('så'),_9942],_9888,_9890) --> 
    w(verb(be,imp,fin),_9902,_9888,_9919),
    cc('så',_9919,_9941),
    w(adj2(good,nil),_9942,_9941,_9890).

personal('Takk',[personal,_9892,_9916,_9940,_9964],_9878,_9880) --> 
    so(_9892,_9878,_9907),
    good(_9916,_9907,_9931),
    you(_9940,_9931,_9955),
    be(_9964,_9955,_9880).

personal('Takk',[personal,lit(bravo)],_9871,_9873) --> 
    cc(bravo,_9871,_9873).

personal('Takk',[personal,_9895,_9924,_9948],_9881,_9883) --> 
    w(verb(congratulate,pres,fin),_9895,_9881,_9912),
    with0(_9924,_9912,_9939),
    skip_rest(_9948,_9939,_9883).

personal(pong,[personal,lit(ping)],_9871,_9873) --> 
    cc(ping,_9871,_9873).

personal(_9850,[personal,_9885],_9871,_9873) --> 
    greetings(_9850,_9885,_9871,_9873).

greetings0([greetings0,_9888,_9917,!],_9877,_9879) --> 
    w(verb(help,imp,fin),_9888,_9877,_9905),
    optoken(_9917,_9905,_9879),
    !.

greetings0([greetings0,_9887,_9931,_9955,!],_9876,_9878) --> 
    optional(grums,_9887,_9876,_9919),
    greetings(_9931,_9919,_9946),
    optoken(_9955,_9946,_9878),
    !.

greetings0([greetings0,_9878],_9867,_9869) --> 
    optional(grums,_9878,_9867,_9869).

greetings('OK',[greetings,_9886,_9910],_9872,_9874) --> 
    okeys(_9886,_9872,_9901),
    endofline(_9910,_9901,_9874).

greetings('Hei på deg',[greetings,_9886,_9910],_9872,_9874) --> 
    hello(_9886,_9872,_9901),
    daddy(_9910,_9901,_9874).

greetings('Hei',[greetings,_9883],_9869,_9871) --> 
    greetings(_9883,_9869,_9871).

daddy([daddy,_9886,!],_9875,_9877) --> 
    w(noun(father,sin,u,n),_9886,_9875,_9877),
    !.

daddy([daddy,_9886,!],_9875,_9877) --> 
    w(noun(mother,sin,u,n),_9886,_9875,_9877),
    !.

daddy([daddy,_9885,!],_9874,_9876) --> 
    w(name(_9855,n,man),_9885,_9874,_9876),
    !.

optoken([optoken,lit(:)],_9867,_9869) --> 
    cc(:,_9867,_9869).

optoken([optoken,lit(!)],_9867,_9869) --> 
    cc(!,_9867,_9869).

optoken([optoken,lit('.')],_9867,_9869) --> 
    cc('.',_9867,_9869).

optoken([optoken,[]],_9865,_9865) --> 
    [].

greetings([greetings,lit(_9855),{}],_9885,_9887) --> 
    cc(_9855,_9885,_9887),
    {user:testmember(_9855,[ja,jo,joda,nei,neida])}.

greetings([greetings,_9876],_9865,_9867) --> 
    hellos(_9876,_9865,_9867).

greetings([greetings,lit(hva),lit(om)],_9872,_9874) --> 
    cc(hva,_9872,_9893),
    cc(om,_9893,_9874).

greetings([greetings,lit(nei)],_9867,_9869) --> 
    cc(nei,_9867,_9869).

greetings([greetings,lit(o),_9898,_9922],_9876,_9878) --> 
    cc(o,_9876,_9897),
    adj0(_9898,_9897,_9913),
    np0(_9856,_9857,_9922,_9913,_9878).

greetings([greetings,_9887,lit(meg)],_9876,_9878) --> 
    w(verb(say,inf,fin),_9887,_9876,_9904),
    cc(meg,_9904,_9878).

greetings([greetings,_9910,{},_9949,_9973,!],_9899,_9901) --> 
    w(noun(_9864,sin,u,n),_9910,_9899,_9927),
    {user:testmember(_9864,[oracle,brother,sister])},
    colon0(_9949,_9927,_9964),
    look_ahead(['når'],_9973,_9964,_9901),
    !.

greetings([greetings,_9911,{},_9950,_9974],_9900,_9902) --> 
    w(noun(_9869,sin,u,n),_9911,_9900,_9928),
    {user:testmember(_9869,[oracle,brother,sister])},
    colon0(_9950,_9928,_9965),
    not_look_ahead(w(verb(_9863,_9864,fin)),_9974,_9965,_9902).

greetings([greetings,_9918,_9947,_9976,_10005,_10029,_10058,_10082],_9907,_9909) --> 
    w(name(bustuc,n,_9872),_9918,_9907,_9935),
    not_look_ahead([som],_9947,_9935,_9964),
    not_look_ahead(w(prep(_9882)),_9976,_9964,_9993),
    colon0(_10005,_9993,_10020),
    not_look_ahead(w(verb(_9888,_9889,_9890)),_10029,_10020,_10046),
    not_look_ahead_vp(_10058,_10046,_10073),
    not_look_ahead_np(_10082,_10073,_9909).

trafikk([trafikk,lit(trafikk)],_9867,_9869) --> 
    cc(trafikk,_9867,_9869).

trafikk([trafikk,lit(t)],_9867,_9869) --> 
    cc(t,_9867,_9869).

grums0([grums0,[]],_9865,_9865) --> 
    [].

grums([grums,lit(rute),{}],_9875,_9877) --> 
    cc(rute,_9875,_9877),
    {user:value(smsflag,true)}.

grums([grums,lit('.')],_9867,_9869) --> 
    cc('.',_9867,_9869).

grums([grums,lit(?)],_9867,_9869) --> 
    cc(?,_9867,_9869).

grums([grums,lit(:),!],_9870,_9872) --> 
    cc(:,_9870,_9872),
    !.

grums([grums,lit(/),!],_9870,_9872) --> 
    cc(/,_9870,_9872),
    !.

grums([grums,lit(!),!],_9870,_9872) --> 
    cc(!,_9870,_9872),
    !.

grums([grums,lit(-),!],_9870,_9872) --> 
    cc(-,_9870,_9872),
    !.

grums([grums,lit(eksempelvis),lit(:)],_9872,_9874) --> 
    cc(eksempelvis,_9872,_9893),
    cc(:,_9893,_9874).

grums([grums,_9881,lit(at)],_9870,_9872) --> 
    redundant(_9881,_9870,_9896),
    cc(at,_9896,_9872).

grums([grums,_9905,lit(:),_9945,!],_9894,_9896) --> 
    w(noun(_9861,sin,u,n),_9905,_9894,_9922),
    cc(:,_9922,_9944),
    gmem(_9861,[error,thing,subject,example],_9945,_9944,_9896),
    !.

grums([grums,_9889,lit(om),!],_9878,_9880) --> 
    w(adj2(good,nil),_9889,_9878,_9906),
    cc(om,_9906,_9880),
    !.

grums([grums,lit(bare)],_9867,_9869) --> 
    cc(bare,_9867,_9869).

grums([grums,lit(eller)],_9867,_9869) --> 
    cc(eller,_9867,_9869).

grums([grums,lit(fyi),_9892],_9870,_9872) --> 
    cc(fyi,_9870,_9891),
    point0(_9892,_9891,_9872).

grums([grums,lit(grr)],_9867,_9869) --> 
    cc(grr,_9867,_9869).

grums([grums,lit(huff)],_9867,_9869) --> 
    cc(huff,_9867,_9869).

grums([grums,lit(igjen)],_9867,_9869) --> 
    cc(igjen,_9867,_9869).

grums([grums,lit(jo)],_9867,_9869) --> 
    cc(jo,_9867,_9869).

grums([grums,lit(og)],_9867,_9869) --> 
    cc(og,_9867,_9869).

grums([grums,lit(kort),lit(sagt)],_9872,_9874) --> 
    cc(kort,_9872,_9893),
    cc(sagt,_9893,_9874).

grums([grums,lit(men)],_9867,_9869) --> 
    cc(men,_9867,_9869).

grums([grums,lit(nei),lit(men)],_9872,_9874) --> 
    cc(nei,_9872,_9893),
    cc(men,_9893,_9874).

grums([grums,lit(nb)],_9867,_9869) --> 
    cc(nb,_9867,_9869).

grums([grums,lit(nei),_9900],_9878,_9880) --> 
    cc(nei,_9878,_9899),
    look_ahead(w(verb(_9857,_9858,_9859)),_9900,_9899,_9880).

grums([grums,lit(ja),_9900],_9878,_9880) --> 
    cc(ja,_9878,_9899),
    look_ahead(w(verb(_9857,_9858,_9859)),_9900,_9899,_9880).

grums([grums,lit(typisk)],_9867,_9869) --> 
    cc(typisk,_9867,_9869).

grums([grums,lit(uff)],_9867,_9869) --> 
    cc(uff,_9867,_9869).

grums([grums,lit(vel)],_9867,_9869) --> 
    cc(vel,_9867,_9869).

grums([grums,lit('å'),_9892],_9870,_9872) --> 
    cc('å',_9870,_9891),
    not_look_ahead_vp(_9892,_9891,_9872).

grums([grums,_9884,_9913],_9873,_9875) --> 
    w(nb(1939,num),_9884,_9873,_9901),
    point0(_9913,_9901,_9875).

grums([grums,_9897,_9941,_9970],_9886,_9888) --> 
    optional([for],_9897,_9886,_9929),
    w(noun(example,sin,u,n),_9941,_9929,_9958),
    optional([:],_9970,_9958,_9888).

grums([grums,_9888,lit(:)],_9877,_9879) --> 
    w(noun(question,sin,u,n),_9888,_9877,_9905),
    cc(:,_9905,_9879).

grums([grums,lit(svar),_9896],_9874,_9876) --> 
    cc(svar,_9874,_9895),
    optional([:],_9896,_9895,_9876).

grums([grums,lit(n),lit(:)],_9872,_9874) --> 
    cc(n,_9872,_9893),
    cc(:,_9893,_9874).

grums([grums,_9889,_9918,!],_9878,_9880) --> 
    w(noun(traffic,sin,u,n),_9889,_9878,_9906),
    colon(_9918,_9906,_9880),
    !.

grums([grums,_9885,lit(tt)],_9874,_9876) --> 
    not_look_ahead([dere],_9885,_9874,_9902),
    cc(tt,_9902,_9876).

grums([grums,lit('så'),_9900,!],_9878,_9880) --> 
    cc('så',_9878,_9899),
    w(adj2(funny,nil),_9900,_9899,_9880),
    !.

grums([grums,lit('så'),_9892],_9870,_9872) --> 
    cc('så',_9870,_9891),
    not_look_ahead_vp(_9892,_9891,_9872).

grums([grums,lit(ja),lit('så'),_9908],_9875,_9877) --> 
    cc(ja,_9875,_9896),
    cc('så',_9896,_9907),
    not_look_ahead_vp(_9908,_9907,_9877).

grums([grums,lit(nb),_9900],_9878,_9880) --> 
    cc(nb,_9878,_9899),
    one_of_lit(['.',:,!],_9900,_9899,_9880).

grums([grums,lit(obs),_9900],_9878,_9880) --> 
    cc(obs,_9878,_9899),
    one_of_lit(['.',:,!],_9900,_9899,_9880).

grums([grums,lit(unnskyld),lit(men)],_9872,_9874) --> 
    cc(unnskyld,_9872,_9893),
    cc(men,_9893,_9874).

grums([grums,lit(ok),_9900],_9878,_9880) --> 
    cc(ok,_9878,_9899),
    look_ahead(w(verb(_9857,imp,fin)),_9900,_9899,_9880).

grums([grums,lit(supert)],_9867,_9869) --> 
    cc(supert,_9867,_9869).

team([team,_9882],_9871,_9873) --> 
    w(name(team,_9853,_9854),_9882,_9871,_9873).

team([team,lit(team)],_9867,_9869) --> 
    cc(team,_9867,_9869).

hellos([hellos,_9882,_9906,_9930],_9871,_9873) --> 
    hello(_9882,_9871,_9897),
    sludder0(_9906,_9897,_9921),
    hellos0(_9930,_9921,_9873).

hellos0([hellos0,_9876],_9865,_9867) --> 
    hellos(_9876,_9865,_9867).

hellos0([hellos0,[]],_9865,_9865) --> 
    [].

adj0([adj0,_9887,!,_9921],_9876,_9878) --> 
    w(adj2(_9858,_9859),_9887,_9876,_9904),
    !,
    accept(_9921,_9904,_9878).

adj0([adj0,[]],_9865,_9865) --> 
    [].

hei([hei,lit(hei),_9892],_9870,_9872) --> 
    cc(hei,_9870,_9891),
    der0(_9892,_9891,_9872).

hei([hei,lit(hallo),_9892],_9870,_9872) --> 
    cc(hallo,_9870,_9891),
    der0(_9892,_9891,_9872).

sludder0([sludder0,_9879,!],_9868,_9870) --> 
    sludder(_9879,_9868,_9870),
    !.

sludder0([sludder0,[]],_9865,_9865) --> 
    [].

sludder([sludder,lit(alle),lit(sammen),!],_9875,_9877) --> 
    cc(alle,_9875,_9896),
    cc(sammen,_9896,_9877),
    !.

sludder([sludder,lit(der),!],_9870,_9872) --> 
    cc(der,_9870,_9872),
    !.

sludder([sludder,lit(du),_9903,!],_9881,_9883) --> 
    cc(du,_9881,_9902),
    not_look_ahead(w(verb(_9862,_9863,_9864)),_9903,_9902,_9883),
    !.

sludder([sludder,_9896,_9925,!],_9885,_9887) --> 
    w(name(tuc,n,_9860),_9896,_9885,_9913),
    not_look_ahead(w(verb(_9866,_9867,_9868)),_9925,_9913,_9887),
    !.

sludder([sludder,_9885,!],_9874,_9876) --> 
    w(name(bustuc,n,_9857),_9885,_9874,_9876),
    !.

sludder([sludder,_9885,!],_9874,_9876) --> 
    w(name(tt,n,_9857),_9885,_9874,_9876),
    !.

sludder([sludder,_9885,!],_9874,_9876) --> 
    w(name(tagore,n,_9857),_9885,_9874,_9876),
    !.

sludder([sludder,_9885,!],_9874,_9876) --> 
    w(name(tore,n,_9857),_9885,_9874,_9876),
    !.

sludder([sludder,_9886,!],_9875,_9877) --> 
    w(noun(computer,sin,u,n),_9886,_9875,_9877),
    !.

sludder([sludder,_9886,!],_9875,_9877) --> 
    w(noun(oracle,sin,_9857,n),_9886,_9875,_9877),
    !.

sludder([sludder,_9886,!],_9875,_9877) --> 
    w(noun(man,sin,u,n),_9886,_9875,_9877),
    !.

sludder([sludder,_9886,!],_9875,_9877) --> 
    w(noun(sweetheart,sin,u,n),_9886,_9875,_9877),
    !.

okeys0([okeys0,_9876],_9865,_9867) --> 
    okeys(_9876,_9865,_9867).

okeys0([okeys0,[]],_9865,_9865) --> 
    [].

okeys([okeys,lit(ok),_9906,_9950,_9994],_9884,_9886) --> 
    cc(ok,_9884,_9905),
    optional([ja],_9906,_9905,_9938),
    optional([men],_9950,_9938,_9982),
    optoken(_9994,_9982,_9886).

hello([hello,lit(bra)],_9867,_9869) --> 
    cc(bra,_9867,_9869).

hello([hello,_9876],_9865,_9867) --> 
    okeys(_9876,_9865,_9867).

hello([hello,_9884,_9908,_9952],_9873,_9875) --> 
    hei(_9884,_9873,_9899),
    optional(paadeg,_9908,_9899,_9940),
    sludder0(_9952,_9940,_9875).

hello([hello,lit(goddag)],_9867,_9869) --> 
    cc(goddag,_9867,_9869).

hello([hello,_9909,_9938,{}],_9898,_9900) --> 
    w(adj2(good,nil),_9909,_9898,_9926),
    w(noun(_9858,_9879,_9880,_9881),_9938,_9926,_9900),
    {user:testmember(_9858,[day,morning,evening,night,afternoon])}.

paadeg([paadeg,_9889,lit(deg),!,_9934],_9878,_9880) --> 
    prep1(on,_9889,_9878,_9906),
    cc(deg,_9906,_9928),
    !,
    accept(_9934,_9928,_9880).

paadeg([paadeg,lit(og),lit('hå'),!,_9916],_9878,_9880) --> 
    cc(og,_9878,_9899),
    cc('hå',_9899,_9910),
    !,
    accept(_9916,_9910,_9880).

forhjelpen0([forhjelpen0,_9886,lit(alt),!],_9875,_9877) --> 
    prep1(for,_9886,_9875,_9903),
    cc(alt,_9903,_9877),
    !.

forhjelpen0([forhjelpen0,_9897,_9926,_9955,!],_9886,_9888) --> 
    prep1(for,_9897,_9886,_9914),
    w(noun(_9863,sin,def,n),_9926,_9914,_9943),
    np1(_9868,_9869,_9955,_9943,_9888),
    !.

forhjelpen0([forhjelpen0,_9891,_9920,!],_9880,_9882) --> 
    prep1(for,_9891,_9880,_9908),
    w(noun(_9860,sin,def,n),_9920,_9908,_9882),
    !.

forhjelpen0([forhjelpen0,_9887,_9916,!],_9876,_9878) --> 
    prep1(for,_9887,_9876,_9904),
    np1(_9858,_9859,_9916,_9904,_9878),
    !.

forhjelpen0([forhjelpen0,lit(skal),lit(du),_9914],_9881,_9883) --> 
    cc(skal,_9881,_9902),
    cc(du,_9902,_9913),
    w(verb(have,imp,fin),_9914,_9913,_9883).

forhjelpen0([forhjelpen0,[]],_9865,_9865) --> 
    [].

hadet([hadet,lit(ha),lit(de),_9908],_9875,_9877) --> 
    cc(ha,_9875,_9896),
    cc(de,_9896,_9907),
    paabadet0(_9908,_9907,_9877).

hadet([hadet,lit(ha),lit(det),_9908],_9875,_9877) --> 
    cc(ha,_9875,_9896),
    cc(det,_9896,_9907),
    paabadet0(_9908,_9907,_9877).

hadet([hadet,lit(hadet),_9892],_9870,_9872) --> 
    cc(hadet,_9870,_9891),
    paabadet0(_9892,_9891,_9872).

hadet([hadet,lit(hade),_9892],_9870,_9872) --> 
    cc(hade,_9870,_9891),
    paabadet0(_9892,_9891,_9872).

kan([kan,_9882],_9871,_9873) --> 
    w(verb(know,_9853,fin),_9882,_9871,_9873).

kan([kan,lit(kan)],_9867,_9869) --> 
    cc(kan,_9867,_9869).

paabadet0([paabadet0,_9889,lit(badet),!,_9934],_9878,_9880) --> 
    prep1(on,_9889,_9878,_9906),
    cc(badet,_9906,_9928),
    !,
    accept(_9934,_9928,_9880).

paabadet0([paabadet0,[]],_9865,_9865) --> 
    [].

quit(thanks,[quit,_9901,_9930,!],_9887,_9889) --> 
    w(adj2(good,nil),_9901,_9887,_9918),
    w(noun(trip,sin,u,n),_9930,_9918,_9889),
    !.

quit(bye,[quit,_9892,_9921],_9878,_9880) --> 
    w(verb(hear,pres,pass),_9892,_9878,_9909),
    skip_rest(_9921,_9909,_9880).

quit(bye,[quit,_9892,_9921],_9878,_9880) --> 
    w(verb(see,pres,pass),_9892,_9878,_9909),
    skip_rest(_9921,_9909,_9880).

quit(bye,[quit,_9892,_9921],_9878,_9880) --> 
    w(verb(tals,pres,pass),_9892,_9878,_9909),
    skip_rest(_9921,_9909,_9880).

quit(bye,[quit,lit(med),lit(vennlig),_9925,_9954],_9889,_9891) --> 
    cc(med,_9889,_9913),
    cc(vennlig,_9913,_9924),
    w(noun(greeting,_9868,_9869,_9870),_9925,_9924,_9942),
    skip_rest(_9954,_9942,_9891).

quit(bye,[quit,lit(vennlig),_9909,_9938],_9884,_9886) --> 
    cc(vennlig,_9884,_9908),
    w(noun(greeting,_9863,_9864,_9865),_9909,_9908,_9926),
    skip_rest(_9938,_9926,_9886).

quit(bye,[quit,_9893,_9922],_9879,_9881) --> 
    w(noun(greeting,_9858,_9859,_9860),_9893,_9879,_9910),
    skip_rest(_9922,_9910,_9881).

quit(bye,[quit,_9890],_9876,_9878) --> 
    w(noun(midnight,plu,def,n),_9890,_9876,_9878).

quit(bye,[quit,lit(jeg),lit(snakkes),_9915],_9879,_9881) --> 
    cc(jeg,_9879,_9903),
    cc(snakkes,_9903,_9914),
    skip_rest(_9915,_9914,_9881).

quit(bye,[quit,_9889],_9875,_9877) --> 
    w(verb(stop,imp,_9856),_9889,_9875,_9877).

quit(bye,[quit,lit('adjø')],_9871,_9873) --> 
    cc('adjø',_9871,_9873).

quit(bye,[quit,lit('på'),lit(gjensyn)],_9876,_9878) --> 
    cc('på',_9876,_9900),
    cc(gjensyn,_9900,_9878).

quit(bye,[quit,_9883],_9869,_9871) --> 
    hadet(_9883,_9869,_9871).

quit(bye,[quit,_9886,_9910],_9872,_9874) --> 
    hadet(_9886,_9872,_9901),
    godt(_9910,_9901,_9874).

quit(bye,[quit,lit(hei),lit(da)],_9876,_9878) --> 
    cc(hei,_9876,_9900),
    cc(da,_9900,_9878).

quit(bye,[quit,lit(godnatt)],_9871,_9873) --> 
    cc(godnatt,_9871,_9873).

quit(bye,[quit,_9912,_9936,_9960,{}],_9898,_9900) --> 
    haen0(_9912,_9898,_9927),
    godt(_9936,_9927,_9951),
    w(noun(_9863,_9877,_9878,_9879),_9960,_9951,_9900),
    {user:testmember(_9863,[midnight,weekend,easter,summer])}.

quit(bye,[quit,lit(takk),_9916,_9945,_9974],_9891,_9893) --> 
    cc(takk,_9891,_9915),
    prep1(for,_9916,_9915,_9933),
    prep1(in,_9945,_9933,_9962),
    w(noun(day,sin,u,n),_9974,_9962,_9893).

quit(bye,[quit,_9902,_9926,_9955],_9888,_9890) --> 
    good0(_9902,_9888,_9917),
    w(noun(greeting,_9867,_9868,_9869),_9926,_9917,_9943),
    w(name(_9860,_9861,_9862),_9955,_9943,_9890).

quit(bye,[quit,_9903,_9927,_9956],_9889,_9891) --> 
    good0(_9903,_9889,_9918),
    w(noun(greeting,_9868,_9869,_9870),_9927,_9918,_9944),
    w(noun(_9860,_9861,_9862,_9863),_9956,_9944,_9891).

quit(bye,[quit,lit(far),lit(vel)],_9876,_9878) --> 
    cc(far,_9876,_9900),
    cc(vel,_9900,_9878).

quit(bye,[quit,_9912,_9956,lit(en),_9996,_10020],_9898,_9900) --> 
    optional(hello,_9912,_9898,_9944),
    w(verb(have,imp,_9877),_9956,_9944,_9973),
    cc(en,_9973,_9995),
    godt(_9996,_9995,_10011),
    w(noun(_9866,_9867,_9868,_9869),_10020,_10011,_9900).

quit(you_are_welcome,[quit,lit('på'),lit('forhånd'),_9918,!],_9882,_9884) --> 
    cc('på',_9882,_9906),
    cc('forhånd',_9906,_9917),
    thanks(_9918,_9917,_9884),
    !.

quit(you_are_welcome,[quit,_9894,_9923,!],_9880,_9882) --> 
    w(nb(1000,_9861),_9894,_9880,_9911),
    thanks(_9923,_9911,_9882),
    !.

quit(you_are_welcome,[quit,_9886,_9910],_9872,_9874) --> 
    thanks(_9886,_9872,_9901),
    alot(_9910,_9901,_9874).

quit(you_are_welcome,[quit,_9912,lit('å'),_9952,_9981,lit(deg)],_9898,_9900) --> 
    w(adj2(nice,nil),_9912,_9898,_9929),
    cc('å',_9929,_9951),
    w(verb(speak,_9876,_9877),_9952,_9951,_9969),
    prep1(with,_9981,_9969,_9998),
    cc(deg,_9998,_9900).

quit(merry_christmas,[quit,_9888,lit(jul)],_9874,_9876) --> 
    godt(_9888,_9874,_9903),
    cc(jul,_9903,_9876).

quit(happy_new_year,[quit,_9886,_9910],_9872,_9874) --> 
    godt(_9886,_9872,_9901),
    newyear(_9910,_9901,_9874).

quit(bye,[quit,lit(hilsen),_9899],_9874,_9876) --> 
    cc(hilsen,_9874,_9898),
    skip_rest(_9899,_9898,_9876).

alot([alot,[]],_9865,_9865) --> 
    [].

alot([alot,lit('så'),lit(mye)],_9872,_9874) --> 
    cc('så',_9872,_9893),
    cc(mye,_9893,_9874).

alot([alot,lit('så'),lit(meget)],_9872,_9874) --> 
    cc('så',_9872,_9893),
    cc(meget,_9893,_9874).

alot([alot,lit(skal),lit(du),_9914],_9881,_9883) --> 
    cc(skal,_9881,_9902),
    cc(du,_9902,_9913),
    w(verb(have,inf,fin),_9914,_9913,_9883).

godt([godt,_9881],_9870,_9872) --> 
    w(adj2(good,nil),_9881,_9870,_9872).

godt([godt,_9882],_9871,_9873) --> 
    w(verb(go,past,part),_9882,_9871,_9873).

godt([godt,_9891,_9920],_9880,_9882) --> 
    w(adj2(good,nil),_9891,_9880,_9908),
    w(noun(day,sin,u,n),_9920,_9908,_9882).

deter0([deter0,_9882,!,_9911],_9871,_9873) --> 
    deter(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

deter0([deter0,_9882,!,_9911],_9871,_9873) --> 
    endofline(_9882,_9871,_9897),
    !,
    reject(_9911,_9897,_9873).

deter0([deter0,[]],_9865,_9865) --> 
    [].

deter([deter,lit(det),_9898,!,_9927],_9876,_9878) --> 
    cc(det,_9876,_9897),
    be(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

deter([deter,lit(dette),_9898,!,_9927],_9876,_9878) --> 
    cc(dette,_9876,_9897),
    be(_9898,_9897,_9913),
    !,
    accept(_9927,_9913,_9878).

haen0([haen0,lit(ha),lit(en),!,_9916],_9878,_9880) --> 
    cc(ha,_9878,_9899),
    cc(en,_9899,_9910),
    !,
    accept(_9916,_9910,_9880).

haen0([haen0,[]],_9865,_9865) --> 
    [].

personal('Takk',[personal,lit(velkommen),lit(til),!,_9923],_9882,_9884) --> 
    cc(velkommen,_9882,_9906),
    cc(til,_9906,_9917),
    !,
    skip_rest(_9923,_9917,_9884).

personal('Takk',[personal,lit(velkommen)],_9871,_9873) --> 
    cc(velkommen,_9871,_9873).

personal('Takk',[personal,lit(god),_9906],_9881,_9883) --> 
    cc(god,_9881,_9905),
    w(noun(health,sin,u,n),_9906,_9905,_9883).

personal('OK',[personal,lit(ps)],_9871,_9873) --> 
    cc(ps,_9871,_9873).

personal('OK',[personal,_9891,_9935,_9959],_9877,_9879) --> 
    optional(hello,_9891,_9877,_9923),
    so0(_9935,_9923,_9950),
    persok(_9959,_9950,_9879).

persok([persok,_9876],_9865,_9867) --> 
    okeys(_9876,_9865,_9867).

persok([persok,_9882],_9871,_9873) --> 
    w(verb(test,imp,fin),_9882,_9871,_9873).

persok([persok,lit(bra),_9892],_9870,_9872) --> 
    cc(bra,_9870,_9891),
    endofline(_9892,_9891,_9872).

persok([persok,lit(sorry)],_9867,_9869) --> 
    cc(sorry,_9867,_9869).

persok([persok,_9895,lit('så'),_9935],_9884,_9886) --> 
    w(verb(be,imp,fin),_9895,_9884,_9912),
    cc('så',_9912,_9934),
    w(adj2(good,nil),_9935,_9934,_9886).

persok([persok,_9887,lit(det)],_9876,_9878) --> 
    w(verb(forget,imp,fin),_9887,_9876,_9904),
    cc(det,_9904,_9878).

persok([persok,_9891,_9920],_9880,_9882) --> 
    w(verb(forget,imp,fin),_9891,_9880,_9908),
    np(_9853,_9856:_9857,_9920,_9908,_9882).

persok([persok,_9893,lit(du),_9933,_9957],_9882,_9884) --> 
    w(verb(be,_9862,fin),_9893,_9882,_9910),
    cc(du,_9910,_9932),
    good(_9933,_9932,_9948),
    dadanow0(_9957,_9948,_9884).

persok([persok,lit(unnskyld)],_9867,_9869) --> 
    cc(unnskyld,_9867,_9869).

persok([persok,lit(hvordan),_9911,lit(du),lit(det),_9962],_9889,_9891) --> 
    cc(hvordan,_9889,_9910),
    w(verb(have,_9867,fin),_9911,_9910,_9928),
    cc(du,_9928,_9950),
    cc(det,_9950,_9961),
    dadanow0(_9962,_9961,_9891).

persok([persok,lit(hvordan),_9914,lit(det),_9954,_9983,_10007],_9892,_9894) --> 
    cc(hvordan,_9892,_9913),
    w(verb(stand,pres,fin),_9914,_9913,_9931),
    cc(det,_9931,_9953),
    prep1(to,_9954,_9953,_9971),
    withyou0(_9983,_9971,_9998),
    dadanow0(_10007,_9998,_9894).

persok([persok,_9906,lit(det),_9946,_9975,_10004,_10028],_9895,_9897) --> 
    w(verb(stand,pres,fin),_9906,_9895,_9923),
    cc(det,_9923,_9945),
    w(adj2(good,nil),_9946,_9945,_9963),
    prep1(to,_9975,_9963,_9992),
    withyou0(_10004,_9992,_10019),
    dadanow0(_10028,_10019,_9897).

persok([persok,_9887,_9916],_9876,_9878) --> 
    w(verb(stand,pres,fin),_9887,_9876,_9904),
    prep1(to,_9916,_9904,_9878).

persok([persok,lit(hvordan),_9902,_9926],_9880,_9882) --> 
    cc(hvordan,_9880,_9901),
    be(_9902,_9901,_9917),
    w(noun(situation,sin,def,n),_9926,_9917,_9882).

persok([persok,lit(hva),_9902,_9926],_9880,_9882) --> 
    cc(hva,_9880,_9901),
    be(_9902,_9901,_9917),
    w(noun(situation,sin,def,n),_9926,_9917,_9882).

persok([persok,_9903,lit(du),lit(det),_9954,_9983],_9892,_9894) --> 
    w(verb(have,_9865,fin),_9903,_9892,_9920),
    cc(du,_9920,_9942),
    cc(det,_9942,_9953),
    w(adj2(_9874,nil),_9954,_9953,_9971),
    dadanow0(_9983,_9971,_9894).

persok([persok,lit(jeg),_9917,lit(det),_9957,_9986,_10010,_10034],_9895,_9897) --> 
    cc(jeg,_9895,_9916),
    w(verb(have,_9873,fin),_9917,_9916,_9934),
    cc(det,_9934,_9956),
    negation0(_9878,_9957,_9956,_9974),
    so0(_9986,_9974,_10001),
    good(_10010,_10001,_10025),
    dadanow0(_10034,_10025,_9897).

persok([persok,lit(hvordan),_9909,lit(det),_9949,_9973],_9887,_9889) --> 
    cc(hvordan,_9887,_9908),
    w(verb(go,pres,fin),_9909,_9908,_9926),
    cc(det,_9926,_9948),
    withyou0(_9949,_9948,_9964),
    dadanow0(_9973,_9964,_9889).

persok([persok,_9908,lit(det),_9948,_9992,_10021,_10045],_9897,_9899) --> 
    w(verb(go,pres,fin),_9908,_9897,_9925),
    cc(det,_9925,_9947),
    optional([ikke],_9948,_9947,_9980),
    w(adj2(good,nil),_9992,_9980,_10009),
    withyou0(_10021,_10009,_10036),
    dadanow0(_10045,_10036,_9899).

persok([persok,lit(greitt)],_9867,_9869) --> 
    cc(greitt,_9867,_9869).

persok([persok,_9884,_9913],_9873,_9875) --> 
    w(adj2(good,nil),_9884,_9873,_9901),
    endofline(_9913,_9901,_9875).

thanks([thanks,_9885,_9909,_9933,_9957],_9874,_9876) --> 
    ogmen0(_9885,_9874,_9900),
    thousands0(_9909,_9900,_9924),
    takk(_9933,_9924,_9948),
    forhjelpen0(_9957,_9948,_9876).

takk([takk,_9881,lit(takk)],_9870,_9872) --> 
    hellos0(_9881,_9870,_9896),
    cc(takk,_9896,_9872).

takk([takk,_9882],_9871,_9873) --> 
    w(verb(thank,pres,fin),_9882,_9871,_9873).

takk([takk,lit(jeg),lit(vil),_9914],_9881,_9883) --> 
    cc(jeg,_9881,_9902),
    cc(vil,_9902,_9913),
    w(verb(thank,inf,_9860),_9914,_9913,_9883).

ogmen0([ogmen0,lit(og),!,_9900],_9873,_9875) --> 
    cc(og,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

ogmen0([ogmen0,lit(men),!,_9900],_9873,_9875) --> 
    cc(men,_9873,_9894),
    !,
    accept(_9900,_9894,_9875).

ogmen0([ogmen0,[]],_9865,_9865) --> 
    [].

thousands0([thousands0,_9882,!,_9911],_9871,_9873) --> 
    thousand(_9882,_9871,_9897),
    !,
    thousands0(_9911,_9897,_9873).

thousands0([thousands0,[]],_9865,_9865) --> 
    [].

thousand0([thousand0,_9882,!,_9911],_9871,_9873) --> 
    thousand(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

thousand0([thousand0,[]],_9865,_9865) --> 
    [].

thousand([thousand,_9887,!,_9921],_9876,_9878) --> 
    number(1000:_9859,_9887,_9876,_9904),
    !,
    accept(_9921,_9904,_9878).

thousand([thousand,_9876],_9865,_9867) --> 
    many1(_9876,_9865,_9867).

withyou0([withyou0,_9889,lit(_9860),!,_9934],_9878,_9880) --> 
    prep1(with,_9889,_9878,_9906),
    cc(_9860,_9906,_9928),
    !,
    accept(_9934,_9928,_9880).

withyou0([withyou0,[]],_9865,_9865) --> 
    [].

dadanow0([dadanow0,_9879,_9903],_9868,_9870) --> 
    todax(_9879,_9868,_9894),
    danow0(_9903,_9894,_9870).

dadanow0([dadanow0,_9876],_9865,_9867) --> 
    danow0(_9876,_9865,_9867).

danow0([danow0,_9891,_9920,lit('nå'),!],_9880,_9882) --> 
    look_ahead(['nå'],_9891,_9880,_9908),
    notreachphrase(_9920,_9908,_9935),
    cc('nå',_9935,_9882),
    !.

danow0([danow0,[]],_9865,_9865) --> 
    [].

notreachphrase([notreachphrase,_9882,!,_9911],_9871,_9873) --> 
    reachphrase(_9882,_9871,_9897),
    !,
    reject(_9911,_9897,_9873).

notreachphrase([notreachphrase,[]],_9865,_9865) --> 
    [].

reachphrase([reachphrase,_9888,_9917,!],_9877,_9879) --> 
    w(verb(reach,inf,fin),_9888,_9877,_9905),
    look_ahead_np(_9917,_9905,_9879),
    !.

danow0([danow0,_9879,!],_9868,_9870) --> 
    danow(_9879,_9868,_9870),
    !.

danow0([danow0,[]],_9865,_9865) --> 
    [].

danow([danow,_9886,_9915,!],_9875,_9877) --> 
    w(adv(now),_9886,_9875,_9903),
    danow(_9915,_9903,_9877),
    !.

danow([danow,_9880],_9869,_9871) --> 
    w(adv(now),_9880,_9869,_9871).

danow([danow,lit(da),_9892],_9870,_9872) --> 
    cc(da,_9870,_9891),
    danow(_9892,_9891,_9872).

todax([todax,_9882,!,_9911],_9871,_9873) --> 
    today(_9882,_9871,_9897),
    !,
    accept(_9911,_9897,_9873).

todax([todax,_9889,lit('går'),!,_9934],_9878,_9880) --> 
    prep1(in,_9889,_9878,_9906),
    cc('går',_9906,_9928),
    !,
    accept(_9934,_9928,_9880).

good0([good0,_9885,_9909,!,_9938],_9874,_9876) --> 
    so0(_9885,_9874,_9900),
    good(_9909,_9900,_9924),
    !,
    accept(_9938,_9924,_9876).

good0([good0,[]],_9865,_9865) --> 
    [].

good([good,_9881],_9870,_9872) --> 
    w(adj2(good,nil),_9881,_9870,_9872).

good([good,_9881],_9870,_9872) --> 
    w(adj2(clever,nil),_9881,_9870,_9872).

good([good,_9881],_9870,_9872) --> 
    w(adj2(fast,nil),_9881,_9870,_9872).

good([good,_9881],_9870,_9872) --> 
    w(adj2(funny,nil),_9881,_9870,_9872).

good([good,_9881],_9870,_9872) --> 
    w(adj2(honest,nil),_9881,_9870,_9872).

good([good,_9881],_9870,_9872) --> 
    w(adj2(nice,nil),_9881,_9870,_9872).

good([good,_9876],_9865,_9867) --> 
    okeys(_9876,_9865,_9867).

gmem(_9850,_9851,[gmem,{}],_9877,_9877) --> 
    {user:testmember(_9850,_9851)}.

panic(_9850,[panic,{}],_9873,_9873) --> 
    {user:write(_9850)}.

traceprint(_9850,_9851,[traceprint,{}],_9877,_9877) --> 
    {user:traceprint(_9850,_9851)}.

% Auxillary tables created datetime(2012,1,20,11,11,16)

%% Automatically created by metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

optional(itrailer,[optional,_10101,!],_10087,_10089) --> 
    itrailer(_10101,_10087,_10089),
    !.

optional([kanskje],[optional,lit(kanskje),!],_10089,_10091) --> 
    cc(kanskje,_10089,_10091),
    !.

optional([at],[optional,lit(at),!],_10089,_10091) --> 
    cc(at,_10089,_10091),
    !.

optional(grums,[optional,_10101,!],_10087,_10089) --> 
    grums(_10101,_10087,_10089),
    !.

optional(grums,[optional,_10101,!],_10087,_10089) --> 
    grums(_10101,_10087,_10089),
    !.

optional([ofte],[optional,lit(ofte),!],_10089,_10091) --> 
    cc(ofte,_10089,_10091),
    !.

optional([som],[optional,lit(som),!],_10089,_10091) --> 
    cc(som,_10089,_10091),
    !.

optional([','],[optional,lit(','),!],_10089,_10091) --> 
    cc(',',_10089,_10091),
    !.

optional([at],[optional,lit(at),!],_10089,_10091) --> 
    cc(at,_10089,_10091),
    !.

optional([meget],[optional,lit(meget),!],_10089,_10091) --> 
    cc(meget,_10089,_10091),
    !.

optional([det],[optional,lit(det),!],_10089,_10091) --> 
    cc(det,_10089,_10091),
    !.

optional(['å'],[optional,lit('å'),!],_10089,_10091) --> 
    cc('å',_10089,_10091),
    !.

optional(['å'],[optional,lit('å'),!],_10089,_10091) --> 
    cc('å',_10089,_10091),
    !.

optional([an],[optional,lit(an),!],_10089,_10091) --> 
    cc(an,_10089,_10091),
    !.

optional([ut],[optional,lit(ut),!],_10089,_10091) --> 
    cc(ut,_10089,_10091),
    !.

optional([neste],[optional,lit(neste),!],_10089,_10091) --> 
    cc(neste,_10089,_10091),
    !.

optional([det],[optional,lit(det),!],_10089,_10091) --> 
    cc(det,_10089,_10091),
    !.

optional(itrailer,[optional,_10101,!],_10087,_10089) --> 
    itrailer(_10101,_10087,_10089),
    !.

optional(itrailer,[optional,_10101,!],_10087,_10089) --> 
    itrailer(_10101,_10087,_10089),
    !.

optional([alle],[optional,lit(alle),!],_10089,_10091) --> 
    cc(alle,_10089,_10091),
    !.

optional([at],[optional,lit(at),!],_10089,_10091) --> 
    cc(at,_10089,_10091),
    !.

optional([som],[optional,lit(som),!],_10089,_10091) --> 
    cc(som,_10089,_10091),
    !.

optional([gang],[optional,lit(gang),!],_10089,_10091) --> 
    cc(gang,_10089,_10091),
    !.

optional(much,[optional,_10101,!],_10087,_10089) --> 
    much(_10101,_10087,_10089),
    !.

optional(w(verb(be,inf,fin)),[optional,_10107,!],_10093,_10095) --> 
    w(verb(be,inf,fin),_10107,_10093,_10095),
    !.

optional(w(adj2(old,nil)),[optional,_10106,!],_10092,_10094) --> 
    w(adj2(old,nil),_10106,_10092,_10094),
    !.

optional([om],[optional,lit(om),!],_10089,_10091) --> 
    cc(om,_10089,_10091),
    !.

optional([for],[optional,lit(for),!],_10089,_10091) --> 
    cc(for,_10089,_10091),
    !.

optional(['på'],[optional,lit('på'),!],_10089,_10091) --> 
    cc('på',_10089,_10091),
    !.

optional([om],[optional,lit(om),!],_10089,_10091) --> 
    cc(om,_10089,_10091),
    !.

optional(['på'],[optional,lit('på'),!],_10089,_10091) --> 
    cc('på',_10089,_10091),
    !.

optional([om],[optional,lit(om),!],_10089,_10091) --> 
    cc(om,_10089,_10091),
    !.

optional(['å'],[optional,lit('å'),!],_10089,_10091) --> 
    cc('å',_10089,_10091),
    !.

optional(['på'],[optional,lit('på'),!],_10089,_10091) --> 
    cc('på',_10089,_10091),
    !.

optional(['på'],[optional,lit('på'),!],_10089,_10091) --> 
    cc('på',_10089,_10091),
    !.

optional(['å'],[optional,lit('å'),!],_10089,_10091) --> 
    cc('å',_10089,_10091),
    !.

optional([til],[optional,lit(til),!],_10089,_10091) --> 
    cc(til,_10089,_10091),
    !.

optional([da],[optional,lit(da),!],_10089,_10091) --> 
    cc(da,_10089,_10091),
    !.

optional([bare],[optional,lit(bare),!],_10089,_10091) --> 
    cc(bare,_10089,_10091),
    !.

optional(w(prep(_10070)),[optional,_10105,!],_10091,_10093) --> 
    w(prep(_10070),_10105,_10091,_10093),
    !.

optional([til],[optional,lit(til),!],_10089,_10091) --> 
    cc(til,_10089,_10091),
    !.

optional([med],[optional,lit(med),!],_10089,_10091) --> 
    cc(med,_10089,_10091),
    !.

optional(['på'],[optional,lit('på'),!],_10089,_10091) --> 
    cc('på',_10089,_10091),
    !.

optional(w(noun(year,_10071,_10072,n)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(year,_10071,_10072,n),_10108,_10094,_10096),
    !.

optional(w(prep(in)),[optional,_10105,!],_10091,_10093) --> 
    w(prep(in),_10105,_10091,_10093),
    !.

optional(w(noun(year,sin,u,n)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(year,sin,u,n),_10108,_10094,_10096),
    !.

optional([i],[optional,lit(i),!],_10089,_10091) --> 
    cc(i,_10089,_10091),
    !.

optional([i],[optional,lit(i),!],_10089,_10091) --> 
    cc(i,_10089,_10091),
    !.

optional([i],[optional,lit(i),!],_10089,_10091) --> 
    cc(i,_10089,_10091),
    !.

optional(['.'],[optional,lit('.'),!],_10089,_10091) --> 
    cc('.',_10089,_10091),
    !.

optional(w(noun(time,sin,def,n)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(time,sin,def,n),_10108,_10094,_10096),
    !.

optional(['nå'],[optional,lit('nå'),!],_10089,_10091) --> 
    cc('nå',_10089,_10091),
    !.

optional([denne],[optional,lit(denne),!],_10089,_10091) --> 
    cc(denne,_10089,_10091),
    !.

optional(w(noun(route,sin,u,n)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(route,sin,u,n),_10108,_10094,_10096),
    !.

optional(w(noun(route,sin,u,n)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(route,sin,u,n),_10108,_10094,_10096),
    !.

optional(w(noun(bus,sin,_10072,_10073)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(bus,sin,_10072,_10073),_10108,_10094,_10096),
    !.

optional([for],[optional,lit(for),!],_10089,_10091) --> 
    cc(for,_10089,_10091),
    !.

optional([til],[optional,lit(til),!],_10089,_10091) --> 
    cc(til,_10089,_10091),
    !.

optional([av],[optional,lit(av),!],_10089,_10091) --> 
    cc(av,_10089,_10091),
    !.

optional(w(noun(time,sin,def,n)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(time,sin,def,n),_10108,_10094,_10096),
    !.

optional(w(noun(time,sin,def,n)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(time,sin,def,n),_10108,_10094,_10096),
    !.

optional(w(noun(time,_10071,def,_10073)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(time,_10071,def,_10073),_10108,_10094,_10096),
    !.

optional(w(prep(in)),[optional,_10105,!],_10091,_10093) --> 
    w(prep(in),_10105,_10091,_10093),
    !.

optional(w(noun(time,sin,def,n)),[optional,_10108,!],_10094,_10096) --> 
    w(noun(time,sin,def,n),_10108,_10094,_10096),
    !.

optional([h],[optional,lit(h),!],_10089,_10091) --> 
    cc(h,_10089,_10091),
    !.

optional([opp],[optional,lit(opp),!],_10089,_10091) --> 
    cc(opp,_10089,_10091),
    !.

optional([om],[optional,lit(om),!],_10089,_10091) --> 
    cc(om,_10089,_10091),
    !.

optional([mye],[optional,lit(mye),!],_10089,_10091) --> 
    cc(mye,_10089,_10091),
    !.

optional([nr],[optional,lit(nr),!],_10089,_10091) --> 
    cc(nr,_10089,_10091),
    !.

optional([slik],[optional,lit(slik),!],_10089,_10091) --> 
    cc(slik,_10089,_10091),
    !.

optional(['så'],[optional,lit('så'),!],_10089,_10091) --> 
    cc('så',_10089,_10091),
    !.

optional(be,[optional,_10101,!],_10087,_10089) --> 
    be(_10101,_10087,_10089),
    !.

optional([at],[optional,lit(at),!],_10089,_10091) --> 
    cc(at,_10089,_10091),
    !.

optional([at],[optional,lit(at),!],_10089,_10091) --> 
    cc(at,_10089,_10091),
    !.

optional([seg],[optional,lit(seg),!],_10089,_10091) --> 
    cc(seg,_10089,_10091),
    !.

optional([at],[optional,lit(at),!],_10089,_10091) --> 
    cc(at,_10089,_10091),
    !.

optional(w(adj2(great,nil)),[optional,_10106,!],_10092,_10094) --> 
    w(adj2(great,nil),_10106,_10092,_10094),
    !.

optional(w(adj2(_10070,nil)),[optional,_10106,!],_10092,_10094) --> 
    w(adj2(_10070,nil),_10106,_10092,_10094),
    !.

optional(w(adj2(_10070,nil)),[optional,_10106,!],_10092,_10094) --> 
    w(adj2(_10070,nil),_10106,_10092,_10094),
    !.

optional(w(adj2(_10070,nil)),[optional,_10106,!],_10092,_10094) --> 
    w(adj2(_10070,nil),_10106,_10092,_10094),
    !.

optional([med],[optional,lit(med),!],_10089,_10091) --> 
    cc(med,_10089,_10091),
    !.

optional(sometimes,[optional,_10101,!],_10087,_10089) --> 
    sometimes(_10101,_10087,_10089),
    !.

optional([ofte],[optional,lit(ofte),!],_10089,_10091) --> 
    cc(ofte,_10089,_10091),
    !.

optional([bare],[optional,lit(bare),!],_10089,_10091) --> 
    cc(bare,_10089,_10091),
    !.

optional(grums,[optional,_10101,!],_10087,_10089) --> 
    grums(_10101,_10087,_10089),
    !.

optional(grums,[optional,_10101,!],_10087,_10089) --> 
    grums(_10101,_10087,_10089),
    !.

optional([for],[optional,lit(for),!],_10089,_10091) --> 
    cc(for,_10089,_10091),
    !.

optional([:],[optional,lit(:),!],_10089,_10091) --> 
    cc(:,_10089,_10091),
    !.

optional([:],[optional,lit(:),!],_10089,_10091) --> 
    cc(:,_10089,_10091),
    !.

optional([ja],[optional,lit(ja),!],_10089,_10091) --> 
    cc(ja,_10089,_10091),
    !.

optional([men],[optional,lit(men),!],_10089,_10091) --> 
    cc(men,_10089,_10091),
    !.

optional(paadeg,[optional,_10101,!],_10087,_10089) --> 
    paadeg(_10101,_10087,_10089),
    !.

optional(hello,[optional,_10101,!],_10087,_10089) --> 
    hello(_10101,_10087,_10089),
    !.

optional(hello,[optional,_10101,!],_10087,_10089) --> 
    hello(_10101,_10087,_10089),
    !.

optional([ikke],[optional,lit(ikke),!],_10089,_10091) --> 
    cc(ikke,_10089,_10091),
    !.

optional(_10061,[],_9841,_9841) --> 
    [].

xnp(_10223,_10224,[xnp,_10266],_10249,_10251) --> 
    virtual(xnp(_10223,_10224),_10266,_10249,_10251).

negation(_10223,[negation,_10260],_10246,_10248) --> 
    virtual(negation(_10223),_10260,_10246,_10248).

aux1([aux1,_10253],_10242,_10244) --> 
    virtual(aux1,_10253,_10242,_10244).

adverbial1(_10223,_10224,_10225,[adverbial1,_10272],_10252,_10254) --> 
    virtual(adverbial1(_10223,_10224,_10225),_10272,_10252,_10254).

xadverbial1(_10223,_10224,_10225,[xadverbial1,_10272],_10252,_10254) --> 
    virtual(xadverbial1(_10223,_10224,_10225),_10272,_10252,_10254).

subordinate(in_order_to,_10224,_10225,[subordinate,_10272],_10252,_10254) --> 
    virtual(subordinate(in_order_to,_10224,_10225),_10272,_10252,_10254).

subordinate(_10223,_10224,_10225,[subordinate,_10272],_10252,_10254) --> 
    virtual(subordinate(_10223,_10224,_10225),_10272,_10252,_10254).

adj1(_10223,_10228:_10229,_10225,_10226,[adj1,_10281],_10258,_10260) --> 
    virtual(adj1(_10223,_10228:_10229,_10225,_10226),_10281,_10258,_10260).

someone([someone,_10253],_10242,_10244) --> 
    virtual(someone,_10253,_10242,_10244).

obviousdate1(_10223,_10224,[obviousdate1,_10266],_10249,_10251) --> 
    virtual(obviousdate1(_10223,_10224),_10266,_10249,_10251).

np_kernel(0,_10224,_10225,[np_kernel,_10272],_10252,_10254) --> 
    virtual(np_kernel(0,_10224,_10225),_10272,_10252,_10254).

xnp(_10223,_10226::_10227,[xnp,_10269],_10252,_10254) --> 
    virtual(xnp(_10223,_10226::_10227),_10269,_10252,_10254).

pp(_10223,_10224,_10225,[pp,_10272],_10252,_10254) --> 
    virtual(pp(_10223,_10224,_10225),_10272,_10252,_10254).

np(_10223,_10224,[np,_10266],_10249,_10251) --> 
    virtual(np(_10223,_10224),_10266,_10249,_10251).

prep(to,[prep,_10260],_10246,_10248) --> 
    virtual(prep(to),_10260,_10246,_10248).

prep(_10223,[prep,_10260],_10246,_10248) --> 
    virtual(prep(_10223),_10260,_10246,_10248).

noun_phrase1(_10223,_10224,[noun_phrase1,_10266],_10249,_10251) --> 
    virtual(noun_phrase1(_10223,_10224),_10266,_10249,_10251).

xadverb(_10223,_10224,[xadverb,_10266],_10249,_10251) --> 
    virtual(xadverb(_10223,_10224),_10266,_10249,_10251).

np(_10223,_10226::_10227,[np,_10269],_10252,_10254) --> 
    virtual(np(_10223,_10226::_10227),_10269,_10252,_10254).

be(_10223,[be,_10260],_10246,_10248) --> 
    virtual(be(_10223),_10260,_10246,_10248).

thereit([thereit,_10253],_10242,_10244) --> 
    virtual(thereit,_10253,_10242,_10244).

be([be,_10253],_10242,_10244) --> 
    virtual(be,_10253,_10242,_10244).

adverbial1(_10223,_10224,_10227::_10228,[adverbial1,_10275],_10255,_10257) --> 
    virtual(adverbial1(_10223,_10224,_10227::_10228),_10275,_10255,_10257).

lexv(_10223,_10224,_10225,fin,[lexv,_10278],_10255,_10257) --> 
    virtual(lexv(_10223,_10224,_10225,fin),_10278,_10255,_10257).

ap(_10223,_10224,_10225,_10226,[ap,_10278],_10255,_10257) --> 
    virtual(ap(_10223,_10224,_10225,_10226),_10278,_10255,_10257).

adj1(_10223,_10224,_10225,_10226,[adj1,_10278],_10255,_10257) --> 
    virtual(adj1(_10223,_10224,_10225,_10226),_10278,_10255,_10257).

\(state(_10226,_10227),(xnp(_10232,_10233),w(verb(be,_10241,fin)),w(adj2(_10246,nil))),[\,_10289],_10272,_10274) --> 
    virtual(state(_10226,_10227)\(xnp(_10232,_10233),w(verb(be,_10241,fin)),w(adj2(_10246,nil))),_10289,_10272,_10274).

something([something,_10253],_10242,_10244) --> 
    virtual(something,_10253,_10242,_10244).

lexv(iv,_10224,pres,fin,[lexv,_10278],_10255,_10257) --> 
    virtual(lexv(iv,_10224,pres,fin),_10278,_10255,_10257).

np1(_10223,_10224,[np1,_10266],_10249,_10251) --> 
    virtual(np1(_10223,_10224),_10266,_10249,_10251).

adverbial(_10223,_10224,_10227::_10228,[adverbial,_10275],_10255,_10257) --> 
    virtual(adverbial(_10223,_10224,_10227::_10228),_10275,_10255,_10257).

lexv(iv,_10224,_10225,fin,[lexv,_10278],_10255,_10257) --> 
    virtual(lexv(iv,_10224,_10225,fin),_10278,_10255,_10257).

the([the,_10253],_10242,_10244) --> 
    virtual(the,_10253,_10242,_10244).

nameq1(_10226:person,_10224,[nameq1,_10269],_10252,_10254) --> 
    virtual(nameq1(_10226:person,_10224),_10269,_10252,_10254).

obviousclock1(_10226:clock,_10226 isa clock,[obviousclock1,_10272],_10255,_10257) --> 
    virtual(obviousclock1(_10226:clock,_10226 isa clock),_10272,_10255,_10257).

whatbe([whatbe,_10253],_10242,_10244) --> 
    virtual(whatbe,_10253,_10242,_10244).

obviousclock1(_10223,_10224,[obviousclock1,_10266],_10249,_10251) --> 
    virtual(obviousclock1(_10223,_10224),_10266,_10249,_10251).

pronoun(_10223,[pronoun,_10260],_10246,_10248) --> 
    virtual(pronoun(_10223),_10260,_10246,_10248).

noun_phrase1(_10223,_10226::_10227,[noun_phrase1,_10269],_10252,_10254) --> 
    virtual(noun_phrase1(_10223,_10226::_10227),_10269,_10252,_10254).

npgap(_10223,[npgap,_10260],_10246,_10248) --> 
    virtual(npgap(_10223),_10260,_10246,_10248).

npgap(_10225:thing,[npgap,_10263],_10249,_10251) --> 
    virtual(npgap(_10225:thing),_10263,_10249,_10251).

noun(_10223,_10224,_10225,_10226,_10227,_10228,[noun,_10290],_10261,_10263) --> 
    virtual(noun(_10223,_10224,_10225,_10226,_10227,_10228),_10290,_10261,_10263).

lexv(tv,_10224,_10225,fin,[lexv,_10278],_10255,_10257) --> 
    virtual(lexv(tv,_10224,_10225,fin),_10278,_10255,_10257).

which([which,_10253],_10242,_10244) --> 
    virtual(which,_10253,_10242,_10244).

np1(_10223,_10226::_10227,[np1,_10269],_10252,_10254) --> 
    virtual(np1(_10223,_10226::_10227),_10269,_10252,_10254).

lexv(tv,know1,_10225,fin,[lexv,_10278],_10255,_10257) --> 
    virtual(lexv(tv,know1,_10225,fin),_10278,_10255,_10257).

doit([doit,_10253],_10242,_10244) --> 
    virtual(doit,_10253,_10242,_10244).

xadverbial1(_10223,_10224,_10227::_10228,[xadverbial1,_10275],_10255,_10257) --> 
    virtual(xadverbial1(_10223,_10224,_10227::_10228),_10275,_10255,_10257).

prep(in,[prep,_10260],_10246,_10248) --> 
    virtual(prep(in),_10260,_10246,_10248).

adverbial1(in,_10224,_10227::_10228,[adverbial1,_10275],_10255,_10257) --> 
    virtual(adverbial1(in,_10224,_10227::_10228),_10275,_10255,_10257).

xadverbial1(in,_10224,_10227::_10228,[xadverbial1,_10275],_10255,_10257) --> 
    virtual(xadverbial1(in,_10224,_10227::_10228),_10275,_10255,_10257).

adverbial1(nil,_10224,_10227::_10228,[adverbial1,_10275],_10255,_10257) --> 
    virtual(adverbial1(nil,_10224,_10227::_10228),_10275,_10255,_10257).

prep(from,[prep,_10260],_10246,_10248) --> 
    virtual(prep(from),_10260,_10246,_10248).

who([who,_10253],_10242,_10244) --> 
    virtual(who,_10253,_10242,_10244).

a([a,_10253],_10242,_10244) --> 
    virtual(a,_10253,_10242,_10244).

noun(_10223,_10224,u,n,_10227,_10228,[noun,_10290],_10261,_10263) --> 
    virtual(noun(_10223,_10224,u,n,_10227,_10228),_10290,_10261,_10263).

that([that,_10253],_10242,_10244) --> 
    virtual(that,_10253,_10242,_10244).

xadverbial1(how,nil,_10227::_10227,[xadverbial1,_10275],_10255,_10257) --> 
    virtual(xadverbial1(how,nil,_10227::_10227),_10275,_10255,_10257).

prep(with,[prep,_10260],_10246,_10248) --> 
    virtual(prep(with),_10260,_10246,_10248).

xadverbial1(nil,_10224,_10225,[xadverbial1,_10272],_10252,_10254) --> 
    virtual(xadverbial1(nil,_10224,_10225),_10272,_10252,_10254).

the(_10223,[the,_10260],_10246,_10248) --> 
    virtual(the(_10223),_10260,_10246,_10248).

of([of,_10253],_10242,_10244) --> 
    virtual(of,_10253,_10242,_10244).

prep1(in,[prep1,_10260],_10246,_10248) --> 
    virtual(prep1(in),_10260,_10246,_10248).

number(_10223,[number,_10260],_10246,_10248) --> 
    virtual(number(_10223),_10260,_10246,_10248).

lexv(dtv,_10224,_10225,_10226,[lexv,_10278],_10255,_10257) --> 
    virtual(lexv(dtv,_10224,_10225,_10226),_10278,_10255,_10257).

negation0(_10223,[negation0,_10260],_10246,_10248) --> 
    virtual(negation0(_10223),_10260,_10246,_10248).

adverbx(_10223,_10224,_10225,[adverbx,_10272],_10252,_10254) --> 
    virtual(adverbx(_10223,_10224,_10225),_10272,_10252,_10254).

particle(_10223,[particle,_10260],_10246,_10248) --> 
    virtual(particle(_10223),_10260,_10246,_10248).

verb_mod1(_10223,_10224,_10225,_10226,_10229::_10230,[verb_mod1,_10287],_10261,_10263) --> 
    virtual(verb_mod1(_10223,_10224,_10225,_10226,_10229::_10230),_10287,_10261,_10263).

lexv(tv,_10224,pres,fin,[lexv,_10278],_10255,_10257) --> 
    virtual(lexv(tv,_10224,pres,fin),_10278,_10255,_10257).

prep1(_10223,[prep1,_10260],_10246,_10248) --> 
    virtual(prep1(_10223),_10260,_10246,_10248).

noun_phrase1(_10223,_10226:_10227,[noun_phrase1,_10269],_10252,_10254) --> 
    virtual(noun_phrase1(_10223,_10226:_10227),_10269,_10252,_10254).

lexv(_10223,know1,_10225,fin,[lexv,_10278],_10255,_10257) --> 
    virtual(lexv(_10223,know1,_10225,fin),_10278,_10255,_10257).

lexv(tv,_10224,past,fin,[lexv,_10278],_10255,_10257) --> 
    virtual(lexv(tv,_10224,past,fin),_10278,_10255,_10257).

this([this,_10253],_10242,_10244) --> 
    virtual(this,_10253,_10242,_10244).

adverbial1(_10223,_10227:_10228,_10225,[adverbial1,_10275],_10255,_10257) --> 
    virtual(adverbial1(_10223,_10227:_10228,_10225),_10275,_10255,_10257).

adverbial1(nil,_10227:coevent,_10225,[adverbial1,_10275],_10255,_10257) --> 
    virtual(adverbial1(nil,_10227:coevent,_10225),_10275,_10255,_10257).

xadverbial1(_10223,_10227:_10228,_10225,[xadverbial1,_10275],_10255,_10257) --> 
    virtual(xadverbial1(_10223,_10227:_10228,_10225),_10275,_10255,_10257).

adverb(_10223,_10224,_10225,[adverb,_10272],_10252,_10254) --> 
    virtual(adverb(_10223,_10224,_10225),_10272,_10252,_10254).

some([some,_10253],_10242,_10244) --> 
    virtual(some,_10253,_10242,_10244).

much([much,_10253],_10242,_10244) --> 
    virtual(much,_10253,_10242,_10244).

little([little,_10253],_10242,_10244) --> 
    virtual(little,_10253,_10242,_10244).

every([every,_10253],_10242,_10244) --> 
    virtual(every,_10253,_10242,_10244).

relpron(agent,[relpron,_10260],_10246,_10248) --> 
    virtual(relpron(agent),_10260,_10246,_10248).

relpron(thing,[relpron,_10260],_10246,_10248) --> 
    virtual(relpron(thing),_10260,_10246,_10248).

time1(_10223,[time1,_10260],_10246,_10248) --> 
    virtual(time1(_10223),_10260,_10246,_10248).

and1([and1,_10253],_10242,_10244) --> 
    virtual(and1,_10253,_10242,_10244).

thispron([thispron,_10253],_10242,_10244) --> 
    virtual(thispron,_10253,_10242,_10244).

clock_kernel(_10226:clock,_10226 isa clock,[clock_kernel,_10272],_10255,_10257) --> 
    virtual(clock_kernel(_10226:clock,_10226 isa clock),_10272,_10255,_10257).

nameq1(_10223,_10224,[nameq1,_10266],_10249,_10251) --> 
    virtual(nameq1(_10223,_10224),_10266,_10249,_10251).

