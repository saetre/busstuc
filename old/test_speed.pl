main.

main :-
        tree(60).

tree(N) :-
        N < 1 ;
        (tab(N), write('/')).

