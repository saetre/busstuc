% Auxillary tables created datetime(2012,1,19,21,29,42)

%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

:-prolog_flag(discontiguous_warnings, off).

sentence([gpsflag:::_7245|_7242],[sentence,{},_7306,!,_7340],_7282,_7284) --> 
    {user:value(gpsflag,true)},
    origin_phrase(_7245,_7306,_7282,_7323),
    !,
    sentences(_7242,_7340,_7323,_7284).

sentence(_7240,[sentence,{},_7295],_7271,_7273) --> 
    {user:(\+value(gpsflag,true))},
    sentences(_7240,_7295,_7271,_7273).

origin_phrase([_7241|_7242],[origin_phrase,lit('('),!,_7314,{},_7353],_7284,_7286) --> 
    cc('(',_7284,_7308),
    !,
    origin_element(_7241,_7314,_7308,_7331),
    {user:set(new_origin,true)},
    origin_phrase0n(_7242,_7353,_7331,_7286).

origin_phrase([],[origin_phrase,[]],_7259,_7259) --> 
    [].

origin_phrase0n([_7241|_7242],[origin_phrase0n,_7285,!,_7319],_7271,_7273) --> 
    origin_element(_7241,_7285,_7271,_7302),
    !,
    origin_phrase0n(_7242,_7319,_7302,_7273).

origin_phrase0n([],[origin_phrase0n,lit(')')],_7261,_7263) --> 
    cc(')',_7261,_7263).

origin_element(gps_origin(_7242,_7243),[origin_element,_7288,lit(+),_7328],_7274,_7276) --> 
    gps_origin(_7242,_7288,_7274,_7305),
    cc(+,_7305,_7327),
    gps_time(_7243,_7328,_7327,_7276).

gps_origin(_7240,[gps_origin,_7283,!],_7269,_7271) --> 
    name_phrase(name,_7240:_7250,_7247,_7283,_7269,_7271),
    !.

gps_time(_7240,[gps_time,_7278],_7264,_7266) --> 
    w(nb(_7240,num),_7278,_7264,_7266).

sentence01(_7240,[sentence01,_7275],_7261,_7263) --> 
    implicitq(_7240,_7275,_7261,_7263).

sentence01(_7240,[sentence01,_7275],_7261,_7263) --> 
    sentence1(_7240,_7275,_7261,_7263).

sentences([new:::_7245],[sentences,{},_7310,_7339,!,_7368],_7286,_7288) --> 
    {user:value(queryflag,false)},
    declaration(_7245,_7310,_7286,_7327),
    terminatore(_7339,_7327,_7354),
    !,
    accept(_7368,_7354,_7288).

sentences([_7241],[sentences,{},_7315,_7339,_7368,_7412,!,_7441],_7291,_7293) --> 
    {user:value(queryflag,true)},
    greetings0(_7315,_7291,_7330),
    implicitq(_7241,_7339,_7330,_7356),
    optional(itrailer,_7368,_7356,_7400),
    terminatores(_7412,_7400,_7427),
    !,
    accept(_7441,_7427,_7293).

sentences(_7240,[sentences,_7292,{},_7331,_7355],_7278,_7280) --> 
    onesentence(_7251,_7292,_7278,_7309),
    {user:_7251\==error},
    check_stop(_7331,_7309,_7346),
    moresentences0(_7251,_7240,_7355,_7346,_7280).

moresentences0(_7240,_7241,[moresentences0,_7297,_7326,!,_7355,_7379],_7280,_7282) --> 
    onesentence(_7256,_7297,_7280,_7314),
    check_stop(_7326,_7314,_7341),
    !,
    accept(_7355,_7341,_7370),
    evenmore0(_7240,_7256,_7241,_7379,_7370,_7282).

evenmore0(_7240,error,[_7240,error],[evenmore0,!,_7297],_7272,_7274) --> 
    !,
    skip_rest(_7297,_7272,_7274).

evenmore0(_7240,[],[_7240],[evenmore0,[],!],_7270,_7270) --> 
    [],
    !.

evenmore0(_7240,_7241,[_7240|_7244],[evenmore0,_7290],_7270,_7272) --> 
    moresentences0(_7241,_7244,_7290,_7270,_7272).

onesentence([],[onesentence,_7279,!,_7308],_7265,_7267) --> 
    endofline(_7279,_7265,_7294),
    !,
    accept(_7308,_7294,_7267).

onesentence(_7240,[onesentence,_7284,_7313,!,_7342],_7270,_7272) --> 
    conf_statement(_7240,_7284,_7270,_7301),
    endofline(_7313,_7301,_7328),
    !,
    accept(_7342,_7328,_7272).

onesentence(_7240,[onesentence,_7284,_7308,_7337,_7361],_7270,_7272) --> 
    grums0(_7284,_7270,_7299),
    sentence1(_7240,_7308,_7299,_7325),
    sentence_delimiter(_7337,_7325,_7352),
    accept(_7361,_7352,_7272).

onesentence(error,[onesentence,_7273],_7259,_7261) --> 
    skip_rest(_7273,_7259,_7261).

notify([notify,_7272],_7261,_7263) --> 
    w(verb(notify,_7243,_7244),_7272,_7261,_7263).

notify([notify,_7273],_7262,_7264) --> 
    w(noun(notification,_7243,_7244,_7245),_7273,_7262,_7264).

conf_statement(confirm:::_7243,[conf_statement,_7278],_7264,_7266) --> 
    confirm(_7243,_7278,_7264,_7266).

confirm(false,[confirm,lit(jeg),_7303,lit(ikke),_7343],_7278,_7280) --> 
    cc(jeg,_7278,_7302),
    w(verb(know,pres,fin),_7303,_7302,_7320),
    cc(ikke,_7320,_7342),
    endofline(_7343,_7342,_7280).

confirm(true,[confirm,lit(ja),_7289],_7264,_7266) --> 
    cc(ja,_7264,_7288),
    of_course0(_7289,_7288,_7266).

confirm(true,[confirm,lit(jo),_7289],_7264,_7266) --> 
    cc(jo,_7264,_7288),
    of_course0(_7289,_7288,_7266).

confirm(false,[confirm,lit(nei),_7289],_7264,_7266) --> 
    cc(nei,_7264,_7288),
    of_coursenot0(_7289,_7288,_7266).

confirm(true,[confirm,_7273],_7259,_7261) --> 
    of_course(_7273,_7259,_7261).

confirm(false,[confirm,_7278,lit(ikke)],_7264,_7266) --> 
    of_course(_7278,_7264,_7293),
    cc(ikke,_7293,_7266).

sentence_delimiter([sentence_delimiter,lit(for),_7286],_7264,_7266) --> 
    cc(for,_7264,_7285),
    look_ahead([hvis],_7286,_7285,_7266).

sentence_delimiter([sentence_delimiter,lit(;)],_7257,_7259) --> 
    cc(;,_7257,_7259).

sentence_delimiter([sentence_delimiter,_7266],_7255,_7257) --> 
    terminatore(_7266,_7255,_7257).

terminatore0([terminatore0,_7272,!,_7301],_7261,_7263) --> 
    terminatore(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

terminatore0([terminatore0,[]],_7255,_7255) --> 
    [].

terminatores([terminatores,_7272,!,_7301],_7261,_7263) --> 
    terminator(_7272,_7261,_7287),
    !,
    terminatores(_7301,_7287,_7263).

terminatores([terminatores,_7275,_7299,!,_7328],_7264,_7266) --> 
    check_stop(_7275,_7264,_7290),
    endofline(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

terminatore([terminatore,_7266],_7255,_7257) --> 
    terminator1(_7266,_7255,_7257).

terminator1([terminator1,_7315,_7339,_7368,_7397,_7426,!,_7460],_7304,_7306) --> 
    terminator(_7315,_7304,_7330),
    not_look_ahead(w(nb(_7262,num)),_7339,_7330,_7356),
    not_look_ahead(w(name(_7269,_7270,month)),_7368,_7356,_7385),
    not_look_ahead(w(name(_7269,_7278,day)),_7397,_7385,_7414),
    not_look_ahead(w(name(_7269,_7286,date)),_7426,_7414,_7443),
    !,
    accept(_7460,_7443,_7306).

terminator1([terminator1,_7275,_7299,!,_7328],_7264,_7266) --> 
    check_stop_locations(_7275,_7264,_7290),
    endofline(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

look_ahead_endofline([look_ahead_endofline,_7277,!],_7266,_7268) --> 
    look_ahead_lit(['.',?,!],_7277,_7266,_7268),
    !.

look_ahead_endofline([look_ahead_endofline,_7266],_7255,_7257) --> 
    end_of_line(_7266,_7255,_7257).

endofline0([endofline0,_7272,!,_7301],_7261,_7263) --> 
    terminator(_7272,_7261,_7287),
    !,
    endofline0(_7301,_7287,_7263).

endofline0([endofline0,_7266],_7255,_7257) --> 
    end_of_line0(_7266,_7255,_7257).

endofline([endofline,_7275,_7299,!,_7328],_7264,_7266) --> 
    terminator(_7275,_7264,_7290),
    endofline(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

endofline([endofline,lit(:),_7285,!],_7263,_7265) --> 
    cc(:,_7263,_7284),
    end_of_line(_7285,_7284,_7265),
    !.

endofline([endofline,lit(+),{},_7306,!,_7335],_7274,_7276) --> 
    cc(+,_7274,_7295),
    {user:value(busflag,true)},
    endofline(_7306,_7295,_7321),
    !,
    accept(_7335,_7321,_7276).

endofline([endofline,_7266],_7255,_7257) --> 
    end_of_line(_7266,_7255,_7257).

endofline1([endofline1,lit('.')],_7257,_7259) --> 
    cc('.',_7257,_7259).

endofline1([endofline1,lit(?)],_7257,_7259) --> 
    cc(?,_7257,_7259).

endofline1([endofline1,lit(!)],_7257,_7259) --> 
    cc(!,_7257,_7259).

check_stop_locations([check_stop_locations,_7269,!],_7258,_7260) --> 
    check_stop(_7269,_7258,_7260),
    !.

assemble_stop_locations([_7244+_7245|_7242],[assemble_stop_locations,_7305,lit(+),_7345,!,_7379],_7291,_7293) --> 
    w(name(_7244,n,_7265),_7305,_7291,_7322),
    cc(+,_7322,_7344),
    w(nb(_7245,num),_7345,_7344,_7362),
    !,
    check_stop_locations(_7242,_7379,_7362,_7293).

assemble_stop_locations([],[assemble_stop_locations,_7273],_7259,_7261) --> 
    end_of_line(_7273,_7259,_7261).

sentence1(new:::_7243,[sentence1,_7326,_7350,lit(at),!,_7395,_7429],_7312,_7314) --> 
    hellos0(_7326,_7312,_7341),
    w(adj2(_7271,_7272),_7350,_7341,_7367),
    cc(at,_7367,_7389),
    !,
    clausal_object1(_7281,_7282,_7395,_7389,_7414),
    pushstack(first,(xnp(_7281,_7282),w(verb(be,pres,fin)),w(adj2(_7271,_7272))),nil,_7414,_7472),
    statreal(_7243,_7429,_7472,_7314).

sentence1(new:::_7243,[sentence1,_7301,_7325,!,_7373],_7287,_7289) --> 
    detaa(_7301,_7287,_7316),
    pushstack(first,[noen],nil,_7316,_7338),clausal_object1(_7257,_7258,_7325,_7338,_7353),
    !,
    pushstack(first,xnp(_7257,_7258),nil,_7353,_7414),
    statreal(_7243,_7373,_7414,_7289).

detaa([detaa,lit(det),lit('å')],_7262,_7264) --> 
    cc(det,_7262,_7283),
    cc('å',_7283,_7264).

detaa([detaa,lit('å')],_7257,_7259) --> 
    cc('å',_7257,_7259).

sentence1(new:::_7243,[sentence1,_7296,_7320,!,_7359],_7282,_7284) --> 
    hvorvidt(_7296,_7282,_7311),
    clausal_object1(_7257,_7258,_7320,_7311,_7339),
    !,
    pushstack(first,xnp(_7257,_7258),nil,_7339,_7400),
    statreal(_7243,_7359,_7400,_7284).

hvorvidt([hvorvidt,lit(hvorvidt)],_7257,_7259) --> 
    cc(hvorvidt,_7257,_7259).

hvorvidt([hvorvidt,lit(det),lit(at)],_7262,_7264) --> 
    cc(det,_7262,_7283),
    cc(at,_7283,_7264).

hvorvidt([hvorvidt,lit(at)],_7257,_7259) --> 
    cc(at,_7257,_7259).

sentence1(new:::_7243,[sentence1,_7289,_7313,!,_7347],_7275,_7277) --> 
    redundant(_7289,_7275,_7304),
    be_it_tf_that(_7256,_7313,_7304,_7330),
    !,
    statreal(_7243,_7347,_7330,_7277).

sentence1(new:::_7243,[sentence1,_7308,_7337,_7366],_7294,_7296) --> 
    w(verb(be,_7266,fin),_7308,_7294,_7325),
    look_ahead_lit([mye],_7337,_7325,_7354),
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_7354,_7376),
    statement(_7243,_7366,_7376,_7296).

sentence1(new:::_7243,[sentence1,_7322,_7351,lit(som),!,_7391],_7308,_7310) --> 
    w(verb(_7273,_7274,pass),_7322,_7308,_7339),
    redundant0(_7351,_7339,_7366),
    cc(som,_7366,_7385),
    !,
    pushstack(first,([noen],w(verb(_7273,_7274,fin)),[dette],[som]),nil,_7385,_7401),
    statreal(_7243,_7391,_7401,_7310).

sentence1(new:::_7243,[sentence1,_7316,_7360,_7389,_7418],_7302,_7304) --> 
    optional([kanskje],_7316,_7302,_7348),
    negation(_7263,_7360,_7348,_7377),
    not_look_ahead([alle],_7389,_7377,_7406),
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_7263)),nil,_7406,_7461),
    statreal(_7243,_7418,_7461,_7304).

sentence1(new:::_7243,[sentence1,_7404,_7433,_7462,_7491,_7525,_7554,lit('å'),_7594,!,_7628],_7390,_7392) --> 
    one_of_lit([den,det,dette,disse,slike],_7404,_7390,_7421),
    w(noun(_7295,_7296,_7297,n),_7433,_7421,_7450),
    w(verb(be,_7322,fin),_7462,_7450,_7479),
    subject(_7325,_7326,_7491,_7479,_7510),
    w(adj2(_7330,nil),_7525,_7510,_7542),
    w(prep(_7335),_7554,_7542,_7571),
    cc('å',_7571,_7593),
    w(verb(_7341,inf,fin),_7594,_7593,_7611),
    !,
    pushstack(first,(xnp(_7325,_7326),w(verb(be,_7322,fin)),w(adj2(_7330,nil)),w(prep(_7335)),['å'],w(verb(_7341,inf,fin)),w(noun(_7295,_7296,_7297,n))),nil,_7611,_7669),
    statreal(_7243,_7628,_7669,_7392).

sentence1(new:::_7243,[sentence1,_7376,_7405,_7434,_7463,_7497,_7526,!,_7560],_7362,_7364) --> 
    one_of_lit([den,det,dette,disse,slike],_7376,_7362,_7393),
    w(noun(_7283,_7284,_7285,n),_7405,_7393,_7422),
    w(verb(be,_7310,fin),_7434,_7422,_7451),
    subject(_7313,_7314,_7463,_7451,_7482),
    w(adj2(_7318,nil),_7497,_7482,_7514),
    w(prep(_7323),_7526,_7514,_7543),
    !,
    pushstack(free,(xnp(_7313,_7314),w(verb(be,_7310,fin)),w(adj2(_7318,nil)),w(prep(_7323)),w(noun(_7283,_7284,_7285,n))),nil,_7543,_7601),
    statreal(_7243,_7560,_7601,_7364).

sentence1(new:::_7243,[sentence1,_7380,_7409,_7438,_7467,_7501,_7530,!,_7564],_7366,_7368) --> 
    one_of_lit([den,det,dette,disse,slike],_7380,_7366,_7397),
    w(noun(_7283,_7284,_7285,n),_7409,_7397,_7426),
    w(verb(_7309,_7310,fin),_7438,_7426,_7455),
    subject(_7313,_7314,_7467,_7455,_7486),
    w(noun(_7318,sin,u,n),_7501,_7486,_7518),
    w(prep(_7325),_7530,_7518,_7547),
    !,
    pushstack(first,(xnp(_7313,_7314),w(verb(_7309,_7310,fin)),w(noun(_7318,sin,u,n)),w(prep(_7325)),w(noun(_7283,_7284,_7285,n))),nil,_7547,_7605),
    statreal(_7243,_7564,_7605,_7368).

sentence1(new:::_7243,[sentence1,_7360,_7389,_7418,{},_7457,!,_7496],_7346,_7348) --> 
    one_of_lit([den,det,dette,disse,slike],_7360,_7346,_7377),
    w(noun(_7274,_7275,_7276,n),_7389,_7377,_7406),
    w(verb(_7300,_7301,fin),_7418,_7406,_7435),
    {user:(\+testmember(_7300,[have,get]))},
    subject(_7315,_7316,_7457,_7435,_7476),
    !,
    pushstack(first,(xnp(_7315,_7316),w(verb(_7300,_7301,fin)),w(noun(_7274,_7275,_7276,n))),nil,_7476,_7537),
    statreal(_7243,_7496,_7537,_7348).

sentence1(new:::_7243,[sentence1,lit(hvorvidt),_7340,!,lit(kan),_7390,!,_7424],_7315,_7317) --> 
    cc(hvorvidt,_7315,_7339),
    clausal_object1(_7272,_7273,_7340,_7339,_7359),
    !,
    cc(kan,_7359,_7389),
    w(verb(_7284,_7285,pass),_7390,_7389,_7407),
    !,
    pushstack(first,([dere],w(verb(_7284,_7285,fin)),xnp(_7272,_7273)),nil,_7407,_7465),
    statreal(_7243,_7424,_7465,_7317).

sentence1(new:::_7243,[sentence1,_7322,_7351,_7385,!,_7419],_7308,_7310) --> 
    w(verb(_7265,_7271,_7272),_7322,_7308,_7339),
    gmem(_7265,[talk,speak],_7351,_7339,_7370),
    look_ahead(w(prep(_7285)),_7385,_7370,_7402),
    !,
    pushstack(first,([du],w(verb(_7265,pres))),nil,_7402,_7429),
    statreal(_7243,_7419,_7429,_7310).

sentence1(new:::_7243,[sentence1,_7295,_7319,!,_7348],_7281,_7283) --> 
    aux1(_7295,_7281,_7310),
    not_look_ahead_np(_7319,_7310,_7334),
    !,
    pushstack(first,([jeg],aux1),nil,_7334,_7391),
    statreal(_7243,_7348,_7391,_7283).

sentence1(new:::_7243,[sentence1,_7304,!,_7338],_7290,_7292) --> 
    w(verb(_7259,past,part),_7304,_7290,_7321),
    !,
    pushstack(first,([jeg],w(verb(_7259,past,fin))),nil,_7321,_7348),
    statreal(_7243,_7338,_7348,_7292).

sentence1(new:::_7243,[sentence1,_7304,!,_7338],_7290,_7292) --> 
    w(verb(_7259,past,part),_7304,_7290,_7321),
    !,
    pushstack(first,([jeg],w(verb(_7259,past,fin))),nil,_7321,_7348),
    statreal(_7243,_7338,_7348,_7292).

sentence1(new:::_7243,[sentence1,lit(har),_7330,_7359,!,_7393],_7305,_7307) --> 
    cc(har,_7305,_7329),
    negation0(_7266,_7330,_7329,_7347),
    w(verb(_7274,past,part),_7359,_7347,_7376),
    !,
    pushstack(first,([jeg],w(verb(_7274,past,fin)),negation(_7266)),nil,_7376,_7433),
    statreal(_7243,_7393,_7433,_7307).

sentence1(new:::_7243,[sentence1,_7342,_7371,_7400,_7434,_7458,_7487,!,_7521],_7328,_7330) --> 
    not_look_ahead(['så'],_7342,_7328,_7359),
    w(verb(_7274,pres,fin),_7371,_7359,_7388),
    gmem(_7274,[go,think],_7400,_7388,_7419),
    not_look_ahead_np(_7434,_7419,_7449),
    not_look_ahead([ikke],_7458,_7449,_7475),
    not_look_ahead_lit([jeg,meg,du],_7487,_7475,_7504),
    !,
    pushstack(first,([jeg],w(verb(_7274,pres,fin))),nil,_7504,_7531),
    statreal(_7243,_7521,_7531,_7330).

sentence1(new:::_7243,[sentence1,_7376,_7405,_7434,_7468,_7502,_7531,_7560,!,_7594],_7362,_7364) --> 
    not_look_ahead(['så'],_7376,_7362,_7393),
    w(verb(_7277,_7288,fin),_7405,_7393,_7422),
    gmem(_7288,[pres],_7434,_7422,_7453),
    gmem(_7277,[arrive,calculate,discover,give,hope,pass,run,send,start,take,think,try,wait],_7468,_7453,_7487),
    particlev1(_7277,_7502,_7487,_7519),
    not_look_ahead([ikke],_7531,_7519,_7548),
    not_look_ahead_lit([jeg,meg,du,vi],_7560,_7548,_7577),
    !,
    pushstack(first,([jeg],w(verb(_7277,pres,fin))),nil,_7577,_7604),
    statreal(_7243,_7594,_7604,_7364).

sentence1(new:::_7243,[sentence1,_7368,_7397,_7426,_7460,_7494,_7523,_7552,!,_7586],_7354,_7356) --> 
    not_look_ahead(['så'],_7368,_7354,_7385),
    w(verb(_7277,_7288,fin),_7397,_7385,_7414),
    gmem(_7288,[imp,inf],_7426,_7414,_7445),
    gmem(_7277,[arrive,discover,pass,run,send,start,take,try],_7460,_7445,_7479),
    reflexiv0(_7277,_7494,_7479,_7511),
    not_look_ahead([ikke],_7523,_7511,_7540),
    not_look_ahead_lit([jeg,meg,du,vi],_7552,_7540,_7569),
    !,
    pushstack(first,([jeg],w(verb(_7277,pres,fin))),nil,_7569,_7596),
    statreal(_7243,_7586,_7596,_7356).

sentence1(new:::_7243,[sentence1,_7358,_7387,{},_7426,_7455,_7484,_7508,!,_7557],_7344,_7346) --> 
    not_look_ahead(['så'],_7358,_7344,_7375),
    w(verb(_7286,pres,fin),_7387,_7375,_7404),
    {user:testmember(_7286,[believe,calculate,think,see,know])},
    not_look_ahead([det],_7426,_7404,_7443),
    not_look_ahead([du],_7455,_7443,_7472),
    redundant0(_7484,_7472,_7499),
    optional([at],_7508,_7499,_7540),
    !,
    pushstack(first,([jeg],w(verb(_7286,pres,fin)),[at]),nil,_7540,_7567),
    statreal(_7243,_7557,_7567,_7346).

sentence1(new:::_7243,[sentence1,_7327,_7356,_7385,lit(jeg),_7420,!,_7449],_7313,_7315) --> 
    not_look_ahead(['så'],_7327,_7313,_7344),
    w(verb(_7280,_7281,fin),_7356,_7344,_7373),
    redundant0(_7385,_7373,_7400),
    cc(jeg,_7400,_7419),
    aux1(_7420,_7419,_7435),
    !,
    pushstack(first,([jeg],w(verb(_7280,pres,fin)),['å']),nil,_7435,_7459),
    statement(_7243,_7449,_7459,_7315).

sentence1(new:::_7243,[sentence1,_7320,_7344,_7368,_7397,!,_7431],_7306,_7308) --> 
    aux1(_7320,_7306,_7335),
    redundants0(_7344,_7335,_7359),
    negation0(_7269,_7368,_7359,_7385),
    w(verb(_7275,inf,fin),_7397,_7385,_7414),
    !,
    pushstack(first,([jeg],w(verb(_7275,pres,fin)),negation(_7269)),nil,_7414,_7471),
    statement(_7243,_7431,_7471,_7308).

sentence1(_7240,[sentence1,_7275],_7261,_7263) --> 
    command(_7240,_7275,_7261,_7263).

sentence1(_7240,[sentence1,_7281,_7305,_7334],_7267,_7269) --> 
    greetings0(_7281,_7267,_7296),
    question(_7240,_7305,_7296,_7322),
    qtrailer0(_7334,_7322,_7269).

sentence1(modifier(_7252):::_7256 isa clock and srel/nil/time/_7256/_7252 and event/real/_7252,[sentence1,{},_7345,_7374,{},!,_7413],_7321,_7323) --> 
    {user:value(dialog,1)},
    item(_7294,_7345,_7321,_7362),
    endofline(_7374,_7362,_7389),
    {user:_7294=(_7256 isa clock)},
    !,
    accept(_7413,_7389,_7323).

sentence1(item:::_7243,[sentence1,{},_7305,_7334,!,_7363],_7281,_7283) --> 
    {user:value(dialog,1)},
    item(_7243,_7305,_7281,_7322),
    endofline(_7334,_7322,_7349),
    !,
    accept(_7363,_7349,_7283).

sentence1(item:::_7245 isa clock,[sentence1,{},lit('nå'),_7329,!,_7358,{}],_7294,_7296) --> 
    {user:value(dialog,1)},
    cc('nå',_7294,_7328),
    terminator1(_7329,_7328,_7344),
    !,
    accept(_7358,_7344,_7296),
    {user:timenow(_7245)}.

sentence1(item:::_7243,[sentence1,_7306,{},_7370,!,_7399],_7292,_7294) --> 
    noun(_7257,_7258,_7259,n,it:_7265,_7243,_7306,_7292,_7333),
    {user:value(dialog,1)},
    endofline(_7370,_7333,_7385),
    !,
    accept(_7399,_7385,_7294).

sentence1(item:::it isa _7246,[sentence1,{},_7316,_7340,!,_7369,{}],_7292,_7294) --> 
    {user:value(dialog,1)},
    today(_7316,_7292,_7331),
    terminator1(_7340,_7331,_7355),
    !,
    accept(_7369,_7355,_7294),
    {user:today(_7246)}.

sentence1(new:::_7243,[sentence1,lit(ble),_7329,!,_7363],_7304,_7306) --> 
    cc(ble,_7304,_7328),
    look_ahead(w(adj2(_7265,nil)),_7329,_7328,_7346),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),w(adj2(_7265,nil))),nil,_7346,_7373),
    statement(_7243,_7363,_7373,_7306).

sentence1(new:::_7243,[sentence1,_7338,_7367,_7391,{},!,_7435,_7459],_7324,_7326) --> 
    w(verb(be,_7279,_7280),_7338,_7324,_7355),
    now0(_7367,_7355,_7382),
    w(prep(_7284),_7391,_7382,_7408),
    {user:testmember(_7284,[in,on,at])},
    !,
    accept(_7435,_7408,_7450),
    pushstack(first,([jeg],w(verb(be,pres,fin)),w(prep(on))),nil,_7450,_7469),
    statement(_7243,_7459,_7469,_7326).

sentence1(new:::_7243,[sentence1,_7323,_7347,{},_7386,_7410],_7309,_7311) --> 
    has(_7323,_7309,_7338),
    w(verb(_7265,past,part),_7347,_7338,_7364),
    {user:testmember(_7265,[send,get,receive,lay])},
    now0(_7386,_7364,_7401),
    pushstack(first,([jeg],w(verb(_7265,past,fin))),nil,_7401,_7420),
    statement(_7243,_7410,_7420,_7311).

sentence1(new:::_7243,[sentence1,_7322,{},_7361,_7385],_7308,_7310) --> 
    w(verb(_7262,_7269,fin),_7322,_7308,_7339),
    {user:testmember(_7262,[send,get,receive,lay,check])},
    now0(_7361,_7339,_7376),
    pushstack(first,([jeg],w(verb(_7262,pres,fin))),nil,_7376,_7395),
    statement(_7243,_7385,_7395,_7310).

sentence1(new:::_7243,[sentence1,_7284,_7308,_7337],_7270,_7272) --> 
    greetings0(_7284,_7270,_7299),
    statement(_7243,_7308,_7299,_7325),
    dtrailer0(_7337,_7325,_7272).

sentence1(item:::_7243,[sentence1,_7287,_7316,!,_7345],_7273,_7275) --> 
    item(_7243,_7287,_7273,_7304),
    terminator1(_7316,_7304,_7331),
    !,
    accept(_7345,_7331,_7275).

item(_7242 isa clock,[item,{},_7307,{},_7346],_7283,_7285) --> 
    {user:value(dialog,1)},
    time12(_7242,_7307,_7283,_7324),
    {user:_7242\==now},
    endofline(_7346,_7324,_7285).

item(_7240,[item,{},_7297,_7331],_7273,_7275) --> 
    {user:value(dialog,1)},
    obviousdate1(_7253,_7240,_7297,_7273,_7316),
    endofline(_7331,_7316,_7275).

item(_7240,[item,_7277],_7263,_7265) --> 
    namep(_7242,_7243,_7240,_7277,_7263,_7265).

command(_7240,[command,lit(vil),!,_7297],_7267,_7269) --> 
    cc(vil,_7267,_7291),
    !,
    reject(_7297,_7291,_7269).

command(_7240,[command,lit(skal),!,_7297],_7267,_7269) --> 
    cc(skal,_7267,_7291),
    !,
    reject(_7297,_7291,_7269).

command(doit:::_7243,[command,lit(du),lit('må'),_7343,_7372,!,_7406],_7307,_7309) --> 
    cc(du,_7307,_7331),
    cc('må',_7331,_7342),
    not_look_ahead([ikke],_7343,_7342,_7360),
    w(verb(_7268,inf,fin),_7372,_7360,_7389),
    !,
    pushstack(first,([du],w(verb(_7268,pres,fin))),nil,_7389,_7416),
    statreal(_7243,_7406,_7416,_7309).

command(doit:::quit(_7245),[command,_7289,_7313,_7337,_7366],_7275,_7277) --> 
    grums0(_7289,_7275,_7304),
    okeys0(_7313,_7304,_7328),
    quit(_7245,_7337,_7328,_7354),
    skip_rest(_7366,_7354,_7277).

command(doit:::reply(_7245),[command,_7286,_7315,_7339],_7272,_7274) --> 
    personal(_7245,_7286,_7272,_7303),
    dtrailer0(_7315,_7303,_7330),
    endofline(_7339,_7330,_7274).

command(doit:::replyq('Hei'),[command,_7281,!],_7267,_7269) --> 
    hellos(_7281,_7267,_7269),
    !.

command(new:::_7243,[command,_7316,_7345,lit(ut),_7385,_7419,!,_7448],_7302,_7304) --> 
    w(verb(_7268,pres,fin),_7316,_7302,_7333),
    not_look_ahead([du],_7345,_7333,_7362),
    cc(ut,_7362,_7384),
    gmem(_7268,[see,look],_7385,_7384,_7404),
    tilat(_7419,_7404,_7434),
    !,
    substateme1(real,_7243,_7448,_7434,_7304).

tilat([tilat,lit(til),lit(at),!],_7265,_7267) --> 
    cc(til,_7265,_7286),
    cc(at,_7286,_7267),
    !.

tilat([tilat,lit(som),lit(om),!],_7265,_7267) --> 
    cc(som,_7265,_7286),
    cc(om,_7286,_7267),
    !.

tilat([tilat,lit(som)],_7257,_7259) --> 
    cc(som,_7257,_7259).

command(new:::_7243,[command,_7331,_7360,_7389,!,_7428],_7317,_7319) --> 
    w(verb(_7265,pres,fin),_7331,_7317,_7348),
    not_look_ahead([du],_7360,_7348,_7377),
    gmem(_7265,[expect,miss,need,get,receive,see,understand],_7389,_7377,_7408),
    !,
    pushstack(first,([jeg],w(verb(_7265,pres,fin))),nil,_7408,_7438),
    statreal(_7243,_7428,_7438,_7319).

command(new:::_7243,[command,_7367,_7396,_7425,{},_7464,{},!,_7508],_7353,_7355) --> 
    not_look_ahead(['nå'],_7367,_7353,_7384),
    not_look_ahead(w(verb(come,imp,fin)),_7396,_7384,_7413),
    w(verb(_7274,_7293,fin),_7425,_7413,_7442),
    {user:testmember(_7274,[go,take,run,arrive,leave,leave2,depart,start,pass])},
    not_look_ahead([meg],_7464,_7442,_7481),
    {user:testmember(_7293,[imp,inf])},
    !,
    pushstack(first,([jeg],w(verb(_7274,pres,fin))),nil,_7481,_7518),
    statreal(_7243,_7508,_7518,_7355).

command(new:::_7243,[command,_7332,_7361,{},_7400,lit(jeg),_7445,!,_7479],_7318,_7320) --> 
    w(verb(_7273,pres,fin),_7332,_7318,_7349),
    not_look_ahead([du],_7361,_7349,_7378),
    {user:testmember(_7273,[believe])},
    that0(_7273,that,_7400,_7378,_7419),
    cc(jeg,_7419,_7444),
    not_look_ahead(w(prep(_7297)),_7445,_7444,_7462),
    !,
    pushstack(first,[jeg],nil,_7462,_7489),
    statreal(_7243,_7479,_7489,_7320).

command(new:::_7243,[command,_7319,_7348,_7382,!,_7411],_7305,_7307) --> 
    w(verb(_7265,pres,fin),_7319,_7305,_7336),
    gmem(_7265,[arrive,leave2,depart],_7348,_7336,_7367),
    look_ahead_place(_7382,_7367,_7397),
    !,
    pushstack(first,([jeg],w(verb(_7265,pres,fin))),nil,_7397,_7421),
    statreal(_7243,_7411,_7421,_7307).

command(doit:::_7243,[command,_7333,_7377,_7401,_7430,{},_7469,!,_7498],_7319,_7321) --> 
    optional(grums,_7333,_7319,_7365),
    please0(_7377,_7365,_7392),
    negation0(_7275,_7401,_7392,_7418),
    w(verb(_7283,imp,fin),_7430,_7418,_7447),
    {user:verbtype(_7283,tv)},
    look_ahead_np(_7469,_7447,_7484),
    !,
    pushstack(first,([du],w(verb(_7283,pres,fin)),negation(_7275)),nil,_7484,_7538),
    statreal(_7243,_7498,_7538,_7321).

command(doit:::_7243,[command,_7328,_7372,_7396,_7425,_7454,!,_7493],_7314,_7316) --> 
    optional(grums,_7328,_7314,_7360),
    please0(_7372,_7360,_7387),
    negation0(_7272,_7396,_7387,_7413),
    w(verb(_7280,imp,fin),_7425,_7413,_7442),
    particlev0(_7280,_7285,_7454,_7442,_7473),
    !,
    pushstack(first,([du],w(verb(_7285,pres,fin)),negation(_7272)),nil,_7473,_7533),
    statreal(_7243,_7493,_7533,_7316).

command(doit:::replyq(?),[command,_7278],_7264,_7266) --> 
    end_of_line(_7278,_7264,_7266).

imp_phrase(_7240,[imp_phrase,_7295,lit(oss),_7350,!],_7281,_7283) --> 
    lexv(_7251,let,imp,fin,_7295,_7281,_7318),
    cc(oss,_7318,_7349),
    w(verb(_7240,inf,fin),_7350,_7349,_7283),
    !.

imp_phrase(let,[imp_phrase,_7284,!,_7333],_7270,_7272) --> 
    lexv(rv,let,imp,fin,_7284,_7270,_7307),
    !,
    accept(_7333,_7307,_7272).

imp_phrase(list,[imp_phrase,_7287,_7311,!,_7360],_7273,_7275) --> 
    faa(_7287,_7273,_7302),
    lexv(_7251,see,imp,fin,_7311,_7302,_7334),
    !,
    accept(_7360,_7334,_7275).

imp_phrase(wait,[imp_phrase,_7282,!],_7268,_7270) --> 
    w(verb(wait,imp,fin),_7282,_7268,_7270),
    !.

imp_phrase(_7240,[imp_phrase,_7310,_7339,_7363,{},{}],_7296,_7298) --> 
    not_look_ahead(['må'],_7310,_7296,_7327),
    comeand0(_7339,_7327,_7354),
    lexv(_7269,_7240,imp,fin,_7363,_7354,_7298),
    {user:_7269\==rv},
    {user:(\+testmember(_7240,[have,expect]))}.

imp_phrase(_7240,[imp_phrase,_7309,_7338,_7362,{},{},_7426],_7295,_7297) --> 
    not_look_ahead(['må'],_7309,_7295,_7326),
    comeand0(_7338,_7326,_7353),
    lexv(rv,_7240,imp,fin,_7362,_7353,_7385),
    {user:_7240\==be},
    {user:_7240\==wonder},
    reflexiv0(_7240,_7426,_7385,_7297).

imp_phrase(_7240,[imp_phrase,_7310,_7339,_7363,{},{}],_7296,_7298) --> 
    not_look_ahead(['må'],_7310,_7296,_7327),
    comeand0(_7339,_7327,_7354),
    lexv(_7263,_7240,inf,fin,_7363,_7354,_7298),
    {user:testmember(_7240,[list,show,make])},
    {user:_7240\==be}.

comeand0([comeand0,_7280,lit('å'),!],_7269,_7271) --> 
    w(verb(come,imp,fin),_7280,_7269,_7297),
    cc('å',_7297,_7271),
    !.

comeand0([comeand0,[]],_7255,_7255) --> 
    [].

declaration(_7242 isa self,[declaration,_7287,_7311,!,_7340],_7273,_7275) --> 
    i(_7287,_7273,_7302),
    be(_7311,_7302,_7326),
    !,
    newatomid(_7242,_7340,_7326,_7275).

declaration(_7240,[declaration,_7294,_7323,_7347,!,_7376],_7280,_7282) --> 
    newatom(_7258,_7294,_7280,_7311),
    be(_7323,_7311,_7338),
    a(_7347,_7338,_7362),
    !,
    noun(_7254,sin,u,n,_7258,_7240,_7376,_7362,_7282).

statement(_7240,[statement,lit(det),_7338,lit(at),_7378,_7407,_7446,!,_7475,[],_7546],_7313,_7315) --> 
    cc(det,_7313,_7337),
    be_truefalse(_7273,_7338,_7337,_7355),
    cc(at,_7355,_7377),
    look_ahead_lit(['før',etter,'når'],_7378,_7377,_7395),
    adverbial3(_7285,_7286,_7287,_7407,_7395,_7428),
    comma0(_7446,_7428,_7461),
    !,
    accept(_7475,_7461,_7490),
    pushstack(free,adverbial1(_7285,_7286,_7287),nil,_7490,_7545),[],
    substatement1(_7240,_7546,_7545,_7315).

statement(_7240,[statement,_7313,_7342,_7381,!,_7410],_7299,_7301) --> 
    look_ahead_lit([hvis,om,selvom,da],_7313,_7299,_7330),
    adverbial3(_7260,_7261,_7262,_7342,_7330,_7363),
    soredundant(_7381,_7363,_7396),
    !,
    lock(last,_7396,_7460),
    pushstack(last,(['så'],xadverbial1(_7260,_7261,_7262)),nil,_7460,_7466),
    substatement1(_7240,_7410,_7466,_7455),
    unlock(_7455,_7301).

statement(_7240,[statement,_7337,_7366,_7405,_7434,lit(det),!,_7479,_7503],_7323,_7325) --> 
    look_ahead([hvis],_7337,_7323,_7354),
    adverbial3(_7272,_7273,_7274,_7366,_7354,_7387),
    not_look_ahead(['så'],_7405,_7387,_7422),
    w(verb(_7290,_7291,fin),_7434,_7422,_7451),
    cc(det,_7451,_7473),
    !,
    accept(_7479,_7473,_7494),
    lock(last,_7494,_7552),
    pushstack(last,([det],w(verb(_7290,_7291,fin)),xadverbial1(_7272,_7273,_7274)),nil,_7552,_7558),
    substatement1(_7240,_7503,_7558,_7547),
    unlock(_7547,_7325).

statement(_7240,[statement,_7335,_7364,_7403,_7432,lit(det),_7467,!,_7501,_7525],_7321,_7323) --> 
    look_ahead([hvis],_7335,_7321,_7352),
    adverbial3(_7278,_7279,_7280,_7364,_7352,_7385),
    not_look_ahead(['så'],_7403,_7385,_7420),
    aux1(_7432,_7420,_7447),
    cc(det,_7447,_7466),
    negation0(_7296,_7467,_7466,_7484),
    !,
    accept(_7501,_7484,_7516),
    lock(last,_7516,_7632),
    pushstack(last,([det],aux1,negation(_7296),xadverbial1(_7278,_7279,_7280)),nil,_7632,_7638),
    substatement1(_7240,_7525,_7638,_7627),
    unlock(_7627,_7323).

statement(_7240,[statement,_7340,_7369,_7408,_7437,_7461,_7495,_7519,!,_7553,_7577],_7326,_7328) --> 
    look_ahead([hvis],_7340,_7326,_7357),
    adverbial3(_7281,_7282,_7283,_7369,_7357,_7390),
    not_look_ahead(['så'],_7408,_7390,_7425),
    aux1(_7437,_7425,_7452),
    subject(_7297,_7298,_7461,_7452,_7480),
    redundant0(_7495,_7480,_7510),
    negation0(_7300,_7519,_7510,_7536),
    !,
    accept(_7553,_7536,_7568),
    lock(last,_7568,_7715),
    pushstack(last,(xnp(_7297,_7298),aux1,negation(_7300),xadverbial1(_7281,_7282,_7283)),nil,_7715,_7721),
    substatement1(_7240,_7577,_7721,_7710),
    unlock(_7710,_7328).

statement(_7240,[statement,_7342,_7371,_7410,_7439,!,_7473,!,_7512,_7536],_7328,_7330) --> 
    look_ahead([hvis],_7342,_7328,_7359),
    adverbial3(_7275,_7276,_7277,_7371,_7359,_7392),
    not_look_ahead(['så'],_7410,_7392,_7427),
    w(verb(_7293,_7294,fin),_7439,_7427,_7456),
    !,
    subject(_7297,_7298,_7473,_7456,_7492),
    !,
    accept(_7512,_7492,_7527),
    lock(last,_7527,_7616),
    pushstack(last,(xnp(_7297,_7298),w(verb(_7293,_7294,fin)),xadverbial1(_7275,_7276,_7277)),nil,_7616,_7622),
    substatement1(_7240,_7536,_7622,_7611),
    unlock(_7611,_7330).

statement(_7240,[statement,_7312,_7341,_7380,!,_7409,[],_7479],_7298,_7300) --> 
    look_ahead_lit(['før',etter,'når'],_7312,_7298,_7329),
    adverbial3(_7270,_7271,_7272,_7341,_7329,_7362),
    comma0(_7380,_7362,_7395),
    !,
    accept(_7409,_7395,_7424),
    pushstack(free,adverbial1(_7270,_7271,_7272),nil,_7424,_7478),[],
    substatement1(_7240,_7479,_7478,_7300).

statement(_7240,[statement,_7276],_7262,_7264) --> 
    statemens(real,_7240,_7276,_7262,_7264).

substatement1(_7240,[substatement1,_7328,_7352,_7381,_7425,_7459,_7503,!,_7542],_7314,_7316) --> 
    dether(_7328,_7314,_7343),
    w(verb(be,_7275,fin),_7352,_7343,_7369),
    optional([ofte],_7381,_7369,_7413),
    np0_accept(_7269,_7270,_7425,_7413,_7444),
    optional([som],_7459,_7444,_7491),
    subject(_7289,_7290,_7503,_7491,_7522),
    !,
    pushstack(free,(xnp(_7289,_7290),xnp(_7269,_7270)),nil,_7522,_7614),
    statreal(_7240,_7542,_7614,_7316).

dether([dether,lit(det)],_7257,_7259) --> 
    cc(det,_7257,_7259).

dether([dether,lit(det),lit(her)],_7262,_7264) --> 
    cc(det,_7262,_7283),
    cc(her,_7283,_7264).

dether([dether,lit(dette)],_7257,_7259) --> 
    cc(dette,_7257,_7259).

substatement1(_7240,[substatement1,_7276],_7262,_7264) --> 
    statemen1(real,_7240,_7276,_7262,_7264).

statemens(_7240,_7241,[statemens,_7289,_7323],_7272,_7274) --> 
    statemen1(_7240,_7247,_7289,_7272,_7308),
    statemens0(_7240,_7247,_7241,_7323,_7308,_7274).

statemens0(_7240,_7241,_7241 and _7245,[statemens0,_7305,_7329,!,_7358],_7285,_7287) --> 
    stm_conjunction(_7305,_7285,_7320),
    aux1(_7329,_7320,_7344),
    !,
    pushstack(first,[jeg],nil,_7344,_7368),
    statemens(_7240,_7245,_7358,_7368,_7287).

statemens0(_7240,_7241,_7241 and _7245,[statemens0,_7308,_7332,!,_7366],_7288,_7290) --> 
    stm_conjunction(_7308,_7288,_7323),
    look_ahead_lit(['så','nå',da],_7332,_7323,_7349),
    !,
    statemens(_7240,_7245,_7366,_7349,_7290).

statemens0(_7240,_7241,_7241 and _7245,[statemens0,_7301,!,_7335],_7281,_7283) --> 
    look_ahead(['så'],_7301,_7281,_7318),
    !,
    statemens(_7240,_7245,_7335,_7318,_7283).

statemens0(_7240,_7241,_7241 and _7245,[statemens0,_7311,_7335,_7364,!,_7393],_7291,_7293) --> 
    stm_conjunction(_7311,_7291,_7326),
    not_look_ahead(w(verb(_7266,_7267,_7268)),_7335,_7326,_7352),
    not_look_ahead_number(_7364,_7352,_7379),
    !,
    statemens(_7240,_7245,_7393,_7379,_7293).

statemens0(_7240,_7241,_7241,[statemens0,[]],_7265,_7265) --> 
    [].

stm_conjunction([stm_conjunction,lit(hvorav)],_7257,_7259) --> 
    cc(hvorav,_7257,_7259).

stm_conjunction([stm_conjunction,lit('å'),_7286],_7264,_7266) --> 
    cc('å',_7264,_7285),
    look_ahead(['så'],_7286,_7285,_7266).

stm_conjunction([stm_conjunction,lit('å'),_7286],_7264,_7266) --> 
    cc('å',_7264,_7285),
    look_ahead(['nå'],_7286,_7285,_7266).

stm_conjunction([stm_conjunction,lit(og),_7286],_7264,_7266) --> 
    cc(og,_7264,_7285),
    look_ahead(['nå'],_7286,_7285,_7266).

stm_conjunction([stm_conjunction,lit(og),lit(at)],_7262,_7264) --> 
    cc(og,_7262,_7283),
    cc(at,_7283,_7264).

stm_conjunction([stm_conjunction,lit(men),lit(at)],_7262,_7264) --> 
    cc(men,_7262,_7283),
    cc(at,_7283,_7264).

stm_conjunction([stm_conjunction,lit('altså'),lit(at)],_7262,_7264) --> 
    cc('altså',_7262,_7283),
    cc(at,_7283,_7264).

stm_conjunction([stm_conjunction,_7266],_7255,_7257) --> 
    and1(_7266,_7255,_7257).

stm_conjunction([stm_conjunction,lit(men)],_7257,_7259) --> 
    cc(men,_7257,_7259).

stm_conjunction([stm_conjunction,_7270],_7259,_7261) --> 
    look_ahead(['så'],_7270,_7259,_7261).

stm_conjunction([stm_conjunction,_7277,_7321],_7266,_7268) --> 
    optional([','],_7277,_7266,_7309),
    look_ahead([ikke],_7321,_7309,_7268).

stm_conjunction([stm_conjunction,lit(mens)],_7257,_7259) --> 
    cc(mens,_7257,_7259).

statemen1(_7240,_7241,[statemen1,_7282],_7265,_7267) --> 
    stateme1(_7240,_7241,_7282,_7265,_7267).

statemen1(_7240,_7241,[statemen1,_7341,{},_7380,!,_7429],_7324,_7326) --> 
    w(adj2(_7271,nil),_7341,_7324,_7358),
    {user:testmember(_7271,[possible,clear,ready])},
    optional([at],_7380,_7358,_7412),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7271,nil)),[at]),nil,_7412,_7439),
    substateme1(_7240,_7241,_7429,_7439,_7326).

statemen1(_7240,_7241,[statemen1,_7365,{},_7404,{},{},_7453,!,_7492,!,_7571],_7348,_7350) --> 
    w(adj2(_7272,nil),_7365,_7348,_7382),
    {user:testmember(_7272,[enclosed])},
    w(verb(_7284,_7285,fin),_7404,_7382,_7421),
    {user:(\+testmember(_7284,[]))},
    {user:verbtype(_7284,iv)},
    subject(_7300,_7301,_7453,_7421,_7472),
    !,
    pushstack(first,(xnp(_7300,_7301),w(verb(_7284,_7285,fin)),w(adj2(_7272,nil))),nil,_7472,_7536),substateme1(_7240,_7241,_7492,_7536,_7551),
    !,
    accept(_7571,_7551,_7350).

statemen1(_7240,_7241,[statemen1,_7332,_7356,{},lit(det),_7406,_7430,!,_7478],_7315,_7317) --> 
    redundant(_7332,_7315,_7347),
    w(verb(_7266,_7267,fin),_7356,_7347,_7373),
    {user:(\+testmember(_7266,[]))},
    cc(det,_7373,_7405),
    danow0(_7406,_7405,_7421),
    pushstack(first,([det],w(verb(_7266,pres,fin))),nil,_7421,_7443),substateme1(_7240,_7241,_7430,_7443,_7458),
    !,
    accept(_7478,_7458,_7317).

statemen1(_7240,_7241,[statemen1,_7341,_7385,{},_7424,!,_7472],_7324,_7326) --> 
    optional([meget],_7341,_7324,_7373),
    w(adj2(_7264,nil),_7385,_7373,_7402),
    {user:testmember(_7264,[good,bad,interesting,nice])},
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7264,nil))),nil,_7402,_7437),substateme1(_7240,_7241,_7424,_7437,_7452),
    !,
    accept(_7472,_7452,_7326).

statemen1(_7240,_7241,[statemen1,_7302,{},_7341],_7285,_7287) --> 
    not_look_ahead_lit([hva,hvem,hvilke,hvilken,hvilket],_7302,_7285,_7319),
    {user:unprotected_verb},
    substateme1(_7240,_7241,_7341,_7319,_7287).

statemen1(_7240,_7241,[statemen1,lit(som),lit(du),_7367,{},_7406,_7435,_7469],_7328,_7330) --> 
    cc(som,_7328,_7355),
    cc(du,_7355,_7366),
    w(verb(_7279,_7280,fin),_7367,_7366,_7384),
    {user:testmember(_7279,[know,see,understand])},
    w(verb(_7269,_7297,fin),_7406,_7384,_7423),
    subject(_7300,_7301,_7435,_7423,_7454),
    pushstack(first,(xnp(_7300,_7301),w(verb(_7269,pres,fin))),nil,_7454,_7510),
    substateme1(_7240,_7241,_7469,_7510,_7330).

statemen1(_7240,_7241,[statemen1,_7316,_7340,lit(det),_7380,!],_7299,_7301) --> 
    soredundant(_7316,_7299,_7331),
    w(verb(_7257,_7258,fin),_7340,_7331,_7357),
    cc(det,_7357,_7379),
    pushstack(first,([noe],w(verb(_7257,_7258,fin))),nil,_7379,_7393),substateme1(_7240,_7241,_7380,_7393,_7301),
    !.

stateme1(_7240,_7241,[stateme1,_7291],_7274,_7276) --> 
    statem(_7243,event/_7240/_7243::_7241,_7291,_7274,_7276).

substateme1(_7240,_7241,[substateme1,_7291],_7274,_7276) --> 
    substatem1(_7243,event/_7240/_7243::_7241,_7291,_7274,_7276).

substatem(_7240,_7241,[substatem,_7289,_7323],_7272,_7274) --> 
    substatem1(_7240,_7247,_7289,_7272,_7308),
    ogat(_7240,_7247,_7241,_7323,_7308,_7274).

ogat(_7240,_7244::_7247,_7244::_7247 and _7248,[ogat,lit(og),lit(at),!,_7340],_7293,_7295) --> 
    cc(og,_7293,_7323),
    cc(at,_7323,_7334),
    !,
    substatem1(_7240,_7244::_7248,_7340,_7334,_7295).

ogat(_7240,_7241,_7241,[ogat,[]],_7265,_7265) --> 
    [].

substatem1(_7240,_7241,[substatem1,lit(det),_7342,_7371,{},!,[],_7459],_7314,_7316) --> 
    cc(det,_7314,_7341),
    negation0(_7275,_7342,_7341,_7359),
    be(_7277,_7371,_7359,_7388),
    {user:bigno(_7275,_7277,_7283)},
    !,
    pushstack(free,negation(_7283),nil,_7388,_7458),[],
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_7458,_7469),
    statem(_7240,_7241,_7459,_7469,_7316).

substatem1(_7240,_7241,[substatem1,lit(det),_7343,_7372,{},!,_7436],_7315,_7317) --> 
    cc(det,_7315,_7342),
    negation0(_7271,_7343,_7342,_7360),
    hlexv(_7273,_7274,_7275,fin,_7277,_7372,_7360,_7397),
    {user:bigno(_7271,_7277,_7267)},
    !,
    pushstack(first,([det],w(verb(_7274,pres,fin)),negation(_7267)),nil,_7397,_7476),
    statem(_7240,_7241,_7436,_7476,_7317).

substatem1(_7240,_7241,[substatem1,lit('å'),!,_7326,!,_7374],_7293,_7295) --> 
    cc('å',_7293,_7320),
    !,
    pushstack(first,[jeg],nil,_7320,_7339),clausal_object1(_7258,_7259,_7326,_7339,_7354),
    !,
    lock(last,_7354,_7422),
    pushstack(last,xnp(_7258,_7259),nil,_7422,_7428),
    statem(_7240,_7241,_7374,_7428,_7417),
    unlock(_7417,_7295).

substatem1(_7240,_7241,[substatem1,_7335,_7359,_7388,_7431,!,_7460],_7318,_7320) --> 
    'forå'(_7335,_7318,_7350),
    w(verb(_7270,inf,fin),_7359,_7350,_7376),
    pushstack(first,([jeg],w(verb(_7270,pres,fin))),nil,_7376,_7401),clausal_object1(_7265,true::_7266,_7388,_7401,_7416),
    hvisaa0(_7431,_7416,_7446),
    !,
    lock(last,_7446,_7510),
    pushstack(last,(['så'],subordinate(in_order_to,_7265,_7266)),nil,_7510,_7516),
    statem(_7240,_7241,_7460,_7516,_7505),
    unlock(_7505,_7320).

substatem1(_7240,_7241,[substatem1,_7355,_7384,[],_7468,_7492,lit(det),_7527,_7551,!,_7585],_7338,_7340) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom],_7355,_7338,_7372),
    subordinate(_7297,_7298,_7299,_7384,_7372,_7405),
    pushstack(free,subordinate(_7297,_7298,_7299),nil,_7405,_7467),[],
    hvisaa0(_7468,_7467,_7483),
    has(_7492,_7483,_7507),
    cc(det,_7507,_7526),
    redundant0(_7527,_7526,_7542),
    w(verb(be,past,part),_7551,_7542,_7568),
    !,
    pushstack(first,w(verb(be,past,fin)),nil,_7568,_7595),
    itstatem(_7240,_7241,_7585,_7595,_7340).

substatem1(_7240,_7241,[substatem1,_7332,_7361,_7400,!,_7429],_7315,_7317) --> 
    look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom,da,'når'],_7332,_7315,_7349),
    subordinate(_7261,_7262,_7263,_7361,_7349,_7382),
    hvisaa0(_7400,_7382,_7415),
    !,
    lock(last,_7415,_7478),
    pushstack(last,(['så'],subordinate(_7261,_7262,_7263)),nil,_7478,_7484),
    statem(_7240,_7241,_7429,_7484,_7473),
    unlock(_7473,_7317).

substatem1(_7240,_7241,[substatem1,_7282],_7265,_7267) --> 
    substate(_7240,_7241,_7282,_7265,_7267).

hvisaa0([hvisaa0,lit('så'),!],_7260,_7262) --> 
    cc('så',_7260,_7262),
    !.

hvisaa0([hvisaa0,_7273,!],_7262,_7264) --> 
    look_ahead_lit([ble],_7273,_7262,_7264),
    !.

hvisaa0([hvisaa0,_7275,!],_7264,_7266) --> 
    look_ahead_lit([kan,'får'],_7275,_7264,_7266),
    !.

hvisaa0([hvisaa0,_7290,{}],_7279,_7281) --> 
    look_ahead(w(verb(_7245,_7261,fin)),_7290,_7279,_7281),
    {user:testmember(_7245,[avoid,be,come,have])}.

hvisaa0([hvisaa0,[]],_7255,_7255) --> 
    [].

sostatem(_7240,_7241,[sostatem,_7337,_7361,_7395,_7419,_7448,!,_7482,!],_7320,_7322) --> 
    faux1(_7337,_7320,_7352),
    subject(_7264,_7265,_7361,_7352,_7380),
    redundant0(_7395,_7380,_7410),
    negation0(_7267,_7419,_7410,_7436),
    w(verb(_7271,inf,fin),_7448,_7436,_7465),
    !,
    pushstack(first,(xnp(_7264,_7265),aux1,negation(_7267),w(verb(_7271,inf,fin))),nil,_7465,_7584),state(_7240,_7241,_7482,_7584,_7322),
    !.

sostatem(_7240,_7241,[sostatem,_7357,lit(det),_7397,_7426,lit(at),!,_7486,_7520],_7340,_7342) --> 
    w(verb(_7283,_7284,fin),_7357,_7340,_7374),
    cc(det,_7374,_7396),
    negation0(_7289,_7397,_7396,_7414),
    adj1(_7276,_7296:_7297,_7278,_7279,_7426,_7414,_7449),
    cc(at,_7449,_7480),
    !,
    clausal_object1(_7301,_7302,_7486,_7480,_7505),
    pushstack(first,(xnp(_7301,_7302),w(verb(_7283,_7284,fin)),negation(_7289),adj1(_7276,_7296:_7319,_7278,_7279)),nil,_7505,_7624),
    state(_7240,_7241,_7520,_7624,_7342).

sostatem(_7240,_7241,[sostatem,_7336,lit(det),_7371,_7395,_7424,_7453,_7487,!],_7319,_7321) --> 
    has(_7336,_7319,_7351),
    cc(det,_7351,_7370),
    preadverbials0(_7371,_7370,_7386),
    negation0(_7266,_7395,_7386,_7412),
    w(verb(_7270,past,part),_7424,_7412,_7441),
    subject(_7274,_7275,_7453,_7441,_7472),
    pushstack(first,(xnp(_7274,_7275),w(verb(_7270,past,fin)),negation(_7266)),nil,_7472,_7561),state(_7240,_7241,_7487,_7561,_7321),
    !.

sostatem(_7240,_7241,[sostatem,_7335,_7384,_7413,_7437,{},_7476,!],_7318,_7320) --> 
    lexvaccept(rv,_7262,_7263,fin,_7265,_7335,_7318,_7360),
    negation0(_7267,_7384,_7360,_7401),
    thereit(_7413,_7401,_7428),
    negation0(_7269,_7437,_7428,_7454),
    {user:bigno(_7267,_7269,_7265)},
    pushstack(first,([noe],w(verb(_7262,_7263,fin)),negation(_7265)),nil,_7454,_7519),state(_7240,_7241,_7476,_7519,_7320),
    !.

sostatem(_7240,_7241,[sostatem,_7339,_7368,_7397,_7431,{},_7470,!],_7322,_7324) --> 
    w(verb(_7263,_7264,fin),_7339,_7322,_7356),
    negation0(_7267,_7368,_7356,_7385),
    subject(_7269,_7270,_7397,_7385,_7416),
    negation0(_7272,_7431,_7416,_7448),
    {user:bigno(_7267,_7272,_7278)},
    pushstack(first,(xnp(_7269,_7270),w(verb(_7263,_7264,fin)),negation(_7278)),nil,_7448,_7544),state(_7240,_7241,_7470,_7544,_7324),
    !.

sostatem(_7240,_7241,[sostatem,_7321,_7350,_7374,_7403,!],_7304,_7306) --> 
    w(verb(_7257,_7258,pass),_7321,_7304,_7338),
    thereit0(_7350,_7338,_7365),
    negation0(_7261,_7374,_7365,_7391),
    pushstack(first,([noen],w(verb(_7257,_7258,fin)),negation(_7261)),nil,_7391,_7446),state(_7240,_7241,_7403,_7446,_7306),
    !.

sostatem(_7240,_7241,[sostatem,_7333,lit(det),_7368,{},!,_7412,!],_7316,_7318) --> 
    aux1(_7333,_7316,_7348),
    cc(det,_7348,_7367),
    w(verb(_7265,_7266,_7267),_7368,_7367,_7385),
    {user:(_7266=inf;_7267=part)},
    !,
    pushstack(first,([noe],w(verb(_7265,pres,fin))),nil,_7385,_7425),state(_7240,_7241,_7412,_7425,_7318),
    !.

sostatem(_7240,_7241,[sostatem,_7317,lit(det),_7352,!,_7386,!],_7300,_7302) --> 
    aux1(_7317,_7300,_7332),
    cc(det,_7332,_7351),
    w(verb(_7262,pres,pass),_7352,_7351,_7369),
    !,
    pushstack(first,(someone,w(verb(_7262,pres,fin))),nil,_7369,_7430),state(_7240,_7241,_7386,_7430,_7302),
    !.

sostatem(_7240,_7241,[sostatem,_7324,_7348,_7382,!,_7416,!],_7307,_7309) --> 
    aux1(_7324,_7307,_7339),
    object(_7258,_7259,_7348,_7339,_7367),
    w(verb(_7263,pres,pass),_7382,_7367,_7399),
    !,
    pushstack(first,(someone,w(verb(_7263,pres,fin)),xnp(_7258,_7259)),nil,_7399,_7488),state(_7240,_7241,_7416,_7488,_7309),
    !.

sostatem(_7240,_7241,[sostatem,_7326,_7355,{},lit(det),!,_7410,!],_7309,_7311) --> 
    not_look_ahead(['så'],_7326,_7309,_7343),
    w(verb(_7267,_7268,fin),_7355,_7343,_7372),
    {user:_7268\==inf},
    cc(det,_7372,_7404),
    !,
    pushstack(free,w(verb(_7267,pres,fin)),nil,_7404,_7423),state(_7240,_7241,_7410,_7423,_7311),
    !.

sostatem(_7240,_7241,[sostatem,_7324,_7348,_7382,!,_7416,!],_7307,_7309) --> 
    docan(_7324,_7307,_7339),
    subject(_7258,_7259,_7348,_7339,_7367),
    w(verb(_7263,pres,pass),_7382,_7367,_7399),
    !,
    pushstack(first,(someone,w(verb(_7263,pres,fin)),xnp(_7258,_7259)),nil,_7399,_7488),state(_7240,_7241,_7416,_7488,_7309),
    !.

statem(_7240,_7241,[statem,lit(det),_7351,_7380,_7414,!,_7448],_7323,_7325) --> 
    cc(det,_7323,_7350),
    w(verb(_7276,_7277,pass),_7351,_7350,_7368),
    gmem(_7276,[want,wish,need],_7380,_7368,_7399),
    negation0(_7289,_7414,_7399,_7431),
    !,
    pushstack(first,([noen],w(verb(_7276,_7277,fin)),negation(_7289),[dette]),nil,_7431,_7488),
    state(_7240,_7241,_7448,_7488,_7325).

statem(_7240,_7241,[statem,_7288,!,_7317],_7271,_7273) --> 
    preadverbials(_7288,_7271,_7303),
    !,
    prestatem(_7240,_7241,_7317,_7303,_7273).

statem(_7240,_7241,[statem,_7333,_7367,_7396,_7420,!,[],_7506],_7316,_7318) --> 
    obviousdate1(_7273,_7274,_7333,_7316,_7352),
    w(verb(_7269,_7270,fin),_7367,_7352,_7384),
    det0(_7396,_7384,_7411),
    subject(_7282,_7283,_7420,_7411,_7439),
    !,
    pushstack(free,obviousdate1(_7273,_7274),nil,_7439,_7505),[],
    pushstack(first,(xnp(_7282,_7283),w(verb(_7269,_7270,fin))),nil,_7505,_7547),
    state(_7240,_7241,_7506,_7547,_7318).

statem(_7240,_7241,[statem,_7327,_7361,_7390,!,_7439],_7310,_7312) --> 
    obviousdate1(_7264,_7265,_7327,_7310,_7346),
    w(verb(_7272,_7273,pass),_7361,_7346,_7378),
    optional([det],_7390,_7378,_7422),
    !,
    pushstack(free,([noen],w(verb(_7272,_7273,fin)),obviousdate1(_7264,_7265)),nil,_7422,_7480),
    state(_7240,_7241,_7439,_7480,_7312).

statem(_7240,_7241,[statem,_7374,_7408,_7437,_7471,_7505,_7534,lit(om),!,[],[],_7607],_7357,_7359) --> 
    lit_of(_7284,[det,dette],_7374,_7357,_7393),
    w(verb(_7293,_7294,fin),_7408,_7393,_7425),
    gmem(_7293,[worry],_7437,_7425,_7456),
    lit_of(_7302,[jeg,du,man],_7471,_7456,_7490),
    reflexiv0(_7293,_7505,_7490,_7522),
    negation0(_7282,_7534,_7522,_7551),
    cc(om,_7551,_7573),
    !,
    pushstack(free,[dette],nil,_7573,_7592),[],
    pushstack(free,[om],nil,_7592,_7606),[],
    pushstack(first,([_7302],w(verb(_7293,_7294,fin)),negation(_7282)),nil,_7606,_7647),
    state(_7240,_7241,_7607,_7647,_7359).

statem(_7240,_7241,[statem,_7368,_7402,_7431,_7465,lit(om),!,[],[],[],_7595],_7351,_7353) --> 
    lit_of(_7282,[det,dette],_7368,_7351,_7387),
    w(verb(_7278,_7279,fin),_7402,_7387,_7419),
    lit_of(_7295,[jeg,du,man],_7431,_7419,_7450),
    np_kernel(0,_7305,_7306,_7465,_7450,_7486),
    cc(om,_7486,_7514),
    !,
    pushstack(free,[dette],nil,_7514,_7533),[],
    pushstack(free,[om],nil,_7533,_7547),[],
    pushstack(free,np_kernel(0,_7305,_7306),nil,_7547,_7594),[],
    pushstack(first,([_7295],w(verb(_7278,_7279,fin))),nil,_7594,_7605),
    state(_7240,_7241,_7595,_7605,_7353).

statem(_7240,_7241,[statem,_7368,_7402,_7431,_7465,lit(om),!,[],[],[],_7594],_7351,_7353) --> 
    lit_of(_7282,[det,dette],_7368,_7351,_7387),
    w(verb(have,_7279,fin),_7402,_7387,_7419),
    lit_of(_7295,[jeg,du,man],_7431,_7419,_7450),
    np_kernel(0,_7305,_7306,_7465,_7450,_7486),
    cc(om,_7486,_7514),
    !,
    pushstack(free,[dette],nil,_7514,_7533),[],
    pushstack(free,[om],nil,_7533,_7547),[],
    pushstack(free,np_kernel(0,_7305,_7306),nil,_7547,_7593),[],
    pushstack(first,([_7295],w(verb(have,_7279,fin))),nil,_7593,_7604),
    state(_7240,_7241,_7594,_7604,_7353).

statem(_7240,_7241,[statem,_7360,_7399,lit(det),_7434,_7473,_7502,!,_7541],_7343,_7345) --> 
    preadverbial1(_7283,_7284,_7285,_7360,_7343,_7381),
    blei(_7399,_7381,_7414),
    cc(det,_7414,_7433),
    preadverbial0(_7279,_7280,_7281,_7434,_7433,_7455),
    w(verb(_7295,past,part),_7473,_7455,_7490),
    object(_7299,_7300,_7502,_7490,_7521),
    !,
    pushstack(first,(xnp(_7299,_7300),w(verb(be,pres,fin)),w(verb(_7295,past,part)),adverbial1(_7283,_7284,_7285),adverbial1(_7279,_7280,_7281)),nil,_7521,_7646),
    state(_7240,_7241,_7541,_7646,_7345).

statem(_7240,_7241,[statem,_7395,_7424,_7458,_7487,_7521,_7555,_7584,_7628,!,_7662],_7378,_7380) --> 
    not_look_ahead([det],_7395,_7378,_7412),
    obvious_object(_7288,_7289,_7424,_7412,_7443),
    w(verb(_7300,_7301,fin),_7458,_7443,_7475),
    gmem(_7300,[want,wish,need],_7487,_7475,_7506),
    lit_of(_7313,[jeg,vi,han,hun,du],_7521,_7506,_7540),
    negation0(_7326,_7555,_7540,_7572),
    optional(['å'],_7584,_7572,_7616),
    w(verb(_7334,inf,fin),_7628,_7616,_7645),
    !,
    pushstack(first,([_7313],w(verb(_7300,_7301,fin)),negation(_7326),['å'],w(verb(_7334,_7301,fin)),xnp(_7288,_7289)),nil,_7645,_7733),
    state(_7240,_7241,_7662,_7733,_7380).

statem(_7240,_7241,[statem,_7362,_7391,_7425,_7454,_7488,_7522,!,_7556],_7345,_7347) --> 
    not_look_ahead([det],_7362,_7345,_7379),
    obvious_object(_7273,_7274,_7391,_7379,_7410),
    w(verb(_7285,_7286,fin),_7425,_7410,_7442),
    gmem(_7285,[have,get],_7454,_7442,_7473),
    lit_of(_7296,[jeg,vi,han,hun,du],_7488,_7473,_7507),
    w(verb(_7311,past,part),_7522,_7507,_7539),
    !,
    pushstack(first,([_7296],w(verb(_7311,_7286,fin)),xnp(_7273,_7274)),nil,_7539,_7597),
    state(_7240,_7241,_7556,_7597,_7347).

statem(_7240,_7241,[statem,_7365,_7394,_7428,{},_7467,_7501,!,_7535],_7348,_7350) --> 
    not_look_ahead([det],_7365,_7348,_7382),
    obvious_object(_7276,_7277,_7394,_7382,_7413),
    w(verb(_7288,_7289,fin),_7428,_7413,_7445),
    {user:(\+testmember(_7288,[give]))},
    lit_of(_7301,[jeg,vi,han,hun,du],_7467,_7445,_7486),
    negation0(_7314,_7501,_7486,_7518),
    !,
    pushstack(first,([_7301],w(verb(_7288,_7289,fin)),negation(_7314),xnp(_7276,_7277)),nil,_7518,_7606),
    state(_7240,_7241,_7535,_7606,_7350).

statem(_7240,_7241,[statem,_7399,_7428,_7462,_7491,_7525,_7559,_7603,_7632,!,_7666],_7382,_7384) --> 
    not_look_ahead([det],_7399,_7382,_7416),
    obvious_object(_7288,_7289,_7428,_7416,_7447),
    w(verb(_7300,_7301,fin),_7462,_7447,_7479),
    gmem(_7300,[want,wish,need],_7491,_7479,_7510),
    lit_of(_7313,[jeg,vi,han,hun,du],_7525,_7510,_7544),
    optional(['å'],_7559,_7544,_7591),
    w(verb(_7332,inf,fin),_7603,_7591,_7620),
    w(prep(_7338),_7632,_7620,_7649),
    !,
    pushstack(first,([_7313],w(verb(_7300,_7301,fin)),['å'],w(verb(_7332,_7301,fin)),w(prep(_7338)),xnp(_7288,_7289)),nil,_7649,_7707),
    state(_7240,_7241,_7666,_7707,_7384).

statem(_7240,_7241,[statem,_7343,lit(kan),_7388,_7422,!,_7456],_7326,_7328) --> 
    obvious_object(_7267,_7268,_7343,_7326,_7362),
    cc(kan,_7362,_7387),
    lit_of(_7275,[jeg,vi,han,hun,du],_7388,_7387,_7407),
    not_look_ahead(w(verb(_7292,_7293,_7294)),_7422,_7407,_7439),
    !,
    pushstack(first,([_7275],w(verb(do1,pres,fin)),xnp(_7267,_7268)),nil,_7439,_7497),
    state(_7240,_7241,_7456,_7497,_7328).

statem(_7240,_7241,[statem,_7346,_7375,_7409,_7433,_7467,!,_7501],_7329,_7331) --> 
    not_look_ahead([det],_7346,_7329,_7363),
    obvious_object(_7270,_7271,_7375,_7363,_7394),
    aux1(_7409,_7394,_7424),
    lit_of(_7280,[jeg,vi,han,hun,du],_7433,_7424,_7452),
    w(verb(_7295,inf,fin),_7467,_7452,_7484),
    !,
    pushstack(first,([_7280],w(verb(_7295,pres,fin)),xnp(_7270,_7271)),nil,_7484,_7542),
    state(_7240,_7241,_7501,_7542,_7331).

statem(_7240,_7241,[statem,_7346,_7375,_7409,_7433,_7467,!,_7501],_7329,_7331) --> 
    not_look_ahead([det],_7346,_7329,_7363),
    obvious_object(_7270,_7271,_7375,_7363,_7394),
    aux1(_7409,_7394,_7424),
    lit_of(_7280,[jeg,vi,han,hun,du],_7433,_7424,_7452),
    w(verb(_7295,inf,fin),_7467,_7452,_7484),
    !,
    pushstack(first,([_7280],w(verb(_7295,pres,fin)),xnp(_7270,_7271)),nil,_7484,_7542),
    state(_7240,_7241,_7501,_7542,_7331).

statem(_7240,_7241,[statem,lit(det),lit(som),!,_7342],_7298,_7300) --> 
    cc(det,_7298,_7325),
    cc(som,_7325,_7336),
    !,
    pushstack(first,([en],w(noun(thing,sin,u,n)),[som]),nil,_7336,_7352),
    state(_7240,_7241,_7342,_7352,_7300).

statem(_7240,_7241,[statem,_7336,_7365,_7389,lit('å'),!,_7434],_7319,_7321) --> 
    one_of_lit(['nå','så',da,redundant0],_7336,_7319,_7353),
    shoulditbe(_7365,_7353,_7380),
    w(adj2(_7281,_7282),_7389,_7380,_7406),
    cc('å',_7406,_7428),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_7281,_7282)),['å']),nil,_7428,_7444),
    itstatem(_7240,_7241,_7434,_7444,_7321).

statem(_7240,_7241,[statem,_7308,_7337,_7361,!],_7291,_7293) --> 
    one_of_lit(['nå','så',da],_7308,_7291,_7325),
    shoulditbe(_7337,_7325,_7352),
    pushstack(first,w(verb(be,pres,fin)),nil,_7352,_7374),itstatem(_7240,_7241,_7361,_7374,_7293),
    !.

shoulditbe([shoulditbe,_7280,_7309,lit(det)],_7269,_7271) --> 
    w(verb(be,_7251,fin),_7280,_7269,_7297),
    redundant0(_7309,_7297,_7324),
    cc(det,_7324,_7271).

shoulditbe([shoulditbe,_7283,_7307,lit(det),_7342],_7272,_7274) --> 
    aux1(_7283,_7272,_7298),
    redundant0(_7307,_7298,_7322),
    cc(det,_7322,_7341),
    w(verb(be,inf,fin),_7342,_7341,_7274).

shoulditbe([shoulditbe,_7284,lit(det),_7324],_7273,_7275) --> 
    one_of_lit([kan,kunne,'får',fikk],_7284,_7273,_7301),
    cc(det,_7301,_7323),
    vaere(_7324,_7323,_7275).

vaere([vaere,_7276],_7265,_7267) --> 
    one_of_lit(['være','vært',bli,blitt],_7276,_7265,_7267).

statem(_7240,_7241,[statem,lit(det),_7359,_7383,_7417,{},{},!,_7471],_7331,_7333) --> 
    cc(det,_7331,_7358),
    aux1(_7359,_7358,_7374),
    subject(_7277,_7278,_7383,_7374,_7402),
    w(verb(_7282,inf,fin),_7417,_7402,_7434),
    {user:testmember(_7282,[believe,know])},
    {user:verbtype(_7282,rv)},
    !,
    pushstack(first,(xnp(_7277,_7278),w(verb(_7282,pres,fin)),[dette]),nil,_7434,_7512),
    state(_7240,_7241,_7471,_7512,_7333).

statem(_7240,_7241,[statem,_7352,_7386,{},{},_7435,!,_7474],_7335,_7337) --> 
    obvious_object(_7273,_7274,_7352,_7335,_7371),
    w(verb(_7281,_7282,fin),_7386,_7371,_7403),
    {user:testmember(_7281,[believe,know])},
    {user:verbtype(_7281,rv)},
    subject(_7299,_7300,_7435,_7403,_7454),
    !,
    pushstack(first,(xnp(_7299,_7300),w(verb(_7281,_7282,fin)),[at],xnp(_7273,_7274)),nil,_7454,_7546),
    state(_7240,_7241,_7474,_7546,_7337).

statem(_7240,_7241,[statem,_7330,_7364,_7388,_7422,!,_7456],_7313,_7315) --> 
    obvious_object(_7267,_7268,_7330,_7313,_7349),
    has(_7364,_7349,_7379),
    subject(_7273,_7274,_7388,_7379,_7407),
    w(verb(_7278,past,part),_7422,_7407,_7439),
    !,
    pushstack(first,(xnp(_7273,_7274),w(verb(_7278,past,fin)),xnp(_7267,_7268)),nil,_7439,_7528),
    state(_7240,_7241,_7456,_7528,_7315).

statem(_7240,_7241,[statem,lit('å'),_7353,_7382,_7425,!,_7459],_7325,_7327) --> 
    cc('å',_7325,_7352),
    w(verb(_7271,inf,fin),_7353,_7352,_7370),
    pushstack(first,([noen],w(verb(_7271,pres,fin))),nil,_7370,_7395),clausal_object1(_7261,_7264::_7265,_7382,_7395,_7410),
    look_ahead(w(verb(be,pres,fin)),_7425,_7410,_7442),
    !,
    pushstack(first,xnp(_7261,_7264::_7265),nil,_7442,_7500),
    state(_7240,_7241,_7459,_7500,_7327).

statem(_7240,_7241,[statem,lit(det),_7355,lit(seg),_7395,_7424,lit('å'),!,_7469,!],_7327,_7329) --> 
    cc(det,_7327,_7354),
    w(verb(let,_7272,fin),_7355,_7354,_7372),
    cc(seg,_7372,_7394),
    negation0(_7277,_7395,_7394,_7412),
    w(verb(do1,inf,fin),_7424,_7412,_7441),
    cc('å',_7441,_7463),
    !,
    pushstack(first,(w(noun(agent,sin,u,n)),aux1,negation(_7277)),nil,_7463,_7540),state(_7240,_7241,_7469,_7540,_7329),
    !.

statem(_7240,_7241,[statem,_7285,_7309],_7268,_7270) --> 
    soredundant(_7285,_7268,_7300),
    sostatem(_7240,_7241,_7309,_7300,_7270).

statem(_7240,_7241,[statem,_7335,_7364,{},_7403,_7442],_7318,_7320) --> 
    w(noun(_7267,_7268,_7269,n),_7335,_7318,_7352),
    look_ahead(w(prep(_7261)),_7364,_7352,_7381),
    {user:testmember(_7261,[at])},
    pp(_7261,_7262,_7263,_7403,_7381,_7424),
    pushstack(free,(w(noun(_7267,_7268,_7269,n)),pp(_7261,_7262,_7263)),nil,_7424,_7485),
    state(_7240,_7241,_7442,_7485,_7320).

statem(_7240,_7241,[statem,_7359,_7393,{},_7432,_7466,!,_7500,!],_7342,_7344) --> 
    lit_of(_7264,[dette],_7359,_7342,_7378),
    w(verb(_7271,_7272,fin),_7393,_7378,_7410),
    {user:(\+testmember(_7271,[be,give,take,cost]))},
    subject(_7290,_7291,_7432,_7410,_7451),
    negation0(_7293,_7466,_7451,_7483),
    !,
    pushstack(first,(xnp(_7290,_7291),w(verb(_7271,_7272,fin)),negation(_7293),[_7264]),nil,_7483,_7574),state(_7240,_7241,_7500,_7574,_7344),
    !.

statem(_7240,_7241,[statem,_7351,{},_7390,!,_7424],_7334,_7336) --> 
    w(adj2(_7273,nil),_7351,_7334,_7368),
    {user:testmember(_7273,[good,bad,correct,true,mild,hot,cold])},
    w(prep(_7269),_7390,_7368,_7407),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7273,nil)),w(prep(_7269))),nil,_7407,_7434),
    state(_7240,_7241,_7424,_7434,_7336).

statem(_7240,_7241,[statem,_7351,{},_7390,!,_7424],_7334,_7336) --> 
    w(adj2(_7273,nil),_7351,_7334,_7368),
    {user:testmember(_7273,[good,bad,correct,true,mild,hot,cold])},
    w(adv(_7269),_7390,_7368,_7407),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7273,nil)),w(adv(_7269))),nil,_7407,_7434),
    state(_7240,_7241,_7424,_7434,_7336).

statem(_7240,_7241,[statem,_7315,_7339,_7368,!,_7402,!,_7480],_7298,_7300) --> 
    init(_7315,_7298,_7330),
    negation(_7261,_7339,_7330,_7356),
    not_look_ahead(w(verb(_7267,_7268,pass)),_7368,_7356,_7385),
    !,
    pushstack(free,negation(_7261),nil,_7385,_7445),itstatem(_7240,_7241,_7402,_7445,_7460),
    !,
    accept(_7480,_7460,_7300).

statem(_7240,_7241,[statem,_7324,_7348,_7372,_7396,_7425,!,[],_7478],_7307,_7309) --> 
    redundants0(_7324,_7307,_7339),
    dette(_7348,_7339,_7363),
    aux1(_7372,_7363,_7387),
    not_look_ahead(['være'],_7396,_7387,_7413),
    obvious_object(_7274,_7275,_7425,_7413,_7444),
    !,
    pushstack(free,[dette],nil,_7444,_7477),[],
    pushstack(first,(xnp(_7274,_7275),aux1),nil,_7477,_7547),
    state(_7240,_7241,_7478,_7547,_7309).

statem(_7240,_7241,[statem,_7294,!,_7323,!,_7362],_7277,_7279) --> 
    init(_7294,_7277,_7309),
    !,
    itstatem(_7240,_7241,_7323,_7309,_7342),
    !,
    accept(_7362,_7342,_7279).

statem(_7240,_7243::_7244,[statem,_7294,!,_7333],_7277,_7279) --> 
    state(_7240,_7243::_7244,_7294,_7277,_7313),
    !,
    accept(_7333,_7313,_7279).

statem(_7240,_7243::_7244,[statem,_7387,_7421,_7450,_7474,_7503,lit('å'),{},[],{},_7608,{}],_7370,_7372) --> 
    subject(_7282,_7283,_7387,_7370,_7406),
    be(_7278,_7421,_7406,_7438),
    so0(_7450,_7438,_7465),
    gradverb0(_7287,_7474,_7465,_7491),
    w(adj2(_7291,nil),_7503,_7491,_7520),
    cc('å',_7520,_7542),
    {user:testmember(_7291,[difficult,easy,expensive,free,funny,good,intelligent,sad,stupid,tedious])},
    pushstack(free,xnp(_7282,_7283),nil,_7542,_7597),[],
    {user:it_template(_7329)},
    pushstack(first,(w(adj2(_7291,nil)),['å']),nil,_7597,_7621),be_complements(_7329,_7240,_7243::_7279,_7608,_7621,_7372),
    {user:negate(_7278,_7279,_7244)}.

statem(_7240,_7243::_7244,[statem,_7342,_7376,_7400,{},!,_7444,_7468],_7325,_7327) --> 
    np1_accept(_7275,_7276,_7342,_7325,_7361),
    aux1(_7376,_7361,_7391),
    prepnof(_7278,_7400,_7391,_7417),
    {user:testmember(_7278,[on,to,towards])},
    !,
    accept(_7444,_7417,_7459),
    pushstack(first,(np(_7275,_7276),w(verb(go,pres,fin)),prep(to)),nil,_7459,_7542),
    state(_7240,_7243::_7244,_7468,_7542,_7327).

statem(_7240,_7243::_7244,[statem,_7356,_7385,_7414,_7448,_7472,{},_7511],_7339,_7341) --> 
    not_look_ahead([dette],_7356,_7339,_7373),
    not_look_ahead([det],_7385,_7373,_7402),
    np1_accept(_7283,_7284,_7414,_7402,_7433),
    aux1(_7448,_7433,_7463),
    prepnof(_7273,_7472,_7463,_7489),
    {user:testmember(_7273,[to,from,near,in,on,past])},
    pushstack(first,(np(_7283,_7284),w(verb(go,pres,fin)),prep(_7273)),nil,_7489,_7583),
    state(_7240,_7243::_7244,_7511,_7583,_7341).

statem(_7240,_7243::_7244,[statem,_7358,_7387,_7416,_7450,_7479,_7503,_7532,_7561,_7590],_7341,_7343) --> 
    not_look_ahead([dette],_7358,_7341,_7375),
    not_look_ahead([det],_7387,_7375,_7404),
    np1_accept(_7290,_7291,_7416,_7404,_7435),
    not_look_ahead([kan],_7450,_7435,_7467),
    aux1(_7479,_7467,_7494),
    look_ahead([hjem],_7503,_7494,_7520),
    not_look_ahead([kunne],_7532,_7520,_7549),
    not_look_ahead(w(verb(_7309,_7310,_7311)),_7561,_7549,_7578),
    pushstack(first,(np(_7290,_7291),w(verb(go,pres,fin))),nil,_7578,_7631),
    state(_7240,_7243::_7244,_7590,_7631,_7343).

statem(_7240,_7241,[statem,_7311,_7335,_7359,[],_7407],_7294,_7296) --> 
    dedette(_7311,_7294,_7326),
    aux1(_7335,_7326,_7350),
    np1_accept(_7261,_7262,_7359,_7350,_7378),
    pushstack(free,[dette],nil,_7378,_7406),[],
    pushstack(first,(xnp(_7261,_7262),aux1),nil,_7406,_7476),
    state(_7240,_7241,_7407,_7476,_7296).

dedette([dedette,lit(det)],_7257,_7259) --> 
    cc(det,_7257,_7259).

dedette([dedette,lit(dette)],_7257,_7259) --> 
    cc(dette,_7257,_7259).

soredundant0([soredundant0,_7269,!],_7258,_7260) --> 
    soredundant(_7269,_7258,_7260),
    !.

soredundant([soredundant,lit('når'),!],_7260,_7262) --> 
    cc('når',_7260,_7262),
    !.

soredundant([soredundant,_7269,!],_7258,_7260) --> 
    so(_7269,_7258,_7260),
    !.

soredundant([soredundant,_7266],_7255,_7257) --> 
    redundant(_7266,_7255,_7257).

so([so,lit('så'),!],_7260,_7262) --> 
    cc('så',_7260,_7262),
    !.

so([so,lit(derfor),!],_7260,_7262) --> 
    cc(derfor,_7260,_7262),
    !.

so([so,_7278],_7267,_7269) --> 
    look_ahead_lit([kan,'må',vil,skal,'bør'],_7278,_7267,_7269).

so([so,_7274],_7263,_7265) --> 
    look_ahead(w(verb(know,_7245,fin)),_7274,_7263,_7265).

statem(_7240,_7243::_7244,[statem,_7332,_7371,lit(kan),_7406,_7430,_7464,_7488],_7315,_7317) --> 
    adverbx(_7273,_7274,pre,_7332,_7315,_7353),
    saa0(_7371,_7353,_7386),
    cc(kan,_7386,_7405),
    redundant0(_7406,_7405,_7421),
    np1_accept(_7282,_7283,_7430,_7421,_7449),
    redundant0(_7464,_7449,_7479),
    pushstack(free,(noun_phrase1(_7282,_7283),[kan],xadverb(_7273,_7274)),nil,_7479,_7564),
    state(_7240,_7243::_7244,_7488,_7564,_7317).

statem(_7240,_7243::_7244,[statem,_7328,_7367,_7391,_7415,_7439,_7473,_7497],_7311,_7313) --> 
    adverbx(_7273,_7274,pre,_7328,_7311,_7349),
    saa0(_7367,_7349,_7382),
    aux1(_7391,_7382,_7406),
    redundant0(_7415,_7406,_7430),
    np1_accept(_7280,_7281,_7439,_7430,_7458),
    redundant0(_7473,_7458,_7488),
    pushstack(free,(noun_phrase1(_7280,_7281),aux1,xadverb(_7273,_7274)),nil,_7488,_7597),
    state(_7240,_7243::_7244,_7497,_7597,_7313).

statem(_7240,_7243::_7244,[statem,_7331,_7370,_7394,lit(jeg),_7429,!,_7458,_7482],_7314,_7316) --> 
    adverbx(_7276,_7277,pre,_7331,_7314,_7352),
    saa0(_7370,_7352,_7385),
    aux1(_7394,_7385,_7409),
    cc(jeg,_7409,_7428),
    redundant0(_7429,_7428,_7444),
    !,
    accept(_7458,_7444,_7473),
    pushstack(free,([jeg],[skal],xadverb(_7276,_7277)),nil,_7473,_7523),
    state(_7240,_7243::_7244,_7482,_7523,_7316).

statem(_7240,_7243::_7244,[statem,lit(at),_7318,_7352,{}],_7290,_7292) --> 
    cc(at,_7290,_7317),
    statem(_7240,_7243::_7258,_7318,_7317,_7337),
    be_truefalse(_7257,_7352,_7337,_7292),
    {user:negate(_7257,_7258,_7244)}.

statem(_7240,_7243::_7244,[statem,_7332,_7371,_7395,_7424,_7453],_7315,_7317) --> 
    adverbx(_7267,_7268,pre,_7332,_7315,_7353),
    saa0(_7371,_7353,_7386),
    w(verb(_7276,_7277,_7278),_7395,_7386,_7412),
    negation0(_7280,_7424,_7412,_7441),
    lock(last,_7441,_7531),
    pushstack(last,(w(verb(_7276,_7277,_7278)),negation(_7280),xadverb(_7267,_7268)),nil,_7531,_7537),
    state(_7240,_7243::_7244,_7453,_7537,_7526),
    unlock(_7526,_7317).

statem(_7240,_7243::_7244,[statem,_7343,_7382,_7411,_7445,!,_7479],_7326,_7328) --> 
    adverbx(_7270,_7271,pre,_7343,_7326,_7364),
    w(verb(be,_7280,fin),_7382,_7364,_7399),
    np1_accept(_7283,_7284,_7411,_7399,_7430),
    w(verb(_7288,_7289,part),_7445,_7430,_7462),
    !,
    lock(last,_7462,_7558),
    pushstack(last,(np(_7283,_7284),w(verb(_7288,_7289,fin)),xadverb(_7270,_7271)),nil,_7558,_7564),
    state(_7240,_7243::_7244,_7479,_7564,_7553),
    unlock(_7553,_7328).

statem(_7240,_7243::_7244,[statem,_7335,_7374,_7398,_7432,!,_7466],_7318,_7320) --> 
    adverbx(_7270,_7271,pre,_7335,_7318,_7356),
    be(_7374,_7356,_7389),
    specific_phrase(_7277,_7280::_7281,_7398,_7389,_7417),
    negation0(_7283,_7432,_7417,_7449),
    !,
    pushstack(free,(np(_7277,_7280::_7281),be(_7283),xadverb(_7270,_7271)),nil,_7449,_7571),
    state(_7240,_7243::_7244,_7466,_7571,_7320).

statem(_7240,_7243::_7244,[statem,_7323,_7362,_7391,!,_7425],_7306,_7308) --> 
    adverbx(_7264,_7265,pre,_7323,_7306,_7344),
    w(verb(be,_7274,fin),_7362,_7344,_7379),
    negation0(_7277,_7391,_7379,_7408),
    !,
    pushstack(free,(be(_7277),xadverb(_7264,_7265)),nil,_7408,_7496),
    state(_7240,_7243::_7244,_7425,_7496,_7308).

statem(_7240,_7243::_7244,[statem,_7307,_7346,_7370,_7394],_7290,_7292) --> 
    adverbx(_7258,_7259,pre,_7307,_7290,_7328),
    saa0(_7346,_7328,_7361),
    doit(_7370,_7361,_7385),
    pushstack(free,xadverb(_7258,_7259),nil,_7385,_7435),
    state(_7240,_7243::_7244,_7394,_7435,_7292).

statem(_7240,_7241,[statem,_7328,_7367,_7391,_7425,_7454],_7311,_7313) --> 
    adverbx(_7264,_7265,pre,_7328,_7311,_7349),
    has(_7367,_7349,_7382),
    specific_phrase(_7271,_7272,_7391,_7382,_7410),
    w(verb(_7276,past,part),_7425,_7410,_7442),
    lock(last,_7442,_7533),
    pushstack(last,(xnp(_7271,_7272),w(verb(_7276,past,fin)),xadverb(_7264,_7265)),nil,_7533,_7539),
    state(_7240,_7241,_7454,_7539,_7528),
    unlock(_7528,_7313).

statem(_7240,_7241,[statem,_7314,_7353,_7382],_7297,_7299) --> 
    preadverbial1(_7255,_7256,_7257,_7314,_7297,_7335),
    w(verb(be,pres,fin),_7353,_7335,_7370),
    pushstack(free,(w(verb(be,pres,fin)),adverbial1(_7255,_7256,_7257)),nil,_7370,_7424),
    state(_7240,_7241,_7382,_7424,_7299).

statem(_7240,_7241,[statem,_7294,_7318,!,_7347,_7371],_7277,_7279) --> 
    preadverbials0(_7294,_7277,_7309),
    aux1(_7318,_7309,_7333),
    !,
    accept(_7347,_7333,_7362),
    state(_7240,_7241,_7371,_7362,_7279).

statem(_7240,_7243::_7244,[statem,_7320,_7359,!,_7388],_7303,_7305) --> 
    adverbial1(_7264,_7265,_7268::_7269,_7320,_7303,_7341),
    be(_7359,_7341,_7374),
    !,
    pushstack(free,(thereit,be,adverbial1(_7264,_7265,_7268::_7269)),nil,_7374,_7493),
    statem(_7240,_7243::_7244,_7388,_7493,_7305).

statem(_7240,_7243::_7244,[statem,_7355,_7394,_7418,_7452,!,_7486],_7338,_7340) --> 
    preadverbial1(_7273,_7274,_7277::_7278,_7355,_7338,_7376),
    doit(_7394,_7376,_7409),
    specific_phrase(_7287,_7290::_7291,_7418,_7409,_7437),
    w(prep(_7295),_7452,_7437,_7469),
    !,
    pushstack(free,(np(_7287,_7290::_7291),w(verb(go,pres,fin)),w(prep(_7295)),adverbial1(_7273,_7274,_7277::_7278)),nil,_7469,_7565),
    state(_7240,_7243::_7244,_7486,_7565,_7340).

statem(_7240,_7243::_7244,[statem,_7314,_7353,!,_7382],_7297,_7299) --> 
    preadverbial1(_7258,_7259,_7262::_7263,_7314,_7297,_7335),
    doit(_7353,_7335,_7368),
    !,
    pushstack(free,adverbial1(_7258,_7259,_7262::_7263),nil,_7368,_7427),
    state(_7240,_7243::_7244,_7382,_7427,_7299).

statem(_7240,_7241,[statem,_7332,_7371,_7395,_7424,!,_7463],_7315,_7317) --> 
    preadverbial1(_7267,_7268,_7269,_7332,_7315,_7353),
    so0(_7371,_7353,_7386),
    w(verb(have,_7278,fin),_7395,_7386,_7412),
    subject(_7281,_7282,_7424,_7412,_7443),
    !,
    pushstack(free,(xnp(_7281,_7282),w(verb(have,_7278,fin)),adverbial1(_7267,_7268,_7269)),nil,_7443,_7536),
    state(_7240,_7241,_7463,_7536,_7317).

statem(_7240,_7243::_7244,[statem,{},_7371,_7410,_7449,!,_7498,_7522],_7344,_7346) --> 
    {user:value(dialog,1)},
    preadverbial1(_7288,_7289,_7292::_7293,_7371,_7344,_7392),
    preadverbial1(_7273,_7274,_7277::_7278,_7410,_7392,_7431),
    lexv(_7302,_7303,_7304,fin,_7449,_7431,_7472),
    !,
    accept(_7498,_7472,_7513),
    lock(last,_7513,_7640),
    pushstack(last,(lexv(_7302,_7303,_7304,fin),adverbial1(_7288,_7289,_7292::_7293),adverbial1(_7273,_7274,_7277::_7278)),nil,_7640,_7646),
    state(_7240,_7243::_7244,_7522,_7646,_7635),
    unlock(_7635,_7346).

prestatem(_7240,_7241,[prestatem,_7334,_7363,lit(det),_7408,!,_7442],_7317,_7319) --> 
    w(verb(_7271,_7272,fin),_7334,_7317,_7351),
    gmem(_7271,[be,stand],_7363,_7351,_7382),
    cc(det,_7382,_7407),
    w(adj2(_7266,_7267),_7408,_7407,_7425),
    !,
    pushstack(first,(w(verb(be,_7272,fin)),w(adj2(_7266,_7267))),nil,_7425,_7452),
    itstatem(_7240,_7241,_7442,_7452,_7319).

prestatem(_7240,_7241,[prestatem,_7361,_7385,_7409,_7438,_7462,_7496,_7520,{},_7559,!,_7598],_7344,_7346) --> 
    so0(_7361,_7344,_7376),
    aux1(_7385,_7376,_7400),
    negation0(_7288,_7409,_7400,_7426),
    redundant0(_7438,_7426,_7453),
    object(_7285,_7286,_7462,_7453,_7481),
    redundant0(_7496,_7481,_7511),
    w(verb(_7295,_7296,pass),_7520,_7511,_7537),
    {user:(\+testmember(_7295,[be]))},
    whodidit(_7308,_7309,_7559,_7537,_7578),
    !,
    pushstack(first,(xnp(_7308,_7309),w(verb(_7295,_7296,fin)),negation(_7288),xnp(_7285,_7286)),nil,_7578,_7700),
    state(_7240,_7241,_7598,_7700,_7346).

prestatem(_7240,_7241,[prestatem,_7321,_7345,_7374,!,_7418],_7304,_7306) --> 
    shoulditbe(_7321,_7304,_7336),
    not_look_ahead(w(adj2(_7269,_7270)),_7345,_7336,_7362),
    adverbix0(_7261,_7262,_7263,_7374,_7362,_7395),
    !,
    pushstack(free,(w(verb(be,pres,fin)),xadverbial1(_7261,_7262,_7263)),nil,_7395,_7460),
    itstatem(_7240,_7241,_7418,_7460,_7306).

prestatem(_7240,_7241,[prestatem,_7302,lit(det),_7342,!,_7371],_7285,_7287) --> 
    w(verb(be,_7261,fin),_7302,_7285,_7319),
    cc(det,_7319,_7341),
    slikat(_7342,_7341,_7357),
    !,
    state(_7240,_7241,_7371,_7357,_7287).

prestatem(_7240,_7241,[prestatem,_7345,_7374,lit(det),_7419,_7443,_7472,!,_7501,_7535],_7328,_7330) --> 
    w(verb(_7281,_7282,fin),_7345,_7328,_7362),
    gmem(_7281,[have,be],_7374,_7362,_7393),
    cc(det,_7393,_7418),
    redundant0(_7419,_7418,_7434),
    w(verb(_7275,past,part),_7443,_7434,_7460),
    look_ahead_np(_7472,_7460,_7487),
    !,
    subject(_7300,_7301,_7501,_7487,_7520),
    pushstack(first,(xnp(_7300,_7301),w(verb(_7275,past,fin))),nil,_7520,_7576),
    state(_7240,_7241,_7535,_7576,_7330).

prestatem(_7240,_7241,[prestatem,_7330,_7354,_7388,_7417,!,_7456],_7313,_7315) --> 
    has(_7330,_7313,_7345),
    subject(_7270,_7271,_7354,_7345,_7373),
    w(verb(_7275,past,part),_7388,_7373,_7405),
    object(_7267,_7268,_7417,_7405,_7436),
    !,
    pushstack(first,(xnp(_7270,_7271),w(verb(_7275,past,fin)),xnp(_7267,_7268)),nil,_7436,_7528),
    state(_7240,_7241,_7456,_7528,_7315).

prestatem(_7240,_7241,[prestatem,_7348,{},_7387,_7421,_7450,!,_7489],_7331,_7333) --> 
    w(verb(_7275,_7276,fin),_7348,_7331,_7365),
    {user:(\+member(_7275,[]))},
    subject(_7286,_7287,_7387,_7365,_7406),
    not_look_ahead(w(verb(_7293,_7294,_7295)),_7421,_7406,_7438),
    object(_7270,_7271,_7450,_7438,_7469),
    !,
    pushstack(first,(xnp(_7286,_7287),w(verb(_7275,past,fin)),xnp(_7270,_7271)),nil,_7469,_7561),
    state(_7240,_7241,_7489,_7561,_7333).

prestatem(_7240,_7241,[prestatem,_7351,_7380,_7409,_7433,lit(det),_7473,_7497,!,_7531],_7334,_7336) --> 
    not_look_ahead(w(verb(be,_7283,_7284)),_7351,_7334,_7368),
    not_look_ahead(w(verb(be1,_7291,_7292)),_7380,_7368,_7397),
    so0(_7409,_7397,_7424),
    w(verb(_7296,_7297,fin),_7433,_7424,_7450),
    cc(det,_7450,_7472),
    not_look_ahead_np(_7473,_7472,_7488),
    negation0(_7276,_7497,_7488,_7514),
    !,
    pushstack(first,([dette],w(verb(_7296,_7297,fin)),negation(_7276)),nil,_7514,_7571),
    state(_7240,_7241,_7531,_7571,_7336).

prestatem(_7240,_7241,[prestatem,_7347,_7376,_7405,_7429,_7458,_7482,_7516,!,_7550],_7330,_7332) --> 
    not_look_ahead(w(verb(be,_7280,_7281)),_7347,_7330,_7364),
    not_look_ahead(w(verb(be1,_7288,_7289)),_7376,_7364,_7393),
    so0(_7405,_7393,_7420),
    w(verb(_7293,_7294,fin),_7429,_7420,_7446),
    det0(_7458,_7446,_7473),
    particlev0(_7293,_7298,_7482,_7473,_7501),
    negation0(_7273,_7516,_7501,_7533),
    !,
    pushstack(free,(w(verb(_7298,_7294,fin)),negation(_7273)),nil,_7533,_7590),
    state(_7240,_7241,_7550,_7590,_7332).

prestatem(_7240,_7241,[prestatem,_7348,_7372,{},_7411,_7435,!,_7469,_7503],_7331,_7333) --> 
    so0(_7348,_7331,_7363),
    w(verb(_7281,_7282,pass),_7372,_7363,_7389),
    {user:(\+testmember(_7281,[be]))},
    thereit0(_7411,_7389,_7426),
    negation0(_7294,_7435,_7426,_7452),
    !,
    object(_7276,_7277,_7469,_7452,_7488),
    pushstack(first,([noen],w(verb(_7281,_7282,fin)),negation(_7294),xnp(_7276,_7277)),nil,_7488,_7574),
    state(_7240,_7241,_7503,_7574,_7333).

prestatem(_7240,_7241,[prestatem,_7325,_7354,!,_7388,_7422],_7308,_7310) --> 
    w(verb(be,_7269,fin),_7325,_7308,_7342),
    negation0(_7264,_7354,_7342,_7371),
    !,
    subject(_7274,_7275,_7388,_7371,_7407),
    pushstack(first,(xnp(_7274,_7275),w(verb(be,_7269,fin)),negation(_7264)),nil,_7407,_7493),
    state(_7240,_7241,_7422,_7493,_7310).

prestatem(_7240,_7241,[prestatem,_7335,lit(kan),_7370,_7404,_7428,_7457,!,_7491],_7318,_7320) --> 
    so0(_7335,_7318,_7350),
    cc(kan,_7350,_7369),
    subject(_7278,_7279,_7370,_7369,_7389),
    redundant0(_7404,_7389,_7419),
    not_look_ahead(w(verb(_7285,_7286,_7287)),_7428,_7419,_7445),
    not_look_ahead([ikke],_7457,_7445,_7474),
    !,
    pushstack(free,(xnp(_7278,_7279),w(verb(do1,pres,fin))),nil,_7474,_7532),
    state(_7240,_7241,_7491,_7532,_7320).

prestatem(_7240,_7241,[prestatem,_7316,_7340,_7364,_7398,!,_7432],_7299,_7301) --> 
    so0(_7316,_7299,_7331),
    aux1(_7340,_7331,_7355),
    subject(_7269,_7270,_7364,_7355,_7383),
    negation0(_7267,_7398,_7383,_7415),
    !,
    pushstack(free,(xnp(_7269,_7270),aux1,negation(_7267)),nil,_7415,_7531),
    state(_7240,_7241,_7432,_7531,_7301).

itstatem(_7240,_7241,[itstatem,_7332,_7356,lit(at),_7401,!,_7440,_7474],_7315,_7317) --> 
    be(_7332,_7315,_7347),
    np0_accept(_7270,_7271,_7356,_7347,_7375),
    cc(at,_7375,_7400),
    traceprint(4,it00,_7401,_7400,_7420),
    !,
    clausal_object1(_7281,_7282,_7440,_7420,_7459),
    pushstack(first,(xnp(_7281,_7282),w(verb(be,pres,fin)),xnp(_7270,_7271)),nil,_7459,_7546),
    state(_7240,_7241,_7474,_7546,_7317).

itstatem(_7240,_7241,[itstatem,_7316,_7340,_7369,_7393,!,_7432],_7299,_7301) --> 
    be(_7316,_7299,_7331),
    not_look_ahead(w(adj2(_7271,_7272)),_7340,_7331,_7357),
    look_ahead_np(_7369,_7357,_7384),
    traceprint(4,it01,_7393,_7384,_7412),
    !,
    pushstack(free,w(verb(exist,pres,fin)),nil,_7412,_7442),
    state(_7240,_7241,_7432,_7442,_7301).

itstatem(_7240,_7241,[itstatem,_7320,{},_7359,_7383,!,_7422],_7303,_7305) --> 
    w(verb(_7263,_7264,fin),_7320,_7303,_7337),
    {user:_7263\==be},
    look_ahead_np(_7359,_7337,_7374),
    traceprint(4,it02,_7383,_7374,_7402),
    !,
    pushstack(free,w(verb(_7263,_7264,fin)),nil,_7402,_7432),
    state(_7240,_7241,_7422,_7432,_7305).

itstatem(_7240,_7241,[itstatem,_7347,_7376,{},_7435,_7469,!,_7508],_7330,_7332) --> 
    negation0(_7272,_7347,_7330,_7364),
    hlexv(_7274,_7275,_7276,fin,_7278,_7376,_7364,_7401),
    {user:bigno(_7272,_7278,_7270)},
    gmem(_7275,[help,give,make,create],_7435,_7401,_7454),
    traceprint(4,it0,_7469,_7454,_7488),
    !,
    pushstack(first,([dette],w(verb(_7275,_7276,fin)),negation(_7270)),nil,_7488,_7548),
    state(_7240,_7241,_7508,_7548,_7332).

itstatem(_7240,_7241,[itstatem,_7331,_7360,_7394,_7428,_7462],_7314,_7316) --> 
    w(verb(_7268,_7269,fin),_7331,_7314,_7348),
    gmem(_7268,[have],_7360,_7348,_7379),
    subject(_7277,_7278,_7394,_7379,_7413),
    traceprint(4,it1,_7428,_7413,_7447),
    pushstack(first,(xnp(_7277,_7278),w(verb(_7268,_7269,fin)),[dette]),nil,_7447,_7503),
    state(_7240,_7241,_7462,_7503,_7316).

itstatem(_7240,_7241,[itstatem,_7327,lit(at),_7387,_7411,!,_7450],_7310,_7312) --> 
    lexvaccept(rv,_7270,_7271,fin,_7267,_7327,_7310,_7352),
    cc(at,_7352,_7386),
    look_ahead_np(_7387,_7386,_7402),
    traceprint(4,it2,_7411,_7402,_7430),
    !,
    pushstack(first,([dette],w(verb(_7270,_7271,fin)),negation(_7267)),nil,_7430,_7490),
    state(_7240,_7241,_7450,_7490,_7312).

itstatem(_7240,_7241,[itstatem,_7367,_7391,_7415,_7444,_7473,_7502,lit(som),_7547,_7576,!,_7615,!,_7724],_7350,_7352) --> 
    be(_7367,_7350,_7382),
    redundant0(_7391,_7382,_7406),
    negation0(_7279,_7415,_7406,_7432),
    not_look_ahead(w(nb(_7285,_7286)),_7444,_7432,_7461),
    not_look_ahead_lit([jeg,du],_7473,_7461,_7490),
    np0_accept(_7294,_7295,_7502,_7490,_7521),
    cc(som,_7521,_7546),
    w(verb(_7301,_7302,fin),_7547,_7546,_7564),
    traceprint(4,it3,_7576,_7564,_7595),
    !,
    pushstack(first,(xnp(_7294,_7295),w(verb(_7301,_7302,fin)),negation(_7279)),nil,_7595,_7689),state(_7240,_7241,_7615,_7689,_7704),
    !,
    accept(_7724,_7704,_7352).

itstatem(_7240,_7241,[itstatem,_7370,_7394,_7428,_7457,_7486,_7515,_7544,!,_7583],_7353,_7355) --> 
    be(_7370,_7353,_7385),
    subject(_7287,_7288,_7394,_7385,_7413),
    negation0(_7290,_7428,_7413,_7445),
    not_look_ahead(noun(_7294,_7295,_7296,_7297),_7457,_7445,_7474),
    w(adj2(_7301,nil),_7486,_7474,_7503),
    w(prep(_7306),_7515,_7503,_7532),
    traceprint(4,it4,_7544,_7532,_7563),
    !,
    pushstack(first,(xnp(_7287,_7288),w(verb(be,pres,fin)),negation(_7290),w(adj2(_7301,nil)),w(prep(_7306)),[dette]),nil,_7563,_7654),
    state(_7240,_7241,_7583,_7654,_7355).

itstatem(_7240,_7241,[itstatem,_7339,_7363,_7397,_7426,_7455,!,_7494],_7322,_7324) --> 
    aux1(_7339,_7322,_7354),
    subject(_7275,_7276,_7363,_7354,_7382),
    negation0(_7278,_7397,_7382,_7414),
    w(verb(_7282,_7283,fin),_7426,_7414,_7443),
    traceprint(4,it5,_7455,_7443,_7474),
    !,
    pushstack(first,(xnp(_7275,_7276),w(verb(_7282,pres,fin)),negation(_7278),[dette]),nil,_7474,_7565),
    state(_7240,_7241,_7494,_7565,_7324).

itstatem(_7240,_7241,[itstatem,_7358,_7387,_7416,lit('å'),_7456,!,_7495,_7538],_7341,_7343) --> 
    be(_7281,_7358,_7341,_7375),
    gradverb0(_7283,_7387,_7375,_7404),
    w(adj2(_7278,_7279),_7416,_7404,_7433),
    cc('å',_7433,_7455),
    traceprint(4,it7,_7456,_7455,_7475),
    !,
    pushstack(first,([jeg],[vil]),nil,_7475,_7508),clausal_object1(_7303,_7304,_7495,_7508,_7523),
    pushstack(first,(xnp(_7303,_7304),w(verb(be,pres,fin)),negation(_7281),w(adj2(_7278,_7279))),nil,_7523,_7609),
    state(_7240,_7241,_7538,_7609,_7343).

itstatem(_7240,_7241,[itstatem,_7339,_7368,_7412,_7451,!,_7490],_7322,_7324) --> 
    be(_7275,_7339,_7322,_7356),
    ap(_7270,_7271,_7240,_7273,_7368,_7356,_7391),
    pp(with,_7283,_7284,_7412,_7391,_7433),
    traceprint(4,it8,_7451,_7433,_7470),
    !,
    pushstack(first,(xnp(_7283,_7284),w(verb(be,pres,fin)),negation(_7275),ap(_7270,_7271,_7240,_7273)),nil,_7470,_7594),
    state(_7240,_7241,_7490,_7594,_7324).

itstatem(_7240,_7241,[itstatem,_7348,_7377,_7406,lit(at),_7446,!,_7485,_7519],_7331,_7333) --> 
    be(_7281,_7348,_7331,_7365),
    gradverb0(_7283,_7377,_7365,_7394),
    w(adj2(_7278,_7279),_7406,_7394,_7423),
    cc(at,_7423,_7445),
    traceprint(4,it9,_7446,_7445,_7465),
    !,
    clausal_object1(_7295,_7296,_7485,_7465,_7504),
    pushstack(first,(xnp(_7295,_7296),w(verb(be,pres,fin)),negation(_7281),w(adj2(_7278,_7279))),nil,_7504,_7590),
    state(_7240,_7241,_7519,_7590,_7333).

itstatem(_7240,_7241,[itstatem,_7375,_7404,_7433,_7462,_7491,lit('å'),_7536,!,_7575,_7599,_7673],_7358,_7360) --> 
    be(_7290,_7375,_7358,_7392),
    gradverb0(_7292,_7404,_7392,_7421),
    w(adj2(_7287,_7288),_7433,_7421,_7450),
    w(prep(for),_7462,_7450,_7479),
    object(_7303,_7304,_7491,_7479,_7510),
    cc('å',_7510,_7535),
    traceprint(4,it10,_7536,_7535,_7555),
    !,
    accept(_7575,_7555,_7590),
    pushstack(first,(xnp(_7303,_7304),[vil]),nil,_7590,_7643),clausal_object1(_7319,_7320,_7599,_7643,_7658),
    pushstack(first,(xnp(_7319,_7320),w(verb(be,pres,fin)),negation(_7290),w(adj2(_7287,_7288))),nil,_7658,_7744),
    state(_7240,_7241,_7673,_7744,_7360).

itstatem(_7240,_7241,[itstatem,_7365,_7394,_7423,lit('å'),_7473,!,_7512,_7536,_7579],_7348,_7350) --> 
    be(_7286,_7365,_7348,_7382),
    w(adj2(_7290,_7291),_7394,_7382,_7411),
    pp(_7282,_7283,_7284,_7423,_7411,_7444),
    cc('å',_7444,_7472),
    traceprint(4,it11,_7473,_7472,_7492),
    !,
    accept(_7512,_7492,_7527),
    pushstack(first,[noen],nil,_7527,_7549),clausal_object1(_7307,_7308,_7536,_7549,_7564),
    pushstack(first,(xnp(_7307,_7308),w(verb(be,pres,fin)),negation(_7286),w(adj2(_7290,_7291)),pp(_7282,_7283,_7284)),nil,_7564,_7682),
    state(_7240,_7241,_7579,_7682,_7350).

itstatem(_7240,_7241,[itstatem,_7377,_7406,lit('å'),_7461,_7490,_7519,!,_7558,_7601],_7360,_7362) --> 
    be(_7284,_7377,_7360,_7394),
    adj1(_7279,_7291:_7292,_7281,_7282,_7406,_7394,_7429),
    cc('å',_7429,_7460),
    w(verb(_7298,inf,fin),_7461,_7460,_7478),
    reflexiv0(_7298,_7490,_7478,_7507),
    traceprint(4,it12,_7519,_7507,_7538),
    !,
    pushstack(first,([noen],w(verb(_7298,pres,fin))),nil,_7538,_7571),clausal_object1(_7319,_7320,_7558,_7571,_7586),
    pushstack(first,(xnp(_7319,_7320),w(verb(be,pres,fin)),negation(_7284),adj1(_7279,_7291:_7339,_7281,_7282)),nil,_7586,_7708),
    state(_7240,_7241,_7601,_7708,_7362).

itstatem(_7240,_7241,[itstatem,_7334,_7363,_7407,_7431,!,_7470],_7317,_7319) --> 
    be(_7275,_7334,_7317,_7351),
    adj1(_7270,_7271,_7272,_7273,_7363,_7351,_7386),
    not_look_ahead_np(_7407,_7386,_7422),
    traceprint(4,it13,_7431,_7422,_7450),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_7275),adj1(_7270,_7271,_7272,_7273)),nil,_7450,_7541),
    state(_7240,_7241,_7470,_7541,_7319).

itstatem(_7240,_7243::_7244,[itstatem,_7371,_7395,_7419,_7443,_7472,_7501,_7530,_7559,lit(som),_7604,_7638,!,_7747],_7354,_7356) --> 
    be(_7371,_7354,_7386),
    preadverbials0(_7395,_7386,_7410),
    redundant0(_7419,_7410,_7434),
    negation0(_7282,_7443,_7434,_7460),
    not_look_ahead(w(nb(_7288,_7289)),_7472,_7460,_7489),
    not_look_ahead_lit([jeg,du],_7501,_7489,_7518),
    not_look_ahead([det],_7530,_7518,_7547),
    np1_accept(_7301,_7302,_7559,_7547,_7578),
    cc(som,_7578,_7603),
    traceprint(4,it14a,_7604,_7603,_7623),
    pushstack(first,(xnp(_7301,_7302),w(verb(be,pres,fin)),negation(_7282)),nil,_7623,_7712),state(_7240,_7243::_7244,_7638,_7712,_7727),
    !,
    accept(_7747,_7727,_7356).

itstatem(_7240,_7241,[itstatem,_7321,_7345,_7374,_7398,!,_7437],_7304,_7306) --> 
    be(_7321,_7304,_7336),
    negation0(_7267,_7345,_7336,_7362),
    not_look_ahead_np(_7374,_7362,_7389),
    traceprint(4,it14b,_7398,_7389,_7417),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin)),negation(_7267)),nil,_7417,_7477),
    state(_7240,_7241,_7437,_7477,_7306).

itstatem(_7240,_7241,[itstatem,_7336,_7365,lit(med),_7410,_7444,!,_7483],_7319,_7321) --> 
    w(verb(_7269,_7270,fin),_7336,_7319,_7353),
    gmem(_7269,[help,function],_7365,_7353,_7384),
    cc(med,_7384,_7409),
    np0_accept(_7288,_7289,_7410,_7409,_7429),
    traceprint(4,it15,_7444,_7429,_7463),
    !,
    pushstack(first,(xnp(_7288,_7289),w(verb(_7269,_7270,fin))),nil,_7463,_7524),
    state(_7240,_7241,_7483,_7524,_7321).

itstatem(_7240,_7241,[itstatem,_7358,_7387,_7421,lit('å'),_7466,!,_7505,_7548],_7341,_7343) --> 
    w(verb(_7278,_7279,fin),_7358,_7341,_7375),
    gmem(_7278,[cost,take],_7387,_7375,_7406),
    np0_accept(_7273,_7274,_7421,_7406,_7440),
    cc('å',_7440,_7465),
    traceprint(4,it16,_7466,_7465,_7485),
    !,
    pushstack(first,([noen],[vil]),nil,_7485,_7518),clausal_object1(_7305,_7306,_7505,_7518,_7533),
    pushstack(first,(xnp(_7305,_7306),w(verb(_7278,_7279,fin)),xnp(_7273,_7274)),nil,_7533,_7620),
    state(_7240,_7241,_7548,_7620,_7343).

itstatem(_7240,_7243::_7244,[itstatem,_7329,_7358,_7382,_7411,_7435,_7459,_7493,{}],_7312,_7314) --> 
    w(verb(go,pres,fin),_7329,_7312,_7346),
    redundants0(_7358,_7346,_7373),
    negation0(_7269,_7382,_7373,_7399),
    ann0(_7411,_7399,_7426),
    infinitive(_7435,_7426,_7450),
    traceprint(4,it17,_7459,_7450,_7478),
    pushstack(first,someone,nil,_7478,_7534),state(_7240,_7243::_7270,_7493,_7534,_7314),
    {user:negate(_7269,_7270,_7244)}.

itstatem(_7240,_7241,[itstatem,_7351,_7380,{},_7439,_7483,_7507,!,_7546],_7334,_7336) --> 
    negation0(_7281,_7351,_7334,_7368),
    hlexv(_7283,go,_7285,fin,_7287,_7380,_7368,_7405),
    {user:bigno(_7281,_7287,_7293)},
    optional([an],_7439,_7405,_7471),
    not_look_ahead_np(_7483,_7471,_7498),
    traceprint(4,it17b,_7507,_7498,_7526),
    !,
    pushstack(first,([dette],w(verb(be,_7285,fin)),negation(_7293),w(adj2(possible,nil))),nil,_7526,_7586),
    state(_7240,_7241,_7546,_7586,_7336).

itstatem(_7240,_7241,[itstatem,_7360,_7389,{},{},_7458,_7482,_7506,!,_7545,_7579],_7343,_7345) --> 
    negation0(_7281,_7360,_7343,_7377),
    hlexv(_7283,_7284,_7285,fin,_7287,_7389,_7377,_7414),
    {user:bigno(_7281,_7287,_7279)},
    {user:(\+testmember(_7284,[cost,take]))},
    preadverbials0(_7458,_7414,_7473),
    look_ahead_np(_7482,_7473,_7497),
    traceprint(4,it18,_7506,_7497,_7525),
    !,
    subject(_7309,_7310,_7545,_7525,_7564),
    pushstack(first,(xnp(_7309,_7310),w(verb(_7284,_7285,fin)),negation(_7279)),nil,_7564,_7650),
    state(_7240,_7241,_7579,_7650,_7345).

itstatem(_7240,_7241,[itstatem,_7336,lit('å'),_7376,!,_7415,_7458],_7319,_7321) --> 
    w(verb(_7266,_7267,fin),_7336,_7319,_7353),
    cc('å',_7353,_7375),
    traceprint(4,it19,_7376,_7375,_7395),
    !,
    pushstack(first,([noen],[vil]),nil,_7395,_7428),clausal_object1(_7289,_7290,_7415,_7428,_7443),
    pushstack(first,(xnp(_7289,_7290),w(verb(_7266,_7267,fin))),nil,_7443,_7499),
    state(_7240,_7241,_7458,_7499,_7321).

itstatem(_7240,_7241,[itstatem,_7343,_7367,_7391,_7420,lit(at),_7460,!,_7499,_7523],_7326,_7328) --> 
    blei(_7343,_7326,_7358),
    redundant0(_7367,_7358,_7382),
    negation0(_7281,_7391,_7382,_7408),
    w(verb(_7285,past,part),_7420,_7408,_7437),
    cc(at,_7437,_7459),
    traceprint(4,it20,_7460,_7459,_7479),
    !,
    accept(_7499,_7479,_7514),
    pushstack(first,([noen],w(verb(_7285,past,fin)),negation(_7281),[at]),nil,_7514,_7563),
    state(_7240,_7241,_7523,_7563,_7328).

itstatem(_7240,_7241,[itstatem,_7363,_7387,_7426,_7450,_7479,_7508,_7542,!,_7581,_7605],_7346,_7348) --> 
    blei(_7363,_7346,_7378),
    preadverbial0(_7285,_7286,_7287,_7387,_7378,_7408),
    redundant0(_7426,_7408,_7441),
    negation0(_7293,_7450,_7441,_7467),
    w(verb(_7297,past,part),_7479,_7467,_7496),
    object(_7301,_7302,_7508,_7496,_7527),
    traceprint(4,it21,_7542,_7527,_7561),
    !,
    accept(_7581,_7561,_7596),
    pushstack(first,(xnp(_7301,_7302),w(verb(be,pres,fin)),negation(_7293),w(verb(_7297,past,part)),adverbial1(_7285,_7286,_7287)),nil,_7596,_7708),
    state(_7240,_7241,_7605,_7708,_7348).

itstatem(_7240,_7241,[itstatem,_7324,_7353,_7382,!,_7421],_7307,_7309) --> 
    w(verb(_7268,_7269,pass),_7324,_7307,_7341),
    negation0(_7264,_7353,_7341,_7370),
    traceprint(4,it23,_7382,_7370,_7401),
    !,
    pushstack(first,([noen],w(verb(_7268,_7269,fin)),negation(_7264)),nil,_7401,_7461),
    state(_7240,_7241,_7421,_7461,_7309).

itstatem(_7240,_7241,[itstatem,_7359,_7388,_7412,{},_7451,_7475,!,_7514],_7342,_7344) --> 
    w(verb(be,_7284,fin),_7359,_7342,_7376),
    redundant0(_7388,_7376,_7403),
    w(adj2(_7278,nil),_7412,_7403,_7429),
    {user:testmember(_7278,[certain,uncertain,good,bad])},
    atom(_7451,_7429,_7466),
    traceprint(4,it24,_7475,_7466,_7494),
    !,
    pushstack(first,state(_7240,_7241)\(xnp(_7308,_7309),w(verb(be,_7284,fin)),w(adj2(_7278,nil))),nil,_7494,_7557),
    clausal_object1(_7308,_7309,_7514,_7557,_7344).

atom([atom,lit(at)],_7257,_7259) --> 
    cc(at,_7257,_7259).

atom([atom,lit(om)],_7257,_7259) --> 
    cc(om,_7257,_7259).

itstatem(_7240,_7241,[itstatem,_7381,_7410,_7434,lit('å'),_7474,_7503,_7532,_7556,!,_7595,_7638],_7364,_7366) --> 
    w(verb(be,_7290,fin),_7381,_7364,_7398),
    redundant0(_7410,_7398,_7425),
    w(adj2(_7284,nil),_7434,_7425,_7451),
    cc('å',_7451,_7473),
    w(verb(_7302,inf,fin),_7474,_7473,_7491),
    reflexiv0(_7302,_7503,_7491,_7520),
    not_look_ahead_np(_7532,_7520,_7547),
    traceprint(4,it25,_7556,_7547,_7575),
    !,
    pushstack(first,([noen],w(verb(_7302,pres,fin)),[dette]),nil,_7575,_7608),clausal_object1(_7322,_7323,_7595,_7608,_7623),
    pushstack(first,(xnp(_7322,_7323),w(verb(be,_7290,fin)),w(adj2(_7284,nil))),nil,_7623,_7679),
    state(_7240,_7241,_7638,_7679,_7366).

itstatem(_7240,_7241,[itstatem,_7338,_7367,_7396,_7425,!,_7464],_7321,_7323) --> 
    w(verb(be,_7277,fin),_7338,_7321,_7355),
    negation0(_7280,_7367,_7355,_7384),
    w(prep(_7272),_7396,_7384,_7413),
    traceprint(4,it26,_7425,_7413,_7444),
    !,
    pushstack(first,([dette],w(verb(be,_7277,fin)),negation(_7280),w(prep(_7272))),nil,_7444,_7504),
    state(_7240,_7241,_7464,_7504,_7323).

itstatem(_7240,_7241,[itstatem,_7368,_7397,lit('å'),_7437,_7466,!,_7505,!,_7553],_7351,_7353) --> 
    w(verb(be,pres,fin),_7368,_7351,_7385),
    w(adj2(_7278,nil),_7397,_7385,_7414),
    cc('å',_7414,_7436),
    w(verb(_7296,inf,fin),_7437,_7436,_7454),
    traceprint(4,it27,_7466,_7454,_7485),
    !,
    pushstack(first,([jeg],w(verb(_7296,pres,fin))),nil,_7485,_7518),clausal_object1(_7315,_7316,_7505,_7518,_7533),
    !,
    pushstack(first,(xnp(_7315,_7316),w(verb(be,pres,fin)),w(adj2(_7278,nil))),nil,_7533,_7594),
    state(_7240,_7241,_7553,_7594,_7353).

itstatem(_7240,_7241,[itstatem,_7334,{},_7373,_7407,!,_7446],_7317,_7319) --> 
    w(verb(_7271,_7272,fin),_7334,_7317,_7351),
    {user:verbtype(_7271,rv)},
    subject(_7280,_7281,_7373,_7351,_7392),
    traceprint(4,it28,_7407,_7392,_7426),
    !,
    pushstack(first,(xnp(_7280,_7281),w(verb(_7271,pres,fin)),[dette]),nil,_7426,_7487),
    state(_7240,_7241,_7446,_7487,_7319).

itstatem(_7240,_7241,[itstatem,_7375,_7404,_7438,_7462,_7491,{},lit(noe),lit(om),_7552,_7586],_7358,_7360) --> 
    w(verb(have,_7293,fin),_7375,_7358,_7392),
    subject(_7296,_7297,_7404,_7392,_7423),
    redundant0(_7438,_7423,_7453),
    negation0(_7299,_7462,_7453,_7479),
    w(verb(_7303,past,part),_7491,_7479,_7508),
    {user:testmember(_7303,[tell])},
    cc(noe,_7508,_7540),
    cc(om,_7540,_7551),
    traceprint(4,it29,_7552,_7551,_7571),
    pushstack(first,(xnp(_7296,_7297),w(verb(_7303,past,fin)),negation(_7299),[noe],[om],[det]),nil,_7571,_7657),
    state(_7240,_7241,_7586,_7657,_7360).

itstatem(_7240,_7241,[itstatem,_7329,{},_7368,!,_7407],_7312,_7314) --> 
    w(verb(_7263,_7270,fin),_7329,_7312,_7346),
    {user:testmember(_7263,[concern])},
    traceprint(4,it30,_7368,_7346,_7387),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_7263,pres,fin))),nil,_7387,_7417),
    state(_7240,_7241,_7407,_7417,_7314).

itstatem(_7240,_7241,[itstatem,_7356,{},_7395,_7424,_7468,!,_7507],_7339,_7341) --> 
    w(verb(_7276,_7277,fin),_7356,_7339,_7373),
    {user:testmember(_7276,[go,look,see,function])},
    w(adv(_7272),_7395,_7373,_7412),
    optional([ut],_7424,_7412,_7456),
    traceprint(4,it31,_7468,_7456,_7487),
    !,
    pushstack(first,(w(noun(thing,sin,u,n)),w(verb(_7276,pres,fin)),w(adv(_7272))),nil,_7487,_7517),
    state(_7240,_7241,_7507,_7517,_7341).

itstatem(_7240,_7243::_7244,[itstatem,_7333,{},_7372,!,_7411],_7316,_7318) --> 
    w(verb(_7265,_7272,fin),_7333,_7316,_7350),
    {user:testmember(_7265,[rain,snow,look,be_urgent])},
    traceprint(4,it32,_7372,_7350,_7391),
    !,
    pushstack(first,(something,lexv(iv,_7265,pres,fin)),nil,_7391,_7485),
    state(_7240,_7243::_7244,_7411,_7485,_7318).

itstatem(_7240,_7243::_7244,[itstatem,_7320,{},_7364,_7398],_7303,_7305) --> 
    pvimodal(_7260,_7265,_7320,_7303,_7339),
    {user:constrainit(_7269,thing)},
    traceprint(4,it32,_7364,_7339,_7383),
    pushstack(first,w(verb(_7260,pres,fin)),nil,_7383,_7408),
    verb_phrase1(_7260,_7269,id,_7240,_7243::_7244,_7398,_7408,_7305).

itstatem(_7240,_7243::_7244,[itstatem,_7330,_7364,_7398,_7432,{}],_7313,_7315) --> 
    beginverb(_7264,_7260,_7330,_7313,_7349),
    np1(_7267,_7268,_7364,_7349,_7383),
    traceprint(4,it33,_7398,_7383,_7417),
    pushstack(first,(np1(_7267,_7268),w(verb(_7264,pres,fin))),nil,_7417,_7478),state(_7240,_7243::_7261,_7432,_7478,_7315),
    {user:negate(_7260,_7261,_7244)}.

itstatem(_7240,_7243::_7244,[itstatem,_7320,_7344,_7383,_7407,_7441],_7303,_7305) --> 
    be(_7320,_7303,_7335),
    adverbial(_7261,_7262,_7265::_7266,_7344,_7335,_7365),
    that(_7383,_7365,_7398),
    traceprint(4,it34,_7407,_7398,_7426),
    lock(last,_7426,_7491),
    pushstack(last,adverbial(_7261,_7262,_7265::_7266),nil,_7491,_7497),
    state(_7240,_7243::_7244,_7441,_7497,_7486),
    unlock(_7486,_7305).

itstatem(_7240,_7243::_7244,[itstatem,_7339,_7363,_7392,_7416,_7445,_7474,_7503,!,_7542,_7566],_7322,_7324) --> 
    be(_7339,_7322,_7354),
    negation0(_7279,_7363,_7354,_7380),
    saa0(_7392,_7380,_7407),
    not_look_ahead(w(verb(_7285,past,part)),_7416,_7407,_7433),
    w(adj2(_7291,nil),_7445,_7433,_7462),
    one_of_lit([at,om],_7474,_7462,_7491),
    traceprint(4,it35,_7503,_7491,_7522),
    !,
    accept(_7542,_7522,_7557),
    statem(_7240,_7243::_7244,_7566,_7557,_7324).

itstatem(_7240,_7243::_7244,[itstatem,_7335,_7359,_7388,_7412,{},_7451,_7480,_7514],_7318,_7320) --> 
    be(_7335,_7318,_7350),
    negation0(_7273,_7359,_7350,_7376),
    saa0(_7388,_7376,_7403),
    w(adj2(_7277,nil),_7412,_7403,_7429),
    {user:testmember(_7277,[good])},
    not_look_ahead(w(noun(_7291,_7292,_7293,_7294)),_7451,_7429,_7468),
    traceprint(4,it36,_7480,_7468,_7499),
    statem(_7240,_7243::_7244,_7514,_7499,_7320).

itstatem(_7240,_7243::_7244,[itstatem,_7382,{},_7421,_7445,_7474,{},_7513,_7547,{}],_7365,_7367) --> 
    be(_7272,_7382,_7365,_7399),
    {user:it_template(_7280)},
    so0(_7421,_7399,_7436),
    gradverb0(_7282,_7445,_7436,_7462),
    w(adj2(_7286,nil),_7474,_7462,_7491),
    {user:testmember(_7286,[difficult,easy,expensive,free,funny,good,intelligent,mild,hot,cold,wet,dark,bright,cloudy,sad,stupid,tedious])},
    traceprint(4,it37,_7513,_7491,_7532),
    pushstack(first,w(adj2(_7286,nil)),nil,_7532,_7560),be_complements(_7280,_7240,_7243::_7273,_7547,_7560,_7367),
    {user:negate(_7272,_7273,_7244)}.

itstatem(_7240,_7243::_7244,[itstatem,_7346,{},_7400,_7429,_7468,!,_7507],_7329,_7331) --> 
    lexv(iv,_7277,_7278,fin,_7346,_7329,_7369),
    {user:(\+testmember(_7277,be))},
    negation0(_7288,_7400,_7369,_7417),
    adverb(_7273,_7274,_7292,_7429,_7417,_7450),
    traceprint(4,it38,_7468,_7450,_7487),
    !,
    pushstack(free,(lexv(iv,_7277,_7278,fin),negation(_7288),xadverb(_7273,_7274)),nil,_7487,_7609),
    state(_7240,_7243::_7244,_7507,_7609,_7331).

itstatem(_7240,_7241,[itstatem,_7325,_7354,_7388,!,_7427,!],_7308,_7310) --> 
    be(_7258,_7325,_7308,_7342),
    subject(_7260,_7261,_7354,_7342,_7373),
    traceprint(4,it39,_7388,_7373,_7407),
    !,
    pushstack(first,(xnp(_7260,_7261),w(verb(exist,pres,fin)),negation(_7258)),nil,_7407,_7501),state(_7240,_7241,_7427,_7501,_7310),
    !.

statreal(_7240,[statreal,_7276],_7262,_7264) --> 
    stat(real,_7240,_7276,_7262,_7264).

stat(_7240,_7241,[stat,_7296,_7330],_7279,_7281) --> 
    state(_7247,_7254::_7255,_7296,_7279,_7315),
    worldcomp(_7240,_7247,_7254::_7255,_7241,_7330,_7315,_7281).

statreal1(_7240,[statreal1,_7284,_7318],_7270,_7272) --> 
    state1(_7246,_7247,_7284,_7270,_7303),
    worldcomp(real,_7246,_7247,_7240,_7318,_7303,_7272).

state1(_7240,_7243::_7244,[state1,_7331,_7365,_7394,!,_7423,{},{},!],_7314,_7316) --> 
    np(_7267,_7270::_7244,_7331,_7314,_7350),
    negation0(_7273,_7365,_7350,_7382),
    redundant0(_7394,_7382,_7409),
    !,
    vp(_7267,_7276,_7240,_7243::_7281,_7423,_7409,_7316),
    {user:bigno(_7273,_7276,_7287)},
    {user:negate(_7287,_7281,_7270)},
    !.

substate(_7240,_7243::_7244,[substate,_7328,_7362,_7386,!,_7420,{},{}],_7311,_7313) --> 
    subject(_7270,_7268::_7244,_7328,_7311,_7347),
    preadverbials0(_7362,_7347,_7377),
    negation0(_7276,_7386,_7377,_7403),
    !,
    vp(_7270,_7279,_7240,_7243::_7267,_7420,_7403,_7313),
    {user:bigno(_7276,_7279,_7266)},
    {user:negate(_7266,_7267,_7268)}.

state(_7240,_7243::_7244,[state,_7325,_7359,_7383,_7412,{},{}],_7308,_7310) --> 
    subject(_7267,_7265::_7244,_7325,_7308,_7344),
    redundant0(_7359,_7344,_7374),
    negation0(_7273,_7383,_7374,_7400),
    vp(_7267,_7276,_7240,_7243::_7264,_7412,_7400,_7310),
    {user:bigno(_7273,_7276,_7263)},
    {user:negate(_7263,_7264,_7265)}.

beginverb(_7240,_7241,[beginverb,_7302,_7331,_7360,_7384],_7285,_7287) --> 
    w(verb(start,_7261,fin),_7302,_7285,_7319),
    negation0(_7241,_7331,_7319,_7348),
    infinitiveand(_7360,_7348,_7375),
    w(verb(_7240,_7255,fin),_7384,_7375,_7287).

question(_7240,[question,_7315,_7344,!,_7373],_7301,_7303) --> 
    w(noun(clock,sin,_7271,n),_7315,_7301,_7332),
    terminator(_7344,_7332,_7359),
    !,
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(clock,sin,def,n))),nil,_7359,_7383),
    whatq(_7240,_7373,_7383,_7303).

question(_7240,[question,_7275],_7261,_7263) --> 
    whichq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    whoq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    whenq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    howadjq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    whereq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    wherefromq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    whatq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    howmuchq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    whyq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    howq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    ppq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7275],_7261,_7263) --> 
    whoseq(_7240,_7275,_7261,_7263).

question(_7240,[question,_7324,_7348,!,_7382,_7416,!,_7445],_7310,_7312) --> 
    be(_7324,_7310,_7339),
    w(noun(clock,_7282,_7283,_7284),_7348,_7339,_7365),
    !,
    np1(_7286,_7287,_7382,_7365,_7401),
    danow0(_7416,_7401,_7431),
    !,
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_7431,_7514),
    whatq(_7240,_7445,_7514,_7312).

question(_7240,[question,_7275],_7261,_7263) --> 
    question1(_7240,_7275,_7261,_7263).

question1(test:::_7243,[question1,lit('får'),_7314,!,_7353],_7289,_7291) --> 
    cc('får',_7289,_7313),
    specific_phrase(_7264,_7265,_7314,_7313,_7333),
    !,
    pushstack(first,(np(_7264,_7265),['får']),nil,_7333,_7394),
    statement(_7243,_7353,_7394,_7291).

question1(new:::_7243,[question1,_7332,_7361,{},_7400,!,_7434],_7318,_7320) --> 
    w(verb(have,pres,fin),_7332,_7318,_7349),
    w(verb(_7268,past,part),_7361,_7349,_7378),
    {user:testmember(_7268,[want,think])},
    not_look_ahead([du],_7400,_7378,_7417),
    !,
    pushstack(first,([jeg],w(verb(_7268,pres,fin))),nil,_7417,_7444),
    statement(_7243,_7434,_7444,_7320).

question1(new:::_7243,[question1,_7331,{},_7370,_7404,!,_7438],_7317,_7319) --> 
    w(verb(_7274,pres,fin),_7331,_7317,_7348),
    {user:testmember(_7274,[want,think,hope])},
    particlev0(_7274,_7268,_7370,_7348,_7389),
    not_look_ahead([du],_7404,_7389,_7421),
    !,
    pushstack(first,([jeg],w(verb(_7268,pres,fin))),nil,_7421,_7448),
    statement(_7243,_7438,_7448,_7319).

question1(test:::_7243,[question1,_7278],_7264,_7266) --> 
    question0(_7243,_7278,_7264,_7266).

np_question(which(_7245):::_7243,[np_question,_7284],_7270,_7272) --> 
    np1(_7245,true::_7243,_7284,_7270,_7272).

question0(_7240,[question0,_7275],_7261,_7263) --> 
    isq(_7240,_7275,_7261,_7263).

question0(_7240,[question0,_7275],_7261,_7263) --> 
    ynqs(_7240,_7275,_7261,_7263).

question0(_7240,[question0,_7275],_7261,_7263) --> 
    hasq(_7240,_7275,_7261,_7263).

question0(_7240,[question0,_7278,_7302],_7264,_7266) --> 
    hoq(_7278,_7264,_7293),
    statement(_7240,_7302,_7293,_7266).

implicitq(new:::_7243,[implicitq,_7397,{},_7436,{},{},lit(som),_7496,_7520,_7563,!,_7602,_7626,!,_7680],_7383,_7385) --> 
    w(prep(_7286),_7397,_7383,_7414),
    {user:testmember(_7286,[from,to])},
    w(name(_7299,n,_7301),_7436,_7414,_7453),
    {user:testmember(_7301,[station,neighbourhood])},
    {user:no_unprotected_verb},
    cc(som,_7453,_7495),
    look_ahead_vp(_7496,_7495,_7511),
    pushstack(first,(w(noun(bus,sin,u,n)),w(prep(_7286)),w(name(_7299,n,_7301))),nil,_7511,_7533),np1_accept(_7331,_7334::_7243,_7520,_7533,_7548),
    traceprint(4,iq00,_7563,_7548,_7582),
    !,
    accept(_7602,_7582,_7617),
    verb_phrase1(_7351,_7331,id,_7354,event/real/_7354::_7334,_7626,_7617,_7651),
    !,
    accept(_7680,_7651,_7385).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,_7385,lit('når'),{},_7435,_7464,_7508,{},_7547,!,{},_7596,_7635],_7371,_7373) --> 
    not_look_ahead([nr],_7385,_7371,_7402),
    cc('når',_7402,_7424),
    {user:(\+user:value(dialog,1))},
    w(verb(go,_7311,fin),_7435,_7424,_7452),
    optional([neste],_7464,_7452,_7496),
    w(name(_7288,n,_7290),_7508,_7496,_7525),
    {user:testmember(_7290,[station,neighbourhood])},
    traceprint(4,iq01,_7547,_7525,_7566),
    !,
    {user:setvartype(_7338,vehicle)},
    realcomp(_7248,_7342,_7246,_7596,_7566,_7617),
    pushstack(first,w(name(_7288,n,_7290)),nil,_7617,_7645),
    verb_modifiers(go,_7338,_7248,_7245::true,_7342,_7635,_7645,_7373).

implicitq(_7240,[implicitq,_7343,lit('når'),{},{},_7403,{},!,_7447,_7471,_7505],_7329,_7331) --> 
    not_look_ahead([nr],_7343,_7329,_7360),
    cc('når',_7360,_7382),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    look_ahead(w(name(_7298,_7299,_7300)),_7403,_7382,_7420),
    {user:subclass0(_7300,place)},
    !,
    accept(_7447,_7420,_7462),
    traceprint(4,iq2,_7471,_7462,_7490),
    pushstack(first,w(prep(to)),nil,_7490,_7515),
    implicitq(_7240,_7505,_7515,_7331).

implicitq(test:::_7243,[implicitq,{},_7344,lit('når'),lit(nr),{},!,_7410,_7434,_7468],_7320,_7322) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead([nr],_7344,_7320,_7361),
    cc('når',_7361,_7383),
    cc(nr,_7383,_7394),
    {user:no_unprotected_verb},
    !,
    accept(_7410,_7394,_7425),
    traceprint(4,iq3,_7434,_7425,_7453),
    pushstack(first,w(verb(go,pres,fin)),nil,_7453,_7478),
    ynq(_7243,_7468,_7478,_7322).

implicitq(test:::_7243,[implicitq,_7336,lit('når'),{},{},_7396,!,_7445,_7469,_7503],_7322,_7324) --> 
    not_look_ahead([nr],_7336,_7322,_7353),
    cc('når',_7353,_7375),
    {user:(\+user:value(dialog,1))},
    {user:no_unprotected_verb},
    optional([det],_7396,_7375,_7428),
    !,
    accept(_7445,_7428,_7460),
    traceprint(4,iq4,_7469,_7460,_7488),
    pushstack(first,w(verb(go,pres,fin)),nil,_7488,_7513),
    ynq(_7243,_7503,_7513,_7324).

implicitq(_7240,[implicitq,_7279,!,_7308],_7265,_7267) --> 
    reject_implicitq(_7279,_7265,_7294),
    !,
    reject(_7308,_7294,_7267).

implicitq(new:::_7243,[implicitq,_7402,{},{},_7451,{},{},_7505,_7534,_7563,_7592,!,_7621,_7645,_7679,_7737,_7781,!,_7810],_7388,_7390) --> 
    look_ahead(w(noun(_7300,sin,u,n)),_7402,_7388,_7419),
    {user:subclass0(_7300,vehicle)},
    {user:no_unprotected_verb},
    np1_accept(_7312,_7315::_7243,_7451,_7419,_7470),
    {user:(\+vartypeid(_7312,time))},
    {user:(\+vartypeid(_7312,clock))},
    constrainvehdep(_7312,_7505,_7470,_7522),
    not_look_ahead([som],_7534,_7522,_7551),
    not_look_ahead([om],_7563,_7551,_7580),
    point0(_7592,_7580,_7607),
    !,
    accept(_7621,_7607,_7636),
    traceprint(4,iq4b,_7645,_7636,_7664),
    pushstack(first,w(verb(go,pres,fin)),nil,_7664,_7692),verb_phrase1(go,_7312,id,_7357,event/real/_7357::_7315,_7679,_7692,_7713),
    optional(itrailer,_7737,_7713,_7769),
    endofline(_7781,_7769,_7796),
    !,
    accept(_7810,_7796,_7390).

implicitq(which(_7245):::_7243,[implicitq,{},_7375,_7404,_7433,_7472,!,_7501,_7535,!,_7629],_7351,_7353) --> 
    {user:value(teleflag,true)},
    w(noun(_7284,_7285,_7286,n),_7375,_7351,_7392),
    not_look_ahead(w(prep(_7293)),_7404,_7392,_7421),
    person_name(_7299:person,_7296,_7297,_7433,_7421,_7454),
    endofline(_7472,_7454,_7487),
    !,
    traceprint(4,iq5,_7501,_7487,_7520),
    lock(exact,_7520,_7588),pushstack(exact,(w(noun(_7284,sin,u,n)),w(prep(to)),nameq1(_7299:person,_7296)),nil,_7588,_7594),no_phrases(_7245,_7243,_7535,_7594,_7583),unlock(_7583,_7584),
    !,
    accept(_7629,_7584,_7353).

implicitq(which(_7245):::_7243,[implicitq,{},_7317,_7351,_7375,!,_7414],_7293,_7295) --> 
    {user:value(teleflag,true)},
    no_phrases(_7245,_7243,_7317,_7293,_7336),
    endofline(_7351,_7336,_7366),
    traceprint(4,iq7,_7375,_7366,_7394),
    !,
    accept(_7414,_7394,_7295).

implicitq(new:::_7243,[implicitq,{},_7396,{},_7435,_7464,_7493,_7536,!,_7575,_7599,_7657,!,_7686],_7372,_7374) --> 
    {user:(\+user:value(dialog,1))},
    not_look_ahead(w(prep(_7295)),_7396,_7372,_7413),
    {user:no_unprotected_verb},
    w(noun(time,_7302,_7303,_7304),_7435,_7413,_7452),
    look_ahead(w(prep(_7310)),_7464,_7452,_7481),
    pushstack(first,w(noun(departure,sin,u,_7304)),nil,_7481,_7506),np0(_7322,_7325::_7243,_7493,_7506,_7521),
    traceprint(4,iq8,_7536,_7521,_7555),
    !,
    accept(_7575,_7555,_7590),
    pushstack(first,w(verb(go,pres,fin)),nil,_7590,_7612),verb_phrase1(_7340,_7322,id,_7343,event/real/_7343::_7325,_7599,_7612,_7633),
    endofline(_7657,_7633,_7672),
    !,
    accept(_7686,_7672,_7374).

implicitq(new:::_7243,[implicitq,_7401,_7430,{},_7469,{},{},_7523,_7552,_7581,_7610,!,_7639,_7663,_7697,_7755,_7799,!,_7828],_7387,_7389) --> 
    not_look_ahead(w(nb(_7300,num)),_7401,_7387,_7418),
    not_look_ahead(w(prep(_7307)),_7430,_7418,_7447),
    {user:no_unprotected_verb},
    np1_accept(_7311,_7314::_7243,_7469,_7447,_7488),
    {user:(\+vartypeid(_7311,time))},
    {user:(\+vartypeid(_7311,clock))},
    constrainvehdep(_7311,_7523,_7488,_7540),
    not_look_ahead([som],_7552,_7540,_7569),
    not_look_ahead([om],_7581,_7569,_7598),
    point0(_7610,_7598,_7625),
    !,
    accept(_7639,_7625,_7654),
    traceprint(4,iq9,_7663,_7654,_7682),
    pushstack(first,w(verb(go,pres,fin)),nil,_7682,_7710),verb_phrase1(_7353,_7311,id,_7356,event/real/_7356::_7314,_7697,_7710,_7731),
    optional(itrailer,_7755,_7731,_7787),
    endofline(_7799,_7787,_7814),
    !,
    accept(_7828,_7814,_7389).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,{},_7382,_7411,_7440,{},_7474,_7498,{},_7532,_7571,_7595,_7686,!,_7725,_7749],_7358,_7360) --> 
    {user:value(dialog,1)},
    not_look_ahead(['nå'],_7382,_7358,_7399),
    time1(_7304,_7411,_7399,_7428),
    endofline(_7440,_7428,_7455),
    {user:no_unprotected_verb},
    no_harmful_adj(_7474,_7455,_7489),
    no_harmful_noun(_7498,_7489,_7513),
    {user:setvartype(_7310,vehicle)},
    realcomp(_7248,_7314,_7246,_7532,_7513,_7553),
    deter0(_7571,_7553,_7586),
    pushstack(first,obviousclock1(_7304:clock,_7304 isa clock),nil,_7586,_7641),verb_modifiers(go,_7310,_7248,_7245::true,_7314,_7595,_7641,_7662),
    traceprint(4,iq10,_7686,_7662,_7705),
    !,
    accept(_7725,_7705,_7740),
    qtrailer0(_7749,_7740,_7360).

implicitq(new:::_7243,[implicitq,{},_7404,_7433,{},_7467,{},{},_7521,_7550,_7579,!,_7613,_7637,_7671,_7729,!,_7758],_7380,_7382) --> 
    {user:value(dialog,1)},
    not_look_ahead(w(prep(_7302)),_7404,_7380,_7421),
    not_look_ahead_flnp(_7433,_7421,_7448),
    {user:no_unprotected_verb},
    np0(_7306,_7309::_7243,_7467,_7448,_7486),
    {user:(\+vartypeid(_7306,time))},
    {user:(\+vartypeid(_7306,clock))},
    constrainvehdep(_7306,_7521,_7486,_7538),
    not_look_ahead([om],_7550,_7538,_7567),
    not_look_ahead([som],_7579,_7567,_7596),
    !,
    accept(_7613,_7596,_7628),
    traceprint(4,iq11,_7637,_7628,_7656),
    pushstack(first,w(verb(go,pres,fin)),nil,_7656,_7684),verb_phrase1(_7348,_7306,id,_7351,event/real/_7351::_7309,_7671,_7684,_7705),
    endofline(_7729,_7705,_7744),
    !,
    accept(_7758,_7744,_7382).

implicitq(_7240,[implicitq,_7343,_7367,_7396,_7425,!,_7459,_7483,_7517],_7329,_7331) --> 
    the0(_7343,_7329,_7358),
    w(nb(_7281,num),_7367,_7358,_7384),
    flnp(_7284,_7396,_7384,_7413),
    w(prep(_7277),_7425,_7413,_7442),
    !,
    accept(_7459,_7442,_7474),
    traceprint(4,iq12,_7483,_7474,_7502),
    pushstack(first,(w(nb(_7281,num)),w(adj2(_7284,nil)),w(noun(route,plu,u,n)),w(prep(_7277))),nil,_7502,_7527),
    implicitq(_7240,_7517,_7527,_7331).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,_7360,_7389,_7418,!,_7452,_7476,_7510,_7549,!,_7612],_7346,_7348) --> 
    flnp(_7277,_7360,_7346,_7377),
    not_look_ahead([p],_7389,_7377,_7406),
    therightprep(_7283,_7418,_7406,_7435),
    !,
    accept(_7452,_7435,_7467),
    traceprint(4,iq13,_7476,_7467,_7495),
    realcomp(_7248,_7289,_7246,_7510,_7495,_7531),
    pushstack(first,w(prep(_7283)),nil,_7531,_7562),verb_modifiers(go,_7305:vehicle,_7248,_7245::_7305 isa vehicle and adj/nil/_7277/_7305/_7248,_7289,_7549,_7562,_7583),
    !,
    accept(_7612,_7583,_7348).

implicitq(_7240,[implicitq,{},_7365,_7394,{},_7433,{},!,_7477,_7501,_7535],_7341,_7343) --> 
    {user:(\+value(dialog,1))},
    w(noun(_7277,_7278,_7279,_7280),_7365,_7341,_7382),
    not_look_ahead(w(name(_7300,_7301,_7302)),_7394,_7382,_7411),
    {user:testmember(_7277,[station])},
    look_ahead(w(prep(_7315)),_7433,_7411,_7450),
    {user:no_unprotected_verb},
    !,
    accept(_7477,_7450,_7492),
    traceprint(4,iq14,_7501,_7492,_7520),
    pushstack(first,(whatbe,w(noun(_7277,_7278,_7279,_7280))),nil,_7520,_7578),
    whatq(_7240,_7535,_7578,_7343).

implicitq(_7240,[implicitq,{},_7353,_7382,{},{},!,_7436,_7460,_7494],_7329,_7331) --> 
    {user:(\+value(dialog,1))},
    w(adj2(nearest,nil),_7353,_7329,_7370),
    look_ahead(w(noun(_7293,_7294,_7295,_7296)),_7382,_7370,_7399),
    {user:testmember(_7293,[station])},
    {user:no_unprotected_verb},
    !,
    accept(_7436,_7399,_7451),
    traceprint(4,iq14b,_7460,_7451,_7479),
    pushstack(first,(whatbe,w(adj2(nearest,nil))),nil,_7479,_7532),
    whatq(_7240,_7494,_7532,_7331).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,lit('nå'),{},{},{},_7418,_7447,_7476,{},_7510,_7549,_7607,!,_7646],_7363,_7365) --> 
    cc('nå',_7363,_7387),
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(adj2(_7308,nil)),_7418,_7387,_7435),
    not_look_ahead(w(noun(_7315,_7316,_7317,_7318)),_7447,_7435,_7464),
    not_fnlp(_7476,_7464,_7491),
    {user:setvartype(_7322,vehicle)},
    realcomp(_7248,_7326,_7246,_7510,_7491,_7531),
    pushstack(free,['nå'],nil,_7531,_7562),verb_modifiers(go,_7322,_7248,_7245::true,_7326,_7549,_7562,_7583),
    traceprint(4,iq15,_7607,_7583,_7626),
    !,
    accept(_7646,_7626,_7365).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,{},{},{},_7407,_7436,{},_7480,_7519,_7543,!,_7637,_7661,_7695],_7363,_7365) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_7306,_7307)),_7407,_7363,_7424),
    obviousclock1(_7309,_7310,_7436,_7424,_7455),
    {user:setvartype(_7314,vehicle)},
    realcomp(_7248,_7318,_7246,_7480,_7455,_7501),
    deter0(_7519,_7501,_7534),
    pushstack(first,(w(prep(after)),obviousclock1(_7309,_7310)),nil,_7534,_7587),verb_modifiers(go,_7314,_7248,_7245::true,_7318,_7543,_7587,_7608),
    !,
    accept(_7637,_7608,_7652),
    traceprint(4,iq17,_7661,_7652,_7680),
    qtrailer0(_7695,_7680,_7365).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,{},{},_7379,_7418,{},_7452,_7481,_7510,_7549,_7598,!,_7637],_7345,_7347) --> 
    {user:(\+value(dialog,1))},
    {user:no_unprotected_verb},
    namep(_7292,_7293,_7294,_7379,_7345,_7400),
    no_harmful_adj(_7418,_7400,_7433),
    {user:constrain(_7293,vehicle)},
    not_look_ahead([om],_7452,_7433,_7469),
    not_look_ahead(w(nb(_7309,_7310)),_7481,_7469,_7498),
    realcomp(_7248,_7313,_7246,_7510,_7498,_7531),
    verb_modifiers(go,_7293,_7248,_7245::_7294,_7313,_7549,_7531,_7574),
    traceprint(4,iq18,_7598,_7574,_7617),
    !,
    accept(_7637,_7617,_7347).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,_7365,_7394,{},{},_7443,_7482,_7540,!,_7579],_7351,_7353) --> 
    not_look_ahead(w(name(_7278,_7279,_7280)),_7365,_7351,_7382),
    w(noun(_7284,sin,u,n),_7394,_7382,_7411),
    {user:test(_7284 ako day)},
    {user:setvartype(_7298,vehicle)},
    realcomp(_7248,_7302,_7246,_7443,_7411,_7464),
    pushstack(first,(w(prep(on)),w(noun(_7284,sin,u,n))),nil,_7464,_7495),verb_modifiers(go,_7298,_7248,_7245::true,_7302,_7482,_7495,_7516),
    traceprint(4,iq19,_7540,_7516,_7559),
    !,
    accept(_7579,_7559,_7353).

implicitq(new:::_7243,[implicitq,{},_7427,_7456,{},{},{},{},{},_7540,_7569,_7598,!,_7632,_7656,_7690,_7748,!,_7777],_7403,_7405) --> 
    {user:no_unprotected_verb},
    not_look_ahead(w(nb(_7302,_7303)),_7427,_7403,_7444),
    np1_accept(_7305,_7308::_7243,_7456,_7444,_7475),
    {user:(\+vartypeid(_7305,thing))},
    {user:(\+vartypeid(_7305,time))},
    {user:(\+vartypeid(_7305,clock))},
    {user:(\+vartypeid(_7305,arrival))},
    {user:(\+vartypeid(_7305,departure))},
    not_look_ahead([om],_7540,_7475,_7557),
    not_look_ahead(w(nb(_7354,_7355)),_7569,_7557,_7586),
    constrainvehdep(_7305,_7598,_7586,_7615),
    !,
    accept(_7632,_7615,_7647),
    traceprint(4,iq20,_7656,_7647,_7675),
    pushstack(first,w(verb(go,pres,fin)),nil,_7675,_7703),verb_phrase1(_7371,_7305,id,_7374,event/real/_7374::_7308,_7690,_7703,_7724),
    endofline(_7748,_7724,_7763),
    !,
    accept(_7777,_7763,_7405).

implicitq(new:::_7243,[implicitq,lit('når'),_7359,!,_7403,_7427,!,_7461,_7495,_7570],_7334,_7336) --> 
    cc('når',_7334,_7358),
    np_kernel(_7280,_7281,_7282,_7359,_7358,_7380),
    !,
    accept(_7403,_7380,_7418),
    constrainvehdep(_7281,_7427,_7418,_7444),
    !,
    traceprint(4,iq21,_7461,_7444,_7480),
    pushstack(first,np_kernel(0,_7281,_7282),nil,_7480,_7540),np1(_7281,_7299::_7243,_7495,_7540,_7555),
    pushstack(first,w(verb(go,pres,fin)),nil,_7555,_7580),
    verb_phrase1(_7302,_7281,id,_7305,event/real/_7305::_7299,_7570,_7580,_7336).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,_7376,_7400,_7429,_7458,_7487,!,_7521,_7545,_7579,_7618,!,_7672],_7362,_7364) --> 
    athe0(_7376,_7362,_7391),
    flnp(_7283,_7400,_7391,_7417),
    not_look_ahead(w(nb(_7289,_7290)),_7429,_7417,_7446),
    not_look_ahead(w(name(_7296,_7297,route)),_7458,_7446,_7475),
    look_ahead(w(name(_7304,_7305,_7306)),_7487,_7475,_7504),
    !,
    accept(_7521,_7504,_7536),
    traceprint(4,iq22,_7545,_7536,_7564),
    realcomp(_7248,_7312,_7246,_7579,_7564,_7600),
    verb_modifiers(go,_7321:vehicle,_7248,_7245::_7321 isa vehicle and adj/nil/_7283/_7321/_7248,_7312,_7618,_7600,_7643),
    !,
    accept(_7672,_7643,_7364).

implicitq(_7240,[implicitq,{},_7400,_7429,_7458,_7487,_7516,_7545,{},_7584,!,_7623,_7647,_7681],_7376,_7378) --> 
    {user:(\+value(dialog,1))},
    not_look_ahead(w(noun(clock,_7299,_7300,_7301)),_7400,_7376,_7417),
    not_look_ahead(w(noun(thing,_7308,_7309,_7310)),_7429,_7417,_7446),
    not_look_ahead(w(noun(answer,_7317,_7318,_7319)),_7458,_7446,_7475),
    not_look_ahead([det],_7487,_7475,_7504),
    not_look_ahead(w(name(_7329,n,_7331)),_7516,_7504,_7533),
    look_ahead(w(noun(_7337,_7338,_7339,n)),_7545,_7533,_7562),
    {user:testmember(_7337,[ticket,price])},
    np1_accept(_7284,_7285,_7584,_7562,_7603),
    !,
    accept(_7623,_7603,_7638),
    traceprint(4,iq23,_7647,_7638,_7666),
    pushstack(first,(whatbe,xnp(_7284,_7285)),nil,_7666,_7750),
    whatq(_7240,_7681,_7750,_7378).

implicitq(_7240,[implicitq,{},_7352,{},_7391,!,_7425,_7449,_7483],_7328,_7330) --> 
    {user:(\+value(dialog,1))},
    w(noun(_7271,_7286,_7287,_7288),_7352,_7328,_7369),
    {user:testmember(_7271,[clock,date])},
    not_look_ahead(w(nb(_7303,_7304)),_7391,_7369,_7408),
    !,
    accept(_7425,_7408,_7440),
    traceprint(4,iq24,_7449,_7440,_7468),
    pushstack(first,(whatbe,w(noun(_7271,_7272,_7273,_7274))),nil,_7468,_7521),
    whatq(_7240,_7483,_7521,_7330).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,{},{},{},_7451,{},_7490,{},{},_7539,_7578,_7607,_7641,!,_7704,_7728],_7407,_7409) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    w(name(_7310,n,_7312),_7451,_7407,_7468),
    {user:subclass0(_7312,place)},
    w(name(_7321,n,_7323),_7490,_7468,_7507),
    {user:subclass0(_7323,place)},
    {user:setvartype(_7332,vehicle)},
    realcomp(_7248,_7336,_7246,_7539,_7507,_7560),
    not_look_ahead(w(nb(_7343,_7344)),_7578,_7560,_7595),
    traceprint(4,iq25,_7607,_7595,_7626),
    pushstack(first,(w(prep(from)),w(name(_7310,n,_7312)),w(prep(to)),w(name(_7321,n,_7323))),nil,_7626,_7654),verb_modifiers(go,_7332,_7248,_7245::true,_7336,_7641,_7654,_7675),
    !,
    accept(_7704,_7675,_7719),
    qtrailer0(_7728,_7719,_7409).

implicitq(modifier(_7248):::_7245 and _7246,[implicitq,{},{},{},_7407,_7431,_7455,{},_7494,_7533,_7557,_7586,_7610,_7634,_7668,!,_7722,_7746],_7363,_7365) --> 
    {user:(\+value(teleflag,true))},
    {user:(\+value(textflag,true))},
    {user:no_unprotected_verb},
    no_harmful_adj(_7407,_7363,_7422),
    no_harmful_noun(_7431,_7422,_7446),
    not_look_ahead([du],_7455,_7446,_7472),
    {user:setvartype(_7320,vehicle)},
    realcomp(_7248,_7324,_7246,_7494,_7472,_7515),
    deter0(_7533,_7515,_7548),
    not_look_ahead(w(nb(_7331,_7332)),_7557,_7548,_7574),
    no_harmful_adj(_7586,_7574,_7601),
    redundants0(_7610,_7601,_7625),
    traceprint(4,iq26,_7634,_7625,_7653),
    verb_modifiers(go,_7320,_7248,_7245::true,_7324,_7668,_7653,_7693),
    !,
    accept(_7722,_7693,_7737),
    qtrailer0(_7746,_7737,_7365).

reject_implicitq([reject_implicitq,lit(hvilke)],_7257,_7259) --> 
    cc(hvilke,_7257,_7259).

reject_implicitq([reject_implicitq,_7301,_7330,_7359,_7388,_7417],_7290,_7292) --> 
    look_ahead(w(nb(1000,num)),_7301,_7290,_7318),
    not_look_ahead([en],_7330,_7318,_7347),
    not_look_ahead([et],_7359,_7347,_7376),
    not_look_ahead([to],_7388,_7376,_7405),
    not_look_ahead([tre],_7417,_7405,_7292).

reject_implicitq([reject_implicitq,lit(at)],_7257,_7259) --> 
    cc(at,_7257,_7259).

reject_implicitq([reject_implicitq,_7273],_7262,_7264) --> 
    w(noun(error,_7243,_7244,_7245),_7273,_7262,_7264).

reject_implicitq([reject_implicitq,_7291,_7320,_7349],_7280,_7282) --> 
    not_look_ahead(w(adj2(fast,_7256)),_7291,_7280,_7308),
    not_look_ahead(w(adj2(best,_7263)),_7320,_7308,_7337),
    w(adj2(good,nil),_7349,_7337,_7282).

reject_implicitq([reject_implicitq,lit(kan)],_7257,_7259) --> 
    cc(kan,_7257,_7259).

reject_implicitq([reject_implicitq,_7287,_7316,{}],_7276,_7278) --> 
    not_look_ahead([e],_7287,_7276,_7304),
    w(verb(_7248,_7258,_7259),_7316,_7304,_7278),
    {user:_7248\==reach}.

reject_implicitq([reject_implicitq,_7282,_7311],_7271,_7273) --> 
    w(noun(_7251,_7252,_7253,_7254),_7282,_7271,_7299),
    w(verb(_7245,_7246,_7247),_7311,_7299,_7273).

reject_implicitq([reject_implicitq,_7304,_7333,_7362,_7391,_7420,_7449],_7293,_7295) --> 
    not_look_ahead([de],_7304,_7293,_7321),
    not_look_ahead([den],_7333,_7321,_7350),
    not_look_ahead([det],_7362,_7350,_7379),
    not_look_ahead([alle],_7391,_7379,_7408),
    not_look_ahead([en],_7420,_7408,_7437),
    quant_pron(_7255,_7256,_7449,_7437,_7295).

reject_implicitq([reject_implicitq,_7278,_7307],_7267,_7269) --> 
    w(noun(_7247,_7248,_7249,_7250),_7278,_7267,_7295),
    posspron(_7243,_7307,_7295,_7269).

reject_implicitq([reject_implicitq,_7285,{}],_7274,_7276) --> 
    w(noun(_7245,_7255,_7256,_7257),_7285,_7274,_7276),
    {user:testmember(_7245,[possibility,necessity])}.

reject_implicitq([reject_implicitq,_7266],_7255,_7257) --> 
    what(_7266,_7255,_7257).

reject_implicitq([reject_implicitq,lit(der)],_7257,_7259) --> 
    cc(der,_7257,_7259).

reject_implicitq([reject_implicitq,lit(hvor)],_7257,_7259) --> 
    cc(hvor,_7257,_7259).

reject_implicitq([reject_implicitq,lit(hvem)],_7257,_7259) --> 
    cc(hvem,_7257,_7259).

reject_implicitq([reject_implicitq,_7291,_7320,lit('når'),_7360],_7280,_7282) --> 
    not_look_ahead([nr],_7291,_7280,_7308),
    not_look_ahead([n],_7320,_7308,_7337),
    cc('når',_7337,_7359),
    not_look_ahead(w(prep(from)),_7360,_7359,_7282).

reject_implicitq([reject_implicitq,_7266],_7255,_7257) --> 
    so(_7266,_7255,_7257).

reject_implicitq([reject_implicitq,_7278,_7307],_7267,_7269) --> 
    w(nb(1000,num),_7278,_7267,_7295),
    look_ahead([takk],_7307,_7295,_7269).

reject_implicitq([reject_implicitq,lit(da)],_7257,_7259) --> 
    cc(da,_7257,_7259).

reject_implicitq([reject_implicitq,lit(og)],_7257,_7259) --> 
    cc(og,_7257,_7259).

reject_implicitq([reject_implicitq,lit(men)],_7257,_7259) --> 
    cc(men,_7257,_7259).

reject_implicitq([reject_implicitq,_7275,lit(hvis)],_7264,_7266) --> 
    not_look_ahead([om],_7275,_7264,_7292),
    cc(hvis,_7292,_7266).

reject_implicitq([reject_implicitq,lit(fordi)],_7257,_7259) --> 
    cc(fordi,_7257,_7259).

reject_implicitq([reject_implicitq,lit(ja)],_7257,_7259) --> 
    cc(ja,_7257,_7259).

reject_implicitq([reject_implicitq,lit(nei)],_7257,_7259) --> 
    cc(nei,_7257,_7259).

reject_implicitq([reject_implicitq,{},lit(det)],_7265,_7267) --> 
    {user:value(notimeoutflag,true)},
    cc(det,_7265,_7267).

reject_implicitq([reject_implicitq,lit(det),_7288],_7266,_7268) --> 
    cc(det,_7266,_7287),
    w(verb(be,_7246,_7247),_7288,_7287,_7268).

reject_implicitq([reject_implicitq,_7309,_7338,{}],_7298,_7300) --> 
    w(adj2(good,nil),_7309,_7298,_7326),
    w(noun(_7248,_7279,_7280,_7281),_7338,_7326,_7300),
    {user:testmember(_7248,[morrow,morning,day,night,evening,midnight,afternoon,prenoon,saturday,sunday])}.

reject_implicitq([reject_implicitq,_7283,{}],_7272,_7274) --> 
    w(noun(_7245,_7253,def,_7255),_7283,_7272,_7274),
    {user:testmember(_7245,[midnight])}.

reject_implicitq([reject_implicitq,lit('på'),lit('forhånd'),lit(takk)],_7267,_7269) --> 
    cc('på',_7267,_7288),
    cc('forhånd',_7288,_7299),
    cc(takk,_7299,_7269).

reject_implicitq([reject_implicitq,_7306,{},_7345,{},!,_7384],_7295,_7297) --> 
    w(noun(_7257,_7258,_7259,_7260),_7306,_7295,_7323),
    {user:(\+testmember(_7257,[nightbus,airplane,airbus]))},
    endofline(_7345,_7323,_7360),
    {user:value(notimeoutflag,true)},
    !,
    reject(_7384,_7360,_7297).

reject_implicitq([reject_implicitq,lit('nå'),_7288,!,_7317],_7266,_7268) --> 
    cc('nå',_7266,_7287),
    endofline(_7288,_7287,_7303),
    !,
    reject(_7317,_7303,_7268).

no_harmful_adj([no_harmful_adj,_7293,{},!,_7337],_7282,_7284) --> 
    look_ahead(w(adj2(_7253,nil)),_7293,_7282,_7310),
    {user:testmember(_7253,[nearest,good,next])},
    !,
    reject(_7337,_7310,_7284).

no_harmful_adj([no_harmful_adj,[]],_7255,_7255) --> 
    [].

no_harmful_noun([no_harmful_noun,_7291,_7320,!,_7359],_7280,_7282) --> 
    look_ahead(w(noun(_7253,_7254,_7255,n)),_7291,_7280,_7308),
    gmem(_7253,[airport,bridge],_7320,_7308,_7339),
    !,
    accept(_7359,_7339,_7282).

','({\+testmember(_7247,[airport])},no_harmful_noun,[',',_7310,{},!,_7354],_7293,_7295) --> 
    look_ahead(w(name(_7265,_7266,_7247)),_7310,_7293,_7327),
    {user:subclass0(_7247,place)},
    !,
    accept(_7354,_7327,_7295).

no_harmful_noun([no_harmful_noun,_7295,_7339,{},!],_7284,_7286) --> 
    optional([alle],_7295,_7284,_7327),
    look_ahead(w(noun(_7257,sin,_7259,_7260)),_7339,_7327,_7286),
    {user:testmember(_7257,[station])},
    !.

no_harmful_noun([no_harmful_noun,_7294,{},!],_7283,_7285) --> 
    look_ahead(w(noun(_7250,sin,u,n)),_7294,_7283,_7285),
    {user:testmember(_7250,[arrival,departure,station,student])},
    !.

no_harmful_noun([no_harmful_noun,_7285,{}],_7274,_7276) --> 
    not_look_ahead(w(noun(_7247,_7255,_7256,_7257)),_7285,_7274,_7276),
    {user:(\+testmember(_7247,airport))}.

therightprep(from,[therightprep,_7280,!],_7266,_7268) --> 
    w(prep(from),_7280,_7266,_7268),
    !.

therightprep(_7240,[therightprep,_7280,!],_7266,_7268) --> 
    w(prep(_7240),_7280,_7266,_7268),
    !.

not_adjective_only([not_adjective_only,_7277,!],_7266,_7268) --> 
    look_ahead(w(name(_7247,n,_7249)),_7277,_7266,_7268),
    !.

not_adjective_only([not_adjective_only,_7273],_7262,_7264) --> 
    look_ahead(w(adj2(_7244,_7245)),_7273,_7262,_7264).

not_fnlp([not_fnlp,_7295,{},!,_7339],_7284,_7286) --> 
    look_ahead(w(adj2(_7253,nil)),_7295,_7284,_7312),
    {user:testmember(_7253,[first,next,last,previous])},
    !,
    reject(_7339,_7312,_7286).

not_fnlp([not_fnlp,[]],_7255,_7255) --> 
    [].

constrainvehdep(_7240,[constrainvehdep,{},!,_7299],_7270,_7272) --> 
    {user:vartypeid(_7240,thing)},
    !,
    reject(_7299,_7270,_7272).

constrainvehdep(_7240,[constrainvehdep,{},!,_7299],_7270,_7272) --> 
    {user:constrain(_7240,clock)},
    !,
    reject(_7299,_7270,_7272).

constrainvehdep(_7242:_7243,[constrainvehdep,{},{},!,_7322],_7283,_7285) --> 
    {user:constrain(_7242:_7260,number)},
    {user:plausible_busno(_7242)},
    !,
    accept(_7322,_7283,_7285).

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,summerroute)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,winterroute)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,route)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,route_plan)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,vehicle)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,departure)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,arrival)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,connection)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,tram_route)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,tram_route_plan)},
    !.

constrainvehdep(_7240,[constrainvehdep,{},!],_7267,_7267) --> 
    {user:constrain(_7240,trip)},
    !.

hasq(_7240,[hasq,_7312,_7336,_7365,!,_7399,_7423],_7298,_7300) --> 
    has(_7312,_7298,_7327),
    thereit(_7269,_7336,_7327,_7353),
    w(verb(_7265,past,part),_7365,_7353,_7382),
    !,
    accept(_7399,_7382,_7414),
    pushstack(free,([det],w(verb(_7265,pres,fin))),nil,_7414,_7433),
    statement(_7240,_7423,_7433,_7300).

hasq(_7240,[hasq,_7333,_7362,_7391,_7415,_7449,_7478,_7502,_7526,_7550,!,_7579],_7319,_7321) --> 
    w(verb(have,_7287,fin),_7333,_7319,_7350),
    negation0(_7290,_7362,_7350,_7379),
    so0(_7391,_7379,_7406),
    subject(_7292,_7293,_7415,_7406,_7434),
    negation0(_7295,_7449,_7434,_7466),
    adverbx0(_7478,_7466,_7493),
    hatt0(_7502,_7493,_7517),
    negatino(_7526,_7517,_7541),
    sometimes0(_7550,_7541,_7565),
    !,
    pushstack(first,(xnp(_7292,_7293),w(verb(have,pres,fin))),nil,_7565,_7620),
    statement(_7240,_7579,_7620,_7321).

hasq(_7240,[hasq,_7298,_7327,_7356],_7284,_7286) --> 
    w(verb(have,_7254,fin),_7298,_7284,_7315),
    negation0(_7263,_7327,_7315,_7344),
    lock(last,_7344,_7373),
    pushstack(last,w(verb(have,_7254,fin)),nil,_7373,_7379),
    statement(_7240,_7356,_7379,_7368),
    unlock(_7368,_7286).

isq(_7240,[isq,_7363,_7387,_7416,_7445,_7474,_7498,_7527,lit('å'),!,_7577,!,_7625],_7349,_7351) --> 
    be(_7363,_7349,_7378),
    negation0(_7289,_7387,_7378,_7404),
    thereit(_7291,_7416,_7404,_7433),
    negation0(_7293,_7445,_7433,_7462),
    so0(_7474,_7462,_7489),
    w(adj2(_7286,nil),_7498,_7489,_7515),
    gmem(_7286,[true,false,wrong,correct],_7527,_7515,_7546),
    cc('å',_7546,_7571),
    !,
    pushstack(first,[jeg],nil,_7571,_7590),clausal_object1(_7318,_7319,_7577,_7590,_7605),
    !,
    pushstack(first,(xnp(_7318,_7319),w(verb(be,pres,fin)),w(adj2(_7286,nil))),nil,_7605,_7666),
    substatement1(_7240,_7625,_7666,_7351).

isq(_7240,[isq,_7358,_7382,_7411,_7440,_7469,_7493,_7522,lit(at),!,_7572,!,_7611],_7344,_7346) --> 
    be(_7358,_7344,_7373),
    negation0(_7289,_7382,_7373,_7399),
    thereit(_7291,_7411,_7399,_7428),
    negation0(_7293,_7440,_7428,_7457),
    so0(_7469,_7457,_7484),
    w(adj2(_7286,nil),_7493,_7484,_7510),
    gmem(_7286,[true,false,wrong,correct],_7522,_7510,_7541),
    cc(at,_7541,_7566),
    !,
    clausal_object1(_7313,_7314,_7572,_7566,_7591),
    !,
    pushstack(first,(xnp(_7313,_7314),w(verb(be,pres,fin)),w(adj2(_7286,nil))),nil,_7591,_7652),
    substatement1(_7240,_7611,_7652,_7346).

isq(_7240,[isq,_7318,_7347,_7376,_7405,!,[],_7453],_7304,_7306) --> 
    w(verb(be,_7265,fin),_7318,_7304,_7335),
    negation0(_7268,_7347,_7335,_7364),
    thereit(_7270,_7376,_7364,_7393),
    w(verb(_7274,past,part),_7405,_7393,_7422),
    !,
    pushstack(free,w(verb(_7274,_7265,fin)),nil,_7422,_7452),[],
    statement(_7240,_7453,_7452,_7306).

isq(_7240,[isq,_7320,_7344,_7373,_7402,_7431,_7455,!,_7489],_7306,_7308) --> 
    be(_7320,_7306,_7335),
    negation0(_7275,_7344,_7335,_7361),
    pronoun(_7277,_7373,_7361,_7390),
    negation0(_7279,_7402,_7390,_7419),
    not_look_ahead_np(_7431,_7419,_7446),
    not_look_ahead([som],_7455,_7446,_7472),
    !,
    pushstack(first,(pronoun(_7277),w(verb(be,pres,fin))),nil,_7472,_7530),
    substatement1(_7240,_7489,_7530,_7308).

isq(_7240,[isq,_7354,lit(det),_7389,_7418,_7442,_7471,_7500,lit('å'),!,_7550,_7624],_7340,_7342) --> 
    be(_7354,_7340,_7369),
    cc(det,_7369,_7388),
    negation0(_7288,_7389,_7388,_7406),
    so0(_7418,_7406,_7433),
    w(adj2(_7283,nil),_7442,_7433,_7459),
    w(prep(for),_7471,_7459,_7488),
    object(_7299,_7300,_7500,_7488,_7519),
    cc('å',_7519,_7544),
    !,
    pushstack(first,(xnp(_7299,_7300),[vil]),nil,_7544,_7594),clausal_object1(_7312,_7313,_7550,_7594,_7609),
    pushstack(first,(xnp(_7312,_7313),be,w(adj2(_7283,nil))),nil,_7609,_7693),
    substatement1(_7240,_7624,_7693,_7342).

isq(_7240,[isq,_7329,_7353,_7382,_7411,_7435,_7464,!,_7503],_7315,_7317) --> 
    be(_7329,_7315,_7344),
    thereit(_7279,_7353,_7344,_7370),
    negation0(_7281,_7382,_7370,_7399),
    so0(_7411,_7399,_7426),
    w(adj2(_7285,nil),_7435,_7426,_7452),
    prepnog(_7285,_7277,_7464,_7452,_7483),
    !,
    pushstack(first,(something,be,w(adj2(_7285,nil)),w(prep(_7277))),nil,_7483,_7569),
    substatement1(_7240,_7503,_7569,_7317).

isq(_7240,[isq,_7349,_7373,_7402,_7431,_7460,_7484,{},lit('å'),!,_7539],_7335,_7337) --> 
    be(_7349,_7335,_7364),
    negation0(_7283,_7373,_7364,_7390),
    thereit(_7285,_7402,_7390,_7419),
    negation0(_7287,_7431,_7419,_7448),
    so0(_7460,_7448,_7475),
    w(adj2(_7291,nil),_7484,_7475,_7501),
    {user:(\+testmember(_7291,[]))},
    cc('å',_7501,_7533),
    !,
    pushstack(first,([det],w(verb(be,pres,fin)),w(adj2(_7291,nil)),['å']),nil,_7533,_7549),
    substatement1(_7240,_7539,_7549,_7337).

isq(_7240,[isq,_7329,_7353,_7382,_7411,_7440,_7464,!,_7498],_7315,_7317) --> 
    be(_7329,_7315,_7344),
    negation0(_7277,_7353,_7344,_7370),
    thereit(_7279,_7382,_7370,_7399),
    negation0(_7281,_7411,_7399,_7428),
    so0(_7440,_7428,_7455),
    w(adj2(_7274,nil),_7464,_7455,_7481),
    !,
    pushstack(first,([noe],w(verb(be,pres,fin)),w(adj2(_7274,nil))),nil,_7481,_7508),
    substatement1(_7240,_7498,_7508,_7317).

isq(_7240,[isq,_7303,_7327,_7351,!,_7385],_7289,_7291) --> 
    be(_7303,_7289,_7318),
    dette(_7327,_7318,_7342),
    negation0(_7266,_7351,_7342,_7368),
    !,
    pushstack(first,([dette],w(verb(be,pres,fin))),nil,_7368,_7395),
    substatement1(_7240,_7385,_7395,_7291).

isq(_7240,[isq,_7301,_7325,_7349,!,_7378],_7287,_7289) --> 
    be(_7301,_7287,_7316),
    thereit(_7325,_7316,_7340),
    ikkeingen0(_7349,_7340,_7364),
    !,
    pushstack(free,([det],w(verb(be,pres,fin))),nil,_7364,_7388),
    substatement1(_7240,_7378,_7388,_7289).

isq(_7240,[isq,_7312,_7336,_7365,_7399,!,_7433],_7298,_7300) --> 
    be(_7312,_7298,_7327),
    negation0(_7269,_7336,_7327,_7353),
    subject(_7271,_7272,_7365,_7353,_7384),
    negation0(_7274,_7399,_7384,_7416),
    !,
    pushstack(first,(xnp(_7271,_7272),w(verb(be,pres,fin))),nil,_7416,_7474),
    substatement1(_7240,_7433,_7474,_7300).

isq(_7240,[isq,_7298,_7322,_7346,!,_7380],_7284,_7286) --> 
    be(_7298,_7284,_7313),
    det0(_7322,_7313,_7337),
    negation0(_7263,_7346,_7337,_7363),
    !,
    pushstack(free,w(verb(be,pres,fin)),nil,_7363,_7390),
    substatement1(_7240,_7380,_7390,_7286).

ikkeingen0([ikkeingen0,lit(ingen),!],_7260,_7262) --> 
    cc(ingen,_7260,_7262),
    !.

ikkeingen0([ikkeingen0,_7268],_7257,_7259) --> 
    negation0(_7240,_7268,_7257,_7259).

ynqs(_7240,[ynqs,_7287,_7316,!,_7355],_7273,_7275) --> 
    isynq(_7251,_7287,_7273,_7304),
    orwill(_7251,_7240,_7316,_7304,_7335),
    !,
    accept(_7355,_7335,_7275).

isynq(_7240,[isynq,_7275],_7261,_7263) --> 
    isq(_7240,_7275,_7261,_7263).

isynq(_7240,[isynq,_7275],_7261,_7263) --> 
    ynq(_7240,_7275,_7261,_7263).

orwill(_7240,_7240,[orwill,lit(eller),_7301,!,_7330],_7273,_7275) --> 
    cc(eller,_7273,_7300),
    endofline(_7301,_7300,_7316),
    !,
    accept(_7330,_7316,_7275).

orwill(_7240,_7240 or _7244,[orwill,lit(eller),_7322,!,_7356,_7380,_7409],_7294,_7296) --> 
    cc(eller,_7294,_7321),
    not_look_ahead(w(nb(_7270,_7271)),_7322,_7321,_7339),
    !,
    accept(_7356,_7339,_7371),
    isynq(_7261,_7380,_7371,_7397),
    orwill(_7261,_7244,_7409,_7397,_7296).

orwill(_7240,_7240,[orwill,[]],_7262,_7262) --> 
    [].

ynq(_7240,[ynq,_7335,{},lit(det),_7385,_7414,!,_7448],_7321,_7323) --> 
    w(verb(_7268,_7269,fin),_7335,_7321,_7352),
    {user:(\+testmember(_7268,[be,have]))},
    cc(det,_7352,_7384),
    negation0(_7291,_7385,_7384,_7402),
    look_ahead(w(adj2(_7297,_7298)),_7414,_7402,_7431),
    !,
    pushstack(free,([dette],w(verb(_7268,_7269,fin))),nil,_7431,_7458),
    statreal(_7240,_7448,_7458,_7323).

ynq(_7240,[ynq,_7350,{},lit(det),_7400,lit('å'),_7445,!,_7493],_7336,_7338) --> 
    w(verb(_7277,_7278,fin),_7350,_7336,_7367),
    {user:testmember(_7277,[cost])},
    cc(det,_7367,_7399),
    np0_accept(_7272,_7273,_7400,_7399,_7419),
    cc('å',_7419,_7444),
    pushstack(first,([noen],[vil]),nil,_7444,_7458),clausal_object1(_7303,_7304,_7445,_7458,_7473),
    !,
    pushstack(first,(xnp(_7303,_7304),w(verb(_7277,pres,fin)),xnp(_7272,_7273)),nil,_7473,_7565),
    statreal1(_7240,_7493,_7565,_7338).

ynq(_7240,[ynq,_7327,lit(det),_7362,_7391,_7420,_7454,_7478,!,_7552],_7313,_7315) --> 
    aux1(_7327,_7313,_7342),
    cc(det,_7342,_7361),
    negation0(_7268,_7362,_7361,_7379),
    w(verb(happen,inf,fin),_7391,_7379,_7408),
    subject(_7276,_7277,_7420,_7408,_7439),
    not_look_ahead_vp(_7454,_7439,_7469),
    pushstack(first,(xnp(_7276,_7277),w(verb(happen,pres,fin))),nil,_7469,_7522),statreal1(_7240,_7478,_7522,_7535),
    !,
    accept(_7552,_7535,_7315).

ynq(_7240,[ynq,lit(kan),_7331,_7360,_7394,_7423,_7447,!,_7521],_7306,_7308) --> 
    cc(kan,_7306,_7330),
    negation0(_7265,_7331,_7330,_7348),
    subject(_7267,_7268,_7360,_7348,_7379),
    negation0(_7270,_7394,_7379,_7411),
    not_look_ahead_vp(_7423,_7411,_7438),
    pushstack(first,(xnp(_7267,_7268),w(verb(know1,pres,fin))),nil,_7438,_7491),statreal1(_7240,_7447,_7491,_7504),
    !,
    accept(_7521,_7504,_7308).

ynq(_7240,[ynq,lit('Får'),{},_7345,_7374,_7408,!,_7442],_7310,_7312) --> 
    cc('Får',_7310,_7334),
    {user:testmember('Får',['får',kan,kunne])},
    negation0(_7281,_7345,_7334,_7362),
    subject(_7283,_7284,_7374,_7362,_7393),
    negation0(_7286,_7408,_7393,_7425),
    !,
    pushstack(first,(xnp(_7283,_7284),['Får']),nil,_7425,_7483),
    statreal1(_7240,_7442,_7483,_7312).

ynq(_7240,[ynq,_7337,_7361,_7395,_7424,{},_7463,!,_7497],_7323,_7325) --> 
    aux1(_7337,_7323,_7352),
    subject(_7275,_7276,_7361,_7352,_7380),
    w(verb(_7271,inf,fin),_7395,_7380,_7412),
    not_look_ahead(w(verb(_7288,_7289,_7290)),_7424,_7412,_7441),
    {user:(\+verbtype(_7271,rv))},
    negation0(_7299,_7463,_7441,_7480),
    !,
    pushstack(first,(xnp(_7275,_7276),w(verb(_7271,pres,fin))),nil,_7480,_7538),
    statreal1(_7240,_7497,_7538,_7325).

ynq(_7240,[ynq,lit('så'),!,_7297],_7267,_7269) --> 
    cc('så',_7267,_7291),
    !,
    reject(_7297,_7291,_7269).

ynq(_7240,[ynq,_7334,_7358,_7387,lit(av),!,_7437,_7461,_7485,_7514],_7320,_7322) --> 
    aux1(_7334,_7320,_7349),
    not_look_ahead(w(verb(go,_7282,_7283)),_7358,_7349,_7375),
    subject(_7285,_7286,_7387,_7375,_7406),
    cc(av,_7406,_7431),
    !,
    accept(_7437,_7431,_7452),
    adverbx0(_7461,_7452,_7476),
    negation0(_7290,_7485,_7476,_7502),
    pushstack(first,(xnp(_7285,_7286),w(verb(go,pres,fin)),[av]),nil,_7502,_7555),
    statreal1(_7240,_7514,_7555,_7322).

ynq(_7240,[ynq,_7349,_7373,_7402,_7436,_7460,{},!,_7504,_7528,_7552,_7581],_7335,_7337) --> 
    aux1(_7349,_7335,_7364),
    not_look_ahead(w(verb(go,_7290,_7291)),_7373,_7364,_7390),
    subject(_7293,_7294,_7402,_7390,_7421),
    redundant0(_7436,_7421,_7451),
    w(prep(_7283),_7460,_7451,_7477),
    {user:_7283\==av},
    !,
    accept(_7504,_7477,_7519),
    adverbx0(_7528,_7519,_7543),
    negation0(_7305,_7552,_7543,_7569),
    pushstack(first,(xnp(_7293,_7294),w(verb(go,pres,fin)),w(prep(_7283))),nil,_7569,_7622),
    statreal1(_7240,_7581,_7622,_7337).

ynq(_7240,[ynq,_7364,_7398,_7427,_7456,_7485,_7514,_7548,_7587,!,_7621,_7645,_7669,[],_7744,!,_7846],_7350,_7352) --> 
    aux1(_7287,_7288,_7364,_7350,_7383),
    negation0(_7290,_7398,_7383,_7415),
    not_look_ahead([man],_7427,_7415,_7444),
    not_look_ahead([jeg],_7456,_7444,_7473),
    not_look_ahead([du],_7485,_7473,_7502),
    subject(_7304,_7305,_7514,_7502,_7533),
    preadverbial0(_7307,_7308,_7309,_7548,_7533,_7569),
    negation0(_7311,_7587,_7569,_7604),
    !,
    accept(_7621,_7604,_7636),
    adverbx0(_7645,_7636,_7660),
    negation0(_7313,_7669,_7660,_7686),
    pushstack(free,adverbial1(_7307,_7308,_7309),nil,_7686,_7743),[],
    pushstack(first,(noun_phrase1(_7304,_7305),aux1),nil,_7743,_7816),statreal1(_7240,_7744,_7816,_7829),
    !,
    accept(_7846,_7829,_7352).

ynq(_7240,[ynq,_7317,_7341,_7365,{},!,_7409],_7303,_7305) --> 
    doit(_7317,_7303,_7332),
    you(_7341,_7332,_7356),
    w(verb(_7262,_7269,fin),_7365,_7356,_7382),
    {user:testmember(_7262,[list,show])},
    !,
    pushstack(first,w(verb(_7262,imp,fin)),nil,_7382,_7419),
    command(doit:::_7240,_7409,_7419,_7305).

ynq(_7240,[ynq,_7283,_7307,_7336],_7269,_7271) --> 
    doit(_7283,_7269,_7298),
    negation0(_7250,_7307,_7298,_7324),
    statreal1(_7240,_7336,_7324,_7271).

ynq(_7240,[ynq,_7284,_7308,!,_7342],_7270,_7272) --> 
    aux1(_7284,_7270,_7299),
    prep(_7251,_7308,_7299,_7325),
    !,
    reject(_7342,_7325,_7272).

ynq(_7240,[ynq,_7352,_7381,lit(det),_7426,lit('å'),!,_7476,_7519],_7338,_7340) --> 
    w(verb(_7277,_7278,fin),_7352,_7338,_7369),
    gmem(_7277,[cost,take,be],_7381,_7369,_7400),
    cc(det,_7400,_7425),
    np0_accept(_7272,_7273,_7426,_7425,_7445),
    cc('å',_7445,_7470),
    !,
    pushstack(first,([noen],[vil]),nil,_7470,_7489),clausal_object1(_7305,_7306,_7476,_7489,_7504),
    pushstack(first,(xnp(_7305,_7306),w(verb(_7277,pres,fin)),xnp(_7272,_7273)),nil,_7504,_7591),
    statreal1(_7240,_7519,_7591,_7340).

ynq(_7240,[ynq,_7313,{},_7352,!,_7386],_7299,_7301) --> 
    w(verb(_7259,_7260,fin),_7313,_7299,_7330),
    {user:testmember(_7259,[know,find])},
    negation0(_7278,_7352,_7330,_7369),
    !,
    pushstack(free,w(verb(_7259,_7260,fin)),nil,_7369,_7396),
    statreal1(_7240,_7386,_7396,_7301).

ynq(_7240,[ynq,_7330,{},{},_7394,_7423,!,_7452],_7316,_7318) --> 
    lexv(tv,_7265,_7266,fin,_7330,_7316,_7353),
    {user:_7266\==imp},
    {user:(\+testmember(_7265,[have,think]))},
    not_look_ahead(w(adj2(_7294,_7295)),_7394,_7353,_7411),
    anyadverb0(_7423,_7411,_7438),
    !,
    pushstack(free,w(verb(_7265,_7266,fin)),nil,_7438,_7462),
    statreal1(_7240,_7452,_7462,_7318).

ynq(_7240,[ynq,_7313,_7357,lit(til),lit('å'),!,_7418],_7299,_7301) --> 
    lexv(iv,come,_7267,fin,_7313,_7299,_7336),
    subject(_7270,_7271,_7357,_7336,_7376),
    cc(til,_7376,_7401),
    cc('å',_7401,_7412),
    !,
    pushstack(first,(xnp(_7270,_7271),[vil]),nil,_7412,_7459),
    statreal(_7240,_7418,_7459,_7301).

ynq(_7240,[ynq,_7322,_7366,_7400,lit(hva),!,_7445],_7308,_7310) --> 
    lexv(rv,know,_7270,fin,_7322,_7308,_7345),
    subject(_7273,_7274,_7366,_7345,_7385),
    negation0(_7276,_7400,_7385,_7417),
    cc(hva,_7417,_7439),
    !,
    pushstack(first,(xnp(_7273,_7274),w(verb(know,_7270,fin)),[hva]),nil,_7439,_7486),
    statreal(_7240,_7445,_7486,_7310).

ynq(_7240,[ynq,_7315,_7359,_7393,!,_7422],_7301,_7303) --> 
    lexv(rv,_7266,_7267,fin,_7315,_7301,_7338),
    subject(_7270,_7271,_7359,_7338,_7378),
    infinitive(_7393,_7378,_7408),
    !,
    pushstack(first,(xnp(_7270,_7271),w(verb(_7266,_7267,fin)),['å']),nil,_7408,_7463),
    statreal(_7240,_7422,_7463,_7303).

ynq(_7240,[ynq,_7368,{},_7407,_7436,_7465,_7504,_7538,_7567,_7596,!,_7630],_7354,_7356) --> 
    w(verb(_7287,_7288,fin),_7368,_7354,_7385),
    {user:(\+testmember(_7287,[be,have]))},
    not_look_ahead([det],_7407,_7385,_7424),
    not_look_ahead(w(adj2(_7310,_7311)),_7436,_7424,_7453),
    adverb0(_7283,_7314,_7315,_7465,_7453,_7486),
    subject(_7317,_7318,_7504,_7486,_7523),
    reflexiv0(_7287,_7538,_7523,_7555),
    negation0(_7322,_7567,_7555,_7584),
    rep_particlev0(_7287,_7596,_7584,_7613),
    !,
    pushstack(free,(xnp(_7317,_7318),w(verb(_7287,_7288,fin)),w(adv(_7283))),nil,_7613,_7671),
    statreal(_7240,_7630,_7671,_7356).

ynq(_7240,[ynq,_7325,_7354,_7388,!,_7417,_7441,_7465,_7494,!,_7568],_7311,_7313) --> 
    w(verb(reach,pres,fin),_7325,_7311,_7342),
    np1_accept(_7275,_7278::_7279,_7354,_7342,_7373),
    infinitive(_7388,_7373,_7403),
    !,
    accept(_7417,_7403,_7432),
    adverbx0(_7441,_7432,_7456),
    negation0(_7281,_7465,_7456,_7482),
    pushstack(first,noun_phrase1(_7275,_7278::_7279),nil,_7482,_7538),statreal1(_7240,_7494,_7538,_7551),
    !,
    accept(_7568,_7551,_7313).

ynq(_7240,[ynq,_7290,_7319,!,_7348],_7276,_7278) --> 
    not_look_ahead(w(verb(go,_7256,fin)),_7290,_7276,_7307),
    be(_7319,_7307,_7334),
    !,
    reject(_7348,_7334,_7278).

ynq(_7240,[ynq,_7308,!,_7342,_7366],_7294,_7296) --> 
    w(verb(_7259,pres,pass),_7308,_7294,_7325),
    !,
    thereit0(_7342,_7325,_7357),
    pushstack(free,(w(verb(be,pres,fin)),w(verb(_7259,past,part))),nil,_7357,_7376),
    isq(_7240,_7366,_7376,_7296).

ynq(_7240,[ynq,_7299,_7328,_7357,!,_7391],_7285,_7287) --> 
    w(verb(want,pres,fin),_7299,_7285,_7316),
    not_look_ahead([du],_7328,_7316,_7345),
    not_look_ahead([jeg],_7357,_7345,_7374),
    !,
    reject(_7391,_7374,_7287).

ynq(_7240,[ynq,_7301,_7330,_7354,_7383,!,_7412],_7287,_7289) --> 
    w(verb(go,_7263,fin),_7301,_7287,_7318),
    thereit(_7330,_7318,_7345),
    negation0(_7266,_7354,_7345,_7371),
    anaa(_7383,_7371,_7398),
    !,
    pushstack(first,someone,nil,_7398,_7450),
    statement(_7240,_7412,_7450,_7289).

ynq(_7240,[ynq,_7317,lit(det),{},!,_7387],_7303,_7305) --> 
    lexv(iv,_7262,_7263,fin,_7317,_7303,_7340),
    cc(det,_7340,_7371),
    {user:testmember(_7262,[rain,snow])},
    !,
    pushstack(first,([det],w(verb(_7262,_7263,fin))),nil,_7371,_7397),
    statement(_7240,_7387,_7397,_7305).

ynq(_7240,[ynq,_7327,lit(det),_7367,_7396,!,_7430],_7313,_7315) --> 
    w(verb(_7265,_7266,fin),_7327,_7313,_7344),
    cc(det,_7344,_7366),
    look_ahead(w(prep(_7281)),_7367,_7366,_7384),
    not_look_ahead([e],_7396,_7384,_7413),
    !,
    pushstack(first,(w(noun(vehicle,plu,u,n)),w(verb(_7265,_7266,fin))),nil,_7413,_7440),
    statement(_7240,_7430,_7440,_7315).

ynq(_7240,[ynq,_7321,{},_7360,_7389,!,_7423],_7307,_7309) --> 
    w(verb(_7265,_7266,fin),_7321,_7307,_7338),
    {user:(\+rv_templ(_7265,_7280))},
    negation0(_7282,_7360,_7338,_7377),
    thereit(_7284,_7389,_7377,_7406),
    !,
    pushstack(first,([det],w(verb(_7265,_7266,fin))),nil,_7406,_7433),
    statement(_7240,_7423,_7433,_7309).

ynq(_7240,[ynq,_7328,_7357,_7386,_7415,{},_7449,!,_7483],_7314,_7316) --> 
    w(verb(_7268,_7269,fin),_7328,_7314,_7345),
    not_look_ahead(w(verb,_7281,_7282),_7357,_7345,_7374),
    not_look_ahead([det],_7386,_7374,_7403),
    saa0(_7415,_7403,_7430),
    {user:_7268\==have},
    negation0(_7293,_7449,_7430,_7466),
    !,
    pushstack(free,w(verb(_7268,_7269,fin)),nil,_7466,_7493),
    statreal(_7240,_7483,_7493,_7316).

ynq(_7240,[ynq,{},_7317,_7346,!,_7375],_7293,_7295) --> 
    {user:value(smsflag,true)},
    w(verb(have,pres,fin),_7317,_7293,_7334),
    look_ahead_bus(_7346,_7334,_7361),
    !,
    pushstack(free,w(verb(go,pres,fin)),nil,_7361,_7385),
    statreal(_7240,_7375,_7385,_7295).

ynq(_7240,[ynq,_7325,_7354,{},_7408,{},_7442,!,_7471],_7311,_7313) --> 
    not_look_ahead([vil],_7325,_7311,_7342),
    lexv(iv,_7267,_7268,fin,_7354,_7342,_7377),
    {user:(\+rv_templ(_7267,_7285))},
    saa0(_7408,_7377,_7423),
    {user:_7268\==imp},
    anyadverb0(_7442,_7423,_7457),
    !,
    lock(last,_7457,_7521),
    pushstack(last,lexv(iv,_7267,_7268,fin),nil,_7521,_7527),
    statreal1(_7240,_7471,_7527,_7516),
    unlock(_7516,_7313).

look_ahead_bus([look_ahead_bus,_7289,{}],_7278,_7280) --> 
    look_ahead(w(noun(_7245,_7259,_7260,n)),_7289,_7278,_7280),
    {user:testmember(_7245,[bus,nightbus,number])}.

look_ahead_bus([look_ahead_bus,_7273],_7262,_7264) --> 
    look_ahead(w(adj2(next,nil)),_7273,_7262,_7264).

ppq(_7242:::_7243,[ppq,_7375,_7404,_7443,!,_7477,!,_7516,_7540,_7665],_7361,_7363) --> 
    prep(_7288,_7375,_7361,_7392),
    whx_phrase(_7290,_7242,_7294::_7295,_7404,_7392,_7425),
    w(verb(_7299,pres,pass),_7443,_7425,_7460),
    !,
    noun_phrase1(_7303,_7306::_7307,_7477,_7460,_7496),
    !,
    accept(_7516,_7496,_7531),
    lock(exact,_7531,_7624),pushstack(exact,(prep(_7288),noun_phrase1(_7290,_7294::_7295)),nil,_7624,_7630),adverbial1(_7281,_7282,_7285::_7286,_7540,_7630,_7619),unlock(_7619,_7620),
    pushstack(first,(someone,w(verb(_7299,pres,fin)),noun_phrase1(_7303,_7306::_7307),adverbial1(_7281,_7282,_7285::_7286)),nil,_7620,_7772),
    statreal(_7243,_7665,_7772,_7363).

ppq(_7242:::_7243,[ppq,_7322,_7351,{},!,_7405,_7449,!,_7483],_7308,_7310) --> 
    prepnof(_7266,_7322,_7308,_7339),
    whx_phrase(_7268,_7242,_7272::_7273,_7351,_7339,_7372),
    {user:adjustprep(_7268,_7266,_7279)},
    !,
    forwq(_7243,_7279,_7268,_7272::_7273,_7405,_7372,_7428),
    optionalprep(_7279,_7449,_7428,_7466),
    !,
    accept(_7483,_7466,_7310).

optionalprep(in,[optionalprep,_7281,!,_7315],_7267,_7269) --> 
    prep1(_7248,_7281,_7267,_7298),
    !,
    accept(_7315,_7298,_7269).

optionalprep(_7240,[optionalprep,[]],_7259,_7259) --> 
    [].

forwq(_7240,_7241,_7242,_7245::_7246,[forwq,_7329,!,_7378,_7402],_7306,_7308) --> 
    lexv(_7270,be1,_7272,fin,_7329,_7306,_7352),
    !,
    thereit0(_7378,_7352,_7393),
    pushstack(free,(w(verb(be1,pres,fin)),adverbial1(_7241,_7242,_7245::_7246)),nil,_7393,_7447),
    statreal(_7240,_7402,_7447,_7308).

forwq(_7240,_7241,_7242,_7245::_7246,[forwq,_7312,!,_7341],_7289,_7291) --> 
    doit(_7312,_7289,_7327),
    !,
    pushstack(free,adverbial1(_7241,_7242,_7245::_7246),nil,_7327,_7386),
    statreal(_7240,_7341,_7386,_7291).

forwq(_7240,_7241,_7242,_7245::_7246,[forwq,_7335,{},_7374,_7398],_7312,_7314) --> 
    w(verb(_7272,_7273,_7274),_7335,_7312,_7352),
    {user:_7272\==understand},
    thereit0(_7374,_7352,_7389),
    pushstack(free,(w(verb(_7272,_7273,_7274)),adverbial1(_7241,_7242,_7245::_7246)),nil,_7389,_7443),
    statreal(_7240,_7398,_7443,_7314).

whichq(_7242:::_7245 and _7246,[whichq,_7354,_7393,_7422,_7446,_7470,!,_7504,_7528],_7340,_7342) --> 
    whx_phrase(_7284,_7242,true::_7245,_7354,_7340,_7375),
    w(verb(recommend,_7296,pass),_7393,_7375,_7410),
    det0(_7422,_7410,_7437),
    infinitive(_7446,_7437,_7461),
    w(verb(_7301,inf,_7303),_7470,_7461,_7487),
    !,
    accept(_7504,_7487,_7519),
    pushstack(first,([noen],w(verb(recommend,_7296,fin)),['å'],w(verb(_7301,inf,_7321)),npgap(_7284)),nil,_7519,_7569),
    statreal(_7246,_7528,_7569,_7342).

whichq(_7242:::_7245 and _7246,[whichq,_7332,_7371,_7395,_7424,!,_7463],_7318,_7320) --> 
    whx_phrase(_7272,_7242,true::_7245,_7332,_7318,_7353),
    paux0(_7371,_7353,_7386),
    w(verb(_7283,_7284,pass),_7395,_7386,_7412),
    whodidit(_7287,_7288,_7424,_7412,_7443),
    !,
    pushstack(first,(xnp(_7287,_7288),w(verb(_7283,_7284,fin)),npgap(_7272)),nil,_7443,_7534),
    statreal(_7246,_7463,_7534,_7320).

whichq(_7242:::_7243,[whichq,_7307,_7346,_7385,{}],_7293,_7295) --> 
    whx_phrase(_7260,_7242,_7258::_7243,_7307,_7293,_7328),
    realcomp(_7267,_7268,_7257,_7346,_7328,_7367),
    qverb_phrase(_7260,_7256,_7267,_7268,_7385,_7367,_7295),
    {user:negate(_7256,_7257,_7258)}.

whx_phrase(_7240,_7241,_7244::_7245,[whx_phrase,{},_7366,_7400,{},!,_7444,!,_7505],_7336,_7338) --> 
    {user:value(busflag,true)},
    whichf(_7240,_7241,_7366,_7336,_7385),
    look_ahead(w(verb(_7280,_7281,fin)),_7400,_7385,_7417),
    {user:testmember(_7280,[go,pass,leave,depart,arrive])},
    !,
    lock(exact,_7417,_7464),pushstack(exact,w(noun(vehicle,plu,u,n)),nil,_7464,_7470),noun_phrase1(_7240,_7244::_7245,_7444,_7470,_7459),unlock(_7459,_7460),
    !,
    accept(_7505,_7460,_7338).

whx_phrase(_7240,_7241,_7244::_7245,[whx_phrase,_7334,_7368,_7392,_7421,!,_7450],_7314,_7316) --> 
    whichf(_7240,_7241,_7334,_7314,_7353),
    oter(_7368,_7353,_7383),
    w(noun(_7275,_7276,u,n),_7392,_7383,_7409),
    enn(_7421,_7409,_7436),
    !,
    pushstack(first,(w(noun(_7275,_7276,u,n)),[ulik]),nil,_7436,_7460),
    noun_phrase1(_7240,_7244::_7245,_7450,_7460,_7316).

whx_phrase(_7240,which(_7240),_7244::_7245,[whx_phrase,_7341,_7365,_7394,{},!,_7438],_7321,_7323) --> 
    hvordan(_7341,_7321,_7356),
    not_look_ahead(w(verb(_7278,pres,fin)),_7365,_7356,_7382),
    w(noun(_7269,_7285,_7286,_7287),_7394,_7382,_7411),
    {user:_7269\==type},
    !,
    pushstack(first,w(noun(_7269,sin,u,n)),nil,_7411,_7448),
    noun_phrase1(_7240,_7244::_7245,_7438,_7448,_7323).

whx_phrase(_7240,which(_7240),_7244::_7245,[whx_phrase,lit(hva),_7346,_7375,{},!,_7419],_7315,_7317) --> 
    cc(hva,_7315,_7345),
    not_look_ahead(w(verb(_7276,_7277,_7278)),_7346,_7345,_7363),
    look_ahead(w(noun(_7284,_7285,_7286,_7287)),_7375,_7363,_7392),
    {user:_7284\==type},
    !,
    noun_phrase1(_7240,_7244::_7245,_7419,_7392,_7317).

whx_phrase(_7240,_7241,_7244::_7245,[whx_phrase,_7309,_7343,_7367,!,_7406],_7289,_7291) --> 
    whichf(_7240,_7241,_7309,_7289,_7328),
    type0(_7343,_7328,_7358),
    noun_phrase1(_7240,_7244::_7245,_7367,_7358,_7386),
    !,
    accept(_7406,_7386,_7291).

whx_phrase(_7240,_7241,_7244::_7245,[whx_phrase,_7325,_7359,!,_7393,!,_7441],_7305,_7307) --> 
    whichf(_7240,_7241,_7325,_7305,_7344),
    w(nb(_7267,num),_7359,_7344,_7376),
    !,
    pushstack(first,w(nb(_7267,num)),nil,_7376,_7406),noun_phrase1(_7240,_7244::_7245,_7393,_7406,_7421),
    !,
    accept(_7441,_7421,_7307).

whichf(_7240,which(_7240),[whichf,_7281],_7264,_7266) --> 
    which2(_7281,_7264,_7266).

whichg00(_7240,_7241,_7251:_7240,which(_7251):::_7251 isa _7240 and _7241,[whichg00,[]],_7282,_7282) --> 
    [].

qstatement(_7240,_7243:::_7244,[qstatement,{},_7302],_7275,_7277) --> 
    {user:which_thing(_7240,_7243)},
    statreal(_7244,_7302,_7275,_7277).

what_phrase(_7244:thing,which(_7244:thing),_7244 isa thing,[what_phrase,lit(hva)],_7278,_7280) --> 
    cc(hva,_7278,_7280).

whatq(_7240,[whatq,lit(hva),_7360,_7389,_7423,_7457,_7486,!,_7515,_7539],_7335,_7337) --> 
    cc(hva,_7335,_7359),
    w(verb(use,_7288,fin),_7360,_7359,_7377),
    subject(_7291,_7292,_7389,_7377,_7408),
    np1_accept(_7294,_7295,_7423,_7408,_7442),
    prep1(_7297,_7457,_7442,_7474),
    not_look_ahead_np(_7486,_7474,_7501),
    !,
    accept(_7515,_7501,_7530),
    pushstack(first,(xnp(_7291,_7292),w(verb(use,_7288,fin)),np(_7294,_7295),w(prep(_7297)),npgap(_7281)),nil,_7530,_7641),
    qstatement(_7281,_7240,_7539,_7641,_7337).

whatq(which(_7246):::_7245 ako _7246,[whatq,{},_7320,_7344,_7368,_7397,!],_7296,_7298) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_7320,_7296,_7335),
    art1(_7344,_7335,_7359),
    w(noun(_7245,_7275,u,n),_7368,_7359,_7385),
    endofline(_7397,_7385,_7298),
    !.

whatq(which(_7246):::_7245 ako _7246,[whatq,{},_7334,_7358,{},_7397],_7310,_7312) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_7334,_7310,_7349),
    w(noun(_7245,_7272,u,n),_7358,_7349,_7375),
    {user:(\+testmember(_7245,[clock,special_ticket,price,bus,station]))},
    endofline(_7397,_7375,_7312).

whatq(_7240,[whatq,{},_7324,_7348,_7377,!,_7406],_7300,_7302) --> 
    {user:(\+value(dialog,1))},
    whatbemean(_7324,_7300,_7339),
    look_ahead(w(name(_7277,_7278,_7279)),_7348,_7339,_7365),
    redundant0(_7377,_7365,_7392),
    !,
    pushstack(first,w(verb(describe,imp,fin)),nil,_7392,_7416),
    command(_7240,_7406,_7416,_7302).

whatq(which(_7247:thing):::_7243,[whatq,lit(hva),_7356,_7400,_7434,_7468,_7502],_7331,_7333) --> 
    cc(hva,_7331,_7355),
    lexv(tv,_7282,_7283,fin,_7356,_7355,_7379),
    gmem(_7282,[hold,keep,drive,operate],_7400,_7379,_7419),
    subject(_7297,_7298,_7434,_7419,_7453),
    particlev2(_7282,_7301,_7468,_7453,_7487),
    pushstack(first,(xnp(_7297,_7298),w(verb(_7301,pres,fin)),npgap(_7247:thing)),nil,_7487,_7574),
    statreal(_7243,_7502,_7574,_7333).

whatq(_7242:::_7243,[whatq,{},lit(hva),_7393,_7417,_7451,_7480,lit(kunne),_7535,!,_7569],_7358,_7360) --> 
    {user:which_thing(_7290,_7242)},
    cc(hva,_7358,_7392),
    has(_7393,_7392,_7408),
    subject(_7299,_7300,_7417,_7408,_7436),
    w(verb(expect,past,part),_7451,_7436,_7468),
    optional([at],_7480,_7468,_7512),
    cc(kunne,_7512,_7534),
    w(verb(_7316,_7317,pass),_7535,_7534,_7552),
    !,
    pushstack(first,(xnp(_7299,_7300),w(verb(expect,past,fin)),[at],[noen],w(verb(_7316,pres,fin)),npgap(_7290)),nil,_7552,_7640),
    statreal(_7243,_7569,_7640,_7360).

whatq(_7242:::_7245 and _7246,[whatq,_7329,_7368,_7392,_7421,!,_7460],_7315,_7317) --> 
    what_phrase(_7272,_7242,_7245,_7329,_7315,_7350),
    paux0(_7368,_7350,_7383),
    w(verb(_7280,_7281,pass),_7392,_7383,_7409),
    whodidit(_7284,_7285,_7421,_7409,_7440),
    !,
    pushstack(first,(xnp(_7284,_7285),w(verb(_7280,_7281,fin)),npgap(_7272)),nil,_7440,_7531),
    statreal(_7246,_7460,_7531,_7317).

whatq(_7242:::_7245 and _7246,[whatq,_7366,_7405,{},_7459,_7493,_7527,!,_7566,[],_7639],_7352,_7354) --> 
    what_phrase(_7290,_7242,_7245,_7366,_7352,_7387),
    lexv(rv,_7295,_7296,fin,_7405,_7387,_7428),
    {user:(\+testmember(_7295,[]))},
    subject(_7306,_7307,_7459,_7428,_7478),
    that0(_7295,that,_7493,_7478,_7512),
    subject(_7287,_7288,_7527,_7512,_7546),
    !,
    negation0(_7315,_7566,_7546,_7583),
    pushstack(free,npgap(_7290),nil,_7583,_7638),[],
    pushstack(first,(xnp(_7306,_7307),w(verb(_7295,pres,fin)),[at],xnp(_7287,_7288)),nil,_7638,_7711),
    statreal(_7246,_7639,_7711,_7354).

whatq(_7242:::_7245 and _7246,[whatq,_7329,_7368,lit(det),_7408,_7452,!,_7491],_7315,_7317) --> 
    what_phrase(_7272,_7242,_7245,_7329,_7315,_7350),
    w(verb(be,_7281,fin),_7368,_7350,_7385),
    cc(det,_7385,_7407),
    optional([som],_7408,_7407,_7440),
    specific_phrase(_7290,_7291,_7452,_7440,_7471),
    !,
    pushstack(free,(xnp(_7290,_7291),npgap(_7272)),nil,_7471,_7562),
    statreal(_7246,_7491,_7562,_7317).

whatq(which(_7247:thing):::_7243,[whatq,lit(hva),_7356,_7400,_7424,_7458,_7487,_7516],_7331,_7333) --> 
    cc(hva,_7331,_7355),
    lexv(rv,_7288,_7289,fin,_7356,_7355,_7379),
    look_ahead_subject(_7400,_7379,_7415),
    np0_accept(_7292,_7293,_7424,_7415,_7443),
    negation0(_7295,_7458,_7443,_7475),
    prepnom(_7297,_7487,_7475,_7504),
    pushstack(first,(xnp(_7292,_7293),w(verb(_7288,pres,fin)),w(prep(_7297)),npgap(_7247:thing)),nil,_7504,_7590),
    statreal(_7243,_7516,_7590,_7333).

whatq(_7242:::_7245 and _7246,[whatq,_7357,_7396,{},_7450,_7484,_7513,_7542,_7571],_7343,_7345) --> 
    what_phrase(_7278,_7242,_7245,_7357,_7343,_7378),
    lexv(tv,do,_7286,fin,_7396,_7378,_7419),
    {user:(\+testmember(do,[cost,be2,have]))},
    subject(_7302,_7303,_7450,_7419,_7469),
    not_look_ahead([at],_7484,_7469,_7501),
    not_look_ahead(['å'],_7513,_7501,_7530),
    negation0(_7313,_7542,_7530,_7559),
    pushstack(first,(xnp(_7302,_7303),w(verb(do,pres,fin)),npgap(_7278)),nil,_7559,_7642),
    statreal(_7246,_7571,_7642,_7345).

whatq(_7242:::_7243,[whatq,{},lit(hva),_7353,_7377,_7411,!,_7445],_7318,_7320) --> 
    {user:which_thing(_7272,_7242)},
    cc(hva,_7318,_7352),
    has(_7353,_7352,_7368),
    subject(_7281,_7282,_7377,_7368,_7396),
    w(verb(_7286,past,part),_7411,_7396,_7428),
    !,
    pushstack(first,(xnp(_7281,_7282),w(verb(_7286,past,fin)),npgap(_7272)),nil,_7428,_7516),
    statreal(_7243,_7445,_7516,_7320).

whatq(_7242:::_7243,[whatq,{},lit(hva),_7388,_7412,_7446,_7500,!,_7534,_7651],_7353,_7355) --> 
    {user:which_thing(_7283,_7242)},
    cc(hva,_7353,_7387),
    has(_7388,_7387,_7403),
    subject(_7288,_7289,_7412,_7403,_7431),
    noun(_7291,_7292,_7293,_7294,_7278,_7296,_7446,_7431,_7473),
    prepnom(_7298,_7500,_7473,_7517),
    !,
    lock(exact,_7517,_7615),pushstack(exact,(noun(_7291,_7292,_7293,_7294,_7278,_7296),w(prep(_7298)),npgap(_7283)),nil,_7615,_7621),np1(_7278,_7279,_7534,_7621,_7610),unlock(_7610,_7611),
    pushstack(first,(xnp(_7288,_7289),w(verb(have,pres,fin)),xnp(_7278,_7279)),nil,_7611,_7723),
    statreal(_7243,_7651,_7723,_7355).

whatq(which(_7247:thing):::_7243,[whatq,lit(hva),_7373,{},lit(det),_7423,lit('å'),_7458,!,_7506],_7348,_7350) --> 
    cc(hva,_7348,_7372),
    w(verb(_7292,_7293,fin),_7373,_7372,_7390),
    {user:testmember(_7292,[cost])},
    cc(det,_7390,_7422),
    for0(_7423,_7422,_7438),
    cc('å',_7438,_7457),
    pushstack(first,([noen],[vil]),nil,_7457,_7471),clausal_object1(_7315,_7316,_7458,_7471,_7486),
    !,
    pushstack(first,(xnp(_7315,_7316),w(verb(_7292,pres,fin)),npgap(_7247:thing)),nil,_7486,_7580),
    statreal1(_7243,_7506,_7580,_7350).

for0([for0,lit(for),!],_7260,_7262) --> 
    cc(for,_7260,_7262),
    !.

for0([for0,[]],_7255,_7255) --> 
    [].

whatq(_7242:::_7243,[whatq,lit(hva),_7384,{},lit(det),_7434,!,_7468,{},_7502,_7558],_7359,_7361) --> 
    cc(hva,_7359,_7383),
    w(verb(_7287,_7288,fin),_7384,_7383,_7401),
    {user:testmember(_7287,[cost,weigh])},
    cc(det,_7401,_7433),
    look_ahead(w(prep(_7306)),_7434,_7433,_7451),
    !,
    accept(_7468,_7451,_7483),
    {user:which_thing(_7281,_7242)},
    lock(exact,_7483,_7522),pushstack(exact,w(noun(ticket,sin,u,n)),nil,_7522,_7528),noun_phrase1(_7323,_7326::_7327,_7502,_7528,_7517),unlock(_7517,_7518),
    pushstack(first,(noun_phrase1(_7323,_7326::_7327),lexv(tv,_7287,_7288,fin),npgap(_7281)),nil,_7518,_7663),
    statreal(_7243,_7558,_7663,_7361).

whatq(_7242:::_7245 and _7246,[whatq,_7345,_7384,_7413,_7447,{},!,_7496],_7331,_7333) --> 
    what_phrase(_7275,_7242,_7245,_7345,_7331,_7366),
    w(verb(_7283,_7284,fin),_7384,_7366,_7401),
    gmem(_7283,[cost,weigh],_7413,_7401,_7432),
    np1_accept(_7294,_7295,_7447,_7432,_7466),
    {user:(\+constrain(_7294,place))},
    !,
    pushstack(first,(xnp(_7294,_7295),lexv(tv,_7283,_7284,fin),npgap(_7275)),nil,_7466,_7600),
    statreal(_7246,_7496,_7600,_7333).

whatq(_7242:::_7245 and _7246,[whatq,_7298,_7337,_7376],_7284,_7286) --> 
    what_phrase(_7254,_7242,_7245,_7298,_7284,_7319),
    realcomp(_7256,_7257,_7246,_7337,_7319,_7358),
    qverb_phrase(_7254,id,_7256,_7257,_7376,_7358,_7286).

whatq(which(_7247:thing):::_7243,[whatq,_7329,lit(det),_7364,_7393,_7427,!,_7461],_7315,_7317) --> 
    whatbe(_7329,_7315,_7344),
    cc(det,_7344,_7363),
    not_look_ahead(w(adj2(_7285,nil)),_7364,_7363,_7381),
    subject(_7288,_7289,_7393,_7381,_7412),
    negation0(_7291,_7427,_7412,_7444),
    !,
    pushstack(free,(xnp(_7288,_7289),npgap(_7247:thing)),nil,_7444,_7535),
    statement(_7243,_7461,_7535,_7317).

whatq(_7240,[whatq,_7351,_7375,_7399,_7423,_7452,{},!,_7496],_7337,_7339) --> 
    whatbe(_7351,_7337,_7366),
    so0(_7375,_7366,_7390),
    dent0(_7399,_7390,_7414),
    not_look_ahead(w(nb(_7284,_7285)),_7423,_7414,_7440),
    w(adj2(_7277,nil),_7452,_7440,_7469),
    {user:(\+testmember(_7277,[near,nearest,next]))},
    !,
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin)),w(adj2(_7277,nil))),nil,_7469,_7537),
    whichq(_7240,_7496,_7537,_7339).

whatq(which(_7245):::_7243,[whatq,_7301,_7325,_7349,!,_7383,_7417],_7287,_7289) --> 
    whatbe(_7301,_7287,_7316),
    thereit(_7325,_7316,_7340),
    prep1(for,_7349,_7340,_7366),
    !,
    noun_phrase1(_7245,true::_7243,_7383,_7366,_7402),
    danow0(_7417,_7402,_7289).

whatq(which(_7245):::_7243,[whatq,_7345,lit(det),lit(som),!,_7396,_7420,_7454,_7510],_7331,_7333) --> 
    whatbe(_7345,_7331,_7360),
    cc(det,_7360,_7379),
    cc(som,_7379,_7390),
    !,
    accept(_7396,_7390,_7411),
    np(_7284,_7287::_7288,_7420,_7411,_7439),
    lock(exact,_7439,_7474),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7474,_7480),np(_7245,_7277::_7278,_7454,_7480,_7469),unlock(_7469,_7470),
    pushstack(free,(np(_7284,_7287::_7288),np(_7245,_7277::_7278)),nil,_7470,_7588),
    statreal(_7243,_7510,_7588,_7333).

whatq(which(_7245):::_7243,[whatq,_7325,_7349,_7378,_7407,_7450,!,_7479],_7311,_7313) --> 
    whatbe(_7325,_7311,_7340),
    w(noun(time,_7268,_7269,n),_7349,_7340,_7366),
    look_ahead(w(prep(_7276)),_7378,_7366,_7395),
    pushstack(first,w(noun(departure,sin,u,n)),nil,_7395,_7420),noun_phrase1(_7245,true::_7243,_7407,_7420,_7435),
    danow0(_7450,_7435,_7465),
    !,
    accept(_7479,_7465,_7313).

whatq(_7242:::_7243,[whatq,{},_7345,lit(det),_7380,_7409,_7443,!,_7477],_7321,_7323) --> 
    {user:which_thing(_7272,_7242)},
    whatbe(_7345,_7321,_7360),
    cc(det,_7360,_7379),
    not_look_ahead(w(adj2(_7285,nil)),_7380,_7379,_7397),
    noun_phrase1(_7288,_7291::_7292,_7409,_7397,_7428),
    negation0(_7294,_7443,_7428,_7460),
    !,
    pushstack(free,(np(_7288,_7291::_7292),npgap(_7272)),nil,_7460,_7551),
    statement(_7243,_7477,_7551,_7323).

whatq(which(_7247:thing):::_7243,[whatq,_7342,_7366,_7395,_7424,_7458,_7482,!,_7511],_7328,_7330) --> 
    whatbe(_7342,_7328,_7357),
    not_look_ahead([det],_7366,_7357,_7383),
    not_look_ahead(w(name(_7293,n,_7295)),_7395,_7383,_7412),
    np(_7297,_7298,_7424,_7412,_7443),
    danow0(_7458,_7443,_7473),
    endofline(_7482,_7473,_7497),
    !,
    lock(exact,_7497,_7592),
    pushstack(exact,(xnp(_7297,_7298),w(verb(be,pres,fin)),npgap(_7247:thing)),nil,_7592,_7598),
    statreal(_7243,_7511,_7598,_7587),
    unlock(_7587,_7330).

whatq(which(_7245):::_7243,[whatq,_7308,_7332,_7361,_7390,_7424],_7294,_7296) --> 
    whatbe(_7308,_7294,_7323),
    not_look_ahead([det],_7332,_7323,_7349),
    not_look_ahead(w(name(_7267,n,_7269)),_7361,_7349,_7378),
    np1_accept(_7245,true::_7243,_7390,_7378,_7409),
    danow0(_7424,_7409,_7296).

whatq(which(_7247:thing):::_7243,[whatq,_7348,_7372,_7406,_7435,!,_7469],_7334,_7336) --> 
    whatbe(_7348,_7334,_7363),
    noun_phrase1(_7285,_7286,_7372,_7363,_7391),
    w(verb(_7290,past,part),_7406,_7391,_7423),
    prep(_7294,_7435,_7423,_7452),
    !,
    pushstack(first,(noun_phrase1(_7285,_7286),w(verb(be,pres,fin)),w(verb(_7290,past,part)),w(prep(_7294)),npgap(_7247:thing)),nil,_7452,_7543),
    statement(_7243,_7469,_7543,_7336).

whatq(_7240,[whatq,_7300,_7324],_7286,_7288) --> 
    whatbe(_7300,_7286,_7315),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin))),nil,_7315,_7362),
    whichq(_7240,_7324,_7362,_7288).

whatq(_7240,[whatq,lit(hva),_7359,_7383,_7417,_7446,!,_7480,_7504],_7334,_7336) --> 
    cc(hva,_7334,_7358),
    aux1(_7359,_7358,_7374),
    np1_accept(_7282,_7285::_7286,_7383,_7374,_7402),
    w(verb(use,_7291,pass),_7417,_7402,_7434),
    prep1(_7294,_7446,_7434,_7463),
    !,
    accept(_7480,_7463,_7495),
    pushstack(first,([noen],w(verb(use,_7291,fin)),np(_7282,_7285::_7286),w(prep(_7294)),npgap(_7278)),nil,_7495,_7578),
    qstatement(_7278,_7240,_7504,_7578,_7336).

whatq(_7240,[whatq,lit(hva),_7356,_7385,_7419,!,_7453,_7477],_7331,_7333) --> 
    cc(hva,_7331,_7355),
    w(verb(use,_7282,pass),_7356,_7355,_7373),
    np1_accept(_7285,_7288::_7289,_7385,_7373,_7404),
    prep1(_7291,_7419,_7404,_7436),
    !,
    accept(_7453,_7436,_7468),
    pushstack(first,([noen],w(verb(use,_7282,fin)),np(_7285,_7288::_7289),w(prep(_7291)),npgap(_7275)),nil,_7468,_7551),
    qstatement(_7275,_7240,_7477,_7551,_7333).

whatq(which(_7247:thing):::_7243,[whatq,_7364,_7388,_7422,_7446,_7475,_7504,_7533,{},!,_7577],_7350,_7352) --> 
    whatcan(_7364,_7350,_7379),
    subject(_7294,_7295,_7388,_7379,_7407),
    redundant0(_7422,_7407,_7437),
    negation0(_7297,_7446,_7437,_7463),
    w(verb(_7301,_7302,_7303),_7475,_7463,_7492),
    reflexiv0(_7301,_7504,_7492,_7521),
    prepnom(_7307,_7533,_7521,_7550),
    {user:testmember(_7307,[regarding,with])},
    !,
    pushstack(first,(xnp(_7294,_7295),w(verb(_7301,_7302,_7303)),w(prep(_7307)),npgap(_7247:thing)),nil,_7550,_7651),
    statreal(_7243,_7577,_7651,_7352).

whatq(_7242:::_7243,[whatq,_7333,{},_7367,_7401,lit(om),!,_7446],_7319,_7321) --> 
    whatcan(_7333,_7319,_7348),
    {user:which_thing(_7279,_7242)},
    specific_phrase(_7282,_7283,_7367,_7348,_7386),
    negation0(_7285,_7401,_7386,_7418),
    cc(om,_7418,_7440),
    !,
    pushstack(first,(noun_phrase1(_7282,_7283),w(verb(know1,pres,fin)),npgap(_7279),[om]),nil,_7440,_7517),
    statreal(_7243,_7446,_7517,_7321).

whatq(_7242:::_7243,[whatq,_7374,{},_7408,_7442,_7471,_7500,lit(_7306),{},_7550,!,_7584],_7360,_7362) --> 
    whatcan(_7374,_7360,_7389),
    {user:which_thing(_7284,_7242)},
    specific_phrase(_7291,_7294::_7295,_7408,_7389,_7427),
    negation0(_7297,_7442,_7427,_7459),
    w(verb(_7301,_7302,_7303),_7471,_7459,_7488),
    reflexiv0(_7301,_7500,_7488,_7517),
    cc(_7306,_7517,_7539),
    {user:testmember(_7306,['på',om,til])},
    not_look_ahead(w(noun(_7324,_7325,_7326,_7327)),_7550,_7539,_7567),
    !,
    pushstack(first,(noun_phrase1(_7291,_7294::_7295),w(verb(_7301,_7302,_7303)),npgap(_7284)),nil,_7567,_7658),
    statreal(_7243,_7584,_7658,_7362).

whatq(_7242:::_7243,[whatq,_7367,{},_7401,_7435,_7464,_7493,lit(om),_7533,!,_7572],_7353,_7355) --> 
    whatcan(_7367,_7353,_7382),
    {user:which_thing(_7292,_7242)},
    specific_phrase(_7295,_7298::_7299,_7401,_7382,_7420),
    negation0(_7301,_7435,_7420,_7452),
    w(verb(_7305,_7306,_7307),_7464,_7452,_7481),
    reflexiv0(_7305,_7493,_7481,_7510),
    cc(om,_7510,_7532),
    noun_phrase1(_7287,_7288,_7533,_7532,_7552),
    !,
    pushstack(first,(noun_phrase1(_7295,_7298::_7299),w(verb(_7305,_7306,_7307)),npgap(_7292),w(prep(regarding)),np(_7287,_7288)),nil,_7552,_7677),
    statreal(_7243,_7572,_7677,_7355).

whatq(_7242:::_7243,[whatq,_7367,{},_7401,_7435,_7464,_7508,_7542,!,_7576],_7353,_7355) --> 
    whatcan(_7367,_7353,_7382),
    {user:which_thing(_7284,_7242)},
    specific_phrase(_7291,_7294::_7295,_7401,_7382,_7420),
    negation0(_7297,_7435,_7420,_7452),
    lexv(tv,_7300,_7301,_7302,_7464,_7452,_7487),
    np1(_7304,_7307::_7308,_7508,_7487,_7527),
    prepnom(_7310,_7542,_7527,_7559),
    !,
    pushstack(first,(noun_phrase1(_7291,_7294::_7295),w(verb(_7300,_7301,_7302)),np1(_7304,_7307::_7308),w(prep(_7310)),npgap(_7284)),nil,_7559,_7681),
    statreal(_7243,_7576,_7681,_7355).

whatq(_7242:::_7243,[whatq,_7368,_7392,_7426,_7455,_7484,_7518,!,{},_7562],_7354,_7356) --> 
    whatcan(_7368,_7354,_7383),
    specific_phrase(_7290,_7293::_7294,_7392,_7383,_7411),
    negation0(_7296,_7426,_7411,_7443),
    w(verb(_7300,_7301,_7302),_7455,_7443,_7472),
    noun_phrase1(_7284,_7287::_7288,_7484,_7472,_7503),
    prepnom(_7310,_7518,_7503,_7535),
    !,
    {user:which_thing(_7314,_7242)},
    pushstack(first,(noun_phrase1(_7290,_7293::_7294),w(verb(_7300,_7301,_7302)),npgap(_7314),w(prep(_7310)),np(_7284,_7287::_7288)),nil,_7535,_7670),
    statreal(_7243,_7562,_7670,_7356).

whatq(_7242:::_7243,[whatq,_7340,{},_7374,_7408,_7437,!,_7471],_7326,_7328) --> 
    whatcan(_7340,_7326,_7355),
    {user:which_thing(_7272,_7242)},
    specific_phrase(_7279,_7282::_7283,_7374,_7355,_7393),
    negation0(_7285,_7408,_7393,_7425),
    not_look_ahead(w(verb('_gjøre_',_7292,_7293)),_7437,_7425,_7454),
    !,
    pushstack(first,(noun_phrase1(_7279,_7282::_7283),w(verb(do1,pres,fin)),npgap(_7272)),nil,_7454,_7545),
    statreal(_7243,_7471,_7545,_7328).

whatq(_7242:::_7243,[whatq,_7343,{},_7377,_7411,_7440,_7469,!,_7503],_7329,_7331) --> 
    whatcan(_7343,_7329,_7358),
    {user:which_thing(_7275,_7242)},
    specific_phrase(_7282,_7285::_7286,_7377,_7358,_7396),
    negation0(_7288,_7411,_7396,_7428),
    w(verb(_7292,_7293,_7294),_7440,_7428,_7457),
    reflexiv0(_7292,_7469,_7457,_7486),
    !,
    pushstack(first,(noun_phrase1(_7282,_7285::_7286),w(verb(_7292,_7293,_7294)),npgap(_7275)),nil,_7486,_7577),
    statreal(_7243,_7503,_7577,_7331).

whatq(_7242:::_7243,[whatq,lit(hva),{},_7355,_7384,!,_7423],_7320,_7322) --> 
    cc(hva,_7320,_7344),
    {user:which_thing(_7269,_7242)},
    w(verb(know,_7281,fin),_7355,_7344,_7372),
    specific_phrase(_7284,_7287::_7288,_7384,_7372,_7403),
    !,
    pushstack(first,(noun_phrase1(_7284,_7287::_7288),lexv(tv,know1,_7281,fin),npgap(_7269)),nil,_7403,_7528),
    statreal(_7243,_7423,_7528,_7322).

whatq(_7240,[whatq,lit(hva),_7310,_7334],_7285,_7287) --> 
    cc(hva,_7285,_7309),
    doit(_7310,_7309,_7325),
    pushstack(first,(which,w(noun(thing,sin,u,n)),doit),nil,_7325,_7403),
    whichq(_7240,_7334,_7403,_7287).

whatq(_7240,[whatq,lit(hva),_7332,!,_7381,_7405,_7434],_7307,_7309) --> 
    cc(hva,_7307,_7331),
    lexv(iv,_7268,_7276,fin,_7332,_7331,_7355),
    !,
    accept(_7381,_7355,_7396),
    negation0(_7279,_7405,_7396,_7422),
    pushstack(first,(which,w(noun(thing,sin,u,n)),w(verb(_7268,pres,fin))),nil,_7422,_7472),
    whichq(_7240,_7434,_7472,_7309).

whenq(which(_7245):::_7243,[whenq,_7314,_7353,lit(det),_7388,!,_7417],_7300,_7302) --> 
    when_adverbialq(_7265,_7245,_7269::_7270,_7314,_7300,_7335),
    be(_7353,_7335,_7368),
    cc(det,_7368,_7387),
    that0(_7388,_7387,_7403),
    !,
    pushstack(free,xadverbial1(_7265,_7245,_7269::_7270),nil,_7403,_7458),
    statreal(_7243,_7417,_7458,_7302).

whenq(which(_7245):::_7243,[whenq,_7318,_7357,!,_7391,_7415],_7304,_7306) --> 
    when_adverbialq(_7262,_7245,_7266::_7267,_7318,_7304,_7339),
    look_ahead(w(noun(bus,_7281,_7282,n)),_7357,_7339,_7374),
    !,
    accept(_7391,_7374,_7406),
    pushstack(free,xadverbial1(_7262,_7245,_7266::_7267),nil,_7406,_7460),
    statreal(_7243,_7415,_7460,_7306).

whenq(which(_7245):::_7243,[whenq,_7352,_7391,_7420,{},!,_7464],_7338,_7340) --> 
    when_adverbialq(_7271,_7245,_7275::_7276,_7352,_7338,_7373),
    w(verb(go,_7288,fin),_7391,_7373,_7408),
    look_ahead(w(prep(_7295)),_7420,_7408,_7437),
    {user:testmember(_7295,[from,to])},
    !,
    pushstack(free,(w(noun(bus,sin,u,n)),w(verb(go,_7288,fin)),xadverbial1(_7271,_7245,_7275::_7276)),nil,_7437,_7509),
    statreal(_7243,_7464,_7509,_7340).

whenq(which(_7245):::_7243,[whenq,_7327,_7366,_7390,_7414,!,_7453,_7477,_7506],_7313,_7315) --> 
    when_adverbialq(_7270,_7245,_7279::_7280,_7327,_7313,_7348),
    be(_7366,_7348,_7381),
    detnexttime(_7390,_7381,_7405),
    np1(_7268,_7285::_7286,_7414,_7405,_7433),
    !,
    accept(_7453,_7433,_7468),
    negation0(_7288,_7477,_7468,_7494),
    whencomplex(_7268,_7285::_7286,_7270,_7245,_7279::_7280,_7243,_7506,_7494,_7315).

whenq(which(_7245):::_7243,[whenq,_7305,_7329,{},!,_7373],_7291,_7293) --> 
    when(_7305,_7291,_7320),
    look_ahead(w(prep(_7263)),_7329,_7320,_7346),
    {user:testmember(_7263,[from,to])},
    !,
    reject(_7373,_7346,_7293).

whenq(which(_7245):::_7243,[whenq,_7370,_7394,_7433,!,_7477,_7501,!,_7585,_7609],_7356,_7358) --> 
    when(_7370,_7356,_7385),
    preadverbial1(_7287,_7288,_7291::_7292,_7394,_7385,_7415),
    preadverbial1(_7280,_7281,_7284::_7285,_7433,_7415,_7454),
    !,
    accept(_7477,_7454,_7492),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_7492,_7545),adverbial1(_7314,_7245,_7318::_7319,_7501,_7545,_7562),
    !,
    accept(_7585,_7562,_7600),
    lock(last,_7600,_7727),
    pushstack(last,(adverbial1(in,_7245,_7318::_7319),adverbial1(_7287,_7288,_7291::_7292),adverbial1(_7280,_7281,_7284::_7285)),nil,_7727,_7733),
    question0(_7243,_7609,_7733,_7722),
    unlock(_7722,_7358).

whenq(which(_7245):::_7243,[whenq,_7357,_7381,_7410,!,_7454,_7478,!,_7561,_7585],_7343,_7345) --> 
    when(_7357,_7343,_7372),
    not_look_ahead([e],_7381,_7372,_7398),
    adverbial1(_7277,_7278,_7281::_7282,_7410,_7398,_7431),
    !,
    accept(_7454,_7431,_7469),
    pushstack(first,(prep(in),w(noun(time,sin,u,n))),nil,_7469,_7521),adverbial1(_7308,_7245,_7312::_7313,_7478,_7521,_7538),
    !,
    accept(_7561,_7538,_7576),
    lock(last,_7576,_7668),
    pushstack(last,(xadverbial1(in,_7245,_7312::_7313),xadverbial1(_7277,_7278,_7281::_7282)),nil,_7668,_7674),
    question0(_7243,_7585,_7674,_7663),
    unlock(_7663,_7345).

whenq(which(_7245):::_7243,[whenq,_7337,_7361,!,_7405,!,_7501],_7323,_7325) --> 
    when(_7337,_7323,_7352),
    adverb(_7268,_7269,pre,_7361,_7352,_7382),
    !,
    lock(exact,_7382,_7455),pushstack(exact,(prep(in),w(noun(time,sin,u,n))),nil,_7455,_7461),adverbial1(_7288,_7245,_7292::_7293,_7405,_7461,_7450),unlock(_7450,_7451),
    !,
    pushstack(free,(xadverbial1(in,_7245,_7292::_7293),xadverb(_7268,_7269)),nil,_7451,_7577),
    question0(_7243,_7501,_7577,_7325).

whenq(which(_7245):::_7243,[whenq,_7349,_7388,{},_7427,_7451,!,_7485],_7335,_7337) --> 
    howlongto(_7274,_7245,_7278::_7279,_7349,_7335,_7370),
    w(adj2(_7290,nil),_7388,_7370,_7405),
    {user:testmember(_7290,[easy,possible,good])},
    infinitive(_7427,_7405,_7442),
    w(verb(_7306,inf,fin),_7451,_7442,_7468),
    !,
    lock(last,_7468,_7565),
    pushstack(last,(someone,w(verb(_7306,pres,fin)),adverbial1(_7274,_7245,_7278::_7279)),nil,_7565,_7571),
    statement(_7243,_7485,_7571,_7560),
    unlock(_7560,_7337).

whenq(which(_7245):::_7243,[whenq,_7321,_7360,!,_7394],_7307,_7309) --> 
    howlongto(_7262,_7245,_7266::_7267,_7321,_7307,_7342),
    w(verb(_7278,_7279,fin),_7360,_7342,_7377),
    !,
    lock(last,_7377,_7446),
    pushstack(last,(w(verb(_7278,pres,fin)),adverbial1(_7262,_7245,_7266::_7267)),nil,_7446,_7452),
    statement(_7243,_7394,_7452,_7441),
    unlock(_7441,_7309).

whenq(which(_7245):::_7243,[whenq,_7315,!,_7359,_7432,_7461],_7301,_7303) --> 
    when_adverbialq(_7261,_7245,_7265::_7266,_7315,_7301,_7336),
    !,
    pushstack(free,xadverbial1(_7261,_7245,_7265::_7266),nil,_7336,_7407),question0(_7243,_7359,_7407,_7420),
    not_look_ahead([a],_7432,_7420,_7449),
    prep0(_7259,_7461,_7449,_7303).

detnexttime([detnexttime,lit(det),_7288,_7312,!],_7266,_7268) --> 
    cc(det,_7266,_7287),
    nexttime0(_7288,_7287,_7303),
    that0(_7312,_7303,_7268),
    !.

detnexttime([detnexttime,_7272,_7296,!],_7261,_7263) --> 
    nexttime(_7272,_7261,_7287),
    that0(_7296,_7287,_7263),
    !.

detnexttime([detnexttime,lit(at),!],_7260,_7262) --> 
    cc(at,_7260,_7262),
    !.

nexttime0([nexttime0,_7266],_7255,_7257) --> 
    nexttime(_7266,_7255,_7257).

nexttime0([nexttime0,[]],_7255,_7255) --> 
    [].

nexttime([nexttime,_7278,_7307],_7267,_7269) --> 
    w(adj2(next,nil),_7278,_7267,_7295),
    optional([gang],_7307,_7295,_7269).

whencomplex(_7240,_7247::_7248,_7242,_7243,_7250::_7251,_7245,[whencomplex,_7357,_7381,!,_7415,_7439],_7328,_7330) --> 
    do0(_7357,_7328,_7372),
    w(verb(_7283,_7284,finy),_7381,_7372,_7398),
    !,
    accept(_7415,_7398,_7430),
    pushstack(free,(np(_7240,_7247::_7248),w(verb(_7283,pres,fin)),adverbial1(_7242,_7243,_7250::_7251)),nil,_7430,_7518),
    statreal(_7245,_7439,_7518,_7330).

whencomplex(_7240,_7247::_7248,_7242,_7243,_7250::_7251,_7245,[whencomplex,_7339],_7310,_7312) --> 
    pushstack(free,(np(_7240,_7247::_7248),w(verb(be,pres,fin)),adverbial1(_7242,_7243,_7250::_7251)),nil,_7310,_7418),
    statreal(_7245,_7339,_7418,_7312).

verb0(_7240,[verb0,_7285,!,_7319],_7271,_7273) --> 
    w(verb(_7240,_7251,_7252),_7285,_7271,_7302),
    !,
    accept(_7319,_7302,_7273).

verb0(be1,[verb0,[]],_7259,_7259) --> 
    [].

subjectverb(_7240,_7241,_7242,[subjectverb,_7300,_7329,!],_7280,_7282) --> 
    w(verb(_7242,_7253,fin),_7300,_7280,_7317),
    subject(_7240,_7241,_7329,_7317,_7282),
    !.

subjectverb(_7240,_7241,_7242,[subjectverb,_7300,_7324,_7358],_7280,_7282) --> 
    aux1(_7300,_7280,_7315),
    subject(_7240,_7241,_7324,_7315,_7343),
    w(verb(_7242,inf,fin),_7358,_7343,_7282).

whereq(which(_7245):::_7243,[whereq,_7364,_7388,_7427,_7456,_7480,_7509,!,_7548,_7572,!,_7601,[],_7671,!,_7745],_7350,_7352) --> 
    dummyprep0(_7364,_7350,_7379),
    where_adverbial(_7289,_7245,_7291,_7388,_7379,_7409),
    w(verb(_7295,_7296,fin),_7427,_7409,_7444),
    thereit0(_7456,_7444,_7471),
    not_look_ahead(w(nb(_7303,_7304)),_7480,_7471,_7497),
    subject(_7306,_7307,_7509,_7497,_7528),
    !,
    accept(_7548,_7528,_7563),
    dummyprep0(_7572,_7563,_7587),
    !,
    accept(_7601,_7587,_7616),
    pushstack(free,adverbial1(_7289,_7245,_7291),nil,_7616,_7670),[],
    pushstack(first,(xnp(_7306,_7307),w(verb(_7295,_7296,fin))),nil,_7670,_7715),substatement1(_7243,_7671,_7715,_7728),
    !,
    accept(_7745,_7728,_7352).

whereq(which(_7245):::_7243,[whereq,{},_7360,_7384,!,_7418,!,_7484,_7553],_7336,_7338) --> 
    {user:(\+value(dialog,1))},
    where(_7360,_7336,_7375),
    w(verb(go,_7278,fin),_7384,_7375,_7401),
    !,
    lock(exact,_7401,_7438),pushstack(exact,w(noun(place,sin,u,n)),nil,_7438,_7444),adverbial1(nil,_7245,_7295::_7296,_7418,_7444,_7433),unlock(_7433,_7434),
    !,
    pushstack(free,(w(verb(go,pres,fin)),adverbial1(nil,_7245,_7295::_7296)),nil,_7434,_7528),ynq(_7243,_7484,_7528,_7541),
    dummyprep0(_7553,_7541,_7338).

whereq(which(_7245):::_7243,[whereq,_7353,_7377,_7406,!,_7450,!,_7546],_7339,_7341) --> 
    where(_7353,_7339,_7368),
    not_look_ahead(w(prep(after)),_7377,_7368,_7394),
    adverbial1(_7271,_7272,_7275::_7276,_7406,_7394,_7427),
    !,
    lock(exact,_7427,_7500),pushstack(exact,(prep(in),w(noun(place,sin,u,n))),nil,_7500,_7506),adverbial1(_7304,_7245,_7308::_7309,_7450,_7506,_7495),unlock(_7495,_7496),
    !,
    pushstack(free,(adverbial1(in,_7245,_7308::_7309),adverbial1(_7271,_7272,_7275::_7276)),nil,_7496,_7626),
    question0(_7243,_7546,_7626,_7341).

whereq(which(_7245):::_7243,[whereq,_7338,_7377,lit(det),_7412,!,[],_7495],_7324,_7326) --> 
    where_adverbial(_7279,_7245,_7283::_7284,_7338,_7324,_7359),
    be(_7377,_7359,_7392),
    cc(det,_7392,_7411),
    w(adj2(_7276,_7277),_7412,_7411,_7429),
    !,
    pushstack(free,adverbial1(_7279,_7245,_7283::_7284),nil,_7429,_7494),[],
    pushstack(first,([det],be,w(adj2(_7276,_7277))),nil,_7494,_7533),
    substatement1(_7243,_7495,_7533,_7326).

whereq(which(_7245):::_7243,[whereq,_7314,_7353,lit(det),_7388,!,_7417],_7300,_7302) --> 
    where_adverbial(_7265,_7245,_7269::_7270,_7314,_7300,_7335),
    be(_7353,_7335,_7368),
    cc(det,_7368,_7387),
    that0(_7388,_7387,_7403),
    !,
    pushstack(free,adverbial1(_7265,_7245,_7269::_7270),nil,_7403,_7462),
    statreal(_7243,_7417,_7462,_7302).

whereq(_7240,[whereq,_7308,_7332,_7356],_7294,_7296) --> 
    where(_7308,_7294,_7323),
    be(_7332,_7323,_7347),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),w(verb(be1,pres,fin))),nil,_7347,_7424),
    ppq(_7240,_7356,_7424,_7296).

whereq(which(_7245):::_7243,[whereq,_7287,_7311,!,_7340],_7273,_7275) --> 
    where(_7287,_7273,_7302),
    many1(_7311,_7302,_7326),
    !,
    reject(_7340,_7326,_7275).

whereq(_7240,[whereq,_7302,_7326,_7350],_7288,_7290) --> 
    where(_7302,_7288,_7317),
    aux1(_7326,_7317,_7341),
    pushstack(first,(prep(in),which,w(noun(place,sin,u,n)),doit),nil,_7341,_7446),
    ppq(_7240,_7350,_7446,_7290).

whereq(_7240,[whereq,_7294,_7318,_7342],_7280,_7282) --> 
    where(_7294,_7280,_7309),
    look_ahead_vp(_7318,_7309,_7333),
    pushstack(first,(which,w(noun(place,sin,u,n))),nil,_7333,_7380),
    whichq(_7240,_7342,_7380,_7282).

when_adverbial(in,_7241,_7244::_7245,[when_adverbial,_7308,_7332,!,{}],_7288,_7290) --> 
    which(_7308,_7288,_7323),
    np1(_7241,_7244::_7245,_7332,_7323,_7290),
    !,
    {user:testconstraint(_7241,time)}.

when_adverbialq(in,_7250:time,_7244::_7250 isa time and _7244,[when_adverbialq,_7297],_7277,_7279) --> 
    when(_7297,_7277,_7279).

when_adverbial(in,_7250:time,_7244::_7250 isa time and _7244,[when_adverbial,_7297],_7277,_7279) --> 
    whenx(_7297,_7277,_7279).

where_adverbial(nil,_7241,_7242,[where_adverbial,_7302,_7326,!,{}],_7282,_7284) --> 
    which(_7302,_7282,_7317),
    np1(_7241,_7242,_7326,_7317,_7284),
    !,
    {user:testconstraint(_7241,place)}.

where_adverbial(nil,_7241,_7242,[where_adverbial,lit(hvor),_7308,!],_7277,_7279) --> 
    cc(hvor,_7277,_7307),
    np00(place,_7241,_7242,_7308,_7307,_7279),
    !.

dummyprep0([dummyprep0,_7269,!],_7258,_7260) --> 
    dummyprep(_7269,_7258,_7260),
    !.

dummyprep0([dummyprep0,[]],_7255,_7255) --> 
    [].

dummyprep([dummyprep,_7274,!,_7308],_7263,_7265) --> 
    prep1(from,_7274,_7263,_7291),
    !,
    accept(_7308,_7291,_7265).

dummyprep([dummyprep,_7274,!,_7308],_7263,_7265) --> 
    prep1(to,_7274,_7263,_7291),
    !,
    accept(_7308,_7291,_7265).

wherefromq(_7240,[wherefromq,_7299,!,_7328],_7285,_7287) --> 
    wherefrom(_7299,_7285,_7314),
    !,
    pushstack(first,(prep(from),which,w(noun(place,sin,u,n))),nil,_7314,_7397),
    ppq(_7240,_7328,_7397,_7287).

whoq(_7240,[whoq,_7324,_7348,_7377,!,_7411],_7310,_7312) --> 
    who(_7324,_7310,_7339),
    look_ahead(w(noun(_7273,sin,def,n)),_7348,_7339,_7365),
    w(verb(_7265,_7266,fin),_7377,_7365,_7394),
    !,
    pushstack(first,(which,w(noun(agent,sin,u,n)),w(verb(_7265,_7266,fin))),nil,_7394,_7449),
    whichq(_7240,_7411,_7449,_7312).

whoq(_7240,[whoq,_7291,_7315],_7277,_7279) --> 
    who(_7291,_7277,_7306),
    pushstack(first,(which,w(noun(agent,sin,u,n))),nil,_7306,_7353),
    whichq(_7240,_7315,_7353,_7279).

whoseq(_7240,[whoseq,_7316,_7340,_7394],_7302,_7304) --> 
    whose(_7316,_7302,_7331),
    noun(_7263,_7264,u,n,_7267,_7268,_7340,_7331,_7367),
    pushstack(first,(who,w(verb(have,pres,fin)),a,noun(_7263,_7264,u,n,_7267,_7268),that),nil,_7367,_7528),
    whoq(_7240,_7394,_7528,_7304).

whyq(explain:::_7243,[whyq,_7281,_7305],_7267,_7269) --> 
    hvorfor(_7281,_7267,_7296),
    isq(_7243,_7305,_7296,_7269).

whyq(explain:::_7243,[whyq,_7281,_7305],_7267,_7269) --> 
    hvorfor(_7281,_7267,_7296),
    ynq(_7243,_7305,_7296,_7269).

whyq(explain:::_7243,[whyq,_7281,_7305],_7267,_7269) --> 
    hvorfor(_7281,_7267,_7296),
    hasq(_7243,_7305,_7296,_7269).

howq(doit:::reply('OK'),[howq,lit(hvordan),_7311,lit(det),!,_7356],_7286,_7288) --> 
    cc(hvordan,_7286,_7310),
    w(verb(go,_7264,fin),_7311,_7310,_7328),
    cc(det,_7328,_7350),
    !,
    skip_rest(_7356,_7350,_7288).

howq(explain:::_7243,[howq,lit(hvordan),_7326,_7350,_7379,!,_7408],_7301,_7303) --> 
    cc(hvordan,_7301,_7325),
    erdetaa0(_7326,_7325,_7341),
    w(verb(_7268,inf,fin),_7350,_7341,_7367),
    mex0(_7379,_7367,_7394),
    !,
    pushstack(first,([jeg],w(verb(_7268,pres,fin))),nil,_7394,_7418),
    statreal1(_7243,_7408,_7418,_7303).

howq(explain:::_7243,[howq,lit(hvorfor),_7320,!,_7354],_7295,_7297) --> 
    cc(hvorfor,_7295,_7319),
    w(verb(_7262,inf,fin),_7320,_7319,_7337),
    !,
    pushstack(first,([jeg],w(verb(_7262,pres,fin))),nil,_7337,_7364),
    statreal1(_7243,_7354,_7364,_7297).

howq(explain:::_7243,[howq,lit(hvordan),_7318,[],_7392],_7293,_7295) --> 
    cc(hvordan,_7293,_7317),
    look_ahead(w(verb(be,_7263,fin)),_7318,_7317,_7335),
    pushstack(free,xadverbial1(how,nil,_7273::_7273),nil,_7335,_7391),[],
    isq(_7243,_7392,_7391,_7295).

howq(explain:::_7243,[howq,_7305,_7329,_7353,_7387],_7291,_7293) --> 
    how(_7305,_7291,_7320),
    be(_7329,_7320,_7344),
    np1_accept(_7266,_7267,_7353,_7344,_7372),
    pushstack(first,(xnp(_7266,_7267),w(verb(be,pres,fin))),nil,_7372,_7428),
    substatement1(_7243,_7387,_7428,_7293).

howq(explain:::_7243,[howq,_7311,_7335,lit(det),_7370,!,_7404],_7297,_7299) --> 
    how(_7311,_7297,_7326),
    be(_7335,_7326,_7350),
    cc(det,_7350,_7369),
    negation0(_7274,_7370,_7369,_7387),
    !,
    pushstack(first,([det],w(verb(be,pres,fin))),nil,_7387,_7414),
    substatement1(_7243,_7404,_7414,_7299).

howq(explain:::_7243,[howq,_7295,_7339,_7363,!,_7392],_7281,_7283) --> 
    lexv(iv,tell,imp,fin,_7295,_7281,_7318),
    me0(_7339,_7318,_7354),
    how(_7363,_7354,_7378),
    !,
    statreal1(_7243,_7392,_7378,_7283).

howq(_7240,[howq,_7290,_7314,_7338,!,_7367],_7276,_7278) --> 
    how(_7290,_7276,_7305),
    be(_7314,_7305,_7329),
    thereit(_7338,_7329,_7353),
    !,
    pushstack(first,whatbe,nil,_7353,_7405),
    whatq(_7240,_7367,_7405,_7278).

howq(_7240,[howq,_7297,_7321,lit(det),_7356,!,_7390],_7283,_7285) --> 
    how(_7297,_7283,_7312),
    be(_7321,_7312,_7336),
    cc(det,_7336,_7355),
    prep1(with,_7356,_7355,_7373),
    !,
    pushstack(first,whatbe,nil,_7373,_7428),
    whatq(_7240,_7390,_7428,_7285).

howq(explain:::_7243,[howq,_7281,_7305],_7267,_7269) --> 
    how(_7281,_7267,_7296),
    ynq(_7243,_7305,_7296,_7269).

howq(explain:::_7243,[howq,_7281,_7305],_7267,_7269) --> 
    how(_7281,_7267,_7296),
    hasq(_7243,_7305,_7296,_7269).

erdetaa0([erdetaa0,_7282,lit(det),lit('å'),!,_7333],_7271,_7273) --> 
    be(_7282,_7271,_7297),
    cc(det,_7297,_7316),
    cc('å',_7316,_7327),
    !,
    accept(_7333,_7327,_7273).

erdetaa0([erdetaa0,[]],_7255,_7255) --> 
    [].

howlongto(_7240,_7241,_7244::_7245,[howlongto,_7318,lit(det),lit(lenge),_7364,_7393],_7298,_7300) --> 
    be(_7318,_7298,_7333),
    cc(det,_7333,_7352),
    cc(lenge,_7352,_7363),
    prep1(to,_7364,_7363,_7381),
    lock(exact,_7381,_7410),
    pushstack(exact,['når'],nil,_7410,_7416),
    when_adverbial(_7240,_7241,_7244::_7245,_7393,_7416,_7405),
    unlock(_7405,_7300).

howlongto(_7240,_7241,_7244::_7245,[howlongto,lit(hvor),lit(lenge),_7345,lit(det),_7380,_7409],_7303,_7305) --> 
    cc(hvor,_7303,_7333),
    cc(lenge,_7333,_7344),
    be(_7345,_7344,_7360),
    cc(det,_7360,_7379),
    prep1(to,_7380,_7379,_7397),
    lock(exact,_7397,_7426),
    pushstack(exact,['når'],nil,_7426,_7432),
    when_adverbial(_7240,_7241,_7244::_7245,_7409,_7432,_7421),
    unlock(_7421,_7305).

howlongto(_7240,_7241,_7244::_7245,[howlongto,_7304,_7343,_7367,_7391],_7284,_7286) --> 
    when_adverbial(_7240,_7241,_7244::_7245,_7304,_7284,_7325),
    be(_7343,_7325,_7358),
    thereit(_7367,_7358,_7382),
    that0(_7391,_7382,_7286).

howadjq(_7240,[howadjq,_7366,_7390,{},_7429,{},lit(det),_7479,_7508,_7532,_7561,!,_7632],_7352,_7354) --> 
    hvor(_7366,_7352,_7381),
    howadj1(_7275,_7390,_7381,_7407),
    {user:testmember(_7275,[duration])},
    w(verb(_7286,_7287,fin),_7429,_7407,_7446),
    {user:testmember(_7286,[take,be])},
    cc(det,_7446,_7478),
    not_look_ahead(['å'],_7479,_7478,_7496),
    redundant0(_7508,_7496,_7523),
    not_look_ahead(w(prep(with)),_7532,_7523,_7549),
    pushstack(first,(which,w(noun(_7275,sin,u,n)),w(verb(_7286,_7287,fin))),nil,_7549,_7602),whichq(_7240,_7561,_7602,_7615),
    !,
    accept(_7632,_7615,_7354).

howadjq(_7240,[howadjq,_7330,_7354,_7383,{},!,_7422],_7316,_7318) --> 
    hvor(_7330,_7316,_7345),
    howadj1(_7269,_7354,_7345,_7371),
    docan(_7383,_7371,_7398),
    {user:testmember(_7269,[frequency,speed,lateness,earliness,duration,distance])},
    !,
    pushstack(first,(prep(with),which,w(noun(_7269,sin,u,n)),doit),nil,_7398,_7519),
    ppq(_7240,_7422,_7519,_7318).

howadjq(_7240,[howadjq,_7346,_7370,{},_7409,{},!,_7453],_7332,_7334) --> 
    hvor(_7346,_7332,_7361),
    howadj1(_7278,_7370,_7361,_7387),
    {user:testmember(_7278,[frequency,earliness,lateness])},
    w(verb(_7274,_7294,_7276),_7409,_7387,_7426),
    {user:(\+_7274=be)},
    !,
    pushstack(first,(prep(with),which,w(noun(_7278,sin,u,n)),w(verb(_7274,pres,_7276))),nil,_7426,_7521),
    ppq(_7240,_7453,_7521,_7334).

howadjq(_7240,[howadjq,_7316,_7340,_7369,_7403,_7427],_7302,_7304) --> 
    hvor(_7316,_7302,_7331),
    howadj1(_7269,_7340,_7331,_7357),
    gmem(_7269,[distance],_7369,_7357,_7388),
    be(_7403,_7388,_7418),
    pushstack(first,(which,w(noun(_7269,sin,u,n)),w(verb(have,pres,fin))),nil,_7418,_7465),
    whichq(_7240,_7427,_7465,_7304).

howadjq(which(_7250:time):::_7250 isa time and _7246,[howadjq,_7357,_7381,_7410,lit(det),lit(til),_7461,!,_7500,_7539],_7343,_7345) --> 
    hvor(_7357,_7343,_7372),
    howadj1(duration,_7381,_7372,_7398),
    w(verb(be,_7298,fin),_7410,_7398,_7427),
    cc(det,_7427,_7449),
    cc(til,_7449,_7460),
    clausal_object0(_7305,_7306,_7461,_7460,_7480),
    !,
    np00(time,_7250:time,_7291,_7500,_7480,_7521),
    pushstack(first,(xnp(_7305,_7306),w(verb(exist,_7298,fin)),xadverbial1(nil,_7250,_7291)),nil,_7521,_7611),
    statreal(_7246,_7539,_7611,_7345).

howadjq(_7240,[howadjq,_7354,_7398,_7422,_7451,_7480,_7514,!,_7548,_7587],_7340,_7342) --> 
    whichg00(duration,_7283,_7279,_7240,_7354,_7340,_7377),
    hvor(_7398,_7377,_7413),
    howadj1(duration,_7422,_7413,_7439),
    w(verb(be,_7292,fin),_7451,_7439,_7468),
    np1_accept(_7295,_7296,_7480,_7468,_7499),
    w(adj2(_7300,nil),_7514,_7499,_7531),
    !,
    np00(duration,_7279,_7280,_7548,_7531,_7569),
    pushstack(first,(xnp(_7295,_7296),w(verb(be,_7292,fin)),w(adj2(_7300,nil)),xadverbial1(nil,_7279,_7280)),nil,_7569,_7660),
    statreal(_7283,_7587,_7660,_7342).

howadjq(_7240,[howadjq,_7347,_7391,_7415,_7444,_7473,_7507,!,_7541,_7580],_7333,_7335) --> 
    whichg00(duration,_7280,_7276,_7240,_7347,_7333,_7370),
    hvor(_7391,_7370,_7406),
    howadj1(duration,_7415,_7406,_7432),
    w(verb(have,_7289,fin),_7444,_7432,_7461),
    subject(_7292,_7293,_7473,_7461,_7492),
    w(verb(_7297,past,part),_7507,_7492,_7524),
    !,
    np00(duration,_7276,_7277,_7541,_7524,_7562),
    pushstack(first,(xnp(_7292,_7293),w(verb(_7297,past,fin)),xadverbial1(nil,_7276,_7277)),nil,_7562,_7653),
    statreal(_7280,_7580,_7653,_7335).

howadjq(which(_7248):::_7248 isa _7251 and _7246,[howadjq,_7364,_7388,_7417,_7446,_7480,!,{},_7529,_7568],_7350,_7352) --> 
    hvor(_7364,_7350,_7379),
    howadj1(_7251,_7388,_7379,_7405),
    w(verb(have,_7298,fin),_7417,_7405,_7434),
    subject(_7301,_7302,_7446,_7434,_7465),
    object(_7304,_7305,_7480,_7465,_7499),
    !,
    {user:_7290=(_7248:_7251)},
    np00(_7251,_7290,_7291,_7529,_7499,_7550),
    pushstack(first,(xnp(_7301,_7302),w(verb(have,_7298,fin)),xnp(_7304,_7305),xadverbial1(nil,_7290,_7291)),nil,_7550,_7672),
    statreal(_7246,_7568,_7672,_7352).

howadjq(which(_7248):::_7248 isa _7251 and _7246,[howadjq,_7372,_7396,_7425,{},_7464,_7493,!,{},_7542,_7581],_7358,_7360) --> 
    hvor(_7372,_7358,_7387),
    howadj1(duration,_7396,_7387,_7413),
    w(verb(_7296,_7297,fin),_7425,_7413,_7442),
    {user:(\+testmember(_7296,[expect,be]))},
    not_look_ahead([det],_7464,_7442,_7481),
    np1(_7315,_7316,_7493,_7481,_7512),
    !,
    {user:_7289=(_7248:duration)},
    np00(_7251,_7289,_7290,_7542,_7512,_7563),
    pushstack(first,(xnp(_7315,_7316),w(verb(_7296,_7297,fin)),xnp(_7289,_7290)),nil,_7563,_7653),
    statreal(_7246,_7581,_7653,_7360).

howadjq(_7240,[howadjq,lit(hvor),lit(lenge),_7357,lit(det),_7397,!,_7431,_7465],_7321,_7323) --> 
    cc(hvor,_7321,_7345),
    cc(lenge,_7345,_7356),
    w(verb(be,pres,fin),_7357,_7356,_7374),
    cc(det,_7374,_7396),
    w(prep(to),_7397,_7396,_7414),
    !,
    clausal_object0(_7272,_7273,_7431,_7414,_7450),
    pushstack(first,(['når'],w(verb(be,pres,fin)),xnp(_7272,_7273)),nil,_7450,_7506),
    whenq(_7240,_7465,_7506,_7323).

howadjq(_7240,[howadjq,lit(hvor),lit(mange),_7365,_7394,lit(det),_7434,!,_7468],_7329,_7331) --> 
    cc(hvor,_7329,_7353),
    cc(mange,_7353,_7364),
    w(noun(minute,plu,u,n),_7365,_7364,_7382),
    w(verb(be,pres,fin),_7394,_7382,_7411),
    cc(det,_7411,_7433),
    w(prep(to),_7434,_7433,_7451),
    !,
    pushstack(free,(['når'],w(verb(be,pres,fin)),[det],[at]),nil,_7451,_7478),
    whenq(_7240,_7468,_7478,_7331).

howadjq(_7240,[howadjq,_7339,_7363,lit(blir),_7403,_7437,!,_7471],_7325,_7327) --> 
    hvor(_7339,_7325,_7354),
    howadj1(_7278,_7363,_7354,_7380),
    cc(blir,_7380,_7402),
    np1(_7275,_7276,_7403,_7402,_7422),
    w(verb(_7287,past,part),_7437,_7422,_7454),
    !,
    pushstack(first,(prep(with),which,w(noun(_7278,sin,u,n)),w(verb(_7287,pres,pass)),xnp(_7275,_7276)),nil,_7454,_7570),
    ppq(_7240,_7471,_7570,_7327).

howadjq(_7240,[howadjq,_7365,_7389,{},_7428,_7452,_7486,{},_7525,_7564],_7351,_7353) --> 
    hvor(_7365,_7351,_7380),
    howadj1(_7284,_7389,_7380,_7406),
    {user:testmember(_7284,[frequency])},
    be(_7428,_7406,_7443),
    subject(_7293,_7294,_7452,_7443,_7471),
    w(adj2(_7298,nil),_7486,_7471,_7503),
    {user:testmember(_7298,[delayed,tooearly])},
    np00(frequency,_7281,_7282,_7525,_7503,_7546),
    pushstack(first,(xnp(_7293,_7294),w(verb(be,pres,fin)),w(adj2(_7298,nil)),w(prep(with)),xnp(_7281,_7282)),nil,_7546,_7636),
    statreal1(_7240,_7564,_7636,_7353).

howadjq(_7240,[howadjq,_7324,_7348,{},_7387,_7411],_7310,_7312) --> 
    hvor(_7324,_7310,_7339),
    howadj1(_7269,_7348,_7339,_7365),
    {user:(\+testmember(_7269,[duration,distance,time]))},
    be(_7387,_7365,_7402),
    pushstack(first,(which,w(noun(_7269,sin,u,n)),w(verb(have,pres,fin))),nil,_7402,_7449),
    whichq(_7240,_7411,_7449,_7312).

howadjq(_7240,[howadjq,_7347,_7371,_7400,_7424,_7458,{},_7497,!,_7599],_7333,_7335) --> 
    hvor(_7347,_7333,_7362),
    howadj1(_7266,_7371,_7362,_7388),
    doit(_7400,_7388,_7415),
    np(_7268,_7269,_7424,_7415,_7443),
    w(verb(_7273,_7274,_7275),_7458,_7443,_7475),
    {user:testmember(_7273,[use,take])},
    pushstack(first,(which,w(noun(_7266,sin,u,n)),w(verb(_7273,inf,fin)),xnp(_7268,_7269)),nil,_7475,_7569),whichq(_7240,_7497,_7569,_7582),
    !,
    accept(_7599,_7582,_7335).

howadjq(which(_7245):::_7243,[howadjq,_7375,_7399,{},_7438,{},_7477,!,_7516,!,_7621],_7361,_7363) --> 
    hvor(_7375,_7361,_7390),
    howadj1(_7274,_7399,_7390,_7416),
    {user:testmember(_7274,[speed,distance])},
    w(verb(_7287,pres,fin),_7438,_7416,_7455),
    {user:(\+testmember(_7287,[know,be]))},
    np1(_7302,_7303,_7477,_7455,_7496),
    !,
    pushstack(first,(xnp(_7302,_7303),w(verb(_7287,pres,fin)),w(prep(with)),the(_7245),w(noun(_7274,sin,u,n))),nil,_7496,_7591),statreal(_7243,_7516,_7591,_7604),
    !,
    accept(_7621,_7604,_7363).

howadjq(_7240,[howadjq,_7325,lit(lenge),_7360,_7384,!,_7418],_7311,_7313) --> 
    hvor(_7325,_7311,_7340),
    cc(lenge,_7340,_7359),
    be(_7360,_7359,_7375),
    not_look_ahead([det],_7384,_7375,_7401),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),w(verb(be,pres,fin))),nil,_7401,_7456),
    ppq(_7240,_7418,_7456,_7313).

howadjq(_7240,[howadjq,_7361,_7385,{},_7424,{},lit(det),_7474,_7498,!,_7532,_7556,!,_7627],_7347,_7349) --> 
    hvor(_7361,_7347,_7376),
    howadj1(_7278,_7385,_7376,_7402),
    {user:testmember(_7278,[duration])},
    w(verb(_7289,pres,fin),_7424,_7402,_7441),
    {user:testmember(_7289,[take,be])},
    cc(det,_7441,_7473),
    redundant0(_7474,_7473,_7489),
    prep(with,_7498,_7489,_7515),
    !,
    accept(_7532,_7515,_7547),
    pushstack(first,(which,w(noun(_7278,sin,u,n)),w(verb(_7289,pres,fin))),nil,_7547,_7597),whichq(_7240,_7556,_7597,_7610),
    !,
    accept(_7627,_7610,_7349).

howadjq(_7240,[howadjq,_7380,_7404,{},_7443,{},lit(det),_7493,_7522,_7546,!,_7580,_7604,!,_7675],_7366,_7368) --> 
    hvor(_7380,_7366,_7395),
    howadj1(_7281,_7404,_7395,_7421),
    {user:testmember(_7281,[duration])},
    w(verb(_7292,pres,fin),_7443,_7421,_7460),
    {user:testmember(_7292,[take])},
    cc(det,_7460,_7492),
    not_look_ahead(['å'],_7493,_7492,_7510),
    redundant0(_7522,_7510,_7537),
    look_ahead(w(prep(_7313)),_7546,_7537,_7563),
    !,
    accept(_7580,_7563,_7595),
    pushstack(first,(which,w(noun(_7281,sin,u,n)),w(verb(_7292,pres,fin)),w(noun(vehicle,sin,def,n))),nil,_7595,_7645),whichq(_7240,_7604,_7645,_7658),
    !,
    accept(_7675,_7658,_7368).

howadjq(_7240,[howadjq,_7357,_7381,{},_7420,lit(det),_7460,{},_7499,_7523,!,_7594],_7343,_7345) --> 
    hvor(_7357,_7343,_7372),
    howadj1(_7272,_7381,_7372,_7398),
    {user:testmember(_7272,[duration])},
    w(verb(_7283,pres,fin),_7420,_7398,_7437),
    cc(det,_7437,_7459),
    not_look_ahead(['å'],_7460,_7459,_7477),
    {user:testmember(_7283,[take,be])},
    redundant0(_7499,_7477,_7514),
    pushstack(first,(which,w(noun(_7272,sin,u,n)),w(verb(exist,pres,fin))),nil,_7514,_7564),whichq(_7240,_7523,_7564,_7577),
    !,
    accept(_7594,_7577,_7345).

howadjq(_7240,[howadjq,_7296,_7320,_7349],_7282,_7284) --> 
    ihvor(_7296,_7282,_7311),
    howadj1(_7256,_7320,_7311,_7337),
    pushstack(first,(which,w(noun(_7256,sin,u,n))),nil,_7337,_7387),
    whichq(_7240,_7349,_7387,_7284).

howadjq(_7240,[howadjq,_7312,lit(lenge),_7347,!,_7376],_7298,_7300) --> 
    hvor(_7312,_7298,_7327),
    cc(lenge,_7327,_7346),
    be(_7347,_7346,_7362),
    !,
    pushstack(first,(w(prep(with)),which,w(noun(duration,sin,u,n)),be),nil,_7362,_7442),
    ppq(_7240,_7376,_7442,_7300).

howadjq(_7240,[howadjq,_7315,_7339,_7363,_7387,_7416],_7301,_7303) --> 
    hvor(_7315,_7301,_7330),
    meny(_7339,_7330,_7354),
    be(_7363,_7354,_7378),
    w(noun(clock,_7276,_7277,_7278),_7387,_7378,_7404),
    pushstack(first,([hva],be,the,w(noun(clock,sin,def,n))),nil,_7404,_7482),
    whatq(_7240,_7416,_7482,_7303).

howadjq(_7240,[howadjq,_7330,lit(lenge),_7365,{},!,_7409],_7316,_7318) --> 
    hvor(_7330,_7316,_7345),
    cc(lenge,_7345,_7364),
    w(verb(_7271,pres,fin),_7365,_7364,_7382),
    {user:_7271\==take},
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(_7271,pres,fin))),nil,_7382,_7477),
    ppq(_7240,_7409,_7477,_7318).

howadjq(_7240,[howadjq,_7322,_7346,_7375,!,_7409],_7308,_7310) --> 
    hvor(_7322,_7308,_7337),
    howadj1(duration,_7346,_7337,_7363),
    w(verb(use,pres,fin),_7375,_7363,_7392),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_7392,_7477),
    ppq(_7240,_7409,_7477,_7310).

howadjq(_7240,[howadjq,_7313,_7337,_7366,_7390,!,_7519],_7299,_7301) --> 
    hvor(_7313,_7299,_7328),
    howadj1(_7257,_7337,_7328,_7354),
    doit(_7366,_7354,_7381),
    pushstack(first,(prep(with),which,w(noun(_7257,sin,u,n)),doit),nil,_7381,_7489),ppq(_7240,_7390,_7489,_7502),
    !,
    accept(_7519,_7502,_7301).

howadjq(_7240,[howadjq,_7313,_7337,_7366,_7390,_7414],_7299,_7301) --> 
    hvor(_7313,_7299,_7328),
    howadj1(duration,_7337,_7328,_7354),
    betake(_7366,_7354,_7381),
    thereit(_7390,_7381,_7405),
    pushstack(first,([hva],w(verb(be,pres,fin)),w(noun(duration,sin,def,n))),nil,_7405,_7424),
    whatq(_7240,_7414,_7424,_7301).

howadjq(_7240,[howadjq,_7329,_7353,_7382,_7411,!,_7445],_7315,_7317) --> 
    hvor(_7329,_7315,_7344),
    howadj1(duration,_7353,_7344,_7370),
    w(verb(take,pres,fin),_7382,_7370,_7399),
    not_look_ahead([det],_7411,_7399,_7428),
    !,
    pushstack(first,(prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))),nil,_7428,_7513),
    ppq(_7240,_7445,_7513,_7317).

howmuchq(which(_7245):::_7243,[howmuchq,_7337,lit(lenge),_7372,lit(det),!,_7417],_7323,_7325) --> 
    hvor(_7337,_7323,_7352),
    cc(lenge,_7352,_7371),
    w(verb(be,_7281,fin),_7372,_7371,_7389),
    cc(det,_7389,_7411),
    !,
    pushstack(first,(which,w(noun(duration,plu,u,n)),w(verb(be,_7281,fin)),[det]),nil,_7411,_7455),
    whichq(which(_7245):::_7243,_7417,_7455,_7325).

howmuchq(which(_7245):::_7243,[howmuchq,_7354,_7378,_7402,{},lit(det),lit('å'),_7463,!,_7511],_7340,_7342) --> 
    hvor(_7354,_7340,_7369),
    much(_7378,_7369,_7393),
    w(verb(_7284,_7285,fin),_7402,_7393,_7419),
    {user:testmember(_7284,[cost])},
    cc(det,_7419,_7451),
    cc('å',_7451,_7462),
    pushstack(first,([noen],[vil]),nil,_7462,_7476),clausal_object1(_7307,_7308,_7463,_7476,_7491),
    !,
    pushstack(first,(xnp(_7307,_7308),w(verb(_7284,pres,fin)),npgap(_7245)),nil,_7491,_7582),
    statreal1(_7243,_7511,_7582,_7342).

howmuchq(test:::_7243,[howmuchq,_7337,_7361,_7385,_7414,_7448,!,_7482,_7506],_7323,_7325) --> 
    hvor(_7337,_7323,_7352),
    much(_7361,_7352,_7376),
    w(verb(be,_7283,fin),_7385,_7376,_7402),
    np0_accept(_7286,_7287,_7414,_7402,_7433),
    w(adj2(_7277,nil),_7448,_7433,_7465),
    !,
    accept(_7482,_7465,_7497),
    pushstack(first,(xnp(_7286,_7287),w(verb(be,pres,fin)),w(adj2(_7277,nil))),nil,_7497,_7547),
    statemen1(real,_7243,_7506,_7547,_7325).

howmuchq(_7240,[howmuchq,_7300,_7324,_7348,!,_7382],_7286,_7288) --> 
    hvor(_7300,_7286,_7315),
    many1(_7324,_7315,_7339),
    look_ahead(w(verb(be,_7264,fin)),_7348,_7339,_7365),
    !,
    pushstack(first,[hva],nil,_7365,_7392),
    whatq(_7240,_7382,_7392,_7288).

howmuchq(howmany(_7245):::_7243,[howmuchq,_7294,_7318,_7342],_7280,_7282) --> 
    hvor(_7294,_7280,_7309),
    many1(_7318,_7309,_7333),
    pushstack(first,which,nil,_7333,_7380),
    whichq(which(_7245):::_7243,_7342,_7380,_7282).

howmuchq(howmany(_7245):::_7243,[howmuchq,_7304,_7328,_7352],_7290,_7292) --> 
    hvor(_7304,_7290,_7319),
    manypersons(_7328,_7319,_7343),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_7343,_7390),
    whichq(which(_7245):::_7243,_7352,_7390,_7292).

howmuchq(howmany(_7245):::_7243,[howmuchq,_7314,lit(det),_7349,lit(som),_7384],_7300,_7302) --> 
    be(_7314,_7300,_7329),
    cc(det,_7329,_7348),
    manypersons(_7349,_7348,_7364),
    cc(som,_7364,_7383),
    pushstack(first,(which,w(noun(person,plu,u,n))),nil,_7383,_7422),
    whichq(which(_7245):::_7243,_7384,_7422,_7302).

howmuchq(which(_7245):::_7243,[howmuchq,_7309,_7333,_7357,{},_7396],_7295,_7297) --> 
    hvor(_7309,_7295,_7324),
    much(_7333,_7324,_7348),
    w(verb(_7259,_7266,fin),_7357,_7348,_7374),
    {user:testmember(_7259,[earn,cost])},
    whattrans(_7259,_7245,_7243,_7396,_7374,_7297).

howmuchq(_7240,[howmuchq,_7293,_7317,_7341,!,_7370],_7279,_7281) --> 
    hvor(_7293,_7279,_7308),
    much(_7317,_7308,_7332),
    of(_7341,_7332,_7356),
    !,
    pushstack(first,(which,of),nil,_7356,_7439),
    whichq(_7240,_7370,_7439,_7281).

howmuchq(_7240,[howmuchq,_7310,_7334,_7358,_7387,!,_7458],_7296,_7298) --> 
    hvor(_7310,_7296,_7325),
    much(_7334,_7325,_7349),
    w(noun(_7259,_7260,u,n),_7358,_7349,_7375),
    pushstack(first,(which,w(noun(_7259,sin,u,n))),nil,_7375,_7428),whichq(_7240,_7387,_7428,_7441),
    !,
    accept(_7458,_7441,_7298).

howmuchq(_7240,[howmuchq,_7286,_7310,_7334],_7272,_7274) --> 
    hvor(_7286,_7272,_7301),
    much(_7310,_7301,_7325),
    pushstack(first,[hva],nil,_7325,_7344),
    question(_7240,_7334,_7344,_7274).

whattrans(_7240,_7241,_7242,[whattrans,_7329,_7358,!,_7397],_7309,_7311) --> 
    not_look_ahead([det],_7329,_7309,_7346),
    noun_phrase1(_7268,_7271::_7272,_7358,_7346,_7377),
    !,
    pushstack(first,(noun_phrase1(_7268,_7271::_7272),w(verb(_7240,pres,fin)),npgap(_7241)),nil,_7377,_7471),
    statreal1(_7242,_7397,_7471,_7311).

howadj1(_7240,[howadj1,_7278,!],_7264,_7266) --> 
    howadj(_7240,_7278,_7264,_7266),
    !.

howadj(duration,[howadj,lit(langt)],_7261,_7263) --> 
    cc(langt,_7261,_7263).

howadj(age,[howadj,_7278],_7264,_7266) --> 
    w(adj2(old,nil),_7278,_7264,_7266).

howadj(age,[howadj,lit(mange),_7296],_7271,_7273) --> 
    cc(mange,_7271,_7295),
    w(noun(year,plu,u,n),_7296,_7295,_7273).

howadj(delay,[howadj,_7278],_7264,_7266) --> 
    w(adj2(slow,nil),_7278,_7264,_7266).

howadj(delay,[howadj,_7283,_7327],_7269,_7271) --> 
    optional(much,_7283,_7269,_7315),
    w(adj2(delayed,nil),_7327,_7315,_7271).

howadj(delay,[howadj,_7278],_7264,_7266) --> 
    w(adj2(punctual,nil),_7278,_7264,_7266).

howadj(earliness,[howadj,_7278],_7264,_7266) --> 
    w(adj2(early,nil),_7278,_7264,_7266).

howadj(lateness,[howadj,_7278],_7264,_7266) --> 
    w(adj2(late,nil),_7278,_7264,_7266).

howadj(lateness,[howadj,lit(sent)],_7261,_7263) --> 
    cc(sent,_7261,_7263).

howadj(distance,[howadj,lit(langt)],_7261,_7263) --> 
    cc(langt,_7261,_7263).

howadj(distance,[howadj,_7299,_7323,{}],_7285,_7287) --> 
    many(_7299,_7285,_7314),
    w(noun(_7250,_7264,u,n),_7323,_7314,_7287),
    {user:testmember(_7250,[mil,mile,kilometer,meter])}.

howadj(duration,[howadj,lit(mange),_7296],_7271,_7273) --> 
    cc(mange,_7271,_7295),
    w(noun(minute,_7248,_7249,n),_7296,_7295,_7273).

howadj(duration,[howadj,lit(lenge)],_7261,_7263) --> 
    cc(lenge,_7261,_7263).

howadj(duration,[howadj,_7286,_7310,!],_7272,_7274) --> 
    long(_7286,_7272,_7301),
    w(noun(time,_7251,u,n),_7310,_7301,_7274),
    !.

howadj(duration,[howadj,_7286,_7310,!],_7272,_7274) --> 
    much(_7286,_7272,_7301),
    w(noun(time,_7251,u,n),_7310,_7301,_7274),
    !.

howadj(duration,[howadj,_7278],_7264,_7266) --> 
    w(adj2(short,nil),_7278,_7264,_7266).

howadj(frequency,[howadj,_7273],_7259,_7261) --> 
    often(_7273,_7259,_7261).

howadj(frequency,[howadj,lit(mange),_7305,_7334,!,_7363],_7280,_7282) --> 
    cc(mange,_7280,_7304),
    w(noun(time_count,_7259,_7260,n),_7305,_7304,_7322),
    inperiod0(_7334,_7322,_7349),
    !,
    accept(_7363,_7349,_7282).

howadj(intelligence,[howadj,_7278],_7264,_7266) --> 
    w(adj2(intelligent,nil),_7278,_7264,_7266).

howadj(intelligence,[howadj,_7278],_7264,_7266) --> 
    w(adj2(stupid,_7245),_7278,_7264,_7266).

howadj(intelligence,[howadj,_7288,_7317],_7274,_7276) --> 
    w(adj2(_7254,nil),_7288,_7274,_7305),
    w(noun(intelligence,sin,_7249,n),_7317,_7305,_7276).

howadj(price,[howadj,_7278],_7264,_7266) --> 
    w(adj2(expensive,nil),_7278,_7264,_7266).

howadj(price,[howadj,_7278],_7264,_7266) --> 
    w(adj2(cheap,nil),_7278,_7264,_7266).

howadj(size,[howadj,_7273],_7259,_7261) --> 
    great(_7273,_7259,_7261).

howadj(length,[howadj,_7278],_7264,_7266) --> 
    w(adj2(long,nil),_7278,_7264,_7266).

howadj(length,[howadj,_7278],_7264,_7266) --> 
    w(adj2(short,nil),_7278,_7264,_7266).

howadj(speed,[howadj,lit(fort)],_7261,_7263) --> 
    cc(fort,_7261,_7263).

howadj(speed,[howadj,_7278],_7264,_7266) --> 
    w(adj2(fast,_7245),_7278,_7264,_7266).

howadj(speed,[howadj,_7278],_7264,_7266) --> 
    w(adj2(slow,_7245),_7278,_7264,_7266).

howadj(temperature,[howadj,_7278],_7264,_7266) --> 
    w(adj2(cold,nil),_7278,_7264,_7266).

howadj(temperature,[howadj,_7278],_7264,_7266) --> 
    w(adj2(hot,nil),_7278,_7264,_7266).

howadj(weather,[howadj,_7278],_7264,_7266) --> 
    w(adj2(hot,nil),_7278,_7264,_7266).

howadj(weather,[howadj,_7278],_7264,_7266) --> 
    w(adj2(cold,nil),_7278,_7264,_7266).

howadj(weight,[howadj,_7278],_7264,_7266) --> 
    w(adj2(heavy,nil),_7278,_7264,_7266).

vp(_7240,_7241,_7242,_7245::true,[vp,lit(:),_7313,!],_7279,_7281) --> 
    cc(:,_7279,_7312),
    end_of_line(_7313,_7312,_7281),
    !.

vp(_7240,_7241,_7242,_7243,[vp,_7296],_7273,_7275) --> 
    verb_phrase(_7240,_7241,_7242,_7243,_7296,_7273,_7275).

verb_phrase(_7240,_7241,_7242,_7243,[verb_phrase,_7364,{},{},{},{},!,_7433,_7457,!],_7341,_7343) --> 
    endofline(_7364,_7341,_7379),
    {user:value(busflag,true)},
    {user:(\+value(dialog,1))},
    {user:vartypeid(_7240,_7284)},
    {user:testmember(_7284,[neighbourhood,bus,tram,station,departure,arrival])},
    !,
    accept(_7433,_7379,_7448),
    pushstack(first,w(verb(exist,pres,fin)),nil,_7448,_7470),verb_phrase1(exist,_7240,_7241,_7242,_7243,_7457,_7470,_7343),
    !.

verb_phrase(_7240,_7241,_7242,_7245::_7246,[verb_phrase,_7400,{},lit(og),_7450,{},_7489,!,_7528,!,_7635],_7377,_7379) --> 
    w(verb(_7288,_7289,fin),_7400,_7377,_7417),
    {user:verbtype(_7288,tv)},
    cc(og,_7417,_7449),
    w(verb(_7301,_7302,fin),_7450,_7449,_7467),
    {user:verbtype(_7301,tv)},
    object(_7284,_7311,_7489,_7467,_7508),
    !,
    lock(exact,_7508,_7579),pushstack(exact,(w(verb(_7288,_7334,fin)),xnp(_7284,_7311)),nil,_7579,_7585),verb_phrase1(_7288,_7240,_7241,_7242,_7245::_7329,_7528,_7585,_7574),unlock(_7574,_7575),
    !,
    lock(exact,_7575,_7682),
    pushstack(exact,([og],w(verb(_7301,_7351,fin)),npgap(_7284)),nil,_7682,_7688),
    verb_phrases0(_7301,_7240,_7242,_7329,_7245::_7246,_7635,_7688,_7677),
    unlock(_7677,_7379).

verb_phrase(_7240,_7241,_7242,_7245::_7246,[verb_phrase,_7315,_7364],_7292,_7294) --> 
    verb_phrase1(_7251,_7240,_7241,_7242,_7245::_7254,_7315,_7292,_7340),
    verb_phrases0(_7251,_7240,_7242,_7254,_7245::_7246,_7364,_7340,_7294).

verb_phrases0(_7240,_7241,_7242,_7243,_7246::_7243 and _7250,[verb_phrases0,_7362,lit(ikke),!,_7402,{},{},_7480],_7336,_7338) --> 
    vp_conjunction(_7362,_7336,_7377),
    cc(ikke,_7377,_7396),
    !,
    pushstack(first,w(verb(_7240,pres,fin)),nil,_7396,_7415),verb_phrase1(_7240,_7241,_7292,_7242,_7246::_7297,_7402,_7415,_7436),
    {user:bigno(not,_7292,_7303)},
    {user:negate(_7303,_7297,_7273)},
    verb_phrases0(_7240,_7241,_7242,_7273,_7246::_7250,_7480,_7436,_7338).

verb_phrases0(_7240,_7241,_7242,_7243,_7246::_7243 and _7250,[verb_phrases0,_7343,_7367,_7396,{},_7455],_7317,_7319) --> 
    vp_conjunction(_7343,_7317,_7358),
    not_look_ahead(['så'],_7367,_7358,_7384),
    verb_phrase1(_7277,_7241,_7279,_7242,_7246::_7284,_7396,_7384,_7421),
    {user:negate(_7279,_7284,_7267)},
    verb_phrases0(_7264,_7241,_7242,_7267,_7246::_7250,_7455,_7421,_7319).

verb_phrases0(be,_7241,_7242,_7243,_7246::_7243 and _7250,[verb_phrases0,_7350,{},!,_7394],_7324,_7326) --> 
    w(adj2(_7269,nil),_7350,_7324,_7367),
    {user:testmember(_7269,[enclosed])},
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_7269,nil))),nil,_7367,_7404),
    verb_phrase1(be,_7241,id,_7242,_7246::_7250,_7394,_7404,_7326).

verb_phrases0(_7240,_7241,_7242,_7243,_7246::_7243,[verb_phrases0,[]],_7274,_7274) --> 
    [].

vp_conjunction([vp_conjunction,lit(som),_7282],_7260,_7262) --> 
    cc(som,_7260,_7281),
    look_ahead_vp(_7282,_7281,_7262).

vp_conjunction([vp_conjunction,lit('å'),_7290],_7268,_7270) --> 
    cc('å',_7268,_7289),
    look_ahead(w(verb(_7247,pres,fin)),_7290,_7289,_7270).

vp_conjunction([vp_conjunction,lit(evt)],_7257,_7259) --> 
    cc(evt,_7257,_7259).

vp_conjunction([vp_conjunction,_7292,_7316,_7345,_7374,!],_7281,_7283) --> 
    and1(_7292,_7281,_7307),
    not_look_ahead(['nå'],_7316,_7307,_7333),
    not_look_ahead(['så'],_7345,_7333,_7362),
    not_look_ahead(w(adv(redundantly)),_7374,_7362,_7283),
    !.

vp_conjunction([vp_conjunction,lit(men),_7298,_7327,!],_7276,_7278) --> 
    cc(men,_7276,_7297),
    not_look_ahead(['så'],_7298,_7297,_7315),
    look_ahead_lit([skal,vil],_7327,_7315,_7278),
    !.

vp_conjunction([vp_conjunction,lit(men),_7300,_7329,!],_7278,_7280) --> 
    cc(men,_7278,_7299),
    not_look_ahead(['så'],_7300,_7299,_7317),
    look_ahead(w(verb(_7259,_7260,_7261)),_7329,_7317,_7280),
    !.

vp_conjunction([vp_conjunction,_7277,_7301],_7266,_7268) --> 
    or1(_7277,_7266,_7292),
    look_ahead(w(verb(_7247,_7248,fin)),_7301,_7292,_7268).

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7343,_7367,_7396,!,_7430,_7454],_7317,_7319) --> 
    aux1(_7343,_7317,_7358),
    not_look_ahead(w(verb(_7274,_7275,_7276)),_7367,_7358,_7384),
    look_ahead_lit(['så',tilbake,fram],_7396,_7384,_7413),
    !,
    accept(_7430,_7413,_7445),
    pushstack(first,w(verb(go,pres,fin)),nil,_7445,_7464),
    do_phrase(_7240,_7241,_7242,_7243,_7244,_7454,_7464,_7319).

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7366,_7390,_7419,{},{},!,_7478,_7502],_7340,_7342) --> 
    aux1(_7366,_7340,_7381),
    not_look_ahead(w(verb(_7280,_7281,_7282)),_7390,_7381,_7407),
    np0_accept(_7273,_7274,_7419,_7407,_7438),
    {user:vartypeid(_7273,_7290)},
    {user:testmember(_7290,[thing,coevent,activity])},
    !,
    accept(_7478,_7438,_7493),
    pushstack(first,(w(verb(do1,pres,fin)),xnp(_7273,_7274)),nil,_7493,_7543),
    do_phrase(_7240,_7241,_7242,_7243,_7244,_7502,_7543,_7342).

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7393,_7417,_7446,_7470,_7499,{},_7538,_7562,{},!,_7611,_7635],_7367,_7369) --> 
    aux1(_7393,_7367,_7408),
    negation0(_7242,_7417,_7408,_7434),
    redundant0(_7446,_7434,_7461),
    not_look_ahead(w(verb(_7297,_7298,_7299)),_7470,_7461,_7487),
    w(prep(_7303),_7499,_7487,_7516),
    {user:testmember(_7303,[from,to,on,towards])},
    look_ahead_np(_7538,_7516,_7553),
    np0_accept(_7288,_7289,_7562,_7553,_7581),
    {user:constrain(_7288,place)},
    !,
    accept(_7611,_7581,_7626),
    pushstack(first,(w(verb(go,pres,fin)),w(prep(_7303)),xnp(_7288,_7289)),nil,_7626,_7676),
    do_phrase(_7240,_7241,_7242,_7243,_7244,_7635,_7676,_7369).

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7353,_7377,_7406,{},_7445,!,_7474,_7498],_7327,_7329) --> 
    aux1(_7353,_7327,_7368),
    not_look_ahead(w(verb(_7277,_7278,_7279)),_7377,_7368,_7394),
    look_ahead(w(prep(_7285)),_7406,_7394,_7423),
    {user:(\+testmember(_7285,[from,to,on,towards]))},
    preadverbials0(_7445,_7423,_7460),
    !,
    accept(_7474,_7460,_7489),
    do_phrase(_7240,_7241,_7242,_7243,_7244,_7498,_7489,_7329).

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7332,_7356,_7385,!,_7419,_7443],_7306,_7308) --> 
    aux1(_7332,_7306,_7347),
    not_look_ahead(w(verb(_7271,_7272,_7273)),_7356,_7347,_7373),
    one_of_lit([da,'nå'],_7385,_7373,_7402),
    !,
    accept(_7419,_7402,_7434),
    do_phrase(_7240,_7241,_7242,_7243,_7244,_7443,_7434,_7308).

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7360,_7384,_7413,_7442,_7466,{},!,_7515,_7539],_7334,_7336) --> 
    aux1(_7360,_7334,_7375),
    not_look_ahead(w(verb(_7283,_7284,_7285)),_7384,_7375,_7401),
    w(prep(_7289),_7413,_7401,_7430),
    look_ahead_np(_7442,_7430,_7457),
    np0_accept(_7276,_7277,_7466,_7457,_7485),
    {user:constrain(_7276,time)},
    !,
    accept(_7515,_7485,_7530),
    lock(last,_7530,_7587),
    pushstack(last,(w(prep(_7289)),xnp(_7276,_7277)),nil,_7587,_7593),
    do_phrase(_7240,_7241,_7242,_7243,_7244,_7539,_7593,_7582),
    unlock(_7582,_7336).

verb_phrase1(be1,_7241,_7242,_7243,_7244,[verb_phrase1,lit(skal),_7368,_7397,lit(med),_7452,_7476,{}],_7331,_7333) --> 
    cc(skal,_7331,_7367),
    negation0(_7266,_7368,_7367,_7385),
    optional(w(verb(be,inf,fin)),_7397,_7385,_7429),
    cc(med,_7429,_7451),
    not_look_ahead_np(_7452,_7451,_7467),
    pushstack(first,(w(verb(be1,inf,fin)),w(adv(inside))),nil,_7467,_7489),do_phrase(be1,_7241,_7267,_7243,_7244,_7476,_7489,_7333),
    {user:bigno(_7266,_7267,_7242)}.

verb_phrase1(be,_7241,id,_7243,_7244,[verb_phrase1,_7327,{},_7366],_7301,_7303) --> 
    w(adj2(_7257,nil),_7327,_7301,_7344),
    {user:testmember(_7257,[enclosed])},
    pushstack(first,w(adj2(_7257,nil)),nil,_7344,_7376),
    be_pred(_7241,_7243,_7244,_7366,_7376,_7303).

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7375,_7404,_7433,_7462,{},!,_7506,_7564,{}],_7349,_7351) --> 
    constrainvehdep(_7241,_7375,_7349,_7392),
    w(verb(be,_7281,fin),_7404,_7392,_7421),
    negation0(_7272,_7433,_7421,_7450),
    w(verb(_7240,past,part),_7462,_7450,_7479),
    {user:testmember(_7240,[go,run,pass])},
    !,
    pushstack(first,w(verb(_7240,_7281,fin)),nil,_7479,_7519),vp_kernel(_7240,_7241,_7273,_7243,_7316,_7506,_7519,_7540),
    verb_modifiers0(_7240,_7241,_7243,_7316,_7244,_7564,_7540,_7351),
    {user:bigno(_7272,_7273,_7242)}.

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7340,_7364,_7393,_7422,!,_7471],_7314,_7316) --> 
    blei(_7340,_7314,_7355),
    one_of_lit([siden,derfor,dermed],_7364,_7355,_7381),
    negation0(_7242,_7393,_7381,_7410),
    lexv(tv,_7240,past,part,_7422,_7410,_7445),
    !,
    pushstack(first,w(verb(_7240,past,part)),nil,_7445,_7481),
    passive(_7241,_7243,_7244,_7471,_7481,_7316).

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7335,_7359,_7383,_7412,_7436,!,_7485],_7309,_7311) --> 
    aux1(_7335,_7309,_7350),
    redundant0(_7359,_7350,_7374),
    negation0(_7242,_7383,_7374,_7400),
    blei(_7412,_7400,_7427),
    lexv(tv,_7240,past,part,_7436,_7427,_7459),
    !,
    pushstack(first,w(verb(_7240,past,part)),nil,_7459,_7495),
    passive(_7241,_7243,_7244,_7485,_7495,_7311).

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7342,_7366,_7395,_7419,_7463,!,_7502],_7316,_7318) --> 
    redundant0(_7342,_7316,_7357),
    blei(_7242,_7366,_7357,_7383),
    redundant0(_7395,_7383,_7410),
    lexv(_7275,_7240,past,part,_7419,_7410,_7442),
    gmem(_7275,[tv,dtv],_7463,_7442,_7482),
    !,
    pushstack(first,w(verb(_7240,past,part)),nil,_7482,_7512),
    passive(_7241,_7243,_7244,_7502,_7512,_7318).

verb_phrase1(be,_7241,_7242,_7243,_7244,[verb_phrase1,_7335,_7364,_7388,_7412,_7441,_7465,_7489,_7513,_7537],_7309,_7311) --> 
    not_look_ahead(w(verb(go,_7279,fin)),_7335,_7309,_7352),
    aux10(_7364,_7352,_7379),
    redundants0(_7388,_7379,_7403),
    be(_7242,_7412,_7403,_7429),
    not_look_ahead_verbx(_7441,_7429,_7456),
    danow0(_7465,_7456,_7480),
    redundant0(_7489,_7480,_7504),
    not_look_ahead_prepx(_7513,_7504,_7528),
    be_complements(_7241,_7243,_7244,_7537,_7528,_7311).

not_look_ahead_verbx([not_look_ahead_verbx,lit('så'),!],_7260,_7262) --> 
    cc('så',_7260,_7262),
    !.

not_look_ahead_verbx([not_look_ahead_verbx,_7274],_7263,_7265) --> 
    not_look_ahead(w(verb(_7244,_7245,_7246)),_7274,_7263,_7265).

not_look_ahead_prepx([not_look_ahead_prepx,_7290,{},!,_7334],_7279,_7281) --> 
    look_ahead(w(prep(_7253)),_7290,_7279,_7307),
    {user:(\+testmember(_7253,[for]))},
    !,
    reject(_7334,_7307,_7281).

not_look_ahead_prepx([not_look_ahead_prepx,[]],_7255,_7255) --> 
    [].

verb_phrase1(_7240,_7241,_7242,_7243,_7244,[verb_phrase1,_7352,_7386,_7415,_7439,{},_7478,{},!,_7542],_7326,_7328) --> 
    auxs0(_7270,_7271,_7352,_7326,_7371),
    not_look_ahead(w(verb(_7277,_7278,pass)),_7386,_7371,_7403),
    redundants0(_7415,_7403,_7430),
    negation0(_7281,_7439,_7430,_7456),
    {user:bigno(_7270,_7281,_7287)},
    do_phrase(_7240,_7241,_7291,_7243,_7244,_7478,_7456,_7503),
    {user:bigno(_7287,_7291,_7242)},
    !,
    accept(_7542,_7503,_7328).

verb_phrase1(go,_7241,_7242,_7243,_7244,[verb_phrase1,_7342,_7366,lit(av),!,_7411,_7435],_7316,_7318) --> 
    aux1(_7342,_7316,_7357),
    not_look_ahead(w(verb(_7273,_7274,_7275)),_7366,_7357,_7383),
    cc(av,_7383,_7405),
    !,
    accept(_7411,_7405,_7426),
    pushstack(first,(w(verb(go,pres,fin)),[av]),nil,_7426,_7445),
    do_phrase(go,_7241,_7242,_7243,_7244,_7435,_7445,_7318).

verb_phrase1(_7240,_7241,id,_7243,_7246::_7247,[verb_phrase1,_7331,_7355,_7379,_7408],_7305,_7307) --> 
    paux0(_7331,_7305,_7346),
    redundant0(_7355,_7346,_7370),
    w(verb(_7240,_7270,pass),_7379,_7370,_7396),
    pushstack(first,w(verb(_7240,past,part)),nil,_7396,_7418),
    passive(_7241,_7243,_7246::_7247,_7408,_7418,_7307).

verb_phrase1(live,_7241,id,_7243,_7244,[verb_phrase1,_7366,_7390,_7414,_7443,_7472,!,_7521],_7340,_7342) --> 
    be(_7366,_7340,_7381),
    redundant0(_7390,_7381,_7405),
    number(_7283,_7414,_7405,_7431),
    w(noun(year,_7288,u,n),_7443,_7431,_7460),
    optional(w(adj2(old,nil)),_7472,_7460,_7504),
    !,
    pushstack(first,(w(verb(live,pres,fin)),prep1(in),number(_7283),w(noun(year,plu,u,n))),nil,_7504,_7595),
    do_phrase(live,_7241,id,_7243,_7244,_7521,_7595,_7342).

verb_phrase1(be,_7241,_7242,_7243,_7244,[verb_phrase1,_7319,_7348,lit(som),!,_7388],_7293,_7295) --> 
    be(_7242,_7319,_7293,_7336),
    dudet(_7348,_7336,_7363),
    cc(som,_7363,_7382),
    !,
    do_phrase(be,_7241,_7242,_7243,_7244,_7388,_7382,_7295).

verb_phrase1(be,_7241,_7242,_7243,_7244,[verb_phrase1,_7380,_7409,_7438,!,_7472,_7496,_7525,_7554,_7578,_7602,{}],_7354,_7356) --> 
    not_look_ahead(w(verb(go,_7287,fin)),_7380,_7354,_7397),
    w(verb(be,_7293,fin),_7409,_7397,_7426),
    not_look_ahead(w(verb(_7300,_7301,part)),_7438,_7426,_7455),
    !,
    accept(_7472,_7455,_7487),
    not_look_ahead(w(name(_7308,_7309,_7310)),_7496,_7487,_7513),
    negation0(_7278,_7525,_7513,_7542),
    it0(_7554,_7542,_7569),
    redundant0(_7578,_7569,_7593),
    pushstack(first,w(verb(be,pres,fin)),nil,_7593,_7615),do_phrase(be,_7241,_7279,_7243,_7244,_7602,_7615,_7356),
    {user:bigno(_7278,_7279,_7242)}.

verb_phrase1(_7240,_7241,id,_7243,_7244,[verb_phrase1,_7324,_7348,_7377,_7401],_7298,_7300) --> 
    paux0(_7324,_7298,_7339),
    w(verb(_7240,pres,pass),_7348,_7339,_7365),
    thereit0(_7377,_7365,_7392),
    pushstack(first,w(adj2(_7240,nil)),nil,_7392,_7411),
    be_complements(_7241,_7243,_7244,_7401,_7411,_7300).

do_phrase(_7240,_7241,_7242,_7243,_7244,[do_phrase,_7425,{},_7464,_7493,_7517,_7546,_7575,{},!,_7619,_7643,_7709],_7399,_7401) --> 
    w(verb(_7240,_7298,fin),_7425,_7399,_7442),
    {user:testmember(_7240,[go,come])},
    negation0(_7242,_7464,_7442,_7481),
    morethan0(_7493,_7481,_7508),
    w(nb(_7314,num),_7517,_7508,_7534),
    w(noun(minute,_7320,u,n),_7546,_7534,_7563),
    w(adj2(_7326,_7327),_7575,_7563,_7592),
    {user:testmember(_7326,[delayed,tooearly,late])},
    !,
    accept(_7619,_7592,_7634),
    lock(exact,_7634,_7663),pushstack(exact,w(adj2(_7326,_7327)),nil,_7663,_7669),ap(_7326,_7241,_7243,_7351,_7643,_7669,_7658),unlock(_7658,_7659),
    pushstack(first,(w(prep(with)),w(nb(_7314,num)),w(noun(minute,plu,u,n))),nil,_7659,_7719),
    verb_modifiers0(adj/nil/_7326,_7241,_7243,_7351,_7244,_7709,_7719,_7401).

morethan0([morethan0,lit(ca),!],_7260,_7262) --> 
    cc(ca,_7260,_7262),
    !.

morethan0([morethan0,lit(minst),!],_7260,_7262) --> 
    cc(minst,_7260,_7262),
    !.

morethan0([morethan0,lit(mer),lit(enn),!],_7265,_7267) --> 
    cc(mer,_7265,_7286),
    cc(enn,_7286,_7267),
    !.

morethan0([morethan0,[]],_7255,_7255) --> 
    [].

do_phrase(_7240,_7241,id,_7243,_7246::_7249 and _7250,[do_phrase,_7381,_7410,_7439,{},_7483,_7507,!,_7541,{}],_7355,_7357) --> 
    w(verb(ask,_7288,fin),_7381,_7355,_7398),
    not_look_ahead([om],_7410,_7398,_7427),
    object(_7295,_7296,_7439,_7427,_7458),
    {user:constrain(_7295,agent)},
    omaa0(_7483,_7458,_7498),
    w(verb(_7305,inf,fin),_7507,_7498,_7524),
    !,
    pushstack(first,(xnp(_7295,_7296),w(verb(_7305,pres,fin))),nil,_7524,_7585),clausal_object1(_7281,_7246::_7250,_7541,_7585,_7357),
    {user:co_template(_7240,that,_7241,_7281,_7243,_7249)}.

omaa0([omaa0,[]],_7255,_7255) --> 
    [].

omaa([omaa,lit(om),lit('å')],_7262,_7264) --> 
    cc(om,_7262,_7283),
    cc('å',_7283,_7264).

omaa([omaa,lit(om),lit(og)],_7262,_7264) --> 
    cc(om,_7262,_7283),
    cc(og,_7283,_7264).

omaa([omaa,lit('å')],_7257,_7259) --> 
    cc('å',_7257,_7259).

do_phrase(_7240,_7241,_7242,_7243,_7244,[do_phrase,_7312,_7361],_7286,_7288) --> 
    rvp_kernel(_7240,_7241,_7242,_7243,_7252,_7312,_7286,_7337),
    verb_modifiers0(_7240,_7241,_7243,_7252,_7244,_7361,_7337,_7288).

do_phrase(have,_7241,id,_7243,_7246::_7249 and _7250,[do_phrase,_7371,_7395,{},lit(for),lit('å'),!,_7461,_7485,{}],_7345,_7347) --> 
    has(_7371,_7345,_7386),
    w(adj2(_7286,nil),_7395,_7386,_7412),
    {user:testmember(_7286,[difficult])},
    cc(for,_7412,_7444),
    cc('å',_7444,_7455),
    !,
    accept(_7461,_7455,_7476),
    pushstack(first,(npgap(_7241),aux1),nil,_7476,_7556),clausal_object1(_7312:coevent,_7246::_7250,_7485,_7556,_7347),
    {user:tv_template(dislike,_7241,_7312:coevent,_7243,_7249)}.

do_phrase(_7240,_7241,_7242,_7243,_7244,[do_phrase,_7318,_7367,_7416],_7292,_7294) --> 
    vp_kernel(_7240,_7241,_7252,_7243,_7259,_7318,_7292,_7343),
    verb_modifiers0(_7240,_7241,_7243,_7259,_7244,_7367,_7343,_7392),
    negation2(_7252,_7242,_7416,_7392,_7294).

do_phrase(_7240,_7241,_7242,_7243,_7244,[do_phrase,_7347,_7376,!,_7410,_7468,_7492],_7321,_7323) --> 
    not_look_ahead(w(verb(_7271,_7272,_7273)),_7347,_7321,_7364),
    look_ahead(w(prep(_7279)),_7376,_7364,_7393),
    !,
    pushstack(first,w(verb(do1,pres,fin)),nil,_7393,_7423),vp_kernel(_7240,_7241,_7242,_7243,_7264,_7410,_7423,_7444),
    it0(_7468,_7444,_7483),
    verb_modifiers0(_7240,_7241,_7243,_7264,_7244,_7492,_7483,_7323).

rvp_kernel(_7240,_7241,_7242,_7243,_7244,[rvp_kernel,_7437,{},_7496,_7525,_7554,_7583,_7612,{},_7656,_7700,_7729,!,_7768,_7888],_7411,_7413) --> 
    hlexv(dtv,_7240,_7296,_7297,_7298,_7437,_7411,_7462),
    {user:testmember(_7240,[ask,tell,answer,answer1])},
    not_look_ahead([om],_7496,_7462,_7513),
    not_look_ahead([et],_7525,_7513,_7542),
    not_look_ahead([en],_7554,_7542,_7571),
    not_look_ahead(w(nb(_7329,_7330)),_7583,_7571,_7600),
    ind_object(_7332,_7333,_7612,_7600,_7631),
    {user:constrain(_7332,agent)},
    optional([om],_7656,_7631,_7688),
    not_look_ahead([at],_7700,_7688,_7717),
    np1_accept(_7291,_7292,_7729,_7717,_7748),
    !,
    pushstack(first,(lexv(dtv,_7240,_7296,_7297),xnp(_7332,_7333),[noe]),nil,_7748,_7843),vp_kernel(_7240,_7241,_7242,_7243,_7366,_7768,_7843,_7864),
    pushstack(first,(w(prep(about)),xnp(_7291,_7292)),nil,_7864,_7929),
    verb_modifiers0(_7240,_7241,_7243,_7366,_7244,_7888,_7929,_7413).

rvp_kernel(_7240,_7241,_7242,_7243,_7244,[rvp_kernel,_7320,_7369,_7398,!],_7294,_7296) --> 
    lexvaccept(rv,_7240,_7257,_7258,_7242,_7320,_7294,_7345),
    reflexiv0(_7240,_7369,_7345,_7386),
    rvpk(_7240,_7241,id,_7243,_7244,_7398,_7386,_7296),
    !.

rvp_kernel(_7240,_7241,id,_7243,event/real/_7243::_7249 and _7250,[rvp_kernel,_7385,{},_7444,_7473,{},_7512,!,_7541,_7565,{}],_7359,_7361) --> 
    hlexv(rv,_7240,_7295,_7296,_7297,_7385,_7359,_7410),
    {user:testmember(_7240,[know,say])},
    reflexiv0(_7240,_7444,_7410,_7461),
    w(prep(_7312),_7473,_7461,_7490),
    {user:(\+testmember(_7312,[]))},
    which(_7512,_7490,_7527),
    !,
    accept(_7541,_7527,_7556),
    pushstack(first,(w(prep(_7312)),which),nil,_7556,_7606),ppstnp(_7289,_7249,_7565,_7606,_7361),
    {user:tv_template(_7240,_7241,_7289,_7243,_7250)}.

rvp_kernel(adj/nil/_7253,_7241,_7242,_7243,_7246::_7249 and _7250,[rvp_kernel,_7358,_7387,_7416,_7445,_7469,{}],_7332,_7334) --> 
    w(verb(be,_7285,fin),_7358,_7332,_7375),
    negation0(_7242,_7387,_7375,_7404),
    w(adj2(_7253,nil),_7416,_7404,_7433),
    forat(_7445,_7433,_7460),
    clausal_object1(_7301:_7302,_7246::_7250,_7469,_7460,_7334),
    {user:atv_template(_7253,because_of,_7241,_7301:_7302,_7243,_7249)}.

rvpk(_7240,_7241,id,_7243,_7246::_7249 and _7250,[rvpk,{},_7393,lit(hvordan),_7428,!,_7457,_7481,{}],_7357,_7359) --> 
    {user:testmember(_7240,[ask,answer,answer1,discuss,know,know1])},
    omut0(_7393,_7357,_7408),
    cc(hvordan,_7408,_7427),
    endofline0(_7428,_7427,_7443),
    !,
    accept(_7457,_7443,_7472),
    pushstack(first,(w(noun(bus,sin,def,n)),w(verb(go,pres,fin))),nil,_7472,_7494),clausal_object1(_7319:_7320,_7246::_7250,_7481,_7494,_7359),
    {user:co_template(_7240,how,_7241,_7319:_7320,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},_7389,lit(hvordan),!,_7429,{},!,_7473,_7497,{}],_7353,_7355) --> 
    {user:testmember(_7240,[ask,answer,answer1,discuss,know,know1])},
    omut0(_7389,_7353,_7404),
    cc(hvordan,_7404,_7423),
    !,
    negation0(_7242,_7429,_7423,_7446),
    {user:test(rv_templ(_7240,_7314))},
    !,
    accept(_7473,_7446,_7488),
    clausal_object1(_7322:_7323,_7246::_7250,_7497,_7488,_7355),
    {user:co_template(_7240,how,_7241,_7322:_7323,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,_7386,_7420,lit(at),_7460,!,_7494,_7533,{}],_7360,_7362) --> 
    gmem(_7240,[calculate,say,tell,know,decide,believe,doubt,think],_7386,_7360,_7405),
    negation0(_7242,_7420,_7405,_7437),
    cc(at,_7437,_7459),
    look_ahead_lit([hvis,'når',selvom],_7460,_7459,_7477),
    !,
    subordinate(_7312,_7313,_7314,_7494,_7477,_7515),
    lock(last,_7515,_7585),pushstack(last,subordinate(_7312,_7313,_7314),nil,_7585,_7591),clausal_object1(_7329:_7330,_7246::_7250,_7533,_7591,_7580),unlock(_7580,_7362),
    {user:tv_template(_7240,_7241,_7329:_7330,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,_7365,_7399,_7423,_7452,_7481,{}],_7339,_7341) --> 
    gmem(_7240,[calculate,fear,hope,know,mean,recognize,think,understand],_7365,_7339,_7384),
    redundant0(_7399,_7384,_7414),
    negation0(_7242,_7423,_7414,_7440),
    not_look_ahead_lit([at,om],_7452,_7440,_7469),
    clausal_object0(_7308:_7309,_7246::_7250,_7481,_7469,_7341),
    {user:tv_template(_7240,_7241,_7308:_7309,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,_7373,_7407,lit(at),_7447,!,_7486,_7510,{}],_7347,_7349) --> 
    gmem(_7240,[do1,paint],_7373,_7347,_7392),
    negation0(_7242,_7407,_7392,_7424),
    cc(at,_7424,_7446),
    np0_accept(_7292,_7293,_7447,_7446,_7466),
    !,
    accept(_7486,_7466,_7501),
    pushstack(first,(xnp(_7292,_7293),w(verb(be,pres,fin))),nil,_7501,_7554),clausal_object1(_7313:_7314,_7246::_7250,_7510,_7554,_7349),
    {user:tv_template(_7240,_7241,_7313:_7314,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},_7366,_7395,lit(at),!,_7435,{}],_7330,_7332) --> 
    {user:testmember(_7240,[base,say,tell])},
    negation0(_7242,_7366,_7330,_7383),
    preadverbials0(_7395,_7383,_7410),
    cc(at,_7410,_7429),
    !,
    clausal_object1(_7299:_7300,_7246::_7250,_7435,_7429,_7332),
    {user:tv_template(_7240,_7241,_7299:_7300,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},_7369,_7398,!,_7432,_7456,{}],_7333,_7335) --> 
    {user:testmember(_7240,[mean,think])},
    pronoun(_7287,_7369,_7333,_7386),
    negation0(_7242,_7398,_7386,_7415),
    !,
    accept(_7432,_7415,_7447),
    pushstack(first,pronoun(_7287),nil,_7447,_7499),clausal_object1(_7302:_7303,_7246::_7250,_7456,_7499,_7335),
    {user:tv_template(_7240,_7241,_7302:_7303,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},_7372,_7401,_7435,lit('å'),!,_7495,{}],_7336,_7338) --> 
    {user:testmember(_7240,[regard])},
    negation0(_7242,_7372,_7336,_7389),
    object1(_7290,_7291,_7401,_7389,_7420),
    optional([for],_7435,_7420,_7467),
    cc('å',_7467,_7489),
    !,
    pushstack(first,xnp(_7290,_7291),nil,_7489,_7539),clausal_object1(_7277,_7246::_7250,_7495,_7539,_7338),
    {user:tv_template(_7240,_7241,_7277,_7243,_7249)}.

rvpk(_7240,_7241,id,_7243,_7246::_7249 and _7250,[rvpk,{},_7372,_7416,lit('når'),!,_7476,_7500,{}],_7336,_7338) --> 
    {user:testmember(_7240,[wonder])},
    optional(['på'],_7372,_7336,_7404),
    optional([om],_7416,_7404,_7448),
    cc('når',_7448,_7470),
    !,
    accept(_7476,_7470,_7491),
    clausal_object1(_7305:coevent,_7246::_7250,_7500,_7491,_7338),
    {user:co_template(_7240,when,_7241,_7305:coevent,_7243,_7249)}.

rvpk(_7240,_7241,id,_7243,_7246::_7249 and _7250,[rvpk,{},_7367,lit(om),!,_7427,_7451,{}],_7331,_7333) --> 
    {user:testmember(_7240,[think,wonder])},
    optional(['på'],_7367,_7331,_7399),
    cc(om,_7399,_7421),
    !,
    accept(_7427,_7421,_7442),
    clausal_object1(_7300:coevent,_7246::_7250,_7451,_7442,_7333),
    {user:co_template(_7240,whether,_7241,_7300:coevent,_7243,_7249)}.

'altsogå'(['altsogå',lit('altså'),lit('å')],_7262,_7264) --> 
    cc('altså',_7262,_7283),
    cc('å',_7283,_7264).

'altsogå'(['altsogå',lit(og),lit('å')],_7262,_7264) --> 
    cc(og,_7262,_7283),
    cc('å',_7283,_7264).

ppstnp(_7240,_7241,[ppstnp,_7301,_7330,_7354,_7393],_7284,_7286) --> 
    w(prep(_7253),_7301,_7284,_7318),
    which(_7330,_7318,_7345),
    np_kernel(0,_7240,_7255,_7354,_7345,_7375),
    forwst(_7241,_7253,_7240,_7255,_7393,_7375,_7286).

forwst(_7240,_7241,_7242,_7243,[forwst,_7300],_7277,_7279) --> 
    pushstack(free,adverbial1(_7241,_7242,_7243),nil,_7277,_7342),
    statreal(_7240,_7300,_7342,_7279).

forat([forat,lit(at)],_7257,_7259) --> 
    cc(at,_7257,_7259).

forat([forat,lit(for),lit(at)],_7262,_7264) --> 
    cc(for,_7262,_7283),
    cc(at,_7283,_7264).

forat([forat,lit(fordi)],_7257,_7259) --> 
    cc(fordi,_7257,_7259).

forat([forat,lit(av),lit(at)],_7262,_7264) --> 
    cc(av,_7262,_7283),
    cc(at,_7283,_7264).

forat([forat,lit(over),lit(at)],_7262,_7264) --> 
    cc(over,_7262,_7283),
    cc(at,_7283,_7264).

forat([forat,lit(til),lit(at)],_7262,_7264) --> 
    cc(til,_7262,_7283),
    cc(at,_7283,_7264).

forat([forat,lit(om)],_7257,_7259) --> 
    cc(om,_7257,_7259).

rvpk(_7240,_7241,id,_7243,_7246::_7249 and _7250,[rvpk,{},_7384,lit(hvor),_7419,!,_7453,{}],_7348,_7350) --> 
    {user:testmember(_7240,[ask,answer,answer1,discuss,know,know1])},
    omut0(_7384,_7348,_7399),
    cc(hvor,_7399,_7418),
    w(adj2(_7300,nil),_7419,_7418,_7436),
    !,
    pushstack(free,w(adj2(_7300,nil)),nil,_7436,_7466),clausal_object1(_7317:_7318,_7246::_7250,_7453,_7466,_7350),
    {user:co_template(_7240,how,_7241,_7317:_7318,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,_7389,_7423,_7452,_7476,lit('når'),{},!,_7526,!,_7560,_7584,{}],_7363,_7365) --> 
    gmem(_7240,[ask,answer,answer1,discover,discuss,know,know1,say],_7389,_7363,_7408),
    reflexiv0(_7240,_7423,_7408,_7440),
    redundant0(_7452,_7440,_7467),
    omut0(_7476,_7467,_7491),
    cc('når',_7491,_7510),
    {user:test(rv_templ(_7240,_7322))},
    !,
    negation0(_7242,_7526,_7510,_7543),
    !,
    accept(_7560,_7543,_7575),
    clausal_object1(_7332:_7333,_7246::_7250,_7584,_7575,_7365),
    {user:co_template(_7240,when,_7241,_7332:_7333,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},{},lit(_7313),{},!,_7436,!,_7470,_7494,{}],_7364,_7366) --> 
    {user:(\+testmember(_7240,[fail,help,let,lie2,slip,try]))},
    {user:test(rv_templ(_7240,_7312))},
    cc(_7313,_7364,_7420),
    {user:testmember(_7313,[hvorfor,hvordan])},
    !,
    negation0(_7242,_7436,_7420,_7453),
    !,
    accept(_7470,_7453,_7485),
    clausal_object1(_7333:_7334,_7246::_7250,_7494,_7485,_7366),
    {user:co_template(_7240,why,_7241,_7333:_7334,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},_7378,_7407,lit(at),!,_7462,{},[]],_7342,_7344) --> 
    {user:testmember(_7240,[say,tell])},
    negation0(_7242,_7378,_7342,_7395),
    pp(_7276,_7277,_7278,_7407,_7395,_7428),
    cc(at,_7428,_7456),
    !,
    clausal_object1(_7303:_7304,_7246::_7250,_7462,_7456,_7481),
    {user:tv_template(_7240,_7241,_7303:_7304,_7243,_7249)},
    pushstack(free,adverbial1(_7276,_7277,_7278),nil,_7481,_7344),
    [].

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},_7401,_7430,_7454,{},{},!,_7508,_7532,{}],_7365,_7367) --> 
    {user:(\+testmember(_7240,[fail,help,let,lie2,slip,think,try,propose]))},
    reflexiv0(_7240,_7401,_7365,_7418),
    omut0(_7430,_7418,_7445),
    negation0(_7242,_7454,_7445,_7471),
    {user:test(rv_templ(_7240,_7319))},
    {user:(\+verbtype(_7240,tv))},
    !,
    accept(_7508,_7471,_7523),
    clausal_object0(_7334:_7335,_7246::_7250,_7532,_7523,_7367),
    {user:tv_template(_7240,_7241,_7334:_7335,_7243,_7249)}.

at0([at0,lit(at),!],_7260,_7262) --> 
    cc(at,_7260,_7262),
    !.

at0([at0,_7284],_7273,_7275) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de,det],_7284,_7273,_7275).

omut0([omut0,lit(om),!],_7260,_7262) --> 
    cc(om,_7260,_7262),
    !.

omut0([omut0,lit(ut),!],_7260,_7262) --> 
    cc(ut,_7260,_7262),
    !.

omut0([omut0,[]],_7255,_7255) --> 
    [].

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},_7390,lit(om),_7430,!,_7464,!,_7498,_7522,{}],_7354,_7356) --> 
    {user:testmember(_7240,[ask,say,know,know1,answer,answer1])},
    reflexiv0(_7240,_7390,_7354,_7407),
    cc(om,_7407,_7429),
    not_look_ahead_lit([et,en],_7430,_7429,_7447),
    !,
    negation0(_7242,_7464,_7447,_7481),
    !,
    accept(_7498,_7481,_7513),
    clausal_object1(_7323:_7324,_7246::_7250,_7522,_7513,_7356),
    {user:co_template(_7240,whether,_7241,_7323:_7324,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},{},_7405,_7434,lit(at),!,_7474,!,_7508,_7532,{}],_7359,_7361) --> 
    {user:test(rv_templ(_7240,_7295))},
    {user:(\+testmember(_7240,[fail,help,let,lie2,slip,try]))},
    reflexiv0(_7240,_7405,_7359,_7422),
    omut0(_7434,_7422,_7449),
    cc(at,_7449,_7468),
    !,
    negation0(_7242,_7474,_7468,_7491),
    !,
    accept(_7508,_7491,_7523),
    clausal_object1(_7328:_7329,_7246::_7250,_7532,_7523,_7361),
    {user:tv_template(_7240,_7241,_7328:_7329,_7243,_7249)}.

at0([at0,lit(at),!],_7260,_7262) --> 
    cc(at,_7260,_7262),
    !.

at0([at0,_7282],_7271,_7273) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_7282,_7271,_7273).

omut0([omut0,lit(om),!],_7260,_7262) --> 
    cc(om,_7260,_7262),
    !.

omut0([omut0,lit(ut),!],_7260,_7262) --> 
    cc(ut,_7260,_7262),
    !.

omut0([omut0,[]],_7255,_7255) --> 
    [].

rvpk(_7240,_7241,_7242,_7243,_7244,[rvpk,{},_7374,_7418,_7442,!,_7481],_7338,_7340) --> 
    {user:testmember(_7240,[ask,check,discuss,know,know1,tell])},
    optional([om],_7374,_7338,_7406),
    hvilkemange(_7418,_7406,_7433),
    clausal_object0(_7270,_7271,_7442,_7433,_7461),
    !,
    pushstack(first,(w(verb(_7240,pres,fin)),w(prep(about)),xnp(_7270,_7271)),nil,_7461,_7522),
    do_phrase(_7240,_7241,_7242,_7243,_7244,_7481,_7522,_7340).

hvilkemange([hvilkemange,lit(hvilke)],_7257,_7259) --> 
    cc(hvilke,_7257,_7259).

hvilkemange([hvilkemange,lit(hvor),lit(mange)],_7262,_7264) --> 
    cc(hvor,_7262,_7283),
    cc(mange,_7283,_7264).

rvpk(_7240,_7241,id,_7243,_7246::_7249 and _7250,[rvpk,lit(om),lit('å'),{},{},!,_7414,{}],_7341,_7343) --> 
    cc(om,_7341,_7377),
    cc('å',_7377,_7388),
    {user:testmember(_7240,[ask])},
    {user:test(rv_templ(_7240,_7294))},
    !,
    pushstack(first,(npgap(_7241),aux1),nil,_7388,_7485),clausal_object1(_7308:coevent,_7246::_7250,_7414,_7485,_7343),
    {user:tv_template(_7240,_7241,_7308:coevent,_7243,_7249)}.

rvpk(_7240,_7241,id,_7243,_7246::_7249 and _7250,[rvpk,_7360,_7394,!,_7443,{}],_7334,_7336) --> 
    gmem(_7240,[need,start,stop,try,use2],_7360,_7334,_7379),
    optional(['å'],_7394,_7379,_7426),
    !,
    pushstack(first,(npgap(_7241),aux1),nil,_7426,_7514),clausal_object1(_7301:coevent,_7246::_7250,_7443,_7514,_7336),
    {user:tv_template(_7240,_7241,_7301:coevent,_7243,_7249)}.

rvpk(_7240,_7241,id,_7243,_7246::_7249 and _7250,[rvpk,_7422,lit('å'),{},!,_7492,_7516,{}],_7396,_7398) --> 
    optional(['på'],_7422,_7396,_7454),
    cc('å',_7454,_7476),
    {user:testmember(_7240,[avoid,choose,consider,deny,end,expect,forget,hate,hope,learn,like,manage,need,postpone,promise,propose,reach,recommend,refuse,remember,resist,risk,seem,slip,start,think,try,use2,want,wish,wonder])},
    !,
    accept(_7492,_7476,_7507),
    pushstack(first,(npgap(_7241),aux1),nil,_7507,_7587),clausal_object1(_7363:coevent,_7246::_7250,_7516,_7587,_7398),
    {user:tv_template(_7240,_7241,_7363:coevent,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},_7434,_7463,lit(om),_7518,_7552,_7581,!,_7610,_7634,{},_7688,{},{}],_7398,_7400) --> 
    {user:testmember(_7240,[answer,answer1,say])},
    reflexiv0(_7240,_7434,_7398,_7451),
    optional(['på'],_7463,_7451,_7495),
    cc(om,_7495,_7517),
    np1_accept(_7316,_7317,_7518,_7517,_7537),
    negation0(_7319,_7552,_7537,_7569),
    look_ahead_vp(_7581,_7569,_7596),
    !,
    accept(_7610,_7596,_7625),
    lexv(_7321,_7322,_7323,fin,_7634,_7625,_7657),
    {user:test(rv_templ(_7240,_7331))},
    pushstack(first,(xnp(_7316,_7317),w(verb(_7322,_7323,fin)),negation0(_7319)),nil,_7657,_7765),clausal_object1(_7350:coevent,_7246::_7250,_7688,_7765,_7400),
    {user:tv_template(_7240,_7241,_7350:coevent,_7243,_7294)},
    {user:negate(_7242,_7294,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7244,[rvpk,{},lit(om),_7383,_7422,!,_7456],_7336,_7338) --> 
    {user:testmember(_7240,[ask,worry,tell])},
    cc(om,_7336,_7382),
    np_kernel(0,_7271,_7272,_7383,_7382,_7404),
    look_ahead([som],_7422,_7404,_7439),
    !,
    pushstack(first,(w(verb(_7240,pres,fin)),w(prep(about)),np_kernel(0,_7271,_7272)),nil,_7439,_7498),
    do_phrase(_7240,_7241,_7242,_7243,_7244,_7456,_7498,_7338).

rvpk(_7240,_7241,id,_7243,_7246::_7249 and _7250,[rvpk,{},lit(om),_7372,{}],_7325,_7327) --> 
    {user:testmember(_7240,[ask,check,discuss,know,know1,see])},
    cc(om,_7325,_7371),
    clausal_object1(_7294:coevent,_7246::_7250,_7372,_7371,_7327),
    {user:tv_template(_7240,_7241,_7294:coevent,_7243,_7249)}.

rvpk(_7240,_7241,_7242,_7243,_7244,[rvpk,{},lit(om),_7374,!,_7413],_7327,_7329) --> 
    {user:testmember(_7240,[ask,worry,tell])},
    cc(om,_7327,_7373),
    np1_accept(_7267,_7268,_7374,_7373,_7393),
    !,
    pushstack(first,(w(verb(_7240,pres,fin)),w(prep(about)),xnp(_7267,_7268)),nil,_7393,_7454),
    do_phrase(_7240,_7241,_7242,_7243,_7244,_7413,_7454,_7329).

rvpk(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[rvpk,{},_7391,_7420,_7449,{},!,_7493,_7517,{}],_7355,_7357) --> 
    {user:testmember(_7240,[believe,clculate,know,know1,mean,tell,say])},
    negation0(_7242,_7391,_7355,_7408),
    reflexiv0(_7240,_7420,_7408,_7437),
    not_look_ahead([om],_7449,_7437,_7466),
    {user:test(rv_templ(_7240,_7316))},
    !,
    accept(_7493,_7466,_7508),
    clausal_object0(_7324:_7325,_7246::_7250,_7517,_7508,_7357),
    {user:tv_template(_7240,_7241,_7324:_7325,_7243,_7249)}.

clausal_object0(_7240,_7241,[clausal_object0,_7298,_7327,!,_7366],_7281,_7283) --> 
    look_ahead(w(nb(_7256,_7257)),_7298,_7281,_7315),
    obviousdate(_7240,_7241,_7327,_7315,_7346),
    !,
    accept(_7366,_7346,_7283).

clausal_object0(_7240,_7241,[clausal_object0,_7300,_7329,_7363],_7283,_7285) --> 
    not_look_ahead(w(nb(_7258,_7259)),_7300,_7283,_7317),
    np(_7249,_7250,_7329,_7317,_7348),
    cond_vp(_7249,_7250,_7240,_7241,_7363,_7348,_7285).

cond_vp(_7240,_7241,_7242,_7243,[cond_vp,_7322,{},_7361,!],_7299,_7301) --> 
    look_ahead([_7255],_7322,_7299,_7339),
    {user:testmember(_7255,[du,jeg])},
    lock(last,_7339,_7412),pushstack(last,xnp(_7240,_7241),nil,_7412,_7418),clausal_object1(_7242,_7243,_7361,_7418,_7407),unlock(_7407,_7301),
    !.

cond_vp(_7240,_7241,_7242,_7243,[cond_vp,_7313,_7342,_7366,!],_7290,_7292) --> 
    not_look_ahead(['så'],_7313,_7290,_7330),
    look_ahead_vp(_7342,_7330,_7357),
    pushstack(first,xnp(_7240,_7241),nil,_7357,_7410),clausal_object1(_7242,_7243,_7366,_7410,_7292),
    !.

cond_vp(_7240,_7241,_7240,_7241,[cond_vp,[]],_7268,_7268) --> 
    [].

clausal_object1(_7255:coevent,_7243::exists(_7255:coevent)::_7255 isa coevent and event/_7255/_7267 and _7253,[clausal_object1,_7314],_7297,_7299) --> 
    substatem(_7267,_7243::_7253,_7314,_7297,_7299).

clausal_object2(_7255:coevent,_7243::exists(_7255:coevent)::_7255 isa coevent and event/_7255/_7267 and _7253,[clausal_object2,_7314],_7297,_7299) --> 
    sostatem(_7267,_7243::_7253,_7314,_7297,_7299).

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7378,{},_7437,_7471,_7515,{},_7599,_7638],_7352,_7354) --> 
    hlexv(dtv,_7240,_7275,_7276,_7270,_7378,_7352,_7403),
    {user:testmember(_7240,[allow,let])},
    ind_object(_7288,_7289,_7437,_7403,_7456),
    optional(['å'],_7471,_7456,_7503),
    pushstack(first,(xnp(_7288,_7289),[vil]),nil,_7503,_7559),clausal_object1(_7303,_7306::_7247,_7515,_7559,_7574),
    {user:tv_template(_7240,_7241,_7303,_7243,_7318)},
    someevent00(_7243,_7318,_7246::_7306,_7599,_7574,_7620),
    negation2(_7270,_7242,_7638,_7620,_7354).

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7249 and _7250,[vp_kernel,_7420,_7464,_7493,_7522,_7551,_7580,_7614,_7643,{},_7682,{},_7726,_7770],_7394,_7396) --> 
    lexv(dtv,_7240,_7297,fin,_7420,_7394,_7443),
    not_look_ahead(w(adj2(_7304,nil)),_7464,_7443,_7481),
    not_look_ahead(w(nb(_7311,_7312)),_7493,_7481,_7510),
    not_look_ahead_lit([en,et,den,det,han,hun,vi],_7522,_7510,_7539),
    negation0(_7330,_7551,_7539,_7568),
    ind_object(_7332,_7293::_7249,_7580,_7568,_7599),
    negation0(_7338,_7614,_7599,_7631),
    not_look_ahead(['så'],_7643,_7631,_7660),
    {user:bigno(_7330,_7338,_7242)},
    object(_7350,_7293::_7250,_7682,_7660,_7701),
    {user:dtv_template(_7240,_7241,_7332,_7350,_7243,_7289)},
    optional([til],_7726,_7701,_7758),
    someevent00(_7243,_7289,_7246::_7293,_7770,_7758,_7396).

vp_kernel(notify,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7357,_7406,!,_7440,_7464,{},_7530],_7331,_7333) --> 
    hlexv(tv,notify,_7276,_7277,_7242,_7357,_7331,_7382),
    look_ahead(w(nb(_7284,_7285)),_7406,_7382,_7423),
    !,
    accept(_7440,_7423,_7455),
    lock(exact,_7455,_7484),pushstack(exact,[meg],nil,_7484,_7490),np0_accept(_7292,_7272::_7247,_7464,_7490,_7479),unlock(_7479,_7480),
    {user:tv_template(notify,_7241,_7292,_7243,_7268)},
    someevent00(_7243,_7268,_7246::_7272,_7530,_7480,_7333).

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7363,_7412,_7436,_7475,!,_7519,{},_7553,[]],_7337,_7339) --> 
    lexvaccept(tv,_7240,_7282,fin,_7242,_7363,_7337,_7388),
    redundant0(_7412,_7388,_7427),
    adverbx(_7276,_7277,_7278,_7436,_7427,_7457),
    object2(_7241,_7291,_7294::_7247,_7475,_7457,_7496),
    !,
    accept(_7519,_7496,_7534),
    {user:tv_template(_7240,_7241,_7291,_7243,_7303)},
    someevent00(_7243,_7303,_7246::_7294,_7553,_7534,_7574),
    pushstack(free,adverbx(_7276,_7277,_7278),nil,_7574,_7339),
    [].

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7408,_7457,_7486,{},{},{},{},{},!,_7580,{},_7614],_7382,_7384) --> 
    hlexv(tv,_7240,_7291,_7292,_7242,_7408,_7382,_7433),
    not_look_ahead_lit([om,hver],_7457,_7433,_7474),
    object2(_7241,_7302,_7287::_7247,_7486,_7474,_7507),
    {user:(\+constrain(_7302,date);_7240==have)},
    {user:(\+constrain(_7302,distance))},
    {user:(\+constrain(_7302,minute))},
    {user:(\+constrain(_7302,hour))},
    {user:(\+constrain(_7302,clock))},
    !,
    accept(_7580,_7507,_7595),
    {user:tv_template(_7240,_7241,_7302,_7243,_7283)},
    someevent00(_7243,_7283,_7246::_7287,_7614,_7595,_7384).

vp_kernel(_7240,_7241,_7242,_7243,_7244,[vp_kernel,_7352,_7401,{},{},!,_7460,_7484,_7508,_7537],_7326,_7328) --> 
    hlexv(iv,_7240,_7276,fin,_7242,_7352,_7326,_7377),
    gmem(_7240,[run,pass],_7401,_7377,_7420),
    {user:iv_template(_7240,_7241,_7243,_7271)},
    {user:_7276\==imp},
    !,
    redundants0(_7460,_7420,_7475),
    it0(_7484,_7475,_7499),
    reflexiv0(_7240,_7508,_7499,_7525),
    someevent00(_7243,_7271,_7244,_7537,_7525,_7328).

vp_kernel(have,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7395,_7424,_7448,{},_7487,lit(om),_7527,!,_7561,{},_7614],_7369,_7371) --> 
    negation0(_7286,_7395,_7369,_7412),
    has(_7424,_7412,_7439),
    negation0(_7288,_7448,_7439,_7465),
    {user:bigno(_7286,_7288,_7242)},
    w(noun(information,sin,u,n),_7487,_7465,_7504),
    cc(om,_7504,_7526),
    not_look_ahead_lit(['når','å',at],_7527,_7526,_7544),
    !,
    pushstack(first,(w(noun(information,sin,u,n)),w(prep(regarding))),nil,_7544,_7574),np1(_7323,_7284::_7247,_7561,_7574,_7589),
    {user:tv_template(have,_7241,_7323,_7243,_7280)},
    someevent00(_7243,_7280,_7246::_7284,_7614,_7589,_7371).

vp_kernel(have,_7241,_7242,_7243,_7244,[vp_kernel,_7340,_7369,_7393,{},!,_7437],_7314,_7316) --> 
    negation0(_7242,_7340,_7314,_7357),
    has(_7369,_7357,_7384),
    w(adj2(_7266,nil),_7393,_7384,_7410),
    {user:testmember(_7266,[open,closed])},
    !,
    pushstack(first,w(adj2(_7266,nil)),nil,_7410,_7447),
    be_complement(_7241,_7243,_7244,_7437,_7447,_7316).

vp_kernel(have,_7241,_7242,_7243,_7244,[vp_kernel,_7340,lit(det),_7375,_7404,_7433,!,_7482],_7314,_7316) --> 
    has(_7340,_7314,_7355),
    cc(det,_7355,_7374),
    negation0(_7242,_7375,_7374,_7392),
    w(adj2(_7269,nil),_7404,_7392,_7421),
    optional([da],_7433,_7421,_7465),
    !,
    pushstack(first,w(adj2(_7269,nil)),nil,_7465,_7492),
    be_complement(_7241,_7243,_7244,_7482,_7492,_7316).

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7409,_7438,_7467,_7516,{},{},_7565,_7594,_7623,_7647,!,_7691,{},_7725,_7764],_7383,_7385) --> 
    not_look_ahead(w(verb(have,_7299,_7300)),_7409,_7383,_7426),
    not_look_ahead(w(verb(be2,_7307,_7308)),_7438,_7426,_7455),
    hlexv(tv,_7240,_7312,_7313,_7291,_7467,_7455,_7492),
    not_look_ahead(w(prep(_7320)),_7516,_7492,_7533),
    {user:_7240\==have},
    {user:_7240\==be2},
    reflexiv0(_7240,_7565,_7533,_7582),
    particle0(_7240,_7594,_7582,_7611),
    redundant0(_7623,_7611,_7638),
    object2(_7241,_7337,_7340::_7247,_7647,_7638,_7668),
    !,
    accept(_7691,_7668,_7706),
    {user:tv_template(_7240,_7241,_7337,_7243,_7349)},
    someevent00(_7243,_7349,_7246::_7340,_7725,_7706,_7746),
    negation2(_7291,_7242,_7764,_7746,_7385).

menbare([menbare,lit(men)],_7257,_7259) --> 
    cc(men,_7257,_7259).

menbare([menbare,lit(bare)],_7257,_7259) --> 
    cc(bare,_7257,_7259).

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7419,_7448,_7477,{},{},{},_7556,_7595,_7624,{},_7673,_7712,[]],_7393,_7395) --> 
    not_look_ahead(w(verb(have,_7296,_7297)),_7419,_7393,_7436),
    not_look_ahead(w(verb(be2,_7304,_7305)),_7448,_7436,_7465),
    hlexv(tv,_7240,_7309,_7310,_7311,_7477,_7465,_7502),
    {user:_7240\==have},
    {user:_7240\==be2},
    {user:(\+verbtype(_7240,iv))},
    adverb(_7288,_7289,pre,_7556,_7502,_7577),
    not_look_ahead(w(noun(night,_7339,_7340,_7341)),_7595,_7577,_7612),
    object2(_7241,_7344,_7347::_7247,_7624,_7612,_7645),
    {user:tv_template(_7240,_7241,_7344,_7243,_7356)},
    someevent00(_7243,_7356,_7246::_7347,_7673,_7645,_7694),
    negation2(_7311,_7242,_7712,_7694,_7731),
    pushstack(free,xadverb(_7288,_7289),nil,_7731,_7395),
    [].

vp_kernel(be1,_7241,_7242,_7243,_7244,[vp_kernel,_7349,_7373,_7402,{},{},_7451,[]],_7323,_7325) --> 
    be(_7349,_7323,_7364),
    negation0(_7242,_7373,_7364,_7390),
    look_ahead(w(noun(_7277,_7278,_7279,_7280)),_7402,_7390,_7419),
    {user:subclass0(_7277,time)},
    {user:iv_template(be1,_7241,_7243,_7292)},
    someevent00(_7243,_7292,_7244,_7451,_7419,_7472),
    pushstack(free,w(prep(on)),nil,_7472,_7325),
    [].

vp_kernel(be1,_7241,id,_7243,_7244,[vp_kernel,_7351,{},_7385,{},{},_7434,[]],_7325,_7327) --> 
    be(_7351,_7325,_7366),
    {user:vartypeid(_7241,self)},
    look_ahead(w(name(_7280,n,_7282)),_7385,_7366,_7402),
    {user:subclass0(_7282,place)},
    {user:iv_template(be1,_7241,_7243,_7294)},
    someevent00(_7243,_7294,_7244,_7434,_7402,_7455),
    pushstack(free,w(prep(in)),nil,_7455,_7327),
    [].

vp_kernel(be1,_7241,_7242,_7243,_7244,[vp_kernel,_7325,_7349,_7378,{},_7412,_7436],_7299,_7301) --> 
    be(_7325,_7299,_7340),
    negation0(_7242,_7349,_7340,_7366),
    not_look_ahead_np(_7378,_7366,_7393),
    {user:iv_template(be1,_7241,_7243,_7262)},
    redundant0(_7412,_7393,_7427),
    someevent00(_7243,_7262,_7244,_7436,_7427,_7301).

vp_kernel(be1,_7241,_7242,_7243,_7244,[vp_kernel,_7345,_7369,_7398,{},!,{},_7452],_7319,_7321) --> 
    be(_7345,_7319,_7360),
    negation0(_7242,_7369,_7360,_7386),
    look_ahead(w(adv(_7274)),_7398,_7386,_7415),
    {user:testmember(_7274,[redundantly,inside,outside])},
    !,
    {user:iv_template(be1,_7241,_7243,_7265)},
    someevent00(_7243,_7265,_7244,_7452,_7415,_7321).

vp_kernel(be1,_7241,_7242,_7243,_7244,[vp_kernel,_7343,_7367,_7396,{},{},_7445,_7469],_7317,_7319) --> 
    be(_7343,_7317,_7358),
    negation0(_7242,_7367,_7358,_7384),
    look_ahead([_7271],_7396,_7384,_7413),
    {user:testmember(_7271,[her,der,overalt])},
    {user:iv_template(be1,_7241,_7243,_7265)},
    redundant0(_7445,_7413,_7460),
    someevent00(_7243,_7265,_7244,_7469,_7460,_7319).

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7389,{},_7428,_7457,_7491,_7520,_7544,_7573,{},_7622,_7661,!,_7700],_7363,_7365) --> 
    w(verb(_7287,_7288,fin),_7389,_7363,_7406),
    {user:testmember(_7287,[have])},
    negation0(_7298,_7428,_7406,_7445),
    particlev2(_7287,_7240,_7457,_7445,_7476),
    reflexiv0(_7240,_7491,_7476,_7508),
    redundant0(_7520,_7508,_7535),
    not_look_ahead(w(verb(_7309,past,part)),_7544,_7535,_7561),
    object2(_7241,_7314,_7317::_7247,_7573,_7561,_7594),
    {user:tv_template(_7240,_7241,_7314,_7243,_7326)},
    someevent00(_7243,_7326,_7246::_7317,_7622,_7594,_7643),
    negation2(_7298,_7242,_7661,_7643,_7680),
    !,
    accept(_7700,_7680,_7365).

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7400,{},!,_7459,_7488,_7537,_7566,_7590,{},_7639,!,_7683,[]],_7374,_7376) --> 
    lexv(tv,_7240,_7302,_7303,_7400,_7374,_7423),
    {user:testmember(_7240,[lay])},
    !,
    negation0(_7242,_7459,_7423,_7476),
    verb_mod1(_7240,_7292,_7243,_7294,_7297::_7298,_7488,_7476,_7513),
    particle(_7240,_7537,_7513,_7554),
    redundant0(_7566,_7554,_7581),
    object2(_7241,_7326,_7329::_7247,_7590,_7581,_7611),
    {user:tv_template(_7240,_7241,_7326,_7243,_7338)},
    someevent00(_7243,_7338,_7246::_7329,_7639,_7611,_7660),
    !,
    accept(_7683,_7660,_7698),
    pushstack(free,(particle(_7240),verb_mod1(_7240,_7292,_7243,_7294,_7297::_7298)),nil,_7698,_7376),
    [].

vp_kernel(evah,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7339,_7383,_7412,{},_7461],_7313,_7315) --> 
    lexv(tv,evah,_7270,fin,_7339,_7313,_7362),
    negation0(_7242,_7383,_7362,_7400),
    subject2(_7241,_7276,_7279::_7262,_7412,_7400,_7433),
    {user:has_template(_7276,_7241,_7279)},
    someevent00(_7243,_7262,_7246::_7247,_7461,_7433,_7315).

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7247,[vp_kernel,_7368,{},_7427,{},_7466,_7490,{},_7539,_7578],_7342,_7344) --> 
    hlexv(tv,_7240,_7278,_7279,_7273,_7368,_7342,_7393),
    {user:_7240==be2},
    reflexiv0(_7240,_7427,_7393,_7444),
    {user:compliancetest2(tv,_7240,_7241)},
    redundant0(_7466,_7444,_7481),
    object2(_7241,_7296,_7299::_7247,_7490,_7481,_7511),
    {user:tv_template(_7240,_7241,_7296,_7243,_7308)},
    someevent00(_7243,_7308,_7246::_7299,_7539,_7511,_7560),
    negation2(_7273,_7242,_7578,_7560,_7344).

vp_kernel(_7240,_7241,_7242,_7243,_7244,[vp_kernel,_7339,{},{},_7408,_7432,_7456,_7485],_7313,_7315) --> 
    hlexv(iv,_7240,_7270,fin,_7242,_7339,_7313,_7364),
    {user:iv_template(_7240,_7241,_7243,_7265)},
    {user:_7270\==imp},
    redundants0(_7408,_7364,_7423),
    it0(_7432,_7423,_7447),
    reflexiv0(_7240,_7456,_7447,_7473),
    someevent00(_7243,_7265,_7244,_7485,_7473,_7315).

vp_kernel(_7240,_7241,_7242,_7243,_7246::_7247,[vp_kernel,{},_7391,lit('Må'),{},_7441,!,_7475,_7543,_7577],_7355,_7357) --> 
    {user:constrain(_7241,person)},
    not_look_ahead([kan],_7391,_7355,_7408),
    cc('Må',_7408,_7430),
    {user:testmember('Må',['må',skal,vil])},
    not_look_ahead(w(verb(_7306,_7307,_7308)),_7441,_7430,_7458),
    !,
    pushstack(first,w(verb(arrive,pres,fin)),nil,_7458,_7488),intrans_verb(_7240,_7241,_7321,_7243,_7274,_7324,_7325,_7475,_7488,_7513),
    negation2(_7321,_7242,_7543,_7513,_7562),
    someevent00(_7243,_7274,_7246::_7247,_7577,_7562,_7357).

worldcomp(_7240,_7241,event/_7240/_7241::_7243,_7243,[worldcomp,[]],_7277,_7277) --> 
    [].

realcomp(_7240,event/real/_7240::_7242,_7242,[realcomp,[]],_7274,_7274) --> 
    [].

someevent00(_7240,_7241,_7244::exists(_7240:event)::_7241 and _7244,[someevent00,[]],_7279,_7279) --> 
    [].

thatto0(_7240,that,_7242,[thatto0,_7296,!,[]],_7276,_7278) --> 
    infinitive(_7296,_7276,_7311),
    !,
    pushstack(free,npgap(_7242),nil,_7311,_7278),
    [].

thatto0(_7240,_7241,_7242,[thatto0,_7295,!,_7329],_7275,_7277) --> 
    w(prep(on),_7295,_7275,_7312),
    !,
    reject(_7329,_7312,_7277).

thatto0(_7240,_7241,_7242,[thatto0,lit(om),_7315,!,_7349],_7284,_7286) --> 
    cc(om,_7284,_7314),
    look_ahead(w(name(_7259,_7260,_7261)),_7315,_7314,_7332),
    !,
    reject(_7349,_7332,_7286).

thatto0(_7240,_7241,_7242,[thatto0,lit(om),_7316,!,_7350],_7285,_7287) --> 
    cc(om,_7285,_7315),
    look_ahead(w(noun(departure,_7260,_7261,n)),_7316,_7315,_7333),
    !,
    reject(_7350,_7333,_7287).

that0(_7240,that,[that0,lit('på'),!,_7303],_7270,_7272) --> 
    cc('på',_7270,_7297),
    !,
    reject(_7303,_7297,_7272).

that0(_7240,when,[that0,_7344,lit('når'),_7389,_7418,!,_7457,[],!,_7531],_7327,_7329) --> 
    gmem(_7240,[know,know1,think,ask,notify,tell],_7344,_7327,_7363),
    cc('når',_7363,_7388),
    w(verb(_7286,_7287,fin),_7389,_7388,_7406),
    np1(_7290,_7291,_7418,_7406,_7437),
    !,
    accept(_7457,_7437,_7472),
    pushstack(free,(xnp(_7290,_7291),w(verb(_7286,_7287,fin))),nil,_7472,_7525),[],
    !,
    accept(_7531,_7525,_7329).

that0(ask,that,[that0,_7287],_7270,_7272) --> 
    look_ahead(w(verb(_7247,inf,_7249)),_7287,_7270,_7272).

that0(answer,whether,[that0,_7284,lit(om)],_7267,_7269) --> 
    on0(_7284,_7267,_7299),
    cc(om,_7299,_7269).

that0(ask,that,[that0,lit(om),_7301,!,_7330],_7273,_7275) --> 
    cc(om,_7273,_7300),
    infinitive(_7301,_7300,_7316),
    !,
    accept(_7330,_7316,_7275).

that0(ask,whether,[that0,lit(om),!,_7303],_7270,_7272) --> 
    cc(om,_7270,_7297),
    !,
    accept(_7303,_7297,_7272).

that0(ask,that,[that0,_7285,!,_7314],_7268,_7270) --> 
    infinitive(_7285,_7268,_7300),
    !,
    accept(_7314,_7300,_7270).

that0(believe,that,[that0,lit(at),!],_7267,_7269) --> 
    cc(at,_7267,_7269),
    !.

that0(believe,that,[that0,[]],_7262,_7262) --> 
    [].

that0(know,whether,[that0,lit(om),!],_7267,_7269) --> 
    cc(om,_7267,_7269),
    !.

that0(know,that,[that0,lit(at),!],_7267,_7269) --> 
    cc(at,_7267,_7269),
    !.

that0(know,that,[that0,_7295,_7324],_7278,_7280) --> 
    not_look_ahead([en],_7295,_7278,_7312),
    not_look_ahead(w(noun(_7250,_7251,_7252,_7253)),_7324,_7312,_7280).

that0(know1,whether,[that0,lit(om),!],_7267,_7269) --> 
    cc(om,_7267,_7269),
    !.

that0(know1,that,[that0,lit(at),!],_7267,_7269) --> 
    cc(at,_7267,_7269),
    !.

that0(know1,that,[that0,_7295,_7324],_7278,_7280) --> 
    not_look_ahead([en],_7295,_7278,_7312),
    not_look_ahead(w(noun(_7250,_7251,_7252,_7253)),_7324,_7312,_7280).

that0(let,that,[that0,[]],_7262,_7262) --> 
    [].

that0(mean,that,[that0,lit(at),!],_7267,_7269) --> 
    cc(at,_7267,_7269),
    !.

that0(mean,that,[that0,[]],_7262,_7262) --> 
    [].

that0(notify,that,[that0,lit(at)],_7264,_7266) --> 
    cc(at,_7264,_7266).

that0(notify,that,[that0,lit(om),lit(at),!,_7319],_7275,_7277) --> 
    cc(om,_7275,_7302),
    cc(at,_7302,_7313),
    !,
    accept(_7319,_7313,_7277).

that0(notify,_7241,[that0,lit(om),!,_7303],_7270,_7272) --> 
    cc(om,_7270,_7297),
    !,
    reject(_7303,_7297,_7272).

that0(say,that,[that0,lit(at),!],_7267,_7269) --> 
    cc(at,_7267,_7269),
    !.

that0(say,that,[that0,[]],_7262,_7262) --> 
    [].

that0(tell,that,[that0,_7289,!,_7323],_7272,_7274) --> 
    look_ahead([et],_7289,_7272,_7306),
    !,
    reject(_7323,_7306,_7274).

that0(tell,that,[that0,_7289,!,_7323],_7272,_7274) --> 
    look_ahead([en],_7289,_7272,_7306),
    !,
    reject(_7323,_7306,_7274).

that0(tell,that,[that0,lit(at),!],_7267,_7269) --> 
    cc(at,_7267,_7269),
    !.

that0(think,that,[that0,lit(at),!],_7267,_7269) --> 
    cc(at,_7267,_7269),
    !.

that0(think,that,[that0,[]],_7262,_7262) --> 
    [].

that0(understand,how,[that0,lit(hvordan)],_7264,_7266) --> 
    cc(hvordan,_7264,_7266).

that0(want,that,[that0,lit(at),!],_7267,_7269) --> 
    cc(at,_7267,_7269),
    !.

that0(want,to,[that0,lit(og)],_7264,_7266) --> 
    cc(og,_7264,_7266).

that0(wish,that,[that0,_7287],_7270,_7272) --> 
    look_ahead(w(verb(_7247,_7248,_7249)),_7287,_7270,_7272).

that0(_7240,_7241,[that0,_7299,!,_7333,_7362],_7282,_7284) --> 
    that(_7241,_7299,_7282,_7316),
    !,
    not_look_ahead(w(noun(departure,_7259,_7260,_7261)),_7333,_7316,_7350),
    accept(_7362,_7350,_7284).

rep_modifiers0(_7240,_7241,_7242,_7243,_7244,[rep_modifiers0,lit(hvor),!,_7321],_7279,_7281) --> 
    cc(hvor,_7279,_7315),
    !,
    reject(_7321,_7315,_7281).

rep_modifiers0(_7240,_7241,_7242,_7243,_7244,[rep_modifiers0,lit(hva),!,_7321],_7279,_7281) --> 
    cc(hva,_7279,_7315),
    !,
    reject(_7321,_7315,_7281).

rep_modifiers0(_7240,_7241,_7242,_7243,_7244,[rep_modifiers0,{},_7342,{},_7381],_7306,_7308) --> 
    {user:testmember(_7240,[see])},
    look_ahead(w(prep(_7272)),_7342,_7306,_7359),
    {user:testmember(_7272,[in])},
    verb_modifier(_7240,_7241,_7242,_7243,_7244,_7381,_7359,_7308).

rep_modifiers0(_7240,_7241,_7242,_7243,_7244,[rep_modifiers0,{},_7335,_7364],_7299,_7301) --> 
    {user:testmember(_7240,[say,tell])},
    prep1(to,_7335,_7299,_7352),
    pushstack(first,prep(to),nil,_7352,_7404),
    verb_modifiers(_7240,_7241,_7242,_7243,_7244,_7364,_7404,_7301).

rep_modifiers0(_7240,_7241,_7242,_7243,_7243,[rep_modifiers0,[]],_7271,_7271) --> 
    [].

be_complements(_7240,_7241,_7244::_7247 and _7248,[be_complements,lit(at),_7339,!,_7373,_7397,{}],_7308,_7310) --> 
    cc(at,_7308,_7338),
    look_ahead(w(prep(_7279)),_7339,_7338,_7356),
    !,
    preadverbials(_7373,_7356,_7388),
    clausal_object2(_7268,_7244::_7248,_7397,_7388,_7310),
    {user:bealign(_7240,_7268,_7241,_7248,_7247)}.

be_complements(_7240,_7241,_7244::_7247 and _7248,[be_complements,lit(at),!,_7335,_7359,{}],_7299,_7301) --> 
    cc(at,_7299,_7329),
    !,
    accept(_7335,_7329,_7350),
    clausal_object1(_7265,_7244::_7248,_7359,_7350,_7301),
    {user:bealign(_7240,_7265,_7241,_7248,_7247)}.

be_complements(_7240,_7241,_7244::_7247 and _7248,[be_complements,lit('å'),!,_7338,_7362,{}],_7302,_7304) --> 
    cc('å',_7302,_7332),
    !,
    accept(_7338,_7332,_7353),
    pushstack(first,someone,nil,_7353,_7403),clausal_object1(_7265,_7244::_7248,_7362,_7403,_7304),
    {user:bealign(_7240,_7265,_7241,_7248,_7247)}.

be_complements(_7240,_7241,_7242,[be_complements,_7303,_7342],_7283,_7285) --> 
    be_complement(_7240,_7241,_7256::_7257,_7303,_7283,_7324),
    be_complements20(_7240,_7241,_7256::_7257,_7242,_7342,_7324,_7285).

be_complements20(_7240,_7241,_7245::_7248,_7245::_7248 or _7249,[be_complements20,lit(eller),_7349,!,_7383,_7422],_7315,_7317) --> 
    cc(eller,_7315,_7348),
    not_look_ahead_lit(['.',?],_7349,_7348,_7366),
    !,
    be_complement(_7240,_7241,_7245::_7287,_7383,_7366,_7404),
    be_complements20(_7240,_7241,_7245::_7287,_7245::_7249,_7422,_7404,_7317).

be_complements20(_7240,_7241,_7245::_7248,_7245::_7248 and _7249,[be_complements20,_7318,_7342,_7381],_7295,_7297) --> 
    be_compl_conjunction(_7318,_7295,_7333),
    be_pred(_7240,_7241,_7262,_7342,_7333,_7363),
    be_complements20(_7240,_7241,_7262,_7245::_7249,_7381,_7363,_7297).

be_complements20(_7240,_7241,_7242,_7242,[be_complements20,_7291],_7268,_7270) --> 
    redundant0(_7291,_7268,_7270).

be_compl_conjunction([be_compl_conjunction,lit(og),!],_7260,_7262) --> 
    cc(og,_7260,_7262),
    !.

be_compl_conjunction([be_compl_conjunction,lit(men),_7293,!],_7271,_7273) --> 
    cc(men,_7271,_7292),
    look_ahead(w(verb(_7252,past,part)),_7293,_7292,_7273),
    !.

be_complement(_7240,_7241,_7242,[be_complement,_7298,_7327],_7278,_7280) --> 
    not_look_ahead_lit([der,her],_7298,_7278,_7315),
    be_pred(_7240,_7241,_7242,_7327,_7315,_7280).

be_complement(_7240,_7241,_7242,[be_complement,_7298,_7327],_7278,_7280) --> 
    not_look_ahead_lit([der,her],_7298,_7278,_7315),
    be_noun(_7240,_7241,_7242,_7327,_7315,_7280).

be_pred(_7240,_7241,_7242,[be_pred,_7322,{},_7376,_7400],_7302,_7304) --> 
    ap(_7259,_7240,_7241,_7256,_7322,_7302,_7345),
    {user:(\+testmember(_7259,[true,whole]))},
    not_look_ahead_nounx(_7376,_7345,_7391),
    verb_modifiers0(adj/nil/_7259,_7240,_7241,_7256,_7242,_7400,_7391,_7304).

be_pred(_7240,_7241,_7242,[be_pred,_7309,_7338,{}],_7289,_7291) --> 
    look_ahead(w(prep(_7260)),_7309,_7289,_7326),
    verb_mod1(be1,_7240,_7241,_7252,_7253,_7338,_7326,_7291),
    {user:thenwhat(_7252,_7253,_7242)}.

be_pred(_7240,_7241,_7242,[be_pred,_7376,_7405,_7434,{},_7473,_7539],_7356,_7358) --> 
    w(nb(_7277,num),_7376,_7356,_7393),
    w(noun(percent,_7271,u,n),_7405,_7393,_7422),
    w(adj2(_7289,nil),_7434,_7422,_7451),
    {user:testmember(_7289,[certain,safe])},
    lock(exact,_7451,_7493),pushstack(exact,w(adj2(_7289,nil)),nil,_7493,_7499),ap(_7289,_7240,_7241,_7312,_7473,_7499,_7488),unlock(_7488,_7489),
    pushstack(first,(w(prep(with)),w(nb(_7277,num)),w(noun(percent,_7271,u,n))),nil,_7489,_7549),
    verb_modifiers0(adj/nil/_7289,_7240,_7241,_7312,_7242,_7539,_7549,_7358).

be_pred(_7240,_7241,_7242,[be_pred,_7369,_7393,_7417,!,_7451,{},_7490,_7556],_7349,_7351) --> 
    ofte0(_7369,_7349,_7384),
    mangenoen(_7393,_7384,_7408),
    w(noun(minute,_7281,u,n),_7417,_7408,_7434),
    !,
    w(adj2(_7287,nil),_7451,_7434,_7468),
    {user:testmember(_7287,[delayed,tooearly])},
    lock(exact,_7468,_7510),pushstack(exact,w(adj2(_7287,nil)),nil,_7510,_7516),ap(_7287,_7240,_7241,_7310,_7490,_7516,_7505),unlock(_7505,_7506),
    pushstack(first,(w(prep(with)),w(noun(minute,plu,u,n))),nil,_7506,_7566),
    verb_modifiers0(adj/nil/_7287,_7240,_7241,_7310,_7242,_7556,_7566,_7351).

ofte0([ofte0,lit(ofte)],_7257,_7259) --> 
    cc(ofte,_7257,_7259).

ofte0([ofte0,[]],_7255,_7255) --> 
    [].

mangenoen([mangenoen,lit(mange)],_7257,_7259) --> 
    cc(mange,_7257,_7259).

mangenoen([mangenoen,lit(flere)],_7257,_7259) --> 
    cc(flere,_7257,_7259).

mangenoen([mangenoen,lit(noen)],_7257,_7259) --> 
    cc(noen,_7257,_7259).

be_pred(_7240,_7241,_7242,[be_pred,_7376,_7405,_7434,{},_7473,_7539],_7356,_7358) --> 
    w(nb(_7277,num),_7376,_7356,_7393),
    w(noun(minute,_7271,u,n),_7405,_7393,_7422),
    w(adj2(_7289,nil),_7434,_7422,_7451),
    {user:testmember(_7289,[delayed,tooearly])},
    lock(exact,_7451,_7493),pushstack(exact,w(adj2(_7289,nil)),nil,_7493,_7499),ap(_7289,_7240,_7241,_7312,_7473,_7499,_7488),unlock(_7488,_7489),
    pushstack(first,(w(prep(with)),w(nb(_7277,num)),w(noun(minute,_7271,u,n))),nil,_7489,_7549),
    verb_modifiers0(adj/nil/_7289,_7240,_7241,_7312,_7242,_7539,_7549,_7358).

be_pred(_7240,_7241,_7242,[be_pred,lit(mer),_7336,_7365,_7431],_7305,_7307) --> 
    cc(mer,_7305,_7335),
    look_ahead([enn],_7336,_7335,_7353),
    lock(exact,_7353,_7385),pushstack(exact,w(adj2(great,nil)),nil,_7385,_7391),ap(_7273,_7240,_7241,_7256,_7365,_7391,_7380),unlock(_7380,_7381),
    verb_modifiers0(adj/nil/_7273,_7240,_7241,_7256,_7242,_7431,_7381,_7307).

be_pred(_7240,_7241,_7244::_7245,[be_pred,_7295],_7275,_7277) --> 
    passive(_7240,_7241,_7244::_7245,_7295,_7275,_7277).

be_pred(_7240,_7241,_7242,[be_pred,_7296,_7335],_7276,_7278) --> 
    comparisons(_7240,_7241,_7248,_7296,_7276,_7317),
    someevent00(_7241,_7248,_7242,_7335,_7317,_7278).

be_pred(_7240,_7241,_7244::_7245,[be_pred,_7309,_7333],_7289,_7291) --> 
    sure(_7309,_7289,_7324),
    pushstack(first,w(verb(know,pres,fin)),nil,_7324,_7343),
    do_phrase(know,_7240,id,_7241,_7244::_7245,_7333,_7343,_7291).

be_pred(_7240,_7241,_7242,[be_pred,_7333,_7377,{},_7416],_7313,_7315) --> 
    ap(_7260,_7240,_7241,_7263,_7333,_7313,_7356),
    look_ahead([hva],_7377,_7356,_7394),
    {user:(\+testmember(_7260,[true,whole]))},
    pushstack(first,w(prep(on)),nil,_7394,_7426),
    verb_modifiers0(adj/nil/_7260,_7240,_7241,_7263,_7242,_7416,_7426,_7315).

fordent0(_7240,[fordent0,_7278,!],_7264,_7266) --> 
    gradverb(_7240,_7278,_7264,_7266),
    !.

fordent0(nil,[fordent0,_7273],_7259,_7261) --> 
    dent0(_7273,_7259,_7261).

not_look_ahead_nounx([not_look_ahead_nounx,_7278,!],_7267,_7269) --> 
    look_ahead(w(noun(clock,sin,def,n)),_7278,_7267,_7269),
    !.

not_look_ahead_nounx([not_look_ahead_nounx,_7275],_7264,_7266) --> 
    not_look_ahead(w(noun(_7244,_7245,_7246,_7247)),_7275,_7264,_7266).

be_noun(_7240,_7241,_7244::exists(_7241:event)::_7248,[be_noun,lit(at),_7332,{},!],_7301,_7303) --> 
    cc(at,_7301,_7331),
    clausal_object1(_7266,_7244::_7270,_7332,_7331,_7303),
    {user:bealign(_7240,_7266,_7241,_7270,_7248)},
    !.

be_noun(_7240,_7241,_7244::exists(_7241:event)::_7248,[be_noun,_7351,_7380,{},!,_7438],_7331,_7333) --> 
    look_ahead(w(nb(_7280,_7281)),_7351,_7331,_7368),
    pushstack(first,w(noun(clock,sin,def,n)),nil,_7368,_7393),obviousclock(_7293,_7296::_7297,_7380,_7393,_7408),
    {user:bealign(_7240,_7293,_7241,_7297,_7305)},
    !,
    verb_modifiers0(exist,_7240,_7241,_7296::_7305,_7244::_7248,_7438,_7408,_7333).

be_noun(_7240,_7241,_7244::exists(_7241:event)::_7248,[be_noun,_7341,_7365,{},_7409,!,_7458],_7321,_7323) --> 
    redundant0(_7341,_7321,_7356),
    object(_7279,_7282::_7283,_7365,_7356,_7384),
    {user:bealign(_7240,_7279,_7241,_7283,_7291)},
    optional([bare],_7409,_7384,_7441),
    !,
    verb_modifiers0(exist,_7240,_7241,_7282::_7291,_7244::_7248,_7458,_7441,_7323).

ap(_7240,_7241,_7242,_7243,[ap,_7309,_7333,_7377,_7401],_7286,_7288) --> 
    mthe10(_7309,_7286,_7324),
    adj1s(_7240,_7241,_7242,_7255,_7333,_7324,_7356),
    redundant0(_7377,_7356,_7392),
    someevent00(_7242,_7255,_7243,_7401,_7392,_7288).

ap(_7240,_7241,_7242,_7243,[ap,_7332,{},{},_7381],_7309,_7311) --> 
    w(verb(_7240,past,part),_7332,_7309,_7349),
    {user:(\+testmember(_7240,[be,have]))},
    {user:adj_template(nil,be/_7240,_7241,_7242,_7255)},
    someevent00(_7242,_7255,_7243,_7381,_7349,_7311).

mthe10([mthe10,lit(mye)],_7257,_7259) --> 
    cc(mye,_7257,_7259).

mthe10([mthe10,_7266],_7255,_7257) --> 
    the0(_7266,_7255,_7257).

passive(_7240,_7241,_7242,[passive,_7376,_7405,_7439,{},_7493,!,_7532],_7356,_7358) --> 
    w(noun(_7279,sin,u,n),_7376,_7356,_7393),
    gmem(_7279,[video,camera],_7405,_7393,_7424),
    lexv(tv,_7299,_7300,part,_7439,_7424,_7462),
    {user:(\+testmember(_7299,[be2,have]))},
    whodidit(_7314,_7315,_7493,_7462,_7512),
    !,
    pushstack(first,(np(_7314,_7315),w(verb(_7299,_7300,fin)),npgap(_7240),w(prep(by)),w(noun(_7279,sin,u,n))),nil,_7512,_7603),
    state(_7241,_7242,_7532,_7603,_7358).

passive(_7240,_7241,_7242,[passive,_7353,{},_7407,_7436,!,_7475],_7333,_7335) --> 
    lexv(dtv,_7271,past,part,_7353,_7333,_7376),
    {user:(\+testmember(_7271,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_7294,_7295)),_7407,_7376,_7424),
    whodidit(_7297,_7298,_7436,_7424,_7455),
    !,
    pushstack(first,(np(_7297,_7298),w(verb(_7271,past,fin)),npgap(_7240)),nil,_7455,_7546),
    state(_7241,_7242,_7475,_7546,_7335).

passive(_7240,_7241,_7242,[passive,_7365,{},_7419,_7448,_7482,!,_7521],_7345,_7347) --> 
    lexv(dtv,_7278,_7279,part,_7365,_7345,_7388),
    {user:(\+testmember(_7278,[be2,have,wish,want]))},
    not_look_ahead(w(adj2(_7301,_7302)),_7419,_7388,_7436),
    ind_object(_7274,_7275,_7448,_7436,_7467),
    whodidit(_7307,_7308,_7482,_7467,_7501),
    !,
    pushstack(free,(np(_7307,_7308),w(verb(_7278,_7279,fin)),npgap(_7240),noun_phrase1(_7274,_7275)),nil,_7501,_7623),
    state(_7241,_7242,_7521,_7623,_7347).

passive(_7240,_7241,_7244::_7245,[passive,_7343,lit(om),_7398,!,_7437],_7323,_7325) --> 
    lexv(tv,notify,past,part,_7343,_7323,_7366),
    cc(om,_7366,_7397),
    whodidit(_7280,_7281,_7398,_7397,_7417),
    !,
    lock(last,_7417,_7515),
    pushstack(last,(xnp(_7280,_7281),w(verb(notify,pres,fin)),w(prep(regarding)),npgap(_7240)),nil,_7515,_7521),
    state(_7241,_7244::_7245,_7437,_7521,_7510),
    unlock(_7510,_7325).

passive(_7240,_7241,_7242,[passive,_7356,!,_7400,{},_7454,!,_7493],_7336,_7338) --> 
    adverbial1(_7274,_7275,_7276,_7356,_7336,_7377),
    !,
    lexv(tv,_7283,_7284,part,_7400,_7377,_7423),
    {user:(\+testmember(_7283,[be2,have]))},
    whodidit(_7298,_7299,_7454,_7423,_7473),
    !,
    pushstack(first,(np(_7298,_7299),w(verb(_7283,_7284,fin)),npgap(_7240),adverbial1(_7274,_7275,_7276)),nil,_7473,_7596),
    state(_7241,_7242,_7493,_7596,_7338).

passive(_7240,_7241,_7242,[passive,_7348,{},_7402,_7436,_7460,!,_7499],_7328,_7330) --> 
    lexv(tv,_7274,_7275,part,_7348,_7328,_7371),
    {user:(\+testmember(_7274,[be2,have]))},
    particlev0(_7274,_7290,_7402,_7371,_7421),
    redundant0(_7436,_7421,_7451),
    whodidit(_7292,_7293,_7460,_7451,_7479),
    !,
    pushstack(first,(np(_7292,_7293),w(verb(_7290,_7275,fin)),npgap(_7240)),nil,_7479,_7570),
    state(_7241,_7242,_7499,_7570,_7330).

passive(_7240,_7241,_7242,[passive,_7387,{},_7441,lit(og),_7476,{},!,_7540,!,_7579],_7367,_7369) --> 
    lexv(tv,_7289,past,part,_7387,_7367,_7410),
    {user:(\+testmember(_7289,[be2,have]))},
    redundant0(_7441,_7410,_7456),
    cc(og,_7456,_7475),
    hlexv(tv,_7307,past,part,id,_7476,_7475,_7501),
    {user:(\+testmember(_7289,[be2,have]))},
    !,
    whodidit(_7323,_7324,_7540,_7501,_7559),
    !,
    pushstack(first,(np(_7323,_7324),w(verb(_7289,past,fin)),[og],w(verb(_7307,past,fin)),npgap(_7240)),nil,_7559,_7650),
    state(_7241,_7242,_7579,_7650,_7369).

whodidit(_7240,_7241,[whodidit,lit(av),lit(at),_7320,!,_7359],_7281,_7283) --> 
    cc(av,_7281,_7308),
    cc(at,_7308,_7319),
    clausal_object1(_7240,_7241,_7320,_7319,_7339),
    !,
    accept(_7359,_7339,_7283).

whodidit(_7240,_7241,[whodidit,_7288,!,_7317],_7271,_7273) --> 
    by(_7288,_7271,_7303),
    !,
    np(_7240,_7241,_7317,_7303,_7273).

whodidit(_7240,_7241,[whodidit,_7298,!,_7359],_7281,_7283) --> 
    lock(exact,_7281,_7318),pushstack(exact,w(noun(agent,sin,u,n)),nil,_7318,_7324),np1(_7240,_7241,_7298,_7324,_7313),unlock(_7313,_7314),
    !,
    accept(_7359,_7314,_7283).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7348,lit(det),lit('å'),_7414,_7457,!,_7496],_7325,_7327) --> 
    lexv(tv,_7273,_7274,fin,_7348,_7325,_7371),
    cc(det,_7371,_7402),
    cc('å',_7402,_7413),
    pushstack(first,[noen],nil,_7413,_7427),clausal_object1(_7286,_7270,_7414,_7427,_7442),
    traceprint(4,qv0a,_7457,_7442,_7476),
    !,
    pushstack(first,(lexv(tv,_7273,_7274,fin),xnp(_7240,_7270)),nil,_7476,_7570),
    verb_phrase(_7286,_7241,_7242,_7243,_7496,_7570,_7327).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7403,{},{},_7467,_7501,_7530,_7559,{},_7603,_7632,_7656,!,_7695],_7380,_7382) --> 
    lexv(tv,_7299,_7300,fin,_7403,_7380,_7426),
    {user:_7299\==ask},
    {user:_7299\==have},
    subject(_7313,_7314,_7467,_7426,_7486),
    negation0(_7241,_7501,_7486,_7518),
    not_look_ahead([om],_7530,_7518,_7547),
    object(_7322,_7323,_7559,_7547,_7578),
    {user:subject_object_test(_7299,_7313,_7322)},
    w(prep(_7333),_7603,_7578,_7620),
    not_look_ahead_np(_7632,_7620,_7647),
    traceprint(4,qv0b,_7656,_7647,_7675),
    !,
    pushstack(first,(xnp(_7313,_7314),w(verb(_7299,pres,fin)),xnp(_7322,_7323),w(prep(_7333)),npgap(_7240)),nil,_7675,_7797),
    state(_7242,_7243,_7695,_7797,_7382).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7383,{},_7437,_7471,_7500,_7529,_7553,!,_7592,{},_7626],_7360,_7362) --> 
    lexv(iv,_7290,_7291,fin,_7383,_7360,_7406),
    {user:(\+testmember(_7290,[think]))},
    subject(_7303,_7304,_7437,_7406,_7456),
    negation0(_7241,_7471,_7456,_7488),
    w(prep(_7310),_7500,_7488,_7517),
    not_look_ahead_np(_7529,_7517,_7544),
    traceprint(4,qv1,_7553,_7544,_7572),
    !,
    accept(_7592,_7572,_7607),
    {user:adjustprepv(_7290,_7310,_7319)},
    pushstack(first,(xnp(_7303,_7304),w(verb(_7290,_7291,fin)),w(prep(_7319)),npgap(_7240)),nil,_7607,_7697),
    state(_7242,_7243,_7626,_7697,_7362).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7363,_7407,_7441,_7465,[],_7539,!,_7578],_7340,_7342) --> 
    lexv(rv,_7282,pres,fin,_7363,_7340,_7386),
    subject(_7286,_7287,_7407,_7386,_7426),
    infinitive(_7441,_7426,_7456),
    w(verb(do,inf,fin),_7465,_7456,_7482),
    pushstack(free,xnp(_7240,_7287),nil,_7482,_7538),[],
    traceprint(4,qv2,_7539,_7538,_7558),
    !,
    pushstack(first,(w(verb(_7282,pres,fin)),['å'],w(verb(do,inf,fin))),nil,_7558,_7588),
    verb_phrase(_7286,_7241,_7242,_7243,_7578,_7588,_7342).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7362,_7406,_7440,_7474,_7498,!,[],_7582],_7339,_7341) --> 
    lexv(dtv,_7281,_7282,fin,_7362,_7339,_7385),
    subject(_7285,_7286,_7406,_7385,_7425),
    ind_object(_7288,_7289,_7440,_7425,_7459),
    omaa(_7474,_7459,_7489),
    traceprint(4,qv3,_7498,_7489,_7517),
    !,
    pushstack(free,xnp(_7240,_7286),nil,_7517,_7581),[],
    pushstack(first,(w(verb(_7281,_7282,fin)),xnp(_7288,_7289),[om],['å']),nil,_7581,_7623),
    verb_phrase(_7285,_7241,_7242,_7243,_7582,_7623,_7341).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7364,{},{},_7428,_7462,{},_7506,!,_7545],_7341,_7343) --> 
    lexv(tv,_7279,_7280,fin,_7364,_7341,_7387),
    {user:_7279\==ask},
    {user:_7279\==have},
    subject(_7293,_7276,_7428,_7387,_7447),
    particlev0(_7279,_7297,_7462,_7447,_7481),
    {user:subject_object_test(_7279,_7293,_7240)},
    traceprint(4,qv4,_7506,_7481,_7525),
    !,
    pushstack(first,(lexv(tv,_7297,_7280,fin),xnp(_7240,_7276)),nil,_7525,_7619),
    verb_phrase(_7293,_7241,_7242,_7243,_7545,_7619,_7343).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7378,_7402,_7431,_7465,_7509,{},{},_7558,!,_7597,{}],_7355,_7357) --> 
    aux1(_7378,_7355,_7393),
    negation0(_7277,_7402,_7393,_7419),
    subject(_7283,_7284,_7431,_7419,_7450),
    lexv(tv,_7287,inf,fin,_7465,_7450,_7488),
    not_look_ahead([om],_7509,_7488,_7526),
    {user:_7287\==have},
    {user:test(tv_template(_7287,_7283,_7240,_7242,_7308))},
    traceprint(4,qv5,_7558,_7526,_7577),
    !,
    pushstack(first,(lexv(tv,_7287,pres,fin),xnp(_7240,_7284)),nil,_7577,_7672),verb_phrase(_7283,_7278,_7242,_7243,_7597,_7672,_7357),
    {user:bigno(_7277,_7278,_7241)}.

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7368,_7392,_7426,_7455,_7484,_7513,!,_7552],_7345,_7347) --> 
    aux1(_7368,_7345,_7383),
    subject(_7281,_7279,_7392,_7383,_7411),
    w(verb(be,inf,fin),_7426,_7411,_7443),
    w(adj2(_7292,_7293),_7455,_7443,_7472),
    w(prep(_7297),_7484,_7472,_7501),
    traceprint(4,qv6,_7513,_7501,_7532),
    !,
    pushstack(first,(w(verb(be,pres,fin)),w(adj2(_7292,_7293)),w(prep(_7297)),xnp(_7240,_7279)),nil,_7532,_7593),
    verb_phrase(_7281,_7241,_7242,_7243,_7552,_7593,_7347).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7347,lit(du),_7382,_7411,_7440,!,_7479],_7324,_7326) --> 
    has(_7347,_7324,_7362),
    cc(du,_7362,_7381),
    negation0(_7241,_7382,_7381,_7399),
    prepnom(_7277,_7411,_7399,_7428),
    traceprint(4,qv7,_7440,_7428,_7459),
    !,
    pushstack(first,([du],w(verb(have,pres,fin)),npgap(_7240),w(prep(_7277))),nil,_7459,_7519),
    state(_7242,_7243,_7479,_7519,_7326).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7368,_7392,_7426,_7455,_7484,!,_7523],_7345,_7347) --> 
    has(_7368,_7345,_7383),
    np1_accept(_7281,_7278::_7279,_7392,_7383,_7411),
    w(noun(_7289,_7290,_7291,n),_7426,_7411,_7443),
    prepnom(_7294,_7455,_7443,_7472),
    traceprint(4,qv8,_7484,_7472,_7503),
    !,
    pushstack(free,(w(verb(have,pres,fin)),w(noun(_7289,sin,u,n)),w(prep(_7294)),noun_phrase1(_7240,_7278::_7279)),nil,_7503,_7567),
    do_phrase(have,_7281,_7241,_7242,_7243,_7523,_7567,_7347).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7368,_7392,_7426,_7455,{},_7494,_7533,!,_7572],_7345,_7347) --> 
    has(_7368,_7345,_7383),
    subject(_7283,_7284,_7392,_7383,_7411),
    negation0(_7241,_7426,_7411,_7443),
    w(verb(_7290,_7291,part),_7455,_7443,_7472),
    {user:testmember(_7290,[go])},
    defaultprep(_7290,_7240,_7303,_7494,_7472,_7515),
    traceprint(4,qv9,_7533,_7515,_7552),
    !,
    pushstack(first,(xnp(_7283,_7284),w(verb(_7290,_7291,fin)),prep1(_7303),npgap(_7240)),nil,_7552,_7674),
    state(_7242,_7243,_7572,_7674,_7347).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7346,_7370,_7404,_7433,_7462,!,_7501],_7323,_7325) --> 
    has(_7346,_7323,_7361),
    subject(_7274,_7275,_7370,_7361,_7389),
    negation0(_7241,_7404,_7389,_7421),
    w(verb(_7281,past,part),_7433,_7421,_7450),
    traceprint(4,qv10,_7462,_7450,_7481),
    !,
    pushstack(first,(xnp(_7274,_7275),w(verb(_7281,past,fin)),npgap(_7240)),nil,_7481,_7572),
    state(_7242,_7243,_7501,_7572,_7325).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7343,_7367,_7401,_7430,_7459,!,_7498],_7320,_7322) --> 
    has(_7343,_7320,_7358),
    np1_accept(_7275,_7276,_7367,_7358,_7386),
    negation0(_7241,_7401,_7386,_7418),
    w(verb(_7271,_7272,part),_7430,_7418,_7447),
    traceprint(4,qv11,_7459,_7447,_7478),
    !,
    pushstack(first,(xnp(_7275,_7276),w(verb(_7271,_7272,fin))),nil,_7478,_7539),
    verb_phrase(_7240,id,_7242,_7243,_7498,_7539,_7322).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,lit(kan),_7360,_7394,_7428,_7457,!,_7496],_7326,_7328) --> 
    cc(kan,_7326,_7359),
    subject(_7274,_7270,_7360,_7359,_7379),
    negation2(id,_7241,_7394,_7379,_7413),
    not_look_ahead(w(verb(_7284,_7285,_7286)),_7428,_7413,_7445),
    traceprint(4,qv12,_7457,_7445,_7476),
    !,
    lock(last,_7476,_7544),
    pushstack(last,(w(verb(know1,pres,fin)),xnp(_7240,_7270)),nil,_7544,_7550),
    do_phrase(_7291,_7274,id,_7242,_7243,_7496,_7550,_7539),
    unlock(_7539,_7328).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7365,_7394,_7428,_7462,_7491,_7520,!,_7559],_7342,_7344) --> 
    w(verb(_7279,_7280,fin),_7365,_7342,_7382),
    gmem(_7279,[talk,speak],_7394,_7382,_7413),
    subject(_7290,_7291,_7428,_7413,_7447),
    negation0(_7241,_7462,_7447,_7479),
    look_ahead(w(prep(_7299)),_7491,_7479,_7508),
    traceprint(4,qv13a,_7520,_7508,_7539),
    !,
    lock(last,_7539,_7637),
    pushstack(last,(xnp(_7240,_7291),w(verb(_7279,_7280,fin)),negation(_7241)),nil,_7637,_7643),
    do_phrase(_7304,_7290,id,_7242,_7243,_7559,_7643,_7632),
    unlock(_7632,_7344).

qverb_phrase(_7240,id,_7242,_7243,[qverb_phrase,_7341,_7365,_7399,_7428,!,_7467],_7318,_7320) --> 
    aux1(_7341,_7318,_7356),
    subject(_7271,_7272,_7365,_7356,_7384),
    w(verb(be,_7277,fin),_7399,_7384,_7416),
    traceprint(4,qv15c,_7428,_7416,_7447),
    !,
    pushstack(first,(xnp(_7271,_7272),w(verb(be,pres,fin)),npgap(_7240)),nil,_7447,_7538),
    state(_7242,_7243,_7467,_7538,_7320).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7327,_7351,_7385,_7419,!,_7458],_7304,_7306) --> 
    docan(_7327,_7304,_7342),
    subject(_7266,_7264,_7351,_7342,_7370),
    negation2(id,_7241,_7385,_7370,_7404),
    traceprint(4,qv13b,_7419,_7404,_7438),
    !,
    lock(last,_7438,_7506),
    pushstack(last,xnp(_7240,_7264),nil,_7506,_7512),
    do_phrase(_7275,_7266,id,_7242,_7243,_7458,_7512,_7501),
    unlock(_7501,_7306).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,{},_7371,_7395,_7429,lit(av),_7469,!,_7508],_7338,_7340) --> 
    {user:constrain(_7240,place)},
    aux1(_7371,_7338,_7386),
    np1_accept(_7285,_7288::_7289,_7395,_7386,_7414),
    negation0(_7241,_7429,_7414,_7446),
    cc(av,_7446,_7468),
    traceprint(4,qv14,_7469,_7468,_7488),
    !,
    pushstack(first,(noun_phrase1(_7285,_7288::_7289),w(verb(go,pres,fin)),[av],npgap(_7240)),nil,_7488,_7582),
    state(_7242,_7243,_7508,_7582,_7340).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7376,_7405,_7429,_7463,_7492,_7521,_7550,!,_7589],_7353,_7355) --> 
    w(verb(be,pres,_7290),_7376,_7353,_7393),
    thereit0(_7405,_7393,_7420),
    np1_accept(_7292,_7295::_7296,_7429,_7420,_7448),
    negation0(_7241,_7463,_7448,_7480),
    w(verb(_7302,_7303,part),_7492,_7480,_7509),
    prep(_7306,_7521,_7509,_7538),
    traceprint(4,qv15,_7550,_7538,_7569),
    !,
    pushstack(first,(someone,w(verb(_7302,_7303,fin)),noun_phrase1(_7292,_7295::_7296),w(prep(_7306)),npgap(_7240)),nil,_7569,_7691),
    state(_7242,_7243,_7589,_7691,_7355).

qverb_phrase(_7240,id,_7242,_7243,[qverb_phrase,_7368,_7397,_7431,_7460,_7489,!,_7528],_7345,_7347) --> 
    w(verb(be,_7283,fin),_7368,_7345,_7385),
    subject(_7286,_7287,_7397,_7385,_7416),
    w(adj2(_7291,nil),_7431,_7416,_7448),
    w(prep(_7296),_7460,_7448,_7477),
    traceprint(4,qv15a,_7489,_7477,_7508),
    !,
    pushstack(first,(xnp(_7286,_7287),w(verb(be,pres,fin)),w(adj2(_7291,nil)),w(prep(_7296)),npgap(_7240)),nil,_7508,_7599),
    state(_7242,_7243,_7528,_7599,_7347).

qverb_phrase(_7240,id,_7242,_7243,[qverb_phrase,_7338,_7367,_7401,!,_7440],_7315,_7317) --> 
    w(verb(be,_7271,fin),_7338,_7315,_7355),
    subject(_7274,_7275,_7367,_7355,_7386),
    traceprint(4,qv15b,_7401,_7386,_7420),
    !,
    pushstack(first,(xnp(_7274,_7275),w(verb(be,pres,fin)),npgap(_7240)),nil,_7420,_7511),
    state(_7242,_7243,_7440,_7511,_7317).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7367,_7396,_7420,_7454,_7483,_7512,{},_7546,!,_7585],_7344,_7346) --> 
    w(verb(be,_7289,fin),_7367,_7344,_7384),
    thereit0(_7396,_7384,_7411),
    np1_accept(_7292,_7293,_7420,_7411,_7439),
    negation0(_7241,_7454,_7439,_7471),
    prep(_7297,_7483,_7471,_7500),
    not_look_ahead_np(_7512,_7500,_7527),
    {user:_7297\==towards},
    traceprint(4,qv16,_7546,_7527,_7565),
    !,
    pushstack(first,(xnp(_7292,_7293),w(verb(be1,pres,fin)),prep(_7297),npgap(_7240)),nil,_7565,_7686),
    state(_7242,_7243,_7585,_7686,_7346).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7430,{},_7484,_7518,_7547,_7581,_7610,_7634,!,{},{},_7693],_7407,_7409) --> 
    lexv(tv,_7296,_7297,fin,_7430,_7407,_7453),
    {user:(\+testmember(_7296,[pass,be1,be,be2,cost,have,know1]))},
    np1_accept(_7321,_7324::_7325,_7484,_7453,_7503),
    negation0(_7241,_7518,_7503,_7535),
    np1_accept(_7240,_7332::_7333,_7547,_7535,_7566),
    prep1(_7335,_7581,_7566,_7598),
    endofline(_7610,_7598,_7625),
    traceprint(4,qv17,_7634,_7625,_7653),
    !,
    {user:(\+testmember(_7335,[off,of]))},
    {user:test(verb_compl(_7296,_7335,_7321,_7240,_7359,_7360))},
    pushstack(first,(noun_phrase1(_7321,_7324::_7325),lexv(tv,_7296,_7297,fin),noun_phrase1(_7240,_7332::_7333),prep1(_7335),npgap(_7240)),nil,_7653,_7864),
    state(_7242,_7243,_7693,_7864,_7409).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7438,_7467,_7496,{},{},_7560,_7584,_7618,_7647,{},{},_7706,_7730,!,_7769],_7415,_7417) --> 
    not_look_ahead([kan],_7438,_7415,_7455),
    not_look_ahead(w(verb(be,_7310,_7311)),_7467,_7455,_7484),
    lexv(_7313,_7314,_7315,fin,_7496,_7484,_7519),
    {user:(_7313==iv;_7313==rv)},
    {user:(\+testmember(_7314,[pass]))},
    thereit0(_7560,_7519,_7575),
    np1_accept(_7338,_7341::_7342,_7584,_7575,_7603),
    negation0(_7241,_7618,_7603,_7635),
    defaultprep(_7314,_7240,_7348,_7647,_7635,_7668),
    {user:(\+testmember(_7348,[off,of]))},
    {user:test(verb_compl(_7314,_7348,_7338,_7240,_7369,_7370))},
    qtrailer0(_7706,_7668,_7721),
    traceprint(4,qv18,_7730,_7721,_7749),
    !,
    pushstack(first,(noun_phrase1(_7338,_7341::_7342),w(verb(_7314,_7315,fin)),prep1(_7348),npgap(_7240)),nil,_7749,_7873),
    state(_7242,_7243,_7769,_7873,_7417).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,{},_7402,{},_7441,_7470,_7504,_7533,_7572,!,_7611],_7369,_7371) --> 
    {user:constrain(_7240,place)},
    w(verb(_7293,_7294,fin),_7402,_7369,_7419),
    {user:(\+testmember(_7293,[be,take,pass]))},
    not_look_ahead([det],_7441,_7419,_7458),
    np1_accept(_7314,_7317::_7318,_7470,_7458,_7489),
    negation0(_7241,_7504,_7489,_7521),
    defaultprep(_7293,_7240,_7324,_7533,_7521,_7554),
    traceprint(4,qv19,_7572,_7554,_7591),
    !,
    pushstack(first,(noun_phrase1(_7314,_7317:_7318),w(verb(_7293,pres,fin)),prep1(_7324),npgap(_7240)),nil,_7591,_7712),
    state(_7242,_7243,_7611,_7712,_7371).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7392,{},_7446,_7480,{},_7519,{},_7558,!,_7597],_7369,_7371) --> 
    lexv(iv,_7287,_7288,fin,_7392,_7369,_7415),
    {user:_7287\==be1},
    np1_accept(_7296,_7299::_7300,_7446,_7415,_7465),
    negation0(_7241,_7480,_7465,_7497),
    {user:constrain(_7296,vehicle)},
    prep1(_7309,_7519,_7497,_7536),
    {user:testmember(_7309,[to,from,past,by,on])},
    traceprint(4,qv20,_7558,_7536,_7577),
    !,
    pushstack(first,(noun_phrase1(_7296,_7299::_7300),w(verb(_7287,pres,fin)),prep1(_7309),npgap(_7240)),nil,_7577,_7701),
    state(_7242,_7243,_7597,_7701,_7371).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7342,_7366,_7400,_7444,!,_7483],_7319,_7321) --> 
    doit(_7342,_7319,_7357),
    noun_phrase1(_7272,_7269::_7270,_7366,_7357,_7385),
    lexv(_7278,know1,_7280,fin,_7400,_7385,_7423),
    traceprint(4,qv21,_7444,_7423,_7463),
    !,
    pushstack(first,(lexv(_7278,know1,_7280,fin),np(_7240,_7269::_7270)),nil,_7463,_7558),
    verb_phrase(_7272,_7241,_7242,_7243,_7483,_7558,_7321).

qverb_phrase(_7240,_7241,_7242,_7245::_7246,[qverb_phrase,_7336,_7360,_7394,_7418,!,_7457],_7313,_7315) --> 
    use(_7336,_7313,_7351),
    noun_phrase1(_7271,_7274::_7246,_7360,_7351,_7379),
    in_order_to(_7394,_7379,_7409),
    traceprint(4,qv22,_7418,_7409,_7437),
    !,
    pushstack(free,(prep(with),npgap(_7240)),nil,_7437,_7527),
    verb_phrase(_7271,_7241,_7242,_7245::_7274,_7457,_7527,_7315).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7335,_7359,_7388,_7417,!,_7456],_7312,_7314) --> 
    be(_7335,_7312,_7350),
    thereit2(be,_7359,_7350,_7376),
    not_look_ahead(w(noun(_7275,_7276,u,_7278)),_7388,_7376,_7405),
    traceprint(4,qv23,_7417,_7405,_7436),
    !,
    pushstack(first,w(verb(exist,pres,fin)),nil,_7436,_7466),
    verb_phrase1(exist,_7240,_7241,_7242,_7243,_7456,_7466,_7314).

qverb_phrase(_7240,id,_7242,_7243,[qverb_phrase,{},_7373,{},_7427,{},_7471,!,_7510],_7340,_7342) --> 
    {user:constrain(_7240,route)},
    lexv(iv,_7283,_7284,fin,_7373,_7340,_7396),
    {user:testmember(_7283,[go])},
    subject(_7294,_7295,_7427,_7396,_7446),
    {user:constrain(_7294,vehicle)},
    traceprint(4,qv24,_7471,_7446,_7490),
    !,
    lock(last,_7490,_7588),
    pushstack(last,(xnp(_7294,_7295),w(verb(_7283,_7284,fin)),npgap(_7240)),nil,_7588,_7594),
    state(_7242,_7243,_7510,_7594,_7583),
    unlock(_7583,_7342).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7351,_7395,{},_7439,_7468,!,_7507],_7328,_7330) --> 
    lexv(tv,_7273,_7274,fin,_7351,_7328,_7374),
    subject(_7277,_7270,_7395,_7374,_7414),
    {user:subject_object_test(_7273,_7277,_7240)},
    not_look_ahead(w(prep(_7290)),_7439,_7414,_7456),
    traceprint(4,qv25,_7468,_7456,_7487),
    !,
    pushstack(first,(lexv(tv,_7273,_7274,fin),xnp(_7240,_7270)),nil,_7487,_7581),
    verb_phrase(_7277,_7241,_7242,_7243,_7507,_7581,_7330).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7316,_7345,!,_7384],_7293,_7295) --> 
    look_ahead(w(verb(be,_7264,fin)),_7316,_7293,_7333),
    traceprint(4,qv26,_7345,_7333,_7364),
    !,
    verb_phrase(_7240,_7241,_7242,_7243,_7384,_7364,_7295).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7335,{},_7374,_7403,!,_7442],_7312,_7314) --> 
    not_look_ahead(w(verb(be,_7270,fin)),_7335,_7312,_7352),
    {user:vartypeid(_7240,thing)},
    look_ahead(w(verb(_7282,_7283,fin)),_7374,_7352,_7391),
    traceprint(4,qv27,_7403,_7391,_7422),
    !,
    verb_phrase(_7240,_7241,_7242,_7243,_7442,_7422,_7314).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7346,lit(du),_7386,_7410,_7444,lit(kan),_7489,!,_7528],_7323,_7325) --> 
    w(verb(believe,pres,fin),_7346,_7323,_7363),
    cc(du,_7363,_7385),
    that0(_7386,_7385,_7401),
    noun_phrase1(_7283,_7273,_7410,_7401,_7429),
    negation2(id,_7241,_7444,_7429,_7463),
    cc(kan,_7463,_7488),
    traceprint(4,qv28,_7489,_7488,_7508),
    !,
    pushstack(free,xnp(_7240,_7273),nil,_7508,_7569),
    do_phrase(believe,_7283,id,_7242,_7243,_7528,_7569,_7325).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7330,_7354,_7388,_7422,_7446,!,_7485],_7307,_7309) --> 
    doit(_7330,_7307,_7345),
    noun_phrase1(_7269,_7267,_7354,_7345,_7373),
    negation2(id,_7241,_7388,_7373,_7407),
    redundant0x(_7422,_7407,_7437),
    traceprint(4,qv29,_7446,_7437,_7465),
    !,
    lock(last,_7465,_7533),
    pushstack(last,xnp(_7240,_7267),nil,_7533,_7539),
    do_phrase(_7278,_7269,id,_7242,_7243,_7485,_7539,_7528),
    unlock(_7528,_7309).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7365,{},_7419,_7443,_7477,_7501,_7530,!,_7569],_7342,_7344) --> 
    lexv(iv,_7282,_7283,fin,_7365,_7342,_7388),
    {user:(\+testmember(_7282,[know,know1,be1]))},
    thereit(_7419,_7388,_7434),
    noun_phrase1(_7299,_7279,_7443,_7434,_7462),
    adverbx0(_7477,_7462,_7492),
    prep0(_7302,_7501,_7492,_7518),
    traceprint(4,qv30,_7530,_7518,_7549),
    !,
    pushstack(first,(lexv(iv,_7282,_7283,fin),prep(_7302),xnp(_7240,_7279)),nil,_7549,_7673),
    verb_phrase(_7299,_7241,_7242,_7243,_7569,_7673,_7344).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7353,_7377,_7411,_7455,_7479,_7523,!,_7562],_7330,_7332) --> 
    has(_7353,_7330,_7368),
    np1_accept(_7278,_7275::_7276,_7377,_7368,_7396),
    lexv(rv,_7285,past,part,_7411,_7396,_7434),
    infinitive(_7455,_7434,_7470),
    lexv(tv,_7290,inf,fin,_7479,_7470,_7502),
    traceprint(4,qv31,_7523,_7502,_7542),
    !,
    pushstack(first,(lexv(tv,_7290,pres,fin),np(_7240,_7275::_7276)),nil,_7542,_7639),
    verb_phrase(_7278,_7241,_7242,_7243,_7562,_7639,_7332).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7342,_7366,_7400,_7444,!,_7483],_7319,_7321) --> 
    has(_7342,_7319,_7357),
    np1_accept(_7272,_7269::_7270,_7366,_7357,_7385),
    lexv(tv,_7279,past,part,_7400,_7385,_7423),
    traceprint(4,qv32,_7444,_7423,_7463),
    !,
    pushstack(first,(lexv(tv,_7279,past,fin),np(_7240,_7269::_7270)),nil,_7463,_7558),
    verb_phrase(_7272,_7241,_7242,_7243,_7483,_7558,_7321).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7339,_7363,{},_7407,!,_7446],_7316,_7318) --> 
    has(_7339,_7316,_7354),
    np1_accept(_7269,_7267,_7363,_7354,_7382),
    {user:has_template(_7269,_7240,_7276)},
    traceprint(4,qv33,_7407,_7382,_7426),
    !,
    pushstack(free,(w(verb(have,pres,fin)),noun_phrase1(_7240,_7267)),nil,_7426,_7487),
    do_phrase(have,_7269,_7241,_7242,_7243,_7446,_7487,_7318).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7370,_7394,_7428,_7472,_7506,_7535,!,_7574],_7347,_7349) --> 
    has(_7370,_7347,_7385),
    np1_accept(_7284,_7281::_7282,_7394,_7385,_7413),
    lexv(tv,_7291,past,part,_7428,_7413,_7451),
    noun_phrase1(_7295,_7298::_7299,_7472,_7451,_7491),
    prep(_7301,_7506,_7491,_7523),
    traceprint(4,qv34,_7535,_7523,_7554),
    !,
    pushstack(first,(lexv(tv,_7291,past,fin),np(_7295,_7298::_7299),prep(_7301),np(_7240,_7281::_7282)),nil,_7554,_7715),
    verb_phrase(_7284,_7241,_7242,_7243,_7574,_7715,_7349).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7326,{},_7365,!,_7404],_7303,_7305) --> 
    not_look_ahead(w(verb(be,_7267,fin)),_7326,_7303,_7343),
    {user:(\+vartypeid(_7240,thing))},
    traceprint(4,qv35,_7365,_7343,_7384),
    !,
    verb_phrase(_7240,_7241,_7242,_7243,_7404,_7384,_7305).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,{},_7346,_7375,_7399,!,_7438],_7313,_7315) --> 
    {user:(\+vartypeid(_7240,thing))},
    w(verb(_7265,_7266,fin),_7346,_7313,_7363),
    thereit0(_7375,_7363,_7390),
    traceprint(4,qv36,_7399,_7390,_7418),
    !,
    pushstack(first,w(verb(_7265,_7266,fin)),nil,_7418,_7448),
    verb_phrase(_7240,_7241,_7242,_7243,_7438,_7448,_7315).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7339,_7383,_7407,_7494,!,_7533],_7316,_7318) --> 
    lexv(_7269,_7270,_7271,fin,_7339,_7316,_7362),
    thereit(_7383,_7362,_7398),
    lock(exact,_7398,_7458),pushstack(exact,this,nil,_7458,_7464),npa(_7277,_7267,_7407,_7464,_7453),unlock(_7453,_7454),
    traceprint(4,qv37,_7494,_7454,_7513),
    !,
    pushstack(first,(lexv(_7269,_7270,_7271,fin),xnp(_7240,_7267)),nil,_7513,_7607),
    verb_phrase(_7277,_7241,_7242,_7243,_7533,_7607,_7318).

qverb_phrase(_7240,_7241,_7242,_7243,[qverb_phrase,_7388,{},_7442,_7476,_7505,_7544,!,_7583,_7607,_7646],_7365,_7367) --> 
    lexv(iv,_7290,_7291,fin,_7388,_7365,_7411),
    {user:(\+testmember(_7290,[think]))},
    np1_accept(_7303,_7304,_7442,_7411,_7461),
    negation0(_7241,_7476,_7461,_7493),
    adverbial1(_7308,_7309,_7312::_7313,_7505,_7493,_7526),
    traceprint(4,qv38,_7544,_7526,_7563),
    !,
    accept(_7583,_7563,_7598),
    defaultprep(_7290,_7240,_7320,_7607,_7598,_7628),
    pushstack(first,(xnp(_7303,_7304),lexv(iv,_7290,_7291,fin),adverbial1(_7308,_7309,_7312::_7313),prep1(_7320),npgap(_7240)),nil,_7628,_7815),
    state(_7242,_7243,_7646,_7815,_7367).

verb_modifiers0(_7240,_7241,_7242,_7243,_7244,[verb_modifiers0,lit(hva),!,_7321],_7279,_7281) --> 
    cc(hva,_7279,_7315),
    !,
    reject(_7321,_7315,_7281).

verb_modifiers0(_7240,_7241,_7242,_7243,_7244,[verb_modifiers0,_7303],_7277,_7279) --> 
    verb_modifiers(_7240,_7241,_7242,_7243,_7244,_7303,_7277,_7279).

verb_modifiers0(_7240,_7241,_7242,_7243,_7244,[verb_modifiers0,_7309,!,_7338],_7283,_7285) --> 
    redundant(_7309,_7283,_7324),
    !,
    verb_modifiers(_7240,_7241,_7242,_7243,_7244,_7338,_7324,_7285).

verb_modifiers0(_7240,_7241,_7242,_7243,_7243,[verb_modifiers0,{}],_7278,_7278) --> 
    {user:(\+_7240=be1)}.

verb_modifiers(_7240,_7241,_7242,_7243,_7244,[verb_modifiers,_7318,!,_7372,_7396],_7292,_7294) --> 
    verb_modifier(_7240,_7241,_7242,_7243,_7258,_7318,_7292,_7343),
    !,
    accept(_7372,_7343,_7387),
    verb_modifiers10(_7240,_7241,_7242,_7258,_7244,_7396,_7387,_7294).

verb_modifiers10(_7240,_7241,_7242,_7243,_7244,[verb_modifiers10,_7309,_7333,_7357],_7283,_7285) --> 
    vmod_conjunction(_7309,_7283,_7324),
    look_ahead_prepadv(_7333,_7324,_7348),
    verb_modifiers(_7240,_7241,_7242,_7243,_7244,_7357,_7348,_7285).

verb_modifiers10(go,_7241,_7242,_7243,_7244,[verb_modifiers10,_7329,_7353,!,_7387,_7411],_7303,_7305) --> 
    numberroute(_7329,_7303,_7344),
    look_ahead(w(nb(_7269,num)),_7353,_7344,_7370),
    !,
    accept(_7387,_7370,_7402),
    pushstack(first,w(prep(with)),nil,_7402,_7421),
    verb_modifiers(go,_7241,_7242,_7243,_7244,_7411,_7421,_7305).

verb_modifiers10(_7240,_7241,_7242,_7243,_7244,[verb_modifiers10,_7317,_7341,_7370],_7291,_7293) --> 
    point(_7317,_7291,_7332),
    look_ahead(w(name(_7262,_7263,_7264)),_7341,_7332,_7358),
    verb_modifiers0(_7240,_7241,_7242,_7243,_7244,_7370,_7358,_7293).

verb_modifiers10(_7240,_7241,_7242,_7243,_7244,[verb_modifiers10,_7303],_7277,_7279) --> 
    verb_modifiers0(_7240,_7241,_7242,_7243,_7244,_7303,_7277,_7279).

verb_modifiers10(_7240,_7241,_7242,_7243,_7243,[verb_modifiers10,[]],_7271,_7271) --> 
    [].

look_ahead_prepadv([look_ahead_prepadv,_7275,!],_7264,_7266) --> 
    look_ahead(w(prep(_7247)),_7275,_7264,_7266),
    !.

look_ahead_prepadv([look_ahead_prepadv,_7275,!],_7264,_7266) --> 
    look_ahead(w(adv(_7247)),_7275,_7264,_7266),
    !.

verb_modifier(_7240,_7241,_7242,_7252 and _7246::_7247,_7246::_7247,[verb_modifier,_7352,_7381,{},{}],_7326,_7328) --> 
    thisplace(_7275,_7352,_7326,_7369),
    not_look_ahead([jegdu],_7381,_7369,_7328),
    {user:verb_compl(_7240,_7275,_7241,_7290:place,_7242,_7273)},
    {user:_7252=(findexternal(_7290:place)::_7290 isa place and _7273)}.

verb_modifier(_7240,_7241,_7242,_7252 and _7246::_7250,_7246::_7247,[verb_modifier,_7315],_7289,_7291) --> 
    verb_mod1(_7240,_7241,_7242,_7252,_7250::_7247,_7315,_7289,_7291).

verb_modifier(_7240,_7241,_7242,_7252 and _7246::_7247,_7246::_7247,[verb_modifier,_7321,!,{}],_7295,_7297) --> 
    today(_7321,_7295,_7297),
    !,
    {user:adv_compl(_7240,today,_7241,time,_7242,_7252)}.

verb_modifier(_7240,_7241,_7242,_7243,_7243,[verb_modifier,_7305,!,_7339],_7279,_7281) --> 
    particlev1(_7240,_7305,_7279,_7322),
    !,
    accept(_7339,_7322,_7281).

verb_modifier(_7240,_7241,_7242,_7243,_7243,[verb_modifier,{},_7319],_7283,_7285) --> 
    {user:testmember(_7240,[want])},
    reflexiv(_7240,_7319,_7283,_7285).

verb_modifier(_7240,_7241,_7242,_7252 and _7246::_7250,_7246::_7247,[verb_modifier,{},_7350,_7394,{}],_7314,_7316) --> 
    {user:_7240\==be1},
    lexv(iv,_7279,pres,part,_7350,_7314,_7373),
    verb_modifier3(_7279,_7241,_7269,_7250,_7247,_7394,_7373,_7316),
    {user:verb_compl(_7240,during,_7241,_7269,_7242,_7252)}.

verb_modifier(_7240,_7241,_7242,_7246 and _7253::_7250,_7246::_7247,[verb_modifier,_7336,_7360,{}],_7310,_7312) --> 
    this(_7336,_7310,_7351),
    pushstack(first,(prep(in),this),nil,_7351,_7431),adverbial(_7264,_7266,_7250::_7247,_7360,_7431,_7312),
    {user:verb_compl(_7240,_7264,_7241,_7266,_7242,_7253)}.

verb_modifier(_7240,_7241,_7242,_7252 and _7246::_7247,_7246::_7247,[verb_modifier,_7322,{}],_7296,_7298) --> 
    partday(_7261,_7263,_7269,_7322,_7296,_7298),
    {user:adv_compl(_7240,_7261,_7241,_7263,_7242,_7252)}.

verb_modifier(_7240,_7241,_7242,_7252 and _7246::_7250,_7246::_7247,[verb_modifier,_7336,_7365,{},!,_7419],_7310,_7312) --> 
    nil_compl(_7240,_7336,_7310,_7353),
    adjunct1(nil,_7270,_7250::_7247,_7365,_7353,_7386),
    {user:verb_compl(_7240,nil,_7241,_7270,_7242,_7252)},
    !,
    accept(_7419,_7386,_7312).

verb_modifier(_7240,_7241,_7242,_7252 and _7246::_7250,_7246::_7247,[verb_modifier,_7336,_7365,{},!,_7419],_7310,_7312) --> 
    dir_compl(_7240,_7336,_7310,_7353),
    adjunct1(dir,_7270,_7250::_7247,_7365,_7353,_7386),
    {user:verb_compl(_7240,dir,_7241,_7270,_7242,_7252)},
    !,
    accept(_7419,_7386,_7312).

verb_modifier(adj/nil/_7250,_7241,_7242,_7258 and _7246::_7256,_7246::_7247,[verb_modifier,_7349,_7373,_7422,{}],_7323,_7325) --> 
    infinitive(_7349,_7323,_7364),
    subordinateinfnosubj(nil,coevent,_7241,_7275,_7283,_7373,_7364,_7398),
    determiner00(_7275,_7256,_7283::_7247,_7422,_7398,_7325),
    {user:verb_compl(adj/nil/_7250,in_order_to,_7241,_7275,_7242,_7258)}.

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,_7353,_7387,{},_7426,!,_7465,{}],_7327,_7329) --> 
    gmem(_7240,[be1,go,arrive,depart],_7353,_7327,_7372),
    w(prep(_7267),_7387,_7372,_7404),
    {user:testmember(_7267,[before,after,between])},
    plausibleclock(_7269,_7244,_7426,_7404,_7445),
    !,
    accept(_7465,_7445,_7329),
    {user:verb_compl(_7240,_7267,_7241,_7269,_7242,_7243)}.

verb_mod1(look,_7241,_7242,_7243,_7246::_7247,[verb_mod1,_7342,lit(ut),!,_7387,{}],_7316,_7318) --> 
    w(adj2(_7272,_7273),_7342,_7316,_7359),
    cc(ut,_7359,_7381),
    !,
    lock(exact,_7381,_7407),pushstack(exact,w(adv(_7272)),nil,_7407,_7413),adverbix(_7264,_7266,_7246::_7247,_7387,_7413,_7402),unlock(_7402,_7318),
    {user:verb_compl(look,_7264,_7241,_7266,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,_7344,_7378,{},!,_7422,{}],_7318,_7320) --> 
    gmem(_7240,[be1],_7344,_7318,_7363),
    w(prep(_7264),_7378,_7363,_7395),
    {user:(\+member(_7264,[between,for]))},
    !,
    np1_accept(_7266,_7244,_7422,_7395,_7320),
    {user:verb_compl(_7240,_7264,_7241,_7266,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,lit(som),_7338,!,_7372,{}],_7301,_7303) --> 
    cc(som,_7301,_7337),
    w(prep(in),_7338,_7337,_7355),
    !,
    np1_accept(_7263,_7244,_7372,_7355,_7303),
    {user:verb_compl(_7240,as_in,_7241,_7263,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,lit(som),!,_7336,{}],_7294,_7296) --> 
    cc(som,_7294,_7330),
    !,
    np1_accept(_7260,_7244,_7336,_7330,_7296),
    {user:verb_compl(_7240,as,_7241,_7260,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,_7357,_7391,{},_7430,!,_7464,{}],_7331,_7333) --> 
    gmem(_7240,[exist],_7357,_7331,_7376),
    one_of_lit([til,'før'],_7391,_7376,_7408),
    {user:(vartypeid(_7241,_7289),subclass0(_7289,duration))},
    not_look_ahead(w(name(_7299,n,place)),_7430,_7408,_7447),
    !,
    clausal_object0(_7269,_7244,_7464,_7447,_7333),
    {user:verb_compl(_7240,until,_7241,_7269,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,{},lit(_7279),{},{},!,_7400,{}],_7328,_7330) --> 
    {user:testmember(_7240,[exist])},
    cc(_7279,_7328,_7374),
    {user:testmember(_7279,[siden])},
    {user:(vartypeid(_7241,_7294),subclass0(_7294,duration))},
    !,
    clausal_object0(_7269,_7244,_7400,_7374,_7330),
    {user:verb_compl(_7240,since,_7241,_7269,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,{},lit(med),lit(at),!,_7372,{}],_7309,_7311) --> 
    {user:testmember(_7240,[mean])},
    cc(med,_7309,_7355),
    cc(at,_7355,_7366),
    !,
    clausal_object1(_7266,_7244,_7372,_7366,_7311),
    {user:verb_compl(_7240,with,_7241,_7266,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},_7369,_7398,!,_7432,{}],_7333,_7335) --> 
    {user:testmember(_7240,[ask])},
    not_look_ahead(['nå'],_7369,_7333,_7386),
    look_ahead(w(verb(_7288,inf,fin)),_7398,_7386,_7415),
    !,
    pushstack(first,(npgap(_7241),[vil]),nil,_7415,_7475),clausal_object1(_7269,_7246::_7247,_7432,_7475,_7335),
    {user:verb_compl(_7240,regarding,_7241,_7269,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,{},lit(om),_7360,!,_7394,{}],_7313,_7315) --> 
    {user:testmember(_7240,[notify,take])},
    cc(om,_7313,_7359),
    not_look_ahead([en],_7360,_7359,_7377),
    !,
    clausal_object0(_7266,_7244,_7394,_7377,_7315),
    {user:verb_compl(_7240,regarding,_7241,_7266,_7242,_7243)}.

verb_mod1(adj/nil/_7247,_7241,_7242,_7243,_7244,[verb_mod1,{},_7365,!,_7399,{}],_7329,_7331) --> 
    {user:testmember(_7247,[delayed])},
    w(nb(_7282,num),_7365,_7329,_7382),
    !,
    pushstack(first,(w(prep(with)),w(nb(_7282,num))),nil,_7382,_7412),pp(with,_7269,_7244,_7399,_7412,_7331),
    {user:adj_compl(_7247,with,_7241,_7269,_7242,_7243)}.

'utenå'(['utenå',lit(uten),_7288,_7312,!],_7266,_7268) --> 
    cc(uten,_7266,_7287),
    'ogå'(_7288,_7287,_7303),
    'måtte'(_7312,_7303,_7268),
    !.

'utenå'(['utenå',lit(uten),_7282],_7260,_7262) --> 
    cc(uten,_7260,_7281),
    'ogå'(_7282,_7281,_7262).

'måtte'(['måtte',_7278],_7267,_7269) --> 
    one_of_lit(['måtte',ville,skulle,burde,kunne],_7278,_7267,_7269).

verb_mod1(adj/nil/_7247,_7241,_7242,_7243,_7244,[verb_mod1,{},_7346,!,_7375,{}],_7310,_7312) --> 
    {user:testmember(_7247,[afraid,happy])},
    foratx0(_7346,_7310,_7361),
    !,
    clausal_object1(_7269,_7244,_7375,_7361,_7312),
    {user:adj_compl(_7247,because_of,_7241,_7269,_7242,_7243)}.

foratx0([foratx0,lit(for),lit(at)],_7262,_7264) --> 
    cc(for,_7262,_7283),
    cc(at,_7283,_7264).

foratx0([foratx0,lit(at)],_7257,_7259) --> 
    cc(at,_7257,_7259).

foratx0([foratx0,_7282],_7271,_7273) --> 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_7282,_7271,_7273).

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,{},_7340,_7364,{},!],_7304,_7306) --> 
    {user:testmember(_7240,[label,be_named])},
    look_ahead_np(_7340,_7304,_7355),
    np0_accept(_7267,_7244,_7364,_7355,_7306),
    {user:verb_compl(_7240,with,_7241,_7267,_7242,_7243)},
    !.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},lit(enn),lit('å'),!,_7389,{}],_7326,_7328) --> 
    {user:(\+testmember(_7240,[be,be1,be2]))},
    cc(enn,_7326,_7372),
    cc('å',_7372,_7383),
    !,
    pushstack(first,[noen],nil,_7383,_7402),clausal_object1(_7269,_7246::_7247,_7389,_7402,_7328),
    {user:verb_compl(_7240,than,_7241,_7269,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},lit(enn),lit(at),!,_7384,{}],_7321,_7323) --> 
    {user:(\+testmember(_7240,[be,be1,be2]))},
    cc(enn,_7321,_7367),
    cc(at,_7367,_7378),
    !,
    clausal_object1(_7269,_7246::_7247,_7384,_7378,_7323),
    {user:verb_compl(_7240,than,_7241,_7269,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},lit(enn),_7360,{}],_7313,_7315) --> 
    {user:(\+testmember(_7240,[be,be1,be2]))},
    cc(enn,_7313,_7359),
    np1(_7263,_7246::_7247,_7360,_7359,_7315),
    {user:verb_compl(_7240,than,_7241,_7263,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,{},_7356,{},!,_7400,{}],_7320,_7322) --> 
    {user:testmember(_7240,[notify,wait])},
    w(prep(_7264),_7356,_7320,_7373),
    {user:(\+testmember(_7264,[for]))},
    !,
    clausal_object0(_7266,_7244,_7400,_7373,_7322),
    {user:verb_compl(_7240,_7264,_7241,_7266,_7242,_7243)}.

verb_mod1(adj/nil/_7250,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},_7380,lit('å'),!,_7440,{}],_7344,_7346) --> 
    {user:testmember(_7250,[nice,good,bad,interested,interesting])},
    optional(w(prep(_7298)),_7380,_7344,_7412),
    cc('å',_7412,_7434),
    !,
    pushstack(first,npgap(_7241),nil,_7434,_7483),clausal_object1(_7275,_7246::_7247,_7440,_7483,_7346),
    {user:verb_compl(adj/nil/_7250,because_of,_7241,_7275,_7242,_7243)}.

overat([overat,lit(fordi)],_7257,_7259) --> 
    cc(fordi,_7257,_7259).

overat([overat,lit(av),lit(at)],_7262,_7264) --> 
    cc(av,_7262,_7283),
    cc(at,_7283,_7264).

overat([overat,lit(over),lit(at)],_7262,_7264) --> 
    cc(over,_7262,_7283),
    cc(at,_7283,_7264).

overat([overat,lit(til),lit(at)],_7262,_7264) --> 
    cc(til,_7262,_7283),
    cc(at,_7283,_7264).

verb_mod1(adj/nil/_7247,_7241,_7242,_7243,_7244,[verb_mod1,{},lit(av),lit(hvilken),!,_7384,{}],_7321,_7323) --> 
    {user:(\+testmember(_7247,[]))},
    cc(av,_7321,_7367),
    cc(hvilken,_7367,_7378),
    !,
    np1(_7272,_7244,_7384,_7378,_7323),
    {user:verb_compl(adj/nil/_7247,of,_7241,_7272,_7242,_7243)}.

verb_mod1(adj/nil/_7250,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},_7361,!,_7390,{}],_7325,_7327) --> 
    {user:(\+testmember(_7250,[]))},
    overaa(_7361,_7325,_7376),
    !,
    pushstack(first,npgap(_7241),nil,_7376,_7433),clausal_object1(_7272,_7246::_7247,_7390,_7433,_7327),
    {user:verb_compl(adj/nil/_7250,because_of,_7241,_7272,_7242,_7243)}.

overaa([overaa,lit(av),lit('å')],_7262,_7264) --> 
    cc(av,_7262,_7283),
    cc('å',_7283,_7264).

overaa([overaa,lit(over),lit('å')],_7262,_7264) --> 
    cc(over,_7262,_7283),
    cc('å',_7283,_7264).

overaa([overaa,lit(til),lit('å')],_7262,_7264) --> 
    cc(til,_7262,_7283),
    cc('å',_7283,_7264).

verb_mod1(_7240,_7241,_7242,_7243,_7244,[verb_mod1,{},_7348,lit('å'),!,_7388,{}],_7312,_7314) --> 
    {user:(\+testmember(_7240,[]))},
    instead_of(_7348,_7312,_7363),
    cc('å',_7363,_7382),
    !,
    pushstack(first,npgap(_7241),nil,_7382,_7431),clausal_object1(_7266,_7244,_7388,_7431,_7314),
    {user:verb_compl(_7240,instead_of,_7241,_7266,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7246,[verb_mod1,_7342,_7371,{},_7420,{}],_7316,_7318) --> 
    gradverb0(_7270,_7342,_7316,_7359),
    adverb(_7264,_7266,_7274,_7371,_7359,_7392),
    {user:testmember(_7264,[slowly,fast,thereafter])},
    not_look_ahead([det],_7420,_7392,_7318),
    {user:adv_compl(_7240,_7264,_7241,_7266,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},lit(om),lit('å'),!,_7383,{}],_7320,_7322) --> 
    {user:testmember(_7240,[ask])},
    cc(om,_7320,_7366),
    cc('å',_7366,_7377),
    !,
    pushstack(first,npgap(_7241),nil,_7377,_7426),clausal_object1(_7269,_7246::_7247,_7383,_7426,_7322),
    {user:verb_compl(_7240,regarding,_7241,_7269,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},_7367,_7411,lit('å'),!,_7471,{}],_7331,_7333) --> 
    {user:testmember(_7240,[extend,help])},
    optional([til],_7367,_7331,_7399),
    optional([med],_7411,_7399,_7443),
    cc('å',_7443,_7465),
    !,
    pushstack(first,npgap(_7241),nil,_7465,_7514),clausal_object1(_7272,_7246::_7247,_7471,_7514,_7333),
    {user:verb_compl(_7240,with,_7241,_7272,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,_7322,!,{}],_7296,_7298) --> 
    xadverbial1(_7258,_7260,_7246::_7247,_7322,_7296,_7298),
    !,
    {user:verb_compl(_7240,_7258,_7241,_7260,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},_7354,!,_7388,_7412,{}],_7318,_7320) --> 
    {user:testmember(_7240,[talk,speak])},
    look_ahead([om],_7354,_7318,_7371),
    !,
    accept(_7388,_7371,_7403),
    adverbial1(regarding,_7269,_7246::_7247,_7412,_7403,_7320),
    {user:verb_compl(_7240,regarding,_7241,_7269,_7242,_7243)}.

verb_mod1(adj/_7253/_7250,_7241,_7242,_7243,_7246::_7247,[verb_mod1,_7325,{}],_7299,_7301) --> 
    adverbial4(_7261,_7263,_7246::_7247,_7325,_7299,_7301),
    {user:adj_compl(_7250,_7261,_7241,_7263,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},_7347,{}],_7311,_7313) --> 
    {user:(\+testmember(_7240,[know,know1,speak,hope]))},
    adverbial3(_7258,_7260,_7246::_7247,_7347,_7311,_7313),
    {user:verb_compl(_7240,_7258,_7241,_7260,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},_7362,!,_7396,_7420,{}],_7326,_7328) --> 
    {user:testmember(_7240,[know,know1,ask,tell,speak,think])},
    look_ahead([om],_7362,_7326,_7379),
    !,
    accept(_7396,_7379,_7411),
    adverbial1(regarding,_7269,_7246::_7247,_7420,_7411,_7328),
    {user:verb_compl(_7240,regarding,_7241,_7269,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,srel/_7259/time/_7253/_7242,_7246::_7246,[verb_mod1,_7366,{},_7405,{},{},!,_7459],_7340,_7342) --> 
    w(prep(_7259),_7366,_7340,_7383),
    {user:testmember(_7259,[to,until])},
    w(adv(_7253),_7405,_7383,_7422),
    {user:testmember(_7253,[tomorrow])},
    {user:verb_compl(_7240,_7259,_7241,_7312:time,_7242,_7310)},
    !,
    accept(_7459,_7422,_7342).

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7246,[verb_mod1,_7315,{}],_7289,_7291) --> 
    xadverb(_7255,_7257,_7315,_7289,_7291),
    {user:adv_compl(_7240,_7255,_7241,_7257,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,_7319,{}],_7293,_7295) --> 
    adverbix(_7255,_7257,_7246::_7247,_7319,_7293,_7295),
    {user:verb_compl(_7240,_7255,_7241,_7257,_7242,_7243)}.

verb_mod1(_7240,_7241,_7242,_7243,_7246::_7247,[verb_mod1,{},_7390,_7419,{},{},!,_7483],_7354,_7356) --> 
    {user:(\+testmember(_7240,[go]))},
    nil_compl(_7240,_7390,_7354,_7407),
    adjunct1(nil,_7279,_7246::_7247,_7419,_7407,_7440),
    {user:(constrain(_7279,time);constrain(_7279,departure);constrain(_7279,arrival);constrain(_7279,route);constrain(_7279,number);constrain(_7279,bus))},
    {user:verb_compl(_7240,nil,_7241,_7279,_7242,_7243)},
    !,
    accept(_7483,_7440,_7356).

dir_compl(_7240,[dir_compl,{},!,_7301],_7272,_7274) --> 
    {user:v_compl(_7240,_7251,dir,_7253)},
    !,
    accept(_7301,_7272,_7274).

nil_compl(_7240,[nil_compl,_7288,_7322,!],_7274,_7276) --> 
    gmem(_7240,[have],_7288,_7274,_7307),
    look_ahead_lit([hver],_7322,_7307,_7276),
    !.

nil_compl(be/_7243,[nil_compl,{},!,_7304],_7275,_7277) --> 
    {user:a_compl(_7243,_7254,nil,_7256)},
    !,
    accept(_7304,_7275,_7277).

nil_compl(adj/nil/_7243,[nil_compl,{},!],_7275,_7275) --> 
    {user:(\+testmember(_7243,[]))},
    !.

nil_compl(adj/nil/_7243,[nil_compl,{},!,_7306],_7277,_7279) --> 
    {user:(\+post_adjective(_7243))},
    !,
    reject(_7306,_7277,_7279).

nil_compl(go,[nil_compl,_7495,{},_7534,_7563,_7592,_7621,_7650,_7679,_7708,_7737,_7766,_7795,_7824,_7853,_7882,_7911,_7940,_7969,_7998,_8027,_8056,_8085,_8114,!,_8148],_7481,_7483) --> 
    w(nb(_7316,num),_7495,_7481,_7512),
    {user:_7316<100},
    not_look_ahead(w(noun(time_count,plu,u,n)),_7534,_7512,_7551),
    not_look_ahead(w(nb(_7337,num)),_7563,_7551,_7580),
    not_look_ahead([:],_7592,_7580,_7609),
    not_look_ahead([?],_7621,_7609,_7638),
    not_look_ahead(['.'],_7650,_7638,_7667),
    not_look_ahead([/],_7679,_7667,_7696),
    not_look_ahead([den],_7708,_7696,_7725),
    not_look_ahead(w(name(_7364,_7365,month)),_7737,_7725,_7754),
    not_look_ahead(w(name(new_years_day,_7373,date)),_7766,_7754,_7783),
    not_look_ahead(w(name(whitsun_day,_7381,date)),_7795,_7783,_7812),
    not_look_ahead(w(name(christmas_day,_7389,date)),_7824,_7812,_7841),
    not_look_ahead(w(name(easterday,_7397,date)),_7853,_7841,_7870),
    not_look_ahead(w(prep(_7404)),_7882,_7870,_7899),
    not_look_ahead(w(prep(over)),_7911,_7899,_7928),
    not_look_ahead(w(prep(on)),_7940,_7928,_7957),
    not_look_ahead(w(prep(in)),_7969,_7957,_7986),
    not_look_ahead(w(noun(day,_7429,_7430,_7431)),_7998,_7986,_8015),
    not_look_ahead(w(noun(hour,_7438,_7439,_7440)),_8027,_8015,_8044),
    not_look_ahead(w(noun(minute,_7447,_7448,_7449)),_8056,_8044,_8073),
    not_look_ahead(w(noun(second,_7456,_7457,_7458)),_8085,_8073,_8102),
    not_look_ahead([om],_8114,_8102,_8131),
    !,
    reject(_8148,_8131,_7483).

nil_compl(_7240,[nil_compl,{},{},{},_7343,!,_7372],_7299,_7301) --> 
    {user:(\+abnormalverb(_7240,_7262))},
    {user:(\+testmember(_7240,[have,be_named]))},
    {user:v_compl(_7240,_7278,nil,_7280)},
    hver0(_7343,_7299,_7358),
    !,
    accept(_7372,_7358,_7301).

verb_modifier3(_7240,_7241,_7242,_7243,_7244,[verb_modifier3,_7337,_7468],_7311,_7313) --> 
    pushstack(free,(npgap(_7241),lexv(iv,_7240,pres,fin),prep(in),w(noun(time,sin,u,n))),nil,_7311,_7443),statreal(_7253,_7337,_7443,_7456),
    determiner00(_7242,_7243,_7253::_7244,_7468,_7456,_7313).

adverbix0(_7240,_7241,_7242,[adverbix0,_7292,!],_7272,_7274) --> 
    adverbix(_7240,_7241,_7242,_7292,_7272,_7274),
    !.

adverbix0(redundantly,nil:thing,_7244::_7244,[adverbix0,[]],_7271,_7271) --> 
    [].

adverbix(_7240,nil:_7248,_7244::_7244,[adverbix,_7304,{}],_7284,_7286) --> 
    w(adv(_7240),_7304,_7284,_7286),
    {user:particle(_7240,_7248,_7257)}.

adverbix(redundantly,nil:thing,_7244::_7244,[adverbix,_7298,!],_7278,_7280) --> 
    w(adv(redundantly),_7298,_7278,_7280),
    !.

adverbix(_7240,_7241,_7244::_7245,[adverbix,_7295],_7275,_7277) --> 
    adverbial1(_7240,_7241,_7244::_7245,_7295,_7275,_7277).

adverbix(_7240,nil:_7248,_7244::_7244,[adverbix,_7300,_7329],_7280,_7282) --> 
    gradverbs0(_7257,_7300,_7280,_7317),
    adverbx(_7240,_7248,_7255,_7329,_7317,_7282).

adverbix(nil,_7241,_7242,[adverbix,_7308,_7337,_7371],_7288,_7290) --> 
    look_ahead(w(noun(_7257,sin,u,n)),_7308,_7288,_7325),
    gmem(_7257,[midnight],_7337,_7325,_7356),
    complement_nil(_7241,_7242,_7371,_7356,_7290).

adverbix(nil,_7241,_7242,[adverbix,lit(den),_7314,_7343],_7283,_7285) --> 
    cc(den,_7283,_7313),
    look_ahead(w(nb(_7259,_7260)),_7314,_7313,_7331),
    complement_nil(_7241,_7242,_7343,_7331,_7285).

adverbial(_7240,_7241,_7244::_7245,[adverbial,_7295],_7275,_7277) --> 
    adverbial3(_7240,_7241,_7244::_7245,_7295,_7275,_7277).

adverbial(_7240,_7241,_7244::_7245,[adverbial,_7295],_7275,_7277) --> 
    adverbial1(_7240,_7241,_7244::_7245,_7295,_7275,_7277).

preadverbial0(_7240,_7241,_7242,[preadverbial0,_7292,!],_7272,_7274) --> 
    adverbial1(_7240,_7241,_7242,_7292,_7272,_7274),
    !.

preadverbial0(redundantly,nil:thing,_7244::_7244,[preadverbial0,[]],_7271,_7271) --> 
    [].

preadverbial1(_7240,_7241,_7242,[preadverbial1,_7331,_7360,_7389,{},_7428,!],_7311,_7313) --> 
    w(nb(_7261,num),_7331,_7311,_7348),
    w(noun(minute,_7267,_7268,_7269),_7360,_7348,_7377),
    look_ahead(w(prep(_7275)),_7389,_7377,_7406),
    {user:testmember(_7275,[before,after])},
    adverbial1(_7240,_7241,_7242,_7428,_7406,_7313),
    !.

preadverbial1(_7240,_7241,_7242,[preadverbial1,_7299,_7328,_7352],_7279,_7281) --> 
    not_look_ahead([e],_7299,_7279,_7316),
    not_look_ahead_np(_7328,_7316,_7343),
    adverbix(_7240,_7241,_7242,_7352,_7343,_7281).

preadverbial1(nil,_7241,_7242,[preadverbial1,_7313,!,_7347,_7371],_7293,_7295) --> 
    w(adj2(early,nil),_7313,_7293,_7330),
    !,
    accept(_7347,_7330,_7362),
    pushstack(first,w(noun(morning,sin,u,n)),nil,_7362,_7381),
    adjunct1(nil,_7241,_7242,_7371,_7381,_7295).

preadverbial1(before,1200:clock,_7244::_7244 and 1200 isa clock,[preadverbial1,_7304],_7284,_7286) --> 
    w(noun(morning,sin,u,n),_7304,_7284,_7286).

preadverbial1(before,1200:clock,_7244::_7244 and 1200 isa clock,[preadverbial1,_7304],_7284,_7286) --> 
    w(noun(prenoon,sin,u,n),_7304,_7284,_7286).

preadverbial1(after,1200:clock,_7244::_7244 and 1200 isa clock,[preadverbial1,_7304],_7284,_7286) --> 
    w(noun(afternoon,sin,u,n),_7304,_7284,_7286).

preadverbial1(after,1800:clock,_7244::_7244 and 1800 isa clock,[preadverbial1,_7304],_7284,_7286) --> 
    w(noun(night,sin,u,n),_7304,_7284,_7286).

preadverbial1(nil,_7241,_7242,[preadverbial1,_7294,!,_7333],_7274,_7276) --> 
    obviousclock1(_7241,_7242,_7294,_7274,_7313),
    !,
    accept(_7333,_7313,_7276).

preadverbial1(nil,_7241,_7242,[preadverbial1,_7294,!,_7333],_7274,_7276) --> 
    obviousdate1(_7241,_7242,_7294,_7274,_7313),
    !,
    accept(_7333,_7313,_7276).

preadverbials([preadverbials,_7272,!,_7301],_7261,_7263) --> 
    redundant(_7272,_7261,_7287),
    !,
    preadverbials(_7301,_7287,_7263).

preadverbials([preadverbials,_7289,!,[],_7379,_7403],_7278,_7280) --> 
    adverbix(_7252,_7253,_7254,_7289,_7278,_7310),
    !,
    pushstack(free,xadverbial1(_7252,_7253,_7254),nil,_7310,_7378),[],
    adverbial_conjunction0(_7379,_7378,_7394),
    preadverbials0(_7403,_7394,_7280).

preadverbials0([preadverbials0,_7269,!],_7258,_7260) --> 
    preadverbials(_7269,_7258,_7260),
    !.

preadverbials0([preadverbials0,[]],_7255,_7255) --> 
    [].

adverbial_conjunction0([adverbial_conjunction0,_7269,!],_7258,_7260) --> 
    adverbial_conjunction(_7269,_7258,_7260),
    !.

adverbial_conjunction0([adverbial_conjunction0,[]],_7255,_7255) --> 
    [].

adverbial_conjunction([adverbial_conjunction,lit(og),_7291,!],_7269,_7271) --> 
    cc(og,_7269,_7290),
    look_ahead(w(prep(_7252)),_7291,_7290,_7271),
    !.

adverbial1(_7240,_7241,_7242,[adverbial1,lit(slik),!,_7335],_7299,_7301) --> 
    cc(slik,_7299,_7329),
    !,
    pushstack(first,(w(prep(in)),w(noun(way,sin,def,n)),[som]),nil,_7329,_7345),
    adjunct1(_7240,_7241,_7242,_7335,_7345,_7301).

adverbial1(_7240,_7241,_7242,[adverbial1,lit(dit),_7345,!,_7384],_7314,_7316) --> 
    cc(dit,_7314,_7344),
    lit_of(_7264,[jeg,du],_7345,_7344,_7364),
    !,
    pushstack(first,(w(prep(to)),w(noun(place,sin,def,n)),[som],[_7264]),nil,_7364,_7394),
    adjunct1(_7240,_7241,_7242,_7384,_7394,_7316).

adverbial1(ago,_7241,_7242,[adverbial1,_7331,_7360,_7389,lit(siden),!,_7434],_7311,_7313) --> 
    prep1(for,_7331,_7311,_7348),
    anumber(_7274,_7360,_7348,_7377),
    w(noun(_7267,_7279,u,n),_7389,_7377,_7406),
    cc(siden,_7406,_7428),
    !,
    lock(exact,_7428,_7481),
    pushstack(exact,(number(_7274),w(noun(_7267,plu,u,n))),nil,_7481,_7487),
    np1(_7241,_7242,_7434,_7487,_7476),
    unlock(_7476,_7313).

adverbial1(in,_7253:day,_7244::exists(_7253:morrow)::_7253 isa morrow and _7244,[adverbial1,_7311,!,_7340],_7291,_7293) --> 
    tomorrow(_7311,_7291,_7326),
    !,
    accept(_7340,_7326,_7293).

adverbial1(_7240,_7241,_7242,[adverbial1,_7289],_7269,_7271) --> 
    adjunct1(_7240,_7241,_7242,_7289,_7269,_7271).

adverbial1(in,_7253:_7254,_7244::exists(_7253:_7254)::_7253 isa _7254 and _7244,[adverbial1,_7340,{},!,_7384],_7320,_7322) --> 
    w(noun(_7254,_7276,_7277,n),_7340,_7320,_7357),
    {user:testmember(_7254,[monday,tuesday,wednesday,thursday,friday,saturday,sunday])},
    !,
    accept(_7384,_7357,_7322).

adverbial3(_7240,_7247:_7248,_7244::_7245,[adverbial3,_7343,_7382,[],_7461,_7527],_7323,_7325) --> 
    xsubjunction(_7240,_7248,_7271,_7343,_7323,_7364),
    adverbial_object00(_7247:_7248,_7274,_7382,_7364,_7401),
    pushstack(free,adverbial1(_7271,_7247:_7248,_7274),nil,_7401,_7460),[],
    pushstack(first,([jeg],aux1),nil,_7460,_7502),substatement1(_7266,_7461,_7502,_7515),
    determiner00(_7247:_7248,_7244,_7266::_7245,_7527,_7515,_7325).

adverbial3(_7240,_7241,_7242,[adverbial3,lit('før'),_7307,!,_7336],_7276,_7278) --> 
    cc('før',_7276,_7306),
    look_ahead_time(_7307,_7306,_7322),
    !,
    reject(_7336,_7322,_7278).

adverbial3(_7240,_7241,_7244::_7245,[adverbial3,lit(til),_7342,_7371,!,_7405,_7453],_7311,_7313) --> 
    cc(til,_7311,_7341),
    not_look_ahead([j],_7342,_7341,_7359),
    look_ahead([jeg],_7371,_7359,_7388),
    !,
    pushstack(first,w(prep(to)),nil,_7388,_7418),subordinate(_7240,_7241,_7266,_7405,_7418,_7435),
    determiner00(_7241,_7244,_7266::_7245,_7453,_7435,_7313).

adverbial3(_7240,_7241,_7244::_7245,[adverbial3,_7309,_7338,_7377],_7289,_7291) --> 
    not_look_ahead([til],_7309,_7289,_7326),
    subordinate(_7240,_7241,_7257,_7338,_7326,_7359),
    determiner00(_7241,_7244,_7257::_7245,_7377,_7359,_7291).

adverbial4(_7240,_7241,_7244::_7244 and _7248,[adverbial4,_7318,_7347,_7376,{}],_7298,_7300) --> 
    not_look_ahead([om],_7318,_7298,_7335),
    prep(_7262,_7347,_7335,_7364),
    clausal_object0(_7241,true::_7248,_7376,_7364,_7300),
    {user:adjustprep(_7241,_7262,_7240)}.

adverbial4(_7240,_7241,_7244::_7244 and _7248,[adverbial4,_7323,_7352,lit(at),_7392,{}],_7303,_7305) --> 
    not_look_ahead([om],_7323,_7303,_7340),
    prep(_7265,_7352,_7340,_7369),
    cc(at,_7369,_7391),
    clausal_object1(_7241,true::_7248,_7392,_7391,_7305),
    {user:adjustprep(_7241,_7265,_7240)}.

subordinate(nil,_7244:coevent,_7242,[subordinate,lit(de),lit(samme),lit(som),_7371,_7405],_7318,_7320) --> 
    cc(de,_7318,_7348),
    cc(samme,_7348,_7359),
    cc(som,_7359,_7370),
    adverbial_object00(_7244:coevent,_7270,_7371,_7370,_7390),
    lock(last,_7390,_7453),
    pushstack(last,([de],w(verb(be,pres,fin)),adverbial1(nil,_7244:coevent,_7270)),nil,_7453,_7459),
    substatement1(_7242,_7405,_7459,_7448),
    unlock(_7448,_7320).

subordinate(_7240,_7241,_7242,[subordinate,_7314,{},_7353,!,_7387],_7294,_7296) --> 
    w(prep(_7258),_7314,_7294,_7331),
    {user:testmember(_7258,[instead_of])},
    not_look_ahead_lit([at,'å'],_7353,_7331,_7370),
    !,
    reject(_7387,_7370,_7296).

subordinate(_7240,_7241,_7242,[subordinate,_7322,_7351,_7380,{},!,_7424],_7302,_7304) --> 
    not_look_ahead([siden],_7322,_7302,_7339),
    w(prep(_7265),_7351,_7339,_7368),
    look_ahead(w(noun(_7271,_7272,_7273,_7274)),_7380,_7368,_7397),
    {user:subclass0(_7271,time)},
    !,
    reject(_7424,_7397,_7304).

subordinate(_7240,_7241,_7242,[subordinate,_7308,_7347,_7376],_7288,_7290) --> 
    subjunction(_7240,_7251,_7250,_7308,_7288,_7329),
    not_look_ahead(w(verb(_7263,_7264,_7265)),_7347,_7329,_7364),
    subord_clause(_7250,_7251,_7241,_7242,_7376,_7364,_7290).

subord_clause(_7240,_7241,_7245:_7241,_7243,[subord_clause,_7318,!,_7357],_7295,_7297) --> 
    adverbial_object00(_7245:_7241,_7259,_7318,_7295,_7337),
    !,
    lock(last,_7337,_7405),
    pushstack(last,xadverbial1(_7240,_7245:_7241,_7259),nil,_7405,_7411),
    substatement1(_7243,_7357,_7411,_7400),
    unlock(_7400,_7297).

adverbial_object00(_7252:_7253,_7243::exists(_7252:_7253)::_7252 isa _7253 and _7243,[adverbial_object00,[]],_7282,_7282) --> 
    [].

subordinateinfnosubj(_7240,_7241,_7242,_7243,_7244,[subordinateinfnosubj,{},_7344,!,_7388],_7308,_7310) --> 
    {user:it_template(_7242)},
    np00(_7241,_7262,_7265::_7266,_7344,_7308,_7365),
    !,
    pushstack(free,(npgap(_7242),adverbial1(_7240,_7262,_7265::_7266)),nil,_7365,_7463),
    statreal(_7244,_7388,_7463,_7310).

subordinateinfnosubj(_7240,_7241,_7242,_7243,_7244,[subordinateinfnosubj,{},_7379,{},!,_7438,!,_7482],_7343,_7345) --> 
    {user:(\+it_template(_7242))},
    lexv(tv,_7290,_7291,fin,_7379,_7343,_7402),
    {user:testmember(_7290,[take])},
    !,
    np00(_7241,_7277,_7280::_7281,_7438,_7402,_7459),
    !,
    pushstack(free,(someone,w(verb(_7290,pres,fin)),npgap(_7242),adverbial1(_7240,_7277,_7280::_7281)),nil,_7459,_7585),
    statreal(_7244,_7482,_7585,_7345).

subordinateinfnosubj(_7240,_7241,_7242,_7243,_7244,[subordinateinfnosubj,{},_7379,{},!,_7438,!,_7482],_7343,_7345) --> 
    {user:(\+it_template(_7242))},
    lexv(tv,_7290,_7291,fin,_7379,_7343,_7402),
    {user:testmember(_7290,[help])},
    !,
    np00(_7241,_7277,_7280::_7281,_7438,_7402,_7459),
    !,
    pushstack(free,(npgap(_7242),w(verb(_7290,pres,fin)),someone,adverbial1(_7240,_7277,_7280::_7281)),nil,_7459,_7585),
    statreal(_7244,_7482,_7585,_7345).

partday(_7240,_7241,_7242,[partday,_7304,{},!],_7284,_7286) --> 
    w(noun(_7240,_7253,_7254,n),_7304,_7284,_7286),
    {user:particle(_7240,_7241,_7242)},
    !.

partday(tomorrow,_7241,_7242,[partday,_7319,_7343,_7372,_7401,!,{}],_7299,_7301) --> 
    to0(_7319,_7299,_7334),
    prep1(in,_7343,_7334,_7360),
    not_look_ahead([formiddag],_7372,_7360,_7389),
    w(noun(morning,_7274,_7275,n),_7401,_7389,_7301),
    !,
    {user:particle(tomorrow,_7241,_7242)}.

partday(tomorrow,_7241,_7242,[partday,_7312,_7336,_7365,!,{}],_7292,_7294) --> 
    to0(_7312,_7292,_7327),
    prep1(in,_7336,_7327,_7353),
    w(noun(morrow,_7267,_7268,n),_7365,_7353,_7294),
    !,
    {user:particle(tomorrow,_7241,_7242)}.

partday(_7240,_7241,_7242,[partday,_7318,_7347,!,{},{}],_7298,_7300) --> 
    inom(_7262,_7318,_7298,_7335),
    w(noun(_7266,_7267,_7268,n),_7347,_7335,_7300),
    !,
    {user:norpart(_7262,_7266,_7240)},
    {user:particle(_7240,_7241,_7242)}.

adverbx(with,mode,post,[adverbx,lit(med),_7304,!],_7273,_7275) --> 
    cc(med,_7273,_7303),
    not_look_ahead_np(_7304,_7303,_7275),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),_7304,!],_7273,_7275) --> 
    cc(etter,_7273,_7303),
    terminatore(_7304,_7303,_7275),
    !.

adverbx(thereafter,time,post,[adverbx,lit(etter),lit(det),!],_7275,_7277) --> 
    cc(etter,_7275,_7305),
    cc(det,_7305,_7277),
    !.

adverbx(earlier,time,post,[adverbx,lit('før'),lit(det),!],_7275,_7277) --> 
    cc('før',_7275,_7305),
    cc(det,_7305,_7277),
    !.

adverbx(_7240,_7241,_7242,[adverbx,lit(slik),lit(at),!,_7325],_7278,_7280) --> 
    cc(slik,_7278,_7308),
    cc(at,_7308,_7319),
    !,
    reject(_7325,_7319,_7280).

adverbx(_7240,_7241,_7242,[adverbx,_7304,_7328,!,{}],_7284,_7286) --> 
    not_look_ahead_prepx(_7304,_7284,_7319),
    w(adv(_7240),_7328,_7319,_7286),
    !,
    {user:particle(_7240,_7241,_7242)}.

not_look_ahead_prepx([not_look_ahead_prepx,lit(med),_7285,!],_7263,_7265) --> 
    cc(med,_7263,_7284),
    look_ahead_np(_7285,_7284,_7265),
    !.

not_look_ahead_prepx([not_look_ahead_prepx,_7272],_7261,_7263) --> 
    not_look_ahead(w(prep(_7244)),_7272,_7261,_7263).

adverbx(_7240,_7241,_7242,[adverbx,_7289],_7269,_7271) --> 
    adverb(_7240,_7241,_7242,_7289,_7269,_7271).

adverbx(_7240,_7241,_7242,[adverbx,_7289],_7269,_7271) --> 
    partday(_7240,_7241,_7242,_7289,_7269,_7271).

adverbx(yesterday,_7241,_7242,[adverbx,_7304,lit('går'),!,{}],_7284,_7286) --> 
    prep1(in,_7304,_7284,_7321),
    cc('går',_7321,_7286),
    !,
    {user:particle(yesterday,_7241,_7242)}.

anyadverb0([anyadverb0,_7286,_7310,!,[]],_7275,_7277) --> 
    therenot0(_7286,_7275,_7301),
    adverb(_7252,_7253,_7254,_7310,_7301,_7331),
    !,
    pushstack(free,adverb(_7252,_7253,_7254),nil,_7331,_7277),
    [].

anyadverb0([anyadverb0,_7266],_7255,_7257) --> 
    therenot0(_7266,_7255,_7257).

adverbx0([adverbx0,_7273,!],_7262,_7264) --> 
    w(adv(redundantly),_7273,_7262,_7264),
    !.

adverbx0([adverbx0,_7316,_7345,_7374,{},!,[]],_7305,_7307) --> 
    not_look_ahead(w(noun(_7266,sin,u,n)),_7316,_7305,_7333),
    not_look_ahead(w(prep(_7275)),_7345,_7333,_7362),
    adverb(_7258,_7259,_7260,_7374,_7362,_7395),
    {user:(\+testmember(_7258,[home]))},
    !,
    pushstack(free,adverb(_7258,_7259,_7260),nil,_7395,_7307),
    [].

adverbx0([adverbx0,[]],_7255,_7255) --> 
    [].

adverb0(_7240,_7241,_7242,[adverb0,_7292,!],_7272,_7274) --> 
    adverb(_7240,_7241,_7242,_7292,_7272,_7274),
    !.

adverb0(redundantly,thing,post,[adverb0,[]],_7265,_7265) --> 
    [].

adverb(delayed,time,post,[adverb,_7293,!],_7273,_7275) --> 
    w(adj2(delayed,nil),_7293,_7273,_7275),
    !.

adverb(_7240,_7241,_7242,[adverb,_7311,_7340,_7369,{}],_7291,_7293) --> 
    gradverb0(_7259,_7311,_7291,_7328),
    not_look_ahead([siste],_7340,_7328,_7357),
    w(adj2(_7240,nil),_7369,_7357,_7293),
    {user:particle(_7240,_7241,_7242)}.

adverb(now,_7241,_7242,[adverb,_7299,_7328,{}],_7279,_7281) --> 
    prep1(with,_7299,_7279,_7316),
    detsamme(_7328,_7316,_7281),
    {user:particle(now,_7241,_7242)}.

adverb(first,time,_7242,[adverb,lit('først')],_7267,_7269) --> 
    cc('først',_7267,_7269).

adverb(today,day,pre,[adverb,_7297,_7326],_7277,_7279) --> 
    prep1(in,_7297,_7277,_7314),
    w(noun(day,sin,u,n),_7326,_7314,_7279).

adverb(tomorrow,day,pre,[adverb,_7292,lit(morgen)],_7272,_7274) --> 
    prep1(in,_7292,_7272,_7309),
    cc(morgen,_7309,_7274).

adverb(day_after_tomorrow,day,pre,[adverb,_7292,lit(overimorgen)],_7272,_7274) --> 
    prep1(in,_7292,_7272,_7309),
    cc(overimorgen,_7309,_7274).

adverb(day_before_yesterday,day,pre,[adverb,_7292,lit('forgårs')],_7272,_7274) --> 
    prep1(in,_7292,_7272,_7309),
    cc('forgårs',_7309,_7274).

adverb(tonight,daypart,pre,[adverb,_7297,_7326],_7277,_7279) --> 
    prep1(in,_7297,_7277,_7314),
    w(noun(night,_7250,_7251,_7252),_7326,_7314,_7279).

adverb(today,day,pre,[adverb,_7297,_7326],_7277,_7279) --> 
    prep1(in,_7297,_7277,_7314),
    w(noun(day,_7250,_7251,_7252),_7326,_7314,_7279).

adverb(locally,place,post,[adverb,lit(lokalt)],_7267,_7269) --> 
    cc(lokalt,_7267,_7269).

adverb(_7240,_7241,_7242,[adverb,_7298,_7327,!,_7356],_7278,_7280) --> 
    w(prep(_7255),_7298,_7278,_7315),
    look_ahead_np(_7327,_7315,_7342),
    !,
    reject(_7356,_7342,_7280).

adverb(_7240,_7241,_7242,[adverb,_7296,{}],_7276,_7278) --> 
    particle(_7240,_7296,_7276,_7278),
    {user:particle(_7240,_7241,_7242)}.

adverb(_7240,_7241,_7242,[adverb,_7334,{},_7373,_7402,{},_7441],_7314,_7316) --> 
    particle(_7240,_7334,_7314,_7351),
    {user:testmember(_7240,[on,off])},
    not_look_ahead(w(noun(_7274,_7275,_7276,_7277)),_7373,_7351,_7390),
    not_look_ahead(w(name(_7283,_7284,_7285)),_7402,_7390,_7419),
    {user:particle(_7240,_7241,_7242)},
    da0(_7441,_7419,_7316).

particlev0(_7240,_7241,[particlev0,_7285,!],_7268,_7270) --> 
    particlev2(_7240,_7241,_7285,_7268,_7270),
    !.

particlev0(_7240,_7240,[particlev0,_7281],_7264,_7266) --> 
    particlev1(_7240,_7281,_7264,_7266).

particlev0(_7240,_7240,[particlev0,[]],_7262,_7262) --> 
    [].

particle0(_7240,[particle0,_7278,!],_7264,_7266) --> 
    particle(_7240,_7278,_7264,_7266),
    !.

particle0(_7240,[particle0,[]],_7259,_7259) --> 
    [].

particlev1(believe,[particlev1,lit('på')],_7261,_7263) --> 
    cc('på',_7261,_7263).

particlev1(calculate,[particlev1,lit(med)],_7261,_7263) --> 
    cc(med,_7261,_7263).

particlev1(check,[particlev1,lit(opp)],_7261,_7263) --> 
    cc(opp,_7261,_7263).

particlev1(come,[particlev1,lit(med),_7289],_7264,_7266) --> 
    cc(med,_7264,_7288),
    not_look_ahead_np(_7289,_7288,_7266).

particlev1(come,[particlev1,lit(til),_7289],_7264,_7266) --> 
    cc(til,_7264,_7288),
    not_look_ahead_np(_7289,_7288,_7266).

particlev1(come,[particlev1,lit(opp)],_7261,_7263) --> 
    cc(opp,_7261,_7263).

particlev1(correct,[particlev1,lit(opp)],_7261,_7263) --> 
    cc(opp,_7261,_7263).

particlev1(fetch,[particlev1,lit(ned)],_7261,_7263) --> 
    cc(ned,_7261,_7263).

particlev1(fetch,[particlev1,lit(opp)],_7261,_7263) --> 
    cc(opp,_7261,_7263).

particlev1(find,[particlev1,lit(ut),lit(av)],_7266,_7268) --> 
    cc(ut,_7266,_7290),
    cc(av,_7290,_7268).

particlev1(get,[particlev1,lit(med)],_7261,_7263) --> 
    cc(med,_7261,_7263).

particlev1(get,[particlev1,lit(opp)],_7261,_7263) --> 
    cc(opp,_7261,_7263).

particlev1(have,[particlev1,lit('på')],_7261,_7263) --> 
    cc('på',_7261,_7263).

particlev1(help,[particlev1,lit(til),lit(med)],_7266,_7268) --> 
    cc(til,_7266,_7290),
    cc(med,_7290,_7268).

particlev1(help,[particlev1,lit(til)],_7261,_7263) --> 
    cc(til,_7261,_7263).

particlev1(improve,[particlev1,lit(inn)],_7261,_7263) --> 
    cc(inn,_7261,_7263).

particlev1(indicte,[particlev1,lit('på')],_7261,_7263) --> 
    cc('på',_7261,_7263).

particlev1(lay,[particlev1,lit(inn)],_7261,_7263) --> 
    cc(inn,_7261,_7263).

particlev1(lie1,[particlev1,lit(med)],_7261,_7263) --> 
    cc(med,_7261,_7263).

particlev1(name,[particlev1,lit(til)],_7261,_7263) --> 
    cc(til,_7261,_7263).

particlev1(reach,[particlev1,lit(til)],_7261,_7263) --> 
    cc(til,_7261,_7263).

particlev1(reach,[particlev1,lit(fram),lit(til)],_7266,_7268) --> 
    cc(fram,_7266,_7290),
    cc(til,_7290,_7268).

particlev1(read,[particlev1,lit(gjennom)],_7261,_7263) --> 
    cc(gjennom,_7261,_7263).

particlev1(receive,[particlev1,lit(opp)],_7261,_7263) --> 
    cc(opp,_7261,_7263).

particlev1(get,[particlev1,lit(opp)],_7261,_7263) --> 
    cc(opp,_7261,_7263).

particlev1(send,[particlev1,lit(med)],_7261,_7263) --> 
    cc(med,_7261,_7263).

particlev1(send,[particlev1,lit(over)],_7261,_7263) --> 
    cc(over,_7261,_7263).

particlev1(send,[particlev1,lit(ved)],_7261,_7263) --> 
    cc(ved,_7261,_7263).

particlev1(sing,[particlev1,lit(ut)],_7261,_7263) --> 
    cc(ut,_7261,_7263).

particlev1(take,[particlev1,lit(ut)],_7261,_7263) --> 
    cc(ut,_7261,_7263).

particlev1(throw,[particlev1,lit(av)],_7261,_7263) --> 
    cc(av,_7261,_7263).

particlev1(tell,[particlev1,lit(inn)],_7261,_7263) --> 
    cc(inn,_7261,_7263).

particlev1(tell,[particlev1,lit(om)],_7261,_7263) --> 
    cc(om,_7261,_7263).

particlev1(tell,[particlev1,lit(fra),lit(om),!],_7269,_7271) --> 
    cc(fra,_7269,_7293),
    cc(om,_7293,_7271),
    !.

particlev1(tell,[particlev1,lit(fra)],_7261,_7263) --> 
    cc(fra,_7261,_7263).

particlev1(tell,[particlev1,lit(ifra)],_7261,_7263) --> 
    cc(ifra,_7261,_7263).

particlev1(tell,[particlev1,_7277],_7263,_7265) --> 
    w(prep(regarding),_7277,_7263,_7265).

particlev1(wonder,[particlev1,lit('på')],_7261,_7263) --> 
    cc('på',_7261,_7263).

particlev1(write,[particlev1,lit(inn)],_7261,_7263) --> 
    cc(inn,_7261,_7263).

particlev2(avoid,release,[particlev2,lit(fri)],_7264,_7266) --> 
    cc(fri,_7264,_7266).

particlev2(be,come,[particlev2,lit(med)],_7264,_7266) --> 
    cc(med,_7264,_7266).

particlev2(belong,belong_to,[particlev2,lit(til)],_7264,_7266) --> 
    cc(til,_7264,_7266).

particlev2(hear,belong_to,[particlev2,lit(til)],_7264,_7266) --> 
    cc(til,_7264,_7266).

particlev2(calculate,expect,[particlev2,lit(med)],_7264,_7266) --> 
    cc(med,_7264,_7266).

particlev2(care1,ensure,[particlev2,lit(for)],_7264,_7266) --> 
    cc(for,_7264,_7266).

particlev2(come,appear,[particlev2,lit(fram)],_7264,_7266) --> 
    cc(fram,_7264,_7266).

particlev2(come,disappear,[particlev2,lit(bort),_7301],_7273,_7275) --> 
    cc(bort,_7273,_7300),
    not_look_ahead(w(prep(to)),_7301,_7300,_7275).

particlev2(comment,remove,[particlev2,lit(ut)],_7264,_7266) --> 
    cc(ut,_7264,_7266).

particlev2(do1,finish,[particlev2,lit(ferdig)],_7264,_7266) --> 
    cc(ferdig,_7264,_7266).

particlev2(do1,make,[particlev2,lit(meg)],_7264,_7266) --> 
    cc(meg,_7264,_7266).

particlev2(find,do1,[particlev2,lit('på')],_7264,_7266) --> 
    cc('på',_7264,_7266).

particlev2(find,discover,[particlev2,lit(ut)],_7264,_7266) --> 
    cc(ut,_7264,_7266).

particlev2(fool,wonder,[particlev2,lit('på')],_7264,_7266) --> 
    cc('på',_7264,_7266).

particlev2(go,stop,[particlev2,lit(ned)],_7264,_7266) --> 
    cc(ned,_7264,_7266).

particlev2(get,manage,[particlev2,lit(til)],_7264,_7266) --> 
    cc(til,_7264,_7266).

particlev2(have,bring,[particlev2,lit(med)],_7264,_7266) --> 
    cc(med,_7264,_7266).

particlev2(hold,be,[particlev2,lit(deg)],_7264,_7266) --> 
    cc(deg,_7264,_7266).

particlev2(hold,be,[particlev2,lit(meg)],_7264,_7266) --> 
    cc(meg,_7264,_7266).

particlev2(hold,be,[particlev2,lit(seg)],_7264,_7266) --> 
    cc(seg,_7264,_7266).

particlev2(hold,do1,[particlev2,lit('på'),lit(med)],_7269,_7271) --> 
    cc('på',_7269,_7296),
    cc(med,_7296,_7271).

particlev2(hold,be1,[particlev2,lit(til)],_7264,_7266) --> 
    cc(til,_7264,_7266).

particlev2(hold,wait,[particlev2,lit(ut)],_7264,_7266) --> 
    cc(ut,_7264,_7266).

particlev2(improve,ensure,[particlev2,lit(inn)],_7264,_7266) --> 
    cc(inn,_7264,_7266).

particlev2(lay,include,[particlev2,lit(inn)],_7264,_7266) --> 
    cc(inn,_7264,_7266).

particlev2(lay,include,[particlev2,lit('på')],_7264,_7266) --> 
    cc('på',_7264,_7266).

particlev2(lay,enclose,[particlev2,lit(ved)],_7264,_7266) --> 
    cc(ved,_7264,_7266).

particlev2(lay,stop,[particlev2,lit(ned)],_7264,_7266) --> 
    cc(ned,_7264,_7266).

particlev2(lay,change,[particlev2,lit(om)],_7264,_7266) --> 
    cc(om,_7264,_7266).

particlev2(lead,cause,[particlev2,lit(til)],_7264,_7266) --> 
    cc(til,_7264,_7266).

particlev2(lie1,belong_to,[particlev2,lit(under)],_7264,_7266) --> 
    cc(under,_7264,_7266).

particlev2(list,list,[particlev2,lit(opp)],_7264,_7266) --> 
    cc(opp,_7264,_7266).

particlev2(long,want,[particlev2,lit(etter)],_7264,_7266) --> 
    cc(etter,_7264,_7266).

particlev2(look,appear,[particlev2,lit(ut)],_7264,_7266) --> 
    cc(ut,_7264,_7266).

particlev2(meet,meetup,[particlev2,lit(opp)],_7264,_7266) --> 
    cc(opp,_7264,_7266).

particlev2(negotiate,discuss,[particlev2,lit(om)],_7264,_7266) --> 
    cc(om,_7264,_7266).

particlev2(operate,do1,[particlev2,_7288,lit(med)],_7271,_7273) --> 
    optional(['på'],_7288,_7271,_7320),
    cc(med,_7320,_7273).

particlev2(pay,pay2,[particlev2,lit(seg)],_7264,_7266) --> 
    cc(seg,_7264,_7266).

particlev2(put,arrange,[particlev2,lit(opp)],_7264,_7266) --> 
    cc(opp,_7264,_7266).

particlev2(say,tell,[particlev2,lit(fra)],_7264,_7266) --> 
    cc(fra,_7264,_7266).

particlev2(say,tell,[particlev2,lit(ifra)],_7264,_7266) --> 
    cc(ifra,_7264,_7266).

particlev2(see,appear,[particlev2,lit(ut)],_7264,_7266) --> 
    cc(ut,_7264,_7266).

particlev2(see,appear,[particlev2,lit(ut)],_7264,_7266) --> 
    cc(ut,_7264,_7266).

particlev2(stand,indicate,[particlev2,lit(for)],_7264,_7266) --> 
    cc(for,_7264,_7266).

particlev2(take,bring,[particlev2,lit(med)],_7264,_7266) --> 
    cc(med,_7264,_7266).

particlev2(take,manage,[particlev2,lit(over)],_7264,_7266) --> 
    cc(over,_7264,_7266).

particlev2(take,get,[particlev2,lit(til),_7295],_7267,_7269) --> 
    cc(til,_7267,_7294),
    rfxpron(_7295,_7294,_7269).

particlev2(take,get,[particlev2,lit(mot)],_7264,_7266) --> 
    cc(mot,_7264,_7266).

particlev2(take,get,[particlev2,lit(imot)],_7264,_7266) --> 
    cc(imot,_7264,_7266).

particlev2(take,get,[particlev2,lit(i),lit(mot)],_7269,_7271) --> 
    cc(i,_7269,_7296),
    cc(mot,_7296,_7271).

particlev2(take,treat,[particlev2,lit(opp)],_7264,_7266) --> 
    cc(opp,_7264,_7266).

particlev2(turn,stop,[particlev2,lit(av)],_7264,_7266) --> 
    cc(av,_7264,_7266).

particlev2(turn,start,[particlev2,lit('på')],_7264,_7266) --> 
    cc('på',_7264,_7266).

particlev2(write,print,[particlev2,lit(ut)],_7264,_7266) --> 
    cc(ut,_7264,_7266).

rep_particlev0(_7240,[rep_particlev0,_7278,!],_7264,_7266) --> 
    rep_particlev(_7240,_7278,_7264,_7266),
    !.

rep_particlev0(_7240,[rep_particlev0,[]],_7259,_7259) --> 
    [].

rep_particlev(ask,[rep_particlev,lit(:),!],_7264,_7266) --> 
    cc(:,_7264,_7266),
    !.

rep_particlev(deny,[rep_particlev,lit(for)],_7261,_7263) --> 
    cc(for,_7261,_7263).

rep_particlev(wonder,[rep_particlev,lit('på'),_7295,!,_7324],_7270,_7272) --> 
    cc('på',_7270,_7294),
    which0(_7295,_7294,_7310),
    !,
    accept(_7324,_7310,_7272).

rep_particlev(know,[rep_particlev,_7281,!,_7315],_7267,_7269) --> 
    prep1(to,_7281,_7267,_7298),
    !,
    accept(_7315,_7298,_7269).

rep_particlev(find,[rep_particlev,lit(ut)],_7261,_7263) --> 
    cc(ut,_7261,_7263).

rep_particlev(recognize,[rep_particlev,lit(til)],_7261,_7263) --> 
    cc(til,_7261,_7263).

rep_particlev(think,[rep_particlev,lit('på'),_7299,!,_7333],_7274,_7276) --> 
    cc('på',_7274,_7298),
    not_look_ahead([om],_7299,_7298,_7316),
    !,
    reject(_7333,_7316,_7276).

rep_particlev(think,[rep_particlev,lit('på'),_7299,!,_7333],_7274,_7276) --> 
    cc('på',_7274,_7298),
    not_look_ahead([at],_7299,_7298,_7316),
    !,
    reject(_7333,_7316,_7276).

rep_particlev(think,[rep_particlev,lit('på'),!,_7297],_7267,_7269) --> 
    cc('på',_7267,_7291),
    !,
    accept(_7297,_7291,_7269).

particle(redundantly,[particle,_7273],_7259,_7261) --> 
    redundant(_7273,_7259,_7261).

particle(_7240,[particle,_7280,!],_7266,_7268) --> 
    w(adv(_7240),_7280,_7266,_7268),
    !.

particle(back,[particle,lit(tilbake)],_7261,_7263) --> 
    cc(tilbake,_7261,_7263).

particle(badly,[particle,lit('dårlig')],_7261,_7263) --> 
    cc('dårlig',_7261,_7263).

particle(beforethat,[particle,_7273],_7259,_7261) --> 
    beforethat(_7273,_7259,_7261).

particle(daily,[particle,lit(daglig)],_7261,_7263) --> 
    cc(daglig,_7261,_7263).

particle(day_after_tomorrow,[particle,lit(overimorgen)],_7261,_7263) --> 
    cc(overimorgen,_7261,_7263).

particle(directly,[particle,lit(direkte)],_7261,_7263) --> 
    cc(direkte,_7261,_7263).

particle(down,[particle,lit(ned)],_7261,_7263) --> 
    cc(ned,_7261,_7263).

particle(down,[particle,lit(under)],_7261,_7263) --> 
    cc(under,_7261,_7263).

particle(earlier,[particle,_7273],_7259,_7261) --> 
    earlier(_7273,_7259,_7261).

particle(early,[particle,lit('så'),lit(tidlig),lit(som),_7332,!,_7366],_7285,_7287) --> 
    cc('så',_7285,_7309),
    cc(tidlig,_7309,_7320),
    cc(som,_7320,_7331),
    w(adj2(possible,nil),_7332,_7331,_7349),
    !,
    accept(_7366,_7349,_7287).

particle(early,[particle,lit(tidligst),_7300,!,_7334],_7275,_7277) --> 
    cc(tidligst,_7275,_7299),
    w(adj2(possible,nil),_7300,_7299,_7317),
    !,
    accept(_7334,_7317,_7277).

particle(early,[particle,lit(tidlig)],_7261,_7263) --> 
    cc(tidlig,_7261,_7263).

particle(early,[particle,lit(am)],_7261,_7263) --> 
    cc(am,_7261,_7263).

particle(eastward,[particle,lit('østover')],_7261,_7263) --> 
    cc('østover',_7261,_7263).

particle(everywhere,[particle,lit(overalt)],_7261,_7263) --> 
    cc(overalt,_7261,_7263).

particle(far,[particle,lit(langt)],_7261,_7263) --> 
    cc(langt,_7261,_7263).

particle(fast,[particle,lit(fort)],_7261,_7263) --> 
    cc(fort,_7261,_7263).

particle(fast,[particle,_7278],_7264,_7266) --> 
    w(adj2(fast,comp),_7278,_7264,_7266).

particle(from,[particle,lit(ifra)],_7261,_7263) --> 
    cc(ifra,_7261,_7263).

particle(gratis,[particle,lit(gratis)],_7261,_7263) --> 
    cc(gratis,_7261,_7263).

particle(home,[particle,lit(hjem),_7297,!,_7331],_7272,_7274) --> 
    cc(hjem,_7272,_7296),
    prep1(to,_7297,_7296,_7314),
    !,
    reject(_7331,_7314,_7274).

particle(home,[particle,_7278,lit(hjem)],_7264,_7266) --> 
    to0(_7278,_7264,_7293),
    cc(hjem,_7293,_7266).

particle(here,[particle,_7278,lit(hit)],_7264,_7266) --> 
    to0(_7278,_7264,_7293),
    cc(hit,_7293,_7266).

particle(here,[particle,_7278,lit(her)],_7264,_7266) --> 
    to0(_7278,_7264,_7293),
    cc(her,_7293,_7266).

particle(hereafter,[particle,_7273],_7259,_7261) --> 
    hereafter(_7273,_7259,_7261).

particle(in,[particle,lit(inn)],_7261,_7263) --> 
    cc(inn,_7261,_7263).

particle(in_morning,[particle,lit(ommorgenen)],_7261,_7263) --> 
    cc(ommorgenen,_7261,_7263).

particle(late,[particle,_7278,lit(sent)],_7264,_7266) --> 
    so0(_7278,_7264,_7293),
    cc(sent,_7293,_7266).

particle(late,[particle,_7278,lit(sent)],_7264,_7266) --> 
    too(_7278,_7264,_7293),
    cc(sent,_7293,_7266).

particle(lay,[particle,lit(ut)],_7261,_7263) --> 
    cc(ut,_7261,_7263).

particle(lay,[particle,lit(inn)],_7261,_7263) --> 
    cc(inn,_7261,_7263).

particle(lay,[particle,lit(ved)],_7261,_7263) --> 
    cc(ved,_7261,_7263).

particle(logically,[particle,lit(logisk)],_7261,_7263) --> 
    cc(logisk,_7261,_7263).

particle(much,[particle,_7278,lit(mye)],_7264,_7266) --> 
    so(_7278,_7264,_7293),
    cc(mye,_7293,_7266).

particle(normally,[particle,lit(normalt)],_7261,_7263) --> 
    cc(normalt,_7261,_7263).

particle(northward,[particle,lit(nordover)],_7261,_7263) --> 
    cc(nordover,_7261,_7263).

particle(now,[particle,_7273],_7259,_7261) --> 
    now1(_7273,_7259,_7261).

particle(now,[particle,_7280,lit('øyeblikket')],_7266,_7268) --> 
    prep1(for,_7280,_7266,_7297),
    cc('øyeblikket',_7297,_7268).

particle(on,[particle,_7275],_7261,_7263) --> 
    prep1(on,_7275,_7261,_7263).

particle(off,[particle,lit(av)],_7261,_7263) --> 
    cc(av,_7261,_7263).

particle(offside,[particle,_7276,_7300],_7262,_7264) --> 
    and0(_7276,_7262,_7291),
    compassly(_7300,_7291,_7264).

particle(often,[particle,_7278,lit(ofte)],_7264,_7266) --> 
    so0(_7278,_7264,_7293),
    cc(ofte,_7293,_7266).

particle(recently,[particle,_7273],_7259,_7261) --> 
    recently(_7273,_7259,_7261).

particle(out,[particle,lit(ut)],_7261,_7263) --> 
    cc(ut,_7261,_7263).

particle(past,[particle,lit(forbi)],_7261,_7263) --> 
    cc(forbi,_7261,_7263).

particle(present,[particle,lit(framme)],_7261,_7263) --> 
    cc(framme,_7261,_7263).

particle(punctually,[particle,lit(presis)],_7261,_7263) --> 
    cc(presis,_7261,_7263).

particle(punctually,[particle,_7278],_7264,_7266) --> 
    w(adj2(punctual,nil),_7278,_7264,_7266).

particle(punctually,[particle,_7280,lit(tide)],_7266,_7268) --> 
    prep1(in,_7280,_7266,_7297),
    cc(tide,_7297,_7268).

particle(regularly,[particle,lit(som),lit(normalt)],_7266,_7268) --> 
    cc(som,_7266,_7290),
    cc(normalt,_7290,_7268).

particle(silent,[particle,lit(stille)],_7261,_7263) --> 
    cc(stille,_7261,_7263).

particle(simultaneously,[particle,lit(samtidig)],_7261,_7263) --> 
    cc(samtidig,_7261,_7263).

particle(slowly,[particle,lit(langsomt)],_7261,_7263) --> 
    cc(langsomt,_7261,_7263).

particle(somewhere,[particle,lit(noensted)],_7261,_7263) --> 
    cc(noensted,_7261,_7263).

particle(southward,[particle,lit('sørover')],_7261,_7263) --> 
    cc('sørover',_7261,_7263).

particle(there,[particle,lit(dit)],_7261,_7263) --> 
    cc(dit,_7261,_7263).

particle(there,[particle,lit(der)],_7261,_7263) --> 
    cc(der,_7261,_7263).

particle(there,[particle,_7278],_7264,_7266) --> 
    w(adj2(present,nil),_7278,_7264,_7266).

particle(thereafter,[particle,_7273],_7259,_7261) --> 
    thereafter(_7273,_7259,_7261).

particle(this_midnight,[particle,lit(inatt)],_7261,_7263) --> 
    cc(inatt,_7261,_7263).

particle(today,[particle,lit(idag)],_7261,_7263) --> 
    cc(idag,_7261,_7263).

particle(together,[particle,lit(sammen)],_7261,_7263) --> 
    cc(sammen,_7261,_7263).

particle(tomorrow,[particle,lit(imorgen)],_7261,_7263) --> 
    cc(imorgen,_7261,_7263).

particle(tonight,[particle,lit(ikveld)],_7261,_7263) --> 
    cc(ikveld,_7261,_7263).

particle(up,[particle,lit(opp)],_7261,_7263) --> 
    cc(opp,_7261,_7263).

particle(well,[particle,lit(bra)],_7261,_7263) --> 
    cc(bra,_7261,_7263).

particle(well,[particle,lit(best)],_7261,_7263) --> 
    cc(best,_7261,_7263).

particle(well,[particle,lit(vel)],_7261,_7263) --> 
    cc(vel,_7261,_7263).

particle(westward,[particle,lit(vestover)],_7261,_7263) --> 
    cc(vestover,_7261,_7263).

particle(with1,[particle,lit(med),_7297],_7272,_7274) --> 
    cc(med,_7272,_7296),
    not_look_ahead(w(name(_7249,_7250,_7251)),_7297,_7296,_7274).

particle(wrongly,[particle,_7278,lit(feil)],_7264,_7266) --> 
    saa0(_7278,_7264,_7293),
    cc(feil,_7293,_7266).

particle(yesterday,[particle,lit('igår')],_7261,_7263) --> 
    cc('igår',_7261,_7263).

adjunct1(_7240,_7241,_7244::_7245,[adjunct1,{},_7388,_7417,_7441,{},!,_7485,!,_7546],_7358,_7360) --> 
    {user:_7240==nil},
    w(nb(_7278,_7279),_7388,_7358,_7405),
    point0(_7417,_7405,_7432),
    w(noun(_7283,_7284,u,n),_7441,_7432,_7458),
    {user:testmember(_7283,[year,month,week,day,hour,minute,second,mile,kilometer,meter])},
    !,
    lock(exact,_7458,_7505),pushstack(exact,(w(nb(_7278,num)),w(noun(_7283,sin,u,n))),nil,_7505,_7511),np0_accept(_7241,_7244::_7245,_7485,_7511,_7500),unlock(_7500,_7501),
    !,
    accept(_7546,_7501,_7360).

adjunct1(after,_7241,_7242,[adjunct1,_7311,lit('å'),!,_7356],_7291,_7293) --> 
    w(prep(after),_7311,_7291,_7328),
    cc('å',_7328,_7350),
    !,
    lock(last,_7350,_7401),
    pushstack(last,([noen],aux1),nil,_7401,_7407),
    clausal_object1(_7241,_7242,_7356,_7407,_7396),
    unlock(_7396,_7293).

adjunct1(when,_7241,_7242,[adjunct1,lit(om),lit('når'),!,_7328],_7281,_7283) --> 
    cc(om,_7281,_7311),
    cc('når',_7311,_7322),
    !,
    clausal_object1(_7241,_7242,_7328,_7322,_7283).

adjunct1(where,_7241,_7242,[adjunct1,lit(om),lit(hvor),!,_7328],_7281,_7283) --> 
    cc(om,_7281,_7311),
    cc(hvor,_7311,_7322),
    !,
    clausal_object1(_7241,_7242,_7328,_7322,_7283).

adjunct1(regarding,_7241,_7242,[adjunct1,lit(om),lit(at),!,_7328],_7281,_7283) --> 
    cc(om,_7281,_7311),
    cc(at,_7311,_7322),
    !,
    clausal_object1(_7241,_7242,_7328,_7322,_7283).

adjunct1(with,_7241,_7242,[adjunct1,lit(med),lit(det),lit('å'),!,_7350],_7292,_7294) --> 
    cc(med,_7292,_7322),
    cc(det,_7322,_7333),
    cc('å',_7333,_7344),
    !,
    pushstack(first,(someone,aux1),nil,_7344,_7416),
    clausal_object1(_7241,_7242,_7350,_7416,_7294).

adjunct1(_7240,_7241,_7242,[adjunct1,lit(hva),!,_7309],_7273,_7275) --> 
    cc(hva,_7273,_7303),
    !,
    reject(_7309,_7303,_7275).

adjunct1(_7240,_7241,_7242,[adjunct1,_7303,_7332,!,_7366],_7283,_7285) --> 
    prep1(in,_7303,_7283,_7320),
    w(noun(morning,_7258,_7259,_7260),_7332,_7320,_7349),
    !,
    reject(_7366,_7349,_7285).

adjunct1(_7240,_7241,_7244::_7245,[adjunct1,{},!,_7320],_7285,_7287) --> 
    {user:_7240==nil},
    !,
    complement_nil(_7241,_7244::_7245,_7320,_7285,_7287).

adjunct1(ago,_7241,_7244::_7245,[adjunct1,_7340,_7369,_7398,lit(siden),!,_7443,!],_7320,_7322) --> 
    prep1(for,_7340,_7320,_7357),
    anumber(_7267,_7369,_7357,_7386),
    w(noun(_7271,_7272,u,n),_7398,_7386,_7415),
    cc(siden,_7415,_7437),
    !,
    lock(exact,_7437,_7493),pushstack(exact,(number(_7267),w(noun(_7271,plu,u,n))),nil,_7493,_7499),np0_accept(_7241,_7244::_7245,_7443,_7499,_7488),unlock(_7488,_7322),
    !.

adjunct1(after,_7241,_7244::_7245,[adjunct1,lit(om),_7353,_7382,_7411,!,_7445],_7322,_7324) --> 
    cc(om,_7322,_7352),
    anumber(_7277,_7353,_7352,_7370),
    w(noun(_7270,_7282,u,gen),_7382,_7370,_7399),
    w(noun(time,sin,u,n),_7411,_7399,_7428),
    !,
    pushstack(first,(number(_7277),w(noun(_7270,sin,u,n))),nil,_7428,_7485),
    np1(_7241,_7244::_7245,_7445,_7485,_7324).

adjunct1(in,_7241,_7242,[adjunct1,_7348,_7377,{},_7416,!,_7450],_7328,_7330) --> 
    prep(in,_7348,_7328,_7365),
    w(nb(_7267,num),_7377,_7365,_7394),
    {user:(1000=<_7267,_7267=<9999)},
    not_look_ahead(w(noun(time,_7293,_7294,_7295)),_7416,_7394,_7433),
    !,
    lock(exact,_7433,_7467),
    pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_7267,num))),nil,_7467,_7473),
    np1(_7241,_7242,_7450,_7473,_7462),
    unlock(_7462,_7330).

adjunct1(around,_7241,_7242,[adjunct1,_7334,{},_7373,_7397,_7431,_7455,!,_7489],_7314,_7316) --> 
    prep1(_7268,_7334,_7314,_7351),
    {user:testmember(_7268,[in,at,around])},
    ca0(_7373,_7351,_7388),
    clock_kernel(_7241,_7265,_7397,_7388,_7416),
    point0(_7431,_7416,_7446),
    not_look_ahead(w(noun(_7288,_7289,_7290,_7291)),_7455,_7446,_7472),
    !,
    raise_object00(_7265,_7242,_7489,_7472,_7316).

adjunct1(_7240,_7241,_7242,[adjunct1,lit(med),lit(en),lit(gang),!,_7341],_7283,_7285) --> 
    cc(med,_7283,_7313),
    cc(en,_7313,_7324),
    cc(gang,_7324,_7335),
    !,
    reject(_7341,_7335,_7285).

adjunct1(between,(_7256,_7257):clock,_7244::_7244 and _7250 and _7251,[adjunct1,_7335,_7364,_7388,_7422,_7446,_7470,!,_7509],_7315,_7317) --> 
    prep1(between,_7335,_7315,_7352),
    clock0(_7364,_7352,_7379),
    clock_kernel(_7256:clock,_7250,_7388,_7379,_7407),
    betwand0(_7422,_7407,_7437),
    clock0(_7446,_7437,_7461),
    clock_kernel(_7257:clock,_7251,_7470,_7461,_7489),
    !,
    accept(_7509,_7489,_7317).

adjunct1(between,_7241,_7242,[adjunct1,_7299,_7328,!,_7367],_7279,_7281) --> 
    prep1(between,_7299,_7279,_7316),
    noun_phrases2(_7241,_7242,_7328,_7316,_7347),
    !,
    accept(_7367,_7347,_7281).

adjunct1(_7240,_7241,_7242,[adjunct1,lit(om),_7319,!,_7348,{}],_7288,_7290) --> 
    cc(om,_7288,_7318),
    not_look_ahead_subject(_7319,_7318,_7334),
    !,
    np(_7241,_7242,_7348,_7334,_7290),
    {user:adjustprep(_7241,om,_7240)}.

adjunct1(_7240,_7241,_7242,[adjunct1,_7289],_7269,_7271) --> 
    pp(_7240,_7241,_7242,_7289,_7269,_7271).

adjunct1(_7240,_7241,_7242,[adjunct1,{},_7306],_7276,_7278) --> 
    {user:_7240==dir},
    noun_phrase1(_7241,_7242,_7306,_7276,_7278).

pp(on,_7241,_7242,[pp,_7298,lit(at),_7338],_7278,_7280) --> 
    prep(on,_7298,_7278,_7315),
    cc(at,_7315,_7337),
    clausal_object1(_7241,_7242,_7338,_7337,_7280).

pp(as,_7241,_7242,[pp,lit(som),_7324,!,_7358],_7293,_7295) --> 
    cc(som,_7293,_7323),
    look_ahead_lit([meg,deg,ham,henne,oss,dem],_7324,_7323,_7341),
    !,
    np(_7241,_7242,_7358,_7341,_7295).

pp(_7240,_7241,_7242,[pp,_7307,_7336,_7365,_7394],_7287,_7289) --> 
    look_ahead([om],_7307,_7287,_7324),
    prep(_7240,_7336,_7324,_7353),
    not_look_ahead([jeg],_7365,_7353,_7382),
    np(_7241,_7242,_7394,_7382,_7289).

pp(_7240,_7241,_7242,[pp,lit('før'),lit(det),!,_7325],_7278,_7280) --> 
    cc('før',_7278,_7308),
    cc(det,_7308,_7319),
    !,
    reject(_7325,_7319,_7280).

pp(_7240,_7241,_7242,[pp,_7312,_7341,_7370,_7394,{}],_7292,_7294) --> 
    not_look_ahead_lit([om],_7312,_7292,_7329),
    prep(_7259,_7341,_7329,_7358),
    redundant0(_7370,_7358,_7385),
    object(_7241,_7242,_7394,_7385,_7294),
    {user:adjustprep(_7241,_7259,_7240)}.

pp(_7240,_7241,_7244::_7244 and _7248,[pp,_7375,{},_7414,_7443,_7472,_7506,_7535,_7564,!,_7598],_7355,_7357) --> 
    prep(_7240,_7375,_7355,_7392),
    {user:testmember(_7240,[before,after,around,to,over,within])},
    not_look_ahead([et],_7414,_7392,_7431),
    not_look_ahead([en],_7443,_7431,_7460),
    clock_kernel(_7241,_7248,_7472,_7460,_7491),
    not_look_ahead(w(noun(station,_7312,_7313,_7314)),_7506,_7491,_7523),
    not_look_ahead(w(noun(hour,_7321,_7322,_7323)),_7535,_7523,_7552),
    not_look_ahead(w(noun(minute,_7330,_7331,_7332)),_7564,_7552,_7581),
    !,
    accept(_7598,_7581,_7357).

complement_nil(_7240,_7241,[complement_nil,_7347,_7376,_7405,!,_7449,_7483],_7330,_7332) --> 
    w(nb(_7275,num),_7347,_7330,_7364),
    w(noun(minute,_7281,_7282,_7283),_7376,_7364,_7393),
    subjunction(_7285,time,_7287,_7405,_7393,_7426),
    !,
    clausal_object0(_7270,_7271,_7449,_7426,_7468),
    lock(exact,_7468,_7531),
    pushstack(exact,(w(nb(_7275,num)),w(noun(minute,plu,u,n)),w(prep(_7285)),xnp(_7270,_7271)),nil,_7531,_7537),
    np1(_7240,_7241,_7483,_7537,_7526),
    unlock(_7526,_7332).

complement_nil(_7240,_7241,[complement_nil,_7330,_7359,_7388,!,_7422],_7313,_7315) --> 
    w(nb(_7270,num),_7330,_7313,_7347),
    w(noun(minute,_7276,_7277,_7278),_7359,_7347,_7376),
    look_ahead(w(prep(_7284)),_7388,_7376,_7405),
    !,
    lock(exact,_7405,_7439),
    pushstack(exact,(w(nb(_7270,num)),w(noun(minute,_7264,_7265,_7266))),nil,_7439,_7445),
    noun_phrase1(_7240,_7241,_7422,_7445,_7434),
    unlock(_7434,_7315).

complement_nil(_7240,_7241,[complement_nil,_7282],_7265,_7267) --> 
    obviousclock(_7240,_7241,_7282,_7265,_7267).

complement_nil(_7240,_7241,[complement_nil,_7292,!,_7326],_7275,_7277) --> 
    w(prep(nil),_7292,_7275,_7309),
    !,
    noun_phrase1(_7240,_7241,_7326,_7309,_7277).

complement_nil(_7240,_7243::_7244,[complement_nil,_7336,{},!,_7380,_7404],_7319,_7321) --> 
    w(noun(_7266,_7274,_7275,n),_7336,_7319,_7353),
    {user:testmember(_7266,[nightbus,summerroute,winterroute])},
    !,
    accept(_7380,_7353,_7395),
    lock(exact,_7395,_7421),
    pushstack(exact,(w(prep(with)),w(noun(_7266,sin,u,n))),nil,_7421,_7427),
    adjunct1(_7289,_7240,_7243::_7244,_7404,_7427,_7416),
    unlock(_7416,_7321).

complement_nil(_7240,_7241,[complement_nil,_7322,_7351,_7380,_7409,_7438,!,_7472],_7305,_7307) --> 
    not_look_ahead(w(noun(street,sin,u,n)),_7322,_7305,_7339),
    not_look_ahead([den],_7351,_7339,_7368),
    not_look_ahead([det],_7380,_7368,_7397),
    not_look_ahead(w(prep(with)),_7409,_7397,_7426),
    pronoun1(_7284,_7438,_7426,_7455),
    !,
    reject(_7472,_7455,_7307).

complement_nil(_7240,_7243::_7243 and _7247,[complement_nil,_7288],_7271,_7273) --> 
    plausibleclock1(_7240,_7247,_7288,_7271,_7273).

complement_nil(_7240,_7243::_7244,[complement_nil,_7291,!],_7274,_7276) --> 
    obviousdate(_7240,_7243::_7244,_7291,_7274,_7276),
    !.

complement_nil(_7240,_7243::_7243 and _7247,[complement_nil,_7288],_7271,_7273) --> 
    plausibledate1(_7240,_7247,_7288,_7271,_7273).

complement_nil(_7240,_7243::_7244,[complement_nil,_7311,_7340,!,_7379],_7294,_7296) --> 
    look_ahead(w(adj2(_7265,nil)),_7311,_7294,_7328),
    gmem(_7265,[short,long],_7340,_7328,_7359),
    !,
    noun_phrase1(_7240,_7243::_7244,_7379,_7359,_7296).

complement_nil(_7240,_7241,[complement_nil,_7321,_7350,!,_7384],_7304,_7306) --> 
    w(nb(_7267,num),_7321,_7304,_7338),
    w(noun(time_count,_7261,_7262,_7263),_7350,_7338,_7367),
    !,
    lock(exact,_7367,_7401),
    pushstack(exact,(w(nb(_7267,num)),w(noun(time_count,_7261,_7262,_7263))),nil,_7401,_7407),
    np0(_7240,_7241,_7384,_7407,_7396),
    unlock(_7396,_7306).

complement_nil(_7240,_7241,[complement_nil,_7344,_7373,_7402,_7431,_7460,_7489,!,_7523],_7327,_7329) --> 
    not_look_ahead(w(name(_7268,_7269,_7270)),_7344,_7327,_7361),
    w(nb(_7274,num),_7373,_7361,_7390),
    not_look_ahead([ganger],_7402,_7390,_7419),
    not_look_ahead(w(noun(hour,_7286,_7287,_7288)),_7431,_7419,_7448),
    not_look_ahead(w(noun(minute,_7295,_7296,_7297)),_7460,_7448,_7477),
    not_look_ahead(w(noun(second,_7304,_7305,_7306)),_7489,_7477,_7506),
    !,
    reject(_7523,_7506,_7329).

complement_nil(_7240,_7241,[complement_nil,_7366,_7395,_7424,_7453,_7482,_7511,_7540,_7569,!],_7349,_7351) --> 
    not_look_ahead(w(nb(_7271,_7272)),_7366,_7349,_7383),
    not_look_ahead(w(_7276,name(_7276,_7280,month)),_7395,_7383,_7412),
    not_look_ahead_lit([sin,sitt,sine],_7424,_7412,_7441),
    not_look_ahead(w(noun(hour,plu,u,n)),_7453,_7441,_7470),
    not_look_ahead(w(noun(minute,plu,u,n)),_7482,_7470,_7499),
    not_look_ahead(w(noun(second,plu,u,n)),_7511,_7499,_7528),
    not_look_ahead(w(noun(room,_7323,u,n)),_7540,_7528,_7557),
    object(_7240,_7241,_7569,_7557,_7351),
    !.

complement1_accept(_7240,_7241,_7242,[complement1_accept,lit(idag),!,_7331,!],_7295,_7297) --> 
    cc(idag,_7295,_7325),
    !,
    pushstack(first,(prep(in),w(noun(day,sin,u,n))),nil,_7325,_7374),complement1_accept(_7240,_7241,_7242,_7331,_7374,_7297),
    !.

complement1_accept(_7240,_7241,_7244::_7245,[complement1_accept,_7333,{},_7372,_7401,_7430,!,_7469],_7313,_7315) --> 
    prep(_7240,_7333,_7313,_7350),
    {user:(\+testmember(_7240,[of,between]))},
    not_look_ahead([jeg],_7372,_7350,_7389),
    not_look_ahead([man],_7401,_7389,_7418),
    noun_phrase_accept(_7241,_7244::_7245,_7430,_7418,_7449),
    !,
    accept(_7469,_7449,_7315).

plausibledate1(_7243:date,_7243 isa date,[plausibledate1,_7363,{},_7402,_7426,{},_7465,_7489,{},!,_7533,{}],_7346,_7348) --> 
    num_na(_7284,_7363,_7346,_7380),
    {user:(_7284>=1000,_7284=<9999)},
    dashpoint0(_7402,_7380,_7417),
    num_na(_7285,_7426,_7417,_7443),
    {user:(_7285>=1,_7285=<12)},
    dashpoint0(_7465,_7443,_7480),
    num_na(_7286,_7489,_7480,_7506),
    {user:(_7286>=1,_7286=<31)},
    !,
    accept(_7533,_7506,_7348),
    {user:_7243=date(_7284,_7285,_7286)}.

plausibledate1(_7243:date,_7243 isa date,[plausibledate1,_7343,{},_7382,_7406,{},{},!,_7460,{}],_7326,_7328) --> 
    num_na(_7283,_7343,_7326,_7360),
    {user:_7283=<31},
    slashpoint0(_7382,_7360,_7397),
    num_na(_7282,_7406,_7397,_7423),
    {user:_7282=<12},
    {user:this_year(_7301)},
    !,
    accept(_7460,_7423,_7328),
    {user:(adjust_year(_7282,_7301,_7281),_7243=date(_7281,_7282,_7283))}.

obviousdate(_7240,_7243::_7246 and _7243,[obviousdate,_7288],_7271,_7273) --> 
    obviousdate1(_7240,_7246,_7288,_7271,_7273).

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7322,_7346,_7375,_7399,_7428,!,_7467,{}],_7305,_7307) --> 
    point0(_7322,_7305,_7337),
    dayno(_7277,_7346,_7337,_7363),
    slashpoint0(_7375,_7363,_7390),
    monthname(_7276,_7399,_7390,_7416),
    xyear0(_7276,_7275,_7428,_7416,_7447),
    !,
    accept(_7467,_7447,_7307),
    {user:_7243=date(_7275,_7276,_7277)}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7366,_7390,{},_7429,_7453,{},_7492,_7516,{},!,_7560,{}],_7349,_7351) --> 
    point0(_7366,_7349,_7381),
    num_na(_7287,_7390,_7381,_7407),
    {user:(_7287>=1000,_7287=<9999)},
    dashpoint0(_7429,_7407,_7444),
    num_na(_7288,_7453,_7444,_7470),
    {user:(_7288>=1,_7288=<12)},
    dashpoint0(_7492,_7470,_7507),
    num_na(_7289,_7516,_7507,_7533),
    {user:(_7289>=1,_7289=<31)},
    !,
    accept(_7560,_7533,_7351),
    {user:_7243=date(_7287,_7288,_7289)}.

obviousdate1(_7240,_7246 isa day and _7244,[obviousdate1,_7306,{},_7345,!,_7384],_7289,_7291) --> 
    dendagen(_7246,_7306,_7289,_7323),
    {user:dayname(_7246)},
    date(_7240,_7244,_7345,_7323,_7364),
    !,
    accept(_7384,_7364,_7291).

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7344,_7368,{},_7407,_7431,{},_7470,!,_7509,{}],_7327,_7329) --> 
    point0(_7344,_7327,_7359),
    num_na(_7283,_7368,_7359,_7385),
    {user:(_7283>=25,_7283=<31)},
    slash(_7407,_7385,_7422),
    num_na(_7282,_7431,_7422,_7448),
    {user:_7282=<12},
    xyear0(_7282,_7281,_7470,_7448,_7489),
    !,
    accept(_7509,_7489,_7329),
    {user:_7243=date(_7281,_7282,_7283)}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7385,_7409,{},_7448,_7472,{},_7511,_7555,!,{}],_7368,_7370) --> 
    den0(_7385,_7368,_7400),
    num_na(_7294,_7409,_7400,_7426),
    {user:(_7294>=1,_7294=<7)},
    point0(_7448,_7426,_7463),
    w(name(_7309,n,date),_7472,_7463,_7489),
    {user:testmember(_7309,[easterday])},
    optional(w(noun(year,_7325,_7326,n)),_7511,_7489,_7543),
    w(nb(_7331,num),_7555,_7543,_7370),
    !,
    {user:(easterdate(_7331,_7290),_7331>=1000,_7331=<9999,_7291 is _7294-1,add_days(_7290,_7291,_7243))}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,{},_7355,{},_7394,!,{}],_7328,_7330) --> 
    {user:_7243=date(_7278,_7270,_7271)},
    w(name(_7266,n,date),_7355,_7328,_7372),
    {user:testmember(_7266,[christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day,may17])},
    year_expression(_7278,_7394,_7372,_7330),
    !,
    {user:named_date(_7266,date(_7269,_7270,_7271))}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7389,_7413,{},_7452,_7476,{},_7515,_7544,!,{}],_7372,_7374) --> 
    den0(_7389,_7372,_7404),
    num_na(_7288,_7413,_7404,_7430),
    {user:(_7288>=1,_7288=<7)},
    point0(_7452,_7430,_7467),
    w(name(_7303,n,date),_7476,_7467,_7493),
    {user:testmember(_7303,[whitsun_day,easterday,christmas_day,new_years_day])},
    not_look_ahead(w(noun(year,_7325,_7326,_7327)),_7515,_7493,_7532),
    not_look_ahead(w(nb(_7333,num)),_7544,_7532,_7374),
    !,
    {user:(named_date(_7303,date(_7339,_7340,_7341)),_7285 is _7288-1,add_days(date(_7339,_7340,_7341),_7285,_7243))}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7357,{},_7396,_7425,!,{}],_7340,_7342) --> 
    w(name(_7266,n,date),_7357,_7340,_7374),
    {user:testmember(_7266,[whitsun_eve,whitsun_day,palm_sunday,maundy_thursday,good_friday,eastereve,easterday,christmas_eve,christmas_day,new_years_eve,new_years_day,midsummer_eve,midsummer_day])},
    not_look_ahead(w(prep(in)),_7396,_7374,_7413),
    not_look_ahead(w(noun(year,_7317,_7318,_7319)),_7425,_7413,_7342),
    !,
    {user:named_date(_7266,_7243)}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7302,{},!],_7285,_7287) --> 
    w(name(_7257,n,date),_7302,_7285,_7287),
    {user:named_date(_7257,_7243)},
    !.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7314,{},_7353,{},!,_7397],_7297,_7299) --> 
    dendagen(_7264,_7314,_7297,_7331),
    {user:_7264\==nil},
    num_na(_7264,_7353,_7331,_7370),
    {user:numberdate(_7264,_7243)},
    !,
    accept(_7397,_7370,_7299).

obviousdate1(_7240,_7241,[obviousdate1,_7290,_7319,!],_7273,_7275) --> 
    dendagen(_7249,_7290,_7273,_7307),
    date(_7240,_7241,_7319,_7307,_7275),
    !.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7336,_7360,{},_7399,_7423,_7452,_7476,!,{}],_7319,_7321) --> 
    den(_7336,_7319,_7351),
    num_na(_7280,_7360,_7351,_7377),
    {user:(_7280>=1,_7280=<31)},
    slashpoint0(_7399,_7377,_7414),
    monthname(_7279,_7423,_7414,_7440),
    slashpoint0(_7452,_7440,_7467),
    xyear0(_7279,_7278,_7476,_7467,_7321),
    !,
    {user:_7243=date(_7278,_7279,_7280)}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7349,_7373,{},_7412,_7436,{},_7475,_7499,!,{}],_7332,_7334) --> 
    den0(_7349,_7332,_7364),
    num_na(_7283,_7373,_7364,_7390),
    {user:(_7283>=1,_7283=<31)},
    slashpoint0(_7412,_7390,_7427),
    month(_7282,_7436,_7427,_7453),
    {user:(_7282>=1,_7282=<12)},
    slashpoint0(_7475,_7453,_7490),
    year(_7281,_7499,_7490,_7334),
    !,
    {user:_7243=date(_7281,_7282,_7283)}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7322,_7351,_7380,_7409,!,{}],_7305,_7307) --> 
    not_look_ahead(w(nb(_7277,num)),_7322,_7305,_7339),
    month(_7270,_7351,_7339,_7368),
    num_na(_7271,_7380,_7368,_7397),
    year0(_7269,_7409,_7397,_7307),
    !,
    {user:_7243=date(_7269,_7270,_7271)}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7325,_7349,_7378,_7402,!,{}],_7308,_7310) --> 
    den(_7325,_7308,_7340),
    num_na(_7277,_7349,_7340,_7366),
    slashpoint(_7378,_7366,_7393),
    month(_7276,_7402,_7393,_7310),
    !,
    {user:(this_year(_7283),adjust_year(_7276,_7283,_7275),_7243=date(_7275,_7276,_7277))}.

obviousdate1(_7240,_7241,[obviousdate1,_7302,_7331,_7360,!,_7394],_7285,_7287) --> 
    dendagen(_7255,_7302,_7285,_7319),
    num_na(_7257,_7331,_7319,_7348),
    w(noun(_7261,plu,_7263,_7264),_7360,_7348,_7377),
    !,
    reject(_7394,_7377,_7287).

obviousdate1(_7240,_7241,[obviousdate1,lit(den),_7306,!,_7340],_7278,_7280) --> 
    cc(den,_7278,_7305),
    w(nb(_7256,ord),_7306,_7305,_7323),
    !,
    reject(_7340,_7323,_7280).

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,{},_7340,_7369,_7393,_7422,{}],_7313,_7315) --> 
    {user:value(busflag,true)},
    num_na(_7274,_7340,_7313,_7357),
    slashpoint0(_7369,_7357,_7384),
    num_na(_7273,_7393,_7384,_7410),
    slashpoint0(_7422,_7410,_7315),
    {user:(dedicated_date(date(_7272,_7273,_7274)),_7243=date(_7272,_7273,_7274))}.

obviousdate1(_7243:date,_7241,[obviousdate1,_7314,_7343,{},_7382,!,_7416],_7297,_7299) --> 
    dendagen(_7261,_7314,_7297,_7331),
    num_na(_7263,_7343,_7331,_7360),
    {user:(_7263>=1,_7263=<31)},
    colemin(_7276,_7382,_7360,_7399),
    !,
    reject(_7416,_7399,_7299).

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7353,{},_7392,{},_7431,_7455,!,{},{}],_7336,_7338) --> 
    dendagen(_7282,_7353,_7336,_7370),
    {user:_7282\==nil},
    num_na(_7280,_7392,_7370,_7409),
    {user:(_7280>=1,_7280=<31)},
    point(_7431,_7409,_7446),
    not_look_ahead(w(nb(_7306,_7307)),_7455,_7446,_7338),
    !,
    {user:todaysdate(date(_7278,_7279,_7315))},
    {user:_7243=date(_7278,_7279,_7280)}.

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,lit(den),_7317,{},!,_7361],_7289,_7291) --> 
    cc(den,_7289,_7316),
    num_na(_7263,_7317,_7316,_7334),
    {user:numberdate(_7263,_7243)},
    !,
    accept(_7361,_7334,_7291).

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7321,{},_7360,{},!,_7404],_7304,_7306) --> 
    num_na(_7264,_7321,_7304,_7338),
    {user:_7264>=10101},
    not_look_ahead(w(noun(_7275,plu,_7277,_7278)),_7360,_7338,_7377),
    {user:numberdate(_7264,_7243)},
    !,
    accept(_7404,_7377,_7306).

obviousdate1(_7243:date,_7243 isa date,[obviousdate1,_7321,{},_7360,{},!,_7404],_7304,_7306) --> 
    num_na(_7264,_7321,_7304,_7338),
    {user:_7264>=2501},
    not_look_ahead(w(noun(_7275,plu,_7277,_7278)),_7360,_7338,_7377),
    {user:numberdate(_7264,_7243)},
    !,
    accept(_7404,_7377,_7306).

year_expression(_7240,[year_expression,_7310,_7354,_7398,{},!],_7296,_7298) --> 
    optional(w(prep(in)),_7310,_7296,_7342),
    optional(w(noun(year,sin,u,n)),_7354,_7342,_7386),
    w(nb(_7240,num),_7398,_7386,_7298),
    {user:_7240=<9999},
    !.

year_expression(_7240,[year_expression,_7292,!,{}],_7278,_7280) --> 
    lastyear(_7292,_7278,_7280),
    !,
    {user:(this_year(_7256),_7240 is _7256-1)}.

year_expression(_7240,[year_expression,_7292,!,{}],_7278,_7280) --> 
    nextyear(_7292,_7278,_7280),
    !,
    {user:(this_year(_7256),_7240 is _7256+1)}.

lastyear([lastyear,_7285,lit(siste),_7340],_7274,_7276) --> 
    optional([i],_7285,_7274,_7317),
    cc(siste,_7317,_7339),
    w(noun(year,sin,_7250,n),_7340,_7339,_7276).

lastyear([lastyear,_7280,_7324],_7269,_7271) --> 
    optional([i],_7280,_7269,_7312),
    w(noun(lastyear,sin,_7247,n),_7324,_7312,_7271).

lastyear([lastyear,lit(ifjor),!],_7260,_7262) --> 
    cc(ifjor,_7260,_7262),
    !.

nextyear([nextyear,_7285,lit(neste),_7340],_7274,_7276) --> 
    optional([i],_7285,_7274,_7317),
    cc(neste,_7317,_7339),
    w(noun(year,sin,u,n),_7340,_7339,_7276).

plausibleclock(_7240,_7243::_7243 and _7247,[plausibleclock,_7301,!,_7335],_7284,_7286) --> 
    look_ahead(w(nb(_7262,_7263)),_7301,_7284,_7318),
    !,
    clock_sequel(_7240,_7247,_7335,_7318,_7286).

plausibleclock1(_7243:clock,_7243 isa clock,[plausibleclock1,_7355,{},_7394,_7418,_7447,_7491,_7520,{},!],_7338,_7340) --> 
    w(nb(_7275,num),_7355,_7338,_7372),
    {user:(_7275>=1,_7275=<24)},
    point0(_7394,_7372,_7409),
    w(nb(_7291,num),_7418,_7409,_7435),
    optional(['.'],_7447,_7435,_7479),
    not_look_ahead(w(nb(_7302,_7303)),_7491,_7479,_7508),
    not_look_ahead(w(name(_7309,_7310,month)),_7520,_7508,_7340),
    {user:plausibleclocktest(_7275,_7291,_7243)},
    !.

obviousclock(_7240,_7241,[obviousclock,_7312,_7341,_7365,{},!,_7409],_7295,_7297) --> 
    w(nb(_7260,num),_7312,_7295,_7329),
    pointNO(_7341,_7329,_7356),
    w(nb(_7265,num),_7365,_7356,_7382),
    {user:dedicated_date(date(_7272,_7265,_7260))},
    !,
    reject(_7409,_7382,_7297).

obviousclock(_7240,_7243::_7243 and _7247,[obviousclock,_7288],_7271,_7273) --> 
    obviousclock1(_7240,_7247,_7288,_7271,_7273).

obviousclock1(_7240,_7241,[obviousclock1,_7288,!,_7317],_7271,_7273) --> 
    clock(_7288,_7271,_7303),
    !,
    clock_sequel(_7240,_7241,_7317,_7303,_7273).

obviousclock1(_7240,_7241,[obviousclock1,_7298,_7332,!,_7366],_7281,_7283) --> 
    clock_kernel(_7240,_7241,_7298,_7281,_7317),
    w(noun(time,sin,def,n),_7332,_7317,_7349),
    !,
    accept(_7366,_7349,_7283).

obviousclock1(_7243:clock,_7243 isa clock,[obviousclock1,_7386,_7415,_7444,{},_7483,_7512,_7541,_7570,_7599,_7628,!,_7677],_7369,_7371) --> 
    not_look_ahead(w(name(_7286,n,route)),_7386,_7369,_7403),
    not_look_ahead(w(name(_7294,n,nightbus)),_7415,_7403,_7432),
    w(nb(_7243,num),_7444,_7432,_7461),
    {user:(_7243>=100,clock_test(_7243))},
    not_look_ahead([-],_7483,_7461,_7500),
    not_look_ahead(w(nb(_7321,_7322)),_7512,_7500,_7529),
    not_look_ahead(w(noun(_7328,plu,_7330,_7331)),_7541,_7529,_7558),
    not_look_ahead([tusen],_7570,_7558,_7587),
    not_look_ahead([millioner],_7599,_7587,_7616),
    optional(w(noun(time,sin,def,n)),_7628,_7616,_7660),
    !,
    accept(_7677,_7660,_7371).

obviousclock1(_7243:clock,_7243 isa clock,[obviousclock1,_7287],_7270,_7272) --> 
    time2(_7243,_7287,_7270,_7272).

obviousclock1(_7243:clock,_7243 isa clock,[obviousclock1,_7294,_7323],_7277,_7279) --> 
    hours100(_7243,_7294,_7277,_7311),
    look_ahead([om],_7323,_7311,_7279).

rel_clauses(_7240,_7241,_7242,[rel_clauses,lit(hva),!,_7309],_7273,_7275) --> 
    cc(hva,_7273,_7303),
    !,
    reject(_7309,_7303,_7275).

rel_clauses(_7240,_7241,_7241 and _7245,[rel_clauses,_7329,lit(det),_7364,_7455],_7309,_7311) --> 
    derhvor(_7329,_7309,_7344),
    cc(det,_7344,_7363),
    lock(exact,_7363,_7414),pushstack(exact,(w(prep(in)),npgap(_7240)),nil,_7414,_7420),adverbial1(_7262,_7263,_7264,_7364,_7420,_7409),unlock(_7409,_7410),
    lock(last,_7410,_7504),
    pushstack(last,([det],xadverbial1(_7262,_7263,_7264)),nil,_7504,_7510),
    substatement1(_7245,_7455,_7510,_7499),
    unlock(_7499,_7311).

rel_clauses(_7240,_7241,_7241 and _7245,[rel_clauses,_7350,_7379,_7408,!,_7442],_7330,_7332) --> 
    w(noun(_7275,_7276,_7277,n),_7350,_7330,_7367),
    w(verb(apply,_7283,fin),_7379,_7367,_7396),
    w(prep(_7288),_7408,_7396,_7425),
    !,
    pushstack(first,(w(noun(_7275,_7276,_7277,n)),w(verb(apply,_7283,fin)),w(prep(_7288)),npgap(_7240)),nil,_7425,_7482),
    statreal(_7245,_7442,_7482,_7332).

rel_clauses(_7240,_7241,_7242,[rel_clauses,_7317,_7351],_7297,_7299) --> 
    lit_of(_7252,[jeg,hun,han,vi,man,du],_7317,_7297,_7336),
    pushstack(first,([som],[_7252]),nil,_7336,_7361),
    rel_clause(_7240,_7241,_7242,_7351,_7361,_7299).

rel_clauses(_7240,_7241,_7241 and _7245,[rel_clauses,_7329,lit(det),_7364,_7455],_7309,_7311) --> 
    derhvor(_7329,_7309,_7344),
    cc(det,_7344,_7363),
    lock(exact,_7363,_7414),pushstack(exact,(w(prep(in)),npgap(_7240)),nil,_7414,_7420),adverbial1(_7262,_7263,_7264,_7364,_7420,_7409),unlock(_7409,_7410),
    lock(last,_7410,_7504),
    pushstack(last,([det],xadverbial1(_7262,_7263,_7264)),nil,_7504,_7510),
    substatement1(_7245,_7455,_7510,_7499),
    unlock(_7499,_7311).

rel_clauses(_7240,_7241,_7241 and _7245,[rel_clauses,_7317,_7341,_7375],_7297,_7299) --> 
    derhvor(_7317,_7297,_7332),
    subject(_7264,_7265,_7341,_7332,_7360),
    lock(last,_7360,_7453),
    pushstack(last,(xnp(_7264,_7265),w(prep(in)),npgap(_7240)),nil,_7453,_7459),
    statreal(_7245,_7375,_7459,_7448),
    unlock(_7448,_7299).

rel_clauses(_7240,_7241,_7242,[rel_clauses,lit(som),_7350,_7374,_7403,_7437,!,[],_7527],_7319,_7321) --> 
    cc(som,_7319,_7349),
    danow0(_7350,_7349,_7365),
    look_ahead(w(prep(_7276)),_7374,_7365,_7391),
    gmem(_7276,[of],_7403,_7391,_7422),
    adverbix(_7283,_7284,_7285,_7437,_7422,_7458),
    !,
    pushstack(free,xadverbial1(_7283,_7284,_7285),nil,_7458,_7526),[],
    pushstack(first,[som],nil,_7526,_7537),
    rel_clause(_7240,_7241,_7242,_7527,_7537,_7321).

rel_clauses(_7240,_7241,_7242,[rel_clauses,_7296,_7335],_7276,_7278) --> 
    rel_clause(_7240,_7241,_7248,_7296,_7276,_7317),
    rel_clauses0(_7240,_7248,_7242,_7335,_7317,_7278).

rel_clauses0(_7240,_7241,_7242,[rel_clauses0,_7292,_7316],_7272,_7274) --> 
    and1x(_7292,_7272,_7307),
    rel_clauses(_7240,_7241,_7242,_7316,_7307,_7274).

rel_clauses0(_7240,_7241,_7241,[rel_clauses0,[]],_7265,_7265) --> 
    [].

derhvor([derhvor,_7277,!],_7266,_7268) --> 
    one_of_lit([der,hvor,dit],_7277,_7266,_7268),
    !.

and1x([and1x,_7266],_7255,_7257) --> 
    and1(_7266,_7255,_7257).

and1x([and1x,_7270],_7259,_7261) --> 
    look_ahead([som],_7270,_7259,_7261).

dvs([dvs,lit(dvs)],_7257,_7259) --> 
    cc(dvs,_7257,_7259).

dvs([dvs,lit('altså')],_7257,_7259) --> 
    cc('altså',_7257,_7259).

dvs([dvs,lit(a),lit(la)],_7262,_7264) --> 
    cc(a,_7262,_7283),
    cc(la,_7283,_7264).

rel_clause(_7240,_7241,_7241 and _7245,[rel_clause,_7310,!,_7339],_7290,_7292) --> 
    dvs(_7310,_7290,_7325),
    !,
    lock(last,_7325,_7386),
    pushstack(last,(npgap(_7240),w(verb(be,pres,fin))),nil,_7386,_7392),
    statreal(_7245,_7339,_7392,_7381),
    unlock(_7381,_7292).

rel_clause(_7240,_7241,_7241 and _7245,[rel_clause,_7340,_7369,!,_7408],_7320,_7322) --> 
    w(verb(_7269,past,part),_7340,_7320,_7357),
    gmem(_7269,[adapt,label,be_named,register],_7369,_7357,_7388),
    !,
    lock(last,_7388,_7455),
    pushstack(last,(w(noun(agent,sin,u,n)),w(verb(_7269,past,fin)),npgap(_7240)),nil,_7455,_7461),
    statreal(_7245,_7408,_7461,_7450),
    unlock(_7450,_7322).

rel_clause(_7240,_7241,_7241 and _7245,[rel_clause,_7333,_7362,_7396,!,_7425],_7313,_7315) --> 
    rel(_7240,_7333,_7313,_7350),
    lit_of(_7269,[du,jeg,de,han,hun,vi,dere,man],_7362,_7350,_7381),
    look_ahead_vp(_7396,_7381,_7411),
    !,
    lock(last,_7411,_7472),
    pushstack(last,([_7269],npgap(_7240)),nil,_7472,_7478),
    statreal(_7245,_7425,_7478,_7467),
    unlock(_7467,_7315).

rel_clause(_7240,_7241,_7241 and _7245,[rel_clause,_7307,_7336,_7365],_7287,_7289) --> 
    rel(_7240,_7307,_7287,_7324),
    not_look_ahead([at],_7336,_7324,_7353),
    pushstack(free,npgap(_7240),nil,_7353,_7405),
    statreal(_7245,_7365,_7405,_7289).

rel_clause(_7240,_7241,_7241 and _7245,[rel_clause,_7313,lit(det),!,_7358],_7293,_7295) --> 
    rel(_7240,_7313,_7293,_7330),
    cc(det,_7330,_7352),
    !,
    lock(last,_7352,_7405),
    pushstack(last,([det],npgap(_7240)),nil,_7405,_7411),
    statreal(_7245,_7358,_7411,_7400),
    unlock(_7400,_7295).

relneg(_7240,[relneg,_7281,_7305,!],_7267,_7269) --> 
    relblabla(_7281,_7267,_7296),
    negation0(_7240,_7305,_7296,_7269),
    !.

relneg(_7240,[relneg,_7281,_7310,!],_7267,_7269) --> 
    negation0(_7240,_7281,_7267,_7298),
    relblabla(_7310,_7298,_7269),
    !.

relblabla([relblabla,lit('nå'),!],_7260,_7262) --> 
    cc('nå',_7260,_7262),
    !.

relblabla([relblabla,lit(bare),!],_7260,_7262) --> 
    cc(bare,_7260,_7262),
    !.

relblabla([relblabla,_7266],_7255,_7257) --> 
    redundant0(_7266,_7255,_7257).

whose_noun(_7240,_7241,[whose_noun,_7289,_7313],_7272,_7274) --> 
    whose(_7289,_7272,_7304),
    noun(_7246,_7247,u,n,_7240,_7241,_7313,_7304,_7274).

relwhat(_7240,[relwhat,_7290,_7314,{},!,_7353],_7276,_7278) --> 
    hva(_7290,_7276,_7305),
    som0(_7314,_7305,_7329),
    {user:constrain(_7240,thing)},
    !,
    accept(_7353,_7329,_7278).

relwhat(_7240,[relwhat,lit(hvem),_7303,{},!,_7342],_7278,_7280) --> 
    cc(hvem,_7278,_7302),
    som0(_7303,_7302,_7318),
    {user:constrain(_7240,agent)},
    !,
    accept(_7342,_7318,_7280).

rel(_7240,[rel,_7305,_7334,_7363,{},!,_7422],_7291,_7293) --> 
    relpron(_7257,_7305,_7291,_7322),
    not_look_ahead(w(quote(_7263)),_7334,_7322,_7351),
    optional(['nå'],_7363,_7351,_7395),
    {user:constrain(_7240,_7257)},
    !,
    accept(_7422,_7395,_7293).

comparisons(_7240,_7241,_7242,[comparisons,_7297,_7336],_7277,_7279) --> 
    comparison(_7240,_7241,_7249,_7297,_7277,_7318),
    comparisons0(_7240,_7241,_7249,_7242,_7336,_7318,_7279).

comparisons0(_7240,_7241,_7242,_7242 and _7246,[comparisons0,_7309,_7333,_7372],_7286,_7288) --> 
    and1(_7309,_7286,_7324),
    comparison(_7240,_7241,_7256,_7333,_7324,_7354),
    comparisons0(_7240,_7241,_7256,_7246,_7372,_7354,_7288).

comparisons0(_7240,_7241,_7242,_7242,[comparisons0,[]],_7268,_7268) --> 
    [].

comparison(_7240,_7241,_7242,[comparison,{},{},_7349,!,{}],_7309,_7311) --> 
    {user:vartypeid(_7240,_7267)},
    {user:testmember(_7267,[speed,price,name,description])},
    np1_accept(_7261,_7262::_7242,_7349,_7309,_7311),
    !,
    {user:compare(eq,thing,_7240,_7261,_7262)}.

comparison(_7240,_7241,_7242,[comparison,_7322,{},{},{},!,_7386],_7302,_7304) --> 
    comparator1(_7259,_7322,_7302,_7339),
    {user:_7259==gt},
    {user:vartype(_7240,_7269,_7270)},
    {user:testmember(_7270,[information,minute])},
    !,
    reject(_7386,_7339,_7304).

comparison(_7240,_7241,_7242,[comparison,_7319,{},_7358,{}],_7299,_7301) --> 
    comparator1(_7255,_7319,_7299,_7336),
    {user:testmember(_7255,[eq,ne])},
    noun_phrase1(_7258,_7259::_7242,_7358,_7336,_7301),
    {user:compare(_7255,thing,_7240,_7258,_7259)}.

comparison(_7240,_7241,_7242,[comparison,_7323,{},_7362,{}],_7303,_7305) --> 
    comparator1(_7255,_7323,_7303,_7340),
    {user:testmember(_7255,[gt,ge,le,lt])},
    noun_phrase1(_7258,_7259::_7242,_7362,_7340,_7305),
    {user:compare(_7255,number,_7240,_7258,_7259)}.

comparison(_7240,_7241,_7242,[comparison,_7308,_7342,{}],_7288,_7290) --> 
    comparator2(_7252,_7253,_7308,_7288,_7327),
    noun_phrase1(_7255,_7256::_7242,_7342,_7327,_7290),
    {user:compare(_7252,_7253,_7240,_7255,_7256)}.

comparison(_7240,_7241,_7242,[comparison,_7308,_7342,{}],_7288,_7290) --> 
    comparator3(_7252,_7253,_7308,_7288,_7327),
    noun_phrase1(_7255,_7256::_7242,_7342,_7327,_7290),
    {user:comparad(_7252,_7253,_7240,_7255,_7256)}.

np(_7240,_7241,[np,_7282],_7265,_7267) --> 
    xnp(_7240,_7241,_7282,_7265,_7267).

np(_7240,_7243::_7244,[np,_7288],_7271,_7273) --> 
    noun_phrases(_7240,_7243::_7244,_7288,_7271,_7273).

np(_7240,_7243::_7243,[np,_7284],_7267,_7269) --> 
    npgap(_7240,_7284,_7267,_7269).

np0_accept(_7240,_7243::_7244,[np0_accept,_7294,!,_7333],_7277,_7279) --> 
    np0(_7240,_7243::_7244,_7294,_7277,_7313),
    !,
    accept(_7333,_7313,_7279).

np00(_7240,_7253:_7240,_7244::exists(_7253:_7240)::_7253 isa _7240 and _7244,[np00,[]],_7285,_7285) --> 
    [].

raise_object00(_7240,_7243::_7243 and _7240,[raise_object00,[]],_7268,_7268) --> 
    [].

subject(_7240,_7241,[subject,_7325,_7354,_7383,_7412],_7308,_7310) --> 
    not_look_ahead(w(name('være',n,_7261)),_7325,_7308,_7342),
    not_look_ahead(w(name(norwegian,n,language)),_7354,_7342,_7371),
    not_look_ahead_lit([meg,deg,ham,henne,seg,oss,dem,det],_7383,_7371,_7400),
    np(_7240,_7241,_7412,_7400,_7310).

object1(_7240,_7241,[object1,_7300,_7329,!],_7283,_7285) --> 
    not_look_ahead_lit([jeg,du,han,hun,vi],_7300,_7283,_7317),
    np0(_7240,_7241,_7329,_7317,_7285),
    !.

object(_7240,_7241,[object,_7285,_7309],_7268,_7270) --> 
    not_look_ahead_subject(_7285,_7268,_7300),
    noun_phrase_accept(_7240,_7241,_7309,_7300,_7270).

ind_object(_7240,_7241,[ind_object,_7285,_7309],_7268,_7270) --> 
    not_look_ahead_subject(_7285,_7268,_7300),
    noun_phrase_accept(_7240,_7241,_7309,_7300,_7270).

not_look_ahead_time([not_look_ahead_time,_7272,!,_7301],_7261,_7263) --> 
    look_ahead_time(_7272,_7261,_7287),
    !,
    reject(_7301,_7287,_7263).

look_ahead_time([look_ahead_time,_7271],_7260,_7262) --> 
    w(nb(_7242,_7243),_7271,_7260,_7262).

look_ahead_time([look_ahead_time,_7272],_7261,_7263) --> 
    one_of_lit([halv,kvart],_7272,_7261,_7263).

look_ahead_time([look_ahead_time,_7284,{},!],_7273,_7275) --> 
    w(noun(_7248,_7249,_7250,_7251),_7284,_7273,_7275),
    {user:subclass0(_7248,time)},
    !.

not_look_ahead_subject([not_look_ahead_subject,_7272,!,_7301],_7261,_7263) --> 
    look_ahead_subject(_7272,_7261,_7287),
    !,
    reject(_7301,_7287,_7263).

not_look_ahead_subject([not_look_ahead_subject,[]],_7255,_7255) --> 
    [].

look_ahead_subject([look_ahead_subject,_7280],_7269,_7271) --> 
    look_ahead_lit([jeg,du,han,hun,vi,man],_7280,_7269,_7271).

subject2(_7240,_7241,_7242,[subject2,_7295,!,_7339],_7275,_7277) --> 
    noun_phrase2(_7240,_7241,_7242,_7295,_7275,_7316),
    !,
    accept(_7339,_7316,_7277).

object2hnn(_7240,_7241,_7242,[object2hnn,_7325,_7354,_7383,_7412,!,_7446],_7305,_7307) --> 
    w(name(_7261,_7262,_7263),_7325,_7305,_7342),
    not_look_ahead(w(prep(on)),_7354,_7342,_7371),
    not_look_ahead(w(noun(_7275,_7276,_7277,_7278)),_7383,_7371,_7400),
    not_look_ahead([deg],_7412,_7400,_7429),
    !,
    reject(_7446,_7429,_7307).

object2hnn(_7240,_7241,_7242,[object2hnn,_7295,!,_7339],_7275,_7277) --> 
    object2h(_7240,_7241,_7242,_7295,_7275,_7316),
    !,
    accept(_7339,_7316,_7277).

object2h(_7240,_7241,_7242,[object2h,lit(dere),!,_7309],_7273,_7275) --> 
    cc(dere,_7273,_7303),
    !,
    reject(_7309,_7303,_7275).

object2h(_7240,_7241,_7242,[object2h,_7289],_7269,_7271) --> 
    object2(_7240,_7241,_7242,_7289,_7269,_7271).

object2(_7240,_7241,_7242,[object2,lit(en),lit(gang),!,_7325],_7278,_7280) --> 
    cc(en,_7278,_7308),
    cc(gang,_7308,_7319),
    !,
    reject(_7325,_7319,_7280).

object2(_7240,_7241,_7242,[object2,_7307,_7331,{},!,_7380],_7287,_7289) --> 
    which(_7307,_7287,_7322),
    np(_7241,_7242,_7331,_7322,_7350),
    {user:(\+vartypeid(_7241,place))},
    !,
    accept(_7380,_7350,_7289).

object2(_7240,_7240,_7244::_7244 and _7248,[object2,_7305,_7334,!,_7363],_7285,_7287) --> 
    prep1(around,_7305,_7285,_7322),
    clock(_7334,_7322,_7349),
    !,
    clock_kernel(_7240,_7248,_7363,_7349,_7287).

object2(_7240,_7241,_7244::_7245,[object2,_7302,_7331],_7282,_7284) --> 
    not_look_ahead_lit([middag],_7302,_7282,_7319),
    noun_phrase2(_7240,_7241,_7244::_7245,_7331,_7319,_7284).

object2(_7240,_7241,_7242,[object2,_7308,_7337,!,_7371],_7288,_7290) --> 
    one_of_lit([jeg,du,hun,vi],_7308,_7288,_7325),
    not_look_ahead([som],_7337,_7325,_7354),
    !,
    reject(_7371,_7354,_7290).

noun_phrase2(_7240,_7241,_7244::_7244 and _7248,[noun_phrase2,_7310,!,_7344,_7368],_7290,_7292) --> 
    look_ahead([hvor],_7310,_7290,_7327),
    !,
    accept(_7344,_7327,_7359),
    adverbial_noun_phrase1(_7241,_7244::_7248,_7368,_7359,_7292).

noun_phrase2(_7240,_7240,_7244::_7245,[noun_phrase2,_7304,_7333],_7284,_7286) --> 
    recipron(_7255,_7304,_7284,_7321),
    pushstack(first,npgap(_7240),nil,_7321,_7373),
    noun_phrase1(_7240,_7244::_7245,_7333,_7373,_7286).

noun_phrase2(_7240,_7241,_7244::findalt(diff,_7240,_7241)::_7250 and _7244,[noun_phrase2,_7316,_7340,_7394],_7296,_7298) --> 
    another(_7316,_7296,_7331),
    noun(_7268,sin,u,n,_7241,_7265,_7340,_7331,_7367),
    noun_modsx0(0,_7241,_7265,_7250,_7394,_7367,_7298).

noun_phrase2(_7240,_7241,_7242,[noun_phrase2,_7319,_7348,_7377,!,_7411],_7299,_7301) --> 
    not_look_ahead(w(noun(_7260,_7261,_7262,_7263)),_7319,_7299,_7336),
    not_look_ahead(w(adj2(_7269,_7270)),_7348,_7336,_7365),
    w(verb(_7274,past,part),_7377,_7365,_7394),
    !,
    reject(_7411,_7394,_7301).

noun_phrase2(_7240,_7241,_7242,[noun_phrase2,_7298,!,_7332],_7278,_7280) --> 
    look_ahead([hva],_7298,_7278,_7315),
    !,
    np(_7241,_7242,_7332,_7315,_7280).

noun_phrase2(_7240,_7241,_7242,[noun_phrase2,_7298,_7327,_7351],_7278,_7280) --> 
    not_look_ahead([hva],_7298,_7278,_7315),
    which0(_7327,_7315,_7342),
    np(_7241,_7242,_7351,_7342,_7280).

adverbial_noun_phrase1(_7240,_7243::_7243 and _7247,[adverbial_noun_phrase1,lit(hvor),_7350,_7379,!,_7445],_7322,_7324) --> 
    cc(hvor,_7322,_7349),
    not_look_ahead([mye],_7350,_7349,_7367),
    lock(exact,_7367,_7399),pushstack(exact,(w(prep(in)),w(noun(place,sin,u,n))),nil,_7399,_7405),adverbial1(_7264,_7240,_7268::_7269,_7379,_7405,_7394),unlock(_7394,_7395),
    !,
    lock(last,_7395,_7497),
    pushstack(last,adverbial1(_7264,_7240,_7268::_7269),nil,_7497,_7503),
    statreal(_7247,_7445,_7503,_7492),
    unlock(_7492,_7324).

noun_phrase_accept(_7240,_7241,[noun_phrase_accept,_7288,!,_7327],_7271,_7273) --> 
    np(_7240,_7241,_7288,_7271,_7307),
    !,
    accept(_7327,_7307,_7273).

np1_accept(_7240,_7241,[np1_accept,_7288,!,_7327],_7271,_7273) --> 
    noun_phrase1(_7240,_7241,_7288,_7271,_7307),
    !,
    accept(_7327,_7307,_7273).

noun_phrases2(_7240,_7243::_7246 and _7247,[noun_phrases2,_7319,_7353,_7377,{},!,_7426],_7302,_7304) --> 
    np1_accept(_7264,_7243::_7246,_7319,_7302,_7338),
    and0(_7353,_7338,_7368),
    np1_accept(_7270,_7243::_7247,_7377,_7368,_7396),
    {user:latin(and,_7264,_7270,_7240)},
    !,
    accept(_7426,_7396,_7304).

noun_phrases(_7240,_7243::_7246 and _7249 and _7250,[noun_phrases,_7358,_7387,{},{},_7441,_7475,{},!,_7524],_7341,_7343) --> 
    look_ahead(w(noun(distance,sin,def,n)),_7358,_7341,_7375),
    noun_phrase1(_7285,_7243::_7246,_7387,_7375,_7406),
    {user:vartypeid(_7285,_7294)},
    {user:testmember(_7294,[distance])},
    noun_phrase1(_7303,_7243::_7249,_7441,_7406,_7460),
    noun_phrase1(_7309,_7243::_7250,_7475,_7460,_7494),
    {user:latin(and,_7303,_7309,_7240)},
    !,
    accept(_7524,_7494,_7343).

noun_phrases(_7240,_7243::_7244,[noun_phrases,_7305,_7339,!,_7388],_7288,_7290) --> 
    noun_phrase1(_7255,_7243::_7259,_7305,_7288,_7324),
    noun_phrases0(_7255,_7240,true::_7259,_7244,_7339,_7324,_7362),
    !,
    accept(_7388,_7362,_7290).

noun_phrases0(_7240,_7240,_7245::_7243,_7243,[noun_phrases0,{},!],_7279,_7279) --> 
    {user:constrain(_7240,number)},
    !.

noun_phrases0(_7240,_7240,_7245::_7243,_7243,[noun_phrases0,_7304,!],_7281,_7283) --> 
    look_ahead(w(nb(_7255,_7256)),_7304,_7281,_7283),
    !.

noun_phrases0(_7240,_7240,_7245::_7243,_7243,[noun_phrases0,_7303,!],_7280,_7282) --> 
    look_ahead_lit([etc,samme],_7303,_7280,_7282),
    !.

noun_phrases0(_7240,_7240,_7245::_7243,_7243,[noun_phrases0,_7317,{},!],_7294,_7296) --> 
    look_ahead(w(verb(_7258,inf,fin)),_7317,_7294,_7296),
    {user:testmember(_7258,[be,use])},
    !.

noun_phrases0(_7240,_7240,_7245::_7243,_7243,[noun_phrases0,_7317,{},!],_7294,_7296) --> 
    look_ahead(w(verb(_7258,pres,fin)),_7317,_7294,_7296),
    {user:testmember(_7258,[wish,want])},
    !.

noun_phrases0(_7240,_7241,_7248::_7245,_7245 and _7246,[noun_phrases0,_7346,_7375,_7404,_7433,_7467,{}],_7323,_7325) --> 
    not_look_ahead([','],_7346,_7323,_7363),
    np_conjunction(_7268,_7375,_7363,_7392),
    not_look_ahead(w(noun(_7283,sin,def,n)),_7404,_7392,_7421),
    noun_phrase1(_7288,_7248::_7292,_7433,_7421,_7452),
    noun_phrases20(_7288,_7270,_7248,_7292,_7246,_7467,_7452,_7325),
    {user:latin(_7268,_7240,_7270,_7241)}.

noun_phrases0(_7240,_7241,_7248::_7245,_7245 and _7246,[noun_phrases0,{},_7342,_7376,{}],_7309,_7311) --> 
    {user:(\+vartypeid(_7240,savant))},
    noun_phrase1(_7274,_7248::_7278,_7342,_7309,_7361),
    noun_phrases10(_7274,_7264,_7248,_7278,_7246,_7376,_7361,_7311),
    {user:latin(and,_7240,_7264,_7241)}.

noun_phrases0(_7240,_7240,_7245::_7243,_7243,[noun_phrases0,[]],_7271,_7271) --> 
    [].

noun_phrases10(_7240,_7241,_7242,_7243,_7243 and _7247,[noun_phrases10,_7335,_7364,_7398,{},lit(etc)],_7309,_7311) --> 
    andor(_7263,_7335,_7309,_7352),
    noun_phrase1(_7265,_7242::_7269,_7364,_7352,_7383),
    noun_phrases20(_7265,_7272,_7242,_7269,_7247,_7398,_7383,_7423),
    {user:latin(_7263,_7240,_7272,_7241)},
    cc(etc,_7423,_7311).

noun_phrases10(_7240,_7241,_7242,_7243,_7243 and _7247,[noun_phrases10,_7335,_7364,_7398,{}],_7309,_7311) --> 
    not_look_ahead(w(nb(_7269,_7270)),_7335,_7309,_7352),
    noun_phrase1(_7272,_7242::_7276,_7364,_7352,_7383),
    noun_phrases10(_7272,_7262,_7242,_7276,_7247,_7398,_7383,_7311),
    {user:latin(and,_7240,_7262,_7241)}.

noun_phrases10(_7240,_7240,_7242,_7243,_7243,[noun_phrases10,lit(etc)],_7273,_7275) --> 
    cc(etc,_7273,_7275).

noun_phrases20(_7240,_7241,_7242,_7243,_7243 and _7247,[noun_phrases20,_7330,_7359,_7393,{}],_7304,_7306) --> 
    andor(_7260,_7330,_7304,_7347),
    noun_phrase1(_7267,_7242::_7271,_7359,_7347,_7378),
    noun_phrases20(_7267,_7262,_7242,_7271,_7247,_7393,_7378,_7306),
    {user:latin(_7260,_7240,_7262,_7241)}.

noun_phrases20(_7240,_7240,_7242,_7243,_7243,[noun_phrases20,[]],_7271,_7271) --> 
    [].

no_phrases(_7240,_7241,[no_phrases,{},!,_7311],_7279,_7281) --> 
    {user:value(teleflag,true)},
    !,
    np(_7240,true::_7241,_7311,_7279,_7281).

no_phrases(_7240,_7241,[no_phrases,_7288,_7312],_7271,_7273) --> 
    the0(_7288,_7271,_7303),
    np(_7240,true::_7241,_7312,_7303,_7273).

no_phrase(_7240,_7241,[no_phrase,_7288,_7312],_7271,_7273) --> 
    the0(_7288,_7271,_7303),
    noun_phrase1(_7240,true::_7241,_7312,_7303,_7273).

noun_phrase1(_7240,_7241,[noun_phrase1,lit(og),!,_7303],_7270,_7272) --> 
    cc(og,_7270,_7297),
    !,
    reject(_7303,_7297,_7272).

noun_phrase1(_7240,_7241,[noun_phrase1,_7282],_7265,_7267) --> 
    np2(_7240,_7241,_7282,_7265,_7267).

noun_phrase1(_7240,_7241,[noun_phrase1,_7282],_7265,_7267) --> 
    np1(_7240,_7241,_7282,_7265,_7267).

noun_phrase1(_7240,_7241,[noun_phrase1,_7309,_7338,_7367,_7396,_7420],_7292,_7294) --> 
    one_of_lit([noen,mange],_7309,_7292,_7326),
    not_look_ahead([som],_7338,_7326,_7355),
    not_look_ahead([av],_7367,_7355,_7384),
    not_look_ahead_np(_7396,_7384,_7411),
    np00(agent,_7240,_7241,_7420,_7411,_7294).

noun_phrase1(_7240,_7241,[noun_phrase1,_7306,_7335,_7364,_7388],_7289,_7291) --> 
    one_of_lit([den,det],_7306,_7289,_7323),
    not_look_ahead(w(verb(_7266,_7267,pass)),_7335,_7323,_7352),
    not_look_ahead_np(_7364,_7352,_7379),
    np00(thing,_7240,_7241,_7388,_7379,_7291).

noun_phrase1(_7240,_7243::_7244,[noun_phrase1,_7346,_7375,_7404,_7438,_7467,!,_7501,_7525],_7329,_7331) --> 
    not_look_ahead([de],_7346,_7329,_7363),
    not_look_ahead([det],_7375,_7363,_7392),
    quant_pron(some,_7275,_7404,_7392,_7423),
    not_look_ahead([som],_7438,_7423,_7455),
    not_look_ahead(w(noun(_7299,_7300,_7301,_7302)),_7467,_7455,_7484),
    !,
    accept(_7501,_7484,_7516),
    lock(exact,_7516,_7575),
    pushstack(exact,(some,w(noun(_7275,sin,u,n))),nil,_7575,_7581),
    np1(_7240,_7243::_7244,_7525,_7581,_7570),
    unlock(_7570,_7331).

noun_phrase1(_7240,_7241,[noun_phrase1,_7338,_7367,_7401,_7430,!,_7464,_7488],_7321,_7323) --> 
    not_look_ahead([de],_7338,_7321,_7355),
    quant_pron(every,thing,_7367,_7355,_7386),
    not_look_ahead(w(noun(_7285,_7286,_7287,_7288)),_7401,_7386,_7418),
    not_look_ahead(w(adj2(_7294,_7295)),_7430,_7418,_7447),
    !,
    accept(_7464,_7447,_7479),
    pushstack(first,([alle],w(noun(thing,sin,u,n))),nil,_7479,_7498),
    np1(_7240,_7241,_7488,_7498,_7323).

noun_phrase1(_7240,_7241,[noun_phrase1,_7282],_7265,_7267) --> 
    npa(_7240,_7241,_7282,_7265,_7267).

noun_phrase1(_7240,_7243::_7244,[noun_phrase1,_7307,_7341],_7290,_7292) --> 
    quant_pron(much,_7257,_7307,_7290,_7326),
    lock(exact,_7326,_7391),
    pushstack(exact,(much,w(noun(_7257,sin,u,n))),nil,_7391,_7397),
    np1(_7240,_7243::_7244,_7341,_7397,_7386),
    unlock(_7386,_7292).

noun_phrase1(_7240,_7243::_7244,[noun_phrase1,_7307,_7341],_7290,_7292) --> 
    quant_pron(little,_7257,_7307,_7290,_7326),
    lock(exact,_7326,_7391),
    pushstack(exact,(little,w(noun(_7257,sin,u,n))),nil,_7391,_7397),
    np1(_7240,_7243::_7244,_7341,_7397,_7386),
    unlock(_7386,_7292).

noun_phrase1(_7240,_7243::not _7246,[noun_phrase1,_7309,_7343],_7292,_7294) --> 
    quant_pron(no,_7259,_7309,_7292,_7328),
    lock(exact,_7328,_7393),
    pushstack(exact,(every,w(noun(_7259,sin,u,n))),nil,_7393,_7399),
    np1(_7240,_7243::_7246,_7343,_7399,_7388),
    unlock(_7388,_7294).

noun_phrase1(_7240,_7241,[noun_phrase1,_7282],_7265,_7267) --> 
    xnp(_7240,_7241,_7282,_7265,_7267).

noun_phrase1(_7240,_7243::_7243,[noun_phrase1,_7284],_7267,_7269) --> 
    npgap(_7240,_7284,_7267,_7269).

specific_phrase(_7240,_7241,[specific_phrase,_7291,!,_7325],_7274,_7276) --> 
    w(name(_7251,gen,_7253),_7291,_7274,_7308),
    !,
    reject(_7325,_7308,_7276).

specific_phrase(_7240,_7241,[specific_phrase,_7294,_7323,!,_7352],_7277,_7279) --> 
    w(name(_7254,_7255,_7256),_7294,_7277,_7311),
    sin(_7323,_7311,_7338),
    !,
    reject(_7352,_7338,_7279).

specific_phrase(_7240,_7243::_7244,[specific_phrase,_7288],_7271,_7273) --> 
    sp1(_7240,_7243::_7244,_7288,_7271,_7273).

sp1(_7252:_7253,_7243::findpron(_7252:_7253)::_7252 isa _7261 and _7243,[sp1,_7309,{}],_7292,_7294) --> 
    pronoun(_7261,_7309,_7292,_7294),
    {user:type(_7261,_7253)}.

sp1(_7240,_7241,[sp1,_7295,_7334],_7278,_7280) --> 
    name_phrase(name,_7240,_7241,_7295,_7278,_7316),
    not_look_ahead(w(noun(_7250,_7251,_7252,_7253)),_7334,_7316,_7280).

np0(_7240,_7241,[np0,lit(mye),_7328,_7352,_7381,!,_7447],_7300,_7302) --> 
    cc(mye,_7300,_7327),
    not_look_ahead_np(_7328,_7327,_7343),
    not_look_ahead(w(adj(_7264,_7265)),_7352,_7343,_7369),
    lock(exact,_7369,_7401),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7401,_7407),np_kernel(0,_7240,_7241,_7381,_7407,_7396),unlock(_7396,_7397),
    !,
    accept(_7447,_7397,_7302).

np0(_7240,_7243::_7244,[np0,_7295,!,_7339],_7278,_7280) --> 
    np_head1(_7252,_7240,_7243::_7244,_7295,_7278,_7316),
    !,
    accept(_7339,_7316,_7280).

np0(_7240,_7243::_7244,[np0,_7292,_7316],_7275,_7277) --> 
    the10(_7292,_7275,_7307),
    aname_phrase(_7249,_7240,_7243::_7244,_7316,_7307,_7277).

np0(_7240,_7243::_7244,[np0,_7289],_7272,_7274) --> 
    np_kernel(_7246,_7240,_7243::_7244,_7289,_7272,_7274).

np0(_7240,_7243::_7244,[np0,_7288],_7271,_7273) --> 
    npa(_7240,_7243::_7244,_7288,_7271,_7273).

np0(_7240,_7243::_7243,[np0,_7284],_7267,_7269) --> 
    npgap(_7240,_7284,_7267,_7269).

obvious_object(_7240,_7241,[obvious_object,lit(det),_7309,!,_7343],_7281,_7283) --> 
    cc(det,_7281,_7308),
    not_look_ahead(w(verb(_7258,_7259,pass)),_7309,_7308,_7326),
    !,
    reject(_7343,_7326,_7283).

obvious_object(_7240,_7241,[obvious_object,_7292,_7321,!],_7275,_7277) --> 
    look_ahead([alt],_7292,_7275,_7309),
    np1_accept(_7240,_7241,_7321,_7309,_7277),
    !.

obvious_object(_7240,_7241,[obvious_object,_7289,_7318],_7272,_7274) --> 
    not_look_ahead([noen],_7289,_7272,_7306),
    np0_accept(_7240,_7241,_7318,_7306,_7274).

np1(_7240,_7243::_7243 and _7247,[np1,_7351,lit(det),_7386,lit('å'),!,_7431,!,_7479],_7334,_7336) --> 
    hvormye(_7351,_7334,_7366),
    cc(det,_7366,_7385),
    w(verb(_7285,_7286,fin),_7386,_7385,_7403),
    cc('å',_7403,_7425),
    !,
    pushstack(first,([noen],[vil]),nil,_7425,_7444),clausal_object1(_7299,_7300,_7431,_7444,_7459),
    !,
    lock(exact,_7459,_7557),
    pushstack(exact,(xnp(_7299,_7300),w(verb(_7285,_7286,fin)),npgap(_7240)),nil,_7557,_7563),
    statreal1(_7247,_7479,_7563,_7552),
    unlock(_7552,_7336).

np1(_7240,_7241,[np1,lit(noe),_7329,!,_7363,_7424],_7301,_7303) --> 
    cc(noe,_7301,_7328),
    look_ahead(w(prep(_7266)),_7329,_7328,_7346),
    !,
    lock(exact,_7346,_7383),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7383,_7389),np_kernel(0,_7240,_7257,_7363,_7389,_7378),unlock(_7378,_7379),
    noun_modifiers0(0,_7240,_7257,_7241,_7424,_7379,_7303).

np1(_7240,_7241,[np1,_7385,_7409,_7438,_7467,{},!,_7511,_7535,_7596],_7368,_7370) --> 
    a(_7385,_7368,_7400),
    w(noun(_7284,sin,u,n),_7409,_7400,_7426),
    w(name(_7278,n,_7280),_7438,_7426,_7455),
    w(noun(_7297,sin,u,n),_7467,_7455,_7484),
    {user:(\+testmember(_7297,[minute,hour,direction,home,station]))},
    !,
    accept(_7511,_7484,_7526),
    lock(exact,_7526,_7555),pushstack(exact,w(noun(_7297,sin,u,n)),nil,_7555,_7561),np_kernel(_7329,_7240,_7331,_7535,_7561,_7550),unlock(_7550,_7551),
    lock(exact,_7551,_7613),
    pushstack(exact,(w(prep(with)),w(noun(_7284,sin,u,n)),w(name(_7278,n,_7280))),nil,_7613,_7619),
    noun_modifiers0(0,_7240,_7331,_7241,_7596,_7619,_7608),
    unlock(_7608,_7370).

np1(_7240,_7241,[np1,lit(hvem),_7328,!,_7362,_7401],_7300,_7302) --> 
    cc(hvem,_7300,_7327),
    look_ahead_lit([man,jeg,du,vi],_7328,_7327,_7345),
    !,
    np00(agent,_7240,_7274,_7362,_7345,_7383),
    pushstack(first,relpron(agent),nil,_7383,_7444),
    noun_modifiers0(0,_7240,_7274,_7241,_7401,_7444,_7302).

np1(_7240,_7241,[np1,lit(hvem),lit(som),!,_7336,_7375],_7292,_7294) --> 
    cc(hvem,_7292,_7319),
    cc(som,_7319,_7330),
    !,
    np00(agent,_7240,_7266,_7336,_7330,_7357),
    pushstack(first,relpron(agent),nil,_7357,_7415),
    noun_modifiers0(0,_7240,_7266,_7241,_7375,_7415,_7294).

np1(_7240,_7241,[np1,_7315,_7339,!,_7368,_7429],_7298,_7300) --> 
    hvormye(_7315,_7298,_7330),
    dette(_7339,_7330,_7354),
    !,
    lock(exact,_7354,_7388),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7388,_7394),np_kernel(0,_7240,_7272,_7368,_7394,_7383),unlock(_7383,_7384),
    pushstack(first,relpron(thing),nil,_7384,_7470),
    noun_modifiers0(0,_7240,_7272,_7241,_7429,_7470,_7300).

np1(_7240,_7241,[np1,lit(hva),lit(som),!,_7336,_7375],_7292,_7294) --> 
    cc(hva,_7292,_7319),
    cc(som,_7319,_7330),
    !,
    np00(thing,_7240,_7266,_7336,_7330,_7357),
    pushstack(first,relpron(thing),nil,_7357,_7415),
    noun_modifiers0(0,_7240,_7266,_7241,_7375,_7415,_7294).

np1(_7240,_7241,[np1,lit(hva),_7328,!,_7357,_7418],_7300,_7302) --> 
    cc(hva,_7300,_7327),
    look_ahead_np(_7328,_7327,_7343),
    !,
    lock(exact,_7343,_7377),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7377,_7383),np_kernel(0,_7240,_7274,_7357,_7383,_7372),unlock(_7372,_7373),
    pushstack(first,relpron(thing),nil,_7373,_7458),
    noun_modifiers0(0,_7240,_7274,_7241,_7418,_7458,_7302).

np1(_7240,_7241,[np1,lit(de),_7324,_7353,!,_7387],_7296,_7298) --> 
    cc(de,_7296,_7323),
    not_look_ahead(w(nb(_7265,_7266)),_7324,_7323,_7341),
    look_ahead(w(noun(_7272,sin,_7274,_7275)),_7353,_7341,_7370),
    !,
    np00(agent,_7240,_7241,_7387,_7370,_7298).

np1(_7240,_7241,[np1,_7343,!,_7372,lit('å'),_7417,!,_7451,_7512],_7326,_7328) --> 
    noemed(_7343,_7326,_7358),
    !,
    np0_accept(_7270,_7271,_7372,_7358,_7391),
    cc('å',_7391,_7416),
    w(verb(do1,inf,fin),_7417,_7416,_7434),
    !,
    lock(exact,_7434,_7471),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7471,_7477),np_kernel(_7294,_7240,_7296,_7451,_7477,_7466),unlock(_7466,_7467),
    pushstack(first,(w(prep(with)),xnp(_7270,_7271)),nil,_7467,_7553),
    noun_modifiers0(_7294,_7240,_7296,_7241,_7512,_7553,_7328).

noemed([noemed,lit(noe),lit(med)],_7262,_7264) --> 
    cc(noe,_7262,_7283),
    cc(med,_7283,_7264).

np1(_7240,_7241,[np1,_7317,!,_7346,_7407],_7300,_7302) --> 
    'noeå'(_7317,_7300,_7332),
    !,
    lock(exact,_7332,_7366),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7366,_7372),np_kernel(0,_7240,_7272,_7346,_7372,_7361),unlock(_7361,_7362),
    pushstack(first,([som],[jeg]),nil,_7362,_7417),
    noun_modifiers0(0,_7240,_7272,_7241,_7407,_7417,_7302).

'noeå'(['noeå',lit(noe),lit('å')],_7262,_7264) --> 
    cc(noe,_7262,_7283),
    cc('å',_7283,_7264).

np1(_7240,_7241,[np1,_7312,!,_7341,_7402],_7295,_7297) --> 
    noesom(_7312,_7295,_7327),
    !,
    lock(exact,_7327,_7361),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7361,_7367),np_kernel(0,_7240,_7269,_7341,_7367,_7356),unlock(_7356,_7357),
    pushstack(first,[som],nil,_7357,_7412),
    noun_modifiers0(0,_7240,_7269,_7241,_7402,_7412,_7297).

noesom([noesom,lit(det),_7292],_7270,_7272) --> 
    cc(det,_7270,_7291),
    look_ahead_lit([man,jeg,du,vi],_7292,_7291,_7272).

noesom([noesom,lit(det),lit(som)],_7262,_7264) --> 
    cc(det,_7262,_7283),
    cc(som,_7283,_7264).

noesom([noesom,lit(noe),lit(som)],_7262,_7264) --> 
    cc(noe,_7262,_7283),
    cc(som,_7283,_7264).

noesom([noesom,lit(noe),_7292],_7270,_7272) --> 
    cc(noe,_7270,_7291),
    look_ahead_lit([jeg,du,han,hun],_7292,_7291,_7272).

noesom([noesom,lit(hva),lit(som)],_7262,_7264) --> 
    cc(hva,_7262,_7283),
    cc(som,_7283,_7264).

noesom([noesom,lit(det),_7291,!],_7269,_7271) --> 
    cc(det,_7269,_7290),
    look_ahead_lit([jeg,du],_7291,_7290,_7271),
    !.

np1(_7240,_7241,[np1,lit(det),_7322,!,_7356,_7395],_7294,_7296) --> 
    cc(det,_7294,_7321),
    look_ahead([de],_7322,_7321,_7339),
    !,
    np00(agent,_7240,_7268,_7356,_7339,_7377),
    pushstack(first,[som],nil,_7377,_7405),
    noun_modifiers0(0,_7240,_7268,_7241,_7395,_7405,_7296).

np1(_7240,_7241,[np1,lit(noen),_7322,!,_7356,_7395],_7294,_7296) --> 
    cc(noen,_7294,_7321),
    look_ahead([de],_7322,_7321,_7339),
    !,
    np00(agent,_7240,_7268,_7356,_7339,_7377),
    pushstack(first,[som],nil,_7377,_7405),
    noun_modifiers0(0,_7240,_7268,_7241,_7395,_7405,_7296).

np1(_7240,_7241,[np1,lit(hvilke),_7325,_7364,_7393,!,_7422],_7297,_7299) --> 
    cc(hvilke,_7297,_7324),
    np_kernel(_7265,_7240,_7267,_7325,_7324,_7346),
    not_look_ahead([som],_7364,_7346,_7381),
    look_ahead_np(_7393,_7381,_7408),
    !,
    pushstack(first,[som],nil,_7408,_7432),
    noun_modifiers0(_7265,_7240,_7267,_7241,_7422,_7432,_7299).

np1(_7240,_7241,[np1,lit(hvilke),_7317,_7356,!,_7390],_7289,_7291) --> 
    cc(hvilke,_7289,_7316),
    np_kernel(_7255,_7240,_7257,_7317,_7316,_7338),
    look_ahead([som],_7356,_7338,_7373),
    !,
    noun_modifiers0(_7255,_7240,_7257,_7241,_7390,_7373,_7291).

np1(_7240,_7241,[np1,{},lit(de),_7399,_7428,_7457,_7486,!,_7520,[],_7558,_7606],_7361,_7363) --> 
    {user:value(busflag,true)},
    cc(de,_7361,_7398),
    w(nb(_7287,num),_7399,_7398,_7416),
    flnp(_7290,_7428,_7416,_7445),
    not_look_ahead(w(noun(_7296,_7297,_7298,_7299)),_7457,_7445,_7474),
    w(prep(_7303),_7486,_7474,_7503),
    !,
    accept(_7520,_7503,_7535),
    pushstack(free,w(prep(_7303)),nil,_7535,_7557),[],
    pushstack(first,(w(nb(_7287,num)),w(adj2(_7290,nil)),w(noun(vehicle,sin,u,n))),nil,_7557,_7571),np_kernel(_7273,_7240,_7275,_7558,_7571,_7588),
    noun_modifiers0(_7273,_7240,_7275,_7241,_7606,_7588,_7363).

np1(_7240,_7243::_7244,[np1,_7294,!,_7333],_7277,_7279) --> 
    obviousclock(_7240,_7243::_7244,_7294,_7277,_7313),
    !,
    accept(_7333,_7313,_7279).

np1(_7240,_7241,[np1,{},lit(en),_7376,{},_7415,!,_7449,_7473,_7521],_7338,_7340) --> 
    {user:value(busflag,true)},
    cc(en,_7338,_7375),
    w(nb(_7281,num),_7376,_7375,_7393),
    {user:plausible_busno(_7281)},
    not_look_ahead(w(noun(_7292,_7293,_7294,_7295)),_7415,_7393,_7432),
    !,
    accept(_7449,_7432,_7464),
    pushstack(first,(w(noun(vehicle,sin,u,n)),w(nb(_7281,num))),nil,_7464,_7486),np_kernel(_7267,_7240,_7269,_7473,_7486,_7503),
    noun_modifiers0(_7267,_7240,_7269,_7241,_7521,_7503,_7340).

np1(_7240,_7243::_7244,[np1,_7303,_7342],_7286,_7288) --> 
    np_kernel(_7249,_7240,_7261::_7262,_7303,_7286,_7324),
    noun_modifiers0(_7249,_7240,_7261::_7262,_7243::_7244,_7342,_7324,_7288).

np_kernel(0,_7253:thing,_7244::findpron(_7253:thing)::_7253 isa thing and _7244,[np_kernel,_7311,_7335,!],_7291,_7293) --> 
    dette(_7311,_7291,_7326),
    not_look_ahead_np(_7335,_7326,_7293),
    !.

np_kernel(0,_7253:agent,_7244::findpron(_7253:agent)::_7253 isa agent and _7244,[np_kernel,lit(de),_7352,_7381,_7410,!],_7321,_7323) --> 
    cc(de,_7321,_7351),
    not_look_ahead(w(nb(_7282,_7283)),_7352,_7351,_7369),
    not_look_ahead(w(adj2(_7289,_7290)),_7381,_7369,_7398),
    look_ahead(w(verb(_7296,pres,fin)),_7410,_7398,_7323),
    !.

np_kernel(0,_7241,_7244::_7245,[np_kernel,_7300,!,_7339],_7280,_7282) --> 
    obviousdate(_7241,_7244::_7245,_7300,_7280,_7319),
    !,
    accept(_7339,_7319,_7282).

np_kernel(0,_7253:thing,_7244::findpron(_7253:thing)::_7253 isa thing and _7244,[np_kernel,lit(en),_7340,!],_7309,_7311) --> 
    cc(en,_7309,_7339),
    look_ahead_lit([jeg,du,han,hun,vi,dere,de],_7340,_7339,_7311),
    !.

np_kernel(name,_7253:_7254,_7244::findpron(_7253:_7254)::_7253 isa _7254 and _7244,[np_kernel,_7323,_7352,!],_7303,_7305) --> 
    not_look_ahead_lit([de,den,det,et],_7323,_7303,_7340),
    pronoun(_7254,_7352,_7340,_7305),
    !.

np_kernel(0,_7253:thing,_7244::exists(_7253:thing)::_7253 isa thing and _7244,[np_kernel,_7323,_7352,!],_7303,_7305) --> 
    one_of_lit([alt,noe],_7323,_7303,_7340),
    look_ahead_lit([som,'å'],_7352,_7340,_7305),
    !.

np_kernel(_7240,_7241,_7244::_7245,[np_kernel,_7295],_7275,_7277) --> 
    np_head1(_7240,_7241,_7244::_7245,_7295,_7275,_7277).

np_kernel(_7240,_7241,_7242,[np_kernel,_7312,_7341,_7370],_7292,_7294) --> 
    look_ahead(w(name(_7258,n,_7260)),_7312,_7292,_7329),
    not_look_ahead(w(noun(_7266,_7267,_7268,_7269)),_7341,_7329,_7358),
    aname_phrase(_7240,_7241,_7242,_7370,_7358,_7294).

np_kernel(_7240,_7241,_7244::_7245,[np_kernel,_7295],_7275,_7277) --> 
    np_head(_7240,_7241,_7244::_7245,_7295,_7275,_7277).

np_kernel(_7240,_7241,_7244::_7245,[np_kernel,_7306,_7335],_7286,_7288) --> 
    not_look_ahead(w(name(_7261,n,_7263)),_7306,_7286,_7323),
    aname_phrase(_7240,_7241,_7244::_7245,_7335,_7323,_7288).

np_head1(_7240,_7241,_7244::_7245,[np_head1,{},_7337,_7386,_7415,{}],_7307,_7309) --> 
    {user:value(teleflag,true)},
    determiner0(_7271,_7240,_7241,_7264,_7244::_7245,_7337,_7307,_7362),
    preadjs0(_7261,_7386,_7362,_7403),
    noun_list2(_7282,_7241,_7263,_7415,_7403,_7309),
    {user:preadjs_template(_7261,_7241,_7263,_7264)}.

np_head1(0,_7247:_7248,_7244::_7245,[np_head1,{},_7376,_7420,_7474,!,{},{},{}],_7346,_7348) --> 
    {user:value(busflag,true)},
    optional([denne],_7376,_7346,_7408),
    bus_head(_7287,_7273,_7289,_7248,_7291,_7247,_7420,_7408,_7447),
    not_look_ahead_lit([sin,sitt,sine],_7474,_7447,_7348),
    !,
    {user:decide_adjective(_7289,_7247,_7306)},
    {user:_7310=(_7247 isa _7248 and _7306)},
    {user:decide_quantifier(_7273,_7247:_7248,_7310 and _7244,_7245)}.

np_head1(0,_7241,_7244::_7245,[np_head1,{},lit(den),_7390,{},_7429,!,_7463,_7487,!,_7553],_7349,_7351) --> 
    {user:value(busflag,true)},
    cc(den,_7349,_7389),
    w(adj2(_7283,nil),_7390,_7389,_7407),
    {user:testmember(_7283,[first,last,next,previous])},
    look_ahead([som],_7429,_7407,_7446),
    !,
    accept(_7463,_7446,_7478),
    lock(exact,_7478,_7507),pushstack(exact,(w(adj2(_7283,nil)),w(noun(vehicle,sin,u,n))),nil,_7507,_7513),np_head(0,_7241,_7244::_7245,_7487,_7513,_7502),unlock(_7502,_7503),
    !,
    accept(_7553,_7503,_7351).

np_head1(0,_7241,_7244::exists(_7241)::_7250 and _7253 and _7244,[np_head1,_7337,_7366,_7395,{},!,_7464],_7317,_7319) --> 
    not_look_ahead([dere],_7337,_7317,_7354),
    w(name(_7279,_7280,_7281),_7366,_7354,_7383),
    noun(_7283,_7284,_7285,n,_7241,_7253,_7395,_7383,_7422),
    {user:adjnamecomp_template(_7279,_7241,_7250)},
    !,
    accept(_7464,_7422,_7319).

bus_head(_7240,_7241,_7242,_7243,_7243,_7245,[bus_head,_7346,_7380,_7414,{},{},_7468,_7502],_7317,_7319) --> 
    traceprint(5,bx01,_7346,_7317,_7365),
    art0(_7240,_7272,_7380,_7365,_7399),
    quantnext(_7241,_7242,_7414,_7399,_7433),
    {user:_7242\==nil},
    {user:_7241=<5},
    busnumber(_7245,_7243,_7468,_7433,_7487),
    traceprint(4,bh01,_7502,_7487,_7319).

bus_head(_7240,_7241,_7242,_7243,_7244,_7245,[bus_head,_7339,_7373,_7407,{},_7451,_7490],_7310,_7312) --> 
    traceprint(5,bx02,_7339,_7310,_7358),
    art0(_7240,_7269,_7373,_7358,_7392),
    quantnext(_7241,_7242,_7407,_7392,_7426),
    {user:_7241=<5},
    busseno(_7245,_7243,_7244,_7451,_7426,_7472),
    traceprint(4,bh02,_7490,_7472,_7312).

bus_head(_7240,_7241,_7242,_7243,_7243,_7245,[bus_head,_7351,_7385,_7419,{},_7463,_7492,_7516,_7550],_7322,_7324) --> 
    traceprint(5,bx03,_7351,_7322,_7370),
    art0(_7240,_7275,_7385,_7370,_7404),
    quantnext(_7241,_7242,_7419,_7404,_7438),
    {user:_7241=<5},
    not_look_ahead(w(nb(_7289,_7290)),_7463,_7438,_7480),
    nr0(_7492,_7480,_7507),
    busnumber(_7245,_7243,_7516,_7507,_7535),
    traceprint(4,bh03,_7550,_7535,_7324).

bus_head(_7240,_7241,_7242,_7243,_7243,_7245,[bus_head,_7360,_7394,_7428,{},_7472,_7501,_7557,!],_7331,_7333) --> 
    traceprint(5,bx04,_7360,_7331,_7379),
    art0(_7240,_7272,_7394,_7379,_7413),
    quantnext(_7241,_7242,_7428,_7413,_7447),
    {user:_7241=<5},
    look_ahead(w(prep(_7286)),_7472,_7447,_7489),
    lock(exact,_7489,_7521),pushstack(exact,w(noun(bus,plu,def,n)),nil,_7521,_7527),busnumber(_7245,_7243,_7501,_7527,_7516),unlock(_7516,_7517),
    traceprint(4,bh04,_7557,_7517,_7333),
    !.

bus_head(_7240,1,_7242,_7243,_7244,_7245,[bus_head,_7340,_7374,_7408,_7437,_7461,_7495,_7539],_7311,_7313) --> 
    traceprint(5,bx05,_7340,_7311,_7359),
    art0(_7240,_7272,_7374,_7359,_7393),
    flnp(_7242,_7408,_7393,_7425),
    nr1(_7437,_7425,_7452),
    busnumber(_7245,_7244,_7461,_7452,_7480),
    busse0(_7244,_7243,_7281,_7282,_7495,_7480,_7518),
    traceprint(4,bh05,_7539,_7518,_7313).

bus_head(_7240,_7241,nil,_7243,_7244,_7245,[bus_head,_7340,_7374,_7408,_7437,_7461,_7495,_7539],_7311,_7313) --> 
    traceprint(5,bx06,_7340,_7311,_7359),
    art0(_7240,_7272,_7374,_7359,_7393),
    quant(_7241,_7408,_7393,_7425),
    nr1(_7437,_7425,_7452),
    busnumber(_7245,_7244,_7461,_7452,_7480),
    busse0(_7244,_7243,_7281,_7282,_7495,_7480,_7518),
    traceprint(4,bh06,_7539,_7518,_7313).

bus_head(_7240,_7241,nil,_7243,_7244,_7245,[bus_head,_7339,_7373,_7407,_7436,_7475,_7499,_7533],_7310,_7312) --> 
    traceprint(5,bx07,_7339,_7310,_7358),
    art0(_7240,_7272,_7373,_7358,_7392),
    quant(_7241,_7407,_7392,_7424),
    busnoun(_7243,_7277,_7278,_7436,_7424,_7457),
    nr0(_7475,_7457,_7490),
    busnumber(_7245,_7244,_7499,_7490,_7518),
    traceprint(4,bh07,_7533,_7518,_7312).

bus_head(_7240,_7241,nil,_7243,_7244,_7245,[bus_head,_7336,_7370,_7404,_7433,_7467,_7506],_7307,_7309) --> 
    traceprint(5,bx08,_7336,_7307,_7355),
    art0(_7240,_7269,_7370,_7355,_7389),
    quant(_7241,_7404,_7389,_7421),
    busnumber(_7245,_7244,_7433,_7421,_7452),
    busnoun(_7243,_7277,_7278,_7467,_7452,_7488),
    traceprint(4,bh08,_7506,_7488,_7309).

bus_head(_7240,1,_7242,_7243,_7244,_7245,[bus_head,_7339,_7373,_7407,_7436,_7460,_7494,_7533],_7310,_7312) --> 
    traceprint(5,bx09,_7339,_7310,_7358),
    art0(_7240,_7272,_7373,_7358,_7392),
    filanepr(_7242,_7407,_7392,_7424),
    nr1(_7436,_7424,_7451),
    busnumber(_7245,_7244,_7460,_7451,_7479),
    busnoun(_7243,_7280,_7281,_7494,_7479,_7515),
    traceprint(4,bh09,_7533,_7515,_7312).

bus_head(_7240,1,_7242,route,_7244,_7245,[bus_head,_7340,_7374,{},_7418,_7447,_7471,_7505],_7311,_7313) --> 
    traceprint(5,bx10,_7340,_7311,_7359),
    art0(_7240,_7272,_7374,_7359,_7393),
    {user:_7272\==plu},
    filanepr(_7242,_7418,_7393,_7435),
    nr1(_7447,_7435,_7462),
    busnumber(_7245,_7244,_7471,_7462,_7490),
    traceprint(4,bh10,_7505,_7490,_7313).

bus_head(_7240,1,_7242,_7243,_7244,_7245,[bus_head,_7362,_7396,{},_7440,_7469,_7508,_7532,_7556,_7590,_7619],_7333,_7335) --> 
    traceprint(5,bx11,_7362,_7333,_7381),
    art0(_7240,_7281,_7396,_7381,_7415),
    {user:_7281\==plu},
    filanepr(_7242,_7440,_7415,_7457),
    busnoun(_7243,_7291,_7292,_7469,_7457,_7490),
    nr0(_7508,_7490,_7523),
    colon0(_7532,_7523,_7547),
    busnumber(_7245,_7244,_7556,_7547,_7575),
    not_look_ahead(w(noun(minute,_7302,_7303,_7304)),_7590,_7575,_7607),
    traceprint(4,bh11,_7619,_7607,_7335).

bus_head(_7240,_7241,_7242,_7243,_7244,_7245,[bus_head,_7345,_7379,_7413,{},_7457,_7496,_7530],_7316,_7318) --> 
    traceprint(5,bx12,_7345,_7316,_7364),
    art0(_7240,_7272,_7379,_7364,_7398),
    quantnext(_7241,_7242,_7413,_7398,_7432),
    {user:_7241<10},
    busnoun(_7243,_7283,plu,_7457,_7432,_7478),
    busnumber(_7245,_7244,_7496,_7478,_7515),
    traceprint(4,bh12,_7530,_7515,_7318).

bus_head(_7240,_7241,_7242,_7243,nil,_7245,[bus_head,_7339,_7373,_7407,{},_7451,_7490],_7310,_7312) --> 
    traceprint(5,bx13,_7339,_7310,_7358),
    art0(_7240,plu,_7373,_7358,_7392),
    quantnext(_7241,_7242,_7407,_7392,_7426),
    {user:_7241<100},
    busnoun(_7243,_7280,_7281,_7451,_7426,_7472),
    traceprint(4,bh13,_7490,_7472,_7312).

bus_head(_7240,_7241,_7242,_7243,nil,_7245,[bus_head,_7339,_7373,_7407,{},_7451,_7490],_7310,_7312) --> 
    traceprint(5,bx14,_7339,_7310,_7358),
    art0(_7240,_7269,_7373,_7358,_7392),
    quantnext(_7241,_7242,_7407,_7392,_7426),
    {user:_7241=<5},
    busnoun(_7243,_7280,plu,_7451,_7426,_7472),
    traceprint(4,bh14,_7490,_7472,_7312).

bus_head(_7240,1,_7242,_7243,_7244,_7245,[bus_head,_7349,_7383,_7417,_7446,{},_7490,_7529],_7320,_7322) --> 
    traceprint(5,bx15,_7349,_7320,_7368),
    art0(_7240,_7272,_7383,_7368,_7402),
    filanepr(_7242,_7417,_7402,_7434),
    busnumber(_7245,_7244,_7446,_7434,_7465),
    {user:(number(_7245),_7245>5)},
    busnoun(_7243,_7290,_7291,_7490,_7465,_7511),
    traceprint(4,bh15,_7529,_7511,_7322).

bus_head(_7240,1,_7242,_7243,_7244,_7245,[bus_head,_7344,_7378,_7412,_7441,{},_7485,_7524],_7315,_7317) --> 
    traceprint(5,bx16,_7344,_7315,_7363),
    art0(_7240,_7272,_7378,_7363,_7397),
    filanepr(_7242,_7412,_7397,_7429),
    busnumber(_7245,_7244,_7441,_7429,_7460),
    {user:_7245\==1},
    busnoun(_7243,_7285,sin,_7485,_7460,_7506),
    traceprint(4,bh16,_7524,_7506,_7317).

bus_head(u,1,nil,bus,number,_7245,[bus_head,_7357,_7391,_7420,{},_7459,_7498],_7328,_7330) --> 
    traceprint(5,bx17,_7357,_7328,_7376),
    not_look_ahead(w(name(_7272,n,route)),_7391,_7376,_7408),
    w(nb(_7245,num),_7420,_7408,_7437),
    {user:(number(_7245),_7245>5,_7245=<9999)},
    busnoun(bus,def,sin,_7459,_7437,_7480),
    traceprint(4,bh17,_7498,_7480,_7330).

bus_head(def,_7241,_7242,route,nil,_7245,[bus_head,_7334,lit(de),_7379,{},_7423,_7447],_7305,_7307) --> 
    traceprint(5,bx18,_7334,_7305,_7353),
    cc(de,_7353,_7378),
    quantnext(_7241,_7242,_7379,_7378,_7398),
    {user:_7241=<5},
    not_look_ahead_np(_7423,_7398,_7438),
    traceprint(4,bh18,_7447,_7438,_7307).

bus_head(_7240,_7241,_7242,route,nil,_7245,[bus_head,_7352,_7386,_7420,{},{},_7474,_7498,!],_7323,_7325) --> 
    traceprint(5,bx19,_7352,_7323,_7371),
    art0(_7240,_7272,_7386,_7371,_7405),
    quantnext(_7241,_7242,_7420,_7405,_7439),
    {user:_7242\==nil},
    {user:(_7241>0,_7241=<5)},
    not_look_ahead_np(_7474,_7439,_7489),
    traceprint(4,bh19,_7498,_7489,_7325),
    !.

bus_head(_7240,1,_7242,_7243,_7244,_7245,[bus_head,_7354,_7388,_7422,_7451,_7490,_7514,_7538,_7572,_7601],_7325,_7327) --> 
    traceprint(5,bx20,_7354,_7325,_7373),
    art0(_7240,_7278,_7388,_7373,_7407),
    filanepr(_7242,_7422,_7407,_7439),
    busnoun(_7243,_7283,sin,_7451,_7439,_7472),
    nr0(_7490,_7472,_7505),
    colon0(_7514,_7505,_7529),
    busnumber(_7245,_7244,_7538,_7529,_7557),
    not_look_ahead(w(noun(minute,_7294,_7295,_7296)),_7572,_7557,_7589),
    traceprint(4,bh20,_7601,_7589,_7327).

art0(u,plu,[art0,lit(noen),_7298,!],_7270,_7272) --> 
    cc(noen,_7270,_7297),
    look_ahead_np(_7298,_7297,_7272),
    !.

art0(u,sin,[art0,lit(noe),!],_7267,_7269) --> 
    cc(noe,_7267,_7269),
    !.

art0(_7240,_7241,[art0,_7285,!],_7268,_7270) --> 
    art(_7240,_7241,_7285,_7268,_7270),
    !.

art0(u,nil,[art0,[]],_7262,_7262) --> 
    [].

art(u,sin,[art,lit(en),!],_7267,_7269) --> 
    cc(en,_7267,_7269),
    !.

art(u,sin,[art,lit(et),!],_7267,_7269) --> 
    cc(et,_7267,_7269),
    !.

art(u,sin,[art,lit(ei),!],_7267,_7269) --> 
    cc(ei,_7267,_7269),
    !.

art(def,sin,[art,lit(den),!],_7267,_7269) --> 
    cc(den,_7267,_7269),
    !.

art(def,plu,[art,lit(det),!],_7267,_7269) --> 
    cc(det,_7267,_7269),
    !.

art(def,plu,[art,lit(de),!],_7267,_7269) --> 
    cc(de,_7267,_7269),
    !.

quantnext(_7240,_7241,[quantnext,_7289,_7318,!],_7272,_7274) --> 
    quant(_7240,_7289,_7272,_7306),
    filanepr(_7241,_7318,_7306,_7274),
    !.

quantnext(_7240,_7241,[quantnext,_7289,_7318,!],_7272,_7274) --> 
    filanepr(_7241,_7289,_7272,_7306),
    quant(_7240,_7318,_7306,_7274),
    !.

quant00(1,[quant00,[]],_7259,_7259) --> 
    [].

quant(_7240,[quant,_7278],_7264,_7266) --> 
    w(nb(_7240,num),_7278,_7264,_7266).

filanepr(_7240,[filanepr,_7278,!],_7264,_7266) --> 
    flnp(_7240,_7278,_7264,_7266),
    !.

filanepr(nil,[filanepr,[]],_7259,_7259) --> 
    [].

busseno(_7240,_7241,_7242,[busseno,_7304,_7343,_7367,_7391,!],_7284,_7286) --> 
    busnoun(_7241,_7257,_7258,_7304,_7284,_7325),
    nr0(_7343,_7325,_7358),
    colon0(_7367,_7358,_7382),
    busnumber(_7240,_7242,_7391,_7382,_7286),
    !.

busseno(_7240,_7241,_7242,[busseno,_7301,_7325,_7359,!],_7281,_7283) --> 
    nr0(_7301,_7281,_7316),
    busnumber(_7240,_7242,_7325,_7316,_7344),
    busnoun(_7241,_7257,_7258,_7359,_7344,_7283),
    !.

busnumber(_7240,_7241,[busnumber,_7395,_7439,{},_7478,_7507,_7536,_7560,_7589,_7618,_7647,_7676,_7705],_7378,_7380) --> 
    optional(w(noun(route,sin,u,n)),_7395,_7378,_7427),
    w(name(_7240,n,_7241),_7439,_7427,_7456),
    {user:test(subclass0(_7241,vehicle))},
    not_look_ahead(w(noun(minute,_7311,_7312,_7313)),_7478,_7456,_7495),
    not_look_ahead([:],_7507,_7495,_7524),
    point0(_7536,_7524,_7551),
    not_look_ahead(w(name(_7323,_7324,month)),_7560,_7551,_7577),
    not_look_ahead(w(name(_7323,_7332,day)),_7589,_7577,_7606),
    not_look_ahead(w(name(whitsun_day,_7340,date)),_7618,_7606,_7635),
    not_look_ahead(w(name(christmas_day,_7348,date)),_7647,_7635,_7664),
    not_look_ahead(w(name(easterday,_7356,date)),_7676,_7664,_7693),
    not_look_ahead(w(name(new_years_day,_7281,date)),_7705,_7693,_7380).

busnumber(_7240,number,[busnumber,_7384,_7428,_7457,_7486,_7515,_7539,_7568,_7597,_7626,_7655,_7684],_7367,_7369) --> 
    optional(w(noun(route,sin,u,n)),_7384,_7367,_7416),
    w(nb(_7240,num),_7428,_7416,_7445),
    not_look_ahead(w(noun(minute,_7300,_7301,_7302)),_7457,_7445,_7474),
    not_look_ahead([:],_7486,_7474,_7503),
    point0(_7515,_7503,_7530),
    not_look_ahead(w(name(_7312,_7313,month)),_7539,_7530,_7556),
    not_look_ahead(w(name(_7312,_7321,day)),_7568,_7556,_7585),
    not_look_ahead(w(name(whitsun_day,_7329,date)),_7597,_7585,_7614),
    not_look_ahead(w(name(christmas_day,_7337,date)),_7626,_7614,_7643),
    not_look_ahead(w(name(easterday,_7345,date)),_7655,_7643,_7672),
    not_look_ahead(w(name(new_years_day,_7278,date)),_7684,_7672,_7369).

busse0(_7240,_7241,_7242,_7243,[busse0,_7298,!],_7275,_7277) --> 
    busnoun(_7241,_7242,_7243,_7298,_7275,_7277),
    !.

busse0(_7240,_7240,u,sin,[busse0,[]],_7268,_7268) --> 
    [].

busnoun(_7240,_7241,_7242,[busnoun,_7314,!,{},_7358],_7294,_7296) --> 
    w(noun(_7240,_7242,_7241,n),_7314,_7294,_7331),
    !,
    {user:(test(subclass0(_7240,vehicle));_7240=number)},
    point0(_7358,_7331,_7296).

aname_phrase(0,_7241,_7244::_7244 and _7248,[aname_phrase,_7329,_7353,_7382,_7411,{},!],_7309,_7311) --> 
    a0(_7329,_7309,_7344),
    look_ahead(w(name(_7269,n,_7271)),_7353,_7344,_7370),
    preadjs(_7273,_7382,_7370,_7399),
    noun2(_7275,_7276,n,_7241,_7279,_7411,_7399,_7311),
    {user:preadjs_template(_7273,_7241,_7279,_7248)},
    !.

aname_phrase(_7240,_7241,_7244::_7244 and _7248,[aname_phrase,_7332,_7361,lit(gang),!,_7406,_7430],_7312,_7314) --> 
    w(name(_7270,n,route),_7332,_7312,_7349),
    w(adj2(next,nil),_7361,_7349,_7378),
    cc(gang,_7378,_7400),
    !,
    accept(_7406,_7400,_7421),
    pushstack(first,w(name(_7270,n,route)),nil,_7421,_7440),
    namep(_7240,_7241,_7248,_7430,_7440,_7314).

aname_phrase(_7240,_7241,_7242,[aname_phrase,_7305,_7334,_7363,!,_7392],_7285,_7287) --> 
    number(_7256,_7305,_7285,_7322),
    not_look_ahead(w(prep(from)),_7334,_7322,_7351),
    filanepr(_7363,_7351,_7378),
    !,
    reject(_7392,_7378,_7287).

aname_phrase(_7240,_7241,_7242,[aname_phrase,_7319,_7343,_7367,_7396,{},!,_7440],_7299,_7301) --> 
    dent0(_7319,_7299,_7334),
    filanepr(_7343,_7334,_7358),
    bus_number(_7262,_7367,_7358,_7384),
    w(noun(_7266,plu,_7268,_7269),_7396,_7384,_7413),
    {user:testmember(_7266,[bus])},
    !,
    reject(_7440,_7413,_7301).

aname_phrase(_7240,_7241,_7242,[aname_phrase,_7325,_7349,_7378,_7412,{},!,_7456],_7305,_7307) --> 
    dent0(_7325,_7305,_7340),
    w(adj2(_7264,nil),_7349,_7340,_7366),
    gmem(_7264,[nearest],_7378,_7366,_7397),
    w(name(_7274,_7275,_7276),_7412,_7397,_7429),
    {user:(\+number(_7274))},
    !,
    reject(_7456,_7429,_7307).

aname_phrase(_7240,_7241,_7244::_7245,[aname_phrase,_7327,_7351,_7380,_7409,_7438,{}],_7307,_7309) --> 
    a0(_7327,_7307,_7342),
    preadjs0(_7264,_7351,_7342,_7368),
    not_look_ahead([jeg],_7380,_7368,_7397),
    not_look_ahead([du],_7409,_7397,_7426),
    name_phrase(_7240,_7241,_7244::_7266,_7438,_7426,_7309),
    {user:preadjs_template(_7264,_7241,_7266,_7245)}.

aname_phrase(_7240,_7241,_7244::_7245,[aname_phrase,_7305,_7334,_7358],_7285,_7287) --> 
    not_look_ahead([ett],_7305,_7285,_7322),
    a0(_7334,_7322,_7349),
    name_phrase(_7240,_7241,_7244::_7245,_7358,_7349,_7287).

aname_phrase(name,_7241,_7242,[aname_phrase,_7289],_7269,_7271) --> 
    person_name(_7241,_7242,_7246,_7289,_7269,_7271).

name_phrase(0,_7241,_7244::_7245,[name_phrase,_7383,_7412,_7441,_7470,_7494,_7523,!,{},{},_7577],_7363,_7365) --> 
    w(noun(time,sin,def,n),_7383,_7363,_7400),
    w(nb(_7294,num),_7412,_7400,_7429),
    w(nb(_7299,num),_7441,_7429,_7458),
    to0(_7470,_7458,_7485),
    w(nb(_7304,num),_7494,_7485,_7511),
    w(nb(_7309,num),_7523,_7511,_7540),
    !,
    {user:_7314 is _7294*100+_7299},
    {user:_7283 is _7304*100+_7309},
    lock(exact,_7540,_7690),
    pushstack(exact,(time1(_7314),and1,time1(_7283)),nil,_7690,_7696),
    noun_phrases(_7241,_7244::_7245,_7577,_7696,_7685),
    unlock(_7685,_7365).

name_phrase(0,_7241,_7244::_7245,[name_phrase,_7333,_7362,_7391,_7415,!,_7449],_7313,_7315) --> 
    w(noun(time,sin,def,n),_7333,_7313,_7350),
    timexp(_7280,_7362,_7350,_7379),
    to0(_7391,_7379,_7406),
    timexp(_7271,_7415,_7406,_7432),
    !,
    pushstack(first,(time1(_7280),and1,time1(_7271)),nil,_7432,_7547),
    noun_phrases(_7241,_7244::_7245,_7449,_7547,_7315).

name_phrase(_7240,_7241,_7244::_7247 and _7244,[name_phrase,_7317,_7346,_7385],_7297,_7299) --> 
    look_ahead(w(nb(_7269,_7270)),_7317,_7297,_7334),
    namep(_7240,_7241,_7247,_7346,_7334,_7367),
    not_look_ahead(w(noun(minute,_7261,_7262,_7263)),_7385,_7367,_7299).

name_phrase(_7240,_7241,_7244::_7247 and _7244,[name_phrase,_7317,_7346,_7385],_7297,_7299) --> 
    look_ahead(w(nb(_7269,_7270)),_7317,_7297,_7334),
    namep(_7240,_7241,_7247,_7346,_7334,_7367),
    not_look_ahead(w(noun(minute,_7261,_7262,_7263)),_7385,_7367,_7299).

name_phrase(_7240,_7241,_7244::_7247 and _7244,[name_phrase,_7295],_7275,_7277) --> 
    namep(_7240,_7241,_7247,_7295,_7275,_7277).

person_name((_7247,_7250,_7251):person,_7253 and _7256 and _7257,_7242,[person_name,_7324,_7363,_7402,!,_7446],_7304,_7306) --> 
    properfirstname(_7247,_7253,_7273,_7324,_7304,_7345),
    properfirstname(_7250,_7256,_7277,_7363,_7345,_7384),
    properlastname(_7251,_7257,_7242,_7402,_7384,_7423),
    !,
    accept(_7446,_7423,_7306).

person_name((_7247,_7248):person,_7250 and _7251,_7242,[person_name,_7311,_7350,!,_7394],_7291,_7293) --> 
    properfirstname(_7247,_7250,_7264,_7311,_7291,_7332),
    properlastname(_7248,_7251,_7242,_7350,_7332,_7371),
    !,
    accept(_7394,_7371,_7293).

properfirstname('Rønning','RønningP',_7242,[properfirstname,_7292],_7272,_7274) --> 
    name1g('Rønning':firstname,'RønningP',_7242,_7292,_7272,_7274).

properlastname('Rønning','RønningP',_7242,[properlastname,_7292],_7272,_7274) --> 
    name1g('Rønning':lastname,'RønningP',_7242,_7292,_7272,_7274).

np_head(_7240,_7241,_7242,[np_head,lit(ett),_7314,!,_7348],_7283,_7285) --> 
    cc(ett,_7283,_7313),
    w(noun(time,_7258,def,_7260),_7314,_7313,_7331),
    !,
    reject(_7348,_7331,_7285).

np_head(0,_7241,_7244::_7245,[np_head,_7341,_7365,_7394,!,_7438,_7467,{},{}],_7321,_7323) --> 
    the0(_7341,_7321,_7356),
    preadjs0(_7275,_7365,_7356,_7382),
    quantifier(_7241,_7273,_7273 and _7244::_7245,_7394,_7382,_7415),
    !,
    preadjs0(_7270,_7438,_7415,_7455),
    noun_complex(_7289,_7241,_7291,_7467,_7455,_7323),
    {user:preadjs_template(_7275,_7241,_7291,_7272)},
    {user:preadjs_template(_7270,_7241,_7272,_7273)}.

np_head(_7240,_7241,_7242,[np_head,_7345,_7394,{},_7433,_7462,{}],_7325,_7327) --> 
    determiner0(_7266,_7240,_7241,_7264,_7242,_7345,_7325,_7370),
    preadjs0(_7261,_7394,_7370,_7411),
    {user:(_7261=true->_7279=_7266;_7279=_7280)},
    not_look_ahead(w(noun(crown,_7296,_7297,_7298)),_7433,_7411,_7450),
    noun_complex(_7279,_7241,_7263,_7462,_7450,_7327),
    {user:preadjs_template(_7261,_7241,_7263,_7264)}.

np_head(0,_7241,_7244::findpron(_7259)::exists(_7241)::_7253 and _7256 and _7244,[np_head,_7345,_7369,_7423,!,_7457,{}],_7325,_7327) --> 
    thispron(_7345,_7325,_7360),
    noun(_7284,_7285,_7286,gen,_7259,_7256,_7369,_7360,_7396),
    look_ahead(w(nb(_7295,num)),_7423,_7396,_7440),
    !,
    np0_accept(_7241,_7282::_7253,_7457,_7440,_7327),
    {user:has_template(_7259,_7241,_7282)}.

np_head(0,_7241,_7244::findpron(_7265)::exists(_7241)::_7253 and _7256 and _7259 and _7262 and _7244,[np_head,_7357,_7381,!,_7440,_7469,_7508,{},{}],_7337,_7339) --> 
    thispron(_7357,_7337,_7372),
    noun(_7296,_7297,_7298,gen,_7265,_7259,_7381,_7372,_7408),
    !,
    preadjs0(_7303,_7440,_7408,_7457),
    noun_compound(_7241,_7256,_7307,_7469,_7457,_7490),
    not_look_aheadnounx(_7508,_7490,_7339),
    {user:preadjs_template(_7303,_7241,_7256,_7253)},
    {user:has_template(_7265,_7241,_7262)}.

not_look_aheadnounx([not_look_aheadnounx,_7277,!],_7266,_7268) --> 
    look_ahead(w(verb(_7247,_7248,fin)),_7277,_7266,_7268),
    !.

not_look_aheadnounx([not_look_aheadnounx,_7278,!],_7267,_7269) --> 
    look_ahead(w(noun(clock,_7248,_7249,_7250)),_7278,_7267,_7269),
    !.

not_look_aheadnounx([not_look_aheadnounx,_7275],_7264,_7266) --> 
    not_look_ahead(w(noun(_7244,_7245,_7246,_7247)),_7275,_7264,_7266).

noun_complex(_7240,_7244:_7245,_7244 isa _7245,[noun_complex,_7340,_7369,_7398,_7427,{},!],_7320,_7322) --> 
    not_look_ahead(w(nb(_7269,_7270)),_7340,_7320,_7357),
    w(name(_7244,n,_7276),_7369,_7357,_7386),
    not_look_ahead(w(verb(_7282,pres,fin)),_7398,_7386,_7415),
    w(noun(_7288,_7240,_7290,n),_7427,_7415,_7322),
    {user:joinclass(_7288,_7276,_7245)},
    !.

noun_complex(sin,_7244:_7245,_7244 isa _7245,[noun_complex,_7308,_7337,!],_7288,_7290) --> 
    w(noun(_7245,sin,_7260,n),_7308,_7288,_7325),
    w(quote(_7244),_7337,_7325,_7290),
    !.

noun_complex(sin,_7244:_7248,_7244 isa _7245,[noun_complex,_7358,_7387,_7416,_7445,_7474,_7498,{},!],_7338,_7340) --> 
    w(noun(_7245,sin,_7275,n),_7358,_7338,_7375),
    not_look_ahead([du],_7387,_7375,_7404),
    w(name(_7244,n,_7286),_7416,_7404,_7433),
    not_look_ahead(w(noun(minute,_7293,_7294,_7295)),_7445,_7433,_7462),
    point0(_7474,_7462,_7489),
    not_look_ahead(w(name(_7301,_7302,date)),_7498,_7489,_7340),
    {user:(joinclass(_7245,_7286,_7248),_7248\==nil)},
    !.

noun_complex(sin,_7244:_7245,_7244 isa _7245,[noun_complex,_7340,_7369,{},_7408,_7432,!],_7320,_7322) --> 
    w(noun(_7245,_7268,_7269,n),_7340,_7320,_7357),
    w(nb(_7244,num),_7369,_7357,_7386),
    {user:testmember(_7245,[footnote,page,sms,telephone,week,year])},
    and1(_7408,_7386,_7423),
    w(nb(_7296,_7297),_7432,_7423,_7322),
    !.

noun_complex(_7240,_7244:_7245,_7244 isa _7245,[noun_complex,_7331,_7360,{},!],_7311,_7313) --> 
    w(noun(_7245,_7240,_7263,n),_7331,_7311,_7348),
    w(nb(_7244,num),_7360,_7348,_7313),
    {user:testmember(_7245,[footnote,page,sms,telephone,week,year,number])},
    !.

noun_complex(_7240,_7244:_7245,_7244 isa _7245,[noun_complex,_7376,{},_7415,_7449,_7478,_7512,_7541,_7570,_7599,!,_7633],_7356,_7358) --> 
    w(noun(_7245,_7240,_7284,n),_7376,_7356,_7393),
    {user:subtype0(_7245,vehicle)},
    plausibleno(_7245,_7244,_7415,_7393,_7434),
    not_look_ahead([ganger],_7449,_7434,_7466),
    plausibleno(_7245,_7244,_7478,_7466,_7497),
    not_look_ahead_lit([sin,sitt,sine],_7512,_7497,_7529),
    not_look_ahead(w(name(_7314,_7315,month)),_7541,_7529,_7558),
    not_look_ahead(w(name(_7314,_7323,date)),_7570,_7558,_7587),
    not_look_ahead(w(noun(_7330,plu,_7332,_7333)),_7599,_7587,_7616),
    !,
    accept(_7633,_7616,_7358).

noun_complex(plu,_7244:_7245,_7244 isa _7245,[noun_complex,_7312,_7346,{}],_7292,_7294) --> 
    plausibleno(_7245,_7244,_7312,_7292,_7331),
    w(noun(_7245,sin,u,n),_7346,_7331,_7294),
    {user:subtype0(_7245,vehicle)}.

noun_complex(_7240,_7241,_7242,[noun_complex,_7310,_7349,_7378],_7290,_7292) --> 
    noun_list(_7240,_7241,_7242,_7310,_7290,_7331),
    not_look_ahead_lit([sin,sitt,sine],_7349,_7331,_7366),
    not_look_ahead(w(nb(_7254,_7255)),_7378,_7366,_7292).

noun_complex(_7240,_7241,_7242,[noun_complex,_7303,_7332,_7361],_7283,_7285) --> 
    not_look_ahead([noe],_7303,_7283,_7320),
    not_look_ahead([min],_7332,_7320,_7349),
    noun_compound(_7241,_7242,_7240,_7361,_7349,_7285).

plausibleno(_7240,_7241,[plausibleno,_7293,_7322,_7346,!,_7375],_7276,_7278) --> 
    num(_7255,_7293,_7276,_7310),
    point(_7322,_7310,_7337),
    monthnamex(_7346,_7337,_7361),
    !,
    reject(_7375,_7361,_7278).

plausibleno(_7240,_7241,[plausibleno,_7290,_7319,!,_7348],_7273,_7275) --> 
    num(_7252,_7290,_7273,_7307),
    colon(_7319,_7307,_7334),
    !,
    reject(_7348,_7334,_7275).

plausibleno(_7240,_7241,[plausibleno,_7292,_7321,!,_7355],_7275,_7277) --> 
    num(_7252,_7292,_7275,_7309),
    monthname(_7254,_7321,_7309,_7338),
    !,
    reject(_7355,_7338,_7277).

plausibleno(_7240,_7241,[plausibleno,_7298,_7322,{}],_7281,_7283) --> 
    nr0(_7298,_7281,_7313),
    num(_7241,_7322,_7313,_7283),
    {user:(_7241>0,_7241<1000)}.

plausibleno(_7240,_7241,[plausibleno,_7295,_7319,{}],_7278,_7280) --> 
    nr0(_7295,_7278,_7310),
    w(nb(_7241,alf),_7319,_7310,_7280),
    {user:_7241<1000}.

npa(_7252:_7253,_7243::findexternal(_7252:_7253)::_7252 isa _7253 and _7243,[npa,_7325,_7354,!,{}],_7308,_7310) --> 
    one_of_lit([det,dette],_7325,_7308,_7342),
    look_ahead(w(adv(_7287)),_7354,_7342,_7310),
    !,
    {user:_7253=thing}.

npa(_7252:_7253,_7243::findexternal(_7252:_7253)::_7252 isa _7253 and _7243,[npa,lit(dette),_7323,{}],_7295,_7297) --> 
    cc(dette,_7295,_7322),
    not_look_ahead_np(_7323,_7322,_7297),
    {user:_7253=thing}.

npa(_7252:_7253,_7243::findexternal(_7252:thing)::_7252 isa _7253 and _7243,[npa,lit(det),_7326,_7355],_7298,_7300) --> 
    cc(det,_7298,_7325),
    look_ahead(w(verb(_7275,_7276,fin)),_7326,_7325,_7343),
    not_look_ahead_np(_7355,_7343,_7300).

npa(_7240,_7243::findit(_7249)::_7247,[npa,_7316,_7340,_7379,{}],_7299,_7301) --> 
    its(_7316,_7299,_7331),
    determiner00(_7240,_7273 and _7264,_7243::_7247,_7340,_7331,_7361),
    noun_compound(_7240,_7273,_7278,_7379,_7361,_7301),
    {user:has_template(_7249,_7240,_7264)}.

npa(_7240,_7241,[npa,_7288,_7312,!,_7341],_7271,_7273) --> 
    this(_7288,_7271,_7303),
    look_ahead_np(_7312,_7303,_7327),
    !,
    reject(_7341,_7327,_7273).

npa(_7240,_7243::find(_7240)::_7249 and _7243,[npa,_7297],_7280,_7282) --> 
    noun(_7254,_7255,def,n,_7240,_7249,_7297,_7280,_7282).

npa(_7252:_7253,_7243::findexternal(_7252:_7253)::_7252 isa _7261 and _7243,[npa,lit(denne),_7347,_7376,{},{}],_7319,_7321) --> 
    cc(denne,_7319,_7346),
    not_look_ahead(w(adj),_7347,_7346,_7364),
    not_look_ahead(w(noun(_7290,_7291,_7292,_7293)),_7376,_7364,_7321),
    {user:_7261=thing},
    {user:type(_7261,_7253)}.

npa(_7252:_7253,_7243::findpron(_7252:_7253)::_7252 isa thing and _7243,[npa,lit(det),_7323,{}],_7295,_7297) --> 
    cc(det,_7295,_7322),
    endofline(_7323,_7322,_7297),
    {user:type(thing,_7253)}.

npa(_7240,_7243::_7244,[npa,_7325,_7349,_7378,_7407],_7308,_7310) --> 
    allsome0(_7325,_7308,_7340),
    posspron(_7269,_7349,_7340,_7366),
    w(nb(_7266,num),_7378,_7366,_7395),
    pushstack(first,(thispron,w(noun(_7269,sin,u,gen)),w(nb(_7266,num))),nil,_7395,_7448),
    np1(_7240,_7243::_7244,_7407,_7448,_7310).

npa(_7240,_7243::_7244,[npa,_7309,_7333,_7362],_7292,_7294) --> 
    allsome0(_7309,_7292,_7324),
    posspron(_7260,_7333,_7324,_7350),
    pushstack(first,(thispron,w(noun(_7260,sin,u,gen))),nil,_7350,_7400),
    np1(_7240,_7243::_7244,_7362,_7400,_7294).

npa(_7240,_7241,[npa,lit(de),_7363,_7392,_7421,_7450,!,_7484],_7335,_7337) --> 
    cc(de,_7335,_7362),
    w(nb(_7281,num),_7363,_7362,_7380),
    flnp(_7284,_7392,_7380,_7409),
    not_look_ahead(w(name(_7290,_7291,_7292)),_7421,_7409,_7438),
    not_look_ahead(w(noun(_7298,_7299,_7300,_7301)),_7450,_7438,_7467),
    !,
    pushstack(first,(w(nb(_7281,num)),w(adj2(_7284,nil)),w(noun(vehicle,sin,u,n))),nil,_7467,_7494),
    np1(_7240,_7241,_7484,_7494,_7337).

npa(_7240,_7243::_7244,[npa,_7368,_7392,_7421,_7450,_7479,_7508,_7532,_7561,!,_7595],_7351,_7353) --> 
    dent0(_7368,_7351,_7383),
    not_look_ahead(['først'],_7392,_7383,_7409),
    not_look_ahead([sist],_7421,_7409,_7438),
    not_look_ahead([senest],_7450,_7438,_7467),
    not_look_ahead([tidligst],_7479,_7467,_7496),
    nest(_7508,_7496,_7523),
    flnp(_7305,_7532,_7523,_7549),
    not_look_ahead(w(noun(_7311,_7312,_7313,_7314)),_7561,_7549,_7578),
    !,
    pushstack(first,(w(adj2(second,nil)),w(adj2(_7305,nil)),w(noun(vehicle,sin,u,n))),nil,_7578,_7605),
    np1(_7240,_7243::_7244,_7595,_7605,_7353).

npa(_7240,_7243::_7244,[npa,_7372,_7396,_7425,_7454,_7483,!,_7517,_7588],_7355,_7357) --> 
    dent0(_7372,_7355,_7387),
    not_look_ahead([f,s,'først',sist,senest,tidligst],_7396,_7387,_7413),
    flnp(_7290,_7425,_7413,_7442),
    not_look_ahead(w(name(_7296,_7297,_7298)),_7454,_7442,_7471),
    not_look_ahead(w(noun(_7304,_7305,_7306,_7307)),_7483,_7471,_7500),
    !,
    pushstack(first,(a,w(adj2(_7290,nil)),w(noun(vehicle,sin,u,n))),nil,_7500,_7558),np1(_7240,_7243::_7244,_7517,_7558,_7573),
    optional(w(noun(bus,sin,_7273,_7274)),_7588,_7573,_7357).

npa(_7240,_7241,[npa,{},lit(den),_7341,_7370,!,_7404],_7303,_7305) --> 
    {user:value(busflag,true)},
    cc(den,_7303,_7340),
    not_look_ahead(w(adj2(_7272,nil)),_7341,_7340,_7358),
    not_look_ahead(w(noun(_7279,_7280,_7281,_7282)),_7370,_7358,_7387),
    !,
    npit(_7240,_7241,_7404,_7387,_7305).

npa(_7240,_7243::_7244,[npa,lit(den),_7342,_7371,!,_7405],_7314,_7316) --> 
    cc(den,_7314,_7341),
    not_look_ahead(w(adj2(_7277,nil)),_7342,_7341,_7359),
    not_look_ahead(w(noun(_7284,_7285,_7286,_7287)),_7371,_7359,_7388),
    !,
    lock(exact,_7388,_7450),
    pushstack(exact,(this,w(noun(thing,sin,u,n))),nil,_7450,_7456),
    np1(_7240,_7243::_7244,_7405,_7456,_7445),
    unlock(_7445,_7316).

npit(_7249:_7250,_7243::_7249 isa _7250 and _7243,[npit,{}],_7281,_7281) --> 
    {user:it_template(_7249:_7250)}.

adjnoun([adjnoun,_7271],_7260,_7262) --> 
    w(adj2(nil,nil),_7271,_7260,_7262).

adjnoun([adjnoun,_7273],_7262,_7264) --> 
    w(noun(_7242,plu,u,_7245),_7273,_7262,_7264).

np2(_7240,_7241,[np2,lit(noe),_7331,_7360,!,_7389],_7303,_7305) --> 
    cc(noe,_7303,_7330),
    w(adj2(_7272,_7273),_7331,_7330,_7348),
    not_look_ahead_np(_7360,_7348,_7375),
    !,
    lock(exact,_7375,_7406),
    pushstack(exact,(w(adj2(_7272,_7273)),w(noun(thing,sin,u,n))),nil,_7406,_7412),
    np_kernel(0,_7240,_7241,_7389,_7412,_7401),
    unlock(_7401,_7305).

np2(_7240,_7241,[np2,lit(noe),_7329,!,_7363,_7424],_7301,_7303) --> 
    cc(noe,_7301,_7328),
    look_ahead(w(prep(_7266)),_7329,_7328,_7346),
    !,
    lock(exact,_7346,_7383),pushstack(exact,w(noun(thing,sin,u,n)),nil,_7383,_7389),np_kernel(0,_7240,_7257,_7363,_7389,_7378),unlock(_7378,_7379),
    noun_modifiers0(0,_7240,_7257,_7241,_7424,_7379,_7303).

np2(_7240,_7241,[np2,_7351,_7385,{},!,_7429,!],_7334,_7336) --> 
    clock_kernel(_7261:clock,_7261 isa clock,_7351,_7334,_7370),
    w(noun(_7269,sin,_7271,n),_7385,_7370,_7402),
    {user:testmember(_7269,[departure,arrival])},
    !,
    lock(exact,_7402,_7482),pushstack(exact,(w(noun(_7269,sin,def,n)),w(prep(at)),clock_kernel(_7261:clock,_7261 isa clock)),nil,_7482,_7488),np1(_7240,_7241,_7429,_7488,_7477),unlock(_7477,_7336),
    !.

np2(_7240,_7241,[np2,_7338,_7362,lit(enn),!,_7407,!,_7446,!],_7321,_7323) --> 
    anders(_7338,_7321,_7353),
    w(noun(_7266,_7267,_7268,n),_7362,_7353,_7379),
    cc(enn,_7379,_7401),
    !,
    np1(_7273,_7274,_7407,_7401,_7426),
    !,
    lock(exact,_7426,_7497),pushstack(exact,(w(noun(_7266,_7267,_7268,n)),w(prep(except)),xnp(_7273,_7274)),nil,_7497,_7503),np1(_7240,_7241,_7446,_7503,_7492),unlock(_7492,_7323),
    !.

anders([anders,lit(andre),!],_7260,_7262) --> 
    cc(andre,_7260,_7262),
    !.

anders([anders,lit(en),lit(annen),!],_7265,_7267) --> 
    cc(en,_7265,_7286),
    cc(annen,_7286,_7267),
    !.

np2(_7240,_7241,[np2,lit(samme),_7351,lit(som),!,_7396,!,_7435,!],_7323,_7325) --> 
    cc(samme,_7323,_7350),
    w(noun(_7268,sin,u,n),_7351,_7350,_7368),
    cc(som,_7368,_7390),
    !,
    np1(_7275,_7276,_7396,_7390,_7415),
    !,
    lock(exact,_7415,_7486),pushstack(exact,(w(noun(_7268,sin,def,n)),w(prep(as)),xnp(_7275,_7276)),nil,_7486,_7492),np1(_7240,_7241,_7435,_7492,_7481),unlock(_7481,_7325),
    !.

np2(_7249:_7250,_7243::_7246 and _7243,[np2,_7357,_7386,_7420,{},{}],_7340,_7342) --> 
    w(name(_7283,n,_7285),_7357,_7340,_7374),
    gmem(_7285,[company],_7386,_7374,_7405),
    w(noun(_7250,_7295,_7296,n),_7420,_7405,_7342),
    {user:subclass0(_7250,vehicle)},
    {user:_7246=(exists(_7249)::_7249 isa _7250 and _7283 isa _7285 and adj/nil/_7283/_7249/real)}.

np2(_7240,_7241,[np2,_7387,{},{},_7436,_7465,_7494,{},!,_7538,_7562,!],_7370,_7372) --> 
    w(name('Tåsen',n,_7277),_7387,_7370,_7404),
    {user:testmember(_7277,[neighbourhood,station,street])},
    {user:(\+testmember('Tåsen',[sentrum]))},
    w(noun(_7301,_7302,_7303,n),_7436,_7404,_7453),
    not_look_ahead([nr],_7465,_7453,_7482),
    not_look_ahead(w(nb(_7314,_7315)),_7494,_7482,_7511),
    {user:subclass0(_7301,vehicle)},
    !,
    accept(_7538,_7511,_7553),
    lock(exact,_7553,_7582),pushstack(exact,(w(noun(_7301,sin,def,n)),w(prep(to)),w(name('Tåsen',n,_7277))),nil,_7582,_7588),np1(_7240,_7241,_7562,_7588,_7577),unlock(_7577,_7372),
    !.

np2(_7240,_7241,[np2,_7341,{},_7380,_7409,!,_7443,_7467,!],_7324,_7326) --> 
    w(nb(_7266,num),_7341,_7324,_7358),
    {user:this_year(_7266)},
    not_look_ahead([-],_7380,_7358,_7397),
    not_look_ahead(w(nb(_7281,_7282)),_7409,_7397,_7426),
    !,
    accept(_7443,_7426,_7458),
    lock(exact,_7458,_7487),pushstack(exact,(w(noun(year,sin,u,n)),w(nb(_7266,num))),nil,_7487,_7493),np1(_7240,_7241,_7467,_7493,_7482),unlock(_7482,_7326),
    !.

np2(_7240,_7241,[np2,_7321,_7345,lit(enn),!,_7390],_7304,_7306) --> 
    oter(_7321,_7304,_7336),
    w(noun(_7268,_7269,u,n),_7345,_7336,_7362),
    cc(enn,_7362,_7384),
    !,
    pushstack(first,(a,w(noun(_7268,sin,u,n)),[ulik]),nil,_7384,_7428),
    np1(_7240,_7241,_7390,_7428,_7306).

np2(_7240,_7243::_7244,[np2,_7325,_7354,_7383,_7417],_7308,_7310) --> 
    not_look_ahead([alle],_7325,_7308,_7342),
    not_look_ahead(w(name(_7276,_7277,_7278)),_7354,_7342,_7371),
    quant_pron(every,_7263,_7383,_7371,_7402),
    pushstack(first,(every,w(noun(_7263,sin,u,n))),nil,_7402,_7455),
    np1(_7240,_7243::_7244,_7417,_7455,_7310).

np2(_7240,_7241,[np2,_7311,_7345,_7374,_7398],_7294,_7296) --> 
    quant_pron(every,_7260,_7311,_7294,_7330),
    not_look_ahead([som],_7345,_7330,_7362),
    not_look_ahead_np(_7374,_7362,_7389),
    pushstack(first,(every,w(noun(_7260,sin,u,n))),nil,_7389,_7436),
    np0_accept(_7240,_7241,_7398,_7436,_7296).

np2(_7240,_7241,[np2,_7302,_7336,_7360,_7389,_7413],_7285,_7287) --> 
    quant_pron(some,_7255,_7302,_7285,_7321),
    rfxpron0(_7336,_7321,_7351),
    not_look_ahead([som],_7360,_7351,_7377),
    not_look_ahead_np(_7389,_7377,_7404),
    np00(_7255,_7240,_7241,_7413,_7404,_7287).

clock_number(_7242:_7243,[clock_number,_7291,{},!],_7277,_7279) --> 
    number(_7242:_7243,_7291,_7277,_7279),
    {user:clock_test(_7242)},
    !.

bus_number(_7242:_7243,[bus_number,_7288,{}],_7274,_7276) --> 
    number(_7242:_7243,_7288,_7274,_7276),
    {user:plausible_busno(_7242)}.

road_number(_7242:_7243,[road_number,_7289,{}],_7275,_7277) --> 
    number(_7242:_7243,_7289,_7275,_7277),
    {user:_7242=<200}.

noun_list2(_7240,_7241,_7242,[noun_list2,_7300,_7354],_7280,_7282) --> 
    noun(_7252,_7240,u,n,_7247,_7248,_7300,_7280,_7327),
    nlists10(_7247,_7248,_7241,_7242,_7354,_7327,_7282).

nlists10(_7248:_7249,_7241,(_7248,_7258):(_7249,_7255),_7241 and _7246,[nlists10,_7327,_7351,_7405],_7304,_7306) --> 
    comma(_7327,_7304,_7342),
    noun(_7271,_7272,_7273,n,_7266,_7267,_7351,_7342,_7378),
    nlists10(_7266,_7267,_7258:_7255,_7246,_7405,_7378,_7306).

nlists10(_7248:_7249,_7241,(_7248,_7258):(_7249,_7255),_7241 and _7246,[nlists10,_7321,_7350],_7298,_7300) --> 
    andor(_7270,_7321,_7298,_7338),
    noun(_7263,_7264,_7265,n,_7258:_7255,_7246,_7350,_7338,_7300).

noun_list(_7240,_7241,_7242,[noun_list,_7343,_7372,_7401,_7430,_7459,{},_7523],_7323,_7325) --> 
    not_look_ahead([noe],_7343,_7323,_7360),
    not_look_ahead([noen],_7372,_7360,_7389),
    not_look_ahead([min],_7401,_7389,_7418),
    not_look_ahead(w(adj2(_7283,nil)),_7430,_7418,_7447),
    noun(_7286,_7240,_7288,n,_7262,_7263,_7459,_7447,_7486),
    {user:(\+testmember(_7286,[clock]))},
    nlists0join(_7262,_7263,_7241,_7242,_7523,_7486,_7325).

nlists0join(_7240,_7241,_7245:_7246,_7243,[nlists0join,_7324,{},!,_7383,{}],_7301,_7303) --> 
    nlists0(_7240,_7241,_7245:_7271,_7243,_7324,_7301,_7347),
    {user:joinclasses(_7271,_7246)},
    !,
    accept(_7383,_7347,_7303),
    {user:_7246\==thing}.

nlists0(_7248:_7249,_7241,(_7248,_7258):(_7249,_7255),_7241 and _7246,[nlists0,lit(og),_7383,_7412,_7466,{},{},_7515],_7349,_7351) --> 
    cc(og,_7349,_7382),
    not_look_ahead_lit([da,'så',min],_7383,_7382,_7400),
    noun(_7293,_7294,_7295,n,_7278,_7279,_7412,_7400,_7439),
    not_look_ahead(w(prep(_7304)),_7466,_7439,_7483),
    {user:joinclass(_7249,_7293,_7310)},
    {user:(_7310\==thing,_7310\==nil)},
    nlists0(_7278,_7279,_7258:_7255,_7246,_7515,_7483,_7351).

nlists0(_7240,_7241,_7240,_7241,[nlists0,[],_7308],_7280,_7282) --> 
    [],
    not_look_ahead(w(noun(_7252,_7253,_7254,_7255)),_7308,_7280,_7282).

postcode(_7240,[postcode,_7322,{},_7361,{}],_7308,_7310) --> 
    w(nb(_7240,num),_7322,_7308,_7339),
    {user:(number(_7240),_7240>=1000,_7240=<9999)},
    look_ahead(w(name(_7287,n,_7253)),_7361,_7339,_7310),
    {user:testmember(_7253,[city,neighbourhood,station])}.

noun_compound(_7240,_7241,sin,[noun_compound,_7309,_7338,_7377,_7401],_7289,_7291) --> 
    not_look_ahead([man],_7309,_7289,_7326),
    namep(_7264,_7255,_7256,_7338,_7326,_7359),
    sin(_7377,_7359,_7392),
    ncomps0(gen,_7240,_7255,_7256,_7241,_7258,_7401,_7392,_7291).

noun_compound(_7240,_7244 and _7245,_7242,[noun_compound,_7320,_7349,_7378,{}],_7300,_7302) --> 
    not_look_ahead([dere],_7320,_7300,_7337),
    w(name(_7258,_7269,_7270),_7349,_7337,_7366),
    noun(_7272,_7242,u,n,_7240,_7244,_7378,_7366,_7302),
    {user:adjnamecomp_template(_7258,_7240,_7245)}.

noun_compound(_7240,_7241,_7242,[noun_compound,_7324,_7353,{},_7412,_7456],_7304,_7306) --> 
    not_look_ahead([man],_7324,_7304,_7341),
    noun2(_7267,_7268,_7269,_7258,_7259,_7353,_7341,_7378),
    {user:_7242=_7267},
    s0(_7267,_7268,_7269,_7256,_7412,_7378,_7435),
    ncomps0(_7256,_7240,_7258,_7259,_7241,_7261,_7456,_7435,_7306).

morenames(_7240,(_7240,_7244),[morenames,_7290,_7319],_7273,_7275) --> 
    unplausible_name(_7249,_7290,_7273,_7307),
    morenames(_7249,_7244,_7319,_7307,_7275).

morenames(_7240,_7240,[morenames,[]],_7262,_7262) --> 
    [].

unplausible_name(_7240,[unplausible_name,_7285,!,_7319],_7271,_7273) --> 
    w(name(_7240,unknown,_7252),_7285,_7271,_7302),
    !,
    accept(_7319,_7302,_7273).

ncomps0(gen,_7241,_7242,_7243,_7244,0,[ncomps0,_7323,_7352,{}],_7294,_7296) --> 
    preadjs0(_7255,_7323,_7294,_7340),
    ncomps(_7241,_7242,_7258,_7244,_7352,_7340,_7296),
    {user:preadjs_template(_7255,_7241,_7243,_7258)}.

ncomps0(n,_7247:_7248,_7247:_7248,_7243,_7243,0,[ncomps0,_7316],_7287,_7289) --> 
    w(noun(_7248,_7256,_7257,n),_7316,_7287,_7289).

ncomps0(n,_7241,_7242,_7243,_7243,name,[ncomps0,{}],_7279,_7279) --> 
    {user:compatvar(_7241,_7242)}.

ncomps(_7240,_7241,_7242,_7243,[ncomps,_7322,{},_7381],_7299,_7301) --> 
    noun2(_7258,_7259,_7251,_7253,_7262,_7322,_7299,_7347),
    {user:has_template(_7241,_7253,_7268)},
    ncomps0(_7251,_7240,_7253,_7242 and _7262 and _7268,_7243,_7256,_7381,_7347,_7301).

s0(_7240,_7241,n,gen,[s0,_7291],_7268,_7270) --> 
    sin(_7291,_7268,_7270).

s0(_7240,_7241,n,gen,[s0,lit(s)],_7270,_7272) --> 
    cc(s,_7270,_7272).

s0(sin,u,n,n,[s0,[]],_7268,_7268) --> 
    [].

s0(sin,def,n,n,[s0,[]],_7268,_7268) --> 
    [].

s0(plu,u,n,n,[s0,[]],_7268,_7268) --> 
    [].

s0(plu,def,n,n,[s0,[]],_7268,_7268) --> 
    [].

s0(_7240,_7241,gen,gen,[s0,[]],_7268,_7268) --> 
    [].

noun_modifiers0(_7240,_7241,_7248::_7246,_7245::_7246,[noun_modifiers0,_7302],_7279,_7281) --> 
    noun_modsx0(_7240,_7241,_7245,_7248,_7302,_7279,_7281).

noun_modsx0(0,_7241,_7242,_7243,[noun_modsx0,_7295],_7272,_7274) --> 
    rel_clauses(_7241,_7242,_7243,_7295,_7272,_7274).

noun_modsx0(0,_7254:_7255,_7242,_7242 and _7257 isa coevent and _7251 and _7252,[noun_modsx0,{},lit(til),lit(at),!,_7397,{},!,_7446],_7337,_7339) --> 
    {user:testmember(_7255,[cause])},
    cc(til,_7337,_7380),
    cc(at,_7380,_7391),
    !,
    clausal_object1(_7257:coevent,true::_7252,_7397,_7391,_7416),
    {user:noun_compl(to,_7254:_7255,_7257:coevent,_7251)},
    !,
    accept(_7446,_7416,_7339).

noun_modsx0(0,_7254:_7255,_7242,_7242 and _7257 isa coevent and _7251 and _7252,[noun_modsx0,{},lit(for),lit('å'),!,_7402,{},!,_7460],_7342,_7344) --> 
    {user:testmember(_7255,[way])},
    cc(for,_7342,_7385),
    cc('å',_7385,_7396),
    !,
    pushstack(first,[noen],nil,_7396,_7415),clausal_object1(_7257:coevent,true::_7252,_7402,_7415,_7430),
    {user:noun_compl(regarding,_7254:_7255,_7257:coevent,_7251)},
    !,
    accept(_7460,_7430,_7344).

noun_modsx0(0,_7254:_7255,_7242,_7242 and _7257 isa coevent and _7251 and _7252,[noun_modsx0,{},lit(for),lit(hvordan),!,_7397,{},!,_7446],_7337,_7339) --> 
    {user:testmember(_7255,[way])},
    cc(for,_7337,_7380),
    cc(hvordan,_7380,_7391),
    !,
    clausal_object1(_7257:coevent,true::_7252,_7397,_7391,_7416),
    {user:noun_compl(regarding,_7254:_7255,_7257:coevent,_7251)},
    !,
    accept(_7446,_7416,_7339).

noun_modsx0(0,_7254:_7255,_7242,_7242 and _7257 isa coevent and _7251 and _7252,[noun_modsx0,{},lit(om),lit(hvor),_7408,!,_7442,{},!,_7500],_7353,_7355) --> 
    {user:testmember(_7255,[question])},
    cc(om,_7353,_7396),
    cc(hvor,_7396,_7407),
    w(adj2(_7297,nil),_7408,_7407,_7425),
    !,
    pushstack(free,w(adj2(_7297,nil)),nil,_7425,_7455),clausal_object1(_7257:coevent,true::_7252,_7442,_7455,_7470),
    {user:noun_compl(regarding,_7254:_7255,_7257:coevent,_7251)},
    !,
    accept(_7500,_7470,_7355).

noun_modsx0(0,_7254:_7255,_7242,_7242 and _7257 isa coevent and _7251 and _7252,[noun_modsx0,{},lit(der),!,_7381,{},!,_7430],_7332,_7334) --> 
    {user:testmember(_7255,[example])},
    cc(der,_7332,_7375),
    !,
    clausal_object1(_7257:coevent,true::_7252,_7381,_7375,_7400),
    {user:noun_compl(on,_7254:_7255,_7257:coevent,_7251)},
    !,
    accept(_7430,_7400,_7334).

noun_modsx0(0,_7254:_7255,_7242,_7242 and _7257 isa coevent and _7251 and _7252,[noun_modsx0,{},_7378,lit('å'),!,_7438,{},!,_7552],_7345,_7347) --> 
    {user:testmember(_7255,[cause])},
    optional([for],_7378,_7345,_7410),
    cc('å',_7410,_7432),
    !,
    pushstack(first,(someone,aux1),nil,_7432,_7507),clausal_object1(_7257:coevent,true::_7252,_7438,_7507,_7522),
    {user:noun_compl(for,_7254:_7255,_7257:coevent,_7251)},
    !,
    accept(_7552,_7522,_7347).

noun_modsx0(0,_7254:_7255,_7242,_7242 and _7257 isa coevent and _7251 and _7252,[noun_modsx0,{},_7380,lit('å'),!,_7440,{},!,_7554],_7347,_7349) --> 
    {user:testmember(_7255,[permission,possibility])},
    optional([til],_7380,_7347,_7412),
    cc('å',_7412,_7434),
    !,
    pushstack(first,(someone,aux1),nil,_7434,_7509),clausal_object1(_7257:coevent,true::_7252,_7440,_7509,_7524),
    {user:noun_compl(to,_7254:_7255,_7257:coevent,_7251)},
    !,
    accept(_7554,_7524,_7349).

noun_modsx0(0,_7254:_7255,_7242,_7242 and _7257 isa coevent and _7251 and _7252,[noun_modsx0,{},lit(om),lit('å'),!,_7409,{},!,_7523],_7349,_7351) --> 
    {user:testmember(_7255,[notification,request,plan,wish])},
    cc(om,_7349,_7392),
    cc('å',_7392,_7403),
    !,
    pushstack(first,(someone,aux1),nil,_7403,_7478),clausal_object1(_7257:coevent,true::_7252,_7409,_7478,_7493),
    {user:noun_compl(about,_7254:_7255,_7257:coevent,_7251)},
    !,
    accept(_7523,_7493,_7351).

noun_modsx0(0,_7254:_7255,_7242,_7242 and _7257 isa coevent and _7251 and _7252,[noun_modsx0,{},_7373,lit(at),!,_7418,{},!,_7467],_7340,_7342) --> 
    {user:constrain(_7254:_7255,connection)},
    w(prep(with),_7373,_7340,_7390),
    cc(at,_7390,_7412),
    !,
    clausal_object1(_7257:coevent,true::_7252,_7418,_7412,_7437),
    {user:noun_compl(with,_7254:_7255,_7257:coevent,_7251)},
    !,
    accept(_7467,_7437,_7342).

noun_modsx0(0,_7241,_7242,_7242 and _7246,[noun_modsx0,{},_7374,_7398,_7442,_7476,!,_7515],_7341,_7343) --> 
    {user:constrain(_7241,way)},
    in_order_tox(_7374,_7341,_7389),
    lexv(tv,_7289,inf,fin,_7398,_7389,_7421),
    np1(_7293,_7296::_7297,_7442,_7421,_7461),
    fictitiousprep(way,_7300,_7476,_7461,_7495),
    !,
    pushstack(first,(someone,w(verb(_7289,pres,fin)),np1(_7293,_7296::_7297),prep(_7300),npgap(_7241)),nil,_7495,_7647),
    statreal(_7246,_7515,_7647,_7343).

noun_modsx0(0,_7241,_7242,_7242 and _7246,[noun_modsx0,{},_7356,_7380,_7424,!,_7463],_7323,_7325) --> 
    {user:constrain(_7241,way)},
    in_order_tox(_7356,_7323,_7371),
    lexv(iv,_7283,inf,fin,_7380,_7371,_7403),
    fictitiousprep(way,_7288,_7424,_7403,_7443),
    !,
    pushstack(first,(someone,w(verb(_7283,pres,fin)),prep(_7288),npgap(_7241)),nil,_7443,_7561),
    statreal(_7246,_7463,_7561,_7325).

noun_modsx0(_7240,_7241,_7242,_7242,[noun_modsx0,_7301,!,_7335],_7278,_7280) --> 
    look_ahead([den],_7301,_7278,_7318),
    !,
    accept(_7335,_7318,_7280).

noun_modsx0(_7240,_7241,_7242,_7242,[noun_modsx0,{},_7327,!,_7361],_7294,_7296) --> 
    {user:(vartypeid(_7241,_7259),subclass(_7259,daypart))},
    not_look_ahead(w(prep(_7269)),_7327,_7294,_7344),
    !,
    accept(_7361,_7344,_7296).

noun_modsx0(_7240,_7241,_7242,_7243,[noun_modsx0,_7299,!],_7276,_7278) --> 
    noun_mods(_7240,_7241,_7242,_7243,_7299,_7276,_7278),
    !.

noun_modsx0(_7240,_7241,_7242,_7242,[noun_modsx0,[]],_7268,_7268) --> 
    [].

fictitiousprep(way,in,[fictitiousprep,[]],_7262,_7262) --> 
    [].

fictitiousprep(abstract,with,[fictitiousprep,[]],_7262,_7262) --> 
    [].

noun_mods(0,_7241,_7242,_7242 and _7246,[noun_mods,{},_7444,{},_7483,_7512,_7541,_7570,_7599,_7628,_7657,_7686],_7411,_7413) --> 
    {user:(vartypeid(_7241,_7295),testmember(_7295,[address,email,mind,mailaddress,telephone,webaddress]))},
    prep1(to,_7444,_7411,_7461),
    {user:(vartypeid(_7241,_7322),\+testmember(_7322,[name]))},
    not_look_ahead(w(nb(_7334,_7335)),_7483,_7461,_7500),
    not_look_ahead(w(prep(_7341)),_7512,_7500,_7529),
    not_look_ahead_lit([deg,meg,seg],_7541,_7529,_7558),
    not_look_ahead(w(noun(station,_7356,_7357,_7358)),_7570,_7558,_7587),
    not_look_ahead(w(name(_7364,_7365,station)),_7599,_7587,_7616),
    not_look_ahead(w(name(_7372,_7373,neighbourhood)),_7628,_7616,_7645),
    not_look_ahead(w(name(_7380,_7381,city)),_7657,_7645,_7674),
    pushstack(first,(npgap(_7241),w(verb(evah,pres,fin))),nil,_7674,_7726),
    statreal(_7246,_7686,_7726,_7413).

noun_mods(0,_7241,_7242,_7242 and _7246,[noun_mods,{},_7355,{},{},_7404],_7322,_7324) --> 
    {user:value(teleflag,true)},
    not_look_ahead(w(prep(_7281)),_7355,_7322,_7372),
    {user:vartypeid(_7241,_7286)},
    {user:(\+vartypid(_7286,[]))},
    pushstack(first,(npgap(_7241),w(verb(evah,pres,fin))),nil,_7372,_7444),
    statreal(_7246,_7404,_7444,_7324).

noun_mods(0,_7241,_7242,_7243,[noun_mods,_7309,!,_7353,_7377],_7286,_7288) --> 
    noun_mod(_7241,_7242,_7256,_7309,_7286,_7330),
    !,
    accept(_7353,_7330,_7368),
    noun_modsx0(0,_7241,_7256,_7243,_7377,_7368,_7288).

noun_mods(name,_7241,_7242,_7243,[noun_mods,{},_7354,{},_7393,!,_7437,_7461],_7321,_7323) --> 
    {user:(vartypeid(_7241,_7273),subclass0(_7273,vehicle))},
    look_ahead(w(prep(_7283)),_7354,_7321,_7371),
    {user:testmember(_7283,[to,from])},
    noun_mod(_7241,_7242,_7265,_7393,_7371,_7414),
    !,
    accept(_7437,_7414,_7452),
    noun_mods(name,_7241,_7265,_7243,_7461,_7452,_7323).

noun_mods(name,_7241,_7242,_7243,[noun_mods,_7344,{},{},_7393,!,_7437,_7461],_7321,_7323) --> 
    look_ahead(w(prep(_7272)),_7344,_7321,_7361),
    {user:testmember(_7272,[on,towards])},
    {user:(vartypeid(_7241,_7288),subclass0(_7288,place))},
    noun_mod(_7241,_7242,_7265,_7393,_7361,_7414),
    !,
    accept(_7437,_7414,_7452),
    noun_mods(name,_7241,_7265,_7243,_7461,_7452,_7323).

noun_mods(name,_7241,_7242,_7243,[noun_mods,{},_7327,_7366],_7294,_7296) --> 
    {user:(value(textflag,true);value(teleflag,true))},
    noun_mod(_7241,_7242,_7253,_7327,_7294,_7348),
    noun_mods(name,_7241,_7253,_7243,_7366,_7348,_7296).

noun_mods(name,_7241,_7242,_7242 and _7246,[noun_mods,{},{},_7371,{},_7410],_7328,_7330) --> 
    {user:value(teleflag,true)},
    {user:constrain(_7241,person)},
    w(name(_7268,n,_7270),_7371,_7328,_7388),
    {user:subclass0(_7270,place)},
    pushstack(first,(prep1(in),w(name(_7268,n,_7270))),nil,_7388,_7450),
    noun_mod(_7241,_7242,_7246,_7410,_7450,_7330).

noun_mod(_7250:_7251,_7241,nrel/nil/day/clock/_7250/_7254 and _7241 and _7248,[noun_mod,{},_7339,_7363],_7309,_7311) --> 
    {user:constrain(_7250:_7251,day)},
    clock(_7339,_7309,_7354),
    clock_sequel(_7254:_7286,_7248,_7363,_7354,_7311).

noun_mod(_7240,_7241,_7241 and _7245,[noun_mod,_7305,{},!],_7285,_7287) --> 
    adverb(_7253,_7254,_7255,_7305,_7285,_7287),
    {user:noun_adverb(_7240,_7253,_7254,_7245)},
    !.

noun_mod(_7250:_7251,_7241,_7241 and _7247 and _7248,[noun_mod,lit(for),lit('å'),_7373,!,_7412,{},!,_7470],_7331,_7333) --> 
    cc(for,_7331,_7361),
    cc('å',_7361,_7372),
    gmem(_7251,[condition],_7373,_7372,_7392),
    !,
    pushstack(first,[noen],nil,_7392,_7425),clausal_object1(_7294:coevent,true::_7248,_7412,_7425,_7440),
    {user:noun_compl(for,_7250:_7251,_7294:coevent,_7247)},
    !,
    accept(_7470,_7440,_7333).

noun_mod(_7250:_7251,_7241,_7241 and _7247 and _7248,[noun_mod,lit(om),lit(at),{},!,_7399,{},{},!,_7458],_7342,_7344) --> 
    cc(om,_7342,_7372),
    cc(at,_7372,_7383),
    {user:testmember(_7251,[information,message,notification,question])},
    !,
    clausal_object1(_7300:coevent,_7297::_7248,_7399,_7383,_7418),
    {user:_7297=true},
    {user:noun_compl(regarding,_7250:_7251,_7300:coevent,_7247)},
    !,
    accept(_7458,_7418,_7344).

noun_mod(_7240,_7241,_7241 and _7245,[noun_mod,_7314,_7343],_7294,_7296) --> 
    posspron(_7261,_7314,_7294,_7331),
    lock(exact,_7331,_7420),
    pushstack(exact,(pronoun(_7261),w(verb(have,pres,fin)),npgap(_7240)),nil,_7420,_7426),
    statreal(_7245,_7343,_7426,_7415),
    unlock(_7415,_7296).

noun_mod(_7240,_7241,_7241 and _7245,[noun_mod,_7302,_7331],_7282,_7284) --> 
    look_ahead(w(adj(_7258,comp)),_7302,_7282,_7319),
    comparison(_7240,_7251,_7245,_7331,_7319,_7284).

noun_mod(_7240,_7241,_7241 and _7245,[noun_mod,_7335,{},_7374,{},!,_7428,{}],_7315,_7317) --> 
    negation0(_7267,_7335,_7315,_7352),
    {user:(\+vartypeid(_7240,self))},
    adjunct1(_7280,_7281,_7269::_7245,_7374,_7352,_7395),
    {user:noun_compl(_7280,_7240,_7281,_7268)},
    !,
    accept(_7428,_7395,_7317),
    {user:negate(_7267,_7268,_7269)}.

noun_mod(_7244:_7245,_7241,_7241,[noun_mod,{},_7322,_7346,{}],_7292,_7294) --> 
    {user:constrain(_7244:_7245,vehicle)},
    numberroute(_7322,_7292,_7337),
    num_na(_7258,_7346,_7337,_7294),
    {user:_7258=_7244}.

noun_mod(_7240,_7241,_7241 and _7245,[noun_mod,_7325,_7354,{},!,_7425],_7305,_7307) --> 
    day(_7259,_7325,_7305,_7342),
    lock(exact,_7342,_7374),pushstack(exact,w(noun(_7259,sin,u,n)),nil,_7374,_7380),np1(_7271,_7274::_7245,_7354,_7380,_7369),unlock(_7369,_7370),
    {user:noun_compl(nil,_7240,_7271,_7274)},
    !,
    accept(_7425,_7370,_7307).

noun_mod(_7240,_7241,_7241 and _7245,[noun_mod,_7330,_7359,{},!,_7417],_7310,_7312) --> 
    w(noun(midnight,_7262,_7263,n),_7330,_7310,_7347),
    pushstack(first,w(noun(midnight,sin,u,n)),nil,_7347,_7372),np1(_7276,_7279::_7245,_7359,_7372,_7387),
    {user:noun_compl(nil,_7240,_7276,_7279)},
    !,
    accept(_7417,_7387,_7312).

noun_mod(_7240,_7241,_7241 and _7245,[noun_mod,_7310,{},!,_7359],_7290,_7292) --> 
    obviousdate(_7256,_7259::_7245,_7310,_7290,_7329),
    {user:noun_compl(nil,_7240,_7256,_7259)},
    !,
    accept(_7359,_7329,_7292).

noun_mod(_7240,_7241,_7241 and _7245,[noun_mod,_7310,{},!,_7359],_7290,_7292) --> 
    obviousclock(_7256,_7259::_7245,_7310,_7290,_7329),
    {user:noun_compl(nil,_7240,_7256,_7259)},
    !,
    accept(_7359,_7329,_7292).

noun_mod(_7240,_7241,_7242,[noun_mod,_7327,_7356,!,_7395,!,_7479],_7307,_7309) --> 
    w(noun(direction,_7262,_7263,_7264),_7327,_7307,_7344),
    nameq1(_7266,_7267,_7356,_7344,_7375),
    !,
    pushstack(first,(w(prep(towards)),nameq1(_7266,_7267)),nil,_7375,_7439),noun_mod(_7240,_7241,_7242,_7395,_7439,_7456),
    !,
    accept(_7479,_7456,_7309).

noun_mod(_7247:_7248,_7241,_7241 and _7245,[noun_mod,{},_7337,{},!,_7386],_7307,_7309) --> 
    {user:test(n_compl(nil,_7248,_7268))},
    np1_accept(_7270,_7273::_7245,_7337,_7307,_7356),
    {user:noun_compl(nil,_7247:_7248,_7270,_7273)},
    !,
    accept(_7386,_7356,_7309).

begin([begin,[]],_7255,_7255) --> 
    [].

end([end,[]],_7255,_7255) --> 
    [].

accept([accept,[]],_7255,_7255) --> 
    [].

reject([reject,{}],_7257,_7257) --> 
    {user:fail}.

look_ahead_place([look_ahead_place,_7284,{}],_7273,_7275) --> 
    look_ahead(w(name(_7254,_7255,_7247)),_7284,_7273,_7275),
    {user:test(subclass0(_7247,place))}.

look_ahead_conjuction([look_ahead_conjuction,_7270],_7259,_7261) --> 
    look_ahead(['før'],_7270,_7259,_7261).

look_ahead_conjuction([look_ahead_conjuction,_7270],_7259,_7261) --> 
    look_ahead([etter],_7270,_7259,_7261).

look_ahead_conjuction([look_ahead_conjuction,_7270],_7259,_7261) --> 
    look_ahead(['når'],_7270,_7259,_7261).

not_look_ahead_flnp([not_look_ahead_flnp,_7295,{},!,_7339],_7284,_7286) --> 
    look_ahead(w(adj2(_7253,nil)),_7295,_7284,_7312),
    {user:testmember(_7253,[first,last,next,previous])},
    !,
    reject(_7339,_7312,_7286).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_7255,_7255) --> 
    [].

not_look_ahead_flnp([not_look_ahead_flnp,_7295,{},!,_7339],_7284,_7286) --> 
    look_ahead(w(adj2(_7253,nil)),_7295,_7284,_7312),
    {user:testmember(_7253,[first,last,next,previous])},
    !,
    reject(_7339,_7312,_7286).

not_look_ahead_flnp([not_look_ahead_flnp,[]],_7255,_7255) --> 
    [].

not_look_ahead_vehicle([not_look_ahead_vehicle,_7291,{},!,_7335],_7280,_7282) --> 
    look_ahead(w(noun(_7253,_7254,_7255,_7256)),_7291,_7280,_7308),
    {user:test(subclass0(_7253,vehicle))},
    !,
    reject(_7335,_7308,_7282).

not_look_ahead_vehicle([not_look_ahead_vehicle,_7293,{},!,_7337],_7282,_7284) --> 
    look_ahead(w(noun(_7253,_7254,_7255,_7256)),_7293,_7282,_7310),
    {user:testmember(_7253,[departure,arrival])},
    !,
    reject(_7337,_7310,_7284).

not_look_ahead_vehicle([not_look_ahead_vehicle,[]],_7255,_7255) --> 
    [].

not_look_ahead_day([not_look_ahead_day,_7289,{},!,_7333],_7278,_7280) --> 
    look_ahead(w(noun(_7253,_7254,_7255,_7256)),_7289,_7278,_7306),
    {user:_7253 ako day},
    !,
    reject(_7333,_7306,_7280).

not_look_ahead_day([not_look_ahead_day,[]],_7255,_7255) --> 
    [].

not_look_ahead_noun([not_look_ahead_noun,_7275],_7264,_7266) --> 
    not_look_ahead(w(noun(_7244,_7245,_7246,_7247)),_7275,_7264,_7266).

look_ahead_timeclause([look_ahead_timeclause,_7275],_7264,_7266) --> 
    look_ahead(w(noun(clock,_7245,_7246,_7247)),_7275,_7264,_7266).

look_ahead_timeclause([look_ahead_timeclause,_7283,{}],_7272,_7274) --> 
    look_ahead(w(noun(_7245,sin,u,n)),_7283,_7272,_7274),
    {user:subclass(_7245,day)}.

look_ahead_clock([look_ahead_clock,_7272],_7261,_7263) --> 
    look_ahead_lit([kl,klokken],_7272,_7261,_7263).

look_ahead_clock([look_ahead_clock,_7275],_7264,_7266) --> 
    look_ahead(w(noun(clock,sin,def,n)),_7275,_7264,_7266).

look_ahead_clock([look_ahead_clock,_7273],_7262,_7264) --> 
    look_ahead(w(nb(_7244,_7245)),_7273,_7262,_7264).

not_look_ahead_vp([not_look_ahead_vp,_7272,!,_7301],_7261,_7263) --> 
    look_ahead_vp(_7272,_7261,_7287),
    !,
    reject(_7301,_7287,_7263).

not_look_ahead_vp([not_look_ahead_vp,[]],_7255,_7255) --> 
    [].

look_ahead_vp([look_ahead_vp,_7274],_7263,_7265) --> 
    look_ahead(w(verb(_7244,_7245,_7246)),_7274,_7263,_7265).

look_ahead_vp([look_ahead_vp,_7270],_7259,_7261) --> 
    look_ahead([ikke],_7270,_7259,_7261).

look_ahead_vp([look_ahead_vp,_7266],_7255,_7257) --> 
    look_ahead_aux(_7266,_7255,_7257).

look_ahead_aux([look_ahead_aux,_7288],_7277,_7279) --> 
    look_ahead_lit([vil,skal,'bør','må',kan,ville,skulle,burde,'måtte',kunne],_7288,_7277,_7279).

not_look_ahead_lit(_7240,[not_look_ahead_lit,_7281,!,_7315],_7267,_7269) --> 
    look_ahead_lit(_7240,_7281,_7267,_7298),
    !,
    reject(_7315,_7298,_7269).

not_look_ahead_lit(_7240,[not_look_ahead_lit,[]],_7259,_7259) --> 
    [].

look_ahead_lit(_7240,[look_ahead_lit,_7288,{},!],_7274,_7276) --> 
    look_ahead([_7249],_7288,_7274,_7276),
    {user:testmember(_7249,_7240)},
    !.

lit_of(_7240,_7241,[lit_of,lit(_7240),{},!],_7275,_7277) --> 
    cc(_7240,_7275,_7277),
    {user:member(_7240,_7241)},
    !.

one_of_lit(_7240,[one_of_lit,lit(_7247),{},!],_7272,_7274) --> 
    cc(_7247,_7272,_7274),
    {user:member(_7247,_7240)},
    !.

not_one_of_lit(_7240,[not_one_of_lit,_7281,!,_7315],_7267,_7269) --> 
    one_of_lit(_7240,_7281,_7267,_7298),
    !,
    reject(_7315,_7298,_7269).

not_one_of_lit(_7240,[not_one_of_lit,[]],_7259,_7259) --> 
    [].

not_look_ahead_number([not_look_ahead_number,lit(ett),!],_7260,_7262) --> 
    cc(ett,_7260,_7262),
    !.

not_look_ahead_number([not_look_ahead_number,_7277,!,_7311],_7266,_7268) --> 
    w(nb(_7248,_7249),_7277,_7266,_7294),
    !,
    fail(_7311,_7294,_7268).

not_look_ahead_number([not_look_ahead_number,[]],_7255,_7255) --> 
    [].

not_look_ahead_np([not_look_ahead_np,_7291,_7320,!],_7280,_7282) --> 
    look_ahead(w(adv(_7250)),_7291,_7280,_7308),
    gmem(_7250,[klokken,kloka,kl,directly,correctly],_7320,_7308,_7282),
    !.

not_look_ahead_np([not_look_ahead_np,_7272,!,_7301],_7261,_7263) --> 
    look_ahead_np(_7272,_7261,_7287),
    !,
    reject(_7301,_7287,_7263).

not_look_ahead_np([not_look_ahead_np,[]],_7255,_7255) --> 
    [].

look_ahead_np([look_ahead_np,_7334],_7323,_7325) --> 
    look_ahead_lit([den,det,de,denne,dere,dette,disse,du,en,et,ei,han,hun,jeg,noe,noen,vi,meg,deg,seg,min,mine,din,dine,hans,hennes,seg,'vår','våre',deres,mange,noen,noe],_7334,_7323,_7325).

look_ahead_np([look_ahead_np,_7283,{}],_7272,_7274) --> 
    look_ahead(w(adj2(_7247,_7255)),_7283,_7272,_7274),
    {user:(\+testmember(_7247,[]))}.

look_ahead_np([look_ahead_np,_7275],_7264,_7266) --> 
    look_ahead(w(noun(_7244,_7245,_7246,_7247)),_7275,_7264,_7266).

look_ahead_np([look_ahead_np,_7273],_7262,_7264) --> 
    look_ahead(w(nb(_7244,_7245)),_7273,_7262,_7264).

look_ahead_np([look_ahead_np,_7272],_7261,_7263) --> 
    look_ahead_lit([halv,kvart],_7272,_7261,_7263).

look_ahead_np([look_ahead_np,_7284,{}],_7273,_7275) --> 
    look_ahead(w(name(_7247,_7255,_7256)),_7284,_7273,_7275),
    {user:(\+testmember(_7247,[]))}.

look_ahead_subject([look_ahead_subject,lit(_7245),{}],_7275,_7277) --> 
    cc(_7245,_7275,_7277),
    {user:testmember(_7245,[jeg,du,han,hun,vi])}.

look_ahead_pron([look_ahead_pron,_7276],_7265,_7267) --> 
    look_ahead_lit([jeg,vi,du,dere],_7276,_7265,_7267).

not_look_ahead_pron([not_look_ahead_pron,_7274,!,_7308],_7263,_7265) --> 
    posspron(_7246,_7274,_7263,_7291),
    !,
    reject(_7308,_7291,_7265).

not_look_ahead_pron([not_look_ahead_pron,_7276],_7265,_7267) --> 
    not_look_ahead_lit([jeg,du,han,hun],_7276,_7265,_7267).

determiner0(plu,0,_7242,_7243,_7246::quant(approx/_7259,_7242)::_7243 and _7246,[determiner0,lit(mellom),_7354,lit(og),_7394,{}],_7317,_7319) --> 
    cc(mellom,_7317,_7353),
    w(nb(_7259,num),_7354,_7353,_7371),
    cc(og,_7371,_7393),
    w(nb(_7276,num),_7394,_7393,_7319),
    {user:_7259<_7276}.

determiner0(plu,0,_7242,_7243,_7246::quant(eq/_7259,_7242)::_7243 and _7246,[determiner0,_7373,_7397,{},_7436,_7465,!,_7499,[]],_7347,_7349) --> 
    theplu0(_7373,_7347,_7388),
    w(adj2(_7287,nil),_7397,_7388,_7414),
    {user:testmember(_7287,[first,last,next,previous])},
    number(_7259:_7311,_7436,_7414,_7453),
    look_ahead(w(noun(_7317,plu,_7319,_7320)),_7465,_7453,_7482),
    !,
    accept(_7499,_7482,_7514),
    pushstack(free,w(adj2(_7287,nil)),nil,_7514,_7349),
    [].

determiner0(sin,0,_7242,_7243,_7246::_7247,[determiner0,{},_7331,_7355],_7295,_7297) --> 
    {user:value(dialog,1)},
    the(_7331,_7295,_7346),
    pushstack(first,this,nil,_7346,_7393),
    determiner(_7242,_7243,_7246::_7247,_7355,_7393,_7297).

determiner0(_7240,_7241,_7242,_7243,_7244,[determiner0,_7328,_7352,_7381,{},!,_7425],_7302,_7304) --> 
    theplu0(_7328,_7302,_7343),
    number(_7263:_7264,_7352,_7343,_7369),
    w(noun(_7268,_7269,_7270,_7271),_7381,_7369,_7398),
    {user:measureclass(_7268)},
    !,
    reject(_7425,_7398,_7304).

determiner0(plu,0,_7242,_7243,_7246::quant(approx/_7259,_7242)::_7243 and _7246,[determiner0,_7323,!,_7352],_7297,_7299) --> 
    approx(_7323,_7297,_7338),
    !,
    number(_7259:_7270,_7352,_7338,_7299).

approx([approx,lit(ca),!],_7260,_7262) --> 
    cc(ca,_7260,_7262),
    !.

approx([approx,lit(rundt),!],_7260,_7262) --> 
    cc(rundt,_7260,_7262),
    !.

determiner0(plu,0,_7242,_7243,_7246::quant(ge/_7259,_7242)::_7243 and _7246,[determiner0,_7320,_7344],_7294,_7296) --> 
    morethan(_7320,_7294,_7335),
    number(_7259:_7267,_7344,_7335,_7296).

morethan([morethan,lit(minst)],_7257,_7259) --> 
    cc(minst,_7257,_7259).

morethan([morethan,lit(over)],_7257,_7259) --> 
    cc(over,_7257,_7259).

morethan([morethan,lit(mer),lit(enn)],_7262,_7264) --> 
    cc(mer,_7262,_7283),
    cc(enn,_7283,_7264).

determiner0(plu,0,_7242,_7243,_7246::quant(eq/_7259,_7242)::_7243 and _7246,[determiner0,_7332,_7356,_7385],_7306,_7308) --> 
    theplu0(_7332,_7306,_7347),
    number(_7259:_7279,_7356,_7347,_7373),
    not_look_ahead(w(noun(time,_7272,def,n)),_7385,_7373,_7308).

determiner0(sin,0,_7242,_7243,_7246::quant(eq/1,_7242)::_7243 and _7246,[determiner0,_7332,_7361,!],_7306,_7308) --> 
    w(nb(1,num),_7332,_7306,_7349),
    not_look_ahead(w(noun(time,_7277,def,n)),_7361,_7349,_7308),
    !.

determiner0(sin,0,_7242,_7243,_7246::_7247,[determiner0,{},_7331,_7355],_7295,_7297) --> 
    {user:value(dialog,1)},
    the(_7331,_7295,_7346),
    pushstack(first,this,nil,_7346,_7393),
    determiner(_7242,_7243,_7246::_7247,_7355,_7393,_7297).

determiner0(plu,0,_7242,_7243,_7246::_7247,[determiner0,_7321,_7345,_7374],_7295,_7297) --> 
    the(_7321,_7295,_7336),
    not_look_ahead(w(verb(_7266,pres,fin)),_7345,_7336,_7362),
    determiner00(_7242,_7243,_7246::_7247,_7374,_7362,_7297).

determiner0(_7240,0,_7242,_7243,_7246::_7247,[determiner0,_7307],_7281,_7283) --> 
    determiner(_7242,_7243,_7246::_7247,_7307,_7281,_7283).

determiner0(_7240,0,_7242,_7243,_7246::_7247,[determiner0,_7307],_7281,_7283) --> 
    determiner00(_7242,_7243,_7246::_7247,_7307,_7281,_7283).

determiner0(_7240,0,_7242,_7243,_7246::exists(_7242)::_7243 and _7246,[determiner0,_7308],_7282,_7284) --> 
    the0(_7308,_7282,_7284).

determiner00(_7250:_7251,_7241,_7244::_7241 and _7244,[determiner00,_7302,!],_7282,_7284) --> 
    the(_7250:_7251,_7302,_7282,_7284),
    !.

determiner00(_7240,_7241,_7244::exists(_7240)::_7241 and _7244,[determiner00,[]],_7276,_7276) --> 
    [].

determiner(_7240,_7241,_7244::forall(_7240)::_7241=>_7244,[determiner,lit(alle),_7312],_7281,_7283) --> 
    cc(alle,_7281,_7311),
    look_ahead_np(_7312,_7311,_7283).

determiner(_7240,_7241,_7244::forall(_7240)::_7241=>_7244,[determiner,lit(hver)],_7278,_7280) --> 
    cc(hver,_7278,_7280).

determiner(_7240,_7241,_7244::find(_7240)::_7241 and _7244,[determiner,_7299,_7323],_7279,_7281) --> 
    this(_7299,_7279,_7314),
    look_ahead_np(_7323,_7314,_7281).

determiner(_7240,_7241,_7244::_7241 and _7244,[determiner,_7293],_7273,_7275) --> 
    the(_7240,_7293,_7273,_7275).

determiner(_7240,_7241,_7244::exists(_7240)::_7241 and _7244,[determiner,_7317,_7341,_7365,_7394,!],_7297,_7299) --> 
    only0(_7317,_7297,_7332),
    art(_7341,_7332,_7356),
    look_ahead(w(noun(_7271,sin,u,n)),_7365,_7356,_7382),
    off0(_7394,_7382,_7299),
    !.

determiner(_7240,_7241,_7244::exists(_7240)::_7241 and _7244,[determiner,_7302,_7326,_7350],_7282,_7284) --> 
    only0(_7302,_7282,_7317),
    art(_7326,_7317,_7341),
    off0(_7350,_7341,_7284).

determiner(_7240,_7241,_7244::forall(_7240)::_7241=>_7244,[determiner,_7299,_7323],_7279,_7281) --> 
    every(_7299,_7279,_7314),
    look_ahead_np(_7323,_7314,_7281).

determiner(_7240,_7241,_7244::not (exists(_7240)::_7241 and _7244),[determiner,_7301,_7325],_7281,_7283) --> 
    no(_7301,_7281,_7316),
    look_ahead_np(_7325,_7316,_7283).

determiner(_7240,_7241,_7244::exists(_7240)::_7241 and not _7244,[determiner,_7301,_7325],_7281,_7283) --> 
    notall(_7301,_7281,_7316),
    look_ahead_np(_7325,_7316,_7283).

determiner(_7240,_7241,_7244::quant(all,_7240)::_7241 and _7244,[determiner,lit(hele)],_7279,_7281) --> 
    cc(hele,_7279,_7281).

determiner(_7240,_7241,_7244::_7245,[determiner,_7295],_7275,_7277) --> 
    quantifier(_7240,_7241,_7244::_7245,_7295,_7275,_7277).

quantifier(_7240,_7241,_7244::quant(eq/_7257,_7240)::_7241 and _7244,[quantifier,lit(bare),_7321],_7290,_7292) --> 
    cc(bare,_7290,_7320),
    w(nb(_7257,_7265),_7321,_7320,_7292).

quantifier(_7240,_7241,_7244::quant(few,_7240)::_7241 and _7244,[quantifier,_7303,_7327,_7351],_7283,_7285) --> 
    aso0(_7303,_7283,_7318),
    few(_7327,_7318,_7342),
    look_ahead_np(_7351,_7342,_7285).

quantifier(_7240,_7241,_7244::quant(most,_7240)::_7241 and _7244,[quantifier,lit(de),lit(fleste),_7329],_7287,_7289) --> 
    cc(de,_7287,_7317),
    cc(fleste,_7317,_7328),
    look_ahead_np(_7329,_7328,_7289).

quantifier(_7240,_7241,_7244::quant(much,_7240)::_7241 and _7244,[quantifier,_7307,_7331],_7287,_7289) --> 
    much(_7307,_7287,_7322),
    not_look_ahead(w(adj2(_7263,nil)),_7331,_7322,_7289).

quantifier(_7240,_7241,_7244::quant(little,_7240)::_7241 and _7244,[quantifier,_7307,_7331],_7287,_7289) --> 
    little(_7307,_7287,_7322),
    not_look_ahead(w(adj2(_7263,nil)),_7331,_7322,_7289).

quantifier(_7240,_7241,_7244::quant(many,_7240)::_7241 and _7244,[quantifier,_7303,_7327,_7351],_7283,_7285) --> 
    aso0(_7303,_7283,_7318),
    many(_7327,_7318,_7342),
    look_ahead_np(_7351,_7342,_7285).

quantifier(_7240,_7241,_7244::quant(most,_7240)::_7241 and _7244,[quantifier,_7303,_7327,_7351],_7283,_7285) --> 
    aso0(_7303,_7283,_7318),
    most(_7327,_7318,_7342),
    look_ahead_np(_7351,_7342,_7285).

quantifier(_7240,_7241,_7244::quant(all,_7240)::_7241 and _7244,[quantifier,lit(alle),_7313],_7282,_7284) --> 
    cc(alle,_7282,_7312),
    look_ahead_np(_7313,_7312,_7284).

quantifier(_7240,_7241,_7244::quant(ge/2,_7240)::_7241 and _7244,[quantifier,_7303,_7327],_7283,_7285) --> 
    several(_7303,_7283,_7318),
    look_ahead_np(_7327,_7318,_7285).

quantifier(_7240,_7241,_7244::quant(count,_7240)::_7241 and _7244,[quantifier,_7314,_7343,_7387],_7294,_7296) --> 
    w(noun(count,_7265,_7266,_7267),_7314,_7294,_7331),
    optional([av],_7343,_7331,_7375),
    look_ahead_np(_7387,_7375,_7296).

few([few,lit('få')],_7257,_7259) --> 
    cc('få',_7257,_7259).

few([few,lit('færre')],_7257,_7259) --> 
    cc('færre',_7257,_7259).

plausible_name(_7244:person,_7244 isa person,_7242,[plausible_name,_7319,_7358,{},!,_7412],_7299,_7301) --> 
    properfirstname(_7262,_7263,_7264,_7319,_7299,_7340),
    properlastname(_7266,_7267,_7242,_7358,_7340,_7379),
    {user:_7244=(_7262,_7266)},
    !,
    accept(_7412,_7379,_7301).

plausible_name(_7244:_7245,_7244 isa _7245,_7242,[plausible_name,_7315,{}],_7295,_7297) --> 
    w(name(_7244,_7242,_7245),_7315,_7295,_7297),
    {user:(\+_7245=0,\+_7245=date)}.

name_compound(_7240,_7241,_7242,[name_compound,_7331,_7360,_7389,_7418,_7457,_7501],_7311,_7313) --> 
    not_look_ahead([dere],_7331,_7311,_7348),
    not_look_ahead([du],_7360,_7348,_7377),
    not_look_ahead(w(nb(_7278,_7279)),_7389,_7377,_7406),
    plausible_name(_7261,_7262,_7283,_7418,_7406,_7439),
    s0(sin,u,_7283,_7259,_7457,_7439,_7480),
    ncomps0(_7259,_7241,_7261,_7262,_7242,_7240,_7501,_7480,_7313).

namep(name,_7244:street,_7244 isa street,[namep,_7334,_7363,_7387,_7416,{},!,_7460],_7314,_7316) --> 
    w(name(_7244,n,street),_7334,_7314,_7351),
    comma0(_7363,_7351,_7378),
    postcode(_7274,_7387,_7378,_7404),
    w(name(_7278,n,_7280),_7416,_7404,_7433),
    {user:testmember(_7280,[neighbourhood,city,station])},
    !,
    accept(_7460,_7433,_7316).

namep(_7240,_7241,_7242,[namep,_7331,_7360,_7389,_7418,_7457,_7501],_7311,_7313) --> 
    not_look_ahead([dere],_7331,_7311,_7348),
    not_look_ahead([du],_7360,_7348,_7377),
    not_look_ahead(w(nb(_7278,_7279)),_7389,_7377,_7406),
    plausible_name(_7261,_7262,_7283,_7418,_7406,_7439),
    s0(sin,u,_7283,_7259,_7457,_7439,_7480),
    ncomps0(_7259,_7241,_7261,_7262,_7242,_7240,_7501,_7480,_7313).

namep(name,_7244:thing,_7244 isa unkn,[namep,{},_7317,_7346],_7287,_7289) --> 
    {user:value(unknownflag,true)},
    unplausible_name(_7256,_7317,_7287,_7334),
    morenames(_7256,_7244,_7346,_7334,_7289).

namep(0,_7241,_7242,[namep,_7288],_7268,_7270) --> 
    measure(_7241,_7242,_7288,_7268,_7270).

namep(name,_7241,_7242,[namep,_7300,_7324],_7280,_7282) --> 
    you(_7300,_7280,_7315),
    pushstack(first,w(name(tuc,n,savant)),nil,_7315,_7334),
    nameq(_7241,_7242,_7324,_7334,_7282).

namep(0,_7241,_7242,[namep,_7303,_7332,!,_7391],_7283,_7285) --> 
    number(_7253,_7303,_7283,_7320),
    noun(_7255,plu,_7257,n,_7259,_7260,_7332,_7320,_7359),
    !,
    reject(_7391,_7359,_7285).

namep(0,_7241,_7242,[namep,_7388,_7412,{},_7471,_7500,_7529,_7563,{},{},_7612,_7641,!,_7675],_7368,_7370) --> 
    athe0(_7388,_7368,_7403),
    noun2(_7280,_7281,n,_7286:_7287,_7284,_7412,_7403,_7437),
    {user:(\+testmember(_7287,[thing]))},
    not_look_ahead([jeg],_7471,_7437,_7488),
    not_look_ahead([du],_7500,_7488,_7517),
    nameq(_7306,_7307,_7529,_7517,_7548),
    not_look_ahead([:],_7563,_7548,_7580),
    {user:compoundtest(_7280,_7281,_7286:_7287,_7306)},
    {user:align_noun_name(_7286:_7287,_7306,_7284,_7241,_7242)},
    optional_suffix(_7286:_7287,_7612,_7580,_7629),
    not_look_ahead(w(name(_7343,_7344,date)),_7641,_7629,_7658),
    !,
    accept(_7675,_7658,_7370).

namep(0,_7241,_7242,[namep,_7330,_7354,_7378,_7412,{},!,{}],_7310,_7312) --> 
    athe0(_7330,_7310,_7345),
    nr0(_7354,_7345,_7369),
    nameq1(_7265,_7271,_7378,_7369,_7397),
    noun(_7273,sin,u,n,_7264,_7266,_7412,_7397,_7312),
    {user:testmember(_7273,[bus,tram])},
    !,
    {user:align_noun_name(_7264,_7265,_7266,_7241,_7242)}.

namep(0,_7241,_7242,[namep,_7331,_7355,_7384,_7418,{},{}],_7311,_7313) --> 
    athe0(_7331,_7311,_7346),
    not_look_ahead([_7268],_7355,_7346,_7372),
    nameq1(_7262,_7272,_7384,_7372,_7403),
    noun(_7274,sin,_7276,n,_7261,_7263,_7418,_7403,_7313),
    {user:(\+testmember(_7274,[thing]))},
    {user:align_noun_name(_7261,_7262,_7263,_7241,_7242)}.

namep(name,_7241,_7242,[namep,_7295,_7324],_7275,_7277) --> 
    not_look_ahead([ett],_7295,_7275,_7312),
    nameq(_7241,_7242,_7324,_7312,_7277).

optional_suffix(_7242:_7243,[optional_suffix,_7297,{},!,_7341],_7283,_7285) --> 
    w(noun(_7256,_7257,_7258,n),_7297,_7283,_7314),
    {user:alignable(_7243,_7256)},
    !,
    accept(_7341,_7314,_7285).

optional_suffix(_7242:_7243,[optional_suffix,_7297,{},!,_7341],_7283,_7285) --> 
    w(noun(_7256,_7257,_7258,n),_7297,_7283,_7314),
    {user:alignable(_7243,_7256)},
    !,
    accept(_7341,_7314,_7285).

optional_suffix(_7242:_7243,[optional_suffix,_7276],_7262,_7264) --> 
    point0(_7276,_7262,_7264).

noun2(sin,u,n,_7246:thing,_7246 isa thing,[noun2,lit(_7261),{},_7347],_7300,_7302) --> 
    cc(_7261,_7300,_7336),
    {user:testmember(_7261,[de,disse,dem])},
    look_ahead([som],_7347,_7336,_7302).

noun2(plu,u,n,_7246:thing,_7246 isa thing,[noun2,lit(_7257),{},_7343],_7296,_7298) --> 
    cc(_7257,_7296,_7332),
    {user:testmember(_7257,[de,disse,dem])},
    not_look_ahead_np(_7343,_7332,_7298).

noun2(sin,u,n,_7246:agent,_7246 isa agent,[noun2,_7310,_7334],_7284,_7286) --> 
    agent_pronoun(_7310,_7284,_7325),
    look_ahead([som],_7334,_7325,_7286).

noun2(sin,u,n,_7246:thing,_7246 isa thing,[noun2,lit(det),_7323],_7286,_7288) --> 
    cc(det,_7286,_7322),
    look_ahead([som],_7323,_7322,_7288).

noun2(_7240,_7241,_7242,_7243,_7244,[noun2,_7337,{},_7401,!,_7430],_7311,_7313) --> 
    noun(_7258,_7240,_7241,_7242,_7243,_7244,_7337,_7311,_7364),
    {user:testmember(_7258,[monday,tuesday,wednesday,thursday,friday,saturday,sunday,month])},
    point0(_7401,_7364,_7416),
    !,
    accept(_7430,_7416,_7313).

noun2(_7240,_7241,_7242,_7246:_7247,_7244,[noun2,_7366,_7395,_7424,_7453,_7482,{},!,_7526],_7340,_7342) --> 
    w(noun(_7272,_7273,u,n),_7366,_7340,_7383),
    not_look_ahead(w(noun(number,sin,_7283,n)),_7395,_7383,_7412),
    not_look_ahead([nr],_7424,_7412,_7441),
    not_look_ahead(w(verb(_7294,_7295,_7296)),_7453,_7441,_7470),
    w(noun(_7300,_7240,_7241,_7242),_7482,_7470,_7499),
    {user:adjnoun_template(_7272,_7300,_7246:_7247,_7244)},
    !,
    accept(_7526,_7499,_7342).

noun2(_7240,_7241,_7242,_7243,_7244,[noun2,_7304],_7278,_7280) --> 
    noun(_7246,_7240,_7241,_7242,_7243,_7244,_7304,_7278,_7280).

noun2(sin,u,n,_7246:thing,_7246 isa thing,[noun2,_7313,_7337,!],_7287,_7289) --> 
    someone(_7313,_7287,_7328),
    look_ahead([som],_7337,_7328,_7289),
    !.

agent_pronoun([agent_pronoun,lit(jeg)],_7257,_7259) --> 
    cc(jeg,_7257,_7259).

agent_pronoun([agent_pronoun,lit(du)],_7257,_7259) --> 
    cc(du,_7257,_7259).

agent_pronoun([agent_pronoun,lit(noen)],_7257,_7259) --> 
    cc(noen,_7257,_7259).

agent_pronoun([agent_pronoun,lit(mange)],_7257,_7259) --> 
    cc(mange,_7257,_7259).

agent_pronoun([agent_pronoun,lit('få')],_7257,_7259) --> 
    cc('få',_7257,_7259).

agent_pronoun([agent_pronoun,lit(han)],_7257,_7259) --> 
    cc(han,_7257,_7259).

agent_pronoun([agent_pronoun,lit(ham)],_7257,_7259) --> 
    cc(ham,_7257,_7259).

agent_pronoun([agent_pronoun,lit(hun)],_7257,_7259) --> 
    cc(hun,_7257,_7259).

agent_pronoun([agent_pronoun,lit(henne)],_7257,_7259) --> 
    cc(henne,_7257,_7259).

agent_pronoun([agent_pronoun,lit(dere)],_7257,_7259) --> 
    cc(dere,_7257,_7259).

agent_pronoun([agent_pronoun,lit(alle)],_7257,_7259) --> 
    cc(alle,_7257,_7259).

noun(_7240,_7241,_7242,_7243,_7247:_7240,_7247 isa _7240,[noun,_7316],_7287,_7289) --> 
    w(noun(_7240,_7241,_7242,_7243),_7316,_7287,_7289).

measure(_7240,_7241,[measure,_7323,{},_7387,_7421,_7445,!,{}],_7306,_7308) --> 
    noun(_7269,_7270,_7271,n,_7263,_7265,_7323,_7306,_7350),
    {user:measureclass(_7269)},
    gmem(_7269,[crown],_7387,_7350,_7406),
    point0(_7421,_7406,_7436),
    anumber(_7264,_7445,_7436,_7308),
    !,
    {user:align_measure(_7263,_7264,_7265,_7240,_7241)}.

measure(_7240,_7241,[measure,_7320,_7349,_7373,_7427,_7451,{},{}],_7303,_7305) --> 
    anumber(_7264,_7320,_7303,_7337),
    point0(_7349,_7337,_7364),
    noun(_7271,_7272,_7273,n,_7263,_7265,_7373,_7364,_7400),
    point0(_7427,_7400,_7442),
    not_overon_clock(_7271,_7451,_7442,_7305),
    {user:measureclass(_7271)},
    {user:align_measure(_7263,_7264,_7265,_7240,_7241)}.

not_overon_clock(_7240,[not_overon_clock,{},_7331,{},_7370,!,_7404],_7307,_7309) --> 
    {user:testmember(_7240,[hour,minute,second])},
    prep1(_7268,_7331,_7307,_7348),
    {user:testmember(_7268,[on,before,over,after])},
    look_ahead(w(nb(_7287,_7288)),_7370,_7348,_7387),
    !,
    reject(_7404,_7387,_7309).

not_overon_clock(_7240,[not_overon_clock,[]],_7259,_7259) --> 
    [].

nameq(_7240,_7241,[nameq,_7292,_7326],_7275,_7277) --> 
    nameq1(_7240,_7241,_7292,_7275,_7311),
    not_look_ahead(w(nb(_7250,_7251)),_7326,_7311,_7277).

nameq(_7240,_7241,[nameq,_7292,_7326],_7275,_7277) --> 
    nameq2(_7240,_7241,_7292,_7275,_7311),
    not_look_ahead(w(nb(_7250,_7251)),_7326,_7311,_7277).

name1g('Rønning':lastname,'Rønning' isa lastname,_7242,[name1g,{},_7343,_7372,_7401,!,_7435],_7313,_7315) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',_7275,firstname)),_7343,_7313,_7360),
    w(name('Rønning',_7242,lastname),_7372,_7360,_7389),
    not_look_ahead(w(name(_7288,_7289,lastname)),_7401,_7389,_7418),
    !,
    accept(_7435,_7418,_7315).

name1g('Ståle':firstname,'Ståle' isa firstname,n,[name1g,{},_7343,_7372,_7401,!,_7435],_7313,_7315) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Ståle',_7275,lastname)),_7343,_7313,_7360),
    w(name('Ståle',n,firstname),_7372,_7360,_7389),
    look_ahead(w(name(_7288,_7289,lastname)),_7401,_7389,_7418),
    !,
    accept(_7435,_7418,_7315).

name1g('Rønning':lastname,'Rønning' isa lastname,_7242,[name1g,{},_7343,_7372,_7401,!,_7435],_7313,_7315) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',_7275,firstname)),_7343,_7313,_7360),
    w(name('Rønning',_7242,lastname),_7372,_7360,_7389),
    not_look_ahead(w(name(_7288,n,lastname)),_7401,_7389,_7418),
    !,
    accept(_7435,_7418,_7315).

name1g('Rønning':firstname,'Rønning' isa firstname,n,[name1g,{},_7343,_7372,_7401,!,_7435],_7313,_7315) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',_7275,lastname)),_7343,_7313,_7360),
    w(name('Rønning',n,firstname),_7372,_7360,_7389),
    look_ahead(w(name(_7288,n,lastname)),_7401,_7389,_7418),
    !,
    accept(_7435,_7418,_7315).

name1g(_7244:_7245,_7244 isa _7245,_7242,[name1g,_7298],_7278,_7280) --> 
    wnameg(_7244:_7245,_7242,_7245,_7298,_7278,_7280).

wnameg(_7244:_7242,gen,_7242,[wnameg,_7300,_7329,!],_7280,_7282) --> 
    w(name(_7244,n,_7242),_7300,_7280,_7317),
    sin(_7329,_7317,_7282),
    !.

wnameg(_7244:_7242,gen,_7242,[wnameg,_7300,_7329,!],_7280,_7282) --> 
    w(name(_7244,gen,_7242),_7300,_7280,_7317),
    sin(_7329,_7317,_7282),
    !.

wnameg(_7244:_7242,gen,_7242,[wnameg,_7297,!],_7277,_7279) --> 
    w(name(_7244,gen,_7242),_7297,_7277,_7279),
    !.

wnameg(_7244:_7242,n,_7242,[wnameg,_7294],_7274,_7276) --> 
    w(name(_7244,n,_7242),_7294,_7274,_7276).

nameq1('Rønning':lastname,'Rønning' isa lastname,[nameq1,{},_7337,_7366,_7395,!,_7429],_7310,_7312) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',n,firstname)),_7337,_7310,_7354),
    w(name('Rønning',n,lastname),_7366,_7354,_7383),
    not_look_ahead(w(name(_7287,n,lastname)),_7395,_7383,_7412),
    !,
    accept(_7429,_7412,_7312).

nameq1('Rønning':firstname,'Rønning' isa firstname,[nameq1,{},_7337,_7366,_7395,!,_7429],_7310,_7312) --> 
    {user:value(teleflag,true)},
    look_ahead(w(name('Rønning',n,lastname)),_7337,_7310,_7354),
    w(name('Rønning',n,firstname),_7366,_7354,_7383),
    look_ahead(w(name(_7287,n,lastname)),_7395,_7383,_7412),
    !,
    accept(_7429,_7412,_7312).

nameq1(quote(_7249):_7247,quote(_7249)isa thing,[nameq1,_7304,!,{}],_7287,_7289) --> 
    w(quote(_7249),_7304,_7287,_7289),
    !,
    {user:type(thing,_7247)}.

nameq1(_7240,_7241,[nameq1,_7293,_7322,_7346,!,_7375],_7276,_7278) --> 
    number(_7255,_7293,_7276,_7310),
    point0(_7322,_7310,_7337),
    monthnamex(_7346,_7337,_7361),
    !,
    reject(_7375,_7361,_7278).

nameq1(_7240,_7241,[nameq1,_7297,_7326,!,_7360],_7280,_7282) --> 
    number(_7252,_7297,_7280,_7314),
    w(noun(hour,_7257,_7258,_7259),_7326,_7314,_7343),
    !,
    reject(_7360,_7343,_7282).

nameq1(_7240,_7241,[nameq1,_7300,_7329,_7353,!,_7387],_7283,_7285) --> 
    number(_7255,_7300,_7283,_7317),
    point(_7329,_7317,_7344),
    w(noun(_7259,_7260,_7261,_7262),_7353,_7344,_7370),
    !,
    reject(_7387,_7370,_7285).

nameq1(_7240,_7241,[nameq1,_7288,!,_7327],_7271,_7273) --> 
    obviousclock1(_7240,_7241,_7288,_7271,_7307),
    !,
    accept(_7327,_7307,_7273).

nameq1(_7243:_7247,_7243 isa clock,[nameq1,_7301,_7325,!,{}],_7284,_7286) --> 
    clock0(_7301,_7284,_7316),
    time2(_7243,_7325,_7316,_7286),
    !,
    {user:type(clock,_7247)}.

nameq1(_7243:_7247,_7243 isa clock,[nameq1,_7294],_7277,_7279) --> 
    plausibleclock1(_7243:_7247,_7243 isa clock,_7294,_7277,_7279).

nameq1(_7240,_7241,[nameq1,_7282],_7265,_7267) --> 
    date(_7240,_7241,_7282,_7265,_7267).

nameq1(_7243:_7244,_7241,[nameq1,_7298,_7322,!,_7356],_7281,_7283) --> 
    one(_7298,_7281,_7313),
    w(noun(_7257,sin,u,n),_7322,_7313,_7339),
    !,
    reject(_7356,_7339,_7283).

nameq1(_7243:_7247,_7243 isa _7244,[nameq1,_7328,{},{},_7377,!,_7411],_7311,_7313) --> 
    w(name(_7243,_7267,_7244),_7328,_7311,_7345),
    {user:atom(_7243)},
    {user:testmember(_7244,[language,colour])},
    look_ahead(w(noun(_7287,_7288,_7289,_7290)),_7377,_7345,_7394),
    !,
    reject(_7411,_7394,_7313).

nameq1(_7243:_7247,_7243 isa _7244,[nameq1,_7342,_7371,{},{},{},{}],_7325,_7327) --> 
    not_look_ahead(w(name,_7272,gen,_7274),_7342,_7325,_7359),
    w(name(_7243,_7279,_7244),_7371,_7359,_7327),
    {user:_7243\==1},
    {user:(_7244==unkn->value(unknownflag,true);true)},
    {user:_7279\==gen},
    {user:type(_7244,_7247)}.

nameq1(_7243:_7247,_7243 isa _7244,[nameq1,_7337,_7361,_7390,_7414,{},{},{}],_7320,_7322) --> 
    nr0(_7337,_7320,_7352),
    w(name(_7243,n,_7244),_7361,_7352,_7378),
    point0(_7390,_7378,_7405),
    not_look_ahead(w(name(_7282,_7283,date)),_7414,_7405,_7322),
    {user:(_7244==unkn->value(unknownflag,true))},
    {user:number(_7243)},
    {user:type(_7244,_7247)}.

nameq1(_7243:_7244,_7241,[nameq1,_7301,{}],_7284,_7286) --> 
    timeq1(_7243:_7244,_7241,_7301,_7284,_7286),
    {user:(number(_7243),_7243>=100)}.

nameq1(_7243:year,_7243 isa year,[nameq1,_7309,{}],_7292,_7294) --> 
    w(nb(_7243,num),_7309,_7292,_7294),
    {user:(number(_7243),_7243>=1900,_7243=<2099)}.

date(_7243:date,_7243 isa date,[date,_7371,{},_7410,_7434,!,{},{},{},{}],_7354,_7356) --> 
    num_na(_7282,_7371,_7354,_7388),
    {user:(_7282>=1,_7282=<7)},
    slashpoint0(_7410,_7388,_7425),
    w(name(new_years_day,n,date),_7434,_7425,_7356),
    !,
    {user:datetime(_7303,_7304,_7305,_7306,_7307,_7308)},
    {user:(_7304>1->_7278 is _7303+1;_7278 is _7303)},
    {user:_7280 is _7282},
    {user:_7243=date(_7278,1,_7280)}.

date(_7243:date,_7243 isa date,[date,_7362,{},_7401,_7425,{},!,{}],_7345,_7347) --> 
    num_na(_7279,_7362,_7345,_7379),
    {user:(_7279>=1,_7279=<7)},
    slashpoint0(_7401,_7379,_7416),
    w(name(_7294,n,date),_7425,_7416,_7347),
    {user:testmember(_7294,[whitsun_day,easterday,christmas_day])},
    !,
    {user:(named_date(_7294,date(_7312,_7313,_7314)),_7276 is _7279-1,add_days(date(_7312,_7313,_7314),_7276,_7243))}.

date(_7243:date,_7243 isa date,[date,_7318,_7347,_7371,_7400,_7424,!,{}],_7301,_7303) --> 
    dayno(_7274,_7318,_7301,_7335),
    slashpoint0(_7347,_7335,_7362),
    month(_7273,_7371,_7362,_7388),
    slashpoint0(_7400,_7388,_7415),
    year(_7272,_7424,_7415,_7303),
    !,
    {user:_7243=date(_7272,_7273,_7274)}.

date(_7243:date,_7243 isa date,[date,_7333,_7362,_7386,_7415,{},!,_7454,{}],_7316,_7318) --> 
    dayno(_7277,_7333,_7316,_7350),
    slashpoint(_7362,_7350,_7377),
    month(_7276,_7386,_7377,_7403),
    point0(_7415,_7403,_7430),
    {user:(_7277>24;_7276>0)},
    !,
    xyear0(_7276,_7275,_7454,_7430,_7318),
    {user:_7243=date(_7275,_7276,_7277)}.

date(_7243:date,_7243 isa date,[date,_7319,_7348,_7372,_7401,!,_7440,{}],_7302,_7304) --> 
    dayno(_7274,_7319,_7302,_7336),
    slashpoint0(_7348,_7336,_7363),
    monthname(_7273,_7372,_7363,_7389),
    xyear0(_7273,_7272,_7401,_7389,_7420),
    !,
    accept(_7440,_7420,_7304),
    {user:_7243=date(_7272,_7273,_7274)}.

date(_7243:date,_7243 isa date,[date,_7321,_7350,_7379,!,_7413,{},!,_7452],_7304,_7306) --> 
    year(_7270,_7321,_7304,_7338),
    month(_7272,_7350,_7338,_7367),
    dayno(_7274,_7379,_7367,_7396),
    !,
    accept(_7413,_7396,_7428),
    {user:_7243=date(_7270,_7272,_7274)},
    !,
    accept(_7452,_7428,_7306).

timeq1(_7243:clock,_7243 isa clock,[timeq1,lit(halv),_7323,{},!,_7367],_7295,_7297) --> 
    cc(halv,_7295,_7322),
    hours(_7263,_7323,_7322,_7340),
    {user:_7243 is _7263*100-70},
    !,
    accept(_7367,_7340,_7297).

timeq1(_7243:clock,_7243 isa clock,[timeq1,_7293,!,_7327],_7276,_7278) --> 
    time12(_7243,_7293,_7276,_7310),
    !,
    accept(_7327,_7310,_7278).

clock_sequel(_7243:clock,_7243 isa clock,[clock_sequel,_7297,!],_7280,_7282) --> 
    clock_kernel(_7243:clock,_7243 isa clock,_7297,_7280,_7282),
    !.

clock_sequel(_7243:clock,_7243 isa clock,[clock_sequel,_7341,{},_7380,_7409,_7433,{},!,{}],_7324,_7326) --> 
    w(nb(_7280,num),_7341,_7324,_7358),
    {user:_7280<100},
    not_look_ahead([/],_7380,_7358,_7397),
    point(_7409,_7397,_7424),
    w(nb(_7276,num),_7433,_7424,_7326),
    {user:_7276<100},
    !,
    {user:_7243 is _7280*100+_7276}.

clock_sequel(_7243:clock,_7243 isa clock,[clock_sequel,_7326,_7355,{}],_7309,_7311) --> 
    w(nb(_7261,num),_7326,_7309,_7343),
    not_look_ahead([/],_7355,_7343,_7311),
    {user:(_7261>0,_7261<25->_7243 is _7261*100;_7243 is _7261)}.

clock_kernel(_7243:clock,_7243 isa clock,[clock_kernel,_7308,{},!],_7291,_7293) --> 
    number(_7243:_7258,_7308,_7291,_7293),
    {user:(_7243>2500,\+clock_test(_7243))},
    !.

clock_kernel(_7240,_7241,[clock_kernel,lit('nå'),!,_7303],_7270,_7272) --> 
    cc('nå',_7270,_7297),
    !,
    reject(_7303,_7297,_7272).

clock_kernel(_7240,_7241,[clock_kernel,lit(en),!,_7303],_7270,_7272) --> 
    cc(en,_7270,_7297),
    !,
    reject(_7303,_7297,_7272).

clock_kernel(_7240,_7241,[clock_kernel,lit(et),!,_7303],_7270,_7272) --> 
    cc(et,_7270,_7297),
    !,
    reject(_7303,_7297,_7272).

clock_kernel(_7243:clock,_7243 isa clock,[clock_kernel,_7369,_7398,_7427,{},_7466,_7495,_7524,_7553,!,_7602],_7352,_7354) --> 
    not_look_ahead(w(name(_7280,n,route)),_7369,_7352,_7386),
    not_look_ahead(w(name(_7288,n,nightbus)),_7398,_7386,_7415),
    w(nb(_7243,num),_7427,_7415,_7444),
    {user:(_7243>=100,clock_test(_7243))},
    not_look_ahead(w(noun(_7311,plu,_7313,_7314)),_7466,_7444,_7483),
    not_look_ahead([tusen],_7495,_7483,_7512),
    not_look_ahead([millioner],_7524,_7512,_7541),
    optional(w(noun(time,sin,def,n)),_7553,_7541,_7585),
    !,
    accept(_7602,_7585,_7354).

clock_kernel(_7240,_7241,[clock_kernel,_7295,_7324,_7348,!,_7382],_7278,_7280) --> 
    num_na(_7255,_7295,_7278,_7312),
    point0(_7324,_7312,_7339),
    monthname(_7257,_7348,_7339,_7365),
    !,
    reject(_7382,_7365,_7280).

clock_kernel(_7243:clock,_7243 isa clock,[clock_kernel,{},_7328,_7357,_7386,!,_7420],_7301,_7303) --> 
    {user:value(busflag,true)},
    hours(_7272,_7328,_7301,_7345),
    colemin0(_7274,_7357,_7345,_7374),
    w(name(_7278,_7279,month),_7386,_7374,_7403),
    !,
    reject(_7420,_7403,_7303).

clock_kernel(_7243:clock,_7243 isa clock,[clock_kernel,{},_7330,_7359,{},!,_7403],_7303,_7305) --> 
    {user:value(busflag,true)},
    hours(_7272,_7330,_7303,_7347),
    colemin0(_7274,_7359,_7347,_7376),
    {user:dedicated_date(date(_7280,_7272,_7274))},
    !,
    reject(_7403,_7376,_7305).

clock_kernel(_7240,_7241,[clock_kernel,_7308,_7337,_7366,{},!,_7410],_7291,_7293) --> 
    hours(_7258,_7308,_7291,_7325),
    colemin2(_7260,_7337,_7325,_7354),
    w(nb(_7264,num),_7366,_7354,_7383),
    {user:_7264>=60},
    !,
    reject(_7410,_7383,_7293).

clock_kernel(_7243:clock,_7243 isa clock,[clock_kernel,_7321,_7350,!,_7384,{}],_7304,_7306) --> 
    hours24(_7269,_7321,_7304,_7338),
    colemin2(_7267,_7350,_7338,_7367),
    !,
    optional(w(noun(time,sin,def,n)),_7384,_7367,_7306),
    {user:_7243 is _7269*100+_7267}.

clock_kernel(_7243:clock,_7243 isa clock,[clock_kernel,_7293,!,_7327],_7276,_7278) --> 
    time012(_7243,_7293,_7276,_7310),
    !,
    accept(_7327,_7310,_7278).

clock_kernel(_7243:clock,_7243 isa clock,[clock_kernel,_7287],_7270,_7272) --> 
    timeoff(_7243,_7287,_7270,_7272).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(et)],_7270,_7272) --> 
    cc(et,_7270,_7272).

clock_kernel(1300:clock,1300 isa clock,[clock_kernel,lit(en)],_7270,_7272) --> 
    cc(en,_7270,_7272).

clock_kernel(_7243:clock,_7243 isa clock,[clock_kernel,_7343,{},_7382,_7411,{}],_7326,_7328) --> 
    w(nb(_7268,num),_7343,_7326,_7360),
    {user:_7268>9},
    not_look_ahead(w(noun(minute,_7281,_7282,_7283)),_7382,_7360,_7399),
    not_look_ahead([/],_7411,_7399,_7328),
    {user:(_7268>0,_7268<25->_7243 is _7268*100;fail)}.

namenb(1,[namenb,lit(ett),_7302,!,_7336],_7277,_7279) --> 
    cc(ett,_7277,_7301),
    w(noun(_7255,_7256,_7257,_7258),_7302,_7301,_7319),
    !,
    reject(_7336,_7319,_7279).

namenb(1,[namenb,lit(ett),!,_7297],_7267,_7269) --> 
    cc(ett,_7267,_7291),
    !,
    accept(_7297,_7291,_7269).

namenb(_7240,[namenb,_7279,!,_7308],_7265,_7267) --> 
    a(_7279,_7265,_7294),
    !,
    reject(_7308,_7294,_7267).

namenb(_7240,[namenb,_7279],_7265,_7267) --> 
    w(name(_7240,n,_7246),_7279,_7265,_7267).

namenb(_7240,[namenb,_7278],_7264,_7266) --> 
    w(nb(_7240,num),_7278,_7264,_7266).

dayno(_7240,[dayno,_7289,{}],_7275,_7277) --> 
    num_na(_7240,_7289,_7275,_7277),
    {user:(_7240>0,_7240=<31)}.

month(_7240,[month,_7278,!],_7264,_7266) --> 
    monthnamed(_7240,_7278,_7264,_7266),
    !.

month(_7240,[month,_7275],_7261,_7263) --> 
    monthnum(_7240,_7275,_7261,_7263).

monthnamed(_7240,[monthnamed,_7281,_7310,!],_7267,_7269) --> 
    monthname(_7240,_7281,_7267,_7298),
    point0(_7310,_7298,_7269),
    !.

monthname(_7240,[monthname,_7287,{}],_7273,_7275) --> 
    w(name(_7247,n,_7254),_7287,_7273,_7275),
    {user:monthnumber(_7247,_7240)}.

monthnum(_7240,[monthnum,_7292,{}],_7278,_7280) --> 
    number(_7240:_7256,_7292,_7278,_7280),
    {user:(_7240>0,_7240=<12)}.

monthnamex([monthnamex,_7268],_7257,_7259) --> 
    monthname(_7240,_7268,_7257,_7259).

monthnamex([monthnamex,_7280,{}],_7269,_7271) --> 
    w(name(_7245,_7251,_7252),_7280,_7269,_7271),
    {user:named_date(_7245,_7246)}.

day(_7240,[day,_7287,{}],_7273,_7275) --> 
    w(noun(_7240,_7252,_7253,_7254),_7287,_7273,_7275),
    {user:dayname(_7240)}.

day(weekday,[day,_7280],_7266,_7268) --> 
    w(noun(weekday,_7245,_7246,_7247),_7280,_7266,_7268).

xyear0(_7240,_7241,[xyear0,_7290,_7314,!,_7348],_7273,_7275) --> 
    aar0(_7290,_7273,_7305),
    year(_7241,_7314,_7305,_7331),
    !,
    accept(_7348,_7331,_7275).

xyear0(_7240,_7241,[xyear0,{},{}],_7275,_7275) --> 
    {user:this_year(_7249)},
    {user:adjust_year(_7240,_7249,_7241)}.

year0(_7240,[year0,_7284,_7308,!,_7342],_7270,_7272) --> 
    aar0(_7284,_7270,_7299),
    year(_7240,_7308,_7299,_7325),
    !,
    accept(_7342,_7325,_7272).

year0(_7240,[year0,{}],_7263,_7263) --> 
    {user:this_year(_7240)}.

aar0([aar0,_7279,_7303,!],_7268,_7270) --> 
    point0(_7279,_7268,_7294),
    w(noun(year,_7249,_7250,n),_7303,_7294,_7270),
    !.

aar0([aar0,_7266],_7255,_7257) --> 
    point0(_7266,_7255,_7257).

year(_7240,[year,{},_7319,{},!,_7363],_7295,_7297) --> 
    {user:value(busflag,true)},
    number(_7240:_7265,_7319,_7295,_7336),
    {user:(_7240>=2000,_7240=<9999)},
    !,
    accept(_7363,_7336,_7297).

year(_7240,[year,_7298,{},!,_7342],_7284,_7286) --> 
    number(_7240:_7254,_7298,_7284,_7315),
    {user:(_7240>=1000,_7240=<9999)},
    !,
    accept(_7342,_7315,_7286).

year(_7240,[year,_7309,{},!,_7353,{}],_7295,_7297) --> 
    number(_7259:_7265,_7309,_7295,_7326),
    {user:(_7259>=0,_7259=<99)},
    !,
    accept(_7353,_7326,_7297),
    {user:_7240 is _7259+2000}.

timexp(_7240,[timexp,_7278,_7302],_7264,_7266) --> 
    clock0(_7278,_7264,_7293),
    time2(_7240,_7302,_7293,_7266).

timexp(_7240,[timexp,_7278,_7302],_7264,_7266) --> 
    clock0(_7278,_7264,_7293),
    time1(_7240,_7302,_7293,_7266).

timenexp(_7240,[timenexp,_7278,_7302],_7264,_7266) --> 
    clock(_7278,_7264,_7293),
    time2(_7240,_7302,_7293,_7266).

timenexp(_7240,[timenexp,_7278,_7302],_7264,_7266) --> 
    clock(_7278,_7264,_7293),
    time1(_7240,_7302,_7293,_7266).

clock_time(1300,[clock_time,_7279,!,_7308],_7265,_7267) --> 
    a(_7279,_7265,_7294),
    !,
    accept(_7308,_7294,_7267).

clock_time(1300,[clock_time,lit('nå'),!,_7297],_7267,_7269) --> 
    cc('nå',_7267,_7291),
    !,
    reject(_7297,_7291,_7269).

clock_time(_7240,[clock_time,_7300,_7329,{},_7368],_7286,_7288) --> 
    hours(_7254,_7300,_7286,_7317),
    colemin0(_7256,_7329,_7317,_7346),
    {user:_7251 is _7254*100+_7256},
    ampm0(_7251,_7240,_7368,_7346,_7288).

clock_time(_7240,[clock_time,_7275],_7261,_7263) --> 
    time12(_7240,_7275,_7261,_7263).

time012(_7240,[time012,_7275],_7261,_7263) --> 
    time12(_7240,_7275,_7261,_7263).

time012(_7240,[time012,_7328,{},_7367,_7396,{}],_7314,_7316) --> 
    w(nb(_7265,num),_7328,_7314,_7345),
    {user:_7265>1},
    not_look_ahead(w(noun(minute,_7283,_7284,_7285)),_7367,_7345,_7384),
    not_look_ahead([/],_7396,_7384,_7316),
    {user:(_7265>0,_7265<25,_7240 is _7265*100)}.

time012(100,[time012,_7291,_7320,_7349,!],_7277,_7279) --> 
    w(nb(1,num),_7291,_7277,_7308),
    not_look_ahead([/],_7320,_7308,_7337),
    not_look_ahead_np(_7349,_7337,_7279),
    !.

time12(_7240,[time12,_7285,_7314],_7271,_7273) --> 
    time2(_7240,_7285,_7271,_7302),
    w(noun(time,sin,def,n),_7314,_7302,_7273).

time12(_7240,[time12,_7275],_7261,_7263) --> 
    time2(_7240,_7275,_7261,_7263).

time12(_7240,[time12,_7288,_7317,_7341],_7274,_7276) --> 
    time1(_7240,_7288,_7274,_7305),
    point0(_7317,_7305,_7332),
    w(noun(time,sin,def,n),_7341,_7332,_7276).

timeoff(_7240,[timeoff,_7319,{},_7358,_7382,{},{}],_7305,_7307) --> 
    w(nb(_7267,num),_7319,_7305,_7336),
    {user:_7267<100},
    colon0(_7358,_7336,_7373),
    w(nb(_7263,num),_7382,_7373,_7307),
    {user:_7263<100},
    {user:_7240 is _7267*100+_7263}.

time1(_7240,[time1,_7284,!,_7318],_7270,_7272) --> 
    w(nb(0,_7251),_7284,_7270,_7301),
    !,
    reject(_7318,_7301,_7272).

time1(_7240,[time1,lit(ett),_7314,_7343,!,_7377],_7289,_7291) --> 
    cc(ett,_7289,_7313),
    not_look_ahead(w(noun(time,_7261,def,_7263)),_7314,_7313,_7331),
    w(noun(_7267,_7268,_7269,_7270),_7343,_7331,_7360),
    !,
    reject(_7377,_7360,_7291).

time1(100,[time1,lit(ett),_7304,!,_7353],_7279,_7281) --> 
    cc(ett,_7279,_7303),
    optional(w(noun(time,_7258,def,_7260)),_7304,_7303,_7336),
    !,
    accept(_7353,_7336,_7281).

time1(_7240,[time1,_7291,_7315,!,_7349],_7277,_7279) --> 
    a(_7291,_7277,_7306),
    not_look_ahead(w(noun(time,_7256,def,_7258)),_7315,_7306,_7332),
    !,
    reject(_7349,_7332,_7279).

time1(_7240,[time1,_7287,_7316,!,_7355],_7273,_7275) --> 
    time3(_7251,_7287,_7273,_7304),
    ampm0(_7251,_7240,_7316,_7304,_7335),
    !,
    accept(_7355,_7335,_7275).

time1(_7240,[time1,_7325,_7354,_7383,{},!,{},_7437],_7311,_7313) --> 
    w(nb(_7265,num),_7325,_7311,_7342),
    not_look_ahead(w(noun(hour,_7273,_7274,_7275)),_7354,_7342,_7371),
    not_look_ahead([t],_7383,_7371,_7400),
    {user:_7265<25},
    !,
    {user:_7260 is _7265*100},
    ampm0(_7260,_7240,_7437,_7400,_7313).

time1(now,[time1,lit('nå'),lit(av),!,_7313],_7272,_7274) --> 
    cc('nå',_7272,_7296),
    cc(av,_7296,_7307),
    !,
    reject(_7313,_7307,_7274).

time1(now,[time1,lit('nå')],_7261,_7263) --> 
    cc('nå',_7261,_7263).

time2(_7240,[time2,_7325,{},_7364,_7388,{},!,_7432,{}],_7311,_7313) --> 
    hours24(_7271,_7325,_7311,_7342),
    {user:_7271=<25},
    point(_7364,_7342,_7379),
    num(_7269,_7388,_7379,_7405),
    {user:(_7269>12,_7269<60)},
    !,
    accept(_7432,_7405,_7313),
    {user:_7240 is _7271*100+_7269}.

time2(_7240,[time2,_7309,_7338,!,{},_7382,{}],_7295,_7297) --> 
    num(_7263,_7309,_7295,_7326),
    w(prep(over),_7338,_7326,_7355),
    !,
    {user:_7263<60},
    hours30(_7262,_7382,_7355,_7297),
    {user:_7240 is _7262+_7263}.

time2(_7240,[time2,_7308,_7337,_7361,!,{},_7400,{}],_7294,_7296) --> 
    num(_7266,_7308,_7294,_7325),
    minutes(_7337,_7325,_7352),
    overclock(_7361,_7352,_7376),
    !,
    {user:_7266<60},
    hours30(_7265,_7400,_7376,_7296),
    {user:_7240 is _7265+_7266}.

time2(_7240,[time2,_7307,{},_7346,!,_7380,{}],_7293,_7295) --> 
    num(_7260,_7307,_7293,_7324),
    {user:_7260<60},
    w(prep(on),_7346,_7324,_7363),
    !,
    hours30(_7259,_7380,_7363,_7295),
    {user:subfromtime(_7259,_7260,_7240)}.

time2(_7240,[time2,_7309,_7338,_7362,!,{},_7401,_7425,{}],_7295,_7297) --> 
    num(_7266,_7309,_7295,_7326),
    minutes(_7338,_7326,_7353),
    onclock(_7362,_7353,_7377),
    !,
    {user:_7266<60},
    clock0(_7401,_7377,_7416),
    hours30(_7265,_7425,_7416,_7297),
    {user:subfromtime(_7265,_7266,_7240)}.

time2(_7240,[time2,_7315,lit(halv),_7370,{},_7409],_7301,_7303) --> 
    optional(w(prep(in)),_7315,_7301,_7347),
    cc(halv,_7347,_7369),
    hours100(_7271,_7370,_7369,_7387),
    {user:_7240 is _7271-100+30},
    optional(w(noun(time,sin,def,n)),_7409,_7387,_7303).

time2(_7240,[time2,lit(halv),_7310,!,_7344,{}],_7285,_7287) --> 
    cc(halv,_7285,_7309),
    prep1(over,_7310,_7309,_7327),
    !,
    hours100(_7259,_7344,_7327,_7287),
    {user:_7240 is _7259+30}.

time2(_7240,[time2,lit(kvart),_7308,_7332,{}],_7283,_7285) --> 
    cc(kvart,_7283,_7307),
    onclock(_7308,_7307,_7323),
    hours100(_7261,_7332,_7323,_7285),
    {user:_7240 is _7261-100+45}.

time2(_7240,[time2,lit(kvart),_7308,_7332,{}],_7283,_7285) --> 
    cc(kvart,_7283,_7307),
    overclock(_7308,_7307,_7323),
    hours(_7261,_7332,_7323,_7285),
    {user:_7240 is _7261*100+15}.

time2(_7240,[time2,_7302,_7331,_7360,{},!,_7404],_7288,_7290) --> 
    hours(_7257,_7302,_7288,_7319),
    minutes(_7259,_7331,_7319,_7348),
    number(_7263:_7264,_7360,_7348,_7377),
    {user:_7263>24},
    !,
    reject(_7404,_7377,_7290).

time2(_7240,[time2,_7295,_7324,_7353,!,_7387],_7281,_7283) --> 
    hours(_7254,_7295,_7281,_7312),
    minutes(_7256,_7324,_7312,_7341),
    w(name(_7260,_7261,month),_7353,_7341,_7370),
    !,
    reject(_7387,_7370,_7283).

time2(_7240,[time2,_7300,_7329,{},_7368],_7286,_7288) --> 
    hours24(_7254,_7300,_7286,_7317),
    colemin(_7256,_7329,_7317,_7346),
    {user:_7251 is _7254*100+_7256},
    ampm0(_7251,_7240,_7368,_7346,_7288).

time2(_7240,[time2,_7294,_7323,_7352,_7376,!,_7410],_7280,_7282) --> 
    hours(_7257,_7294,_7280,_7311),
    minutes(_7259,_7323,_7311,_7340),
    point(_7352,_7340,_7367),
    minutes(_7261,_7376,_7367,_7393),
    !,
    reject(_7410,_7393,_7282).

time2(_7240,[time2,_7308,_7337,{},{},_7386],_7294,_7296) --> 
    hours24(_7257,_7308,_7294,_7325),
    minutes(_7259,_7337,_7325,_7354),
    {user:_7259>12},
    {user:_7254 is _7257*100+_7259},
    ampm0(_7254,_7240,_7386,_7354,_7296).

onclock([onclock,_7285,{},_7324],_7274,_7276) --> 
    w(prep(_7248),_7285,_7274,_7302),
    {user:testmember(_7248,[on,before])},
    clock0(_7324,_7302,_7276).

overclock([overclock,_7285,{},_7324],_7274,_7276) --> 
    w(prep(_7248),_7285,_7274,_7302),
    {user:testmember(_7248,[over,after])},
    clock0(_7324,_7302,_7276).

hours30(_7240,[hours30,lit(halv),_7311,{},!,_7355],_7286,_7288) --> 
    cc(halv,_7286,_7310),
    hours(_7256,_7311,_7310,_7328),
    {user:_7240 is _7256*100-70},
    !,
    accept(_7355,_7328,_7288).

hours30(_7240,[hours30,_7275],_7261,_7263) --> 
    hours100(_7240,_7275,_7261,_7263).

hours100(_7240,[hours100,_7286,_7315,!,_7349],_7272,_7274) --> 
    num(_7240,_7286,_7272,_7303),
    monthname(_7253,_7315,_7303,_7332),
    !,
    reject(_7349,_7332,_7274).

hours100(_7240,[hours100,_7307,{},!,_7351],_7293,_7295) --> 
    num(_7240,_7307,_7293,_7324),
    {user:(_7240 is _7240//100*100,_7240>100,_7240<2500)},
    !,
    accept(_7351,_7324,_7295).

hours100(_7240,[hours100,_7286,{}],_7272,_7274) --> 
    hours(_7250,_7286,_7272,_7274),
    {user:_7240 is _7250*100}.

hours100(100,[hours100,lit(ett),!,_7297],_7267,_7269) --> 
    cc(ett,_7267,_7291),
    !,
    accept(_7297,_7291,_7269).

hours100(1300,[hours100,lit(et),!,_7297],_7267,_7269) --> 
    cc(et,_7267,_7291),
    !,
    accept(_7297,_7291,_7269).

time3(_7240,[time3,_7286,{}],_7272,_7274) --> 
    w(nb(_7240,num),_7286,_7272,_7274),
    {user:_7240>=60}.

ampm0(_7240,_7240,[ampm0,_7285,!,_7314],_7268,_7270) --> 
    amtime(_7285,_7268,_7300),
    !,
    accept(_7314,_7300,_7270).

ampm0(_7240,_7241,[ampm0,_7305,!,{}],_7288,_7290) --> 
    pmtime(_7305,_7288,_7290),
    !,
    {user:(_7240>1200->_7241 is _7240;_7241 is _7240+1200)}.

ampm0(_7240,_7240,[ampm0,lit(h),!],_7267,_7269) --> 
    cc(h,_7267,_7269),
    !.

ampm0(_7240,_7240,[ampm0,[]],_7262,_7262) --> 
    [].

amtime([amtime,lit(am)],_7257,_7259) --> 
    cc(am,_7257,_7259).

amtime([amtime,lit(a),lit(m)],_7262,_7264) --> 
    cc(a,_7262,_7283),
    cc(m,_7283,_7264).

pmtime([pmtime,lit(pm)],_7257,_7259) --> 
    cc(pm,_7257,_7259).

pmtime([pmtime,lit(p),lit(m)],_7262,_7264) --> 
    cc(p,_7262,_7283),
    cc(m,_7283,_7264).

hours24(_7240,[hours24,_7275],_7261,_7263) --> 
    hours(_7240,_7275,_7261,_7263).

hours(_7240,[hours,_7293,_7322,_7351,!,_7380],_7279,_7281) --> 
    not_look_ahead([ett],_7293,_7279,_7310),
    not_look_ahead([et],_7322,_7310,_7339),
    a(_7351,_7339,_7366),
    !,
    reject(_7380,_7366,_7281).

hours(_7240,[hours,_7293,{},_7332],_7279,_7281) --> 
    w(nb(_7240,num),_7293,_7279,_7310),
    {user:_7240=<25},
    optional([h],_7332,_7310,_7281).

smallhours(_7240,[smallhours,_7292,{}],_7278,_7280) --> 
    w(nb(_7240,num),_7292,_7278,_7280),
    {user:(_7240>31,_7240=<59)}.

minutes0([minutes0,_7272,!,_7301],_7261,_7263) --> 
    minutes(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

minutes0([minutes0,[]],_7255,_7255) --> 
    [].

minutes([minutes,_7279,!,_7313],_7268,_7270) --> 
    w(noun(minute,_7249,_7250,_7251),_7279,_7268,_7296),
    !,
    accept(_7313,_7296,_7270).

colemin0(_7240,[colemin0,_7281,!,_7315],_7267,_7269) --> 
    colemin(_7240,_7281,_7267,_7298),
    !,
    accept(_7315,_7298,_7269).

colemin0(_7240,[colemin0,_7284,_7308,!,_7342],_7270,_7272) --> 
    point0(_7284,_7270,_7299),
    minutes0(_7240,_7308,_7299,_7325),
    !,
    accept(_7342,_7325,_7272).

colemin2(_7240,[colemin2,_7289,_7318,_7342,!,_7376],_7275,_7277) --> 
    minutes(_7254,_7289,_7275,_7306),
    point(_7318,_7306,_7333),
    minutes(_7256,_7342,_7333,_7359),
    !,
    reject(_7376,_7359,_7277).

colemin2(_7240,[colemin2,_7287,_7311,_7340,!,_7369],_7273,_7275) --> 
    colon(_7287,_7273,_7302),
    minutes(_7240,_7311,_7302,_7328),
    colesec0(_7340,_7328,_7355),
    !,
    accept(_7369,_7355,_7275).

colemin2(_7240,[colemin2,_7287,_7311,!,_7345],_7273,_7275) --> 
    colon(_7287,_7273,_7302),
    w(nb(_7240,num),_7311,_7302,_7328),
    !,
    reject(_7345,_7328,_7275).

colemin2(0,[colemin2,_7279,!,_7308],_7265,_7267) --> 
    colon(_7279,_7265,_7294),
    !,
    accept(_7308,_7294,_7267).

colemin2(_7240,[colemin2,_7284,_7308,_7337,!],_7270,_7272) --> 
    point0(_7284,_7270,_7299),
    minutes(_7240,_7308,_7299,_7325),
    point0(_7337,_7325,_7272),
    !.

colemin2(_7240,[colemin2,_7281,_7310,!],_7267,_7269) --> 
    minutes(_7240,_7281,_7267,_7298),
    point0(_7310,_7298,_7269),
    !.

colemin(_7240,[colemin,_7297,{},_7336,_7360,!,_7394],_7283,_7285) --> 
    minutes(_7257,_7297,_7283,_7314),
    {user:_7257\==0},
    point(_7336,_7314,_7351),
    minutes(_7264,_7360,_7351,_7377),
    !,
    reject(_7394,_7377,_7285).

colemin(_7240,[colemin,_7287,_7311,!,_7345,_7369],_7273,_7275) --> 
    colon(_7287,_7273,_7302),
    minutes(_7240,_7311,_7302,_7328),
    !,
    accept(_7345,_7328,_7360),
    colesec0(_7369,_7360,_7275).

colemin(_7240,[colemin,_7298,_7322,{},!,_7366],_7284,_7286) --> 
    point(_7298,_7284,_7313),
    minutes(_7240,_7322,_7313,_7339),
    {user:(_7240=0;_7240>12)},
    !,
    colesec0(_7366,_7339,_7286).

colemin(_7240,[colemin,_7287,_7311,!,_7345],_7273,_7275) --> 
    colon(_7287,_7273,_7302),
    w(nb(_7240,num),_7311,_7302,_7328),
    !,
    reject(_7345,_7328,_7275).

colemin(0,[colemin,_7279,!,_7308],_7265,_7267) --> 
    colon(_7279,_7265,_7294),
    !,
    accept(_7308,_7294,_7267).

colesec0([colesec0,lit(:),_7287,!],_7265,_7267) --> 
    cc(:,_7265,_7286),
    minutes(_7248,_7287,_7286,_7267),
    !.

colesec0([colesec0,[]],_7255,_7255) --> 
    [].

minutes0(_7240,[minutes0,_7281,!,_7315],_7267,_7269) --> 
    minutes(_7240,_7281,_7267,_7298),
    !,
    accept(_7315,_7298,_7269).

minutes0(0,[minutes0,[]],_7259,_7259) --> 
    [].

minutes(_7240,[minutes,_7279,!,_7308],_7265,_7267) --> 
    a(_7279,_7265,_7294),
    !,
    reject(_7308,_7294,_7267).

minutes(_7240,[minutes,_7286,{}],_7272,_7274) --> 
    w(nb(_7240,num),_7286,_7272,_7274),
    {user:_7240<100}.

nameq2(_7243:_7247,_7243 isa number,[nameq2,_7302,_7331,_7355,!,_7384],_7285,_7287) --> 
    number(_7243:_7247,_7302,_7285,_7319),
    point0(_7331,_7319,_7346),
    monthnamex(_7355,_7346,_7370),
    !,
    reject(_7384,_7370,_7287).

nameq2(_7240,_7241,[nameq2,_7295,_7319,!,_7353],_7278,_7280) --> 
    one(_7295,_7278,_7310),
    w(noun(_7254,sin,u,n),_7319,_7310,_7336),
    !,
    reject(_7353,_7336,_7280).

nameq2(_7243:_7244,_7243 isa _7244,[nameq2,_7324,_7353,{},_7387,{},!],_7307,_7309) --> 
    number(_7243:_7267,_7324,_7307,_7341),
    point(_7353,_7341,_7368),
    {user:(\+_7243=1)},
    w(noun(_7244,sin,u,n),_7387,_7368,_7309),
    {user:alignable(_7244,number)},
    !.

nameq2(_7243:_7247,_7243 isa clock,[nameq2,{},_7326,{},{},!],_7299,_7301) --> 
    {user:type(clock,_7247)},
    number(_7243:_7269,_7326,_7299,_7301),
    {user:_7243>=1000},
    {user:clock_test(_7243)},
    !.

nameq2(_7243:_7247,_7243 isa number,[nameq2,_7290],_7273,_7275) --> 
    number(_7243:_7247,_7290,_7273,_7275).

number(_7242:number,[number,_7319,lit('.'),_7359,{},!,{}],_7305,_7307) --> 
    num(_7268,_7319,_7305,_7336),
    cc('.',_7336,_7358),
    num(_7266,_7359,_7358,_7307),
    {user:(_7266>=100,_7266<1000)},
    !,
    {user:_7242 is _7268*1000+_7266}.

number(2:_7243,[number,_7294,_7318,{}],_7280,_7282) --> 
    a(_7294,_7280,_7309),
    w(noun(pair,_7259,_7260,_7261),_7318,_7309,_7282),
    {user:type(number,_7243)}.

number(_7242:_7243,[number,_7305,_7329,{},_7368,{}],_7291,_7293) --> 
    only0(_7305,_7291,_7320),
    num(_7262,_7329,_7320,_7346),
    {user:type(number,_7243)},
    thousands0(_7263,_7368,_7346,_7293),
    {user:_7242 is _7262*_7263}.

number(_7240,[number,_7291,_7315,!,_7349],_7277,_7279) --> 
    a(_7291,_7277,_7306),
    not_look_ahead(w(noun(time,_7256,def,_7258)),_7315,_7306,_7332),
    !,
    reject(_7349,_7332,_7279).

thousands0(1000,[thousands0,_7276,!],_7262,_7264) --> 
    tusen(_7276,_7262,_7264),
    !.

thousands0(1000000,[thousands0,_7276,!],_7262,_7264) --> 
    million(_7276,_7262,_7264),
    !.

thousands0(1000000000,[thousands0,_7279,!],_7265,_7267) --> 
    milliard(_7279,_7265,_7267),
    !.

thousands0(1,[thousands0,[]],_7259,_7259) --> 
    [].

tusen([tusen,lit(tusen)],_7257,_7259) --> 
    cc(tusen,_7257,_7259).

tusen([tusen,lit(tusener)],_7257,_7259) --> 
    cc(tusener,_7257,_7259).

million([million,lit(million)],_7257,_7259) --> 
    cc(million,_7257,_7259).

million([million,lit(millioner)],_7257,_7259) --> 
    cc(millioner,_7257,_7259).

milliard([milliard,lit(milliard)],_7257,_7259) --> 
    cc(milliard,_7257,_7259).

milliard([milliard,lit(milliarder)],_7257,_7259) --> 
    cc(milliarder,_7257,_7259).

anumber(_7240,[anumber,_7284,_7308,!,_7342],_7270,_7272) --> 
    a0(_7284,_7270,_7299),
    number(_7240,_7308,_7299,_7325),
    !,
    accept(_7342,_7325,_7272).

anumber(1:_7243,[anumber,_7287,!,{}],_7273,_7275) --> 
    art1(_7287,_7273,_7275),
    !,
    {user:type(number,_7243)}.

intrans_verb(work,_7241,id,_7243,_7244,_7245,_7246,[intrans_verb,_7331,_7375,{}],_7299,_7301) --> 
    lexv(tv,hold,_7245,_7246,_7331,_7299,_7354),
    w(prep(on),_7375,_7354,_7301),
    {user:iv_template(work,_7241,_7243,_7244)}.

intrans_verb(be1,_7241,id,_7243,_7244,_7245,_7246,[intrans_verb,_7331,_7375,{}],_7299,_7301) --> 
    lexv(tv,hold,_7245,_7246,_7331,_7299,_7354),
    w(prep(to),_7375,_7354,_7301),
    {user:iv_template(be1,_7241,_7243,_7244)}.

intrans_verb(_7240,_7241,id,_7243,_7244,_7245,_7246,[intrans_verb,_7324,{}],_7292,_7294) --> 
    lexv(iv,_7240,_7245,_7246,_7324,_7292,_7294),
    {user:iv_template(_7240,_7241,_7243,_7244)}.

intrans_verb(be1,_7241,_7242,_7243,_7244,pres,fin,[intrans_verb,_7343,_7372,_7401,{}],_7311,_7313) --> 
    not_look_ahead(w(verb(go,_7269,fin)),_7343,_7311,_7360),
    be1(_7242,_7372,_7360,_7389),
    not_look_ahead(w(verb(_7278,_7279,_7280)),_7401,_7389,_7313),
    {user:iv_template(be1,_7241,_7243,_7244)}.

intrans_verb(_7240,_7241,_7242,_7243,_7244,past,fin,[intrans_verb,_7332,_7361,_7385,{}],_7300,_7302) --> 
    has(_7242,_7332,_7300,_7349),
    now0(_7361,_7349,_7376),
    lexv(iv,_7240,past,part,_7385,_7376,_7302),
    {user:iv_template(_7240,_7241,_7243,_7244)}.

trans_verbs(_7240,_7241,_7242,_7243,_7244,[trans_verbs,_7316,_7380],_7290,_7292) --> 
    trans_verb(_7249,_7241,_7242,id,_7243,_7261,_7262,_7263,_7316,_7290,_7347),
    trans_verbs0(_7249,_7240,_7241,_7242,_7243,_7244,_7380,_7347,_7292).

trans_verbs0(_7240,_7241,_7242,_7243,_7244,_7245,[trans_verbs0,_7328,_7352,_7416],_7299,_7301) --> 
    andor(_7328,_7299,_7343),
    trans_verb(_7260,_7242,_7243,id,_7244,_7265,_7266,_7267,_7352,_7343,_7383),
    trans_verbs0((_7240,_7260),_7241,_7242,_7243,_7244,_7245,_7416,_7383,_7301).

trans_verbs0(_7240,_7240,_7250:_7251,_7253:_7254,_7244,_7240/_7250/_7253/_7244,[trans_verbs0,[]],_7289,_7289) --> 
    [].

trans_verb(tell,_7241,_7242,id,_7244,_7245,_7246,fin,[trans_verb,_7336,_7380,{}],_7301,_7303) --> 
    lexv(tv,tell,_7246,fin,_7336,_7301,_7359),
    particle0(tell,_7380,_7359,_7303),
    {user:tv_template(tell,_7241,_7242,_7244,_7245)}.

trans_verb(_7240,_7241,_7242,_7243,_7244,_7245,past,fin,[trans_verb,_7336,_7365,{}],_7301,_7303) --> 
    has(_7243,_7336,_7301,_7353),
    lexv(tv,_7240,past,part,_7365,_7353,_7303),
    {user:tv_template(_7240,_7241,_7242,_7244,_7245)}.

trans_verb(_7240,_7241,_7242,id,_7244,_7245,_7246,_7247,[trans_verb,_7331,{}],_7296,_7298) --> 
    lexv(tv,_7240,_7246,_7247,_7331,_7296,_7298),
    {user:tv_template(_7240,_7241,_7242,_7244,_7245)}.

rep_v(be_free,pres,fin,[rep_v,_7290],_7270,_7272) --> 
    w(adj2(free,nil),_7290,_7270,_7272).

rep_v(_7240,_7241,_7242,[rep_v,_7303,_7327,_7371,_7400],_7283,_7285) --> 
    aux0(_7303,_7283,_7318),
    lexv(rv,_7240,_7241,_7242,_7327,_7318,_7350),
    reflexiv0(_7240,_7371,_7350,_7388),
    rep_particlev0(_7240,_7400,_7388,_7285).

rep_v(want,pres,fin,[rep_v,lit(skal),!,_7309],_7273,_7275) --> 
    cc(skal,_7273,_7303),
    !,
    reject(_7309,_7303,_7275).

there_be_modal(think,[there_be_modal,_7287,_7311,lit(an)],_7273,_7275) --> 
    thereit(_7287,_7273,_7302),
    w(verb(go,_7253,_7254),_7311,_7302,_7328),
    cc(an,_7328,_7275).

there_be_modal(_7240,[there_be_modal,_7278,_7302],_7264,_7266) --> 
    thereit(_7278,_7264,_7293),
    be_modal(_7240,_7302,_7293,_7266).

be_there_modal(_7240,[be_there_modal,_7281,_7305,_7329],_7267,_7269) --> 
    be(_7281,_7267,_7296),
    thereit(_7305,_7296,_7320),
    be_modal(_7240,_7329,_7320,_7269).

be_modal(_7240,[be_modal,_7278,_7302],_7264,_7266) --> 
    be(_7278,_7264,_7293),
    modal(_7240,_7302,_7293,_7266).

be_modal(seem,[be_modal,_7279],_7265,_7267) --> 
    w(verb(seem,_7245,fin),_7279,_7265,_7267).

modal(_7240,[modal,_7282,_7321],_7268,_7270) --> 
    rep_v(_7240,past,part,_7282,_7268,_7303),
    tobetrue(_7245,_7321,_7303,_7270).

modal(_7240,[modal,_7277],_7263,_7265) --> 
    rep_v(_7240,_7243,fin,_7277,_7263,_7265).

modal(think,[modal,_7278],_7264,_7266) --> 
    w(adj2(possible,nil),_7278,_7264,_7266).

modal(think,[modal,_7278],_7264,_7266) --> 
    w(adj2(best,nil),_7278,_7264,_7266).

modal(free,[modal,_7278],_7264,_7266) --> 
    w(adj2(free,nil),_7278,_7264,_7266).

tobetrue(_7240,[tobetrue,_7278,_7302],_7264,_7266) --> 
    infinitive(_7278,_7264,_7293),
    be_truefalse(_7240,_7302,_7293,_7266).

tobetrue(id,[tobetrue,[]],_7259,_7259) --> 
    [].

pvimodal(_7240,_7241,[pvimodal,_7300,{},{}],_7283,_7285) --> 
    lexv(tv,_7240,_7256,fin,_7300,_7283,_7285),
    {user:_7240\==be},
    {user:pvi_templ(_7240,_7241)}.

lexvaccept(_7240,_7241,_7242,_7243,_7244,[lexvaccept,_7306,!],_7280,_7282) --> 
    hlexv(_7240,_7241,_7242,_7243,_7244,_7306,_7280,_7282),
    !.

hlexv(_7240,_7241,_7242,_7243,_7244,[hlexv,_7339,_7363,_7392,_7421,{},_7465,{}],_7313,_7315) --> 
    aux0(_7339,_7313,_7354),
    negation0(_7266,_7363,_7354,_7380),
    w(verb(_7274,_7242,_7243),_7392,_7380,_7409),
    particlev0(_7274,_7241,_7421,_7409,_7440),
    {user:verbtype(_7241,_7240)},
    negation0(_7267,_7465,_7440,_7315),
    {user:bigno(_7266,_7267,_7244)}.

hlexv(iv,_7241,_7242,fin,_7244,[hlexv,_7320,_7349,_7373,_7402,!],_7294,_7296) --> 
    w(verb(be,_7242,fin),_7320,_7294,_7337),
    now0(_7349,_7337,_7364),
    negation0(_7244,_7373,_7364,_7390),
    particlev2(be,_7241,_7402,_7390,_7296),
    !.

hlexv(_7240,_7241,past,fin,_7244,[hlexv,_7318,_7342,_7366,_7395,_7439],_7292,_7294) --> 
    has(_7318,_7292,_7333),
    danow0(_7342,_7333,_7357),
    negation0(_7244,_7366,_7357,_7383),
    lexv(_7240,_7241,past,part,_7395,_7383,_7418),
    reflexiv0(_7241,_7439,_7418,_7294).

hlexv(tv,bring,_7242,_7243,id,[hlexv,_7308,_7337],_7282,_7284) --> 
    w(verb(have,_7242,_7243),_7308,_7282,_7325),
    prep1(with,_7337,_7325,_7284).

hlexv(_7240,_7241,past,fin,_7244,[hlexv,_7325,_7354,_7383,{}],_7299,_7301) --> 
    w(verb(get,_7263,fin),_7325,_7299,_7342),
    negation0(_7244,_7354,_7342,_7371),
    w(verb(_7241,past,part),_7383,_7371,_7301),
    {user:verbtype(_7241,_7240)}.

hlexv(_7240,_7241,_7242,fin,_7244,[hlexv,_7333,_7362,_7391,{},!],_7307,_7309) --> 
    w(verb(get,_7242,fin),_7333,_7307,_7350),
    negation0(_7244,_7362,_7350,_7379),
    lexv(_7240,_7241,_7268,_7269,_7391,_7379,_7309),
    {user:(_7268\==imp,_7269\=fin)},
    !.

hlexv(_7240,_7241,past,fin,_7244,[hlexv,_7322,_7351,_7375,_7404,!],_7296,_7298) --> 
    w(verb(be,_7261,fin),_7322,_7296,_7339),
    now0(_7351,_7339,_7366),
    negation0(_7244,_7375,_7366,_7392),
    lexv(_7240,_7241,past,part,_7404,_7392,_7298),
    !.

hlexv(_7240,_7241,past,fin,_7244,[hlexv,_7313,_7337,_7361,_7390],_7287,_7289) --> 
    has(_7313,_7287,_7328),
    redundant0(_7337,_7328,_7352),
    negation0(_7244,_7361,_7352,_7378),
    lexv(_7240,_7241,past,part,_7390,_7378,_7289).

hlexv(_7240,know1,_7242,_7243,_7244,[hlexv,_7344,_7373,_7402,{},!,{}],_7318,_7320) --> 
    w(verb(know,_7242,_7243),_7344,_7318,_7361),
    negation0(_7244,_7373,_7361,_7390),
    look_ahead([_7275],_7402,_7390,_7320),
    {user:testmember(_7275,[hva,hvem,hvilken,hvilket,hvilke])},
    !,
    {user:_7240=tv}.

hlexv(tv,know1,_7242,_7243,_7244,[hlexv,_7313,_7342,lit(om)],_7287,_7289) --> 
    w(verb(know,_7242,_7243),_7313,_7287,_7330),
    negation0(_7244,_7342,_7330,_7359),
    cc(om,_7359,_7289).

hlexv(tv,_7241,_7242,fin,_7244,[hlexv,_7338,_7367,_7396,_7420,_7454,!,[]],_7312,_7314) --> 
    w(verb(get,_7242,fin),_7338,_7312,_7355),
    negation0(_7244,_7367,_7355,_7384),
    look_ahead_np(_7396,_7384,_7411),
    np1_accept(_7267,_7268,_7420,_7411,_7439),
    w(verb(_7241,past,part),_7454,_7439,_7471),
    !,
    pushstack(free,xnp(_7267,_7268),nil,_7471,_7314),
    [].

hlexv(tv,get,pres,fin,_7244,[hlexv,lit('får'),_7336,_7365,_7394,!],_7299,_7301) --> 
    cc('får',_7299,_7335),
    not_look_ahead(w(verb(_7264,inf,_7266)),_7336,_7335,_7353),
    negation0(_7244,_7365,_7353,_7382),
    optional([opp],_7394,_7382,_7301),
    !.

hlexv(iv,_7241,_7242,_7243,_7244,[hlexv,_7332,{},{},_7381,_7410],_7306,_7308) --> 
    w(verb(_7241,_7242,_7243),_7332,_7306,_7349),
    {user:rv_templ(_7241,_7271)},
    {user:tv_templ(_7241,_7276,nil)},
    negation0(_7244,_7381,_7349,_7398),
    look_ahead([om],_7410,_7398,_7308).

hlexv(_7240,_7241,_7242,_7243,_7244,[hlexv,_7346,{},_7385,_7414,!,{}],_7320,_7322) --> 
    w(verb(_7241,_7242,_7243),_7346,_7320,_7363),
    {user:testmember(_7241,[understand,believe,know])},
    negation0(_7244,_7385,_7363,_7402),
    look_ahead_lit([at,hvordan,hvorfor,'når'],_7414,_7402,_7322),
    !,
    {user:_7240=rv}.

hlexv(_7240,_7241,_7242,_7243,_7244,[hlexv,_7329,{},_7368,!,{}],_7303,_7305) --> 
    w(verb(_7241,_7242,_7243),_7329,_7303,_7346),
    {user:testmember(_7241,[believe])},
    negation0(_7244,_7368,_7346,_7305),
    !,
    {user:_7240=rv}.

hlexv(_7240,_7241,_7242,_7243,_7244,[hlexv,_7329,{},_7368,!,{}],_7303,_7305) --> 
    w(verb(_7241,_7242,_7243),_7329,_7303,_7346),
    {user:testmember(_7241,[understand])},
    negation0(_7244,_7368,_7346,_7305),
    !,
    {user:_7240=tv}.

hlexv(rv,_7241,_7242,_7243,_7244,[hlexv,{},_7350,_7394,_7423,_7452,_7481,!,_7515],_7314,_7316) --> 
    {user:value(textflag,true)},
    lexv(rv,_7241,_7242,_7243,_7350,_7314,_7373),
    negation0(_7244,_7394,_7373,_7411),
    not_look_ahead([det],_7423,_7411,_7440),
    not_look_ahead([hva],_7452,_7440,_7469),
    rep_particlev0(_7241,_7481,_7469,_7498),
    !,
    accept(_7515,_7498,_7316).

hlexv(tv,know1,pres,fin,_7244,[hlexv,lit(kan),_7340,_7369,_7398,_7427],_7303,_7305) --> 
    cc(kan,_7303,_7339),
    negation0(_7244,_7340,_7339,_7357),
    not_look_ahead([jeg],_7369,_7357,_7386),
    not_look_ahead([du],_7398,_7386,_7415),
    not_look_ahead(w(verb(_7262,_7263,_7264)),_7427,_7415,_7305).

hlexv(_7240,_7241,_7242,_7243,_7244,[hlexv,{},_7327,_7371,!],_7291,_7293) --> 
    {user:nonvar(_7240)},
    lexv(_7240,_7241,_7242,_7243,_7327,_7291,_7350),
    negation0(_7244,_7371,_7350,_7293),
    !.

hlexv(_7240,_7241,_7242,_7243,_7244,[hlexv,_7307,_7351],_7281,_7283) --> 
    lexv(_7240,_7241,_7242,_7243,_7307,_7281,_7330),
    negation0(_7244,_7351,_7330,_7283).

lexv(_7240,_7241,past,fin,[lexv,_7329,_7358,_7382,_7411,!,{},!],_7306,_7308) --> 
    w(verb(have,_7266,fin),_7329,_7306,_7346),
    redundant0(_7358,_7346,_7373),
    w(verb(_7271,past,part),_7382,_7373,_7399),
    particlev2(_7271,_7241,_7411,_7399,_7308),
    !,
    {user:verbtype(_7241,_7240)},
    !.

lexv(_7240,_7241,_7242,part,[lexv,_7314,_7343,{},!],_7291,_7293) --> 
    w(verb(_7256,_7242,part),_7314,_7291,_7331),
    particlev2(_7256,_7241,_7343,_7331,_7293),
    {user:verbtype(_7241,_7240)},
    !.

lexv(iv,_7241,past,fin,[lexv,_7308,{},!],_7285,_7287) --> 
    w(verb(_7241,past,part),_7308,_7285,_7287),
    {user:verbtype(_7241,iv)},
    !.

lexv(iv,_7241,pres,part,[lexv,_7308,{},!],_7285,_7287) --> 
    w(verb(_7241,pres,part),_7308,_7285,_7287),
    {user:verbtype(_7241,iv)},
    !.

lexv(dtv,_7241,_7242,_7243,[lexv,_7305,{}],_7282,_7284) --> 
    w(verb(_7241,_7242,_7243),_7305,_7282,_7284),
    {user:verbtype(_7241,dtv)}.

lexv(iv,be1,pres,fin,[lexv,_7297],_7274,_7276) --> 
    w(verb(be,inf,fin),_7297,_7274,_7276).

lexv(tv,_7241,past,part,[lexv,_7317,_7346,{},!],_7294,_7296) --> 
    w(verb(be,past,part),_7317,_7294,_7334),
    w(verb(_7241,past,part),_7346,_7334,_7296),
    {user:verbtype(_7241,tv)},
    !.

lexv(_7240,_7241,past,part,[lexv,_7308,{},!],_7285,_7287) --> 
    w(verb(_7241,past,part),_7308,_7285,_7287),
    {user:verbtype(_7241,_7240)},
    !.

lexv(tv,tell,_7242,_7243,[lexv,_7315,_7344,_7373,!,_7422],_7292,_7294) --> 
    w(verb(tell,_7242,_7243),_7315,_7292,_7332),
    reflexiv0(tell,_7344,_7332,_7361),
    optional([om],_7373,_7361,_7405),
    !,
    accept(_7422,_7405,_7294).

lexv(rv,_7241,_7242,_7243,[lexv,_7312,{},_7351],_7289,_7291) --> 
    w(verb(_7241,_7242,_7243),_7312,_7289,_7329),
    {user:rv_templ(_7241,_7264)},
    not_look_ahead([hva],_7351,_7329,_7291).

lexv(iv,_7241,_7242,fin,[lexv,_7309,_7338,!],_7286,_7288) --> 
    w(verb(be,_7242,fin),_7309,_7286,_7326),
    w(verb(_7241,pres,part),_7338,_7326,_7288),
    !.

lexv(iv,_7241,past,fin,[lexv,_7309,_7338,!],_7286,_7288) --> 
    w(verb(be,_7254,fin),_7309,_7286,_7326),
    w(verb(_7241,pres,part),_7338,_7326,_7288),
    !.

lexv(rv,_7241,_7242,_7243,[lexv,_7327,{},_7366,_7395,!,_7429],_7304,_7306) --> 
    w(verb(_7241,_7242,_7243),_7327,_7304,_7344),
    {user:testmember(_7241,[tell,notify])},
    reflexiv0(_7241,_7366,_7344,_7383),
    not_look_ahead([hva],_7395,_7383,_7412),
    !,
    accept(_7429,_7412,_7306).

lexv(rv,show,_7242,_7243,[lexv,_7302,_7331],_7279,_7281) --> 
    w(verb(show,_7242,_7243),_7302,_7279,_7319),
    reflexiv0(show,_7331,_7319,_7281).

lexv(rv,mean,_7242,_7243,[lexv,_7307,_7336,!],_7284,_7286) --> 
    w(verb(mean,_7242,_7243),_7307,_7284,_7324),
    look_ahead([at],_7336,_7324,_7286),
    !.

lexv(rv,mean,_7242,_7243,[lexv,_7318,_7347,_7376,_7405],_7295,_7297) --> 
    w(verb(mean,_7242,_7243),_7318,_7295,_7335),
    not_look_ahead([hva],_7347,_7335,_7364),
    not_look_ahead([en],_7376,_7364,_7393),
    not_look_ahead([noe],_7405,_7393,_7297).

lexv(tv,know1,_7242,_7243,[lexv,_7311,_7340,_7369],_7288,_7290) --> 
    w(verb(know,_7242,_7243),_7311,_7288,_7328),
    not_look_ahead(['når'],_7340,_7328,_7357),
    not_look_ahead([at],_7369,_7357,_7290).

lexv(_7240,_7241,_7242,_7243,[lexv,_7317,_7341,_7365,{},!,_7409],_7294,_7296) --> 
    doit(_7317,_7294,_7332),
    faa(_7341,_7332,_7356),
    w(verb(_7241,_7242,_7243),_7365,_7356,_7382),
    {user:verbtype(_7241,_7240)},
    !,
    accept(_7409,_7382,_7296).

lexv(_7240,_7241,_7242,_7243,[lexv,_7321,_7345,_7374,{},!,_7418],_7298,_7300) --> 
    doit(_7321,_7298,_7336),
    not_look_ahead(['nå'],_7345,_7336,_7362),
    w(verb(_7241,_7242,_7243),_7374,_7362,_7391),
    {user:verbtype(_7241,_7240)},
    !,
    accept(_7418,_7391,_7300).

lexv(_7240,_7241,_7242,_7243,[lexv,_7324,_7348,_7377,{},{}],_7301,_7303) --> 
    faa(_7324,_7301,_7339),
    not_look_ahead(['nå'],_7348,_7339,_7365),
    lexv(_7240,_7241,_7242,_7243,_7377,_7365,_7303),
    {user:verbtype(_7241,_7240)},
    {user:(\+_7241=manage)}.

lexv(tv,run,_7242,_7243,[lexv,_7308,_7337,!,_7371],_7285,_7287) --> 
    w(verb(run,_7242,_7243),_7308,_7285,_7325),
    prep1(with,_7337,_7325,_7354),
    !,
    reject(_7371,_7354,_7287).

lexv(tv,evah,pres,fin,[lexv,_7303,!,_7337],_7280,_7282) --> 
    w(verb(evah,pres,fin),_7303,_7280,_7320),
    !,
    accept(_7337,_7320,_7282).

lexv(cv,be,pres,fin,[lexv,_7294,_7318],_7271,_7273) --> 
    aux0(_7294,_7271,_7309),
    be(_7318,_7309,_7273).

lexv(tv,wonder,_7242,_7243,[lexv,_7297],_7274,_7276) --> 
    w(verb(wonder,_7242,_7243),_7297,_7274,_7276).

lexv(tv,want,_7242,_7243,[lexv,_7300,_7329],_7277,_7279) --> 
    w(verb(think,_7242,_7243),_7300,_7277,_7317),
    rfxpron(_7329,_7317,_7279).

lexv(_7240,_7241,past,fin,[lexv,_7334,_7358,_7387,{},_7426,_7455,{}],_7311,_7313) --> 
    aux1(_7334,_7311,_7349),
    w(verb(_7270,past,part),_7358,_7349,_7375),
    not_look_ahead([om],_7387,_7375,_7404),
    {user:_7270\==have},
    reflexiv0(_7270,_7426,_7404,_7443),
    particlev0(_7270,_7241,_7455,_7443,_7313),
    {user:verbtype(_7241,_7240)}.

lexv(_7240,_7241,_7242,_7243,[lexv,{},_7343,_7372,{},_7411,{}],_7310,_7312) --> 
    {user:_7240==tv},
    w(verb(_7241,_7242,_7243),_7343,_7310,_7360),
    not_look_ahead([om],_7372,_7360,_7389),
    {user:_7241\==have},
    reflexiv0(_7241,_7411,_7389,_7312),
    {user:verbtype(_7241,_7240)}.

lexv(_7240,_7241,_7242,_7243,[lexv,{},_7358,{},_7397,{},_7436,_7465,{}],_7325,_7327) --> 
    {user:var(_7240)},
    w(verb(_7277,_7242,_7243),_7358,_7325,_7375),
    {user:(\+rv_templ(_7277,_7286))},
    not_look_ahead([om],_7397,_7375,_7414),
    {user:_7277\==have},
    reflexiv0(_7277,_7436,_7414,_7453),
    particlev0(_7277,_7241,_7465,_7453,_7327),
    {user:verbtype(_7241,_7240)}.

lexv(iv,_7241,_7242,_7243,[lexv,_7335,_7359,{},{},_7408,_7437,{}],_7312,_7314) --> 
    aux0(_7335,_7312,_7350),
    w(verb(_7270,_7242,_7243),_7359,_7350,_7376),
    {user:_7243==fin},
    {user:_7270\==have},
    reflexiv0(_7270,_7408,_7376,_7425),
    particlev0(_7270,_7241,_7437,_7425,_7314),
    {user:verbtype(_7241,iv)}.

lexv(_7240,have,_7242,_7243,[lexv,_7320,_7344,{},_7383],_7297,_7299) --> 
    aux0(_7320,_7297,_7335),
    w(verb(have,_7242,_7243),_7344,_7335,_7361),
    {user:verbtype(have,_7240)},
    not_look_ahead(w(noun(arrival,_7259,_7260,n)),_7383,_7361,_7299).

lexv(_7240,_7241,past,fin,[lexv,_7308,_7332,{}],_7285,_7287) --> 
    has(_7308,_7285,_7323),
    w(verb(_7241,past,part),_7332,_7323,_7287),
    {user:verbtype(_7241,_7240)}.

lexv(tv,bring,_7242,_7243,[lexv,_7302,_7331],_7279,_7281) --> 
    w(verb(take,_7242,_7243),_7302,_7279,_7319),
    prep1(with,_7331,_7319,_7281).

lexv(_7240,_7241,_7242,_7243,[lexv,_7317,_7346,_7370,{},!],_7294,_7296) --> 
    w(verb(_7259,_7242,_7243),_7317,_7294,_7334),
    redundant0(_7346,_7334,_7361),
    particlev0(_7259,_7241,_7370,_7361,_7296),
    {user:verbtype(_7241,_7240)},
    !.

preadjs0(_7240,[preadjs0,lit(s),_7295,!,_7324],_7270,_7272) --> 
    cc(s,_7270,_7294),
    look_ahead_clock(_7295,_7294,_7310),
    !,
    reject(_7324,_7310,_7272).

preadjs0(_7240,[preadjs0,_7281,_7305,!],_7267,_7269) --> 
    so(_7281,_7267,_7296),
    preadjs(_7240,_7305,_7296,_7269),
    !.

preadjs0((_7242,_7243),[preadjs0,_7289,_7313,_7342,_7366],_7275,_7277) --> 
    dent0(_7289,_7275,_7304),
    preadj1(_7242,_7313,_7304,_7330),
    adj_conjunction(_7342,_7330,_7357),
    preadj1(_7243,_7366,_7357,_7277).

preadjs0((_7242,_7243),[preadjs0,_7295,_7319,_7348,_7377],_7281,_7283) --> 
    dent0(_7295,_7281,_7310),
    preadj1(_7242,_7319,_7310,_7336),
    not_look_ahead(w(prep(_7262)),_7348,_7336,_7365),
    preadjs0(_7243,_7377,_7365,_7283).

preadjs0(true,[preadjs0,[]],_7259,_7259) --> 
    [].

preadjs((_7242,_7243),[preadjs,_7292,_7321,_7350],_7278,_7280) --> 
    preadj1(_7242,_7292,_7278,_7309),
    not_look_ahead(w(prep(_7259)),_7321,_7309,_7338),
    preadjs0(_7243,_7350,_7338,_7280).

preadj1(nil/first,[preadj1,_7287,_7316,!],_7273,_7275) --> 
    w(nb(1,num),_7287,_7273,_7304),
    point(_7316,_7304,_7275),
    !.

preadj1(nil/second,[preadj1,_7287,_7316,!],_7273,_7275) --> 
    w(nb(2,num),_7287,_7273,_7304),
    point(_7316,_7304,_7275),
    !.

preadj1(nil/third,[preadj1,_7287,_7316,!],_7273,_7275) --> 
    w(nb(3,num),_7287,_7273,_7304),
    point(_7316,_7304,_7275),
    !.

preadj1(nil/_7243,[preadj1,_7298,{},!,_7342],_7284,_7286) --> 
    w(name(_7243,n,station),_7298,_7284,_7315),
    {user:(\+adjname_templ(_7243,_7265))},
    !,
    reject(_7342,_7315,_7286).

preadj1(nil/_7243,[preadj1,_7293,{},!],_7279,_7281) --> 
    w(name(_7243,n,_7255),_7293,_7279,_7281),
    {user:adjname_templ(_7243,_7260)},
    !.

preadj1(_7242/_7243,[preadj1,_7286,_7315],_7272,_7274) --> 
    gradverb(_7242,_7286,_7272,_7303),
    w(adj2(_7243,nil),_7315,_7303,_7274).

preadj1(_7242/_7243,[preadj1,_7323,_7352,_7381,_7425,{},!],_7309,_7311) --> 
    not_look_ahead_lit(['først',senest,tidligst],_7323,_7309,_7340),
    not_look_ahead(w(prep(_7272)),_7352,_7340,_7369),
    optional([mye],_7381,_7369,_7413),
    w(adj2(_7243,_7242),_7425,_7413,_7311),
    {user:(\+user:post_adjective(_7243))},
    !.

adj_conjunction0([adj_conjunction0,_7269,!],_7258,_7260) --> 
    adj_conjunction(_7269,_7258,_7260),
    !.

adj_conjunction0([adj_conjunction0,[]],_7255,_7255) --> 
    [].

adj_conjunction([adj_conjunction,lit(og)],_7257,_7259) --> 
    cc(og,_7257,_7259).

adj_conjunction([adj_conjunction,lit(men)],_7257,_7259) --> 
    cc(men,_7257,_7259).

adj_conjunction([adj_conjunction,lit(eller)],_7257,_7259) --> 
    cc(eller,_7257,_7259).

adj_conjunction([adj_conjunction,lit(/)],_7257,_7259) --> 
    cc(/,_7257,_7259).

adj1s((_7248;_7249),_7241,_7242,_7245 or _7246,[adj1s,_7318,lit(eller),_7373,!],_7295,_7297) --> 
    adj1(_7248,_7241,_7242,_7245,_7318,_7295,_7341),
    cc(eller,_7341,_7372),
    adj1(_7249,_7241,_7242,_7246,_7373,_7372,_7297),
    !.

adj1s((_7248,_7249),_7241,_7242,_7245 and _7246,[adj1s,_7327,lit(og),_7382,_7426,!],_7304,_7306) --> 
    adj1(_7248,_7241,_7242,_7245,_7327,_7304,_7350),
    cc(og,_7350,_7381),
    adj1(_7249,_7241,_7242,_7246,_7382,_7381,_7405),
    not_look_ahead(w(prep(_7279)),_7426,_7405,_7306),
    !.

adj1s(_7240,_7241,_7242,_7243,[adj1s,_7296],_7273,_7275) --> 
    adj1(_7240,_7241,_7242,_7243,_7296,_7273,_7275).

adj1(_7240,_7241,_7242,_7243,[adj1,_7312,_7341,{}],_7289,_7291) --> 
    gradverbs0(_7253,_7312,_7289,_7329),
    w(adj2(_7240,nil),_7341,_7329,_7291),
    {user:adj_template(_7253,_7240,_7241,_7242,_7243)}.

adj1(_7240,_7241,_7242,_7243,[adj1,_7307,{}],_7284,_7286) --> 
    w(adj2(_7240,_7250),_7307,_7284,_7286),
    {user:adj_template(_7250,_7240,_7241,_7242,_7243)}.

gradverbs0(_7240,[gradverbs0,_7283,!,_7317],_7269,_7271) --> 
    gradverb(_7240,_7283,_7269,_7300),
    !,
    gradverbs0(_7248,_7317,_7300,_7271).

gradverbs0(nil,[gradverbs0,[]],_7259,_7259) --> 
    [].

gradverb0(more,[gradverb0,lit(mer),_7299,!],_7274,_7276) --> 
    cc(mer,_7274,_7298),
    look_ahead(w(adj2(_7254,nil)),_7299,_7298,_7276),
    !.

gradverb0(_7240,[gradverb0,_7287,_7316,!],_7273,_7275) --> 
    gradverb(_7240,_7287,_7273,_7304),
    not_look_ahead(w(prep(_7254)),_7316,_7304,_7275),
    !.

gradverb0(nil,[gradverb0,[]],_7259,_7259) --> 
    [].

gradverb(little,[gradverb,lit('dårlig')],_7261,_7263) --> 
    cc('dårlig',_7261,_7263).

gradverb(more,[gradverb,lit(litt),lit(mer),!],_7269,_7271) --> 
    cc(litt,_7269,_7293),
    cc(mer,_7293,_7271),
    !.

gradverb(more,[gradverb,lit(mye),lit(mer),!],_7269,_7271) --> 
    cc(mye,_7269,_7293),
    cc(mer,_7293,_7271),
    !.

gradverb(more,[gradverb,lit(mer)],_7261,_7263) --> 
    cc(mer,_7261,_7263).

gradverb(only,[gradverb,lit(bare)],_7261,_7263) --> 
    cc(bare,_7261,_7263).

gradverb(too,[gradverb,lit(for)],_7261,_7263) --> 
    cc(for,_7261,_7263).

gradverb(very,[gradverb,lit(meget)],_7261,_7263) --> 
    cc(meget,_7261,_7263).

gradverb(very,[gradverb,lit(veldig)],_7261,_7263) --> 
    cc(veldig,_7261,_7263).

gradverb(little,[gradverb,lit(litt)],_7261,_7263) --> 
    cc(litt,_7261,_7263).

gradverb(somewhat,[gradverb,lit(noe)],_7261,_7263) --> 
    cc(noe,_7261,_7263).

gradverb(often,[gradverb,lit(ofte)],_7261,_7263) --> 
    cc(ofte,_7261,_7263).

gradverb(nil,[gradverb,lit('så')],_7261,_7263) --> 
    cc('så',_7261,_7263).

prepnom(_7240,[prepnom,_7289,{},!,_7333],_7275,_7277) --> 
    prep(_7240,_7289,_7275,_7306),
    {user:_7240==regarding},
    !,
    accept(_7333,_7306,_7277).

prepnom(_7240,[prepnom,_7275],_7261,_7263) --> 
    prepnof(_7240,_7275,_7261,_7263).

prepnog(long,from,[prepnog,_7287,!,_7321],_7270,_7272) --> 
    prep1(from,_7287,_7270,_7304),
    !,
    accept(_7321,_7304,_7272).

prepnog(possible,_7241,[prepnog,!,_7287],_7265,_7267) --> 
    !,
    reject(_7287,_7265,_7267).

prepnog(_7240,_7241,[prepnog,_7287,!,_7321],_7270,_7272) --> 
    prepnof(_7241,_7287,_7270,_7304),
    !,
    accept(_7321,_7304,_7272).

prepnof(_7240,[prepnof,_7285,{}],_7271,_7273) --> 
    prep(_7240,_7285,_7271,_7273),
    {user:(\+_7240=of)}.

defaultprep(_7240,_7241,_7242,[defaultprep,{},{},_7331,!,_7375],_7291,_7293) --> 
    {user:_7240\==be},
    {user:vartypeid(_7241,_7264)},
    adjustprep0(_7240,_7264,_7242,_7331,_7291,_7352),
    !,
    accept(_7375,_7352,_7293).

adjustprep0(_7240,_7241,_7242,[adjustprep0,_7292,!],_7272,_7274) --> 
    adjustprep(_7240,_7241,_7242,_7292,_7272,_7274),
    !.

adjustprep0(_7240,_7241,_7242,[adjustprep0,_7289],_7269,_7271) --> 
    missingprep(_7240,_7241,_7242,_7289,_7269,_7271).

adjustprep(ask,_7241,regarding,[adjustprep,lit(om)],_7267,_7269) --> 
    cc(om,_7267,_7269).

adjustprep(dream,_7241,regarding,[adjustprep,lit(om)],_7267,_7269) --> 
    cc(om,_7267,_7269).

adjustprep(handle2,_7241,regarding,[adjustprep,lit(om)],_7267,_7269) --> 
    cc(om,_7267,_7269).

adjustprep(know,_7241,regarding,[adjustprep,lit(om)],_7267,_7269) --> 
    cc(om,_7267,_7269).

adjustprep(know1,_7241,regarding,[adjustprep,lit(om)],_7267,_7269) --> 
    cc(om,_7267,_7269).

adjustprep(go,_7241,from,[adjustprep,_7287],_7267,_7269) --> 
    prep(after,_7287,_7267,_7269).

adjustprep(go,_7241,to,[adjustprep,_7287],_7267,_7269) --> 
    prep(of,_7287,_7267,_7269).

adjustprep(_7240,_7241,_7242,[adjustprep,_7287],_7267,_7269) --> 
    prep(_7242,_7287,_7267,_7269).

missingprep(_7240,duration,with,[missingprep,!],_7265,_7265) --> 
    !.

missingprep(pass,_7241,_7242,[missingprep,!,_7293],_7268,_7270) --> 
    !,
    reject(_7293,_7268,_7270).

missingprep(_7240,thing,_7242,[missingprep,!,_7293],_7268,_7270) --> 
    !,
    reject(_7293,_7268,_7270).

missingprep(go,direction,in,[missingprep,[]],_7265,_7265) --> 
    [].

missingprep(arrive,_7241,at,[missingprep,[]],_7265,_7265) --> 
    [].

missingprep(depart,_7241,from,[missingprep,[]],_7265,_7265) --> 
    [].

missingprep(go,direction,in,[missingprep,[]],_7265,_7265) --> 
    [].

missingprep(go,_7241,at,[missingprep,[]],_7265,_7265) --> 
    [].

missingprep(start,_7241,at,[missingprep,[]],_7265,_7265) --> 
    [].

missingprep(stop,_7241,at,[missingprep,[]],_7265,_7265) --> 
    [].

prep0(from,[prep0,_7281,!,_7315],_7267,_7269) --> 
    prep(from,_7281,_7267,_7298),
    !,
    accept(_7315,_7298,_7269).

prep0(_7240,[prep0,_7283,{}],_7269,_7271) --> 
    prep(_7240,_7283,_7269,_7271),
    {user:_7240\==of}.

prep0(in,[prep0,[]],_7259,_7259) --> 
    [].

prep(_7240,[prep,lit(m),_7300,!,_7334],_7275,_7277) --> 
    cc(m,_7275,_7299),
    w(nb(_7255,_7256),_7300,_7299,_7317),
    !,
    reject(_7334,_7317,_7277).

prep(from,[prep,lit(dra),{},_7315],_7280,_7282) --> 
    cc(dra,_7280,_7304),
    {user:value(smsflag,true)},
    look_ahead(w(name(_7252,n,_7254)),_7315,_7304,_7282).

prep(_7240,[prep,_7275],_7261,_7263) --> 
    prep2(_7240,_7275,_7261,_7263).

prep(_7240,[prep,_7275],_7261,_7263) --> 
    prep1(_7240,_7275,_7261,_7263).

prep1(after,[prep1,lit(e),_7296,!],_7271,_7273) --> 
    cc(e,_7271,_7295),
    not_look_ahead(['.'],_7296,_7295,_7273),
    !.

prep1(_7240,[prep1,_7284,_7313],_7270,_7272) --> 
    w(prep(_7240),_7284,_7270,_7301),
    not_look_ahead(['å'],_7313,_7301,_7272).

prep1(to,[prep1,lit(ti),_7297],_7272,_7274) --> 
    cc(ti,_7272,_7296),
    look_ahead(w(name(_7249,_7250,_7251)),_7297,_7296,_7274).

atom(_7240,[atom,_7287,{}],_7273,_7275) --> 
    w(name(_7247,_7253,_7254),_7287,_7273,_7275),
    {user:atom_templ(_7247,_7240)}.

atomlist(_7240,[atomlist,_7289,_7318,_7347],_7275,_7277) --> 
    atom1(_7251,_7289,_7275,_7306),
    atom1(_7253,_7318,_7306,_7335),
    atoms0(_7251-_7253,_7240,_7347,_7335,_7277).

atom1(_7240,[atom1,_7287,{}],_7273,_7275) --> 
    w(name(_7240,n,_7247),_7287,_7273,_7275),
    {user:_7247\==unkn}.

atoms0(_7240,_7241,[atoms0,_7290,_7319],_7273,_7275) --> 
    atom1(_7249,_7290,_7273,_7307),
    atoms0(_7240-_7249,_7241,_7319,_7307,_7275).

atoms0(_7240,_7240,[atoms0,[]],_7262,_7262) --> 
    [].

newatom(_7240,[newatom,_7287,{}],_7273,_7275) --> 
    w(name(_7247,_7253,_7254),_7287,_7273,_7275),
    {user:atom_templ(_7247,_7240)}.

newatomid(_7240,[newatomid,_7279],_7265,_7267) --> 
    w(name(_7240,_7245,_7246),_7279,_7265,_7267).

xsubjunction(nil,coevent,instead_of,[xsubjunction,lit(fremfor)],_7267,_7269) --> 
    cc(fremfor,_7267,_7269).

xsubjunction(nil,coevent,in_order_to,[xsubjunction,_7285],_7265,_7267) --> 
    in_order_to(_7285,_7265,_7267).

xsubjunction(nil,coevent,without,[xsubjunction,_7285],_7265,_7267) --> 
    'utenå'(_7285,_7265,_7267).

xsubjunction(nil,coevent,by,[xsubjunction,lit(ved),lit('å')],_7272,_7274) --> 
    cc(ved,_7272,_7302),
    cc('å',_7302,_7274).

subjunction(before,time,in,[subjunction,_7290,_7319],_7270,_7272) --> 
    prep1(to,_7290,_7270,_7307),
    look_ahead_np(_7319,_7307,_7272).

subjunction(after,time,in,[subjunction,_7290,_7319],_7270,_7272) --> 
    prep1(after,_7290,_7270,_7307),
    that(_7319,_7307,_7272).

subjunction(after,time,in,[subjunction,_7319,_7348,_7377,_7406,!],_7299,_7301) --> 
    prep1(after,_7319,_7299,_7336),
    not_look_ahead(w(noun(clock,sin,def,n)),_7348,_7336,_7365),
    not_look_ahead(w(nb(_7271,_7272)),_7377,_7365,_7394),
    look_ahead([jeg],_7406,_7394,_7301),
    !.

subjunction(before,time,in,[subjunction,lit('før'),_7320,_7349],_7289,_7291) --> 
    cc('før',_7289,_7319),
    not_look_ahead(w(nb(_7265,_7266)),_7320,_7319,_7337),
    not_look_ahead(w(noun(clock,sin,def,n)),_7349,_7337,_7291).

subjunction(before,time,in,[subjunction,lit(til),_7309],_7278,_7280) --> 
    cc(til,_7278,_7308),
    not_look_ahead(w(name(_7251,_7252,_7253)),_7309,_7308,_7280).

subjunction(not_withstanding,coevent,nil,[subjunction,_7290,lit(om)],_7270,_7272) --> 
    uansett(_7290,_7270,_7305),
    cc(om,_7305,_7272).

subjunction(not_withstanding,coevent,nil,[subjunction,lit(selvom)],_7267,_7269) --> 
    cc(selvom,_7267,_7269).

uansett([uansett,lit(uansett)],_7257,_7259) --> 
    cc(uansett,_7257,_7259).

uansett([uansett,lit(selv)],_7257,_7259) --> 
    cc(selv,_7257,_7259).

subjunction(unless,coevent,nil,[subjunction,lit(med),lit(mindre)],_7272,_7274) --> 
    cc(med,_7272,_7302),
    cc(mindre,_7302,_7274).

subjunction(nil,coevent,so_that,[subjunction,_7285],_7265,_7267) --> 
    because(_7285,_7265,_7267).

subjunction(nil,coevent,so_that,[subjunction,_7285],_7265,_7267) --> 
    if1(_7285,_7265,_7267).

subjunction(nil,coevent,despite_of,[subjunction,_7292,lit(at)],_7272,_7274) --> 
    prep1(without,_7292,_7272,_7309),
    cc(at,_7309,_7274).

subjunction(nil,coevent,instead_of,[subjunction,_7285],_7265,_7267) --> 
    instead_of(_7285,_7265,_7267).

subjunction(nil,coevent,because_of,[subjunction,lit(med),lit(at)],_7272,_7274) --> 
    cc(med,_7272,_7302),
    cc(at,_7302,_7274).

subjunction(nil,coevent,because_of,[subjunction,_7285],_7265,_7267) --> 
    so_that(_7285,_7265,_7267).

subjunction(nil,coevent,because_of,[subjunction,lit(slik)],_7267,_7269) --> 
    cc(slik,_7267,_7269).

subjunction(during,time,in,[subjunction,_7285],_7265,_7267) --> 
    while(_7285,_7265,_7267).

subjunction(in,time,in,[subjunction,lit(om),_7301],_7270,_7272) --> 
    cc(om,_7270,_7300),
    when1(_7301,_7300,_7272).

subjunction(in,time,in,[subjunction,_7285],_7265,_7267) --> 
    when1(_7285,_7265,_7267).

subjunction(in,time,in,[subjunction,lit('så'),_7305],_7274,_7276) --> 
    cc('så',_7274,_7304),
    w(adv(fast),_7305,_7304,_7276).

subjunction(in,time,in,[subjunction,lit(om),lit(hvordan)],_7272,_7274) --> 
    cc(om,_7272,_7302),
    cc(hvordan,_7302,_7274).

subjunction(in,time,in,[subjunction,lit('på'),lit(hvordan)],_7272,_7274) --> 
    cc('på',_7272,_7302),
    cc(hvordan,_7302,_7274).

subjunction(in,time,in,[subjunction,lit(da)],_7267,_7269) --> 
    cc(da,_7267,_7269).

subjunction(in,place,in,[subjunction,lit(der)],_7267,_7269) --> 
    cc(der,_7267,_7269).

subjunction(in,place,in,[subjunction,lit(hvor),_7308],_7277,_7279) --> 
    cc(hvor,_7277,_7307),
    not_look_ahead(w(adj2(_7251,_7252)),_7308,_7307,_7279).

subjunction(until,time,in,[subjunction,_7285],_7265,_7267) --> 
    until(_7285,_7265,_7267).

subjunction(in,time,in,[subjunction,lit(i),lit(det)],_7272,_7274) --> 
    cc(i,_7272,_7302),
    cc(det,_7302,_7274).

because([because,lit(fordi)],_7257,_7259) --> 
    cc(fordi,_7257,_7259).

because([because,lit(for),_7291,!],_7269,_7271) --> 
    cc(for,_7269,_7290),
    look_ahead_lit([da,den],_7291,_7290,_7271),
    !.

because([because,lit(siden),_7303,{},!,_7347],_7281,_7283) --> 
    cc(siden,_7281,_7302),
    w(noun(_7256,_7257,_7258,_7259),_7303,_7302,_7320),
    {user:constrain(_7256,time)},
    !,
    reject(_7347,_7320,_7283).

because([because,lit(siden)],_7257,_7259) --> 
    cc(siden,_7257,_7259).

erdetdet([erdetdet,_7277,lit(det),_7312,_7336],_7266,_7268) --> 
    be(_7277,_7266,_7292),
    cc(det,_7292,_7311),
    that0(_7312,_7311,_7327),
    det0(_7336,_7327,_7268).

be_it_tf_that(_7240,[be_it_tf_that,_7304,lit(det),_7344,lit(ut),lit(til),lit(at)],_7290,_7292) --> 
    w(verb(see,_7262,fin),_7304,_7290,_7321),
    cc(det,_7321,_7343),
    negation0(_7240,_7344,_7343,_7361),
    cc(ut,_7361,_7383),
    cc(til,_7383,_7394),
    cc(at,_7394,_7292).

omaa([omaa,lit(om),lit('å'),!],_7265,_7267) --> 
    cc(om,_7265,_7286),
    cc('å',_7286,_7267),
    !.

omaa([omaa,lit('å'),!],_7260,_7262) --> 
    cc('å',_7260,_7262),
    !.

gadd([gadd,lit(vil)],_7257,_7259) --> 
    cc(vil,_7257,_7259).

hvormye([hvormye,lit(hvor),lit(mye)],_7262,_7264) --> 
    cc(hvor,_7262,_7283),
    cc(mye,_7283,_7264).

hvormye([hvormye,lit(hvor),lit(mange)],_7262,_7264) --> 
    cc(hvor,_7262,_7283),
    cc(mange,_7283,_7264).

hvormye([hvormye,lit(hvor),lit(meget)],_7262,_7264) --> 
    cc(hvor,_7262,_7283),
    cc(meget,_7283,_7264).

hvormye([hvormye,lit(hva)],_7257,_7259) --> 
    cc(hva,_7257,_7259).

whatcan([whatcan,lit(hva),lit(kan)],_7262,_7264) --> 
    cc(hva,_7262,_7283),
    cc(kan,_7283,_7264).

whatcan([whatcan,lit(hva),_7282],_7260,_7262) --> 
    cc(hva,_7260,_7281),
    aux1(_7282,_7281,_7262).

ompa([ompa,lit(om)],_7257,_7259) --> 
    cc(om,_7257,_7259).

ompa([ompa,_7270],_7259,_7261) --> 
    w(prep(on),_7270,_7259,_7261).

ompa([ompa,_7270],_7259,_7261) --> 
    w(prep(for),_7270,_7259,_7261).

hver0([hver0,lit(hvert),!],_7260,_7262) --> 
    cc(hvert,_7260,_7262),
    !.

hver0([hver0,lit(hver),!],_7260,_7262) --> 
    cc(hver,_7260,_7262),
    !.

hver0([hver0,[]],_7255,_7255) --> 
    [].

'detå'(['detå',lit(det),_7285,!],_7263,_7265) --> 
    cc(det,_7263,_7284),
    infinitive(_7285,_7284,_7265),
    !.

'detå'(['detå',lit(det),lit(og),!],_7265,_7267) --> 
    cc(det,_7265,_7286),
    cc(og,_7286,_7267),
    !.

'detå'(['detå',lit(det),lit(for),_7301,!],_7268,_7270) --> 
    cc(det,_7268,_7289),
    cc(for,_7289,_7300),
    infinitive(_7301,_7300,_7270),
    !.

'detå'(['detå',lit(det),lit(for),lit(og),!],_7270,_7272) --> 
    cc(det,_7270,_7291),
    cc(for,_7291,_7302),
    cc(og,_7302,_7272),
    !.

numberroute([numberroute,_7272,_7296,!],_7261,_7263) --> 
    optionalbus(_7272,_7261,_7287),
    num1(_7296,_7287,_7263),
    !.

numberroute([numberroute,_7269,!],_7258,_7260) --> 
    bus1(_7269,_7258,_7260),
    !.

optionalbus([optionalbus,_7273,_7297],_7262,_7264) --> 
    bus1(_7273,_7262,_7288),
    optional([nr],_7297,_7288,_7264).

optionalbus([optionalbus,_7266],_7255,_7257) --> 
    num1(_7266,_7255,_7257).

optionalbus([optionalbus,[]],_7255,_7255) --> 
    [].

num1([num1,_7279,_7308,!],_7268,_7270) --> 
    w(noun(number,sin,_7250,n),_7279,_7268,_7296),
    point0(_7308,_7296,_7270),
    !.

num1([num1,lit(nr),_7285,!],_7263,_7265) --> 
    cc(nr,_7263,_7284),
    point0(_7285,_7284,_7265),
    !.

bus1([bus1,_7273],_7262,_7264) --> 
    w(noun(route,sin,_7244,_7245),_7273,_7262,_7264).

bus1([bus1,_7273],_7262,_7264) --> 
    w(noun(bus,sin,_7244,_7245),_7273,_7262,_7264).

commas0([commas0,_7272,!,_7301],_7261,_7263) --> 
    comma(_7272,_7261,_7287),
    !,
    commas0(_7301,_7287,_7263).

commas0([commas0,[]],_7255,_7255) --> 
    [].

comma0([comma0,lit(','),!],_7260,_7262) --> 
    cc(',',_7260,_7262),
    !.

comma0([comma0,[]],_7255,_7255) --> 
    [].

comma([comma,lit(',')],_7257,_7259) --> 
    cc(',',_7257,_7259).

streetno([streetno,_7272,!,_7301],_7261,_7263) --> 
    a(_7272,_7261,_7287),
    !,
    reject(_7301,_7287,_7263).

streetno([streetno,lit(veg)],_7257,_7259) --> 
    cc(veg,_7257,_7259).

streetno([streetno,_7279,{}],_7268,_7270) --> 
    w(nb(_7245,num),_7279,_7268,_7270),
    {user:_7245<500}.

tilsiden([tilsiden,_7268],_7257,_7259) --> 
    prep1(to,_7268,_7257,_7259).

tilsiden([tilsiden,_7268],_7257,_7259) --> 
    prep1(before,_7268,_7257,_7259).

tilsiden([tilsiden,lit(siden)],_7257,_7259) --> 
    cc(siden,_7257,_7259).

hva([hva,lit(hva),!,_7290],_7263,_7265) --> 
    cc(hva,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

hva([hva,lit(hvor),_7288,!,_7317],_7266,_7268) --> 
    cc(hvor,_7266,_7287),
    meny(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

addressat0([addressat0,_7278,!,_7312],_7267,_7269) --> 
    w(name(tuc,n,_7250),_7278,_7267,_7295),
    !,
    accept(_7312,_7295,_7269).

addressat0([addressat0,_7278,!,_7312],_7267,_7269) --> 
    w(name(busstuc,n,_7250),_7278,_7267,_7295),
    !,
    accept(_7312,_7295,_7269).

addressat0([addressat0,_7278,!,_7312],_7267,_7269) --> 
    w(name(bustuc,n,_7250),_7278,_7267,_7295),
    !,
    accept(_7312,_7295,_7269).

addressat0([addressat0,_7278,!,_7312],_7267,_7269) --> 
    w(name(hal,n,_7250),_7278,_7267,_7295),
    !,
    accept(_7312,_7295,_7269).

addressat0([addressat0,[]],_7255,_7255) --> 
    [].

enn([enn,lit(enn)],_7257,_7259) --> 
    cc(enn,_7257,_7259).

enn([enn,lit(en)],_7257,_7259) --> 
    cc(en,_7257,_7259).

hatt0([hatt0,_7275,!],_7264,_7266) --> 
    w(verb(have,past,part),_7275,_7264,_7266),
    !.

hatt0([hatt0,[]],_7255,_7255) --> 
    [].

out0([out0,lit(ut),!,_7290],_7263,_7265) --> 
    cc(ut,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

out0([out0,lit(opp),!,_7290],_7263,_7265) --> 
    cc(opp,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

out0([out0,[]],_7255,_7255) --> 
    [].

a0([a0,_7266],_7255,_7257) --> 
    a(_7266,_7255,_7257).

a0([a0,[]],_7255,_7255) --> 
    [].

a([a,lit(ett),_7291],_7269,_7271) --> 
    cc(ett,_7269,_7290),
    not_look_ahead(w(noun(time,_7248,def,_7250)),_7291,_7290,_7271).

a([a,lit(noen),lit(av),!],_7265,_7267) --> 
    cc(noen,_7265,_7286),
    cc(av,_7286,_7267),
    !.

a([a,lit(noen),_7296,_7325,_7354],_7274,_7276) --> 
    cc(noen,_7274,_7295),
    not_look_ahead([av],_7296,_7295,_7313),
    not_look_ahead([de],_7325,_7313,_7342),
    look_ahead_np(_7354,_7342,_7276).

a([a,lit(noe),_7289,_7318],_7267,_7269) --> 
    cc(noe,_7267,_7288),
    not_look_ahead([de],_7289,_7288,_7306),
    look_ahead_np(_7318,_7306,_7269).

a([a,_7273,_7297],_7262,_7264) --> 
    art1(_7273,_7262,_7288),
    optional([slik],_7297,_7288,_7264).

art([art,_7266],_7255,_7257) --> 
    a(_7266,_7255,_7257).

art([art,_7274,lit(eller),_7309],_7263,_7265) --> 
    a(_7274,_7263,_7289),
    cc(eller,_7289,_7308),
    more(_7309,_7308,_7265).

art([art,lit(de)],_7257,_7259) --> 
    cc(de,_7257,_7259).

art([art,lit(all)],_7257,_7259) --> 
    cc(all,_7257,_7259).

art([art,_7279,lit(alt)],_7268,_7270) --> 
    not_look_ahead(w(name(_7249,_7250,_7251)),_7279,_7268,_7296),
    cc(alt,_7296,_7270).

art([art,_7276,{}],_7265,_7267) --> 
    every(_7276,_7265,_7267),
    {user:(\+value(textflag,true))}.

art1([art1,lit(en)],_7257,_7259) --> 
    cc(en,_7257,_7259).

art1([art1,lit(et)],_7257,_7259) --> 
    cc(et,_7257,_7259).

art1([art1,lit(ei)],_7257,_7259) --> 
    cc(ei,_7257,_7259).

allsome0([allsome0,lit(noen),lit(av)],_7262,_7264) --> 
    cc(noen,_7262,_7283),
    cc(av,_7283,_7264).

allsome0([allsome0,_7269,!],_7258,_7260) --> 
    all(_7269,_7258,_7260),
    !.

allsome0([allsome0,[]],_7255,_7255) --> 
    [].

all0([all0,_7269,!],_7258,_7260) --> 
    all(_7269,_7258,_7260),
    !.

all0([all0,[]],_7255,_7255) --> 
    [].

all([all,_7266],_7255,_7257) --> 
    every(_7266,_7255,_7257).

always([always,lit(alltid)],_7257,_7259) --> 
    cc(alltid,_7257,_7259).

always([always,_7281,_7310],_7270,_7272) --> 
    w(adj2(whole,nil),_7281,_7270,_7298),
    w(noun(time,sin,def,n),_7310,_7298,_7272).

and0([and0,_7272,!,_7301],_7261,_7263) --> 
    and1(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

and0([and0,[]],_7255,_7255) --> 
    [].

andor0([andor0,_7272,!,_7301],_7261,_7263) --> 
    andor(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

andor0([andor0,[]],_7255,_7255) --> 
    [].

andor([andor,lit(og),!],_7260,_7262) --> 
    cc(og,_7260,_7262),
    !.

andor([andor,lit(eller),!],_7260,_7262) --> 
    cc(eller,_7260,_7262),
    !.

betwand0([betwand0,lit('å'),!],_7260,_7262) --> 
    cc('å',_7260,_7262),
    !.

betwand0([betwand0,lit(og),!],_7260,_7262) --> 
    cc(og,_7260,_7262),
    !.

betwand0([betwand0,_7273,!],_7262,_7264) --> 
    w(prep(to),_7273,_7262,_7264),
    !.

betwand0([betwand0,[]],_7255,_7255) --> 
    [].

and1([and1,lit(og)],_7257,_7259) --> 
    cc(og,_7257,_7259).

and1([and1,lit(men),_7288],_7266,_7268) --> 
    cc(men,_7266,_7287),
    look_ahead_lit([en,et],_7288,_7287,_7268).

vmod_conjunction([vmod_conjunction,lit(mao)],_7257,_7259) --> 
    cc(mao,_7257,_7259).

vmod_conjunction([vmod_conjunction,lit(men),_7288],_7266,_7268) --> 
    cc(men,_7266,_7287),
    not_look_ahead_lit([med,'nå'],_7288,_7287,_7268).

vmod_conjunction([vmod_conjunction,_7328,_7357,_7401,_7430,_7459,_7488,_7517],_7317,_7319) --> 
    one_of_lit([og,eller],_7328,_7317,_7345),
    optional(['så'],_7357,_7345,_7389),
    not_look_ahead_lit([da,'så','nå'],_7401,_7389,_7418),
    not_look_ahead(w(prep(in)),_7430,_7418,_7447),
    not_look_ahead(w([ikveld]),_7459,_7447,_7476),
    not_look_ahead(w([imorgen]),_7488,_7476,_7505),
    not_look_ahead(w(name(_7262,_7263,_7264)),_7517,_7505,_7319).

andwhen0([andwhen0,_7275,_7299,!,_7328],_7264,_7266) --> 
    and1(_7275,_7264,_7290),
    when(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

andwhen0([andwhen0,[]],_7255,_7255) --> 
    [].

andwhere0([andwhere0,_7280,_7304,_7333,!,_7362],_7269,_7271) --> 
    and1(_7280,_7269,_7295),
    prep1(from,_7304,_7295,_7321),
    where(_7333,_7321,_7348),
    !,
    accept(_7362,_7348,_7271).

andwhere0([andwhere0,_7275,_7299,!,_7328],_7264,_7266) --> 
    and1(_7275,_7264,_7290),
    where(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

andwhere0([andwhere0,_7277,lit(hvorfra),!,_7317],_7266,_7268) --> 
    and1(_7277,_7266,_7292),
    cc(hvorfra,_7292,_7311),
    !,
    accept(_7317,_7311,_7268).

andwhere0([andwhere0,[]],_7255,_7255) --> 
    [].

np_conjunction(_7240,[np_conjunction,_7289,lit(det),_7329,!,_7358],_7275,_7277) --> 
    andor(_7254,_7289,_7275,_7306),
    cc(det,_7306,_7328),
    look_ahead_vp(_7329,_7328,_7344),
    !,
    reject(_7358,_7344,_7277).

np_conjunction(_7240,[np_conjunction,_7300,_7329,_7358,_7387],_7286,_7288) --> 
    andor(_7240,_7300,_7286,_7317),
    not_look_ahead_lit([da,'så'],_7329,_7317,_7346),
    not_look_ahead(w(prep(_7267)),_7358,_7346,_7375),
    not_look_ahead(['.'],_7387,_7375,_7288).

andor0(_7240,[andor0,_7275],_7261,_7263) --> 
    andor(_7240,_7275,_7261,_7263).

andor0(and,[andor0,{}],_7267,_7267) --> 
    {user:value(textflag,true)}.

andor(and,[andor,_7299,_7323,_7352],_7285,_7287) --> 
    and1(_7299,_7285,_7314),
    not_look_ahead(['.'],_7323,_7314,_7340),
    not_look_ahead_lit([jeg,mange,ikke,ingen,noen,disse,dette],_7352,_7340,_7287).

andor(or,[andor,lit(eller),_7297],_7272,_7274) --> 
    cc(eller,_7272,_7296),
    not_look_ahead(w(verb(_7249,_7250,_7251)),_7297,_7296,_7274).

andor(and,[andor,{},_7300,!,_7329],_7276,_7278) --> 
    {user:value(teleflag,true)},
    art(_7300,_7276,_7315),
    !,
    reject(_7329,_7315,_7278).

andor(and,[andor,{}],_7267,_7267) --> 
    {user:value(teleflag,true)}.

also0([also0,lit('også'),lit(samtidig),!],_7265,_7267) --> 
    cc('også',_7265,_7286),
    cc(samtidig,_7286,_7267),
    !.

also0([also0,lit(samtidig),lit('også'),!],_7265,_7267) --> 
    cc(samtidig,_7265,_7286),
    cc('også',_7286,_7267),
    !.

also0([also0,lit('også'),!],_7260,_7262) --> 
    cc('også',_7260,_7262),
    !.

also0([also0,lit(samtidig),!],_7260,_7262) --> 
    cc(samtidig,_7260,_7262),
    !.

also0([also0,lit(deretter),!],_7260,_7262) --> 
    cc(deretter,_7260,_7262),
    !.

also0([also0,[]],_7255,_7255) --> 
    [].

anaa([anaa,_7272,_7296,!],_7261,_7263) --> 
    ann0(_7272,_7261,_7287),
    ogaa(_7296,_7287,_7263),
    !.

ogaa([ogaa,lit('å')],_7257,_7259) --> 
    cc('å',_7257,_7259).

ogaa([ogaa,lit(og)],_7257,_7259) --> 
    cc(og,_7257,_7259).

ann0([ann0,lit(an),!,_7290],_7263,_7265) --> 
    cc(an,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

ann0([ann0,[]],_7255,_7255) --> 
    [].

anorder(a,_7241,[anorder,_7287,_7311],_7270,_7272) --> 
    a(_7287,_7270,_7302),
    w(nb(_7241,ord),_7311,_7302,_7272).

anorder(the,_7241,[anorder,_7287,_7311],_7270,_7272) --> 
    the(_7287,_7270,_7302),
    w(nb(_7241,ord),_7311,_7302,_7272).

another([another,_7269,_7293],_7258,_7260) --> 
    a(_7269,_7258,_7284),
    other(_7293,_7284,_7260).

around0([around0,_7266],_7255,_7257) --> 
    around1(_7266,_7255,_7257).

around0([around0,[]],_7255,_7255) --> 
    [].

around1([around1,_7266],_7255,_7257) --> 
    ca(_7266,_7255,_7257).

around1([around1,lit(om),lit(lag)],_7262,_7264) --> 
    cc(om,_7262,_7283),
    cc(lag,_7283,_7264).

around1([around1,_7268],_7257,_7259) --> 
    prep1(around,_7268,_7257,_7259).

as([as,lit(som)],_7257,_7259) --> 
    cc(som,_7257,_7259).

as0([as0,_7266],_7255,_7257) --> 
    as(_7266,_7255,_7257).

as0([as0,[]],_7255,_7255) --> 
    [].

andsoon([andsoon,lit(og),_7282],_7260,_7262) --> 
    cc(og,_7260,_7281),
    sovidere0(_7282,_7281,_7262).

sovidere0([sovidere0,_7269,_7293],_7258,_7260) --> 
    sov0(_7269,_7258,_7284),
    videre0(_7293,_7284,_7260).

sov0([sov0,lit('så')],_7257,_7259) --> 
    cc('så',_7257,_7259).

sov0([sov0,[]],_7255,_7255) --> 
    [].

videre0([videre0,lit(videre)],_7257,_7259) --> 
    cc(videre,_7257,_7259).

videre0([videre0,[]],_7255,_7255) --> 
    [].

aspossible0([aspossible0,_7272,!,_7301],_7261,_7263) --> 
    aspossible(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

aspossible0([aspossible0,_7266],_7255,_7257) --> 
    possible0(_7266,_7255,_7257).

aspossible([aspossible,_7274,_7298],_7263,_7265) --> 
    as(_7274,_7263,_7289),
    w(adj2(possible,nil),_7298,_7289,_7265).

aso0([aso0,lit('så'),!,_7290],_7263,_7265) --> 
    cc('så',_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

aso0([aso0,_7272,!,_7301],_7261,_7263) --> 
    too(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

aso0([aso0,_7266],_7255,_7257) --> 
    as(_7266,_7255,_7257).

aso0([aso0,[]],_7255,_7255) --> 
    [].

at([at,_7268],_7257,_7259) --> 
    prep(at,_7268,_7257,_7259).

athe([athe,_7266],_7255,_7257) --> 
    the(_7266,_7255,_7257).

athe([athe,_7266],_7255,_7257) --> 
    a(_7266,_7255,_7257).

athe0([athe0,_7269,!],_7258,_7260) --> 
    athe(_7269,_7258,_7260),
    !.

athe0([athe0,[]],_7255,_7255) --> 
    [].

blei(_7240,[blei,_7298,_7327,_7356,!],_7284,_7286) --> 
    w(verb(stand,pres,fin),_7298,_7284,_7315),
    negation0(_7240,_7327,_7315,_7344),
    look_ahead(w(verb(_7263,past,part)),_7356,_7344,_7286),
    !.

blei(_7240,[blei,_7278,_7302],_7264,_7266) --> 
    blei(_7278,_7264,_7293),
    negation0(_7240,_7302,_7293,_7266).

blei([blei,_7286,_7315,!],_7275,_7277) --> 
    w(verb(stand,pres,fin),_7286,_7275,_7303),
    look_ahead(w(verb(_7256,past,part)),_7315,_7303,_7277),
    !.

blei([blei,_7275,!],_7264,_7266) --> 
    w(verb(be,_7246,fin),_7275,_7264,_7266),
    !.

blei([blei,_7281,_7305,_7329,!],_7270,_7272) --> 
    has(_7281,_7270,_7296),
    redundant0(_7305,_7296,_7320),
    w(verb(be,past,part),_7329,_7320,_7272),
    !.

blei([blei,_7278,_7302,!],_7267,_7269) --> 
    aux1(_7278,_7267,_7293),
    w(verb(be,past,part),_7302,_7293,_7269),
    !.

blei([blei,_7278,_7302,!],_7267,_7269) --> 
    aux1(_7278,_7267,_7293),
    w(verb(be,inf,fin),_7302,_7293,_7269),
    !.

aux0(_7240,_7241,[aux0,_7285,!],_7268,_7270) --> 
    aux1(_7240,_7241,_7285,_7268,_7270),
    !.

aux0(id,pres,[aux0,_7279],_7262,_7264) --> 
    aux0(_7279,_7262,_7264).

auxs0(_7240,_7241,[auxs0,_7285,!],_7268,_7270) --> 
    aux1(_7240,_7241,_7285,_7268,_7270),
    !.

auxs0(_7240,_7241,[auxs0,[]],_7262,_7262) --> 
    [].

auxs([auxs,_7269,_7293],_7258,_7260) --> 
    aux1(_7269,_7258,_7284),
    auxs0(_7293,_7284,_7260).

auxs0([auxs0,_7272,!,_7301],_7261,_7263) --> 
    aux1(_7272,_7261,_7287),
    !,
    auxs0(_7301,_7287,_7263).

auxs0([auxs0,[]],_7255,_7255) --> 
    [].

aux1(_7240,pres,[aux1,lit(kan),_7314,_7338,_7367,!],_7286,_7288) --> 
    cc(kan,_7286,_7313),
    redundant0(_7314,_7313,_7329),
    negation0(_7240,_7338,_7329,_7355),
    look_ahead(w(verb(_7263,_7264,_7265)),_7367,_7355,_7288),
    !.

aux1(_7240,past,[aux1,lit(kunne),_7311,_7340,!],_7283,_7285) --> 
    cc(kunne,_7283,_7310),
    negation0(_7240,_7311,_7310,_7328),
    look_ahead(w(verb(_7260,_7261,_7262)),_7340,_7328,_7285),
    !.

aux1(_7240,past,[aux1,lit(burde),_7300,!],_7272,_7274) --> 
    cc(burde,_7272,_7299),
    negation0(_7240,_7300,_7299,_7274),
    !.

aux1(_7240,past,[aux1,lit(kunne),_7300,!],_7272,_7274) --> 
    cc(kunne,_7272,_7299),
    negation0(_7240,_7300,_7299,_7274),
    !.

aux1(_7240,pres,[aux1,_7284,_7308],_7267,_7269) --> 
    aux1(_7284,_7267,_7299),
    negation0(_7240,_7308,_7299,_7269).

skalsaa([skalsaa,_7269,_7293],_7258,_7260) --> 
    aux1(_7269,_7258,_7284),
    so0(_7293,_7284,_7260).

faux1([faux1,_7275,!],_7264,_7266) --> 
    w(verb(get,_7246,fin),_7275,_7264,_7266),
    !.

faux1([faux1,_7266],_7255,_7257) --> 
    aux1(_7266,_7255,_7257).

aux1([aux1,_7297,_7326,_7355,!],_7286,_7288) --> 
    one_of_lit([kan,kunne,'får',fikk],_7297,_7286,_7314),
    not_look_ahead(['nå'],_7326,_7314,_7343),
    look_ahead(w(verb(_7267,inf,_7269)),_7355,_7343,_7288),
    !.

aux1([aux1,_7272],_7261,_7263) --> 
    one_of_lit([kan,kunne],_7272,_7261,_7263).

aux1([aux1,_7284],_7273,_7275) --> 
    one_of_lit(['bør',burde,'må','måtte',skal,skulle,vil,ville],_7284,_7273,_7275).

aux10([aux10,_7269,!],_7258,_7260) --> 
    aux1(_7269,_7258,_7260),
    !.

aux10([aux10,[]],_7255,_7255) --> 
    [].

aux0([aux0,_7280,_7304,!],_7269,_7271) --> 
    faa(_7280,_7269,_7295),
    look_ahead(w(verb(_7250,_7251,_7252)),_7304,_7295,_7271),
    !.

aux0([aux0,lit('må')],_7257,_7259) --> 
    cc('må',_7257,_7259).

aux0([aux0,_7290,lit('så'),_7325,lit('å'),!,_7370],_7279,_7281) --> 
    be(_7290,_7279,_7305),
    cc('så',_7305,_7324),
    w(adj2(good,nil),_7325,_7324,_7342),
    cc('å',_7342,_7364),
    !,
    accept(_7370,_7364,_7281).

aux0([aux0,_7266],_7255,_7257) --> 
    doit(_7266,_7255,_7257).

aux0([aux0,[]],_7255,_7255) --> 
    [].

paux0([paux0,_7274,lit(blitt),!],_7263,_7265) --> 
    has(_7274,_7263,_7289),
    cc(blitt,_7289,_7265),
    !.

paux0([paux0,lit(vil),lit(bli),!],_7265,_7267) --> 
    cc(vil,_7265,_7286),
    cc(bli,_7286,_7267),
    !.

paux0([paux0,lit(_7245),{},!],_7288,_7290) --> 
    cc(_7245,_7288,_7290),
    {user:testmember(_7245,[skal,vil,'bør','må',kan,skulle,ville,burde,'måtte',kunne])},
    !.

paux0([paux0,[]],_7255,_7255) --> 
    [].

do(_7240,[do,_7281,_7305,_7334],_7267,_7269) --> 
    use(_7281,_7267,_7296),
    negation0(_7240,_7305,_7296,_7322),
    infinitive(_7334,_7322,_7269).

do(_7240,[do,_7281,_7305,_7334],_7267,_7269) --> 
    doit(_7281,_7267,_7296),
    negation0(_7240,_7305,_7296,_7322),
    hasto0(_7334,_7322,_7269).

do(id,[do,[]],_7259,_7259) --> 
    [].

do0([do0,_7266],_7255,_7257) --> 
    doit(_7266,_7255,_7257).

do0([do0,[]],_7255,_7255) --> 
    [].

docan([docan,lit(kan)],_7257,_7259) --> 
    cc(kan,_7257,_7259).

docan([docan,lit('må')],_7257,_7259) --> 
    cc('må',_7257,_7259).

docan([docan,lit('får')],_7257,_7259) --> 
    cc('får',_7257,_7259).

docan([docan,_7269,!],_7258,_7260) --> 
    doit(_7269,_7258,_7260),
    !.

doit([doit,_7282,_7306,!,_7340],_7271,_7273) --> 
    faa(_7282,_7271,_7297),
    w(noun(information,_7252,_7253,_7254),_7306,_7297,_7323),
    !,
    reject(_7340,_7323,_7273).

doit([doit,lit(vil),lit(vil),!,_7306],_7268,_7270) --> 
    cc(vil,_7268,_7289),
    cc(vil,_7289,_7300),
    !,
    accept(_7306,_7300,_7270).

doit([doit,_7266],_7255,_7257) --> 
    skalsaa(_7266,_7255,_7257).

doit([doit,_7266],_7255,_7257) --> 
    may(_7266,_7255,_7257).

doit([doit,_7266],_7255,_7257) --> 
    must(_7266,_7255,_7257).

may([may,lit(kan),_7290],_7268,_7270) --> 
    cc(kan,_7268,_7289),
    look_ahead(w(verb(_7247,_7248,_7249)),_7290,_7289,_7270).

may([may,lit('får'),_7290],_7268,_7270) --> 
    cc('får',_7268,_7289),
    look_ahead(w(verb(_7247,_7248,_7249)),_7290,_7289,_7270).

may([may,lit('bør')],_7257,_7259) --> 
    cc('bør',_7257,_7259).

may([may,lit('må')],_7257,_7259) --> 
    cc('må',_7257,_7259).

must([must,lit('må')],_7257,_7259) --> 
    cc('må',_7257,_7259).

must([must,lit(skal)],_7257,_7259) --> 
    cc(skal,_7257,_7259).

be(_7240,[be,_7304,_7333,_7362,!,_7391,{}],_7290,_7292) --> 
    w(verb(hold,_7266,fin),_7304,_7290,_7321),
    negation0(_7259,_7333,_7321,_7350),
    rfxpron(_7362,_7350,_7377),
    !,
    negation0(_7260,_7391,_7377,_7292),
    {user:bigno(_7259,_7260,_7240)}.

be(_7240,[be,_7281,!,_7315],_7267,_7269) --> 
    be1(_7240,_7281,_7267,_7298),
    !,
    accept(_7315,_7298,_7269).

be(not,[be,_7276,_7300],_7262,_7264) --> 
    not(_7276,_7262,_7291),
    be(_7300,_7291,_7264).

be(id,[be,_7273],_7259,_7261) --> 
    be(_7273,_7259,_7261).

be0([be0,_7268],_7257,_7259) --> 
    optional(be,_7268,_7257,_7259).

be([be,_7278,_7302,!],_7267,_7269) --> 
    aux1(_7278,_7267,_7293),
    w(verb(be,inf,fin),_7302,_7293,_7269),
    !.

be([be,_7287,_7316,_7340,!],_7276,_7278) --> 
    w(verb(have,_7252,fin),_7287,_7276,_7304),
    redundant0(_7316,_7304,_7331),
    w(verb(be,past,part),_7340,_7331,_7278),
    !.

be([be,_7275,!],_7264,_7266) --> 
    w(verb(be,_7246,part),_7275,_7264,_7266),
    !.

be([be,_7278,_7307,!],_7267,_7269) --> 
    w(verb(be,_7249,fin),_7278,_7267,_7295),
    been0(_7307,_7295,_7269),
    !.

be1(_7240,[be1,_7287,_7316,_7340],_7273,_7275) --> 
    w(verb(be,_7253,fin),_7287,_7273,_7304),
    redundant0(_7316,_7304,_7331),
    negation0(_7240,_7340,_7331,_7275).

be1(_7240,[be1,_7290,_7314,_7338,_7367],_7276,_7278) --> 
    aux1(_7290,_7276,_7305),
    redundant0(_7314,_7305,_7329),
    negation0(_7240,_7338,_7329,_7355),
    w(verb(be,inf,fin),_7367,_7355,_7278).

be1(_7240,[be1,_7296,_7325,_7349,_7383,!],_7282,_7284) --> 
    negation0(_7254,_7296,_7282,_7313),
    aux1(_7325,_7313,_7340),
    negation2(_7254,_7240,_7349,_7340,_7368),
    w(verb(be,inf,fin),_7383,_7368,_7284),
    !.

be1(_7240,[be1,_7296,_7325,_7354,!],_7282,_7284) --> 
    w(verb(have,_7254,fin),_7296,_7282,_7313),
    negation0(_7240,_7325,_7313,_7342),
    w(verb(be,past,part),_7354,_7342,_7284),
    !.

be1(_7240,[be1,_7287,_7316,_7340,_7364],_7273,_7275) --> 
    negation0(_7251,_7287,_7273,_7304),
    be(_7316,_7304,_7331),
    redundant0(_7340,_7331,_7355),
    negation2(_7251,_7240,_7364,_7355,_7275).

be1(_7240,[be1,_7289,_7318,lit(blitt)],_7275,_7277) --> 
    w(verb(have,_7253,fin),_7289,_7275,_7306),
    negation0(_7240,_7318,_7306,_7335),
    cc(blitt,_7335,_7277).

be1(id,[be1,lit(blitt)],_7261,_7263) --> 
    cc(blitt,_7261,_7263).

be1(not,[be1,_7287,_7316,_7345],_7273,_7275) --> 
    w(verb(reject,_7251,fin),_7287,_7273,_7304),
    prep(to,_7316,_7304,_7333),
    be(_7345,_7333,_7275).

be_truefalse_that(_7240,[be_truefalse_that,_7307,{},_7346,lit(ut),_7386,!],_7293,_7295) --> 
    w(verb(_7259,_7260,fin),_7307,_7293,_7324),
    {user:testmember(_7259,[look,see])},
    negation0(_7240,_7346,_7324,_7363),
    cc(ut,_7363,_7385),
    somatom0(_7386,_7385,_7295),
    !.

be_truefalse_that(_7240,[be_truefalse_that,_7307,{},_7346,lit(ut),_7386,!],_7293,_7295) --> 
    w(verb(_7259,_7260,fin),_7307,_7293,_7324),
    {user:testmember(_7259,[look,see])},
    negation0(_7240,_7346,_7324,_7363),
    cc(ut,_7363,_7385),
    somatom0(_7386,_7385,_7295),
    !.

be_truefalse_that(_7240,[be_truefalse_that,_7302,{},_7341,_7370,!],_7288,_7290) --> 
    w(verb(_7256,_7257,fin),_7302,_7288,_7319),
    {user:testmember(_7256,[appear,be])},
    negation0(_7240,_7341,_7319,_7358),
    somatom0(_7370,_7358,_7290),
    !.

somatom0([somatom0,_7269,!],_7258,_7260) --> 
    somatom(_7269,_7258,_7260),
    !.

somatom0([somatom0,[]],_7255,_7255) --> 
    [].

somatom([somatom,_7279,lit(at),!],_7268,_7270) --> 
    w(adj2(true,nil),_7279,_7268,_7296),
    cc(at,_7296,_7270),
    !.

somatom([somatom,lit(som),lit(at),!],_7265,_7267) --> 
    cc(som,_7265,_7286),
    cc(at,_7286,_7267),
    !.

somatom([somatom,lit(som),lit(om),!],_7265,_7267) --> 
    cc(som,_7265,_7286),
    cc(om,_7286,_7267),
    !.

somatom([somatom,lit(som)],_7257,_7259) --> 
    cc(som,_7257,_7259).

somatom([somatom,lit(at)],_7257,_7259) --> 
    cc(at,_7257,_7259).

somatom([somatom,lit(til),lit(at),!],_7265,_7267) --> 
    cc(til,_7265,_7286),
    cc(at,_7286,_7267),
    !.

somatom([somatom,lit(til)],_7257,_7259) --> 
    cc(til,_7257,_7259).

be_truefalse_that(_7240,[be_truefalse_that,_7304,_7333,_7367,_7396,!],_7290,_7292) --> 
    w(verb(_7256,_7257,fin),_7304,_7290,_7321),
    gmem(_7256,[agree,appear],_7333,_7321,_7352),
    negation0(_7240,_7367,_7352,_7384),
    optional([at],_7396,_7384,_7292),
    !.

be_truefalse_that(_7240,[be_truefalse_that,_7294,_7323,_7352,!],_7280,_7282) --> 
    negation0(_7240,_7294,_7280,_7311),
    one_of_lit(['så',slik],_7323,_7311,_7340),
    optional([at],_7352,_7340,_7282),
    !.

be_truefalse_that(id,[be_truefalse_that,_7294,_7323,lit(at),!],_7280,_7282) --> 
    w(verb(show,_7254,fin),_7294,_7280,_7311),
    optional([seg],_7323,_7311,_7355),
    cc(at,_7355,_7282),
    !.

be_truefalse_that(_7240,[be_truefalse_that,_7307,{},_7346,lit(ut),_7386,!],_7293,_7295) --> 
    w(verb(_7259,_7260,fin),_7307,_7293,_7324),
    {user:testmember(_7259,[see,look])},
    negation0(_7240,_7346,_7324,_7363),
    cc(ut,_7363,_7385),
    somatom(_7386,_7385,_7295),
    !.

be_truefalse_that(_7240,[be_truefalse_that,_7302,{},_7341,_7370,!],_7288,_7290) --> 
    w(verb(_7256,_7257,fin),_7302,_7288,_7319),
    {user:testmember(_7256,[be,appear])},
    negation0(_7240,_7341,_7319,_7358),
    somatom(_7370,_7358,_7290),
    !.

be_truefalse_that(_7240,[be_truefalse_that,_7285,_7314,!],_7271,_7273) --> 
    be_truefalse(_7240,_7285,_7271,_7302),
    optional([at],_7314,_7302,_7273),
    !.

be_truefalse(_7240,[be_truefalse,_7302,{},_7341,_7370,!],_7288,_7290) --> 
    w(verb(_7256,_7257,fin),_7302,_7288,_7319),
    {user:testmember(_7256,[be,appear])},
    negation0(_7240,_7341,_7319,_7358),
    somatom(_7370,_7358,_7290),
    !.

be_truefalse(_7240,[be_truefalse,_7294,_7343,!],_7280,_7282) --> 
    lexvaccept(rv,_7249,_7250,fin,_7240,_7294,_7280,_7319),
    gmem(_7249,[stand,mean2,indicate],_7343,_7319,_7282),
    !.

be_truefalse(_7240,[be_truefalse,_7309,{},_7348,lit(ut),lit(til),!],_7295,_7297) --> 
    w(verb(_7259,_7260,fin),_7309,_7295,_7326),
    {user:testmember(_7259,[see,look])},
    negation0(_7240,_7348,_7326,_7365),
    cc(ut,_7365,_7387),
    cc(til,_7387,_7297),
    !.

be_truefalse(_7240,[be_truefalse,_7309,{},_7348,lit(ut),lit(for),!],_7295,_7297) --> 
    w(verb(_7259,_7260,fin),_7309,_7295,_7326),
    {user:testmember(_7259,[see,look])},
    negation0(_7240,_7348,_7326,_7365),
    cc(ut,_7365,_7387),
    cc(for,_7387,_7297),
    !.

be_truefalse(_7240,[be_truefalse,_7309,{},_7348,lit(ut),lit(som),!],_7295,_7297) --> 
    w(verb(_7259,_7260,fin),_7309,_7295,_7326),
    {user:testmember(_7259,[see,look])},
    negation0(_7240,_7348,_7326,_7365),
    cc(ut,_7365,_7387),
    cc(som,_7387,_7297),
    !.

be_truefalse(_7240,[be_truefalse,_7287,!,_7321],_7273,_7275) --> 
    w(verb(agree,_7253,fin),_7287,_7273,_7304),
    !,
    negation0(_7240,_7321,_7304,_7275).

be_truefalse(_7240,[be_truefalse,_7278,_7302],_7264,_7266) --> 
    be(_7278,_7264,_7293),
    truefalse(_7240,_7302,_7293,_7266).

be_truefalse(not,[be_truefalse,_7288,_7317,_7341,_7365],_7274,_7276) --> 
    w(verb(reject,_7254,fin),_7288,_7274,_7305),
    infinitive(_7317,_7305,_7332),
    be(_7341,_7332,_7356),
    true(_7365,_7356,_7276).

been0([been0,_7272,!,_7301],_7261,_7263) --> 
    been(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

been0([been0,[]],_7255,_7255) --> 
    [].

been([been,_7272],_7261,_7263) --> 
    w(verb(be,past,part),_7272,_7261,_7263).

betake([betake,_7266],_7255,_7257) --> 
    be(_7266,_7255,_7257).

betake([betake,_7272],_7261,_7263) --> 
    w(verb(take,_7243,fin),_7272,_7261,_7263).

both0([both0,lit('både')],_7257,_7259) --> 
    cc('både',_7257,_7259).

both0([both0,[]],_7255,_7255) --> 
    [].

by([by,lit(av),_7286],_7264,_7266) --> 
    cc(av,_7264,_7285),
    not_look_ahead([hensyn],_7286,_7285,_7266).

ca0([ca0,_7272,!,_7301],_7261,_7263) --> 
    ca(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

ca0([ca0,[]],_7255,_7255) --> 
    [].

ca([ca,_7277,_7306,!,_7335],_7266,_7268) --> 
    prep1(around,_7277,_7266,_7294),
    point0(_7306,_7294,_7321),
    !,
    accept(_7335,_7321,_7268).

clock0([clock0,_7266],_7255,_7257) --> 
    clock(_7266,_7255,_7257).

clock0([clock0,[]],_7255,_7255) --> 
    [].

clock([clock,lit(k),_7292,!],_7270,_7272) --> 
    cc(k,_7270,_7291),
    look_ahead(w(nb(_7252,_7253)),_7292,_7291,_7272),
    !.

clock([clock,lit(k),_7295,_7319,!],_7273,_7275) --> 
    cc(k,_7273,_7294),
    point(_7295,_7294,_7310),
    look_ahead(w(nb(_7255,_7256)),_7319,_7310,_7275),
    !.

clock([clock,lit(kl),_7285,!],_7263,_7265) --> 
    cc(kl,_7263,_7284),
    colon(_7285,_7284,_7265),
    !.

clock([clock,_7275,_7299,_7323,_7347],_7264,_7266) --> 
    point0(_7275,_7264,_7290),
    klokken(_7299,_7290,_7314),
    point0(_7323,_7314,_7338),
    ca0(_7347,_7338,_7266).

clock([clock,_7272,_7296,_7320],_7261,_7263) --> 
    point0(_7272,_7261,_7287),
    klokken(_7296,_7287,_7311),
    colon0(_7320,_7311,_7263).

klokken([klokken,lit(kl)],_7257,_7259) --> 
    cc(kl,_7257,_7259).

klokken([klokken,_7273],_7262,_7264) --> 
    w(noun(clock,sin,_7244,n),_7273,_7262,_7264).

colon0([colon0,_7272,!,_7301],_7261,_7263) --> 
    colon(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

colon0([colon0,_7270],_7259,_7261) --> 
    not_look_ahead(['.'],_7270,_7259,_7261).

colon([colon,lit(:)],_7257,_7259) --> 
    cc(:,_7257,_7259).

colon([colon,lit(;)],_7257,_7259) --> 
    cc(;,_7257,_7259).

comparator1(_7240,[comparator1,_7278,!],_7264,_7266) --> 
    comparel(_7240,_7278,_7264,_7266),
    !.

comparel(eq,[comparel,_7276,_7300],_7262,_7264) --> 
    equal(_7276,_7262,_7291),
    tomed0(_7300,_7291,_7264).

comparel(ge,[comparel,_7285,_7309,_7333,_7357,_7381],_7271,_7273) --> 
    greater(_7285,_7271,_7300),
    than0(_7309,_7300,_7324),
    or1(_7333,_7324,_7348),
    equal(_7357,_7348,_7372),
    to0(_7381,_7372,_7273).

comparel(ge,[comparel,_7279,_7303,_7327],_7265,_7267) --> 
    not(_7279,_7265,_7294),
    less(_7303,_7294,_7318),
    than(_7327,_7318,_7267).

comparel(ge,[comparel,lit(minst)],_7261,_7263) --> 
    cc(minst,_7261,_7263).

comparel(gt,[comparel,_7276,_7300],_7262,_7264) --> 
    greater(_7276,_7262,_7291),
    than(_7300,_7291,_7264).

comparel(gt,[comparel,lit(mer),_7289],_7264,_7266) --> 
    cc(mer,_7264,_7288),
    than(_7289,_7288,_7266).

comparel(gt,[comparel,_7275],_7261,_7263) --> 
    prep1(over,_7275,_7261,_7263).

comparel(le,[comparel,_7285,_7309,_7333,_7357,_7381],_7271,_7273) --> 
    less(_7285,_7271,_7300),
    than0(_7309,_7300,_7324),
    or1(_7333,_7324,_7348),
    equal(_7357,_7348,_7372),
    to0(_7381,_7372,_7273).

comparel(le,[comparel,_7279,_7303,_7327],_7265,_7267) --> 
    not(_7279,_7265,_7294),
    more(_7303,_7294,_7318),
    than(_7327,_7318,_7267).

comparel(le,[comparel,_7279,_7303,_7327],_7265,_7267) --> 
    not(_7279,_7265,_7294),
    greater(_7303,_7294,_7318),
    than(_7327,_7318,_7267).

comparel(le,[comparel,_7276,_7300],_7262,_7264) --> 
    at(_7276,_7262,_7291),
    most(_7300,_7291,_7264).

comparel(lt,[comparel,_7276,_7300],_7262,_7264) --> 
    less(_7276,_7262,_7291),
    than(_7300,_7291,_7264).

comparel(ne,[comparel,lit(forskjellig),_7291],_7266,_7268) --> 
    cc(forskjellig,_7266,_7290),
    prep1(from,_7291,_7290,_7268).

comparel(ne,[comparel,lit(annet),lit(enn)],_7266,_7268) --> 
    cc(annet,_7266,_7290),
    cc(enn,_7290,_7268).

comparel(ne,[comparel,lit(ulik)],_7261,_7263) --> 
    cc(ulik,_7261,_7263).

comparel(ne,[comparel,lit(unntatt)],_7261,_7263) --> 
    cc(unntatt,_7261,_7263).

comparel(ne,[comparel,_7276,_7300],_7262,_7264) --> 
    unequal(_7276,_7262,_7291),
    to0(_7300,_7291,_7264).

comparel(_7240,[comparel,_7283,lit(enn)],_7269,_7271) --> 
    w(adj2(_7240,comp),_7283,_7269,_7300),
    cc(enn,_7300,_7271).

comparel(_7240,[comparel,lit(mer),_7299,lit(enn)],_7274,_7276) --> 
    cc(mer,_7274,_7298),
    w(adj2(_7240,nil),_7299,_7298,_7316),
    cc(enn,_7316,_7276).

comparator2(gt,intelligent,[comparator2,_7287,_7316],_7270,_7272) --> 
    w(adj2(intelligent,nil),_7287,_7270,_7304),
    than(_7316,_7304,_7272).

comparator2(lt,intelligent,[comparator2,_7287,_7316],_7270,_7272) --> 
    w(adj2(stupid,nil),_7287,_7270,_7304),
    than(_7316,_7304,_7272).

comparator2(gt,quality,[comparator2,_7287,_7316],_7270,_7272) --> 
    w(adj2(good,comp),_7287,_7270,_7304),
    than(_7316,_7304,_7272).

comparator2(gt,age,[comparator2,_7282,_7306],_7265,_7267) --> 
    older(_7282,_7265,_7297),
    than(_7306,_7297,_7267).

comparator2(lt,age,[comparator2,_7282,_7306],_7265,_7267) --> 
    younger(_7282,_7265,_7297),
    than(_7306,_7297,_7267).

comparator2(gt,latitude,[comparator2,lit(nord),lit(for)],_7269,_7271) --> 
    cc(nord,_7269,_7296),
    cc(for,_7296,_7271).

comparator2(lt,latitude,[comparator2,lit('sør'),lit(for)],_7269,_7271) --> 
    cc('sør',_7269,_7296),
    cc(for,_7296,_7271).

comparator2(gt,longitude,[comparator2,lit(vest),lit(for)],_7269,_7271) --> 
    cc(vest,_7269,_7296),
    cc(for,_7296,_7271).

comparator2(lt,longitude,[comparator2,lit('øst'),lit(for)],_7269,_7271) --> 
    cc('øst',_7269,_7296),
    cc(for,_7296,_7271).

comparator2(gt,size,[comparator2,_7282,_7306],_7265,_7267) --> 
    greater(_7282,_7265,_7297),
    than(_7306,_7297,_7267).

comparator2(lt,size,[comparator2,lit(mindre),_7295],_7267,_7269) --> 
    cc(mindre,_7267,_7294),
    than(_7295,_7294,_7269).

comparator3(eq,_7241,[comparator3,lit(like),_7305,lit(som)],_7277,_7279) --> 
    cc(like,_7277,_7304),
    w(adj2(_7241,nil),_7305,_7304,_7322),
    cc(som,_7322,_7279).

comparator3(gt,_7241,[comparator3,lit(mer),_7305,lit(enn)],_7277,_7279) --> 
    cc(mer,_7277,_7304),
    w(adj2(_7241,nil),_7305,_7304,_7322),
    cc(enn,_7322,_7279).

comparator3(lt,_7241,[comparator3,lit(mindre),_7305,lit(enn)],_7277,_7279) --> 
    cc(mindre,_7277,_7304),
    w(adj2(_7241,nil),_7305,_7304,_7322),
    cc(enn,_7322,_7279).

comparator3(lt,_7241,[comparator3,lit(ikke),lit('så'),_7321,lit(som)],_7282,_7284) --> 
    cc(ikke,_7282,_7309),
    cc('så',_7309,_7320),
    w(adj2(_7241,nil),_7321,_7320,_7338),
    cc(som,_7338,_7284).

comparator3(ge,_7241,[comparator3,lit(minst),lit(like),_7321,lit(som)],_7282,_7284) --> 
    cc(minst,_7282,_7309),
    cc(like,_7309,_7320),
    w(adj2(_7241,nil),_7321,_7320,_7338),
    cc(som,_7338,_7284).

comparator3(le,_7241,[comparator3,lit('høyst'),lit('så'),_7321,lit(som)],_7282,_7284) --> 
    cc('høyst',_7282,_7309),
    cc('så',_7309,_7320),
    w(adj2(_7241,nil),_7321,_7320,_7338),
    cc(som,_7338,_7284).

superlative(_7240,_7241,[superlative,_7294,_7333,!,_7367],_7277,_7279) --> 
    filanepr(_7240,_7253,_7241,_7294,_7277,_7315),
    quant1(_7253,_7333,_7315,_7350),
    !,
    accept(_7367,_7350,_7279).

superlative(_7240,_7241,[superlative,_7288,_7317],_7271,_7273) --> 
    quant0(_7247,_7288,_7271,_7305),
    filanepr(_7240,_7247,_7241,_7317,_7305,_7273).

flnp(_7240,[flnp,_7292,_7321],_7278,_7280) --> 
    w(adj2(_7240,nil),_7292,_7278,_7309),
    gmem(_7240,[first,last,next,previous],_7321,_7309,_7280).

flnp(next,[flnp,lit(nest)],_7261,_7263) --> 
    cc(nest,_7261,_7263).

flnp(last,[flnp,_7281,!],_7267,_7269) --> 
    w(adj2(late,sup),_7281,_7267,_7269),
    !.

flnp(first,[flnp,_7278],_7264,_7266) --> 
    w(nb(1,ord),_7278,_7264,_7266).

flnpproper(_7240,[flnpproper,lit('først'),!,_7297],_7267,_7269) --> 
    cc('først',_7267,_7291),
    !,
    reject(_7297,_7291,_7269).

flnpproper(_7240,[flnpproper,lit(sist),!,_7297],_7267,_7269) --> 
    cc(sist,_7267,_7291),
    !,
    reject(_7297,_7291,_7269).

flnpproper(_7240,[flnpproper,lit(nest),!,_7297],_7267,_7269) --> 
    cc(nest,_7267,_7291),
    !,
    reject(_7297,_7291,_7269).

flnpproper(_7240,[flnpproper,_7275],_7261,_7263) --> 
    flnp(_7240,_7275,_7261,_7263).

filanepr([filanepr,_7274,!],_7263,_7265) --> 
    w(adj2(first,nil),_7274,_7263,_7265),
    !.

filanepr([filanepr,_7274,!],_7263,_7265) --> 
    w(adj2(last,nil),_7274,_7263,_7265),
    !.

filanepr([filanepr,_7274,!],_7263,_7265) --> 
    w(adj2(next,nil),_7274,_7263,_7265),
    !.

filanepr([filanepr,_7274,!],_7263,_7265) --> 
    w(adj2(previous,nil),_7274,_7263,_7265),
    !.

filanepr(min(_7241),_7241,time,[filanepr,_7287],_7267,_7269) --> 
    first(_7287,_7267,_7269).

filanepr(max(_7241),_7241,time,[filanepr,_7287],_7267,_7269) --> 
    latest(_7287,_7267,_7269).

filanepr(min(_7241),_7241,next,[filanepr,_7287],_7267,_7269) --> 
    next(_7287,_7267,_7269).

filanepr(max(_7241),_7241,previous,[filanepr,_7287],_7267,_7269) --> 
    previous(_7287,_7267,_7269).

filanepr(max(_7241),_7241,size,[filanepr,_7287],_7267,_7269) --> 
    greatest(_7287,_7267,_7269).

filanepr(min(_7241),_7241,size,[filanepr,lit(minste)],_7269,_7271) --> 
    cc(minste,_7269,_7271).

faaverb(_7240,[faaverb,_7285,_7309,!],_7271,_7273) --> 
    faa(_7285,_7271,_7300),
    w(verb(_7240,_7251,_7252),_7309,_7300,_7273),
    !.

faaverb(_7240,[faaverb,_7282,!],_7268,_7270) --> 
    w(verb(_7240,inf,fin),_7282,_7268,_7270),
    !.

da0([da0,lit(da),!,_7290],_7263,_7265) --> 
    cc(da,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

da0([da0,[]],_7255,_7255) --> 
    [].

de0([de0,lit(de),!,_7290],_7263,_7265) --> 
    cc(de,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

de0([de0,[]],_7255,_7255) --> 
    [].

dendagen(_7240,[dendagen,lit(om),_7300,_7329,!,_7358],_7275,_7277) --> 
    cc(om,_7275,_7299),
    day(_7240,_7300,_7299,_7317),
    den0(_7329,_7317,_7344),
    !,
    accept(_7358,_7344,_7277).

dendagen(nil,[dendagen,_7282,_7306,!,_7335],_7268,_7270) --> 
    today(_7282,_7268,_7297),
    den0(_7306,_7297,_7321),
    !,
    accept(_7335,_7321,_7270).

dendagen(nil,[dendagen,_7282,_7306,!,_7335],_7268,_7270) --> 
    yesterday(_7282,_7268,_7297),
    den0(_7306,_7297,_7321),
    !,
    accept(_7335,_7321,_7270).

dendagen(nil,[dendagen,_7282,_7306,!,_7335],_7268,_7270) --> 
    tomorrow(_7282,_7268,_7297),
    den0(_7306,_7297,_7321),
    !,
    accept(_7335,_7321,_7270).

dendagen(_7240,[dendagen,_7287,_7311,_7340,!,_7369],_7273,_7275) --> 
    on0(_7287,_7273,_7302),
    day(_7240,_7311,_7302,_7328),
    den0(_7340,_7328,_7355),
    !,
    accept(_7369,_7355,_7275).

dendagen(nil,[dendagen,_7284,lit(den),!,_7324],_7270,_7272) --> 
    on0(_7284,_7270,_7299),
    cc(den,_7299,_7318),
    !,
    accept(_7324,_7318,_7272).

dendagen(nil,[dendagen,_7284,_7313,!,_7342],_7270,_7272) --> 
    prep1(for,_7284,_7270,_7301),
    den0(_7313,_7301,_7328),
    !,
    accept(_7342,_7328,_7272).

dendagen(nil,[dendagen,_7281,!,_7315],_7267,_7269) --> 
    prep1(on,_7281,_7267,_7298),
    !,
    accept(_7315,_7298,_7269).

der0([der0,lit(der),_7288,!,_7317],_7266,_7268) --> 
    cc(der,_7266,_7287),
    qm0(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

der0([der0,_7266],_7255,_7257) --> 
    qm0(_7266,_7255,_7257).

qm0([qm0,lit(?)],_7257,_7259) --> 
    cc(?,_7257,_7259).

qm0([qm0,[]],_7255,_7255) --> 
    [].

detsamme([detsamme,lit(en),lit(gang)],_7262,_7264) --> 
    cc(en,_7262,_7283),
    cc(gang,_7283,_7264).

detsamme([detsamme,_7278,lit(det),lit(samme)],_7267,_7269) --> 
    prep1(with,_7278,_7267,_7295),
    cc(det,_7295,_7317),
    cc(samme,_7317,_7269).

den0([den0,_7269,!],_7258,_7260) --> 
    den(_7269,_7258,_7260),
    !.

den0([den0,[]],_7255,_7255) --> 
    [].

den([den,lit(den)],_7257,_7259) --> 
    cc(den,_7257,_7259).

dendet0([dendet0,_7273,!],_7262,_7264) --> 
    look_ahead([d],_7273,_7262,_7264),
    !.

dendet0([dendet0,lit(den),_7295,!,_7329],_7273,_7275) --> 
    cc(den,_7273,_7294),
    not_look_ahead(w(nb(_7255,_7256)),_7295,_7294,_7312),
    !,
    accept(_7329,_7312,_7275).

dendet0([dendet0,lit(det),!,_7290],_7263,_7265) --> 
    cc(det,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

dendet0([dendet0,[]],_7255,_7255) --> 
    [].

dent0([dent0,lit(den),!],_7260,_7262) --> 
    cc(den,_7260,_7262),
    !.

dent0([dent0,lit(det),!],_7260,_7262) --> 
    cc(det,_7260,_7262),
    !.

dent0([dent0,lit(de),!,_7290],_7263,_7265) --> 
    cc(de,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

dent0([dent0,lit(noen),!],_7260,_7262) --> 
    cc(noen,_7260,_7262),
    !.

dent0([dent0,lit(en),!],_7260,_7262) --> 
    cc(en,_7260,_7262),
    !.

dent0([dent0,[]],_7255,_7255) --> 
    [].

det0([det0,_7275,_7299,!,_7328],_7264,_7266) --> 
    thereit(_7275,_7264,_7290),
    thereit_not_pronoun(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

det0([det0,[]],_7255,_7255) --> 
    [].

dudet([dudet,lit(du)],_7257,_7259) --> 
    cc(du,_7257,_7259).

dudet([dudet,lit(det)],_7257,_7259) --> 
    cc(det,_7257,_7259).

dudet([dudet,_7268],_7257,_7259) --> 
    pronoun(_7240,_7268,_7257,_7259).

each([each,lit(alle),_7282],_7260,_7262) --> 
    cc(alle,_7260,_7281),
    the(_7282,_7281,_7262).

earlier([earlier,lit(tidligere)],_7257,_7259) --> 
    cc(tidligere,_7257,_7259).

earlier([earlier,_7273,lit('forhånd')],_7262,_7264) --> 
    prep1(on,_7273,_7262,_7290),
    cc('forhånd',_7290,_7264).

earlier([earlier,lit('derfør')],_7257,_7259) --> 
    cc('derfør',_7257,_7259).

either0([either0,lit(enten),!,_7290],_7263,_7265) --> 
    cc(enten,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

either0([either0,[]],_7255,_7255) --> 
    [].

equal([equal,lit(lik)],_7257,_7259) --> 
    cc(lik,_7257,_7259).

equal([equal,lit(likt)],_7257,_7259) --> 
    cc(likt,_7257,_7259).

iyou(du,[iyou,lit(du)],_7261,_7263) --> 
    cc(du,_7261,_7263).

iyou(jeg,[iyou,lit(jeg)],_7261,_7263) --> 
    cc(jeg,_7261,_7263).

iyou(vi,[iyou,lit(vi)],_7261,_7263) --> 
    cc(vi,_7261,_7263).

areyou([areyou,lit(erru),_7284],_7262,_7264) --> 
    cc(erru,_7262,_7283),
    negation0(_7243,_7284,_7283,_7264).

areyou([areyou,_7282,lit(du),_7322],_7271,_7273) --> 
    w(verb(be,_7251,fin),_7282,_7271,_7299),
    cc(du,_7299,_7321),
    negation0(_7246,_7322,_7321,_7273).

areyou([areyou,lit(vil),lit(du),_7309,_7338],_7276,_7278) --> 
    cc(vil,_7276,_7297),
    cc(du,_7297,_7308),
    negation0(_7259,_7309,_7308,_7326),
    w(verb(be,_7252,fin),_7338,_7326,_7278).

every([every,lit(alle),_7282],_7260,_7262) --> 
    cc(alle,_7260,_7281),
    de0(_7282,_7281,_7262).

every([every,lit(en),lit(hver)],_7262,_7264) --> 
    cc(en,_7262,_7283),
    cc(hver,_7283,_7264).

false([false,lit(galt)],_7257,_7259) --> 
    cc(galt,_7257,_7259).

false([false,lit(usant)],_7257,_7259) --> 
    cc(usant,_7257,_7259).

false([false,lit(feil)],_7257,_7259) --> 
    cc(feil,_7257,_7259).

false([false,lit(uriktig)],_7257,_7259) --> 
    cc(uriktig,_7257,_7259).

few([few,lit('få')],_7257,_7259) --> 
    cc('få',_7257,_7259).

few([few,lit('fåtallig')],_7257,_7259) --> 
    cc('fåtallig',_7257,_7259).

first([first,_7271],_7260,_7262) --> 
    w(adj2(first,nil),_7271,_7260,_7262).

first([first,lit(tidligste)],_7257,_7259) --> 
    cc(tidligste,_7257,_7259).

faa([faa,lit('få')],_7257,_7259) --> 
    cc('få',_7257,_7259).

faa([faa,lit('får')],_7257,_7259) --> 
    cc('får',_7257,_7259).

faa0([faa0,_7272,!,_7301],_7261,_7263) --> 
    faa(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

faa0([faa0,[]],_7255,_7255) --> 
    [].

fast([fast,lit(fort)],_7257,_7259) --> 
    cc(fort,_7257,_7259).

fast([fast,_7271],_7260,_7262) --> 
    w(adj2(fast,nil),_7271,_7260,_7262).

fast([fast,_7276,lit(mulig)],_7265,_7267) --> 
    w(adj2(fast,nil),_7276,_7265,_7293),
    cc(mulig,_7293,_7267).

fast([fast,_7266],_7255,_7257) --> 
    hereafter(_7266,_7255,_7257).

from([from,_7268],_7257,_7259) --> 
    prep(from,_7268,_7257,_7259).

'førn\'år'(['førn\'år',lit('når')],_7257,_7259) --> 
    cc('når',_7257,_7259).

'førn\'år'(['førn\'år',lit('før')],_7257,_7259) --> 
    cc('før',_7257,_7259).

great([great,_7271],_7260,_7262) --> 
    w(adj2(great,nil),_7271,_7260,_7262).

great([great,lit('høy')],_7257,_7259) --> 
    cc('høy',_7257,_7259).

greater([greater,_7268],_7257,_7259) --> 
    prep(after,_7268,_7257,_7259).

greater([greater,lit('større')],_7257,_7259) --> 
    cc('større',_7257,_7259).

greater([greater,lit('høyere')],_7257,_7259) --> 
    cc('høyere',_7257,_7259).

greater([greater,lit(mer)],_7257,_7259) --> 
    cc(mer,_7257,_7259).

greater([greater,_7266],_7255,_7257) --> 
    great(_7266,_7255,_7257).

greatest([greatest,lit('størst')],_7257,_7259) --> 
    cc('størst',_7257,_7259).

greatest([greatest,lit('største')],_7257,_7259) --> 
    cc('største',_7257,_7259).

halfhour([halfhour,lit(halv),_7289],_7267,_7269) --> 
    cc(halv,_7267,_7288),
    w(noun(hour,_7246,_7247,n),_7289,_7288,_7269).

halfhour([halfhour,lit(halvtime)],_7257,_7259) --> 
    cc(halvtime,_7257,_7259).

has(_7240,[has,_7290,_7314,_7343],_7276,_7278) --> 
    has(_7290,_7276,_7305),
    negation0(_7240,_7314,_7305,_7331),
    not_look_ahead(w(noun(arrival,_7253,_7254,n)),_7343,_7331,_7278).

has0([has0,_7269,!],_7258,_7260) --> 
    has(_7269,_7258,_7260),
    !.

has0([has0,[]],_7255,_7255) --> 
    [].

has([has,_7284,_7313],_7273,_7275) --> 
    w(verb(have,_7255,fin),_7284,_7273,_7301),
    not_look_ahead(w(noun(arrival,_7248,_7249,n)),_7313,_7301,_7275).

hashad0([hashad0,_7269,!],_7258,_7260) --> 
    hashad(_7269,_7258,_7260),
    !.

hashad0([hashad0,[]],_7255,_7255) --> 
    [].

hashad([hashad,_7287,_7316,!,_7350],_7276,_7278) --> 
    w(verb(have,_7252,_7253),_7287,_7276,_7304),
    w(verb(have,_7258,_7259),_7316,_7304,_7333),
    !,
    accept(_7350,_7333,_7278).

hashad([hashad,_7272],_7261,_7263) --> 
    w(verb(have,_7243,_7244),_7272,_7261,_7263).

hasto0([hasto0,_7275,_7304],_7264,_7266) --> 
    w(verb(have,_7246,fin),_7275,_7264,_7292),
    infinitive(_7304,_7292,_7266).

hasto0([hasto0,[]],_7255,_7255) --> 
    [].

hereafter([hereafter,lit(om),lit(ikke),lit('så'),lit(lenge)],_7272,_7274) --> 
    cc(om,_7272,_7293),
    cc(ikke,_7293,_7304),
    cc('så',_7304,_7315),
    cc(lenge,_7315,_7274).

hereafter([hereafter,_7269,_7293],_7258,_7260) --> 
    soonar(_7269,_7258,_7284),
    aspossible0(_7293,_7284,_7260).

hereafter([hereafter,lit('så'),_7298,lit(som),_7333,!],_7276,_7278) --> 
    cc('så',_7276,_7297),
    soon(_7298,_7297,_7313),
    cc(som,_7313,_7332),
    w(adj2(possible,nil),_7333,_7332,_7278),
    !.

hereafter([hereafter,_7284,_7313,_7337,!],_7273,_7275) --> 
    prep1(in,_7284,_7273,_7301),
    near(_7313,_7301,_7328),
    w(noun(future,_7254,_7255,_7256),_7337,_7328,_7275),
    !.

hereafter([hereafter,lit(med),lit(en),lit(gang)],_7267,_7269) --> 
    cc(med,_7267,_7288),
    cc(en,_7288,_7299),
    cc(gang,_7299,_7269).

hereafter([hereafter,lit(heretter)],_7257,_7259) --> 
    cc(heretter,_7257,_7259).

hereafter([hereafter,_7271,_7300],_7260,_7262) --> 
    prep1(from,_7271,_7260,_7288),
    nowon(_7300,_7288,_7262).

hereafter([hereafter,_7286,_7315,_7344],_7275,_7277) --> 
    prep1(in,_7286,_7275,_7303),
    w(adj2(nearest,nil),_7315,_7303,_7332),
    w(noun(future,_7249,_7250,n),_7344,_7332,_7277).

hereafter([hereafter,_7286,_7315,_7344],_7275,_7277) --> 
    prep1(on,_7286,_7275,_7303),
    w(adj2(_7257,nil),_7315,_7303,_7332),
    w(noun(way,_7249,u,n),_7344,_7332,_7277).

hereafter([hereafter,_7271,_7300],_7260,_7262) --> 
    prep1(after,_7271,_7260,_7288),
    now1(_7300,_7288,_7262).

hereafter([hereafter,_7273,lit(dette)],_7262,_7264) --> 
    prep1(after,_7273,_7262,_7290),
    cc(dette,_7290,_7264).

hereafter([hereafter,lit(raskest),lit(mulig)],_7262,_7264) --> 
    cc(raskest,_7262,_7283),
    cc(mulig,_7283,_7264).

hereafter([hereafter,_7276,lit(gang)],_7265,_7267) --> 
    w(adj2(next,nil),_7276,_7265,_7293),
    cc(gang,_7293,_7267).

hereafter([hereafter,lit(raskest)],_7257,_7259) --> 
    cc(raskest,_7257,_7259).

herefrom([herefrom,_7279,lit(her),!,_7324],_7268,_7270) --> 
    prep1(from,_7279,_7268,_7296),
    cc(her,_7296,_7318),
    !,
    accept(_7324,_7318,_7270).

herefrom([herefrom,lit(herfra)],_7257,_7259) --> 
    cc(herfra,_7257,_7259).

herefrom([herefrom,lit(derfra)],_7257,_7259) --> 
    cc(derfra,_7257,_7259).

how([how,lit(hvordan),_7282],_7260,_7262) --> 
    cc(hvordan,_7260,_7281),
    ialle0(_7282,_7281,_7262).

how([how,lit(hvorfor),_7282],_7260,_7262) --> 
    cc(hvorfor,_7260,_7281),
    ialle0(_7282,_7281,_7262).

hoq([hoq,lit(vil),lit(du),lit(at)],_7267,_7269) --> 
    cc(vil,_7267,_7288),
    cc(du,_7288,_7299),
    cc(at,_7299,_7269).

hoq([hoq,_7282,lit(det),lit(at)],_7271,_7273) --> 
    w(verb(mean,_7251,fin),_7282,_7271,_7299),
    cc(det,_7299,_7321),
    cc(at,_7321,_7273).

hoq([hoq,_7284,lit(det),lit(seg),_7330,lit(at)],_7273,_7275) --> 
    has(_7284,_7273,_7299),
    cc(det,_7299,_7318),
    cc(seg,_7318,_7329),
    redundant0(_7330,_7329,_7345),
    cc(at,_7345,_7275).

hoq([hoq,_7279,lit(det),_7314,lit(at)],_7268,_7270) --> 
    be(_7279,_7268,_7294),
    cc(det,_7294,_7313),
    redundant0(_7314,_7313,_7329),
    cc(at,_7329,_7270).

hoq([hoq,_7287,lit(det),lit(an),lit(at)],_7276,_7278) --> 
    w(verb(go,_7254,fin),_7287,_7276,_7304),
    cc(det,_7304,_7326),
    cc(an,_7326,_7337),
    cc(at,_7337,_7278).

hoq([hoq,_7287,lit(det),_7327,lit(at)],_7276,_7278) --> 
    w(verb(agree,_7254,fin),_7287,_7276,_7304),
    cc(det,_7304,_7326),
    negation0(_7259,_7327,_7326,_7344),
    cc(at,_7344,_7278).

ihvor([ihvor,lit(i),lit(hvor),!],_7265,_7267) --> 
    cc(i,_7265,_7286),
    cc(hvor,_7286,_7267),
    !.

ihvor([ihvor,lit(hvor)],_7257,_7259) --> 
    cc(hvor,_7257,_7259).

hvor([hvor,lit(hvor)],_7257,_7259) --> 
    cc(hvor,_7257,_7259).

hvordan([hvordan,lit(hvordan),!,_7290],_7263,_7265) --> 
    cc(hvordan,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

hvordan([hvordan,lit(hva),lit(slags),_7304,!,_7333],_7271,_7273) --> 
    cc(hva,_7271,_7292),
    cc(slags,_7292,_7303),
    type0(_7304,_7303,_7319),
    !,
    accept(_7333,_7319,_7273).

hvordan([hvordan,lit(hva),!,_7290],_7263,_7265) --> 
    cc(hva,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

hvordan([hvordan,lit(hvor),_7293,!,_7327],_7271,_7273) --> 
    cc(hvor,_7271,_7292),
    w(adj2(great,nil),_7293,_7292,_7310),
    !,
    accept(_7327,_7310,_7273).

hvorfor([hvorfor,lit(hvorfor),_7282],_7260,_7262) --> 
    cc(hvorfor,_7260,_7281),
    ialle0(_7282,_7281,_7262).

type0([type0,_7272,!,_7301],_7261,_7263) --> 
    type(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

type0([type0,[]],_7255,_7255) --> 
    [].

type([type,_7279,!,_7313],_7268,_7270) --> 
    w(noun(type,_7249,u,n),_7279,_7268,_7296),
    !,
    accept(_7313,_7296,_7270).

i([i,lit(jeg)],_7257,_7259) --> 
    cc(jeg,_7257,_7259).

i([i,lit(meg)],_7257,_7259) --> 
    cc(meg,_7257,_7259).

i([i,lit(oss)],_7257,_7259) --> 
    cc(oss,_7257,_7259).

ialle0([ialle0,[]],_7255,_7255) --> 
    [].

if1([if1,lit(hvis)],_7257,_7259) --> 
    cc(hvis,_7257,_7259).

if1([if1,lit(om),_7300,{}],_7278,_7280) --> 
    cc(om,_7278,_7299),
    look_ahead(w(name(_7259,_7260,_7250)),_7300,_7299,_7280),
    {user:(\+subclass0(_7250,place))}.

if1([if1,lit(om),_7301,{}],_7279,_7281) --> 
    cc(om,_7279,_7300),
    look_ahead(w(noun(_7250,_7260,_7261,_7262)),_7301,_7300,_7281),
    {user:(\+subclass0(_7250,place))}.

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([jeg],_7286,_7285,_7266).

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([du],_7286,_7285,_7266).

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([han],_7286,_7285,_7266).

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([hun],_7286,_7285,_7266).

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([man],_7286,_7285,_7266).

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([vi],_7286,_7285,_7266).

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([dere],_7286,_7285,_7266).

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([de],_7286,_7285,_7266).

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([en],_7286,_7285,_7266).

if1([if1,lit(om),_7286],_7264,_7266) --> 
    cc(om,_7264,_7285),
    look_ahead([et],_7286,_7285,_7266).

ifra([ifra,lit(fra)],_7257,_7259) --> 
    cc(fra,_7257,_7259).

ifra([ifra,lit(ifra)],_7257,_7259) --> 
    cc(ifra,_7257,_7259).

iman([iman,lit(jeg)],_7257,_7259) --> 
    cc(jeg,_7257,_7259).

iman([iman,lit(man)],_7257,_7259) --> 
    cc(man,_7257,_7259).

iman([iman,lit(en)],_7257,_7259) --> 
    cc(en,_7257,_7259).

iman([iman,lit(du)],_7257,_7259) --> 
    cc(du,_7257,_7259).

inperiod0([inperiod0,_7284,_7313,!,_7347],_7273,_7275) --> 
    prep1(in,_7284,_7273,_7301),
    w(noun(hour,_7254,def,n),_7313,_7301,_7330),
    !,
    accept(_7347,_7330,_7275).

inperiod0([inperiod0,lit(om),_7295,!,_7329],_7273,_7275) --> 
    cc(om,_7273,_7294),
    w(noun(day,_7254,def,n),_7295,_7294,_7312),
    !,
    accept(_7329,_7312,_7275).

inperiod0([inperiod0,lit(hver),_7295,!,_7329],_7273,_7275) --> 
    cc(hver,_7273,_7294),
    w(noun(day,sin,u,n),_7295,_7294,_7312),
    !,
    accept(_7329,_7312,_7275).

inperiod0([inperiod0,[]],_7255,_7255) --> 
    [].

in_order_to(adj/nil/_7244,id,[in_order_to,_7285],_7268,_7270) --> 
    infinitiveand(_7285,_7268,_7270).

in_order_to(begin,id,[in_order_to,_7285,!,_7314],_7268,_7270) --> 
    infinitive(_7285,_7268,_7300),
    !,
    accept(_7314,_7300,_7270).

in_order_to(like,id,[in_order_to,_7285,!,_7314],_7268,_7270) --> 
    infinitive(_7285,_7268,_7300),
    !,
    accept(_7314,_7300,_7270).

in_order_to(start,id,[in_order_to,_7285,!,_7314],_7268,_7270) --> 
    infinitive(_7285,_7268,_7300),
    !,
    accept(_7314,_7300,_7270).

in_order_to(stop,id,[in_order_to,_7285,!,_7314],_7268,_7270) --> 
    infinitive(_7285,_7268,_7300),
    !,
    accept(_7314,_7300,_7270).

in_order_to(use,id,[in_order_to,_7306,{},_7345,!,_7374],_7289,_7291) --> 
    prepnof(_7255,_7306,_7289,_7323),
    {user:testmember(_7255,[on,to,for,with])},
    infinitive(_7345,_7323,_7360),
    !,
    accept(_7374,_7360,_7291).

in_order_to(use2,id,[in_order_to,_7285,!,_7314],_7268,_7270) --> 
    infinitive(_7285,_7268,_7300),
    !,
    accept(_7314,_7300,_7270).

in_order_to(have,id,[in_order_to,_7279],_7262,_7264) --> 
    infinitive(_7279,_7262,_7264).

in_order_to(think,id,[in_order_to,[]],_7262,_7262) --> 
    [].

in_order_to(_7240,not,[in_order_to,lit(uten),_7295],_7267,_7269) --> 
    cc(uten,_7267,_7294),
    infinitive(_7295,_7294,_7269).

in_order_to(_7240,id,[in_order_to,_7279],_7262,_7264) --> 
    in_order_to(_7279,_7262,_7264).

in_order_tox([in_order_tox,_7269,!],_7258,_7260) --> 
    infinitive(_7269,_7258,_7260),
    !.

in_order_tox([in_order_tox,_7266],_7255,_7257) --> 
    in_order_to(_7266,_7255,_7257).

in_order_to([in_order_to,_7266],_7255,_7257) --> 
    'forå'(_7266,_7255,_7257).

in_order_to([in_order_to,lit('får'),_7285,!],_7263,_7265) --> 
    cc('får',_7263,_7284),
    infinitive(_7285,_7284,_7265),
    !.

in_order_to([in_order_to,lit(for),_7285,!],_7263,_7265) --> 
    cc(for,_7263,_7284),
    infinitiveand(_7285,_7284,_7265),
    !.

in_order_to([in_order_to,lit('før'),_7285,!],_7263,_7265) --> 
    cc('før',_7263,_7284),
    infinitive(_7285,_7284,_7265),
    !.

in_order_to([in_order_to,_7274,_7303,!],_7263,_7265) --> 
    prep1(on,_7274,_7263,_7291),
    infinitive(_7303,_7291,_7265),
    !.

in_order_to([in_order_to,_7274,_7303,!],_7263,_7265) --> 
    prep1(with,_7274,_7263,_7291),
    infinitive(_7303,_7291,_7265),
    !.

in_order_to([in_order_to,_7274,_7303,!],_7263,_7265) --> 
    prep1(to,_7274,_7263,_7291),
    infinitiveand(_7303,_7291,_7265),
    !.

in_order_to([in_order_to,lit(av),_7285,!],_7263,_7265) --> 
    cc(av,_7263,_7284),
    infinitive(_7285,_7284,_7265),
    !.

in_order_to([in_order_to,lit(for),lit(og),!],_7265,_7267) --> 
    cc(for,_7265,_7286),
    cc(og,_7286,_7267),
    !.

in_order_to([in_order_to,lit('får'),lit('å'),!],_7265,_7267) --> 
    cc('får',_7265,_7286),
    cc('å',_7286,_7267),
    !.

in_order_to([in_order_to,lit('får'),lit(og),!],_7265,_7267) --> 
    cc('får',_7265,_7286),
    cc(og,_7286,_7267),
    !.

'forå'(['forå',lit(i),_7282],_7260,_7262) --> 
    cc(i,_7260,_7281),
    'ogå'(_7282,_7281,_7262).

'forå'(['forå',lit(med),_7282],_7260,_7262) --> 
    cc(med,_7260,_7281),
    'ogå'(_7282,_7281,_7262).

'forå'(['forå',lit(mot),_7282],_7260,_7262) --> 
    cc(mot,_7260,_7281),
    'ogå'(_7282,_7281,_7262).

'forå'(['forå',lit(for),_7282],_7260,_7262) --> 
    cc(for,_7260,_7281),
    'ogå'(_7282,_7281,_7262).

'forå'(['forå',lit(til),_7282],_7260,_7262) --> 
    cc(til,_7260,_7281),
    'ogå'(_7282,_7281,_7262).

'forå'(['forå',lit(over),_7282],_7260,_7262) --> 
    cc(over,_7260,_7281),
    'ogå'(_7282,_7281,_7262).

'forå'(['forå',lit('før'),lit('å')],_7262,_7264) --> 
    cc('før',_7262,_7283),
    cc('å',_7283,_7264).

'forå'(['forå',lit(ved),lit('å')],_7262,_7264) --> 
    cc(ved,_7262,_7283),
    cc('å',_7283,_7264).

'ogå'(['ogå',lit('å')],_7257,_7259) --> 
    cc('å',_7257,_7259).

'ogå'(['ogå',lit(og)],_7257,_7259) --> 
    cc(og,_7257,_7259).

infinitiveand([infinitiveand,lit('å')],_7257,_7259) --> 
    cc('å',_7257,_7259).

infinitiveand([infinitiveand,lit(og)],_7257,_7259) --> 
    cc(og,_7257,_7259).

infinitive([infinitive,lit('å'),_7296,_7320,!],_7274,_7276) --> 
    cc('å',_7274,_7295),
    faa(_7296,_7295,_7311),
    look_ahead(w(verb(_7255,_7256,_7257)),_7320,_7311,_7276),
    !.

infinitive([infinitive,lit('å')],_7257,_7259) --> 
    cc('å',_7257,_7259).

infinitive([infinitive,lit(til),lit('å')],_7262,_7264) --> 
    cc(til,_7262,_7283),
    cc('å',_7283,_7264).

inom(in,[inom,_7275],_7261,_7263) --> 
    prep1(in,_7275,_7261,_7263).

inom(om,[inom,lit(om)],_7261,_7263) --> 
    cc(om,_7261,_7263).

inom(om,[inom,_7275],_7261,_7263) --> 
    prep1(on,_7275,_7261,_7263).

instead_of([instead_of,lit(fremfor)],_7257,_7259) --> 
    cc(fremfor,_7257,_7259).

instead_of([instead_of,_7286,_7315,lit(for),!],_7275,_7277) --> 
    prep1(in,_7286,_7275,_7303),
    w(noun(place,sin,def,n),_7315,_7303,_7332),
    cc(for,_7332,_7277),
    !.

instead_of([instead_of,lit(istedenfor)],_7257,_7259) --> 
    cc(istedenfor,_7257,_7259).

instead_of([instead_of,lit(heller),lit(enn)],_7262,_7264) --> 
    cc(heller,_7262,_7283),
    cc(enn,_7283,_7264).

it0([it0,lit(det),_7289,!],_7267,_7269) --> 
    cc(det,_7267,_7288),
    not_look_ahead([vil],_7289,_7288,_7269),
    !.

it0([it0,[]],_7255,_7255) --> 
    [].

it([it,lit(den)],_7257,_7259) --> 
    cc(den,_7257,_7259).

its([its,lit(dens),_7282],_7260,_7262) --> 
    cc(dens,_7260,_7281),
    own0(_7282,_7281,_7262).

its([its,lit(dets),_7282],_7260,_7262) --> 
    cc(dets,_7260,_7281),
    own0(_7282,_7281,_7262).

later([later,lit(senere)],_7257,_7259) --> 
    cc(senere,_7257,_7259).

later([later,lit(siden),_7282],_7260,_7262) --> 
    cc(siden,_7260,_7281),
    not_look_ahead_np(_7282,_7281,_7262).

later([later,lit(deretter)],_7257,_7259) --> 
    cc(deretter,_7257,_7259).

latest([latest,_7271],_7260,_7262) --> 
    w(adj2(sup,late),_7271,_7260,_7262).

latest([latest,_7271],_7260,_7262) --> 
    w(adj2(last,nil),_7271,_7260,_7262).

less([less,lit('før')],_7257,_7259) --> 
    cc('før',_7257,_7259).

less([less,lit(tidligere)],_7257,_7259) --> 
    cc(tidligere,_7257,_7259).

less([less,lit(mindre)],_7257,_7259) --> 
    cc(mindre,_7257,_7259).

less([less,lit(lavere)],_7257,_7259) --> 
    cc(lavere,_7257,_7259).

let([let,_7272],_7261,_7263) --> 
    w(verb(let,pres,fin),_7272,_7261,_7263).

little([little,lit(lite)],_7257,_7259) --> 
    cc(lite,_7257,_7259).

long([long,_7271],_7260,_7262) --> 
    w(adj2(short,nil),_7271,_7260,_7262).

long([long,_7271],_7260,_7262) --> 
    w(adj2(long,nil),_7271,_7260,_7262).

longadj([longadj,_7271],_7260,_7262) --> 
    w(adj2(long,nil),_7271,_7260,_7262).

manypersons([manypersons,lit(mange),_7288,!,_7317],_7266,_7268) --> 
    cc(mange,_7266,_7287),
    adjnoun(_7288,_7287,_7303),
    !,
    reject(_7317,_7303,_7268).

manypersons([manypersons,lit(mange)],_7257,_7259) --> 
    cc(mange,_7257,_7259).

many1([many1,lit(mange),_7282],_7260,_7262) --> 
    cc(mange,_7260,_7281),
    off0(_7282,_7281,_7262).

many([many,_7274,lit(mange),_7309],_7263,_7265) --> 
    so0(_7274,_7263,_7289),
    cc(mange,_7289,_7308),
    off0(_7309,_7308,_7265).

meny([meny,lit(mange)],_7257,_7259) --> 
    cc(mange,_7257,_7259).

meny([meny,lit(meget)],_7257,_7259) --> 
    cc(meget,_7257,_7259).

meny([meny,lit(mye)],_7257,_7259) --> 
    cc(mye,_7257,_7259).

me0([me0,lit(jeg),!],_7260,_7262) --> 
    cc(jeg,_7260,_7262),
    !.

me0([me0,lit(meg),!],_7260,_7262) --> 
    cc(meg,_7260,_7262),
    !.

me0([me0,lit(oss),!],_7260,_7262) --> 
    cc(oss,_7260,_7262),
    !.

me0([me0,lit(seg),!],_7260,_7262) --> 
    cc(seg,_7260,_7262),
    !.

me0([me0,[]],_7255,_7255) --> 
    [].

mineyour0([mineyour0,_7271,!],_7260,_7262) --> 
    posspron(_7243,_7271,_7260,_7262),
    !.

mineyour0([mineyour0,[]],_7255,_7255) --> 
    [].

more([more,lit(mer)],_7257,_7259) --> 
    cc(mer,_7257,_7259).

more([more,lit(fler)],_7257,_7259) --> 
    cc(fler,_7257,_7259).

more([more,lit(flere)],_7257,_7259) --> 
    cc(flere,_7257,_7259).

most([most,lit(de),lit(fleste)],_7262,_7264) --> 
    cc(de,_7262,_7283),
    cc(fleste,_7283,_7264).

most([most,lit(flest)],_7257,_7259) --> 
    cc(flest,_7257,_7259).

much([much,lit(mye)],_7257,_7259) --> 
    cc(mye,_7257,_7259).

much([much,lit(meget)],_7257,_7259) --> 
    cc(meget,_7257,_7259).

my([my,lit(min)],_7257,_7259) --> 
    cc(min,_7257,_7259).

my([my,lit(mitt)],_7257,_7259) --> 
    cc(mitt,_7257,_7259).

my([my,lit(mine)],_7257,_7259) --> 
    cc(mine,_7257,_7259).

when10([when10,_7266],_7255,_7257) --> 
    when1(_7266,_7255,_7257).

when10([when10,[]],_7255,_7255) --> 
    [].

when1([when1,lit(da)],_7257,_7259) --> 
    cc(da,_7257,_7259).

when1([when1,lit('når')],_7257,_7259) --> 
    cc('når',_7257,_7259).

when1([when1,lit(n),{},!],_7268,_7270) --> 
    cc(n,_7268,_7270),
    {user:value(smsflag,true)},
    !.

when1([when1,lit(tid),_7286],_7264,_7266) --> 
    cc(tid,_7264,_7285),
    look_ahead(['går'],_7286,_7285,_7266).

negation2(only,only,[negation2,[],!],_7265,_7265) --> 
    [],
    !.

negation2(id,only,[negation2,_7281],_7264,_7266) --> 
    negation(only,_7281,_7264,_7266).

negation2(id,only,[negation2,_7281],_7264,_7266) --> 
    negation(only,_7281,_7264,_7266).

negation2(not,id,[negation2,_7281],_7264,_7266) --> 
    negation(only,_7281,_7264,_7266).

negation2(not,id,[negation2,_7287,!,_7321],_7270,_7272) --> 
    negation(not,_7287,_7270,_7304),
    !,
    reject(_7321,_7304,_7272).

negation2(not,not,[negation2,_7281],_7264,_7266) --> 
    negation0(id,_7281,_7264,_7266).

negation2(id,_7241,[negation2,_7281],_7264,_7266) --> 
    negation0(_7241,_7281,_7264,_7266).

negation2(often,often,[negation2,[]],_7262,_7262) --> 
    [].

negation0(_7240,[negation0,{},!],_7272,_7272) --> 
    {user:(nonvar(_7240),_7240==not)},
    !.

negation0(_7240,[negation0,_7278,!],_7264,_7266) --> 
    negation(_7240,_7278,_7264,_7266),
    !.

negation0(id,[negation0,[]],_7259,_7259) --> 
    [].

negation(id,[negation,_7281,lit(bare),!],_7267,_7269) --> 
    not(_7281,_7267,_7296),
    cc(bare,_7296,_7269),
    !.

negation(not,[negation,lit(bare),_7289],_7264,_7266) --> 
    cc(bare,_7264,_7288),
    not(_7289,_7288,_7266).

negation(not,[negation,_7273],_7259,_7261) --> 
    not(_7273,_7259,_7261).

negation(only,[negation,lit(bare)],_7261,_7263) --> 
    cc(bare,_7261,_7263).

negation(atleast,[negation,lit(minst)],_7261,_7263) --> 
    cc(minst,_7261,_7263).

negation(often,[negation,lit(ofte)],_7261,_7263) --> 
    cc(ofte,_7261,_7263).

negatino([negatino,lit(ikke),!],_7260,_7262) --> 
    cc(ikke,_7260,_7262),
    !.

negatino([negatino,lit(ingen),!],_7260,_7262) --> 
    cc(ingen,_7260,_7262),
    !.

negatino([negatino,[]],_7255,_7255) --> 
    [].

near([near,_7271],_7260,_7262) --> 
    w(adj2(near,nil),_7271,_7260,_7262).

near([near,_7274,_7298],_7263,_7265) --> 
    the0(_7274,_7263,_7289),
    w(adj2(nearest,nil),_7298,_7289,_7265).

nearest([nearest,_7271],_7260,_7262) --> 
    w(adj2(near,sup),_7271,_7260,_7262).

nearest([nearest,_7271],_7260,_7262) --> 
    w(adj2(nearest,nil),_7271,_7260,_7262).

nearest([nearest,_7268],_7257,_7259) --> 
    prep1(nearest,_7268,_7257,_7259).

nest([nest,lit(nest)],_7257,_7259) --> 
    cc(nest,_7257,_7259).

nest([nest,_7271],_7260,_7262) --> 
    w(adj2(next,nil),_7271,_7260,_7262).

next0([next0,_7269,!],_7258,_7260) --> 
    next(_7269,_7258,_7260),
    !.

next0([next0,[]],_7255,_7255) --> 
    [].

next([next,_7271],_7260,_7262) --> 
    w(adj2(next,nil),_7271,_7260,_7262).

no([no,lit(ingen),_7282],_7260,_7262) --> 
    cc(ingen,_7260,_7281),
    look_ahead_np(_7282,_7281,_7262).

notall([notall,lit(ikke),lit(alle)],_7262,_7264) --> 
    cc(ikke,_7262,_7283),
    cc(alle,_7283,_7264).

not0([not0,_7269,!],_7258,_7260) --> 
    not(_7269,_7258,_7260),
    !.

not0([not0,[]],_7255,_7255) --> 
    [].

not([not,lit(ikke)],_7257,_7259) --> 
    cc(ikke,_7257,_7259).

not([not,lit(intet),_7282],_7260,_7262) --> 
    cc(intet,_7260,_7281),
    look_ahead_np(_7282,_7281,_7262).

notwithstanding([notwithstanding,lit(selv_om)],_7257,_7259) --> 
    cc(selv_om,_7257,_7259).

notwithstanding([notwithstanding,lit(selv),lit(om)],_7262,_7264) --> 
    cc(selv,_7262,_7283),
    cc(om,_7283,_7264).

now0([now0,_7269,!],_7258,_7260) --> 
    now1(_7269,_7258,_7260),
    !.

now0([now0,_7266],_7255,_7257) --> 
    today(_7266,_7255,_7257).

now0([now0,[]],_7255,_7255) --> 
    [].

now1([now1,lit('ennå')],_7257,_7259) --> 
    cc('ennå',_7257,_7259).

now1([now1,lit('nå')],_7257,_7259) --> 
    cc('nå',_7257,_7259).

now1([now1,lit(no)],_7257,_7259) --> 
    cc(no,_7257,_7259).

nowon([nowon,_7274,lit(av),!],_7263,_7265) --> 
    now1(_7274,_7263,_7289),
    cc(av,_7289,_7265),
    !.

nowon([nowon,_7266],_7255,_7257) --> 
    now1(_7266,_7255,_7257).

nr0([nr0,_7269,!],_7258,_7260) --> 
    nr1(_7269,_7258,_7260),
    !.

nr0([nr0,[]],_7255,_7255) --> 
    [].

nr1([nr1,lit(nr),_7285,!],_7263,_7265) --> 
    cc(nr,_7263,_7284),
    point0(_7285,_7284,_7265),
    !.

nr1([nr1,lit(n),_7285,!],_7263,_7265) --> 
    cc(n,_7263,_7284),
    point0(_7285,_7284,_7265),
    !.

nr1([nr1,_7272,_7296,!],_7261,_7263) --> 
    number1(_7272,_7261,_7287),
    point0(_7296,_7287,_7263),
    !.

number0([number0,_7271,!],_7260,_7262) --> 
    num(_7243,_7271,_7260,_7262),
    !.

number0([number0,[]],_7255,_7255) --> 
    [].

number1([number1,_7276,_7305],_7265,_7267) --> 
    w(noun(number,sin,_7247,n),_7276,_7265,_7293),
    colon0(_7305,_7293,_7267).

of_course0([of_course0,_7266],_7255,_7257) --> 
    of_course(_7266,_7255,_7257).

of_course0([of_course0,_7274],_7263,_7265) --> 
    not_look_ahead(w(verb(_7244,_7245,_7246)),_7274,_7263,_7265).

of_coursenot0([of_coursenot0,_7271,lit(ikke)],_7260,_7262) --> 
    of_course(_7271,_7260,_7286),
    cc(ikke,_7286,_7262).

of_coursenot0([of_coursenot0,_7274],_7263,_7265) --> 
    not_look_ahead(w(verb(_7244,_7245,_7246)),_7274,_7263,_7265).

of_course([of_course,lit(naturligvis)],_7257,_7259) --> 
    cc(naturligvis,_7257,_7259).

of_course([of_course,lit('selvfølgelig')],_7257,_7259) --> 
    cc('selvfølgelig',_7257,_7259).

of_course([of_course,lit(det),_7288],_7266,_7268) --> 
    cc(det,_7266,_7287),
    w(verb(agree,pres,fin),_7288,_7287,_7268).

of0([of0,_7269,!],_7258,_7260) --> 
    of(_7269,_7258,_7260),
    !.

of0([of0,[]],_7255,_7255) --> 
    [].

of([of,_7268],_7257,_7259) --> 
    prep(of,_7268,_7257,_7259).

of([of,_7268],_7257,_7259) --> 
    prep1(to,_7268,_7257,_7259).

off0([off0,lit(av),!],_7260,_7262) --> 
    cc(av,_7260,_7262),
    !.

off0([off0,[]],_7255,_7255) --> 
    [].

offrom([offrom,lit(av)],_7257,_7259) --> 
    cc(av,_7257,_7259).

offrom([offrom,_7268],_7257,_7259) --> 
    prep1(from,_7268,_7257,_7259).

offrom([offrom,lit(ifra)],_7257,_7259) --> 
    cc(ifra,_7257,_7259).

often([often,_7271],_7260,_7262) --> 
    w(adj2(often,nil),_7271,_7260,_7262).

often([often,lit(ofte)],_7257,_7259) --> 
    cc(ofte,_7257,_7259).

often([often,lit(sjelden)],_7257,_7259) --> 
    cc(sjelden,_7257,_7259).

often([often,lit(jevnlig)],_7257,_7259) --> 
    cc(jevnlig,_7257,_7259).

ofthe([ofthe,_7269,_7293],_7258,_7260) --> 
    of(_7269,_7258,_7284),
    the(_7293,_7284,_7260).

ofthe0([ofthe0,_7266],_7255,_7257) --> 
    ofthe(_7266,_7255,_7257).

ofthe0([ofthe0,[]],_7255,_7255) --> 
    [].

older([older,lit(eldre)],_7257,_7259) --> 
    cc(eldre,_7257,_7259).

on0([on0,_7271,!],_7260,_7262) --> 
    prep1(on,_7271,_7260,_7262),
    !.

on0([on0,[]],_7255,_7255) --> 
    [].

newyear([newyear,_7281,_7310],_7270,_7272) --> 
    w(adj2(new,nil),_7281,_7270,_7298),
    w(noun(year,_7246,_7247,_7248),_7310,_7298,_7272).

newyear([newyear,lit('nyttår')],_7257,_7259) --> 
    cc('nyttår',_7257,_7259).

om0([om0,lit(om),!],_7260,_7262) --> 
    cc(om,_7260,_7262),
    !.

om0([om0,[]],_7255,_7255) --> 
    [].

on0([on0,lit('på'),!],_7260,_7262) --> 
    cc('på',_7260,_7262),
    !.

on0([on0,[]],_7255,_7255) --> 
    [].

one([one,_7271],_7260,_7262) --> 
    w(nb(1,num),_7271,_7260,_7262).

one([one,_7266],_7255,_7257) --> 
    a(_7266,_7255,_7257).

only0([only0,lit(bare),!],_7260,_7262) --> 
    cc(bare,_7260,_7262),
    !.

only0([only0,lit(hele),!],_7260,_7262) --> 
    cc(hele,_7260,_7262),
    !.

only0([only0,lit(nesten),!],_7260,_7262) --> 
    cc(nesten,_7260,_7262),
    !.

only0([only0,[]],_7255,_7255) --> 
    [].

or1([or1,lit(eller)],_7257,_7259) --> 
    cc(eller,_7257,_7259).

ordinal(_7240,[ordinal,_7278],_7264,_7266) --> 
    w(nb(_7240,ord),_7278,_7264,_7266).

oter([oter,_7266],_7255,_7257) --> 
    other(_7266,_7255,_7257).

oter([oter,_7266],_7255,_7257) --> 
    others(_7266,_7255,_7257).

other([other,lit(annen)],_7257,_7259) --> 
    cc(annen,_7257,_7259).

other([other,lit(annet)],_7257,_7259) --> 
    cc(annet,_7257,_7259).

others([others,lit(andre)],_7257,_7259) --> 
    cc(andre,_7257,_7259).

own0([own0,lit(egen)],_7257,_7259) --> 
    cc(egen,_7257,_7259).

own0([own0,lit(egne)],_7257,_7259) --> 
    cc(egne,_7257,_7259).

own0([own0,[]],_7255,_7255) --> 
    [].

possible0([possible0,_7274,!],_7263,_7265) --> 
    w(adj2(possible,nil),_7274,_7263,_7265),
    !.

possible0([possible0,[]],_7255,_7255) --> 
    [].

reflexiv0(_7240,[reflexiv0,_7281,!,_7315],_7267,_7269) --> 
    reflexiv(_7240,_7281,_7267,_7298),
    !,
    accept(_7315,_7298,_7269).

reflexiv0(_7240,[reflexiv0,{},!,_7299],_7270,_7272) --> 
    {user:verbtype(_7240,dtv)},
    !,
    accept(_7299,_7270,_7272).

reflexiv0(_7240,[reflexiv0,[]],_7259,_7259) --> 
    [].

reflexiv(ask,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(befind,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(beworry,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(buy,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(change,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(come,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(cost,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(decide,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(feel,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(fit,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(find,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(give,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(go,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(have,[reflexiv,lit(meg)],_7261,_7263) --> 
    cc(meg,_7261,_7263).

reflexiv(have,[reflexiv,lit(seg)],_7261,_7263) --> 
    cc(seg,_7261,_7263).

reflexiv(hurry,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(learn,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(move,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(pass,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(pay2,[reflexiv,lit(seg)],_7261,_7263) --> 
    cc(seg,_7261,_7263).

reflexiv(promise,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(get,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(get,[reflexiv,lit(med)],_7261,_7263) --> 
    cc(med,_7261,_7263).

reflexiv(receive,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(receive,[reflexiv,lit(med)],_7261,_7263) --> 
    cc(med,_7261,_7263).

reflexiv(retire,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(run,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(say,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(send,[reflexiv,_7276,_7300],_7262,_7264) --> 
    to0(_7276,_7262,_7291),
    rfxpron(_7300,_7291,_7264).

reflexiv(show,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(sneak,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(take,[reflexiv,lit(med),_7289],_7264,_7266) --> 
    cc(med,_7264,_7288),
    rfxpron(_7289,_7288,_7266).

reflexiv(take,[reflexiv,lit(med)],_7261,_7263) --> 
    cc(med,_7261,_7263).

reflexiv(take,[reflexiv,_7280,_7309],_7266,_7268) --> 
    not_look_ahead([dere],_7280,_7266,_7297),
    rfxpron(_7309,_7297,_7268).

reflexiv(tell,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(think,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(turn,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(want,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(wish,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(worry,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

reflexiv(write,[reflexiv,_7273],_7259,_7261) --> 
    rfxpron(_7273,_7259,_7261).

rfxpron0([rfxpron0,_7269,!],_7258,_7260) --> 
    rfxpron(_7269,_7258,_7260),
    !.

rfxpron0([rfxpron0,[]],_7255,_7255) --> 
    [].

rfxpron([rfxpron,lit(meg)],_7257,_7259) --> 
    cc(meg,_7257,_7259).

rfxpron([rfxpron,lit(deg)],_7257,_7259) --> 
    cc(deg,_7257,_7259).

rfxpron([rfxpron,lit(seg)],_7257,_7259) --> 
    cc(seg,_7257,_7259).

rfxpron([rfxpron,lit(oss)],_7257,_7259) --> 
    cc(oss,_7257,_7259).

rfxpron([rfxpron,lit(dere)],_7257,_7259) --> 
    cc(dere,_7257,_7259).

rfxpron([rfxpron,lit(selv),_7286],_7264,_7266) --> 
    cc(selv,_7264,_7285),
    not_look_ahead([om],_7286,_7285,_7266).

compassly([compassly,lit(nordfra)],_7257,_7259) --> 
    cc(nordfra,_7257,_7259).

compassly([compassly,lit(nordover)],_7257,_7259) --> 
    cc(nordover,_7257,_7259).

compassly([compassly,lit(sydfra)],_7257,_7259) --> 
    cc(sydfra,_7257,_7259).

compassly([compassly,lit(sydover)],_7257,_7259) --> 
    cc(sydover,_7257,_7259).

compassly([compassly,lit('sørfra')],_7257,_7259) --> 
    cc('sørfra',_7257,_7259).

compassly([compassly,lit('sørover')],_7257,_7259) --> 
    cc('sørover',_7257,_7259).

compassly([compassly,lit(vestfra)],_7257,_7259) --> 
    cc(vestfra,_7257,_7259).

compassly([compassly,lit(vestover)],_7257,_7259) --> 
    cc(vestover,_7257,_7259).

compassly([compassly,lit('østfra')],_7257,_7259) --> 
    cc('østfra',_7257,_7259).

compassly([compassly,lit('østover')],_7257,_7259) --> 
    cc('østover',_7257,_7259).

redundant0x([redundant0x,lit('så')],_7257,_7259) --> 
    cc('så',_7257,_7259).

redundant0x([redundant0x,_7266],_7255,_7257) --> 
    redundants0(_7266,_7255,_7257).

redundant0([redundant0,_7269,!],_7258,_7260) --> 
    redundant(_7269,_7258,_7260),
    !.

redundant0([redundant0,[]],_7255,_7255) --> 
    [].

redundants0([redundants0,_7272,_7296,!],_7261,_7263) --> 
    redundant(_7272,_7261,_7287),
    redundants0(_7296,_7287,_7263),
    !.

redundants0([redundants0,[]],_7255,_7255) --> 
    [].

redundantsx0([redundantsx0,_7272,!,_7301],_7261,_7263) --> 
    redundant(_7272,_7261,_7287),
    !,
    redxxx0(_7301,_7287,_7263).

redundantsx0([redundantsx0,[]],_7255,_7255) --> 
    [].

redxxx0([redxxx0,lit(og),_7285,!],_7263,_7265) --> 
    cc(og,_7263,_7284),
    redundant(_7285,_7284,_7265),
    !.

redxxx0([redxxx0,[]],_7255,_7255) --> 
    [].

redundant([redundant,_7273,!],_7262,_7264) --> 
    w(adv(redundantly),_7273,_7262,_7264),
    !.

redundant([redundant,_7278,_7307],_7267,_7269) --> 
    prep1(in,_7278,_7267,_7295),
    w(noun(average,_7246,_7247,_7248),_7307,_7295,_7269).

redundant([redundant,_7273,lit(allverden)],_7262,_7264) --> 
    prep1(in,_7273,_7262,_7290),
    cc(allverden,_7290,_7264).

redundant([redundant,_7290,lit(det),_7330,_7359],_7279,_7281) --> 
    prep1(in,_7290,_7279,_7307),
    cc(det,_7307,_7329),
    w(adj2(whole,nil),_7330,_7329,_7347),
    w(verb(take,past,part),_7359,_7347,_7281).

redundant([redundant,_7273,lit(hvertfall)],_7262,_7264) --> 
    prep1(in,_7273,_7262,_7290),
    cc(hvertfall,_7290,_7264).

redundant([redundant,_7273,lit(gjen)],_7262,_7264) --> 
    prep1(in,_7273,_7262,_7290),
    cc(gjen,_7290,_7264).

redundant([redundant,_7278,_7307],_7267,_7269) --> 
    prep1(for,_7278,_7267,_7295),
    w(noun(time,sin,def,n),_7307,_7295,_7269).

redundant([redundant,_7287,_7316,_7340,!,_7374],_7276,_7278) --> 
    prep1(from,_7287,_7276,_7304),
    a(_7316,_7304,_7331),
    w(noun(place,sin,u,n),_7340,_7331,_7357),
    !,
    accept(_7374,_7357,_7278).

redundant([redundant,_7276,_7305],_7265,_7267) --> 
    prep1(on,_7276,_7265,_7293),
    w(adj2(new,nil),_7305,_7293,_7267).

redundant([redundant,_7283,lit(en),_7323],_7272,_7274) --> 
    prep1(on,_7283,_7272,_7300),
    cc(en,_7300,_7322),
    w(noun(time_count,sin,u,n),_7323,_7322,_7274).

redundant([redundant,_7271,_7300],_7260,_7262) --> 
    prep1(to,_7271,_7260,_7288),
    slutt(_7300,_7288,_7262).

redundant([redundant,_7273,lit(sammen)],_7262,_7264) --> 
    prep1(to,_7273,_7262,_7290),
    cc(sammen,_7290,_7264).

redundant([redundant,_7288,_7317,_7346],_7277,_7279) --> 
    prep1(to,_7288,_7277,_7305),
    w(adj2(ordinary,nil),_7317,_7305,_7334),
    not_look_ahead(w(noun(time,_7251,_7252,_7253)),_7346,_7334,_7279).

redundant([redundant,_7266],_7255,_7257) --> 
    always(_7266,_7255,_7257).

redundant([redundant,_7266],_7255,_7257) --> 
    aspossible(_7266,_7255,_7257).

redundant([redundant,lit('altså'),_7288],_7266,_7268) --> 
    cc('altså',_7266,_7287),
    not_look_ahead_lit([at,'å'],_7288,_7287,_7268).

redundant([redundant,lit(bare)],_7257,_7259) --> 
    cc(bare,_7257,_7259).

redundant([redundant,lit(da),_7282],_7260,_7262) --> 
    cc(da,_7260,_7281),
    not_look_ahead_np(_7282,_7281,_7262).

redundant([redundant,lit(den),lit(gang)],_7262,_7264) --> 
    cc(den,_7262,_7283),
    cc(gang,_7283,_7264).

redundant([redundant,lit(derfra)],_7257,_7259) --> 
    cc(derfra,_7257,_7259).

redundant([redundant,lit(derfor)],_7257,_7259) --> 
    cc(derfor,_7257,_7259).

redundant([redundant,lit(alene)],_7257,_7259) --> 
    cc(alene,_7257,_7259).

redundant([redundant,lit(bort)],_7257,_7259) --> 
    cc(bort,_7257,_7259).

redundant([redundant,lit(dessverre)],_7257,_7259) --> 
    cc(dessverre,_7257,_7259).

redundant([redundant,lit(egentlig)],_7257,_7259) --> 
    cc(egentlig,_7257,_7259).

redundant([redundant,lit(ellers)],_7257,_7259) --> 
    cc(ellers,_7257,_7259).

redundant([redundant,lit(engang)],_7257,_7259) --> 
    cc(engang,_7257,_7259).

redundant([redundant,lit(enklest),lit(mulig)],_7262,_7264) --> 
    cc(enklest,_7262,_7283),
    cc(mulig,_7283,_7264).

redundant([redundant,lit(enklest)],_7257,_7259) --> 
    cc(enklest,_7257,_7259).

redundant([redundant,lit(ergo)],_7257,_7259) --> 
    cc(ergo,_7257,_7259).

redundant([redundant,lit(farefritt)],_7257,_7259) --> 
    cc(farefritt,_7257,_7259).

redundant([redundant,lit(faktisk)],_7257,_7259) --> 
    cc(faktisk,_7257,_7259).

redundant([redundant,lit('forøvrig')],_7257,_7259) --> 
    cc('forøvrig',_7257,_7259).

redundant([redundant,lit('forøvrig')],_7257,_7259) --> 
    cc('forøvrig',_7257,_7259).

redundant([redundant,lit(fram)],_7257,_7259) --> 
    cc(fram,_7257,_7259).

redundant([redundant,lit(gjerne)],_7257,_7259) --> 
    cc(gjerne,_7257,_7259).

redundant([redundant,lit(heller)],_7257,_7259) --> 
    cc(heller,_7257,_7259).

redundant([redundant,lit(helst)],_7257,_7259) --> 
    cc(helst,_7257,_7259).

redundant([redundant,lit(heldigvis)],_7257,_7259) --> 
    cc(heldigvis,_7257,_7259).

redundant([redundant,lit(herfra)],_7257,_7259) --> 
    cc(herfra,_7257,_7259).

redundant([redundant,lit(jo)],_7257,_7259) --> 
    cc(jo,_7257,_7259).

redundant([redundant,lit(jovisst)],_7257,_7259) --> 
    cc(jovisst,_7257,_7259).

redundant([redundant,lit(ikke),lit(sant)],_7262,_7264) --> 
    cc(ikke,_7262,_7283),
    cc(sant,_7283,_7264).

redundant([redundant,lit(ihvertfall)],_7257,_7259) --> 
    cc(ihvertfall,_7257,_7259).

redundant([redundant,lit(imens)],_7257,_7259) --> 
    cc(imens,_7257,_7259).

redundant([redundant,lit(inne)],_7257,_7259) --> 
    cc(inne,_7257,_7259).

redundant([redundant,lit(kanskje)],_7257,_7259) --> 
    cc(kanskje,_7257,_7259).

redundant([redundant,lit(langt),lit(bort)],_7262,_7264) --> 
    cc(langt,_7262,_7283),
    cc(bort,_7283,_7264).

redundant([redundant,lit(lenge)],_7257,_7259) --> 
    cc(lenge,_7257,_7259).

redundant([redundant,lit(likevel)],_7257,_7259) --> 
    cc(likevel,_7257,_7259).

redundant([redundant,lit(minst)],_7257,_7259) --> 
    cc(minst,_7257,_7259).

redundant([redundant,lit(mon),_7288],_7266,_7268) --> 
    cc(mon,_7266,_7287),
    w(verb(believe,imp,fin),_7288,_7287,_7268).

redundant([redundant,lit(normalt)],_7257,_7259) --> 
    cc(normalt,_7257,_7259).

redundant([redundant,lit('når'),lit(som),lit(helst)],_7267,_7269) --> 
    cc('når',_7267,_7288),
    cc(som,_7288,_7299),
    cc(helst,_7299,_7269).

redundant([redundant,lit('også')],_7257,_7259) --> 
    cc('også',_7257,_7259).

redundant([redundant,_7266],_7255,_7257) --> 
    sometimes(_7266,_7255,_7257).

redundant([redundant,lit(om),_7289],_7267,_7269) --> 
    cc(om,_7267,_7288),
    w(noun(time_count,sin,def,n),_7289,_7288,_7269).

redundant([redundant,lit(ad),_7289],_7267,_7269) --> 
    cc(ad,_7267,_7288),
    w(noun(time_count,sin,def,n),_7289,_7288,_7269).

redundant([redundant,lit(sikkert)],_7257,_7259) --> 
    cc(sikkert,_7257,_7259).

redundant([redundant,lit(straks)],_7257,_7259) --> 
    cc(straks,_7257,_7259).

redundant([redundant,lit(selvsagt)],_7257,_7259) --> 
    cc(selvsagt,_7257,_7259).

redundant([redundant,lit(totalt)],_7257,_7259) --> 
    cc(totalt,_7257,_7259).

redundant([redundant,lit(uansett)],_7257,_7259) --> 
    cc(uansett,_7257,_7259).

redundant([redundant,lit(vanligvis)],_7257,_7259) --> 
    cc(vanligvis,_7257,_7259).

redundant([redundant,lit(vel)],_7257,_7259) --> 
    cc(vel,_7257,_7259).

redundant([redundant,lit(videre)],_7257,_7259) --> 
    cc(videre,_7257,_7259).

slutt([slutt,lit(sist)],_7257,_7259) --> 
    cc(sist,_7257,_7259).

slutt([slutt,lit(slutt)],_7257,_7259) --> 
    cc(slutt,_7257,_7259).

please0([please0,_7272,!,_7301],_7261,_7263) --> 
    please(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

please0([please0,lit(bare),!,_7290],_7263,_7265) --> 
    cc(bare,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

please0([please0,[]],_7255,_7255) --> 
    [].

please([please,_7275,_7299,_7323,_7347],_7264,_7266) --> 
    be(_7275,_7264,_7290),
    so(_7299,_7290,_7314),
    good(_7323,_7314,_7338),
    infinitive(_7347,_7338,_7266).

please([please,lit(kan),_7301,_7325,_7349,_7373,lit('å')],_7279,_7281) --> 
    cc(kan,_7279,_7300),
    you(_7301,_7300,_7316),
    be(_7325,_7316,_7340),
    so0(_7349,_7340,_7364),
    w(adj2(good,nil),_7373,_7364,_7390),
    cc('å',_7390,_7281).

slashpoint0([slashpoint0,_7269,!],_7258,_7260) --> 
    slashpoint(_7269,_7258,_7260),
    !.

slashpoint0([slashpoint0,[]],_7255,_7255) --> 
    [].

slashpoint([slashpoint,lit(ende),!],_7260,_7262) --> 
    cc(ende,_7260,_7262),
    !.

slashpoint([slashpoint,lit(/),!],_7260,_7262) --> 
    cc(/,_7260,_7262),
    !.

slashpoint([slashpoint,lit(i),_7292,!],_7270,_7272) --> 
    cc(i,_7270,_7291),
    look_ahead(w(nb(_7252,_7253)),_7292,_7291,_7272),
    !.

slashpoint([slashpoint,lit('.'),lit(i),_7308,!],_7275,_7277) --> 
    cc('.',_7275,_7296),
    cc(i,_7296,_7307),
    look_ahead(w(nb(_7257,_7258)),_7308,_7307,_7277),
    !.

slashpoint([slashpoint,lit('.'),!],_7260,_7262) --> 
    cc('.',_7260,_7262),
    !.

slash([slash,lit(/)],_7257,_7259) --> 
    cc(/,_7257,_7259).

dashpoint0([dashpoint0,_7269,!],_7258,_7260) --> 
    dashpoint(_7269,_7258,_7260),
    !.

dashpoint0([dashpoint0,[]],_7255,_7255) --> 
    [].

dashpoint([dashpoint,lit(-)],_7257,_7259) --> 
    cc(-,_7257,_7259).

dashpoint([dashpoint,lit('.')],_7257,_7259) --> 
    cc('.',_7257,_7259).

point0([point0,_7272,!,_7301],_7261,_7263) --> 
    point(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

point0([point0,[]],_7255,_7255) --> 
    [].

pointNO([pointNO,_7272,!,_7301],_7261,_7263) --> 
    point(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

pointNO([pointNO,{}],_7260,_7260) --> 
    {user:value(nodotflag,true)}.

point([point,lit('.')],_7257,_7259) --> 
    cc('.',_7257,_7259).

itrailer([itrailer,lit(n)],_7257,_7259) --> 
    cc(n,_7257,_7259).

itrailer([itrailer,_7275,lit('når')],_7264,_7266) --> 
    not_look_ahead([n],_7275,_7264,_7292),
    cc('når',_7292,_7266).

itrailer([itrailer,_7278,_7307],_7267,_7269) --> 
    not_look_ahead([n],_7278,_7267,_7295),
    w(adj2(next,nil),_7307,_7295,_7269).

itrailer([itrailer,lit(takk)],_7257,_7259) --> 
    cc(takk,_7257,_7259).

qtrailer0([qtrailer0,lit(?),_7285,!],_7263,_7265) --> 
    cc(?,_7263,_7284),
    qtrailer(_7285,_7284,_7265),
    !.

qtrailer0([qtrailer0,lit('.'),_7285,!],_7263,_7265) --> 
    cc('.',_7263,_7284),
    qtrailer(_7285,_7284,_7265),
    !.

qtrailer0([qtrailer0,lit(a),_7285,!],_7263,_7265) --> 
    cc(a,_7263,_7284),
    qtrailer(_7285,_7284,_7265),
    !.

qtrailer0([qtrailer0,_7269,!],_7258,_7260) --> 
    qtrailer(_7269,_7258,_7260),
    !.

qtrailer0([qtrailer0,[]],_7255,_7255) --> 
    [].

qtrailer([qtrailer,lit(a)],_7257,_7259) --> 
    cc(a,_7257,_7259).

qtrailer([qtrailer,lit(takk)],_7257,_7259) --> 
    cc(takk,_7257,_7259).

qtrailer([qtrailer,_7274,lit(du),_7309],_7263,_7265) --> 
    be(_7274,_7263,_7289),
    cc(du,_7289,_7308),
    good(_7309,_7308,_7265).

qtrailer([qtrailer,lit(ca)],_7257,_7259) --> 
    cc(ca,_7257,_7259).

qtrailer([qtrailer,lit(da)],_7257,_7259) --> 
    cc(da,_7257,_7259).

qtrailer([qtrailer,lit(eller),lit(ikke)],_7262,_7264) --> 
    cc(eller,_7262,_7283),
    cc(ikke,_7283,_7264).

qtrailer([qtrailer,lit(eller)],_7257,_7259) --> 
    cc(eller,_7257,_7259).

qtrailer([qtrailer,_7275,!],_7264,_7266) --> 
    w(name(hal,_7246,_7247),_7275,_7264,_7266),
    !.

qtrailer([qtrailer,_7286,_7330,!],_7275,_7277) --> 
    optional(w(adj2(great,nil)),_7286,_7275,_7318),
    w(noun(oracle,sin,u,n),_7330,_7318,_7277),
    !.

qtrailer([qtrailer,_7290,{},!],_7279,_7281) --> 
    w(noun(_7248,sin,u,n),_7290,_7279,_7281),
    {user:testmember(_7248,[program,oracle,boss])},
    !.

qtrailer([qtrailer,lit(og)],_7257,_7259) --> 
    cc(og,_7257,_7259).

qtrailer([qtrailer,lit(og),lit('når')],_7262,_7264) --> 
    cc(og,_7262,_7283),
    cc('når',_7283,_7264).

qtrailer([qtrailer,lit(lenger),!],_7260,_7262) --> 
    cc(lenger,_7260,_7262),
    !.

qtrailer([qtrailer,lit(lengre),!],_7260,_7262) --> 
    cc(lengre,_7260,_7262),
    !.

qtrailer([qtrailer,lit('så'),_7304,lit(du),_7344,!],_7282,_7284) --> 
    cc('så',_7282,_7303),
    w(verb(be,_7257,_7258),_7304,_7303,_7321),
    cc(du,_7321,_7343),
    w(adj2(nice,nil),_7344,_7343,_7284),
    !.

qtrailer([qtrailer,_7272],_7261,_7263) --> 
    w(verb(believe,inf,fin),_7272,_7261,_7263).

qtrailer([qtrailer,_7277,lit(du)],_7266,_7268) --> 
    w(verb(believe,pres,fin),_7277,_7266,_7294),
    cc(du,_7294,_7268).

qtrailer([qtrailer,lit('ø')],_7257,_7259) --> 
    cc('ø',_7257,_7259).

qtrailer([qtrailer,_7275,lit('når')],_7264,_7266) --> 
    not_look_ahead([n],_7275,_7264,_7292),
    cc('når',_7292,_7266).

qtrailer([qtrailer,lit(din),_7299,_7343],_7277,_7279) --> 
    cc(din,_7277,_7298),
    optional(w(adj2(_7259,nil)),_7299,_7298,_7331),
    w(noun(_7248,sin,_7250,_7251),_7343,_7331,_7279).

qtrailer([qtrailer,_7287,{},!],_7276,_7278) --> 
    w(name(_7248,_7249,_7250),_7287,_7276,_7278),
    {user:testmember(_7250,[man,woman])},
    !.

qtrailer([qtrailer,lit(uansett)],_7257,_7259) --> 
    cc(uansett,_7257,_7259).

ctrailer0([ctrailer0,_7269,!],_7258,_7260) --> 
    ctrailer(_7269,_7258,_7260),
    !.

ctrailer0([ctrailer0,[]],_7255,_7255) --> 
    [].

ctrailer([ctrailer,_7266],_7255,_7257) --> 
    please(_7266,_7255,_7257).

ctrailer([ctrailer,lit(takk)],_7257,_7259) --> 
    cc(takk,_7257,_7259).

ctrailer([ctrailer,_7285,lit(du),_7325],_7274,_7276) --> 
    w(verb(be,pres,fin),_7285,_7274,_7302),
    cc(du,_7302,_7324),
    w(adj2(nice,nil),_7325,_7324,_7276).

ctrailer([ctrailer,lit(da)],_7257,_7259) --> 
    cc(da,_7257,_7259).

ctrailer([ctrailer,lit(din),_7299,_7343],_7277,_7279) --> 
    cc(din,_7277,_7298),
    optional(w(adj2(_7259,nil)),_7299,_7298,_7331),
    w(noun(_7248,sin,_7250,_7251),_7343,_7331,_7279).

dtrailer0([dtrailer0,{},_7289,!],_7268,_7270) --> 
    {user:(\+value(dialog,1))},
    dtrailer(_7289,_7268,_7270),
    !.

dtrailer0([dtrailer0,[]],_7255,_7255) --> 
    [].

dtrailer([dtrailer,_7272],_7261,_7263) --> 
    w(name(tore,n,firstname),_7272,_7261,_7263).

dtrailer([dtrailer,_7277,lit(jeg)],_7266,_7268) --> 
    w(verb(think,_7248,fin),_7277,_7266,_7294),
    cc(jeg,_7294,_7268).

dtrailer([dtrailer,_7277,lit(jeg)],_7266,_7268) --> 
    w(verb(mean,_7248,fin),_7277,_7266,_7294),
    cc(jeg,_7294,_7268).

dtrailer([dtrailer,_7272],_7261,_7263) --> 
    w(name(bustuc,_7243,_7244),_7272,_7261,_7263).

dtrailer([dtrailer,lit(ass)],_7257,_7259) --> 
    cc(ass,_7257,_7259).

dtrailer([dtrailer,lit(da)],_7257,_7259) --> 
    cc(da,_7257,_7259).

dtrailer([dtrailer,lit(din),_7299,_7343],_7277,_7279) --> 
    cc(din,_7277,_7298),
    optional(w(adj2(_7259,nil)),_7299,_7298,_7331),
    w(noun(fool,sin,u,n),_7343,_7331,_7279).

dtrailer([dtrailer,lit(du)],_7257,_7259) --> 
    cc(du,_7257,_7259).

dtrailer([dtrailer,lit(eller),lit(hva)],_7262,_7264) --> 
    cc(eller,_7262,_7283),
    cc(hva,_7283,_7264).

dtrailer([dtrailer,lit(eller)],_7257,_7259) --> 
    cc(eller,_7257,_7259).

dtrailer([dtrailer,lit(gitt)],_7257,_7259) --> 
    cc(gitt,_7257,_7259).

dtrailer([dtrailer,lit(hvordan)],_7257,_7259) --> 
    cc(hvordan,_7257,_7259).

dtrailer([dtrailer,lit(hei)],_7257,_7259) --> 
    cc(hei,_7257,_7259).

dtrailer([dtrailer,lit(ja)],_7257,_7259) --> 
    cc(ja,_7257,_7259).

dtrailer([dtrailer,lit(jeg)],_7257,_7259) --> 
    cc(jeg,_7257,_7259).

dtrailer([dtrailer,lit(men),lit('når')],_7262,_7264) --> 
    cc(men,_7262,_7283),
    cc('når',_7283,_7264).

dtrailer([dtrailer,lit(ok)],_7257,_7259) --> 
    cc(ok,_7257,_7259).

dtrailer([dtrailer,lit('sjø')],_7257,_7259) --> 
    cc('sjø',_7257,_7259).

dtrailer([dtrailer,lit(?),lit(takk)],_7262,_7264) --> 
    cc(?,_7262,_7283),
    cc(takk,_7283,_7264).

dtrailer([dtrailer,_7278,lit(hilsen),_7333],_7267,_7269) --> 
    optional([med],_7278,_7267,_7310),
    cc(hilsen,_7310,_7332),
    skip_rest(_7333,_7332,_7269).

posspron(self,[posspron,_7276,_7300],_7262,_7264) --> 
    my(_7276,_7262,_7291),
    own0(_7300,_7291,_7264).

posspron(man,[posspron,lit(hans),_7289],_7264,_7266) --> 
    cc(hans,_7264,_7288),
    own0(_7289,_7288,_7266).

posspron(woman,[posspron,lit(hennes),_7289],_7264,_7266) --> 
    cc(hennes,_7264,_7288),
    own0(_7289,_7288,_7266).

posspron(savant,[posspron,_7273],_7259,_7261) --> 
    your(_7273,_7259,_7261).

posspron(person,[posspron,_7276,_7300],_7262,_7264) --> 
    their(_7276,_7262,_7291),
    own0(_7300,_7291,_7264).

posspron(thing,[posspron,_7273],_7259,_7261) --> 
    sin(_7273,_7259,_7261).

previous([previous,_7271],_7260,_7262) --> 
    w(adj2(previous,nil),_7271,_7260,_7262).

thereafter([thereafter,_7269,_7293],_7258,_7260) --> 
    andor0(_7269,_7258,_7284),
    later(_7293,_7284,_7260).

thereafter([thereafter,_7273,lit(det)],_7262,_7264) --> 
    prep1(after,_7273,_7262,_7290),
    cc(det,_7290,_7264).

thereafter([thereafter,_7273,lit(dette)],_7262,_7264) --> 
    prep1(after,_7273,_7262,_7290),
    cc(dette,_7290,_7264).

thereafter([thereafter,_7273,lit(der)],_7262,_7264) --> 
    prep1(after,_7273,_7262,_7290),
    cc(der,_7290,_7264).

thereafter([thereafter,lit(nest),_7289,lit(der)],_7267,_7269) --> 
    cc(nest,_7267,_7288),
    prep1(after,_7289,_7288,_7306),
    cc(der,_7306,_7269).

thereafter([thereafter,_7273,lit(hvert)],_7262,_7264) --> 
    prep1(after,_7273,_7262,_7290),
    cc(hvert,_7290,_7264).

beforethat([beforethat,lit('derfør')],_7257,_7259) --> 
    cc('derfør',_7257,_7259).

beforethat([beforethat,_7269,_7293],_7258,_7260) --> 
    andor0(_7269,_7258,_7284),
    earlier(_7293,_7284,_7260).

beforethat([beforethat,_7273,lit(det)],_7262,_7264) --> 
    prep1(before,_7273,_7262,_7290),
    cc(det,_7290,_7264).

beforethat([beforethat,_7273,lit(dette)],_7262,_7264) --> 
    prep1(after,_7273,_7262,_7290),
    cc(dette,_7290,_7264).

beforethat([beforethat,_7273,lit(der)],_7262,_7264) --> 
    prep1(after,_7273,_7262,_7290),
    cc(der,_7290,_7264).

beforethat([beforethat,_7273,lit(dette)],_7262,_7264) --> 
    prep1(before,_7273,_7262,_7290),
    cc(dette,_7290,_7264).

beforethat([beforethat,lit(nest),_7289,lit(der)],_7267,_7269) --> 
    cc(nest,_7267,_7288),
    prep1(before,_7289,_7288,_7306),
    cc(der,_7306,_7269).

preperly([preperly,lit(en),lit(del)],_7262,_7264) --> 
    cc(en,_7262,_7283),
    cc(del,_7283,_7264).

preperly([preperly,lit(enda)],_7257,_7259) --> 
    cc(enda,_7257,_7259).

preperly([preperly,lit(ekte)],_7257,_7259) --> 
    cc(ekte,_7257,_7259).

preperly([preperly,lit(litt)],_7257,_7259) --> 
    cc(litt,_7257,_7259).

preperly([preperly,lit(noe)],_7257,_7259) --> 
    cc(noe,_7257,_7259).

preperly([preperly,lit(reellt)],_7257,_7259) --> 
    cc(reellt,_7257,_7259).

preperly([preperly,lit(strengt)],_7257,_7259) --> 
    cc(strengt,_7257,_7259).

preperly([preperly,lit(strikt)],_7257,_7259) --> 
    cc(strikt,_7257,_7259).

preperly([preperly,lit(virkelig)],_7257,_7259) --> 
    cc(virkelig,_7257,_7259).

prep2(after,[prep2,lit(avgang),_7295],_7270,_7272) --> 
    cc(avgang,_7270,_7294),
    not_look_ahead(w(prep(_7249)),_7295,_7294,_7272).

prep2(before,[prep2,lit(ankomst),_7295],_7270,_7272) --> 
    cc(ankomst,_7270,_7294),
    not_look_ahead(w(prep(_7249)),_7295,_7294,_7272).

prep2(after,[prep2,_7278,_7302],_7264,_7266) --> 
    preperly(_7278,_7264,_7293),
    prep1(after,_7302,_7293,_7266).

prep2(after,[prep2,_7286,_7310,lit(enn)],_7272,_7274) --> 
    preperly(_7286,_7272,_7301),
    w(adj2(later,nil),_7310,_7301,_7327),
    cc(enn,_7327,_7274).

prep2(before,[prep2,_7278,_7302],_7264,_7266) --> 
    preperly(_7278,_7264,_7293),
    prep1(before,_7302,_7293,_7266).

prep2(before,[prep2,_7286,_7310,lit(enn)],_7272,_7274) --> 
    preperly(_7286,_7272,_7301),
    w(adj2(earlier,nil),_7310,_7301,_7327),
    cc(enn,_7327,_7274).

prep2(according_to,[prep2,_7280,lit('følge')],_7266,_7268) --> 
    prep1(in,_7280,_7266,_7297),
    cc('følge',_7297,_7268).

prep2(after,[prep2,_7278,_7302],_7264,_7266) --> 
    clock(_7278,_7264,_7293),
    prep1(after,_7302,_7293,_7266).

prep2(after,[prep2,_7278,_7302],_7264,_7266) --> 
    around1(_7278,_7264,_7293),
    prep1(after,_7302,_7293,_7266).

prep2(after,[prep2,lit(ca),_7291],_7266,_7268) --> 
    cc(ca,_7266,_7290),
    prep1(after,_7291,_7290,_7268).

prep2(after,[prep2,_7278,_7307],_7264,_7266) --> 
    prep1(after,_7278,_7264,_7295),
    around1(_7307,_7295,_7266).

prep2(after,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(from,_7280,_7266,_7297),
    prep1(after,_7309,_7297,_7268).

prep2(after,[prep2,_7287,_7316,_7345],_7273,_7275) --> 
    prep1(to,_7287,_7273,_7304),
    not_look_ahead([e],_7316,_7304,_7333),
    prep1(after,_7345,_7333,_7275).

prep2(after,[prep2,_7285,lit(og),_7325],_7271,_7273) --> 
    prep1(from,_7285,_7271,_7302),
    cc(og,_7302,_7324),
    prep1(with,_7325,_7324,_7273).

prep2(after,[prep2,lit(like),_7291],_7266,_7268) --> 
    cc(like,_7266,_7290),
    prep1(after,_7291,_7290,_7268).

prep2(after,[prep2,_7278,_7302],_7264,_7266) --> 
    not(_7278,_7264,_7293),
    prep(before,_7302,_7293,_7266).

prep2(after,[prep2,lit(senere),lit(enn)],_7266,_7268) --> 
    cc(senere,_7266,_7290),
    cc(enn,_7290,_7268).

prep2(after,[prep2,lit(resten),_7291],_7266,_7268) --> 
    cc(resten,_7266,_7290),
    prep1(off,_7291,_7290,_7268).

prep2(around,[prep2,_7276,_7300],_7262,_7264) --> 
    around1(_7276,_7262,_7291),
    around0(_7300,_7291,_7264).

prep2(at,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(in,_7280,_7266,_7297),
    prep1(at,_7309,_7297,_7268).

prep2(at,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(on,_7280,_7266,_7297),
    prep1(at,_7309,_7297,_7268).

prep2(at,[prep2,_7290,_7319,lit(av)],_7276,_7278) --> 
    prep1(at,_7290,_7276,_7307),
    w(noun(side,_7255,_7256,_7257),_7319,_7307,_7336),
    cc(av,_7336,_7278).

prep2(before,[prep2,lit(for),_7296],_7271,_7273) --> 
    cc(for,_7271,_7295),
    look_ahead(w(nb(_7249,num)),_7296,_7295,_7273).

prep2(before,[prep2,_7288,_7317,!],_7274,_7276) --> 
    w(noun(arrival,sin,u,n),_7288,_7274,_7305),
    prep1(before,_7317,_7305,_7276),
    !.

prep2(before,[prep2,_7278,_7307],_7264,_7266) --> 
    prep1(before,_7278,_7264,_7295),
    ca(_7307,_7295,_7266).

prep2(before,[prep2,lit(like),_7291],_7266,_7268) --> 
    cc(like,_7266,_7290),
    prep1(before,_7291,_7290,_7268).

prep2(before,[prep2,_7278,_7302],_7264,_7266) --> 
    not(_7278,_7264,_7293),
    prep(after,_7302,_7293,_7266).

prep2(before,[prep2,lit(senest),_7291],_7266,_7268) --> 
    cc(senest,_7266,_7290),
    prep1(before,_7291,_7290,_7268).

prep2(before,[prep2,lit(senest)],_7261,_7263) --> 
    cc(senest,_7261,_7263).

prep2(before,[prep2,_7283,_7312],_7269,_7271) --> 
    w(adj2(present,nil),_7283,_7269,_7300),
    prep1(before,_7312,_7300,_7271).

prep2(before,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(to,_7280,_7266,_7297),
    prep1(before,_7309,_7297,_7268).

prep2(before,[prep2,_7280,lit(ca)],_7266,_7268) --> 
    prep1(to,_7280,_7266,_7297),
    cc(ca,_7297,_7268).

prep2(between,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(from,_7280,_7266,_7297),
    prep1(between,_7309,_7297,_7268).

prep2(between,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(in,_7280,_7266,_7297),
    prep1(between,_7309,_7297,_7268).

prep2(between,[prep2,_7288,_7312,_7341],_7274,_7276) --> 
    a0(_7288,_7274,_7303),
    w(noun(place,_7253,_7254,n),_7312,_7303,_7329),
    prep1(between,_7341,_7329,_7276).

prep2(during,[prep2,_7285,lit('løpet'),lit(av)],_7271,_7273) --> 
    prep1(in,_7285,_7271,_7302),
    cc('løpet',_7302,_7324),
    cc(av,_7324,_7273).

prep2(during2,[prep2,lit(om),_7289],_7264,_7266) --> 
    cc(om,_7264,_7288),
    ca(_7289,_7288,_7266).

prep2(from,[prep2,_7278,_7307],_7264,_7266) --> 
    prep1(from,_7278,_7264,_7295),
    colon0(_7307,_7295,_7266).

prep2(from,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(from,_7280,_7266,_7297),
    prep1(near,_7309,_7297,_7268).

prep2(from,[prep2,_7294,_7323,_7352,!,_7386],_7280,_7282) --> 
    prep1(from,_7294,_7280,_7311),
    w(adj2(up,nil),_7323,_7311,_7340),
    prep1(at,_7352,_7340,_7369),
    !,
    accept(_7386,_7369,_7282).

prep2(from,[prep2,_7286,_7315,!,_7349],_7272,_7274) --> 
    prep1(from,_7286,_7272,_7303),
    prep1(from,_7315,_7303,_7332),
    !,
    accept(_7349,_7332,_7274).

prep2(from,[prep2,lit(med),_7291],_7266,_7268) --> 
    cc(med,_7266,_7290),
    prep1(from,_7291,_7290,_7268).

prep2(from,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(in,_7280,_7266,_7297),
    prep1(from,_7309,_7297,_7268).

prep2(from,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(over,_7280,_7266,_7297),
    prep1(from,_7309,_7297,_7268).

prep2(from,[prep2,lit(ifra)],_7261,_7263) --> 
    cc(ifra,_7261,_7263).

prep2(from,[prep2,lit(inn),_7291],_7266,_7268) --> 
    cc(inn,_7266,_7290),
    prep1(from,_7291,_7290,_7268).

prep2(from,[prep2,lit(ut),_7289],_7264,_7266) --> 
    cc(ut,_7264,_7288),
    offrom(_7289,_7288,_7266).

prep2(from,[prep2,_7290,_7319,_7348],_7276,_7278) --> 
    prep1(with,_7290,_7276,_7307),
    w(noun(start,sin,_7256,_7257),_7319,_7307,_7336),
    prep1(in,_7348,_7336,_7278).

prep2(from,[prep2,_7278,_7302],_7264,_7266) --> 
    umpover(_7278,_7264,_7293),
    prep1(from,_7302,_7293,_7266).

prep2(from,[prep2,_7290,_7319,lit('nærheten'),lit(av)],_7276,_7278) --> 
    prep1(from,_7290,_7276,_7307),
    prep1(in,_7319,_7307,_7336),
    cc('nærheten',_7336,_7358),
    cc(av,_7358,_7278).

prep2(in,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(around,_7280,_7266,_7297),
    prep1(in,_7309,_7297,_7268).

prep2(in,[prep2,lit(inne),_7291],_7266,_7268) --> 
    cc(inne,_7266,_7290),
    prep1(in,_7291,_7290,_7268).

prep2(in,[prep2,lit(nede),_7291],_7266,_7268) --> 
    cc(nede,_7266,_7290),
    prep1(in,_7291,_7290,_7268).

prep2(instead_of,[prep2,lit(i),lit(stedet),lit(for)],_7271,_7273) --> 
    cc(i,_7271,_7295),
    cc(stedet,_7295,_7306),
    cc(for,_7306,_7273).

prep2(near,[prep2,_7281,_7305,_7334],_7267,_7269) --> 
    so0(_7281,_7267,_7296),
    prep1(near,_7305,_7296,_7322),
    to0(_7334,_7322,_7269).

prep2(near,[prep2,_7285,lit('nærheten'),lit(av)],_7271,_7273) --> 
    prep1(in,_7285,_7271,_7302),
    cc('nærheten',_7302,_7324),
    cc(av,_7324,_7273).

prep2(near,[prep2,lit(like),_7291],_7266,_7268) --> 
    cc(like,_7266,_7290),
    prep1(at,_7291,_7290,_7268).

prep2(near,[prep2,_7287,_7311,_7340,_7364],_7273,_7275) --> 
    and0(_7287,_7273,_7302),
    w(adj2(nearest,nil),_7311,_7302,_7328),
    possible0(_7340,_7328,_7355),
    to0(_7364,_7355,_7275).

prep2(near,[prep2,_7283,_7312],_7269,_7271) --> 
    w(adj2(near,nil),_7283,_7269,_7300),
    prep1(at,_7312,_7300,_7271).

prep2(near,[prep2,_7288,lit(eller),_7328],_7274,_7276) --> 
    prep1(to,_7288,_7274,_7305),
    cc(eller,_7305,_7327),
    w(adj2(near,nil),_7328,_7327,_7276).

prep2(near,[prep2,_7288,lit(eller),_7328],_7274,_7276) --> 
    prep1(past,_7288,_7274,_7305),
    cc(eller,_7305,_7327),
    w(adj2(near,nil),_7328,_7327,_7276).

prep2(on,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(in,_7280,_7266,_7297),
    prep1(on,_7309,_7297,_7268).

prep2(on,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(with,_7280,_7266,_7297),
    prep1(on,_7309,_7297,_7268).

prep2(on,[prep2,_7289,lit(midt),_7324,!,_7358],_7275,_7277) --> 
    ca0(_7289,_7275,_7304),
    cc(midt,_7304,_7323),
    prep1(on,_7324,_7323,_7341),
    !,
    accept(_7358,_7341,_7277).

prep2(on,[prep2,lit(nede),_7291],_7266,_7268) --> 
    cc(nede,_7266,_7290),
    prep1(on,_7291,_7290,_7268).

prep2(out_of,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(to,_7280,_7266,_7297),
    prep1(outside,_7309,_7297,_7268).

prep2(outside,[prep2,lit(ikke),_7291],_7266,_7268) --> 
    cc(ikke,_7266,_7290),
    prep1(past,_7291,_7290,_7268).

prep2(outside,[prep2,lit(ikke),_7291],_7266,_7268) --> 
    cc(ikke,_7266,_7290),
    prep1(to,_7291,_7290,_7268).

prep2(over,[prep2,lit(litt),_7291],_7266,_7268) --> 
    cc(litt,_7266,_7290),
    prep1(over,_7291,_7290,_7268).

prep2(over,[prep2,_7280,lit(hvilke)],_7266,_7268) --> 
    prep1(over,_7280,_7266,_7297),
    cc(hvilke,_7297,_7268).

prep2(past,[prep2,lit(og),lit(ned)],_7266,_7268) --> 
    cc(og,_7266,_7290),
    cc(ned,_7290,_7268).

prep2(past,[prep2,lit(og),_7291],_7266,_7268) --> 
    cc(og,_7266,_7290),
    prep1(past,_7291,_7290,_7268).

prep2(past,[prep2,lit(ned)],_7261,_7263) --> 
    cc(ned,_7261,_7263).

prep2(past,[prep2,_7295,lit(/),_7335,lit('nærheten'),lit(av)],_7281,_7283) --> 
    prep1(past,_7295,_7281,_7312),
    cc(/,_7312,_7334),
    prep1(in,_7335,_7334,_7352),
    cc('nærheten',_7352,_7374),
    cc(av,_7374,_7283).

prep2(past,[prep2,_7295,lit(eller),_7335,lit('nærheten'),lit(av)],_7281,_7283) --> 
    prep1(past,_7295,_7281,_7312),
    cc(eller,_7312,_7334),
    prep1(in,_7335,_7334,_7352),
    cc('nærheten',_7352,_7374),
    cc(av,_7374,_7283).

prep2(past,[prep2,_7291,lit(/),_7331,!,_7365],_7277,_7279) --> 
    prep1(to,_7291,_7277,_7308),
    cc(/,_7308,_7330),
    prep1(from,_7331,_7330,_7348),
    !,
    accept(_7365,_7348,_7279).

prep2(past,[prep2,_7289,_7318,_7342,!,_7376],_7275,_7277) --> 
    prep1(to,_7289,_7275,_7306),
    and0(_7318,_7306,_7333),
    prep1(from,_7342,_7333,_7359),
    !,
    accept(_7376,_7359,_7277).

prep2(past,[prep2,_7289,_7318,_7342,!,_7376],_7275,_7277) --> 
    prep1(from,_7289,_7275,_7306),
    and1(_7318,_7306,_7333),
    prep1(to,_7342,_7333,_7359),
    !,
    accept(_7376,_7359,_7277).

prep2(past,[prep2,_7285,_7314],_7271,_7273) --> 
    prep1(with,_7285,_7271,_7302),
    w(noun(departure,_7248,_7249,_7250),_7314,_7302,_7273).

prep2(past,[prep2,_7285,lit(/),_7325],_7271,_7273) --> 
    prep1(past,_7285,_7271,_7302),
    cc(/,_7302,_7324),
    prep1(past,_7325,_7324,_7273).

prep2(to,[prep2,_7278,_7307],_7264,_7266) --> 
    prep1(to,_7278,_7264,_7295),
    colon0(_7307,_7295,_7266).

prep2(to,[prep2,_7286,_7315,!,_7349],_7272,_7274) --> 
    prep1(to,_7286,_7272,_7303),
    prep1(to,_7315,_7303,_7332),
    !,
    accept(_7349,_7332,_7274).

prep2(to,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(to,_7280,_7266,_7297),
    prep1(near,_7309,_7297,_7268).

prep2(to,[prep2,_7290,_7319,_7348],_7276,_7278) --> 
    prep1(in,_7290,_7276,_7307),
    w(noun(connection,_7255,u,n),_7319,_7307,_7336),
    prep1(with,_7348,_7336,_7278).

prep2(to,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(over,_7280,_7266,_7297),
    prep1(to,_7309,_7297,_7268).

prep2(to,[prep2,_7285,_7314],_7271,_7273) --> 
    prep1(with,_7285,_7271,_7302),
    w(noun(arrival,_7248,_7249,_7250),_7314,_7302,_7273).

prep2(to,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(with,_7280,_7266,_7297),
    prep1(to,_7309,_7297,_7268).

prep2(to,[prep2,_7278,_7302],_7264,_7266) --> 
    andsoon(_7278,_7264,_7293),
    prep1(to,_7302,_7293,_7266).

prep2(to,[prep2,lit(hjem),_7291],_7266,_7268) --> 
    cc(hjem,_7266,_7290),
    prep1(to,_7291,_7290,_7268).

prep2(to,[prep2,lit(inn),_7291],_7266,_7268) --> 
    cc(inn,_7266,_7290),
    prep1(to,_7291,_7290,_7268).

prep2(to,[prep2,lit(ned),_7291],_7266,_7268) --> 
    cc(ned,_7266,_7290),
    prep1(to,_7291,_7290,_7268).

prep2(to,[prep2,lit(opp),_7291],_7266,_7268) --> 
    cc(opp,_7266,_7290),
    prep1(to,_7291,_7290,_7268).

prep2(to,[prep2,lit(tur),lit(retur)],_7266,_7268) --> 
    cc(tur,_7266,_7290),
    cc(retur,_7290,_7268).

prep2(to,[prep2,_7278,_7302],_7264,_7266) --> 
    umpover(_7278,_7264,_7293),
    prep1(to,_7302,_7293,_7266).

prep2(towards,[prep2,lit(inn),_7291],_7266,_7268) --> 
    cc(inn,_7266,_7290),
    prep1(towards,_7291,_7290,_7268).

prep2(towards,[prep2,lit(ut),_7291],_7266,_7268) --> 
    cc(ut,_7266,_7290),
    prep1(towards,_7291,_7290,_7268).

prep2(towards,[prep2,lit(ned),_7291],_7266,_7268) --> 
    cc(ned,_7266,_7290),
    prep1(towards,_7291,_7290,_7268).

prep2(towards,[prep2,_7278,_7302],_7264,_7266) --> 
    umpover(_7278,_7264,_7293),
    prep1(towards,_7302,_7293,_7266).

prep2(until,[prep2,_7273],_7259,_7261) --> 
    until(_7273,_7259,_7261).

prep2(with,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(with,_7280,_7266,_7297),
    prep1(on,_7309,_7297,_7268).

prep2(with,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(with,_7280,_7266,_7297),
    prep1(in,_7309,_7297,_7268).

prep2(with,[prep2,_7281,lit(bruk),_7316],_7267,_7269) --> 
    by(_7281,_7267,_7296),
    cc(bruk,_7296,_7315),
    of(_7316,_7315,_7269).

prep2(within,[prep2,_7280,_7309],_7266,_7268) --> 
    prep1(on,_7280,_7266,_7297),
    prep1(under,_7309,_7297,_7268).

prep2(without,[prep2,lit(fri),lit(for)],_7266,_7268) --> 
    cc(fri,_7266,_7290),
    cc(for,_7290,_7268).

umpover([umpover,lit(opp),_7284],_7262,_7264) --> 
    cc(opp,_7262,_7283),
    prep1(over,_7284,_7283,_7264).

umpover([umpover,lit(bort)],_7257,_7259) --> 
    cc(bort,_7257,_7259).

umpover([umpover,_7268],_7257,_7259) --> 
    prep1(over,_7268,_7257,_7259).

umpover([umpover,lit(bortover)],_7257,_7259) --> 
    cc(bortover,_7257,_7259).

umpover([umpover,lit(utover)],_7257,_7259) --> 
    cc(utover,_7257,_7259).

umpover([umpover,lit(innover)],_7257,_7259) --> 
    cc(innover,_7257,_7259).

umpover([umpover,lit(oppover)],_7257,_7259) --> 
    cc(oppover,_7257,_7259).

umpover([umpover,lit(nedover)],_7257,_7259) --> 
    cc(nedover,_7257,_7259).

umpover([umpover,lit(hitover)],_7257,_7259) --> 
    cc(hitover,_7257,_7259).

umpover([umpover,_7278,_7307],_7267,_7269) --> 
    prep1(on,_7278,_7267,_7295),
    w(noun(route,sin,_7247,n),_7307,_7295,_7269).

umpover([umpover,_7278,_7307],_7267,_7269) --> 
    prep1(on,_7278,_7267,_7295),
    w(noun(direction,sin,_7247,n),_7307,_7295,_7269).

pronoun1(_7240,[pronoun1,lit(de),!,_7297],_7267,_7269) --> 
    cc(de,_7267,_7291),
    !,
    reject(_7297,_7291,_7269).

pronoun1(_7240,[pronoun1,lit(en),!,_7297],_7267,_7269) --> 
    cc(en,_7267,_7291),
    !,
    reject(_7297,_7291,_7269).

pronoun1(_7240,[pronoun1,_7275],_7261,_7263) --> 
    pronoun(_7240,_7275,_7261,_7263).

pronoun(thing,[pronoun,_7288,_7317,!,_7346],_7274,_7276) --> 
    one_of_lit([noe,det],_7288,_7274,_7305),
    not_look_ahead_np(_7317,_7305,_7332),
    !,
    accept(_7346,_7332,_7276).

pronoun(thing,[pronoun,lit(det),_7317,_7341,_7370,!,_7404],_7292,_7294) --> 
    cc(det,_7292,_7316),
    look_ahead_vp(_7317,_7316,_7332),
    not_look_ahead(w(adj2(_7263,_7264)),_7341,_7332,_7358),
    not_look_ahead(w(noun(_7270,_7271,_7272,_7273)),_7370,_7358,_7387),
    !,
    accept(_7404,_7387,_7294).

pronoun(agent,[pronoun,lit(man)],_7261,_7263) --> 
    cc(man,_7261,_7263).

pronoun(self,[pronoun,lit(jeg),_7304,_7333],_7279,_7281) --> 
    cc(jeg,_7279,_7303),
    not_look_ahead(['.'],_7304,_7303,_7321),
    not_look_ahead(w(name(_7252,_7253,_7254)),_7333,_7321,_7281).

pronoun(self,[pronoun,lit(meg)],_7261,_7263) --> 
    cc(meg,_7261,_7263).

pronoun(vehicle,[pronoun,lit(den),_7297,{}],_7272,_7274) --> 
    cc(den,_7272,_7296),
    not_look_ahead_np(_7297,_7296,_7274),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(de),_7297,{}],_7272,_7274) --> 
    cc(de,_7272,_7296),
    not_look_ahead_np(_7297,_7296,_7274),
    {user:value(busflag,true)}.

pronoun(thing,[pronoun,lit(_7250),{},_7322,!],_7287,_7289) --> 
    cc(_7250,_7287,_7311),
    {user:testmember(_7250,[den,det,en,et])},
    look_ahead([som],_7322,_7311,_7289),
    !.

pronoun(_7240,[pronoun,lit(_7254),{},_7317],_7282,_7284) --> 
    cc(_7254,_7282,_7306),
    {dict_n:pronoun(_7254,_7240)},
    not_look_ahead(w(nb(_7252,_7253)),_7317,_7306,_7284).

pronoun(thing,[pronoun,lit(dette),_7314,_7343,!,_7377],_7289,_7291) --> 
    cc(dette,_7289,_7313),
    not_look_ahead(w(adj2(_7260,_7261)),_7314,_7313,_7331),
    not_look_ahead(w(noun(_7267,_7268,_7269,_7270)),_7343,_7331,_7360),
    !,
    accept(_7377,_7360,_7291).

pronoun(thing,[pronoun,lit(denne),_7295,!,_7324],_7270,_7272) --> 
    cc(denne,_7270,_7294),
    not_look_ahead_np(_7295,_7294,_7310),
    !,
    accept(_7324,_7310,_7272).

pronoun(agent,[pronoun,lit(vi)],_7261,_7263) --> 
    cc(vi,_7261,_7263).

pronoun(savant,[pronoun,lit(du)],_7261,_7263) --> 
    cc(du,_7261,_7263).

pronoun(agent,[pronoun,lit(dere)],_7261,_7263) --> 
    cc(dere,_7261,_7263).

quant_pron(some,person,[quant_pron,lit(en),_7306,!],_7278,_7280) --> 
    cc(en,_7278,_7305),
    look_ahead(w(verb(_7255,_7256,_7257)),_7306,_7305,_7280),
    !.

quant_pron(some,thing,[quant_pron,lit(mye),_7298,!],_7270,_7272) --> 
    cc(mye,_7270,_7297),
    not_look_ahead_np(_7298,_7297,_7272),
    !.

quant_pron(every,person,[quant_pron,_7291,lit(alle),_7331],_7274,_7276) --> 
    not_look_ahead([hver],_7291,_7274,_7308),
    cc(alle,_7308,_7330),
    not_look_ahead_np(_7331,_7330,_7276).

quant_pron(every,thing,[quant_pron,_7295,lit(alt),_7335],_7278,_7280) --> 
    not_look_ahead(w(name(_7253,_7254,_7255)),_7295,_7278,_7312),
    cc(alt,_7312,_7334),
    sammen0(_7335,_7334,_7280).

quant_pron(some,person,[quant_pron,lit(den),_7302,!],_7274,_7276) --> 
    cc(den,_7274,_7301),
    look_ahead([som],_7302,_7301,_7276),
    !.

quant_pron(some,thing,[quant_pron,lit(det),_7302,!],_7274,_7276) --> 
    cc(det,_7274,_7301),
    look_ahead([som],_7302,_7301,_7276),
    !.

quant_pron(some,person,[quant_pron,lit(man)],_7264,_7266) --> 
    cc(man,_7264,_7266).

quant_pron(some,thing,[quant_pron,lit(mer),_7299],_7271,_7273) --> 
    cc(mer,_7271,_7298),
    not_look_ahead([enn],_7299,_7298,_7273).

quant_pron(some,thing,[quant_pron,lit(noe)],_7264,_7266) --> 
    cc(noe,_7264,_7266).

quant_pron(some,agent,[quant_pron,lit(noen),_7305,_7329],_7277,_7279) --> 
    cc(noen,_7277,_7304),
    avdem0(_7305,_7304,_7320),
    not_look_ahead(w(adj(_7253,_7254)),_7329,_7320,_7279).

avdem0([avdem0,lit(av),lit('våre'),!,_7306],_7268,_7270) --> 
    cc(av,_7268,_7289),
    cc('våre',_7289,_7300),
    !,
    reject(_7306,_7300,_7270).

avdem0([avdem0,lit(av),lit(dem),!],_7265,_7267) --> 
    cc(av,_7265,_7286),
    cc(dem,_7286,_7267),
    !.

avdem0([avdem0,[]],_7255,_7255) --> 
    [].

quant_pron(some,vehicle,[quant_pron,lit(noen),_7299],_7271,_7273) --> 
    cc(noen,_7271,_7298),
    not_look_ahead([av],_7299,_7298,_7273).

quant_pron(some,agent,[quant_pron,_7279],_7262,_7264) --> 
    someone(_7279,_7262,_7264).

quant_pron(some,thing,[quant_pron,_7290,_7314],_7273,_7275) --> 
    something(_7290,_7273,_7305),
    not_look_ahead(w(verb(_7250,_7251,pass)),_7314,_7305,_7275).

quant_pron(no,person,[quant_pron,lit(ingen),_7295],_7267,_7269) --> 
    cc(ingen,_7267,_7294),
    not_look_ahead_np(_7295,_7294,_7269).

quant_pron(no,thing,[quant_pron,lit(intet),_7304],_7276,_7278) --> 
    cc(intet,_7276,_7303),
    not_look_ahead(w(noun(_7250,_7251,_7252,_7253)),_7304,_7303,_7278).

quant_pron(no,thing,[quant_pron,lit(ingen),lit(ting)],_7269,_7271) --> 
    cc(ingen,_7269,_7296),
    cc(ting,_7296,_7271).

quant_pron(no,thing,[quant_pron,lit(ingenting)],_7264,_7266) --> 
    cc(ingenting,_7264,_7266).

quant_pron(much,thing,[quant_pron,_7289,_7313],_7272,_7274) --> 
    somuch(_7289,_7272,_7304),
    not_look_ahead(w(adj2(_7250,nil)),_7313,_7304,_7274).

quant_pron(little,thing,[quant_pron,_7305,_7334,_7358,_7387],_7288,_7290) --> 
    not_look_ahead(w(adv(_7263)),_7305,_7288,_7322),
    solittle(_7334,_7322,_7349),
    not_look_ahead(['å'],_7358,_7349,_7375),
    not_look_ahead(w(adj2(late,nil)),_7387,_7375,_7290).

quant_pron(some,feeling,[quant_pron,_7279],_7262,_7264) --> 
    somegood(_7279,_7262,_7264).

denbussen([denbussen,lit(den),_7293,!,_7327],_7271,_7273) --> 
    cc(den,_7271,_7292),
    w(adj2(_7253,nil),_7293,_7292,_7310),
    !,
    reject(_7327,_7310,_7273).

denbussen([denbussen,lit(den)],_7257,_7259) --> 
    cc(den,_7257,_7259).

sammen0([sammen0,lit(sammen),!],_7260,_7262) --> 
    cc(sammen,_7260,_7262),
    !.

sammen0([sammen0,_7274,!],_7263,_7265) --> 
    w(adj2(possible,nil),_7274,_7263,_7265),
    !.

sammen0([sammen0,[]],_7255,_7255) --> 
    [].

somuch([somuch,_7269,_7293],_7258,_7260) --> 
    so0(_7269,_7258,_7284),
    much(_7293,_7284,_7260).

solittle([solittle,_7269,_7293],_7258,_7260) --> 
    so0(_7269,_7258,_7284),
    little(_7293,_7284,_7260).

quant0(_7240,[quant0,_7281,!,_7315],_7267,_7269) --> 
    quant1(_7240,_7281,_7267,_7298),
    !,
    accept(_7315,_7298,_7269).

quant0(1,[quant0,[]],_7259,_7259) --> 
    [].

quant1(+(_7242),[quant1,_7280],_7266,_7268) --> 
    w(nb(_7242,num),_7280,_7266,_7268).

quant1(-(_7242),[quant1,_7277],_7263,_7265) --> 
    ordinal(_7242,_7277,_7263,_7265).

recently([recently,lit(nylig)],_7257,_7259) --> 
    cc(nylig,_7257,_7259).

recently([recently,_7276,lit(det),_7316],_7265,_7267) --> 
    prep1(in,_7276,_7265,_7293),
    cc(det,_7293,_7315),
    latest(_7316,_7315,_7267).

everything([everything,_7279,lit(alt)],_7268,_7270) --> 
    not_look_ahead(w(name(_7249,_7250,_7251)),_7279,_7268,_7296),
    cc(alt,_7296,_7270).

something([something,lit(noe),lit(mer),!,_7306],_7268,_7270) --> 
    cc(noe,_7268,_7289),
    cc(mer,_7289,_7300),
    !,
    accept(_7306,_7300,_7270).

something([something,lit(noe),lit(som),lit(helst),!,_7322],_7273,_7275) --> 
    cc(noe,_7273,_7294),
    cc(som,_7294,_7305),
    cc(helst,_7305,_7316),
    !,
    accept(_7322,_7316,_7275).

something([something,lit(noe)],_7257,_7259) --> 
    cc(noe,_7257,_7259).

something([something,lit(det),_7285,!],_7263,_7265) --> 
    cc(det,_7263,_7284),
    endofline(_7285,_7284,_7265),
    !.

something([something,lit(det),_7298,_7327],_7276,_7278) --> 
    cc(det,_7276,_7297),
    not_look_ahead(['å'],_7298,_7297,_7315),
    not_look_ahead(w(noun(_7250,_7251,_7252,_7253)),_7327,_7315,_7278).

somegood([somegood,lit(det),_7293,_7317,!],_7271,_7273) --> 
    cc(det,_7271,_7292),
    so0(_7293,_7292,_7308),
    w(adj2(good,nil),_7317,_7308,_7273),
    !.

somegood([somegood,lit(det),_7293,_7317,!],_7271,_7273) --> 
    cc(det,_7271,_7292),
    so0(_7293,_7292,_7308),
    w(adj2(bad,nil),_7317,_7308,_7273),
    !.

sometimes0([sometimes0,_7268],_7257,_7259) --> 
    optional(sometimes,_7268,_7257,_7259).

sometimes([sometimes,lit(noen),_7295,!,_7329],_7273,_7275) --> 
    cc(noen,_7273,_7294),
    w(noun(time_count,_7254,_7255,_7256),_7295,_7294,_7312),
    !,
    accept(_7329,_7312,_7275).

sometimes([sometimes,lit(tidvis)],_7257,_7259) --> 
    cc(tidvis,_7257,_7259).

sometimes0([sometimes0,[]],_7255,_7255) --> 
    [].

notrel([notrel,_7276,!,_7310],_7265,_7267) --> 
    look_ahead([som],_7276,_7265,_7293),
    !,
    reject(_7310,_7293,_7267).

notrel([notrel,[]],_7255,_7255) --> 
    [].

relpron(thing,[relpron,lit(som),_7289],_7264,_7266) --> 
    cc(som,_7264,_7288),
    also0(_7289,_7288,_7266).

recipron(man,[recipron,lit(han),_7289],_7264,_7266) --> 
    cc(han,_7264,_7288),
    self(_7289,_7288,_7266).

recipron(person,[recipron,lit(seg),_7289],_7264,_7266) --> 
    cc(seg,_7264,_7288),
    self(_7289,_7288,_7266).

recipron(woman,[recipron,lit(henne),_7289],_7264,_7266) --> 
    cc(henne,_7264,_7288),
    self(_7289,_7288,_7266).

recipron(thing,[recipron,lit(seg),_7289],_7264,_7266) --> 
    cc(seg,_7264,_7288),
    self0(_7289,_7288,_7266).

recipron(thing,[recipron,lit(hverandre)],_7261,_7263) --> 
    cc(hverandre,_7261,_7263).

same([same,lit(samme)],_7257,_7259) --> 
    cc(samme,_7257,_7259).

self0([self0,_7266],_7255,_7257) --> 
    self(_7266,_7255,_7257).

self0([self0,[]],_7255,_7255) --> 
    [].

self([self,lit(selv)],_7257,_7259) --> 
    cc(selv,_7257,_7259).

set([set,_7273],_7262,_7264) --> 
    w(noun(set,_7243,_7244,n),_7273,_7262,_7264).

setlist([setlist,_7266],_7255,_7257) --> 
    set(_7266,_7255,_7257).

setlist([setlist,_7273],_7262,_7264) --> 
    w(noun(list,_7243,_7244,n),_7273,_7262,_7264).

several([several,lit(fler)],_7257,_7259) --> 
    cc(fler,_7257,_7259).

several([several,lit(flere)],_7257,_7259) --> 
    cc(flere,_7257,_7259).

several([several,lit(mer),lit(enn),_7298],_7265,_7267) --> 
    cc(mer,_7265,_7286),
    cc(enn,_7286,_7297),
    one(_7298,_7297,_7267).

sin([sin,lit(sin)],_7257,_7259) --> 
    cc(sin,_7257,_7259).

sin([sin,lit(sine)],_7257,_7259) --> 
    cc(sine,_7257,_7259).

sin([sin,lit(sitt)],_7257,_7259) --> 
    cc(sitt,_7257,_7259).

saa0([saa0,lit(bare),!,_7290],_7263,_7265) --> 
    cc(bare,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

saa0([saa0,lit('så'),_7292,!,_7341],_7270,_7272) --> 
    cc('så',_7270,_7291),
    optional([ofte],_7292,_7291,_7324),
    !,
    accept(_7341,_7324,_7272).

saa0([saa0,lit(mye),!,_7290],_7263,_7265) --> 
    cc(mye,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

saa0([saa0,lit(da),!,_7290],_7263,_7265) --> 
    cc(da,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

saa0([saa0,[]],_7255,_7255) --> 
    [].

so0([so0,_7269,!],_7258,_7260) --> 
    so(_7269,_7258,_7260),
    !.

so0([so0,[]],_7255,_7255) --> 
    [].

so([so,lit('så')],_7257,_7259) --> 
    cc('så',_7257,_7259).

so([so,_7266],_7255,_7257) --> 
    too(_7266,_7255,_7257).

so([so,lit(heretter)],_7257,_7259) --> 
    cc(heretter,_7257,_7259).

so_that([so_that,lit(forat)],_7257,_7259) --> 
    cc(forat,_7257,_7259).

so_that([so_that,lit(som),lit(at)],_7262,_7264) --> 
    cc(som,_7262,_7283),
    cc(at,_7283,_7264).

so_that([so_that,lit(slik),_7289,_7313],_7267,_7269) --> 
    cc(slik,_7267,_7288),
    that(_7289,_7288,_7304),
    optional([bare],_7313,_7304,_7269).

so_that([so_that,lit('så'),_7282],_7260,_7262) --> 
    cc('så',_7260,_7281),
    that(_7282,_7281,_7262).

so_that([so_that,lit(som),_7291,_7320],_7269,_7271) --> 
    cc(som,_7269,_7290),
    w(verb(do1,_7251,fin),_7291,_7290,_7308),
    that(_7320,_7308,_7271).

so_that([so_that,lit('så'),_7295,!],_7273,_7275) --> 
    cc('så',_7273,_7294),
    look_ahead_lit([jeg,da,den,det],_7295,_7294,_7275),
    !.

so_that([so_that,lit('så'),_7294,!],_7272,_7274) --> 
    cc('så',_7272,_7293),
    look_ahead(w(noun(_7252,_7253,_7254,_7255)),_7294,_7293,_7274),
    !.

so_that([so_that,lit(til),lit(at),!],_7265,_7267) --> 
    cc(til,_7265,_7286),
    cc(at,_7286,_7267),
    !.

so_that([so_that,_7273,lit(at)],_7262,_7264) --> 
    prep1(for,_7273,_7262,_7290),
    cc(at,_7290,_7264).

som0([som0,_7266],_7255,_7257) --> 
    som(_7266,_7255,_7257).

som0([som0,[]],_7255,_7255) --> 
    [].

som([som,lit(som)],_7257,_7259) --> 
    cc(som,_7257,_7259).

some([some,lit(noen),_7282],_7260,_7262) --> 
    cc(noen,_7260,_7281),
    of0(_7282,_7281,_7262).

someonex([someonex,_7266],_7255,_7257) --> 
    someone(_7266,_7255,_7257).

someone([someone,lit(dere)],_7257,_7259) --> 
    cc(dere,_7257,_7259).

someone([someone,lit(noen),_7282],_7260,_7262) --> 
    cc(noen,_7260,_7281),
    endofline(_7282,_7281,_7262).

someone([someone,lit(noen),_7290],_7268,_7270) --> 
    cc(noen,_7268,_7289),
    look_ahead(w(verb(_7247,_7248,_7249)),_7290,_7289,_7270).

someone([someone,_7271,lit(mange)],_7260,_7262) --> 
    so0(_7271,_7260,_7286),
    cc(mange,_7286,_7262).

someone([someone,lit(den),_7286],_7264,_7266) --> 
    cc(den,_7264,_7285),
    look_ahead([som],_7286,_7285,_7266).

someone([someone,lit(en),_7286],_7264,_7266) --> 
    cc(en,_7264,_7285),
    look_ahead([som],_7286,_7285,_7266).

soonar([soonar,lit(snart)],_7257,_7259) --> 
    cc(snart,_7257,_7259).

soonar([soonar,lit(snarest)],_7257,_7259) --> 
    cc(snarest,_7257,_7259).

soonar([soonar,lit(fort)],_7257,_7259) --> 
    cc(fort,_7257,_7259).

soon([soon,lit(fort)],_7257,_7259) --> 
    cc(fort,_7257,_7259).

soon([soon,_7271],_7260,_7262) --> 
    w(adj2(fast,nil),_7271,_7260,_7262).

soon([soon,lit(snart)],_7257,_7259) --> 
    cc(snart,_7257,_7259).

soon([soon,lit(snarest)],_7257,_7259) --> 
    cc(snarest,_7257,_7259).

statics(avg,[statics,lit(gjennomsnittet),_7289],_7264,_7266) --> 
    cc(gjennomsnittet,_7264,_7288),
    ofthe0(_7289,_7288,_7266).

statics(max(1),[statics,lit(maksimum),_7291],_7266,_7268) --> 
    cc(maksimum,_7266,_7290),
    ofthe0(_7291,_7290,_7268).

statics(min(1),[statics,lit(minimum),_7291],_7266,_7268) --> 
    cc(minimum,_7266,_7290),
    ofthe0(_7291,_7290,_7268).

statics(sum,[statics,_7276,_7300],_7262,_7264) --> 
    total(_7276,_7262,_7291),
    ofthe0(_7300,_7291,_7264).

statics(number,[statics,lit(antall),_7289],_7264,_7266) --> 
    cc(antall,_7264,_7288),
    ofthe0(_7289,_7288,_7266).

sure([sure,lit(sikker)],_7257,_7259) --> 
    cc(sikker,_7257,_7259).

sure([sure,lit(sikkert)],_7257,_7259) --> 
    cc(sikkert,_7257,_7259).

sure([sure,lit(sikre)],_7257,_7259) --> 
    cc(sikre,_7257,_7259).

terminator([terminator,_7272,!,_7301],_7261,_7263) --> 
    termchar(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

termchar0([termchar0,_7269,!],_7258,_7260) --> 
    termchar(_7269,_7258,_7260),
    !.

termchar0([termchar0,[]],_7255,_7255) --> 
    [].

termchar([termchar,lit('.')],_7257,_7259) --> 
    cc('.',_7257,_7259).

termchar([termchar,lit(?)],_7257,_7259) --> 
    cc(?,_7257,_7259).

termchar([termchar,lit(!)],_7257,_7259) --> 
    cc(!,_7257,_7259).

termchar([termchar,lit(:)],_7257,_7259) --> 
    cc(:,_7257,_7259).

than0([than0,_7266],_7255,_7257) --> 
    than(_7266,_7255,_7257).

than0([than0,[]],_7255,_7255) --> 
    [].

than([than,lit(enn)],_7257,_7259) --> 
    cc(enn,_7257,_7259).

that([that,lit(om),lit(at),!,_7306],_7268,_7270) --> 
    cc(om,_7268,_7289),
    cc(at,_7289,_7300),
    !,
    accept(_7306,_7300,_7270).

that([that,lit(at)],_7257,_7259) --> 
    cc(at,_7257,_7259).

that(that,[that,_7273],_7259,_7261) --> 
    that(_7273,_7259,_7261).

that(how,[that,_7273],_7259,_7261) --> 
    how(_7273,_7259,_7261).

that(when,[that,_7273],_7259,_7261) --> 
    when(_7273,_7259,_7261).

that(where,[that,_7273],_7259,_7261) --> 
    where(_7273,_7259,_7261).

that(whether,[that,_7278,lit(hvorvidt)],_7264,_7266) --> 
    paa0(_7278,_7264,_7293),
    cc(hvorvidt,_7293,_7266).

that(whether,[that,_7278,lit(om)],_7264,_7266) --> 
    paa0(_7278,_7264,_7293),
    cc(om,_7293,_7266).

that(why,[that,lit(hvorfor)],_7261,_7263) --> 
    cc(hvorfor,_7261,_7263).

paa0([paa0,lit('på'),!,_7290],_7263,_7265) --> 
    cc('på',_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

paa0([paa0,[]],_7255,_7255) --> 
    [].

that0([that0,_7266],_7255,_7257) --> 
    that(_7266,_7255,_7257).

that0([that0,[]],_7255,_7255) --> 
    [].

the([the,lit(den)],_7257,_7259) --> 
    cc(den,_7257,_7259).

the([the,lit(denne)],_7257,_7259) --> 
    cc(denne,_7257,_7259).

the([the,lit(det)],_7257,_7259) --> 
    cc(det,_7257,_7259).

the([the,lit(de)],_7257,_7259) --> 
    cc(de,_7257,_7259).

the([the,lit(dette)],_7257,_7259) --> 
    cc(dette,_7257,_7259).

the([the,lit(disse),_7282],_7260,_7262) --> 
    cc(disse,_7260,_7281),
    look_ahead_np(_7282,_7281,_7262).

themost([themost,_7271,lit(mest)],_7260,_7262) --> 
    the(_7271,_7260,_7286),
    cc(mest,_7286,_7262).

the0([the0,_7275,_7299,!,_7328],_7264,_7266) --> 
    the(_7275,_7264,_7290),
    der0(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

the0([the0,{},_7284],_7263,_7265) --> 
    {user:value(textflag,true)},
    art(_7284,_7263,_7265).

the0([the0,[]],_7255,_7255) --> 
    [].

the10([the10,lit(det)],_7257,_7259) --> 
    cc(det,_7257,_7259).

the10([the10,lit(den)],_7257,_7259) --> 
    cc(den,_7257,_7259).

the10([the10,[]],_7255,_7255) --> 
    [].

theplu0([theplu0,_7275,_7299,!,_7328],_7264,_7266) --> 
    all0(_7275,_7264,_7290),
    theplu(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

theplu0([theplu0,lit(den)],_7257,_7259) --> 
    cc(den,_7257,_7259).

theplu0([theplu0,_7266],_7255,_7257) --> 
    all0(_7266,_7255,_7257).

theplu([theplu,lit(de)],_7257,_7259) --> 
    cc(de,_7257,_7259).

their([their,lit(deres)],_7257,_7259) --> 
    cc(deres,_7257,_7259).

their([their,lit(de),lit(andres)],_7262,_7264) --> 
    cc(de,_7262,_7283),
    cc(andres,_7283,_7264).

then0([then0,_7272,!,_7301],_7261,_7263) --> 
    then1(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

then0([then0,[]],_7255,_7255) --> 
    [].

then1([then1,lit(da)],_7257,_7259) --> 
    cc(da,_7257,_7259).

then1([then1,lit('så')],_7257,_7259) --> 
    cc('så',_7257,_7259).

theonly0([theonly0,_7269,_7293],_7258,_7260) --> 
    the0(_7269,_7258,_7284),
    only0(_7293,_7284,_7260).

thereit0([thereit0,_7272,!,_7301],_7261,_7263) --> 
    thereit(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

thereit0([thereit0,[]],_7255,_7255) --> 
    [].

therenot0([therenot0,_7275,_7299,!,_7328],_7264,_7266) --> 
    thereit(_7275,_7264,_7290),
    not0(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

therenot0([therenot0,_7275,_7299,!,_7328],_7264,_7266) --> 
    not(_7275,_7264,_7290),
    thereit0(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

therenot0([therenot0,[]],_7255,_7255) --> 
    [].

thereit(_7240,[thereit,_7290,_7314,_7343,_7367,!,_7396],_7276,_7278) --> 
    thereit(_7290,_7276,_7305),
    negation0(_7240,_7314,_7305,_7331),
    redundant0(_7343,_7331,_7358),
    been0(_7367,_7358,_7382),
    !,
    accept(_7396,_7382,_7278).

thereitN([thereitN,_7276,_7300,!],_7265,_7267) --> 
    thereit(_7276,_7265,_7291),
    look_ahead([ikke],_7300,_7291,_7267),
    !.

thereitN([thereitN,_7266],_7255,_7257) --> 
    thereit(_7266,_7255,_7257).

dette([dette,lit(det),_7282],_7260,_7262) --> 
    cc(det,_7260,_7281),
    it_was_pronoun(_7282,_7281,_7262).

dette([dette,lit(dette)],_7257,_7259) --> 
    cc(dette,_7257,_7259).

thereit2(be,[thereit2,lit(det),!],_7264,_7266) --> 
    cc(det,_7264,_7266),
    !.

thereit2(_7240,[thereit2,_7276,!],_7262,_7264) --> 
    thereit(_7276,_7262,_7264),
    !.

thereit2(be,[thereit2,_7280,!],_7266,_7268) --> 
    look_ahead([til],_7280,_7266,_7268),
    !.

init([init,lit(det)],_7257,_7259) --> 
    cc(det,_7257,_7259).

init([init,lit(dette),_7282],_7260,_7262) --> 
    cc(dette,_7260,_7281),
    look_ahead_vp(_7282,_7281,_7262).

thereit([thereit,lit(de),_7286],_7264,_7266) --> 
    cc(de,_7264,_7285),
    look_ahead([noe],_7286,_7285,_7266).

thereit([thereit,lit(det),_7288,!,_7317],_7266,_7268) --> 
    cc(det,_7266,_7287),
    thereit_not_pronoun(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

thereit([thereit,lit(der)],_7257,_7259) --> 
    cc(der,_7257,_7259).

thereit([thereit,lit(her)],_7257,_7259) --> 
    cc(her,_7257,_7259).

thereit_not_pronoun([thereit_not_pronoun,_7272,!,_7301],_7261,_7263) --> 
    it_was_pronoun(_7272,_7261,_7287),
    !,
    reject(_7301,_7287,_7263).

thereit_not_pronoun([thereit_not_pronoun,[]],_7255,_7255) --> 
    [].

it_was_pronoun([it_was_pronoun,_7266],_7255,_7257) --> 
    endofline(_7266,_7255,_7257).

it_was_pronoun([it_was_pronoun,_7266],_7255,_7257) --> 
    look_ahead_vp(_7266,_7255,_7257).

this(_7240,[this,_7280,{}],_7266,_7268) --> 
    this(_7280,_7266,_7268),
    {user:it_template(_7240)}.

this(_7240,[this,_7280,{}],_7266,_7268) --> 
    thereit(_7280,_7266,_7268),
    {user:it_template(_7240)}.

this([this,lit(denne)],_7257,_7259) --> 
    cc(denne,_7257,_7259).

this([this,lit(dette)],_7257,_7259) --> 
    cc(dette,_7257,_7259).

this([this,lit(disse),_7282],_7260,_7262) --> 
    cc(disse,_7260,_7281),
    not_look_ahead_np(_7282,_7281,_7262).

this([this,lit(det),_7289,_7318],_7267,_7269) --> 
    cc(det,_7267,_7288),
    look_ahead(['.'],_7289,_7288,_7306),
    accept(_7318,_7306,_7269).

this([this,lit(det),_7289,_7318],_7267,_7269) --> 
    cc(det,_7267,_7288),
    look_ahead([?],_7289,_7288,_7306),
    accept(_7318,_7306,_7269).

this([this,lit(det),lit(da),!,_7306],_7268,_7270) --> 
    cc(det,_7268,_7289),
    cc(da,_7289,_7300),
    !,
    accept(_7306,_7300,_7270).

this([this,lit(det),_7288,!,_7317],_7266,_7268) --> 
    cc(det,_7266,_7287),
    end_of_line(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

this([this,lit(slik),_7288],_7266,_7268) --> 
    cc(slik,_7266,_7287),
    not_look_ahead_lit([at,som],_7288,_7287,_7268).

thisplace(in,[thisplace,lit(her)],_7261,_7263) --> 
    cc(her,_7261,_7263).

thisplace(to,[thisplace,lit(hit)],_7261,_7263) --> 
    cc(hit,_7261,_7263).

thisplace(in,[thisplace,lit(der)],_7261,_7263) --> 
    cc(der,_7261,_7263).

thisplace(to,[thisplace,lit(dit)],_7261,_7263) --> 
    cc(dit,_7261,_7263).

timepoint([timepoint,_7273],_7262,_7264) --> 
    w(noun(time,_7243,u,n),_7273,_7262,_7264).

timepoint([timepoint,_7273],_7262,_7264) --> 
    w(noun(clock,sin,u,n),_7273,_7262,_7264).

to([to,_7268],_7257,_7259) --> 
    prep(to,_7268,_7257,_7259).

forto0([forto0,_7269,!],_7258,_7260) --> 
    forto(_7269,_7258,_7260),
    !.

forto0([forto0,[]],_7255,_7255) --> 
    [].

forto([forto,lit(for)],_7257,_7259) --> 
    cc(for,_7257,_7259).

forto([forto,lit(til)],_7257,_7259) --> 
    cc(til,_7257,_7259).

forto([forto,lit(om)],_7257,_7259) --> 
    cc(om,_7257,_7259).

slikat([slikat,lit(slik),lit(at)],_7262,_7264) --> 
    cc(slik,_7262,_7283),
    cc(at,_7283,_7264).

slikat([slikat,lit(sikkert),lit(at)],_7262,_7264) --> 
    cc(sikkert,_7262,_7283),
    cc(at,_7283,_7264).

to0([to0,_7269,!],_7258,_7260) --> 
    to(_7269,_7258,_7260),
    !.

to0([to0,[]],_7255,_7255) --> 
    [].

tomed0([tomed0,lit(til),!],_7260,_7262) --> 
    cc(til,_7260,_7262),
    !.

tomed0([tomed0,lit(med),!],_7260,_7262) --> 
    cc(med,_7260,_7262),
    !.

tomed0([tomed0,[]],_7255,_7255) --> 
    [].

too([too,lit(for),_7289],_7267,_7269) --> 
    cc(for,_7267,_7288),
    look_ahead(w(adj(_7247,nil)),_7289,_7288,_7269).

today0([today0,_7266],_7255,_7257) --> 
    today(_7266,_7255,_7257).

today0([today0,[]],_7255,_7255) --> 
    [].

today([today,lit(idag)],_7257,_7259) --> 
    cc(idag,_7257,_7259).

today([today,_7278,_7307],_7267,_7269) --> 
    prep(in,_7278,_7267,_7295),
    w(noun(day,sin,u,n),_7307,_7295,_7269).

tomorrow([tomorrow,lit(imorgen)],_7257,_7259) --> 
    cc(imorgen,_7257,_7259).

tomorrow([tomorrow,_7273,lit(morgen)],_7262,_7264) --> 
    prep1(in,_7273,_7262,_7290),
    cc(morgen,_7290,_7264).

total([total,lit(total)],_7257,_7259) --> 
    cc(total,_7257,_7259).

total([total,lit(totalt)],_7257,_7259) --> 
    cc(totalt,_7257,_7259).

total([total,lit(totale)],_7257,_7259) --> 
    cc(totale,_7257,_7259).

total([total,lit(sum),_7282],_7260,_7262) --> 
    cc(sum,_7260,_7281),
    of(_7282,_7281,_7262).

true([true,lit(sann)],_7257,_7259) --> 
    cc(sann,_7257,_7259).

true([true,lit(sant)],_7257,_7259) --> 
    cc(sant,_7257,_7259).

true([true,lit(sanne)],_7257,_7259) --> 
    cc(sanne,_7257,_7259).

true([true,lit(slik)],_7257,_7259) --> 
    cc(slik,_7257,_7259).

truefalse(id,[truefalse,_7273],_7259,_7261) --> 
    true(_7273,_7259,_7261).

truefalse(id,[truefalse,_7276,_7300],_7262,_7264) --> 
    not(_7276,_7262,_7291),
    false(_7300,_7291,_7264).

truefalse(not,[truefalse,_7273],_7259,_7261) --> 
    false(_7273,_7259,_7261).

truefalse(not,[truefalse,_7276,_7300],_7262,_7264) --> 
    not(_7276,_7262,_7291),
    true(_7300,_7291,_7264).

unequal([unequal,lit(ulik)],_7257,_7259) --> 
    cc(ulik,_7257,_7259).

unequal([unequal,lit(ulikt)],_7257,_7259) --> 
    cc(ulikt,_7257,_7259).

unequal([unequal,lit(ulike)],_7257,_7259) --> 
    cc(ulike,_7257,_7259).

unequal([unequal,_7269,_7293],_7258,_7260) --> 
    not(_7269,_7258,_7284),
    equal(_7293,_7284,_7260).

until([until,lit(inntil)],_7257,_7259) --> 
    cc(inntil,_7257,_7259).

until([until,lit(fram),_7284],_7262,_7264) --> 
    cc(fram,_7262,_7283),
    prep1(to,_7284,_7283,_7264).

use([use,_7272],_7261,_7263) --> 
    w(verb(use,_7243,fin),_7272,_7261,_7263).

use([use,_7272],_7261,_7263) --> 
    w(verb(want,_7243,fin),_7272,_7261,_7263).

what([what,lit(hva)],_7257,_7259) --> 
    cc(hva,_7257,_7259).

whatbe([whatbe,_7275,_7299,!,_7328],_7264,_7266) --> 
    what(_7275,_7264,_7290),
    be(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

whatbe([whatbe,lit(hvilke),_7288,!,_7317],_7266,_7268) --> 
    cc(hvilke,_7266,_7287),
    be(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

whatbe([whatbe,lit(hvilken),_7288,!,_7317],_7266,_7268) --> 
    cc(hvilken,_7266,_7287),
    be(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

whatbe([whatbe,lit(hvilket),_7288,!,_7317],_7266,_7268) --> 
    cc(hvilket,_7266,_7287),
    be(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

whatbemean([whatbemean,lit(hva),_7288],_7266,_7268) --> 
    cc(hva,_7266,_7287),
    w(verb(be,pres,fin),_7288,_7287,_7268).

whatbemean([whatbemean,lit(hva),_7288],_7266,_7268) --> 
    cc(hva,_7266,_7287),
    w(verb(mean2,pres,fin),_7288,_7287,_7268).

whatbemean([whatbemean,lit(hva),_7288],_7266,_7268) --> 
    cc(hva,_7266,_7287),
    w(verb(indicate,pres,fin),_7288,_7287,_7268).

when0([when0,_7272,!,_7301],_7261,_7263) --> 
    when(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

when0([when0,[]],_7255,_7255) --> 
    [].

whenx([whenx,_7277,lit(jeg),!,_7317],_7266,_7268) --> 
    when1(_7277,_7266,_7292),
    cc(jeg,_7292,_7311),
    !,
    reject(_7317,_7311,_7268).

whenx([whenx,_7266],_7255,_7257) --> 
    when(_7266,_7255,_7257).

when([when,lit('når'),_7288,!,_7317],_7266,_7268) --> 
    cc('når',_7266,_7287),
    timepoint(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

when([when,lit('når')],_7257,_7259) --> 
    cc('når',_7257,_7259).

when([when,lit(hvordan),_7295,!,_7329],_7273,_7275) --> 
    cc(hvordan,_7273,_7294),
    w(noun(time,_7254,u,n),_7295,_7294,_7312),
    !,
    accept(_7329,_7312,_7275).

when([when,lit(hvor),_7288,!,_7317],_7266,_7268) --> 
    cc(hvor,_7266,_7287),
    timepoint(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

when([when,lit(hva),_7288,!,_7317],_7266,_7268) --> 
    cc(hva,_7266,_7287),
    timepoint(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

when([when,_7275,_7299,!,_7328],_7264,_7266) --> 
    which(_7275,_7264,_7290),
    timepoint(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

when([when,_7280,_7309,_7333,!,_7362],_7269,_7271) --> 
    prep1(to,_7280,_7269,_7297),
    which(_7309,_7297,_7324),
    timepoint(_7333,_7324,_7348),
    !,
    accept(_7362,_7348,_7271).

when([when,_7280,_7309,_7333,!,_7362],_7269,_7271) --> 
    prep1(on,_7280,_7269,_7297),
    which(_7309,_7297,_7324),
    timepoint(_7333,_7324,_7348),
    !,
    accept(_7362,_7348,_7271).

when([when,lit('så'),lit(snart),!,_7306],_7268,_7270) --> 
    cc('så',_7268,_7289),
    cc(snart,_7289,_7300),
    !,
    accept(_7306,_7300,_7270).

when([when,lit(hva),lit(ti)],_7262,_7264) --> 
    cc(hva,_7262,_7283),
    cc(ti,_7283,_7264).

when([when,lit(hvordan),lit(ti)],_7262,_7264) --> 
    cc(hvordan,_7262,_7283),
    cc(ti,_7283,_7264).

when([when,lit(tid),_7286],_7264,_7266) --> 
    cc(tid,_7264,_7285),
    look_ahead(['går'],_7286,_7285,_7266).

where([where,lit(hvor),_7297,_7326,!,_7355],_7275,_7277) --> 
    cc(hvor,_7275,_7296),
    not_look_ahead(w(prep(from)),_7297,_7296,_7314),
    andwhen0(_7326,_7314,_7341),
    !,
    accept(_7355,_7341,_7277).

where([where,_7282,_7306,!,_7340],_7271,_7273) --> 
    which(_7282,_7271,_7297),
    w(noun(place,_7252,_7253,_7254),_7306,_7297,_7323),
    !,
    accept(_7340,_7323,_7273).

where1([where1,lit(der),lit(hvor),!,_7306],_7268,_7270) --> 
    cc(der,_7268,_7289),
    cc(hvor,_7289,_7300),
    !,
    accept(_7306,_7300,_7270).

where1([where1,lit(hvor),_7288,!,_7317],_7266,_7268) --> 
    cc(hvor,_7266,_7287),
    meny(_7288,_7287,_7303),
    !,
    reject(_7317,_7303,_7268).

where1([where1,lit(hvor)],_7257,_7259) --> 
    cc(hvor,_7257,_7259).

where1([where1,lit(der)],_7257,_7259) --> 
    cc(der,_7257,_7259).

wherefrom([wherefrom,_7287,_7316,_7340,!,_7374],_7276,_7278) --> 
    prep1(from,_7287,_7276,_7304),
    which(_7316,_7304,_7331),
    w(noun(place,_7257,_7258,_7259),_7340,_7331,_7357),
    !,
    accept(_7374,_7357,_7278).

wherefrom([wherefrom,_7279,lit(hvor),!,_7324],_7268,_7270) --> 
    prep1(from,_7279,_7268,_7296),
    cc(hvor,_7296,_7318),
    !,
    accept(_7324,_7318,_7270).

wherefrom([wherefrom,lit(hvorfra)],_7257,_7259) --> 
    cc(hvorfra,_7257,_7259).

wherefrom([wherefrom,lit(hvor),lit(fra)],_7262,_7264) --> 
    cc(hvor,_7262,_7283),
    cc(fra,_7283,_7264).

wherefrom([wherefrom,lit(hvor),lit(ifra)],_7262,_7264) --> 
    cc(hvor,_7262,_7283),
    cc(ifra,_7283,_7264).

while([while,lit(mens)],_7257,_7259) --> 
    cc(mens,_7257,_7259).

which0([which0,_7272,!,_7301],_7261,_7263) --> 
    which(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

which0([which0,[]],_7255,_7255) --> 
    [].

which([which,lit(hva),_7290,_7319,!],_7268,_7270) --> 
    cc(hva,_7268,_7289),
    prep1(for,_7290,_7289,_7307),
    a0(_7319,_7307,_7270),
    !.

which([which,lit(hva),lit(slags),!],_7265,_7267) --> 
    cc(hva,_7265,_7286),
    cc(slags,_7286,_7267),
    !.

which([which,lit(hvilken),lit(slags),!],_7265,_7267) --> 
    cc(hvilken,_7265,_7286),
    cc(slags,_7286,_7267),
    !.

which([which,lit(hvilken)],_7257,_7259) --> 
    cc(hvilken,_7257,_7259).

which([which,lit(hvilket)],_7257,_7259) --> 
    cc(hvilket,_7257,_7259).

which([which,lit(hvilke),_7282],_7260,_7262) --> 
    cc(hvilke,_7260,_7281),
    off0(_7282,_7281,_7262).

which2([which2,_7272,_7296,_7320],_7261,_7263) --> 
    which(_7272,_7261,_7287),
    numbertype0(_7296,_7287,_7311),
    ofthe0(_7320,_7311,_7263).

which2([which2,lit(hvem),_7306,_7335,!],_7284,_7286) --> 
    cc(hvem,_7284,_7305),
    look_ahead(w(noun(_7255,sin,u,n)),_7306,_7305,_7323),
    gmem(_7255,[bus,tram,day],_7335,_7323,_7286),
    !.

which2([which2,lit(hvordan),_7308,_7337,!],_7286,_7288) --> 
    cc(hvordan,_7286,_7307),
    look_ahead(w(noun(_7255,sin,u,n)),_7308,_7307,_7325),
    gmem(_7255,[label,bus,tram,day],_7337,_7325,_7288),
    !.

numbertype0([numbertype0,_7272,!,_7301],_7261,_7263) --> 
    type(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

numbertype0([numbertype0,[]],_7255,_7255) --> 
    [].

with0([with0,_7274,!,_7308],_7263,_7265) --> 
    prep(with,_7274,_7263,_7291),
    !,
    accept(_7308,_7291,_7265).

with0([with0,[]],_7255,_7255) --> 
    [].

who([who,lit(hvem)],_7257,_7259) --> 
    cc(hvem,_7257,_7259).

whose([whose,lit(hvis)],_7257,_7259) --> 
    cc(hvis,_7257,_7259).

mex0([mex0,_7276,!,_7310],_7265,_7267) --> 
    look_ahead([jeg],_7276,_7265,_7293),
    !,
    reject(_7310,_7293,_7267).

mex0([mex0,_7276,!,_7310],_7265,_7267) --> 
    look_ahead([du],_7276,_7265,_7293),
    !,
    reject(_7310,_7293,_7267).

mex0([mex0,lit(seg),!,_7290],_7263,_7265) --> 
    cc(seg,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

mex0([mex0,lit(meg),!,_7290],_7263,_7265) --> 
    cc(meg,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

mex0([mex0,lit(oss),!,_7290],_7263,_7265) --> 
    cc(oss,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

mex0([mex0,[]],_7255,_7255) --> 
    [].

you([you,lit(du),_7286],_7264,_7266) --> 
    cc(du,_7264,_7285),
    not_look_ahead([jeg],_7286,_7285,_7266).

yesterday([yesterday,_7273,lit('går')],_7262,_7264) --> 
    prep1(in,_7273,_7262,_7290),
    cc('går',_7290,_7264).

younger([younger,lit(yngre)],_7257,_7259) --> 
    cc(yngre,_7257,_7259).

your([your,lit(din)],_7257,_7259) --> 
    cc(din,_7257,_7259).

your([your,lit(ditt)],_7257,_7259) --> 
    cc(ditt,_7257,_7259).

your([your,lit(dine)],_7257,_7259) --> 
    cc(dine,_7257,_7259).

your([your,lit(di)],_7257,_7259) --> 
    cc(di,_7257,_7259).

num_na(_7240,[num_na,_7279,!,_7308],_7265,_7267) --> 
    art(_7279,_7265,_7294),
    !,
    reject(_7308,_7294,_7267).

num_na(_7240,[num_na,_7278],_7264,_7266) --> 
    w(nb(_7240,_7245),_7278,_7264,_7266).

num(_7240,[num,_7281,!],_7267,_7269) --> 
    w(nb(_7240,num),_7281,_7267,_7269),
    !.

personal('    ',[personal,lit(hysj)],_7261,_7263) --> 
    cc(hysj,_7261,_7263).

personal('RPGOLRAM',[personal,lit(rpgol)],_7261,_7263) --> 
    cc(rpgol,_7261,_7263).

personal('OK',[personal,lit(rpgolram)],_7261,_7263) --> 
    cc(rpgolram,_7261,_7263).

personal('Takk',[personal,lit('værs\'ågod')],_7261,_7263) --> 
    cc('værs\'ågod',_7261,_7263).

personal('Takk',[personal,_7292,lit('så'),_7332],_7278,_7280) --> 
    w(verb(be,imp,fin),_7292,_7278,_7309),
    cc('så',_7309,_7331),
    w(adj2(good,nil),_7332,_7331,_7280).

personal('Takk',[personal,_7282,_7306,_7330,_7354],_7268,_7270) --> 
    so(_7282,_7268,_7297),
    good(_7306,_7297,_7321),
    you(_7330,_7321,_7345),
    be(_7354,_7345,_7270).

personal('Takk',[personal,lit(bravo)],_7261,_7263) --> 
    cc(bravo,_7261,_7263).

personal('Takk',[personal,_7285,_7314,_7338],_7271,_7273) --> 
    w(verb(congratulate,pres,fin),_7285,_7271,_7302),
    with0(_7314,_7302,_7329),
    skip_rest(_7338,_7329,_7273).

personal(pong,[personal,lit(ping)],_7261,_7263) --> 
    cc(ping,_7261,_7263).

personal(_7240,[personal,_7275],_7261,_7263) --> 
    greetings(_7240,_7275,_7261,_7263).

greetings0([greetings0,_7278,_7307,!],_7267,_7269) --> 
    w(verb(help,imp,fin),_7278,_7267,_7295),
    optoken(_7307,_7295,_7269),
    !.

greetings0([greetings0,_7277,_7321,_7345,!],_7266,_7268) --> 
    optional(grums,_7277,_7266,_7309),
    greetings(_7321,_7309,_7336),
    optoken(_7345,_7336,_7268),
    !.

greetings0([greetings0,_7268],_7257,_7259) --> 
    optional(grums,_7268,_7257,_7259).

greetings('OK',[greetings,_7276,_7300],_7262,_7264) --> 
    okeys(_7276,_7262,_7291),
    endofline(_7300,_7291,_7264).

greetings('Hei på deg',[greetings,_7276,_7300],_7262,_7264) --> 
    hello(_7276,_7262,_7291),
    daddy(_7300,_7291,_7264).

greetings('Hei',[greetings,_7273],_7259,_7261) --> 
    greetings(_7273,_7259,_7261).

daddy([daddy,_7276,!],_7265,_7267) --> 
    w(noun(father,sin,u,n),_7276,_7265,_7267),
    !.

daddy([daddy,_7276,!],_7265,_7267) --> 
    w(noun(mother,sin,u,n),_7276,_7265,_7267),
    !.

daddy([daddy,_7275,!],_7264,_7266) --> 
    w(name(_7245,n,man),_7275,_7264,_7266),
    !.

optoken([optoken,lit(:)],_7257,_7259) --> 
    cc(:,_7257,_7259).

optoken([optoken,lit(!)],_7257,_7259) --> 
    cc(!,_7257,_7259).

optoken([optoken,lit('.')],_7257,_7259) --> 
    cc('.',_7257,_7259).

optoken([optoken,[]],_7255,_7255) --> 
    [].

greetings([greetings,lit(_7245),{}],_7275,_7277) --> 
    cc(_7245,_7275,_7277),
    {user:testmember(_7245,[ja,jo,joda,nei,neida])}.

greetings([greetings,_7266],_7255,_7257) --> 
    hellos(_7266,_7255,_7257).

greetings([greetings,lit(hva),lit(om)],_7262,_7264) --> 
    cc(hva,_7262,_7283),
    cc(om,_7283,_7264).

greetings([greetings,lit(nei)],_7257,_7259) --> 
    cc(nei,_7257,_7259).

greetings([greetings,lit(o),_7288,_7312],_7266,_7268) --> 
    cc(o,_7266,_7287),
    adj0(_7288,_7287,_7303),
    np0(_7246,_7247,_7312,_7303,_7268).

greetings([greetings,_7277,lit(meg)],_7266,_7268) --> 
    w(verb(say,inf,fin),_7277,_7266,_7294),
    cc(meg,_7294,_7268).

greetings([greetings,_7300,{},_7339,_7363,!],_7289,_7291) --> 
    w(noun(_7254,sin,u,n),_7300,_7289,_7317),
    {user:testmember(_7254,[oracle,brother,sister])},
    colon0(_7339,_7317,_7354),
    look_ahead(['når'],_7363,_7354,_7291),
    !.

greetings([greetings,_7301,{},_7340,_7364],_7290,_7292) --> 
    w(noun(_7259,sin,u,n),_7301,_7290,_7318),
    {user:testmember(_7259,[oracle,brother,sister])},
    colon0(_7340,_7318,_7355),
    not_look_ahead(w(verb(_7253,_7254,fin)),_7364,_7355,_7292).

greetings([greetings,_7308,_7337,_7366,_7395,_7419,_7448,_7472],_7297,_7299) --> 
    w(name(bustuc,n,_7262),_7308,_7297,_7325),
    not_look_ahead([som],_7337,_7325,_7354),
    not_look_ahead(w(prep(_7272)),_7366,_7354,_7383),
    colon0(_7395,_7383,_7410),
    not_look_ahead(w(verb(_7278,_7279,_7280)),_7419,_7410,_7436),
    not_look_ahead_vp(_7448,_7436,_7463),
    not_look_ahead_np(_7472,_7463,_7299).

trafikk([trafikk,lit(trafikk)],_7257,_7259) --> 
    cc(trafikk,_7257,_7259).

trafikk([trafikk,lit(t)],_7257,_7259) --> 
    cc(t,_7257,_7259).

grums0([grums0,[]],_7255,_7255) --> 
    [].

grums([grums,lit(rute),{}],_7265,_7267) --> 
    cc(rute,_7265,_7267),
    {user:value(smsflag,true)}.

grums([grums,lit('.')],_7257,_7259) --> 
    cc('.',_7257,_7259).

grums([grums,lit(?)],_7257,_7259) --> 
    cc(?,_7257,_7259).

grums([grums,lit(:),!],_7260,_7262) --> 
    cc(:,_7260,_7262),
    !.

grums([grums,lit(/),!],_7260,_7262) --> 
    cc(/,_7260,_7262),
    !.

grums([grums,lit(!),!],_7260,_7262) --> 
    cc(!,_7260,_7262),
    !.

grums([grums,lit(-),!],_7260,_7262) --> 
    cc(-,_7260,_7262),
    !.

grums([grums,lit(eksempelvis),lit(:)],_7262,_7264) --> 
    cc(eksempelvis,_7262,_7283),
    cc(:,_7283,_7264).

grums([grums,_7271,lit(at)],_7260,_7262) --> 
    redundant(_7271,_7260,_7286),
    cc(at,_7286,_7262).

grums([grums,_7295,lit(:),_7335,!],_7284,_7286) --> 
    w(noun(_7251,sin,u,n),_7295,_7284,_7312),
    cc(:,_7312,_7334),
    gmem(_7251,[error,thing,subject,example],_7335,_7334,_7286),
    !.

grums([grums,_7279,lit(om),!],_7268,_7270) --> 
    w(adj2(good,nil),_7279,_7268,_7296),
    cc(om,_7296,_7270),
    !.

grums([grums,lit(bare)],_7257,_7259) --> 
    cc(bare,_7257,_7259).

grums([grums,lit(eller)],_7257,_7259) --> 
    cc(eller,_7257,_7259).

grums([grums,lit(fyi),_7282],_7260,_7262) --> 
    cc(fyi,_7260,_7281),
    point0(_7282,_7281,_7262).

grums([grums,lit(grr)],_7257,_7259) --> 
    cc(grr,_7257,_7259).

grums([grums,lit(huff)],_7257,_7259) --> 
    cc(huff,_7257,_7259).

grums([grums,lit(igjen)],_7257,_7259) --> 
    cc(igjen,_7257,_7259).

grums([grums,lit(jo)],_7257,_7259) --> 
    cc(jo,_7257,_7259).

grums([grums,lit(og)],_7257,_7259) --> 
    cc(og,_7257,_7259).

grums([grums,lit(kort),lit(sagt)],_7262,_7264) --> 
    cc(kort,_7262,_7283),
    cc(sagt,_7283,_7264).

grums([grums,lit(men)],_7257,_7259) --> 
    cc(men,_7257,_7259).

grums([grums,lit(nei),lit(men)],_7262,_7264) --> 
    cc(nei,_7262,_7283),
    cc(men,_7283,_7264).

grums([grums,lit(nb)],_7257,_7259) --> 
    cc(nb,_7257,_7259).

grums([grums,lit(nei),_7290],_7268,_7270) --> 
    cc(nei,_7268,_7289),
    look_ahead(w(verb(_7247,_7248,_7249)),_7290,_7289,_7270).

grums([grums,lit(ja),_7290],_7268,_7270) --> 
    cc(ja,_7268,_7289),
    look_ahead(w(verb(_7247,_7248,_7249)),_7290,_7289,_7270).

grums([grums,lit(typisk)],_7257,_7259) --> 
    cc(typisk,_7257,_7259).

grums([grums,lit(uff)],_7257,_7259) --> 
    cc(uff,_7257,_7259).

grums([grums,lit(vel)],_7257,_7259) --> 
    cc(vel,_7257,_7259).

grums([grums,lit('å'),_7282],_7260,_7262) --> 
    cc('å',_7260,_7281),
    not_look_ahead_vp(_7282,_7281,_7262).

grums([grums,_7274,_7303],_7263,_7265) --> 
    w(nb(1939,num),_7274,_7263,_7291),
    point0(_7303,_7291,_7265).

grums([grums,_7287,_7331,_7360],_7276,_7278) --> 
    optional([for],_7287,_7276,_7319),
    w(noun(example,sin,u,n),_7331,_7319,_7348),
    optional([:],_7360,_7348,_7278).

grums([grums,_7278,lit(:)],_7267,_7269) --> 
    w(noun(question,sin,u,n),_7278,_7267,_7295),
    cc(:,_7295,_7269).

grums([grums,lit(svar),_7286],_7264,_7266) --> 
    cc(svar,_7264,_7285),
    optional([:],_7286,_7285,_7266).

grums([grums,lit(n),lit(:)],_7262,_7264) --> 
    cc(n,_7262,_7283),
    cc(:,_7283,_7264).

grums([grums,_7279,_7308,!],_7268,_7270) --> 
    w(noun(traffic,sin,u,n),_7279,_7268,_7296),
    colon(_7308,_7296,_7270),
    !.

grums([grums,_7275,lit(tt)],_7264,_7266) --> 
    not_look_ahead([dere],_7275,_7264,_7292),
    cc(tt,_7292,_7266).

grums([grums,lit('så'),_7290,!],_7268,_7270) --> 
    cc('så',_7268,_7289),
    w(adj2(funny,nil),_7290,_7289,_7270),
    !.

grums([grums,lit('så'),_7282],_7260,_7262) --> 
    cc('så',_7260,_7281),
    not_look_ahead_vp(_7282,_7281,_7262).

grums([grums,lit(ja),lit('så'),_7298],_7265,_7267) --> 
    cc(ja,_7265,_7286),
    cc('så',_7286,_7297),
    not_look_ahead_vp(_7298,_7297,_7267).

grums([grums,lit(nb),_7290],_7268,_7270) --> 
    cc(nb,_7268,_7289),
    one_of_lit(['.',:,!],_7290,_7289,_7270).

grums([grums,lit(obs),_7290],_7268,_7270) --> 
    cc(obs,_7268,_7289),
    one_of_lit(['.',:,!],_7290,_7289,_7270).

grums([grums,lit(unnskyld),lit(men)],_7262,_7264) --> 
    cc(unnskyld,_7262,_7283),
    cc(men,_7283,_7264).

grums([grums,lit(ok),_7290],_7268,_7270) --> 
    cc(ok,_7268,_7289),
    look_ahead(w(verb(_7247,imp,fin)),_7290,_7289,_7270).

grums([grums,lit(supert)],_7257,_7259) --> 
    cc(supert,_7257,_7259).

team([team,_7272],_7261,_7263) --> 
    w(name(team,_7243,_7244),_7272,_7261,_7263).

team([team,lit(team)],_7257,_7259) --> 
    cc(team,_7257,_7259).

hellos([hellos,_7272,_7296,_7320],_7261,_7263) --> 
    hello(_7272,_7261,_7287),
    sludder0(_7296,_7287,_7311),
    hellos0(_7320,_7311,_7263).

hellos0([hellos0,_7266],_7255,_7257) --> 
    hellos(_7266,_7255,_7257).

hellos0([hellos0,[]],_7255,_7255) --> 
    [].

adj0([adj0,_7277,!,_7311],_7266,_7268) --> 
    w(adj2(_7248,_7249),_7277,_7266,_7294),
    !,
    accept(_7311,_7294,_7268).

adj0([adj0,[]],_7255,_7255) --> 
    [].

hei([hei,lit(hei),_7282],_7260,_7262) --> 
    cc(hei,_7260,_7281),
    der0(_7282,_7281,_7262).

hei([hei,lit(hallo),_7282],_7260,_7262) --> 
    cc(hallo,_7260,_7281),
    der0(_7282,_7281,_7262).

sludder0([sludder0,_7269,!],_7258,_7260) --> 
    sludder(_7269,_7258,_7260),
    !.

sludder0([sludder0,[]],_7255,_7255) --> 
    [].

sludder([sludder,lit(alle),lit(sammen),!],_7265,_7267) --> 
    cc(alle,_7265,_7286),
    cc(sammen,_7286,_7267),
    !.

sludder([sludder,lit(der),!],_7260,_7262) --> 
    cc(der,_7260,_7262),
    !.

sludder([sludder,lit(du),_7293,!],_7271,_7273) --> 
    cc(du,_7271,_7292),
    not_look_ahead(w(verb(_7252,_7253,_7254)),_7293,_7292,_7273),
    !.

sludder([sludder,_7286,_7315,!],_7275,_7277) --> 
    w(name(tuc,n,_7250),_7286,_7275,_7303),
    not_look_ahead(w(verb(_7256,_7257,_7258)),_7315,_7303,_7277),
    !.

sludder([sludder,_7275,!],_7264,_7266) --> 
    w(name(bustuc,n,_7247),_7275,_7264,_7266),
    !.

sludder([sludder,_7275,!],_7264,_7266) --> 
    w(name(tt,n,_7247),_7275,_7264,_7266),
    !.

sludder([sludder,_7275,!],_7264,_7266) --> 
    w(name(tagore,n,_7247),_7275,_7264,_7266),
    !.

sludder([sludder,_7275,!],_7264,_7266) --> 
    w(name(tore,n,_7247),_7275,_7264,_7266),
    !.

sludder([sludder,_7276,!],_7265,_7267) --> 
    w(noun(computer,sin,u,n),_7276,_7265,_7267),
    !.

sludder([sludder,_7276,!],_7265,_7267) --> 
    w(noun(oracle,sin,_7247,n),_7276,_7265,_7267),
    !.

sludder([sludder,_7276,!],_7265,_7267) --> 
    w(noun(man,sin,u,n),_7276,_7265,_7267),
    !.

sludder([sludder,_7276,!],_7265,_7267) --> 
    w(noun(sweetheart,sin,u,n),_7276,_7265,_7267),
    !.

okeys0([okeys0,_7266],_7255,_7257) --> 
    okeys(_7266,_7255,_7257).

okeys0([okeys0,[]],_7255,_7255) --> 
    [].

okeys([okeys,lit(ok),_7296,_7340,_7384],_7274,_7276) --> 
    cc(ok,_7274,_7295),
    optional([ja],_7296,_7295,_7328),
    optional([men],_7340,_7328,_7372),
    optoken(_7384,_7372,_7276).

hello([hello,lit(bra)],_7257,_7259) --> 
    cc(bra,_7257,_7259).

hello([hello,_7266],_7255,_7257) --> 
    okeys(_7266,_7255,_7257).

hello([hello,_7274,_7298,_7342],_7263,_7265) --> 
    hei(_7274,_7263,_7289),
    optional(paadeg,_7298,_7289,_7330),
    sludder0(_7342,_7330,_7265).

hello([hello,lit(goddag)],_7257,_7259) --> 
    cc(goddag,_7257,_7259).

hello([hello,_7299,_7328,{}],_7288,_7290) --> 
    w(adj2(good,nil),_7299,_7288,_7316),
    w(noun(_7248,_7269,_7270,_7271),_7328,_7316,_7290),
    {user:testmember(_7248,[day,morning,evening,night,afternoon])}.

paadeg([paadeg,_7279,lit(deg),!,_7324],_7268,_7270) --> 
    prep1(on,_7279,_7268,_7296),
    cc(deg,_7296,_7318),
    !,
    accept(_7324,_7318,_7270).

paadeg([paadeg,lit(og),lit('hå'),!,_7306],_7268,_7270) --> 
    cc(og,_7268,_7289),
    cc('hå',_7289,_7300),
    !,
    accept(_7306,_7300,_7270).

forhjelpen0([forhjelpen0,_7276,lit(alt),!],_7265,_7267) --> 
    prep1(for,_7276,_7265,_7293),
    cc(alt,_7293,_7267),
    !.

forhjelpen0([forhjelpen0,_7287,_7316,_7345,!],_7276,_7278) --> 
    prep1(for,_7287,_7276,_7304),
    w(noun(_7253,sin,def,n),_7316,_7304,_7333),
    np1(_7258,_7259,_7345,_7333,_7278),
    !.

forhjelpen0([forhjelpen0,_7281,_7310,!],_7270,_7272) --> 
    prep1(for,_7281,_7270,_7298),
    w(noun(_7250,sin,def,n),_7310,_7298,_7272),
    !.

forhjelpen0([forhjelpen0,_7277,_7306,!],_7266,_7268) --> 
    prep1(for,_7277,_7266,_7294),
    np1(_7248,_7249,_7306,_7294,_7268),
    !.

forhjelpen0([forhjelpen0,lit(skal),lit(du),_7304],_7271,_7273) --> 
    cc(skal,_7271,_7292),
    cc(du,_7292,_7303),
    w(verb(have,imp,fin),_7304,_7303,_7273).

forhjelpen0([forhjelpen0,[]],_7255,_7255) --> 
    [].

hadet([hadet,lit(ha),lit(de),_7298],_7265,_7267) --> 
    cc(ha,_7265,_7286),
    cc(de,_7286,_7297),
    paabadet0(_7298,_7297,_7267).

hadet([hadet,lit(ha),lit(det),_7298],_7265,_7267) --> 
    cc(ha,_7265,_7286),
    cc(det,_7286,_7297),
    paabadet0(_7298,_7297,_7267).

hadet([hadet,lit(hadet),_7282],_7260,_7262) --> 
    cc(hadet,_7260,_7281),
    paabadet0(_7282,_7281,_7262).

hadet([hadet,lit(hade),_7282],_7260,_7262) --> 
    cc(hade,_7260,_7281),
    paabadet0(_7282,_7281,_7262).

kan([kan,_7272],_7261,_7263) --> 
    w(verb(know,_7243,fin),_7272,_7261,_7263).

kan([kan,lit(kan)],_7257,_7259) --> 
    cc(kan,_7257,_7259).

paabadet0([paabadet0,_7279,lit(badet),!,_7324],_7268,_7270) --> 
    prep1(on,_7279,_7268,_7296),
    cc(badet,_7296,_7318),
    !,
    accept(_7324,_7318,_7270).

paabadet0([paabadet0,[]],_7255,_7255) --> 
    [].

quit(thanks,[quit,_7291,_7320,!],_7277,_7279) --> 
    w(adj2(good,nil),_7291,_7277,_7308),
    w(noun(trip,sin,u,n),_7320,_7308,_7279),
    !.

quit(bye,[quit,_7282,_7311],_7268,_7270) --> 
    w(verb(hear,pres,pass),_7282,_7268,_7299),
    skip_rest(_7311,_7299,_7270).

quit(bye,[quit,_7282,_7311],_7268,_7270) --> 
    w(verb(see,pres,pass),_7282,_7268,_7299),
    skip_rest(_7311,_7299,_7270).

quit(bye,[quit,_7282,_7311],_7268,_7270) --> 
    w(verb(tals,pres,pass),_7282,_7268,_7299),
    skip_rest(_7311,_7299,_7270).

quit(bye,[quit,lit(med),lit(vennlig),_7315,_7344],_7279,_7281) --> 
    cc(med,_7279,_7303),
    cc(vennlig,_7303,_7314),
    w(noun(greeting,_7258,_7259,_7260),_7315,_7314,_7332),
    skip_rest(_7344,_7332,_7281).

quit(bye,[quit,lit(vennlig),_7299,_7328],_7274,_7276) --> 
    cc(vennlig,_7274,_7298),
    w(noun(greeting,_7253,_7254,_7255),_7299,_7298,_7316),
    skip_rest(_7328,_7316,_7276).

quit(bye,[quit,_7283,_7312],_7269,_7271) --> 
    w(noun(greeting,_7248,_7249,_7250),_7283,_7269,_7300),
    skip_rest(_7312,_7300,_7271).

quit(bye,[quit,_7280],_7266,_7268) --> 
    w(noun(midnight,plu,def,n),_7280,_7266,_7268).

quit(bye,[quit,lit(jeg),lit(snakkes),_7305],_7269,_7271) --> 
    cc(jeg,_7269,_7293),
    cc(snakkes,_7293,_7304),
    skip_rest(_7305,_7304,_7271).

quit(bye,[quit,_7279],_7265,_7267) --> 
    w(verb(stop,imp,_7246),_7279,_7265,_7267).

quit(bye,[quit,lit('adjø')],_7261,_7263) --> 
    cc('adjø',_7261,_7263).

quit(bye,[quit,lit('på'),lit(gjensyn)],_7266,_7268) --> 
    cc('på',_7266,_7290),
    cc(gjensyn,_7290,_7268).

quit(bye,[quit,_7273],_7259,_7261) --> 
    hadet(_7273,_7259,_7261).

quit(bye,[quit,_7276,_7300],_7262,_7264) --> 
    hadet(_7276,_7262,_7291),
    godt(_7300,_7291,_7264).

quit(bye,[quit,lit(hei),lit(da)],_7266,_7268) --> 
    cc(hei,_7266,_7290),
    cc(da,_7290,_7268).

quit(bye,[quit,lit(godnatt)],_7261,_7263) --> 
    cc(godnatt,_7261,_7263).

quit(bye,[quit,_7302,_7326,_7350,{}],_7288,_7290) --> 
    haen0(_7302,_7288,_7317),
    godt(_7326,_7317,_7341),
    w(noun(_7253,_7267,_7268,_7269),_7350,_7341,_7290),
    {user:testmember(_7253,[midnight,weekend,easter,summer])}.

quit(bye,[quit,lit(takk),_7306,_7335,_7364],_7281,_7283) --> 
    cc(takk,_7281,_7305),
    prep1(for,_7306,_7305,_7323),
    prep1(in,_7335,_7323,_7352),
    w(noun(day,sin,u,n),_7364,_7352,_7283).

quit(bye,[quit,_7292,_7316,_7345],_7278,_7280) --> 
    good0(_7292,_7278,_7307),
    w(noun(greeting,_7257,_7258,_7259),_7316,_7307,_7333),
    w(name(_7250,_7251,_7252),_7345,_7333,_7280).

quit(bye,[quit,_7293,_7317,_7346],_7279,_7281) --> 
    good0(_7293,_7279,_7308),
    w(noun(greeting,_7258,_7259,_7260),_7317,_7308,_7334),
    w(noun(_7250,_7251,_7252,_7253),_7346,_7334,_7281).

quit(bye,[quit,lit(far),lit(vel)],_7266,_7268) --> 
    cc(far,_7266,_7290),
    cc(vel,_7290,_7268).

quit(bye,[quit,_7302,_7346,lit(en),_7386,_7410],_7288,_7290) --> 
    optional(hello,_7302,_7288,_7334),
    w(verb(have,imp,_7267),_7346,_7334,_7363),
    cc(en,_7363,_7385),
    godt(_7386,_7385,_7401),
    w(noun(_7256,_7257,_7258,_7259),_7410,_7401,_7290).

quit(you_are_welcome,[quit,lit('på'),lit('forhånd'),_7308,!],_7272,_7274) --> 
    cc('på',_7272,_7296),
    cc('forhånd',_7296,_7307),
    thanks(_7308,_7307,_7274),
    !.

quit(you_are_welcome,[quit,_7284,_7313,!],_7270,_7272) --> 
    w(nb(1000,_7251),_7284,_7270,_7301),
    thanks(_7313,_7301,_7272),
    !.

quit(you_are_welcome,[quit,_7276,_7300],_7262,_7264) --> 
    thanks(_7276,_7262,_7291),
    alot(_7300,_7291,_7264).

quit(you_are_welcome,[quit,_7302,lit('å'),_7342,_7371,lit(deg)],_7288,_7290) --> 
    w(adj2(nice,nil),_7302,_7288,_7319),
    cc('å',_7319,_7341),
    w(verb(speak,_7266,_7267),_7342,_7341,_7359),
    prep1(with,_7371,_7359,_7388),
    cc(deg,_7388,_7290).

quit(merry_christmas,[quit,_7278,lit(jul)],_7264,_7266) --> 
    godt(_7278,_7264,_7293),
    cc(jul,_7293,_7266).

quit(happy_new_year,[quit,_7276,_7300],_7262,_7264) --> 
    godt(_7276,_7262,_7291),
    newyear(_7300,_7291,_7264).

quit(bye,[quit,lit(hilsen),_7289],_7264,_7266) --> 
    cc(hilsen,_7264,_7288),
    skip_rest(_7289,_7288,_7266).

alot([alot,[]],_7255,_7255) --> 
    [].

alot([alot,lit('så'),lit(mye)],_7262,_7264) --> 
    cc('så',_7262,_7283),
    cc(mye,_7283,_7264).

alot([alot,lit('så'),lit(meget)],_7262,_7264) --> 
    cc('så',_7262,_7283),
    cc(meget,_7283,_7264).

alot([alot,lit(skal),lit(du),_7304],_7271,_7273) --> 
    cc(skal,_7271,_7292),
    cc(du,_7292,_7303),
    w(verb(have,inf,fin),_7304,_7303,_7273).

godt([godt,_7271],_7260,_7262) --> 
    w(adj2(good,nil),_7271,_7260,_7262).

godt([godt,_7272],_7261,_7263) --> 
    w(verb(go,past,part),_7272,_7261,_7263).

godt([godt,_7281,_7310],_7270,_7272) --> 
    w(adj2(good,nil),_7281,_7270,_7298),
    w(noun(day,sin,u,n),_7310,_7298,_7272).

deter0([deter0,_7272,!,_7301],_7261,_7263) --> 
    deter(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

deter0([deter0,_7272,!,_7301],_7261,_7263) --> 
    endofline(_7272,_7261,_7287),
    !,
    reject(_7301,_7287,_7263).

deter0([deter0,[]],_7255,_7255) --> 
    [].

deter([deter,lit(det),_7288,!,_7317],_7266,_7268) --> 
    cc(det,_7266,_7287),
    be(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

deter([deter,lit(dette),_7288,!,_7317],_7266,_7268) --> 
    cc(dette,_7266,_7287),
    be(_7288,_7287,_7303),
    !,
    accept(_7317,_7303,_7268).

haen0([haen0,lit(ha),lit(en),!,_7306],_7268,_7270) --> 
    cc(ha,_7268,_7289),
    cc(en,_7289,_7300),
    !,
    accept(_7306,_7300,_7270).

haen0([haen0,[]],_7255,_7255) --> 
    [].

personal('Takk',[personal,lit(velkommen),lit(til),!,_7313],_7272,_7274) --> 
    cc(velkommen,_7272,_7296),
    cc(til,_7296,_7307),
    !,
    skip_rest(_7313,_7307,_7274).

personal('Takk',[personal,lit(velkommen)],_7261,_7263) --> 
    cc(velkommen,_7261,_7263).

personal('Takk',[personal,lit(god),_7296],_7271,_7273) --> 
    cc(god,_7271,_7295),
    w(noun(health,sin,u,n),_7296,_7295,_7273).

personal('OK',[personal,lit(ps)],_7261,_7263) --> 
    cc(ps,_7261,_7263).

personal('OK',[personal,_7281,_7325,_7349],_7267,_7269) --> 
    optional(hello,_7281,_7267,_7313),
    so0(_7325,_7313,_7340),
    persok(_7349,_7340,_7269).

persok([persok,_7266],_7255,_7257) --> 
    okeys(_7266,_7255,_7257).

persok([persok,_7272],_7261,_7263) --> 
    w(verb(test,imp,fin),_7272,_7261,_7263).

persok([persok,lit(bra),_7282],_7260,_7262) --> 
    cc(bra,_7260,_7281),
    endofline(_7282,_7281,_7262).

persok([persok,lit(sorry)],_7257,_7259) --> 
    cc(sorry,_7257,_7259).

persok([persok,_7285,lit('så'),_7325],_7274,_7276) --> 
    w(verb(be,imp,fin),_7285,_7274,_7302),
    cc('så',_7302,_7324),
    w(adj2(good,nil),_7325,_7324,_7276).

persok([persok,_7277,lit(det)],_7266,_7268) --> 
    w(verb(forget,imp,fin),_7277,_7266,_7294),
    cc(det,_7294,_7268).

persok([persok,_7281,_7310],_7270,_7272) --> 
    w(verb(forget,imp,fin),_7281,_7270,_7298),
    np(_7243,_7246:_7247,_7310,_7298,_7272).

persok([persok,_7283,lit(du),_7323,_7347],_7272,_7274) --> 
    w(verb(be,_7252,fin),_7283,_7272,_7300),
    cc(du,_7300,_7322),
    good(_7323,_7322,_7338),
    dadanow0(_7347,_7338,_7274).

persok([persok,lit(unnskyld)],_7257,_7259) --> 
    cc(unnskyld,_7257,_7259).

persok([persok,lit(hvordan),_7301,lit(du),lit(det),_7352],_7279,_7281) --> 
    cc(hvordan,_7279,_7300),
    w(verb(have,_7257,fin),_7301,_7300,_7318),
    cc(du,_7318,_7340),
    cc(det,_7340,_7351),
    dadanow0(_7352,_7351,_7281).

persok([persok,lit(hvordan),_7304,lit(det),_7344,_7373,_7397],_7282,_7284) --> 
    cc(hvordan,_7282,_7303),
    w(verb(stand,pres,fin),_7304,_7303,_7321),
    cc(det,_7321,_7343),
    prep1(to,_7344,_7343,_7361),
    withyou0(_7373,_7361,_7388),
    dadanow0(_7397,_7388,_7284).

persok([persok,_7296,lit(det),_7336,_7365,_7394,_7418],_7285,_7287) --> 
    w(verb(stand,pres,fin),_7296,_7285,_7313),
    cc(det,_7313,_7335),
    w(adj2(good,nil),_7336,_7335,_7353),
    prep1(to,_7365,_7353,_7382),
    withyou0(_7394,_7382,_7409),
    dadanow0(_7418,_7409,_7287).

persok([persok,_7277,_7306],_7266,_7268) --> 
    w(verb(stand,pres,fin),_7277,_7266,_7294),
    prep1(to,_7306,_7294,_7268).

persok([persok,lit(hvordan),_7292,_7316],_7270,_7272) --> 
    cc(hvordan,_7270,_7291),
    be(_7292,_7291,_7307),
    w(noun(situation,sin,def,n),_7316,_7307,_7272).

persok([persok,lit(hva),_7292,_7316],_7270,_7272) --> 
    cc(hva,_7270,_7291),
    be(_7292,_7291,_7307),
    w(noun(situation,sin,def,n),_7316,_7307,_7272).

persok([persok,_7293,lit(du),lit(det),_7344,_7373],_7282,_7284) --> 
    w(verb(have,_7255,fin),_7293,_7282,_7310),
    cc(du,_7310,_7332),
    cc(det,_7332,_7343),
    w(adj2(_7264,nil),_7344,_7343,_7361),
    dadanow0(_7373,_7361,_7284).

persok([persok,lit(jeg),_7307,lit(det),_7347,_7376,_7400,_7424],_7285,_7287) --> 
    cc(jeg,_7285,_7306),
    w(verb(have,_7263,fin),_7307,_7306,_7324),
    cc(det,_7324,_7346),
    negation0(_7268,_7347,_7346,_7364),
    so0(_7376,_7364,_7391),
    good(_7400,_7391,_7415),
    dadanow0(_7424,_7415,_7287).

persok([persok,lit(hvordan),_7299,lit(det),_7339,_7363],_7277,_7279) --> 
    cc(hvordan,_7277,_7298),
    w(verb(go,pres,fin),_7299,_7298,_7316),
    cc(det,_7316,_7338),
    withyou0(_7339,_7338,_7354),
    dadanow0(_7363,_7354,_7279).

persok([persok,_7298,lit(det),_7338,_7382,_7411,_7435],_7287,_7289) --> 
    w(verb(go,pres,fin),_7298,_7287,_7315),
    cc(det,_7315,_7337),
    optional([ikke],_7338,_7337,_7370),
    w(adj2(good,nil),_7382,_7370,_7399),
    withyou0(_7411,_7399,_7426),
    dadanow0(_7435,_7426,_7289).

persok([persok,lit(greitt)],_7257,_7259) --> 
    cc(greitt,_7257,_7259).

persok([persok,_7274,_7303],_7263,_7265) --> 
    w(adj2(good,nil),_7274,_7263,_7291),
    endofline(_7303,_7291,_7265).

thanks([thanks,_7275,_7299,_7323,_7347],_7264,_7266) --> 
    ogmen0(_7275,_7264,_7290),
    thousands0(_7299,_7290,_7314),
    takk(_7323,_7314,_7338),
    forhjelpen0(_7347,_7338,_7266).

takk([takk,_7271,lit(takk)],_7260,_7262) --> 
    hellos0(_7271,_7260,_7286),
    cc(takk,_7286,_7262).

takk([takk,_7272],_7261,_7263) --> 
    w(verb(thank,pres,fin),_7272,_7261,_7263).

takk([takk,lit(jeg),lit(vil),_7304],_7271,_7273) --> 
    cc(jeg,_7271,_7292),
    cc(vil,_7292,_7303),
    w(verb(thank,inf,_7250),_7304,_7303,_7273).

ogmen0([ogmen0,lit(og),!,_7290],_7263,_7265) --> 
    cc(og,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

ogmen0([ogmen0,lit(men),!,_7290],_7263,_7265) --> 
    cc(men,_7263,_7284),
    !,
    accept(_7290,_7284,_7265).

ogmen0([ogmen0,[]],_7255,_7255) --> 
    [].

thousands0([thousands0,_7272,!,_7301],_7261,_7263) --> 
    thousand(_7272,_7261,_7287),
    !,
    thousands0(_7301,_7287,_7263).

thousands0([thousands0,[]],_7255,_7255) --> 
    [].

thousand0([thousand0,_7272,!,_7301],_7261,_7263) --> 
    thousand(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

thousand0([thousand0,[]],_7255,_7255) --> 
    [].

thousand([thousand,_7277,!,_7311],_7266,_7268) --> 
    number(1000:_7249,_7277,_7266,_7294),
    !,
    accept(_7311,_7294,_7268).

thousand([thousand,_7266],_7255,_7257) --> 
    many1(_7266,_7255,_7257).

withyou0([withyou0,_7279,lit(_7250),!,_7324],_7268,_7270) --> 
    prep1(with,_7279,_7268,_7296),
    cc(_7250,_7296,_7318),
    !,
    accept(_7324,_7318,_7270).

withyou0([withyou0,[]],_7255,_7255) --> 
    [].

dadanow0([dadanow0,_7269,_7293],_7258,_7260) --> 
    todax(_7269,_7258,_7284),
    danow0(_7293,_7284,_7260).

dadanow0([dadanow0,_7266],_7255,_7257) --> 
    danow0(_7266,_7255,_7257).

danow0([danow0,_7281,_7310,lit('nå'),!],_7270,_7272) --> 
    look_ahead(['nå'],_7281,_7270,_7298),
    notreachphrase(_7310,_7298,_7325),
    cc('nå',_7325,_7272),
    !.

danow0([danow0,[]],_7255,_7255) --> 
    [].

notreachphrase([notreachphrase,_7272,!,_7301],_7261,_7263) --> 
    reachphrase(_7272,_7261,_7287),
    !,
    reject(_7301,_7287,_7263).

notreachphrase([notreachphrase,[]],_7255,_7255) --> 
    [].

reachphrase([reachphrase,_7278,_7307,!],_7267,_7269) --> 
    w(verb(reach,inf,fin),_7278,_7267,_7295),
    look_ahead_np(_7307,_7295,_7269),
    !.

danow0([danow0,_7269,!],_7258,_7260) --> 
    danow(_7269,_7258,_7260),
    !.

danow0([danow0,[]],_7255,_7255) --> 
    [].

danow([danow,_7276,_7305,!],_7265,_7267) --> 
    w(adv(now),_7276,_7265,_7293),
    danow(_7305,_7293,_7267),
    !.

danow([danow,_7270],_7259,_7261) --> 
    w(adv(now),_7270,_7259,_7261).

danow([danow,lit(da),_7282],_7260,_7262) --> 
    cc(da,_7260,_7281),
    danow(_7282,_7281,_7262).

todax([todax,_7272,!,_7301],_7261,_7263) --> 
    today(_7272,_7261,_7287),
    !,
    accept(_7301,_7287,_7263).

todax([todax,_7279,lit('går'),!,_7324],_7268,_7270) --> 
    prep1(in,_7279,_7268,_7296),
    cc('går',_7296,_7318),
    !,
    accept(_7324,_7318,_7270).

good0([good0,_7275,_7299,!,_7328],_7264,_7266) --> 
    so0(_7275,_7264,_7290),
    good(_7299,_7290,_7314),
    !,
    accept(_7328,_7314,_7266).

good0([good0,[]],_7255,_7255) --> 
    [].

good([good,_7271],_7260,_7262) --> 
    w(adj2(good,nil),_7271,_7260,_7262).

good([good,_7271],_7260,_7262) --> 
    w(adj2(clever,nil),_7271,_7260,_7262).

good([good,_7271],_7260,_7262) --> 
    w(adj2(fast,nil),_7271,_7260,_7262).

good([good,_7271],_7260,_7262) --> 
    w(adj2(funny,nil),_7271,_7260,_7262).

good([good,_7271],_7260,_7262) --> 
    w(adj2(honest,nil),_7271,_7260,_7262).

good([good,_7271],_7260,_7262) --> 
    w(adj2(nice,nil),_7271,_7260,_7262).

good([good,_7266],_7255,_7257) --> 
    okeys(_7266,_7255,_7257).

gmem(_7240,_7241,[gmem,{}],_7267,_7267) --> 
    {user:testmember(_7240,_7241)}.

panic(_7240,[panic,{}],_7263,_7263) --> 
    {user:write(_7240)}.

traceprint(_7240,_7241,[traceprint,{}],_7267,_7267) --> 
    {user:traceprint(_7240,_7241)}.

% Auxillary tables created datetime(2012,1,19,21,29,42)

%% Automatically created by metacomp.pl, based on dict and tuc/gram_...

:- ensure_loaded(declare). %% RS-111213 General (semantic) Operators

optional(itrailer,[optional,_7491,!],_7477,_7479) --> 
    itrailer(_7491,_7477,_7479),
    !.

optional([kanskje],[optional,lit(kanskje),!],_7479,_7481) --> 
    cc(kanskje,_7479,_7481),
    !.

optional([at],[optional,lit(at),!],_7479,_7481) --> 
    cc(at,_7479,_7481),
    !.

optional(grums,[optional,_7491,!],_7477,_7479) --> 
    grums(_7491,_7477,_7479),
    !.

optional(grums,[optional,_7491,!],_7477,_7479) --> 
    grums(_7491,_7477,_7479),
    !.

optional([ofte],[optional,lit(ofte),!],_7479,_7481) --> 
    cc(ofte,_7479,_7481),
    !.

optional([som],[optional,lit(som),!],_7479,_7481) --> 
    cc(som,_7479,_7481),
    !.

optional([','],[optional,lit(','),!],_7479,_7481) --> 
    cc(',',_7479,_7481),
    !.

optional([at],[optional,lit(at),!],_7479,_7481) --> 
    cc(at,_7479,_7481),
    !.

optional([meget],[optional,lit(meget),!],_7479,_7481) --> 
    cc(meget,_7479,_7481),
    !.

optional([det],[optional,lit(det),!],_7479,_7481) --> 
    cc(det,_7479,_7481),
    !.

optional(['å'],[optional,lit('å'),!],_7479,_7481) --> 
    cc('å',_7479,_7481),
    !.

optional(['å'],[optional,lit('å'),!],_7479,_7481) --> 
    cc('å',_7479,_7481),
    !.

optional([an],[optional,lit(an),!],_7479,_7481) --> 
    cc(an,_7479,_7481),
    !.

optional([ut],[optional,lit(ut),!],_7479,_7481) --> 
    cc(ut,_7479,_7481),
    !.

optional([neste],[optional,lit(neste),!],_7479,_7481) --> 
    cc(neste,_7479,_7481),
    !.

optional([det],[optional,lit(det),!],_7479,_7481) --> 
    cc(det,_7479,_7481),
    !.

optional(itrailer,[optional,_7491,!],_7477,_7479) --> 
    itrailer(_7491,_7477,_7479),
    !.

optional(itrailer,[optional,_7491,!],_7477,_7479) --> 
    itrailer(_7491,_7477,_7479),
    !.

optional([alle],[optional,lit(alle),!],_7479,_7481) --> 
    cc(alle,_7479,_7481),
    !.

optional([at],[optional,lit(at),!],_7479,_7481) --> 
    cc(at,_7479,_7481),
    !.

optional([som],[optional,lit(som),!],_7479,_7481) --> 
    cc(som,_7479,_7481),
    !.

optional([gang],[optional,lit(gang),!],_7479,_7481) --> 
    cc(gang,_7479,_7481),
    !.

optional(much,[optional,_7491,!],_7477,_7479) --> 
    much(_7491,_7477,_7479),
    !.

optional(w(verb(be,inf,fin)),[optional,_7497,!],_7483,_7485) --> 
    w(verb(be,inf,fin),_7497,_7483,_7485),
    !.

optional(w(adj2(old,nil)),[optional,_7496,!],_7482,_7484) --> 
    w(adj2(old,nil),_7496,_7482,_7484),
    !.

optional([om],[optional,lit(om),!],_7479,_7481) --> 
    cc(om,_7479,_7481),
    !.

optional([for],[optional,lit(for),!],_7479,_7481) --> 
    cc(for,_7479,_7481),
    !.

optional(['på'],[optional,lit('på'),!],_7479,_7481) --> 
    cc('på',_7479,_7481),
    !.

optional([om],[optional,lit(om),!],_7479,_7481) --> 
    cc(om,_7479,_7481),
    !.

optional(['på'],[optional,lit('på'),!],_7479,_7481) --> 
    cc('på',_7479,_7481),
    !.

optional([om],[optional,lit(om),!],_7479,_7481) --> 
    cc(om,_7479,_7481),
    !.

optional(['å'],[optional,lit('å'),!],_7479,_7481) --> 
    cc('å',_7479,_7481),
    !.

optional(['på'],[optional,lit('på'),!],_7479,_7481) --> 
    cc('på',_7479,_7481),
    !.

optional(['på'],[optional,lit('på'),!],_7479,_7481) --> 
    cc('på',_7479,_7481),
    !.

optional(['å'],[optional,lit('å'),!],_7479,_7481) --> 
    cc('å',_7479,_7481),
    !.

optional([til],[optional,lit(til),!],_7479,_7481) --> 
    cc(til,_7479,_7481),
    !.

optional([da],[optional,lit(da),!],_7479,_7481) --> 
    cc(da,_7479,_7481),
    !.

optional([bare],[optional,lit(bare),!],_7479,_7481) --> 
    cc(bare,_7479,_7481),
    !.

optional(w(prep(_7460)),[optional,_7495,!],_7481,_7483) --> 
    w(prep(_7460),_7495,_7481,_7483),
    !.

optional([til],[optional,lit(til),!],_7479,_7481) --> 
    cc(til,_7479,_7481),
    !.

optional([med],[optional,lit(med),!],_7479,_7481) --> 
    cc(med,_7479,_7481),
    !.

optional(['på'],[optional,lit('på'),!],_7479,_7481) --> 
    cc('på',_7479,_7481),
    !.

optional(w(noun(year,_7461,_7462,n)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(year,_7461,_7462,n),_7498,_7484,_7486),
    !.

optional(w(prep(in)),[optional,_7495,!],_7481,_7483) --> 
    w(prep(in),_7495,_7481,_7483),
    !.

optional(w(noun(year,sin,u,n)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(year,sin,u,n),_7498,_7484,_7486),
    !.

optional([i],[optional,lit(i),!],_7479,_7481) --> 
    cc(i,_7479,_7481),
    !.

optional([i],[optional,lit(i),!],_7479,_7481) --> 
    cc(i,_7479,_7481),
    !.

optional([i],[optional,lit(i),!],_7479,_7481) --> 
    cc(i,_7479,_7481),
    !.

optional(['.'],[optional,lit('.'),!],_7479,_7481) --> 
    cc('.',_7479,_7481),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(time,sin,def,n),_7498,_7484,_7486),
    !.

optional(['nå'],[optional,lit('nå'),!],_7479,_7481) --> 
    cc('nå',_7479,_7481),
    !.

optional([denne],[optional,lit(denne),!],_7479,_7481) --> 
    cc(denne,_7479,_7481),
    !.

optional(w(noun(route,sin,u,n)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(route,sin,u,n),_7498,_7484,_7486),
    !.

optional(w(noun(route,sin,u,n)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(route,sin,u,n),_7498,_7484,_7486),
    !.

optional(w(noun(bus,sin,_7462,_7463)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(bus,sin,_7462,_7463),_7498,_7484,_7486),
    !.

optional([for],[optional,lit(for),!],_7479,_7481) --> 
    cc(for,_7479,_7481),
    !.

optional([til],[optional,lit(til),!],_7479,_7481) --> 
    cc(til,_7479,_7481),
    !.

optional([av],[optional,lit(av),!],_7479,_7481) --> 
    cc(av,_7479,_7481),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(time,sin,def,n),_7498,_7484,_7486),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(time,sin,def,n),_7498,_7484,_7486),
    !.

optional(w(noun(time,_7461,def,_7463)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(time,_7461,def,_7463),_7498,_7484,_7486),
    !.

optional(w(prep(in)),[optional,_7495,!],_7481,_7483) --> 
    w(prep(in),_7495,_7481,_7483),
    !.

optional(w(noun(time,sin,def,n)),[optional,_7498,!],_7484,_7486) --> 
    w(noun(time,sin,def,n),_7498,_7484,_7486),
    !.

optional([h],[optional,lit(h),!],_7479,_7481) --> 
    cc(h,_7479,_7481),
    !.

optional([opp],[optional,lit(opp),!],_7479,_7481) --> 
    cc(opp,_7479,_7481),
    !.

optional([om],[optional,lit(om),!],_7479,_7481) --> 
    cc(om,_7479,_7481),
    !.

optional([mye],[optional,lit(mye),!],_7479,_7481) --> 
    cc(mye,_7479,_7481),
    !.

optional([nr],[optional,lit(nr),!],_7479,_7481) --> 
    cc(nr,_7479,_7481),
    !.

optional([slik],[optional,lit(slik),!],_7479,_7481) --> 
    cc(slik,_7479,_7481),
    !.

optional(['så'],[optional,lit('så'),!],_7479,_7481) --> 
    cc('så',_7479,_7481),
    !.

optional(be,[optional,_7491,!],_7477,_7479) --> 
    be(_7491,_7477,_7479),
    !.

optional([at],[optional,lit(at),!],_7479,_7481) --> 
    cc(at,_7479,_7481),
    !.

optional([at],[optional,lit(at),!],_7479,_7481) --> 
    cc(at,_7479,_7481),
    !.

optional([seg],[optional,lit(seg),!],_7479,_7481) --> 
    cc(seg,_7479,_7481),
    !.

optional([at],[optional,lit(at),!],_7479,_7481) --> 
    cc(at,_7479,_7481),
    !.

optional(w(adj2(great,nil)),[optional,_7496,!],_7482,_7484) --> 
    w(adj2(great,nil),_7496,_7482,_7484),
    !.

optional(w(adj2(_7460,nil)),[optional,_7496,!],_7482,_7484) --> 
    w(adj2(_7460,nil),_7496,_7482,_7484),
    !.

optional(w(adj2(_7460,nil)),[optional,_7496,!],_7482,_7484) --> 
    w(adj2(_7460,nil),_7496,_7482,_7484),
    !.

optional(w(adj2(_7460,nil)),[optional,_7496,!],_7482,_7484) --> 
    w(adj2(_7460,nil),_7496,_7482,_7484),
    !.

optional([med],[optional,lit(med),!],_7479,_7481) --> 
    cc(med,_7479,_7481),
    !.

optional(sometimes,[optional,_7491,!],_7477,_7479) --> 
    sometimes(_7491,_7477,_7479),
    !.

optional([ofte],[optional,lit(ofte),!],_7479,_7481) --> 
    cc(ofte,_7479,_7481),
    !.

optional([bare],[optional,lit(bare),!],_7479,_7481) --> 
    cc(bare,_7479,_7481),
    !.

optional(grums,[optional,_7491,!],_7477,_7479) --> 
    grums(_7491,_7477,_7479),
    !.

optional(grums,[optional,_7491,!],_7477,_7479) --> 
    grums(_7491,_7477,_7479),
    !.

optional([for],[optional,lit(for),!],_7479,_7481) --> 
    cc(for,_7479,_7481),
    !.

optional([:],[optional,lit(:),!],_7479,_7481) --> 
    cc(:,_7479,_7481),
    !.

optional([:],[optional,lit(:),!],_7479,_7481) --> 
    cc(:,_7479,_7481),
    !.

optional([ja],[optional,lit(ja),!],_7479,_7481) --> 
    cc(ja,_7479,_7481),
    !.

optional([men],[optional,lit(men),!],_7479,_7481) --> 
    cc(men,_7479,_7481),
    !.

optional(paadeg,[optional,_7491,!],_7477,_7479) --> 
    paadeg(_7491,_7477,_7479),
    !.

optional(hello,[optional,_7491,!],_7477,_7479) --> 
    hello(_7491,_7477,_7479),
    !.

optional(hello,[optional,_7491,!],_7477,_7479) --> 
    hello(_7491,_7477,_7479),
    !.

optional([ikke],[optional,lit(ikke),!],_7479,_7481) --> 
    cc(ikke,_7479,_7481),
    !.

optional(_7451,[],_7231,_7231) --> 
    [].

xnp(_7613,_7614,[xnp,_7656],_7639,_7641) --> 
    virtual(xnp(_7613,_7614),_7656,_7639,_7641).

negation(_7613,[negation,_7650],_7636,_7638) --> 
    virtual(negation(_7613),_7650,_7636,_7638).

aux1([aux1,_7643],_7632,_7634) --> 
    virtual(aux1,_7643,_7632,_7634).

adverbial1(_7613,_7614,_7615,[adverbial1,_7662],_7642,_7644) --> 
    virtual(adverbial1(_7613,_7614,_7615),_7662,_7642,_7644).

xadverbial1(_7613,_7614,_7615,[xadverbial1,_7662],_7642,_7644) --> 
    virtual(xadverbial1(_7613,_7614,_7615),_7662,_7642,_7644).

subordinate(in_order_to,_7614,_7615,[subordinate,_7662],_7642,_7644) --> 
    virtual(subordinate(in_order_to,_7614,_7615),_7662,_7642,_7644).

subordinate(_7613,_7614,_7615,[subordinate,_7662],_7642,_7644) --> 
    virtual(subordinate(_7613,_7614,_7615),_7662,_7642,_7644).

adj1(_7613,_7618:_7619,_7615,_7616,[adj1,_7671],_7648,_7650) --> 
    virtual(adj1(_7613,_7618:_7619,_7615,_7616),_7671,_7648,_7650).

someone([someone,_7643],_7632,_7634) --> 
    virtual(someone,_7643,_7632,_7634).

obviousdate1(_7613,_7614,[obviousdate1,_7656],_7639,_7641) --> 
    virtual(obviousdate1(_7613,_7614),_7656,_7639,_7641).

np_kernel(0,_7614,_7615,[np_kernel,_7662],_7642,_7644) --> 
    virtual(np_kernel(0,_7614,_7615),_7662,_7642,_7644).

xnp(_7613,_7616::_7617,[xnp,_7659],_7642,_7644) --> 
    virtual(xnp(_7613,_7616::_7617),_7659,_7642,_7644).

pp(_7613,_7614,_7615,[pp,_7662],_7642,_7644) --> 
    virtual(pp(_7613,_7614,_7615),_7662,_7642,_7644).

np(_7613,_7614,[np,_7656],_7639,_7641) --> 
    virtual(np(_7613,_7614),_7656,_7639,_7641).

prep(to,[prep,_7650],_7636,_7638) --> 
    virtual(prep(to),_7650,_7636,_7638).

prep(_7613,[prep,_7650],_7636,_7638) --> 
    virtual(prep(_7613),_7650,_7636,_7638).

noun_phrase1(_7613,_7614,[noun_phrase1,_7656],_7639,_7641) --> 
    virtual(noun_phrase1(_7613,_7614),_7656,_7639,_7641).

xadverb(_7613,_7614,[xadverb,_7656],_7639,_7641) --> 
    virtual(xadverb(_7613,_7614),_7656,_7639,_7641).

np(_7613,_7616::_7617,[np,_7659],_7642,_7644) --> 
    virtual(np(_7613,_7616::_7617),_7659,_7642,_7644).

be(_7613,[be,_7650],_7636,_7638) --> 
    virtual(be(_7613),_7650,_7636,_7638).

thereit([thereit,_7643],_7632,_7634) --> 
    virtual(thereit,_7643,_7632,_7634).

be([be,_7643],_7632,_7634) --> 
    virtual(be,_7643,_7632,_7634).

adverbial1(_7613,_7614,_7617::_7618,[adverbial1,_7665],_7645,_7647) --> 
    virtual(adverbial1(_7613,_7614,_7617::_7618),_7665,_7645,_7647).

lexv(_7613,_7614,_7615,fin,[lexv,_7668],_7645,_7647) --> 
    virtual(lexv(_7613,_7614,_7615,fin),_7668,_7645,_7647).

ap(_7613,_7614,_7615,_7616,[ap,_7668],_7645,_7647) --> 
    virtual(ap(_7613,_7614,_7615,_7616),_7668,_7645,_7647).

adj1(_7613,_7614,_7615,_7616,[adj1,_7668],_7645,_7647) --> 
    virtual(adj1(_7613,_7614,_7615,_7616),_7668,_7645,_7647).

\(state(_7616,_7617),(xnp(_7622,_7623),w(verb(be,_7631,fin)),w(adj2(_7636,nil))),[\,_7679],_7662,_7664) --> 
    virtual(state(_7616,_7617)\(xnp(_7622,_7623),w(verb(be,_7631,fin)),w(adj2(_7636,nil))),_7679,_7662,_7664).

something([something,_7643],_7632,_7634) --> 
    virtual(something,_7643,_7632,_7634).

lexv(iv,_7614,pres,fin,[lexv,_7668],_7645,_7647) --> 
    virtual(lexv(iv,_7614,pres,fin),_7668,_7645,_7647).

np1(_7613,_7614,[np1,_7656],_7639,_7641) --> 
    virtual(np1(_7613,_7614),_7656,_7639,_7641).

adverbial(_7613,_7614,_7617::_7618,[adverbial,_7665],_7645,_7647) --> 
    virtual(adverbial(_7613,_7614,_7617::_7618),_7665,_7645,_7647).

lexv(iv,_7614,_7615,fin,[lexv,_7668],_7645,_7647) --> 
    virtual(lexv(iv,_7614,_7615,fin),_7668,_7645,_7647).

the([the,_7643],_7632,_7634) --> 
    virtual(the,_7643,_7632,_7634).

nameq1(_7616:person,_7614,[nameq1,_7659],_7642,_7644) --> 
    virtual(nameq1(_7616:person,_7614),_7659,_7642,_7644).

obviousclock1(_7616:clock,_7616 isa clock,[obviousclock1,_7662],_7645,_7647) --> 
    virtual(obviousclock1(_7616:clock,_7616 isa clock),_7662,_7645,_7647).

whatbe([whatbe,_7643],_7632,_7634) --> 
    virtual(whatbe,_7643,_7632,_7634).

obviousclock1(_7613,_7614,[obviousclock1,_7656],_7639,_7641) --> 
    virtual(obviousclock1(_7613,_7614),_7656,_7639,_7641).

pronoun(_7613,[pronoun,_7650],_7636,_7638) --> 
    virtual(pronoun(_7613),_7650,_7636,_7638).

noun_phrase1(_7613,_7616::_7617,[noun_phrase1,_7659],_7642,_7644) --> 
    virtual(noun_phrase1(_7613,_7616::_7617),_7659,_7642,_7644).

npgap(_7613,[npgap,_7650],_7636,_7638) --> 
    virtual(npgap(_7613),_7650,_7636,_7638).

npgap(_7615:thing,[npgap,_7653],_7639,_7641) --> 
    virtual(npgap(_7615:thing),_7653,_7639,_7641).

noun(_7613,_7614,_7615,_7616,_7617,_7618,[noun,_7680],_7651,_7653) --> 
    virtual(noun(_7613,_7614,_7615,_7616,_7617,_7618),_7680,_7651,_7653).

lexv(tv,_7614,_7615,fin,[lexv,_7668],_7645,_7647) --> 
    virtual(lexv(tv,_7614,_7615,fin),_7668,_7645,_7647).

which([which,_7643],_7632,_7634) --> 
    virtual(which,_7643,_7632,_7634).

np1(_7613,_7616::_7617,[np1,_7659],_7642,_7644) --> 
    virtual(np1(_7613,_7616::_7617),_7659,_7642,_7644).

lexv(tv,know1,_7615,fin,[lexv,_7668],_7645,_7647) --> 
    virtual(lexv(tv,know1,_7615,fin),_7668,_7645,_7647).

doit([doit,_7643],_7632,_7634) --> 
    virtual(doit,_7643,_7632,_7634).

xadverbial1(_7613,_7614,_7617::_7618,[xadverbial1,_7665],_7645,_7647) --> 
    virtual(xadverbial1(_7613,_7614,_7617::_7618),_7665,_7645,_7647).

prep(in,[prep,_7650],_7636,_7638) --> 
    virtual(prep(in),_7650,_7636,_7638).

adverbial1(in,_7614,_7617::_7618,[adverbial1,_7665],_7645,_7647) --> 
    virtual(adverbial1(in,_7614,_7617::_7618),_7665,_7645,_7647).

xadverbial1(in,_7614,_7617::_7618,[xadverbial1,_7665],_7645,_7647) --> 
    virtual(xadverbial1(in,_7614,_7617::_7618),_7665,_7645,_7647).

adverbial1(nil,_7614,_7617::_7618,[adverbial1,_7665],_7645,_7647) --> 
    virtual(adverbial1(nil,_7614,_7617::_7618),_7665,_7645,_7647).

prep(from,[prep,_7650],_7636,_7638) --> 
    virtual(prep(from),_7650,_7636,_7638).

who([who,_7643],_7632,_7634) --> 
    virtual(who,_7643,_7632,_7634).

a([a,_7643],_7632,_7634) --> 
    virtual(a,_7643,_7632,_7634).

noun(_7613,_7614,u,n,_7617,_7618,[noun,_7680],_7651,_7653) --> 
    virtual(noun(_7613,_7614,u,n,_7617,_7618),_7680,_7651,_7653).

that([that,_7643],_7632,_7634) --> 
    virtual(that,_7643,_7632,_7634).

xadverbial1(how,nil,_7617::_7617,[xadverbial1,_7665],_7645,_7647) --> 
    virtual(xadverbial1(how,nil,_7617::_7617),_7665,_7645,_7647).

prep(with,[prep,_7650],_7636,_7638) --> 
    virtual(prep(with),_7650,_7636,_7638).

xadverbial1(nil,_7614,_7615,[xadverbial1,_7662],_7642,_7644) --> 
    virtual(xadverbial1(nil,_7614,_7615),_7662,_7642,_7644).

the(_7613,[the,_7650],_7636,_7638) --> 
    virtual(the(_7613),_7650,_7636,_7638).

of([of,_7643],_7632,_7634) --> 
    virtual(of,_7643,_7632,_7634).

prep1(in,[prep1,_7650],_7636,_7638) --> 
    virtual(prep1(in),_7650,_7636,_7638).

number(_7613,[number,_7650],_7636,_7638) --> 
    virtual(number(_7613),_7650,_7636,_7638).

lexv(dtv,_7614,_7615,_7616,[lexv,_7668],_7645,_7647) --> 
    virtual(lexv(dtv,_7614,_7615,_7616),_7668,_7645,_7647).

negation0(_7613,[negation0,_7650],_7636,_7638) --> 
    virtual(negation0(_7613),_7650,_7636,_7638).

adverbx(_7613,_7614,_7615,[adverbx,_7662],_7642,_7644) --> 
    virtual(adverbx(_7613,_7614,_7615),_7662,_7642,_7644).

particle(_7613,[particle,_7650],_7636,_7638) --> 
    virtual(particle(_7613),_7650,_7636,_7638).

verb_mod1(_7613,_7614,_7615,_7616,_7619::_7620,[verb_mod1,_7677],_7651,_7653) --> 
    virtual(verb_mod1(_7613,_7614,_7615,_7616,_7619::_7620),_7677,_7651,_7653).

lexv(tv,_7614,pres,fin,[lexv,_7668],_7645,_7647) --> 
    virtual(lexv(tv,_7614,pres,fin),_7668,_7645,_7647).

prep1(_7613,[prep1,_7650],_7636,_7638) --> 
    virtual(prep1(_7613),_7650,_7636,_7638).

noun_phrase1(_7613,_7616:_7617,[noun_phrase1,_7659],_7642,_7644) --> 
    virtual(noun_phrase1(_7613,_7616:_7617),_7659,_7642,_7644).

lexv(_7613,know1,_7615,fin,[lexv,_7668],_7645,_7647) --> 
    virtual(lexv(_7613,know1,_7615,fin),_7668,_7645,_7647).

lexv(tv,_7614,past,fin,[lexv,_7668],_7645,_7647) --> 
    virtual(lexv(tv,_7614,past,fin),_7668,_7645,_7647).

this([this,_7643],_7632,_7634) --> 
    virtual(this,_7643,_7632,_7634).

adverbial1(_7613,_7617:_7618,_7615,[adverbial1,_7665],_7645,_7647) --> 
    virtual(adverbial1(_7613,_7617:_7618,_7615),_7665,_7645,_7647).

adverbial1(nil,_7617:coevent,_7615,[adverbial1,_7665],_7645,_7647) --> 
    virtual(adverbial1(nil,_7617:coevent,_7615),_7665,_7645,_7647).

xadverbial1(_7613,_7617:_7618,_7615,[xadverbial1,_7665],_7645,_7647) --> 
    virtual(xadverbial1(_7613,_7617:_7618,_7615),_7665,_7645,_7647).

adverb(_7613,_7614,_7615,[adverb,_7662],_7642,_7644) --> 
    virtual(adverb(_7613,_7614,_7615),_7662,_7642,_7644).

some([some,_7643],_7632,_7634) --> 
    virtual(some,_7643,_7632,_7634).

much([much,_7643],_7632,_7634) --> 
    virtual(much,_7643,_7632,_7634).

little([little,_7643],_7632,_7634) --> 
    virtual(little,_7643,_7632,_7634).

every([every,_7643],_7632,_7634) --> 
    virtual(every,_7643,_7632,_7634).

relpron(agent,[relpron,_7650],_7636,_7638) --> 
    virtual(relpron(agent),_7650,_7636,_7638).

relpron(thing,[relpron,_7650],_7636,_7638) --> 
    virtual(relpron(thing),_7650,_7636,_7638).

time1(_7613,[time1,_7650],_7636,_7638) --> 
    virtual(time1(_7613),_7650,_7636,_7638).

and1([and1,_7643],_7632,_7634) --> 
    virtual(and1,_7643,_7632,_7634).

thispron([thispron,_7643],_7632,_7634) --> 
    virtual(thispron,_7643,_7632,_7634).

clock_kernel(_7616:clock,_7616 isa clock,[clock_kernel,_7662],_7645,_7647) --> 
    virtual(clock_kernel(_7616:clock,_7616 isa clock),_7662,_7645,_7647).

nameq1(_7613,_7614,[nameq1,_7656],_7639,_7641) --> 
    virtual(nameq1(_7613,_7614),_7656,_7639,_7641).

