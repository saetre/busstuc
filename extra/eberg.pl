testament1 :-

    departure(free(37),eberg,wednesday,B),
    departure(free(37),hovedterminalen,wednesday,C),
    connections(B,C,free(37),eberg,hovedterminalen,wednesday,[],D,E),
    output(xxxxxxxxx(D,E)).


testament2 :-
    departure(free(47),eberg,wednesday,B),
    departure(free(48),hovedterminalen,wednesday,C),
    connections(B,C,free(48),eberg,hovedterminalen,wednesday,[],D,E),
    output(yyyyyyyyyyyyyy(D,E)),
    diffdep777(D,hovedterminalen,F,eberg,hovedterminalen),
    takestime(F,eberg,hovedterminalen).

testament3 :-
    departure(free(47),eberg,wednesday,B),
    departure(free(48),hovedterminalen,wednesday,C),
    connections(B,C,free(48),eberg,hovedterminalen,wednesday,[],D,E),
    output(zzzzzzzzzzzzzz(D,E)).


diffdep777([_,A,B,_,C,D], _, E, _, _) :-
        unumber(A), !,
        difftime(C, A, E).
diffdep777(A, _, B, C, D) :-
        member([E,_,F,G,H], A),
        corr0(H, C),
        passes(G, I, J),
        corr0(I, D),
        H\==I,
        addtotime(F, J, K),
        K>=E,
        difftime(K, E, B), !.
diffdep777([], _, -1, _, _).

unumber(X):-number(X),output(uuuuuuuuuuuuuuu(X)).



