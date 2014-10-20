/* -*- Mode:Prolog; coding:utf-8; -*- */
% Grammar files transformed to dcg_e.pl or dcg_n.pl 
%%from writeheading in tuc/metacomp.pl
%% datetime(2014,10,20,10,49,40)

%% FILE dcg_n.pl
%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...

:-module( dcg_n, [sentence/6,(\)/7,addressat0/5,adj_conjunction0/5,altsogå/5,andor0/6,andwhere0/5,anorder/7,areyou/5,as0/5,assemble_stop_locations/6,at0/5,atom/6,atomlist/6,aux0/7,auxs/5,be_modal/6,be_there_modal/6,be_truefalse_that/6,be0/5,begin/5,both0/5,bus_number/6,check_stop_locations/5,clock_number/6,clock_time/6,colon0/5,commas0/5,complement1_accept/8,denbussen/5,dendet0/5,detå/5,(do)/6,each/5,either0/5,end/5,endofline1/5,erdetdet/5,everything/5,faa0/5,faaverb/6,fast/5,flnpproper/6,fordent0/6,forto0/5,from/5,førnår/5,gadd/5,grums/5,halfhour/5,has0/5,hashad0/5,herefrom/5,ifra/5,iman/5,imp_phrase/6,in_order_to/7,it/5,itrailer/5,iyou/6,kan/5,latest/5,let/5,longadj/5,look_ahead_conjuction/5,look_ahead_endofline/5,look_ahead_pron/5,look_ahead_timeclause/5,menbare/5,mineyour0/5,minutes0/5,name_compound/8,namenb/6,nearest/5,next0/5,no_phrase/7,not_adjective_only/5,not_look_ahead_day/5,not_look_ahead_noun/5,not_look_ahead_pron/5,not_look_ahead_time/5,not_look_ahead_vehicle/5,not_one_of_lit/6,notify/5,notrel/5,notwithstanding/5,np_question/6,number0/5,nr0/5,object2hnn/8,om0/5,ompa/5,or1/5,others/5,out0/5,overat/5,paadeg/5,panic/6,pointNO/5,prep0/6,qtrailer/5,quant00/6,redundantsx0/5,relneg/6,relwhat/6,rep_modifiers0/10,road_number/6,same/5,sentence01/6,setlist/5,smallhours/6,some/5,someonex/5,soredundant0/5,statics/6,streetno/5,subjectverb/8,superlative/7,team/5,termchar0/5,terminatore0/5,thatto0/8,that0/5,themost/5,then0/5,theonly0/5,there_be_modal/6,thereitN/5,this/6,thousand0/5,tilsiden/5,timenexp/6,today0/5,trafikk/5,trans_verbs/10,verb0/6,when0/5,when10/5,where1/5,whose_noun/7,year0/6] ).

:- ensure_loaded( user:'../declare.pl' ). %% RS-111213 General (semantic) Operators, ...
:- use_module( '../utility/utility', [ test/1, testmember/2 ] ).  %% RS-140914

:- use_module( '../utility/datecalc', [ add_days/3, datetime/6, easterdate/2, subfromtime/3, this_year/1, timenow/1, today/1, todaysdate/1  ] ).  %% RS-131228, addtotime/3, days_between/3, 
:- use_module( 'dagrun_n', [cc/5,check_stop/5,end_of_line/5,end_of_line0/5,lock/5,look_ahead/6,not_look_ahead/6,pushstack/7,skip_rest/5,unlock/4,virtual/6,w/6]). %% RS-111213 What is DAG? 
:- use_module( 'dict_n', []). %% RS-111213 What is DAG? 
:- prolog_flag(discontiguous_warnings,_,off). %% RS-140921 Does this actually work?

:- use_module( '../db/timedat', [ dedicated_date/1, named_date/2 ] ). %% RS-131228
:- use_module( fernando, [ adj_compl/6, adjnamecomp_template/3, adjnoun_template/4, adjustprep/3, adjust_year/3, % ] ).  %% adjname_template2/3, adjname_template/4, 
         adj_template/5, adjustprepv/3, adv_compl/6, align_measure/5, align_noun_name/5, atom_templ/2, alignable/2, atv_template/6, bealign/5, bigno/3, %  cat_templ/5, align/5, 
         compare/5, clock_test/1, co_template/6, comparad/5, compatvar/2, compliancetest2/3, %% compliancetest/2,  
         compoundtest/4, constrain/2, constrainit/2,     %%  constrain0/2, constrain2/3,  ctype/2,
         dayname/1, decide_adjective/3, decide_quantifier/4, dtv_template/6, % defact/3, event/4,
         has_template/3, it_template/1, iv_template/4, % hour_test/1, idvarx/3, isfaktor/1, issiffer/1, issifre/1,
         joinclass/3,  joinclasses/2, latin/4, monthnumber/2, negate/3, % meetclass/3,
         norpart/3, numberdate/2,  noun_adverb/4, noun_compl/4, plausible_busno/1, plausibleclocktest/3, % nil_noun_compl/1, 
         preadjs_template/4, % rep_verb/1, pluralis/2, 
         setvartype/2, subject_object_test/3, subtype0/2, testconstraint/2, thenwhat/3, tv_template/5, type/2, % subclass/2, subclass0/2, screenmeasure/2, rv_template/7, 
         vartype/3, vartypeid/2, verb_compl/6, verbtype/2, which_thing/2 ] ). %% RS-140921 value_world/1, whodunnit/2
:- use_module( lex, [ no_unprotected_verb/0, unprotected_verb/0 ] ). %% txt/3, maxl/1, RS-140209
:- use_module( semantic, [ a_compl/4, abnormalverb/2, adjname_templ/2, ako/2, measureclass/1, % ] ). %% RS-140921 adj_templ/2, adjnamecomp_templ/3, adjnoun_templ/2, adjnouncomp_templ/3, (has_a)/2, iv_templ/2, jako/2, align1/2, aligen2/2,
         particle/3, post_adjective/1, pvi_templ/2, subclass/2, subclass0/2, tv_templ/3, v_compl/4, %  coher_class/3, dtv_templ/4, gradv_templ/2, stanprep/2,
         rv_templ/2 ] ). % RS-131227 measureclass/1, particle/3, post_adjective/1, pvi_templ/2, stanprep/2, tv_templ/3, v_compl/4, vako/2, testclass/1, n_compl/3, pai_templ/2,
:- use_module( '../main', [ traceprint/2 ] ). %%RS-140209 

sentence([gpsflag:::_40121|_40115],[sentence,{},_40243,!,_40311],_40195,_40199) --> 
    {user:value(gpsflag,true)},
    origin_phrase(_40121,_40243,_40195,_40277),
    !,
    sentences(_40115,_40311,_40277,_40199).

sentence(_40111,[sentence,{},_40215],_40173,_40177) --> 
    {\+user:value(gpsflag,true)},
    sentences(_40111,_40215,_40173,_40177).

origin_phrase([_40113|_40115],[origin_phrase,lit('('),!,_40259,{},_40337],_40199,_40203) --> 
    cc('(',_40199,_40247),
    !,
    origin_element(_40113,_40259,_40247,_40293),
    {user:new_origin:=true},
    origin_phrase0n(_40115,_40337,_40293,_40203).

origin_phrase([],[origin_phrase,[]],_40143,_40143) --> 
    [].

origin_phrase0n([_40113|_40115],[origin_phrase0n,_40195,!,_40263],_40167,_40171) --> 
    origin_element(_40113,_40195,_40167,_40229),
    !,
    origin_phrase0n(_40115,_40263,_40229,_40171).

origin_phrase0n([],[origin_phrase0n,lit(')')],_40147,_40151) --> 
    cc(')',_40147,_40151).

origin_element(gps_origin(_40115,_40117),[origin_element,_40201,lit(+),_40281],_40173,_40177) --> 
    gps_origin(_40115,_40201,_40173,_40235),
    cc(+,_40235,_40279),
    gps_time(_40117,_40281,_40279,_40177).

gps_origin(_40111,[gps_origin,_40191,!],_40163,_40167) --> 
    name_phrase(name,_40111:_40131,_40125,_40191,_40163,_40167),
    !.

gps_time(_40111,[gps_time,_40181],_40153,_40157) --> 
    w(nb(_40111,num),_40181,_40153,_40157).

sentence01(_40111,[sentence01,_40175],_40147,_40151) --> 
    implicitq(_40111,_40175,_40147,_40151).

sentence01(_40111,[sentence01,_40175],_40147,_40151) --> 
    sentence1(_40111,_40175,_40147,_40151).

sentences([new:::_40121],[sentences,{},_40245,_40303,!,_40361],_40197,_40201) --> 
    {user:value(queryflag,false)},
    declaration(_40121,_40245,_40197,_40279),
    terminatore(_40303,_40279,_40333),
    !,
    accept(_40361,_40333,_40201).

sentences([_40113],[sentences,{},_40255,_40303,_40361,_40449,!,_40507],_40207,_40211) --> 
    {user:value(queryflag,true)},
    greetings0(_40255,_40207,_40285),
    implicitq(_40113,_40303,_40285,_40337),
    optional(itrailer,_40361,_40337,_40425),
    terminatores(_40449,_40425,_40479),
    !,
    accept(_40507,_40479,_40211).

sentences(_40111,[sentences,_40209,{},_40281,_40329],_40181,_40185) --> 
    onesentence(_40133,_40209,_40181,_40243),
    {_40133\==error},
    check_stop(_40281,_40243,_40311),
    moresentences0(_40133,_40111,_40329,_40311,_40185).

moresentences0(_40111,_40113,[moresentences0,_40219,_40277,!,_40335,_40383],_40185,_40189) --> 
    onesentence(_40143,_40219,_40185,_40253),
    check_stop(_40277,_40253,_40307),
    !,
    accept(_40335,_40307,_40365),
    evenmore0(_40111,_40143,_40113,_40383,_40365,_40189).

evenmore0(_40111,error,[_40111,error],[evenmore0,!,_40219],_40169,_40173) --> 
    !,
    skip_rest(_40219,_40169,_40173).

evenmore0(_40111,[],[_40111],[evenmore0,[],!],_40165,_40165) --> 
    [],
    !.

evenmore0(_40111,_40113,[_40111|_40119],[evenmore0,_40205],_40165,_40169) --> 
    moresentences0(_40113,_40119,_40205,_40165,_40169).

onesentence([],[onesentence,_40183,!,_40241],_40155,_40159) --> 
    endofline(_40183,_40155,_40213),
    !,
    accept(_40241,_40213,_40159).

onesentence(_40111,[onesentence,_40193,_40251,!,_40309],_40165,_40169) --> 
    conf_statement(_40111,_40193,_40165,_40227),
    endofline(_40251,_40227,_40281),
    !,
    accept(_40309,_40281,_40169).

onesentence(_40111,[onesentence,_40193,_40241,_40299,_40347],_40165,_40169) --> 
    grums0(_40193,_40165,_40223),
    sentence1(_40111,_40241,_40223,_40275),
    sentence_delimiter(_40299,_40275,_40329),
    accept(_40347,_40329,_40169).

onesentence(error,[onesentence,_40171],_40143,_40147) --> 
    skip_rest(_40171,_40143,_40147).

notify([notify,_40169],_40147,_40151) --> 
    w(verb(notify,_40117,_40119),_40169,_40147,_40151).

notify([notify,_40171],_40149,_40153) --> 
    w(noun(notification,_40117,_40119,_40121),_40171,_40149,_40153).

conf_statement(confirm:::_40117,[conf_statement,_40181],_40153,_40157) --> 
    confirm(_40117,_40181,_40153,_40157).

confirm(false,[confirm,lit(jeg),_40231,lit(ikke),_40311],_40181,_40185) --> 
    cc(jeg,_40181,_40229),
    w(verb(know,pres,fin),_40231,_40229,_40265),
    cc(ikke,_40265,_40309),
    endofline(_40311,_40309,_40185).

confirm(true,[confirm,lit(ja),_40203],_40153,_40157) --> 
    cc(ja,_40153,_40201),
    of_course0(_40203,_40201,_40157).

confirm(true,[confirm,lit(jo),_40203],_40153,_40157) --> 
    cc(jo,_40153,_40201),
    of_course0(_40203,_40201,_40157).

confirm(false,[confirm,lit(nei),_40203],_40153,_40157) --> 
    cc(nei,_40153,_40201),
    of_coursenot0(_40203,_40201,_40157).

confirm(true,[confirm,_40171],_40143,_40147) --> 
    of_course(_40171,_40143,_40147).

confirm(false,[confirm,_40181,lit(ikke)],_40153,_40157) --> 
    of_course(_40181,_40153,_40211),
    cc(ikke,_40211,_40157).

sentence_delimiter([sentence_delimiter,lit(for),_40197],_40153,_40157) --> 
    cc(for,_40153,_40195),
    look_ahead([hvis],_40197,_40195,_40157).

sentence_delimiter([sentence_delimiter,lit(;)],_40139,_40143) --> 
    cc(;,_40139,_40143).

sentence_delimiter([sentence_delimiter,_40157],_40135,_40139) --> 
    terminatore(_40157,_40135,_40139).

terminatore0([terminatore0,_40169,!,_40227],_40147,_40151) --> 
    terminatore(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

terminatore0([terminatore0,[]],_40135,_40135) --> 
    [].

terminatores([terminatores,_40169,!,_40227],_40147,_40151) --> 
    terminator(_40169,_40147,_40199),
    !,
    terminatores(_40227,_40199,_40151).

terminatores([terminatores,_40175,_40223,!,_40281],_40153,_40157) --> 
    check_stop(_40175,_40153,_40205),
    endofline(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

terminatore([terminatore,_40157],_40135,_40139) --> 
    terminator1(_40157,_40135,_40139).

terminator1([terminator1,_40255,_40303,_40361,_40419,_40477,!,_40545],_40233,_40237) --> 
    terminator(_40255,_40233,_40285),
    not_look_ahead(w(nb(_40155,num)),_40303,_40285,_40337),
    not_look_ahead(w(name(_40169,_40171,month)),_40361,_40337,_40395),
    not_look_ahead(w(name(_40169,_40187,day)),_40419,_40395,_40453),
    not_look_ahead(w(name(_40169,_40203,date)),_40477,_40453,_40511),
    !,
    accept(_40545,_40511,_40237).

terminator1([terminator1,_40175,_40223,!,_40281],_40153,_40157) --> 
    check_stop_locations(_40175,_40153,_40205),
    endofline(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

look_ahead_endofline([look_ahead_endofline,_40179,!],_40157,_40161) --> 
    look_ahead_lit(['.',?,!],_40179,_40157,_40161),
    !.

look_ahead_endofline([look_ahead_endofline,_40157],_40135,_40139) --> 
    end_of_line(_40157,_40135,_40139).

endofline0([endofline0,_40169,!,_40227],_40147,_40151) --> 
    terminator(_40169,_40147,_40199),
    !,
    endofline0(_40227,_40199,_40151).

endofline0([endofline0,_40157],_40135,_40139) --> 
    end_of_line0(_40157,_40135,_40139).

endofline([endofline,_40175,_40223,!,_40281],_40153,_40157) --> 
    terminator(_40175,_40153,_40205),
    endofline(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

endofline([endofline,lit(:),_40195,!],_40151,_40155) --> 
    cc(:,_40151,_40193),
    end_of_line(_40195,_40193,_40155),
    !.

endofline([endofline,lit(+),{},_40243,!,_40301],_40179,_40183) --> 
    cc(+,_40179,_40221),
    {user:value(busflag,true)},
    endofline(_40243,_40221,_40273),
    !,
    accept(_40301,_40273,_40183).

endofline([endofline,_40157],_40135,_40139) --> 
    end_of_line(_40157,_40135,_40139).

endofline1([endofline1,lit('.')],_40139,_40143) --> 
    cc('.',_40139,_40143).

endofline1([endofline1,lit(?)],_40139,_40143) --> 
    cc(?,_40139,_40143).

endofline1([endofline1,lit(!)],_40139,_40143) --> 
    cc(!,_40139,_40143).

check_stop_locations([check_stop_locations,_40163,!],_40141,_40145) --> 
    check_stop(_40163,_40141,_40145),
    !.

check_stop_locations([check_stop_locations,_40191,_40249,!,{}],_40169,_40173) --> 
    w(end_of_query,_40191,_40169,_40225),
    assemble_stop_locations(_40133,_40249,_40225,_40173),
    !,
    {assert_default_origins(_40133)}.

assemble_stop_locations([_40119+_40121|_40115],[assemble_stop_locations,_40235,lit(+),_40315,!,_40383],_40207,_40211) --> 
    w(name(_40119,n,_40161),_40235,_40207,_40269),
    cc(+,_40269,_40313),
    w(nb(_40121,num),_40315,_40313,_40349),
    !,
    check_stop_locations(_40115,_40383,_40349,_40211).

assemble_stop_locations([],[assemble_stop_locations,_40171],_40143,_40147) --> 
    end_of_line(_40171,_40143,_40147).

sentence1(new:::_40117,[sentence1,_40277,_40325,lit(at),!,_40415,_40483],_40249,_40253) --> 
    hellos0(_40277,_40249,_40307),
    w(adj2(_40173,_40175),_40325,_40307,_40359),
    cc(at,_40359,_40403),
    !,
    clausal_object1(_40193,_40195,_40415,_40403,_40453),
    pushstack(first,(xnp(_40193,_40195),w(verb(be,pres,fin)),w(adj2(_40173,_40175))),nil,_40453,_40575),
    statreal(_40117,_40483,_40575,_40253).

sentence1(new:::_40117,[sentence1,_40227,_40275,!,_40371],_40199,_40203) --> 
    detaa(_40227,_40199,_40257),
    pushstack(first,[noen],nil,_40257,_40301),clausal_object1(_40145,_40147,_40275,_40301,_40331),
    !,
    pushstack(first,xnp(_40145,_40147),nil,_40331,_40471),
    statreal(_40117,_40371,_40471,_40203).

detaa([detaa,lit(det),lit(å)],_40149,_40153) --> 
    cc(det,_40149,_40191),
    cc(å,_40191,_40153).

detaa([detaa,lit(å)],_40139,_40143) --> 
    cc(å,_40139,_40143).

sentence1(new:::_40117,[sentence1,_40217,_40265,!,_40343],_40189,_40193) --> 
    hvorvidt(_40217,_40189,_40247),
    clausal_object1(_40145,_40147,_40265,_40247,_40303),
    !,
    pushstack(first,xnp(_40145,_40147),nil,_40303,_40443),
    statreal(_40117,_40343,_40443,_40193).

hvorvidt([hvorvidt,lit(hvorvidt)],_40139,_40143) --> 
    cc(hvorvidt,_40139,_40143).

hvorvidt([hvorvidt,lit(det),lit(at)],_40149,_40153) --> 
    cc(det,_40149,_40191),
    cc(at,_40191,_40153).

hvorvidt([hvorvidt,lit(at)],_40139,_40143) --> 
    cc(at,_40139,_40143).

sentence1(new:::_40117,[sentence1,_40203,_40251,!,_40319],_40175,_40179) --> 
    redundant(_40203,_40175,_40233),
    be_it_tf_that(_40143,_40251,_40233,_40285),
    !,
    statreal(_40117,_40319,_40285,_40179).

sentence1(new:::_40117,[sentence1,_40241,_40299,_40357],_40213,_40217) --> 
    w(verb(be,_40163,fin),_40241,_40213,_40275),
    look_ahead_lit([mye],_40299,_40275,_40333),
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_40333,_40377),
    statement(_40117,_40357,_40377,_40217).

sentence1(new:::_40117,[sentence1,_40269,_40327,lit(som),!,_40407],_40241,_40245) --> 
    w(verb(_40177,_40179,pass),_40269,_40241,_40303),
    redundant0(_40327,_40303,_40357),
    cc(som,_40357,_40395),
    !,
    pushstack(first,([noen],w(verb(_40177,_40179,fin)),[dette],[som]),nil,_40395,_40427),
    statreal(_40117,_40407,_40427,_40245).

sentence1(new:::_40117,[sentence1,_40257,_40345,_40403,_40461],_40229,_40233) --> 
    optional([kanskje],_40257,_40229,_40321),
    negation(_40157,_40345,_40321,_40379),
    not_look_ahead([alle],_40403,_40379,_40437),
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_40157)),nil,_40437,_40553),
    statreal(_40117,_40461,_40553,_40233).

sentence1(new:::_40117,[sentence1,_40433,_40491,_40549,_40607,_40675,_40733,lit(å),_40813,!,_40881],_40405,_40409) --> 
    one_of_lit([den,det,dette,disse,slike],_40433,_40405,_40467),
    w(noun(_40221,_40223,_40225,n),_40491,_40467,_40525),
    w(verb(be,_40275,fin),_40549,_40525,_40583),
    subject(_40281,_40283,_40607,_40583,_40645),
    w(adj2(_40291,nil),_40675,_40645,_40709),
    w(prep(_40301),_40733,_40709,_40767),
    cc(å,_40767,_40811),
    w(verb(_40313,inf,fin),_40813,_40811,_40847),
    !,
    pushstack(first,(xnp(_40281,_40283),w(verb(be,_40275,fin)),w(adj2(_40291,nil)),w(prep(_40301)),[å],w(verb(_40313,inf,fin)),w(noun(_40221,_40223,_40225,n))),nil,_40847,_40981),
    statreal(_40117,_40881,_40981,_40409).

sentence1(new:::_40117,[sentence1,_40377,_40435,_40493,_40551,_40619,_40677,!,_40745],_40349,_40353) --> 
    one_of_lit([den,det,dette,disse,slike],_40377,_40349,_40411),
    w(noun(_40197,_40199,_40201,n),_40435,_40411,_40469),
    w(verb(be,_40251,fin),_40493,_40469,_40527),
    subject(_40257,_40259,_40551,_40527,_40589),
    w(adj2(_40267,nil),_40619,_40589,_40653),
    w(prep(_40277),_40677,_40653,_40711),
    !,
    pushstack(free,(xnp(_40257,_40259),w(verb(be,_40251,fin)),w(adj2(_40267,nil)),w(prep(_40277)),w(noun(_40197,_40199,_40201,n))),nil,_40711,_40845),
    statreal(_40117,_40745,_40845,_40353).

sentence1(new:::_40117,[sentence1,_40385,_40443,_40501,_40559,_40627,_40685,!,_40753],_40357,_40361) --> 
    one_of_lit([den,det,dette,disse,slike],_40385,_40357,_40419),
    w(noun(_40197,_40199,_40201,n),_40443,_40419,_40477),
    w(verb(_40249,_40251,fin),_40501,_40477,_40535),
    subject(_40257,_40259,_40559,_40535,_40597),
    w(noun(_40267,sin,u,n),_40627,_40597,_40661),
    w(prep(_40281),_40685,_40661,_40719),
    !,
    pushstack(first,(xnp(_40257,_40259),w(verb(_40249,_40251,fin)),w(noun(_40267,sin,u,n)),w(prep(_40281)),w(noun(_40197,_40199,_40201,n))),nil,_40719,_40853),
    statreal(_40117,_40753,_40853,_40361).

sentence1(new:::_40117,[sentence1,_40345,_40403,_40461,{},_40533,!,_40611],_40317,_40321) --> 
    one_of_lit([den,det,dette,disse,slike],_40345,_40317,_40379),
    w(noun(_40179,_40181,_40183,n),_40403,_40379,_40437),
    w(verb(_40231,_40233,fin),_40461,_40437,_40495),
    {\+testmember(_40231,[have,get])},
    subject(_40261,_40263,_40533,_40495,_40571),
    !,
    pushstack(first,(xnp(_40261,_40263),w(verb(_40231,_40233,fin)),w(noun(_40179,_40181,_40183,n))),nil,_40571,_40711),
    statreal(_40117,_40611,_40711,_40321).

sentence1(new:::_40117,[sentence1,lit(hvorvidt),_40305,!,lit(kan),_40405,!,_40473],_40255,_40259) --> 
    cc(hvorvidt,_40255,_40303),
    clausal_object1(_40175,_40177,_40305,_40303,_40343),
    !,
    cc(kan,_40343,_40403),
    w(verb(_40199,_40201,pass),_40405,_40403,_40439),
    !,
    pushstack(first,([dere],w(verb(_40199,_40201,fin)),xnp(_40175,_40177)),nil,_40439,_40573),
    statreal(_40117,_40473,_40573,_40259).

sentence1(new:::_40117,[sentence1,_40269,_40327,_40395,!,_40463],_40241,_40245) --> 
    w(verb(_40161,_40173,_40175),_40269,_40241,_40303),
    gmem(_40161,[talk,speak],_40327,_40303,_40365),
    look_ahead(w(prep(_40201)),_40395,_40365,_40429),
    !,
    pushstack(first,([du],w(verb(_40161,pres))),nil,_40429,_40483),
    statreal(_40117,_40463,_40483,_40245).

sentence1(new:::_40117,[sentence1,_40215,_40263,!,_40321],_40187,_40191) --> 
    aux1(_40215,_40187,_40245),
    not_look_ahead_np(_40263,_40245,_40293),
    !,
    pushstack(first,([jeg],aux1),nil,_40293,_40413),
    statreal(_40117,_40321,_40413,_40191).

sentence1(new:::_40117,[sentence1,_40233,!,_40301],_40205,_40209) --> 
    w(verb(_40149,past,part),_40233,_40205,_40267),
    !,
    pushstack(first,([jeg],w(verb(_40149,past,fin))),nil,_40267,_40321),
    statreal(_40117,_40301,_40321,_40209).

sentence1(new:::_40117,[sentence1,_40233,!,_40301],_40205,_40209) --> 
    w(verb(_40149,past,part),_40233,_40205,_40267),
    !,
    pushstack(first,([jeg],w(verb(_40149,past,fin))),nil,_40267,_40321),
    statreal(_40117,_40301,_40321,_40209).

sentence1(new:::_40117,[sentence1,lit(har),_40285,_40343,!,_40411],_40235,_40239) --> 
    cc(har,_40235,_40283),
    negation0(_40163,_40285,_40283,_40319),
    w(verb(_40179,past,part),_40343,_40319,_40377),
    !,
    pushstack(first,([jeg],w(verb(_40179,past,fin)),negation(_40163)),nil,_40377,_40509),
    statreal(_40117,_40411,_40509,_40239).

sentence1(new:::_40117,[sentence1,_40309,_40367,_40425,_40493,_40541,_40599,!,_40667],_40281,_40285) --> 
    not_look_ahead([så],_40309,_40281,_40343),
    w(verb(_40179,pres,fin),_40367,_40343,_40401),
    gmem(_40179,[go,think],_40425,_40401,_40463),
    not_look_ahead_np(_40493,_40463,_40523),
    not_look_ahead([ikke],_40541,_40523,_40575),
    not_look_ahead_lit([jeg,meg,du],_40599,_40575,_40633),
    !,
    pushstack(first,([jeg],w(verb(_40179,pres,fin))),nil,_40633,_40687),
    statreal(_40117,_40667,_40687,_40285).

sentence1(new:::_40117,[sentence1,_40377,_40435,_40493,_40561,_40629,_40687,_40745,!,_40813],_40349,_40353) --> 
    not_look_ahead([så],_40377,_40349,_40411),
    w(verb(_40185,_40207,fin),_40435,_40411,_40469),
    gmem(_40207,[pres],_40493,_40469,_40531),
    gmem(_40185,[arrive,calculate,discover,give,hope,pass,run,send,start,take,think,try,wait],_40561,_40531,_40599),
    particlev1(_40185,_40629,_40599,_40663),
    not_look_ahead([ikke],_40687,_40663,_40721),
    not_look_ahead_lit([jeg,meg,du,vi],_40745,_40721,_40779),
    !,
    pushstack(first,([jeg],w(verb(_40185,pres,fin))),nil,_40779,_40833),
    statreal(_40117,_40813,_40833,_40353).

sentence1(new:::_40117,[sentence1,_40361,_40419,_40477,_40545,_40613,_40671,_40729,!,_40797],_40333,_40337) --> 
    not_look_ahead([så],_40361,_40333,_40395),
    w(verb(_40185,_40207,fin),_40419,_40395,_40453),
    gmem(_40207,[imp,inf],_40477,_40453,_40515),
    gmem(_40185,[arrive,discover,pass,run,send,start,take,try],_40545,_40515,_40583),
    reflexiv0(_40185,_40613,_40583,_40647),
    not_look_ahead([ikke],_40671,_40647,_40705),
    not_look_ahead_lit([jeg,meg,du,vi],_40729,_40705,_40763),
    !,
    pushstack(first,([jeg],w(verb(_40185,pres,fin))),nil,_40763,_40817),
    statreal(_40117,_40797,_40817,_40337).

sentence1(new:::_40117,[sentence1,_40341,_40399,{},_40471,_40529,_40587,_40635,!,_40733],_40313,_40317) --> 
    not_look_ahead([så],_40341,_40313,_40375),
    w(verb(_40203,pres,fin),_40399,_40375,_40433),
    {testmember(_40203,[believe,calculate,think,see,know])},
    not_look_ahead([det],_40471,_40433,_40505),
    not_look_ahead([du],_40529,_40505,_40563),
    redundant0(_40587,_40563,_40617),
    optional([at],_40635,_40617,_40699),
    !,
    pushstack(first,([jeg],w(verb(_40203,pres,fin)),[at]),nil,_40699,_40753),
    statreal(_40117,_40733,_40753,_40317).

sentence1(new:::_40117,[sentence1,_40279,_40337,_40395,lit(jeg),_40465,!,_40523],_40251,_40255) --> 
    not_look_ahead([så],_40279,_40251,_40313),
    w(verb(_40191,_40193,fin),_40337,_40313,_40371),
    redundant0(_40395,_40371,_40425),
    cc(jeg,_40425,_40463),
    aux1(_40465,_40463,_40495),
    !,
    pushstack(first,([jeg],w(verb(_40191,pres,fin)),[å]),nil,_40495,_40543),
    statement(_40117,_40523,_40543,_40255).

sentence1(new:::_40117,[sentence1,_40265,_40313,_40361,_40419,!,_40487],_40237,_40241) --> 
    aux1(_40265,_40237,_40295),
    redundants0(_40313,_40295,_40343),
    negation0(_40169,_40361,_40343,_40395),
    w(verb(_40181,inf,fin),_40419,_40395,_40453),
    !,
    pushstack(first,([jeg],w(verb(_40181,pres,fin)),negation(_40169)),nil,_40453,_40585),
    statement(_40117,_40487,_40585,_40241).

sentence1(_40111,[sentence1,_40175],_40147,_40151) --> 
    command(_40111,_40175,_40147,_40151).

sentence1(_40111,[sentence1,_40187,_40235,_40293],_40159,_40163) --> 
    greetings0(_40187,_40159,_40217),
    question(_40111,_40235,_40217,_40269),
    qtrailer0(_40293,_40269,_40163).

sentence1(modifier(_40135):::_40143 isa clock and srel/nil/time/_40143/_40135 and event/real/_40135,[sentence1,{},_40321,_40379,{},!,_40451],_40273,_40277) --> 
    {user:value(dialog,1)},
    item(_40225,_40321,_40273,_40355),
    endofline(_40379,_40355,_40409),
    {_40225=(_40143 isa clock)},
    !,
    accept(_40451,_40409,_40277).

sentence1(item:::_40117,[sentence1,{},_40241,_40299,!,_40357],_40193,_40197) --> 
    {user:value(dialog,1)},
    item(_40117,_40241,_40193,_40275),
    endofline(_40299,_40275,_40329),
    !,
    accept(_40357,_40329,_40197).

sentence1(item:::_40121 isa clock,[sentence1,{},lit(nå),_40283,!,_40341,{}],_40213,_40217) --> 
    {user:value(dialog,1)},
    cc(nå,_40213,_40281),
    terminator1(_40283,_40281,_40313),
    !,
    accept(_40341,_40313,_40217),
    {timenow(_40121)}.

sentence1(item:::_40117,[sentence1,_40237,{},_40365,!,_40423],_40209,_40213) --> 
    noun(_40145,_40147,_40149,n,it:_40161,_40117,_40237,_40209,_40291),
    {user:value(dialog,1)},
    endofline(_40365,_40291,_40395),
    !,
    accept(_40423,_40395,_40213).

sentence1(item:::it isa _40123,[sentence1,{},_40257,_40305,!,_40363,{}],_40209,_40213) --> 
    {user:value(dialog,1)},
    today(_40257,_40209,_40287),
    terminator1(_40305,_40287,_40335),
    !,
    accept(_40363,_40335,_40213),
    {today(_40123)}.

sentence1(new:::_40117,[sentence1,lit(ble),_40283,!,_40351],_40233,_40237) --> 
    cc(ble,_40233,_40281),
    look_ahead(w(adj2(_40161,nil)),_40283,_40281,_40317),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),w(adj2(_40161,nil))),nil,_40317,_40371),
    statement(_40117,_40351,_40371,_40237).

sentence1(new:::_40117,[sentence1,_40301,_40359,_40407,{},!,_40489,_40537],_40273,_40277) --> 
    w(verb(be,_40189,_40191),_40301,_40273,_40335),
    now0(_40359,_40335,_40389),
    w(prep(_40199),_40407,_40389,_40441),
    {testmember(_40199,[in,on,at])},
    !,
    accept(_40489,_40441,_40519),
    pushstack(first,([jeg],w(verb(be,pres,fin)),w(prep(on))),nil,_40519,_40557),
    statement(_40117,_40537,_40557,_40277).

sentence1(new:::_40117,[sentence1,_40271,_40319,{},_40391,_40439],_40243,_40247) --> 
    has(_40271,_40243,_40301),
    w(verb(_40161,past,part),_40319,_40301,_40353),
    {testmember(_40161,[send,get,receive,lay])},
    now0(_40391,_40353,_40421),
    pushstack(first,([jeg],w(verb(_40161,past,fin))),nil,_40421,_40459),
    statement(_40117,_40439,_40459,_40247).

sentence1(new:::_40117,[sentence1,_40269,{},_40341,_40389],_40241,_40245) --> 
    w(verb(_40155,_40169,fin),_40269,_40241,_40303),
    {testmember(_40155,[send,get,receive,lay,check])},
    now0(_40341,_40303,_40371),
    pushstack(first,([jeg],w(verb(_40155,pres,fin))),nil,_40371,_40409),
    statement(_40117,_40389,_40409,_40245).

sentence1(new:::_40117,[sentence1,_40193,_40241,_40299],_40165,_40169) --> 
    greetings0(_40193,_40165,_40223),
    statement(_40117,_40241,_40223,_40275),
    dtrailer0(_40299,_40275,_40169).

sentence1(item:::_40117,[sentence1,_40199,_40257,!,_40315],_40171,_40175) --> 
    item(_40117,_40199,_40171,_40233),
    terminator1(_40257,_40233,_40287),
    !,
    accept(_40315,_40287,_40175).

item(_40115 isa clock,[item,{},_40245,{},_40317],_40197,_40201) --> 
    {user:value(dialog,1)},
    time12(_40115,_40245,_40197,_40279),
    {_40115\==now},
    endofline(_40317,_40279,_40201).

item(_40111,[item,{},_40225,_40293],_40177,_40181) --> 
    {user:value(dialog,1)},
    obviousdate1(_40143,_40111,_40225,_40177,_40263),
    endofline(_40293,_40263,_40181).

item(_40111,[item,_40179],_40151,_40155) --> 
    namep(_40115,_40117,_40111,_40179,_40151,_40155).

command(_40111,[command,lit(vil),!,_40219],_40159,_40163) --> 
    cc(vil,_40159,_40207),
    !,
    reject(_40219,_40207,_40163).

command(_40111,[command,lit(skal),!,_40219],_40159,_40163) --> 
    cc(skal,_40159,_40207),
    !,
    reject(_40219,_40207,_40163).

command(doit:::_40117,[command,lit(du),lit(må),_40311,_40369,!,_40437],_40239,_40243) --> 
    cc(du,_40239,_40287),
    cc(må,_40287,_40309),
    not_look_ahead([ikke],_40311,_40309,_40345),
    w(verb(_40167,inf,fin),_40369,_40345,_40403),
    !,
    pushstack(first,([du],w(verb(_40167,pres,fin))),nil,_40403,_40457),
    statreal(_40117,_40437,_40457,_40243).

command(doit:::quit(_40121),[command,_40203,_40251,_40299,_40357],_40175,_40179) --> 
    grums0(_40203,_40175,_40233),
    okeys0(_40251,_40233,_40281),
    quit(_40121,_40299,_40281,_40333),
    skip_rest(_40357,_40333,_40179).

command(doit:::reply(_40121),[command,_40197,_40255,_40303],_40169,_40173) --> 
    personal(_40121,_40197,_40169,_40231),
    dtrailer0(_40255,_40231,_40285),
    endofline(_40303,_40285,_40173).

command(doit:::replyq('Hei'),[command,_40187,!],_40159,_40163) --> 
    hellos(_40187,_40159,_40163),
    !.

command(new:::_40117,[command,_40257,_40315,lit(ut),_40395,_40463,!,_40521],_40229,_40233) --> 
    w(verb(_40167,pres,fin),_40257,_40229,_40291),
    not_look_ahead([du],_40315,_40291,_40349),
    cc(ut,_40349,_40393),
    gmem(_40167,[see,look],_40395,_40393,_40433),
    tilat(_40463,_40433,_40493),
    !,
    substateme1(real,_40117,_40521,_40493,_40233).

tilat([tilat,lit(til),lit(at),!],_40155,_40159) --> 
    cc(til,_40155,_40197),
    cc(at,_40197,_40159),
    !.

tilat([tilat,lit(som),lit(om),!],_40155,_40159) --> 
    cc(som,_40155,_40197),
    cc(om,_40197,_40159),
    !.

tilat([tilat,lit(som)],_40139,_40143) --> 
    cc(som,_40139,_40143).

command(new:::_40117,[command,_40287,_40345,_40403,!,_40481],_40259,_40263) --> 
    w(verb(_40161,pres,fin),_40287,_40259,_40321),
    not_look_ahead([du],_40345,_40321,_40379),
    gmem(_40161,[expect,miss,need,get,receive,see,understand],_40403,_40379,_40441),
    !,
    pushstack(first,([jeg],w(verb(_40161,pres,fin))),nil,_40441,_40501),
    statreal(_40117,_40481,_40501,_40263).

command(new:::_40117,[command,_40359,_40417,_40475,{},_40547,{},!,_40629],_40331,_40335) --> 
    not_look_ahead([nå],_40359,_40331,_40393),
    not_look_ahead(w(verb(come,imp,fin)),_40417,_40393,_40451),
    w(verb(_40179,_40217,fin),_40475,_40451,_40509),
    {testmember(_40179,[go,take,run,arrive,leave,leave2,depart,start,pass])},
    not_look_ahead([meg],_40547,_40509,_40581),
    {testmember(_40217,[imp,inf])},
    !,
    pushstack(first,([jeg],w(verb(_40179,pres,fin))),nil,_40581,_40649),
    statreal(_40117,_40629,_40649,_40335).

command(new:::_40117,[command,_40289,_40347,{},_40419,lit(jeg),_40509,!,_40577],_40261,_40265) --> 
    w(verb(_40177,pres,fin),_40289,_40261,_40323),
    not_look_ahead([du],_40347,_40323,_40381),
    {testmember(_40177,[believe])},
    that0(_40177,that,_40419,_40381,_40457),
    cc(jeg,_40457,_40507),
    not_look_ahead(w(prep(_40225)),_40509,_40507,_40543),
    !,
    pushstack(first,[jeg],nil,_40543,_40597),
    statreal(_40117,_40577,_40597,_40265).

command(new:::_40117,[command,_40263,_40321,_40389,!,_40447],_40235,_40239) --> 
    w(verb(_40161,pres,fin),_40263,_40235,_40297),
    gmem(_40161,[arrive,leave2,depart],_40321,_40297,_40359),
    look_ahead_place(_40389,_40359,_40419),
    !,
    pushstack(first,([jeg],w(verb(_40161,pres,fin))),nil,_40419,_40467),
    statreal(_40117,_40447,_40467,_40239).

command(doit:::_40117,[command,_40291,_40379,_40427,_40485,{},_40557,!,_40615],_40263,_40267) --> 
    optional(grums,_40291,_40263,_40355),
    please0(_40379,_40355,_40409),
    negation0(_40181,_40427,_40409,_40461),
    w(verb(_40197,imp,fin),_40485,_40461,_40519),
    {verbtype(_40197,tv)},
    look_ahead_np(_40557,_40519,_40587),
    !,
    pushstack(first,([du],w(verb(_40197,pres,fin)),negation(_40181)),nil,_40587,_40713),
    statreal(_40117,_40615,_40713,_40267).

command(doit:::_40117,[command,_40287,_40375,_40423,_40481,_40539,!,_40617,_40771],_40259,_40263) --> 
    optional(grums,_40287,_40259,_40351),
    please0(_40375,_40351,_40405),
    negation0(_40167,_40423,_40405,_40457),
    w(verb(_40175,imp,fin),_40481,_40457,_40515),
    particlev0(_40175,_40185,_40539,_40515,_40577),
    !,
    pushstack(first,([du],w(verb(_40185,pres,fin)),negation(_40167)),nil,_40577,_40721),statreal(_40117,_40617,_40721,_40747),
    ctrailer0(_40771,_40747,_40263).

command(doit:::replyq(?),[command,_40181],_40153,_40157) --> 
    end_of_line(_40181,_40153,_40157).

imp_phrase(_40111,[imp_phrase,_40215,lit(oss),_40325,!],_40187,_40191) --> 
    lexv(_40133,let,imp,fin,_40215,_40187,_40261),
    cc(oss,_40261,_40323),
    w(verb(_40111,inf,fin),_40325,_40323,_40191),
    !.

imp_phrase(let,[imp_phrase,_40193,!,_40291],_40165,_40169) --> 
    lexv(rv,let,imp,fin,_40193,_40165,_40239),
    !,
    accept(_40291,_40239,_40169).

imp_phrase(list,[imp_phrase,_40199,_40247,!,_40345],_40171,_40175) --> 
    faa(_40199,_40171,_40229),
    lexv(_40133,see,imp,fin,_40247,_40229,_40293),
    !,
    accept(_40345,_40293,_40175).

imp_phrase(wait,[imp_phrase,_40189,!],_40161,_40165) --> 
    w(verb(wait,imp,fin),_40189,_40161,_40165),
    !.

imp_phrase(_40111,[imp_phrase,_40245,_40303,_40351,{},{}],_40217,_40221) --> 
    not_look_ahead([må],_40245,_40217,_40279),
    comeand0(_40303,_40279,_40333),
    lexv(_40169,_40111,imp,fin,_40351,_40333,_40221),
    {_40169\==rv},
    {\+testmember(_40111,[have,expect])}.

imp_phrase(_40111,[imp_phrase,_40243,_40301,_40349,{},{},_40465],_40215,_40219) --> 
    not_look_ahead([må],_40243,_40215,_40277),
    comeand0(_40301,_40277,_40331),
    lexv(rv,_40111,imp,fin,_40349,_40331,_40395),
    {_40111\==be},
    {_40111\==wonder},
    reflexiv0(_40111,_40465,_40395,_40219).

imp_phrase(_40111,[imp_phrase,_40245,_40303,_40351,{},{}],_40217,_40221) --> 
    not_look_ahead([må],_40245,_40217,_40279),
    comeand0(_40303,_40279,_40333),
    lexv(_40157,_40111,inf,fin,_40351,_40333,_40221),
    {testmember(_40111,[list,show,make])},
    {_40111\==be}.

comeand0([comeand0,_40185,lit(å),!],_40163,_40167) --> 
    w(verb(come,imp,fin),_40185,_40163,_40219),
    cc(å,_40219,_40167),
    !.

comeand0([comeand0,[]],_40135,_40135) --> 
    [].

declaration(_40115 isa self,[declaration,_40199,_40247,!,_40305],_40171,_40175) --> 
    i(_40199,_40171,_40229),
    be(_40247,_40229,_40277),
    !,
    newatomid(_40115,_40305,_40277,_40175).

declaration(_40111,[declaration,_40213,_40271,_40319,!,_40377],_40185,_40189) --> 
    newatom(_40147,_40213,_40185,_40247),
    be(_40271,_40247,_40301),
    a(_40319,_40301,_40349),
    !,
    noun(_40139,sin,u,n,_40147,_40111,_40377,_40349,_40189).

statement(_40111,[statement,lit(det),_40301,lit(at),_40381,_40439,_40517,!,_40575,[],_40723],_40251,_40255) --> 
    cc(det,_40251,_40299),
    be_truefalse(_40177,_40301,_40299,_40335),
    cc(at,_40335,_40379),
    look_ahead_lit([før,etter,når],_40381,_40379,_40415),
    adverbial3(_40201,_40203,_40205,_40439,_40415,_40481),
    comma0(_40517,_40481,_40547),
    !,
    accept(_40575,_40547,_40605),
    pushstack(free,adverbial1(_40201,_40203,_40205),nil,_40605,_40721),[],
    substatement1(_40111,_40723,_40721,_40255).

statement(_40111,[statement,_40251,_40309,_40387,!,_40445],_40223,_40227) --> 
    look_ahead_lit([hvis,om,selvom,da],_40251,_40223,_40285),
    adverbial3(_40151,_40153,_40155,_40309,_40285,_40351),
    soredundant(_40387,_40351,_40417),
    !,
    lock(last,_40417,_40551),
    pushstack(last,([så],xadverbial1(_40151,_40153,_40155)),nil,_40551,_40563),
    substatement1(_40111,_40445,_40563,_40541),
    unlock(_40541,_40227).

statement(_40111,[statement,_40299,_40357,_40435,_40493,lit(det),!,_40583,_40631],_40271,_40275) --> 
    look_ahead([hvis],_40299,_40271,_40333),
    adverbial3(_40175,_40177,_40179,_40357,_40333,_40399),
    not_look_ahead([så],_40435,_40399,_40469),
    w(verb(_40211,_40213,fin),_40493,_40469,_40527),
    cc(det,_40527,_40571),
    !,
    accept(_40583,_40571,_40613),
    lock(last,_40613,_40747),
    pushstack(last,([det],w(verb(_40211,_40213,fin)),xadverbial1(_40175,_40177,_40179)),nil,_40747,_40759),
    substatement1(_40111,_40631,_40759,_40737),
    unlock(_40737,_40275).

statement(_40111,[statement,_40295,_40353,_40431,_40489,lit(det),_40559,!,_40627,_40675],_40267,_40271) --> 
    look_ahead([hvis],_40295,_40267,_40329),
    adverbial3(_40187,_40189,_40191,_40353,_40329,_40395),
    not_look_ahead([så],_40431,_40395,_40465),
    aux1(_40489,_40465,_40519),
    cc(det,_40519,_40557),
    negation0(_40223,_40559,_40557,_40593),
    !,
    accept(_40627,_40593,_40657),
    lock(last,_40657,_40943),
    pushstack(last,([det],aux1,negation(_40223),xadverbial1(_40187,_40189,_40191)),nil,_40943,_40955),
    substatement1(_40111,_40675,_40955,_40933),
    unlock(_40933,_40271).

statement(_40111,[statement,_40305,_40363,_40441,_40499,_40547,_40615,_40663,!,_40731,_40779],_40277,_40281) --> 
    look_ahead([hvis],_40305,_40277,_40339),
    adverbial3(_40193,_40195,_40197,_40363,_40339,_40405),
    not_look_ahead([så],_40441,_40405,_40475),
    aux1(_40499,_40475,_40529),
    subject(_40225,_40227,_40547,_40529,_40585),
    redundant0(_40615,_40585,_40645),
    negation0(_40231,_40663,_40645,_40697),
    !,
    accept(_40731,_40697,_40761),
    lock(last,_40761,_41127),
    pushstack(last,(xnp(_40225,_40227),aux1,negation(_40231),xadverbial1(_40193,_40195,_40197)),nil,_41127,_41139),
    substatement1(_40111,_40779,_41139,_41117),
    unlock(_41117,_40281).

statement(_40111,[statement,_40309,_40367,_40445,_40503,!,_40571,!,_40649,_40697],_40281,_40285) --> 
    look_ahead([hvis],_40309,_40281,_40343),
    adverbial3(_40181,_40183,_40185,_40367,_40343,_40409),
    not_look_ahead([så],_40445,_40409,_40479),
    w(verb(_40217,_40219,fin),_40503,_40479,_40537),
    !,
    subject(_40225,_40227,_40571,_40537,_40609),
    !,
    accept(_40649,_40609,_40679),
    lock(last,_40679,_40893),
    pushstack(last,(xnp(_40225,_40227),w(verb(_40217,_40219,fin)),xadverbial1(_40181,_40183,_40185)),nil,_40893,_40905),
    substatement1(_40111,_40697,_40905,_40883),
    unlock(_40883,_40285).

statement(_40111,[statement,_40249,_40307,_40385,!,_40443,[],_40601],_40221,_40225) --> 
    look_ahead_lit([før,etter,når],_40249,_40221,_40283),
    adverbial3(_40171,_40173,_40175,_40307,_40283,_40349),
    comma0(_40385,_40349,_40415),
    !,
    accept(_40443,_40415,_40473),
    pushstack(free,adverbial1(_40171,_40173,_40175),nil,_40473,_40599),[],
    substatement1(_40111,_40601,_40599,_40225).

statement(_40111,[statement,_40177],_40149,_40153) --> 
    statemens(real,_40111,_40177,_40149,_40153).

substatement1(_40111,[substatement1,_40281,_40329,_40387,_40475,_40543,_40631,!,_40709],_40253,_40257) --> 
    dether(_40281,_40253,_40311),
    w(verb(be,_40181,fin),_40329,_40311,_40363),
    optional([ofte],_40387,_40363,_40451),
    np0_accept(_40169,_40171,_40475,_40451,_40513),
    optional([som],_40543,_40513,_40607),
    subject(_40209,_40211,_40631,_40607,_40669),
    !,
    pushstack(free,(xnp(_40209,_40211),xnp(_40169,_40171)),nil,_40669,_40889),
    statreal(_40111,_40709,_40889,_40257).

dether([dether,lit(det)],_40139,_40143) --> 
    cc(det,_40139,_40143).

dether([dether,lit(det),lit(her)],_40149,_40153) --> 
    cc(det,_40149,_40191),
    cc(her,_40191,_40153).

dether([dether,lit(dette)],_40139,_40143) --> 
    cc(dette,_40139,_40143).

substatement1(_40111,[substatement1,_40177],_40149,_40153) --> 
    statemen1(real,_40111,_40177,_40149,_40153).

statemens(_40111,_40113,[statemens,_40203,_40271],_40169,_40173) --> 
    statemen1(_40111,_40125,_40203,_40169,_40241),
    statemens0(_40111,_40125,_40113,_40271,_40241,_40173).

statemens0(_40111,_40113,_40113 and _40121,[statemens0,_40235,_40283,!,_40341],_40195,_40199) --> 
    stm_conjunction(_40235,_40195,_40265),
    aux1(_40283,_40265,_40313),
    !,
    pushstack(first,[jeg],nil,_40313,_40361),
    statemens(_40111,_40121,_40341,_40361,_40199).

statemens0(_40111,_40113,_40113 and _40121,[statemens0,_40241,_40289,!,_40357],_40201,_40205) --> 
    stm_conjunction(_40241,_40201,_40271),
    look_ahead_lit([så,nå,da],_40289,_40271,_40323),
    !,
    statemens(_40111,_40121,_40357,_40323,_40205).

statemens0(_40111,_40113,_40113 and _40121,[statemens0,_40227,!,_40295],_40187,_40191) --> 
    look_ahead([så],_40227,_40187,_40261),
    !,
    statemens(_40111,_40121,_40295,_40261,_40191).

statemens0(_40111,_40113,_40113 and _40121,[statemens0,_40247,_40295,_40353,!,_40411],_40207,_40211) --> 
    stm_conjunction(_40247,_40207,_40277),
    not_look_ahead(w(verb(_40163,_40165,_40167)),_40295,_40277,_40329),
    not_look_ahead_number(_40353,_40329,_40383),
    !,
    statemens(_40111,_40121,_40411,_40383,_40211).

statemens0(_40111,_40113,_40113,[statemens0,[]],_40155,_40155) --> 
    [].

stm_conjunction([stm_conjunction,lit(hvorav)],_40139,_40143) --> 
    cc(hvorav,_40139,_40143).

stm_conjunction([stm_conjunction,lit(å),_40197],_40153,_40157) --> 
    cc(å,_40153,_40195),
    look_ahead([så],_40197,_40195,_40157).

stm_conjunction([stm_conjunction,lit(å),_40197],_40153,_40157) --> 
    cc(å,_40153,_40195),
    look_ahead([nå],_40197,_40195,_40157).

stm_conjunction([stm_conjunction,lit(og),_40197],_40153,_40157) --> 
    cc(og,_40153,_40195),
    look_ahead([nå],_40197,_40195,_40157).

stm_conjunction([stm_conjunction,lit(og),lit(at)],_40149,_40153) --> 
    cc(og,_40149,_40191),
    cc(at,_40191,_40153).

stm_conjunction([stm_conjunction,lit(men),lit(at)],_40149,_40153) --> 
    cc(men,_40149,_40191),
    cc(at,_40191,_40153).

stm_conjunction([stm_conjunction,lit(altså),lit(at)],_40149,_40153) --> 
    cc(altså,_40149,_40191),
    cc(at,_40191,_40153).

stm_conjunction([stm_conjunction,_40157],_40135,_40139) --> 
    and1(_40157,_40135,_40139).

stm_conjunction([stm_conjunction,lit(men)],_40139,_40143) --> 
    cc(men,_40139,_40143).

stm_conjunction([stm_conjunction,_40165],_40143,_40147) --> 
    look_ahead([så],_40165,_40143,_40147).

stm_conjunction([stm_conjunction,_40179,_40267],_40157,_40161) --> 
    optional([','],_40179,_40157,_40243),
    look_ahead([ikke],_40267,_40243,_40161).

stm_conjunction([stm_conjunction,lit(mens)],_40139,_40143) --> 
    cc(mens,_40139,_40143).

statemen1(_40111,_40113,[statemen1,_40189],_40155,_40159) --> 
    stateme1(_40111,_40113,_40189,_40155,_40159).

statemen1(_40111,_40113,[statemen1,_40307,{},_40379,!,_40477],_40273,_40277) --> 
    w(adj2(_40173,nil),_40307,_40273,_40341),
    {testmember(_40173,[possible,clear,ready])},
    optional([at],_40379,_40341,_40443),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_40173,nil)),[at]),nil,_40443,_40497),
    substateme1(_40111,_40113,_40477,_40497,_40277).

statemen1(_40111,_40113,[statemen1,_40355,{},_40427,{},{},_40513,!,_40591,!,_40767],_40321,_40325) --> 
    w(adj2(_40175,nil),_40355,_40321,_40389),
    {testmember(_40175,[enclosed])},
    w(verb(_40199,_40201,fin),_40427,_40389,_40461),
    {\+testmember(_40199,[])},
    {verbtype(_40199,iv)},
    subject(_40231,_40233,_40513,_40461,_40551),
    !,
    pushstack(first,(xnp(_40231,_40233),w(verb(_40199,_40201,fin)),w(adj2(_40175,nil))),nil,_40551,_40697),substateme1(_40111,_40113,_40591,_40697,_40727),
    !,
    accept(_40767,_40727,_40325).

statemen1(_40111,_40113,[statemen1,_40289,_40337,{},lit(det),_40431,_40479,!,_40575],_40255,_40259) --> 
    redundant(_40289,_40255,_40319),
    w(verb(_40163,_40165,fin),_40337,_40319,_40371),
    {\+testmember(_40163,[])},
    cc(det,_40371,_40429),
    danow0(_40431,_40429,_40461),
    pushstack(first,([det],w(verb(_40163,pres,fin))),nil,_40461,_40505),substateme1(_40111,_40113,_40479,_40505,_40535),
    !,
    accept(_40575,_40535,_40259).

statemen1(_40111,_40113,[statemen1,_40307,_40395,{},_40467,!,_40563],_40273,_40277) --> 
    optional([meget],_40307,_40273,_40371),
    w(adj2(_40159,nil),_40395,_40371,_40429),
    {testmember(_40159,[good,bad,interesting,nice])},
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_40159,nil))),nil,_40429,_40493),substateme1(_40111,_40113,_40467,_40493,_40523),
    !,
    accept(_40563,_40523,_40277).

statemen1(_40111,_40113,[statemen1,_40229,{},_40301],_40195,_40199) --> 
    not_look_ahead_lit([hva,hvem,hvilke,hvilken,hvilket],_40229,_40195,_40263),
    {unprotected_verb},
    substateme1(_40111,_40113,_40301,_40263,_40199).

statemen1(_40111,_40113,[statemen1,lit(som),lit(du),_40359,{},_40431,_40489,_40557],_40281,_40285) --> 
    cc(som,_40281,_40335),
    cc(du,_40335,_40357),
    w(verb(_40189,_40191,fin),_40359,_40357,_40393),
    {testmember(_40189,[know,see,understand])},
    w(verb(_40169,_40225,fin),_40431,_40393,_40465),
    subject(_40231,_40233,_40489,_40465,_40527),
    pushstack(first,(xnp(_40231,_40233),w(verb(_40169,pres,fin))),nil,_40527,_40657),
    substateme1(_40111,_40113,_40557,_40657,_40285).

statemen1(_40111,_40113,[statemen1,_40257,_40305,lit(det),_40385,!],_40223,_40227) --> 
    soredundant(_40257,_40223,_40287),
    w(verb(_40145,_40147,fin),_40305,_40287,_40339),
    cc(det,_40339,_40383),
    pushstack(first,([noe],w(verb(_40145,_40147,fin))),nil,_40383,_40411),substateme1(_40111,_40113,_40385,_40411,_40227),
    !.

stateme1(_40111,_40113,[stateme1,_40207],_40173,_40177) --> 
    statem(_40117,event/_40111/_40117::_40113,_40207,_40173,_40177).

substateme1(_40111,_40113,[substateme1,_40207],_40173,_40177) --> 
    substatem1(_40117,event/_40111/_40117::_40113,_40207,_40173,_40177).

substatem(_40111,_40113,[substatem,_40203,_40271],_40169,_40173) --> 
    substatem1(_40111,_40125,_40203,_40169,_40241),
    ogat(_40111,_40125,_40113,_40271,_40241,_40173).

ogat(_40111,_40119::_40125,_40119::_40125 and _40127,[ogat,lit(og),lit(at),!,_40305],_40211,_40215) --> 
    cc(og,_40211,_40271),
    cc(at,_40271,_40293),
    !,
    substatem1(_40111,_40119::_40127,_40305,_40293,_40215).

ogat(_40111,_40113,_40113,[ogat,[]],_40155,_40155) --> 
    [].

substatem1(_40111,_40113,[substatem1,lit(det),_40309,_40367,{},!,[],_40555],_40253,_40257) --> 
    cc(det,_40253,_40307),
    negation0(_40181,_40309,_40307,_40343),
    be(_40185,_40367,_40343,_40401),
    {bigno(_40181,_40185,_40197)},
    !,
    pushstack(free,negation(_40197),nil,_40401,_40553),[],
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_40553,_40575),
    statem(_40111,_40113,_40555,_40575,_40257).

substatem1(_40111,_40113,[substatem1,lit(det),_40311,_40369,{},!,_40491],_40255,_40259) --> 
    cc(det,_40255,_40309),
    negation0(_40173,_40311,_40309,_40345),
    hlexv(_40177,_40179,_40181,fin,_40185,_40369,_40345,_40419),
    {bigno(_40173,_40185,_40165)},
    !,
    pushstack(first,([det],w(verb(_40179,pres,fin)),negation(_40165)),nil,_40419,_40589),
    statem(_40111,_40113,_40491,_40589,_40259).

substatem1(_40111,_40113,[substatem1,lit(å),!,_40277,!,_40373],_40211,_40215) --> 
    cc(å,_40211,_40265),
    !,
    pushstack(first,[jeg],nil,_40265,_40303),clausal_object1(_40147,_40149,_40277,_40303,_40333),
    !,
    lock(last,_40333,_40487),
    pushstack(last,xnp(_40147,_40149),nil,_40487,_40499),
    statem(_40111,_40113,_40373,_40499,_40477),
    unlock(_40477,_40215).

substatem1(_40111,_40113,[substatem1,_40295,_40343,_40401,_40487,!,_40545],_40261,_40265) --> 
    forå(_40295,_40261,_40325),
    w(verb(_40171,inf,fin),_40343,_40325,_40377),
    pushstack(first,([jeg],w(verb(_40171,pres,fin))),nil,_40377,_40427),clausal_object1(_40161,true::_40163,_40401,_40427,_40457),
    hvisaa0(_40487,_40457,_40517),
    !,
    lock(last,_40517,_40651),
    pushstack(last,([så],subordinate(in_order_to,_40161,_40163)),nil,_40651,_40663),
    statem(_40111,_40113,_40545,_40663,_40641),
    unlock(_40641,_40265).

substatem1(_40111,_40113,[substatem1,_40335,_40393,[],_40567,_40615,lit(det),_40685,_40733,!,_40801],_40301,_40305) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom],_40335,_40301,_40369),
    subordinate(_40225,_40227,_40229,_40393,_40369,_40435),
    pushstack(free,subordinate(_40225,_40227,_40229),nil,_40435,_40565),[],
    hvisaa0(_40567,_40565,_40597),
    has(_40615,_40597,_40645),
    cc(det,_40645,_40683),
    redundant0(_40685,_40683,_40715),
    w(verb(be,past,part),_40733,_40715,_40767),
    !,
    pushstack(first,w(verb(be,past,fin)),nil,_40767,_40821),
    itstatem(_40111,_40113,_40801,_40821,_40305).

substatem1(_40111,_40113,[substatem1,_40289,_40347,_40425,!,_40483],_40255,_40259) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom,da,når],_40289,_40255,_40323),
    subordinate(_40153,_40155,_40157,_40347,_40323,_40389),
    hvisaa0(_40425,_40389,_40455),
    !,
    lock(last,_40455,_40599),
    pushstack(last,([så],subordinate(_40153,_40155,_40157)),nil,_40599,_40611),
    statem(_40111,_40113,_40483,_40611,_40589),
    unlock(_40589,_40259).

substatem1(_40111,_40113,[substatem1,_40189],_40155,_40159) --> 
    substate(_40111,_40113,_40189,_40155,_40159).

hvisaa0([hvisaa0,lit(så),!],_40145,_40149) --> 
    cc(så,_40145,_40149),
    !.

hvisaa0([hvisaa0,_40171,!],_40149,_40153) --> 
    look_ahead_lit([ble],_40171,_40149,_40153),
    !.

hvisaa0([hvisaa0,_40175,!],_40153,_40157) --> 
    look_ahead_lit([kan,får],_40175,_40153,_40157),
    !.

hvisaa0([hvisaa0,_40205,{}],_40183,_40187) --> 
    look_ahead(w(verb(_40121,_40153,fin)),_40205,_40183,_40187),
    {testmember(_40121,[avoid,be,come,have])}.

hvisaa0([hvisaa0,[]],_40135,_40135) --> 
    [].

sostatem(_40111,_40113,[sostatem,_40299,_40347,_40415,_40463,_40521,!,_40589,!],_40265,_40269) --> 
    faux1(_40299,_40265,_40329),
    subject(_40159,_40161,_40347,_40329,_40385),
    redundant0(_40415,_40385,_40445),
    negation0(_40165,_40463,_40445,_40497),
    w(verb(_40173,inf,fin),_40521,_40497,_40555),
    !,
    pushstack(first,(xnp(_40159,_40161),aux1,negation(_40165),w(verb(_40173,inf,fin))),nil,_40555,_40847),state(_40111,_40113,_40589,_40847,_40269),
    !.

sostatem(_40111,_40113,[sostatem,_40339,lit(det),_40419,_40477,lit(at),!,_40597,_40665],_40305,_40309) --> 
    w(verb(_40197,_40199,fin),_40339,_40305,_40373),
    cc(det,_40373,_40417),
    negation0(_40209,_40419,_40417,_40453),
    adj1(_40183,_40223:_40225,_40187,_40189,_40477,_40453,_40523),
    cc(at,_40523,_40585),
    !,
    clausal_object1(_40233,_40235,_40597,_40585,_40635),
    pushstack(first,(xnp(_40233,_40235),w(verb(_40197,_40199,fin)),negation(_40209),adj1(_40183,_40223:_40269,_40187,_40189)),nil,_40635,_40915),
    state(_40111,_40113,_40665,_40915,_40309).

sostatem(_40111,_40113,[sostatem,_40297,lit(det),_40367,_40415,_40473,_40531,_40599,!],_40263,_40267) --> 
    has(_40297,_40263,_40327),
    cc(det,_40327,_40365),
    preadverbials0(_40367,_40365,_40397),
    negation0(_40163,_40415,_40397,_40449),
    w(verb(_40171,past,part),_40473,_40449,_40507),
    subject(_40179,_40181,_40531,_40507,_40569),
    pushstack(first,(xnp(_40179,_40181),w(verb(_40171,past,fin)),negation(_40163)),nil,_40569,_40783),state(_40111,_40113,_40599,_40783,_40267),
    !.

sostatem(_40111,_40113,[sostatem,_40295,_40393,_40451,_40499,{},_40571,!],_40261,_40265) --> 
    lexvaccept(rv,_40155,_40157,fin,_40161,_40295,_40261,_40345),
    negation0(_40165,_40393,_40345,_40427),
    thereit(_40451,_40427,_40481),
    negation0(_40169,_40499,_40481,_40533),
    {bigno(_40165,_40169,_40161)},
    pushstack(first,([noe],w(verb(_40155,_40157,fin)),negation(_40161)),nil,_40533,_40675),state(_40111,_40113,_40571,_40675,_40265),
    !.

sostatem(_40111,_40113,[sostatem,_40303,_40361,_40419,_40487,{},_40559,!],_40269,_40273) --> 
    w(verb(_40157,_40159,fin),_40303,_40269,_40337),
    negation0(_40165,_40361,_40337,_40395),
    subject(_40169,_40171,_40419,_40395,_40457),
    negation0(_40175,_40487,_40457,_40521),
    {bigno(_40165,_40175,_40187)},
    pushstack(first,(xnp(_40169,_40171),w(verb(_40157,_40159,fin)),negation(_40187)),nil,_40521,_40743),state(_40111,_40113,_40559,_40743,_40273),
    !.

sostatem(_40111,_40113,[sostatem,_40267,_40325,_40373,_40431,!],_40233,_40237) --> 
    w(verb(_40145,_40147,pass),_40267,_40233,_40301),
    thereit0(_40325,_40301,_40355),
    negation0(_40153,_40373,_40355,_40407),
    pushstack(first,([noen],w(verb(_40145,_40147,fin)),negation(_40153)),nil,_40407,_40535),state(_40111,_40113,_40431,_40535,_40237),
    !.

sostatem(_40111,_40113,[sostatem,_40291,lit(det),_40361,{},!,_40443,!],_40257,_40261) --> 
    aux1(_40291,_40257,_40321),
    cc(det,_40321,_40359),
    w(verb(_40161,_40163,_40165),_40361,_40359,_40395),
    {_40163=inf;_40165=part},
    !,
    pushstack(first,([noe],w(verb(_40161,pres,fin))),nil,_40395,_40469),state(_40111,_40113,_40443,_40469,_40261),
    !.

sostatem(_40111,_40113,[sostatem,_40259,lit(det),_40329,!,_40397,!],_40225,_40229) --> 
    aux1(_40259,_40225,_40289),
    cc(det,_40289,_40327),
    w(verb(_40155,pres,pass),_40329,_40327,_40363),
    !,
    pushstack(first,(someone,w(verb(_40155,pres,fin))),nil,_40363,_40495),state(_40111,_40113,_40397,_40495,_40229),
    !.

sostatem(_40111,_40113,[sostatem,_40273,_40321,_40389,!,_40457,!],_40239,_40243) --> 
    aux1(_40273,_40239,_40303),
    object(_40147,_40149,_40321,_40303,_40359),
    w(verb(_40157,pres,pass),_40389,_40359,_40423),
    !,
    pushstack(first,(someone,w(verb(_40157,pres,fin)),xnp(_40147,_40149)),nil,_40423,_40637),state(_40111,_40113,_40457,_40637,_40243),
    !.

sostatem(_40111,_40113,[sostatem,_40277,_40335,{},lit(det),!,_40439,!],_40243,_40247) --> 
    not_look_ahead([så],_40277,_40243,_40311),
    w(verb(_40165,_40167,fin),_40335,_40311,_40369),
    {_40167\==inf},
    cc(det,_40369,_40427),
    !,
    pushstack(free,w(verb(_40165,pres,fin)),nil,_40427,_40465),state(_40111,_40113,_40439,_40465,_40247),
    !.

sostatem(_40111,_40113,[sostatem,_40273,_40321,_40389,!,_40457,!],_40239,_40243) --> 
    docan(_40273,_40239,_40303),
    subject(_40147,_40149,_40321,_40303,_40359),
    w(verb(_40157,pres,pass),_40389,_40359,_40423),
    !,
    pushstack(first,(someone,w(verb(_40157,pres,fin)),xnp(_40147,_40149)),nil,_40423,_40637),state(_40111,_40113,_40457,_40637,_40243),
    !.

statem(_40111,_40113,[statem,lit(det),_40327,_40385,_40453,!,_40521],_40271,_40275) --> 
    cc(det,_40271,_40325),
    w(verb(_40183,_40185,pass),_40327,_40325,_40361),
    gmem(_40183,[want,wish,need],_40385,_40361,_40423),
    negation0(_40209,_40453,_40423,_40487),
    !,
    pushstack(first,([noen],w(verb(_40183,_40185,fin)),negation(_40209),[dette]),nil,_40487,_40619),
    state(_40111,_40113,_40521,_40619,_40275).

statem(_40111,_40113,[statem,_40201,!,_40259],_40167,_40171) --> 
    preadverbials(_40201,_40167,_40231),
    !,
    prestatem(_40111,_40113,_40259,_40231,_40171).

statem(_40111,_40113,[statem,_40291,_40359,_40417,_40465,!,[],_40643],_40257,_40261) --> 
    obviousdate1(_40177,_40179,_40291,_40257,_40329),
    w(verb(_40169,_40171,fin),_40359,_40329,_40393),
    det0(_40417,_40393,_40447),
    subject(_40195,_40197,_40465,_40447,_40503),
    !,
    pushstack(free,obviousdate1(_40177,_40179),nil,_40503,_40641),[],
    pushstack(first,(xnp(_40195,_40197),w(verb(_40169,_40171,fin))),nil,_40641,_40743),
    state(_40111,_40113,_40643,_40743,_40261).

statem(_40111,_40113,[statem,_40279,_40347,_40405,!,_40503],_40245,_40249) --> 
    obviousdate1(_40159,_40161,_40279,_40245,_40317),
    w(verb(_40175,_40177,pass),_40347,_40317,_40381),
    optional([det],_40405,_40381,_40469),
    !,
    pushstack(free,([noen],w(verb(_40175,_40177,fin)),obviousdate1(_40159,_40161)),nil,_40469,_40603),
    state(_40111,_40113,_40503,_40603,_40249).

statem(_40111,_40113,[statem,_40373,_40441,_40499,_40567,_40635,_40693,lit(om),!,[],[],_40839],_40339,_40343) --> 
    lit_of(_40199,[det,dette],_40373,_40339,_40411),
    w(verb(_40217,_40219,fin),_40441,_40411,_40475),
    gmem(_40217,[worry],_40499,_40475,_40537),
    lit_of(_40235,[jeg,du,man],_40567,_40537,_40605),
    reflexiv0(_40217,_40635,_40605,_40669),
    negation0(_40195,_40693,_40669,_40727),
    cc(om,_40727,_40771),
    !,
    pushstack(free,[dette],nil,_40771,_40809),[],
    pushstack(free,[om],nil,_40809,_40837),[],
    pushstack(first,([_40235],w(verb(_40217,_40219,fin)),negation(_40195)),nil,_40837,_40937),
    state(_40111,_40113,_40839,_40937,_40343).

statem(_40111,_40113,[statem,_40361,_40429,_40487,_40555,lit(om),!,[],[],[],_40821],_40327,_40331) --> 
    lit_of(_40195,[det,dette],_40361,_40327,_40399),
    w(verb(_40187,_40189,fin),_40429,_40399,_40463),
    lit_of(_40221,[jeg,du,man],_40487,_40463,_40525),
    np_kernel(0,_40241,_40243,_40555,_40525,_40597),
    cc(om,_40597,_40653),
    !,
    pushstack(free,[dette],nil,_40653,_40691),[],
    pushstack(free,[om],nil,_40691,_40719),[],
    pushstack(free,np_kernel(0,_40241,_40243),nil,_40719,_40819),[],
    pushstack(first,([_40221],w(verb(_40187,_40189,fin))),nil,_40819,_40841),
    state(_40111,_40113,_40821,_40841,_40331).

statem(_40111,_40113,[statem,_40361,_40429,_40487,_40555,lit(om),!,[],[],[],_40831],_40327,_40331) --> 
    lit_of(_40195,[det,dette],_40361,_40327,_40399),
    w(verb(have,_40189,fin),_40429,_40399,_40463),
    lit_of(_40221,[jeg,du,man],_40487,_40463,_40525),
    np_kernel(0,_40241,_40243,_40555,_40525,_40597),
    cc(om,_40597,_40653),
    !,
    pushstack(free,[dette],nil,_40653,_40691),[],
    pushstack(free,[om],nil,_40691,_40719),[],
    pushstack(free,np_kernel(0,_40241,_40243),nil,_40719,_40829),[],
    pushstack(first,([_40221],w(verb(have,_40189,fin))),nil,_40829,_40851),
    state(_40111,_40113,_40831,_40851,_40331).

statem(_40111,_40113,[statem,_40345,_40423,lit(det),_40493,_40571,_40629,!,_40707],_40311,_40315) --> 
    preadverbial1(_40197,_40199,_40201,_40345,_40311,_40387),
    blei(_40423,_40387,_40453),
    cc(det,_40453,_40491),
    preadverbial0(_40189,_40191,_40193,_40493,_40491,_40535),
    w(verb(_40221,past,part),_40571,_40535,_40605),
    object(_40229,_40231,_40629,_40605,_40667),
    !,
    pushstack(first,(xnp(_40229,_40231),w(verb(be,pres,fin)),w(verb(_40221,past,part)),adverbial1(_40197,_40199,_40201),adverbial1(_40189,_40191,_40193)),nil,_40667,_40971),
    state(_40111,_40113,_40707,_40971,_40315).

statem(_40111,_40113,[statem,_40415,_40473,_40541,_40599,_40667,_40735,_40793,_40881,!,_40949],_40381,_40385) --> 
    not_look_ahead([det],_40415,_40381,_40449),
    obvious_object(_40207,_40209,_40473,_40449,_40511),
    w(verb(_40231,_40233,fin),_40541,_40511,_40575),
    gmem(_40231,[want,wish,need],_40599,_40575,_40637),
    lit_of(_40257,[jeg,vi,han,hun,du],_40667,_40637,_40705),
    negation0(_40283,_40735,_40705,_40769),
    optional([å],_40793,_40769,_40857),
    w(verb(_40299,inf,fin),_40881,_40857,_40915),
    !,
    pushstack(first,([_40257],w(verb(_40231,_40233,fin)),negation(_40283),[å],w(verb(_40299,_40233,fin)),xnp(_40207,_40209)),nil,_40915,_41127),
    state(_40111,_40113,_40949,_41127,_40385).

statem(_40111,_40113,[statem,_40349,_40407,_40475,_40533,_40601,_40669,!,_40737],_40315,_40319) --> 
    not_look_ahead([det],_40349,_40315,_40383),
    obvious_object(_40177,_40179,_40407,_40383,_40445),
    w(verb(_40201,_40203,fin),_40475,_40445,_40509),
    gmem(_40201,[have,get],_40533,_40509,_40571),
    lit_of(_40223,[jeg,vi,han,hun,du],_40601,_40571,_40639),
    w(verb(_40253,past,part),_40669,_40639,_40703),
    !,
    pushstack(first,([_40223],w(verb(_40253,_40203,fin)),xnp(_40177,_40179)),nil,_40703,_40837),
    state(_40111,_40113,_40737,_40837,_40319).

statem(_40111,_40113,[statem,_40355,_40413,_40481,{},_40553,_40621,!,_40689],_40321,_40325) --> 
    not_look_ahead([det],_40355,_40321,_40389),
    obvious_object(_40183,_40185,_40413,_40389,_40451),
    w(verb(_40207,_40209,fin),_40481,_40451,_40515),
    {\+testmember(_40207,[give])},
    lit_of(_40233,[jeg,vi,han,hun,du],_40553,_40515,_40591),
    negation0(_40259,_40621,_40591,_40655),
    !,
    pushstack(first,([_40233],w(verb(_40207,_40209,fin)),negation(_40259),xnp(_40183,_40185)),nil,_40655,_40867),
    state(_40111,_40113,_40689,_40867,_40325).

statem(_40111,_40113,[statem,_40423,_40481,_40549,_40607,_40675,_40743,_40831,_40889,!,_40957],_40389,_40393) --> 
    not_look_ahead([det],_40423,_40389,_40457),
    obvious_object(_40207,_40209,_40481,_40457,_40519),
    w(verb(_40231,_40233,fin),_40549,_40519,_40583),
    gmem(_40231,[want,wish,need],_40607,_40583,_40645),
    lit_of(_40257,[jeg,vi,han,hun,du],_40675,_40645,_40713),
    optional([å],_40743,_40713,_40807),
    w(verb(_40295,inf,fin),_40831,_40807,_40865),
    w(prep(_40307),_40889,_40865,_40923),
    !,
    pushstack(first,([_40257],w(verb(_40231,_40233,fin)),[å],w(verb(_40295,_40233,fin)),w(prep(_40307)),xnp(_40207,_40209)),nil,_40923,_41057),
    state(_40111,_40113,_40957,_41057,_40393).

statem(_40111,_40113,[statem,_40311,lit(kan),_40401,_40469,!,_40537],_40277,_40281) --> 
    obvious_object(_40165,_40167,_40311,_40277,_40349),
    cc(kan,_40349,_40399),
    lit_of(_40181,[jeg,vi,han,hun,du],_40401,_40399,_40439),
    not_look_ahead(w(verb(_40215,_40217,_40219)),_40469,_40439,_40503),
    !,
    pushstack(first,([_40181],w(verb(do1,pres,fin)),xnp(_40165,_40167)),nil,_40503,_40637),
    state(_40111,_40113,_40537,_40637,_40281).

statem(_40111,_40113,[statem,_40317,_40375,_40443,_40491,_40559,!,_40627],_40283,_40287) --> 
    not_look_ahead([det],_40317,_40283,_40351),
    obvious_object(_40171,_40173,_40375,_40351,_40413),
    aux1(_40443,_40413,_40473),
    lit_of(_40191,[jeg,vi,han,hun,du],_40491,_40473,_40529),
    w(verb(_40221,inf,fin),_40559,_40529,_40593),
    !,
    pushstack(first,([_40191],w(verb(_40221,pres,fin)),xnp(_40171,_40173)),nil,_40593,_40727),
    state(_40111,_40113,_40627,_40727,_40287).

statem(_40111,_40113,[statem,_40317,_40375,_40443,_40491,_40559,!,_40627],_40283,_40287) --> 
    not_look_ahead([det],_40317,_40283,_40351),
    obvious_object(_40171,_40173,_40375,_40351,_40413),
    aux1(_40443,_40413,_40473),
    lit_of(_40191,[jeg,vi,han,hun,du],_40491,_40473,_40529),
    w(verb(_40221,inf,fin),_40559,_40529,_40593),
    !,
    pushstack(first,([_40191],w(verb(_40221,pres,fin)),xnp(_40171,_40173)),nil,_40593,_40727),
    state(_40111,_40113,_40627,_40727,_40287).

statem(_40111,_40113,[statem,lit(det),lit(som),!,_40309],_40221,_40225) --> 
    cc(det,_40221,_40275),
    cc(som,_40275,_40297),
    !,
    pushstack(first,([en],w(noun(thing,sin,u,n)),[som]),nil,_40297,_40329),
    state(_40111,_40113,_40309,_40329,_40225).

statem(_40111,_40113,[statem,_40297,_40355,_40403,lit(å),!,_40493],_40263,_40267) --> 
    one_of_lit([nå,så,da,redundant0],_40297,_40263,_40331),
    shoulditbe(_40355,_40331,_40385),
    w(adj2(_40193,_40195),_40403,_40385,_40437),
    cc(å,_40437,_40481),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_40193,_40195)),[å]),nil,_40481,_40513),
    itstatem(_40111,_40113,_40493,_40513,_40267).

statem(_40111,_40113,[statem,_40241,_40299,_40347,!],_40207,_40211) --> 
    one_of_lit([nå,så,da],_40241,_40207,_40275),
    shoulditbe(_40299,_40275,_40329),
    pushstack(first,w(verb(be,pres,fin)),nil,_40329,_40373),itstatem(_40111,_40113,_40347,_40373,_40211),
    !.

shoulditbe([shoulditbe,_40185,_40243,lit(det)],_40163,_40167) --> 
    w(verb(be,_40133,fin),_40185,_40163,_40219),
    redundant0(_40243,_40219,_40273),
    cc(det,_40273,_40167).

shoulditbe([shoulditbe,_40191,_40239,lit(det),_40309],_40169,_40173) --> 
    aux1(_40191,_40169,_40221),
    redundant0(_40239,_40221,_40269),
    cc(det,_40269,_40307),
    w(verb(be,inf,fin),_40309,_40307,_40173).

shoulditbe([shoulditbe,_40193,lit(det),_40273],_40171,_40175) --> 
    one_of_lit([kan,kunne,får,fikk],_40193,_40171,_40227),
    cc(det,_40227,_40271),
    vaere(_40273,_40271,_40175).

vaere([vaere,_40177],_40155,_40159) --> 
    one_of_lit([være,vært,bli,blitt],_40177,_40155,_40159).

statem(_40111,_40113,[statem,lit(det),_40343,_40391,_40459,{},{},!,_40555],_40287,_40291) --> 
    cc(det,_40287,_40341),
    aux1(_40343,_40341,_40373),
    subject(_40185,_40187,_40391,_40373,_40429),
    w(verb(_40195,inf,fin),_40459,_40429,_40493),
    {testmember(_40195,[believe,know])},
    {verbtype(_40195,rv)},
    !,
    pushstack(first,(xnp(_40185,_40187),w(verb(_40195,pres,fin)),[dette]),nil,_40493,_40655),
    state(_40111,_40113,_40555,_40655,_40291).

statem(_40111,_40113,[statem,_40329,_40397,{},{},_40483,!,_40561],_40295,_40299) --> 
    obvious_object(_40177,_40179,_40329,_40295,_40367),
    w(verb(_40193,_40195,fin),_40397,_40367,_40431),
    {testmember(_40193,[believe,know])},
    {verbtype(_40193,rv)},
    subject(_40229,_40231,_40483,_40431,_40521),
    !,
    pushstack(first,(xnp(_40229,_40231),w(verb(_40193,_40195,fin)),[at],xnp(_40177,_40179)),nil,_40521,_40741),
    state(_40111,_40113,_40561,_40741,_40299).

statem(_40111,_40113,[statem,_40285,_40353,_40401,_40469,!,_40537],_40251,_40255) --> 
    obvious_object(_40165,_40167,_40285,_40251,_40323),
    has(_40353,_40323,_40383),
    subject(_40177,_40179,_40401,_40383,_40439),
    w(verb(_40187,past,part),_40469,_40439,_40503),
    !,
    pushstack(first,(xnp(_40177,_40179),w(verb(_40187,past,fin)),xnp(_40165,_40167)),nil,_40503,_40717),
    state(_40111,_40113,_40537,_40717,_40255).

statem(_40111,_40113,[statem,lit(å),_40331,_40389,_40475,!,_40543],_40275,_40279) --> 
    cc(å,_40275,_40329),
    w(verb(_40173,inf,fin),_40331,_40329,_40365),
    pushstack(first,([noen],w(verb(_40173,pres,fin))),nil,_40365,_40415),clausal_object1(_40153,_40159::_40161,_40389,_40415,_40445),
    look_ahead(w(verb(be,pres,fin)),_40475,_40445,_40509),
    !,
    pushstack(first,xnp(_40153,_40159::_40161),nil,_40509,_40631),
    state(_40111,_40113,_40543,_40631,_40279).

statem(_40111,_40113,[statem,lit(det),_40335,lit(seg),_40415,_40473,lit(å),!,_40563,!],_40279,_40283) --> 
    cc(det,_40279,_40333),
    w(verb(let,_40175,fin),_40335,_40333,_40369),
    cc(seg,_40369,_40413),
    negation0(_40185,_40415,_40413,_40449),
    w(verb(do1,inf,fin),_40473,_40449,_40507),
    cc(å,_40507,_40551),
    !,
    pushstack(first,(w(noun(agent,sin,u,n)),aux1,negation(_40185)),nil,_40551,_40741),state(_40111,_40113,_40563,_40741,_40283),
    !.

statem(_40111,_40113,[statem,_40195,_40243],_40161,_40165) --> 
    soredundant(_40195,_40161,_40225),
    sostatem(_40111,_40113,_40243,_40225,_40165).

statem(_40111,_40113,[statem,_40295,_40353,{},_40425,_40503],_40261,_40265) --> 
    w(noun(_40165,_40167,_40169,n),_40295,_40261,_40329),
    look_ahead(w(prep(_40153)),_40353,_40329,_40387),
    {testmember(_40153,[at])},
    pp(_40153,_40155,_40157,_40425,_40387,_40467),
    pushstack(free,(w(noun(_40165,_40167,_40169,n)),pp(_40153,_40155,_40157)),nil,_40467,_40595),
    state(_40111,_40113,_40503,_40595,_40265).

statem(_40111,_40113,[statem,_40343,_40411,{},_40483,_40551,!,_40619,!],_40309,_40313) --> 
    lit_of(_40159,[dette],_40343,_40309,_40381),
    w(verb(_40173,_40175,fin),_40411,_40381,_40445),
    {\+testmember(_40173,[be,give,take,cost])},
    subject(_40211,_40213,_40483,_40445,_40521),
    negation0(_40217,_40551,_40521,_40585),
    !,
    pushstack(first,(xnp(_40211,_40213),w(verb(_40173,_40175,fin)),negation(_40217),[_40159]),nil,_40585,_40803),state(_40111,_40113,_40619,_40803,_40313),
    !.

statem(_40111,_40113,[statem,_40327,{},_40399,!,_40467],_40293,_40297) --> 
    w(adj2(_40177,nil),_40327,_40293,_40361),
    {testmember(_40177,[good,bad,correct,true,mild,hot,cold])},
    w(prep(_40169),_40399,_40361,_40433),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_40177,nil)),w(prep(_40169))),nil,_40433,_40487),
    state(_40111,_40113,_40467,_40487,_40297).

statem(_40111,_40113,[statem,_40327,{},_40399,!,_40467],_40293,_40297) --> 
    w(adj2(_40177,nil),_40327,_40293,_40361),
    {testmember(_40177,[good,bad,correct,true,mild,hot,cold])},
    w(adv(_40169),_40399,_40361,_40433),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_40177,nil)),w(adv(_40169))),nil,_40433,_40487),
    state(_40111,_40113,_40467,_40487,_40297).

statem(_40111,_40113,[statem,_40255,_40303,_40361,!,_40429,!,_40603],_40221,_40225) --> 
    init(_40255,_40221,_40285),
    negation(_40153,_40303,_40285,_40337),
    not_look_ahead(w(verb(_40165,_40167,pass)),_40361,_40337,_40395),
    !,
    pushstack(free,negation(_40153),nil,_40395,_40533),itstatem(_40111,_40113,_40429,_40533,_40563),
    !,
    accept(_40603,_40563,_40225).

statem(_40111,_40113,[statem,_40273,_40321,_40369,_40417,_40475,!,[],_40581],_40239,_40243) --> 
    redundants0(_40273,_40239,_40303),
    dette(_40321,_40303,_40351),
    aux1(_40369,_40351,_40399),
    not_look_ahead([være],_40417,_40399,_40451),
    obvious_object(_40179,_40181,_40475,_40451,_40513),
    !,
    pushstack(free,[dette],nil,_40513,_40579),[],
    pushstack(first,(xnp(_40179,_40181),aux1),nil,_40579,_40755),
    state(_40111,_40113,_40581,_40755,_40243).

statem(_40111,_40113,[statem,_40213,!,_40271,!,_40349],_40179,_40183) --> 
    init(_40213,_40179,_40243),
    !,
    itstatem(_40111,_40113,_40271,_40243,_40309),
    !,
    accept(_40349,_40309,_40183).

statem(_40111,_40117::_40119,[statem,_40213,!,_40291],_40179,_40183) --> 
    state(_40111,_40117::_40119,_40213,_40179,_40251),
    !,
    accept(_40291,_40251,_40183).

statem(_40111,_40117::_40119,[statem,_40399,_40467,_40525,_40573,_40631,lit(å),{},[],{},_40847,{}],_40365,_40369) --> 
    subject(_40195,_40197,_40399,_40365,_40437),
    be(_40187,_40467,_40437,_40501),
    so0(_40525,_40501,_40555),
    gradverb0(_40205,_40573,_40555,_40607),
    w(adj2(_40213,nil),_40631,_40607,_40665),
    cc(å,_40665,_40709),
    {testmember(_40213,[difficult,easy,expensive,free,funny,good,intelligent,sad,stupid,tedious])},
    pushstack(free,xnp(_40195,_40197),nil,_40709,_40831),[],
    {it_template(_40289)},
    pushstack(first,(w(adj2(_40213,nil)),[å]),nil,_40831,_40873),be_complements(_40289,_40111,_40117::_40189,_40847,_40873,_40369),
    {negate(_40187,_40189,_40119)}.

statem(_40111,_40117::_40119,[statem,_40309,_40377,_40425,{},!,_40507,_40555],_40275,_40279) --> 
    np1_accept(_40181,_40183,_40309,_40275,_40347),
    aux1(_40377,_40347,_40407),
    prepnof(_40187,_40425,_40407,_40459),
    {testmember(_40187,[on,to,towards])},
    !,
    accept(_40507,_40459,_40537),
    pushstack(first,(np(_40181,_40183),w(verb(go,pres,fin)),prep(to)),nil,_40537,_40719),
    state(_40111,_40117::_40119,_40555,_40719,_40279).

statem(_40111,_40117::_40119,[statem,_40337,_40395,_40453,_40521,_40569,{},_40641],_40303,_40307) --> 
    not_look_ahead([dette],_40337,_40303,_40371),
    not_look_ahead([det],_40395,_40371,_40429),
    np1_accept(_40197,_40199,_40453,_40429,_40491),
    aux1(_40521,_40491,_40551),
    prepnof(_40177,_40569,_40551,_40603),
    {testmember(_40177,[to,from,near,in,on,past])},
    pushstack(first,(np(_40197,_40199),w(verb(go,pres,fin)),prep(_40177)),nil,_40603,_40809),
    state(_40111,_40117::_40119,_40641,_40809,_40307).

statem(_40111,_40117::_40119,[statem,_40341,_40399,_40457,_40525,_40583,_40631,_40689,_40747,_40805],_40307,_40311) --> 
    not_look_ahead([dette],_40341,_40307,_40375),
    not_look_ahead([det],_40399,_40375,_40433),
    np1_accept(_40211,_40213,_40457,_40433,_40495),
    not_look_ahead([kan],_40525,_40495,_40559),
    aux1(_40583,_40559,_40613),
    look_ahead([hjem],_40631,_40613,_40665),
    not_look_ahead([kunne],_40689,_40665,_40723),
    not_look_ahead(w(verb(_40249,_40251,_40253)),_40747,_40723,_40781),
    pushstack(first,(np(_40211,_40213),w(verb(go,pres,fin))),nil,_40781,_40905),
    state(_40111,_40117::_40119,_40805,_40905,_40311).

statem(_40111,_40113,[statem,_40247,_40295,_40343,[],_40439],_40213,_40217) --> 
    dedette(_40247,_40213,_40277),
    aux1(_40295,_40277,_40325),
    np1_accept(_40153,_40155,_40343,_40325,_40381),
    pushstack(free,[dette],nil,_40381,_40437),[],
    pushstack(first,(xnp(_40153,_40155),aux1),nil,_40437,_40613),
    state(_40111,_40113,_40439,_40613,_40217).

dedette([dedette,lit(det)],_40139,_40143) --> 
    cc(det,_40139,_40143).

dedette([dedette,lit(dette)],_40139,_40143) --> 
    cc(dette,_40139,_40143).

soredundant0([soredundant0,_40163,!],_40141,_40145) --> 
    soredundant(_40163,_40141,_40145),
    !.

soredundant([soredundant,lit(når),!],_40145,_40149) --> 
    cc(når,_40145,_40149),
    !.

soredundant([soredundant,_40163,!],_40141,_40145) --> 
    so(_40163,_40141,_40145),
    !.

soredundant([soredundant,_40157],_40135,_40139) --> 
    redundant(_40157,_40135,_40139).

so([so,lit(så),!],_40145,_40149) --> 
    cc(så,_40145,_40149),
    !.

so([so,lit(derfor),!],_40145,_40149) --> 
    cc(derfor,_40145,_40149),
    !.

so([so,_40181],_40159,_40163) --> 
    look_ahead_lit([kan,må,vil,skal,bør],_40181,_40159,_40163).

so([so,_40173],_40151,_40155) --> 
    look_ahead(w(verb(know,_40121,fin)),_40173,_40151,_40155).

statem(_40111,_40117::_40119,[statem,_40289,_40367,lit(kan),_40437,_40485,_40553,_40601],_40255,_40259) --> 
    adverbx(_40177,_40179,pre,_40289,_40255,_40331),
    saa0(_40367,_40331,_40397),
    cc(kan,_40397,_40435),
    redundant0(_40437,_40435,_40467),
    np1_accept(_40195,_40197,_40485,_40467,_40523),
    redundant0(_40553,_40523,_40583),
    pushstack(free,(noun_phrase1(_40195,_40197),[kan],xadverb(_40177,_40179)),nil,_40583,_40765),
    state(_40111,_40117::_40119,_40601,_40765,_40259).

statem(_40111,_40117::_40119,[statem,_40281,_40359,_40407,_40455,_40503,_40571,_40619],_40247,_40251) --> 
    adverbx(_40177,_40179,pre,_40281,_40247,_40323),
    saa0(_40359,_40323,_40389),
    aux1(_40407,_40389,_40437),
    redundant0(_40455,_40437,_40485),
    np1_accept(_40191,_40193,_40503,_40485,_40541),
    redundant0(_40571,_40541,_40601),
    pushstack(free,(noun_phrase1(_40191,_40193),aux1,xadverb(_40177,_40179)),nil,_40601,_40873),
    state(_40111,_40117::_40119,_40619,_40873,_40251).

statem(_40111,_40117::_40119,[statem,_40287,_40365,_40413,lit(jeg),_40483,!,_40541,_40589],_40253,_40257) --> 
    adverbx(_40183,_40185,pre,_40287,_40253,_40329),
    saa0(_40365,_40329,_40395),
    aux1(_40413,_40395,_40443),
    cc(jeg,_40443,_40481),
    redundant0(_40483,_40481,_40513),
    !,
    accept(_40541,_40513,_40571),
    pushstack(free,([jeg],[skal],xadverb(_40183,_40185)),nil,_40571,_40689),
    state(_40111,_40117::_40119,_40589,_40689,_40257).

statem(_40111,_40117::_40119,[statem,lit(at),_40261,_40329,{}],_40205,_40209) --> 
    cc(at,_40205,_40259),
    statem(_40111,_40117::_40147,_40261,_40259,_40299),
    be_truefalse(_40145,_40329,_40299,_40209),
    {negate(_40145,_40147,_40119)}.

statem(_40111,_40117::_40119,[statem,_40289,_40367,_40415,_40473,_40531],_40255,_40259) --> 
    adverbx(_40165,_40167,pre,_40289,_40255,_40331),
    saa0(_40367,_40331,_40397),
    w(verb(_40183,_40185,_40187),_40415,_40397,_40449),
    negation0(_40191,_40473,_40449,_40507),
    lock(last,_40507,_40723),
    pushstack(last,(w(verb(_40183,_40185,_40187)),negation(_40191),xadverb(_40165,_40167)),nil,_40723,_40735),
    state(_40111,_40117::_40119,_40531,_40735,_40713),
    unlock(_40713,_40259).

statem(_40111,_40117::_40119,[statem,_40311,_40389,_40447,_40515,!,_40583],_40277,_40281) --> 
    adverbx(_40171,_40173,pre,_40311,_40277,_40353),
    w(verb(be,_40191,fin),_40389,_40353,_40423),
    np1_accept(_40197,_40199,_40447,_40423,_40485),
    w(verb(_40207,_40209,part),_40515,_40485,_40549),
    !,
    lock(last,_40549,_40777),
    pushstack(last,(np(_40197,_40199),w(verb(_40207,_40209,fin)),xadverb(_40171,_40173)),nil,_40777,_40789),
    state(_40111,_40117::_40119,_40583,_40789,_40767),
    unlock(_40767,_40281).

statem(_40111,_40117::_40119,[statem,_40295,_40373,_40421,_40489,!,_40557],_40261,_40265) --> 
    adverbx(_40171,_40173,pre,_40295,_40261,_40337),
    be(_40373,_40337,_40403),
    specific_phrase(_40185,_40191::_40193,_40421,_40403,_40459),
    negation0(_40197,_40489,_40459,_40523),
    !,
    pushstack(free,(np(_40185,_40191::_40193),be(_40197),xadverb(_40171,_40173)),nil,_40523,_40797),
    state(_40111,_40117::_40119,_40557,_40797,_40265).

statem(_40111,_40117::_40119,[statem,_40271,_40349,_40407,!,_40475],_40237,_40241) --> 
    adverbx(_40159,_40161,pre,_40271,_40237,_40313),
    w(verb(be,_40179,fin),_40349,_40313,_40383),
    negation0(_40185,_40407,_40383,_40441),
    !,
    pushstack(free,(be(_40185),xadverb(_40159,_40161)),nil,_40441,_40653),
    state(_40111,_40117::_40119,_40475,_40653,_40241).

statem(_40111,_40117::_40119,[statem,_40239,_40317,_40365,_40413],_40205,_40209) --> 
    adverbx(_40147,_40149,pre,_40239,_40205,_40281),
    saa0(_40317,_40281,_40347),
    do(_40365,_40347,_40395),
    pushstack(free,xadverb(_40147,_40149),nil,_40395,_40513),
    state(_40111,_40117::_40119,_40413,_40513,_40209).

statem(_40111,_40113,[statem,_40281,_40359,_40407,_40475,_40533],_40247,_40251) --> 
    adverbx(_40159,_40161,pre,_40281,_40247,_40323),
    has(_40359,_40323,_40389),
    specific_phrase(_40173,_40175,_40407,_40389,_40445),
    w(verb(_40183,past,part),_40475,_40445,_40509),
    lock(last,_40509,_40727),
    pushstack(last,(xnp(_40173,_40175),w(verb(_40183,past,fin)),xadverb(_40159,_40161)),nil,_40727,_40739),
    state(_40111,_40113,_40533,_40739,_40717),
    unlock(_40717,_40251).

statem(_40111,_40113,[statem,_40253,_40331,_40389],_40219,_40223) --> 
    preadverbial1(_40141,_40143,_40145,_40253,_40219,_40295),
    w(verb(be,pres,fin),_40331,_40295,_40365),
    pushstack(free,(w(verb(be,pres,fin)),adverbial1(_40141,_40143,_40145)),nil,_40365,_40491),
    state(_40111,_40113,_40389,_40491,_40223).

statem(_40111,_40113,[statem,_40213,_40261,!,_40319,_40367],_40179,_40183) --> 
    preadverbials0(_40213,_40179,_40243),
    aux1(_40261,_40243,_40291),
    !,
    accept(_40319,_40291,_40349),
    state(_40111,_40113,_40367,_40349,_40183).

statem(_40111,_40117::_40119,[statem,_40265,_40343,!,_40401],_40231,_40235) --> 
    adverbial1(_40159,_40161,_40167::_40169,_40265,_40231,_40307),
    be(_40343,_40307,_40373),
    !,
    pushstack(free,(thereit,be,adverbial1(_40159,_40161,_40167::_40169)),nil,_40373,_40633),
    statem(_40111,_40117::_40119,_40401,_40633,_40235).

statem(_40111,_40117::_40119,[statem,_40335,_40413,_40461,_40529,!,_40597],_40301,_40305) --> 
    preadverbial1(_40177,_40179,_40185::_40187,_40335,_40301,_40377),
    do(_40413,_40377,_40443),
    specific_phrase(_40205,_40211::_40213,_40461,_40443,_40499),
    w(prep(_40221),_40529,_40499,_40563),
    !,
    pushstack(free,(np(_40205,_40211::_40213),w(verb(go,pres,fin)),w(prep(_40221)),adverbial1(_40177,_40179,_40185::_40187)),nil,_40563,_40791),
    state(_40111,_40117::_40119,_40597,_40791,_40305).

statem(_40111,_40117::_40119,[statem,_40253,_40331,!,_40389],_40219,_40223) --> 
    preadverbial1(_40147,_40149,_40155::_40157,_40253,_40219,_40295),
    do(_40331,_40295,_40361),
    !,
    pushstack(free,adverbial1(_40147,_40149,_40155::_40157),nil,_40361,_40497),
    state(_40111,_40117::_40119,_40389,_40497,_40223).

statem(_40111,_40113,[statem,_40289,_40367,_40415,_40473,!,_40551],_40255,_40259) --> 
    preadverbial1(_40165,_40167,_40169,_40289,_40255,_40331),
    so0(_40367,_40331,_40397),
    w(verb(have,_40187,fin),_40415,_40397,_40449),
    subject(_40193,_40195,_40473,_40449,_40511),
    !,
    pushstack(free,(xnp(_40193,_40195),w(verb(have,_40187,fin)),adverbial1(_40165,_40167,_40169)),nil,_40511,_40733),
    state(_40111,_40113,_40551,_40733,_40259).

statem(_40111,_40117::_40119,[statem,{},_40367,_40445,_40523,!,_40621,_40669],_40313,_40317) --> 
    {user:value(dialog,1)},
    preadverbial1(_40207,_40209,_40215::_40217,_40367,_40313,_40409),
    preadverbial1(_40177,_40179,_40185::_40187,_40445,_40409,_40487),
    lexv(_40235,_40237,_40239,fin,_40523,_40487,_40569),
    !,
    accept(_40621,_40569,_40651),
    lock(last,_40651,_40951),
    pushstack(last,(lexv(_40235,_40237,_40239,fin),adverbial1(_40207,_40209,_40215::_40217),adverbial1(_40177,_40179,_40185::_40187)),nil,_40951,_40963),
    state(_40111,_40117::_40119,_40669,_40963,_40941),
    unlock(_40941,_40317).

prestatem(_40111,_40113,[prestatem,_40293,_40351,lit(det),_40441,!,_40509],_40259,_40263) --> 
    w(verb(_40173,_40175,fin),_40293,_40259,_40327),
    gmem(_40173,[be,stand],_40351,_40327,_40389),
    cc(det,_40389,_40439),
    w(adj2(_40163,_40165),_40441,_40439,_40475),
    !,
    pushstack(first,(w(verb(be,_40175,fin)),w(adj2(_40163,_40165))),nil,_40475,_40529),
    itstatem(_40111,_40113,_40509,_40529,_40263).

prestatem(_40111,_40113,[prestatem,_40347,_40395,_40443,_40501,_40549,_40617,_40665,{},_40737,!,_40815],_40313,_40317) --> 
    so0(_40347,_40313,_40377),
    aux1(_40395,_40377,_40425),
    negation0(_40207,_40443,_40425,_40477),
    redundant0(_40501,_40477,_40531),
    object(_40201,_40203,_40549,_40531,_40587),
    redundant0(_40617,_40587,_40647),
    w(verb(_40221,_40223,pass),_40665,_40647,_40699),
    {\+testmember(_40221,[be])},
    whodidit(_40247,_40249,_40737,_40699,_40775),
    !,
    pushstack(first,(xnp(_40247,_40249),w(verb(_40221,_40223,fin)),negation(_40207),xnp(_40201,_40203)),nil,_40775,_41073),
    state(_40111,_40113,_40815,_41073,_40317).

prestatem(_40111,_40113,[prestatem,_40267,_40315,_40373,!,_40461],_40233,_40237) --> 
    shoulditbe(_40267,_40233,_40297),
    not_look_ahead(w(adj2(_40169,_40171)),_40315,_40297,_40349),
    adverbix0(_40153,_40155,_40157,_40373,_40349,_40415),
    !,
    pushstack(free,(w(verb(be,pres,fin)),xadverbial1(_40153,_40155,_40157)),nil,_40415,_40563),
    itstatem(_40111,_40113,_40461,_40563,_40237).

prestatem(_40111,_40113,[prestatem,_40229,lit(det),_40309,!,_40367],_40195,_40199) --> 
    w(verb(be,_40153,fin),_40229,_40195,_40263),
    cc(det,_40263,_40307),
    slikat(_40309,_40307,_40339),
    !,
    state(_40111,_40113,_40367,_40339,_40199).

prestatem(_40111,_40113,[prestatem,_40315,_40373,lit(det),_40463,_40511,_40569,!,_40627,_40695],_40281,_40285) --> 
    w(verb(_40193,_40195,fin),_40315,_40281,_40349),
    gmem(_40193,[have,be],_40373,_40349,_40411),
    cc(det,_40411,_40461),
    redundant0(_40463,_40461,_40493),
    w(verb(_40181,past,part),_40511,_40493,_40545),
    look_ahead_np(_40569,_40545,_40599),
    !,
    subject(_40231,_40233,_40627,_40599,_40665),
    pushstack(first,(xnp(_40231,_40233),w(verb(_40181,past,fin))),nil,_40665,_40795),
    state(_40111,_40113,_40695,_40795,_40285).

prestatem(_40111,_40113,[prestatem,_40285,_40333,_40401,_40459,!,_40537],_40251,_40255) --> 
    has(_40285,_40251,_40315),
    subject(_40171,_40173,_40333,_40315,_40371),
    w(verb(_40181,past,part),_40401,_40371,_40435),
    object(_40165,_40167,_40459,_40435,_40497),
    !,
    pushstack(first,(xnp(_40171,_40173),w(verb(_40181,past,fin)),xnp(_40165,_40167)),nil,_40497,_40717),
    state(_40111,_40113,_40537,_40717,_40255).

prestatem(_40111,_40113,[prestatem,_40321,{},_40393,_40461,_40519,!,_40597],_40287,_40291) --> 
    w(verb(_40181,_40183,fin),_40321,_40287,_40355),
    {\+member(_40181,[])},
    subject(_40203,_40205,_40393,_40355,_40431),
    not_look_ahead(w(verb(_40217,_40219,_40221)),_40461,_40431,_40495),
    object(_40171,_40173,_40519,_40495,_40557),
    !,
    pushstack(first,(xnp(_40203,_40205),w(verb(_40181,past,fin)),xnp(_40171,_40173)),nil,_40557,_40777),
    state(_40111,_40113,_40597,_40777,_40291).

prestatem(_40111,_40113,[prestatem,_40327,_40385,_40443,_40491,lit(det),_40571,_40619,!,_40687],_40293,_40297) --> 
    not_look_ahead(w(verb(be,_40197,_40199)),_40327,_40293,_40361),
    not_look_ahead(w(verb(be1,_40213,_40215)),_40385,_40361,_40419),
    so0(_40443,_40419,_40473),
    w(verb(_40223,_40225,fin),_40491,_40473,_40525),
    cc(det,_40525,_40569),
    not_look_ahead_np(_40571,_40569,_40601),
    negation0(_40183,_40619,_40601,_40653),
    !,
    pushstack(first,([dette],w(verb(_40223,_40225,fin)),negation(_40183)),nil,_40653,_40785),
    state(_40111,_40113,_40687,_40785,_40297).

prestatem(_40111,_40113,[prestatem,_40319,_40377,_40435,_40483,_40541,_40589,_40657,!,_40725],_40285,_40289) --> 
    not_look_ahead(w(verb(be,_40191,_40193)),_40319,_40285,_40353),
    not_look_ahead(w(verb(be1,_40207,_40209)),_40377,_40353,_40411),
    so0(_40435,_40411,_40465),
    w(verb(_40217,_40219,fin),_40483,_40465,_40517),
    det0(_40541,_40517,_40571),
    particlev0(_40217,_40227,_40589,_40571,_40627),
    negation0(_40177,_40657,_40627,_40691),
    !,
    pushstack(free,(w(verb(_40227,_40219,fin)),negation(_40177)),nil,_40691,_40823),
    state(_40111,_40113,_40725,_40823,_40289).

prestatem(_40111,_40113,[prestatem,_40321,_40369,{},_40441,_40489,!,_40557,_40625],_40287,_40291) --> 
    so0(_40321,_40287,_40351),
    w(verb(_40193,_40195,pass),_40369,_40351,_40403),
    {\+testmember(_40193,[be])},
    thereit0(_40441,_40403,_40471),
    negation0(_40219,_40489,_40471,_40523),
    !,
    object(_40183,_40185,_40557,_40523,_40595),
    pushstack(first,([noen],w(verb(_40193,_40195,fin)),negation(_40219),xnp(_40183,_40185)),nil,_40595,_40803),
    state(_40111,_40113,_40625,_40803,_40291).

prestatem(_40111,_40113,[prestatem,_40275,_40333,!,_40401,_40469],_40241,_40245) --> 
    w(verb(be,_40169,fin),_40275,_40241,_40309),
    negation0(_40159,_40333,_40309,_40367),
    !,
    subject(_40179,_40181,_40401,_40367,_40439),
    pushstack(first,(xnp(_40179,_40181),w(verb(be,_40169,fin)),negation(_40159)),nil,_40439,_40647),
    state(_40111,_40113,_40469,_40647,_40245).

prestatem(_40111,_40113,[prestatem,_40295,lit(kan),_40365,_40433,_40481,_40539,!,_40607],_40261,_40265) --> 
    so0(_40295,_40261,_40325),
    cc(kan,_40325,_40363),
    subject(_40187,_40189,_40365,_40363,_40403),
    redundant0(_40433,_40403,_40463),
    not_look_ahead(w(verb(_40201,_40203,_40205)),_40481,_40463,_40515),
    not_look_ahead([ikke],_40539,_40515,_40573),
    !,
    pushstack(free,(xnp(_40187,_40189),w(verb(do1,pres,fin))),nil,_40573,_40707),
    state(_40111,_40113,_40607,_40707,_40265).

prestatem(_40111,_40113,[prestatem,_40257,_40305,_40353,_40421,!,_40489],_40223,_40227) --> 
    so0(_40257,_40223,_40287),
    aux1(_40305,_40287,_40335),
    subject(_40169,_40171,_40353,_40335,_40391),
    negation0(_40165,_40421,_40391,_40455),
    !,
    pushstack(free,(xnp(_40169,_40171),aux1,negation(_40165)),nil,_40455,_40741),
    state(_40111,_40113,_40489,_40741,_40227).

itstatem(_40111,_40113,[itstatem,_40289,_40337,lit(at),_40427,!,_40505,_40573],_40255,_40259) --> 
    be(_40289,_40255,_40319),
    np0_accept(_40171,_40173,_40337,_40319,_40375),
    cc(at,_40375,_40425),
    traceprint(4,it00,_40427,_40425,_40465),
    !,
    clausal_object1(_40193,_40195,_40505,_40465,_40543),
    pushstack(first,(xnp(_40193,_40195),w(verb(be,pres,fin)),xnp(_40171,_40173)),nil,_40543,_40753),
    state(_40111,_40113,_40573,_40753,_40259).

itstatem(_40111,_40113,[itstatem,_40257,_40305,_40363,_40411,!,_40489],_40223,_40227) --> 
    be(_40257,_40223,_40287),
    not_look_ahead(w(adj2(_40173,_40175)),_40305,_40287,_40339),
    look_ahead_np(_40363,_40339,_40393),
    traceprint(4,it01,_40411,_40393,_40449),
    !,
    pushstack(free,w(verb(exist,pres,fin)),nil,_40449,_40509),
    state(_40111,_40113,_40489,_40509,_40227).

itstatem(_40111,_40113,[itstatem,_40265,{},_40337,_40385,!,_40463],_40231,_40235) --> 
    w(verb(_40157,_40159,fin),_40265,_40231,_40299),
    {_40157\==be},
    look_ahead_np(_40337,_40299,_40367),
    traceprint(4,it02,_40385,_40367,_40423),
    !,
    pushstack(free,w(verb(_40157,_40159,fin)),nil,_40423,_40483),
    state(_40111,_40113,_40463,_40483,_40235).

itstatem(_40111,_40113,[itstatem,_40319,_40377,{},_40489,_40557,!,_40635],_40285,_40289) --> 
    negation0(_40175,_40319,_40285,_40353),
    hlexv(_40179,_40181,_40183,fin,_40187,_40377,_40353,_40427),
    {bigno(_40175,_40187,_40171)},
    gmem(_40181,[help,give,make,create],_40489,_40427,_40527),
    traceprint(4,it0,_40557,_40527,_40595),
    !,
    pushstack(first,([dette],w(verb(_40181,_40183,fin)),negation(_40171)),nil,_40595,_40733),
    state(_40111,_40113,_40635,_40733,_40289).

itstatem(_40111,_40113,[itstatem,_40287,_40345,_40413,_40481,_40549],_40253,_40257) --> 
    w(verb(_40167,_40169,fin),_40287,_40253,_40321),
    gmem(_40167,[have],_40345,_40321,_40383),
    subject(_40185,_40187,_40413,_40383,_40451),
    traceprint(4,it1,_40481,_40451,_40519),
    pushstack(first,(xnp(_40185,_40187),w(verb(_40167,_40169,fin)),[dette]),nil,_40519,_40649),
    state(_40111,_40113,_40549,_40649,_40257).

itstatem(_40111,_40113,[itstatem,_40279,lit(at),_40399,_40447,!,_40525],_40245,_40249) --> 
    lexvaccept(rv,_40171,_40173,fin,_40165,_40279,_40245,_40329),
    cc(at,_40329,_40397),
    look_ahead_np(_40399,_40397,_40429),
    traceprint(4,it2,_40447,_40429,_40485),
    !,
    pushstack(first,([dette],w(verb(_40171,_40173,fin)),negation(_40165)),nil,_40485,_40623),
    state(_40111,_40113,_40525,_40623,_40249).

itstatem(_40111,_40113,[itstatem,_40359,_40407,_40455,_40513,_40571,_40629,lit(som),_40719,_40777,!,_40855,!,_41109],_40325,_40329) --> 
    be(_40359,_40325,_40389),
    redundant0(_40407,_40389,_40437),
    negation0(_40189,_40455,_40437,_40489),
    not_look_ahead(w(nb(_40201,_40203)),_40513,_40489,_40547),
    not_look_ahead_lit([jeg,du],_40571,_40547,_40605),
    np0_accept(_40219,_40221,_40629,_40605,_40667),
    cc(som,_40667,_40717),
    w(verb(_40233,_40235,fin),_40719,_40717,_40753),
    traceprint(4,it3,_40777,_40753,_40815),
    !,
    pushstack(first,(xnp(_40219,_40221),w(verb(_40233,_40235,fin)),negation(_40189)),nil,_40815,_41039),state(_40111,_40113,_40855,_41039,_41069),
    !,
    accept(_41109,_41069,_40329).

itstatem(_40111,_40113,[itstatem,_40365,_40413,_40481,_40539,_40597,_40655,_40713,!,_40791],_40331,_40335) --> 
    be(_40365,_40331,_40395),
    subject(_40205,_40207,_40413,_40395,_40451),
    negation0(_40211,_40481,_40451,_40515),
    not_look_ahead(noun(_40219,_40221,_40223,_40225),_40539,_40515,_40573),
    w(adj2(_40233,nil),_40597,_40573,_40631),
    w(prep(_40243),_40655,_40631,_40689),
    traceprint(4,it4,_40713,_40689,_40751),
    !,
    pushstack(first,(xnp(_40205,_40207),w(verb(be,pres,fin)),negation(_40211),w(adj2(_40233,nil)),w(prep(_40243)),[dette]),nil,_40751,_40969),
    state(_40111,_40113,_40791,_40969,_40335).

itstatem(_40111,_40113,[itstatem,_40303,_40351,_40419,_40477,_40535,!,_40613],_40269,_40273) --> 
    aux1(_40303,_40269,_40333),
    subject(_40181,_40183,_40351,_40333,_40389),
    negation0(_40187,_40419,_40389,_40453),
    w(verb(_40195,_40197,fin),_40477,_40453,_40511),
    traceprint(4,it5,_40535,_40511,_40573),
    !,
    pushstack(first,(xnp(_40181,_40183),w(verb(_40195,pres,fin)),negation(_40187),[dette]),nil,_40573,_40791),
    state(_40111,_40113,_40613,_40791,_40273).

itstatem(_40111,_40113,[itstatem,_40341,_40399,_40457,lit(å),_40537,!,_40615,_40701],_40307,_40311) --> 
    be(_40193,_40341,_40307,_40375),
    gradverb0(_40197,_40399,_40375,_40433),
    w(adj2(_40187,_40189),_40457,_40433,_40491),
    cc(å,_40491,_40535),
    traceprint(4,it7,_40537,_40535,_40575),
    !,
    pushstack(first,([jeg],[vil]),nil,_40575,_40641),clausal_object1(_40237,_40239,_40615,_40641,_40671),
    pushstack(first,(xnp(_40237,_40239),w(verb(be,pres,fin)),negation(_40193),w(adj2(_40187,_40189))),nil,_40671,_40879),
    state(_40111,_40113,_40701,_40879,_40311).

itstatem(_40111,_40113,[itstatem,_40303,_40361,_40449,_40527,!,_40605],_40269,_40273) --> 
    be(_40181,_40303,_40269,_40337),
    ap(_40171,_40173,_40111,_40177,_40361,_40337,_40407),
    pp(with,_40197,_40199,_40449,_40407,_40491),
    traceprint(4,it8,_40527,_40491,_40565),
    !,
    pushstack(first,(xnp(_40197,_40199),w(verb(be,pres,fin)),negation(_40181),ap(_40171,_40173,_40111,_40177)),nil,_40565,_40855),
    state(_40111,_40113,_40605,_40855,_40273).

itstatem(_40111,_40113,[itstatem,_40321,_40379,_40437,lit(at),_40517,!,_40595,_40663],_40287,_40291) --> 
    be(_40193,_40321,_40287,_40355),
    gradverb0(_40197,_40379,_40355,_40413),
    w(adj2(_40187,_40189),_40437,_40413,_40471),
    cc(at,_40471,_40515),
    traceprint(4,it9,_40517,_40515,_40555),
    !,
    clausal_object1(_40221,_40223,_40595,_40555,_40633),
    pushstack(first,(xnp(_40221,_40223),w(verb(be,pres,fin)),negation(_40193),w(adj2(_40187,_40189))),nil,_40633,_40841),
    state(_40111,_40113,_40663,_40841,_40291).

itstatem(_40111,_40113,[itstatem,_40375,_40433,_40491,_40549,_40607,lit(å),_40697,!,_40775,_40823,_40989],_40341,_40345) --> 
    be(_40211,_40375,_40341,_40409),
    gradverb0(_40215,_40433,_40409,_40467),
    w(adj2(_40205,_40207),_40491,_40467,_40525),
    w(prep(for),_40549,_40525,_40583),
    object(_40237,_40239,_40607,_40583,_40645),
    cc(å,_40645,_40695),
    traceprint(4,it10,_40697,_40695,_40735),
    !,
    accept(_40775,_40735,_40805),
    pushstack(first,(xnp(_40237,_40239),[vil]),nil,_40805,_40929),clausal_object1(_40269,_40271,_40823,_40929,_40959),
    pushstack(first,(xnp(_40269,_40271),w(verb(be,pres,fin)),negation(_40211),w(adj2(_40205,_40207))),nil,_40959,_41167),
    state(_40111,_40113,_40989,_41167,_40345).

itstatem(_40111,_40113,[itstatem,_40355,_40413,_40471,lit(å),_40571,!,_40649,_40697,_40783],_40321,_40325) --> 
    be(_40203,_40355,_40321,_40389),
    w(adj2(_40211,_40213),_40413,_40389,_40447),
    pp(_40195,_40197,_40199,_40471,_40447,_40513),
    cc(å,_40513,_40569),
    traceprint(4,it11,_40571,_40569,_40609),
    !,
    accept(_40649,_40609,_40679),
    pushstack(first,[noen],nil,_40679,_40723),clausal_object1(_40245,_40247,_40697,_40723,_40753),
    pushstack(first,(xnp(_40245,_40247),w(verb(be,pres,fin)),negation(_40203),w(adj2(_40211,_40213)),pp(_40195,_40197,_40199)),nil,_40753,_41043),
    state(_40111,_40113,_40783,_41043,_40325).

itstatem(_40111,_40113,[itstatem,_40379,_40437,lit(å),_40547,_40605,_40663,!,_40741,_40827],_40345,_40349) --> 
    be(_40199,_40379,_40345,_40413),
    adj1(_40189,_40213:_40215,_40193,_40195,_40437,_40413,_40483),
    cc(å,_40483,_40545),
    w(verb(_40227,inf,fin),_40547,_40545,_40581),
    reflexiv0(_40227,_40605,_40581,_40639),
    traceprint(4,it12,_40663,_40639,_40701),
    !,
    pushstack(first,([noen],w(verb(_40227,pres,fin))),nil,_40701,_40767),clausal_object1(_40269,_40271,_40741,_40767,_40797),
    pushstack(first,(xnp(_40269,_40271),w(verb(be,pres,fin)),negation(_40199),adj1(_40189,_40213:_40309,_40193,_40195)),nil,_40797,_41095),
    state(_40111,_40113,_40827,_41095,_40349).

itstatem(_40111,_40113,[itstatem,_40293,_40351,_40439,_40487,!,_40565],_40259,_40263) --> 
    be(_40181,_40293,_40259,_40327),
    adj1(_40171,_40173,_40175,_40177,_40351,_40327,_40397),
    not_look_ahead_np(_40439,_40397,_40469),
    traceprint(4,it13,_40487,_40469,_40525),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_40181),adj1(_40171,_40173,_40175,_40177)),nil,_40525,_40731),
    state(_40111,_40113,_40565,_40731,_40263).

itstatem(_40111,_40117::_40119,[itstatem,_40367,_40415,_40463,_40511,_40569,_40627,_40685,_40743,lit(som),_40833,_40901,!,_41155],_40333,_40337) --> 
    be(_40367,_40333,_40397),
    preadverbials0(_40415,_40397,_40445),
    redundant0(_40463,_40445,_40493),
    negation0(_40195,_40511,_40493,_40545),
    not_look_ahead(w(nb(_40207,_40209)),_40569,_40545,_40603),
    not_look_ahead_lit([jeg,du],_40627,_40603,_40661),
    not_look_ahead([det],_40685,_40661,_40719),
    np1_accept(_40233,_40235,_40743,_40719,_40781),
    cc(som,_40781,_40831),
    traceprint(4,it14a,_40833,_40831,_40871),
    pushstack(first,(xnp(_40233,_40235),w(verb(be,pres,fin)),negation(_40195)),nil,_40871,_41085),state(_40111,_40117::_40119,_40901,_41085,_41115),
    !,
    accept(_41155,_41115,_40337).

itstatem(_40111,_40113,[itstatem,_40267,_40315,_40373,_40421,!,_40499],_40233,_40237) --> 
    be(_40267,_40233,_40297),
    negation0(_40165,_40315,_40297,_40349),
    not_look_ahead_np(_40373,_40349,_40403),
    traceprint(4,it14b,_40421,_40403,_40459),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_40165)),nil,_40459,_40597),
    state(_40111,_40113,_40499,_40597,_40237).

itstatem(_40111,_40113,[itstatem,_40297,_40355,lit(med),_40445,_40513,!,_40591],_40263,_40267) --> 
    w(verb(_40169,_40171,fin),_40297,_40263,_40331),
    gmem(_40169,[help,function],_40355,_40331,_40393),
    cc(med,_40393,_40443),
    np0_accept(_40207,_40209,_40445,_40443,_40483),
    traceprint(4,it15,_40513,_40483,_40551),
    !,
    pushstack(first,(xnp(_40207,_40209),w(verb(_40169,_40171,fin))),nil,_40551,_40691),
    state(_40111,_40113,_40591,_40691,_40267).

itstatem(_40111,_40113,[itstatem,_40341,_40399,_40467,lit(å),_40557,!,_40635,_40721],_40307,_40311) --> 
    w(verb(_40187,_40189,fin),_40341,_40307,_40375),
    gmem(_40187,[cost,take],_40399,_40375,_40437),
    np0_accept(_40177,_40179,_40467,_40437,_40505),
    cc(å,_40505,_40555),
    traceprint(4,it16,_40557,_40555,_40595),
    !,
    pushstack(first,([noen],[vil]),nil,_40595,_40661),clausal_object1(_40241,_40243,_40635,_40661,_40691),
    pushstack(first,(xnp(_40241,_40243),w(verb(_40187,_40189,fin)),xnp(_40177,_40179)),nil,_40691,_40901),
    state(_40111,_40113,_40721,_40901,_40311).

itstatem(_40111,_40117::_40119,[itstatem,_40283,_40341,_40389,_40447,_40495,_40543,_40611,{}],_40249,_40253) --> 
    w(verb(go,pres,fin),_40283,_40249,_40317),
    redundants0(_40341,_40317,_40371),
    negation0(_40169,_40389,_40371,_40423),
    ann0(_40447,_40423,_40477),
    infinitive(_40495,_40477,_40525),
    traceprint(4,it17,_40543,_40525,_40581),
    pushstack(first,someone,nil,_40581,_40711),state(_40111,_40117::_40171,_40611,_40711,_40253),
    {negate(_40169,_40171,_40119)}.

itstatem(_40111,_40113,[itstatem,_40327,_40385,{},_40497,_40585,_40633,!,_40711],_40293,_40297) --> 
    negation0(_40193,_40327,_40293,_40361),
    hlexv(_40197,go,_40201,fin,_40205,_40385,_40361,_40435),
    {bigno(_40193,_40205,_40217)},
    optional([an],_40497,_40435,_40561),
    not_look_ahead_np(_40585,_40561,_40615),
    traceprint(4,it17b,_40633,_40615,_40671),
    !,
    pushstack(first,([dette],w(verb(be,_40201,fin)),negation(_40217),w(adj2(possible,nil))),nil,_40671,_40809),
    state(_40111,_40113,_40711,_40809,_40297).

itstatem(_40111,_40113,[itstatem,_40345,_40403,{},{},_40529,_40577,_40625,!,_40703,_40771],_40311,_40315) --> 
    negation0(_40193,_40345,_40311,_40379),
    hlexv(_40197,_40199,_40201,fin,_40205,_40403,_40379,_40453),
    {bigno(_40193,_40205,_40189)},
    {\+testmember(_40199,[cost,take])},
    preadverbials0(_40529,_40453,_40559),
    look_ahead_np(_40577,_40559,_40607),
    traceprint(4,it18,_40625,_40607,_40663),
    !,
    subject(_40249,_40251,_40703,_40663,_40741),
    pushstack(first,(xnp(_40249,_40251),w(verb(_40199,_40201,fin)),negation(_40189)),nil,_40741,_40949),
    state(_40111,_40113,_40771,_40949,_40315).

itstatem(_40111,_40113,[itstatem,_40297,lit(å),_40377,!,_40455,_40541],_40263,_40267) --> 
    w(verb(_40163,_40165,fin),_40297,_40263,_40331),
    cc(å,_40331,_40375),
    traceprint(4,it19,_40377,_40375,_40415),
    !,
    pushstack(first,([noen],[vil]),nil,_40415,_40481),clausal_object1(_40209,_40211,_40455,_40481,_40511),
    pushstack(first,(xnp(_40209,_40211),w(verb(_40163,_40165,fin))),nil,_40511,_40641),
    state(_40111,_40113,_40541,_40641,_40267).

itstatem(_40111,_40113,[itstatem,_40311,_40359,_40407,_40465,lit(at),_40545,!,_40623,_40671],_40277,_40281) --> 
    blei(_40311,_40277,_40341),
    redundant0(_40359,_40341,_40389),
    negation0(_40193,_40407,_40389,_40441),
    w(verb(_40201,past,part),_40465,_40441,_40499),
    cc(at,_40499,_40543),
    traceprint(4,it20,_40545,_40543,_40583),
    !,
    accept(_40623,_40583,_40653),
    pushstack(first,([noen],w(verb(_40201,past,fin)),negation(_40193),[at]),nil,_40653,_40769),
    state(_40111,_40113,_40671,_40769,_40281).

itstatem(_40111,_40113,[itstatem,_40351,_40399,_40477,_40525,_40583,_40641,_40709,!,_40787,_40835],_40317,_40321) --> 
    blei(_40351,_40317,_40381),
    preadverbial0(_40201,_40203,_40205,_40399,_40381,_40441),
    redundant0(_40477,_40441,_40507),
    negation0(_40217,_40525,_40507,_40559),
    w(verb(_40225,past,part),_40583,_40559,_40617),
    object(_40233,_40235,_40641,_40617,_40679),
    traceprint(4,it21,_40709,_40679,_40747),
    !,
    accept(_40787,_40747,_40817),
    pushstack(first,(xnp(_40233,_40235),w(verb(be,pres,fin)),negation(_40217),w(verb(_40225,past,part)),adverbial1(_40201,_40203,_40205)),nil,_40817,_41095),
    state(_40111,_40113,_40835,_41095,_40321).

itstatem(_40111,_40113,[itstatem,_40273,_40331,_40389,!,_40467],_40239,_40243) --> 
    w(verb(_40167,_40169,pass),_40273,_40239,_40307),
    negation0(_40159,_40331,_40307,_40365),
    traceprint(4,it23,_40389,_40365,_40427),
    !,
    pushstack(first,([noen],w(verb(_40167,_40169,fin)),negation(_40159)),nil,_40427,_40565),
    state(_40111,_40113,_40467,_40565,_40243).

itstatem(_40111,_40113,[itstatem,_40343,_40401,_40449,{},_40521,_40569,!,_40647],_40309,_40313) --> 
    w(verb(be,_40199,fin),_40343,_40309,_40377),
    redundant0(_40401,_40377,_40431),
    w(adj2(_40187,nil),_40449,_40431,_40483),
    {testmember(_40187,[certain,uncertain,good,bad])},
    atom(_40521,_40483,_40551),
    traceprint(4,it24,_40569,_40551,_40607),
    !,
    pushstack(first,state(_40111,_40113)\(xnp(_40247,_40249),w(verb(be,_40199,fin)),w(adj2(_40187,nil))),nil,_40607,_40739),
    clausal_object1(_40247,_40249,_40647,_40739,_40313).

atom([atom,lit(at)],_40139,_40143) --> 
    cc(at,_40139,_40143).

atom([atom,lit(om)],_40139,_40143) --> 
    cc(om,_40139,_40143).

itstatem(_40111,_40113,[itstatem,_40387,_40445,_40493,lit(å),_40573,_40631,_40689,_40737,!,_40815,_40901],_40353,_40357) --> 
    w(verb(be,_40211,fin),_40387,_40353,_40421),
    redundant0(_40445,_40421,_40475),
    w(adj2(_40199,nil),_40493,_40475,_40527),
    cc(å,_40527,_40571),
    w(verb(_40235,inf,fin),_40573,_40571,_40607),
    reflexiv0(_40235,_40631,_40607,_40665),
    not_look_ahead_np(_40689,_40665,_40719),
    traceprint(4,it25,_40737,_40719,_40775),
    !,
    pushstack(first,([noen],w(verb(_40235,pres,fin)),[dette]),nil,_40775,_40841),clausal_object1(_40275,_40277,_40815,_40841,_40871),
    pushstack(first,(xnp(_40275,_40277),w(verb(be,_40211,fin)),w(adj2(_40199,nil))),nil,_40871,_41001),
    state(_40111,_40113,_40901,_41001,_40357).

itstatem(_40111,_40113,[itstatem,_40301,_40359,_40417,_40475,!,_40553],_40267,_40271) --> 
    w(verb(be,_40185,fin),_40301,_40267,_40335),
    negation0(_40191,_40359,_40335,_40393),
    w(prep(_40175),_40417,_40393,_40451),
    traceprint(4,it26,_40475,_40451,_40513),
    !,
    pushstack(first,([dette],w(verb(be,_40185,fin)),negation(_40191),w(prep(_40175))),nil,_40513,_40651),
    state(_40111,_40113,_40553,_40651,_40271).

itstatem(_40111,_40113,[itstatem,_40361,_40419,lit(å),_40499,_40557,!,_40635,!,_40731],_40327,_40331) --> 
    w(verb(be,pres,fin),_40361,_40327,_40395),
    w(adj2(_40187,nil),_40419,_40395,_40453),
    cc(å,_40453,_40497),
    w(verb(_40223,inf,fin),_40499,_40497,_40533),
    traceprint(4,it27,_40557,_40533,_40595),
    !,
    pushstack(first,([jeg],w(verb(_40223,pres,fin))),nil,_40595,_40661),clausal_object1(_40261,_40263,_40635,_40661,_40691),
    !,
    pushstack(first,(xnp(_40261,_40263),w(verb(be,pres,fin)),w(adj2(_40187,nil))),nil,_40691,_40831),
    state(_40111,_40113,_40731,_40831,_40331).

itstatem(_40111,_40113,[itstatem,_40293,{},_40365,_40433,!,_40511],_40259,_40263) --> 
    w(verb(_40173,_40175,fin),_40293,_40259,_40327),
    {verbtype(_40173,rv)},
    subject(_40191,_40193,_40365,_40327,_40403),
    traceprint(4,it28,_40433,_40403,_40471),
    !,
    pushstack(first,(xnp(_40191,_40193),w(verb(_40173,pres,fin)),[dette]),nil,_40471,_40611),
    state(_40111,_40113,_40511,_40611,_40263).

itstatem(_40111,_40113,[itstatem,_40375,_40433,_40501,_40549,_40607,{},lit(noe),lit(om),_40723,_40791],_40341,_40345) --> 
    w(verb(have,_40217,fin),_40375,_40341,_40409),
    subject(_40223,_40225,_40433,_40409,_40471),
    redundant0(_40501,_40471,_40531),
    negation0(_40229,_40549,_40531,_40583),
    w(verb(_40237,past,part),_40607,_40583,_40641),
    {testmember(_40237,[tell])},
    cc(noe,_40641,_40699),
    cc(om,_40699,_40721),
    traceprint(4,it29,_40723,_40721,_40761),
    pushstack(first,(xnp(_40223,_40225),w(verb(_40237,past,fin)),negation(_40229),[noe],[om],[det]),nil,_40761,_40969),
    state(_40111,_40113,_40791,_40969,_40345).

itstatem(_40111,_40113,[itstatem,_40283,{},_40355,!,_40433],_40249,_40253) --> 
    w(verb(_40157,_40171,fin),_40283,_40249,_40317),
    {testmember(_40157,[concern])},
    traceprint(4,it30,_40355,_40317,_40393),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_40157,pres,fin))),nil,_40393,_40453),
    state(_40111,_40113,_40433,_40453,_40253).

itstatem(_40111,_40113,[itstatem,_40337,{},_40409,_40467,_40555,!,_40633],_40303,_40307) --> 
    w(verb(_40183,_40185,fin),_40337,_40303,_40371),
    {testmember(_40183,[go,look,see,function])},
    w(adv(_40175),_40409,_40371,_40443),
    optional([ut],_40467,_40443,_40531),
    traceprint(4,it31,_40555,_40531,_40593),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_40183,pres,fin)),w(adv(_40175))),nil,_40593,_40653),
    state(_40111,_40113,_40633,_40653,_40307).

itstatem(_40111,_40117::_40119,[itstatem,_40291,{},_40363,!,_40441],_40257,_40261) --> 
    w(verb(_40161,_40175,fin),_40291,_40257,_40325),
    {testmember(_40161,[rain,snow,look,be_urgent])},
    traceprint(4,it32,_40363,_40325,_40401),
    !,
    pushstack(first,(something,lexv(iv,_40161,pres,fin)),nil,_40401,_40601),
    state(_40111,_40117::_40119,_40441,_40601,_40261).

itstatem(_40111,_40117::_40119,[itstatem,_40265,{},_40347,_40415],_40231,_40235) --> 
    pvimodal(_40151,_40161,_40265,_40231,_40303),
    {constrainit(_40169,thing)},
    traceprint(4,it32,_40347,_40303,_40385),
    pushstack(first,w(verb(_40151,pres,fin)),nil,_40385,_40435),
    verb_phrase1(_40151,_40169,id,_40111,_40117::_40119,_40415,_40435,_40235).

itstatem(_40111,_40117::_40119,[itstatem,_40285,_40353,_40421,_40489,{}],_40251,_40255) --> 
    beginverb(_40159,_40151,_40285,_40251,_40323),
    np1(_40165,_40167,_40353,_40323,_40391),
    traceprint(4,it33,_40421,_40391,_40459),
    pushstack(first,(np1(_40165,_40167),w(verb(_40159,pres,fin))),nil,_40459,_40587),state(_40111,_40117::_40153,_40489,_40587,_40255),
    {negate(_40151,_40153,_40119)}.

itstatem(_40111,_40117::_40119,[itstatem,_40265,_40313,_40391,_40439,_40507],_40231,_40235) --> 
    be(_40265,_40231,_40295),
    adverbial(_40153,_40155,_40161::_40163,_40313,_40295,_40355),
    that(_40391,_40355,_40421),
    traceprint(4,it34,_40439,_40421,_40477),
    lock(last,_40477,_40613),
    pushstack(last,adverbial(_40153,_40155,_40161::_40163),nil,_40613,_40625),
    state(_40111,_40117::_40119,_40507,_40625,_40603),
    unlock(_40603,_40235).

itstatem(_40111,_40117::_40119,[itstatem,_40303,_40351,_40409,_40457,_40515,_40573,_40631,!,_40709,_40757],_40269,_40273) --> 
    be(_40303,_40269,_40333),
    negation0(_40189,_40351,_40333,_40385),
    saa0(_40409,_40385,_40439),
    not_look_ahead(w(verb(_40201,past,part)),_40457,_40439,_40491),
    w(adj2(_40213,nil),_40515,_40491,_40549),
    one_of_lit([at,om],_40573,_40549,_40607),
    traceprint(4,it35,_40631,_40607,_40669),
    !,
    accept(_40709,_40669,_40739),
    statem(_40111,_40117::_40119,_40757,_40739,_40273).

itstatem(_40111,_40117::_40119,[itstatem,_40295,_40343,_40401,_40449,{},_40521,_40579,_40647],_40261,_40265) --> 
    be(_40295,_40261,_40325),
    negation0(_40177,_40343,_40325,_40377),
    saa0(_40401,_40377,_40431),
    w(adj2(_40185,nil),_40449,_40431,_40483),
    {testmember(_40185,[good])},
    not_look_ahead(w(noun(_40213,_40215,_40217,_40219)),_40521,_40483,_40555),
    traceprint(4,it36,_40579,_40555,_40617),
    statem(_40111,_40117::_40119,_40647,_40617,_40265).

itstatem(_40111,_40117::_40119,[itstatem,_40389,{},_40461,_40509,_40567,{},_40639,_40707,{}],_40355,_40359) --> 
    be(_40175,_40389,_40355,_40423),
    {it_template(_40191)},
    so0(_40461,_40423,_40491),
    gradverb0(_40195,_40509,_40491,_40543),
    w(adj2(_40203,nil),_40567,_40543,_40601),
    {testmember(_40203,[difficult,easy,expensive,free,funny,good,intelligent,mild,hot,cold,wet,dark,bright,cloudy,sad,stupid,tedious])},
    traceprint(4,it37,_40639,_40601,_40677),
    pushstack(first,w(adj2(_40203,nil)),nil,_40677,_40733),be_complements(_40191,_40111,_40117::_40177,_40707,_40733,_40359),
    {negate(_40175,_40177,_40119)}.

itstatem(_40111,_40117::_40119,[itstatem,_40317,{},_40419,_40477,_40555,!,_40633],_40283,_40287) --> 
    lexv(iv,_40185,_40187,fin,_40317,_40283,_40363),
    {\+testmember(_40185,be)},
    negation0(_40207,_40419,_40363,_40453),
    adverb(_40177,_40179,_40215,_40477,_40453,_40519),
    traceprint(4,it38,_40555,_40519,_40593),
    !,
    pushstack(free,(lexv(iv,_40185,_40187,fin),negation(_40207),xadverb(_40177,_40179)),nil,_40593,_40879),
    state(_40111,_40117::_40119,_40633,_40879,_40287).

itstatem(_40111,_40113,[itstatem,_40275,_40333,_40401,!,_40479,!],_40241,_40245) --> 
    be(_40147,_40275,_40241,_40309),
    subject(_40151,_40153,_40333,_40309,_40371),
    traceprint(4,it39,_40401,_40371,_40439),
    !,
    pushstack(first,(xnp(_40151,_40153),w(verb(exist,pres,fin)),negation(_40147)),nil,_40439,_40663),state(_40111,_40113,_40479,_40663,_40245),
    !.

statreal(_40111,[statreal,_40177],_40149,_40153) --> 
    stat(real,_40111,_40177,_40149,_40153).

stat(_40111,_40113,[stat,_40217,_40285],_40183,_40187) --> 
    state(_40125,_40139::_40141,_40217,_40183,_40255),
    worldcomp(_40111,_40125,_40139::_40141,_40113,_40285,_40255,_40187).

statreal1(_40111,[statreal1,_40193,_40261],_40165,_40169) --> 
    state1(_40123,_40125,_40193,_40165,_40231),
    worldcomp(real,_40123,_40125,_40111,_40261,_40231,_40169).

state1(_40111,_40117::_40119,[state1,_40287,_40355,_40413,!,_40471,{},{},!],_40253,_40257) --> 
    np(_40165,_40171::_40119,_40287,_40253,_40325),
    negation0(_40177,_40355,_40325,_40389),
    redundant0(_40413,_40389,_40443),
    !,
    vp(_40165,_40183,_40111,_40117::_40193,_40471,_40443,_40257),
    {bigno(_40177,_40183,_40205)},
    {negate(_40205,_40193,_40171)},
    !.

substate(_40111,_40117::_40119,[substate,_40281,_40349,_40397,!,_40465,{},{}],_40247,_40251) --> 
    subject(_40171,_40167::_40119,_40281,_40247,_40319),
    preadverbials0(_40349,_40319,_40379),
    negation0(_40183,_40397,_40379,_40431),
    !,
    vp(_40171,_40189,_40111,_40117::_40165,_40465,_40431,_40251),
    {bigno(_40183,_40189,_40163)},
    {negate(_40163,_40165,_40167)}.

state(_40111,_40117::_40119,[state,_40275,_40343,_40391,_40449,{},{}],_40241,_40245) --> 
    subject(_40165,_40161::_40119,_40275,_40241,_40313),
    redundant0(_40343,_40313,_40373),
    negation0(_40177,_40391,_40373,_40425),
    vp(_40165,_40183,_40111,_40117::_40159,_40449,_40425,_40245),
    {bigno(_40177,_40183,_40157)},
    {negate(_40157,_40159,_40161)}.

beginverb(_40111,_40113,[beginverb,_40229,_40287,_40345,_40393],_40195,_40199) --> 
    w(verb(start,_40153,fin),_40229,_40195,_40263),
    negation0(_40113,_40287,_40263,_40321),
    infinitiveand(_40345,_40321,_40375),
    w(verb(_40111,_40141,fin),_40393,_40375,_40199).

question(_40111,[question,_40255,_40313,!,_40371],_40227,_40231) --> 
    w(noun(clock,sin,_40173,n),_40255,_40227,_40289),
    terminator(_40313,_40289,_40343),
    !,
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(clock,sin,def,n))),nil,_40343,_40391),
    whatq(_40111,_40371,_40391,_40231).

question(_40111,[question,_40175],_40147,_40151) --> 
    whichq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    whoq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    whenq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    howadjq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    whereq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    wherefromq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    whatq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    howmuchq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    whyq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    howq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    ppq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40175],_40147,_40151) --> 
    whoseq(_40111,_40175,_40147,_40151).

question(_40111,[question,_40273,_40321,!,_40389,_40457,!,_40515],_40245,_40249) --> 
    be(_40273,_40245,_40303),
    w(noun(clock,_40195,_40197,_40199),_40321,_40303,_40355),
    !,
    np1(_40203,_40205,_40389,_40355,_40427),
    danow0(_40457,_40427,_40487),
    !,
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_40487,_40681),
    whatq(_40111,_40515,_40681,_40249).

question(_40111,[question,_40175],_40147,_40151) --> 
    question1(_40111,_40175,_40147,_40151).

question1(test:::_40117,[question1,lit(får),_40253,!,_40331],_40203,_40207) --> 
    cc(får,_40203,_40251),
    specific_phrase(_40159,_40161,_40253,_40251,_40291),
    !,
    pushstack(first,(np(_40159,_40161),[får]),nil,_40291,_40431),
    statement(_40117,_40331,_40431,_40207).

question1(new:::_40117,[question1,_40289,_40347,{},_40419,!,_40487],_40261,_40265) --> 
    w(verb(have,pres,fin),_40289,_40261,_40323),
    w(verb(_40167,past,part),_40347,_40323,_40381),
    {testmember(_40167,[want,think])},
    not_look_ahead([du],_40419,_40381,_40453),
    !,
    pushstack(first,([jeg],w(verb(_40167,pres,fin))),nil,_40453,_40507),
    statement(_40117,_40487,_40507,_40265).

question1(new:::_40117,[question1,_40287,{},_40359,_40427,!,_40495],_40259,_40263) --> 
    w(verb(_40179,pres,fin),_40287,_40259,_40321),
    {testmember(_40179,[want,think,hope])},
    particlev0(_40179,_40167,_40359,_40321,_40397),
    not_look_ahead([du],_40427,_40397,_40461),
    !,
    pushstack(first,([jeg],w(verb(_40167,pres,fin))),nil,_40461,_40515),
    statement(_40117,_40495,_40515,_40263).

question1(test:::_40117,[question1,_40181],_40153,_40157) --> 
    question0(_40117,_40181,_40153,_40157).

np_question(which(_40121):::_40117,[np_question,_40193],_40165,_40169) --> 
    np1(_40121,true::_40117,_40193,_40165,_40169).

question0(_40111,[question0,_40175],_40147,_40151) --> 
    isq(_40111,_40175,_40147,_40151).

question0(_40111,[question0,_40175],_40147,_40151) --> 
    ynqs(_40111,_40175,_40147,_40151).

question0(_40111,[question0,_40175],_40147,_40151) --> 
    hasq(_40111,_40175,_40147,_40151).

question0(_40111,[question0,_40181,_40229],_40153,_40157) --> 
    hoq(_40181,_40153,_40211),
    statement(_40111,_40229,_40211,_40157).

implicitq(new:::_40117,[implicitq,_40419,{},_40491,{},{},lit(som),_40599,_40647,_40733,!,_40811,_40859,!,_40967],_40391,_40395) --> 
    w(prep(_40203),_40419,_40391,_40453),
    {testmember(_40203,[from,to])},
    w(name(_40229,n,_40233),_40491,_40453,_40525),
    {testmember(_40233,[station,neighbourhood])},
    {no_unprotected_verb},
    cc(som,_40525,_40597),
    look_ahead_vp(_40599,_40597,_40629),
    pushstack(first,(w(noun(bus,sin,u,n)),w(prep(_40203)),w(name(_40229,n,_40233))),nil,_40629,_40673),np1_accept(_40293,_40299::_40117,_40647,_40673,_40703),
    traceprint(4,iq00,_40733,_40703,_40771),
    !,
    accept(_40811,_40771,_40841),
    verb_phrase1(_40333,_40293,id,_40339,event/real/_40339::_40299,_40859,_40841,_40909),
    !,
    accept(_40967,_40909,_40395).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,_40395,lit(når),{},_40489,_40547,_40635,{},_40707,!,{},_40799,_40877],_40367,_40371) --> 
    not_look_ahead([nr],_40395,_40367,_40429),
    cc(når,_40429,_40473),
    {\+user:value(dialog,1)},
    w(verb(go,_40253,fin),_40489,_40473,_40523),
    optional([neste],_40547,_40523,_40611),
    w(name(_40207,n,_40211),_40635,_40611,_40669),
    {testmember(_40211,[station,neighbourhood])},
    traceprint(4,iq01,_40707,_40669,_40745),
    !,
    {setvartype(_40307,vehicle)},
    realcomp(_40127,_40315,_40123,_40799,_40745,_40841),
    pushstack(first,w(name(_40207,n,_40211)),nil,_40841,_40897),
    verb_modifiers(go,_40307,_40127,_40121::true,_40315,_40877,_40897,_40371).

implicitq(_40111,[implicitq,_40311,lit(når),{},{},_40419,{},!,_40501,_40549,_40617],_40283,_40287) --> 
    not_look_ahead([nr],_40311,_40283,_40345),
    cc(når,_40345,_40389),
    {\+user:value(dialog,1)},
    {no_unprotected_verb},
    look_ahead(w(name(_40227,_40229,_40231)),_40419,_40389,_40453),
    {subclass0(_40231,place)},
    !,
    accept(_40501,_40453,_40531),
    traceprint(4,iq2,_40549,_40531,_40587),
    pushstack(first,w(prep(to)),nil,_40587,_40637),
    implicitq(_40111,_40617,_40637,_40287).

implicitq(test:::_40117,[implicitq,{},_40307,lit(når),lit(nr),{},!,_40433,_40481,_40549],_40265,_40269) --> 
    {\+user:value(dialog,1)},
    not_look_ahead([nr],_40307,_40265,_40341),
    cc(når,_40341,_40385),
    cc(nr,_40385,_40407),
    {no_unprotected_verb},
    !,
    accept(_40433,_40407,_40463),
    traceprint(4,iq3,_40481,_40463,_40519),
    pushstack(first,w(verb(go,pres,fin)),nil,_40519,_40569),
    ynq(_40117,_40549,_40569,_40269).

implicitq(test:::_40117,[implicitq,_40297,lit(når),{},{},_40405,!,_40503,_40551,_40619],_40269,_40273) --> 
    not_look_ahead([nr],_40297,_40269,_40331),
    cc(når,_40331,_40375),
    {\+user:value(dialog,1)},
    {no_unprotected_verb},
    optional([det],_40405,_40375,_40469),
    !,
    accept(_40503,_40469,_40533),
    traceprint(4,iq4,_40551,_40533,_40589),
    pushstack(first,w(verb(go,pres,fin)),nil,_40589,_40639),
    ynq(_40117,_40619,_40639,_40273).

implicitq(_40111,[implicitq,_40183,!,_40241],_40155,_40159) --> 
    reject_implicitq(_40183,_40155,_40213),
    !,
    reject(_40241,_40213,_40159).

implicitq(new:::_40117,[implicitq,_40429,{},{},_40515,{},{},_40611,_40669,_40727,_40785,!,_40843,_40891,_40959,_41075,_41163,!,_41221],_40401,_40405) --> 
    look_ahead(w(noun(_40231,sin,u,n)),_40429,_40401,_40463),
    {subclass0(_40231,vehicle)},
    {no_unprotected_verb},
    np1_accept(_40255,_40261::_40117,_40515,_40463,_40553),
    {\+vartypeid(_40255,time)},
    {\+vartypeid(_40255,clock)},
    constrainvehdep(_40255,_40611,_40553,_40645),
    not_look_ahead([som],_40669,_40645,_40703),
    not_look_ahead([om],_40727,_40703,_40761),
    point0(_40785,_40761,_40815),
    !,
    accept(_40843,_40815,_40873),
    traceprint(4,iq4b,_40891,_40873,_40929),
    pushstack(first,w(verb(go,pres,fin)),nil,_40929,_40985),verb_phrase1(go,_40255,id,_40345,event/real/_40345::_40261,_40959,_40985,_41027),
    optional(itrailer,_41075,_41027,_41139),
    endofline(_41163,_41139,_41193),
    !,
    accept(_41221,_41193,_40405).

implicitq(which(_40121):::_40117,[implicitq,{},_40375,_40433,_40491,_40569,!,_40627,_40695,!,_40889],_40327,_40331) --> 
    {user:value(teleflag,true)},
    w(noun(_40199,_40201,_40203,n),_40375,_40327,_40409),
    not_look_ahead(w(prep(_40217)),_40433,_40409,_40467),
    person_name(_40229:person,_40223,_40225,_40491,_40467,_40533),
    endofline(_40569,_40533,_40599),
    !,
    traceprint(4,iq5,_40627,_40599,_40665),
    lock(exact,_40665,_40807),pushstack(exact,(w(noun(_40199,sin,u,n)),w(prep(to)),nameq1(_40229:person,_40223)),nil,_40807,_40819),no_phrases(_40121,_40117,_40695,_40819,_40797),unlock(_40797,_40799),
    !,
    accept(_40889,_40799,_40331).

implicitq(which(_40121):::_40117,[implicitq,{},_40259,_40327,_40375,!,_40453],_40211,_40215) --> 
    {user:value(teleflag,true)},
    no_phrases(_40121,_40117,_40259,_40211,_40297),
    endofline(_40327,_40297,_40357),
    traceprint(4,iq7,_40375,_40357,_40413),
    !,
    accept(_40453,_40413,_40215).

implicitq(new:::_40117,[implicitq,{},_40411,{},_40483,_40541,_40599,_40685,!,_40763,_40811,_40927,!,_40985],_40369,_40373) --> 
    {\+user:value(dialog,1)},
    not_look_ahead(w(prep(_40221)),_40411,_40369,_40445),
    {no_unprotected_verb},
    w(noun(time,_40235,_40237,_40239),_40483,_40445,_40517),
    look_ahead(w(prep(_40251)),_40541,_40517,_40575),
    pushstack(first,w(noun(departure,sin,u,_40239)),nil,_40575,_40625),np0(_40275,_40281::_40117,_40599,_40625,_40655),
    traceprint(4,iq8,_40685,_40655,_40723),
    !,
    accept(_40763,_40723,_40793),
    pushstack(first,w(verb(go,pres,fin)),nil,_40793,_40837),verb_phrase1(_40311,_40275,id,_40317,event/real/_40317::_40281,_40811,_40837,_40879),
    endofline(_40927,_40879,_40957),
    !,
    accept(_40985,_40957,_40373).

implicitq(new:::_40117,[implicitq,_40427,_40485,{},_40557,{},{},_40653,_40711,_40769,_40827,!,_40885,_40933,_41001,_41117,_41205,!,_41263],_40399,_40403) --> 
    not_look_ahead(w(nb(_40231,num)),_40427,_40399,_40461),
    not_look_ahead(w(prep(_40245)),_40485,_40461,_40519),
    {no_unprotected_verb},
    np1_accept(_40253,_40259::_40117,_40557,_40519,_40595),
    {\+vartypeid(_40253,time)},
    {\+vartypeid(_40253,clock)},
    constrainvehdep(_40253,_40653,_40595,_40687),
    not_look_ahead([som],_40711,_40687,_40745),
    not_look_ahead([om],_40769,_40745,_40803),
    point0(_40827,_40803,_40857),
    !,
    accept(_40885,_40857,_40915),
    traceprint(4,iq9,_40933,_40915,_40971),
    pushstack(first,w(verb(go,pres,fin)),nil,_40971,_41027),verb_phrase1(_40337,_40253,id,_40343,event/real/_40343::_40259,_41001,_41027,_41069),
    optional(itrailer,_41117,_41069,_41181),
    endofline(_41205,_41181,_41235),
    !,
    accept(_41263,_41235,_40403).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,{},_40389,_40447,_40505,{},_40567,_40615,{},_40677,_40755,_40803,_40991,!,_41069,_41117],_40341,_40345) --> 
    {user:value(dialog,1)},
    not_look_ahead([nå],_40389,_40341,_40423),
    time1(_40239,_40447,_40423,_40481),
    endofline(_40505,_40481,_40535),
    {no_unprotected_verb},
    no_harmful_adj(_40567,_40535,_40597),
    no_harmful_noun(_40615,_40597,_40645),
    {setvartype(_40251,vehicle)},
    realcomp(_40127,_40259,_40123,_40677,_40645,_40719),
    deter0(_40755,_40719,_40785),
    pushstack(first,obviousclock1(_40239:clock,_40239 isa clock),nil,_40785,_40901),verb_modifiers(go,_40251,_40127,_40121::true,_40259,_40803,_40901,_40943),
    traceprint(4,iq10,_40991,_40943,_41029),
    !,
    accept(_41069,_41029,_41099),
    qtrailer0(_41117,_41099,_40345).

implicitq(new:::_40117,[implicitq,{},_40439,_40497,{},_40559,{},{},_40655,_40713,_40771,!,_40839,_40887,_40955,_41071,!,_41129],_40391,_40395) --> 
    {user:value(dialog,1)},
    not_look_ahead(w(prep(_40241)),_40439,_40391,_40473),
    not_look_ahead_flnp(_40497,_40473,_40527),
    {no_unprotected_verb},
    np0(_40249,_40255::_40117,_40559,_40527,_40597),
    {\+vartypeid(_40249,time)},
    {\+vartypeid(_40249,clock)},
    constrainvehdep(_40249,_40655,_40597,_40689),
    not_look_ahead([om],_40713,_40689,_40747),
    not_look_ahead([som],_40771,_40747,_40805),
    !,
    accept(_40839,_40805,_40869),
    traceprint(4,iq11,_40887,_40869,_40925),
    pushstack(first,w(verb(go,pres,fin)),nil,_40925,_40981),verb_phrase1(_40333,_40249,id,_40339,event/real/_40339::_40255,_40955,_40981,_41023),
    endofline(_41071,_41023,_41101),
    !,
    accept(_41129,_41101,_40395).

implicitq(_40111,[implicitq,_40311,_40359,_40417,_40475,!,_40543,_40591,_40659],_40283,_40287) --> 
    the0(_40311,_40283,_40341),
    w(nb(_40193,num),_40359,_40341,_40393),
    flnp(_40199,_40417,_40393,_40451),
    w(prep(_40185),_40475,_40451,_40509),
    !,
    accept(_40543,_40509,_40573),
    traceprint(4,iq12,_40591,_40573,_40629),
    pushstack(first,(w(nb(_40193,num)),w(adj2(_40199,nil)),w(noun(route,plu,u,n)),w(prep(_40185))),nil,_40629,_40679),
    implicitq(_40111,_40659,_40679,_40287).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,_40345,_40403,_40461,!,_40529,_40577,_40645,_40723,!,_40849],_40317,_40321) --> 
    flnp(_40185,_40345,_40317,_40379),
    not_look_ahead([p],_40403,_40379,_40437),
    therightprep(_40197,_40461,_40437,_40495),
    !,
    accept(_40529,_40495,_40559),
    traceprint(4,iq13,_40577,_40559,_40615),
    realcomp(_40127,_40209,_40123,_40645,_40615,_40687),
    pushstack(first,w(prep(_40197)),nil,_40687,_40749),verb_modifiers(go,_40241:vehicle,_40127,_40121::_40241 isa vehicle and adj/nil/_40185/_40241/_40127,_40209,_40723,_40749,_40791),
    !,
    accept(_40849,_40791,_40321).

implicitq(_40111,[implicitq,{},_40355,_40413,{},_40485,{},!,_40567,_40615,_40683],_40313,_40317) --> 
    {\+user:value(dialog,1)},
    w(noun(_40185,_40187,_40189,_40191),_40355,_40313,_40389),
    not_look_ahead(w(name(_40237,_40239,_40241)),_40413,_40389,_40447),
    {testmember(_40185,[station])},
    look_ahead(w(prep(_40267)),_40485,_40447,_40519),
    {no_unprotected_verb},
    !,
    accept(_40567,_40519,_40597),
    traceprint(4,iq14,_40615,_40597,_40653),
    pushstack(first,(whatbe,w(noun(_40185,_40187,_40189,_40191))),nil,_40653,_40775),
    whatq(_40111,_40683,_40775,_40317).

implicitq(_40111,[implicitq,{},_40331,_40389,{},{},!,_40485,_40533,_40601],_40289,_40293) --> 
    {\+user:value(dialog,1)},
    w(adj2(nearest,nil),_40331,_40289,_40365),
    look_ahead(w(noun(_40223,_40225,_40227,_40229)),_40389,_40365,_40423),
    {testmember(_40223,[station])},
    {no_unprotected_verb},
    !,
    accept(_40485,_40423,_40515),
    traceprint(4,iq14b,_40533,_40515,_40571),
    pushstack(first,(whatbe,w(adj2(nearest,nil))),nil,_40571,_40695),
    whatq(_40111,_40601,_40695,_40293).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,lit(nå),{},{},{},_40455,_40513,_40571,{},_40633,_40711,_40827,!,_40905],_40363,_40367) --> 
    cc(nå,_40363,_40411),
    {\+user:value(teleflag,true)},
    {\+user:value(textflag,true)},
    {no_unprotected_verb},
    not_look_ahead(w(adj2(_40259,nil)),_40455,_40411,_40489),
    not_look_ahead(w(noun(_40273,_40275,_40277,_40279)),_40513,_40489,_40547),
    not_fnlp(_40571,_40547,_40601),
    {setvartype(_40287,vehicle)},
    realcomp(_40127,_40295,_40123,_40633,_40601,_40675),
    pushstack(free,[nå],nil,_40675,_40737),verb_modifiers(go,_40287,_40127,_40121::true,_40295,_40711,_40737,_40779),
    traceprint(4,iq15,_40827,_40779,_40865),
    !,
    accept(_40905,_40865,_40367).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,{},{},{},_40433,_40491,{},_40573,_40651,_40699,!,_40893,_40941,_41009],_40363,_40367) --> 
    {\+user:value(teleflag,true)},
    {\+user:value(textflag,true)},
    {no_unprotected_verb},
    not_look_ahead(w(nb(_40255,_40257)),_40433,_40363,_40467),
    obviousclock1(_40261,_40263,_40491,_40467,_40529),
    {setvartype(_40271,vehicle)},
    realcomp(_40127,_40279,_40123,_40573,_40529,_40615),
    deter0(_40651,_40615,_40681),
    pushstack(first,(w(prep(after)),obviousclock1(_40261,_40263)),nil,_40681,_40793),verb_modifiers(go,_40271,_40127,_40121::true,_40279,_40699,_40793,_40835),
    !,
    accept(_40893,_40835,_40923),
    traceprint(4,iq17,_40941,_40923,_40979),
    qtrailer0(_41009,_40979,_40367).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,{},{},_40377,_40455,{},_40517,_40575,_40633,_40711,_40809,!,_40887],_40321,_40325) --> 
    {\+user:value(dialog,1)},
    {no_unprotected_verb},
    namep(_40221,_40223,_40225,_40377,_40321,_40419),
    no_harmful_adj(_40455,_40419,_40485),
    {constrain(_40223,vehicle)},
    not_look_ahead([om],_40517,_40485,_40551),
    not_look_ahead(w(nb(_40255,_40257)),_40575,_40551,_40609),
    realcomp(_40127,_40263,_40123,_40633,_40609,_40675),
    verb_modifiers(go,_40223,_40127,_40121::_40225,_40263,_40711,_40675,_40761),
    traceprint(4,iq18,_40809,_40761,_40847),
    !,
    accept(_40887,_40847,_40325).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,_40355,_40413,{},{},_40499,_40577,_40693,!,_40771],_40327,_40331) --> 
    not_look_ahead(w(name(_40187,_40189,_40191)),_40355,_40327,_40389),
    w(noun(_40199,sin,u,n),_40413,_40389,_40447),
    {test(_40199 ako day)},
    {setvartype(_40227,vehicle)},
    realcomp(_40127,_40235,_40123,_40499,_40447,_40541),
    pushstack(first,(w(prep(on)),w(noun(_40199,sin,u,n))),nil,_40541,_40603),verb_modifiers(go,_40227,_40127,_40121::true,_40235,_40577,_40603,_40645),
    traceprint(4,iq19,_40693,_40645,_40731),
    !,
    accept(_40771,_40731,_40331).

implicitq(new:::_40117,[implicitq,{},_40473,_40531,{},{},{},{},{},_40669,_40727,_40785,!,_40853,_40901,_40969,_41085,!,_41143],_40431,_40435) --> 
    {no_unprotected_verb},
    not_look_ahead(w(nb(_40235,_40237)),_40473,_40431,_40507),
    np1_accept(_40241,_40247::_40117,_40531,_40507,_40569),
    {\+vartypeid(_40241,thing)},
    {\+vartypeid(_40241,time)},
    {\+vartypeid(_40241,clock)},
    {\+vartypeid(_40241,arrival)},
    {\+vartypeid(_40241,departure)},
    not_look_ahead([om],_40669,_40569,_40703),
    not_look_ahead(w(nb(_40339,_40341)),_40727,_40703,_40761),
    constrainvehdep(_40241,_40785,_40761,_40819),
    !,
    accept(_40853,_40819,_40883),
    traceprint(4,iq20,_40901,_40883,_40939),
    pushstack(first,w(verb(go,pres,fin)),nil,_40939,_40995),verb_phrase1(_40373,_40241,id,_40379,event/real/_40379::_40247,_40969,_40995,_41037),
    endofline(_41085,_41037,_41115),
    !,
    accept(_41143,_41115,_40435).

implicitq(new:::_40117,[implicitq,lit(når),_40343,!,_40431,_40479,!,_40547,_40615,_40783],_40293,_40297) --> 
    cc(når,_40293,_40341),
    np_kernel(_40191,_40193,_40195,_40343,_40341,_40385),
    !,
    accept(_40431,_40385,_40461),
    constrainvehdep(_40193,_40479,_40461,_40513),
    !,
    traceprint(4,iq21,_40547,_40513,_40585),
    pushstack(first,np_kernel(0,_40193,_40195),nil,_40585,_40723),np1(_40193,_40229::_40117,_40615,_40723,_40753),
    pushstack(first,w(verb(go,pres,fin)),nil,_40753,_40803),
    verb_phrase1(_40235,_40193,id,_40241,event/real/_40241::_40229,_40783,_40803,_40297).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,_40377,_40425,_40483,_40541,_40599,!,_40667,_40715,_40783,_40861,!,_40969],_40349,_40353) --> 
    athe0(_40377,_40349,_40407),
    flnp(_40197,_40425,_40407,_40459),
    not_look_ahead(w(nb(_40209,_40211)),_40483,_40459,_40517),
    not_look_ahead(w(name(_40223,_40225,route)),_40541,_40517,_40575),
    look_ahead(w(name(_40239,_40241,_40243)),_40599,_40575,_40633),
    !,
    accept(_40667,_40633,_40697),
    traceprint(4,iq22,_40715,_40697,_40753),
    realcomp(_40127,_40255,_40123,_40783,_40753,_40825),
    verb_modifiers(go,_40273:vehicle,_40127,_40121::_40273 isa vehicle and adj/nil/_40197/_40273/_40127,_40255,_40861,_40825,_40911),
    !,
    accept(_40969,_40911,_40353).

implicitq(_40111,[implicitq,{},_40425,_40483,_40541,_40599,_40657,_40715,{},_40787,!,_40865,_40913,_40981],_40383,_40387) --> 
    {\+user:value(dialog,1)},
    not_look_ahead(w(noun(clock,_40235,_40237,_40239)),_40425,_40383,_40459),
    not_look_ahead(w(noun(thing,_40253,_40255,_40257)),_40483,_40459,_40517),
    not_look_ahead(w(noun(answer,_40271,_40273,_40275)),_40541,_40517,_40575),
    not_look_ahead([det],_40599,_40575,_40633),
    not_look_ahead(w(name(_40295,n,_40299)),_40657,_40633,_40691),
    look_ahead(w(noun(_40311,_40313,_40315,n)),_40715,_40691,_40749),
    {testmember(_40311,[ticket,price])},
    np1_accept(_40199,_40201,_40787,_40749,_40825),
    !,
    accept(_40865,_40825,_40895),
    traceprint(4,iq23,_40913,_40895,_40951),
    pushstack(first,(whatbe,xnp(_40199,_40201)),nil,_40951,_41155),
    whatq(_40111,_40981,_41155,_40387).

implicitq(_40111,[implicitq,{},_40329,{},_40401,!,_40469,_40517,_40585],_40287,_40291) --> 
    {\+user:value(dialog,1)},
    w(noun(_40173,_40209,_40211,_40213),_40329,_40287,_40363),
    {testmember(_40173,[clock,date])},
    not_look_ahead(w(nb(_40243,_40245)),_40401,_40363,_40435),
    !,
    accept(_40469,_40435,_40499),
    traceprint(4,iq24,_40517,_40499,_40555),
    pushstack(first,(whatbe,w(noun(_40173,_40175,_40177,_40179))),nil,_40555,_40679),
    whatq(_40111,_40585,_40679,_40291).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,{},{},{},_40521,{},_40593,{},{},_40679,_40757,_40815,_40883,!,_41009,_41057],_40451,_40455) --> 
    {\+user:value(teleflag,true)},
    {\+user:value(textflag,true)},
    {no_unprotected_verb},
    w(name(_40263,n,_40267),_40521,_40451,_40555),
    {subclass0(_40267,place)},
    w(name(_40285,n,_40289),_40593,_40555,_40627),
    {subclass0(_40289,place)},
    {setvartype(_40307,vehicle)},
    realcomp(_40127,_40315,_40123,_40679,_40627,_40721),
    not_look_ahead(w(nb(_40329,_40331)),_40757,_40721,_40791),
    traceprint(4,iq25,_40815,_40791,_40853),
    pushstack(first,(w(prep(from)),w(name(_40263,n,_40267)),w(prep(to)),w(name(_40285,n,_40289))),nil,_40853,_40909),verb_modifiers(go,_40307,_40127,_40121::true,_40315,_40883,_40909,_40951),
    !,
    accept(_41009,_40951,_41039),
    qtrailer0(_41057,_41039,_40455).

implicitq(modifier(_40127):::_40121 and _40123,[implicitq,{},{},{},_40433,_40481,_40529,{},_40601,_40679,_40727,_40785,_40833,_40881,_40949,!,_41057,_41105],_40363,_40367) --> 
    {\+user:value(teleflag,true)},
    {\+user:value(textflag,true)},
    {no_unprotected_verb},
    no_harmful_adj(_40433,_40363,_40463),
    no_harmful_noun(_40481,_40463,_40511),
    not_look_ahead([du],_40529,_40511,_40563),
    {setvartype(_40283,vehicle)},
    realcomp(_40127,_40291,_40123,_40601,_40563,_40643),
    deter0(_40679,_40643,_40709),
    not_look_ahead(w(nb(_40305,_40307)),_40727,_40709,_40761),
    no_harmful_adj(_40785,_40761,_40815),
    redundants0(_40833,_40815,_40863),
    traceprint(4,iq26,_40881,_40863,_40919),
    verb_modifiers(go,_40283,_40127,_40121::true,_40291,_40949,_40919,_40999),
    !,
    accept(_41057,_40999,_41087),
    qtrailer0(_41105,_41087,_40367).

reject_implicitq([reject_implicitq,lit(hvilke)],_40139,_40143) --> 
    cc(hvilke,_40139,_40143).

reject_implicitq([reject_implicitq,_40227,_40285,_40343,_40401,_40459],_40205,_40209) --> 
    look_ahead(w(nb(1000,num)),_40227,_40205,_40261),
    not_look_ahead([en],_40285,_40261,_40319),
    not_look_ahead([et],_40343,_40319,_40377),
    not_look_ahead([to],_40401,_40377,_40435),
    not_look_ahead([tre],_40459,_40435,_40209).

reject_implicitq([reject_implicitq,lit(at)],_40139,_40143) --> 
    cc(at,_40139,_40143).

reject_implicitq([reject_implicitq,_40171],_40149,_40153) --> 
    w(noun(error,_40117,_40119,_40121),_40171,_40149,_40153).

reject_implicitq([reject_implicitq,_40207,_40265,_40323],_40185,_40189) --> 
    not_look_ahead(w(adj2(fast,_40143)),_40207,_40185,_40241),
    not_look_ahead(w(adj2(best,_40157)),_40265,_40241,_40299),
    w(adj2(good,nil),_40323,_40299,_40189).

reject_implicitq([reject_implicitq,lit(kan)],_40139,_40143) --> 
    cc(kan,_40139,_40143).

reject_implicitq([reject_implicitq,_40199,_40257,{}],_40177,_40181) --> 
    not_look_ahead([e],_40199,_40177,_40233),
    w(verb(_40127,_40147,_40149),_40257,_40233,_40181),
    {_40127\==reach}.

reject_implicitq([reject_implicitq,_40189,_40247],_40167,_40171) --> 
    w(noun(_40133,_40135,_40137,_40139),_40189,_40167,_40223),
    w(verb(_40121,_40123,_40125),_40247,_40223,_40171).

reject_implicitq([reject_implicitq,_40233,_40291,_40349,_40407,_40465,_40523],_40211,_40215) --> 
    not_look_ahead([de],_40233,_40211,_40267),
    not_look_ahead([den],_40291,_40267,_40325),
    not_look_ahead([det],_40349,_40325,_40383),
    not_look_ahead([alle],_40407,_40383,_40441),
    not_look_ahead([en],_40465,_40441,_40499),
    quant_pron(_40141,_40143,_40523,_40499,_40215).

reject_implicitq([reject_implicitq,_40181,_40239],_40159,_40163) --> 
    w(noun(_40125,_40127,_40129,_40131),_40181,_40159,_40215),
    posspron(_40117,_40239,_40215,_40163).

reject_implicitq([reject_implicitq,_40195,{}],_40173,_40177) --> 
    w(noun(_40121,_40141,_40143,_40145),_40195,_40173,_40177),
    {testmember(_40121,[possibility,necessity])}.

reject_implicitq([reject_implicitq,_40157],_40135,_40139) --> 
    what(_40157,_40135,_40139).

reject_implicitq([reject_implicitq,lit(der)],_40139,_40143) --> 
    cc(der,_40139,_40143).

reject_implicitq([reject_implicitq,lit(hvor)],_40139,_40143) --> 
    cc(hvor,_40139,_40143).

reject_implicitq([reject_implicitq,lit(hvem)],_40139,_40143) --> 
    cc(hvem,_40139,_40143).

reject_implicitq([reject_implicitq,_40207,_40265,lit(når),_40345],_40185,_40189) --> 
    not_look_ahead([nr],_40207,_40185,_40241),
    not_look_ahead([n],_40265,_40241,_40299),
    cc(når,_40299,_40343),
    not_look_ahead(w(prep(from)),_40345,_40343,_40189).

reject_implicitq([reject_implicitq,_40157],_40135,_40139) --> 
    so(_40157,_40135,_40139).

reject_implicitq([reject_implicitq,_40181,_40239],_40159,_40163) --> 
    w(nb(1000,num),_40181,_40159,_40215),
    look_ahead([takk],_40239,_40215,_40163).

reject_implicitq([reject_implicitq,lit(da)],_40139,_40143) --> 
    cc(da,_40139,_40143).

reject_implicitq([reject_implicitq,lit(og)],_40139,_40143) --> 
    cc(og,_40139,_40143).

reject_implicitq([reject_implicitq,lit(men)],_40139,_40143) --> 
    cc(men,_40139,_40143).

reject_implicitq([reject_implicitq,_40175,lit(hvis)],_40153,_40157) --> 
    not_look_ahead([om],_40175,_40153,_40209),
    cc(hvis,_40209,_40157).

reject_implicitq([reject_implicitq,lit(fordi)],_40139,_40143) --> 
    cc(fordi,_40139,_40143).

reject_implicitq([reject_implicitq,lit(ja)],_40139,_40143) --> 
    cc(ja,_40139,_40143).

reject_implicitq([reject_implicitq,lit(nei)],_40139,_40143) --> 
    cc(nei,_40139,_40143).

reject_implicitq([reject_implicitq,{},lit(det)],_40161,_40165) --> 
    {user:value(notimeoutflag,true)},
    cc(det,_40161,_40165).

reject_implicitq([reject_implicitq,lit(det),_40201],_40157,_40161) --> 
    cc(det,_40157,_40199),
    w(verb(be,_40123,_40125),_40201,_40199,_40161).

reject_implicitq([reject_implicitq,_40243,_40301,{}],_40221,_40225) --> 
    w(adj2(good,nil),_40243,_40221,_40277),
    w(noun(_40127,_40189,_40191,_40193),_40301,_40277,_40225),
    {testmember(_40127,[morrow,morning,day,night,evening,midnight,afternoon,prenoon,saturday,sunday])}.

reject_implicitq([reject_implicitq,_40191,{}],_40169,_40173) --> 
    w(noun(_40121,_40137,def,_40141),_40191,_40169,_40173),
    {testmember(_40121,[midnight])}.

reject_implicitq([reject_implicitq,lit(på),lit(forhånd),lit(takk)],_40159,_40163) --> 
    cc(på,_40159,_40201),
    cc(forhånd,_40201,_40223),
    cc(takk,_40223,_40163).

reject_implicitq([reject_implicitq,_40243,{},_40315,{},!,_40393],_40221,_40225) --> 
    w(noun(_40145,_40147,_40149,_40151),_40243,_40221,_40277),
    {\+testmember(_40145,[nightbus,airplane,airbus])},
    endofline(_40315,_40277,_40345),
    {user:value(notimeoutflag,true)},
    !,
    reject(_40393,_40345,_40225).

reject_implicitq([reject_implicitq,lit(nå),_40201,!,_40259],_40157,_40161) --> 
    cc(nå,_40157,_40199),
    endofline(_40201,_40199,_40231),
    !,
    reject(_40259,_40231,_40161).

no_harmful_adj([no_harmful_adj,_40211,{},!,_40293],_40189,_40193) --> 
    look_ahead(w(adj2(_40137,nil)),_40211,_40189,_40245),
    {testmember(_40137,[nearest,good,next])},
    !,
    reject(_40293,_40245,_40193).

no_harmful_adj([no_harmful_adj,[]],_40135,_40135) --> 
    [].

no_harmful_noun([no_harmful_noun,_40207,_40265,!,_40343],_40185,_40189) --> 
    look_ahead(w(noun(_40137,_40139,_40141,n)),_40207,_40185,_40241),
    gmem(_40137,[airport,bridge],_40265,_40241,_40303),
    !,
    accept(_40343,_40303,_40189).

no_harmful_noun([no_harmful_noun,_40201,{},!,_40283],_40179,_40183) --> 
    look_ahead(w(name(_40137,_40139,_40141)),_40201,_40179,_40235),
    {subclass0(_40141,place)},
    !,
    accept(_40283,_40235,_40183).

no_harmful_noun([no_harmful_noun,_40215,_40303,{},!],_40193,_40197) --> 
    optional([alle],_40215,_40193,_40279),
    look_ahead(w(noun(_40145,sin,_40149,_40151)),_40303,_40279,_40197),
    {testmember(_40145,[station])},
    !.

no_harmful_noun([no_harmful_noun,_40213,{},!],_40191,_40195) --> 
    look_ahead(w(noun(_40131,sin,u,n)),_40213,_40191,_40195),
    {testmember(_40131,[arrival,departure,station,student])},
    !.

no_harmful_noun([no_harmful_noun,_40195,{}],_40173,_40177) --> 
    not_look_ahead(w(noun(_40125,_40141,_40143,_40145)),_40195,_40173,_40177),
    {\+testmember(_40125,airport)}.

therightprep(from,[therightprep,_40185,!],_40157,_40161) --> 
    w(prep(from),_40185,_40157,_40161),
    !.

therightprep(_40111,[therightprep,_40185,!],_40157,_40161) --> 
    w(prep(_40111),_40185,_40157,_40161),
    !.

not_adjective_only([not_adjective_only,_40179,!],_40157,_40161) --> 
    look_ahead(w(name(_40125,n,_40129)),_40179,_40157,_40161),
    !.

not_adjective_only([not_adjective_only,_40171],_40149,_40153) --> 
    look_ahead(w(adj2(_40119,_40121)),_40171,_40149,_40153).

not_fnlp([not_fnlp,_40215,{},!,_40297],_40193,_40197) --> 
    look_ahead(w(adj2(_40137,nil)),_40215,_40193,_40249),
    {testmember(_40137,[first,next,last,previous])},
    !,
    reject(_40297,_40249,_40197).

not_fnlp([not_fnlp,[]],_40135,_40135) --> 
    [].

constrainvehdep(_40111,[constrainvehdep,{},!,_40217],_40165,_40169) --> 
    {vartypeid(_40111,thing)},
    !,
    reject(_40217,_40165,_40169).

constrainvehdep(_40111,[constrainvehdep,{},!,_40217],_40165,_40169) --> 
    {constrain(_40111,clock)},
    !,
    reject(_40217,_40165,_40169).

constrainvehdep(_40115:_40117,[constrainvehdep,{},{},!,_40257],_40191,_40195) --> 
    {constrain(_40115:_40151,number)},
    {plausible_busno(_40115)},
    !,
    accept(_40257,_40191,_40195).

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,summerroute)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,winterroute)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,route)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,route_plan)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,vehicle)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,departure)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,arrival)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,connection)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,tram_route)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,tram_route_plan)},
    !.

constrainvehdep(_40111,[constrainvehdep,{},!],_40159,_40159) --> 
    {constrain(_40111,trip)},
    !.

hasq(_40111,[hasq,_40249,_40297,_40355,!,_40423,_40471],_40221,_40225) --> 
    has(_40249,_40221,_40279),
    thereit(_40169,_40297,_40279,_40331),
    w(verb(_40161,past,part),_40355,_40331,_40389),
    !,
    accept(_40423,_40389,_40453),
    pushstack(free,([det],w(verb(_40161,pres,fin))),nil,_40453,_40491),
    statement(_40111,_40471,_40491,_40225).

hasq(_40111,[hasq,_40291,_40349,_40407,_40455,_40523,_40581,_40629,_40677,_40725,!,_40783],_40263,_40267) --> 
    w(verb(have,_40205,fin),_40291,_40263,_40325),
    negation0(_40211,_40349,_40325,_40383),
    so0(_40407,_40383,_40437),
    subject(_40215,_40217,_40455,_40437,_40493),
    negation0(_40221,_40523,_40493,_40557),
    adverbx0(_40581,_40557,_40611),
    hatt0(_40629,_40611,_40659),
    negatino(_40677,_40659,_40707),
    sometimes0(_40725,_40707,_40755),
    !,
    pushstack(first,(xnp(_40215,_40217),w(verb(have,pres,fin))),nil,_40755,_40883),
    statement(_40111,_40783,_40883,_40267).

hasq(_40111,[hasq,_40221,_40279,_40337],_40193,_40197) --> 
    w(verb(have,_40139,fin),_40221,_40193,_40255),
    negation0(_40157,_40279,_40255,_40313),
    lock(last,_40313,_40371),
    pushstack(last,w(verb(have,_40139,fin)),nil,_40371,_40383),
    statement(_40111,_40337,_40383,_40361),
    unlock(_40361,_40197).

isq(_40111,[isq,_40351,_40399,_40457,_40515,_40573,_40621,_40679,lit(å),!,_40779,!,_40875],_40323,_40327) --> 
    be(_40351,_40323,_40381),
    negation0(_40209,_40399,_40381,_40433),
    thereit(_40213,_40457,_40433,_40491),
    negation0(_40217,_40515,_40491,_40549),
    so0(_40573,_40549,_40603),
    w(adj2(_40203,nil),_40621,_40603,_40655),
    gmem(_40203,[true,false,wrong,correct],_40679,_40655,_40717),
    cc(å,_40717,_40767),
    !,
    pushstack(first,[jeg],nil,_40767,_40805),clausal_object1(_40267,_40269,_40779,_40805,_40835),
    !,
    pushstack(first,(xnp(_40267,_40269),w(verb(be,pres,fin)),w(adj2(_40203,nil))),nil,_40835,_40975),
    substatement1(_40111,_40875,_40975,_40327).

isq(_40111,[isq,_40341,_40389,_40447,_40505,_40563,_40611,_40669,lit(at),!,_40769,!,_40847],_40313,_40317) --> 
    be(_40341,_40313,_40371),
    negation0(_40209,_40389,_40371,_40423),
    thereit(_40213,_40447,_40423,_40481),
    negation0(_40217,_40505,_40481,_40539),
    so0(_40563,_40539,_40593),
    w(adj2(_40203,nil),_40611,_40593,_40645),
    gmem(_40203,[true,false,wrong,correct],_40669,_40645,_40707),
    cc(at,_40707,_40757),
    !,
    clausal_object1(_40257,_40259,_40769,_40757,_40807),
    !,
    pushstack(first,(xnp(_40257,_40259),w(verb(be,pres,fin)),w(adj2(_40203,nil))),nil,_40807,_40947),
    substatement1(_40111,_40847,_40947,_40317).

isq(_40111,[isq,_40261,_40319,_40377,_40435,!,[],_40531],_40233,_40237) --> 
    w(verb(be,_40161,fin),_40261,_40233,_40295),
    negation0(_40167,_40319,_40295,_40353),
    thereit(_40171,_40377,_40353,_40411),
    w(verb(_40179,past,part),_40435,_40411,_40469),
    !,
    pushstack(free,w(verb(_40179,_40161,fin)),nil,_40469,_40529),[],
    statement(_40111,_40531,_40529,_40237).

isq(_40111,[isq,_40265,_40313,_40371,_40429,_40487,_40535,!,_40603],_40237,_40241) --> 
    be(_40265,_40237,_40295),
    negation0(_40181,_40313,_40295,_40347),
    pronoun(_40185,_40371,_40347,_40405),
    negation0(_40189,_40429,_40405,_40463),
    not_look_ahead_np(_40487,_40463,_40517),
    not_look_ahead([som],_40535,_40517,_40569),
    !,
    pushstack(first,(pronoun(_40185),w(verb(be,pres,fin))),nil,_40569,_40695),
    substatement1(_40111,_40603,_40695,_40241).

isq(_40111,[isq,_40333,lit(det),_40403,_40461,_40509,_40567,_40625,lit(å),!,_40725,_40891],_40305,_40309) --> 
    be(_40333,_40305,_40363),
    cc(det,_40363,_40401),
    negation0(_40207,_40403,_40401,_40437),
    so0(_40461,_40437,_40491),
    w(adj2(_40197,nil),_40509,_40491,_40543),
    w(prep(for),_40567,_40543,_40601),
    object(_40229,_40231,_40625,_40601,_40663),
    cc(å,_40663,_40713),
    !,
    pushstack(first,(xnp(_40229,_40231),[vil]),nil,_40713,_40831),clausal_object1(_40255,_40257,_40725,_40831,_40861),
    pushstack(first,(xnp(_40255,_40257),be,w(adj2(_40197,nil))),nil,_40861,_41065),
    substatement1(_40111,_40891,_41065,_40309).

isq(_40111,[isq,_40283,_40331,_40389,_40447,_40495,_40553,!,_40631],_40255,_40259) --> 
    be(_40283,_40255,_40313),
    thereit(_40189,_40331,_40313,_40365),
    negation0(_40193,_40389,_40365,_40423),
    so0(_40447,_40423,_40477),
    w(adj2(_40201,nil),_40495,_40477,_40529),
    prepnog(_40201,_40185,_40553,_40529,_40591),
    !,
    pushstack(first,(something,be,w(adj2(_40201,nil)),w(prep(_40185))),nil,_40591,_40799),
    substatement1(_40111,_40631,_40799,_40259).

isq(_40111,[isq,_40323,_40371,_40429,_40487,_40545,_40593,{},lit(å),!,_40697],_40295,_40299) --> 
    be(_40323,_40295,_40353),
    negation0(_40197,_40371,_40353,_40405),
    thereit(_40201,_40429,_40405,_40463),
    negation0(_40205,_40487,_40463,_40521),
    so0(_40545,_40521,_40575),
    w(adj2(_40213,nil),_40593,_40575,_40627),
    {\+testmember(_40213,[])},
    cc(å,_40627,_40685),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_40213,nil)),[å]),nil,_40685,_40717),
    substatement1(_40111,_40697,_40717,_40299).

isq(_40111,[isq,_40283,_40331,_40389,_40447,_40505,_40553,!,_40621],_40255,_40259) --> 
    be(_40283,_40255,_40313),
    negation0(_40185,_40331,_40313,_40365),
    thereit(_40189,_40389,_40365,_40423),
    negation0(_40193,_40447,_40423,_40481),
    so0(_40505,_40481,_40535),
    w(adj2(_40179,nil),_40553,_40535,_40587),
    !,
    pushstack(first,([noe],w(verb(be,pres,fin)),w(adj2(_40179,nil))),nil,_40587,_40641),
    substatement1(_40111,_40621,_40641,_40259).

isq(_40111,[isq,_40231,_40279,_40327,!,_40395],_40203,_40207) --> 
    be(_40231,_40203,_40261),
    dette(_40279,_40261,_40309),
    negation0(_40163,_40327,_40309,_40361),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin))),nil,_40361,_40415),
    substatement1(_40111,_40395,_40415,_40207).

isq(_40111,[isq,_40227,_40275,_40323,!,_40381],_40199,_40203) --> 
    be(_40227,_40199,_40257),
    thereit(_40275,_40257,_40305),
    ikkeingen0(_40323,_40305,_40353),
    !,
    pushstack(free,([det],w(verb(be,pres,fin))),nil,_40353,_40401),
    substatement1(_40111,_40381,_40401,_40203).

isq(_40111,[isq,_40249,_40297,_40355,_40423,!,_40491],_40221,_40225) --> 
    be(_40249,_40221,_40279),
    negation0(_40169,_40297,_40279,_40331),
    subject(_40173,_40175,_40355,_40331,_40393),
    negation0(_40179,_40423,_40393,_40457),
    !,
    pushstack(first,(xnp(_40173,_40175),w(verb(be,pres,fin))),nil,_40457,_40591),
    substatement1(_40111,_40491,_40591,_40225).

isq(_40111,[isq,_40221,_40269,_40317,!,_40385],_40193,_40197) --> 
    be(_40221,_40193,_40251),
    det0(_40269,_40251,_40299),
    negation0(_40157,_40317,_40299,_40351),
    !,
    pushstack(free,w(verb(be,pres,fin)),nil,_40351,_40405),
    substatement1(_40111,_40385,_40405,_40197).

ikkeingen0([ikkeingen0,lit(ingen),!],_40145,_40149) --> 
    cc(ingen,_40145,_40149),
    !.

ikkeingen0([ikkeingen0,_40161],_40139,_40143) --> 
    negation0(_40111,_40161,_40139,_40143).

ynqs(_40111,[ynqs,_40199,_40257,!,_40335],_40171,_40175) --> 
    isynq(_40133,_40199,_40171,_40233),
    orwill(_40133,_40111,_40257,_40233,_40295),
    !,
    accept(_40335,_40295,_40175).

isynq(_40111,[isynq,_40175],_40147,_40151) --> 
    isq(_40111,_40175,_40147,_40151).

isynq(_40111,[isynq,_40175],_40147,_40151) --> 
    ynq(_40111,_40175,_40147,_40151).

orwill(_40111,_40111,[orwill,lit(eller),_40227,!,_40285],_40171,_40175) --> 
    cc(eller,_40171,_40225),
    endofline(_40227,_40225,_40257),
    !,
    accept(_40285,_40257,_40175).

orwill(_40111,_40111 or _40119,[orwill,lit(eller),_40269,!,_40337,_40385,_40443],_40213,_40217) --> 
    cc(eller,_40213,_40267),
    not_look_ahead(w(nb(_40171,_40173)),_40269,_40267,_40303),
    !,
    accept(_40337,_40303,_40367),
    isynq(_40153,_40385,_40367,_40419),
    orwill(_40153,_40119,_40443,_40419,_40217).

orwill(_40111,_40111,[orwill,[]],_40149,_40149) --> 
    [].

ynq(_40111,[ynq,_40295,{},lit(det),_40389,_40447,!,_40515],_40267,_40271) --> 
    w(verb(_40167,_40169,fin),_40295,_40267,_40329),
    {\+testmember(_40167,[be,have])},
    cc(det,_40329,_40387),
    negation0(_40213,_40389,_40387,_40423),
    look_ahead(w(adj2(_40225,_40227)),_40447,_40423,_40481),
    !,
    pushstack(free,([dette],w(verb(_40167,_40169,fin))),nil,_40481,_40535),
    statreal(_40111,_40515,_40535,_40271).

ynq(_40111,[ynq,_40325,{},lit(det),_40419,lit(å),_40509,!,_40605],_40297,_40301) --> 
    w(verb(_40185,_40187,fin),_40325,_40297,_40359),
    {testmember(_40185,[cost])},
    cc(det,_40359,_40417),
    np0_accept(_40175,_40177,_40419,_40417,_40457),
    cc(å,_40457,_40507),
    pushstack(first,([noen],[vil]),nil,_40507,_40535),clausal_object1(_40237,_40239,_40509,_40535,_40565),
    !,
    pushstack(first,(xnp(_40237,_40239),w(verb(_40185,pres,fin)),xnp(_40175,_40177)),nil,_40565,_40785),
    statreal1(_40111,_40605,_40785,_40301).

ynq(_40111,[ynq,_40279,lit(det),_40349,_40407,_40465,_40533,_40581,!,_40747],_40251,_40255) --> 
    aux1(_40279,_40251,_40309),
    cc(det,_40309,_40347),
    negation0(_40167,_40349,_40347,_40383),
    w(verb(happen,inf,fin),_40407,_40383,_40441),
    subject(_40183,_40185,_40465,_40441,_40503),
    not_look_ahead_vp(_40533,_40503,_40563),
    pushstack(first,(xnp(_40183,_40185),w(verb(happen,pres,fin))),nil,_40563,_40687),statreal1(_40111,_40581,_40687,_40713),
    !,
    accept(_40747,_40713,_40255).

ynq(_40111,[ynq,lit(kan),_40287,_40345,_40413,_40471,_40519,!,_40685],_40237,_40241) --> 
    cc(kan,_40237,_40285),
    negation0(_40161,_40287,_40285,_40321),
    subject(_40165,_40167,_40345,_40321,_40383),
    negation0(_40171,_40413,_40383,_40447),
    not_look_ahead_vp(_40471,_40447,_40501),
    pushstack(first,(xnp(_40165,_40167),w(verb(know1,pres,fin))),nil,_40501,_40625),statreal1(_40111,_40519,_40625,_40651),
    !,
    accept(_40685,_40651,_40241).

ynq(_40111,[ynq,lit(_40161),{},_40309,_40367,_40435,!,_40503],_40245,_40249) --> 
    cc(_40161,_40245,_40293),
    {testmember(_40161,[får,kan,kunne])},
    negation0(_40193,_40309,_40293,_40343),
    subject(_40197,_40199,_40367,_40343,_40405),
    negation0(_40203,_40435,_40405,_40469),
    !,
    pushstack(first,(xnp(_40197,_40199),[_40161]),nil,_40469,_40603),
    statreal1(_40111,_40503,_40603,_40249).

ynq(_40111,[ynq,_40299,_40347,_40415,_40473,{},_40545,!,_40613],_40271,_40275) --> 
    aux1(_40299,_40271,_40329),
    subject(_40181,_40183,_40347,_40329,_40385),
    w(verb(_40173,inf,fin),_40415,_40385,_40449),
    not_look_ahead(w(verb(_40207,_40209,_40211)),_40473,_40449,_40507),
    {\+verbtype(_40173,rv)},
    negation0(_40229,_40545,_40507,_40579),
    !,
    pushstack(first,(xnp(_40181,_40183),w(verb(_40173,pres,fin))),nil,_40579,_40713),
    statreal1(_40111,_40613,_40713,_40275).

ynq(_40111,[ynq,lit(så),!,_40219],_40159,_40163) --> 
    cc(så,_40159,_40207),
    !,
    reject(_40219,_40207,_40163).

ynq(_40111,[ynq,_40293,_40341,_40399,lit(av),!,_40499,_40547,_40595,_40653],_40265,_40269) --> 
    aux1(_40293,_40265,_40323),
    not_look_ahead(w(verb(go,_40195,_40197)),_40341,_40323,_40375),
    subject(_40201,_40203,_40399,_40375,_40437),
    cc(av,_40437,_40487),
    !,
    accept(_40499,_40487,_40529),
    adverbx0(_40547,_40529,_40577),
    negation0(_40211,_40595,_40577,_40629),
    pushstack(first,(xnp(_40201,_40203),w(verb(go,pres,fin)),[av]),nil,_40629,_40753),
    statreal1(_40111,_40653,_40753,_40269).

ynq(_40111,[ynq,_40323,_40371,_40429,_40497,_40545,{},!,_40627,_40675,_40723,_40781],_40295,_40299) --> 
    aux1(_40323,_40295,_40353),
    not_look_ahead(w(verb(go,_40211,_40213)),_40371,_40353,_40405),
    subject(_40217,_40219,_40429,_40405,_40467),
    redundant0(_40497,_40467,_40527),
    w(prep(_40197),_40545,_40527,_40579),
    {_40197\==av},
    !,
    accept(_40627,_40579,_40657),
    adverbx0(_40675,_40657,_40705),
    negation0(_40241,_40723,_40705,_40757),
    pushstack(first,(xnp(_40217,_40219),w(verb(go,pres,fin)),w(prep(_40197))),nil,_40757,_40881),
    statreal1(_40111,_40781,_40881,_40299).

ynq(_40111,[ynq,_40353,_40421,_40479,_40537,_40595,_40653,_40721,_40799,!,_40867,_40915,_40963,[],_41131,!,_41371],_40325,_40329) --> 
    aux1(_40205,_40207,_40353,_40325,_40391),
    negation0(_40211,_40421,_40391,_40455),
    not_look_ahead([man],_40479,_40455,_40513),
    not_look_ahead([jeg],_40537,_40513,_40571),
    not_look_ahead([du],_40595,_40571,_40629),
    subject(_40239,_40241,_40653,_40629,_40691),
    preadverbial0(_40245,_40247,_40249,_40721,_40691,_40763),
    negation0(_40253,_40799,_40763,_40833),
    !,
    accept(_40867,_40833,_40897),
    adverbx0(_40915,_40897,_40945),
    negation0(_40257,_40963,_40945,_40997),
    pushstack(free,adverbial1(_40245,_40247,_40249),nil,_40997,_41129),[],
    pushstack(first,(noun_phrase1(_40239,_40241),aux1),nil,_41129,_41311),statreal1(_40111,_41131,_41311,_41337),
    !,
    accept(_41371,_41337,_40329).

ynq(_40111,[ynq,_40259,_40307,_40355,{},!,_40437],_40231,_40235) --> 
    do(_40259,_40231,_40289),
    you(_40307,_40289,_40337),
    w(verb(_40155,_40169,fin),_40355,_40337,_40389),
    {testmember(_40155,[list,show])},
    !,
    pushstack(first,w(verb(_40155,imp,fin)),nil,_40389,_40457),
    command(doit:::_40111,_40437,_40457,_40235).

ynq(_40111,[ynq,_40191,_40239,_40297],_40163,_40167) --> 
    do(_40191,_40163,_40221),
    negation0(_40131,_40239,_40221,_40273),
    statreal1(_40111,_40297,_40273,_40167).

ynq(_40111,[ynq,_40193,_40241,!,_40309],_40165,_40169) --> 
    aux1(_40193,_40165,_40223),
    prep(_40133,_40241,_40223,_40275),
    !,
    reject(_40309,_40275,_40169).

ynq(_40111,[ynq,_40329,_40387,lit(det),_40477,lit(å),!,_40577,_40663],_40301,_40305) --> 
    w(verb(_40185,_40187,fin),_40329,_40301,_40363),
    gmem(_40185,[cost,take,be],_40387,_40363,_40425),
    cc(det,_40425,_40475),
    np0_accept(_40175,_40177,_40477,_40475,_40515),
    cc(å,_40515,_40565),
    !,
    pushstack(first,([noen],[vil]),nil,_40565,_40603),clausal_object1(_40241,_40243,_40577,_40603,_40633),
    pushstack(first,(xnp(_40241,_40243),w(verb(_40185,pres,fin)),xnp(_40175,_40177)),nil,_40633,_40843),
    statreal1(_40111,_40663,_40843,_40305).

ynq(_40111,[ynq,_40251,{},_40323,!,_40391],_40223,_40227) --> 
    w(verb(_40149,_40151,fin),_40251,_40223,_40285),
    {testmember(_40149,[know,find])},
    negation0(_40187,_40323,_40285,_40357),
    !,
    pushstack(free,w(verb(_40149,_40151,fin)),nil,_40357,_40411),
    statreal1(_40111,_40391,_40411,_40227).

ynq(_40111,[ynq,_40285,{},{},_40401,_40459,!,_40517],_40257,_40261) --> 
    lexv(tv,_40161,_40163,fin,_40285,_40257,_40331),
    {_40163\==imp},
    {\+testmember(_40161,[have,think])},
    not_look_ahead(w(adj2(_40219,_40221)),_40401,_40331,_40435),
    anyadverb0(_40459,_40435,_40489),
    !,
    pushstack(free,w(verb(_40161,_40163,fin)),nil,_40489,_40537),
    statreal1(_40111,_40517,_40537,_40261).

ynq(_40111,[ynq,_40251,_40339,lit(til),lit(å),!,_40461],_40223,_40227) --> 
    lexv(iv,come,_40165,fin,_40251,_40223,_40297),
    subject(_40171,_40173,_40339,_40297,_40377),
    cc(til,_40377,_40427),
    cc(å,_40427,_40449),
    !,
    pushstack(first,(xnp(_40171,_40173),[vil]),nil,_40449,_40561),
    statreal(_40111,_40461,_40561,_40227).

ynq(_40111,[ynq,_40269,_40357,_40425,lit(hva),!,_40515],_40241,_40245) --> 
    lexv(rv,know,_40171,fin,_40269,_40241,_40315),
    subject(_40177,_40179,_40357,_40315,_40395),
    negation0(_40183,_40425,_40395,_40459),
    cc(hva,_40459,_40503),
    !,
    pushstack(first,(xnp(_40177,_40179),w(verb(know,_40171,fin)),[hva]),nil,_40503,_40615),
    statreal(_40111,_40515,_40615,_40245).

ynq(_40111,[ynq,_40255,_40343,_40411,!,_40469],_40227,_40231) --> 
    lexv(rv,_40163,_40165,fin,_40255,_40227,_40301),
    subject(_40171,_40173,_40343,_40301,_40381),
    infinitive(_40411,_40381,_40441),
    !,
    pushstack(first,(xnp(_40171,_40173),w(verb(_40163,_40165,fin)),[å]),nil,_40441,_40569),
    statreal(_40111,_40469,_40569,_40231).

ynq(_40111,[ynq,_40361,{},_40433,_40491,_40549,_40627,_40695,_40753,_40811,!,_40879],_40333,_40337) --> 
    w(verb(_40205,_40207,fin),_40361,_40333,_40395),
    {\+testmember(_40205,[be,have])},
    not_look_ahead([det],_40433,_40395,_40467),
    not_look_ahead(w(adj2(_40251,_40253)),_40491,_40467,_40525),
    adverb0(_40197,_40259,_40261,_40549,_40525,_40591),
    subject(_40265,_40267,_40627,_40591,_40665),
    reflexiv0(_40205,_40695,_40665,_40729),
    negation0(_40275,_40753,_40729,_40787),
    rep_particlev0(_40205,_40811,_40787,_40845),
    !,
    pushstack(free,(xnp(_40265,_40267),w(verb(_40205,_40207,fin)),w(adv(_40197))),nil,_40845,_40979),
    statreal(_40111,_40879,_40979,_40337).

ynq(_40111,[ynq,_40275,_40333,_40401,!,_40459,_40507,_40555,_40613,!,_40767],_40247,_40251) --> 
    w(verb(reach,pres,fin),_40275,_40247,_40309),
    np1_accept(_40181,_40187::_40189,_40333,_40309,_40371),
    infinitive(_40401,_40371,_40431),
    !,
    accept(_40459,_40431,_40489),
    adverbx0(_40507,_40489,_40537),
    negation0(_40193,_40555,_40537,_40589),
    pushstack(first,noun_phrase1(_40181,_40187::_40189),nil,_40589,_40707),statreal1(_40111,_40613,_40707,_40733),
    !,
    accept(_40767,_40733,_40251).

ynq(_40111,[ynq,_40205,_40263,!,_40321],_40177,_40181) --> 
    not_look_ahead(w(verb(go,_40143,fin)),_40205,_40177,_40239),
    be(_40263,_40239,_40293),
    !,
    reject(_40321,_40293,_40181).

ynq(_40111,[ynq,_40241,!,_40309,_40357],_40213,_40217) --> 
    w(verb(_40149,pres,pass),_40241,_40213,_40275),
    !,
    thereit0(_40309,_40275,_40339),
    pushstack(free,(w(verb(be,pres,fin)),w(verb(_40149,past,part))),nil,_40339,_40377),
    isq(_40111,_40357,_40377,_40217).

ynq(_40111,[ynq,_40223,_40281,_40339,!,_40407],_40195,_40199) --> 
    w(verb(want,pres,fin),_40223,_40195,_40257),
    not_look_ahead([du],_40281,_40257,_40315),
    not_look_ahead([jeg],_40339,_40315,_40373),
    !,
    reject(_40407,_40373,_40199).

ynq(_40111,[ynq,_40227,_40285,_40333,_40391,!,_40449],_40199,_40203) --> 
    w(verb(go,_40157,fin),_40227,_40199,_40261),
    thereit(_40285,_40261,_40315),
    negation0(_40163,_40333,_40315,_40367),
    anaa(_40391,_40367,_40421),
    !,
    pushstack(first,someone,nil,_40421,_40543),
    statement(_40111,_40449,_40543,_40203).

ynq(_40111,[ynq,_40259,lit(det),{},!,_40393],_40231,_40235) --> 
    lexv(iv,_40155,_40157,fin,_40259,_40231,_40305),
    cc(det,_40305,_40367),
    {testmember(_40155,[rain,snow])},
    !,
    pushstack(first,([det],w(verb(_40155,_40157,fin))),nil,_40367,_40413),
    statement(_40111,_40393,_40413,_40235).

ynq(_40111,[ynq,_40279,lit(det),_40359,_40417,!,_40485],_40251,_40255) --> 
    w(verb(_40161,_40163,fin),_40279,_40251,_40313),
    cc(det,_40313,_40357),
    look_ahead(w(prep(_40193)),_40359,_40357,_40393),
    not_look_ahead([e],_40417,_40393,_40451),
    !,
    pushstack(first,(w(noun(vehicle,plu,u,n)),w(verb(_40161,_40163,fin))),nil,_40451,_40505),
    statement(_40111,_40485,_40505,_40255).

ynq(_40111,[ynq,_40267,{},_40339,_40397,!,_40465],_40239,_40243) --> 
    w(verb(_40161,_40163,fin),_40267,_40239,_40301),
    {\+rv_templ(_40161,_40191)},
    negation0(_40195,_40339,_40301,_40373),
    thereit(_40199,_40397,_40373,_40431),
    !,
    pushstack(first,([det],w(verb(_40161,_40163,fin))),nil,_40431,_40485),
    statement(_40111,_40465,_40485,_40243).

ynq(_40111,[ynq,_40281,_40339,_40397,_40455,{},_40517,!,_40585],_40253,_40257) --> 
    w(verb(_40167,_40169,fin),_40281,_40253,_40315),
    not_look_ahead(w(verb,_40193,_40195),_40339,_40315,_40373),
    not_look_ahead([det],_40397,_40373,_40431),
    saa0(_40455,_40431,_40485),
    {_40167\==have},
    negation0(_40217,_40517,_40485,_40551),
    !,
    pushstack(free,w(verb(_40167,_40169,fin)),nil,_40551,_40605),
    statreal(_40111,_40585,_40605,_40257).

ynq(_40111,[ynq,{},_40265,_40323,!,_40381],_40217,_40221) --> 
    {user:value(smsflag,true)},
    w(verb(have,pres,fin),_40265,_40217,_40299),
    look_ahead_bus(_40323,_40299,_40353),
    !,
    pushstack(free,w(verb(go,pres,fin)),nil,_40353,_40401),
    statreal(_40111,_40381,_40401,_40221).

ynq(_40111,[ynq,_40275,_40333,{},_40435,{},_40497,!,_40555],_40247,_40251) --> 
    not_look_ahead([vil],_40275,_40247,_40309),
    lexv(iv,_40165,_40167,fin,_40333,_40309,_40379),
    {\+rv_templ(_40165,_40201)},
    saa0(_40435,_40379,_40465),
    {_40167\==imp},
    anyadverb0(_40497,_40465,_40527),
    !,
    lock(last,_40527,_40673),
    pushstack(last,lexv(iv,_40165,_40167,fin),nil,_40673,_40685),
    statreal1(_40111,_40555,_40685,_40663),
    unlock(_40663,_40251).

look_ahead_bus([look_ahead_bus,_40203,{}],_40181,_40185) --> 
    look_ahead(w(noun(_40121,_40149,_40151,n)),_40203,_40181,_40185),
    {testmember(_40121,[bus,nightbus,number])}.

look_ahead_bus([look_ahead_bus,_40171],_40149,_40153) --> 
    look_ahead(w(adj2(next,nil)),_40171,_40149,_40153).

ppq(_40115:::_40117,[ppq,_40375,_40433,_40511,!,_40579,!,_40657,_40705,_40991],_40347,_40351) --> 
    prep(_40207,_40375,_40347,_40409),
    whx_phrase(_40211,_40115,_40219::_40221,_40433,_40409,_40475),
    w(verb(_40229,pres,pass),_40511,_40475,_40545),
    !,
    noun_phrase1(_40237,_40243::_40245,_40579,_40545,_40617),
    !,
    accept(_40657,_40617,_40687),
    lock(exact,_40687,_40909),pushstack(exact,(prep(_40207),noun_phrase1(_40211,_40219::_40221)),nil,_40909,_40921),adverbial1(_40193,_40195,_40201::_40203,_40705,_40921,_40899),unlock(_40899,_40901),
    pushstack(first,(someone,w(verb(_40229,pres,fin)),noun_phrase1(_40237,_40243::_40245),adverbial1(_40193,_40195,_40201::_40203)),nil,_40901,_41259),
    statreal(_40117,_40991,_41259,_40351).

ppq(_40115:::_40117,[ppq,_40269,_40327,{},!,_40429,_40517,!,_40585],_40241,_40245) --> 
    prepnof(_40163,_40269,_40241,_40303),
    whx_phrase(_40167,_40115,_40175::_40177,_40327,_40303,_40369),
    {adjustprep(_40167,_40163,_40189)},
    !,
    forwq(_40117,_40189,_40167,_40175::_40177,_40429,_40369,_40475),
    optionalprep(_40189,_40517,_40475,_40551),
    !,
    accept(_40585,_40551,_40245).

optionalprep(in,[optionalprep,_40187,!,_40255],_40159,_40163) --> 
    prep1(_40127,_40187,_40159,_40221),
    !,
    accept(_40255,_40221,_40163).

optionalprep(_40111,[optionalprep,[]],_40143,_40143) --> 
    [].

forwq(_40111,_40113,_40115,_40121::_40123,[forwq,_40283,!,_40381,_40429],_40237,_40241) --> 
    lexv(_40171,be1,_40175,fin,_40283,_40237,_40329),
    !,
    thereit0(_40381,_40329,_40411),
    pushstack(free,(w(verb(be1,pres,fin)),adverbial1(_40113,_40115,_40121::_40123)),nil,_40411,_40537),
    statreal(_40111,_40429,_40537,_40241).

forwq(_40111,_40113,_40115,_40121::_40123,[forwq,_40249,!,_40307],_40203,_40207) --> 
    do(_40249,_40203,_40279),
    !,
    pushstack(free,adverbial1(_40113,_40115,_40121::_40123),nil,_40279,_40415),
    statreal(_40111,_40307,_40415,_40207).

forwq(_40111,_40113,_40115,_40121::_40123,[forwq,_40295,{},_40367,_40415],_40249,_40253) --> 
    w(verb(_40175,_40177,_40179),_40295,_40249,_40329),
    {_40175\==understand},
    thereit0(_40367,_40329,_40397),
    pushstack(free,(w(verb(_40175,_40177,_40179)),adverbial1(_40113,_40115,_40121::_40123)),nil,_40397,_40523),
    statreal(_40111,_40415,_40523,_40253).

whichq(_40115:::_40121 and _40123,[whichq,_40333,_40411,_40469,_40517,_40565,!,_40633,_40681],_40305,_40309) --> 
    whx_phrase(_40199,_40115,true::_40121,_40333,_40305,_40375),
    w(verb(recommend,_40223,pass),_40411,_40375,_40445),
    det0(_40469,_40445,_40499),
    infinitive(_40517,_40499,_40547),
    w(verb(_40233,inf,_40237),_40565,_40547,_40599),
    !,
    accept(_40633,_40599,_40663),
    pushstack(first,([noen],w(verb(recommend,_40223,fin)),[å],w(verb(_40233,inf,_40273)),npgap(_40199)),nil,_40663,_40773),
    statreal(_40123,_40681,_40773,_40309).

whichq(_40115:::_40121 and _40123,[whichq,_40289,_40367,_40415,_40473,!,_40551],_40261,_40265) --> 
    whx_phrase(_40175,_40115,true::_40121,_40289,_40261,_40331),
    paux0(_40367,_40331,_40397),
    w(verb(_40197,_40199,pass),_40415,_40397,_40449),
    whodidit(_40205,_40207,_40473,_40449,_40511),
    !,
    pushstack(first,(xnp(_40205,_40207),w(verb(_40197,_40199,fin)),npgap(_40175)),nil,_40511,_40729),
    statreal(_40123,_40551,_40729,_40265).

whichq(_40115:::_40117,[whichq,_40239,_40317,_40395,{}],_40211,_40215) --> 
    whx_phrase(_40151,_40115,_40147::_40117,_40239,_40211,_40281),
    realcomp(_40165,_40167,_40145,_40317,_40281,_40359),
    qverb_phrase(_40151,_40143,_40165,_40167,_40395,_40359,_40215),
    {negate(_40143,_40145,_40147)}.

whx_phrase(_40111,_40113,_40119::_40121,[whx_phrase,{},_40363,_40431,{},!,_40513,!,_40635],_40303,_40307) --> 
    {user:value(busflag,true)},
    whichf(_40111,_40113,_40363,_40303,_40401),
    look_ahead(w(verb(_40197,_40199,fin)),_40431,_40401,_40465),
    {testmember(_40197,[go,pass,leave,depart,arrive])},
    !,
    lock(exact,_40465,_40553),pushstack(exact,w(noun(vehicle,plu,u,n)),nil,_40553,_40565),noun_phrase1(_40111,_40119::_40121,_40513,_40565,_40543),unlock(_40543,_40545),
    !,
    accept(_40635,_40545,_40307).

whx_phrase(_40111,_40113,_40119::_40121,[whx_phrase,_40293,_40361,_40409,_40467,!,_40525],_40253,_40257) --> 
    whichf(_40111,_40113,_40293,_40253,_40331),
    oter(_40361,_40331,_40391),
    w(noun(_40181,_40183,u,n),_40409,_40391,_40443),
    enn(_40467,_40443,_40497),
    !,
    pushstack(first,(w(noun(_40181,_40183,u,n)),[ulik]),nil,_40497,_40545),
    noun_phrase1(_40111,_40119::_40121,_40525,_40545,_40257).

whx_phrase(_40111,which(_40111),_40119::_40121,[whx_phrase,_40307,_40355,_40413,{},!,_40495],_40267,_40271) --> 
    hvordan(_40307,_40267,_40337),
    not_look_ahead(w(verb(_40187,pres,fin)),_40355,_40337,_40389),
    w(noun(_40169,_40201,_40203,_40205),_40413,_40389,_40447),
    {_40169\==type},
    !,
    pushstack(first,w(noun(_40169,sin,u,n)),nil,_40447,_40515),
    noun_phrase1(_40111,_40119::_40121,_40495,_40515,_40271).

whx_phrase(_40111,which(_40111),_40119::_40121,[whx_phrase,lit(hva),_40317,_40375,{},!,_40457],_40255,_40259) --> 
    cc(hva,_40255,_40315),
    not_look_ahead(w(verb(_40183,_40185,_40187)),_40317,_40315,_40351),
    look_ahead(w(noun(_40199,_40201,_40203,_40205)),_40375,_40351,_40409),
    {_40199\==type},
    !,
    noun_phrase1(_40111,_40119::_40121,_40457,_40409,_40259).

whx_phrase(_40111,_40113,_40119::_40121,[whx_phrase,_40243,_40311,_40359,!,_40437],_40203,_40207) --> 
    whichf(_40111,_40113,_40243,_40203,_40281),
    type0(_40311,_40281,_40341),
    noun_phrase1(_40111,_40119::_40121,_40359,_40341,_40397),
    !,
    accept(_40437,_40397,_40207).

whx_phrase(_40111,_40113,_40119::_40121,[whx_phrase,_40275,_40343,!,_40411,!,_40507],_40235,_40239) --> 
    whichf(_40111,_40113,_40275,_40235,_40313),
    w(nb(_40165,num),_40343,_40313,_40377),
    !,
    pushstack(first,w(nb(_40165,num)),nil,_40377,_40437),noun_phrase1(_40111,_40119::_40121,_40411,_40437,_40467),
    !,
    accept(_40507,_40467,_40239).

whichf(_40111,which(_40111),[whichf,_40187],_40153,_40157) --> 
    which2(_40187,_40153,_40157).

whichg00(_40111,_40113,_40133:_40111,which(_40133):::_40133 isa _40111 and _40113,[whichg00,[]],_40189,_40189) --> 
    [].

qstatement(_40111,_40117:::_40119,[qstatement,{},_40223],_40175,_40179) --> 
    {which_thing(_40111,_40117)},
    statreal(_40119,_40223,_40175,_40179).

what_phrase(_40119:thing,which(_40119:thing),_40119 isa thing,[what_phrase,lit(hva)],_40181,_40185) --> 
    cc(hva,_40181,_40185).

whatq(_40111,[whatq,lit(hva),_40345,_40403,_40471,_40539,_40597,!,_40655,_40703],_40295,_40299) --> 
    cc(hva,_40295,_40343),
    w(verb(use,_40207,fin),_40345,_40343,_40379),
    subject(_40213,_40215,_40403,_40379,_40441),
    np1_accept(_40219,_40221,_40471,_40441,_40509),
    prep1(_40225,_40539,_40509,_40573),
    not_look_ahead_np(_40597,_40573,_40627),
    !,
    accept(_40655,_40627,_40685),
    pushstack(first,(xnp(_40213,_40215),w(verb(use,_40207,fin)),np(_40219,_40221),w(prep(_40225)),npgap(_40193)),nil,_40685,_40961),
    qstatement(_40193,_40111,_40703,_40961,_40299).

whatq(which(_40123):::_40121 ako _40123,[whatq,{},_40265,_40313,_40361,_40419,!],_40223,_40227) --> 
    {\+user:value(dialog,1)},
    whatbemean(_40265,_40223,_40295),
    art1(_40313,_40295,_40343),
    w(noun(_40121,_40187,u,n),_40361,_40343,_40395),
    endofline(_40419,_40395,_40227),
    !.

whatq(which(_40123):::_40121 ako _40123,[whatq,{},_40293,_40341,{},_40413],_40251,_40255) --> 
    {\+user:value(dialog,1)},
    whatbemean(_40293,_40251,_40323),
    w(noun(_40121,_40181,u,n),_40341,_40323,_40375),
    {\+testmember(_40121,[clock,special_ticket,price,bus,station])},
    endofline(_40413,_40375,_40255).

whatq(_40111,[whatq,{},_40273,_40321,_40379,!,_40437],_40231,_40235) --> 
    {\+user:value(dialog,1)},
    whatbemean(_40273,_40231,_40303),
    look_ahead(w(name(_40191,_40193,_40195)),_40321,_40303,_40355),
    redundant0(_40379,_40355,_40409),
    !,
    pushstack(first,w(verb(describe,imp,fin)),nil,_40409,_40457),
    command(_40111,_40437,_40457,_40235).

whatq(which(_40125:thing):::_40117,[whatq,lit(hva),_40337,_40425,_40493,_40561,_40629],_40287,_40291) --> 
    cc(hva,_40287,_40335),
    lexv(tv,_40195,_40197,fin,_40337,_40335,_40383),
    gmem(_40195,[hold,keep,drive,operate],_40425,_40383,_40463),
    subject(_40225,_40227,_40493,_40463,_40531),
    particlev2(_40195,_40233,_40561,_40531,_40599),
    pushstack(first,(xnp(_40225,_40227),w(verb(_40233,pres,fin)),npgap(_40125:thing)),nil,_40599,_40797),
    statreal(_40117,_40629,_40797,_40291).

whatq(_40115:::_40117,[whatq,{},lit(hva),_40405,_40453,_40521,_40579,lit(kunne),_40689,!,_40757],_40341,_40345) --> 
    {which_thing(_40211,_40115)},
    cc(hva,_40341,_40403),
    has(_40405,_40403,_40435),
    subject(_40229,_40231,_40453,_40435,_40491),
    w(verb(expect,past,part),_40521,_40491,_40555),
    optional([at],_40579,_40555,_40643),
    cc(kunne,_40643,_40687),
    w(verb(_40263,_40265,pass),_40689,_40687,_40723),
    !,
    pushstack(first,(xnp(_40229,_40231),w(verb(expect,past,fin)),[at],[noen],w(verb(_40263,pres,fin)),npgap(_40211)),nil,_40723,_40935),
    statreal(_40117,_40757,_40935,_40345).

whatq(_40115:::_40121 and _40123,[whatq,_40283,_40361,_40409,_40467,!,_40545],_40255,_40259) --> 
    what_phrase(_40175,_40115,_40121,_40283,_40255,_40325),
    paux0(_40361,_40325,_40391),
    w(verb(_40191,_40193,pass),_40409,_40391,_40443),
    whodidit(_40199,_40201,_40467,_40443,_40505),
    !,
    pushstack(first,(xnp(_40199,_40201),w(verb(_40191,_40193,fin)),npgap(_40175)),nil,_40505,_40723),
    statreal(_40123,_40545,_40723,_40259).

whatq(_40115:::_40121 and _40123,[whatq,_40357,_40435,{},_40537,_40605,_40673,!,_40751,[],_40915],_40329,_40333) --> 
    what_phrase(_40211,_40115,_40121,_40357,_40329,_40399),
    lexv(rv,_40221,_40223,fin,_40435,_40399,_40481),
    {\+testmember(_40221,[])},
    subject(_40243,_40245,_40537,_40481,_40575),
    that0(_40221,that,_40605,_40575,_40643),
    subject(_40205,_40207,_40673,_40643,_40711),
    !,
    negation0(_40261,_40751,_40711,_40785),
    pushstack(free,npgap(_40211),nil,_40785,_40913),[],
    pushstack(first,(xnp(_40243,_40245),w(verb(_40221,pres,fin)),[at],xnp(_40205,_40207)),nil,_40913,_41095),
    statreal(_40123,_40915,_41095,_40333).

whatq(_40115:::_40121 and _40123,[whatq,_40283,_40361,lit(det),_40441,_40529,!,_40607],_40255,_40259) --> 
    what_phrase(_40175,_40115,_40121,_40283,_40255,_40325),
    w(verb(be,_40193,fin),_40361,_40325,_40395),
    cc(det,_40395,_40439),
    optional([som],_40441,_40439,_40505),
    specific_phrase(_40211,_40213,_40529,_40505,_40567),
    !,
    pushstack(free,(xnp(_40211,_40213),npgap(_40175)),nil,_40567,_40785),
    statreal(_40123,_40607,_40785,_40259).

whatq(which(_40125:thing):::_40117,[whatq,lit(hva),_40337,_40425,_40473,_40541,_40599,_40657],_40287,_40291) --> 
    cc(hva,_40287,_40335),
    lexv(rv,_40207,_40209,fin,_40337,_40335,_40383),
    look_ahead_subject(_40425,_40383,_40455),
    np0_accept(_40215,_40217,_40473,_40455,_40511),
    negation0(_40221,_40541,_40511,_40575),
    prepnom(_40225,_40599,_40575,_40633),
    pushstack(first,(xnp(_40215,_40217),w(verb(_40207,pres,fin)),w(prep(_40225)),npgap(_40125:thing)),nil,_40633,_40841),
    statreal(_40117,_40657,_40841,_40291).

whatq(_40115:::_40121 and _40123,[whatq,_40339,_40417,{},_40519,_40587,_40645,_40703,_40761],_40311,_40315) --> 
    what_phrase(_40187,_40115,_40121,_40339,_40311,_40381),
    lexv(tv,do,_40203,fin,_40417,_40381,_40463),
    {\+testmember(do,[cost,be2,have])},
    subject(_40235,_40237,_40519,_40463,_40557),
    not_look_ahead([at],_40587,_40557,_40621),
    not_look_ahead([å],_40645,_40621,_40679),
    negation0(_40257,_40703,_40679,_40737),
    pushstack(first,(xnp(_40235,_40237),w(verb(do,pres,fin)),npgap(_40187)),nil,_40737,_40939),
    statreal(_40123,_40761,_40939,_40315).

whatq(_40115:::_40117,[whatq,{},lit(hva),_40325,_40373,_40441,!,_40509],_40261,_40265) --> 
    {which_thing(_40175,_40115)},
    cc(hva,_40261,_40323),
    has(_40325,_40323,_40355),
    subject(_40193,_40195,_40373,_40355,_40411),
    w(verb(_40203,past,part),_40441,_40411,_40475),
    !,
    pushstack(first,(xnp(_40193,_40195),w(verb(_40203,past,fin)),npgap(_40175)),nil,_40475,_40687),
    statreal(_40117,_40509,_40687,_40265).

whatq(_40115:::_40117,[whatq,{},lit(hva),_40395,_40443,_40511,_40619,!,_40687,_40949],_40331,_40335) --> 
    {which_thing(_40197,_40115)},
    cc(hva,_40331,_40393),
    has(_40395,_40393,_40425),
    subject(_40207,_40209,_40443,_40425,_40481),
    noun(_40213,_40215,_40217,_40219,_40187,_40223,_40511,_40481,_40565),
    prepnom(_40227,_40619,_40565,_40653),
    !,
    lock(exact,_40653,_40877),pushstack(exact,(noun(_40213,_40215,_40217,_40219,_40187,_40223),w(prep(_40227)),npgap(_40197)),nil,_40877,_40889),np1(_40187,_40189,_40687,_40889,_40867),unlock(_40867,_40869),
    pushstack(first,(xnp(_40207,_40209),w(verb(have,pres,fin)),xnp(_40187,_40189)),nil,_40869,_41129),
    statreal(_40117,_40949,_41129,_40335).

whatq(which(_40125:thing):::_40117,[whatq,lit(hva),_40371,{},lit(det),_40465,lit(å),_40535,!,_40631],_40321,_40325) --> 
    cc(hva,_40321,_40369),
    w(verb(_40215,_40217,fin),_40371,_40369,_40405),
    {testmember(_40215,[cost])},
    cc(det,_40405,_40463),
    for0(_40465,_40463,_40495),
    cc(å,_40495,_40533),
    pushstack(first,([noen],[vil]),nil,_40533,_40561),clausal_object1(_40261,_40263,_40535,_40561,_40591),
    !,
    pushstack(first,(xnp(_40261,_40263),w(verb(_40215,pres,fin)),npgap(_40125:thing)),nil,_40591,_40815),
    statreal1(_40117,_40631,_40815,_40325).

for0([for0,lit(for),!],_40145,_40149) --> 
    cc(for,_40145,_40149),
    !.

for0([for0,[]],_40135,_40135) --> 
    [].

whatq(_40115:::_40117,[whatq,lit(hva),_40393,{},lit(det),_40487,!,_40555,{},_40617,_40729],_40343,_40347) --> 
    cc(hva,_40343,_40391),
    w(verb(_40205,_40207,fin),_40393,_40391,_40427),
    {testmember(_40205,[cost,weigh])},
    cc(det,_40427,_40485),
    look_ahead(w(prep(_40243)),_40487,_40485,_40521),
    !,
    accept(_40555,_40521,_40585),
    {which_thing(_40193,_40115)},
    lock(exact,_40585,_40657),pushstack(exact,w(noun(ticket,sin,u,n)),nil,_40657,_40669),noun_phrase1(_40277,_40283::_40285,_40617,_40669,_40647),unlock(_40647,_40649),
    pushstack(first,(noun_phrase1(_40277,_40283::_40285),lexv(tv,_40205,_40207,fin),npgap(_40193)),nil,_40649,_40981),
    statreal(_40117,_40729,_40981,_40347).

whatq(_40115:::_40121 and _40123,[whatq,_40315,_40393,_40451,_40519,{},!,_40611],_40287,_40291) --> 
    what_phrase(_40181,_40115,_40121,_40315,_40287,_40357),
    w(verb(_40197,_40199,fin),_40393,_40357,_40427),
    gmem(_40197,[cost,weigh],_40451,_40427,_40489),
    np1_accept(_40219,_40221,_40519,_40489,_40557),
    {\+constrain(_40219,place)},
    !,
    pushstack(first,(xnp(_40219,_40221),lexv(tv,_40197,_40199,fin),npgap(_40181)),nil,_40557,_40873),
    statreal(_40123,_40611,_40873,_40291).

whatq(_40115:::_40121 and _40123,[whatq,_40221,_40299,_40377],_40193,_40197) --> 
    what_phrase(_40139,_40115,_40121,_40221,_40193,_40263),
    realcomp(_40143,_40145,_40123,_40299,_40263,_40341),
    qverb_phrase(_40139,id,_40143,_40145,_40377,_40341,_40197).

whatq(which(_40125:thing):::_40117,[whatq,_40283,lit(det),_40353,_40411,_40479,!,_40547],_40255,_40259) --> 
    whatbe(_40283,_40255,_40313),
    cc(det,_40313,_40351),
    not_look_ahead(w(adj2(_40201,nil)),_40353,_40351,_40387),
    subject(_40207,_40209,_40411,_40387,_40449),
    negation0(_40213,_40479,_40449,_40513),
    !,
    pushstack(free,(xnp(_40207,_40209),npgap(_40125:thing)),nil,_40513,_40731),
    statement(_40117,_40547,_40731,_40259).

whatq(_40111,[whatq,_40327,_40375,_40423,_40471,_40529,{},!,_40611],_40299,_40303) --> 
    whatbe(_40327,_40299,_40357),
    so0(_40375,_40357,_40405),
    dent0(_40423,_40405,_40453),
    not_look_ahead(w(nb(_40199,_40201)),_40471,_40453,_40505),
    w(adj2(_40185,nil),_40529,_40505,_40563),
    {\+testmember(_40185,[near,nearest,next])},
    !,
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin)),w(adj2(_40185,nil))),nil,_40563,_40703),
    whichq(_40111,_40611,_40703,_40303).

whatq(which(_40121):::_40117,[whatq,_40227,_40275,_40323,!,_40391,_40459],_40199,_40203) --> 
    whatbe(_40227,_40199,_40257),
    thereit(_40275,_40257,_40305),
    prep1(for,_40323,_40305,_40357),
    !,
    noun_phrase1(_40121,true::_40117,_40391,_40357,_40429),
    danow0(_40459,_40429,_40203).

whatq(which(_40121):::_40117,[whatq,_40315,lit(det),lit(som),!,_40417,_40465,_40533,_40645],_40287,_40291) --> 
    whatbe(_40315,_40287,_40345),
    cc(det,_40345,_40383),
    cc(som,_40383,_40405),
    !,
    accept(_40417,_40405,_40447),
    np(_40199,_40205::_40207,_40465,_40447,_40503),
    lock(exact,_40503,_40573),pushstack(exact,w(noun(thing,sin,u,n)),nil,_40573,_40585),np(_40121,_40185::_40187,_40533,_40585,_40563),unlock(_40563,_40565),
    pushstack(free,(np(_40199,_40205::_40207),np(_40121,_40185::_40187)),nil,_40565,_40837),
    statreal(_40117,_40645,_40837,_40291).

whatq(which(_40121):::_40117,[whatq,_40275,_40323,_40381,_40439,_40525,!,_40583],_40247,_40251) --> 
    whatbe(_40275,_40247,_40305),
    w(noun(time,_40167,_40169,n),_40323,_40305,_40357),
    look_ahead(w(prep(_40183)),_40381,_40357,_40415),
    pushstack(first,w(noun(departure,sin,u,n)),nil,_40415,_40465),noun_phrase1(_40121,true::_40117,_40439,_40465,_40495),
    danow0(_40525,_40495,_40555),
    !,
    accept(_40583,_40555,_40251).

whatq(_40115:::_40117,[whatq,{},_40309,lit(det),_40379,_40437,_40505,!,_40573],_40267,_40271) --> 
    {which_thing(_40175,_40115)},
    whatbe(_40309,_40267,_40339),
    cc(det,_40339,_40377),
    not_look_ahead(w(adj2(_40201,nil)),_40379,_40377,_40413),
    noun_phrase1(_40207,_40213::_40215,_40437,_40413,_40475),
    negation0(_40219,_40505,_40475,_40539),
    !,
    pushstack(free,(np(_40207,_40213::_40215),npgap(_40175)),nil,_40539,_40757),
    statement(_40117,_40573,_40757,_40271).

whatq(which(_40125:thing):::_40117,[whatq,_40309,_40357,_40415,_40473,_40541,_40589,!,_40647],_40281,_40285) --> 
    whatbe(_40309,_40281,_40339),
    not_look_ahead([det],_40357,_40339,_40391),
    not_look_ahead(w(name(_40217,n,_40221)),_40415,_40391,_40449),
    np(_40225,_40227,_40473,_40449,_40511),
    danow0(_40541,_40511,_40571),
    endofline(_40589,_40571,_40619),
    !,
    lock(exact,_40619,_40845),
    pushstack(exact,(xnp(_40225,_40227),w(verb(be,pres,fin)),npgap(_40125:thing)),nil,_40845,_40857),
    statreal(_40117,_40647,_40857,_40835),
    unlock(_40835,_40285).

whatq(which(_40121):::_40117,[whatq,_40241,_40289,_40347,_40405,_40473],_40213,_40217) --> 
    whatbe(_40241,_40213,_40271),
    not_look_ahead([det],_40289,_40271,_40323),
    not_look_ahead(w(name(_40165,n,_40169)),_40347,_40323,_40381),
    np1_accept(_40121,true::_40117,_40405,_40381,_40443),
    danow0(_40473,_40443,_40217).

whatq(which(_40125:thing):::_40117,[whatq,_40321,_40369,_40437,_40495,!,_40563],_40293,_40297) --> 
    whatbe(_40321,_40293,_40351),
    noun_phrase1(_40201,_40203,_40369,_40351,_40407),
    w(verb(_40211,past,part),_40437,_40407,_40471),
    prep(_40219,_40495,_40471,_40529),
    !,
    pushstack(first,(noun_phrase1(_40201,_40203),w(verb(be,pres,fin)),w(verb(_40211,past,part)),w(prep(_40219)),npgap(_40125:thing)),nil,_40529,_40747),
    statement(_40117,_40563,_40747,_40297).

whatq(_40111,[whatq,_40225,_40273],_40197,_40201) --> 
    whatbe(_40225,_40197,_40255),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin))),nil,_40255,_40367),
    whichq(_40111,_40273,_40367,_40201).

whatq(_40111,[whatq,lit(hva),_40343,_40391,_40459,_40517,!,_40585,_40633],_40293,_40297) --> 
    cc(hva,_40293,_40341),
    aux1(_40343,_40341,_40373),
    np1_accept(_40195,_40201::_40203,_40391,_40373,_40429),
    w(verb(use,_40213,pass),_40459,_40429,_40493),
    prep1(_40219,_40517,_40493,_40551),
    !,
    accept(_40585,_40551,_40615),
    pushstack(first,([noen],w(verb(use,_40213,fin)),np(_40195,_40201::_40203),w(prep(_40219)),npgap(_40187)),nil,_40615,_40817),
    qstatement(_40187,_40111,_40633,_40817,_40297).

whatq(_40111,[whatq,lit(hva),_40337,_40395,_40463,!,_40531,_40579],_40287,_40291) --> 
    cc(hva,_40287,_40335),
    w(verb(use,_40195,pass),_40337,_40335,_40371),
    np1_accept(_40201,_40207::_40209,_40395,_40371,_40433),
    prep1(_40213,_40463,_40433,_40497),
    !,
    accept(_40531,_40497,_40561),
    pushstack(first,([noen],w(verb(use,_40195,fin)),np(_40201,_40207::_40209),w(prep(_40213)),npgap(_40181)),nil,_40561,_40763),
    qstatement(_40181,_40111,_40579,_40763,_40291).

whatq(which(_40125:thing):::_40117,[whatq,_40353,_40401,_40469,_40517,_40575,_40633,_40691,{},!,_40773],_40325,_40329) --> 
    whatcan(_40353,_40325,_40383),
    subject(_40219,_40221,_40401,_40383,_40439),
    redundant0(_40469,_40439,_40499),
    negation0(_40225,_40517,_40499,_40551),
    w(verb(_40233,_40235,_40237),_40575,_40551,_40609),
    reflexiv0(_40233,_40633,_40609,_40667),
    prepnom(_40245,_40691,_40667,_40725),
    {testmember(_40245,[regarding,with])},
    !,
    pushstack(first,(xnp(_40219,_40221),w(verb(_40233,_40235,_40237)),w(prep(_40245)),npgap(_40125:thing)),nil,_40725,_40957),
    statreal(_40117,_40773,_40957,_40329).

whatq(_40115:::_40117,[whatq,_40291,{},_40353,_40421,lit(om),!,_40511],_40263,_40267) --> 
    whatcan(_40291,_40263,_40321),
    {which_thing(_40189,_40115)},
    specific_phrase(_40195,_40197,_40353,_40321,_40391),
    negation0(_40201,_40421,_40391,_40455),
    cc(om,_40455,_40499),
    !,
    pushstack(first,(noun_phrase1(_40195,_40197),w(verb(know1,pres,fin)),npgap(_40189),[om]),nil,_40499,_40689),
    statreal(_40117,_40511,_40689,_40267).

whatq(_40115:::_40117,[whatq,_40373,{},_40435,_40503,_40561,_40619,lit(_40243),{},_40713,!,_40781],_40345,_40349) --> 
    whatcan(_40373,_40345,_40403),
    {which_thing(_40199,_40115)},
    specific_phrase(_40213,_40219::_40221,_40435,_40403,_40473),
    negation0(_40225,_40503,_40473,_40537),
    w(verb(_40233,_40235,_40237),_40561,_40537,_40595),
    reflexiv0(_40233,_40619,_40595,_40653),
    cc(_40243,_40653,_40697),
    {testmember(_40243,[på,om,til])},
    not_look_ahead(w(noun(_40279,_40281,_40283,_40285)),_40713,_40697,_40747),
    !,
    pushstack(first,(noun_phrase1(_40213,_40219::_40221),w(verb(_40233,_40235,_40237)),npgap(_40199)),nil,_40747,_40965),
    statreal(_40117,_40781,_40965,_40349).

whatq(_40115:::_40117,[whatq,_40359,{},_40421,_40489,_40547,_40605,lit(om),_40685,!,_40763],_40331,_40335) --> 
    whatcan(_40359,_40331,_40389),
    {which_thing(_40215,_40115)},
    specific_phrase(_40221,_40227::_40229,_40421,_40389,_40459),
    negation0(_40233,_40489,_40459,_40523),
    w(verb(_40241,_40243,_40245),_40547,_40523,_40581),
    reflexiv0(_40241,_40605,_40581,_40639),
    cc(om,_40639,_40683),
    noun_phrase1(_40205,_40207,_40685,_40683,_40723),
    !,
    pushstack(first,(noun_phrase1(_40221,_40227::_40229),w(verb(_40241,_40243,_40245)),npgap(_40215),w(prep(regarding)),np(_40205,_40207)),nil,_40723,_41027),
    statreal(_40117,_40763,_41027,_40335).

whatq(_40115:::_40117,[whatq,_40359,{},_40421,_40489,_40547,_40635,_40703,!,_40771],_40331,_40335) --> 
    whatcan(_40359,_40331,_40389),
    {which_thing(_40199,_40115)},
    specific_phrase(_40213,_40219::_40221,_40421,_40389,_40459),
    negation0(_40225,_40489,_40459,_40523),
    lexv(tv,_40231,_40233,_40235,_40547,_40523,_40593),
    np1(_40239,_40245::_40247,_40635,_40593,_40673),
    prepnom(_40251,_40703,_40673,_40737),
    !,
    pushstack(first,(noun_phrase1(_40213,_40219::_40221),w(verb(_40231,_40233,_40235)),np1(_40239,_40245::_40247),w(prep(_40251)),npgap(_40199)),nil,_40737,_41023),
    statreal(_40117,_40771,_41023,_40335).

whatq(_40115:::_40117,[whatq,_40361,_40409,_40477,_40535,_40593,_40661,!,{},_40743],_40333,_40337) --> 
    whatcan(_40361,_40333,_40391),
    specific_phrase(_40211,_40217::_40219,_40409,_40391,_40447),
    negation0(_40223,_40477,_40447,_40511),
    w(verb(_40231,_40233,_40235),_40535,_40511,_40569),
    noun_phrase1(_40199,_40205::_40207,_40593,_40569,_40631),
    prepnom(_40251,_40661,_40631,_40695),
    !,
    {which_thing(_40259,_40115)},
    pushstack(first,(noun_phrase1(_40211,_40217::_40219),w(verb(_40231,_40233,_40235)),npgap(_40259),w(prep(_40251)),np(_40199,_40205::_40207)),nil,_40695,_41013),
    statreal(_40117,_40743,_41013,_40337).

whatq(_40115:::_40117,[whatq,_40305,{},_40367,_40435,_40493,!,_40561],_40277,_40281) --> 
    whatcan(_40305,_40277,_40335),
    {which_thing(_40175,_40115)},
    specific_phrase(_40189,_40195::_40197,_40367,_40335,_40405),
    negation0(_40201,_40435,_40405,_40469),
    not_look_ahead(w(verb(_40213,_40215,_40217)),_40493,_40469,_40527),
    !,
    pushstack(first,(noun_phrase1(_40189,_40195::_40197),w(verb(do1,pres,fin)),npgap(_40175)),nil,_40527,_40745),
    statreal(_40117,_40561,_40745,_40281).

whatq(_40115:::_40117,[whatq,_40311,{},_40373,_40441,_40499,_40557,!,_40625],_40283,_40287) --> 
    whatcan(_40311,_40283,_40341),
    {which_thing(_40181,_40115)},
    specific_phrase(_40195,_40201::_40203,_40373,_40341,_40411),
    negation0(_40207,_40441,_40411,_40475),
    w(verb(_40215,_40217,_40219),_40499,_40475,_40533),
    reflexiv0(_40215,_40557,_40533,_40591),
    !,
    pushstack(first,(noun_phrase1(_40195,_40201::_40203),w(verb(_40215,_40217,_40219)),npgap(_40181)),nil,_40591,_40809),
    statreal(_40117,_40625,_40809,_40287).

whatq(_40115:::_40117,[whatq,lit(hva),{},_40329,_40387,!,_40465],_40265,_40269) --> 
    cc(hva,_40265,_40313),
    {which_thing(_40169,_40115)},
    w(verb(know,_40193,fin),_40329,_40313,_40363),
    specific_phrase(_40199,_40205::_40207,_40387,_40363,_40425),
    !,
    pushstack(first,(noun_phrase1(_40199,_40205::_40207),lexv(tv,know1,_40193,fin),npgap(_40169)),nil,_40425,_40717),
    statreal(_40117,_40465,_40717,_40269).

whatq(_40111,[whatq,lit(hva),_40245,_40293],_40195,_40199) --> 
    cc(hva,_40195,_40243),
    do(_40245,_40243,_40275),
    pushstack(first,(which,w(noun(thing,sin,u,n)),do),nil,_40275,_40459),
    whichq(_40111,_40293,_40459,_40199).

whatq(_40111,[whatq,lit(hva),_40289,!,_40387,_40435,_40493],_40239,_40243) --> 
    cc(hva,_40239,_40287),
    lexv(iv,_40167,_40183,fin,_40289,_40287,_40335),
    !,
    accept(_40387,_40335,_40417),
    negation0(_40189,_40435,_40417,_40469),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(_40167,pres,fin))),nil,_40469,_40587),
    whichq(_40111,_40493,_40587,_40243).

whenq(which(_40121):::_40117,[whenq,_40253,_40331,lit(det),_40401,!,_40459],_40225,_40229) --> 
    when_adverbialq(_40161,_40121,_40169::_40171,_40253,_40225,_40295),
    be(_40331,_40295,_40361),
    cc(det,_40361,_40399),
    that0(_40401,_40399,_40431),
    !,
    pushstack(free,xadverbial1(_40161,_40121,_40169::_40171),nil,_40431,_40547),
    statreal(_40117,_40459,_40547,_40229).

whenq(which(_40121):::_40117,[whenq,_40261,_40339,!,_40407,_40455],_40233,_40237) --> 
    when_adverbialq(_40155,_40121,_40163::_40165,_40261,_40233,_40303),
    look_ahead(w(noun(bus,_40193,_40195,n)),_40339,_40303,_40373),
    !,
    accept(_40407,_40373,_40437),
    pushstack(free,xadverbial1(_40155,_40121,_40163::_40165),nil,_40437,_40563),
    statreal(_40117,_40455,_40563,_40237).

whenq(which(_40121):::_40117,[whenq,_40329,_40407,_40465,{},!,_40547],_40301,_40305) --> 
    when_adverbialq(_40173,_40121,_40181::_40183,_40329,_40301,_40371),
    w(verb(go,_40207,fin),_40407,_40371,_40441),
    look_ahead(w(prep(_40221)),_40465,_40441,_40499),
    {testmember(_40221,[from,to])},
    !,
    pushstack(free,(w(noun(bus,sin,u,n)),w(verb(go,_40207,fin)),xadverbial1(_40173,_40121,_40181::_40183)),nil,_40499,_40655),
    statreal(_40117,_40547,_40655,_40305).

whenq(which(_40121):::_40117,[whenq,_40279,_40357,_40405,_40453,!,_40531,_40579,_40637],_40251,_40255) --> 
    when_adverbialq(_40171,_40121,_40189::_40191,_40279,_40251,_40321),
    be(_40357,_40321,_40387),
    detnexttime(_40405,_40387,_40435),
    np1(_40167,_40201::_40203,_40453,_40435,_40491),
    !,
    accept(_40531,_40491,_40561),
    negation0(_40207,_40579,_40561,_40613),
    whencomplex(_40167,_40201::_40203,_40171,_40121,_40189::_40191,_40117,_40637,_40613,_40255).

whenq(which(_40121):::_40117,[whenq,_40235,_40283,{},!,_40365],_40207,_40211) --> 
    when(_40235,_40207,_40265),
    look_ahead(w(prep(_40157)),_40283,_40265,_40317),
    {testmember(_40157,[from,to])},
    !,
    reject(_40365,_40317,_40211).

whenq(which(_40121):::_40117,[whenq,_40365,_40413,_40491,!,_40579,_40627,!,_40801,_40849],_40337,_40341) --> 
    when(_40365,_40337,_40395),
    preadverbial1(_40205,_40207,_40213::_40215,_40413,_40395,_40455),
    preadverbial1(_40191,_40193,_40199::_40201,_40491,_40455,_40533),
    !,
    accept(_40579,_40533,_40609),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_40609,_40721),adverbial1(_40259,_40121,_40267::_40269,_40627,_40721,_40755),
    !,
    accept(_40801,_40755,_40831),
    lock(last,_40831,_41127),
    pushstack(last,(adverbial1(in,_40121,_40267::_40269),adverbial1(_40205,_40207,_40213::_40215),adverbial1(_40191,_40193,_40199::_40201)),nil,_41127,_41139),
    question0(_40117,_40849,_41139,_41117),
    unlock(_41117,_40341).

whenq(which(_40121):::_40117,[whenq,_40339,_40387,_40445,!,_40533,_40581,!,_40765,_40813],_40311,_40315) --> 
    when(_40339,_40311,_40369),
    not_look_ahead([e],_40387,_40369,_40421),
    adverbial1(_40185,_40187,_40193::_40195,_40445,_40421,_40487),
    !,
    accept(_40533,_40487,_40563),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_40563,_40685),adverbial1(_40247,_40121,_40255::_40257,_40581,_40685,_40719),
    !,
    accept(_40765,_40719,_40795),
    lock(last,_40795,_41003),
    pushstack(last,(xadverbial1(in,_40121,_40255::_40257),xadverbial1(_40185,_40187,_40193::_40195)),nil,_41003,_41015),
    question0(_40117,_40813,_41015,_40993),
    unlock(_40993,_40315).

whenq(which(_40121):::_40117,[whenq,_40299,_40347,!,_40435,!,_40645],_40271,_40275) --> 
    when(_40299,_40271,_40329),
    adverb(_40167,_40169,pre,_40347,_40329,_40389),
    !,
    lock(exact,_40389,_40553),pushstack(exact,(prep(in),w(noun(time,sin,u,n))),nil,_40553,_40565),adverbial1(_40207,_40121,_40215::_40217,_40435,_40565,_40543),unlock(_40543,_40545),
    !,
    pushstack(free,(xadverbial1(in,_40121,_40215::_40217),xadverb(_40167,_40169)),nil,_40545,_40833),
    question0(_40117,_40645,_40833,_40275).

whenq(which(_40121):::_40117,[whenq,_40323,_40401,{},_40473,_40521,!,_40589],_40295,_40299) --> 
    howlongto(_40179,_40121,_40187::_40189,_40323,_40295,_40365),
    w(adj2(_40211,nil),_40401,_40365,_40435),
    {testmember(_40211,[easy,possible,good])},
    infinitive(_40473,_40435,_40503),
    w(verb(_40243,inf,fin),_40521,_40503,_40555),
    !,
    lock(last,_40555,_40785),
    pushstack(last,(someone,w(verb(_40243,pres,fin)),adverbial1(_40179,_40121,_40187::_40189)),nil,_40785,_40797),
    statement(_40117,_40589,_40797,_40775),
    unlock(_40775,_40299).

whenq(which(_40121):::_40117,[whenq,_40267,_40345,!,_40413],_40239,_40243) --> 
    howlongto(_40155,_40121,_40163::_40165,_40267,_40239,_40309),
    w(verb(_40187,_40189,fin),_40345,_40309,_40379),
    !,
    lock(last,_40379,_40535),
    pushstack(last,(w(verb(_40187,pres,fin)),adverbial1(_40155,_40121,_40163::_40165)),nil,_40535,_40547),
    statement(_40117,_40413,_40547,_40525),
    unlock(_40525,_40243).

whenq(which(_40121):::_40117,[whenq,_40255,!,_40343,_40507,_40565],_40227,_40231) --> 
    when_adverbialq(_40153,_40121,_40161::_40163,_40255,_40227,_40297),
    !,
    pushstack(free,xadverbial1(_40153,_40121,_40161::_40163),nil,_40297,_40457),question0(_40117,_40343,_40457,_40483),
    not_look_ahead([a],_40507,_40483,_40541),
    prep0(_40149,_40565,_40541,_40231).

detnexttime([detnexttime,lit(det),_40201,_40249,!],_40157,_40161) --> 
    cc(det,_40157,_40199),
    nexttime0(_40201,_40199,_40231),
    that0(_40249,_40231,_40161),
    !.

detnexttime([detnexttime,_40169,_40217,!],_40147,_40151) --> 
    nexttime(_40169,_40147,_40199),
    that0(_40217,_40199,_40151),
    !.

detnexttime([detnexttime,lit(at),!],_40145,_40149) --> 
    cc(at,_40145,_40149),
    !.

nexttime0([nexttime0,_40157],_40135,_40139) --> 
    nexttime(_40157,_40135,_40139).

nexttime0([nexttime0,[]],_40135,_40135) --> 
    [].

nexttime([nexttime,_40181,_40239],_40159,_40163) --> 
    w(adj2(next,nil),_40181,_40159,_40215),
    optional([gang],_40239,_40215,_40163).

whencomplex(_40111,_40125::_40127,_40115,_40117,_40131::_40133,_40121,[whencomplex,_40339,_40387,!,_40455,_40503],_40281,_40285) --> 
    do0(_40339,_40281,_40369),
    w(verb(_40197,_40199,finy),_40387,_40369,_40421),
    !,
    accept(_40455,_40421,_40485),
    pushstack(free,(np(_40111,_40125::_40127),w(verb(_40197,pres,fin)),adverbial1(_40115,_40117,_40131::_40133)),nil,_40485,_40697),
    statreal(_40121,_40503,_40697,_40285).

whencomplex(_40111,_40125::_40127,_40115,_40117,_40131::_40133,_40121,[whencomplex,_40303],_40245,_40249) --> 
    pushstack(free,(np(_40111,_40125::_40127),w(verb(be,pres,fin)),adverbial1(_40115,_40117,_40131::_40133)),nil,_40245,_40497),
    statreal(_40121,_40303,_40497,_40249).

verb0(_40111,[verb0,_40195,!,_40263],_40167,_40171) --> 
    w(verb(_40111,_40133,_40135),_40195,_40167,_40229),
    !,
    accept(_40263,_40229,_40171).

verb0(be1,[verb0,[]],_40143,_40143) --> 
    [].

subjectverb(_40111,_40113,_40115,[subjectverb,_40225,_40283,!],_40185,_40189) --> 
    w(verb(_40115,_40137,fin),_40225,_40185,_40259),
    subject(_40111,_40113,_40283,_40259,_40189),
    !.

subjectverb(_40111,_40113,_40115,[subjectverb,_40225,_40273,_40341],_40185,_40189) --> 
    aux1(_40225,_40185,_40255),
    subject(_40111,_40113,_40273,_40255,_40311),
    w(verb(_40115,inf,fin),_40341,_40311,_40189).

whereq(which(_40121):::_40117,[whereq,_40353,_40401,_40479,_40537,_40585,_40643,!,_40721,_40769,!,_40827,[],_40985,!,_41151],_40325,_40329) --> 
    dummyprep0(_40353,_40325,_40383),
    where_adverbial(_40209,_40121,_40213,_40401,_40383,_40443),
    w(verb(_40221,_40223,fin),_40479,_40443,_40513),
    thereit0(_40537,_40513,_40567),
    not_look_ahead(w(nb(_40237,_40239)),_40585,_40567,_40619),
    subject(_40243,_40245,_40643,_40619,_40681),
    !,
    accept(_40721,_40681,_40751),
    dummyprep0(_40769,_40751,_40799),
    !,
    accept(_40827,_40799,_40857),
    pushstack(free,adverbial1(_40209,_40121,_40213),nil,_40857,_40983),[],
    pushstack(first,(xnp(_40243,_40245),w(verb(_40221,_40223,fin))),nil,_40983,_41091),substatement1(_40117,_40985,_41091,_41117),
    !,
    accept(_41151,_41117,_40329).

whereq(which(_40121):::_40117,[whereq,{},_40345,_40393,!,_40461,!,_40593,_40737],_40303,_40307) --> 
    {\+user:value(dialog,1)},
    where(_40345,_40303,_40375),
    w(verb(go,_40193,fin),_40393,_40375,_40427),
    !,
    lock(exact,_40427,_40501),pushstack(exact,w(noun(place,sin,u,n)),nil,_40501,_40513),adverbial1(nil,_40121,_40227::_40229,_40461,_40513,_40491),unlock(_40491,_40493),
    !,
    pushstack(free,(w(verb(go,pres,fin)),adverbial1(nil,_40121,_40227::_40229)),nil,_40493,_40687),ynq(_40117,_40593,_40687,_40713),
    dummyprep0(_40737,_40713,_40307).

whereq(which(_40121):::_40117,[whereq,_40331,_40379,_40437,!,_40525,!,_40735],_40303,_40307) --> 
    where(_40331,_40303,_40361),
    not_look_ahead(w(prep(after)),_40379,_40361,_40413),
    adverbial1(_40173,_40175,_40181::_40183,_40437,_40413,_40479),
    !,
    lock(exact,_40479,_40643),pushstack(exact,(prep(in),w(noun(place,sin,u,n))),nil,_40643,_40655),adverbial1(_40239,_40121,_40247::_40249,_40525,_40655,_40633),unlock(_40633,_40635),
    !,
    pushstack(free,(adverbial1(in,_40121,_40247::_40249),adverbial1(_40173,_40175,_40181::_40183)),nil,_40635,_40931),
    question0(_40117,_40735,_40931,_40307).

whereq(which(_40121):::_40117,[whereq,_40301,_40379,lit(det),_40449,!,[],_40633],_40273,_40277) --> 
    where_adverbial(_40189,_40121,_40197::_40199,_40301,_40273,_40343),
    be(_40379,_40343,_40409),
    cc(det,_40409,_40447),
    w(adj2(_40183,_40185),_40449,_40447,_40483),
    !,
    pushstack(free,adverbial1(_40189,_40121,_40197::_40199),nil,_40483,_40631),[],
    pushstack(first,([det],be,w(adj2(_40183,_40185))),nil,_40631,_40727),
    substatement1(_40117,_40633,_40727,_40277).

whereq(which(_40121):::_40117,[whereq,_40253,_40331,lit(det),_40401,!,_40459],_40225,_40229) --> 
    where_adverbial(_40161,_40121,_40169::_40171,_40253,_40225,_40295),
    be(_40331,_40295,_40361),
    cc(det,_40361,_40399),
    that0(_40401,_40399,_40431),
    !,
    pushstack(free,adverbial1(_40161,_40121,_40169::_40171),nil,_40431,_40567),
    statreal(_40117,_40459,_40567,_40229).

whereq(_40111,[whereq,_40241,_40289,_40337],_40213,_40217) --> 
    where(_40241,_40213,_40271),
    be(_40289,_40271,_40319),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),w(verb(be1,pres,fin))),nil,_40319,_40509),
    ppq(_40111,_40337,_40509,_40217).

whereq(which(_40121):::_40117,[whereq,_40199,_40247,!,_40305],_40171,_40175) --> 
    where(_40199,_40171,_40229),
    many1(_40247,_40229,_40277),
    !,
    reject(_40305,_40277,_40175).

whereq(_40111,[whereq,_40229,_40277,_40325],_40201,_40205) --> 
    where(_40229,_40201,_40259),
    aux1(_40277,_40259,_40307),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),do),nil,_40307,_40571),
    ppq(_40111,_40325,_40571,_40205).

whereq(_40111,[whereq,_40213,_40261,_40309],_40185,_40189) --> 
    where(_40213,_40185,_40243),
    look_ahead_vp(_40261,_40243,_40291),
    pushstack(first,(which,w(noun(place,sin,u,n))),nil,_40291,_40403),
    whichq(_40111,_40309,_40403,_40189).

when_adverbial(in,_40113,_40119::_40121,[when_adverbial,_40241,_40289,!,{}],_40201,_40205) --> 
    which(_40241,_40201,_40271),
    np1(_40113,_40119::_40121,_40289,_40271,_40205),
    !,
    {testconstraint(_40113,time)}.

when_adverbialq(in,_40131:time,_40119::_40131 isa time and _40119,[when_adverbialq,_40219],_40179,_40183) --> 
    when(_40219,_40179,_40183).

when_adverbial(in,_40131:time,_40119::_40131 isa time and _40119,[when_adverbial,_40219],_40179,_40183) --> 
    whenx(_40219,_40179,_40183).

where_adverbial(nil,_40113,_40115,[where_adverbial,_40229,_40277,!,{}],_40189,_40193) --> 
    which(_40229,_40189,_40259),
    np1(_40113,_40115,_40277,_40259,_40193),
    !,
    {testconstraint(_40113,place)}.

where_adverbial(nil,_40113,_40115,[where_adverbial,lit(hvor),_40241,!],_40179,_40183) --> 
    cc(hvor,_40179,_40239),
    np00(place,_40113,_40115,_40241,_40239,_40183),
    !.

dummyprep0([dummyprep0,_40163,!],_40141,_40145) --> 
    dummyprep(_40163,_40141,_40145),
    !.

dummyprep0([dummyprep0,[]],_40135,_40135) --> 
    [].

dummyprep([dummyprep,_40173,!,_40241],_40151,_40155) --> 
    prep1(from,_40173,_40151,_40207),
    !,
    accept(_40241,_40207,_40155).

dummyprep([dummyprep,_40173,!,_40241],_40151,_40155) --> 
    prep1(to,_40173,_40151,_40207),
    !,
    accept(_40241,_40207,_40155).

wherefromq(_40111,[wherefromq,_40223,!,_40281],_40195,_40199) --> 
    wherefrom(_40223,_40195,_40253),
    !,
    pushstack(first,(prep(from),which,w(noun(place,sin,u,n))),nil,_40253,_40443),
    ppq(_40111,_40281,_40443,_40199).

whoq(_40111,[whoq,_40273,_40321,_40379,!,_40447],_40245,_40249) --> 
    who(_40273,_40245,_40303),
    look_ahead(w(noun(_40177,sin,def,n)),_40321,_40303,_40355),
    w(verb(_40161,_40163,fin),_40379,_40355,_40413),
    !,
    pushstack(first,(which,w(noun(agent,sin,u,n)),w(verb(_40161,_40163,fin))),nil,_40413,_40541),
    whichq(_40111,_40447,_40541,_40249).

whoq(_40111,[whoq,_40207,_40255],_40179,_40183) --> 
    who(_40207,_40179,_40237),
    pushstack(first,(which,w(noun(agent,sin,u,n))),nil,_40237,_40349),
    whichq(_40111,_40255,_40349,_40183).

whoseq(_40111,[whoseq,_40257,_40305,_40413],_40229,_40233) --> 
    whose(_40257,_40229,_40287),
    noun(_40157,_40159,u,n,_40165,_40167,_40305,_40287,_40359),
    pushstack(first,(who,w(verb(have,pres,fin)),a,noun(_40157,_40159,u,n,_40165,_40167),that),nil,_40359,_40717),
    whoq(_40111,_40413,_40717,_40233).

whyq(explain:::_40117,[whyq,_40187,_40235],_40159,_40163) --> 
    hvorfor(_40187,_40159,_40217),
    isq(_40117,_40235,_40217,_40163).

whyq(explain:::_40117,[whyq,_40187,_40235],_40159,_40163) --> 
    hvorfor(_40187,_40159,_40217),
    ynq(_40117,_40235,_40217,_40163).

whyq(explain:::_40117,[whyq,_40187,_40235],_40159,_40163) --> 
    hvorfor(_40187,_40159,_40217),
    hasq(_40117,_40235,_40217,_40163).

howq(doit:::reply('OK'),[howq,lit(hvordan),_40247,lit(det),!,_40337],_40197,_40201) --> 
    cc(hvordan,_40197,_40245),
    w(verb(go,_40159,fin),_40247,_40245,_40281),
    cc(det,_40281,_40325),
    !,
    skip_rest(_40337,_40325,_40201).

howq(explain:::_40117,[howq,lit(hvordan),_40277,_40325,_40383,!,_40441],_40227,_40231) --> 
    cc(hvordan,_40227,_40275),
    erdetaa0(_40277,_40275,_40307),
    w(verb(_40167,inf,fin),_40325,_40307,_40359),
    mex0(_40383,_40359,_40413),
    !,
    pushstack(first,([jeg],w(verb(_40167,pres,fin))),nil,_40413,_40461),
    statreal1(_40117,_40441,_40461,_40231).

howq(explain:::_40117,[howq,lit(hvorfor),_40265,!,_40333],_40215,_40219) --> 
    cc(hvorfor,_40215,_40263),
    w(verb(_40155,inf,fin),_40265,_40263,_40299),
    !,
    pushstack(first,([jeg],w(verb(_40155,pres,fin))),nil,_40299,_40353),
    statreal1(_40117,_40333,_40353,_40219).

howq(explain:::_40117,[howq,lit(hvordan),_40261,[],_40415],_40211,_40215) --> 
    cc(hvordan,_40211,_40259),
    look_ahead(w(verb(be,_40157,fin)),_40261,_40259,_40295),
    pushstack(free,xadverbial1(how,nil,_40177::_40177),nil,_40295,_40413),[],
    isq(_40117,_40415,_40413,_40215).

howq(explain:::_40117,[howq,_40235,_40283,_40331,_40399],_40207,_40211) --> 
    how(_40235,_40207,_40265),
    be(_40283,_40265,_40313),
    np1_accept(_40163,_40165,_40331,_40313,_40369),
    pushstack(first,(xnp(_40163,_40165),w(verb(be,pres,fin))),nil,_40369,_40499),
    substatement1(_40117,_40399,_40499,_40211).

howq(explain:::_40117,[howq,_40247,_40295,lit(det),_40365,!,_40433],_40219,_40223) --> 
    how(_40247,_40219,_40277),
    be(_40295,_40277,_40325),
    cc(det,_40325,_40363),
    negation0(_40179,_40365,_40363,_40399),
    !,
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_40399,_40453),
    substatement1(_40117,_40433,_40453,_40223).

howq(explain:::_40117,[howq,_40215,_40303,_40351,!,_40409],_40187,_40191) --> 
    lexv(iv,tell,imp,fin,_40215,_40187,_40261),
    me0(_40303,_40261,_40333),
    how(_40351,_40333,_40381),
    !,
    statreal1(_40117,_40409,_40381,_40191).

howq(_40111,[howq,_40205,_40253,_40301,!,_40359],_40177,_40181) --> 
    how(_40205,_40177,_40235),
    be(_40253,_40235,_40283),
    thereit(_40301,_40283,_40331),
    !,
    pushstack(first,whatbe,nil,_40331,_40453),
    whatq(_40111,_40359,_40453,_40181).

howq(_40111,[howq,_40219,_40267,lit(det),_40337,!,_40405],_40191,_40195) --> 
    how(_40219,_40191,_40249),
    be(_40267,_40249,_40297),
    cc(det,_40297,_40335),
    prep1(with,_40337,_40335,_40371),
    !,
    pushstack(first,whatbe,nil,_40371,_40499),
    whatq(_40111,_40405,_40499,_40195).

howq(explain:::_40117,[howq,_40187,_40235],_40159,_40163) --> 
    how(_40187,_40159,_40217),
    ynq(_40117,_40235,_40217,_40163).

howq(explain:::_40117,[howq,_40187,_40235],_40159,_40163) --> 
    how(_40187,_40159,_40217),
    hasq(_40117,_40235,_40217,_40163).

erdetaa0([erdetaa0,_40189,lit(det),lit(å),!,_40291],_40167,_40171) --> 
    be(_40189,_40167,_40219),
    cc(det,_40219,_40257),
    cc(å,_40257,_40279),
    !,
    accept(_40291,_40279,_40171).

erdetaa0([erdetaa0,[]],_40135,_40135) --> 
    [].

howlongto(_40111,_40113,_40119::_40121,[howlongto,_40261,lit(det),lit(lenge),_40353,_40411],_40221,_40225) --> 
    be(_40261,_40221,_40291),
    cc(det,_40291,_40329),
    cc(lenge,_40329,_40351),
    prep1(to,_40353,_40351,_40387),
    lock(exact,_40387,_40445),
    pushstack(exact,[når],nil,_40445,_40457),
    when_adverbial(_40111,_40113,_40119::_40121,_40411,_40457,_40435),
    unlock(_40435,_40225).

howlongto(_40111,_40113,_40119::_40121,[howlongto,lit(hvor),lit(lenge),_40315,lit(det),_40385,_40443],_40231,_40235) --> 
    cc(hvor,_40231,_40291),
    cc(lenge,_40291,_40313),
    be(_40315,_40313,_40345),
    cc(det,_40345,_40383),
    prep1(to,_40385,_40383,_40419),
    lock(exact,_40419,_40477),
    pushstack(exact,[når],nil,_40477,_40489),
    when_adverbial(_40111,_40113,_40119::_40121,_40443,_40489,_40467),
    unlock(_40467,_40235).

howlongto(_40111,_40113,_40119::_40121,[howlongto,_40233,_40311,_40359,_40407],_40193,_40197) --> 
    when_adverbial(_40111,_40113,_40119::_40121,_40233,_40193,_40275),
    be(_40311,_40275,_40341),
    thereit(_40359,_40341,_40389),
    that0(_40407,_40389,_40197).

howadjq(_40111,[howadjq,_40357,_40405,{},_40477,{},lit(det),_40571,_40629,_40677,_40735,!,_40895],_40329,_40333) --> 
    hvor(_40357,_40329,_40387),
    howadj1(_40181,_40405,_40387,_40439),
    {testmember(_40181,[duration])},
    w(verb(_40203,_40205,fin),_40477,_40439,_40511),
    {testmember(_40203,[take,be])},
    cc(det,_40511,_40569),
    not_look_ahead([å],_40571,_40569,_40605),
    redundant0(_40629,_40605,_40659),
    not_look_ahead(w(prep(with)),_40677,_40659,_40711),
    pushstack(first,(which,w(noun(_40181,sin,u,n)),w(verb(_40203,_40205,fin))),nil,_40711,_40835),whichq(_40111,_40735,_40835,_40861),
    !,
    accept(_40895,_40861,_40333).

howadjq(_40111,[howadjq,_40285,_40333,_40391,{},!,_40463],_40257,_40261) --> 
    hvor(_40285,_40257,_40315),
    howadj1(_40169,_40333,_40315,_40367),
    docan(_40391,_40367,_40421),
    {testmember(_40169,[frequency,speed,lateness,earliness,duration,distance])},
    !,
    pushstack(first,(prep(with),which,w(noun(_40169,sin,u,n)),do),nil,_40421,_40699),
    ppq(_40111,_40463,_40699,_40261).

howadjq(_40111,[howadjq,_40317,_40365,{},_40437,{},!,_40519],_40289,_40293) --> 
    hvor(_40317,_40289,_40347),
    howadj1(_40187,_40365,_40347,_40399),
    {testmember(_40187,[frequency,earliness,lateness])},
    w(verb(_40179,_40219,_40183),_40437,_40399,_40471),
    {\+_40179=be},
    !,
    pushstack(first,(prep(with),which,w(noun(_40187,sin,u,n)),w(verb(_40179,pres,_40183))),nil,_40471,_40691),
    ppq(_40111,_40519,_40691,_40293).

howadjq(_40111,[howadjq,_40257,_40305,_40363,_40431,_40479],_40229,_40233) --> 
    hvor(_40257,_40229,_40287),
    howadj1(_40169,_40305,_40287,_40339),
    gmem(_40169,[distance],_40363,_40339,_40401),
    be(_40431,_40401,_40461),
    pushstack(first,(which,w(noun(_40169,sin,u,n)),w(verb(have,pres,fin))),nil,_40461,_40573),
    whichq(_40111,_40479,_40573,_40233).

howadjq(which(_40131:time):::_40131 isa time and _40123,[howadjq,_40339,_40387,_40445,lit(det),lit(til),_40547,!,_40625,_40703],_40311,_40315) --> 
    hvor(_40339,_40311,_40369),
    howadj1(duration,_40387,_40369,_40421),
    w(verb(be,_40227,fin),_40445,_40421,_40479),
    cc(det,_40479,_40523),
    cc(til,_40523,_40545),
    clausal_object0(_40241,_40243,_40547,_40545,_40585),
    !,
    np00(time,_40131:time,_40213,_40625,_40585,_40667),
    pushstack(first,(xnp(_40241,_40243),w(verb(exist,_40227,fin)),xadverbial1(nil,_40131,_40213)),nil,_40667,_40871),
    statreal(_40123,_40703,_40871,_40315).

howadjq(_40111,[howadjq,_40333,_40421,_40469,_40527,_40585,_40653,!,_40721,_40799],_40305,_40309) --> 
    whichg00(duration,_40197,_40189,_40111,_40333,_40305,_40379),
    hvor(_40421,_40379,_40451),
    howadj1(duration,_40469,_40451,_40503),
    w(verb(be,_40215,fin),_40527,_40503,_40561),
    np1_accept(_40221,_40223,_40585,_40561,_40623),
    w(adj2(_40231,nil),_40653,_40623,_40687),
    !,
    np00(duration,_40189,_40191,_40721,_40687,_40763),
    pushstack(first,(xnp(_40221,_40223),w(verb(be,_40215,fin)),w(adj2(_40231,nil)),xadverbial1(nil,_40189,_40191)),nil,_40763,_40981),
    statreal(_40197,_40799,_40981,_40309).

howadjq(_40111,[howadjq,_40319,_40407,_40455,_40513,_40571,_40639,!,_40707,_40785],_40291,_40295) --> 
    whichg00(duration,_40191,_40183,_40111,_40319,_40291,_40365),
    hvor(_40407,_40365,_40437),
    howadj1(duration,_40455,_40437,_40489),
    w(verb(have,_40209,fin),_40513,_40489,_40547),
    subject(_40215,_40217,_40571,_40547,_40609),
    w(verb(_40225,past,part),_40639,_40609,_40673),
    !,
    np00(duration,_40183,_40185,_40707,_40673,_40749),
    pushstack(first,(xnp(_40215,_40217),w(verb(_40225,past,fin)),xadverbial1(nil,_40183,_40185)),nil,_40749,_40967),
    statreal(_40191,_40785,_40967,_40295).

howadjq(which(_40127):::_40127 isa _40133 and _40123,[howadjq,_40353,_40401,_40459,_40517,_40585,!,{},_40677,_40755],_40325,_40329) --> 
    hvor(_40353,_40325,_40383),
    howadj1(_40133,_40401,_40383,_40435),
    w(verb(have,_40227,fin),_40459,_40435,_40493),
    subject(_40233,_40235,_40517,_40493,_40555),
    object(_40239,_40241,_40585,_40555,_40623),
    !,
    {_40211=(_40127:_40133)},
    np00(_40133,_40211,_40213,_40677,_40623,_40719),
    pushstack(first,(xnp(_40233,_40235),w(verb(have,_40227,fin)),xnp(_40239,_40241),xadverbial1(nil,_40211,_40213)),nil,_40719,_41017),
    statreal(_40123,_40755,_41017,_40329).

howadjq(which(_40127):::_40127 isa _40133 and _40123,[howadjq,_40369,_40417,_40475,{},_40547,_40605,!,{},_40697,_40775],_40341,_40345) --> 
    hvor(_40369,_40341,_40399),
    howadj1(duration,_40417,_40399,_40451),
    w(verb(_40223,_40225,fin),_40475,_40451,_40509),
    {\+testmember(_40223,[expect,be])},
    not_look_ahead([det],_40547,_40509,_40581),
    np1(_40261,_40263,_40605,_40581,_40643),
    !,
    {_40209=(_40127:duration)},
    np00(_40133,_40209,_40211,_40697,_40643,_40739),
    pushstack(first,(xnp(_40261,_40263),w(verb(_40223,_40225,fin)),xnp(_40209,_40211)),nil,_40739,_40955),
    statreal(_40123,_40775,_40955,_40345).

howadjq(_40111,[howadjq,lit(hvor),lit(lenge),_40339,lit(det),_40419,!,_40487,_40555],_40267,_40271) --> 
    cc(hvor,_40267,_40315),
    cc(lenge,_40315,_40337),
    w(verb(be,pres,fin),_40339,_40337,_40373),
    cc(det,_40373,_40417),
    w(prep(to),_40419,_40417,_40453),
    !,
    clausal_object0(_40175,_40177,_40487,_40453,_40525),
    pushstack(first,([når],w(verb(be,pres,fin)),xnp(_40175,_40177)),nil,_40525,_40655),
    whenq(_40111,_40555,_40655,_40271).

howadjq(_40111,[howadjq,lit(hvor),lit(mange),_40355,_40413,lit(det),_40493,!,_40561],_40283,_40287) --> 
    cc(hvor,_40283,_40331),
    cc(mange,_40331,_40353),
    w(noun(minute,plu,u,n),_40355,_40353,_40389),
    w(verb(be,pres,fin),_40413,_40389,_40447),
    cc(det,_40447,_40491),
    w(prep(to),_40493,_40491,_40527),
    !,
    pushstack(free,([når],w(verb(be,pres,fin)),[det],[at]),nil,_40527,_40581),
    whenq(_40111,_40561,_40581,_40287).

howadjq(_40111,[howadjq,_40303,_40351,lit(blir),_40431,_40499,!,_40567],_40275,_40279) --> 
    hvor(_40303,_40275,_40333),
    howadj1(_40187,_40351,_40333,_40385),
    cc(blir,_40385,_40429),
    np1(_40181,_40183,_40431,_40429,_40469),
    w(verb(_40205,past,part),_40499,_40469,_40533),
    !,
    pushstack(first,(prep(with),which,w(noun(_40187,sin,u,n)),w(verb(_40205,pres,pass)),xnp(_40181,_40183)),nil,_40533,_40819),
    ppq(_40111,_40567,_40819,_40279).

howadjq(_40111,[howadjq,_40355,_40403,{},_40475,_40523,_40591,{},_40663,_40741],_40327,_40331) --> 
    hvor(_40355,_40327,_40385),
    howadj1(_40199,_40403,_40385,_40437),
    {testmember(_40199,[frequency])},
    be(_40475,_40437,_40505),
    subject(_40217,_40219,_40523,_40505,_40561),
    w(adj2(_40227,nil),_40591,_40561,_40625),
    {testmember(_40227,[delayed,tooearly])},
    np00(frequency,_40193,_40195,_40663,_40625,_40705),
    pushstack(first,(xnp(_40217,_40219),w(verb(be,pres,fin)),w(adj2(_40227,nil)),w(prep(with)),xnp(_40193,_40195)),nil,_40705,_40921),
    statreal1(_40111,_40741,_40921,_40331).

howadjq(_40111,[howadjq,_40273,_40321,{},_40393,_40441],_40245,_40249) --> 
    hvor(_40273,_40245,_40303),
    howadj1(_40169,_40321,_40303,_40355),
    {\+testmember(_40169,[duration,distance,time])},
    be(_40393,_40355,_40423),
    pushstack(first,(which,w(noun(_40169,sin,u,n)),w(verb(have,pres,fin))),nil,_40423,_40535),
    whichq(_40111,_40441,_40535,_40249).

howadjq(_40111,[howadjq,_40319,_40367,_40425,_40473,_40541,{},_40613,!,_40853],_40291,_40295) --> 
    hvor(_40319,_40291,_40349),
    howadj1(_40163,_40367,_40349,_40401),
    do(_40425,_40401,_40455),
    np(_40167,_40169,_40473,_40455,_40511),
    w(verb(_40177,_40179,_40181),_40541,_40511,_40575),
    {testmember(_40177,[use,take])},
    pushstack(first,(which,w(noun(_40163,sin,u,n)),w(verb(_40177,inf,fin)),xnp(_40167,_40169)),nil,_40575,_40793),whichq(_40111,_40613,_40793,_40819),
    !,
    accept(_40853,_40819,_40295).

howadjq(which(_40121):::_40117,[howadjq,_40375,_40423,{},_40495,{},_40567,!,_40645,!,_40883],_40347,_40351) --> 
    hvor(_40375,_40347,_40405),
    howadj1(_40179,_40423,_40405,_40457),
    {testmember(_40179,[speed,distance])},
    w(verb(_40205,pres,fin),_40495,_40457,_40529),
    {\+testmember(_40205,[know,be])},
    np1(_40235,_40237,_40567,_40529,_40605),
    !,
    pushstack(first,(xnp(_40235,_40237),w(verb(_40205,pres,fin)),w(prep(with)),the(_40121),w(noun(_40179,sin,u,n))),nil,_40605,_40823),statreal(_40117,_40645,_40823,_40849),
    !,
    accept(_40883,_40849,_40351).

howadjq(_40111,[howadjq,_40275,lit(lenge),_40345,_40393,!,_40461],_40247,_40251) --> 
    hvor(_40275,_40247,_40305),
    cc(lenge,_40305,_40343),
    be(_40345,_40343,_40375),
    not_look_ahead([det],_40393,_40375,_40427),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),w(verb(be,pres,fin))),nil,_40427,_40555),
    ppq(_40111,_40461,_40555,_40251).

howadjq(_40111,[howadjq,_40347,_40395,{},_40467,{},lit(det),_40561,_40609,!,_40677,_40725,!,_40885],_40319,_40323) --> 
    hvor(_40347,_40319,_40377),
    howadj1(_40187,_40395,_40377,_40429),
    {testmember(_40187,[duration])},
    w(verb(_40209,pres,fin),_40467,_40429,_40501),
    {testmember(_40209,[take,be])},
    cc(det,_40501,_40559),
    redundant0(_40561,_40559,_40591),
    prep(with,_40609,_40591,_40643),
    !,
    accept(_40677,_40643,_40707),
    pushstack(first,(which,w(noun(_40187,sin,u,n)),w(verb(_40209,pres,fin))),nil,_40707,_40825),whichq(_40111,_40725,_40825,_40851),
    !,
    accept(_40885,_40851,_40323).

howadjq(_40111,[howadjq,_40385,_40433,{},_40505,{},lit(det),_40599,_40657,_40705,!,_40773,_40821,!,_40981],_40357,_40361) --> 
    hvor(_40385,_40357,_40415),
    howadj1(_40193,_40433,_40415,_40467),
    {testmember(_40193,[duration])},
    w(verb(_40215,pres,fin),_40505,_40467,_40539),
    {testmember(_40215,[take])},
    cc(det,_40539,_40597),
    not_look_ahead([å],_40599,_40597,_40633),
    redundant0(_40657,_40633,_40687),
    look_ahead(w(prep(_40257)),_40705,_40687,_40739),
    !,
    accept(_40773,_40739,_40803),
    pushstack(first,(which,w(noun(_40193,sin,u,n)),w(verb(_40215,pres,fin)),w(noun(vehicle,sin,def,n))),nil,_40803,_40921),whichq(_40111,_40821,_40921,_40947),
    !,
    accept(_40981,_40947,_40361).

howadjq(_40111,[howadjq,_40339,_40387,{},_40459,lit(det),_40539,{},_40611,_40659,!,_40819],_40311,_40315) --> 
    hvor(_40339,_40311,_40369),
    howadj1(_40175,_40387,_40369,_40421),
    {testmember(_40175,[duration])},
    w(verb(_40197,pres,fin),_40459,_40421,_40493),
    cc(det,_40493,_40537),
    not_look_ahead([å],_40539,_40537,_40573),
    {testmember(_40197,[take,be])},
    redundant0(_40611,_40573,_40641),
    pushstack(first,(which,w(noun(_40175,sin,u,n)),w(verb(exist,pres,fin))),nil,_40641,_40759),whichq(_40111,_40659,_40759,_40785),
    !,
    accept(_40819,_40785,_40315).

howadjq(_40111,[howadjq,_40217,_40265,_40323],_40189,_40193) --> 
    ihvor(_40217,_40189,_40247),
    howadj1(_40143,_40265,_40247,_40299),
    pushstack(first,(which,w(noun(_40143,sin,u,n))),nil,_40299,_40417),
    whichq(_40111,_40323,_40417,_40193).

howadjq(_40111,[howadjq,_40249,lit(lenge),_40319,!,_40377],_40221,_40225) --> 
    hvor(_40249,_40221,_40279),
    cc(lenge,_40279,_40317),
    be(_40319,_40317,_40349),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),be),nil,_40349,_40545),
    ppq(_40111,_40377,_40545,_40225).

howadjq(_40111,[howadjq,_40255,_40303,_40351,_40399,_40457],_40227,_40231) --> 
    hvor(_40255,_40227,_40285),
    meny(_40303,_40285,_40333),
    be(_40351,_40333,_40381),
    w(noun(clock,_40183,_40185,_40187),_40399,_40381,_40433),
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_40433,_40625),
    whatq(_40111,_40457,_40625,_40231).

howadjq(_40111,[howadjq,_40285,lit(lenge),_40355,{},!,_40437],_40257,_40261) --> 
    hvor(_40285,_40257,_40315),
    cc(lenge,_40315,_40353),
    w(verb(_40173,pres,fin),_40355,_40353,_40389),
    {_40173\==take},
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(_40173,pres,fin))),nil,_40389,_40609),
    ppq(_40111,_40437,_40609,_40261).

howadjq(_40111,[howadjq,_40269,_40317,_40375,!,_40443],_40241,_40245) --> 
    hvor(_40269,_40241,_40299),
    howadj1(duration,_40317,_40299,_40351),
    w(verb(use,pres,fin),_40375,_40351,_40409),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_40409,_40615),
    ppq(_40111,_40443,_40615,_40245).

howadjq(_40111,[howadjq,_40251,_40299,_40357,_40405,!,_40717],_40223,_40227) --> 
    hvor(_40251,_40223,_40281),
    howadj1(_40145,_40299,_40281,_40333),
    do(_40357,_40333,_40387),
    pushstack(first,(prep(with),which,w(noun(_40145,sin,u,n)),do),nil,_40387,_40657),ppq(_40111,_40405,_40657,_40683),
    !,
    accept(_40717,_40683,_40227).

howadjq(_40111,[howadjq,_40251,_40299,_40357,_40405,_40453],_40223,_40227) --> 
    hvor(_40251,_40223,_40281),
    howadj1(duration,_40299,_40281,_40333),
    betake(_40357,_40333,_40387),
    thereit(_40405,_40387,_40435),
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(duration,sin,def,n))),nil,_40435,_40473),
    whatq(_40111,_40453,_40473,_40227).

howadjq(_40111,[howadjq,_40283,_40331,_40389,_40447,!,_40515],_40255,_40259) --> 
    hvor(_40283,_40255,_40313),
    howadj1(duration,_40331,_40313,_40365),
    w(verb(take,pres,fin),_40389,_40365,_40423),
    not_look_ahead([det],_40447,_40423,_40481),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_40481,_40687),
    ppq(_40111,_40515,_40687,_40259).

howmuchq(which(_40121):::_40117,[howmuchq,_40299,lit(lenge),_40369,lit(det),!,_40459],_40271,_40275) --> 
    hvor(_40299,_40271,_40329),
    cc(lenge,_40329,_40367),
    w(verb(be,_40193,fin),_40369,_40367,_40403),
    cc(det,_40403,_40447),
    !,
    pushstack(first,(which,w(noun(duration,plu,u,n)),w(verb(be,_40193,fin)),[det]),nil,_40447,_40553),
    whichq(which(_40121):::_40117,_40459,_40553,_40275).

howmuchq(which(_40121):::_40117,[howmuchq,_40333,_40381,_40429,{},lit(det),lit(å),_40545,!,_40641],_40305,_40309) --> 
    hvor(_40333,_40305,_40363),
    much(_40381,_40363,_40411),
    w(verb(_40199,_40201,fin),_40429,_40411,_40463),
    {testmember(_40199,[cost])},
    cc(det,_40463,_40521),
    cc(å,_40521,_40543),
    pushstack(first,([noen],[vil]),nil,_40543,_40571),clausal_object1(_40245,_40247,_40545,_40571,_40601),
    !,
    pushstack(first,(xnp(_40245,_40247),w(verb(_40199,pres,fin)),npgap(_40121)),nil,_40601,_40819),
    statreal1(_40117,_40641,_40819,_40309).

howmuchq(test:::_40117,[howmuchq,_40299,_40347,_40395,_40453,_40521,!,_40589,_40637],_40271,_40275) --> 
    hvor(_40299,_40271,_40329),
    much(_40347,_40329,_40377),
    w(verb(be,_40197,fin),_40395,_40377,_40429),
    np0_accept(_40203,_40205,_40453,_40429,_40491),
    w(adj2(_40185,nil),_40521,_40491,_40555),
    !,
    accept(_40589,_40555,_40619),
    pushstack(first,(xnp(_40203,_40205),w(verb(be,pres,fin)),w(adj2(_40185,nil))),nil,_40619,_40737),
    statemen1(real,_40117,_40637,_40737,_40275).

howmuchq(_40111,[howmuchq,_40225,_40273,_40321,!,_40389],_40197,_40201) --> 
    hvor(_40225,_40197,_40255),
    many1(_40273,_40255,_40303),
    look_ahead(w(verb(be,_40159,fin)),_40321,_40303,_40355),
    !,
    pushstack(first,[hva],nil,_40355,_40409),
    whatq(_40111,_40389,_40409,_40201).

howmuchq(howmany(_40121):::_40117,[howmuchq,_40213,_40261,_40309],_40185,_40189) --> 
    hvor(_40213,_40185,_40243),
    many1(_40261,_40243,_40291),
    pushstack(first,which,nil,_40291,_40403),
    whichq(which(_40121):::_40117,_40309,_40403,_40189).

howmuchq(howmany(_40121):::_40117,[howmuchq,_40233,_40281,_40329],_40205,_40209) --> 
    hvor(_40233,_40205,_40263),
    manypersons(_40281,_40263,_40311),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_40311,_40423),
    whichq(which(_40121):::_40117,_40329,_40423,_40209).

howmuchq(howmany(_40121):::_40117,[howmuchq,_40253,lit(det),_40323,lit(som),_40393],_40225,_40229) --> 
    be(_40253,_40225,_40283),
    cc(det,_40283,_40321),
    manypersons(_40323,_40321,_40353),
    cc(som,_40353,_40391),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_40391,_40487),
    whichq(which(_40121):::_40117,_40393,_40487,_40229).

howmuchq(which(_40121):::_40117,[howmuchq,_40243,_40291,_40339,{},_40411],_40215,_40219) --> 
    hvor(_40243,_40215,_40273),
    much(_40291,_40273,_40321),
    w(verb(_40149,_40163,fin),_40339,_40321,_40373),
    {testmember(_40149,[earn,cost])},
    whattrans(_40149,_40121,_40117,_40411,_40373,_40219).

howmuchq(_40111,[howmuchq,_40211,_40259,_40307,!,_40365],_40183,_40187) --> 
    hvor(_40211,_40183,_40241),
    much(_40259,_40241,_40289),
    of(_40307,_40289,_40337),
    !,
    pushstack(first,(which,of),nil,_40337,_40531),
    whichq(_40111,_40365,_40531,_40187).

howmuchq(_40111,[howmuchq,_40245,_40293,_40341,_40399,!,_40559],_40217,_40221) --> 
    hvor(_40245,_40217,_40275),
    much(_40293,_40275,_40323),
    w(noun(_40149,_40151,u,n),_40341,_40323,_40375),
    pushstack(first,(which,w(noun(_40149,sin,u,n))),nil,_40375,_40499),whichq(_40111,_40399,_40499,_40525),
    !,
    accept(_40559,_40525,_40221).

howmuchq(_40111,[howmuchq,_40197,_40245,_40293],_40169,_40173) --> 
    hvor(_40197,_40169,_40227),
    much(_40245,_40227,_40275),
    pushstack(first,[hva],nil,_40275,_40313),
    question(_40111,_40293,_40313,_40173).

whattrans(_40111,_40113,_40115,[whattrans,_40283,_40341,!,_40419],_40243,_40247) --> 
    not_look_ahead([det],_40283,_40243,_40317),
    noun_phrase1(_40167,_40173::_40175,_40341,_40317,_40379),
    !,
    pushstack(first,(noun_phrase1(_40167,_40173::_40175),w(verb(_40111,pres,fin)),npgap(_40113)),nil,_40379,_40603),
    statreal1(_40115,_40419,_40603,_40247).

howadj1(_40111,[howadj1,_40181,!],_40153,_40157) --> 
    howadj(_40111,_40181,_40153,_40157),
    !.

howadj(duration,[howadj,lit(langt)],_40147,_40151) --> 
    cc(langt,_40147,_40151).

howadj(age,[howadj,_40181],_40153,_40157) --> 
    w(adj2(old,nil),_40181,_40153,_40157).

howadj(age,[howadj,lit(mange),_40217],_40167,_40171) --> 
    cc(mange,_40167,_40215),
    w(noun(year,plu,u,n),_40217,_40215,_40171).

howadj(delay,[howadj,_40181],_40153,_40157) --> 
    w(adj2(slow,nil),_40181,_40153,_40157).

howadj(delay,[howadj,_40191,_40279],_40163,_40167) --> 
    optional(much,_40191,_40163,_40255),
    w(adj2(delayed,nil),_40279,_40255,_40167).

howadj(delay,[howadj,_40181],_40153,_40157) --> 
    w(adj2(punctual,nil),_40181,_40153,_40157).

howadj(earliness,[howadj,_40181],_40153,_40157) --> 
    w(adj2(early,nil),_40181,_40153,_40157).

howadj(lateness,[howadj,_40181],_40153,_40157) --> 
    w(adj2(late,nil),_40181,_40153,_40157).

howadj(lateness,[howadj,lit(sent)],_40147,_40151) --> 
    cc(sent,_40147,_40151).

howadj(distance,[howadj,lit(langt)],_40147,_40151) --> 
    cc(langt,_40147,_40151).

howadj(distance,[howadj,_40223,_40271,{}],_40195,_40199) --> 
    many(_40223,_40195,_40253),
    w(noun(_40131,_40159,u,n),_40271,_40253,_40199),
    {testmember(_40131,[mil,mile,kilometer,meter])}.

howadj(duration,[howadj,lit(mange),_40217],_40167,_40171) --> 
    cc(mange,_40167,_40215),
    w(noun(minute,_40127,_40129,n),_40217,_40215,_40171).

howadj(duration,[howadj,lit(lenge)],_40147,_40151) --> 
    cc(lenge,_40147,_40151).

howadj(duration,[howadj,_40197,_40245,!],_40169,_40173) --> 
    long(_40197,_40169,_40227),
    w(noun(time,_40133,u,n),_40245,_40227,_40173),
    !.

howadj(duration,[howadj,_40197,_40245,!],_40169,_40173) --> 
    much(_40197,_40169,_40227),
    w(noun(time,_40133,u,n),_40245,_40227,_40173),
    !.

howadj(duration,[howadj,_40181],_40153,_40157) --> 
    w(adj2(short,nil),_40181,_40153,_40157).

howadj(frequency,[howadj,_40171],_40143,_40147) --> 
    often(_40171,_40143,_40147).

howadj(frequency,[howadj,lit(mange),_40235,_40293,!,_40351],_40185,_40189) --> 
    cc(mange,_40185,_40233),
    w(noun(time_count,_40149,_40151,n),_40235,_40233,_40269),
    inperiod0(_40293,_40269,_40323),
    !,
    accept(_40351,_40323,_40189).

howadj(intelligence,[howadj,_40181],_40153,_40157) --> 
    w(adj2(intelligent,nil),_40181,_40153,_40157).

howadj(intelligence,[howadj,_40181],_40153,_40157) --> 
    w(adj2(stupid,_40121),_40181,_40153,_40157).

howadj(intelligence,[howadj,_40201,_40259],_40173,_40177) --> 
    w(adj2(_40139,nil),_40201,_40173,_40235),
    w(noun(intelligence,sin,_40129,n),_40259,_40235,_40177).

howadj(price,[howadj,_40181],_40153,_40157) --> 
    w(adj2(expensive,nil),_40181,_40153,_40157).

howadj(price,[howadj,_40181],_40153,_40157) --> 
    w(adj2(cheap,nil),_40181,_40153,_40157).

howadj(size,[howadj,_40171],_40143,_40147) --> 
    great(_40171,_40143,_40147).

howadj(length,[howadj,_40181],_40153,_40157) --> 
    w(adj2(long,nil),_40181,_40153,_40157).

howadj(length,[howadj,_40181],_40153,_40157) --> 
    w(adj2(short,nil),_40181,_40153,_40157).

howadj(speed,[howadj,lit(fort)],_40147,_40151) --> 
    cc(fort,_40147,_40151).

howadj(speed,[howadj,_40181],_40153,_40157) --> 
    w(adj2(fast,_40121),_40181,_40153,_40157).

howadj(speed,[howadj,_40181],_40153,_40157) --> 
    w(adj2(slow,_40121),_40181,_40153,_40157).

howadj(temperature,[howadj,_40181],_40153,_40157) --> 
    w(adj2(cold,nil),_40181,_40153,_40157).

howadj(temperature,[howadj,_40181],_40153,_40157) --> 
    w(adj2(hot,nil),_40181,_40153,_40157).

howadj(weather,[howadj,_40181],_40153,_40157) --> 
    w(adj2(hot,nil),_40181,_40153,_40157).

howadj(weather,[howadj,_40181],_40153,_40157) --> 
    w(adj2(cold,nil),_40181,_40153,_40157).

howadj(weight,[howadj,_40181],_40153,_40157) --> 
    w(adj2(heavy,nil),_40181,_40153,_40157).

vp(_40111,_40113,_40115,_40121::true,[vp,lit(:),_40251,!],_40183,_40187) --> 
    cc(:,_40183,_40249),
    end_of_line(_40251,_40249,_40187),
    !.

vp(_40111,_40113,_40115,_40117,[vp,_40217],_40171,_40175) --> 
    verb_phrase(_40111,_40113,_40115,_40117,_40217,_40171,_40175).

verb_phrase(_40111,_40113,_40115,_40117,[verb_phrase,_40365,{},{},{},{},!,_40485,_40533,!],_40319,_40323) --> 
    endofline(_40365,_40319,_40395),
    {user:value(busflag,true)},
    {\+user:value(dialog,1)},
    {vartypeid(_40111,_40211)},
    {testmember(_40211,[neighbourhood,bus,tram,station,departure,arrival])},
    !,
    accept(_40485,_40395,_40515),
    pushstack(first,w(verb(exist,pres,fin)),nil,_40515,_40559),verb_phrase1(exist,_40111,_40113,_40115,_40117,_40533,_40559,_40323),
    !.

verb_phrase(_40111,_40113,_40115,_40121::_40123,[verb_phrase,_40425,{},lit(og),_40519,{},_40591,!,_40669,!,_40901],_40379,_40383) --> 
    w(verb(_40207,_40209,fin),_40425,_40379,_40459),
    {verbtype(_40207,tv)},
    cc(og,_40459,_40517),
    w(verb(_40233,_40235,fin),_40519,_40517,_40553),
    {verbtype(_40233,tv)},
    object(_40199,_40253,_40591,_40553,_40629),
    !,
    lock(exact,_40629,_40789),pushstack(exact,(w(verb(_40207,_40299,fin)),xnp(_40199,_40253)),nil,_40789,_40801),verb_phrase1(_40207,_40111,_40113,_40115,_40121::_40289,_40669,_40801,_40779),unlock(_40779,_40781),
    !,
    lock(exact,_40781,_41013),
    pushstack(exact,([og],w(verb(_40233,_40333,fin)),npgap(_40199)),nil,_41013,_41025),
    verb_phrases0(_40233,_40111,_40115,_40289,_40121::_40123,_40901,_41025,_41003),
    unlock(_41003,_40383).

verb_phrase(_40111,_40113,_40115,_40121::_40123,[verb_phrase,_40255,_40353],_40209,_40213) --> 
    verb_phrase1(_40133,_40111,_40113,_40115,_40121::_40139,_40255,_40209,_40305),
    verb_phrases0(_40133,_40111,_40115,_40139,_40121::_40123,_40353,_40305,_40213).

verb_phrases0(_40111,_40113,_40115,_40117,_40123::_40117 and _40131,[verb_phrases0,_40349,lit(ikke),!,_40429,{},{},_40573],_40297,_40301) --> 
    vp_conjunction(_40349,_40297,_40379),
    cc(ikke,_40379,_40417),
    !,
    pushstack(first,w(verb(_40111,pres,fin)),nil,_40417,_40455),verb_phrase1(_40111,_40113,_40215,_40115,_40123::_40225,_40429,_40455,_40497),
    {bigno(not,_40215,_40237)},
    {negate(_40237,_40225,_40177)},
    verb_phrases0(_40111,_40113,_40115,_40177,_40123::_40131,_40573,_40497,_40301).

verb_phrases0(_40111,_40113,_40115,_40117,_40123::_40117 and _40131,[verb_phrases0,_40311,_40359,_40417,{},_40529],_40259,_40263) --> 
    vp_conjunction(_40311,_40259,_40341),
    not_look_ahead([så],_40359,_40341,_40393),
    verb_phrase1(_40185,_40113,_40189,_40115,_40123::_40199,_40417,_40393,_40467),
    {negate(_40189,_40199,_40165)},
    verb_phrases0(_40159,_40113,_40115,_40165,_40123::_40131,_40529,_40467,_40263).

verb_phrases0(be,_40113,_40115,_40117,_40123::_40117 and _40131,[verb_phrases0,_40325,{},!,_40407],_40273,_40277) --> 
    w(adj2(_40169,nil),_40325,_40273,_40359),
    {testmember(_40169,[enclosed])},
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_40169,nil))),nil,_40359,_40427),
    verb_phrase1(be,_40113,id,_40115,_40123::_40131,_40407,_40427,_40277).

verb_phrases0(_40111,_40113,_40115,_40117,_40123::_40117,[verb_phrases0,[]],_40173,_40173) --> 
    [].

vp_conjunction([vp_conjunction,lit(som),_40189],_40145,_40149) --> 
    cc(som,_40145,_40187),
    look_ahead_vp(_40189,_40187,_40149).

vp_conjunction([vp_conjunction,lit(å),_40205],_40161,_40165) --> 
    cc(å,_40161,_40203),
    look_ahead(w(verb(_40125,pres,fin)),_40205,_40203,_40165).

vp_conjunction([vp_conjunction,lit(evt)],_40139,_40143) --> 
    cc(evt,_40139,_40143).

vp_conjunction([vp_conjunction,_40209,_40257,_40315,_40373,!],_40187,_40191) --> 
    and1(_40209,_40187,_40239),
    not_look_ahead([nå],_40257,_40239,_40291),
    not_look_ahead([så],_40315,_40291,_40349),
    not_look_ahead(w(adv(redundantly)),_40373,_40349,_40191),
    !.

vp_conjunction([vp_conjunction,lit(men),_40221,_40279,!],_40177,_40181) --> 
    cc(men,_40177,_40219),
    not_look_ahead([så],_40221,_40219,_40255),
    look_ahead_lit([skal,vil],_40279,_40255,_40181),
    !.

vp_conjunction([vp_conjunction,lit(men),_40225,_40283,!],_40181,_40185) --> 
    cc(men,_40181,_40223),
    not_look_ahead([så],_40225,_40223,_40259),
    look_ahead(w(verb(_40149,_40151,_40153)),_40283,_40259,_40185),
    !.

vp_conjunction([vp_conjunction,_40179,_40227],_40157,_40161) --> 
    or1(_40179,_40157,_40209),
    look_ahead(w(verb(_40125,_40127,fin)),_40227,_40209,_40161).

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40311,_40359,_40417,!,_40485,_40533],_40259,_40263) --> 
    aux1(_40311,_40259,_40341),
    not_look_ahead(w(verb(_40179,_40181,_40183)),_40359,_40341,_40393),
    look_ahead_lit([så,tilbake,fram],_40417,_40393,_40451),
    !,
    accept(_40485,_40451,_40515),
    pushstack(first,w(verb(go,pres,fin)),nil,_40515,_40553),
    do_phrase(_40111,_40113,_40115,_40117,_40119,_40533,_40553,_40263).

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40357,_40405,_40463,{},{},!,_40569,_40617],_40305,_40309) --> 
    aux1(_40357,_40305,_40387),
    not_look_ahead(w(verb(_40191,_40193,_40195)),_40405,_40387,_40439),
    np0_accept(_40177,_40179,_40463,_40439,_40501),
    {vartypeid(_40177,_40211)},
    {testmember(_40211,[thing,coevent,activity])},
    !,
    accept(_40569,_40501,_40599),
    pushstack(first,(w(verb(do1,pres,fin)),xnp(_40177,_40179)),nil,_40599,_40717),
    do_phrase(_40111,_40113,_40115,_40117,_40119,_40617,_40717,_40309).

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40411,_40459,_40517,_40565,_40623,{},_40695,_40743,{},!,_40835,_40883],_40359,_40363) --> 
    aux1(_40411,_40359,_40441),
    negation0(_40115,_40459,_40441,_40493),
    redundant0(_40517,_40493,_40547),
    not_look_ahead(w(verb(_40225,_40227,_40229)),_40565,_40547,_40599),
    w(prep(_40237),_40623,_40599,_40657),
    {testmember(_40237,[from,to,on,towards])},
    look_ahead_np(_40695,_40657,_40725),
    np0_accept(_40207,_40209,_40743,_40725,_40781),
    {constrain(_40207,place)},
    !,
    accept(_40835,_40781,_40865),
    pushstack(first,(w(verb(go,pres,fin)),w(prep(_40237)),xnp(_40207,_40209)),nil,_40865,_40983),
    do_phrase(_40111,_40113,_40115,_40117,_40119,_40883,_40983,_40363).

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40331,_40379,_40437,{},_40509,!,_40567,_40615],_40279,_40283) --> 
    aux1(_40331,_40279,_40361),
    not_look_ahead(w(verb(_40185,_40187,_40189)),_40379,_40361,_40413),
    look_ahead(w(prep(_40201)),_40437,_40413,_40471),
    {\+testmember(_40201,[from,to,on,towards])},
    preadverbials0(_40509,_40471,_40539),
    !,
    accept(_40567,_40539,_40597),
    do_phrase(_40111,_40113,_40115,_40117,_40119,_40615,_40597,_40283).

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40289,_40337,_40395,!,_40463,_40511],_40237,_40241) --> 
    aux1(_40289,_40237,_40319),
    not_look_ahead(w(verb(_40173,_40175,_40177)),_40337,_40319,_40371),
    one_of_lit([da,nå],_40395,_40371,_40429),
    !,
    accept(_40463,_40429,_40493),
    do_phrase(_40111,_40113,_40115,_40117,_40119,_40511,_40493,_40241).

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40345,_40393,_40451,_40509,_40557,{},!,_40649,_40697],_40293,_40297) --> 
    aux1(_40345,_40293,_40375),
    not_look_ahead(w(verb(_40197,_40199,_40201)),_40393,_40375,_40427),
    w(prep(_40209),_40451,_40427,_40485),
    look_ahead_np(_40509,_40485,_40539),
    np0_accept(_40183,_40185,_40557,_40539,_40595),
    {constrain(_40183,time)},
    !,
    accept(_40649,_40595,_40679),
    lock(last,_40679,_40811),
    pushstack(last,(w(prep(_40209)),xnp(_40183,_40185)),nil,_40811,_40823),
    do_phrase(_40111,_40113,_40115,_40117,_40119,_40697,_40823,_40801),
    unlock(_40801,_40297).

verb_phrase1(be1,_40113,_40115,_40117,_40119,[verb_phrase1,lit(skal),_40361,_40419,lit(med),_40529,_40577,{}],_40287,_40291) --> 
    cc(skal,_40287,_40359),
    negation0(_40163,_40361,_40359,_40395),
    optional(w(verb(be,inf,fin)),_40419,_40395,_40483),
    cc(med,_40483,_40527),
    not_look_ahead_np(_40529,_40527,_40559),
    pushstack(first,(w(verb(be1,inf,fin)),w(adv(inside))),nil,_40559,_40603),do_phrase(be1,_40113,_40165,_40117,_40119,_40577,_40603,_40291),
    {bigno(_40163,_40165,_40115)}.

verb_phrase1(be,_40113,id,_40117,_40119,[verb_phrase1,_40279,{},_40351],_40227,_40231) --> 
    w(adj2(_40145,nil),_40279,_40227,_40313),
    {testmember(_40145,[enclosed])},
    pushstack(first,w(adj2(_40145,nil)),nil,_40313,_40371),
    be_pred(_40113,_40117,_40119,_40351,_40371,_40231).

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40375,_40433,_40491,_40549,{},!,_40631,_40747,{}],_40323,_40327) --> 
    constrainvehdep(_40113,_40375,_40323,_40409),
    w(verb(be,_40193,fin),_40433,_40409,_40467),
    negation0(_40175,_40491,_40467,_40525),
    w(verb(_40111,past,part),_40549,_40525,_40583),
    {testmember(_40111,[go,run,pass])},
    !,
    pushstack(first,w(verb(_40111,_40193,fin)),nil,_40583,_40657),vp_kernel(_40111,_40113,_40177,_40117,_40263,_40631,_40657,_40699),
    verb_modifiers0(_40111,_40113,_40117,_40263,_40119,_40747,_40699,_40327),
    {bigno(_40175,_40177,_40115)}.

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40305,_40353,_40411,_40469,!,_40567],_40253,_40257) --> 
    blei(_40305,_40253,_40335),
    one_of_lit([siden,derfor,dermed],_40353,_40335,_40387),
    negation0(_40115,_40411,_40387,_40445),
    lexv(tv,_40111,past,part,_40469,_40445,_40515),
    !,
    pushstack(first,w(verb(_40111,past,part)),nil,_40515,_40587),
    passive(_40113,_40117,_40119,_40567,_40587,_40257).

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40295,_40343,_40391,_40449,_40497,!,_40595],_40243,_40247) --> 
    aux1(_40295,_40243,_40325),
    redundant0(_40343,_40325,_40373),
    negation0(_40115,_40391,_40373,_40425),
    blei(_40449,_40425,_40479),
    lexv(tv,_40111,past,part,_40497,_40479,_40543),
    !,
    pushstack(first,w(verb(_40111,past,part)),nil,_40543,_40615),
    passive(_40113,_40117,_40119,_40595,_40615,_40247).

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40309,_40357,_40415,_40463,_40551,!,_40629],_40257,_40261) --> 
    redundant0(_40309,_40257,_40339),
    blei(_40115,_40357,_40339,_40391),
    redundant0(_40415,_40391,_40445),
    lexv(_40181,_40111,past,part,_40463,_40445,_40509),
    gmem(_40181,[tv,dtv],_40551,_40509,_40589),
    !,
    pushstack(first,w(verb(_40111,past,part)),nil,_40589,_40649),
    passive(_40113,_40117,_40119,_40629,_40649,_40261).

verb_phrase1(be,_40113,_40115,_40117,_40119,[verb_phrase1,_40295,_40353,_40401,_40449,_40507,_40555,_40603,_40651,_40699],_40243,_40247) --> 
    not_look_ahead(w(verb(go,_40189,fin)),_40295,_40243,_40329),
    aux10(_40353,_40329,_40383),
    redundants0(_40401,_40383,_40431),
    be(_40115,_40449,_40431,_40483),
    not_look_ahead_verbx(_40507,_40483,_40537),
    danow0(_40555,_40537,_40585),
    redundant0(_40603,_40585,_40633),
    not_look_ahead_prepx(_40651,_40633,_40681),
    be_complements(_40113,_40117,_40119,_40699,_40681,_40247).

not_look_ahead_verbx([not_look_ahead_verbx,lit(så),!],_40145,_40149) --> 
    cc(så,_40145,_40149),
    !.

not_look_ahead_verbx([not_look_ahead_verbx,_40173],_40151,_40155) --> 
    not_look_ahead(w(verb(_40119,_40121,_40123)),_40173,_40151,_40155).

not_look_ahead_prepx([not_look_ahead_prepx,_40205,{},!,_40287],_40183,_40187) --> 
    look_ahead(w(prep(_40137)),_40205,_40183,_40239),
    {\+testmember(_40137,[for])},
    !,
    reject(_40287,_40239,_40187).

not_look_ahead_prepx([not_look_ahead_prepx,[]],_40135,_40135) --> 
    [].

verb_phrase1(_40111,_40113,_40115,_40117,_40119,[verb_phrase1,_40329,_40397,_40455,_40503,{},_40575,{},!,_40697],_40277,_40281) --> 
    auxs0(_40171,_40173,_40329,_40277,_40367),
    not_look_ahead(w(verb(_40185,_40187,pass)),_40397,_40367,_40431),
    redundants0(_40455,_40431,_40485),
    negation0(_40193,_40503,_40485,_40537),
    {bigno(_40171,_40193,_40205)},
    do_phrase(_40111,_40113,_40213,_40117,_40119,_40575,_40537,_40625),
    {bigno(_40205,_40213,_40115)},
    !,
    accept(_40697,_40625,_40281).

verb_phrase1(go,_40113,_40115,_40117,_40119,[verb_phrase1,_40309,_40357,lit(av),!,_40447,_40495],_40257,_40261) --> 
    aux1(_40309,_40257,_40339),
    not_look_ahead(w(verb(_40177,_40179,_40181)),_40357,_40339,_40391),
    cc(av,_40391,_40435),
    !,
    accept(_40447,_40435,_40477),
    pushstack(first,(w(verb(go,pres,fin)),[av]),nil,_40477,_40515),
    do_phrase(go,_40113,_40115,_40117,_40119,_40495,_40515,_40261).

verb_phrase1(_40111,_40113,id,_40117,_40123::_40125,[verb_phrase1,_40287,_40335,_40383,_40441],_40235,_40239) --> 
    paux0(_40287,_40235,_40317),
    redundant0(_40335,_40317,_40365),
    w(verb(_40111,_40171,pass),_40383,_40365,_40417),
    pushstack(first,w(verb(_40111,past,part)),nil,_40417,_40461),
    passive(_40113,_40117,_40123::_40125,_40441,_40461,_40239).

verb_phrase1(live,_40113,id,_40117,_40119,[verb_phrase1,_40357,_40405,_40453,_40511,_40569,!,_40667],_40305,_40309) --> 
    be(_40357,_40305,_40387),
    redundant0(_40405,_40387,_40435),
    number(_40197,_40453,_40435,_40487),
    w(noun(year,_40207,u,n),_40511,_40487,_40545),
    optional(w(adj2(old,nil)),_40569,_40545,_40633),
    !,
    pushstack(first,(w(verb(live,pres,fin)),prep1(in),number(_40197),w(noun(year,plu,u,n))),nil,_40633,_40831),
    do_phrase(live,_40113,id,_40117,_40119,_40667,_40831,_40309).

verb_phrase1(be,_40113,_40115,_40117,_40119,[verb_phrase1,_40263,_40321,lit(som),!,_40401],_40211,_40215) --> 
    be(_40115,_40263,_40211,_40297),
    dudet(_40321,_40297,_40351),
    cc(som,_40351,_40389),
    !,
    do_phrase(be,_40113,_40115,_40117,_40119,_40401,_40389,_40215).

verb_phrase1(be,_40113,_40115,_40117,_40119,[verb_phrase1,_40385,_40443,_40501,!,_40569,_40617,_40675,_40733,_40781,_40829,{}],_40333,_40337) --> 
    not_look_ahead(w(verb(go,_40205,fin)),_40385,_40333,_40419),
    w(verb(be,_40217,fin),_40443,_40419,_40477),
    not_look_ahead(w(verb(_40231,_40233,part)),_40501,_40477,_40535),
    !,
    accept(_40569,_40535,_40599),
    not_look_ahead(w(name(_40247,_40249,_40251)),_40617,_40599,_40651),
    negation0(_40187,_40675,_40651,_40709),
    it0(_40733,_40709,_40763),
    redundant0(_40781,_40763,_40811),
    pushstack(first,w(verb(be,pres,fin)),nil,_40811,_40855),do_phrase(be,_40113,_40189,_40117,_40119,_40829,_40855,_40337),
    {bigno(_40187,_40189,_40115)}.

verb_phrase1(_40111,_40113,id,_40117,_40119,[verb_phrase1,_40273,_40321,_40379,_40427],_40221,_40225) --> 
    paux0(_40273,_40221,_40303),
    w(verb(_40111,pres,pass),_40321,_40303,_40355),
    thereit0(_40379,_40355,_40409),
    pushstack(first,w(adj2(_40111,nil)),nil,_40409,_40447),
    be_complements(_40113,_40117,_40119,_40427,_40447,_40225).

do_phrase(_40111,_40113,_40115,_40117,_40119,[do_phrase,_40475,{},_40547,_40605,_40653,_40711,_40769,{},!,_40851,_40899,_41031],_40423,_40427) --> 
    w(verb(_40111,_40227,fin),_40475,_40423,_40509),
    {testmember(_40111,[go,come])},
    negation0(_40115,_40547,_40509,_40581),
    morethan0(_40605,_40581,_40635),
    w(nb(_40259,num),_40653,_40635,_40687),
    w(noun(minute,_40271,u,n),_40711,_40687,_40745),
    w(adj2(_40283,_40285),_40769,_40745,_40803),
    {testmember(_40283,[delayed,tooearly,late])},
    !,
    accept(_40851,_40803,_40881),
    lock(exact,_40881,_40939),pushstack(exact,w(adj2(_40283,_40285)),nil,_40939,_40951),ap(_40283,_40113,_40117,_40333,_40899,_40951,_40929),unlock(_40929,_40931),
    pushstack(first,(w(prep(with)),w(nb(_40259,num)),w(noun(minute,plu,u,n))),nil,_40931,_41051),
    verb_modifiers0(adj/nil/_40283,_40113,_40117,_40333,_40119,_41031,_41051,_40427).

morethan0([morethan0,lit(ca),!],_40145,_40149) --> 
    cc(ca,_40145,_40149),
    !.

morethan0([morethan0,lit(minst),!],_40145,_40149) --> 
    cc(minst,_40145,_40149),
    !.

morethan0([morethan0,lit(mer),lit(enn),!],_40155,_40159) --> 
    cc(mer,_40155,_40197),
    cc(enn,_40197,_40159),
    !.

morethan0([morethan0,[]],_40135,_40135) --> 
    [].

do_phrase(_40111,_40113,id,_40117,_40123::_40129 and _40131,[do_phrase,_40387,_40445,_40503,{},_40585,_40633,!,_40701,{}],_40335,_40339) --> 
    w(verb(ask,_40207,fin),_40387,_40335,_40421),
    not_look_ahead([om],_40445,_40421,_40479),
    object(_40221,_40223,_40503,_40479,_40541),
    {constrain(_40221,agent)},
    omaa0(_40585,_40541,_40615),
    w(verb(_40241,inf,fin),_40633,_40615,_40667),
    !,
    pushstack(first,(xnp(_40221,_40223),w(verb(_40241,pres,fin))),nil,_40667,_40807),clausal_object1(_40193,_40123::_40131,_40701,_40807,_40339),
    {co_template(_40111,that,_40113,_40193,_40117,_40129)}.

omaa0([omaa0,_40163,!],_40141,_40145) --> 
    omaa(_40163,_40141,_40145),
    !.

omaa0([omaa0,[]],_40135,_40135) --> 
    [].

omaa([omaa,lit(om),lit(å)],_40149,_40153) --> 
    cc(om,_40149,_40191),
    cc(å,_40191,_40153).

omaa([omaa,lit(om),lit(og)],_40149,_40153) --> 
    cc(om,_40149,_40191),
    cc(og,_40191,_40153).

omaa([omaa,lit(å)],_40139,_40143) --> 
    cc(å,_40139,_40143).

do_phrase(_40111,_40113,_40115,_40117,_40119,[do_phrase,_40249,_40347],_40197,_40201) --> 
    rvp_kernel(_40111,_40113,_40115,_40117,_40135,_40249,_40197,_40299),
    verb_modifiers0(_40111,_40113,_40117,_40135,_40119,_40347,_40299,_40201).

do_phrase(have,_40113,id,_40117,_40123::_40129 and _40131,[do_phrase,_40367,_40415,{},lit(for),lit(å),!,_40541,_40589,{}],_40315,_40319) --> 
    has(_40367,_40315,_40397),
    w(adj2(_40203,nil),_40415,_40397,_40449),
    {testmember(_40203,[difficult])},
    cc(for,_40449,_40507),
    cc(å,_40507,_40529),
    !,
    accept(_40541,_40529,_40571),
    pushstack(first,(npgap(_40113),aux1),nil,_40571,_40767),clausal_object1(_40255:coevent,_40123::_40131,_40589,_40767,_40319),
    {tv_template(dislike,_40113,_40255:coevent,_40117,_40129)}.

do_phrase(_40111,_40113,_40115,_40117,_40119,[do_phrase,_40261,_40359,_40457],_40209,_40213) --> 
    vp_kernel(_40111,_40113,_40135,_40117,_40149,_40261,_40209,_40311),
    verb_modifiers0(_40111,_40113,_40117,_40149,_40119,_40359,_40311,_40409),
    negation2(_40135,_40115,_40457,_40409,_40213).

do_phrase(_40111,_40113,_40115,_40117,_40119,[do_phrase,_40319,_40377,!,_40445,_40561,_40609],_40267,_40271) --> 
    not_look_ahead(w(verb(_40173,_40175,_40177)),_40319,_40267,_40353),
    look_ahead(w(prep(_40189)),_40377,_40353,_40411),
    !,
    pushstack(first,w(verb(do1,pres,fin)),nil,_40411,_40471),vp_kernel(_40111,_40113,_40115,_40117,_40159,_40445,_40471,_40513),
    it0(_40561,_40513,_40591),
    verb_modifiers0(_40111,_40113,_40117,_40159,_40119,_40609,_40591,_40271).

rvp_kernel(_40111,_40113,_40115,_40117,_40119,[rvp_kernel,_40499,{},_40611,_40669,_40727,_40785,_40843,{},_40925,_41013,_41071,!,_41149,_41413],_40447,_40451) --> 
    hlexv(dtv,_40111,_40223,_40225,_40227,_40499,_40447,_40549),
    {testmember(_40111,[ask,tell,answer,answer1])},
    not_look_ahead([om],_40611,_40549,_40645),
    not_look_ahead([et],_40669,_40645,_40703),
    not_look_ahead([en],_40727,_40703,_40761),
    not_look_ahead(w(nb(_40289,_40291)),_40785,_40761,_40819),
    ind_object(_40295,_40297,_40843,_40819,_40881),
    {constrain(_40295,agent)},
    optional([om],_40925,_40881,_40989),
    not_look_ahead([at],_41013,_40989,_41047),
    np1_accept(_40213,_40215,_41071,_41047,_41109),
    !,
    pushstack(first,(lexv(dtv,_40111,_40223,_40225),xnp(_40295,_40297),[noe]),nil,_41109,_41323),vp_kernel(_40111,_40113,_40115,_40117,_40363,_41149,_41323,_41365),
    pushstack(first,(w(prep(about)),xnp(_40213,_40215)),nil,_41365,_41513),
    verb_modifiers0(_40111,_40113,_40117,_40363,_40119,_41413,_41513,_40451).

rvp_kernel(_40111,_40113,_40115,_40117,_40119,[rvp_kernel,_40265,_40363,_40421,!],_40213,_40217) --> 
    lexvaccept(rv,_40111,_40145,_40147,_40115,_40265,_40213,_40315),
    reflexiv0(_40111,_40363,_40315,_40397),
    rvpk(_40111,_40113,id,_40117,_40119,_40421,_40397,_40217),
    !.

rvp_kernel(_40111,_40113,id,_40117,event/real/_40117::_40129 and _40131,[rvp_kernel,_40395,{},_40507,_40565,{},_40637,!,_40695,_40743,{}],_40343,_40347) --> 
    hlexv(rv,_40111,_40221,_40223,_40225,_40395,_40343,_40445),
    {testmember(_40111,[know,say])},
    reflexiv0(_40111,_40507,_40445,_40541),
    w(prep(_40255),_40565,_40541,_40599),
    {\+testmember(_40255,[])},
    which(_40637,_40599,_40667),
    !,
    accept(_40695,_40667,_40725),
    pushstack(first,(w(prep(_40255)),which),nil,_40725,_40843),ppstnp(_40209,_40129,_40743,_40843,_40347),
    {tv_template(_40111,_40113,_40209,_40117,_40131)}.

rvp_kernel(adj/nil/_40137,_40113,_40115,_40117,_40123::_40129 and _40131,[rvp_kernel,_40341,_40399,_40457,_40515,_40563,{}],_40289,_40293) --> 
    w(verb(be,_40201,fin),_40341,_40289,_40375),
    negation0(_40115,_40399,_40375,_40433),
    w(adj2(_40137,nil),_40457,_40433,_40491),
    forat(_40515,_40491,_40545),
    clausal_object1(_40233:_40235,_40123::_40131,_40563,_40545,_40293),
    {atv_template(_40137,because_of,_40113,_40233:_40235,_40117,_40129)}.

rvpk(_40111,_40113,id,_40117,_40123::_40129 and _40131,[rvpk,{},_40405,lit(hvordan),_40475,!,_40533,_40581,{}],_40339,_40343) --> 
    {testmember(_40111,[ask,answer,answer1,discuss,know,know1])},
    omut0(_40405,_40339,_40435),
    cc(hvordan,_40435,_40473),
    endofline0(_40475,_40473,_40505),
    !,
    accept(_40533,_40505,_40563),
    pushstack(first,(w(noun(bus,sin,def,n)),w(verb(go,pres,fin))),nil,_40563,_40607),clausal_object1(_40269:_40271,_40123::_40131,_40581,_40607,_40343),
    {co_template(_40111,how,_40113,_40269:_40271,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},_40397,lit(hvordan),!,_40477,{},!,_40559,_40607,{}],_40331,_40335) --> 
    {testmember(_40111,[ask,answer,answer1,discuss,know,know1])},
    omut0(_40397,_40331,_40427),
    cc(hvordan,_40427,_40465),
    !,
    negation0(_40115,_40477,_40465,_40511),
    {test(rv_templ(_40111,_40259))},
    !,
    accept(_40559,_40511,_40589),
    clausal_object1(_40275:_40277,_40123::_40131,_40607,_40589,_40335),
    {co_template(_40111,how,_40113,_40275:_40277,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,_40397,_40465,lit(at),_40545,!,_40613,_40691,{}],_40345,_40349) --> 
    gmem(_40111,[calculate,say,tell,know,decide,believe,doubt,think],_40397,_40345,_40435),
    negation0(_40115,_40465,_40435,_40499),
    cc(at,_40499,_40543),
    look_ahead_lit([hvis,når,selvom],_40545,_40543,_40579),
    !,
    subordinate(_40255,_40257,_40259,_40613,_40579,_40655),
    lock(last,_40655,_40813),pushstack(last,subordinate(_40255,_40257,_40259),nil,_40813,_40825),clausal_object1(_40289:_40291,_40123::_40131,_40691,_40825,_40803),unlock(_40803,_40349),
    {tv_template(_40111,_40113,_40289:_40291,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,_40355,_40423,_40471,_40529,_40587,{}],_40303,_40307) --> 
    gmem(_40111,[calculate,fear,hope,know,mean,recognize,think,understand],_40355,_40303,_40393),
    redundant0(_40423,_40393,_40453),
    negation0(_40115,_40471,_40453,_40505),
    not_look_ahead_lit([at,om],_40529,_40505,_40563),
    clausal_object0(_40247:_40249,_40123::_40131,_40587,_40563,_40307),
    {tv_template(_40111,_40113,_40247:_40249,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,_40371,_40439,lit(at),_40519,!,_40597,_40645,{}],_40319,_40323) --> 
    gmem(_40111,[do1,paint],_40371,_40319,_40409),
    negation0(_40115,_40439,_40409,_40473),
    cc(at,_40473,_40517),
    np0_accept(_40215,_40217,_40519,_40517,_40557),
    !,
    accept(_40597,_40557,_40627),
    pushstack(first,(xnp(_40215,_40217),w(verb(be,pres,fin))),nil,_40627,_40751),clausal_object1(_40257:_40259,_40123::_40131,_40645,_40751,_40323),
    {tv_template(_40111,_40113,_40257:_40259,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},_40351,_40409,lit(at),!,_40489,{}],_40285,_40289) --> 
    {testmember(_40111,[base,say,tell])},
    negation0(_40115,_40351,_40285,_40385),
    preadverbials0(_40409,_40385,_40439),
    cc(at,_40439,_40477),
    !,
    clausal_object1(_40229:_40231,_40123::_40131,_40489,_40477,_40289),
    {tv_template(_40111,_40113,_40229:_40231,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},_40357,_40415,!,_40483,_40531,{}],_40291,_40295) --> 
    {testmember(_40111,[mean,think])},
    pronoun(_40205,_40357,_40291,_40391),
    negation0(_40115,_40415,_40391,_40449),
    !,
    accept(_40483,_40449,_40513),
    pushstack(first,pronoun(_40205),nil,_40513,_40635),clausal_object1(_40235:_40237,_40123::_40131,_40531,_40635,_40295),
    {tv_template(_40111,_40113,_40235:_40237,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},_40363,_40421,_40489,lit(å),!,_40609,{}],_40297,_40301) --> 
    {testmember(_40111,[regard])},
    negation0(_40115,_40363,_40297,_40397),
    object1(_40211,_40213,_40421,_40397,_40459),
    optional([for],_40489,_40459,_40553),
    cc(å,_40553,_40597),
    !,
    pushstack(first,xnp(_40211,_40213),nil,_40597,_40715),clausal_object1(_40185,_40123::_40131,_40609,_40715,_40301),
    {tv_template(_40111,_40113,_40185,_40117,_40129)}.

rvpk(_40111,_40113,id,_40117,_40123::_40129 and _40131,[rvpk,{},_40363,_40451,lit(når),!,_40571,_40619,{}],_40297,_40301) --> 
    {testmember(_40111,[wonder])},
    optional([på],_40363,_40297,_40427),
    optional([om],_40451,_40427,_40515),
    cc(når,_40515,_40559),
    !,
    accept(_40571,_40559,_40601),
    clausal_object1(_40241:coevent,_40123::_40131,_40619,_40601,_40301),
    {co_template(_40111,when,_40113,_40241:coevent,_40117,_40129)}.

rvpk(_40111,_40113,id,_40117,_40123::_40129 and _40131,[rvpk,{},_40353,lit(om),!,_40473,_40521,{}],_40287,_40291) --> 
    {testmember(_40111,[think,wonder])},
    optional([på],_40353,_40287,_40417),
    cc(om,_40417,_40461),
    !,
    accept(_40473,_40461,_40503),
    clausal_object1(_40231:coevent,_40123::_40131,_40521,_40503,_40291),
    {co_template(_40111,whether,_40113,_40231:coevent,_40117,_40129)}.

altsogå([altsogå,lit(altså),lit(å)],_40149,_40153) --> 
    cc(altså,_40149,_40191),
    cc(å,_40191,_40153).

altsogå([altsogå,lit(og),lit(å)],_40149,_40153) --> 
    cc(og,_40149,_40191),
    cc(å,_40191,_40153).

ppstnp(_40111,_40113,[ppstnp,_40227,_40285,_40333,_40411],_40193,_40197) --> 
    w(prep(_40137),_40227,_40193,_40261),
    which(_40285,_40261,_40315),
    np_kernel(0,_40111,_40141,_40333,_40315,_40375),
    forwst(_40113,_40137,_40111,_40141,_40411,_40375,_40197).

forwst(_40111,_40113,_40115,_40117,[forwst,_40225],_40179,_40183) --> 
    pushstack(free,adverbial1(_40113,_40115,_40117),nil,_40179,_40327),
    statreal(_40111,_40225,_40327,_40183).

forat([forat,lit(at)],_40139,_40143) --> 
    cc(at,_40139,_40143).

forat([forat,lit(for),lit(at)],_40149,_40153) --> 
    cc(for,_40149,_40191),
    cc(at,_40191,_40153).

forat([forat,lit(fordi)],_40139,_40143) --> 
    cc(fordi,_40139,_40143).

forat([forat,lit(av),lit(at)],_40149,_40153) --> 
    cc(av,_40149,_40191),
    cc(at,_40191,_40153).

forat([forat,lit(over),lit(at)],_40149,_40153) --> 
    cc(over,_40149,_40191),
    cc(at,_40191,_40153).

forat([forat,lit(til),lit(at)],_40149,_40153) --> 
    cc(til,_40149,_40191),
    cc(at,_40191,_40153).

forat([forat,lit(om)],_40139,_40143) --> 
    cc(om,_40139,_40143).

rvpk(_40111,_40113,id,_40117,_40123::_40129 and _40131,[rvpk,{},_40387,lit(hvor),_40457,!,_40525,{}],_40321,_40325) --> 
    {testmember(_40111,[ask,answer,answer1,discuss,know,know1])},
    omut0(_40387,_40321,_40417),
    cc(hvor,_40417,_40455),
    w(adj2(_40231,nil),_40457,_40455,_40491),
    !,
    pushstack(free,w(adj2(_40231,nil)),nil,_40491,_40551),clausal_object1(_40265:_40267,_40123::_40131,_40525,_40551,_40325),
    {co_template(_40111,how,_40113,_40265:_40267,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,_40403,_40471,_40529,_40577,lit(når),{},!,_40671,!,_40739,_40787,{}],_40351,_40355) --> 
    gmem(_40111,[ask,answer,answer1,discover,discuss,know,know1,say],_40403,_40351,_40441),
    reflexiv0(_40111,_40471,_40441,_40505),
    redundant0(_40529,_40505,_40559),
    omut0(_40577,_40559,_40607),
    cc(når,_40607,_40645),
    {test(rv_templ(_40111,_40275))},
    !,
    negation0(_40115,_40671,_40645,_40705),
    !,
    accept(_40739,_40705,_40769),
    clausal_object1(_40295:_40297,_40123::_40131,_40787,_40769,_40355),
    {co_template(_40111,when,_40113,_40295:_40297,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},{},lit(_40257),{},!,_40479,!,_40547,_40595,{}],_40353,_40357) --> 
    {\+testmember(_40111,[fail,help,let,lie2,slip,try])},
    {test(rv_templ(_40111,_40255))},
    cc(_40257,_40353,_40453),
    {testmember(_40257,[hvorfor,hvordan])},
    !,
    negation0(_40115,_40479,_40453,_40513),
    !,
    accept(_40547,_40513,_40577),
    clausal_object1(_40297:_40299,_40123::_40131,_40595,_40577,_40357),
    {co_template(_40111,why,_40113,_40297:_40299,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},_40375,_40433,lit(at),!,_40543,{},[]],_40309,_40313) --> 
    {testmember(_40111,[say,tell])},
    negation0(_40115,_40375,_40309,_40409),
    pp(_40183,_40185,_40187,_40433,_40409,_40475),
    cc(at,_40475,_40531),
    !,
    clausal_object1(_40237:_40239,_40123::_40131,_40543,_40531,_40581),
    {tv_template(_40111,_40113,_40237:_40239,_40117,_40129)},
    pushstack(free,adverbial1(_40183,_40185,_40187),nil,_40581,_40313),
    [].

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},_40421,_40479,_40527,{},{},!,_40623,_40671,{}],_40355,_40359) --> 
    {\+testmember(_40111,[fail,help,let,lie2,slip,think,try,propose])},
    reflexiv0(_40111,_40421,_40355,_40455),
    omut0(_40479,_40455,_40509),
    negation0(_40115,_40527,_40509,_40561),
    {test(rv_templ(_40111,_40269))},
    {\+verbtype(_40111,tv)},
    !,
    accept(_40623,_40561,_40653),
    clausal_object0(_40299:_40301,_40123::_40131,_40671,_40653,_40359),
    {tv_template(_40111,_40113,_40299:_40301,_40117,_40129)}.

at0([at0,lit(at),!],_40145,_40149) --> 
    cc(at,_40145,_40149),
    !.

at0([at0,_40193],_40171,_40175) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de,det],_40193,_40171,_40175).

omut0([omut0,lit(om),!],_40145,_40149) --> 
    cc(om,_40145,_40149),
    !.

omut0([omut0,lit(ut),!],_40145,_40149) --> 
    cc(ut,_40145,_40149),
    !.

omut0([omut0,[]],_40135,_40135) --> 
    [].

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},_40399,lit(om),_40479,!,_40547,!,_40615,_40663,{}],_40333,_40337) --> 
    {testmember(_40111,[ask,say,know,know1,answer,answer1])},
    reflexiv0(_40111,_40399,_40333,_40433),
    cc(om,_40433,_40477),
    not_look_ahead_lit([et,en],_40479,_40477,_40513),
    !,
    negation0(_40115,_40547,_40513,_40581),
    !,
    accept(_40615,_40581,_40645),
    clausal_object1(_40277:_40279,_40123::_40131,_40663,_40645,_40337),
    {co_template(_40111,whether,_40113,_40277:_40279,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},{},_40423,_40481,lit(at),!,_40561,!,_40629,_40677,{}],_40343,_40347) --> 
    {test(rv_templ(_40111,_40221))},
    {\+testmember(_40111,[fail,help,let,lie2,slip,try])},
    reflexiv0(_40111,_40423,_40343,_40457),
    omut0(_40481,_40457,_40511),
    cc(at,_40511,_40549),
    !,
    negation0(_40115,_40561,_40549,_40595),
    !,
    accept(_40629,_40595,_40659),
    clausal_object1(_40287:_40289,_40123::_40131,_40677,_40659,_40347),
    {tv_template(_40111,_40113,_40287:_40289,_40117,_40129)}.

at0([at0,lit(at),!],_40145,_40149) --> 
    cc(at,_40145,_40149),
    !.

at0([at0,_40189],_40167,_40171) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_40189,_40167,_40171).

omut0([omut0,lit(om),!],_40145,_40149) --> 
    cc(om,_40145,_40149),
    !.

omut0([omut0,lit(ut),!],_40145,_40149) --> 
    cc(ut,_40145,_40149),
    !.

omut0([omut0,[]],_40135,_40135) --> 
    [].

rvpk(_40111,_40113,_40115,_40117,_40119,[rvpk,{},_40367,_40455,_40503,!,_40581],_40301,_40305) --> 
    {testmember(_40111,[ask,check,discuss,know,know1,tell])},
    optional([om],_40367,_40301,_40431),
    hvilkemange(_40455,_40431,_40485),
    clausal_object0(_40171,_40173,_40503,_40485,_40541),
    !,
    pushstack(first,(w(verb(_40111,pres,fin)),w(prep(about)),xnp(_40171,_40173)),nil,_40541,_40681),
    do_phrase(_40111,_40113,_40115,_40117,_40119,_40581,_40681,_40305).

hvilkemange([hvilkemange,lit(hvilke)],_40139,_40143) --> 
    cc(hvilke,_40139,_40143).

hvilkemange([hvilkemange,lit(hvor),lit(mange)],_40149,_40153) --> 
    cc(hvor,_40149,_40191),
    cc(mange,_40191,_40153).

rvpk(_40111,_40113,id,_40117,_40123::_40129 and _40131,[rvpk,lit(om),lit(å),{},{},!,_40441,{}],_40307,_40311) --> 
    cc(om,_40307,_40379),
    cc(å,_40379,_40401),
    {testmember(_40111,[ask])},
    {test(rv_templ(_40111,_40219))},
    !,
    pushstack(first,(npgap(_40113),aux1),nil,_40401,_40619),clausal_object1(_40247:coevent,_40123::_40131,_40441,_40619,_40311),
    {tv_template(_40111,_40113,_40247:coevent,_40117,_40129)}.

rvpk(_40111,_40113,id,_40117,_40123::_40129 and _40131,[rvpk,_40345,_40413,!,_40511,{}],_40293,_40297) --> 
    gmem(_40111,[need,start,stop,try,use2],_40345,_40293,_40383),
    optional([å],_40413,_40383,_40477),
    !,
    pushstack(first,(npgap(_40113),aux1),nil,_40477,_40689),clausal_object1(_40233:coevent,_40123::_40131,_40511,_40689,_40297),
    {tv_template(_40111,_40113,_40233:coevent,_40117,_40129)}.

rvpk(_40111,_40113,id,_40117,_40123::_40129 and _40131,[rvpk,_40469,lit(å),{},!,_40603,_40651,{}],_40417,_40421) --> 
    optional([på],_40469,_40417,_40533),
    cc(å,_40533,_40577),
    {testmember(_40111,[avoid,choose,consider,deny,end,expect,forget,hate,hope,learn,like,manage,need,postpone,promise,propose,reach,recommend,refuse,remember,resist,risk,seem,slip,start,think,try,use2,want,wish,wonder])},
    !,
    accept(_40603,_40577,_40633),
    pushstack(first,(npgap(_40113),aux1),nil,_40633,_40829),clausal_object1(_40357:coevent,_40123::_40131,_40651,_40829,_40421),
    {tv_template(_40111,_40113,_40357:coevent,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},_40487,_40545,lit(om),_40655,_40723,_40781,!,_40839,_40887,{},_40989,{},{}],_40421,_40425) --> 
    {testmember(_40111,[answer,answer1,say])},
    reflexiv0(_40111,_40487,_40421,_40521),
    optional([på],_40545,_40521,_40609),
    cc(om,_40609,_40653),
    np1_accept(_40263,_40265,_40655,_40653,_40693),
    negation0(_40269,_40723,_40693,_40757),
    look_ahead_vp(_40781,_40757,_40811),
    !,
    accept(_40839,_40811,_40869),
    lexv(_40273,_40275,_40277,fin,_40887,_40869,_40933),
    {test(rv_templ(_40111,_40293))},
    pushstack(first,(xnp(_40263,_40265),w(verb(_40275,_40277,fin)),negation0(_40269)),nil,_40933,_41167),clausal_object1(_40331:coevent,_40123::_40131,_40989,_41167,_40425),
    {tv_template(_40111,_40113,_40331:coevent,_40117,_40219)},
    {negate(_40115,_40219,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40119,[rvpk,{},lit(om),_40385,_40463,!,_40531],_40297,_40301) --> 
    {testmember(_40111,[ask,worry,tell])},
    cc(om,_40297,_40383),
    np_kernel(0,_40173,_40175,_40385,_40383,_40427),
    look_ahead([som],_40463,_40427,_40497),
    !,
    pushstack(first,(w(verb(_40111,pres,fin)),w(prep(about)),np_kernel(0,_40173,_40175)),nil,_40497,_40633),
    do_phrase(_40111,_40113,_40115,_40117,_40119,_40531,_40633,_40301).

rvpk(_40111,_40113,id,_40117,_40123::_40129 and _40131,[rvpk,{},lit(om),_40363,{}],_40275,_40279) --> 
    {testmember(_40111,[ask,check,discuss,know,know1,see])},
    cc(om,_40275,_40361),
    clausal_object1(_40219:coevent,_40123::_40131,_40363,_40361,_40279),
    {tv_template(_40111,_40113,_40219:coevent,_40117,_40129)}.

rvpk(_40111,_40113,_40115,_40117,_40119,[rvpk,{},lit(om),_40367,!,_40445],_40279,_40283) --> 
    {testmember(_40111,[ask,worry,tell])},
    cc(om,_40279,_40365),
    np1_accept(_40165,_40167,_40367,_40365,_40405),
    !,
    pushstack(first,(w(verb(_40111,pres,fin)),w(prep(about)),xnp(_40165,_40167)),nil,_40405,_40545),
    do_phrase(_40111,_40113,_40115,_40117,_40119,_40445,_40545,_40283).

rvpk(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[rvpk,{},_40401,_40459,_40517,{},!,_40599,_40647,{}],_40335,_40339) --> 
    {testmember(_40111,[believe,clculate,know,know1,mean,tell,say])},
    negation0(_40115,_40401,_40335,_40435),
    reflexiv0(_40111,_40459,_40435,_40493),
    not_look_ahead([om],_40517,_40493,_40551),
    {test(rv_templ(_40111,_40263))},
    !,
    accept(_40599,_40551,_40629),
    clausal_object0(_40279:_40281,_40123::_40131,_40647,_40629,_40339),
    {tv_template(_40111,_40113,_40279:_40281,_40117,_40129)}.

rvpk(_40111,_40113,id,_40117,_40123::_40129 and _40131,[rvpk,{},{},!,_40423,_40471,{}],_40333,_40337) --> 
    {testmember(_40111,[avoid,manage,promise,recommend,remember,seem,slip,start,try,use2,want])},
    {test(rv_templ(_40111,_40245))},
    !,
    accept(_40423,_40333,_40453),
    pushstack(first,(npgap(_40113),aux1),nil,_40453,_40649),clausal_object1(_40273:coevent,_40123::_40131,_40471,_40649,_40337),
    {tv_template(_40111,_40113,_40273:coevent,_40117,_40129)}.

clausal_object0(_40111,_40113,[clausal_object0,_40221,_40279,!,_40357],_40187,_40191) --> 
    look_ahead(w(nb(_40143,_40145)),_40221,_40187,_40255),
    obviousdate(_40111,_40113,_40279,_40255,_40317),
    !,
    accept(_40357,_40317,_40191).

clausal_object0(_40111,_40113,[clausal_object0,_40225,_40283,_40351],_40191,_40195) --> 
    not_look_ahead(w(nb(_40147,_40149)),_40225,_40191,_40259),
    np(_40129,_40131,_40283,_40259,_40321),
    cond_vp(_40129,_40131,_40111,_40113,_40351,_40321,_40195).

cond_vp(_40111,_40113,_40115,_40117,[cond_vp,_40269,{},_40341,!],_40223,_40227) --> 
    look_ahead([_40141],_40269,_40223,_40303),
    {testmember(_40141,[du,jeg])},
    lock(last,_40303,_40461),pushstack(last,xnp(_40111,_40113),nil,_40461,_40473),clausal_object1(_40115,_40117,_40341,_40473,_40451),unlock(_40451,_40227),
    !.

cond_vp(_40111,_40113,_40115,_40117,[cond_vp,_40251,_40309,_40357,!],_40205,_40209) --> 
    not_look_ahead([så],_40251,_40205,_40285),
    look_ahead_vp(_40309,_40285,_40339),
    pushstack(first,xnp(_40111,_40113),nil,_40339,_40463),clausal_object1(_40115,_40117,_40357,_40463,_40209),
    !.

cond_vp(_40111,_40113,_40111,_40113,[cond_vp,[]],_40161,_40161) --> 
    [].

clausal_object1(_40141:coevent,_40117::exists(_40141:coevent)::_40141 isa coevent and event/_40141/_40165 and _40137,[clausal_object1,_40253],_40219,_40223) --> 
    substatem(_40165,_40117::_40137,_40253,_40219,_40223).

clausal_object2(_40141:coevent,_40117::exists(_40141:coevent)::_40141 isa coevent and event/_40141/_40165 and _40137,[clausal_object2,_40253],_40219,_40223) --> 
    sostatem(_40165,_40117::_40137,_40253,_40219,_40223).

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40381,{},_40493,_40561,_40649,{},_40829,_40907],_40329,_40333) --> 
    hlexv(dtv,_40111,_40181,_40183,_40171,_40381,_40329,_40431),
    {testmember(_40111,[allow,let])},
    ind_object(_40207,_40209,_40493,_40431,_40531),
    optional([å],_40561,_40531,_40625),
    pushstack(first,(xnp(_40207,_40209),[vil]),nil,_40625,_40755),clausal_object1(_40237,_40243::_40125,_40649,_40755,_40785),
    {tv_template(_40111,_40113,_40237,_40117,_40267)},
    someevent00(_40117,_40267,_40123::_40243,_40829,_40785,_40871),
    negation2(_40171,_40115,_40907,_40871,_40333).

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40129 and _40131,[vp_kernel,_40465,_40553,_40611,_40669,_40727,_40785,_40853,_40911,{},_40983,{},_41065,_41153],_40413,_40417) --> 
    lexv(dtv,_40111,_40225,fin,_40465,_40413,_40511),
    not_look_ahead(w(adj2(_40239,nil)),_40553,_40511,_40587),
    not_look_ahead(w(nb(_40253,_40255)),_40611,_40587,_40645),
    not_look_ahead_lit([en,et,den,det,han,hun,vi],_40669,_40645,_40703),
    negation0(_40291,_40727,_40703,_40761),
    ind_object(_40295,_40217::_40129,_40785,_40761,_40823),
    negation0(_40307,_40853,_40823,_40887),
    not_look_ahead([så],_40911,_40887,_40945),
    {bigno(_40291,_40307,_40115)},
    object(_40331,_40217::_40131,_40983,_40945,_41021),
    {dtv_template(_40111,_40113,_40295,_40331,_40117,_40209)},
    optional([til],_41065,_41021,_41129),
    someevent00(_40117,_40209,_40123::_40217,_41153,_41129,_40417).

vp_kernel(notify,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40339,_40437,!,_40505,_40553,{},_40679],_40287,_40291) --> 
    hlexv(tv,notify,_40183,_40185,_40115,_40339,_40287,_40389),
    look_ahead(w(nb(_40199,_40201)),_40437,_40389,_40471),
    !,
    accept(_40505,_40471,_40535),
    lock(exact,_40535,_40593),pushstack(exact,[meg],nil,_40593,_40605),np0_accept(_40215,_40175::_40125,_40553,_40605,_40583),unlock(_40583,_40585),
    {tv_template(notify,_40113,_40215,_40117,_40167)},
    someevent00(_40117,_40167,_40123::_40175,_40679,_40585,_40291).

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40351,_40449,_40497,_40575,!,_40663,{},_40725,[]],_40299,_40303) --> 
    lexvaccept(tv,_40111,_40195,fin,_40115,_40351,_40299,_40401),
    redundant0(_40449,_40401,_40479),
    adverbx(_40183,_40185,_40187,_40497,_40479,_40539),
    object2(_40113,_40213,_40219::_40125,_40575,_40539,_40617),
    !,
    accept(_40663,_40617,_40693),
    {tv_template(_40111,_40113,_40213,_40117,_40237)},
    someevent00(_40117,_40237,_40123::_40219,_40725,_40693,_40767),
    pushstack(free,adverbx(_40183,_40185,_40187),nil,_40767,_40303),
    [].

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40441,_40539,_40597,{},{},{},{},{},!,_40755,{},_40817],_40389,_40393) --> 
    hlexv(tv,_40111,_40213,_40215,_40115,_40441,_40389,_40491),
    not_look_ahead_lit([om,hver],_40539,_40491,_40573),
    object2(_40113,_40235,_40205::_40125,_40597,_40573,_40639),
    {\+constrain(_40235,date);_40111==have},
    {\+constrain(_40235,distance)},
    {\+constrain(_40235,minute)},
    {\+constrain(_40235,hour)},
    {\+constrain(_40235,clock)},
    !,
    accept(_40755,_40639,_40785),
    {tv_template(_40111,_40113,_40235,_40117,_40197)},
    someevent00(_40117,_40197,_40123::_40205,_40817,_40785,_40393).

vp_kernel(_40111,_40113,_40115,_40117,_40119,[vp_kernel,_40329,_40427,{},{},!,_40533,_40581,_40629,_40687],_40277,_40281) --> 
    hlexv(iv,_40111,_40183,fin,_40115,_40329,_40277,_40379),
    gmem(_40111,[run,pass],_40427,_40379,_40465),
    {iv_template(_40111,_40113,_40117,_40173)},
    {_40183\==imp},
    !,
    redundants0(_40533,_40465,_40563),
    it0(_40581,_40563,_40611),
    reflexiv0(_40111,_40629,_40611,_40663),
    someevent00(_40117,_40173,_40119,_40687,_40663,_40281).

vp_kernel(have,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40415,_40473,_40521,{},_40593,lit(om),_40673,!,_40741,{},_40841],_40363,_40367) --> 
    negation0(_40203,_40415,_40363,_40449),
    has(_40473,_40449,_40503),
    negation0(_40207,_40521,_40503,_40555),
    {bigno(_40203,_40207,_40115)},
    w(noun(information,sin,u,n),_40593,_40555,_40627),
    cc(om,_40627,_40671),
    not_look_ahead_lit([når,å,at],_40673,_40671,_40707),
    !,
    pushstack(first,(w(noun(information,sin,u,n)),w(prep(regarding))),nil,_40707,_40767),np1(_40277,_40199::_40125,_40741,_40767,_40797),
    {tv_template(have,_40113,_40277,_40117,_40191)},
    someevent00(_40117,_40191,_40123::_40199,_40841,_40797,_40367).

vp_kernel(have,_40113,_40115,_40117,_40119,[vp_kernel,_40305,_40363,_40411,{},!,_40493],_40253,_40257) --> 
    negation0(_40115,_40305,_40253,_40339),
    has(_40363,_40339,_40393),
    w(adj2(_40163,nil),_40411,_40393,_40445),
    {testmember(_40163,[open,closed])},
    !,
    pushstack(first,w(adj2(_40163,nil)),nil,_40445,_40513),
    be_complement(_40113,_40117,_40119,_40493,_40513,_40257).

vp_kernel(have,_40113,_40115,_40117,_40119,[vp_kernel,_40305,lit(det),_40375,_40433,_40491,!,_40589],_40253,_40257) --> 
    has(_40305,_40253,_40335),
    cc(det,_40335,_40373),
    negation0(_40115,_40375,_40373,_40409),
    w(adj2(_40169,nil),_40433,_40409,_40467),
    optional([da],_40491,_40467,_40555),
    !,
    pushstack(first,w(adj2(_40169,nil)),nil,_40555,_40609),
    be_complement(_40113,_40117,_40119,_40589,_40609,_40257).

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40443,_40501,_40559,_40657,{},{},_40743,_40801,_40859,_40907,!,_40995,{},_41057,_41135],_40391,_40395) --> 
    not_look_ahead(w(verb(have,_40229,_40231)),_40443,_40391,_40477),
    not_look_ahead(w(verb(be2,_40245,_40247)),_40501,_40477,_40535),
    hlexv(tv,_40111,_40255,_40257,_40213,_40559,_40535,_40609),
    not_look_ahead(w(prep(_40271)),_40657,_40609,_40691),
    {_40111\==have},
    {_40111\==be2},
    reflexiv0(_40111,_40743,_40691,_40777),
    particle0(_40111,_40801,_40777,_40835),
    redundant0(_40859,_40835,_40889),
    object2(_40113,_40305,_40311::_40125,_40907,_40889,_40949),
    !,
    accept(_40995,_40949,_41025),
    {tv_template(_40111,_40113,_40305,_40117,_40329)},
    someevent00(_40117,_40329,_40123::_40311,_41057,_41025,_41099),
    negation2(_40213,_40115,_41135,_41099,_40395).

menbare([menbare,lit(men)],_40139,_40143) --> 
    cc(men,_40139,_40143).

menbare([menbare,lit(bare)],_40139,_40143) --> 
    cc(bare,_40139,_40143).

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40463,_40521,_40579,{},{},{},_40719,_40797,_40855,{},_40947,_41025,[]],_40411,_40415) --> 
    not_look_ahead(w(verb(have,_40223,_40225)),_40463,_40411,_40497),
    not_look_ahead(w(verb(be2,_40239,_40241)),_40521,_40497,_40555),
    hlexv(tv,_40111,_40249,_40251,_40253,_40579,_40555,_40629),
    {_40111\==have},
    {_40111\==be2},
    {\+verbtype(_40111,iv)},
    adverb(_40207,_40209,pre,_40719,_40629,_40761),
    not_look_ahead(w(noun(night,_40309,_40311,_40313)),_40797,_40761,_40831),
    object2(_40113,_40319,_40325::_40125,_40855,_40831,_40897),
    {tv_template(_40111,_40113,_40319,_40117,_40343)},
    someevent00(_40117,_40343,_40123::_40325,_40947,_40897,_40989),
    negation2(_40253,_40115,_41025,_40989,_41063),
    pushstack(free,xadverb(_40207,_40209),nil,_41063,_40415),
    [].

vp_kernel(be1,_40113,_40115,_40117,_40119,[vp_kernel,_40323,_40371,_40429,{},{},_40515,[]],_40271,_40275) --> 
    be(_40323,_40271,_40353),
    negation0(_40115,_40371,_40353,_40405),
    look_ahead(w(noun(_40185,_40187,_40189,_40191)),_40429,_40405,_40463),
    {subclass0(_40185,time)},
    {iv_template(be1,_40113,_40117,_40215)},
    someevent00(_40117,_40215,_40119,_40515,_40463,_40557),
    pushstack(free,w(prep(on)),nil,_40557,_40275),
    [].

vp_kernel(be1,_40113,id,_40117,_40119,[vp_kernel,_40327,{},_40389,{},{},_40475,[]],_40275,_40279) --> 
    be(_40327,_40275,_40357),
    {vartypeid(_40113,self)},
    look_ahead(w(name(_40191,n,_40195)),_40389,_40357,_40423),
    {subclass0(_40195,place)},
    {iv_template(be1,_40113,_40117,_40219)},
    someevent00(_40117,_40219,_40119,_40475,_40423,_40517),
    pushstack(free,w(prep(in)),nil,_40517,_40279),
    [].

vp_kernel(be1,_40113,_40115,_40117,_40119,[vp_kernel,_40275,_40323,_40381,{},_40443,_40491],_40223,_40227) --> 
    be(_40275,_40223,_40305),
    negation0(_40115,_40323,_40305,_40357),
    not_look_ahead_np(_40381,_40357,_40411),
    {iv_template(be1,_40113,_40117,_40155)},
    redundant0(_40443,_40411,_40473),
    someevent00(_40117,_40155,_40119,_40491,_40473,_40227).

vp_kernel(be1,_40113,_40115,_40117,_40119,[vp_kernel,_40315,_40363,_40421,{},!,{},_40517],_40263,_40267) --> 
    be(_40315,_40263,_40345),
    negation0(_40115,_40363,_40345,_40397),
    look_ahead(w(adv(_40179)),_40421,_40397,_40455),
    {testmember(_40179,[redundantly,inside,outside])},
    !,
    {iv_template(be1,_40113,_40117,_40161)},
    someevent00(_40117,_40161,_40119,_40517,_40455,_40267).

vp_kernel(be1,_40113,_40115,_40117,_40119,[vp_kernel,_40311,_40359,_40417,{},{},_40503,_40551],_40259,_40263) --> 
    be(_40311,_40259,_40341),
    negation0(_40115,_40359,_40341,_40393),
    look_ahead([_40173],_40417,_40393,_40451),
    {testmember(_40173,[her,der,overalt])},
    {iv_template(be1,_40113,_40117,_40161)},
    redundant0(_40503,_40451,_40533),
    someevent00(_40117,_40161,_40119,_40551,_40533,_40263).

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40403,{},_40475,_40533,_40601,_40659,_40707,_40765,{},_40857,_40935,!,_41013],_40351,_40355) --> 
    w(verb(_40205,_40207,fin),_40403,_40351,_40437),
    {testmember(_40205,[have])},
    negation0(_40227,_40475,_40437,_40509),
    particlev2(_40205,_40111,_40533,_40509,_40571),
    reflexiv0(_40111,_40601,_40571,_40635),
    redundant0(_40659,_40635,_40689),
    not_look_ahead(w(verb(_40249,past,part)),_40707,_40689,_40741),
    object2(_40113,_40259,_40265::_40125,_40765,_40741,_40807),
    {tv_template(_40111,_40113,_40259,_40117,_40283)},
    someevent00(_40117,_40283,_40123::_40265,_40857,_40807,_40899),
    negation2(_40227,_40115,_40935,_40899,_40973),
    !,
    accept(_41013,_40973,_40355).

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40425,{},!,_40537,_40595,_40693,_40751,_40799,{},_40891,!,_40979,[]],_40373,_40377) --> 
    lexv(tv,_40111,_40235,_40237,_40425,_40373,_40471),
    {testmember(_40111,[lay])},
    !,
    negation0(_40115,_40537,_40471,_40571),
    verb_mod1(_40111,_40215,_40117,_40219,_40225::_40227,_40595,_40571,_40645),
    particle(_40111,_40693,_40645,_40727),
    redundant0(_40751,_40727,_40781),
    object2(_40113,_40283,_40289::_40125,_40799,_40781,_40841),
    {tv_template(_40111,_40113,_40283,_40117,_40307)},
    someevent00(_40117,_40307,_40123::_40289,_40891,_40841,_40933),
    !,
    accept(_40979,_40933,_41009),
    pushstack(free,(particle(_40111),verb_mod1(_40111,_40215,_40117,_40219,_40225::_40227)),nil,_41009,_40377),
    [].

vp_kernel(evah,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40303,_40391,_40449,{},_40541],_40251,_40255) --> 
    lexv(tv,evah,_40171,fin,_40303,_40251,_40349),
    negation0(_40115,_40391,_40349,_40425),
    subject2(_40113,_40183,_40189::_40155,_40449,_40425,_40491),
    {has_template(_40183,_40113,_40189)},
    someevent00(_40117,_40155,_40123::_40125,_40541,_40491,_40255).

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40125,[vp_kernel,_40361,{},_40473,{},_40545,_40593,{},_40685,_40763],_40309,_40313) --> 
    hlexv(tv,_40111,_40187,_40189,_40177,_40361,_40309,_40411),
    {_40111==be2},
    reflexiv0(_40111,_40473,_40411,_40507),
    {compliancetest2(tv,_40111,_40113)},
    redundant0(_40545,_40507,_40575),
    object2(_40113,_40223,_40229::_40125,_40593,_40575,_40635),
    {tv_template(_40111,_40113,_40223,_40117,_40247)},
    someevent00(_40117,_40247,_40123::_40229,_40685,_40635,_40727),
    negation2(_40177,_40115,_40763,_40727,_40313).

vp_kernel(_40111,_40113,_40115,_40117,_40119,[vp_kernel,_40303,{},{},_40429,_40477,_40525,_40583],_40251,_40255) --> 
    hlexv(iv,_40111,_40171,fin,_40115,_40303,_40251,_40353),
    {iv_template(_40111,_40113,_40117,_40161)},
    {_40171\==imp},
    redundants0(_40429,_40353,_40459),
    it0(_40477,_40459,_40507),
    reflexiv0(_40111,_40525,_40507,_40559),
    someevent00(_40117,_40161,_40119,_40583,_40559,_40255).

vp_kernel(_40111,_40113,_40115,_40117,_40123::_40125,[vp_kernel,{},_40401,lit(_40207),{},_40495,!,_40563,_40699,_40767],_40335,_40339) --> 
    {constrain(_40113,person)},
    not_look_ahead([kan],_40401,_40335,_40435),
    cc(_40207,_40435,_40479),
    {testmember(_40207,[må,skal,vil])},
    not_look_ahead(w(verb(_40243,_40245,_40247)),_40495,_40479,_40529),
    !,
    pushstack(first,w(verb(arrive,pres,fin)),nil,_40529,_40589),intrans_verb(_40111,_40113,_40273,_40117,_40179,_40279,_40281,_40563,_40589,_40639),
    negation2(_40273,_40115,_40699,_40639,_40737),
    someevent00(_40117,_40179,_40123::_40125,_40767,_40737,_40339).

worldcomp(_40111,_40113,event/_40111/_40113::_40117,_40117,[worldcomp,[]],_40179,_40179) --> 
    [].

realcomp(_40111,event/real/_40111::_40115,_40115,[realcomp,[]],_40173,_40173) --> 
    [].

someevent00(_40111,_40113,_40119::exists(_40111:event)::_40113 and _40119,[someevent00,[]],_40183,_40183) --> 
    [].

thatto0(_40111,that,_40115,[thatto0,_40217,!,[]],_40177,_40181) --> 
    infinitive(_40217,_40177,_40247),
    !,
    pushstack(free,npgap(_40115),nil,_40247,_40181),
    [].

thatto0(_40111,_40113,_40115,[thatto0,_40215,!,_40283],_40175,_40179) --> 
    w(prep(on),_40215,_40175,_40249),
    !,
    reject(_40283,_40249,_40179).

thatto0(_40111,_40113,_40115,[thatto0,lit(om),_40255,!,_40323],_40193,_40197) --> 
    cc(om,_40193,_40253),
    look_ahead(w(name(_40149,_40151,_40153)),_40255,_40253,_40289),
    !,
    reject(_40323,_40289,_40197).

thatto0(_40111,_40113,_40115,[thatto0,lit(om),_40257,!,_40325],_40195,_40199) --> 
    cc(om,_40195,_40255),
    look_ahead(w(noun(departure,_40151,_40153,n)),_40257,_40255,_40291),
    !,
    reject(_40325,_40291,_40199).

that0(_40111,that,[that0,lit(på),!,_40231],_40165,_40169) --> 
    cc(på,_40165,_40219),
    !,
    reject(_40231,_40219,_40169).

that0(_40111,when,[that0,_40313,lit(når),_40403,_40461,!,_40539,[],!,_40705],_40279,_40283) --> 
    gmem(_40111,[know,know1,think,ask,notify,tell],_40313,_40279,_40351),
    cc(når,_40351,_40401),
    w(verb(_40203,_40205,fin),_40403,_40401,_40437),
    np1(_40211,_40213,_40461,_40437,_40499),
    !,
    accept(_40539,_40499,_40569),
    pushstack(free,(xnp(_40211,_40213),w(verb(_40203,_40205,fin))),nil,_40569,_40693),[],
    !,
    accept(_40705,_40693,_40283).

that0(ask,that,[that0,_40199],_40165,_40169) --> 
    look_ahead(w(verb(_40125,inf,_40129)),_40199,_40165,_40169).

that0(answer,whether,[that0,_40193,lit(om)],_40159,_40163) --> 
    on0(_40193,_40159,_40223),
    cc(om,_40223,_40163).

that0(ask,that,[that0,lit(om),_40227,!,_40285],_40171,_40175) --> 
    cc(om,_40171,_40225),
    infinitive(_40227,_40225,_40257),
    !,
    accept(_40285,_40257,_40175).

that0(ask,whether,[that0,lit(om),!,_40231],_40165,_40169) --> 
    cc(om,_40165,_40219),
    !,
    accept(_40231,_40219,_40169).

that0(ask,that,[that0,_40195,!,_40253],_40161,_40165) --> 
    infinitive(_40195,_40161,_40225),
    !,
    accept(_40253,_40225,_40165).

that0(believe,that,[that0,lit(at),!],_40159,_40163) --> 
    cc(at,_40159,_40163),
    !.

that0(believe,that,[that0,[]],_40149,_40149) --> 
    [].

that0(know,whether,[that0,lit(om),!],_40159,_40163) --> 
    cc(om,_40159,_40163),
    !.

that0(know,that,[that0,lit(at),!],_40159,_40163) --> 
    cc(at,_40159,_40163),
    !.

that0(know,that,[that0,_40215,_40273],_40181,_40185) --> 
    not_look_ahead([en],_40215,_40181,_40249),
    not_look_ahead(w(noun(_40131,_40133,_40135,_40137)),_40273,_40249,_40185).

that0(know1,whether,[that0,lit(om),!],_40159,_40163) --> 
    cc(om,_40159,_40163),
    !.

that0(know1,that,[that0,lit(at),!],_40159,_40163) --> 
    cc(at,_40159,_40163),
    !.

that0(know1,that,[that0,_40215,_40273],_40181,_40185) --> 
    not_look_ahead([en],_40215,_40181,_40249),
    not_look_ahead(w(noun(_40131,_40133,_40135,_40137)),_40273,_40249,_40185).

that0(let,that,[that0,[]],_40149,_40149) --> 
    [].

that0(mean,that,[that0,lit(at),!],_40159,_40163) --> 
    cc(at,_40159,_40163),
    !.

that0(mean,that,[that0,[]],_40149,_40149) --> 
    [].

that0(notify,that,[that0,lit(at)],_40153,_40157) --> 
    cc(at,_40153,_40157).

that0(notify,that,[that0,lit(om),lit(at),!,_40263],_40175,_40179) --> 
    cc(om,_40175,_40229),
    cc(at,_40229,_40251),
    !,
    accept(_40263,_40251,_40179).

that0(notify,_40113,[that0,lit(om),!,_40231],_40165,_40169) --> 
    cc(om,_40165,_40219),
    !,
    reject(_40231,_40219,_40169).

that0(say,that,[that0,lit(at),!],_40159,_40163) --> 
    cc(at,_40159,_40163),
    !.

that0(say,that,[that0,[]],_40149,_40149) --> 
    [].

that0(tell,that,[that0,_40203,!,_40271],_40169,_40173) --> 
    look_ahead([et],_40203,_40169,_40237),
    !,
    reject(_40271,_40237,_40173).

that0(tell,that,[that0,_40203,!,_40271],_40169,_40173) --> 
    look_ahead([en],_40203,_40169,_40237),
    !,
    reject(_40271,_40237,_40173).

that0(tell,that,[that0,lit(at),!],_40159,_40163) --> 
    cc(at,_40159,_40163),
    !.

that0(think,that,[that0,lit(at),!],_40159,_40163) --> 
    cc(at,_40159,_40163),
    !.

that0(think,that,[that0,[]],_40149,_40149) --> 
    [].

that0(understand,how,[that0,lit(hvordan)],_40153,_40157) --> 
    cc(hvordan,_40153,_40157).

that0(want,that,[that0,lit(at),!],_40159,_40163) --> 
    cc(at,_40159,_40163),
    !.

that0(want,to,[that0,lit(og)],_40153,_40157) --> 
    cc(og,_40153,_40157).

that0(wish,that,[that0,_40199],_40165,_40169) --> 
    look_ahead(w(verb(_40125,_40127,_40129)),_40199,_40165,_40169).

that0(_40111,_40113,[that0,_40223,!,_40291,_40349],_40189,_40193) --> 
    that(_40113,_40223,_40189,_40257),
    !,
    not_look_ahead(w(noun(departure,_40149,_40151,_40153)),_40291,_40257,_40325),
    accept(_40349,_40325,_40193).

rep_modifiers0(_40111,_40113,_40115,_40117,_40119,[rep_modifiers0,lit(hvor),!,_40267],_40183,_40187) --> 
    cc(hvor,_40183,_40255),
    !,
    reject(_40267,_40255,_40187).

rep_modifiers0(_40111,_40113,_40115,_40117,_40119,[rep_modifiers0,lit(hva),!,_40267],_40183,_40187) --> 
    cc(hva,_40183,_40255),
    !,
    reject(_40267,_40255,_40187).

rep_modifiers0(_40111,_40113,_40115,_40117,_40119,[rep_modifiers0,{},_40303,{},_40375],_40237,_40241) --> 
    {testmember(_40111,[see])},
    look_ahead(w(prep(_40175)),_40303,_40237,_40337),
    {testmember(_40175,[in])},
    verb_modifier(_40111,_40113,_40115,_40117,_40119,_40375,_40337,_40241).

rep_modifiers0(_40111,_40113,_40115,_40117,_40119,[rep_modifiers0,{},_40289,_40347],_40223,_40227) --> 
    {testmember(_40111,[say,tell])},
    prep1(to,_40289,_40223,_40323),
    pushstack(first,prep(to),nil,_40323,_40445),
    verb_modifiers(_40111,_40113,_40115,_40117,_40119,_40347,_40445,_40227).

rep_modifiers0(_40111,_40113,_40115,_40117,_40117,[rep_modifiers0,[]],_40167,_40167) --> 
    [].

be_complements(_40111,_40113,_40119::_40125 and _40127,[be_complements,lit(at),_40303,!,_40371,_40419,{}],_40241,_40245) --> 
    cc(at,_40241,_40301),
    look_ahead(w(prep(_40189)),_40303,_40301,_40337),
    !,
    preadverbials(_40371,_40337,_40401),
    clausal_object2(_40167,_40119::_40127,_40419,_40401,_40245),
    {bealign(_40111,_40167,_40113,_40127,_40125)}.

be_complements(_40111,_40113,_40119::_40125 and _40127,[be_complements,lit(at),!,_40295,_40343,{}],_40223,_40227) --> 
    cc(at,_40223,_40283),
    !,
    accept(_40295,_40283,_40325),
    clausal_object1(_40161,_40119::_40127,_40343,_40325,_40227),
    {bealign(_40111,_40161,_40113,_40127,_40125)}.

be_complements(_40111,_40113,_40119::_40125 and _40127,[be_complements,lit(å),!,_40301,_40349,{}],_40229,_40233) --> 
    cc(å,_40229,_40289),
    !,
    accept(_40301,_40289,_40331),
    pushstack(first,someone,nil,_40331,_40449),clausal_object1(_40161,_40119::_40127,_40349,_40449,_40233),
    {bealign(_40111,_40161,_40113,_40127,_40125)}.

be_complements(_40111,_40113,_40115,[be_complements,_40231,_40309],_40191,_40195) --> 
    be_complement(_40111,_40113,_40143::_40145,_40231,_40191,_40273),
    be_complements20(_40111,_40113,_40143::_40145,_40115,_40309,_40273,_40195).

be_complements20(_40111,_40113,_40121::_40127,_40121::_40127 or _40129,[be_complements20,lit(eller),_40323,!,_40391,_40469],_40255,_40259) --> 
    cc(eller,_40255,_40321),
    not_look_ahead_lit(['.',?],_40323,_40321,_40357),
    !,
    be_complement(_40111,_40113,_40121::_40205,_40391,_40357,_40433),
    be_complements20(_40111,_40113,_40121::_40205,_40121::_40129,_40469,_40433,_40259).

be_complements20(_40111,_40113,_40121::_40127,_40121::_40127 and _40129,[be_complements20,_40261,_40309,_40387],_40215,_40219) --> 
    be_compl_conjunction(_40261,_40215,_40291),
    be_pred(_40111,_40113,_40155,_40309,_40291,_40351),
    be_complements20(_40111,_40113,_40155,_40121::_40129,_40387,_40351,_40219).

be_complements20(_40111,_40113,_40115,_40115,[be_complements20,_40207],_40161,_40165) --> 
    redundant0(_40207,_40161,_40165).

be_compl_conjunction([be_compl_conjunction,lit(og),!],_40145,_40149) --> 
    cc(og,_40145,_40149),
    !.

be_compl_conjunction([be_compl_conjunction,lit(men),_40211,!],_40167,_40171) --> 
    cc(men,_40167,_40209),
    look_ahead(w(verb(_40135,past,part)),_40211,_40209,_40171),
    !.

be_complement(_40111,_40113,_40115,[be_complement,_40221,_40279],_40181,_40185) --> 
    not_look_ahead_lit([der,her],_40221,_40181,_40255),
    be_pred(_40111,_40113,_40115,_40279,_40255,_40185).

be_complement(_40111,_40113,_40115,[be_complement,_40221,_40279],_40181,_40185) --> 
    not_look_ahead_lit([der,her],_40221,_40181,_40255),
    be_noun(_40111,_40113,_40115,_40279,_40255,_40185).

be_pred(_40111,_40113,_40115,[be_pred,_40269,{},_40371,_40419],_40229,_40233) --> 
    ap(_40149,_40111,_40113,_40143,_40269,_40229,_40315),
    {\+testmember(_40149,[true,whole])},
    not_look_ahead_nounx(_40371,_40315,_40401),
    verb_modifiers0(adj/nil/_40149,_40111,_40113,_40143,_40115,_40419,_40401,_40233).

be_pred(_40111,_40113,_40115,[be_pred,_40243,_40301,{}],_40203,_40207) --> 
    look_ahead(w(prep(_40151)),_40243,_40203,_40277),
    verb_mod1(be1,_40111,_40113,_40135,_40137,_40301,_40277,_40207),
    {thenwhat(_40135,_40137,_40115)}.

be_pred(_40111,_40113,_40115,[be_pred,_40377,_40435,_40493,{},_40565,_40697],_40337,_40341) --> 
    w(nb(_40185,num),_40377,_40337,_40411),
    w(noun(percent,_40173,u,n),_40435,_40411,_40469),
    w(adj2(_40209,nil),_40493,_40469,_40527),
    {testmember(_40209,[certain,safe])},
    lock(exact,_40527,_40605),pushstack(exact,w(adj2(_40209,nil)),nil,_40605,_40617),ap(_40209,_40111,_40113,_40255,_40565,_40617,_40595),unlock(_40595,_40597),
    pushstack(first,(w(prep(with)),w(nb(_40185,num)),w(noun(percent,_40173,u,n))),nil,_40597,_40717),
    verb_modifiers0(adj/nil/_40209,_40111,_40113,_40255,_40115,_40697,_40717,_40341).

be_pred(_40111,_40113,_40115,[be_pred,_40363,_40411,_40459,!,_40527,{},_40599,_40731],_40323,_40327) --> 
    ofte0(_40363,_40323,_40393),
    mangenoen(_40411,_40393,_40441),
    w(noun(minute,_40193,u,n),_40459,_40441,_40493),
    !,
    w(adj2(_40205,nil),_40527,_40493,_40561),
    {testmember(_40205,[delayed,tooearly])},
    lock(exact,_40561,_40639),pushstack(exact,w(adj2(_40205,nil)),nil,_40639,_40651),ap(_40205,_40111,_40113,_40251,_40599,_40651,_40629),unlock(_40629,_40631),
    pushstack(first,(w(prep(with)),w(noun(minute,plu,u,n))),nil,_40631,_40751),
    verb_modifiers0(adj/nil/_40205,_40111,_40113,_40251,_40115,_40731,_40751,_40327).

ofte0([ofte0,lit(ofte)],_40139,_40143) --> 
    cc(ofte,_40139,_40143).

ofte0([ofte0,[]],_40135,_40135) --> 
    [].

mangenoen([mangenoen,lit(mange)],_40139,_40143) --> 
    cc(mange,_40139,_40143).

mangenoen([mangenoen,lit(flere)],_40139,_40143) --> 
    cc(flere,_40139,_40143).

mangenoen([mangenoen,lit(noen)],_40139,_40143) --> 
    cc(noen,_40139,_40143).

be_pred(_40111,_40113,_40115,[be_pred,_40377,_40435,_40493,{},_40565,_40697],_40337,_40341) --> 
    w(nb(_40185,num),_40377,_40337,_40411),
    w(noun(minute,_40173,u,n),_40435,_40411,_40469),
    w(adj2(_40209,nil),_40493,_40469,_40527),
    {testmember(_40209,[delayed,tooearly])},
    lock(exact,_40527,_40605),pushstack(exact,w(adj2(_40209,nil)),nil,_40605,_40617),ap(_40209,_40111,_40113,_40255,_40565,_40617,_40595),unlock(_40595,_40597),
    pushstack(first,(w(prep(with)),w(nb(_40185,num)),w(noun(minute,_40173,u,n))),nil,_40597,_40717),
    verb_modifiers0(adj/nil/_40209,_40111,_40113,_40255,_40115,_40697,_40717,_40341).

be_pred(_40111,_40113,_40115,[be_pred,lit(mer),_40297,_40355,_40487],_40235,_40239) --> 
    cc(mer,_40235,_40295),
    look_ahead([enn],_40297,_40295,_40331),
    lock(exact,_40331,_40395),pushstack(exact,w(adj2(great,nil)),nil,_40395,_40407),ap(_40177,_40111,_40113,_40143,_40355,_40407,_40385),unlock(_40385,_40387),
    verb_modifiers0(adj/nil/_40177,_40111,_40113,_40143,_40115,_40487,_40387,_40239).

be_pred(_40111,_40113,_40119::_40121,[be_pred,_40215],_40175,_40179) --> 
    passive(_40111,_40113,_40119::_40121,_40215,_40175,_40179).

be_pred(_40111,_40113,_40115,[be_pred,_40217,_40295],_40177,_40181) --> 
    comparisons(_40111,_40113,_40127,_40217,_40177,_40259),
    someevent00(_40113,_40127,_40115,_40295,_40259,_40181).

be_pred(_40111,_40113,_40119::_40121,[be_pred,_40243,_40291],_40203,_40207) --> 
    sure(_40243,_40203,_40273),
    pushstack(first,w(verb(know,pres,fin)),nil,_40273,_40311),
    do_phrase(know,_40111,id,_40113,_40119::_40121,_40291,_40311,_40207).

be_pred(_40111,_40113,_40115,[be_pred,_40291,_40379,{},_40451],_40251,_40255) --> 
    ap(_40151,_40111,_40113,_40157,_40291,_40251,_40337),
    look_ahead([hva],_40379,_40337,_40413),
    {\+testmember(_40151,[true,whole])},
    pushstack(first,w(prep(on)),nil,_40413,_40471),
    verb_modifiers0(adj/nil/_40151,_40111,_40113,_40157,_40115,_40451,_40471,_40255).

fordent0(_40111,[fordent0,_40181,!],_40153,_40157) --> 
    gradverb(_40111,_40181,_40153,_40157),
    !.

fordent0(nil,[fordent0,_40171],_40143,_40147) --> 
    dent0(_40171,_40143,_40147).

not_look_ahead_nounx([not_look_ahead_nounx,_40181,!],_40159,_40163) --> 
    look_ahead(w(noun(clock,sin,def,n)),_40181,_40159,_40163),
    !.

not_look_ahead_nounx([not_look_ahead_nounx,_40175],_40153,_40157) --> 
    not_look_ahead(w(noun(_40119,_40121,_40123,_40125)),_40175,_40153,_40157).

be_noun(_40111,_40113,_40119::exists(_40113:event)::_40127,[be_noun,lit(at),_40289,{},!],_40227,_40231) --> 
    cc(at,_40227,_40287),
    clausal_object1(_40163,_40119::_40171,_40289,_40287,_40231),
    {bealign(_40111,_40163,_40113,_40171,_40127)},
    !.

be_noun(_40111,_40113,_40119::exists(_40113:event)::_40127,[be_noun,_40327,_40385,{},!,_40495],_40287,_40291) --> 
    look_ahead(w(nb(_40191,_40193)),_40327,_40287,_40361),
    pushstack(first,w(noun(clock,sin,def,n)),nil,_40361,_40411),obviousclock(_40217,_40223::_40225,_40385,_40411,_40441),
    {bealign(_40111,_40217,_40113,_40225,_40241)},
    !,
    verb_modifiers0(exist,_40111,_40113,_40223::_40241,_40119::_40127,_40495,_40441,_40291).

be_noun(_40111,_40113,_40119::exists(_40113:event)::_40127,[be_noun,_40307,_40355,{},_40437,!,_40535],_40267,_40271) --> 
    redundant0(_40307,_40267,_40337),
    object(_40189,_40195::_40197,_40355,_40337,_40393),
    {bealign(_40111,_40189,_40113,_40197,_40213)},
    optional([bare],_40437,_40393,_40501),
    !,
    verb_modifiers0(exist,_40111,_40113,_40195::_40213,_40119::_40127,_40535,_40501,_40271).

ap(_40111,_40113,_40115,_40117,[ap,_40243,_40291,_40379,_40427],_40197,_40201) --> 
    mthe10(_40243,_40197,_40273),
    adj1s(_40111,_40113,_40115,_40141,_40291,_40273,_40337),
    redundant0(_40379,_40337,_40409),
    someevent00(_40115,_40141,_40117,_40427,_40409,_40201).

ap(_40111,_40113,_40115,_40117,[ap,_40289,{},{},_40375],_40243,_40247) --> 
    w(verb(_40111,past,part),_40289,_40243,_40323),
    {\+testmember(_40111,[be,have])},
    {adj_template(nil,be/_40111,_40113,_40115,_40141)},
    someevent00(_40115,_40141,_40117,_40375,_40323,_40247).

mthe10([mthe10,lit(mye)],_40139,_40143) --> 
    cc(mye,_40139,_40143).

mthe10([mthe10,_40157],_40135,_40139) --> 
    the0(_40157,_40135,_40139).

passive(_40111,_40113,_40115,[passive,_40377,_40435,_40503,{},_40605,!,_40683],_40337,_40341) --> 
    w(noun(_40189,sin,u,n),_40377,_40337,_40411),
    gmem(_40189,[video,camera],_40435,_40411,_40473),
    lexv(tv,_40229,_40231,part,_40503,_40473,_40549),
    {\+testmember(_40229,[be2,have])},
    whodidit(_40259,_40261,_40605,_40549,_40643),
    !,
    pushstack(first,(np(_40259,_40261),w(verb(_40229,_40231,fin)),npgap(_40111),w(prep(by)),w(noun(_40189,sin,u,n))),nil,_40643,_40861),
    state(_40113,_40115,_40683,_40861,_40341).

passive(_40111,_40113,_40115,[passive,_40331,{},_40433,_40491,!,_40569],_40291,_40295) --> 
    lexv(dtv,_40173,past,part,_40331,_40291,_40377),
    {\+testmember(_40173,[be2,have,wish,want])},
    not_look_ahead(w(adj2(_40219,_40221)),_40433,_40377,_40467),
    whodidit(_40225,_40227,_40491,_40467,_40529),
    !,
    pushstack(first,(np(_40225,_40227),w(verb(_40173,past,fin)),npgap(_40111)),nil,_40529,_40747),
    state(_40113,_40115,_40569,_40747,_40295).

passive(_40111,_40113,_40115,[passive,_40355,{},_40457,_40515,_40583,!,_40661],_40315,_40319) --> 
    lexv(dtv,_40187,_40189,part,_40355,_40315,_40401),
    {\+testmember(_40187,[be2,have,wish,want])},
    not_look_ahead(w(adj2(_40233,_40235)),_40457,_40401,_40491),
    ind_object(_40179,_40181,_40515,_40491,_40553),
    whodidit(_40245,_40247,_40583,_40553,_40621),
    !,
    pushstack(free,(np(_40245,_40247),w(verb(_40187,_40189,fin)),npgap(_40111),noun_phrase1(_40179,_40181)),nil,_40621,_40919),
    state(_40113,_40115,_40661,_40919,_40319).

passive(_40111,_40113,_40119::_40121,[passive,_40311,lit(om),_40421,!,_40499],_40271,_40275) --> 
    lexv(tv,notify,past,part,_40311,_40271,_40357),
    cc(om,_40357,_40419),
    whodidit(_40191,_40193,_40421,_40419,_40459),
    !,
    lock(last,_40459,_40691),
    pushstack(last,(xnp(_40191,_40193),w(verb(notify,pres,fin)),w(prep(regarding)),npgap(_40111)),nil,_40691,_40703),
    state(_40113,_40119::_40121,_40499,_40703,_40681),
    unlock(_40681,_40275).

passive(_40111,_40113,_40115,[passive,_40337,!,_40425,{},_40527,!,_40605],_40297,_40301) --> 
    adverbial1(_40179,_40181,_40183,_40337,_40297,_40379),
    !,
    lexv(tv,_40197,_40199,part,_40425,_40379,_40471),
    {\+testmember(_40197,[be2,have])},
    whodidit(_40227,_40229,_40527,_40471,_40565),
    !,
    pushstack(first,(np(_40227,_40229),w(verb(_40197,_40199,fin)),npgap(_40111),adverbial1(_40179,_40181,_40183)),nil,_40565,_40865),
    state(_40113,_40115,_40605,_40865,_40301).

passive(_40111,_40113,_40115,[passive,_40321,{},_40423,_40491,_40539,!,_40617],_40281,_40285) --> 
    lexv(tv,_40179,_40181,part,_40321,_40281,_40367),
    {\+testmember(_40179,[be2,have])},
    particlev0(_40179,_40211,_40423,_40367,_40461),
    redundant0(_40491,_40461,_40521),
    whodidit(_40215,_40217,_40539,_40521,_40577),
    !,
    pushstack(first,(np(_40215,_40217),w(verb(_40211,_40181,fin)),npgap(_40111)),nil,_40577,_40795),
    state(_40113,_40115,_40617,_40795,_40285).

passive(_40111,_40113,_40115,[passive,_40399,{},_40501,lit(og),_40571,{},!,_40693,!,_40771],_40359,_40363) --> 
    lexv(tv,_40209,past,part,_40399,_40359,_40445),
    {\+testmember(_40209,[be2,have])},
    redundant0(_40501,_40445,_40531),
    cc(og,_40531,_40569),
    hlexv(tv,_40245,past,part,id,_40571,_40569,_40621),
    {\+testmember(_40209,[be2,have])},
    !,
    whodidit(_40277,_40279,_40693,_40621,_40731),
    !,
    pushstack(first,(np(_40277,_40279),w(verb(_40209,past,fin)),[og],w(verb(_40245,past,fin)),npgap(_40111)),nil,_40731,_40949),
    state(_40113,_40115,_40771,_40949,_40363).

whodidit(_40111,_40113,[whodidit,lit(av),lit(at),_40265,!,_40343],_40187,_40191) --> 
    cc(av,_40187,_40241),
    cc(at,_40241,_40263),
    clausal_object1(_40111,_40113,_40265,_40263,_40303),
    !,
    accept(_40343,_40303,_40191).

whodidit(_40111,_40113,[whodidit,_40201,!,_40259],_40167,_40171) --> 
    by(_40201,_40167,_40231),
    !,
    np(_40111,_40113,_40259,_40231,_40171).

whodidit(_40111,_40113,[whodidit,_40221,!,_40343],_40187,_40191) --> 
    lock(exact,_40187,_40261),pushstack(exact,w(noun(agent,sin,u,n)),nil,_40261,_40273),np1(_40111,_40113,_40221,_40273,_40251),unlock(_40251,_40253),
    !,
    accept(_40343,_40253,_40191).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40321,lit(det),lit(å),_40453,_40539,!,_40617],_40275,_40279) --> 
    lexv(tv,_40177,_40179,fin,_40321,_40275,_40367),
    cc(det,_40367,_40429),
    cc(å,_40429,_40451),
    pushstack(first,[noen],nil,_40451,_40479),clausal_object1(_40203,_40171,_40453,_40479,_40509),
    traceprint(4,qv0a,_40539,_40509,_40577),
    !,
    pushstack(first,(lexv(tv,_40177,_40179,fin),xnp(_40111,_40171)),nil,_40577,_40801),
    verb_phrase(_40203,_40113,_40115,_40117,_40617,_40801,_40279).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40431,{},{},_40547,_40615,_40673,_40731,{},_40813,_40871,_40919,!,_40997],_40385,_40389) --> 
    lexv(tv,_40229,_40231,fin,_40431,_40385,_40477),
    {_40229\==ask},
    {_40229\==have},
    subject(_40257,_40259,_40547,_40477,_40585),
    negation0(_40113,_40615,_40585,_40649),
    not_look_ahead([om],_40673,_40649,_40707),
    object(_40275,_40277,_40731,_40707,_40769),
    {subject_object_test(_40229,_40257,_40275)},
    w(prep(_40297),_40813,_40769,_40847),
    not_look_ahead_np(_40871,_40847,_40901),
    traceprint(4,qv0b,_40919,_40901,_40957),
    !,
    pushstack(first,(xnp(_40257,_40259),w(verb(_40229,pres,fin)),xnp(_40275,_40277),w(prep(_40297)),npgap(_40111)),nil,_40957,_41255),
    state(_40115,_40117,_40997,_41255,_40389).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40391,{},_40493,_40561,_40619,_40677,_40725,!,_40803,{},_40865],_40345,_40349) --> 
    lexv(iv,_40211,_40213,fin,_40391,_40345,_40437),
    {\+testmember(_40211,[think])},
    subject(_40237,_40239,_40493,_40437,_40531),
    negation0(_40113,_40561,_40531,_40595),
    w(prep(_40251),_40619,_40595,_40653),
    not_look_ahead_np(_40677,_40653,_40707),
    traceprint(4,qv1,_40725,_40707,_40763),
    !,
    accept(_40803,_40763,_40833),
    {adjustprepv(_40211,_40251,_40269)},
    pushstack(first,(xnp(_40237,_40239),w(verb(_40211,_40213,fin)),w(prep(_40269)),npgap(_40111)),nil,_40833,_41043),
    state(_40115,_40117,_40865,_41043,_40349).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40351,_40439,_40507,_40555,[],_40721,!,_40799],_40305,_40309) --> 
    lexv(rv,_40195,pres,fin,_40351,_40305,_40397),
    subject(_40203,_40205,_40439,_40397,_40477),
    infinitive(_40507,_40477,_40537),
    w(verb(do,inf,fin),_40555,_40537,_40589),
    pushstack(free,xnp(_40111,_40205),nil,_40589,_40719),[],
    traceprint(4,qv2,_40721,_40719,_40759),
    !,
    pushstack(first,(w(verb(_40195,pres,fin)),[å],w(verb(do,inf,fin))),nil,_40759,_40819),
    verb_phrase(_40203,_40113,_40115,_40117,_40799,_40819,_40309).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40349,_40437,_40505,_40573,_40621,!,[],_40807],_40303,_40307) --> 
    lexv(dtv,_40193,_40195,fin,_40349,_40303,_40395),
    subject(_40201,_40203,_40437,_40395,_40475),
    ind_object(_40207,_40209,_40505,_40475,_40543),
    omaa(_40573,_40543,_40603),
    traceprint(4,qv3,_40621,_40603,_40659),
    !,
    pushstack(free,xnp(_40111,_40203),nil,_40659,_40805),[],
    pushstack(first,(w(verb(_40193,_40195,fin)),xnp(_40207,_40209),[om],[å]),nil,_40805,_40907),
    verb_phrase(_40201,_40113,_40115,_40117,_40807,_40907,_40307).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40353,{},{},_40469,_40537,{},_40619,!,_40697],_40307,_40311) --> 
    lexv(tv,_40189,_40191,fin,_40353,_40307,_40399),
    {_40189\==ask},
    {_40189\==have},
    subject(_40217,_40183,_40469,_40399,_40507),
    particlev0(_40189,_40225,_40537,_40507,_40575),
    {subject_object_test(_40189,_40217,_40111)},
    traceprint(4,qv4,_40619,_40575,_40657),
    !,
    pushstack(first,(lexv(tv,_40225,_40191,fin),xnp(_40111,_40183)),nil,_40657,_40881),
    verb_phrase(_40217,_40113,_40115,_40117,_40697,_40881,_40311).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40381,_40429,_40487,_40555,_40643,{},{},_40729,!,_40807,{}],_40335,_40339) --> 
    aux1(_40381,_40335,_40411),
    negation0(_40185,_40429,_40411,_40463),
    subject(_40197,_40199,_40487,_40463,_40525),
    lexv(tv,_40205,inf,fin,_40555,_40525,_40601),
    not_look_ahead([om],_40643,_40601,_40677),
    {_40205\==have},
    {test(tv_template(_40205,_40197,_40111,_40115,_40247))},
    traceprint(4,qv5,_40729,_40677,_40767),
    !,
    pushstack(first,(lexv(tv,_40205,pres,fin),xnp(_40111,_40199)),nil,_40767,_40981),verb_phrase(_40197,_40187,_40115,_40117,_40807,_40981,_40339),
    {bigno(_40185,_40187,_40113)}.

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40361,_40409,_40477,_40535,_40593,_40651,!,_40729],_40315,_40319) --> 
    aux1(_40361,_40315,_40391),
    subject(_40193,_40189,_40409,_40391,_40447),
    w(verb(be,inf,fin),_40477,_40447,_40511),
    w(adj2(_40215,_40217),_40535,_40511,_40569),
    w(prep(_40225),_40593,_40569,_40627),
    traceprint(4,qv6,_40651,_40627,_40689),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_40215,_40217)),w(prep(_40225)),xnp(_40111,_40189)),nil,_40689,_40829),
    verb_phrase(_40193,_40113,_40115,_40117,_40729,_40829,_40319).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40319,lit(du),_40389,_40447,_40505,!,_40583],_40273,_40277) --> 
    has(_40319,_40273,_40349),
    cc(du,_40349,_40387),
    negation0(_40113,_40389,_40387,_40423),
    prepnom(_40185,_40447,_40423,_40481),
    traceprint(4,qv7,_40505,_40481,_40543),
    !,
    pushstack(first,([du],w(verb(have,pres,fin)),npgap(_40111),w(prep(_40185))),nil,_40543,_40681),
    state(_40115,_40117,_40583,_40681,_40277).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40361,_40409,_40477,_40535,_40593,!,_40671],_40315,_40319) --> 
    has(_40361,_40315,_40391),
    np1_accept(_40193,_40187::_40189,_40409,_40391,_40447),
    w(noun(_40209,_40211,_40213,n),_40477,_40447,_40511),
    prepnom(_40219,_40535,_40511,_40569),
    traceprint(4,qv8,_40593,_40569,_40631),
    !,
    pushstack(free,(w(verb(have,pres,fin)),w(noun(_40209,sin,u,n)),w(prep(_40219)),noun_phrase1(_40111,_40187::_40189)),nil,_40631,_40777),
    do_phrase(have,_40193,_40113,_40115,_40117,_40671,_40777,_40319).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40361,_40409,_40477,_40535,{},_40607,_40685,!,_40763],_40315,_40319) --> 
    has(_40361,_40315,_40391),
    subject(_40197,_40199,_40409,_40391,_40447),
    negation0(_40113,_40477,_40447,_40511),
    w(verb(_40211,_40213,part),_40535,_40511,_40569),
    {testmember(_40211,[go])},
    defaultprep(_40211,_40111,_40237,_40607,_40569,_40649),
    traceprint(4,qv9,_40685,_40649,_40723),
    !,
    pushstack(first,(xnp(_40197,_40199),w(verb(_40211,_40213,fin)),prep1(_40237),npgap(_40111)),nil,_40723,_41009),
    state(_40115,_40117,_40763,_41009,_40319).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40317,_40365,_40433,_40491,_40549,!,_40627],_40271,_40275) --> 
    has(_40317,_40271,_40347),
    subject(_40179,_40181,_40365,_40347,_40403),
    negation0(_40113,_40433,_40403,_40467),
    w(verb(_40193,past,part),_40491,_40467,_40525),
    traceprint(4,qv10,_40549,_40525,_40587),
    !,
    pushstack(first,(xnp(_40179,_40181),w(verb(_40193,past,fin)),npgap(_40111)),nil,_40587,_40805),
    state(_40115,_40117,_40627,_40805,_40275).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40311,_40359,_40427,_40485,_40543,!,_40621],_40265,_40269) --> 
    has(_40311,_40265,_40341),
    np1_accept(_40181,_40183,_40359,_40341,_40397),
    negation0(_40113,_40427,_40397,_40461),
    w(verb(_40173,_40175,part),_40485,_40461,_40519),
    traceprint(4,qv11,_40543,_40519,_40581),
    !,
    pushstack(first,(xnp(_40181,_40183),w(verb(_40173,_40175,fin))),nil,_40581,_40721),
    verb_phrase(_40111,id,_40115,_40117,_40621,_40721,_40269).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,lit(kan),_40345,_40413,_40481,_40539,!,_40617],_40277,_40281) --> 
    cc(kan,_40277,_40343),
    subject(_40179,_40171,_40345,_40343,_40383),
    negation2(id,_40113,_40413,_40383,_40451),
    not_look_ahead(w(verb(_40199,_40201,_40203)),_40481,_40451,_40515),
    traceprint(4,qv12,_40539,_40515,_40577),
    !,
    lock(last,_40577,_40731),
    pushstack(last,(w(verb(know1,pres,fin)),xnp(_40111,_40171)),nil,_40731,_40743),
    do_phrase(_40213,_40179,id,_40115,_40117,_40617,_40743,_40721),
    unlock(_40721,_40281).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40355,_40413,_40481,_40549,_40607,_40665,!,_40743],_40309,_40313) --> 
    w(verb(_40189,_40191,fin),_40355,_40309,_40389),
    gmem(_40189,[talk,speak],_40413,_40389,_40451),
    subject(_40211,_40213,_40481,_40451,_40519),
    negation0(_40113,_40549,_40519,_40583),
    look_ahead(w(prep(_40229)),_40607,_40583,_40641),
    traceprint(4,qv13a,_40665,_40641,_40703),
    !,
    lock(last,_40703,_40935),
    pushstack(last,(xnp(_40111,_40213),w(verb(_40189,_40191,fin)),negation(_40113)),nil,_40935,_40947),
    do_phrase(_40239,_40211,id,_40115,_40117,_40743,_40947,_40925),
    unlock(_40925,_40313).

qverb_phrase(_40111,id,_40115,_40117,[qverb_phrase,_40307,_40355,_40423,_40481,!,_40559],_40261,_40265) --> 
    aux1(_40307,_40261,_40337),
    subject(_40173,_40175,_40355,_40337,_40393),
    w(verb(be,_40185,fin),_40423,_40393,_40457),
    traceprint(4,qv15c,_40481,_40457,_40519),
    !,
    pushstack(first,(xnp(_40173,_40175),w(verb(be,pres,fin)),npgap(_40111)),nil,_40519,_40737),
    state(_40115,_40117,_40559,_40737,_40265).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40279,_40327,_40395,_40463,!,_40541],_40233,_40237) --> 
    docan(_40279,_40233,_40309),
    subject(_40163,_40159,_40327,_40309,_40365),
    negation2(id,_40113,_40395,_40365,_40433),
    traceprint(4,qv13b,_40463,_40433,_40501),
    !,
    lock(last,_40501,_40655),
    pushstack(last,xnp(_40111,_40159),nil,_40655,_40667),
    do_phrase(_40181,_40163,id,_40115,_40117,_40541,_40667,_40645),
    unlock(_40645,_40237).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,{},_40361,_40409,_40477,lit(av),_40557,!,_40635],_40301,_40305) --> 
    {constrain(_40111,place)},
    aux1(_40361,_40301,_40391),
    np1_accept(_40201,_40207::_40209,_40409,_40391,_40447),
    negation0(_40113,_40477,_40447,_40511),
    cc(av,_40511,_40555),
    traceprint(4,qv14,_40557,_40555,_40595),
    !,
    pushstack(first,(noun_phrase1(_40201,_40207::_40209),w(verb(go,pres,fin)),[av],npgap(_40111)),nil,_40595,_40819),
    state(_40115,_40117,_40635,_40819,_40305).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40377,_40435,_40483,_40551,_40609,_40667,_40725,!,_40803],_40331,_40335) --> 
    w(verb(be,pres,_40211),_40377,_40331,_40411),
    thereit0(_40435,_40411,_40465),
    np1_accept(_40215,_40221::_40223,_40483,_40465,_40521),
    negation0(_40113,_40551,_40521,_40585),
    w(verb(_40235,_40237,part),_40609,_40585,_40643),
    prep(_40243,_40667,_40643,_40701),
    traceprint(4,qv15,_40725,_40701,_40763),
    !,
    pushstack(first,(someone,w(verb(_40235,_40237,fin)),noun_phrase1(_40215,_40221::_40223),w(prep(_40243)),npgap(_40111)),nil,_40763,_41061),
    state(_40115,_40117,_40803,_41061,_40335).

qverb_phrase(_40111,id,_40115,_40117,[qverb_phrase,_40361,_40419,_40487,_40545,_40603,!,_40681],_40315,_40319) --> 
    w(verb(be,_40197,fin),_40361,_40315,_40395),
    subject(_40203,_40205,_40419,_40395,_40457),
    w(adj2(_40213,nil),_40487,_40457,_40521),
    w(prep(_40223),_40545,_40521,_40579),
    traceprint(4,qv15a,_40603,_40579,_40641),
    !,
    pushstack(first,(xnp(_40203,_40205),w(verb(be,pres,fin)),w(adj2(_40213,nil)),w(prep(_40223)),npgap(_40111)),nil,_40641,_40859),
    state(_40115,_40117,_40681,_40859,_40319).

qverb_phrase(_40111,id,_40115,_40117,[qverb_phrase,_40301,_40359,_40427,!,_40505],_40255,_40259) --> 
    w(verb(be,_40173,fin),_40301,_40255,_40335),
    subject(_40179,_40181,_40359,_40335,_40397),
    traceprint(4,qv15b,_40427,_40397,_40465),
    !,
    pushstack(first,(xnp(_40179,_40181),w(verb(be,pres,fin)),npgap(_40111)),nil,_40465,_40683),
    state(_40115,_40117,_40505,_40683,_40259).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40359,_40417,_40465,_40533,_40591,_40649,{},_40711,!,_40789],_40313,_40317) --> 
    w(verb(be,_40209,fin),_40359,_40313,_40393),
    thereit0(_40417,_40393,_40447),
    np1_accept(_40215,_40217,_40465,_40447,_40503),
    negation0(_40113,_40533,_40503,_40567),
    prep(_40225,_40591,_40567,_40625),
    not_look_ahead_np(_40649,_40625,_40679),
    {_40225\==towards},
    traceprint(4,qv16,_40711,_40679,_40749),
    !,
    pushstack(first,(xnp(_40215,_40217),w(verb(be1,pres,fin)),prep(_40225),npgap(_40111)),nil,_40749,_41045),
    state(_40115,_40117,_40789,_41045,_40317).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40485,{},_40587,_40655,_40713,_40781,_40839,_40887,!,{},{},_40993],_40439,_40443) --> 
    lexv(tv,_40223,_40225,fin,_40485,_40439,_40531),
    {\+testmember(_40223,[pass,be1,be,be2,cost,have,know1])},
    np1_accept(_40273,_40279::_40281,_40587,_40531,_40625),
    negation0(_40113,_40655,_40625,_40689),
    np1_accept(_40111,_40295::_40297,_40713,_40689,_40751),
    prep1(_40301,_40781,_40751,_40815),
    endofline(_40839,_40815,_40869),
    traceprint(4,qv17,_40887,_40869,_40925),
    !,
    {\+testmember(_40301,[off,of])},
    {test(verb_compl(_40223,_40301,_40273,_40111,_40349,_40351))},
    pushstack(first,(noun_phrase1(_40273,_40279::_40281),lexv(tv,_40223,_40225,fin),noun_phrase1(_40111,_40295::_40297),prep1(_40301),npgap(_40111)),nil,_40925,_41425),
    state(_40115,_40117,_40993,_41425,_40443).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40501,_40559,_40617,{},{},_40733,_40781,_40849,_40907,{},{},_41013,_41061,!,_41139],_40455,_40459) --> 
    not_look_ahead([kan],_40501,_40455,_40535),
    not_look_ahead(w(verb(be,_40251,_40253)),_40559,_40535,_40593),
    lexv(_40257,_40259,_40261,fin,_40617,_40593,_40663),
    {_40257==iv;_40257==rv},
    {\+testmember(_40259,[pass])},
    thereit0(_40733,_40663,_40763),
    np1_accept(_40307,_40313::_40315,_40781,_40763,_40819),
    negation0(_40113,_40849,_40819,_40883),
    defaultprep(_40259,_40111,_40327,_40907,_40883,_40949),
    {\+testmember(_40327,[off,of])},
    {test(verb_compl(_40259,_40327,_40307,_40111,_40369,_40371))},
    qtrailer0(_41013,_40949,_41043),
    traceprint(4,qv18,_41061,_41043,_41099),
    !,
    pushstack(first,(noun_phrase1(_40307,_40313::_40315),w(verb(_40259,_40261,fin)),prep1(_40327),npgap(_40111)),nil,_41099,_41401),
    state(_40115,_40117,_41139,_41401,_40459).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,{},_40423,{},_40495,_40553,_40621,_40679,_40757,!,_40835],_40363,_40367) --> 
    {constrain(_40111,place)},
    w(verb(_40217,_40219,fin),_40423,_40363,_40457),
    {\+testmember(_40217,[be,take,pass])},
    not_look_ahead([det],_40495,_40457,_40529),
    np1_accept(_40259,_40265::_40267,_40553,_40529,_40591),
    negation0(_40113,_40621,_40591,_40655),
    defaultprep(_40217,_40111,_40279,_40679,_40655,_40721),
    traceprint(4,qv19,_40757,_40721,_40795),
    !,
    pushstack(first,(noun_phrase1(_40259,_40265:_40267),w(verb(_40217,pres,fin)),prep1(_40279),npgap(_40111)),nil,_40795,_41079),
    state(_40115,_40117,_40835,_41079,_40367).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40409,{},_40511,_40579,{},_40651,{},_40723,!,_40801],_40363,_40367) --> 
    lexv(iv,_40205,_40207,fin,_40409,_40363,_40455),
    {_40205\==be1},
    np1_accept(_40223,_40229::_40231,_40511,_40455,_40549),
    negation0(_40113,_40579,_40549,_40613),
    {constrain(_40223,vehicle)},
    prep1(_40249,_40651,_40613,_40685),
    {testmember(_40249,[to,from,past,by,on])},
    traceprint(4,qv20,_40723,_40685,_40761),
    !,
    pushstack(first,(noun_phrase1(_40223,_40229::_40231),w(verb(_40205,pres,fin)),prep1(_40249),npgap(_40111)),nil,_40761,_41063),
    state(_40115,_40117,_40801,_41063,_40367).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40309,_40357,_40425,_40513,!,_40591],_40263,_40267) --> 
    do(_40309,_40263,_40339),
    noun_phrase1(_40175,_40169::_40171,_40357,_40339,_40395),
    lexv(_40187,know1,_40191,fin,_40425,_40395,_40471),
    traceprint(4,qv21,_40513,_40471,_40551),
    !,
    pushstack(first,(lexv(_40187,know1,_40191,fin),np(_40111,_40169::_40171)),nil,_40551,_40765),
    verb_phrase(_40175,_40113,_40115,_40117,_40591,_40765,_40267).

qverb_phrase(_40111,_40113,_40115,_40121::_40123,[qverb_phrase,_40297,_40345,_40413,_40461,!,_40539],_40251,_40255) --> 
    use(_40297,_40251,_40327),
    noun_phrase1(_40173,_40179::_40123,_40345,_40327,_40383),
    in_order_to(_40413,_40383,_40443),
    traceprint(4,qv22,_40461,_40443,_40499),
    !,
    pushstack(free,(prep(with),npgap(_40111)),nil,_40499,_40715),
    verb_phrase(_40173,_40113,_40115,_40121::_40179,_40539,_40715,_40255).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40295,_40343,_40401,_40459,!,_40537],_40249,_40253) --> 
    be(_40295,_40249,_40325),
    thereit2(be,_40343,_40325,_40377),
    not_look_ahead(w(noun(_40181,_40183,u,_40187)),_40401,_40377,_40435),
    traceprint(4,qv23,_40459,_40435,_40497),
    !,
    pushstack(first,w(verb(exist,pres,fin)),nil,_40497,_40557),
    verb_phrase1(exist,_40111,_40113,_40115,_40117,_40537,_40557,_40253).

qverb_phrase(_40111,id,_40115,_40117,[qverb_phrase,{},_40365,{},_40467,{},_40549,!,_40627],_40305,_40309) --> 
    {constrain(_40111,route)},
    lexv(iv,_40197,_40199,fin,_40365,_40305,_40411),
    {testmember(_40197,[go])},
    subject(_40219,_40221,_40467,_40411,_40505),
    {constrain(_40219,vehicle)},
    traceprint(4,qv24,_40549,_40505,_40587),
    !,
    lock(last,_40587,_40819),
    pushstack(last,(xnp(_40219,_40221),w(verb(_40197,_40199,fin)),npgap(_40111)),nil,_40819,_40831),
    state(_40115,_40117,_40627,_40831,_40809),
    unlock(_40809,_40309).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40327,_40415,{},_40497,_40555,!,_40633],_40281,_40285) --> 
    lexv(tv,_40177,_40179,fin,_40327,_40281,_40373),
    subject(_40185,_40171,_40415,_40373,_40453),
    {subject_object_test(_40177,_40185,_40111)},
    not_look_ahead(w(prep(_40211)),_40497,_40453,_40531),
    traceprint(4,qv25,_40555,_40531,_40593),
    !,
    pushstack(first,(lexv(tv,_40177,_40179,fin),xnp(_40111,_40171)),nil,_40593,_40817),
    verb_phrase(_40185,_40113,_40115,_40117,_40633,_40817,_40285).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40257,_40315,!,_40393],_40211,_40215) --> 
    look_ahead(w(verb(be,_40159,fin)),_40257,_40211,_40291),
    traceprint(4,qv26,_40315,_40291,_40353),
    !,
    verb_phrase(_40111,_40113,_40115,_40117,_40393,_40353,_40215).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40295,{},_40367,_40425,!,_40503],_40249,_40253) --> 
    not_look_ahead(w(verb(be,_40171,fin)),_40295,_40249,_40329),
    {vartypeid(_40111,thing)},
    look_ahead(w(verb(_40195,_40197,fin)),_40367,_40329,_40401),
    traceprint(4,qv27,_40425,_40401,_40463),
    !,
    verb_phrase(_40111,_40113,_40115,_40117,_40503,_40463,_40253).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40317,lit(du),_40397,_40445,_40513,lit(kan),_40603,!,_40681],_40271,_40275) --> 
    w(verb(believe,pres,fin),_40317,_40271,_40351),
    cc(du,_40351,_40395),
    that0(_40397,_40395,_40427),
    noun_phrase1(_40197,_40177,_40445,_40427,_40483),
    negation2(id,_40113,_40513,_40483,_40551),
    cc(kan,_40551,_40601),
    traceprint(4,qv28,_40603,_40601,_40641),
    !,
    pushstack(free,xnp(_40111,_40177),nil,_40641,_40781),
    do_phrase(believe,_40197,id,_40115,_40117,_40681,_40781,_40275).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40285,_40333,_40401,_40469,_40517,!,_40595],_40239,_40243) --> 
    do(_40285,_40239,_40315),
    noun_phrase1(_40169,_40165,_40333,_40315,_40371),
    negation2(id,_40113,_40401,_40371,_40439),
    redundant0x(_40469,_40439,_40499),
    traceprint(4,qv29,_40517,_40499,_40555),
    !,
    lock(last,_40555,_40709),
    pushstack(last,xnp(_40111,_40165),nil,_40709,_40721),
    do_phrase(_40187,_40169,id,_40115,_40117,_40595,_40721,_40699),
    unlock(_40699,_40243).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40355,{},_40457,_40505,_40573,_40621,_40679,!,_40757],_40309,_40313) --> 
    lexv(iv,_40195,_40197,fin,_40355,_40309,_40401),
    {\+testmember(_40195,[know,know1,be1])},
    thereit(_40457,_40401,_40487),
    noun_phrase1(_40229,_40189,_40505,_40487,_40543),
    adverbx0(_40573,_40543,_40603),
    prep0(_40235,_40621,_40603,_40655),
    traceprint(4,qv30,_40679,_40655,_40717),
    !,
    pushstack(first,(lexv(iv,_40195,_40197,fin),prep(_40235),xnp(_40111,_40189)),nil,_40717,_41019),
    verb_phrase(_40229,_40113,_40115,_40117,_40757,_41019,_40313).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40331,_40379,_40447,_40535,_40583,_40671,!,_40749],_40285,_40289) --> 
    has(_40331,_40285,_40361),
    np1_accept(_40187,_40181::_40183,_40379,_40361,_40417),
    lexv(rv,_40201,past,part,_40447,_40417,_40493),
    infinitive(_40535,_40493,_40565),
    lexv(tv,_40211,inf,fin,_40583,_40565,_40629),
    traceprint(4,qv31,_40671,_40629,_40709),
    !,
    pushstack(first,(lexv(tv,_40211,pres,fin),np(_40111,_40181::_40183)),nil,_40709,_40939),
    verb_phrase(_40187,_40113,_40115,_40117,_40749,_40939,_40289).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40309,_40357,_40425,_40513,!,_40591],_40263,_40267) --> 
    has(_40309,_40263,_40339),
    np1_accept(_40175,_40169::_40171,_40357,_40339,_40395),
    lexv(tv,_40189,past,part,_40425,_40395,_40471),
    traceprint(4,qv32,_40513,_40471,_40551),
    !,
    pushstack(first,(lexv(tv,_40189,past,fin),np(_40111,_40169::_40171)),nil,_40551,_40765),
    verb_phrase(_40175,_40113,_40115,_40117,_40591,_40765,_40267).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40303,_40351,{},_40433,!,_40511],_40257,_40261) --> 
    has(_40303,_40257,_40333),
    np1_accept(_40169,_40165,_40351,_40333,_40389),
    {has_template(_40169,_40111,_40183)},
    traceprint(4,qv33,_40433,_40389,_40471),
    !,
    pushstack(free,(w(verb(have,pres,fin)),noun_phrase1(_40111,_40165)),nil,_40471,_40611),
    do_phrase(have,_40169,_40113,_40115,_40117,_40511,_40611,_40261).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40365,_40413,_40481,_40569,_40637,_40695,!,_40773],_40319,_40323) --> 
    has(_40365,_40319,_40395),
    np1_accept(_40199,_40193::_40195,_40413,_40395,_40451),
    lexv(tv,_40213,past,part,_40481,_40451,_40527),
    noun_phrase1(_40221,_40227::_40229,_40569,_40527,_40607),
    prep(_40233,_40637,_40607,_40671),
    traceprint(4,qv34,_40695,_40671,_40733),
    !,
    pushstack(first,(lexv(tv,_40213,past,fin),np(_40221,_40227::_40229),prep(_40233),np(_40111,_40193::_40195)),nil,_40733,_41127),
    verb_phrase(_40199,_40113,_40115,_40117,_40773,_41127,_40323).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40277,{},_40349,!,_40427],_40231,_40235) --> 
    not_look_ahead(w(verb(be,_40165,fin)),_40277,_40231,_40311),
    {\+vartypeid(_40111,thing)},
    traceprint(4,qv35,_40349,_40311,_40387),
    !,
    verb_phrase(_40111,_40113,_40115,_40117,_40427,_40387,_40235).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,{},_40311,_40369,_40417,!,_40495],_40251,_40255) --> 
    {\+vartypeid(_40111,thing)},
    w(verb(_40161,_40163,fin),_40311,_40251,_40345),
    thereit0(_40369,_40345,_40399),
    traceprint(4,qv36,_40417,_40399,_40455),
    !,
    pushstack(first,w(verb(_40161,_40163,fin)),nil,_40455,_40515),
    verb_phrase(_40111,_40113,_40115,_40117,_40495,_40515,_40255).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40303,_40391,_40439,_40623,!,_40701],_40257,_40261) --> 
    lexv(_40169,_40171,_40173,fin,_40303,_40257,_40349),
    thereit(_40391,_40349,_40421),
    lock(exact,_40421,_40551),pushstack(exact,this,nil,_40551,_40563),npa(_40185,_40165,_40439,_40563,_40541),unlock(_40541,_40543),
    traceprint(4,qv37,_40623,_40543,_40661),
    !,
    pushstack(first,(lexv(_40169,_40171,_40173,fin),xnp(_40111,_40165)),nil,_40661,_40885),
    verb_phrase(_40185,_40113,_40115,_40117,_40701,_40885,_40261).

qverb_phrase(_40111,_40113,_40115,_40117,[qverb_phrase,_40401,{},_40503,_40571,_40629,_40707,!,_40785,_40833,_40911],_40355,_40359) --> 
    lexv(iv,_40211,_40213,fin,_40401,_40355,_40447),
    {\+testmember(_40211,[think])},
    np1_accept(_40237,_40239,_40503,_40447,_40541),
    negation0(_40113,_40571,_40541,_40605),
    adverbial1(_40247,_40249,_40255::_40257,_40629,_40605,_40671),
    traceprint(4,qv38,_40707,_40671,_40745),
    !,
    accept(_40785,_40745,_40815),
    defaultprep(_40211,_40111,_40271,_40833,_40815,_40875),
    pushstack(first,(xnp(_40237,_40239),lexv(iv,_40211,_40213,fin),adverbial1(_40247,_40249,_40255::_40257),prep1(_40271),npgap(_40111)),nil,_40875,_41339),
    state(_40115,_40117,_40911,_41339,_40359).

verb_modifiers0(_40111,_40113,_40115,_40117,_40119,[verb_modifiers0,lit(hva),!,_40267],_40183,_40187) --> 
    cc(hva,_40183,_40255),
    !,
    reject(_40267,_40255,_40187).

verb_modifiers0(_40111,_40113,_40115,_40117,_40119,[verb_modifiers0,_40231],_40179,_40183) --> 
    verb_modifiers(_40111,_40113,_40115,_40117,_40119,_40231,_40179,_40183).

verb_modifiers0(_40111,_40113,_40115,_40117,_40119,[verb_modifiers0,_40243,!,_40301],_40191,_40195) --> 
    redundant(_40243,_40191,_40273),
    !,
    verb_modifiers(_40111,_40113,_40115,_40117,_40119,_40301,_40273,_40195).

verb_modifiers0(_40111,_40113,_40115,_40117,_40117,[verb_modifiers0,{}],_40181,_40181) --> 
    {\+_40111=be1}.

verb_modifiers(_40111,_40113,_40115,_40117,_40119,[verb_modifiers,_40261,!,_40369,_40417],_40209,_40213) --> 
    verb_modifier(_40111,_40113,_40115,_40117,_40147,_40261,_40209,_40311),
    !,
    accept(_40369,_40311,_40399),
    verb_modifiers10(_40111,_40113,_40115,_40147,_40119,_40417,_40399,_40213).

verb_modifiers10(_40111,_40113,_40115,_40117,_40119,[verb_modifiers10,_40243,_40291,_40339],_40191,_40195) --> 
    vmod_conjunction(_40243,_40191,_40273),
    look_ahead_prepadv(_40291,_40273,_40321),
    verb_modifiers(_40111,_40113,_40115,_40117,_40119,_40339,_40321,_40195).

verb_modifiers10(go,_40113,_40115,_40117,_40119,[verb_modifiers10,_40283,_40331,!,_40399,_40447],_40231,_40235) --> 
    numberroute(_40283,_40231,_40313),
    look_ahead(w(nb(_40169,num)),_40331,_40313,_40365),
    !,
    accept(_40399,_40365,_40429),
    pushstack(first,w(prep(with)),nil,_40429,_40467),
    verb_modifiers(go,_40113,_40115,_40117,_40119,_40447,_40467,_40235).

verb_modifiers10(_40111,_40113,_40115,_40117,_40119,[verb_modifiers10,_40259,_40307,_40365],_40207,_40211) --> 
    point(_40259,_40207,_40289),
    look_ahead(w(name(_40155,_40157,_40159)),_40307,_40289,_40341),
    verb_modifiers0(_40111,_40113,_40115,_40117,_40119,_40365,_40341,_40211).

verb_modifiers10(_40111,_40113,_40115,_40117,_40119,[verb_modifiers10,_40231],_40179,_40183) --> 
    verb_modifiers0(_40111,_40113,_40115,_40117,_40119,_40231,_40179,_40183).

verb_modifiers10(_40111,_40113,_40115,_40117,_40117,[verb_modifiers10,[]],_40167,_40167) --> 
    [].

look_ahead_prepadv([look_ahead_prepadv,_40175,!],_40153,_40157) --> 
    look_ahead(w(prep(_40125)),_40175,_40153,_40157),
    !.

look_ahead_prepadv([look_ahead_prepadv,_40175,!],_40153,_40157) --> 
    look_ahead(w(adv(_40125)),_40175,_40153,_40157),
    !.

verb_modifier(_40111,_40113,_40115,_40135 and _40123::_40125,_40123::_40125,[verb_modifier,_40329,_40387,{},{}],_40277,_40281) --> 
    thisplace(_40181,_40329,_40277,_40363),
    not_look_ahead([jegdu],_40387,_40363,_40281),
    {verb_compl(_40111,_40181,_40113,_40211:place,_40115,_40177)},
    {_40135=(findexternal(_40211:place)::_40211 isa place and _40177)}.

verb_modifier(_40111,_40113,_40115,_40135 and _40123::_40131,_40123::_40125,[verb_modifier,_40255],_40203,_40207) --> 
    verb_mod1(_40111,_40113,_40115,_40135,_40131::_40125,_40255,_40203,_40207).

verb_modifier(_40111,_40113,_40115,_40135 and _40123::_40125,_40123::_40125,[verb_modifier,_40267,!,{}],_40215,_40219) --> 
    today(_40267,_40215,_40219),
    !,
    {adv_compl(_40111,today,_40113,time,_40115,_40135)}.

verb_modifier(_40111,_40113,_40115,_40117,_40117,[verb_modifier,_40235,!,_40303],_40183,_40187) --> 
    particlev1(_40111,_40235,_40183,_40269),
    !,
    accept(_40303,_40269,_40187).

verb_modifier(_40111,_40113,_40115,_40117,_40117,[verb_modifier,{},_40257],_40191,_40195) --> 
    {testmember(_40111,[want])},
    reflexiv(_40111,_40257,_40191,_40195).

verb_modifier(_40111,_40113,_40115,_40135 and _40123::_40131,_40123::_40125,[verb_modifier,{},_40319,_40407,{}],_40253,_40257) --> 
    {_40111\==be1},
    lexv(iv,_40189,pres,part,_40319,_40253,_40365),
    verb_modifier3(_40189,_40113,_40169,_40131,_40125,_40407,_40365,_40257),
    {verb_compl(_40111,during,_40113,_40169,_40115,_40135)}.

verb_modifier(_40111,_40113,_40115,_40123 and _40137::_40131,_40123::_40125,[verb_modifier,_40297,_40345,{}],_40245,_40249) --> 
    this(_40297,_40245,_40327),
    pushstack(first,(prep(in),this),nil,_40327,_40523),adverbial(_40159,_40163,_40131::_40125,_40345,_40523,_40249),
    {verb_compl(_40111,_40159,_40113,_40163,_40115,_40137)}.

verb_modifier(_40111,_40113,_40115,_40135 and _40123::_40125,_40123::_40125,[verb_modifier,_40269,{}],_40217,_40221) --> 
    partday(_40153,_40157,_40169,_40269,_40217,_40221),
    {adv_compl(_40111,_40153,_40113,_40157,_40115,_40135)}.

verb_modifier(_40111,_40113,_40115,_40135 and _40123::_40131,_40123::_40125,[verb_modifier,_40297,_40355,{},!,_40457],_40245,_40249) --> 
    nil_compl(_40111,_40297,_40245,_40331),
    adjunct1(nil,_40171,_40131::_40125,_40355,_40331,_40397),
    {verb_compl(_40111,nil,_40113,_40171,_40115,_40135)},
    !,
    accept(_40457,_40397,_40249).

verb_modifier(_40111,_40113,_40115,_40135 and _40123::_40131,_40123::_40125,[verb_modifier,_40297,_40355,{},!,_40457],_40245,_40249) --> 
    dir_compl(_40111,_40297,_40245,_40331),
    adjunct1(dir,_40171,_40131::_40125,_40355,_40331,_40397),
    {verb_compl(_40111,dir,_40113,_40171,_40115,_40135)},
    !,
    accept(_40457,_40397,_40249).

verb_modifier(adj/nil/_40131,_40113,_40115,_40147 and _40123::_40143,_40123::_40125,[verb_modifier,_40323,_40371,_40469,{}],_40271,_40275) --> 
    infinitive(_40323,_40271,_40353),
    subordinateinfnosubj(nil,coevent,_40113,_40181,_40197,_40371,_40353,_40421),
    determiner00(_40181,_40143,_40197::_40125,_40469,_40421,_40275),
    {verb_compl(adj/nil/_40131,in_order_to,_40113,_40181,_40115,_40147)}.

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,_40331,_40399,{},_40471,!,_40549,{}],_40279,_40283) --> 
    gmem(_40111,[be1,go,arrive,depart],_40331,_40279,_40369),
    w(prep(_40165),_40399,_40369,_40433),
    {testmember(_40165,[before,after,between])},
    plausibleclock(_40169,_40119,_40471,_40433,_40509),
    !,
    accept(_40549,_40509,_40283),
    {verb_compl(_40111,_40165,_40113,_40169,_40115,_40117)}.

verb_mod1(look,_40113,_40115,_40117,_40123::_40125,[verb_mod1,_40309,lit(ut),!,_40399,{}],_40257,_40261) --> 
    w(adj2(_40175,_40177),_40309,_40257,_40343),
    cc(ut,_40343,_40387),
    !,
    lock(exact,_40387,_40439),pushstack(exact,w(adv(_40175)),nil,_40439,_40451),adverbix(_40159,_40163,_40123::_40125,_40399,_40451,_40429),unlock(_40429,_40261),
    {verb_compl(look,_40159,_40113,_40163,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,_40313,_40381,{},!,_40463,{}],_40261,_40265) --> 
    gmem(_40111,[be1],_40313,_40261,_40351),
    w(prep(_40159),_40381,_40351,_40415),
    {\+member(_40159,[between,for])},
    !,
    np1_accept(_40163,_40119,_40463,_40415,_40265),
    {verb_compl(_40111,_40159,_40113,_40163,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,lit(som),_40301,!,_40369,{}],_40227,_40231) --> 
    cc(som,_40227,_40299),
    w(prep(in),_40301,_40299,_40335),
    !,
    np1_accept(_40157,_40119,_40369,_40335,_40231),
    {verb_compl(_40111,as_in,_40113,_40157,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,lit(som),!,_40297,{}],_40213,_40217) --> 
    cc(som,_40213,_40285),
    !,
    np1_accept(_40151,_40119,_40297,_40285,_40217),
    {verb_compl(_40111,as,_40113,_40151,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,_40339,_40407,{},_40479,!,_40547,{}],_40287,_40291) --> 
    gmem(_40111,[exist],_40339,_40287,_40377),
    one_of_lit([til,før],_40407,_40377,_40441),
    {vartypeid(_40113,_40209),subclass0(_40209,duration)},
    not_look_ahead(w(name(_40229,n,place)),_40479,_40441,_40513),
    !,
    clausal_object0(_40169,_40119,_40547,_40513,_40291),
    {verb_compl(_40111,until,_40113,_40169,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,{},lit(_40189),{},{},!,_40407,{}],_40281,_40285) --> 
    {testmember(_40111,[exist])},
    cc(_40189,_40281,_40367),
    {testmember(_40189,[siden])},
    {vartypeid(_40113,_40219),subclass0(_40219,duration)},
    !,
    clausal_object0(_40169,_40119,_40407,_40367,_40285),
    {verb_compl(_40111,since,_40113,_40169,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,{},lit(med),lit(at),!,_40363,{}],_40243,_40247) --> 
    {testmember(_40111,[mean])},
    cc(med,_40243,_40329),
    cc(at,_40329,_40351),
    !,
    clausal_object1(_40163,_40119,_40363,_40351,_40247),
    {verb_compl(_40111,with,_40113,_40163,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},_40357,_40415,!,_40483,{}],_40291,_40295) --> 
    {testmember(_40111,[ask])},
    not_look_ahead([nå],_40357,_40291,_40391),
    look_ahead(w(verb(_40207,inf,fin)),_40415,_40391,_40449),
    !,
    pushstack(first,(npgap(_40113),[vil]),nil,_40449,_40587),clausal_object1(_40169,_40123::_40125,_40483,_40587,_40295),
    {verb_compl(_40111,regarding,_40113,_40169,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,{},lit(om),_40339,!,_40407,{}],_40251,_40255) --> 
    {testmember(_40111,[notify,take])},
    cc(om,_40251,_40337),
    not_look_ahead([en],_40339,_40337,_40373),
    !,
    clausal_object0(_40163,_40119,_40407,_40373,_40255),
    {verb_compl(_40111,regarding,_40113,_40163,_40115,_40117)}.

verb_mod1(adj/nil/_40125,_40113,_40115,_40117,_40119,[verb_mod1,{},_40349,!,_40417,{}],_40283,_40287) --> 
    {testmember(_40125,[delayed])},
    w(nb(_40195,num),_40349,_40283,_40383),
    !,
    pushstack(first,(w(prep(with)),w(nb(_40195,num))),nil,_40383,_40443),pp(with,_40169,_40119,_40417,_40443,_40287),
    {adj_compl(_40125,with,_40113,_40169,_40115,_40117)}.

utenå([utenå,lit(uten),_40201,_40249,!],_40157,_40161) --> 
    cc(uten,_40157,_40199),
    ogå(_40201,_40199,_40231),
    måtte(_40249,_40231,_40161),
    !.

utenå([utenå,lit(uten),_40189],_40145,_40149) --> 
    cc(uten,_40145,_40187),
    ogå(_40189,_40187,_40149).

måtte([måtte,_40181],_40159,_40163) --> 
    one_of_lit([måtte,ville,skulle,burde,kunne],_40181,_40159,_40163).

verb_mod1(adj/nil/_40125,_40113,_40115,_40117,_40119,[verb_mod1,{},_40311,!,_40369,{}],_40245,_40249) --> 
    {testmember(_40125,[afraid,happy])},
    foratx0(_40311,_40245,_40341),
    !,
    clausal_object1(_40169,_40119,_40369,_40341,_40249),
    {adj_compl(_40125,because_of,_40113,_40169,_40115,_40117)}.

foratx0([foratx0,lit(for),lit(at)],_40149,_40153) --> 
    cc(for,_40149,_40191),
    cc(at,_40191,_40153).

foratx0([foratx0,lit(at)],_40139,_40143) --> 
    cc(at,_40139,_40143).

foratx0([foratx0,_40189],_40167,_40171) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_40189,_40167,_40171).

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,{},_40299,_40347,{},!],_40233,_40237) --> 
    {testmember(_40111,[label,be_named])},
    look_ahead_np(_40299,_40233,_40329),
    np0_accept(_40165,_40119,_40347,_40329,_40237),
    {verb_compl(_40111,with,_40113,_40165,_40115,_40117)},
    !.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},lit(enn),lit(å),!,_40397,{}],_40277,_40281) --> 
    {\+testmember(_40111,[be,be1,be2])},
    cc(enn,_40277,_40363),
    cc(å,_40363,_40385),
    !,
    pushstack(first,[noen],nil,_40385,_40423),clausal_object1(_40169,_40123::_40125,_40397,_40423,_40281),
    {verb_compl(_40111,than,_40113,_40169,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},lit(enn),lit(at),!,_40387,{}],_40267,_40271) --> 
    {\+testmember(_40111,[be,be1,be2])},
    cc(enn,_40267,_40353),
    cc(at,_40353,_40375),
    !,
    clausal_object1(_40169,_40123::_40125,_40387,_40375,_40271),
    {verb_compl(_40111,than,_40113,_40169,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},lit(enn),_40339,{}],_40251,_40255) --> 
    {\+testmember(_40111,[be,be1,be2])},
    cc(enn,_40251,_40337),
    np1(_40157,_40123::_40125,_40339,_40337,_40255),
    {verb_compl(_40111,than,_40113,_40157,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,{},_40331,{},!,_40413,{}],_40265,_40269) --> 
    {testmember(_40111,[notify,wait])},
    w(prep(_40159),_40331,_40265,_40365),
    {\+testmember(_40159,[for])},
    !,
    clausal_object0(_40163,_40119,_40413,_40365,_40269),
    {verb_compl(_40111,_40159,_40113,_40163,_40115,_40117)}.

verb_mod1(adj/nil/_40131,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},_40379,lit(å),!,_40499,{}],_40313,_40317) --> 
    {testmember(_40131,[nice,good,bad,interested,interesting])},
    optional(w(prep(_40227)),_40379,_40313,_40443),
    cc(å,_40443,_40487),
    !,
    pushstack(first,npgap(_40113),nil,_40487,_40603),clausal_object1(_40181,_40123::_40125,_40499,_40603,_40317),
    {verb_compl(adj/nil/_40131,because_of,_40113,_40181,_40115,_40117)}.

overat([overat,lit(fordi)],_40139,_40143) --> 
    cc(fordi,_40139,_40143).

overat([overat,lit(av),lit(at)],_40149,_40153) --> 
    cc(av,_40149,_40191),
    cc(at,_40191,_40153).

overat([overat,lit(over),lit(at)],_40149,_40153) --> 
    cc(over,_40149,_40191),
    cc(at,_40191,_40153).

overat([overat,lit(til),lit(at)],_40149,_40153) --> 
    cc(til,_40149,_40191),
    cc(at,_40191,_40153).

verb_mod1(adj/nil/_40125,_40113,_40115,_40117,_40119,[verb_mod1,{},lit(av),lit(hvilken),!,_40387,{}],_40267,_40271) --> 
    {\+testmember(_40125,[])},
    cc(av,_40267,_40353),
    cc(hvilken,_40353,_40375),
    !,
    np1(_40175,_40119,_40387,_40375,_40271),
    {verb_compl(adj/nil/_40125,of,_40113,_40175,_40115,_40117)}.

verb_mod1(adj/nil/_40131,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},_40341,!,_40399,{}],_40275,_40279) --> 
    {\+testmember(_40131,[])},
    overaa(_40341,_40275,_40371),
    !,
    pushstack(first,npgap(_40113),nil,_40371,_40503),clausal_object1(_40175,_40123::_40125,_40399,_40503,_40279),
    {verb_compl(adj/nil/_40131,because_of,_40113,_40175,_40115,_40117)}.

overaa([overaa,lit(av),lit(å)],_40149,_40153) --> 
    cc(av,_40149,_40191),
    cc(å,_40191,_40153).

overaa([overaa,lit(over),lit(å)],_40149,_40153) --> 
    cc(over,_40149,_40191),
    cc(å,_40191,_40153).

overaa([overaa,lit(til),lit(å)],_40149,_40153) --> 
    cc(til,_40149,_40191),
    cc(å,_40191,_40153).

verb_mod1(_40111,_40113,_40115,_40117,_40119,[verb_mod1,{},_40315,lit(å),!,_40395,{}],_40249,_40253) --> 
    {\+testmember(_40111,[])},
    instead_of(_40315,_40249,_40345),
    cc(å,_40345,_40383),
    !,
    pushstack(first,npgap(_40113),nil,_40383,_40499),clausal_object1(_40163,_40119,_40395,_40499,_40253),
    {verb_compl(_40111,instead_of,_40113,_40163,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40123,[verb_mod1,_40309,_40367,{},_40459,{}],_40257,_40261) --> 
    gradverb0(_40171,_40309,_40257,_40343),
    adverb(_40159,_40163,_40179,_40367,_40343,_40409),
    {testmember(_40159,[slowly,fast,thereafter])},
    not_look_ahead([det],_40459,_40409,_40261),
    {adv_compl(_40111,_40159,_40113,_40163,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},lit(om),lit(å),!,_40385,{}],_40265,_40269) --> 
    {testmember(_40111,[ask])},
    cc(om,_40265,_40351),
    cc(å,_40351,_40373),
    !,
    pushstack(first,npgap(_40113),nil,_40373,_40489),clausal_object1(_40169,_40123::_40125,_40385,_40489,_40269),
    {verb_compl(_40111,regarding,_40113,_40169,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},_40353,_40441,lit(å),!,_40561,{}],_40287,_40291) --> 
    {testmember(_40111,[extend,help])},
    optional([til],_40353,_40287,_40417),
    optional([med],_40441,_40417,_40505),
    cc(å,_40505,_40549),
    !,
    pushstack(first,npgap(_40113),nil,_40549,_40665),clausal_object1(_40175,_40123::_40125,_40561,_40665,_40291),
    {verb_compl(_40111,with,_40113,_40175,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,_40269,!,{}],_40217,_40221) --> 
    xadverbial1(_40147,_40151,_40123::_40125,_40269,_40217,_40221),
    !,
    {verb_compl(_40111,_40147,_40113,_40151,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},_40327,!,_40395,_40443,{}],_40261,_40265) --> 
    {testmember(_40111,[talk,speak])},
    look_ahead([om],_40327,_40261,_40361),
    !,
    accept(_40395,_40361,_40425),
    adverbial1(regarding,_40169,_40123::_40125,_40443,_40425,_40265),
    {verb_compl(_40111,regarding,_40113,_40169,_40115,_40117)}.

verb_mod1(adj/_40137/_40131,_40113,_40115,_40117,_40123::_40125,[verb_mod1,_40275,{}],_40223,_40227) --> 
    adverbial4(_40153,_40157,_40123::_40125,_40275,_40223,_40227),
    {adj_compl(_40131,_40153,_40113,_40157,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},_40313,{}],_40247,_40251) --> 
    {\+testmember(_40111,[know,know1,speak,hope])},
    adverbial3(_40147,_40151,_40123::_40125,_40313,_40247,_40251),
    {verb_compl(_40111,_40147,_40113,_40151,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},_40343,!,_40411,_40459,{}],_40277,_40281) --> 
    {testmember(_40111,[know,know1,ask,tell,speak,think])},
    look_ahead([om],_40343,_40277,_40377),
    !,
    accept(_40411,_40377,_40441),
    adverbial1(regarding,_40169,_40123::_40125,_40459,_40441,_40281),
    {verb_compl(_40111,regarding,_40113,_40169,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,srel/_40149/time/_40137/_40115,_40123::_40123,[verb_mod1,_40357,{},_40429,{},{},!,_40525],_40305,_40309) --> 
    w(prep(_40149),_40357,_40305,_40391),
    {testmember(_40149,[to,until])},
    w(adv(_40137),_40429,_40391,_40463),
    {testmember(_40137,[tomorrow])},
    {verb_compl(_40111,_40149,_40113,_40255:time,_40115,_40251)},
    !,
    accept(_40525,_40463,_40309).

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40123,[verb_mod1,_40255,{}],_40203,_40207) --> 
    xadverb(_40141,_40145,_40255,_40203,_40207),
    {adv_compl(_40111,_40141,_40113,_40145,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,_40263,{}],_40211,_40215) --> 
    adverbix(_40141,_40145,_40123::_40125,_40263,_40211,_40215),
    {verb_compl(_40111,_40141,_40113,_40145,_40115,_40117)}.

verb_mod1(_40111,_40113,_40115,_40117,_40123::_40125,[verb_mod1,{},_40399,_40457,{},{},!,_40573],_40333,_40337) --> 
    {\+testmember(_40111,[go])},
    nil_compl(_40111,_40399,_40333,_40433),
    adjunct1(nil,_40189,_40123::_40125,_40457,_40433,_40499),
    {constrain(_40189,time);constrain(_40189,departure);constrain(_40189,arrival);constrain(_40189,route);constrain(_40189,number);constrain(_40189,bus)},
    {verb_compl(_40111,nil,_40113,_40189,_40115,_40117)},
    !,
    accept(_40573,_40499,_40337).

dir_compl(_40111,[dir_compl,{},!,_40221],_40169,_40173) --> 
    {v_compl(_40111,_40133,dir,_40137)},
    !,
    accept(_40221,_40169,_40173).

nil_compl(_40111,[nil_compl,_40201,_40269,!],_40173,_40177) --> 
    gmem(_40111,[have],_40201,_40173,_40239),
    look_ahead_lit([hver],_40269,_40239,_40177),
    !.

nil_compl(be/_40117,[nil_compl,{},!,_40227],_40175,_40179) --> 
    {a_compl(_40117,_40139,nil,_40143)},
    !,
    accept(_40227,_40175,_40179).

nil_compl(adj/nil/_40117,[nil_compl,{},!],_40175,_40175) --> 
    {\+testmember(_40117,[])},
    !.

nil_compl(adj/nil/_40117,[nil_compl,{},!,_40231],_40179,_40183) --> 
    {\+post_adjective(_40117)},
    !,
    reject(_40231,_40179,_40183).

nil_compl(go,[nil_compl,_40615,{},_40687,_40745,_40803,_40861,_40919,_40977,_41035,_41093,_41151,_41209,_41267,_41325,_41383,_41441,_41499,_41557,_41615,_41673,_41731,_41789,_41847,!,_41915],_40587,_40591) --> 
    w(nb(_40263,num),_40615,_40587,_40649),
    {_40263<100},
    not_look_ahead(w(noun(time_count,plu,u,n)),_40687,_40649,_40721),
    not_look_ahead(w(nb(_40305,num)),_40745,_40721,_40779),
    not_look_ahead([:],_40803,_40779,_40837),
    not_look_ahead([?],_40861,_40837,_40895),
    not_look_ahead(['.'],_40919,_40895,_40953),
    not_look_ahead([/],_40977,_40953,_41011),
    not_look_ahead([den],_41035,_41011,_41069),
    not_look_ahead(w(name(_40359,_40361,month)),_41093,_41069,_41127),
    not_look_ahead(w(name(new_years_day,_40377,date)),_41151,_41127,_41185),
    not_look_ahead(w(name(whitsun_day,_40393,date)),_41209,_41185,_41243),
    not_look_ahead(w(name(christmas_day,_40409,date)),_41267,_41243,_41301),
    not_look_ahead(w(name(easterday,_40425,date)),_41325,_41301,_41359),
    not_look_ahead(w(prep(_40439)),_41383,_41359,_41417),
    not_look_ahead(w(prep(over)),_41441,_41417,_41475),
    not_look_ahead(w(prep(on)),_41499,_41475,_41533),
    not_look_ahead(w(prep(in)),_41557,_41533,_41591),
    not_look_ahead(w(noun(day,_40489,_40491,_40493)),_41615,_41591,_41649),
    not_look_ahead(w(noun(hour,_40507,_40509,_40511)),_41673,_41649,_41707),
    not_look_ahead(w(noun(minute,_40525,_40527,_40529)),_41731,_41707,_41765),
    not_look_ahead(w(noun(second,_40543,_40545,_40547)),_41789,_41765,_41823),
    not_look_ahead([om],_41847,_41823,_41881),
    !,
    reject(_41915,_41881,_40591).

nil_compl(_40111,[nil_compl,{},{},{},_40293,!,_40351],_40223,_40227) --> 
    {\+abnormalverb(_40111,_40155)},
    {\+testmember(_40111,[have,be_named])},
    {v_compl(_40111,_40187,nil,_40191)},
    hver0(_40293,_40223,_40323),
    !,
    accept(_40351,_40323,_40227).

verb_modifier3(_40111,_40113,_40115,_40117,_40119,[verb_modifier3,_40299,_40615],_40247,_40251) --> 
    pushstack(free,(npgap(_40113),lexv(iv,_40111,pres,fin),prep(in),w(noun(time,sin,u,n))),nil,_40247,_40565),statreal(_40137,_40299,_40565,_40591),
    determiner00(_40115,_40117,_40137::_40119,_40615,_40591,_40251).

adverbix0(_40111,_40113,_40115,[adverbix0,_40209,!],_40169,_40173) --> 
    adverbix(_40111,_40113,_40115,_40209,_40169,_40173),
    !.

adverbix0(redundantly,nil:thing,_40119::_40119,[adverbix0,[]],_40167,_40167) --> 
    [].

adverbix(_40111,nil:_40127,_40119::_40119,[adverbix,_40233,{}],_40193,_40197) --> 
    w(adv(_40111),_40233,_40193,_40197),
    {particle(_40111,_40127,_40145)}.

adverbix(redundantly,nil:thing,_40119::_40119,[adverbix,_40221,!],_40181,_40185) --> 
    w(adv(redundantly),_40221,_40181,_40185),
    !.

adverbix(_40111,_40113,_40119::_40121,[adverbix,_40215],_40175,_40179) --> 
    adverbial1(_40111,_40113,_40119::_40121,_40215,_40175,_40179).

adverbix(_40111,nil:_40127,_40119::_40119,[adverbix,_40225,_40283],_40185,_40189) --> 
    gradverbs0(_40145,_40225,_40185,_40259),
    adverbx(_40111,_40127,_40141,_40283,_40259,_40189).

adverbix(nil,_40113,_40115,[adverbix,_40241,_40299,_40367],_40201,_40205) --> 
    look_ahead(w(noun(_40145,sin,u,n)),_40241,_40201,_40275),
    gmem(_40145,[midnight],_40299,_40275,_40337),
    complement_nil(_40113,_40115,_40367,_40337,_40205).

adverbix(nil,_40113,_40115,[adverbix,lit(den),_40253,_40311],_40191,_40195) --> 
    cc(den,_40191,_40251),
    look_ahead(w(nb(_40149,_40151)),_40253,_40251,_40287),
    complement_nil(_40113,_40115,_40311,_40287,_40195).

adverbial(_40111,_40113,_40119::_40121,[adverbial,_40215],_40175,_40179) --> 
    adverbial3(_40111,_40113,_40119::_40121,_40215,_40175,_40179).

adverbial(_40111,_40113,_40119::_40121,[adverbial,_40215],_40175,_40179) --> 
    adverbial1(_40111,_40113,_40119::_40121,_40215,_40175,_40179).

preadverbial0(_40111,_40113,_40115,[preadverbial0,_40209,!],_40169,_40173) --> 
    adverbial1(_40111,_40113,_40115,_40209,_40169,_40173),
    !.

preadverbial0(redundantly,nil:thing,_40119::_40119,[preadverbial0,[]],_40167,_40167) --> 
    [].

preadverbial1(_40111,_40113,_40115,[preadverbial1,_40287,_40345,_40403,{},_40475,!],_40247,_40251) --> 
    w(nb(_40153,num),_40287,_40247,_40321),
    w(noun(minute,_40165,_40167,_40169),_40345,_40321,_40379),
    look_ahead(w(prep(_40181)),_40403,_40379,_40437),
    {testmember(_40181,[before,after])},
    adverbial1(_40111,_40113,_40115,_40475,_40437,_40251),
    !.

preadverbial1(_40111,_40113,_40115,[preadverbial1,_40223,_40281,_40329],_40183,_40187) --> 
    not_look_ahead([e],_40223,_40183,_40257),
    not_look_ahead_np(_40281,_40257,_40311),
    adverbix(_40111,_40113,_40115,_40329,_40311,_40187).

preadverbial1(nil,_40113,_40115,[preadverbial1,_40251,!,_40319,_40367],_40211,_40215) --> 
    w(adj2(early,nil),_40251,_40211,_40285),
    !,
    accept(_40319,_40285,_40349),
    pushstack(first,w(noun(morning,sin,u,n)),nil,_40349,_40387),
    adjunct1(nil,_40113,_40115,_40367,_40387,_40215).

preadverbial1(before,1200:clock,_40119::_40119 and 1200 isa clock,[preadverbial1,_40233],_40193,_40197) --> 
    w(noun(morning,sin,u,n),_40233,_40193,_40197).

preadverbial1(before,1200:clock,_40119::_40119 and 1200 isa clock,[preadverbial1,_40233],_40193,_40197) --> 
    w(noun(prenoon,sin,u,n),_40233,_40193,_40197).

preadverbial1(after,1200:clock,_40119::_40119 and 1200 isa clock,[preadverbial1,_40233],_40193,_40197) --> 
    w(noun(afternoon,sin,u,n),_40233,_40193,_40197).

preadverbial1(after,1800:clock,_40119::_40119 and 1800 isa clock,[preadverbial1,_40233],_40193,_40197) --> 
    w(noun(night,sin,u,n),_40233,_40193,_40197).

preadverbial1(nil,_40113,_40115,[preadverbial1,_40213,!,_40291],_40173,_40177) --> 
    obviousclock1(_40113,_40115,_40213,_40173,_40251),
    !,
    accept(_40291,_40251,_40177).

preadverbial1(nil,_40113,_40115,[preadverbial1,_40213,!,_40291],_40173,_40177) --> 
    obviousdate1(_40113,_40115,_40213,_40173,_40251),
    !,
    accept(_40291,_40251,_40177).

preadverbials([preadverbials,_40169,!,_40227],_40147,_40151) --> 
    redundant(_40169,_40147,_40199),
    !,
    preadverbials(_40227,_40199,_40151).

preadverbials([preadverbials,_40203,!,[],_40401,_40449],_40181,_40185) --> 
    adverbix(_40135,_40137,_40139,_40203,_40181,_40245),
    !,
    pushstack(free,xadverbial1(_40135,_40137,_40139),nil,_40245,_40399),[],
    adverbial_conjunction0(_40401,_40399,_40431),
    preadverbials0(_40449,_40431,_40185).

preadverbials0([preadverbials0,_40163,!],_40141,_40145) --> 
    preadverbials(_40163,_40141,_40145),
    !.

preadverbials0([preadverbials0,[]],_40135,_40135) --> 
    [].

adverbial_conjunction0([adverbial_conjunction0,_40163,!],_40141,_40145) --> 
    adverbial_conjunction(_40163,_40141,_40145),
    !.

adverbial_conjunction0([adverbial_conjunction0,[]],_40135,_40135) --> 
    [].

adverbial_conjunction([adverbial_conjunction,lit(og),_40207,!],_40163,_40167) --> 
    cc(og,_40163,_40205),
    look_ahead(w(prep(_40135)),_40207,_40205,_40167),
    !.

adverbial1(_40111,_40113,_40115,[adverbial1,lit(slik),!,_40295],_40223,_40227) --> 
    cc(slik,_40223,_40283),
    !,
    pushstack(first,(w(prep(in)),w(noun(way,sin,def,n)),[som]),nil,_40283,_40315),
    adjunct1(_40111,_40113,_40115,_40295,_40315,_40227).

adverbial1(_40111,_40113,_40115,[adverbial1,lit(dit),_40315,!,_40393],_40253,_40257) --> 
    cc(dit,_40253,_40313),
    lit_of(_40159,[jeg,du],_40315,_40313,_40353),
    !,
    pushstack(first,(w(prep(to)),w(noun(place,sin,def,n)),[som],[_40159]),nil,_40353,_40413),
    adjunct1(_40111,_40113,_40115,_40393,_40413,_40257).

adverbial1(ago,_40113,_40115,[adverbial1,_40287,_40345,_40403,lit(siden),!,_40493],_40247,_40251) --> 
    prep1(for,_40287,_40247,_40321),
    anumber(_40179,_40345,_40321,_40379),
    w(noun(_40165,_40189,u,n),_40403,_40379,_40437),
    cc(siden,_40437,_40481),
    !,
    lock(exact,_40481,_40605),
    pushstack(exact,(number(_40179),w(noun(_40165,plu,u,n))),nil,_40605,_40617),
    np1(_40113,_40115,_40493,_40617,_40595),
    unlock(_40595,_40251).

adverbial1(in,_40137:day,_40119::exists(_40137:morrow)::_40137 isa morrow and _40119,[adverbial1,_40247,!,_40305],_40207,_40211) --> 
    tomorrow(_40247,_40207,_40277),
    !,
    accept(_40305,_40277,_40211).

adverbial1(_40111,_40113,_40115,[adverbial1,_40203],_40163,_40167) --> 
    adjunct1(_40111,_40113,_40115,_40203,_40163,_40167).

adverbial1(in,_40137:_40139,_40119::exists(_40137:_40139)::_40137 isa _40139 and _40119,[adverbial1,_40305,{},!,_40387],_40265,_40269) --> 
    w(noun(_40139,_40183,_40185,n),_40305,_40265,_40339),
    {testmember(_40139,[monday,tuesday,wednesday,thursday,friday,saturday,sunday])},
    !,
    accept(_40387,_40339,_40269).

adverbial3(_40111,_40125:_40127,_40119::_40121,[adverbial3,_40311,_40389,[],_40553,_40703],_40271,_40275) --> 
    xsubjunction(_40111,_40127,_40173,_40311,_40271,_40353),
    adverbial_object00(_40125:_40127,_40179,_40389,_40353,_40427),
    pushstack(free,adverbial1(_40173,_40125:_40127,_40179),nil,_40427,_40551),[],
    pushstack(first,([jeg],aux1),nil,_40551,_40653),substatement1(_40163,_40553,_40653,_40679),
    determiner00(_40125:_40127,_40119,_40163::_40121,_40703,_40679,_40275).

adverbial3(_40111,_40113,_40115,[adverbial3,lit(før),_40239,!,_40297],_40177,_40181) --> 
    cc(før,_40177,_40237),
    look_ahead_time(_40239,_40237,_40269),
    !,
    reject(_40297,_40269,_40181).

adverbial3(_40111,_40113,_40119::_40121,[adverbial3,lit(til),_40309,_40367,!,_40435,_40531],_40247,_40251) --> 
    cc(til,_40247,_40307),
    not_look_ahead([j],_40309,_40307,_40343),
    look_ahead([jeg],_40367,_40343,_40401),
    !,
    pushstack(first,w(prep(to)),nil,_40401,_40461),subordinate(_40111,_40113,_40163,_40435,_40461,_40495),
    determiner00(_40113,_40119,_40163::_40121,_40531,_40495,_40251).

adverbial3(_40111,_40113,_40119::_40121,[adverbial3,_40243,_40301,_40379],_40203,_40207) --> 
    not_look_ahead([til],_40243,_40203,_40277),
    subordinate(_40111,_40113,_40145,_40301,_40277,_40343),
    determiner00(_40113,_40119,_40145::_40121,_40379,_40343,_40207).

adverbial4(_40111,_40113,_40119::_40119 and _40127,[adverbial4,_40261,_40319,_40377,{}],_40221,_40225) --> 
    not_look_ahead([om],_40261,_40221,_40295),
    prep(_40155,_40319,_40295,_40353),
    clausal_object0(_40113,true::_40127,_40377,_40353,_40225),
    {adjustprep(_40113,_40155,_40111)}.

adverbial4(_40111,_40113,_40119::_40119 and _40127,[adverbial4,_40271,_40329,lit(at),_40409,{}],_40231,_40235) --> 
    not_look_ahead([om],_40271,_40231,_40305),
    prep(_40161,_40329,_40305,_40363),
    cc(at,_40363,_40407),
    clausal_object1(_40113,true::_40127,_40409,_40407,_40235),
    {adjustprep(_40113,_40161,_40111)}.

subordinate(nil,_40119:coevent,_40115,[subordinate,lit(de),lit(samme),lit(som),_40367,_40435],_40261,_40265) --> 
    cc(de,_40261,_40321),
    cc(samme,_40321,_40343),
    cc(som,_40343,_40365),
    adverbial_object00(_40119:coevent,_40171,_40367,_40365,_40405),
    lock(last,_40405,_40537),
    pushstack(last,([de],w(verb(be,pres,fin)),adverbial1(nil,_40119:coevent,_40171)),nil,_40537,_40549),
    substatement1(_40115,_40435,_40549,_40527),
    unlock(_40527,_40265).

subordinate(_40111,_40113,_40115,[subordinate,_40253,{},_40325,!,_40393],_40213,_40217) --> 
    w(prep(_40147),_40253,_40213,_40287),
    {testmember(_40147,[instead_of])},
    not_look_ahead_lit([at,å],_40325,_40287,_40359),
    !,
    reject(_40393,_40359,_40217).

subordinate(_40111,_40113,_40115,[subordinate,_40269,_40327,_40385,{},!,_40467],_40229,_40233) --> 
    not_look_ahead([siden],_40269,_40229,_40303),
    w(prep(_40161),_40327,_40303,_40361),
    look_ahead(w(noun(_40173,_40175,_40177,_40179)),_40385,_40361,_40419),
    {subclass0(_40173,time)},
    !,
    reject(_40467,_40419,_40233).

subordinate(_40111,_40113,_40115,[subordinate,_40241,_40319,_40377],_40201,_40205) --> 
    subjunction(_40111,_40133,_40131,_40241,_40201,_40283),
    not_look_ahead(w(verb(_40157,_40159,_40161)),_40319,_40283,_40353),
    subord_clause(_40131,_40133,_40113,_40115,_40377,_40353,_40205).

subord_clause(_40111,_40113,_40121:_40113,_40117,[subord_clause,_40261,!,_40339],_40215,_40219) --> 
    adverbial_object00(_40121:_40113,_40149,_40261,_40215,_40299),
    !,
    lock(last,_40299,_40441),
    pushstack(last,xadverbial1(_40111,_40121:_40113,_40149),nil,_40441,_40453),
    substatement1(_40117,_40339,_40453,_40431),
    unlock(_40431,_40219).

adverbial_object00(_40135:_40137,_40117::exists(_40135:_40137)::_40135 isa _40137 and _40117,[adverbial_object00,[]],_40189,_40189) --> 
    [].

subordinateinfnosubj(_40111,_40113,_40115,_40117,_40119,[subordinateinfnosubj,{},_40307,!,_40395],_40241,_40245) --> 
    {it_template(_40115)},
    np00(_40113,_40155,_40161::_40163,_40307,_40241,_40349),
    !,
    pushstack(free,(npgap(_40115),adverbial1(_40111,_40155,_40161::_40163)),nil,_40349,_40581),
    statreal(_40119,_40395,_40581,_40245).

subordinateinfnosubj(_40111,_40113,_40115,_40117,_40119,[subordinateinfnosubj,{},_40377,{},!,_40489,!,_40577],_40311,_40315) --> 
    {\+it_template(_40115)},
    lexv(tv,_40211,_40213,fin,_40377,_40311,_40423),
    {testmember(_40211,[take])},
    !,
    np00(_40113,_40185,_40191::_40193,_40489,_40423,_40531),
    !,
    pushstack(free,(someone,w(verb(_40211,pres,fin)),npgap(_40115),adverbial1(_40111,_40185,_40191::_40193)),nil,_40531,_40837),
    statreal(_40119,_40577,_40837,_40315).

subordinateinfnosubj(_40111,_40113,_40115,_40117,_40119,[subordinateinfnosubj,{},_40377,{},!,_40489,!,_40577],_40311,_40315) --> 
    {\+it_template(_40115)},
    lexv(tv,_40211,_40213,fin,_40377,_40311,_40423),
    {testmember(_40211,[help])},
    !,
    np00(_40113,_40185,_40191::_40193,_40489,_40423,_40531),
    !,
    pushstack(free,(npgap(_40115),w(verb(_40211,pres,fin)),someone,adverbial1(_40111,_40185,_40191::_40193)),nil,_40531,_40837),
    statreal(_40119,_40577,_40837,_40315).

partday(_40111,_40113,_40115,[partday,_40233,{},!],_40193,_40197) --> 
    w(noun(_40111,_40137,_40139,n),_40233,_40193,_40197),
    {particle(_40111,_40113,_40115)},
    !.

partday(tomorrow,_40113,_40115,[partday,_40263,_40311,_40369,_40427,!,{}],_40223,_40227) --> 
    to0(_40263,_40223,_40293),
    prep1(in,_40311,_40293,_40345),
    not_look_ahead([formiddag],_40369,_40345,_40403),
    w(noun(morning,_40179,_40181,n),_40427,_40403,_40227),
    !,
    {particle(tomorrow,_40113,_40115)}.

partday(tomorrow,_40113,_40115,[partday,_40249,_40297,_40355,!,{}],_40209,_40213) --> 
    to0(_40249,_40209,_40279),
    prep1(in,_40297,_40279,_40331),
    w(noun(morrow,_40165,_40167,n),_40355,_40331,_40213),
    !,
    {particle(tomorrow,_40113,_40115)}.

partday(_40111,_40113,_40115,[partday,_40261,_40319,!,{},{}],_40221,_40225) --> 
    inom(_40155,_40261,_40221,_40295),
    w(noun(_40163,_40165,_40167,n),_40319,_40295,_40225),
    !,
    {norpart(_40155,_40163,_40111)},
    {particle(_40111,_40113,_40115)}.

adverbx(with,mode,post,[adverbx,lit(med),_40233,!],_40171,_40175) --> 
    cc(med,_40171,_40231),
    not_look_ahead_np(_40233,_40231,_40175),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),_40233,!],_40171,_40175) --> 
    cc(etter,_40171,_40231),
    terminatore(_40233,_40231,_40175),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),lit(det),!],_40175,_40179) --> 
    cc(etter,_40175,_40235),
    cc(det,_40235,_40179),
    !.

adverbx(earlier,time,post,[adverbx,lit(før),lit(det),!],_40175,_40179) --> 
    cc(før,_40175,_40235),
    cc(det,_40235,_40179),
    !.

adverbx(_40111,_40113,_40115,[adverbx,lit(slik),lit(at),!,_40275],_40181,_40185) --> 
    cc(slik,_40181,_40241),
    cc(at,_40241,_40263),
    !,
    reject(_40275,_40263,_40185).

adverbx(_40111,_40113,_40115,[adverbx,_40233,_40281,!,{}],_40193,_40197) --> 
    not_look_ahead_prepx(_40233,_40193,_40263),
    w(adv(_40111),_40281,_40263,_40197),
    !,
    {particle(_40111,_40113,_40115)}.

not_look_ahead_prepx([not_look_ahead_prepx,lit(med),_40195,!],_40151,_40155) --> 
    cc(med,_40151,_40193),
    look_ahead_np(_40195,_40193,_40155),
    !.

not_look_ahead_prepx([not_look_ahead_prepx,_40169],_40147,_40151) --> 
    not_look_ahead(w(prep(_40119)),_40169,_40147,_40151).

adverbx(_40111,_40113,_40115,[adverbx,_40203],_40163,_40167) --> 
    adverb(_40111,_40113,_40115,_40203,_40163,_40167).

adverbx(_40111,_40113,_40115,[adverbx,_40203],_40163,_40167) --> 
    partday(_40111,_40113,_40115,_40203,_40163,_40167).

adverbx(yesterday,_40113,_40115,[adverbx,_40233,lit(går),!,{}],_40193,_40197) --> 
    prep1(in,_40233,_40193,_40267),
    cc(går,_40267,_40197),
    !,
    {particle(yesterday,_40113,_40115)}.

anyadverb0([anyadverb0,_40197,_40245,!,[]],_40175,_40179) --> 
    therenot0(_40197,_40175,_40227),
    adverb(_40135,_40137,_40139,_40245,_40227,_40287),
    !,
    pushstack(free,adverb(_40135,_40137,_40139),nil,_40287,_40179),
    [].

anyadverb0([anyadverb0,_40157],_40135,_40139) --> 
    therenot0(_40157,_40135,_40139).

adverbx0([adverbx0,_40171,!],_40149,_40153) --> 
    w(adv(redundantly),_40171,_40149,_40153),
    !.

adverbx0([adverbx0,_40257,_40315,_40373,{},!,[]],_40235,_40239) --> 
    not_look_ahead(w(noun(_40163,sin,u,n)),_40257,_40235,_40291),
    not_look_ahead(w(prep(_40181)),_40315,_40291,_40349),
    adverb(_40147,_40149,_40151,_40373,_40349,_40415),
    {\+testmember(_40147,[home])},
    !,
    pushstack(free,adverb(_40147,_40149,_40151),nil,_40415,_40239),
    [].

adverbx0([adverbx0,[]],_40135,_40135) --> 
    [].

adverb0(_40111,_40113,_40115,[adverb0,_40209,!],_40169,_40173) --> 
    adverb(_40111,_40113,_40115,_40209,_40169,_40173),
    !.

adverb0(redundantly,thing,post,[adverb0,[]],_40155,_40155) --> 
    [].

adverb(delayed,time,post,[adverb,_40211,!],_40171,_40175) --> 
    w(adj2(delayed,nil),_40211,_40171,_40175),
    !.

adverb(_40111,_40113,_40115,[adverb,_40247,_40305,_40363,{}],_40207,_40211) --> 
    gradverb0(_40149,_40247,_40207,_40281),
    not_look_ahead([siste],_40305,_40281,_40339),
    w(adj2(_40111,nil),_40363,_40339,_40211),
    {particle(_40111,_40113,_40115)}.

adverb(now,_40113,_40115,[adverb,_40223,_40281,{}],_40183,_40187) --> 
    prep1(with,_40223,_40183,_40257),
    detsamme(_40281,_40257,_40187),
    {particle(now,_40113,_40115)}.

adverb(first,time,_40115,[adverb,lit(først)],_40159,_40163) --> 
    cc(først,_40159,_40163).

adverb(today,day,pre,[adverb,_40219,_40277],_40179,_40183) --> 
    prep1(in,_40219,_40179,_40253),
    w(noun(day,sin,u,n),_40277,_40253,_40183).

adverb(tomorrow,day,pre,[adverb,_40209,lit(morgen)],_40169,_40173) --> 
    prep1(in,_40209,_40169,_40243),
    cc(morgen,_40243,_40173).

adverb(day_after_tomorrow,day,pre,[adverb,_40209,lit(overimorgen)],_40169,_40173) --> 
    prep1(in,_40209,_40169,_40243),
    cc(overimorgen,_40243,_40173).

adverb(day_before_yesterday,day,pre,[adverb,_40209,lit(forgårs)],_40169,_40173) --> 
    prep1(in,_40209,_40169,_40243),
    cc(forgårs,_40243,_40173).

adverb(tonight,daypart,pre,[adverb,_40219,_40277],_40179,_40183) --> 
    prep1(in,_40219,_40179,_40253),
    w(noun(night,_40131,_40133,_40135),_40277,_40253,_40183).

adverb(today,day,pre,[adverb,_40219,_40277],_40179,_40183) --> 
    prep1(in,_40219,_40179,_40253),
    w(noun(day,_40131,_40133,_40135),_40277,_40253,_40183).

adverb(locally,place,post,[adverb,lit(lokalt)],_40159,_40163) --> 
    cc(lokalt,_40159,_40163).

adverb(_40111,_40113,_40115,[adverb,_40221,_40279,!,_40337],_40181,_40185) --> 
    w(prep(_40141),_40221,_40181,_40255),
    look_ahead_np(_40279,_40255,_40309),
    !,
    reject(_40337,_40309,_40185).

adverb(_40111,_40113,_40115,[adverb,_40217,{}],_40177,_40181) --> 
    particle(_40111,_40217,_40177,_40181),
    {particle(_40111,_40113,_40115)}.

adverb(_40111,_40113,_40115,[adverb,_40293,{},_40365,_40423,{},_40495],_40253,_40257) --> 
    particle(_40111,_40293,_40253,_40327),
    {testmember(_40111,[on,off])},
    not_look_ahead(w(noun(_40179,_40181,_40183,_40185)),_40365,_40327,_40399),
    not_look_ahead(w(name(_40197,_40199,_40201)),_40423,_40399,_40457),
    {particle(_40111,_40113,_40115)},
    da0(_40495,_40457,_40257).

particlev0(_40111,_40113,[particlev0,_40195,!],_40161,_40165) --> 
    particlev2(_40111,_40113,_40195,_40161,_40165),
    !.

particlev0(_40111,_40111,[particlev0,_40187],_40153,_40157) --> 
    particlev1(_40111,_40187,_40153,_40157).

particlev0(_40111,_40111,[particlev0,[]],_40149,_40149) --> 
    [].

particle0(_40111,[particle0,_40181,!],_40153,_40157) --> 
    particle(_40111,_40181,_40153,_40157),
    !.

particle0(_40111,[particle0,[]],_40143,_40143) --> 
    [].

particlev1(believe,[particlev1,lit(på)],_40147,_40151) --> 
    cc(på,_40147,_40151).

particlev1(calculate,[particlev1,lit(med)],_40147,_40151) --> 
    cc(med,_40147,_40151).

particlev1(check,[particlev1,lit(opp)],_40147,_40151) --> 
    cc(opp,_40147,_40151).

particlev1(come,[particlev1,lit(med),_40203],_40153,_40157) --> 
    cc(med,_40153,_40201),
    not_look_ahead_np(_40203,_40201,_40157).

particlev1(come,[particlev1,lit(til),_40203],_40153,_40157) --> 
    cc(til,_40153,_40201),
    not_look_ahead_np(_40203,_40201,_40157).

particlev1(come,[particlev1,lit(opp)],_40147,_40151) --> 
    cc(opp,_40147,_40151).

particlev1(correct,[particlev1,lit(opp)],_40147,_40151) --> 
    cc(opp,_40147,_40151).

particlev1(fetch,[particlev1,lit(ned)],_40147,_40151) --> 
    cc(ned,_40147,_40151).

particlev1(fetch,[particlev1,lit(opp)],_40147,_40151) --> 
    cc(opp,_40147,_40151).

particlev1(find,[particlev1,lit(ut),lit(av)],_40157,_40161) --> 
    cc(ut,_40157,_40205),
    cc(av,_40205,_40161).

particlev1(get,[particlev1,lit(med)],_40147,_40151) --> 
    cc(med,_40147,_40151).

particlev1(get,[particlev1,lit(opp)],_40147,_40151) --> 
    cc(opp,_40147,_40151).

particlev1(have,[particlev1,lit(på)],_40147,_40151) --> 
    cc(på,_40147,_40151).

particlev1(help,[particlev1,lit(til),lit(med)],_40157,_40161) --> 
    cc(til,_40157,_40205),
    cc(med,_40205,_40161).

particlev1(help,[particlev1,lit(til)],_40147,_40151) --> 
    cc(til,_40147,_40151).

particlev1(improve,[particlev1,lit(inn)],_40147,_40151) --> 
    cc(inn,_40147,_40151).

particlev1(indicte,[particlev1,lit(på)],_40147,_40151) --> 
    cc(på,_40147,_40151).

particlev1(lay,[particlev1,lit(inn)],_40147,_40151) --> 
    cc(inn,_40147,_40151).

particlev1(lie1,[particlev1,lit(med)],_40147,_40151) --> 
    cc(med,_40147,_40151).

particlev1(name,[particlev1,lit(til)],_40147,_40151) --> 
    cc(til,_40147,_40151).

particlev1(reach,[particlev1,lit(til)],_40147,_40151) --> 
    cc(til,_40147,_40151).

particlev1(reach,[particlev1,lit(fram),lit(til)],_40157,_40161) --> 
    cc(fram,_40157,_40205),
    cc(til,_40205,_40161).

particlev1(read,[particlev1,lit(gjennom)],_40147,_40151) --> 
    cc(gjennom,_40147,_40151).

particlev1(receive,[particlev1,lit(opp)],_40147,_40151) --> 
    cc(opp,_40147,_40151).

particlev1(get,[particlev1,lit(opp)],_40147,_40151) --> 
    cc(opp,_40147,_40151).

particlev1(send,[particlev1,lit(med)],_40147,_40151) --> 
    cc(med,_40147,_40151).

particlev1(send,[particlev1,lit(over)],_40147,_40151) --> 
    cc(over,_40147,_40151).

particlev1(send,[particlev1,lit(ved)],_40147,_40151) --> 
    cc(ved,_40147,_40151).

particlev1(sing,[particlev1,lit(ut)],_40147,_40151) --> 
    cc(ut,_40147,_40151).

particlev1(take,[particlev1,lit(ut)],_40147,_40151) --> 
    cc(ut,_40147,_40151).

particlev1(throw,[particlev1,lit(av)],_40147,_40151) --> 
    cc(av,_40147,_40151).

particlev1(tell,[particlev1,lit(inn)],_40147,_40151) --> 
    cc(inn,_40147,_40151).

particlev1(tell,[particlev1,lit(om)],_40147,_40151) --> 
    cc(om,_40147,_40151).

particlev1(tell,[particlev1,lit(fra),lit(om),!],_40163,_40167) --> 
    cc(fra,_40163,_40211),
    cc(om,_40211,_40167),
    !.

particlev1(tell,[particlev1,lit(fra)],_40147,_40151) --> 
    cc(fra,_40147,_40151).

particlev1(tell,[particlev1,lit(ifra)],_40147,_40151) --> 
    cc(ifra,_40147,_40151).

particlev1(tell,[particlev1,_40179],_40151,_40155) --> 
    w(prep(regarding),_40179,_40151,_40155).

particlev1(wonder,[particlev1,lit(på)],_40147,_40151) --> 
    cc(på,_40147,_40151).

particlev1(write,[particlev1,lit(inn)],_40147,_40151) --> 
    cc(inn,_40147,_40151).

particlev2(avoid,release,[particlev2,lit(fri)],_40153,_40157) --> 
    cc(fri,_40153,_40157).

particlev2(be,come,[particlev2,lit(med)],_40153,_40157) --> 
    cc(med,_40153,_40157).

particlev2(belong,belong_to,[particlev2,lit(til)],_40153,_40157) --> 
    cc(til,_40153,_40157).

particlev2(hear,belong_to,[particlev2,lit(til)],_40153,_40157) --> 
    cc(til,_40153,_40157).

particlev2(calculate,expect,[particlev2,lit(med)],_40153,_40157) --> 
    cc(med,_40153,_40157).

particlev2(care1,ensure,[particlev2,lit(for)],_40153,_40157) --> 
    cc(for,_40153,_40157).

particlev2(come,appear,[particlev2,lit(fram)],_40153,_40157) --> 
    cc(fram,_40153,_40157).

particlev2(come,disappear,[particlev2,lit(bort),_40227],_40171,_40175) --> 
    cc(bort,_40171,_40225),
    not_look_ahead(w(prep(to)),_40227,_40225,_40175).

particlev2(comment,remove,[particlev2,lit(ut)],_40153,_40157) --> 
    cc(ut,_40153,_40157).

particlev2(do1,finish,[particlev2,lit(ferdig)],_40153,_40157) --> 
    cc(ferdig,_40153,_40157).

particlev2(do1,make,[particlev2,lit(meg)],_40153,_40157) --> 
    cc(meg,_40153,_40157).

particlev2(find,do1,[particlev2,lit(på)],_40153,_40157) --> 
    cc(på,_40153,_40157).

particlev2(find,discover,[particlev2,lit(ut)],_40153,_40157) --> 
    cc(ut,_40153,_40157).

particlev2(fool,wonder,[particlev2,lit(på)],_40153,_40157) --> 
    cc(på,_40153,_40157).

particlev2(go,stop,[particlev2,lit(ned)],_40153,_40157) --> 
    cc(ned,_40153,_40157).

particlev2(get,manage,[particlev2,lit(til)],_40153,_40157) --> 
    cc(til,_40153,_40157).

particlev2(have,bring,[particlev2,lit(med)],_40153,_40157) --> 
    cc(med,_40153,_40157).

particlev2(hold,be,[particlev2,lit(deg)],_40153,_40157) --> 
    cc(deg,_40153,_40157).

particlev2(hold,be,[particlev2,lit(meg)],_40153,_40157) --> 
    cc(meg,_40153,_40157).

particlev2(hold,be,[particlev2,lit(seg)],_40153,_40157) --> 
    cc(seg,_40153,_40157).

particlev2(hold,do1,[particlev2,lit(på),lit(med)],_40163,_40167) --> 
    cc(på,_40163,_40217),
    cc(med,_40217,_40167).

particlev2(hold,be1,[particlev2,lit(til)],_40153,_40157) --> 
    cc(til,_40153,_40157).

particlev2(hold,wait,[particlev2,lit(ut)],_40153,_40157) --> 
    cc(ut,_40153,_40157).

particlev2(improve,ensure,[particlev2,lit(inn)],_40153,_40157) --> 
    cc(inn,_40153,_40157).

particlev2(lay,include,[particlev2,lit(inn)],_40153,_40157) --> 
    cc(inn,_40153,_40157).

particlev2(lay,include,[particlev2,lit(på)],_40153,_40157) --> 
    cc(på,_40153,_40157).

particlev2(lay,enclose,[particlev2,lit(ved)],_40153,_40157) --> 
    cc(ved,_40153,_40157).

particlev2(lay,stop,[particlev2,lit(ned)],_40153,_40157) --> 
    cc(ned,_40153,_40157).

particlev2(lay,change,[particlev2,lit(om)],_40153,_40157) --> 
    cc(om,_40153,_40157).

particlev2(lead,cause,[particlev2,lit(til)],_40153,_40157) --> 
    cc(til,_40153,_40157).

particlev2(lie1,belong_to,[particlev2,lit(under)],_40153,_40157) --> 
    cc(under,_40153,_40157).

particlev2(list,list,[particlev2,lit(opp)],_40153,_40157) --> 
    cc(opp,_40153,_40157).

particlev2(long,want,[particlev2,lit(etter)],_40153,_40157) --> 
    cc(etter,_40153,_40157).

particlev2(look,appear,[particlev2,lit(ut)],_40153,_40157) --> 
    cc(ut,_40153,_40157).

particlev2(meet,meetup,[particlev2,lit(opp)],_40153,_40157) --> 
    cc(opp,_40153,_40157).

particlev2(negotiate,discuss,[particlev2,lit(om)],_40153,_40157) --> 
    cc(om,_40153,_40157).

particlev2(operate,do1,[particlev2,_40201,lit(med)],_40167,_40171) --> 
    optional([på],_40201,_40167,_40265),
    cc(med,_40265,_40171).

particlev2(pay,pay2,[particlev2,lit(seg)],_40153,_40157) --> 
    cc(seg,_40153,_40157).

particlev2(put,arrange,[particlev2,lit(opp)],_40153,_40157) --> 
    cc(opp,_40153,_40157).

particlev2(say,tell,[particlev2,lit(fra)],_40153,_40157) --> 
    cc(fra,_40153,_40157).

particlev2(say,tell,[particlev2,lit(ifra)],_40153,_40157) --> 
    cc(ifra,_40153,_40157).

particlev2(see,appear,[particlev2,lit(ut)],_40153,_40157) --> 
    cc(ut,_40153,_40157).

particlev2(see,appear,[particlev2,lit(ut)],_40153,_40157) --> 
    cc(ut,_40153,_40157).

particlev2(stand,indicate,[particlev2,lit(for)],_40153,_40157) --> 
    cc(for,_40153,_40157).

particlev2(take,bring,[particlev2,lit(med)],_40153,_40157) --> 
    cc(med,_40153,_40157).

particlev2(take,manage,[particlev2,lit(over)],_40153,_40157) --> 
    cc(over,_40153,_40157).

particlev2(take,get,[particlev2,lit(til),_40215],_40159,_40163) --> 
    cc(til,_40159,_40213),
    rfxpron(_40215,_40213,_40163).

particlev2(take,get,[particlev2,lit(mot)],_40153,_40157) --> 
    cc(mot,_40153,_40157).

particlev2(take,get,[particlev2,lit(imot)],_40153,_40157) --> 
    cc(imot,_40153,_40157).

particlev2(take,get,[particlev2,lit(i),lit(mot)],_40163,_40167) --> 
    cc(i,_40163,_40217),
    cc(mot,_40217,_40167).

particlev2(take,treat,[particlev2,lit(opp)],_40153,_40157) --> 
    cc(opp,_40153,_40157).

particlev2(turn,stop,[particlev2,lit(av)],_40153,_40157) --> 
    cc(av,_40153,_40157).

particlev2(turn,start,[particlev2,lit(på)],_40153,_40157) --> 
    cc(på,_40153,_40157).

particlev2(write,print,[particlev2,lit(ut)],_40153,_40157) --> 
    cc(ut,_40153,_40157).

rep_particlev0(_40111,[rep_particlev0,_40181,!],_40153,_40157) --> 
    rep_particlev(_40111,_40181,_40153,_40157),
    !.

rep_particlev0(_40111,[rep_particlev0,[]],_40143,_40143) --> 
    [].

rep_particlev(ask,[rep_particlev,lit(:),!],_40153,_40157) --> 
    cc(:,_40153,_40157),
    !.

rep_particlev(deny,[rep_particlev,lit(for)],_40147,_40151) --> 
    cc(for,_40147,_40151).

rep_particlev(wonder,[rep_particlev,lit(på),_40215,!,_40273],_40165,_40169) --> 
    cc(på,_40165,_40213),
    which0(_40215,_40213,_40245),
    !,
    accept(_40273,_40245,_40169).

rep_particlev(know,[rep_particlev,_40187,!,_40255],_40159,_40163) --> 
    prep1(to,_40187,_40159,_40221),
    !,
    accept(_40255,_40221,_40163).

rep_particlev(find,[rep_particlev,lit(ut)],_40147,_40151) --> 
    cc(ut,_40147,_40151).

rep_particlev(recognize,[rep_particlev,lit(til)],_40147,_40151) --> 
    cc(til,_40147,_40151).

rep_particlev(think,[rep_particlev,lit(på),_40223,!,_40291],_40173,_40177) --> 
    cc(på,_40173,_40221),
    not_look_ahead([om],_40223,_40221,_40257),
    !,
    reject(_40291,_40257,_40177).

rep_particlev(think,[rep_particlev,lit(på),_40223,!,_40291],_40173,_40177) --> 
    cc(på,_40173,_40221),
    not_look_ahead([at],_40223,_40221,_40257),
    !,
    reject(_40291,_40257,_40177).

rep_particlev(think,[rep_particlev,lit(på),!,_40219],_40159,_40163) --> 
    cc(på,_40159,_40207),
    !,
    accept(_40219,_40207,_40163).

particle(redundantly,[particle,_40171],_40143,_40147) --> 
    redundant(_40171,_40143,_40147).

particle(_40111,[particle,_40185,!],_40157,_40161) --> 
    w(adv(_40111),_40185,_40157,_40161),
    !.

particle(back,[particle,lit(tilbake)],_40147,_40151) --> 
    cc(tilbake,_40147,_40151).

particle(badly,[particle,lit(dårlig)],_40147,_40151) --> 
    cc(dårlig,_40147,_40151).

particle(beforethat,[particle,_40171],_40143,_40147) --> 
    beforethat(_40171,_40143,_40147).

particle(daily,[particle,lit(daglig)],_40147,_40151) --> 
    cc(daglig,_40147,_40151).

particle(day_after_tomorrow,[particle,lit(overimorgen)],_40147,_40151) --> 
    cc(overimorgen,_40147,_40151).

particle(directly,[particle,lit(direkte)],_40147,_40151) --> 
    cc(direkte,_40147,_40151).

particle(down,[particle,lit(ned)],_40147,_40151) --> 
    cc(ned,_40147,_40151).

particle(down,[particle,lit(under)],_40147,_40151) --> 
    cc(under,_40147,_40151).

particle(earlier,[particle,_40171],_40143,_40147) --> 
    earlier(_40171,_40143,_40147).

particle(early,[particle,lit(så),lit(tidlig),lit(som),_40289,!,_40357],_40195,_40199) --> 
    cc(så,_40195,_40243),
    cc(tidlig,_40243,_40265),
    cc(som,_40265,_40287),
    w(adj2(possible,nil),_40289,_40287,_40323),
    !,
    accept(_40357,_40323,_40199).

particle(early,[particle,lit(tidligst),_40225,!,_40293],_40175,_40179) --> 
    cc(tidligst,_40175,_40223),
    w(adj2(possible,nil),_40225,_40223,_40259),
    !,
    accept(_40293,_40259,_40179).

particle(early,[particle,lit(tidlig)],_40147,_40151) --> 
    cc(tidlig,_40147,_40151).

particle(early,[particle,lit(am)],_40147,_40151) --> 
    cc(am,_40147,_40151).

particle(eastward,[particle,lit(østover)],_40147,_40151) --> 
    cc(østover,_40147,_40151).

particle(everywhere,[particle,lit(overalt)],_40147,_40151) --> 
    cc(overalt,_40147,_40151).

particle(far,[particle,lit(langt)],_40147,_40151) --> 
    cc(langt,_40147,_40151).

particle(fast,[particle,lit(fort)],_40147,_40151) --> 
    cc(fort,_40147,_40151).

particle(fast,[particle,_40181],_40153,_40157) --> 
    w(adj2(fast,comp),_40181,_40153,_40157).

particle(from,[particle,lit(ifra)],_40147,_40151) --> 
    cc(ifra,_40147,_40151).

particle(gratis,[particle,lit(gratis)],_40147,_40151) --> 
    cc(gratis,_40147,_40151).

particle(home,[particle,lit(hjem),_40219,!,_40287],_40169,_40173) --> 
    cc(hjem,_40169,_40217),
    prep1(to,_40219,_40217,_40253),
    !,
    reject(_40287,_40253,_40173).

particle(home,[particle,_40181,lit(hjem)],_40153,_40157) --> 
    to0(_40181,_40153,_40211),
    cc(hjem,_40211,_40157).

particle(here,[particle,_40181,lit(hit)],_40153,_40157) --> 
    to0(_40181,_40153,_40211),
    cc(hit,_40211,_40157).

particle(here,[particle,_40181,lit(her)],_40153,_40157) --> 
    to0(_40181,_40153,_40211),
    cc(her,_40211,_40157).

particle(hereafter,[particle,_40171],_40143,_40147) --> 
    hereafter(_40171,_40143,_40147).

particle(in,[particle,lit(inn)],_40147,_40151) --> 
    cc(inn,_40147,_40151).

particle(in_morning,[particle,lit(ommorgenen)],_40147,_40151) --> 
    cc(ommorgenen,_40147,_40151).

particle(late,[particle,_40181,lit(sent)],_40153,_40157) --> 
    so0(_40181,_40153,_40211),
    cc(sent,_40211,_40157).

particle(late,[particle,_40181,lit(sent)],_40153,_40157) --> 
    too(_40181,_40153,_40211),
    cc(sent,_40211,_40157).

particle(lay,[particle,lit(ut)],_40147,_40151) --> 
    cc(ut,_40147,_40151).

particle(lay,[particle,lit(inn)],_40147,_40151) --> 
    cc(inn,_40147,_40151).

particle(lay,[particle,lit(ved)],_40147,_40151) --> 
    cc(ved,_40147,_40151).

particle(logically,[particle,lit(logisk)],_40147,_40151) --> 
    cc(logisk,_40147,_40151).

particle(much,[particle,_40181,lit(mye)],_40153,_40157) --> 
    so(_40181,_40153,_40211),
    cc(mye,_40211,_40157).

particle(normally,[particle,lit(normalt)],_40147,_40151) --> 
    cc(normalt,_40147,_40151).

particle(northward,[particle,lit(nordover)],_40147,_40151) --> 
    cc(nordover,_40147,_40151).

particle(now,[particle,_40171],_40143,_40147) --> 
    now1(_40171,_40143,_40147).

particle(now,[particle,_40185,lit(øyeblikket)],_40157,_40161) --> 
    prep1(for,_40185,_40157,_40219),
    cc(øyeblikket,_40219,_40161).

particle(on,[particle,_40175],_40147,_40151) --> 
    prep1(on,_40175,_40147,_40151).

particle(off,[particle,lit(av)],_40147,_40151) --> 
    cc(av,_40147,_40151).

particle(offside,[particle,_40177,_40225],_40149,_40153) --> 
    and0(_40177,_40149,_40207),
    compassly(_40225,_40207,_40153).

particle(often,[particle,_40181,lit(ofte)],_40153,_40157) --> 
    so0(_40181,_40153,_40211),
    cc(ofte,_40211,_40157).

particle(recently,[particle,_40171],_40143,_40147) --> 
    recently(_40171,_40143,_40147).

particle(out,[particle,lit(ut)],_40147,_40151) --> 
    cc(ut,_40147,_40151).

particle(past,[particle,lit(forbi)],_40147,_40151) --> 
    cc(forbi,_40147,_40151).

particle(present,[particle,lit(framme)],_40147,_40151) --> 
    cc(framme,_40147,_40151).

particle(punctually,[particle,lit(presis)],_40147,_40151) --> 
    cc(presis,_40147,_40151).

particle(punctually,[particle,_40181],_40153,_40157) --> 
    w(adj2(punctual,nil),_40181,_40153,_40157).

particle(punctually,[particle,_40185,lit(tide)],_40157,_40161) --> 
    prep1(in,_40185,_40157,_40219),
    cc(tide,_40219,_40161).

particle(regularly,[particle,lit(som),lit(normalt)],_40157,_40161) --> 
    cc(som,_40157,_40205),
    cc(normalt,_40205,_40161).

particle(silent,[particle,lit(stille)],_40147,_40151) --> 
    cc(stille,_40147,_40151).

particle(simultaneously,[particle,lit(samtidig)],_40147,_40151) --> 
    cc(samtidig,_40147,_40151).

particle(slowly,[particle,lit(langsomt)],_40147,_40151) --> 
    cc(langsomt,_40147,_40151).

particle(somewhere,[particle,lit(noensted)],_40147,_40151) --> 
    cc(noensted,_40147,_40151).

particle(southward,[particle,lit(sørover)],_40147,_40151) --> 
    cc(sørover,_40147,_40151).

particle(there,[particle,lit(dit)],_40147,_40151) --> 
    cc(dit,_40147,_40151).

particle(there,[particle,lit(der)],_40147,_40151) --> 
    cc(der,_40147,_40151).

particle(there,[particle,_40181],_40153,_40157) --> 
    w(adj2(present,nil),_40181,_40153,_40157).

particle(thereafter,[particle,_40171],_40143,_40147) --> 
    thereafter(_40171,_40143,_40147).

particle(this_midnight,[particle,lit(inatt)],_40147,_40151) --> 
    cc(inatt,_40147,_40151).

particle(today,[particle,lit(idag)],_40147,_40151) --> 
    cc(idag,_40147,_40151).

particle(together,[particle,lit(sammen)],_40147,_40151) --> 
    cc(sammen,_40147,_40151).

particle(tomorrow,[particle,lit(imorgen)],_40147,_40151) --> 
    cc(imorgen,_40147,_40151).

particle(tonight,[particle,lit(ikveld)],_40147,_40151) --> 
    cc(ikveld,_40147,_40151).

particle(up,[particle,lit(opp)],_40147,_40151) --> 
    cc(opp,_40147,_40151).

particle(well,[particle,lit(bra)],_40147,_40151) --> 
    cc(bra,_40147,_40151).

particle(well,[particle,lit(best)],_40147,_40151) --> 
    cc(best,_40147,_40151).

particle(well,[particle,lit(vel)],_40147,_40151) --> 
    cc(vel,_40147,_40151).

particle(westward,[particle,lit(vestover)],_40147,_40151) --> 
    cc(vestover,_40147,_40151).

particle(with1,[particle,lit(med),_40219],_40169,_40173) --> 
    cc(med,_40169,_40217),
    not_look_ahead(w(name(_40129,_40131,_40133)),_40219,_40217,_40173).

particle(wrongly,[particle,_40181,lit(feil)],_40153,_40157) --> 
    saa0(_40181,_40153,_40211),
    cc(feil,_40211,_40157).

particle(yesterday,[particle,lit(igår)],_40147,_40151) --> 
    cc(igår,_40147,_40151).

adjunct1(_40111,_40113,_40119::_40121,[adjunct1,{},_40395,_40453,_40501,{},!,_40583,!,_40705],_40341,_40345) --> 
    {_40111==nil},
    w(nb(_40187,_40189),_40395,_40341,_40429),
    point0(_40453,_40429,_40483),
    w(noun(_40197,_40199,u,n),_40501,_40483,_40535),
    {testmember(_40197,[year,month,week,day,hour,minute,second,mile,kilometer,meter])},
    !,
    lock(exact,_40535,_40623),pushstack(exact,(w(nb(_40187,num)),w(noun(_40197,sin,u,n))),nil,_40623,_40635),np0_accept(_40113,_40119::_40121,_40583,_40635,_40613),unlock(_40613,_40615),
    !,
    accept(_40705,_40615,_40345).

adjunct1(after,_40113,_40115,[adjunct1,_40247,lit(å),!,_40337],_40207,_40211) --> 
    w(prep(after),_40247,_40207,_40281),
    cc(å,_40281,_40325),
    !,
    lock(last,_40325,_40445),
    pushstack(last,([noen],aux1),nil,_40445,_40457),
    clausal_object1(_40113,_40115,_40337,_40457,_40435),
    unlock(_40435,_40211).

adjunct1(when,_40113,_40115,[adjunct1,lit(om),lit(når),!,_40281],_40187,_40191) --> 
    cc(om,_40187,_40247),
    cc(når,_40247,_40269),
    !,
    clausal_object1(_40113,_40115,_40281,_40269,_40191).

adjunct1(where,_40113,_40115,[adjunct1,lit(om),lit(hvor),!,_40281],_40187,_40191) --> 
    cc(om,_40187,_40247),
    cc(hvor,_40247,_40269),
    !,
    clausal_object1(_40113,_40115,_40281,_40269,_40191).

adjunct1(regarding,_40113,_40115,[adjunct1,lit(om),lit(at),!,_40281],_40187,_40191) --> 
    cc(om,_40187,_40247),
    cc(at,_40247,_40269),
    !,
    clausal_object1(_40113,_40115,_40281,_40269,_40191).

adjunct1(with,_40113,_40115,[adjunct1,lit(med),lit(det),lit(å),!,_40325],_40209,_40213) --> 
    cc(med,_40209,_40269),
    cc(det,_40269,_40291),
    cc(å,_40291,_40313),
    !,
    pushstack(first,(someone,aux1),nil,_40313,_40493),
    clausal_object1(_40113,_40115,_40325,_40493,_40213).

adjunct1(_40111,_40113,_40115,[adjunct1,lit(hva),!,_40243],_40171,_40175) --> 
    cc(hva,_40171,_40231),
    !,
    reject(_40243,_40231,_40175).

adjunct1(_40111,_40113,_40115,[adjunct1,_40231,_40289,!,_40357],_40191,_40195) --> 
    prep1(in,_40231,_40191,_40265),
    w(noun(morning,_40147,_40149,_40151),_40289,_40265,_40323),
    !,
    reject(_40357,_40323,_40195).

adjunct1(_40111,_40113,_40119::_40121,[adjunct1,{},!,_40259],_40195,_40199) --> 
    {_40111==nil},
    !,
    complement_nil(_40113,_40119::_40121,_40259,_40195,_40199).

adjunct1(ago,_40113,_40119::_40121,[adjunct1,_40305,_40363,_40421,lit(siden),!,_40511,!],_40265,_40269) --> 
    prep1(for,_40305,_40265,_40339),
    anumber(_40165,_40363,_40339,_40397),
    w(noun(_40173,_40175,u,n),_40421,_40397,_40455),
    cc(siden,_40455,_40499),
    !,
    lock(exact,_40499,_40629),pushstack(exact,(number(_40165),w(noun(_40173,plu,u,n))),nil,_40629,_40641),np0_accept(_40113,_40119::_40121,_40511,_40641,_40619),unlock(_40619,_40269),
    !.

adjunct1(after,_40113,_40119::_40121,[adjunct1,lit(om),_40331,_40389,_40447,!,_40515],_40269,_40273) --> 
    cc(om,_40269,_40329),
    anumber(_40185,_40331,_40329,_40365),
    w(noun(_40171,_40195,u,gen),_40389,_40365,_40423),
    w(noun(time,sin,u,n),_40447,_40423,_40481),
    !,
    pushstack(first,(number(_40185),w(noun(_40171,sin,u,n))),nil,_40481,_40613),
    np1(_40113,_40119::_40121,_40515,_40613,_40273).

adjunct1(in,_40113,_40115,[adjunct1,_40321,_40379,{},_40451,!,_40519],_40281,_40285) --> 
    prep(in,_40321,_40281,_40355),
    w(nb(_40165,num),_40379,_40355,_40413),
    {1000=<_40165,_40165=<9999},
    not_look_ahead(w(noun(time,_40217,_40219,_40221)),_40451,_40413,_40485),
    !,
    lock(exact,_40485,_40553),
    pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_40165,num))),nil,_40553,_40565),
    np1(_40113,_40115,_40519,_40565,_40543),
    unlock(_40543,_40285).

adjunct1(around,_40113,_40115,[adjunct1,_40293,{},_40365,_40413,_40481,_40529,!,_40597],_40253,_40257) --> 
    prep1(_40167,_40293,_40253,_40327),
    {testmember(_40167,[in,at,around])},
    ca0(_40365,_40327,_40395),
    clock_kernel(_40113,_40161,_40413,_40395,_40451),
    point0(_40481,_40451,_40511),
    not_look_ahead(w(noun(_40207,_40209,_40211,_40213)),_40529,_40511,_40563),
    !,
    raise_object00(_40161,_40115,_40597,_40563,_40257).

adjunct1(_40111,_40113,_40115,[adjunct1,lit(med),lit(en),lit(gang),!,_40307],_40191,_40195) --> 
    cc(med,_40191,_40251),
    cc(en,_40251,_40273),
    cc(gang,_40273,_40295),
    !,
    reject(_40307,_40295,_40195).

adjunct1(between,(_40143,_40145):clock,_40119::_40119 and _40131 and _40133,[adjunct1,_40295,_40353,_40401,_40469,_40517,_40565,!,_40643],_40255,_40259) --> 
    prep1(between,_40295,_40255,_40329),
    clock0(_40353,_40329,_40383),
    clock_kernel(_40143:clock,_40131,_40401,_40383,_40439),
    betwand0(_40469,_40439,_40499),
    clock0(_40517,_40499,_40547),
    clock_kernel(_40145:clock,_40133,_40565,_40547,_40603),
    !,
    accept(_40643,_40603,_40259).

adjunct1(between,_40113,_40115,[adjunct1,_40223,_40281,!,_40359],_40183,_40187) --> 
    prep1(between,_40223,_40183,_40257),
    noun_phrases2(_40113,_40115,_40281,_40257,_40319),
    !,
    accept(_40359,_40319,_40187).

adjunct1(_40111,_40113,_40115,[adjunct1,lit(om),_40263,!,_40321,{}],_40201,_40205) --> 
    cc(om,_40201,_40261),
    not_look_ahead_subject(_40263,_40261,_40293),
    !,
    np(_40113,_40115,_40321,_40293,_40205),
    {adjustprep(_40113,om,_40111)}.

adjunct1(_40111,_40113,_40115,[adjunct1,_40203],_40163,_40167) --> 
    pp(_40111,_40113,_40115,_40203,_40163,_40167).

adjunct1(_40111,_40113,_40115,[adjunct1,{},_40231],_40177,_40181) --> 
    {_40111==dir},
    noun_phrase1(_40113,_40115,_40231,_40177,_40181).

pp(on,_40113,_40115,[pp,_40221,lit(at),_40301],_40181,_40185) --> 
    prep(on,_40221,_40181,_40255),
    cc(at,_40255,_40299),
    clausal_object1(_40113,_40115,_40301,_40299,_40185).

pp(as,_40113,_40115,[pp,lit(som),_40273,!,_40341],_40211,_40215) --> 
    cc(som,_40211,_40271),
    look_ahead_lit([meg,deg,ham,henne,oss,dem],_40273,_40271,_40307),
    !,
    np(_40113,_40115,_40341,_40307,_40215).

pp(_40111,_40113,_40115,[pp,_40239,_40297,_40355,_40413],_40199,_40203) --> 
    look_ahead([om],_40239,_40199,_40273),
    prep(_40111,_40297,_40273,_40331),
    not_look_ahead([jeg],_40355,_40331,_40389),
    np(_40113,_40115,_40413,_40389,_40203).

pp(_40111,_40113,_40115,[pp,lit(før),lit(det),!,_40275],_40181,_40185) --> 
    cc(før,_40181,_40241),
    cc(det,_40241,_40263),
    !,
    reject(_40275,_40263,_40185).

pp(_40111,_40113,_40115,[pp,_40249,_40307,_40365,_40413,{}],_40209,_40213) --> 
    not_look_ahead_lit([om],_40249,_40209,_40283),
    prep(_40149,_40307,_40283,_40341),
    redundant0(_40365,_40341,_40395),
    object(_40113,_40115,_40413,_40395,_40213),
    {adjustprep(_40113,_40149,_40111)}.

pp(_40111,_40113,_40119::_40119 and _40127,[pp,_40375,{},_40447,_40505,_40563,_40631,_40689,_40747,!,_40815],_40335,_40339) --> 
    prep(_40111,_40375,_40335,_40409),
    {testmember(_40111,[before,after,around,to,over,within])},
    not_look_ahead([et],_40447,_40409,_40481),
    not_look_ahead([en],_40505,_40481,_40539),
    clock_kernel(_40113,_40127,_40563,_40539,_40601),
    not_look_ahead(w(noun(station,_40255,_40257,_40259)),_40631,_40601,_40665),
    not_look_ahead(w(noun(hour,_40273,_40275,_40277)),_40689,_40665,_40723),
    not_look_ahead(w(noun(minute,_40291,_40293,_40295)),_40747,_40723,_40781),
    !,
    accept(_40815,_40781,_40339).

complement_nil(_40111,_40113,[complement_nil,_40319,_40377,_40435,!,_40523,_40591],_40285,_40289) --> 
    w(nb(_40181,num),_40319,_40285,_40353),
    w(noun(minute,_40193,_40195,_40197),_40377,_40353,_40411),
    subjunction(_40201,time,_40205,_40435,_40411,_40477),
    !,
    clausal_object0(_40171,_40173,_40523,_40477,_40561),
    lock(exact,_40561,_40705),
    pushstack(exact,(w(nb(_40181,num)),w(noun(minute,plu,u,n)),w(prep(_40201)),xnp(_40171,_40173)),nil,_40705,_40717),
    np1(_40111,_40113,_40591,_40717,_40695),
    unlock(_40695,_40289).

complement_nil(_40111,_40113,[complement_nil,_40285,_40343,_40401,!,_40469],_40251,_40255) --> 
    w(nb(_40171,num),_40285,_40251,_40319),
    w(noun(minute,_40183,_40185,_40187),_40343,_40319,_40377),
    look_ahead(w(prep(_40199)),_40401,_40377,_40435),
    !,
    lock(exact,_40435,_40503),
    pushstack(exact,(w(nb(_40171,num)),w(noun(minute,_40159,_40161,_40163))),nil,_40503,_40515),
    noun_phrase1(_40111,_40113,_40469,_40515,_40493),
    unlock(_40493,_40255).

complement_nil(_40111,_40113,[complement_nil,_40189],_40155,_40159) --> 
    obviousclock(_40111,_40113,_40189,_40155,_40159).

complement_nil(_40111,_40113,[complement_nil,_40209,!,_40277],_40175,_40179) --> 
    w(prep(nil),_40209,_40175,_40243),
    !,
    noun_phrase1(_40111,_40113,_40277,_40243,_40179).

complement_nil(_40111,_40117::_40119,[complement_nil,_40297,{},!,_40379,_40427],_40263,_40267) --> 
    w(noun(_40163,_40179,_40181,n),_40297,_40263,_40331),
    {testmember(_40163,[nightbus,summerroute,winterroute])},
    !,
    accept(_40379,_40331,_40409),
    lock(exact,_40409,_40461),
    pushstack(exact,(w(prep(with)),w(noun(_40163,sin,u,n))),nil,_40461,_40473),
    adjunct1(_40209,_40111,_40117::_40119,_40427,_40473,_40451),
    unlock(_40451,_40267).

complement_nil(_40111,_40113,[complement_nil,_40269,_40327,_40385,_40443,_40501,!,_40569],_40235,_40239) --> 
    not_look_ahead(w(noun(street,sin,u,n)),_40269,_40235,_40303),
    not_look_ahead([den],_40327,_40303,_40361),
    not_look_ahead([det],_40385,_40361,_40419),
    not_look_ahead(w(prep(with)),_40443,_40419,_40477),
    pronoun1(_40199,_40501,_40477,_40535),
    !,
    reject(_40569,_40535,_40239).

complement_nil(_40111,_40117::_40117 and _40125,[complement_nil,_40201],_40167,_40171) --> 
    plausibleclock1(_40111,_40125,_40201,_40167,_40171).

complement_nil(_40111,_40117::_40119,[complement_nil,_40207,!],_40173,_40177) --> 
    obviousdate(_40111,_40117::_40119,_40207,_40173,_40177),
    !.

complement_nil(_40111,_40117::_40117 and _40125,[complement_nil,_40201],_40167,_40171) --> 
    plausibledate1(_40111,_40125,_40201,_40167,_40171).

complement_nil(_40111,_40117::_40119,[complement_nil,_40247,_40305,!,_40383],_40213,_40217) --> 
    look_ahead(w(adj2(_40161,nil)),_40247,_40213,_40281),
    gmem(_40161,[short,long],_40305,_40281,_40343),
    !,
    noun_phrase1(_40111,_40117::_40119,_40383,_40343,_40217).

complement_nil(_40111,_40113,[complement_nil,_40267,_40325,!,_40393],_40233,_40237) --> 
    w(nb(_40165,num),_40267,_40233,_40301),
    w(noun(time_count,_40153,_40155,_40157),_40325,_40301,_40359),
    !,
    lock(exact,_40359,_40427),
    pushstack(exact,(w(nb(_40165,num)),w(noun(time_count,_40153,_40155,_40157))),nil,_40427,_40439),
    np0(_40111,_40113,_40393,_40439,_40417),
    unlock(_40417,_40237).

complement_nil(_40111,_40113,[complement_nil,_40313,_40371,_40429,_40487,_40545,_40603,!,_40671],_40279,_40283) --> 
    not_look_ahead(w(name(_40167,_40169,_40171)),_40313,_40279,_40347),
    w(nb(_40179,num),_40371,_40347,_40405),
    not_look_ahead([ganger],_40429,_40405,_40463),
    not_look_ahead(w(noun(hour,_40203,_40205,_40207)),_40487,_40463,_40521),
    not_look_ahead(w(noun(minute,_40221,_40223,_40225)),_40545,_40521,_40579),
    not_look_ahead(w(noun(second,_40239,_40241,_40243)),_40603,_40579,_40637),
    !,
    reject(_40671,_40637,_40283).

complement_nil(_40111,_40113,[complement_nil,_40357,_40415,_40473,_40531,_40589,_40647,_40705,_40763,!],_40323,_40327) --> 
    not_look_ahead(w(nb(_40173,_40175)),_40357,_40323,_40391),
    not_look_ahead(w(_40183,name(_40183,_40191,month)),_40415,_40391,_40449),
    not_look_ahead_lit([sin,sitt,sine],_40473,_40449,_40507),
    not_look_ahead(w(noun(hour,plu,u,n)),_40531,_40507,_40565),
    not_look_ahead(w(noun(minute,plu,u,n)),_40589,_40565,_40623),
    not_look_ahead(w(noun(second,plu,u,n)),_40647,_40623,_40681),
    not_look_ahead(w(noun(room,_40277,u,n)),_40705,_40681,_40739),
    object(_40111,_40113,_40763,_40739,_40327),
    !.

complement1_accept(_40111,_40113,_40115,[complement1_accept,lit(idag),!,_40287,!],_40215,_40219) --> 
    cc(idag,_40215,_40275),
    !,
    pushstack(first,(prep(in),w(noun(day,sin,u,n))),nil,_40275,_40391),complement1_accept(_40111,_40113,_40115,_40287,_40391,_40219),
    !.

complement1_accept(_40111,_40113,_40119::_40121,[complement1_accept,_40291,{},_40363,_40421,_40479,!,_40557],_40251,_40255) --> 
    prep(_40111,_40291,_40251,_40325),
    {\+testmember(_40111,[of,between])},
    not_look_ahead([jeg],_40363,_40325,_40397),
    not_look_ahead([man],_40421,_40397,_40455),
    noun_phrase_accept(_40113,_40119::_40121,_40479,_40455,_40517),
    !,
    accept(_40557,_40517,_40255).

plausibledate1(_40117:date,_40117 isa date,[plausibledate1,_40351,{},_40423,_40471,{},_40543,_40591,{},!,_40673,{}],_40317,_40321) --> 
    num_na(_40199,_40351,_40317,_40385),
    {_40199>=1000,_40199=<9999},
    dashpoint0(_40423,_40385,_40453),
    num_na(_40201,_40471,_40453,_40505),
    {_40201>=1,_40201=<12},
    dashpoint0(_40543,_40505,_40573),
    num_na(_40203,_40591,_40573,_40625),
    {_40203>=1,_40203=<31},
    !,
    accept(_40673,_40625,_40321),
    {_40117=date(_40199,_40201,_40203)}.

plausibledate1(_40117:date,_40117 isa date,[plausibledate1,_40311,{},_40383,_40431,{},{},!,_40527,{}],_40277,_40281) --> 
    num_na(_40197,_40311,_40277,_40345),
    {_40197=<31},
    slashpoint0(_40383,_40345,_40413),
    num_na(_40195,_40431,_40413,_40465),
    {_40195=<12},
    {this_year(_40233)},
    !,
    accept(_40527,_40465,_40281),
    {adjust_year(_40195,_40233,_40193),_40117=date(_40193,_40195,_40197)}.

obviousdate(_40111,_40117::_40123 and _40117,[obviousdate,_40201],_40167,_40171) --> 
    obviousdate1(_40111,_40123,_40201,_40167,_40171).

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40269,_40317,_40375,_40423,_40481,!,_40559,{}],_40235,_40239) --> 
    point0(_40269,_40235,_40299),
    dayno(_40185,_40317,_40299,_40351),
    slashpoint0(_40375,_40351,_40405),
    monthname(_40183,_40423,_40405,_40457),
    xyear0(_40183,_40181,_40481,_40457,_40519),
    !,
    accept(_40559,_40519,_40239),
    {_40117=date(_40181,_40183,_40185)}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40357,_40405,{},_40477,_40525,{},_40597,_40645,{},!,_40727,{}],_40323,_40327) --> 
    point0(_40357,_40323,_40387),
    num_na(_40205,_40405,_40387,_40439),
    {_40205>=1000,_40205=<9999},
    dashpoint0(_40477,_40439,_40507),
    num_na(_40207,_40525,_40507,_40559),
    {_40207>=1,_40207=<12},
    dashpoint0(_40597,_40559,_40627),
    num_na(_40209,_40645,_40627,_40679),
    {_40209>=1,_40209=<31},
    !,
    accept(_40727,_40679,_40327),
    {_40117=date(_40205,_40207,_40209)}.

obviousdate1(_40111,_40123 isa day and _40119,[obviousdate1,_40237,{},_40309,!,_40387],_40203,_40207) --> 
    dendagen(_40123,_40237,_40203,_40271),
    {dayname(_40123)},
    date(_40111,_40119,_40309,_40271,_40347),
    !,
    accept(_40387,_40347,_40207).

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40313,_40361,{},_40433,_40481,{},_40553,!,_40631,{}],_40279,_40283) --> 
    point0(_40313,_40279,_40343),
    num_na(_40197,_40361,_40343,_40395),
    {_40197>=25,_40197=<31},
    slash(_40433,_40395,_40463),
    num_na(_40195,_40481,_40463,_40515),
    {_40195=<12},
    xyear0(_40195,_40193,_40553,_40515,_40591),
    !,
    accept(_40631,_40591,_40283),
    {_40117=date(_40193,_40195,_40197)}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40395,_40443,{},_40515,_40563,{},_40635,_40723,!,{}],_40361,_40365) --> 
    den0(_40395,_40361,_40425),
    num_na(_40219,_40443,_40425,_40477),
    {_40219>=1,_40219=<7},
    point0(_40515,_40477,_40545),
    w(name(_40249,n,date),_40563,_40545,_40597),
    {testmember(_40249,[easterday])},
    optional(w(noun(year,_40281,_40283,n)),_40635,_40597,_40699),
    w(nb(_40293,num),_40723,_40699,_40365),
    !,
    {easterdate(_40293,_40211),_40293>=1000,_40293=<9999,_40213 is _40219-1,add_days(_40211,_40213,_40117)}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,{},_40329,{},_40401,!,{}],_40281,_40285) --> 
    {_40117=date(_40187,_40171,_40173)},
    w(name(_40163,n,date),_40329,_40281,_40363),
    {testmember(_40163,[christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day,may17])},
    year_expression(_40187,_40401,_40363,_40285),
    !,
    {named_date(_40163,date(_40169,_40171,_40173))}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40403,_40451,{},_40523,_40571,{},_40643,_40701,!,{}],_40369,_40373) --> 
    den0(_40403,_40369,_40433),
    num_na(_40207,_40451,_40433,_40485),
    {_40207>=1,_40207=<7},
    point0(_40523,_40485,_40553),
    w(name(_40237,n,date),_40571,_40553,_40605),
    {testmember(_40237,[whitsun_day,easterday,christmas_day,new_years_day])},
    not_look_ahead(w(noun(year,_40281,_40283,_40285)),_40643,_40605,_40677),
    not_look_ahead(w(nb(_40297,num)),_40701,_40677,_40373),
    !,
    {named_date(_40237,date(_40309,_40311,_40313)),_40201 is _40207-1,add_days(date(_40309,_40311,_40313),_40201,_40117)}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40339,{},_40411,_40469,!,{}],_40305,_40309) --> 
    w(name(_40163,n,date),_40339,_40305,_40373),
    {testmember(_40163,[whitsun_eve,whitsun_day,palm_sunday,maundy_thursday,good_friday,eastereve,easterday,christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day])},
    not_look_ahead(w(prep(in)),_40411,_40373,_40445),
    not_look_ahead(w(noun(year,_40265,_40267,_40269)),_40469,_40445,_40309),
    !,
    {named_date(_40163,_40117)}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40229,{},!],_40195,_40199) --> 
    w(name(_40145,n,date),_40229,_40195,_40199),
    {named_date(_40145,_40117)},
    !.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40253,{},_40325,{},!,_40407],_40219,_40223) --> 
    dendagen(_40159,_40253,_40219,_40287),
    {_40159\==nil},
    num_na(_40159,_40325,_40287,_40359),
    {numberdate(_40159,_40117)},
    !,
    accept(_40407,_40359,_40223).

obviousdate1(_40111,_40113,[obviousdate1,_40205,_40263,!],_40171,_40175) --> 
    dendagen(_40129,_40205,_40171,_40239),
    date(_40111,_40113,_40263,_40239,_40175),
    !.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40297,_40345,{},_40417,_40465,_40523,_40571,!,{}],_40263,_40267) --> 
    den(_40297,_40263,_40327),
    num_na(_40191,_40345,_40327,_40379),
    {_40191>=1,_40191=<31},
    slashpoint0(_40417,_40379,_40447),
    monthname(_40189,_40465,_40447,_40499),
    slashpoint0(_40523,_40499,_40553),
    xyear0(_40189,_40187,_40571,_40553,_40267),
    !,
    {_40117=date(_40187,_40189,_40191)}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40323,_40371,{},_40443,_40491,{},_40563,_40611,!,{}],_40289,_40293) --> 
    den0(_40323,_40289,_40353),
    num_na(_40197,_40371,_40353,_40405),
    {_40197>=1,_40197=<31},
    slashpoint0(_40443,_40405,_40473),
    month(_40195,_40491,_40473,_40525),
    {_40195>=1,_40195=<12},
    slashpoint0(_40563,_40525,_40593),
    year(_40193,_40611,_40593,_40293),
    !,
    {_40117=date(_40193,_40195,_40197)}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40269,_40327,_40385,_40443,!,{}],_40235,_40239) --> 
    not_look_ahead(w(nb(_40185,num)),_40269,_40235,_40303),
    month(_40171,_40327,_40303,_40361),
    num_na(_40173,_40385,_40361,_40419),
    year0(_40169,_40443,_40419,_40239),
    !,
    {_40117=date(_40169,_40171,_40173)}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40275,_40323,_40381,_40429,!,{}],_40241,_40245) --> 
    den(_40275,_40241,_40305),
    num_na(_40185,_40323,_40305,_40357),
    slashpoint(_40381,_40357,_40411),
    month(_40183,_40429,_40411,_40245),
    !,
    {this_year(_40197),adjust_year(_40183,_40197,_40181),_40117=date(_40181,_40183,_40185)}.

obviousdate1(_40111,_40113,[obviousdate1,_40229,_40287,_40345,!,_40413],_40195,_40199) --> 
    dendagen(_40141,_40229,_40195,_40263),
    num_na(_40145,_40287,_40263,_40321),
    w(noun(_40153,plu,_40157,_40159),_40345,_40321,_40379),
    !,
    reject(_40413,_40379,_40199).

obviousdate1(_40111,_40113,[obviousdate1,lit(den),_40237,!,_40305],_40181,_40185) --> 
    cc(den,_40181,_40235),
    w(nb(_40143,ord),_40237,_40235,_40271),
    !,
    reject(_40305,_40271,_40185).

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,{},_40305,_40363,_40411,_40469,{}],_40251,_40255) --> 
    {user:value(busflag,true)},
    num_na(_40179,_40305,_40251,_40339),
    slashpoint0(_40363,_40339,_40393),
    num_na(_40177,_40411,_40393,_40445),
    slashpoint0(_40469,_40445,_40255),
    {dedicated_date(date(_40175,_40177,_40179)),_40117=date(_40175,_40177,_40179)}.

obviousdate1(_40117:date,_40113,[obviousdate1,_40253,_40311,{},_40383,!,_40451],_40219,_40223) --> 
    dendagen(_40153,_40253,_40219,_40287),
    num_na(_40157,_40311,_40287,_40345),
    {_40157>=1,_40157=<31},
    colemin(_40183,_40383,_40345,_40417),
    !,
    reject(_40451,_40417,_40223).

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40331,{},_40403,{},_40475,_40523,!,{},{}],_40297,_40301) --> 
    dendagen(_40195,_40331,_40297,_40365),
    {_40195\==nil},
    num_na(_40191,_40403,_40365,_40437),
    {_40191>=1,_40191=<31},
    point(_40475,_40437,_40505),
    not_look_ahead(w(nb(_40243,_40245)),_40523,_40505,_40301),
    !,
    {todaysdate(date(_40187,_40189,_40261))},
    {_40117=date(_40187,_40189,_40191)}.

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,lit(den),_40259,{},!,_40341],_40203,_40207) --> 
    cc(den,_40203,_40257),
    num_na(_40157,_40259,_40257,_40293),
    {numberdate(_40157,_40117)},
    !,
    accept(_40341,_40293,_40207).

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40267,{},_40339,{},!,_40421],_40233,_40237) --> 
    num_na(_40159,_40267,_40233,_40301),
    {_40159>=10101},
    not_look_ahead(w(noun(_40181,plu,_40185,_40187)),_40339,_40301,_40373),
    {numberdate(_40159,_40117)},
    !,
    accept(_40421,_40373,_40237).

obviousdate1(_40117:date,_40117 isa date,[obviousdate1,_40267,{},_40339,{},!,_40421],_40233,_40237) --> 
    num_na(_40159,_40267,_40233,_40301),
    {_40159>=2501},
    not_look_ahead(w(noun(_40181,plu,_40185,_40187)),_40339,_40301,_40373),
    {numberdate(_40159,_40117)},
    !,
    accept(_40421,_40373,_40237).

year_expression(_40111,[year_expression,_40245,_40333,_40421,{},!],_40217,_40221) --> 
    optional(w(prep(in)),_40245,_40217,_40309),
    optional(w(noun(year,sin,u,n)),_40333,_40309,_40397),
    w(nb(_40111,num),_40421,_40397,_40221),
    {_40111=<9999},
    !.

year_expression(_40111,[year_expression,_40209,!,{}],_40181,_40185) --> 
    lastyear(_40209,_40181,_40185),
    !,
    {this_year(_40143),_40111 is _40143-1}.

year_expression(_40111,[year_expression,_40209,!,{}],_40181,_40185) --> 
    nextyear(_40209,_40181,_40185),
    !,
    {this_year(_40143),_40111 is _40143+1}.

lastyear([lastyear,_40195,lit(siste),_40305],_40173,_40177) --> 
    optional([i],_40195,_40173,_40259),
    cc(siste,_40259,_40303),
    w(noun(year,sin,_40131,n),_40305,_40303,_40177).

lastyear([lastyear,_40185,_40273],_40163,_40167) --> 
    optional([i],_40185,_40163,_40249),
    w(noun(lastyear,sin,_40125,n),_40273,_40249,_40167).

lastyear([lastyear,lit(ifjor),!],_40145,_40149) --> 
    cc(ifjor,_40145,_40149),
    !.

nextyear([nextyear,_40195,lit(neste),_40305],_40173,_40177) --> 
    optional([i],_40195,_40173,_40259),
    cc(neste,_40259,_40303),
    w(noun(year,sin,u,n),_40305,_40303,_40177).

plausibleclock(_40111,_40117::_40117 and _40125,[plausibleclock,_40227,!,_40295],_40193,_40197) --> 
    look_ahead(w(nb(_40155,_40157)),_40227,_40193,_40261),
    !,
    clock_sequel(_40111,_40125,_40295,_40261,_40197).

plausibleclock1(_40117:clock,_40117 isa clock,[plausibleclock1,_40335,{},_40407,_40455,_40513,_40601,_40659,{},!],_40301,_40305) --> 
    w(nb(_40181,num),_40335,_40301,_40369),
    {_40181>=1,_40181=<24},
    point0(_40407,_40369,_40437),
    w(nb(_40213,num),_40455,_40437,_40489),
    optional(['.'],_40513,_40489,_40577),
    not_look_ahead(w(nb(_40235,_40237)),_40601,_40577,_40635),
    not_look_ahead(w(name(_40249,_40251,month)),_40659,_40635,_40305),
    {plausibleclocktest(_40181,_40213,_40117)},
    !.

obviousclock(_40111,_40113,[obviousclock,_40249,_40307,_40355,{},!,_40437],_40215,_40219) --> 
    w(nb(_40151,num),_40249,_40215,_40283),
    pointNO(_40307,_40283,_40337),
    w(nb(_40161,num),_40355,_40337,_40389),
    {dedicated_date(date(_40175,_40161,_40151))},
    !,
    reject(_40437,_40389,_40219).

obviousclock(_40111,_40117::_40117 and _40125,[obviousclock,_40201],_40167,_40171) --> 
    obviousclock1(_40111,_40125,_40201,_40167,_40171).

obviousclock1(_40111,_40113,[obviousclock1,_40201,!,_40259],_40167,_40171) --> 
    clock(_40201,_40167,_40231),
    !,
    clock_sequel(_40111,_40113,_40259,_40231,_40171).

obviousclock1(_40111,_40113,[obviousclock1,_40221,_40289,!,_40357],_40187,_40191) --> 
    clock_kernel(_40111,_40113,_40221,_40187,_40259),
    w(noun(time,sin,def,n),_40289,_40259,_40323),
    !,
    accept(_40357,_40323,_40191).

obviousclock1(_40117:clock,_40117 isa clock,[obviousclock1,_40397,_40455,_40513,{},_40585,_40643,_40701,_40759,_40817,_40875,!,_40973],_40363,_40367) --> 
    not_look_ahead(w(name(_40203,n,route)),_40397,_40363,_40431),
    not_look_ahead(w(name(_40219,n,nightbus)),_40455,_40431,_40489),
    w(nb(_40117,num),_40513,_40489,_40547),
    {_40117>=100,clock_test(_40117)},
    not_look_ahead([-],_40585,_40547,_40619),
    not_look_ahead(w(nb(_40273,_40275)),_40643,_40619,_40677),
    not_look_ahead(w(noun(_40287,plu,_40291,_40293)),_40701,_40677,_40735),
    not_look_ahead([tusen],_40759,_40735,_40793),
    not_look_ahead([millioner],_40817,_40793,_40851),
    optional(w(noun(time,sin,def,n)),_40875,_40851,_40939),
    !,
    accept(_40973,_40939,_40367).

obviousclock1(_40117:clock,_40117 isa clock,[obviousclock1,_40199],_40165,_40169) --> 
    time2(_40117,_40199,_40165,_40169).

obviousclock1(_40117:clock,_40117 isa clock,[obviousclock1,_40213,_40271],_40179,_40183) --> 
    hours100(_40117,_40213,_40179,_40247),
    look_ahead([om],_40271,_40247,_40183).

rel_clauses(_40111,_40113,_40115,[rel_clauses,lit(hva),!,_40243],_40171,_40175) --> 
    cc(hva,_40171,_40231),
    !,
    reject(_40243,_40231,_40175).

rel_clauses(_40111,_40113,_40113 and _40121,[rel_clauses,_40283,lit(det),_40353,_40553],_40243,_40247) --> 
    derhvor(_40283,_40243,_40313),
    cc(det,_40313,_40351),
    lock(exact,_40351,_40471),pushstack(exact,(w(prep(in)),npgap(_40111)),nil,_40471,_40483),adverbial1(_40155,_40157,_40159,_40353,_40483,_40461),unlock(_40461,_40463),
    lock(last,_40463,_40669),
    pushstack(last,([det],xadverbial1(_40155,_40157,_40159)),nil,_40669,_40681),
    substatement1(_40121,_40553,_40681,_40659),
    unlock(_40659,_40247).

rel_clauses(_40111,_40113,_40113 and _40121,[rel_clauses,_40325,_40383,_40441,!,_40509],_40285,_40289) --> 
    w(noun(_40181,_40183,_40185,n),_40325,_40285,_40359),
    w(verb(apply,_40197,fin),_40383,_40359,_40417),
    w(prep(_40207),_40441,_40417,_40475),
    !,
    pushstack(first,(w(noun(_40181,_40183,_40185,n)),w(verb(apply,_40197,fin)),w(prep(_40207)),npgap(_40111)),nil,_40475,_40607),
    statreal(_40121,_40509,_40607,_40289).

rel_clauses(_40111,_40113,_40115,[rel_clauses,_40259,_40327],_40219,_40223) --> 
    lit_of(_40135,[jeg,hun,han,vi,man,du],_40259,_40219,_40297),
    pushstack(first,([som],[_40135]),nil,_40297,_40347),
    rel_clause(_40111,_40113,_40115,_40327,_40347,_40223).

rel_clauses(_40111,_40113,_40113 and _40121,[rel_clauses,_40283,lit(det),_40353,_40553],_40243,_40247) --> 
    derhvor(_40283,_40243,_40313),
    cc(det,_40313,_40351),
    lock(exact,_40351,_40471),pushstack(exact,(w(prep(in)),npgap(_40111)),nil,_40471,_40483),adverbial1(_40155,_40157,_40159,_40353,_40483,_40461),unlock(_40461,_40463),
    lock(last,_40463,_40669),
    pushstack(last,([det],xadverbial1(_40155,_40157,_40159)),nil,_40669,_40681),
    substatement1(_40121,_40553,_40681,_40659),
    unlock(_40659,_40247).

rel_clauses(_40111,_40113,_40113 and _40121,[rel_clauses,_40259,_40307,_40375],_40219,_40223) --> 
    derhvor(_40259,_40219,_40289),
    subject(_40159,_40161,_40307,_40289,_40345),
    lock(last,_40345,_40567),
    pushstack(last,(xnp(_40159,_40161),w(prep(in)),npgap(_40111)),nil,_40567,_40579),
    statreal(_40121,_40375,_40579,_40557),
    unlock(_40557,_40223).

rel_clauses(_40111,_40113,_40115,[rel_clauses,lit(som),_40325,_40373,_40431,_40499,!,[],_40697],_40263,_40267) --> 
    cc(som,_40263,_40323),
    danow0(_40325,_40323,_40355),
    look_ahead(w(prep(_40183)),_40373,_40355,_40407),
    gmem(_40183,[of],_40431,_40407,_40469),
    adverbix(_40197,_40199,_40201,_40499,_40469,_40541),
    !,
    pushstack(free,xadverbial1(_40197,_40199,_40201),nil,_40541,_40695),[],
    pushstack(first,[som],nil,_40695,_40717),
    rel_clause(_40111,_40113,_40115,_40697,_40717,_40267).

rel_clauses(_40111,_40113,_40115,[rel_clauses,_40217,_40295],_40177,_40181) --> 
    rel_clause(_40111,_40113,_40127,_40217,_40177,_40259),
    rel_clauses0(_40111,_40127,_40115,_40295,_40259,_40181).

rel_clauses0(_40111,_40113,_40115,[rel_clauses0,_40209,_40257],_40169,_40173) --> 
    and1x(_40209,_40169,_40239),
    rel_clauses(_40111,_40113,_40115,_40257,_40239,_40173).

rel_clauses0(_40111,_40113,_40113,[rel_clauses0,[]],_40155,_40155) --> 
    [].

derhvor([derhvor,_40179,!],_40157,_40161) --> 
    one_of_lit([der,hvor,dit],_40179,_40157,_40161),
    !.

and1x([and1x,_40157],_40135,_40139) --> 
    and1(_40157,_40135,_40139).

and1x([and1x,_40165],_40143,_40147) --> 
    look_ahead([som],_40165,_40143,_40147).

dvs([dvs,lit(dvs)],_40139,_40143) --> 
    cc(dvs,_40139,_40143).

dvs([dvs,lit(altså)],_40139,_40143) --> 
    cc(altså,_40139,_40143).

dvs([dvs,lit(a),lit(la)],_40149,_40153) --> 
    cc(a,_40149,_40191),
    cc(la,_40191,_40153).

rel_clause(_40111,_40113,_40113 and _40121,[rel_clause,_40245,!,_40303],_40205,_40209) --> 
    dvs(_40245,_40205,_40275),
    !,
    lock(last,_40275,_40415),
    pushstack(last,(npgap(_40111),w(verb(be,pres,fin))),nil,_40415,_40427),
    statreal(_40121,_40303,_40427,_40405),
    unlock(_40405,_40209).

rel_clause(_40111,_40113,_40113 and _40121,[rel_clause,_40305,_40363,!,_40441],_40265,_40269) --> 
    w(verb(_40169,past,part),_40305,_40265,_40339),
    gmem(_40169,[adapt,label,be_named,register],_40363,_40339,_40401),
    !,
    lock(last,_40401,_40553),
    pushstack(last,(w(noun(agent,sin,u,n)),w(verb(_40169,past,fin)),npgap(_40111)),nil,_40553,_40565),
    statreal(_40121,_40441,_40565,_40543),
    unlock(_40543,_40269).

rel_clause(_40111,_40113,_40113 and _40121,[rel_clause,_40291,_40349,_40417,!,_40475],_40251,_40255) --> 
    rel(_40111,_40291,_40251,_40325),
    lit_of(_40169,[du,jeg,de,han,hun,vi,dere,man],_40349,_40325,_40387),
    look_ahead_vp(_40417,_40387,_40447),
    !,
    lock(last,_40447,_40587),
    pushstack(last,([_40169],npgap(_40111)),nil,_40587,_40599),
    statreal(_40121,_40475,_40599,_40577),
    unlock(_40577,_40255).

rel_clause(_40111,_40113,_40113 and _40121,[rel_clause,_40239,_40297,_40355],_40199,_40203) --> 
    rel(_40111,_40239,_40199,_40273),
    not_look_ahead([at],_40297,_40273,_40331),
    pushstack(free,npgap(_40111),nil,_40331,_40453),
    statreal(_40121,_40355,_40453,_40203).

rel_clause(_40111,_40113,_40113 and _40121,[rel_clause,_40251,lit(det),!,_40341],_40211,_40215) --> 
    rel(_40111,_40251,_40211,_40285),
    cc(det,_40285,_40329),
    !,
    lock(last,_40329,_40453),
    pushstack(last,([det],npgap(_40111)),nil,_40453,_40465),
    statreal(_40121,_40341,_40465,_40443),
    unlock(_40443,_40215).

relneg(_40111,[relneg,_40187,_40235,!],_40159,_40163) --> 
    relblabla(_40187,_40159,_40217),
    negation0(_40111,_40235,_40217,_40163),
    !.

relneg(_40111,[relneg,_40187,_40245,!],_40159,_40163) --> 
    negation0(_40111,_40187,_40159,_40221),
    relblabla(_40245,_40221,_40163),
    !.

relblabla([relblabla,lit(nå),!],_40145,_40149) --> 
    cc(nå,_40145,_40149),
    !.

relblabla([relblabla,lit(bare),!],_40145,_40149) --> 
    cc(bare,_40145,_40149),
    !.

relblabla([relblabla,_40157],_40135,_40139) --> 
    redundant0(_40157,_40135,_40139).

whose_noun(_40111,_40113,[whose_noun,_40203,_40251],_40169,_40173) --> 
    whose(_40203,_40169,_40233),
    noun(_40123,_40125,u,n,_40111,_40113,_40251,_40233,_40173).

relwhat(_40111,[relwhat,_40205,_40253,{},!,_40325],_40177,_40181) --> 
    hva(_40205,_40177,_40235),
    som0(_40253,_40235,_40283),
    {constrain(_40111,thing)},
    !,
    accept(_40325,_40283,_40181).

relwhat(_40111,[relwhat,lit(hvem),_40231,{},!,_40303],_40181,_40185) --> 
    cc(hvem,_40181,_40229),
    som0(_40231,_40229,_40261),
    {constrain(_40111,agent)},
    !,
    accept(_40303,_40261,_40185).

rel(_40111,[rel,_40235,_40293,_40351,{},!,_40463],_40207,_40211) --> 
    relpron(_40145,_40235,_40207,_40269),
    not_look_ahead(w(quote(_40157)),_40293,_40269,_40327),
    optional([nå],_40351,_40327,_40415),
    {constrain(_40111,_40145)},
    !,
    accept(_40463,_40415,_40211).

comparisons(_40111,_40113,_40115,[comparisons,_40219,_40297],_40179,_40183) --> 
    comparison(_40111,_40113,_40129,_40219,_40179,_40261),
    comparisons0(_40111,_40113,_40129,_40115,_40297,_40261,_40183).

comparisons0(_40111,_40113,_40115,_40115 and _40123,[comparisons0,_40243,_40291,_40369],_40197,_40201) --> 
    and1(_40243,_40197,_40273),
    comparison(_40111,_40113,_40143,_40291,_40273,_40333),
    comparisons0(_40111,_40113,_40143,_40123,_40369,_40333,_40201).

comparisons0(_40111,_40113,_40115,_40115,[comparisons0,[]],_40161,_40161) --> 
    [].

comparison(_40111,_40113,_40115,[comparison,{},{},_40311,!,{}],_40243,_40247) --> 
    {vartypeid(_40111,_40165)},
    {testmember(_40165,[speed,price,name,description])},
    np1_accept(_40153,_40155::_40115,_40311,_40243,_40247),
    !,
    {compare(eq,thing,_40111,_40153,_40155)}.

comparison(_40111,_40113,_40115,[comparison,_40269,{},{},{},!,_40379],_40229,_40233) --> 
    comparator1(_40149,_40269,_40229,_40303),
    {_40149==gt},
    {vartype(_40111,_40169,_40171)},
    {testmember(_40171,[information,minute])},
    !,
    reject(_40379,_40303,_40233).

comparison(_40111,_40113,_40115,[comparison,_40263,{},_40335,{}],_40223,_40227) --> 
    comparator1(_40141,_40263,_40223,_40297),
    {testmember(_40141,[eq,ne])},
    noun_phrase1(_40147,_40149::_40115,_40335,_40297,_40227),
    {compare(_40141,thing,_40111,_40147,_40149)}.

comparison(_40111,_40113,_40115,[comparison,_40271,{},_40343,{}],_40231,_40235) --> 
    comparator1(_40141,_40271,_40231,_40305),
    {testmember(_40141,[gt,ge,le,lt])},
    noun_phrase1(_40147,_40149::_40115,_40343,_40305,_40235),
    {compare(_40141,number,_40111,_40147,_40149)}.

comparison(_40111,_40113,_40115,[comparison,_40241,_40309,{}],_40201,_40205) --> 
    comparator2(_40135,_40137,_40241,_40201,_40279),
    noun_phrase1(_40141,_40143::_40115,_40309,_40279,_40205),
    {compare(_40135,_40137,_40111,_40141,_40143)}.

comparison(_40111,_40113,_40115,[comparison,_40241,_40309,{}],_40201,_40205) --> 
    comparator3(_40135,_40137,_40241,_40201,_40279),
    noun_phrase1(_40141,_40143::_40115,_40309,_40279,_40205),
    {comparad(_40135,_40137,_40111,_40141,_40143)}.

np(_40111,_40113,[np,_40189],_40155,_40159) --> 
    xnp(_40111,_40113,_40189,_40155,_40159).

np(_40111,_40117::_40119,[np,_40201],_40167,_40171) --> 
    noun_phrases(_40111,_40117::_40119,_40201,_40167,_40171).

np(_40111,_40117::_40117,[np,_40193],_40159,_40163) --> 
    npgap(_40111,_40193,_40159,_40163).

np0_accept(_40111,_40117::_40119,[np0_accept,_40213,!,_40291],_40179,_40183) --> 
    np0(_40111,_40117::_40119,_40213,_40179,_40251),
    !,
    accept(_40291,_40251,_40183).

np00(_40111,_40137:_40111,_40119::exists(_40137:_40111)::_40137 isa _40111 and _40119,[np00,[]],_40195,_40195) --> 
    [].

raise_object00(_40111,_40117::_40117 and _40111,[raise_object00,[]],_40161,_40161) --> 
    [].

subject(_40111,_40113,[subject,_40275,_40333,_40391,_40449],_40241,_40245) --> 
    not_look_ahead(w(name(være,n,_40153)),_40275,_40241,_40309),
    not_look_ahead(w(name(norwegian,n,language)),_40333,_40309,_40367),
    not_look_ahead_lit([meg,deg,ham,henne,seg,oss,dem,det],_40391,_40367,_40425),
    np(_40111,_40113,_40449,_40425,_40245).

object1(_40111,_40113,[object1,_40225,_40283,!],_40191,_40195) --> 
    not_look_ahead_lit([jeg,du,han,hun,vi],_40225,_40191,_40259),
    np0(_40111,_40113,_40283,_40259,_40195),
    !.

object(_40111,_40113,[object,_40195,_40243],_40161,_40165) --> 
    not_look_ahead_subject(_40195,_40161,_40225),
    noun_phrase_accept(_40111,_40113,_40243,_40225,_40165).

ind_object(_40111,_40113,[ind_object,_40195,_40243],_40161,_40165) --> 
    not_look_ahead_subject(_40195,_40161,_40225),
    noun_phrase_accept(_40111,_40113,_40243,_40225,_40165).

not_look_ahead_time([not_look_ahead_time,_40169,!,_40227],_40147,_40151) --> 
    look_ahead_time(_40169,_40147,_40199),
    !,
    reject(_40227,_40199,_40151).

look_ahead_time([look_ahead_time,_40167],_40145,_40149) --> 
    w(nb(_40115,_40117),_40167,_40145,_40149).

look_ahead_time([look_ahead_time,_40169],_40147,_40151) --> 
    one_of_lit([halv,kvart],_40169,_40147,_40151).

look_ahead_time([look_ahead_time,_40193,{},!],_40171,_40175) --> 
    w(noun(_40127,_40129,_40131,_40133),_40193,_40171,_40175),
    {subclass0(_40127,time)},
    !.

not_look_ahead_subject([not_look_ahead_subject,_40169,!,_40227],_40147,_40151) --> 
    look_ahead_subject(_40169,_40147,_40199),
    !,
    reject(_40227,_40199,_40151).

not_look_ahead_subject([not_look_ahead_subject,[]],_40135,_40135) --> 
    [].

look_ahead_subject([look_ahead_subject,_40185],_40163,_40167) --> 
    look_ahead_lit([jeg,du,han,hun,vi,man],_40185,_40163,_40167).

subject2(_40111,_40113,_40115,[subject2,_40215,!,_40303],_40175,_40179) --> 
    noun_phrase2(_40111,_40113,_40115,_40215,_40175,_40257),
    !,
    accept(_40303,_40257,_40179).

object2hnn(_40111,_40113,_40115,[object2hnn,_40275,_40333,_40391,_40449,!,_40517],_40235,_40239) --> 
    w(name(_40153,_40155,_40157),_40275,_40235,_40309),
    not_look_ahead(w(prep(on)),_40333,_40309,_40367),
    not_look_ahead(w(noun(_40181,_40183,_40185,_40187)),_40391,_40367,_40425),
    not_look_ahead([deg],_40449,_40425,_40483),
    !,
    reject(_40517,_40483,_40239).

object2hnn(_40111,_40113,_40115,[object2hnn,_40215,!,_40303],_40175,_40179) --> 
    object2h(_40111,_40113,_40115,_40215,_40175,_40257),
    !,
    accept(_40303,_40257,_40179).

object2h(_40111,_40113,_40115,[object2h,lit(dere),!,_40243],_40171,_40175) --> 
    cc(dere,_40171,_40231),
    !,
    reject(_40243,_40231,_40175).

object2h(_40111,_40113,_40115,[object2h,_40203],_40163,_40167) --> 
    object2(_40111,_40113,_40115,_40203,_40163,_40167).

object2(_40111,_40113,_40115,[object2,lit(en),lit(gang),!,_40275],_40181,_40185) --> 
    cc(en,_40181,_40241),
    cc(gang,_40241,_40263),
    !,
    reject(_40275,_40263,_40185).

object2(_40111,_40113,_40115,[object2,_40239,_40287,{},!,_40379],_40199,_40203) --> 
    which(_40239,_40199,_40269),
    np(_40113,_40115,_40287,_40269,_40325),
    {\+vartypeid(_40113,place)},
    !,
    accept(_40379,_40325,_40203).

object2(_40111,_40111,_40119::_40119 and _40127,[object2,_40235,_40293,!,_40351],_40195,_40199) --> 
    prep1(around,_40235,_40195,_40269),
    clock(_40293,_40269,_40323),
    !,
    clock_kernel(_40111,_40127,_40351,_40323,_40199).

object2(_40111,_40113,_40119::_40121,[object2,_40229,_40287],_40189,_40193) --> 
    not_look_ahead_lit([middag],_40229,_40189,_40263),
    noun_phrase2(_40111,_40113,_40119::_40121,_40287,_40263,_40193).

object2(_40111,_40113,_40115,[object2,_40241,_40299,!,_40367],_40201,_40205) --> 
    one_of_lit([jeg,du,hun,vi],_40241,_40201,_40275),
    not_look_ahead([som],_40299,_40275,_40333),
    !,
    reject(_40367,_40333,_40205).

noun_phrase2(_40111,_40113,_40119::_40119 and _40127,[noun_phrase2,_40245,!,_40313,_40361],_40205,_40209) --> 
    look_ahead([hvor],_40245,_40205,_40279),
    !,
    accept(_40313,_40279,_40343),
    adverbial_noun_phrase1(_40113,_40119::_40127,_40361,_40343,_40209).

noun_phrase2(_40111,_40111,_40119::_40121,[noun_phrase2,_40233,_40291],_40193,_40197) --> 
    recipron(_40141,_40233,_40193,_40267),
    pushstack(first,npgap(_40111),nil,_40267,_40389),
    noun_phrase1(_40111,_40119::_40121,_40291,_40389,_40197).

noun_phrase2(_40111,_40113,_40119::findalt(diff,_40111,_40113)::_40131 and _40119,[noun_phrase2,_40257,_40305,_40413],_40217,_40221) --> 
    another(_40257,_40217,_40287),
    noun(_40167,sin,u,n,_40113,_40161,_40305,_40287,_40359),
    noun_modsx0(0,_40113,_40161,_40131,_40413,_40359,_40221).

noun_phrase2(_40111,_40113,_40115,[noun_phrase2,_40263,_40321,_40379,!,_40447],_40223,_40227) --> 
    not_look_ahead(w(noun(_40151,_40153,_40155,_40157)),_40263,_40223,_40297),
    not_look_ahead(w(adj2(_40169,_40171)),_40321,_40297,_40355),
    w(verb(_40179,past,part),_40379,_40355,_40413),
    !,
    reject(_40447,_40413,_40227).

noun_phrase2(_40111,_40113,_40115,[noun_phrase2,_40221,!,_40289],_40181,_40185) --> 
    look_ahead([hva],_40221,_40181,_40255),
    !,
    np(_40113,_40115,_40289,_40255,_40185).

noun_phrase2(_40111,_40113,_40115,[noun_phrase2,_40221,_40279,_40327],_40181,_40185) --> 
    not_look_ahead([hva],_40221,_40181,_40255),
    which0(_40279,_40255,_40309),
    np(_40113,_40115,_40327,_40309,_40185).

adverbial_noun_phrase1(_40111,_40117::_40117 and _40125,[adverbial_noun_phrase1,lit(hvor),_40325,_40383,!,_40515],_40269,_40273) --> 
    cc(hvor,_40269,_40323),
    not_look_ahead([mye],_40325,_40323,_40359),
    lock(exact,_40359,_40423),pushstack(exact,(w(prep(in)),w(noun(place,sin,u,n))),nil,_40423,_40435),adverbial1(_40159,_40111,_40167::_40169,_40383,_40435,_40413),unlock(_40413,_40415),
    !,
    lock(last,_40415,_40637),
    pushstack(last,adverbial1(_40159,_40111,_40167::_40169),nil,_40637,_40649),
    statreal(_40125,_40515,_40649,_40627),
    unlock(_40627,_40273).

noun_phrase_accept(_40111,_40113,[noun_phrase_accept,_40201,!,_40279],_40167,_40171) --> 
    np(_40111,_40113,_40201,_40167,_40239),
    !,
    accept(_40279,_40239,_40171).

np1_accept(_40111,_40113,[np1_accept,_40201,!,_40279],_40167,_40171) --> 
    noun_phrase1(_40111,_40113,_40201,_40167,_40239),
    !,
    accept(_40279,_40239,_40171).

noun_phrases2(_40111,_40117::_40123 and _40125,[noun_phrases2,_40263,_40331,_40379,{},!,_40471],_40229,_40233) --> 
    np1_accept(_40159,_40117::_40123,_40263,_40229,_40301),
    and0(_40331,_40301,_40361),
    np1_accept(_40171,_40117::_40125,_40379,_40361,_40417),
    {latin(and,_40159,_40171,_40111)},
    !,
    accept(_40471,_40417,_40233).

noun_phrases(_40111,_40117::_40123 and _40129 and _40131,[noun_phrases,_40341,_40399,{},{},_40495,_40563,{},!,_40655],_40307,_40311) --> 
    look_ahead(w(noun(distance,sin,def,n)),_40341,_40307,_40375),
    noun_phrase1(_40201,_40117::_40123,_40399,_40375,_40437),
    {vartypeid(_40201,_40219)},
    {testmember(_40219,[distance])},
    noun_phrase1(_40237,_40117::_40129,_40495,_40437,_40533),
    noun_phrase1(_40249,_40117::_40131,_40563,_40533,_40601),
    {latin(and,_40237,_40249,_40111)},
    !,
    accept(_40655,_40601,_40311).

noun_phrases(_40111,_40117::_40119,[noun_phrases,_40235,_40303,!,_40401],_40201,_40205) --> 
    noun_phrase1(_40141,_40117::_40149,_40235,_40201,_40273),
    noun_phrases0(_40141,_40111,true::_40149,_40119,_40303,_40273,_40349),
    !,
    accept(_40401,_40349,_40205).

noun_phrases0(_40111,_40111,_40121::_40117,_40117,[noun_phrases0,{},!],_40183,_40183) --> 
    {constrain(_40111,number)},
    !.

noun_phrases0(_40111,_40111,_40121::_40117,_40117,[noun_phrases0,_40233,!],_40187,_40191) --> 
    look_ahead(w(nb(_40141,_40143)),_40233,_40187,_40191),
    !.

noun_phrases0(_40111,_40111,_40121::_40117,_40117,[noun_phrases0,_40231,!],_40185,_40189) --> 
    look_ahead_lit([etc,samme],_40231,_40185,_40189),
    !.

noun_phrases0(_40111,_40111,_40121::_40117,_40117,[noun_phrases0,_40259,{},!],_40213,_40217) --> 
    look_ahead(w(verb(_40147,inf,fin)),_40259,_40213,_40217),
    {testmember(_40147,[be,use])},
    !.

noun_phrases0(_40111,_40111,_40121::_40117,_40117,[noun_phrases0,_40259,{},!],_40213,_40217) --> 
    look_ahead(w(verb(_40147,pres,fin)),_40259,_40213,_40217),
    {testmember(_40147,[wish,want])},
    !.

noun_phrases0(_40111,_40113,_40127::_40121,_40121 and _40123,[noun_phrases0,_40317,_40375,_40433,_40491,_40559,{}],_40271,_40275) --> 
    not_look_ahead([','],_40317,_40271,_40351),
    np_conjunction(_40167,_40375,_40351,_40409),
    not_look_ahead(w(noun(_40197,sin,def,n)),_40433,_40409,_40467),
    noun_phrase1(_40207,_40127::_40215,_40491,_40467,_40529),
    noun_phrases20(_40207,_40171,_40127,_40215,_40123,_40559,_40529,_40275),
    {latin(_40167,_40111,_40171,_40113)}.

noun_phrases0(_40111,_40113,_40127::_40121,_40121 and _40123,[noun_phrases0,{},_40303,_40371,{}],_40243,_40247) --> 
    {\+vartypeid(_40111,savant)},
    noun_phrase1(_40179,_40127::_40187,_40303,_40243,_40341),
    noun_phrases10(_40179,_40159,_40127,_40187,_40123,_40371,_40341,_40247),
    {latin(and,_40111,_40159,_40113)}.

noun_phrases0(_40111,_40111,_40121::_40117,_40117,[noun_phrases0,[]],_40167,_40167) --> 
    [].

noun_phrases10(_40111,_40113,_40115,_40117,_40117 and _40125,[noun_phrases10,_40295,_40353,_40421,{},lit(etc)],_40243,_40247) --> 
    andor(_40157,_40295,_40243,_40329),
    noun_phrase1(_40161,_40115::_40169,_40353,_40329,_40391),
    noun_phrases20(_40161,_40175,_40115,_40169,_40125,_40421,_40391,_40471),
    {latin(_40157,_40111,_40175,_40113)},
    cc(etc,_40471,_40247).

noun_phrases10(_40111,_40113,_40115,_40117,_40117 and _40125,[noun_phrases10,_40295,_40353,_40421,{}],_40243,_40247) --> 
    not_look_ahead(w(nb(_40169,_40171)),_40295,_40243,_40329),
    noun_phrase1(_40175,_40115::_40183,_40353,_40329,_40391),
    noun_phrases10(_40175,_40155,_40115,_40183,_40125,_40421,_40391,_40247),
    {latin(and,_40111,_40155,_40113)}.

noun_phrases10(_40111,_40111,_40115,_40117,_40117,[noun_phrases10,lit(etc)],_40171,_40175) --> 
    cc(etc,_40171,_40175).

noun_phrases20(_40111,_40113,_40115,_40117,_40117 and _40125,[noun_phrases20,_40285,_40343,_40411,{}],_40233,_40237) --> 
    andor(_40151,_40285,_40233,_40319),
    noun_phrase1(_40165,_40115::_40173,_40343,_40319,_40381),
    noun_phrases20(_40165,_40155,_40115,_40173,_40125,_40411,_40381,_40237),
    {latin(_40151,_40111,_40155,_40113)}.

noun_phrases20(_40111,_40111,_40115,_40117,_40117,[noun_phrases20,[]],_40167,_40167) --> 
    [].

no_phrases(_40111,_40113,[no_phrases,{},!,_40253],_40189,_40193) --> 
    {user:value(teleflag,true)},
    !,
    np(_40111,true::_40113,_40253,_40189,_40193).

no_phrases(_40111,_40113,[no_phrases,_40201,_40249],_40167,_40171) --> 
    the0(_40201,_40167,_40231),
    np(_40111,true::_40113,_40249,_40231,_40171).

no_phrase(_40111,_40113,[no_phrase,_40201,_40249],_40167,_40171) --> 
    the0(_40201,_40167,_40231),
    noun_phrase1(_40111,true::_40113,_40249,_40231,_40171).

noun_phrase1(_40111,_40113,[noun_phrase1,lit(og),!,_40231],_40165,_40169) --> 
    cc(og,_40165,_40219),
    !,
    reject(_40231,_40219,_40169).

noun_phrase1(_40111,_40113,[noun_phrase1,_40189],_40155,_40159) --> 
    np2(_40111,_40113,_40189,_40155,_40159).

noun_phrase1(_40111,_40113,[noun_phrase1,_40189],_40155,_40159) --> 
    np1(_40111,_40113,_40189,_40155,_40159).

noun_phrase1(_40111,_40113,[noun_phrase1,_40243,_40301,_40359,_40417,_40465],_40209,_40213) --> 
    one_of_lit([noen,mange],_40243,_40209,_40277),
    not_look_ahead([som],_40301,_40277,_40335),
    not_look_ahead([av],_40359,_40335,_40393),
    not_look_ahead_np(_40417,_40393,_40447),
    np00(agent,_40111,_40113,_40465,_40447,_40213).

noun_phrase1(_40111,_40113,[noun_phrase1,_40237,_40295,_40353,_40401],_40203,_40207) --> 
    one_of_lit([den,det],_40237,_40203,_40271),
    not_look_ahead(w(verb(_40163,_40165,pass)),_40295,_40271,_40329),
    not_look_ahead_np(_40353,_40329,_40383),
    np00(thing,_40111,_40113,_40401,_40383,_40207).

noun_phrase1(_40111,_40117::_40119,[noun_phrase1,_40317,_40375,_40433,_40501,_40559,!,_40627,_40675],_40283,_40287) --> 
    not_look_ahead([de],_40317,_40283,_40351),
    not_look_ahead([det],_40375,_40351,_40409),
    quant_pron(some,_40181,_40433,_40409,_40471),
    not_look_ahead([som],_40501,_40471,_40535),
    not_look_ahead(w(noun(_40229,_40231,_40233,_40235)),_40559,_40535,_40593),
    !,
    accept(_40627,_40593,_40657),
    lock(exact,_40657,_40781),
    pushstack(exact,(some,w(noun(_40181,sin,u,n))),nil,_40781,_40793),
    np1(_40111,_40117::_40119,_40675,_40793,_40771),
    unlock(_40771,_40287).

noun_phrase1(_40111,_40113,[noun_phrase1,_40301,_40359,_40427,_40485,!,_40553,_40601],_40267,_40271) --> 
    not_look_ahead([de],_40301,_40267,_40335),
    quant_pron(every,thing,_40359,_40335,_40397),
    not_look_ahead(w(noun(_40201,_40203,_40205,_40207)),_40427,_40397,_40461),
    not_look_ahead(w(adj2(_40219,_40221)),_40485,_40461,_40519),
    !,
    accept(_40553,_40519,_40583),
    pushstack(first,([alle],w(noun(thing,sin,u,n))),nil,_40583,_40621),
    np1(_40111,_40113,_40601,_40621,_40271).

noun_phrase1(_40111,_40113,[noun_phrase1,_40189],_40155,_40159) --> 
    npa(_40111,_40113,_40189,_40155,_40159).

noun_phrase1(_40111,_40117::_40119,[noun_phrase1,_40239,_40307],_40205,_40209) --> 
    quant_pron(much,_40145,_40239,_40205,_40277),
    lock(exact,_40277,_40413),
    pushstack(exact,(much,w(noun(_40145,sin,u,n))),nil,_40413,_40425),
    np1(_40111,_40117::_40119,_40307,_40425,_40403),
    unlock(_40403,_40209).

noun_phrase1(_40111,_40117::_40119,[noun_phrase1,_40239,_40307],_40205,_40209) --> 
    quant_pron(little,_40145,_40239,_40205,_40277),
    lock(exact,_40277,_40413),
    pushstack(exact,(little,w(noun(_40145,sin,u,n))),nil,_40413,_40425),
    np1(_40111,_40117::_40119,_40307,_40425,_40403),
    unlock(_40403,_40209).

noun_phrase1(_40111,_40117::not _40123,[noun_phrase1,_40243,_40311],_40209,_40213) --> 
    quant_pron(no,_40149,_40243,_40209,_40281),
    lock(exact,_40281,_40417),
    pushstack(exact,(every,w(noun(_40149,sin,u,n))),nil,_40417,_40429),
    np1(_40111,_40117::_40123,_40311,_40429,_40407),
    unlock(_40407,_40213).

noun_phrase1(_40111,_40113,[noun_phrase1,_40189],_40155,_40159) --> 
    xnp(_40111,_40113,_40189,_40155,_40159).

noun_phrase1(_40111,_40117::_40117,[noun_phrase1,_40193],_40159,_40163) --> 
    npgap(_40111,_40193,_40159,_40163).

specific_phrase(_40111,_40113,[specific_phrase,_40207,!,_40275],_40173,_40177) --> 
    w(name(_40133,gen,_40137),_40207,_40173,_40241),
    !,
    reject(_40275,_40241,_40177).

specific_phrase(_40111,_40113,[specific_phrase,_40213,_40271,!,_40329],_40179,_40183) --> 
    w(name(_40139,_40141,_40143),_40213,_40179,_40247),
    sin(_40271,_40247,_40301),
    !,
    reject(_40329,_40301,_40183).

specific_phrase(_40111,_40117::_40119,[specific_phrase,_40201],_40167,_40171) --> 
    sp1(_40111,_40117::_40119,_40201,_40167,_40171).

sp1(_40135:_40137,_40117::findpron(_40135:_40137)::_40135 isa _40153 and _40117,[sp1,_40243,{}],_40209,_40213) --> 
    pronoun(_40153,_40243,_40209,_40213),
    {type(_40153,_40137)}.

sp1(_40111,_40113,[sp1,_40215,_40293],_40181,_40185) --> 
    name_phrase(name,_40111,_40113,_40215,_40181,_40257),
    not_look_ahead(w(noun(_40131,_40133,_40135,_40137)),_40293,_40257,_40185).

np0(_40111,_40113,[np0,lit(mye),_40281,_40329,_40387,!,_40519],_40225,_40229) --> 
    cc(mye,_40225,_40279),
    not_look_ahead_np(_40281,_40279,_40311),
    not_look_ahead(w(adj(_40159,_40161)),_40329,_40311,_40363),
    lock(exact,_40363,_40427),pushstack(exact,w(noun(thing,sin,u,n)),nil,_40427,_40439),np_kernel(0,_40111,_40113,_40387,_40439,_40417),unlock(_40417,_40419),
    !,
    accept(_40519,_40419,_40229).

np0(_40111,_40117::_40119,[np0,_40215,!,_40303],_40181,_40185) --> 
    np_head1(_40135,_40111,_40117::_40119,_40215,_40181,_40257),
    !,
    accept(_40303,_40257,_40185).

np0(_40111,_40117::_40119,[np0,_40209,_40257],_40175,_40179) --> 
    the10(_40209,_40175,_40239),
    aname_phrase(_40129,_40111,_40117::_40119,_40257,_40239,_40179).

np0(_40111,_40117::_40119,[np0,_40203],_40169,_40173) --> 
    np_kernel(_40123,_40111,_40117::_40119,_40203,_40169,_40173).

np0(_40111,_40117::_40119,[np0,_40201],_40167,_40171) --> 
    npa(_40111,_40117::_40119,_40201,_40167,_40171).

np0(_40111,_40117::_40117,[np0,_40193],_40159,_40163) --> 
    npgap(_40111,_40193,_40159,_40163).

obvious_object(_40111,_40113,[obvious_object,lit(det),_40243,!,_40311],_40187,_40191) --> 
    cc(det,_40187,_40241),
    not_look_ahead(w(verb(_40147,_40149,pass)),_40243,_40241,_40277),
    !,
    reject(_40311,_40277,_40191).

obvious_object(_40111,_40113,[obvious_object,_40209,_40267,!],_40175,_40179) --> 
    look_ahead([alt],_40209,_40175,_40243),
    np1_accept(_40111,_40113,_40267,_40243,_40179),
    !.

obvious_object(_40111,_40113,[obvious_object,_40203,_40261],_40169,_40173) --> 
    not_look_ahead([noen],_40203,_40169,_40237),
    np0_accept(_40111,_40113,_40261,_40237,_40173).

np1(_40111,_40117::_40117 and _40125,[np1,_40327,lit(det),_40397,lit(å),!,_40487,!,_40583],_40293,_40297) --> 
    hvormye(_40327,_40293,_40357),
    cc(det,_40357,_40395),
    w(verb(_40201,_40203,fin),_40397,_40395,_40431),
    cc(å,_40431,_40475),
    !,
    pushstack(first,([noen],[vil]),nil,_40475,_40513),clausal_object1(_40229,_40231,_40487,_40513,_40543),
    !,
    lock(exact,_40543,_40775),
    pushstack(exact,(xnp(_40229,_40231),w(verb(_40201,_40203,fin)),npgap(_40111)),nil,_40775,_40787),
    statreal1(_40125,_40583,_40787,_40765),
    unlock(_40765,_40297).

np1(_40111,_40113,[np1,lit(noe),_40283,!,_40351,_40473],_40227,_40231) --> 
    cc(noe,_40227,_40281),
    look_ahead(w(prep(_40163)),_40283,_40281,_40317),
    !,
    lock(exact,_40317,_40391),pushstack(exact,w(noun(thing,sin,u,n)),nil,_40391,_40403),np_kernel(0,_40111,_40145,_40351,_40403,_40381),unlock(_40381,_40383),
    noun_modifiers0(0,_40111,_40145,_40113,_40473,_40383,_40231).

np1(_40111,_40113,[np1,_40395,_40443,_40501,_40559,{},!,_40641,_40689,_40811],_40361,_40365) --> 
    a(_40395,_40361,_40425),
    w(noun(_40199,sin,u,n),_40443,_40425,_40477),
    w(name(_40187,n,_40191),_40501,_40477,_40535),
    w(noun(_40225,sin,u,n),_40559,_40535,_40593),
    {\+testmember(_40225,[minute,hour,direction,home,station])},
    !,
    accept(_40641,_40593,_40671),
    lock(exact,_40671,_40729),pushstack(exact,w(noun(_40225,sin,u,n)),nil,_40729,_40741),np_kernel(_40289,_40111,_40293,_40689,_40741,_40719),unlock(_40719,_40721),
    lock(exact,_40721,_40845),
    pushstack(exact,(w(prep(with)),w(noun(_40199,sin,u,n)),w(name(_40187,n,_40191))),nil,_40845,_40857),
    noun_modifiers0(0,_40111,_40293,_40113,_40811,_40857,_40835),
    unlock(_40835,_40365).

np1(_40111,_40113,[np1,lit(hvem),_40281,!,_40349,_40427],_40225,_40229) --> 
    cc(hvem,_40225,_40279),
    look_ahead_lit([man,jeg,du,vi],_40281,_40279,_40315),
    !,
    np00(agent,_40111,_40179,_40349,_40315,_40391),
    pushstack(first,relpron(agent),nil,_40391,_40519),
    noun_modifiers0(0,_40111,_40179,_40113,_40427,_40519,_40229).

np1(_40111,_40113,[np1,lit(hvem),lit(som),!,_40297,_40375],_40209,_40213) --> 
    cc(hvem,_40209,_40263),
    cc(som,_40263,_40285),
    !,
    np00(agent,_40111,_40163,_40297,_40285,_40339),
    pushstack(first,relpron(agent),nil,_40339,_40473),
    noun_modifiers0(0,_40111,_40163,_40113,_40375,_40473,_40213).

np1(_40111,_40113,[np1,_40255,_40303,!,_40361,_40483],_40221,_40225) --> 
    hvormye(_40255,_40221,_40285),
    dette(_40303,_40285,_40333),
    !,
    lock(exact,_40333,_40401),pushstack(exact,w(noun(thing,sin,u,n)),nil,_40401,_40413),np_kernel(0,_40111,_40175,_40361,_40413,_40391),unlock(_40391,_40393),
    pushstack(first,relpron(thing),nil,_40393,_40571),
    noun_modifiers0(0,_40111,_40175,_40113,_40483,_40571,_40225).

np1(_40111,_40113,[np1,lit(hva),lit(som),!,_40297,_40375],_40209,_40213) --> 
    cc(hva,_40209,_40263),
    cc(som,_40263,_40285),
    !,
    np00(thing,_40111,_40163,_40297,_40285,_40339),
    pushstack(first,relpron(thing),nil,_40339,_40473),
    noun_modifiers0(0,_40111,_40163,_40113,_40375,_40473,_40213).

np1(_40111,_40113,[np1,lit(hva),_40281,!,_40339,_40461],_40225,_40229) --> 
    cc(hva,_40225,_40279),
    look_ahead_np(_40281,_40279,_40311),
    !,
    lock(exact,_40311,_40379),pushstack(exact,w(noun(thing,sin,u,n)),nil,_40379,_40391),np_kernel(0,_40111,_40179,_40339,_40391,_40369),unlock(_40369,_40371),
    pushstack(first,relpron(thing),nil,_40371,_40559),
    noun_modifiers0(0,_40111,_40179,_40113,_40461,_40559,_40229).

np1(_40111,_40113,[np1,lit(de),_40273,_40331,!,_40399],_40217,_40221) --> 
    cc(de,_40217,_40271),
    not_look_ahead(w(nb(_40161,_40163)),_40273,_40271,_40307),
    look_ahead(w(noun(_40175,sin,_40179,_40181)),_40331,_40307,_40365),
    !,
    np00(agent,_40111,_40113,_40399,_40365,_40221).

np1(_40111,_40113,[np1,_40311,!,_40369,lit(å),_40459,!,_40527,_40649],_40277,_40281) --> 
    noemed(_40311,_40277,_40341),
    !,
    np0_accept(_40171,_40173,_40369,_40341,_40407),
    cc(å,_40407,_40457),
    w(verb(do1,inf,fin),_40459,_40457,_40493),
    !,
    lock(exact,_40493,_40567),pushstack(exact,w(noun(thing,sin,u,n)),nil,_40567,_40579),np_kernel(_40219,_40111,_40223,_40527,_40579,_40557),unlock(_40557,_40559),
    pushstack(first,(w(prep(with)),xnp(_40171,_40173)),nil,_40559,_40749),
    noun_modifiers0(_40219,_40111,_40223,_40113,_40649,_40749,_40281).

noemed([noemed,lit(noe),lit(med)],_40149,_40153) --> 
    cc(noe,_40149,_40191),
    cc(med,_40191,_40153).

np1(_40111,_40113,[np1,_40259,!,_40317,_40439],_40225,_40229) --> 
    noeå(_40259,_40225,_40289),
    !,
    lock(exact,_40289,_40357),pushstack(exact,w(noun(thing,sin,u,n)),nil,_40357,_40369),np_kernel(0,_40111,_40175,_40317,_40369,_40347),unlock(_40347,_40349),
    pushstack(first,([som],[jeg]),nil,_40349,_40459),
    noun_modifiers0(0,_40111,_40175,_40113,_40439,_40459,_40229).

noeå([noeå,lit(noe),lit(å)],_40149,_40153) --> 
    cc(noe,_40149,_40191),
    cc(å,_40191,_40153).

np1(_40111,_40113,[np1,_40249,!,_40307,_40429],_40215,_40219) --> 
    noesom(_40249,_40215,_40279),
    !,
    lock(exact,_40279,_40347),pushstack(exact,w(noun(thing,sin,u,n)),nil,_40347,_40359),np_kernel(0,_40111,_40169,_40307,_40359,_40337),unlock(_40337,_40339),
    pushstack(first,[som],nil,_40339,_40449),
    noun_modifiers0(0,_40111,_40169,_40113,_40429,_40449,_40219).

noesom([noesom,lit(det),_40209],_40165,_40169) --> 
    cc(det,_40165,_40207),
    look_ahead_lit([man,jeg,du,vi],_40209,_40207,_40169).

noesom([noesom,lit(det),lit(som)],_40149,_40153) --> 
    cc(det,_40149,_40191),
    cc(som,_40191,_40153).

noesom([noesom,lit(noe),lit(som)],_40149,_40153) --> 
    cc(noe,_40149,_40191),
    cc(som,_40191,_40153).

noesom([noesom,lit(noe),_40209],_40165,_40169) --> 
    cc(noe,_40165,_40207),
    look_ahead_lit([jeg,du,han,hun],_40209,_40207,_40169).

noesom([noesom,lit(hva),lit(som)],_40149,_40153) --> 
    cc(hva,_40149,_40191),
    cc(som,_40191,_40153).

noesom([noesom,lit(det),_40207,!],_40163,_40167) --> 
    cc(det,_40163,_40205),
    look_ahead_lit([jeg,du],_40207,_40205,_40167),
    !.

np1(_40111,_40113,[np1,lit(det),_40269,!,_40337,_40415],_40213,_40217) --> 
    cc(det,_40213,_40267),
    look_ahead([de],_40269,_40267,_40303),
    !,
    np00(agent,_40111,_40167,_40337,_40303,_40379),
    pushstack(first,[som],nil,_40379,_40435),
    noun_modifiers0(0,_40111,_40167,_40113,_40415,_40435,_40217).

np1(_40111,_40113,[np1,lit(noen),_40269,!,_40337,_40415],_40213,_40217) --> 
    cc(noen,_40213,_40267),
    look_ahead([de],_40269,_40267,_40303),
    !,
    np00(agent,_40111,_40167,_40337,_40303,_40379),
    pushstack(first,[som],nil,_40379,_40435),
    noun_modifiers0(0,_40111,_40167,_40113,_40415,_40435,_40217).

np1(_40111,_40113,[np1,lit(hvilke),_40275,_40353,_40411,!,_40469],_40219,_40223) --> 
    cc(hvilke,_40219,_40273),
    np_kernel(_40161,_40111,_40165,_40275,_40273,_40317),
    not_look_ahead([som],_40353,_40317,_40387),
    look_ahead_np(_40411,_40387,_40441),
    !,
    pushstack(first,[som],nil,_40441,_40489),
    noun_modifiers0(_40161,_40111,_40165,_40113,_40469,_40489,_40223).

np1(_40111,_40113,[np1,lit(hvilke),_40259,_40337,!,_40405],_40203,_40207) --> 
    cc(hvilke,_40203,_40257),
    np_kernel(_40141,_40111,_40145,_40259,_40257,_40301),
    look_ahead([som],_40337,_40301,_40371),
    !,
    noun_modifiers0(_40141,_40111,_40145,_40113,_40405,_40371,_40207).

np1(_40111,_40113,[np1,{},lit(de),_40429,_40487,_40545,_40603,!,_40671,[],_40747,_40843],_40353,_40357) --> 
    {user:value(busflag,true)},
    cc(de,_40353,_40427),
    w(nb(_40211,num),_40429,_40427,_40463),
    flnp(_40217,_40487,_40463,_40521),
    not_look_ahead(w(noun(_40229,_40231,_40233,_40235)),_40545,_40521,_40579),
    w(prep(_40243),_40603,_40579,_40637),
    !,
    accept(_40671,_40637,_40701),
    pushstack(free,w(prep(_40243)),nil,_40701,_40745),[],
    pushstack(first,(w(nb(_40211,num)),w(adj2(_40217,nil)),w(noun(vehicle,sin,u,n))),nil,_40745,_40773),np_kernel(_40177,_40111,_40181,_40747,_40773,_40807),
    noun_modifiers0(_40177,_40111,_40181,_40113,_40843,_40807,_40357).

np1(_40111,_40117::_40119,[np1,_40213,!,_40291],_40179,_40183) --> 
    obviousclock(_40111,_40117::_40119,_40213,_40179,_40251),
    !,
    accept(_40291,_40251,_40183).

np1(_40111,_40113,[np1,{},lit(en),_40383,{},_40455,!,_40523,_40571,_40667],_40307,_40311) --> 
    {user:value(busflag,true)},
    cc(en,_40307,_40381),
    w(nb(_40199,num),_40383,_40381,_40417),
    {plausible_busno(_40199)},
    not_look_ahead(w(noun(_40221,_40223,_40225,_40227)),_40455,_40417,_40489),
    !,
    accept(_40523,_40489,_40553),
    pushstack(first,(w(noun(vehicle,sin,u,n)),w(nb(_40199,num))),nil,_40553,_40597),np_kernel(_40165,_40111,_40169,_40571,_40597,_40631),
    noun_modifiers0(_40165,_40111,_40169,_40113,_40667,_40631,_40311).

np1(_40111,_40117::_40119,[np1,_40231,_40309],_40197,_40201) --> 
    np_kernel(_40129,_40111,_40153::_40155,_40231,_40197,_40273),
    noun_modifiers0(_40129,_40111,_40153::_40155,_40117::_40119,_40309,_40273,_40201).

np_kernel(0,_40137:thing,_40119::findpron(_40137:thing)::_40137 isa thing and _40119,[np_kernel,_40247,_40295,!],_40207,_40211) --> 
    dette(_40247,_40207,_40277),
    not_look_ahead_np(_40295,_40277,_40211),
    !.

np_kernel(0,_40137:agent,_40119::findpron(_40137:agent)::_40137 isa agent and _40119,[np_kernel,lit(de),_40329,_40387,_40445,!],_40267,_40271) --> 
    cc(de,_40267,_40327),
    not_look_ahead(w(nb(_40195,_40197)),_40329,_40327,_40363),
    not_look_ahead(w(adj2(_40209,_40211)),_40387,_40363,_40421),
    look_ahead(w(verb(_40223,pres,fin)),_40445,_40421,_40271),
    !.

np_kernel(0,_40113,_40119::_40121,[np_kernel,_40225,!,_40303],_40185,_40189) --> 
    obviousdate(_40113,_40119::_40121,_40225,_40185,_40263),
    !,
    accept(_40303,_40263,_40189).

np_kernel(0,_40137:thing,_40119::findpron(_40137:thing)::_40137 isa thing and _40119,[np_kernel,lit(en),_40305,!],_40243,_40247) --> 
    cc(en,_40243,_40303),
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_40305,_40303,_40247),
    !.

np_kernel(name,_40137:_40139,_40119::findpron(_40137:_40139)::_40137 isa _40139 and _40119,[np_kernel,_40271,_40329,!],_40231,_40235) --> 
    not_look_ahead_lit([de,den,det,et],_40271,_40231,_40305),
    pronoun(_40139,_40329,_40305,_40235),
    !.

np_kernel(0,_40137:thing,_40119::exists(_40137:thing)::_40137 isa thing and _40119,[np_kernel,_40271,_40329,!],_40231,_40235) --> 
    one_of_lit([alt,noe],_40271,_40231,_40305),
    look_ahead_lit([som,å],_40329,_40305,_40235),
    !.

np_kernel(_40111,_40113,_40119::_40121,[np_kernel,_40215],_40175,_40179) --> 
    np_head1(_40111,_40113,_40119::_40121,_40215,_40175,_40179).

np_kernel(_40111,_40113,_40115,[np_kernel,_40249,_40307,_40365],_40209,_40213) --> 
    look_ahead(w(name(_40147,n,_40151)),_40249,_40209,_40283),
    not_look_ahead(w(noun(_40163,_40165,_40167,_40169)),_40307,_40283,_40341),
    aname_phrase(_40111,_40113,_40115,_40365,_40341,_40213).

np_kernel(_40111,_40113,_40119::_40121,[np_kernel,_40215],_40175,_40179) --> 
    np_head(_40111,_40113,_40119::_40121,_40215,_40175,_40179).

np_kernel(_40111,_40113,_40119::_40121,[np_kernel,_40237,_40295],_40197,_40201) --> 
    not_look_ahead(w(name(_40153,n,_40157)),_40237,_40197,_40271),
    aname_phrase(_40111,_40113,_40119::_40121,_40295,_40271,_40201).

np_head1(_40111,_40113,_40119::_40121,[np_head1,{},_40305,_40403,_40461,{}],_40245,_40249) --> 
    {user:value(teleflag,true)},
    determiner0(_40179,_40111,_40113,_40159,_40119::_40121,_40305,_40245,_40355),
    preadjs0(_40153,_40403,_40355,_40437),
    noun_list2(_40201,_40113,_40157,_40461,_40437,_40249),
    {preadjs_template(_40153,_40113,_40157,_40159)}.

np_head1(0,_40125:_40127,_40119::_40121,[np_head1,{},_40383,_40471,_40579,!,{},{},{}],_40323,_40327) --> 
    {user:value(busflag,true)},
    optional([denne],_40383,_40323,_40447),
    bus_head(_40211,_40177,_40215,_40127,_40219,_40125,_40471,_40447,_40525),
    not_look_ahead_lit([sin,sitt,sine],_40579,_40525,_40327),
    !,
    {decide_adjective(_40215,_40125,_40249)},
    {_40257=(_40125 isa _40127 and _40249)},
    {decide_quantifier(_40177,_40125:_40127,_40257 and _40119,_40121)}.

np_head1(0,_40113,_40119::_40121,[np_head1,{},lit(den),_40411,{},_40483,!,_40551,_40599,!,_40731],_40329,_40333) --> 
    {user:value(busflag,true)},
    cc(den,_40329,_40409),
    w(adj2(_40203,nil),_40411,_40409,_40445),
    {testmember(_40203,[first,last,next,previous])},
    look_ahead([som],_40483,_40445,_40517),
    !,
    accept(_40551,_40517,_40581),
    lock(exact,_40581,_40639),pushstack(exact,(w(adj2(_40203,nil)),w(noun(vehicle,sin,u,n))),nil,_40639,_40651),np_head(0,_40113,_40119::_40121,_40599,_40651,_40629),unlock(_40629,_40631),
    !,
    accept(_40731,_40631,_40333).

np_head1(0,_40113,_40119::exists(_40113)::_40131 and _40137 and _40119,[np_head1,_40299,_40357,_40415,{},!,_40547],_40259,_40263) --> 
    not_look_ahead([dere],_40299,_40259,_40333),
    w(name(_40189,_40191,_40193),_40357,_40333,_40391),
    noun(_40197,_40199,_40201,n,_40113,_40137,_40415,_40391,_40469),
    {adjnamecomp_template(_40189,_40113,_40131)},
    !,
    accept(_40547,_40469,_40263).

bus_head(_40111,_40113,_40115,_40117,_40117,_40121,[bus_head,_40317,_40385,_40453,{},{},_40549,_40617],_40259,_40263) --> 
    traceprint(5,bx01,_40317,_40259,_40355),
    art0(_40111,_40175,_40385,_40355,_40423),
    quantnext(_40113,_40115,_40453,_40423,_40491),
    {_40115\==nil},
    {_40113=<5},
    busnumber(_40121,_40117,_40549,_40491,_40587),
    traceprint(4,bh01,_40617,_40587,_40263).

bus_head(_40111,_40113,_40115,_40117,_40119,_40121,[bus_head,_40303,_40371,_40439,{},_40521,_40599],_40245,_40249) --> 
    traceprint(5,bx02,_40303,_40245,_40341),
    art0(_40111,_40169,_40371,_40341,_40409),
    quantnext(_40113,_40115,_40439,_40409,_40477),
    {_40113=<5},
    busseno(_40121,_40117,_40119,_40521,_40477,_40563),
    traceprint(4,bh02,_40599,_40563,_40249).

bus_head(_40111,_40113,_40115,_40117,_40117,_40121,[bus_head,_40327,_40395,_40463,{},_40545,_40603,_40651,_40719],_40269,_40273) --> 
    traceprint(5,bx03,_40327,_40269,_40365),
    art0(_40111,_40181,_40395,_40365,_40433),
    quantnext(_40113,_40115,_40463,_40433,_40501),
    {_40113=<5},
    not_look_ahead(w(nb(_40209,_40211)),_40545,_40501,_40579),
    nr0(_40603,_40579,_40633),
    busnumber(_40121,_40117,_40651,_40633,_40689),
    traceprint(4,bh03,_40719,_40689,_40273).

bus_head(_40111,_40113,_40115,_40117,_40117,_40121,[bus_head,_40345,_40413,_40481,{},_40563,_40621,_40733,!],_40287,_40291) --> 
    traceprint(5,bx04,_40345,_40287,_40383),
    art0(_40111,_40175,_40413,_40383,_40451),
    quantnext(_40113,_40115,_40481,_40451,_40519),
    {_40113=<5},
    look_ahead(w(prep(_40203)),_40563,_40519,_40597),
    lock(exact,_40597,_40661),pushstack(exact,w(noun(bus,plu,def,n)),nil,_40661,_40673),busnumber(_40121,_40117,_40621,_40673,_40651),unlock(_40651,_40653),
    traceprint(4,bh04,_40733,_40653,_40291),
    !.

bus_head(_40111,1,_40115,_40117,_40119,_40121,[bus_head,_40305,_40373,_40441,_40499,_40547,_40615,_40703],_40247,_40251) --> 
    traceprint(5,bx05,_40305,_40247,_40343),
    art0(_40111,_40175,_40373,_40343,_40411),
    flnp(_40115,_40441,_40411,_40475),
    nr1(_40499,_40475,_40529),
    busnumber(_40121,_40119,_40547,_40529,_40585),
    busse0(_40119,_40117,_40193,_40195,_40615,_40585,_40661),
    traceprint(4,bh05,_40703,_40661,_40251).

bus_head(_40111,_40113,nil,_40117,_40119,_40121,[bus_head,_40305,_40373,_40441,_40499,_40547,_40615,_40703],_40247,_40251) --> 
    traceprint(5,bx06,_40305,_40247,_40343),
    art0(_40111,_40175,_40373,_40343,_40411),
    quant(_40113,_40441,_40411,_40475),
    nr1(_40499,_40475,_40529),
    busnumber(_40121,_40119,_40547,_40529,_40585),
    busse0(_40119,_40117,_40193,_40195,_40615,_40585,_40661),
    traceprint(4,bh06,_40703,_40661,_40251).

bus_head(_40111,_40113,nil,_40117,_40119,_40121,[bus_head,_40303,_40371,_40439,_40497,_40575,_40623,_40691],_40245,_40249) --> 
    traceprint(5,bx07,_40303,_40245,_40341),
    art0(_40111,_40175,_40371,_40341,_40409),
    quant(_40113,_40439,_40409,_40473),
    busnoun(_40117,_40185,_40187,_40497,_40473,_40539),
    nr0(_40575,_40539,_40605),
    busnumber(_40121,_40119,_40623,_40605,_40661),
    traceprint(4,bh07,_40691,_40661,_40249).

bus_head(_40111,_40113,nil,_40117,_40119,_40121,[bus_head,_40297,_40365,_40433,_40491,_40559,_40637],_40239,_40243) --> 
    traceprint(5,bx08,_40297,_40239,_40335),
    art0(_40111,_40169,_40365,_40335,_40403),
    quant(_40113,_40433,_40403,_40467),
    busnumber(_40121,_40119,_40491,_40467,_40529),
    busnoun(_40117,_40185,_40187,_40559,_40529,_40601),
    traceprint(4,bh08,_40637,_40601,_40243).

bus_head(_40111,1,_40115,_40117,_40119,_40121,[bus_head,_40303,_40371,_40439,_40497,_40545,_40613,_40691],_40245,_40249) --> 
    traceprint(5,bx09,_40303,_40245,_40341),
    art0(_40111,_40175,_40371,_40341,_40409),
    filanepr(_40115,_40439,_40409,_40473),
    nr1(_40497,_40473,_40527),
    busnumber(_40121,_40119,_40545,_40527,_40583),
    busnoun(_40117,_40191,_40193,_40613,_40583,_40655),
    traceprint(4,bh09,_40691,_40655,_40249).

bus_head(_40111,1,_40115,route,_40119,_40121,[bus_head,_40305,_40373,{},_40455,_40513,_40561,_40629],_40247,_40251) --> 
    traceprint(5,bx10,_40305,_40247,_40343),
    art0(_40111,_40175,_40373,_40343,_40411),
    {_40175\==plu},
    filanepr(_40115,_40455,_40411,_40489),
    nr1(_40513,_40489,_40543),
    busnumber(_40121,_40119,_40561,_40543,_40599),
    traceprint(4,bh10,_40629,_40599,_40251).

bus_head(_40111,1,_40115,_40117,_40119,_40121,[bus_head,_40349,_40417,{},_40499,_40557,_40635,_40683,_40731,_40799,_40857],_40291,_40295) --> 
    traceprint(5,bx11,_40349,_40291,_40387),
    art0(_40111,_40193,_40417,_40387,_40455),
    {_40193\==plu},
    filanepr(_40115,_40499,_40455,_40533),
    busnoun(_40117,_40213,_40215,_40557,_40533,_40599),
    nr0(_40635,_40599,_40665),
    colon0(_40683,_40665,_40713),
    busnumber(_40121,_40119,_40731,_40713,_40769),
    not_look_ahead(w(noun(minute,_40235,_40237,_40239)),_40799,_40769,_40833),
    traceprint(4,bh11,_40857,_40833,_40295).

bus_head(_40111,_40113,_40115,_40117,_40119,_40121,[bus_head,_40315,_40383,_40451,{},_40533,_40611,_40679],_40257,_40261) --> 
    traceprint(5,bx12,_40315,_40257,_40353),
    art0(_40111,_40175,_40383,_40353,_40421),
    quantnext(_40113,_40115,_40451,_40421,_40489),
    {_40113<10},
    busnoun(_40117,_40197,plu,_40533,_40489,_40575),
    busnumber(_40121,_40119,_40611,_40575,_40649),
    traceprint(4,bh12,_40679,_40649,_40261).

bus_head(_40111,_40113,_40115,_40117,nil,_40121,[bus_head,_40303,_40371,_40439,{},_40521,_40599],_40245,_40249) --> 
    traceprint(5,bx13,_40303,_40245,_40341),
    art0(_40111,plu,_40371,_40341,_40409),
    quantnext(_40113,_40115,_40439,_40409,_40477),
    {_40113<100},
    busnoun(_40117,_40191,_40193,_40521,_40477,_40563),
    traceprint(4,bh13,_40599,_40563,_40249).

bus_head(_40111,_40113,_40115,_40117,nil,_40121,[bus_head,_40303,_40371,_40439,{},_40521,_40599],_40245,_40249) --> 
    traceprint(5,bx14,_40303,_40245,_40341),
    art0(_40111,_40169,_40371,_40341,_40409),
    quantnext(_40113,_40115,_40439,_40409,_40477),
    {_40113=<5},
    busnoun(_40117,_40191,plu,_40521,_40477,_40563),
    traceprint(4,bh14,_40599,_40563,_40249).

bus_head(_40111,1,_40115,_40117,_40119,_40121,[bus_head,_40323,_40391,_40459,_40517,{},_40599,_40677],_40265,_40269) --> 
    traceprint(5,bx15,_40323,_40265,_40361),
    art0(_40111,_40175,_40391,_40361,_40429),
    filanepr(_40115,_40459,_40429,_40493),
    busnumber(_40121,_40119,_40517,_40493,_40555),
    {number(_40121),_40121>5},
    busnoun(_40117,_40211,_40213,_40599,_40555,_40641),
    traceprint(4,bh15,_40677,_40641,_40269).

bus_head(_40111,1,_40115,_40117,_40119,_40121,[bus_head,_40313,_40381,_40449,_40507,{},_40589,_40667],_40255,_40259) --> 
    traceprint(5,bx16,_40313,_40255,_40351),
    art0(_40111,_40175,_40381,_40351,_40419),
    filanepr(_40115,_40449,_40419,_40483),
    busnumber(_40121,_40119,_40507,_40483,_40545),
    {_40121\==1},
    busnoun(_40117,_40201,sin,_40589,_40545,_40631),
    traceprint(4,bh16,_40667,_40631,_40259).

bus_head(u,1,nil,bus,number,_40121,[bus_head,_40339,_40407,_40465,{},_40537,_40615],_40281,_40285) --> 
    traceprint(5,bx17,_40339,_40281,_40377),
    not_look_ahead(w(name(_40175,n,route)),_40407,_40377,_40441),
    w(nb(_40121,num),_40465,_40441,_40499),
    {number(_40121),_40121>5,_40121=<9999},
    busnoun(bus,def,sin,_40537,_40499,_40579),
    traceprint(4,bh17,_40615,_40579,_40285).

bus_head(def,_40113,_40115,route,nil,_40121,[bus_head,_40293,lit(de),_40383,{},_40465,_40513],_40235,_40239) --> 
    traceprint(5,bx18,_40293,_40235,_40331),
    cc(de,_40331,_40381),
    quantnext(_40113,_40115,_40383,_40381,_40421),
    {_40113=<5},
    not_look_ahead_np(_40465,_40421,_40495),
    traceprint(4,bh18,_40513,_40495,_40239).

bus_head(_40111,_40113,_40115,route,nil,_40121,[bus_head,_40329,_40397,_40465,{},{},_40561,_40609,!],_40271,_40275) --> 
    traceprint(5,bx19,_40329,_40271,_40367),
    art0(_40111,_40175,_40397,_40367,_40435),
    quantnext(_40113,_40115,_40465,_40435,_40503),
    {_40115\==nil},
    {_40113>0,_40113=<5},
    not_look_ahead_np(_40561,_40503,_40591),
    traceprint(4,bh19,_40609,_40591,_40275),
    !.

bus_head(_40111,1,_40115,_40117,_40119,_40121,[bus_head,_40333,_40401,_40469,_40527,_40605,_40653,_40701,_40769,_40827],_40275,_40279) --> 
    traceprint(5,bx20,_40333,_40275,_40371),
    art0(_40111,_40187,_40401,_40371,_40439),
    filanepr(_40115,_40469,_40439,_40503),
    busnoun(_40117,_40197,sin,_40527,_40503,_40569),
    nr0(_40605,_40569,_40635),
    colon0(_40653,_40635,_40683),
    busnumber(_40121,_40119,_40701,_40683,_40739),
    not_look_ahead(w(noun(minute,_40219,_40221,_40223)),_40769,_40739,_40803),
    traceprint(4,bh20,_40827,_40803,_40279).

art0(u,plu,[art0,lit(noen),_40221,!],_40165,_40169) --> 
    cc(noen,_40165,_40219),
    look_ahead_np(_40221,_40219,_40169),
    !.

art0(u,sin,[art0,lit(noe),!],_40159,_40163) --> 
    cc(noe,_40159,_40163),
    !.

art0(_40111,_40113,[art0,_40195,!],_40161,_40165) --> 
    art(_40111,_40113,_40195,_40161,_40165),
    !.

art0(u,nil,[art0,[]],_40149,_40149) --> 
    [].

art(u,sin,[art,lit(en),!],_40159,_40163) --> 
    cc(en,_40159,_40163),
    !.

art(u,sin,[art,lit(et),!],_40159,_40163) --> 
    cc(et,_40159,_40163),
    !.

art(u,sin,[art,lit(ei),!],_40159,_40163) --> 
    cc(ei,_40159,_40163),
    !.

art(def,sin,[art,lit(den),!],_40159,_40163) --> 
    cc(den,_40159,_40163),
    !.

art(def,plu,[art,lit(det),!],_40159,_40163) --> 
    cc(det,_40159,_40163),
    !.

art(def,plu,[art,lit(de),!],_40159,_40163) --> 
    cc(de,_40159,_40163),
    !.

quantnext(_40111,_40113,[quantnext,_40203,_40261,!],_40169,_40173) --> 
    quant(_40111,_40203,_40169,_40237),
    filanepr(_40113,_40261,_40237,_40173),
    !.

quantnext(_40111,_40113,[quantnext,_40203,_40261,!],_40169,_40173) --> 
    filanepr(_40113,_40203,_40169,_40237),
    quant(_40111,_40261,_40237,_40173),
    !.

quant00(1,[quant00,[]],_40143,_40143) --> 
    [].

quant(_40111,[quant,_40181],_40153,_40157) --> 
    w(nb(_40111,num),_40181,_40153,_40157).

filanepr(_40111,[filanepr,_40181,!],_40153,_40157) --> 
    flnp(_40111,_40181,_40153,_40157),
    !.

filanepr(nil,[filanepr,[]],_40143,_40143) --> 
    [].

busseno(_40111,_40113,_40115,[busseno,_40233,_40311,_40359,_40407,!],_40193,_40197) --> 
    busnoun(_40113,_40145,_40147,_40233,_40193,_40275),
    nr0(_40311,_40275,_40341),
    colon0(_40359,_40341,_40389),
    busnumber(_40111,_40115,_40407,_40389,_40197),
    !.

busseno(_40111,_40113,_40115,[busseno,_40227,_40275,_40343,!],_40187,_40191) --> 
    nr0(_40227,_40187,_40257),
    busnumber(_40111,_40115,_40275,_40257,_40313),
    busnoun(_40113,_40145,_40147,_40343,_40313,_40191),
    !.

busnumber(_40111,_40113,[busnumber,_40415,_40503,{},_40575,_40633,_40691,_40739,_40797,_40855,_40913,_40971,_41029],_40381,_40385) --> 
    optional(w(noun(route,sin,u,n)),_40415,_40381,_40479),
    w(name(_40111,n,_40113),_40503,_40479,_40537),
    {test(subclass0(_40113,vehicle))},
    not_look_ahead(w(noun(minute,_40253,_40255,_40257)),_40575,_40537,_40609),
    not_look_ahead([:],_40633,_40609,_40667),
    point0(_40691,_40667,_40721),
    not_look_ahead(w(name(_40277,_40279,month)),_40739,_40721,_40773),
    not_look_ahead(w(name(_40277,_40295,day)),_40797,_40773,_40831),
    not_look_ahead(w(name(whitsun_day,_40311,date)),_40855,_40831,_40889),
    not_look_ahead(w(name(christmas_day,_40327,date)),_40913,_40889,_40947),
    not_look_ahead(w(name(easterday,_40343,date)),_40971,_40947,_41005),
    not_look_ahead(w(name(new_years_day,_40193,date)),_41029,_41005,_40385).

busnumber(_40111,number,[busnumber,_40393,_40481,_40539,_40597,_40655,_40703,_40761,_40819,_40877,_40935,_40993],_40359,_40363) --> 
    optional(w(noun(route,sin,u,n)),_40393,_40359,_40457),
    w(nb(_40111,num),_40481,_40457,_40515),
    not_look_ahead(w(noun(minute,_40231,_40233,_40235)),_40539,_40515,_40573),
    not_look_ahead([:],_40597,_40573,_40631),
    point0(_40655,_40631,_40685),
    not_look_ahead(w(name(_40255,_40257,month)),_40703,_40685,_40737),
    not_look_ahead(w(name(_40255,_40273,day)),_40761,_40737,_40795),
    not_look_ahead(w(name(whitsun_day,_40289,date)),_40819,_40795,_40853),
    not_look_ahead(w(name(christmas_day,_40305,date)),_40877,_40853,_40911),
    not_look_ahead(w(name(easterday,_40321,date)),_40935,_40911,_40969),
    not_look_ahead(w(name(new_years_day,_40187,date)),_40993,_40969,_40363).

busse0(_40111,_40113,_40115,_40117,[busse0,_40221,!],_40175,_40179) --> 
    busnoun(_40113,_40115,_40117,_40221,_40175,_40179),
    !.

busse0(_40111,_40111,u,sin,[busse0,[]],_40161,_40161) --> 
    [].

busnoun(_40111,_40113,_40115,[busnoun,_40253,!,{},_40335],_40213,_40217) --> 
    w(noun(_40111,_40115,_40113,n),_40253,_40213,_40287),
    !,
    {test(subclass0(_40111,vehicle));_40111=number},
    point0(_40335,_40287,_40217).

aname_phrase(0,_40113,_40119::_40119 and _40127,[aname_phrase,_40283,_40331,_40389,_40447,{},!],_40243,_40247) --> 
    a0(_40283,_40243,_40313),
    look_ahead(w(name(_40169,n,_40173)),_40331,_40313,_40365),
    preadjs(_40177,_40389,_40365,_40423),
    noun2(_40181,_40183,n,_40113,_40189,_40447,_40423,_40247),
    {preadjs_template(_40177,_40113,_40189,_40127)},
    !.

aname_phrase(_40111,_40113,_40119::_40119 and _40127,[aname_phrase,_40289,_40347,lit(gang),!,_40437,_40485],_40249,_40253) --> 
    w(name(_40171,n,route),_40289,_40249,_40323),
    w(adj2(next,nil),_40347,_40323,_40381),
    cc(gang,_40381,_40425),
    !,
    accept(_40437,_40425,_40467),
    pushstack(first,w(name(_40171,n,route)),nil,_40467,_40505),
    namep(_40111,_40113,_40127,_40485,_40505,_40253).

aname_phrase(_40111,_40113,_40115,[aname_phrase,_40235,_40293,_40351,!,_40409],_40195,_40199) --> 
    number(_40143,_40235,_40195,_40269),
    not_look_ahead(w(prep(from)),_40293,_40269,_40327),
    filanepr(_40351,_40327,_40381),
    !,
    reject(_40409,_40381,_40199).

aname_phrase(_40111,_40113,_40115,[aname_phrase,_40263,_40311,_40359,_40417,{},!,_40499],_40223,_40227) --> 
    dent0(_40263,_40223,_40293),
    filanepr(_40311,_40293,_40341),
    bus_number(_40155,_40359,_40341,_40393),
    w(noun(_40163,plu,_40167,_40169),_40417,_40393,_40451),
    {testmember(_40163,[bus])},
    !,
    reject(_40499,_40451,_40227).

aname_phrase(_40111,_40113,_40115,[aname_phrase,_40275,_40323,_40381,_40449,{},!,_40531],_40235,_40239) --> 
    dent0(_40275,_40235,_40305),
    w(adj2(_40159,nil),_40323,_40305,_40357),
    gmem(_40159,[nearest],_40381,_40357,_40419),
    w(name(_40179,_40181,_40183),_40449,_40419,_40483),
    {\+number(_40179)},
    !,
    reject(_40531,_40483,_40239).

aname_phrase(_40111,_40113,_40119::_40121,[aname_phrase,_40279,_40327,_40385,_40443,_40501,{}],_40239,_40243) --> 
    a0(_40279,_40239,_40309),
    preadjs0(_40159,_40327,_40309,_40361),
    not_look_ahead([jeg],_40385,_40361,_40419),
    not_look_ahead([du],_40443,_40419,_40477),
    name_phrase(_40111,_40113,_40119::_40163,_40501,_40477,_40243),
    {preadjs_template(_40159,_40113,_40163,_40121)}.

aname_phrase(_40111,_40113,_40119::_40121,[aname_phrase,_40235,_40293,_40341],_40195,_40199) --> 
    not_look_ahead([ett],_40235,_40195,_40269),
    a0(_40293,_40269,_40323),
    name_phrase(_40111,_40113,_40119::_40121,_40341,_40323,_40199).

aname_phrase(name,_40113,_40115,[aname_phrase,_40203],_40163,_40167) --> 
    person_name(_40113,_40115,_40123,_40203,_40163,_40167).

name_phrase(0,_40113,_40119::_40121,[name_phrase,_40391,_40449,_40507,_40565,_40613,_40671,!,{},{},_40767],_40351,_40355) --> 
    w(noun(time,sin,def,n),_40391,_40351,_40425),
    w(nb(_40219,num),_40449,_40425,_40483),
    w(nb(_40229,num),_40507,_40483,_40541),
    to0(_40565,_40541,_40595),
    w(nb(_40239,num),_40613,_40595,_40647),
    w(nb(_40249,num),_40671,_40647,_40705),
    !,
    {_40259 is _40219*100+_40229},
    {_40197 is _40239*100+_40249},
    lock(exact,_40705,_41023),
    pushstack(exact,(time1(_40259),and1,time1(_40197)),nil,_41023,_41035),
    noun_phrases(_40113,_40119::_40121,_40767,_41035,_41013),
    unlock(_41013,_40355).

name_phrase(0,_40113,_40119::_40121,[name_phrase,_40291,_40349,_40407,_40455,!,_40523],_40251,_40255) --> 
    w(noun(time,sin,def,n),_40291,_40251,_40325),
    timexp(_40191,_40349,_40325,_40383),
    to0(_40407,_40383,_40437),
    timexp(_40173,_40455,_40437,_40489),
    !,
    pushstack(first,(time1(_40191),and1,time1(_40173)),nil,_40489,_40773),
    noun_phrases(_40113,_40119::_40121,_40523,_40773,_40255).

name_phrase(_40111,_40113,_40119::_40125 and _40119,[name_phrase,_40259,_40317,_40395],_40219,_40223) --> 
    look_ahead(w(nb(_40169,_40171)),_40259,_40219,_40293),
    namep(_40111,_40113,_40125,_40317,_40293,_40359),
    not_look_ahead(w(noun(minute,_40153,_40155,_40157)),_40395,_40359,_40223).

name_phrase(_40111,_40113,_40119::_40125 and _40119,[name_phrase,_40259,_40317,_40395],_40219,_40223) --> 
    look_ahead(w(nb(_40169,_40171)),_40259,_40219,_40293),
    namep(_40111,_40113,_40125,_40317,_40293,_40359),
    not_look_ahead(w(noun(minute,_40153,_40155,_40157)),_40395,_40359,_40223).

name_phrase(_40111,_40113,_40119::_40125 and _40119,[name_phrase,_40215],_40175,_40179) --> 
    namep(_40111,_40113,_40125,_40215,_40175,_40179).

person_name((_40125,_40131,_40133):person,_40137 and _40143 and _40145,_40115,[person_name,_40273,_40351,_40429,!,_40517],_40233,_40237) --> 
    properfirstname(_40125,_40137,_40177,_40273,_40233,_40315),
    properfirstname(_40131,_40143,_40185,_40351,_40315,_40393),
    properlastname(_40133,_40145,_40115,_40429,_40393,_40471),
    !,
    accept(_40517,_40471,_40237).

person_name((_40125,_40127):person,_40131 and _40133,_40115,[person_name,_40247,_40325,!,_40413],_40207,_40211) --> 
    properfirstname(_40125,_40131,_40159,_40247,_40207,_40289),
    properlastname(_40127,_40133,_40115,_40325,_40289,_40367),
    !,
    accept(_40413,_40367,_40211).

properfirstname(_40111,_40113,_40115,[properfirstname,_40209],_40169,_40173) --> 
    name1g(_40111:firstname,_40113,_40115,_40209,_40169,_40173).

properlastname(_40111,_40113,_40115,[properlastname,_40209],_40169,_40173) --> 
    name1g(_40111:lastname,_40113,_40115,_40209,_40169,_40173).

np_head(_40111,_40113,_40115,[np_head,lit(ett),_40253,!,_40321],_40191,_40195) --> 
    cc(ett,_40191,_40251),
    w(noun(time,_40147,def,_40151),_40253,_40251,_40287),
    !,
    reject(_40321,_40287,_40195).

np_head(0,_40113,_40119::_40121,[np_head,_40307,_40355,_40413,!,_40501,_40559,{},{}],_40267,_40271) --> 
    the0(_40307,_40267,_40337),
    preadjs0(_40181,_40355,_40337,_40389),
    quantifier(_40113,_40177,_40177 and _40119::_40121,_40413,_40389,_40455),
    !,
    preadjs0(_40171,_40501,_40455,_40535),
    noun_complex(_40209,_40113,_40213,_40559,_40535,_40271),
    {preadjs_template(_40181,_40113,_40213,_40175)},
    {preadjs_template(_40171,_40113,_40175,_40177)}.

np_head(_40111,_40113,_40115,[np_head,_40315,_40413,{},_40485,_40543,{}],_40275,_40279) --> 
    determiner0(_40163,_40111,_40113,_40159,_40115,_40315,_40275,_40365),
    preadjs0(_40153,_40413,_40365,_40447),
    {_40153=true->_40189=_40163;_40189=_40191},
    not_look_ahead(w(noun(crown,_40223,_40225,_40227)),_40485,_40447,_40519),
    noun_complex(_40189,_40113,_40157,_40543,_40519,_40279),
    {preadjs_template(_40153,_40113,_40157,_40159)}.

np_head(0,_40113,_40119::findpron(_40149)::exists(_40113)::_40137 and _40143 and _40119,[np_head,_40315,_40363,_40471,!,_40539,{}],_40275,_40279) --> 
    thispron(_40315,_40275,_40345),
    noun(_40199,_40201,_40203,gen,_40149,_40143,_40363,_40345,_40417),
    look_ahead(w(nb(_40221,num)),_40471,_40417,_40505),
    !,
    np0_accept(_40113,_40195::_40137,_40539,_40505,_40279),
    {has_template(_40149,_40113,_40195)}.

np_head(0,_40113,_40119::findpron(_40161)::exists(_40113)::_40137 and _40143 and _40149 and _40155 and _40119,[np_head,_40339,_40387,!,_40505,_40563,_40641,{},{}],_40299,_40303) --> 
    thispron(_40339,_40299,_40369),
    noun(_40223,_40225,_40227,gen,_40161,_40149,_40387,_40369,_40441),
    !,
    preadjs0(_40237,_40505,_40441,_40539),
    noun_compound(_40113,_40143,_40245,_40563,_40539,_40605),
    not_look_aheadnounx(_40641,_40605,_40303),
    {preadjs_template(_40237,_40113,_40143,_40137)},
    {has_template(_40161,_40113,_40155)}.

not_look_aheadnounx([not_look_aheadnounx,_40179,!],_40157,_40161) --> 
    look_ahead(w(verb(_40125,_40127,fin)),_40179,_40157,_40161),
    !.

not_look_aheadnounx([not_look_aheadnounx,_40181,!],_40159,_40163) --> 
    look_ahead(w(noun(clock,_40127,_40129,_40131)),_40181,_40159,_40163),
    !.

not_look_aheadnounx([not_look_aheadnounx,_40175],_40153,_40157) --> 
    not_look_ahead(w(noun(_40119,_40121,_40123,_40125)),_40175,_40153,_40157).

noun_complex(_40111,_40119:_40121,_40119 isa _40121,[noun_complex,_40305,_40363,_40421,_40479,{},!],_40265,_40269) --> 
    not_look_ahead(w(nb(_40169,_40171)),_40305,_40265,_40339),
    w(name(_40119,n,_40183),_40363,_40339,_40397),
    not_look_ahead(w(verb(_40195,pres,fin)),_40421,_40397,_40455),
    w(noun(_40207,_40111,_40211,n),_40479,_40455,_40269),
    {joinclass(_40207,_40183,_40121)},
    !.

noun_complex(sin,_40119:_40121,_40119 isa _40121,[noun_complex,_40241,_40299,!],_40201,_40205) --> 
    w(noun(_40121,sin,_40151,n),_40241,_40201,_40275),
    w(quote(_40119),_40299,_40275,_40205),
    !.

noun_complex(sin,_40119:_40127,_40119 isa _40121,[noun_complex,_40341,_40399,_40457,_40515,_40573,_40621,{},!],_40301,_40305) --> 
    w(noun(_40121,sin,_40181,n),_40341,_40301,_40375),
    not_look_ahead([du],_40399,_40375,_40433),
    w(name(_40119,n,_40203),_40457,_40433,_40491),
    not_look_ahead(w(noun(minute,_40217,_40219,_40221)),_40515,_40491,_40549),
    point0(_40573,_40549,_40603),
    not_look_ahead(w(name(_40233,_40235,date)),_40621,_40603,_40305),
    {joinclass(_40121,_40203,_40127),_40127\==nil},
    !.

noun_complex(sin,_40119:_40121,_40119 isa _40121,[noun_complex,_40305,_40363,{},_40435,_40483,!],_40265,_40269) --> 
    w(noun(_40121,_40167,_40169,n),_40305,_40265,_40339),
    w(nb(_40119,num),_40363,_40339,_40397),
    {testmember(_40121,[footnote,page,sms,telephone,week,year])},
    and1(_40435,_40397,_40465),
    w(nb(_40223,_40225),_40483,_40465,_40269),
    !.

noun_complex(_40111,_40119:_40121,_40119 isa _40121,[noun_complex,_40287,_40345,{},!],_40247,_40251) --> 
    w(noun(_40121,_40111,_40157,n),_40287,_40247,_40321),
    w(nb(_40119,num),_40345,_40321,_40251),
    {testmember(_40121,[footnote,page,sms,telephone,week,year,number])},
    !.

noun_complex(_40111,_40119:_40121,_40119 isa _40121,[noun_complex,_40377,{},_40449,_40517,_40575,_40643,_40701,_40759,_40817,!,_40885],_40337,_40341) --> 
    w(noun(_40121,_40111,_40199,n),_40377,_40337,_40411),
    {subtype0(_40121,vehicle)},
    plausibleno(_40121,_40119,_40449,_40411,_40487),
    not_look_ahead([ganger],_40517,_40487,_40551),
    plausibleno(_40121,_40119,_40575,_40551,_40613),
    not_look_ahead_lit([sin,sitt,sine],_40643,_40613,_40677),
    not_look_ahead(w(name(_40259,_40261,month)),_40701,_40677,_40735),
    not_look_ahead(w(name(_40259,_40277,date)),_40759,_40735,_40793),
    not_look_ahead(w(noun(_40291,plu,_40295,_40297)),_40817,_40793,_40851),
    !,
    accept(_40885,_40851,_40341).

noun_complex(plu,_40119:_40121,_40119 isa _40121,[noun_complex,_40249,_40317,{}],_40209,_40213) --> 
    plausibleno(_40121,_40119,_40249,_40209,_40287),
    w(noun(_40121,sin,u,n),_40317,_40287,_40213),
    {subtype0(_40121,vehicle)}.

noun_complex(_40111,_40113,_40115,[noun_complex,_40245,_40323,_40381],_40205,_40209) --> 
    noun_list(_40111,_40113,_40115,_40245,_40205,_40287),
    not_look_ahead_lit([sin,sitt,sine],_40323,_40287,_40357),
    not_look_ahead(w(nb(_40139,_40141)),_40381,_40357,_40209).

noun_complex(_40111,_40113,_40115,[noun_complex,_40231,_40289,_40347],_40191,_40195) --> 
    not_look_ahead([noe],_40231,_40191,_40265),
    not_look_ahead([min],_40289,_40265,_40323),
    noun_compound(_40113,_40115,_40111,_40347,_40323,_40195).

plausibleno(_40111,_40113,[plausibleno,_40211,_40269,_40317,!,_40375],_40177,_40181) --> 
    num(_40141,_40211,_40177,_40245),
    point(_40269,_40245,_40299),
    monthnamex(_40317,_40299,_40347),
    !,
    reject(_40375,_40347,_40181).

plausibleno(_40111,_40113,[plausibleno,_40205,_40263,!,_40321],_40171,_40175) --> 
    num(_40135,_40205,_40171,_40239),
    colon(_40263,_40239,_40293),
    !,
    reject(_40321,_40293,_40175).

plausibleno(_40111,_40113,[plausibleno,_40209,_40267,!,_40335],_40175,_40179) --> 
    num(_40135,_40209,_40175,_40243),
    monthname(_40139,_40267,_40243,_40301),
    !,
    reject(_40335,_40301,_40179).

plausibleno(_40111,_40113,[plausibleno,_40221,_40269,{}],_40187,_40191) --> 
    nr0(_40221,_40187,_40251),
    num(_40113,_40269,_40251,_40191),
    {_40113>0,_40113<1000}.

plausibleno(_40111,_40113,[plausibleno,_40215,_40263,{}],_40181,_40185) --> 
    nr0(_40215,_40181,_40245),
    w(nb(_40113,alf),_40263,_40245,_40185),
    {_40113<1000}.

npa(_40135:_40137,_40117::findexternal(_40135:_40137)::_40135 isa _40137 and _40117,[npa,_40275,_40333,!,{}],_40241,_40245) --> 
    one_of_lit([det,dette],_40275,_40241,_40309),
    look_ahead(w(adv(_40205)),_40333,_40309,_40245),
    !,
    {_40137=thing}.

npa(_40135:_40137,_40117::findexternal(_40135:_40137)::_40135 isa _40137 and _40117,[npa,lit(dette),_40271,{}],_40215,_40219) --> 
    cc(dette,_40215,_40269),
    not_look_ahead_np(_40271,_40269,_40219),
    {_40137=thing}.

npa(_40135:_40137,_40117::findexternal(_40135:thing)::_40135 isa _40137 and _40117,[npa,lit(det),_40277,_40335],_40221,_40225) --> 
    cc(det,_40221,_40275),
    look_ahead(w(verb(_40181,_40183,fin)),_40277,_40275,_40311),
    not_look_ahead_np(_40335,_40311,_40225).

npa(_40111,_40117::findit(_40129)::_40125,[npa,_40257,_40305,_40383,{}],_40223,_40227) --> 
    its(_40257,_40223,_40287),
    determiner00(_40111,_40177 and _40159,_40117::_40125,_40305,_40287,_40347),
    noun_compound(_40111,_40177,_40187,_40383,_40347,_40227),
    {has_template(_40129,_40111,_40159)}.

npa(_40111,_40113,[npa,_40201,_40249,!,_40307],_40167,_40171) --> 
    this(_40201,_40167,_40231),
    look_ahead_np(_40249,_40231,_40279),
    !,
    reject(_40307,_40279,_40171).

npa(_40111,_40117::find(_40111)::_40129 and _40117,[npa,_40219],_40185,_40189) --> 
    noun(_40139,_40141,def,n,_40111,_40129,_40219,_40185,_40189).

npa(_40135:_40137,_40117::findexternal(_40135:_40137)::_40135 isa _40153 and _40117,[npa,lit(denne),_40319,_40377,{},{}],_40263,_40267) --> 
    cc(denne,_40263,_40317),
    not_look_ahead(w(adj),_40319,_40317,_40353),
    not_look_ahead(w(noun(_40211,_40213,_40215,_40217)),_40377,_40353,_40267),
    {_40153=thing},
    {type(_40153,_40137)}.

npa(_40135:_40137,_40117::findpron(_40135:_40137)::_40135 isa thing and _40117,[npa,lit(det),_40271,{}],_40215,_40219) --> 
    cc(det,_40215,_40269),
    endofline(_40271,_40269,_40219),
    {type(thing,_40137)}.

npa(_40111,_40117::_40119,[npa,_40275,_40323,_40381,_40439],_40241,_40245) --> 
    allsome0(_40275,_40241,_40305),
    posspron(_40169,_40323,_40305,_40357),
    w(nb(_40163,num),_40381,_40357,_40415),
    pushstack(first,(thispron,w(noun(_40169,sin,u,gen)),w(nb(_40163,num))),nil,_40415,_40531),
    np1(_40111,_40117::_40119,_40439,_40531,_40245).

npa(_40111,_40117::_40119,[npa,_40243,_40291,_40349],_40209,_40213) --> 
    allsome0(_40243,_40209,_40273),
    posspron(_40151,_40291,_40273,_40325),
    pushstack(first,(thispron,w(noun(_40151,sin,u,gen))),nil,_40325,_40443),
    np1(_40111,_40117::_40119,_40349,_40443,_40213).

npa(_40111,_40113,[npa,lit(de),_40351,_40409,_40467,_40525,!,_40593],_40295,_40299) --> 
    cc(de,_40295,_40349),
    w(nb(_40193,num),_40351,_40349,_40385),
    flnp(_40199,_40409,_40385,_40443),
    not_look_ahead(w(name(_40211,_40213,_40215)),_40467,_40443,_40501),
    not_look_ahead(w(noun(_40227,_40229,_40231,_40233)),_40525,_40501,_40559),
    !,
    pushstack(first,(w(nb(_40193,num)),w(adj2(_40199,nil)),w(noun(vehicle,sin,u,n))),nil,_40559,_40613),
    np1(_40111,_40113,_40593,_40613,_40299).

npa(_40111,_40117::_40119,[npa,_40361,_40409,_40467,_40525,_40583,_40641,_40689,_40747,!,_40815],_40327,_40331) --> 
    dent0(_40361,_40327,_40391),
    not_look_ahead([først],_40409,_40391,_40443),
    not_look_ahead([sist],_40467,_40443,_40501),
    not_look_ahead([senest],_40525,_40501,_40559),
    not_look_ahead([tidligst],_40583,_40559,_40617),
    nest(_40641,_40617,_40671),
    flnp(_40241,_40689,_40671,_40723),
    not_look_ahead(w(noun(_40253,_40255,_40257,_40259)),_40747,_40723,_40781),
    !,
    pushstack(first,(w(adj2(second,nil)),w(adj2(_40241,nil)),w(noun(vehicle,sin,u,n))),nil,_40781,_40835),
    np1(_40111,_40117::_40119,_40815,_40835,_40331).

npa(_40111,_40117::_40119,[npa,_40369,_40417,_40475,_40533,_40591,!,_40659,_40819],_40335,_40339) --> 
    dent0(_40369,_40335,_40399),
    not_look_ahead([f,s,først,sist,senest,tidligst],_40417,_40399,_40451),
    flnp(_40211,_40475,_40451,_40509),
    not_look_ahead(w(name(_40223,_40225,_40227)),_40533,_40509,_40567),
    not_look_ahead(w(noun(_40239,_40241,_40243,_40245)),_40591,_40567,_40625),
    !,
    pushstack(first,(a,w(adj2(_40211,nil)),w(noun(vehicle,sin,u,n))),nil,_40625,_40759),np1(_40111,_40117::_40119,_40659,_40759,_40789),
    optional(w(noun(bus,sin,_40177,_40179)),_40819,_40789,_40339).

npa(_40111,_40113,[npa,{},lit(den),_40313,_40371,!,_40439],_40237,_40241) --> 
    {user:value(busflag,true)},
    cc(den,_40237,_40311),
    not_look_ahead(w(adj2(_40181,nil)),_40313,_40311,_40347),
    not_look_ahead(w(noun(_40195,_40197,_40199,_40201)),_40371,_40347,_40405),
    !,
    npit(_40111,_40113,_40439,_40405,_40241).

npa(_40111,_40117::_40119,[npa,lit(den),_40309,_40367,!,_40435],_40253,_40257) --> 
    cc(den,_40253,_40307),
    not_look_ahead(w(adj2(_40185,nil)),_40309,_40307,_40343),
    not_look_ahead(w(noun(_40199,_40201,_40203,_40205)),_40367,_40343,_40401),
    !,
    lock(exact,_40401,_40543),
    pushstack(exact,(this,w(noun(thing,sin,u,n))),nil,_40543,_40555),
    np1(_40111,_40117::_40119,_40435,_40555,_40533),
    unlock(_40533,_40257).

npit(_40129:_40131,_40117::_40129 isa _40131 and _40117,[npit,{}],_40187,_40187) --> 
    {it_template(_40129:_40131)}.

adjnoun([adjnoun,_40167],_40145,_40149) --> 
    w(adj2(nil,nil),_40167,_40145,_40149).

adjnoun([adjnoun,_40171],_40149,_40153) --> 
    w(noun(_40115,plu,u,_40121),_40171,_40149,_40153).

np2(_40111,_40113,[np2,lit(noe),_40287,_40345,!,_40403],_40231,_40235) --> 
    cc(noe,_40231,_40285),
    w(adj2(_40175,_40177),_40287,_40285,_40321),
    not_look_ahead_np(_40345,_40321,_40375),
    !,
    lock(exact,_40375,_40437),
    pushstack(exact,(w(adj2(_40175,_40177)),w(noun(thing,sin,u,n))),nil,_40437,_40449),
    np_kernel(0,_40111,_40113,_40403,_40449,_40427),
    unlock(_40427,_40235).

np2(_40111,_40113,[np2,lit(noe),_40283,!,_40351,_40473],_40227,_40231) --> 
    cc(noe,_40227,_40281),
    look_ahead(w(prep(_40163)),_40283,_40281,_40317),
    !,
    lock(exact,_40317,_40391),pushstack(exact,w(noun(thing,sin,u,n)),nil,_40391,_40403),np_kernel(0,_40111,_40145,_40351,_40403,_40381),unlock(_40381,_40383),
    noun_modifiers0(0,_40111,_40145,_40113,_40473,_40383,_40231).

np2(_40111,_40113,[np2,_40327,_40395,{},!,_40477,!],_40293,_40297) --> 
    clock_kernel(_40153:clock,_40153 isa clock,_40327,_40293,_40365),
    w(noun(_40169,sin,_40173,n),_40395,_40365,_40429),
    {testmember(_40169,[departure,arrival])},
    !,
    lock(exact,_40429,_40589),pushstack(exact,(w(noun(_40169,sin,def,n)),w(prep(at)),clock_kernel(_40153:clock,_40153 isa clock)),nil,_40589,_40601),np1(_40111,_40113,_40477,_40601,_40579),unlock(_40579,_40297),
    !.

np2(_40111,_40113,[np2,_40301,_40349,lit(enn),!,_40439,!,_40517,!],_40267,_40271) --> 
    anders(_40301,_40267,_40331),
    w(noun(_40163,_40165,_40167,n),_40349,_40331,_40383),
    cc(enn,_40383,_40427),
    !,
    np1(_40177,_40179,_40439,_40427,_40477),
    !,
    lock(exact,_40477,_40637),pushstack(exact,(w(noun(_40163,_40165,_40167,n)),w(prep(except)),xnp(_40177,_40179)),nil,_40637,_40649),np1(_40111,_40113,_40517,_40649,_40627),unlock(_40627,_40271),
    !.

anders([anders,lit(andre),!],_40145,_40149) --> 
    cc(andre,_40145,_40149),
    !.

anders([anders,lit(en),lit(annen),!],_40155,_40159) --> 
    cc(en,_40155,_40197),
    cc(annen,_40197,_40159),
    !.

np2(_40111,_40113,[np2,lit(samme),_40327,lit(som),!,_40417,!,_40495,!],_40271,_40275) --> 
    cc(samme,_40271,_40325),
    w(noun(_40167,sin,u,n),_40327,_40325,_40361),
    cc(som,_40361,_40405),
    !,
    np1(_40181,_40183,_40417,_40405,_40455),
    !,
    lock(exact,_40455,_40615),pushstack(exact,(w(noun(_40167,sin,def,n)),w(prep(as)),xnp(_40181,_40183)),nil,_40615,_40627),np1(_40111,_40113,_40495,_40627,_40605),unlock(_40605,_40275),
    !.

np2(_40129:_40131,_40117::_40123 and _40117,[np2,_40339,_40397,_40465,{},{}],_40305,_40309) --> 
    w(name(_40197,n,_40201),_40339,_40305,_40373),
    gmem(_40201,[company],_40397,_40373,_40435),
    w(noun(_40131,_40221,_40223,n),_40465,_40435,_40309),
    {subclass0(_40131,vehicle)},
    {_40123=(exists(_40129)::_40129 isa _40131 and _40197 isa _40201 and adj/nil/_40197/_40129/real)}.

np2(_40111,_40113,[np2,_40399,{},{},_40485,_40543,_40601,{},!,_40683,_40731,!],_40365,_40369) --> 
    w(name(_40181,n,_40185),_40399,_40365,_40433),
    {testmember(_40185,[neighbourhood,station,street])},
    {\+testmember(_40181,[sentrum])},
    w(noun(_40233,_40235,_40237,n),_40485,_40433,_40519),
    not_look_ahead([nr],_40543,_40519,_40577),
    not_look_ahead(w(nb(_40259,_40261)),_40601,_40577,_40635),
    {subclass0(_40233,vehicle)},
    !,
    accept(_40683,_40635,_40713),
    lock(exact,_40713,_40771),pushstack(exact,(w(noun(_40233,sin,def,n)),w(prep(to)),w(name(_40181,n,_40185))),nil,_40771,_40783),np1(_40111,_40113,_40731,_40783,_40761),unlock(_40761,_40369),
    !.

np2(_40111,_40113,[np2,_40307,{},_40379,_40437,!,_40505,_40553,!],_40273,_40277) --> 
    w(nb(_40163,num),_40307,_40273,_40341),
    {this_year(_40163)},
    not_look_ahead([-],_40379,_40341,_40413),
    not_look_ahead(w(nb(_40193,_40195)),_40437,_40413,_40471),
    !,
    accept(_40505,_40471,_40535),
    lock(exact,_40535,_40593),pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_40163,num))),nil,_40593,_40605),np1(_40111,_40113,_40553,_40605,_40583),unlock(_40583,_40277),
    !.

np2(_40111,_40113,[np2,_40267,_40315,lit(enn),!,_40405],_40233,_40237) --> 
    oter(_40267,_40233,_40297),
    w(noun(_40167,_40169,u,n),_40315,_40297,_40349),
    cc(enn,_40349,_40393),
    !,
    pushstack(first,(a,w(noun(_40167,sin,u,n)),[ulik]),nil,_40393,_40499),
    np1(_40111,_40113,_40405,_40499,_40237).

np2(_40111,_40117::_40119,[np2,_40275,_40333,_40391,_40459],_40241,_40245) --> 
    not_look_ahead([alle],_40275,_40241,_40309),
    not_look_ahead(w(name(_40183,_40185,_40187)),_40333,_40309,_40367),
    quant_pron(every,_40157,_40391,_40367,_40429),
    pushstack(first,(every,w(noun(_40157,sin,u,n))),nil,_40429,_40553),
    np1(_40111,_40117::_40119,_40459,_40553,_40245).

np2(_40111,_40113,[np2,_40247,_40315,_40373,_40421],_40213,_40217) --> 
    quant_pron(every,_40151,_40247,_40213,_40285),
    not_look_ahead([som],_40315,_40285,_40349),
    not_look_ahead_np(_40373,_40349,_40403),
    pushstack(first,(every,w(noun(_40151,sin,u,n))),nil,_40403,_40515),
    np0_accept(_40111,_40113,_40421,_40515,_40217).

np2(_40111,_40113,[np2,_40229,_40297,_40345,_40403,_40451],_40195,_40199) --> 
    quant_pron(some,_40141,_40229,_40195,_40267),
    rfxpron0(_40297,_40267,_40327),
    not_look_ahead([som],_40345,_40327,_40379),
    not_look_ahead_np(_40403,_40379,_40433),
    np00(_40141,_40111,_40113,_40451,_40433,_40199).

clock_number(_40115:_40117,[clock_number,_40207,{},!],_40179,_40183) --> 
    number(_40115:_40117,_40207,_40179,_40183),
    {clock_test(_40115)},
    !.

bus_number(_40115:_40117,[bus_number,_40201,{}],_40173,_40177) --> 
    number(_40115:_40117,_40201,_40173,_40177),
    {plausible_busno(_40115)}.

road_number(_40115:_40117,[road_number,_40203,{}],_40175,_40179) --> 
    number(_40115:_40117,_40203,_40175,_40179),
    {_40115=<200}.

noun_list2(_40111,_40113,_40115,[noun_list2,_40225,_40333],_40185,_40189) --> 
    noun(_40135,_40111,u,n,_40125,_40127,_40225,_40185,_40279),
    nlists10(_40125,_40127,_40113,_40115,_40333,_40279,_40189).

nlists10(_40127:_40129,_40113,(_40127,_40147):(_40129,_40141),_40113 and _40123,[nlists10,_40279,_40327,_40435],_40233,_40237) --> 
    comma(_40279,_40233,_40309),
    noun(_40173,_40175,_40177,n,_40163,_40165,_40327,_40309,_40381),
    nlists10(_40163,_40165,_40147:_40141,_40123,_40435,_40381,_40237).

nlists10(_40127:_40129,_40113,(_40127,_40147):(_40129,_40141),_40113 and _40123,[nlists10,_40267,_40325],_40221,_40225) --> 
    andor(_40171,_40267,_40221,_40301),
    noun(_40157,_40159,_40161,n,_40147:_40141,_40123,_40325,_40301,_40225).

noun_list(_40111,_40113,_40115,[noun_list,_40311,_40369,_40427,_40485,_40543,{},_40665],_40271,_40275) --> 
    not_look_ahead([noe],_40311,_40271,_40345),
    not_look_ahead([noen],_40369,_40345,_40403),
    not_look_ahead([min],_40427,_40403,_40461),
    not_look_ahead(w(adj2(_40197,nil)),_40485,_40461,_40519),
    noun(_40203,_40111,_40207,n,_40155,_40157,_40543,_40519,_40597),
    {\+testmember(_40203,[clock])},
    nlists0join(_40155,_40157,_40113,_40115,_40665,_40597,_40275).

nlists0join(_40111,_40113,_40121:_40123,_40117,[nlists0join,_40273,{},!,_40385,{}],_40227,_40231) --> 
    nlists0(_40111,_40113,_40121:_40173,_40117,_40273,_40227,_40319),
    {joinclasses(_40173,_40123)},
    !,
    accept(_40385,_40319,_40231),
    {_40123\==thing}.

nlists0(_40127:_40129,_40113,(_40127,_40147):(_40129,_40141),_40113 and _40123,[nlists0,lit(og),_40391,_40449,_40557,{},{},_40643],_40323,_40327) --> 
    cc(og,_40323,_40389),
    not_look_ahead_lit([da,så,min],_40391,_40389,_40425),
    noun(_40217,_40219,_40221,n,_40187,_40189,_40449,_40425,_40503),
    not_look_ahead(w(prep(_40239)),_40557,_40503,_40591),
    {joinclass(_40129,_40217,_40251)},
    {_40251\==thing,_40251\==nil},
    nlists0(_40187,_40189,_40147:_40141,_40123,_40643,_40591,_40327).

nlists0(_40111,_40113,_40111,_40113,[nlists0,[],_40241],_40185,_40189) --> 
    [],
    not_look_ahead(w(noun(_40135,_40137,_40139,_40141)),_40241,_40185,_40189).

postcode(_40111,[postcode,_40269,{},_40341,{}],_40241,_40245) --> 
    w(nb(_40111,num),_40269,_40241,_40303),
    {number(_40111),_40111>=1000,_40111=<9999},
    look_ahead(w(name(_40205,n,_40137)),_40341,_40303,_40245),
    {testmember(_40137,[city,neighbourhood,station])}.

noun_compound(_40111,_40113,sin,[noun_compound,_40243,_40301,_40379,_40427],_40203,_40207) --> 
    not_look_ahead([man],_40243,_40203,_40277),
    namep(_40159,_40141,_40143,_40301,_40277,_40343),
    sin(_40379,_40343,_40409),
    ncomps0(gen,_40111,_40141,_40143,_40113,_40147,_40427,_40409,_40207).

noun_compound(_40111,_40119 and _40121,_40115,[noun_compound,_40265,_40323,_40381,{}],_40225,_40229) --> 
    not_look_ahead([dere],_40265,_40225,_40299),
    w(name(_40147,_40169,_40171),_40323,_40299,_40357),
    noun(_40175,_40115,u,n,_40111,_40119,_40381,_40357,_40229),
    {adjnamecomp_template(_40147,_40111,_40121)}.

noun_compound(_40111,_40113,_40115,[noun_compound,_40273,_40331,{},_40443,_40531],_40233,_40237) --> 
    not_look_ahead([man],_40273,_40233,_40307),
    noun2(_40165,_40167,_40169,_40147,_40149,_40331,_40307,_40381),
    {_40115=_40165},
    s0(_40165,_40167,_40169,_40143,_40443,_40381,_40489),
    ncomps0(_40143,_40111,_40147,_40149,_40113,_40153,_40531,_40489,_40237).

morenames(_40111,(_40111,_40119),[morenames,_40205,_40263],_40171,_40175) --> 
    unplausible_name(_40129,_40205,_40171,_40239),
    morenames(_40129,_40119,_40263,_40239,_40175).

morenames(_40111,_40111,[morenames,[]],_40149,_40149) --> 
    [].

unplausible_name(_40111,[unplausible_name,_40195,!,_40263],_40167,_40171) --> 
    w(name(_40111,unknown,_40135),_40195,_40167,_40229),
    !,
    accept(_40263,_40229,_40171).

ncomps0(gen,_40113,_40115,_40117,_40119,0,[ncomps0,_40271,_40329,{}],_40213,_40217) --> 
    preadjs0(_40141,_40271,_40213,_40305),
    ncomps(_40113,_40115,_40147,_40119,_40329,_40305,_40217),
    {preadjs_template(_40141,_40113,_40117,_40147)}.

ncomps0(n,_40125:_40127,_40125:_40127,_40117,_40117,0,[ncomps0,_40257],_40199,_40203) --> 
    w(noun(_40127,_40143,_40145,n),_40257,_40199,_40203).

ncomps0(n,_40113,_40115,_40117,_40117,name,[ncomps0,{}],_40183,_40183) --> 
    {compatvar(_40113,_40115)}.

ncomps(_40111,_40113,_40115,_40117,[ncomps,_40269,{},_40381],_40223,_40227) --> 
    noun2(_40147,_40149,_40133,_40137,_40155,_40269,_40223,_40319),
    {has_template(_40113,_40137,_40167)},
    ncomps0(_40133,_40111,_40137,_40115 and _40155 and _40167,_40117,_40143,_40381,_40319,_40227).

s0(_40111,_40113,n,gen,[s0,_40207],_40161,_40165) --> 
    sin(_40207,_40161,_40165).

s0(_40111,_40113,n,gen,[s0,lit(s)],_40165,_40169) --> 
    cc(s,_40165,_40169).

s0(sin,u,n,n,[s0,[]],_40161,_40161) --> 
    [].

s0(sin,def,n,n,[s0,[]],_40161,_40161) --> 
    [].

s0(plu,u,n,n,[s0,[]],_40161,_40161) --> 
    [].

s0(plu,def,n,n,[s0,[]],_40161,_40161) --> 
    [].

s0(_40111,_40113,gen,gen,[s0,[]],_40161,_40161) --> 
    [].

noun_modifiers0(_40111,_40113,_40127::_40123,_40121::_40123,[noun_modifiers0,_40229],_40183,_40187) --> 
    noun_modsx0(_40111,_40113,_40121,_40127,_40229,_40183,_40187).

noun_modsx0(0,_40113,_40115,_40117,[noun_modsx0,_40215],_40169,_40173) --> 
    rel_clauses(_40113,_40115,_40117,_40215,_40169,_40173).

noun_modsx0(0,_40139:_40141,_40115,_40115 and _40145 isa coevent and _40133 and _40135,[noun_modsx0,{},lit(til),lit(at),!,_40413,{},!,_40505],_40299,_40303) --> 
    {testmember(_40141,[cause])},
    cc(til,_40299,_40379),
    cc(at,_40379,_40401),
    !,
    clausal_object1(_40145:coevent,true::_40135,_40413,_40401,_40451),
    {noun_compl(to,_40139:_40141,_40145:coevent,_40133)},
    !,
    accept(_40505,_40451,_40303).

noun_modsx0(0,_40139:_40141,_40115,_40115 and _40145 isa coevent and _40133 and _40135,[noun_modsx0,{},lit(for),lit(å),!,_40423,{},!,_40533],_40309,_40313) --> 
    {testmember(_40141,[way])},
    cc(for,_40309,_40389),
    cc(å,_40389,_40411),
    !,
    pushstack(first,[noen],nil,_40411,_40449),clausal_object1(_40145:coevent,true::_40135,_40423,_40449,_40479),
    {noun_compl(regarding,_40139:_40141,_40145:coevent,_40133)},
    !,
    accept(_40533,_40479,_40313).

noun_modsx0(0,_40139:_40141,_40115,_40115 and _40145 isa coevent and _40133 and _40135,[noun_modsx0,{},lit(for),lit(hvordan),!,_40413,{},!,_40505],_40299,_40303) --> 
    {testmember(_40141,[way])},
    cc(for,_40299,_40379),
    cc(hvordan,_40379,_40401),
    !,
    clausal_object1(_40145:coevent,true::_40135,_40413,_40401,_40451),
    {noun_compl(regarding,_40139:_40141,_40145:coevent,_40133)},
    !,
    accept(_40505,_40451,_40303).

noun_modsx0(0,_40139:_40141,_40115,_40115 and _40145 isa coevent and _40133 and _40135,[noun_modsx0,{},lit(om),lit(hvor),_40435,!,_40503,{},!,_40613],_40331,_40335) --> 
    {testmember(_40141,[question])},
    cc(om,_40331,_40411),
    cc(hvor,_40411,_40433),
    w(adj2(_40225,nil),_40435,_40433,_40469),
    !,
    pushstack(free,w(adj2(_40225,nil)),nil,_40469,_40529),clausal_object1(_40145:coevent,true::_40135,_40503,_40529,_40559),
    {noun_compl(regarding,_40139:_40141,_40145:coevent,_40133)},
    !,
    accept(_40613,_40559,_40335).

noun_modsx0(0,_40139:_40141,_40115,_40115 and _40145 isa coevent and _40133 and _40135,[noun_modsx0,{},lit(der),!,_40381,{},!,_40473],_40289,_40293) --> 
    {testmember(_40141,[example])},
    cc(der,_40289,_40369),
    !,
    clausal_object1(_40145:coevent,true::_40135,_40381,_40369,_40419),
    {noun_compl(on,_40139:_40141,_40145:coevent,_40133)},
    !,
    accept(_40473,_40419,_40293).

noun_modsx0(0,_40139:_40141,_40115,_40115 and _40145 isa coevent and _40133 and _40135,[noun_modsx0,{},_40375,lit(å),!,_40495,{},!,_40753],_40315,_40319) --> 
    {testmember(_40141,[cause])},
    optional([for],_40375,_40315,_40439),
    cc(å,_40439,_40483),
    !,
    pushstack(first,(someone,aux1),nil,_40483,_40669),clausal_object1(_40145:coevent,true::_40135,_40495,_40669,_40699),
    {noun_compl(for,_40139:_40141,_40145:coevent,_40133)},
    !,
    accept(_40753,_40699,_40319).

noun_modsx0(0,_40139:_40141,_40115,_40115 and _40145 isa coevent and _40133 and _40135,[noun_modsx0,{},_40379,lit(å),!,_40499,{},!,_40757],_40319,_40323) --> 
    {testmember(_40141,[permission,possibility])},
    optional([til],_40379,_40319,_40443),
    cc(å,_40443,_40487),
    !,
    pushstack(first,(someone,aux1),nil,_40487,_40673),clausal_object1(_40145:coevent,true::_40135,_40499,_40673,_40703),
    {noun_compl(to,_40139:_40141,_40145:coevent,_40133)},
    !,
    accept(_40757,_40703,_40323).

noun_modsx0(0,_40139:_40141,_40115,_40115 and _40145 isa coevent and _40133 and _40135,[noun_modsx0,{},lit(om),lit(å),!,_40437,{},!,_40695],_40323,_40327) --> 
    {testmember(_40141,[notification,request,plan,wish])},
    cc(om,_40323,_40403),
    cc(å,_40403,_40425),
    !,
    pushstack(first,(someone,aux1),nil,_40425,_40611),clausal_object1(_40145:coevent,true::_40135,_40437,_40611,_40641),
    {noun_compl(about,_40139:_40141,_40145:coevent,_40133)},
    !,
    accept(_40695,_40641,_40327).

noun_modsx0(0,_40139:_40141,_40115,_40115 and _40145 isa coevent and _40133 and _40135,[noun_modsx0,{},_40365,lit(at),!,_40455,{},!,_40547],_40305,_40309) --> 
    {constrain(_40139:_40141,connection)},
    w(prep(with),_40365,_40305,_40399),
    cc(at,_40399,_40443),
    !,
    clausal_object1(_40145:coevent,true::_40135,_40455,_40443,_40493),
    {noun_compl(with,_40139:_40141,_40145:coevent,_40133)},
    !,
    accept(_40547,_40493,_40309).

noun_modsx0(0,_40113,_40115,_40115 and _40123,[noun_modsx0,{},_40367,_40415,_40503,_40571,!,_40649],_40307,_40311) --> 
    {constrain(_40113,way)},
    in_order_tox(_40367,_40307,_40397),
    lexv(tv,_40209,inf,fin,_40415,_40397,_40461),
    np1(_40217,_40223::_40225,_40503,_40461,_40541),
    fictitiousprep(way,_40231,_40571,_40541,_40609),
    !,
    pushstack(first,(someone,w(verb(_40209,pres,fin)),np1(_40217,_40223::_40225),prep(_40231),npgap(_40113)),nil,_40609,_40985),
    statreal(_40123,_40649,_40985,_40311).

noun_modsx0(0,_40113,_40115,_40115 and _40123,[noun_modsx0,{},_40331,_40379,_40467,!,_40545],_40271,_40275) --> 
    {constrain(_40113,way)},
    in_order_tox(_40331,_40271,_40361),
    lexv(iv,_40197,inf,fin,_40379,_40361,_40425),
    fictitiousprep(way,_40207,_40467,_40425,_40505),
    !,
    pushstack(first,(someone,w(verb(_40197,pres,fin)),prep(_40207),npgap(_40113)),nil,_40505,_40795),
    statreal(_40123,_40545,_40795,_40275).

noun_modsx0(_40111,_40113,_40115,_40115,[noun_modsx0,_40227,!,_40295],_40181,_40185) --> 
    look_ahead([den],_40227,_40181,_40261),
    !,
    accept(_40295,_40261,_40185).

noun_modsx0(_40111,_40113,_40115,_40115,[noun_modsx0,{},_40273,!,_40341],_40213,_40217) --> 
    {vartypeid(_40113,_40149),subclass(_40149,daypart)},
    not_look_ahead(w(prep(_40169)),_40273,_40213,_40307),
    !,
    accept(_40341,_40307,_40217).

noun_modsx0(_40111,_40113,_40115,_40117,[noun_modsx0,_40223,!],_40177,_40181) --> 
    noun_mods(_40111,_40113,_40115,_40117,_40223,_40177,_40181),
    !.

noun_modsx0(_40111,_40113,_40115,_40115,[noun_modsx0,[]],_40161,_40161) --> 
    [].

fictitiousprep(way,in,[fictitiousprep,[]],_40149,_40149) --> 
    [].

fictitiousprep(abstract,with,[fictitiousprep,[]],_40149,_40149) --> 
    [].

noun_mods(0,_40113,_40115,_40115 and _40123,[noun_mods,{},_40507,{},_40579,_40637,_40695,_40753,_40811,_40869,_40927,_40985],_40447,_40451) --> 
    {vartypeid(_40113,_40221),testmember(_40221,[address,email,mind,mailaddress,telephone,webaddress])},
    prep1(to,_40507,_40447,_40541),
    {vartypeid(_40113,_40275),\+testmember(_40275,[name])},
    not_look_ahead(w(nb(_40299,_40301)),_40579,_40541,_40613),
    not_look_ahead(w(prep(_40313)),_40637,_40613,_40671),
    not_look_ahead_lit([deg,meg,seg],_40695,_40671,_40729),
    not_look_ahead(w(noun(station,_40343,_40345,_40347)),_40753,_40729,_40787),
    not_look_ahead(w(name(_40359,_40361,station)),_40811,_40787,_40845),
    not_look_ahead(w(name(_40375,_40377,neighbourhood)),_40869,_40845,_40903),
    not_look_ahead(w(name(_40391,_40393,city)),_40927,_40903,_40961),
    pushstack(first,(npgap(_40113),w(verb(evah,pres,fin))),nil,_40961,_41083),
    statreal(_40123,_40985,_41083,_40451).

noun_mods(0,_40113,_40115,_40115 and _40123,[noun_mods,{},_40341,{},{},_40427],_40275,_40279) --> 
    {user:value(teleflag,true)},
    not_look_ahead(w(prep(_40199)),_40341,_40275,_40375),
    {vartypeid(_40113,_40209)},
    {\+vartypeid(_40209,[])},
    pushstack(first,(npgap(_40113),w(verb(evah,pres,fin))),nil,_40375,_40525),
    statreal(_40123,_40427,_40525,_40279).

noun_mods(0,_40113,_40115,_40117,[noun_mods,_40243,!,_40331,_40379],_40197,_40201) --> 
    noun_mod(_40113,_40115,_40143,_40243,_40197,_40285),
    !,
    accept(_40331,_40285,_40361),
    noun_modsx0(0,_40113,_40143,_40117,_40379,_40361,_40201).

noun_mods(name,_40113,_40115,_40117,[noun_mods,{},_40327,{},_40399,!,_40487,_40535],_40267,_40271) --> 
    {vartypeid(_40113,_40177),subclass0(_40177,vehicle)},
    look_ahead(w(prep(_40197)),_40327,_40267,_40361),
    {testmember(_40197,[to,from])},
    noun_mod(_40113,_40115,_40161,_40399,_40361,_40441),
    !,
    accept(_40487,_40441,_40517),
    noun_mods(name,_40113,_40161,_40117,_40535,_40517,_40271).

noun_mods(name,_40113,_40115,_40117,[noun_mods,_40313,{},{},_40399,!,_40487,_40535],_40267,_40271) --> 
    look_ahead(w(prep(_40175)),_40313,_40267,_40347),
    {testmember(_40175,[on,towards])},
    {vartypeid(_40113,_40207),subclass0(_40207,place)},
    noun_mod(_40113,_40115,_40161,_40399,_40347,_40441),
    !,
    accept(_40487,_40441,_40517),
    noun_mods(name,_40113,_40161,_40117,_40535,_40517,_40271).

noun_mods(name,_40113,_40115,_40117,[noun_mods,{},_40285,_40363],_40225,_40229) --> 
    {user:value(textflag,true);user:value(teleflag,true)},
    noun_mod(_40113,_40115,_40137,_40285,_40225,_40327),
    noun_mods(name,_40113,_40137,_40117,_40363,_40327,_40229).

noun_mods(name,_40113,_40115,_40115 and _40123,[noun_mods,{},{},_40355,{},_40427],_40275,_40279) --> 
    {user:value(teleflag,true)},
    {constrain(_40113,person)},
    w(name(_40167,n,_40171),_40355,_40275,_40389),
    {subclass0(_40171,place)},
    pushstack(first,(prep1(in),w(name(_40167,n,_40171))),nil,_40389,_40525),
    noun_mod(_40113,_40115,_40123,_40427,_40525,_40279).

noun_mod(_40131:_40133,_40113,nrel/nil/day/clock/_40131/_40139 and _40113 and _40127,[noun_mod,{},_40297,_40345],_40243,_40247) --> 
    {constrain(_40131:_40133,day)},
    clock(_40297,_40243,_40327),
    clock_sequel(_40139:_40203,_40127,_40345,_40327,_40247).

noun_mod(_40111,_40113,_40113 and _40121,[noun_mod,_40235,{},!],_40195,_40199) --> 
    adverb(_40137,_40139,_40141,_40235,_40195,_40199),
    {noun_adverb(_40111,_40137,_40139,_40121)},
    !.

noun_mod(_40131:_40133,_40113,_40113 and _40125 and _40127,[noun_mod,lit(for),lit(å),_40371,!,_40449,{},!,_40559],_40287,_40291) --> 
    cc(for,_40287,_40347),
    cc(å,_40347,_40369),
    gmem(_40133,[condition],_40371,_40369,_40409),
    !,
    pushstack(first,[noen],nil,_40409,_40475),clausal_object1(_40219:coevent,true::_40127,_40449,_40475,_40505),
    {noun_compl(for,_40131:_40133,_40219:coevent,_40125)},
    !,
    accept(_40559,_40505,_40291).

noun_mod(_40131:_40133,_40113,_40113 and _40125 and _40127,[noun_mod,lit(om),lit(at),{},!,_40417,{},{},!,_40523],_40309,_40313) --> 
    cc(om,_40309,_40369),
    cc(at,_40369,_40391),
    {testmember(_40133,[information,message,notification,question])},
    !,
    clausal_object1(_40231:coevent,_40225::_40127,_40417,_40391,_40455),
    {_40225=true},
    {noun_compl(regarding,_40131:_40133,_40231:coevent,_40125)},
    !,
    accept(_40523,_40455,_40313).

noun_mod(_40111,_40113,_40113 and _40121,[noun_mod,_40253,_40311],_40213,_40217) --> 
    posspron(_40153,_40253,_40213,_40287),
    lock(exact,_40287,_40501),
    pushstack(exact,(pronoun(_40153),w(verb(have,pres,fin)),npgap(_40111)),nil,_40501,_40513),
    statreal(_40121,_40311,_40513,_40491),
    unlock(_40491,_40217).

noun_mod(_40111,_40113,_40113 and _40121,[noun_mod,_40229,_40287],_40189,_40193) --> 
    look_ahead(w(adj(_40147,comp)),_40229,_40189,_40263),
    comparison(_40111,_40133,_40121,_40287,_40263,_40193).

noun_mod(_40111,_40113,_40113 and _40121,[noun_mod,_40295,{},_40367,{},!,_40469,{}],_40255,_40259) --> 
    negation0(_40165,_40295,_40255,_40329),
    {\+vartypeid(_40111,self)},
    adjunct1(_40191,_40193,_40169::_40121,_40367,_40329,_40409),
    {noun_compl(_40191,_40111,_40193,_40167)},
    !,
    accept(_40469,_40409,_40259),
    {negate(_40165,_40167,_40169)}.

noun_mod(_40119:_40121,_40113,_40113,[noun_mod,{},_40263,_40311,{}],_40209,_40213) --> 
    {constrain(_40119:_40121,vehicle)},
    numberroute(_40263,_40209,_40293),
    num_na(_40147,_40311,_40293,_40213),
    {_40147=_40119}.

noun_mod(_40111,_40113,_40113 and _40121,[noun_mod,_40275,_40333,{},!,_40469],_40235,_40239) --> 
    day(_40149,_40275,_40235,_40309),
    lock(exact,_40309,_40373),pushstack(exact,w(noun(_40149,sin,u,n)),nil,_40373,_40385),np1(_40173,_40179::_40121,_40333,_40385,_40363),unlock(_40363,_40365),
    {noun_compl(nil,_40111,_40173,_40179)},
    !,
    accept(_40469,_40365,_40239).

noun_mod(_40111,_40113,_40113 and _40121,[noun_mod,_40285,_40343,{},!,_40453],_40245,_40249) --> 
    w(noun(midnight,_40155,_40157,n),_40285,_40245,_40319),
    pushstack(first,w(noun(midnight,sin,u,n)),nil,_40319,_40369),np1(_40183,_40189::_40121,_40343,_40369,_40399),
    {noun_compl(nil,_40111,_40183,_40189)},
    !,
    accept(_40453,_40399,_40249).

noun_mod(_40111,_40113,_40113 and _40121,[noun_mod,_40245,{},!,_40337],_40205,_40209) --> 
    obviousdate(_40143,_40149::_40121,_40245,_40205,_40283),
    {noun_compl(nil,_40111,_40143,_40149)},
    !,
    accept(_40337,_40283,_40209).

noun_mod(_40111,_40113,_40113 and _40121,[noun_mod,_40245,{},!,_40337],_40205,_40209) --> 
    obviousclock(_40143,_40149::_40121,_40245,_40205,_40283),
    {noun_compl(nil,_40111,_40143,_40149)},
    !,
    accept(_40337,_40283,_40209).

noun_mod(_40111,_40113,_40115,[noun_mod,_40279,_40337,!,_40415,!,_40589],_40239,_40243) --> 
    w(noun(direction,_40155,_40157,_40159),_40279,_40239,_40313),
    nameq1(_40163,_40165,_40337,_40313,_40375),
    !,
    pushstack(first,(w(prep(towards)),nameq1(_40163,_40165)),nil,_40375,_40509),noun_mod(_40111,_40113,_40115,_40415,_40509,_40543),
    !,
    accept(_40589,_40543,_40243).

noun_mod(_40125:_40127,_40113,_40113 and _40121,[noun_mod,{},_40299,{},!,_40391],_40245,_40249) --> 
    {test(semantic:n_compl(nil,_40127,_40173))},
    np1_accept(_40177,_40183::_40121,_40299,_40245,_40337),
    {noun_compl(nil,_40125:_40127,_40177,_40183)},
    !,
    accept(_40391,_40337,_40249).

begin([begin,[]],_40135,_40135) --> 
    [].

end([end,[]],_40135,_40135) --> 
    [].

accept([accept,[]],_40135,_40135) --> 
    [].

reject([reject,{}],_40139,_40139) --> 
    {fail}.

look_ahead_place([look_ahead_place,_40193,{}],_40171,_40175) --> 
    look_ahead(w(name(_40139,_40141,_40125)),_40193,_40171,_40175),
    {test(subclass0(_40125,place))}.

look_ahead_conjuction([look_ahead_conjuction,_40165],_40143,_40147) --> 
    look_ahead([før],_40165,_40143,_40147).

look_ahead_conjuction([look_ahead_conjuction,_40165],_40143,_40147) --> 
    look_ahead([etter],_40165,_40143,_40147).

look_ahead_conjuction([look_ahead_conjuction,_40165],_40143,_40147) --> 
    look_ahead([når],_40165,_40143,_40147).

not_look_ahead_flnp([not_look_ahead_flnp,_40215,{},!,_40297],_40193,_40197) --> 
    look_ahead(w(adj2(_40137,nil)),_40215,_40193,_40249),
    {testmember(_40137,[first,last,next,previous])},
    !,
    reject(_40297,_40249,_40197).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_40135,_40135) --> 
    [].

not_look_ahead_flnp([not_look_ahead_flnp,_40215,{},!,_40297],_40193,_40197) --> 
    look_ahead(w(adj2(_40137,nil)),_40215,_40193,_40249),
    {testmember(_40137,[first,last,next,previous])},
    !,
    reject(_40297,_40249,_40197).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_40135,_40135) --> 
    [].

not_look_ahead_vehicle([not_look_ahead_vehicle,_40207,{},!,_40289],_40185,_40189) --> 
    look_ahead(w(noun(_40137,_40139,_40141,_40143)),_40207,_40185,_40241),
    {test(subclass0(_40137,vehicle))},
    !,
    reject(_40289,_40241,_40189).

not_look_ahead_vehicle([not_look_ahead_vehicle,_40211,{},!,_40293],_40189,_40193) --> 
    look_ahead(w(noun(_40137,_40139,_40141,_40143)),_40211,_40189,_40245),
    {testmember(_40137,[departure,arrival])},
    !,
    reject(_40293,_40245,_40193).

not_look_ahead_vehicle([not_look_ahead_vehicle,[]],_40135,_40135) --> 
    [].

not_look_ahead_day([not_look_ahead_day,_40203,{},!,_40285],_40181,_40185) --> 
    look_ahead(w(noun(_40137,_40139,_40141,_40143)),_40203,_40181,_40237),
    {_40137 ako day},
    !,
    reject(_40285,_40237,_40185).

not_look_ahead_day([not_look_ahead_day,[]],_40135,_40135) --> 
    [].

not_look_ahead_noun([not_look_ahead_noun,_40175],_40153,_40157) --> 
    not_look_ahead(w(noun(_40119,_40121,_40123,_40125)),_40175,_40153,_40157).

look_ahead_timeclause([look_ahead_timeclause,_40175],_40153,_40157) --> 
    look_ahead(w(noun(clock,_40121,_40123,_40125)),_40175,_40153,_40157).

look_ahead_timeclause([look_ahead_timeclause,_40191,{}],_40169,_40173) --> 
    look_ahead(w(noun(_40121,sin,u,n)),_40191,_40169,_40173),
    {subclass(_40121,day)}.

look_ahead_clock([look_ahead_clock,_40169],_40147,_40151) --> 
    look_ahead_lit([kl,klokken],_40169,_40147,_40151).

look_ahead_clock([look_ahead_clock,_40175],_40153,_40157) --> 
    look_ahead(w(noun(clock,sin,def,n)),_40175,_40153,_40157).

look_ahead_clock([look_ahead_clock,_40171],_40149,_40153) --> 
    look_ahead(w(nb(_40119,_40121)),_40171,_40149,_40153).

not_look_ahead_vp([not_look_ahead_vp,_40169,!,_40227],_40147,_40151) --> 
    look_ahead_vp(_40169,_40147,_40199),
    !,
    reject(_40227,_40199,_40151).

not_look_ahead_vp([not_look_ahead_vp,[]],_40135,_40135) --> 
    [].

look_ahead_vp([look_ahead_vp,_40173],_40151,_40155) --> 
    look_ahead(w(verb(_40119,_40121,_40123)),_40173,_40151,_40155).

look_ahead_vp([look_ahead_vp,_40165],_40143,_40147) --> 
    look_ahead([ikke],_40165,_40143,_40147).

look_ahead_vp([look_ahead_vp,_40157],_40135,_40139) --> 
    look_ahead_aux(_40157,_40135,_40139).

look_ahead_aux([look_ahead_aux,_40201],_40179,_40183) --> 
    look_ahead_lit([vil,skal,bør,må,kan,ville,skulle,burde,måtte,kunne],_40201,_40179,_40183).

not_look_ahead_lit(_40111,[not_look_ahead_lit,_40187,!,_40255],_40159,_40163) --> 
    look_ahead_lit(_40111,_40187,_40159,_40221),
    !,
    reject(_40255,_40221,_40163).

not_look_ahead_lit(_40111,[not_look_ahead_lit,[]],_40143,_40143) --> 
    [].

look_ahead_lit(_40111,[look_ahead_lit,_40201,{},!],_40173,_40177) --> 
    look_ahead([_40129],_40201,_40173,_40177),
    {testmember(_40129,_40111)},
    !.

lit_of(_40111,_40113,[lit_of,lit(_40111),{},!],_40175,_40179) --> 
    cc(_40111,_40175,_40179),
    {member(_40111,_40113)},
    !.

one_of_lit(_40111,[one_of_lit,lit(_40125),{},!],_40169,_40173) --> 
    cc(_40125,_40169,_40173),
    {member(_40125,_40111)},
    !.

not_one_of_lit(_40111,[not_one_of_lit,_40187,!,_40255],_40159,_40163) --> 
    one_of_lit(_40111,_40187,_40159,_40221),
    !,
    reject(_40255,_40221,_40163).

not_one_of_lit(_40111,[not_one_of_lit,[]],_40143,_40143) --> 
    [].

not_look_ahead_number([not_look_ahead_number,lit(ett),!],_40145,_40149) --> 
    cc(ett,_40145,_40149),
    !.

not_look_ahead_number([not_look_ahead_number,_40183,!,{}],_40161,_40165) --> 
    w(nb(_40131,_40133),_40183,_40161,_40165),
    !,
    {fail}.

not_look_ahead_number([not_look_ahead_number,[]],_40135,_40135) --> 
    [].

not_look_ahead_np([not_look_ahead_np,_40207,_40265,!],_40185,_40189) --> 
    look_ahead(w(adv(_40131)),_40207,_40185,_40241),
    gmem(_40131,[klokken,kloka,kl,directly,correctly],_40265,_40241,_40189),
    !.

not_look_ahead_np([not_look_ahead_np,_40169,!,_40227],_40147,_40151) --> 
    look_ahead_np(_40169,_40147,_40199),
    !,
    reject(_40227,_40199,_40151).

not_look_ahead_np([not_look_ahead_np,[]],_40135,_40135) --> 
    [].

look_ahead_np([look_ahead_np,_40293],_40271,_40275) --> 
    look_ahead_lit([den,det,de,denne,dere,dette,disse,du,en,et,ei,han,hun,jeg,noe,noen,vi,meg,deg,seg,min,mine,din,dine,hans,hennes,seg,vår,våre,deres,mange,noen,noe],_40293,_40271,_40275).

look_ahead_np([look_ahead_np,_40191,{}],_40169,_40173) --> 
    look_ahead(w(adj2(_40125,_40141)),_40191,_40169,_40173),
    {\+testmember(_40125,[])}.

look_ahead_np([look_ahead_np,_40175],_40153,_40157) --> 
    look_ahead(w(noun(_40119,_40121,_40123,_40125)),_40175,_40153,_40157).

look_ahead_np([look_ahead_np,_40171],_40149,_40153) --> 
    look_ahead(w(nb(_40119,_40121)),_40171,_40149,_40153).

look_ahead_np([look_ahead_np,_40169],_40147,_40151) --> 
    look_ahead_lit([halv,kvart],_40169,_40147,_40151).

look_ahead_np([look_ahead_np,_40193,{}],_40171,_40175) --> 
    look_ahead(w(name(_40125,_40141,_40143)),_40193,_40171,_40175),
    {\+testmember(_40125,[])}.

look_ahead_subject([look_ahead_subject,lit(_40121),{}],_40175,_40179) --> 
    cc(_40121,_40175,_40179),
    {testmember(_40121,[jeg,du,han,hun,vi])}.

look_ahead_pron([look_ahead_pron,_40177],_40155,_40159) --> 
    look_ahead_lit([jeg,vi,du,dere],_40177,_40155,_40159).

not_look_ahead_pron([not_look_ahead_pron,_40173,!,_40241],_40151,_40155) --> 
    posspron(_40123,_40173,_40151,_40207),
    !,
    reject(_40241,_40207,_40155).

not_look_ahead_pron([not_look_ahead_pron,_40177],_40155,_40159) --> 
    not_look_ahead_lit([jeg,du,han,hun],_40177,_40155,_40159).

determiner0(plu,0,_40115,_40117,_40123::quant(approx/_40149,_40115)::_40117 and _40123,[determiner0,lit(mellom),_40333,lit(og),_40413,{}],_40259,_40263) --> 
    cc(mellom,_40259,_40331),
    w(nb(_40149,num),_40333,_40331,_40367),
    cc(og,_40367,_40411),
    w(nb(_40183,num),_40413,_40411,_40263),
    {_40149<_40183}.

determiner0(plu,0,_40115,_40117,_40123::quant(eq/_40149,_40115)::_40117 and _40123,[determiner0,_40371,_40419,{},_40491,_40549,!,_40617,[]],_40319,_40323) --> 
    theplu0(_40371,_40319,_40401),
    w(adj2(_40205,nil),_40419,_40401,_40453),
    {testmember(_40205,[first,last,next,previous])},
    number(_40149:_40253,_40491,_40453,_40525),
    look_ahead(w(noun(_40265,plu,_40269,_40271)),_40549,_40525,_40583),
    !,
    accept(_40617,_40583,_40647),
    pushstack(free,w(adj2(_40205,nil)),nil,_40647,_40323),
    [].

determiner0(sin,0,_40115,_40117,_40123::_40125,[determiner0,{},_40293,_40341],_40221,_40225) --> 
    {user:value(dialog,1)},
    the(_40293,_40221,_40323),
    pushstack(first,this,nil,_40323,_40435),
    determiner(_40115,_40117,_40123::_40125,_40341,_40435,_40225).

determiner0(_40111,_40113,_40115,_40117,_40119,[determiner0,_40281,_40329,_40387,{},!,_40469],_40229,_40233) --> 
    theplu0(_40281,_40229,_40311),
    number(_40157:_40159,_40329,_40311,_40363),
    w(noun(_40167,_40169,_40171,_40173),_40387,_40363,_40421),
    {measureclass(_40167)},
    !,
    reject(_40469,_40421,_40233).

determiner0(plu,0,_40115,_40117,_40123::quant(approx/_40149,_40115)::_40117 and _40123,[determiner0,_40271,!,_40329],_40219,_40223) --> 
    approx(_40271,_40219,_40301),
    !,
    number(_40149:_40171,_40329,_40301,_40223).

approx([approx,lit(ca),!],_40145,_40149) --> 
    cc(ca,_40145,_40149),
    !.

approx([approx,lit(rundt),!],_40145,_40149) --> 
    cc(rundt,_40145,_40149),
    !.

determiner0(plu,0,_40115,_40117,_40123::quant(ge/_40149,_40115)::_40117 and _40123,[determiner0,_40265,_40313],_40213,_40217) --> 
    morethan(_40265,_40213,_40295),
    number(_40149:_40165,_40313,_40295,_40217).

morethan([morethan,lit(minst)],_40139,_40143) --> 
    cc(minst,_40139,_40143).

morethan([morethan,lit(over)],_40139,_40143) --> 
    cc(over,_40139,_40143).

morethan([morethan,lit(mer),lit(enn)],_40149,_40153) --> 
    cc(mer,_40149,_40191),
    cc(enn,_40191,_40153).

determiner0(plu,0,_40115,_40117,_40123::quant(eq/_40149,_40115)::_40117 and _40123,[determiner0,_40289,_40337,_40395],_40237,_40241) --> 
    theplu0(_40289,_40237,_40319),
    number(_40149:_40189,_40337,_40319,_40371),
    not_look_ahead(w(noun(time,_40175,def,n)),_40395,_40371,_40241).

determiner0(sin,0,_40115,_40117,_40123::quant(eq/1,_40115)::_40117 and _40123,[determiner0,_40289,_40347,!],_40237,_40241) --> 
    w(nb(1,num),_40289,_40237,_40323),
    not_look_ahead(w(noun(time,_40185,def,n)),_40347,_40323,_40241),
    !.

determiner0(sin,0,_40115,_40117,_40123::_40125,[determiner0,{},_40293,_40341],_40221,_40225) --> 
    {user:value(dialog,1)},
    the(_40293,_40221,_40323),
    pushstack(first,this,nil,_40323,_40435),
    determiner(_40115,_40117,_40123::_40125,_40341,_40435,_40225).

determiner0(plu,0,_40115,_40117,_40123::_40125,[determiner0,_40267,_40315,_40373],_40215,_40219) --> 
    the(_40267,_40215,_40297),
    not_look_ahead(w(verb(_40163,pres,fin)),_40315,_40297,_40349),
    determiner00(_40115,_40117,_40123::_40125,_40373,_40349,_40219).

determiner0(_40111,0,_40115,_40117,_40123::_40125,[determiner0,_40239],_40187,_40191) --> 
    determiner(_40115,_40117,_40123::_40125,_40239,_40187,_40191).

determiner0(_40111,0,_40115,_40117,_40123::_40125,[determiner0,_40239],_40187,_40191) --> 
    determiner00(_40115,_40117,_40123::_40125,_40239,_40187,_40191).

determiner0(_40111,0,_40115,_40117,_40123::exists(_40115)::_40117 and _40123,[determiner0,_40241],_40189,_40193) --> 
    the0(_40241,_40189,_40193).

determiner00(_40131:_40133,_40113,_40119::_40113 and _40119,[determiner00,_40229,!],_40189,_40193) --> 
    the(_40131:_40133,_40229,_40189,_40193),
    !.

determiner00(_40111,_40113,_40119::exists(_40111)::_40113 and _40119,[determiner00,[]],_40177,_40177) --> 
    [].

determiner(_40111,_40113,_40119::forall(_40111)::_40113=>_40119,[determiner,lit(alle),_40249],_40187,_40191) --> 
    cc(alle,_40187,_40247),
    look_ahead_np(_40249,_40247,_40191).

determiner(_40111,_40113,_40119::forall(_40111)::_40113=>_40119,[determiner,lit(hver)],_40181,_40185) --> 
    cc(hver,_40181,_40185).

determiner(_40111,_40113,_40119::find(_40111)::_40113 and _40119,[determiner,_40223,_40271],_40183,_40187) --> 
    this(_40223,_40183,_40253),
    look_ahead_np(_40271,_40253,_40187).

determiner(_40111,_40113,_40119::_40113 and _40119,[determiner,_40211],_40171,_40175) --> 
    the(_40111,_40211,_40171,_40175).

determiner(_40111,_40113,_40119::exists(_40111)::_40113 and _40119,[determiner,_40259,_40307,_40355,_40413,!],_40219,_40223) --> 
    only0(_40259,_40219,_40289),
    art(_40307,_40289,_40337),
    look_ahead(w(noun(_40173,sin,u,n)),_40355,_40337,_40389),
    off0(_40413,_40389,_40223),
    !.

determiner(_40111,_40113,_40119::exists(_40111)::_40113 and _40119,[determiner,_40229,_40277,_40325],_40189,_40193) --> 
    only0(_40229,_40189,_40259),
    art(_40277,_40259,_40307),
    off0(_40325,_40307,_40193).

determiner(_40111,_40113,_40119::forall(_40111)::_40113=>_40119,[determiner,_40223,_40271],_40183,_40187) --> 
    every(_40223,_40183,_40253),
    look_ahead_np(_40271,_40253,_40187).

determiner(_40111,_40113,_40119::not (exists(_40111)::_40113 and _40119),[determiner,_40227,_40275],_40187,_40191) --> 
    no(_40227,_40187,_40257),
    look_ahead_np(_40275,_40257,_40191).

determiner(_40111,_40113,_40119::exists(_40111)::_40113 and not _40119,[determiner,_40227,_40275],_40187,_40191) --> 
    notall(_40227,_40187,_40257),
    look_ahead_np(_40275,_40257,_40191).

determiner(_40111,_40113,_40119::quant(all,_40111)::_40113 and _40119,[determiner,lit(hele)],_40183,_40187) --> 
    cc(hele,_40183,_40187).

determiner(_40111,_40113,_40119::_40121,[determiner,_40215],_40175,_40179) --> 
    quantifier(_40111,_40113,_40119::_40121,_40215,_40175,_40179).

quantifier(_40111,_40113,_40119::quant(eq/_40145,_40111)::_40113 and _40119,[quantifier,lit(bare),_40267],_40205,_40209) --> 
    cc(bare,_40205,_40265),
    w(nb(_40145,_40161),_40267,_40265,_40209).

quantifier(_40111,_40113,_40119::quant(few,_40111)::_40113 and _40119,[quantifier,_40231,_40279,_40327],_40191,_40195) --> 
    aso0(_40231,_40191,_40261),
    few(_40279,_40261,_40309),
    look_ahead_np(_40327,_40309,_40195).

quantifier(_40111,_40113,_40119::quant(most,_40111)::_40113 and _40119,[quantifier,lit(de),lit(fleste),_40283],_40199,_40203) --> 
    cc(de,_40199,_40259),
    cc(fleste,_40259,_40281),
    look_ahead_np(_40283,_40281,_40203).

quantifier(_40111,_40113,_40119::quant(much,_40111)::_40113 and _40119,[quantifier,_40239,_40287],_40199,_40203) --> 
    much(_40239,_40199,_40269),
    not_look_ahead(w(adj2(_40157,nil)),_40287,_40269,_40203).

quantifier(_40111,_40113,_40119::quant(little,_40111)::_40113 and _40119,[quantifier,_40239,_40287],_40199,_40203) --> 
    little(_40239,_40199,_40269),
    not_look_ahead(w(adj2(_40157,nil)),_40287,_40269,_40203).

quantifier(_40111,_40113,_40119::quant(many,_40111)::_40113 and _40119,[quantifier,_40231,_40279,_40327],_40191,_40195) --> 
    aso0(_40231,_40191,_40261),
    many(_40279,_40261,_40309),
    look_ahead_np(_40327,_40309,_40195).

quantifier(_40111,_40113,_40119::quant(most,_40111)::_40113 and _40119,[quantifier,_40231,_40279,_40327],_40191,_40195) --> 
    aso0(_40231,_40191,_40261),
    most(_40279,_40261,_40309),
    look_ahead_np(_40327,_40309,_40195).

quantifier(_40111,_40113,_40119::quant(all,_40111)::_40113 and _40119,[quantifier,lit(alle),_40251],_40189,_40193) --> 
    cc(alle,_40189,_40249),
    look_ahead_np(_40251,_40249,_40193).

quantifier(_40111,_40113,_40119::quant(ge/2,_40111)::_40113 and _40119,[quantifier,_40231,_40279],_40191,_40195) --> 
    several(_40231,_40191,_40261),
    look_ahead_np(_40279,_40261,_40195).

quantifier(_40111,_40113,_40119::quant(count,_40111)::_40113 and _40119,[quantifier,_40253,_40311,_40399],_40213,_40217) --> 
    w(noun(count,_40161,_40163,_40165),_40253,_40213,_40287),
    optional([av],_40311,_40287,_40375),
    look_ahead_np(_40399,_40375,_40217).

few([few,lit(få)],_40139,_40143) --> 
    cc(få,_40139,_40143).

few([few,lit(færre)],_40139,_40143) --> 
    cc(færre,_40139,_40143).

plausible_name(_40119:person,_40119 isa person,_40115,[plausible_name,_40263,_40341,{},!,_40443],_40223,_40227) --> 
    properfirstname(_40155,_40157,_40159,_40263,_40223,_40305),
    properlastname(_40163,_40165,_40115,_40341,_40305,_40383),
    {_40119=(_40155,_40163)},
    !,
    accept(_40443,_40383,_40227).

plausible_name(_40119:_40121,_40119 isa _40121,_40115,[plausible_name,_40255,{}],_40215,_40219) --> 
    w(name(_40119,_40115,_40121),_40255,_40215,_40219),
    {\+_40121=0,\+_40121=date}.

name_compound(_40111,_40113,_40115,[name_compound,_40287,_40345,_40403,_40461,_40539,_40627],_40247,_40251) --> 
    not_look_ahead([dere],_40287,_40247,_40321),
    not_look_ahead([du],_40345,_40321,_40379),
    not_look_ahead(w(nb(_40187,_40189)),_40403,_40379,_40437),
    plausible_name(_40153,_40155,_40197,_40461,_40437,_40503),
    s0(sin,u,_40197,_40149,_40539,_40503,_40585),
    ncomps0(_40149,_40113,_40153,_40155,_40115,_40111,_40627,_40585,_40251).

namep(name,_40119:street,_40119 isa street,[namep,_40293,_40351,_40399,_40457,{},!,_40539],_40253,_40257) --> 
    w(name(_40119,n,street),_40293,_40253,_40327),
    comma0(_40351,_40327,_40381),
    postcode(_40179,_40399,_40381,_40433),
    w(name(_40187,n,_40191),_40457,_40433,_40491),
    {testmember(_40191,[neighbourhood,city,station])},
    !,
    accept(_40539,_40491,_40257).

namep(_40111,_40113,_40115,[namep,_40287,_40345,_40403,_40461,_40539,_40627],_40247,_40251) --> 
    not_look_ahead([dere],_40287,_40247,_40321),
    not_look_ahead([du],_40345,_40321,_40379),
    not_look_ahead(w(nb(_40187,_40189)),_40403,_40379,_40437),
    plausible_name(_40153,_40155,_40197,_40461,_40437,_40503),
    s0(sin,u,_40197,_40149,_40539,_40503,_40585),
    ncomps0(_40149,_40113,_40153,_40155,_40115,_40111,_40627,_40585,_40251).

namep(name,_40119:thing,_40119 isa unkn,[namep,{},_40265,_40323],_40205,_40209) --> 
    {user:value(unknownflag,true)},
    unplausible_name(_40143,_40265,_40205,_40299),
    morenames(_40143,_40119,_40323,_40299,_40209).

namep(0,_40113,_40115,[namep,_40201],_40161,_40165) --> 
    measure(_40113,_40115,_40201,_40161,_40165).

namep(name,_40113,_40115,[namep,_40225,_40273],_40185,_40189) --> 
    you(_40225,_40185,_40255),
    pushstack(first,w(name(tuc,n,savant)),nil,_40255,_40293),
    nameq(_40113,_40115,_40273,_40293,_40189).

namep(0,_40113,_40115,[namep,_40231,_40289,!,_40407],_40191,_40195) --> 
    number(_40137,_40231,_40191,_40265),
    noun(_40141,plu,_40145,n,_40149,_40151,_40289,_40265,_40343),
    !,
    reject(_40407,_40343,_40195).

namep(0,_40113,_40115,[namep,_40401,_40449,{},_40561,_40619,_40677,_40745,{},{},_40831,_40889,!,_40957],_40361,_40365) --> 
    athe0(_40401,_40361,_40431),
    noun2(_40191,_40193,n,_40203:_40205,_40199,_40449,_40431,_40499),
    {\+testmember(_40205,[thing])},
    not_look_ahead([jeg],_40561,_40499,_40595),
    not_look_ahead([du],_40619,_40595,_40653),
    nameq(_40243,_40245,_40677,_40653,_40715),
    not_look_ahead([:],_40745,_40715,_40779),
    {compoundtest(_40191,_40193,_40203:_40205,_40243)},
    {align_noun_name(_40203:_40205,_40243,_40199,_40113,_40115)},
    optional_suffix(_40203:_40205,_40831,_40779,_40865),
    not_look_ahead(w(name(_40317,_40319,date)),_40889,_40865,_40923),
    !,
    accept(_40957,_40923,_40365).

namep(0,_40113,_40115,[namep,_40285,_40333,_40381,_40449,{},!,{}],_40245,_40249) --> 
    athe0(_40285,_40245,_40315),
    nr0(_40333,_40315,_40363),
    nameq1(_40161,_40173,_40381,_40363,_40419),
    noun(_40177,sin,u,n,_40159,_40163,_40449,_40419,_40249),
    {testmember(_40177,[bus,tram])},
    !,
    {align_noun_name(_40159,_40161,_40163,_40113,_40115)}.

namep(0,_40113,_40115,[namep,_40287,_40335,_40393,_40461,{},{}],_40247,_40251) --> 
    athe0(_40287,_40247,_40317),
    not_look_ahead([_40167],_40335,_40317,_40369),
    nameq1(_40155,_40175,_40393,_40369,_40431),
    noun(_40179,sin,_40183,n,_40153,_40157,_40461,_40431,_40251),
    {\+testmember(_40179,[thing])},
    {align_noun_name(_40153,_40155,_40157,_40113,_40115)}.

namep(name,_40113,_40115,[namep,_40215,_40273],_40175,_40179) --> 
    not_look_ahead([ett],_40215,_40175,_40249),
    nameq(_40113,_40115,_40273,_40249,_40179).

optional_suffix(_40115:_40117,[optional_suffix,_40219,{},!,_40301],_40191,_40195) --> 
    w(noun(_40143,_40145,_40147,n),_40219,_40191,_40253),
    {alignable(_40117,_40143)},
    !,
    accept(_40301,_40253,_40195).

optional_suffix(_40115:_40117,[optional_suffix,_40219,{},!,_40301],_40191,_40195) --> 
    w(noun(_40143,_40145,_40147,n),_40219,_40191,_40253),
    {alignable(_40117,_40143)},
    !,
    accept(_40301,_40253,_40195).

optional_suffix(_40115:_40117,[optional_suffix,_40177],_40149,_40153) --> 
    point0(_40177,_40149,_40153).

noun2(sin,u,n,_40123:thing,_40123 isa thing,[noun2,lit(_40153),{},_40313],_40225,_40229) --> 
    cc(_40153,_40225,_40297),
    {testmember(_40153,[de,disse,dem])},
    look_ahead([som],_40313,_40297,_40229).

noun2(plu,u,n,_40123:thing,_40123 isa thing,[noun2,lit(_40145),{},_40305],_40217,_40221) --> 
    cc(_40145,_40217,_40289),
    {testmember(_40145,[de,disse,dem])},
    not_look_ahead_np(_40305,_40289,_40221).

noun2(sin,u,n,_40123:agent,_40123 isa agent,[noun2,_40245,_40293],_40193,_40197) --> 
    agent_pronoun(_40245,_40193,_40275),
    look_ahead([som],_40293,_40275,_40197).

noun2(sin,u,n,_40123:thing,_40123 isa thing,[noun2,lit(det),_40271],_40197,_40201) --> 
    cc(det,_40197,_40269),
    look_ahead([som],_40271,_40269,_40201).

noun2(_40111,_40113,_40115,_40117,_40119,[noun2,_40299,{},_40421,!,_40479],_40247,_40251) --> 
    noun(_40147,_40111,_40113,_40115,_40117,_40119,_40299,_40247,_40353),
    {testmember(_40147,[monday,tuesday,wednesday,thursday,friday,saturday,sunday,month])},
    point0(_40421,_40353,_40451),
    !,
    accept(_40479,_40451,_40251).

noun2(_40111,_40113,_40115,_40123:_40125,_40119,[noun2,_40357,_40415,_40473,_40531,_40589,{},!,_40671],_40305,_40309) --> 
    w(noun(_40175,_40177,u,n),_40357,_40305,_40391),
    not_look_ahead(w(noun(number,sin,_40197,n)),_40415,_40391,_40449),
    not_look_ahead([nr],_40473,_40449,_40507),
    not_look_ahead(w(verb(_40219,_40221,_40223)),_40531,_40507,_40565),
    w(noun(_40231,_40111,_40113,_40115),_40589,_40565,_40623),
    {adjnoun_template(_40175,_40231,_40123:_40125,_40119)},
    !,
    accept(_40671,_40623,_40309).

noun2(_40111,_40113,_40115,_40117,_40119,[noun2,_40233],_40181,_40185) --> 
    noun(_40123,_40111,_40113,_40115,_40117,_40119,_40233,_40181,_40185).

noun2(sin,u,n,_40123:thing,_40123 isa thing,[noun2,_40251,_40299,!],_40199,_40203) --> 
    someone(_40251,_40199,_40281),
    look_ahead([som],_40299,_40281,_40203),
    !.

agent_pronoun([agent_pronoun,lit(jeg)],_40139,_40143) --> 
    cc(jeg,_40139,_40143).

agent_pronoun([agent_pronoun,lit(du)],_40139,_40143) --> 
    cc(du,_40139,_40143).

agent_pronoun([agent_pronoun,lit(noen)],_40139,_40143) --> 
    cc(noen,_40139,_40143).

agent_pronoun([agent_pronoun,lit(mange)],_40139,_40143) --> 
    cc(mange,_40139,_40143).

agent_pronoun([agent_pronoun,lit(få)],_40139,_40143) --> 
    cc(få,_40139,_40143).

agent_pronoun([agent_pronoun,lit(han)],_40139,_40143) --> 
    cc(han,_40139,_40143).

agent_pronoun([agent_pronoun,lit(ham)],_40139,_40143) --> 
    cc(ham,_40139,_40143).

agent_pronoun([agent_pronoun,lit(hun)],_40139,_40143) --> 
    cc(hun,_40139,_40143).

agent_pronoun([agent_pronoun,lit(henne)],_40139,_40143) --> 
    cc(henne,_40139,_40143).

agent_pronoun([agent_pronoun,lit(dere)],_40139,_40143) --> 
    cc(dere,_40139,_40143).

agent_pronoun([agent_pronoun,lit(alle)],_40139,_40143) --> 
    cc(alle,_40139,_40143).

noun(_40111,_40113,_40115,_40117,_40125:_40111,_40125 isa _40111,[noun,_40257],_40199,_40203) --> 
    w(noun(_40111,_40113,_40115,_40117),_40257,_40199,_40203).

measure(_40111,_40113,[measure,_40271,{},_40393,_40461,_40509,!,{}],_40237,_40241) --> 
    noun(_40169,_40171,_40173,n,_40157,_40161,_40271,_40237,_40325),
    {measureclass(_40169)},
    gmem(_40169,[crown],_40393,_40325,_40431),
    point0(_40461,_40431,_40491),
    anumber(_40159,_40509,_40491,_40241),
    !,
    {align_measure(_40157,_40159,_40161,_40111,_40113)}.

measure(_40111,_40113,[measure,_40265,_40323,_40371,_40479,_40527,{},{}],_40231,_40235) --> 
    anumber(_40159,_40265,_40231,_40299),
    point0(_40323,_40299,_40353),
    noun(_40173,_40175,_40177,n,_40157,_40161,_40371,_40353,_40425),
    point0(_40479,_40425,_40509),
    not_overon_clock(_40173,_40527,_40509,_40235),
    {measureclass(_40173)},
    {align_measure(_40157,_40159,_40161,_40111,_40113)}.

not_overon_clock(_40111,[not_overon_clock,{},_40281,{},_40353,!,_40421],_40239,_40243) --> 
    {testmember(_40111,[hour,minute,second])},
    prep1(_40167,_40281,_40239,_40315),
    {testmember(_40167,[on,before,over,after])},
    look_ahead(w(nb(_40205,_40207)),_40353,_40315,_40387),
    !,
    reject(_40421,_40387,_40243).

not_overon_clock(_40111,[not_overon_clock,[]],_40143,_40143) --> 
    [].

nameq(_40111,_40113,[nameq,_40209,_40277],_40175,_40179) --> 
    nameq1(_40111,_40113,_40209,_40175,_40247),
    not_look_ahead(w(nb(_40131,_40133)),_40277,_40247,_40179).

nameq(_40111,_40113,[nameq,_40209,_40277],_40175,_40179) --> 
    nameq2(_40111,_40113,_40209,_40175,_40247),
    not_look_ahead(w(nb(_40131,_40133)),_40277,_40247,_40179).

name1g(_40119:lastname,_40119 isa lastname,_40115,[name1g,{},_40317,_40375,_40433,!,_40501],_40257,_40261) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_40119,_40187,firstname)),_40317,_40257,_40351),
    w(name(_40119,_40115,lastname),_40375,_40351,_40409),
    not_look_ahead(w(name(_40213,_40215,lastname)),_40433,_40409,_40467),
    !,
    accept(_40501,_40467,_40261).

name1g(_40119:firstname,_40119 isa firstname,n,[name1g,{},_40317,_40375,_40433,!,_40501],_40257,_40261) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_40119,_40187,lastname)),_40317,_40257,_40351),
    w(name(_40119,n,firstname),_40375,_40351,_40409),
    look_ahead(w(name(_40213,_40215,lastname)),_40433,_40409,_40467),
    !,
    accept(_40501,_40467,_40261).

name1g(_40119:lastname,_40119 isa lastname,_40115,[name1g,{},_40317,_40375,_40433,!,_40501],_40257,_40261) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_40119,_40187,firstname)),_40317,_40257,_40351),
    w(name(_40119,_40115,lastname),_40375,_40351,_40409),
    not_look_ahead(w(name(_40213,n,lastname)),_40433,_40409,_40467),
    !,
    accept(_40501,_40467,_40261).

name1g(_40119:firstname,_40119 isa firstname,n,[name1g,{},_40317,_40375,_40433,!,_40501],_40257,_40261) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_40119,_40187,lastname)),_40317,_40257,_40351),
    w(name(_40119,n,firstname),_40375,_40351,_40409),
    look_ahead(w(name(_40213,n,lastname)),_40433,_40409,_40467),
    !,
    accept(_40501,_40467,_40261).

name1g(_40119:_40121,_40119 isa _40121,_40115,[name1g,_40221],_40181,_40185) --> 
    wnameg(_40119:_40121,_40115,_40121,_40221,_40181,_40185).

wnameg(_40119:_40115,gen,_40115,[wnameg,_40225,_40283,!],_40185,_40189) --> 
    w(name(_40119,n,_40115),_40225,_40185,_40259),
    sin(_40283,_40259,_40189),
    !.

wnameg(_40119:_40115,gen,_40115,[wnameg,_40225,_40283,!],_40185,_40189) --> 
    w(name(_40119,gen,_40115),_40225,_40185,_40259),
    sin(_40283,_40259,_40189),
    !.

wnameg(_40119:_40115,gen,_40115,[wnameg,_40219,!],_40179,_40183) --> 
    w(name(_40119,gen,_40115),_40219,_40179,_40183),
    !.

wnameg(_40119:_40115,n,_40115,[wnameg,_40213],_40173,_40177) --> 
    w(name(_40119,n,_40115),_40213,_40173,_40177).

nameq1(_40117:lastname,_40117 isa lastname,[nameq1,{},_40305,_40363,_40421,!,_40489],_40251,_40255) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_40117,n,firstname)),_40305,_40251,_40339),
    w(name(_40117,n,lastname),_40363,_40339,_40397),
    not_look_ahead(w(name(_40211,n,lastname)),_40421,_40397,_40455),
    !,
    accept(_40489,_40455,_40255).

nameq1(_40117:firstname,_40117 isa firstname,[nameq1,{},_40305,_40363,_40421,!,_40489],_40251,_40255) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name(_40117,n,lastname)),_40305,_40251,_40339),
    w(name(_40117,n,firstname),_40363,_40339,_40397),
    look_ahead(w(name(_40211,n,lastname)),_40421,_40397,_40455),
    !,
    accept(_40489,_40455,_40255).

nameq1(quote(_40129):_40125,quote(_40129)isa thing,[nameq1,_40233,!,{}],_40199,_40203) --> 
    w(quote(_40129),_40233,_40199,_40203),
    !,
    {type(thing,_40125)}.

nameq1(_40111,_40113,[nameq1,_40211,_40269,_40317,!,_40375],_40177,_40181) --> 
    number(_40141,_40211,_40177,_40245),
    point0(_40269,_40245,_40299),
    monthnamex(_40317,_40299,_40347),
    !,
    reject(_40375,_40347,_40181).

nameq1(_40111,_40113,[nameq1,_40219,_40277,!,_40345],_40185,_40189) --> 
    number(_40135,_40219,_40185,_40253),
    w(noun(hour,_40145,_40147,_40149),_40277,_40253,_40311),
    !,
    reject(_40345,_40311,_40189).

nameq1(_40111,_40113,[nameq1,_40225,_40283,_40331,!,_40399],_40191,_40195) --> 
    number(_40141,_40225,_40191,_40259),
    point(_40283,_40259,_40313),
    w(noun(_40149,_40151,_40153,_40155),_40331,_40313,_40365),
    !,
    reject(_40399,_40365,_40195).

nameq1(_40111,_40113,[nameq1,_40201,!,_40279],_40167,_40171) --> 
    obviousclock1(_40111,_40113,_40201,_40167,_40239),
    !,
    accept(_40279,_40239,_40171).

nameq1(_40117:_40125,_40117 isa clock,[nameq1,_40227,_40275,!,{}],_40193,_40197) --> 
    clock0(_40227,_40193,_40257),
    time2(_40117,_40275,_40257,_40197),
    !,
    {type(clock,_40125)}.

nameq1(_40117:_40125,_40117 isa clock,[nameq1,_40213],_40179,_40183) --> 
    plausibleclock1(_40117:_40125,_40117 isa clock,_40213,_40179,_40183).

nameq1(_40111,_40113,[nameq1,_40189],_40155,_40159) --> 
    date(_40111,_40113,_40189,_40155,_40159).

nameq1(_40117:_40119,_40113,[nameq1,_40221,_40269,!,_40337],_40187,_40191) --> 
    one(_40221,_40187,_40251),
    w(noun(_40145,sin,u,n),_40269,_40251,_40303),
    !,
    reject(_40337,_40303,_40191).

nameq1(_40117:_40125,_40117 isa _40119,[nameq1,_40281,{},{},_40367,!,_40435],_40247,_40251) --> 
    w(name(_40117,_40165,_40119),_40281,_40247,_40315),
    {atom(_40117)},
    {testmember(_40119,[language,colour])},
    look_ahead(w(noun(_40205,_40207,_40209,_40211)),_40367,_40315,_40401),
    !,
    reject(_40435,_40401,_40251).

nameq1(_40117:_40125,_40117 isa _40119,[nameq1,_40315,_40373,{},{},{},{}],_40281,_40285) --> 
    not_look_ahead(w(name,_40175,gen,_40179),_40315,_40281,_40349),
    w(name(_40117,_40189,_40119),_40373,_40349,_40285),
    {_40117\==1},
    {_40119==unkn->user:value(unknownflag,true);true},
    {_40189\==gen},
    {type(_40119,_40125)}.

nameq1(_40117:_40125,_40117 isa _40119,[nameq1,_40305,_40353,_40411,_40459,{},{},{}],_40271,_40275) --> 
    nr0(_40305,_40271,_40335),
    w(name(_40117,n,_40119),_40353,_40335,_40387),
    point0(_40411,_40387,_40441),
    not_look_ahead(w(name(_40195,_40197,date)),_40459,_40441,_40275),
    {_40119==unkn->user:value(unknownflag,true)},
    {number(_40117)},
    {type(_40119,_40125)}.

nameq1(_40117:_40119,_40113,[nameq1,_40227,{}],_40193,_40197) --> 
    timeq1(_40117:_40119,_40113,_40227,_40193,_40197),
    {number(_40117),_40117>=100}.

nameq1(_40117:year,_40117 isa year,[nameq1,_40243,{}],_40209,_40213) --> 
    w(nb(_40117,num),_40243,_40209,_40213),
    {number(_40117),_40117>=1900,_40117=<2099}.

date(_40117:date,_40117 isa date,[date,_40367,{},_40439,_40487,!,{},{},{},{}],_40333,_40337) --> 
    num_na(_40195,_40367,_40333,_40401),
    {_40195>=1,_40195=<7},
    slashpoint0(_40439,_40401,_40469),
    w(name(new_years_day,n,date),_40487,_40469,_40337),
    !,
    {datetime(_40237,_40239,_40241,_40243,_40245,_40247)},
    {_40239>1->_40187 is _40237+1;_40187 is _40237},
    {_40191 is _40195},
    {_40117=date(_40187,1,_40191)}.

date(_40117:date,_40117 isa date,[date,_40349,{},_40421,_40469,{},!,{}],_40315,_40319) --> 
    num_na(_40189,_40349,_40315,_40383),
    {_40189>=1,_40189=<7},
    slashpoint0(_40421,_40383,_40451),
    w(name(_40219,n,date),_40469,_40451,_40319),
    {testmember(_40219,[whitsun_day,easterday,christmas_day])},
    !,
    {named_date(_40219,date(_40255,_40257,_40259)),_40183 is _40189-1,add_days(date(_40255,_40257,_40259),_40183,_40117)}.

date(_40117:date,_40117 isa date,[date,_40261,_40319,_40367,_40425,_40473,!,{}],_40227,_40231) --> 
    dayno(_40179,_40261,_40227,_40295),
    slashpoint0(_40319,_40295,_40349),
    month(_40177,_40367,_40349,_40401),
    slashpoint0(_40425,_40401,_40455),
    year(_40175,_40473,_40455,_40231),
    !,
    {_40117=date(_40175,_40177,_40179)}.

date(_40117:date,_40117 isa date,[date,_40291,_40349,_40397,_40455,{},!,_40527,{}],_40257,_40261) --> 
    dayno(_40185,_40291,_40257,_40325),
    slashpoint(_40349,_40325,_40379),
    month(_40183,_40397,_40379,_40431),
    point0(_40455,_40431,_40485),
    {_40185>24;_40183>0},
    !,
    xyear0(_40183,_40181,_40527,_40485,_40261),
    {_40117=date(_40181,_40183,_40185)}.

date(_40117:date,_40117 isa date,[date,_40263,_40321,_40369,_40427,!,_40505,{}],_40229,_40233) --> 
    dayno(_40179,_40263,_40229,_40297),
    slashpoint0(_40321,_40297,_40351),
    monthname(_40177,_40369,_40351,_40403),
    xyear0(_40177,_40175,_40427,_40403,_40465),
    !,
    accept(_40505,_40465,_40233),
    {_40117=date(_40175,_40177,_40179)}.

date(_40117:date,_40117 isa date,[date,_40267,_40325,_40383,!,_40451,{},!,_40523],_40233,_40237) --> 
    year(_40171,_40267,_40233,_40301),
    month(_40175,_40325,_40301,_40359),
    dayno(_40179,_40383,_40359,_40417),
    !,
    accept(_40451,_40417,_40481),
    {_40117=date(_40171,_40175,_40179)},
    !,
    accept(_40523,_40481,_40237).

timeq1(_40117:clock,_40117 isa clock,[timeq1,lit(halv),_40271,{},!,_40353],_40215,_40219) --> 
    cc(halv,_40215,_40269),
    hours(_40157,_40271,_40269,_40305),
    {_40117 is _40157*100-70},
    !,
    accept(_40353,_40305,_40219).

timeq1(_40117:clock,_40117 isa clock,[timeq1,_40211,!,_40279],_40177,_40181) --> 
    time12(_40117,_40211,_40177,_40245),
    !,
    accept(_40279,_40245,_40181).

clock_sequel(_40117:clock,_40117 isa clock,[clock_sequel,_40219,!],_40185,_40189) --> 
    clock_kernel(_40117:clock,_40117 isa clock,_40219,_40185,_40189),
    !.

clock_sequel(_40117:clock,_40117 isa clock,[clock_sequel,_40307,{},_40379,_40437,_40485,{},!,{}],_40273,_40277) --> 
    w(nb(_40191,num),_40307,_40273,_40341),
    {_40191<100},
    not_look_ahead([/],_40379,_40341,_40413),
    point(_40437,_40413,_40467),
    w(nb(_40183,num),_40485,_40467,_40277),
    {_40183<100},
    !,
    {_40117 is _40191*100+_40183}.

clock_sequel(_40117:clock,_40117 isa clock,[clock_sequel,_40277,_40335,{}],_40243,_40247) --> 
    w(nb(_40153,num),_40277,_40243,_40311),
    not_look_ahead([/],_40335,_40311,_40247),
    {_40153>0,_40153<25->_40117 is _40153*100;_40117 is _40153}.

clock_kernel(_40117:clock,_40117 isa clock,[clock_kernel,_40241,{},!],_40207,_40211) --> 
    number(_40117:_40147,_40241,_40207,_40211),
    {_40117>2500,\+clock_test(_40117)},
    !.

clock_kernel(_40111,_40113,[clock_kernel,lit(nå),!,_40231],_40165,_40169) --> 
    cc(nå,_40165,_40219),
    !,
    reject(_40231,_40219,_40169).

clock_kernel(_40111,_40113,[clock_kernel,lit(en),!,_40231],_40165,_40169) --> 
    cc(en,_40165,_40219),
    !,
    reject(_40231,_40219,_40169).

clock_kernel(_40111,_40113,[clock_kernel,lit(et),!,_40231],_40165,_40169) --> 
    cc(et,_40165,_40219),
    !,
    reject(_40231,_40219,_40169).

clock_kernel(_40117:clock,_40117 isa clock,[clock_kernel,_40363,_40421,_40479,{},_40551,_40609,_40667,_40725,!,_40823],_40329,_40333) --> 
    not_look_ahead(w(name(_40191,n,route)),_40363,_40329,_40397),
    not_look_ahead(w(name(_40207,n,nightbus)),_40421,_40397,_40455),
    w(nb(_40117,num),_40479,_40455,_40513),
    {_40117>=100,clock_test(_40117)},
    not_look_ahead(w(noun(_40253,plu,_40257,_40259)),_40551,_40513,_40585),
    not_look_ahead([tusen],_40609,_40585,_40643),
    not_look_ahead([millioner],_40667,_40643,_40701),
    optional(w(noun(time,sin,def,n)),_40725,_40701,_40789),
    !,
    accept(_40823,_40789,_40333).

clock_kernel(_40111,_40113,[clock_kernel,_40215,_40273,_40321,!,_40389],_40181,_40185) --> 
    num_na(_40141,_40215,_40181,_40249),
    point0(_40273,_40249,_40303),
    monthname(_40145,_40321,_40303,_40355),
    !,
    reject(_40389,_40355,_40185).

clock_kernel(_40117:clock,_40117 isa clock,[clock_kernel,{},_40281,_40339,_40397,!,_40465],_40227,_40231) --> 
    {user:value(busflag,true)},
    hours(_40175,_40281,_40227,_40315),
    colemin0(_40179,_40339,_40315,_40373),
    w(name(_40187,_40189,month),_40397,_40373,_40431),
    !,
    reject(_40465,_40431,_40231).

clock_kernel(_40117:clock,_40117 isa clock,[clock_kernel,{},_40285,_40343,{},!,_40425],_40231,_40235) --> 
    {user:value(busflag,true)},
    hours(_40175,_40285,_40231,_40319),
    colemin0(_40179,_40343,_40319,_40377),
    {dedicated_date(date(_40191,_40175,_40179))},
    !,
    reject(_40425,_40377,_40235).

clock_kernel(_40111,_40113,[clock_kernel,_40241,_40299,_40357,{},!,_40439],_40207,_40211) --> 
    hours(_40147,_40241,_40207,_40275),
    colemin2(_40151,_40299,_40275,_40333),
    w(nb(_40159,num),_40357,_40333,_40391),
    {_40159>=60},
    !,
    reject(_40439,_40391,_40211).

clock_kernel(_40117:clock,_40117 isa clock,[clock_kernel,_40267,_40325,!,_40393,{}],_40233,_40237) --> 
    hours24(_40169,_40267,_40233,_40301),
    colemin2(_40165,_40325,_40301,_40359),
    !,
    optional(w(noun(time,sin,def,n)),_40393,_40359,_40237),
    {_40117 is _40169*100+_40165}.

clock_kernel(_40117:clock,_40117 isa clock,[clock_kernel,_40211,!,_40279],_40177,_40181) --> 
    time012(_40117,_40211,_40177,_40245),
    !,
    accept(_40279,_40245,_40181).

clock_kernel(_40117:clock,_40117 isa clock,[clock_kernel,_40199],_40165,_40169) --> 
    timeoff(_40117,_40199,_40165,_40169).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(et)],_40165,_40169) --> 
    cc(et,_40165,_40169).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(en)],_40165,_40169) --> 
    cc(en,_40165,_40169).

clock_kernel(_40117:clock,_40117 isa clock,[clock_kernel,_40311,{},_40383,_40441,{}],_40277,_40281) --> 
    w(nb(_40167,num),_40311,_40277,_40345),
    {_40167>9},
    not_look_ahead(w(noun(minute,_40193,_40195,_40197)),_40383,_40345,_40417),
    not_look_ahead([/],_40441,_40417,_40281),
    {_40167>0,_40167<25->_40117 is _40167*100;fail}.

namenb(1,[namenb,lit(ett),_40229,!,_40297],_40179,_40183) --> 
    cc(ett,_40179,_40227),
    w(noun(_40141,_40143,_40145,_40147),_40229,_40227,_40263),
    !,
    reject(_40297,_40263,_40183).

namenb(1,[namenb,lit(ett),!,_40219],_40159,_40163) --> 
    cc(ett,_40159,_40207),
    !,
    accept(_40219,_40207,_40163).

namenb(_40111,[namenb,_40183,!,_40241],_40155,_40159) --> 
    a(_40183,_40155,_40213),
    !,
    reject(_40241,_40213,_40159).

namenb(_40111,[namenb,_40183],_40155,_40159) --> 
    w(name(_40111,n,_40123),_40183,_40155,_40159).

namenb(_40111,[namenb,_40181],_40153,_40157) --> 
    w(nb(_40111,num),_40181,_40153,_40157).

dayno(_40111,[dayno,_40203,{}],_40175,_40179) --> 
    num_na(_40111,_40203,_40175,_40179),
    {_40111>0,_40111=<31}.

month(_40111,[month,_40181,!],_40153,_40157) --> 
    monthnamed(_40111,_40181,_40153,_40157),
    !.

month(_40111,[month,_40175],_40147,_40151) --> 
    monthnum(_40111,_40175,_40147,_40151).

monthnamed(_40111,[monthnamed,_40187,_40245,!],_40159,_40163) --> 
    monthname(_40111,_40187,_40159,_40221),
    point0(_40245,_40221,_40163),
    !.

monthname(_40111,[monthname,_40199,{}],_40171,_40175) --> 
    w(name(_40125,n,_40139),_40199,_40171,_40175),
    {monthnumber(_40125,_40111)}.

monthnum(_40111,[monthnum,_40209,{}],_40181,_40185) --> 
    number(_40111:_40143,_40209,_40181,_40185),
    {_40111>0,_40111=<12}.

monthnamex([monthnamex,_40161],_40139,_40143) --> 
    monthname(_40111,_40161,_40139,_40143).

monthnamex([monthnamex,_40185,{}],_40163,_40167) --> 
    w(name(_40121,_40133,_40135),_40185,_40163,_40167),
    {named_date(_40121,_40123)}.

day(_40111,[day,_40199,{}],_40171,_40175) --> 
    w(noun(_40111,_40135,_40137,_40139),_40199,_40171,_40175),
    {dayname(_40111)}.

day(weekday,[day,_40185],_40157,_40161) --> 
    w(noun(weekday,_40121,_40123,_40125),_40185,_40157,_40161).

xyear0(_40111,_40113,[xyear0,_40205,_40253,!,_40321],_40171,_40175) --> 
    aar0(_40205,_40171,_40235),
    year(_40113,_40253,_40235,_40287),
    !,
    accept(_40321,_40287,_40175).

xyear0(_40111,_40113,[xyear0,{},{}],_40175,_40175) --> 
    {this_year(_40129)},
    {adjust_year(_40111,_40129,_40113)}.

year0(_40111,[year0,_40193,_40241,!,_40309],_40165,_40169) --> 
    aar0(_40193,_40165,_40223),
    year(_40111,_40241,_40223,_40275),
    !,
    accept(_40309,_40275,_40169).

year0(_40111,[year0,{}],_40151,_40151) --> 
    {this_year(_40111)}.

aar0([aar0,_40183,_40231,!],_40161,_40165) --> 
    point0(_40183,_40161,_40213),
    w(noun(year,_40129,_40131,n),_40231,_40213,_40165),
    !.

aar0([aar0,_40157],_40135,_40139) --> 
    point0(_40157,_40135,_40139).

year(_40111,[year,{},_40263,{},!,_40345],_40215,_40219) --> 
    {user:value(busflag,true)},
    number(_40111:_40161,_40263,_40215,_40297),
    {_40111>=2000,_40111=<9999},
    !,
    accept(_40345,_40297,_40219).

year(_40111,[year,_40221,{},!,_40303],_40193,_40197) --> 
    number(_40111:_40139,_40221,_40193,_40255),
    {_40111>=1000,_40111=<9999},
    !,
    accept(_40303,_40255,_40197).

year(_40111,[year,_40243,{},!,_40325,{}],_40215,_40219) --> 
    number(_40149:_40161,_40243,_40215,_40277),
    {_40149>=0,_40149=<99},
    !,
    accept(_40325,_40277,_40219),
    {_40111 is _40149+2000}.

timexp(_40111,[timexp,_40181,_40229],_40153,_40157) --> 
    clock0(_40181,_40153,_40211),
    time2(_40111,_40229,_40211,_40157).

timexp(_40111,[timexp,_40181,_40229],_40153,_40157) --> 
    clock0(_40181,_40153,_40211),
    time1(_40111,_40229,_40211,_40157).

timenexp(_40111,[timenexp,_40181,_40229],_40153,_40157) --> 
    clock(_40181,_40153,_40211),
    time2(_40111,_40229,_40211,_40157).

timenexp(_40111,[timenexp,_40181,_40229],_40153,_40157) --> 
    clock(_40181,_40153,_40211),
    time1(_40111,_40229,_40211,_40157).

clock_time(1300,[clock_time,_40183,!,_40241],_40155,_40159) --> 
    a(_40183,_40155,_40213),
    !,
    accept(_40241,_40213,_40159).

clock_time(1300,[clock_time,lit(nå),!,_40219],_40159,_40163) --> 
    cc(nå,_40159,_40207),
    !,
    reject(_40219,_40207,_40163).

clock_time(_40111,[clock_time,_40225,_40283,{},_40355],_40197,_40201) --> 
    hours(_40139,_40225,_40197,_40259),
    colemin0(_40143,_40283,_40259,_40317),
    {_40133 is _40139*100+_40143},
    ampm0(_40133,_40111,_40355,_40317,_40201).

clock_time(_40111,[clock_time,_40175],_40147,_40151) --> 
    time12(_40111,_40175,_40147,_40151).

time012(_40111,[time012,_40175],_40147,_40151) --> 
    time12(_40111,_40175,_40147,_40151).

time012(_40111,[time012,_40281,{},_40353,_40411,{}],_40253,_40257) --> 
    w(nb(_40161,num),_40281,_40253,_40315),
    {_40161>1},
    not_look_ahead(w(noun(minute,_40197,_40199,_40201)),_40353,_40315,_40387),
    not_look_ahead([/],_40411,_40387,_40257),
    {_40161>0,_40161<25,_40111 is _40161*100}.

time012(100,[time012,_40207,_40265,_40323,!],_40179,_40183) --> 
    w(nb(1,num),_40207,_40179,_40241),
    not_look_ahead([/],_40265,_40241,_40299),
    not_look_ahead_np(_40323,_40299,_40183),
    !.

time12(_40111,[time12,_40195,_40253],_40167,_40171) --> 
    time2(_40111,_40195,_40167,_40229),
    w(noun(time,sin,def,n),_40253,_40229,_40171).

time12(_40111,[time12,_40175],_40147,_40151) --> 
    time2(_40111,_40175,_40147,_40151).

time12(_40111,[time12,_40201,_40259,_40307],_40173,_40177) --> 
    time1(_40111,_40201,_40173,_40235),
    point0(_40259,_40235,_40289),
    w(noun(time,sin,def,n),_40307,_40289,_40177).

timeoff(_40111,[timeoff,_40263,{},_40335,_40383,{},{}],_40235,_40239) --> 
    w(nb(_40165,num),_40263,_40235,_40297),
    {_40165<100},
    colon0(_40335,_40297,_40365),
    w(nb(_40157,num),_40383,_40365,_40239),
    {_40157<100},
    {_40111 is _40165*100+_40157}.

time1(_40111,[time1,_40193,!,_40261],_40165,_40169) --> 
    w(nb(0,_40133),_40193,_40165,_40227),
    !,
    reject(_40261,_40227,_40169).

time1(_40111,[time1,lit(ett),_40253,_40311,!,_40379],_40203,_40207) --> 
    cc(ett,_40203,_40251),
    not_look_ahead(w(noun(time,_40153,def,_40157)),_40253,_40251,_40287),
    w(noun(_40165,_40167,_40169,_40171),_40311,_40287,_40345),
    !,
    reject(_40379,_40345,_40207).

time1(100,[time1,lit(ett),_40233,!,_40331],_40183,_40187) --> 
    cc(ett,_40183,_40231),
    optional(w(noun(time,_40147,def,_40151)),_40233,_40231,_40297),
    !,
    accept(_40331,_40297,_40187).

time1(_40111,[time1,_40207,_40255,!,_40323],_40179,_40183) --> 
    a(_40207,_40179,_40237),
    not_look_ahead(w(noun(time,_40143,def,_40147)),_40255,_40237,_40289),
    !,
    reject(_40323,_40289,_40183).

time1(_40111,[time1,_40199,_40257,!,_40335],_40171,_40175) --> 
    time3(_40133,_40199,_40171,_40233),
    ampm0(_40133,_40111,_40257,_40233,_40295),
    !,
    accept(_40335,_40295,_40175).

time1(_40111,[time1,_40275,_40333,_40391,{},!,{},_40487],_40247,_40251) --> 
    w(nb(_40161,num),_40275,_40247,_40309),
    not_look_ahead(w(noun(hour,_40177,_40179,_40181)),_40333,_40309,_40367),
    not_look_ahead([t],_40391,_40367,_40425),
    {_40161<25},
    !,
    {_40151 is _40161*100},
    ampm0(_40151,_40111,_40487,_40425,_40251).

time1(now,[time1,lit(nå),lit(av),!,_40251],_40169,_40173) --> 
    cc(nå,_40169,_40217),
    cc(av,_40217,_40239),
    !,
    reject(_40251,_40239,_40173).

time1(now,[time1,lit(nå)],_40147,_40151) --> 
    cc(nå,_40147,_40151).

time2(_40111,[time2,_40275,{},_40347,_40395,{},!,_40477,{}],_40247,_40251) --> 
    hours24(_40173,_40275,_40247,_40309),
    {_40173=<25},
    point(_40347,_40309,_40377),
    num(_40169,_40395,_40377,_40429),
    {_40169>12,_40169<60},
    !,
    accept(_40477,_40429,_40251),
    {_40111 is _40173*100+_40169}.

time2(_40111,[time2,_40243,_40301,!,{},_40383,{}],_40215,_40219) --> 
    num(_40157,_40243,_40215,_40277),
    w(prep(over),_40301,_40277,_40335),
    !,
    {_40157<60},
    hours30(_40155,_40383,_40335,_40219),
    {_40111 is _40155+_40157}.

time2(_40111,[time2,_40241,_40299,_40347,!,{},_40419,{}],_40213,_40217) --> 
    num(_40163,_40241,_40213,_40275),
    minutes(_40299,_40275,_40329),
    overclock(_40347,_40329,_40377),
    !,
    {_40163<60},
    hours30(_40161,_40419,_40377,_40217),
    {_40111 is _40161+_40163}.

time2(_40111,[time2,_40239,{},_40311,!,_40379,{}],_40211,_40215) --> 
    num(_40151,_40239,_40211,_40273),
    {_40151<60},
    w(prep(on),_40311,_40273,_40345),
    !,
    hours30(_40149,_40379,_40345,_40215),
    {subfromtime(_40149,_40151,_40111)}.

time2(_40111,[time2,_40243,_40301,_40349,!,{},_40421,_40469,{}],_40215,_40219) --> 
    num(_40163,_40243,_40215,_40277),
    minutes(_40301,_40277,_40331),
    onclock(_40349,_40331,_40379),
    !,
    {_40163<60},
    clock0(_40421,_40379,_40451),
    hours30(_40161,_40469,_40451,_40219),
    {subfromtime(_40161,_40163,_40111)}.

time2(_40111,[time2,_40255,lit(halv),_40365,{},_40437],_40227,_40231) --> 
    optional(w(prep(in)),_40255,_40227,_40319),
    cc(halv,_40319,_40363),
    hours100(_40173,_40365,_40363,_40399),
    {_40111 is _40173-100+30},
    optional(w(noun(time,sin,def,n)),_40437,_40399,_40231).

time2(_40111,[time2,lit(halv),_40245,!,_40313,{}],_40195,_40199) --> 
    cc(halv,_40195,_40243),
    prep1(over,_40245,_40243,_40279),
    !,
    hours100(_40149,_40313,_40279,_40199),
    {_40111 is _40149+30}.

time2(_40111,[time2,lit(kvart),_40241,_40289,{}],_40191,_40195) --> 
    cc(kvart,_40191,_40239),
    onclock(_40241,_40239,_40271),
    hours100(_40153,_40289,_40271,_40195),
    {_40111 is _40153-100+45}.

time2(_40111,[time2,lit(kvart),_40241,_40289,{}],_40191,_40195) --> 
    cc(kvart,_40191,_40239),
    overclock(_40241,_40239,_40271),
    hours(_40153,_40289,_40271,_40195),
    {_40111 is _40153*100+15}.

time2(_40111,[time2,_40229,_40287,_40345,{},!,_40427],_40201,_40205) --> 
    hours(_40145,_40229,_40201,_40263),
    minutes(_40149,_40287,_40263,_40321),
    number(_40157:_40159,_40345,_40321,_40379),
    {_40157>24},
    !,
    reject(_40427,_40379,_40205).

time2(_40111,[time2,_40215,_40273,_40331,!,_40399],_40187,_40191) --> 
    hours(_40139,_40215,_40187,_40249),
    minutes(_40143,_40273,_40249,_40307),
    w(name(_40151,_40153,month),_40331,_40307,_40365),
    !,
    reject(_40399,_40365,_40191).

time2(_40111,[time2,_40225,_40283,{},_40355],_40197,_40201) --> 
    hours24(_40139,_40225,_40197,_40259),
    colemin(_40143,_40283,_40259,_40317),
    {_40133 is _40139*100+_40143},
    ampm0(_40133,_40111,_40355,_40317,_40201).

time2(_40111,[time2,_40213,_40271,_40329,_40377,!,_40445],_40185,_40189) --> 
    hours(_40145,_40213,_40185,_40247),
    minutes(_40149,_40271,_40247,_40305),
    point(_40329,_40305,_40359),
    minutes(_40153,_40377,_40359,_40411),
    !,
    reject(_40445,_40411,_40189).

time2(_40111,[time2,_40241,_40299,{},{},_40385],_40213,_40217) --> 
    hours24(_40145,_40241,_40213,_40275),
    minutes(_40149,_40299,_40275,_40333),
    {_40149>12},
    {_40139 is _40145*100+_40149},
    ampm0(_40139,_40111,_40385,_40333,_40217).

onclock([onclock,_40195,{},_40267],_40173,_40177) --> 
    w(prep(_40127),_40195,_40173,_40229),
    {testmember(_40127,[on,before])},
    clock0(_40267,_40229,_40177).

overclock([overclock,_40195,{},_40267],_40173,_40177) --> 
    w(prep(_40127),_40195,_40173,_40229),
    {testmember(_40127,[over,after])},
    clock0(_40267,_40229,_40177).

hours30(_40111,[hours30,lit(halv),_40247,{},!,_40329],_40197,_40201) --> 
    cc(halv,_40197,_40245),
    hours(_40143,_40247,_40245,_40281),
    {_40111 is _40143*100-70},
    !,
    accept(_40329,_40281,_40201).

hours30(_40111,[hours30,_40175],_40147,_40151) --> 
    hours100(_40111,_40175,_40147,_40151).

hours100(_40111,[hours100,_40197,_40255,!,_40323],_40169,_40173) --> 
    num(_40111,_40197,_40169,_40231),
    monthname(_40137,_40255,_40231,_40289),
    !,
    reject(_40323,_40289,_40173).

hours100(_40111,[hours100,_40239,{},!,_40321],_40211,_40215) --> 
    num(_40111,_40239,_40211,_40273),
    {_40111 is _40111//100*100,_40111>100,_40111<2500},
    !,
    accept(_40321,_40273,_40215).

hours100(_40111,[hours100,_40197,{}],_40169,_40173) --> 
    hours(_40131,_40197,_40169,_40173),
    {_40111 is _40131*100}.

hours100(100,[hours100,lit(ett),!,_40219],_40159,_40163) --> 
    cc(ett,_40159,_40207),
    !,
    accept(_40219,_40207,_40163).

hours100(1300,[hours100,lit(et),!,_40219],_40159,_40163) --> 
    cc(et,_40159,_40207),
    !,
    accept(_40219,_40207,_40163).

time3(_40111,[time3,_40197,{}],_40169,_40173) --> 
    w(nb(_40111,num),_40197,_40169,_40173),
    {_40111>=60}.

ampm0(_40111,_40111,[ampm0,_40195,!,_40253],_40161,_40165) --> 
    amtime(_40195,_40161,_40225),
    !,
    accept(_40253,_40225,_40165).

ampm0(_40111,_40113,[ampm0,_40235,!,{}],_40201,_40205) --> 
    pmtime(_40235,_40201,_40205),
    !,
    {_40111>1200->_40113 is _40111;_40113 is _40111+1200}.

ampm0(_40111,_40111,[ampm0,lit(h),!],_40159,_40163) --> 
    cc(h,_40159,_40163),
    !.

ampm0(_40111,_40111,[ampm0,[]],_40149,_40149) --> 
    [].

amtime([amtime,lit(am)],_40139,_40143) --> 
    cc(am,_40139,_40143).

amtime([amtime,lit(a),lit(m)],_40149,_40153) --> 
    cc(a,_40149,_40191),
    cc(m,_40191,_40153).

pmtime([pmtime,lit(pm)],_40139,_40143) --> 
    cc(pm,_40139,_40143).

pmtime([pmtime,lit(p),lit(m)],_40149,_40153) --> 
    cc(p,_40149,_40191),
    cc(m,_40191,_40153).

hours24(_40111,[hours24,_40175],_40147,_40151) --> 
    hours(_40111,_40175,_40147,_40151).

hours(_40111,[hours,_40211,_40269,_40327,!,_40385],_40183,_40187) --> 
    not_look_ahead([ett],_40211,_40183,_40245),
    not_look_ahead([et],_40269,_40245,_40303),
    a(_40327,_40303,_40357),
    !,
    reject(_40385,_40357,_40187).

hours(_40111,[hours,_40211,{},_40283],_40183,_40187) --> 
    w(nb(_40111,num),_40211,_40183,_40245),
    {_40111=<25},
    optional([h],_40283,_40245,_40187).

smallhours(_40111,[smallhours,_40209,{}],_40181,_40185) --> 
    w(nb(_40111,num),_40209,_40181,_40185),
    {_40111>31,_40111=<59}.

minutes0([minutes0,_40169,!,_40227],_40147,_40151) --> 
    minutes(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

minutes0([minutes0,[]],_40135,_40135) --> 
    [].

minutes([minutes,_40183,!,_40251],_40161,_40165) --> 
    w(noun(minute,_40129,_40131,_40133),_40183,_40161,_40217),
    !,
    accept(_40251,_40217,_40165).

colemin0(_40111,[colemin0,_40187,!,_40255],_40159,_40163) --> 
    colemin(_40111,_40187,_40159,_40221),
    !,
    accept(_40255,_40221,_40163).

colemin0(_40111,[colemin0,_40193,_40241,!,_40309],_40165,_40169) --> 
    point0(_40193,_40165,_40223),
    minutes0(_40111,_40241,_40223,_40275),
    !,
    accept(_40309,_40275,_40169).

colemin2(_40111,[colemin2,_40203,_40261,_40309,!,_40377],_40175,_40179) --> 
    minutes(_40139,_40203,_40175,_40237),
    point(_40261,_40237,_40291),
    minutes(_40143,_40309,_40291,_40343),
    !,
    reject(_40377,_40343,_40179).

colemin2(_40111,[colemin2,_40199,_40247,_40305,!,_40363],_40171,_40175) --> 
    colon(_40199,_40171,_40229),
    minutes(_40111,_40247,_40229,_40281),
    colesec0(_40305,_40281,_40335),
    !,
    accept(_40363,_40335,_40175).

colemin2(_40111,[colemin2,_40199,_40247,!,_40315],_40171,_40175) --> 
    colon(_40199,_40171,_40229),
    w(nb(_40111,num),_40247,_40229,_40281),
    !,
    reject(_40315,_40281,_40175).

colemin2(0,[colemin2,_40183,!,_40241],_40155,_40159) --> 
    colon(_40183,_40155,_40213),
    !,
    accept(_40241,_40213,_40159).

colemin2(_40111,[colemin2,_40193,_40241,_40299,!],_40165,_40169) --> 
    point0(_40193,_40165,_40223),
    minutes(_40111,_40241,_40223,_40275),
    point0(_40299,_40275,_40169),
    !.

colemin2(_40111,[colemin2,_40187,_40245,!],_40159,_40163) --> 
    minutes(_40111,_40187,_40159,_40221),
    point0(_40245,_40221,_40163),
    !.

colemin(_40111,[colemin,_40219,{},_40291,_40339,!,_40407],_40191,_40195) --> 
    minutes(_40145,_40219,_40191,_40253),
    {_40145\==0},
    point(_40291,_40253,_40321),
    minutes(_40159,_40339,_40321,_40373),
    !,
    reject(_40407,_40373,_40195).

colemin(_40111,[colemin,_40199,_40247,!,_40315,_40363],_40171,_40175) --> 
    colon(_40199,_40171,_40229),
    minutes(_40111,_40247,_40229,_40281),
    !,
    accept(_40315,_40281,_40345),
    colesec0(_40363,_40345,_40175).

colemin(_40111,[colemin,_40221,_40269,{},!,_40351],_40193,_40197) --> 
    point(_40221,_40193,_40251),
    minutes(_40111,_40269,_40251,_40303),
    {_40111=0;_40111>12},
    !,
    colesec0(_40351,_40303,_40197).

colemin(_40111,[colemin,_40199,_40247,!,_40315],_40171,_40175) --> 
    colon(_40199,_40171,_40229),
    w(nb(_40111,num),_40247,_40229,_40281),
    !,
    reject(_40315,_40281,_40175).

colemin(0,[colemin,_40183,!,_40241],_40155,_40159) --> 
    colon(_40183,_40155,_40213),
    !,
    accept(_40241,_40213,_40159).

colesec0([colesec0,lit(:),_40199,!],_40155,_40159) --> 
    cc(:,_40155,_40197),
    minutes(_40127,_40199,_40197,_40159),
    !.

colesec0([colesec0,[]],_40135,_40135) --> 
    [].

minutes0(_40111,[minutes0,_40187,!,_40255],_40159,_40163) --> 
    minutes(_40111,_40187,_40159,_40221),
    !,
    accept(_40255,_40221,_40163).

minutes0(0,[minutes0,[]],_40143,_40143) --> 
    [].

minutes(_40111,[minutes,_40183,!,_40241],_40155,_40159) --> 
    a(_40183,_40155,_40213),
    !,
    reject(_40241,_40213,_40159).

minutes(_40111,[minutes,_40197,{}],_40169,_40173) --> 
    w(nb(_40111,num),_40197,_40169,_40173),
    {_40111<100}.

nameq2(_40117:_40125,_40117 isa number,[nameq2,_40229,_40287,_40335,!,_40393],_40195,_40199) --> 
    number(_40117:_40125,_40229,_40195,_40263),
    point0(_40287,_40263,_40317),
    monthnamex(_40335,_40317,_40365),
    !,
    reject(_40393,_40365,_40199).

nameq2(_40111,_40113,[nameq2,_40215,_40263,!,_40331],_40181,_40185) --> 
    one(_40215,_40181,_40245),
    w(noun(_40139,sin,u,n),_40263,_40245,_40297),
    !,
    reject(_40331,_40297,_40185).

nameq2(_40117:_40119,_40117 isa _40119,[nameq2,_40273,_40331,{},_40393,{},!],_40239,_40243) --> 
    number(_40117:_40165,_40273,_40239,_40307),
    point(_40331,_40307,_40361),
    {\+_40117=1},
    w(noun(_40119,sin,u,n),_40393,_40361,_40243),
    {alignable(_40119,number)},
    !.

nameq2(_40117:_40125,_40117 isa clock,[nameq2,{},_40271,{},{},!],_40223,_40227) --> 
    {type(clock,_40125)},
    number(_40117:_40169,_40271,_40223,_40227),
    {_40117>=1000},
    {clock_test(_40117)},
    !.

nameq2(_40117:_40125,_40117 isa number,[nameq2,_40205],_40171,_40175) --> 
    number(_40117:_40125,_40205,_40171,_40175).

number(_40115:number,[number,_40263,lit('.'),_40343,{},!,{}],_40235,_40239) --> 
    num(_40167,_40263,_40235,_40297),
    cc('.',_40297,_40341),
    num(_40163,_40343,_40341,_40239),
    {_40163>=100,_40163<1000},
    !,
    {_40115 is _40167*1000+_40163}.

number(2:_40117,[number,_40213,_40261,{}],_40185,_40189) --> 
    a(_40213,_40185,_40243),
    w(noun(pair,_40149,_40151,_40153),_40261,_40243,_40189),
    {type(number,_40117)}.

number(_40115:_40117,[number,_40235,_40283,{},_40355,{}],_40207,_40211) --> 
    only0(_40235,_40207,_40265),
    num(_40155,_40283,_40265,_40317),
    {type(number,_40117)},
    thousands0(_40157,_40355,_40317,_40211),
    {_40115 is _40155*_40157}.

number(_40111,[number,_40207,_40255,!,_40323],_40179,_40183) --> 
    a(_40207,_40179,_40237),
    not_look_ahead(w(noun(time,_40143,def,_40147)),_40255,_40237,_40289),
    !,
    reject(_40323,_40289,_40183).

thousands0(1000,[thousands0,_40177,!],_40149,_40153) --> 
    tusen(_40177,_40149,_40153),
    !.

thousands0(1000000,[thousands0,_40177,!],_40149,_40153) --> 
    million(_40177,_40149,_40153),
    !.

thousands0(1000000000,[thousands0,_40177,!],_40149,_40153) --> 
    milliard(_40177,_40149,_40153),
    !.

thousands0(1,[thousands0,[]],_40143,_40143) --> 
    [].

tusen([tusen,lit(tusen)],_40139,_40143) --> 
    cc(tusen,_40139,_40143).

tusen([tusen,lit(tusener)],_40139,_40143) --> 
    cc(tusener,_40139,_40143).

million([million,lit(million)],_40139,_40143) --> 
    cc(million,_40139,_40143).

million([million,lit(millioner)],_40139,_40143) --> 
    cc(millioner,_40139,_40143).

milliard([milliard,lit(milliard)],_40139,_40143) --> 
    cc(milliard,_40139,_40143).

milliard([milliard,lit(milliarder)],_40139,_40143) --> 
    cc(milliarder,_40139,_40143).

anumber(_40111,[anumber,_40193,_40241,!,_40309],_40165,_40169) --> 
    a0(_40193,_40165,_40223),
    number(_40111,_40241,_40223,_40275),
    !,
    accept(_40309,_40275,_40169).

anumber(1:_40117,[anumber,_40199,!,{}],_40171,_40175) --> 
    art1(_40199,_40171,_40175),
    !,
    {type(number,_40117)}.

intrans_verb(work,_40113,id,_40117,_40119,_40121,_40123,[intrans_verb,_40287,_40375,{}],_40223,_40227) --> 
    lexv(tv,hold,_40121,_40123,_40287,_40223,_40333),
    w(prep(on),_40375,_40333,_40227),
    {iv_template(work,_40113,_40117,_40119)}.

intrans_verb(be1,_40113,id,_40117,_40119,_40121,_40123,[intrans_verb,_40287,_40375,{}],_40223,_40227) --> 
    lexv(tv,hold,_40121,_40123,_40287,_40223,_40333),
    w(prep(to),_40375,_40333,_40227),
    {iv_template(be1,_40113,_40117,_40119)}.

intrans_verb(_40111,_40113,id,_40117,_40119,_40121,_40123,[intrans_verb,_40273,{}],_40209,_40213) --> 
    lexv(iv,_40111,_40121,_40123,_40273,_40209,_40213),
    {iv_template(_40111,_40113,_40117,_40119)}.

intrans_verb(be1,_40113,_40115,_40117,_40119,pres,fin,[intrans_verb,_40311,_40369,_40427,{}],_40247,_40251) --> 
    not_look_ahead(w(verb(go,_40169,fin)),_40311,_40247,_40345),
    be1(_40115,_40369,_40345,_40403),
    not_look_ahead(w(verb(_40187,_40189,_40191)),_40427,_40403,_40251),
    {iv_template(be1,_40113,_40117,_40119)}.

intrans_verb(_40111,_40113,_40115,_40117,_40119,past,fin,[intrans_verb,_40289,_40347,_40395,{}],_40225,_40229) --> 
    has(_40115,_40289,_40225,_40323),
    now0(_40347,_40323,_40377),
    lexv(iv,_40111,past,part,_40395,_40377,_40229),
    {iv_template(_40111,_40113,_40117,_40119)}.

trans_verbs(_40111,_40113,_40115,_40117,_40119,[trans_verbs,_40257,_40385],_40205,_40209) --> 
    trans_verb(_40129,_40113,_40115,id,_40117,_40153,_40155,_40157,_40257,_40205,_40319),
    trans_verbs0(_40129,_40111,_40113,_40115,_40117,_40119,_40385,_40319,_40209).

trans_verbs0(_40111,_40113,_40115,_40117,_40119,_40121,[trans_verbs0,_40281,_40329,_40457],_40223,_40227) --> 
    andor(_40281,_40223,_40311),
    trans_verb(_40151,_40115,_40117,id,_40119,_40161,_40163,_40165,_40329,_40311,_40391),
    trans_verbs0((_40111,_40151),_40113,_40115,_40117,_40119,_40121,_40457,_40391,_40227).

trans_verbs0(_40111,_40111,_40131:_40133,_40137:_40139,_40119,_40111/_40131/_40137/_40119,[trans_verbs0,[]],_40203,_40203) --> 
    [].

trans_verb(tell,_40113,_40115,id,_40119,_40121,_40123,fin,[trans_verb,_40297,_40385,{}],_40227,_40231) --> 
    lexv(tv,tell,_40123,fin,_40297,_40227,_40343),
    particle0(tell,_40385,_40343,_40231),
    {tv_template(tell,_40113,_40115,_40119,_40121)}.

trans_verb(_40111,_40113,_40115,_40117,_40119,_40121,past,fin,[trans_verb,_40297,_40355,{}],_40227,_40231) --> 
    has(_40117,_40297,_40227,_40331),
    lexv(tv,_40111,past,part,_40355,_40331,_40231),
    {tv_template(_40111,_40113,_40115,_40119,_40121)}.

trans_verb(_40111,_40113,_40115,id,_40119,_40121,_40123,_40125,[trans_verb,_40287,{}],_40217,_40221) --> 
    lexv(tv,_40111,_40123,_40125,_40287,_40217,_40221),
    {tv_template(_40111,_40113,_40115,_40119,_40121)}.

rep_v(be_free,pres,fin,[rep_v,_40205],_40165,_40169) --> 
    w(adj2(free,nil),_40205,_40165,_40169).

rep_v(_40111,_40113,_40115,[rep_v,_40231,_40279,_40367,_40425],_40191,_40195) --> 
    aux0(_40231,_40191,_40261),
    lexv(rv,_40111,_40113,_40115,_40279,_40261,_40325),
    reflexiv0(_40111,_40367,_40325,_40401),
    rep_particlev0(_40111,_40425,_40401,_40195).

rep_v(want,pres,fin,[rep_v,lit(skal),!,_40243],_40171,_40175) --> 
    cc(skal,_40171,_40231),
    !,
    reject(_40243,_40231,_40175).

there_be_modal(think,[there_be_modal,_40199,_40247,lit(an)],_40171,_40175) --> 
    thereit(_40199,_40171,_40229),
    w(verb(go,_40137,_40139),_40247,_40229,_40281),
    cc(an,_40281,_40175).

there_be_modal(_40111,[there_be_modal,_40181,_40229],_40153,_40157) --> 
    thereit(_40181,_40153,_40211),
    be_modal(_40111,_40229,_40211,_40157).

be_there_modal(_40111,[be_there_modal,_40187,_40235,_40283],_40159,_40163) --> 
    be(_40187,_40159,_40217),
    thereit(_40235,_40217,_40265),
    be_modal(_40111,_40283,_40265,_40163).

be_modal(_40111,[be_modal,_40181,_40229],_40153,_40157) --> 
    be(_40181,_40153,_40211),
    modal(_40111,_40229,_40211,_40157).

be_modal(seem,[be_modal,_40183],_40155,_40159) --> 
    w(verb(seem,_40121,fin),_40183,_40155,_40159).

modal(_40111,[modal,_40189,_40267],_40161,_40165) --> 
    rep_v(_40111,past,part,_40189,_40161,_40231),
    tobetrue(_40121,_40267,_40231,_40165).

modal(_40111,[modal,_40179],_40151,_40155) --> 
    rep_v(_40111,_40117,fin,_40179,_40151,_40155).

modal(think,[modal,_40181],_40153,_40157) --> 
    w(adj2(possible,nil),_40181,_40153,_40157).

modal(think,[modal,_40181],_40153,_40157) --> 
    w(adj2(best,nil),_40181,_40153,_40157).

modal(free,[modal,_40181],_40153,_40157) --> 
    w(adj2(free,nil),_40181,_40153,_40157).

tobetrue(_40111,[tobetrue,_40181,_40229],_40153,_40157) --> 
    infinitive(_40181,_40153,_40211),
    be_truefalse(_40111,_40229,_40211,_40157).

tobetrue(id,[tobetrue,[]],_40143,_40143) --> 
    [].

pvimodal(_40111,_40113,[pvimodal,_40225,{},{}],_40191,_40195) --> 
    lexv(tv,_40111,_40143,fin,_40225,_40191,_40195),
    {_40111\==be},
    {pvi_templ(_40111,_40113)}.

lexvaccept(_40111,_40113,_40115,_40117,_40119,[lexvaccept,_40237,!],_40185,_40189) --> 
    hlexv(_40111,_40113,_40115,_40117,_40119,_40237,_40185,_40189),
    !.

hlexv(_40111,_40113,_40115,_40117,_40119,[hlexv,_40303,_40351,_40409,_40467,{},_40549,{}],_40251,_40255) --> 
    aux0(_40303,_40251,_40333),
    negation0(_40163,_40351,_40333,_40385),
    w(verb(_40179,_40115,_40117),_40409,_40385,_40443),
    particlev0(_40179,_40113,_40467,_40443,_40505),
    {verbtype(_40113,_40111)},
    negation0(_40165,_40549,_40505,_40255),
    {bigno(_40163,_40165,_40119)}.

hlexv(iv,_40113,_40115,fin,_40119,[hlexv,_40265,_40323,_40371,_40429,!],_40213,_40217) --> 
    w(verb(be,_40115,fin),_40265,_40213,_40299),
    now0(_40323,_40299,_40353),
    negation0(_40119,_40371,_40353,_40405),
    particlev2(be,_40113,_40429,_40405,_40217),
    !.

hlexv(_40111,_40113,past,fin,_40119,[hlexv,_40261,_40309,_40357,_40415,_40503],_40209,_40213) --> 
    has(_40261,_40209,_40291),
    danow0(_40309,_40291,_40339),
    negation0(_40119,_40357,_40339,_40391),
    lexv(_40111,_40113,past,part,_40415,_40391,_40461),
    reflexiv0(_40113,_40503,_40461,_40213).

hlexv(tv,bring,_40115,_40117,id,[hlexv,_40251,_40309,_40367],_40199,_40203) --> 
    w(verb(have,_40115,_40117),_40251,_40199,_40285),
    prep1(with,_40309,_40285,_40343),
    reflexiv0(have,_40367,_40343,_40203).

hlexv(_40111,_40113,past,fin,_40119,[hlexv,_40275,_40333,_40391,{}],_40223,_40227) --> 
    w(verb(get,_40157,fin),_40275,_40223,_40309),
    negation0(_40119,_40333,_40309,_40367),
    w(verb(_40113,past,part),_40391,_40367,_40227),
    {verbtype(_40113,_40111)}.

hlexv(_40111,_40113,_40115,fin,_40119,[hlexv,_40291,_40349,_40407,{},!],_40239,_40243) --> 
    w(verb(get,_40115,fin),_40291,_40239,_40325),
    negation0(_40119,_40349,_40325,_40383),
    lexv(_40111,_40113,_40167,_40169,_40407,_40383,_40243),
    {_40167\==imp,_40169\=fin},
    !.

hlexv(_40111,_40113,past,fin,_40119,[hlexv,_40269,_40327,_40375,_40433,!],_40217,_40221) --> 
    w(verb(be,_40153,fin),_40269,_40217,_40303),
    now0(_40327,_40303,_40357),
    negation0(_40119,_40375,_40357,_40409),
    lexv(_40111,_40113,past,part,_40433,_40409,_40221),
    !.

hlexv(_40111,_40113,past,fin,_40119,[hlexv,_40251,_40299,_40347,_40405],_40199,_40203) --> 
    has(_40251,_40199,_40281),
    redundant0(_40299,_40281,_40329),
    negation0(_40119,_40347,_40329,_40381),
    lexv(_40111,_40113,past,part,_40405,_40381,_40203).

hlexv(_40111,know1,_40115,_40117,_40119,[hlexv,_40313,_40371,_40429,{},!,{}],_40261,_40265) --> 
    w(verb(know,_40115,_40117),_40313,_40261,_40347),
    negation0(_40119,_40371,_40347,_40405),
    look_ahead([_40181],_40429,_40405,_40265),
    {testmember(_40181,[hva,hvem,hvilken,hvilket,hvilke])},
    !,
    {_40111=tv}.

hlexv(tv,know1,_40115,_40117,_40119,[hlexv,_40251,_40309,lit(om)],_40199,_40203) --> 
    w(verb(know,_40115,_40117),_40251,_40199,_40285),
    negation0(_40119,_40309,_40285,_40343),
    cc(om,_40343,_40203).

hlexv(tv,_40113,_40115,fin,_40119,[hlexv,_40301,_40359,_40417,_40465,_40533,!,[]],_40249,_40253) --> 
    w(verb(get,_40115,fin),_40301,_40249,_40335),
    negation0(_40119,_40359,_40335,_40393),
    look_ahead_np(_40417,_40393,_40447),
    np1_accept(_40165,_40167,_40465,_40447,_40503),
    w(verb(_40113,past,part),_40533,_40503,_40567),
    !,
    pushstack(free,xnp(_40165,_40167),nil,_40567,_40253),
    [].

hlexv(tv,get,pres,fin,_40119,[hlexv,lit(får),_40297,_40355,_40413,!],_40223,_40227) --> 
    cc(får,_40223,_40295),
    not_look_ahead(w(verb(_40159,inf,_40163)),_40297,_40295,_40331),
    negation0(_40119,_40355,_40331,_40389),
    optional([opp],_40413,_40389,_40227),
    !.

hlexv(iv,_40113,_40115,_40117,_40119,[hlexv,_40295,{},{},_40387,_40445],_40243,_40247) --> 
    w(verb(_40113,_40115,_40117),_40295,_40243,_40329),
    {rv_templ(_40113,_40173)},
    {semantic:tv_templ(_40113,_40189,nil)},
    negation0(_40119,_40387,_40329,_40421),
    look_ahead([om],_40445,_40421,_40247).

hlexv(_40111,_40113,_40115,_40117,_40119,[hlexv,_40317,{},_40389,_40447,!,{}],_40265,_40269) --> 
    w(verb(_40113,_40115,_40117),_40317,_40265,_40351),
    {testmember(_40113,[understand,believe,know])},
    negation0(_40119,_40389,_40351,_40423),
    look_ahead_lit([at,hvordan,hvorfor,når],_40447,_40423,_40269),
    !,
    {_40111=rv}.

hlexv(_40111,_40113,_40115,_40117,_40119,[hlexv,_40283,{},_40355,!,{}],_40231,_40235) --> 
    w(verb(_40113,_40115,_40117),_40283,_40231,_40317),
    {testmember(_40113,[believe])},
    negation0(_40119,_40355,_40317,_40235),
    !,
    {_40111=rv}.

hlexv(_40111,_40113,_40115,_40117,_40119,[hlexv,_40283,{},_40355,!,{}],_40231,_40235) --> 
    w(verb(_40113,_40115,_40117),_40283,_40231,_40317),
    {testmember(_40113,[understand])},
    negation0(_40119,_40355,_40317,_40235),
    !,
    {_40111=tv}.

hlexv(rv,_40113,_40115,_40117,_40119,[hlexv,{},_40331,_40419,_40477,_40535,_40593,!,_40661],_40259,_40263) --> 
    {user:value(textflag,true)},
    lexv(rv,_40113,_40115,_40117,_40331,_40259,_40377),
    negation0(_40119,_40419,_40377,_40453),
    not_look_ahead([det],_40477,_40453,_40511),
    not_look_ahead([hva],_40535,_40511,_40569),
    rep_particlev0(_40113,_40593,_40569,_40627),
    !,
    accept(_40661,_40627,_40263).

hlexv(tv,know1,pres,fin,_40119,[hlexv,lit(kan),_40305,_40363,_40421,_40479],_40231,_40235) --> 
    cc(kan,_40231,_40303),
    negation0(_40119,_40305,_40303,_40339),
    not_look_ahead([jeg],_40363,_40339,_40397),
    not_look_ahead([du],_40421,_40397,_40455),
    not_look_ahead(w(verb(_40155,_40157,_40159)),_40479,_40455,_40235).

hlexv(_40111,_40113,_40115,_40117,_40119,[hlexv,{},_40273,_40361,!],_40207,_40211) --> 
    {nonvar(_40111)},
    lexv(_40111,_40113,_40115,_40117,_40273,_40207,_40319),
    negation0(_40119,_40361,_40319,_40211),
    !.

hlexv(_40111,_40113,_40115,_40117,_40119,[hlexv,_40239,_40327],_40187,_40191) --> 
    lexv(_40111,_40113,_40115,_40117,_40239,_40187,_40285),
    negation0(_40119,_40327,_40285,_40191).

lexv(_40111,_40113,past,fin,[lexv,_40283,_40341,_40389,_40447,!,{},!],_40237,_40241) --> 
    w(verb(have,_40163,fin),_40283,_40237,_40317),
    redundant0(_40341,_40317,_40371),
    w(verb(_40173,past,part),_40389,_40371,_40423),
    particlev2(_40173,_40113,_40447,_40423,_40241),
    !,
    {verbtype(_40113,_40111)},
    !.

lexv(_40111,_40113,_40115,part,[lexv,_40253,_40311,{},!],_40207,_40211) --> 
    w(verb(_40143,_40115,part),_40253,_40207,_40287),
    particlev2(_40143,_40113,_40311,_40287,_40211),
    {verbtype(_40113,_40111)},
    !.

lexv(iv,_40113,past,fin,[lexv,_40241,{},!],_40195,_40199) --> 
    w(verb(_40113,past,part),_40241,_40195,_40199),
    {verbtype(_40113,iv)},
    !.

lexv(iv,_40113,pres,part,[lexv,_40241,{},!],_40195,_40199) --> 
    w(verb(_40113,pres,part),_40241,_40195,_40199),
    {verbtype(_40113,iv)},
    !.

lexv(dtv,_40113,_40115,_40117,[lexv,_40235,{}],_40189,_40193) --> 
    w(verb(_40113,_40115,_40117),_40235,_40189,_40193),
    {verbtype(_40113,dtv)}.

lexv(iv,be1,pres,fin,[lexv,_40219],_40173,_40177) --> 
    w(verb(be,inf,fin),_40219,_40173,_40177).

lexv(tv,_40113,past,part,[lexv,_40259,_40317,{},!],_40213,_40217) --> 
    w(verb(be,past,part),_40259,_40213,_40293),
    w(verb(_40113,past,part),_40317,_40293,_40217),
    {verbtype(_40113,tv)},
    !.

lexv(_40111,_40113,past,part,[lexv,_40241,{},!],_40195,_40199) --> 
    w(verb(_40113,past,part),_40241,_40195,_40199),
    {verbtype(_40113,_40111)},
    !.

lexv(tv,tell,_40115,_40117,[lexv,_40255,_40313,_40371,!,_40469],_40209,_40213) --> 
    w(verb(tell,_40115,_40117),_40255,_40209,_40289),
    reflexiv0(tell,_40313,_40289,_40347),
    optional([om],_40371,_40347,_40435),
    !,
    accept(_40469,_40435,_40213).

lexv(rv,_40113,_40115,_40117,[lexv,_40249,{},_40321],_40203,_40207) --> 
    w(verb(_40113,_40115,_40117),_40249,_40203,_40283),
    {rv_templ(_40113,_40159)},
    not_look_ahead([hva],_40321,_40283,_40207).

lexv(iv,_40113,_40115,fin,[lexv,_40243,_40301,!],_40197,_40201) --> 
    w(verb(be,_40115,fin),_40243,_40197,_40277),
    w(verb(_40113,pres,part),_40301,_40277,_40201),
    !.

lexv(iv,_40113,past,fin,[lexv,_40243,_40301,!],_40197,_40201) --> 
    w(verb(be,_40139,fin),_40243,_40197,_40277),
    w(verb(_40113,pres,part),_40301,_40277,_40201),
    !.

lexv(rv,_40113,_40115,_40117,[lexv,_40279,{},_40351,_40409,!,_40477],_40233,_40237) --> 
    w(verb(_40113,_40115,_40117),_40279,_40233,_40313),
    {testmember(_40113,[tell,notify])},
    reflexiv0(_40113,_40351,_40313,_40385),
    not_look_ahead([hva],_40409,_40385,_40443),
    !,
    accept(_40477,_40443,_40237).

lexv(rv,show,_40115,_40117,[lexv,_40229,_40287],_40183,_40187) --> 
    w(verb(show,_40115,_40117),_40229,_40183,_40263),
    reflexiv0(show,_40287,_40263,_40187).

lexv(rv,mean,_40115,_40117,[lexv,_40239,_40297,!],_40193,_40197) --> 
    w(verb(mean,_40115,_40117),_40239,_40193,_40273),
    look_ahead([at],_40297,_40273,_40197),
    !.

lexv(rv,mean,_40115,_40117,[lexv,_40261,_40319,_40377,_40435],_40215,_40219) --> 
    w(verb(mean,_40115,_40117),_40261,_40215,_40295),
    not_look_ahead([hva],_40319,_40295,_40353),
    not_look_ahead([en],_40377,_40353,_40411),
    not_look_ahead([noe],_40435,_40411,_40219).

lexv(tv,know1,_40115,_40117,[lexv,_40247,_40305,_40363],_40201,_40205) --> 
    w(verb(know,_40115,_40117),_40247,_40201,_40281),
    not_look_ahead([når],_40305,_40281,_40339),
    not_look_ahead([at],_40363,_40339,_40205).

lexv(_40111,_40113,_40115,_40117,[lexv,_40259,_40307,_40355,{},!,_40437],_40213,_40217) --> 
    do(_40259,_40213,_40289),
    faa(_40307,_40289,_40337),
    w(verb(_40113,_40115,_40117),_40355,_40337,_40389),
    {verbtype(_40113,_40111)},
    !,
    accept(_40437,_40389,_40217).

lexv(_40111,_40113,_40115,_40117,[lexv,_40267,_40315,_40373,{},!,_40455],_40221,_40225) --> 
    do(_40267,_40221,_40297),
    not_look_ahead([nå],_40315,_40297,_40349),
    w(verb(_40113,_40115,_40117),_40373,_40349,_40407),
    {verbtype(_40113,_40111)},
    !,
    accept(_40455,_40407,_40225).

lexv(_40111,_40113,_40115,_40117,[lexv,_40273,_40321,_40379,{},{}],_40227,_40231) --> 
    faa(_40273,_40227,_40303),
    not_look_ahead([nå],_40321,_40303,_40355),
    lexv(_40111,_40113,_40115,_40117,_40379,_40355,_40231),
    {verbtype(_40113,_40111)},
    {\+_40113=manage}.

lexv(tv,run,_40115,_40117,[lexv,_40241,_40299,!,_40367],_40195,_40199) --> 
    w(verb(run,_40115,_40117),_40241,_40195,_40275),
    prep1(with,_40299,_40275,_40333),
    !,
    reject(_40367,_40333,_40199).

lexv(tv,evah,pres,fin,[lexv,_40231,!,_40299],_40185,_40189) --> 
    w(verb(evah,pres,fin),_40231,_40185,_40265),
    !,
    accept(_40299,_40265,_40189).

lexv(cv,be,pres,fin,[lexv,_40213,_40261],_40167,_40171) --> 
    aux0(_40213,_40167,_40243),
    be(_40261,_40243,_40171).

lexv(tv,wonder,_40115,_40117,[lexv,_40219],_40173,_40177) --> 
    w(verb(wonder,_40115,_40117),_40219,_40173,_40177).

lexv(tv,want,_40115,_40117,[lexv,_40225,_40283],_40179,_40183) --> 
    w(verb(think,_40115,_40117),_40225,_40179,_40259),
    rfxpron(_40283,_40259,_40183).

lexv(_40111,_40113,past,fin,[lexv,_40293,_40341,_40399,{},_40471,_40529,{}],_40247,_40251) --> 
    aux1(_40293,_40247,_40323),
    w(verb(_40171,past,part),_40341,_40323,_40375),
    not_look_ahead([om],_40399,_40375,_40433),
    {_40171\==have},
    reflexiv0(_40171,_40471,_40433,_40505),
    particlev0(_40171,_40113,_40529,_40505,_40251),
    {verbtype(_40113,_40111)}.

lexv(_40111,_40113,_40115,_40117,[lexv,{},_40305,_40363,{},_40435,{}],_40245,_40249) --> 
    {_40111==tv},
    w(verb(_40113,_40115,_40117),_40305,_40245,_40339),
    not_look_ahead([om],_40363,_40339,_40397),
    {_40113\==have},
    reflexiv0(_40113,_40435,_40397,_40249),
    {verbtype(_40113,_40111)}.

lexv(_40111,_40113,_40115,_40117,[lexv,{},_40335,{},_40407,{},_40479,_40537,{}],_40275,_40279) --> 
    {var(_40111)},
    w(verb(_40185,_40115,_40117),_40335,_40275,_40369),
    {\+rv_templ(_40185,_40203)},
    not_look_ahead([om],_40407,_40369,_40441),
    {_40185\==have},
    reflexiv0(_40185,_40479,_40441,_40513),
    particlev0(_40185,_40113,_40537,_40513,_40279),
    {verbtype(_40113,_40111)}.

lexv(iv,_40113,_40115,_40117,[lexv,_40295,_40343,{},{},_40429,_40487,{}],_40249,_40253) --> 
    aux0(_40295,_40249,_40325),
    w(verb(_40171,_40115,_40117),_40343,_40325,_40377),
    {_40117==fin},
    {_40171\==have},
    reflexiv0(_40171,_40429,_40377,_40463),
    particlev0(_40171,_40113,_40487,_40463,_40253),
    {verbtype(_40113,iv)}.

lexv(_40111,have,_40115,_40117,[lexv,_40265,_40313,{},_40385],_40219,_40223) --> 
    aux0(_40265,_40219,_40295),
    w(verb(have,_40115,_40117),_40313,_40295,_40347),
    {verbtype(have,_40111)},
    not_look_ahead(w(noun(arrival,_40149,_40151,n)),_40385,_40347,_40223).

lexv(_40111,_40113,past,fin,[lexv,_40241,_40289,{}],_40195,_40199) --> 
    has(_40241,_40195,_40271),
    w(verb(_40113,past,part),_40289,_40271,_40199),
    {verbtype(_40113,_40111)}.

lexv(tv,bring,_40115,_40117,[lexv,_40229,_40287],_40183,_40187) --> 
    w(verb(take,_40115,_40117),_40229,_40183,_40263),
    prep1(with,_40287,_40263,_40187).

lexv(_40111,_40113,_40115,_40117,[lexv,_40259,_40317,_40365,{},!],_40213,_40217) --> 
    w(verb(_40149,_40115,_40117),_40259,_40213,_40293),
    redundant0(_40317,_40293,_40347),
    particlev0(_40149,_40113,_40365,_40347,_40217),
    {verbtype(_40113,_40111)},
    !.

preadjs0(_40111,[preadjs0,lit(s),_40215,!,_40273],_40165,_40169) --> 
    cc(s,_40165,_40213),
    look_ahead_clock(_40215,_40213,_40245),
    !,
    reject(_40273,_40245,_40169).

preadjs0(_40111,[preadjs0,_40187,_40235,!],_40159,_40163) --> 
    so(_40187,_40159,_40217),
    preadjs(_40111,_40235,_40217,_40163),
    !.

preadjs0((_40115,_40117),[preadjs0,_40203,_40251,_40309,_40357],_40175,_40179) --> 
    dent0(_40203,_40175,_40233),
    preadj1(_40115,_40251,_40233,_40285),
    adj_conjunction(_40309,_40285,_40339),
    preadj1(_40117,_40357,_40339,_40179).

preadjs0((_40115,_40117),[preadjs0,_40215,_40263,_40321,_40379],_40187,_40191) --> 
    dent0(_40215,_40187,_40245),
    preadj1(_40115,_40263,_40245,_40297),
    not_look_ahead(w(prep(_40155)),_40321,_40297,_40355),
    preadjs0(_40117,_40379,_40355,_40191).

preadjs0(true,[preadjs0,[]],_40143,_40143) --> 
    [].

preadjs((_40115,_40117),[preadjs,_40209,_40267,_40325],_40181,_40185) --> 
    preadj1(_40115,_40209,_40181,_40243),
    not_look_ahead(w(prep(_40149)),_40267,_40243,_40301),
    preadjs0(_40117,_40325,_40301,_40185).

preadj1(nil/first,[preadj1,_40199,_40257,!],_40171,_40175) --> 
    w(nb(1,num),_40199,_40171,_40233),
    point(_40257,_40233,_40175),
    !.

preadj1(nil/second,[preadj1,_40199,_40257,!],_40171,_40175) --> 
    w(nb(2,num),_40199,_40171,_40233),
    point(_40257,_40233,_40175),
    !.

preadj1(nil/third,[preadj1,_40199,_40257,!],_40171,_40175) --> 
    w(nb(3,num),_40199,_40171,_40233),
    point(_40257,_40233,_40175),
    !.

preadj1(nil/_40117,[preadj1,_40221,{},!,_40303],_40193,_40197) --> 
    w(name(_40117,n,station),_40221,_40193,_40255),
    {\+adjname_templ(_40117,_40161)},
    !,
    reject(_40303,_40255,_40197).

preadj1(nil/_40117,[preadj1,_40211,{},!],_40183,_40187) --> 
    w(name(_40117,n,_40141),_40211,_40183,_40187),
    {adjname_templ(_40117,_40151)},
    !.

preadj1(_40115/_40117,[preadj1,_40197,_40255],_40169,_40173) --> 
    gradverb(_40115,_40197,_40169,_40231),
    w(adj2(_40117,nil),_40255,_40231,_40173).

preadj1(_40115/_40117,[preadj1,_40265,_40323,_40381,_40469,{},!],_40237,_40241) --> 
    not_look_ahead_lit([først,senest,tidligst],_40265,_40237,_40299),
    not_look_ahead(w(prep(_40175)),_40323,_40299,_40357),
    optional([mye],_40381,_40357,_40445),
    w(adj2(_40117,_40115),_40469,_40445,_40241),
    {\+post_adjective(_40117)},
    !.

adj_conjunction0([adj_conjunction0,_40163,!],_40141,_40145) --> 
    adj_conjunction(_40163,_40141,_40145),
    !.

adj_conjunction0([adj_conjunction0,[]],_40135,_40135) --> 
    [].

adj_conjunction([adj_conjunction,lit(og)],_40139,_40143) --> 
    cc(og,_40139,_40143).

adj_conjunction([adj_conjunction,lit(men)],_40139,_40143) --> 
    cc(men,_40139,_40143).

adj_conjunction([adj_conjunction,lit(eller)],_40139,_40143) --> 
    cc(eller,_40139,_40143).

adj_conjunction([adj_conjunction,lit(/)],_40139,_40143) --> 
    cc(/,_40139,_40143).

adj1s((_40127;_40129),_40113,_40115,_40121 or _40123,[adj1s,_40261,lit(eller),_40371,!],_40215,_40219) --> 
    adj1(_40127,_40113,_40115,_40121,_40261,_40215,_40307),
    cc(eller,_40307,_40369),
    adj1(_40129,_40113,_40115,_40123,_40371,_40369,_40219),
    !.

adj1s((_40127,_40129),_40113,_40115,_40121 and _40123,[adj1s,_40279,lit(og),_40389,_40477,!],_40233,_40237) --> 
    adj1(_40127,_40113,_40115,_40121,_40279,_40233,_40325),
    cc(og,_40325,_40387),
    adj1(_40129,_40113,_40115,_40123,_40389,_40387,_40435),
    not_look_ahead(w(prep(_40189)),_40477,_40435,_40237),
    !.

adj1s(_40111,_40113,_40115,_40117,[adj1s,_40217],_40171,_40175) --> 
    adj1(_40111,_40113,_40115,_40117,_40217,_40171,_40175).

adj1(_40111,_40113,_40115,_40117,[adj1,_40249,_40307,{}],_40203,_40207) --> 
    gradverbs0(_40137,_40249,_40203,_40283),
    w(adj2(_40111,nil),_40307,_40283,_40207),
    {adj_template(_40137,_40111,_40113,_40115,_40117)}.

adj1(_40111,_40113,_40115,_40117,[adj1,_40239,{}],_40193,_40197) --> 
    w(adj2(_40111,_40131),_40239,_40193,_40197),
    {adj_template(_40131,_40111,_40113,_40115,_40117)}.

gradverbs0(_40111,[gradverbs0,_40191,!,_40259],_40163,_40167) --> 
    gradverb(_40111,_40191,_40163,_40225),
    !,
    gradverbs0(_40127,_40259,_40225,_40167).

gradverbs0(nil,[gradverbs0,[]],_40143,_40143) --> 
    [].

gradverb0(more,[gradverb0,lit(mer),_40223,!],_40173,_40177) --> 
    cc(mer,_40173,_40221),
    look_ahead(w(adj2(_40139,nil)),_40223,_40221,_40177),
    !.

gradverb0(_40111,[gradverb0,_40199,_40257,!],_40171,_40175) --> 
    gradverb(_40111,_40199,_40171,_40233),
    not_look_ahead(w(prep(_40139)),_40257,_40233,_40175),
    !.

gradverb0(nil,[gradverb0,[]],_40143,_40143) --> 
    [].

gradverb(little,[gradverb,lit(dårlig)],_40147,_40151) --> 
    cc(dårlig,_40147,_40151).

gradverb(more,[gradverb,lit(litt),lit(mer),!],_40163,_40167) --> 
    cc(litt,_40163,_40211),
    cc(mer,_40211,_40167),
    !.

gradverb(more,[gradverb,lit(mye),lit(mer),!],_40163,_40167) --> 
    cc(mye,_40163,_40211),
    cc(mer,_40211,_40167),
    !.

gradverb(more,[gradverb,lit(mer)],_40147,_40151) --> 
    cc(mer,_40147,_40151).

gradverb(only,[gradverb,lit(bare)],_40147,_40151) --> 
    cc(bare,_40147,_40151).

gradverb(too,[gradverb,lit(for)],_40147,_40151) --> 
    cc(for,_40147,_40151).

gradverb(very,[gradverb,lit(meget)],_40147,_40151) --> 
    cc(meget,_40147,_40151).

gradverb(very,[gradverb,lit(veldig)],_40147,_40151) --> 
    cc(veldig,_40147,_40151).

gradverb(little,[gradverb,lit(litt)],_40147,_40151) --> 
    cc(litt,_40147,_40151).

gradverb(somewhat,[gradverb,lit(noe)],_40147,_40151) --> 
    cc(noe,_40147,_40151).

gradverb(often,[gradverb,lit(ofte)],_40147,_40151) --> 
    cc(ofte,_40147,_40151).

gradverb(nil,[gradverb,lit(så)],_40147,_40151) --> 
    cc(så,_40147,_40151).

prepnom(_40111,[prepnom,_40203,{},!,_40285],_40175,_40179) --> 
    prep(_40111,_40203,_40175,_40237),
    {_40111==regarding},
    !,
    accept(_40285,_40237,_40179).

prepnom(_40111,[prepnom,_40175],_40147,_40151) --> 
    prepnof(_40111,_40175,_40147,_40151).

prepnog(long,from,[prepnog,_40199,!,_40267],_40165,_40169) --> 
    prep1(from,_40199,_40165,_40233),
    !,
    accept(_40267,_40233,_40169).

prepnog(possible,_40113,[prepnog,!,_40199],_40155,_40159) --> 
    !,
    reject(_40199,_40155,_40159).

prepnog(_40111,_40113,[prepnog,_40199,!,_40267],_40165,_40169) --> 
    prepnof(_40113,_40199,_40165,_40233),
    !,
    accept(_40267,_40233,_40169).

prepnof(_40111,[prepnof,_40195,{}],_40167,_40171) --> 
    prep(_40111,_40195,_40167,_40171),
    {\+_40111=of}.

defaultprep(_40111,_40113,_40115,[defaultprep,{},{},_40275,!,_40363],_40207,_40211) --> 
    {_40111\==be},
    {vartypeid(_40113,_40159)},
    adjustprep0(_40111,_40159,_40115,_40275,_40207,_40317),
    !,
    accept(_40363,_40317,_40211).

adjustprep0(_40111,_40113,_40115,[adjustprep0,_40209,!],_40169,_40173) --> 
    adjustprep(_40111,_40113,_40115,_40209,_40169,_40173),
    !.

adjustprep0(_40111,_40113,_40115,[adjustprep0,_40203],_40163,_40167) --> 
    missingprep(_40111,_40113,_40115,_40203,_40163,_40167).

adjustprep(ask,_40113,regarding,[adjustprep,lit(om)],_40159,_40163) --> 
    cc(om,_40159,_40163).

adjustprep(dream,_40113,regarding,[adjustprep,lit(om)],_40159,_40163) --> 
    cc(om,_40159,_40163).

adjustprep(handle2,_40113,regarding,[adjustprep,lit(om)],_40159,_40163) --> 
    cc(om,_40159,_40163).

adjustprep(know,_40113,regarding,[adjustprep,lit(om)],_40159,_40163) --> 
    cc(om,_40159,_40163).

adjustprep(know1,_40113,regarding,[adjustprep,lit(om)],_40159,_40163) --> 
    cc(om,_40159,_40163).

adjustprep(go,_40113,from,[adjustprep,_40199],_40159,_40163) --> 
    prep(after,_40199,_40159,_40163).

adjustprep(go,_40113,to,[adjustprep,_40199],_40159,_40163) --> 
    prep(of,_40199,_40159,_40163).

adjustprep(_40111,_40113,_40115,[adjustprep,_40199],_40159,_40163) --> 
    prep(_40115,_40199,_40159,_40163).

missingprep(_40111,duration,with,[missingprep,!],_40155,_40155) --> 
    !.

missingprep(pass,_40113,_40115,[missingprep,!,_40211],_40161,_40165) --> 
    !,
    reject(_40211,_40161,_40165).

missingprep(_40111,thing,_40115,[missingprep,!,_40211],_40161,_40165) --> 
    !,
    reject(_40211,_40161,_40165).

missingprep(go,direction,in,[missingprep,[]],_40155,_40155) --> 
    [].

missingprep(arrive,_40113,at,[missingprep,[]],_40155,_40155) --> 
    [].

missingprep(depart,_40113,from,[missingprep,[]],_40155,_40155) --> 
    [].

missingprep(go,direction,in,[missingprep,[]],_40155,_40155) --> 
    [].

missingprep(go,_40113,at,[missingprep,[]],_40155,_40155) --> 
    [].

missingprep(start,_40113,at,[missingprep,[]],_40155,_40155) --> 
    [].

missingprep(stop,_40113,at,[missingprep,[]],_40155,_40155) --> 
    [].

prep0(from,[prep0,_40187,!,_40255],_40159,_40163) --> 
    prep(from,_40187,_40159,_40221),
    !,
    accept(_40255,_40221,_40163).

prep0(_40111,[prep0,_40191,{}],_40163,_40167) --> 
    prep(_40111,_40191,_40163,_40167),
    {_40111\==of}.

prep0(in,[prep0,[]],_40143,_40143) --> 
    [].

prep(_40111,[prep,lit(m),_40225,!,_40293],_40175,_40179) --> 
    cc(m,_40175,_40223),
    w(nb(_40141,_40143),_40225,_40223,_40259),
    !,
    reject(_40293,_40259,_40179).

prep(from,[prep,lit(dra),{},_40261],_40191,_40195) --> 
    cc(dra,_40191,_40239),
    {user:value(smsflag,true)},
    look_ahead(w(name(_40135,n,_40139)),_40261,_40239,_40195).

prep(_40111,[prep,_40175],_40147,_40151) --> 
    prep2(_40111,_40175,_40147,_40151).

prep(_40111,[prep,_40175],_40147,_40151) --> 
    prep1(_40111,_40175,_40147,_40151).

prep1(after,[prep1,lit(e),_40217,!],_40167,_40171) --> 
    cc(e,_40167,_40215),
    not_look_ahead(['.'],_40217,_40215,_40171),
    !.

prep1(_40111,[prep1,_40193,_40251],_40165,_40169) --> 
    w(prep(_40111),_40193,_40165,_40227),
    not_look_ahead([å],_40251,_40227,_40169).

prep1(to,[prep1,lit(ti),_40219],_40169,_40173) --> 
    cc(ti,_40169,_40217),
    look_ahead(w(name(_40129,_40131,_40133)),_40219,_40217,_40173).

atom(_40111,[atom,_40199,{}],_40171,_40175) --> 
    w(name(_40125,_40137,_40139),_40199,_40171,_40175),
    {atom_templ(_40125,_40111)}.

atomlist(_40111,[atomlist,_40203,_40261,_40319],_40175,_40179) --> 
    atom1(_40133,_40203,_40175,_40237),
    atom1(_40137,_40261,_40237,_40295),
    atoms0(_40133-_40137,_40111,_40319,_40295,_40179).

atom1(_40111,[atom1,_40199,{}],_40171,_40175) --> 
    w(name(_40111,n,_40125),_40199,_40171,_40175),
    {_40125\==unkn}.

atoms0(_40111,_40113,[atoms0,_40205,_40263],_40171,_40175) --> 
    atom1(_40129,_40205,_40171,_40239),
    atoms0(_40111-_40129,_40113,_40263,_40239,_40175).

atoms0(_40111,_40111,[atoms0,[]],_40149,_40149) --> 
    [].

newatom(_40111,[newatom,_40199,{}],_40171,_40175) --> 
    w(name(_40125,_40137,_40139),_40199,_40171,_40175),
    {atom_templ(_40125,_40111)}.

newatomid(_40111,[newatomid,_40183],_40155,_40159) --> 
    w(name(_40111,_40121,_40123),_40183,_40155,_40159).

xsubjunction(nil,coevent,instead_of,[xsubjunction,lit(fremfor)],_40159,_40163) --> 
    cc(fremfor,_40159,_40163).

xsubjunction(nil,coevent,in_order_to,[xsubjunction,_40195],_40155,_40159) --> 
    in_order_to(_40195,_40155,_40159).

xsubjunction(nil,coevent,without,[xsubjunction,_40195],_40155,_40159) --> 
    utenå(_40195,_40155,_40159).

xsubjunction(nil,coevent,by,[xsubjunction,lit(ved),lit(å)],_40169,_40173) --> 
    cc(ved,_40169,_40229),
    cc(å,_40229,_40173).

subjunction(before,time,in,[subjunction,_40205,_40263],_40165,_40169) --> 
    prep1(to,_40205,_40165,_40239),
    look_ahead_np(_40263,_40239,_40169).

subjunction(after,time,in,[subjunction,_40205,_40263],_40165,_40169) --> 
    prep1(after,_40205,_40165,_40239),
    that(_40263,_40239,_40169).

subjunction(after,time,in,[subjunction,_40263,_40321,_40379,_40437,!],_40223,_40227) --> 
    prep1(after,_40263,_40223,_40297),
    not_look_ahead(w(noun(clock,sin,def,n)),_40321,_40297,_40355),
    not_look_ahead(w(nb(_40173,_40175)),_40379,_40355,_40413),
    look_ahead([jeg],_40437,_40413,_40227),
    !.

subjunction(before,time,in,[subjunction,lit(før),_40265,_40323],_40203,_40207) --> 
    cc(før,_40203,_40263),
    not_look_ahead(w(nb(_40161,_40163)),_40265,_40263,_40299),
    not_look_ahead(w(noun(clock,sin,def,n)),_40323,_40299,_40207).

subjunction(before,time,in,[subjunction,lit(til),_40243],_40181,_40185) --> 
    cc(til,_40181,_40241),
    not_look_ahead(w(name(_40133,_40135,_40137)),_40243,_40241,_40185).

subjunction(not_withstanding,coevent,nil,[subjunction,_40205,lit(om)],_40165,_40169) --> 
    uansett(_40205,_40165,_40235),
    cc(om,_40235,_40169).

subjunction(not_withstanding,coevent,nil,[subjunction,lit(selvom)],_40159,_40163) --> 
    cc(selvom,_40159,_40163).

uansett([uansett,lit(uansett)],_40139,_40143) --> 
    cc(uansett,_40139,_40143).

uansett([uansett,lit(selv)],_40139,_40143) --> 
    cc(selv,_40139,_40143).

subjunction(unless,coevent,nil,[subjunction,lit(med),lit(mindre)],_40169,_40173) --> 
    cc(med,_40169,_40229),
    cc(mindre,_40229,_40173).

subjunction(nil,coevent,so_that,[subjunction,_40195],_40155,_40159) --> 
    because(_40195,_40155,_40159).

subjunction(nil,coevent,so_that,[subjunction,_40195],_40155,_40159) --> 
    if1(_40195,_40155,_40159).

subjunction(nil,coevent,despite_of,[subjunction,_40209,lit(at)],_40169,_40173) --> 
    prep1(without,_40209,_40169,_40243),
    cc(at,_40243,_40173).

subjunction(nil,coevent,instead_of,[subjunction,_40195],_40155,_40159) --> 
    instead_of(_40195,_40155,_40159).

subjunction(nil,coevent,because_of,[subjunction,lit(med),lit(at)],_40169,_40173) --> 
    cc(med,_40169,_40229),
    cc(at,_40229,_40173).

subjunction(nil,coevent,because_of,[subjunction,_40195],_40155,_40159) --> 
    so_that(_40195,_40155,_40159).

subjunction(nil,coevent,because_of,[subjunction,lit(slik)],_40159,_40163) --> 
    cc(slik,_40159,_40163).

subjunction(during,time,in,[subjunction,_40195],_40155,_40159) --> 
    while(_40195,_40155,_40159).

subjunction(in,time,in,[subjunction,lit(om),_40227],_40165,_40169) --> 
    cc(om,_40165,_40225),
    when1(_40227,_40225,_40169).

subjunction(in,time,in,[subjunction,_40195],_40155,_40159) --> 
    when1(_40195,_40155,_40159).

subjunction(in,time,in,[subjunction,lit(så),_40235],_40173,_40177) --> 
    cc(så,_40173,_40233),
    w(adv(fast),_40235,_40233,_40177).

subjunction(in,time,in,[subjunction,lit(om),lit(hvordan)],_40169,_40173) --> 
    cc(om,_40169,_40229),
    cc(hvordan,_40229,_40173).

subjunction(in,time,in,[subjunction,lit(på),lit(hvordan)],_40169,_40173) --> 
    cc(på,_40169,_40229),
    cc(hvordan,_40229,_40173).

subjunction(in,time,in,[subjunction,lit(da)],_40159,_40163) --> 
    cc(da,_40159,_40163).

subjunction(in,place,in,[subjunction,lit(der)],_40159,_40163) --> 
    cc(der,_40159,_40163).

subjunction(in,place,in,[subjunction,lit(hvor),_40241],_40179,_40183) --> 
    cc(hvor,_40179,_40239),
    not_look_ahead(w(adj2(_40133,_40135)),_40241,_40239,_40183).

subjunction(until,time,in,[subjunction,_40195],_40155,_40159) --> 
    until(_40195,_40155,_40159).

subjunction(in,time,in,[subjunction,lit(i),lit(det)],_40169,_40173) --> 
    cc(i,_40169,_40229),
    cc(det,_40229,_40173).

because([because,lit(fordi)],_40139,_40143) --> 
    cc(fordi,_40139,_40143).

because([because,lit(for),_40207,!],_40163,_40167) --> 
    cc(for,_40163,_40205),
    look_ahead_lit([da,den],_40207,_40205,_40167),
    !.

because([because,lit(siden),_40231,{},!,_40313],_40187,_40191) --> 
    cc(siden,_40187,_40229),
    w(noun(_40143,_40145,_40147,_40149),_40231,_40229,_40265),
    {constrain(_40143,time)},
    !,
    reject(_40313,_40265,_40191).

because([because,lit(siden)],_40139,_40143) --> 
    cc(siden,_40139,_40143).

erdetdet([erdetdet,_40179,lit(det),_40249,_40297],_40157,_40161) --> 
    be(_40179,_40157,_40209),
    cc(det,_40209,_40247),
    that0(_40249,_40247,_40279),
    det0(_40297,_40279,_40161).

be_it_tf_that(_40111,[be_it_tf_that,_40233,lit(det),_40313,lit(ut),lit(til),lit(at)],_40205,_40209) --> 
    w(verb(see,_40155,fin),_40233,_40205,_40267),
    cc(det,_40267,_40311),
    negation0(_40111,_40313,_40311,_40347),
    cc(ut,_40347,_40391),
    cc(til,_40391,_40413),
    cc(at,_40413,_40209).

omaa([omaa,lit(om),lit(å),!],_40155,_40159) --> 
    cc(om,_40155,_40197),
    cc(å,_40197,_40159),
    !.

omaa([omaa,lit(å),!],_40145,_40149) --> 
    cc(å,_40145,_40149),
    !.

gadd([gadd,lit(vil)],_40139,_40143) --> 
    cc(vil,_40139,_40143).

hvormye([hvormye,lit(hvor),lit(mye)],_40149,_40153) --> 
    cc(hvor,_40149,_40191),
    cc(mye,_40191,_40153).

hvormye([hvormye,lit(hvor),lit(mange)],_40149,_40153) --> 
    cc(hvor,_40149,_40191),
    cc(mange,_40191,_40153).

hvormye([hvormye,lit(hvor),lit(meget)],_40149,_40153) --> 
    cc(hvor,_40149,_40191),
    cc(meget,_40191,_40153).

hvormye([hvormye,lit(hva)],_40139,_40143) --> 
    cc(hva,_40139,_40143).

whatcan([whatcan,lit(hva),lit(kan)],_40149,_40153) --> 
    cc(hva,_40149,_40191),
    cc(kan,_40191,_40153).

whatcan([whatcan,lit(hva),_40189],_40145,_40149) --> 
    cc(hva,_40145,_40187),
    aux1(_40189,_40187,_40149).

ompa([ompa,lit(om)],_40139,_40143) --> 
    cc(om,_40139,_40143).

ompa([ompa,_40165],_40143,_40147) --> 
    w(prep(on),_40165,_40143,_40147).

ompa([ompa,_40165],_40143,_40147) --> 
    w(prep(for),_40165,_40143,_40147).

hver0([hver0,lit(hvert),!],_40145,_40149) --> 
    cc(hvert,_40145,_40149),
    !.

hver0([hver0,lit(hver),!],_40145,_40149) --> 
    cc(hver,_40145,_40149),
    !.

hver0([hver0,[]],_40135,_40135) --> 
    [].

detå([detå,lit(det),_40195,!],_40151,_40155) --> 
    cc(det,_40151,_40193),
    infinitive(_40195,_40193,_40155),
    !.

detå([detå,lit(det),lit(og),!],_40155,_40159) --> 
    cc(det,_40155,_40197),
    cc(og,_40197,_40159),
    !.

detå([detå,lit(det),lit(for),_40227,!],_40161,_40165) --> 
    cc(det,_40161,_40203),
    cc(for,_40203,_40225),
    infinitive(_40227,_40225,_40165),
    !.

detå([detå,lit(det),lit(for),lit(og),!],_40165,_40169) --> 
    cc(det,_40165,_40207),
    cc(for,_40207,_40229),
    cc(og,_40229,_40169),
    !.

numberroute([numberroute,_40169,_40217,!],_40147,_40151) --> 
    optionalbus(_40169,_40147,_40199),
    num1(_40217,_40199,_40151),
    !.

numberroute([numberroute,_40163,!],_40141,_40145) --> 
    bus1(_40163,_40141,_40145),
    !.

optionalbus([optionalbus,_40171,_40219],_40149,_40153) --> 
    bus1(_40171,_40149,_40201),
    optional([nr],_40219,_40201,_40153).

optionalbus([optionalbus,_40157],_40135,_40139) --> 
    num1(_40157,_40135,_40139).

optionalbus([optionalbus,[]],_40135,_40135) --> 
    [].

num1([num1,_40183,_40241,!],_40161,_40165) --> 
    w(noun(number,sin,_40131,n),_40183,_40161,_40217),
    point0(_40241,_40217,_40165),
    !.

num1([num1,lit(nr),_40195,!],_40151,_40155) --> 
    cc(nr,_40151,_40193),
    point0(_40195,_40193,_40155),
    !.

bus1([bus1,_40171],_40149,_40153) --> 
    w(noun(route,sin,_40119,_40121),_40171,_40149,_40153).

bus1([bus1,_40171],_40149,_40153) --> 
    w(noun(bus,sin,_40119,_40121),_40171,_40149,_40153).

commas0([commas0,_40169,!,_40227],_40147,_40151) --> 
    comma(_40169,_40147,_40199),
    !,
    commas0(_40227,_40199,_40151).

commas0([commas0,[]],_40135,_40135) --> 
    [].

comma0([comma0,lit(','),!],_40145,_40149) --> 
    cc(',',_40145,_40149),
    !.

comma0([comma0,[]],_40135,_40135) --> 
    [].

comma([comma,lit(',')],_40139,_40143) --> 
    cc(',',_40139,_40143).

streetno([streetno,_40169,!,_40227],_40147,_40151) --> 
    a(_40169,_40147,_40199),
    !,
    reject(_40227,_40199,_40151).

streetno([streetno,lit(veg)],_40139,_40143) --> 
    cc(veg,_40139,_40143).

streetno([streetno,_40183,{}],_40161,_40165) --> 
    w(nb(_40121,num),_40183,_40161,_40165),
    {_40121<500}.

tilsiden([tilsiden,_40161],_40139,_40143) --> 
    prep1(to,_40161,_40139,_40143).

tilsiden([tilsiden,_40161],_40139,_40143) --> 
    prep1(before,_40161,_40139,_40143).

tilsiden([tilsiden,lit(siden)],_40139,_40143) --> 
    cc(siden,_40139,_40143).

hva([hva,lit(hva),!,_40205],_40151,_40155) --> 
    cc(hva,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

hva([hva,lit(hvor),_40201,!,_40259],_40157,_40161) --> 
    cc(hvor,_40157,_40199),
    meny(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

addressat0([addressat0,_40181,!,_40249],_40159,_40163) --> 
    w(name(tuc,n,_40131),_40181,_40159,_40215),
    !,
    accept(_40249,_40215,_40163).

addressat0([addressat0,_40181,!,_40249],_40159,_40163) --> 
    w(name(busstuc,n,_40131),_40181,_40159,_40215),
    !,
    accept(_40249,_40215,_40163).

addressat0([addressat0,_40181,!,_40249],_40159,_40163) --> 
    w(name(bustuc,n,_40131),_40181,_40159,_40215),
    !,
    accept(_40249,_40215,_40163).

addressat0([addressat0,_40181,!,_40249],_40159,_40163) --> 
    w(name(hal,n,_40131),_40181,_40159,_40215),
    !,
    accept(_40249,_40215,_40163).

addressat0([addressat0,[]],_40135,_40135) --> 
    [].

enn([enn,lit(enn)],_40139,_40143) --> 
    cc(enn,_40139,_40143).

enn([enn,lit(en)],_40139,_40143) --> 
    cc(en,_40139,_40143).

hatt0([hatt0,_40175,!],_40153,_40157) --> 
    w(verb(have,past,part),_40175,_40153,_40157),
    !.

hatt0([hatt0,[]],_40135,_40135) --> 
    [].

out0([out0,lit(ut),!,_40205],_40151,_40155) --> 
    cc(ut,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

out0([out0,lit(opp),!,_40205],_40151,_40155) --> 
    cc(opp,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

out0([out0,[]],_40135,_40135) --> 
    [].

a0([a0,_40157],_40135,_40139) --> 
    a(_40157,_40135,_40139).

a0([a0,[]],_40135,_40135) --> 
    [].

a([a,lit(ett),_40207],_40163,_40167) --> 
    cc(ett,_40163,_40205),
    not_look_ahead(w(noun(time,_40127,def,_40131)),_40207,_40205,_40167).

a([a,lit(noen),lit(av),!],_40155,_40159) --> 
    cc(noen,_40155,_40197),
    cc(av,_40197,_40159),
    !.

a([a,lit(noen),_40217,_40275,_40333],_40173,_40177) --> 
    cc(noen,_40173,_40215),
    not_look_ahead([av],_40217,_40215,_40251),
    not_look_ahead([de],_40275,_40251,_40309),
    look_ahead_np(_40333,_40309,_40177).

a([a,lit(noe),_40203,_40261],_40159,_40163) --> 
    cc(noe,_40159,_40201),
    not_look_ahead([de],_40203,_40201,_40237),
    look_ahead_np(_40261,_40237,_40163).

a([a,_40171,_40219],_40149,_40153) --> 
    art1(_40171,_40149,_40201),
    optional([slik],_40219,_40201,_40153).

art([art,_40157],_40135,_40139) --> 
    a(_40157,_40135,_40139).

art([art,_40173,lit(eller),_40243],_40151,_40155) --> 
    a(_40173,_40151,_40203),
    cc(eller,_40203,_40241),
    more(_40243,_40241,_40155).

art([art,lit(de)],_40139,_40143) --> 
    cc(de,_40139,_40143).

art([art,lit(all)],_40139,_40143) --> 
    cc(all,_40139,_40143).

art([art,_40183,lit(alt)],_40161,_40165) --> 
    not_look_ahead(w(name(_40129,_40131,_40133)),_40183,_40161,_40217),
    cc(alt,_40217,_40165).

art([art,_40183,{}],_40161,_40165) --> 
    every(_40183,_40161,_40165),
    {\+user:value(textflag,true)}.

art1([art1,lit(en)],_40139,_40143) --> 
    cc(en,_40139,_40143).

art1([art1,lit(et)],_40139,_40143) --> 
    cc(et,_40139,_40143).

art1([art1,lit(ei)],_40139,_40143) --> 
    cc(ei,_40139,_40143).

allsome0([allsome0,lit(noen),lit(av)],_40149,_40153) --> 
    cc(noen,_40149,_40191),
    cc(av,_40191,_40153).

allsome0([allsome0,_40163,!],_40141,_40145) --> 
    all(_40163,_40141,_40145),
    !.

allsome0([allsome0,[]],_40135,_40135) --> 
    [].

all0([all0,_40163,!],_40141,_40145) --> 
    all(_40163,_40141,_40145),
    !.

all0([all0,[]],_40135,_40135) --> 
    [].

all([all,_40157],_40135,_40139) --> 
    every(_40157,_40135,_40139).

always([always,lit(alltid)],_40139,_40143) --> 
    cc(alltid,_40139,_40143).

always([always,_40187,_40245],_40165,_40169) --> 
    w(adj2(whole,nil),_40187,_40165,_40221),
    w(noun(time,sin,def,n),_40245,_40221,_40169).

and0([and0,_40169,!,_40227],_40147,_40151) --> 
    and1(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

and0([and0,[]],_40135,_40135) --> 
    [].

andor0([andor0,_40169,!,_40227],_40147,_40151) --> 
    andor(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

andor0([andor0,[]],_40135,_40135) --> 
    [].

andor([andor,lit(og),!],_40145,_40149) --> 
    cc(og,_40145,_40149),
    !.

andor([andor,lit(eller),!],_40145,_40149) --> 
    cc(eller,_40145,_40149),
    !.

betwand0([betwand0,lit(å),!],_40145,_40149) --> 
    cc(å,_40145,_40149),
    !.

betwand0([betwand0,lit(og),!],_40145,_40149) --> 
    cc(og,_40145,_40149),
    !.

betwand0([betwand0,_40171,!],_40149,_40153) --> 
    w(prep(to),_40171,_40149,_40153),
    !.

betwand0([betwand0,[]],_40135,_40135) --> 
    [].

and1([and1,lit(og)],_40139,_40143) --> 
    cc(og,_40139,_40143).

and1([and1,lit(men),_40201],_40157,_40161) --> 
    cc(men,_40157,_40199),
    look_ahead_lit([en,et],_40201,_40199,_40161).

vmod_conjunction([vmod_conjunction,lit(mao)],_40139,_40143) --> 
    cc(mao,_40139,_40143).

vmod_conjunction([vmod_conjunction,lit(men),_40201],_40157,_40161) --> 
    cc(men,_40157,_40199),
    not_look_ahead_lit([med,nå],_40201,_40199,_40161).

vmod_conjunction([vmod_conjunction,_40281,_40339,_40427,_40485,_40543,_40601,_40659],_40259,_40263) --> 
    one_of_lit([og,eller],_40281,_40259,_40315),
    optional([så],_40339,_40315,_40403),
    not_look_ahead_lit([da,så,nå],_40427,_40403,_40461),
    not_look_ahead(w(prep(in)),_40485,_40461,_40519),
    not_look_ahead(w([ikveld]),_40543,_40519,_40577),
    not_look_ahead(w([imorgen]),_40601,_40577,_40635),
    not_look_ahead(w(name(_40155,_40157,_40159)),_40659,_40635,_40263).

andwhen0([andwhen0,_40175,_40223,!,_40281],_40153,_40157) --> 
    and1(_40175,_40153,_40205),
    when(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

andwhen0([andwhen0,[]],_40135,_40135) --> 
    [].

andwhere0([andwhere0,_40185,_40233,_40291,!,_40349],_40163,_40167) --> 
    and1(_40185,_40163,_40215),
    prep1(from,_40233,_40215,_40267),
    where(_40291,_40267,_40321),
    !,
    accept(_40349,_40321,_40167).

andwhere0([andwhere0,_40175,_40223,!,_40281],_40153,_40157) --> 
    and1(_40175,_40153,_40205),
    where(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

andwhere0([andwhere0,_40179,lit(hvorfra),!,_40259],_40157,_40161) --> 
    and1(_40179,_40157,_40209),
    cc(hvorfra,_40209,_40247),
    !,
    accept(_40259,_40247,_40161).

andwhere0([andwhere0,[]],_40135,_40135) --> 
    [].

np_conjunction(_40111,[np_conjunction,_40203,lit(det),_40283,!,_40341],_40175,_40179) --> 
    andor(_40139,_40203,_40175,_40237),
    cc(det,_40237,_40281),
    look_ahead_vp(_40283,_40281,_40313),
    !,
    reject(_40341,_40313,_40179).

np_conjunction(_40111,[np_conjunction,_40225,_40283,_40341,_40399],_40197,_40201) --> 
    andor(_40111,_40225,_40197,_40259),
    not_look_ahead_lit([da,så],_40283,_40259,_40317),
    not_look_ahead(w(prep(_40165)),_40341,_40317,_40375),
    not_look_ahead(['.'],_40399,_40375,_40201).

andor0(_40111,[andor0,_40175],_40147,_40151) --> 
    andor(_40111,_40175,_40147,_40151).

andor0(and,[andor0,{}],_40159,_40159) --> 
    {user:value(textflag,true)}.

andor(and,[andor,_40223,_40271,_40329],_40195,_40199) --> 
    and1(_40223,_40195,_40253),
    not_look_ahead(['.'],_40271,_40253,_40305),
    not_look_ahead_lit([jeg,mange,ikke,ingen,noen,disse,dette],_40329,_40305,_40199).

andor(or,[andor,lit(eller),_40219],_40169,_40173) --> 
    cc(eller,_40169,_40217),
    not_look_ahead(w(verb(_40129,_40131,_40133)),_40219,_40217,_40173).

andor(and,[andor,{},_40225,!,_40283],_40177,_40181) --> 
    {user:value(teleflag,true)},
    art(_40225,_40177,_40255),
    !,
    reject(_40283,_40255,_40181).

andor(and,[andor,{}],_40159,_40159) --> 
    {user:value(teleflag,true)}.

also0([also0,lit(også),lit(samtidig),!],_40155,_40159) --> 
    cc(også,_40155,_40197),
    cc(samtidig,_40197,_40159),
    !.

also0([also0,lit(samtidig),lit(også),!],_40155,_40159) --> 
    cc(samtidig,_40155,_40197),
    cc(også,_40197,_40159),
    !.

also0([also0,lit(også),!],_40145,_40149) --> 
    cc(også,_40145,_40149),
    !.

also0([also0,lit(samtidig),!],_40145,_40149) --> 
    cc(samtidig,_40145,_40149),
    !.

also0([also0,lit(deretter),!],_40145,_40149) --> 
    cc(deretter,_40145,_40149),
    !.

also0([also0,[]],_40135,_40135) --> 
    [].

anaa([anaa,_40169,_40217,!],_40147,_40151) --> 
    ann0(_40169,_40147,_40199),
    ogaa(_40217,_40199,_40151),
    !.

ogaa([ogaa,lit(å)],_40139,_40143) --> 
    cc(å,_40139,_40143).

ogaa([ogaa,lit(og)],_40139,_40143) --> 
    cc(og,_40139,_40143).

ann0([ann0,lit(an),!,_40205],_40151,_40155) --> 
    cc(an,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

ann0([ann0,[]],_40135,_40135) --> 
    [].

anorder(a,_40113,[anorder,_40199,_40247],_40165,_40169) --> 
    a(_40199,_40165,_40229),
    w(nb(_40113,ord),_40247,_40229,_40169).

anorder(the,_40113,[anorder,_40199,_40247],_40165,_40169) --> 
    the(_40199,_40165,_40229),
    w(nb(_40113,ord),_40247,_40229,_40169).

another([another,_40163,_40211],_40141,_40145) --> 
    a(_40163,_40141,_40193),
    other(_40211,_40193,_40145).

around0([around0,_40157],_40135,_40139) --> 
    around1(_40157,_40135,_40139).

around0([around0,[]],_40135,_40135) --> 
    [].

around1([around1,_40157],_40135,_40139) --> 
    ca(_40157,_40135,_40139).

around1([around1,lit(om),lit(lag)],_40149,_40153) --> 
    cc(om,_40149,_40191),
    cc(lag,_40191,_40153).

around1([around1,_40161],_40139,_40143) --> 
    prep1(around,_40161,_40139,_40143).

as([as,lit(som)],_40139,_40143) --> 
    cc(som,_40139,_40143).

as0([as0,_40157],_40135,_40139) --> 
    as(_40157,_40135,_40139).

as0([as0,[]],_40135,_40135) --> 
    [].

andsoon([andsoon,lit(og),_40189],_40145,_40149) --> 
    cc(og,_40145,_40187),
    sovidere0(_40189,_40187,_40149).

sovidere0([sovidere0,_40163,_40211],_40141,_40145) --> 
    sov0(_40163,_40141,_40193),
    videre0(_40211,_40193,_40145).

sov0([sov0,lit(så)],_40139,_40143) --> 
    cc(så,_40139,_40143).

sov0([sov0,[]],_40135,_40135) --> 
    [].

videre0([videre0,lit(videre)],_40139,_40143) --> 
    cc(videre,_40139,_40143).

videre0([videre0,[]],_40135,_40135) --> 
    [].

aspossible0([aspossible0,_40169,!,_40227],_40147,_40151) --> 
    aspossible(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

aspossible0([aspossible0,_40157],_40135,_40139) --> 
    possible0(_40157,_40135,_40139).

aspossible([aspossible,_40173,_40221],_40151,_40155) --> 
    as(_40173,_40151,_40203),
    w(adj2(possible,nil),_40221,_40203,_40155).

aso0([aso0,lit(så),!,_40205],_40151,_40155) --> 
    cc(så,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

aso0([aso0,_40169,!,_40227],_40147,_40151) --> 
    too(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

aso0([aso0,_40157],_40135,_40139) --> 
    as(_40157,_40135,_40139).

aso0([aso0,[]],_40135,_40135) --> 
    [].

at([at,_40161],_40139,_40143) --> 
    prep(at,_40161,_40139,_40143).

athe([athe,_40157],_40135,_40139) --> 
    the(_40157,_40135,_40139).

athe([athe,_40157],_40135,_40139) --> 
    a(_40157,_40135,_40139).

athe0([athe0,_40163,!],_40141,_40145) --> 
    athe(_40163,_40141,_40145),
    !.

athe0([athe0,[]],_40135,_40135) --> 
    [].

blei(_40111,[blei,_40221,_40279,_40337,!],_40193,_40197) --> 
    w(verb(stand,pres,fin),_40221,_40193,_40255),
    negation0(_40111,_40279,_40255,_40313),
    look_ahead(w(verb(_40157,past,part)),_40337,_40313,_40197),
    !.

blei(_40111,[blei,_40181,_40229],_40153,_40157) --> 
    blei(_40181,_40153,_40211),
    negation0(_40111,_40229,_40211,_40157).

blei([blei,_40197,_40255,!],_40175,_40179) --> 
    w(verb(stand,pres,fin),_40197,_40175,_40231),
    look_ahead(w(verb(_40143,past,part)),_40255,_40231,_40179),
    !.

blei([blei,_40175,!],_40153,_40157) --> 
    w(verb(be,_40123,fin),_40175,_40153,_40157),
    !.

blei([blei,_40187,_40235,_40283,!],_40165,_40169) --> 
    has(_40187,_40165,_40217),
    redundant0(_40235,_40217,_40265),
    w(verb(be,past,part),_40283,_40265,_40169),
    !.

blei([blei,_40181,_40229,!],_40159,_40163) --> 
    aux1(_40181,_40159,_40211),
    w(verb(be,past,part),_40229,_40211,_40163),
    !.

blei([blei,_40181,_40229,!],_40159,_40163) --> 
    aux1(_40181,_40159,_40211),
    w(verb(be,inf,fin),_40229,_40211,_40163),
    !.

aux0(_40111,_40113,[aux0,_40195,!],_40161,_40165) --> 
    aux1(_40111,_40113,_40195,_40161,_40165),
    !.

aux0(id,pres,[aux0,_40183],_40149,_40153) --> 
    aux0(_40183,_40149,_40153).

auxs0(_40111,_40113,[auxs0,_40195,!],_40161,_40165) --> 
    aux1(_40111,_40113,_40195,_40161,_40165),
    !.

auxs0(_40111,_40113,[auxs0,[]],_40149,_40149) --> 
    [].

auxs([auxs,_40163,_40211],_40141,_40145) --> 
    aux1(_40163,_40141,_40193),
    auxs0(_40211,_40193,_40145).

auxs0([auxs0,_40169,!,_40227],_40147,_40151) --> 
    aux1(_40169,_40147,_40199),
    !,
    auxs0(_40227,_40199,_40151).

auxs0([auxs0,[]],_40135,_40135) --> 
    [].

aux1(_40111,pres,[aux1,lit(kan),_40253,_40301,_40359,!],_40197,_40201) --> 
    cc(kan,_40197,_40251),
    redundant0(_40253,_40251,_40283),
    negation0(_40111,_40301,_40283,_40335),
    look_ahead(w(verb(_40157,_40159,_40161)),_40359,_40335,_40201),
    !.

aux1(_40111,past,[aux1,lit(kunne),_40247,_40305,!],_40191,_40195) --> 
    cc(kunne,_40191,_40245),
    negation0(_40111,_40247,_40245,_40281),
    look_ahead(w(verb(_40151,_40153,_40155)),_40305,_40281,_40195),
    !.

aux1(_40111,past,[aux1,lit(burde),_40225,!],_40169,_40173) --> 
    cc(burde,_40169,_40223),
    negation0(_40111,_40225,_40223,_40173),
    !.

aux1(_40111,past,[aux1,lit(kunne),_40225,!],_40169,_40173) --> 
    cc(kunne,_40169,_40223),
    negation0(_40111,_40225,_40223,_40173),
    !.

aux1(_40111,pres,[aux1,_40193,_40241],_40159,_40163) --> 
    aux1(_40193,_40159,_40223),
    negation0(_40111,_40241,_40223,_40163).

skalsaa([skalsaa,_40163,_40211],_40141,_40145) --> 
    aux1(_40163,_40141,_40193),
    so0(_40211,_40193,_40145).

faux1([faux1,_40175,!],_40153,_40157) --> 
    w(verb(get,_40123,fin),_40175,_40153,_40157),
    !.

faux1([faux1,_40157],_40135,_40139) --> 
    aux1(_40157,_40135,_40139).

aux1([aux1,_40219,_40277,_40335,!],_40197,_40201) --> 
    one_of_lit([kan,kunne,får,fikk],_40219,_40197,_40253),
    not_look_ahead([nå],_40277,_40253,_40311),
    look_ahead(w(verb(_40165,inf,_40169)),_40335,_40311,_40201),
    !.

aux1([aux1,_40169],_40147,_40151) --> 
    one_of_lit([kan,kunne],_40169,_40147,_40151).

aux1([aux1,_40193],_40171,_40175) --> 
    one_of_lit([bør,burde,må,måtte,skal,skulle,vil,ville],_40193,_40171,_40175).

aux10([aux10,_40163,!],_40141,_40145) --> 
    aux1(_40163,_40141,_40145),
    !.

aux10([aux10,[]],_40135,_40135) --> 
    [].

aux0([aux0,_40185,_40233,!],_40163,_40167) --> 
    faa(_40185,_40163,_40215),
    look_ahead(w(verb(_40131,_40133,_40135)),_40233,_40215,_40167),
    !.

aux0([aux0,lit(må)],_40139,_40143) --> 
    cc(må,_40139,_40143).

aux0([aux0,_40205,lit(så),_40275,lit(å),!,_40365],_40183,_40187) --> 
    be(_40205,_40183,_40235),
    cc(så,_40235,_40273),
    w(adj2(good,nil),_40275,_40273,_40309),
    cc(å,_40309,_40353),
    !,
    accept(_40365,_40353,_40187).

aux0([aux0,_40157],_40135,_40139) --> 
    do(_40157,_40135,_40139).

aux0([aux0,[]],_40135,_40135) --> 
    [].

paux0([paux0,_40173,lit(blitt),!],_40151,_40155) --> 
    has(_40173,_40151,_40203),
    cc(blitt,_40203,_40155),
    !.

paux0([paux0,lit(vil),lit(bli),!],_40155,_40159) --> 
    cc(vil,_40155,_40197),
    cc(bli,_40197,_40159),
    !.

paux0([paux0,lit(_40121),{},!],_40201,_40205) --> 
    cc(_40121,_40201,_40205),
    {testmember(_40121,[skal,vil,bør,må,kan,skulle,ville,burde,måtte,kunne])},
    !.

paux0([paux0,[]],_40135,_40135) --> 
    [].

do(_40111,[do,_40187,_40235,_40293],_40159,_40163) --> 
    use(_40187,_40159,_40217),
    negation0(_40111,_40235,_40217,_40269),
    infinitive(_40293,_40269,_40163).

do(_40111,[do,_40187,_40235,_40293],_40159,_40163) --> 
    do(_40187,_40159,_40217),
    negation0(_40111,_40235,_40217,_40269),
    hasto0(_40293,_40269,_40163).

do(id,[do,[]],_40143,_40143) --> 
    [].

do0([do0,_40157],_40135,_40139) --> 
    do(_40157,_40135,_40139).

do0([do0,[]],_40135,_40135) --> 
    [].

docan([docan,lit(kan)],_40139,_40143) --> 
    cc(kan,_40139,_40143).

docan([docan,lit(må)],_40139,_40143) --> 
    cc(må,_40139,_40143).

docan([docan,lit(får)],_40139,_40143) --> 
    cc(får,_40139,_40143).

docan([docan,_40163,!],_40141,_40145) --> 
    do(_40163,_40141,_40145),
    !.

do([do,_40189,_40237,!,_40305],_40167,_40171) --> 
    faa(_40189,_40167,_40219),
    w(noun(information,_40135,_40137,_40139),_40237,_40219,_40271),
    !,
    reject(_40305,_40271,_40171).

do([do,lit(vil),lit(vil),!,_40237],_40161,_40165) --> 
    cc(vil,_40161,_40203),
    cc(vil,_40203,_40225),
    !,
    accept(_40237,_40225,_40165).

do([do,_40157],_40135,_40139) --> 
    skalsaa(_40157,_40135,_40139).

do([do,_40157],_40135,_40139) --> 
    may(_40157,_40135,_40139).

do([do,_40157],_40135,_40139) --> 
    must(_40157,_40135,_40139).

may([may,lit(kan),_40205],_40161,_40165) --> 
    cc(kan,_40161,_40203),
    look_ahead(w(verb(_40125,_40127,_40129)),_40205,_40203,_40165).

may([may,lit(får),_40205],_40161,_40165) --> 
    cc(får,_40161,_40203),
    look_ahead(w(verb(_40125,_40127,_40129)),_40205,_40203,_40165).

may([may,lit(bør)],_40139,_40143) --> 
    cc(bør,_40139,_40143).

may([may,lit(må)],_40139,_40143) --> 
    cc(må,_40139,_40143).

must([must,lit(må)],_40139,_40143) --> 
    cc(må,_40139,_40143).

must([must,lit(skal)],_40139,_40143) --> 
    cc(skal,_40139,_40143).

be(_40111,[be,_40233,_40291,_40349,!,_40407,{}],_40205,_40209) --> 
    w(verb(hold,_40163,fin),_40233,_40205,_40267),
    negation0(_40149,_40291,_40267,_40325),
    rfxpron(_40349,_40325,_40379),
    !,
    negation0(_40151,_40407,_40379,_40209),
    {bigno(_40149,_40151,_40111)}.

be(_40111,[be,_40187,!,_40255],_40159,_40163) --> 
    be1(_40111,_40187,_40159,_40221),
    !,
    accept(_40255,_40221,_40163).

be(not,[be,_40177,_40225],_40149,_40153) --> 
    not(_40177,_40149,_40207),
    be(_40225,_40207,_40153).

be(id,[be,_40171],_40143,_40147) --> 
    be(_40171,_40143,_40147).

be0([be0,_40161],_40139,_40143) --> 
    optional(be,_40161,_40139,_40143).

be([be,_40181,_40229,!],_40159,_40163) --> 
    aux1(_40181,_40159,_40211),
    w(verb(be,inf,fin),_40229,_40211,_40163),
    !.

be([be,_40199,_40257,_40305,!],_40177,_40181) --> 
    w(verb(have,_40135,fin),_40199,_40177,_40233),
    redundant0(_40257,_40233,_40287),
    w(verb(be,past,part),_40305,_40287,_40181),
    !.

be([be,_40175,!],_40153,_40157) --> 
    w(verb(be,_40123,part),_40175,_40153,_40157),
    !.

be([be,_40181,_40239,!],_40159,_40163) --> 
    w(verb(be,_40129,fin),_40181,_40159,_40215),
    been0(_40239,_40215,_40163),
    !.

be1(_40111,[be1,_40199,_40257,_40305],_40171,_40175) --> 
    w(verb(be,_40137,fin),_40199,_40171,_40233),
    redundant0(_40257,_40233,_40287),
    negation0(_40111,_40305,_40287,_40175).

be1(_40111,[be1,_40205,_40253,_40301,_40359],_40177,_40181) --> 
    aux1(_40205,_40177,_40235),
    redundant0(_40253,_40235,_40283),
    negation0(_40111,_40301,_40283,_40335),
    w(verb(be,inf,fin),_40359,_40335,_40181).

be1(_40111,[be1,_40217,_40275,_40323,_40391,!],_40189,_40193) --> 
    negation0(_40139,_40217,_40189,_40251),
    aux1(_40275,_40251,_40305),
    negation2(_40139,_40111,_40323,_40305,_40361),
    w(verb(be,inf,fin),_40391,_40361,_40193),
    !.

be1(_40111,[be1,_40217,_40275,_40333,!],_40189,_40193) --> 
    w(verb(have,_40139,fin),_40217,_40189,_40251),
    negation0(_40111,_40275,_40251,_40309),
    w(verb(be,past,part),_40333,_40309,_40193),
    !.

be1(_40111,[be1,_40199,_40257,_40305,_40353],_40171,_40175) --> 
    negation0(_40133,_40199,_40171,_40233),
    be(_40257,_40233,_40287),
    redundant0(_40305,_40287,_40335),
    negation2(_40133,_40111,_40353,_40335,_40175).

be1(_40111,[be1,_40203,_40261,lit(blitt)],_40175,_40179) --> 
    w(verb(have,_40137,fin),_40203,_40175,_40237),
    negation0(_40111,_40261,_40237,_40295),
    cc(blitt,_40295,_40179).

be1(id,[be1,lit(blitt)],_40147,_40151) --> 
    cc(blitt,_40147,_40151).

be1(not,[be1,_40199,_40257,_40315],_40171,_40175) --> 
    w(verb(reject,_40133,fin),_40199,_40171,_40233),
    prep(to,_40257,_40233,_40291),
    be(_40315,_40291,_40175).

be_truefalse_that(_40111,[be_truefalse_that,_40239,{},_40311,lit(ut),_40391,!],_40211,_40215) --> 
    w(verb(_40149,_40151,fin),_40239,_40211,_40273),
    {testmember(_40149,[look,see])},
    negation0(_40111,_40311,_40273,_40345),
    cc(ut,_40345,_40389),
    somatom0(_40391,_40389,_40215),
    !.

be_truefalse_that(_40111,[be_truefalse_that,_40239,{},_40311,lit(ut),_40391,!],_40211,_40215) --> 
    w(verb(_40149,_40151,fin),_40239,_40211,_40273),
    {testmember(_40149,[look,see])},
    negation0(_40111,_40311,_40273,_40345),
    cc(ut,_40345,_40389),
    somatom0(_40391,_40389,_40215),
    !.

be_truefalse_that(_40111,[be_truefalse_that,_40229,{},_40301,_40359,!],_40201,_40205) --> 
    w(verb(_40143,_40145,fin),_40229,_40201,_40263),
    {testmember(_40143,[appear,be])},
    negation0(_40111,_40301,_40263,_40335),
    somatom0(_40359,_40335,_40205),
    !.

somatom0([somatom0,_40163,!],_40141,_40145) --> 
    somatom(_40163,_40141,_40145),
    !.

somatom0([somatom0,[]],_40135,_40135) --> 
    [].

somatom([somatom,_40183,lit(at),!],_40161,_40165) --> 
    w(adj2(true,nil),_40183,_40161,_40217),
    cc(at,_40217,_40165),
    !.

somatom([somatom,lit(som),lit(at),!],_40155,_40159) --> 
    cc(som,_40155,_40197),
    cc(at,_40197,_40159),
    !.

somatom([somatom,lit(som),lit(om),!],_40155,_40159) --> 
    cc(som,_40155,_40197),
    cc(om,_40197,_40159),
    !.

somatom([somatom,lit(som)],_40139,_40143) --> 
    cc(som,_40139,_40143).

somatom([somatom,lit(at)],_40139,_40143) --> 
    cc(at,_40139,_40143).

somatom([somatom,lit(til),lit(at),!],_40155,_40159) --> 
    cc(til,_40155,_40197),
    cc(at,_40197,_40159),
    !.

somatom([somatom,lit(til)],_40139,_40143) --> 
    cc(til,_40139,_40143).

be_truefalse_that(_40111,[be_truefalse_that,_40233,_40291,_40359,_40417,!],_40205,_40209) --> 
    w(verb(_40143,_40145,fin),_40233,_40205,_40267),
    gmem(_40143,[agree,appear],_40291,_40267,_40329),
    negation0(_40111,_40359,_40329,_40393),
    optional([at],_40417,_40393,_40209),
    !.

be_truefalse_that(_40111,[be_truefalse_that,_40213,_40271,_40329,!],_40185,_40189) --> 
    negation0(_40111,_40213,_40185,_40247),
    one_of_lit([så,slik],_40271,_40247,_40305),
    optional([at],_40329,_40305,_40189),
    !.

be_truefalse_that(id,[be_truefalse_that,_40213,_40271,lit(at),!],_40185,_40189) --> 
    w(verb(show,_40139,fin),_40213,_40185,_40247),
    optional([seg],_40271,_40247,_40335),
    cc(at,_40335,_40189),
    !.

be_truefalse_that(_40111,[be_truefalse_that,_40239,{},_40311,lit(ut),_40391,!],_40211,_40215) --> 
    w(verb(_40149,_40151,fin),_40239,_40211,_40273),
    {testmember(_40149,[see,look])},
    negation0(_40111,_40311,_40273,_40345),
    cc(ut,_40345,_40389),
    somatom(_40391,_40389,_40215),
    !.

be_truefalse_that(_40111,[be_truefalse_that,_40229,{},_40301,_40359,!],_40201,_40205) --> 
    w(verb(_40143,_40145,fin),_40229,_40201,_40263),
    {testmember(_40143,[be,appear])},
    negation0(_40111,_40301,_40263,_40335),
    somatom(_40359,_40335,_40205),
    !.

be_truefalse_that(_40111,[be_truefalse_that,_40195,_40253,!],_40167,_40171) --> 
    be_truefalse(_40111,_40195,_40167,_40229),
    optional([at],_40253,_40229,_40171),
    !.

be_truefalse(_40111,[be_truefalse,_40229,{},_40301,_40359,!],_40201,_40205) --> 
    w(verb(_40143,_40145,fin),_40229,_40201,_40263),
    {testmember(_40143,[be,appear])},
    negation0(_40111,_40301,_40263,_40335),
    somatom(_40359,_40335,_40205),
    !.

be_truefalse(_40111,[be_truefalse,_40213,_40311,!],_40185,_40189) --> 
    lexvaccept(rv,_40129,_40131,fin,_40111,_40213,_40185,_40263),
    gmem(_40129,[stand,mean2,indicate],_40311,_40263,_40189),
    !.

be_truefalse(_40111,[be_truefalse,_40243,{},_40315,lit(ut),lit(til),!],_40215,_40219) --> 
    w(verb(_40149,_40151,fin),_40243,_40215,_40277),
    {testmember(_40149,[see,look])},
    negation0(_40111,_40315,_40277,_40349),
    cc(ut,_40349,_40393),
    cc(til,_40393,_40219),
    !.

be_truefalse(_40111,[be_truefalse,_40243,{},_40315,lit(ut),lit(for),!],_40215,_40219) --> 
    w(verb(_40149,_40151,fin),_40243,_40215,_40277),
    {testmember(_40149,[see,look])},
    negation0(_40111,_40315,_40277,_40349),
    cc(ut,_40349,_40393),
    cc(for,_40393,_40219),
    !.

be_truefalse(_40111,[be_truefalse,_40243,{},_40315,lit(ut),lit(som),!],_40215,_40219) --> 
    w(verb(_40149,_40151,fin),_40243,_40215,_40277),
    {testmember(_40149,[see,look])},
    negation0(_40111,_40315,_40277,_40349),
    cc(ut,_40349,_40393),
    cc(som,_40393,_40219),
    !.

be_truefalse(_40111,[be_truefalse,_40199,!,_40267],_40171,_40175) --> 
    w(verb(agree,_40137,fin),_40199,_40171,_40233),
    !,
    negation0(_40111,_40267,_40233,_40175).

be_truefalse(_40111,[be_truefalse,_40181,_40229],_40153,_40157) --> 
    be(_40181,_40153,_40211),
    truefalse(_40111,_40229,_40211,_40157).

be_truefalse(not,[be_truefalse,_40201,_40259,_40307,_40355],_40173,_40177) --> 
    w(verb(reject,_40139,fin),_40201,_40173,_40235),
    infinitive(_40259,_40235,_40289),
    be(_40307,_40289,_40337),
    true(_40355,_40337,_40177).

been0([been0,_40169,!,_40227],_40147,_40151) --> 
    been(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

been0([been0,[]],_40135,_40135) --> 
    [].

been([been,_40169],_40147,_40151) --> 
    w(verb(be,past,part),_40169,_40147,_40151).

betake([betake,_40157],_40135,_40139) --> 
    be(_40157,_40135,_40139).

betake([betake,_40169],_40147,_40151) --> 
    w(verb(take,_40117,fin),_40169,_40147,_40151).

both0([both0,lit(både)],_40139,_40143) --> 
    cc(både,_40139,_40143).

both0([both0,[]],_40135,_40135) --> 
    [].

by([by,lit(av),_40197],_40153,_40157) --> 
    cc(av,_40153,_40195),
    not_look_ahead([hensyn],_40197,_40195,_40157).

ca0([ca0,_40169,!,_40227],_40147,_40151) --> 
    ca(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

ca0([ca0,[]],_40135,_40135) --> 
    [].

ca([ca,_40179,_40237,!,_40295],_40157,_40161) --> 
    prep1(around,_40179,_40157,_40213),
    point0(_40237,_40213,_40267),
    !,
    accept(_40295,_40267,_40161).

clock0([clock0,_40157],_40135,_40139) --> 
    clock(_40157,_40135,_40139).

clock0([clock0,[]],_40135,_40135) --> 
    [].

clock([clock,lit(k),_40209,!],_40165,_40169) --> 
    cc(k,_40165,_40207),
    look_ahead(w(nb(_40135,_40137)),_40209,_40207,_40169),
    !.

clock([clock,lit(k),_40215,_40263,!],_40171,_40175) --> 
    cc(k,_40171,_40213),
    point(_40215,_40213,_40245),
    look_ahead(w(nb(_40141,_40143)),_40263,_40245,_40175),
    !.

clock([clock,lit(kl),_40195,!],_40151,_40155) --> 
    cc(kl,_40151,_40193),
    colon(_40195,_40193,_40155),
    !.

clock([clock,_40175,_40223,_40271,_40319],_40153,_40157) --> 
    point0(_40175,_40153,_40205),
    klokken(_40223,_40205,_40253),
    point0(_40271,_40253,_40301),
    ca0(_40319,_40301,_40157).

clock([clock,_40169,_40217,_40265],_40147,_40151) --> 
    point0(_40169,_40147,_40199),
    klokken(_40217,_40199,_40247),
    colon0(_40265,_40247,_40151).

klokken([klokken,lit(kl)],_40139,_40143) --> 
    cc(kl,_40139,_40143).

klokken([klokken,_40171],_40149,_40153) --> 
    w(noun(clock,sin,_40119,n),_40171,_40149,_40153).

colon0([colon0,_40169,!,_40227],_40147,_40151) --> 
    colon(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

colon0([colon0,_40165],_40143,_40147) --> 
    not_look_ahead(['.'],_40165,_40143,_40147).

colon([colon,lit(:)],_40139,_40143) --> 
    cc(:,_40139,_40143).

colon([colon,lit(;)],_40139,_40143) --> 
    cc(;,_40139,_40143).

comparator1(_40111,[comparator1,_40181,!],_40153,_40157) --> 
    comparel(_40111,_40181,_40153,_40157),
    !.

comparel(eq,[comparel,_40177,_40225],_40149,_40153) --> 
    equal(_40177,_40149,_40207),
    tomed0(_40225,_40207,_40153).

comparel(ge,[comparel,_40195,_40243,_40291,_40339,_40387],_40167,_40171) --> 
    greater(_40195,_40167,_40225),
    than0(_40243,_40225,_40273),
    or1(_40291,_40273,_40321),
    equal(_40339,_40321,_40369),
    to0(_40387,_40369,_40171).

comparel(ge,[comparel,_40183,_40231,_40279],_40155,_40159) --> 
    not(_40183,_40155,_40213),
    less(_40231,_40213,_40261),
    than(_40279,_40261,_40159).

comparel(ge,[comparel,lit(minst)],_40147,_40151) --> 
    cc(minst,_40147,_40151).

comparel(gt,[comparel,_40177,_40225],_40149,_40153) --> 
    greater(_40177,_40149,_40207),
    than(_40225,_40207,_40153).

comparel(gt,[comparel,lit(mer),_40203],_40153,_40157) --> 
    cc(mer,_40153,_40201),
    than(_40203,_40201,_40157).

comparel(gt,[comparel,_40175],_40147,_40151) --> 
    prep1(over,_40175,_40147,_40151).

comparel(le,[comparel,_40195,_40243,_40291,_40339,_40387],_40167,_40171) --> 
    less(_40195,_40167,_40225),
    than0(_40243,_40225,_40273),
    or1(_40291,_40273,_40321),
    equal(_40339,_40321,_40369),
    to0(_40387,_40369,_40171).

comparel(le,[comparel,_40183,_40231,_40279],_40155,_40159) --> 
    not(_40183,_40155,_40213),
    more(_40231,_40213,_40261),
    than(_40279,_40261,_40159).

comparel(le,[comparel,_40183,_40231,_40279],_40155,_40159) --> 
    not(_40183,_40155,_40213),
    greater(_40231,_40213,_40261),
    than(_40279,_40261,_40159).

comparel(le,[comparel,_40177,_40225],_40149,_40153) --> 
    at(_40177,_40149,_40207),
    most(_40225,_40207,_40153).

comparel(lt,[comparel,_40177,_40225],_40149,_40153) --> 
    less(_40177,_40149,_40207),
    than(_40225,_40207,_40153).

comparel(ne,[comparel,lit(forskjellig),_40207],_40157,_40161) --> 
    cc(forskjellig,_40157,_40205),
    prep1(from,_40207,_40205,_40161).

comparel(ne,[comparel,lit(annet),lit(enn)],_40157,_40161) --> 
    cc(annet,_40157,_40205),
    cc(enn,_40205,_40161).

comparel(ne,[comparel,lit(ulik)],_40147,_40151) --> 
    cc(ulik,_40147,_40151).

comparel(ne,[comparel,lit(unntatt)],_40147,_40151) --> 
    cc(unntatt,_40147,_40151).

comparel(ne,[comparel,_40177,_40225],_40149,_40153) --> 
    unequal(_40177,_40149,_40207),
    to0(_40225,_40207,_40153).

comparel(_40111,[comparel,_40191,lit(enn)],_40163,_40167) --> 
    w(adj2(_40111,comp),_40191,_40163,_40225),
    cc(enn,_40225,_40167).

comparel(_40111,[comparel,lit(mer),_40223,lit(enn)],_40173,_40177) --> 
    cc(mer,_40173,_40221),
    w(adj2(_40111,nil),_40223,_40221,_40257),
    cc(enn,_40257,_40177).

comparator2(gt,intelligent,[comparator2,_40199,_40257],_40165,_40169) --> 
    w(adj2(intelligent,nil),_40199,_40165,_40233),
    than(_40257,_40233,_40169).

comparator2(lt,intelligent,[comparator2,_40199,_40257],_40165,_40169) --> 
    w(adj2(stupid,nil),_40199,_40165,_40233),
    than(_40257,_40233,_40169).

comparator2(gt,quality,[comparator2,_40199,_40257],_40165,_40169) --> 
    w(adj2(good,comp),_40199,_40165,_40233),
    than(_40257,_40233,_40169).

comparator2(gt,age,[comparator2,_40189,_40237],_40155,_40159) --> 
    older(_40189,_40155,_40219),
    than(_40237,_40219,_40159).

comparator2(lt,age,[comparator2,_40189,_40237],_40155,_40159) --> 
    younger(_40189,_40155,_40219),
    than(_40237,_40219,_40159).

comparator2(gt,latitude,[comparator2,lit(nord),lit(for)],_40163,_40167) --> 
    cc(nord,_40163,_40217),
    cc(for,_40217,_40167).

comparator2(lt,latitude,[comparator2,lit(sør),lit(for)],_40163,_40167) --> 
    cc(sør,_40163,_40217),
    cc(for,_40217,_40167).

comparator2(gt,longitude,[comparator2,lit(vest),lit(for)],_40163,_40167) --> 
    cc(vest,_40163,_40217),
    cc(for,_40217,_40167).

comparator2(lt,longitude,[comparator2,lit(øst),lit(for)],_40163,_40167) --> 
    cc(øst,_40163,_40217),
    cc(for,_40217,_40167).

comparator2(gt,size,[comparator2,_40189,_40237],_40155,_40159) --> 
    greater(_40189,_40155,_40219),
    than(_40237,_40219,_40159).

comparator2(lt,size,[comparator2,lit(mindre),_40215],_40159,_40163) --> 
    cc(mindre,_40159,_40213),
    than(_40215,_40213,_40163).

comparator3(eq,_40113,[comparator3,lit(like),_40235,lit(som)],_40179,_40183) --> 
    cc(like,_40179,_40233),
    w(adj2(_40113,nil),_40235,_40233,_40269),
    cc(som,_40269,_40183).

comparator3(gt,_40113,[comparator3,lit(mer),_40235,lit(enn)],_40179,_40183) --> 
    cc(mer,_40179,_40233),
    w(adj2(_40113,nil),_40235,_40233,_40269),
    cc(enn,_40269,_40183).

comparator3(lt,_40113,[comparator3,lit(mindre),_40235,lit(enn)],_40179,_40183) --> 
    cc(mindre,_40179,_40233),
    w(adj2(_40113,nil),_40235,_40233,_40269),
    cc(enn,_40269,_40183).

comparator3(lt,_40113,[comparator3,lit(ikke),lit(så),_40267,lit(som)],_40189,_40193) --> 
    cc(ikke,_40189,_40243),
    cc(så,_40243,_40265),
    w(adj2(_40113,nil),_40267,_40265,_40301),
    cc(som,_40301,_40193).

comparator3(ge,_40113,[comparator3,lit(minst),lit(like),_40267,lit(som)],_40189,_40193) --> 
    cc(minst,_40189,_40243),
    cc(like,_40243,_40265),
    w(adj2(_40113,nil),_40267,_40265,_40301),
    cc(som,_40301,_40193).

comparator3(le,_40113,[comparator3,lit(høyst),lit(så),_40267,lit(som)],_40189,_40193) --> 
    cc(høyst,_40189,_40243),
    cc(så,_40243,_40265),
    w(adj2(_40113,nil),_40267,_40265,_40301),
    cc(som,_40301,_40193).

superlative(_40111,_40113,[superlative,_40213,_40291,!,_40359],_40179,_40183) --> 
    filanepr(_40111,_40137,_40113,_40213,_40179,_40255),
    quant1(_40137,_40291,_40255,_40325),
    !,
    accept(_40359,_40325,_40183).

superlative(_40111,_40113,[superlative,_40201,_40259],_40167,_40171) --> 
    quant0(_40125,_40201,_40167,_40235),
    filanepr(_40111,_40125,_40113,_40259,_40235,_40171).

flnp(_40111,[flnp,_40209,_40267],_40181,_40185) --> 
    w(adj2(_40111,nil),_40209,_40181,_40243),
    gmem(_40111,[first,last,next,previous],_40267,_40243,_40185).

flnp(next,[flnp,lit(nest)],_40147,_40151) --> 
    cc(nest,_40147,_40151).

flnp(last,[flnp,_40187,!],_40159,_40163) --> 
    w(adj2(late,sup),_40187,_40159,_40163),
    !.

flnp(first,[flnp,_40181],_40153,_40157) --> 
    w(nb(1,ord),_40181,_40153,_40157).

flnpproper(_40111,[flnpproper,lit(først),!,_40219],_40159,_40163) --> 
    cc(først,_40159,_40207),
    !,
    reject(_40219,_40207,_40163).

flnpproper(_40111,[flnpproper,lit(sist),!,_40219],_40159,_40163) --> 
    cc(sist,_40159,_40207),
    !,
    reject(_40219,_40207,_40163).

flnpproper(_40111,[flnpproper,lit(nest),!,_40219],_40159,_40163) --> 
    cc(nest,_40159,_40207),
    !,
    reject(_40219,_40207,_40163).

flnpproper(_40111,[flnpproper,_40175],_40147,_40151) --> 
    flnp(_40111,_40175,_40147,_40151).

filanepr([filanepr,_40173,!],_40151,_40155) --> 
    w(adj2(first,nil),_40173,_40151,_40155),
    !.

filanepr([filanepr,_40173,!],_40151,_40155) --> 
    w(adj2(last,nil),_40173,_40151,_40155),
    !.

filanepr([filanepr,_40173,!],_40151,_40155) --> 
    w(adj2(next,nil),_40173,_40151,_40155),
    !.

filanepr([filanepr,_40173,!],_40151,_40155) --> 
    w(adj2(previous,nil),_40173,_40151,_40155),
    !.

filanepr(min(_40113),_40113,time,[filanepr,_40199],_40159,_40163) --> 
    first(_40199,_40159,_40163).

filanepr(max(_40113),_40113,time,[filanepr,_40199],_40159,_40163) --> 
    latest(_40199,_40159,_40163).

filanepr(min(_40113),_40113,next,[filanepr,_40199],_40159,_40163) --> 
    next(_40199,_40159,_40163).

filanepr(max(_40113),_40113,previous,[filanepr,_40199],_40159,_40163) --> 
    previous(_40199,_40159,_40163).

filanepr(max(_40113),_40113,size,[filanepr,_40199],_40159,_40163) --> 
    greatest(_40199,_40159,_40163).

filanepr(min(_40113),_40113,size,[filanepr,lit(minste)],_40163,_40167) --> 
    cc(minste,_40163,_40167).

faaverb(_40111,[faaverb,_40195,_40243,!],_40167,_40171) --> 
    faa(_40195,_40167,_40225),
    w(verb(_40111,_40133,_40135),_40243,_40225,_40171),
    !.

faaverb(_40111,[faaverb,_40189,!],_40161,_40165) --> 
    w(verb(_40111,inf,fin),_40189,_40161,_40165),
    !.

da0([da0,lit(da),!,_40205],_40151,_40155) --> 
    cc(da,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

da0([da0,[]],_40135,_40135) --> 
    [].

de0([de0,lit(de),!,_40205],_40151,_40155) --> 
    cc(de,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

de0([de0,[]],_40135,_40135) --> 
    [].

dendagen(_40111,[dendagen,lit(om),_40225,_40283,!,_40341],_40175,_40179) --> 
    cc(om,_40175,_40223),
    day(_40111,_40225,_40223,_40259),
    den0(_40283,_40259,_40313),
    !,
    accept(_40341,_40313,_40179).

dendagen(nil,[dendagen,_40189,_40237,!,_40295],_40161,_40165) --> 
    today(_40189,_40161,_40219),
    den0(_40237,_40219,_40267),
    !,
    accept(_40295,_40267,_40165).

dendagen(nil,[dendagen,_40189,_40237,!,_40295],_40161,_40165) --> 
    yesterday(_40189,_40161,_40219),
    den0(_40237,_40219,_40267),
    !,
    accept(_40295,_40267,_40165).

dendagen(nil,[dendagen,_40189,_40237,!,_40295],_40161,_40165) --> 
    tomorrow(_40189,_40161,_40219),
    den0(_40237,_40219,_40267),
    !,
    accept(_40295,_40267,_40165).

dendagen(_40111,[dendagen,_40199,_40247,_40305,!,_40363],_40171,_40175) --> 
    on0(_40199,_40171,_40229),
    day(_40111,_40247,_40229,_40281),
    den0(_40305,_40281,_40335),
    !,
    accept(_40363,_40335,_40175).

dendagen(nil,[dendagen,_40193,lit(den),!,_40273],_40165,_40169) --> 
    on0(_40193,_40165,_40223),
    cc(den,_40223,_40261),
    !,
    accept(_40273,_40261,_40169).

dendagen(nil,[dendagen,_40193,_40251,!,_40309],_40165,_40169) --> 
    prep1(for,_40193,_40165,_40227),
    den0(_40251,_40227,_40281),
    !,
    accept(_40309,_40281,_40169).

dendagen(nil,[dendagen,_40187,!,_40255],_40159,_40163) --> 
    prep1(on,_40187,_40159,_40221),
    !,
    accept(_40255,_40221,_40163).

der0([der0,lit(der),_40201,!,_40259],_40157,_40161) --> 
    cc(der,_40157,_40199),
    qm0(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

der0([der0,_40157],_40135,_40139) --> 
    qm0(_40157,_40135,_40139).

qm0([qm0,lit(?)],_40139,_40143) --> 
    cc(?,_40139,_40143).

qm0([qm0,[]],_40135,_40135) --> 
    [].

detsamme([detsamme,lit(en),lit(gang)],_40149,_40153) --> 
    cc(en,_40149,_40191),
    cc(gang,_40191,_40153).

detsamme([detsamme,_40181,lit(det),lit(samme)],_40159,_40163) --> 
    prep1(with,_40181,_40159,_40215),
    cc(det,_40215,_40259),
    cc(samme,_40259,_40163).

den0([den0,_40163,!],_40141,_40145) --> 
    den(_40163,_40141,_40145),
    !.

den0([den0,[]],_40135,_40135) --> 
    [].

den([den,lit(den)],_40139,_40143) --> 
    cc(den,_40139,_40143).

dendet0([dendet0,_40171,!],_40149,_40153) --> 
    look_ahead([d],_40171,_40149,_40153),
    !.

dendet0([dendet0,lit(den),_40215,!,_40283],_40171,_40175) --> 
    cc(den,_40171,_40213),
    not_look_ahead(w(nb(_40141,_40143)),_40215,_40213,_40249),
    !,
    accept(_40283,_40249,_40175).

dendet0([dendet0,lit(det),!,_40205],_40151,_40155) --> 
    cc(det,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

dendet0([dendet0,[]],_40135,_40135) --> 
    [].

dent0([dent0,lit(den),!],_40145,_40149) --> 
    cc(den,_40145,_40149),
    !.

dent0([dent0,lit(det),!],_40145,_40149) --> 
    cc(det,_40145,_40149),
    !.

dent0([dent0,lit(de),!,_40205],_40151,_40155) --> 
    cc(de,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

dent0([dent0,lit(noen),!],_40145,_40149) --> 
    cc(noen,_40145,_40149),
    !.

dent0([dent0,lit(en),!],_40145,_40149) --> 
    cc(en,_40145,_40149),
    !.

dent0([dent0,[]],_40135,_40135) --> 
    [].

det0([det0,_40175,_40223,!,_40281],_40153,_40157) --> 
    thereit(_40175,_40153,_40205),
    thereit_not_pronoun(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

det0([det0,[]],_40135,_40135) --> 
    [].

dudet([dudet,lit(du)],_40139,_40143) --> 
    cc(du,_40139,_40143).

dudet([dudet,lit(det)],_40139,_40143) --> 
    cc(det,_40139,_40143).

dudet([dudet,_40161],_40139,_40143) --> 
    pronoun(_40111,_40161,_40139,_40143).

each([each,lit(alle),_40189],_40145,_40149) --> 
    cc(alle,_40145,_40187),
    the(_40189,_40187,_40149).

earlier([earlier,lit(tidligere)],_40139,_40143) --> 
    cc(tidligere,_40139,_40143).

earlier([earlier,_40171,lit(forhånd)],_40149,_40153) --> 
    prep1(on,_40171,_40149,_40205),
    cc(forhånd,_40205,_40153).

earlier([earlier,lit(derfør)],_40139,_40143) --> 
    cc(derfør,_40139,_40143).

either0([either0,lit(enten),!,_40205],_40151,_40155) --> 
    cc(enten,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

either0([either0,[]],_40135,_40135) --> 
    [].

equal([equal,lit(lik)],_40139,_40143) --> 
    cc(lik,_40139,_40143).

equal([equal,lit(likt)],_40139,_40143) --> 
    cc(likt,_40139,_40143).

iyou(du,[iyou,lit(du)],_40147,_40151) --> 
    cc(du,_40147,_40151).

iyou(jeg,[iyou,lit(jeg)],_40147,_40151) --> 
    cc(jeg,_40147,_40151).

iyou(vi,[iyou,lit(vi)],_40147,_40151) --> 
    cc(vi,_40147,_40151).

areyou([areyou,lit(erru),_40193],_40149,_40153) --> 
    cc(erru,_40149,_40191),
    negation0(_40117,_40193,_40191,_40153).

areyou([areyou,_40189,lit(du),_40269],_40167,_40171) --> 
    w(verb(be,_40133,fin),_40189,_40167,_40223),
    cc(du,_40223,_40267),
    negation0(_40123,_40269,_40267,_40171).

areyou([areyou,lit(vil),lit(du),_40243,_40301],_40177,_40181) --> 
    cc(vil,_40177,_40219),
    cc(du,_40219,_40241),
    negation0(_40149,_40243,_40241,_40277),
    w(verb(be,_40135,fin),_40301,_40277,_40181).

every([every,lit(alle),_40189],_40145,_40149) --> 
    cc(alle,_40145,_40187),
    de0(_40189,_40187,_40149).

every([every,lit(en),lit(hver)],_40149,_40153) --> 
    cc(en,_40149,_40191),
    cc(hver,_40191,_40153).

false([false,lit(galt)],_40139,_40143) --> 
    cc(galt,_40139,_40143).

false([false,lit(usant)],_40139,_40143) --> 
    cc(usant,_40139,_40143).

false([false,lit(feil)],_40139,_40143) --> 
    cc(feil,_40139,_40143).

false([false,lit(uriktig)],_40139,_40143) --> 
    cc(uriktig,_40139,_40143).

few([few,lit(få)],_40139,_40143) --> 
    cc(få,_40139,_40143).

few([few,lit(fåtallig)],_40139,_40143) --> 
    cc(fåtallig,_40139,_40143).

first([first,_40167],_40145,_40149) --> 
    w(adj2(first,nil),_40167,_40145,_40149).

first([first,lit(tidligste)],_40139,_40143) --> 
    cc(tidligste,_40139,_40143).

faa([faa,lit(få)],_40139,_40143) --> 
    cc(få,_40139,_40143).

faa([faa,lit(får)],_40139,_40143) --> 
    cc(får,_40139,_40143).

faa0([faa0,_40169,!,_40227],_40147,_40151) --> 
    faa(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

faa0([faa0,[]],_40135,_40135) --> 
    [].

fast([fast,lit(fort)],_40139,_40143) --> 
    cc(fort,_40139,_40143).

fast([fast,_40167],_40145,_40149) --> 
    w(adj2(fast,nil),_40167,_40145,_40149).

fast([fast,_40177,lit(mulig)],_40155,_40159) --> 
    w(adj2(fast,nil),_40177,_40155,_40211),
    cc(mulig,_40211,_40159).

fast([fast,_40157],_40135,_40139) --> 
    hereafter(_40157,_40135,_40139).

from([from,_40161],_40139,_40143) --> 
    prep(from,_40161,_40139,_40143).

førnår([førnår,lit(når)],_40139,_40143) --> 
    cc(når,_40139,_40143).

førnår([førnår,lit(før)],_40139,_40143) --> 
    cc(før,_40139,_40143).

great([great,_40167],_40145,_40149) --> 
    w(adj2(great,nil),_40167,_40145,_40149).

great([great,lit(høy)],_40139,_40143) --> 
    cc(høy,_40139,_40143).

greater([greater,_40161],_40139,_40143) --> 
    prep(after,_40161,_40139,_40143).

greater([greater,lit(større)],_40139,_40143) --> 
    cc(større,_40139,_40143).

greater([greater,lit(høyere)],_40139,_40143) --> 
    cc(høyere,_40139,_40143).

greater([greater,lit(mer)],_40139,_40143) --> 
    cc(mer,_40139,_40143).

greater([greater,_40157],_40135,_40139) --> 
    great(_40157,_40135,_40139).

greatest([greatest,lit(størst)],_40139,_40143) --> 
    cc(størst,_40139,_40143).

greatest([greatest,lit(største)],_40139,_40143) --> 
    cc(største,_40139,_40143).

halfhour([halfhour,lit(halv),_40203],_40159,_40163) --> 
    cc(halv,_40159,_40201),
    w(noun(hour,_40123,_40125,n),_40203,_40201,_40163).

halfhour([halfhour,lit(halvtime)],_40139,_40143) --> 
    cc(halvtime,_40139,_40143).

has(_40111,[has,_40205,_40253,_40311],_40177,_40181) --> 
    has(_40205,_40177,_40235),
    negation0(_40111,_40253,_40235,_40287),
    not_look_ahead(w(noun(arrival,_40137,_40139,n)),_40311,_40287,_40181).

has0([has0,_40163,!],_40141,_40145) --> 
    has(_40163,_40141,_40145),
    !.

has0([has0,[]],_40135,_40135) --> 
    [].

has([has,_40193,_40251],_40171,_40175) --> 
    w(verb(have,_40141,fin),_40193,_40171,_40227),
    not_look_ahead(w(noun(arrival,_40127,_40129,n)),_40251,_40227,_40175).

hashad0([hashad0,_40163,!],_40141,_40145) --> 
    hashad(_40163,_40141,_40145),
    !.

hashad0([hashad0,[]],_40135,_40135) --> 
    [].

hashad([hashad,_40199,_40257,!,_40325],_40177,_40181) --> 
    w(verb(have,_40135,_40137),_40199,_40177,_40233),
    w(verb(have,_40147,_40149),_40257,_40233,_40291),
    !,
    accept(_40325,_40291,_40181).

hashad([hashad,_40169],_40147,_40151) --> 
    w(verb(have,_40117,_40119),_40169,_40147,_40151).

hasto0([hasto0,_40175,_40233],_40153,_40157) --> 
    w(verb(have,_40123,fin),_40175,_40153,_40209),
    infinitive(_40233,_40209,_40157).

hasto0([hasto0,[]],_40135,_40135) --> 
    [].

hereafter([hereafter,lit(om),lit(ikke),lit(så),lit(lenge)],_40169,_40173) --> 
    cc(om,_40169,_40211),
    cc(ikke,_40211,_40233),
    cc(så,_40233,_40255),
    cc(lenge,_40255,_40173).

hereafter([hereafter,_40163,_40211],_40141,_40145) --> 
    soonar(_40163,_40141,_40193),
    aspossible0(_40211,_40193,_40145).

hereafter([hereafter,lit(så),_40221,lit(som),_40291,!],_40177,_40181) --> 
    cc(så,_40177,_40219),
    soon(_40221,_40219,_40251),
    cc(som,_40251,_40289),
    w(adj2(possible,nil),_40291,_40289,_40181),
    !.

hereafter([hereafter,_40193,_40251,_40299,!],_40171,_40175) --> 
    prep1(in,_40193,_40171,_40227),
    near(_40251,_40227,_40281),
    w(noun(future,_40139,_40141,_40143),_40299,_40281,_40175),
    !.

hereafter([hereafter,lit(med),lit(en),lit(gang)],_40159,_40163) --> 
    cc(med,_40159,_40201),
    cc(en,_40201,_40223),
    cc(gang,_40223,_40163).

hereafter([hereafter,lit(heretter)],_40139,_40143) --> 
    cc(heretter,_40139,_40143).

hereafter([hereafter,_40167,_40225],_40145,_40149) --> 
    prep1(from,_40167,_40145,_40201),
    nowon(_40225,_40201,_40149).

hereafter([hereafter,_40197,_40255,_40313],_40175,_40179) --> 
    prep1(in,_40197,_40175,_40231),
    w(adj2(nearest,nil),_40255,_40231,_40289),
    w(noun(future,_40129,_40131,n),_40313,_40289,_40179).

hereafter([hereafter,_40197,_40255,_40313],_40175,_40179) --> 
    prep1(on,_40197,_40175,_40231),
    w(adj2(_40145,nil),_40255,_40231,_40289),
    w(noun(way,_40129,u,n),_40313,_40289,_40179).

hereafter([hereafter,_40167,_40225],_40145,_40149) --> 
    prep1(after,_40167,_40145,_40201),
    now1(_40225,_40201,_40149).

hereafter([hereafter,_40171,lit(dette)],_40149,_40153) --> 
    prep1(after,_40171,_40149,_40205),
    cc(dette,_40205,_40153).

hereafter([hereafter,lit(raskest),lit(mulig)],_40149,_40153) --> 
    cc(raskest,_40149,_40191),
    cc(mulig,_40191,_40153).

hereafter([hereafter,_40177,lit(gang)],_40155,_40159) --> 
    w(adj2(next,nil),_40177,_40155,_40211),
    cc(gang,_40211,_40159).

hereafter([hereafter,lit(raskest)],_40139,_40143) --> 
    cc(raskest,_40139,_40143).

herefrom([herefrom,_40183,lit(her),!,_40273],_40161,_40165) --> 
    prep1(from,_40183,_40161,_40217),
    cc(her,_40217,_40261),
    !,
    accept(_40273,_40261,_40165).

herefrom([herefrom,lit(herfra)],_40139,_40143) --> 
    cc(herfra,_40139,_40143).

herefrom([herefrom,lit(derfra)],_40139,_40143) --> 
    cc(derfra,_40139,_40143).

how([how,lit(hvordan),_40189],_40145,_40149) --> 
    cc(hvordan,_40145,_40187),
    ialle0(_40189,_40187,_40149).

how([how,lit(hvorfor),_40189],_40145,_40149) --> 
    cc(hvorfor,_40145,_40187),
    ialle0(_40189,_40187,_40149).

hoq([hoq,lit(vil),lit(du),lit(at)],_40159,_40163) --> 
    cc(vil,_40159,_40201),
    cc(du,_40201,_40223),
    cc(at,_40223,_40163).

hoq([hoq,_40189,lit(det),lit(at)],_40167,_40171) --> 
    w(verb(mean,_40133,fin),_40189,_40167,_40223),
    cc(det,_40223,_40267),
    cc(at,_40267,_40171).

hoq([hoq,_40193,lit(det),lit(seg),_40285,lit(at)],_40171,_40175) --> 
    has(_40193,_40171,_40223),
    cc(det,_40223,_40261),
    cc(seg,_40261,_40283),
    redundant0(_40285,_40283,_40315),
    cc(at,_40315,_40175).

hoq([hoq,_40183,lit(det),_40253,lit(at)],_40161,_40165) --> 
    be(_40183,_40161,_40213),
    cc(det,_40213,_40251),
    redundant0(_40253,_40251,_40283),
    cc(at,_40283,_40165).

hoq([hoq,_40199,lit(det),lit(an),lit(at)],_40177,_40181) --> 
    w(verb(go,_40139,fin),_40199,_40177,_40233),
    cc(det,_40233,_40277),
    cc(an,_40277,_40299),
    cc(at,_40299,_40181).

hoq([hoq,_40199,lit(det),_40279,lit(at)],_40177,_40181) --> 
    w(verb(agree,_40139,fin),_40199,_40177,_40233),
    cc(det,_40233,_40277),
    negation0(_40149,_40279,_40277,_40313),
    cc(at,_40313,_40181).

ihvor([ihvor,lit(i),lit(hvor),!],_40155,_40159) --> 
    cc(i,_40155,_40197),
    cc(hvor,_40197,_40159),
    !.

ihvor([ihvor,lit(hvor)],_40139,_40143) --> 
    cc(hvor,_40139,_40143).

hvor([hvor,lit(hvor)],_40139,_40143) --> 
    cc(hvor,_40139,_40143).

hvordan([hvordan,lit(hvordan),!,_40205],_40151,_40155) --> 
    cc(hvordan,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

hvordan([hvordan,lit(hva),lit(slags),_40233,!,_40291],_40167,_40171) --> 
    cc(hva,_40167,_40209),
    cc(slags,_40209,_40231),
    type0(_40233,_40231,_40263),
    !,
    accept(_40291,_40263,_40171).

hvordan([hvordan,lit(hva),!,_40205],_40151,_40155) --> 
    cc(hva,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

hvordan([hvordan,lit(hvor),_40211,!,_40279],_40167,_40171) --> 
    cc(hvor,_40167,_40209),
    w(adj2(great,nil),_40211,_40209,_40245),
    !,
    accept(_40279,_40245,_40171).

hvorfor([hvorfor,lit(hvorfor),_40189],_40145,_40149) --> 
    cc(hvorfor,_40145,_40187),
    ialle0(_40189,_40187,_40149).

type0([type0,_40169,!,_40227],_40147,_40151) --> 
    type(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

type0([type0,[]],_40135,_40135) --> 
    [].

type([type,_40183,!,_40251],_40161,_40165) --> 
    w(noun(type,_40129,u,n),_40183,_40161,_40217),
    !,
    accept(_40251,_40217,_40165).

i([i,lit(jeg)],_40139,_40143) --> 
    cc(jeg,_40139,_40143).

i([i,lit(meg)],_40139,_40143) --> 
    cc(meg,_40139,_40143).

i([i,lit(oss)],_40139,_40143) --> 
    cc(oss,_40139,_40143).

ialle0([ialle0,[]],_40135,_40135) --> 
    [].

if1([if1,lit(hvis)],_40139,_40143) --> 
    cc(hvis,_40139,_40143).

if1([if1,lit(om),_40225,{}],_40181,_40185) --> 
    cc(om,_40181,_40223),
    look_ahead(w(name(_40149,_40151,_40131)),_40225,_40223,_40185),
    {\+subclass0(_40131,place)}.

if1([if1,lit(om),_40227,{}],_40183,_40187) --> 
    cc(om,_40183,_40225),
    look_ahead(w(noun(_40131,_40151,_40153,_40155)),_40227,_40225,_40187),
    {\+subclass0(_40131,place)}.

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([jeg],_40197,_40195,_40157).

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([du],_40197,_40195,_40157).

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([han],_40197,_40195,_40157).

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([hun],_40197,_40195,_40157).

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([man],_40197,_40195,_40157).

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([vi],_40197,_40195,_40157).

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([dere],_40197,_40195,_40157).

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([de],_40197,_40195,_40157).

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([en],_40197,_40195,_40157).

if1([if1,lit(om),_40197],_40153,_40157) --> 
    cc(om,_40153,_40195),
    look_ahead([et],_40197,_40195,_40157).

ifra([ifra,lit(fra)],_40139,_40143) --> 
    cc(fra,_40139,_40143).

ifra([ifra,lit(ifra)],_40139,_40143) --> 
    cc(ifra,_40139,_40143).

iman([iman,lit(jeg)],_40139,_40143) --> 
    cc(jeg,_40139,_40143).

iman([iman,lit(man)],_40139,_40143) --> 
    cc(man,_40139,_40143).

iman([iman,lit(en)],_40139,_40143) --> 
    cc(en,_40139,_40143).

iman([iman,lit(du)],_40139,_40143) --> 
    cc(du,_40139,_40143).

inperiod0([inperiod0,_40193,_40251,!,_40319],_40171,_40175) --> 
    prep1(in,_40193,_40171,_40227),
    w(noun(hour,_40139,def,n),_40251,_40227,_40285),
    !,
    accept(_40319,_40285,_40175).

inperiod0([inperiod0,lit(om),_40215,!,_40283],_40171,_40175) --> 
    cc(om,_40171,_40213),
    w(noun(day,_40139,def,n),_40215,_40213,_40249),
    !,
    accept(_40283,_40249,_40175).

inperiod0([inperiod0,lit(hver),_40215,!,_40283],_40171,_40175) --> 
    cc(hver,_40171,_40213),
    w(noun(day,sin,u,n),_40215,_40213,_40249),
    !,
    accept(_40283,_40249,_40175).

inperiod0([inperiod0,[]],_40135,_40135) --> 
    [].

in_order_to(adj/nil/_40119,id,[in_order_to,_40195],_40161,_40165) --> 
    infinitiveand(_40195,_40161,_40165).

in_order_to(begin,id,[in_order_to,_40195,!,_40253],_40161,_40165) --> 
    infinitive(_40195,_40161,_40225),
    !,
    accept(_40253,_40225,_40165).

in_order_to(like,id,[in_order_to,_40195,!,_40253],_40161,_40165) --> 
    infinitive(_40195,_40161,_40225),
    !,
    accept(_40253,_40225,_40165).

in_order_to(start,id,[in_order_to,_40195,!,_40253],_40161,_40165) --> 
    infinitive(_40195,_40161,_40225),
    !,
    accept(_40253,_40225,_40165).

in_order_to(stop,id,[in_order_to,_40195,!,_40253],_40161,_40165) --> 
    infinitive(_40195,_40161,_40225),
    !,
    accept(_40253,_40225,_40165).

in_order_to(use,id,[in_order_to,_40237,{},_40309,!,_40367],_40203,_40207) --> 
    prepnof(_40141,_40237,_40203,_40271),
    {testmember(_40141,[on,to,for,with])},
    infinitive(_40309,_40271,_40339),
    !,
    accept(_40367,_40339,_40207).

in_order_to(use2,id,[in_order_to,_40195,!,_40253],_40161,_40165) --> 
    infinitive(_40195,_40161,_40225),
    !,
    accept(_40253,_40225,_40165).

in_order_to(have,id,[in_order_to,_40183],_40149,_40153) --> 
    infinitive(_40183,_40149,_40153).

in_order_to(think,id,[in_order_to,[]],_40149,_40149) --> 
    [].

in_order_to(_40111,not,[in_order_to,lit(uten),_40215],_40159,_40163) --> 
    cc(uten,_40159,_40213),
    infinitive(_40215,_40213,_40163).

in_order_to(_40111,id,[in_order_to,_40183],_40149,_40153) --> 
    in_order_to(_40183,_40149,_40153).

in_order_tox([in_order_tox,_40163,!],_40141,_40145) --> 
    infinitive(_40163,_40141,_40145),
    !.

in_order_tox([in_order_tox,_40157],_40135,_40139) --> 
    in_order_to(_40157,_40135,_40139).

in_order_to([in_order_to,_40157],_40135,_40139) --> 
    forå(_40157,_40135,_40139).

in_order_to([in_order_to,lit(får),_40195,!],_40151,_40155) --> 
    cc(får,_40151,_40193),
    infinitive(_40195,_40193,_40155),
    !.

in_order_to([in_order_to,lit(for),_40195,!],_40151,_40155) --> 
    cc(for,_40151,_40193),
    infinitiveand(_40195,_40193,_40155),
    !.

in_order_to([in_order_to,lit(før),_40195,!],_40151,_40155) --> 
    cc(før,_40151,_40193),
    infinitive(_40195,_40193,_40155),
    !.

in_order_to([in_order_to,_40173,_40231,!],_40151,_40155) --> 
    prep1(on,_40173,_40151,_40207),
    infinitive(_40231,_40207,_40155),
    !.

in_order_to([in_order_to,_40173,_40231,!],_40151,_40155) --> 
    prep1(with,_40173,_40151,_40207),
    infinitive(_40231,_40207,_40155),
    !.

in_order_to([in_order_to,_40173,_40231,!],_40151,_40155) --> 
    prep1(to,_40173,_40151,_40207),
    infinitiveand(_40231,_40207,_40155),
    !.

in_order_to([in_order_to,lit(av),_40195,!],_40151,_40155) --> 
    cc(av,_40151,_40193),
    infinitive(_40195,_40193,_40155),
    !.

in_order_to([in_order_to,lit(for),lit(og),!],_40155,_40159) --> 
    cc(for,_40155,_40197),
    cc(og,_40197,_40159),
    !.

in_order_to([in_order_to,lit(får),lit(å),!],_40155,_40159) --> 
    cc(får,_40155,_40197),
    cc(å,_40197,_40159),
    !.

in_order_to([in_order_to,lit(får),lit(og),!],_40155,_40159) --> 
    cc(får,_40155,_40197),
    cc(og,_40197,_40159),
    !.

forå([forå,lit(i),_40189],_40145,_40149) --> 
    cc(i,_40145,_40187),
    ogå(_40189,_40187,_40149).

forå([forå,lit(med),_40189],_40145,_40149) --> 
    cc(med,_40145,_40187),
    ogå(_40189,_40187,_40149).

forå([forå,lit(mot),_40189],_40145,_40149) --> 
    cc(mot,_40145,_40187),
    ogå(_40189,_40187,_40149).

forå([forå,lit(for),_40189],_40145,_40149) --> 
    cc(for,_40145,_40187),
    ogå(_40189,_40187,_40149).

forå([forå,lit(til),_40189],_40145,_40149) --> 
    cc(til,_40145,_40187),
    ogå(_40189,_40187,_40149).

forå([forå,lit(over),_40189],_40145,_40149) --> 
    cc(over,_40145,_40187),
    ogå(_40189,_40187,_40149).

forå([forå,lit(før),lit(å)],_40149,_40153) --> 
    cc(før,_40149,_40191),
    cc(å,_40191,_40153).

forå([forå,lit(ved),lit(å)],_40149,_40153) --> 
    cc(ved,_40149,_40191),
    cc(å,_40191,_40153).

ogå([ogå,lit(å)],_40139,_40143) --> 
    cc(å,_40139,_40143).

ogå([ogå,lit(og)],_40139,_40143) --> 
    cc(og,_40139,_40143).

infinitiveand([infinitiveand,lit(å)],_40139,_40143) --> 
    cc(å,_40139,_40143).

infinitiveand([infinitiveand,lit(og)],_40139,_40143) --> 
    cc(og,_40139,_40143).

infinitive([infinitive,lit(å),_40217,_40265,!],_40173,_40177) --> 
    cc(å,_40173,_40215),
    faa(_40217,_40215,_40247),
    look_ahead(w(verb(_40141,_40143,_40145)),_40265,_40247,_40177),
    !.

infinitive([infinitive,lit(å)],_40139,_40143) --> 
    cc(å,_40139,_40143).

infinitive([infinitive,lit(til),lit(å)],_40149,_40153) --> 
    cc(til,_40149,_40191),
    cc(å,_40191,_40153).

inom(in,[inom,_40175],_40147,_40151) --> 
    prep1(in,_40175,_40147,_40151).

inom(om,[inom,lit(om)],_40147,_40151) --> 
    cc(om,_40147,_40151).

inom(om,[inom,_40175],_40147,_40151) --> 
    prep1(on,_40175,_40147,_40151).

instead_of([instead_of,lit(fremfor)],_40139,_40143) --> 
    cc(fremfor,_40139,_40143).

instead_of([instead_of,_40197,_40255,lit(for),!],_40175,_40179) --> 
    prep1(in,_40197,_40175,_40231),
    w(noun(place,sin,def,n),_40255,_40231,_40289),
    cc(for,_40289,_40179),
    !.

instead_of([instead_of,lit(istedenfor)],_40139,_40143) --> 
    cc(istedenfor,_40139,_40143).

instead_of([instead_of,lit(heller),lit(enn)],_40149,_40153) --> 
    cc(heller,_40149,_40191),
    cc(enn,_40191,_40153).

it0([it0,lit(det),_40203,!],_40159,_40163) --> 
    cc(det,_40159,_40201),
    not_look_ahead([vil],_40203,_40201,_40163),
    !.

it0([it0,[]],_40135,_40135) --> 
    [].

it([it,lit(den)],_40139,_40143) --> 
    cc(den,_40139,_40143).

its([its,lit(dens),_40189],_40145,_40149) --> 
    cc(dens,_40145,_40187),
    own0(_40189,_40187,_40149).

its([its,lit(dets),_40189],_40145,_40149) --> 
    cc(dets,_40145,_40187),
    own0(_40189,_40187,_40149).

later([later,lit(senere)],_40139,_40143) --> 
    cc(senere,_40139,_40143).

later([later,lit(siden),_40189],_40145,_40149) --> 
    cc(siden,_40145,_40187),
    not_look_ahead_np(_40189,_40187,_40149).

later([later,lit(deretter)],_40139,_40143) --> 
    cc(deretter,_40139,_40143).

latest([latest,_40167],_40145,_40149) --> 
    w(adj2(sup,late),_40167,_40145,_40149).

latest([latest,_40167],_40145,_40149) --> 
    w(adj2(last,nil),_40167,_40145,_40149).

less([less,lit(før)],_40139,_40143) --> 
    cc(før,_40139,_40143).

less([less,lit(tidligere)],_40139,_40143) --> 
    cc(tidligere,_40139,_40143).

less([less,lit(mindre)],_40139,_40143) --> 
    cc(mindre,_40139,_40143).

less([less,lit(lavere)],_40139,_40143) --> 
    cc(lavere,_40139,_40143).

let([let,_40169],_40147,_40151) --> 
    w(verb(let,pres,fin),_40169,_40147,_40151).

little([little,lit(lite)],_40139,_40143) --> 
    cc(lite,_40139,_40143).

long([long,_40167],_40145,_40149) --> 
    w(adj2(short,nil),_40167,_40145,_40149).

long([long,_40167],_40145,_40149) --> 
    w(adj2(long,nil),_40167,_40145,_40149).

longadj([longadj,_40167],_40145,_40149) --> 
    w(adj2(long,nil),_40167,_40145,_40149).

manypersons([manypersons,lit(mange),_40201,!,_40259],_40157,_40161) --> 
    cc(mange,_40157,_40199),
    adjnoun(_40201,_40199,_40231),
    !,
    reject(_40259,_40231,_40161).

manypersons([manypersons,lit(mange)],_40139,_40143) --> 
    cc(mange,_40139,_40143).

many1([many1,lit(mange),_40189],_40145,_40149) --> 
    cc(mange,_40145,_40187),
    off0(_40189,_40187,_40149).

many([many,_40173,lit(mange),_40243],_40151,_40155) --> 
    so0(_40173,_40151,_40203),
    cc(mange,_40203,_40241),
    off0(_40243,_40241,_40155).

meny([meny,lit(mange)],_40139,_40143) --> 
    cc(mange,_40139,_40143).

meny([meny,lit(meget)],_40139,_40143) --> 
    cc(meget,_40139,_40143).

meny([meny,lit(mye)],_40139,_40143) --> 
    cc(mye,_40139,_40143).

me0([me0,lit(jeg),!],_40145,_40149) --> 
    cc(jeg,_40145,_40149),
    !.

me0([me0,lit(meg),!],_40145,_40149) --> 
    cc(meg,_40145,_40149),
    !.

me0([me0,lit(oss),!],_40145,_40149) --> 
    cc(oss,_40145,_40149),
    !.

me0([me0,lit(seg),!],_40145,_40149) --> 
    cc(seg,_40145,_40149),
    !.

me0([me0,[]],_40135,_40135) --> 
    [].

mineyour0([mineyour0,_40167,!],_40145,_40149) --> 
    posspron(_40117,_40167,_40145,_40149),
    !.

mineyour0([mineyour0,[]],_40135,_40135) --> 
    [].

more([more,lit(mer)],_40139,_40143) --> 
    cc(mer,_40139,_40143).

more([more,lit(fler)],_40139,_40143) --> 
    cc(fler,_40139,_40143).

more([more,lit(flere)],_40139,_40143) --> 
    cc(flere,_40139,_40143).

most([most,lit(de),lit(fleste)],_40149,_40153) --> 
    cc(de,_40149,_40191),
    cc(fleste,_40191,_40153).

most([most,lit(flest)],_40139,_40143) --> 
    cc(flest,_40139,_40143).

much([much,lit(mye)],_40139,_40143) --> 
    cc(mye,_40139,_40143).

much([much,lit(meget)],_40139,_40143) --> 
    cc(meget,_40139,_40143).

my([my,lit(min)],_40139,_40143) --> 
    cc(min,_40139,_40143).

my([my,lit(mitt)],_40139,_40143) --> 
    cc(mitt,_40139,_40143).

my([my,lit(mine)],_40139,_40143) --> 
    cc(mine,_40139,_40143).

when10([when10,_40157],_40135,_40139) --> 
    when1(_40157,_40135,_40139).

when10([when10,[]],_40135,_40135) --> 
    [].

when1([when1,lit(da)],_40139,_40143) --> 
    cc(da,_40139,_40143).

when1([when1,lit(når)],_40139,_40143) --> 
    cc(når,_40139,_40143).

when1([when1,lit(n),{},!],_40167,_40171) --> 
    cc(n,_40167,_40171),
    {user:value(smsflag,true)},
    !.

when1([when1,lit(tid),_40197],_40153,_40157) --> 
    cc(tid,_40153,_40195),
    look_ahead([går],_40197,_40195,_40157).

negation2(only,only,[negation2,[],!],_40155,_40155) --> 
    [],
    !.

negation2(id,only,[negation2,_40187],_40153,_40157) --> 
    negation(only,_40187,_40153,_40157).

negation2(id,only,[negation2,_40187],_40153,_40157) --> 
    negation(only,_40187,_40153,_40157).

negation2(not,id,[negation2,_40187],_40153,_40157) --> 
    negation(only,_40187,_40153,_40157).

negation2(not,id,[negation2,_40199,!,_40267],_40165,_40169) --> 
    negation(not,_40199,_40165,_40233),
    !,
    reject(_40267,_40233,_40169).

negation2(not,not,[negation2,_40187],_40153,_40157) --> 
    negation0(id,_40187,_40153,_40157).

negation2(id,_40113,[negation2,_40187],_40153,_40157) --> 
    negation0(_40113,_40187,_40153,_40157).

negation2(often,often,[negation2,[]],_40149,_40149) --> 
    [].

negation0(_40111,[negation0,{},!],_40169,_40169) --> 
    {nonvar(_40111),_40111==(not)},
    !.

negation0(_40111,[negation0,_40181,!],_40153,_40157) --> 
    negation(_40111,_40181,_40153,_40157),
    !.

negation0(id,[negation0,[]],_40143,_40143) --> 
    [].

negation(id,[negation,_40187,lit(bare),!],_40159,_40163) --> 
    not(_40187,_40159,_40217),
    cc(bare,_40217,_40163),
    !.

negation(not,[negation,lit(bare),_40203],_40153,_40157) --> 
    cc(bare,_40153,_40201),
    not(_40203,_40201,_40157).

negation(not,[negation,_40171],_40143,_40147) --> 
    not(_40171,_40143,_40147).

negation(only,[negation,lit(bare)],_40147,_40151) --> 
    cc(bare,_40147,_40151).

negation(atleast,[negation,lit(minst)],_40147,_40151) --> 
    cc(minst,_40147,_40151).

negation(often,[negation,lit(ofte)],_40147,_40151) --> 
    cc(ofte,_40147,_40151).

negatino([negatino,lit(ikke),!],_40145,_40149) --> 
    cc(ikke,_40145,_40149),
    !.

negatino([negatino,lit(ingen),!],_40145,_40149) --> 
    cc(ingen,_40145,_40149),
    !.

negatino([negatino,[]],_40135,_40135) --> 
    [].

near([near,_40167],_40145,_40149) --> 
    w(adj2(near,nil),_40167,_40145,_40149).

near([near,_40173,_40221],_40151,_40155) --> 
    the0(_40173,_40151,_40203),
    w(adj2(nearest,nil),_40221,_40203,_40155).

nearest([nearest,_40167],_40145,_40149) --> 
    w(adj2(near,sup),_40167,_40145,_40149).

nearest([nearest,_40167],_40145,_40149) --> 
    w(adj2(nearest,nil),_40167,_40145,_40149).

nearest([nearest,_40161],_40139,_40143) --> 
    prep1(nearest,_40161,_40139,_40143).

nest([nest,lit(nest)],_40139,_40143) --> 
    cc(nest,_40139,_40143).

nest([nest,_40167],_40145,_40149) --> 
    w(adj2(next,nil),_40167,_40145,_40149).

next0([next0,_40163,!],_40141,_40145) --> 
    next(_40163,_40141,_40145),
    !.

next0([next0,[]],_40135,_40135) --> 
    [].

next([next,_40167],_40145,_40149) --> 
    w(adj2(next,nil),_40167,_40145,_40149).

no([no,lit(ingen),_40189],_40145,_40149) --> 
    cc(ingen,_40145,_40187),
    look_ahead_np(_40189,_40187,_40149).

notall([notall,lit(ikke),lit(alle)],_40149,_40153) --> 
    cc(ikke,_40149,_40191),
    cc(alle,_40191,_40153).

not0([not0,_40163,!],_40141,_40145) --> 
    not(_40163,_40141,_40145),
    !.

not0([not0,[]],_40135,_40135) --> 
    [].

not([not,lit(ikke)],_40139,_40143) --> 
    cc(ikke,_40139,_40143).

not([not,lit(intet),_40189],_40145,_40149) --> 
    cc(intet,_40145,_40187),
    look_ahead_np(_40189,_40187,_40149).

notwithstanding([notwithstanding,lit(selv_om)],_40139,_40143) --> 
    cc(selv_om,_40139,_40143).

notwithstanding([notwithstanding,lit(selv),lit(om)],_40149,_40153) --> 
    cc(selv,_40149,_40191),
    cc(om,_40191,_40153).

now0([now0,_40163,!],_40141,_40145) --> 
    now1(_40163,_40141,_40145),
    !.

now0([now0,_40157],_40135,_40139) --> 
    today(_40157,_40135,_40139).

now0([now0,[]],_40135,_40135) --> 
    [].

now1([now1,lit(ennå)],_40139,_40143) --> 
    cc(ennå,_40139,_40143).

now1([now1,lit(nå)],_40139,_40143) --> 
    cc(nå,_40139,_40143).

now1([now1,lit(no)],_40139,_40143) --> 
    cc(no,_40139,_40143).

nowon([nowon,_40173,lit(av),!],_40151,_40155) --> 
    now1(_40173,_40151,_40203),
    cc(av,_40203,_40155),
    !.

nowon([nowon,_40157],_40135,_40139) --> 
    now1(_40157,_40135,_40139).

nr0([nr0,_40163,!],_40141,_40145) --> 
    nr1(_40163,_40141,_40145),
    !.

nr0([nr0,[]],_40135,_40135) --> 
    [].

nr1([nr1,lit(nr),_40195,!],_40151,_40155) --> 
    cc(nr,_40151,_40193),
    point0(_40195,_40193,_40155),
    !.

nr1([nr1,lit(n),_40195,!],_40151,_40155) --> 
    cc(n,_40151,_40193),
    point0(_40195,_40193,_40155),
    !.

nr1([nr1,_40169,_40217,!],_40147,_40151) --> 
    number1(_40169,_40147,_40199),
    point0(_40217,_40199,_40151),
    !.

number0([number0,_40167,!],_40145,_40149) --> 
    num(_40117,_40167,_40145,_40149),
    !.

number0([number0,[]],_40135,_40135) --> 
    [].

number1([number1,_40177,_40235],_40155,_40159) --> 
    w(noun(number,sin,_40125,n),_40177,_40155,_40211),
    colon0(_40235,_40211,_40159).

of_course0([of_course0,_40157],_40135,_40139) --> 
    of_course(_40157,_40135,_40139).

of_course0([of_course0,_40173],_40151,_40155) --> 
    not_look_ahead(w(verb(_40119,_40121,_40123)),_40173,_40151,_40155).

of_coursenot0([of_coursenot0,_40167,lit(ikke)],_40145,_40149) --> 
    of_course(_40167,_40145,_40197),
    cc(ikke,_40197,_40149).

of_coursenot0([of_coursenot0,_40173],_40151,_40155) --> 
    not_look_ahead(w(verb(_40119,_40121,_40123)),_40173,_40151,_40155).

of_course([of_course,lit(naturligvis)],_40139,_40143) --> 
    cc(naturligvis,_40139,_40143).

of_course([of_course,lit(selvfølgelig)],_40139,_40143) --> 
    cc(selvfølgelig,_40139,_40143).

of_course([of_course,lit(det),_40201],_40157,_40161) --> 
    cc(det,_40157,_40199),
    w(verb(agree,pres,fin),_40201,_40199,_40161).

of0([of0,_40163,!],_40141,_40145) --> 
    of(_40163,_40141,_40145),
    !.

of0([of0,[]],_40135,_40135) --> 
    [].

of([of,_40161],_40139,_40143) --> 
    prep(of,_40161,_40139,_40143).

of([of,_40161],_40139,_40143) --> 
    prep1(to,_40161,_40139,_40143).

off0([off0,lit(av),!],_40145,_40149) --> 
    cc(av,_40145,_40149),
    !.

off0([off0,[]],_40135,_40135) --> 
    [].

offrom([offrom,lit(av)],_40139,_40143) --> 
    cc(av,_40139,_40143).

offrom([offrom,_40161],_40139,_40143) --> 
    prep1(from,_40161,_40139,_40143).

offrom([offrom,lit(ifra)],_40139,_40143) --> 
    cc(ifra,_40139,_40143).

often([often,_40167],_40145,_40149) --> 
    w(adj2(often,nil),_40167,_40145,_40149).

often([often,lit(ofte)],_40139,_40143) --> 
    cc(ofte,_40139,_40143).

often([often,lit(sjelden)],_40139,_40143) --> 
    cc(sjelden,_40139,_40143).

often([often,lit(jevnlig)],_40139,_40143) --> 
    cc(jevnlig,_40139,_40143).

ofthe([ofthe,_40163,_40211],_40141,_40145) --> 
    of(_40163,_40141,_40193),
    the(_40211,_40193,_40145).

ofthe0([ofthe0,_40157],_40135,_40139) --> 
    ofthe(_40157,_40135,_40139).

ofthe0([ofthe0,[]],_40135,_40135) --> 
    [].

older([older,lit(eldre)],_40139,_40143) --> 
    cc(eldre,_40139,_40143).

on0([on0,_40167,!],_40145,_40149) --> 
    prep1(on,_40167,_40145,_40149),
    !.

on0([on0,[]],_40135,_40135) --> 
    [].

newyear([newyear,_40187,_40245],_40165,_40169) --> 
    w(adj2(new,nil),_40187,_40165,_40221),
    w(noun(year,_40123,_40125,_40127),_40245,_40221,_40169).

newyear([newyear,lit(nyttår)],_40139,_40143) --> 
    cc(nyttår,_40139,_40143).

om0([om0,lit(om),!],_40145,_40149) --> 
    cc(om,_40145,_40149),
    !.

om0([om0,[]],_40135,_40135) --> 
    [].

on0([on0,lit(på),!],_40145,_40149) --> 
    cc(på,_40145,_40149),
    !.

on0([on0,[]],_40135,_40135) --> 
    [].

one([one,_40167],_40145,_40149) --> 
    w(nb(1,num),_40167,_40145,_40149).

one([one,_40157],_40135,_40139) --> 
    a(_40157,_40135,_40139).

only0([only0,lit(bare),!],_40145,_40149) --> 
    cc(bare,_40145,_40149),
    !.

only0([only0,lit(hele),!],_40145,_40149) --> 
    cc(hele,_40145,_40149),
    !.

only0([only0,lit(nesten),!],_40145,_40149) --> 
    cc(nesten,_40145,_40149),
    !.

only0([only0,[]],_40135,_40135) --> 
    [].

or1([or1,lit(eller)],_40139,_40143) --> 
    cc(eller,_40139,_40143).

ordinal(_40111,[ordinal,_40181],_40153,_40157) --> 
    w(nb(_40111,ord),_40181,_40153,_40157).

oter([oter,_40157],_40135,_40139) --> 
    other(_40157,_40135,_40139).

oter([oter,_40157],_40135,_40139) --> 
    others(_40157,_40135,_40139).

other([other,lit(annen)],_40139,_40143) --> 
    cc(annen,_40139,_40143).

other([other,lit(annet)],_40139,_40143) --> 
    cc(annet,_40139,_40143).

others([others,lit(andre)],_40139,_40143) --> 
    cc(andre,_40139,_40143).

own0([own0,lit(egen)],_40139,_40143) --> 
    cc(egen,_40139,_40143).

own0([own0,lit(egne)],_40139,_40143) --> 
    cc(egne,_40139,_40143).

own0([own0,[]],_40135,_40135) --> 
    [].

possible0([possible0,_40173,!],_40151,_40155) --> 
    w(adj2(possible,nil),_40173,_40151,_40155),
    !.

possible0([possible0,[]],_40135,_40135) --> 
    [].

reflexiv0(_40111,[reflexiv0,_40187,!,_40255],_40159,_40163) --> 
    reflexiv(_40111,_40187,_40159,_40221),
    !,
    accept(_40255,_40221,_40163).

reflexiv0(_40111,[reflexiv0,{},!,_40217],_40165,_40169) --> 
    {verbtype(_40111,dtv)},
    !,
    accept(_40217,_40165,_40169).

reflexiv0(_40111,[reflexiv0,[]],_40143,_40143) --> 
    [].

reflexiv(ask,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(befind,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(beworry,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(buy,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(change,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(come,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(cost,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(decide,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(feel,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(fit,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(find,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(give,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(go,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(have,[reflexiv,lit(meg)],_40147,_40151) --> 
    cc(meg,_40147,_40151).

reflexiv(have,[reflexiv,lit(seg)],_40147,_40151) --> 
    cc(seg,_40147,_40151).

reflexiv(hurry,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(learn,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(move,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(pass,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(pay2,[reflexiv,lit(seg)],_40147,_40151) --> 
    cc(seg,_40147,_40151).

reflexiv(promise,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(get,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(get,[reflexiv,lit(med)],_40147,_40151) --> 
    cc(med,_40147,_40151).

reflexiv(receive,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(receive,[reflexiv,lit(med)],_40147,_40151) --> 
    cc(med,_40147,_40151).

reflexiv(retire,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(run,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(say,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(send,[reflexiv,_40177,_40225],_40149,_40153) --> 
    to0(_40177,_40149,_40207),
    rfxpron(_40225,_40207,_40153).

reflexiv(show,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(sneak,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(take,[reflexiv,lit(med),_40203],_40153,_40157) --> 
    cc(med,_40153,_40201),
    rfxpron(_40203,_40201,_40157).

reflexiv(take,[reflexiv,lit(med)],_40147,_40151) --> 
    cc(med,_40147,_40151).

reflexiv(take,[reflexiv,_40185,_40243],_40157,_40161) --> 
    not_look_ahead([dere],_40185,_40157,_40219),
    rfxpron(_40243,_40219,_40161).

reflexiv(tell,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(think,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(turn,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(want,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(wish,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(worry,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

reflexiv(write,[reflexiv,_40171],_40143,_40147) --> 
    rfxpron(_40171,_40143,_40147).

rfxpron0([rfxpron0,_40163,!],_40141,_40145) --> 
    rfxpron(_40163,_40141,_40145),
    !.

rfxpron0([rfxpron0,[]],_40135,_40135) --> 
    [].

rfxpron([rfxpron,lit(meg)],_40139,_40143) --> 
    cc(meg,_40139,_40143).

rfxpron([rfxpron,lit(deg)],_40139,_40143) --> 
    cc(deg,_40139,_40143).

rfxpron([rfxpron,lit(seg)],_40139,_40143) --> 
    cc(seg,_40139,_40143).

rfxpron([rfxpron,lit(oss)],_40139,_40143) --> 
    cc(oss,_40139,_40143).

rfxpron([rfxpron,lit(dere)],_40139,_40143) --> 
    cc(dere,_40139,_40143).

rfxpron([rfxpron,lit(selv),_40197],_40153,_40157) --> 
    cc(selv,_40153,_40195),
    not_look_ahead([om],_40197,_40195,_40157).

compassly([compassly,lit(nordfra)],_40139,_40143) --> 
    cc(nordfra,_40139,_40143).

compassly([compassly,lit(nordover)],_40139,_40143) --> 
    cc(nordover,_40139,_40143).

compassly([compassly,lit(sydfra)],_40139,_40143) --> 
    cc(sydfra,_40139,_40143).

compassly([compassly,lit(sydover)],_40139,_40143) --> 
    cc(sydover,_40139,_40143).

compassly([compassly,lit(sørfra)],_40139,_40143) --> 
    cc(sørfra,_40139,_40143).

compassly([compassly,lit(sørover)],_40139,_40143) --> 
    cc(sørover,_40139,_40143).

compassly([compassly,lit(vestfra)],_40139,_40143) --> 
    cc(vestfra,_40139,_40143).

compassly([compassly,lit(vestover)],_40139,_40143) --> 
    cc(vestover,_40139,_40143).

compassly([compassly,lit(østfra)],_40139,_40143) --> 
    cc(østfra,_40139,_40143).

compassly([compassly,lit(østover)],_40139,_40143) --> 
    cc(østover,_40139,_40143).

redundant0x([redundant0x,lit(så)],_40139,_40143) --> 
    cc(så,_40139,_40143).

redundant0x([redundant0x,_40157],_40135,_40139) --> 
    redundants0(_40157,_40135,_40139).

redundant0([redundant0,_40163,!],_40141,_40145) --> 
    redundant(_40163,_40141,_40145),
    !.

redundant0([redundant0,[]],_40135,_40135) --> 
    [].

redundants0([redundants0,_40169,_40217,!],_40147,_40151) --> 
    redundant(_40169,_40147,_40199),
    redundants0(_40217,_40199,_40151),
    !.

redundants0([redundants0,[]],_40135,_40135) --> 
    [].

redundantsx0([redundantsx0,_40169,!,_40227],_40147,_40151) --> 
    redundant(_40169,_40147,_40199),
    !,
    redxxx0(_40227,_40199,_40151).

redundantsx0([redundantsx0,[]],_40135,_40135) --> 
    [].

redxxx0([redxxx0,lit(og),_40195,!],_40151,_40155) --> 
    cc(og,_40151,_40193),
    redundant(_40195,_40193,_40155),
    !.

redxxx0([redxxx0,[]],_40135,_40135) --> 
    [].

redundant([redundant,_40171,!],_40149,_40153) --> 
    w(adv(redundantly),_40171,_40149,_40153),
    !.

redundant([redundant,_40181,_40239],_40159,_40163) --> 
    prep1(in,_40181,_40159,_40215),
    w(noun(average,_40123,_40125,_40127),_40239,_40215,_40163).

redundant([redundant,_40171,lit(allverden)],_40149,_40153) --> 
    prep1(in,_40171,_40149,_40205),
    cc(allverden,_40205,_40153).

redundant([redundant,_40205,lit(det),_40285,_40343],_40183,_40187) --> 
    prep1(in,_40205,_40183,_40239),
    cc(det,_40239,_40283),
    w(adj2(whole,nil),_40285,_40283,_40319),
    w(verb(take,past,part),_40343,_40319,_40187).

redundant([redundant,_40171,lit(hvertfall)],_40149,_40153) --> 
    prep1(in,_40171,_40149,_40205),
    cc(hvertfall,_40205,_40153).

redundant([redundant,_40171,lit(gjen)],_40149,_40153) --> 
    prep1(in,_40171,_40149,_40205),
    cc(gjen,_40205,_40153).

redundant([redundant,_40181,_40239],_40159,_40163) --> 
    prep1(for,_40181,_40159,_40215),
    w(noun(time,sin,def,n),_40239,_40215,_40163).

redundant([redundant,_40199,_40257,_40305,!,_40373],_40177,_40181) --> 
    prep1(from,_40199,_40177,_40233),
    a(_40257,_40233,_40287),
    w(noun(place,sin,u,n),_40305,_40287,_40339),
    !,
    accept(_40373,_40339,_40181).

redundant([redundant,_40177,_40235],_40155,_40159) --> 
    prep1(on,_40177,_40155,_40211),
    w(adj2(new,nil),_40235,_40211,_40159).

redundant([redundant,_40191,lit(en),_40271],_40169,_40173) --> 
    prep1(on,_40191,_40169,_40225),
    cc(en,_40225,_40269),
    w(noun(time_count,sin,u,n),_40271,_40269,_40173).

redundant([redundant,_40167,_40225],_40145,_40149) --> 
    prep1(to,_40167,_40145,_40201),
    slutt(_40225,_40201,_40149).

redundant([redundant,_40171,lit(sammen)],_40149,_40153) --> 
    prep1(to,_40171,_40149,_40205),
    cc(sammen,_40205,_40153).

redundant([redundant,_40201,_40259,_40317],_40179,_40183) --> 
    prep1(to,_40201,_40179,_40235),
    w(adj2(ordinary,nil),_40259,_40235,_40293),
    not_look_ahead(w(noun(time,_40133,_40135,_40137)),_40317,_40293,_40183).

redundant([redundant,_40157],_40135,_40139) --> 
    always(_40157,_40135,_40139).

redundant([redundant,_40157],_40135,_40139) --> 
    aspossible(_40157,_40135,_40139).

redundant([redundant,lit(altså),_40201],_40157,_40161) --> 
    cc(altså,_40157,_40199),
    not_look_ahead_lit([at,å],_40201,_40199,_40161).

redundant([redundant,lit(bare)],_40139,_40143) --> 
    cc(bare,_40139,_40143).

redundant([redundant,lit(da),_40189],_40145,_40149) --> 
    cc(da,_40145,_40187),
    not_look_ahead_np(_40189,_40187,_40149).

redundant([redundant,lit(den),lit(gang)],_40149,_40153) --> 
    cc(den,_40149,_40191),
    cc(gang,_40191,_40153).

redundant([redundant,lit(derfra)],_40139,_40143) --> 
    cc(derfra,_40139,_40143).

redundant([redundant,lit(derfor)],_40139,_40143) --> 
    cc(derfor,_40139,_40143).

redundant([redundant,lit(alene)],_40139,_40143) --> 
    cc(alene,_40139,_40143).

redundant([redundant,lit(bort)],_40139,_40143) --> 
    cc(bort,_40139,_40143).

redundant([redundant,lit(dessverre)],_40139,_40143) --> 
    cc(dessverre,_40139,_40143).

redundant([redundant,lit(egentlig)],_40139,_40143) --> 
    cc(egentlig,_40139,_40143).

redundant([redundant,lit(ellers)],_40139,_40143) --> 
    cc(ellers,_40139,_40143).

redundant([redundant,lit(engang)],_40139,_40143) --> 
    cc(engang,_40139,_40143).

redundant([redundant,lit(enklest),lit(mulig)],_40149,_40153) --> 
    cc(enklest,_40149,_40191),
    cc(mulig,_40191,_40153).

redundant([redundant,lit(enklest)],_40139,_40143) --> 
    cc(enklest,_40139,_40143).

redundant([redundant,lit(ergo)],_40139,_40143) --> 
    cc(ergo,_40139,_40143).

redundant([redundant,lit(farefritt)],_40139,_40143) --> 
    cc(farefritt,_40139,_40143).

redundant([redundant,lit(faktisk)],_40139,_40143) --> 
    cc(faktisk,_40139,_40143).

redundant([redundant,lit(forøvrig)],_40139,_40143) --> 
    cc(forøvrig,_40139,_40143).

redundant([redundant,lit(forøvrig)],_40139,_40143) --> 
    cc(forøvrig,_40139,_40143).

redundant([redundant,lit(fram)],_40139,_40143) --> 
    cc(fram,_40139,_40143).

redundant([redundant,lit(gjerne)],_40139,_40143) --> 
    cc(gjerne,_40139,_40143).

redundant([redundant,lit(heller)],_40139,_40143) --> 
    cc(heller,_40139,_40143).

redundant([redundant,lit(helst)],_40139,_40143) --> 
    cc(helst,_40139,_40143).

redundant([redundant,lit(heldigvis)],_40139,_40143) --> 
    cc(heldigvis,_40139,_40143).

redundant([redundant,lit(herfra)],_40139,_40143) --> 
    cc(herfra,_40139,_40143).

redundant([redundant,lit(jo)],_40139,_40143) --> 
    cc(jo,_40139,_40143).

redundant([redundant,lit(jovisst)],_40139,_40143) --> 
    cc(jovisst,_40139,_40143).

redundant([redundant,lit(ikke),lit(sant)],_40149,_40153) --> 
    cc(ikke,_40149,_40191),
    cc(sant,_40191,_40153).

redundant([redundant,lit(ihvertfall)],_40139,_40143) --> 
    cc(ihvertfall,_40139,_40143).

redundant([redundant,lit(imens)],_40139,_40143) --> 
    cc(imens,_40139,_40143).

redundant([redundant,lit(inne)],_40139,_40143) --> 
    cc(inne,_40139,_40143).

redundant([redundant,lit(kanskje)],_40139,_40143) --> 
    cc(kanskje,_40139,_40143).

redundant([redundant,lit(langt),lit(bort)],_40149,_40153) --> 
    cc(langt,_40149,_40191),
    cc(bort,_40191,_40153).

redundant([redundant,lit(lenge)],_40139,_40143) --> 
    cc(lenge,_40139,_40143).

redundant([redundant,lit(likevel)],_40139,_40143) --> 
    cc(likevel,_40139,_40143).

redundant([redundant,lit(minst)],_40139,_40143) --> 
    cc(minst,_40139,_40143).

redundant([redundant,lit(mon),_40201],_40157,_40161) --> 
    cc(mon,_40157,_40199),
    w(verb(believe,imp,fin),_40201,_40199,_40161).

redundant([redundant,lit(normalt)],_40139,_40143) --> 
    cc(normalt,_40139,_40143).

redundant([redundant,lit(når),lit(som),lit(helst)],_40159,_40163) --> 
    cc(når,_40159,_40201),
    cc(som,_40201,_40223),
    cc(helst,_40223,_40163).

redundant([redundant,lit(også)],_40139,_40143) --> 
    cc(også,_40139,_40143).

redundant([redundant,_40157],_40135,_40139) --> 
    sometimes(_40157,_40135,_40139).

redundant([redundant,lit(om),_40203],_40159,_40163) --> 
    cc(om,_40159,_40201),
    w(noun(time_count,sin,def,n),_40203,_40201,_40163).

redundant([redundant,lit(ad),_40203],_40159,_40163) --> 
    cc(ad,_40159,_40201),
    w(noun(time_count,sin,def,n),_40203,_40201,_40163).

redundant([redundant,lit(sikkert)],_40139,_40143) --> 
    cc(sikkert,_40139,_40143).

redundant([redundant,lit(straks)],_40139,_40143) --> 
    cc(straks,_40139,_40143).

redundant([redundant,lit(selvsagt)],_40139,_40143) --> 
    cc(selvsagt,_40139,_40143).

redundant([redundant,lit(totalt)],_40139,_40143) --> 
    cc(totalt,_40139,_40143).

redundant([redundant,lit(uansett)],_40139,_40143) --> 
    cc(uansett,_40139,_40143).

redundant([redundant,lit(vanligvis)],_40139,_40143) --> 
    cc(vanligvis,_40139,_40143).

redundant([redundant,lit(vel)],_40139,_40143) --> 
    cc(vel,_40139,_40143).

redundant([redundant,lit(videre)],_40139,_40143) --> 
    cc(videre,_40139,_40143).

slutt([slutt,lit(sist)],_40139,_40143) --> 
    cc(sist,_40139,_40143).

slutt([slutt,lit(slutt)],_40139,_40143) --> 
    cc(slutt,_40139,_40143).

please0([please0,_40169,!,_40227],_40147,_40151) --> 
    please(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

please0([please0,lit(bare),!,_40205],_40151,_40155) --> 
    cc(bare,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

please0([please0,[]],_40135,_40135) --> 
    [].

please([please,_40175,_40223,_40271,_40319],_40153,_40157) --> 
    be(_40175,_40153,_40205),
    so(_40223,_40205,_40253),
    good(_40271,_40253,_40301),
    infinitive(_40319,_40301,_40157).

please([please,lit(kan),_40227,_40275,_40323,_40371,lit(å)],_40183,_40187) --> 
    cc(kan,_40183,_40225),
    you(_40227,_40225,_40257),
    be(_40275,_40257,_40305),
    so0(_40323,_40305,_40353),
    w(adj2(good,nil),_40371,_40353,_40405),
    cc(å,_40405,_40187).

slashpoint0([slashpoint0,_40163,!],_40141,_40145) --> 
    slashpoint(_40163,_40141,_40145),
    !.

slashpoint0([slashpoint0,[]],_40135,_40135) --> 
    [].

slashpoint([slashpoint,lit(ende),!],_40145,_40149) --> 
    cc(ende,_40145,_40149),
    !.

slashpoint([slashpoint,lit(/),!],_40145,_40149) --> 
    cc(/,_40145,_40149),
    !.

slashpoint([slashpoint,lit(i),_40209,!],_40165,_40169) --> 
    cc(i,_40165,_40207),
    look_ahead(w(nb(_40135,_40137)),_40209,_40207,_40169),
    !.

slashpoint([slashpoint,lit('.'),lit(i),_40241,!],_40175,_40179) --> 
    cc('.',_40175,_40217),
    cc(i,_40217,_40239),
    look_ahead(w(nb(_40145,_40147)),_40241,_40239,_40179),
    !.

slashpoint([slashpoint,lit('.'),!],_40145,_40149) --> 
    cc('.',_40145,_40149),
    !.

slash([slash,lit(/)],_40139,_40143) --> 
    cc(/,_40139,_40143).

dashpoint0([dashpoint0,_40163,!],_40141,_40145) --> 
    dashpoint(_40163,_40141,_40145),
    !.

dashpoint0([dashpoint0,[]],_40135,_40135) --> 
    [].

dashpoint([dashpoint,lit(-)],_40139,_40143) --> 
    cc(-,_40139,_40143).

dashpoint([dashpoint,lit('.')],_40139,_40143) --> 
    cc('.',_40139,_40143).

point0([point0,_40169,!,_40227],_40147,_40151) --> 
    point(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

point0([point0,[]],_40135,_40135) --> 
    [].

pointNO([pointNO,_40169,!,_40227],_40147,_40151) --> 
    point(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

pointNO([pointNO,{}],_40151,_40151) --> 
    {user:value(nodotflag,true)}.

point([point,lit('.')],_40139,_40143) --> 
    cc('.',_40139,_40143).

itrailer([itrailer,lit(n)],_40139,_40143) --> 
    cc(n,_40139,_40143).

itrailer([itrailer,_40175,lit(når)],_40153,_40157) --> 
    not_look_ahead([n],_40175,_40153,_40209),
    cc(når,_40209,_40157).

itrailer([itrailer,_40181,_40239],_40159,_40163) --> 
    not_look_ahead([n],_40181,_40159,_40215),
    w(adj2(next,nil),_40239,_40215,_40163).

itrailer([itrailer,lit(takk)],_40139,_40143) --> 
    cc(takk,_40139,_40143).

qtrailer0([qtrailer0,lit(?),_40195,!],_40151,_40155) --> 
    cc(?,_40151,_40193),
    qtrailer(_40195,_40193,_40155),
    !.

qtrailer0([qtrailer0,lit('.'),_40195,!],_40151,_40155) --> 
    cc('.',_40151,_40193),
    qtrailer(_40195,_40193,_40155),
    !.

qtrailer0([qtrailer0,lit(a),_40195,!],_40151,_40155) --> 
    cc(a,_40151,_40193),
    qtrailer(_40195,_40193,_40155),
    !.

qtrailer0([qtrailer0,_40163,!],_40141,_40145) --> 
    qtrailer(_40163,_40141,_40145),
    !.

qtrailer0([qtrailer0,[]],_40135,_40135) --> 
    [].

qtrailer([qtrailer,lit(a)],_40139,_40143) --> 
    cc(a,_40139,_40143).

qtrailer([qtrailer,lit(takk)],_40139,_40143) --> 
    cc(takk,_40139,_40143).

qtrailer([qtrailer,_40173,lit(du),_40243],_40151,_40155) --> 
    be(_40173,_40151,_40203),
    cc(du,_40203,_40241),
    good(_40243,_40241,_40155).

qtrailer([qtrailer,lit(ca)],_40139,_40143) --> 
    cc(ca,_40139,_40143).

qtrailer([qtrailer,lit(da)],_40139,_40143) --> 
    cc(da,_40139,_40143).

qtrailer([qtrailer,lit(eller),lit(ikke)],_40149,_40153) --> 
    cc(eller,_40149,_40191),
    cc(ikke,_40191,_40153).

qtrailer([qtrailer,lit(eller)],_40139,_40143) --> 
    cc(eller,_40139,_40143).

qtrailer([qtrailer,_40175,!],_40153,_40157) --> 
    w(name(hal,_40123,_40125),_40175,_40153,_40157),
    !.

qtrailer([qtrailer,_40197,_40285,!],_40175,_40179) --> 
    optional(w(adj2(great,nil)),_40197,_40175,_40261),
    w(noun(oracle,sin,u,n),_40285,_40261,_40179),
    !.

qtrailer([qtrailer,_40205,{},!],_40183,_40187) --> 
    w(noun(_40127,sin,u,n),_40205,_40183,_40187),
    {testmember(_40127,[program,oracle,boss])},
    !.

qtrailer([qtrailer,lit(og)],_40139,_40143) --> 
    cc(og,_40139,_40143).

qtrailer([qtrailer,lit(og),lit(når)],_40149,_40153) --> 
    cc(og,_40149,_40191),
    cc(når,_40191,_40153).

qtrailer([qtrailer,lit(lenger),!],_40145,_40149) --> 
    cc(lenger,_40145,_40149),
    !.

qtrailer([qtrailer,lit(lengre),!],_40145,_40149) --> 
    cc(lengre,_40145,_40149),
    !.

qtrailer([qtrailer,lit(så),_40233,lit(du),_40313,!],_40189,_40193) --> 
    cc(så,_40189,_40231),
    w(verb(be,_40145,_40147),_40233,_40231,_40267),
    cc(du,_40267,_40311),
    w(adj2(nice,nil),_40313,_40311,_40193),
    !.

qtrailer([qtrailer,_40169],_40147,_40151) --> 
    w(verb(believe,inf,fin),_40169,_40147,_40151).

qtrailer([qtrailer,_40179,lit(du)],_40157,_40161) --> 
    w(verb(believe,pres,fin),_40179,_40157,_40213),
    cc(du,_40213,_40161).

qtrailer([qtrailer,lit(ø)],_40139,_40143) --> 
    cc(ø,_40139,_40143).

qtrailer([qtrailer,_40175,lit(når)],_40153,_40157) --> 
    not_look_ahead([n],_40175,_40153,_40209),
    cc(når,_40209,_40157).

qtrailer([qtrailer,lit(din),_40223,_40311],_40179,_40183) --> 
    cc(din,_40179,_40221),
    optional(w(adj2(_40149,nil)),_40223,_40221,_40287),
    w(noun(_40127,sin,_40131,_40133),_40311,_40287,_40183).

qtrailer([qtrailer,_40199,{},!],_40177,_40181) --> 
    w(name(_40127,_40129,_40131),_40199,_40177,_40181),
    {testmember(_40131,[man,woman])},
    !.

qtrailer([qtrailer,lit(uansett)],_40139,_40143) --> 
    cc(uansett,_40139,_40143).

ctrailer0([ctrailer0,_40163,!],_40141,_40145) --> 
    ctrailer(_40163,_40141,_40145),
    !.

ctrailer0([ctrailer0,[]],_40135,_40135) --> 
    [].

ctrailer([ctrailer,_40157],_40135,_40139) --> 
    please(_40157,_40135,_40139).

ctrailer([ctrailer,lit(takk)],_40139,_40143) --> 
    cc(takk,_40139,_40143).

ctrailer([ctrailer,_40195,lit(du),_40275],_40173,_40177) --> 
    w(verb(be,pres,fin),_40195,_40173,_40229),
    cc(du,_40229,_40273),
    w(adj2(nice,nil),_40275,_40273,_40177).

ctrailer([ctrailer,lit(da)],_40139,_40143) --> 
    cc(da,_40139,_40143).

ctrailer([ctrailer,lit(din),_40223,_40311],_40179,_40183) --> 
    cc(din,_40179,_40221),
    optional(w(adj2(_40149,nil)),_40223,_40221,_40287),
    w(noun(_40127,sin,_40131,_40133),_40311,_40287,_40183).

dtrailer0([dtrailer0,{},_40203,!],_40167,_40171) --> 
    {\+user:value(dialog,1)},
    dtrailer(_40203,_40167,_40171),
    !.

dtrailer0([dtrailer0,[]],_40135,_40135) --> 
    [].

dtrailer([dtrailer,_40169],_40147,_40151) --> 
    w(name(tore,n,firstname),_40169,_40147,_40151).

dtrailer([dtrailer,_40179,lit(jeg)],_40157,_40161) --> 
    w(verb(think,_40127,fin),_40179,_40157,_40213),
    cc(jeg,_40213,_40161).

dtrailer([dtrailer,_40179,lit(jeg)],_40157,_40161) --> 
    w(verb(mean,_40127,fin),_40179,_40157,_40213),
    cc(jeg,_40213,_40161).

dtrailer([dtrailer,_40169],_40147,_40151) --> 
    w(name(bustuc,_40117,_40119),_40169,_40147,_40151).

dtrailer([dtrailer,lit(ass)],_40139,_40143) --> 
    cc(ass,_40139,_40143).

dtrailer([dtrailer,lit(da)],_40139,_40143) --> 
    cc(da,_40139,_40143).

dtrailer([dtrailer,lit(din),_40223,_40311],_40179,_40183) --> 
    cc(din,_40179,_40221),
    optional(w(adj2(_40149,nil)),_40223,_40221,_40287),
    w(noun(fool,sin,u,n),_40311,_40287,_40183).

dtrailer([dtrailer,lit(du)],_40139,_40143) --> 
    cc(du,_40139,_40143).

dtrailer([dtrailer,lit(eller),lit(hva)],_40149,_40153) --> 
    cc(eller,_40149,_40191),
    cc(hva,_40191,_40153).

dtrailer([dtrailer,lit(eller)],_40139,_40143) --> 
    cc(eller,_40139,_40143).

dtrailer([dtrailer,lit(gitt)],_40139,_40143) --> 
    cc(gitt,_40139,_40143).

dtrailer([dtrailer,lit(hvordan)],_40139,_40143) --> 
    cc(hvordan,_40139,_40143).

dtrailer([dtrailer,lit(hei)],_40139,_40143) --> 
    cc(hei,_40139,_40143).

dtrailer([dtrailer,lit(ja)],_40139,_40143) --> 
    cc(ja,_40139,_40143).

dtrailer([dtrailer,lit(jeg)],_40139,_40143) --> 
    cc(jeg,_40139,_40143).

dtrailer([dtrailer,lit(men),lit(når)],_40149,_40153) --> 
    cc(men,_40149,_40191),
    cc(når,_40191,_40153).

dtrailer([dtrailer,lit(ok)],_40139,_40143) --> 
    cc(ok,_40139,_40143).

dtrailer([dtrailer,lit(sjø)],_40139,_40143) --> 
    cc(sjø,_40139,_40143).

dtrailer([dtrailer,lit(?),lit(takk)],_40149,_40153) --> 
    cc(?,_40149,_40191),
    cc(takk,_40191,_40153).

dtrailer([dtrailer,_40181,lit(hilsen),_40291],_40159,_40163) --> 
    optional([med],_40181,_40159,_40245),
    cc(hilsen,_40245,_40289),
    skip_rest(_40291,_40289,_40163).

posspron(self,[posspron,_40177,_40225],_40149,_40153) --> 
    my(_40177,_40149,_40207),
    own0(_40225,_40207,_40153).

posspron(man,[posspron,lit(hans),_40203],_40153,_40157) --> 
    cc(hans,_40153,_40201),
    own0(_40203,_40201,_40157).

posspron(woman,[posspron,lit(hennes),_40203],_40153,_40157) --> 
    cc(hennes,_40153,_40201),
    own0(_40203,_40201,_40157).

posspron(savant,[posspron,_40171],_40143,_40147) --> 
    your(_40171,_40143,_40147).

posspron(person,[posspron,_40177,_40225],_40149,_40153) --> 
    their(_40177,_40149,_40207),
    own0(_40225,_40207,_40153).

posspron(thing,[posspron,_40171],_40143,_40147) --> 
    sin(_40171,_40143,_40147).

previous([previous,_40167],_40145,_40149) --> 
    w(adj2(previous,nil),_40167,_40145,_40149).

thereafter([thereafter,_40163,_40211],_40141,_40145) --> 
    andor0(_40163,_40141,_40193),
    later(_40211,_40193,_40145).

thereafter([thereafter,_40171,lit(det)],_40149,_40153) --> 
    prep1(after,_40171,_40149,_40205),
    cc(det,_40205,_40153).

thereafter([thereafter,_40171,lit(dette)],_40149,_40153) --> 
    prep1(after,_40171,_40149,_40205),
    cc(dette,_40205,_40153).

thereafter([thereafter,_40171,lit(der)],_40149,_40153) --> 
    prep1(after,_40171,_40149,_40205),
    cc(der,_40205,_40153).

thereafter([thereafter,lit(nest),_40203,lit(der)],_40159,_40163) --> 
    cc(nest,_40159,_40201),
    prep1(after,_40203,_40201,_40237),
    cc(der,_40237,_40163).

thereafter([thereafter,_40171,lit(hvert)],_40149,_40153) --> 
    prep1(after,_40171,_40149,_40205),
    cc(hvert,_40205,_40153).

beforethat([beforethat,lit(derfør)],_40139,_40143) --> 
    cc(derfør,_40139,_40143).

beforethat([beforethat,_40163,_40211],_40141,_40145) --> 
    andor0(_40163,_40141,_40193),
    earlier(_40211,_40193,_40145).

beforethat([beforethat,_40171,lit(det)],_40149,_40153) --> 
    prep1(before,_40171,_40149,_40205),
    cc(det,_40205,_40153).

beforethat([beforethat,_40171,lit(dette)],_40149,_40153) --> 
    prep1(after,_40171,_40149,_40205),
    cc(dette,_40205,_40153).

beforethat([beforethat,_40171,lit(der)],_40149,_40153) --> 
    prep1(after,_40171,_40149,_40205),
    cc(der,_40205,_40153).

beforethat([beforethat,_40171,lit(dette)],_40149,_40153) --> 
    prep1(before,_40171,_40149,_40205),
    cc(dette,_40205,_40153).

beforethat([beforethat,lit(nest),_40203,lit(der)],_40159,_40163) --> 
    cc(nest,_40159,_40201),
    prep1(before,_40203,_40201,_40237),
    cc(der,_40237,_40163).

preperly([preperly,lit(en),lit(del)],_40149,_40153) --> 
    cc(en,_40149,_40191),
    cc(del,_40191,_40153).

preperly([preperly,lit(enda)],_40139,_40143) --> 
    cc(enda,_40139,_40143).

preperly([preperly,lit(ekte)],_40139,_40143) --> 
    cc(ekte,_40139,_40143).

preperly([preperly,lit(litt)],_40139,_40143) --> 
    cc(litt,_40139,_40143).

preperly([preperly,lit(noe)],_40139,_40143) --> 
    cc(noe,_40139,_40143).

preperly([preperly,lit(reellt)],_40139,_40143) --> 
    cc(reellt,_40139,_40143).

preperly([preperly,lit(strengt)],_40139,_40143) --> 
    cc(strengt,_40139,_40143).

preperly([preperly,lit(strikt)],_40139,_40143) --> 
    cc(strikt,_40139,_40143).

preperly([preperly,lit(virkelig)],_40139,_40143) --> 
    cc(virkelig,_40139,_40143).

prep2(after,[prep2,lit(avgang),_40215],_40165,_40169) --> 
    cc(avgang,_40165,_40213),
    not_look_ahead(w(prep(_40129)),_40215,_40213,_40169).

prep2(before,[prep2,lit(ankomst),_40215],_40165,_40169) --> 
    cc(ankomst,_40165,_40213),
    not_look_ahead(w(prep(_40129)),_40215,_40213,_40169).

prep2(after,[prep2,_40181,_40229],_40153,_40157) --> 
    preperly(_40181,_40153,_40211),
    prep1(after,_40229,_40211,_40157).

prep2(after,[prep2,_40197,_40245,lit(enn)],_40169,_40173) --> 
    preperly(_40197,_40169,_40227),
    w(adj2(later,nil),_40245,_40227,_40279),
    cc(enn,_40279,_40173).

prep2(before,[prep2,_40181,_40229],_40153,_40157) --> 
    preperly(_40181,_40153,_40211),
    prep1(before,_40229,_40211,_40157).

prep2(before,[prep2,_40197,_40245,lit(enn)],_40169,_40173) --> 
    preperly(_40197,_40169,_40227),
    w(adj2(earlier,nil),_40245,_40227,_40279),
    cc(enn,_40279,_40173).

prep2(according_to,[prep2,_40185,lit(følge)],_40157,_40161) --> 
    prep1(in,_40185,_40157,_40219),
    cc(følge,_40219,_40161).

prep2(after,[prep2,_40181,_40229],_40153,_40157) --> 
    clock(_40181,_40153,_40211),
    prep1(after,_40229,_40211,_40157).

prep2(after,[prep2,_40181,_40229],_40153,_40157) --> 
    around1(_40181,_40153,_40211),
    prep1(after,_40229,_40211,_40157).

prep2(after,[prep2,lit(ca),_40207],_40157,_40161) --> 
    cc(ca,_40157,_40205),
    prep1(after,_40207,_40205,_40161).

prep2(after,[prep2,_40181,_40239],_40153,_40157) --> 
    prep1(after,_40181,_40153,_40215),
    around1(_40239,_40215,_40157).

prep2(after,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(from,_40185,_40157,_40219),
    prep1(after,_40243,_40219,_40161).

prep2(after,[prep2,_40199,_40257,_40315],_40171,_40175) --> 
    prep1(to,_40199,_40171,_40233),
    not_look_ahead([e],_40257,_40233,_40291),
    prep1(after,_40315,_40291,_40175).

prep2(after,[prep2,_40195,lit(og),_40275],_40167,_40171) --> 
    prep1(from,_40195,_40167,_40229),
    cc(og,_40229,_40273),
    prep1(with,_40275,_40273,_40171).

prep2(after,[prep2,lit(like),_40207],_40157,_40161) --> 
    cc(like,_40157,_40205),
    prep1(after,_40207,_40205,_40161).

prep2(after,[prep2,_40181,_40229],_40153,_40157) --> 
    not(_40181,_40153,_40211),
    prep(before,_40229,_40211,_40157).

prep2(after,[prep2,lit(senere),lit(enn)],_40157,_40161) --> 
    cc(senere,_40157,_40205),
    cc(enn,_40205,_40161).

prep2(after,[prep2,lit(resten),_40207],_40157,_40161) --> 
    cc(resten,_40157,_40205),
    prep1(off,_40207,_40205,_40161).

prep2(around,[prep2,_40177,_40225],_40149,_40153) --> 
    around1(_40177,_40149,_40207),
    around0(_40225,_40207,_40153).

prep2(at,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(in,_40185,_40157,_40219),
    prep1(at,_40243,_40219,_40161).

prep2(at,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(on,_40185,_40157,_40219),
    prep1(at,_40243,_40219,_40161).

prep2(at,[prep2,_40205,_40263,lit(av)],_40177,_40181) --> 
    prep1(at,_40205,_40177,_40239),
    w(noun(side,_40141,_40143,_40145),_40263,_40239,_40297),
    cc(av,_40297,_40181).

prep2(before,[prep2,lit(for),_40217],_40167,_40171) --> 
    cc(for,_40167,_40215),
    look_ahead(w(nb(_40129,num)),_40217,_40215,_40171).

prep2(before,[prep2,_40201,_40259,!],_40173,_40177) --> 
    w(noun(arrival,sin,u,n),_40201,_40173,_40235),
    prep1(before,_40259,_40235,_40177),
    !.

prep2(before,[prep2,_40181,_40239],_40153,_40157) --> 
    prep1(before,_40181,_40153,_40215),
    ca(_40239,_40215,_40157).

prep2(before,[prep2,lit(like),_40207],_40157,_40161) --> 
    cc(like,_40157,_40205),
    prep1(before,_40207,_40205,_40161).

prep2(before,[prep2,_40181,_40229],_40153,_40157) --> 
    not(_40181,_40153,_40211),
    prep(after,_40229,_40211,_40157).

prep2(before,[prep2,lit(senest),_40207],_40157,_40161) --> 
    cc(senest,_40157,_40205),
    prep1(before,_40207,_40205,_40161).

prep2(before,[prep2,lit(senest)],_40147,_40151) --> 
    cc(senest,_40147,_40151).

prep2(before,[prep2,_40191,_40249],_40163,_40167) --> 
    w(adj2(present,nil),_40191,_40163,_40225),
    prep1(before,_40249,_40225,_40167).

prep2(before,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(to,_40185,_40157,_40219),
    prep1(before,_40243,_40219,_40161).

prep2(before,[prep2,_40185,lit(ca)],_40157,_40161) --> 
    prep1(to,_40185,_40157,_40219),
    cc(ca,_40219,_40161).

prep2(between,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(from,_40185,_40157,_40219),
    prep1(between,_40243,_40219,_40161).

prep2(between,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(in,_40185,_40157,_40219),
    prep1(between,_40243,_40219,_40161).

prep2(between,[prep2,_40201,_40249,_40307],_40173,_40177) --> 
    a0(_40201,_40173,_40231),
    w(noun(place,_40137,_40139,n),_40249,_40231,_40283),
    prep1(between,_40307,_40283,_40177).

prep2(during,[prep2,_40195,lit(løpet),lit(av)],_40167,_40171) --> 
    prep1(in,_40195,_40167,_40229),
    cc(løpet,_40229,_40273),
    cc(av,_40273,_40171).

prep2(during2,[prep2,lit(om),_40203],_40153,_40157) --> 
    cc(om,_40153,_40201),
    ca(_40203,_40201,_40157).

prep2(from,[prep2,_40181,_40239],_40153,_40157) --> 
    prep1(from,_40181,_40153,_40215),
    colon0(_40239,_40215,_40157).

prep2(from,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(from,_40185,_40157,_40219),
    prep1(near,_40243,_40219,_40161).

prep2(from,[prep2,_40213,_40271,_40329,!,_40397],_40185,_40189) --> 
    prep1(from,_40213,_40185,_40247),
    w(adj2(up,nil),_40271,_40247,_40305),
    prep1(at,_40329,_40305,_40363),
    !,
    accept(_40397,_40363,_40189).

prep2(from,[prep2,_40197,_40255,!,_40323],_40169,_40173) --> 
    prep1(from,_40197,_40169,_40231),
    prep1(from,_40255,_40231,_40289),
    !,
    accept(_40323,_40289,_40173).

prep2(from,[prep2,lit(med),_40207],_40157,_40161) --> 
    cc(med,_40157,_40205),
    prep1(from,_40207,_40205,_40161).

prep2(from,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(in,_40185,_40157,_40219),
    prep1(from,_40243,_40219,_40161).

prep2(from,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(over,_40185,_40157,_40219),
    prep1(from,_40243,_40219,_40161).

prep2(from,[prep2,lit(ifra)],_40147,_40151) --> 
    cc(ifra,_40147,_40151).

prep2(from,[prep2,lit(inn),_40207],_40157,_40161) --> 
    cc(inn,_40157,_40205),
    prep1(from,_40207,_40205,_40161).

prep2(from,[prep2,lit(ut),_40203],_40153,_40157) --> 
    cc(ut,_40153,_40201),
    offrom(_40203,_40201,_40157).

prep2(from,[prep2,_40205,_40263,_40321],_40177,_40181) --> 
    prep1(with,_40205,_40177,_40239),
    w(noun(start,sin,_40143,_40145),_40263,_40239,_40297),
    prep1(in,_40321,_40297,_40181).

prep2(from,[prep2,_40181,_40229],_40153,_40157) --> 
    umpover(_40181,_40153,_40211),
    prep1(from,_40229,_40211,_40157).

prep2(from,[prep2,_40205,_40263,lit(nærheten),lit(av)],_40177,_40181) --> 
    prep1(from,_40205,_40177,_40239),
    prep1(in,_40263,_40239,_40297),
    cc(nærheten,_40297,_40341),
    cc(av,_40341,_40181).

prep2(in,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(around,_40185,_40157,_40219),
    prep1(in,_40243,_40219,_40161).

prep2(in,[prep2,lit(inne),_40207],_40157,_40161) --> 
    cc(inne,_40157,_40205),
    prep1(in,_40207,_40205,_40161).

prep2(in,[prep2,lit(nede),_40207],_40157,_40161) --> 
    cc(nede,_40157,_40205),
    prep1(in,_40207,_40205,_40161).

prep2(instead_of,[prep2,lit(i),lit(stedet),lit(for)],_40167,_40171) --> 
    cc(i,_40167,_40215),
    cc(stedet,_40215,_40237),
    cc(for,_40237,_40171).

prep2(near,[prep2,_40187,_40235,_40293],_40159,_40163) --> 
    so0(_40187,_40159,_40217),
    prep1(near,_40235,_40217,_40269),
    to0(_40293,_40269,_40163).

prep2(near,[prep2,_40195,lit(nærheten),lit(av)],_40167,_40171) --> 
    prep1(in,_40195,_40167,_40229),
    cc(nærheten,_40229,_40273),
    cc(av,_40273,_40171).

prep2(near,[prep2,lit(like),_40207],_40157,_40161) --> 
    cc(like,_40157,_40205),
    prep1(at,_40207,_40205,_40161).

prep2(near,[prep2,_40199,_40247,_40305,_40353],_40171,_40175) --> 
    and0(_40199,_40171,_40229),
    w(adj2(nearest,nil),_40247,_40229,_40281),
    possible0(_40305,_40281,_40335),
    to0(_40353,_40335,_40175).

prep2(near,[prep2,_40191,_40249],_40163,_40167) --> 
    w(adj2(near,nil),_40191,_40163,_40225),
    prep1(at,_40249,_40225,_40167).

prep2(near,[prep2,_40201,lit(eller),_40281],_40173,_40177) --> 
    prep1(to,_40201,_40173,_40235),
    cc(eller,_40235,_40279),
    w(adj2(near,nil),_40281,_40279,_40177).

prep2(near,[prep2,_40201,lit(eller),_40281],_40173,_40177) --> 
    prep1(past,_40201,_40173,_40235),
    cc(eller,_40235,_40279),
    w(adj2(near,nil),_40281,_40279,_40177).

prep2(on,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(in,_40185,_40157,_40219),
    prep1(on,_40243,_40219,_40161).

prep2(on,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(with,_40185,_40157,_40219),
    prep1(on,_40243,_40219,_40161).

prep2(on,[prep2,_40203,lit(midt),_40273,!,_40341],_40175,_40179) --> 
    ca0(_40203,_40175,_40233),
    cc(midt,_40233,_40271),
    prep1(on,_40273,_40271,_40307),
    !,
    accept(_40341,_40307,_40179).

prep2(on,[prep2,lit(nede),_40207],_40157,_40161) --> 
    cc(nede,_40157,_40205),
    prep1(on,_40207,_40205,_40161).

prep2(out_of,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(to,_40185,_40157,_40219),
    prep1(outside,_40243,_40219,_40161).

prep2(outside,[prep2,lit(ikke),_40207],_40157,_40161) --> 
    cc(ikke,_40157,_40205),
    prep1(past,_40207,_40205,_40161).

prep2(outside,[prep2,lit(ikke),_40207],_40157,_40161) --> 
    cc(ikke,_40157,_40205),
    prep1(to,_40207,_40205,_40161).

prep2(over,[prep2,lit(litt),_40207],_40157,_40161) --> 
    cc(litt,_40157,_40205),
    prep1(over,_40207,_40205,_40161).

prep2(over,[prep2,_40185,lit(hvilke)],_40157,_40161) --> 
    prep1(over,_40185,_40157,_40219),
    cc(hvilke,_40219,_40161).

prep2(past,[prep2,lit(og),lit(ned)],_40157,_40161) --> 
    cc(og,_40157,_40205),
    cc(ned,_40205,_40161).

prep2(past,[prep2,lit(og),_40207],_40157,_40161) --> 
    cc(og,_40157,_40205),
    prep1(past,_40207,_40205,_40161).

prep2(past,[prep2,lit(ned)],_40147,_40151) --> 
    cc(ned,_40147,_40151).

prep2(past,[prep2,_40215,lit(/),_40295,lit(nærheten),lit(av)],_40187,_40191) --> 
    prep1(past,_40215,_40187,_40249),
    cc(/,_40249,_40293),
    prep1(in,_40295,_40293,_40329),
    cc(nærheten,_40329,_40373),
    cc(av,_40373,_40191).

prep2(past,[prep2,_40215,lit(eller),_40295,lit(nærheten),lit(av)],_40187,_40191) --> 
    prep1(past,_40215,_40187,_40249),
    cc(eller,_40249,_40293),
    prep1(in,_40295,_40293,_40329),
    cc(nærheten,_40329,_40373),
    cc(av,_40373,_40191).

prep2(past,[prep2,_40207,lit(/),_40287,!,_40355],_40179,_40183) --> 
    prep1(to,_40207,_40179,_40241),
    cc(/,_40241,_40285),
    prep1(from,_40287,_40285,_40321),
    !,
    accept(_40355,_40321,_40183).

prep2(past,[prep2,_40203,_40261,_40309,!,_40377],_40175,_40179) --> 
    prep1(to,_40203,_40175,_40237),
    and0(_40261,_40237,_40291),
    prep1(from,_40309,_40291,_40343),
    !,
    accept(_40377,_40343,_40179).

prep2(past,[prep2,_40203,_40261,_40309,!,_40377],_40175,_40179) --> 
    prep1(from,_40203,_40175,_40237),
    and1(_40261,_40237,_40291),
    prep1(to,_40309,_40291,_40343),
    !,
    accept(_40377,_40343,_40179).

prep2(past,[prep2,_40195,_40253],_40167,_40171) --> 
    prep1(with,_40195,_40167,_40229),
    w(noun(departure,_40127,_40129,_40131),_40253,_40229,_40171).

prep2(past,[prep2,_40195,lit(/),_40275],_40167,_40171) --> 
    prep1(past,_40195,_40167,_40229),
    cc(/,_40229,_40273),
    prep1(past,_40275,_40273,_40171).

prep2(to,[prep2,_40181,_40239],_40153,_40157) --> 
    prep1(to,_40181,_40153,_40215),
    colon0(_40239,_40215,_40157).

prep2(to,[prep2,_40197,_40255,!,_40323],_40169,_40173) --> 
    prep1(to,_40197,_40169,_40231),
    prep1(to,_40255,_40231,_40289),
    !,
    accept(_40323,_40289,_40173).

prep2(to,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(to,_40185,_40157,_40219),
    prep1(near,_40243,_40219,_40161).

prep2(to,[prep2,_40205,_40263,_40321],_40177,_40181) --> 
    prep1(in,_40205,_40177,_40239),
    w(noun(connection,_40141,u,n),_40263,_40239,_40297),
    prep1(with,_40321,_40297,_40181).

prep2(to,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(over,_40185,_40157,_40219),
    prep1(to,_40243,_40219,_40161).

prep2(to,[prep2,_40195,_40253],_40167,_40171) --> 
    prep1(with,_40195,_40167,_40229),
    w(noun(arrival,_40127,_40129,_40131),_40253,_40229,_40171).

prep2(to,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(with,_40185,_40157,_40219),
    prep1(to,_40243,_40219,_40161).

prep2(to,[prep2,_40181,_40229],_40153,_40157) --> 
    andsoon(_40181,_40153,_40211),
    prep1(to,_40229,_40211,_40157).

prep2(to,[prep2,lit(hjem),_40207],_40157,_40161) --> 
    cc(hjem,_40157,_40205),
    prep1(to,_40207,_40205,_40161).

prep2(to,[prep2,lit(inn),_40207],_40157,_40161) --> 
    cc(inn,_40157,_40205),
    prep1(to,_40207,_40205,_40161).

prep2(to,[prep2,lit(ned),_40207],_40157,_40161) --> 
    cc(ned,_40157,_40205),
    prep1(to,_40207,_40205,_40161).

prep2(to,[prep2,lit(opp),_40207],_40157,_40161) --> 
    cc(opp,_40157,_40205),
    prep1(to,_40207,_40205,_40161).

prep2(to,[prep2,lit(tur),lit(retur)],_40157,_40161) --> 
    cc(tur,_40157,_40205),
    cc(retur,_40205,_40161).

prep2(to,[prep2,_40181,_40229],_40153,_40157) --> 
    umpover(_40181,_40153,_40211),
    prep1(to,_40229,_40211,_40157).

prep2(towards,[prep2,lit(inn),_40207],_40157,_40161) --> 
    cc(inn,_40157,_40205),
    prep1(towards,_40207,_40205,_40161).

prep2(towards,[prep2,lit(ut),_40207],_40157,_40161) --> 
    cc(ut,_40157,_40205),
    prep1(towards,_40207,_40205,_40161).

prep2(towards,[prep2,lit(ned),_40207],_40157,_40161) --> 
    cc(ned,_40157,_40205),
    prep1(towards,_40207,_40205,_40161).

prep2(towards,[prep2,_40181,_40229],_40153,_40157) --> 
    umpover(_40181,_40153,_40211),
    prep1(towards,_40229,_40211,_40157).

prep2(until,[prep2,_40171],_40143,_40147) --> 
    until(_40171,_40143,_40147).

prep2(with,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(with,_40185,_40157,_40219),
    prep1(on,_40243,_40219,_40161).

prep2(with,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(with,_40185,_40157,_40219),
    prep1(in,_40243,_40219,_40161).

prep2(with,[prep2,_40187,lit(bruk),_40257],_40159,_40163) --> 
    by(_40187,_40159,_40217),
    cc(bruk,_40217,_40255),
    of(_40257,_40255,_40163).

prep2(within,[prep2,_40185,_40243],_40157,_40161) --> 
    prep1(on,_40185,_40157,_40219),
    prep1(under,_40243,_40219,_40161).

prep2(without,[prep2,lit(fri),lit(for)],_40157,_40161) --> 
    cc(fri,_40157,_40205),
    cc(for,_40205,_40161).

umpover([umpover,lit(opp),_40193],_40149,_40153) --> 
    cc(opp,_40149,_40191),
    prep1(over,_40193,_40191,_40153).

umpover([umpover,lit(bort)],_40139,_40143) --> 
    cc(bort,_40139,_40143).

umpover([umpover,_40161],_40139,_40143) --> 
    prep1(over,_40161,_40139,_40143).

umpover([umpover,lit(bortover)],_40139,_40143) --> 
    cc(bortover,_40139,_40143).

umpover([umpover,lit(utover)],_40139,_40143) --> 
    cc(utover,_40139,_40143).

umpover([umpover,lit(innover)],_40139,_40143) --> 
    cc(innover,_40139,_40143).

umpover([umpover,lit(oppover)],_40139,_40143) --> 
    cc(oppover,_40139,_40143).

umpover([umpover,lit(nedover)],_40139,_40143) --> 
    cc(nedover,_40139,_40143).

umpover([umpover,lit(hitover)],_40139,_40143) --> 
    cc(hitover,_40139,_40143).

umpover([umpover,_40181,_40239],_40159,_40163) --> 
    prep1(on,_40181,_40159,_40215),
    w(noun(route,sin,_40125,n),_40239,_40215,_40163).

umpover([umpover,_40181,_40239],_40159,_40163) --> 
    prep1(on,_40181,_40159,_40215),
    w(noun(direction,sin,_40125,n),_40239,_40215,_40163).

pronoun1(_40111,[pronoun1,lit(de),!,_40219],_40159,_40163) --> 
    cc(de,_40159,_40207),
    !,
    reject(_40219,_40207,_40163).

pronoun1(_40111,[pronoun1,lit(en),!,_40219],_40159,_40163) --> 
    cc(en,_40159,_40207),
    !,
    reject(_40219,_40207,_40163).

pronoun1(_40111,[pronoun1,_40175],_40147,_40151) --> 
    pronoun(_40111,_40175,_40147,_40151).

pronoun(thing,[pronoun,_40201,_40259,!,_40317],_40173,_40177) --> 
    one_of_lit([noe,det],_40201,_40173,_40235),
    not_look_ahead_np(_40259,_40235,_40289),
    !,
    accept(_40317,_40289,_40177).

pronoun(thing,[pronoun,lit(det),_40259,_40307,_40365,!,_40433],_40209,_40213) --> 
    cc(det,_40209,_40257),
    look_ahead_vp(_40259,_40257,_40289),
    not_look_ahead(w(adj2(_40157,_40159)),_40307,_40289,_40341),
    not_look_ahead(w(noun(_40171,_40173,_40175,_40177)),_40365,_40341,_40399),
    !,
    accept(_40433,_40399,_40213).

pronoun(agent,[pronoun,lit(man)],_40147,_40151) --> 
    cc(man,_40147,_40151).

pronoun(self,[pronoun,lit(jeg),_40233,_40291],_40183,_40187) --> 
    cc(jeg,_40183,_40231),
    not_look_ahead(['.'],_40233,_40231,_40267),
    not_look_ahead(w(name(_40135,_40137,_40139)),_40291,_40267,_40187).

pronoun(self,[pronoun,lit(meg)],_40147,_40151) --> 
    cc(meg,_40147,_40151).

pronoun(vehicle,[pronoun,lit(den),_40225,{}],_40175,_40179) --> 
    cc(den,_40175,_40223),
    not_look_ahead_np(_40225,_40223,_40179),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(de),_40225,{}],_40175,_40179) --> 
    cc(de,_40175,_40223),
    not_look_ahead_np(_40225,_40223,_40179),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(_40131),{},_40263,!],_40199,_40203) --> 
    cc(_40131,_40199,_40247),
    {testmember(_40131,[den,det,en,et])},
    look_ahead([som],_40263,_40247,_40203),
    !.

pronoun(_40111,[pronoun,lit(_40139),{},_40259],_40189,_40193) --> 
    cc(_40139,_40189,_40237),
    {dict_n:pronoun(_40139,_40111)},
    not_look_ahead(w(nb(_40135,_40137)),_40259,_40237,_40193).

pronoun(thing,[pronoun,lit(dette),_40253,_40311,!,_40379],_40203,_40207) --> 
    cc(dette,_40203,_40251),
    not_look_ahead(w(adj2(_40151,_40153)),_40253,_40251,_40287),
    not_look_ahead(w(noun(_40165,_40167,_40169,_40171)),_40311,_40287,_40345),
    !,
    accept(_40379,_40345,_40207).

pronoun(thing,[pronoun,lit(denne),_40215,!,_40273],_40165,_40169) --> 
    cc(denne,_40165,_40213),
    not_look_ahead_np(_40215,_40213,_40245),
    !,
    accept(_40273,_40245,_40169).

pronoun(agent,[pronoun,lit(vi)],_40147,_40151) --> 
    cc(vi,_40147,_40151).

pronoun(savant,[pronoun,lit(du)],_40147,_40151) --> 
    cc(du,_40147,_40151).

pronoun(agent,[pronoun,lit(dere)],_40147,_40151) --> 
    cc(dere,_40147,_40151).

quant_pron(some,person,[quant_pron,lit(en),_40237,!],_40181,_40185) --> 
    cc(en,_40181,_40235),
    look_ahead(w(verb(_40141,_40143,_40145)),_40237,_40235,_40185),
    !.

quant_pron(some,thing,[quant_pron,lit(mye),_40221,!],_40165,_40169) --> 
    cc(mye,_40165,_40219),
    not_look_ahead_np(_40221,_40219,_40169),
    !.

quant_pron(every,person,[quant_pron,_40207,lit(alle),_40287],_40173,_40177) --> 
    not_look_ahead([hver],_40207,_40173,_40241),
    cc(alle,_40241,_40285),
    not_look_ahead_np(_40287,_40285,_40177).

quant_pron(every,thing,[quant_pron,_40215,lit(alt),_40295],_40181,_40185) --> 
    not_look_ahead(w(name(_40137,_40139,_40141)),_40215,_40181,_40249),
    cc(alt,_40249,_40293),
    sammen0(_40295,_40293,_40185).

quant_pron(some,person,[quant_pron,lit(den),_40229,!],_40173,_40177) --> 
    cc(den,_40173,_40227),
    look_ahead([som],_40229,_40227,_40177),
    !.

quant_pron(some,thing,[quant_pron,lit(det),_40229,!],_40173,_40177) --> 
    cc(det,_40173,_40227),
    look_ahead([som],_40229,_40227,_40177),
    !.

quant_pron(some,person,[quant_pron,lit(man)],_40153,_40157) --> 
    cc(man,_40153,_40157).

quant_pron(some,thing,[quant_pron,lit(mer),_40223],_40167,_40171) --> 
    cc(mer,_40167,_40221),
    not_look_ahead([enn],_40223,_40221,_40171).

quant_pron(some,thing,[quant_pron,lit(noe)],_40153,_40157) --> 
    cc(noe,_40153,_40157).

quant_pron(some,agent,[quant_pron,lit(noen),_40235,_40283],_40179,_40183) --> 
    cc(noen,_40179,_40233),
    avdem0(_40235,_40233,_40265),
    not_look_ahead(w(adj(_40137,_40139)),_40283,_40265,_40183).

avdem0([avdem0,lit(av),lit(våre),!,_40237],_40161,_40165) --> 
    cc(av,_40161,_40203),
    cc(våre,_40203,_40225),
    !,
    reject(_40237,_40225,_40165).

avdem0([avdem0,lit(av),lit(dem),!],_40155,_40159) --> 
    cc(av,_40155,_40197),
    cc(dem,_40197,_40159),
    !.

avdem0([avdem0,[]],_40135,_40135) --> 
    [].

quant_pron(some,vehicle,[quant_pron,lit(noen),_40223],_40167,_40171) --> 
    cc(noen,_40167,_40221),
    not_look_ahead([av],_40223,_40221,_40171).

quant_pron(some,agent,[quant_pron,_40183],_40149,_40153) --> 
    someone(_40183,_40149,_40153).

quant_pron(some,thing,[quant_pron,_40205,_40253],_40171,_40175) --> 
    something(_40205,_40171,_40235),
    not_look_ahead(w(verb(_40131,_40133,pass)),_40253,_40235,_40175).

quant_pron(no,person,[quant_pron,lit(ingen),_40215],_40159,_40163) --> 
    cc(ingen,_40159,_40213),
    not_look_ahead_np(_40215,_40213,_40163).

quant_pron(no,thing,[quant_pron,lit(intet),_40233],_40177,_40181) --> 
    cc(intet,_40177,_40231),
    not_look_ahead(w(noun(_40131,_40133,_40135,_40137)),_40233,_40231,_40181).

quant_pron(no,thing,[quant_pron,lit(ingen),lit(ting)],_40163,_40167) --> 
    cc(ingen,_40163,_40217),
    cc(ting,_40217,_40167).

quant_pron(no,thing,[quant_pron,lit(ingenting)],_40153,_40157) --> 
    cc(ingenting,_40153,_40157).

quant_pron(much,thing,[quant_pron,_40203,_40251],_40169,_40173) --> 
    somuch(_40203,_40169,_40233),
    not_look_ahead(w(adj2(_40131,nil)),_40251,_40233,_40173).

quant_pron(little,thing,[quant_pron,_40235,_40293,_40341,_40399],_40201,_40205) --> 
    not_look_ahead(w(adv(_40157)),_40235,_40201,_40269),
    solittle(_40293,_40269,_40323),
    not_look_ahead([å],_40341,_40323,_40375),
    not_look_ahead(w(adj2(late,nil)),_40399,_40375,_40205).

quant_pron(some,feeling,[quant_pron,_40183],_40149,_40153) --> 
    somegood(_40183,_40149,_40153).

denbussen([denbussen,lit(den),_40211,!,_40279],_40167,_40171) --> 
    cc(den,_40167,_40209),
    w(adj2(_40137,nil),_40211,_40209,_40245),
    !,
    reject(_40279,_40245,_40171).

denbussen([denbussen,lit(den)],_40139,_40143) --> 
    cc(den,_40139,_40143).

sammen0([sammen0,lit(sammen),!],_40145,_40149) --> 
    cc(sammen,_40145,_40149),
    !.

sammen0([sammen0,_40173,!],_40151,_40155) --> 
    w(adj2(possible,nil),_40173,_40151,_40155),
    !.

sammen0([sammen0,[]],_40135,_40135) --> 
    [].

somuch([somuch,_40163,_40211],_40141,_40145) --> 
    so0(_40163,_40141,_40193),
    much(_40211,_40193,_40145).

solittle([solittle,_40163,_40211],_40141,_40145) --> 
    so0(_40163,_40141,_40193),
    little(_40211,_40193,_40145).

quant0(_40111,[quant0,_40187,!,_40255],_40159,_40163) --> 
    quant1(_40111,_40187,_40159,_40221),
    !,
    accept(_40255,_40221,_40163).

quant0(+1,[quant0,[]],_40147,_40147) --> 
    [].

quant1(+_40115,[quant1,_40185],_40157,_40161) --> 
    w(nb(_40115,num),_40185,_40157,_40161).

quant1(-_40115,[quant1,_40179],_40151,_40155) --> 
    ordinal(_40115,_40179,_40151,_40155).

recently([recently,lit(nylig)],_40139,_40143) --> 
    cc(nylig,_40139,_40143).

recently([recently,_40177,lit(det),_40257],_40155,_40159) --> 
    prep1(in,_40177,_40155,_40211),
    cc(det,_40211,_40255),
    latest(_40257,_40255,_40159).

everything([everything,_40183,lit(alt)],_40161,_40165) --> 
    not_look_ahead(w(name(_40129,_40131,_40133)),_40183,_40161,_40217),
    cc(alt,_40217,_40165).

something([something,lit(noe),lit(mer),!,_40237],_40161,_40165) --> 
    cc(noe,_40161,_40203),
    cc(mer,_40203,_40225),
    !,
    accept(_40237,_40225,_40165).

something([something,lit(noe),lit(som),lit(helst),!,_40269],_40171,_40175) --> 
    cc(noe,_40171,_40213),
    cc(som,_40213,_40235),
    cc(helst,_40235,_40257),
    !,
    accept(_40269,_40257,_40175).

something([something,lit(noe)],_40139,_40143) --> 
    cc(noe,_40139,_40143).

something([something,lit(det),_40195,!],_40151,_40155) --> 
    cc(det,_40151,_40193),
    endofline(_40195,_40193,_40155),
    !.

something([something,lit(det),_40221,_40279],_40177,_40181) --> 
    cc(det,_40177,_40219),
    not_look_ahead([å],_40221,_40219,_40255),
    not_look_ahead(w(noun(_40131,_40133,_40135,_40137)),_40279,_40255,_40181).

somegood([somegood,lit(det),_40211,_40259,!],_40167,_40171) --> 
    cc(det,_40167,_40209),
    so0(_40211,_40209,_40241),
    w(adj2(good,nil),_40259,_40241,_40171),
    !.

somegood([somegood,lit(det),_40211,_40259,!],_40167,_40171) --> 
    cc(det,_40167,_40209),
    so0(_40211,_40209,_40241),
    w(adj2(bad,nil),_40259,_40241,_40171),
    !.

sometimes0([sometimes0,_40161],_40139,_40143) --> 
    optional(sometimes,_40161,_40139,_40143).

sometimes([sometimes,lit(noen),_40215,!,_40283],_40171,_40175) --> 
    cc(noen,_40171,_40213),
    w(noun(time_count,_40139,_40141,_40143),_40215,_40213,_40249),
    !,
    accept(_40283,_40249,_40175).

sometimes([sometimes,lit(tidvis)],_40139,_40143) --> 
    cc(tidvis,_40139,_40143).

sometimes0([sometimes0,[]],_40135,_40135) --> 
    [].

notrel([notrel,_40177,!,_40245],_40155,_40159) --> 
    look_ahead([som],_40177,_40155,_40211),
    !,
    reject(_40245,_40211,_40159).

notrel([notrel,[]],_40135,_40135) --> 
    [].

relpron(thing,[relpron,lit(som),_40203],_40153,_40157) --> 
    cc(som,_40153,_40201),
    also0(_40203,_40201,_40157).

recipron(man,[recipron,lit(han),_40203],_40153,_40157) --> 
    cc(han,_40153,_40201),
    self(_40203,_40201,_40157).

recipron(person,[recipron,lit(seg),_40203],_40153,_40157) --> 
    cc(seg,_40153,_40201),
    self(_40203,_40201,_40157).

recipron(woman,[recipron,lit(henne),_40203],_40153,_40157) --> 
    cc(henne,_40153,_40201),
    self(_40203,_40201,_40157).

recipron(thing,[recipron,lit(seg),_40203],_40153,_40157) --> 
    cc(seg,_40153,_40201),
    self0(_40203,_40201,_40157).

recipron(thing,[recipron,lit(hverandre)],_40147,_40151) --> 
    cc(hverandre,_40147,_40151).

same([same,lit(samme)],_40139,_40143) --> 
    cc(samme,_40139,_40143).

self0([self0,_40157],_40135,_40139) --> 
    self(_40157,_40135,_40139).

self0([self0,[]],_40135,_40135) --> 
    [].

self([self,lit(selv)],_40139,_40143) --> 
    cc(selv,_40139,_40143).

set([set,_40171],_40149,_40153) --> 
    w(noun(set,_40117,_40119,n),_40171,_40149,_40153).

setlist([setlist,_40157],_40135,_40139) --> 
    set(_40157,_40135,_40139).

setlist([setlist,_40171],_40149,_40153) --> 
    w(noun(list,_40117,_40119,n),_40171,_40149,_40153).

several([several,lit(fler)],_40139,_40143) --> 
    cc(fler,_40139,_40143).

several([several,lit(flere)],_40139,_40143) --> 
    cc(flere,_40139,_40143).

several([several,lit(mer),lit(enn),_40221],_40155,_40159) --> 
    cc(mer,_40155,_40197),
    cc(enn,_40197,_40219),
    one(_40221,_40219,_40159).

sin([sin,lit(sin)],_40139,_40143) --> 
    cc(sin,_40139,_40143).

sin([sin,lit(sine)],_40139,_40143) --> 
    cc(sine,_40139,_40143).

sin([sin,lit(sitt)],_40139,_40143) --> 
    cc(sitt,_40139,_40143).

saa0([saa0,lit(bare),!,_40205],_40151,_40155) --> 
    cc(bare,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

saa0([saa0,lit(så),_40209,!,_40307],_40165,_40169) --> 
    cc(så,_40165,_40207),
    optional([ofte],_40209,_40207,_40273),
    !,
    accept(_40307,_40273,_40169).

saa0([saa0,lit(mye),!,_40205],_40151,_40155) --> 
    cc(mye,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

saa0([saa0,lit(da),!,_40205],_40151,_40155) --> 
    cc(da,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

saa0([saa0,[]],_40135,_40135) --> 
    [].

so0([so0,_40163,!],_40141,_40145) --> 
    so(_40163,_40141,_40145),
    !.

so0([so0,[]],_40135,_40135) --> 
    [].

so([so,lit(så)],_40139,_40143) --> 
    cc(så,_40139,_40143).

so([so,_40157],_40135,_40139) --> 
    too(_40157,_40135,_40139).

so([so,lit(heretter)],_40139,_40143) --> 
    cc(heretter,_40139,_40143).

so_that([so_that,lit(forat)],_40139,_40143) --> 
    cc(forat,_40139,_40143).

so_that([so_that,lit(som),lit(at)],_40149,_40153) --> 
    cc(som,_40149,_40191),
    cc(at,_40191,_40153).

so_that([so_that,lit(slik),_40203,_40251],_40159,_40163) --> 
    cc(slik,_40159,_40201),
    that(_40203,_40201,_40233),
    optional([bare],_40251,_40233,_40163).

so_that([so_that,lit(så),_40189],_40145,_40149) --> 
    cc(så,_40145,_40187),
    that(_40189,_40187,_40149).

so_that([so_that,lit(som),_40207,_40265],_40163,_40167) --> 
    cc(som,_40163,_40205),
    w(verb(do1,_40133,fin),_40207,_40205,_40241),
    that(_40265,_40241,_40167).

so_that([so_that,lit(så),_40215,!],_40171,_40175) --> 
    cc(så,_40171,_40213),
    look_ahead_lit([jeg,da,den,det],_40215,_40213,_40175),
    !.

so_that([so_that,lit(så),_40213,!],_40169,_40173) --> 
    cc(så,_40169,_40211),
    look_ahead(w(noun(_40135,_40137,_40139,_40141)),_40213,_40211,_40173),
    !.

so_that([so_that,lit(til),lit(at),!],_40155,_40159) --> 
    cc(til,_40155,_40197),
    cc(at,_40197,_40159),
    !.

so_that([so_that,_40171,lit(at)],_40149,_40153) --> 
    prep1(for,_40171,_40149,_40205),
    cc(at,_40205,_40153).

som0([som0,_40157],_40135,_40139) --> 
    som(_40157,_40135,_40139).

som0([som0,[]],_40135,_40135) --> 
    [].

som([som,lit(som)],_40139,_40143) --> 
    cc(som,_40139,_40143).

some([some,lit(noen),_40189],_40145,_40149) --> 
    cc(noen,_40145,_40187),
    of0(_40189,_40187,_40149).

someonex([someonex,_40157],_40135,_40139) --> 
    someone(_40157,_40135,_40139).

someone([someone,lit(dere)],_40139,_40143) --> 
    cc(dere,_40139,_40143).

someone([someone,lit(noen),_40189],_40145,_40149) --> 
    cc(noen,_40145,_40187),
    endofline(_40189,_40187,_40149).

someone([someone,lit(noen),_40205],_40161,_40165) --> 
    cc(noen,_40161,_40203),
    look_ahead(w(verb(_40125,_40127,_40129)),_40205,_40203,_40165).

someone([someone,_40167,lit(mange)],_40145,_40149) --> 
    so0(_40167,_40145,_40197),
    cc(mange,_40197,_40149).

someone([someone,lit(den),_40197],_40153,_40157) --> 
    cc(den,_40153,_40195),
    look_ahead([som],_40197,_40195,_40157).

someone([someone,lit(en),_40197],_40153,_40157) --> 
    cc(en,_40153,_40195),
    look_ahead([som],_40197,_40195,_40157).

soonar([soonar,lit(snart)],_40139,_40143) --> 
    cc(snart,_40139,_40143).

soonar([soonar,lit(snarest)],_40139,_40143) --> 
    cc(snarest,_40139,_40143).

soonar([soonar,lit(fort)],_40139,_40143) --> 
    cc(fort,_40139,_40143).

soon([soon,lit(fort)],_40139,_40143) --> 
    cc(fort,_40139,_40143).

soon([soon,_40167],_40145,_40149) --> 
    w(adj2(fast,nil),_40167,_40145,_40149).

soon([soon,lit(snart)],_40139,_40143) --> 
    cc(snart,_40139,_40143).

soon([soon,lit(snarest)],_40139,_40143) --> 
    cc(snarest,_40139,_40143).

statics(avg,[statics,lit(gjennomsnittet),_40203],_40153,_40157) --> 
    cc(gjennomsnittet,_40153,_40201),
    ofthe0(_40203,_40201,_40157).

statics(max(+1),[statics,lit(maksimum),_40211],_40161,_40165) --> 
    cc(maksimum,_40161,_40209),
    ofthe0(_40211,_40209,_40165).

statics(min(+1),[statics,lit(minimum),_40211],_40161,_40165) --> 
    cc(minimum,_40161,_40209),
    ofthe0(_40211,_40209,_40165).

statics(sum,[statics,_40177,_40225],_40149,_40153) --> 
    total(_40177,_40149,_40207),
    ofthe0(_40225,_40207,_40153).

statics(number,[statics,lit(antall),_40203],_40153,_40157) --> 
    cc(antall,_40153,_40201),
    ofthe0(_40203,_40201,_40157).

sure([sure,lit(sikker)],_40139,_40143) --> 
    cc(sikker,_40139,_40143).

sure([sure,lit(sikkert)],_40139,_40143) --> 
    cc(sikkert,_40139,_40143).

sure([sure,lit(sikre)],_40139,_40143) --> 
    cc(sikre,_40139,_40143).

terminator([terminator,_40169,!,_40227],_40147,_40151) --> 
    termchar(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

termchar0([termchar0,_40163,!],_40141,_40145) --> 
    termchar(_40163,_40141,_40145),
    !.

termchar0([termchar0,[]],_40135,_40135) --> 
    [].

termchar([termchar,lit('.')],_40139,_40143) --> 
    cc('.',_40139,_40143).

termchar([termchar,lit(?)],_40139,_40143) --> 
    cc(?,_40139,_40143).

termchar([termchar,lit(!)],_40139,_40143) --> 
    cc(!,_40139,_40143).

termchar([termchar,lit(:)],_40139,_40143) --> 
    cc(:,_40139,_40143).

than0([than0,_40157],_40135,_40139) --> 
    than(_40157,_40135,_40139).

than0([than0,[]],_40135,_40135) --> 
    [].

than([than,lit(enn)],_40139,_40143) --> 
    cc(enn,_40139,_40143).

that([that,lit(om),lit(at),!,_40237],_40161,_40165) --> 
    cc(om,_40161,_40203),
    cc(at,_40203,_40225),
    !,
    accept(_40237,_40225,_40165).

that([that,lit(at)],_40139,_40143) --> 
    cc(at,_40139,_40143).

that(that,[that,_40171],_40143,_40147) --> 
    that(_40171,_40143,_40147).

that(how,[that,_40171],_40143,_40147) --> 
    how(_40171,_40143,_40147).

that(when,[that,_40171],_40143,_40147) --> 
    when(_40171,_40143,_40147).

that(where,[that,_40171],_40143,_40147) --> 
    where(_40171,_40143,_40147).

that(whether,[that,_40181,lit(hvorvidt)],_40153,_40157) --> 
    paa0(_40181,_40153,_40211),
    cc(hvorvidt,_40211,_40157).

that(whether,[that,_40181,lit(om)],_40153,_40157) --> 
    paa0(_40181,_40153,_40211),
    cc(om,_40211,_40157).

that(why,[that,lit(hvorfor)],_40147,_40151) --> 
    cc(hvorfor,_40147,_40151).

paa0([paa0,lit(på),!,_40205],_40151,_40155) --> 
    cc(på,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

paa0([paa0,[]],_40135,_40135) --> 
    [].

that0([that0,_40157],_40135,_40139) --> 
    that(_40157,_40135,_40139).

that0([that0,[]],_40135,_40135) --> 
    [].

the([the,lit(den)],_40139,_40143) --> 
    cc(den,_40139,_40143).

the([the,lit(denne)],_40139,_40143) --> 
    cc(denne,_40139,_40143).

the([the,lit(det)],_40139,_40143) --> 
    cc(det,_40139,_40143).

the([the,lit(de)],_40139,_40143) --> 
    cc(de,_40139,_40143).

the([the,lit(dette)],_40139,_40143) --> 
    cc(dette,_40139,_40143).

the([the,lit(disse),_40189],_40145,_40149) --> 
    cc(disse,_40145,_40187),
    look_ahead_np(_40189,_40187,_40149).

themost([themost,_40167,lit(mest)],_40145,_40149) --> 
    the(_40167,_40145,_40197),
    cc(mest,_40197,_40149).

the0([the0,_40175,_40223,!,_40281],_40153,_40157) --> 
    the(_40175,_40153,_40205),
    der0(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

the0([the0,{},_40199],_40157,_40161) --> 
    {user:value(textflag,true)},
    art(_40199,_40157,_40161).

the0([the0,[]],_40135,_40135) --> 
    [].

the10([the10,lit(det)],_40139,_40143) --> 
    cc(det,_40139,_40143).

the10([the10,lit(den)],_40139,_40143) --> 
    cc(den,_40139,_40143).

the10([the10,[]],_40135,_40135) --> 
    [].

theplu0([theplu0,_40175,_40223,!,_40281],_40153,_40157) --> 
    all0(_40175,_40153,_40205),
    theplu(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

theplu0([theplu0,lit(den)],_40139,_40143) --> 
    cc(den,_40139,_40143).

theplu0([theplu0,_40157],_40135,_40139) --> 
    all0(_40157,_40135,_40139).

theplu([theplu,lit(de)],_40139,_40143) --> 
    cc(de,_40139,_40143).

their([their,lit(deres)],_40139,_40143) --> 
    cc(deres,_40139,_40143).

their([their,lit(de),lit(andres)],_40149,_40153) --> 
    cc(de,_40149,_40191),
    cc(andres,_40191,_40153).

then0([then0,_40169,!,_40227],_40147,_40151) --> 
    then1(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

then0([then0,[]],_40135,_40135) --> 
    [].

then1([then1,lit(da)],_40139,_40143) --> 
    cc(da,_40139,_40143).

then1([then1,lit(så)],_40139,_40143) --> 
    cc(så,_40139,_40143).

theonly0([theonly0,_40163,_40211],_40141,_40145) --> 
    the0(_40163,_40141,_40193),
    only0(_40211,_40193,_40145).

thereit0([thereit0,_40169,!,_40227],_40147,_40151) --> 
    thereit(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

thereit0([thereit0,[]],_40135,_40135) --> 
    [].

therenot0([therenot0,_40175,_40223,!,_40281],_40153,_40157) --> 
    thereit(_40175,_40153,_40205),
    not0(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

therenot0([therenot0,_40175,_40223,!,_40281],_40153,_40157) --> 
    not(_40175,_40153,_40205),
    thereit0(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

therenot0([therenot0,[]],_40135,_40135) --> 
    [].

thereit(_40111,[thereit,_40205,_40253,_40311,_40359,!,_40417],_40177,_40181) --> 
    thereit(_40205,_40177,_40235),
    negation0(_40111,_40253,_40235,_40287),
    redundant0(_40311,_40287,_40341),
    been0(_40359,_40341,_40389),
    !,
    accept(_40417,_40389,_40181).

thereitN([thereitN,_40177,_40225,!],_40155,_40159) --> 
    thereit(_40177,_40155,_40207),
    look_ahead([ikke],_40225,_40207,_40159),
    !.

thereitN([thereitN,_40157],_40135,_40139) --> 
    thereit(_40157,_40135,_40139).

dette([dette,lit(det),_40189],_40145,_40149) --> 
    cc(det,_40145,_40187),
    it_was_pronoun(_40189,_40187,_40149).

dette([dette,lit(dette)],_40139,_40143) --> 
    cc(dette,_40139,_40143).

thereit2(be,[thereit2,lit(det),!],_40153,_40157) --> 
    cc(det,_40153,_40157),
    !.

thereit2(_40111,[thereit2,_40177,!],_40149,_40153) --> 
    thereit(_40177,_40149,_40153),
    !.

thereit2(be,[thereit2,_40185,!],_40157,_40161) --> 
    look_ahead([til],_40185,_40157,_40161),
    !.

init([init,lit(det)],_40139,_40143) --> 
    cc(det,_40139,_40143).

init([init,lit(dette),_40189],_40145,_40149) --> 
    cc(dette,_40145,_40187),
    look_ahead_vp(_40189,_40187,_40149).

thereit([thereit,lit(de),_40197],_40153,_40157) --> 
    cc(de,_40153,_40195),
    look_ahead([noe],_40197,_40195,_40157).

thereit([thereit,lit(det),_40201,!,_40259],_40157,_40161) --> 
    cc(det,_40157,_40199),
    thereit_not_pronoun(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

thereit([thereit,lit(der)],_40139,_40143) --> 
    cc(der,_40139,_40143).

thereit([thereit,lit(her)],_40139,_40143) --> 
    cc(her,_40139,_40143).

thereit_not_pronoun([thereit_not_pronoun,_40169,!,_40227],_40147,_40151) --> 
    it_was_pronoun(_40169,_40147,_40199),
    !,
    reject(_40227,_40199,_40151).

thereit_not_pronoun([thereit_not_pronoun,[]],_40135,_40135) --> 
    [].

it_was_pronoun([it_was_pronoun,_40157],_40135,_40139) --> 
    endofline(_40157,_40135,_40139).

it_was_pronoun([it_was_pronoun,_40157],_40135,_40139) --> 
    look_ahead_vp(_40157,_40135,_40139).

this(_40111,[this,_40185,{}],_40157,_40161) --> 
    this(_40185,_40157,_40161),
    {it_template(_40111)}.

this(_40111,[this,_40185,{}],_40157,_40161) --> 
    thereit(_40185,_40157,_40161),
    {it_template(_40111)}.

this([this,lit(denne)],_40139,_40143) --> 
    cc(denne,_40139,_40143).

this([this,lit(dette)],_40139,_40143) --> 
    cc(dette,_40139,_40143).

this([this,lit(disse),_40189],_40145,_40149) --> 
    cc(disse,_40145,_40187),
    not_look_ahead_np(_40189,_40187,_40149).

this([this,lit(det),_40203,_40261],_40159,_40163) --> 
    cc(det,_40159,_40201),
    look_ahead(['.'],_40203,_40201,_40237),
    accept(_40261,_40237,_40163).

this([this,lit(det),_40203,_40261],_40159,_40163) --> 
    cc(det,_40159,_40201),
    look_ahead([?],_40203,_40201,_40237),
    accept(_40261,_40237,_40163).

this([this,lit(det),lit(da),!,_40237],_40161,_40165) --> 
    cc(det,_40161,_40203),
    cc(da,_40203,_40225),
    !,
    accept(_40237,_40225,_40165).

this([this,lit(det),_40201,!,_40259],_40157,_40161) --> 
    cc(det,_40157,_40199),
    end_of_line(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

this([this,lit(slik),_40201],_40157,_40161) --> 
    cc(slik,_40157,_40199),
    not_look_ahead_lit([at,som],_40201,_40199,_40161).

thisplace(in,[thisplace,lit(her)],_40147,_40151) --> 
    cc(her,_40147,_40151).

thisplace(to,[thisplace,lit(hit)],_40147,_40151) --> 
    cc(hit,_40147,_40151).

thisplace(in,[thisplace,lit(der)],_40147,_40151) --> 
    cc(der,_40147,_40151).

thisplace(to,[thisplace,lit(dit)],_40147,_40151) --> 
    cc(dit,_40147,_40151).

timepoint([timepoint,_40171],_40149,_40153) --> 
    w(noun(time,_40117,u,n),_40171,_40149,_40153).

timepoint([timepoint,_40171],_40149,_40153) --> 
    w(noun(clock,sin,u,n),_40171,_40149,_40153).

to([to,_40161],_40139,_40143) --> 
    prep(to,_40161,_40139,_40143).

forto0([forto0,_40163,!],_40141,_40145) --> 
    forto(_40163,_40141,_40145),
    !.

forto0([forto0,[]],_40135,_40135) --> 
    [].

forto([forto,lit(for)],_40139,_40143) --> 
    cc(for,_40139,_40143).

forto([forto,lit(til)],_40139,_40143) --> 
    cc(til,_40139,_40143).

forto([forto,lit(om)],_40139,_40143) --> 
    cc(om,_40139,_40143).

slikat([slikat,lit(slik),lit(at)],_40149,_40153) --> 
    cc(slik,_40149,_40191),
    cc(at,_40191,_40153).

slikat([slikat,lit(sikkert),lit(at)],_40149,_40153) --> 
    cc(sikkert,_40149,_40191),
    cc(at,_40191,_40153).

to0([to0,_40163,!],_40141,_40145) --> 
    to(_40163,_40141,_40145),
    !.

to0([to0,[]],_40135,_40135) --> 
    [].

tomed0([tomed0,lit(til),!],_40145,_40149) --> 
    cc(til,_40145,_40149),
    !.

tomed0([tomed0,lit(med),!],_40145,_40149) --> 
    cc(med,_40145,_40149),
    !.

tomed0([tomed0,[]],_40135,_40135) --> 
    [].

too([too,lit(for),_40203],_40159,_40163) --> 
    cc(for,_40159,_40201),
    look_ahead(w(adj(_40125,nil)),_40203,_40201,_40163).

today0([today0,_40157],_40135,_40139) --> 
    today(_40157,_40135,_40139).

today0([today0,[]],_40135,_40135) --> 
    [].

today([today,lit(idag)],_40139,_40143) --> 
    cc(idag,_40139,_40143).

today([today,_40181,_40239],_40159,_40163) --> 
    prep(in,_40181,_40159,_40215),
    w(noun(day,sin,u,n),_40239,_40215,_40163).

tomorrow([tomorrow,lit(imorgen)],_40139,_40143) --> 
    cc(imorgen,_40139,_40143).

tomorrow([tomorrow,_40171,lit(morgen)],_40149,_40153) --> 
    prep1(in,_40171,_40149,_40205),
    cc(morgen,_40205,_40153).

total([total,lit(total)],_40139,_40143) --> 
    cc(total,_40139,_40143).

total([total,lit(totalt)],_40139,_40143) --> 
    cc(totalt,_40139,_40143).

total([total,lit(totale)],_40139,_40143) --> 
    cc(totale,_40139,_40143).

total([total,lit(sum),_40189],_40145,_40149) --> 
    cc(sum,_40145,_40187),
    of(_40189,_40187,_40149).

true([true,lit(sann)],_40139,_40143) --> 
    cc(sann,_40139,_40143).

true([true,lit(sant)],_40139,_40143) --> 
    cc(sant,_40139,_40143).

true([true,lit(sanne)],_40139,_40143) --> 
    cc(sanne,_40139,_40143).

true([true,lit(slik)],_40139,_40143) --> 
    cc(slik,_40139,_40143).

truefalse(id,[truefalse,_40171],_40143,_40147) --> 
    true(_40171,_40143,_40147).

truefalse(id,[truefalse,_40177,_40225],_40149,_40153) --> 
    not(_40177,_40149,_40207),
    false(_40225,_40207,_40153).

truefalse(not,[truefalse,_40171],_40143,_40147) --> 
    false(_40171,_40143,_40147).

truefalse(not,[truefalse,_40177,_40225],_40149,_40153) --> 
    not(_40177,_40149,_40207),
    true(_40225,_40207,_40153).

unequal([unequal,lit(ulik)],_40139,_40143) --> 
    cc(ulik,_40139,_40143).

unequal([unequal,lit(ulikt)],_40139,_40143) --> 
    cc(ulikt,_40139,_40143).

unequal([unequal,lit(ulike)],_40139,_40143) --> 
    cc(ulike,_40139,_40143).

unequal([unequal,_40163,_40211],_40141,_40145) --> 
    not(_40163,_40141,_40193),
    equal(_40211,_40193,_40145).

until([until,lit(inntil)],_40139,_40143) --> 
    cc(inntil,_40139,_40143).

until([until,lit(fram),_40193],_40149,_40153) --> 
    cc(fram,_40149,_40191),
    prep1(to,_40193,_40191,_40153).

use([use,_40169],_40147,_40151) --> 
    w(verb(use,_40117,fin),_40169,_40147,_40151).

use([use,_40169],_40147,_40151) --> 
    w(verb(want,_40117,fin),_40169,_40147,_40151).

what([what,lit(hva)],_40139,_40143) --> 
    cc(hva,_40139,_40143).

whatbe([whatbe,_40175,_40223,!,_40281],_40153,_40157) --> 
    what(_40175,_40153,_40205),
    be(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

whatbe([whatbe,lit(hvilke),_40201,!,_40259],_40157,_40161) --> 
    cc(hvilke,_40157,_40199),
    be(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

whatbe([whatbe,lit(hvilken),_40201,!,_40259],_40157,_40161) --> 
    cc(hvilken,_40157,_40199),
    be(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

whatbe([whatbe,lit(hvilket),_40201,!,_40259],_40157,_40161) --> 
    cc(hvilket,_40157,_40199),
    be(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

whatbemean([whatbemean,lit(hva),_40201],_40157,_40161) --> 
    cc(hva,_40157,_40199),
    w(verb(be,pres,fin),_40201,_40199,_40161).

whatbemean([whatbemean,lit(hva),_40201],_40157,_40161) --> 
    cc(hva,_40157,_40199),
    w(verb(mean2,pres,fin),_40201,_40199,_40161).

whatbemean([whatbemean,lit(hva),_40201],_40157,_40161) --> 
    cc(hva,_40157,_40199),
    w(verb(indicate,pres,fin),_40201,_40199,_40161).

when0([when0,_40169,!,_40227],_40147,_40151) --> 
    when(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

when0([when0,[]],_40135,_40135) --> 
    [].

whenx([whenx,_40179,lit(jeg),!,_40259],_40157,_40161) --> 
    when1(_40179,_40157,_40209),
    cc(jeg,_40209,_40247),
    !,
    reject(_40259,_40247,_40161).

whenx([whenx,_40157],_40135,_40139) --> 
    when(_40157,_40135,_40139).

when([when,lit(når),_40201,!,_40259],_40157,_40161) --> 
    cc(når,_40157,_40199),
    timepoint(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

when([when,lit(når)],_40139,_40143) --> 
    cc(når,_40139,_40143).

when([when,lit(hvordan),_40215,!,_40283],_40171,_40175) --> 
    cc(hvordan,_40171,_40213),
    w(noun(time,_40139,u,n),_40215,_40213,_40249),
    !,
    accept(_40283,_40249,_40175).

when([when,lit(hvor),_40201,!,_40259],_40157,_40161) --> 
    cc(hvor,_40157,_40199),
    timepoint(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

when([when,lit(hva),_40201,!,_40259],_40157,_40161) --> 
    cc(hva,_40157,_40199),
    timepoint(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

when([when,_40175,_40223,!,_40281],_40153,_40157) --> 
    which(_40175,_40153,_40205),
    timepoint(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

when([when,_40185,_40243,_40291,!,_40349],_40163,_40167) --> 
    prep1(to,_40185,_40163,_40219),
    which(_40243,_40219,_40273),
    timepoint(_40291,_40273,_40321),
    !,
    accept(_40349,_40321,_40167).

when([when,_40185,_40243,_40291,!,_40349],_40163,_40167) --> 
    prep1(on,_40185,_40163,_40219),
    which(_40243,_40219,_40273),
    timepoint(_40291,_40273,_40321),
    !,
    accept(_40349,_40321,_40167).

when([when,lit(så),lit(snart),!,_40237],_40161,_40165) --> 
    cc(så,_40161,_40203),
    cc(snart,_40203,_40225),
    !,
    accept(_40237,_40225,_40165).

when([when,lit(hva),lit(ti)],_40149,_40153) --> 
    cc(hva,_40149,_40191),
    cc(ti,_40191,_40153).

when([when,lit(hvordan),lit(ti)],_40149,_40153) --> 
    cc(hvordan,_40149,_40191),
    cc(ti,_40191,_40153).

when([when,lit(tid),_40197],_40153,_40157) --> 
    cc(tid,_40153,_40195),
    look_ahead([går],_40197,_40195,_40157).

where([where,lit(hvor),_40219,_40277,!,_40335],_40175,_40179) --> 
    cc(hvor,_40175,_40217),
    not_look_ahead(w(prep(from)),_40219,_40217,_40253),
    andwhen0(_40277,_40253,_40307),
    !,
    accept(_40335,_40307,_40179).

where([where,_40189,_40237,!,_40305],_40167,_40171) --> 
    which(_40189,_40167,_40219),
    w(noun(place,_40135,_40137,_40139),_40237,_40219,_40271),
    !,
    accept(_40305,_40271,_40171).

where1([where1,lit(der),lit(hvor),!,_40237],_40161,_40165) --> 
    cc(der,_40161,_40203),
    cc(hvor,_40203,_40225),
    !,
    accept(_40237,_40225,_40165).

where1([where1,lit(hvor),_40201,!,_40259],_40157,_40161) --> 
    cc(hvor,_40157,_40199),
    meny(_40201,_40199,_40231),
    !,
    reject(_40259,_40231,_40161).

where1([where1,lit(hvor)],_40139,_40143) --> 
    cc(hvor,_40139,_40143).

where1([where1,lit(der)],_40139,_40143) --> 
    cc(der,_40139,_40143).

wherefrom([wherefrom,_40199,_40257,_40305,!,_40373],_40177,_40181) --> 
    prep1(from,_40199,_40177,_40233),
    which(_40257,_40233,_40287),
    w(noun(place,_40145,_40147,_40149),_40305,_40287,_40339),
    !,
    accept(_40373,_40339,_40181).

wherefrom([wherefrom,_40183,lit(hvor),!,_40273],_40161,_40165) --> 
    prep1(from,_40183,_40161,_40217),
    cc(hvor,_40217,_40261),
    !,
    accept(_40273,_40261,_40165).

wherefrom([wherefrom,lit(hvorfra)],_40139,_40143) --> 
    cc(hvorfra,_40139,_40143).

wherefrom([wherefrom,lit(hvor),lit(fra)],_40149,_40153) --> 
    cc(hvor,_40149,_40191),
    cc(fra,_40191,_40153).

wherefrom([wherefrom,lit(hvor),lit(ifra)],_40149,_40153) --> 
    cc(hvor,_40149,_40191),
    cc(ifra,_40191,_40153).

while([while,lit(mens)],_40139,_40143) --> 
    cc(mens,_40139,_40143).

which0([which0,_40169,!,_40227],_40147,_40151) --> 
    which(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

which0([which0,[]],_40135,_40135) --> 
    [].

which([which,lit(hva),_40205,_40263,!],_40161,_40165) --> 
    cc(hva,_40161,_40203),
    prep1(for,_40205,_40203,_40239),
    a0(_40263,_40239,_40165),
    !.

which([which,lit(hva),lit(slags),!],_40155,_40159) --> 
    cc(hva,_40155,_40197),
    cc(slags,_40197,_40159),
    !.

which([which,lit(hvilken),lit(slags),!],_40155,_40159) --> 
    cc(hvilken,_40155,_40197),
    cc(slags,_40197,_40159),
    !.

which([which,lit(hvilken)],_40139,_40143) --> 
    cc(hvilken,_40139,_40143).

which([which,lit(hvilket)],_40139,_40143) --> 
    cc(hvilket,_40139,_40143).

which([which,lit(hvilke),_40189],_40145,_40149) --> 
    cc(hvilke,_40145,_40187),
    off0(_40189,_40187,_40149).

which2([which2,_40169,_40217,_40265],_40147,_40151) --> 
    which(_40169,_40147,_40199),
    numbertype0(_40217,_40199,_40247),
    ofthe0(_40265,_40247,_40151).

which2([which2,lit(hvem),_40237,_40295,!],_40193,_40197) --> 
    cc(hvem,_40193,_40235),
    look_ahead(w(noun(_40141,sin,u,n)),_40237,_40235,_40271),
    gmem(_40141,[bus,tram,day],_40295,_40271,_40197),
    !.

which2([which2,lit(hvordan),_40241,_40299,!],_40197,_40201) --> 
    cc(hvordan,_40197,_40239),
    look_ahead(w(noun(_40141,sin,u,n)),_40241,_40239,_40275),
    gmem(_40141,[label,bus,tram,day],_40299,_40275,_40201),
    !.

numbertype0([numbertype0,_40169,!,_40227],_40147,_40151) --> 
    type(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

numbertype0([numbertype0,[]],_40135,_40135) --> 
    [].

with0([with0,_40173,!,_40241],_40151,_40155) --> 
    prep(with,_40173,_40151,_40207),
    !,
    accept(_40241,_40207,_40155).

with0([with0,[]],_40135,_40135) --> 
    [].

who([who,lit(hvem)],_40139,_40143) --> 
    cc(hvem,_40139,_40143).

whose([whose,lit(hvis)],_40139,_40143) --> 
    cc(hvis,_40139,_40143).

mex0([mex0,_40177,!,_40245],_40155,_40159) --> 
    look_ahead([jeg],_40177,_40155,_40211),
    !,
    reject(_40245,_40211,_40159).

mex0([mex0,_40177,!,_40245],_40155,_40159) --> 
    look_ahead([du],_40177,_40155,_40211),
    !,
    reject(_40245,_40211,_40159).

mex0([mex0,lit(seg),!,_40205],_40151,_40155) --> 
    cc(seg,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

mex0([mex0,lit(meg),!,_40205],_40151,_40155) --> 
    cc(meg,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

mex0([mex0,lit(oss),!,_40205],_40151,_40155) --> 
    cc(oss,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

mex0([mex0,[]],_40135,_40135) --> 
    [].

you([you,lit(du),_40197],_40153,_40157) --> 
    cc(du,_40153,_40195),
    not_look_ahead([jeg],_40197,_40195,_40157).

yesterday([yesterday,_40171,lit(går)],_40149,_40153) --> 
    prep1(in,_40171,_40149,_40205),
    cc(går,_40205,_40153).

younger([younger,lit(yngre)],_40139,_40143) --> 
    cc(yngre,_40139,_40143).

your([your,lit(din)],_40139,_40143) --> 
    cc(din,_40139,_40143).

your([your,lit(ditt)],_40139,_40143) --> 
    cc(ditt,_40139,_40143).

your([your,lit(dine)],_40139,_40143) --> 
    cc(dine,_40139,_40143).

your([your,lit(di)],_40139,_40143) --> 
    cc(di,_40139,_40143).

num_na(_40111,[num_na,_40183,!,_40241],_40155,_40159) --> 
    art(_40183,_40155,_40213),
    !,
    reject(_40241,_40213,_40159).

num_na(_40111,[num_na,_40181],_40153,_40157) --> 
    w(nb(_40111,_40121),_40181,_40153,_40157).

num(_40111,[num,_40187,!],_40159,_40163) --> 
    w(nb(_40111,num),_40187,_40159,_40163),
    !.

personal('    ',[personal,lit(hysj)],_40147,_40151) --> 
    cc(hysj,_40147,_40151).

personal('RPGOLRAM',[personal,lit(rpgol)],_40147,_40151) --> 
    cc(rpgol,_40147,_40151).

personal('OK',[personal,lit(rpgolram)],_40147,_40151) --> 
    cc(rpgolram,_40147,_40151).

personal('Takk',[personal,lit(værsågod)],_40147,_40151) --> 
    cc(værsågod,_40147,_40151).

personal('Takk',[personal,_40209,lit(så),_40289],_40181,_40185) --> 
    w(verb(be,imp,fin),_40209,_40181,_40243),
    cc(så,_40243,_40287),
    w(adj2(good,nil),_40289,_40287,_40185).

personal('Takk',[personal,_40189,_40237,_40285,_40333],_40161,_40165) --> 
    so(_40189,_40161,_40219),
    good(_40237,_40219,_40267),
    you(_40285,_40267,_40315),
    be(_40333,_40315,_40165).

personal('Takk',[personal,lit(bravo)],_40147,_40151) --> 
    cc(bravo,_40147,_40151).

personal('Takk',[personal,_40195,_40253,_40301],_40167,_40171) --> 
    w(verb(congratulate,pres,fin),_40195,_40167,_40229),
    with0(_40253,_40229,_40283),
    skip_rest(_40301,_40283,_40171).

personal(pong,[personal,lit(ping)],_40147,_40151) --> 
    cc(ping,_40147,_40151).

personal(_40111,[personal,_40175],_40147,_40151) --> 
    greetings(_40111,_40175,_40147,_40151).

greetings0([greetings0,_40181,_40239,!],_40159,_40163) --> 
    w(verb(help,imp,fin),_40181,_40159,_40215),
    optoken(_40239,_40215,_40163),
    !.

greetings0([greetings0,_40179,_40267,_40315,!],_40157,_40161) --> 
    optional(grums,_40179,_40157,_40243),
    greetings(_40267,_40243,_40297),
    optoken(_40315,_40297,_40161),
    !.

greetings0([greetings0,_40161],_40139,_40143) --> 
    optional(grums,_40161,_40139,_40143).

greetings('OK',[greetings,_40177,_40225],_40149,_40153) --> 
    okeys(_40177,_40149,_40207),
    endofline(_40225,_40207,_40153).

greetings('Hei på deg',[greetings,_40177,_40225],_40149,_40153) --> 
    hello(_40177,_40149,_40207),
    daddy(_40225,_40207,_40153).

greetings('Hei',[greetings,_40171],_40143,_40147) --> 
    greetings(_40171,_40143,_40147).

daddy([daddy,_40177,!],_40155,_40159) --> 
    w(noun(father,sin,u,n),_40177,_40155,_40159),
    !.

daddy([daddy,_40177,!],_40155,_40159) --> 
    w(noun(mother,sin,u,n),_40177,_40155,_40159),
    !.

daddy([daddy,_40175,!],_40153,_40157) --> 
    w(name(_40121,n,man),_40175,_40153,_40157),
    !.

optoken([optoken,lit(:)],_40139,_40143) --> 
    cc(:,_40139,_40143).

optoken([optoken,lit(!)],_40139,_40143) --> 
    cc(!,_40139,_40143).

optoken([optoken,lit('.')],_40139,_40143) --> 
    cc('.',_40139,_40143).

optoken([optoken,[]],_40135,_40135) --> 
    [].

greetings([greetings,lit(_40121),{}],_40175,_40179) --> 
    cc(_40121,_40175,_40179),
    {testmember(_40121,[ja,jo,joda,nei,neida])}.

greetings([greetings,_40157],_40135,_40139) --> 
    hellos(_40157,_40135,_40139).

greetings([greetings,lit(hva),lit(om)],_40149,_40153) --> 
    cc(hva,_40149,_40191),
    cc(om,_40191,_40153).

greetings([greetings,lit(nei)],_40139,_40143) --> 
    cc(nei,_40139,_40143).

greetings([greetings,lit(o),_40201,_40249],_40157,_40161) --> 
    cc(o,_40157,_40199),
    adj0(_40201,_40199,_40231),
    np0(_40123,_40125,_40249,_40231,_40161).

greetings([greetings,_40179,lit(meg)],_40157,_40161) --> 
    w(verb(say,inf,fin),_40179,_40157,_40213),
    cc(meg,_40213,_40161).

greetings([greetings,_40225,{},_40297,_40345,!],_40203,_40207) --> 
    w(noun(_40139,sin,u,n),_40225,_40203,_40259),
    {testmember(_40139,[oracle,brother,sister])},
    colon0(_40297,_40259,_40327),
    look_ahead([når],_40345,_40327,_40207),
    !.

greetings([greetings,_40227,{},_40299,_40347],_40205,_40209) --> 
    w(noun(_40149,sin,u,n),_40227,_40205,_40261),
    {testmember(_40149,[oracle,brother,sister])},
    colon0(_40299,_40261,_40329),
    not_look_ahead(w(verb(_40137,_40139,fin)),_40347,_40329,_40209).

greetings([greetings,_40241,_40299,_40357,_40415,_40463,_40521,_40569],_40219,_40223) --> 
    w(name(bustuc,n,_40155),_40241,_40219,_40275),
    not_look_ahead([som],_40299,_40275,_40333),
    not_look_ahead(w(prep(_40175)),_40357,_40333,_40391),
    colon0(_40415,_40391,_40445),
    not_look_ahead(w(verb(_40187,_40189,_40191)),_40463,_40445,_40497),
    not_look_ahead_vp(_40521,_40497,_40551),
    not_look_ahead_np(_40569,_40551,_40223).

trafikk([trafikk,lit(trafikk)],_40139,_40143) --> 
    cc(trafikk,_40139,_40143).

trafikk([trafikk,lit(t)],_40139,_40143) --> 
    cc(t,_40139,_40143).

grums0([grums0,[]],_40135,_40135) --> 
    [].

grums([grums,lit(rute),{}],_40161,_40165) --> 
    cc(rute,_40161,_40165),
    {user:value(smsflag,true)}.

grums([grums,lit('.')],_40139,_40143) --> 
    cc('.',_40139,_40143).

grums([grums,lit(?)],_40139,_40143) --> 
    cc(?,_40139,_40143).

grums([grums,lit(:),!],_40145,_40149) --> 
    cc(:,_40145,_40149),
    !.

grums([grums,lit(/),!],_40145,_40149) --> 
    cc(/,_40145,_40149),
    !.

grums([grums,lit(!),!],_40145,_40149) --> 
    cc(!,_40145,_40149),
    !.

grums([grums,lit(-),!],_40145,_40149) --> 
    cc(-,_40145,_40149),
    !.

grums([grums,lit(eksempelvis),lit(:)],_40149,_40153) --> 
    cc(eksempelvis,_40149,_40191),
    cc(:,_40191,_40153).

grums([grums,_40167,lit(at)],_40145,_40149) --> 
    redundant(_40167,_40145,_40197),
    cc(at,_40197,_40149).

grums([grums,_40215,lit(:),_40295,!],_40193,_40197) --> 
    w(noun(_40133,sin,u,n),_40215,_40193,_40249),
    cc(:,_40249,_40293),
    gmem(_40133,[error,thing,subject,example],_40295,_40293,_40197),
    !.

grums([grums,_40183,lit(om),!],_40161,_40165) --> 
    w(adj2(good,nil),_40183,_40161,_40217),
    cc(om,_40217,_40165),
    !.

grums([grums,lit(bare)],_40139,_40143) --> 
    cc(bare,_40139,_40143).

grums([grums,lit(eller)],_40139,_40143) --> 
    cc(eller,_40139,_40143).

grums([grums,lit(fyi),_40189],_40145,_40149) --> 
    cc(fyi,_40145,_40187),
    point0(_40189,_40187,_40149).

grums([grums,lit(grr)],_40139,_40143) --> 
    cc(grr,_40139,_40143).

grums([grums,lit(huff)],_40139,_40143) --> 
    cc(huff,_40139,_40143).

grums([grums,lit(igjen)],_40139,_40143) --> 
    cc(igjen,_40139,_40143).

grums([grums,lit(jo)],_40139,_40143) --> 
    cc(jo,_40139,_40143).

grums([grums,lit(og)],_40139,_40143) --> 
    cc(og,_40139,_40143).

grums([grums,lit(kort),lit(sagt)],_40149,_40153) --> 
    cc(kort,_40149,_40191),
    cc(sagt,_40191,_40153).

grums([grums,lit(men)],_40139,_40143) --> 
    cc(men,_40139,_40143).

grums([grums,lit(nei),lit(men)],_40149,_40153) --> 
    cc(nei,_40149,_40191),
    cc(men,_40191,_40153).

grums([grums,lit(nb)],_40139,_40143) --> 
    cc(nb,_40139,_40143).

grums([grums,lit(nei),_40205],_40161,_40165) --> 
    cc(nei,_40161,_40203),
    look_ahead(w(verb(_40125,_40127,_40129)),_40205,_40203,_40165).

grums([grums,lit(ja),_40205],_40161,_40165) --> 
    cc(ja,_40161,_40203),
    look_ahead(w(verb(_40125,_40127,_40129)),_40205,_40203,_40165).

grums([grums,lit(typisk)],_40139,_40143) --> 
    cc(typisk,_40139,_40143).

grums([grums,lit(uff)],_40139,_40143) --> 
    cc(uff,_40139,_40143).

grums([grums,lit(vel)],_40139,_40143) --> 
    cc(vel,_40139,_40143).

grums([grums,lit(å),_40189],_40145,_40149) --> 
    cc(å,_40145,_40187),
    not_look_ahead_vp(_40189,_40187,_40149).

grums([grums,_40173,_40231],_40151,_40155) --> 
    w(nb(1939,num),_40173,_40151,_40207),
    point0(_40231,_40207,_40155).

grums([grums,_40199,_40287,_40345],_40177,_40181) --> 
    optional([for],_40199,_40177,_40263),
    w(noun(example,sin,u,n),_40287,_40263,_40321),
    optional([:],_40345,_40321,_40181).

grums([grums,_40181,lit(:)],_40159,_40163) --> 
    w(noun(question,sin,u,n),_40181,_40159,_40215),
    cc(:,_40215,_40163).

grums([grums,lit(svar),_40197],_40153,_40157) --> 
    cc(svar,_40153,_40195),
    optional([:],_40197,_40195,_40157).

grums([grums,lit(n),lit(:)],_40149,_40153) --> 
    cc(n,_40149,_40191),
    cc(:,_40191,_40153).

grums([grums,_40183,_40241,!],_40161,_40165) --> 
    w(noun(traffic,sin,u,n),_40183,_40161,_40217),
    colon(_40241,_40217,_40165),
    !.

grums([grums,_40175,lit(tt)],_40153,_40157) --> 
    not_look_ahead([dere],_40175,_40153,_40209),
    cc(tt,_40209,_40157).

grums([grums,lit(så),_40205,!],_40161,_40165) --> 
    cc(så,_40161,_40203),
    w(adj2(funny,nil),_40205,_40203,_40165),
    !.

grums([grums,lit(så),_40189],_40145,_40149) --> 
    cc(så,_40145,_40187),
    not_look_ahead_vp(_40189,_40187,_40149).

grums([grums,lit(ja),lit(så),_40221],_40155,_40159) --> 
    cc(ja,_40155,_40197),
    cc(så,_40197,_40219),
    not_look_ahead_vp(_40221,_40219,_40159).

grums([grums,lit(nb),_40205],_40161,_40165) --> 
    cc(nb,_40161,_40203),
    one_of_lit(['.',:,!],_40205,_40203,_40165).

grums([grums,lit(obs),_40205],_40161,_40165) --> 
    cc(obs,_40161,_40203),
    one_of_lit(['.',:,!],_40205,_40203,_40165).

grums([grums,lit(unnskyld),lit(men)],_40149,_40153) --> 
    cc(unnskyld,_40149,_40191),
    cc(men,_40191,_40153).

grums([grums,lit(ok),_40205],_40161,_40165) --> 
    cc(ok,_40161,_40203),
    look_ahead(w(verb(_40125,imp,fin)),_40205,_40203,_40165).

grums([grums,lit(supert)],_40139,_40143) --> 
    cc(supert,_40139,_40143).

team([team,_40169],_40147,_40151) --> 
    w(name(team,_40117,_40119),_40169,_40147,_40151).

team([team,lit(team)],_40139,_40143) --> 
    cc(team,_40139,_40143).

hellos([hellos,_40169,_40217,_40265],_40147,_40151) --> 
    hello(_40169,_40147,_40199),
    sludder0(_40217,_40199,_40247),
    hellos0(_40265,_40247,_40151).

hellos0([hellos0,_40157],_40135,_40139) --> 
    hellos(_40157,_40135,_40139).

hellos0([hellos0,[]],_40135,_40135) --> 
    [].

adj0([adj0,_40179,!,_40247],_40157,_40161) --> 
    w(adj2(_40127,_40129),_40179,_40157,_40213),
    !,
    accept(_40247,_40213,_40161).

adj0([adj0,[]],_40135,_40135) --> 
    [].

hei([hei,lit(hei),_40189],_40145,_40149) --> 
    cc(hei,_40145,_40187),
    der0(_40189,_40187,_40149).

hei([hei,lit(hallo),_40189],_40145,_40149) --> 
    cc(hallo,_40145,_40187),
    der0(_40189,_40187,_40149).

sludder0([sludder0,_40163,!],_40141,_40145) --> 
    sludder(_40163,_40141,_40145),
    !.

sludder0([sludder0,[]],_40135,_40135) --> 
    [].

sludder([sludder,lit(alle),lit(sammen),!],_40155,_40159) --> 
    cc(alle,_40155,_40197),
    cc(sammen,_40197,_40159),
    !.

sludder([sludder,lit(der),!],_40145,_40149) --> 
    cc(der,_40145,_40149),
    !.

sludder([sludder,lit(du),_40211,!],_40167,_40171) --> 
    cc(du,_40167,_40209),
    not_look_ahead(w(verb(_40135,_40137,_40139)),_40211,_40209,_40171),
    !.

sludder([sludder,_40197,_40255,!],_40175,_40179) --> 
    w(name(tuc,n,_40131),_40197,_40175,_40231),
    not_look_ahead(w(verb(_40143,_40145,_40147)),_40255,_40231,_40179),
    !.

sludder([sludder,_40175,!],_40153,_40157) --> 
    w(name(bustuc,n,_40125),_40175,_40153,_40157),
    !.

sludder([sludder,_40175,!],_40153,_40157) --> 
    w(name(tt,n,_40125),_40175,_40153,_40157),
    !.

sludder([sludder,_40175,!],_40153,_40157) --> 
    w(name(tagore,n,_40125),_40175,_40153,_40157),
    !.

sludder([sludder,_40175,!],_40153,_40157) --> 
    w(name(tore,n,_40125),_40175,_40153,_40157),
    !.

sludder([sludder,_40177,!],_40155,_40159) --> 
    w(noun(computer,sin,u,n),_40177,_40155,_40159),
    !.

sludder([sludder,_40177,!],_40155,_40159) --> 
    w(noun(oracle,sin,_40125,n),_40177,_40155,_40159),
    !.

sludder([sludder,_40177,!],_40155,_40159) --> 
    w(noun(man,sin,u,n),_40177,_40155,_40159),
    !.

sludder([sludder,_40177,!],_40155,_40159) --> 
    w(noun(sweetheart,sin,u,n),_40177,_40155,_40159),
    !.

okeys0([okeys0,_40157],_40135,_40139) --> 
    okeys(_40157,_40135,_40139).

okeys0([okeys0,[]],_40135,_40135) --> 
    [].

okeys([okeys,lit(ok),_40217,_40305,_40393],_40173,_40177) --> 
    cc(ok,_40173,_40215),
    optional([ja],_40217,_40215,_40281),
    optional([men],_40305,_40281,_40369),
    optoken(_40393,_40369,_40177).

hello([hello,lit(bra)],_40139,_40143) --> 
    cc(bra,_40139,_40143).

hello([hello,_40157],_40135,_40139) --> 
    okeys(_40157,_40135,_40139).

hello([hello,_40173,_40221,_40309],_40151,_40155) --> 
    hei(_40173,_40151,_40203),
    optional(paadeg,_40221,_40203,_40285),
    sludder0(_40309,_40285,_40155).

hello([hello,lit(goddag)],_40139,_40143) --> 
    cc(goddag,_40139,_40143).

hello([hello,_40223,_40281,{}],_40201,_40205) --> 
    w(adj2(good,nil),_40223,_40201,_40257),
    w(noun(_40127,_40169,_40171,_40173),_40281,_40257,_40205),
    {testmember(_40127,[day,morning,evening,night,afternoon])}.

paadeg([paadeg,_40183,lit(deg),!,_40273],_40161,_40165) --> 
    prep1(on,_40183,_40161,_40217),
    cc(deg,_40217,_40261),
    !,
    accept(_40273,_40261,_40165).

paadeg([paadeg,lit(og),lit(hå),!,_40237],_40161,_40165) --> 
    cc(og,_40161,_40203),
    cc(hå,_40203,_40225),
    !,
    accept(_40237,_40225,_40165).

forhjelpen0([forhjelpen0,_40177,lit(alt),!],_40155,_40159) --> 
    prep1(for,_40177,_40155,_40211),
    cc(alt,_40211,_40159),
    !.

forhjelpen0([forhjelpen0,_40199,_40257,_40315,!],_40177,_40181) --> 
    prep1(for,_40199,_40177,_40233),
    w(noun(_40137,sin,def,n),_40257,_40233,_40291),
    np1(_40147,_40149,_40315,_40291,_40181),
    !.

forhjelpen0([forhjelpen0,_40187,_40245,!],_40165,_40169) --> 
    prep1(for,_40187,_40165,_40221),
    w(noun(_40131,sin,def,n),_40245,_40221,_40169),
    !.

forhjelpen0([forhjelpen0,_40179,_40237,!],_40157,_40161) --> 
    prep1(for,_40179,_40157,_40213),
    np1(_40127,_40129,_40237,_40213,_40161),
    !.

forhjelpen0([forhjelpen0,lit(skal),lit(du),_40233],_40167,_40171) --> 
    cc(skal,_40167,_40209),
    cc(du,_40209,_40231),
    w(verb(have,imp,fin),_40233,_40231,_40171).

forhjelpen0([forhjelpen0,[]],_40135,_40135) --> 
    [].

hadet([hadet,lit(ha),lit(de),_40221],_40155,_40159) --> 
    cc(ha,_40155,_40197),
    cc(de,_40197,_40219),
    paabadet0(_40221,_40219,_40159).

hadet([hadet,lit(ha),lit(det),_40221],_40155,_40159) --> 
    cc(ha,_40155,_40197),
    cc(det,_40197,_40219),
    paabadet0(_40221,_40219,_40159).

hadet([hadet,lit(hadet),_40189],_40145,_40149) --> 
    cc(hadet,_40145,_40187),
    paabadet0(_40189,_40187,_40149).

hadet([hadet,lit(hade),_40189],_40145,_40149) --> 
    cc(hade,_40145,_40187),
    paabadet0(_40189,_40187,_40149).

kan([kan,_40169],_40147,_40151) --> 
    w(verb(know,_40117,fin),_40169,_40147,_40151).

kan([kan,lit(kan)],_40139,_40143) --> 
    cc(kan,_40139,_40143).

paabadet0([paabadet0,_40183,lit(badet),!,_40273],_40161,_40165) --> 
    prep1(on,_40183,_40161,_40217),
    cc(badet,_40217,_40261),
    !,
    accept(_40273,_40261,_40165).

paabadet0([paabadet0,[]],_40135,_40135) --> 
    [].

quit(thanks,[quit,_40207,_40265,!],_40179,_40183) --> 
    w(adj2(good,nil),_40207,_40179,_40241),
    w(noun(trip,sin,u,n),_40265,_40241,_40183),
    !.

quit(bye,[quit,_40189,_40247],_40161,_40165) --> 
    w(verb(hear,pres,pass),_40189,_40161,_40223),
    skip_rest(_40247,_40223,_40165).

quit(bye,[quit,_40189,_40247],_40161,_40165) --> 
    w(verb(see,pres,pass),_40189,_40161,_40223),
    skip_rest(_40247,_40223,_40165).

quit(bye,[quit,_40189,_40247],_40161,_40165) --> 
    w(verb(tals,pres,pass),_40189,_40161,_40223),
    skip_rest(_40247,_40223,_40165).

quit(bye,[quit,lit(med),lit(vennlig),_40255,_40313],_40183,_40187) --> 
    cc(med,_40183,_40231),
    cc(vennlig,_40231,_40253),
    w(noun(greeting,_40147,_40149,_40151),_40255,_40253,_40289),
    skip_rest(_40313,_40289,_40187).

quit(bye,[quit,lit(vennlig),_40223,_40281],_40173,_40177) --> 
    cc(vennlig,_40173,_40221),
    w(noun(greeting,_40137,_40139,_40141),_40223,_40221,_40257),
    skip_rest(_40281,_40257,_40177).

quit(bye,[quit,_40191,_40249],_40163,_40167) --> 
    w(noun(greeting,_40127,_40129,_40131),_40191,_40163,_40225),
    skip_rest(_40249,_40225,_40167).

quit(bye,[quit,_40185],_40157,_40161) --> 
    w(noun(midnight,plu,def,n),_40185,_40157,_40161).

quit(bye,[quit,lit(jeg),lit(snakkes),_40235],_40163,_40167) --> 
    cc(jeg,_40163,_40211),
    cc(snakkes,_40211,_40233),
    skip_rest(_40235,_40233,_40167).

quit(bye,[quit,_40183],_40155,_40159) --> 
    w(verb(stop,imp,_40123),_40183,_40155,_40159).

quit(bye,[quit,lit(adjø)],_40147,_40151) --> 
    cc(adjø,_40147,_40151).

quit(bye,[quit,lit(på),lit(gjensyn)],_40157,_40161) --> 
    cc(på,_40157,_40205),
    cc(gjensyn,_40205,_40161).

quit(bye,[quit,_40171],_40143,_40147) --> 
    hadet(_40171,_40143,_40147).

quit(bye,[quit,_40177,_40225],_40149,_40153) --> 
    hadet(_40177,_40149,_40207),
    godt(_40225,_40207,_40153).

quit(bye,[quit,lit(hei),lit(da)],_40157,_40161) --> 
    cc(hei,_40157,_40205),
    cc(da,_40205,_40161).

quit(bye,[quit,lit(godnatt)],_40147,_40151) --> 
    cc(godnatt,_40147,_40151).

quit(bye,[quit,_40229,_40277,_40325,{}],_40201,_40205) --> 
    haen0(_40229,_40201,_40259),
    godt(_40277,_40259,_40307),
    w(noun(_40137,_40165,_40167,_40169),_40325,_40307,_40205),
    {testmember(_40137,[midnight,weekend,easter,summer])}.

quit(bye,[quit,lit(takk),_40237,_40295,_40353],_40187,_40191) --> 
    cc(takk,_40187,_40235),
    prep1(for,_40237,_40235,_40271),
    prep1(in,_40295,_40271,_40329),
    w(noun(day,sin,u,n),_40353,_40329,_40191).

quit(bye,[quit,_40209,_40257,_40315],_40181,_40185) --> 
    good0(_40209,_40181,_40239),
    w(noun(greeting,_40145,_40147,_40149),_40257,_40239,_40291),
    w(name(_40131,_40133,_40135),_40315,_40291,_40185).

quit(bye,[quit,_40211,_40259,_40317],_40183,_40187) --> 
    good0(_40211,_40183,_40241),
    w(noun(greeting,_40147,_40149,_40151),_40259,_40241,_40293),
    w(noun(_40131,_40133,_40135,_40137),_40317,_40293,_40187).

quit(bye,[quit,lit(far),lit(vel)],_40157,_40161) --> 
    cc(far,_40157,_40205),
    cc(vel,_40205,_40161).

quit(bye,[quit,_40229,_40317,lit(en),_40397,_40445],_40201,_40205) --> 
    optional(hello,_40229,_40201,_40293),
    w(verb(have,imp,_40165),_40317,_40293,_40351),
    cc(en,_40351,_40395),
    godt(_40397,_40395,_40427),
    w(noun(_40143,_40145,_40147,_40149),_40445,_40427,_40205).

quit(you_are_welcome,[quit,lit(på),lit(forhånd),_40241,!],_40169,_40173) --> 
    cc(på,_40169,_40217),
    cc(forhånd,_40217,_40239),
    thanks(_40241,_40239,_40173),
    !.

quit(you_are_welcome,[quit,_40193,_40251,!],_40165,_40169) --> 
    w(nb(1000,_40133),_40193,_40165,_40227),
    thanks(_40251,_40227,_40169),
    !.

quit(you_are_welcome,[quit,_40177,_40225],_40149,_40153) --> 
    thanks(_40177,_40149,_40207),
    alot(_40225,_40207,_40153).

quit(you_are_welcome,[quit,_40229,lit(å),_40309,_40367,lit(deg)],_40201,_40205) --> 
    w(adj2(nice,nil),_40229,_40201,_40263),
    cc(å,_40263,_40307),
    w(verb(speak,_40163,_40165),_40309,_40307,_40343),
    prep1(with,_40367,_40343,_40401),
    cc(deg,_40401,_40205).

quit(merry_christmas,[quit,_40181,lit(jul)],_40153,_40157) --> 
    godt(_40181,_40153,_40211),
    cc(jul,_40211,_40157).

quit(happy_new_year,[quit,_40177,_40225],_40149,_40153) --> 
    godt(_40177,_40149,_40207),
    newyear(_40225,_40207,_40153).

quit(bye,[quit,lit(hilsen),_40203],_40153,_40157) --> 
    cc(hilsen,_40153,_40201),
    skip_rest(_40203,_40201,_40157).

alot([alot,[]],_40135,_40135) --> 
    [].

alot([alot,lit(så),lit(mye)],_40149,_40153) --> 
    cc(så,_40149,_40191),
    cc(mye,_40191,_40153).

alot([alot,lit(så),lit(meget)],_40149,_40153) --> 
    cc(så,_40149,_40191),
    cc(meget,_40191,_40153).

alot([alot,lit(skal),lit(du),_40233],_40167,_40171) --> 
    cc(skal,_40167,_40209),
    cc(du,_40209,_40231),
    w(verb(have,inf,fin),_40233,_40231,_40171).

godt([godt,_40167],_40145,_40149) --> 
    w(adj2(good,nil),_40167,_40145,_40149).

godt([godt,_40169],_40147,_40151) --> 
    w(verb(go,past,part),_40169,_40147,_40151).

godt([godt,_40187,_40245],_40165,_40169) --> 
    w(adj2(good,nil),_40187,_40165,_40221),
    w(noun(day,sin,u,n),_40245,_40221,_40169).

deter0([deter0,_40169,!,_40227],_40147,_40151) --> 
    deter(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

deter0([deter0,_40169,!,_40227],_40147,_40151) --> 
    endofline(_40169,_40147,_40199),
    !,
    reject(_40227,_40199,_40151).

deter0([deter0,[]],_40135,_40135) --> 
    [].

deter([deter,lit(det),_40201,!,_40259],_40157,_40161) --> 
    cc(det,_40157,_40199),
    be(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

deter([deter,lit(dette),_40201,!,_40259],_40157,_40161) --> 
    cc(dette,_40157,_40199),
    be(_40201,_40199,_40231),
    !,
    accept(_40259,_40231,_40161).

haen0([haen0,lit(ha),lit(en),!,_40237],_40161,_40165) --> 
    cc(ha,_40161,_40203),
    cc(en,_40203,_40225),
    !,
    accept(_40237,_40225,_40165).

haen0([haen0,[]],_40135,_40135) --> 
    [].

personal('Takk',[personal,lit(velkommen),lit(til),!,_40251],_40169,_40173) --> 
    cc(velkommen,_40169,_40217),
    cc(til,_40217,_40239),
    !,
    skip_rest(_40251,_40239,_40173).

personal('Takk',[personal,lit(velkommen)],_40147,_40151) --> 
    cc(velkommen,_40147,_40151).

personal('Takk',[personal,lit(god),_40217],_40167,_40171) --> 
    cc(god,_40167,_40215),
    w(noun(health,sin,u,n),_40217,_40215,_40171).

personal('OK',[personal,lit(ps)],_40147,_40151) --> 
    cc(ps,_40147,_40151).

personal('OK',[personal,_40187,_40275,_40323],_40159,_40163) --> 
    optional(hello,_40187,_40159,_40251),
    so0(_40275,_40251,_40305),
    persok(_40323,_40305,_40163).

persok([persok,_40157],_40135,_40139) --> 
    okeys(_40157,_40135,_40139).

persok([persok,_40169],_40147,_40151) --> 
    w(verb(test,imp,fin),_40169,_40147,_40151).

persok([persok,lit(bra),_40189],_40145,_40149) --> 
    cc(bra,_40145,_40187),
    endofline(_40189,_40187,_40149).

persok([persok,lit(sorry)],_40139,_40143) --> 
    cc(sorry,_40139,_40143).

persok([persok,_40195,lit(så),_40275],_40173,_40177) --> 
    w(verb(be,imp,fin),_40195,_40173,_40229),
    cc(så,_40229,_40273),
    w(adj2(good,nil),_40275,_40273,_40177).

persok([persok,_40179,lit(det)],_40157,_40161) --> 
    w(verb(forget,imp,fin),_40179,_40157,_40213),
    cc(det,_40213,_40161).

persok([persok,_40187,_40245],_40165,_40169) --> 
    w(verb(forget,imp,fin),_40187,_40165,_40221),
    np(_40117,_40123:_40125,_40245,_40221,_40169).

persok([persok,_40191,lit(du),_40271,_40319],_40169,_40173) --> 
    w(verb(be,_40135,fin),_40191,_40169,_40225),
    cc(du,_40225,_40269),
    good(_40271,_40269,_40301),
    dadanow0(_40319,_40301,_40173).

persok([persok,lit(unnskyld)],_40139,_40143) --> 
    cc(unnskyld,_40139,_40143).

persok([persok,lit(hvordan),_40227,lit(du),lit(det),_40329],_40183,_40187) --> 
    cc(hvordan,_40183,_40225),
    w(verb(have,_40145,fin),_40227,_40225,_40261),
    cc(du,_40261,_40305),
    cc(det,_40305,_40327),
    dadanow0(_40329,_40327,_40187).

persok([persok,lit(hvordan),_40233,lit(det),_40313,_40371,_40419],_40189,_40193) --> 
    cc(hvordan,_40189,_40231),
    w(verb(stand,pres,fin),_40233,_40231,_40267),
    cc(det,_40267,_40311),
    prep1(to,_40313,_40311,_40347),
    withyou0(_40371,_40347,_40401),
    dadanow0(_40419,_40401,_40193).

persok([persok,_40217,lit(det),_40297,_40355,_40413,_40461],_40195,_40199) --> 
    w(verb(stand,pres,fin),_40217,_40195,_40251),
    cc(det,_40251,_40295),
    w(adj2(good,nil),_40297,_40295,_40331),
    prep1(to,_40355,_40331,_40389),
    withyou0(_40413,_40389,_40443),
    dadanow0(_40461,_40443,_40199).

persok([persok,_40179,_40237],_40157,_40161) --> 
    w(verb(stand,pres,fin),_40179,_40157,_40213),
    prep1(to,_40237,_40213,_40161).

persok([persok,lit(hvordan),_40209,_40257],_40165,_40169) --> 
    cc(hvordan,_40165,_40207),
    be(_40209,_40207,_40239),
    w(noun(situation,sin,def,n),_40257,_40239,_40169).

persok([persok,lit(hva),_40209,_40257],_40165,_40169) --> 
    cc(hva,_40165,_40207),
    be(_40209,_40207,_40239),
    w(noun(situation,sin,def,n),_40257,_40239,_40169).

persok([persok,_40211,lit(du),lit(det),_40313,_40371],_40189,_40193) --> 
    w(verb(have,_40141,fin),_40211,_40189,_40245),
    cc(du,_40245,_40289),
    cc(det,_40289,_40311),
    w(adj2(_40159,nil),_40313,_40311,_40347),
    dadanow0(_40371,_40347,_40193).

persok([persok,lit(jeg),_40239,lit(det),_40319,_40377,_40425,_40473],_40195,_40199) --> 
    cc(jeg,_40195,_40237),
    w(verb(have,_40157,fin),_40239,_40237,_40273),
    cc(det,_40273,_40317),
    negation0(_40167,_40319,_40317,_40353),
    so0(_40377,_40353,_40407),
    good(_40425,_40407,_40455),
    dadanow0(_40473,_40455,_40199).

persok([persok,lit(hvordan),_40223,lit(det),_40303,_40351],_40179,_40183) --> 
    cc(hvordan,_40179,_40221),
    w(verb(go,pres,fin),_40223,_40221,_40257),
    cc(det,_40257,_40301),
    withyou0(_40303,_40301,_40333),
    dadanow0(_40351,_40333,_40183).

persok([persok,_40221,lit(det),_40301,_40389,_40447,_40495],_40199,_40203) --> 
    w(verb(go,pres,fin),_40221,_40199,_40255),
    cc(det,_40255,_40299),
    optional([ikke],_40301,_40299,_40365),
    w(adj2(good,nil),_40389,_40365,_40423),
    withyou0(_40447,_40423,_40477),
    dadanow0(_40495,_40477,_40203).

persok([persok,lit(greitt)],_40139,_40143) --> 
    cc(greitt,_40139,_40143).

persok([persok,_40173,_40231],_40151,_40155) --> 
    w(adj2(good,nil),_40173,_40151,_40207),
    endofline(_40231,_40207,_40155).

thanks([thanks,_40175,_40223,_40271,_40319],_40153,_40157) --> 
    ogmen0(_40175,_40153,_40205),
    thousands0(_40223,_40205,_40253),
    takk(_40271,_40253,_40301),
    forhjelpen0(_40319,_40301,_40157).

takk([takk,_40167,lit(takk)],_40145,_40149) --> 
    hellos0(_40167,_40145,_40197),
    cc(takk,_40197,_40149).

takk([takk,_40169],_40147,_40151) --> 
    w(verb(thank,pres,fin),_40169,_40147,_40151).

takk([takk,lit(jeg),lit(vil),_40233],_40167,_40171) --> 
    cc(jeg,_40167,_40209),
    cc(vil,_40209,_40231),
    w(verb(thank,inf,_40131),_40233,_40231,_40171).

ogmen0([ogmen0,lit(og),!,_40205],_40151,_40155) --> 
    cc(og,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

ogmen0([ogmen0,lit(men),!,_40205],_40151,_40155) --> 
    cc(men,_40151,_40193),
    !,
    accept(_40205,_40193,_40155).

ogmen0([ogmen0,[]],_40135,_40135) --> 
    [].

thousands0([thousands0,_40169,!,_40227],_40147,_40151) --> 
    thousand(_40169,_40147,_40199),
    !,
    thousands0(_40227,_40199,_40151).

thousands0([thousands0,[]],_40135,_40135) --> 
    [].

thousand0([thousand0,_40169,!,_40227],_40147,_40151) --> 
    thousand(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

thousand0([thousand0,[]],_40135,_40135) --> 
    [].

thousand([thousand,_40179,!,_40247],_40157,_40161) --> 
    number(1000:_40129,_40179,_40157,_40213),
    !,
    accept(_40247,_40213,_40161).

thousand([thousand,_40157],_40135,_40139) --> 
    many1(_40157,_40135,_40139).

withyou0([withyou0,_40183,lit(_40131),!,_40273],_40161,_40165) --> 
    prep1(with,_40183,_40161,_40217),
    cc(_40131,_40217,_40261),
    !,
    accept(_40273,_40261,_40165).

withyou0([withyou0,[]],_40135,_40135) --> 
    [].

dadanow0([dadanow0,_40163,_40211],_40141,_40145) --> 
    todax(_40163,_40141,_40193),
    danow0(_40211,_40193,_40145).

dadanow0([dadanow0,_40157],_40135,_40139) --> 
    danow0(_40157,_40135,_40139).

danow0([danow0,_40187,_40245,lit(nå),!],_40165,_40169) --> 
    look_ahead([nå],_40187,_40165,_40221),
    notreachphrase(_40245,_40221,_40275),
    cc(nå,_40275,_40169),
    !.

danow0([danow0,[]],_40135,_40135) --> 
    [].

notreachphrase([notreachphrase,_40169,!,_40227],_40147,_40151) --> 
    reachphrase(_40169,_40147,_40199),
    !,
    reject(_40227,_40199,_40151).

notreachphrase([notreachphrase,[]],_40135,_40135) --> 
    [].

reachphrase([reachphrase,_40181,_40239,!],_40159,_40163) --> 
    w(verb(reach,inf,fin),_40181,_40159,_40215),
    look_ahead_np(_40239,_40215,_40163),
    !.

danow0([danow0,_40163,!],_40141,_40145) --> 
    danow(_40163,_40141,_40145),
    !.

danow0([danow0,[]],_40135,_40135) --> 
    [].

danow([danow,_40177,_40235,!],_40155,_40159) --> 
    w(adv(now),_40177,_40155,_40211),
    danow(_40235,_40211,_40159),
    !.

danow([danow,_40165],_40143,_40147) --> 
    w(adv(now),_40165,_40143,_40147).

danow([danow,lit(da),_40189],_40145,_40149) --> 
    cc(da,_40145,_40187),
    danow(_40189,_40187,_40149).

todax([todax,_40169,!,_40227],_40147,_40151) --> 
    today(_40169,_40147,_40199),
    !,
    accept(_40227,_40199,_40151).

todax([todax,_40183,lit(går),!,_40273],_40161,_40165) --> 
    prep1(in,_40183,_40161,_40217),
    cc(går,_40217,_40261),
    !,
    accept(_40273,_40261,_40165).

good0([good0,_40175,_40223,!,_40281],_40153,_40157) --> 
    so0(_40175,_40153,_40205),
    good(_40223,_40205,_40253),
    !,
    accept(_40281,_40253,_40157).

good0([good0,[]],_40135,_40135) --> 
    [].

good([good,_40167],_40145,_40149) --> 
    w(adj2(good,nil),_40167,_40145,_40149).

good([good,_40167],_40145,_40149) --> 
    w(adj2(clever,nil),_40167,_40145,_40149).

good([good,_40167],_40145,_40149) --> 
    w(adj2(fast,nil),_40167,_40145,_40149).

good([good,_40167],_40145,_40149) --> 
    w(adj2(funny,nil),_40167,_40145,_40149).

good([good,_40167],_40145,_40149) --> 
    w(adj2(honest,nil),_40167,_40145,_40149).

good([good,_40167],_40145,_40149) --> 
    w(adj2(nice,nil),_40167,_40145,_40149).

good([good,_40157],_40135,_40139) --> 
    okeys(_40157,_40135,_40139).

gmem(_40111,_40113,[gmem,{}],_40159,_40159) --> 
    {testmember(_40111,_40113)}.

panic(_40111,[panic,{}],_40151,_40151) --> 
    {write(_40111)}.

traceprint(_40111,_40113,[traceprint,{}],_40159,_40159) --> 
    {traceprint(_40111,_40113)}.

%%% optionals
optional(itrailer,[optional,_40215,!],_40187,_40191) --> 
    itrailer(_40215,_40187,_40191),
    !.

optional([kanskje],[optional,lit(kanskje),!],_40191,_40195) --> 
    cc(kanskje,_40191,_40195),
    !.

optional([at],[optional,lit(at),!],_40191,_40195) --> 
    cc(at,_40191,_40195),
    !.

optional(grums,[optional,_40215,!],_40187,_40191) --> 
    grums(_40215,_40187,_40191),
    !.

optional(grums,[optional,_40215,!],_40187,_40191) --> 
    grums(_40215,_40187,_40191),
    !.

optional([ofte],[optional,lit(ofte),!],_40191,_40195) --> 
    cc(ofte,_40191,_40195),
    !.

optional([som],[optional,lit(som),!],_40191,_40195) --> 
    cc(som,_40191,_40195),
    !.

optional([','],[optional,lit(','),!],_40191,_40195) --> 
    cc(',',_40191,_40195),
    !.

optional([at],[optional,lit(at),!],_40191,_40195) --> 
    cc(at,_40191,_40195),
    !.

optional([meget],[optional,lit(meget),!],_40191,_40195) --> 
    cc(meget,_40191,_40195),
    !.

optional([det],[optional,lit(det),!],_40191,_40195) --> 
    cc(det,_40191,_40195),
    !.

optional([å],[optional,lit(å),!],_40191,_40195) --> 
    cc(å,_40191,_40195),
    !.

optional([å],[optional,lit(å),!],_40191,_40195) --> 
    cc(å,_40191,_40195),
    !.

optional([an],[optional,lit(an),!],_40191,_40195) --> 
    cc(an,_40191,_40195),
    !.

optional([ut],[optional,lit(ut),!],_40191,_40195) --> 
    cc(ut,_40191,_40195),
    !.

optional([neste],[optional,lit(neste),!],_40191,_40195) --> 
    cc(neste,_40191,_40195),
    !.

optional([det],[optional,lit(det),!],_40191,_40195) --> 
    cc(det,_40191,_40195),
    !.

optional(itrailer,[optional,_40215,!],_40187,_40191) --> 
    itrailer(_40215,_40187,_40191),
    !.

optional(itrailer,[optional,_40215,!],_40187,_40191) --> 
    itrailer(_40215,_40187,_40191),
    !.

optional([alle],[optional,lit(alle),!],_40191,_40195) --> 
    cc(alle,_40191,_40195),
    !.

optional([at],[optional,lit(at),!],_40191,_40195) --> 
    cc(at,_40191,_40195),
    !.

optional([som],[optional,lit(som),!],_40191,_40195) --> 
    cc(som,_40191,_40195),
    !.

optional([gang],[optional,lit(gang),!],_40191,_40195) --> 
    cc(gang,_40191,_40195),
    !.

optional(much,[optional,_40215,!],_40187,_40191) --> 
    much(_40215,_40187,_40191),
    !.

optional(w(verb(be,inf,fin)),[optional,_40227,!],_40199,_40203) --> 
    w(verb(be,inf,fin),_40227,_40199,_40203),
    !.

optional(w(adj2(old,nil)),[optional,_40225,!],_40197,_40201) --> 
    w(adj2(old,nil),_40225,_40197,_40201),
    !.

optional([om],[optional,lit(om),!],_40191,_40195) --> 
    cc(om,_40191,_40195),
    !.

optional([for],[optional,lit(for),!],_40191,_40195) --> 
    cc(for,_40191,_40195),
    !.

optional([på],[optional,lit(på),!],_40191,_40195) --> 
    cc(på,_40191,_40195),
    !.

optional([om],[optional,lit(om),!],_40191,_40195) --> 
    cc(om,_40191,_40195),
    !.

optional([på],[optional,lit(på),!],_40191,_40195) --> 
    cc(på,_40191,_40195),
    !.

optional([om],[optional,lit(om),!],_40191,_40195) --> 
    cc(om,_40191,_40195),
    !.

optional([å],[optional,lit(å),!],_40191,_40195) --> 
    cc(å,_40191,_40195),
    !.

optional([på],[optional,lit(på),!],_40191,_40195) --> 
    cc(på,_40191,_40195),
    !.

optional([på],[optional,lit(på),!],_40191,_40195) --> 
    cc(på,_40191,_40195),
    !.

optional([å],[optional,lit(å),!],_40191,_40195) --> 
    cc(å,_40191,_40195),
    !.

optional([til],[optional,lit(til),!],_40191,_40195) --> 
    cc(til,_40191,_40195),
    !.

optional([da],[optional,lit(da),!],_40191,_40195) --> 
    cc(da,_40191,_40195),
    !.

optional([bare],[optional,lit(bare),!],_40191,_40195) --> 
    cc(bare,_40191,_40195),
    !.

optional(w(prep(_40159)),[optional,_40223,!],_40195,_40199) --> 
    w(prep(_40159),_40223,_40195,_40199),
    !.

optional([til],[optional,lit(til),!],_40191,_40195) --> 
    cc(til,_40191,_40195),
    !.

optional([med],[optional,lit(med),!],_40191,_40195) --> 
    cc(med,_40191,_40195),
    !.

optional([på],[optional,lit(på),!],_40191,_40195) --> 
    cc(på,_40191,_40195),
    !.

optional(w(noun(year,_40161,_40163,n)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(year,_40161,_40163,n),_40229,_40201,_40205),
    !.

optional(w(prep(in)),[optional,_40223,!],_40195,_40199) --> 
    w(prep(in),_40223,_40195,_40199),
    !.

optional(w(noun(year,sin,u,n)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(year,sin,u,n),_40229,_40201,_40205),
    !.

optional([i],[optional,lit(i),!],_40191,_40195) --> 
    cc(i,_40191,_40195),
    !.

optional([i],[optional,lit(i),!],_40191,_40195) --> 
    cc(i,_40191,_40195),
    !.

optional([i],[optional,lit(i),!],_40191,_40195) --> 
    cc(i,_40191,_40195),
    !.

optional(['.'],[optional,lit('.'),!],_40191,_40195) --> 
    cc('.',_40191,_40195),
    !.

optional(w(noun(time,sin,def,n)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(time,sin,def,n),_40229,_40201,_40205),
    !.

optional([nå],[optional,lit(nå),!],_40191,_40195) --> 
    cc(nå,_40191,_40195),
    !.

optional([denne],[optional,lit(denne),!],_40191,_40195) --> 
    cc(denne,_40191,_40195),
    !.

optional(w(noun(route,sin,u,n)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(route,sin,u,n),_40229,_40201,_40205),
    !.

optional(w(noun(route,sin,u,n)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(route,sin,u,n),_40229,_40201,_40205),
    !.

optional(w(noun(bus,sin,_40163,_40165)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(bus,sin,_40163,_40165),_40229,_40201,_40205),
    !.

optional([for],[optional,lit(for),!],_40191,_40195) --> 
    cc(for,_40191,_40195),
    !.

optional([til],[optional,lit(til),!],_40191,_40195) --> 
    cc(til,_40191,_40195),
    !.

optional([av],[optional,lit(av),!],_40191,_40195) --> 
    cc(av,_40191,_40195),
    !.

optional(w(noun(time,sin,def,n)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(time,sin,def,n),_40229,_40201,_40205),
    !.

optional(w(noun(time,sin,def,n)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(time,sin,def,n),_40229,_40201,_40205),
    !.

optional(w(noun(time,_40161,def,_40165)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(time,_40161,def,_40165),_40229,_40201,_40205),
    !.

optional(w(prep(in)),[optional,_40223,!],_40195,_40199) --> 
    w(prep(in),_40223,_40195,_40199),
    !.

optional(w(noun(time,sin,def,n)),[optional,_40229,!],_40201,_40205) --> 
    w(noun(time,sin,def,n),_40229,_40201,_40205),
    !.

optional([h],[optional,lit(h),!],_40191,_40195) --> 
    cc(h,_40191,_40195),
    !.

optional([opp],[optional,lit(opp),!],_40191,_40195) --> 
    cc(opp,_40191,_40195),
    !.

optional([om],[optional,lit(om),!],_40191,_40195) --> 
    cc(om,_40191,_40195),
    !.

optional([mye],[optional,lit(mye),!],_40191,_40195) --> 
    cc(mye,_40191,_40195),
    !.

optional([nr],[optional,lit(nr),!],_40191,_40195) --> 
    cc(nr,_40191,_40195),
    !.

optional([slik],[optional,lit(slik),!],_40191,_40195) --> 
    cc(slik,_40191,_40195),
    !.

optional([så],[optional,lit(så),!],_40191,_40195) --> 
    cc(så,_40191,_40195),
    !.

optional(be,[optional,_40215,!],_40187,_40191) --> 
    be(_40215,_40187,_40191),
    !.

optional([at],[optional,lit(at),!],_40191,_40195) --> 
    cc(at,_40191,_40195),
    !.

optional([at],[optional,lit(at),!],_40191,_40195) --> 
    cc(at,_40191,_40195),
    !.

optional([seg],[optional,lit(seg),!],_40191,_40195) --> 
    cc(seg,_40191,_40195),
    !.

optional([at],[optional,lit(at),!],_40191,_40195) --> 
    cc(at,_40191,_40195),
    !.

optional(w(adj2(great,nil)),[optional,_40225,!],_40197,_40201) --> 
    w(adj2(great,nil),_40225,_40197,_40201),
    !.

optional(w(adj2(_40159,nil)),[optional,_40225,!],_40197,_40201) --> 
    w(adj2(_40159,nil),_40225,_40197,_40201),
    !.

optional(w(adj2(_40159,nil)),[optional,_40225,!],_40197,_40201) --> 
    w(adj2(_40159,nil),_40225,_40197,_40201),
    !.

optional(w(adj2(_40159,nil)),[optional,_40225,!],_40197,_40201) --> 
    w(adj2(_40159,nil),_40225,_40197,_40201),
    !.

optional([med],[optional,lit(med),!],_40191,_40195) --> 
    cc(med,_40191,_40195),
    !.

optional(sometimes,[optional,_40215,!],_40187,_40191) --> 
    sometimes(_40215,_40187,_40191),
    !.

optional([ofte],[optional,lit(ofte),!],_40191,_40195) --> 
    cc(ofte,_40191,_40195),
    !.

optional([bare],[optional,lit(bare),!],_40191,_40195) --> 
    cc(bare,_40191,_40195),
    !.

optional(grums,[optional,_40215,!],_40187,_40191) --> 
    grums(_40215,_40187,_40191),
    !.

optional(grums,[optional,_40215,!],_40187,_40191) --> 
    grums(_40215,_40187,_40191),
    !.

optional([for],[optional,lit(for),!],_40191,_40195) --> 
    cc(for,_40191,_40195),
    !.

optional([:],[optional,lit(:),!],_40191,_40195) --> 
    cc(:,_40191,_40195),
    !.

optional([:],[optional,lit(:),!],_40191,_40195) --> 
    cc(:,_40191,_40195),
    !.

optional([ja],[optional,lit(ja),!],_40191,_40195) --> 
    cc(ja,_40191,_40195),
    !.

optional([men],[optional,lit(men),!],_40191,_40195) --> 
    cc(men,_40191,_40195),
    !.

optional(paadeg,[optional,_40215,!],_40187,_40191) --> 
    paadeg(_40215,_40187,_40191),
    !.

optional(hello,[optional,_40215,!],_40187,_40191) --> 
    hello(_40215,_40187,_40191),
    !.

optional(hello,[optional,_40215,!],_40187,_40191) --> 
    hello(_40215,_40187,_40191),
    !.

optional([ikke],[optional,lit(ikke),!],_40191,_40195) --> 
    cc(ikke,_40191,_40195),
    !.

optional(_40147,[],_40093,_40093) --> 
    [].

%%% virtuals
xnp(_40647,_40649,[xnp,_40727],_40693,_40697) --> 
    virtual(xnp(_40647,_40649),_40727,_40693,_40697).

negation(_40647,[negation,_40715],_40687,_40691) --> 
    virtual(negation(_40647),_40715,_40687,_40691).

aux1([aux1,_40701],_40679,_40683) --> 
    virtual(aux1,_40701,_40679,_40683).

adverbial1(_40647,_40649,_40651,[adverbial1,_40739],_40699,_40703) --> 
    virtual(adverbial1(_40647,_40649,_40651),_40739,_40699,_40703).

xadverbial1(_40647,_40649,_40651,[xadverbial1,_40739],_40699,_40703) --> 
    virtual(xadverbial1(_40647,_40649,_40651),_40739,_40699,_40703).

subordinate(in_order_to,_40649,_40651,[subordinate,_40739],_40699,_40703) --> 
    virtual(subordinate(in_order_to,_40649,_40651),_40739,_40699,_40703).

subordinate(_40647,_40649,_40651,[subordinate,_40739],_40699,_40703) --> 
    virtual(subordinate(_40647,_40649,_40651),_40739,_40699,_40703).

adj1(_40647,_40657:_40659,_40651,_40653,[adj1,_40757],_40711,_40715) --> 
    virtual(adj1(_40647,_40657:_40659,_40651,_40653),_40757,_40711,_40715).

someone([someone,_40701],_40679,_40683) --> 
    virtual(someone,_40701,_40679,_40683).

obviousdate1(_40647,_40649,[obviousdate1,_40727],_40693,_40697) --> 
    virtual(obviousdate1(_40647,_40649),_40727,_40693,_40697).

np_kernel(0,_40649,_40651,[np_kernel,_40739],_40699,_40703) --> 
    virtual(np_kernel(0,_40649,_40651),_40739,_40699,_40703).

xnp(_40647,_40653::_40655,[xnp,_40733],_40699,_40703) --> 
    virtual(xnp(_40647,_40653::_40655),_40733,_40699,_40703).

pp(_40647,_40649,_40651,[pp,_40739],_40699,_40703) --> 
    virtual(pp(_40647,_40649,_40651),_40739,_40699,_40703).

np(_40647,_40649,[np,_40727],_40693,_40697) --> 
    virtual(np(_40647,_40649),_40727,_40693,_40697).

prep(to,[prep,_40715],_40687,_40691) --> 
    virtual(prep(to),_40715,_40687,_40691).

prep(_40647,[prep,_40715],_40687,_40691) --> 
    virtual(prep(_40647),_40715,_40687,_40691).

noun_phrase1(_40647,_40649,[noun_phrase1,_40727],_40693,_40697) --> 
    virtual(noun_phrase1(_40647,_40649),_40727,_40693,_40697).

xadverb(_40647,_40649,[xadverb,_40727],_40693,_40697) --> 
    virtual(xadverb(_40647,_40649),_40727,_40693,_40697).

np(_40647,_40653::_40655,[np,_40733],_40699,_40703) --> 
    virtual(np(_40647,_40653::_40655),_40733,_40699,_40703).

be(_40647,[be,_40715],_40687,_40691) --> 
    virtual(be(_40647),_40715,_40687,_40691).

thereit([thereit,_40701],_40679,_40683) --> 
    virtual(thereit,_40701,_40679,_40683).

be([be,_40701],_40679,_40683) --> 
    virtual(be,_40701,_40679,_40683).

adverbial1(_40647,_40649,_40655::_40657,[adverbial1,_40745],_40705,_40709) --> 
    virtual(adverbial1(_40647,_40649,_40655::_40657),_40745,_40705,_40709).

lexv(_40647,_40649,_40651,fin,[lexv,_40751],_40705,_40709) --> 
    virtual(lexv(_40647,_40649,_40651,fin),_40751,_40705,_40709).

ap(_40647,_40649,_40651,_40653,[ap,_40751],_40705,_40709) --> 
    virtual(ap(_40647,_40649,_40651,_40653),_40751,_40705,_40709).

adj1(_40647,_40649,_40651,_40653,[adj1,_40751],_40705,_40709) --> 
    virtual(adj1(_40647,_40649,_40651,_40653),_40751,_40705,_40709).

\(state(_40653,_40655),(xnp(_40665,_40667),w(verb(be,_40683,fin)),w(adj2(_40693,nil))),[\,_40773],_40739,_40743) --> 
    virtual(state(_40653,_40655)\(xnp(_40665,_40667),w(verb(be,_40683,fin)),w(adj2(_40693,nil))),_40773,_40739,_40743).

something([something,_40701],_40679,_40683) --> 
    virtual(something,_40701,_40679,_40683).

lexv(iv,_40649,pres,fin,[lexv,_40751],_40705,_40709) --> 
    virtual(lexv(iv,_40649,pres,fin),_40751,_40705,_40709).

np1(_40647,_40649,[np1,_40727],_40693,_40697) --> 
    virtual(np1(_40647,_40649),_40727,_40693,_40697).

adverbial(_40647,_40649,_40655::_40657,[adverbial,_40745],_40705,_40709) --> 
    virtual(adverbial(_40647,_40649,_40655::_40657),_40745,_40705,_40709).

lexv(iv,_40649,_40651,fin,[lexv,_40751],_40705,_40709) --> 
    virtual(lexv(iv,_40649,_40651,fin),_40751,_40705,_40709).

the([the,_40701],_40679,_40683) --> 
    virtual(the,_40701,_40679,_40683).

nameq1(_40653:person,_40649,[nameq1,_40733],_40699,_40703) --> 
    virtual(nameq1(_40653:person,_40649),_40733,_40699,_40703).

obviousclock1(_40653:clock,_40653 isa clock,[obviousclock1,_40739],_40705,_40709) --> 
    virtual(obviousclock1(_40653:clock,_40653 isa clock),_40739,_40705,_40709).

whatbe([whatbe,_40701],_40679,_40683) --> 
    virtual(whatbe,_40701,_40679,_40683).

obviousclock1(_40647,_40649,[obviousclock1,_40727],_40693,_40697) --> 
    virtual(obviousclock1(_40647,_40649),_40727,_40693,_40697).

pronoun(_40647,[pronoun,_40715],_40687,_40691) --> 
    virtual(pronoun(_40647),_40715,_40687,_40691).

noun_phrase1(_40647,_40653::_40655,[noun_phrase1,_40733],_40699,_40703) --> 
    virtual(noun_phrase1(_40647,_40653::_40655),_40733,_40699,_40703).

npgap(_40647,[npgap,_40715],_40687,_40691) --> 
    virtual(npgap(_40647),_40715,_40687,_40691).

npgap(_40651:thing,[npgap,_40721],_40693,_40697) --> 
    virtual(npgap(_40651:thing),_40721,_40693,_40697).

noun(_40647,_40649,_40651,_40653,_40655,_40657,[noun,_40775],_40717,_40721) --> 
    virtual(noun(_40647,_40649,_40651,_40653,_40655,_40657),_40775,_40717,_40721).

lexv(tv,_40649,_40651,fin,[lexv,_40751],_40705,_40709) --> 
    virtual(lexv(tv,_40649,_40651,fin),_40751,_40705,_40709).

which([which,_40701],_40679,_40683) --> 
    virtual(which,_40701,_40679,_40683).

np1(_40647,_40653::_40655,[np1,_40733],_40699,_40703) --> 
    virtual(np1(_40647,_40653::_40655),_40733,_40699,_40703).

lexv(tv,know1,_40651,fin,[lexv,_40751],_40705,_40709) --> 
    virtual(lexv(tv,know1,_40651,fin),_40751,_40705,_40709).

do([do,_40701],_40679,_40683) --> 
    virtual(do,_40701,_40679,_40683).

xadverbial1(_40647,_40649,_40655::_40657,[xadverbial1,_40745],_40705,_40709) --> 
    virtual(xadverbial1(_40647,_40649,_40655::_40657),_40745,_40705,_40709).

prep(in,[prep,_40715],_40687,_40691) --> 
    virtual(prep(in),_40715,_40687,_40691).

adverbial1(in,_40649,_40655::_40657,[adverbial1,_40745],_40705,_40709) --> 
    virtual(adverbial1(in,_40649,_40655::_40657),_40745,_40705,_40709).

xadverbial1(in,_40649,_40655::_40657,[xadverbial1,_40745],_40705,_40709) --> 
    virtual(xadverbial1(in,_40649,_40655::_40657),_40745,_40705,_40709).

adverbial1(nil,_40649,_40655::_40657,[adverbial1,_40745],_40705,_40709) --> 
    virtual(adverbial1(nil,_40649,_40655::_40657),_40745,_40705,_40709).

prep(from,[prep,_40715],_40687,_40691) --> 
    virtual(prep(from),_40715,_40687,_40691).

who([who,_40701],_40679,_40683) --> 
    virtual(who,_40701,_40679,_40683).

a([a,_40701],_40679,_40683) --> 
    virtual(a,_40701,_40679,_40683).

noun(_40647,_40649,u,n,_40655,_40657,[noun,_40775],_40717,_40721) --> 
    virtual(noun(_40647,_40649,u,n,_40655,_40657),_40775,_40717,_40721).

that([that,_40701],_40679,_40683) --> 
    virtual(that,_40701,_40679,_40683).

xadverbial1(how,nil,_40655::_40655,[xadverbial1,_40745],_40705,_40709) --> 
    virtual(xadverbial1(how,nil,_40655::_40655),_40745,_40705,_40709).

prep(with,[prep,_40715],_40687,_40691) --> 
    virtual(prep(with),_40715,_40687,_40691).

xadverbial1(nil,_40649,_40651,[xadverbial1,_40739],_40699,_40703) --> 
    virtual(xadverbial1(nil,_40649,_40651),_40739,_40699,_40703).

the(_40647,[the,_40715],_40687,_40691) --> 
    virtual(the(_40647),_40715,_40687,_40691).

of([of,_40701],_40679,_40683) --> 
    virtual(of,_40701,_40679,_40683).

prep1(in,[prep1,_40715],_40687,_40691) --> 
    virtual(prep1(in),_40715,_40687,_40691).

number(_40647,[number,_40715],_40687,_40691) --> 
    virtual(number(_40647),_40715,_40687,_40691).

lexv(dtv,_40649,_40651,_40653,[lexv,_40751],_40705,_40709) --> 
    virtual(lexv(dtv,_40649,_40651,_40653),_40751,_40705,_40709).

negation0(_40647,[negation0,_40715],_40687,_40691) --> 
    virtual(negation0(_40647),_40715,_40687,_40691).

adverbx(_40647,_40649,_40651,[adverbx,_40739],_40699,_40703) --> 
    virtual(adverbx(_40647,_40649,_40651),_40739,_40699,_40703).

particle(_40647,[particle,_40715],_40687,_40691) --> 
    virtual(particle(_40647),_40715,_40687,_40691).

verb_mod1(_40647,_40649,_40651,_40653,_40659::_40661,[verb_mod1,_40769],_40717,_40721) --> 
    virtual(verb_mod1(_40647,_40649,_40651,_40653,_40659::_40661),_40769,_40717,_40721).

lexv(tv,_40649,pres,fin,[lexv,_40751],_40705,_40709) --> 
    virtual(lexv(tv,_40649,pres,fin),_40751,_40705,_40709).

prep1(_40647,[prep1,_40715],_40687,_40691) --> 
    virtual(prep1(_40647),_40715,_40687,_40691).

noun_phrase1(_40647,_40653:_40655,[noun_phrase1,_40733],_40699,_40703) --> 
    virtual(noun_phrase1(_40647,_40653:_40655),_40733,_40699,_40703).

lexv(_40647,know1,_40651,fin,[lexv,_40751],_40705,_40709) --> 
    virtual(lexv(_40647,know1,_40651,fin),_40751,_40705,_40709).

lexv(tv,_40649,past,fin,[lexv,_40751],_40705,_40709) --> 
    virtual(lexv(tv,_40649,past,fin),_40751,_40705,_40709).

this([this,_40701],_40679,_40683) --> 
    virtual(this,_40701,_40679,_40683).

adverbial1(_40647,_40655:_40657,_40651,[adverbial1,_40745],_40705,_40709) --> 
    virtual(adverbial1(_40647,_40655:_40657,_40651),_40745,_40705,_40709).

adverbial1(nil,_40655:coevent,_40651,[adverbial1,_40745],_40705,_40709) --> 
    virtual(adverbial1(nil,_40655:coevent,_40651),_40745,_40705,_40709).

xadverbial1(_40647,_40655:_40657,_40651,[xadverbial1,_40745],_40705,_40709) --> 
    virtual(xadverbial1(_40647,_40655:_40657,_40651),_40745,_40705,_40709).

adverb(_40647,_40649,_40651,[adverb,_40739],_40699,_40703) --> 
    virtual(adverb(_40647,_40649,_40651),_40739,_40699,_40703).

some([some,_40701],_40679,_40683) --> 
    virtual(some,_40701,_40679,_40683).

much([much,_40701],_40679,_40683) --> 
    virtual(much,_40701,_40679,_40683).

little([little,_40701],_40679,_40683) --> 
    virtual(little,_40701,_40679,_40683).

every([every,_40701],_40679,_40683) --> 
    virtual(every,_40701,_40679,_40683).

relpron(agent,[relpron,_40715],_40687,_40691) --> 
    virtual(relpron(agent),_40715,_40687,_40691).

relpron(thing,[relpron,_40715],_40687,_40691) --> 
    virtual(relpron(thing),_40715,_40687,_40691).

time1(_40647,[time1,_40715],_40687,_40691) --> 
    virtual(time1(_40647),_40715,_40687,_40691).

and1([and1,_40701],_40679,_40683) --> 
    virtual(and1,_40701,_40679,_40683).

thispron([thispron,_40701],_40679,_40683) --> 
    virtual(thispron,_40701,_40679,_40683).

clock_kernel(_40653:clock,_40653 isa clock,[clock_kernel,_40739],_40705,_40709) --> 
    virtual(clock_kernel(_40653:clock,_40653 isa clock),_40739,_40705,_40709).

nameq1(_40647,_40649,[nameq1,_40727],_40693,_40697) --> 
    virtual(nameq1(_40647,_40649),_40727,_40693,_40697).

