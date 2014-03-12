%% FILE tucbus.pl 
%% SYSTEM TUC
%% CREATED TA-940620
%% REVISED JB-970114 TA-001119


:- ensure_loaded( user:'../declare' ). %% RS-111213 General (semantic) Operators

:-use_module( '../tucbuses', [ makegram/0 ] ). 


/* moved to tucbuses.pl  %% TA-000529

?-  dict_file(norsk,L),compile(L),         % dictionary for N
  morph_file(norsk,M),compile(M),        % morphology for N

  gram_file(norsk,G),compile(G),         % grammar for N
  makegram(norsk).

?-  dict_file(english,L),compile(L),       % dictionary for E 
  morph_file(english,M),compile(M),      % morphology for E 

  gram_file(english,G),compile(G),         % grammar for E 
  makegram(english).
*/


?- (unix_language := eng),  %% Standard for IDI/NTNU UNIX Solaris )
       
   (language := english),    %% Initial default user language  

   (duallangflag := true).  %% Also Try Norwegian if unknown words %% TA-001119

%%%%%%%%%%%%%%%%%%%%%%%%%%%

