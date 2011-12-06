%% FILE sicstus4compatibility.pl
%% SYSTEM TUC
%% CREATED TA-071026
%% REVISED TA-080506

%% Sicstus 4 compatibility
%% append/3  %% built in Sicstus 4 (library.pl)
%% member/2  %% built in Sicstus 4 (library.pl)   

:- module( sicstus4, [get/1, get0/1, put/1, ttyflush/0] ).
%% RS-111206    Exported through utility.pl (utility:). 111207 No!

get(G) :- get_code(F),
          F = 10 -> get(G) %% CR
          ;
          G=10.
get0(G) :-get_code(G). %% TA-070809

put(G) :- put_code(G). %%
ttyflush :- flush_output(user).
