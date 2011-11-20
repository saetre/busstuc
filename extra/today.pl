%% FILE today.pl
%% SYSTEM BUSSTUC
%% CREATED TA-981207

% Q&D  way of getting the day from unix

tadoy(Day):-
    shell('date > rabindranath_tagore.e'),
    shell('cat dot.e >>  rabindranath_tagore.e'),
    see('rabindranath_tagore.e'),
    read_in(L),
    seen,
    L=[Day|_].

   
