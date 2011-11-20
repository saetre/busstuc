%% FILE sicstus4compatibility.pl
%% SYSTEM TUC
%% CREATED TA-071026
%% REVISED TA-080506


%% Sicstus 4 compatibility
%% append/3  %% built in Sicstus 4 (library.pl)
%% member/2  %% built in Sicstus 4 (library.pl)   

get(G) :- get_code(F),
          F = 10 -> get(G) %% CR
          ;
          G=10.
get0(G) :-get_code(G). %% TA-070809

put(G) :- put_code(G). %%
ttyflush :- flush_output(user).
