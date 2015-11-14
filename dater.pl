%% FILE dater.pl
%% SYSTEM BUSTER
%% CREATED   TA-051007
%% REVISED   TA-060306

%% UNIX Version

%% Compiles all  the necessary files.
%% Same function as the file tucbus.


:- use_module( declare, [ (:=)/2, (=:)/2, set/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

%%?-prolog_flag(unknown,_,fail). %% (Don't?) crash on undefined predicates

%:-compile( 'tucbuster.pl' ).  
:- use_module( 'tucbuster.pl', [ ] ).   %% :-[tuctele]. %%% // Tele things %% TA-051018

?- (duallangflag := false).      %% speech based

?- (telebusterflag := false). %% Permanent

?- (daterflag := true).       %% Permanent %% TA-061130

?- (teleflag := true).       %% Volatile %% Ad Hoc 

?- (busflag := false).       

?- (windowsflag := false).
